#!/usr/local/bin/python3.4
# By Amir Hassan Azimi [http://parsclick.net/]

import sqlite3

class Database:
    def __init__(self, **kwargs):
        self.filename = kwargs.get('filename')
        # Create table
        self._db.execute('''CREATE TABLE IF NOT EXISTS lancamento
             (tipo VARCHAR(12), user INTEGER, nome VARCHAR(60), caixa integer, codigo integer, data_lancamento date)''')
        self.table = kwargs.get('table', 'lancamento')

    def sql_do(self, sql, *params):
        self._db.execute(sql, params)
        self._db.commit()

    def insert(self, row):
        self._db.execute('insert into {} (tipo, user, nome, caixa, codigo, data_lancamento) values (?, ?, ?, ?, ?, ?)'.format(self._table), (
            row['tipo'],
            row['user'],
            row['nome'],
            row['caixa'],
            row['codigo'],
            row['data_lancamento']
        ))
        self._db.commit()

    def consulta(self, tipo, caixa, codigo):
        cursor = self._db.execute('select * from {} where tipo = ? and caixa = ? and codigo = ?'.format(
            self._table), (tipo, caixa, codigo))
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
        cursor = self._db.execute('select * from {} order by tipo, caixa, codigo'.format(self._table))
        for row in cursor:
            print('  {}: {}'.format(row['tipo'], row['caixa'], row['codigo'], row['nome']))

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
    def table(self): self._table = 'lancamento'

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