unit udm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, SQLDB, DB, IniFiles, dialogs;

type

  { Tdm }

  Tdm = class(TDataModule)
    dsOrcamento: TDataSource;
    dsbusca: TDataSource;
    IbCon: TIBConnection;
    sqBusca: TSQLQuery;
    sqBuscaOrc: TSQLQuery;
    sqBuscaOrcCODPROD: TLongintField;
    sqBuscaOrcCODPRODPRO: TStringField;
    sqBuscaOrcPRODUTO: TStringField;
    sqEmpresa: TSQLQuery;
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
    sqGen: TSQLQuery;
    sqlOrc: TSQLQuery;
    sqlOrcamento: TSQLQuery;
    sqlOrcamentoCODORC: TLongintField;
    sqlOrcamentoCODPROD: TLongintField;
    sqlOrcamentoCODPRODMAT: TStringField;
    sqlOrcamentoCODPRODPRO: TStringField;
    sqlOrcamentoCUSTOTOT: TFloatField;
    sqlOrcamentoCUSTOUNIT: TFloatField;
    sqlOrcamentoID: TLongintField;
    sqlOrcamentoMATPRIMA: TStringField;
    sqlOrcamentoPRODUTO: TStringField;
    sqlOrcamentoQTDE: TFloatField;
    sqlOrcCODPROD: TLongintField;
    sqlOrcDadosDATACADASTRO: TDateField;
    sqlOrcDadosID: TLongintField;
    sqlOrcDadosID_ORCAMENTO: TLongintField;
    sqlOrcDadosNOMECLIENTE: TStringField;
    sqlOrcDadosVALOR_A: TFloatField;
    sqlOrcDadosVALOR_B: TFloatField;
    sqlOrcDadosVALOR_C: TFloatField;
    sqlOrcDadosVALOR_D: TFloatField;
    sqlOrcDadosVALOR_E: TFloatField;
    sqlOrcDadosVALOR_PORC_A: TFloatField;
    sqlOrcDadosVALOR_PORC_B: TFloatField;
    sqlOrcDadosVALOR_PORC_C: TFloatField;
    sqlOrcDadosVALOR_PORC_D: TFloatField;
    sqlOrcDadosVALOR_PORC_E: TFloatField;
    sqlOrcDadosVALOR_TOTAL_A: TFloatField;
    sqlOrcDadosVALOR_TOTAL_B: TFloatField;
    sqlOrcDadosVALOR_TOTAL_C: TFloatField;
    sqlOrcDadosVALOR_TOTAL_D: TFloatField;
    sqlOrcDadosVALOR_TOTAL_E: TFloatField;
    sqlOrcDadosVALOR_TOTAL_GERAL: TFloatField;
    sqlOrcPRODUTO: TStringField;
    sTrans: TSQLTransaction;
    function executaSql(strSql: String): Boolean;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    varLogado : String;
    nomeLogado : String;
    senhaLogin : String;
    MICRO : String;
    path_exe: String;
  end;

var
  dm: Tdm;

implementation

{$R *.lfm}

{ Tdm }

function Tdm.executaSql(strSql: String): Boolean;
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

procedure Tdm.DataModuleCreate(Sender: TObject);
var
  conf: TIniFile;
  snh: String;
  vstr: String;
begin
  varLogado := ''; // usuario logado
  nomeLogado:= '';
  senhaLogin := '';
  MICRO := GetEnvironmentVariable('COMPUTERNAME');

  IBCon.Connected:=False;
  sTrans.Params.Text := 'isc_tpb_read_committed';
  //IBCon.CharSet:='WIN1252';
  //path_exe := path_exe;
  if FileExists(path_exe  + 'dbxconnections.ini') then
  begin
    conf := TIniFile.Create(path_exe + 'dbxconnections.ini');
    try
      vstr := conf.ReadString('sisAdmin', 'Database', '');
      IBCon.DatabaseName := vstr;
      vstr := conf.ReadString('sisAdmin', 'Hostname', '');
      IBCon.HostName := vstr;
      snh := conf.ReadString('sisAdmin', 'Password', '');
      //snh:= EncodeStringBase64(snh); // Ver a senha Encryptada
      //snh:= DecodeStringBase64(snh);
      IBCon.Password := snh;
      vstr := IntToStr(conf.ReadInteger('sisAdmin', 'Port', 3050));
      IbCon.Params.Add('port=' + vstr)
    finally
      conf.free;
    end;
  end;

end;

end.

