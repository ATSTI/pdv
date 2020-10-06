unit udmpdv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, db, FileUtil, IniFiles,
  Dialogs, uExecutaIntegracao, JsonTools, base64, fphttpclient, fpjson, jsonparser;

type

  { TdmPdv }

  TdmPdv = class(TDataModule)
    cdsItensNFBCII: TFloatField;
    cdsItensNFCEST: TStringField;
    cdsItensNFCFOP: TStringField;
    cdsItensNFCODDETALHE: TLongintField;
    cdsItensNFCODMOVIMENTO: TLongintField;
    cdsItensNFCODPRO: TStringField;
    cdsItensNFCODPRODUTO: TLongintField;
    cdsItensNFCOD_BARRA: TStringField;
    cdsItensNFCSOSN: TStringField;
    cdsItensNFCST: TStringField;
    cdsItensNFCSTCOFINS: TStringField;
    cdsItensNFCSTIPI: TStringField;
    cdsItensNFCSTPIS: TStringField;
    cdsItensNFCST_IPI_CENQ: TStringField;
    cdsItensNFDESCPRODUTO: TStringField;
    cdsItensNFDTAFAB: TDateField;
    cdsItensNFDTAVCTO: TDateField;
    cdsItensNFFRETE: TFloatField;
    cdsItensNFICMS: TFloatField;
    cdsItensNFICMS_PST: TFloatField;
    cdsItensNFICMS_SUBST: TFloatField;
    cdsItensNFICMS_SUBSTD: TFloatField;
    cdsItensNFII: TFloatField;
    cdsItensNFLOTE: TStringField;
    cdsItensNFNITEMPED: TLongintField;
    cdsItensNFOBS: TStringField;
    cdsItensNFPCOFINS: TFloatField;
    cdsItensNFPEDIDO: TStringField;
    cdsItensNFPERCIPIDEVOL: TFloatField;
    cdsItensNFPFCPUFDEST: TFloatField;
    cdsItensNFPGLP: TFloatField;
    cdsItensNFPGNI: TFloatField;
    cdsItensNFPGNN: TFloatField;
    cdsItensNFPICMSINTER: TFloatField;
    cdsItensNFPICMSINTERPART: TFloatField;
    cdsItensNFPICMSUFDEST: TFloatField;
    cdsItensNFPIPI: TFloatField;
    cdsItensNFPPIS: TFloatField;
    cdsItensNFPRECO: TFloatField;
    cdsItensNFP_FCP: TFloatField;
    cdsItensNFP_FCPST: TFloatField;
    cdsItensNFP_FCPSTRET: TFloatField;
    cdsItensNFQUANTIDADE: TFloatField;
    cdsItensNFUNIDADEMEDIDA: TStringField;
    cdsItensNFVALORIPIDEVOL: TFloatField;
    cdsItensNFVALOR_COFINS: TFloatField;
    cdsItensNFVALOR_DESCONTO: TFloatField;
    cdsItensNFVALOR_ICMS: TFloatField;
    cdsItensNFVALOR_OUTROS: TFloatField;
    cdsItensNFVALOR_PIS: TFloatField;
    cdsItensNFVALOR_SEGURO: TFloatField;
    cdsItensNFVALTOTAL: TFloatField;
    cdsItensNFVBCSTDEST: TFloatField;
    cdsItensNFVBCSTRET: TFloatField;
    cdsItensNFVBCUFDEST: TFloatField;
    cdsItensNFVBFCPUFDEST: TFloatField;
    cdsItensNFVFCPUFDEST: TFloatField;
    cdsItensNFVICMSSTDEST: TFloatField;
    cdsItensNFVICMSSTRET: TFloatField;
    cdsItensNFVICMSUFDEST: TFloatField;
    cdsItensNFVICMSUFREMET: TFloatField;
    cdsItensNFVIPI: TFloatField;
    cdsItensNFVLRBC_COFINS: TFloatField;
    cdsItensNFVLRBC_IPI: TFloatField;
    cdsItensNFVLRBC_PIS: TFloatField;
    cdsItensNFVLRTOT_TRIB: TFloatField;
    cdsItensNFVLR_BASE: TFloatField;
    cdsItensNFVLR_BASEICMS: TFloatField;
    cdsItensNFVPART: TFloatField;
    cdsItensNFV_B_FCP: TFloatField;
    cdsItensNFV_B_FCPST: TFloatField;
    cdsItensNFV_B_FCPSTRET: TFloatField;
    cdsItensNFV_FCP: TFloatField;
    cdsItensNFV_FCPST: TFloatField;
    cdsItensNFV_FCPSTRET: TFloatField;
    dsNF: TDataSource;
    dsCCE: TDataSource;
    IbCon: TIBConnection;
    qcdsFaturaDATAFATURA: TDateField;
    qcdsFaturaFORMAPAGAMENTO: TStringField;
    qcdsFaturaNUMEROFATURA: TStringField;
    qcdsFaturaVALOR: TFloatField;
    qcdsNF: TSQLQuery;
    qcdsNFBASE_COFINS: TFloatField;
    qcdsNFBASE_ICMS: TFloatField;
    qcdsNFBASE_ICMS_SUBST: TFloatField;
    qcdsNFBASE_IPI: TFloatField;
    qcdsNFBASE_PIS: TFloatField;
    qcdsNFBCII: TFloatField;
    qcdsNFCCUSTO: TLongintField;
    qcdsNFCFOP: TStringField;
    qcdsNFCIDADE_TRANSP: TStringField;
    qcdsNFCNPJ: TStringField;
    qcdsNFCNPJ_CPF: TStringField;
    qcdsNFCODCLIENTE: TLongintField;
    qcdsNFCODTRANSP: TLongintField;
    qcdsNFCODVENDA: TLongintField;
    qcdsNFCORPONF1: TStringField;
    qcdsNFCORPONF2: TStringField;
    qcdsNFCORPONF3: TStringField;
    qcdsNFCORPONF4: TStringField;
    qcdsNFCORPONF5: TStringField;
    qcdsNFCORPONF6: TStringField;
    qcdsNFDTAEMISSAO: TDateField;
    qcdsNFDTASAIDA: TDateField;
    qcdsNFEND_TRANSP: TStringField;
    qcdsNFENTRADA: TFloatField;
    qcdsNFESPECIE: TStringField;
    qcdsNFFATURA: TStringField;
    qcdsNFFRETE: TStringField;
    qcdsNFHORASAIDA: TTimeField;
    qcdsNFIDCOMPLEMENTAR: TStringField;
    qcdsNFII: TFloatField;
    qcdsNFIND_IEDEST: TStringField;
    qcdsNFINSCRICAOESTADUAL: TStringField;
    qcdsNFMARCA: TStringField;
    qcdsNFNATUREZA: TSmallintField;
    qcdsNFNFE_DESTOPERACAO: TStringField;
    qcdsNFNFE_FINNFE: TStringField;
    qcdsNFNFE_FORMATODANFE: TStringField;
    qcdsNFNFE_INDFINAL: TStringField;
    qcdsNFNFE_INDPRES: TStringField;
    qcdsNFNFE_MODELO: TStringField;
    qcdsNFNFE_TIPOEMISSAO: TStringField;
    qcdsNFNFE_VERSAO: TStringField;
    qcdsNFNOMETRANSP: TStringField;
    qcdsNFNOMEXML: TStringField;
    qcdsNFNOTASERIE: TStringField;
    qcdsNFNUMERO: TStringField;
    qcdsNFNUMNF: TLongintField;
    qcdsNFNUMRECIBO: TStringField;
    qcdsNFOUTRAS_DESP: TFloatField;
    qcdsNFPESOBRUTO: TBCDField;
    qcdsNFPESOLIQUIDO: TBCDField;
    qcdsNFPLACATRANSP: TStringField;
    qcdsNFPROTOCOLOCANC: TStringField;
    qcdsNFPROTOCOLOENV: TStringField;
    qcdsNFQUANTIDADE: TFloatField;
    qcdsNFRAZAOSOCIAL: TStringField;
    qcdsNFREDUZICMS: TFloatField;
    qcdsNFSELECIONOU: TStringField;
    qcdsNFSTATUS: TStringField;
    qcdsNFTRANSP2: TStringField;
    qcdsNFUF_TRANSP: TStringField;
    qcdsNFUF_VEICULO_TRANSP: TStringField;
    qcdsNFVALOR_COFINS: TFloatField;
    qcdsNFVALOR_DESCONTO: TFloatField;
    qcdsNFVALOR_FRETE: TFloatField;
    qcdsNFVALOR_ICMS: TFloatField;
    qcdsNFVALOR_ICMS_SUBST: TFloatField;
    qcdsNFVALOR_IPI: TFloatField;
    qcdsNFVALOR_PAGAR: TFloatField;
    qcdsNFVALOR_PIS: TFloatField;
    qcdsNFVALOR_PRODUTO: TFloatField;
    qcdsNFVALOR_SEGURO: TFloatField;
    qcdsNFVALOR_TOTAL_NOTA: TFloatField;
    qcdsNFVLRTOT_TRIB: TFloatField;
    qcdsNFV_B_FCPUFDEST: TFloatField;
    qcdsNFV_FCP: TFloatField;
    qcdsNFV_FCPST: TFloatField;
    qcdsNFV_FCPSTRET: TFloatField;
    qcdsNFV_IPI_DEVOL: TFloatField;
    qcdsNFXMLNFE: TBlobField;
    qcds_ccustoCODIGO: TLongintField;
    qcds_ccustoCONTA: TStringField;
    qcds_ccustoNOME: TStringField;
    qcds_parametroCONFIGURADO: TStringField;
    qcds_parametroD1: TStringField;
    qcds_parametroD2: TStringField;
    qcds_parametroD3: TStringField;
    qcds_parametroD4: TStringField;
    qcds_parametroD5: TStringField;
    qcds_parametroD6: TStringField;
    qcds_parametroD7: TStringField;
    qcds_parametroD8: TStringField;
    qcds_parametroD9: TStringField;
    qcds_parametroDADOS: TStringField;
    qcds_parametroDESCRICAO: TStringField;
    qcds_parametroINSTRUCOES: TStringField;
    qcds_parametroPARAMETRO: TStringField;
    qcds_parametroVALOR: TFloatField;
    qsCFOPCFCOD: TStringField;
    qsCFOPCFNOME: TStringField;
    qsCFOPCODFISCAL: TStringField;
    qsCFOPCOFINS: TFloatField;
    qsCFOPCSTCOFINS: TStringField;
    qsCFOPCSTIPI: TStringField;
    qsCFOPCSTPIS: TStringField;
    qsCFOPICMS: TFloatField;
    qsCFOPICMS_SUBSTRIB: TFloatField;
    qsCFOPICMS_SUBSTRIB_IC: TFloatField;
    qsCFOPICMS_SUBSTRIB_IND: TFloatField;
    qsCFOPIPI: TFloatField;
    qsCFOPNAOENVFATURA: TStringField;
    qsCFOPPIS: TFloatField;
    qsCFOPREDUCAO: TFloatField;
    qsCFOPUF: TStringField;
    qsClienteBAIRRO: TStringField;
    qsClienteCD_IBGE: TStringField;
    qsClienteCEP: TStringField;
    qsClienteCIDADE: TStringField;
    qsClienteCNPJ: TStringField;
    qsClienteCODCLIENTE: TLongintField;
    qsClienteCODFISCAL: TStringField;
    qsClienteCODPAIS: TStringField;
    qsClienteCOMPLEMENTO: TStringField;
    qsClienteCONTATO: TStringField;
    qsClienteDDD: TStringField;
    qsClienteE_MAIL: TStringField;
    qsClienteINSCESTADUAL: TStringField;
    qsClienteLOGRADOURO: TStringField;
    qsClienteNOMECLIENTE: TStringField;
    qsClienteNUMERO: TStringField;
    qsClientePAIS: TStringField;
    qsClienteRAZAOSOCIAL: TStringField;
    qsClienteSUFRAMA: TStringField;
    qsClienteTELEFONE: TStringField;
    qsClienteTEM_IE: TStringField;
    qsClienteTIPOFIRMA: TSmallintField;
    qsClienteUF: TStringField;
    qsEmpresa1: TSQLQuery;
    qsEmpresa1ANOLETIVO: TLongintField;
    qsEmpresa1BAIRRO: TStringField;
    qsEmpresa1BASECALCULOCREDITO: TSmallintField;
    qsEmpresa1CCUSTO: TLongintField;
    qsEmpresa1CD_IBGE: TStringField;
    qsEmpresa1CEP: TStringField;
    qsEmpresa1CERTIFICADO: TStringField;
    qsEmpresa1CHAVECONT: TStringField;
    qsEmpresa1CHAVELIC: TStringField;
    qsEmpresa1CIDADE: TStringField;
    qsEmpresa1CNPJPREFEITURA: TStringField;
    qsEmpresa1CNPJ_CPF: TStringField;
    qsEmpresa1CODAJ: TSmallintField;
    qsEmpresa1CODCONT: TSmallintField;
    qsEmpresa1CODCRED: TSmallintField;
    qsEmpresa1CODIGO: TLongintField;
    qsEmpresa1CODIGO_CONTA: TLongintField;
    qsEmpresa1CODINDCRITESCRIT: TSmallintField;
    qsEmpresa1CODINDINCTRIBUTARIA: TSmallintField;
    qsEmpresa1CODINDTIPOCON: TSmallintField;
    qsEmpresa1CONTADOR: TStringField;
    qsEmpresa1CONTADOR_BAIRRO: TStringField;
    qsEmpresa1CONTADOR_CEP: TStringField;
    qsEmpresa1CONTADOR_CNPJ: TStringField;
    qsEmpresa1CONTADOR_COD_MUN: TStringField;
    qsEmpresa1CONTADOR_COMPL: TStringField;
    qsEmpresa1CONTADOR_CPF: TStringField;
    qsEmpresa1CONTADOR_CRC: TStringField;
    qsEmpresa1CONTADOR_EMAIL: TStringField;
    qsEmpresa1CONTADOR_END: TStringField;
    qsEmpresa1CONTADOR_FAX: TStringField;
    qsEmpresa1CONTADOR_FONE: TStringField;
    qsEmpresa1CONTADOR_NUMEND: TStringField;
    qsEmpresa1CRT: TLongintField;
    qsEmpresa1DDD: TStringField;
    qsEmpresa1DIVERSOS1: TStringField;
    qsEmpresa1DIVERSOS2: TStringField;
    qsEmpresa1DIVERSOS3: TStringField;
    qsEmpresa1ECFCX: TStringField;
    qsEmpresa1ECFFAB: TStringField;
    qsEmpresa1ECFMOD: TStringField;
    qsEmpresa1EMPRESA: TStringField;
    qsEmpresa1ENDERECO: TStringField;
    qsEmpresa1E_MAIL: TStringField;
    qsEmpresa1FAX: TStringField;
    qsEmpresa1FONE: TStringField;
    qsEmpresa1FONE_1: TStringField;
    qsEmpresa1FONE_2: TStringField;
    qsEmpresa1GIAF1: TStringField;
    qsEmpresa1GIAF3: TStringField;
    qsEmpresa1GIAF4: TStringField;
    qsEmpresa1IE_RG: TStringField;
    qsEmpresa1IM: TStringField;
    qsEmpresa1INDAJ: TSmallintField;
    qsEmpresa1INDAPROCRED: TSmallintField;
    qsEmpresa1INDCODINCIDENCIA: TSmallintField;
    qsEmpresa1INDCREDORI: TSmallintField;
    qsEmpresa1INDCTA: TSmallintField;
    qsEmpresa1INDDESCCRED: TSmallintField;
    qsEmpresa1INDESCRITURACAO: TSmallintField;
    qsEmpresa1INDICADORATIVIDADE: TSmallintField;
    qsEmpresa1INDICADORNATUREZAPJ: TSmallintField;
    qsEmpresa1INDNATDEDUCAO: TSmallintField;
    qsEmpresa1INDNATREC: TSmallintField;
    qsEmpresa1INDNATRETFONTE: TSmallintField;
    qsEmpresa1INDORIGEMDIVERSAS: TSmallintField;
    qsEmpresa1INDREC: TSmallintField;
    qsEmpresa1INDTIPCOOP: TSmallintField;
    qsEmpresa1INDTPOPERACAORECEITA: TSmallintField;
    qsEmpresa1LOGOTIPO: TBlobField;
    qsEmpresa1LOGRADOURO: TStringField;
    qsEmpresa1MEDIA_ESCOLA: TFloatField;
    qsEmpresa1MODELOCUPOM: TStringField;
    qsEmpresa1NATCREDDESC: TSmallintField;
    qsEmpresa1NOMEPREFEITURA: TStringField;
    qsEmpresa1NUMERO: TStringField;
    qsEmpresa1OUTRAS_INFO: TStringField;
    qsEmpresa1PORTA: TLongintField;
    qsEmpresa1RAZAO: TStringField;
    qsEmpresa1SENHA: TStringField;
    qsEmpresa1SLOGAN: TStringField;
    qsEmpresa1SMTP: TStringField;
    qsEmpresa1TIPO: TStringField;
    qsEmpresa1TREGIME: TLongintField;
    qsEmpresa1UF: TStringField;
    qsEmpresa1WEB: TStringField;
    qsEndEntregaBAIRRO: TStringField;
    qsEndEntregaCD_IBGE: TStringField;
    qsEndEntregaCEP: TStringField;
    qsEndEntregaCIDADE: TStringField;
    qsEndEntregaCODCLIENTE: TLongintField;
    qsEndEntregaCODENDERECO: TLongintField;
    qsEndEntregaCOMPLEMENTO: TStringField;
    qsEndEntregaDADOSADICIONAIS: TStringField;
    qsEndEntregaDDD: TStringField;
    qsEndEntregaDDD1: TStringField;
    qsEndEntregaDDD2: TStringField;
    qsEndEntregaDDD3: TStringField;
    qsEndEntregaE_MAIL: TStringField;
    qsEndEntregaFAX: TStringField;
    qsEndEntregaLOGRADOURO: TStringField;
    qsEndEntregaNUMERO: TStringField;
    qsEndEntregaPAIS: TStringField;
    qsEndEntregaRAMAL: TStringField;
    qsEndEntregaTELEFONE: TStringField;
    qsEndEntregaTELEFONE1: TStringField;
    qsEndEntregaTELEFONE2: TStringField;
    qsEndEntregaTIPOEND: TSmallintField;
    qsEndEntregaUF: TStringField;
    qsNFCNUMNF: TLongintField;
    qsNFCNUMRECIBO: TStringField;
    qsNFCPROTOCOLOCANC: TStringField;
    qsNFCPROTOCOLOENV: TStringField;
    qsEmpresaANOLETIVO: TLongintField;
    qsEmpresaBAIRRO: TStringField;
    qsEmpresaBASECALCULOCREDITO: TSmallintField;
    qsEmpresaCCUSTO: TLongintField;
    qsEmpresaCD_IBGE: TStringField;
    qsEmpresaCENTROCUSTO: TStringField;
    qsEmpresaCEP: TStringField;
    qsEmpresaCERTIFICADO: TStringField;
    qsEmpresaCHAVECONT: TStringField;
    qsEmpresaCHAVELIC: TStringField;
    qsEmpresaCIDADE: TStringField;
    qsEmpresaCNPJPREFEITURA: TStringField;
    qsEmpresaCNPJ_CPF: TStringField;
    qsEmpresaCODAJ: TSmallintField;
    qsEmpresaCODCONT: TSmallintField;
    qsEmpresaCODCRED: TSmallintField;
    qsEmpresaCODIGO: TLongintField;
    qsEmpresaCODIGO_CONTA: TLongintField;
    qsEmpresaCODINDCRITESCRIT: TSmallintField;
    qsEmpresaCODINDINCTRIBUTARIA: TSmallintField;
    qsEmpresaCODINDTIPOCON: TSmallintField;
    qsEmpresaCONTADOR: TStringField;
    qsEmpresaCONTADOR_BAIRRO: TStringField;
    qsEmpresaCONTADOR_CEP: TStringField;
    qsEmpresaCONTADOR_CNPJ: TStringField;
    qsEmpresaCONTADOR_COD_MUN: TStringField;
    qsEmpresaCONTADOR_COMPL: TStringField;
    qsEmpresaCONTADOR_CPF: TStringField;
    qsEmpresaCONTADOR_CRC: TStringField;
    qsEmpresaCONTADOR_EMAIL: TStringField;
    qsEmpresaCONTADOR_END: TStringField;
    qsEmpresaCONTADOR_FAX: TStringField;
    qsEmpresaCONTADOR_FONE: TStringField;
    qsEmpresaCONTADOR_NUMEND: TStringField;
    qsEmpresaCRT: TLongintField;
    qsEmpresaDDD: TStringField;
    qsEmpresaDIVERSOS1: TStringField;
    qsEmpresaDIVERSOS2: TStringField;
    qsEmpresaDIVERSOS3: TStringField;
    qsEmpresaECFCX: TStringField;
    qsEmpresaECFFAB: TStringField;
    qsEmpresaECFMOD: TStringField;
    qsEmpresaEMPRESA: TStringField;
    qsEmpresaENDERECO: TStringField;
    qsEmpresaE_MAIL: TStringField;
    qsEmpresaFAX: TStringField;
    qsEmpresaFONE: TStringField;
    qsEmpresaFONE_1: TStringField;
    qsEmpresaFONE_2: TStringField;
    qsEmpresaGIAF1: TStringField;
    qsEmpresaGIAF3: TStringField;
    qsEmpresaGIAF4: TStringField;
    qsEmpresaIE_RG: TStringField;
    qsEmpresaIM: TStringField;
    qsEmpresaINDAJ: TSmallintField;
    qsEmpresaINDAPROCRED: TSmallintField;
    qsEmpresaINDCODINCIDENCIA: TSmallintField;
    qsEmpresaINDCREDORI: TSmallintField;
    qsEmpresaINDCTA: TSmallintField;
    qsEmpresaINDDESCCRED: TSmallintField;
    qsEmpresaINDESCRITURACAO: TSmallintField;
    qsEmpresaINDICADORATIVIDADE: TSmallintField;
    qsEmpresaINDICADORNATUREZAPJ: TSmallintField;
    qsEmpresaINDNATDEDUCAO: TSmallintField;
    qsEmpresaINDNATREC: TSmallintField;
    qsEmpresaINDNATRETFONTE: TSmallintField;
    qsEmpresaINDORIGEMDIVERSAS: TSmallintField;
    qsEmpresaINDREC: TSmallintField;
    qsEmpresaINDTIPCOOP: TSmallintField;
    qsEmpresaINDTPOPERACAORECEITA: TSmallintField;
    qsEmpresaLOGOTIPO: TBlobField;
    qsEmpresaLOGRADOURO: TStringField;
    qsEmpresaMEDIA_ESCOLA: TFloatField;
    qsEmpresaMODELOCUPOM: TStringField;
    qsEmpresaNATCREDDESC: TSmallintField;
    qsEmpresaNOMEPREFEITURA: TStringField;
    qsEmpresaNUMERO: TStringField;
    qsEmpresaOUTRAS_INFO: TStringField;
    qsEmpresaPORTA: TLongintField;
    qsEmpresaRAZAO: TStringField;
    qsEmpresaSENHA: TStringField;
    qsEmpresaSLOGAN: TStringField;
    qsEmpresaSMTP: TStringField;
    qsEmpresaTIPO: TStringField;
    qsEmpresaTREGIME: TLongintField;
    qsEmpresaUF: TStringField;
    qsEmpresaWEB: TStringField;
    qsEstadoCODIGO: TLongintField;
    qsEstadoNOME: TStringField;
    qsEstadoSIGLA: TStringField;
    qsFornecBAIRRO: TStringField;
    qsFornecCD_IBGE: TStringField;
    qsFornecCEP: TStringField;
    qsFornecCIDADE: TStringField;
    qsFornecCNPJ: TStringField;
    qsFornecCODCLIENTE: TLongintField;
    qsFornecCODFISCAL: TStringField;
    qsFornecCODPAIS: TStringField;
    qsFornecCOMPLEMENTO: TStringField;
    qsFornecCONTATO: TStringField;
    qsFornecDDD: TSmallintField;
    qsFornecE_MAIL: TStringField;
    qsFornecINSCESTADUAL: TStringField;
    qsFornecLOGRADOURO: TStringField;
    qsFornecNOMECLIENTE: TStringField;
    qsFornecNUMERO: TStringField;
    qsFornecPAIS: TStringField;
    qsFornecRAZAOSOCIAL: TStringField;
    qsFornecTELEFONE: TStringField;
    qsFornecTIPOFIRMA: TSmallintField;
    qsFornecUF: TStringField;
    qsMaiorData_EXCLUIR: TSQLQuery;
    qsMaiorData_EXCLUIRMAIORDATA: TDateField;
    qsProdutosBASE_ICMS: TFloatField;
    qsProdutosCATEGORIA: TStringField;
    qsProdutosCEST: TStringField;
    qsProdutosCLASSIFIC_FISCAL: TStringField;
    qsProdutosCODALMOXARIFADO: TLongintField;
    qsProdutosCODFORN: TStringField;
    qsProdutosCODPRO: TStringField;
    qsProdutosCODPRODUTO: TLongintField;
    qsProdutosCOD_BARRA: TStringField;
    qsProdutosCOD_COMISSAO: TLongintField;
    qsProdutosCONTA_DESPESA: TStringField;
    qsProdutosCONTA_ESTOQUE: TStringField;
    qsProdutosCONTA_RECEITA: TStringField;
    qsProdutosCPRODANP: TStringField;
    qsProdutosCST: TStringField;
    qsProdutosDATACADASTRO: TDateTimeField;
    qsProdutosDATAGRAV: TDateField;
    qsProdutosDATAULTIMACOMPRA: TDateField;
    qsProdutosEMBALAGEM: TStringField;
    qsProdutosESTOQUEATUAL: TFloatField;
    qsProdutosESTOQUEMAXIMO: TFloatField;
    qsProdutosESTOQUEMINIMO: TFloatField;
    qsProdutosESTOQUEREPOSICAO: TFloatField;
    qsProdutosFAMILIA: TStringField;
    qsProdutosFOTOPRODUTO: TStringField;
    qsProdutosGENERO: TLongintField;
    qsProdutosGERADESCONTO: TStringField;
    qsProdutosICMS: TFloatField;
    qsProdutosIMPRESSORA_1: TStringField;
    qsProdutosIMPRESSORA_2: TStringField;
    qsProdutosIMPRESSORA_3: TStringField;
    qsProdutosIMPRIMIR: TStringField;
    qsProdutosIPI: TFloatField;
    qsProdutosLOCALIZACAO: TStringField;
    qsProdutosLOTES: TStringField;
    qsProdutosMARCA: TStringField;
    qsProdutosMARGEM: TFloatField;
    qsProdutosMARGEM_LUCRO: TFloatField;
    qsProdutosNCM: TStringField;
    qsProdutosOBS: TStringField;
    qsProdutosORIGEM: TLongintField;
    qsProdutosPESO_LIQ: TFloatField;
    qsProdutosPESO_QTDE: TFloatField;
    qsProdutosPGLP: TFloatField;
    qsProdutosPGNI: TFloatField;
    qsProdutosPGNN: TFloatField;
    qsProdutosPMIXGN: TFloatField;
    qsProdutosPRECOATACADO: TFloatField;
    qsProdutosPRECOMEDIO: TBCDField;
    qsProdutosPRODUTO: TStringField;
    qsProdutosPRO_COD: TStringField;
    qsProdutosQTD: TLongintField;
    qsProdutosQTDEATACADO: TFloatField;
    qsProdutosQTDE_PCT: TFloatField;
    qsProdutosRATEIO: TStringField;
    qsProdutosTAM_LOTE: TLongintField;
    qsProdutosTIPO: TStringField;
    qsProdutosTIPOPRECOVENDA: TStringField;
    qsProdutosUNIDADEMEDIDA: TStringField;
    qsProdutosUSA: TStringField;
    qsProdutosVALIQPROD: TFloatField;
    qsProdutosVALORCOMISSAO: TFloatField;
    qsProdutosVALORMINIMO: TFloatField;
    qsProdutosVALORUNITARIOANTERIOR: TFloatField;
    qsProdutosVALORUNITARIOATUAL: TFloatField;
    qsProdutosVALOR_PRAZO: TFloatField;
    qsProdutosVPART: TFloatField;
    sAdicaoADIC_CODDET: TLongintField;
    sAdicaoADIC_CODDI: TLongintField;
    sAdicaoADIC_CODFAB: TStringField;
    sAdicaoADIC_NADICAO: TLongintField;
    sAdicaoADIC_NSEQUEN: TLongintField;
    sAdicaoADIC_VDESC: TLongintField;
    sDiCODMOVIMENTO: TLongintField;
    sDiDI_CODDI: TLongintField;
    sDiDI_CODEXPORTADOR: TStringField;
    sDiDI_DATA: TDateField;
    sDiDI_DATADESEMB: TDateField;
    sDiDI_LOCALDESEMB: TStringField;
    sDiDI_NUMDI: TStringField;
    sDiDI_UFDESEMB: TStringField;
    sDiNOTASERIE: TStringField;
    sdsCfopNCMALIQ_CUPOM: TStringField;
    sdsCfopNCMCFOP: TStringField;
    sdsCfopNCMCODFISCAL: TStringField;
    sdsCfopNCMCOFINS: TFloatField;
    sdsCfopNCMCSOSN: TStringField;
    sdsCfopNCMCST: TStringField;
    sdsCfopNCMCSTCOFINS: TStringField;
    sdsCfopNCMCSTIPI: TStringField;
    sdsCfopNCMCSTPIS: TStringField;
    sdsCfopNCMCST_IPI_CENQ: TStringField;
    sdsCfopNCMDADOSADC1: TStringField;
    sdsCfopNCMDADOSADC2: TStringField;
    sdsCfopNCMDADOSADC3: TStringField;
    sdsCfopNCMDADOSADC4: TStringField;
    sdsCfopNCMDADOSADC5: TStringField;
    sdsCfopNCMDADOSADC6: TStringField;
    sdsCfopNCMICMS: TFloatField;
    sdsCfopNCMICMS_BASE: TFloatField;
    sdsCfopNCMICMS_SUBST: TFloatField;
    sdsCfopNCMICMS_SUBST_IC: TFloatField;
    sdsCfopNCMICMS_SUBST_IND: TFloatField;
    sdsCfopNCMII_PERCENTUAL: TFloatField;
    sdsCfopNCMIPI: TFloatField;
    sdsCfopNCMNCM: TStringField;
    sdsCfopNCMORIGEM: TLongintField;
    sdsCfopNCMPFCPUFDEST: TFloatField;
    sdsCfopNCMPICMSINTER: TFloatField;
    sdsCfopNCMPICMSINTERPART: TFloatField;
    sdsCfopNCMPICMSUFDEST: TFloatField;
    sdsCfopNCMPIS: TFloatField;
    sdsCfopNCMREDBASECOFINS: TFloatField;
    sdsCfopNCMREDBASEIPI: TFloatField;
    sdsCfopNCMREDBASEPIS: TFloatField;
    sdsCfopNCMUF: TStringField;
    sdsCfopNCMVBCUFDEST: TFloatField;
    sdsCfopNCMVFCPUFDEST: TFloatField;
    sdsCfopNCMVICMSUFDEST: TFloatField;
    sdsCfopNCMVICMSUFREMET: TFloatField;
    sdsCfopProdALIQ_CUPOM: TStringField;
    sdsCfopProdCFOP: TStringField;
    sdsCfopProdCODFISCAL: TStringField;
    sdsCfopProdCOD_PROD: TLongintField;
    sdsCfopProdCOFINS: TFloatField;
    sdsCfopProdCSOSN: TStringField;
    sdsCfopProdCST: TStringField;
    sdsCfopProdCSTCOFINS: TStringField;
    sdsCfopProdCSTIPI: TStringField;
    sdsCfopProdCSTPIS: TStringField;
    sdsCfopProdCST_IPI_CENQ: TStringField;
    sdsCfopProdICMS: TFloatField;
    sdsCfopProdICMS_BASE: TFloatField;
    sdsCfopProdICMS_SUBST: TFloatField;
    sdsCfopProdICMS_SUBST_IC: TFloatField;
    sdsCfopProdICMS_SUBST_IND: TFloatField;
    sdsCfopProdIPI: TFloatField;
    sdsCfopProdPFCPUFDEST: TFloatField;
    sdsCfopProdPICMSINTER: TFloatField;
    sdsCfopProdPICMSINTERPART: TFloatField;
    sdsCfopProdPICMSUFDEST: TFloatField;
    sdsCfopProdPIS: TFloatField;
    sdsCfopProdUF: TStringField;
    sdsCfopProdVBCUFDEST: TFloatField;
    sdsCfopProdVFCPUFDEST: TFloatField;
    sdsCfopProdVICMSUFDEST: TFloatField;
    sdsCfopProdVICMSUFREMET: TFloatField;
    sdsProd_CombCPRODANP: TStringField;
    sdsProd_CombPMIXGN: TFloatField;
    sdsProd_CombVALIQPROD: TFloatField;
    sqBusca: TSQLQuery;
    sqBusca1: TSQLQuery;
    sqClienteANOLETIVO: TStringField;
    sqClienteANUIDADE: TFloatField;
    sqClienteBANDA_DOWLOAD: TStringField;
    sqClienteBANDA_UPLOAD: TStringField;
    sqClienteBASE_ICMS: TSmallintField;
    sqClienteBLOQUEADO: TStringField;
    sqClienteBLOQUEIO: TStringField;
    sqClienteCARGOFUNCAO: TLongintField;
    sqClienteCARTEIRAVACINACAO: TStringField;
    sqClienteCELULARMAE: TStringField;
    sqClienteCELULARPAI: TStringField;
    sqClienteCERTIDAONASCNUM: TStringField;
    sqClienteCERT_NAS_COMARCA: TStringField;
    sqClienteCERT_NAS_DISTRITO: TStringField;
    sqClienteCERT_NAS_MUNICIPIO: TStringField;
    sqClienteCERT_NAS_SUBDISTRITO: TStringField;
    sqClienteCERT_NAS_UF: TStringField;
    sqClienteCFOP: TStringField;
    sqClienteCIDADENASC: TStringField;
    sqClienteCNPJ: TStringField;
    sqClienteCODBANCO: TSmallintField;
    sqClienteCODCLIENTE: TLongintField;
    sqClienteCODFISCAL: TStringField;
    sqClienteCODFORNECEDOR: TLongintField;
    sqClienteCODINCLUCANC: TLongintField;
    sqClienteCODRESPONSAVEL: TLongintField;
    sqClienteCODUSUARIO: TLongintField;
    sqClienteCOD_CLI: TStringField;
    sqClienteCOD_FAIXA: TLongintField;
    sqClienteCOD_TRANPORTADORA: TLongintField;
    sqClienteCOMUNICAALUNO: TStringField;
    sqClienteCOMUNICAMAE: TStringField;
    sqClienteCOMUNICAPAI: TStringField;
    sqClienteCONTATO: TStringField;
    sqClienteCONTA_CLIENTE: TStringField;
    sqClienteCORTESIA: TStringField;
    sqClienteCOR_RACA: TStringField;
    sqClienteCPF: TStringField;
    sqClienteCPFMAE: TStringField;
    sqClienteCPFPAI: TStringField;
    sqClienteCURSO: TStringField;
    sqClienteDATACADASTRO: TDateField;
    sqClienteDATAEMISSAORG: TDateField;
    sqClienteDATANASC: TDateField;
    sqClienteDATANASCIMENTO: TDateTimeField;
    sqClienteDATAREINC: TDateField;
    sqClienteDATARESC: TDateField;
    sqClienteDATATRANSF: TDateField;
    sqClienteDATA_MATRICULA: TDateTimeField;
    sqClienteDESCONTO: TFloatField;
    sqClienteDIVERSO1: TStringField;
    sqClienteDIVERSO2: TStringField;
    sqClienteDTAALTERA: TDateField;
    sqClienteEMVIAGEM: TStringField;
    sqClienteESTADORG: TStringField;
    sqClienteEXISTCOPART: TStringField;
    sqClienteEXIST_COBERT: TStringField;
    sqClienteE_FORNECEDOR: TStringField;
    sqClienteFLLIVRONASC: TStringField;
    sqClienteFONEMAE: TStringField;
    sqClienteFONEPAI: TStringField;
    sqClienteFORMA_CORRESPOND: TStringField;
    sqClienteFOTO: TStringField;
    sqClienteGERAAVISO: TStringField;
    sqClienteGERABOL: TStringField;
    sqClienteGERAENV: TStringField;
    sqClienteGRUPO_CLIENTE: TStringField;
    sqClienteHOMEPAGE: TStringField;
    sqClienteID_COB: TLongintField;
    sqClienteINFONECESSARIAS: TStringField;
    sqClienteINSCESTADUAL: TStringField;
    sqClienteIP: TStringField;
    sqClienteLANCADOCLASSE: TLongintField;
    sqClienteLIMITECREDITO: TFloatField;
    sqClienteLIVRONASC: TStringField;
    sqClienteLOCALTRABALUNO: TStringField;
    sqClienteLOCALTRABMAE: TStringField;
    sqClienteLOCALTRABPAI: TStringField;
    sqClienteMAC: TStringField;
    sqClienteMARCA: TStringField;
    sqClienteMENSALIDADE: TFloatField;
    sqClienteNACIONALIDADE: TStringField;
    sqClienteNOMECLIENTE: TStringField;
    sqClienteNOMEMAE: TStringField;
    sqClienteNUMERO: TLongintField;
    sqClienteN_CONTRATO: TStringField;
    sqClienteOBS: TStringField;
    sqClientePAI: TStringField;
    sqClientePARCELA: TLongintField;
    sqClientePARCELAGERADAS: TLongintField;
    sqClientePERIODO: TStringField;
    sqClientePRAZOENTREGA: TSmallintField;
    sqClientePRAZORECEBIMENTO: TSmallintField;
    sqClienteRA: TStringField;
    sqClienteRAPROD: TStringField;
    sqClienteRAPRODESP: TStringField;
    sqClienteRAZAOSOCIAL: TStringField;
    sqClienteREGIAO: TSmallintField;
    sqClienteRG: TStringField;
    sqClienteRGMAE: TStringField;
    sqClienteRGPAI: TStringField;
    sqClienteSEGMENTO: TSmallintField;
    sqClienteSERIE: TStringField;
    sqClienteSERIELETRA: TStringField;
    sqClienteSEXO: TStringField;
    sqClienteSITUACAOESCOLAR: TStringField;
    sqClienteSTATUS: TSmallintField;
    sqClienteSUFRAMA: TStringField;
    sqClienteTELTRABALUNO: TStringField;
    sqClienteTELTRABMAE: TStringField;
    sqClienteTELTRABPAI: TStringField;
    sqClienteTEM_IE: TStringField;
    sqClienteTIPOFIRMA: TSmallintField;
    sqClienteTORRE_CONECCAO: TStringField;
    sqClienteTRANSPORTE: TStringField;
    sqClienteUFNASC: TStringField;
    sqClienteVALOR_CONSUMO: TFloatField;
    sqClienteVALOR_CORTESIA: TFloatField;
    sqClienteVALOR_MATRICULA: TFloatField;
    sqEmpresaANOLETIVO: TLongintField;
    sqEmpresaBAIRRO: TStringField;
    sqEmpresaBASECALCULOCREDITO: TSmallintField;
    sqEmpresaCCUSTO: TLongintField;
    sqEmpresaCD_IBGE: TStringField;
    sqEmpresaCEP: TStringField;
    sqEmpresaCHAVECONT: TStringField;
    sqEmpresaCHAVELIC: TStringField;
    sqEmpresaCIDADE: TStringField;
    sqEmpresaCNPJPREFEITURA: TStringField;
    sqEmpresaCNPJ_CPF: TStringField;
    sqEmpresaCODAJ: TSmallintField;
    sqEmpresaCODCONT: TSmallintField;
    sqEmpresaCODCRED: TSmallintField;
    sqEmpresaCODIGO: TLongintField;
    sqEmpresaCODIGO_CONTA: TLongintField;
    sqEmpresaCODINDCRITESCRIT: TSmallintField;
    sqEmpresaCODINDINCTRIBUTARIA: TSmallintField;
    sqEmpresaCODINDTIPOCON: TSmallintField;
    sqEmpresaCONTADOR: TStringField;
    sqEmpresaCONTADOR_BAIRRO: TStringField;
    sqEmpresaCONTADOR_CEP: TStringField;
    sqEmpresaCONTADOR_CNPJ: TStringField;
    sqEmpresaCONTADOR_COD_MUN: TStringField;
    sqEmpresaCONTADOR_COMPL: TStringField;
    sqEmpresaCONTADOR_CPF: TStringField;
    sqEmpresaCONTADOR_CRC: TStringField;
    sqEmpresaCONTADOR_EMAIL: TStringField;
    sqEmpresaCONTADOR_END: TStringField;
    sqEmpresaCONTADOR_FAX: TStringField;
    sqEmpresaCONTADOR_FONE: TStringField;
    sqEmpresaCONTADOR_NUMEND: TStringField;
    sqEmpresaCRT: TLongintField;
    sqEmpresaDDD: TStringField;
    sqEmpresaDIVERSOS1: TStringField;
    sqEmpresaDIVERSOS2: TStringField;
    sqEmpresaDIVERSOS3: TStringField;
    sqEmpresaECFCX: TStringField;
    sqEmpresaECFFAB: TStringField;
    sqEmpresaECFMOD: TStringField;
    sqEmpresaEMPRESA: TStringField;
    sqEmpresaENDERECO: TStringField;
    sqEmpresaE_MAIL: TStringField;
    sqEmpresaFAX: TStringField;
    sqEmpresaFONE: TStringField;
    sqEmpresaFONE_1: TStringField;
    sqEmpresaFONE_2: TStringField;
    sqEmpresaIE_RG: TStringField;
    sqEmpresaIM: TStringField;
    sqEmpresaINDAJ: TSmallintField;
    sqEmpresaINDAPROCRED: TSmallintField;
    sqEmpresaINDCODINCIDENCIA: TSmallintField;
    sqEmpresaINDCREDORI: TSmallintField;
    sqEmpresaINDCTA: TSmallintField;
    sqEmpresaINDDESCCRED: TSmallintField;
    sqEmpresaINDESCRITURACAO: TSmallintField;
    sqEmpresaINDICADORATIVIDADE: TSmallintField;
    sqEmpresaINDICADORNATUREZAPJ: TSmallintField;
    sqEmpresaINDNATDEDUCAO: TSmallintField;
    sqEmpresaINDNATREC: TSmallintField;
    sqEmpresaINDNATRETFONTE: TSmallintField;
    sqEmpresaINDORIGEMDIVERSAS: TSmallintField;
    sqEmpresaINDREC: TSmallintField;
    sqEmpresaINDTIPCOOP: TSmallintField;
    sqEmpresaINDTPOPERACAORECEITA: TSmallintField;
    sqEmpresaLOGOTIPO: TBlobField;
    sqEmpresaLOGRADOURO: TStringField;
    sqEmpresaMEDIA_ESCOLA: TFloatField;
    sqEmpresaMODELOCUPOM: TStringField;
    sqEmpresaNATCREDDESC: TSmallintField;
    sqEmpresaNOMEPREFEITURA: TStringField;
    sqEmpresaNUMERO: TStringField;
    sqEmpresaOUTRAS_INFO: TStringField;
    sqEmpresaPORTA: TLongintField;
    sqEmpresaRAZAO: TStringField;
    sqEmpresaSENHA: TStringField;
    sqEmpresaSLOGAN: TStringField;
    sqEmpresaSMTP: TStringField;
    sqEmpresaTIPO: TStringField;
    sqEmpresaTREGIME: TLongintField;
    sqEmpresaUF: TStringField;
    sqEmpresaWEB: TStringField;
    sqGenerator: TSQLQuery;
    sqLancamentos: TSQLQuery;
    sqLancamentosALIQ_CUPOM: TStringField;
    sqLancamentosBAIXA: TStringField;
    sqLancamentosCEST: TStringField;
    sqLancamentosCEST_1: TStringField;
    sqLancamentosCFOP: TStringField;
    sqLancamentosCODALMOXARIFADO: TLongintField;
    sqLancamentosCODCLIENTE: TLongintField;
    sqLancamentosCODDETALHE: TLongintField;
    sqLancamentosCODIGO: TLongintField;
    sqLancamentosCODMOVIMENTO: TLongintField;
    sqLancamentosCODNATUREZA: TSmallintField;
    sqLancamentosCODPRO: TStringField;
    sqLancamentosCODPRODUTO: TLongintField;
    sqLancamentosCODUSUARIO: TSmallintField;
    sqLancamentosCODVENDEDOR: TSmallintField;
    sqLancamentosCOD_BARRA: TStringField;
    sqLancamentosCONTROLE: TStringField;
    sqLancamentosCONTROLE_1: TSmallintField;
    sqLancamentosCSOSN: TStringField;
    sqLancamentosCST: TStringField;
    sqLancamentosCSTCOFINS: TStringField;
    sqLancamentosCSTIPI: TStringField;
    sqLancamentosCSTPIS: TStringField;
    sqLancamentosDATAMOVIMENTO: TDateField;
    sqLancamentosDESCONTO: TFloatField;
    sqLancamentosDESCONTO_BC: TStringField;
    sqLancamentosDESCPRODUTO: TStringField;
    sqLancamentosESTOQUEATUAL: TFloatField;
    sqLancamentosICMS: TFloatField;
    sqLancamentosICMS_SUBST: TFloatField;
    sqLancamentosII: TFloatField;
    sqLancamentosLOCALIZACAO: TStringField;
    sqLancamentosNCM: TStringField;
    sqLancamentosNITEMPED: TLongintField;
    sqLancamentosNOMECLIENTE: TStringField;
    sqLancamentosOBS: TStringField;
    sqLancamentosOBS_MD: TStringField;
    sqLancamentosOBS_PROD: TStringField;
    sqLancamentosORIGEM: TStringField;
    sqLancamentosORIGEM_1: TLongintField;
    sqLancamentosPCOFINS: TFloatField;
    sqLancamentosPIPI: TFloatField;
    sqLancamentosPPIS: TFloatField;
    sqLancamentosPRECO: TFloatField;
    sqLancamentosPRECOATACADO: TFloatField;
    sqLancamentosQTDEATACADO: TFloatField;
    sqLancamentosQTDE_ALT: TFloatField;
    sqLancamentosQUANTIDADE: TFloatField;
    sqLancamentosRATEIO: TStringField;
    sqLancamentosSTATUS: TSmallintField;
    sqLancamentosSTATUS_1: TStringField;
    sqLancamentosTIPO: TStringField;
    sqLancamentosTIPOPRECOVENDA: TStringField;
    sqLancamentosTOTALITEM: TFloatField;
    sqLancamentosUN: TStringField;
    sqLancamentosUNIDADEMEDIDA: TStringField;
    sqLancamentosUSA: TStringField;
    sqLancamentosUSUARIOLOGADO: TStringField;
    sqLancamentosVALOR_COFINS: TFloatField;
    sqLancamentosVALOR_DESCONTO: TFloatField;
    sqLancamentosVALOR_ICMS: TFloatField;
    sqLancamentosVALOR_OUTROS: TFloatField;
    sqLancamentosVALOR_PIS: TFloatField;
    sqLancamentosVALOR_SEGURO: TFloatField;
    sqLancamentosVALTOTAL: TFloatField;
    sqLancamentosVIPI: TFloatField;
    sqLancamentosVLRBC_COFINS: TFloatField;
    sqLancamentosVLRBC_IPI: TFloatField;
    sqLancamentosVLRBC_PIS: TFloatField;
    sqLancamentosVLRTOT_TRIB: TFloatField;
    sqLancamentosVLR_BASE: TFloatField;
    sqLancamentosVLR_BASEICMS: TFloatField;
    SQLQuery1: TSQLQuery;
    sqEmpresa: TSQLQuery;
    qcds_ccusto: TSQLQuery;
    qsEmpresa: TSQLQuery;
    qsMenorData_EXCLUIR: TSQLQuery;
    qsMenorData_EXCLUIRMENORDATA: TDateField;
    qcds_parametro: TSQLQuery;
    qsFornec: TSQLQuery;
    qsCliente: TSQLQuery;
    qsCFOP: TSQLQuery;
    qsEstado: TSQLQuery;
    cdsItensNF: TSQLQuery;
    qsProdutos: TSQLQuery;
    qcdsFatura: TSQLQuery;
    qsNFC: TSQLQuery;
    qsEndEntrega: TSQLQuery;
    sAdicao: TSQLQuery;
    sDi: TSQLQuery;
    sdsProd_Comb: TSQLQuery;
    sdsCfopNCM: TSQLQuery;
    sdsCfopProd: TSQLQuery;
    qsTransp: TSQLQuery;
    qsTranspBAIRRO: TStringField;
    qsTranspCEP: TStringField;
    qsTranspCIDADE_TRANSP: TStringField;
    qsTranspCNPJ_CPF: TStringField;
    qsTranspCODTRANSP: TLongintField;
    qsTranspCONTATO: TStringField;
    qsTranspCORPONF1: TStringField;
    qsTranspCORPONF2: TStringField;
    qsTranspCORPONF3: TStringField;
    qsTranspCORPONF4: TStringField;
    qsTranspCORPONF5: TStringField;
    qsTranspCORPONF6: TStringField;
    qsTranspEMAIL: TStringField;
    qsTranspEND_TRANSP: TStringField;
    qsTranspFANTASIA: TStringField;
    qsTranspFAX: TStringField;
    qsTranspFONE: TStringField;
    qsTranspFONE2: TStringField;
    qsTranspFRETE: TStringField;
    qsTranspINSCRICAOESTADUAL: TStringField;
    qsTranspNOMETRANSP: TStringField;
    qsTranspPLACATRANSP: TStringField;
    qsTranspUF_TRANSP: TStringField;
    qsTranspUF_VEICULO_TRANSP: TStringField;
    qsListaTransp: TSQLQuery;
    qsListaTranspBAIRRO: TStringField;
    qsListaTranspCEP: TStringField;
    qsListaTranspCIDADE_TRANSP: TStringField;
    qsListaTranspCNPJ_CPF: TStringField;
    qsListaTranspCODTRANSP: TLongintField;
    qsListaTranspCONTATO: TStringField;
    qsListaTranspCORPONF1: TStringField;
    qsListaTranspCORPONF2: TStringField;
    qsListaTranspCORPONF3: TStringField;
    qsListaTranspCORPONF4: TStringField;
    qsListaTranspCORPONF5: TStringField;
    qsListaTranspCORPONF6: TStringField;
    qsListaTranspEMAIL: TStringField;
    qsListaTranspEND_TRANSP: TStringField;
    qsListaTranspFANTASIA: TStringField;
    qsListaTranspFAX: TStringField;
    qsListaTranspFONE: TStringField;
    qsListaTranspFONE2: TStringField;
    qsListaTranspFRETE: TStringField;
    qsListaTranspINSCRICAOESTADUAL: TStringField;
    qsListaTranspNOMETRANSP: TStringField;
    qsListaTranspPLACATRANSP: TStringField;
    qsListaTranspUF_TRANSP: TStringField;
    qsListaTranspUF_VEICULO_TRANSP: TStringField;
    qsCentroCusto: TSQLQuery;
    qsCentroCustoCODEMPRESA: TLongintField;
    qsCentroCustoNOMEEMPRESA: TStringField;
    qsCentroCustoTIPONOTA: TLongintField;
    qsCentroCustoUCDATA: TStringField;
    qsCentroCustoUCLOGIN: TStringField;
    qsCentroCustoUCMACHINENAME: TStringField;
    qsCCE: TSQLQuery;
    qsCCECHAVE: TStringField;
    qsCCECNPJ: TStringField;
    qsCCECONDICAO: TStringField;
    qsCCECORRECAO: TStringField;
    qsCCEDHENVIO: TDateTimeField;
    qsCCEORGAO: TLongintField;
    qsCCEPROTOCOLO: TStringField;
    qsCCESELECIONOU: TStringField;
    qsCCESEQUENCIA: TLongintField;
    sTabIBGE: TSQLQuery;
    sqlTotal_tributos: TSQLQuery;
    sqCliente: TSQLQuery;
    sqUpdate: TSQLQuery;
    sqParametro: TSQLQuery;
    sqParametroCONFIGURADO: TStringField;
    sqParametroD1: TStringField;
    sqParametroD2: TStringField;
    sqParametroD3: TStringField;
    sqParametroD4: TStringField;
    sqParametroD5: TStringField;
    sqParametroD6: TStringField;
    sqParametroD7: TStringField;
    sqParametroD8: TStringField;
    sqParametroD9: TStringField;
    sqParametroDADOS: TStringField;
    sqParametroDESCRICAO: TStringField;
    sqParametroINSTRUCOES: TStringField;
    sqParametroPARAMETRO: TStringField;
    sqParametroVALOR: TFloatField;
    sTabIBGECD_IBGE: TStringField;
    sTabIBGECD_UF: TStringField;
    sTabIBGENM_LOCALIDADE: TStringField;
    sTabIBGENM_MUNICIPIO: TStringField;
    sTabIBGENM_TIPO_LOCALIDADE: TStringField;
    sTabIBGESQ_IBGE: TLongintField;
    sTrans: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure IbConAfterDisconnect(Sender: TObject);
    procedure IbConBeforeConnect(Sender: TObject);
  private
    procedure atualiza_bd(sistema: String);
    procedure campo_novo(tabela, campo, tipo: String);
    function existe_campo(tabela, campo: String): Boolean;
  public
    modoDesenvolvedor: String;
    usosistema : string;
    precoLivre : String; // o usuario pode alterar o preco do item
    descontoLivre : Double; // 0 = pode dar desconto, > 0 e o valor q pode dar sem permissao
    usaComanda : Integer;
    usaCurso : Integer;
    contaCaixa : Integer;
    margemCodBarra: Integer;
    tamanhoLinha: Integer;
    codMovimentoEst: Integer;
    caixaBanco : String;
    idcaixa : string;
    ccusto : String;
    ccusto_padrao : String;
    versao_sistema: String;
    usaCentroCusto: String;
    tipo_buscaProd: String;
    tipo_CodBarra: String;
    tamanhoDescProd: Integer;
    clientePadrao: Integer;
    tamanhoCodProd: Integer;
    varLogado : String;
    nomeLogado : String;
    senhaLogin : String;
    nomeCaixa : String;
    MICRO : String;
    path_exe: String;
    path_python: String;
    path_script: String;
    path_xml: String;
    path_imp: String;
    portaImp: String;
    NfceSat: String;
    espacoEntreLinhas: Integer;
    NFE_Teste: String;
    ModeloImp: Integer;
    CupomImp : String;
    id_tk: String;
    tk: string;
    SSLLib : Integer;
    CryptLib :Integer;
    HttpLib :Integer;
    XmlSignLib :Integer;
    CaminhoCert:String;
    SenhaCert :String;
    NumSerieCert :String;
    OutrosCartoes : String;
    vendedor_padrao: Integer;
    imp_controle_porta: Boolean;
    imp_Interval: Integer;
    imp_vias: Integer;
    imp_LinhasBuffer: Integer;
    imp_ColunaFonteNormal: Integer;
    imp_larguraBobina: Integer;
    function executaSql(strSql: String): Boolean;
    procedure executaDSQL(strDSQL: String); // criei pra executar o atualiza Bd
    procedure gravaLog(DataLog: TDateTime; usuario: String; tipoMovimento: String;
    pc: String; valorAnt: String; valorPos: String; campoChave: String; acao: String);
    function busca_generator(generator: String): integer;
    function busca_serie(Serie: String): integer;
    procedure busca_sql(sql_txt: String);
    procedure executa_integracao;
  end;
