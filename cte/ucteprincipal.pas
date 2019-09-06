unit uCtePrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Menus, Buttons, DBGrids, DateTimePicker, Types, IniFiles,
  ACBrCTe, ACBrCTeDACTEClass, ACBrMail, ACBrBase, ACBrDFe, pcnConversao,
  pcteConversaoCTe, DateUtils;

type

  { TfCTePrincipal }

  TfCTePrincipal = class(TForm)
    ACBrCTe1: TACBrCTe;
    BitBtn1: TBitBtn;
    btnGravarCTe: TBitBtn;
    combICMSDevido: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    OpenDialog1: TOpenDialog;
    sbtnPathSalvar: TBitBtn;
    sbtnLogoMarca: TBitBtn;
    Edit2: TEdit;
    sbtnGetCert: TBitBtn;
    btnPreVisu: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    btnEditarCte: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    btnIncCte: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    btnListarCte: TBitBtn;
    btnDuplicar: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    btnImportarXML: TButton;
    btnGerarPDFEvento: TButton;
    btnEnviarEventoEmail: TButton;
    btnGerarPDF: TButton;
    btnEnviarEmail: TButton;
    btnValidarXML: TButton;
    btnCC: TButton;
    Button27: TButton;
    Button30: TButton;
    btnImprimirInut: TButton;
    btnImprimirEvento: TButton;
    btnImprimir: TButton;
    btnImportarXML1: TButton;
    btnConsultar: TButton;
    btnConsultarChave: TButton;
    btnEnvEPEC: TButton;
    btnConsCad: TButton;
    btnCriarEnviar: TButton;
    btnConsultarRecibo: TButton;
    btnStatusServ: TButton;
    btnInutilizar: TButton;
    btnGerar: TButton;
    btnAtualizarBD: TButton;
    btnGerarPDFInut: TButton;
    Button9: TButton;
    cbEmailSSL: TCheckBox;
    ckVisualizar: TCheckBox;
    ckSalvar: TCheckBox;
    CheckBox1: TCheckBox;
    combCodSitTrib: TComboBox;
    cbUF: TComboBox;
    combOutrosDocs: TComboBox;
    dataGerarCte: TDateTimePicker;
    dataRodPrev: TDateTimePicker;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    dgGridCTE: TDBGrid;
    dbValInfCarga: TEdit;
    dbValTotPrest: TEdit;
    calValB: TEdit;
    Edit1: TEdit;
    edtDestISUF: TEdit;
    edtFimCodCidade: TEdit;
    edtIniCodCidade: TEdit;
    edtEnvCodCidade: TEdit;
    edtNatOpe: TEdit;
    edtCfop: TEdit;
    edtSmtpPass: TEdit;
    edtSmtpUser: TEdit;
    edtSmtpPort: TEdit;
    edtProxyHost: TEdit;
    edtPathLogs: TEdit;
    edtLogoMarca: TEdit;
    edtNumSerie: TEdit;
    edtSenha: TEdit;
    edtCaminho: TEdit;
    edtAntCNPJ: TEdit;
    edtAntIE: TEdit;
    edtAntNome: TEdit;
    edtAntCHCTE: TEdit;
    edtAntUF: TEdit;
    edtCodEmitente1: TEdit;
    edtEmitBairro1: TEdit;
    edtEmitCEP1: TEdit;
    edtEmitCidade1: TEdit;
    edtEmitCNPJ1: TEdit;
    edtEmitCodCidade1: TEdit;
    edtEmitComp1: TEdit;
    edtEmitFantasia1: TEdit;
    edtEmitFone1: TEdit;
    edtEmitIE1: TEdit;
    edtEmitLogradouro1: TEdit;
    edtEmitNumero1: TEdit;
    edtEmitRazao1: TEdit;
    edtEmitUF1: TEdit;
    DBEdit1: TEdit;
    DBEdit2: TEdit;
    DBEdit3: TEdit;
    edtNumCte10: TEdit;
    edtNumCte11: TEdit;
    edtNumCte12: TEdit;
    edtNumCte13: TEdit;
    edtNumCte15: TEdit;
    edtNumCte16: TEdit;
    edtNumCte17: TEdit;
    edtNumCte18: TEdit;
    edtNumCte19: TEdit;
    edtSmtpHost: TEdit;
    edtRodRNTRC: TEdit;
    edtOutrosDesc: TEdit;
    edtOutrosNum: TEdit;
    edtProxyPorta: TEdit;
    edtProxySenha: TEdit;
    edtProxyUser: TEdit;
    edtEmailAssunto: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBoxTomador: TGroupBox;
    GroupBoxRemetente: TGroupBox;
    GroupBoxRecebedor: TGroupBox;
    GroupBoxExpeditor: TGroupBox;
    GroupBoxDestinatario: TGroupBox;
    GroupBox7: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    lblEmailAssunto: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label9: TLabel;
    lblDetRetira1: TStaticText;
    MemoDados: TMemo;
    mmEmailMsg: TMemo;
    memxObs: TMemo;
    rgTipoDACTe: TRadioGroup;
    rgTipoAmb: TRadioGroup;
    rgRodLotacao: TRadioGroup;
    sbtnCaminhoCert: TSpeedButton;
    TabSheet12: TTabSheet;
    TabRodoviario: TTabSheet;
    TabSheet17: TTabSheet;
    valOutrosVal: TEdit;
    dataOutrosEmi: TEdit;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    TabCteGeradas: TTabSheet;
    valAliIn: TEdit;
    StaticText30: TStaticText;
    valpICMS: TEdit;
    dbValInfCarga13: TEdit;
    valAliInter: TEdit;
    valIMCSPartF: TEdit;
    dbValInfCarga16: TEdit;
    dbValInfCarga17: TEdit;
    valICMSPartI: TEdit;
    dbValReceber: TEdit;
    dbValTotTri: TEdit;
    valpRedBC: TEdit;
    valvBC: TEdit;
    valvICMS: TEdit;
    valvCred: TEdit;
    edtProPred: TEdit;
    edtOutCat: TEdit;
    edtCodEmitente: TEdit;
    edtEmitBairro: TEdit;
    edtCaracAdTrans: TEdit;
    edtCaracAdServ: TEdit;
    edtFuncEmi: TEdit;
    edtRecBairro: TEdit;
    edtDestBairro: TEdit;
    edtRecBusca: TEdit;
    edtDestBusca: TEdit;
    edtRecCep: TEdit;
    edtDestCEP: TEdit;
    edtRecCidade: TEdit;
    edtDestCidade: TEdit;
    edtRecCNPJ: TEdit;
    edtDestCNPJ: TEdit;
    edtRecCodCidade: TEdit;
    edtDestCodCidade: TEdit;
    edtRecComp: TEdit;
    edtDestComp: TEdit;
    edtRecEnd: TEdit;
    edtDestEnd: TEdit;
    edtRecFone: TEdit;
    edtDestFone: TEdit;
    edtRecIE: TEdit;
    edtDestIE: TEdit;
    edtRecNome: TEdit;
    edtDestNome: TEdit;
    edtRecNum: TEdit;
    edtDestNum: TEdit;
    edtRecRazao: TEdit;
    edtDestRazao: TEdit;
    edtRecUF: TEdit;
    edtDestUF: TEdit;
    edtRemBairro: TEdit;
    edtEmitCEP: TEdit;
    edtExpBairro: TEdit;
    edtExpBusca: TEdit;
    edtBairroTomador: TEdit;
    edtBuscaTomador: TEdit;
    edtRemCep: TEdit;
    edtEmitCidade: TEdit;
    edtExpCep: TEdit;
    edtCepTomador: TEdit;
    edtRemCidade: TEdit;
    edtEmitCNPJ: TEdit;
    edtEmitCodCidade: TEdit;
    edtExpCidade: TEdit;
    edtExpCNPJ: TEdit;
    edtTomadorCidade: TEdit;
    edtCNPJTomador: TEdit;
    edtRemCodCidade: TEdit;
    edtEmitComp: TEdit;
    edtExpCodCidade: TEdit;
    edtTomadorCodCidade: TEdit;
    edtRemComp: TEdit;
    edtEmitFantasia: TEdit;
    edtEmitFone: TEdit;
    edtExpComp: TEdit;
    edtExpEnd: TEdit;
    edtCompTomador: TEdit;
    edtEndTomador: TEdit;
    edtRemFone: TEdit;
    edtEmitIE: TEdit;
    edtEmitLogradouro: TEdit;
    edtRemEnd: TEdit;
    edtEmitNumero: TEdit;
    edtExpFone: TEdit;
    edtExpIE: TEdit;
    edtExpNome: TEdit;
    edtFoneTomador: TEdit;
    edtIETomador: TEdit;
    edtNomeTomador: TEdit;
    edtRemNum: TEdit;
    edtEmitRazao: TEdit;
    edtEmitUF: TEdit;
    edtExpNum: TEdit;
    edtExpRazao: TEdit;
    edtNumTomador: TEdit;
    edtRazaoTomador: TEdit;
    edtRemUF: TEdit;
    edtModelo: TEdit;
    edtNumCte: TEdit;
    edtNumCte1: TEdit;
    edtNumCte2: TEdit;
    edtNumCte3: TEdit;
    edtEnvUF: TEdit;
    edtEnvCidade: TEdit;
    edtIniUF: TEdit;
    edtIniCidade: TEdit;
    edtFimUF: TEdit;
    edtFimCidade: TEdit;
    edtRemBusca: TEdit;
    edtRemCNPJ: TEdit;
    edtRemIE: TEdit;
    edtRemNome: TEdit;
    edtRemRazao: TEdit;
    edtExpUF: TEdit;
    edtTomadorUF: TEdit;
    edtSerieCte: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label7: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label8: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    lblDetRetira: TStaticText;
    memDetRetira: TMemo;
    memDetRetira1: TMemo;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    PageControl4: TPageControl;
    Panel1: TPanel;
    rgFormaEmissao: TRadioGroup;
    rgGlobalizado: TRadioGroup;
    rgModal: TRadioGroup;
    rgModal1: TRadioGroup;
    rgForPag: TRadioGroup;
    rgDest: TRadioGroup;
    rgRetira: TRadioGroup;
    rgTiposCte: TRadioGroup;
    rgTipoServico: TRadioGroup;
    rgRec: TRadioGroup;
    rgTomador: TRadioGroup;
    rgRem: TRadioGroup;
    rgExp: TRadioGroup;
    StaticText1: TStaticText;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    StaticText16: TStaticText;
    StaticText18: TStaticText;
    StaticText19: TStaticText;
    StaticText2: TStaticText;
    StaticText20: TStaticText;
    StaticText21: TStaticText;
    StaticText22: TStaticText;
    StaticText23: TStaticText;
    StaticText24: TStaticText;
    StaticText25: TStaticText;
    StaticText26: TStaticText;
    StaticText27: TStaticText;
    StaticText28: TStaticText;
    StaticText29: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    TabSheet1: TTabSheet;
    TabServicosImpostos: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet16: TTabSheet;
    TabSheet18: TTabSheet;
    TabSheet19: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet20: TTabSheet;
    TabSheet21: TTabSheet;
    TabInfoCarga: TTabSheet;
    TabSheet3: TTabSheet;
    TabTomador: TTabSheet;
    TabDadosCte: TTabSheet;
    TabSheet6: TTabSheet;
    TabExpedidor: TTabSheet;
    TabRecebedor: TTabSheet;
    TabDestinatario: TTabSheet;
    procedure BitBtn20Click(Sender: TObject);
    procedure btnStatusServClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure dbValInfCargaChange(Sender: TObject);
    procedure edtCodEmitente1Change(Sender: TObject);
    procedure mmEmailMsgChange(Sender: TObject);
    procedure rgDestClick(Sender: TObject);
    procedure rgExpClick(Sender: TObject);
    procedure rgRecClick(Sender: TObject);
    procedure rgRemClick(Sender: TObject);
    procedure rgTomadorClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
    procedure StaticText13Click(Sender: TObject);
    procedure StaticText6Click(Sender: TObject);
    procedure StaticText7Click(Sender: TObject);
    procedure TabCteGeradasShow(Sender: TObject);
    procedure TabDadosCteShow(Sender: TObject);
    procedure TabExpedidorShow(Sender: TObject);
    procedure TabInfoCargaShow(Sender: TObject);
    procedure TabRecebedorShow(Sender: TObject);
    procedure TabRodoviarioShow(Sender: TObject);
    procedure TabServicosImpostosShow(Sender: TObject);
    procedure TabSheet12ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabInfoCargaContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabDestinatarioShow(Sender: TObject);
    procedure TabTomadorShow(Sender: TObject);
  private
    modoGravacao : string;
    val_genCte : integer;
    val0 , val1, val2 : Double;
    valC :string;
    strInsere , strEndereco : string;
    generetor, genCLI,genEnd : integer;
    pVALPREDBC,pVALVBC,pVALPICMS,pVALVICMS,pVALVCRED : Double;
    percent_icms: Double;
    vDup : integer;
    procedure GravarConfiguracao;
    procedure DadosBasicos;
    procedure LerConfiguracao;
    procedure EditarRe;
    procedure GerarCTe(NumCTe : String);
    function LimparString(ATExto, ACaracteres: string): string;
  public

  end;

