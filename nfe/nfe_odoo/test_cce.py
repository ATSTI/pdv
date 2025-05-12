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
        import pudb;pu.db
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

    """
    def test_pega_xml(self):
        # sindicato-teste
        # empresa Alcides Caceres
        empresa = '1'

        # limpando para executar teste completo
        db = con_fdb()
        edita = "DELETE FROM nfe WHERE EMPRESA_ID = %s" %(str(empresa))
        db.execute(edita)
        conecta = nfe_envia(empresa=empresa, funcao_exec='PEGA_XML')

        # limpo arquivos se existir
        arquivo = os.path.join(conecta.path_retorno, "notas", '*.xml')
        files = iglob(arquivo)
        for xml_arquivo in files:
            os.remove(xml_arquivo)

        # buscando xml e inserindo
        conecta.pega_xml(int(empresa))
        # arquivo = os.path.join(conecta.path_retorno, "notas", '*.xml')
        files = iglob(arquivo)
        baixou = False
        for xml_arquivo in files:
            baixou = True
        # verifica se baixou arquivos
        self.assertEqual(baixou, True)

    def test_verifica_database_xml(self):
        db = con_fdb()
        # limpando q existe
        empresa = '1'        
        arquivo = os.path.join(db.return_path(), "notas", '*.xml')
        files = iglob(arquivo)
        total_xml = 0
        total_database = 0
        for xml_arquivo in files:
            # import pudb;pu.db
            total_xml += 1
            print (xml_arquivo)
            nfe_proc = NfeProc.from_path(xml_arquivo)
            if hasattr(nfe_proc, "infNFe"):
                chave = nfe_proc.infNFe.Id[3:]
                print ("Sem Protocolo")
                protocolo = False
            if hasattr(nfe_proc, "protNFe"):
                # with self.assertRaises(TypeError):
                # chave = nfe_proc.infNFe.Id[3:]
                # print ("NFe")
                # nfe_proc = NfeProc.from_path(xml_arquivo)
                # if hasattr(nfe_proc, "protNFe"):
                print ("Com Protocolo NFe")
                chave = nfe_proc.protNFe.infProt.chNFe
                protocolo = nfe_proc.protNFe.infProt.nProt
            #try:
            #    
            #except:
            #    protocolo = False
            busca = "select num_nfe, situacao, data_alteracao, chave, protocolo from nfe "
            busca += " where empresa_id = %s " %(str(empresa))
            busca += " and chave = '%s'" %(str(chave))
            dados = db.query(busca)
            # import pudb;pu.db
            for item in dados:
                total_database += 1
                if protocolo:
                    situacao = "Autorizada"
                    print("Situacao: %s" %(situacao))
                    self.assertEqual(item[1], situacao)
                    self.assertEqual(item[4], protocolo)
                else:
                    print("Situacao: nao autorizada")
                    self.assertTrue(item[0]) 
        self.assertEqual(total_xml, total_database)

    def test_verifica_sobrescrever_xml(self):
        # se xml com protocolo nao pode sobrescrever
        db = con_fdb()
        empresa = '1'
        arquivo = os.path.join(db.return_path(), "notas", '*.xml')
        files = iglob(arquivo)
        protocolo = ""
        isExist = os.path.exists("teste")
        if not isExist:
            # Create a new directory because it does not exist
            os.makedirs("teste")        
        for xml_arquivo in files:
            nfe_proc = NfeProc.from_path(xml_arquivo)
            if hasattr(nfe_proc, "protNFe"):                
                protocolo = nfe_proc.protNFe.infProt.nProt
                shutil.copyfile(xml_arquivo, "teste/nfe_com_protocolo.xml")
                break
        files = iglob(arquivo)
        arquivo_com_protocolo = ""
        for xml_arquivo in files:
            nfe_proc = NfeProc.from_path(xml_arquivo)
            print ("xml gravado com protocolo : %s" %(xml_arquivo))
            if hasattr(nfe_proc, "infNFe"):
                shutil.copyfile("teste/nfe_com_protocolo.xml", xml_arquivo)
                arquivo_com_protocolo = xml_arquivo
                break

        # executando a busca de xml
        conecta = nfe_envia(empresa=empresa, funcao_exec='PEGA_XML')
        conecta.pega_xml(int(empresa))
        files = iglob(arquivo)
        baixou = False
        for xml_arquivo in files:
            baixou = True
            if arquivo_com_protocolo == xml_arquivo:
                print ("Validando protocolo : %s" %(xml_arquivo))
                nfe_proc = NfeProc.from_path(xml_arquivo)
                if hasattr(nfe_proc, "protNFe"):
                    self.assertEqual(nfe_proc.protNFe.infProt.nProt, protocolo)
        self.assertEqual(baixou, True)
    """

if __name__ == '__main__':
    unittest.main()