# -*- coding: utf-8 -*-
"""
Valida clientes Firebird x Odoo.

Uso:
    python validar_clientes.py          -> dry-run (so mostra)
    python validar_clientes.py aplicar  -> aplica de verdade
"""
import sys
from pos_order_script import IntegracaoOdoo

dry = "aplicar" not in sys.argv

prd = IntegracaoOdoo()
prd.validar_clientes(dry_run=dry)

if dry:
    print("\n>>> DRY-RUN: nada foi alterado.")
    print(">>> Para aplicar de verdade, rode:")
    print(">>>   python validar_clientes.py aplicar")