var
  fCTePrincipal: TfCTePrincipal;
const
  SELDIRHELP = 1000;

implementation

uses udmpdv, uDmCte, uNFe;

{$R *.lfm}

{ TfCTePrincipal }





procedure TfCTePrincipal.StaticText7Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.TabCteGeradasShow(Sender: TObject);
  var vDate1 , vDate2 : TdateTime;
begin
  vDate1 := StartOfTheMonth(today);
  DateTimePicker1.Date := vDate1 ;
  vDate2 := today;
  DateTimePicker2.Date := vDate2 ;
end;

procedure TfCTePrincipal.TabDadosCteShow(Sender: TObject);
begin
  edtSerieCte.SetFocus;
end;

procedure TfCTePrincipal.TabExpedidorShow(Sender: TObject);
begin
  edtExpBusca.SetFocus;
end;

procedure TfCTePrincipal.TabInfoCargaShow(Sender: TObject);
begin
  if(modoGravacao = 'INCLUIR')then
  begin
    btnGravarCTe.Click;
  end;
  dbValInfCarga.SetFocus;
  //TODO
  //Lazarus-Cte
  {
  if(edtNumCte.Text <> '') then
  begin
      if not(dm.qQC.Active)then
    dm.qQC.Active;
    dm.qQC.Params[0].AsInteger := val_genCte;
    dm.qQC.Open;
  end;}
end;

procedure TfCTePrincipal.TabRecebedorShow(Sender: TObject);
begin
  edtRecBusca.SetFocus;
end;

procedure TfCTePrincipal.TabRodoviarioShow(Sender: TObject);
begin
  edtRodRNTRC.SetFocus;
end;

procedure TfCTePrincipal.TabServicosImpostosShow(Sender: TObject);
begin
 if(modoGravacao = 'INCLUIR')then
 begin
   btnGravarCTe.Click;
 end;
 //Lazarus-Cte
 {
 if(edtNumCte.Text <> '') then
 begin
   if not(dm.qCOMP.Active)then
     dm.qCOMP.Active;
   dm.qCOMP.Params[0].AsInteger := val_genCte;
   dm.qCOMP.Open;
 end;
 }
 CheckBox1.Enabled := False;
 calValB.Enabled := False;
 valAliIn.Enabled := False;
 valAliInter.Enabled := False;
 valICMSPartI.Enabled := False;
 valIMCSPartF.Enabled := False;
 //Lazarus-Cte
 //valCombIni.Enabled := False;
 //valCombFim.Enabled := False;
end;

procedure TfCTePrincipal.TabSheet12ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TfCTePrincipal.TabInfoCargaContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TfCTePrincipal.TabDestinatarioShow(Sender: TObject);
begin
  edtDestBusca.SetFocus;
end;

procedure TfCTePrincipal.TabTomadorShow(Sender: TObject);
begin
  edtBuscaTomador.SetFocus;
end;

procedure TfCTePrincipal.GravarConfiguracao;
var
  IniFile    : String;
  Ini        : TIniFile;
  StreamMemo : TMemoryStream;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini');
  DadosBasicos;
  Ini := TIniFile.Create( IniFile );
  try
    Ini.WriteString( 'Certificado','Caminho' ,edtCaminho.Text);
    Ini.WriteString( 'Certificado','Senha'   ,edtSenha.Text);
    Ini.WriteString( 'Certificado','NumSerie',edtNumSerie.Text);

    Ini.WriteInteger( 'Geral','DACTE'       ,rgTipoDACTe.ItemIndex);
    Ini.WriteInteger( 'Geral','FormaEmissao',rgFormaEmissao.ItemIndex);
    Ini.WriteInteger( 'Geral','TipoServico',rgTipoServico.ItemIndex);
    Ini.WriteString( 'Geral','LogoMarca'   ,edtLogoMarca.Text);
    Ini.WriteBool(   'Geral','Salvar'      ,ckSalvar.Checked);
    Ini.WriteString( 'Geral','PathSalvar'  ,edtPathLogs.Text);

    Ini.WriteString( 'WebService','UF'        ,cbUF.Text);
    Ini.WriteInteger( 'WebService','Ambiente'  ,rgTipoAmb.ItemIndex);
    Ini.WriteBool(   'WebService','Visualizar',ckVisualizar.Checked);

    Ini.WriteString( 'Proxy','Host'   ,edtProxyHost.Text);
    Ini.WriteString( 'Proxy','Porta'  ,edtProxyPorta.Text);
    Ini.WriteString( 'Proxy','User'   ,edtProxyUser.Text);
    Ini.WriteString( 'Proxy','Pass'   ,edtProxySenha.Text);

    Ini.WriteString( 'Emitente','CNPJ'       ,edtEmitCNPJ.Text);
    Ini.WriteString( 'Emitente','IE'         ,edtEmitIE.Text);
    Ini.WriteString( 'Emitente','RazaoSocial',edtEmitRazao.Text);
    Ini.WriteString( 'Emitente','Fantasia'   ,edtEmitFantasia.Text);
    Ini.WriteString( 'Emitente','Fone'       ,edtEmitFone.Text);
    Ini.WriteString( 'Emitente','CEP'        ,edtEmitCEP.Text);
    Ini.WriteString( 'Emitente','Logradouro' ,edtEmitLogradouro.Text);
    Ini.WriteString( 'Emitente','Numero'     ,edtEmitNumero.Text);
    Ini.WriteString( 'Emitente','Complemento',edtEmitComp.Text);
    Ini.WriteString( 'Emitente','Bairro'     ,edtEmitBairro.Text);
    Ini.WriteString( 'Emitente','CodCidade'  ,edtEmitCodCidade.Text);
    Ini.WriteString( 'Emitente','Cidade'     ,edtEmitCidade.Text);
    Ini.WriteString( 'Emitente','UF'         ,edtEmitUF.Text);

    Ini.WriteString( 'Email','Host'    ,edtSmtpHost.Text);
    Ini.WriteString( 'Email','Port'    ,edtSmtpPort.Text);
    Ini.WriteString( 'Email','User'    ,edtSmtpUser.Text);
    Ini.WriteString( 'Email','Pass'    ,edtSmtpPass.Text);
    Ini.WriteString( 'Email','Assunto' ,edtEmailAssunto.Text);
    Ini.WriteBool(   'Email','SSL'     ,cbEmailSSL.Checked );

    // cte-lazarus
    //Ini.WriteFloat('ICMS','Percentual' , dmCte.cdsCTEVALPICMS.AsFloat);

    StreamMemo := TMemoryStream.Create;
    mmEmailMsg.Lines.SaveToStream(StreamMemo);
    StreamMemo.Seek(0,soFromBeginning);
    Ini.WriteBinaryStream( 'Email','Mensagem',StreamMemo);

    StreamMemo.Free;
  finally
    Ini.Free;
  end;

