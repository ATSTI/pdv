# -*- coding:utf-8 -*-

from datetime import datetime
from datetime import timedelta
import logging
import unicodedata
import re
import time
import os
import json
import base64
import configparser
from main import Main as verifica_versao
from atscon import Conexao as con
from conecta_server import EnviaServer as envia
from sqlite_bd import Database as local_db
from pathlib import Path
from logging.handlers import RotatingFileHandler


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
                    datefmt='%d/%m/%Y %I:%M:%S %p',force=True)
_logger.setLevel(logging.INFO)



class IntegracaoOdoo:
    _name = 'integracao.odoo'
    
    def _inicia(self, tipo='geral'):
        # _logger.info("verificando versao")
        verifica_versao()
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')
        self.path_envio  = cfg.get('INTEGRA', 'path_envio')
        self.path_retorno = cfg.get('INTEGRA', 'path_retorno' )
        # self.host = cfg.get('DATABASE', 'hostname')
        # self.db = cfg.get('DATABASE', 'path')
        # tipo = '1-executa_tudo'
        #tipo = 'executa_produto'
        #print("Tipo : %s" %('teste tetetstet'))
        # _logger.info (f'Tipo - {tipo}')
        self.caixa_user = cfg.get('INTEGRA', 'caixa_user')
        # if tipo == 'executa_tudo':
        # self._executando(tipo)
        # if tipo == 'executa_produto':
        #     print ("Atualizando produtos.")
        #     _logger.info('Atualizando produtos')
        #     envia('produto')
        #     self.action_atualiza_produtos()
        # # self.action_devolucao()
        _logger.info ('Cursor liberado')

    def _executando_venda(self, tipo='geral'):
        # rodou = 1
        # print(tipo)
        if tipo == 'geral':
            # while(True):
            if tipo == 'geral':
                # Cria o ARQUIVO JSON dos Pedidos para ser enviado
                # msg = "Iniciando atualizacoes - %s" %(str(rodou))
                msg = "Iniciando atualizacoes"
                _logger.info(msg)
                print("Atualizando vendas ...")
                self.action_atualiza_vendas()
                # # Cria o ARQUIVO JSON dos Caixas para ser enviado
                # if rodou == 1 or rodou % 10 == 0:
                #     _logger.info ('Caixa atualizando.')
                #     self.action_atualiza_caixas()
                #     # ESTA SENDO FEITO DIRETO NO PDV usando o main
                #     # _logger.info ('Atualiza devolucoes.')
                #     # self.action_devolucao()
                _logger.info ('Enviando pedidos.')
                envia("pedido")
                # # Busca alteracoes dos produtos e grava no database local para ser comparado com o BD do PDV
                # if rodou == 1 or rodou % 5 == 0:
                #    _logger.info ('Produto atualizando.')
                #    envia("produto")
                #    # Compara as ataulizacoes do produto com o BD do PDV e atualiza ou insere se necessario
                #    self.action_atualiza_produtos()
                # _logger.info("Rodou : %s vezes" %(rodou))
                # if rodou == 1 or rodou % 4 == 0:
                #     _logger.info ('Cliente atualizando.')
                #     envia("cliente")
                #     self.action_atualiza_clientes()
                # rodou += 1
                # time.sleep(600)
        # elif tipo == 'produto':
        #     print ("Atualizando produtos.")
        #     envia("produto")
        #     # Compara as ataulizacoes do produto com o BD do PDV e atualiza ou insere se necessario
        #     self.action_atualiza_produtos()
        # elif tipo == 'cliente':
        #     print ("Atualizando Clientes.")
        #     envia("cliente")
        #     self.action_atualiza_clientes()
        # elif tipo == 'caixa':
        #     print ("Atualizando Caixa.")
        #     self.action_atualiza_caixas(None)
        return True

    def _executando(self, tipo='geral'):
        rodou = 1
        # print(tipo)
        if tipo == 'geral':
            while(True):
                # if tipo == 'geral':
                # Cria o ARQUIVO JSON dos Pedidos para ser enviado
                # msg = "Iniciando atualizacoes - %s" %(str(rodou))
                msg = "Iniciando atualizacoes"
                _logger.info(msg)
                print("Atualizando vendas ...")
                self.action_atualiza_vendas()
                # # Cria o ARQUIVO JSON dos Caixas para ser enviado
                if rodou == 1 or rodou % 10 == 0:
                    _logger.info ('Caixa atualizando.')
                    self.action_atualiza_caixas()
                    # ESTA SENDO FEITO DIRETO NO PDV usando o main
                    _logger.info ('Atualiza devolucoes.')
                    self.action_devolucao()
                _logger.info ('Enviando pedidos.')
                envia("pedido")
                # # Busca alteracoes dos produtos e grava no database local para ser comparado com o BD do PDV
                if rodou == 1 or rodou % 5 == 0:
                   _logger.info ('Produto atualizando.')
                   envia("produto")
                   # Compara as ataulizacoes do produto com o BD do PDV e atualiza ou insere se necessario
                   self.action_atualiza_produtos()
                _logger.info("Rodou : %s vezes" %(rodou))
                if rodou == 1 or rodou % 4 == 0:
                    _logger.info ('Cliente atualizando.')
                    envia("cliente")
                    self.action_atualiza_clientes()
                print("Rodou : %s vezes" %(rodou))
                rodou += 1
                time.sleep(600)
        # elif tipo == 'produto':
        #     print ("Atualizando produtos.")
        #     envia("produto")
        #     # Compara as ataulizacoes do produto com o BD do PDV e atualiza ou insere se necessario
        #     self.action_atualiza_produtos()
        # elif tipo == 'cliente':
        #     print ("Atualizando Clientes.")
        #     envia("cliente")
        #     self.action_atualiza_clientes()
        # elif tipo == 'caixa':
        #     print ("Atualizando Caixa.")
        #     self.action_atualiza_caixas(None)
        return True

    """
    A remoco de acentos foi baseada em uma resposta no Stack Overflow.
    http://stackoverflow.com/a/517974/3464573
    """
    def removerAcentosECaracteresEspeciais(self, palavra):

        # Unicode normalize transforma um caracter em seu equivalente em latin.
        nfkd = unicodedata.normalize('NFKD', palavra)
        palavraSemAcento = u"".join([c for c in nfkd if not unicodedata.combining(c)])

        # Usa expressao regular para retornar a palavra apenas com numeros, letras e espaco
        return re.sub('[^a-zA-Z0-9]', ' ', palavraSemAcento)    

    def action_atualiza_caixas(self):
        self._inicia()
        try:
            # db = con.Conexao(self.host, self.database)
            db = con()
        except:
            msg_sis = u'Caminho ou nome do banco invalido. '
        msg_erro = ''
        #breakpoint()
        print('Atualizando Caixa.')
        hj = datetime.now()
        hj = hj - timedelta(days=5)
        hj = datetime.strftime(hj,'%Y-%m-%d')
        executando_msg = ""
        # sessao_ids = self.env['pos.session'].search([
        #     ('create_date', '>=', hj),   
        #     ('state','=','opened')
        #     ])
        #('state','=','opened')
        # for ses in sessao_ids:
        
            # TODO trocar os numeros abaixo pelas variaveis
            #user_temp = 11
            #sess_temp = 4564
            # num_sessao = int(session.name[len(ses.name)-4:])
            # num_sessao = ses.id
        sqlp = "SELECT IDCAIXACONTROLE \
                ,CODCAIXA, CODUSUARIO, SITUACAO, DATAFECHAMENTO \
                ,NOMECAIXA, DATAABERTURA FROM CAIXA_CONTROLE \
                WHERE DATAABERTURA > '%s' \
                AND CODUSUARIO = %s" %(hj, self.caixa_user)
        sess = db.query(sqlp)
        for ses in sess:
            nomecli = ses[5]
            nomecli = self.removerAcentosECaracteresEspeciais(nomecli)
            vals = {}
            vals['user_id'] = ses[2]
            vals['name'] = ses[5]
            vals['caixa'] = ses[1]
            # vals['config_id'] = ses.config_id.id
            data_abertura = "%s 20:00:00" %(ses[6])
            vals['start_at'] = data_abertura
            if ses[3] == 'o':
                vals['state'] = 'draft'
                arquivo_nome = self.path_envio + '/caixa_%s.json' %(ses[1])
            elif ses[3] == 'F':
                vals['state'] = 'closed'
                arquivo_nome = self.path_envio + '/caixaf_%s.json' %(ses[1])
            if os.path.exists(arquivo_nome):
                continue
            arquivo_json = open(arquivo_nome, 'w+')
            dados_vals = json.dumps(vals)
            arquivo_json.write(dados_vals)
            executando_msg += " Caixa enviando : " + arquivo_nome
        sqlp = "SELECT f.CAIXA, f.CODFORMA, f.COD_VENDA, \
            f.VALOR_PAGO, f.N_DOC FROM FORMA_ENTRADA f, CAIXA_CONTROLE c \
            WHERE c.CODCAIXA = f. CAIXA and DATAABERTURA > '%s' \
            and f.COD_VENDA = 1 AND CODUSUARIO = %s" %(hj, self.caixa_user)
        sess_ids = db.query(sqlp)
        amount = 0.0
        for sess in sess_ids:
            cod_caixa = sess[0]
            cod_forma = sess[1]
            cod_venda = sess[2]
            valor = sess[3] or 0.0
            if not valor:
                continue
            motivo = sess[4]
            motivo = self.removerAcentosECaracteresEspeciais(motivo)
            if int(cod_caixa) != sess[0]:
                continue
            if int(cod_venda) == 1:
                amount = -valor
            else:
                amount = valor

            lancamento = 'Caixa-%s-%s' %(cod_caixa, cod_forma)
            vals = {
                        'date': hj,
                        'amount': amount,
                        'ref': lancamento,
                        'motivo': motivo,
                        'tipo': 'san',
                        'name': str(cod_forma),
                        'caixa': cod_caixa,
                        'cod_venda': cod_venda,
                        'user_id': self.caixa_user,
            }
            arquivo_nome = self.path_envio + '/sangria_%s.json' %(cod_forma)
            if os.path.exists(arquivo_nome):
                continue
            arquivo_json = open(arquivo_nome, 'w+')
            dados_vals = json.dumps(vals)
            arquivo_json.write(dados_vals)
            executando_msg += " Caixa lancamento : " + arquivo_nome
        if executando_msg:
            print(executando_msg)
        else:
            print("CAIXA sem atualizacao.")

    def cron_integra_produtos(self):
        self.action_atualiza_produtos()

    def action_integra_produtos(self):
        # se nao for no pos enviar email com as msg_erro
        self.msg_integracao = self.action_atualiza_produtos(self)

    def action_atualiza_produtos(self):
        self._inicia()
        envia("produto")
        db = con()
        _logger.info("Integrando PRODUTOS para o PDV")
        #import pudb;pu.db
        # hj = datetime.now()
        # data_limpa = hj - timedelta(days=5)
        # # hj = datetime.strftime(hj,'%Y-%m-%d')
        # data_limpa = data_limpa.day
        # # limpa produtos antigos atualizados
        # sql_delete = "delete from produto where CAST(substr(DataCadastro, 4, 2) AS INTEGER) < %s" %(str(data_limpa))
        # # print (sql_delete)
        # dblocal = local_db(filename = 'lancamento.db', table = 'lancamento')
        # dblocal.delete_produto(sql_delete)     
        # prod_novo = dblocal.consulta_produto()

        # 09/05/2024 parei de usar o sqlite usando um arquivo em json
        arquivo_json = os.path.join(self.path_envio, "produtos.json")
        try:
            f = open(arquivo_json)
        except:
            return
        produto_arquivo = json.load(f)
        
        prod_novo = json.loads(produto_arquivo['result'])
        # for t in qa:
        #     print(str(t['codproduto']) + '-' + t['produto'])
        incluido = 0
        alterado = 0
        #breakpoint()
        if not prod_novo:
            _logger.info("Sem produtos pra atualizar")
            return False
        for pr in prod_novo:
            codproduto = pr['codproduto']
            ncm = ''
            if 'ncm' in pr and pr['ncm']:
                ncm = pr['ncm']
                if ncm:
                    ncm = re.sub('[^0-9]', '', ncm)
            if ncm and len(ncm) > 8:
                ncm = '00000000'
            p_custo = 0.0
            if 'custo' in pr and pr['custo']:
                p_custo = pr['custo']
            p_venda = 0.00
            if 'valor_prazo' in pr and pr['valor_prazo']:
                p_venda = pr['valor_prazo']
            codbarra = ''
            if 'cod_barra' in pr and pr['cod_barra'] and len(pr['cod_barra']) < 14:
                codbarra = pr['cod_barra'].strip()
            produto = pr['produto'].strip()
            produto = produto.replace("'"," ")
            try:
                produto = self.removerAcentosECaracteresEspeciais(produto)
            except:
                produto = produto
            produto = produto.replace("'","")
            codp = str(pr['codproduto'])

            sqlp = "select FIRST 1 CODPRODUTO,\
                    DATACADASTRO, VALOR_PRAZO from produtos \
                    where codproduto = %s" %(str(codproduto))
            print(sqlp)
            prods = db.query(sqlp)
            if pr['codpro']:
                codpro = pr['codpro'].strip()
            if not len(prods) and pr['codpro']:
                sqlp = "select FIRST 1 CODPRODUTO,\
                    DATACADASTRO, VALOR_PRAZO from produtos \
                    where codpro = \'%s\'" %(codpro)
                prods = db.query(sqlp)

            # serve pra identificar se usa o pdv_integracao ou o pdv_integracao_outros
            if 'tipo_venda' in pr:
                if not os.path.exists('promocao'):
                    os.makedirs('promocao')
                promo_jpg = f"promocao{codpro}.jpg"
                promo_txt = f"promocao{codpro}.txt"
                img_sql = ''
                if pr['promocao_jpg']:
                    img_sql = promo_jpg
                    if not os.path.exists(promo_jpg):
                        imagem = pr['promocao_jpg']
                        imagem_dec = base64.b64decode(imagem)
                        with open(promo_jpg, 'wb') as f:
                            f.write(imagem_dec)
                else:
                    if os.path.exists(promo_jpg):
                        os.remove(promo_jpg)
                if pr['promocao_txt']:
                    img_sql = promo_txt
                    if not os.path.exists(promo_txt):
                        with open(promo_txt, 'w') as f:
                            f.write(pr['promocao_txt'])
                else:
                    if os.path.exists(promo_txt):
                        os.remove(promo_txt)

            #sqlp = 'select codproduto from produtos where codpro like \'%s\'' %(codp+'%')
            if codbarra:
                # 03/10/2022 limpando o codigo de barra qdo ja existe  
                sql_bar = 'select codpro from produtos where cod_barra = \'%s\' AND CODPRODUTO <> \'%s\'' %(codbarra, codproduto)
                barra = db.query(sql_bar)
                if len(barra):
                    _logger.info("Limpando codigo de barras, se existir outro item %s - %s-%s" %(codbarra,codpro,produto)) 
                    up_bar = 'UPDATE PRODUTOS SET COD_BARRA = NULL WHERE COD_BARRA = \'%s\' AND CODPRODUTO <> \'%s\'' %(codbarra, codproduto)
                    for sess_bar in barra:
                        cod_p_barra = str(sess_bar[0])
                        if str(codpro) == cod_p_barra:
                            up_bar = ''
                    if len(barra) and up_bar:
                        db.insert(up_bar)
            #prods = db.query(sqlp)
            #print ('TESTE - %s' %(product_id.name))
            data_cad = '2023/01/01 01:00:00'
            if len(prods):
                data_cad = datetime.strftime(prods[0][1],'%Y/%m/%d %H:%M:%S')
            data_nova = pr['datacadastro']
            data_nova = datetime.strptime(data_nova,'%m/%d/%Y %H:%M:%S')
            data_fb = datetime.strftime(data_nova,'%Y.%m.%d, %H:%M:%S.0000')
            data_nova = datetime.strftime(data_nova,'%Y/%m/%d %H:%M:%S')
            origem = '0'
            if 'origem' in pr and pr['origem']:
                    origem = str(pr['origem'])
            tipo_venda = '1'
            if 'tipo_venda' in pr and pr['tipo_venda']:
                    tipo_venda = str(pr['tipo_venda'])
            qtdeatacado = '0.0'
            if 'qtdeatacado' in pr and pr['qtdeatacado']:
                    qtdeatacado = str(pr['qtdeatacado'])
            precoatacado = '0.0'
            if 'precoatacado' in pr and pr['precoatacado']:
                    precoatacado = str(pr['precoatacado'])
            if not len(prods) and pr['usa'] == 'S':
                incluido += 1
                _logger.info("Inserindo item : %s-%s" %(codpro,produto))
                print ('Incluindo - %s' %(produto))
                #sqlp = 'select codproduto from produtos where codpro like \'%s\'' %(codp+'%')

                #prodsa = db.query(sqlp)					
                #if len(prodsa):
                #    if product_id.default_code:
                #        codp = product_id.default_code + '(%s)' %(str(len(prodsa)+1))
                #if len(codp) > 14:
                #    codp = str(product_id.id) 
                #print ('Incluindo - %s-%s' %(str(product_id.id),product_id.name))
                un = pr['unidademedida'][:2]
                
                insere = 'INSERT INTO PRODUTOS (UNIDADEMEDIDA, PRODUTO, PRECOMEDIO, CODPRO,\
                          TIPOPRECOVENDA, ORIGEM, NCM, VALORUNITARIOATUAL, VALOR_PRAZO, TIPO, RATEIO, \
                          QTDEATACADO, PRECOATACADO, DATACADASTRO, CODPRODUTO'
                if 'tipo_venda' in pr and img_sql:
                    insere += ', FOTOPRODUTO'
                if codbarra:
                    insere += ', COD_BARRA'

                insere += ') VALUES ('
                insere += '\'' + un + '\''
                insere += ', \'' + produto + '\''
                insere += ', ' + str(p_custo)
                insere += ', \'' + str(codpro) + '\''
                insere += ',\'F\''
                insere += ',' + origem
                insere += ',\'' + str(ncm) + '\''
                insere += ', ' + str(p_custo)
                insere += ',' + str(round(p_venda,2))
                insere += ',\'' + str('PROD') + '\''
                insere += ', \'' + tipo_venda + '\''
                insere += ',' + qtdeatacado
                insere += ',' + precoatacado
                insere += ', \'' + data_fb + '\''
                insere += ',' + str(codproduto)
                if 'tipo_venda' in pr and img_sql:
                    insere += ',' + img_sql                
                if codbarra:
                    insere += ', \'' + str(codbarra) + '\''
                insere += ')'
                # try:
                retorno = db.insert(insere)
                if retorno:
                    print ('ERRRRRRRRRRRRROOOOOOOOOOOO : ' + codp + '-' + produto)
                    _logger.info("SQL erro: %s" %(retorno))
                print (codp+'-'+produto)
                # TODO tratar isso e enviar email
            elif len(prods):
                alterado += 1
                print(data_cad + ' - ' + data_nova)
                if data_cad == data_nova and round(prods[0][2],2) == round(p_venda,2):
                    _logger.info("Item ja atualizado: %s-%s" %(codpro, produto))
                    print("Item ja atualizado: %s-%s" %(codpro, produto))
                    continue
                _logger.info("Atualizando item: %s-%s" %(codpro, produto))
                print("Atualizando item: %s-%s" %(codpro, produto))
                ativo = 'S'
                codprox = pr['codpro']
                if pr['usa'] != 'S':
                    ativo = 'N'
                    codbarra = ''
              
               
                altera = 'UPDATE PRODUTOS SET PRODUTO = '
                altera += '\'' + produto + '\''
                altera += ', VALOR_PRAZO = ' + str(round(p_venda, 2))
                altera += ', NCM = ' +  '\'' + str(ncm) + '\''
                altera += ', CODPRO = ' +  '\'' + str(codprox) + '\''
                altera += ', ORIGEM = ' + origem 
                altera += ', USA = \'' + ativo + '\''  
                altera += ', RATEIO = \'' + tipo_venda + '\''
                altera += ', QTDEATACADO = ' + qtdeatacado 
                altera += ', PRECOATACADO = ' + precoatacado
                altera += ', DATACADASTRO = \'' + data_fb + '\''
                if 'tipo_venda' in pr and img_sql:
                    altera += ', FOTOPRODUTO = \'' + img_sql + '\''
                if codbarra:
                    altera += ', COD_BARRA = \'' + str(codbarra) + '\''
                #altera += ' WHERE CODPRO = \'' + str(pr['codpro']) + '\''
                altera += ' WHERE CODPRODUTO = ' + str(codproduto)
                #print(altera)
                #breakpoint()
                retorno = db.insert(altera)
                if retorno:
                    print ('SQL : %s' %(altera))
                    print ('**** ERRO **** : %s' %(retorno))
                    _logger.info("SQL erro : %s" %(retorno))
        msg = ""
        if incluido:
            msg += " -Incluido: " + str(incluido)
        if alterado:
            msg += " -Alterado: " + str(alterado)
        print("Atualizacao produto executada. " + msg)
        _logger.info("Atualizacao do produto executada com sucesso.")
        return True

    def cron_integra_clientes(self):
        session_ids = self.env['pos.session'].search([
                ('state', '=', 'opened')])
        for ses in session_ids:
             self.action_atualiza_clientes(ses, False)

    def action_integra_clientes(self):
        # se nao for no pos enviar email com as msg_erro
        self.msg_integracao = self.action_atualiza_clientes(self, False)

    def action_atualiza_clientes(self):
        self._inicia()
        envia("cliente")
        # try:
        db = con()
        #     dblocal = local_db(filename = 'lancamento.db', table = 'cliente')
        # except:
        #     msg_sis = u'Caminho ou nome do banco invalido. '
        msg_erro = ''
        msg_sis = 'Integrando Clientes para o PDV '
        print("Atualizando clientes.")
        incluido = 0
        alterado = 0
        hj = datetime.now()
        hj = datetime.strftime(hj,'%Y-%m-%d')
        # cli_ids = dblocal.consulta_cliente()
        arquivo_json = os.path.join(self.path_envio, "clientes.json")
        try:
            f = open(arquivo_json)
        except:
            return
        cliente_arquivo = json.load(f)
        
        cli_novo = json.loads(cliente_arquivo['result'])

        if not cli_novo:
            print('Sem clientes pra atualizar')
            return
        for partner_id in cli_novo:
            nome = partner_id['nomecliente']
            nome = self.removerAcentosECaracteresEspeciais(nome)
            razao = nome  
            sqlc = 'select codcliente, datacadastro from clientes where codcliente = %s' %(partner_id['codcliente'])
            cli = db.query(sqlc)
            if len(cli):
                alterado += 1
                data_cad = '2023/01/01 01:00:00'
                if len(cli):
                    data_cad = datetime.strftime(cli[0][1],'%Y-%m-%d')
                if data_cad == hj:
                    continue
                altera =  "UPDATE CLIENTES SET STATUS = 0 \
                    ,NOMECLIENTE = \'%s\', DATACADASTRO = \'%s\'  \
                    WHERE CODCLIENTE = %s" %(nome, hj, str(partner_id['codcliente']))
                retorno = db.insert(altera )
                if retorno:
                    msg_erro += 'ERRO : %s ' %(retorno)
            if not len(cli):
                incluido += 1
                tipo = partner_id['tipofirma']
                vendedor = partner_id['codusuario']
                ie = 'Null'
                fiscal = 'J'
                regiao = partner_id['regiao']
                insere = 'insert into clientes (\
                            CODCLIENTE, NOMECLIENTE, RAZAOSOCIAL,\
                            TIPOFIRMA,CNPJ, INSCESTADUAL,\
                            SEGMENTO, REGIAO, LIMITECREDITO,\
                            DATACADASTRO, CODUSUARIO, STATUS, CODBANCO, CODFISCAL)\
                            values (%s, \'%s\', \'%s\',\
                            %s, \'%s\',\'%s\',\
                            %s, %s, %s,\
                            %s, %s, %s, %s, \'%s\')'\
                            %(str(partner_id['codcliente']), nome, razao, \
                            tipo, partner_id['cnpj'], ie,\
                            '1', regiao, '0.0',\
                            'current_date', vendedor, '1', '1', fiscal)
                retorno = db.insert(insere)
                if retorno:
                    msg_erro += 'ERRO : %s ' %(retorno)                
                
                #buscar Cidade/UF/Pais
                ibge = 'Null'
                cidade = 'Artur Nogueira'
                uf = 'SP'
                pais = 'Br'
                endereco = 'Rua x'
                bairro = 'centro'
                complemento = 'Null'
                cep = '123'
                email = 'fulano@gmail.com'
                obs = 'Null'
                numero = '413'
                inserir = 'INSERT INTO ENDERECOCLIENTE (CODENDERECO, \
                          CODCLIENTE, LOGRADOURO, BAIRRO, COMPLEMENTO,\
                          CIDADE, UF, CEP, TELEFONE, TELEFONE1, TELEFONE2,\
                          E_MAIL, TIPOEND,\
                          DADOSADICIONAIS, DDD, DDD1, DDD2,\
                          NUMERO, CD_IBGE, PAIS) VALUES ('
                inserir += str(partner_id['codcliente'])
                inserir += ',' + str(partner_id['codcliente'])
                if endereco != 'Null':
                    inserir += ', \'%s\'' %(str(endereco.encode('ascii', 'ignore')))
                else:
                    inserir += ', Null'
                if bairro != 'Null':
                    inserir += ', \'%s\'' % (str(bairro.encode('ascii', 'ignore')))
                else:
                    inserir += ', Null'
                if complemento != 'Null':
                    inserir += ', \'%s\'' % (str(complemento.encode('ascii', 'ignore')))
                else:
                    inserir += ', Null'
                if cidade != 'Null':
                    inserir += ', \'%s\'' % (str(cidade.encode('ascii', 'ignore')))
                else:
                    inserir += ', Null'
                if uf != 'Null':
                    inserir += ', \'%s\'' % (str(uf))
                else:
                    inserir += ', Null'
                if cep != 'Null':
                    inserir += ', \'%s\'' % (cep)
                else:
                    inserir += ', Null'
                if email != 'Null':
                    inserir += ', \'%s\'' % (email)
                else:
                    inserir += ', Null'
                inserir += ', 0' # tipoEnd
                if obs != 'Null':
                    inserir += ', \'%s\'' % (str(obs.encode('ascii', 'ignore')))
                else:
                    inserir += ', Null'
                if numero != 'Null':
                    inserir += ', \'%s\'' % (numero)
                else:
                    inserir += ', Null'
                if ibge != 'Null':
                    inserir += ', \'%s\'' % (ibge)
                else:
                    inserir += ', Null'
                if pais != 'Null':
                    inserir += ', \'%s\');' % (pais)
                else:
                    inserir += ', Null);'
                
                retorno = db.insert(inserir)
                if retorno:
                    msg_erro += 'ERRO : %s ' %(retorno)
            else:
                regiao = partner_id['regiao']
                altera =  'UPDATE CLIENTES SET REGIAO = %s \
                    ,NOMECLIENTE = \'%s\', STATUS = 1 \
                    WHERE CODCLIENTE = %s' %(regiao, nome, str(partner_id['codcliente']))
                retorno = db.insert(altera )
                if retorno:
                    msg_erro += 'ERRO : %s ' %(retorno)
        msg = ""
        if incluido:
            msg += " -Incluido: " + str(incluido)
        if alterado:
            msg += " -Alterado: " + str(alterado)       
        msg_sis += 'Integracao Clientes finalizada. ' + msg
        print('Integracao Clientes finalizada. ' + msg)
        return  msg_sis + ' ' + msg_erro

    def cron_integra_recebidos(self):
        session_ids = self.env['pos.session'].search([
                ('state', '=', 'opened')])
        for ses in session_ids:
            if self.verifica_se_esta_rodando(ses):
                ses.integracao_andamento = datetime.strftime(datetime.now(),'%Y-%m-%d %H:%M:%S')
                self.action_atualiza_recebidos(ses)

    def action_integra_recebidos(self):
        self._inicia()
        # se nao for no pos enviar email com as msg_erro
        #if self.verifica_se_esta_rodando(self):
        #    self.integracao_andamento = datetime.strftime(datetime.now(),'%Y-%m-%d %H:%M:%S')
        self.msg_integracao = self.action_atualiza_recebidos(self)
        #else:
        #    raise UserError(
        #            u'Ja existe Atualizacao em Andamento, aguarde.')
        
    def action_atualiza_recebidos(self, session):
        self._inicia()
        try:
            if session.config_id.ip_terminal:
                db = con.Conexao(session.config_id.ip_terminal, session.config_id.database)
            else:
                return False
        except:
            msg_sis = u'Caminho ou nome do banco invalido. '
        msg_erro = ''
        msg_sis = 'Integrando Contas a Receber para o PDV '
        hj = datetime.now()
        hj = hj - timedelta(days=session.periodo_integracao+10)
        hj = datetime.strftime(hj,'%Y-%m-%d %H:%M:%S')
        # se dois bds, entao preciso verificar se o contas a receber esta correto
        order_ids = self.env['pos.order'].search([
            ('state','=', 'invoiced'),
            ('date_order','>',hj),
        ])
        # repeti a variavel hj aqui, pq acima tem horas, minutos
        hj = datetime.now()
        hj = hj - timedelta(days=session.periodo_integracao)
        hj = datetime.strftime(hj,'%Y-%m-%d')
        
        for odr in order_ids:
            #verifico se existe no contas a receber
            codmov = odr.pos_reference[odr.pos_reference.find('-')+1:]
            #codcaixa = odr.pos_reference[:odr.pos_reference.find('-')]
            codcaixa = odr.session_id.id
            sqld = 'SELECT r.CODRECEBIMENTO, r.CODCLIENTE, r.STATUS FROM RECEBIMENTO r \
                    LEFT OUTER JOIN VENDA v ON r.CODVENDA = v.CODVENDA \
                    WHERE r.CODCLIENTE = %s AND r.CODALMOXARIFADO = %s \
                    AND ((r.TITULO = \'%s\') \
                     OR (v.CODMOVIMENTO = %s))' %(
                   str(odr.partner_id.id), codcaixa, str(odr.name), codmov)
            recs = db.query(sqld)
            if len(recs):
                # TODO
                # recebido entao precisa colocar recebido aqui tbem
                if recs[0][2] == '5-':
                    faturas_ids = self.env['account.invoice'].search([
                        ('state','=', 'paid'),
                        ('partner_id','=', odr.partner_id.id),
                        ('origin','=', odr.name), 
                    ])
                    if faturas_ids:
                        recebe = 'UPDATE RECEBIMENTO SET STATUS = \'7-\' \
                              WHERE CODRECEBIMENTO = %s' %(str(recs[0][0]))
                        retorno = db.insert(recebe)
                        if retorno:
                            msg_erro += 'ERRO : %s ' %(retorno)
                    """ PRECISO DISTO ABAIXO
                    else:
                        vlr := fatura_ids.amount_total - fatura_ids.residual
                        recebe = 'UPDATE RECEBIMENTO SET VALOR_RESTO = %s \
                              ,VALORTITULO = %s \
                              WHERE CODRECEBIMENTO = %s' %(str(vlr),str(recs[0][0]))
                        retorno = db.insert(recebe)
                        if retorno:
                            msg_erro += 'ERRO : %s ' %(retorno)
                    """   
                continue
            else:
                sqlc = 'SELECT CODCLIENTE FROM CLIENTES WHERE CODCLIENTE = %s' %(
                    str(odr.partner_id.id))
                clis = db.query(sqlc)
                if not len(clis):
                    self.action_atualiza_clientes(session, odr.partner_id.id)
                sqld = 'SELECT r.CODRECEBIMENTO, r.CODCLIENTE, r.STATUS FROM RECEBIMENTO r \
                    WHERE r.CODCLIENTE = %s AND r.CODALMOXARIFADO = %s \
                    AND (r.TITULO = \'%s\')' %(
                   str(odr.partner_id.id), codcaixa, str(odr.name))
                recs = db.query(sqld)
                if len(recs):
                    continue
                #incluindo no RECEBIMENTO
                # ve se a fatura esta aberta
                faturas_ids = self.env['account.invoice'].search([
                    ('state','=', 'open'),
                    ('partner_id','=', odr.partner_id.id),
                    ('origin','=', odr.name), 
                    ])
                for ftr in faturas_ids:
                    dt_vc = ftr.date_invoice
                    if ftr.date_due:
                        dt_vc = ftr.date_due
                    ins_rec = 'INSERT INTO RECEBIMENTO (CODRECEBIMENTO, TITULO ' \
                              ',EMISSAO, CODCLIENTE, DATAVENCIMENTO ' \
                              ',STATUS, VIA, FORMARECEBIMENTO, HISTORICO' \
                              ',CODALMOXARIFADO, CODVENDEDOR, CODUSUARIO' \
                              ',VALORRECEBIDO, JUROS ' \
                              ',DESCONTO, PERDA, TROCA, FUNRURAL ' \
                              ',VALOR_PRIM_VIA, VALOR_RESTO, VALORTITULO' \
                              ',OUTRO_CREDITO, OUTRO_DEBITO, PARCELAS)' \
                              ' VALUES(' \
                                  'GEN_ID(COD_AREC,1), \'%s\' ' \
                                  ',\'%s\', %s, \'%s\'' \
                                  ',\'5-\', \'1\', \'1\', \'Importado Odoo\'' \
                                  ',%s, %s, %s, 0.0, 0.0, 0.0, 0.0, 0.0,0.0' \
                                  ',%s, %s, %s, 0.0, 0.0, 1)' %(
                                ftr.origin, ftr.date_invoice, ftr.partner_id.id, 
                                dt_vc, codcaixa, ftr.user_id.id, 
                                ftr.user_id.id, ftr.residual, 
                                ftr.residual, ftr.residual)
                    # print(ins_rec)
                    retorno = db.insert(ins_rec)
                    if retorno:
                        msg_erro += 'ERRO : %s ' %(retorno)
        # contas recebidas colocar no PDV ODOO
        sqld = 'SELECT  r.CODRECEBIMENTO, r.DATARECEBIMENTO, \
                   r.CODALMOXARIFADO, r.FORMARECEBIMENTO, \
                   r.VALORRECEBIDO, r.TITULO, r.CODCLIENTE \
                   , f.CAIXA , f.ID_ENTRADA \
                FROM RECEBIMENTO r, FORMA_ENTRADA f  \
                WHERE f.CODFORMA = CAST(r.N_DOCUMENTO AS INTEGER) \
                   AND r.DATARECEBIMENTO >= \'%s\' \
                   AND r.STATUS = \'7-\' \
                   AND r.CODALMOXARIFADO = %s' %(hj,str(session.id))
        recs = db.query(sqld)

        if not len(recs):
            msg_sis = 'Sem Contas Receber para importar. '
        for rcs in recs:
            # procura o pedido pdv odoo
            lanc = '%s-%s' %(str(rcs[7]), str(rcs[8]))
            # ppdv = self.env['pos.order'].search([
            #     ('pos_reference','=',lanc)
            # ])
            ppdv = ''
            if not ppdv:
                continue
            msg_sis = 'Receber novos : %s ' %(str(rcs[0]))
            jrn = '1-'
            # cartao Credito ATSAdmin    
            if rcs[3] == '6':
                jrn = '3-'
            # cartao Debito ATSAdmin
            if rcs[3] == '7':
                jrn = '2-'
            jrn_id = self.env['account.journal'].search([
                ('name','like', jrn)])[0]
            stmt = session.cash_register_id
            if jrn != '1-':
                stmt = self.env['account.bank.statement'].search([
                    ('journal_id','=', jrn_id.id),
                    ('pos_session_id','=',rcs[2]),
                ])
            lancado_id = self.env['account.bank.statement.line'].search([
                ('move_name','=',str(rcs[0])),
                ('statement_id','=', stmt.id),
                ('journal_id','=', jrn_id.id),
            ])
            # if lancado_id:
            #     faturas_ids = self.env['account.invoice'].search([
            #         ('partner_id','=', rcs[6]),
            #         ('origin', '=', ppdv.name)
            #         ('state','=', 'open'),
            #     ])
            #     for ftr in faturas_ids:
            #         ftr.pay_and_reconcile(jrn_id.id, rcs[4])
            #     continue
            values = {}
            values['statement_id'] = stmt.id
            values['journal_id'] = jrn_id.id
            values['ref'] = session.name
            values['move_name'] = str(rcs[0])
            values['name'] = 'Recebimento conta %s' %(str(rcs[5]))
            values['amount'] = rcs[4]
            self.env['account.bank.statement.line'].create(values)                                        
            # baixar a fatura do cliente
            faturas_ids = self.env['account.invoice'].search([
                ('partner_id','=', rcs[6]),
                ('state','=', 'open'),
                ('origin', '=', ppdv.name)
            ])
            for ftr in faturas_ids:
                ftr.pay_and_reconcile(jrn_id.id, rcs[4])

    def action_devolucao(self):  
        self._inicia()     
        db = con()
        _logger.info("Integrando Devolucao PDV para Odoo")
        hj = datetime.now()
        hj = hj - timedelta(days=20)
        hj = datetime.strftime(hj, '%m-%d-%Y')
        sqlc = "SELECT r.IDCAIXACONTROLE, r.CODCAIXA,  \
               r.VALORABRE, r.VALORFECHA  \
               FROM CAIXA_CONTROLE r \
               WHERE DATAABERTURA > '%s' AND r.CODUSUARIO = %s \
               ORDER BY r.CODCAIXA " %(hj, self.caixa_user)
        caixa_aberto = db.query(sqlc)
        sqld = False
        for cx in caixa_aberto:
            sqld = ' Select c.caixa, c.codmovimento, movd.quantidade, movd.codproduto,'\
                ' mov.hist_mov, p.produto, mov.controle, mov.codusuario, p.codpro '\
                ' from compra c '\
                ' inner join movimentodetalhe movd on (c.codmovimento = movd.codmovimento) '\
                ' inner join produtos p on (movd.codproduto = p.codproduto) '\
                ' inner join movimento mov on (c.codmovimento = mov.codmovimento) '\
                ' where c.caixa = %s ' %(str(cx[1]))
            movs = db.query(sqld)
            if not len(movs):
                _logger.info("Sem Devolucao para importar.")
            for mvs in movs:
                ord_name = '%s-%s' %(str(cx[1]),str(mvs[1]))
                arquivo_nome = self.path_envio + '/devolucao_%s.json' %(ord_name)
                if os.path.exists(arquivo_nome):
                    continue
                nome_busca = 'DEV-' + ord_name
                _logger.info("Devolucao %s" %(ord_name))
                item = []
                vals = {}
                vals['tipo'] = 'devolucao'
                vals['name'] = nome_busca
                vals['origin'] = nome_busca
                vals['user_id'] = mvs[7]
                vals['motivo'] = mvs[4]
                vals['caixa'] = mvs[0]
                prd = {}

                prd['product_code']= mvs[3]
                prd['product_uom_qty'] = mvs[2]
                prd['product_uom_id'] = 1
                prd['product_uom'] = 1
                prd['qty_done'] = mvs[2]
                prd['name']= str(mvs[5])
                item.append((0, 0, prd))
                
                vals['move_lines'] = item

                dados_vals = json.dumps(vals)
                if not os.path.exists(arquivo_nome):
                    arquivo_json = open(arquivo_nome, 'w')
                    arquivo_json.write(dados_vals)
                    arquivo_json.close()
                _logger.info("Devolucao enviada: %s" %(nome_busca))
        envia("devolucao")

    def action_atualiza_vendas(self):
        #breakpoint()
        self._inicia()
        caixa_falta = False
        # Fazer um loop pela pasta de arquivos pegando o codigo dos pedidos
        # Para remover do select da movimento
        db = con()
        _logger.info("Integrando Vendas para o PDV")
        hj = datetime.now()
        # hj = hj - timedelta(days=session.periodo_integracao)
        hj = hj - timedelta(days=5)
        hj = datetime.strftime(hj,'%m-%d-%Y')
        caixa_usado = 'None'
        # TODO le o ultimo arquivo de retorno com as ultimas atualizacos
        # retorno = open(self.path_retorno, '+r')
        str_ord = '0'
        # TODO buscar caixa aberto
        sqlc = "SELECT r.IDCAIXACONTROLE, r.CODCAIXA,  \
               r.VALORABRE, r.VALORFECHA  \
               FROM CAIXA_CONTROLE r"
        if caixa_falta:
            sqlc += " WHERE r.CODCAIXA = %s AND r.CODUSUARIO = %s \
               ORDER BY r.CODCAIXA " %(caixa_falta, self.caixa_user)
        else:       
            sqlc += " WHERE DATAABERTURA > '%s' AND r.CODUSUARIO = %s \
               ORDER BY r.CODCAIXA " %(hj, self.caixa_user)
        
        caixa_aberto = db.query(sqlc)
        sqld = False
        for cx in caixa_aberto:
            # print(cx[1])
            sqld = 'SELECT m.CODMOVIMENTO, m.DATAMOVIMENTO, ' \
               'm.CODCLIENTE, m.STATUS, m.CODUSUARIO, m.CODVENDEDOR, ' \
               'm.CODALMOXARIFADO, DATEADD(3 hour to m.DATA_SISTEMA) ' \
               ', c.NOMECLIENTE ' \
               '  FROM MOVIMENTO m, CLIENTES c ' \
               ' WHERE c.CODCLIENTE = m.CODCLIENTE ' \
               '   AND m.CODALMOXARIFADO = %s' \
               '   AND m.STATUS = 1 ' \
               '   AND m.CODNATUREZA = 3 ' \
               '   AND m.CODMOVIMENTO NOT IN (%s)' %(str(cx[1]),str_ord)
        if not sqld:
            _logger.info("Sem caixa aberto.")
            return
                # return msg_sis
        movs = db.query(sqld)
        if not len(movs):
            _logger.info("Sem Pedidos para importar.")
            # for mvs in movs:
            #    print ('cod mov: %s' %(str(mvs[0]))) 
        for mvs in movs:
            ord_p = False
            ord_name = '%s-%s' %(str(cx[1]),str(mvs[0]))
            _logger.info("Pedidos novos: %s" %(ord_name))
            arquivo_nome = self.path_envio + '/pedido_%s.json' %(ord_name)
            if os.path.exists(arquivo_nome):
                continue
            teve_desconto = 'n'
            dt_ord = '2018.01.01'
            
            # coloquei so pra manter o if
            if ord_name:
                # cortesia = tipo_venda n
                vals = {}               
                cli = mvs[2]
                dt_ord = str(mvs[7])
                vals['name'] = ord_name
                vals['nb_print'] = 0
                vals['pos_reference'] = ord_name
                vals['session_id'] = cx[1]
                vals['pos_session_id'] = cx[1]
                # vals['pricelist_id'] = cx[2].config_id.pricelist_id.id
                vals['create_date'] = dt_ord #datetime.strftime(datetime.now(),'%Y-%m-%d %H:%M:%S')
                vals['date_order'] = dt_ord
                vals['sequence_number'] = mvs[0]
                #print('XXXXXX' + str(cli))
                vals['partner_id'] = cli
                userid = mvs[5]
                #if userid == 17:
                if userid > 1:
                    vals['user_id'] = userid
                else:
                    vals['user_id'] = mvs[4]
                
                sqld = 'SELECT f.CODFORMA, f.FORMA_PGTO, f.VALOR_PAGO, ' \
                    'f.STATE, f.TROCO, f.DESCONTO from FORMA_ENTRADA f' \
                    ' WHERE ID_ENTRADA = %s AND f.STATE = 1' %(str(mvs[0]))
                pag_ids = db.query(sqld)

                pag_line = []
                desconto_t = 0.0
                total_g = 0.0
                troca = 0.0
                for pg in pag_ids:
                    pag = {}
                    controle_troca = 0
                    if pg[5]:
                        desconto_t += pg[5]
                        teve_desconto = 's'
                    total_g += pg[2]
                    jrn = '%s-' %(pg[1])
                    if jrn == '5-':
                        jrn = '1-'
                    if jrn == '9-':
                        troca = pg[2]
                        controle_troca = 1
                        
                    #pag['account_id'] = self.env['res.partner'].browse(cli).property_account_receivable_id.id
                    pag['date'] = dt_ord
                    pag['amount'] = pg[2]
                    # pag['journal_id'] = jrn_id.id
                    pag['journal'] = jrn
                    pag['partner_id'] = cli
                    pag['name'] = ord_name
                    if controle_troca == 0:
                        pag_line.append((0, 0,pag))

                #ord_id = pos_ord.create(vals)
                order_line = []
                sqld = 'SELECT md.CODDETALHE, md.CODPRODUTO, ' \
                    ' md.QUANTIDADE, md.PRECO, COALESCE(md.VALOR_DESCONTO,0),' \
                    ' md.BAIXA, md.DESCPRODUTO, md.CORTESIA, p.CODPRO ' \
                    ' FROM MOVIMENTODETALHE md, PRODUTOS p ' \
                    ' WHERE p.CODPRODUTO = md.CODPRODUTO ' \
                    ' AND   md.STATUS = 0 AND md.CodMovimento = %s' %(str(mvs[0]))
                md_ids = db.query(sqld)
                if not len(md_ids):
                    continue
                #order = pos_ord.browse(ord_id)
                #order.write({'fiscal_position_id' : })
                vlr_total = 0.0
                vlr_totprod = 0.0
                if desconto_t > 0:
                    desconto_t = desconto_t / (total_g+desconto_t)

                num_linha = len(md_ids)
                # se so 1 linha ignora
                linhas = 's'
                
                if num_linha == 1:
                    linhas = 'n'

                soma_t = 0.0
                #total_gx = total_g
                #if str(mvs[0]) == '10416':
                for md in md_ids:
                    if linhas == 's': 
                        num_linha -= 1
                    try:
                        prdname = self.removerAcentosECaracteresEspeciais(md[6])
                    except:
                        if md[6]:
                            prdname = md[6]
                        else:
                            prdname = "Sem descricao"
                    vlr_total += (md[2]*md[3])-md[4]
                    vlr_totprod = (md[2]*md[3])-md[4]
                    desconto = 0.0
                    if (md[4] > 0):
                        teve_desconto = 's'
                        # comentei aqui pq nao testei
                        #if num_linha > 0:
                        desconto = md[4] / (vlr_totprod+md[4])
                        #else:
                        #    desconto = md[4] / (vlr_totprod+total_g)
                    
                    if num_linha > 0:
                        desconto = (desconto + desconto_t) * 100
                    else:
                        #desconto Zero, vou editar depois de gravado
                        # pra calcular o desconto correto
                        desconto = 0.0
                    prd = {}
                    tipo = '1'
                    if md[7].strip():
                        tipo = md[7].strip()

                    prd['product_id'] = md[1]
                    prd['discount'] = desconto
                    prd['qty'] = md[2]
                    prd['price_unit'] = md[3]
                    prd['tipo_venda'] = tipo
                    prd['name'] = prdname
                    prd['codpro'] = md[8]

                    order_line.append((0, 0,prd))
                if troca:
                    prd = {}
                    prd['product_id'] = 2
                    prd['qty'] = 1
                    prd['price_unit'] = troca * (-1)
                    prd['tipo_venda'] = tipo
                    prd['name'] = 'Troca/Devolucao'
                    prd['codpro'] = md[8]
                    order_line.append((0, 0,prd))

                vals['amount_return'] = vlr_total
                vals['lines'] = order_line
                
                vals['statement_ids'] = pag_line
                
                if teve_desconto == 's':
                    # uso nb_print pra saber q veio do pdv lazarus
                    vals['nb_print'] = 9

                # try:
                vals_ped = vals 
                nomecliente = self.removerAcentosECaracteresEspeciais(mvs[8])
                nomecliente = (nomecliente)
                vals_ped['nomecliente'] = nomecliente
                dados_vals = json.dumps(vals_ped)
                #breakpoint()
                if not os.path.exists(arquivo_nome):
                    arquivo_json = open(arquivo_nome, 'w')
                    arquivo_json.write(dados_vals)
                    arquivo_json.close()

                # except:
                # msg_erro += 'ERRO, nao integrado pedido : %s ' %(prdname)

                if teve_desconto == 's' and linhas == 's' and ord_p:
                    #ord_p = pos_ord.browse(ords)
                    if (total_g != ord_p.amount_total):
                        tam = len(ord_p.lines)
                        for line in ord_p.lines[tam-1]:
                            x = line.price_unit * line.qty
                            desconto = (ord_p.amount_total-round(total_g,2))/x*100
                        
                if teve_desconto == 's' and ord_p:
                    # coloquei isto aqui pq qdo tem desconto
                    # e era a prazo o desconto do ultimo item nao ia pra
                    # fatura estas duas linhas abaixo eram feitas no create
                    arquivo_nome = self.path_envio + '/pagline_%s.json' %(ord_name)
                    arquivo_json = open(arquivo_nome, 'w')
                    dados_vals = json.dumps(vals)
                    arquivo_json.write(dados_vals)
                    arquivo_json.close()                    
        print ('Integracao VENDAS realizada com sucesso.')
                #if ord_p and jrn == '4-':
                #    pedido_venda = self.env['sale.order']
                #    pv = {}
                #    pv['name'] = ord_p.pos_reference
                #    pv['partner_id'] = ord_p.partner_id.id
                #    pv['date_order'] = ord_p.date_order
                #    pv['user_id'] = ord_p.user_id.id
                #    pv['fiscal_position_id'] = 5
                #    pv['origin'] = ord_p.name
                #    pv_line = []
                #    pv_ln = {}
                #    for pvl in order_line:
                #        pv_ln['product_uom_qty'] = pvl[2]['qty']
                #        pv_ln['product_id'] = pvl[2]['product_id']
                #        pv_ln['price_unit'] = pvl[2]['price_unit']
                #        pv_ln['name'] = pvl[2]['name']
                #        pv_line.append((0, 0,pv_ln))
                #    pv['order_line'] = pv_line
                #    pedido_venda.create(pv)
                    #ord_p.create_picking()
                # 02/03/2023 Comentei as 3 linhas abaixo pq estava baixando o estoque 2x
                #if teve_desconto == 's' and ord_p:
                #    if jrn != '4-':
                #        ord_p.action_pos_order_paid()
        # 19/12/19
        # CRIAR FATURA - coloquei isso pq faturado nao esta entrando em faturas            
        #ord_ids = self.env['pos.order'].search([(
        #    'session_id','=',session.id)])
        #str_ord = ",".join(str(x.sequence_number) for x in ord_ids)
        #if not str_ord:
        #    str_ord = '1'
        #sqld = 'SELECT m.CODMOVIMENTO, m.DATAMOVIMENTO, ' \
        #       'm.CODCLIENTE, m.STATUS, m.CODUSUARIO, m.CODVENDEDOR, ' \
        #       'm.CODALMOXARIFADO, DATEADD(3 hour to m.DATA_SISTEMA) ' \
        #       '  FROM MOVIMENTO m ' \
        #       ' WHERE m.STATUS = 1 ' \
        #       '   AND m.CODNATUREZA = 3 ' \
        #       '   AND m.CODCLIENTE > 1 ' \
        #       '   AND m.CODMOVIMENTO IN (%s)' %(str_ord)
        #movs = db.query(sqld)

        #if not len(movs):
        #    msg_sis = 'Sem Pedidos para importar. '
        #for mvs in movs:
        #    pos_ord = self.env['pos.order']
        #    ord_name = '%s-%s' %(str(mvs[6]),str(mvs[0]))
        #    ords = pos_ord.search([('pos_reference','=', ord_name)])
        #    for pdv in ords:
        #        for sttm in pdv.statement_ids:
        #            if sttm.journal_id.id == 10:
        #                # procuro se existe a fatura
        #                ftr = self.env['account.invoice'].search([('origin','=', pdv.name)])
        #                if ftr:
        #                    continue
        #                #pdv.create_order(pdv.statement_ids, pdv)
        #                pdv.action_pos_order_invoice()
        #                pdv.invoice_id.sudo().action_invoice_open()
        #                pdv.create_picking()

        # Fim CRIAR FATURA
        
        #msg_sis += 'Integracao Finalizada. '

        #sqlc = 'SELECT FIRST 3 r.IDCAIXACONTROLE, r.CODCAIXA,  \
        #       r.VALORABRE, r.VALORFECHA  \
        #       FROM CAIXA_CONTROLE r WHERE r.VALORFECHA = 1 \
        #       ORDER BY r.CODCAIXA DESC '
        #caixa_fechado = db.query(sqlc)
        #for cx in caixa_fechado:
        #    pos_ses = self.env['pos.session'].search([
        #        ('id', '=', cx[1]), 
        #        ('state','=','opened'),
        #        ('venda_finalizada','=', False)])
            #session = self.env['pos.session'].browse(pos_ses)
        #    if pos_ses:
        #        pos_ses.write({'venda_finalizada': True})
        #        msg_sis = 'CAIXA FECHADO , COM SUCESSO. '
        # return msg_sis + ' ' + msg_erro

