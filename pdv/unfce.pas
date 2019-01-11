unit uNfce;

{$mode objfpc}{$H+}

interface

uses
  Classes, typinfo, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  MaskEdit, Buttons, StdCtrls, ExtCtrls, ComCtrls, Menus, ActnList, udmpdv,
  uCertificadoLer, ACBrNFe, ACBrNFeDANFeESCPOS, ACBrDANFCeFortesFr,
  pcnConversao, pcnConversaoNFe, ACBrDFeSSL, ACBrPosPrinter, ACBrIntegrador,
  ACBrValidador, ACBrEnterTab, ACBrUtil, StrUtils, IniFiles, math;

type

  { TfNfce }

  TfNfce = class(TForm)
    ACBrEnterTab1: TACBrEnterTab;
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFeESCPOS1: TACBrNFeDANFeESCPOS;
    ACBrPosPrinter1: TACBrPosPrinter;
    ACBrValidador1: TACBrValidador;
    acFechar: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    btnFechar: TBitBtn;
    btnNFce: TBitBtn;
    btnNFce1: TBitBtn;
    btnNFce2: TBitBtn;
    cbCryptLib: TComboBox;
    cbHttpLib: TComboBox;
    cbSSLLib: TComboBox;
    cbXmlSignLib: TComboBox;
    cbxModeloPosPrinter: TComboBox;
    edtCaminho: TLabeledEdit;
    edtNumSerie: TLabeledEdit;
    edtSenha: TLabeledEdit;
    Label1: TLabel;
    edCPF: TMaskEdit;
    edCertificado: TLabeledEdit;
    edNFce: TLabeledEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblcbCryptLib: TLabel;
    lblcbSSLLib: TLabel;
    lblProtocolo: TLabel;
    MemoDados: TMemo;
    MemoResp: TMemo;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    RadioGroup1: TRadioGroup;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    procedure ACBrNFe1AntesDeAssinar(var ConteudoXML: String; const docElement,
      infElement, SignatureNode, SelectionNamespaces, IdSignature: String);
    procedure acFecharExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNFce1Click(Sender: TObject);
    procedure btnNFce2Click(Sender: TObject);
    procedure btnNFceClick(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure edCPFKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    total_tributos: Double;
    serie_nfce: Integer;
    num_nfce: Integer;
    notaEmitida: String;
    function RemoveChar(Const Texto:String):String;
    procedure GerarNFCe(Num: String);
    procedure prepararImpressao();
    procedure pegaTributos(codMov: Integer; codProd: Integer);
    procedure pegaItens();
    procedure AtualizaSSLLibsCombo;
    procedure GravarDadosNF(protocolo: String; recibo: String);
  public
    nfce_valor: Double;
    nfce_desconto: Double;
    nfce_codVenda: Integer;
  end;

var
  fNfce: TfNfce;

implementation

{$R *.lfm}

{ TfNfce }

procedure TfNfce.btnNFceClick(Sender: TObject);
var
 vAux, vNumLote, vSincrono : String;
 Sincrono : boolean;
 Protocolo, Recibo: String;
 str: String;
 ambiente: String;
begin
  ACBrNFe1.NotasFiscais.Clear;
  if (notaEmitida = 'S') then
  begin
    ShowMessage('Nota Fiscal já emitida.');
    Exit;
  end;
  ACBrNFe1.SSL.DescarregarCertificado;
  ACBrNFe1.Configuracoes.Certificados.ArquivoPFX  := dmPdv.CaminhoCert;
  ACBrNFe1.Configuracoes.Certificados.Senha       := dmPdv.SenhaCert;
  edtNumSerie.Text := dmPdv.NumSerieCert;
  edCertificado.Text := edtNumSerie.Text;
  ACBrNFe1.Configuracoes.Certificados.NumeroSerie := edCertificado.Text;

  //edtPathSchemas.Text  := Ini.ReadString( 'Geral','PathSchemas'  ,PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\') ;
  ACBrNFe1.SSL.CarregarCertificado;

  with ACBrNFe1.Configuracoes.Geral do
  begin
    SSLLib       := TSSLLib(cbSSLLib.ItemIndex);
    SSLCryptLib  := TSSLCryptLib(cbCryptLib.ItemIndex);
    SSLHttpLib   := TSSLHttpLib(cbHttpLib.ItemIndex);
    SSLXmlSignLib:= TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  end;

  if (dmPdv.tk = '') then
  begin
    ShowMessage('Cadastre: '+#13+#10+''+#13+#10+'Natureza Operação : 30 ' +
      'para Nota Fiscal Consumidor;'+#13+#10+''+#13+#10+'Série :' +
      'para ser usada na NFCe;'+#13+#10+''+#13+#10+'Parametro: ' +
      'SERIENFCe com a série criada no campo D1.');
    exit;
  end;


  if (edCPF.Text <> '   .   .   -  ') then
  begin
    ACBrValidador1.PermiteVazio:=True;
    ACBrValidador1.TipoDocto:= docCPF;
    ACBrValidador1.IgnorarChar:='./-';
    ACBrValidador1.Documento:=edCPF.Text;
    if not ACBrValidador1.Validar then
    begin
      edCPF.Font.Color:=clRed;
      ShowMessage('CPF Inválido');
      edCPF.SetFocus;
      Exit;
    end
    else begin
      edCPF.Font.Color := clBlack;
    end;
  end;
  if (edCertificado.Text = '') then
  begin
    MessageDlg('Informe o certificado.',mtError,[mbok],0);
    exit;
  end;

  vAux := edNFCe.Text;
  //if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
  //  exit;

  //if not(InputQuery('WebServices Enviar', 'Numero do Lote', vNumLote)) then
  //  exit;

  vSincrono := '1';
  Sincrono := True;
  //if not(InputQuery('WebServices Enviar', 'Envio Síncrono(1=Sim, 0=Não)', vSincrono)) then
  //  exit;

  vNumLote := '1';

  if Trim(vNumLote) = '' then
  begin
    MessageDlg('Número do Lote inválido.',mtError,[mbok],0);
    exit;
  end;

  if (Trim(vSincrono) <> '1') and
     (Trim(vSincrono) <> '0') then
  begin
     MessageDlg('Valor Inválido.',mtError,[mbok],0);
     exit;
  end;
  Sincrono := False;

  // carlos 23/12/14
  ACBrNFe1.Configuracoes.Geral.ModeloDF := moNFCe;
  ACBrNFe1.Configuracoes.Geral.VersaoDF := ve400;

  ACBrNFe1.Configuracoes.Geral.IdCSC := dmPdv.id_tk;
  ACBrNFe1.Configuracoes.Geral.CSC := dmPdv.tk;

  //ACBrNFe1.Configuracoes.Geral.SSLLib := libCapicom;

  // TODO
  //if ACBrNFe1.NotasFiscais.Add.NFe.ide.tpAmb = taHomologacao then
  //  ambiente := 'homolog';
  AcbrNfe1.Configuracoes.Arquivos.PathSalvar := dmpdv.path_xml + '\NFce\';
  AcbrNfe1.Configuracoes.Arquivos.PathEvento := dmpdv.path_xml + '\Eventos\';

  GerarNFCe(vAux);
  //if ACBrNFe1.NotasFiscais.Add.NFe.ide.tpAmb = taHomologacao then
  //  ambiente := 'homolog';

  //edtCaminho.Text := ACBrNFe1.SSL.CertCNPJ;
  //ACBrNFe1.NotasFiscais.GravarXML(AcbrNfe1.Configuracoes.Arquivos.PathSalvar);
  ACBrNFe1.NotasFiscais.Assinar;
  //ACBrNFe1.NotasFiscais.GravarXML(AcbrNfe1.Configuracoes.Arquivos.PathSalvar);

  // Gravando a nota aqui pois se der erro no validar ja gravei
  GravarDadosNF('', '');

  ACBrNFe1.NotasFiscais.Validar;
  //LoadXML(ACBrNFe1.NotasFiscais.Items[0].XML,  mRecebido);

  // TODO
  //prepararImpressao();
  //ACBrNFe1.DANFE := ACBrNFeDANFCeFortes1;

  //ACBrNFe1.DANFE.TipoDANFE := tiNFCeA4;
  if (dmPdv.NFE_Teste = 'N') then
    ACBrNFe1.Enviar(vNumLote,True,Sincrono);

  MemoResp.Lines.Add(UTF8Encode(ACBrNFe1.WebServices.Retorno.RetWS));
  memoResp.Lines.Add(UTF8Encode(ACBrNFe1.WebServices.Retorno.RetornoWS));

  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Envio NFe');
  MemoDados.Lines.Add('tpAmb: '+ TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb));
  MemoDados.Lines.Add('verAplic: '+ ACBrNFe1.WebServices.Retorno.verAplic);
  MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cStat));
  MemoDados.Lines.Add('cUF: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cUF));
  MemoDados.Lines.Add('xMotivo: '+ ACBrNFe1.WebServices.Retorno.xMotivo);
  MemoDados.Lines.Add('cMsg: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cMsg));
  MemoDados.Lines.Add('xMsg: '+ ACBrNFe1.WebServices.Retorno.xMsg);
  MemoDados.Lines.Add('Recibo: '+ ACBrNFe1.WebServices.Retorno.Recibo);
  MemoDados.Lines.Add('Protocolo: '+ ACBrNFe1.WebServices.Retorno.Protocolo);

  ShowMessage('Nº do Protocolo de envio ' + ACBrNFe1.WebServices.Retorno.Protocolo);
  ShowMessage('Nº do Recibo de envio ' + ACBrNFe1.WebServices.Retorno.Recibo);

  Protocolo := ACBrNFe1.WebServices.Retorno.Protocolo;
  Recibo := ACBrNFe1.WebServices.Retorno.Recibo;
  //LoadXML(ACBrNFe1.NotasFiscais.Items[0].XML,  mRecebido);
  //ACBrNFe1.NotasFiscais.Imprimir;

  GravarDadosNF(protocolo, recibo);
  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Nota Fiscal Consumidor, gerada com sucesso.');
  MemoDados.Lines.Add('');
  ACBrNFe1.NotasFiscais.Clear;
  Close;
end;

procedure TfNfce.cbCryptLibChange(Sender: TObject);
begin
  try
    if cbCryptLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLCryptLib := TSSLCryptLib(cbCryptLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfNfce.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfNfce.cbSSLLibChange(Sender: TObject);
begin
  try
    if cbSSLLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfNfce.cbXmlSignLibChange(Sender: TObject);
begin
  try
    if cbXmlSignLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfNfce.edCPFKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    BitBtn3.SetFocus;
  end;
end;



procedure TfNfce.FormCreate(Sender: TObject);
var  N: TACBrPosPrinterModelo;
    T : TSSLLib;
    U: TSSLCryptLib;
    V: TSSLHttpLib;
    X: TSSLXmlSignLib;
begin
  //ACBrNFeDANFeESCPOS1 := TACBrNFeDANFeESCPOS.Create(nil);
  //ACBrNFeDANFCeFortes1 := TACBrNFeDANFCeFortes.Create(nil);
  cbxModeloPosPrinter.Items.Clear ;
  For N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
     cbxModeloPosPrinter.Items.Add(GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(N) ));
  cbxModeloPosPrinter.ItemIndex := dmPdv.ModeloImp;

  cbSSLLib.Items.Clear ;
  For T := Low(TSSLLib) to High(TSSLLib) do
    cbSSLLib.Items.Add( GetEnumName(TypeInfo(TSSLLib), integer(T) ) ) ;
  cbSSLLib.ItemIndex := dmPdv.SSLLib;

  cbCryptLib.Items.Clear ;
  For U := Low(TSSLCryptLib) to High(TSSLCryptLib) do
    cbCryptLib.Items.Add( GetEnumName(TypeInfo(TSSLCryptLib), integer(U) ) ) ;
  cbCryptLib.ItemIndex := dmPdv.CryptLib;

  cbHttpLib.Items.Clear ;
  For V := Low(TSSLHttpLib) to High(TSSLHttpLib) do
    cbHttpLib.Items.Add( GetEnumName(TypeInfo(TSSLHttpLib), integer(V) ) ) ;
  cbHttpLib.ItemIndex := dmPdv.HttpLib;

  cbXmlSignLib.Items.Clear ;
  For X := Low(TSSLXmlSignLib) to High(TSSLXmlSignLib) do
    cbXmlSignLib.Items.Add( GetEnumName(TypeInfo(TSSLXmlSignLib), integer(X) ) ) ;
  cbXmlSignLib.ItemIndex := dmPdv.XmlSignLib;

  edtCaminho.Text := dmPdv.CaminhoCert;
  edtSenha.Text   := dmPdv.SenhaCert;
  edtNumSerie.Text:= dmPdv.NumSerieCert;
  { coloquei no botão NFCE
  ACBrNFe1.Configuracoes.Certificados.ArquivoPFX  := dmPdv.CaminhoCert;
  ACBrNFe1.Configuracoes.Certificados.Senha       := dmPdv.SenhaCert;
  ACBrNFe1.Configuracoes.Certificados.NumeroSerie := dmPdv.NumSerieCert;

  //edtPathSchemas.Text  := Ini.ReadString( 'Geral','PathSchemas'  ,PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\') ;
  ACBrNFe1.SSL.DescarregarCertificado;

  with ACBrNFe1.Configuracoes.Geral do
  begin
    SSLLib       := TSSLLib(cbSSLLib.ItemIndex);
    SSLCryptLib  := TSSLCryptLib(cbCryptLib.ItemIndex);
    SSLHttpLib   := TSSLHttpLib(cbHttpLib.ItemIndex);
    SSLXmlSignLib:= TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  end;
  }
end;

procedure TfNfce.FormDestroy(Sender: TObject);
begin
  //ACBrNFeDANFeESCPOS1.Destroy;
  //ACBrNFeDANFCeFortes1.Destroy;
end;

procedure TfNfce.FormShow(Sender: TObject);
var msg_ncm: String;
 msg_origem: String;
 t: string;
 serie : String;
begin
  ACBrPosPrinter1.Porta := dmPdv.portaImp;
  ACBrPosPrinter1.Modelo:= TACBrPosPrinterModelo(cbxModeloPosPrinter.ItemIndex);
  notaEmitida := 'N';
  edNFce.text := '';
  edCPF.Text := '';
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text:='SELECT NOTAFISCAL , NOMEXML, PROTOCOLOENV, SERIE FROM VENDA ' +
    'WHERE CODVENDA = ' + IntToStr(nfce_codVenda);
  dmPdv.sqBusca.Open;
  if (not dmpdv.sqBusca.IsEmpty) then
  begin
    t := dmPdv.sqBusca.Fields[1].AsString;
    serie := copy(dmPdv.sqBusca.Fields[3].AsString,0,4);
    if (serie = 'NFCE') then
    begin
      edNFce.text := IntToStr(dmPdv.sqBusca.Fields[0].AsInteger);
    end;
    if (dmPdv.sqBusca.Fields[2].AsString <> '') then
    begin
      notaEmitida := 'S';
      t := IntToStr(dmPdv.sqBusca.Fields[0].AsInteger);
    end;
    if dmPdv.sqBusca.Fields[2].AsString <> '' then
    begin
      lblProtocolo.Caption:=dmPdv.sqBusca.Fields[2].AsString;
    end;
  end;
  if (not dmPdv.sqLancamentos.Active) then
    exit;
  dmPdv.sqLancamentos.First;
  msg_ncm:='';
  msg_origem:='';
  while not dmPdv.sqLancamentos.Eof do
  begin
    if ((dmPdv.sqLancamentosNCM.IsNull) OR (dmPdv.sqLancamentosNCM.AsString = '')
       or (Length(dmPdv.sqLancamentosNCM.AsString) < 8)) then
    begin
      msg_ncm += dmPdv.sqLancamentosCODPRO.AsString + ';';
    end;
    //teste := dmPdv.sqLancamentosORIGEM.AsString;
    if (dmPdv.sqLancamentosORIGEM.IsNull) then
    begin
      msg_origem += dmPdv.sqLancamentosCODPRO.AsString + ';';
    end;
    dmPdv.sqLancamentos.Next;
  end;
  if (msg_ncm <> '') then
  begin
    MessageDlg('NCM não informado ou inválido para os produtos: ' + msg_ncm, mtError, [mbOK], 0);
  end;
  if (msg_origem <> '') then
  begin
    MessageDlg('Origem do Produto(CADASTRO PRODUTO) não informado, para : ' +
              msg_origem, mtError, [mbOK], 0);
  end;
  if ((msg_ncm <> '') or (msg_origem <> '')) then
  begin
    MemoResp.Lines.Clear;
    if (msg_ncm <> '') then
    begin
      MemoResp.Lines.Add('');
      MemoResp.Lines.Add('NCM não informado ou inválido para os produtos: ');
      MemoResp.Lines.Add(msg_ncm);
    end;
    if (msg_origem <> '') then
    begin
      MemoResp.Lines.Add('');
      MemoResp.Lines.Add('Origem do Produto(CADASTRO PRODUTO) não informado, para :');
      MemoResp.Lines.Add(msg_origem);
    end;


  end;
  if ((edNFce.Text = '') or (edNFce.Text = '0')) then
  begin
    // usando no CODSERIE o CODUSUARIO .. pra pegar a SERIE por USUARIO
    dmPdv.sqBusca.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqBusca.SQL.Text := 'SELECT * FROM SERIES WHERE SERIE = ' +
      QuotedStr('NFCE-'+dmPdv.varLogado);
    dmPdv.sqBusca.Open;

    if dmPdv.sqBusca.IsEmpty then
    begin
      ShowMessage('Série não cadastrada para o Usuario deste Caixa.');
      Exit;
    end;
    Try
      serie_nfce := StrToInt(Trim(dmPdv.sqBusca.FieldByName('CODSERIE').AsString));
    except
      ShowMessage('O campo CODSERIE na serie NFCE tem que ser númerico.');
      exit;
    end;
    num_nfce := dmPdv.sqBusca.FieldByName('ULTIMO_NUMERO').AsInteger+1;
    edNFce.Text:=IntToStr(num_nfce);
  end;
  BitBtn3.SetFocus;
end;

function TfNfce.RemoveChar(const Texto: String): String;
var
  I: integer;
  S: string;
begin
  S := '';
  for I := 1 To Length(Texto) Do
  begin
    if (Texto[I] in ['0'..'9']) then
    begin
     S := S + Copy(Texto, I, 1);
    end;
  end;
  result := S;

end;

procedure TfNfce.GerarNFCe(Num: String);
var
 tributos :string;
 vlr : Double;
begin
  // gerar nfce
  if (dmPdv.sqEmpresa.Active) then
    dmPdv.sqEmpresa.Close;
  ////dmPdv.sqEmpresa.Params[0].AsInteger := dm.CCustoPadrao; //Buscar de parametro
  dmPdv.sqEmpresa.Open;
  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    Ide.cNF       := num_nfce; //Caso não seja preenchido será gerado um número aleatório pelo componente
    Ide.natOp     := 'VENDA';
    ////if (chkAvista.Checked) then
      Ide.indPag    := ipVista;
    ////else
     //// Ide.indPag    := ipPrazo;
    Ide.modelo    := 65;
    Ide.serie     := serie_nfce;
    Ide.nNF       := num_nfce;
    Ide.dEmi      := now;
    Ide.dSaiEnt   := now;
    Ide.hSaiEnt   := now;
    Ide.tpNF      := tnSaida;
    Ide.tpEmis    := teNormal;
    ////Ide.tpEmis    := TpcnTipoEmissao(cbFormaEmissao.ItemIndex); ;
    if(dmPdv.sqEmpresaTIPO.IsNull) then
    begin
     ShowMessage('O Campo TIPO na tabela EMPRESA precisa ser 1 par ' +
       'NFCe Producaoo ou 2 para NFCe Homolocacao');
     exit;
    end;
    if(dmPdv.sqEmpresaTIPO.AsInteger = 1 ) then
    begin
      Ide.tpAmb := taProducao;
      ACBrNFe1.Configuracoes.WebServices.Ambiente:=taProducao;
    end
    else begin
      Ide.tpAmb := taHomologacao;
      ACBrNFe1.Configuracoes.WebServices.Ambiente:=taHomologacao;
    end;
    if (dmpdv.sqEmpresaUF.IsNull) then
    begin
      ShowMessage('Informar o UF no cadastro da Empresa');
      Exit;
    end;
    if (dmpdv.sqEmpresaUF.AsString = 'SP') then
      Ide.cUF       := 35; // SP
    if (dmpdv.sqEmpresaUF.AsString = 'BA') then
      Ide.cUF       := 29;

    Ide.cMunFG    := StrToInt(RemoveChar(dmPdv.sqEmpresaCD_IBGE.AsString));
    Ide.finNFe    := fnNormal;
    Ide.tpImp     := tiNFCe;
    Ide.indFinal  := cfConsumidorFinal;
    Ide.indPres   := pcPresencial;
    //autXML.Add.CNPJCPF := RemoveChar(sEmpresaCNPJ_CPF.AsString);

    //     Ide.dhCont := date;
    //     Ide.xJust  := 'Justificativa Contingencia';
    ////label8.Caption := RemoveChar(dmPdv.sqEmpresaCNPJ_CPF.AsString);
    Emit.CNPJCPF           := RemoveChar(dmPdv.sqEmpresaCNPJ_CPF.AsString);
    Emit.IE                := RemoveChar(dmPdv.sqEmpresaIE_RG.AsString);
    Emit.xNome             := dmPdv.sqEmpresaRAZAO.AsString;
    Emit.xFant             := dmPdv.sqEmpresaEMPRESA.AsString;
    Emit.EnderEmit.fone    := RemoveChar(dmPdv.sqEmpresaDDD.AsString + dmPdv.sqEmpresaFONE.AsString);
    Emit.EnderEmit.CEP     := StrToInt(RemoveChar(dmPdv.sqEmpresaCEP.AsString));
    Emit.EnderEmit.xLgr    := dmPdv.sqEmpresaENDERECO.AsString;
    Emit.EnderEmit.nro     := dmPdv.sqEmpresaNUMERO.AsString;
    Emit.EnderEmit.xCpl    := dmPdv.sqEmpresaLOGRADOURO.AsString;
    Emit.EnderEmit.xBairro := dmPdv.sqEmpresaBAIRRO.AsString;
    Emit.EnderEmit.cMun    := StrToInt(RemoveChar(dmPdv.sqEmpresaCD_IBGE.AsString));
    Emit.EnderEmit.xMun    := dmPdv.sqEmpresaCIDADE.AsString;
    Emit.EnderEmit.UF      := dmPdv.sqEmpresaUF.AsString;
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';

    Emit.IEST              := '';


    //case rgRegime.ItemIndex of
    Emit.CRT := crtSimplesNacional;// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)
    //  1: Emit.CRT := crtSimplesExcessoReceita;
    //  2: Emit.CRT := crtRegimeNormal;
    //end;

    if (edCPF.Text <> '   .   .   -  ') then
    begin
      Dest.CNPJCPF := RemoveChar(edCPF.Text);
      Dest.indIEDest := inNaoContribuinte;
      Dest.EnderDest.UF:='SP';
      Dest.EnderDest.cPais := 1058;
    end;

    pegaItens;

    {  TpcnFormaPagamento = (fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito, fpCreditoLoja,
                        fpValeAlimentacao, fpValeRefeicao, fpValePresente, fpValeCombustivel,
                        fpOutro}
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT CODFORMA, COD_VENDA, ID_ENTRADA, FORMA_PGTO' +
    ' , CAIXA , N_DOC, VALOR_PAGO, CAIXINHA, TROCO, DESCONTO, STATE' +
    ' FROM FORMA_ENTRADA WHERE STATE < 2 AND ID_ENTRADA = ' +
    InttoStr(dmPdv.sqLancamentosCODMOVIMENTO.AsInteger);
  dmPdv.sqBusca.Open;

    while not dmPdv.sqBusca.EOF do
    begin
      with pag.Add do
      begin
        tPag := fpCreditoLoja;
        if (dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString = '1') then
          tPag := fpDinheiro
        else if (dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString = '3') then
        begin
          tPag := fpCartaoCredito;
          tpIntegra := tiPagNaoIntegrado;
        end
        else if dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString = '2' then
        begin
          tPag := fpCartaoDebito;
          tpIntegra := tiPagNaoIntegrado;
        end
        else
          tPag := fpOutro;

        vPag := RoundTo(dmPdv.sqBusca.FieldByName('VALOR_PAGO').AsFloat, -2);
      end;
      dmPdv.sqBusca.Next;
    end;



    pegaTributos(dmPdv.sqLancamentosCODMOVIMENTO.AsInteger, 0);
    if (not dmPdv.sqBusca.IsEmpty)  then
    begin
      Total.ICMSTot.vTotTrib:= total_tributos;
      vlr :=  dmPdv.sqBusca.FieldByName('TRIB_EST').AsFloat;
      vlr :=  dmPdv.sqBusca.FieldByName('TRIB_FED').AsFloat;
      tributos := 'Trib aprox R$:' +
        format('%8.2n', [dmPdv.sqBusca.FieldByName('TRIB_FED').AsFloat]) + '-Fed, ' +
        format('%8.2n', [dmPdv.sqBusca.FieldByName('TRIB_EST').AsFloat]) + '-Est e ' +
        format('%8.2n', [dmPdv.sqBusca.FieldByName('TRIB_MUN').AsFloat]) + '-Mun ';
      InfAdic.infCpl := tributos + 'Fonte: IBPT';//Fonte: IBPT/FECOMERCIO RJ Xe67eQ
      // DESCOMENTAR #################################
      //ACBrNFeDANFCeFortes1.FonteTributos := 'Fonte: IBPT';
      //ACBrNFeDANFCeFortes1.vTribFed := dmPdv.sqBusca.FieldByName('TRIB_FED').AsFloat;
      //ACBrNFeDANFCeFortes1.vTribEst := dmPdv.sqBusca.FieldByName('TRIB_EST').AsFloat;
      //ACBrNFeDANFCeFortes1.vTribMun := dmPdv.sqBusca.FieldByName('TRIB_MUN').AsFloat;
      ACBrNFeDANFeESCPOS1.FonteTributos := 'Fonte: IBPT';
      ACBrNFeDANFeESCPOS1.vTribFed := dmPdv.sqBusca.FieldByName('TRIB_FED').AsFloat;
      ACBrNFeDANFeESCPOS1.vTribEst := dmPdv.sqBusca.FieldByName('TRIB_EST').AsFloat;
      ACBrNFeDANFeESCPOS1.vTribMun := dmPdv.sqBusca.FieldByName('TRIB_MUN').AsFloat;
    end;


      Total.ICMSTot.vBC     := 0;
      Total.ICMSTot.vICMS   := 0;
      Total.ICMSTot.vBCST   := 0;
      Total.ICMSTot.vST     := 0;
      Total.ICMSTot.vProd   := RoundTo(nfce_valor,-2); //sqlBuscaNota.fieldByName('VALOR').AsFloat; // totalNFCe;
      Total.ICMSTot.vFrete  := 0;
      Total.ICMSTot.vSeg    := 0;
      Total.ICMSTot.vDesc   := RoundTo(nfce_desconto, -2);
      Total.ICMSTot.vII     := 0;
      Total.ICMSTot.vIPI    := 0;
      Total.ICMSTot.vPIS    := 0;
      Total.ICMSTot.vCOFINS := 0;
      Total.ICMSTot.vOutro  := 0;
      Total.ICMSTot.vNF     := RoundTo((nfce_valor - nfce_desconto),-2); //totalNFCe;

      Total.ISSQNtot.vServ   := 0;
      Total.ISSQNTot.vBC     := 0;
      Total.ISSQNTot.vISS    := 0;
      Total.ISSQNTot.vPIS    := 0;
      Total.ISSQNTot.vCOFINS := 0;



   end;
////
end;

procedure TfNfce.prepararImpressao();
begin
  //imprimir

end;

procedure TfNfce.pegaTributos(codMov: Integer; codProd: Integer);
var pegaTribSql : String;
begin
  pegaTribSql := 'SELECT CODPRODUTO ' +
    ' , TRIB_FED ' +
    ' , TRIB_EST ' +
    ' , TRIB_MUN ' +
    ' , TOT_TRIB_FED ' +
    ' , TOT_TRIB_EST ' +
    ' , TOT_TRIB_MUN ' +
    ' , FONTE ' +
    ' , CHAVE ' +
    ' FROM TOTAL_TRIBUTOS(' +
    IntToStr(codMov) + ')';
  if (codProd > 0) then
  begin
    pegaTribSql := pegaTribSql +
      ' WHERE CODPRODUTO = ' + IntToStr(codProd);
  end;
  if (codProd = 0) then
  begin
    pegaTribSql := 'SELECT ' +
      ' SUM(TRIB_FED) as TRIB_FED ' +
      ' , SUM(TRIB_EST) as TRIB_EST ' +
      ' , SUM(TRIB_MUN) as  TRIB_MUN ' +
      ' FROM TOTAL_TRIBUTOS(' +
      IntToStr(codMov) + ')';
  end;
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := pegaTribSql;
  dmPdv.sqBusca.Open;
  //total_tributos := ;
end;

procedure TfNfce.pegaItens();
var contaItens :integer;
  desc, BC, BCST : variant;
  totalNFCe: Double;
  cod_barra: String;
  desconto_rateio: double;
  ncm_str: String;
begin
  desconto_rateio := 0;
  totalNFCe := 0;
  ACBrNFe1.NotasFiscais.Items[0].nfe.Det.Clear;
  with ACBrNFe1.NotasFiscais.Items[0].NFe do
  begin
    with Transp do
    begin
      modFrete := mfSemFrete;
    end;
    //Adicionando Produtos
    contaItens := 0;
    dmPdv.sqLancamentos.First;
    total_tributos := 0;
    while not dmPdv.sqLancamentos.Eof do
    begin
      totalNFCe := totalNFCe + dmPdv.sqLancamentosTOTALITEM.AsFloat;
      contaItens := contaItens + 1;
      with Det.Add do
      begin
        Prod.nItem    := contaItens; // Número sequencial, para cada item deve ser incrementado
        Prod.cProd    := dmPdv.sqLancamentosCODPRO.AsString;
        //Prod.cEAN     := '7896523206646';
        Prod.xProd    := LeftStr(dmPdv.sqLancamentosDESCPRODUTO.AsString, 99);
        Prod.CFOP     := dmPdv.sqLancamentosCFOP.AsString;
        Prod.uCom     := dmPdv.sqLancamentosUNIDADEMEDIDA.AsString;
        Prod.qCom     := dmPdv.sqLancamentosQUANTIDADE.AsFloat;
        Prod.vUnCom   := dmPdv.sqLancamentosPRECO.AsFloat;
        Prod.uTrib    := dmPdv.sqLancamentosUNIDADEMEDIDA.AsString;
        Prod.qTrib    := dmPdv.sqLancamentosQUANTIDADE.AsFloat;
        Prod.vUnTrib  := dmPdv.sqLancamentosPRECO.AsFloat;

        ncm_str := dmPdv.sqLancamentosNCM.AsString;
        ncm_str  := StringReplace(ncm_str,'.','',[rfReplaceAll]);
        if Length(ncm_str) < 8then
           ncm_str := '00000000';
        Prod.NCM      := ncm_str;
        Prod.EXTIPI   := '';

        // TODO instalar VALIDADDOR
        cod_barra := dmPdv.sqLancamentosCOD_BARRA.AsString;
        ACBrValidador1.Documento := cod_barra;
        ACBrValidador1.TipoDocto := docGTIN;
        if not ACBrValidador1.Validar then
          cod_barra := 'SEM GTIN';
        ACBrValidador1.TipoDocto := docPrefixoGTIN;
        if not ACBrValidador1.Validar then
          cod_barra := 'SEM GTIN';
        Prod.cEAN := cod_barra;
        Prod.cEANTrib := cod_barra;
        desc := StrLen(PChar(MidStr(dmPdv.sqLancamentosDESCPRODUTO.AsString, 100, 200)));
        if ( desc > 0) then
          infAdProd     := MidStr(dmPdv.sqLancamentosDESCPRODUTO.AsString, 100, 200)  +
                           dmPdv.sqLancamentosOBS.AsString
        else
          infAdProd     := dmPdv.sqLancamentosOBS.AsString;

        Prod.vProd    := dmPdv.sqLancamentosTOTALITEM.AsFloat;
        Prod.vFrete   := 0 ; //dmPdv.sqLancamentosFRETE.AsCurrency;
        Prod.vDesc    := dmPdv.sqLancamentosVALOR_DESCONTO.AsCurrency;
        if nfce_desconto > 0 then
        begin
          desconto_rateio := nfce_desconto/nfce_valor;
          desconto_rateio := dmPdv.sqLancamentosTOTALITEM.AsFloat * desconto_rateio;
          Prod.vDesc      := RoundTo(desconto_rateio, -2);
        end;

        Prod.vOutro   := dmPdv.sqLancamentosVALOR_OUTROS.AsCurrency;
        Prod.vSeg     := dmPdv.sqLancamentosVALOR_SEGURO.AsCurrency;

        with Imposto do
        begin
          // lei da transparencia nos impostos
          vTotTrib := RoundTo(dmPdv.sqLancamentosVLRTOT_TRIB.AsFloat,-2);
          total_tributos:= total_tributos + RoundTo(dmPdv.sqLancamentosVLRTOT_TRIB.AsFloat,-2);
          // ***********************  ICMS ********************************
          with ICMS do
          begin
            if (dmPdv.sqLancamentosORIGEM.IsNull) then
            begin
              MessageDlg('Origem do Produto(CADASTRO PRODUTO) não informado, Cod. Prod: ' +
                          dmPdv.sqLancamentosCODPRO.AsString, mtError, [mbOK], 0);
              //exit;
            end;

            if( dmPdv.sqEmpresaCRT.AsInteger = 0) then
            begin
              if ((dmPdv.sqLancamentosCSOSN.AsString = null) or ( dmPdv.sqLancamentosCSOSN.AsString = '')) then
              begin
                CSOSN := csosnVazio;
              end
              else if (dmPdv.sqLancamentosCSOSN.AsString = '101') then
              begin
                CSOSN := csosn101;
                if (ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional ) then
                begin
                  if (dmPdv.sqLancamentosICMS.AsVariant > 0 ) then
                  begin
                    pCredSN := dmPdv.sqLancamentosICMS.AsVariant; //Aliquota ICMS SIMPLES
                    vCredICMSSN := dmPdv.sqLancamentosVALOR_ICMS.AsVariant; //ICMS SIMPLES
                  end;
                end;
              end
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '102') then
                CSOSN := csosn102
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '103') then
                CSOSN := csosn103
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '201') then
              begin
                CSOSN := csosn201;
                if (ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional ) then
                begin
                  if (dmPdv.sqLancamentosICMS.AsVariant > 0 ) then
                  begin
                    pCredSN := dmPdv.sqLancamentosICMS.AsVariant; //Aliquota ICMS SIMPLES
                    vCredICMSSN := dmPdv.sqLancamentosVALOR_ICMS.AsVariant; //ICMS SIMPLES
                  end;
                end;
              end
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '202') then
                CSOSN := csosn202
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '203') then
                CSOSN := csosn203
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '300') then
                CSOSN := csosn300
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '400') then
                CSOSN := csosn400
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '500') then
                CSOSN := csosn500
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '900') then
                CSOSN := csosn900;
            end; // CRT = 0

            // CST's

            if ((Trim(dmPdv.sqLancamentosCST.AsString) = '') and (Trim(dmPdv.sqLancamentosCSOSN.AsString) = '')) then
            begin
              if ((Trim(dmPdv.sqLancamentosCSOSN.AsString) = '') or (Trim(dmPdv.sqLancamentosCSOSN.AsString) = '0')) then
                MessageDlg('CST do ICMS em branco no item ' + dmPdv.sqLancamentosDESCPRODUTO.AsString, mtWarning, [mbOK], 0);
              Exit;
            end
            else
            begin
              if ((dmPdv.sqLancamentosCST.AsString = '000') or (dmPdv.sqLancamentosCST.AsString = '100') or (dmPdv.sqLancamentosCST.AsString = '200') or (dmPdv.sqLancamentosCST.AsString = '00')) then
                CST := cst00
              else if ((dmPdv.sqLancamentosCST.AsString = '010') or (dmPdv.sqLancamentosCST.AsString = '110') or (dmPdv.sqLancamentosCST.AsString = '210') or (dmPdv.sqLancamentosCST.AsString = '10')) then
                CST := cst10
              else if ((dmPdv.sqLancamentosCST.AsString = '020') or (dmPdv.sqLancamentosCST.AsString = '120') or (dmPdv.sqLancamentosCST.AsString = '220') or (dmPdv.sqLancamentosCST.AsString = '20')) then
                CST := cst20
              else if ((dmPdv.sqLancamentosCST.AsString = '030') or (dmPdv.sqLancamentosCST.AsString = '130') or (dmPdv.sqLancamentosCST.AsString = '230') or (dmPdv.sqLancamentosCST.AsString = '30')) then
                CST := cst30
              else if ((dmPdv.sqLancamentosCST.AsString = '040') or (dmPdv.sqLancamentosCST.AsString = '140') or (dmPdv.sqLancamentosCST.AsString = '240') or (dmPdv.sqLancamentosCST.AsString = '40')) then
                CST :=  cst40
              else if ((dmPdv.sqLancamentosCST.AsString = '041') or (dmPdv.sqLancamentosCST.AsString = '141') or (dmPdv.sqLancamentosCST.AsString = '241') or (dmPdv.sqLancamentosCST.AsString = '41')) then
                CST :=  cst41
              else if ((dmPdv.sqLancamentosCST.AsString = '050') or (dmPdv.sqLancamentosCST.AsString = '150') or (dmPdv.sqLancamentosCST.AsString = '250') or (dmPdv.sqLancamentosCST.AsString = '50')) then
                CST :=  cst50
              else if ((dmPdv.sqLancamentosCST.AsString = '051') or (dmPdv.sqLancamentosCST.AsString = '151') or (dmPdv.sqLancamentosCST.AsString = '251') or (dmPdv.sqLancamentosCST.AsString = '51')) then
                CST := cst51
              else if ((dmPdv.sqLancamentosCST.AsString = '060') or (dmPdv.sqLancamentosCST.AsString = '160') or (dmPdv.sqLancamentosCST.AsString = '260') or (dmPdv.sqLancamentosCST.AsString = '60')) then
                CST := cst60
              else if ((dmPdv.sqLancamentosCST.AsString = '070') or (dmPdv.sqLancamentosCST.AsString = '170') or (dmPdv.sqLancamentosCST.AsString = '270') or (dmPdv.sqLancamentosCST.AsString = '70')) then
                CST := cst70
              else if ((dmPdv.sqLancamentosCST.AsString = '090') or (dmPdv.sqLancamentosCST.AsString = '190') or (dmPdv.sqLancamentosCST.AsString = '290') or (dmPdv.sqLancamentosCST.AsString = '90')) then
                CST := cst90
              else
                CST := cst00;
            end;

            if dmPdv.sqLancamentosORIGEM.AsString = '0' then
              orig  := oeNacional                       //ORIGEM DO PRODUTO
            else if dmPdv.sqLancamentosORIGEM.AsString = '1' then
              orig  := oeEstrangeiraAdquiridaBrasil
            else
              orig  := oeEstrangeiraImportacaoDireta;
            modBC := BC;                                              //MODO DE BASE DE CALCULO (0) POR %
            //Não carregar ICMS para Simples Nacional
            if not ((ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional) and (dmPdv.sqLancamentosCSOSN.AsString <> '900')) then
            begin
              vBC := dmPdv.sqLancamentosVLR_BASEICMS.AsVariant;                //VALOR DA BASE DE CALCULO
              pICMS := dmPdv.sqLancamentosICMS.AsVariant;                     //ALIQUOTA DO ICMS
              vICMS := dmPdv.sqLancamentosVALOR_ICMS.AsVariant;                  //VALOR DO ICMS
            end;
            modBCST :=  BCST;                                         //MODO DE BASE DE CALCULO SUBST. TRIBUTÁRIA(4) POR %
            vBCST := 0;
            if (not dmPdv.sqLancamentosICMS_SUBST.IsNull) then
              vBCST :=    dmPdv.sqLancamentosICMS_SUBST.AsVariant;                 //VALOR DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA

            if (dmPdv.sqLancamentosCFOP.AsString <> '') then
            begin
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pMVAST := 0
              else
                pMVAST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                //% MARGEM DE VALOR ADICIONADO DO ICMSST
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pRedBCST := 0
              else
                pRedBCST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                 //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pICMSST := 0
              else
                pICMSST :=  dmPdv.sqLancamentosICMS_SUBST.AsVariant;                    //ALIQUOTA DO ICMS DA SUBST. TRIBUTÁRIA
            end
            else begin
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pMVAST := 0
              else
                pMVAST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                //% MARGEM DE VALOR ADICIONADO DO ICMSST
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pRedBCST := 0
              else
                pRedBCST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                 //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pICMSST := 0
              else
                pICMSST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                    //ALIQUOTA DO ICMS DA SUBST. TRIBUTÁRIA
            end;

            //if (sCFOPREDUCAO.IsNull) then
            pRedBC := 0;
            //else
            //  pRedBC :=   sCFOPREDUCAO.AsVariant;                          //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO
            if (dmPdv.sqLancamentosICMS_SUBST.isnull) then
              vICMSST := 0
            else
              vICMSST :=  dmPdv.sqLancamentosICMS_SUBST.AsVariant;                  //VALOR DO ICMS DA SUBST. TRIBUTÁRIA
          end;
          //ICMS.orig    := oeNacional;
          //ICMS.modBC   := dbiValorOperacao;
          //ICMS.modBCST := dbisMargemValorAgregado;

          // ***********************  FIM ICMS ********************************

          // ***********************  PIS ********************************
          with PIS do
          begin
            CST      := pis99;
            PIS.vBC  := 0;
            PIS.pPIS := 0;
            PIS.vPIS := 0;

            PIS.qBCProd   := 0;
            PIS.vAliqProd := 0;
            PIS.vPIS      := 0;
          end;
          // ***********************  FIM PIS ********************************
          with PISST do
          begin
            vBc       := 0;
            pPis      := 0;
            qBCProd   := 0;
            vAliqProd := 0;
            vPIS      := 0;
          end;

          with COFINS do
          begin
            CST            := cof99;
            COFINS.vBC     := 0;
            COFINS.pCOFINS := 0;
            COFINS.vCOFINS := 0;
            COFINS.qBCProd   := 0;
            COFINS.vAliqProd := 0;
          end;

          with COFINSST do
          begin
            vBC       := 0;
            pCOFINS   := 0;
            qBCProd   := 0;
            vAliqProd := 0;
            vCOFINS   := 0;
          end;

        end;
      end; // fim add item
      dmPdv.sqLancamentos.Next;
    end; // fim do while

  end;