end;

procedure TfCTePrincipal.DadosBasicos;
begin
  if (not dmPdv.sqEmpresa.Active) then
  begin
    dmPdv.sqEmpresa.Open;
    edtEmitCNPJ.Text     := dmPdv.sqEmpresaCNPJ_CPF.AsString;
    edtEmitIE.Text       := dmPdv.sqEmpresaIE_RG.AsString;
    edtEmitRazao.Text    := dmPdv.sqEmpresaRAZAO.AsString;
    edtEmitFantasia.Text := dmPdv.sqEmpresaEMPRESA.AsString;
    edtEmitFone.Text     := dmPdv.sqEmpresaFONE.AsString;
    edtEmitCEP.Text      := dmPdv.sqEmpresaCEP.AsString;
    edtEmitLogradouro.Text := dmPdv.sqEmpresaENDERECO.AsString;
    edtEmitNumero.Text   := dmPdv.sqEmpresaNUMERO.AsString;
    edtEmitComp.Text     := dmPdv.sqEmpresaLOGRADOURO.AsString;
    edtEmitBairro.Text   := dmPdv.sqEmpresaBAIRRO.AsString;
    edtEmitCodCidade.Text:= LimparString(dmPdv.sqEmpresaCD_IBGE.AsString,'-');
    edtEmitCidade.Text   := dmPdv.sqEmpresaCIDADE.AsString;
    edtEmitUF.Text       := dmPdv.sqEmpresaUF.AsString;

    edtSmtpHost.Text     := dmPdv.sqEmpresaSMTP.AsString;
    edtSmtpPort.Text     := dmPdv.sqEmpresaPORTA.AsString;
    edtSmtpUser.Text     := dmPdv.sqEmpresaE_MAIL.AsString;
    edtSmtpPass.Text     := dmPdv.sqEmpresaSENHA.AsString;
    edtEmailAssunto.Text := dmPdv.sqEmpresaDIVERSOS1.AsString;
    cbEmailSSL.Checked   := cbEmailSSL.Checked;

    dmPdv.sqEmpresa.Close;
  end;
end;

procedure TfCTePrincipal.LerConfiguracao;
var
 IniFile    : String;
 Ini        : TIniFile;
 Ok         : Boolean;
 StreamMemo : TMemoryStream;
begin
 IniFile := ChangeFileExt( Application.ExeName, '.ini');

 Ini := TIniFile.Create( IniFile );
 try
  {$IFDEF ACBrCTeOpenSSL}
   edtCaminho.Text  := Ini.ReadString( 'Certificado','Caminho' ,'');
   edtSenha.Text    := Ini.ReadString( 'Certificado','Senha'   ,'');

   ACBrCTe1.Configuracoes.Certificados.Certificado  := edtCaminho.Text;
   ACBrCTe1.Configuracoes.Certificados.Senha        := edtSenha.Text;
   edtNumSerie.Visible := False;
   Label25.Visible     := False;
   sbtnGetCert.Visible := False;
  {$ELSE}
   edtNumSerie.Text := Ini.ReadString( 'Certificado','NumSerie','');
   ACBrCTe1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;
   //edtNumSerie.Text := ACBrCTe1.Configuracoes.Certificados.NumeroSerie;
   Label1.Caption := 'Informe o número de série do certificado'#13+
                     'Disponível no Internet Explorer no menu'#13+
                     'Ferramentas - Opções da Internet - Conteúdo '#13+
                     'Certificados - Exibir - Detalhes - '#13+
                     'Número do certificado';
   Label2.Visible     := False;
   edtCaminho.Visible := False;
   edtSenha.Visible   := False;
   sbtnCaminhoCert.Visible := False;
  {$ENDIF}

  rgFormaEmissao.ItemIndex := Ini.ReadInteger('Geral','FormaEmissao',0);

  ckSalvar.Checked         := Ini.ReadBool(   'Geral','Salvar'      ,True);
  edtPathLogs.Text         := Ini.ReadString( 'Geral','PathSalvar'  ,'');

  percent_icms     := Ini.ReadFloat( 'ICMS','Percentual'   , 0);

  case rgFormaEmissao.ItemIndex of
   0: ACBrCTe1.Configuracoes.Geral.FormaEmissao := teNormal;
   1: ACBrCTe1.Configuracoes.Geral.FormaEmissao := teDPEC; // o mesmo que EPEC
   2: ACBrCTe1.Configuracoes.Geral.FormaEmissao := teFSDA;
   3: ACBrCTe1.Configuracoes.Geral.FormaEmissao := teSVCRS;
   4: ACBrCTe1.Configuracoes.Geral.FormaEmissao := tESVCSP;
  end;

  ACBrCTe1.Configuracoes.Geral.Salvar := ckSalvar.Checked;

  ACBrCTe1.Configuracoes.Arquivos.PathSalvar := edtPathLogs.Text;

  cbUF.ItemIndex       := cbUF.Items.IndexOf(Ini.ReadString('WebService','UF','SP'));
  rgTipoAmb.ItemIndex  := Ini.ReadInteger('WebService','Ambiente'  ,0);
  ckVisualizar.Checked :=Ini.ReadBool(    'WebService','Visualizar',False);
  ACBrCTe1.Configuracoes.WebServices.UF         := cbUF.Text;
  ACBrCTe1.Configuracoes.WebServices.Ambiente   := StrToTpAmb(Ok,IntToStr(rgTipoAmb.ItemIndex+1));
  ACBrCTe1.Configuracoes.WebServices.Visualizar := ckVisualizar.Checked;

  edtProxyHost.Text  := Ini.ReadString( 'Proxy','Host'   ,'');
  edtProxyPorta.Text := Ini.ReadString( 'Proxy','Porta'  ,'');
  edtProxyUser.Text  := Ini.ReadString( 'Proxy','User'   ,'');
  edtProxySenha.Text := Ini.ReadString( 'Proxy','Pass'   ,'');
  ACBrCTe1.Configuracoes.WebServices.ProxyHost := edtProxyHost.Text;
  ACBrCTe1.Configuracoes.WebServices.ProxyPort := edtProxyPorta.Text;
  ACBrCTe1.Configuracoes.WebServices.ProxyUser := edtProxyUser.Text;
  ACBrCTe1.Configuracoes.WebServices.ProxyPass := edtProxySenha.Text;

  rgTipoDACTe.ItemIndex   := Ini.ReadInteger('Geral','DACTE'       ,0);
  rgTipoServico.ItemIndex := Ini.ReadInteger('Geral','TipoServico' ,0);
  edtLogoMarca.Text       := Ini.ReadString ('Geral','LogoMarca'   ,'');

  if ACBrCTe1.DACTe <> nil then
   begin
    ACBrCTe1.DACTe.TipoDACTe    := StrToTpImp(OK,IntToStr(rgTipoDaCTe.ItemIndex+1));
    ACBrCTe1.DACTe.Logo         := edtLogoMarca.Text;
    ACBrCTe1.DACTe.PathPDF      := edtPathLogs.Text;
    ACBrCTe1.DACTe.TamanhoPapel := tpA4_2vias;
   end;

  edtEmitCNPJ.Text       := Ini.ReadString( 'Emitente','CNPJ'       ,'');
  edtEmitIE.Text         := Ini.ReadString( 'Emitente','IE'         ,'');
  edtEmitRazao.Text      := Ini.ReadString( 'Emitente','RazaoSocial','');
  edtEmitFantasia.Text   := Ini.ReadString( 'Emitente','Fantasia'   ,'');
  edtEmitFone.Text       := Ini.ReadString( 'Emitente','Fone'       ,'');
  edtEmitCEP.Text        := Ini.ReadString( 'Emitente','CEP'        ,'');
  edtEmitLogradouro.Text := Ini.ReadString( 'Emitente','Logradouro' ,'');
  edtEmitNumero.Text     := Ini.ReadString( 'Emitente','Numero'     ,'');
  edtEmitComp.Text       := Ini.ReadString( 'Emitente','Complemento','');
  edtEmitBairro.Text     := Ini.ReadString( 'Emitente','Bairro'     ,'');
  edtEmitCodCidade.Text  := Ini.ReadString( 'Emitente','CodCidade'  ,'');
  edtEmitCidade.Text     := Ini.ReadString( 'Emitente','Cidade'     ,'');
  edtEmitUF.Text         := Ini.ReadString( 'Emitente','UF'         ,'');

  edtSmtpHost.Text      := Ini.ReadString( 'Email','Host'   ,'');
  edtSmtpPort.Text      := Ini.ReadString( 'Email','Port'   ,'');
  edtSmtpUser.Text      := Ini.ReadString( 'Email','User'   ,'');
  edtSmtpPass.Text      := Ini.ReadString( 'Email','Pass'   ,'');
  edtEmailAssunto.Text  := Ini.ReadString( 'Email','Assunto','');
  cbEmailSSL.Checked    := Ini.ReadBool(   'Email','SSL'    ,False);

  StreamMemo := TMemoryStream.Create;
  Ini.ReadBinaryStream( 'Email','Mensagem',StreamMemo);
  mmEmailMsg.Lines.LoadFromStream(StreamMemo);
  StreamMemo.Free;

  ACBrCTe1.MAIL.Host := edtSmtpHost.Text;
  ACBrCTe1.MAIL.Port := edtSmtpPort.Text;
  ACBrCTe1.MAIL.Username := edtSmtpUser.Text;
  ACBrCTe1.MAIL.Password := edtSmtpPass.Text;
  ACBrCTe1.MAIL.SetSSL   := cbEmailSSL.Checked;
  ACBrCTe1.MAIL.ReadingConfirmation := False;

 finally
  Ini.Free;
 end;


