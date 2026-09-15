# -*- coding: utf-8 -*-
"""
App principal — agendador de integracao PDV <-> Odoo.

Botoes:
- Atualiza Produtos  -> atualiza_produtos.py
- Atualiza Clientes  -> atualiza_clientes.py
- Atualiza Caixas    -> atualiza_caixas.py
- Atualiza Vendas    -> pos_order_exec.py
- Validar Produtos   -> validar_produtos.py [aplicar]
- Validar Clientes   -> validar_clientes.py [aplicar]

Os botoes "Validar" abrem um popup:
- Sim, primeiro dry-run     -> roda sem 'aplicar'
- Nao, aplicar agora        -> pede confirmacao extra e roda com 'aplicar'
"""
import datetime
import os
import subprocess
import sys
import threading
from tkinter import (
    BOTH, LEFT, YES, Button, Frame, Label, RIDGE, Text, Tk, messagebox,
)

from integracao_log import get_logger

_logger = get_logger(__name__)

PASTA = os.path.dirname(os.path.abspath(__file__))


class MinhaGUI:

    def __init__(self):
        self.janela_principal = Tk()
        self.janela_principal.title("Atualizar Servidor")
        self.janela_principal.option_add("*font", ("verdana", 12, "bold"))
        self.janela_principal.geometry("1080x600")

        # controle de concorrencia dos scripts
        self.lock = threading.Lock()
        self.rodando = set()
        self.ultima_exec = {}

        # frame superior com os botoes
        fm = Frame(self.janela_principal, background="tan",
                   borderwidth=5, relief=RIDGE, width=250)

        # area de log
        self.logbox = Text(self.janela_principal, width=100, height=30)
        self.logbox.pack()

        # ---- botoes de sincronizacao automatica ----
        botoes_sync = [
            ("Atualiza Produtos", "atualiza_produtos.py"),
            ("Atualiza Clientes", "atualiza_clientes.py"),
            ("Atualiza Caixas",   "atualiza_caixas.py"),
            ("Atualiza Vendas",   "pos_order_exec.py"),
        ]
        for texto, script in botoes_sync:
            Button(
                fm, text=texto,
                command=lambda s=script: self._disparar(s, forcar=True),
            ).pack(side=LEFT, fill=BOTH, expand=1)

        # ---- botoes de validacao (com popup) ----
        Button(
            fm, text="Validar Produtos",
            command=self._validar_produtos,
        ).pack(side=LEFT, fill=BOTH, expand=1)

        Button(
            fm, text="Validar Clientes",
            command=self._validar_clientes,
        ).pack(side=LEFT, fill=BOTH, expand=1)

        # ---- sair ----
        Button(
            fm, text="Sair",
            command=self.janela_principal.quit,
        ).pack(side=LEFT, fill=BOTH, expand=1)

        Label(fm, text="1").pack()
        fm.pack(fill=BOTH, expand=YES)

        # primeiro tick (agendador automatico)
        self.janela_principal.after(60_000, self.tick)

        self.janela_principal.mainloop()

    # ==================================================================
    # Botoes de validacao
    # ==================================================================
    def _validar_produtos(self):
        """
        Pergunta ao usuario se quer dry-run ou aplicar.
        - Sim  -> dry-run (nada e alterado)
        - Nao  -> pede confirmacao extra e aplica
        """
        if messagebox.askyesno(
            "Validar Produtos",
            "Deseja rodar em DRY-RUN primeiro?\n\n"
            "  Sim = apenas mostra o que seria alterado (seguro)\n"
            "  Nao = aplica as alteracoes no Firebird"
        ):
            self._disparar("validar_produtos.py", forcar=True)
            return

        # aplicar de verdade -> confirma duas vezes
        if messagebox.askyesno(
            "ATENCAO — Aplicar de verdade?",
            "Isso vai ALTERAR produtos no Firebird (inativar e atualizar).\n\n"
            "Recomendado ter rodado dry-run antes.\n\n"
            "Tem certeza?"
        ):
            self._disparar("validar_produtos.py", forcar=True,
                           args_extra=["aplicar"])
        else:
            self._log("[CANCELADO] Validacao de produtos abortada pelo usuario.\n")

    def _validar_clientes(self):
        if messagebox.askyesno(
            "Validar Clientes",
            "Deseja rodar em DRY-RUN primeiro?\n\n"
            "  Sim = apenas mostra o que seria alterado (seguro)\n"
            "  Nao = aplica as alteracoes no Firebird"
        ):
            self._disparar("validar_clientes.py", forcar=True)
            return

        if messagebox.askyesno(
            "ATENCAO — Aplicar de verdade?",
            "Isso vai ALTERAR clientes no Firebird (inativar e atualizar).\n\n"
            "Recomendado ter rodado dry-run antes.\n\n"
            "Tem certeza?"
        ):
            self._disparar("validar_clientes.py", forcar=True,
                           args_extra=["aplicar"])
        else:
            self._log("[CANCELADO] Validacao de clientes abortada pelo usuario.\n")

    # ==================================================================
    # Agendamento / execucao
    # ==================================================================
    def _disparar(self, script, forcar=False, intervalo_min=5,
                  args_extra=None):
        """
        Dispara um subprocesso para o script, se nao estiver rodando
        e se o intervalo minimo passou.

        Args:
            script: nome do .py na pasta do app
            forcar: ignora o intervalo minimo
            intervalo_min: minutos minimos entre execucoes do mesmo script
            args_extra: lista de argumentos extras (ex: ["aplicar"])
        """
        with self.lock:
            if script in self.rodando:
                self._log("[SKIP] %s ja esta rodando.\n" % script)
                return
            if not forcar:
                ultima = self.ultima_exec.get(script)
                if ultima and (datetime.datetime.now() - ultima
                               ).total_seconds() < intervalo_min * 60:
                    return
            self.rodando.add(script)
            self.ultima_exec[script] = datetime.datetime.now()

        threading.Thread(
            target=self._executar,
            args=(script, args_extra),
            daemon=True,
        ).start()

    def _executar(self, script, args_extra=None):
        cmd = [sys.executable, "-u", script]
        if args_extra:
            cmd.extend(args_extra)

        try:
            r = subprocess.run(
                cmd,
                capture_output=True, text=True, timeout=600,
                cwd=PASTA,
            )
            saida = (r.stdout or "") + (r.stderr or "")
            if saida:
                self._log(saida)
            if r.returncode != 0:
                self._log("[ERRO] %s (rc=%s)\n" % (script, r.returncode))
            else:
                self._log("--- %s: feito ---\n" % script)
        except subprocess.TimeoutExpired:
            self._log("[TIMEOUT] %s excedeu 600s\n" % script)
        except Exception as e:
            self._log("[EXCECAO] %s: %s\n" % (script, e))
        finally:
            with self.lock:
                self.rodando.discard(script)

    # ==================================================================
    # Log thread-safe
    # ==================================================================
    def _log(self, texto):
        # agenda a escrita na thread principal do Tk
        self.janela_principal.after(0, lambda: self._log_direto(texto))

    def _log_direto(self, texto):
        self.logbox.insert("end", texto)
        self.logbox.see("end")

    # ==================================================================
    # Tick automatico (a cada 1 min)
    # ==================================================================
    def tick(self):
        now = datetime.datetime.now()
        self._log("[TICK] %s\n" % now.strftime("%Y-%m-%d %H:%M:%S"))

        # sincronizacoes automaticas
        self._disparar("pos_order_exec.py",    intervalo_min=5)
        self._disparar("atualiza_produtos.py", intervalo_min=20)
        self._disparar("atualiza_clientes.py", intervalo_min=60)
        self._disparar("atualiza_caixas.py",   intervalo_min=60)

        # validadores NAO entram no tick — sao manuais
        self.janela_principal.after(60_000, self.tick)


if __name__ == "__main__":
    MinhaGUI()
