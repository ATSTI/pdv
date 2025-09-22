# -*- coding: utf-8 -*-
import odoorpc
import os
import logging
from logging.handlers import RotatingFileHandler
from datetime import datetime
import base64
import configparser
from pathlib import Path
from glob import iglob
from os.path import getmtime
from nfelib.nfe_evento_cancel.bindings.v1_0.evento_canc_nfe_v1_00 import Evento as Cancel


_logger = logging.getLogger(__name__)
Path('logs').mkdir(parents=True, exist_ok=True) # Create folder if not exists
handlers = [ RotatingFileHandler(filename='logs/log_cancel.txt',
            mode='w', 
            maxBytes=512000, 
            backupCount=4)
           ]
logging.basicConfig(handlers=handlers, 
                    level=logging.INFO, 
                    format='%(levelname)s %(asctime)s %(message)s', 
                    datefmt='%d/%m/%Y%I:%M:%S %p',force=True)
_logger.setLevel(logging.INFO)


class ConectaServerNFeCancela():
    _name = 'conecta.server.nfe.cancela'

    def __init__(self, funcao_exec='PEGA_XML', empresa='999999'):
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')
        self.path_retorno  = cfg.get('INTEGRA', 'Path_retorno')
        self.url = cfg.get('INTEGRA', 'url')
        self.db = cfg.get('INTEGRA', 'db')
        self.porta = cfg.get('INTEGRA', 'porta')
        self.login = cfg.get('INTEGRA', 'login')
        self.passwd = cfg.get('INTEGRA', 'password')

    def _conexao_odoo(self):
        origem = odoorpc.ODOO(self.url, port=self.porta)
        origem.login(self.db, self.login, self.passwd)
        return origem

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
                        _logger.info(f"Evento de Cancelamento criado com sucesso, nota: {nfe.document_number}")
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
                        "state": "cancel",
                        "state_fiscal": state,
                        "state_edoc": "cancelada"
                    })
                    _logger.info(f"Situacao evento Cancelamento alterada com sucesso, NFe: {str(nfe.document_number)}")
            else:
                break