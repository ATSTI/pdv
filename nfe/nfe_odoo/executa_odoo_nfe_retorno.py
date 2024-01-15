import time
from conecta_odoo_nfe import ConectaServerNFe as nfe_envia

class ExecutaOdooNFeRetorna():
    _name = 'executa.odoo.nfe.retorna'

    def __init__(self):
        #import pudb;pu.db
        empresa = int('999999') # ao executar o script substitui pelo id da empresa
        # uso TESTE
        # empresa = '3'
        conecta = nfe_envia(empresa=empresa, funcao_exec='ENVIA_AUTORIZADA')
        while(True):
            conecta.retorna_xml_validado(int(empresa))
            time.sleep(600)

ExecutaOdooNFeRetorna()