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
        self.path_retorno  = cfg.get('INTEGRA', 'Path_retorno')
        self.connection = fdb.connect(dsn=host, \
            user=user, password= psw, charset='win1252')
            # user='sysdba', password= psw.decode())
        self.cursor = self.connection.cursor()

    def return_path(self):
        return self.path_retorno

    def execute(self, query):
        try:
            self.cursor.execute(query)
            self.connection.commit()
        except:
            self.connection.rollback()

    def query(self, query):
        cur = self.cursor.execute(query)

        return cur.fetchall()

    def query_one(self, query):
        cur = self.cursor.execute(query)

        return cur.fetchone()

    def sistema(self):
        return self.odoo     


    def __del__(self):
        self.connection.close()
