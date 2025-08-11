# -*- coding: utf-8 -*-

import odoorpc
import re
from datetime import datetime
from datetime import date
from datetime import timedelta
import configparser
import fdb
import json
import sys



cfg = configparser.ConfigParser()
cfg.read('conf.ini')
psw = cfg.get('DATABASE', 'password')
#psw = base64.b64decode(psw)
host = cfg.get('DATABASE', 'HostName')
name = cfg.get('DATABASE', 'user')
url_odoo = cfg.get('INTEGRA', 'url')
database_odoo = cfg.get('INTEGRA', 'db')
user_odoo = cfg.get('INTEGRA', 'login')
pass_odoo = cfg.get('INTEGRA', 'password')
port_odoo = cfg.get('INTEGRA', 'port')
#import pdb; pdb.set_trace()
connection = fdb.connect(dsn=host, \
    user='sysdba', password= psw, charset='utf-8')
db = connection.cursor()

#reload(sys)
#sys.setdefaultencoding("utf-8")

#CONEXAO ODOO
# Prepare the connection to the server
dest = odoorpc.ODOO(url_odoo, port=port_odoo)
# Login
dest.login(database_odoo, user_odoo, pass_odoo)

# odoo_user = odoo.env['res.users']

b_prod = dest.env['product.product']

x = sys.argv[1]
y = sys.argv[2]
print (f"fazendo id : {x} - {y}")

p = b_prod.search([('id', '>', x), ('id', '<', y)], order='id')
contar = 0
conferido = 0
browse_p = b_prod.browse(p)
busca = 100

