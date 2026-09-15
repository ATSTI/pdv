# teste_fila_insert.py
from atscon import Conexao

with Conexao() as db:
    # limpa qualquer coisa da fila (opcional)
    # db.ddl("DELETE FROM INTEGRACAO_FILA")

    # insere sem ID — a trigger deve preencher
    r = db.insert(
        "INSERT INTO INTEGRACAO_FILA (TIPO, ID_ORIGEM, PAYLOAD, STATUS) "
        "VALUES (?, ?, ?, ?)",
        ("TESTE", 999, '{"x":1}', "PENDENTE"),
    )
    if r:
        print("Falha no INSERT:", r)
    else:
        linhas = db.query(
            "SELECT ID, TIPO, ID_ORIGEM, STATUS, DT_CRIACAO "
            "FROM INTEGRACAO_FILA WHERE TIPO = 'TESTE'"
        )
        for l in linhas:
            print("ID=%s TIPO=%s ID_ORIGEM=%s STATUS=%s DT=%s" % l)

        # limpa o teste
        db.insert("DELETE FROM INTEGRACAO_FILA WHERE TIPO = 'TESTE'")
        print("Registro de teste removido.")