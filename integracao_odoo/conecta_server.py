import requests as rq
import json
import os
import configparser
from datetime import datetime, timedelta
# from atscon import Conexao as con
from sqlite_bd import Database as local_db
# import numpy as np
# import pandas as pd
# from pandas import DataFrame, Series
import sqlite3 as db


class EnviaServer:

    def __init__(self, tipo):
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')
        self.path_envio  = cfg.get('INTEGRA', 'Path_envio')
        self.path_retorno  = cfg.get('INTEGRA', 'Path_retorno')
        self.url = cfg.get('INTEGRA', 'url')
        self.db = cfg.get('INTEGRA', 'db')
        self.login = cfg.get('INTEGRA', 'login')
        self.passwd = cfg.get('INTEGRA', 'password')

        # host = cfg.get('DATABASE', 'hostname' ),
        # db = cfg.get('DATABASE', 'database' ),

        # TODO path_retorno remover arquivos velhos
        # self.buscando_script()
        if tipo == "produto":
            self.buscando_produtos()
        if tipo == "cliente":
            self.buscando_clientes()
        if tipo == "pedido":
            self.lendo_arquivos()
        if tipo == "devolucao":
            self.lendo_arquivos()
        if tipo == "sangria":
            self.lendo_arquivos()

    def get_session(self, ):
        headers = {'Content-type': 'application/json'}
        AUTH_URL = "http://%s/web/session/authenticate" %(self.url)
        data = {
                "jsonrpc": "2.0",
                "params": {
                        "db": self.db,
                        "login": self.login,
                        "password": self.passwd,
                    }
                }  
        res = rq.get(AUTH_URL, data=json.dumps(data),headers=headers)
        session_id = res.cookies["session_id"]
        return session_id

    def enviando_arquivo(self, retorno, arq, file_name, session_id):
        parameter = {
                        "db": self.db,
                        "login": self.login,
                        "password": self.passwd,
                    }
        base_url = '%s/integrapdv' %(self.url)
        # base_url = "127.0.0.1:8072/api/v1/modules/" # your api 
        json_data = json.dumps(parameter)
        json_headers = {
            "Content-Type": "application/json",
            "Accept": "application/json",
            }
        cookies = {
            'login': self.login, 
            'password': self.passwd,
            'session_id':session_id
        }
        file_path = os.path.join(self.path_envio, file_name)
        arquivo = open(file_path, mode="r")
        vals = {}
        vals['params'] = json.load(arquivo)
        vals['tipo'] = arq
        json_data = json.dumps(vals)
        return rq.post("http://{}".format(base_url), data=json_data, headers=json_headers, cookies=cookies)
        
        # if not retorno:
        #     file_retorno = f"{self.path_retorno}/retorno.json"
        #     with open(file_retorno, mode="a") as arq_retorno:
        #         dados = json.loads(req.content)
        #         if len(dados['result']) > 2:
        #             arq_retorno.write(dados["result"])
        #         # dados = req.json()
        #         print(req.content)

    def buscando_produtos(self):
        # dblocal = local_db(filename = 'lancamento.db', table = 'lancamento')
        # conn = db.connect('lancamento.db')
        # cur_db = conn.cursor()
        headers = {'Content-type': 'application/json'}
        AUTH_URL = "http://%s/web/session/authenticate" %(self.url)
        data = {
                "jsonrpc": "2.0",
                "params": {
                        "db": self.db,
                        "login": self.login,
                        "password": self.passwd,
                    }
                }  
        parameter = {
                        "db": self.db,
                        "login": self.login,
                        "password": self.passwd,
                    }
        res = rq.get(AUTH_URL, data=json.dumps(data),headers=headers)
        session_id = res.cookies["session_id"]
        base_url = '%s/produtoconsulta' %(self.url)
        # base_url = "127.0.0.1:8072/api/v1/modules/" # your api 
        json_data = json.dumps(parameter)
        json_headers = {
            "Content-Type": "application/json",
            "Accept": "application/json",
            }
        cookies = {
            'login': self.login, 
            'password': self.passwd,
            'session_id':session_id
        }

        # arquivo = open(self.path_envio + '/' + file_name, mode="r")
        arquivo_json = os.path.join(self.path_envio, "produtos.json")
        vals = {}
        # vals['params'] = json.load(arquivo)
        # vals['tipo'] = arq
        json_data = json.dumps(vals)
        retorno = rq.post("http://{}".format(base_url), data=json_data, headers=json_headers, cookies=cookies)
        # hj = datetime.now()       
        # hj = datetime.strftime(hj,'%m-%d-%Y')
        if retorno:
            file_json = retorno.json()
            with open(arquivo_json, 'w', encoding='utf-8') as f:
                json.dump(file_json, f, ensure_ascii=False, indent=4)

            # for item in file_json.values():
            #     if item != None and len(item)>5:
            #         item_json = eval(item)
            #         # for dado in item_json:
            #         m_df = pd.DataFrame(item_json)
            #         # print(m_df)
            #         m_df.to_sql('produto', conn, if_exists='replace', index=False)

            #         
            #             ja_recebido = self.dblocal.consulta_nome(
            #                 'produto', 1, 9, dado['codproduto'], hj)
            #             if ja_recebido:
            #                 continue                    
            #             self.dblocal.insert(dict(
            #                 tipo = 'produto',
            #                 user = 1,
            #                 nome = dado['codproduto'],
            #                 caixa = 1,
            #                 codigo = 9,
            #                 data_lancamento = hj
            #             ))
            #             # Atualizar no banco de DADOS (firebird) ou fazer insert

    def buscando_clientes(self):
        # conn = db.connect('lancamento.db')
        headers = {'Content-type': 'application/json'}
        AUTH_URL = "http://%s/web/session/authenticate" %(self.url)
        data = {
                "jsonrpc": "2.0",
                "params": {
                        "db": self.db,
                        "login": self.login,
                        "password": self.passwd,
                    }
                }  
        parameter = {
                        "db": self.db,
                        "login": self.login,
                        "password": self.passwd,
                    }
        res = rq.get(AUTH_URL, data=json.dumps(data),headers=headers)
        session_id = res.cookies["session_id"]
        base_url = '%s/clienteconsulta' %(self.url)
        json_data = json.dumps(parameter)
        json_headers = {
            "Content-Type": "application/json",
            "Accept": "application/json",
            }
        cookies = {
            'login': self.login, 
            'password': self.passwd,
            'session_id':session_id
        }
        vals = {}
        json_data = json.dumps(vals)
        arquivo_json = os.path.join(self.path_envio, "clientes.json")
        retorno = rq.post("http://{}".format(base_url), data=json_data, headers=json_headers, cookies=cookies)
        if retorno:
            file_json = retorno.json()
            with open(arquivo_json, 'w', encoding='utf-8') as f:
                json.dump(file_json, f, ensure_ascii=False, indent=4)

            # for item in file_json.values():
            #     # print (item)
            #     if item != None and len(item)>5:
            #         item_json = eval(item)
            #         m_df = pd.DataFrame(item_json)
            #         # print(m_df)
            #         m_df.to_sql('cliente', conn, if_exists='replace', index=False)

    def lendo_arquivos(self):
        hj = datetime.now()       
        hj = datetime.strftime(hj,'%m-%d-%Y')
        # hoje = datetime.today()
        # name_file_controle = 'file_controle_pedido%s_%s.txt' %(str(hoje.day), str(hoje.month))
        # if os.path.exists(name_file_controle):
        #     ontem = datetime.today() - timedelta(days=1)
        #     old_file_name = 'file_controle_pedido%s_%s.txt' %(str(ontem.day-1), str(ontem.month))
        #     os.remove(old_file_name)

        dblocal = local_db(filename = 'lancamento.db', table = 'lancamento')
        # le arquivos na pasta
        arquivos = os.listdir(self.path_envio)
        # para cada arquivo na pasta
        # db = con.Conexao(host, db)
        get_return = False
        session_id = self.get_session()
        for i in arquivos:
            nome_arq = i[:i.index('.')]
            retorno_ids = []
            # print('Arquivo: %s' %(nome_arq)) 
            if nome_arq[:3] not in ('cai', 'ped', 'dev', 'san'):
                continue
            tipo = ''
            caixa = 0
            codigo = 0
            if nome_arq[:7] == 'pedido_' and 'codmovimento':
                tipo = 'pedido'
                codigo = nome_arq[nome_arq.find('-')+1:]
                caixa = nome_arq[7:nome_arq.find('-')]
            if nome_arq[:6] == 'caixa_' and 'caixa':
                tipo = 'sessao'
                caixa = nome_arq[6:]
            if nome_arq[:10] == 'devolucao_':
                tipo = 'devolucao'
                caixa = nome_arq[10:nome_arq.find('-')]
            if nome_arq[:8] == 'sangria_':
                tipo = 'sangria'
                caixa = nome_arq[8:nome_arq.find('-')]
            ja_enviado = dblocal.consulta(
                tipo, caixa, codigo)
            
            if ja_enviado:
                # os.remove(self.path_envio + '/' + i)
                file_remove = os.path.join(self.path_envio, i)
                os.remove(file_remove)
                continue

            if len(retorno_ids):
                enviado = False
                for arq in retorno_ids:
                    if nome_arq[:7] == 'pedido_' and 'codmovimento' in arq and nome_arq[7:] == arq['codmovimento']:
                        enviado = True

                    if nome_arq[:6] == 'caixa_' and 'caixa' in arq and nome_arq[6:] == arq['caixa']:
                        enviado = True

                    if nome_arq[:10] == 'devolucao_' and 'devolucao' in arq and nome_arq[10:] == arq['devolucao']:
                        enviado = True

                    if nome_arq[:8] == 'sangria_' and 'sangria' in arq and nome_arq[8:] == arq['sangria']:
                        enviado = True

                if not enviado and ((nome_arq[:6] == 'caixa_') or (nome_arq[:7] == 'pedido_') or (nome_arq[:10] == 'devolucao_') or (nome_arq[:8] == 'sangria_')):
                    get_return = self.enviando_arquivo(get_return, nome_arq[:3], i, session_id)

                if enviado and ((nome_arq[:6] == 'caixa_') or (nome_arq[:7] == 'pedido_') or (nome_arq[:10] == 'devolucao_') or (nome_arq[:8] == 'sangria_')):
                    # os.remove(self.path_envio + '/' + i)
                    file_remove = os.path.join(self.path_envio, i)
                    os.remove(file_remove)
            else:
                get_return = self.enviando_arquivo(get_return, nome_arq[:3], i, session_id)
                if tipo and caixa:
                    dblocal.insert(dict(
                            tipo = tipo,
                            user = 1,
                            nome = nome_arq,
                            caixa = caixa,
                            codigo = codigo,
                            data_lancamento = hj
                        ))
                # get_return = True
        if get_return:
            file_json = get_return.json()
            for item in file_json.values():
                # print('item %s:' %(item))
                if item != None and len(item)>5:
                    item_json = json.loads(json.dumps(eval(eval(item))))
                    for z in item_json:
                        codigo = 0
                        if 'name' in z:
                            name = z['name']
                        if 'codmovimento' in z:
                            codigo = z['codmovimento']
                            codigo = codigo[codigo.find('-')+1:]
                            name = z['order_id']
                        ja_enviado = dblocal.consulta(
                            z['tipo'], z['caixa'], codigo)
            
                        if ja_enviado:
                            continue
                        dblocal.insert(dict(
                            tipo = z['tipo'],
                            user = z['user_id'],
                            nome = name,
                            caixa = z['caixa'],
                            codigo = codigo,
                            data_lancamento = hj
                        ))
