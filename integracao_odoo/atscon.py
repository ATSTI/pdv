# -*- encoding: iso-8859-1 -*-

import fdb
import configparser
import base64


class Conexao:

    def __init__(self):
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')
        psw = cfg.get('DATABASE', 'Password')
        # psw = base64.b64decode(psw)
        host = cfg.get('DATABASE', 'Hostname')
        user = cfg.get('DATABASE', 'User')
        self.connection = fdb.connect(dsn=host, \
            user=user, password= psw, charset='win1252')
            # user='sysdba', password= psw.decode())
        self.cursor = self.connection.cursor()

    def insert(self, query):
        try:
            self.cursor.execute(query)
            self.connection.commit()
            return ""
        except Exception as general_error:
            return f"Erro : {general_error}"

    def query(self, query):
        cur = self.cursor.execute(query)

        return cur.fetchall()

    def sistema(self):
        return self.odoo     


    def __del__(self):
        self.connection.close()
