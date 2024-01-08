# -*- coding: utf-8 -*-
import odoorpc
import os
import logging
from logging.handlers import RotatingFileHandler
from datetime import datetime
import base64
from sqlite_bd import Database as local_db
import configparser
from pathlib import Path


_logger = logging.getLogger(__name__)
Path('logs').mkdir(parents=True, exist_ok=True) # Create folder if not exists
handlers = [ RotatingFileHandler(filename='logs/log.txt',
            mode='w', 
            maxBytes=512000, 
            backupCount=4)
           ]
logging.basicConfig(handlers=handlers, 
                    level=logging.INFO, 
                    format='%(levelname)s %(asctime)s %(message)s', 
                    datefmt='%d/%m/%Y%I:%M:%S %p')

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
        empresa = '2'
        self.pega_xml(int(empresa))
        self.retorna_xml_validado('2')

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
            ('company_id', '=', int(empresa))
        ])

        arquivo = f"{self.path_retorno}/notas"
        # Check whether the specified path exists or not
        isExist = os.path.exists(arquivo)
        if not isExist:
            # Create a new directory because it does not exist
            os.makedirs(arquivo)
        for prd in p_xml.browse(nfe_ids):
            chave = prd.document_key
            existe = db.consulta_nfe(chave, empresa)
            if existe:
                continue
            xml = base64.b64decode(prd.send_file_id.datas).decode('iso-8859-1')
            arquivo_name = f"{arquivo}/{prd.send_file_id.name}"
            save_file = open(arquivo_name, 'w')
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

    def retorna_xml_validado(self, empresa):
        _logger.info('Iniciando envio para o odoo')
        con = self._conexao_odoo()
        db = local_db(filename = 'lancamento.db', table = 'nfe')
        notas_empresa = db.consulta_nfe('', int(empresa), 5)

        if not notas_empresa:
            _logger.info('Sem notas para enviar')
            return
        for nota in notas_empresa:
            if nota['situacao'] == 'A_enviar':
                continue
            # confirma situacao no odoo 
            n_xml = con.env['account.move']
            # chave = '35xxxxxxxxxxx8550010000093411523728494'
            # nfe_ids = p_xml.search([('document_key', '=', chave)])
            nfe_ids = n_xml.search([
                ('document_type_id.code', '=', '55'),
                ('document_key', '=', nota['chave']),
                ('company_id', '=', int(empresa))
            ])
            import pudb;pu.db
            if not nfe_ids:
                continue
            nfe = n_xml.browse(nfe_ids)
            if nota['situacao_odoo'] in ('enviada','cancelada'):
                if nfe.state_edoc in ('autorizada', 'cancelada', 'denegada', 'inutilizada'):
                    continue
            if not nfe.authorization_file_id:
                file_name = f"{nota['chave']}-nfe.xml"
                arquivo = f"{self.path_retorno}/xml/{file_name}"
                xml_file = open(arquivo, 'r')
                # envia o xml para o Odoo e altera a situacao
                event_id = nfe.event_ids.create_event_save_xml(
                    company_id=nfe.company_id,
                    environment=(
                        'prod' if nfe.nfe_environment == "1" else 'hml'
                    ),
                    event_type="0",
                    xml_file=xml_file.read(),
                    document_id=nfe,
                )
                nfe.authorization_event_id = event_id
                # attach = self.env["ir.attachment"]
                # file_name = f"{nota[chave]}-proc-env.xml"
                # attach.create({
                #     "name": file_name,
                #     "res_model": "l10n_br_fiscal.event:n",
                #     "res_id": self.id,
                #     "datas": base64.b64encode(file.encode("utf-8")),
                #     "mimetype": "application/" + file_extension,
                #     "type": "binary",
                # })
                # muda a situacao_odoo                
                situacao = ''
                if nota['situacao'] == 'Autorizada':
                    situacao = 'autorizada'
                    nfe.write({'state_edoc': situacao,})
                

ConectaServerNFe()