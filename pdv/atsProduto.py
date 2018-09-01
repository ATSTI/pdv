# -*- encoding: utf-8 -*-

import odoorpc
from datetime import datetime
from datetime import date
from datetime import timedelta
import atscon as con
import re

class AtsProduto:

    ######## IMPORTAR PRODUTOS
    def produtos(self):
        # vendo se a categoria está cadastrada
        #odoo = self.con()
        #import pdb; pdb.set_trace()
        #import pudb;pu.db
        db = con.Conexao()
        sist = db.sistema()
        
        #order = odoo.env['pos.order']
        hj = datetime.now()
        hj = hj - timedelta(days=10)
        hj = datetime.strftime(hj,'%Y-%m-%d %H:%M:%S')
        
        grupo = sist.env['pos.category']
        grupo_ids = grupo.search([('create_date', '>=', hj),('parent_id','!=', False)])
        for grp in grupo.browse(grupo_ids):
            sqlp = 'SELECT a.COD_CATEGORIA, a.COD_FAMILIA FROM CATEGORIAPRODUTO a where a.COD_CATEGORIA = %s' %(grp.id)
            grps = db.query(sqlp)
            if not len(grps):
                # procura a familia
                sqlp = 'SELECT a.COD_FAMILIA FROM FAMILIAPRODUTOS a where a.cod_Familia = %s' %(grp.parent_id.id)
                frps = cur.query(sqlp)
                if not len(frps):
                    insere = 'INSERT INTO FAMILIAPRODUTOS (DESCFAMILIA, COD_FAMILIA) VALUES (\'%s\',%s)'\
                        %(grp.parent_id.name, grp.parent_id.id)
                    db.insert(insere)

                insere = 'INSERT INTO CATEGORIAPRODUTO (DESCCATEGORIA, COD_CATEGORIA, COD_FAMILIA) VALUES (\
                         \'%s\',%s, %s);' %(grp.name, grp.id, grp.parent_id.id)
                db.insert(insere)

        prod_ids = sist.env['product.product'].search([
           ('write_date', '>=', hj),
           ('sale_ok', '=', True)])
        for product_id in sist.env['product.product'].browse(prod_ids):
            ncm = ''
            if product_id.fiscal_classification_id:
                ncm = product_id.fiscal_classification_id.code
                ncm = re.sub('[^0-9]', '', ncm)
            p_custo = 0.0
            if product_id.standard_price:
                p_custo = product_id.standard_price
            p_venda = 0.0
            if product_id.list_price:
                p_venda = product_id.list_price
            produto = product_id.name.encode('ascii', 'ignore')				
            sqlp = 'select codproduto from produtos where codproduto = %s' %(product_id.id)
            prods = db.query(sqlp)
            #import pdb; pdb.set_trace()
            if not len(prods):
                print ('Incluindo - %s' %(product_id.name))
                #import pudb;pu.db
                
                cat = ''
                if product_id.pos_categ_id:
                    cat = product_id.pos_categ_id.name
                fam = ''
                if product_id.pos_categ_id.parent_id:
                    fam = product_id.pos_categ_id.parent_id.name
                codp = str(product_id.id)
                if product_id.default_code:
                    codp = product_id.default_code
                un = product_id.uom_id.name.encode('ascii', 'ignore')
                insere = 'INSERT INTO PRODUTOS (CODPRODUTO, UNIDADEMEDIDA, PRODUTO, PRECOMEDIO, CODPRO,\
                          TIPOPRECOVENDA, ORIGEM, NCM, VALORUNITARIOATUAL, VALOR_PRAZO, TIPO, RATEIO, \
                          QTDEATACADO, PRECOATACADO'
                if fam:
                    insere += ', FAMILIA'
                if cat:
                    insere += ', CATEGORIA'
                insere += ') VALUES ('
                insere += str(product_id.id)
                insere += ', \'' + un.decode() + '\''
                insere += ', \'' + produto.decode() + '\''
                insere += ',' + str(p_custo)
                insere += ', \'' + str(codp) + '\''
                insere += ',\'F\''
                insere += ',' + str(product_id.origin)
                insere += ',\'' + str(ncm) + '\''
                insere += ',' + str(p_custo)
                insere += ',' + str(p_venda)
                insere += ',\'' + str('PROD') + '\''
                insere += ', \'' + product_id.tipo_venda + '\''
                insere += ',' + str(product_id.qtde_atacado)
                insere += ',' + str(product_id.preco_atacado)
                if fam:
                    insere += ', \'' + str(fam) + '\''
                if cat:
                    insere += ', \'' + str(cat) + '\''
                insere += ')'
                print (codp+'-'+product_id.name)
                # print ' Cadastrando : %s - %s' % (str(row[0]), row[1])
                db.insert(insere)
            else:
                print ('Alterando - %s' %(product_id.name))
                altera = 'UPDATE PRODUTOS SET PRODUTO = '
                altera += '\'' + produto.decode() + '\''
                altera += ', VALOR_PRAZO = ' + str(p_venda)
                altera += ', NCM = ' +  '\'' + str(ncm) + '\''
                altera += ', ORIGEM = ' + str(product_id.origin) 
                altera += ', RATEIO = \'' + str(product_id.tipo_venda) + '\''
                altera += ', QTDEATACADO = ' + str(product_id.qtde_atacado) 
                altera += ', PRECOATACADO = ' + str(product_id.preco_atacado) 
                altera += ' WHERE CODPRODUTO = ' + str(product_id.id)
                db.insert(altera)
p = AtsProduto()
p.produtos()
