unit uNfce;

{$mode objfpc}{$H+}

interface

uses
  Classes, typinfo, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  MaskEdit, Buttons, StdCtrls, ExtCtrls, ComCtrls, Menus, ActnList, udmpdv,
  uCertificadoLer, ufrmStatus, ACBrNFe, ACBrNFeDANFeESCPOS, ACBrDANFCeFortesFr,
  pcnConversao, pcnConversaoNFe, ACBrDFeSSL, ACBrPosPrinter, ACBrIntegrador,
  ACBrValidador, ACBrEnterTab, ACBrUtil, ACBrSAT, StrUtils, IniFiles, math,
  ACBrSATClass, ACBrSATExtratoESCPOS, dateutils, ACBrBase, ACBrDFe, ACBrDFeUtil;

type

  { TfNfce }

  TfNfce = class(TForm)
    ACBrEnterTab1: TACBrEnterTab;
    ACBrIntegrador1: TACBrIntegrador;
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFeESCPOS1: TACBrNFeDANFeESCPOS;
    ACBrPosPrinter1: TACBrPosPrinter;
    ACBrSAT1: TACBrSAT;
    ACBrSATExtratoESCPOS1: TACBrSATExtratoESCPOS;
    ACBrValidador1: TACBrValidador;
    acFechar: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    btnFechar: TBitBtn;
    btnNFce: TBitBtn;
    btnNFce1: TBitBtn;
    btnNFce2: TBitBtn;
    btnNFce3: TBitBtn;
    btnNFce4: TBitBtn;
    btnNFce5: TBitBtn;
    btnNFce6: TBitBtn;
    btnNFce7: TBitBtn;
    btnNFce8: TBitBtn;
    cbCryptLib: TComboBox;
    cbHttpLib: TComboBox;
    cbSSLLib: TComboBox;
    cbXmlSignLib: TComboBox;
    cbxModeloPosPrinter: TComboBox;
    edAno: TEdit;
    edCancelamentoMotivo: TEdit;
    edModelo: TEdit;
    edJustificativa: TEdit;
    edSerie: TEdit;
    edNumIni: TEdit;
    edNumFim: TEdit;
    edtCaminho: TLabeledEdit;
    edtNumSerie: TLabeledEdit;
    edtSenha: TLabeledEdit;
    edCPF: TMaskEdit;
    edCertificado: TLabeledEdit;
    edNFce: TLabeledEdit;
    Label1: TLabel;
    Label10: TLabel;
    lblCancelamento2: TLabel;
    lblCancelamento: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblcbCryptLib: TLabel;
    lblcbSSLLib: TLabel;
    lblProtocolo: TLabel;
    memoLog: TMemo;
    MemoDados: TMemo;
    MemoResp: TMemo;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    pnCancelamento: TPanel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    rgAmbiente: TRadioGroup;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    procedure ACBrNFe1AntesDeAssinar(var ConteudoXML: String; const docElement,
      infElement, SignatureNode, SelectionNamespaces, IdSignature: String);
    procedure ACBrNFe1GerarLog(const ALogLine: String; var Tratado: Boolean);
    procedure ACBrNFe1StatusChange(Sender: TObject);
    procedure ACBrNFe1TransmitError(const HttpError, InternalError: Integer;
      const URL, DadosEnviados, SoapAction: String; var Retentar: Boolean;
      var Tratado: Boolean);
    procedure ACBrSAT1GetcodigoDeAtivacao(var Chave: AnsiString);
    procedure ACBrSAT1GetsignAC(var Chave: AnsiString);
    procedure acFecharExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNFce1Click(Sender: TObject);
    procedure btnNFce2Click(Sender: TObject);
    procedure btnNFce3Click(Sender: TObject);
    procedure btnNFce4Click(Sender: TObject);
    procedure btnNFce5Click(Sender: TObject);
    procedure btnNFce6Click(Sender: TObject);
    procedure btnNFce7Click(Sender: TObject);
    procedure btnNFce8Click(Sender: TObject);
    procedure btnNFceClick(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure edCPFKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
  private
    //ACBrNFe1 : TACBrNFe;
    total_tributos: Double;
    serie_nfce: Integer;
    num_nfce: Integer;
    notaEmitida: String;
    vBC : Double;
    vICMS: Double;
    sat_ativacao: String;
    sat_assinatura: String;
    nomeXml : String;
    function RemoveChar(Const Texto:String):String;
    function validaCpfCnpj():Boolean;
    procedure GerarNFCe(Num: String);
    procedure prepararImpressao();
    procedure pegaTributos(codMov: Integer; codProd: Integer);
    procedure pegaItens();
    procedure AtualizaSSLLibsCombo;
    procedure GravarDadosNF(protocolo: String; recibo: String);
    procedure gerarSat();
    procedure gerarLog(const ALogLine: String; var Tratado: Boolean);
    procedure TrataErros(Sender: TObject; E: Exception);
    procedure carregaAcbr;
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
 ver_var: String;
begin
  if (dmPdv.NfceSat = 'SAT') then
  begin
    memoLog.Lines.Add('Gerando SAT');
    gerarSat();
    exit;
  end;
  memoLog.Lines.Add('Gerando NFCe');
  ACBrNFe1.NotasFiscais.Clear;
  if (notaEmitida = 'S') then
  begin
    ShowMessage('Nota Fiscal já emitida.');
    Exit;
  end;
  memoLog.Lines.Add('Carregando certificado(se parar deve estar pedindo permissao)');
  carregaAcbr;
  memoLog.Lines.Add('Certificado carregado');
  if (dmPdv.tk = '') then
  begin
    ShowMessage('Cadastre: '+#13+#10+''+#13+#10+'Natureza Operação : 30 ' +
      'para Nota Fiscal Consumidor;'+#13+#10+''+#13+#10+'Série :' +
      'para ser usada na NFCe;'+#13+#10+''+#13+#10+'Parametro: ' +
      'SERIENFCe com a série criada no campo D1.');
    exit;
  end;

  if (validaCpfCnpj() = False) then
    exit;

  if (edCertificado.Text = '') then
  begin
    MessageDlg('Informe o certificado.',mtError,[mbok],0);
    exit;
  end;

  vAux := edNFCe.Text;
  memoLog.Lines.Add('NFCe-' + edNFce.Text);
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

  ACBrNFe1.DANFE := ACBrNFeDANFeESCPOS1;

  //ACBrNFe1.Configuracoes.Geral.SSLLib := libCapicom;
  try
  memoLog.Lines.Add('Gerando XML');
  GerarNFCe(vAux);
  memoLog.Lines.Add('Assinando XML');
  ACBrNFe1.NotasFiscais.Assinar;
  //ACBrNFe1.NotasFiscais.GravarXML(AcbrNfe1.Configuracoes.Arquivos.PathSalvar);

  // Gravando a nota aqui pois se der erro no validar ja gravei
  GravarDadosNF('', '');
  // estou pegando o ultimo numero usado em venda pra nao pular
  memoLog.Lines.Add('Gravando XML');
  //ACBrNFe1.NotasFiscais.Items[0].GravarXML();
  ACBrNFe1.NotasFiscais.GravarXML();
  memoLog.Lines.Add('Validando');
  ACBrNFe1.NotasFiscais.Validar;
  //LoadXML(ACBrNFe1.NotasFiscais.Items[0].XML,  mRecebido);

  // TODO
  //prepararImpressao();
  //ACBrNFe1.DANFE := ACBrNFeDANFCeFortes1;

  //ACBrNFe1.DANFE.TipoDANFE := tiNFCeA4;
  if (dmPdv.NFE_Teste = 'N') then
  begin
    memoLog.Lines.Add('Enviando ...');
    ACBrNFe1.Enviar(vNumLote,True,Sincrono);
    memoLog.Lines.Add('cStat : ' + IntToStr(ACBrNFe1.WebServices.Retorno.cStat));
    if (ACBrNFe1.WebServices.Retorno.cStat = 100) then
    begin
      Protocolo := ACBrNFe1.WebServices.Retorno.Protocolo;
      Recibo := ACBrNFe1.WebServices.Retorno.Recibo;
      GravarDadosNF(protocolo, recibo);
    end;
  end;
  Except
    on E:Exception do
    begin
      ver_var := IntToStr(ACBrNFe1.WebServices.Retorno.cStat);
      ShowMessage('Erro para Enviar a NFCe, erro : ' + ver_var + ' MSG : ' + e.Message);
    end;
  end;

    {
    if ((ACBrNFe1.WebServices.Retorno.cStat = 204)
      or (ACBrNFe1.WebServices.Retorno.cStat = 539)) then
    begin
      Recibo := ACBrNFe1.WebServices.Retorno.Recibo;
      memoLog.Lines.Add('Recibo : ' + recibo);
      memoLog.Lines.Add('Chave : ' + recibo);
      Protocolo := ACBrNFe1.WebServices.Retorno.ChaveNFe;
      memoLog.Lines.Add('Deu erro de Duplicidade, executando consulta pela chave');
      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.WebServices.Consulta.NFeChave := Protocolo;
      ACBrNFe1.WebServices.Consulta.Executar;
      memoLog.Lines.Add('cStat consulta Chave : ' + IntToStr(ACBrNFe1.WebServices.Consulta.cStat));
      if (ACBrNFe1.WebServices.Consulta.cStat = 100) then
      begin
        memoLog.Lines.Add('NFe Localizada , gravando ...');
        Protocolo := ACBrNFe1.WebServices.Consulta.Protocolo;
        GravarDadosNF(protocolo, recibo);
        Exit;
      end;
      memoLog.Lines.Add('Nao encontrou enviando novamente ...');
      ACBrNFe1.NotasFiscais.Clear;
      carregaAcbr;
      GerarNFCe(vAux);
      num_nfce := num_nfce+1;
      edNFce.Text:=IntToStr(num_nfce);
      with ACBrNFe1.NotasFiscais.Add.NFe do
      begin
        Ide.cNF       := num_nfce;
        Ide.nNF       := num_nfce;
      end;
      memoLog.Lines.Add('Assinando XML');
      ACBrNFe1.NotasFiscais.Assinar;
      memoLog.Lines.Add('Gravando XML');
      ACBrNFe1.NotasFiscais.GravarXML();
      memoLog.Lines.Add('Validando');
      ACBrNFe1.NotasFiscais.Validar;
      memoLog.Lines.Add('Enviando ...');
      ACBrNFe1.Enviar(vNumLote,True,Sincrono);
      memoLog.Lines.Add('cStat Re envio : ' + IntToStr(ACBrNFe1.WebServices.Retorno.cStat));
      if (ACBrNFe1.WebServices.Retorno.cStat = 100) then
      begin
        Protocolo := ACBrNFe1.WebServices.Retorno.Protocolo;
        Recibo := ACBrNFe1.WebServices.Retorno.Recibo;
        GravarDadosNF(protocolo, recibo);
      end;
    end;
  end; }

  MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.Retorno.RetWS);
  MemoDados.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.Retorno.RetornoWS);

  memoLog.Lines.Add('');
  memoLog.Lines.Add('Envio NFe');
  memoLog.Lines.Add('tpAmb: '+ TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb));
  memoLog.Lines.Add('verAplic: '+ ACBrNFe1.WebServices.Retorno.verAplic);
  memoLog.Lines.Add('cStat: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cStat));
  memoLog.Lines.Add('cUF: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cUF));
  memoLog.Lines.Add('xMotivo: '+ ACBrNFe1.WebServices.Retorno.xMotivo);
  memoLog.Lines.Add('cMsg: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cMsg));
  memoLog.Lines.Add('xMsg: '+ ACBrNFe1.WebServices.Retorno.xMsg);
  memoLog.Lines.Add('Recibo: '+ ACBrNFe1.WebServices.Retorno.Recibo);
  memoLog.Lines.Add('Protocolo: '+ ACBrNFe1.WebServices.Retorno.Protocolo);

  ShowMessage('Nº do Protocolo de envio ' + ACBrNFe1.WebServices.Retorno.Protocolo);
  ShowMessage('Nº do Recibo de envio ' + ACBrNFe1.WebServices.Retorno.Recibo);

  //LoadXML(ACBrNFe1.NotasFiscais.Items[0].XML,  mRecebido);
  //ACBrNFe1.NotasFiscais.Imprimir;
  memoLog.Lines.Add('Enviado gravando retorno');
  memoLog.Lines.Add('');
  memoLog.Lines.Add('Nota Fiscal Consumidor, gerada com sucesso.');
  memoLog.Lines.Add('');
  //Application.ProcessMessages;
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
  //ACBrNFe1 := TACBrNFe.Create(ACBrNFe1);

  //ACBrNFe1.OnTransmitError := ACBrNFe1TransmitError;
  //ACBrNFe1.OnStatusChange := ACBrNFe1StatusChange;
  //ACBrNFe1.OnGerarLog := ACBrNFe1GerarLog;
  //ACBrNFe1.OnAntesDeAssinar := ACBrNFe1AntesDeAssinar;
  {
  ACBrNFe1.Configuracoes.Geral.SSLLib := libCustom;
  ACBrNFe1.Configuracoes.Geral.SSLCryptLib := cryCapicom;
  ACBrNFe1.Configuracoes.Geral.SSLHttpLib := httpNone;
  ACBrNFe1.Configuracoes.Geral.SSLXmlSignLib := xsNone;
  ACBrNFe1.Configuracoes.Geral.FormatoAlerta := 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.';
  ACBrNFe1.Configuracoes.Geral.ModeloDF := moNFCe;
  ACBrNFe1.Configuracoes.Geral.VersaoDF := ve400;
  ACBrNFe1.Configuracoes.Geral.VersaoQRCode := veqr200;
  ACBrNFe1.Configuracoes.Arquivos.SepararPorMes := True;
  ACBrNFe1.Configuracoes.Arquivos.SalvarApenasNFeProcessadas := True;
  ACBrNFe1.Configuracoes.WebServices.UF := 'SP';
  ACBrNFe1.Configuracoes.WebServices.Ambiente := taProducao;
  ACBrNFe1.Configuracoes.WebServices.AguardarConsultaRet := 0;
  ACBrNFe1.Configuracoes.WebServices.QuebradeLinha := '|';
  }

  //ACBrNfe1.OnAntesDeAssinar:=ACBrNFe1AntesDeAssinar(ConteudoXML, docElement,
  //    infElement, SignatureNode, SelectionNamespaces, IdSignature);
  //ACBrNfe1.OnGerarLog:=ACBrNFe1GerarLog;
  //ACBrNFe1.OnStatusChange:=ACBrNFe1StatusChange;
  //ACBrNFe1.OnTransmitError:=ACBrNFe1TransmitError;

  //ACBrNFeDANFeESCPOS1 := TACBrNFeDANFeESCPOS.Create(nil);
  //ACBrNFeDANFCeFortes1 := TACBrNFeDANFCeFortes.Create(nil);
  {if (not DirectoryExists(dmPdv.path_exe + '\input')) then
  begin
    CreateDir(dmPdv.path_exe + '\input');
    CreateDir(dmPdv.path_exe + '\output');
  end;
  ACBrIntegrador1.PastaInput := dmPdv.path_exe + '\input';
  ACBrIntegrador1.PastaOutput := dmPdv.path_exe + '\output';}
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
  edCertificado.Text := dmPdv.NumSerieCert;

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
  Application.OnException := @TrataErros ;
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
  if (dmPdv.sqEmpresa.Active) then
   dmPdv.sqEmpresa.Close;
  ////dmPdv.sqEmpresa.Params[0].AsInteger := dm.CCustoPadrao; //Buscar de parametro
  dmPdv.sqEmpresa.Open;
  StatusBar1.Panels[0].Text := 'NFCe HOMOLOGACAO';
  if (Trim(dmPdv.sqEmpresaTIPO.AsString) = '1') then
    StatusBar1.Panels[0].Text := 'NFCe PRODUCAO';
  //ACBrNFe1.Integrador := ACBrIntegrador1;
  if(dmPdv.sqEmpresaTIPO.AsInteger = 1 ) then
  begin
    rgAmbiente.ItemIndex := 0;
  end
  else begin
    rgAmbiente.ItemIndex := 1;
  end;
  ACBrNFeDANFeESCPOS1.ACBrNFe := ACBrNFe1;
  ACBrNFeDANFeESCPOS1.PosPrinter := ACBrPosPrinter1;
  ACBrPosPrinter1.Porta := dmPdv.portaImp;
  ACBrPosPrinter1.Modelo:= TACBrPosPrinterModelo(cbxModeloPosPrinter.ItemIndex);
  ACBrPosPrinter1.LinhasEntreCupons := dmPdv.espacoEntreLinhas;
  if (cbxModeloPosPrinter.ItemIndex = 4) then
  begin
    ACBrPosPrinter1.ConfigQRCode.LarguraModulo:=3;
  end;
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
    nomeXml := dmPdv.sqBusca.Fields[2].AsString;
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

procedure TfNfce.RadioGroup2Click(Sender: TObject);
begin
  if RadioGroup2.ItemIndex = 0 then
  begin
    edCPF.EditMask := '999.999.999-99;1;_'
  end;
  if RadioGroup2.ItemIndex = 1 then
  begin
    edCPF.EditMask := '99.999.999/9999-99;1;_'
  end;

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

function TfNfce.validaCpfCnpj(): Boolean;
begin
  if ((edCPF.Text <> '   .   .   -  ') and  (Length(edCPF.Text) = 14)) then
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
      result := False;
    end
    else begin
      edCPF.Font.Color := clBlack;
    end;
  end;
  if ((edCPF.Text <> '  .   .   /   -  ') and  (Length(edCPF.Text) > 14)) then
  begin
    ACBrValidador1.PermiteVazio:=True;
    ACBrValidador1.TipoDocto:= docCNPJ;
    ACBrValidador1.IgnorarChar:='./-';
    ACBrValidador1.Documento:=edCPF.Text;
    if not ACBrValidador1.Validar then
    begin
      edCPF.Font.Color:=clRed;
      ShowMessage('CNPJ Inválido');
      edCPF.SetFocus;
      result := False;
    end
    else begin
      edCPF.Font.Color := clBlack;
    end;
  end;
  result := True;
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
  dmPdv.busca_sql('SELECT MAX(NOTAFISCAL) AS NUM ' +
    ' FROM VENDA WHERE SERIE = ' + QuotedStr('NFCE-'+dmPdv.varLogado));
  if (num_nfce < dmPdv.sqBusca.FieldByName('NUM').AsInteger+1) then
  begin
    num_nfce := dmPdv.sqBusca.FieldByName('NUM').AsInteger+1;
    edNFce.Text:=IntToStr(num_nfce);
  end;
  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    infRespTec.CNPJ := '08382545000111';
    infRespTec.email:= 'carlos@atsti.com.br';
    infRespTec.xContato := 'Carlos R. Silveira';
    infRespTec.fone := '19992159534';
    //02/09/2019 troquei a linha abaixa
    //Ide.cNF       := num_nfce; //Caso não seja preenchido será gerado um número aleatório pelo componente
    Ide.cNF       := GerarCodigoNumerico(num_nfce);
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
    if (Trim(dmpdv.sqEmpresaUF.AsString) = 'MS') then
      Ide.cUF       := 50;
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
    if (dmPdv.sqEmpresaCRT.AsInteger = 0) then
      Emit.CRT := crtSimplesNacional;// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)
    if (dmPdv.sqEmpresaCRT.AsInteger = 1) then
      Emit.CRT := crtSimplesExcessoReceita;
    if (dmPdv.sqEmpresaCRT.AsInteger = 2) then
      Emit.CRT := crtRegimeNormal;
    //end;

    if ((edCPF.Text <> '   .   .   -  ') and  (Length(edCPF.Text) = 14)) then
    begin
      Dest.CNPJCPF := RemoveChar(edCPF.Text);
      Dest.indIEDest := inNaoContribuinte;
      Dest.EnderDest.UF:='SP';
      Dest.EnderDest.cPais := 1058;
    end;
    if ((edCPF.Text <> '  .   .   /   -  ') and  (Length(edCPF.Text) > 14)) then
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
        if (trim(dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString) = '1') then
          tPag := fpDinheiro
        else if (trim(dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString) = '3') then
        begin
          tPag := fpCartaoCredito;
          tpIntegra := tiPagNaoIntegrado;
        end
        else if trim(dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString) = '2' then
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
      Total.ICMSTot.vBC     := vBC;
      Total.ICMSTot.vICMS   := vICMS;
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
  desc_rateado: double;
  ncm_str: String;
  num_itens: Integer;
begin
  desconto_rateio := 0;
  desc_rateado := 0;
  totalNFCe := 0;
  num_itens := 0;
  ACBrNFe1.NotasFiscais.Items[0].nfe.Det.Clear;
  with ACBrNFe1.NotasFiscais.Items[0].NFe do
  begin
    with Transp do
    begin
      modFrete := mfSemFrete;
    end;
    //Adicionando Produtos
    contaItens := 0;
    if (not dmPdv.sqLancamentos.Active) then
      dmPdv.sqLancamentos.open;
    dmPdv.sqLancamentos.First;
    total_tributos := 0;
    vICMS := 0;
    vBC := 0;
    num_itens := dmPdv.sqLancamentos.RecordCount;
    while not dmPdv.sqLancamentos.Eof do
    begin
      num_itens -= 1;
      totalNFCe := totalNFCe + dmPdv.sqLancamentosTOTALITEM.AsFloat;
      contaItens := contaItens + 1;
      vBC += dmPdv.sqLancamentosVLR_BASEICMS.AsVariant;
      vICMS += dmPdv.sqLancamentosVALOR_ICMS.AsVariant;
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
        if ((nfce_desconto > 0) and (num_itens = 0)) then
        begin
          // jogar diferenca rateio desconto no ultimo item
          Prod.vDesc      := RoundTo(nfce_desconto - desc_rateado, -2);
        end;
        if ((nfce_desconto > 0) and (num_itens > 0)) then
        begin
          desconto_rateio := nfce_desconto/nfce_valor;
          desconto_rateio := dmPdv.sqLancamentosTOTALITEM.AsFloat * desconto_rateio;
          Prod.vDesc      := RoundTo(desconto_rateio, -2);
          desc_rateado += Prod.vDesc;
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
            end;
            if( dmPdv.sqEmpresaCRT.AsInteger = 2) then
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
            modBCST := dbisMargemValorAgregado;          //MODO DE BASE DE CALCULO SUBST. TRIBUTÁRIA(4) POR %
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
    if ((num_nfce > 0) and (protocolo <> '')) then
    begin
      str := 'UPDATE SERIES SET ULTIMO_NUMERO = ' + IntToSTR(num_nfce) +
        ' WHERE SERIE = ' + QuotedStr('NFCE-'+dmPdv.varLogado);
      dmPdv.IbCon.ExecuteDirect(str);
    end;
    if (protocolo <> '') then
    begin
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
    end
    else begin
      str := 'UPDATE VENDA SET ';
      str := str + ' NOMEXML = ' +
          QuotedStr('NFCE-' + dmPdv.varLogado + '-' + IntToStr(num_nfce));
    end;
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

procedure TfNfce.gerarSat();
Var
  ArqINI: String ;
  INI : TIniFile ;
  total_trib: Double;
  desconto_rateio: Double;
  TotalItem: Double;
  TotalGeral: Double;
  Erro: String;
  tini, tfim: TDateTime;
  arquivosat : String;
  chave_sat: String;
  nItem: Integer;
  contaItens : Integer;
  cod_barra : String;
  ncm_str: String;
  desc: String;
  vr: String;
begin
  // CARREGANDO TODOS OS DADOS DO ARQUIVO INI,
  // PARA GRAVAR ELE USA O PARAMETRO SAT

  MemoDados.Lines.Clear;

  ACBrSAT1.CFe.Clear;
  ArqINI := 'prjAtsAdmin.ini';
  ACBrSAT1.Extrato := ACBrSATExtratoESCPOS1;
  ACBrSATExtratoESCPOS1.PosPrinter := ACBrPosPrinter1;
  ACBrSAT1.ConfigArquivos.SalvarCFe:=True;

  INI := TIniFile.Create(ArqINI);
  try
    sat_ativacao := INI.ReadString('SAT','CodigoAtivacao','123456');
    sat_assinatura := INI.ReadString('SwH','Assinatura','ATS SOLUCOES E COMERCIO LTDA');
    with ACBrSAT1 do
    begin
      ArqLOG  := INI.ReadString('SAT','ArqLog','ACBrSAT.log');
      NomeDLL := INI.ReadString('SAT','NomeDLL','C:\SAT\SAT.DLL');
      // rede
      with Rede do
      begin
        //tipoInter   := TTipoInterface( INI.ReadInteger('Rede','tipoInter',0) );
        SSID        := INI.ReadString('Rede','SSID','');
        //seg         := TSegSemFio( INI.ReadInteger('Rede','seg',0) ) ;
        codigo      := INI.ReadString('Rede','codigo','') ;
        //tipoLan     := TTipoLan( INI.ReadInteger('Rede','tipoLan',0) ) ;
        lanIP       := INI.ReadString('Rede','lanIP','') ;
        lanMask     := INI.ReadString('Rede','lanMask','') ;
        lanGW       := INI.ReadString('Rede','lanGW','') ;
        lanDNS1     := INI.ReadString('Rede','lanDNS1','') ;
        lanDNS2     := INI.ReadString('Rede','lanDNS2','') ;
        usuario     := INI.ReadString('Rede','usuario','') ;
        senha       := INI.ReadString('Rede','senha','') ;
      end;
      //satNenhum, satDinamico_cdecl, satDinamico_stdcall, mfe_Integrador_XML
      //Modelo  := TACBrSATModelo( INI.ReadInteger('SAT','Modelo',1) );

      try
        Modelo := TACBrSATModelo( INI.ReadInteger('SAT','Modelo',1) ) ;
      except
        raise ;
      end;
      Config.ide_numeroCaixa := INI.ReadInteger('SAT','NumeroCaixa',1);
      Config.ide_tpAmb       := TpcnTipoAmbiente( INI.ReadInteger('SAT','Ambiente',1) );
      Config.ide_CNPJ        := INI.ReadString('SwH','CNPJ','11111111111111');
      Config.emit_CNPJ       := INI.ReadString('Emit','CNPJ','');
      Config.emit_IE         := INI.ReadString('Emit','IE','');
      Config.emit_IM         := INI.ReadString('Emit','IM','');
      Config.emit_cRegTrib      := TpcnRegTrib( INI.ReadInteger('Emit','RegTributario',0) ) ;
      Config.emit_cRegTribISSQN := TpcnRegTribISSQN( INI.ReadInteger('Emit','RegTribISSQN',0) ) ;
      Config.emit_indRatISSQN   := TpcnindRatISSQN( INI.ReadInteger('Emit','IndRatISSQN',0) ) ;
      Config.infCFe_versaoDadosEnt := INI.ReadFloat('SAT','versaoDadosEnt', cversaoDadosEnt);

      CFe.IdentarXML := INI.ReadBool('SAT','FormatarXML', True);
      CFeCanc.IdentarXML := INI.ReadBool('SAT','FormatarXML', True);
      CFe.RetirarAcentos := INI.ReadBool('SAT','RetirarAcentos', True);
      CFeCanc.RetirarAcentos := INI.ReadBool('SAT','RetirarAcentos', True);
      ConfigArquivos.SalvarCFe := INI.ReadBool('SAT','SalvarCFe', True);
      ConfigArquivos.SalvarCFeCanc := INI.ReadBool('SAT','SalvarCFeCanc', True);
      ConfigArquivos.SalvarEnvio :=  INI.ReadBool('SAT','SalvarEnvio', True);
      ConfigArquivos.SepararPorMes := INI.ReadBool('SAT','SepararPorMES', True);

      Config.XmlSignLib := TSSLXmlSignLib( INI.ReadInteger('SAT','XMLLib',0) );

      Config.ArqSchema := INI.ReadString('SAT','SchemaVendaSAT','');
    end;
    ACBrPosPrinter1.Modelo := TACBrPosPrinterModelo( INI.ReadInteger(
      'PosPrinter', 'Modelo', 0));
    ACBrPosPrinter1.PaginaDeCodigo := TACBrPosPaginaCodigo( INI.ReadInteger(
      'PosPrinter','PaginaDeCodigo', 0));
    ACBrPosPrinter1.Porta := INI.ReadString('PosPrinter','Porta', 'LPT1');
    //ACBrPosPrinter1.ColunasFonteNormal := INI.ReadInteger(
    //  'PosPrinter','Colunas',ACBrPosPrinter1.ColunasFonteNormal);
    ACBrPosPrinter1.LinhasEntreCupons := INI.ReadInteger(
      'PosPrinter','LinhasEntreCupons', 10);
    ACBrPosPrinter1.EspacoEntreLinhas := INI.ReadInteger(
      'PosPrinter','EspacoLinhas', 10);
    ACBrSATExtratoESCPOS1.ImprimeQRCode := True;
    ACBrSATExtratoESCPOS1.ImprimeEmUmaLinha := INI.ReadBool(
      'EscPos','ImprimirItemUmaLinha', False);
    if (INI.ReadBool('EscPos','ImprimirChaveUmaLinha',True)) then
      ACBrSATExtratoESCPOS1.ImprimeChaveEmUmaLinha := rSim
    else
      ACBrSATExtratoESCPOS1.ImprimeChaveEmUmaLinha := rAuto;

  finally
     INI.Free ;
  end ;
  ACBrSAT1.Inicializado := True ;
  if ACBrSAT1.Inicializado then
    StatusBar1.Panels[1].Text := 'SAT Inicializado.'
  else
    StatusBar1.Panels[1].Text := 'Sat não inicializado.' ;
  ACBrSAT1.InicializaCFe();
  desc := ACBrSAT1.Config.ide_CNPJ;
  desc := ACBrSAT1.Config.emit_CNPJ;
  //ACBrSAT1.AtivarSAT( 1, ACBrSAT1.Config.emit_CNPJ, StrToInt('35') );

  if (validaCpfCnpj() = False) then
    exit;

  // Montando uma Venda //
  with ACBrSAT1.CFe do
  begin
    //ide.numeroCaixa := dmPdv.contaCaixa;
    //ide.cNF := Random(num_nfce);
    //ide.nserieSAT := ;
    if ((edCPF.Text <> '   .   .   -  ') and  (Length(edCPF.Text) = 14)) then
    begin
      Dest.CNPJCPF := RemoveChar(edCPF.Text);
    end;
    if ((edCPF.Text <> '  .   .   /   -  ') and  (Length(edCPF.Text) > 14)) then
    begin
      Dest.CNPJCPF := RemoveChar(edCPF.Text);
    end;

    contaItens := 0;
    dmPdv.sqLancamentos.First;
    total_tributos := 0;
    vICMS := 0;
    vBC := 0;
    total_trib := 0;
    while not dmPdv.sqLancamentos.Eof do
    begin
    with Det.Add do
    begin
      contaItens += 1;
      nItem := contaItens;
      Prod.cProd := dmPdv.sqLancamentosCODPRO.AsString;
      //cod_barra := dmPdv.sqLancamentosCOD_BARRA.AsString;
      //ACBrValidador1.Documento := cod_barra;
      //ACBrValidador1.TipoDocto := docGTIN;
      //if not ACBrValidador1.Validar then
      //  cod_barra := 'SEM GTIN';
      //ACBrValidador1.TipoDocto := docPrefixoGTIN;
      //if not ACBrValidador1.Validar then
      //  cod_barra := 'SEM GTIN';

      //Prod.cEAN := cod_barra;
      Prod.xProd := LeftStr(dmPdv.sqLancamentosDESCPRODUTO.AsString, 99);
      desc := Copy(dmPdv.sqLancamentosDESCPRODUTO.AsString, 100, 200);
      if ( Length(desc) > 0) then
        infAdProd     := MidStr(dmPdv.sqLancamentosDESCPRODUTO.AsString, 100, 200)  +
                         dmPdv.sqLancamentosOBS.AsString
      else
        infAdProd     := dmPdv.sqLancamentosOBS.AsString;

      ncm_str := dmPdv.sqLancamentosNCM.AsString;
      ncm_str  := StringReplace(ncm_str,'.','',[rfReplaceAll]);
      if Length(ncm_str) < 8then
         ncm_str := '00000000';
      Prod.NCM      := ncm_str;

      Prod.CFOP := dmPdv.sqLancamentosCFOP.AsString;
      Prod.uCom := dmPdv.sqLancamentosUNIDADEMEDIDA.AsString;
      Prod.qCom := dmPdv.sqLancamentosQUANTIDADE.AsFloat;
      Prod.vUnCom := dmPdv.sqLancamentosPRECO.AsFloat;
      Prod.indRegra := irArredondamento;
      Prod.vDesc    := dmPdv.sqLancamentosVALOR_DESCONTO.AsCurrency;
      if nfce_desconto > 0 then
      begin
        desconto_rateio := nfce_desconto/nfce_valor;
        desconto_rateio := dmPdv.sqLancamentosTOTALITEM.AsFloat * desconto_rateio;
        Prod.vDesc      := RoundTo(desconto_rateio, -2);
      end;
      Prod.vProd := (Prod.qCom*Prod.vUnCom)-Prod.vDesc;
      with Imposto do
      begin
        TotalItem := RoundABNT((Prod.qCom * Prod.vUnCom) + Prod.vOutro - Prod.vDesc, -2);
        TotalGeral := TotalGeral + TotalItem;
        vItem12741 := RoundTo(dmPdv.sqLancamentosVLRTOT_TRIB.AsFloat,-2);
        total_trib += RoundTo(dmPdv.sqLancamentosVLRTOT_TRIB.AsFloat,-2);
        if (dmPdv.sqLancamentosORIGEM.IsNull) then
        begin
          MessageDlg('Origem do Produto(CADASTRO PRODUTO) não informado, Cod. Prod: ' +
                    dmPdv.sqLancamentosCODPRO.AsString, mtError, [mbOK], 0);
        end;
        ICMS.orig := oeNacional;
        vr := Trim(dmPdv.sqLancamentosORIGEM.AsString);
        if (vr = '1') then
          ICMS.orig := oeEstrangeiraImportacaoDireta;
        if (vr = '2') then
          ICMS.orig := oeEstrangeiraAdquiridaBrasil;
        if (vr = '3') then
          ICMS.orig := oeNacionalConteudoImportacaoSuperior40;
        if (vr = '4') then
          ICMS.orig := oeNacionalProcessosBasicos;
        if (vr = '5') then
          ICMS.orig := oeNacionalConteudoImportacaoInferiorIgual40;
        if (vr = '6') then
          ICMS.orig := oeEstrangeiraImportacaoDiretaSemSimilar;
        if (vr = '7') then
          ICMS.orig := oeEstrangeiraAdquiridaBrasilSemSimilar;

        vr := Trim(dmPdv.sqLancamentosCSOSN.AsString);
        if( dmPdv.sqEmpresaCRT.AsInteger = 0) then
        begin
          if ((dmPdv.sqLancamentosCSOSN.AsString = null) or ( vr = '')) then
          begin
            ICMS.CSOSN := csosnVazio;
          end
          else if (vr = '101') then
          begin
            ICMS.CSOSN := csosn101;
          end;
        end
        else if ( vr = '102') then
          ICMS.CSOSN := csosn102
        else if ( vr = '103') then
          ICMS.CSOSN := csosn103
        else if ( vr = '201') then
        begin
          ICMS.CSOSN := csosn201;
        end
        else if ( vr = '202') then
          ICMS.CSOSN := csosn202
        else if ( vr = '203') then
          ICMS.CSOSN := csosn203
        else if ( vr = '300') then
          ICMS.CSOSN := csosn300
        else if ( vr = '400') then
          ICMS.CSOSN := csosn400
        else if ( vr = '500') then
          ICMS.CSOSN := csosn500
        else if ( vr = '900') then
          ICMS.CSOSN := csosn900;
        ICMS.pICMS := 0;
        ICMS.vICMS := 0;
        vr := Trim(dmPdv.sqLancamentosCST.AsString);
        if (vr  = '000') then
        begin
           Imposto.ICMS.CST := cst00;
           ICMS.pICMS := dmPdv.sqLancamentosICMS.AsFloat;
           ICMS.vICMS := dmPdv.sqLancamentosVALOR_ICMS.AsFloat;
        end;
        if ( vr = '060') then
        begin
           Imposto.ICMS.CST := cst60;
           ICMS.pICMS := dmPdv.sqLancamentosICMS.AsFloat;
           ICMS.vICMS := dmPdv.sqLancamentosVALOR_ICMS.AsFloat;
        end;

        //ICMS.vBC := 0;
      end; // CRT = 0
      vr := dmPdv.sqLancamentosCSTPIS.AsString;
      if (vr = '49') then
      begin
        Imposto.PIS.CST := pis49;
        Imposto.PIS.vBC := 0;
        Imposto.PIS.pPIS := 0;
      end;
      if (Trim(dmPdv.sqLancamentosCSTPIS.AsString) = '01') then
      begin
        Imposto.PIS.CST := pis01;
        Imposto.PIS.vPIS := dmPdv.sqLancamentosVALOR_PIS.AsFloat;
        Imposto.PIS.pPIS := dmPdv.sqLancamentosPPIS.AsFloat;
      end;
      if (Trim(dmPdv.sqLancamentosCSTCOFINS.AsString) = '49') then
      begin
        Imposto.COFINS.CST := cof49;
        Imposto.COFINS.vCOFINS := 0;
        Imposto.COFINS.pCOFINS := 0;
      end;
      if (Trim(dmPdv.sqLancamentosCSTCOFINS.AsString) = '01') then
      begin
        Imposto.COFINS.CST := cof01;
        Imposto.COFINS.vCOFINS := dmPdv.sqLancamentosVALOR_COFINS.AsFloat;
        Imposto.COFINS.pCOFINS := dmPdv.sqLancamentosPCOFINS.AsFloat;
      end;

    end;
    dmPdv.sqLancamentos.Next;
    end;
    Total.DescAcrEntr.vDescSubtot := nfce_desconto;
    Total.vCFeLei12741 :=  total_trib;

    dmPdv.sqBusca.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqBusca.SQL.Text := 'SELECT CODFORMA, COD_VENDA, ID_ENTRADA, FORMA_PGTO' +
      ' , CAIXA , N_DOC, VALOR_PAGO, CAIXINHA, TROCO, DESCONTO, STATE' +
      ' FROM FORMA_ENTRADA WHERE STATE < 2 AND ID_ENTRADA = ' +
      InttoStr(dmPdv.sqLancamentosCODMOVIMENTO.AsInteger);
    dmPdv.sqBusca.Open;

    while not dmPdv.sqBusca.EOF do
    begin
      with Pagto.Add do
      begin
        cMP := mpCreditoLoja;
        if (trim(dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString) = '1') then
          cMP := mpDinheiro
        else if (trim(dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString) = '3') then
        begin
          cMP := mpCartaodeCredito;
          //tpIntegra := tiPagNaoIntegrado;
        end
        else if trim(dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString) = '2' then
        begin
          cMP := mpCartaodeDebito;
        end
        else
          cMP := mpOutros;
        vMP := RoundTo(dmPdv.sqBusca.FieldByName('VALOR_PAGO').AsFloat, -2);
      end;
      dmPdv.sqBusca.Next;
    end;


    //InfAdic.infCpl := ''+ '';

   { InfAdic.infCpl := '</linha_simples>;'+
                        '</ce><e><n>SENHA XXX</n></e>;'+
                        '</linha_simples>';}
  end;
  memoLog.Lines.Add('Gerando o XML');
  memoDados.Lines.Text := ACBrSAT1.CFe.GerarXML( True );    // True = Gera apenas as TAGs da aplicação
  //if ACBrSAT1.ValidarDadosVenda( MemoDados.Text, Erro ) then
  //ACBrSAT1.EnviarDadosVenda(MemoDados.Text);
  //ShowMessage('XML Recebido do SAT, validado com sucesso');

  tini := now;
  memoLog.Lines.Add('Enviando Dados');
  ACBrSAT1.EnviarDadosVenda( MemoDados.Text );
  tfim := now;
  memoLog.Lines.Add('------------------------------------------------') ;
  memoLog.Lines.Add('Iniciado em: '+DateTimeToStr(tini)) ;
  memoLog.Lines.Add('Finalizado em: '+DateTimeToStr(tFim)) ;
  memoLog.Lines.Add('') ;
  memoLog.Lines.Add('Tempo de Envio e Recebimento: '+ FormatFloat('##0.00',SecondSpan(tini,tfim))+' segundos' ) ;
  memoLog.Lines.Add('------------------------------------------------') ;
  memoLog.Lines.Add('Retorno : ' + IntToStr(ACBrSAT1.Resposta.codigoDeRetorno));
  if ACBrSAT1.Resposta.codigoDeRetorno = 6000 then
  begin
    MemoResp.Lines.Text := ACBrSAT1.CFe.AsXMLString;
    ACBrSAT1.ImprimirExtrato;
    begin
      try
        dmPdv.IbCon.ExecuteDirect('ALTER TRIGGER ALTERA_CONTABIL INACTIVE');
        dmPdv.IbCon.ExecuteDirect('ALTER TRIGGER ALTERA_REC INACTIVE');
        dmPdv.sTrans.Commit;
      except
        ///dm.sqlsisAdimin.Rollback(TD); //on failure, undo the changes}
      end;
    end;
    try
      arquivosat := AcbrSat1.CFe.NomeArquivo;
      if (not DirectoryExists(arquivosat)) then
        CreateDir(arquivosat);
      ACBrSAT1.CFe.SaveToFile(ACBrSAT1.CalcCFeNomeArq(''));
      chave_sat := Copy(ACBrSAT1.cfe.infCFe.ID,23,29);
      dmPdv.IbCon.ExecuteDirect('UPDATE VENDA SET STATUS1 = ' +
        QuotedStr('E') + ', OBS = ' + QuotedStr(arquivosat) +
        ' ,N_DOCUMENTO = ' + QuotedStr(IntToStr(ACBrSAT1.CFe.ide.nCFe)) +
        ' ,N_BOLETO = ' + QuotedStr(chave_sat) +
        ', NOTAFISCAL = ' + IntToStr(ACBrSAT1.CFe.ide.nCFe) +
        ', SERIE = ' + QuotedStr('NFCE-'+dmPdv.varLogado) +
        ' WHERE CODVENDA = ' + IntToStr(nfce_codVenda));
      dmPdv.sTrans.Commit;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        //dm.sqlsisAdimin.Rollback(TD); //on failure, undo the changes}
      end;
    end;
    //ACBrSAT1.CFe.SaveToFile(arquivosat);
    MemoLog.Lines.add('Cupom gerado com SUCESSO.');
    MemoResp.Lines.Add(arquivosat);
    begin
      try
        dmPdv.IbCon.ExecuteDirect('ALTER TRIGGER ALTERA_CONTABIL ACTIVE');
        dmPdv.IbCon.ExecuteDirect('ALTER TRIGGER ALTERA_REC ACTIVE');
        dmPdv.sTrans.Commit;
      except
        //dm.sqlsisAdimin.Rollback(TD); //on failure, undo the changes}
      end;
    end;
    MessageDlg('Cupom criado com sucesso.', mtInformation, [mbOK], 0);
  end;
  MemoResp.Lines.Add('Venda Gerada');
  ACBrSAT1.Inicializado := False ;
end;

procedure TfNfce.gerarLog(const ALogLine: String; var Tratado: Boolean);
begin
  MemoResp.Lines.Add(ALogLine);
  StatusBar1.Panels[0].Text := IntToStr( ACBrSAT1.Resposta.numeroSessao );
  StatusBar1.Panels[1].Text := IntToStr( ACBrSAT1.Resposta.codigoDeRetorno );
  Tratado := False;
end;

procedure TfNfce.TrataErros(Sender: TObject; E: Exception);
var
  Erro : String ;
begin
  Erro := Trim(E.Message) ;
  ACBrSAT1.DoLog( E.ClassName+' - '+Erro);
end;

procedure TfNfce.carregaAcbr;
var ver_strc: String;
begin
  ACBrNFe1.SSL.DescarregarCertificado;
  if (edtCaminho.Text <> '') then
  begin
    ACBrNFe1.Configuracoes.Certificados.ArquivoPFX  := dmPdv.CaminhoCert;
    ACBrNFe1.Configuracoes.Certificados.Senha       := dmPdv.SenhaCert;
  end
  else begin
    edtNumSerie.Text := dmPdv.NumSerieCert;
    edCertificado.Text := edtNumSerie.Text;
    ACBrNFe1.Configuracoes.Certificados.NumeroSerie := edCertificado.Text;
  end;
  Try
    ACBrNFe1.SSL.CarregarCertificado;
  except
    on e:Exception do
    begin
      ShowMessage('Erro carregar certificado ' + e.Message );
      Exit;
    end;
  end;
  ver_strc := Trim(dmPdv.sqEmpresaUF.AsString);
  ACBrNFe1.Configuracoes.WebServices.UF := ver_strc;

  if (dmPdv.sqEmpresaDIVERSOS3.AsString <> '') then
  begin
    ACBrNFe1.Configuracoes.WebServices.TimeZoneConf.TimeZoneStr := dmPdv.sqEmpresaDIVERSOS3.AsString;
  end;

  ACBrNFe1.Configuracoes.Geral.ModeloDF := moNFCe;
  ACBrNFe1.Configuracoes.Geral.Salvar   := True;
  ACBrNFe1.Configuracoes.Arquivos.Salvar:= True;
  ACBrNFe1.Configuracoes.Arquivos.SalvarEvento:= True;
  ACBrNFe1.Configuracoes.Geral.VersaoDF := ve400;

  ACBrNFe1.Configuracoes.Geral.IdCSC := dmPdv.id_tk;
  ACBrNFe1.Configuracoes.Geral.CSC := dmPdv.tk;
  ACBrNFe1.Configuracoes.WebServices.TimeOut := 35000;

  if (not DirectoryExists(dmpdv.path_xml + '\NFce')) then
    CreateDir(dmpdv.path_xml + '\NFce');
  if (not DirectoryExists(dmpdv.path_xml + '\Eventos')) then
    CreateDir(dmpdv.path_xml + '\Eventos');

  AcbrNfe1.Configuracoes.Arquivos.PathSalvar := dmpdv.path_xml + '\NFce';
  AcbrNfe1.Configuracoes.Arquivos.PathEvento := dmpdv.path_xml + '\Eventos';

  //ACBrNFe1.Configuracoes.WebServices.UFCodigo := 35;
  if (Trim(dmPdv.sqEmpresaTIPO.AsString) = '1') then
    ACBrNFe1.Configuracoes.WebServices.Ambiente := taProducao
  else
    ACBrNFe1.Configuracoes.WebServices.Ambiente := taHomologacao;

  //edtPathSchemas.Text  := Ini.ReadString( 'Geral','PathSchemas'  ,PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\') ;

  with ACBrNFe1.Configuracoes.Geral do
  begin
    SSLLib       := TSSLLib(cbSSLLib.ItemIndex);
    SSLCryptLib  := TSSLCryptLib(cbCryptLib.ItemIndex);
    SSLHttpLib   := TSSLHttpLib(cbHttpLib.ItemIndex);
    SSLXmlSignLib:= TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  end;
  ACBrNFe1.SSL.CarregarCertificado;
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

procedure TfNfce.BitBtn5Click(Sender: TObject);
begin
  dmPdv.executaSql('UPDATE VENDA SET NOTAFISCAL = '  + IntToStr(num_nfce) +
    ', SERIE = ' + QuotedStr('NFCE-'+dmPdv.varLogado) + ' WHERE NOMEXML = ' +
    QuotedStr('NFCE-' + dmPdv.varLogado + '-' + IntToStr(num_nfce)));
  dmPdv.executaSql('UPDATE SERIES SET ULTIMO_NUMERO = ' + IntToStr(num_nfce) +
    ' WHERE SERIE = ' + QuotedStr('NFCE-'+dmPdv.varLogado));
  dmPdv.sTrans.Commit;
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
  edNFce.Text:=IntToStr(num_nfce)
end;

procedure TfNfce.BitBtn6Click(Sender: TObject);
var idLote,vAux : String;
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.EventoNFe.Evento.Clear;
    carregaAcbr;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

    idLote := '1';
      //if not(InputQuery('WebServices Eventos: Cancelamento', 'Identificador de controle do Lote de envio do Evento', idLote)) then
      //   exit;
      //if not(InputQuery('WebServices Eventos: Cancelamento', 'Justificativa', vAux)) then
      //   exit;
    lblCancelamento.Caption := 'Chave ' + acbrnfe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
    //Copy(acbrnfe1.NotasFiscais.Items[0].NFe.infNFe.ID,4,44);
    //lblCancelamento.Caption := 'Chave' + acbrnfe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
    // Copy(acbrnfe1.NotasFiscais.Items[0].NFe.infNFe.ID,4,44);
    ACBrNFe1.EventoNFe.idLote := StrToInt(idLote) ;
    with ACBrNFe1.EventoNFe.Evento.Add do
    begin
      infEvento.tpAmb := acbrnfe1.NotasFiscais.Items[0].NFe.Ide.tpAmb;
      infEvento.CNPJ := acbrnfe1.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
      infEvento.cOrgao := acbrnfe1.NotasFiscais.Items[0].NFe.Ide.cUF;
      infEvento.dhEvento := now;
      infEvento.tpEvento := teCancelamento;
      infEvento.nSeqEvento := 1;
      infEvento.detEvento.xJust := edCancelamentoMotivo.Text;
      infEvento.chNFe := acbrnfe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
      infEvento.detEvento.nProt := acbrnfe1.NotasFiscais.Items[0].NFe.procNFe.nProt;
      InfEvento.versaoEvento:='1.0';
    end;
    lblCancelamento.Caption := 'Gerando xml ' + DateTimeToStr(now);
    Try
      ACBrNFe1.EventoNFe.GerarXML;
      ACBrNFe1.EventoNFe.Gerador.SalvarArquivo('C:\home\evento.xml');
    Except
      ShowMessage('Erro para Gravar o XML : ' +
        AcbrNfe1.Configuracoes.Arquivos.PathSalvar);
    end;
    lblCancelamento2.Caption := 'Enviando Evento, lote : ' + idLote;
    Try
      if (ACBrNFe1.EnviarEvento(StrToInt(idLote))) then
      begin
        with ACBrNFe1.WebServices.EnvEvento do
        begin
          if (EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <>  135) then
          begin
            raise Exception.CreateFmt(
              'Ocorreu erro para cancelar a NFCe %d ,' + sLineBreak +
              ' Motivo : %s', [
              EventoRetorno.retEvento.Items[0].RetInfEvento.cStat,
              EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo
            ]);
          end;
        end;
      end
      else begin
        with ACBrNFe1.WebServices.EnvEvento do
        begin
          raise Exception.Create(
            'Ocorreram erros no cancelamento :' + sLineBreak +
            'Ambiente : ' + TpAmbToStr(EventoRetorno.tpAmb) + sLineBreak +
            'Orgao : ' + IntToStr(EventoRetorno.cOrgao) + sLineBreak +
            'Status : ' + IntToStr(EventoRetorno.cStat) + sLineBreak +
            'Motivo : ' + EventoRetorno.xMotivo
          );
        end;
      end;
    Except
      on E:Exception do
         ShowMessage('Erro para enviar NFCe : ' + e.Message);
    end;
    MemoResp.Lines.Text := ACBrNFe1.WebServices.EnvEvento.RetWS;
    memoResp.Lines.Text := ACBrNFe1.WebServices.EnvEvento.RetornoWS;
    //LoadXML(MemoResp, WBResposta);
    ShowMessage(IntToStr(ACBrNFe1.WebServices.EnvEvento.cStat));
    ShowMessage(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);
  end;
  pnCancelamento.Visible:=False;
end;

procedure TfNfce.BitBtn7Click(Sender: TObject);
begin
  pnCancelamento.Visible:=False;
end;

procedure TfNfce.BitBtn8Click(Sender: TObject);
begin
  ACBrNFe1.SSL.CarregarCertificado;;
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
  carregaAcbr;
  //if not(InputQuery('WebServices Consultar', 'Chave da NF-e:', vChave)) then
  //  exit;
  memoLog.Lines.Add('Executando consulta NFCe...');
  if (nomeXml <> '') then
  begin
    MemoResp.Lines.Clear;
    MemoDados.Lines.Clear;
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.WebServices.Consulta.NFeChave := nomeXml;
  end
  else begin
    OpenDialog1.Title := 'Selecione a NFE';
    OpenDialog1.DefaultExt := '*-nfe.XML';
    OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
    OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
    if OpenDialog1.Execute then
    begin
      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    end;
  end;
  ACBrNFe1.WebServices.Consulta.Executar;
  memoLog.Lines.Add('Consulta executada  cStat: ' + IntToStr(ACBrNFe1.WebServices.Consulta.cStat));
  MemoResp.Lines.Text := ACBrNFe1.WebServices.Consulta.RetWS;
  memoDados.Lines.Text := ACBrNFe1.WebServices.Consulta.RetornoWS;
  if ACBrNFe1.WebServices.Consulta.Protocolo <> '' then
  begin
    memoLog.Lines.Add('Consulta executada com sucesso');
    ShowMessage(ACBrNFe1.WebServices.Consulta.Protocolo);
    Protocolo := ACBrNFe1.WebServices.Consulta.Protocolo;
    Recibo := 'recibo';//ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe. .WebServices.Consulta.Recibo;
    GravarDadosNF(protocolo, recibo);
  end;
  memoLog.Lines.Add('Imprimindo NFCe ' + IntToStr(ACBrNFe1.NotasFiscais.Count));
  if ACBrNFe1.NotasFiscais.Count > 0 then
    ACBrNFe1.NotasFiscais.Imprimir;
end;

procedure TfNfce.btnNFce3Click(Sender: TObject);
var
 Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : String;

begin
  edSerie.Text := IntToStr(serie_nfce);
  Panel1.Visible:= True;
  // gerar nfce
  carregaAcbr;

  begin
   if not(InputQuery('WebServices Inutilização ', 'Ano',    Ano)) then
      exit;
   if not(InputQuery('WebServices Inutilização ', 'Modelo', Modelo)) then
      exit;
   if not(InputQuery('WebServices Inutilização ', 'Serie',  Serie)) then
      exit;
   if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroInicial)) then
      exit;
   if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroFinal)) then
      exit;
   if not(InputQuery('WebServices Inutilização ', 'Justificativa', Justificativa)) then
      exit;
    ACBrNFe1.WebServices.Inutiliza(RemoveChar(dmPdv.sqEmpresaCNPJ_CPF.AsString),
      Justificativa, StrToInt(Ano), StrToInt(Modelo), StrToInt(Serie),
      StrToInt(NumeroInicial), StrToInt(NumeroFinal));
    MemoResp.Lines.Text :=  ACBrNFe1.WebServices.Inutilizacao.RetWS;
    MemoResp.Lines.Text :=  ACBrNFe1.WebServices.Inutilizacao.RetornoWS;
    //LoadXML(MemoResp, WBResposta);

    //pgRespostas.ActivePageIndex := 1;

    MemoDados.Lines.Add('');
    MemoDados.Lines.Add('Inutilização');
    MemoDados.Lines.Add('tpAmb: '    +TpAmbToStr(ACBrNFe1.WebServices.Inutilizacao.tpAmb));
    MemoDados.Lines.Add('verAplic: ' +ACBrNFe1.WebServices.Inutilizacao.verAplic);
    MemoDados.Lines.Add('cStat: '    +IntToStr(ACBrNFe1.WebServices.Inutilizacao.cStat));
    MemoDados.Lines.Add('xMotivo: '  +ACBrNFe1.WebServices.Inutilizacao.xMotivo);
    MemoDados.Lines.Add('cUF: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.cUF));
    MemoDados.Lines.Add('Ano: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.Ano));
    MemoDados.Lines.Add('CNPJ: '      +ACBrNFe1.WebServices.Inutilizacao.CNPJ);
    MemoDados.Lines.Add('Modelo: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.Modelo));
    MemoDados.Lines.Add('Serie: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.Serie));
    MemoDados.Lines.Add('NumeroInicial: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.NumeroInicial));
    MemoDados.Lines.Add('NumeroInicial: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.NumeroFinal));
    MemoDados.Lines.Add('dhRecbto: ' +DateTimeToStr(ACBrNFe1.WebServices.Inutilizacao.dhRecbto));
    MemoDados.Lines.Add('Protocolo: '      +ACBrNFe1.WebServices.Inutilizacao.Protocolo);
  end;
end;

procedure TfNfce.btnNFce4Click(Sender: TObject);
begin
  carregaAcbr;
  MemoDados.Lines.Clear;
  MemoResp.Lines.Clear;
  ACBrNFe1.WebServices.Inutiliza(RemoveChar(dmPdv.sqEmpresaCNPJ_CPF.AsString),
    EdJustificativa.Text, StrToInt(edAno.Text), StrToInt(edModelo.Text), StrToInt(edSerie.Text),
    StrToInt(edNumIni.Text), StrToInt(edNumFim.Text));
  MemoResp.Lines.Text :=  ACBrNFe1.WebServices.Inutilizacao.RetWS;
  memoDados.Lines.Text :=  ACBrNFe1.WebServices.Inutilizacao.RetornoWS;

  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Inutilização');
  MemoDados.Lines.Add('tpAmb: '    +TpAmbToStr(ACBrNFe1.WebServices.Inutilizacao.tpAmb));
  MemoDados.Lines.Add('verAplic: ' +ACBrNFe1.WebServices.Inutilizacao.verAplic);
  MemoDados.Lines.Add('cStat: '    +IntToStr(ACBrNFe1.WebServices.Inutilizacao.cStat));
  MemoDados.Lines.Add('xMotivo: '  +ACBrNFe1.WebServices.Inutilizacao.xMotivo);
  MemoDados.Lines.Add('cUF: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.cUF));
  MemoDados.Lines.Add('Ano: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.Ano));
  MemoDados.Lines.Add('CNPJ: '      +ACBrNFe1.WebServices.Inutilizacao.CNPJ);
  MemoDados.Lines.Add('Modelo: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.Modelo));
  MemoDados.Lines.Add('Serie: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.Serie));
  MemoDados.Lines.Add('NumeroInicial: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.NumeroInicial));
  MemoDados.Lines.Add('NumeroInicial: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.NumeroFinal));
  MemoDados.Lines.Add('dhRecbto: ' +DateTimeToStr(ACBrNFe1.WebServices.Inutilizacao.dhRecbto));
  MemoDados.Lines.Add('Protocolo: '      +ACBrNFe1.WebServices.Inutilizacao.Protocolo);
  ShowMessage('Numeração inutilizada com sucesso.');
  ACBrNFe1.ImprimirInutilizacao;
end;

procedure TfNfce.btnNFce5Click(Sender: TObject);
begin
  Panel1.Visible := False;
end;

procedure TfNfce.btnNFce6Click(Sender: TObject);
begin
  edCancelamentoMotivo.Text := '';
  pnCancelamento.Visible := True;
end;

procedure TfNfce.btnNFce7Click(Sender: TObject);
var
 vAux, vNumLote, vSincrono : String;
 Sincrono : boolean;
 Protocolo, Recibo: String;
 str: String;
 ambiente: String;
 ver_var: String;
begin
  memoLog.Lines.Add('Gerando NFCe');
  ACBrNFe1.NotasFiscais.Clear;
  carregaAcbr;
  ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis:=teOffLine;
  ACBrNFe1.Configuracoes.Geral.FormaEmissao:=teOffLine;
  ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dhCont:=Now;
  ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.xJust:='Emissao em contigencia , falha conexao.';

    if (notaEmitida = 'S') then
    begin
      ShowMessage('Nota Fiscal já emitida.');
      Exit;
    end;
    memoLog.Lines.Add('Carregando certificado(se parar deve estar pedindo permissao)');

    memoLog.Lines.Add('Certificado carregado');
    if (dmPdv.tk = '') then
    begin
      ShowMessage('Cadastre: '+#13+#10+''+#13+#10+'Natureza Operação : 30 ' +
        'para Nota Fiscal Consumidor;'+#13+#10+''+#13+#10+'Série :' +
        'para ser usada na NFCe;'+#13+#10+''+#13+#10+'Parametro: ' +
        'SERIENFCe com a série criada no campo D1.');
      exit;
    end;

    if (validaCpfCnpj() = False) then
      exit;

    if (edCertificado.Text = '') then
    begin
      MessageDlg('Informe o certificado.',mtError,[mbok],0);
      exit;
    end;

    vAux := edNFCe.Text;
    memoLog.Lines.Add('NFCe-' + edNFce.Text);

    vSincrono := '1';
    Sincrono := True;
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
    ACBrNFe1.Configuracoes.WebServices.TimeOut := 35000;

    ACBrNFe1.DANFE := ACBrNFeDANFeESCPOS1;

    AcbrNfe1.Configuracoes.Arquivos.PathSalvar := dmpdv.path_xml + '\NFce\';
    AcbrNfe1.Configuracoes.Arquivos.PathEvento := dmpdv.path_xml + '\Eventos\';
    memoLog.Lines.Add('Gerando XML');
    GerarNFCe(vAux);
    memoLog.Lines.Add('Assinando XML');
    ACBrNFe1.NotasFiscais.Assinar;

    // Gravando a nota aqui pois se der erro no validar ja gravei
    GravarDadosNF('', '');
    // estou pegando o ultimo numero usado em venda pra nao pular
    memoLog.Lines.Add('Gravando XML');
    //ACBrNFe1.NotasFiscais.Items[0].GravarXML();
    ACBrNFe1.NotasFiscais.GravarXML();
    memoLog.Lines.Add('Validando');
    ACBrNFe1.NotasFiscais.Validar;
    //LoadXML(ACBrNFe1.NotasFiscais.Items[0].XML,  mRecebido);

    // TODO
    if (dmPdv.NFE_Teste = 'N') then
    begin
      memoLog.Lines.Add('Enviando ...');
      Try
        ACBrNFe1.Enviar(vNumLote,True,Sincrono);
      Except
        ver_var := IntToStr(ACBrNFe1.WebServices.Retorno.cStat);
        ShowMessage('Erro para Enviar a NFCe, erro : ' + ver_var);
        exit;
      end;
      memoLog.Lines.Add('cStat : ' + IntToStr(ACBrNFe1.WebServices.Retorno.cStat));
      if (ACBrNFe1.WebServices.Retorno.cStat = 100) then
      begin
        Protocolo := 'CONT-' +  ACBrNFe1.WebServices.Retorno.Protocolo;
        Recibo := ACBrNFe1.WebServices.Retorno.Recibo;
        GravarDadosNF(protocolo, recibo);
      end;
    end;

    MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.Retorno.RetWS);
    MemoDados.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.Retorno.RetornoWS);

    memoLog.Lines.Add('');
    memoLog.Lines.Add('Envio NFe');
    memoLog.Lines.Add('tpAmb: '+ TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb));
    memoLog.Lines.Add('verAplic: '+ ACBrNFe1.WebServices.Retorno.verAplic);
    memoLog.Lines.Add('cStat: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cStat));
    memoLog.Lines.Add('cUF: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cUF));
    memoLog.Lines.Add('xMotivo: '+ ACBrNFe1.WebServices.Retorno.xMotivo);
    memoLog.Lines.Add('cMsg: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cMsg));
    memoLog.Lines.Add('xMsg: '+ ACBrNFe1.WebServices.Retorno.xMsg);
    memoLog.Lines.Add('Recibo: '+ ACBrNFe1.WebServices.Retorno.Recibo);
    memoLog.Lines.Add('Protocolo: '+ ACBrNFe1.WebServices.Retorno.Protocolo);

    ShowMessage('Nº do Protocolo de envio ' + ACBrNFe1.WebServices.Retorno.Protocolo);
    ShowMessage('Nº do Recibo de envio ' + ACBrNFe1.WebServices.Retorno.Recibo);

    //LoadXML(ACBrNFe1.NotasFiscais.Items[0].XML,  mRecebido);
    //ACBrNFe1.NotasFiscais.Imprimir;
    memoLog.Lines.Add('Enviado gravando retorno');
    memoLog.Lines.Add('');
    memoLog.Lines.Add('Nota Fiscal Consumidor, gerada com sucesso.');
    memoLog.Lines.Add('');
    //Application.ProcessMessages;
    ACBrNFe1.NotasFiscais.Clear;
    Close;
end;

procedure TfNfce.btnNFce8Click(Sender: TObject);
var idLote,vAux : String;
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    carregaAcbr;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFe1.NotasFiscais.GerarNFe;
  end;
end;

procedure TfNfce.ACBrNFe1AntesDeAssinar(var ConteudoXML: String;
  const docElement, infElement, SignatureNode, SelectionNamespaces,
  IdSignature: String);
begin

end;

procedure TfNfce.ACBrNFe1GerarLog(const ALogLine: String; var Tratado: Boolean);
begin
  memoLog.Lines.Add(ALogLine);
end;

procedure TfNfce.ACBrNFe1StatusChange(Sender: TObject);
begin
  case ACBrNFe1.Status of
    stIdle :
    begin
      if ( frmStatus <> nil ) then
        frmStatus.Hide;
    end;
    stNFeStatusServico :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Verificando Status do servico...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeRecepcao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando dados da NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeRetRecepcao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Recebendo dados da NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeConsulta :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeCancelamento :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando cancelamento de NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeInutilizacao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeRecibo :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeCadastro :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando Cadastro...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeEmail :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando Email...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeCCe :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando Carta de Correção...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeEvento :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando Evento...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
  end;
  Application.ProcessMessages;

end;

procedure TfNfce.ACBrNFe1TransmitError(const HttpError, InternalError: Integer;
  const URL, DadosEnviados, SoapAction: String; var Retentar: Boolean;
  var Tratado: Boolean);
begin
  ShowMessage('HTTPError: '+IntToStr(HttpError) + sLineBreak +
              'InternalError: '+IntToStr(InternalError)  );

  //TryAgain := False;
end;

procedure TfNfce.ACBrSAT1GetcodigoDeAtivacao(var Chave: AnsiString);
begin
  Chave := AnsiString( sat_ativacao );
end;

procedure TfNfce.ACBrSAT1GetsignAC(var Chave: AnsiString);
begin
  Chave := AnsiString( sat_assinatura );
end;

procedure TfNfce.acFecharExecute(Sender: TObject);
begin
  Close;
end;

end.

