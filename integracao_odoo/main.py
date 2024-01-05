import configparser
import requests as rq
# from pos_order import IntegracaoOdoo as integra

class Main():

    def __init__(self):
        # import pudb;pu.db
        cfg = configparser.ConfigParser()
        self.versao_name = 'versao.cfg'
        cfg.read(self.versao_name)
        if len(cfg.sections()):
            self.versao = cfg.get('SISTEMA', 'versao')
        else:
            self.versao = '0.0.0.0'
        self.buscando_script()

    def buscando_script(self):
        path_url = f"https://github.com/ATSTI/pdv/raw/integracao_odoo_script/integracao_odoo/{self.versao_name}"
        retorno = rq.get(path_url)
        with open(self.versao_name, mode="w") as arq_retorno:
            arq_retorno.write(retorno.text)
        cfg = configparser.ConfigParser()
        cfg.read(self.versao_name)
        versao_atual  = cfg.get('SISTEMA', 'versao')
        if versao_atual == self.versao:
            return
        arquivos = [
            '__init__.py',
            'atscon.py',
            'conecta_server.py',
            'pos_order.py',
            'sqlite_bd.py'
        ]
        for arq in arquivos:
            path_url = f"https://github.com/ATSTI/pdv/raw/integracao_odoo_script/integracao_odoo/{arq}"
            retorno = rq.get(path_url)
            file_retorno = arq
            with open(file_retorno, mode="w") as arq_retorno:
                arq_retorno.write(retorno.text)
