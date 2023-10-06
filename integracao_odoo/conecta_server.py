import requests as rq
import json
import os
import configparser

parameter = {
    "db": "felicita14",
    "login": "ats@atsti.com.br",
    "password": "a2t00s7",
}

cfg = configparser.ConfigParser()
cfg.read('conf.ini')
path_envio  = cfg.get('INTEGRA', 'Path_envio')
path_retorno  = cfg.get('INTEGRA', 'Path_retorno')

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
base_url = '%s/pedidoconsulta' %(url)
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

# lê arquivos na pasta
arquivos = os.listdir(path_envio)
# import pudb;pu.db
# para cada arquivo na pasta
for i in arquivos:
    nome_arq = i[:i.index('.')]   
    arquivo = open(path_envio + '/' + i, mode="r")
    vals = {}
    arquivo_retorno = open(path_retorno, mode="w+")
    # TODO precisa ver se o arquivo nao esta no arquivo retorno
    # se estiver nao precisa mandar
    if not arquivo in (arquivo_retorno.read()):
        vals['params'] = json.load(arquivo)
        json_data = json.dumps(vals)
        req = rq.post("http://{}".format(base_url), data=json_data, headers=json_headers, cookies=cookies)
    # import pudb;pu.db
    
    
    dados = json.loads(req.content)
    arquivo_retorno.write(dados["result"])
    dados = req.json()
    # arquivo_retorno.w
    print(req.content)
    # TODO  recebe do servidor a lista dos arquivos, e remove daqui