end;

procedure TfCTePrincipal.EditarRe;
var  strEdita :string;
begin
  if ((rgRec.ItemIndex = 1) and (edtNumCte.Text <> '')) then
  begin
    strEdita := 'UPDATE CTE SET ';

    strEdita := strEdita + ' RE_CNPJCPF = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_IESTADUAL = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_RSOCIAL = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_FANTASIA = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_TELEFONE = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_ENDERECO = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_NUMERO = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_COMPLEMENTO = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_BAIRRO = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_CODIGOMUNICIPI = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_CIDADE = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_CEP = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita + ' ,RE_ESTADO = ';
    strEdita := strEdita + QuotedStr('');

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;

    try
      dmPdv.IbCon.ExecuteDirect(strEdita);
      dmPdv.sTrans.Commit;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dmPdv.sTrans.Rollback;
        exit;
      end;
    end;
  end;

end;

procedure TfCTePrincipal.GerarCTe(NumCTe: String);
var
 i, j, CodigoMunicipio, Tomador: Integer;
 IE  : string;
begin

 // O código abaixo faz parte da minha aplicação devendo ser feitas as alterações
 // necessárias para ser utilizado na sua.


 with ACBrCTe1.Conhecimentos.Add.CTe do
  begin
   //
   // Dados de Identificação do CT-e
   //
   Ide.cUF:= 35; // Criar campo Tabela Empresa
   Ide.cCT:= StrToInt(edtNumCte.Text); //   Código Aleatório   Estou usando o mesmo do numero da CTE
   Ide.CFOP:= StrToInt(edtCFOP.Text);
   Ide.natOp:= edtNatOpe.Text;

   //if zEmpresaCODIGO.AsInteger = 0  // criar ou ver de onde vira

     // forma pgto
    case  rgForPag.ItemIndex of
    0: Ide.forPag := fpPago;
    1: Ide.forPag := fpAPagar;
    2: Ide.forPag := fpOutros;
   end;


   Ide.modelo:= 57 ;
   Ide.serie:= StrToInt(edtSerieCte.Text) ;// Criar ou ver da onde Vira DM_CNT.Conhec2Serie.AsInteger;
   Ide.nCT:= StrToInt(edtNumCte.Text);
   Ide.dhEmi:= dataGerarCte.DateTime;  // StringToDateTime(dataGerarCte.Text); //  Now;
   Ide.tpImp:= tiRetrato;

               // envio do CT-e       Inicio da Prestação




   // TpcnTipoEmissao = (teNormal, teContingencia, teSCAN, teDPEC, teFSDA);
   case rgFormaEmissao.ItemIndex of
    0: Ide.tpEmis:=teNormal;
    1: Ide.tpEmis:=teContingencia;
    2: Ide.tpEmis:=teSCAN;
    3: Ide.tpEmis:=teDPEC;
    4: Ide.tpEmis:=teFSDA;
   end;

   // TpcnTipoAmbiente = (taProducao, taHomologacao);
   case  rgTipoAmb.ItemIndex of
    0: Ide.tpAmb:=taProducao;
    1: Ide.tpAmb:=taHomologacao;
   end;

   // TpcteTipoCTe = (tcNormal, tcComplemento, tcAnulacao, tcSubstituto);
   case rgTipoDACTe.ItemIndex of
    0: Ide.tpCTe:=tcNormal;
    1: Ide.tpCTe:=tcComplemento;
    2: Ide.tpCTe:=tcAnulacao;
    3: Ide.tpCTe:=tcSubstituto;
   end;

   // TpcnProcessoEmissao = (peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco);
   Ide.procEmi := peAplicativoContribuinte;
   Ide.verProc:='2.0.42';  // = versaão do aplicativo da receita

   // Ide.refCTE:=''; // Chave de Acesso do CT-e Referenciado
   CodigoMunicipio:= StrToInt(LimparString(edtEmitCodCidade.Text,'-')); //StrToInt((35*100000) + LimparString(edtEmitCodCidade.Text,'-'))); /// fazer DM_CTA.EmpresaCodigoEstado.AsInteger * 100000 + DM_CTA.EmpresaCodigoMunicipio.AsInteger;
  //Ide.cMunEmi := StrToInt(LimparString(edtEmitCodCidade.Text,'-'));
  // Ide.xMunEmi := edtEmitLogradouro.Text;
  // Ide.UFEmi := edtEmitUF.Text;

   // TpcteModal = (mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario);

    // Ide.modal:= mdRodoviario;
    case rgModal.ItemIndex of
     0: Ide.modal:=mdRodoviario;
     1: Ide.modal:=mdAereo;
     //2: Ide.modal:=mdAquaviario;    // manoel não inlui no rgModal
     //3: Ide.modal:=mdFerroviario;
     //4: Ide.modal:=mdDutoviario;
     //5: Ide.modal:=mdMultimodal;
    end;


   // TpcteTipoServico = (tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario);
    case rgTipoServico.ItemIndex of
     0: Ide.tpServ:=tsNormal;
     1: Ide.tpServ:=tsSubcontratacao;
     2: Ide.tpServ:=tsRedespacho;
     3: Ide.tpServ:=tsIntermediario;
    end;
                               // incluir na aba Dados

    // Emissão
    Ide.cMunEnv := StrToInt(edtEnvCodCidade.Text);
    Ide.xMunEnv := edtEnvCidade.Text;
    Ide.UFEnv := edtEnvUF.Text;

    // Inicio da Prestação
    Ide.cMunIni:= StrToInt(edtIniCodCidade.Text); // DM_CNT.Conhec2CodCidadeColeta.AsInteger;
    Ide.xMunIni:= edtIniCidade.Text; //DM_CNT.Conhec2NomeCidadeColeta.AsString;
    Ide.UFIni:= edtIniUF.Text; // DM_CNT.Conhec2EstadoColeta.AsString;

    // Termino da Prestação
    Ide.cMunFim:= StrToInt(edtFimCodCidade.Text); // DM_CNT.Conhec2CodCidadeEntrega.AsInteger;
    Ide.xMunFim:= edtFimCidade.Text; // DM_CNT.Conhec2NomeCidadeEntrega.AsString;
    Ide.UFFim:= edtFimUF.Text; //DM_CNT.Conhec2EstadoEntrega.AsString;

    /////////// aba dados fim

    // TpcteRetira

    case rgRetira.ItemIndex of
     0: Ide.retira := rtSim;
     1: Ide.retira := rtNao;
    end;
    Ide.xdetretira := memDetRetira.Text;

                                         // Aba Tomador  inicio
   //0-Remetente; 1-Expedidor; 2-Recebedor; 3-Destinatário Serão utilizadas as informações contidas no respectivo grupo,

   // Lazarus-Cte
   //rgTomador.ItemIndex := dmCte.cdsCTETOMADORSERVICO.AsInteger;

    case rgTomador.ItemIndex of
      0: rgTomador.ItemIndex := 0;
      1: rgTomador.ItemIndex := 1;
      2: rgTomador.ItemIndex := 2;
      3: rgTomador.ItemIndex := 3;
      4: rgTomador.ItemIndex := 4;
    end;

    case rgTomador.ItemIndex of
      0 : Ide.toma03.Toma := tmRemetente ;
      1 : Ide.toma03.Toma := tmExpedidor ;
      2 : Ide.toma03.Toma := tmRecebedor ;
      3 : Ide.toma03.Toma := tmDestinatario ;
    end;

   // Tomador do Serviço no CTe    4 = Outros
   if rgTomador.ItemIndex = 4  then
   begin
     Ide.Toma4.Toma:=tmOutros;
     if copy(edtCNPJTomador.text,10,4)<>'0000'
          then begin
           Ide.Toma4.CNPJCPF := edtCNPJTomador.Text ; // Copy(edtCNPJTomador.Text, 2, 14);
           IE := edtIETomador.Text;
          end
          else begin
           Ide.Toma4.CNPJCPF := Copy(edtCNPJTomador.Text, 1, 9) +
                                   Copy(edtCNPJTomador.Text, 14, 2);
           IE := 'ISENTO';
          end;

     Ide.toma4.IE:= IE;

     Ide.Toma4.xNome:= edtNomeTomador.Text;
     Ide.Toma4.xFant:= edtRazaoTomador.Text;
     Ide.Toma4.fone:= edtFoneTomador.Text;
     Ide.Toma4.EnderToma.xLgr:= edtEndTomador.Text;
     Ide.Toma4.EnderToma.nro:= edtNumTomador.Text;
     Ide.Toma4.EnderToma.xCpl:= edtCompTomador.Text;
     Ide.Toma4.EnderToma.xBairro:= edtBairroTomador.Text;

     CodigoMunicipio:= StrToInt(LimparString(edtTomadorCodCidade.Text,'-'));
     Ide.Toma4.EnderToma.cMun:= CodigoMunicipio;
     Ide.Toma4.EnderToma.xMun:= edtTomadorCidade.Text;
     Ide.Toma4.EnderToma.CEP:= StrToInt(LimparString(edtCepTomador.TExt,'-')); //StrToIntDef(edtCepTomador.TExt, 0); 199
     Ide.Toma4.EnderToma.UF:= edtTomadorUF.Text;
     Ide.Toma4.EnderToma.cPais:= 1058 ; //////////////////// manoel
     Ide.Toma4.EnderToma.xPais:= 'BRASIL';                  ///manoel
    end;
                                         // Aba Tomador  fim

   //
   //  Informações Complementares do CTe     Aba Dados Complementares inicio
   //
   compl.xCaracAd := Trim(edtCaracAdTrans.Text);
   compl.xCaracSer := Trim(edtCaracAdServ.Text);
   compl.xEmi := Trim(edtFuncEmi.Text);

   compl.xObs     := memxObs.Text;

   //                          Aba Emitente caregando dados da Empresa  Inicio
   // Dados do Emitente
   //
   // dm.zEmpresa.Close;
   // dm.zEmpresa.SQL.Clear;
   // dm.zEmpresa.SQL.Add('Select * From Empresa');
   // dm.zEmpresa.SQL.Add('Where RAZAO = ' + QuotedStr(comboEmpresa.Text));
   if (not dmPdv.sqEmpresa.Active) then
     dmPdv.sqEmpresa.Open;

   if(copy(dmPdv.sqEmpresaCNPJ_CPF.Text,10,4)<>'0000')then
   begin
     Emit.CNPJ := dmPdv.sqEmpresaCNPJ_CPF.Text;
     Emit.IE := dmPdv.sqEmpresaIE_RG.Text;
   end
   else begin
     Emit.CNPJ := Copy(dmPdv.sqEmpresaCNPJ_CPF.Text, 1, 9) +
       Copy(dmPdv.sqEmpresaCNPJ_CPF.Text, 14, 2);
       Emit.IE := 'ISENTO';
     end;

    Emit.xNome := dmPdv.sqEmpresaRAZAO.AsString;
    Emit.xFant := dmPdv.sqEmpresaEMPRESA.AsString;
    Emit.EnderEmit.xLgr := dmPdv.sqEmpresaENDERECO.AsString;
    Emit.EnderEmit.nro := dmPdv.sqEmpresaNUMERO.AsString;
    Emit.EnderEmit.xCpl := dmPdv.sqEmpresaLOGRADOURO.AsString;
    Emit.EnderEmit.xBairro := dmPdv.sqEmpresaBAIRRO.AsString;
    /// refazer aqui ta errado
    //  CodigoMunicipio := StrToInt(dm.zEmpresaCD_IBGE.AsString);
    CodigoMunicipio := StrToInt(LimparString(dmPdv.sqEmpresaCD_IBGE.AsString,'-'));
    Emit.EnderEmit.cMun := CodigoMunicipio;

    Emit.EnderEmit.xMun := dmPdv.sqEmpresaCIDADE.AsString;
    Emit.EnderEmit.CEP := StrToIntDef(dmPdv.sqEmpresaCEP.AsString, 0);
    Emit.EnderEmit.UF := dmPdv.sqEmpresaUF.AsString;
    ////Emit.enderEmit.cPais := 1058; // manoel Obs ver se precisar refazer
    ////Emit.EnderEmit.xPais := 'Brasil' ; //manoel Obs ver se precisar refazer
    Emit.EnderEmit.fone := dmPdv.sqEmpresaDDD.AsString + '-' + dmPdv.sqEmpresaFONE.AsString;

    //  Aba Emitente Fim

    //
    //  Dados do Remetente
    //
                          // aba Remetente  inicio

    if trim(edtRemCNPJ.Text)<>'' then
    begin
      Rem.xNome:= edtRemRazao.Text;
      Rem.xFant:= edtRemNome.Text;
      Rem.EnderReme.xLgr:= edtRemEnd.Text;
      Rem.EnderReme.nro:= edtRemNum.Text;
      Rem.EnderReme.xCpl:= edtRemComp.Text;
      Rem.EnderReme.xBairro:= edtRemBairro.Text;

      CodigoMunicipio:= StrToInt(LimparString(edtRemCodCidade.Text,'-'));

      Rem.EnderReme.cMun := CodigoMunicipio;
      Rem.EnderReme.xMun := edtRemCidade.Text;
      Rem.EnderReme.CEP :=  StrToInt(LimparString(edtRemCep.Text,'-')); //StrToIntDef(edtRemCep.Text, 0); 199
      Rem.EnderReme.UF := edtRemUF.Text;
      Rem.EnderReme.cPais := 1058 ; ///  manoel DM_CTA.PessoaFJCodigoPais.AsInteger;
      Rem.EnderReme.xPais := 'BRASIL' ; /// manoel DM_CTA.PessoaFJPais.AsString;


      if copy(edtRemCNPJ.Text,10,4)<>'0000'
      then begin
        Rem.CNPJCPF := edtRemCNPJ.Text;
        IE := edtRemIE.Text;
      end
      else begin
        Rem.CNPJCPF := Copy(edtRemCNPJ.Text, 1, 9) +
                          Copy(edtRemCNPJ.Text, 14, 2);
        IE := 'ISENTO';
      end;

      Rem.IE:=IE;
      Rem.fone:= edtRemFone.Text; // manoel trocar depois quando tive endereço

    end;

   // parcial nf   StringToFloat(Format('%8.2f', [calValCarga.Value]));

    //info Documentos

    //Lazarus-Cte
    {
    if not(dm.cdsNFe.Active)then
    begin
      dm.cdsNFe.Params[0].AsInteger := val_genCte;
      dm.cdsNFe.Open;
    end;

    dm.cdsNFe.First;
    while( not dm.cdsNFe.Eof) do begin
      with infCTeNorm.infDoc.infNFe.Add do
      begin
        chave := dm.cdsNFeCHAVE.AsString;
        PIN := dm.cdsNFePIN.AsString;
        dPrev := dm.cdsNFeDPREV.Value; // ; FormatDateTime('mm/dd/yyyy',dm.cdsNFeDPREV.Text); //dm.cdsNFeDPREV.AsString;
      end;
      dm.cdsNFe.Next;
    end;
    dm.cdsNFe.Close;
    }
   case  rgGlobalizado.ItemIndex of
    1: Ide.indGlobalizado :=tiSim;
    0: Ide.indGlobalizado :=tiNao;
   end;
   // Lazarus-Cte
   {
    if(fNF.edtNFserie.Text <> '') then
    begin
      with infCTeNorm.infDoc.infNF.Add do
      begin
        nRoma := fNF.edtNFRoma.Text;
        nPed  := fNF.edtNFNumP.Text;
        serie := fNF.edtNFserie.Text;
        nDoc  := fNF.edtNFNum.Text;

        // case comboNFModelo.ItemIndex of     FALTA AQUI 08/11/2013

        dEmi  := StrToDate(fNF.dataNFEmi.Text); //  DM_CNT.NotasEmissaoNF.AsDateTime;
        vBC   := StringToFloat(Format('%8.2f', [fNF.valNFBase.Value])); //RoundTo(DM_CNT.NotasValorBCICMS.AsFloat, -2);
        vICMS := StringToFloat(Format('%8.2f', [fNF.valNFICMS.Value]));//RoundTo(DM_CNT.NotasValorICMS.AsFloat, -2);
        vBCST := StringToFloat(Format('%8.2f', [fNF.valNFBaseST.Value])); //RoundTo(DM_CNT.NotasValorBCICMSST.AsFloat, -2);
        vST   := StringToFloat(Format('%8.2f', [fNF.valNFICMSST.Value])); //RoundTo(DM_CNT.NotasValorICMSST.AsFloat, -2);
        vProd := StringToFloat(Format('%8.2f', [fNF.valNFValProd.Value])); //RoundTo(DM_CNT.NotasValorProdutos.AsFloat, -2);
        vNF   := StringToFloat(Format('%8.2f', [fNF.valNFValor.Value]));//RoundTo(DM_CNT.NotasValorNF.AsFloat, -2);
        nCFOP := StrToInt(fNF.edtNFCFOP.Text); //DM_CNT.NotasCFOPNF.AsInteger;
        nPeso := StringToFloat(Format('%8.2f', [fNF.valNFPeso.Value])); //RoundTo(DM_CNT.NotasPesoKg.AsFloat, -2);
        PIN   := fNF.edtNFPin.Text; //DM_CNT.NotasPinSuframa.AsString;
      end
    end;
    }

    // Lazarus-Cte
    // aba Remetente fim
    {
    if(combOutrosDocs.Text <> '') then
    begin
      with infCTeNorm.infDoc.infOutros.Add do
      begin
        if(dm.cdsCTEOUTPDOC.AsString = '00' )then
        tpDoc := tdDeclaracao;
        if(dm.cdsCTEOUTPDOC.AsString = '99' )then
        tpDoc := tdOutros;

        dEmi       := dataOutrosEmi.DateTime;
        nDoc       := edtOutrosNum.Text;
        descOutros := edtOutrosDesc.Text;
        vDocFisc   := StringToFloat(Format('%8.2f', [valOutrosVal.Value])); // valOutrosVal.Value;
      end;
    end;}

   //
   //  Dados do Destinatario    // Aba Destinatarios Inicio

   //
    if(trim(edtDestCNPJ.Text)<>'') then
    begin
      Dest.xNome:= edtDestNome.Text ;//DM_CTA.PessoaFJRSocial.AsString;
      Dest.EnderDest.xLgr:= edtDestEnd.Text ;// DM_CTA.PessoaFJEndereco.AsString;
      Dest.EnderDest.nro:= edtDestNum.Text ;// DM_CTA.PessoaFJNumero.AsString;
      Dest.EnderDest.xCpl:= edtDestComp.Text ;//DM_CTA.PessoaFJComplemento.AsString;
      Dest.EnderDest.xBairro:= edtDestBairro.Text ;// DM_CTA.PessoaFJBairro.AsString;

      CodigoMunicipio:= StrToInt(LimparString(edtDestCodCidade.Text,'-'));

      Dest.EnderDest.cMun:= CodigoMunicipio;
      Dest.EnderDest.xMun:= edtDestCidade.Text ;//DM_CTA.PessoaFJCidade.AsString;
      Dest.EnderDest.CEP:= StrToInt(LimparString(edtDestCEP.Text,'-')); //StrToIntDef(edtDestCEP.Text, 0); 199
      Dest.EnderDest.UF:= edtDestUF.Text ;// DM_CTA.PessoaFJEstado.AsString;
      Dest.EnderDest.cPais:= 1058 ;//  manoel DM_CTA.PessoaFJCodigoPais.AsInteger;
      Dest.EnderDest.xPais:= 'BRASIL' ; // manoelDM_CTA.PessoaFJPais.AsString;

      if (copy(edtDestCNPJ.Text,10,4)<>'0000') then
      begin
        Dest.CNPJCPF := edtDestCNPJ.Text;
        Dest.IE := edtDestIE.Text;
      end
      else begin
        Dest.CNPJCPF := Copy(edtDestCNPJ.Text, 1, 9) + Copy(edtDestCNPJ.Text, 14, 2);
        Dest.IE := 'ISENTO';
      end;
      ////Dest.IE:=IE;   manoel
      Dest.IE := edtDestIE.Text;
      // Manoel Inscrição na SUFRAMA
      Dest.fone:= edtDestFone.Text; //DM_CTA.PessoaFJTelefone.AsString;
      Dest.ISUF:= edtDestISUF.Text; // Trim(DM_CTA.PessoaFJInscSUF.AsString);
      // Aba Destinatarios Inicio Fim
    end;
    //
    //  Dados do Expedidor
    //
    if(rgExp.ItemIndex = 0)then
    begin
      Exped.xNome:= edtExpRazao.Text;
      Exped.EnderExped.xLgr:= edtExpEnd.Text;
      Exped.EnderExped.nro:= edtExpNum.Text;//DM_CTA.PessoaFJNumero.AsString;
      Exped.EnderExped.xCpl:= edtExpComp.Text;//DM_CTA.PessoaFJComplemento.AsString;
      Exped.EnderExped.xBairro:= edtExpBairro.Text;//DM_CTA.PessoaFJBairro.AsString;

      CodigoMunicipio:= StrToInt(LimparString(edtExpCodCidade.Text,'-'));
      Exped.EnderExped.cMun:=CodigoMunicipio;
      Exped.EnderExped.xMun:= edtExpCidade.Text;//DM_CTA.PessoaFJCidade.AsString;
      Exped.EnderExped.CEP:= StrToInt(LimparString(edtExpCep.Text,'-')); // StrToIntDef(edtExpCep.Text, 0); 199
      Exped.EnderExped.UF:= edtExpUF.Text;//DM_CTA.PessoaFJEstado.AsString;
      Exped.EnderExped.cPais:= 1058;// DM_CTA.PessoaFJCodigoPais.AsInteger;
      Exped.EnderExped.xPais:= 'BRASIL' ; //DM_CTA.PessoaFJPais.AsString;

      if copy(edtExpCNPJ.Text,10,4)<>'0000'
      then begin
        Exped.CNPJCPF := edtExpCNPJ.Text;
        IE := edtExpIE.Text;
      end
      else begin
        Exped.CNPJCPF := Copy(edtExpCNPJ.Text, 1, 9) +
                          Copy(edtExpCNPJ.Text, 14, 2);
        IE := 'ISENTO';
      end;

      Exped.IE:=IE;
      Exped.fone:= edtExpFone.Text;// DM_CTA.PessoaFJTelefone.AsString;
    end;
    // ABA RECEBEDOR
    //  Dados do Recebedor

    if (rgRec.ItemIndex = 0)then
    begin
      Receb.xNome:= edtRecRazao.Text;// DM_CTA.PessoaFJRSocial.AsString;
      Receb.EnderReceb.xLgr:= edtRecEnd.Text;// DM_CTA.PessoaFJEndereco.AsString;
      Receb.EnderReceb.nro:= edtRecNum.Text;// DM_CTA.PessoaFJNumero.AsString;
      Receb.EnderReceb.xCpl:= edtRecComp.Text;// DM_CTA.PessoaFJComplemento.AsString;
      Receb.EnderReceb.xBairro:= edtRecBairro.Text;// DM_CTA.PessoaFJBairro.AsString;

      CodigoMunicipio:= StrToInt(LimparString(edtRecCodCidade.Text,'-'));
      Receb.EnderReceb.cMun:=CodigoMunicipio;
      Receb.EnderReceb.xMun:= edtRecCidade.Text;// DM_CTA.PessoaFJCidade.AsString;
      Receb.EnderReceb.CEP:= StrToInt(LimparString(edtRecCep.Text,'-')); //StrToIntDef(edtRecCep.Text, 0); 199
      Receb.EnderReceb.UF:= edtRecUF.Text;// DM_CTA.PessoaFJEstado.AsString;
      Receb.EnderReceb.cPais:= 1058 ; //DM_CTA.PessoaFJCodigoPais.AsInteger;
      Receb.EnderReceb.xPais:= 'BRASIL' ; //DM_CTA.PessoaFJPais.AsString;

      if copy(edtRecCNPJ.Text,10,4)<>'0000'
      then begin
        Receb.CNPJCPF := edtRecCNPJ.Text;
        IE := edtRecIE.Text;
      end
      else begin
        Receb.CNPJCPF := Copy(edtRecCNPJ.Text, 1, 9) +
                          Copy(edtRecCNPJ.Text, 14, 2);
        IE := 'ISENTO';
      end;

      Receb.IE:=IE;
      Receb.fone:= edtRecFone.Text; /// DM_CTA.PessoaFJTelefone.AsString;
    end;

     // ABA Serviços e Impostos
     //  Valores da Prestação de Serviço
    // Lazarus-Cte
    {
    if (dbValTotPrest.Field.Value <> null) then
      vPrest.vTPrest :=  dbValTotPrest.Field.Value;// /RoundTo(DM_CNT.Conhec2ValorTotal.AsFloat, -2);
    if (dbValReceber.Field.Value <> null) then
      vPrest.vRec    :=  dbValReceber.Field.Value;//valReceber.Value; // RoundTo(DM_CNT.Conhec2ValorTotal.AsFloat, -2);

    if not(dm.cdsCOMP.Active)then
    begin
      dm.cdsCOMP.Params[0].AsInteger := val_genCte;
      dm.cdsCOMP.Open;
    end;

    while( not dm.cdsCOMP.Eof) do begin
      with vPrest.comp.Add do
      begin
        xNome := dm.cdsCOMPCOMP_NOME.AsString;
        vComp := dm.cdsCOMPCOMP_VALOR.AsFloat;
      end;
      dm.cdsCOMP.Next;
    end;
    dm.cdsCOMP.Close;
    }
    //  Docs Anterior 15/08/19

     with infCTeNorm.docAnt.emiDocAnt.Add do
     begin
       CNPJCPF  := edtAntCNPJ.Text;  // '31776232000160';
       xNome    := edtAntNome.Text; //'TRANS MOINHOS LOGISTICA LTDA';
       uf       := edtAntUF.Text;    // 'PR';
       ie       := edtAntIE.Text;  //'9079516349';

       with idDocAnt.Add do
       begin
         idDocAntEle.Add.chCTe := edtAntCHCTE.Text; //'41190731776232000160570010000415871000157434';
       end;
     end;

   //  Valores dos Impostos
   // TpcnCSTIcms = (cst00, cst10, cst20, cst30, cst40, cst41, cst45, cst50, cst51, cst60, cst70, cst80, cst81, cst90);
   // 80 e 81 apenas para CTe

   //Lazarus-Cte
   {
    case combCodSitTrib.ItemIndex of    //00 - Tributação Normal do ICMS
    0: begin
         Imp.ICMS.SituTrib     := cst00;
         Imp.ICMS.ICMS00.CST   := cst00;
         Imp.ICMS.ICMS00.vBC   := StrToFloat(dbVALVBC.Field.Value);
         Imp.ICMS.ICMS00.pICMS := StrToFloat(dbVALPICMS.Field.Value);
         Imp.ICMS.ICMS00.vICMS := StrToFloat(dbVALVICMS.Field.Value);             // valvICMS.Value;
       end;

    1: begin                        //20 - Tributação com Redulçao da BC do ICMS
         Imp.ICMS.SituTrib      := cst20;
         Imp.ICMS.ICMS20.CST    := cst20; // Tributação com BC reduzida do ICMS
         Imp.ICMS.ICMS20.pRedBC := StrToFloat(dbvalpRedBC.Field.Value); //RoundTo(DM_CNT.Conhec2ReducaoICMS.AsFloat, -2);
         Imp.ICMS.ICMS20.vBC    := StrToFloat(dbvalvBC.Field.Value); //RoundTo(DM_CNT.Conhec2BaseCalc.AsFloat, -2);
         Imp.ICMS.ICMS20.pICMS  := StrToFloat(dbvalpICMS.Field.Value); //RoundTo(DM_CNT.Conhec2AliqICMS.AsFloat, -2);
         Imp.ICMS.ICMS20.vICMS  := StrToFloat(dbvalvICMS.Field.Value); //RoundTo(DM_CNT.Conhec2ValorICMS.AsFloat, -2);
         end;

    2: begin                         // 40 - ICMS Isenção
         Imp.ICMS.SituTrib   := cst40;
         Imp.ICMS.ICMS45.CST := cst40;
       end;

    3: begin                       //41 - ICMS não Tributado
         Imp.ICMS.SituTrib   := cst41;
         Imp.ICMS.ICMS45.CST := cst41;
       end;

    4: begin                       //51 - ICMS Deferido
         Imp.ICMS.SituTrib   := cst51;
         Imp.ICMS.ICMS45.CST := cst51;
       end;

    5: begin                      //   60 - ICMS Cobrado Anteriormente por Substituição Tributária
         Imp.ICMS.SituTrib          := cst60;
         Imp.ICMS.ICMS60.CST        := cst60;
         Imp.ICMS.ICMS60.vBCSTRet   := StringToFloat(dbvalvBC.Field.Value);
         Imp.ICMS.ICMS60.vICMSSTRet := StringToFloat(dbvalpICMS.Field.Value);     // invertido
         Imp.ICMS.ICMS60.pICMSSTRet := StringToFloat(dbvalvICMS.Field.Value);     // invertido
         Imp.ICMS.ICMS60.vCred      := StringToFloat(dbvalvCred.Field.Value);
        end;
                                 // 90 - ICMS outros
    6: begin
         Imp.ICMS.SituTrib      := cst90;
         Imp.ICMS.ICMS90.CST    := cst90; // Tributação atribuida ao tomador ou 3. por ST
         Imp.ICMS.ICMS90.pRedBC := StringToFloat(dbvalpRedBC.Field.Value);
         Imp.ICMS.ICMS90.vBC    := StringToFloat(dbvalvBC.Field.Value);
         Imp.ICMS.ICMS90.pICMS  := StringToFloat(dbvalpICMS.Field.Value);
         Imp.ICMS.ICMS90.vICMS  := StringToFloat(dbvalvICMS.Field.Value);
         Imp.ICMS.ICMS90.vCred  := StringToFloat(dbvalvCred.Field.Value);
       end;

    7: begin                        // 90 - ICMS Outra UF
         Imp.ICMS.SituTrib      := cst90;
         Imp.ICMS.ICMS90.CST    := cst90;
         Imp.ICMS.ICMS90.pRedBC := StringToFloat(dbvalpRedBC.Field.Value); //RoundTo(DM_CNT.Conhec2ReducaoICMS.AsFloat, -2);
         Imp.ICMS.ICMS90.vBC    := StringToFloat(dbvalvBC.Field.Value); //RoundTo(DM_CNT.Conhec2BaseCalc.AsFloat, -2);
         Imp.ICMS.ICMS90.pICMS  := StringToFloat(dbvalpICMS.Field.Value); //RoundTo(DM_CNT.Conhec2AliqICMS.AsFloat, -2);
         Imp.ICMS.ICMS90.vICMS  := StringToFloat(dbvalvICMS.Field.Value); //RoundTo(DM_CNT.Conhec2ValorICMS.AsFloat, -2);
       // Imp.ICMS.ICMS90.vCred  := valvCred.Value; //RoundTo(DM_CNT.Conhec2CreditoICMS.AsFloat, -2);
       end;

    8: begin                    // 90 - SIMPLES NACIONAL
         Imp.ICMS.SituTrib := cstICMSSN ;
         Imp.ICMS.ICMSSN.indSN := 1;
       end;
    end;
    }

    //
    //  Informações da Carga
    //                                  //Format('%8.2f', [edPesoVol1.Value]);


    // Lazarus-Cte
    {
    infCTeNorm.infCarga.vCarga  := StringToFloat(dbValInfCarga.Field.Value);  //StringToFloat(calValCarga.Text); // RoundTo(DM_CNT.Conhec2ValorTotalNF.AsFloat, -2);arga.vMerc   :=  calValCarga.Text; // RoundTo(DM_CNT.Conhec2ValorTotalNF.AsFloat, -2);
    infCTeNorm.infCarga.proPred := edtProPred.Text; //DM_CNT.Conhec2Especie.AsString;
    infCTeNorm.infCarga.xOutCat := edtOutCat.Text; // DM_CNT.Conhec2Natureza.AsString;
    }

    //  Dados do Modal Rodoviário

    infCTeNorm.rodo.RNTRC := edtRodRNTRC.Text;
    infCTeNorm.rodo.dPrev := dataRodPrev.Date;

    case rgRodLotacao.ItemIndex of
      0: infCTeNorm.rodo.lota := ltNao;
      1: infCTeNorm.rodo.lota := ltsim;
    end;

    // Lazarus-Cte
    {
    if (not dm.cdsVeic.Active)then
    begin
      dm.cdsVeic.Params[0].AsInteger := val_genCte;
      dm.cdsVeic.Open;
    end;

    while( not dm.cdsVeic.Eof) do
    begin
      with infCTeNorm.rodo.veic.Add  do
      begin
        cInt  := dm.cdsVeicCINT.AsString ;
        RENAVAM := dm.cdsVeicRENAVAM.AsString ;
        placa := dm.cdsVeicPlaca.AsString ;
        tara := dm.cdsVeicTara.AsInteger ;
        capKG := dm.cdsVeicCAPKG.AsInteger ;
        capM3 := dm.cdsVeicCAPM3.AsInteger ;
        if(dm.cdsVeicTPPROP.AsString = 'P' )then
        tpProp  := tpProprio;
        if(dm.cdsVeicTPPROP.AsString = 'T' )then
        tpProp  := tpTerceiro;
        if(dm.cdsVeicTPVEIC.AsString = '0' )then
        tpVeic  := tvTracao;
        if(dm.cdsVeicTPVEIC.AsString = '1' )then
        tpVeic  := tvReboque;
        if(dm.cdsVeicTPCAR.AsString = '00' )then
        tpRod := trNaoAplicavel;
        if(dm.cdsVeicTPCAR.AsString = '01' )then
        tpRod := trTruck;
        if(dm.cdsVeicTPCAR.AsString = '02' )then
        tpRod := trToco;
        if(dm.cdsVeicTPCAR.AsString = '03' )then
        tpRod := trCavaloMecanico;
        if(dm.cdsVeicTPCAR.AsString = '04' )then
        tpRod := trVAN;
        if(dm.cdsVeicTPCAR.AsString = '05' )then
        tpRod := trUtilitario;
        if(dm.cdsVeicTPCAR.AsString = '06' )then
        tpRod := trOutros;
        if(dm.cdsVeicTPCAR.AsString = '00' )then
        tpCar := tcNaoAplicavel ;
        if(dm.cdsVeicTPCAR.AsString = '01' )then
        tpCar := tcAberta ;
        if(dm.cdsVeicTPCAR.AsString = '02' )then
        tpCar := tcFechada;
        if(dm.cdsVeicTPCAR.AsString = '03' )then
        tpCar := tcGraneleira;
        if(dm.cdsVeicTPCAR.AsString = '04' )then
        tpCar := tcPortaContainer;
        if(dm.cdsVeicTPCAR.AsString = '05' )then
        tpCar := tcSider;
        UF := dm.cdsVeicUF.AsString ;
        Prop.CNPJCPF := dm.cdsVeicCNPJ.AsString;
        Prop.RNTRC   := dm.cdsVeicRNTRC.AsString;
        Prop.xNome   := dm.cdsVeicNOME.AsString;
        if(dm.cdsVeicIE.Text = '')then
        Prop.IE      := 'ISENTO';
        if(dm.cdsVeicIE.Text <> '')then
        Prop.IE      := dm.cdsVeicIE.AsString;
        Prop.UF      := dm.cdsVeicVUF.AsString;

        if(dm.cdsVeicVTPPROP.AsString = '0' )then
        Prop.tpProp := tpTACAgregado;
        if(dm.cdsVeicVTPPROP.AsString = '1' )then
        Prop.tpProp := tpTACIndependente;
        if(dm.cdsVeicVTPPROP.AsString = '2' )then
        Prop.tpProp := tpOutros;

      end;
      dm.cdsVeic.Next;
    end;
    dm.cdsVeic.Close;
    }

    // Lazarus-Cte
    {
    if (not dm.cdsMot.Active)then
    begin
      dm.cdsMot.Params[0].AsInteger := val_genCte;
      dm.cdsMot.Open;
    end;

    while( not dm.cdsMot.Eof) do
    begin
      with infCTeNorm.rodo.moto.Add  do
        begin
          CPF  := dm.cdsMotCPF.AsString ;
          xNome := dm.cdsMotNOME.AsString ;
        end;
       dm.cdsMot.Next;
    end;
    dm.cdsMot.Close;

                                         // ABA SEGURO
    if (not dm.cdsSeg.Active)then
    begin
      dm.cdsSeg.Params[0].AsInteger := val_genCte;
      dm.cdsSeg.Open;
    end;

    while( not dm.cdsSeg.Eof) do begin
      with infCTeNorm.seg.Add do
      begin
        if(dm.cdsSegRESP.AsInteger = 0 )then
        respSeg  := rsRemetente;
        if(dm.cdsSegRESP.AsInteger = 1 )then
        respSeg  := rsExpedidor;
        if(dm.cdsSegRESP.AsInteger = 2 )then
        respSeg  := rsRecebedor;
        if(dm.cdsSegRESP.AsInteger = 3 )then
        respSeg  := rsDestinatario;
        if(dm.cdsSegRESP.AsInteger = 4 )then
        respSeg  := rsEmitenteCTe;
        if(dm.cdsSegRESP.AsInteger = 5 )then
        respSeg  := rsTomadorServico;

        xSeg   := dm.cdsSegNOME_SEGURADORA.AsString;
        nApol  := dm.cdsSegNUMERO_APOLICE.AsString;
        nAver  := dm.cdsSegNUMERO_AVERBACAO.AsString;
        vCarga := dm.cdsSegVALOR.Value;
      end;
      dm.cdsSeg.Next;
    end;
    dm.cdsSeg.Close;


     case  rgForPag.ItemIndex of
     0: Ide.forPag := fpPago;
     1: Ide.forPag := fpAPagar;
     2: Ide.forPag := fpOutros;
    end;


    if not(dm.cdsQC.Active)then
    begin
      dm.cdsQC.Params[0].AsInteger := val_genCte;
      dm.cdsQC.Open;
    end;

    while( not dm.cdsQC.Eof) do
    begin
      // UnidMed = (uM3,uKG, uTON, uUNIDADE, uLITROS , uMMBTU);
      with infCTeNorm.infCarga.InfQ.Add do
      begin
      if(dm.cdsQCUNID.AsString = '00')then
      cUnid  := uM3;
      if(dm.cdsQCUNID.AsString = '01')then
      cUnid  := uKG;
      if(dm.cdsQCUNID.AsString = '02')then
      cUnid  := uTON;
      if(dm.cdsQCUNID.AsString = '03')then
      cUnid  := uUNIDADE;
      if(dm.cdsQCUNID.AsString = '04')then
      cUnid  := uLITROS;
      if(dm.cdsQCUNID.AsString = '05')then
      cUnid  := uMMBTU;
      tpMed  := dm.cdsQCMEDIDA.AsString;
      qCarga := dm.cdsQCQUANT.Value;
    end;
      dm.cdsQC.Next;
    end;
    dm.cdsQC.Close;
    }
  end;

