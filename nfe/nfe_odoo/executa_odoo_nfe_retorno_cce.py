import time
from conecta_odoo_nfe_cce import ConectaServerNFeCCe as nfe_cce

class ExecutaOdooNFeRetorna():
    _name = 'executa.odoo.nfe.retorna'

    def __init__(self):
        empresa = int('999999') # ao executar o script substitui pelo id da empresa
        # uso TESTE
        # empresa = '3'
        cce = nfe_cce(empresa=empresa)
        cce.retorna_cce(empresa)

        # time.sleep(600)

ExecutaOdooNFeRetorna()