var
  dmPdv: TdmPdv;

implementation

{$R *.lfm}

{ TdmPdv }

procedure TdmPdv.DataModuleCreate(Sender: TObject);
var
  conf: TIniFile;
  snh: String;
  vstr: String;
begin
  //extrac
  contaCaixa := 0;
  caixaBanco := '1.1.1.01';
  id_tk := '';
  tk := '';
  NFE_Teste := 'N';
  varLogado := ''; // usuario logado
  nomeLogado:= '';
  senhaLogin := '';
  clientePadrao := 1;
  tipo_buscaProd := 'NORMAL';
  tipo_CodBarra := 'PRECO';
  MICRO := GetEnvironmentVariable('COMPUTERNAME');
  path_exe := ExtractFilePath(ParamStr(0));
  path_xml := path_exe;
  IBCon.Connected:=False;

  sTrans.Params.Text := 'isc_tpb_read_committed';
  //IBCon.CharSet:='WIN1252';
  //path_exe := path_exe;
  if FileExists(path_exe  + 'dbxconnections.ini') then
  begin
    conf := TIniFile.Create(path_exe + 'dbxconnections.ini');
    try
      vstr := conf.ReadString('nfe', 'Database', '');
      IBCon.DatabaseName := vstr;
      vstr := conf.ReadString('nfe', 'Hostname', '');
      IBCon.HostName := vstr;
      snh := conf.ReadString('nfe', 'Password', '');
      //snh:= EncodeStringBase64(snh); // Ver a senha Encryptada
      //snh:= DecodeStringBase64(snh);
      IBCon.Password := snh;
      vstr := IntToStr(conf.ReadInteger('nfe', 'Port', 3050));
      IbCon.Params.Add('port=' + vstr)
    finally
      conf.free;
    end;
  end;
  if FileExists(path_exe  + 'nfe.ini') then
  begin
    conf := TIniFile.Create(path_exe + 'nfe.ini');
    try
      portaImp := conf.ReadString('IMPRESSORA', 'porta', '');
      ModeloImp := conf.ReadInteger('IMPRESSORA', 'Modelo', 0);
      CupomImp := conf.ReadString('IMPRESSORA', 'Cupom', 'Texto');
      espacoEntreLinhas := conf.ReadInteger('IMPRESSORA', 'EspacoEntreLinhas', 10);
      margemCodBarra := conf.ReadInteger('IMPRESSORA', 'MargemCodBarra', 50);
      tamanhoLinha := conf.ReadInteger('IMPRESSORA', 'TamanhoLinha', 36);
      imp_controle_porta := conf.ReadBool('IMPRESSORA', 'ControlaPorta', False);
      imp_Interval := conf.ReadInteger('IMPRESSORA', 'SendBytesInterval', 100);
      imp_vias := conf.ReadInteger('IMPRESSORA', 'NumeroVias', 1);
      imp_LinhasBuffer:= conf.ReadInteger('IMPRESSORA', 'LinhasBuffer', 10);
      imp_larguraBobina:= conf.ReadInteger('IMPRESSORA', 'LarguraBobina', 302);
      SSLLib     := conf.ReadInteger( 'Certificado','SSLLib' ,0) ;
      CryptLib   := conf.ReadInteger( 'Certificado','CryptLib' , 0) ;
      HttpLib    := conf.ReadInteger( 'Certificado','HttpLib' , 0) ;
      XmlSignLib := conf.ReadInteger( 'Certificado','XmlSignLib' , 0) ;
      CaminhoCert:= conf.ReadString( 'Certificado','Caminho' ,'') ;
      SenhaCert  := conf.ReadString( 'Certificado','Senha'   ,'') ;
      NumSerieCert:= conf.ReadString( 'Certificado','NumSerie','');
      NFE_Teste:= conf.ReadString( 'Certificado','NFE_Teste','N');
      vendedor_padrao := conf.ReadInteger( 'Outros','Vendedor',0);
      senhaLogin := conf.ReadString( 'Outros','SenhaLogin','');
      nomeLogado := conf.ReadString( 'Outros','NomeLogin','');
      tipo_buscaProd := conf.ReadString( 'Outros','BuscaProduto','NORMAL');
      tipo_CodBarra := conf.ReadString( 'Outros','TipoCodBarra','PRECO');
      tamanhoDescProd := conf.ReadInteger( 'Outros','TamanhoDescProd',400);
      tamanhoCodProd := conf.ReadInteger( 'Outros','TamanhoCodProd',140);
      usoSistema := conf.ReadString( 'Outros','TipoUso','ATS');
      usaComanda := conf.ReadInteger( 'Outros','UsaComanda',0);
      usaCurso := conf.ReadInteger( 'Outros','UsaCurso',0);
      NfceSat := conf.ReadString( 'Outros','NfceSat','NFCE');
      ccusto := conf.ReadString( 'Outros','CentroCusto','');
      modoDesenvolvedor := conf.ReadString( 'Outros','modoDesenvolvedor','N');
    finally
      conf.free;
    end;
  end;
  if FileExists(path_exe  + 'conf.ini') then
  begin
    conf := TIniFile.Create(path_exe + 'conf.ini');
    try
      vstr := conf.ReadString('DATABASE', 'Name', '');
      IBCon.DatabaseName := vstr;
      //ShowMessage('BD ' + vstr);
      vstr := conf.ReadString('DATABASE', 'HostName', '');
      path_python := conf.ReadString('PATH', 'PathPython', '');
      path_script := conf.ReadString('PATH', 'PathScript', '');
      path_xml := conf.ReadString('PATH', 'PathXML', path_exe);
      path_imp := conf.ReadString('PATH', 'PathIMP', 'imp.txt');
      IBCon.HostName := vstr;
      //ShowMessage('Hostname ' + vstr);
      snh:= conf.ReadString('DATABASE', 'Acesso', '');
      portaImp := conf.ReadString('IMPRESSORA', 'porta', '');
      ModeloImp := conf.ReadInteger('IMPRESSORA', 'Modelo', 0);
      CupomImp := conf.ReadString('IMPRESSORA', 'Cupom', 'Texto');
      espacoEntreLinhas := conf.ReadInteger('IMPRESSORA', 'EspacoEntreLinhas', 10);
      margemCodBarra := conf.ReadInteger('IMPRESSORA', 'MargemCodBarra', 50);
      tamanhoLinha := conf.ReadInteger('IMPRESSORA', 'TamanhoLinha', 36);
      imp_controle_porta := conf.ReadBool('IMPRESSORA', 'ControlaPorta', False);
      imp_Interval := conf.ReadInteger('IMPRESSORA', 'SendBytesInterval', 100);
      imp_vias := conf.ReadInteger('IMPRESSORA', 'NumeroVias', 1);
      imp_LinhasBuffer:= conf.ReadInteger('IMPRESSORA', 'LinhasBuffer', 10);
      imp_larguraBobina:= conf.ReadInteger('IMPRESSORA', 'LarguraBobina', 10);
      //snh:= EncodeStringBase64(snh); // Ver a senha Encryptada
      snh:= DecodeStringBase64(snh);
      IBCon.Password := snh;
      SSLLib     := conf.ReadInteger( 'Certificado','SSLLib' ,0) ;
      CryptLib   := conf.ReadInteger( 'Certificado','CryptLib' , 0) ;
      HttpLib    := conf.ReadInteger( 'Certificado','HttpLib' , 0) ;
      XmlSignLib := conf.ReadInteger( 'Certificado','XmlSignLib' , 0) ;
      CaminhoCert:= conf.ReadString( 'Certificado','Caminho' ,'') ;
      SenhaCert  := conf.ReadString( 'Certificado','Senha'   ,'') ;
      NumSerieCert:= conf.ReadString( 'Certificado','NumSerie','');
      NFE_Teste:= conf.ReadString( 'Certificado','NFE_Teste','N');
      vendedor_padrao := conf.ReadInteger( 'Outros','Vendedor',0);
      senhaLogin := conf.ReadString( 'Outros','SenhaLogin','');
      nomeLogado := conf.ReadString( 'Outros','NomeLogin','');
      tipo_buscaProd := conf.ReadString( 'Outros','BuscaProduto','NORMAL');
      tipo_CodBarra := conf.ReadString( 'Outros','TipoCodBarra','PRECO');
      tamanhoDescProd := conf.ReadInteger( 'Outros','TamanhoDescProd',400);
      tamanhoCodProd := conf.ReadInteger( 'Outros','TamanhoCodProd',140);
      usoSistema := conf.ReadString( 'Outros','TipoUso','ATS');
      usaComanda := conf.ReadInteger( 'Outros','UsaComanda',0);
      usaCurso := conf.ReadInteger( 'Outros','UsaCurso',0);
      NfceSat := conf.ReadString( 'Outros','NfceSat','NFCE');
      ccusto := conf.ReadString( 'Outros','CentroCusto','');
      modoDesenvolvedor := conf.ReadString( 'Outros','modoDesenvolvedor','N');
    finally
      conf.free;
    end;
  end;
  //path_exe := path_exe + 'dbxconnections.ini';
  {
  if FileExists(path_exe + 'dbxconnections.ini') then
  begin
    conf := TIniFile.Create(path_exe + 'dbxconnections.ini');
    try
      vstr := conf.ReadString('DATABASE', 'Name', '');
      IBCon.DatabaseName := vstr;
      vstr := conf.ReadString('DATABASE', 'HostName', '');
      IBCon.HostName := vstr;
      snh:= conf.ReadString('DATABASE', 'Password', '');
      IBCon.Password := snh;
      IBCon.UserName := conf.ReadString('DATABASE', 'User', '');;
    finally
      conf.free;
    end;
  end;
  }
  sTrans.Active:=True;
  IBCon.Connected:=True;
  sqParametro.Active:=True;
  usaCentroCusto := 'S';
  precoLivre := 'LIVRE';
  descontoLivre := 0;
  While not sqParametro.EOF do
  begin
    if (Trim(sqParametroPARAMETRO.AsString) = 'CENTROCUSTO') then
    begin
      if (ccusto = '') then
        ccusto := Trim(sqParametroDADOS.AsString);

      ccusto_padrao := Trim(sqParametroD1.AsString);
    end;
    if (Trim(sqParametroPARAMETRO.AsString) = 'SERIENFCe') then
    begin
      tk := Trim(sqParametroDADOS.AsString);
      id_tk := Trim(sqParametroD4.AsString);
    end;
    if (Trim(sqParametroPARAMETRO.AsString) = 'CONSUMIDOR') then
    begin
      try
        clientePadrao := StrToInt(sqParametroDADOS.AsString);
      Except
        ShowMessage('Parametro Consumidor campo DADOS precisa ser número');
      end;
    end;
    if (Trim(sqParametroPARAMETRO.AsString) = 'PDV_PERMISSAO') then
    begin
      try
        precoLivre := Trim(sqParametroDADOS.AsString);
        if (sqParametroD1.AsString <> '') then
          try
            descontoLivre := StrToFloat(sqParametroD1.AsString);
            if descontoLivre > 0 then
              descontoLivre := descontoLivre / 100;
          except
            ShowMessage('Parametro PDV_PERMISSAO campo D1 precisa ser número');
            descontoLivre := 0;
          end;
      Except
        ShowMessage('Parametro Consumidor campo DADOS precisa ser número');
      end;
    end;
    if (Trim(sqParametroPARAMETRO.AsString) = 'CAIXA_BANCO') then
    begin
      caixaBanco := sqParametroDADOS.AsString;
      busca_sql('SELECT CODIGO FROM PLANO WHERE CONTAPAI = ' +
        QuotedStr(caixaBanco) + ' AND CONSOLIDA = ' + QuotedStr('S'));
      if not sqBusca.IsEmpty then
      begin
        contaCaixa := sqBusca.FieldByName('CODIGO').AsInteger;
      end;
    end;
    sqParametro.Next;
  end;
  versao_sistema := ApplicationName;
  if (ApplicationName = 'ATS-NFe Nota Fiscal Eletrônica') then
  begin
    busca_sql('SELECT r.VERSAO FROM ATUALIZA r WHERE r.CODATUALIZA = 5003');
    if (sqBusca.IsEmpty) then
    begin
      executaSql('INSERT INTO ATUALIZA (CODATUALIZA, SCRIPT, VERSAO) VALUES ('+
        '5003, ' + QuotedStr('NFe') + ', ' + QuotedStr('1.0') + ')');
      versao_sistema := '1.0';
      atualiza_bd('NFe');
    end
    else begin
      versao_sistema := Trim(sqBusca.FieldByName('VERSAO').AsString);
      atualiza_bd('NFe');
    end;
  end;
  if (ApplicationName = 'ATS Conhecimento Transportes (CTe)') then
  begin
    busca_sql('SELECT r.VERSAO FROM ATUALIZA r WHERE r.CODATUALIZA = 5001');
    if (sqBusca.IsEmpty) then
    begin
      executaSql('INSERT INTO ATUALIZA (CODATUALIZA, SCRIPT, VERSAO) VALUES ('+
        '5001, ' + QuotedStr('CTe') + ', ' + QuotedStr('1.0') + ')');
      versao_sistema := '1.0';
      atualiza_bd('CTe');
    end
    else begin
      versao_sistema := Trim(sqBusca.FieldByName('VERSAO').AsString);
      atualiza_bd('CTe');
    end;
  end;
  if (ApplicationName = 'ATS-PDV') then
  begin
    busca_sql('SELECT r.VERSAO FROM ATUALIZA r WHERE r.CODATUALIZA = 5002');
    if (sqBusca.IsEmpty) then
      versao_sistema := '1.1'
    else
      versao_sistema := Trim(sqBusca.FieldByName('VERSAO').AsString);
    atualiza_bd('PDV');
  end;
  if (ApplicationName = 'ATS-Admin') then
  begin
     busca_sql('SELECT r.VERSAO FROM ATUALIZA r WHERE r.CODATUALIZA = 5000');
     versao_sistema := sqBusca.FieldByName('VERSAO').AsString;
     atualiza_bd('ATS');
  end;
  //if (versao_sistema <> '1.2') then
  //begin

  //end;
