unit uCtePrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Menus, Buttons, DBGrids, Types;

type

  { TfCTePrincipal }

  TfCTePrincipal = class(TForm)
    BitBtn1: TBitBtn;
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
    combICMSDevido: TCheckBox;
    combCodSitTrib: TComboBox;
    cbUF: TComboBox;
    combOutrosDocs: TComboBox;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    dgGridCTE: TDBGrid;
    dbValInfCarga: TEdit;
    dbValTotPrest: TEdit;
    calValB: TEdit;
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
    edtNumCte14: TEdit;
    edtOutrosDesc: TEdit;
    edtOutrosNum: TEdit;
    edtProxyPorta: TEdit;
    edtProxySenha: TEdit;
    edtProxyUser: TEdit;
    edtEmailAssunto1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
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
    edtEmailAssunto: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label9: TLabel;
    lblDetRetira1: TStaticText;
    mmEmailMsg: TMemo;
    memxObs: TMemo;
    rgTipoAmb: TRadioGroup;
    rgRodLotacao: TRadioGroup;
    sbtnCaminhoCert: TSpeedButton;
    SpeedButton3: TSpeedButton;
    sbtnLogoMarca: TSpeedButton;
    TabSheet12: TTabSheet;
    TabSheet15: TTabSheet;
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
    TabSheet14: TTabSheet;
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
    edtTomadorFone: TEdit;
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
    edtNumCte4: TEdit;
    edtNumCte5: TEdit;
    edtNumCte6: TEdit;
    edtNumCte7: TEdit;
    edtNumCte8: TEdit;
    edtNumCte9: TEdit;
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
    rgModal2: TRadioGroup;
    rgDest: TRadioGroup;
    rgRetira1: TRadioGroup;
    rgTiposCte: TRadioGroup;
    rgTipoServico: TRadioGroup;
    rgRec: TRadioGroup;
    rgTomador: TRadioGroup;
    rgTipoServico2: TRadioGroup;
    rgTipoServico3: TRadioGroup;
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
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet16: TTabSheet;
    TabSheet18: TTabSheet;
    TabSheet19: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet20: TTabSheet;
    TabSheet21: TTabSheet;
    TabSheet22: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    procedure BitBtn20Click(Sender: TObject);
    procedure btnStatusServClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure dbValInfCargaChange(Sender: TObject);
    procedure edtCodEmitente1Change(Sender: TObject);
    procedure mmEmailMsgChange(Sender: TObject);
    procedure StaticText13Click(Sender: TObject);
    procedure StaticText6Click(Sender: TObject);
    procedure StaticText7Click(Sender: TObject);
    procedure TabSheet12ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabSheet22ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private

  public

  end;

var
  fCTePrincipal: TfCTePrincipal;

implementation

{$R *.lfm}

{ TfCTePrincipal }





procedure TfCTePrincipal.StaticText7Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.TabSheet12ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TfCTePrincipal.TabSheet22ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

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

procedure TfCTePrincipal.StaticText13Click(Sender: TObject);
begin

end;

end.

