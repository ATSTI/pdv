# -*- encoding: utf-8 -*-

import odoorpc
from datetime import datetime
from datetime import date
from datetime import timedelta
import atscon as con


class AtsCliente:
        
    ######## IMPORTAR CLIENTES
    def clientes(self):
        db = con.Conexao()
        sist = db.sistema()
        
        #import pudb;pu.db
        #order = odoo.env['pos.order']
        hj = datetime.now()
        hj = hj - timedelta(days=220)
        hj = datetime.strftime(hj,'%Y-%m-%d %H:%M:%S')

        cliente = sist.env['res.partner']
        #if cliente_id == 0:
        cli_ids = cliente.search([('create_date', '>=', hj), ('customer','=', True)])
        #else:
        #    cli_ids = cliente_id
        for partner_id in cliente.browse(cli_ids):
            sqlc = 'select codcliente from clientes where codcliente = %s' %(partner_id.id)
            cli = db.query(sqlc)
            if not len(cli):
               tipo = '0'
               if partner_id.is_company:
                   tipo = '1'
               vendedor = '1'
               if partner_id.user_id.id:
                   vendedor = str(partner_id.user_id.id)
               ie = ''
               if partner_id.inscr_est:
                   ie = partner_id.inscr_est
               fiscal = 'J'
               #if partner_id.property_account_position:
               #    fiscal = partner_id.property_account_position.note
               nome = partner_id.name.encode('ascii', 'ignore')
               if partner_id.legal_name:
                   razao = partner_id.legal_name.encode('ascii', 'ignore')
               else:
                   razao = nome
                   
               insere = 'insert into clientes (\
                            CODCLIENTE, NOMECLIENTE, RAZAOSOCIAL,\
                            TIPOFIRMA,CNPJ, INSCESTADUAL,\
                            SEGMENTO, REGIAO, LIMITECREDITO,\
                            DATACADASTRO, CODUSUARIO, STATUS, CODBANCO, CODFISCAL)\
                            values (%s, \'%s\', \'%s\',\
                            %s, \'%s\',\'%s\',\
                            %s, %s, %s,\
                            %s, %s, %s, %s, \'%s\')'\
                            %(str(partner_id.id), str(nome),str(razao), \
                            tipo, partner_id.cnpj_cpf, ie,\
                            '1', '0', '0.0',\
                            'current_date', vendedor, '1', '1', fiscal)
               print(partner_id.name.encode('ascii', 'ignore'))
               db.insert(insere)
               fone = 'Null'
               ddd = 'Null'
               if partner_id.phone:
                   fone = '''%s''' %(partner_id.phone[4:])
                   ddd = '''%s''' %(partner_id.phone[1:3])
               fone1 = 'Null'
               ddd1 = 'Null'
               if partner_id.mobile:
                   fone1 = '''%s''' %(partner_id.mobile[4:])
                   ddd1 = partner_id.mobile[1:3]
               fone2 = 'Null'
               ddd2 = 'Null'
               if partner_id.fax:
                   fone2 = partner_id.fax[4:]
                   ddd2 = partner_id.fax[1:3]
               #buscar Cidade/UF/Pais
               cidade = 'Null'
               ibge = 'Null'
               uf = 'Null'
               pais = 'Null'
               if partner_id.city_id:
                   cidade = partner_id.city_id.name[:39]
                   if partner_id.city_id.ibge_code:
                        ibge = '%s%s-%s' %(partner_id.city_id.state_id.ibge_code, \
                                      partner_id.city_id.ibge_code[:4], \
                                      partner_id.city_id.ibge_code[4:])
                   uf = partner_id.city_id.state_id.code
                   pais = partner_id.city_id.state_id.country_id.name
               endereco = 'Null'
               if partner_id.street:
                   endereco = partner_id.street[:49]
               bairro = 'Null'
               if partner_id.district:
                   bairro = partner_id.district[:29]
               complemento = 'Null'
               if partner_id.street2:
                   complemento = partner_id.street2[:29]
               cep = 'Null'
               if partner_id.zip:
                   cep = '%s-%s' %(partner_id.zip[:5], \
                                   partner_id.zip[5:])
                   cep = cep[:10]
               email = 'Null'
               if partner_id.email:
                   email = partner_id.email[:255]
               obs = 'Null'
               if partner_id.comment:
                   obs = partner_id.comment[:199]
               numero = 'Null'
               if partner_id.number:
                   numero = partner_id.number[:5]
               inserir = 'INSERT INTO ENDERECOCLIENTE (CODENDERECO, \
                          CODCLIENTE, LOGRADOURO, BAIRRO, COMPLEMENTO,\
                          CIDADE, UF, CEP, TELEFONE, TELEFONE1, TELEFONE2,\
                          E_MAIL, TIPOEND,\
                          DADOSADICIONAIS, DDD, DDD1, DDD2,\
                          NUMERO, CD_IBGE, PAIS) VALUES ('
               inserir += str(partner_id.id)
               inserir += ',' + str(partner_id.id)
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
               if fone != 'Null':
                   inserir += ', \'%s\'' % (fone)
               else:
                   inserir += ', Null'
               if fone1 != 'Null':
                   inserir += ', \'%s\'' % (fone1)
               else:
                   inserir += ', Null'
               if fone2 != 'Null':
                   inserir += ', \'%s\'' % (fone2)
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
               if ddd != 'Null':
                   inserir += ', \'%s\'' % (ddd)
               else:
                   inserir += ', Null'
               if ddd1 != 'Null':
                   inserir += ', \'%s\'' % (ddd1)
               else:
                   inserir += ', Null'
               if ddd2 != 'Null':
                   inserir += ', \'%s\'' % (ddd2)
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
               print(partner_id.street)
               db.insert(inserir)


p = AtsCliente()
p.clientes()
