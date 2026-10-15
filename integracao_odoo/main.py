# -*- coding: utf-8 -*-
"""
Atualizador seguro do integrador PDV.

Protecoes:
  - HTTPS + timeout + raise_for_status
  - SHA-256 de cada arquivo via checksums.json
  - Validacao sintatica de .py (compile antes de gravar)
  - Validacao estrutural de versao.cfg
  - Gravacao atomica (.tmp + fsync + os.replace)
  - Backup automatico em backup/<arquivo>.<timestamp>
  - versao.cfg gravado por ULTIMO (marca ponto-de-sucesso)
  - Aborta ao primeiro erro (nao deixa estado inconsistente)
"""
import configparser
import hashlib
import json
import os
import shutil
import time

import requests as rq

from main_arquivos import MainArquivos

# URL_BASE = "https://raw.githubusercontent.com/ATSTI/pdv/master/integracao_odoo/"
URL_BASE = "https://raw.githubusercontent.com/ATSTI/pdv/integracao-odoo-2.0/integracao_odoo/"
TIMEOUT = 15
VERSAO_ARQ = "versao.cfg"
CHECKSUMS_ARQ = "checksums.json"
PASTA_BACKUP = "backup"


# ==================== HELPERS ====================

def _sha256(data):
    return hashlib.sha256(data).hexdigest()


def _baixar(nome):
    """Baixa um arquivo do GitHub. Retorna bytes ou None."""
    try:
        resp = rq.get(URL_BASE + nome, timeout=TIMEOUT)
        resp.raise_for_status()
        return resp.content
    except rq.RequestException as e:
        print("Falha baixando %s: %s" % (nome, e))
        return None


def _grava_atomico(caminho, data):
    """Grava bytes de forma atomica: .tmp + fsync + os.replace."""
    tmp = caminho + ".tmp"
    with open(tmp, "wb") as f:
        f.write(data)
        f.flush()
        os.fsync(f.fileno())
    os.replace(tmp, caminho)


def _backup(caminho):
    """Copia o arquivo atual para backup/<arquivo>.<timestamp>."""
    if not os.path.exists(caminho):
        return
    os.makedirs(PASTA_BACKUP, exist_ok=True)
    ts = time.strftime("%Y%m%d-%H%M%S")
    destino = os.path.join(PASTA_BACKUP, "%s.%s" % (caminho, ts))
    shutil.copy2(caminho, destino)


def _valida_python(nome, data):
    """Compila o .py em memoria. Retorna True se sintaxe OK."""
    if not nome.endswith(".py"):
        return True
    try:
        compile(data.decode("utf-8"), nome, "exec")
        return True
    except (SyntaxError, UnicodeDecodeError) as e:
        print("REJEITADO %s: %s" % (nome, e))
        return False


def _valida_cfg(data):
    """Verifica que o versao.cfg tem [SISTEMA] versao."""
    cfg = configparser.ConfigParser()
    try:
        cfg.read_string(data.decode("utf-8"))
        cfg.get("SISTEMA", "versao")
        return True
    except Exception as e:
        print("REJEITADO versao.cfg: %s" % e)
        return False


# ==================== CLASSE ====================

class Main():

    def __init__(self):
        self.versao = self._le_versao_local()
        self.checksums = {}
        self.buscando_script()

    # ------------------------------------------------------------------
    def _le_versao_local(self):
        cfg = configparser.ConfigParser()
        if not cfg.read(VERSAO_ARQ):
            return "0.0.0.0"
        try:
            return cfg.get("SISTEMA", "versao")
        except (configparser.Error, KeyError):
            return "0.0.0.0"

    # ------------------------------------------------------------------
    def _carrega_checksums(self):
        data = _baixar(CHECKSUMS_ARQ)
        if not data:
            print("ABORTADO: nao foi possivel baixar %s" % CHECKSUMS_ARQ)
            return False
        try:
            self.checksums = json.loads(data.decode("utf-8"))
        except Exception as e:
            print("ABORTADO: %s invalido: %s" % (CHECKSUMS_ARQ, e))
            return False
        if not isinstance(self.checksums, dict) or not self.checksums:
            print("ABORTADO: %s vazio ou formato errado" % CHECKSUMS_ARQ)
            return False
        print("%s carregado (%s arquivo(s))"
              % (CHECKSUMS_ARQ, len(self.checksums)))
        return True

    # ------------------------------------------------------------------
    def _aplica(self, nome, data):
        """Valida hash + sintaxe, faz backup e grava atomicamente."""
        # 1. hash
        esperado = self.checksums.get(nome)
        if not esperado:
            print("SKIP %s: sem hash em %s" % (nome, CHECKSUMS_ARQ))
            return False
        obtido = _sha256(data)
        if obtido != esperado:
            print("REJEITADO %s: hash nao bate" % nome)
            print("  esperado: %s" % esperado)
            print("  obtido:   %s" % obtido)
            return False

        # 2. validacao sintatica
        if not _valida_python(nome, data):
            return False

        # 3. backup
        _backup(nome)

        # 4. gravacao atomica
        _grava_atomico(nome, data)
        print("OK %s" % nome)
        return True

    # ------------------------------------------------------------------
    def buscando_script(self):
        # 0. checksums primeiro
        if not self._carrega_checksums():
            return

        # 1. versao.cfg remoto
        data_versao = _baixar(VERSAO_ARQ)
        if not data_versao:
            print("Falha baixando %s, mantendo local" % VERSAO_ARQ)
            return
        if not _valida_cfg(data_versao):
            print("%s remoto invalido, mantendo local" % VERSAO_ARQ)
            return

        cfg = configparser.ConfigParser()
        cfg.read_string(data_versao.decode("utf-8"))
        versao_remota = cfg.get("SISTEMA", "versao")

        if versao_remota == self.versao:
            print("Sem atualizacao (versao %s)" % self.versao)
            return

        print("Atualizando de %s para %s" % (self.versao, versao_remota))

        # 2. baixa e aplica cada arquivo, abortando ao primeiro erro
        arquivos = MainArquivos().lista_arquivos()
        for nome in arquivos:
            data = _baixar(nome)
            if data is None:
                print("FALHA baixando %s, ABORTANDO atualizacao" % nome)
                return
            if not self._aplica(nome, data):
                print("FALHA aplicando %s, ABORTANDO" % nome)
                return

        # 3. versao.cfg por ultimo (ponto-de-sucesso)
        _grava_atomico(VERSAO_ARQ, data_versao)
        print("Atualizacao concluida para versao %s" % versao_remota)