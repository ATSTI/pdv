# -*- encoding: utf-8 -*-

import odoorpc
from datetime import datetime
from datetime import date
from datetime import timedelta
import atscon as con
import re
import sys

_table = { 
    "á" : "a", "à" : "a", "â" : "a", "ä" : "a", "ã" : "a", "å" : "a",
    "é" : "e", "è" : "e", "ê" : "e", "ë" : "e",
    "í" : "i", "ì" : "i", "î" : "i", "ï" : "i",
    "ó" : "o", "ò" : "o", "ô" : "o", "ö" : "o", "õ" : "o", "ø" : "o", 
    "ú" : "u", "ù" : "u", "û" : "u", "ü" : "u",
    "ñ" : "n", "ç" : "c",
    "Á" : "A", "À" : "A", "Â" : "A", "Ä" : "A", "Ã" : "A", "Å" : "A",
    "É" : "E", "È" : "E", "Ê" : "E", "Ë" : "E", 
    "Í" : "I", "Ì" : "I", "Î" : "I", "Ï" : "I", 
    "Ó" : "O", "Ò" : "O", "Ô" : "O", "Ö" : "O", "Õ" : "O", "Ø" : "O",
    "Ú" : "U", "Ù" : "U", "Û" : "U", "Ü" : "U", 
    "Ñ" : "N", "Ç" : "C",
    "ß" : "ss", "Þ" : "d" , "æ" : "ae", "º": ".", "ª": ".", "'": ""
}



class AtsOrder:

    def asciize(self,s):
        """ 
        Converts a entire string to a ASCII only string.

        string
           The string to be converted.
        """
        for original, plain in _table.items():
            s = s.replace(original, plain)
        return s

    ######## IMPORTAR VENDAS
    def order(self):
        #import pdb; pdb.set_trace()
        
        db = con.Conexao()
        sist = db.sistema()
        #arq = open('C:\home\programas\lazarus\pdv\pdv\log_pedido.log', 'w')
        #order = odoo.env['pos.order']
        hj = datetime.now()
        hj = hj - timedelta(days=2)
        hj = datetime.strftime(hj,'%m-%d-%Y')
        caixa_usado = 'None'
        sqld = 'SELECT m.CODMOVIMENTO, m.DATAMOVIMENTO, ' \
               'm.CODCLIENTE, m.STATUS, m.CODUSUARIO, m.CODVENDEDOR, ' \
               'm.CODALMOXARIFADO, DATEADD(3 hour to m.DATA_SISTEMA) ' \
               '  FROM MOVIMENTO m ' \
               ' WHERE STATUS = 1 ' \
               '   AND DataMovimento > \'%s\'' %(hj)
        movs = db.query(sqld)

        print ('Importando Pedidos .....')
        if not len(movs):
            print ('Sem Pedidos para importar.')
            print ('')
        for mvs in movs:
            #log = 
            #arq.write(log)
            print('Pedidos novos : %s' %(str(mvs[0])))
            pos_ses = sist.env['pos.session'].search([
                ('id', '=', mvs[6])])
            session = sist.env['pos.session'].browse(pos_ses)
            caixa_usado = session.name
            pos_ord = sist.env['pos.order']
            ord_name = '%s-%s' %(str(session.id),str(mvs[0]))
            coding = sys.stdout.encoding
            ord_ids = pos_ord.search([
                ('pos_reference', '=', ord_name)])
            #import pdb; pdb.set_trace()
            #print ('Pedido -'+ str(mvs[0]))
            dt_ord = '2018.01.01'
            if ord_ids:
                ord_p = pos_ord.browse(ord_ids)
                ord_pi = str(ord_p.id)
                print ('ORD: %s' %(ord_pi))
            if not ord_ids:
                #log = 
                #arq.write(log)
                print('Importando : %s' %(str(mvs[0])))
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
                
                sqld = 'SELECT f.CODFORMA, f.FORMA_PGTO, f.VALOR_PAGO, ' \
                    'f.STATE, f.TROCO, f.DESCONTO from FORMA_ENTRADA f' \
                    ' WHERE ID_ENTRADA = %s AND f.STATE = 1' %(str(mvs[0]))
                pag_ids = db.query(sqld)

                pag_line = []
                desconto_t = 0.0
                total_g = 0.0
                for pg in pag_ids:
                    pag = {}
                    if pg[5]:
                        desconto_t += pg[5]
                    total_g += pg[2]
                    jrn = '%s-' %(pg[1])
                    #import pdb; pdb.set_trace()
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
                if desconto_t > 0:
                    desconto_t = desconto_t / total_g
                for md in md_ids:
                    try:
                        prdname = self.asciize(md[6].encode(coding))
                    except:
                        prdname = 'Nada'
                    vlr_total += (md[2]*md[3])-md[4]
                    desconto = 0.0
                    if (md[4] > 0):
                        desconto = md[4] / vlr_total
                    
                    desconto = (desconto + desconto_t) * 100
                    prd = {}
                    tipo = '1'
                    if md[7].strip():
                        tipo = md[7].strip()
                    #import pdb; pdb.set_trace()
                    prd['product_id'] = md[1]
                    prd['discount'] = desconto
                    prd['qty'] = md[2]
                    prd['price_unit'] = md[3]
                    prd['tipo_venda'] = tipo
                    prd['name'] = prdname
                    #prd['order_id'] = session.id
                    order_line.append((0, 0,prd))
                vals['amount_return'] = vlr_total
                vals['lines'] = order_line
                
                vals['statement_ids'] = pag_line
                
                order = pos_ord.create(vals)
                    
                #order.add_payment(pag)
                #sist.env['account.bank.statement.line'].create(pag)
        #arq.close()
        #AND NOMECAIXA = %s ' %(caixa_usado)
        #import pdb; pdb.set_trace()
        sqlc = 'SELECT FIRST 2 r.IDCAIXACONTROLE, r.CODCAIXA,  \
               r.VALORABRE, r.VALORFECHA  \
               FROM CAIXA_CONTROLE r WHERE r.VALORFECHA = 1 \
               ORDER BY r.CODCAIXA DESC '
        caixa_fechado = db.query(sqlc)
        for cx in caixa_fechado:
            pos_ses = sist.env['pos.session'].search([
                ('id', '=', cx[1]), ('state','=','opened')])
            session = sist.env['pos.session'].browse(pos_ses)
            if session:
                session.write({'venda_finalizada': True})
                print ('CAIXA FECHADO , COM SUCESSO.')
 
p = AtsOrder()
p.order()
