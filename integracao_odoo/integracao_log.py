# -*- coding: utf-8 -*-
"""
Logging centralizado para a integração PDV <-> Odoo.

Todos os módulos devem fazer:

    from integracao_log import get_logger
    _logger = get_logger(__name__)

Assim evitamos o problema de 'basicConfig() só funciona uma vez'.
"""
import logging
import os
from logging.handlers import RotatingFileHandler

_CONFIGURADO = False


def _configurar():
    global _CONFIGURADO
    if _CONFIGURADO:
        return
    os.makedirs("logs", exist_ok=True)

    handler = RotatingFileHandler(
        filename=os.path.join("logs", "log.txt"),
        mode="a",
        maxBytes=2 * 1024 * 1024,   # 2 MB por arquivo
        backupCount=5,
        encoding="utf-8",
    )
    handler.setFormatter(logging.Formatter(
        "%(levelname)s %(asctime)s [%(threadName)s] %(name)s: %(message)s",
        datefmt="%d/%m/%Y %I:%M:%S %p",
    ))

    console = logging.StreamHandler()
    console.setFormatter(logging.Formatter(
        "%(levelname)s: %(message)s"
    ))

    root = logging.getLogger()
    root.setLevel(logging.INFO)
    # evita duplicar handlers se rodar 2x no mesmo processo
    if not any(isinstance(h, RotatingFileHandler) for h in root.handlers):
        root.addHandler(handler)
    if not any(isinstance(h, logging.StreamHandler) for h in root.handlers):
        root.addHandler(console)

    _CONFIGURADO = True


def get_logger(nome):
    _configurar()
    return logging.getLogger(nome)