end;

procedure TdmPdv.IbConAfterDisconnect(Sender: TObject);
begin

end;

procedure TdmPdv.IbConBeforeConnect(Sender: TObject);
begin

end;

procedure TdmPdv.atualiza_bd(sistema: String);
begin
  if (sistema = 'NFe') then
  begin
    if (versao_sistema = '1.0') then
    begin
      versao_sistema := '1.1';
      Try
        IbCon.ExecuteDirect('CREATE TABLE NOTAFISCAL_MANIFESTO(CHAVE VARCHAR(50)' +
           ' NOT NULL PRIMARY KEY, CODEMPRESA INTEGER, CNPJ VARCHAR(18)' +
           ' , NOME VARCHAR(80), IE VARCHAR(20), EMISSAO TIMESTAMP, TIPO CHAR(1)' +
           ' , VALOR DOUBLE PRECISION, CONFIRMACAO INTEGER, NSU VARCHAR(10)' +
           ' , DATAEVENTO TIMESTAMP, PROTOCOLO VARCHAR(20))');
        IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.1') +
          ' WHERE CODATUALIZA = 5003');
        sTrans.Commit;
      except
      end;
    end;
    if (versao_sistema = '1.1') then
    begin
      versao_sistema := '1.2';
      campo_novo('USUARIO', 'SENHA', 'VARCHAR(50)');
      campo_novo('USUARIO', 'CODBARRA', 'VARCHAR(13)');
      campo_novo('PRODUTOS', 'PRECOATACADO', 'DOUBLE PRECISION');
      campo_novo('PRODUTOS', 'QTDEATACADO', 'DOUBLE PRECISION');
      campo_novo('MOVIMENTO', 'DATA_FECHOU', 'TIMESTAMP');
      IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.2') +
        ' WHERE CODATUALIZA = 5003');
      sTrans.Commit;
    end;
    if (versao_sistema = '1.2') then
    begin
      versao_sistema := '1.3';
      campo_novo('EMPRESA', 'CERTIFICADO', 'VARCHAR( 50 )');
      campo_novo('EMPRESA', 'GIAF1', 'CHAR( 1 )');
      campo_novo('EMPRESA', 'GIAF3', 'CHAR( 1 )');
      campo_novo('EMPRESA', 'GIAF4', 'CHAR( 1 )');
      IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.3') +
        ' WHERE CODATUALIZA = 5003');
      sTrans.Commit;
    end;
  end;
  if (sistema = 'PDV') then
  begin
    if (versao_sistema = '1.1') then
    begin
      Try
        IbCon.ExecuteDirect('ALTER TABLE FORMA_ENTRADA DROP CONSTRAINT INTEG_448');
      Except
      end;
      IbCon.ExecuteDirect('INSERT INTO ATUALIZA (CODATUALIZA, SCRIPT, VERSAO' +
        ') VALUES (5002, ' + QuotedStr('PDV') + ', '  + QuotedStr('1.2') + ')');

      campo_novo('FORMA_ENTRADA', 'STATE', 'SMALLINT');
      campo_novo('FORMA_ENTRADA', 'TROCO', 'double precision');
      campo_novo('USUARIO', 'SENHA', 'VARCHAR(50)');
      campo_novo('USUARIO', 'CODBARRA', 'VARCHAR(13)');
      campo_novo('PRODUTOS', 'PRECOATACADO', 'DOUBLE PRECISION');
      campo_novo('PRODUTOS', 'QTDEATACADO', 'DOUBLE PRECISION');
      campo_novo('FORMA_ENTRADA', 'CODFORMA', 'INTEGER NOT NULL');
      campo_novo('FORMA_ENTRADA', 'PRIMARY KEY', '(CODFORMA)');
      Try
        IbCon.ExecuteDirect('CREATE SEQUENCE GEN_FORMA');
      Except
      end;
      campo_novo('MOVIMENTO', 'DESCONTO', 'DOUBLE PRECISION');
      campo_novo('venda', 'XMLNFE', 'BLOB SUB_TYPE 0');
      campo_novo('venda', 'NOMEXML', 'VARCHAR( 60 )');
      campo_novo('venda', 'PROTOCOLOENV', 'VARCHAR( 20 )');
      campo_novo('venda', 'NUMRECIBO', 'VARCHAR( 20 )');
      campo_novo('FORMA_ENTRADA', 'DESCONTO', 'double precision');
      sTrans.Commit;
      versao_sistema := '1.2';
    end;
    if (versao_sistema = '1.2') then
    begin
      campo_novo('MOVIMENTO', 'DATA_FECHOU', 'TIMESTAMP');
      IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.3') +
      ' WHERE CODATUALIZA = 5002');
      sTrans.Commit;
    end;
  end;
  if (sistema = 'CTe') then
  begin
    if (versao_sistema = '1.0') then
    begin
      campo_novo('CTE', 'UFPER', 'VARCHAR( 2 )');
      versao_sistema := '1.3';
    end;

    if (versao_sistema = '1.3') then
    begin
      Try
        IbCon.ExecuteDirect('ALTER TABLE CTE  ' +
          ' ADD INFADFISCO VARCHAR( 500 ), ADD VPIS DOUBLE PRECISION ' +
          ', ADD VCOFINS DOUBLE PRECISION, ADD VIR DOUBLE PRECISION ' +
          ', ADD VINSS DOUBLE PRECISION, ADD VCSLL DOUBLE PRECISION ' +
          ', ADD XDESCSERV VARCHAR( 30 ), ADD QCARGA DOUBLE PRECISION ' +
          ', ADD TPSERV INTEGER, ADD TAF VARCHAR( 12 ) ' +
          ', ADD NROREGESTADUAL VARCHAR( 25 ), ADD VEICRENAVAM VARCHAR( 11 ) ' +
          ', ADD VEICPLACA VARCHAR( 7 ), ADD VEIUF VARCHAR( 2 ) ' +
          ', ADD OBSCONT VARCHAR( 400 ), ADD TCPF VARCHAR( 11 ) ' +
          ', ADD TCNPJ VARCHAR( 14 ) , ADD TTAF VARCHAR( 12 ) ' +
          ', ADD TNROREGESTADUAL VARCHAR( 25 ), ADD TXNOME VARCHAR( 60 ) ' +
          ', ADD TIE VARCHAR( 14 ), ADD TUF VARCHAR( 2 ) ' +
          ', ADD TTPPROP VARCHAR( 14 ), ADD TUFT VARCHAR( 2 ) ' +
          ', ADD OBSFISCO  VARCHAR( 300 )');
          IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.4') +
          ' WHERE CODATUALIZA = 5001');
          sTrans.Commit;
          versao_sistema := '1.4';
      Except
        on dmPdv: EDatabaseError do
        begin
          MessageDlg('Error','Erro na atualização banco de dados : ' +
            dmPdv.Message,mtError,[mbOK],0);
          sTrans.Rollback;
        end;
      end;
    end;
    if (versao_sistema = '1.4') then
    begin
      campo_novo('CTE', 'ANT_CNPJ', 'VARCHAR(20)');
      campo_novo('CTE', 'ANT_IE',  'VARCHAR(20)');
      campo_novo('CTE', 'ANT_UF', 'VARCHAR(2)');
      campo_novo('CTE', 'ANT_NOME', 'VARCHAR(60)');
      campo_novo('CTE', 'ANT_CHCTE', 'VARCHAR(60)');
      IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.5') +
        ' WHERE CODATUALIZA = 5001');
      sTrans.Commit;
      versao_sistema := '1.5';
    end;
    if (versao_sistema = '1.5') then
    begin
      campo_novo('CTE', 'IN_IMPOSTOS', 'INTEGER');
      IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.6') +
        ' WHERE CODATUALIZA = 5001');
      sTrans.Commit;
      versao_sistema := '1.6';
    end;
    if (versao_sistema = '1.6') then
    begin
      campo_novo('CTE', 'NPROTCANCEL', 'VARCHAR(30)');
      IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.7') +
        ' WHERE CODATUALIZA = 5001');
      sTrans.Commit;
      versao_sistema := '1.7';
    end;
    if (versao_sistema = '1.7') then
    begin
      campo_novo('CTE', 'VALPREDBC', 'DOUBLE PRECISION');
      campo_novo('CTE', 'VALVBC', 'DOUBLE PRECISION');
      campo_novo('CTE', 'VALPICMS', 'DOUBLE PRECISION');
      campo_novo('CTE', 'VALVICMS', 'DOUBLE PRECISION');
      campo_novo('CTE', 'VALVCRED', 'DOUBLE PRECISION');
      campo_novo('CTE', 'STATUS_CTE', 'VARCHAR(30)');
      IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.8') +
        ' WHERE CODATUALIZA = 5001');
      sTrans.Commit;
      versao_sistema := '1.8';
    end;

  end;  // fim atualiza CTe
