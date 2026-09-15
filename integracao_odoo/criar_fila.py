# -*- coding: utf-8 -*-
"""
Cria (se nao existir) a tabela INTEGRACAO_FILA no Firebird 2.5.

Estrutura:
- Tabela INTEGRACAO_FILA
- Sequence GEN_INTEGRACAO_FILA_ID
- Trigger TR_INTEGRACAO_FILA_BI que preenche o ID no INSERT

Idempotente: rodar varias vezes nao causa erro.
"""
import sys

from atscon import Conexao as con
from integracao_log import get_logger

_logger = get_logger("criar_fila")


def _executa_ddl(db, sql, descricao):
    r = db.ddl(sql)
    if r:
        # alguns DDLs podem ja existir; tratamos como aviso
        low = r.lower()
        if "already exists" in low or "ja existe" in low:
            print("  (aviso) %s ja existia" % descricao)
            return True
        print("FALHA em %s: %s" % (descricao, r))
        _logger.error("DDL falhou (%s): %s", descricao, r)
        return False
    print("  OK %s" % descricao)
    return True


def _existe_tabela(db):
    r = db.query(
        "SELECT 1 FROM RDB$RELATIONS "
        "WHERE RDB$RELATION_NAME = 'INTEGRACAO_FILA'"
    )
    return bool(r)


def _existe_sequence(db):
    r = db.query(
        "SELECT 1 FROM RDB$GENERATORS "
        "WHERE RDB$GENERATOR_NAME = 'GEN_INTEGRACAO_FILA_ID'"
    )
    return bool(r)


def _existe_trigger(db):
    r = db.query(
        "SELECT 1 FROM RDB$TRIGGERS "
        "WHERE RDB$TRIGGER_NAME = 'TR_INTEGRACAO_FILA_BI'"
    )
    return bool(r)


DDL_TABELA = """
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
"""

DDL_SEQUENCE = """
CREATE SEQUENCE GEN_INTEGRACAO_FILA_ID
"""

DDL_TRIGGER = """
CREATE TRIGGER TR_INTEGRACAO_FILA_BI FOR INTEGRACAO_FILA
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.ID IS NULL) THEN
        NEW.ID = NEXT VALUE FOR GEN_INTEGRACAO_FILA_ID;
END
"""


def main():
    with con() as db:
        # 1. tabela
        if not _existe_tabela(db):
            print("Criando INTEGRACAO_FILA...")
            if not _executa_ddl(db, DDL_TABELA, "CREATE TABLE"):
                sys.exit(1)
        else:
            print("INTEGRACAO_FILA ja existe.")

        # 2. sequence
        if not _existe_sequence(db):
            if not _executa_ddl(db, DDL_SEQUENCE, "CREATE SEQUENCE"):
                sys.exit(1)
        else:
            print("  Sequence ja existe.")

        # 3. trigger
        if not _existe_trigger(db):
            if not _executa_ddl(db, DDL_TRIGGER, "CREATE TRIGGER"):
                sys.exit(1)
        else:
            print("  Trigger ja existe.")

        # 4. valida colunas
        cols = db.query(
            "SELECT RDB$FIELD_NAME FROM RDB$RELATION_FIELDS "
            "WHERE RDB$RELATION_NAME = 'INTEGRACAO_FILA'"
        )
        existentes = {(c[0] or "").strip().upper() for c in cols}
        esperadas = {
            "ID", "TIPO", "ID_ORIGEM", "PAYLOAD",
            "STATUS", "TENTATIVAS", "DT_CRIACAO", "DT_ENVIO", "ERRO",
        }
        faltando = esperadas - existentes
        if faltando:
            print("ATENCAO: colunas faltando: %s" % sorted(faltando))
            print("Presentes: %s" % sorted(existentes))
            sys.exit(2)
        print("Colunas OK: %s" % sorted(existentes))

        r = db.query("SELECT COUNT(*) FROM INTEGRACAO_FILA")
        print("Registros: %s" % (r[0][0] if r else 0))

    print("\nPronto.")


if __name__ == "__main__":
    main()
