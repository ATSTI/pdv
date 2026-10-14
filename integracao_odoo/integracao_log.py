# -*- coding: utf-8 -*-
"""
Logging centralizado para a integracao PDV <-> Odoo.

Todos os modulos devem fazer:

    from integracao_log import get_logger
    _logger = get_logger(__name__)

Assim evitamos o problema de 'basicConfig() so funciona uma vez'.
"""
import logging
import os
import sys
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

    # Console: escreve em stderr por padrao (bom para subprocess ser capturado
    # pelo app_executa via stderr=STDOUT). Se stderr nao existir (pythonw,
    # PyInstaller --windowed), caimos para stdout. Se nenhum existir,
    # simplesmente nao adicionamos o handler de console.
    console_stream = sys.stderr or sys.stdout
    console = None
    if console_stream is not None:
        console = logging.StreamHandler(console_stream)
        console.setFormatter(logging.Formatter(
            "%(levelname)s: %(message)s"
        ))

    root = logging.getLogger()
    root.setLevel(logging.INFO)

    # IMPORTANTE: RotatingFileHandler e subclasse de StreamHandler.
    # Por isso usamos type(h) is X em vez de isinstance(h, X),
    # senao o console nunca seria adicionado.
    if not any(type(h) is RotatingFileHandler for h in root.handlers):
        root.addHandler(handler)
    if console is not None and \
            not any(type(h) is logging.StreamHandler for h in root.handlers):
        root.addHandler(console)

    _CONFIGURADO = True


def get_logger(nome):
    _configurar()
    return logging.getLogger(nome)