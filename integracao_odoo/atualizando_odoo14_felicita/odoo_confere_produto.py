# -*- coding: utf-8 -*-

import odoorpc
import re
import configparser
import fdb
import sys
from datetime import datetime
import csv

# ------------------------------------------------------------------
# CONFIG
# ------------------------------------------------------------------
cfg = configparser.ConfigParser()
cfg.read('conf.ini')

psw          = cfg.get('DATABASE', 'password')
host         = cfg.get('DATABASE', 'HostName')
name         = cfg.get('DATABASE', 'user')
url_odoo     = cfg.get('INTEGRA', 'url')
database_odoo= cfg.get('INTEGRA', 'db')
user_odoo    = cfg.get('INTEGRA', 'login')
pass_odoo    = cfg.get('INTEGRA', 'password')
port_odoo    = cfg.get('INTEGRA', 'port')

# ------------------------------------------------------------------
# CONEXAO FIREBIRD
# ------------------------------------------------------------------
connection = fdb.connect(
    dsn=host,
    user='sysdba',
    password=psw,
    charset='utf-8'
)
db = connection.cursor()

# ------------------------------------------------------------------
# CONEXAO ODOO
# ------------------------------------------------------------------
dest = odoorpc.ODOO(url_odoo, port=port_odoo)
dest.login(database_odoo, user_odoo, pass_odoo)

b_prod = dest.env['product.product']

# ------------------------------------------------------------------
# HELPERS DE UNICIDADE
# ------------------------------------------------------------------
def fb_codpro_em_outro(cursor, codpro, codproduto_excluir=None):
    """Retorna o CODPRODUTO que ja usa esse codpro, ou None."""
    sql = "select first 1 CODPRODUTO from PRODUTOS where CODPRO = ?"
    params = [codpro]
    if codproduto_excluir is not None:
        sql += " and CODPRODUTO <> ?"
        params.append(codproduto_excluir)
    cur = cursor.execute(sql, params)
    row = cur.fetchone()
    return row[0] if row else None


def fb_barcode_em_outro(cursor, barcode, codproduto_excluir=None):
    """Retorna o CODPRODUTO que ja usa esse barcode, ou None."""
    if not barcode:
        return None
    sql = "select first 1 CODPRODUTO from PRODUTOS where COD_BARRA = ?"
    params = [barcode]
    if codproduto_excluir is not None:
        sql += " and CODPRODUTO <> ?"
        params.append(codproduto_excluir)
    cur = cursor.execute(sql, params)
    row = cur.fetchone()
    return row[0] if row else None


def gera_codpro_unico(cursor, codpro_base, codproduto_excluir=None):
    """
    Retorna um CODPRO livre (<=15 chars).
    Tenta 'base', depois 'base-1', 'base-2', ...
    """
    codpro_base = (codpro_base or '').strip()
    if not codpro_base:
        return codpro_base

    if fb_codpro_em_outro(cursor, codpro_base, codproduto_excluir) is None:
        return codpro_base

    n = 1
    while n <= 999:
        sufixo = "-%d" % n
        limite = 15 - len(sufixo)
        candidato = codpro_base[:limite] + sufixo
        if fb_codpro_em_outro(cursor, candidato, codproduto_excluir) is None:
            return candidato
        n += 1

    raise Exception("Nao foi possivel gerar CODPRO unico para '%s'" % codpro_base)

CODPRO_MAX = 15

def normaliza_codpro(valor):
    """Trunca para 15 chars e remove espacos nas pontas."""
    if valor is None:
        return ''
    return str(valor).strip()[:CODPRO_MAX]


