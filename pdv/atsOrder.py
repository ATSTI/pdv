# -*- encoding: utf-8 -*-

import odoorpc
from datetime import datetime
from datetime import date
from datetime import timedelta
import atscon as con
import re

class AtsOrder:

    ######## IMPORTAR VENDAS
    def order(self):
        #import pdb; pdb.set_trace()
        
        db = con.Conexao()
        sist = db.sistema()
        
        #order = odoo.env['pos.order']
        hj = datetime.now()
        hj = hj - timedelta(days=1)
        hj = datetime.strftime(hj,'%m-%d-%Y')

        sqld = 'SELECT m.CODMOVIMENTO, m.DATAMOVIMENTO, ' \
               'm.CODCLIENTE, m.STATUS, m.CODUSUARIO, m.CODVENDEDOR, ' \
               'm.CODALMOXARIFADO, DATEADD(3 hour to m.DATA_SISTEMA) ' \
               '  FROM MOVIMENTO m ' \
               ' WHERE STATUS = 1 ' \
               '   AND DataMovimento > \'%s\'' %(hj)
        movs = db.query(sqld)
        #import pudb;pu.db
        for mvs in movs:
            pos_ses = sist.env['pos.session'].search([
                ('id', '=', mvs[6])])
            session = sist.env['pos.session'].browse(pos_ses)
            pos_ord = sist.env['pos.order']
            ord_name = '%s-%s' %(str(session.id),str(mvs[0]))
            ord_ids = pos_ord.search([
                ('pos_reference', '=', ord_name)])
            #import pdb; pdb.set_trace()
            print ('Pedido -'+ str(mvs[0]))
            dt_ord = '2018.01.01'
            if not ord_ids:
                # cortesia = tipo_venda n
                vals = {}               
                
                cli = mvs[2]
                dt_ord = str(mvs[7])
                vals['name'] = ord_name
                vals['pos_reference'] = ord_name
                vals['session_id'] = mvs[6]
                vals['pos_session_id'] = mvs[6]
                vals['pricelist_id'] = session.config_id.pricelist_id.id
                vals['creation_date'] = dt_ord #datetime.strftime(datetime.now(),'%Y-%m-%d %H:%M:%S')
                vals['date_order'] = dt_ord
                vals['sequence_number'] = mvs[0]
                
                if cli != 1:
                    vals['partner_id'] = cli
                else:
                    vals['partner_id'] = sist.env['res.partner'].search([
                        ('name','ilike','consumidor')],limit=1)[0]
                userid = mvs[5]
                if mvs[5] == 2:
                    userid = 1
                vals['user_id'] = userid
                vals['fiscal_position_id'] = session.config_id.default_fiscal_position_id.id
                #ord_id = pos_ord.create(vals)
                order_line = []
                sqld = 'SELECT md.CODDETALHE, md.CODPRODUTO, ' \
                    ' md.QUANTIDADE, md.PRECO, COALESCE(md.VALOR_DESCONTO,0),' \
                    ' md.BAIXA, md.DESCPRODUTO, md.CORTESIA ' \
                    ' FROM MOVIMENTODETALHE md ' \
                    ' WHERE md.STATUS = 0 AND md.CodMovimento = %s' %(str(mvs[0]))
                md_ids = db.query(sqld)
                #order = pos_ord.browse(ord_id)
                #order.write({'fiscal_position_id' : })
                vlr_total = 0.0
                for md in md_ids:
                    vlr_total += (md[2]*md[3])-md[4]
                    prd = {}
                    tipo = '1'
                    if md[7].strip():
                        tipo = md[7].strip()
                    prd['product_id'] = md[1]
                    prd['discount'] = md[4]
                    prd['qty'] = md[2]
                    prd['price_unit'] = md[3]
                    prd['tipo_venda'] = tipo
                    prd['name'] = md[6]
                    #prd['order_id'] = session.id
                    order_line.append((0, 0,prd))
                vals['amount_return'] = vlr_total
                #order.write({'lines':order_line})
                vals['lines'] = order_line
                sqld = 'SELECT f.CODFORMA, f.FORMA_PGTO, f.VALOR_PAGO, ' \
                    'f.STATE, f.TROCO, f.DESCONTO from FORMA_ENTRADA f' \
                    ' WHERE ID_ENTRADA = %s' %(str(mvs[0]))
                pag_ids = db.query(sqld)

                pag_line = []
                #import pudb;pu.db
                for pg in pag_ids:
                    #if pg[1] == '4':
                    #    vals['state'] = 'invoiced'
                    #else:
                    #    vals['state'] = 'paid'
                    pag = {}
                    jrn = '%s-' %(pg[1])
                    jrn_id = sist.env['account.journal'].search([
                        ('name','like', jrn)])[0]
                    for stt in session.statement_ids:
                        if stt.journal_id.id == jrn_id:
                            pag['statement_id'] = stt.id
                        
                    company_cxt = sist.env['account.journal'].browse(jrn_id).company_id.id   
                    pag['account_id'] = sist.env['res.partner'].browse(cli).property_account_receivable_id.id
                    pag['date'] = dt_ord
                    pag['amount'] = pg[2]
                    pag['journal_id'] = jrn_id
                    pag['journal'] = jrn_id
                    pag['partner_id'] = cli
                    pag['name'] = ord_name
                    pag_line.append((0, 0,pag))
                #order.write({'statement_ids':pag_line})
                #import pudb;pu.db
                vals['statement_ids'] = pag_line
                pos_ord.create(vals)
                    
                #order.add_payment(pag)
                #sist.env['account.bank.statement.line'].create(pag)
                    
p = AtsOrder()
p.order()
