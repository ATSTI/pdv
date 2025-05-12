import unittest
import os
import shutil

from glob import iglob
from os.path import getmtime
from conecta_odoo_nfe import ConectaServerNFe as nfe_envia
from nfelib.nfe.bindings.v4_0.proc_nfe_v4_00 import NfeProc



class TestStringMethods(unittest.TestCase):

    def test_retorna_xml(self):
        # sindicato-teste
        # empresa Armax
        empresa = 2
        # limpando para executar teste completo
        conecta = nfe_envia(empresa=empresa, funcao_exec='PEGA_XML')
        con = conecta._conexao_odoo()
        # buscando xml e inserindo
        conecta.retorna_xml_validado(empresa)
        # verificando se criou o evento no Odoo
        arquivo = os.path.join(conecta.path_retorno, "notas", '')
        arquivo = arquivo + 'NFe35250522798597000102550010000015771841667444-env.xml'
        nfe_ret = NfeProc.from_path(arquivo)
        chave = nfe_ret.NFe.infNFe.Id[3:]
        # protocolo = nfe_ret.protNFe.infProt.nProt
        n_xml = con.env['account.move']
        nfe_ids = n_xml.search([
            ('document_key', '=', chave),
            ('company_id', '=', empresa)
        ])
        if not nfe_ids:
            self.fail("Nota de teste nao localizada Odoo")
        for nfe in n_xml.browse(nfe_ids):
            self.assertEqual(nfe.state_edoc, "autorizada")

if __name__ == '__main__':
    unittest.main()