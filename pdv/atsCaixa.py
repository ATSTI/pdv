# -*- encoding: utf-8 -*-

import odoorpc
from datetime import datetime
from datetime import date
from datetime import timedelta
import atscon as con

class AtsCaixa:

    ######## IMPORTAR CAIXA
    def caixas(self):
        
        db = con.Conexao()
        sist = db.sistema()
        arq = open('log_integracao.log', 'w')
        hj = datetime.now()
        hj = hj - timedelta(days=5)
        hj = datetime.strftime(hj,'%Y-%m-%d %H:%M:%S')
        #import pudb;pu.db
        #import pdb; pdb.set_trace()
        usuario = sist.env['res.users']
        user_ids = usuario.search([('write_date', '>=', hj)])
        
        for usr in usuario.browse(user_ids):
            log = 'Usuarios novos : %s\n' %(usr.name.encode('ascii', 'ignore').decode('ascii'))
            arq.write(log)
            sqlp = 'SELECT CODUSUARIO FROM USUARIO where CODUSUARIO = %s' %(str(usr.id))
            usrq = db.query(sqlp)
            if not len(usrq):
                barcode = ''
                if usr.barcode:
                    barcode = usr.barcode
                log = 'Cadastrando Usuario novo : %s\n' %(usr.name.encode('ascii', 'ignore').decode('ascii'))
                arq.write(log)
                insere = 'INSERT INTO USUARIO (CODUSUARIO, NOMEUSUARIO, '
                insere += 'STATUS, PERFIL, SENHA, CODBARRA) VALUES ('
                insere += '%s'
                insere += ',\'%s\''
                insere += ', 1'
                insere += ',\'CAIXA\','
                insere += ',\'CAIXA\','
                insere += ',\'%s\');'
                insere = insere %(str(usr.id), str(usr.name), str(barcode))
                db.insert(insere)

        sessao = sist.env['pos.session']
        # ('state','=', 'opened')
        sessao_ids = sessao.search([
            ('create_date', '>=', hj),
            ])
        #('state','=','opened')
        #import pdb; pdb.set_trace()
        for ses in sessao.browse(sessao_ids):
            log = 'Caixas aberto: %s\n' %(ses.name.encode('ascii', 'ignore').decode('ascii'))
            arq.write(log)
            
            sqlp = 'SELECT CODCAIXA FROM CAIXA_CONTROLE where CODCAIXA = %s' %(str(ses.id))
            sess = db.query(sqlp)
            if not len(sess):
                log = 'Inserindo Caixa: %s\n' %(ses.name.encode('ascii', 'ignore').decode('ascii'))
                arq.write(log)
                state = 'c' # close
                if ses.state == 'opened':
                    state = 'o'
                insere = 'INSERT INTO CAIXA_CONTROLE (IDCAIXACONTROLE, '
                insere += 'CODCAIXA, CODUSUARIO, SITUACAO, DATAFECHAMENTO'
                insere += ',NOMECAIXA) VALUES ('
                insere += '%s'
                insere += ',%s'
                insere += ',%s'
                insere += ',\'%s\''
                insere += ',\'%s\''
                insere += ',\'%s\');'
                #import pudb;pu.db
                insere = insere %(str(ses.id), str(ses.id), str(ses.user_id.id), str(state) \
                ,str('01.01.2018'), str(ses.name))
                db.insert(insere)
            else:
                if ses.state != 'opened':
                    altera = 'UPDATE CAIXA_CONTROLE SET SITUACAO = \'F\''
                    altera += ' WHERE IDCAIXACONTROLE = %s' %(str(ses.id))
                    db.insert(altera)
        arq.close()
p = AtsCaixa()
p.caixas()
