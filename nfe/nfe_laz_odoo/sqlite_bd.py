#!/usr/local/bin/python3.4
# By Amir Hassan Azimi [http://parsclick.net/]

import sqlite3

class Database:

    def __init__(self, **kwargs):
        self.filename = kwargs.get('filename')
        # Create table
        self._db.execute('''CREATE TABLE IF NOT EXISTS empresa
             (empresa_id INTEGER, nome VARCHAR(120), razao VARCHAR(120), cnpj VARCHAR(24))''')
        # self.table = kwargs.get('table', 'lancamento')
        self._db.execute('''CREATE TABLE IF NOT EXISTS nfe
            (move_id INTEGER, empresa_id INTEGER, xml_aenviar TEXT, xml_enviado TEXT,\
                protocolo VARCHAR(30), chave VARCHAR(60), \
                destinatario VARCHAR(80), num_nfe VARCHAR(20), data_emissao DATE, situacao VARCHAR(20)
            )''')
        self.table = kwargs.get('table')

    def sql_do(self, sql, *params):
        self._db.execute(sql, params)
        self._db.commit()

    def insert_empresa(self, row):
        sql = "insert into empresa (empresa_id, nome, razao, cnpj) values (%s, '%s', '%s', '%s')" \
            %(row['empresa_id'], row['nome'], row['razao'], row['cnpj'])
        self._db.execute(sql)
        self._db.commit()
    
    def insert_nfe(self, row):
        # import pudb;pu.db
        sql = "insert into nfe (move_id, empresa_id, xml_aenviar, chave, destinatario, \
            num_nfe, data_emissao, situacao) values ('%s', %s, \
            '%s', '%s', '%s', '%s', '%s', '%s')" \
            %(row['move_id'], row['empresa_id'], row['xml_aenviar'],
                row['chave'],
                row['dest'],
                row['num_nfe'],
                row['data_emissao'],
                row['situacao']
            )
        self._db.execute(sql)
        self._db.commit()

    def consulta_nfe(self, chave=None, empresa_id=None):
        if not empresa_id:
            # bloqueia a busca sem informar a empresa
            empresa_id = 1
        busca = "select * from {} where empresa_id = %s " %(str(empresa_id))
        if chave:
            busca += " and chave like '%s'" %(chave)
        busca += " order by num_nfe desc"
        cursor = self._db.execute(busca.format(self._table))
        dados = cursor.fetchall()
        if not dados:
            return False
        list_accumulator = []
        # import pudb;pu.db
        for item in dados:
            if item['situacao'] == 'A_enviar':
                excluir = "DELETE FROM {} WHERE empresa_id = %s and num_nfe = %s" %(
                    str(empresa_id),
                    item['num_nfe']
                )
                self._db.execute(excluir.format(self._table))
                continue
            list_accumulator.append({k: item[k] for k in item.keys()})
        if len(list_accumulator):
            return list_accumulator
        else:
            return False


    def consulta_empresa(self, empresa_id=None, nome=None, cnpj=None):
        busca = "select * from {}"
        if empresa_id:
            busca += " where empresa_id = " + str(empresa_id)
        if nome:
            busca += " where nome like '%s' or razao like '%s'" %(nome)
        if cnpj:
            busca += " where cnpj like '%s'" %(cnpj)
        cursor = self._db.execute(busca.format(self._table))
        dados = cursor.fetchone()
        if not dados:
            return False
        return dict(dados)

    def update(self, row):
        self._db.execute(row)
            # 'update {} set i1 = ? where t1 = ?'.format(self._table),
            # (row['i1'], row['t1']))
        self._db.commit()

    def delete(self, key):
        self._db.execute('delete from {} where codigo = ?'.format(self._table), (key,))
        self._db.commit()

    def disp_rows(self):
        cursor = self._db.execute('select * from {} order by nome, razao, cnpj'.format(self._table))
        for row in cursor:
            print('  {}: {}'.format(row['empresa_id'], row['nome'], row['razao'], row['cnpj']))

    def __iter__(self):
        cursor = self._db.execute('select * from {} order by tipo'.format(self._table))
        for row in cursor:
            yield dict(row)

    @property
    def filename(self): return self._filename
    @filename.setter
    def filename(self, fn):
        self._filename = fn
        self._db = sqlite3.connect(fn)
        self._db.row_factory = sqlite3.Row
    @filename.deleter
    def filename(self): self.close()
    @property
    def table(self): return self._table
    @table.setter
    def table(self, t): self._table = t
    @table.deleter
    def table(self): self._table = 'nfe'

    def close(self):
            self._db.close()
            del self._filename

# Exemplo de uso

# def main():
#     db = Database(filename = 'test.db', table = 'test')

#     print('Create table test')
#     db.sql_do('drop table if exists test')
#     db.sql_do('create table test ( t1 text, i1 int )')

#     print('Create rows')
#     db.insert(dict(t1 = 'one', i1 = 1))
#     db.insert(dict(t1 = 'two', i1 = 2))
#     db.insert(dict(t1 = 'three', i1 = 3))
#     db.insert(dict(t1 = 'four', i1 = 4))
#     for row in db: print(row)

#     print('Retrieve rows')
#     print(db.retrieve('one'), db.retrieve('two'))

#     print('Update rows')
#     db.update(dict(t1 = 'one', i1 = 101))
#     db.update(dict(t1 = 'three', i1 = 103))
#     for row in db: print(row)

#     print('Delete rows')
#     db.delete('one')
#     db.delete('three')
#     for row in db: print(row)

# if __name__ == "__main__": main()