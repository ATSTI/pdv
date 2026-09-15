# -*- coding: utf-8 -*-
"""
Valida produtos Firebird x Odoo.

Uso:
    python validar_produtos.py          -> dry-run (so mostra)
    python validar_produtos.py aplicar  -> aplica de verdade
"""
import sys
from pos_order_script import IntegracaoOdoo

dry = "aplicar" not in sys.argv

prd = IntegracaoOdoo()
prd.validar_produtos(dry_run=dry)

if dry:
    print("\n>>> DRY-RUN: nada foi alterado.")
    print(">>> Para aplicar de verdade, rode:")
    print(">>>   python validar_produtos.py aplicar")
