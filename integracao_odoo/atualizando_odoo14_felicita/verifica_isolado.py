# -*- coding: utf-8 -*-
"""
Executa SOMENTE a verificacao de orfaos, sem o loop principal
de INSERT/UPDATE do odoo_confere_produto.py.
Uso:
    python verifica_isolado.py 1 500
"""

import sys
import configparser
import fdb
import odoorpc
from datetime import datetime

# ------------------------------------------------------------------
# CONFIG
# ------------------------------------------------------------------
cfg = configparser.ConfigParser()
cfg.read('conf.ini')

psw           = cfg.get('DATABASE', 'password')
host          = cfg.get('DATABASE', 'HostName')
url_odoo      = cfg.get('INTEGRA', 'url')
database_odoo = cfg.get('INTEGRA', 'db')
user_odoo     = cfg.get('INTEGRA', 'login')
pass_odoo     = cfg.get('INTEGRA', 'password')
port_odoo     = cfg.get('INTEGRA', 'port')

# ------------------------------------------------------------------
# CONEXOES
# ------------------------------------------------------------------
connection = fdb.connect(
    dsn=host,
    user='sysdba',
    password=psw,
    charset='utf-8'
)
db = connection.cursor()

dest = odoorpc.ODOO(url_odoo, port=port_odoo)
dest.login(database_odoo, user_odoo, pass_odoo)
b_prod = dest.env['product.product']

# ------------------------------------------------------------------
# HELPERS (copiados do odoo_confere_produto.py)
# ------------------------------------------------------------------
CODPRO_MAX = 15

def normaliza_codpro(valor):
    if valor is None:
        return ''
    return str(valor).strip()[:CODPRO_MAX]


def codpro_ja_e_variacao(fb_codpro, odoo_codpro_base):
    if not fb_codpro:
        return False
    base = normaliza_codpro(odoo_codpro_base)
    if fb_codpro == base:
        return True
    if '-' not in fb_codpro:
        return False
    for n in range(1, 1000):
        sufixo = '-%d' % n
        limite = 15 - len(sufixo)
        if base[:limite] + sufixo == fb_codpro:
            return True
    return False


# ------------------------------------------------------------------
# FUNCAO DE VERIFICACAO (copie a versao atual do arquivo principal)
# ------------------------------------------------------------------
def verifica_orfaos_firebird(bd_cursor, b_prod, id_inicio, id_fim):
    """
    Multiempresa (Odoo):
      - Produto existe no Odoo e o template tem company_id em (1, 3):
            -> INATIVA no Firebird (USA='N', COD_BARRA=Null)
      - Produto existe no Odoo com company_id = False (compartilhado) ou outra empresa:
            -> MANTEM ATIVO no Firebird (nao faz nada)
      - Produto NAO existe no Odoo:
            -> MANTEM ATIVO e exporta no CSV para INSERT no Odoo
    CSV: id;default_code;barcode;name;uom_id;list_price (uom_id=1 fixo)
    """
    print(f"\n--- Verificando orfaos no Firebird (faixa {id_inicio} a {id_fim}) ---")

    # ------------------------------------------------------------------
    # 1. Busca no Odoo (product.template) com company_id
    #    IDs de product.template == IDs de product.product (sem variantes)
    # ------------------------------------------------------------------
    b_tmpl = b_prod.env['product.template']

    try:
        templates = b_tmpl.search_read(
            [('id', '>=', int(id_inicio)), ('id', '<=', int(id_fim))],
            ['id', 'company_id']
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
    # 3. Separa em 3 grupos
    # ------------------------------------------------------------------
    para_inativar = []   # existe no Odoo, company 1/3
    para_csv = []        # NAO existe no Odoo -> vai para CSV

    for fb in fb_prod:
        fb_id = fb[0]
        if fb_id in odoo_company:
            cid = odoo_company[fb_id]
            if cid in (1, 3):
                para_inativar.append(fb)
            # False / outra empresa -> mantem ativo, nao faz nada
        else:
            para_csv.append(fb)

    # ------------------------------------------------------------------
    # 4. Inativa os da empresa 1/3
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
    # 5. CSV com os que NAO existem no Odoo
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
    # 6. Resumo
    # ------------------------------------------------------------------
    print("-" * 80)
    print(f"Resumo: {len(fb_prod)} ativos no Firebird | "
          f"{total_inativados} inativados (empresa 1/3) | "
          f"{len(para_csv)} para CSV (ausentes no Odoo) | "
          f"{total_erros} erros")

    # ------------------------------------------------------------------
    # 7. Gera CSV (formato Odoo)
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
# MAIN
# ------------------------------------------------------------------
if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Uso: python verifica_isolado.py <id_inicio> <id_fim>")
        sys.exit(1)

    x = sys.argv[1]
    y = sys.argv[2]
    print("Verificando orfaos (SOMENTE a verificacao) : %s - %s" % (x, y))

    verifica_orfaos_firebird(db, b_prod, x, y)

    try:
        db.close()
    except Exception:
        pass
    try:
        connection.close()
    except Exception:
        pass

    sys.exit(0)