end;

procedure TdmPdv.campo_novo(tabela, campo, tipo: String);
begin
  if (existe_campo(tabela, campo) = False) then
  begin
    Try
      tabela := 'ALTER TABLE ' + tabela + ' ADD ' + campo + ' ' + tipo;
      IbCon.ExecuteDirect(tabela);
    Except
    end;
  end;
end;

function TdmPdv.existe_campo(tabela, campo: String): Boolean;
begin
  busca_sql('SELECT * FROM rdb$relation_fields ' +
    ' WHERE rdb$relation_name = ' + QuotedStr(tabela) +
    '   AND rdb$relation_fields.rdb$field_name = ' + QuotedStr(campo));
  if (sqBusca.IsEmpty) then
    result := False
  else
    result := True;
end;

procedure TdmPdv.gravaLog(DataLog: TDateTime; usuario: String;
  tipoMovimento: String; pc: String; valorAnt: String; valorPos: String;
  campoChave: String; acao: String);
var logStr: String;
begin
  try
    logStr := 'INSERT INTO LOGS (TABELA, DATA, USUARIO, MICRO, HORA, ' +
      'CAMPO1, CAMPO2, CAMPO3, CAMPO4)  VALUES (';
    logStr := logStr + QuotedStr(tipoMovimento);
    logStr := logStr + ', ' + QuotedStr(formatdatetime('mm/dd/yy', DataLog));
    logStr := logStr + ', ' + QuotedStr(usuario);
    logStr := logStr + ', ' + QuotedStr(pc);
    logStr := logStr + ', ' + QuotedStr(formatdatetime('hh:MM', DataLog));
    logStr := logStr + ', ' + QuotedStr(acao);
    if (valorAnt <> '') then
        logStr := logStr + ', ' + QuotedStr('ANT:' + copy(valorAnt,0,45))
    else
      logStr := logStr + ', ' + QuotedStr('');
    logStr := logStr + ', ' + QuotedStr('NOVO:' + copy(valorPos,0,45));
    logStr := logStr + ', ' + QuotedStr(campoChave);
    logStr := logStr + ')';
    IbCon.ExecuteDirect(logStr);
  except
    on dmPdv: EDatabaseError do
    begin
      MessageDlg('Error','Erro na conexao com a base de dados, erro : ' +
        dmPdv.Message,mtError,[mbOK],0);
    end;
  end;
