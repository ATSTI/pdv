import unittest
import os
from conecta_odoo_nfe_cancela import ConectaServerNFeCancela as nfe_cancel
from nfelib.nfe_evento_cancel.bindings.v1_0.evento_canc_nfe_v1_00 import Evento as Cancel

class TestStringMethods(unittest.TestCase):

    def test_envia_cancelamento_odoo(self):
        # sindicato-teste
        # empresa Armax
        empresa = 2
        # limpando para executar teste completo
        conecta = nfe_cancel(empresa=empresa, funcao_exec='PEGA_XML')
        con = conecta._conexao_odoo()
        # buscando xml e inserindo
        conecta.retorna_notas_canceladas(empresa)
        # verificando se criou o evento no Odoo
        arquivo = os.path.join(conecta.path_retorno, "eventos", '')
        arquivo = arquivo + '1101113525052279859700010255001000001577184166744401-procEventoNFe.xml'
        cancel_ret = Cancel.from_path(arquivo)
        tpoEvento = cancel_ret.retEvento.infEvento.tpEvento
        chave = cancel_ret.retEvento.infEvento.chNFe
        protocolo = cancel_ret.retEvento.infEvento.nProt
        # justificativa = cancel_ret.evento.infEvento.detEvento.xJust
        try:
            cancel_ret.retEvento.infEvento.tpEvento
        except:
            self.fail("Não tem atributo tpEvento")
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
                ('type', '=', '2')
            ])
            for cce in event.browse(cce_ids):
                self.assertEqual(cce.protocol_number, protocolo)
                self.assertEqual(tpoEvento, '110111', msg='Tipo do evento nao confere')
                self.assertEqual(cce.state_edoc, "cancelada", msg="Nota nao cancelada no Odoo")

if __name__ == '__main__':
    unittest.main()