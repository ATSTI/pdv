# -*- coding: utf-8 -*-
import odoorpc
# import re
# from datetime import datetime
# from datetime import date
# from datetime import timedelta
import os
import shutil
from main import Main as verifica_versao
import configparser
from atscon import Conexao as con_fdb

class ConectaServer():
    _name = 'conecta.server'

    def __init__(self):
        cfg = configparser.ConfigParser()
        cfg.read('conf.ini')
        self.path_retorno  = cfg.get('INTEGRA', 'Path_retorno')
        self.url = cfg.get('INTEGRA', 'url')
        self.db = cfg.get('INTEGRA', 'db')
        self.porta = cfg.get('INTEGRA', 'porta')
        self.login = cfg.get('INTEGRA', 'login')
        self.passwd = cfg.get('INTEGRA', 'password')
        verifica_versao()
        #print ("Verificando cadastro de empresas")        
        self.busca_empresa()

    def _conexao_odoo(self):
        origem = odoorpc.ODOO(self.url, port=self.porta)
        origem.login(self.db, self.login, self.passwd)
        return origem

    def consulta_empresa(self, db=None, empresa_id=None, nome=None, cnpj=None):
        busca = "select * from EMPRESA"
        if empresa_id:
            busca += " where empresa_id = " + str(empresa_id)
        if nome:
            busca += " where nome like '%s' or razao like '%s'" %(nome)
        if cnpj:
            busca += " where cnpj like '%s'" %(cnpj)
        dados = db.query_one(busca)
        if not dados:
            return False
        return dados

    def busca_empresa(self):
        try:
            db = con_fdb()
        except:
            msg = u'Caminho ou nome do banco invalido.<br>'
        con = self._conexao_odoo()
        # db = local_db(filename = 'lancamento.db', table = 'empresa')
        empresa = con.env['res.company']
        empresas_ids = empresa.search([('certificate_ecnpj_id', '=', False), ('certificate_nfe_id', '=', False)])
        
        for emp in empresa.browse(empresas_ids):
            if emp.certificate_nfe_id:
                continue
            existe = self.consulta_empresa(db=db, empresa_id=None, nome=None, cnpj=emp.cnpj_cpf)
            razao = ''
            if emp.legal_name:
                razao = emp.legal_name
            cnpj = ''
            if emp.cnpj_cpf:
                cnpj = emp.cnpj_cpf
            if not existe:
                #print (f"Cadastrando empresa : {emp.name}")
                sql = "insert into empresa (empresa_id, nome, razao, cnpj) values (%s, '%s', '%s', '%s')" %(
                    str(emp.id), emp.name, razao, cnpj
                )
                db.execute(sql)
            replace = ['-', ' ', '(',')', '/', '.', ':','º','+55']
            for i in replace:
                cnpj = cnpj.replace(i, '')
            empresa_arquivo = os.path.join(self.path_retorno, 'empresas')
            # Check whether the specified path exists or not
            isExist = os.path.exists(empresa_arquivo)
            if not isExist:
                # Create a new directory because it does not exist
                os.makedirs(empresa_arquivo)
            empresa_arquivo = os.path.join(empresa_arquivo, f"{cnpj}.ini")
            if not os.path.isfile(empresa_arquivo):        
                if cnpj:
                    #print (f"Criando o arquivo INI para a empresa: {emp.name}-{empresa_arquivo}")
                    # arquivo modelo
                    empresa_modelo = "empresa.ini"
                    #print(f"Copiando o empresa.ini para a Empresa nova {empresa_arquivo}")
                    # with open(empresa_modelo, 'r') as src, open('destination.txt', 'w') as dst:
                    shutil.copyfile(empresa_modelo,empresa_arquivo) 
                    cfgx = configparser.ConfigParser()
                    #print(f"Lendo arquivo - {empresa_arquivo}")
                    cfgx.read(empresa_arquivo)
                    fone = ""
                    if emp.phone:
                        fone = emp.phone
                        for i in replace:
                            fone = fone.replace(i, '')
                    cep = ""
                    if emp.zip:
                        cep = emp.zip
                        for i in replace:
                            cep = cep.replace(i, '')

                    empresa_secao = cfgx["Emitente"]
                    empresa_secao["CNPJ"] = cnpj
                    if emp.inscr_est:
                        empresa_secao["IE"] = emp.inscr_est
                    empresa_secao["RazaoSocial"] = emp.legal_name
                    empresa_secao["Fantasia"] = emp.name
                    empresa_secao["Fone"] = fone
                    empresa_secao["CEP"] = cep
                    if emp.street_name:
                        empresa_secao["Logradouro"] = emp.street_name
                        empresa_secao["Numero"] = str(emp.street_number)
                    if emp.street2:
                        empresa_secao["Complemento"] = emp.street2
                    if emp.district:
                        empresa_secao["Bairro"] = emp.district
                    if emp.city_id:
                        empresa_secao["CodCidade"] = emp.city_id.ibge_code
                        empresa_secao["Cidade"] = emp.city_id.name
                        empresa_secao["UF"] = emp.state_id.code
                    empresa_secao["CRT"] = emp.tax_framework # ou :  emp.fiscal_profile_id.tax_framework
                    with open(empresa_arquivo, 'w') as configfile:
                        cfgx.write(configfile)
    
ConectaServer()