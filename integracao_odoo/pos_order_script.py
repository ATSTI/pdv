# -*- coding: utf-8 -*-
"""Integracao PDV (Firebird) <-> Odoo."""
import configparser
import json
import os
import re
import unicodedata
from datetime import datetime, timedelta

from atscon import Conexao as con
from conecta_server import EnviaServer as envia
from integracao_log import get_logger
from main import Main as verifica_versao

_logger = get_logger(__name__)


def _normaliza_doc(valor):
    """Remove pontuacao de CPF/CNPJ. Retorna so digitos."""
    if not valor:
        return ""
    return re.sub(r"[^0-9]", "", str(valor))


def _doc_igual(doc_a, doc_b):
    """
    Compara CPF/CNPJ de forma tolerante.

    Regras:
    - Ambos vazios             -> iguais
    - Um vazio, outro com dado -> diferentes
    - Mesmo tamanho            -> compara exato
    - Tamanhos diferentes      -> compara o prefixo comum (o menor)
                                 (caso o Odoo tenha digitos a mais por erro
                                  de digitacao, tipo zero a esquerda)
    """
    a = _normaliza_doc(doc_a)
    b = _normaliza_doc(doc_b)

    if not a and not b:
        return True
    if not a or not b:
        return False
    if len(a) == len(b):
        return a == b
    # tamanhos diferentes: compara prefixo comum
    n = min(len(a), len(b))
    return a[:n] == b[:n]


