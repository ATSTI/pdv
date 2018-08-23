unit uDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, sysutils, IBConnection, sqldb, db, IniFiles;

type

  { Tdm }

  Tdm = class(TDataModule)
    IBCon: TIBConnection;
    sqCompraAPAGAR: TFloatField;
    sqCompraBANCO: TSmallintField;
    sqCompraCAIXA: TSmallintField;
    sqCompraCFOP: TStringField;
    sqCompraCHAVENF: TStringField;
    sqCompraCODCCUSTO: TSmallintField;
    sqCompraCODCOMPRA: TLongintField;
    sqCompraCODCOMPRADOR: TSmallintField;
    sqCompraCODFORNECEDOR: TLongintField;
    sqCompraCODMOVIMENTO: TLongintField;
    sqCompraCODORIGEM: TLongintField;
    sqCompraCODUSUARIO: TSmallintField;
    sqCompraDATACOMPRA: TDateField;
    sqCompraDATASISTEMA: TDateField;
    sqCompraDATAVENCIMENTO: TDateField;
    sqCompraDESCONTO: TFloatField;
    sqCompraDIGITOVALIDACAO: TStringField;
    sqCompraENTRADA: TFloatField;
    sqCompraFORMAPAGAMENTO: TStringField;
    sqCompraICMS_BASE_ST: TFloatField;
    sqCompraICMS_ST: TFloatField;
    sqCompraINDPAG: TLongintField;
    sqCompraMODELO: TStringField;
    sqCompraMULTA_JUROS: TFloatField;
    sqCompraNOTAFISCAL: TLongintField;
    sqCompraNUMEROBORDERO: TLongintField;
    sqCompraN_BOLETO: TStringField;
    sqCompraN_DOCUMENTO: TStringField;
    sqCompraN_PARCELA: TSmallintField;
    sqCompraOPERACAO: TStringField;
    sqCompraOUTRAS_DESP: TFloatField;
    sqCompraPRAZO: TStringField;
    sqCompraSERIE: TStringField;
    sqCompraSTATUS: TSmallintField;
    sqCompraSTATUS1: TStringField;
    sqCompraVALOR: TFloatField;
    sqCompraVALOR_FRETE: TFloatField;
    sqCompraVALOR_ICMS: TFloatField;
    sqCompraVALOR_IPI: TFloatField;
    sqCompraVALOR_PAGAR: TFloatField;
    sqCompraVALOR_SEGURO: TFloatField;
    sqGen: TSQLQuery;
    sqCompra: TSQLQuery;
    sqLote: TSQLQuery;
    sqLoteCCUSTO: TLongintField;
    sqLoteCODLOTE: TLongintField;
    sqLoteCODPRO: TStringField;
    sqLoteCODPRODUTO: TLongintField;
    sqLoteDATAFABRICACAO: TDateField;
    sqLoteDATAVENCIMENTO: TDateField;
    sqLoteESTOQUE: TFloatField;
    sqLoteLOTE: TStringField;
    sqLoteNOTAFISCAL: TStringField;
    sqLotePRECO: TFloatField;
    sqLotePRODUTO: TStringField;
    sqLoteSERIEFIM: TLongintField;
    sqLoteSERIEINI: TLongintField;
    sqExec: TSQLQuery;
    sqVenda: TSQLQuery;
    sqSeries: TSQLQuery;
    sqMovCODALMOXARIFADO: TLongintField;
    sqMovCODCLIENTE: TLongintField;
    sqMovCODCOTACAO: TLongintField;
    sqMovCODFORNECEDOR: TLongintField;
    sqMovCODMOVIMENTO: TLongintField;
    sqMovCODMOVRATEIO: TLongintField;
    sqMovCODNATUREZA: TSmallintField;
    sqMovCODORIGEM: TLongintField;
    sqMovCODPEDIDO: TLongintField;
    sqMovCODTRANSP: TLongintField;
    sqMovCODUSUARIO: TSmallintField;
    sqMovCODVENDEDOR: TSmallintField;
    sqMovCOD_VEICULO: TLongintField;
    sqMovCONFERIDO: TStringField;
    sqMovCONTROLE: TStringField;
    sqMovDATAMOVIMENTO: TDateField;
    sqMovDATA_ENTREGA: TDateField;
    sqMovDATA_SISTEMA: TDateTimeField;
    sqMovDESCONTO: TFloatField;
    sqMovDetACRESCIMO: TFloatField;
    sqMovDetALIQ_CUPOM: TStringField;
    sqMovDetATENDENTE: TLongintField;
    sqMovDetBAIXA: TStringField;
    sqMovDetBCFRETE: TFloatField;
    sqMovDetBCII: TFloatField;
    sqMovDetBCSTFRETE: TFloatField;
    sqMovDetCEST: TStringField;
    sqMovDetCFOP: TStringField;
    sqMovDetCODALMOXARIFADO: TSmallintField;
    sqMovDetCODAUTORIZACAO: TLongintField;
    sqMovDetCODDETALHE: TLongintField;
    sqMovDetCODIGO: TLongintField;
    sqMovDetCODIGO1: TLongintField;
    sqMovDetCODMOVIMENTO: TLongintField;
    sqMovDetCODMOVRATEIO: TLongintField;
    sqMovDetCODPRODUTO: TLongintField;
    sqMovDetCODSOLICITACAO: TLongintField;
    sqMovDetCOD_COMISSAO: TLongintField;
    sqMovDetCOD_FUNCIONARIO: TLongintField;
    sqMovDetCOLABORADOR: TLongintField;
    sqMovDetCONTROLE: TSmallintField;
    sqMovDetCORTESIA: TStringField;
    sqMovDetCSOSN: TStringField;
    sqMovDetCST: TStringField;
    sqMovDetCSTCOFINS: TStringField;
    sqMovDetCSTIPI: TStringField;
    sqMovDetCSTPIS: TStringField;
    sqMovDetCST_IPI_CENQ: TStringField;
    sqMovDetDESCONTO_BC: TStringField;
    sqMovDetDESCPRODUTO: TStringField;
    sqMovDetDTAFAB: TDateField;
    sqMovDetDTAVCTO: TDateField;
    sqMovDetFORMARECEBIMENTO: TStringField;
    sqMovDetFRETE: TFloatField;
    sqMovDetFRETE_BC: TStringField;
    sqMovDetICMS: TFloatField;
    sqMovDetICMSFRETE: TFloatField;
    sqMovDetICMS_PST: TFloatField;
    sqMovDetICMS_SUBST: TFloatField;
    sqMovDetICMS_SUBSTD: TFloatField;
    sqMovDetII: TFloatField;
    sqMovDetIMPRESSO: TStringField;
    sqMovDetLOTE: TStringField;
    sqMovDetNCM: TStringField;
    sqMovDetNITEMPED: TLongintField;
    sqMovDetNOTAFISCAL: TStringField;
    sqMovDetOBS: TStringField;
    sqMovDetORIGEM: TStringField;
    sqMovDetPAGO: TStringField;
    sqMovDetPAGOU: TStringField;
    sqMovDetPAGOUCOMISSAO: TStringField;
    sqMovDetPCOFINS: TFloatField;
    sqMovDetPEDIDO: TStringField;
    sqMovDetPERCIPIDEVOL: TFloatField;
    sqMovDetPERIODOFIM: TDateTimeField;
    sqMovDetPERIODOINI: TDateTimeField;
    sqMovDetPFCPUFDEST: TFloatField;
    sqMovDetPICMSINTER: TFloatField;
    sqMovDetPICMSINTERPART: TFloatField;
    sqMovDetPICMSUFDEST: TFloatField;
    sqMovDetPIPI: TFloatField;
    sqMovDetPORCENTAGENDESC: TFloatField;
    sqMovDetPPIS: TFloatField;
    sqMovDetPRECO: TFloatField;
    sqMovDetPRECOCUSTO: TFloatField;
    sqMovDetPRECOULTIMACOMPRA: TFloatField;
    sqMovDetP_FCP: TFloatField;
    sqMovDetP_FCPST: TFloatField;
    sqMovDetP_FCPSTRET: TFloatField;
    sqMovDetQTDEESTOQUE: TFloatField;
    sqMovDetQTDE_ALT: TFloatField;
    sqMovDetQUANTIDADE: TFloatField;
    sqMovDetRATEIO: TFloatField;
    sqMovDetRECEBIDO: TFloatField;
    sqMovDetSTATUS: TStringField;
    sqMovDetSTFRETE: TStringField;
    sqMovDetSUITE: TStringField;
    sqMovDetUN: TStringField;
    sqMovDetUN_CONV: TFloatField;
    sqMovDetVALORIPIDEVOL: TFloatField;
    sqMovDetVALORRATEIO: TFloatField;
    sqMovDetVALOR_COFINS: TFloatField;
    sqMovDetVALOR_DESCONTO: TFloatField;
    sqMovDetVALOR_ICMS: TFloatField;
    sqMovDetVALOR_OUTROS: TFloatField;
    sqMovDetVALOR_PIS: TFloatField;
    sqMovDetVALOR_SEGURO: TFloatField;
    sqMovDetVALTOTAL: TFloatField;
    sqMovDetVBCSTDEST: TFloatField;
    sqMovDetVBCSTRET: TFloatField;
    sqMovDetVBCUFDEST: TFloatField;
    sqMovDetVBFCPUFDEST: TFloatField;
    sqMovDetVFCPUFDEST: TFloatField;
    sqMovDetVICMSSTDEST: TFloatField;
    sqMovDetVICMSSTRET: TFloatField;
    sqMovDetVICMSUFDEST: TFloatField;
    sqMovDetVICMSUFREMET: TFloatField;
    sqMovDetVIPI: TFloatField;
    sqMovDetVLRBC_COFINS: TFloatField;
    sqMovDetVLRBC_IPI: TFloatField;
    sqMovDetVLRBC_PIS: TFloatField;
    sqMovDetVLRESTOQUE: TFloatField;
    sqMovDetVLRTOT_TRIB: TFloatField;
    sqMovDetVLR_BASE: TFloatField;
    sqMovDetVLR_BASEICMS: TFloatField;
    sqMovDetV_B_FCP: TFloatField;
    sqMovDetV_B_FCPST: TFloatField;
    sqMovDetV_B_FCPSTRET: TFloatField;
    sqMovDetV_FCP: TFloatField;
    sqMovDetV_FCPST: TFloatField;
    sqMovDetV_FCPSTRET: TFloatField;
    sqMovENTREGA: TStringField;
    sqMovFORMA_PAG: TStringField;
    sqMovHIST_MOV: TStringField;
    sqMovKM: TStringField;
    sqMovNFCOBRANCA: TLongintField;
    sqMovNFE: TStringField;
    sqMovNFREVENDA: TLongintField;
    sqMovOBS: TStringField;
    sqMovORDEMATEND: TLongintField;
    sqMovPRAZO_ENT: TLongintField;
    sqMovPRAZO_PAGAMENTO: TStringField;
    sqMovQTD: TLongintField;
    sqMovRATEIO: TFloatField;
    sqMovSTATUS: TSmallintField;
    sqMovTIPO_PEDIDO: TStringField;
    sqMovTOTALMOVIMENTO: TFloatField;
    sqMovTPFRETE: TStringField;
    sqMovUSER_APROVA: TStringField;
    sqMovUSUARIOLOGADO: TStringField;
    sqMovVALORRATEIO: TFloatField;
    sqMovVALOR_FRETE: TFloatField;
    sqMovVAL_PROP: TDateField;
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
    sqPlano: TSQLQuery;
    sqPlanoCODEMPRESA: TLongintField;
    sqPlanoCODIGO: TLongintField;
    sqPlanoCODREDUZIDO: TStringField;
    sqPlanoCONSOLIDA: TStringField;
    sqPlanoCONTA: TStringField;
    sqPlanoCONTAPAI: TStringField;
    sqPlanoDESCRICAO: TStringField;
    sqPlanoNOME: TStringField;
    sqPlanoRATEIO: TStringField;
    sqPlanoREDUZRECEITA: TStringField;
    sqPlanoTIPOLANC: TStringField;
    sqProc: TSQLQuery;
    sqMovDet: TSQLQuery;
    sqMov: TSQLQuery;
    sqProduto: TSQLQuery;
    sqProdutoBASE_ICMS: TFloatField;
    sqProdutoCATEGORIA: TStringField;
    sqProdutoCEST: TStringField;
    sqProdutoCLASSIFIC_FISCAL: TStringField;
    sqProdutoCODALMOXARIFADO: TLongintField;
    sqProdutoCODFORN: TStringField;
    sqProdutoCODPRO: TStringField;
    sqProdutoCODPRODUTO: TLongintField;
    sqProdutoCOD_BARRA: TStringField;
    sqProdutoCOD_COMISSAO: TLongintField;
    sqProdutoCONTA_DESPESA: TStringField;
    sqProdutoCONTA_ESTOQUE: TStringField;
    sqProdutoCONTA_RECEITA: TStringField;
    sqProdutoCPRODANP: TStringField;
    sqProdutoCST: TStringField;
    sqProdutoDATACADASTRO: TDateTimeField;
    sqProdutoDATAGRAV: TDateField;
    sqProdutoDATAULTIMACOMPRA: TDateField;
    sqProdutoEMBALAGEM: TStringField;
    sqProdutoESTOQUEATUAL: TFloatField;
    sqProdutoESTOQUEMAXIMO: TFloatField;
    sqProdutoESTOQUEMINIMO: TFloatField;
    sqProdutoESTOQUEREPOSICAO: TFloatField;
    sqProdutoFAMILIA: TStringField;
    sqProdutoFOTOPRODUTO: TStringField;
    sqProdutoGERADESCONTO: TStringField;
    sqProdutoICMS: TFloatField;
    sqProdutoIMPRESSORA_1: TStringField;
    sqProdutoIMPRESSORA_2: TStringField;
    sqProdutoIMPRESSORA_3: TStringField;
    sqProdutoIMPRIMIR: TStringField;
    sqProdutoIPI: TFloatField;
    sqProdutoLOCALIZACAO: TStringField;
    sqProdutoLOTES: TStringField;
    sqProdutoMARCA: TStringField;
    sqProdutoMARGEM: TFloatField;
    sqProdutoMARGEM_LUCRO: TFloatField;
    sqProdutoNCM: TStringField;
    sqProdutoOBS: TStringField;
    sqProdutoORIGEM: TLongintField;
    sqProdutoPESO_LIQ: TFloatField;
    sqProdutoPESO_QTDE: TFloatField;
    sqProdutoPMIXGN: TFloatField;
    sqProdutoPRECOMEDIO: TBCDField;
    sqProdutoPRODUTO: TStringField;
    sqProdutoPRO_COD: TStringField;
    sqProdutoQTD: TLongintField;
    sqProdutoQTDE_PCT: TFloatField;
    sqProdutoRATEIO: TStringField;
    sqProdutoTAM_LOTE: TLongintField;
    sqProdutoTIPO: TStringField;
    sqProdutoTIPOPRECOVENDA: TStringField;
    sqProdutoUNIDADEMEDIDA: TStringField;
    sqProdutoUSA: TStringField;
    sqProdutoVALIQPROD: TFloatField;
    sqProdutoVALORCOMISSAO: TFloatField;
    sqProdutoVALORMINIMO: TFloatField;
    sqProdutoVALORUNITARIOANTERIOR: TFloatField;
    sqProdutoVALORUNITARIOATUAL: TFloatField;
    sqProdutoVALOR_PRAZO: TFloatField;
    sqSeriesCODSERIE: TStringField;
    sqSeriesICMS_DESTACADO: TFloatField;
    sqSeriesMODELO: TStringField;
    sqSeriesNOTAFISCAL: TSmallintField;
    sqSeriesSERIE: TStringField;
    sqSeriesULTIMO_NUMERO: TLongintField;
    sqVendaAPAGAR: TFloatField;
    sqVendaBANCO: TSmallintField;
    sqVendaCAIXA: TSmallintField;
    sqVendaCAIXINHA: TFloatField;
    sqVendaCODCCUSTO: TSmallintField;
    sqVendaCODCLIENTE: TLongintField;
    sqVendaCODMOVIMENTO: TLongintField;
    sqVendaCODORIGEM: TLongintField;
    sqVendaCODUSUARIO: TSmallintField;
    sqVendaCODVENDA: TLongintField;
    sqVendaCODVENDEDOR: TSmallintField;
    sqVendaCOMISSAO: TFloatField;
    sqVendaCONTROLE: TStringField;
    sqVendaDATASISTEMA: TDateField;
    sqVendaDATAVENCIMENTO: TDateField;
    sqVendaDATAVENDA: TDateField;
    sqVendaDESCONTO: TFloatField;
    sqVendaENTRADA: TFloatField;
    sqVendaFORMARECEBIMENTO: TStringField;
    sqVendaMULTA_JUROS: TFloatField;
    sqVendaNOTAFISCAL: TLongintField;
    sqVendaNUMEROBORDERO: TLongintField;
    sqVendaN_BOLETO: TStringField;
    sqVendaN_DOCUMENTO: TStringField;
    sqVendaN_PARCELA: TSmallintField;
    sqVendaOBS: TStringField;
    sqVendaOPERACAO: TStringField;
    sqVendaOUTRAS_DESP: TFloatField;
    sqVendaPORCENTAGENDESC: TFloatField;
    sqVendaPRAZO: TStringField;
    sqVendaRATEIO: TFloatField;
    sqVendaSERIE: TStringField;
    sqVendaSTATUS: TSmallintField;
    sqVendaSTATUS1: TStringField;
    sqVendaTROCO: TFloatField;
    sqVendaVALOR: TFloatField;
    sqVendaVALOR_FRETE: TFloatField;
    sqVendaVALOR_ICMS: TFloatField;
    sqVendaVALOR_IPI: TFloatField;
    sqVendaVALOR_PAGAR: TFloatField;
    sqVendaVALOR_SEGURO: TFloatField;
    sqVendaVALOR_ST: TFloatField;
    sTrans: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    versao_sistema: String;
    ccusto: String;
    ccusto_padrao: String;
    function atualiza_serie(serie: String): Integer;
    procedure atualizaBD(tabela: String; tipo: String; campo: String; formato: String; versao:String);
  end;

