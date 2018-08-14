unit udmpdv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, db, FileUtil, IniFiles, Dialogs;

type

  { TdmPdv }

  TdmPdv = class(TDataModule)
    IbCon: TIBConnection;
    sqBusca: TSQLQuery;
    sqGenerator: TSQLQuery;
    sqLancamentos: TSQLQuery;
    sqLancamentosALIQ_CUPOM: TStringField;
    sqLancamentosBAIXA: TStringField;
    sqLancamentosBCII: TFloatField;
    sqLancamentosCATEGORIA: TStringField;
    sqLancamentosCEST: TStringField;
    sqLancamentosCEST_1: TStringField;
    sqLancamentosCFOP: TStringField;
    sqLancamentosCODALMOXARIFADO: TLongintField;
    sqLancamentosCODAUTORIZACAO: TLongintField;
    sqLancamentosCODCLIENTE: TLongintField;
    sqLancamentosCODDETALHE: TLongintField;
    sqLancamentosCODIGO: TLongintField;
    sqLancamentosCODMOVIMENTO: TLongintField;
    sqLancamentosCODNATUREZA: TSmallintField;
    sqLancamentosCODORIGEM: TLongintField;
    sqLancamentosCODPRO: TStringField;
    sqLancamentosCODPRODUTO: TLongintField;
    sqLancamentosCODPRODUTO_1: TLongintField;
    sqLancamentosCODUSUARIO: TSmallintField;
    sqLancamentosCODVENDEDOR: TSmallintField;
    sqLancamentosCOD_BARRA: TStringField;
    sqLancamentosCOD_COMISSAO: TLongintField;
    sqLancamentosCOD_COMISSAO_1: TLongintField;
    sqLancamentosCOD_FUNCIONARIO: TLongintField;
    sqLancamentosCOLABORADOR: TLongintField;
    sqLancamentosCONTROLE: TStringField;
    sqLancamentosCONTROLE_1: TSmallintField;
    sqLancamentosCSOSN: TStringField;
    sqLancamentosCST: TStringField;
    sqLancamentosCSTCOFINS: TStringField;
    sqLancamentosCSTIPI: TStringField;
    sqLancamentosCSTPIS: TStringField;
    sqLancamentosCST_IPI_CENQ: TStringField;
    sqLancamentosDATAMOVIMENTO: TDateField;
    sqLancamentosDATA_SISTEMA: TDateTimeField;
    sqLancamentosDESCONTO: TFloatField;
    sqLancamentosDESCONTO_BC: TStringField;
    sqLancamentosDESCPRODUTO: TStringField;
    sqLancamentosEMBALAGEM: TStringField;
    sqLancamentosESTOQUEATUAL: TFloatField;
    sqLancamentosFAMILIA: TStringField;
    sqLancamentosFORMA_PAG: TStringField;
    sqLancamentosICMS: TFloatField;
    sqLancamentosICMS_SUBST: TFloatField;
    sqLancamentosICMS_SUBSTD: TFloatField;
    sqLancamentosII: TFloatField;
    sqLancamentosIMPRESSO: TStringField;
    sqLancamentosIMPRESSORA_1: TStringField;
    sqLancamentosIMPRESSORA_2: TStringField;
    sqLancamentosIMPRESSORA_3: TStringField;
    sqLancamentosIMPRIMIR: TStringField;
    sqLancamentosLOCALIZACAO: TStringField;
    sqLancamentosMARCA: TStringField;
    sqLancamentosMARGEM: TFloatField;
    sqLancamentosMARGEM_LUCRO: TFloatField;
    sqLancamentosNCM: TStringField;
    sqLancamentosNCM_1: TStringField;
    sqLancamentosNITEMPED: TLongintField;
    sqLancamentosNOTAFISCAL: TStringField;
    sqLancamentosOBS: TStringField;
    sqLancamentosOBS_MD: TStringField;
    sqLancamentosOBS_PROD: TStringField;
    sqLancamentosORIGEM: TStringField;
    sqLancamentosORIGEM_1: TLongintField;
    sqLancamentosPAGO: TStringField;
    sqLancamentosPAGOU: TStringField;
    sqLancamentosPCOFINS: TFloatField;
    sqLancamentosPEDIDO: TStringField;
    sqLancamentosPESO_LIQ: TFloatField;
    sqLancamentosPESO_QTDE: TFloatField;
    sqLancamentosPFCPUFDEST: TFloatField;
    sqLancamentosPICMSINTER: TFloatField;
    sqLancamentosPICMSINTERPART: TFloatField;
    sqLancamentosPICMSUFDEST: TFloatField;
    sqLancamentosPIPI: TFloatField;
    sqLancamentosPORCENTAGENDESC: TFloatField;
    sqLancamentosPPIS: TFloatField;
    sqLancamentosPRAZO_PAGAMENTO: TStringField;
    sqLancamentosPRECO: TFloatField;
    sqLancamentosPRECOCUSTO: TFloatField;
    sqLancamentosPRECOMEDIO: TBCDField;
    sqLancamentosPRODUTO: TStringField;
    sqLancamentosQTD: TLongintField;
    sqLancamentosQTDEESTOQUE: TFloatField;
    sqLancamentosQTDE_ALT: TFloatField;
    sqLancamentosQTDE_PCT: TFloatField;
    sqLancamentosQUANTIDADE: TFloatField;
    sqLancamentosSTATUS: TSmallintField;
    sqLancamentosSTATUS_1: TStringField;
    sqLancamentosTIPO: TStringField;
    sqLancamentosTIPOPRECOVENDA: TStringField;
    sqLancamentosTIPO_PEDIDO: TStringField;
    sqLancamentosTOTALMOVIMENTO: TFloatField;
    sqLancamentosUN: TStringField;
    sqLancamentosUNIDADEMEDIDA: TStringField;
    sqLancamentosUSA: TStringField;
    sqLancamentosUSUARIOLOGADO: TStringField;
    sqLancamentosVALORCOMISSAO: TFloatField;
    sqLancamentosVALORUNITARIOATUAL: TFloatField;
    sqLancamentosVALOR_COFINS: TFloatField;
    sqLancamentosVALOR_DESCONTO: TFloatField;
    sqLancamentosVALOR_ICMS: TFloatField;
    sqLancamentosVALOR_OUTROS: TFloatField;
    sqLancamentosVALOR_PIS: TFloatField;
    sqLancamentosVALOR_PRAZO: TFloatField;
    sqLancamentosVALOR_SEGURO: TFloatField;
    sqLancamentosVALTOTAL: TFloatField;
    sqLancamentosVBCUFDEST: TFloatField;
    sqLancamentosVFCPUFDEST: TFloatField;
    sqLancamentosVICMSUFDEST: TFloatField;
    sqLancamentosVICMSUFREMET: TFloatField;
    sqLancamentosVIPI: TFloatField;
    sqLancamentosVLRBC_COFINS: TFloatField;
    sqLancamentosVLRBC_IPI: TFloatField;
    sqLancamentosVLRBC_PIS: TFloatField;
    sqLancamentosVLRESTOQUE: TFloatField;
    sqLancamentosVLRTOT_TRIB: TFloatField;
    sqLancamentosVLR_BASE: TFloatField;
    sqLancamentosVLR_BASEICMS: TFloatField;
    SQLQuery1: TSQLQuery;
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
    sTrans: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    ccusto : String;
    ccusto_padrao : String;
    versao_sistema: String;
    usaCentroCusto: String;
    varLogado : String;
    MICRO : String;
    function executaSql(strSql: String): Boolean;
    procedure gravaLog(DataLog: TDateTime; usuario: String; tipoMovimento: String;
    pc: String; valorAnt: String; valorPos: String; campoChave: String; acao: String);
  end;