end;

function TfCTePrincipal.LimparString(ATExto, ACaracteres: string): string;
 var
   strAux            : string;
   I                 : integer;
 begin
   strAux := '';
   for I := 1 to Length(ATexto) do
     if Pos(Copy(ATexto, I, 1), ACaracteres) <= 0 then
       strAux := strAux + Copy(ATexto, I, 1);
   Result := strAux;
end;

procedure TfCTePrincipal.StaticText6Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.dbValInfCargaChange(Sender: TObject);
begin

end;

procedure TfCTePrincipal.BitBtn20Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.btnStatusServClick(Sender: TObject);
begin

end;

procedure TfCTePrincipal.Button11Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.edtCodEmitente1Change(Sender: TObject);
begin

end;

procedure TfCTePrincipal.mmEmailMsgChange(Sender: TObject);
begin

end;

procedure TfCTePrincipal.rgDestClick(Sender: TObject);
begin
  if rgDest.ItemIndex = 0 then
  begin
    GroupBoxDestinatario.Visible := False;
  end;

  if rgDest.ItemIndex <> 0 then
  begin
    GroupBoxDestinatario.Visible := True;
  end;
end;

procedure TfCTePrincipal.rgExpClick(Sender: TObject);
begin
  if rgExp.ItemIndex = 0 then
  begin
    GroupBoxExpeditor.Visible := False;
  end;

  if rgExp.ItemIndex = 1 then
  begin
    GroupBoxExpeditor.Visible := True;
  end;
