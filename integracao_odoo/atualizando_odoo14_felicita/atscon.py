# -*- coding: utf-8 -*-

import configparser
import fdb


class Conexao:

    def __init__(self):
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')

        psw  = cfg.get('DATABASE', 'password')
        host = cfg.get('DATABASE', 'HostName')

        self.connection = fdb.connect(
            dsn=host,
            user='sysdba',
            password=psw,
            charset='utf-8'
        )
        self.cursor = self.connection.cursor()

    # ------------------------------------------------------------------
    def insert(self, query, params=None):
        """
        Executa INSERT/UPDATE/DELETE com commit.
        Retorna True em sucesso, False em erro.
        """
        try:
            if params is not None:
                self.cursor.execute(query, params)
            else:
                self.cursor.execute(query)
            self.connection.commit()
            return True
        except Exception as e:
            print("ERRO SQL: %s\n  -> %s" % (query, e))
            try:
                self.connection.rollback()
            except Exception:
                pass
            return False

    # ------------------------------------------------------------------
    def query(self, query, params=None):
        """
        Executa SELECT e devolve uma lista de tuplas (materializada).
        Assim o cursor fica livre para a próxima chamada.
        """
        try:
            if params is not None:
                cur = self.cursor.execute(query, params)
            else:
                cur = self.cursor.execute(query)
            return cur.fetchall()
        except Exception as e:
            print("ERRO SELECT: %s\n  -> %s" % (query, e))
            raise

    # ------------------------------------------------------------------
    def scalar(self, query, params=None):
        """Executa SELECT e devolve apenas o primeiro campo da primeira linha (ou None)."""
        rows = self.query(query, params)
        if not rows:
            return None
        row = rows[0]
        return row[0] if row else None

    # ------------------------------------------------------------------
    def commit(self):
        try:
            self.connection.commit()
        except Exception as e:
            print("ERRO COMMIT: %s" % e)

    def rollback(self):
        try:
            self.connection.rollback()
        except Exception:
            pass

    # ------------------------------------------------------------------
    def close(self):
        try:
            if self.cursor is not None:
                self.cursor.close()
        except Exception:
            pass
        try:
            if self.connection is not None:
                self.connection.close()
        except Exception:
            pass
        self.cursor = None
        self.connection = None

    def __del__(self):
        # protege contra o interpretador já estar encerrando
        try:
            self.close()
        except Exception:
            pass