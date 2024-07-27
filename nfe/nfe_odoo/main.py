import configparser
import requests as rq
import logging
from logging.handlers import RotatingFileHandler
from pathlib import Path
# from pos_order import IntegracaoOdoo as integra

_logger = logging.getLogger(__name__)
Path('logs').mkdir(parents=True, exist_ok=True) # Create folder if not exists
handlers = [ RotatingFileHandler(filename='logs/log_atualiza.txt',
            mode='w', 
            maxBytes=512000, 
            backupCount=4)
           ]
logging.basicConfig(handlers=handlers, 
                    level=logging.INFO, 
                    format='%(levelname)s %(asctime)s %(message)s', 
                    datefmt='%d/%m/%Y%I:%M:%S %p',force=True)

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
        path_url = f"https://github.com/ATSTI/pdv/raw/master/nfe/nfe_odoo/{self.versao_name}"
        retorno = rq.get(path_url)
        # print(retorno.text)
        if "SISTEMA" not in retorno.text:
            print ("------------------------------------")
            print ("Erro na atualizacao da versao,")
            print ("...............................")
            print (" ATENCAO: ")
            print ("...............................")
            print ("se continuar muito tempo assim, depois de horas, ")
            print ("comunique a ATS.")
            print ("------------------------------------")
            return
        _logger.info(f"atualizando {retorno.text}")
        with open(self.versao_name, mode="w") as arq_retorno:
            arq_retorno.write(retorno.text)
        cfg = configparser.ConfigParser()
        cfg.read(self.versao_name)
        versao_atual  = cfg.get('SISTEMA', 'versao')
        # print("versao atual " + versao_atual)
        _logger.info(f"Versão atual: {versao_atual}, nova versao: {self.versao}")
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
            _logger.info(f"Atualizando arquivos - {arq}")
            print ("Atualizando arquivos - " + arq)
            path_url = f"https://github.com/ATSTI/pdv/raw/master/nfe/nfe_odoo/{arq}"
            retorno = rq.get(path_url)
            file_retorno = arq
            if arq == 'executa_odoo_nfe_retorno.py':
                file_retorno = 'executa_odoo_nfe_retorno.pyw'
            with open(file_retorno, mode="w") as arq_retorno:
                arq_retorno.write(retorno.text)
        _logger.info("Sistema atualizado com sucesso")