end;

procedure TfCTePrincipal.rgRecClick(Sender: TObject);
begin
  if rgRec.ItemIndex = 0 then
  begin
    GroupBoxRecebedor.Visible := False;
  end;

  if rgRec.ItemIndex = 1 then
  begin
    GroupBoxRecebedor.Visible := True;
    edtRecBusca.Text     := '';
    edtRecNome.Text      := '';
    edtRecRazao.Text     := '';
    edtRecCNPJ.Text      := '';
    edtRecIE.Text        := '';
    edtRecFone.Text      := '';
    edtRecEnd.Text       := '';
    edtRecNum.Text       := '';
    edtRecCodCidade.Text := '';
    edtRecCidade.Text    := '';
    edtRecBairro.Text    := '';
    edtRecCep.TExt       := '';
    edtRecUF.Text        := '';
    EditarRe;
  end;
end;

procedure TfCTePrincipal.rgRemClick(Sender: TObject);
begin
  if rgRem.ItemIndex = 0 then
  begin
    GroupBoxRemetente.Visible := False;
  end;

  if rgRem.ItemIndex <> 0 then
  begin
    GroupBoxRemetente.Visible := True;
  end;
end;

procedure TfCTePrincipal.rgTomadorClick(Sender: TObject);
begin
  if rgTomador.ItemIndex = 4 then
  begin
    GroupBoxTomador.Visible := False;
  end;

  if rgTomador.ItemIndex <> 4 then
  begin
    GroupBoxTomador.Visible := True;
  end;
end;

procedure TfCTePrincipal.sbtnGetCertClick(Sender: TObject);
begin
  edtNumSerie.Text := ACBrCTe1.SSL.SelecionarCertificado;
end;

procedure TfCTePrincipal.sbtnLogoMarcaClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Logo';
  OpenDialog1.DefaultExt := '*.bmp';
  OpenDialog1.Filter := 'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);

  if OpenDialog1.Execute then
  begin
    edtLogoMarca.Text := OpenDialog1.FileName;
  end;
end;

procedure TfCTePrincipal.sbtnPathSalvarClick(Sender: TObject);
var
 Dir : string;
begin
  if Length(edtPathLogs.Text) <= 0 then
    Dir := ExtractFileDir(application.ExeName)
  else
    Dir := edtPathLogs.Text;

 if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
   edtPathLogs.Text := Dir;
end;

procedure TfCTePrincipal.StaticText13Click(Sender: TObject);
begin

end;

end.

