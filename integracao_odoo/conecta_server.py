# -*- coding: utf-8 -*-
"""Comunicacao HTTP com o Odoo."""
import configparser
import json
import os
from datetime import datetime

import requests as rq

from integracao_log import get_logger
from sqlite_bd import Database as local_db

_logger = get_logger(__name__)

TIMEOUT = 60


class EnviaServer:

    def __init__(self, tipo):
        cfg = configparser.ConfigParser()
        if not cfg.read("conf.ini"):
            raise FileNotFoundError("conf.ini nao encontrado")

        self.path_envio   = cfg.get("INTEGRA", "path_envio")
        self.path_retorno = cfg.get("INTEGRA", "path_retorno")
        self.url          = cfg.get("INTEGRA", "url")
        self.db           = cfg.get("INTEGRA", "db")
        self.login        = cfg.get("INTEGRA", "login")
        self.passwd       = cfg.get("INTEGRA", "password")

        os.makedirs(self.path_envio, exist_ok=True)
        os.makedirs(self.path_retorno, exist_ok=True)

        self.session = rq.Session()

        if tipo == "produto":
            self.buscando_produtos()
        elif tipo == "cliente":
            self.buscando_clientes()
        elif tipo in ("pedido", "devolucao", "sangria"):
            self.lendo_arquivos()

    def get_session(self):
        url = "https://%s/web/session/authenticate" % self.url
        payload = {
            "jsonrpc": "2.0",
            "params": {
                "db": self.db,
                "login": self.login,
                "password": self.passwd,
            },
        }
        r = self.session.post(
            url, json=payload,
            headers={"Content-Type": "application/json"},
            timeout=TIMEOUT,
        )
        r.raise_for_status()
        session_id = self.session.cookies.get("session_id")
        if not session_id:
            raise RuntimeError(
                "Login Odoo falhou: HTTP %s - %s"
                % (r.status_code, r.text[:500])
            )
        _logger.info("Sessao Odoo OK: %s...", session_id[:8])
        return session_id

    def _post_json(self, url, payload):
        r = self.session.post(
            url, json=payload,
            headers={"Content-Type": "application/json",
                     "Accept": "application/json"},
            timeout=TIMEOUT,
        )
        r.raise_for_status()
        return r.json()

    def buscando_produtos(self):
        self.get_session()
        url = "https://%s/produtoconsulta" % self.url
        dados = self._post_json(url, {})

        if not isinstance(dados, dict) or "result" not in dados:
            _logger.error("Resposta inesperada de /produtoconsulta: %s",
                          str(dados)[:500])
            return
        if not dados["result"]:
            _logger.warning("Produtos vieram vazios - mantendo arquivo antigo")
            return

        arquivo = os.path.join(self.path_envio, "produtos.json")
        tmp = arquivo + ".tmp"
        with open(tmp, "w", encoding="utf-8") as f:
            json.dump(dados, f, ensure_ascii=False, indent=4)
        os.replace(tmp, arquivo)
        _logger.info("Produtos gravados em %s", arquivo)

    def buscando_clientes(self):
        self.get_session()
        url = "https://%s/clienteconsulta" % self.url
        dados = self._post_json(url, {})

        if not isinstance(dados, dict) or "result" not in dados:
            _logger.error("Resposta inesperada de /clienteconsulta: %s",
                          str(dados)[:500])
            return
        if not dados["result"]:
            _logger.warning("Clientes vieram vazios - mantendo arquivo antigo")
            return

        arquivo = os.path.join(self.path_envio, "clientes.json")
        tmp = arquivo + ".tmp"
        with open(tmp, "w", encoding="utf-8") as f:
            json.dump(dados, f, ensure_ascii=False, indent=4)
        os.replace(tmp, arquivo)
        _logger.info("Clientes gravados em %s", arquivo)

    def enviando_arquivo(self, arq, file_name):
        url = "https://%s/integrapdv" % self.url
        caminho = os.path.join(self.path_envio, file_name)
        with open(caminho, "r", encoding="utf-8") as f:
            conteudo = json.load(f)

        vals = {"params": conteudo, "tipo": arq}
        r = self.session.post(
            url, json=vals,
            headers={"Content-Type": "application/json",
                     "Accept": "application/json"},
            timeout=TIMEOUT,
        )
        return r

    def lendo_arquivos(self):
        self.get_session()
        hj = datetime.now().strftime("%m-%d-%Y")

        with local_db(filename="lancamento.db", table="lancamento") as dblocal:
            try:
                arquivos = os.listdir(self.path_envio)
            except FileNotFoundError:
                _logger.error("Pasta de envio inexistente: %s", self.path_envio)
                return

            for nome in arquivos:
                try:
                    self._processar_arquivo(nome, dblocal, hj)
                except Exception:
                    _logger.exception("Falha processando arquivo %s", nome)

    def _processar_arquivo(self, nome, dblocal, hj):
        caminho = os.path.join(self.path_envio, nome)
        if not os.path.isfile(caminho):
            return
        if "." not in nome:
            return

        nome_arq = nome[:nome.index(".")]

        if nome_arq[:3] not in ("cai", "ped", "dev", "san"):
            return

        tipo   = ""
        caixa  = 0
        codigo = 0

        if nome_arq.startswith("caixa_"):
            tipo  = "sessao"
            caixa = nome_arq[6:]
        elif nome_arq.startswith("caixaf_"):
            tipo  = "sessao_fechada"
            caixa = nome_arq[7:]
        elif nome_arq.startswith("pedido_"):
            tipo = "pedido"
            partes = nome_arq[7:].split("-")
            if partes:
                caixa = partes[0]
            if len(partes) >= 2:
                codigo = partes[1]
        elif nome_arq.startswith("devolucao_"):
            tipo = "devolucao"
            partes = nome_arq[10:].split("-")
            if partes:
                caixa = partes[0]
            if len(partes) >= 2:
                codigo = partes[1]
        elif nome_arq.startswith("sangria_"):
            tipo = "sangria"
            partes = nome_arq[8:].split("-")
            if partes:
                caixa = partes[0]
            if len(partes) >= 3:
                codigo = partes[2]
            elif len(partes) >= 2:
                codigo = partes[1]

        if not tipo:
            return

        if dblocal.consulta(tipo, caixa, codigo):
            try:
                os.remove(caminho)
            except OSError:
                _logger.exception("Falha removendo %s", nome)
            return

        arq_tipo = nome_arq[:3]
        try:
            r = self.enviando_arquivo(arq_tipo, nome)
        except Exception:
            _logger.exception("Excecao ao enviar %s", nome)
            return

        if r.status_code >= 400:
            _logger.error("Envio de %s falhou: HTTP %s - %s",
                          nome, r.status_code, r.text[:500])
            return

        try:
            corpo = r.json()
        except ValueError:
            _logger.error("Resposta nao-JSON para %s: %s",
                          nome, r.text[:500])
            return

        if isinstance(corpo, dict) and corpo.get("error"):
            _logger.error("Odoo retornou erro para %s: %s",
                          nome, str(corpo["error"])[:500])
            return

        if tipo and caixa:
            try:
                dblocal.insert({
                    "tipo": tipo,
                    "user": 1,
                    "nome": nome_arq,
                    "caixa": caixa,
                    "codigo": codigo,
                    "data_lancamento": hj,
                })
            except Exception:
                _logger.exception("Falha registrando envio de %s no SQLite", nome)

        try:
            os.remove(caminho)
        except OSError:
            _logger.exception("Envio OK mas nao consegui remover %s", nome)

    # ==================================================================
    # Validacao em massa (ativos/inativos)
    # ==================================================================
    def buscando_clientes_validar(self):
        """Retorna lista completa (ativos + inativos) para validacao."""
        self.get_session()
        url = "https://%s/clientesvalidar" % self.url
        dados = self._post_json(url, {})

        if not isinstance(dados, dict) or "result" not in dados:
            _logger.error("Resposta inesperada de /clientesvalidar: %s",
                          str(dados)[:500])
            return None

        try:
            return json.loads(dados["result"])
        except (TypeError, json.JSONDecodeError):
            _logger.error("result de /clientesvalidar nao e JSON valido")
            return None

    def buscando_produtos_validar(self):
        """Retorna lista completa (ativos + inativos) para validacao."""
        self.get_session()
        url = "https://%s/produtosvalidar" % self.url
        dados = self._post_json(url, {})

        if not isinstance(dados, dict) or "result" not in dados:
            _logger.error("Resposta inesperada de /produtosvalidar: %s",
                          str(dados)[:500])
            return None

        try:
            return json.loads(dados["result"])
        except (TypeError, json.JSONDecodeError):
            _logger.error("result de /produtosvalidar nao e JSON valido")
            return None

    def _carregar_config(self):
        """Carrega config + abre Session sem disparar buscas."""
        cfg = configparser.ConfigParser()
        if not cfg.read("conf.ini"):
            raise FileNotFoundError("conf.ini nao encontrado")

        self.path_envio   = cfg.get("INTEGRA", "path_envio")
        self.path_retorno = cfg.get("INTEGRA", "path_retorno")
        self.url          = cfg.get("INTEGRA", "url")
        self.db           = cfg.get("INTEGRA", "db")
        self.login        = cfg.get("INTEGRA", "login")
        self.passwd       = cfg.get("INTEGRA", "password")

        os.makedirs(self.path_envio, exist_ok=True)
        os.makedirs(self.path_retorno, exist_ok=True)
        self.session = rq.Session()