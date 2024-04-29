import psycopg2

lista_databases = ['freitas, jpagronegocios']
conn = psycopg2.connect(
    host="localhost",
    port=5432,
    dbname="nome_do_banco_de_dados",
    user="usuario",
    password="senha"
)

cur = conn.cursor()
cur.execute("SELECT * FROM tabela")
rows = cur.fetchall()

for row in rows:
    print(row)