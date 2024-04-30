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
a_prod = origem.env['product.product']
b_prod = dest.env['product.product']
# db = con.Conexao()
#sist = db.sistema()
#arq = open('C:\home\programas\lazarus\pdv\pdv\log_pedido.log', 'w')
#order = odoo.env['pos.order']
hj = datetime.now()
hj = hj - timedelta(days=1)
hj = datetime.strftime(hj,'%m-%d-%Y')

x = sys.argv[1]
y = sys.argv[2]
print (f"fazendo id : {x} - {y}")
"""
p = a_prod.search([('id', '>', x), ('id', '<', y)])
for pr in a_prod.browse(p):
    pbd = b_prod.search([('default_code', '=', pr.default_code)])
    preco_a = round(pr.list_price,2)
    if pbd:
        prod_id = b_prod.browse(pbd)
        preco_b = round(prod_id.list_price,2)
        if preco_a == preco_b:
            continue
        prod_id.write({'list_price': preco_a})
        print (f"produto: {prod_id.product_tmpl_id.id} preco_a {preco_a} preco_b {preco_b}")
"""

import pudb;pu.db
p = a_prod.search([('qtde_atacado', '>', 0)])
for pr in a_prod.browse(p):
    pbd = b_prod.search([('default_code', '=', pr.default_code)])
    if pbd:
        prod_id = b_prod.browse(pbd)
        prod_id.write({'qtde_atacado': pr.qtde_atacado, 'preco_atacado': pr.preco_atacado})
        print (f"produto: {prod_id.product_tmpl_id.id}")
    
# Corringindo user_id do pos order
"""
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
"""	