class IntegracaoOdoo:

    def _inicia(self):
        verifica_versao()
        cfg = configparser.ConfigParser()
        if not cfg.read("conf.ini"):
            raise FileNotFoundError("conf.ini nao encontrado")
        self.path_envio   = cfg.get("INTEGRA", "path_envio")
        self.path_retorno = cfg.get("INTEGRA", "path_retorno")
        self.caixa_user   = cfg.get("INTEGRA", "caixa_user")
        self._garantir_fila()

    def _garantir_fila(self):
        """Cria INTEGRACAO_FILA compativel com Firebird 2.5."""
        with con() as db:
            # tabela
            if not db.query(
                "SELECT 1 FROM RDB$RELATIONS "
                "WHERE RDB$RELATION_NAME = 'INTEGRACAO_FILA'"
            ):
                r = db.ddl("""
                    CREATE TABLE INTEGRACAO_FILA (
                        ID           INTEGER NOT NULL PRIMARY KEY,
                        TIPO         VARCHAR(20),
                        ID_ORIGEM    INTEGER,
                        PAYLOAD      BLOB SUB_TYPE TEXT,
                        STATUS       VARCHAR(10) DEFAULT 'PENDENTE',
                        TENTATIVAS   INTEGER DEFAULT 0,
                        DT_CRIACAO   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        DT_ENVIO     TIMESTAMP,
                        ERRO         BLOB SUB_TYPE TEXT
                    )
                """)
                if r:
                    _logger.error("Falha criando INTEGRACAO_FILA: %s", r)
                    raise RuntimeError("Nao foi possivel criar INTEGRACAO_FILA")

            # sequence
            if not db.query(
                "SELECT 1 FROM RDB$GENERATORS "
                "WHERE RDB$GENERATOR_NAME = 'GEN_INTEGRACAO_FILA_ID'"
            ):
                db.ddl("CREATE SEQUENCE GEN_INTEGRACAO_FILA_ID")

            # trigger
            if not db.query(
                "SELECT 1 FROM RDB$TRIGGERS "
                "WHERE RDB$TRIGGER_NAME = 'TR_INTEGRACAO_FILA_BI'"
            ):
                db.ddl("""
                    CREATE TRIGGER TR_INTEGRACAO_FILA_BI FOR INTEGRACAO_FILA
                    ACTIVE BEFORE INSERT POSITION 0
                    AS
                    BEGIN
                        IF (NEW.ID IS NULL) THEN
                            NEW.ID = NEXT VALUE FOR GEN_INTEGRACAO_FILA_ID;
                    END
                """)

    def _validar_colunas_fila(self, db):
        """Garante que a tabela tem todas as colunas que o código usa."""
        esperadas = {
            "ID", "TIPO", "ID_ORIGEM", "PAYLOAD",
            "STATUS", "TENTATIVAS", "DT_CRIACAO", "DT_ENVIO", "ERRO",
        }
        r = db.query(
            "SELECT RDB$FIELD_NAME FROM RDB$RELATION_FIELDS "
            "WHERE RDB$RELATION_NAME = 'INTEGRACAO_FILA'"
        )
        existentes = {(linha[0] or "").strip().upper() for linha in r}
        faltando = esperadas - existentes
        if faltando:
            raise RuntimeError(
                "INTEGRACAO_FILA sem colunas esperadas: %s" % sorted(faltando)
            )

    def removerAcentosECaracteresEspeciais(self, palavra):
        if not palavra:
            return ""
        nfkd = unicodedata.normalize("NFKD", str(palavra))
        sem_acento = "".join(c for c in nfkd
                             if not unicodedata.combining(c))
        return re.sub(r"[^a-zA-Z0-9]", " ", sem_acento)

    def action_atualiza_produtos(self):
        self._inicia()
        envia("produto")

        arquivo_json = os.path.join(self.path_envio, "produtos.json")
        if not os.path.isfile(arquivo_json):
            _logger.warning("produtos.json nao encontrado")
            return False

        with open(arquivo_json, encoding="utf-8") as f:
            dados = json.load(f)

        try:
            prod_novo = json.loads(dados["result"])
        except (KeyError, TypeError, json.JSONDecodeError):
            _logger.error("produtos.json com formato inesperado")
            return False

        if not prod_novo:
            _logger.info("Sem produtos pra atualizar")
            return False

        incluido = alterado = 0
        with con() as db:
            for pr in prod_novo:
                try:
                    r = self._processar_produto(db, pr)
                    if r == "I":
                        incluido += 1
                    elif r == "U":
                        alterado += 1
                except Exception:
                    _logger.exception(
                        "Erro processando produto %s", pr.get("codproduto")
                    )
        _logger.info("Produtos: incluido=%s alterado=%s", incluido, alterado)
        return True

    def _processar_produto(self, db, pr):
        codproduto = pr["codproduto"]
        codpro     = (pr.get("codpro") or "").strip()
        produto    = self.removerAcentosECaracteresEspeciais(
            (pr.get("produto") or "").strip()
        )
        p_venda    = float(pr.get("valor_prazo") or 0)
        ncm        = re.sub(r"[^0-9]", "", pr.get("ncm") or "")
        if ncm and len(ncm) > 8:
            ncm = "00000000"
        codbarra   = (pr.get("cod_barra") or "").strip()
        if codbarra and len(codbarra) >= 14:
            codbarra = ""

        prods = db.query(
            "SELECT FIRST 1 CODPRODUTO, DATACADASTRO, VALOR_PRAZO, CODPRO "
            "FROM PRODUTOS WHERE CODPRODUTO = ?",
            (codproduto,),
        )

        data_nova = datetime.strptime(pr["datacadastro"], "%m/%d/%Y %H:%M:%S")
        data_fb = data_nova.strftime("%Y.%m.%d, %H:%M:%S.0000")

        if not prods and pr.get("usa") == "S":
            db.insert(
                "INSERT INTO PRODUTOS ("
                "  UNIDADEMEDIDA, PRODUTO, PRECOMEDIO, CODPRO, "
                "  TIPOPRECOVENDA, ORIGEM, NCM, VALORUNITARIOATUAL, "
                "  VALOR_PRAZO, TIPO, RATEIO, QTDEATACADO, PRECOATACADO, "
                "  DATACADASTRO, CODPRODUTO, COD_BARRA"
                ") VALUES (?, ?, ?, ?, 'F', ?, ?, ?, ?, 'PROD', ?, ?, ?, ?, ?, ?)",
                (
                    (pr.get("unidademedida") or "")[:2],
                    produto, 0.0, codpro,
                    str(pr.get("origem") or "0"),
                    ncm, 0.0, round(p_venda, 2),
                    str(pr.get("tipo_venda") or "1"),
                    str(pr.get("qtdeatacado") or "0.0"),
                    str(pr.get("precoatacado") or "0.0"),
                    data_fb, codproduto, codbarra or None,
                ),
            )
            _logger.info("Incluido: %s-%s", codpro, produto)
            return "I"

        if prods:
            data_cad = (prods[0][1].strftime("%Y/%m/%d %H:%M:%S")
                        if prods[0][1] else "2023/01/01 01:00:00")
            if (data_cad == data_nova.strftime("%Y/%m/%d %H:%M:%S")
                    and round(prods[0][2], 2) == round(p_venda, 2)):
                return None

            ativo = "S" if pr.get("usa") == "S" else "N"
            db.insert(
                "UPDATE PRODUTOS SET "
                "  PRODUTO = ?, VALOR_PRAZO = ?, NCM = ?, CODPRO = ?, "
                "  ORIGEM = ?, USA = ?, RATEIO = ?, "
                "  QTDEATACADO = ?, PRECOATACADO = ?, DATACADASTRO = ?, "
                "  COD_BARRA = ? "
                "WHERE CODPRODUTO = ?",
                (
                    produto, round(p_venda, 2), ncm, codpro,
                    str(pr.get("origem") or "0"), ativo,
                    str(pr.get("tipo_venda") or "1"),
                    str(pr.get("qtdeatacado") or "0.0"),
                    str(pr.get("precoatacado") or "0.0"),
                    data_fb, codbarra or None, codproduto,
                ),
            )
            _logger.info("Atualizado: %s-%s", codpro, produto)
            return "U"
        return None

    def action_atualiza_clientes(self):
        self._inicia()
        envia("cliente")

        arquivo_json = os.path.join(self.path_envio, "clientes.json")
        if not os.path.isfile(arquivo_json):
            return False

        with open(arquivo_json, encoding="utf-8") as f:
            dados = json.load(f)

        try:
            cli_novo = json.loads(dados["result"])
        except (KeyError, TypeError, json.JSONDecodeError):
            _logger.error("clientes.json com formato inesperado")
            return False

        if not cli_novo:
            _logger.info("Sem clientes pra atualizar")
            return False

        incluido = alterado = 0
        hj = datetime.now().strftime("%Y-%m-%d")

        with con() as db:
            for partner in cli_novo:
                try:
                    nome = self.removerAcentosECaracteresEspeciais(
                        partner["nomecliente"])
                    cod = partner["codcliente"]
                    cli = db.query(
                        "SELECT CODCLIENTE FROM CLIENTES WHERE CODCLIENTE = ?",
                        (cod,),
                    )
                    if cli:
                        db.insert(
                            "UPDATE CLIENTES SET STATUS = 1, "
                            "NOMECLIENTE = ?, DATACADASTRO = ?, REGIAO = ? "
                            "WHERE CODCLIENTE = ?",
                            (nome, hj, partner.get("regiao"), cod),
                        )
                        alterado += 1
                    else:
                        db.insert(
                            "INSERT INTO CLIENTES ("
                            " CODCLIENTE, NOMECLIENTE, RAZAOSOCIAL, TIPOFIRMA, "
                            " CNPJ, INSCESTADUAL, SEGMENTO, REGIAO, LIMITECREDITO, "
                            " DATACADASTRO, CODUSUARIO, STATUS, CODBANCO, CODFISCAL"
                            ") VALUES (?, ?, ?, ?, ?, 'Null', 1, ?, 0.0, "
                            "          CURRENT_DATE, ?, 1, 1, '9')",
                            (
                                cod, nome, nome,
                                partner.get("tipofirma"),
                                partner.get("cnpj"),
                                partner.get("regiao"),
                                partner.get("codusuario"),
                            ),
                        )
                        incluido += 1
                except Exception:
                    _logger.exception("Erro processando cliente %s",
                                      partner.get("codcliente"))

        _logger.info("Clientes: incluido=%s alterado=%s", incluido, alterado)
        return True

    def action_atualiza_vendas(self):
        self._inicia()
        with con() as db:
            self._enfileirar_vendas(db)
            self._drenar_fila(db)

    def _enfileirar_vendas(self, db):
        hj = (datetime.now() - timedelta(days=3)).strftime("%m-%d-%Y")
        caixas = db.query(
            "SELECT CODCAIXA FROM CAIXA_CONTROLE "
            "WHERE DATAABERTURA > ? AND CODUSUARIO = ? "
            "ORDER BY CODCAIXA",
            (hj, self.caixa_user),
        )
        enfileirados = 0
        for (codcaixa,) in caixas:
            vendas = db.query(
                "SELECT m.CODMOVIMENTO, m.CODCLIENTE, m.CODUSUARIO, "
                "       m.CODVENDEDOR, DATEADD(3 hour to m.DATA_SISTEMA) "
                "FROM MOVIMENTO m "
                "WHERE m.CODALMOXARIFADO = ? AND m.STATUS = 1 "
                "  AND m.CODNATUREZA = 3",
                (codcaixa,),
            )
            for v in vendas:
                codmov = v[0]
                ja = db.query(
                    "SELECT 1 FROM INTEGRACAO_FILA "
                    "WHERE TIPO = 'VENDA' AND ID_ORIGEM = ?",
                    (codmov,),
                )
                if ja:
                    continue
                payload = self._montar_payload_venda(db, codcaixa, v)
                if payload is None:
                    continue
                db.insert(
                    "INSERT INTO INTEGRACAO_FILA "
                    "(TIPO, ID_ORIGEM, PAYLOAD, STATUS) "
                    "VALUES ('VENDA', ?, ?, 'PENDENTE')",
                    (codmov, json.dumps(payload)),
                )
                enfileirados += 1
                print("  Enfileirando venda %s-%s" % (codcaixa, codmov))

        if enfileirados:
            print("Vendas novas enfileiradas: %s" % enfileirados)
        else:
            print("Vendas: nada novo.")

    def _montar_payload_venda(self, db, codcaixa, mov):
        codmov, cli, codusuario, codvendedor, dt_sistema = mov
        ord_name = "%s-%s" % (codcaixa, codmov)

        pag_ids = db.query(
            "SELECT f.CODFORMA, f.FORMA_PGTO, f.VALOR_PAGO, f.STATE, "
            "       f.TROCO, f.DESCONTO "
            "FROM FORMA_ENTRADA f WHERE f.ID_ENTRADA = ? AND f.STATE = 1",
            (codmov,),
        )
        md_ids = db.query(
            "SELECT md.CODDETALHE, md.CODPRODUTO, md.QUANTIDADE, md.PRECO, "
            "       COALESCE(md.VALOR_DESCONTO, 0), md.BAIXA, md.DESCPRODUTO, "
            "       md.CORTESIA, p.CODPRO "
            "FROM MOVIMENTODETALHE md, PRODUTOS p "
            "WHERE p.CODPRODUTO = md.CODPRODUTO "
            "  AND md.STATUS = 0 AND md.CodMovimento = ?",
            (codmov,),
        )
        if not md_ids:
            return None

        order_line = []
        for md in md_ids:
            try:
                prdname = self.removerAcentosECaracteresEspeciais(md[6])
            except Exception:
                prdname = md[6] or "Sem descricao"
            order_line.append((0, 0, {
                "product_id": md[1],
                "qty": md[2],
                "price_unit": md[3],
                "discount": md[4] or 0.0,
                "tipo_venda": (md[7] or "1").strip(),
                "name": prdname,
                "codpro": md[8],
            }))

        pag_line = []
        for pg in pag_ids:
            jrn = "%s-" % pg[1]
            if jrn == "5-":
                jrn = "1-"
            if jrn == "9-":
                continue
            pag_line.append((0, 0, {
                "date": str(dt_sistema),
                "amount": pg[2],
                "journal": jrn,
                "partner_id": cli,
                "name": ord_name,
            }))

        return {
            "name": ord_name,
            "pos_reference": ord_name,
            "session_id": codcaixa,
            "pos_session_id": codcaixa,
            "create_date": str(dt_sistema),
            "date_order": str(dt_sistema),
            "sequence_number": codmov,
            "partner_id": cli,
            "user_id": codvendedor if codvendedor > 1 else codusuario,
            "lines": order_line,
            "statement_ids": pag_line,
        }

    def _drenar_fila(self, db):
        pend = db.query(
            "SELECT FIRST 50 ID, ID_ORIGEM, PAYLOAD "
            "FROM INTEGRACAO_FILA "
            "WHERE STATUS = 'PENDENTE' AND TENTATIVAS < 5 ORDER BY ID"
        )
        if not pend:
            print("Fila de vendas: nada pendente.")
            return

        print("Fila de vendas: %s pendente(s)." % len(pend))

        for id_fila, id_origem, payload_blob in pend:
            try:
                payload = json.loads(payload_blob)
            except Exception:
                print("  [ERRO] fila ID=%s: payload invalido" % id_fila)
                _logger.exception("Payload invalido na fila ID=%s", id_fila)
                db.insert(
                    "UPDATE INTEGRACAO_FILA SET STATUS='ERRO', "
                    "ERRO = 'payload invalido' WHERE ID = ?",
                    (id_fila,),
                )
                continue

            ord_name = payload.get("pos_reference", "?")
            nome_arq = "pedido_%s.json" % ord_name
            caminho = os.path.join(self.path_envio, nome_arq)

            with open(caminho, "w", encoding="utf-8") as f:
                json.dump(payload, f, ensure_ascii=False)

            print("  Enviando venda %s (fila ID=%s)..." % (ord_name, id_fila))

            try:
                envia("pedido")
                db.insert(
                    "UPDATE INTEGRACAO_FILA SET STATUS='ENVIADO', "
                    "DT_ENVIO = CURRENT_TIMESTAMP WHERE ID = ?",
                    (id_fila,),
                )
                print("  [OK] venda %s enviada" % ord_name)
                try:
                    os.remove(caminho)
                except OSError:
                    pass
            except Exception as e:
                db.insert(
                    "UPDATE INTEGRACAO_FILA SET "
                    "TENTATIVAS = TENTATIVAS + 1, ERRO = ? WHERE ID = ?",
                    (str(e)[:2000], id_fila),
                )
                print("  [ERRO] venda %s: %s" % (ord_name, e))
                _logger.exception("Falha enviando fila ID=%s", id_fila)

    def action_atualiza_caixas(self):
        self._inicia()
        with con() as db:
            self._atualiza_caixas(db)
            self._atualiza_sangrias(db)
        envia("sangria")

    def _atualiza_caixas(self, db):
        hj = (datetime.now() - timedelta(days=5)).strftime("%Y-%m-%d")
        caixas = db.query(
            "SELECT FIRST 10 IDCAIXACONTROLE, CODCAIXA, CODUSUARIO, "
            "       SITUACAO, DATAFECHAMENTO, NOMECAIXA, DATAABERTURA "
            "FROM CAIXA_CONTROLE "
            "WHERE DATAABERTURA > ? AND CODUSUARIO = ? "
            "ORDER BY IDCAIXACONTROLE DESC",
            (hj, self.caixa_user),
        )
        enviados = 0
        for cx in caixas:
            _, codcaixa, codusuario, situacao, _, nomecaixa, data_abertura = cx
            nome = self.removerAcentosECaracteresEspeciais(nomecaixa or "")
            estado = "draft" if situacao == "o" else "closed"
            prefixo = "caixa_" if situacao == "o" else "caixaf_"
            arquivo = os.path.join(self.path_envio, "%s%s.json" % (prefixo, codcaixa))
            if os.path.exists(arquivo):
                continue
            vals = {
                "user_id": int(codusuario) if codusuario else None,
                "name": nome,
                "caixa": codcaixa,
                "start_at": "%s 20:00:00" % data_abertura,
                "state": estado,
            }
            tmp = arquivo + ".tmp"
            with open(tmp, "w", encoding="utf-8") as f:
                json.dump(vals, f, ensure_ascii=False)
            os.replace(tmp, arquivo)
            enviados += 1
        if enviados:
            _logger.info("Caixas: %s arquivo(s) gerado(s)", enviados)

    def _atualiza_sangrias(self, db):
        hj = (datetime.now() - timedelta(days=5)).strftime("%Y-%m-%d")
        sangrias = db.query(
            "SELECT f.CAIXA, f.CODFORMA, f.COD_VENDA, "
            "       f.VALOR_PAGO, f.N_DOC, c.DATAABERTURA "
            "FROM FORMA_ENTRADA f "
            "INNER JOIN CAIXA_CONTROLE c ON c.CODCAIXA = f.CAIXA "
            "WHERE c.DATAABERTURA > ? AND f.COD_VENDA = 1 "
            "  AND c.CODUSUARIO = ? "
            "ORDER BY f.CAIXA, f.CODFORMA, f.N_DOC",
            (hj, self.caixa_user),
        )
        if not sangrias:
            _logger.info("Sangria sem atualizacao.")
            return
        gerados = 0
        for sx in sangrias:
            cod_caixa, cod_forma, cod_venda, valor, n_doc, data_abertura = sx
            valor = float(valor or 0.0)
            if valor == 0.0:
                continue
            amount = -valor if int(cod_venda or 0) == 1 else valor
            chave = "%s-%s-%s" % (cod_caixa, cod_forma, n_doc or 0)
            motivo = self.removerAcentosECaracteresEspeciais(str(n_doc or ""))
            vals = {
                "date": str(data_abertura),
                "amount": amount,
                "ref": "Caixa-%s-%s" % (cod_caixa, cod_forma),
                "motivo": motivo,
                "tipo": "san",
                "name": str(cod_forma),
                "caixa": cod_caixa,
                "cod_venda": cod_venda,
                "user_id": int(self.caixa_user),
            }
            arquivo = os.path.join(self.path_envio, "sangria_%s.json" % chave)
            if os.path.exists(arquivo):
                continue
            tmp = arquivo + ".tmp"
            with open(tmp, "w", encoding="utf-8") as f:
                json.dump(vals, f, ensure_ascii=False)
            os.replace(tmp, arquivo)
            gerados += 1
            _logger.info("Sangria gerada: %s (valor=%s)", chave, amount)
        if not gerados:
            _logger.info("Sangria sem novidades.")

    def action_devolucao(self):
        self._inicia()
        with con() as db:
            hj = (datetime.now() - timedelta(days=20)).strftime("%m-%d-%Y")
            caixas = db.query(
                "SELECT CODCAIXA FROM CAIXA_CONTROLE "
                "WHERE DATAABERTURA > ? AND CODUSUARIO = ? "
                "ORDER BY CODCAIXA",
                (hj, self.caixa_user),
            )
            for (codcaixa,) in caixas:
                movs = db.query(
                    "SELECT c.codmovimento, movd.quantidade, movd.codproduto, "
                    "       mov.hist_mov, p.produto, mov.codusuario, p.codpro "
                    "FROM compra c "
                    "INNER JOIN movimentodetalhe movd "
                    "  ON c.codmovimento = movd.codmovimento "
                    "INNER JOIN produtos p ON movd.codproduto = p.codproduto "
                    "INNER JOIN movimento mov ON c.codmovimento = mov.codmovimento "
                    "WHERE c.caixa = ?",
                    (codcaixa,),
                )
                for mv in movs:
                    ord_name = "%s-%s" % (codcaixa, mv[0])
                    arquivo = os.path.join(self.path_envio,
                                           "devolucao_%s.json" % ord_name)
                    if os.path.exists(arquivo):
                        continue
                    vals = {
                        "tipo": "devolucao",
                        "name": "DEV-%s" % ord_name,
                        "origin": "DEV-%s" % ord_name,
                        "user_id": mv[5],
                        "motivo": mv[3],
                        "caixa": codcaixa,
                        "move_lines": [(0, 0, {
                            "product_code": mv[2],
                            "product_uom_qty": mv[1],
                            "product_uom_id": 1,
                            "product_uom": 1,
                            "qty_done": mv[1],
                            "name": mv[4],
                        })],
                    }
                    with open(arquivo, "w", encoding="utf-8") as f:
                        json.dump(vals, f, ensure_ascii=False)

        envia("devolucao")

    # ==================================================================
    # Validacao em massa — clientes
    # ==================================================================
    def validar_clientes(self, dry_run=False, min_pct=0.5):
        """
        Compara clientes Firebird x Odoo.

        Regras:
        - codcliente existe no Odoo:
            - Odoo active=False       -> inativa no Firebird (STATUS=0)
            - nome/cnpj divergem      -> atualiza no Firebird
            - tudo OK                 -> nada
        - codcliente NAO existe no Odoo:
            - inativa no Firebird (STATUS=0)

        Seguranca:
        - min_pct: fraçao minima (0..1) de clientes do Odoo em relacao ao
          total do Firebird. Se o Odoo devolver menos que isso, aborta
          para evitar catastrofe (ex: Odoo com problema devolvendo vazio).

        Args:
            dry_run: se True, apenas mostra o que faria, sem alterar nada.
            min_pct: 0.5 = exige 50% dos clientes do FB presentes no Odoo.
                     Use 0 para desligar a protecao (nao recomendado).
        """
        self._inicia()
        _logger.info("=== Validacao de CLIENTES iniciada (dry_run=%s) ===",
                     dry_run)

        # 1. busca lista do Odoo
        env = envia.__new__(envia)
        env._carregar_config()
        lista_odoo = env.buscando_clientes_validar()
        if lista_odoo is None:
            _logger.error("Nao foi possivel obter lista de clientes do Odoo")
            print("FALHA: nao foi possivel obter lista do Odoo.")
            return

        mapa_odoo = {int(c["codcliente"]): c for c in lista_odoo}
        _logger.info("Odoo retornou %s clientes", len(mapa_odoo))

        # 2. protecao: lista do Odoo tem que cobrir X% do Firebird
        with con() as db:
            total_fb = db.query("SELECT COUNT(*) FROM CLIENTES")[0][0]

        if total_fb > 0 and min_pct > 0:
            pct = len(mapa_odoo) / float(total_fb)
            if pct < min_pct:
                msg = ("ABORTADO: Odoo devolveu %s clientes, Firebird tem %s "
                       "(%.1f%% < %.0f%%). Verifique o Odoo antes de rodar."
                       % (len(mapa_odoo), total_fb, pct * 100, min_pct * 100))
                _logger.error(msg)
                print(msg)
                return
            _logger.info("Cobertura Odoo: %.1f%% (%s / %s)",
                         pct * 100, len(mapa_odoo), total_fb)

        inativados = 0
        atualizados = 0
        sem_match = 0
        ja_ok = 0

        with con() as db:
            clientes_fb = db.query(
                "SELECT CODCLIENTE, NOMECLIENTE, COALESCE(CNPJ, ''), "
                "       COALESCE(STATUS, 1) "
                "FROM CLIENTES"
            )

            for codcli, nome_fb, cnpj_fb, status_fb in clientes_fb:
                dados_odoo = mapa_odoo.get(int(codcli))

                # ---- caso 1: nao existe no Odoo -> inativa
                if not dados_odoo:
                    if int(status_fb) != 0:
                        if dry_run:
                            print("[DRY-RUN] inativaria cliente %s (%s) "
                                  "[nao existe no Odoo]"
                                  % (codcli, nome_fb))
                        else:
                            db.insert(
                                "UPDATE CLIENTES SET STATUS = 0 "
                                "WHERE CODCLIENTE = ?",
                                (codcli,),
                            )
                            _logger.info("Inativado cliente %s (%s) "
                                         "[nao existe no Odoo]",
                                         codcli, nome_fb)
                        inativados += 1
                    else:
                        ja_ok += 1
                    sem_match += 1
                    continue

                ativo_odoo = bool(dados_odoo.get("active"))
                nome_odoo  = self.removerAcentosECaracteresEspeciais(
                    dados_odoo.get("nomecliente") or "")
                cnpj_odoo  = _normaliza_doc(dados_odoo.get("cnpj") or "")
                cnpj_fb_n  = _normaliza_doc(cnpj_fb or "")

                # ---- caso 2: Odoo inativo -> inativa no FB
                if not ativo_odoo:
                    if int(status_fb) != 0:
                        if dry_run:
                            print("[DRY-RUN] inativaria cliente %s (%s) "
                                  "[Odoo inativo]" % (codcli, nome_fb))
                        else:
                            db.insert(
                                "UPDATE CLIENTES SET STATUS = 0 "
                                "WHERE CODCLIENTE = ?",
                                (codcli,),
                            )
                            _logger.info("Inativado cliente %s (%s) "
                                         "[Odoo inativo]", codcli, nome_fb)
                        inativados += 1
                    else:
                        ja_ok += 1
                    continue

                # ---- caso 3: divergencia de nome ou doc
                mudou = False
                if nome_odoo != (nome_fb or "").strip():
                    mudou = True
                if not _doc_igual(cnpj_odoo, cnpj_fb_n):
                    mudou = True

                if mudou:
                    if dry_run:
                        print("[DRY-RUN] atualizaria cliente %s: "
                              "nome=%r->%r doc=%r->%r"
                              % (codcli, nome_fb, nome_odoo,
                                 cnpj_fb_n, cnpj_odoo))
                    else:
                        db.insert(
                            "UPDATE CLIENTES SET "
                            "  NOMECLIENTE = ?, CNPJ = ?, STATUS = 1 "
                            "WHERE CODCLIENTE = ?",
                            (nome_odoo, cnpj_odoo, codcli),
                        )
                        _logger.info("Atualizado cliente %s: %s -> %s",
                                     codcli, nome_fb, nome_odoo)
                    atualizados += 1
                else:
                    ja_ok += 1

        resumo = ("Validacao CLIENTES (%s): inativados=%s atualizados=%s "
                  "ja_ok=%s sem_match_no_odoo=%s"
                  % ("DRY-RUN" if dry_run else "APLICADO",
                     inativados, atualizados, ja_ok, sem_match))
        _logger.info(resumo)
        print(resumo)

    # ==================================================================
    # Validacao em massa — produtos
    # ==================================================================
    def validar_produtos(self, dry_run=False, min_pct=0.5):
        """
        Compara produtos Firebird x Odoo.

        Regras:
        - codproduto existe no Odoo:
            - Odoo active=False       -> inativa (USA='N')
            - nome/codpro/cod_barra divergem -> atualiza
            - tudo OK                 -> nada
        - codproduto NAO existe no Odoo -> inativa (USA='N')

        Seguranca: ver validar_clientes().
        """
        self._inicia()
        _logger.info("=== Validacao de PRODUTOS iniciada (dry_run=%s) ===",
                     dry_run)

        env = envia.__new__(envia)
        env._carregar_config()
        lista_odoo = env.buscando_produtos_validar()
        if lista_odoo is None:
            _logger.error("Nao foi possivel obter lista de produtos do Odoo")
            print("FALHA: nao foi possivel obter lista do Odoo.")
            return

        mapa_odoo = {int(p["codproduto"]): p for p in lista_odoo}
        _logger.info("Odoo retornou %s produtos", len(mapa_odoo))

        with con() as db:
            total_fb = db.query("SELECT COUNT(*) FROM PRODUTOS")[0][0]

        if total_fb > 0 and min_pct > 0:
            pct = len(mapa_odoo) / float(total_fb)
            if pct < min_pct:
                msg = ("ABORTADO: Odoo devolveu %s produtos, Firebird tem %s "
                       "(%.1f%% < %.0f%%). Verifique o Odoo antes de rodar."
                       % (len(mapa_odoo), total_fb, pct * 100, min_pct * 100))
                _logger.error(msg)
                print(msg)
                return
            _logger.info("Cobertura Odoo: %.1f%% (%s / %s)",
                         pct * 100, len(mapa_odoo), total_fb)

        inativados = 0
        atualizados = 0
        sem_match = 0
        ja_ok = 0

        with con() as db:
            produtos_fb = db.query(
                "SELECT CODPRODUTO, PRODUTO, COALESCE(CODPRO, ''), "
                "       COALESCE(COD_BARRA, ''), COALESCE(USA, 'S') "
                "FROM PRODUTOS"
            )

            for codprd, produto_fb, codpro_fb, codbarra_fb, usa_fb in produtos_fb:
                dados_odoo = mapa_odoo.get(int(codprd))

                # ---- caso 1: nao existe no Odoo -> inativa
                if not dados_odoo:
                    if usa_fb != "N":
                        if dry_run:
                            print("[DRY-RUN] inativaria produto %s (%s) "
                                  "[nao existe no Odoo]"
                                  % (codprd, produto_fb))
                        else:
                            db.insert(
                                "UPDATE PRODUTOS SET USA = 'N' "
                                "WHERE CODPRODUTO = ?",
                                (codprd,),
                            )
                            _logger.info("Inativado produto %s (%s) "
                                         "[nao existe no Odoo]",
                                         codprd, produto_fb)
                        inativados += 1
                    else:
                        ja_ok += 1
                    sem_match += 1
                    continue

                ativo_odoo = bool(dados_odoo.get("active"))
                nome_odoo  = self.removerAcentosECaracteresEspeciais(
                    dados_odoo.get("produto") or "")
                codpro_odoo = (dados_odoo.get("codpro") or "").strip()
                codbarra_odoo = (dados_odoo.get("cod_barra") or "").strip()

                # ---- caso 2: Odoo inativo -> inativa
                if not ativo_odoo:
                    if usa_fb != "N":
                        if dry_run:
                            print("[DRY-RUN] inativaria produto %s (%s) "
                                  "[Odoo inativo]" % (codprd, produto_fb))
                        else:
                            db.insert(
                                "UPDATE PRODUTOS SET USA = 'N' "
                                "WHERE CODPRODUTO = ?",
                                (codprd,),
                            )
                            _logger.info("Inativado produto %s (%s) "
                                         "[Odoo inativo]", codprd, produto_fb)
                        inativados += 1
                    else:
                        ja_ok += 1
                    continue

                # ---- caso 3: divergencias
                mudou = False
                if nome_odoo != (produto_fb or "").strip():
                    mudou = True
                if codpro_odoo and codpro_odoo != (codpro_fb or "").strip():
                    mudou = True
                if codbarra_odoo and \
                        codbarra_odoo != (codbarra_fb or "").strip():
                    mudou = True

                if mudou:
                    if dry_run:
                        print("[DRY-RUN] atualizaria produto %s: "
                              "nome=%r->%r codpro=%r->%r codbarra=%r->%r"
                              % (codprd, produto_fb, nome_odoo,
                                 codpro_fb, codpro_odoo,
                                 codbarra_fb, codbarra_odoo))
                    else:
                        db.insert(
                            "UPDATE PRODUTOS SET "
                            "  PRODUTO = ?, CODPRO = ?, COD_BARRA = ?, "
                            "  USA = 'S' "
                            "WHERE CODPRODUTO = ?",
                            (nome_odoo, codpro_odoo,
                             codbarra_odoo or None, codprd),
                        )
                        _logger.info("Atualizado produto %s: %s -> %s",
                                     codprd, produto_fb, nome_odoo)
                    atualizados += 1
                else:
                    ja_ok += 1

        resumo = ("Validacao PRODUTOS (%s): inativados=%s atualizados=%s "
                  "ja_ok=%s sem_match_no_odoo=%s"
                  % ("DRY-RUN" if dry_run else "APLICADO",
                     inativados, atualizados, ja_ok, sem_match))
        _logger.info(resumo)
        print(resumo)

# executa = IntegracaoOdoo()
