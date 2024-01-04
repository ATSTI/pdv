# -*- coding: utf-8 -*-
import odoorpc
import os
from datetime import datetime
import base64
from sqlite_bd import Database as local_db
import configparser

class ConectaServerNFe():
    _name = 'conecta.server.nfe'

    def __init__(self):
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')
        self.path_retorno  = cfg.get('INTEGRA', 'Path_retorno')
        self.url = cfg.get('INTEGRA', 'url')
        self.db = cfg.get('INTEGRA', 'db')
        self.porta = cfg.get('INTEGRA', 'porta')
        self.login = cfg.get('INTEGRA', 'login')
        self.passwd = cfg.get('INTEGRA', 'password')
        empresa = int('999999') # ao executar o script substitui pelo id da empresa
        self.pega_xml(empresa)

    def _conexao_odoo(self):
        origem = odoorpc.ODOO(self.url, port=self.porta)
        origem.login(self.db, self.login, self.passwd)
        return origem

    def pega_xml(self, empresa):
        con = self._conexao_odoo()
        db = local_db(filename = 'lancamento.db', table = 'nfe')
        p_xml = con.env['account.move']

        # chave = '35xxxxxxxxxxx8550010000093411523728494'
        # nfe_ids = p_xml.search([('document_key', '=', chave)])
        nfe_ids = p_xml.search([
            ('document_type_id.code', '=', '55'),
            ('state_edoc', '=', 'a_enviar'),
            ('company_id', '=', empresa)
        ])

        empresa_id = empresa
        arquivo = f"{self.path_retorno}/notas"
        # Check whether the specified path exists or not
        isExist = os.path.exists(arquivo)
        if not isExist:
            # Create a new directory because it does not exist
            os.makedirs(arquivo)
        for prd in p_xml.browse(nfe_ids):
            chave = prd.document_key
            existe = db.consulta_nfe(chave, empresa_id)
            if existe:
                continue
            xml = base64.b64decode(prd.send_file_id.datas).decode('iso-8859-1')
            arquivo = f"{arquivo}/{prd.send_file_id.name}"
            save_file = open(arquivo, 'w')
            save_file.write(xml)
            print ('Chave: %s , protocolo: %s ' % (chave ,prd.authorization_protocol))
            emissao = datetime.strftime(prd.document_date,'%Y-%m-%d')

            db.insert_nfe(dict(
                    move_id = prd.id,
                    empresa_id = prd.company_id.id,
                    xml_aenviar = xml,
                    chave = prd.document_key,
                    dest = prd.partner_id.name,
                    num_nfe = prd.document_number,
                    data_emissao = emissao,
                    situacao = 'A_enviar'
                ))
            
ConectaServerNFe()