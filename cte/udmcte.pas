unit uDmCte;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db;

type

  { TdmCte }

  TdmCte = class(TDataModule)
    cdsCte: TSQLQuery;
    cdsCteANT_CHCTE: TStringField;
    cdsCteANT_CNPJ: TStringField;
    cdsCteANT_IE: TStringField;
    cdsCteANT_NOME: TStringField;
    cdsCteANT_UF: TStringField;
    cdsCteCARAC_SERV: TStringField;
    cdsCteCARAC_TRANSP: TStringField;
    cdsCteCHCTE: TStringField;
    cdsCteCODEMITENTE: TLongintField;
    cdsCteCODIGOMUNICIPIO: TStringField;
    cdsCteCOD_CTE: TLongintField;
    cdsCteCOMBCODSITTRIB: TLongintField;
    cdsCteCOMPONENTE: TStringField;
    cdsCteCTE_CFOP: TLongintField;
    cdsCteCTE_CHAVE: TLongintField;
    cdsCteCTE_ESTADO: TLongintField;
    cdsCteCTE_NATOP: TStringField;
    cdsCteCTE_NUMERO: TLongintField;
    cdsCteCTE_SERIE: TStringField;
    cdsCteDATARODPREV: TDateField;
    cdsCteDESTINATARIO: TLongintField;
    cdsCteDETRETIRA: TStringField;
    cdsCteDET_RETIRA: TStringField;
    cdsCteDHEMI: TDateTimeField;
    cdsCteD_BAIRRO: TStringField;
    cdsCteD_CEP: TStringField;
    cdsCteD_CIDADE: TStringField;
    cdsCteD_CNPJCPF: TStringField;
    cdsCteD_CODIGOMUNICIPI: TStringField;
    cdsCteD_CODIGOPAIS: TLongintField;
    cdsCteD_COMPLEMENTO: TStringField;
    cdsCteD_ENDERECO: TStringField;
    cdsCteD_ESTADO: TStringField;
    cdsCteD_FANTASIA: TStringField;
    cdsCteD_IESTADUAL: TStringField;
    cdsCteD_NUMERO: TStringField;
    cdsCteD_PAIS: TStringField;
    cdsCteD_RG: TStringField;
    cdsCteD_RSOCIAL: TStringField;
    cdsCteD_TELEFONE: TStringField;
    cdsCteEMITENTE: TLongintField;
    cdsCteEMPRESACIDADE: TStringField;
    cdsCteEMPRESAESTADO: TStringField;
    cdsCteENV_CIDADE: TStringField;
    cdsCteENV_CODCIDADE: TStringField;
    cdsCteENV_ESTADO: TStringField;
    cdsCteEXPEDITOR: TLongintField;
    cdsCteEX_BAIRRO: TStringField;
    cdsCteEX_CEP: TStringField;
    cdsCteEX_CIDADE: TStringField;
    cdsCteEX_CNPJCPF: TStringField;
    cdsCteEX_CODIGOMUNICIPI: TStringField;
    cdsCteEX_CODIGOPAIS: TLongintField;
    cdsCteEX_COMPLEMENTO: TStringField;
    cdsCteEX_ENDERECO: TStringField;
    cdsCteEX_ESTADO: TStringField;
    cdsCteEX_FANTASIA: TStringField;
    cdsCteEX_IESTADUAL: TStringField;
    cdsCteEX_NUMERO: TStringField;
    cdsCteEX_PAIS: TStringField;
    cdsCteEX_RG: TStringField;
    cdsCteEX_RSOCIAL: TStringField;
    cdsCteEX_TELEFONE: TStringField;
    cdsCteE_BAIRRO: TStringField;
    cdsCteE_CEP: TStringField;
    cdsCteE_CIDADE: TStringField;
    cdsCteE_CNPJCPF: TStringField;
    cdsCteE_CODIGOMUNICIPI: TStringField;
    cdsCteE_CODIGOPAIS: TLongintField;
    cdsCteE_COMPLEMENTO: TStringField;
    cdsCteE_ENDERECO: TStringField;
    cdsCteE_ESTADO: TStringField;
    cdsCteE_FANTASIA: TStringField;
    cdsCteE_IESTADUAL: TStringField;
    cdsCteE_NUMERO: TStringField;
    cdsCteE_PAIS: TStringField;
    cdsCteE_RG: TStringField;
    cdsCteE_RSOCIAL: TStringField;
    cdsCteE_TELEFONE: TStringField;
    cdsCteFIM_CIDADE: TStringField;
    cdsCteFIM_CODCIDADE: TStringField;
    cdsCteFIM_ESTADO: TStringField;
    cdsCteFUNC_EMI: TStringField;
    cdsCteIFORPAG: TLongintField;
    cdsCteINI_CIDADE: TStringField;
    cdsCteINI_CODCIDADE: TStringField;
    cdsCteINI_ESTADO: TStringField;
    cdsCteIN_IMPOSTOS: TLongintField;
    cdsCteMODAL: TStringField;
    cdsCteMODELO: TStringField;
    cdsCteNPROT: TStringField;
    cdsCteOBS_GERAL: TStringField;
    cdsCteOUDEMI: TDateTimeField;
    cdsCteOUDESCOUTRO: TStringField;
    cdsCteOUNDOC: TStringField;
    cdsCteOUTCAT: TStringField;
    cdsCteOUTPDOC: TStringField;
    cdsCteOUVDOCFISC: TFloatField;
    cdsCtePROCEMI: TLongintField;
    cdsCtePROPRED: TStringField;
    cdsCteRECEBEDOR: TLongintField;
    cdsCteREFCTE: TStringField;
    cdsCteREMETENTE: TLongintField;
    cdsCteRETIRA: TLongintField;
    cdsCteRE_BAIRRO: TStringField;
    cdsCteRE_CEP: TStringField;
    cdsCteRE_CIDADE: TStringField;
    cdsCteRE_CNPJCPF: TStringField;
    cdsCteRE_CODIGOMUNICIPI: TStringField;
    cdsCteRE_CODIGOPAIS: TLongintField;
    cdsCteRE_COMPLEMENTO: TStringField;
    cdsCteRE_ENDERECO: TStringField;
    cdsCteRE_ESTADO: TStringField;
    cdsCteRE_FANTASIA: TStringField;
    cdsCteRE_IESTADUAL: TStringField;
    cdsCteRE_NUMERO: TStringField;
    cdsCteRE_PAIS: TStringField;
    cdsCteRE_RG: TStringField;
    cdsCteRE_RSOCIAL: TStringField;
    cdsCteRE_TELEFONE: TStringField;
    cdsCteRGRODLOTACAO: TLongintField;
    cdsCteRNTRC: TStringField;
    cdsCteR_BAIRRO: TStringField;
    cdsCteR_CEP: TStringField;
    cdsCteR_CIDADE: TStringField;
    cdsCteR_CNPJCPF: TStringField;
    cdsCteR_CODIGOMUNICIPI: TStringField;
    cdsCteR_CODIGOPAIS: TLongintField;
    cdsCteR_COMPLEMENTO: TStringField;
    cdsCteR_ENDERECO: TStringField;
    cdsCteR_ESTADO: TStringField;
    cdsCteR_FANTASIA: TStringField;
    cdsCteR_IESTADUAL: TStringField;
    cdsCteR_NUMERO: TStringField;
    cdsCteR_PAIS: TStringField;
    cdsCteR_RG: TStringField;
    cdsCteR_RSOCIAL: TStringField;
    cdsCteR_TELEFONE: TStringField;
    cdsCteSTATUS: TStringField;
    cdsCteTIPOAMBIENTE: TLongintField;
    cdsCteTIPOCTE: TLongintField;
    cdsCteTIPOSERVICO: TLongintField;
    cdsCteTOMADORSERVICO: TLongintField;
    cdsCteTPIMP: TLongintField;
    cdsCteTPOEMISSAO: TLongintField;
    cdsCteT_BAIRRO: TStringField;
    cdsCteT_CEP: TStringField;
    cdsCteT_CIDADE: TStringField;
    cdsCteT_CNPJCPF: TStringField;
    cdsCteT_CODIGOMUNICIPI: TStringField;
    cdsCteT_CODIGOPAIS: TLongintField;
    cdsCteT_COMPLEMENTO: TStringField;
    cdsCteT_ENDERECO: TStringField;
    cdsCteT_ESTADO: TStringField;
    cdsCteT_FANTASIA: TStringField;
    cdsCteT_IESTADUAL: TStringField;
    cdsCteT_NUMERO: TStringField;
    cdsCteT_PAIS: TStringField;
    cdsCteT_RG: TStringField;
    cdsCteT_RSOCIAL: TStringField;
    cdsCteT_TELEFONE: TStringField;
    cdsCteVALINFCARGA: TFloatField;
    cdsCteVALPICMS: TFloatField;
    cdsCteVALPREDBC: TFloatField;
    cdsCteVALTOTTRI: TFloatField;
    cdsCteVALVBC: TFloatField;
    cdsCteVALVCRED: TFloatField;
    cdsCteVALVICMS: TFloatField;
    cdsCteVCOMPONENTE: TFloatField;
    cdsCteVERPROC: TStringField;
    cdsCteVPREST: TFloatField;
    cdsCteVREC: TFloatField;
    sqSeg: TSQLQuery;
    sqNFe: TSQLQuery;
    sqQC: TSQLQuery;
    sqComp: TSQLQuery;
    sqVeic: TSQLQuery;
    sqMot: TSQLQuery;
  private

  public

  end;

var
  dmCte: TdmCte;

implementation

uses udmpdv;

{$R *.lfm}

end.