def codpro_ja_e_variacao(fb_codpro, odoo_codpro_base, min_base=8):
    """
    Retorna True se fb_codpro e uma variacao valida do default_code do Odoo.

    Reconhece os esquemas:
      (1) Firebird: base[:15-len('-N')] + '-N'  (N = 1..999)
      (2) Firebird com sufixo -N: base contido no default_code do Odoo
          (com ou sem prefixo '20' / '10')
      (3) Odoo truncado: '20'+base ou '10'+base contido no default_code

    min_base: comprimento minimo do 'base' para evitar falso positivo
              quando o base e curto demais.
    """
    if not fb_codpro:
        return False

    base_odoo = normaliza_codpro(odoo_codpro_base)   # <= 15
    odoo_raw  = (odoo_codpro_base or '').strip()

    # (0) exato
    if fb_codpro == base_odoo or fb_codpro == odoo_raw:
        return True

    # (1) esquema Firebird: base[:15-len(sufixo)] + sufixo
    if '-' in fb_codpro:
        for n in range(1, 1000):
            sufixo = '-%d' % n
            limite = 15 - len(sufixo)
            if base_odoo[:limite] + sufixo == fb_codpro:
                return True

    # (2) e (3): comparar 'base' do Firebird com o default_code do Odoo
    fb_base = fb_codpro
    if '-' in fb_codpro:
        fb_base = fb_codpro.rsplit('-', 1)[0]

    if len(fb_base) < min_base:
        return False

    # normaliza o default_code do Odoo removendo prefixos '20' / '10'
    candidatos_odoo = {odoo_raw, base_odoo}
    for pref in ('20', '10'):
        if odoo_raw.startswith(pref):
            candidatos_odoo.add(odoo_raw[len(pref):])
        if base_odoo.startswith(pref):
            candidatos_odoo.add(base_odoo[len(pref):])

    # (2) fb_base esta contido no default_code do Odoo?
    for cand in candidatos_odoo:
        if cand and fb_base in cand:
            return True

    # (3) '20'+fb_base ou '10'+fb_base esta contido no default_code?
    for pref in ('20', '10'):
        if (pref + fb_base) in odoo_raw:
            return True

    return False


def sql_quote(valor):
    """Escapa aspas simples para SQL literal."""
    if valor is None:
        return 'Null'
    return "'" + str(valor).replace("'", "''") + "'"


MAPA_UNIDADE = {
    'UNIDADE': 'UN', 'UN': 'UN',
    'PEÇA':    'PC', 'PECA': 'PC', 'PC': 'PC',
    'QUILOGRAMA': 'KG', 'KG': 'KG',
    'LITRO':   'LT', 'LT': 'LT',
    'CAIXA':   'CX', 'CX': 'CX',
    'PACOTE':  'PT', 'PT': 'PT',
    'METRO':   'MT', 'MT': 'MT',
    'FARDO':   'FD', 'FD': 'FD',
}

def normaliza_unidade(valor):
    if not valor:
        return ''
    s = str(valor).strip().upper()
    if s in MAPA_UNIDADE:
        return MAPA_UNIDADE[s]
    return s[:2]


def normaliza_produto(valor, limite=300):
    """PRODUTO e VARCHAR(300): garante <= 300 chars."""
    if valor is None:
        return ''
    return str(valor).strip()[:limite]


def normaliza_valor(valor):
    """VALOR_PRAZO e DOUBLE PRECISION: devolve float valido (0.0 se vazio/invalido)."""
    if valor is None or valor == '' or valor is False:
        return 0.0
    try:
        return float(valor)
    except (TypeError, ValueError):
        return 0.0


