# -*- coding: utf-8 -*-
"""
Gera checksums.json com SHA-256 dos arquivos do integrador PDV.
Rode ANTES de cada git commit/push.

Uso:
    python gerar_checksums.py
"""
import hashlib
import json
import os
import sys

from main_arquivos import MainArquivos

ARQ_SAIDA = "checksums.json"


def sha256_arquivo(caminho):
    h = hashlib.sha256()
    with open(caminho, "rb") as f:
        for bloco in iter(lambda: f.read(65536), b""):
            h.update(bloco)
    return h.hexdigest()


def main():
    arquivos = MainArquivos().lista_arquivos()
    checksums = {}
    faltando = []

    print("Gerando checksums:")
    for arq in arquivos:
        if not os.path.isfile(arq):
            faltando.append(arq)
            continue
        checksums[arq] = sha256_arquivo(arq)
        print("  %-25s %s" % (arq, checksums[arq][:16] + "..."))

    if faltando:
        print("\nAVISO: arquivos listados mas ausentes:")
        for arq in faltando:
            print("  - %s" % arq)

    if not checksums:
        print("\nERRO: nenhum arquivo para gerar checksum.")
        sys.exit(1)

    with open(ARQ_SAIDA, "w", encoding="utf-8") as f:
        json.dump(checksums, f, indent=2, sort_keys=True)
        f.write("\n")

    print("\n%s gerado com %s arquivo(s)." % (ARQ_SAIDA, len(checksums)))
    print("Agora faca:")
    print("  git add %s" % ARQ_SAIDA)
    print("  git commit -m 'atualiza checksums'")
    print("  git push")


if __name__ == "__main__":
    main()