sqld = "UPDATE PRODUTOS set COD_BARRA = Null WHERE USA = 'N' and COD_BARRA is not null;"
db.execute(sqld)
connection.commit()
print(' limpando codigo de barra produtos inativos')
#breakpoint()
contar = 0
contar_correcao = 0
for pr in browse_p:
    code = pr.default_code[:15]
    sqld = "select CODPRODUTO, CODPRO, PRODUTO, COD_BARRA, USA from PRODUTOS where (CODPRODUTO = " + str(pr.id) + ") OR (CODPRO = '" + code + "') order by usa desc"
    #try:
    if sqld:
        fb_prod = db.execute(sqld)
        achou = False
        precisa_update = False
        #corrigir = ''
        for fb in fb_prod:
            #print('CODPRO / DEFAULT_CODE : %s - %s - %s' %(fb[1], pr.default_code, str(pr.id)))
            achou = True
            if fb[4] == 'N':
                #print('ITEM FIREBIRD : CODPRO : %s - id: %s' %(fb[1], str(fb[0])))
                #print(' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   ITEM ODOO : DEFAULT_CODE : %s - id: %s' %(pr.default_code, str(pr.id)))
                #if pr.barcode:
                #    corrigir = "UPDATE PRODUTOS set USA = 'S', CODPRO = '%s', COD_BARRA = '%s' WHERE codproduto = %s;" %(pr.default_code, pr.barcode, str(pr.id))
                #else:
                #    corrigir = "UPDATE PRODUTOS set USA = 'S', CODPRO = '%s' WHERE codproduto = %s;" %(pr.default_code, str(pr.id))
                precisa_update = True
                print('USA = N (id: %s): %s - %s' %(str(pr.id), fb[1], pr.default_code))
            else:
                if fb[1] != pr.default_code:
                    if fb[4] == 'N':
                        continue
                    precisa_update = True
                    print('CODPRO diferente (id: %s): %s - %s' %(str(pr.id), fb[1], pr.default_code))
        #if corrigir:
        #    try:
        #        db.execute(corrigir)
        #        connection.commit()
        #    except:
        #        print('ERRO UPDATE codigo barras : %s' %(corrigir))            
        #data_nova = datetime.strptime(pr.write_date,'%m/%d/%Y %H:%M:%S')
        data_fb = datetime.strftime(pr.write_date,'%Y.%m.%d, %H:%M:%S.0000')
        vp = str(pr.list_price)
        va = str(pr.standard_price)

        if precisa_update:
            print('CODPRO DIFERENTE (id: %s) : CODPRO : %s - id: %s' %(str(pr.id), fb[1], str(fb[0])))
            print(' UPDATE GERAL   ITEM ODOO : DEFAULT_CODE : %s - id: %s' %(pr.default_code, str(pr.id)))
            
            # se existir este codpro entao coloca como NULL
            code = pr.default_code[:14] + '_'
            corrigir = corrigir = "UPDATE PRODUTOS set COD_BARRA = Null, USA = 'N', CODPRO = '" + code + "' WHERE CODPRO = '" + pr.default_code + "'"
            try:
                db.execute(corrigir)
                connection.commit()
            except:
                print('ERRO CORRECAO CODIGO ENCONTRADO : %s' %(corrigir))

            if pr.barcode:
                corrigir = corrigir = "UPDATE PRODUTOS set COD_BARRA = Null, USA = 'N' WHERE COD_BARRA = '" + pr.barcode + "'"
                try:
                    db.execute(corrigir)
                    connection.commit()
                except:
                    print('ERRO CORRECAO CODIGO ENCONTRADO : %s' %(corrigir))
            
            corrigir = "UPDATE PRODUTOS set CODPRO = '" + pr.default_code + "'"
            corrigir += ", UNIDADEMEDIDA = '" + pr.uom_id.name + "'"
            corrigir += ", PRODUTO = '" + pr.name.replace('\'','') + "'"
            corrigir += ", TIPOPRECOVENDA = " + '\'F\''
            corrigir += ", USA = Null "
            corrigir += ", ORIGEM = "  + '0'
            corrigir += ", TIPO = " + '\'' + str('PROD') + '\''
            corrigir += ", VALORUNITARIOATUAL = " + vp
            corrigir += ", VALOR_PRAZO = " + vp
            corrigir += ", DATACADASTRO = " +  '\'' + data_fb + '\''
            if pr.barcode:
                corrigir += ", COD_BARRA = '%s' WHERE codproduto = %s;" %(pr.barcode, str(pr.id))
            else:
                corrigir += " WHERE codproduto = %s;" %(str(pr.id))
            try:
                db.execute(corrigir)
                connection.commit()            
            except:
                print('ERRO UPDATE  : %s' %(corrigir))
            contar_correcao += 1
        if not achou:
            contar += 1
            ncm = ''
            if pr.ncm_id:
                ncm = pr.ncm_id.code.replace('.', '')
            un = pr.uom_id.name
            produto = re.sub('[^a-zA-Z0-9 \\\]', '', pr.name)
            codpro = pr.default_code
            barcode = pr.barcode
            insere = 'INSERT INTO PRODUTOS (CODPRODUTO, UNIDADEMEDIDA, PRODUTO, CODPRO,\
                        TIPOPRECOVENDA, ORIGEM, TIPO, VALORUNITARIOATUAL, VALOR_PRAZO, DATACADASTRO'
            if ncm:
                insere +=  ',NCM'
            if barcode:
                insere +=  ', COD_BARRA'
            insere += ') VALUES (' + str(pr.id)
            insere += ',\'' + un + '\''
            insere += ', \'' + produto + '\''
            insere += ', \'' + str(codpro) + '\''
            insere += ',\'F\''
            insere += ', 0'
            insere += ',\'' + str('PROD') + '\''
            #insere += ', \'' + tipo_venda + '\''
            #insere += ',' + str(codproduto)
            insere += ',' + vp
            insere += ',' + vp
            insere += ',\'' + data_fb + '\''
            #if familia:
            #    insere += ', \'' + familia + '\''
            #if marca:
            #    insere += ', \'' + marca + '\''
            if ncm:
                insere += ',\'' + str(ncm) + '\''
            if barcode:
                insere += ',\'' + str(barcode) + '\''
                
            insere += ')'
            sqld = insere
            #print(sqld)
            print(' INSERINDO  : %s-%s' %(str(pr.id),codpro))
            db.execute(sqld)
            connection.commit()            
    #except:
    #    print(sqld)
print('INSERINDO/CORRIGIDO  %s NOVOS ITENS, CORRIGIDO %s' %(str(contar), str(contar_correcao)))
exit()


