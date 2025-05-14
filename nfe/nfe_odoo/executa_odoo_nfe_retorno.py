import time
from conecta_odoo_nfe import ConectaServerNFe as nfe_envia
# from conecta_odoo_nfe_cce import ConectaServerNFeCCe as nfe_cce
# from conecta_odoo_nfe_cancela import ConectaServerNFeCancela as nfe_cancel

class ExecutaOdooNFeRetorna():
    _name = 'executa.odoo.nfe.retorna'

    def __init__(self):
        empresa = int('999999') # ao executar o script substitui pelo id da empresa
        # uso TESTE
        # empresa = '3'
        conecta = nfe_envia(empresa=empresa, funcao_exec='ENVIA_AUTORIZADA')
        # while(True):
        conecta.retorna_xml_validado(int(empresa))
        # cce = nfe_cce(empresa=empresa)
        # cce.retorna_cce(empresa)
        # cancel = nfe_cancel(empresa=empresa)
        # cancel.retorna_notas_canceladas(empresa)

        # time.sleep(600)

ExecutaOdooNFeRetorna()