var
  dmPdv: TdmPdv;

implementation

{$R *.lfm}

{ TdmPdv }

procedure TdmPdv.DataModuleCreate(Sender: TObject);
var
  conf: TIniFile;
  path_exe : String;
begin
  //extrac
  varLogado := '1'; // usuario logado
  MICRO := GetEnvironmentVariable('COMPUTERNAME');
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
  usaCentroCusto := 'S';
  While not sqParametro.EOF do
  begin
    if (sqParametroPARAMETRO.AsString = 'CENTROCUSTO') then
    begin
      ccusto:=sqParametroDADOS.AsString;
      ccusto_padrao:=sqParametroD1.AsString;
    end;
    sqParametro.Next;
  end;
  sqBusca.SQL.Clear;
  sqBusca.SQL.Add('SELECT r.VERSAO FROM ATUALIZA r WHERE r.CODATUALIZA = 5000');
  sqBusca.Active:=True;
  versao_sistema:=sqBusca.FieldByName('VERSAO').AsString;
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
    on E: EDatabaseError do
    begin
      MessageDlg('Error','Erro na conexao com a base de dados, erro : ' +
        E.Message,mtError,[mbOK],0);
    end;
  end;
end;

function TdmPdv.executaSql(strSql: String): Boolean;
begin
  try
    ibcon.ExecuteDirect(strSql);
    Result := True;
  except
    on E: EDatabaseError do
    begin
      MessageDlg('Error','Erro na conexao com a base de dados, erro : ' +
        E.Message,mtError,[mbOK],0);
      Result := False;
    end;
  end;
end;

end.