# DICIONARIO
lista_errados = []
while busca < int(y)+1:
    z = busca
    busca += 100
    # SET
    lista = set()
    print ('GRUPO %s' %(z))
    for pr in browse_p[z-100:z]:
        #print('xxxxxxx' + str(pr.id) + '-' + str(pr.product_tmpl_id) + '-' + str(pr.default_code))
        lista.add(pr.default_code)
    #print(lista)
    lst = str(lista).replace(',', '') if len(lista) == 1 else lista
    if not len(lst):
        continue
    cod_pros = tuple(lst)
    #breakpoint()
    sqld = "select CODPRODUTO, CODPRO, PRODUTO, COD_BARRA from PRODUTOS where CODPRO in %s" %(str(cod_pros))
    try:
        fb_prod = db.execute(sqld)
    except:
        print(sqld)
    for fb_p in fb_prod:
        print ('Conferindo item %s' %(fb_p[1]))
        for pr in browse_p[z-100:z]:
            if pr.default_code == fb_p[1] and pr.barcode == fb_p[3]:
                if fb_p[0] == pr.id:
                    conferido += 1
                    continue
                else:
                    print ('Errado Fb codproduto: %s, Odoo id : %s' %(str(fb_p[0]), str(pr.id)))
                    fb_codp = str(fb_p[0])
                    fb_codpro = fb_p[1]
                    odoo_barcode = pr.barcode or ''
                    odoo = str(pr.id)
                    odoo_code = pr.default_code
                    lista_errados.append({'CODPRODUTO': fb_codp, 'CODPRO': fb_codpro, 'ODOO': odoo, 'DEFAULT_CODE': odoo_code, 'BARCODE': odoo_barcode})
                    contar += 1
# CORRIGINDO ITENS
for lst in lista_errados:
    #muda_md = "UPDATE movimentodetalhe set codproduto = 11 WHERE codproduto = %s;" %(lst['CODPRODUTO'])
    if lst['BARCODE']:
        limpa_barcode = "UPDATE PRODUTOS set COD_BARRA = Null WHERE codproduto = %s AND USA = 'N';" %(lst['ODOO'])
        corrigir_barcode = 'UPDATE PRODUTOS set COD_BARRA = %s WHERE codproduto = %s;' %(lst['BARCODE'], lst['CODPRODUTO'])
    else:
        muda_se_existe = "UPDATE PRODUTOS set codproduto = codproduto * 100, codpro = substring(codpro from 1 for 14) || '_', USA = 'N', COD_BARRA = Null WHERE codproduto = %s;" %(lst['ODOO'])
        corrigir = 'UPDATE PRODUTOS set codproduto = %s WHERE codproduto = %s;' %(lst['ODOO'], lst['CODPRODUTO'])
    #volta_md = "UPDATE movimentodetalhe set codproduto = %s WHERE codproduto = 11;" %(lst['ODOO'])
    try:
        limpou_codigo_barra = False
        if lst['BARCODE']:
            breakpoint()
            limpou_codigo_barra = True
            db.execute(limpa_barcode)
            print(' limpando codigo de barra : %s-%s' %(str(lst['CODPRODUTO']),lst['CODPRO']))
            connection.commit()
            db.execute(corrigir_barcode)
            print(' corrigindo codigo de barra : %s-%s' %(str(lst['CODPRODUTO']),lst['CODPRO']))
            connection.commit()
        else:
            #breakpoint()
            #db.execute(muda_md)
            #connection.commit()
            db.execute(muda_se_existe)
            connection.commit()
            db.execute(corrigir)
            connection.commit()
            #db.execute(volta_md)
            #connection.commit()        
            print('CORRIGIDO : %s-%s' %(str(lst['CODPRODUTO']),lst['CODPRO']))
    except:
        print(muda_se_existe)
        print(corrigir)
        if limpou_codigo_barra:
            print(limpa_barcode)
            print(corrigir_barcode)
print('total itens errados %s' %(str(contar)))
#print(str(lista_errados))
print('total itens CONFERIDOS %s' %(str(conferido)))