# class PosConfig(models.Model):
    # _inherit = 'pos.config'
    
    # ip_terminal = fields.Char(string='ip Terminal Vendas')
    # database = fields.Char(string='Banco de Dados')
    
    # def action_testar_acesso_terminal(self):
    #     try:
    #         db = con.Conexao(self.ip_terminal, self.database)
    #     except:
            # raise UserError(u'Caminho ou nome do banco invalido.')

# class PosOrder(models.Model):
#     _inherit = 'pos.order'

#     def _payment_fields(self, ui_paymentline):
#         if 'date' in ui_paymentline:
#             dt = ui_paymentline['date']
#         else:
#             dt = ui_paymentline['name']

#         return {
#             'amount':       ui_paymentline['amount'] or 0.0,
#             'payment_date': dt,
#             'statement_id': ui_paymentline['statement_id'],
#             'payment_name': ui_paymentline.get('note', False),
#             'journal':      ui_paymentline['journal_id'],
#         }

#     @api.model
#     def create_order(self, orders, order):
#         # Keep only new orders
#         order_ids = []
#         to_invoice = False
#         for stm in orders:
#             if stm[2]['journal_id'] == 10:
#                 to_invoice = True
#             amount = order.amount_total - order.amount_paid
#             data = stm[2]
#             if amount != 0.0:
#                 order.add_payment(data)
#             if order.test_paid() and not to_invoice:
#                 order.action_pos_order_paid()        
            
#         if to_invoice:
#             order.action_pos_order_invoice()
#             order.invoice_id.sudo().action_invoice_open()
#             order.create_picking()
    

#     @api.model
#     def create(self, values):
#         if 'pos_session_id' in values:
#             stm_ids = values['statement_ids']
#             del values['statement_ids']
#             res = super(PosOrder, self).create(values)
#             #uso nb_print = 9 qdo importo pdv lazarus
#             if values['nb_print'] == 0:
#                 self.create_order(stm_ids, res)
#         else:
#             res = super(PosOrder, self).create(values)
#         return res

executa = IntegracaoOdoo()
# executa
