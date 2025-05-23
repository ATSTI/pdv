# -*- encoding: iso-8859-1 -*-

import fdb
import odoorpc
import configparser
import base64


class Conexao:

    def __init__(self):
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')
        psw = cfg.get('DATABASE', 'password')
        #psw = base64.b64decode(psw)
        host = cfg.get('DATABASE', 'HostName')
        name = cfg.get('DATABASE', 'user')
        #import pdb; pdb.set_trace()
        self.connection = fdb.connect(dsn=host, \
            user='sysdba', password= psw, charset='utf-8')
        self.cursor = self.connection.cursor()

        #db = cfg.get('SISTEMA', 'Database')
        #user = cfg.get('SISTEMA', 'User')
        #psw = cfg.get('SISTEMA', 'Acesso')
        #host = cfg.get('SISTEMA', 'HostName')
        #port = cfg.get('SISTEMA', 'Port')
        #psw = base64.b64decode(psw)
        #self.odoo = odoorpc.ODOO(host, port=port)
        # Login
        #self.odoo.login(db, user, psw.decode())

    def insert(self, query):
        try:
            self.cursor.execute(query)
            self.connection.commit()
        except:
            self.connection.rollback()

    def query(self, query):
        #cursor = self.connection.cursor( MySQLdb.cursors.DictCursor )
        cur = self.cursor.execute(query)

        return cur.fetchall()

    #def sistema(self):
    #    return self.odoo     


    def __del__(self):
        self.connection.close()
