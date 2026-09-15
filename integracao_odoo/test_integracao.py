# -*- coding: utf-8 -*-
"""Testes de fumaca para a integracao."""
import os
import sys

from integracao_log import get_logger

_logger = get_logger("teste")


def teste_conf():
    import configparser
    cfg = configparser.ConfigParser()
    ok = cfg.read("conf.ini")
    assert ok, "conf.ini nao encontrado"
    assert cfg.has_section("INTEGRA"), "conf.ini sem [INTEGRA]"
    assert cfg.has_section("DATABASE"), "conf.ini sem [DATABASE]"
    print("OK conf.ini")


def teste_firebird():
    from atscon import Conexao
    with Conexao() as db:
        r = db.query("SELECT FIRST 1 1 FROM RDB$DATABASE")
        assert r, "Firebird nao respondeu"
    print("OK Firebird")


def teste_sqlite():
    from sqlite_bd import Database
    nome = "teste_integracao.db"
    if os.path.exists(nome):
        os.remove(nome)
    with Database(filename=nome, table="lancamento") as db:
        db.insert({"tipo": "pedido", "user": 1, "nome": "x",
                   "caixa": 1, "codigo": 999, "data_lancamento": "01-01-2024"})
        r = db.consulta("pedido", 1, 999)
        assert r, "consulta nao retornou"
        db.insert({"tipo": "pedido", "user": 1, "nome": "x",
                   "caixa": 1, "codigo": 999, "data_lancamento": "01-01-2024"})
    os.remove(nome)
    print("OK SQLite")


def teste_login_odoo():
    import configparser
    import requests as rq
    from conecta_server import EnviaServer

    s = EnviaServer.__new__(EnviaServer)
    cfg = configparser.ConfigParser(); cfg.read("conf.ini")
    s.path_envio = cfg.get("INTEGRA", "path_envio")
    s.path_retorno = cfg.get("INTEGRA", "path_retorno")
    s.url   = cfg.get("INTEGRA", "url")
    s.db    = cfg.get("INTEGRA", "db")
    s.login = cfg.get("INTEGRA", "login")
    s.passwd = cfg.get("INTEGRA", "password")
    s.session = rq.Session()

    sid = s.get_session()
    assert sid, "login falhou"
    print("OK Login Odoo (session_id=%s...)" % sid[:8])


def teste_parsing_arquivos():
    casos = [
        ("sangria_5-3-987", "sangria", "5", "987"),
        ("sangria_5-3-0",   "sangria", "5", "0"),
        ("pedido_5-987",    "pedido",  "5", "987"),
        ("devolucao_5-987", "devolucao", "5", "987"),
        ("caixa_5",         "sessao",  "5", "0"),
        ("caixaf_5",        "sessao_fechada", "5", "0"),
    ]
    for nome_arq, tipo_esp, caixa_esp, cod_esp in casos:
        tipo, caixa, codigo = "", 0, 0
        if nome_arq.startswith("caixa_"):
            tipo = "sessao"; caixa = nome_arq[6:]
        elif nome_arq.startswith("caixaf_"):
            tipo = "sessao_fechada"; caixa = nome_arq[7:]
        elif nome_arq.startswith("pedido_"):
            tipo = "pedido"
            partes = nome_arq[7:].split("-")
            caixa = partes[0]
            if len(partes) >= 2:
                codigo = partes[1]
        elif nome_arq.startswith("devolucao_"):
            tipo = "devolucao"
            partes = nome_arq[10:].split("-")
            caixa = partes[0]
            if len(partes) >= 2:
                codigo = partes[1]
        elif nome_arq.startswith("sangria_"):
            tipo = "sangria"
            partes = nome_arq[8:].split("-")
            caixa = partes[0]
            if len(partes) >= 3:
                codigo = partes[2]
            elif len(partes) >= 2:
                codigo = partes[1]

        assert tipo == tipo_esp, "%s: tipo=%s != %s" % (nome_arq, tipo, tipo_esp)
        assert str(caixa) == caixa_esp, "%s: caixa=%s" % (nome_arq, caixa)
        assert str(codigo) == cod_esp, "%s: codigo=%s" % (nome_arq, codigo)
    print("OK Parsing de arquivos")

def teste_fila():
    """Valida que a tabela INTEGRACAO_FILA existe (ou é criada)."""
    from atscon import Conexao

    with Conexao() as db:
        r = db.query(
            "SELECT 1 FROM RDB$RELATIONS "
            "WHERE RDB$RELATION_NAME = 'INTEGRACAO_FILA'"
        )
        assert r, "INTEGRACAO_FILA não existe (rode _garantir_fila uma vez)"

        cols = db.query(
            "SELECT RDB$FIELD_NAME FROM RDB$RELATION_FIELDS "
            "WHERE RDB$RELATION_NAME = 'INTEGRACAO_FILA'"
        )
        nomes = {(c[0] or "").strip().upper() for c in cols}
        for esperado in ("ID", "TIPO", "ID_ORIGEM", "PAYLOAD",
                         "STATUS", "TENTATIVAS", "DT_CRIACAO", "DT_ENVIO", "ERRO"):
            assert esperado in nomes, "coluna %s faltando" % esperado

    print("OK INTEGRACAO_FILA")

def main():
    testes = [
        ("conf.ini",       teste_conf),
        ("Firebird",       teste_firebird),
        ("SQLite",         teste_sqlite),
        ("Login Odoo",     teste_login_odoo),
        ("Parsing arquivos", teste_parsing_arquivos),
        ("Fila de integração", teste_fila),
    ]
    falhas = 0
    for nome, fn in testes:
        try:
            fn()
        except Exception as e:
            falhas += 1
            print("FALHA %s: %s" % (nome, e))
            import traceback; traceback.print_exc()
    print()
    if falhas:
        print("%s falha(s)" % falhas)
        sys.exit(1)
    print("Tudo OK.")


if __name__ == "__main__":
    main()
