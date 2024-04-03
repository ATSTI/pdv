# -*- coding: utf-8 -*-

import odoorpc
# import fiscal
import re
from datetime import datetime
from datetime import date
from datetime import timedelta
import atscon as con

import json
import sys
#reload(sys)
#sys.setdefaultencoding("utf-8")

# CONEXAO ODOO ORIGEM
origem = odoorpc.ODOO('felicita.atsti.com.br', port=48069)

#CONEXAO ODOO DESTINO
# Prepare the connection to the server
#odoo = odoorpc.ODOO('192.168.6.100', port=8069)
dest = odoorpc.ODOO('felicita14.atsti.com.br', port=48069)
#dest = odoorpc.ODOO('127.0.0.1', port=14069)
# Login
origem.login('felicita_atsti_com_br', 'ats@atsti.com.br', 'a2t00s7')
dest.login('felicita14', 'ats@atsti.com.br', 'a2t00s7')

# odoo_user = odoo.env['res.users']

b_order = dest.env['pos.order']
db = con.Conexao()
#sist = db.sistema()
#arq = open('C:\home\programas\lazarus\pdv\pdv\log_pedido.log', 'w')
#order = odoo.env['pos.order']
hj = datetime.now()
hj = hj - timedelta(days=1)
hj = datetime.strftime(hj,'%m-%d-%Y')

sqld = "select CODMOVIMENTO,CODALMOXARIFADO from MOVIMENTO where DATAMOVIMENTO > '31.12.2023' and CODVENDEDOR = 40"
#'   AND m.CODMOVIMENTO = 199'
#       ' WHERE m.STATUS = 1 ' \

movs = db.query(sqld)
print ('Importando Pedidos .....')
if not len(movs):
    print ('Sem Pedidos para importar.')
    print ('')
for mvs in movs:
	pedido = f"{mvs[1]}-{mvs[0]}" 
	p = b_order.search([('name', '=', pedido), ('user_id', '!=', 50)])
	if p:
		pedido_id = b_order.browse(p)
		pedido_id.write({'user_id': 50})
		print (pedido)
#return True
	

# import pudb;pu.db
x = 1
if x == 0:
    produto = a_produto.search([('id', '>', 7999), ('id', '<', 9000)], order='id')
    
    for prod in a_produto.browse(produto):
        prod_b = b_produto.search([('default_code', '=', prod.default_code)])
        #import pudb;pu.db
        
        prodb = b_produto.browse(prod_b)
        if prodb.ncm_id:
            continue
        
        
        ncm_b = b_ncm.search([('code', 'ilike', prod.fiscal_classification_id.code)])
        ncmb = b_ncm.browse(ncm_b)
        if not ncmb:
            continue
        print(f"Fazendo produto {prod.default_code}, id = {prod.id}")
        genre = dest.env["l10n_br_fiscal.product.genre"].search(
            [("code", "=", ncmb.code[0:2])]
        )
        vals = {}
        vals['ncm_id'] = ncmb.id
        vals['fiscal_type'] = '00'
        vals['icms_origin'] = prod.origin
        vals['fiscal_genre_id'] = genre[0]

        prodb.write(vals)
        # prodb._onchange_ncm_id()            
           
            #list_adi.append(vLine[0])
            
        #vals['lines'] = [(6, 0, list_adi)]          
        
        
        # se a prazo criando a Fatura