def verifica_orfaos_firebird(bd_cursor, b_prod, id_inicio, id_fim):
    """
    Multiempresa (Odoo):
      - Produto existe no Odoo por id e company_id em (1, 3):
            -> INATIVA no Firebird (USA='N', COD_BARRA=Null)
      - Produto existe no Odoo por id com company_id = False ou outra empresa:
            -> MANTEM ATIVO
      - Produto NAO existe no Odoo por id, mas o CODPRO do Firebird existe
        como default_code no Odoo (puro, com prefixo '20' ou '10'):
            -> MANTEM ATIVO (ja existe no Odoo com outro id)
      - Produto NAO existe no Odoo por id NEM por default_code:
            -> MANTEM ATIVO e exporta no CSV para INSERT no Odoo
    CSV: id;default_code;barcode;name;uom_id;list_price (uom_id=1 fixo)
    """
    print(f"\n--- Verificando orfaos no Firebird (faixa {id_inicio} a {id_fim}) ---")

    # ------------------------------------------------------------------
    # 1. Busca no Odoo (product.template) com company_id e default_code
    # ------------------------------------------------------------------
    b_tmpl = b_prod.env['product.template']

    try:
        templates = b_tmpl.search_read(
            [('id', '>=', int(id_inicio)), ('id', '<=', int(id_fim))],
            ['id', 'company_id', 'default_code']
        )
        odoo_company = {}
        for t in templates:
            cid = t.get('company_id')
            if cid:
                cid = cid[0] if isinstance(cid, (list, tuple)) else cid
            odoo_company[t['id']] = cid
    except Exception as e:
        print(f"Erro ao buscar produtos no Odoo: {e}")
        return

    total_odoo = len(odoo_company)
    qtd_emp_1_3 = sum(1 for cid in odoo_company.values() if cid in (1, 3))
    qtd_compart = sum(1 for cid in odoo_company.values() if cid is False or cid is None)
    qtd_outras = total_odoo - qtd_emp_1_3 - qtd_compart

    print(f"Total de templates no Odoo nessa faixa: {total_odoo}")
    print(f"  -> empresa 1/3 : {qtd_emp_1_3}  (serao INATIVADOS no Firebird)")
    print(f"  -> compartilhados (company_id=False): {qtd_compart}  (mantidos)")
    print(f"  -> outras empresas: {qtd_outras}  (mantidos)")

    # ------------------------------------------------------------------
    # 2. Busca no Firebird (somente ativos)
    # ------------------------------------------------------------------
    sqld = (f"select CODPRODUTO, CODPRO, PRODUTO, USA, COD_BARRA, "
            f"UNIDADEMEDIDA, VALOR_PRAZO "
            f"from PRODUTOS where CODPRODUTO >= {id_inicio} "
            f"and CODPRODUTO <= {id_fim} "
            f"and (USA is null or USA <> 'N')")

    try:
        bd_cursor.execute(sqld)
        fb_prod = bd_cursor.fetchall()
    except Exception as e:
        print(f"Erro ao buscar produtos no Firebird: {e}")
        return

    # ------------------------------------------------------------------
    # 3. Separa em grupos
    # ------------------------------------------------------------------
    para_inativar = []
    candidatos_csv = []

    for fb in fb_prod:
        fb_id = fb[0]
        if fb_id in odoo_company:
            cid = odoo_company[fb_id]
            if cid in (1, 3):
                para_inativar.append(fb)
        else:
            candidatos_csv.append(fb)

    # ------------------------------------------------------------------
    # 4. Entre os candidatos, verifica se o CODPRO existe como default_code
    #    no Odoo (puro, '20'+ ou '10'+). Se existir, NAO vai para CSV.
    # ------------------------------------------------------------------
    para_csv = []
    odoo_default_codes_extra = set()

    if candidatos_csv:
        codpros_busca = set()
        for fb in candidatos_csv:
            fb_codpro = (fb[1] or '').strip()
            if fb_codpro:
                codpros_busca.add(fb_codpro)
                codpros_busca.add('20' + fb_codpro)
                codpros_busca.add('10' + fb_codpro)

        if codpros_busca:
            try:
                achados = b_tmpl.search_read(
                    [('default_code', 'in', list(codpros_busca))],
                    ['default_code']
                )
                odoo_default_codes_extra = set(
                    (t.get('default_code') or '').strip()
                    for t in achados
                )
            except Exception as e:
                print(f"Erro ao buscar default_code no Odoo: {e}")
                odoo_default_codes_extra = set()

        for fb in candidatos_csv:
            fb_codpro = (fb[1] or '').strip()
            variantes = {
                fb_codpro,
                '20' + fb_codpro,
                '10' + fb_codpro,
            }
            if variantes & odoo_default_codes_extra:
                continue
            para_csv.append(fb)

    # ------------------------------------------------------------------
    # 5. Inativa os da empresa 1/3
    # ------------------------------------------------------------------
    total_inativados = 0
    total_erros = 0

    if para_inativar:
        print(f"\n--- Produtos no Firebird e no Odoo (empresas 1/3) -> INATIVANDO ---")
        print("-" * 80)
        print(f"{'CODPRODUTO':<12} | {'CODPRO':<15} | {'COD_BARRA':<14} | {'PRODUTO':<30}")
        print("-" * 80)

        for fb in para_inativar:
            c_id    = fb[0]
            c_pro   = (fb[1] or '').strip()
            c_nome  = fb[2] if fb[2] else ''
            c_barra = (fb[4] or '').strip() if len(fb) > 4 else ''

            print(f"{c_id:<12} | {c_pro:<15} | {(c_barra[:14] if c_barra else '-'):<14} | {c_nome[:30]:<30}")
            try:
                upd = ("UPDATE PRODUTOS set USA = 'N', COD_BARRA = Null "
                       "WHERE CODPRODUTO = %s;" % str(c_id))
                bd_cursor.execute(upd)
                bd_cursor.connection.commit()
                total_inativados += 1
                print(f"   -> INATIVADO CODPRODUTO {c_id}")
            except Exception as e:
                total_erros += 1
                print(f"   -> ERRO ao inativar CODPRODUTO {c_id}: {e}")

    # ------------------------------------------------------------------
    # 6. CSV com os que NAO existem no Odoo (nem por id, nem por default_code)
    # ------------------------------------------------------------------
    csv_linhas = []
    for fb in para_csv:
        c_id    = fb[0]
        c_pro   = (fb[1] or '').strip()
        c_nome  = fb[2] if fb[2] else ''
        c_barra = (fb[4] or '').strip() if len(fb) > 4 else ''
        c_valor = fb[6] if len(fb) > 6 and fb[6] is not None else 0.0

        csv_linhas.append([
            c_id,
            c_pro,
            c_barra,
            c_nome,
            1,                          # uom_id fixo
            f"{c_valor:.2f}",           # list_price com ponto (Odoo)
        ])

    if para_csv:
        print(f"\n--- Produtos no Firebird e AUSENTES no Odoo -> CSV (INSERT) ---")
        print(f"Total: {len(para_csv)}")

    # ------------------------------------------------------------------
    # 7. Resumo
    # ------------------------------------------------------------------
    print("-" * 80)
    print(f"Resumo: {len(fb_prod)} ativos no Firebird | "
          f"{total_inativados} inativados (empresa 1/3) | "
          f"{len(para_csv)} para CSV (ausentes no Odoo) | "
          f"{total_erros} erros")

    # ------------------------------------------------------------------
    # 8. Gera CSV (formato Odoo)
    # ------------------------------------------------------------------
    if csv_linhas:
        nome_csv = "orfaos_%s_%s_%s.csv" % (
            id_inicio, id_fim, datetime.now().strftime('%Y%m%d_%H%M%S')
        )
        try:
            with open(nome_csv, 'w', newline='', encoding='utf-8-sig') as f:
                w = csv.writer(f, delimiter=';')
                w.writerow(['id', 'default_code', 'barcode', 'name', 'uom_id', 'list_price'])
                for linha in csv_linhas:
                    w.writerow(linha)
            print(f"\nCSV gerado: {nome_csv} ({len(csv_linhas)} linha(s))")
        except Exception as e:
            print(f"\nErro ao gerar CSV '{nome_csv}': {e}")
    else:
        print("\nNenhum produto para exportar no CSV.")