end;

procedure TfNfce.AtualizaSSLLibsCombo;
begin
  cbSSLLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLLib );
  cbCryptLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLCryptLib );
  cbHttpLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLHttpLib );
  cbXmlSignLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLXmlSignLib );
end;

procedure TfNfce.GravarDadosNF(protocolo: String; recibo: String);
var str: String;
begin
  try
    str := 'UPDATE SERIES SET ULTIMO_NUMERO = ' + IntToSTR(num_nfce) +
      ' WHERE SERIE = ' + QuotedStr('NFCE-'+dmPdv.varLogado);
    dmPdv.IbCon.ExecuteDirect(str);
    str := 'UPDATE VENDA SET ';
    str := str + ' XMLNFE = ' + quotedStr(ACBrNFe1.NotasFiscais.Items[0].XML);
    str := str + ', NOMEXML = ' + QuotedStr(copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
      (length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml');
    str := str + ', NOTAFISCAL = ' + IntToStr(num_nfce);
    str := str + ', SERIE = ' + QuotedStr('NFCE-'+dmPdv.varLogado);
    if (Protocolo <> '') then
      str := str + ', PROTOCOLOENV = ' + quotedStr(Protocolo);
    if (Recibo <> '') then
      str := str + ', NUMRECIBO = ' + QuotedStr(Recibo);
    str := str + ' WHERE CODVENDA = ' + IntToStr(nfce_codVenda);
    dmPdv.IbCon.ExecuteDirect(str);
    dmPdv.sTrans.Commit;
  except
    on E : Exception do
    begin
      ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
      dmPdv.sTrans.Rollback; //on failure, undo the changes}
    end;
  end;

end;

procedure TfNfce.BitBtn1Click(Sender: TObject);
var
  I: Integer;
begin
  //edCertificado.Text := ACBrNFe1.SSL.SelecionarCertificado;
    frSelecionarCertificado := TfrSelecionarCertificado.Create(Self);
    try
      ACBrNFe1.SSL.LerCertificadosStore;

      For I := 0 to ACBrNFe1.SSL.ListaCertificados.Count-1 do
      begin
        with ACBrNFe1.SSL.ListaCertificados[I] do
        begin
          if (CNPJ <> '') then
          begin
            with frSelecionarCertificado.StringGrid1 do
            begin
              RowCount := RowCount + 1;
              Cells[ 0, RowCount-1] := NumeroSerie;
              Cells[ 1, RowCount-1] := RazaoSocial;
              Cells[ 2, RowCount-1] := CNPJ;
              Cells[ 3, RowCount-1] := FormatDateBr(DataVenc);
              Cells[ 4, RowCount-1] := Certificadora;
            end;
          end;
        end;
      end;

      frSelecionarCertificado.ShowModal;

      if frSelecionarCertificado.ModalResult = mrOK then
      begin
        edtNumSerie.Text := frSelecionarCertificado.StringGrid1.Cells[ 0,
                              frSelecionarCertificado.StringGrid1.Row];
        edCertificado.Text := edtNumSerie.Text;
      end;
    finally
       frSelecionarCertificado.Free;
    end;

end;

procedure TfNfce.BitBtn2Click(Sender: TObject);
var
 Ini : TIniFile;
begin
  Ini := TIniFile.Create(dmPdv.path_exe + 'conf.ini');;
  try
    Ini.WriteString( 'Certificado','NumSerie',edtNumSerie.Text);
    Ini.WriteString( 'Certificado','Caminho' ,edtCaminho.Text);
    Ini.WriteString( 'Certificado','Senha'   ,edtSenha.Text);

    Ini.WriteInteger( 'Certificado','SSLLib' , cbSSLLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','CryptLib' , cbCryptLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','HttpLib' , cbHttpLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','XmlSignLib' , cbXmlSignLib.ItemIndex) ;
    Ini.WriteInteger( 'IMPRESSORA','Modelo' , cbxModeloPosPrinter.ItemIndex) ;
  finally
    Ini.Free;
  end;
end;

procedure TfNfce.BitBtn3Click(Sender: TObject);
begin
  if (edCPF.Text = '   .   .   -  ') then
  begin
    //if MessageDlg('DESEJA CPF NA NOTA ?', mtConfirmation,
    //  [mbYes, mbNo, mbIgnore],0) = mrYes then
    begin
      edCPF.SetFocus;
      Exit;
    end;
  end;
  btnNFce.Click;
end;

procedure TfNfce.BitBtn4Click(Sender: TObject);
begin
  btnNFce.Click;
end;

procedure TfNfce.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfNfce.btnNFce1Click(Sender: TObject);
//var carregarMais : Boolean;
begin
  //carregarMais := true;
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;

  ACBrNFe1.NotasFiscais.Clear;
  //while carregarMais  do
  begin
    if OpenDialog1.Execute then
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName,False);
    //carregarMais := MessageDlg('Carregar mais XML?', mtConfirmation, mbYesNo,0)= mrYes;
  end;

  if ACBrNFe1.NotasFiscais.Count > 0 then
     ACBrNFe1.NotasFiscais.Imprimir;

end;

procedure TfNfce.btnNFce2Click(Sender: TObject);
var
   vChave : String;
  vAux, vNumLote, vSincrono : String;
 Sincrono : boolean;
 Protocolo, Recibo: String;
 str: String;
 ambiente: String;
begin
  //if not(InputQuery('WebServices Consultar', 'Chave da NF-e:', vChave)) then
  //  exit;

  //ACBrNFe1.NotasFiscais.Clear;
  //ACBrNFe1.WebServices.Consulta.NFeChave := vChave;
  //ACBrNFe1.WebServices.Consulta.Executar;

  //MemoResp.Lines.Text := ACBrNFe1.WebServices.Consulta.RetWS;
  //memoRespWS.Lines.Text := ACBrNFe1.WebServices.Consulta.RetornoWS;
  //LoadXML(MemoResp, WBResposta);
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFe1.Consultar;

    if ACBrNFe1.WebServices.Consulta.Protocolo <> '' then
    begin
      ShowMessage(ACBrNFe1.WebServices.Consulta.Protocolo);
      Protocolo := ACBrNFe1.WebServices.Consulta.Protocolo;
      Recibo := 'recibo';//ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe. .WebServices.Consulta.Recibo;
    end;
    //MemoResp.Lines.Text := ACBrNFe1.WebServices.Consulta.RetWS;
    //memoRespWS.Lines.Text := ACBrNFe1.WebServices.Consulta.RetornoWS;
    //LoadXML(MemoResp, WBResposta);
  end;

end;

procedure TfNfce.ACBrNFe1AntesDeAssinar(var ConteudoXML: String;
  const docElement, infElement, SignatureNode, SelectionNamespaces,
  IdSignature: String);
begin

end;

procedure TfNfce.acFecharExecute(Sender: TObject);
begin
  Close;
end;

end.

