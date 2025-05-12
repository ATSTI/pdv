# -*- coding: utf-8 -*-
import odoorpc
import os
import logging
from logging.handlers import RotatingFileHandler
from datetime import datetime
import base64
import configparser
from pathlib import Path
from atscon import Conexao as con_fdb
import locale
from glob import iglob
from os.path import getmtime
from nfelib.nfe.bindings.v4_0.proc_nfe_v4_00 import NfeProc
# from nfelib.nfe_evento_cancel.bindings.v1_0.evento_canc_nfe_v1_00 import Evento as Cancel


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
        # empresa = '1'
        # funcao_exec = 'PEGA_XML'
        # uso TESTE
        
        # funcao_exec = 'ENVIA_AUTORIZADA'
        #if funcao_exec == 'PEGA_XML':
        #    self.pega_xml(int(empresa))
        #if funcao_exec == 'ENVIA_AUTORIZADA':
        #    self.retorna_xml_validado(int(empresa))
        #    # else:
        #    self.pega_xml(int(empresa))

    def _conexao_odoo(self):
        origem = odoorpc.ODOO(self.url, port=self.porta)
        origem.login(self.db, self.login, self.passwd)
        return origem

    def consulta_nfe(self, db=None, chave=None, empresa_id=None, limit=50):
        if not empresa_id:
            # bloqueia a busca sem informar a empresa
            empresa_id = 1
        busca = "select first %s num_nfe, situacao, data_alteracao, chave from nfe " %(str(limit))
        busca += " where empresa_id = %s " %(str(empresa_id))
        if chave:
            busca += " and chave like '%s'" %(chave)
        busca += " order by chave desc "
        dados = db.query(busca)
        if not dados:
            _logger.info(f"NFe/NFCe : {str(chave)} NAO existe.")
            return False
        ultima_modificacao = datetime.now()
        for item in dados:
            situacao = item[1]
            # coloquei o limit > 5 pq qdo consulta pra enviar para o odoo nao pode exluir
            if situacao == 'A_enviar' and item[2] != ultima_modificacao:
                arquivo = os.path.join(self.path_retorno, item[0]+"-proc-env.xml")
                exclui = False
                if os.path.exists(arquivo):
                    nfe_proc = NfeProc.from_path(arquivo)
                    try:
                        nProt = nfe_proc.protNFe.infProt.nProt
                        edita = "UPDATE FROM nfe SET situacao = 'Autorizada', protocolo = '%s' WHERE empresa_id = %s and num_nfe = %s" %(
                            str(nProt),
                            str(empresa_id),
                            item[0]
                        )
                        db.execute(edita)
                    except:
                        exclui = True
                # if exclui:
                #     excluir = "DELETE FROM nfe WHERE empresa_id = %s and num_nfe = %s" %(
                #         str(empresa_id),
                #         item[0]
                #     )
                #     db.execute(excluir)
                # continue
        return dados

    def pega_xml(self, empresa):
        try:
            db = con_fdb()
        except:
            msg = u'Caminho ou nome do banco invalido.<br>'
            _logger.info(msg)
        msg = 'Buscando no Odoo NFe para empresa: %s' %(str(empresa))
        # print (msg)
        _logger.info(msg)
        con = self._conexao_odoo()
        p_xml = con.env['account.move']
        # chave = '35xxxxxxxxxxx8550010000093411523728494'
        # nfe_ids = p_xml.search([('document_key', '=', chave)])
        # ('state_edoc', '=', 'a_enviar'),
        
        nfe_ids = p_xml.search([   
            ('document_type_id.code', 'in', ('55', '65')),
            ('state_edoc', '!=', 'em_digitacao'),
            ('company_id', '=', int(empresa))
        ], limit=10, order="id desc")
        #print(nfe_ids)
        if not nfe_ids:
            _logger.info(f"Sem NFe para a empresa: {str(empresa)}")
        _logger.info(f"ID da fatura no Odoo: {str(nfe_ids)}")
        arquivo = os.path.join(self.path_retorno, "notas")
        # Check whether the specified path exists or not
        isExist = os.path.exists(arquivo)
        if not isExist:
            # Create a new directory because it does not exist
            os.makedirs(arquivo)

        # db = local_db(filename = 'lancamento.db', table = 'nfe')
        # existe_notas = db.consulta_nfe(chave='', empresa_id=empresa, limit=50)
        existe_notas = self.consulta_nfe(db=db, chave='', empresa_id=empresa, limit=50)
        _logger.info(f"Retorno existe notas: {str(existe_notas)}")
        
        notas_sistema = set()
        if existe_notas:
            for nf in existe_notas:
                # if nf[3] in notas_sistema:
                #     USADO PRA LIMPAR SUJEIRA
                #     excluir = "DELETE FROM nfe WHERE empresa_id = %s and chave = '%s'" %(
                #             int(empresa),
                #             str(nf[3])
                #         )
                #     db.execute(excluir)
                notas_sistema.add(nf[3])

        for prd in p_xml.browse(nfe_ids):
            _logger.info(f" Lendo xml ID {str(prd)}")
            chave = prd.document_key
            _logger.info(f" Chave xml {chave}")
            # _logger.info(f"NFe: {str(chave)}")
            if prd.authorization_file_id:
                _logger.info(f" Entrou no IF  file autorization_id ")
                arquivo_name = os.path.join(arquivo, prd.authorization_file_id.name)
                xml_data = prd.authorization_file_id.datas
                xml_name = prd.authorization_file_id.name
                _logger.info(f" File autorization_id {xml_name}")
                xml_protocolo = prd.authorization_protocol
                xml_situacao = "Autorizada"
            elif prd.send_file_id:
                arquivo_name = os.path.join(arquivo, prd.send_file_id.name)
                xml_data = prd.send_file_id.datas
                xml_name = prd.send_file_id.name
                _logger.info(f" send_file_id {xml_name}")
                xml_protocolo = ""
                xml_situacao = "A_enviar"
            else:
                _logger.info(f" Nenhuma das opcoes")
                continue
            # existe = db.consulta_nfe(chave, empresa)

            # xml = base64.b64decode(prd.send_file_id.datas).decode('iso-8859-1')
            try:
                locale.setlocale(locale.LC_ALL, "Portuguese_Brazil.1252")
            except:
                locale.setlocale(locale.LC_ALL, 'pt_BR.utf8')

            xml = base64.b64decode(xml_data).decode()
            arquivo_name = os.path.join(arquivo, xml_name)

            # EVITO SOBRESCREVER ARQUIVO JA ENVIADO
            # vou verificar se existe o arquivo local e se tem protocolo
            if Path(arquivo_name).is_file():
                # verificar se xml tem protocolo
                nfe_proc = NfeProc.from_path(arquivo_name)
                try:
                    nProt = nfe_proc.protNFe.infProt.nProt
                    continue
                except:
                    sem_protocolo = True
            with open(arquivo_name, 'w') as save_file:
                save_file.write(xml)
            _logger.info(f"Arquivo {str(arquivo_name)} criado.")
            if prd.authorization_protocol:
                _logger.info(f"Chave: {chave}, protocolo: {prd.authorization_protocol}")
            emissao = datetime.strftime(prd.document_date,'%Y-%m-%d')

            if chave in notas_sistema:
                _logger.info(f"NFe : {str(chave)} ja existe.")
                continue            
            # file_binary = fdb.binary(xml)
            # data_tuple = (1, file_binary)
            data_fb = datetime.strftime(prd.write_date,'%Y.%m.%d, %H:%M:%S.0000')
            sql = "insert into nfe (move_id, empresa_id, xml_aenviar, chave, destinatario, \
                num_nfe, data_emissao, situacao, data_alteracao, protocolo) values ('%s', %s, \
                '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" %(
                    str(prd.id), str(prd.company_id.id), xml, prd.document_key, 
                    prd.partner_id.name, prd.document_number, emissao, xml_situacao, data_fb, xml_protocolo)
            db.execute(sql)

    def consulta_nfe_autorizada(self, db=None, chave=None, limit=50):
        busca = "select first %s move_id, num_nfe, situacao, chave, empresa_id, data_alteracao from nfe " %(str(limit))
        busca += " WHERE situacao = 'Autorizada' AND situacao_odoo is null"
        if chave:
            busca += " AND chave like '%s'" %(chave)
        busca += " order by move_id desc "
        dados = db.query(busca)
        if not dados:
            _logger.info(f"NFe/NFCe : {str(chave)} NAO existe.")
            return False
        else:
            _logger.info(f"NFe/NFCe : {str(chave)} existe na base.")
            return dados

    # def retornar_notas_canceladas(self, empresa):
    #     try:
    #         db = con_fdb()
    #     except:
    #         msg = u'Caminho ou nome do banco invalido.<br>'
    #         _logger.info(msg)        
    #     busca = "select first 5 move_id, num_nfe, situacao, chave, empresa_id, data_alteracao from nfe "
    #     busca += " WHERE situacao = 'Cancelada' AND empresa_id = %s" %(empresa)
    #     busca += " order by move_id desc "
    #     dados = db.query(busca)
    #     if not dados:
    #         return False
    #     else:
    #         con = self._conexao_odoo()
    #         n_xml = con.env['account.move']
    #         for nf in dados:
    #             nfe_ids = n_xml.search([
    #                 ('document_key', '=', nf[3]),
    #                 ('state_edoc', '!=', 'cancelada')
    #             ])
    #             if not nfe_ids:
    #                 # _logger.info(f"NFe nao encontrada no odoo {nota[3]}")
    #                 _logger.info(f"NFe ja atualizada odoo {nf[3]}")
    #                 continue
    #             for nfe in n_xml.browse(nfe_ids):
    #                 atualiza = {'state_edoc': 'cancelada'}
    #                 nfe.write(atualiza)
    #                 _logger.info(f"Situacao alterada com sucesso, NFe: {str(nfe.document_number)}")
    #         return True

    def retorna_notas_canceladas(self, empresa):
        _logger.info('Enviando Cancelamento para o odoo')
        arquivo = os.path.join(self.path_retorno, "eventos", '110111*.xml')
        # lendo o diretorio e pegando somente os ultimos 5 cancelamentos
        files = iglob(arquivo)
        sorted_files = sorted(files, key=getmtime, reverse=True)
        num_arquivo = 1
        con = self._conexao_odoo()
        n_xml = con.env['account.move']
        for xml_arquivo in sorted_files:
            # pega so os ultimos 5 arquivos
            if num_arquivo < 6:
                num_arquivo += 1
                # print(xml_arquivo)
                cancel_ret = Cancel.from_path(xml_arquivo)
                # cancel_ret = parser.parse(xml_arquivo, Evento)
                try:
                    cancel_ret.retEvento.infEvento.tpEvento
                except:
                    continue
                chave = cancel_ret.retEvento.infEvento.chNFe
                protocolo = cancel_ret.retEvento.infEvento.nProt
                motivo = cancel_ret.evento.infEvento.detEvento.xJust
                cStat = cancel_ret.retEvento.infEvento.cStat
                if cStat not in ("135", "155"):
                    continue
                if cStat == "135":
                    state = "02"
                else:
                    state = "03"

                nfe_ids = n_xml.search([
                    ('document_key', '=', chave),
                    ('state_edoc', '=', 'autorizada'),
                    ('company_id', '=', empresa)
                ])
                if not nfe_ids:
                    _logger.info(f"NFe nao localizada no odoo: {chave}")
                    continue
                for nfe in n_xml.browse(nfe_ids):
                    event = con.env['l10n_br_fiscal.event']
                    cce = event.search([
                        ('protocol_number', '=', protocolo),
                        ('document_id', '=', nfe.fiscal_document_id.id),
                        ('type', '=', '2')
                    ])
                    if cce:
                        continue
                   
                    environment='prod' if nfe.nfe_environment == "1" else 'hml'
                    vals = {
                        "company_id": nfe.company_id.id,
                        "environment": environment,
                        "type": "2",
                        "document_id": nfe.fiscal_document_id.id,
                        "document_type_id": nfe.document_type_id.id,
                        "document_serie_id": nfe.document_serie_id.id,
                        "document_number": nfe.document_number
                    }                   
                    event_ids = event.create(vals)
                    event_id = event.browse(event_ids)
                    if event_id:
                        _logger.info(f"Evento da CCe criado com sucesso, nota: {nfe.document_number}")
                    attach = con.env["ir.attachment"]
                    file_name = chave + "-proc-env.xml"
                    xml_file = open(xml_arquivo, 'r')
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
                    dt_protocol = cancel_ret.retEvento.infEvento.dhRegEvento
                    dt_protocol = datetime.strptime(dt_protocol, '%Y-%m-%dT%H:%M:%S%z')
                    dt_protocol = dt_protocol.strftime('%Y-%m-%d %H:%M:%S')
                    event_id.write(
                        {
                                "state": "done",
                                "status_code": cStat,
                                "response": "Evento registrado e vinculado a NF-e",
                                "protocol_date": dt_protocol,
                                "protocol_number": protocolo,
                                "justification": motivo,
                            }
                        )
                    nfe.write({
                        "state_fiscal": state,
                        "state_edoc": "cancelada"
                    })
                    _logger.info(f"Situacao evento CCe alterada com sucesso, NFe: {str(nfe.document_number)}")
            else:
                break

    def retorna_xml_validado(self, empresa):
        _logger.info('Iniciando envio para o odoo')
        # protocolocanc
        self.retorna_notas_canceladas(empresa)
        arquivo = os.path.join(self.path_retorno, "notas", '*.xml')
        # 07/05/2024 lendo o diretorio e pegando somente os ultimos 5 autorizados
        files = iglob(arquivo)
        sorted_files = sorted(files, key=getmtime, reverse=True)
        num_arquivo = 1
        con = self._conexao_odoo()
        n_xml = con.env['account.move']
        for xml_arquivo in sorted_files:
            # pega so os ultimos 5 arquivos
            if num_arquivo < 6:
                num_arquivo += 1
                # print(xml_arquivo)
                try:
                    nfe_proc = NfeProc.from_path(xml_arquivo)
                    chave = nfe_proc.NFe.infNFe.Id[3:]
                except:
                    _logger.info(f"Erro arquivo {xml_arquivo}")
                    continue
                nProt = nfe_proc.protNFe.infProt.nProt
                # nfe_proc.protNFe.infProt.chNFe
                # confirma situacao no odoo 
                
                # chave = '35xxxxxxxxxxx8550010000093411523728494'
                nfe_ids = n_xml.search([
                    ('document_key', '=', chave),
                    ('state_edoc', '=', 'a_enviar')
                ])
                # nfe_ids = n_xml.search([
                #     ('id', 'in', list(lista_id)),
                #     ('state_edoc', '=', 'a_enviar')
                # ])
                if not nfe_ids:
                    # _logger.info(f"NFe nao encontrada no odoo {nota[3]}")
                    _logger.info(f"NFe ja atualizada odoo {chave}")
                    continue
                for nfe in n_xml.browse(nfe_ids):
                    if not nfe.authorization_file_id:
                        file_name = f"NFe{chave}-env.xml"
                        # envia o xml para o Odoo e altera a situacao
                        environment='prod' if nfe.nfe_environment == "1" else 'hml'
                        vals = {
                            "company_id": nfe.company_id.id,
                            "environment": environment,
                            "type": "0",
                            "document_id": nfe.fiscal_document_id.id,
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
                        file_name = chave + "-proc-env.xml"
                        xml_file = open(xml_arquivo, 'r')
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
                        #tree = ET.parse(arquivo)
                        #root = tree.getroot()
                        #try:
                        #    protNFe = root.find('{http://www.portalfiscal.inf.br/nfe}protNFe')
                        #    infProt = protNFe.find('{http://www.portalfiscal.inf.br/nfe}infProt')
                        #    nProt = infProt.find('{http://www.portalfiscal.inf.br/nfe}nProt')
                        #    protocol_date = infProt.find('{http://www.portalfiscal.inf.br/nfe}dhRecbto')
                        # dt_protocol = protocol_date.text
                        dt_protocol = nfe_proc.protNFe.infProt.dhRecbto
                        dt_protocol = dt_protocol.to_datetime()
                        # dt_protocol = datetime.fromisoformat(dt_protocol)
                        dt_protocol = dt_protocol.strftime('%Y-%m-%d %H:%M:%S')
                        event_id.write(
                            {
                                    "state": "done",
                                    "status_code": "100",
                                    "response": "Autorizado o uso da NF-e",
                                    "protocol_date": dt_protocol,
                                    "protocol_number": nProt,
                                }
                            )
                        atualiza = {'authorization_event_id': event_id.id}
                        # muda a situacao no odoo
                        # situacao = ''
                        # if nota[2] == 'Autorizada':
                        # situacao = 'autorizada'
                        atualiza['state_edoc'] = 'autorizada'
                        atualiza['xml_error_message'] = False
                        atualiza['file_report_id'] = False
                        nfe.write(atualiza)
                        # muda situacao_odoo bd local
                        # sql_update = "update nfe set situacao_odoo = 'enviada' where chave = '%s' \
                        # and empresa_id = %s" %(nota[3], nota[4])
                        #db.execute(sql_update)
                        _logger.info(f"Situacao alterada com sucesso, NFe: {str(nfe.document_number)}")
                        # except:
                            # _logger.info(f"ERRO lendo protocolo no XML, NFe: {str(nfe.document_number)}")
            else:
                break

# ConectaServerNFe(empresa=3)