end;

function TdmPdv.busca_generator(generator: String): integer;
begin
  if (dmPdv.sqGenerator.Active) then
    dmPdv.sqGenerator.Close;
  dmPdv.sqGenerator.SQL.Clear;
  dmPdv.sqGenerator.SQL.Text := 'SELECT CAST(GEN_ID(' + generator +
     ', 1) AS INTEGER) AS CODIGO FROM RDB$DATABASE';
  dmPdv.sqGenerator.Open;
  Result := dmPdv.sqGenerator.Fields[0].AsInteger;
  dmPdv.sqGenerator.Close
end;

function TdmPdv.busca_serie(Serie: String): integer;
var num_cp: Integer;
begin
  dmPdv.sqUpdate.Close;
  dmPdv.sqUpdate.SQL.Clear;
  dmPdv.sqUpdate.SQL.Text := 'SELECT * FROM SERIES WHERE SERIE = ' +
    QuotedStr(Serie);
  dmPdv.sqUpdate.Open;
  num_cp := dmPdv.sqUpdate.FieldByName('ULTIMO_NUMERO').AsInteger+1;
  dmPdv.sqUpdate.Close;
  dmPdv.sqUpdate.UpdateSQL.Clear;
  dmPdv.sqUpdate.UpdateSQL.Text := 'UPDATE SERIES SET ULTIMO_NUMERO = ' +
    IntToStr(num_cp) + ' WHERE SERIE = ' +
    QuotedStr(Serie);
  dmPdv.sqUpdate.Open;
  dmPdv.sqUpdate.Edit;
  dmPdv.sqUpdate.Post;
  dmPdv.sqUpdate.ApplyUpdates;
  Result := num_cp;

