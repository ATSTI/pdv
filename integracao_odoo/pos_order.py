# -*- coding:utf-8 -*-

from datetime import datetime
from datetime import date
from datetime import timedelta
import logging

import re
import time
import os
import unidecode
import json
import configparser
from atscon import Conexao as con
from conecta_server import EnviaServer as envia
from sqlite_bd import Database as local_db


_logger = logging.getLogger(__name__)

class IntegracaoOdoo:
    _name = 'integracao.odoo'
    
    def __init__(self):
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')
        self.path_envio  = cfg.get('INTEGRA', 'path_envio')
        self.path_retorno = cfg.get('INTEGRA', 'path_retorno' )
        # self.host = cfg.get('DATABASE', 'hostname')
        # self.db = cfg.get('DATABASE', 'path')
        rodou = 1
        while(True):
            # Cria o ARQUIVO JSON dos Pedidos para ser enviado
            self.action_atualiza_vendas()
            # Cria o ARQUIVO JSON dos Caixas para ser enviado
            self.action_atualiza_caixas(None)
            envia("pedido")
            # Busca alterações dos produtos e grava no database local para ser comparado com o BD do PDV
            envia("produto")
            # Compara as ataulizacoes do produto com o BD do PDV e atualiza ou insere se necessario
            self.action_atualiza_produtos(None)
            print(f"Rodou : {rodou} vezes")
            envia("cliente")
            self.action_atualiza_clientes()
            rodou += 1
            time.sleep(600)

    def action_atualiza_caixas(self, session):
        try:
            # db = con.Conexao(self.host, self.database)
            db = con()
        except:
            msg_sis = u'Caminho ou nome do banco inválido.<br>'
        msg_erro = ''
        msg_sis = 'Integrando Caixa com o PDV<br>'
        hj = datetime.now()
        hj = hj - timedelta(days=4)
        hj = datetime.strftime(hj,'%Y-%m-%d')

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
                WHERE SITUACAO = 'o' AND DATAABERTURA = '%s'" %(hj)
        sess = db.query(sqlp)
        for ses in sess:
            vals = {}
            vals['user_id'] = ses[2]
            vals['name'] = ses[5]
            vals['caixa'] = ses[1]
            # vals['config_id'] = ses.config_id.id
            data_abertura = f"{ses[6]} 20:00:00"
            vals['start_at'] = data_abertura
            vals['state'] = 'draft'
            arquivo_nome = self.path_envio + '/caixa_%s.json' %(ses[1])
            if os.path.exists(arquivo_nome):
                continue
            arquivo_json = open(arquivo_nome, 'w+')
            dados_vals = json.dumps(vals)
            arquivo_json.write(dados_vals)
            # if not len(sess):
            #     #state = 'c' # close
            #     #if ses.state == 'opened':
            #     #dta_abre = '%s.%s.%s' %(str(ses.start_at.month).zfill(2), str(ses.start_at.day).zfill(2), str(ses.start_at.year))
            #     hj = datetime.now()
            #     dta_abre = datetime.strftime(hj,'%m-%d-%Y')
            #     if ses.start_at:
            #         dta_abre = '%s/%s/%s' %(str(ses.start_at[5:7]), str(ses.start_at[8:10]), str(ses.start_at[:4]))
            #     state = 'o'
            #     insere = 'INSERT INTO CAIXA_CONTROLE (IDCAIXACONTROLE, '
            #     insere += 'CODCAIXA, CODUSUARIO, SITUACAO, DATAFECHAMENTO'
            #     insere += ',NOMECAIXA, DATAABERTURA) VALUES ('
            #     insere += '%s'
            #     insere += ',%s'
            #     insere += ',%s'
            #     insere += ',\'%s\''
            #     insere += ',\'%s\''
            #     insere += ',\'%s\''
            #     insere += ',\'%s\');'
                
            #     insere = insere %(str(ses.id), str(ses.id), str(ses.user_id.id), str(state) \
            #     ,str('01.01.2018'), str(ses.name), str(dta_abre))
            #     db.insert(insere)
            # else:
            # if not len(sess):
            #     #if ses.state != 'opened':
            #     #    altera = 'UPDATE CAIXA_CONTROLE SET SITUACAO = \'F\''
            #     #    altera += ' WHERE IDCAIXACONTROLE = %s' %(str(ses.id))
            #     #    db.insert(altera)

            #     if sess[0][1] == 'F':
            #         ses.venda_finalizada = True
        # INSERINDO sangria
        # for ses in sessao_ids: 
        #     hj = datetime.now()
        #     #num_sessao = session.name[len(ses.name)-4:]
        #     # num_sessao = ses.id
        #     sqlp = 'SELECT f.CAIXA, f.CODFORMA, f.COD_VENDA, \
        #         f.VALOR_PAGO, f.N_DOC FROM FORMA_ENTRADA f \
        #         where f.CAIXA = %s and f.COD_VENDA = 1' %(str(num_sessao))
        #     sess_ids = db.query(sqlp)
        #     amount = 0.0
        #     for sess in sess_ids:
        #         cod_caixa = sess[0]
        #         cod_forma = sess[1]
        #         cod_venda = sess[2]
        #         valor = sess[3] or 0.0
        #         if not valor:
        #             continue
        #         motivo = sess[4]
        #         if int(cod_caixa) != ses.id:
        #             continue
        #         if int(cod_venda) == 1:
        #             amount = -valor
        #         else:
        #             amount = valor
                
        #         lancamento = 'Caixa-%s-%s' %(cod_caixa, cod_forma)
        #         vals = {
        #                     'date': hj,
        #                     'amount': amount,
        #                     'ref': lancamento,
        #                     'name': motivo,
        #         }
        #         ja_importou = self.env['account.bank.statement.line'].search([
        #               ('name', '=', motivo),
        #               ('ref', '=', lancamento)])
        #         if ja_importou:
        #             continue
        #         for cx in ses.statement_ids:
        #             if cx.journal_id.name[:2] == '1-':
        #                  stt = cx
        #                  jrn = cx.journal_id
        #                  vals['statement_id'] = cx.id
        #                  vals['journal_id'] = jrn.id
        #                  vals['account_id'] = jrn.company_id.transfer_account_id.id,
        #                  cx.write({'line_ids': [(0, False, vals)]})

    def cron_integra_produtos(self):
        session_ids = self.env['pos.session'].search([
                ('state', '=', 'opened')])
        for ses in session_ids:
             self.action_atualiza_produtos(ses)

    def action_integra_produtos(self):
        # se nao for no pos enviar email com as msg_erro
        self.msg_integracao = self.action_atualiza_produtos(self)

    def action_atualiza_produtos(self, session):
        try:
            # db = con.Conexao(self.host, self.database)
            db = con()
            dblocal = local_db(filename = 'lancamento.db', table = 'produto')
        except:
            msg_sis = u'Caminho ou nome do banco inválido.<br>'
        msg_erro = ''
        hj = datetime.now()
        hj = hj - timedelta(days=1)
        hj = datetime.strftime(hj,'%Y-%m-%d')
        msg_erro = ''
        msg_sis = 'Integrando Produtos para o PDV<br>'

        # troquei esta rotina pq agora os dados estao no sqlite3 ja vindos do odoo

        # # pegando alteracoes pelo log
        # audit = self.env['auditlog.log'].sudo().search([
        #     ('create_date', '>=', hj),
        #     ('model_id', '=', 'product.template'),
        # ])
        # prod_ids = []
        # prd_ids = set()
        # for pr in audit:
        #     if len(pr.line_ids):
        #         prd_ids.add(pr.res_id)
    
        # audit = self.env['auditlog.log'].sudo().search([
        #     ('create_date', '>=', hj),
        #     ('model_id', '=', 'product.product'),
        # ])
        # for pr in audit:
        #     if len(pr.line_ids):
        #         prd_ids.add(pr.res_id)

        # if len(prd_ids):
        #     prod_ids = self.env['product.product'].sudo().search([
        #         ('product_tmpl_id','in',list(prd_ids))])

        # for product_id in prod_ids:
        #     if not product_id.origin:
        #         continue
            #print ('Produto %s\n' %(str(product_id.product_tmpl_id.id)))
        prod_novo = dblocal.consulta_produto()
        for pr in prod_novo:
            ncm = ''
            if pr['ncm']:
                ncm = pr['ncm']
                if ncm:
                    ncm = re.sub('[^0-9]', '', ncm)
            if ncm and len(ncm) > 8:
                ncm = '00000000'
            p_custo = 0.0
            if pr['custo']:
                p_custo = pr['custo']
            p_venda = 0.0
            if pr['valor_prazo']:
                p_venda = pr['valor_prazo']
            codbarra = ''
            if pr['cod_barra'] and len(pr['cod_barra']) < 14:
                codbarra = pr['cod_barra'].strip()
            produto = pr['produto'].strip()
            produto = produto.replace("'"," ")
            try:
                produto = unidecode(produto)
            except:
                produto = produto
            produto = produto.replace("'","")
            codp = str(pr['codproduto'])
            sqlp = "select FIRST 1 CODPRODUTO,\
                    DATACADASTRO from produtos where codpro = '%s'" %(pr["codpro"])
            prods = db.query(sqlp)
            if pr['codpro']:
                codpro = pr['codpro'].strip()
            #sqlp = 'select codproduto from produtos where codpro like \'%s\'' %(codp+'%')
            if codbarra:
                # 03/10/2022 limpando o codigo de barra qdo ja existe  
                sql_bar = 'select codpro from produtos where cod_barra = \'%s\'' %(codbarra)
                barra = db.query(sql_bar)
                up_bar = 'UPDATE PRODUTOS SET COD_BARRA = NULL WHERE COD_BARRA = \'%s\'' %(codbarra)
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
            if not len(prods) and pr['usa'] == 'S':
                #print ('Incluindo - %s' %(product_id.name))
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
                          QTDEATACADO, PRECOATACADO, DATACADASTRO'
                if codbarra:
                    insere += ', COD_BARRA'
                insere += ') VALUES ('
                insere += '\'' + un + '\''
                insere += ', \'' + produto + '\''
                insere += ', ' + str(p_custo)
                insere += ', \'' + str(codpro) + '\''
                insere += ',\'F\''
                insere += ',' + str(pr['origem'])
                insere += ',\'' + str(ncm) + '\''
                insere += ', ' + str(p_custo)
                insere += ',' + str(p_venda)
                insere += ',\'' + str('PROD') + '\''
                insere += ', \'' + pr['tipo_venda'] + '\''
                insere += ',' + str(pr['qtdeatacado'])
                insere += ',' + str(pr['precoatacado'])
                insere += ', \'' + data_fb + '\''
                if codbarra:
                    insere += ', \'' + str(codbarra) + '\''
                insere += ')'
                #print (codp+'-'+produto)
                try:
                    retorno = db.insert(insere)
                except:
                    x = 0
                # TODO tratar isso e enviar email
                if retorno:
                    msg_erro += 'ERRO : %s<br>' %(retorno)
                    if 'ERRO' in msg_erro:
                        x = 1
                    #print ('SQL %s' %str(insere))
            elif len(prods):
                if data_cad == data_nova:
                    continue
                ativo = 'S'
                if pr['usa'] != 'S':
                   ativo = 'N'
                   codbarra = ''
                   codp = codp + 'x'
                #print ('Alterando - %s' %(product_id.name))
                altera = 'UPDATE PRODUTOS SET PRODUTO = '
                altera += '\'' + produto + '\''
                altera += ', VALOR_PRAZO = ' + str(p_venda)
                altera += ', NCM = ' +  '\'' + str(ncm) + '\''
                altera += ', CODPRO = ' +  '\'' + str(codp) + '\''
                altera += ', ORIGEM = ' + str(pr['origem']) 
                altera += ', USA = \'' + ativo + '\''  
                altera += ', RATEIO = \'' + str(pr['tipo_venda']) + '\''
                altera += ', QTDEATACADO = ' + str(pr['qtdeatacado']) 
                altera += ', PRECOATACADO = ' + str(pr['precoatacado'])
                altera += ', DATACADASTRO = \'' + data_fb + '\''
                if codbarra:
                    altera += ', COD_BARRA = \'' + str(codbarra) + '\''
                altera += ' WHERE CODPRO = \'' + str(pr['codpro']) + '\''
                retorno = db.insert(altera)
                #print ('SQL : %s' %(altera))
                if retorno:
                    #print ('SQL erro : %s' %(altera))
                    msg_erro += 'ERRO : %s<br>' %(retorno)
                    if 'ERRO' in msg_erro:
                        x = 1
        #print ('Integracao realizada com sucesso.')
        msg_sis += 'Integracao Finalizada.<br>'
        return msg_sis + '<br>' + msg_erro

    def cron_integra_clientes(self):
        session_ids = self.env['pos.session'].search([
                ('state', '=', 'opened')])
        for ses in session_ids:
             self.action_atualiza_clientes(ses, False)

    def action_integra_clientes(self):
        # se nao for no pos enviar email com as msg_erro
        self.msg_integracao = self.action_atualiza_clientes(self, False)

    def action_atualiza_clientes(self):
        try:
            db = con()
            dblocal = local_db(filename = 'lancamento.db', table = 'cliente')
        except:
            msg_sis = u'Caminho ou nome do banco inválido.<br>'
        msg_erro = ''
        msg_sis = 'Integrando Clientes para o PDV<br>'
        hj = datetime.now()
        hj = datetime.strftime(hj,'%Y-%m-%d')
        cli_ids = dblocal.consulta_cliente()
        for partner_id in cli_ids:
            nome = partner_id['nomecliente']
            razao = nome  
            sqlc = 'select codcliente, datacadastro from clientes where codcliente = %s' %(partner_id['codcliente'])
            cli = db.query(sqlc)
            if len(cli):
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
                    msg_erro += 'ERRO : %s<br>' %(retorno)
            if not len(cli):
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
                    msg_erro += 'ERRO : %s<br>' %(retorno)                
                
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
                    msg_erro += 'ERRO : %s<br>' %(retorno)
            else:
                regiao = partner_id['regiao']
                altera =  'UPDATE CLIENTES SET REGIAO = %s \
                    ,NOMECLIENTE = \'%s\', STATUS = 1 \
                    WHERE CODCLIENTE = %s' %(regiao, nome, str(partner_id['codcliente']))
                retorno = db.insert(altera )
                if retorno:
                    msg_erro += 'ERRO : %s<br>' %(retorno)
        
        msg_sis += 'Integracao Finalizada.<br>'
        return  msg_sis + '<br>' + msg_erro

    def cron_integra_recebidos(self):
        session_ids = self.env['pos.session'].search([
                ('state', '=', 'opened')])
        for ses in session_ids:
            if self.verifica_se_esta_rodando(ses):
                ses.integracao_andamento = datetime.strftime(datetime.now(),'%Y-%m-%d %H:%M:%S')
                self.action_atualiza_recebidos(ses)

    def action_integra_recebidos(self):
        # se nao for no pos enviar email com as msg_erro
        #if self.verifica_se_esta_rodando(self):
        #    self.integracao_andamento = datetime.strftime(datetime.now(),'%Y-%m-%d %H:%M:%S')
        self.msg_integracao = self.action_atualiza_recebidos(self)
        #else:
        #    raise UserError(
        #            u'Já existe Atualização em Andamento, aguarde.')
        
    def action_atualiza_recebidos(self, session):
        try:
            if session.config_id.ip_terminal:
                db = con.Conexao(session.config_id.ip_terminal, session.config_id.database)
            else:
                return False
        except:
            msg_sis = u'Caminho ou nome do banco inválido.<br>'
        msg_erro = ''
        msg_sis = 'Integrando Contas a Receber para o PDV<br>'
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
                            msg_erro += 'ERRO : %s<br>' %(retorno)
                    """ PRECISO DISTO ABAIXO
                    else:
                        vlr := fatura_ids.amount_total - fatura_ids.residual
                        recebe = 'UPDATE RECEBIMENTO SET VALOR_RESTO = %s \
                              ,VALORTITULO = %s \
                              WHERE CODRECEBIMENTO = %s' %(str(vlr),str(recs[0][0]))
                        retorno = db.insert(recebe)
                        if retorno:
                            msg_erro += 'ERRO : %s<br>' %(retorno)
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
                    print(ins_rec)
                    retorno = db.insert(ins_rec)
                    if retorno:
                        msg_erro += 'ERRO : %s<br>' %(retorno)
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
            msg_sis = 'Sem Contas Receber para importar.<br>'
        for rcs in recs:
            # procura o pedido pdv odoo
            lanc = '%s-%s' %(str(rcs[7]), str(rcs[8]))
            # ppdv = self.env['pos.order'].search([
            #     ('pos_reference','=',lanc)
            # ])
            ppdv = ''
            if not ppdv:
                continue
            msg_sis = 'Receber novos : %s<br>' %(str(rcs[0]))
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

    def action_devolucao(self, session):
        try:
            if session.config_id.ip_terminal:
                db = con.Conexao(session.config_id.ip_terminal,
                                 session.config_id.database)
            else:
                return False
        except:
            msg_sis = u'Caminho ou nome do banco inválido.<br>'
        #db = con.Conexao('192.168.0.137:3050','C:\home\bd\ats_pdv_cx1.fdb')
        
        #db = con.Conexao (host='192.168.0.137', database='C:\\home\\bd\\sge_vitton_artur.fdb')
        #db = con.Conexao (host='192.168.0.137', database='C:\\home\\bd\\ats_pdv_cx1.fdb', user='sysdba', password='masterkey')
        #db = con.Conexao(session.config_id.ip_terminal, session.config_id.database)
        msg_erro = ''
        msg_sis = 'Integrando Devolução PDV para Odoo <br>'
        hj = datetime.now()
        # session.periodo_integracao
        hj = hj - timedelta(days=10)
        hj = datetime.strftime(hj, '%m-%d-%Y')
        caixa_usado = 'None'
        # ord_ids = self.env['pos.order'].search([(
        #    'session_id','=',session.id)])
        
        ord_ids = self.env['pos.order'].search([(
            'session_id', '=', session.id)])

        str_ord = ",".join(str(x.sequence_number) for x in ord_ids)
        if not str_ord:
            str_ord = '1'

        sqld = ' Select c.caixa, c.codmovimento, movd.quantidade, movd.codproduto,'\
               ' mov.hist_mov, p.produto, mov.controle '\
               ' from compra c '\
               ' inner join movimentodetalhe movd on (c.codmovimento = movd.codmovimento) '\
               ' inner join produtos p on (movd.codproduto = p.codproduto) '\
               ' inner join movimento mov on (c.codmovimento = mov.codmovimento) '\
               ' where c.caixa = %s ' %(str(session.id))

        movs = db.query(sqld)

        if not len(movs):
            msg_sis = 'Sem Devolução para importar.<br>'
        for mvs in movs:
            nome_busca = 'DEV-' + str(mvs[1])
            dev = self.env['stock.picking'].sudo().search([
                        ('origin', 'like', nome_busca)
                    ])
            if dev:
                continue
            else:
                item = []
                item_x = []
                vals = {}
                #if 'origin' in movs:
                vals['origin'] = nome_busca
                operacao = self.env['stock.picking.type'].sudo().search([
                    ('name', 'ilike', 'devolucao')
                ])
                prd = {}
                prd_x = {}
                if operacao:
                    for tipo in operacao:
                        # user_id.company_id.id
                        #if tipo.warehouse_id.company_id.id == 3:
                        # tipo_operacao = tipo
                        vals['picking_type_id'] = tipo.id
                        vals['location_id'] = tipo.default_location_src_id.id
                        vals['location_dest_id'] = tipo.default_location_dest_id.id
                        vals['note']= str(mvs[4])
                        prd['location_id'] = tipo.default_location_src_id.id
                        prd['location_dest_id'] = tipo.default_location_dest_id.id

                    # 0 c.caixa , 1 c.codmovimento , 2 movd.quantidade  , 3 movd.codproduto  , 4 mov.hist_mov, 5 p.produto,  6 mov.controle

                    prd['product_id']= mvs[3]
                    prd['product_uom_qty'] = mvs[2]
                    prd['product_uom_id'] = 1
                    prd['product_uom'] = 1
                    prd['qty_done'] = mvs[2]
                    prd['name']= str(mvs[5])
                    item.append((0, 0, prd))
                    vals['pack_operation_product_ids'] = item
                    
                    prd_x['product_uom_qty'] = mvs[2]
                    prd_x['product_id']= mvs[3]
                    prd_x['name']= str(mvs[5])
                    item_x.append((0, 0, prd))
                    
                    vals['move_lines'] = item_x

                    pos = self.env['stock.picking']
                    pick = pos.sudo().create(vals)
                    pick.action_confirm()
                    pick.force_assign()
                    pick.do_new_transfer()
        return 'Sucesso'    

    def action_atualiza_vendas(self):
        # Fazer um loop pela pasta de arquivos pegando o codigo dos pedidos
        # Para remover do select da movimento
        db = con()
        msg_erro = ''
        msg_sis = 'Integrando Vendas para o PDV<br>'
        hj = datetime.now()
        # hj = hj - timedelta(days=session.periodo_integracao)
        hj = hj - timedelta(days=4)
        hj = datetime.strftime(hj,'%m-%d-%Y')
        caixa_usado = 'None'
        # TODO le o ultimo arquivo de retorno com as ultimas atualizacos
        # retorno = open(self.path_retorno, '+r')
        str_ord = '0'
        # TODO buscar caixa aberto
        sqlc = "SELECT FIRST 1 r.IDCAIXACONTROLE, r.CODCAIXA,  \
               r.VALORABRE, r.VALORFECHA  \
               FROM CAIXA_CONTROLE r WHERE r.SITUACAO = '%s' \
               AND DATAABERTURA = '%s' \
               ORDER BY r.CODCAIXA " %('o', hj)
        caixa_aberto = db.query(sqlc)
        for cx in caixa_aberto:
            print(cx[1])
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
        movs = db.query(sqld)
        if not len(movs):
            msg_sis = 'Sem Pedidos para importar.<br>'
        # for mvs in movs:
        #    print ('cod mov: %s' %(str(mvs[0]))) 
        for mvs in movs:
            msg_sis = 'Pedidos novos : %s<br>' %(str(mvs[0]))
            ord_p = False
            ord_name = '%s-%s' %(str(cx[1]),str(mvs[0]))
            arquivo_nome = self.path_envio + '/pedido_%s.json' %(ord_name)
            if os.path.exists(arquivo_nome):
                continue
            teve_desconto = 'n'
            dt_ord = '2018.01.01'
            
            # coloquei so pra manter o if
            if ord_name:
                msg_sis = 'Importando : %s<br>' %(str(mvs[0]))
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
                vals['user_id'] = userid
                vals['user_id'] = 1
                
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
                        prdname = unidecode(md[6])
                    except:
                        prdname = md[6]
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

                    prd['product_id'] = md[8]
                    prd['discount'] = desconto
                    prd['qty'] = md[2]
                    prd['price_unit'] = md[3]
                    prd['tipo_venda'] = tipo
                    prd['name'] = prdname

                    order_line.append((0, 0,prd))
                if troca:
                    prd = {}
                    prd['product_id'] = 2
                    prd['qty'] = 1
                    prd['price_unit'] = troca * (-1)
                    prd['tipo_venda'] = tipo
                    prd['name'] = 'Troca/Devolucao'
                    order_line.append((0, 0,prd))

                vals['amount_return'] = vlr_total
                vals['lines'] = order_line
                
                vals['statement_ids'] = pag_line
                
                if teve_desconto == 's':
                    # uso nb_print pra saber q veio do pdv lazarus
                    vals['nb_print'] = 9

                # try:
                vals_ped = vals 
                nomecliente = mvs[8]
                nomecliente = (nomecliente)
                #nomecliente = normalize('NFKD', nomecliente).encode('ASCII','ignore').decode('ASCII')
                #nomecliente = re.sub(u'[^a-zA-Z0-9áéíóúÁÉÍÓÚâêîôÂÊÎÔãõÃÕçÇ: ]', '', nomecliente.decode('utf-8'))
                vals_ped['nomecliente'] = nomecliente
                dados_vals = json.dumps(vals_ped)
                if not os.path.exists(arquivo_nome):
                    arquivo_json = open(arquivo_nome, 'w')
                    arquivo_json.write(dados_vals)
                    arquivo_json.close()

                # except:
                msg_erro += 'ERRO, não integrado pedido : %s<br>' %(prdname)

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
        #    msg_sis = 'Sem Pedidos para importar.<br>'
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
        
        #print ('Integracao realizada com sucesso.')
        #msg_sis += 'Integracao Finalizada.<br>'

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
        #        msg_sis = 'CAIXA FECHADO , COM SUCESSO.<br>'
        return msg_sis + '<br>' + msg_erro

# class PosConfig(models.Model):
    # _inherit = 'pos.config'
    
    # ip_terminal = fields.Char(string='ip Terminal Vendas')
    # database = fields.Char(string='Banco de Dados')
    
    # def action_testar_acesso_terminal(self):
    #     try:
    #         db = con.Conexao(self.ip_terminal, self.database)
    #     except:
            # raise UserError(u'Caminho ou nome do banco inválido.')

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
