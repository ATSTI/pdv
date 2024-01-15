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
        # import pudb;pu.db
        path_url = f"https://github.com/ATSTI/pdv/raw/integracao_nfe_odoo_a3/nfe/nfe_odoo/{self.versao_name}"
        retorno = rq.get(path_url)
        print(retorno.text)
        with open(self.versao_name, mode="w") as arq_retorno:
            arq_retorno.write(retorno.text)
        cfg = configparser.ConfigParser()
        cfg.read(self.versao_name)
        versao_atual  = cfg.get('SISTEMA', 'versao')
        print("versao atual " + versao_atual)
        if versao_atual == self.versao:
            return
        arquivos = [
            'conecta_odoo_empresa.py',
            'conecta_odoo_nfe.py',
            'executa_odoo_nfe_busca.py',
            'executa_odoo_nfe_retorno.py',
            'sqlite_bd.py'
        ]
        for arq in arquivos:
            print ("Atualizando arquivos - " + arq) 
            path_url = f"https://github.com/ATSTI/pdv/raw/integracao_nfe_odoo_a3/nfe/nfe_odoo/{arq}"
            retorno = rq.get(path_url)
            file_retorno = arq
            if arq == 'executa_odoo_nfe_retorno.py':
                file_retorno = 'executa_odoo_nfe_retorno.pyw'
            with open(file_retorno, mode="w") as arq_retorno:
                arq_retorno.write(retorno.text)
