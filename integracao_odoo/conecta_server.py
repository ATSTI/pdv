import requests as rq
import json
import os
import re
import configparser
import pandas as pd
from atscon import Conexao as con

parameter = {
    "db": "felicita14",
    "login": "ats@atsti.com.br",
    "password": "a2t00s7",
}

cfg = configparser.ConfigParser()
cfg.read('conf.ini')
path_envio  = cfg.get('INTEGRA', 'Path_envio')
path_retorno  = cfg.get('INTEGRA', 'Path_retorno')
# host = cfg.get('DATABASE', 'hostname' ),
# db = cfg.get('DATABASE', 'database' ),

# TODO path_retorno remover arquivos velhos


headers = {'Content-type': 'application/json'}
url = 'felicita14.atsti.com.br:49069'
AUTH_URL = "http://%s/web/session/authenticate" %(url)
data = {
        "jsonrpc": "2.0",
        "params": {
                "db": parameter['db'],
                "login": parameter['login'],
                "password": parameter['password']
            }
        }  
res = rq.get(AUTH_URL, data=json.dumps(data),headers=headers)
session_id = res.cookies["session_id"]
base_url = '%s/integrapdv' %(url)
# base_url = "127.0.0.1:8072/api/v1/modules/" # your api 
json_data = json.dumps(parameter)
json_headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    }
cookies = {
    'login': parameter['login'], 
    'password': parameter['password'],
    'session_id':session_id
}

def enviando_arquivo(retorno, arq):
    # import pudb;pu.db
    arquivo = open(path_envio + '/' + i, mode="r")
    vals = {}
    vals['params'] = json.load(arquivo)
    vals['tipo'] = arq
    json_data = json.dumps(vals)
    req = rq.post("http://{}".format(base_url), data=json_data, headers=json_headers, cookies=cookies)
    # import pudb;pu.db
    if not retorno:
        file_retorno = f"{path_retorno}/retorno.json"
        with open(file_retorno, mode="w+") as arq_retorno:
            dados = json.loads(req.content)
            if len(dados['result']) > 2:
                arq_retorno.write(dados["result"])
            # dados = req.json()
            print(req.content)


# lê arquivos na pasta
arquivos = os.listdir(path_envio)
# para cada arquivo na pasta
# db = con.Conexao(host, db)
get_return = False

for i in arquivos:
    nome_arq = i[:i.index('.')]
    # if nome_arq[:3] == 'cai':
    #     import pudb;pu.db
    retorno_ids = []
    # file_retorno = f"{path_retorno}/{nome_arq[:3]}_retorno.json"
    file_retorno = f"{path_retorno}/retorno.json"
    if os.path.exists(file_retorno) and os.stat(file_retorno).st_size > 0:
        x = open(file_retorno,'r')
        # data = [json.loads(line) for line in open(path_retorno,'r')]
        # arquivo_retorno = x.read()
        # le json 
        retorno_ids = json.loads(json.dumps(eval(json.loads(x.read()))))

    print('QQQQQQQQQQQQQQ: %s' %(nome_arq))
    if ((nome_arq[:3] != 'cai') and (nome_arq[:3] != 'ped')):
        continue
    if len(retorno_ids):
        # import pudb;pu.db
        enviado = False
        for arq in retorno_ids:
            if nome_arq[:7] == 'pedido_' and 'codmovimento' in arq and nome_arq[7:] == arq['codmovimento']:
                enviado = True

            if nome_arq[:6] == 'caixa_' and 'caixa' in arq and nome_arq[6:] == arq['caixa']:
                enviado = True

            # arquivo_retorno = pd.read_csv(path_retorno, delimiter=" ", header = None).to_dict()[0]
            # dados_json = arquivo_retorno.read()
            # TODO precisa ver se o arquivo nao esta no arquivo retorno
            # se estiver nao precisa mandar

            # if nome_arq[7:] in arquivo_retorno:
            # arq['codmovimento']:
        if not enviado and ((nome_arq[:6] == 'caixa_') or (nome_arq[:7] == 'pedido_')):
            # import pudb;pu.db
            enviando_arquivo(get_return, nome_arq[:3])
            get_return = True
        if enviado and ((nome_arq[:6] == 'caixa_') or (nome_arq[:7] == 'pedido_')):
            # sql_t = 'UPDATE movimento SET codmovrateio = %s WHERE codmovimento = %s' %()
            os.remove(path_envio + '/' + i)
    else:
        # import pudb;pu.db
        enviando_arquivo(get_return, nome_arq[:3])
        get_return = True