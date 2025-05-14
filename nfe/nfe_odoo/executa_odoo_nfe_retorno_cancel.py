import time
from conecta_odoo_nfe_cancela import ConectaServerNFeCancela as nfe_cancel

class ExecutaOdooNFeRetorna():
    _name = 'executa.odoo.nfe.retorna'

    def __init__(self):
        empresa = int('999999') # ao executar o script substitui pelo id da empresa
        # uso TESTE
        # empresa = '3'
        cancel = nfe_cancel(empresa=empresa)
        cancel.retorna_notas_canceladas(empresa)

        # time.sleep(600)

ExecutaOdooNFeRetorna()