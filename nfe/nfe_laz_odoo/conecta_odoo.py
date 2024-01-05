# -*- coding: utf-8 -*-
import odoorpc
# import re
# from datetime import datetime
# from datetime import date
# from datetime import timedelta
# import sys
import base64
from sqlite_bd import Database as local_db
import configparser

class ConectaServer():
    _name = 'conecta.server'

    def __init__(self):
        # cfg = configparser.ConfigParser()
        # cfg.read('conf.ini')
        # self.path_envio  = cfg.get('INTEGRA', 'Path_envio')
        # self.path_retorno  = cfg.get('INTEGRA', 'Path_retorno')
        # self.url = cfg.get('INTEGRA', 'url')
        # self.db = cfg.get('INTEGRA', 'db')
        # self.login = cfg.get('INTEGRA', 'login')
        # self.passwd = cfg.get('INTEGRA', 'password')
        print('conecta')
        self.busca_empresa()
        # passa a empresa
        self.pega_xml(1)

    def _conexao_odoo(self):
        origem = odoorpc.ODOO('felicita14.atsti.com.br', port=48069)
        origem.login('felicita14', 'ats@atsti.com.br', 'a2t00s7')
        return origem

    def busca_empresa(self):
        con = self._conexao_odoo()
        db = local_db(filename = 'lancamento.db', table = 'empresa')
        empresa = con.env['res.company']
        empresas_ids = empresa.search([(1, '=', 1)])
        for emp in empresa.browse(empresas_ids):
            print(emp.name)
            existe = db.consulta_empresa(empresa_id=None, nome=None, cnpj=emp.cnpj_cpf)
            if not existe:
                razao = ''
                if emp.legal_name:
                    razao = emp.legal_name
                cnpj = ''
                if emp.cnpj_cpf:
                    cnpj = emp.cnpj_cpf
                db.insert_empresa(dict(
                    empresa_id = emp.id,
                    nome = emp.name,
                    razao = razao,
                    cnpj = cnpj
                ))

    def pega_xml(self, empresa):
        con = self._conexao_odoo()
        db = local_db(filename = 'lancamento.db', table = 'nfe')
        #origem = odoorpc.ODOO('127.0.0.1', port=9090)
        #origem.login('hatae', 'ats@atsti.com.br', 'a2t00s7')

        #a_xml = origem.env['ir.attachment']
        p_xml = con.env['account.move']
        #nfe_ids = p_xml.search([('id', '=', 4)])

        chave = '35231118880480000198550010000093411523728494'
        nfe_ids = p_xml.search([('document_key', '=', chave)])
        # nfe_ids = p_xml.search([
            # ('document_type_id.code', '=', '55'),
            # ('state_edoc', '=', 'a_enviar'),
            # ('company_id', '=', empresa)
        # ])

        empresa_id = 1
        for prd in p_xml.browse(nfe_ids):
            chave = prd.document_key
            print(chave)
            existe = db.consulta_nfe(chave, empresa_id)
            #if existe:
            #    continue
            # prod_id = p_xml.search([('name', '=', prd.name)])
            xml = base64.b64decode(prd.send_file_id.datas).decode('iso-8859-1')
            arquivo = f"C:\home\{prd.send_file_id.name}"
            save_file = open(arquivo, 'w')
            save_file.write(xml)
            print ('id: %s , protocolo: %s ' % (xml ,prd.authorization_protocol))
            db.insert_nfe(dict(
                    move_id = prd.id,
                    empresa_id = prd.company_id.id,
                    xml_aenviar = xml,
                    chave = prd.document_key
                ))
            
#person = ConectaServer()            