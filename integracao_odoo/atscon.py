# -*- coding: utf-8 -*-
"""Conexao Firebird para o PDV."""
import configparser
import os

import fdb

from integracao_log import get_logger

_logger = get_logger(__name__)


class Conexao:

    def __init__(self):
        cfg = configparser.ConfigParser()
        if not cfg.read("conf.ini"):
            raise FileNotFoundError(
                "conf.ini nao encontrado em %s" % os.getcwd()
            )
        if not cfg.has_section("DATABASE"):
            raise ValueError("conf.ini sem secao [DATABASE]")

        dsn  = cfg.get("DATABASE", "Hostname")
        user = cfg.get("DATABASE", "User")
        psw  = cfg.get("DATABASE", "Password")

        self.connection = fdb.connect(
            dsn=dsn, user=user, password=psw, charset="utf-8"
        )
        self._fechada = False

    def insert(self, query, params=None):
        cur = self.connection.cursor()
        try:
            if params:
                cur.execute(query, params)
            else:
                cur.execute(query)
            self.connection.commit()
            return ""
        except Exception as e:
            try:
                self.connection.rollback()
            except Exception:
                pass
            _logger.exception("Falha no INSERT/UPDATE: %s", query[:200])
            return "Erro : %s" % (e,)
        finally:
            try:
                cur.close()
            except Exception:
                pass

    def query(self, query, params=None):
        cur = self.connection.cursor()
        try:
            if params:
                cur.execute(query, params)
            else:
                cur.execute(query)
            return cur.fetchall()
        except Exception:
            _logger.exception("Falha no SELECT: %s", query[:200])
            raise
        finally:
            try:
                cur.close()
            except Exception:
                pass

    def ddl(self, query):
        """Executa DDL (CREATE/ALTER/DROP). Retorna "" ou "Erro : ..."."""
        cur = self.connection.cursor()
        try:
            cur.execute(query)
            self.connection.commit()
            return ""
        except Exception as e:
            try:
                self.connection.rollback()
            except Exception:
                pass
            _logger.exception("Falha no DDL: %s", query[:200])
            return "Erro : %s" % (e,)
        finally:
            try:
                cur.close()
            except Exception:
                pass

    def close(self):
        if self._fechada:
            return
        try:
            self.connection.close()
        except Exception:
            _logger.exception("Falha fechando conexao Firebird")
        finally:
            self._fechada = True

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, tb):
        try:
            if exc_type:
                try:
                    self.connection.rollback()
                except Exception:
                    pass
        finally:
            self.close()

    def __del__(self):
        try:
            self.close()
        except Exception:
            pass
