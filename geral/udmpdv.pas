unit udmpdv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, pqconnection, db, FileUtil, IniFiles,
  Dialogs,  base64;

type

  { TdmPdv }

  TdmPdv = class(TDataModule)
    IbCon: TIBConnection;
    sqBusca: TSQLQuery;
    sqBusca1: TSQLQuery;
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
    sTrans: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure IbConAfterDisconnect(Sender: TObject);
    procedure IbConBeforeConnect(Sender: TObject);
  private
    procedure atualiza_bd();
  public
    usosistema : string;
    usaComanda : Integer;
    usaCurso : Integer;
    contaCaixa : Integer;
    margemCodBarra: Integer;
    tamanhoLinha: Integer;
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
    vendedor_padrao: Integer;
    imp_controle_porta: Boolean;
    imp_Interval: Integer;
    imp_LinhasBuffer: Integer;
    imp_ColunaFonteNormal: Integer;
    function executaSql(strSql: String): Boolean;
    procedure executaDSQL(strDSQL: String); // criei pra executar o atualiza Bd
    procedure gravaLog(DataLog: TDateTime; usuario: String; tipoMovimento: String;
    pc: String; valorAnt: String; valorPos: String; campoChave: String; acao: String);
    function busca_generator(generator: String): integer;
    function busca_serie(Serie: String): integer;
    procedure busca_sql(sql_txt: String);
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
  if FileExists(path_exe  + 'conf.ini') then
  begin
    conf := TIniFile.Create(path_exe + 'conf.ini');
    try
      vstr := conf.ReadString('DATABASE', 'Name', '');
      IBCon.DatabaseName := vstr;
      vstr := conf.ReadString('DATABASE', 'HostName', '');
      path_python := conf.ReadString('PATH', 'PathPython', '');
      path_script := conf.ReadString('PATH', 'PathScript', '');
      path_xml := conf.ReadString('PATH', 'PathXML', path_exe);
      path_imp := conf.ReadString('PATH', 'PathIMP', 'imp.txt');
      IBCon.HostName := vstr;
      snh:= conf.ReadString('DATABASE', 'Acesso', '');
      portaImp := conf.ReadString('IMPRESSORA', 'porta', '');
      ModeloImp := conf.ReadInteger('IMPRESSORA', 'Modelo', 0);
      CupomImp := conf.ReadString('IMPRESSORA', 'Cupom', 'Texto');
      espacoEntreLinhas := conf.ReadInteger('IMPRESSORA', 'EspacoEntreLinhas', 10);
      margemCodBarra := conf.ReadInteger('IMPRESSORA', 'MargemCodBarra', 50);
      tamanhoLinha := conf.ReadInteger('IMPRESSORA', 'TamanhoLinha', 36);
      imp_controle_porta := conf.ReadBool('IMPRESSORA', 'ControlaPorta', False);
      imp_Interval := conf.ReadInteger('IMPRESSORA', 'SendBytesInterval', 0);
      imp_LinhasBuffer:= conf.ReadInteger('IMPRESSORA', 'LinhasBuffer', 0);
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
  While not sqParametro.EOF do
  begin
    if (sqParametroPARAMETRO.AsString = 'CENTROCUSTO') then
    begin
      if (ccusto = '') then
        ccusto:=sqParametroDADOS.AsString;

      ccusto_padrao:=sqParametroD1.AsString;
    end;
    if (sqParametroPARAMETRO.AsString = 'SERIENFCe') then
    begin
      tk := sqParametroDADOS.AsString;
      id_tk := sqParametroD4.AsString;
    end;
    if (sqParametroPARAMETRO.AsString = 'CONSUMIDOR') then
    begin
      try
        clientePadrao := StrToInt(sqParametroDADOS.AsString);
      Except
        ShowMessage('Parametro Consumidor campo DADOS precisa ser número');
      end;
    end;
    if (sqParametroPARAMETRO.AsString = 'CAIXA_BANCO') then
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
  sqBusca.Active := False;
  sqBusca.SQL.Clear;
  sqBusca.SQL.Add('SELECT r.VERSAO FROM ATUALIZA r WHERE r.CODATUALIZA = 5000');
  sqBusca.Active:=True;
  versao_sistema:=sqBusca.FieldByName('VERSAO').AsString;
  if (versao_sistema <> '1.2') then
  begin
    atualiza_bd();
  end;
end;

procedure TdmPdv.IbConAfterDisconnect(Sender: TObject);
begin

end;

procedure TdmPdv.IbConBeforeConnect(Sender: TObject);
begin

end;

procedure TdmPdv.atualiza_bd();
begin
  Try
    IbCon.ExecuteDirect('ALTER TABLE FORMA_ENTRADA  ADD STATE SMALLINT');
  Except
  end;
  Try
    IbCon.ExecuteDirect('ALTER TABLE FORMA_ENTRADA  ADD troco double precision');
  Except
  end;

  Try
    IbCon.ExecuteDirect('ALTER TABLE USUARIO ADD SENHA VARCHAR(50)');
  Except
  end;
  Try
    IbCon.ExecuteDirect('ALTER TABLE USUARIO ADD CODBARRA VARCHAR(13)');
  Except
  end;
  Try
    IbCon.ExecuteDirect('ALTER TABLE PRODUTOS ADD PRECOATACADO DOUBLE PRECISION');
    IbCon.ExecuteDirect('ALTER TABLE PRODUTOS ADD QTDEATACADO DOUBLE PRECISION');
  Except
  end;
  Try
    IbCon.ExecuteDirect('ALTER TABLE FORMA_ENTRADA  ADD CODFORMA INTEGER NOT NULL');
    IbCon.ExecuteDirect('ALTER TABLE FORMA_ENTRADA  ADD PRIMARY KEY (CODFORMA)');
  Except
  end;
  sTrans.Commit;
  Try
    IbCon.ExecuteDirect('CREATE SEQUENCE GEN_FORMA');
  Except
  end;

  Try
    IbCon.ExecuteDirect('ALTER TABLE MOVIMENTO ADD DESCONTO DOUBLE PRECISION');
  Except
  end;
  Try
    IbCon.ExecuteDirect('alter table venda add XMLNFE BLOB SUB_TYPE 0');
    IbCon.ExecuteDirect('alter table venda add NOMEXML VARCHAR( 60 )');
    IbCon.ExecuteDirect('alter table venda add PROTOCOLOENV VARCHAR( 20 )');
    IbCon.ExecuteDirect('alter table venda add NUMRECIBO VARCHAR( 20 )');
  Except
  end;
  Try
    IbCon.ExecuteDirect('ALTER TABLE FORMA_ENTRADA  ADD DESCONTO double precision');
  Except
  end;

  {
  Try
    IbCon.ExecuteDirect('ALTER TABLE USUARIO ADD PODE_EXCLUIR CHAR(1)');
  Except
  end;
  Try
    IbCon.ExecuteDirect('ALTER TABLE USUARIO ADD PODE_DESCONTO CHAR(1)');
  Except
  end;}


  IbCon.ExecuteDirect('UPDATE ATUALIZA SET VERSAO = ' + QuotedStr('1.2') +
    ' WHERE CODATUALIZA = 5000');
  sTrans.Commit;
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

