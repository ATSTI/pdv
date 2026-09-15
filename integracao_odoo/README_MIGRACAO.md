# Migração da integração PDV <-> Odoo

## Ordem de migração

1. **Backup** do projeto atual e do `lancamento.db`.
2. Instale deps: `pip install fdb requests`
3. Copie `conf.ini.exemplo` para `conf.ini` e preencha.
4. **Etapa 1** — Substitua `atscon.py` e `sqlite_bd.py`.
   Rode `python test_integracao.py` (deve passar Firebird e SQLite).
5. **Etapa 2** — Substitua `conecta_server.py`.
   Rode `test_integracao.py` de novo (agora testa o login Odoo).
6. **Etapa 3** — Substitua `pos_order_script.py` + os 5 scripts `atualiza_*.py` e `pos_order_exec.py`.
7. **Etapa 4** — Substitua o app da GUI por `app.py`.
8. Rode `app.py` e clique em **Atualiza Produtos**. Veja `logs/log.txt`.

## Antes de rodar a Etapa 3

Se você já tem `lancamento.db` com duplicatas:

```python
import sqlite3
con = sqlite3.connect("lancamento.db")
con.execute("""
    DELETE FROM lancamento WHERE rowid NOT IN (
        SELECT MIN(rowid) FROM lancamento GROUP BY tipo, caixa, codigo
    )
""")
con.commit()
con.close()
