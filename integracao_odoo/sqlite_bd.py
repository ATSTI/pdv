# -*- coding: utf-8 -*-
"""SQLite local para controle de 'ja enviado'."""
import os
import sqlite3

from integracao_log import get_logger

_logger = get_logger(__name__)


class Database:

    def __init__(self, **kwargs):
        self._filename = kwargs.get("filename")
        if not self._filename:
            raise ValueError("Database: 'filename' e obrigatorio")

        self._table = kwargs.get("table", "lancamento")
        novo = not os.path.exists(self._filename)

        self._db = sqlite3.connect(
            self._filename,
            timeout=30.0,
            isolation_level=None,
            check_same_thread=False,
        )
        self._db.row_factory = sqlite3.Row
        self._db.execute("PRAGMA journal_mode=WAL")
        self._db.execute("PRAGMA synchronous=NORMAL")
        self._db.execute("PRAGMA foreign_keys=ON")

        if novo:
            self._criar_schema()

    def _criar_schema(self):
        _logger.info("Criando schema em %s", self._filename)
        self._db.executescript("""
            CREATE TABLE IF NOT EXISTS lancamento (
                tipo            VARCHAR(12),
                user            INTEGER,
                nome            VARCHAR(60),
                caixa           INTEGER,
                codigo          INTEGER,
                data_lancamento TEXT,
                UNIQUE(tipo, caixa, codigo)
            );
            CREATE INDEX IF NOT EXISTS ix_lanc_tipo_caixa_cod
                ON lancamento(tipo, caixa, codigo);

            CREATE TABLE IF NOT EXISTS produto (
                codproduto VARCHAR(12),
                produto    VARCHAR(60)
            );

            CREATE TABLE IF NOT EXISTS cliente (
                codcliente INTEGER,
                nome       VARCHAR(60)
            );
        """)

    def insert(self, row):
        try:
            self._db.execute(
                "INSERT OR IGNORE INTO %s "
                "(tipo, user, nome, caixa, codigo, data_lancamento) "
                "VALUES (?, ?, ?, ?, ?, ?)" % self._table,
                (
                    row["tipo"], row["user"], row["nome"],
                    row["caixa"], row["codigo"], row["data_lancamento"],
                ),
            )
        except Exception:
            _logger.exception("Falha no insert: %s", row)
            raise

    def delete_produto(self, sql_delete, params=None):
        try:
            self._db.execute(sql_delete, params or ())
        except Exception:
            _logger.exception("Falha no delete_produto: %s", sql_delete[:200])
            raise

    def delete(self, key):
        self._db.execute(
            "DELETE FROM %s WHERE codigo = ?" % self._table, (key,)
        )

    def consulta(self, tipo, caixa, codigo):
        cur = self._db.execute(
            "SELECT * FROM %s "
            "WHERE tipo = ? AND caixa = ? AND codigo = ?" % self._table,
            (tipo, caixa, codigo),
        )
        dados = cur.fetchone()
        return dict(dados) if dados else False

    def consulta_nome(self, tipo, caixa, codigo, nome, data_lancado):
        cur = self._db.execute(
            "SELECT * FROM %s "
            "WHERE tipo = ? AND caixa = ? AND codigo = ? "
            "AND nome = ? AND data_lancamento = ?" % self._table,
            (tipo, caixa, codigo, nome, data_lancado),
        )
        dados = cur.fetchone()
        return dict(dados) if dados else False

    def consulta_produto(self):
        cur = self._db.execute("SELECT * FROM produto")
        return [dict(r) for r in cur.fetchall()] or False

    def consulta_cliente(self):
        cur = self._db.execute("SELECT * FROM %s" % self._table)
        return [dict(r) for r in cur.fetchall()] or False

    def sql_do(self, sql, *params):
        self._db.execute(sql, params)

    def update(self, row):
        self._db.execute(row)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, tb):
        try:
            if exc_type:
                try:
                    self._db.rollback()
                except Exception:
                    pass
        finally:
            self.close()

    def close(self):
        if getattr(self, "_db", None) is None:
            return
        try:
            self._db.close()
        except Exception:
            _logger.exception("Falha fechando SQLite")
        finally:
            self._db = None

    @property
    def filename(self):
        return self._filename

    @filename.setter
    def filename(self, fn):
        self._filename = fn

    @property
    def table(self):
        return self._table

    @table.setter
    def table(self, t):
        self._table = t or "lancamento"
