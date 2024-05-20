import configparser
import requests as rq
from main_arquivos import MainArquivos

class Main():

    def __init__(self):
        cfg = configparser.ConfigParser()
        self.versao_name = 'versao.cfg'
        cfg.read(self.versao_name)
        if len(cfg.sections()):
            self.versao = cfg.get('SISTEMA', 'versao')
        else:
            self.versao = '0.0.0.0'
        self.buscando_script()

    def buscando_script(self):
        path_url = "https://github.com/ATSTI/pdv/raw/integracao_odoo_script/integracao_odoo/%s" %(self.versao_name)
        retorno = rq.get(path_url)
        # print(retorno.text)
        with open(self.versao_name, mode="w") as arq_retorno:
            arq_retorno.write(retorno.text)
        cfg = configparser.ConfigParser()
        cfg.read(self.versao_name)
        versao_atual  = cfg.get('SISTEMA', 'versao')
        # print("versao atual " + versao_atual)
        if versao_atual == self.versao:
            return
        arq = MainArquivos()
        arquivos = arq.lista_arquivos()
        # arquivos = [
        #     '__init__.py',
        #     'atscon.py',
        #     'conecta_server.py',
        #     'pos_order.py',
        #     'pos_order_exec.py',
        #     'pos_order_script.py',
        #     'sqlite_bd.py',
        #     'atualiza_clientes.py',
        #     'atualiza_produtos.py',
        #     'atualiza_caixas.py',
        #     'app_executa.py'
        # ]
        for arq in arquivos:
            print ("Atualizando arquivos - " + arq) 
            path_url = "https://github.com/ATSTI/pdv/raw/integracao_odoo_script/integracao_odoo/%s" %(arq)
            retorno = rq.get(path_url)
            if arq == "pos_order.py":
                file_retorno = "pos_order.pyw"
                with open(file_retorno, mode="w") as arq_retorno:
                    arq_retorno.write(retorno.text)
            file_retorno = arq
            with open(file_retorno, mode="w") as arq_retorno:
                arq_retorno.write(retorno.text)
