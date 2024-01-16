from conecta_odoo_nfe import ConectaServerNFe as nfe_envia

class ExecutaOdooNFeBusca():
    _name = 'executa.odoo.nfe.busca'

    def __init__(self):
        empresa = int('999999') # ao executar o script substitui pelo id da empresa
        # uso TESTE
        # empresa = '3'
        conecta = nfe_envia(empresa=empresa, funcao_exec='PEGA_XML')
        conecta.pega_xml(int(empresa))

ExecutaOdooNFeBusca()