end;

procedure TdmPdv.busca_sql(sql_txt: String);
begin
  if sqBusca.Active then
    sqBusca.Close;
  sqBusca.SQL.Clear;
  sqBusca.SQL.Add(sql_txt);
  sqBusca.Open;
end;

procedure TdmPdv.executa_integracao;
var k: Integer;
  postJson: TJSONObject;
  //dadosJson: TJSONObject;
  dadosJson: TJsonNode;
  responseData: String;
  ver: string;
  arquivo : string;
  listaArquivos : TStringList;
  //sqMovIntegra: TSQLQuery;
  //IntegracaoOdoo : TIntegracaoOdoo;
begin
  // Rotina sera executada em um Timer ?!!!!!

  // GERANDO o JSON em ARQUIVO aqui so vai enviar


  {
  sqMovIntegra := TSQLQuery.Create;
  sqMovIntegra.DataBase := dmPdv.IbCon;
  comDados := 'N';
  postJson := TJSONObject.Create;
  dadosJson := TJSONObject.Create;
  ver := 'SELECT FIRST 10 m.CODMOVIMENTO, m.DATAMOVIMENTO, ' +
               'm.CODCLIENTE, m.STATUS, m.CODUSUARIO, m.CODVENDEDOR, ' +
               'm.CODALMOXARIFADO, DATEADD(3 hour to m.DATA_SISTEMA) ' +
               '  FROM MOVIMENTO m ' +
               ' WHERE m.STATUS = 1 ' +
               '  ORDER BY m.CODMOVIMENTO DESC';
  sqMovIntegra.SQL.Text := ver;
  dmPdv.IbCon.Connected := True;
  sqMovIntegra.Transaction := dmPdv.sTrans;
  sqMovIntegra.Open;
  // inclusao
  postJson.Add('title', 'Movimento');
  postJson.Add('body', 'Insert');
  postJson.Add('movimento', dadosJson);
  postJson.Add('userId', 1);
  While not sqMovIntegra.EOF do
  begin
    for i:=0 to sqMovIntegra.FieldDefs.Count-1 do
    begin
      comDados := 'S';
      ver := sqMovIntegra.FieldDefs.Items[i].Name;
      ver := sqMovIntegra.Fields[i].Value;
      dadosJson.Add(sqMovIntegra.FieldDefs.Items[i].Name, sqMovIntegra.Fields[i].Value);
    end;
    sqMovIntegra.Next;
  end;
  sqMovIntegra.Free;
  gerarjson;}

  // VER SE EXISTE ARQUIVO
  listaArquivos := TStringList.Create;
  try
    FindAllFiles(listaArquivos, 'C:\home\integra\', '*.txt', true);
    for k:=0 to Pred(listaArquivos.Count) do
    begin
      arquivo := listaArquivos[k];
      // SE EXISTE ENVIA
      postJson := TJSONObject.Create;
      dadosJson := TJsonNode.Create;
      postJson.Add('title', 'Enviando Movimento');
      postJson.Add('body', 'Enviando Movimento');
      dadosJson.LoadFromFile(arquivo);
      //dadosJson.Add('nometabela', 'Movimento');

      postJson.Add('tab_venda', dadosJson.ToString);
      postJson.Add('userId', 1);
      With TFPHttpClient.Create(Nil) do
        try
          AddHeader('Content-Type', 'application/json');
          RequestBody := TStringStream.Create(postJson.AsJSON);
          //responseData := Post('http://vitton.atsti.com.br:8905');
          responseData := Post('http://192.168.6.100:8905');
        finally
         Free;
        end;
    end;
  finally
    listaArquivos.Free;
  end;


  //IntegracaoOdoo := TIntegracaoOdoo.Create(True);
  //IntegracaoOdoo.FreeOnTerminate := True;
  //IntegracaoOdoo.Resume;
end;

function TdmPdv.executaSql(strSql: String): Boolean;
begin
  try
    ibcon.ExecuteDirect(strSql);
    Result := True;
  except
    on dmPdv: EDatabaseError do
    begin
      MessageDlg('Error','Erro na conexao com a base de dados, erro : ' +
        dmPdv.Message,mtError,[mbOK],0);
      Result := False;
    end;
  end;
end;

procedure TdmPdv.executaDSQL(strDSQL: String);
begin
  try
    ibcon.ExecuteDirect(strDSql);
    sTrans.Commit;
  except
    sTrans.Rollback;
  end;
end;

end.