# ------------------------------------------------------------------
# PARAMETROS
# ------------------------------------------------------------------
x = sys.argv[1]
y = sys.argv[2]
print("fazendo id : %s - %s" % (x, y))

p = b_prod.search([('id', '>', x), ('id', '<', y)], order='id')
browse_p = b_prod.browse(p)

contar = 0
contar_correcao = 0
codprodutos_ja_tratados = set()

# limpa codigo de barra de produtos inativos antes de comecar
sqld = ("UPDATE PRODUTOS set COD_BARRA = Null "
        "WHERE USA = 'N' and COD_BARRA is not null "
        "and (CODPRODUTO < %s or CODPRODUTO > %s);" % (x, y))
db.execute(sqld)
connection.commit()
print(' limpando codigo de barra produtos inativos (fora da faixa %s-%s)' % (x, y))

# ------------------------------------------------------------------
# LOOP PRINCIPAL
# ------------------------------------------------------------------
for pr in browse_p:
    code = normaliza_codpro(pr.default_code)
    sqld = ("select CODPRODUTO, CODPRO, PRODUTO, COD_BARRA, USA "
            "from PRODUTOS where (CODPRODUTO = " + str(pr.id) +
            ") OR (CODPRO = " + sql_quote(code) + ") order by usa desc")

    try:
        db.execute(sqld)
        fb_prod = db.fetchall()
    except Exception as e:
        print('ERRO SELECT (id %s): %s (%s)' % (str(pr.id), sqld, e))
        continue

    achou = False

    for fb in fb_prod:
        fb_codproduto = fb[0]

        # se ja foi corrigido nesta execucao, nao mexe de novo
        if fb_codproduto in codprodutos_ja_tratados:
            achou = True
            continue

        achou = True
        fb_codpro     = fb[1] or ''
        fb_barcode    = fb[3] or ''
        fb_usa        = fb[4]

        # ---------------- PRODUTO INATIVO NO ODOO ----------------
        if not pr.active:
            if fb_barcode or fb_usa != 'N':
                corrigir = ("UPDATE PRODUTOS set COD_BARRA = Null, USA = 'N' "
                            "WHERE CODPRODUTO = %s;" % str(fb_codproduto))
                try:
                    db.execute(corrigir)
                    connection.commit()
                    print('INATIVADO (odoo inativo id %s): %s - %s'
                          % (str(pr.id), fb_codpro, pr.default_code))
                except Exception as e:
                    print('ERRO INATIVAR : %s (%s)' % (corrigir, e))
            continue

        # ---------------- PRODUTO ATIVO: comparar ----------------
        odoo_codpro  = normaliza_codpro(pr.default_code)
        odoo_barcode = pr.barcode or ''

        # codpro_diferente so e True se o fb_codpro NAO for o odoo_codpro
        # E NAO for uma variacao valida ja gerada por este script
        codpro_diferente = (
            fb_codpro != odoo_codpro
            and not codpro_ja_e_variacao(fb_codpro, pr.default_code)
        )

        divergencias = []

        if fb_codproduto != pr.id:
            if fb_codproduto == pr.id * 10:
                divergencias.append('CODPRODUTO')
            elif codpro_diferente:
                divergencias.append('CODPRODUTO')
            # else: codproduto de outro produto legado dono do codpro -> ignora

        if codpro_diferente:
            divergencias.append('CODPRO')

        # COD_BARRA
        outro_id_conflito = None
        if fb_barcode != odoo_barcode:
            if odoo_barcode:
                conflito = fb_barcode_em_outro(db, odoo_barcode, fb_codproduto)
                if conflito is None:
                    divergencias.append('COD_BARRA')
                else:
                    # barcode correto ja esta em outro produto -> tira de la e poe aqui
                    # (o barcode antigo deste produto e descartado)
                    divergencias.append('COD_BARRA')
                    outro_id_conflito = conflito
            else:
                divergencias.append('COD_BARRA')

        # se inativo no Firebird, nao tenta gravar COD_BARRA
        if fb_usa == 'N' and 'COD_BARRA' in divergencias:
            divergencias.remove('COD_BARRA')
            outro_id_conflito = None

        if not divergencias:
            continue

        print('DIVERGENCIA (id %s) campos=%s | FB: id=%s codpro=%s barcode=%s | ODOO: id=%s codpro=%s barcode=%s'
            % (str(pr.id), ','.join(divergencias),
                str(fb_codproduto), fb_codpro, fb_barcode,
                str(pr.id), odoo_codpro, odoo_barcode))

        produto_fb = normaliza_produto(pr.name).replace("'", "''")
        unidade_fb = normaliza_unidade(pr.uom_id.name)
        vp         = normaliza_valor(pr.list_price)

        sets = [
            "PRODUTO = '" + produto_fb + "'",
            "UNIDADEMEDIDA = '" + unidade_fb + "'",
            "VALOR_PRAZO = " + str(vp),
        ]

        # --- CODPRO ---
        if 'CODPRO' in divergencias:
            novo_codpro = odoo_codpro
            if novo_codpro:
                conflito = fb_codpro_em_outro(db, novo_codpro, fb_codproduto)
                if conflito is not None:
                    novo_codpro = gera_codpro_unico(db, novo_codpro, fb_codproduto)
                    print('  -> CODPRO "%s" ja usado por %s; usando "%s"'
                          % (odoo_codpro, str(conflito), novo_codpro))
                sets.append("CODPRO = " + sql_quote(novo_codpro))
            else:
                sets.append("CODPRO = Null")

        # --- COD_BARRA ---
        if 'COD_BARRA' in divergencias:
            if odoo_barcode:
                # se o barcode correto esta em outro produto, limpa o outro primeiro
                if outro_id_conflito is not None:
                    try:
                        upd_outro = ("UPDATE PRODUTOS set COD_BARRA = Null "
                                     "WHERE CODPRODUTO = %s;" % str(outro_id_conflito))
                        db.execute(upd_outro)
                        connection.commit()
                        print('  -> COD_BARRA "%s" removido do CODPRODUTO %s'
                              % (odoo_barcode, str(outro_id_conflito)))
                    except Exception as e:
                        print('  ERRO ao remover COD_BARRA do CODPRODUTO %s: %s'
                              % (str(outro_id_conflito), e))
                sets.append("COD_BARRA = " + sql_quote(odoo_barcode))
            else:
                sets.append("COD_BARRA = Null")

        # --- CODPRODUTO ---
        if 'CODPRODUTO' in divergencias:
            if fb_codproduto == pr.id * 10:
                sets.append("CODPRODUTO = %s" % str(pr.id))
            else:
                print('  -> CODPRODUTO divergente mas nao seguro trocar: fb=%s odoo=%s'
                      % (str(fb_codproduto), str(pr.id)))

        if sets:
            corrigir = ("UPDATE PRODUTOS set " + ", ".join(sets) +
                        " WHERE CODPRODUTO = %s;" % str(fb_codproduto))
            try:
                db.execute(corrigir)
                connection.commit()
                contar_correcao += 1
                codprodutos_ja_tratados.add(fb_codproduto)
                print('  UPDATE OK : %s' % corrigir)
            except Exception as e:
                print('  ERRO UPDATE : %s (%s)' % (corrigir, e))

    # ---------------- NAO EXISTE: INSERT ----------------
    if not achou:
        contar += 1

        ncm = ''
        if pr.ncm_id:
            ncm = pr.ncm_id.code.replace('.', '')

        un      = normaliza_unidade(pr.uom_id.name)
        produto = pr.name

        # --- CODPRO: garante unicidade ---
        codpro = normaliza_codpro(pr.default_code)
        if codpro:
            conflito = fb_codpro_em_outro(db, codpro, pr.id)
            if conflito is not None:
                novo = gera_codpro_unico(db, codpro, pr.id)
                print('  INSERT -> CODPRO "%s" ja usado por %s; usando "%s"'
                      % (pr.default_code, str(conflito), novo))
                codpro = novo

        # --- COD_BARRA: se ja existir em outro, NULL ---
        barcode = pr.barcode
        if barcode:
            conflito = fb_barcode_em_outro(db, barcode, pr.id)
            if conflito is not None:
                print('  INSERT -> COD_BARRA "%s" ja usado por %s; gravando NULL'
                      % (barcode, str(conflito)))
                barcode = None

        vp      = str(pr.list_price)
        data_fb = datetime.strftime(pr.write_date, '%Y.%m.%d, %H:%M:%S.0000')

        insere = ("INSERT INTO PRODUTOS (CODPRODUTO, UNIDADEMEDIDA, PRODUTO, CODPRO,"
                  "TIPOPRECOVENDA, ORIGEM, TIPO, VALORUNITARIOATUAL, VALOR_PRAZO, DATACADASTRO")
        if ncm:      insere += ',NCM'
        if barcode:  insere += ', COD_BARRA'
        insere += ") VALUES (" + str(pr.id)
        insere += "," + sql_quote(un)
        insere += "," + sql_quote(produto)
        insere += "," + sql_quote(codpro)
        insere += ",'F', 0,'PROD'"
        insere += "," + vp + "," + vp
        insere += "," + sql_quote(data_fb)
        if ncm:      insere += "," + sql_quote(ncm)
        if barcode:  insere += "," + sql_quote(barcode)
        insere += ")"

        try:
            db.execute(insere)
            connection.commit()
            print(' INSERINDO : %s-%s' % (str(pr.id), codpro))
        except Exception as e:
            print(' ERRO INSERT : %s (%s)' % (insere, e))

print('INSERIDO/CORRIGIDO: %s NOVOS ITENS, %s CORRIGIDOS'
      % (str(contar), str(contar_correcao)))

# --- CHAMA A VERIFICACAO DE ORFAOS ---
verifica_orfaos_firebird(db, b_prod, x, y)

# Fecha a conexao e sai
try:
    db.close()
except Exception:
    pass
try:
    connection.close()
except Exception:
    pass

sys.exit(0)