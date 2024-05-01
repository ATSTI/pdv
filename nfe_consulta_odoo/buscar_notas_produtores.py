import psycopg2
import configparser
import requests as rq
import json
from datetime import datetime
from datetime import timedelta


# db = ['freitas, jpagronegocios']
cfg = configparser.ConfigParser()
cfg.read('conf.ini')
lista_databases = cfg.get('INTEGRA', 'lista_database')
hostname = cfg.get('INTEGRA', 'hostname')
login = cfg.get('INTEGRA', 'login')
passwd = cfg.get('INTEGRA', 'password')
url_envio = cfg.get('DESTINO', 'url')
db_envio = cfg.get('DESTINO', 'db')
login_envio = cfg.get('DESTINO', 'user')
passwd_envio = cfg.get('DESTINO', 'password')

def enviando_arquivo(notas):
    headers = {'Content-type': 'application/json'}
    AUTH_URL = "http://%s/web/session/authenticate" %(url_envio)
    data = {
            "jsonrpc": "2.0",
            "params": {
                    "db": db_envio,
                    "login": login_envio,
                    "password": passwd_envio,
                }
            }  
    parameter = {
                    "db": db_envio,
                    "login": login_envio,
                    "password": passwd_envio,
                }
    res = rq.get(AUTH_URL, data=json.dumps(data),headers=headers)
    session_id = res.cookies["session_id"]
    base_url = '%s/nfe' %(url_envio)
    # base_url = "127.0.0.1:8072/api/v1/modules/" # your api 
    json_data = json.dumps(parameter)
    json_headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        }
    cookies = {
        'login': login_envio, 
        'password': passwd_envio,
        'session_id':session_id
    }
    vals = {}
    vals['params'] = notas
    json_data = json.dumps(vals)
    rq.post("http://{}".format(base_url), data=json_data, headers=json_headers, cookies=cookies)

date_today = datetime.now()
mes_inicio = date_today.replace(day=1, hour=23, minute=59, second=0, microsecond=0)
mes_fim = mes_inicio - timedelta(days=1)
mes_inicio = mes_fim.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
# criando json com nf emitidas
num_nota = 0
notas = {}
for db in lista_databases.split():
    conn = psycopg2.connect(
        host=hostname,
        port=5432,
        dbname=db,
        user=login,
        password=passwd
    )

    cur = conn.cursor()
    sql_nf = "SELECT d.document_number, d.operation_name, d.document_date, d.company_id, rc.name, rp.cnpj_cpf \
        FROM l10n_br_fiscal_document d, res_company rc, res_partner rp \
        where rc.id = d.company_id and rp.id = rc.partner_id and d.document_type = '55' \
        and d.edoc_purpose = '1' and d.state_edoc = 'autorizada' \
        and d.document_date BETWEEN '%s' and '%s' \
        ORDER BY d.id ASC " %(mes_inicio, mes_fim)
    cur.execute(sql_nf)
    rows = cur.fetchall()
    for row in rows:
        num_nota += 1
        data_nf = row[2].strftime('%Y-%m-%d %H:%M:%S')
        notas[num_nota] = {
            "numero": row[0],
            "operacao": row[1],
            "nota_data": data_nf,
            "empresa_nome": row[4],
            "empresa_cnpj": row[5],
        }
if num_nota > 0:
    enviando_arquivo(notas)