var
  dm: Tdm;
  path_exe: String;
implementation

{$R *.lfm}

{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
var
  conf: TIniFile;

begin
  //extrac
  path_exe := ExtractFilePath(ParamStr(0));
  IBCon.Connected:=False;
  conf := TIniFile.Create(path_exe + 'conf.ini');
  try
    IBCon.DatabaseName := conf.ReadString('DATABASE', 'Name', '');
    IBCon.HostName := conf.ReadString('DATABASE', 'HostName', '');
  finally
    conf.free;
  end;
  sTrans.Active:=True;
  IBCon.Connected:=True;
  sqParametro.Active:=True;
  While not sqParametro.EOF do
  begin
    if (sqParametroPARAMETRO.AsString = 'CENTROCUSTO') then
    begin
      ccusto:=sqParametroDADOS.AsString;
      ccusto_padrao:=sqParametroD1.AsString;
    end;
    sqParametro.Next;
  end;
  sqProc.SQL.Clear;
  sqProc.SQL.Add('SELECT r.VERSAO FROM ATUALIZA r WHERE r.CODATUALIZA = 5000');
  sqProc.Active:=True;
  versao_sistema:=sqProc.FieldByName('VERSAO').AsString;
end;

function Tdm.atualiza_serie(serie: String): Integer;
begin
  sqSeries.Close;
  sqSeries.Params.ParamByName('PSERIE').AsString := serie;
  sqSeries.Active:=True;
  sqSeries.Edit;
  sqSeriesULTIMO_NUMERO.AsLongint := sqSeriesULTIMO_NUMERO.AsLongint+1;
  sqSeries.Post;
  sqSeries.ApplyUpdates;
  result := sqSeriesULTIMO_NUMERO.AsLongint;
end;

procedure Tdm.atualizaBD(tabela: String; tipo: String; campo: String;
  formato: String; versao: String);
var str_atualiza: String;
begin
  // exemplo Atualizando uma tabela
  //dm.atualizaBD('LOTES','ALTER','CODBARRA','CHAR(13)');

  // exemplo criando tabela
  // dm.atualizaBD('NOVATABELA','CREATE','CODNOVO CHAR(13) NOT NULL, ' +
  //   ' CAMPO2 INTEGER, CAMPO3 VARCHAR(80)');

  // TODO: - ver se o campo ou tabela existe antes de executar

  if (tipo = 'ALTER') then
  begin
    str_atualiza := 'ALTER TABLE ' + tabela + ' ADD ' +
      campo + ' ' + formato;
  end;
  if (tipo = 'CREATE') then
  begin
    str_atualiza := 'CREATE TABLE ' + tabela + '( ' +
      campo + ')';
  end;

  //with sqExec do
  //begin
  //  Active := False;
  //  SQL.Clear;
  //  SQL.Add(str_atualiza);
  //end;
  Try
    //ibcon.StartTransaction;
    //sqExec.ExecSQL;
    IBCon.ExecuteDirect(str_atualiza);
    IBCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr(versao) +
      ' WHERE CODATUALIZA = 5000');
    sTrans.Commit;
  except
    //ShowMessage('Erro na atualizacao do Sistema: ' + str_atualiza);
    sTrans.Rollback;
  end;
end;

end.

