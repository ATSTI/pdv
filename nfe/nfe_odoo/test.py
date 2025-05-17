import unittest
import os
import shutil

from glob import iglob
from os.path import getmtime
# from atscon import Conexao as con_fdb
from conecta_odoo_nfe import ConectaServerNFe as nfe_envia
from nfelib.nfe.bindings.v4_0.proc_nfe_v4_00 import NfeProc


class TestStringMethods(unittest.TestCase):

    def test_pega_xml(self):
        # sindicato-teste
        # empresa ARMAX
        empresa = '2'

        # limpando para executar teste completo
        # db = con_fdb()
        # edita = "DELETE FROM nfe WHERE EMPRESA_ID = %s" %(str(empresa))
        # db.execute(edita)
        conecta = nfe_envia(empresa=empresa, funcao_exec='PEGA_XML')

        # # limpo arquivos se existir
        # arquivo = os.path.join(conecta.path_retorno, "notas", '*.xml')
        # files = iglob(arquivo)
        # for xml_arquivo in files:
        #     os.remove(xml_arquivo)

        # buscando xml e inserindo
        conecta.pega_xml(int(empresa))
        # arquivo = os.path.join(conecta.path_retorno, "notas", '*.xml')
        # files = iglob(arquivo)
        # baixou = False
        # for xml_arquivo in files:
        #     baixou = True
        # verifica se baixou arquivos
        # self.assertEqual(baixou, True)

    # def test_verifica_database_xml(self):
    #     db = con_fdb()
    #     # limpando q existe
    #     empresa = '1'        
    #     arquivo = os.path.join(db.return_path(), "notas", '*.xml')
    #     files = iglob(arquivo)
    #     total_xml = 0
    #     total_database = 0
    #     for xml_arquivo in files:
    #         total_xml += 1
    #         print (xml_arquivo)
    #         nfe_proc = NfeProc.from_path(xml_arquivo)
    #         if hasattr(nfe_proc, "infNFe"):
    #             chave = nfe_proc.infNFe.Id[3:]
    #             print ("Sem Protocolo")
    #             protocolo = False
    #         if hasattr(nfe_proc, "protNFe"):
    #             # with self.assertRaises(TypeError):
    #             # chave = nfe_proc.infNFe.Id[3:]
    #             # print ("NFe")
    #             # nfe_proc = NfeProc.from_path(xml_arquivo)
    #             # if hasattr(nfe_proc, "protNFe"):
    #             print ("Com Protocolo NFe")
    #             chave = nfe_proc.protNFe.infProt.chNFe
    #             protocolo = nfe_proc.protNFe.infProt.nProt
    #         #try:
    #         #    
    #         #except:
    #         #    protocolo = False
    #         busca = "select num_nfe, situacao, data_alteracao, chave, protocolo from nfe "
    #         busca += " where empresa_id = %s " %(str(empresa))
    #         busca += " and chave = '%s'" %(str(chave))
    #         dados = db.query(busca)
    #         for item in dados:
    #             total_database += 1
    #             if protocolo:
    #                 situacao = "Autorizada"
    #                 print("Situacao: %s" %(situacao))
    #                 self.assertEqual(item[1], situacao)
    #                 self.assertEqual(item[4], protocolo)
    #             else:
    #                 print("Situacao: nao autorizada")
    #                 self.assertTrue(item[0]) 
    #     self.assertEqual(total_xml, total_database)

    # def test_verifica_sobrescrever_xml(self):
    #     # se xml com protocolo nao pode sobrescrever
    #     db = con_fdb()
    #     empresa = '1'
    #     arquivo = os.path.join(db.return_path(), "notas", '*.xml')
    #     files = iglob(arquivo)
    #     protocolo = ""
    #     isExist = os.path.exists("teste")
    #     if not isExist:
    #         # Create a new directory because it does not exist
    #         os.makedirs("teste")        
    #     for xml_arquivo in files:
    #         nfe_proc = NfeProc.from_path(xml_arquivo)
    #         if hasattr(nfe_proc, "protNFe"):                
    #             protocolo = nfe_proc.protNFe.infProt.nProt
    #             shutil.copyfile(xml_arquivo, "teste/nfe_com_protocolo.xml")
    #             break
    #     files = iglob(arquivo)
    #     arquivo_com_protocolo = ""
    #     for xml_arquivo in files:
    #         nfe_proc = NfeProc.from_path(xml_arquivo)
    #         print ("xml gravado com protocolo : %s" %(xml_arquivo))
    #         if hasattr(nfe_proc, "infNFe"):
    #             shutil.copyfile("teste/nfe_com_protocolo.xml", xml_arquivo)
    #             arquivo_com_protocolo = xml_arquivo
    #             break

    #     # executando a busca de xml
    #     conecta = nfe_envia(empresa=empresa, funcao_exec='PEGA_XML')
    #     conecta.pega_xml(int(empresa))
    #     files = iglob(arquivo)
    #     baixou = False
    #     for xml_arquivo in files:
    #         baixou = True
    #         if arquivo_com_protocolo == xml_arquivo:
    #             print ("Validando protocolo : %s" %(xml_arquivo))
    #             nfe_proc = NfeProc.from_path(xml_arquivo)
    #             if hasattr(nfe_proc, "protNFe"):
    #                 self.assertEqual(nfe_proc.protNFe.infProt.nProt, protocolo)
    #     self.assertEqual(baixou, True)

if __name__ == '__main__':
    unittest.main()