import unittest
import os
import shutil

from glob import iglob
from os.path import getmtime
from conecta_odoo_nfe import ConectaServerNFe as nfe_envia
from conecta_odoo_nfe_cce import ConectaServerNFeCCe as nfe_cce
from nfelib.nfe.bindings.v4_0.proc_nfe_v4_00 import NfeProc
from nfelib.nfe_evento_cce.bindings.v1_0.ret_env_cce_v1_00 import RetEnvEvento as CCe


class TestStringMethods(unittest.TestCase):

    def test_envia_cce_odoo(self):
        # sindicato-teste
        # empresa Armax
        empresa = 2
        # limpando para executar teste completo
        conecta = nfe_cce(empresa=empresa, funcao_exec='PEGA_XML')
        con = conecta._conexao_odoo()
        # buscando xml e inserindo
        conecta.retorna_cce(empresa)
        # verificando se criou o evento no Odoo
        arquivo = os.path.join(conecta.path_retorno, "eventos", '')
        arquivo = arquivo + '1101103525052279859700010255001000001577184166744401-procEventoNFe.xml'
        # arquivo = '/home/publico/tmp/eventos/1101103525052279859700010255001000001577184166744401-procEventoNFe.xml'
        cce_ret = CCe.from_path(arquivo)
        tpoEvento = cce_ret.retEvento.infEvento.tpEvento
        chave = cce_ret.retEvento.infEvento.chNFe
        protocolo = cce_ret.retEvento.infEvento.nProt
        try:
            cce_ret.retEvento.infEvento.tpEvento
        except:
            self.fail("Não tem atributo tpEvento")
        chave = cce_ret.retEvento.infEvento.chNFe
        protocolo = cce_ret.retEvento.infEvento.nProt
        n_xml = con.env['account.move']
        nfe_ids = n_xml.search([
            ('document_key', '=', chave),
            ('company_id', '=', empresa)
        ])
        if not nfe_ids:
            self.fail("Nota de teste nao localizada Odoo")
        for nfe in n_xml.browse(nfe_ids):
            event = con.env['l10n_br_fiscal.event']
            cce_ids = event.search([
                ('protocol_number', '=', protocolo),
                ('document_id', '=', nfe.fiscal_document_id.id),
                ('type', '=', '14')
            ])
            for cce in event.browse(cce_ids):
                self.assertEqual(cce.protocol_number, protocolo)
                self.assertEqual(tpoEvento, '110110', msg='Tipo do evento nao confere')

if __name__ == '__main__':
    unittest.main()