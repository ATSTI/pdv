# -*- coding: utf-8 -*-
import odoorpc
import os
import logging
from logging.handlers import RotatingFileHandler
from datetime import datetime
import base64
import configparser
from pathlib import Path
import xml.etree.ElementTree as ET
from atscon import Conexao as con_fdb
import fdb


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
                    datefmt='%d/%m/%Y%I:%M:%S %p',force=True)
_logger.setLevel(logging.INFO)


class ConectaServerNFe():
    _name = 'conecta.server.nfe'

    def __init__(self, funcao_exec='PEGA_XML', empresa='999999'):
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')
        self.path_retorno  = cfg.get('INTEGRA', 'Path_retorno')
        self.url = cfg.get('INTEGRA', 'url')
        self.db = cfg.get('INTEGRA', 'db')
        self.porta = cfg.get('INTEGRA', 'porta')
        self.login = cfg.get('INTEGRA', 'login')
        self.passwd = cfg.get('INTEGRA', 'password')
        # empresa = int('999999') # ao executar o script substitui pelo id da empresa
        # uso TESTE
        # empresa = '3'
        # funcao_exec = 'PEGA_XML'
        # uso TESTE
        # funcao_exec = 'ENVIA_AUTORIZADA'
        #if funcao_exec == 'PEGA_XML':
            # self.retorna_xml_validado(int(empresa))
            # else:
        #    self.pega_xml(int(empresa))

    def _conexao_odoo(self):
        origem = odoorpc.ODOO(self.url, port=self.porta)
        origem.login(self.db, self.login, self.passwd)
        return origem

    def consulta_nfe(self, db=None, chave=None, empresa_id=None, limit=50):
        if not empresa_id:
            # bloqueia a busca sem informar a empresa
            empresa_id = 1
        busca = "select first %s num_nfe, situacao, data_alteracao from nfe " %(str(limit))
        busca += " where empresa_id = %s " %(str(empresa_id))
        if chave:
            busca += " and chave like '%s'" %(chave)
        busca += " order by num_nfe desc "
        dados = db.query(busca)
        if not dados:
            return False
        list_accumulator = []

        ultima_modificacao = datetime.now()
        for item in dados:
            situacao = item[1]
            # coloquei o limit > 5 pq qdo consulta pra enviar para o odoo nao pode exluir
            if situacao == 'A_enviar' and item[2] != ultima_modificacao:
                excluir = "DELETE FROM nfe WHERE empresa_id = %s and num_nfe = %s" %(
                    str(empresa_id),
                    item[0]
                )
                db.execute(excluir)
                continue
            list_accumulator.append({k: item[k] for k in item.keys()})
        if len(list_accumulator):
            return list_accumulator
        else:
            return False

    def pega_xml(self, empresa):
        try:
            db = con_fdb()
        except:
            msg = u'Caminho ou nome do banco inválido.<br>'
            _logger.info(msg)
        msg = 'Buscando no Odoo NFe para empresa: %s' %(str(empresa))
        # print (msg)
        _logger.info(msg)
        con = self._conexao_odoo()
        p_xml = con.env['account.move']

        # chave = '35xxxxxxxxxxx8550010000093411523728494'
        # nfe_ids = p_xml.search([('document_key', '=', chave)])
        nfe_ids = p_xml.search([
            ('document_type_id.code', '=', '55'),
            ('state_edoc', '=', 'a_enviar'),
            ('company_id', '=', int(empresa))
        ])
        # if not nfe_ids:
        #     _logger.info(f"Sem NFe para a empresa: {str(empresa)}")
        arquivo = f"{self.path_retorno}/notas"
        # Check whether the specified path exists or not
        isExist = os.path.exists(arquivo)
        if not isExist:
            # Create a new directory because it does not exist
            os.makedirs(arquivo)

        # db = local_db(filename = 'lancamento.db', table = 'nfe')
        # existe_notas = db.consulta_nfe(chave='', empresa_id=empresa, limit=50)
        existe_notas = self.consulta_nfe(db=db, chave='', empresa_id=empresa, limit=50)
        
        notas_sistema = set()
        if notas_sistema:
            for nf in existe_notas:
                notas_sistema.add(nf['chave'])

        for prd in p_xml.browse(nfe_ids):
            chave = prd.document_key
            # _logger.info(f"NFe: {str(chave)}")
            arquivo_name = f"{arquivo}/{prd.send_file_id.name}"
            if Path(arquivo_name).is_file():
                # verificar se xml tem protocolo
                arquivo_protocol = arquivo_name
                try:
                    tree = ET.parse(arquivo_protocol)
                    root = tree.getroot()
                    protNFe = root.find('{http://www.portalfiscal.inf.br/nfe}protNFe')
                    if protNFe:
                        _logger.info(f"NFe com protocolo : {str(chave)}")
                        continue
                except:
                    _logger.info(f"Erro para ler xml")
                    arquivo_protocol = ''
            # existe = db.consulta_nfe(chave, empresa)
            if chave in notas_sistema:
                _logger.info(f"NFe : {str(chave)} ja existe.")
                continue
            xml = base64.b64decode(prd.send_file_id.datas).decode('iso-8859-1')
            arquivo_name = f"{arquivo}/{prd.send_file_id.name}"
            save_file = open(arquivo_name, 'w')
            save_file.write(xml)
            _logger.info(f"Arquivo {str(arquivo_name)} criado.")
            if prd.authorization_protocol:
                _logger.info(f"Chave: {chave}, protocolo: {prd.authorization_protocol}")
            emissao = datetime.strftime(prd.document_date,'%Y-%m-%d')
            
            file_binary = fdb.binary(xml)
            data_tuple = (1, file_binary)
            data_fb = datetime.strftime(prd.write_date,'%Y.%m.%d, %H:%M:%S.0000')
            sql = "insert into nfe (move_id, empresa_id, xml_aenviar, chave, destinatario, \
                num_nfe, data_emissao, situacao, data_alteracao) values ('%s', %s, \
                '%s', '%s', '%s', '%s', '%s', '%s', '%s')" %(
                    str(prd.id), str(prd.company_id.id), data_tuple, prd.document_key, 
                    prd.partner_id.name, prd.document_number, emissao, 'A_enviar', data_fb)
            db.execute(sql)

    def consulta_nfe_autorizada(self, db=None, chave=None, limit=50):
        busca = "select first %s move_id, num_nfe, situacao, chave, empresa_id, data_alteracao from nfe " %(str(limit))
        busca += " WHERE situacao = 'Autorizada' AND situacao_odoo is null"
        if chave:
            busca += " AND chave like '%s'" %(chave)
        busca += " order by move_id desc "
        dados = db.query(busca)
        if not dados:
            return False
        else:
            return dados

    def retorna_xml_validado(self, empresa):
        _logger.info('Iniciando envio para o odoo')
        con = self._conexao_odoo()
        try:
            db = con_fdb()
        except:
            msg = u'Caminho ou nome do banco inválido.<br>'
            _logger.info(msg)
        notas_empresa = self.consulta_nfe_autorizada(db=db, limit=50)
        # nao usando a classe sqlite_bd aqui erro database locked
        if not notas_empresa:
            _logger.info('Sem notas para enviar')
        else:
            # montando lista com o move_id das notas
            lista_id = set()
            for nota in notas_empresa:
                lista_id.add(nota[0])            

            for nota in notas_empresa:
                if nota[2] == 'A_enviar':
                    continue
                # confirma situacao no odoo 
                n_xml = con.env['account.move']
                # chave = '35xxxxxxxxxxx8550010000093411523728494'
                # nfe_ids = p_xml.search([('document_key', '=', chave)])
                nfe_ids = n_xml.search([
                    ('id', 'in', list(lista_id)),
                    ('state_edoc', '=', 'a_enviar')
                ])
                if not nfe_ids:
                    _logger.info(f"NFe nao encontrada no odoo {nota[3]}")
                    continue
                for nfe in n_xml.browse(nfe_ids):
                    # if nota['situacao_odoo'] in ('enviada','cancelada'):
                        # if nfe.state_edoc in ('autorizada', 'cancelada', 'denegada', 'inutilizada'):
                            # continue
                    if not nfe.authorization_file_id:
                        file_name = f"NFe{nota[3]}-env.xml"
                        arquivo = f"{self.path_retorno}/notas/{file_name}"
                        xml_file = open(arquivo, 'r')
                        # envia o xml para o Odoo e altera a situacao
                        environment='prod' if nfe.nfe_environment == "1" else 'hml'
                        vals = {
                            "company_id": nfe.company_id.id,
                            "environment": environment,
                            "type": "0",
                            "document_id": nfe.id,
                            "document_type_id": nfe.document_type_id.id,
                            "document_serie_id": nfe.document_serie_id.id,
                            "document_number": nfe.document_number
                        }
                        event = con.env['l10n_br_fiscal.event']
                        event_ids = event.create(vals)
                        event_id = event.browse(event_ids)
                        if event_id:
                            _logger.info(f"Evento criado com sucesso NFe: {nfe.document_number}")
                        attach = con.env["ir.attachment"]
                        file_name = f"{nota[3]}-proc-env.xml"
                        att_file = attach.create({
                            "name": file_name,
                            "res_model": "l10n_br_fiscal.event",
                            "res_id": event_id.id,
                            "datas": base64.b64encode(xml_file.read().encode("utf-8")).decode(),
                            "mimetype": "application/xml",
                            "type": "binary",
                        })
                        # event_id.file_response_id = False
                        event_id.file_response_id = att_file
                        tree = ET.parse(arquivo)
                        root = tree.getroot()
                        try:
                            protNFe = root.find('{http://www.portalfiscal.inf.br/nfe}protNFe')
                            infProt = protNFe.find('{http://www.portalfiscal.inf.br/nfe}infProt')
                            nProt = infProt.find('{http://www.portalfiscal.inf.br/nfe}nProt')
                            protocol_date = infProt.find('{http://www.portalfiscal.inf.br/nfe}dhRecbto')
                            dt_protocol = protocol_date.text
                            dt_protocol = datetime.fromisoformat(dt_protocol)
                            dt_protocol = dt_protocol.strftime('%Y-%m-%d %H:%M:%S')
                            event_id.write(
                                {
                                    "state": "done",
                                    "status_code": "100",
                                    "response": "Autorizado o uso da NF-e",
                                    "protocol_date": dt_protocol,
                                    "protocol_number": nProt.text,
                                }
                            )
                            atualiza = {'authorization_event_id': event_id.id}
                            # muda a situacao no odoo
                            situacao = ''
                            if nota[2] == 'Autorizada':
                                situacao = 'autorizada'
                                atualiza['state_edoc'] = situacao
                            nfe.write(atualiza)
                            # muda situacao_odoo bd local
                            sql_update = "update nfe set situacao_odoo = 'enviada' where chave = '%s' \
                                and empresa_id = %s" %(nota[3], nota[4])
                            db.execute(sql_update)
                            _logger.info(f"Situação alterada com sucesso, NFe: {str(nfe.document_number)}")
                        except:
                            _logger.info(f"ERRO lendo protocolo no XML, NFe: {str(nfe.document_number)}")

# ConectaServerNFe(empresa=3)