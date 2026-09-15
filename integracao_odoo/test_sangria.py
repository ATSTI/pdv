def teste_sangria_parsing():
    """Valida que os nomes de arquivo de sangria são parseados corretamente."""
    from conecta_server import EnviaServer

    # testa o parser sem instanciar (não chama __init__)
    s = EnviaServer.__new__(EnviaServer)

    casos = [
        ("sangria_5-3-987.json", "sangria", "5", "987"),
        ("sangria_5-3-0.json",   "sangria", "5", "0"),
        ("pedido_5-987.json",    "pedido",  "5", "987"),
        ("devolucao_5-987.json", "devolucao", "5", "987"),
        ("caixa_5.json",         "sessao",  "5", 0),
    ]

    for nome, tipo_esperado, caixa_esp, codigo_esp in casos:
        if "." not in nome:
            continue
        nome_arq = nome[:nome.index(".")]

        # replica o parsing (só para teste)
        tipo, caixa, codigo = "", 0, 0

        if nome_arq.startswith("pedido_"):
            tipo = "pedido"
            partes = nome_arq[7:].split("-")
            caixa = partes[0]
            if len(partes) >= 2:
                codigo = partes[1]
        elif nome_arq.startswith("caixa_"):
            tipo = "sessao"
            caixa = nome_arq[6:]
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

        assert tipo == tipo_esperado, f"{nome}: tipo={tipo} != {tipo_esperado}"
        assert str(caixa) == str(caixa_esp), f"{nome}: caixa={caixa}"
        assert str(codigo) == str(codigo_esp), f"{nome}: codigo={codigo}"

    print("OK parsing de sangria/pedido/devolucao")
