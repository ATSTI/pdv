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

# ==================== HELPERS DE MODULO ====================

def _normaliza_doc(valor):
    """Remove pontuacao de CPF/CNPJ. Retorna so digitos."""
    if not valor:
        return ""
    return re.sub(r"[^0-9]", "", str(valor))


def _doc_igual(doc_a, doc_b):
    """
    Compara CPF/CNPJ de forma tolerante.
    ...
    """
    a = _normaliza_doc(doc_a)
    b = _normaliza_doc(doc_b)

    if not a and not b:
        return True
    if not a or not b:
        return False
    if len(a) == len(b):
        return a == b
    n = min(len(a), len(b))
    return a[:n] == b[:n]


def _blob_para_texto(valor):
    """Normaliza BLOB SUB_TYPE TEXT que pode voltar como bytes ou str."""
    if valor is None:
        return ""
    if isinstance(valor, bytes):
        try:
            return valor.decode("utf-8")
        except UnicodeDecodeError:
            return valor.decode("latin-1", errors="replace")
    return str(valor)


def _formata_cnpj(valor):
    """Formata CNPJ como 00.000.000/0000-00 a partir de so digitos."""
    d = _normaliza_doc(valor)
    if len(d) != 14:
        return ""
    return "%s.%s.%s/%s-%s" % (
        d[0:2], d[2:5], d[5:8], d[8:12], d[12:14],
    )


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

    def _corta(self, valor, tamanho):
        """Trunca string para caber num VARCHAR(tamanho) do Firebird 2.5."""
        if valor is None:
            return None
        s = str(valor)
        return s[:tamanho] if len(s) > tamanho else s

    def _to_int(self, valor, default=None):
        """Converte para int. Retorna default se vazio/invalido."""
        if valor is None or valor == "":
            return default
        try:
            return int(float(str(valor).strip()))
        except (ValueError, TypeError):
            return default

    def _to_float(self, valor, default=0.0):
        """Converte para float. Retorna default se vazio/invalido."""
        if valor is None or valor == "":
            return default
        try:
            return float(str(valor).strip().replace(",", "."))
        except (ValueError, TypeError):
            return default

    # ==================================================================
    # ESTRUTURA DA FILA (COMPATIVEL COM FIREBIRD 2.5)
    # ==================================================================
    def _garantir_fila(self):
        """
        Cria INTEGRACAO_FILA compativel com Firebird 2.5.

        No FB 2.5 nao existe CREATE SEQUENCE (isso e do FB 3+).
        Usamos CREATE GENERATOR + GEN_ID(...) no trigger.
        """
        with con() as db:
            # ---------- TABELA ----------
            if not db.query(
                "SELECT 1 FROM RDB$RELATIONS "
                "WHERE RDB$RELATION_NAME = 'INTEGRACAO_FILA' "
                "  AND RDB$VIEW_BLR IS NULL"
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

            # ---------- GENERATOR (FB 2.5) ----------
            if not db.query(
                "SELECT 1 FROM RDB$GENERATORS "
                "WHERE RDB$GENERATOR_NAME = 'GEN_INTEGRACAO_FILA_ID'"
            ):
                r = db.ddl("CREATE GENERATOR GEN_INTEGRACAO_FILA_ID")
                if r:
                    _logger.error("Falha criando GENERATOR: %s", r)
                    raise RuntimeError("Nao foi possivel criar GEN_INTEGRACAO_FILA_ID")

            # ---------- TRIGGER (GEN_ID no FB 2.5) ----------
            if not db.query(
                "SELECT 1 FROM RDB$TRIGGERS "
                "WHERE RDB$TRIGGER_NAME = 'TR_INTEGRACAO_FILA_BI' "
                "  AND RDB$TRIGGER_INACTIVE = 0"
            ):
                r = db.ddl("""
                    CREATE TRIGGER TR_INTEGRACAO_FILA_BI FOR INTEGRACAO_FILA
                    ACTIVE BEFORE INSERT POSITION 0
                    AS
                    BEGIN
                        IF (NEW.ID IS NULL OR NEW.ID = 0) THEN
                            NEW.ID = GEN_ID(GEN_INTEGRACAO_FILA_ID, 1);
                    END
                """)
                if r:
                    _logger.error("Falha criando TRIGGER: %s", r)
                    raise RuntimeError("Nao foi possivel criar TR_INTEGRACAO_FILA_BI")

            # valida colunas depois de tudo pronto
            self._validar_colunas_fila(db)

    def _validar_colunas_fila(self, db):
        """Garante que a tabela tem todas as colunas que o codigo usa."""
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

    # ==================================================================
    # PRODUTOS
    # ==================================================================
    def action_atualiza_produtos(self):
        self._inicia()
        with envia("produto"):
            pass

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

    def _resolver_codpro_duplicado(self, db, codpro, codproduto):
        """
        Se ja existe OUTRO produto com o mesmo codpro, devolve um codpro
        novo no formato '<codpro>/<n>' que nao colida.

        IMPORTANTE: so deve ser chamado quando o produto VAI ser gravado.
        """
        if not codpro:
            return codpro

        outros = db.query(
            "SELECT CODPRO FROM PRODUTOS WHERE CODPRO = ? AND CODPRODUTO <> ?",
            (codpro, codproduto),
        )
        if not outros:
            return codpro

        usados = {codpro}
        candidatos = db.query(
            "SELECT CODPRO FROM PRODUTOS WHERE CODPRO STARTING WITH ?",
            (codpro + "/",),
        )
        for (cp,) in candidatos:
            usados.add((cp or "").strip())

        n = 1
        novo = "%s/%s" % (codpro, n)
        while novo in usados:
            n += 1
            novo = "%s/%s" % (codpro, n)

        _logger.info(
            "Produto %s: codpro %r ja existe em %s outro(s) produto(s); "
            "renomeando para %r",
            codproduto, codpro, len(outros), novo,
        )
        return novo

    def _processar_produto(self, db, pr):
        codproduto = self._to_int(pr.get("codproduto"))
        if codproduto is None:
            _logger.warning("Produto sem codproduto, ignorado: %r", pr)
            return None

        # CODPRO VARCHAR(15)
        codpro = self._corta((pr.get("codpro") or "").strip(), 15)

        # PRODUTO VARCHAR(300) NOT NULL
        produto = self.removerAcentosECaracteresEspeciais(
            (pr.get("produto") or "").strip())
        produto = self._corta(produto, 300) or "SEM DESCRICAO"

        # numericos
        p_venda = self._to_float(pr.get("valor_prazo"), 0.0)

        # NCM VARCHAR(8)
        ncm = re.sub(r"[^0-9]", "", pr.get("ncm") or "")
        if len(ncm) > 8:
            ncm = "00000000"
        ncm = self._corta(ncm, 8) or None

        # COD_BARRA VARCHAR(20)
        codbarra = self._corta((pr.get("cod_barra") or "").strip(), 20)
        if codbarra and len(codbarra) >= 14:
            codbarra = ""

        # UNIDADEMEDIDA CHAR(2)
        unidade = self._corta((pr.get("unidademedida") or "").strip(), 2)
        if not unidade:
            unidade = "UN"

        # ORIGEM INTEGER (era str!)
        origem = self._to_int(pr.get("origem"), 0)

        # RATEIO CHAR(1) — era str(tipo_venda)
        rateio = self._corta(str(pr.get("tipo_venda") or "1"), 1) or "1"

        # QTDEATACADO / PRECOATACADO DOUBLE PRECISION (eram str!)
        qtde_atac = self._to_float(pr.get("qtdeatacado"), 0.0)
        preco_atac = self._to_float(pr.get("precoatacado"), 0.0)

        prods = db.query(
            "SELECT FIRST 1 CODPRODUTO, DATACADASTRO, VALOR_PRAZO, CODPRO "
            "FROM PRODUTOS WHERE CODPRODUTO = ?",
            (codproduto,),
        )

        data_nova = datetime.strptime(pr["datacadastro"], "%m/%d/%Y %H:%M:%S")
        data_fb = data_nova.strftime("%Y.%m.%d, %H:%M:%S.0000")

        # ----------------------------------------------------------
        # CASO 1: produto novo -> INSERT
        # ----------------------------------------------------------
        if not prods and pr.get("usa") == "S":
            codpro = self._resolver_codpro_duplicado(db, codpro, codproduto)
            codpro = self._corta(codpro, 15)

            r = db.insert(
                "INSERT INTO PRODUTOS ("
                "  UNIDADEMEDIDA, PRODUTO, PRECOMEDIO, CODPRO, "
                "  TIPOPRECOVENDA, ORIGEM, NCM, VALORUNITARIOATUAL, "
                "  VALOR_PRAZO, TIPO, RATEIO, QTDEATACADO, PRECOATACADO, "
                "  DATACADASTRO, CODPRODUTO, COD_BARRA"
                ") VALUES (?, ?, ?, ?, 'F', ?, ?, ?, ?, 'PROD', ?, ?, ?, ?, ?, ?)",
                (
                    unidade,          # CHAR(2)
                    produto,          # VARCHAR(300)
                    0.0,              # PRECOMEDIO
                    codpro,           # VARCHAR(15)
                    origem,           # INTEGER
                    ncm,              # VARCHAR(8)
                    0.0,              # VALORUNITARIOATUAL
                    round(p_venda, 2),# DOUBLE
                    rateio,           # CHAR(1)
                    qtde_atac,        # DOUBLE
                    preco_atac,       # DOUBLE
                    data_fb,          # TIMESTAMP (string FB)
                    codproduto,       # INTEGER
                    codbarra or None, # VARCHAR(20)
                ),
            )
            if r:
                _logger.error("Falha INSERT produto %s: %s", codproduto, r)
                return None
            _logger.info("Incluido: %s-%s", codpro, produto[:60])
            return "I"

        # ----------------------------------------------------------
        # CASO 2: ja existe -> talvez UPDATE
        # ----------------------------------------------------------
        if prods:
            dt_fb = prods[0][1]
            if dt_fb is not None:
                dt_fb = dt_fb.replace(microsecond=0)
            dt_nova = data_nova.replace(microsecond=0)

            preco_fb = round(prods[0][2], 2) if prods[0][2] is not None else 0.0
            preco_odoo = round(p_venda, 2)

            if dt_fb == dt_nova and preco_fb == preco_odoo:
                _logger.debug("Produto %s ja atualizado", codproduto)
                return None

            codpro = self._resolver_codpro_duplicado(db, codpro, codproduto)
            codpro = self._corta(codpro, 15)

            ativo = "S" if pr.get("usa") == "S" else "N"
            r = db.insert(
                "UPDATE PRODUTOS SET "
                "  PRODUTO = ?, VALOR_PRAZO = ?, NCM = ?, CODPRO = ?, "
                "  ORIGEM = ?, USA = ?, RATEIO = ?, "
                "  QTDEATACADO = ?, PRECOATACADO = ?, DATACADASTRO = ?, "
                "  COD_BARRA = ? "
                "WHERE CODPRODUTO = ?",
                (
                    produto,
                    round(p_venda, 2),
                    ncm,
                    codpro,
                    origem,           # INTEGER
                    ativo,
                    rateio,           # CHAR(1)
                    qtde_atac,        # DOUBLE
                    preco_atac,       # DOUBLE
                    data_fb,          # TIMESTAMP
                    codbarra or None,
                    codproduto,
                ),
            )
            if r:
                _logger.error("Falha UPDATE produto %s: %s", codproduto, r)
                return None
            _logger.info("Atualizado: %s-%s", codpro, produto[:60])
            return "U"

        return None

    # ==================================================================
    # CLIENTES
    # ==================================================================

    def action_atualiza_clientes(self):
        self._inicia()
        with envia("cliente"):
            pass

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
        falhas = 0
        hj = datetime.now().date()          # DATE nativo, nao string

        with con() as db:
            for partner in cli_novo:
                try:
                    cod = self._to_int(partner.get("codcliente"))
                    if cod is None:
                        _logger.warning("Cliente sem codcliente, ignorado: %r",
                                        partner.get("nomecliente"))
                        falhas += 1
                        continue

                    # ---- NOMECLIENTE / RAZAOSOCIAL: VARCHAR(60) ----
                    nome = self.removerAcentosECaracteresEspeciais(
                        partner.get("nomecliente") or "")
                    nome = self._corta(nome, 60)

                    # ---- CNPJ: VARCHAR(18), com mascara 00.000.000/0000-00 ----
                    cnpj = _formata_cnpj(partner.get("cnpj") or "")
                    cnpj = self._corta(cnpj, 18) or None

                    # ---- TIPOFIRMA SMALLINT NOT NULL ----
                    tipo = self._to_int(partner.get("tipofirma"), 1)

                    # ---- REGIAO SMALLINT NOT NULL ----
                    regiao = self._to_int(partner.get("regiao"), 1)

                    # ---- CODUSUARIO INTEGER NOT NULL ----
                    codusu = self._to_int(partner.get("codusuario"), 1)

                    status = self._to_int(partner.get("status"), 1)

                    cli = db.query(
                        "SELECT CODCLIENTE FROM CLIENTES WHERE CODCLIENTE = ?",
                        (cod,),
                    )

                    if cli:
                        # ------------------ UPDATE ------------------
                        r = db.insert(
                            "UPDATE CLIENTES SET STATUS = ?, "
                            "NOMECLIENTE = ?, DATACADASTRO = ?, REGIAO = ?, "
                            "CNPJ = ?, TIPOFIRMA = ? "
                            "WHERE CODCLIENTE = ?",
                            (status, nome, hj, regiao, cnpj, tipo, cod),
                        )
                        if r:
                            _logger.error("Falha UPDATE cliente %s: %s", cod, r)
                            falhas += 1
                        else:
                            alterado += 1
                    else:
                        # ------------------ INSERT ------------------
                        r = db.insert(
                            "INSERT INTO CLIENTES ("
                            " CODCLIENTE, NOMECLIENTE, RAZAOSOCIAL, TIPOFIRMA, "
                            " CNPJ, INSCESTADUAL, SEGMENTO, REGIAO, LIMITECREDITO, "
                            " DATACADASTRO, CODUSUARIO, STATUS, CODBANCO, CODFISCAL"
                            ") VALUES (?, ?, ?, ?, ?, 'Null', 1, ?, 0.0, "
                            "          ?, ?, ?, 1, '9')",
                            (
                                cod,       # CODCLIENTE
                                nome,      # NOMECLIENTE
                                nome,      # RAZAOSOCIAL
                                tipo,      # TIPOFIRMA (int)
                                cnpj,      # CNPJ (com mascara)
                                regiao,    # REGIAO (int)
                                hj,        # DATACADASTRO (date)
                                codusu,    # CODUSUARIO (int)
                                status,    # STATUS (int)
                            ),
                        )
                        if r:
                            _logger.error("Falha INSERT cliente %s: %s", cod, r)
                            falhas += 1
                        else:
                            incluido += 1
                except Exception:
                    _logger.exception("Erro processando cliente %s",
                                    partner.get("codcliente"))
                    falhas += 1

        _logger.info("Clientes: incluido=%s alterado=%s falhas=%s",
                    incluido, alterado, falhas)
        return True

    # ==================================================================
    # VENDAS
    # ==================================================================
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
                ", c.NOMECLIENTE "
                "FROM MOVIMENTO m, CLIENTES c "
                "WHERE m.CODALMOXARIFADO = ? AND m.STATUS = 1 "
                "  AND m.CODNATUREZA = 3 AND m.CODCLIENTE = c.CODCLIENTE",
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
                # BLOB TEXT: enviar sempre como bytes para evitar mojibake
                # em clientes Firebird 2.5 com charset ambiguo.
                payload_bytes = json.dumps(payload).encode("utf-8")
                db.insert(
                    "INSERT INTO INTEGRACAO_FILA "
                    "(TIPO, ID_ORIGEM, PAYLOAD, STATUS) "
                    "VALUES ('VENDA', ?, ?, 'PENDENTE')",
                    (codmov, payload_bytes),
                )
                enfileirados += 1
                _logger.info("  Enfileirando venda %s-%s", codcaixa, codmov)

        if enfileirados:
            _logger.info("Vendas novas enfileiradas: %s", enfileirados)
        else:
            _logger.info("Vendas: nada novo.")

    def _montar_payload_venda(self, db, codcaixa, mov):
        codmov, cli, codusuario, codvendedor, dt_sistema, nomecliente = mov
        try:
            nomecliente = self.removerAcentosECaracteresEspeciais(nomecliente)
        except Exception:
            nomecliente = nomecliente or "Consumidor"
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
        vlr_total = 0.0
        vlr_totprod = 0.0        
        for md in md_ids:
            try:
                prdname = self.removerAcentosECaracteresEspeciais(md[6])
            except Exception:
                prdname = md[6] or "Sem descricao"
            vlr_total += (md[2]*md[3])-md[4]
            vlr_totprod = (md[2]*md[3])-md[4]                
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
            "nomecliente": nomecliente,
            "session_id": codcaixa,
            "pos_session_id": codcaixa,
            "create_date": str(dt_sistema),
            "date_order": str(dt_sistema),
            "sequence_number": codmov,
            "partner_id": cli,
            "user_id": codvendedor if codvendedor > 1 else codusuario,
            "lines": order_line,
            "statement_ids": pag_line,
            "amount_return": vlr_total,
        }

    def _drenar_fila(self, db):
        pend = db.query(
            "SELECT FIRST 50 ID, ID_ORIGEM, PAYLOAD "
            "FROM INTEGRACAO_FILA "
            "WHERE STATUS = 'PENDENTE' AND TENTATIVAS < 5 ORDER BY ID"
        )
        if not pend:
            _logger.info("Fila de vendas: nada pendente.")
            return

        _logger.info("Fila de vendas: %s pendente(s).", len(pend))

        for id_fila, id_origem, payload_blob in pend:
            # BLOB TEXT pode voltar como bytes em FB 2.5
            try:
                payload_txt = _blob_para_texto(payload_blob)
                payload = json.loads(payload_txt)
            except Exception:
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

            # IMPORTANTE: try envolve TAMBEM o write do arquivo,
            # para que falhas de disco/permissao nao matem o loop inteiro.
            try:
                with open(caminho, "w", encoding="utf-8") as f:
                    json.dump(payload, f, ensure_ascii=False)

                _logger.info("  Enviando venda %s (fila ID=%s)...",
                             ord_name, id_fila)

                with envia("pedido"):
                    pass

                db.insert(
                    "UPDATE INTEGRACAO_FILA SET STATUS='ENVIADO', "
                    "DT_ENVIO = CURRENT_TIMESTAMP WHERE ID = ?",
                    (id_fila,),
                )
                _logger.info("  [OK] venda %s enviada", ord_name)
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
                _logger.error("  [ERRO] venda %s: %s", ord_name, e)
                _logger.exception("Falha enviando fila ID=%s", id_fila)

    # ==================================================================
    # CAIXAS
    # ==================================================================
    def action_atualiza_caixas(self):
        self._inicia()
        with con() as db:
            self._atualiza_caixas(db)
            self._atualiza_sangrias(db)
        with envia("sangria"):
            pass

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

    # ==================================================================
    # DEVOLUCAO
    # ==================================================================
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

        with envia("devolucao"):
            pass

    # ==================================================================
    # VALIDACAO EM MASSA — CLIENTES
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
        - min_pct: fracao minima (0..1) de clientes do Odoo em relacao ao
          total do Firebird. Se o Odoo devolver menos que isso, aborta.
        """
        self._inicia()
        _logger.info("=== Validacao de CLIENTES iniciada (dry_run=%s) ===",
                     dry_run)

        with envia(None) as env:
            lista_odoo = env.buscando_clientes_validar()

        if lista_odoo is None:
            _logger.error("Nao foi possivel obter lista de clientes do Odoo")
            _logger.info("FALHA: nao foi possivel obter lista do Odoo.")
            return

        mapa_odoo = {int(c["codcliente"]): c for c in lista_odoo}
        _logger.info("Odoo retornou %s clientes", len(mapa_odoo))

        inativados = 0
        atualizados = 0
        sem_match = 0
        ja_ok = 0

        # Uma unica conexao para count + loop principal.
        with con() as db:
            total_fb = db.query("SELECT COUNT(*) FROM CLIENTES")[0][0]

            if total_fb > 0 and min_pct > 0:
                pct = len(mapa_odoo) / float(total_fb)
                if pct < min_pct:
                    msg = ("ABORTADO: Odoo devolveu %s clientes, Firebird tem "
                           "%s (%.1f%% < %.0f%%). Verifique o Odoo antes de "
                           "rodar."
                           % (len(mapa_odoo), total_fb, pct * 100,
                              min_pct * 100))
                    _logger.error(msg)
                    return
                _logger.info("Cobertura Odoo: %.1f%% (%s / %s)",
                             pct * 100, len(mapa_odoo), total_fb)

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
                            _logger.info("[DRY-RUN] inativaria cliente %s (%s) "
                                         "[nao existe no Odoo]",
                                         codcli, nome_fb)
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
                            _logger.info("[DRY-RUN] inativaria cliente %s (%s) "
                                         "[Odoo inativo]", codcli, nome_fb)
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
                        _logger.info("[DRY-RUN] atualizaria cliente %s: "
                                     "nome=%r->%r doc=%r->%r",
                                     codcli, nome_fb, nome_odoo,
                                     cnpj_fb_n, cnpj_odoo)
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

    # ==================================================================
    # VALIDACAO EM MASSA — PRODUTOS
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

        with envia(None) as env:
            lista_odoo = env.buscando_produtos_validar()

        if lista_odoo is None:
            _logger.error("Nao foi possivel obter lista de produtos do Odoo")
            _logger.info("FALHA: nao foi possivel obter lista do Odoo.")
            return

        mapa_odoo = {int(p["codproduto"]): p for p in lista_odoo}
        _logger.info("Odoo retornou %s produtos", len(mapa_odoo))

        inativados = 0
        atualizados = 0
        sem_match = 0
        ja_ok = 0

        with con() as db:
            total_fb = db.query("SELECT COUNT(*) FROM PRODUTOS")[0][0]

            if total_fb > 0 and min_pct > 0:
                pct = len(mapa_odoo) / float(total_fb)
                if pct < min_pct:
                    msg = ("ABORTADO: Odoo devolveu %s produtos, Firebird tem "
                           "%s (%.1f%% < %.0f%%). Verifique o Odoo antes de "
                           "rodar."
                           % (len(mapa_odoo), total_fb, pct * 100,
                              min_pct * 100))
                    _logger.error(msg)
                    return
                _logger.info("Cobertura Odoo: %.1f%% (%s / %s)",
                             pct * 100, len(mapa_odoo), total_fb)

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
                            _logger.info("[DRY-RUN] inativaria produto %s (%s) "
                                         "[nao existe no Odoo]",
                                         codprd, produto_fb)
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
                            _logger.info("[DRY-RUN] inativaria produto %s (%s) "
                                         "[Odoo inativo]", codprd, produto_fb)
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
                        _logger.info("[DRY-RUN] atualizaria produto %s: "
                                     "nome=%r->%r codpro=%r->%r codbarra=%r->%r",
                                     codprd, produto_fb, nome_odoo,
                                     codpro_fb, codpro_odoo,
                                     codbarra_fb, codbarra_odoo)
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


# ======================================================================
# Entrypoint: permite rodar direto para testar.
#   python pos_order_script.py atualiza_vendas
#   python pos_order_script.py atualiza_produtos
#   python pos_order_script.py atualiza_clientes
#   python pos_order_script.py atualiza_caixas
#   python pos_order_script.py devolucao
#   python pos_order_script.py validar_produtos [aplicar]
#   python pos_order_script.py validar_clientes [aplicar]
# ======================================================================
if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        _logger.error("Uso: python pos_order_script.py <acao> [aplicar]")
        _logger.info(
            "Acoes: atualiza_vendas | atualiza_produtos | atualiza_clientes | "
            "atualiza_caixas | devolucao | validar_produtos | validar_clientes"
        )
        sys.exit(2)

    acao = sys.argv[1]
    aplicar = "aplicar" in sys.argv[2:]
    obj = IntegracaoOdoo()

    if acao == "atualiza_vendas":
        obj.action_atualiza_vendas()
    elif acao == "atualiza_produtos":
        obj.action_atualiza_produtos()
    elif acao == "atualiza_clientes":
        obj.action_atualiza_clientes()
    elif acao == "atualiza_caixas":
        obj.action_atualiza_caixas()
    elif acao == "devolucao":
        obj.action_devolucao()
    elif acao == "validar_produtos":
        obj.validar_produtos(dry_run=not aplicar)
    elif acao == "validar_clientes":
        obj.validar_clientes(dry_run=not aplicar)
    else:
        _logger.error("Acao desconhecida: %s", acao)
        sys.exit(2)