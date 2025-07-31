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
#import pdb; pdb.set_trace()
connection = fdb.connect(dsn=host, \
    user='sysdba', password= psw, charset='utf-8')
db = connection.cursor()

#reload(sys)
#sys.setdefaultencoding("utf-8")

#CONEXAO ODOO
# Prepare the connection to the server
dest = odoorpc.ODOO('url_odoo', port=48069)
# Login
dest.login('database', 'usuario_odoo', 'pass_odoo')

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
    sqld = "select CODPRODUTO, CODPRO, PRODUTO from PRODUTOS where CODPRO in %s" %(str(cod_pros))
    try:
        fb_prod = db.execute(sqld)
    except:
        print(sqld)
    for fb_p in fb_prod:
        print ('Conferindo item %s' %(fb_p[1]))
        for pr in browse_p[z-100:z]:
            if pr.default_code == fb_p[1]:
                if fb_p[0] == pr.id:
                    conferido += 1
                    continue
                else:
                    print ('Errado Fb codproduto: %s, Odoo id : %s' %(str(fb_p[0]), str(pr.id)))
                    fb_codp = str(fb_p[0])
                    fb_codpro = fb_p[1]
                    odoo = str(pr.id)
                    odoo_code = pr.default_code
                    lista_errados.append({'CODPRODUTO': fb_codp, 'CODPRO': fb_codpro, 'ODOO': odoo, 'DEFAULT_CODE': odoo_code})
                    contar += 1
# CORRIGINDO ITENS
for lst in lista_errados:
    #muda_md = "UPDATE movimentodetalhe set codproduto = 11 WHERE codproduto = %s;" %(lst['CODPRODUTO'])
    muda_se_existe = "UPDATE PRODUTOS set codproduto = codproduto * 100, codpro = substring(codpro from 1 for 14) || '_', USA = 'N' WHERE codproduto = %s;" %(lst['ODOO'])
    corrigir = 'UPDATE PRODUTOS set codproduto = %s WHERE codproduto = %s;' %(lst['ODOO'], lst['CODPRODUTO'])
    #volta_md = "UPDATE movimentodetalhe set codproduto = %s WHERE codproduto = 11;" %(lst['ODOO'])
    try:
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
print('total itens errados %s' %(str(contar)))
#print(str(lista_errados))
print('total itens CONFERIDOS %s' %(str(conferido)))
