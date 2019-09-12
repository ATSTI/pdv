{$I ACBr.inc}

unit Frm_Demo_ACBrCTe;

interface

uses
  IniFiles, ShellAPI,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, OleCtrls, SHDocVw, StdCtrls, Buttons, ExtCtrls,
  ACBrCTe, ACBrCTeDACTEClass, ACBrMail, ACBrBase, ACBrDFe, ACBrCTeDACTeRLClass,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Mask, Vcl.DBCtrls,
  Datasnap.Provider, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, JvMaskEdit,
  JvCheckedMaskEdit, JvDatePickerEdit, JvExMask, JvToolEdit, JvBaseEdits,
  JvExComCtrls, JvDateTimePicker, ACBrDFeReport, ACBrNFe;

type
  TfrmDemo_ACBrCTe = class(TForm)
    OpenDialog1: TOpenDialog;
    ACBrCTe1: TACBrCTe;
    ACBrMail1: TACBrMail;
    PageControl3: TPageControl;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    TabSheet19: TTabSheet;
    TabSheet20: TTabSheet;
    Panel3: TPanel;
    btnImprimir: TButton;
    btnConsultar: TButton;
    btnValidarXML: TButton;
    btnStatusServ: TButton;
    btnCancCTe: TButton;
    btnCriarEnviar: TButton;
    btnInutilizar: TButton;
    btnGerarCTe: TButton;
    btnConsCad: TButton;
    btnGerarPDF: TButton;
    btnEnviarEmail: TButton;
    btnConsultarRecibo: TButton;
    btnEnvEPEC: TButton;
    btnImprimirEvento: TButton;
    btnImportarXML: TButton;
    btnConsultarChave: TButton;
    btnEnviarEventoEmail: TButton;
    btnGerarPDFEvento: TButton;
    btnImprimirInut: TButton;
    btnGerarPDFInut: TButton;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    MemoResp: TMemo;
    TabSheet6: TTabSheet;
    TabSheet8: TTabSheet;
    memoLog: TMemo;
    TabSheet9: TTabSheet;
    trvwCTe: TTreeView;
    TabSheet10: TTabSheet;
    memoRespWS: TMemo;
    Dados: TTabSheet;
    MemoDados: TMemo;
    btnSalvarConfig: TBitBtn;
    Label7: TLabel;
    edtLogoMarca: TEdit;
    sbtnLogoMarca: TSpeedButton;
    ckSalvar: TCheckBox;
    edtPathLogs: TEdit;
    sbtnPathSalvar: TSpeedButton;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    ckVisualizar: TCheckBox;
    cbUF: TComboBox;
    rgTipoAmb: TRadioGroup;
    gbProxy: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxyUser: TEdit;
    edtProxySenha: TEdit;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtSmtpHost: TEdit;
    edtSmtpPort: TEdit;
    edtSmtpUser: TEdit;
    edtSmtpPass: TEdit;
    edtEmailAssunto: TEdit;
    cbEmailSSL: TCheckBox;
    mmEmailMsg: TMemo;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    sbtnCaminhoCert: TSpeedButton;
    Label25: TLabel;
    sbtnGetCert: TSpeedButton;
    edtCaminho: TEdit;
    edtSenha: TEdit;
    edtNumSerie: TEdit;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    PageControl4: TPageControl;
    TabSheet1: TTabSheet;
    rgTiposCte: TRadioGroup;
    rgTipoServico: TRadioGroup;
    rgFormaEmissao: TRadioGroup;
    rgTipoDACTe: TRadioGroup;
    TabSheet3: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet4: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtEmitCNPJ: TEdit;
    edtEmitIE: TEdit;
    edtEmitRazao: TEdit;
    edtEmitFantasia: TEdit;
    edtEmitFone: TEdit;
    edtEmitCEP: TEdit;
    edtEmitLogradouro: TEdit;
    edtEmitNumero: TEdit;
    edtEmitComp: TEdit;
    edtEmitBairro: TEdit;
    edtEmitCodCidade: TEdit;
    edtEmitCidade: TEdit;
    edtEmitUF: TEdit;
    TabSheet13: TTabSheet;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    rgTomador: TRadioGroup;
    edtBuscaTomador: TEdit;
    edtTomadorCodCidade: TEdit;
    edtTomadorCidade: TEdit;
    edtTomadorUF: TEdit;
    edtNomeTomador: TEdit;
    edtRazaoTomador: TEdit;
    edtCNPJTomador: TEdit;
    edtIETomador: TEdit;
    edtEndTomador: TEdit;
    edtNumTomador: TEdit;
    edtCompTomador: TEdit;
    edtBairroTomador: TEdit;
    edtCepTomador: TEdit;
    Remetente: TTabSheet;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    edtRemBusca: TEdit;
    edtRemRazao: TEdit;
    edtRemNome: TEdit;
    edtRemEnd: TEdit;
    edtRemComp: TEdit;
    edtRemNum: TEdit;
    edtRemBairro: TEdit;
    edtRemCep: TEdit;
    edtRemCNPJ: TEdit;
    edtRemFone: TEdit;
    edtRemIE: TEdit;
    edtRemCodCidade: TEdit;
    edtRemCidade: TEdit;
    edtRemUF: TEdit;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    edtCFOP: TEdit;
    edtNatOpe: TEdit;
    Label68: TLabel;
    Label69: TLabel;
    edtCFOPBusca: TEdit;
    rgRem: TRadioGroup;
    rgModal: TRadioGroup;
    rgForPag: TRadioGroup;
    edtChaveAcesso: TEdit;
    Label70: TLabel;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox6: TGroupBox;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet21: TTabSheet;
    TabSheet22: TTabSheet;
    Label49: TLabel;
    Label48: TLabel;
    edtDestNum: TEdit;
    Label46: TLabel;
    edtDestCEP: TEdit;
    Label45: TLabel;
    edtDestFone: TEdit;
    Label53: TLabel;
    edtDestUF: TEdit;
    edtDestBairro: TEdit;
    Label52: TLabel;
    edtDestCidade: TEdit;
    edtDestCodCidade: TEdit;
    Label51: TLabel;
    edtDestComp: TEdit;
    Label50: TLabel;
    edtDestEnd: TEdit;
    Label47: TLabel;
    edtDestNome: TEdit;
    Label44: TLabel;
    edtDestRazao: TEdit;
    Label43: TLabel;
    edtDestISUF: TEdit;
    Label54: TLabel;
    edtDestIE: TEdit;
    Label42: TLabel;
    Label41: TLabel;
    edtDestCNPJ: TEdit;
    edtDestBusca: TEdit;
    rgDest: TRadioGroup;
    Label92: TLabel;
    edtExpNum: TEdit;
    Label93: TLabel;
    edtExpCep: TEdit;
    edtExpFone: TEdit;
    Label94: TLabel;
    Label95: TLabel;
    edtExpUF: TEdit;
    edtExpBairro: TEdit;
    Label96: TLabel;
    Label97: TLabel;
    edtExpCidade: TEdit;
    edtExpCodCidade: TEdit;
    Label98: TLabel;
    edtExpComp: TEdit;
    Label99: TLabel;
    edtExpEnd: TEdit;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    edtExpNome: TEdit;
    edtExpRazao: TEdit;
    Label104: TLabel;
    edtExpIE: TEdit;
    edtExpCNPJ: TEdit;
    Label105: TLabel;
    edtExpBusca: TEdit;
    rgExp: TRadioGroup;
    TabSheet24: TTabSheet;
    Label106: TLabel;
    edtRecNum: TEdit;
    Label107: TLabel;
    edtRecCep: TEdit;
    Label108: TLabel;
    edtRecFone: TEdit;
    edtRecUF: TEdit;
    Label109: TLabel;
    edtRecBairro: TEdit;
    Label110: TLabel;
    Label111: TLabel;
    edtRecCidade: TEdit;
    edtRecCodCidade: TEdit;
    Label112: TLabel;
    edtRecComp: TEdit;
    Label113: TLabel;
    edtRecEnd: TEdit;
    Label114: TLabel;
    edtRecNome: TEdit;
    Label115: TLabel;
    edtRecRazao: TEdit;
    Label116: TLabel;
    edtRecIE: TEdit;
    Label118: TLabel;
    Label119: TLabel;
    edtRecCNPJ: TEdit;
    edtRecBusca: TEdit;
    rgRec: TRadioGroup;
    PageControl5: TPageControl;
    TabSheet25: TTabSheet;
    TabSheet26: TTabSheet;
    TabSheet27: TTabSheet;
    TabSheet28: TTabSheet;
    TabSheet29: TTabSheet;
    TabSheet30: TTabSheet;
    TabSheet31: TTabSheet;
    Label103: TLabel;
    Label121: TLabel;
    Label117: TLabel;
    edtProPred: TEdit;
    Label122: TLabel;
    Label123: TLabel;
    edtOutCat: TEdit;
    Label120: TLabel;
    btnIncluir: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    PageControl6: TPageControl;
    TabSheet32: TTabSheet;
    TabSheet33: TTabSheet;
    TabSheet34: TTabSheet;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    PageControl7: TPageControl;
    TabSheet35: TTabSheet;
    TabSheet36: TTabSheet;
    TabSheet37: TTabSheet;
    GroupBox14: TGroupBox;
    GroupBox15: TGroupBox;
    GroupBox16: TGroupBox;
    edtModelo: TEdit;
    edtSerieCte: TEdit;
    edtNumCte: TEdit;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    comboEmi: TComboBox;
    comboIni: TComboBox;
    comboFim: TComboBox;
    comboCidadeEmi: TComboBox;
    comboCidadeIni: TComboBox;
    comboCidadeFim: TComboBox;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    btnIncluirComp: TButton;
    btnEditarComp: TButton;
    btnExcluirComp: TButton;
    dbGridComp: TDBGrid;
    CheckBox1: TCheckBox;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    combICMSDevido: TComboBox;
    calValB: TJvCalcEdit;
    valAliIn: TJvCalcEdit;
    valICMSPartI: TJvCalcEdit;
    valIMCSPartF: TJvCalcEdit;
    valCombIni: TJvCalcEdit;
    valCombFim: TJvCalcEdit;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    valpRedBCx: TJvCalcEdit;
    valvBCx: TJvCalcEdit;
    valpICMSx: TJvCalcEdit;
    valvICMSx: TJvCalcEdit;
    valvCredx: TJvCalcEdit;
    combCodSitTrib: TComboBox;
    Label147: TLabel;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    btnGerar: TButton;
    Button13: TButton;
    memDetRetira: TMemo;
    rgRetira: TRadioGroup;
    edtCaracAdServ: TEdit;
    edtFuncEmi: TEdit;
    edtCaracAdTrans: TEdit;
    Label91: TLabel;
    Label166: TLabel;
    Label167: TLabel;
    PageControl8: TPageControl;
    TabSheet38: TTabSheet;
    TabSheet39: TTabSheet;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    edtEnvCodCidade: TEdit;
    edtEnvCidade: TEdit;
    edtEnvUF: TEdit;
    edtIniCodCidade: TEdit;
    edtIniCidade: TEdit;
    edtIniUF: TEdit;
    edtFimCodCidade: TEdit;
    edtFimCidade: TEdit;
    edtFimUF: TEdit;
    valAliInter: TJvCalcEdit;
    GroupBoxTomador: TGroupBox;
    edtFoneTomador: TEdit;
    Label88: TLabel;
    GroupBoxRemetente: TGroupBox;
    GroupBoxExpeditor: TGroupBox;
    GroupBoxRecebedor: TGroupBox;
    GroupBoxDestinatario: TGroupBox;
    memxObs: TMemo;
    Label173: TLabel;
    dbGridQC: TDBGrid;
    ACBrCTeDACTeRL1: TACBrCTeDACTeRL;
    dbgridNFe: TDBGrid;
    btnInluirNF: TButton;
    btnEditarNF: TButton;
    btnExcluirNF: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    dbgridSeg: TDBGrid;
    PageControl9: TPageControl;
    TabSheet23: TTabSheet;
    TabSheet40: TTabSheet;
    TabSheet41: TTabSheet;
    TabSheet42: TTabSheet;
    Label148: TLabel;
    edtRodRNTRC: TEdit;
    Label165: TLabel;
    dataRodPrev: TJvDatePickerEdit;
    rgRodLotacao: TRadioGroup;
    GroupBox13: TGroupBox;
    GroupBox12: TGroupBox;
    dbgridMot: TDBGrid;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    dbgridVeic: TDBGrid;
    Label174: TLabel;
    Label175: TLabel;
    dgGridCTE: TDBGrid;
    btnListarCte: TButton;
    Label29: TLabel;
    dbgridNF: TDBGrid;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    qSeries: TZQuery;
    dsSeries: TDataSource;
    qSeriesSERIE: TWideStringField;
    qSeriesULTIMO_NUMERO: TIntegerField;
    qSeriesCODSERIE: TWideStringField;
    qSeriesNOTAFISCAL: TSmallintField;
    qSeriesICMS_DESTACADO: TFloatField;
    qSeriesMODELO: TWideStringField;
    Label30: TLabel;
    DBEdit1: TDBEdit;
    Label31: TLabel;
    DBEdit2: TDBEdit;
    Label32: TLabel;
    DBEdit3: TDBEdit;
    Button27: TButton;
    cdsSeries: TClientDataSet;
    dspSeries: TDataSetProvider;
    cdsSeriesSERIE: TWideStringField;
    cdsSeriesULTIMO_NUMERO: TIntegerField;
    cdsSeriesCODSERIE: TWideStringField;
    cdsSeriesNOTAFISCAL: TSmallintField;
    cdsSeriesICMS_DESTACADO: TFloatField;
    cdsSeriesMODELO: TWideStringField;
    Label33: TLabel;
    btnAtualizarBD: TButton;
    dataGerarCte: TJvDateTimePicker;
    comboEmpresa: TComboBox;
    edtCodEmitente: TEdit;
    Label34: TLabel;
    btnIniciarEmitente: TButton;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    DBGrid1: TDBGrid;
    qSeriesSERIE_CTE: TWideStringField;
    cdsSeriesSERIE_CTE: TWideStringField;
    dbValReceber: TDBEdit;
    dbValTotPrest: TDBEdit;
    dbValTotTri: TDBEdit;
    dbValInfCarga: TDBEdit;
    btnEditarCte: TBitBtn;
    btnGravarCTe: TBitBtn;
    BitBtn1: TBitBtn;
    btnIncCte: TButton;
    Label59: TLabel;
    btnDuplicarCTe: TButton;
    btnPreVisu: TButton;
    Button22: TButton;
    Label60: TLabel;
    Button15: TButton;
    Button23: TButton;
    Button28: TButton;
    edtOutrosDesc: TEdit;
    edtOutrosNum: TEdit;
    dataOutrosEmi: TJvDateTimePicker;
    Label61: TLabel;
    combOutrosDocs: TComboBox;
    Label62: TLabel;
    Label63: TLabel;
    valOutrosVal: TJvCalcEdit;
    btnOutrosLimpar: TButton;
    Label64: TLabel;
    btnImpPeriodo: TButton;
    JvDateTimePicker1: TJvDateTimePicker;
    JvDateTimePicker2: TJvDateTimePicker;
    Label65: TLabel;
    Label66: TLabel;
    rgGlobalizado: TRadioGroup;
    TabSheet43: TTabSheet;
    btnCC: TButton;
    Label67: TLabel;
    edtChave: TEdit;
    Sequencia: TLabel;
    edtSequencia: TEdit;
    Label150: TLabel;
    edtGrupoAlterado: TEdit;
    Campo: TLabel;
    edtsCampo: TEdit;
    Valor: TLabel;
    edtsValor: TEdit;
    Label151: TLabel;
    edtiNumItem: TEdit;
    Label149: TLabel;
    Label152: TLabel;
    TabSheet44: TTabSheet;
    DataSource1: TDataSource;
    DBText1: TDBText;
    Label153: TLabel;
    edtLink: TEdit;
    btnDuplicar: TButton;
    Button30: TButton;
    ACBrNFe1: TACBrNFe;
    TabSheet45: TTabSheet;
    Button31: TButton;
    trvwNFe: TTreeView;
    Edit2: TEdit;
    btnVerCadastro: TButton;
    Label154: TLabel;
    Label155: TLabel;
    btnCliCa: TButton;
    Edit3: TEdit;
    Label156: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    Label159: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    btnCliEnd: TButton;
    Edit1: TEdit;
    Label164: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Button32: TButton;
    edtAntCNPJ: TEdit;
    edtAntIE: TEdit;
    edtAntUF: TEdit;
    edtAntNome: TEdit;
    edtAntCHCTE: TEdit;
    Label178: TLabel;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    dbVALPREDBC: TDBEdit;
    dbVALVBC: TDBEdit;
    dbVALPICMS: TDBEdit;
    dbVALVICMS: TDBEdit;
    dbVALVCRED: TDBEdit;
    Label183: TLabel;
    btnCancelar: TButton;
    Label132: TLabel;
    Label184: TLabel;
    procedure sbtnGetCertClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarConfigClick(Sender: TObject);
    procedure btnStatusServClick(Sender: TObject);
    procedure btnCriarEnviarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnConsultarChaveClick(Sender: TObject);
    procedure btnCancCTeClick(Sender: TObject);
    procedure btnInutilizarClick(Sender: TObject);
    procedure btnConsultarReciboClick(Sender: TObject);
    procedure btnConsCadClick(Sender: TObject);
    procedure btnGerarCTeClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnEnvEPECClick(Sender: TObject);
    procedure btnImprimirEventoClick(Sender: TObject);
    procedure btnImportarXMLClick(Sender: TObject);
    procedure btnValidarXMLClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure ACBrCTe1StatusChange(Sender: TObject);
    procedure ACBrCTe1GerarLog(const Mensagem: String);
    procedure btnEnviarEventoEmailClick(Sender: TObject);
    procedure btnGerarPDFEventoClick(Sender: TObject);
    procedure btnImprimirInutClick(Sender: TObject);
    procedure btnGerarPDFInutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnInluirNFClick(Sender: TObject);
    procedure edtBuscaTomadorChange(Sender: TObject);
    procedure edtRemBuscaChange(Sender: TObject);
    procedure edtDestBuscaChange(Sender: TObject);
    procedure edtCFOPBuscaChange(Sender: TObject);
    procedure edtExpBuscaChange(Sender: TObject);
    procedure edtRecBuscaChange(Sender: TObject);
    procedure comboEmiChange(Sender: TObject);
    procedure comboIniChange(Sender: TObject);
    procedure comboFimChange(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure comboCidadeEmiChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TabSheet25Show(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure TabSheet13Show(Sender: TObject);
    procedure RemetenteShow(Sender: TObject);
    procedure TabSheet15Show(Sender: TObject);
    procedure TabSheet16Show(Sender: TObject);
    procedure TabSheet11Show(Sender: TObject);
    procedure edtEnvCodCidadeChange(Sender: TObject);
    procedure comboCidadeIniChange(Sender: TObject);
    procedure comboCidadeFimChange(Sender: TObject);
    procedure combCodSitTribChange(Sender: TObject);
    procedure TabSheet12Show(Sender: TObject);
    procedure rgTomadorClick(Sender: TObject);
    procedure rgRemClick(Sender: TObject);
    procedure rgExpClick(Sender: TObject);
    procedure rgRecClick(Sender: TObject);
    procedure rgDestClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncCteClick(Sender: TObject);
    procedure btnIncluirCompClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TabSheet28Show(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure TabSheet42Show(Sender: TObject);
    procedure TabSheet23Show(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure TabSheet41Show(Sender: TObject);
    procedure btnEditarNFClick(Sender: TObject);
    procedure TabSheet33Show(Sender: TObject);
    procedure btnExcluirNFClick(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnEditarCompClick(Sender: TObject);
    procedure btnExcluirCompClick(Sender: TObject);
    procedure btnListarCteClick(Sender: TObject);
    procedure btnEditarCteClick(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure TabSheet32Show(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure TabSheet20Show(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure btnAtualizarBDClick(Sender: TObject);
    procedure btnGravarCTeClick(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
    procedure comboEmpresaChange(Sender: TObject);
    procedure btnIniciarEmitenteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnDuplicarCTeClick(Sender: TObject);
    procedure btnPreVisuClick(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure dgGridCTECellClick(Column: TColumn);
    procedure dgGridCTEKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dgGridCTEDblClick(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure combOutrosDocsClick(Sender: TObject);
    procedure btnOutrosLimparClick(Sender: TObject);
    procedure combOutrosDocsChange(Sender: TObject);
    procedure btnImpPeriodoClick(Sender: TObject);
    procedure TabSheet24Show(Sender: TObject);
    procedure btnCCClick(Sender: TObject);
    procedure btnDuplicarClick(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure btnVerCadastroClick(Sender: TObject);
    procedure btnCliCaClick(Sender: TObject);
    procedure btnCliEndClick(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure PageControl1DrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure PageControl4DrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure dbValReceberKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    {
    procedure lblMouseEnter(Sender: TObject);
    procedure lblMouseLeave(Sender: TObject);
    }


  private
    { Private declarations }
    modoGravacao : string;
    cteEnviada: String;
    function LimparString(ATExto, ACaracteres: string): string;
    function editParaSql(tipo: String;conteudoEdit: String): String;
    function GravarCTe: String;
    procedure duplicar(velhaCte: String);
    procedure GravarConfiguracao;
    procedure LerConfiguracao;
    procedure LoadXML(MyMemo: TMemo; MyWebBrowser: TWebBrowser);
    procedure GerarCTe(NumCTe : String);
    procedure DadosBasicos;
    procedure CarregarUF;
    procedure EditarA;
    procedure EditarB;
    procedure EditarC;
    procedure EditarD;
    procedure EditarE;
    procedure EditarF;
    procedure EditarG;
    procedure EditarEX;
    procedure EditarT;
    procedure EditarR;
    procedure EditarRE;
    procedure EditarDE;
    procedure EditarREC;
  public
    { Public declarations }
    val_genCte : integer;
    val0 , val1, val2 : Double;
    valC :string;
    strInsere , strEndereco : string;
    generetor, genCLI,genEnd : integer;
    pVALPREDBC,pVALVBC,pVALPICMS,pVALVICMS,pVALVCRED : Double;
    percent_icms: Double;
    vDup : integer;
  end;

var
  frmDemo_ACBrCTe: TfrmDemo_ACBrCTe;

implementation

uses
  FileCtrl, DateUtils,
  ufrmStatus,
  pcnConversao, pcteConversaoCTe, ACBrUtil,
  ACBrCTeConhecimentos, uDMCTe, uQuantCarga, ufCompValor, uNFe, uSeguro,
  uMotorista, uVeiculo, uNF, uDocOutros , pcnNFeRTXT , pcnConversaoNFe , uBusca;

const
  SELDIRHELP = 1000;

{$R *.dfm}

(*
procedure TForm1.lblMouseEnter(Sender: TObject);
begin
 TLabel(Sender).Font.Style := [fsBold,fsUnderline];
end;

procedure TForm1.lblMouseLeave(Sender: TObject);
begin
 TLabel(Sender).Font.Style := [fsBold];
end;
*)
procedure TfrmDemo_ACBrCTe.GravarConfiguracao;
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

  Ini.WriteFloat('ICMS','Percentual' , dm.cdsCTEVALPICMS.AsFloat);

  StreamMemo := TMemoryStream.Create;
  mmEmailMsg.Lines.SaveToStream(StreamMemo);
  StreamMemo.Seek(0,soFromBeginning);
  Ini.WriteBinaryStream( 'Email','Mensagem',StreamMemo);

  StreamMemo.Free;
 finally
  Ini.Free;
 end;
end;

procedure TfrmDemo_ACBrCTe.LerConfiguracao;
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

procedure TfrmDemo_ACBrCTe.LoadXML(MyMemo: TMemo;
  MyWebBrowser: TWebBrowser);
begin
 MyMemo.Lines.SaveToFile(ExtractFileDir(application.ExeName)+'temp.xml');
 MyWebBrowser.Navigate(ExtractFileDir(application.ExeName)+'temp.xml');
end;

procedure TfrmDemo_ACBrCTe.PageControl1DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   case TabIndex of      //quantidade de pages(abas) que terá seu pagecontrol.
      // mudar a cor da fonte do titulo do TabSheet
      0: PageControl1.canvas.font.color:=clBlack;
      1: PageControl1.canvas.font.color:=clBlack;
      2: PageControl1.canvas.font.color:=clBlack;
      3: PageControl1.canvas.font.color:=clBlack;
      4: PageControl1.canvas.font.color:=clBlack;
      5: PageControl1.canvas.font.color:=clBlack;
      6: PageControl1.canvas.font.color:=clBlack;
      7: PageControl1.canvas.font.color:=clBlack;
      8: PageControl1.canvas.font.color:=clBlack;
      9: PageControl1.canvas.font.color:=clBlack;
     10: PageControl1.canvas.font.color:=clBlack;
     11: PageControl1.canvas.font.color:=clBlack;

   end;

   Control.Canvas.FillRect( Rect );
   Control.Canvas.TextOut(Rect.left+2,Rect.top+2,TTabSheet(PageControl1.Pages[tabindex]).Caption);
   PageControl1.Pages[TabIndex].Font.Color:=clblack;

end;

procedure TfrmDemo_ACBrCTe.PageControl4DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   case TabIndex of      //quantidade de pages(abas) que terá seu pagecontrol.
      // mudar a cor da fonte do titulo do TabSheet
      0: PageControl4.canvas.font.color:=clBlack;
      1: PageControl4.canvas.font.color:=clBlack;
      2: PageControl4.canvas.font.color:=clBlack;
      3: PageControl4.canvas.font.color:=clBlack;
      4: PageControl4.canvas.font.color:=clBlack;
      5: PageControl4.canvas.font.color:=clBlack;
      6: PageControl4.canvas.font.color:=clBlack;
      7: PageControl4.canvas.font.color:=clBlack;
      8: PageControl4.canvas.font.color:=clBlack;
      9: PageControl4.canvas.font.color:=clBlack;
     10: PageControl4.canvas.font.color:=clBlack;
     11: PageControl4.canvas.font.color:=clBlack;

   end;

   Control.Canvas.FillRect( Rect );
   Control.Canvas.TextOut(Rect.left+2,Rect.top+2,TTabSheet(PageControl4.Pages[tabindex]).Caption);
   PageControl4.Pages[TabIndex].Font.Color:=clblack;

end;

procedure TfrmDemo_ACBrCTe.RemetenteShow(Sender: TObject);
begin
  edtRemBusca.SetFocus;
  GroupBoxRemetente.Visible := False;
end;

procedure TfrmDemo_ACBrCTe.rgDestClick(Sender: TObject);
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

procedure TfrmDemo_ACBrCTe.rgExpClick(Sender: TObject);
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

procedure TfrmDemo_ACBrCTe.rgRecClick(Sender: TObject);
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

procedure TfrmDemo_ACBrCTe.rgRemClick(Sender: TObject);
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

procedure TfrmDemo_ACBrCTe.rgTomadorClick(Sender: TObject);
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

procedure TfrmDemo_ACBrCTe.GerarCTe(NumCTe: String);   // INICO GERAR CTE
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

    rgTomador.ItemIndex := dm.cdsCTETOMADORSERVICO.AsInteger;

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

   {  Fazer depois Manoel   inicio

   compl.fluxo.xOrig := Trim(DM_CNT.Conhec2FluxoOrigem.AsString);
   if Trim(DM_CNT.Conhec2FluxoPassagem.AsString)<>''
    then begin
     with compl.fluxo.pass.Add do
      begin
       xPass := Trim(DM_CNT.Conhec2FluxoPassagem.AsString);
      end;
    end;
   compl.fluxo.xDest := Trim(DM_CNT.Conhec2FluxoDestino.AsString);
   compl.fluxo.xRota := Trim(DM_CNT.Conhec2FluxoRota.AsString);

   compl.Entrega.TipoData:=StrToTpDataPeriodo(okConversao, IntToStr(DM_CNT.Conhec2EntregaTipoData.AsInteger));
   case DM_CNT.Conhec2EntregaTipoData.AsInteger of
        0: compl.Entrega.semData.tpPer:=tdSemData;
    1,2,3: begin
            compl.Entrega.comData.tpPer:=StrToTpDataPeriodo(okConversao, IntToStr(DM_CNT.Conhec2EntregaTipoData.AsInteger));
            compl.Entrega.comData.dProg:=DM_CNT.Conhec2EntregaDataI.AsDateTime;
           end;
        4: begin
            compl.Entrega.noPeriodo.tpPer:=tdNoPeriodo;
            compl.Entrega.noPeriodo.dIni:=DM_CNT.Conhec2EntregaDataI.AsDateTime;
            compl.Entrega.noPeriodo.dFim:=DM_CNT.Conhec2EntregaDataF.AsDateTime;
           end;
   end;

   compl.Entrega.TipoHora:=StrToTpHorarioIntervalo(okConversao, IntToStr(DM_CNT.Conhec2EntregaTipoHora.AsInteger));
   case DM_CNT.Conhec2EntregaTipoHora.AsInteger of
        0: compl.Entrega.semHora.tpHor:=thSemHorario;
    1,2,3: begin
            compl.Entrega.comHora.tpHor:=StrToTpHorarioIntervalo(okConversao, IntToStr(DM_CNT.Conhec2EntregaTipoHora.AsInteger));
            compl.Entrega.comHora.hProg:=StrToTime(DM_CNT.Conhec2EntregaHoraI.AsString);
           end;
        4: begin
            compl.Entrega.noInter.tpHor:=thNoIntervalo;
            compl.Entrega.noInter.hIni:=StrToTime(DM_CNT.Conhec2EntregaHoraI.AsString);
            compl.Entrega.noInter.hFim:=StrToTime(DM_CNT.Conhec2EntregaHoraF.AsString);
           end;
   end;

   compl.origCalc := DM_CNT.Conhec2NomeCidadeColeta.AsString;
   compl.destCalc := DM_CNT.Conhec2NomeCidadeEntrega.AsString;
   }
   compl.xObs     := memxObs.Text;
   {
   DM_CNT.Tabelas.Close;
   DM_CNT.Tabelas.SQL.Clear;
   DM_CNT.Tabelas.SQL.Add('Select * From Cnt_Tabelas');
   DM_CNT.Tabelas.SQL.Add('Where Codigo = :xTabela');
   DM_CNT.Tabelas.Params[0].AsString:=DM_CNT.ParametrosTabela.AsString;
   DM_CNT.Tabelas.Active:=True;
   DM_CNT.Tabelas.Open;

   if DM_CNT.TabelasCST.AsInteger=41
    then compl.xObs := compl.xObs +
           ';Documento emitido por ME ou EPP optante pelo Simples Nacional' +
           ';Nao gera direito a credito fiscal de ICMS';

                                  // Aba Tomador Fim

   // Obs do Contribuinte
   if (trim(DM_CNT.Conhec2ObsContCampo.AsString)<>'') and
      (trim(DM_CNT.Conhec2ObsContTexto.AsString)<>'')
    then begin
     with compl.ObsCont.Add do
      begin
       xCampo:=DM_CNT.Conhec2ObsContCampo.AsString;
       xTexto:=DM_CNT.Conhec2ObsContTexto.AsString;
      end;
    end;

   // Obs para o Fisco
   if (trim(DM_CNT.Conhec2ObsFiscoCampo.AsString)<>'') and
      (trim(DM_CNT.Conhec2ObsFiscoTexto.AsString)<>'')
    then begin
     with compl.ObsFisco.Add do
      begin
       xCampo:=DM_CNT.Conhec2ObsFiscoCampo.AsString;
       xTexto:=DM_CNT.Conhec2ObsFiscoTexto.AsString;
      end;
    end;
     } // Fazer depois Manoel   fim


   //                          Aba Emitente caregando dados da Empresa  Inicio
   // Dados do Emitente
   //
    dm.zEmpresa.Close;
    dm.zEmpresa.SQL.Clear;
    dm.zEmpresa.SQL.Add('Select * From Empresa');
    dm.zEmpresa.SQL.Add('Where RAZAO = ' + QuotedStr(comboEmpresa.Text));
    dm.zEmpresa.Active:=True;
    dm.zEmpresa.Open;

     if(copy(dm.zEmpresaCNPJ_CPF.Text,10,4)<>'0000')then
     begin
       Emit.CNPJ := dm.zEmpresaCNPJ_CPF.Text;
       Emit.IE := dm.zEmpresaIE_RG.Text;
     end
     else begin
       Emit.CNPJ := Copy(dm.zEmpresaCNPJ_CPF.Text, 1, 9) +
                         Copy(dm.zEmpresaCNPJ_CPF.Text, 14, 2);
       Emit.IE := 'ISENTO';
     end;

    Emit.xNome := dm.zEmpresaRAZAO.AsString;
    Emit.xFant := dm.zEmpresaEMPRESA.AsString;
    Emit.EnderEmit.xLgr := dm.zEmpresaENDERECO.AsString;
    Emit.EnderEmit.nro := dm.zEmpresaNUMERO.AsString;
    Emit.EnderEmit.xCpl := dm.zEmpresaLOGRADOURO.AsString;
    Emit.EnderEmit.xBairro := dm.zEmpresaBAIRRO.AsString;
                             /// refazer aqui ta errado
    //  CodigoMunicipio := StrToInt(dm.zEmpresaCD_IBGE.AsString);
    CodigoMunicipio := StrToInt(LimparString(dm.zEmpresaCD_IBGE.AsString,'-'));
    Emit.EnderEmit.cMun := CodigoMunicipio;

    Emit.EnderEmit.xMun := dm.zEmpresaCIDADE.AsString;
    Emit.EnderEmit.CEP := StrToIntDef(dm.zEmpresaCEP.AsString, 0);
    Emit.EnderEmit.UF := dm.zEmpresaUF.AsString;
    ////Emit.enderEmit.cPais := 1058; // manoel Obs ver se precisar refazer
    ////Emit.EnderEmit.xPais := 'Brasil' ; //manoel Obs ver se precisar refazer
    Emit.EnderEmit.fone := dm.zEmpresaDDD.AsString + '-' + dm.zEmpresaFONE.AsString;

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

   case  rgGlobalizado.ItemIndex of
    1: Ide.indGlobalizado :=tiSim;
    0: Ide.indGlobalizado :=tiNao;
   end;



  // infCTeNorm.infDoc.infNFe.Add.chave := '35161146344354000588550010000852421405584417';

     {
        with infseg.Add do
      begin
       case Conhec2RespSeguro.AsInteger of
        0: respSeg:=rsRemetente;
        1: respSeg:=rsExpedidor;
        2: respSeg:=rsRecebedor;
        3: respSeg:=rsDestinatario;
        4: respSeg:=rsEmitenteCTe;
        5: respSeg:=rsTomadorServico;
       end;
     }

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
                                   // aba Remetente fim
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
    end;

     //                            //manoel
     // Relação das Notas Fiscais
   {  //
     DM_CNT.Notas.Close;
     DM_CNT.Notas.SQL.Clear;
     DM_CNT.Notas.SQL.Add('Select * From Cnt_Notas');
     DM_CNT.Notas.SQL.Add('Where Codigo = :xCodigo');
     DM_CNT.Notas.SQL.Add('and Numero = :xNumero');
     DM_CNT.Notas.SQL.Add('Order By Tipo');
     DM_CNT.Notas.Params[0].AsInteger:=DM_CNT.Conhec2Codigo.AsInteger;
     DM_CNT.Notas.Params[1].AsInteger:=DM_CNT.Conhec2Numero.AsInteger;
     DM_CNT.Notas.Active:=True;
     DM_CNT.Notas.Open;
     j:=DM_CNT.Notas.RecordCount;
     if j>0
      then begin
       DM_CNT.Notas.First;
       for i:=1 to j do
        begin
         case DM_CNT.NotasTipo.AsInteger of
          0: begin
              // Nota Fiscal
              with Rem.InfNF.Add do
               begin
                nRoma := DM_CNT.NotasRomaneioNF.AsString;
                nPed  := DM_CNT.NotasPedidoNF.AsString;
                serie := DM_CNT.NotasSerieNF.AsString;
                nDoc  := DM_CNT.NotasNumeroNF.AsString;
                dEmi  := DM_CNT.NotasEmissaoNF.AsDateTime;
                vBC   := RoundTo(DM_CNT.NotasValorBCICMS.AsFloat, -2);
                vICMS := RoundTo(DM_CNT.NotasValorICMS.AsFloat, -2);
                vBCST := RoundTo(DM_CNT.NotasValorBCICMSST.AsFloat, -2);
                vST   := RoundTo(DM_CNT.NotasValorICMSST.AsFloat, -2);
                vProd := RoundTo(DM_CNT.NotasValorProdutos.AsFloat, -2);
                vNF   := RoundTo(DM_CNT.NotasValorNF.AsFloat, -2);
                nCFOP := DM_CNT.NotasCFOPNF.AsInteger;
                nPeso := RoundTo(DM_CNT.NotasPesoKg.AsFloat, -2);
                PIN   := DM_CNT.NotasPinSuframa.AsString;

                // Local de Retirada

                if trim(DM_CNT.NotasCNPJRet.AsString)<>''
                 then begin
                  DM_CTA.PessoaFJ.Close;
                  DM_CTA.PessoaFJ.SQL.Clear;
                  DM_CTA.PessoaFJ.SQL.Add('Select * From Sis_PessoaFJ');
                  DM_CTA.PessoaFJ.SQL.Add('Where CGC = :xCGC');
                  DM_CTA.PessoaFJ.Params[0].AsString:=DM_CNT.NotasCNPJRet.AsString;
                  DM_CTA.PessoaFJ.Active:=True;
                  DM_CTA.PessoaFJ.Open;

                  if copy(DM_CTA.PessoaFJCGC.AsString,10,4)<>'0000'
                   then locRet.CNPJCPF := Copy(DM_CTA.PessoaFJCGC.AsString, 2, 14)
                   else locRet.CNPJCPF := Copy(DM_CTA.PessoaFJCGC.AsString, 1, 9) +
                          Copy(DM_CTA.PessoaFJCGC.AsString, 14, 2);

                  locRet.xNome:=DM_CTA.PessoaFJRSocial.AsString;
                  locRet.xLgr:=DM_CTA.PessoaFJEndereco.AsString;
                  locRet.nro:=DM_CTA.PessoaFJNumero.AsString;
                  locRet.xCpl:=DM_CTA.PessoaFJComplemento.AsString;
                  locRet.xBairro:=DM_CTA.PessoaFJBairro.AsString;
                  CodigoMunicipio:=DM_CTA.PessoaFJCodigoEstado.AsInteger * 100000 +
                      DM_CTA.PessoaFJCodigoMunicipio.AsInteger;
                  locRet.cMun:=CodigoMunicipio;
                  locRet.xMun:=DM_CTA.PessoaFJCidade.AsString;
                  locRet.UF:=DM_CTA.PessoaFJEstado.AsString;
                 end;
               end;
             end;
          1: begin
              // Nota Fiscal Eletrônica
              with Rem.InfNFe.Add do
               begin
                chave := DM_CNT.NotasChaveNFe.AsString;
                PIN   := DM_CNT.NotasPinSuframa.AsString;
               end;
             end;
          2: begin
              // Outros Tipos de Documentos
              with Rem.InfOutros.Add do
               begin
                if DM_CNT.NotasTipoOutros.AsInteger = 0
                 then tpDoc := tdDeclaracao
                 else begin
                  tpDoc      := tdOutros;
                  descOutros := DM_CNT.NotasDescricao.AsString;
                 end;
                nDoc     := DM_CNT.NotasNumeroNF.AsString;
                dEmi     := DM_CNT.NotasEmissaoNF.AsDateTime;
                vDocFisc := RoundTo(DM_CNT.NotasValorNF.AsFloat, -2);
               end;
             end;
         end;
         DM_CNT.Notas.Next;
        end;
      end;
    end;
   }
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

     // with infCTeNorm.docAnt.emiDocAnt.Add

    //  idDocAntEle.chave
    //  idDocAntEle.Add.chCTe
 //   end;
   {
   //
   // Relação dos Componentes da Prestação de Serviço
   //
   DM_CNT.Componentes.Close;
   DM_CNT.Componentes.SQL.Clear;
   DM_CNT.Componentes.SQL.Add('Select * From Cnt_Componentes');
   DM_CNT.Componentes.SQL.Add('Where Codigo = :xCodigo');
   DM_CNT.Componentes.SQL.Add('and Numero = :xNumero');
   DM_CNT.Componentes.SQL.Add('Order By Item');
   DM_CNT.Componentes.Params[0].AsInteger:=DM_CNT.Conhec2Codigo.AsInteger;
   DM_CNT.Componentes.Params[1].AsInteger:=DM_CNT.Conhec2Numero.AsInteger;
   DM_CNT.Componentes.Active:=True;
   DM_CNT.Componentes.Open;
   j:=DM_CNT.Componentes.RecordCount;
   if j>0
    then begin
     DM_CNT.Componentes.First;
     for i:=1 to j do
      begin
       if DM_CNT.ComponentesValor.AsFloat>0.0
        then begin
         with vPrest.comp.Add do
          begin
           xNome:=DM_CNT.ComponentesDescricao.AsString;;
           vComp:=RoundTo(DM_CNT.ComponentesValor.AsFloat, -2);
          end;
        end;
       DM_CNT.Componentes.Next;
      end;
    end;
   }
   //
   //  Valores dos Impostos
   //
   // TpcnCSTIcms = (cst00, cst10, cst20, cst30, cst40, cst41, cst45, cst50, cst51, cst60, cst70, cst80, cst81, cst90);
   // 80 e 81 apenas para CTe

    case combCodSitTrib.ItemIndex of    //00 - Tributação Normal do ICMS
    0: begin
         Imp.ICMS.SituTrib     := cst00;
         Imp.ICMS.ICMS00.CST   := cst00;
         Imp.ICMS.ICMS00.vBC   := StringToFloat(dbVALVBC.Field.Value);
         Imp.ICMS.ICMS00.pICMS := StringToFloat(dbVALPICMS.Field.Value);
         Imp.ICMS.ICMS00.vICMS := StringToFloat(dbVALVICMS.Field.Value);             // valvICMS.Value;
       end;

    1: begin                        //20 - Tributação com Redulçao da BC do ICMS
         Imp.ICMS.SituTrib      := cst20;
         Imp.ICMS.ICMS20.CST    := cst20; // Tributação com BC reduzida do ICMS
         Imp.ICMS.ICMS20.pRedBC := StringToFloat(dbvalpRedBC.Field.Value); //RoundTo(DM_CNT.Conhec2ReducaoICMS.AsFloat, -2);
         Imp.ICMS.ICMS20.vBC    := StringToFloat(dbvalvBC.Field.Value); //RoundTo(DM_CNT.Conhec2BaseCalc.AsFloat, -2);
         Imp.ICMS.ICMS20.pICMS  := StringToFloat(dbvalpICMS.Field.Value); //RoundTo(DM_CNT.Conhec2AliqICMS.AsFloat, -2);
         Imp.ICMS.ICMS20.vICMS  := StringToFloat(dbvalvICMS.Field.Value); //RoundTo(DM_CNT.Conhec2ValorICMS.AsFloat, -2);
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


    //
    //  Informações da Carga
    //                                  //Format('%8.2f', [edPesoVol1.Value]);



    infCTeNorm.infCarga.vCarga  := StringToFloat(dbValInfCarga.Field.Value);  //StringToFloat(calValCarga.Text); // RoundTo(DM_CNT.Conhec2ValorTotalNF.AsFloat, -2);arga.vMerc   :=  calValCarga.Text; // RoundTo(DM_CNT.Conhec2ValorTotalNF.AsFloat, -2);
    infCTeNorm.infCarga.proPred := edtProPred.Text; //DM_CNT.Conhec2Especie.AsString;
    infCTeNorm.infCarga.xOutCat := edtOutCat.Text; // DM_CNT.Conhec2Natureza.AsString;

    //  Dados do Modal Rodoviário

    infCTeNorm.rodo.RNTRC := edtRodRNTRC.Text;
    infCTeNorm.rodo.dPrev := StrToDate(dataRodPrev.Text);

    case rgRodLotacao.ItemIndex of
      0: infCTeNorm.rodo.lota := ltNao;
      1: infCTeNorm.rodo.lota := ltsim;
    end;


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


   //
                     // 16/11/2016 deu erro  aqui então comentei
   //  Dados do Modal Rodoviário
   //
   /////infCTeNorm.rodo.RNTRC := edtRodRNTRC.Text;
   /////infCTeNorm.rodo.dPrev := StrToDate(dataRodPrev.Text);

   // TpcteLocacao = (ltNao, ltsim);
   //Rodo.Lota := ltNao;

  /////  case rgRodLotacao.ItemIndex of
  ///// 0: infCTeNorm.rodo.lota := ltNao;
  /////  1: infCTeNorm.rodo.lota := ltsim;
  /////  end;

   //
   //  Informações do Detalhamento do CTe do tipo Anulação de Valores
   //

   // infCTeAnuEnt.dEmi:=DM_CNT.Conhec2Data.AsDateTime;
   // infCTeAnuEnt.chCTe:='';
  // manoel end;




   end;
end;

procedure TfrmDemo_ACBrCTe.sbtnGetCertClick(Sender: TObject);
begin
  edtNumSerie.Text := ACBrCTe1.SSL.SelecionarCertificado;
end;

procedure TfrmDemo_ACBrCTe.sbtnLogoMarcaClick(Sender: TObject);
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

procedure TfrmDemo_ACBrCTe.sbtnPathSalvarClick(Sender: TObject);
var
 Dir : string;
begin
 if Length(edtPathLogs.Text) <= 0
  then Dir := ExtractFileDir(application.ExeName)
  else Dir := edtPathLogs.Text;

 if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP)
  then edtPathLogs.Text := Dir;
end;

procedure TfrmDemo_ACBrCTe.TabSheet11Show(Sender: TObject);
begin
  edtDestBusca.SetFocus;
  GroupBoxDestinatario.Visible := False;
end;

procedure TfrmDemo_ACBrCTe.TabSheet12Show(Sender: TObject);
begin
  if(modoGravacao = 'INCLUIR')then
  begin
    btnGravarCTe.Click;
  end;

  if(edtNumCte.Text <> '') then
  begin
    if not(dm.qCOMP.Active)then
      dm.qCOMP.Active;
    dm.qCOMP.Params[0].AsInteger := val_genCte;
    dm.qCOMP.Open;
  end;
  combICMSDevido.Enabled := False;
  calValB.Enabled := False;
  valAliIn.Enabled := False;
  valAliInter.Enabled := False;
  valICMSPartI.Enabled := False;
  valIMCSPartF.Enabled := False;
  valCombIni.Enabled := False;
  valCombFim.Enabled := False;


end;

procedure TfrmDemo_ACBrCTe.TabSheet13Show(Sender: TObject);
begin
  edtBuscaTomador.SetFocus;
end;

procedure TfrmDemo_ACBrCTe.TabSheet15Show(Sender: TObject);
begin
  edtExpBusca.SetFocus;
end;

procedure TfrmDemo_ACBrCTe.TabSheet16Show(Sender: TObject);
begin
  edtRecBusca.SetFocus;
end;

procedure TfrmDemo_ACBrCTe.TabSheet1Show(Sender: TObject);
begin
  edtSerieCte.SetFocus;
end;

procedure TfrmDemo_ACBrCTe.TabSheet20Show(Sender: TObject);
begin
  cdsSeries.Active;
  cdsSeries.Open;
end;

procedure TfrmDemo_ACBrCTe.TabSheet23Show(Sender: TObject);
begin
  edtRodRNTRC.SetFocus;
end;

procedure TfrmDemo_ACBrCTe.TabSheet24Show(Sender: TObject);
var vDate1 , vDate2 : TdateTime;
begin
     vDate1 := StartOfTheMonth(today);
     JvDateTimePicker1.Date := vDate1 ;
     vDate2 := today;
     JvDateTimePicker2.Date := vDate2 ;

end;
procedure TfrmDemo_ACBrCTe.TabSheet25Show(Sender: TObject);
begin
  if(modoGravacao = 'INCLUIR')then
  begin
    btnGravarCTe.Click;
  end;
  dbValInfCarga.SetFocus;
    if(edtNumCte.Text <> '') then
  begin
      if not(dm.qQC.Active)then
    dm.qQC.Active;
    dm.qQC.Params[0].AsInteger := val_genCte;
    dm.qQC.Open;
  end;
end;

procedure TfrmDemo_ACBrCTe.TabSheet28Show(Sender: TObject);
begin
  // PULEI 
  if(edtNumCte.Text <> '') then
  begin
    if not(dm.qSeg.Active)then
      dm.qSeg.Active;
    dm.qSeg.Params[0].AsInteger := val_genCte;
    dm.qSeg.Open;
  end;
end;

procedure TfrmDemo_ACBrCTe.TabSheet32Show(Sender: TObject);
begin
  if(modoGravacao = 'INCLUIR')then
  begin
    btnGravarCTe.Click;
  end;
  if(edtNumCte.Text <> '') then
  begin
    if not(dm.qNF.Active)then
      dm.qNF.Active;
    dm.qNF.Params[0].AsInteger := val_genCte;
    dm.qNF.Open;
  end;
end;

procedure TfrmDemo_ACBrCTe.TabSheet33Show(Sender: TObject);
begin
  if(edtNumCte.Text <> '') then
  begin
    if not(dm.qNFe.Active)then
      dm.qNFe.Active;
    dm.qNFe.Params[0].AsInteger := val_genCte;
    dm.qNFe.Open;
  end;
end;

procedure TfrmDemo_ACBrCTe.TabSheet3Show(Sender: TObject);
begin
  edtCaracAdTrans.SetFocus;
end;

procedure TfrmDemo_ACBrCTe.TabSheet41Show(Sender: TObject);
begin
//PULEI 
  if(modoGravacao = 'INCLUIR')then
  begin
    btnGravarCTe.Click;
  end;
  if(edtNumCte.Text <> '') then
  begin
    if not(dm.qVeic.Active)then
      dm.qVeic.Active;
    dm.qVeic.Params[0].AsInteger := val_genCte;
    dm.qVeic.Open;
  end;
end;

procedure TfrmDemo_ACBrCTe.TabSheet42Show(Sender: TObject);
begin
  //PULEI   Motorista
  if(modoGravacao = 'INCLUIR')then
  begin
    btnGravarCTe.Click;
  end;
  if(edtNumCte.Text <> '') then
  begin
    if not(dm.qMot.Active)then
      dm.qMot.Active;
    dm.qMot.Params[0].AsInteger := val_genCte;
    dm.qMot.Open;
  end;
end;

procedure TfrmDemo_ACBrCTe.TabSheet4Show(Sender: TObject);
begin
  if(comboEmpresa.Text = '')then
  begin
    if dm.qEmp.Active then
    dm.qEmp.Close;
    dm.qEmp.Open;
    dm.qEmp.First;
    while not dm.qEmp.Eof do
    begin
      comboEmpresa.Items.Add(dm.qEmpRAZAO.AsString);
      dm.qEmp.Next;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.FormActivate(Sender: TObject);
begin
  PageControl1.OwnerDraw:=true;
end;

Procedure TfrmDemo_ACBrCTe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  
  if (dm.cdsCTE.State in [dsInsert, dsEdit]) then
  begin
    MessageDlg('Grave as alterações antes de fechar.', mtInformation, [mbOK], 0);
    Action := caNone;
  end;

end;

procedure TfrmDemo_ACBrCTe.FormCreate(Sender: TObject);
var contar : integer;
       emp,nomexeC ,nomexebd : string ;
begin

//PAREI AQUI , acho q isso fica melhor no ONShow


  LerConfiguracao;
  // PageControl1.ActivePage := TabSheet2;  // Dados
  //PageControl1.ActivePage := TabSheet4;  // Emitente

 // nomexeC := ExtractFileName(Application.ExeName);

  {
  dm.con.AutoCommit := True;
  dm.cdsParametros.Open;
  dm.cdsParametros.Edit;
  dm.cdsParametrosD1.AsString := nomexe;
  dm.cdsParametros.ApplyUpdates(-1);
  dm.con.AutoCommit := False;
  dm.cdsParametros.close;
  }

  dm.qContarEmp.Open;
  contar := dm.qContarEmp.RecordCount;
  emp := dm.qContarEmpRAZAO.AsString;
  dm.qContarEmp.Close;

  dm.qParametros.Close;
  dm.qParametros.Open;
{    manoel
  if(nomexeC <> 'CTe.exe') then
  begin
    dm.con.AutoCommit := True;
    dm.cdsParametros.Open;
    dm.cdsParametros.Edit;
    dm.cdsParametrosD1.AsString := nomexeC;
    dm.cdsParametros.ApplyUpdates(-1);
    dm.con.AutoCommit := False;
    dm.cdsParametros.close;
  end;
}
  nomexebd := dm.qParametrosD1.Text;

  if(nomexebd <> 'Cte.exe') then
  begin
    if(nomexeC = 'ats_CTe.exe') then
    begin
      MessageDlg('Abra o Progrma pelo Aplicativo Cte ' , mtInformation, [mbOK], 0);
      Application.Terminate;
    end;
  end;

  if(dm.qParametrosINSTRUCOES.Text = '') then
  begin
    PageControl1.ActivePage := TabSheet24;
    comboEmpresa.Text := emp;
    btnIniciarEmitente.Click;
  end;

  if(dm.qParametrosINSTRUCOES.Text <> '') then
  begin
    //MessageDlg('AVISO : '+ dm.qParametrosINSTRUCOES.Text   , mtInformation, [mbOK], 0);
    PageControl1.ActivePage := TabSheet44;
    comboEmpresa.Text := emp;
    btnIniciarEmitente.Click;
   // Label153.Caption := 'Gerar Boleto Atualizado Copie o Link Abaixo e Abra em seu Navegador';
   // edtLink.Visible := True;
  end;


  if(dm.qParametrosINSTRUCOES.Text = 'A Licença de uso expirada.') then
  begin
    PageControl1.ActivePage := TabSheet44;
    comboEmpresa.Enabled    := False;
    btnListarCte.Enabled    := False;
    btnIncCte.Enabled       := False;
    btnEditarCte.Enabled    := False;
    btnDuplicarCTe.Enabled  := False;
    btnImpPeriodo.Enabled   := False;
    btnGerar.Enabled        := False;
    BitBtn1.Enabled         := False;
    btnGravarCTe.Enabled    := False;
    btnSalvarConfig.Enabled := False;
    SpeedButton1.Enabled    := False;
   // Label153.Caption := 'Gerar Boleto Atualizado Copie o Link Abaixo e Abra em seu Navegador';
   // edtLink.Visible := True;
  end;


  { multi empresa
  dm.qContarEmp.Open;
  contar := dm.qContarEmp.RecordCount;
  emp := dm.qContarEmpRAZAO.AsString;
  dm.qContarEmp.Close;

  if(contar > 1) then
  begin PageControl1.ActivePage := TabSheet4
  end  else
  begin
    label55.Caption := '.';
    comboEmpresa.Text := emp;
    btnIniciarEmitente.Click;
    PageControl1.ActivePage := TabSheet24;
  end;

  }
  modoGravacao := 'EDITAR';
end;

procedure TfrmDemo_ACBrCTe.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then
  begin
    key:= #0;
    SelectNext((Sender as TwinControl),True,True);
  end;
end;

procedure TfrmDemo_ACBrCTe.FormShow(Sender: TObject);
begin
  dm.zEmpresa.Active := True;
  dm.zEmpresa.Open;
  DadosBasicos;
  CarregarUF;

  dm.qParametros.Close;
  dm.qParametros.Open;

 // btnDuplicarCTe.Enabled  := False;

end;

procedure TfrmDemo_ACBrCTe.btnSalvarConfigClick(Sender: TObject);
begin
  GravarConfiguracao;
  LerConfiguracao;
end;

procedure TfrmDemo_ACBrCTe.ACBrCTe1StatusChange(Sender: TObject);
begin
  case ACBrCTe1.Status of
  stCTeIdle : begin
               if ( frmStatus <> nil ) then frmStatus.Hide;
              end;
  stCTeStatusServico : begin
                        if ( frmStatus = nil )
                         then frmStatus := TfrmStatus.Create(Application);
                        frmStatus.lblStatus.Caption := 'Verificando Status do servico...';
                        frmStatus.Show;
                        frmStatus.BringToFront;
                       end;
  stCTeRecepcao : begin
                   if ( frmStatus = nil )
                    then frmStatus := TfrmStatus.Create(Application);
                   frmStatus.lblStatus.Caption := 'Enviando dados do CTe...';
                   frmStatus.Show;
                   frmStatus.BringToFront;
                  end;
  stCTeRetRecepcao : begin
                      if ( frmStatus = nil )
                       then frmStatus := TfrmStatus.Create(Application);
                      frmStatus.lblStatus.Caption := 'Recebendo dados do CTe...';
                      frmStatus.Show;
                      frmStatus.BringToFront;
                     end;
  stCTeConsulta : begin
                   if ( frmStatus = nil )
                    then frmStatus := TfrmStatus.Create(Application);
                   frmStatus.lblStatus.Caption := 'Consultando CTe...';
                   frmStatus.Show;
                   frmStatus.BringToFront;
                  end;
  stCTeCancelamento : begin
                       if ( frmStatus = nil )
                        then frmStatus := TfrmStatus.Create(Application);
                       frmStatus.lblStatus.Caption := 'Enviando cancelamento de CTe...';
                       frmStatus.Show;
                       frmStatus.BringToFront;
                      end;
  stCTeInutilizacao : begin
                       if ( frmStatus = nil )
                        then frmStatus := TfrmStatus.Create(Application);
                       frmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
                       frmStatus.Show;
                       frmStatus.BringToFront;
                      end;
  stCTeRecibo : begin
                 if ( frmStatus = nil )
                  then frmStatus := TfrmStatus.Create(Application);
                 frmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
                 frmStatus.Show;
                 frmStatus.BringToFront;
                end;
  stCTeCadastro : begin
                   if ( frmStatus = nil )
                    then frmStatus := TfrmStatus.Create(Application);
                   frmStatus.lblStatus.Caption := 'Consultando Cadastro...';
                   frmStatus.Show;
                   frmStatus.BringToFront;
                  end;
  {
  stCTeEnvDPEC : begin
                  if ( frmStatus = nil )
                   then frmStatus := TfrmStatus.Create(Application);
                  frmStatus.lblStatus.Caption := 'Enviando DPEC...';
                  frmStatus.Show;
                  frmStatus.BringToFront;
                 end;
  }
   stCTeEmail : begin
                if ( frmStatus = nil )
                 then frmStatus := TfrmStatus.Create(Application);
                frmStatus.lblStatus.Caption := 'Enviando Email...';
                frmStatus.Show;
                frmStatus.BringToFront;
               end;
  end;
  Application.ProcessMessages;
end;

procedure TfrmDemo_ACBrCTe.BitBtn1Click(Sender: TObject);
begin
  dm.cdsCte.Cancel;
  btnGravarCTe.Caption := 'Gravar CTE';
  btnGravarCte.Font.Style := [];
end;

procedure TfrmDemo_ACBrCTe.ACBrCTe1GerarLog(const Mensagem: String);
begin
 memoLog.Lines.Add(Mensagem);
end;

procedure TfrmDemo_ACBrCTe.btnStatusServClick(Sender: TObject);
begin
 ACBrCTe1.WebServices.StatusServico.Executar;
 MemoResp.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.StatusServico.RetWS);
 memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.StatusServico.RetWS);
 //LoadXML(MemoResp);

 PageControl2.ActivePageIndex := 5;
 MemoDados.Lines.Add('');
 MemoDados.Lines.Add('Status Serviço');
 MemoDados.Lines.Add('tpAmb: '    +TpAmbToStr(ACBrCTe1.WebServices.StatusServico.tpAmb));
 MemoDados.Lines.Add('verAplic: ' +ACBrCTe1.WebServices.StatusServico.verAplic);
 MemoDados.Lines.Add('cStat: '    +IntToStr(ACBrCTe1.WebServices.StatusServico.cStat));
 MemoDados.Lines.Add('xMotivo: '  +ACBrCTe1.WebServices.StatusServico.xMotivo);
 MemoDados.Lines.Add('cUF: '      +IntToStr(ACBrCTe1.WebServices.StatusServico.cUF));
 MemoDados.Lines.Add('dhRecbto: ' +DateTimeToStr(ACBrCTe1.WebServices.StatusServico.dhRecbto));
 MemoDados.Lines.Add('tMed: '     +IntToStr(ACBrCTe1.WebServices.StatusServico.TMed));
 MemoDados.Lines.Add('dhRetorno: '+DateTimeToStr(ACBrCTe1.WebServices.StatusServico.dhRetorno));
 MemoDados.Lines.Add('xObs: '     +ACBrCTe1.WebServices.StatusServico.xObs);
end;

procedure TfrmDemo_ACBrCTe.btnIncCteClick(Sender: TObject);
var
     strEdita :string;
begin
  if(edtCodEmitente.Text = '') then
  begin
   MessageDlg('Inicie um Emitente .', mtInformation, [mbOK], 0);
   PageControl1.ActivePage := TabSheet4;
   exit
  end;


  if (dm.qBuscaSerie.Active) then
    dm.qBuscaSerie.Close;
  dm.qBuscaSerie.sql.Clear;
  dm.qBuscaSerie.sql.Add('SELECT SERIE_CTE ,ULTIMO_NUMERO  FROM SERIES where MODELO = ' + QuotedStr('CT')+
                         ' and CODSERIE = ' + QuotedStr(edtCodEmitente.Text));

  dm.qBuscaSerie.Open;
  if (dm.qBuscaSerie.fieldByName('ULTIMO_NUMERO').asInteger > 0) then
  begin
   edtSerieCte.Text := dm.qBuscaSerie.fieldByName('serie_cte').AsString;
   edtNumCte.Text := IntToStr(dm.qBuscaSerie.fieldByName('ULTIMO_NUMERO').asInteger + 1);
  end;

  MessageDlg('CTe Iniciada com Sucesso.', mtInformation, [mbOK], 0);

  dataGerarCte.DateTime := now;
  edtCFOPBusca.ReadOnly := False;
  edtCFOP.ReadOnly := False;
  edtNatOpe.ReadOnly := False;
  btnGerar.Enabled := True;
  PageControl1.TabIndex := 0;
  edtCFOPBusca.SetFocus;
  modoGravacao := 'INCLUIR';

  /// Começa aqui Correção dia 15/08/17
    if (dm.cdsCOMP.Active)then
      dm.cdsCOMP.Close;
    dm.cdsCOMP.Params[0].AsInteger := 0;
    dm.cdsCOMP.Open;

    if (dm.cdsQC.Active)then
      dm.cdsQC.Close;
    dm.cdsQC.Params[0].AsInteger := 0;
    dm.cdsQC.Open;

    if (dm.cdsQC.Active)then
      dm.cdsQC.Close;
    dm.cdsQC.Params[0].AsInteger := 0;
    dm.cdsQC.Open;

    if (dm.cdsNFe.Active)then
      dm.cdsNFe.Close;
    dm.cdsNFe.Params[0].AsInteger := 0;
    dm.cdsNFe.Open;

    if (dm.cdsSeg.Active)then
      dm.cdsSeg.Close;
    dm.cdsSeg.Params[0].AsInteger := 0;
    dm.cdsSeg.Open;

    if (dm.cdsVeic.Active)then
      dm.cdsVeic.Close;
    dm.cdsVeic.Params[0].AsInteger := 0;
    dm.cdsVeic.Open;

    if (dm.cdsMot.Active)then
      dm.cdsMot.Close;
    dm.cdsMot.Params[0].AsInteger := 0;
    dm.cdsMot.Open;

    if (dm.cdsNF.Active)then
      dm.cdsNF.Close;
    dm.cdsNF.Params[0].AsInteger := 0;
    dm.cdsNF.Open;

    if (dm.cdsNF.Active)then
      dm.cdsNF.Close;
    dm.cdsNF.Params[0].AsInteger := 0;
    dm.cdsNF.Open;

   ////edtProPred.Text := '';
   ////dbValInfCarga.Text := '';

    //15/08/19
   //// edtAntCNPJ.Text  := '';
   //// edtAntNome.Text  := '';
   //// edtAntUF.Text    := '';
   //// edtAntIE.Text    := '';
    edtAntCHCTE.Text := '';

  /// Termina aqui Correção dia 15/08/17

  if (not dm.cdsCTE.Active)then
    dm.cdsCTE.Open;
  dm.cdsCTE.Append;

  dm.cdsCTEVALPICMS.AsFloat := percent_icms;

  btnGravarCTe.Caption := 'Gravar CTE *';
  btnGravarCte.Font.Style := [fsBold];
end;

procedure TfrmDemo_ACBrCTe.btnIncluirClick(Sender: TObject);
begin
  // NAO ENTENDI isso
  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.qQC.Active)then
    dm.qQC.Active;
  dm.qQC.Params[0].AsInteger := val_genCte;
  dm.qQC.Open;
  dm.qQC.Edit;

  fQuantCarga := TfQuantCarga.Create(Application);
  try
    fQuantCarga.btnEdita.Visible :=False;
    fQuantCarga.ShowModal;
  finally
    fQuantCarga.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnInutilizarClick(Sender: TObject);
var
 Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : String;
begin
 if not(InputQuery('WebServices Inutilização ', 'Ano',    Ano))
  then exit;
 if not(InputQuery('WebServices Inutilização ', 'Modelo', Modelo))
  then exit;
 if not(InputQuery('WebServices Inutilização ', 'Serie',  Serie))
  then exit;
 if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroInicial))
  then exit;
 if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroFinal))
  then exit;
 if not(InputQuery('WebServices Inutilização ', 'Justificativa', Justificativa))
  then exit;
 ACBrCTe1.WebServices.Inutiliza(edtEmitCNPJ.Text, Justificativa, StrToInt(Ano),
                                StrToInt(Modelo), StrToInt(Serie),
                                StrToInt(NumeroInicial), StrToInt(NumeroFinal));
 MemoResp.Lines.Text   := UTF8Encode(ACBrCTe1.WebServices.Inutilizacao.RetWS);
 memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Inutilizacao.RetWS);
 //LoadXML(MemoResp, WBResposta);
end;

procedure TfrmDemo_ACBrCTe.btnGerarCTeClick(Sender: TObject);
var   vAux : String;
 strEdita :string;
begin
  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    ShowMessage('Arquivo ja Gerado e Enviado' );
    exit;
  end;
  // if not(InputQuery('WebServices Enviar', 'Numero do Conhecimento', vAux))
  // then exit;
  vAux := edtNumCte.Text;
  ACBrCTe1.Conhecimentos.Clear;
  GerarCTe(vAux);
  ACBrCTe1.Conhecimentos.Items[0].GravarXML('','');
  
  ShowMessage('Arquivo gerado em: '+ACBrCTe1.Conhecimentos.Items[0].NomeArq);
  MemoDados.Lines.Add('Arquivo gerado em: '+ACBrCTe1.Conhecimentos.Items[0].NomeArq);
  MemoResp.Lines.LoadFromFile(ACBrCTe1.Conhecimentos.Items[0].NomeArq);
  //LoadXML(MemoResp, WBResposta);
  PageControl2.ActivePageIndex := 1;

  // validar
  //OpenDialog1.Title := 'Selecione o CTe';
  //OpenDialog1.DefaultExt := '*-cte.xml';
  //OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  //OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

  //if OpenDialog1.Execute then
  //begin
  //  ACBrCTe1.Conhecimentos.Clear;
  //  ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
     ACBrCTe1.Conhecimentos.Assinar;
     ACBrCTe1.Conhecimentos.Validar;
     showmessage('Conhecimento de Transporte Eletrônico Valido');
  //end;

  ACBrCTe1.Enviar(1); //(StrToInt(vNumLote));

  MemoResp.Lines.Text   := UTF8Encode(ACBrCTe1.WebServices.Retorno.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Retorno.RetWS);
  //LoadXML(MemoResp, WBResposta);

  PageControl2.ActivePageIndex := 5;
  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Envio CTe');
  MemoDados.Lines.Add('tpAmb: '+ TpAmbToStr(ACBrCTe1.WebServices.Retorno.TpAmb));
  MemoDados.Lines.Add('verAplic: '+ ACBrCTe1.WebServices.Retorno.verAplic);
  MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrCTe1.WebServices.Retorno.cStat));
  MemoDados.Lines.Add('cUF: '+ IntToStr(ACBrCTe1.WebServices.Retorno.cUF));
  MemoDados.Lines.Add('xMotivo: '+ ACBrCTe1.WebServices.Retorno.xMotivo);
  MemoDados.Lines.Add('xMsg: '+ ACBrCTe1.WebServices.Retorno.Msg);
  MemoDados.Lines.Add('Recibo: '+ ACBrCTe1.WebServices.Retorno.Recibo);
  MemoDados.Lines.Add('Protocolo: '+ ACBrCTe1.WebServices.Retorno.Protocolo);

  if (ACBrCTe1.WebServices.Retorno.Recibo <> '') then
  begin
    dm.con.AutoCommit := True;

    strEdita := 'UPDATE CTE SET NPROT = ';
    strEdita := strEdita + QuotedStr(ACBrCTe1.WebServices.Retorno.Protocolo);
    strEdita := strEdita + ', CHCTE = ';
    strEdita := strEdita + QuotedStr(ACBrCTe1.WebServices.Retorno.Recibo);

    strEdita := strEdita + ', STATUS_CTE = ';
    strEdita := strEdita + QuotedStr('Autorizada');

    strEdita := strEdita + ' WHERE COD_CTE = ';
    strEdita := strEdita + IntToStr(val_genCte);

    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEdita);
      dm.con.Commit;

      MessageDlg('Protocolo Gravada com Sucesso.', mtInformation, [mbOK], 0);
      FormatSettings.DecimalSeparator := ',';
      dm.con.AutoCommit := False;
       ACBrCTe1.Conhecimentos.ImprimirPDF;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;

  end;


  ACBrCTe1.Conhecimentos.Clear;

end;

procedure TfrmDemo_ACBrCTe.btnConsCadClick(Sender: TObject);
var  UF, Documento : String;
begin
  if not(InputQuery('WebServices Consulta Cadastro ', 'UF do Documento a ser Consultado:', UF))
  then exit;
  if not(InputQuery('WebServices Consulta Cadastro ', 'Documento(CPF/CNPJ)', Documento))
  then exit;

  Documento := Trim(OnlyNumber(Documento));

  ACBrCTe1.WebServices.ConsultaCadastro.UF := UF;
  if Length(Documento) > 11
  then ACBrCTe1.WebServices.ConsultaCadastro.CNPJ := Documento
  else ACBrCTe1.WebServices.ConsultaCadastro.CPF := Documento;
  ACBrCTe1.WebServices.ConsultaCadastro.Executar;

  MemoResp.Lines.Text   := UTF8Encode(ACBrCTe1.WebServices.ConsultaCadastro.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.ConsultaCadastro.RetWS);
  // LoadXML(MemoResp, WBResposta);

  ShowMessage(ACBrCTe1.WebServices.ConsultaCadastro.xMotivo);
  ShowMessage(ACBrCTe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xNome);
end;

procedure TfrmDemo_ACBrCTe.btnCriarEnviarClick(Sender: TObject);
var  vAux, vNumLote : String;
begin
  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    ShowMessage('Arquivo ja Gerado e Enviado ');
    exit;
  end;
  //if not(InputQuery('WebServices Enviar', 'Numero do Conhecimento', vAux))
  // then exit;

  //if not(InputQuery('WebServices Enviar', 'Numero do Lote', vNumLote))
  // then exit;
  vAux := edtNumCte.Text;
  ACBrCTe1.Conhecimentos.Clear;
  GerarCTe(vAux);
  ACBrCTe1.Enviar(StrToInt(vNumLote));

  MemoResp.Lines.Text   := UTF8Encode(ACBrCTe1.WebServices.Retorno.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Retorno.RetWS);
  //LoadXML(MemoResp, WBResposta);

  PageControl2.ActivePageIndex := 5;
  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Envio CTe');
  MemoDados.Lines.Add('tpAmb: '+ TpAmbToStr(ACBrCTe1.WebServices.Retorno.TpAmb));
  MemoDados.Lines.Add('verAplic: '+ ACBrCTe1.WebServices.Retorno.verAplic);
  MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrCTe1.WebServices.Retorno.cStat));
  MemoDados.Lines.Add('cUF: '+ IntToStr(ACBrCTe1.WebServices.Retorno.cUF));
  MemoDados.Lines.Add('xMotivo: '+ ACBrCTe1.WebServices.Retorno.xMotivo);
  MemoDados.Lines.Add('xMsg: '+ ACBrCTe1.WebServices.Retorno.Msg);
  MemoDados.Lines.Add('Recibo: '+ ACBrCTe1.WebServices.Retorno.Recibo);
  MemoDados.Lines.Add('Protocolo: '+ ACBrCTe1.WebServices.Retorno.Protocolo);

  ACBrCTe1.Conhecimentos.Clear;
end;

procedure TfrmDemo_ACBrCTe.btnDuplicarClick(Sender: TObject);
begin
  FormatSettings.DecimalSeparator := '.';
  val_genCte := dm.cdsCTECOD_CTE.AsInteger;
  if (dm.cdsCTE.Active) then
  dm.cdsCTE.Edit;

  edtCFOP.Text := dm.cdsCTECTE_CFOP.AsString;
  edtNatOpe.Text := dm.cdsCTECTE_NATOP.AsString;

  edtModelo.Text := dm.cdsCTEMODELO.AsString;
  edtSerieCte.Text := dm.cdsCTECTE_SERIE.AsString;
  edtNumCte.Text := dm.cdsCTECTE_NUMERO.AsString;
  dataGerarCte.date := dm.cdsCTEDHEMI.Value;
  rgModal.ItemIndex := dm.cdsCTEMODAL.AsInteger;

  rgTipoServico.ItemIndex  :=  dm.cdsCTETIPOSERVICO.AsInteger;
  rgTiposCte.ItemIndex :=     dm.cdsCTETIPOCTE.AsInteger;
  rgFormaEmissao.ItemIndex := dm.cdsCTETPOEMISSAO.AsInteger;
  rgForPag.ItemIndex :=       dm.cdsCTEIFORPAG.AsInteger;
  rgTipoDACTe.ItemIndex :=    dm.cdsCTETPIMP.AsInteger;

  edtEnvCodCidade.Text := dm.cdsCTEENV_CODCIDADE.AsString;
  edtEnvCidade.Text :=    dm.cdsCTEENV_CIDADE.AsString;
  edtEnvUF.Text :=        dm.cdsCTEENV_ESTADO.AsString;
  edtIniCodCidade.Text := dm.cdsCTEINI_CODCIDADE.AsString;
  edtIniCidade.Text :=    dm.cdsCTEINI_CIDADE.AsString;
  edtIniUF.Text :=        dm.cdsCTEINI_ESTADO.AsString;
  edtFimCodCidade.Text := dm.cdsCTEFIM_CODCIDADE.AsString;
  edtFimCidade.Text :=    dm.cdsCTEFIM_CIDADE.AsString;
  edtFimUF.Text :=        dm.cdsCTEFIM_ESTADO.AsString;

  // emitente
  comboEmpresa.Text       := dm.cdsCTEE_RSOCIAL.AsString;
  edtCodEmitente.Text     := dm.cdsCTEEMITENTE.AsString;
  edtEmitCNPJ.Text        := dm.cdsCTEE_CNPJCPF.AsString;
  edtEmitIE.Text          := dm.cdsCTEE_IESTADUAL.AsString;
  edtEmitRazao.Text       := dm.cdsCTEE_RSOCIAL.AsString;
  edtEmitFantasia.Text    := dm.cdsCTEE_FANTASIA.AsString;
  edtEmitFone.Text        := dm.cdsCTEE_TELEFONE.AsString;
  edtEmitLogradouro.Text  := dm.cdsCTEE_ENDERECO.AsString;
  edtEmitNumero.Text      := dm.cdsCTEE_NUMERO.AsString;
  edtEmitComp.Text        := dm.cdsCTEE_COMPLEMENTO.AsString;
  edtEmitBairro.Text      := dm.cdsCTEE_BAIRRO.AsString;
  edtEmitCodCidade.Text   := dm.cdsCTEE_CODIGOMUNICIPI.AsString;
  edtEmitCidade.Text      := dm.cdsCTEE_CIDADE.AsString;
  edtEmitCep.Text         := dm.cdsCTEE_CEP.AsString;
  edtEmitUF.Text          := dm.cdsCTEE_ESTADO.AsString;

    // tomador
    if(dm.cdsCTET_CNPJCPF.AsString <> '') then
    begin

      rgTomador.ItemIndex      := dm.cdsCTETOMADORSERVICO.AsInteger;

      edtCNPJTomador.Text      := dm.cdsCTET_CNPJCPF.AsString;
      edtIETomador.Text        := dm.cdsCTET_IESTADUAL.AsString;
      edtRazaoTomador.Text     := dm.cdsCTET_RSOCIAL.AsString;
      edtNomeTomador.Text      := dm.cdsCTET_FANTASIA.AsString;
      edtFoneTomador.Text      := dm.cdsCTET_TELEFONE.AsString;
      edtEndTomador.Text       := dm.cdsCTET_ENDERECO.AsString;
      edtNumTomador.Text       := dm.cdsCTET_NUMERO.AsString;
      edtCompTomador.Text      := dm.cdsCTET_COMPLEMENTO.AsString;
      edtBairroTomador.Text    := dm.cdsCTET_BAIRRO.AsString;
      edtTomadorCodCidade.Text := dm.cdsCTET_CODIGOMUNICIPI.AsString;
      edtTomadorCidade.Text    := dm.cdsCTET_CIDADE.AsString;
      edtCepTomador.Text       := dm.cdsCTET_CEP.AsString;
      edtTomadorUF.Text        := dm.cdsCTET_ESTADO.AsString;

    end;

    // rememtente
    edtRemCNPJ.Text          := dm.cdsCTER_CNPJCPF.AsString;
    edtRemIE.Text            := dm.cdsCTER_IESTADUAL.AsString;
    edtRemRazao.Text         := dm.cdsCTER_RSOCIAL.AsString;
    edtRemNome.Text          := dm.cdsCTER_FANTASIA.AsString;
    edtRemFone.Text          := dm.cdsCTER_TELEFONE.AsString;
    edtRemEnd.Text           := dm.cdsCTER_ENDERECO.AsString;
    edtRemNum.Text           := dm.cdsCTER_NUMERO.AsString;
    edtRemComp.Text          := dm.cdsCTER_COMPLEMENTO.AsString;
    edtRemBairro.Text        := dm.cdsCTER_BAIRRO.AsString;
    edtRemCodCidade.Text     := dm.cdsCTER_CODIGOMUNICIPI.AsString;
    edtRemCidade.Text        := dm.cdsCTER_CIDADE.AsString;
    edtRemCep.Text           := dm.cdsCTER_CEP.AsString;
    edtRemUF.Text            := dm.cdsCTER_ESTADO.AsString;
    // destinatario
    edtDestCNPJ.Text         := dm.cdsCTED_CNPJCPF.AsString;
    edtDestIE.Text           := dm.cdsCTED_IESTADUAL.AsString;
    edtDestRazao.Text        := dm.cdsCTED_RSOCIAL.AsString;
    edtDestNome.Text         := dm.cdsCTED_FANTASIA.AsString;
    edtDestFone.Text         := dm.cdsCTED_TELEFONE.AsString;
    edtDestEnd.Text          := dm.cdsCTED_ENDERECO.AsString;
    edtDestNum.Text          := dm.cdsCTED_NUMERO.AsString;
    edtDestComp.Text         := dm.cdsCTED_COMPLEMENTO.AsString;
    edtDestBairro.Text       := dm.cdsCTED_BAIRRO.AsString;
    edtDestCodCidade.Text    := dm.cdsCTED_CODIGOMUNICIPI.AsString;
    edtDestCidade.Text       := dm.cdsCTED_CIDADE.AsString;
    edtDestCep.Text          := dm.cdsCTED_CEP.AsString;
    edtDestUF.Text           := dm.cdsCTED_ESTADO.AsString;
    // recebedor
    if(dm.cdsCTERE_CNPJCPF.AsString <> '') then
    begin
      rgRec.ItemIndex := 0 ;
      edtRecCNPJ.Text          := dm.cdsCTERE_CNPJCPF.AsString;
      edtRecIE.Text            := dm.cdsCTERE_IESTADUAL.AsString;
      edtRecNome.Text          := dm.cdsCTERE_ENDERECO.AsString;
      edtRecRazao.Text         := dm.cdsCTERE_RSOCIAL.AsString;
      edtRecFone.Text          := dm.cdsCTERE_TELEFONE.AsString;
      edtRecEnd.Text           := dm.cdsCTERE_ENDERECO.AsString;
      edtRecNum.Text           := dm.cdsCTERE_NUMERO.AsString;
      edtRecComp.Text          := dm.cdsCTERE_COMPLEMENTO.AsString;
      edtRecBairro.Text        := dm.cdsCTERE_BAIRRO.AsString;
      edtRecCodCidade.Text     := dm.cdsCTERE_CODIGOMUNICIPI.AsString;
      edtRecCidade.Text        := dm.cdsCTERE_CIDADE.AsString;
      edtRecCep.TExt           := dm.cdsCTERE_CEP.AsString;
      edtRecUF.Text            := dm.cdsCTERE_ESTADO.AsString;
    end;

    if(dm.cdsCTEEX_CNPJCPF.AsString <> '') then
    begin
      rgExp.ItemIndex := 0;
      edtExpCNPJ.Text          := dm.cdsCTEEX_CNPJCPF.AsString;
      edtExpIE.Text            := dm.cdsCTEEX_IESTADUAL.AsString;
      edtExpRazao.Text         := dm.cdsCTEEX_RSOCIAL.AsString;
      edtExpNome.Text          := dm.cdsCTEEX_FANTASIA.AsString;
      edtExpFone.Text          := dm.cdsCTEEX_TELEFONE.AsString;
      edtExpEnd.Text           := dm.cdsCTEEX_ENDERECO.AsString;
      edtExpNum.Text           := dm.cdsCTEEX_COMPLEMENTO.AsString;
      edtExpComp.Text          := dm.cdsCTEEX_COMPLEMENTO.AsString;
      edtExpBairro.Text        := dm.cdsCTEEX_BAIRRO.AsString;
      edtExpCodCidade.Text     := dm.cdsCTEEX_CODIGOMUNICIPI.AsString;
      edtExpCidade.Text        := dm.cdsCTEEX_CIDADE.AsString;
      edtExpCep.Text           := dm.cdsCTEEX_CEP.AsString;
      edtExpUF.Text            := dm.cdsCTEEX_ESTADO.AsString;
    end;

    edtCaracAdTrans.Text := dm.cdsCTECARAC_TRANSP.AsString;
    edtCaracAdServ.Text  := dm.cdsCTECARAC_SERV.AsString;
    edtFuncEmi.Text      := dm.cdsCTEFUNC_EMI.AsString;

    rgRetira.ItemIndex   := dm.cdsCTERETIRA.AsInteger;
    memDetRetira.Text    := dm.cdsCTEDET_RETIRA.AsString;

    //dbValTotPrest.Field.Value := dm.cdsCTEVPREST.Value;
    //dbValReceber.Field.Value  := dm.cdsCTEVREC.Value;
    //dbValTotTri.Field.Value   := dm.cdsCTEVALTOTTRI.Value;

    combCodSitTrib.ItemIndex := dm.cdsCTECOMBCODSITTRIB.Value;

    dbValInfCarga.Field.Value := dm.cdsCTEVALINFCARGA.Value;
    edtProPred.Text := dm.cdsCTEPROPRED.AsString;
    edtOutCat.Text := dm.cdsCTEOUTCAT.AsString;

    edtRodRNTRC.Text := dm.cdsCTERNTRC.AsString;
    dataRodPrev.date := dm.cdsCTEDATARODPREV.Value;
    rgRodLotacao.ItemIndex := dm.cdsCTERGRODLOTACAO.Value;




    memxObs.Text := dm.cdsCTEOBS_GERAL.Value;
  {
    if (dm.qCOMP.Active)then
      dm.qCOMP.Close;
    dm.qCOMP.Params[0].AsInteger := val_genCte;
    dm.qCOMP.Open;
  }                     // para Clonar  colocar cds da tabela
    if (dm.cdsCOMP.Active)then
      dm.cdsCOMP.Close;
    dm.cdsCOMP.Params[0].AsInteger := val_genCte;
    dm.cdsCOMP.Open;
  {
    if (dm.qQC.Active)then
      dm.qQC.Close;
    dm.qQC.Params[0].AsInteger := val_genCte;
    dm.qQC.Open;
  }                        // para Clonar  colocar cds da tabela
    if (dm.cdsQC.Active)then
      dm.cdsQC.Close;
    dm.cdsQC.Params[0].AsInteger := val_genCte;
    dm.cdsQC.Open;

    if (dm.cdsNFe.Active)then
      dm.cdsNFe.Close;
    dm.cdsNFe.Params[0].AsInteger := val_genCte;
    dm.cdsNFe.Open;
 {
    if (dm.qSeg.Active)then
      dm.qSeg.Close;
    dm.qSeg.Params[0].AsInteger := val_genCte;
    dm.qSeg.Open;
  }
    if (dm.cdsVeic.Active)then
      dm.cdsVeic.Close;
    dm.cdsVeic.Params[0].AsInteger := val_genCte;
    dm.cdsVeic.Open;

    if (dm.cdsMot.Active)then
      dm.cdsMot.Close;
    dm.cdsMot.Params[0].AsInteger := val_genCte;
    dm.cdsMot.Open;
  {
    if (dm.qNF.Active)then
      dm.qNF.Close;
    dm.qNF.Params[0].AsInteger := val_genCte;
    dm.qNF.Open;
   }
    if (dm.cdsNF.Active)then
      dm.cdsNF.Close;
    dm.cdsNF.Params[0].AsInteger := val_genCte;
    dm.cdsNF.Open;

    // outros
    combOutrosDocs.Text    := dm.cdsCTEOUTPDOC.AsString ;
    dataOutrosEmi.DateTime := dm.cdsCTEOUDEMI.AsDateTime  ;
    edtOutrosNum.Text      := dm.cdsCTEOUNDOC.AsString ;
    edtOutrosDesc.Text     := dm.cdsCTEOUDESCOUTRO.AsString ;
    valOutrosVal.Value     := dm.cdsCTEOUVDOCFISC.Value ;

//, OUTPDOC                VARCHAR( 2 )
//, OUDESCOUTRO            VARCHAR( 100 )
//, OUNDOC                 VARCHAR( 20 )
//, OUDEMI                 TIMESTAMP
//, OUVDOCFISC             DOUBLE PRECISION



    if (dm.cdsCTE.Active)then
      dm.cdsCTE.Close;
    dm.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
    dm.cdsCTE.Params[1].AsInteger := StrToInt(edtNumCte.Text);
    dm.cdsCTE.Open;

    if (modoGravacao = 'EDITAR') then
    begin
      // vai pra primeira ABA
      PageControl1.ActivePage:=TabSheet2;
      btnGerar.Enabled := True;
      modoGravacao := 'EDITAR';
      FormatSettings.DecimalSeparator := ',';
      if (dm.cdsCTENPROT.AsString = '') then
      begin
        btnGravarCTe.Caption := 'Gravar CTE *';
        btnGravarCte.Font.Style := [fsBold];
        dm.cdsCTE.Edit;
      end;
      edtCFOPBusca.ReadOnly := False;
      edtCFOP.ReadOnly := False;
      edtNatOpe.ReadOnly := False;

      btnPreVisu.Enabled := True;
    end;
end;

procedure TfrmDemo_ACBrCTe.btnConsultarReciboClick(Sender: TObject);
var
 aux : String;
begin
 if not(InputQuery('Consultar Recibo Lote', 'Número do Recibo', aux))
  then exit;

  ACBrCTe1.WebServices.Recibo.Recibo := aux;
  ACBrCTe1.WebServices.Recibo.Executar;

  MemoResp.Lines.Text   := UTF8Encode(ACBrCTe1.WebServices.Recibo.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Recibo.RetWS);
 // LoadXML(MemoResp, WBResposta);
end;

procedure TfrmDemo_ACBrCTe.btnConsultarClick(Sender: TObject);
begin
 OpenDialog1.Title := 'Selecione o CTe';
 OpenDialog1.DefaultExt := '*-cte.xml';
 OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

 if OpenDialog1.Execute then
  begin
   ACBrCTe1.Conhecimentos.Clear;
   ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
   ACBrCTe1.Consultar;

   ShowMessage(ACBrCTe1.WebServices.Consulta.Protocolo);
   MemoResp.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Consulta.RetWS);
   memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Consulta.RetWS);

   // Retorno do XML completo: CTe + Eventos vinculados
   MemoDados.Lines.Text :=  UTF8Encode(ACBrCTe1.WebServices.Consulta.RetCTeDFe);

  // LoadXML(MemoResp, WBResposta);
 end;
end;

procedure TfrmDemo_ACBrCTe.btnConsultarChaveClick(Sender: TObject);
var
 vChave : String;
begin
  if not(InputQuery('WebServices Consultar', 'Chave do CT-e:', vChave)) then
    exit;

  ACBrCTe1.WebServices.Consulta.CTeChave := vChave;
  ACBrCTe1.WebServices.Consulta.Executar;

  MemoResp.Lines.Text :=  UTF8Encode(ACBrCTe1.WebServices.Consulta.RetWS);
  memoRespWS.Lines.Text :=  UTF8Encode(ACBrCTe1.WebServices.Consulta.RetornoWS);
 // LoadXML(MemoResp, WBResposta);
end;

procedure TfrmDemo_ACBrCTe.btnEditarClick(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.cdsQC.Active)then
    dm.cdsQC.Active;
  dm.cdsQC.Params[0].AsInteger := val_genCte;
  dm.cdsQC.Open;


  fQuantCarga := TfQuantCarga.Create(Application);
  try
    fQuantCarga.btnOk.Visible :=False;
    fQuantCarga.combQC.Text :=  dbGridQC.Columns[0].Field.Value;  //dbGridQC.Columns.FindItemID cdsQCUNID.AsString;
    fQuantCarga.edtQCTm.Text := dbGridQC.Columns[1].Field.Value;  //cdsQCMEDIDA.AsString;
    fQuantCarga.valQCQ.Text := dbGridQC.Columns[2].Field.Value;  //cdsQCQUANT.AsString;
    fQuantCarga.ShowModal;
  finally
    fQuantCarga.Free;
  end;

end;

procedure TfrmDemo_ACBrCTe.btnEnvEPECClick(Sender: TObject);
var
 vAux : String;
begin
 ShowMessage('Opção não Implementada, no programa exemplo!');
end;

procedure TfrmDemo_ACBrCTe.btnImportarXMLClick(Sender: TObject);
var
 i, j, k, n  : integer;
 Nota, Node, NodePai, NodeItem: TTreeNode;
begin
 OpenDialog1.FileName  :=  '';
 OpenDialog1.Title := 'Selecione o CTe';
 OpenDialog1.DefaultExt := '*-cte.xml';
 OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

 if OpenDialog1.Execute then
  begin
   ACBrCTe1.Conhecimentos.Clear;
   ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
   trvwCTe.Items.Clear;

   for n:=0 to ACBrCTe1.Conhecimentos.Count-1 do
    begin
     with ACBrCTe1.Conhecimentos.Items[n].CTe do
      begin
       (*
       Nota := trvwCTe.Items.Add(nil,infCTe.ID);
       trvwCTe.Items.AddChild(Nota,'ID= ' +infCTe.ID);
       Node := trvwCTe.Items.AddChild(Nota,'procCTe');
       trvwCTe.Items.AddChild(Node,'tpAmb= '     +TpAmbToStr(procCTe.tpAmb));
       trvwCTe.Items.AddChild(Node,'verAplic= '  +procCTe.verAplic);
       trvwCTe.Items.AddChild(Node,'chCTe= '     +procCTe.chCTe);
       trvwCTe.Items.AddChild(Node,'dhRecbto= '  +DateTimeToStr(procCTe.dhRecbto));
       trvwCTe.Items.AddChild(Node,'nProt= '     +procCTe.nProt);
       trvwCTe.Items.AddChild(Node,'digVal= '    +procCTe.digVal);
       trvwCTe.Items.AddChild(Node,'cStat= '     +IntToStr(procCTe.cStat));
       trvwCTe.Items.AddChild(Node,'xMotivo= '   +procCTe.xMotivo);

       Node := trvwCTe.Items.AddChild(Nota,'Ide');
       trvwCTe.Items.AddChild(Node,'cNF= '     +IntToStr(Ide.cNF));
       trvwCTe.Items.AddChild(Node,'natOp= '   +Ide.natOp );
       trvwCTe.Items.AddChild(Node,'indPag= '  +IndpagToStr(Ide.indPag));
       trvwCTe.Items.AddChild(Node,'modelo= '  +IntToStr(Ide.modelo));
       trvwCTe.Items.AddChild(Node,'serie= '   +IntToStr(Ide.serie));
       trvwCTe.Items.AddChild(Node,'nNF= '     +IntToStr(Ide.nNF));
       trvwCTe.Items.AddChild(Node,'dEmi= '    +DateToStr(Ide.dEmi));
       trvwCTe.Items.AddChild(Node,'dSaiEnt= ' +DateToStr(Ide.dSaiEnt));
       trvwCTe.Items.AddChild(Node,'tpNF= '    +tpNFToStr(Ide.tpNF));
       trvwCTe.Items.AddChild(Node,'finCTe= '  +FinCTeToStr(Ide.finCTe));
       trvwCTe.Items.AddChild(Node,'verProc= ' +Ide.verProc);
       trvwCTe.Items.AddChild(Node,'cUF= '     +IntToStr(Ide.cUF));
       trvwCTe.Items.AddChild(Node,'cMunFG= '  +IntToStr(Ide.cMunFG));
       trvwCTe.Items.AddChild(Node,'tpImp= '   +TpImpToStr(Ide.tpImp));
       trvwCTe.Items.AddChild(Node,'tpEmis= '  +TpEmisToStr(Ide.tpEmis));
       trvwCTe.Items.AddChild(Node,'cDV= '     +IntToStr(Ide.cDV));
       trvwCTe.Items.AddChild(Node,'tpAmb= '   +TpAmbToStr(Ide.tpAmb));
       trvwCTe.Items.AddChild(Node,'finCTe= '  +FinCTeToStr(Ide.finCTe));
       trvwCTe.Items.AddChild(Node,'procEmi= ' +procEmiToStr(Ide.procEmi));
       trvwCTe.Items.AddChild(Node,'verProc= ' +Ide.verProc);

       for i:=0 to Ide.NFref.Count-1 do
        begin
          Node := trvwCTe.Items.AddChild(Node,'NFRef'+IntToStrZero(i+1,3));
          trvwCTe.Items.AddChild(Node,'refCTe= ' +Ide.NFref.Items[i].refCTe);
          trvwCTe.Items.AddChild(Node,'cUF= '    +IntToStr(Ide.NFref.Items[i].RefNF.cUF));
          trvwCTe.Items.AddChild(Node,'AAMM= '   +Ide.NFref.Items[i].RefNF.AAMM);
          trvwCTe.Items.AddChild(Node,'CNPJ= '   +Ide.NFref.Items[i].RefNF.CNPJ);
          trvwCTe.Items.AddChild(Node,'modelo= ' +IntToStr(Ide.NFref.Items[i].RefNF.modelo));
          trvwCTe.Items.AddChild(Node,'serie= '  +IntToStr(Ide.NFref.Items[i].RefNF.serie));
          trvwCTe.Items.AddChild(Node,'nNF= '    +IntToStr(Ide.NFref.Items[i].RefNF.nNF));
        end;
       }
       Node := trvwCTe.Items.AddChild(Nota,'Emit');
       trvwCTe.Items.AddChild(Node,'CNPJCPF= ' +Emit.CNPJCPF);
       trvwCTe.Items.AddChild(Node,'IE='       +Emit.IE);
       trvwCTe.Items.AddChild(Node,'xNome='    +Emit.xNome);
       trvwCTe.Items.AddChild(Node,'xFant='    +Emit.xFant );
       trvwCTe.Items.AddChild(Node,'IEST='     +Emit.IEST);
       trvwCTe.Items.AddChild(Node,'IM='       +Emit.IM);
       trvwCTe.Items.AddChild(Node,'CNAE='     +Emit.CNAE);

       Node := trvwCTe.Items.AddChild(Node,'EnderEmit');
       trvwCTe.Items.AddChild(Node,'Fone='    +Emit.EnderEmit.fone);
       trvwCTe.Items.AddChild(Node,'CEP='     +IntToStr(Emit.EnderEmit.CEP));
       trvwCTe.Items.AddChild(Node,'xLgr='    +Emit.EnderEmit.xLgr);
       trvwCTe.Items.AddChild(Node,'nro='     +Emit.EnderEmit.nro);
       trvwCTe.Items.AddChild(Node,'xCpl='    +Emit.EnderEmit.xCpl);
       trvwCTe.Items.AddChild(Node,'xBairro=' +Emit.EnderEmit.xBairro);
       trvwCTe.Items.AddChild(Node,'cMun='    +IntToStr(Emit.EnderEmit.cMun));
       trvwCTe.Items.AddChild(Node,'xMun='    +Emit.EnderEmit.xMun);
       trvwCTe.Items.AddChild(Node,'UF'       +Emit.EnderEmit.UF);
       trvwCTe.Items.AddChild(Node,'cPais='   +IntToStr(Emit.EnderEmit.cPais));
       trvwCTe.Items.AddChild(Node,'xPais='   +Emit.EnderEmit.xPais);

       if Avulsa.CNPJ  <> '' then
        begin
          Node := trvwCTe.Items.AddChild(Nota,'Avulsa');
          trvwCTe.Items.AddChild(Node,'CNPJ='    +Avulsa.CNPJ);
          trvwCTe.Items.AddChild(Node,'xOrgao='  +Avulsa.xOrgao);
          trvwCTe.Items.AddChild(Node,'matr='    +Avulsa.matr );
          trvwCTe.Items.AddChild(Node,'xAgente=' +Avulsa.xAgente);
          trvwCTe.Items.AddChild(Node,'fone='    +Avulsa.fone);
          trvwCTe.Items.AddChild(Node,'UF='      +Avulsa.UF);
          trvwCTe.Items.AddChild(Node,'nDAR='    +Avulsa.nDAR);
          trvwCTe.Items.AddChild(Node,'dEmi='    +DateToStr(Avulsa.dEmi));
          trvwCTe.Items.AddChild(Node,'vDAR='    +FloatToStr(Avulsa.vDAR));
          trvwCTe.Items.AddChild(Node,'repEmi='  +Avulsa.repEmi);
          trvwCTe.Items.AddChild(Node,'dPag='    +DateToStr(Avulsa.dPag));
        end;
       Node := trvwCTe.Items.AddChild(Nota,'Dest');
       trvwCTe.Items.AddChild(Node,'CNPJCPF= ' +Dest.CNPJCPF);
       trvwCTe.Items.AddChild(Node,'IE='       +Dest.IE);
       trvwCTe.Items.AddChild(Node,'ISUF='     +Dest.ISUF);
       trvwCTe.Items.AddChild(Node,'xNome='    +Dest.xNome);

       Node := trvwCTe.Items.AddChild(Node,'EnderDest');
       trvwCTe.Items.AddChild(Node,'Fone='    +Dest.EnderDest.Fone);
       trvwCTe.Items.AddChild(Node,'CEP='     +IntToStr(Dest.EnderDest.CEP));
       trvwCTe.Items.AddChild(Node,'xLgr='    +Dest.EnderDest.xLgr);
       trvwCTe.Items.AddChild(Node,'nro='     +Dest.EnderDest.nro);
       trvwCTe.Items.AddChild(Node,'xCpl='    +Dest.EnderDest.xCpl);
       trvwCTe.Items.AddChild(Node,'xBairro=' +Dest.EnderDest.xBairro);
       trvwCTe.Items.AddChild(Node,'cMun='    +IntToStr(Dest.EnderDest.cMun));
       trvwCTe.Items.AddChild(Node,'xMun='    +Dest.EnderDest.xMun);
       trvwCTe.Items.AddChild(Node,'UF='      +Dest.EnderDest.UF );
       trvwCTe.Items.AddChild(Node,'cPais='   +IntToStr(Dest.EnderDest.cPais));
       trvwCTe.Items.AddChild(Node,'xPais='   +Dest.EnderDest.xPais);

       {if Retirada.CNPJ <> '' then
        begin
          Node := trvwCTe.Items.AddChild(Nota,'Retirada');
          trvwCTe.Items.AddChild(Node,'CNPJ='    +Retirada.CNPJ);
          trvwCTe.Items.AddChild(Node,'xLgr='    +Retirada.xLgr);
          trvwCTe.Items.AddChild(Node,'nro='     +Retirada.nro);
          trvwCTe.Items.AddChild(Node,'xCpl='    +Retirada.xCpl);
          trvwCTe.Items.AddChild(Node,'xBairro=' +Retirada.xBairro);
          trvwCTe.Items.AddChild(Node,'cMun='    +IntToStr(Retirada.cMun));
          trvwCTe.Items.AddChild(Node,'xMun='    +Retirada.xMun);
          trvwCTe.Items.AddChild(Node,'UF='      +Retirada.UF);
        end;

       if Entrega.CNPJ <> '' then
        begin
          Node := trvwCTe.Items.AddChild(Nota,'Entrega');
          trvwCTe.Items.AddChild(Node,'CNPJ='    +Entrega.CNPJ);
          trvwCTe.Items.AddChild(Node,'xLgr='    +Entrega.xLgr);
          trvwCTe.Items.AddChild(Node,'nro='     +Entrega.nro);
          trvwCTe.Items.AddChild(Node,'xCpl='    +Entrega.xCpl);
          trvwCTe.Items.AddChild(Node,'xBairro=' +Entrega.xBairro);
          trvwCTe.Items.AddChild(Node,'cMun='    +IntToStr(Entrega.cMun));
          trvwCTe.Items.AddChild(Node,'xMun='    +Entrega.xMun);
          trvwCTe.Items.AddChild(Node,'UF='      +Entrega.UF);
        end;}

       for I := 0 to Det.Count-1 do
        begin
          with Det.Items[I] do
           begin
               NodeItem := trvwCTe.Items.AddChild(Nota,'Produto'+IntToStrZero(I+1,3));
               trvwCTe.Items.AddChild(NodeItem,'nItem='  +IntToStr(Prod.nItem) );
               trvwCTe.Items.AddChild(NodeItem,'cProd='  +Prod.cProd );
               trvwCTe.Items.AddChild(NodeItem,'cEAN='   +Prod.cEAN);
               trvwCTe.Items.AddChild(NodeItem,'xProd='  +Prod.xProd);
               trvwCTe.Items.AddChild(NodeItem,'NCM='    +Prod.NCM);
               trvwCTe.Items.AddChild(NodeItem,'EXTIPI=' +Prod.EXTIPI);
               //trvwCTe.Items.AddChild(NodeItem,'genero=' +IntToStr(Prod.genero));
               trvwCTe.Items.AddChild(NodeItem,'CFOP='   +Prod.CFOP);
               trvwCTe.Items.AddChild(NodeItem,'uCom='   +Prod.uCom);
               trvwCTe.Items.AddChild(NodeItem,'qCom='   +FloatToStr(Prod.qCom));
               trvwCTe.Items.AddChild(NodeItem,'vUnCom=' +FloatToStr(Prod.vUnCom));
               trvwCTe.Items.AddChild(NodeItem,'vProd='  +FloatToStr(Prod.vProd));

               trvwCTe.Items.AddChild(NodeItem,'cEANTrib=' +Prod.cEANTrib);
               trvwCTe.Items.AddChild(NodeItem,'uTrib='    +Prod.uTrib);
               trvwCTe.Items.AddChild(NodeItem,'qTrib='    +FloatToStr(Prod.qTrib));
               trvwCTe.Items.AddChild(NodeItem,'vUnTrib='  +FloatToStr(Prod.vUnTrib));

               trvwCTe.Items.AddChild(NodeItem,'vFrete=' +FloatToStr(Prod.vFrete));
               trvwCTe.Items.AddChild(NodeItem,'vSeg='   +FloatToStr(Prod.vSeg));
               trvwCTe.Items.AddChild(NodeItem,'vDesc='  +FloatToStr(Prod.vDesc));

               trvwCTe.Items.AddChild(NodeItem,'infAdProd=' +infAdProd);

               for J:=0 to Prod.DI.Count-1 do
                begin
                  if Prod.DI.Items[j].nDi <> '' then
                   begin
                     with Prod.DI.Items[j] do
                      begin
                        NodePai := trvwCTe.Items.AddChild(NodeItem,'DI'+IntToStrZero(J+1,3));
                        trvwCTe.Items.AddChild(NodePai,'nDi='         +nDi);
                        trvwCTe.Items.AddChild(NodePai,'dDi='         +DateToStr(dDi));
                        trvwCTe.Items.AddChild(NodePai,'xLocDesemb='  +xLocDesemb);
                        trvwCTe.Items.AddChild(NodePai,'UFDesemb='    +UFDesemb);
                        trvwCTe.Items.AddChild(NodePai,'dDesemb='     +DateToStr(dDesemb));
                        trvwCTe.Items.AddChild(NodePai,'cExportador=' +cExportador);;

                        for K:=0 to adi.Count-1 do
                         begin
                           with adi.Items[K] do
                            begin
                              Node := trvwCTe.Items.AddChild(NodePai,'LADI'+IntToStrZero(K+1,3));
                              trvwCTe.Items.AddChild(Node,'nAdicao='     +IntToStr(nAdicao));
                              trvwCTe.Items.AddChild(Node,'nSeqAdi='     +IntToStr(nSeqAdi));
                              trvwCTe.Items.AddChild(Node,'cFabricante=' +cFabricante);
                              trvwCTe.Items.AddChild(Node,'vDescDI='     +FloatToStr(vDescDI));
                            end;
                         end;
                      end;
                   end
                  else
                    Break;
                end;

              if Prod.veicProd.chassi <> '' then
               begin
                 Node := trvwCTe.Items.AddChild(NodeItem,'Veiculo');
                 with Prod.veicProd do
                  begin
                    trvwCTe.Items.AddChild(Node,'tpOP='     +tpOPToStr(tpOP));
                    trvwCTe.Items.AddChild(Node,'chassi='   +chassi);
                    trvwCTe.Items.AddChild(Node,'cCor='     +cCor);
                    trvwCTe.Items.AddChild(Node,'xCor='     +xCor);
                    trvwCTe.Items.AddChild(Node,'pot='      +pot);
                    trvwCTe.Items.AddChild(Node,'Cilin='      +Cilin);
                    trvwCTe.Items.AddChild(Node,'pesoL='    +pesoL);
                    trvwCTe.Items.AddChild(Node,'pesoB='    +pesoB);
                    trvwCTe.Items.AddChild(Node,'nSerie='   +nSerie);
                    trvwCTe.Items.AddChild(Node,'tpComb='   +tpComb);
                    trvwCTe.Items.AddChild(Node,'nMotor='   +nMotor);
                    trvwCTe.Items.AddChild(Node,'CMT='     +CMT);
                    trvwCTe.Items.AddChild(Node,'dist='     +dist);
                    trvwCTe.Items.AddChild(Node,'RENAVAM='  +RENAVAM);
                    trvwCTe.Items.AddChild(Node,'anoMod='   +IntToStr(anoMod));
                    trvwCTe.Items.AddChild(Node,'anoFab='   +IntToStr(anoFab));
                    trvwCTe.Items.AddChild(Node,'tpPint='   +tpPint);
                    trvwCTe.Items.AddChild(Node,'tpVeic='   +IntToStr(tpVeic));
                    trvwCTe.Items.AddChild(Node,'espVeic='  +IntToStr(espVeic));
                    trvwCTe.Items.AddChild(Node,'VIN='      +VIN);
                    trvwCTe.Items.AddChild(Node,'condVeic=' +condVeicToStr(condVeic));
                    trvwCTe.Items.AddChild(Node,'cMod='     +cMod);
                  end;
               end;

               for J:=0 to Prod.med.Count-1 do
                begin
                  Node := trvwCTe.Items.AddChild(NodeItem,'Medicamento'+IntToStrZero(J+1,3) );
                  with Prod.med.Items[J] do
                   begin
                     trvwCTe.Items.AddChild(Node,'nLote=' +nLote);
                     trvwCTe.Items.AddChild(Node,'qLote=' +FloatToStr(qLote));
                     trvwCTe.Items.AddChild(Node,'dFab='  +DateToStr(dFab));
                     trvwCTe.Items.AddChild(Node,'dVal='  +DateToStr(dVal));
                     trvwCTe.Items.AddChild(Node,'vPMC='  +FloatToStr(vPMC));
                    end;
                end;

               for J:=0 to Prod.arma.Count-1 do
                begin
                  Node := trvwCTe.Items.AddChild(NodeItem,'Arma'+IntToStrZero(J+1,3));
                  with Prod.arma.Items[J] do
                   begin
                     trvwCTe.Items.AddChild(Node,'nSerie=' +IntToStr(nSerie));
                     trvwCTe.Items.AddChild(Node,'tpArma=' +tpArmaToStr(tpArma));
                     trvwCTe.Items.AddChild(Node,'nCano='  +IntToStr(nCano));
                     trvwCTe.Items.AddChild(Node,'descr='  +descr);
                    end;
                end;

               if (Prod.comb.cProdANP > 0) then
                begin
                 NodePai := trvwCTe.Items.AddChild(NodeItem,'Combustivel');
                 with Prod.comb do
                  begin
                    trvwCTe.Items.AddChild(NodePai,'cProdANP=' +IntToStr(cProdANP));
                    trvwCTe.Items.AddChild(NodePai,'CODIF='    +CODIF);
                    trvwCTe.Items.AddChild(NodePai,'qTemp='    +FloatToStr(qTemp));

                    Node := trvwCTe.Items.AddChild(NodePai,'CIDE'+IntToStrZero(I+1,3));
                    trvwCTe.Items.AddChild(Node,'qBCprod='   +FloatToStr(CIDE.qBCprod));
                    trvwCTe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(CIDE.vAliqProd));
                    trvwCTe.Items.AddChild(Node,'vCIDE='     +FloatToStr(CIDE.vCIDE));

                    Node := trvwCTe.Items.AddChild(NodePai,'ICMSComb'+IntToStrZero(I+1,3));
                    trvwCTe.Items.AddChild(Node,'vBCICMS='   +FloatToStr(ICMS.vBCICMS));
                    trvwCTe.Items.AddChild(Node,'vICMS='     +FloatToStr(ICMS.vICMS));
                    trvwCTe.Items.AddChild(Node,'vBCICMSST=' +FloatToStr(ICMS.vBCICMSST));
                    trvwCTe.Items.AddChild(Node,'vICMSST='   +FloatToStr(ICMS.vICMSST));

                    if (ICMSInter.vBCICMSSTDest>0) then
                     begin
                       Node := trvwCTe.Items.AddChild(NodePai,'ICMSInter'+IntToStrZero(I+1,3));
                       trvwCTe.Items.AddChild(Node,'vBCICMSSTDest=' +FloatToStr(ICMSInter.vBCICMSSTDest));
                       trvwCTe.Items.AddChild(Node,'vICMSSTDest='   +FloatToStr(ICMSInter.vICMSSTDest));
                     end;

                    if (ICMSCons.vBCICMSSTCons>0) then
                     begin
                       Node := trvwCTe.Items.AddChild(NodePai,'ICMSCons'+IntToStrZero(I+1,3));
                       trvwCTe.Items.AddChild(Node,'vBCICMSSTCons=' +FloatToStr(ICMSCons.vBCICMSSTCons));
                       trvwCTe.Items.AddChild(Node,'vICMSSTCons='   +FloatToStr(ICMSCons.vICMSSTCons));
                       trvwCTe.Items.AddChild(Node,'UFCons='        +ICMSCons.UFcons);
                     end;
                  end;
               end;

               with Imposto do
                begin
                   NodePai := trvwCTe.Items.AddChild(NodeItem,'Imposto');
                   Node := trvwCTe.Items.AddChild(NodePai,'ICMS');
                   with ICMS do
                    begin
                      trvwCTe.Items.AddChild(Node,'CST=' +CSTICMSToStr(CST));

                      if CST = cst00 then
                       begin
                         trvwCTe.Items.AddChild(Node,'orig='  +OrigToStr(ICMS.orig));
                         trvwCTe.Items.AddChild(Node,'modBC=' +modBCToStr(ICMS.modBC));
                         trvwCTe.Items.AddChild(Node,'vBC='   +FloatToStr(ICMS.vBC));
                         trvwCTe.Items.AddChild(Node,'pICMS=' +FloatToStr(ICMS.pICMS));
                         trvwCTe.Items.AddChild(Node,'vICMS=' +FloatToStr(ICMS.vICMS));
                       end
                      else if CST = cst10 then
                       begin
                         trvwCTe.Items.AddChild(Node,'orig='     +OrigToStr(ICMS.orig));
                         trvwCTe.Items.AddChild(Node,'modBC='    +modBCToStr(ICMS.modBC));
                         trvwCTe.Items.AddChild(Node,'vBC='      +FloatToStr(ICMS.vBC));
                         trvwCTe.Items.AddChild(Node,'pICMS='    +FloatToStr(ICMS.pICMS));
                         trvwCTe.Items.AddChild(Node,'vICMS='    +FloatToStr(ICMS.vICMS));
                         trvwCTe.Items.AddChild(Node,'modBCST='  +modBCSTToStr(ICMS.modBCST));
                         trvwCTe.Items.AddChild(Node,'pMVAST='   +FloatToStr(ICMS.pMVAST));
                         trvwCTe.Items.AddChild(Node,'pRedBCST=' +FloatToStr(ICMS.pRedBCST));
                         trvwCTe.Items.AddChild(Node,'vBCST='    +FloatToStr(ICMS.vBCST));
                         trvwCTe.Items.AddChild(Node,'pICMSST='  +FloatToStr(ICMS.pICMSST));
                         trvwCTe.Items.AddChild(Node,'vICMSST='  +FloatToStr(ICMS.vICMSST));
                       end
                      else if CST = cst20 then
                       begin
                         trvwCTe.Items.AddChild(Node,'orig='   +OrigToStr(ICMS.orig));
                         trvwCTe.Items.AddChild(Node,'modBC='  +modBCToStr(ICMS.modBC));
                         trvwCTe.Items.AddChild(Node,'pRedBC=' +FloatToStr(ICMS.pRedBC));
                         trvwCTe.Items.AddChild(Node,'vBC='    +FloatToStr(ICMS.vBC));
                         trvwCTe.Items.AddChild(Node,'pICMS='  +FloatToStr(ICMS.pICMS));
                         trvwCTe.Items.AddChild(Node,'vICMS='  +FloatToStr(ICMS.vICMS));
                       end
                      else if CST = cst30 then
                       begin
                         trvwCTe.Items.AddChild(Node,'orig='     +OrigToStr(ICMS.orig));
                         trvwCTe.Items.AddChild(Node,'modBCST='  +modBCSTToStr(ICMS.modBCST));
                         trvwCTe.Items.AddChild(Node,'pMVAST='   +FloatToStr(ICMS.pMVAST));
                         trvwCTe.Items.AddChild(Node,'pRedBCST=' +FloatToStr(ICMS.pRedBCST));
                         trvwCTe.Items.AddChild(Node,'vBCST='    +FloatToStr(ICMS.vBCST));
                         trvwCTe.Items.AddChild(Node,'pICMSST='  +FloatToStr(ICMS.pICMSST));
                         trvwCTe.Items.AddChild(Node,'vICMSST='  +FloatToStr(ICMS.vICMSST));
                       end
                      else if (CST = cst40) or (CST = cst41) or (CST = cst50) then
                       begin
                         trvwCTe.Items.AddChild(Node,'orig='    +OrigToStr(ICMS.orig));
                       end
                      else if CST = cst51 then
                         begin
                         trvwCTe.Items.AddChild(Node,'orig='    +OrigToStr(ICMS.orig));
                         trvwCTe.Items.AddChild(Node,'modBC='   +modBCToStr(ICMS.modBC));
                         trvwCTe.Items.AddChild(Node,'pRedBC='  +FloatToStr(ICMS.pRedBC));
                         trvwCTe.Items.AddChild(Node,'vBC='     +FloatToStr(ICMS.vBC));
                         trvwCTe.Items.AddChild(Node,'pICMS='   +FloatToStr(ICMS.pICMS));
                         trvwCTe.Items.AddChild(Node,'vICMS='   +FloatToStr(ICMS.vICMS));
                       end
                      else if CST = cst60 then
                       begin
                         trvwCTe.Items.AddChild(Node,'orig='    +OrigToStr(ICMS.orig));
                         trvwCTe.Items.AddChild(Node,'vBCST='   +FloatToStr(ICMS.vBCST));
                         trvwCTe.Items.AddChild(Node,'vICMSST=' +FloatToStr(ICMS.vICMSST));
                       end
                      else if CST = cst70 then
                       begin
                         trvwCTe.Items.AddChild(Node,'orig='       +OrigToStr(ICMS.orig));
                         trvwCTe.Items.AddChild(Node,'modBC='      +modBCToStr(ICMS.modBC));
                         trvwCTe.Items.AddChild(Node,'pRedBC='     +FloatToStr(ICMS.pRedBC));
                         trvwCTe.Items.AddChild(Node,'vBC='        +FloatToStr(ICMS.vBC));
                         trvwCTe.Items.AddChild(Node,'pICMS='      +FloatToStr(ICMS.pICMS));
                         trvwCTe.Items.AddChild(Node,'vICMS='      +FloatToStr(ICMS.vICMS));
                         trvwCTe.Items.AddChild(Node,'modBCST='    +modBCSTToStr(ICMS.modBCST));
                         trvwCTe.Items.AddChild(Node,'pMVAST='     +FloatToStr(ICMS.pMVAST));
                         trvwCTe.Items.AddChild(Node,'pRedBCST='   +FloatToStr(ICMS.pRedBCST));
                         trvwCTe.Items.AddChild(Node,'vBCST='      +FloatToStr(ICMS.vBCST));
                         trvwCTe.Items.AddChild(Node,'pICMSST='    +FloatToStr(ICMS.pICMSST));
                         trvwCTe.Items.AddChild(Node,'vICMSST='    +FloatToStr(ICMS.vICMSST));
                       end
                      else if CST = cst90 then
                       begin
                         trvwCTe.Items.AddChild(Node,'orig='       +OrigToStr(ICMS.orig));
                         trvwCTe.Items.AddChild(Node,'modBC='      +modBCToStr(ICMS.modBC));
                         trvwCTe.Items.AddChild(Node,'pRedBC='     +FloatToStr(ICMS.pRedBC));
                         trvwCTe.Items.AddChild(Node,'vBC='        +FloatToStr(ICMS.vBC));
                         trvwCTe.Items.AddChild(Node,'pICMS='      +FloatToStr(ICMS.pICMS));
                         trvwCTe.Items.AddChild(Node,'vICMS='      +FloatToStr(ICMS.vICMS));
                         trvwCTe.Items.AddChild(Node,'modBCST='    +modBCSTToStr(ICMS.modBCST));
                         trvwCTe.Items.AddChild(Node,'pMVAST='     +FloatToStr(ICMS.pMVAST));
                         trvwCTe.Items.AddChild(Node,'pRedBCST='   +FloatToStr(ICMS.pRedBCST));
                         trvwCTe.Items.AddChild(Node,'vBCST='      +FloatToStr(ICMS.vBCST));
                         trvwCTe.Items.AddChild(Node,'pICMSST='    +FloatToStr(ICMS.pICMSST));
                         trvwCTe.Items.AddChild(Node,'vICMSST='    +FloatToStr(ICMS.vICMSST));
                       end;
                    end;

                   if (IPI.vBC > 0) then
                    begin
                      Node := trvwCTe.Items.AddChild(NodePai,'IPI');
                      with IPI do
                       begin
                         trvwCTe.Items.AddChild(Node,'CST='       +CSTIPIToStr(CST));
                         trvwCTe.Items.AddChild(Node,'clEnq='    +clEnq);
                         trvwCTe.Items.AddChild(Node,'CNPJProd=' +CNPJProd);
                         trvwCTe.Items.AddChild(Node,'cSelo='    +cSelo);
                         trvwCTe.Items.AddChild(Node,'qSelo='    +IntToStr(qSelo));
                         trvwCTe.Items.AddChild(Node,'cEnq='     +cEnq);

                         trvwCTe.Items.AddChild(Node,'vBC='    +FloatToStr(vBC));
                         trvwCTe.Items.AddChild(Node,'qUnid='  +FloatToStr(qUnid));
                         trvwCTe.Items.AddChild(Node,'vUnid='  +FloatToStr(vUnid));
                         trvwCTe.Items.AddChild(Node,'pIPI='   +FloatToStr(pIPI));
                         trvwCTe.Items.AddChild(Node,'vIPI='   +FloatToStr(vIPI));
                       end;
                    end;

                   if (II.vBc > 0) then
                    begin
                      Node := trvwCTe.Items.AddChild(NodePai,'II');
                      with II do
                       begin
                         trvwCTe.Items.AddChild(Node,'vBc='      +FloatToStr(vBc));
                         trvwCTe.Items.AddChild(Node,'vDespAdu=' +FloatToStr(vDespAdu));
                         trvwCTe.Items.AddChild(Node,'vII='      +FloatToStr(vII));
                         trvwCTe.Items.AddChild(Node,'vIOF='     +FloatToStr(vIOF));
                       end;
                    end;

                   Node := trvwCTe.Items.AddChild(NodePai,'PIS');
                   with PIS do
                    begin
                      trvwCTe.Items.AddChild(Node,'CST=' +CSTPISToStr(CST));

                      if (CST = pis01) or (CST = pis02) then
                       begin
                         trvwCTe.Items.AddChild(Node,'vBC='  +FloatToStr(PIS.vBC));
                         trvwCTe.Items.AddChild(Node,'pPIS=' +FloatToStr(PIS.pPIS));
                         trvwCTe.Items.AddChild(Node,'vPIS=' +FloatToStr(PIS.vPIS));
                       end
                      else if CST = pis03 then
                       begin
                         trvwCTe.Items.AddChild(Node,'qBCProd='   +FloatToStr(PIS.qBCProd));
                         trvwCTe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(PIS.vAliqProd));
                         trvwCTe.Items.AddChild(Node,'vPIS='      +FloatToStr(PIS.vPIS));
                       end
                      else if CST = pis99 then
                       begin
                         trvwCTe.Items.AddChild(Node,'vBC='       +FloatToStr(PIS.vBC));
                         trvwCTe.Items.AddChild(Node,'pPIS='      +FloatToStr(PIS.pPIS));
                         trvwCTe.Items.AddChild(Node,'qBCProd='   +FloatToStr(PIS.qBCProd));
                         trvwCTe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(PIS.vAliqProd));
                         trvwCTe.Items.AddChild(Node,'vPIS='      +FloatToStr(PIS.vPIS));
                       end;
                    end;

                   if (PISST.vBc>0) then
                    begin
                      Node := trvwCTe.Items.AddChild(NodePai,'PISST');
                      with PISST do
                       begin
                         trvwCTe.Items.AddChild(Node,'vBc='       +FloatToStr(vBc));
                         trvwCTe.Items.AddChild(Node,'pPis='      +FloatToStr(pPis));
                         trvwCTe.Items.AddChild(Node,'qBCProd='   +FloatToStr(qBCProd));
                         trvwCTe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(vAliqProd));
                         trvwCTe.Items.AddChild(Node,'vPIS='      +FloatToStr(vPIS));
                       end;
                      end;

                   Node := trvwCTe.Items.AddChild(NodePai,'COFINS');
                   with COFINS do
                    begin
                      trvwCTe.Items.AddChild(Node,'CST=' +CSTCOFINSToStr(CST));

                      if (CST = cof01) or (CST = cof02)   then
                       begin
                         trvwCTe.Items.AddChild(Node,'vBC='     +FloatToStr(COFINS.vBC));
                         trvwCTe.Items.AddChild(Node,'pCOFINS=' +FloatToStr(COFINS.pCOFINS));
                         trvwCTe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(COFINS.vCOFINS));
                       end
                      else if CST = cof03 then
                       begin
                         trvwCTe.Items.AddChild(Node,'qBCProd='   +FloatToStr(COFINS.qBCProd));
                         trvwCTe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(COFINS.vAliqProd));
                         trvwCTe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(COFINS.vCOFINS));
                       end
                      else if CST = cof99 then
                       begin
                         trvwCTe.Items.AddChild(Node,'vBC='       +FloatToStr(COFINS.vBC));
                         trvwCTe.Items.AddChild(Node,'pCOFINS='   +FloatToStr(COFINS.pCOFINS));
                         trvwCTe.Items.AddChild(Node,'qBCProd='   +FloatToStr(COFINS.qBCProd));
                         trvwCTe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(COFINS.vAliqProd));
                         trvwCTe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(COFINS.vCOFINS));
                       end;
                    end;

                   if (COFINSST.vBC > 0) then
                    begin
                      Node := trvwCTe.Items.AddChild(NodePai,'COFINSST');
                      with COFINSST do
                       begin
                         trvwCTe.Items.AddChild(Node,'vBC='       +FloatToStr(vBC));
                         trvwCTe.Items.AddChild(Node,'pCOFINS='   +FloatToStr(pCOFINS));
                         trvwCTe.Items.AddChild(Node,'qBCProd='   +FloatToStr(qBCProd));
                         trvwCTe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(vAliqProd));
                         trvwCTe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(vCOFINS));
                       end;
                    end;

                   if (ISSQN.vBC > 0) then
                    begin
                     Node := trvwCTe.Items.AddChild(NodePai,'ISSQN');
                     with ISSQN do
                      begin
                        trvwCTe.Items.AddChild(Node,'vBC='       +FloatToStr(vBC));
                        trvwCTe.Items.AddChild(Node,'vAliq='     +FloatToStr(vAliq));
                        trvwCTe.Items.AddChild(Node,'vISSQN='    +FloatToStr(vISSQN));
                        trvwCTe.Items.AddChild(Node,'cMunFG='    +IntToStr(cMunFG));
                        trvwCTe.Items.AddChild(Node,'cListServ=' +IntToStr(cListServ));
                      end;
                    end;
                end;
             end;
          end;

       NodePai := trvwCTe.Items.AddChild(Nota,'Total');
       Node := trvwCTe.Items.AddChild(NodePai,'ICMSTot');
       trvwCTe.Items.AddChild(Node,'vBC='     +FloatToStr(Total.ICMSTot.vBC));
       trvwCTe.Items.AddChild(Node,'vICMS='   +FloatToStr(Total.ICMSTot.vICMS));
       trvwCTe.Items.AddChild(Node,'vBCST='   +FloatToStr(Total.ICMSTot.vBCST));
       trvwCTe.Items.AddChild(Node,'vST='     +FloatToStr(Total.ICMSTot.vST));
       trvwCTe.Items.AddChild(Node,'vProd='   +FloatToStr(Total.ICMSTot.vProd));
       trvwCTe.Items.AddChild(Node,'vFrete='  +FloatToStr(Total.ICMSTot.vFrete));
       trvwCTe.Items.AddChild(Node,'vSeg='    +FloatToStr(Total.ICMSTot.vSeg));
       trvwCTe.Items.AddChild(Node,'vDesc='   +FloatToStr(Total.ICMSTot.vDesc));
       trvwCTe.Items.AddChild(Node,'vII='     +FloatToStr(Total.ICMSTot.vII));
       trvwCTe.Items.AddChild(Node,'vIPI='    +FloatToStr(Total.ICMSTot.vIPI));
       trvwCTe.Items.AddChild(Node,'vPIS='    +FloatToStr(Total.ICMSTot.vPIS));
       trvwCTe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(Total.ICMSTot.vCOFINS));
       trvwCTe.Items.AddChild(Node,'vOutro='  +FloatToStr(Total.ICMSTot.vOutro));
       trvwCTe.Items.AddChild(Node,'vNF='     +FloatToStr(Total.ICMSTot.vNF));

       if Total.ISSQNtot.vServ > 0 then
        begin
          Node := trvwCTe.Items.AddChild(NodePai,'ISSQNtot');
          trvwCTe.Items.AddChild(Node,'vServ='   +FloatToStr(Total.ISSQNtot.vServ));
          trvwCTe.Items.AddChild(Node,'vBC='     +FloatToStr(Total.ISSQNTot.vBC));
          trvwCTe.Items.AddChild(Node,'vISS='    +FloatToStr(Total.ISSQNTot.vISS));
          trvwCTe.Items.AddChild(Node,'vPIS='    +FloatToStr(Total.ISSQNTot.vPIS));
          trvwCTe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(Total.ISSQNTot.vCOFINS));
        end;

       Node := trvwCTe.Items.AddChild(NodePai,'retTrib');
       trvwCTe.Items.AddChild(Node,'vRetPIS='   +FloatToStr(Total.retTrib.vRetPIS));
       trvwCTe.Items.AddChild(Node,'vRetCOFINS='+FloatToStr(Total.retTrib.vRetCOFINS));
       trvwCTe.Items.AddChild(Node,'vRetCSLL='  +FloatToStr(Total.retTrib.vRetCSLL));
       trvwCTe.Items.AddChild(Node,'vBCIRRF='   +FloatToStr(Total.retTrib.vBCIRRF));
       trvwCTe.Items.AddChild(Node,'vIRRF='     +FloatToStr(Total.retTrib.vIRRF));
       trvwCTe.Items.AddChild(Node,'vBCRetPrev='+FloatToStr(Total.retTrib.vBCRetPrev));
       trvwCTe.Items.AddChild(Node,'vRetPrev='  +FloatToStr(Total.retTrib.vRetPrev));

       NodePai := trvwCTe.Items.AddChild(Nota,'Transp');
       Node := trvwCTe.Items.AddChild(NodePai,'Transporta');
       trvwCTe.Items.AddChild(Node,'modFrete=' +modFreteToStr(Transp.modFrete));
       trvwCTe.Items.AddChild(Node,'CNPJCPF='  +Transp.Transporta.CNPJCPF);
       trvwCTe.Items.AddChild(Node,'xNome='    +Transp.Transporta.xNome);
       trvwCTe.Items.AddChild(Node,'IE='       +Transp.Transporta.IE);
       trvwCTe.Items.AddChild(Node,'xEnder='   +Transp.Transporta.xEnder);
       trvwCTe.Items.AddChild(Node,'xMun='     +Transp.Transporta.xMun);
       trvwCTe.Items.AddChild(Node,'UF='       +Transp.Transporta.UF);

       Node := trvwCTe.Items.AddChild(NodePai,'retTransp');
       trvwCTe.Items.AddChild(Node,'vServ='    +FloatToStr(Transp.retTransp.vServ));
       trvwCTe.Items.AddChild(Node,'vBCRet='   +FloatToStr(Transp.retTransp.vBCRet));
       trvwCTe.Items.AddChild(Node,'pICMSRet=' +FloatToStr(Transp.retTransp.pICMSRet));
       trvwCTe.Items.AddChild(Node,'vICMSRet=' +FloatToStr(Transp.retTransp.vICMSRet));
       trvwCTe.Items.AddChild(Node,'CFOP='     +Transp.retTransp.CFOP);
       trvwCTe.Items.AddChild(Node,'cMunFG='   +FloatToStr(Transp.retTransp.cMunFG));

       Node := trvwCTe.Items.AddChild(NodePai,'veicTransp');
       trvwCTe.Items.AddChild(Node,'placa='  +Transp.veicTransp.placa);
       trvwCTe.Items.AddChild(Node,'UF='     +Transp.veicTransp.UF);
       trvwCTe.Items.AddChild(Node,'RNTC='   +Transp.veicTransp.RNTC);

       for I:=0 to Transp.Reboque.Count-1 do
        begin
          Node := trvwCTe.Items.AddChild(NodePai,'Reboque'+IntToStrZero(I+1,3));
          with Transp.Reboque.Items[I] do
           begin
             trvwCTe.Items.AddChild(Node,'placa=' +placa);
             trvwCTe.Items.AddChild(Node,'UF='    +UF);
             trvwCTe.Items.AddChild(Node,'RNTC='  +RNTC);
           end;
        end;

       for I:=0 to Transp.Vol.Count-1 do
        begin
          Node := trvwCTe.Items.AddChild(NodePai,'Volume'+IntToStrZero(I+1,3));
          with Transp.Vol.Items[I] do
           begin
             trvwCTe.Items.AddChild(Node,'qVol='  +IntToStr(qVol));
             trvwCTe.Items.AddChild(Node,'esp='   +esp);
             trvwCTe.Items.AddChild(Node,'marca=' +marca);
             trvwCTe.Items.AddChild(Node,'nVol='  +nVol);
             trvwCTe.Items.AddChild(Node,'pesoL=' +FloatToStr(pesoL));
             trvwCTe.Items.AddChild(Node,'pesoB'  +FloatToStr(pesoB));

             for J:=0 to Lacres.Count-1 do
              begin
                Node := trvwCTe.Items.AddChild(Node,'Lacre'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) );
                trvwCTe.Items.AddChild(Node,'nLacre='+Lacres.Items[J].nLacre);
              end;
           end;
        end;

       NodePai := trvwCTe.Items.AddChild(Nota,'Cobr');
       Node    := trvwCTe.Items.AddChild(NodePai,'Fat');
       trvwCTe.Items.AddChild(Node,'nFat='  +Cobr.Fat.nFat);
       trvwCTe.Items.AddChild(Node,'vOrig=' +FloatToStr(Cobr.Fat.vOrig));
       trvwCTe.Items.AddChild(Node,'vDesc=' +FloatToStr(Cobr.Fat.vDesc));
       trvwCTe.Items.AddChild(Node,'vLiq='  +FloatToStr(Cobr.Fat.vLiq));

       for I:=0 to Cobr.Dup.Count-1 do
        begin
          Node    := trvwCTe.Items.AddChild(NodePai,'Duplicata'+IntToStrZero(I+1,3));
          with Cobr.Dup.Items[I] do
           begin
             trvwCTe.Items.AddChild(Node,'nDup='  +nDup);
             trvwCTe.Items.AddChild(Node,'dVenc=' +DateToStr(dVenc));
             trvwCTe.Items.AddChild(Node,'vDup='  +FloatToStr(vDup));
           end;
        end;

       NodePai := trvwCTe.Items.AddChild(Nota,'InfAdic');
       trvwCTe.Items.AddChild(NodePai,'infCpl='     +InfAdic.infCpl);
       trvwCTe.Items.AddChild(NodePai,'infAdFisco=' +InfAdic.infAdFisco);

       for I:=0 to InfAdic.obsCont.Count-1 do
        begin
          Node := trvwCTe.Items.AddChild(NodePai,'obsCont'+IntToStrZero(I+1,3));
          with InfAdic.obsCont.Items[I] do
           begin
             trvwCTe.Items.AddChild(Node,'xCampo=' +xCampo);
             trvwCTe.Items.AddChild(Node,'xTexto=' +xTexto);
           end;
        end;

         for I:=0 to InfAdic.obsFisco.Count-1 do
          begin
            Node := trvwCTe.Items.AddChild(NodePai,'obsFisco'+IntToStrZero(I+1,3));
            with InfAdic.obsFisco.Items[I] do
             begin
                trvwCTe.Items.AddChild(Node,'xCampo=' +xCampo);
                trvwCTe.Items.AddChild(Node,'xTexto=' +xTexto);
             end;
          end;

         for I:=0 to InfAdic.procRef.Count-1 do
          begin
            Node := trvwCTe.Items.AddChild(NodePai,'procRef'+IntToStrZero(I+1,3));
            with InfAdic.procRef.Items[I] do
             begin
               trvwCTe.Items.AddChild(Node,'nProc='   +nProc);
               trvwCTe.Items.AddChild(Node,'indProc=' +indProcToStr(indProc));
             end;
          end;

         if (exporta.UFembarq <> '') then
          begin
            Node := trvwCTe.Items.AddChild(Nota,'exporta');
            trvwCTe.Items.AddChild(Node,'UFembarq='   +exporta.UFembarq);
            trvwCTe.Items.AddChild(Node,'xLocEmbarq=' +exporta.xLocEmbarq);
          end;

         if (compra.xNEmp <> '') then
          begin
            Node := trvwCTe.Items.AddChild(Nota,'compra');
            trvwCTe.Items.AddChild(Node,'xNEmp=' +compra.xNEmp);
            trvwCTe.Items.AddChild(Node,'xPed='  +compra.xPed);
            trvwCTe.Items.AddChild(Node,'xCont=' +compra.xCont);
          end;
      *)
      end;
     PageControl2.ActivePageIndex := 3;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnValidarXMLClick(Sender: TObject);
begin
 OpenDialog1.Title := 'Selecione o CTe';
 OpenDialog1.DefaultExt := '*-cte.xml';
 OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

 if OpenDialog1.Execute then
  begin
   ACBrCTe1.Conhecimentos.Clear;
   ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
   ACBrCTe1.Conhecimentos.Validar;
   showmessage('Conhecimento de Transporte Eletrônico Valido');
  end;
end;

procedure TfrmDemo_ACBrCTe.btnEditarCompClick(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.qCOMP.Active)then
    dm.qCOMP.Active;
  dm.qCOMP.Params[0].AsInteger := val_genCte;
  dm.qCOMP.Open;
  dm.qCOMP.Edit;

  fCompValor := TfCompValor.Create(Application);
  try
    fCompValor.btnOk.Visible :=False;
    fCompValor.edtCompNome.Text :=  dbGridComp.Columns[0].Field.Value;
    fCompValor.valComp.Text :=  dbGridComp.Columns[1].Field.Value;
    fCompValor.ShowModal;
  finally
    fCompValor.Free;
  end;

end;

procedure TfrmDemo_ACBrCTe.btnExcluirCompClick(Sender: TObject);
var strExclui:string;
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( dbGridQC.Columns[1].Field.Value <> '') then
    begin
      strExclui := 'DELETE FROM CTE_COMP';
      strExclui := strExclui + ' WHERE COD_CTE_COMP = ';
      strExclui := strExclui +  IntToStr(dm.qCOMPCOD_CTE_COMP.AsInteger);

      dm.con.AutoCommit := true;
      dm.con.StartTransaction;

      try
        dm.con.ExecuteDirect(strExclui);
        dm.con.Commit;
        MessageDlg('Componente Excluido com Sucesso.', mtInformation, [mbOK], 0);
        dm.qCOMP.Refresh;
      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;
    end;
  end;

end;

procedure TfrmDemo_ACBrCTe.btnEditarNFClick(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.cdsNFe.Active)then
    dm.cdsNFe.Active;
  dm.cdsNFe.Params[0].AsInteger := val_genCte;
  dm.cdsNFe.Open;
  dm.cdsNFe.Edit;

  fNFe := TfNFe.Create(Application);
  try
    fNFe.btnOk.Visible :=False;
    fNFe.edtNFeChave.Text :=  dbgridNFe.Columns[0].Field.Value;
    if(fNFe.edtNFePin.Text <> '') then
    begin
      fNFe.edtNFePin.Text := dbgridNFe.Columns[1].Field.Value;
    end;
    // if(fNFe.edtNFePin.Text = '') then
    // begin
   //   fNFe.edtNFePin.Text := dbgridNFe.Columns[1].Field.Value;
    // end;
     fNFe.dataNFePrev.Text := dbgridNFe.Columns[2].Field.Value;
     fNFe.ShowModal;
  finally
    fNFe.Free;
  end;

end;

procedure TfrmDemo_ACBrCTe.btnExcluirNFClick(Sender: TObject);
var strExclui:string;
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( dbGridQC.Columns[1].Field.Value <> '') then
    begin
      strExclui := 'DELETE FROM CTE_NFE';
      strExclui := strExclui + ' WHERE COD_CTE_NFE = ';
      strExclui := strExclui +  IntToStr(dm.qNFeCOD_CTE_NFE.AsInteger);

      dm.con.AutoCommit := true;
      dm.con.StartTransaction;

      try
        dm.con.ExecuteDirect(strExclui);
        dm.con.Commit;
        MessageDlg('Remetente da NF-es Excluido com Sucesso.', mtInformation, [mbOK], 0);
        dm.qNFe.Refresh;
      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;
    end;
  end;

end;

procedure TfrmDemo_ACBrCTe.Button15Click(Sender: TObject);
begin
  {
  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if(edtNumCte.Text = '') then
  begin
   MessageDlg('Inclua uma CTe', mtWarning,[mbOK],0);
   exit;
  end;
  if not(dm.qNF.Active)then
  dm.qNF.Active;
  dm.qNF.Params[0].AsInteger := val_genCte;
  dm.qNF.Open;
  dm.qNF.Edit;

  fDocOutros := TfDocOutros.Create(Application);
  try
    fDocOutros.btnEdita.Visible :=False;
    fDocOutros.ShowModal;
  finally
    fDocOutros.Free;
  end;
 }
end;

procedure TfrmDemo_ACBrCTe.btnListarCteClick(Sender: TObject);
begin
  if (dm.cdsCTE.State in [dsEdit, dsInsert]) then
  begin
    MessageDlg('Grave ou Cancele suas modificaçes antes de continuar.', mtInformation, [mbOK], 0);
    exit;
  end;
  modoGravacao := 'EDITAR';
  if(edtCodEmitente.Text = '') then
  begin
   MessageDlg('Inicie um Emitente .', mtInformation, [mbOK], 0);
   PageControl1.ActivePage := TabSheet4;
   exit
  end;

  dm.cdsCTE.Close;
  if not(dm.cdsCTE.Active)then
    dm.cdsCTE.Active;
  dm.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
  dm.cdsCTE.Params[1].AsInteger := 0;
  dm.cdsCTE.Params[2].AsDate := JvDateTimePicker1.Date;
  dm.cdsCTE.Params[3].AsDate := JvDateTimePicker2.Date;
  dm.cdsCTE.Open;
end;

procedure TfrmDemo_ACBrCTe.btnOutrosLimparClick(Sender: TObject);
begin
   combOutrosDocs.Text := '';
   edtOutrosDesc.Text  := '';
   edtOutrosNum.Text   := '';
   dataOutrosEmi.Clear;
   valOutrosVal.Text := '0';


end;

procedure TfrmDemo_ACBrCTe.Button16Click(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if(edtNumCte.Text = '') then
  begin
   MessageDlg('Inclua uma CTe', mtWarning,[mbOK],0);
   exit;
  end;

  if not(dm.cdsMot.Active)then
    dm.cdsMot.Active;
  dm.cdsMot.Params[0].AsInteger := val_genCte;
  dm.cdsMot.Open;

  fMotorista := TfMotorista.Create(Application);
  try
    fMotorista.btnEdita.Visible := False;
    fMotorista.ShowModal;
  finally
    fMotorista.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.Button17Click(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.cdsMot.Active)then
    dm.cdsMot.Active;
  dm.cdsMot.Params[0].AsInteger := val_genCte;
  dm.cdsMot.Open;
  dm.cdsMot.Edit;

  fMotorista := TfMotorista.Create(Application);
  try
    fMotorista.btnOk.Visible :=False;
    fMotorista.edtMotCpf.Text :=  dbgridMot.Columns[0].Field.Value;
    fMotorista.edtMotNome.Text := dbgridMot.Columns[1].Field.Value;
    fMotorista.ShowModal;
  finally
    fMotorista.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.Button18Click(Sender: TObject);
var strExclui:string;
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( dbGridQC.Columns[1].Field.Value <> '') then
    begin
      strExclui := 'DELETE FROM CTE_MOTORISTA ';
      strExclui := strExclui + ' WHERE COD_CTE_MOTORISTA = ';
      strExclui := strExclui +  IntToStr(dm.qMotCOD_CTE_MOTORISTA.AsInteger);

      dm.con.AutoCommit := true;
      dm.con.StartTransaction;

      try
        dm.con.ExecuteDirect(strExclui);
        dm.con.Commit;
        MessageDlg('Motorista Excluido com Sucesso.', mtInformation, [mbOK], 0);
        dm.qMot.Refresh;
      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;
    end;
  end;

end;

procedure TfrmDemo_ACBrCTe.Button19Click(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if(edtNumCte.Text = '') then
  begin
    MessageDlg('Inclua uma CTe', mtWarning,[mbOK],0);
    exit;
  end;

  if not(dm.cdsVeic.Active)then
    dm.cdsVeic.Active;
  dm.cdsVeic.Params[0].AsInteger := val_genCte;
  dm.cdsVeic.Open;

  fVeiculo := TfVeiculo.Create(Application);
  try
    fVeiculo.btnEditar.Visible  := False;
    fVeiculo.ShowModal;
  finally
    fVeiculo.Free;
  end
end;

procedure TfrmDemo_ACBrCTe.btnDuplicarCTeClick(Sender: TObject);
var velha_nCte: Integer;
begin
  btnEditarCte.Click;
  velha_nCte := dm.cdsCTECOD_CTE.AsInteger;;
  modoGravacao := 'DUPLICAR';
  btnDuplicar.Click;  //btnEditarCte.Click; isso estava errado
  btnIncCte.Click;
  btnGravarCTe.Click;
  duplicar(IntToStr(velha_nCte));
end;

procedure TfrmDemo_ACBrCTe.dbValReceberKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then
  begin
    key:= #0;
    SelectNext((Sender as TwinControl),True,True);
    //if(dbValReceber.Field.Value > 0)then
    if (dm.cdsCTEVREC.AsFloat > 0) then
    begin
      dm.cdsCTEVALVBC.AsFloat := dm.cdsCTEVREC.AsFloat;
      if  (dm.cdsCTEVALPICMS.AsFloat > 0) then
        dm.cdsCTEVALVICMS.AsFloat := dm.cdsCTEVREC.AsFloat * (dm.cdsCTEVALPICMS.AsFloat /100);
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.dgGridCTECellClick(Column: TColumn);
begin
  btnPreVisu.Enabled := False;
end;

procedure TfrmDemo_ACBrCTe.dgGridCTEDblClick(Sender: TObject);
begin
  btnPreVisu.Enabled := False;
  btnEditarCte.Click;
end;

procedure TfrmDemo_ACBrCTe.dgGridCTEKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  btnPreVisu.Enabled := False;
end;

procedure TfrmDemo_ACBrCTe.duplicar(velhaCte: String);
var val_gen:integer;
  CDSCloneQC: TClientDataSet;
  CDSClone: TClientDataSet;
  CDSCloneCOMP: TClientDataSet;
  I: Integer;
  prox: Integer;
  vallor : double;
  strEdita : string;

begin
                // tabela CTE_VICULOS
  CDSClone := TClientDataSet.Create(Application);
  try
    CDSClone.Data := dm.cdsVeic.Data;
    while not CDSClone.Eof do
    begin
      dm.cdsVeic.Append;

      dm.cdsVeicCOD_CTE.AsInteger := val_genCte;
      dm.cdsVeicCINT.AsString := cdsClone.FieldByName('CINT').AsString;
      dm.cdsVeicRENAVAM.AsString := cdsClone.FieldByName('RENAVAM').AsString;
      dm.cdsVeicPLACA.AsString := cdsClone.FieldByName('PLACA').AsString;
      dm.cdsVeicTARA.AsInteger := cdsClone.FieldByName('TARA').Value;
      dm.cdsVeicCAPKG.AsInteger := cdsClone.FieldByName('CAPKG').Value;
      dm.cdsVeicCAPM3.AsInteger := cdsClone.FieldByName('CAPM3').Value;
      dm.cdsVeicTPROD.AsString := cdsClone.FieldByName('TPROD').AsString;
      dm.cdsVeicTPCAR.AsString := cdsClone.FieldByName('TPCAR').AsString;
      dm.cdsVeicTPVEIC.AsString := cdsClone.FieldByName('TPVEIC').AsString;
      dm.cdsVeicTPPROP.AsString := cdsClone.FieldByName('TPPROP').AsString;
      dm.cdsVeicUF.AsString := cdsClone.FieldByName('UF').AsString;

      if(dm.cdsVeicCNPJ.AsString <> '')then
      begin
        dm.cdsVeicCNPJ.AsString := cdsClone.FieldByName('CNPJ').AsString;
        dm.cdsVeicRNTRC.AsString := cdsClone.FieldByName('RNTRC').AsString;
        dm.cdsVeicNOME.AsString := cdsClone.FieldByName('NOME').AsString;
        dm.cdsVeicIE.AsString := cdsClone.FieldByName('IE').AsString;
        dm.cdsVeicVTPPROP.AsInteger := cdsClone.FieldByName('VTPPROP').Value;
        dm.cdsVeicVUF.AsString := cdsClone.FieldByName('VUF').AsString;
      end;
      dm.con.AutoCommit := True;
      dm.cdsVeic.ApplyUpdates(0);
      CDSClone.Next;
    end;

    if (dm.cdsVeic.Active)then
      dm.cdsVeic.Close;
    dm.cdsVeic.Params[0].AsInteger := val_genCte;
    dm.cdsVeic.Open;

    CDSClone.Close;
  finally
    CDSClone.Free;
  end;

  dm.con.AutoCommit := False;


  // Tabela CTE_QC

   if (dm.cdsQC.Active)then
     dm.cdsQC.Close;
   dm.cdsQC.Params[0].AsInteger := val_genCte;
   dm.cdsQC.Open;


  CDSCloneQC := TClientDataSet.Create(Application);
  try
    CDSCloneQC.Data := dm.cdsQC.Data;
    while not CDSCloneQC.Eof do
    begin
      dm.cdsQC.Append;
      dm.cdsQCCOD_CTE.AsInteger := val_genCte;
      dm.cdsQCUNID.AsString     := CDSCloneQC.FieldByName('UNID').AsString;
      dm.cdsQCMEDIDA.AsString   := CDSCloneQC.FieldByName('MEDIDA').AsString;
      dm.cdsQCQUANT.AsCurrency  := CDSCloneQC.FieldByName('QUANT').Value;

      dm.con.AutoCommit := True;
      dm.cdsQC.ApplyUpdates(0);
      CDSCloneQC.Next;
    end;

    if (dm.cdsQC.Active)then
      dm.cdsQC.Close;
    dm.cdsQC.Params[0].AsInteger := val_genCte;
    dm.cdsQC.Open;

    CDSCloneQC.Close;
  finally
    CDSCloneQC.Free;
  end;
  dm.con.AutoCommit := False;


  // TABLE CTE_MOTORISTA

  CDSClone := TClientDataSet.Create(Application);
  try
    CDSClone.Data := dm.cdsMot.Data;
    while not CDSClone.Eof do
    begin
      dm.cdsMot.Append;
      dm.cdsMotCOD_CTE.AsInteger :=  val_genCte;
      dm.cdsMotCPF.AsString := cdsClone.FieldByName('CPF').AsString;
      dm.cdsMotNOME.AsString := cdsClone.FieldByName('NOME').AsString;

      dm.con.AutoCommit := True;
      dm.cdsMot.ApplyUpdates(0);
      CDSClone.Next;
    end;

    if (dm.cdsMot.Active)then
      dm.cdsMot.Close;
    dm.cdsMot.Params[0].AsInteger := val_genCte;
    dm.cdsMot.Open;

    CDSClone.Close;
  finally
    CDSClone.Free;
  end;
  dm.con.AutoCommit := False;

  // TABLE CTE_NFE
    //cliente jaba 22/0819
  {
  CDSClone := TClientDataSet.Create(Application);
  try
    CDSClone.Data := dm.cdsNFe.Data;
    while not CDSClone.Eof do
    begin
      dm.cdsNFe.Append;
      dm.cdsNFeCTE_NFE.AsInteger :=  val_genCte;
      dm.cdsNFeCHAVE.AsString := cdsClone.FieldByName('CHAVE').AsString;
      dm.cdsNFePIN.AsInteger := cdsClone.FieldByName('PIN').AsInteger;
      dm.cdsNFeDPREV.AsDateTime := cdsClone.FieldByName('DPREV').AsDateTime;

      dm.con.AutoCommit := True;
      dm.cdsNfe.ApplyUpdates(0);
      CDSClone.Next;
    end;

    if (dm.cdsNfe.Active)then
      dm.cdsNfe.Close;
    dm.cdsNfe.Params[0].AsInteger := val_genCte;
    dm.cdsNfe.Open;

    CDSClone.Close;
  finally
    CDSClone.Free;
  end;
  dm.con.AutoCommit := False;

  }
  // TABLE CTE_COMP 16 01 17

  CDSCloneCOMP := TClientDataSet.Create(Application);
  try
    CDSCloneCOMP.Data := dm.cdsCOMP.Data;
    while not CDSCloneCOMP.Eof do
    begin
      dm.cdsCOMP.Append;
      dm.cdsCOMPCOD_CTE_COMP.AsInteger := val_genCte ;
      dm.cdsCOMPCOMP_NOME.AsString := CDSCloneCOMP.FieldByName('COMP_NOME').AsString;
      dm.cdsCOMPCOMP_VALOR.AsCurrency := CDSCloneCOMP.FieldByName('COMP_VALOR').Value;

      dm.con.AutoCommit := True;

    if (edtNumCte.Text <> '') then
    begin

      FormatSettings.DecimalSeparator := ',';

      FormatSettings.DecimalSeparator := '.';

      strEdita := 'INSERT into CTE_COMP ( COD_CTE, COMP_NOME, COMP_VALOR)';
      strEdita := strEdita + ' VALUES (';
      strEdita := strEdita + IntToStr(val_genCte);
      strEdita := strEdita + ',';
      strEdita := strEdita + QuotedStr(CDSCloneCOMP.FieldByName('COMP_NOME').AsString);
      strEdita := strEdita + ',';
      strEdita := strEdita +  FloatToStr(CDSCloneCOMP.FieldByName('COMP_VALOR').Value)  ; // +  Format('%8.2f', [valComp.Value]);
      strEdita := strEdita + ')';

      dm.con.AutoCommit := true;
      dm.con.StartTransaction;

      try
        dm.con.ExecuteDirect(strEdita);
        dm.con.Commit;
        dm.qCOMP.Refresh;
        vDup := 1;
        frmDemo_ACBrCTe.btnGravarCTe.Click;
        FormatSettings.DecimalSeparator := ',';

      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;


     end;

      CDSCloneCOMP.Next;
    end;

    if (dm.cdsCOMP.Active)then
      dm.cdsCOMP.Close;
    dm.cdsCOMP.Params[0].AsInteger := val_genCte;
    dm.cdsCOMP.Open;

    CDSCloneCOMP.Close;
  finally
    CDSCloneCOMP.Free;
  end;
  dm.con.AutoCommit := False;


 end;


procedure TfrmDemo_ACBrCTe.btnIniciarEmitenteClick(Sender: TObject);
var cnpj , ie : string;
begin
   dm.zEmpresa.Close;
   dm.zEmpresa.SQL.Clear;
   dm.zEmpresa.SQL.Add('Select * From Empresa');
   dm.zEmpresa.SQL.Add('Where RAZAO = ' + QuotedStr(comboEmpresa.Text));
   dm.zEmpresa.Active:=True;
   dm.zEmpresa.Open;

    if copy(dm.zEmpresaCNPJ_CPF.Text,10,4)<>'0000'
    then begin
     CNPJ := dm.zEmpresaCNPJ_CPF.Text;
     IE := dm.zEmpresaIE_RG.Text;
    end
    else begin
     CNPJ := Copy(dm.zEmpresaCNPJ_CPF.Text, 1, 9) +
                        Copy(dm.zEmpresaCNPJ_CPF.Text, 14, 2);
     IE := 'ISENTO';
    end;

   edtCodEmitente.Text := dm.zEmpresaCODIGO.AsString;
   edtEmitCNPJ.Text := dm.zEmpresaCNPJ_CPF.AsString;
   edtEmitIE.Text := dm.zEmpresaIE_RG.AsString;
   edtEmitRazao.Text := dm.zEmpresaRAZAO.AsString;
   edtEmitFantasia.Text := dm.zEmpresaEMPRESA.AsString;
   edtEmitFone.Text := dm.zEmpresaFONE.AsString;
   edtEmitCEP.Text := LimparString(dm.zEmpresaCEP.AsString,'-'); //dm.zEmpresaCEP.AsString; 199
   edtEmitLogradouro.Text := dm.zEmpresaENDERECO.AsString;
   edtEmitNumero.Text := dm.zEmpresaNUMERO.AsString;
   edtEmitComp.Text := dm.zEmpresaLOGRADOURO.AsString;
   edtEmitBairro.Text := dm.zEmpresaBAIRRO.AsString;
   edtEmitCodCidade.Text := LimparString(dm.zEmpresaCD_IBGE.AsString,'-');
   edtEmitCidade.Text := dm.zEmpresaCIDADE.AsString;
   edtEmitUF.Text := dm.zEmpresaUF.AsString;

   label55.Caption := ' Emitente Iniciado' ;
   label58.Caption := edtEmitRazao.Text;
   label59.Caption := edtEmitRazao.Text;

end;

procedure TfrmDemo_ACBrCTe.Button20Click(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.cdsVeic.Active)then
    dm.cdsVeic.Active;
  dm.cdsVeic.Params[0].AsInteger := val_genCte;
  dm.cdsVeic.Open;
  dm.cdsVeic.Edit;

  fVeiculo := TfVeiculo.Create(Application);
  try
    fVeiculo.btnOk.Visible :=False;
    fVeiculo.edtCint.Text        := dbgridVeic.Columns[0].Field.Value;
    fVeiculo.edtVeicRenavam.Text := dbgridVeic.Columns[1].Field.Value;
    fVeiculo.edtVeicPlaca.Text   := dbgridVeic.Columns[2].Field.Value;
    fVeiculo.edtVeicTara.Text    := dbgridVeic.Columns[3].Field.Value;
    fVeiculo.edtVeicCapK.Text    := dbgridVeic.Columns[4].Field.Value;
    fVeiculo.edtVeicCapM.Text    := dbgridVeic.Columns[5].Field.Value;
    fVeiculo.combVeicRod.Text    := dbgridVeic.Columns[6].Field.Value;
    fVeiculo.combVeicCar.Text    := dbgridVeic.Columns[7].Field.Value;
    fVeiculo.combVeicTV.Text     := dbgridVeic.Columns[8].Field.Value;
    fVeiculo.combVeicProp.Text   := dbgridVeic.Columns[9].Field.Value;
    fVeiculo.combVeicUF.Text     := dbgridVeic.Columns[10].Field.Value;

    if(dbgridVeic.Columns[11].Field.Value <> null) then
    begin
      fVeiculo.maskedtVeicCNPJ.Text := dbgridVeic.Columns[11].Field.Value;
      fVeiculo.edtVeicRNTRC.Text    := dbgridVeic.Columns[12].Field.Value;
      fVeiculo.edtVeicRazao.Text    := dbgridVeic.Columns[13].Field.Value;
      fVeiculo.edtVeicIE.Text       := dbgridVeic.Columns[14].Field.Value;
      fVeiculo.comVeicTipPro.Text   := dbgridVeic.Columns[15].Field.Value;
      fVeiculo.combVeicPropUF.Text  := dbgridVeic.Columns[16].Field.Value;
    end;

    if(fVeiculo.maskedtVeicCNPJ.Text <> '') then
    fVeiculo.rgPertence.ItemIndex := 1;

    fVeiculo.ShowModal;
  finally
    fVeiculo.Free;
  end
end;

procedure TfrmDemo_ACBrCTe.Button21Click(Sender: TObject);
var strExclui:string;
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( dbGridQC.Columns[1].Field.Value <> '') then
    begin
      strExclui := 'DELETE FROM CTE_VEICULOS';
      strExclui := strExclui + ' WHERE COD_CTE_VEICULOS = ';
      strExclui := strExclui +  IntToStr(dm.qVeicCOD_CTE_VEICULOS.AsInteger); //IntToStr(dbGridQC.Columns[0].Field.Value) ;//IntToStr(frmDemo_ACBrCTe.cdsQCCOD_CTE_QC.AsInteger);

      dm.con.AutoCommit := true;
      dm.con.StartTransaction;

      try
        dm.con.ExecuteDirect(strExclui);
        dm.con.Commit;
        MessageDlg('Veiculo Excluido com Sucesso.', mtInformation, [mbOK], 0);
        dm.cdsVeic.Refresh;
      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;
    end;
  end;

end;

procedure TfrmDemo_ACBrCTe.Button22Click(Sender: TObject);
begin
  close;
end;

procedure TfrmDemo_ACBrCTe.Button23Click(Sender: TObject);
begin
 {
  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.qNF.Active)then
    dm.qNF.Active;
  dm.qNF.Params[0].AsInteger := val_genCte;
  dm.qNF.Open;
  dm.qNF.Edit;

  fDocOutros := TfDocOutros.Create(Application);
  try
    fDocOutros.btnOk.Visible :=False;

    fDocOutros.edtNFeChave.Text :=  dbgridNF.Columns[1].Field.Value;

    fDocOutros.ShowModal;
  finally
     fDocOutros.Free;
  end;
  }
end;

procedure TfrmDemo_ACBrCTe.btnPreVisuClick(Sender: TObject);
var   vAux : String;
begin
  vAux := edtNumCte.Text;
  ACBrCTe1.Conhecimentos.Clear;
  if (dm.cdsCTENPROT.AsString = '') then
  begin
    GerarCTe(vAux);
    ACBrCTe1.Conhecimentos.Items[0].GravarXML('','');
  end
  else begin
    OpenDialog1.Title := 'Selecione o CTe';
    OpenDialog1.DefaultExt := '*-cte.xml';
    OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
    OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;
  end;

  ACBrCTe1.Conhecimentos.Imprimir;
  ACBrCTe1.Conhecimentos.Clear;
end;

procedure TfrmDemo_ACBrCTe.btnEditarCteClick(Sender: TObject);
begin

    if(dm.cdsCTENPROT.AsString <> '')then
    begin
      //MessageDlg('CTe Ja Enviada. Não Pode ser Editada', mtInformation, [mbOK], 0);
      //exit;
      //cteEnviada := 'S';
    end;

    FormatSettings.DecimalSeparator := '.';
    val_genCte := dm.cdsCTECOD_CTE.AsInteger;
    if ((dm.cdsCTE.Active) and (dm.cdsCTENPROT.AsString = '')) then
    dm.cdsCTE.Edit;

    edtCFOP.Text := dm.cdsCTECTE_CFOP.AsString;
    edtNatOpe.Text := dm.cdsCTECTE_NATOP.AsString;

    edtModelo.Text := dm.cdsCTEMODELO.AsString;
    edtSerieCte.Text := dm.cdsCTECTE_SERIE.AsString;
    edtNumCte.Text := dm.cdsCTECTE_NUMERO.AsString;
    dataGerarCte.date := dm.cdsCTEDHEMI.Value;
    rgModal.ItemIndex := dm.cdsCTEMODAL.AsInteger;

    rgTipoServico.ItemIndex  :=  dm.cdsCTETIPOSERVICO.AsInteger;
    rgTiposCte.ItemIndex :=     dm.cdsCTETIPOCTE.AsInteger;
    rgFormaEmissao.ItemIndex := dm.cdsCTETPOEMISSAO.AsInteger;
    rgForPag.ItemIndex :=       dm.cdsCTEIFORPAG.AsInteger;
    rgTipoDACTe.ItemIndex :=    dm.cdsCTETPIMP.AsInteger;

    edtEnvCodCidade.Text := dm.cdsCTEENV_CODCIDADE.AsString;
    edtEnvCidade.Text :=    dm.cdsCTEENV_CIDADE.AsString;
    edtEnvUF.Text :=        dm.cdsCTEENV_ESTADO.AsString;
    edtIniCodCidade.Text := dm.cdsCTEINI_CODCIDADE.AsString;
    edtIniCidade.Text :=    dm.cdsCTEINI_CIDADE.AsString;
    edtIniUF.Text :=        dm.cdsCTEINI_ESTADO.AsString;
    edtFimCodCidade.Text := dm.cdsCTEFIM_CODCIDADE.AsString;
    edtFimCidade.Text :=    dm.cdsCTEFIM_CIDADE.AsString;
    edtFimUF.Text :=        dm.cdsCTEFIM_ESTADO.AsString;

    // emitente
    comboEmpresa.Text       := dm.cdsCTEE_RSOCIAL.AsString;
    edtCodEmitente.Text     := dm.cdsCTEEMITENTE.AsString;
    edtEmitCNPJ.Text        := dm.cdsCTEE_CNPJCPF.AsString;
    edtEmitIE.Text          := dm.cdsCTEE_IESTADUAL.AsString;
    edtEmitRazao.Text       := dm.cdsCTEE_RSOCIAL.AsString;
    edtEmitFantasia.Text    := dm.cdsCTEE_FANTASIA.AsString;
    edtEmitFone.Text        := dm.cdsCTEE_TELEFONE.AsString;
    edtEmitLogradouro.Text  := dm.cdsCTEE_ENDERECO.AsString;
    edtEmitNumero.Text      := dm.cdsCTEE_NUMERO.AsString;
    edtEmitComp.Text        := dm.cdsCTEE_COMPLEMENTO.AsString;
    edtEmitBairro.Text      := dm.cdsCTEE_BAIRRO.AsString;
    edtEmitCodCidade.Text   := dm.cdsCTEE_CODIGOMUNICIPI.AsString;
    edtEmitCidade.Text      := dm.cdsCTEE_CIDADE.AsString;
    edtEmitCep.Text         := dm.cdsCTEE_CEP.AsString;
    edtEmitUF.Text          := dm.cdsCTEE_ESTADO.AsString;
    // tomador




    if(dm.cdsCTET_CNPJCPF.AsString <> '') then
    begin

      rgTomador.ItemIndex     := dm.cdsCTETOMADORSERVICO.AsInteger;

      edtCNPJTomador.Text      := dm.cdsCTET_CNPJCPF.AsString;
      edtIETomador.Text        := dm.cdsCTET_IESTADUAL.AsString;
      edtRazaoTomador.Text     := dm.cdsCTET_RSOCIAL.AsString;
      edtNomeTomador.Text      := dm.cdsCTET_FANTASIA.AsString;
      edtFoneTomador.Text      := dm.cdsCTET_TELEFONE.AsString;
      edtEndTomador.Text       := dm.cdsCTET_ENDERECO.AsString;
      edtNumTomador.Text       := dm.cdsCTET_NUMERO.AsString;
      edtCompTomador.Text      := dm.cdsCTET_COMPLEMENTO.AsString;
      edtBairroTomador.Text    := dm.cdsCTET_BAIRRO.AsString;
      edtTomadorCodCidade.Text := dm.cdsCTET_CODIGOMUNICIPI.AsString;
      edtTomadorCidade.Text    := dm.cdsCTET_CIDADE.AsString;
      edtCepTomador.Text       := dm.cdsCTET_CEP.AsString;
      edtTomadorUF.Text        := dm.cdsCTET_ESTADO.AsString;


    end;

    // rememtente
    edtRemCNPJ.Text          := dm.cdsCTER_CNPJCPF.AsString;
    edtRemIE.Text            := dm.cdsCTER_IESTADUAL.AsString;
    edtRemRazao.Text         := dm.cdsCTER_RSOCIAL.AsString;
    edtRemNome.Text          := dm.cdsCTER_FANTASIA.AsString;
    edtRemFone.Text          := dm.cdsCTER_TELEFONE.AsString;
    edtRemEnd.Text           := dm.cdsCTER_ENDERECO.AsString;
    edtRemNum.Text           := dm.cdsCTER_NUMERO.AsString;
    edtRemComp.Text          := dm.cdsCTER_COMPLEMENTO.AsString;
    edtRemBairro.Text        := dm.cdsCTER_BAIRRO.AsString;
    edtRemCodCidade.Text     := dm.cdsCTER_CODIGOMUNICIPI.AsString;
    edtRemCidade.Text        := dm.cdsCTER_CIDADE.AsString;
    edtRemCep.Text           := dm.cdsCTER_CEP.AsString;
    edtRemUF.Text            := dm.cdsCTER_ESTADO.AsString;
    // destinatario
    edtDestCNPJ.Text         := dm.cdsCTED_CNPJCPF.AsString;
    edtDestIE.Text           := dm.cdsCTED_IESTADUAL.AsString;
    edtDestRazao.Text        := dm.cdsCTED_RSOCIAL.AsString;
    edtDestNome.Text         := dm.cdsCTED_FANTASIA.AsString;
    edtDestFone.Text         := dm.cdsCTED_TELEFONE.AsString;
    edtDestEnd.Text          := dm.cdsCTED_ENDERECO.AsString;
    edtDestNum.Text          := dm.cdsCTED_NUMERO.AsString;
    edtDestComp.Text         := dm.cdsCTED_COMPLEMENTO.AsString;
    edtDestBairro.Text       := dm.cdsCTED_BAIRRO.AsString;
    edtDestCodCidade.Text    := dm.cdsCTED_CODIGOMUNICIPI.AsString;
    edtDestCidade.Text       := dm.cdsCTED_CIDADE.AsString;
    edtDestCep.Text          := dm.cdsCTED_CEP.AsString;
    edtDestUF.Text           := dm.cdsCTED_ESTADO.AsString;
    // receedor
    if(dm.cdsCTERE_CNPJCPF.AsString <> '') then
    begin
      rgRec.ItemIndex := 0 ;
      edtRecCNPJ.Text          := dm.cdsCTERE_CNPJCPF.AsString;
      edtRecIE.Text            := dm.cdsCTERE_IESTADUAL.AsString;
      edtRecNome.Text          := dm.cdsCTERE_ENDERECO.AsString;
      edtRecRazao.Text         := dm.cdsCTERE_RSOCIAL.AsString;
      edtRecFone.Text          := dm.cdsCTERE_TELEFONE.AsString;
      edtRecEnd.Text           := dm.cdsCTERE_ENDERECO.AsString;
      edtRecNum.Text           := dm.cdsCTERE_NUMERO.AsString;
      edtRecComp.Text          := dm.cdsCTERE_COMPLEMENTO.AsString;
      edtRecBairro.Text        := dm.cdsCTERE_BAIRRO.AsString;
      edtRecCodCidade.Text     := dm.cdsCTERE_CODIGOMUNICIPI.AsString;
      edtRecCidade.Text        := dm.cdsCTERE_CIDADE.AsString;
      edtRecCep.TExt           := dm.cdsCTERE_CEP.AsString;
      edtRecUF.Text            := dm.cdsCTERE_ESTADO.AsString;
    end;

    if(dm.cdsCTEEX_CNPJCPF.AsString <> '') then
    begin
      rgExp.ItemIndex := 0;
      edtExpCNPJ.Text          := dm.cdsCTEEX_CNPJCPF.AsString;
      edtExpIE.Text            := dm.cdsCTEEX_IESTADUAL.AsString;
      edtExpRazao.Text         := dm.cdsCTEEX_RSOCIAL.AsString;
      edtExpNome.Text          := dm.cdsCTEEX_FANTASIA.AsString;
      edtExpFone.Text          := dm.cdsCTEEX_TELEFONE.AsString;
      edtExpEnd.Text           := dm.cdsCTEEX_ENDERECO.AsString;
      edtExpNum.Text           := dm.cdsCTEEX_COMPLEMENTO.AsString;
      edtExpComp.Text          := dm.cdsCTEEX_COMPLEMENTO.AsString;
      edtExpBairro.Text        := dm.cdsCTEEX_BAIRRO.AsString;
      edtExpCodCidade.Text     := dm.cdsCTEEX_CODIGOMUNICIPI.AsString;
      edtExpCidade.Text        := dm.cdsCTEEX_CIDADE.AsString;
      edtExpCep.Text           := dm.cdsCTEEX_CEP.AsString;
      edtExpUF.Text            := dm.cdsCTEEX_ESTADO.AsString;
    end;

    edtCaracAdTrans.Text := dm.cdsCTECARAC_TRANSP.AsString;
    edtCaracAdServ.Text  := dm.cdsCTECARAC_SERV.AsString;
    edtFuncEmi.Text      := dm.cdsCTEFUNC_EMI.AsString;

    rgRetira.ItemIndex   := dm.cdsCTERETIRA.AsInteger;
    memDetRetira.Text    := dm.cdsCTEDET_RETIRA.AsString;

    //dbValTotPrest.Field.Value := dm.cdsCTEVPREST.Value;
    //dbValReceber.Field.Value  := dm.cdsCTEVREC.Value;
    //dbValTotTri.Field.Value   := dm.cdsCTEVALTOTTRI.Value;

    if(dm.cdsCTENPROT.AsString = '')then
    begin
      dbValInfCarga.Field.Value := dm.cdsCTEVALINFCARGA.Value;
    end;


    edtProPred.Text := dm.cdsCTEPROPRED.AsString;
    edtOutCat.Text := dm.cdsCTEOUTCAT.AsString;

    edtRodRNTRC.Text := dm.cdsCTERNTRC.AsString;
    dataRodPrev.date := dm.cdsCTEDATARODPREV.Value;
    rgRodLotacao.ItemIndex := dm.cdsCTERGRODLOTACAO.Value;

    memxObs.Text := dm.cdsCTEOBS_GERAL.Value;

  {  if (dm.qCOMP.Active)then
      dm.qCOMP.Close;
    dm.qCOMP.Params[0].AsInteger := val_genCte;
    dm.qCOMP.Open;
  }
                       // para Clonar  colocar cds da tabela
    if (dm.cdsCOMP.Active)then
      dm.cdsCOMP.Close;
    dm.cdsCOMP.Params[0].AsInteger := val_genCte;
    dm.cdsCOMP.Open;

    if (dm.qQC.Active)then
      dm.qQC.Close;
    dm.qQC.Params[0].AsInteger := val_genCte;
    dm.qQC.Open;
                         // para Clonar  colocar cds da tabela
    if (dm.cdsQC.Active)then
      dm.cdsQC.Close;
    dm.cdsQC.Params[0].AsInteger := val_genCte;
    dm.cdsQC.Open;

    if (dm.cdsNFe.Active)then
      dm.cdsNFe.Close;
    dm.cdsNFe.Params[0].AsInteger := val_genCte;
    dm.cdsNFe.Open;
  {
    if (dm.qSeg.Active)then
      dm.qSeg.Close;
    dm.qSeg.Params[0].AsInteger := val_genCte;
    dm.qSeg.Open;
  }
    if (dm.cdsVeic.Active)then
      dm.cdsVeic.Close;
    dm.cdsVeic.Params[0].AsInteger := val_genCte;
    dm.cdsVeic.Open;

    if (dm.cdsMot.Active)then
      dm.cdsMot.Close;
    dm.cdsMot.Params[0].AsInteger := val_genCte;
    dm.cdsMot.Open;
  {
    if (dm.qNF.Active)then
      dm.qNF.Close;
    dm.qNF.Params[0].AsInteger := val_genCte;
    dm.qNF.Open;
   }
    if (dm.cdsNF.Active)then
      dm.cdsNF.Close;
    dm.cdsNF.Params[0].AsInteger := val_genCte;
    dm.cdsNF.Open;

    // outros
    combOutrosDocs.Text    := dm.cdsCTEOUTPDOC.AsString ;
    dataOutrosEmi.DateTime := dm.cdsCTEOUDEMI.AsDateTime  ;
    edtOutrosNum.Text      := dm.cdsCTEOUNDOC.AsString ;
    edtOutrosDesc.Text     := dm.cdsCTEOUDESCOUTRO.AsString ;
    valOutrosVal.Value     := dm.cdsCTEOUVDOCFISC.Value ;

    // 15/08/19

    edtAntCNPJ.Text  := dm.cdsCTEANT_CNPJ.AsString;
    edtAntIE.Text    := dm.cdsCTEANT_IE.AsString;
    edtAntUF.Text    := dm.cdsCTEANT_UF.AsString;
    edtAntNome.Text  := dm.cdsCTEANT_NOME.AsString;
    edtAntCHCTE.Text := dm.cdsCTEANT_CHCTE.AsString;

    // impostos

    if(dm.cdsCTENPROT.AsString = '')then
    begin
      combCodSitTrib.ItemIndex := dm.cdsCTECOMBCODSITTRIB.Value;
      dbVALPREDBC.Field.Value := dm.cdsCTEVALPREDBC.Value;
      dbVALVBC.Field.Value    := dm.cdsCTEVALVBC.Value;
      dbVALPICMS.Field.Value  := dm.cdsCTEVALPICMS.Value;
      dbVALVICMS.Field.Value  := dm.cdsCTEVALVICMS.Value;
      dbVALVCRED.Field.Value  := dm.cdsCTEVALVCRED.Value;
    end;

    if (dm.cdsCTE.Active)then
      dm.cdsCTE.Close;
    dm.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
    dm.cdsCTE.Params[1].AsInteger := StrToInt(edtNumCte.Text);
    dm.cdsCTE.Open;

    if (modoGravacao = 'EDITAR') then
    begin
      // vai pra primeira ABA
      //PageControl1.ActivePage:=TabSheet2;

      btnGerar.Enabled := True;
      modoGravacao := 'EDITAR';
      FormatSettings.DecimalSeparator := ',';
      if (dm.cdsCTENPROT.AsString = '') then
      begin
        btnGravarCTe.Caption := 'Gravar CTE *';
        btnGravarCte.Font.Style := [fsBold];
        dm.cdsCTE.Edit;
      end;
      edtCFOPBusca.ReadOnly  := False;
      edtCFOP.ReadOnly       := False;
      edtNatOpe.ReadOnly     := False;

      btnPreVisu.Enabled     := True;
     // btnDuplicarCTe.Enabled := True;

    end;

end;

procedure TfrmDemo_ACBrCTe.Button24Click(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if(edtNumCte.Text = '') then
  begin
   MessageDlg('Inclua uma CTe', mtWarning,[mbOK],0);
   exit;
  end;

  if not(dm.qNF.Active)then
  dm.qNF.Active;
  dm.qNF.Params[0].AsInteger := val_genCte;
  dm.qNF.Open;
  dm.qNF.Edit;

  fNF := TfNF.Create(Application);
  try
    fNF.btnEdita.Visible :=False;
    fNF.ShowModal;
  finally
     fNF.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.Button25Click(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.qNF.Active)then
    dm.qNF.Active;
  dm.qNF.Params[0].AsInteger := val_genCte;
  dm.qNF.Open;
  dm.qNF.Edit;

  fNF := TfNF.Create(Application);
  try
    fNF.btnOk.Visible :=False;

    fNF.edtNFserie.Text :=  dbgridNF.Columns[0].Field.Value;
    fNF.edtNFNum.Text :=  dbgridNF.Columns[1].Field.Value;
    fNF.dataNFEmi.Text :=  dbgridNF.Columns[2].Field.Value;
    fNF.edtNFCFOP.Text :=  dbgridNF.Columns[3].Field.Value;
    fNF.comboNFModelo.Text :=  dbgridNF.Columns[4].Field.Value;
    fNF.edtNFRoma.Text :=  dbgridNF.Columns[5].Field.Value;
    fNF.edtNFNumP.Text :=  dbgridNF.Columns[6].Field.Value;
    if(fNF.dataNFPrev.Text <> null) then
    fNF.dataNFPrev.Text :=  dbgridNF.Columns[7].Field.Value;
    fNF.valNFBase.Value := dbgridNF.Columns[8].Field.Value;
    fNF.valNFICMS.Value := dbgridNF.Columns[9].Field.Value;
    fNF.valNFBaseST.Value := dbgridNF.Columns[10].Field.Value;
    fNF.valNFICMSST.Value := dbgridNF.Columns[11].Field.Value;
    fNF.valNFPeso.Value := dbgridNF.Columns[12].Field.Value;
    if(fNF.edtNFPin.Text <> null )then
    fNF.edtNFPin.Text := dbgridNF.Columns[13].Field.Value;
    fNF.valNFValProd.Value := dbgridNF.Columns[14].Field.Value;
    fNF.valNFValor.Value := dbgridNF.Columns[15].Field.Value;


    fNF.ShowModal;
  finally
     fNF.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.Button26Click(Sender: TObject);
var strExclui:string;
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if (dbgridNF.Columns[1].Field.Value <> '') then
    begin
      strExclui := 'DELETE FROM CTE_NF';
      strExclui := strExclui + ' WHERE COD_CTE_NF = ';
      strExclui := strExclui +  IntToStr(dm.qNFCOD_CTE_NF.AsInteger);

      dm.con.AutoCommit := true;
      dm.con.StartTransaction;

      try
        dm.con.ExecuteDirect(strExclui);
        dm.con.Commit;
        MessageDlg('NF Excluido com Sucesso.', mtInformation, [mbOK], 0);
        dm.qNF.Refresh;
      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;
    end;
  end;

end;

procedure TfrmDemo_ACBrCTe.Button27Click(Sender: TObject);
begin
  dm.con.AutoCommit := True;
  cdsSeries.Edit;
  cdsSeries.ApplyUpdates(-1);
  dm.con.AutoCommit := False;
end;

procedure TfrmDemo_ACBrCTe.btnImpPeriodoClick(Sender: TObject);
var   vAux : String;

begin
    if(comboEmpresa.Text <> '')then
  begin
    while not dm.cdsCTE.Eof do
    begin


     ////////////////////////INICIO\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


      FormatSettings.DecimalSeparator := '.';
      val_genCte := dm.cdsCTECOD_CTE.AsInteger;
      if ((dm.cdsCTE.Active) and (dm.cdsCTENPROT.AsString = '')) then
        dm.cdsCTE.Edit;
      edtCFOP.Text := dm.cdsCTECTE_CFOP.AsString;
      edtNatOpe.Text := dm.cdsCTECTE_NATOP.AsString;

      edtModelo.Text := dm.cdsCTEMODELO.AsString;
      edtSerieCte.Text := dm.cdsCTECTE_SERIE.AsString;
      edtNumCte.Text := dm.cdsCTECTE_NUMERO.AsString;
      dataGerarCte.date := dm.cdsCTEDHEMI.Value;
      rgModal.ItemIndex := dm.cdsCTEMODAL.AsInteger;

      rgTipoServico.ItemIndex  :=  dm.cdsCTETIPOSERVICO.AsInteger;
      rgTiposCte.ItemIndex :=     dm.cdsCTETIPOCTE.AsInteger;
      rgFormaEmissao.ItemIndex := dm.cdsCTETPOEMISSAO.AsInteger;
      rgForPag.ItemIndex :=       dm.cdsCTEIFORPAG.AsInteger;
      rgTipoDACTe.ItemIndex :=    dm.cdsCTETPIMP.AsInteger;

      edtEnvCodCidade.Text := dm.cdsCTEENV_CODCIDADE.AsString;
      edtEnvCidade.Text :=    dm.cdsCTEENV_CIDADE.AsString;
      edtEnvUF.Text :=        dm.cdsCTEENV_ESTADO.AsString;
      edtIniCodCidade.Text := dm.cdsCTEINI_CODCIDADE.AsString;
      edtIniCidade.Text :=    dm.cdsCTEINI_CIDADE.AsString;
      edtIniUF.Text :=        dm.cdsCTEINI_ESTADO.AsString;
      edtFimCodCidade.Text := dm.cdsCTEFIM_CODCIDADE.AsString;
      edtFimCidade.Text :=    dm.cdsCTEFIM_CIDADE.AsString;
      edtFimUF.Text :=        dm.cdsCTEFIM_ESTADO.AsString;

      // emitente
      comboEmpresa.Text       := dm.cdsCTEE_RSOCIAL.AsString;
      edtCodEmitente.Text     := dm.cdsCTEEMITENTE.AsString;
      edtEmitCNPJ.Text        := dm.cdsCTEE_CNPJCPF.AsString;
      edtEmitIE.Text          := dm.cdsCTEE_IESTADUAL.AsString;
      edtEmitRazao.Text       := dm.cdsCTEE_RSOCIAL.AsString;
      edtEmitFantasia.Text    := dm.cdsCTEE_FANTASIA.AsString;
      edtEmitFone.Text        := dm.cdsCTEE_TELEFONE.AsString;
      edtEmitLogradouro.Text  := dm.cdsCTEE_ENDERECO.AsString;
      edtEmitNumero.Text      := dm.cdsCTEE_NUMERO.AsString;
      edtEmitComp.Text        := dm.cdsCTEE_COMPLEMENTO.AsString;
      edtEmitBairro.Text      := dm.cdsCTEE_BAIRRO.AsString;
      edtEmitCodCidade.Text   := dm.cdsCTEE_CODIGOMUNICIPI.AsString;
      edtEmitCidade.Text      := dm.cdsCTEE_CIDADE.AsString;
      edtEmitCep.Text         := dm.cdsCTEE_CEP.AsString;
      edtEmitUF.Text          := dm.cdsCTEE_ESTADO.AsString;

      // tomador
      if(dm.cdsCTET_CNPJCPF.AsString <> '') then
      begin

        rgTomador.ItemIndex      := dm.cdsCTETOMADORSERVICO.AsInteger;

        edtCNPJTomador.Text      := dm.cdsCTET_CNPJCPF.AsString;
        edtIETomador.Text        := dm.cdsCTET_IESTADUAL.AsString;
        edtRazaoTomador.Text     := dm.cdsCTET_RSOCIAL.AsString;
        edtNomeTomador.Text      := dm.cdsCTET_FANTASIA.AsString;
        edtFoneTomador.Text      := dm.cdsCTET_TELEFONE.AsString;
        edtEndTomador.Text       := dm.cdsCTET_ENDERECO.AsString;
        edtNumTomador.Text       := dm.cdsCTET_NUMERO.AsString;
        edtCompTomador.Text      := dm.cdsCTET_COMPLEMENTO.AsString;
        edtBairroTomador.Text    := dm.cdsCTET_BAIRRO.AsString;
        edtTomadorCodCidade.Text := dm.cdsCTET_CODIGOMUNICIPI.AsString;
        edtTomadorCidade.Text    := dm.cdsCTET_CIDADE.AsString;
        edtCepTomador.Text       := dm.cdsCTET_CEP.AsString;
        edtTomadorUF.Text        := dm.cdsCTET_ESTADO.AsString;
      end;

      // rememtente
      edtRemCNPJ.Text          := dm.cdsCTER_CNPJCPF.AsString;
      edtRemIE.Text            := dm.cdsCTER_IESTADUAL.AsString;
      edtRemRazao.Text         := dm.cdsCTER_RSOCIAL.AsString;
      edtRemNome.Text          := dm.cdsCTER_FANTASIA.AsString;
      edtRemFone.Text          := dm.cdsCTER_TELEFONE.AsString;
      edtRemEnd.Text           := dm.cdsCTER_ENDERECO.AsString;
      edtRemNum.Text           := dm.cdsCTER_NUMERO.AsString;
      edtRemComp.Text          := dm.cdsCTER_COMPLEMENTO.AsString;
      edtRemBairro.Text        := dm.cdsCTER_BAIRRO.AsString;
      edtRemCodCidade.Text     := dm.cdsCTER_CODIGOMUNICIPI.AsString;
      edtRemCidade.Text        := dm.cdsCTER_CIDADE.AsString;
      edtRemCep.Text           := dm.cdsCTER_CEP.AsString;
      edtRemUF.Text            := dm.cdsCTER_ESTADO.AsString;
      // destinatario
      edtDestCNPJ.Text         := dm.cdsCTED_CNPJCPF.AsString;
      edtDestIE.Text           := dm.cdsCTED_IESTADUAL.AsString;
      edtDestRazao.Text        := dm.cdsCTED_RSOCIAL.AsString;
      edtDestNome.Text         := dm.cdsCTED_FANTASIA.AsString;
      edtDestFone.Text         := dm.cdsCTED_TELEFONE.AsString;
      edtDestEnd.Text          := dm.cdsCTED_ENDERECO.AsString;
      edtDestNum.Text          := dm.cdsCTED_NUMERO.AsString;
      edtDestComp.Text         := dm.cdsCTED_COMPLEMENTO.AsString;
      edtDestBairro.Text       := dm.cdsCTED_BAIRRO.AsString;
      edtDestCodCidade.Text    := dm.cdsCTED_CODIGOMUNICIPI.AsString;
      edtDestCidade.Text       := dm.cdsCTED_CIDADE.AsString;
      edtDestCep.Text          := dm.cdsCTED_CEP.AsString;
      edtDestUF.Text           := dm.cdsCTED_ESTADO.AsString;
      // receedor
      if(dm.cdsCTERE_CNPJCPF.AsString <> '') then
      begin
        rgRec.ItemIndex := 0 ;
        edtRecCNPJ.Text          := dm.cdsCTERE_CNPJCPF.AsString;
        edtRecIE.Text            := dm.cdsCTERE_IESTADUAL.AsString;
        edtRecNome.Text          := dm.cdsCTERE_ENDERECO.AsString;
        edtRecRazao.Text         := dm.cdsCTERE_RSOCIAL.AsString;
        edtRecFone.Text          := dm.cdsCTERE_TELEFONE.AsString;
        edtRecEnd.Text           := dm.cdsCTERE_ENDERECO.AsString;
        edtRecNum.Text           := dm.cdsCTERE_NUMERO.AsString;
        edtRecComp.Text          := dm.cdsCTERE_COMPLEMENTO.AsString;
        edtRecBairro.Text        := dm.cdsCTERE_BAIRRO.AsString;
        edtRecCodCidade.Text     := dm.cdsCTERE_CODIGOMUNICIPI.AsString;
        edtRecCidade.Text        := dm.cdsCTERE_CIDADE.AsString;
        edtRecCep.TExt           := dm.cdsCTERE_CEP.AsString;
        edtRecUF.Text            := dm.cdsCTERE_ESTADO.AsString;
      end;

      if(dm.cdsCTEEX_CNPJCPF.AsString <> '') then
      begin
        rgExp.ItemIndex := 0;
        edtExpCNPJ.Text          := dm.cdsCTEEX_CNPJCPF.AsString;
        edtExpIE.Text            := dm.cdsCTEEX_IESTADUAL.AsString;
        edtExpRazao.Text         := dm.cdsCTEEX_RSOCIAL.AsString;
        edtExpNome.Text          := dm.cdsCTEEX_FANTASIA.AsString;
        edtExpFone.Text          := dm.cdsCTEEX_TELEFONE.AsString;
        edtExpEnd.Text           := dm.cdsCTEEX_ENDERECO.AsString;
        edtExpNum.Text           := dm.cdsCTEEX_COMPLEMENTO.AsString;
        edtExpComp.Text          := dm.cdsCTEEX_COMPLEMENTO.AsString;
        edtExpBairro.Text        := dm.cdsCTEEX_BAIRRO.AsString;
        edtExpCodCidade.Text     := dm.cdsCTEEX_CODIGOMUNICIPI.AsString;
        edtExpCidade.Text        := dm.cdsCTEEX_CIDADE.AsString;
        edtExpCep.Text           := dm.cdsCTEEX_CEP.AsString;
        edtExpUF.Text            := dm.cdsCTEEX_ESTADO.AsString;
      end;

      edtCaracAdTrans.Text := dm.cdsCTECARAC_TRANSP.AsString;
      edtCaracAdServ.Text  := dm.cdsCTECARAC_SERV.AsString;
      edtFuncEmi.Text      := dm.cdsCTEFUNC_EMI.AsString;

      rgRetira.ItemIndex   := dm.cdsCTERETIRA.AsInteger;
      memDetRetira.Text    := dm.cdsCTEDET_RETIRA.AsString;

      //dbValTotPrest.Field.Value := dm.cdsCTEVPREST.Value;
      //dbValReceber.Field.Value  := dm.cdsCTEVREC.Value;
      //dbValTotTri.Field.Value   := dm.cdsCTEVALTOTTRI.Value;

      combCodSitTrib.ItemIndex := dm.cdsCTECOMBCODSITTRIB.Value;

      //   dbValInfCarga.Field.Value := dm.cdsCTEVALINFCARGA.Value;
      edtProPred.Text := dm.cdsCTEPROPRED.AsString;
      edtOutCat.Text := dm.cdsCTEOUTCAT.AsString;

      edtRodRNTRC.Text := dm.cdsCTERNTRC.AsString;
      dataRodPrev.date := dm.cdsCTEDATARODPREV.Value;
      rgRodLotacao.ItemIndex := dm.cdsCTERGRODLOTACAO.Value;

      memxObs.Text := dm.cdsCTEOBS_GERAL.Value;

      if (dm.qCOMP.Active)then
        dm.qCOMP.Close;
      dm.qCOMP.Params[0].AsInteger := val_genCte;
      dm.qCOMP.Open;
                         // para Clonar  colocar cds da tabela
      if (dm.cdsCOMP.Active)then
        dm.cdsCOMP.Close;
      dm.cdsCOMP.Params[0].AsInteger := val_genCte;
      dm.cdsCOMP.Open;

      if (dm.qQC.Active)then
        dm.qQC.Close;
      dm.qQC.Params[0].AsInteger := val_genCte;
      dm.qQC.Open;

      if (dm.cdsQC.Active)then
        dm.cdsQC.Close;
      dm.cdsQC.Params[0].AsInteger := val_genCte;
      dm.cdsQC.Open;

      if (dm.cdsNFe.Active)then
        dm.cdsNFe.Close;
      dm.cdsNFe.Params[0].AsInteger := val_genCte;
      dm.cdsNFe.Open;

      if (dm.qSeg.Active)then
        dm.qSeg.Close;
      dm.qSeg.Params[0].AsInteger := val_genCte;
      dm.qSeg.Open;

      if (dm.cdsVeic.Active)then
        dm.cdsVeic.Close;
      dm.cdsVeic.Params[0].AsInteger := val_genCte;
      dm.cdsVeic.Open;

      if (dm.cdsMot.Active)then
        dm.cdsMot.Close;
      dm.cdsMot.Params[0].AsInteger := val_genCte;
      dm.cdsMot.Open;

      if (dm.qNF.Active)then
        dm.qNF.Close;
      dm.qNF.Params[0].AsInteger := val_genCte;
      dm.qNF.Open;

      if (dm.cdsNF.Active)then
        dm.cdsNF.Close;
      dm.cdsNF.Params[0].AsInteger := val_genCte;
      dm.cdsNF.Open;

      // outros
      combOutrosDocs.Text    := dm.cdsCTEOUTPDOC.AsString ;
      dataOutrosEmi.DateTime := dm.cdsCTEOUDEMI.AsDateTime  ;
      edtOutrosNum.Text      := dm.cdsCTEOUNDOC.AsString ;
      edtOutrosDesc.Text     := dm.cdsCTEOUDESCOUTRO.AsString ;
      valOutrosVal.Value     := dm.cdsCTEOUVDOCFISC.Value ;

      //, OUTPDOC                VARCHAR( 2 )
      //, OUDESCOUTRO            VARCHAR( 100 )
      //, OUNDOC                 VARCHAR( 20 )
      //, OUDEMI                 TIMESTAMP
      //, OUVDOCFISC             DOUBLE PRECISION

      {
      if (dm.cdsCTE.Active)then
        dm.cdsCTE.Close;
      dm.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
      dm.cdsCTE.Params[1].AsInteger := StrToInt(edtNumCte.Text);
      dm.cdsCTE.Open;
      }
      {
      if (modoGravacao = 'EDITAR') then
      begin
        // vai pra primeira ABA
        PageControl1.ActivePage:=TabSheet2;
        btnGerar.Enabled := True;
        modoGravacao := 'EDITAR';
        FormatSettings.DecimalSeparator := ',';
        if (dm.cdsCTENPROT.AsString = '') then
        begin
          btnGravarCTe.Caption := 'Gravar CTE *';
          btnGravarCte.Font.Style := [fsBold];
          dm.cdsCTE.Edit;
        end;
        edtCFOPBusca.ReadOnly := False;
        edtCFOP.ReadOnly := False;
        edtNatOpe.ReadOnly := False;

        btnPreVisu.Enabled := True;
      end;

      }


      //////////////////////////FIM\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

      // edtNumCte.Text := dm.cdsCTECTE_NUMERO.AsString;
      vAux := edtNumCte.Text;
      // edtCFOP.Text := dm.cdsCTECTE_CFOP.AsString;
      // edtSerieCte.Text := dm.cdsCTECTE_SERIE.AsString;

      // edtEnvCodCidade.Text := dm.cdsCTEENV_CODCIDADE.AsString;
      // edtIniCodCidade.Text := dm.cdsCTEINI_CODCIDADE.AsString;
      // edtFimCodCidade.Text := dm.cdsCTEFIM_CODCIDADE.AsString;

      // Edit1.Text := dm.cdsCTECTE_NUMERO.AsString; //IntToStr(dm.cdsCTECTE_NUMERO.AsInteger);
      // vAux := dm.cdsCTECTE_NUMERO.AsString; //Edit1.Text ; //edtNumCte.Text;

      ACBrCTe1.Conhecimentos.Clear;
      if (dm.cdsCTENPROT.AsString = '') then
      begin
        GerarCTe(vAux);
        ACBrCTe1.Conhecimentos.Items[0].GravarXML('','');
      end
      else begin
        OpenDialog1.Title := 'Selecione o CTe';
        OpenDialog1.DefaultExt := '*-cte.xml';
        OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
        OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;
      end;

      ACBrCTe1.Conhecimentos.Imprimir;
      ACBrCTe1.Conhecimentos.Clear;

      dm.cdsCTE.Next;

    end;

  end;

end;

procedure TfrmDemo_ACBrCTe.btnInluirNFClick(Sender: TObject);

begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if(edtNumCte.Text = '') then
  begin
   MessageDlg('Inclua uma CTe', mtWarning,[mbOK],0);
   exit;
  end;
  if not(dm.qNFe.Active)then
  dm.qNFe.Active;
  dm.qNFe.Params[0].AsInteger := val_genCte;
  dm.qNFe.Open;
  dm.qNFe.Edit;

  fNFe := TfNFe.Create(Application);
  try
    fNFe.btnEdita.Visible :=False;
    fNFe.ShowModal;
  finally
    fNFe.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.Button31Click(Sender: TObject);
var
  i, j, k, n  : integer;
  Nota, Node, NodePai, NodeItem: TTreeNode;
  NFeRTXT: TNFeRTXT;
begin
  dm.cdsCli.Open;
  dm.cdsCli.Close;
  Edit1.Text  := '';
  Edit2.Text  := '';
  Edit3.Text  := '';
  Edit4.Text  := '';
  Edit5.Text  := '';
  Edit6.Text  := '';
  Edit7.Text  := '';
  Edit8.Text  := '';
  Edit9.Text  := '';
  Edit10.Text := '';
  Edit11.Text := '';
  Edit12.Text := '';
  Edit13.Text := '';
  Edit14.Text := '';
  trvwNFe.Items.Clear;
  OpenDialog1.FileName  :=  '';
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Arquivos TXT (*.TXT)|*.TXT|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    //tenta TXT
    ACBrNFe1.NotasFiscais.Add;
    NFeRTXT := TNFeRTXT.Create(ACBrNFe1.NotasFiscais.Items[0].NFe);
    NFeRTXT.CarregarArquivo(OpenDialog1.FileName);
    if NFeRTXT.LerTxt then
       NFeRTXT.Free
    else
    begin
       NFeRTXT.Free;
       //tenta XML
       ACBrNFe1.NotasFiscais.Clear;
       try
          ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
       except
          ShowMessage('Arquivo NFe Inválido');
          exit;
       end;
    end;

    trvwNFe.Items.Clear;

    for n:=0 to ACBrNFe1.NotasFiscais.Count-1 do
    begin
    with ACBrNFe1.NotasFiscais.Items[n].NFe do
     begin

       Nota := trvwNFe.Items.Add(nil,infNFe.ID);
       {
       Node := trvwNFe.Items.AddChild(Nota,'Emit');
       trvwNFe.Items.AddChild(Node,'CNPJCPF= ' +Emit.CNPJCPF);
       trvwNFe.Items.AddChild(Node,'IE='       +Emit.IE);
       trvwNFe.Items.AddChild(Node,'xNome='    +Emit.xNome);
       trvwNFe.Items.AddChild(Node,'xFant='    +Emit.xFant );
       trvwNFe.Items.AddChild(Node,'IEST='     +Emit.IEST);
       trvwNFe.Items.AddChild(Node,'IM='       +Emit.IM);
       trvwNFe.Items.AddChild(Node,'CNAE='     +Emit.CNAE);
       trvwNFe.Items.AddChild(Node,'CRT='      +CRTToStr(Emit.CRT));

       Node := trvwNFe.Items.AddChild(Node,'EnderEmit');
       trvwNFe.Items.AddChild(Node,'Fone='    +Emit.EnderEmit.fone);
       trvwNFe.Items.AddChild(Node,'CEP='     +IntToStr(Emit.EnderEmit.CEP));
       trvwNFe.Items.AddChild(Node,'xLgr='    +Emit.EnderEmit.xLgr);
       trvwNFe.Items.AddChild(Node,'nro='     +Emit.EnderEmit.nro);
       trvwNFe.Items.AddChild(Node,'xCpl='    +Emit.EnderEmit.xCpl);
       trvwNFe.Items.AddChild(Node,'xBairro=' +Emit.EnderEmit.xBairro);
       trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Emit.EnderEmit.cMun));
       trvwNFe.Items.AddChild(Node,'xMun='    +Emit.EnderEmit.xMun);
       trvwNFe.Items.AddChild(Node,'UF'       +Emit.EnderEmit.UF);
       trvwNFe.Items.AddChild(Node,'cPais='   +IntToStr(Emit.EnderEmit.cPais));
       trvwNFe.Items.AddChild(Node,'xPais='   +Emit.EnderEmit.xPais);

       if Avulsa.CNPJ  <> '' then
        begin
          Node := trvwNFe.Items.AddChild(Nota,'Avulsa');
          trvwNFe.Items.AddChild(Node,'CNPJ='    +Avulsa.CNPJ);
          trvwNFe.Items.AddChild(Node,'xOrgao='  +Avulsa.xOrgao);
          trvwNFe.Items.AddChild(Node,'matr='    +Avulsa.matr );
          trvwNFe.Items.AddChild(Node,'xAgente=' +Avulsa.xAgente);
          trvwNFe.Items.AddChild(Node,'fone='    +Avulsa.fone);
          trvwNFe.Items.AddChild(Node,'UF='      +Avulsa.UF);
          trvwNFe.Items.AddChild(Node,'nDAR='    +Avulsa.nDAR);
          trvwNFe.Items.AddChild(Node,'dEmi='    +DateToStr(Avulsa.dEmi));
          trvwNFe.Items.AddChild(Node,'vDAR='    +FloatToStr(Avulsa.vDAR));
          trvwNFe.Items.AddChild(Node,'repEmi='  +Avulsa.repEmi);
          trvwNFe.Items.AddChild(Node,'dPag='    +DateToStr(Avulsa.dPag));
        end;
       }
       Node := trvwNFe.Items.AddChild(Nota,'Dest');
       trvwNFe.Items.AddChild(Node,'CNPJCPF= ' +Dest.CNPJCPF);
       trvwNFe.Items.AddChild(Node,'IE='       +Dest.IE);
       trvwNFe.Items.AddChild(Node,'ISUF='     +Dest.ISUF);
       trvwNFe.Items.AddChild(Node,'xNome='    +Dest.xNome);
       trvwNFe.Items.AddChild(Node,'email='    +Dest.Email);

       Node := trvwNFe.Items.AddChild(Node,'EnderDest');
       trvwNFe.Items.AddChild(Node,'Fone='    +Dest.EnderDest.Fone);
       trvwNFe.Items.AddChild(Node,'CEP='     +IntToStr(Dest.EnderDest.CEP));
       trvwNFe.Items.AddChild(Node,'xLgr='    +Dest.EnderDest.xLgr);
       trvwNFe.Items.AddChild(Node,'nro='     +Dest.EnderDest.nro);
       trvwNFe.Items.AddChild(Node,'xCpl='    +Dest.EnderDest.xCpl);
       trvwNFe.Items.AddChild(Node,'xBairro=' +Dest.EnderDest.xBairro);
       trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Dest.EnderDest.cMun));
       trvwNFe.Items.AddChild(Node,'xMun='    +Dest.EnderDest.xMun);
       trvwNFe.Items.AddChild(Node,'UF='      +Dest.EnderDest.UF );
       trvwNFe.Items.AddChild(Node,'cPais='   +IntToStr(Dest.EnderDest.cPais));
       trvwNFe.Items.AddChild(Node,'xPais='   +Dest.EnderDest.xPais);

       Edit1.Text := Copy(Dest.CNPJCPF,1,2) + '.' + Copy(Dest.CNPJCPF,3,3) + '.' + Copy(Dest.CNPJCPF,6,3) + '/' + Copy(Dest.CNPJCPF,9,4) + '-' + Copy(Dest.CNPJCPF,13,2);

       Edit2.Text := Dest.xNome ;
       Edit3.Text := Dest.IE ;


       Edit4.Text  := Dest.EnderDest.xLgr;
       Edit5.Text  := Dest.EnderDest.xCpl;
       Edit6.Text  := Dest.EnderDest.xMun ;
       Edit7.Text  := Dest.EnderDest.UF ;
       Edit8.Text  := Dest.EnderDest.xBairro ;
       Edit9.Text  := IntToStr(Dest.EnderDest.CEP) ;
       Edit10.Text := copy(Dest.EnderDest.Fone,0,2) ;

     // copy(dm.zEmpresaCNPJ_CPF.Text,10,4)

       Edit11.Text := copy(Dest.EnderDest.Fone,3,8) ;
       Edit12.Text := Dest.EnderDest.nro ;
       Edit13.Text := IntToStr(Dest.EnderDest.cMun);
       if(Dest.EnderDest.cPais = 1058)then
       Edit14.Text := 'Brasil';

       // NUMERO, CD_IBGE, PAIS

     end;
     end;

    btnVerCadastro.Click;

  end;
end;

procedure TfrmDemo_ACBrCTe.Button32Click(Sender: TObject);
begin
  fBusca := TfBusca.Create(Application);
  try
   // fBusca.btnEditar.Visible  := False;
    fBusca.ShowModal;
  finally
    fBusca.Free;
  end

end;

procedure TfrmDemo_ACBrCTe.btnVerCadastroClick(Sender: TObject);
var nome : string;
begin
  if(Edit1.Text <> '') then
  begin
    dm.cdsCli.Open;
    if not dm.cdsCli.Locate('CNPJ', Edit1.Text,[loCaseInsensitive, loPartialKey]) then
    begin
	   ShowMessage('Empresa Não Cadastrada, CNPJ Não Encontrado!') ;
     btnCliCa.Click;
    end;
  end;

  if(Edit1.Text <> '') then
  begin
    dm.cdsCli.Open;
    if not dm.cdsCli.Locate('CNPJ', Edit1.Text,[loCaseInsensitive, loPartialKey]) then
      ShowMessage('Feito Cadastrado da Empresa!')
    else
    ShowMessage('Empresa já Cadastrada!')

  end;


end;



procedure TfrmDemo_ACBrCTe.btnCliCaClick(Sender: TObject);
//var strInsere , strEndereco : string;
 //   generetor,genEnd : integer;
begin

  if (Edit1.Text <> '') then
  begin

    if dm.cdsGen.Active then
      dm.cdsGen.Close;
    dm.cdsGen.CommandText := 'SELECT CAST(GEN_ID(GEN_CLI, 1) AS INTEGER) AS CODIGO FROM RDB$DATABASE';
    dm.cdsGen.Open;
    generetor := dm.cdsGen.Fields[0].AsInteger;
    genCLI := generetor;
    dm.cdsGen.Close;


    strInsere := 'INSERT INTO CLIENTES (CODCLIENTE, NOMECLIENTE, RAZAOSOCIAL, TIPOFIRMA ' +
                   ', CNPJ, INSCESTADUAL, SEGMENTO, REGIAO, DATACADASTRO  , CODUSUARIO, STATUS ' +
                   ') VALUES ( ';

    strInsere := strInsere +   IntToStr(generetor);
    strInsere := strInsere + ', ' + QuotedStr(Edit2.Text);
    strInsere := strInsere + ', ' + QuotedStr(Edit2.Text);
    strInsere := strInsere + ', ' + IntToStr(1);
    strInsere := strInsere + ', ' + QuotedStr(Edit1.Text);
    strInsere := strInsere + ', ' + QuotedStr(Edit3.Text);
    strInsere := strInsere + ', ' + IntToStr(1);
    strInsere := strInsere + ', ' + IntToStr(1);
    strInsere := strInsere + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now));
    strInsere := strInsere + ', ' + IntToStr(1);
    strInsere := strInsere + ', ' + IntToStr(1);
    strInsere := strInsere + ')';


    dm.con.AutoCommit := True;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strInsere);
      dm.con.Commit;
     // MessageDlg('Cliente Gravado com Sucesso.', mtInformation, [mbOK], 0);
     // dm.cdsCli.Open;
     // dm.cdsCli.Refresh;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;

  btnCliEnd.Click;

end;

procedure TfrmDemo_ACBrCTe.btnCliEndClick(Sender: TObject);

begin

  if (Edit1.Text <> '') then
  begin
    if dm.cdsGen.Active then
      dm.cdsGen.Close;
    dm.cdsGen.CommandText := 'SELECT CAST(GEN_ID(GEN_CLI_END, 1) AS INTEGER) AS CODIGO FROM RDB$DATABASE';
    dm.cdsGen.Open;
    genEnd := dm.cdsGen.Fields[0].AsInteger;
    dm.cdsGen.Close;


    strEndereco := 'INSERT INTO ENDERECOCLIENTE (CODENDERECO , CODCLIENTE, LOGRADOURO , BAIRRO, COMPLEMENTO '+
                  ', CIDADE , UF , CEP , TELEFONE , TIPOEND , DDD , NUMERO, CD_IBGE, PAIS  ' +
                  ') VALUES ( ';

    strEndereco := strEndereco +   IntToStr(genEnd);
    strEndereco := strEndereco + ', ' + IntToStr(genCLI);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit4.Text);
   // strInsere := strInsere + ', ' + IntToStr(1);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit8.Text);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit5.Text);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit6.Text);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit7.Text);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit9.Text);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit11.Text);

    strEndereco := strEndereco + ', ' + IntToStr(0);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit10.Text);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit12.Text);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit13.Text);
    strEndereco := strEndereco + ', ' + QuotedStr(Edit14.Text);
    strEndereco := strEndereco + ')';

   dm.con.AutoCommit := true;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEndereco);
      dm.con.Commit;
     // MessageDlg('Endereço Cliente Gravado com Sucesso.', mtInformation, [mbOK], 0);
     // dm.cdsCliEnd.Refresh;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end

end;


procedure TfrmDemo_ACBrCTe.Button3Click(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if(edtNumCte.Text = '') then
  begin
   MessageDlg('Inclua uma CTe', mtWarning,[mbOK],0);
   exit;
  end;

  if not(dm.qSeg.Active)then
    dm.qSeg.Active;
  dm.qSeg.Params[0].AsInteger := val_genCte;
  dm.qSeg.Open;
  dm.qSeg.Edit;

  fSeguro := TfSeguro.Create(Application);
  try
    fSeguro.ShowModal;
  finally
    fSeguro.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.Button4Click(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.qSeg.Active)then
    dm.qSeg.Active;
  dm.qSeg.Params[0].AsInteger := val_genCte;
  dm.qSeg.Open;
  dm.qSeg.Edit;

  fSeguro := TfSeguro.Create(Application);
  try
    fSeguro.btnOk.Visible := False;
    fSeguro.combSeguro.Text :=  dbgridSeg.Columns[0].Field.Value;
    fSeguro.edtSegNome.Text := dbgridSeg.Columns[1].Field.Value;
    fSeguro.edtSeguNumApo.Text := dbgridSeg.Columns[2].Field.Value;
    fSeguro.edtSegNumAver.Text := dbgridSeg.Columns[3].Field.Value;
    fSeguro.valSegValor.Text := dbgridSeg.Columns[4].Field.Value;
    fSeguro.ShowModal;
  finally
    fSeguro.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.Button5Click(Sender: TObject);
var strExclui:string;
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( dbGridQC.Columns[1].Field.Value <> '') then
    begin
      strExclui := 'DELETE FROM CTE_SEGURO ';
      strExclui := strExclui + ' WHERE COD_CTE_SEGURO = ';
      strExclui := strExclui +  IntToStr(dm.qSegCOD_CTE_SEGURO.AsInteger);

      dm.con.AutoCommit := true;
      dm.con.StartTransaction;

      try
        dm.con.ExecuteDirect(strExclui);
        dm.con.Commit;
        MessageDlg('Informação do Seguro Excluido com Sucesso.', mtInformation, [mbOK], 0);
        dm.qSeg.Refresh;
      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;
    end;
  end;

end;

procedure TfrmDemo_ACBrCTe.btnIncluirCompClick(Sender: TObject);
begin

  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not(dm.qCOMP.Active)then
    dm.qCOMP.Active;
  dm.qCOMP.Params[0].AsInteger := val_genCte;
  dm.qCOMP.Open;
  dm.qCOMP.Edit;

  fCompValor := TfCompValor.Create(Application);
  try
    fCompValor.btnEdita.Visible := False;
    fCompValor.ShowModal;
  finally
    fCompValor.Free;
  end;



end;

procedure TfrmDemo_ACBrCTe.btnAtualizarBDClick(Sender: TObject);
begin

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE_VEICULOS ADD VALINFCARGA DOUBLE PRECISION ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE_VEICULOS ADD CNPJ VARCHAR(20)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE_VEICULOS ADD RNTRC VARCHAR(8)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE_VEICULOS ADD NOME VARCHAR(60)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE_VEICULOS ADD IE VARCHAR(20)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE_VEICULOS ADD VTPPROP INTEGER');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE_VEICULOS ADD VUF VARCHAR(2)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

    try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD STATUS VARCHAR(60)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD VALINFCARGA DOUBLE PRECISION ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD PROPRED VARCHAR(60) ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;
  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD OUTCAT VARCHAR(30) ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RNTRC VARCHAR(8) ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;
  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD DATARODPREV DATE ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RGRODLOTACAO INTEGER ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;
  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD OBS_GERAL VARCHAR(300) ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;
  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD NPROT VARCHAR(20) ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD CHCTE VARCHAR(50)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE SERIES ADD SERIE_CTE VARCHAR(3)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RECEBEDOR    INTEGER');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;


  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_RG    VARCHAR( 20 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_CNPJCPF  VARCHAR( 20 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_IESTADUAL VARCHAR( 20 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;


  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_RSOCIAL VARCHAR( 60 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_FANTASIA  VARCHAR( 60 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;


  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_TELEFONE             VARCHAR( 15 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;


  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_ENDERECO             VARCHAR( 60 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;


  try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_NUMERO               VARCHAR( 10 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_COMPLEMENTO          VARCHAR( 60 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_BAIRRO               VARCHAR( 60 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_CODIGOMUNICIPI       VARCHAR( 10 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_CIDADE  VARCHAR(60)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_CEP VARCHAR(10)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_ESTADO   CHAR(2)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_CODIGOPAIS           INTEGER');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;


   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD RE_PAIS                 VARCHAR( 60 )');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;

  end;
                        // abra outros
   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD OutpDoc  VARCHAR(2)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD OudescOutro  VARCHAR(100)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD OuNDoc  VARCHAR(20)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD OuDEmi  TIMESTAMP ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD OuVDocFisc DOUBLE PRECISION ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;
               // doc anterior

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD ANT_CNPJ  VARCHAR(20)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD ANT_IE  VARCHAR(20)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD ANT_UF  VARCHAR(2)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;


   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD ANT_NOME  VARCHAR(60)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD ANT_CHCTE  VARCHAR(60)');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   // impostos

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD IN_IMPOSTOS INTEGER ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD valpRedBC DOUBLE PRECISION ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD valvBC DOUBLE PRECISION ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;
   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD valpICMS DOUBLE PRECISION ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD valvICMS DOUBLE PRECISION ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD valvCred DOUBLE PRECISION ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD NPROTCANCEL  VARCHAR(30) ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;

   try
    dm.con.ExecuteDirect('ALTER TABLE CTE ADD STATUS_CTE  VARCHAR(30) ');
    dm.con.Commit;
  except
    on E : Exception do
    begin
      dm.con.Rollback;
    end;
  end;







end;

procedure TfrmDemo_ACBrCTe.btnCancCTeClick(Sender: TObject);
var
 vAux : String;
 iLote: Integer;
begin
 OpenDialog1.Title := 'Selecione o CTe a ser Cancelado';
 OpenDialog1.DefaultExt := '*-cte.xml';
 OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

 if OpenDialog1.Execute then
  begin
   ACBrCTe1.Conhecimentos.Clear;
   ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
   if not(InputQuery('Cancelamento do CTe:', 'Justificativa', vAux))
    then exit;

   ACBrCTe1.EventoCTe.Evento.Clear;

   with ACBrCTe1.EventoCTe.Evento.Add do
    begin
     infEvento.nSeqEvento      := 1; // Para o Evento de Cancelamento: nSeqEvento sempre = 1
     infEvento.chCTe           := Copy(ACBrCTe1.Conhecimentos.Items[0].CTe.infCTe.Id, 4, 44);
     infEvento.CNPJ            := edtEmitCNPJ.Text;
     infEvento.dhEvento        := now;
     infEvento.tpEvento        := teCancelamento;
     infEvento.detEvento.xJust := trim(vAux);
     infEvento.detEvento.nProt := ACBrCTe1.Conhecimentos.Items[0].CTe.procCTe.nProt;
    end;

   iLote := 1; // Numero do Lote do Evento
   ACBrCTe1.EnviarEvento(iLote);

   MemoResp.Lines.Text :=  UTF8Encode(ACBrCTe1.WebServices.EnvEvento.RetWS);
   memoRespWS.Lines.Text :=  UTF8Encode(ACBrCTe1.WebServices.EnvEvento.RetWS);
  // LoadXML(MemoResp, WBResposta);
   ShowMessage(IntToStr(ACBrCTe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat));
   ShowMessage(ACBrCTe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);
  end;
end;

procedure TfrmDemo_ACBrCTe.btnCancelarClick(Sender: TObject);
var
 vAux ,strEdita : String;
begin
  OpenDialog1.Title := 'Selecione o CTe';
  OpenDialog1.DefaultExt := '*-cte.xml';
  OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';

  if OpenDialog1.Execute then
  begin
    ACBrCTe1.Conhecimentos.Clear;
    ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
    if not(InputQuery('WebServices Cancelamento', 'Justificativa', vAux))
    then exit;

    ACBrCTe1.Cancelamento(vAux);
    MemoResp.Lines.Text   :=  UTF8Encode(ACBrCTe1.WebServices.Retorno.RetWS);
    MemoResp.Lines.Text   := UTF8Encode(ACBrCTe1.WebServices.Retorno.RetWS);
    memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Retorno.RetWS);

    MemoDados.Lines.Add('');
    MemoDados.Lines.Add('Cancelar CTestatu');
    MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrCTe1.WebServices.Retorno.cStat));
    MemoDados.Lines.Add('xMotivo: '+ ACBrCTe1.WebServices.Retorno.xMotivo);
    MemoDados.Lines.Add('xMsg: '+ ACBrCTe1.WebServices.Retorno.Msg);
    MemoDados.Lines.Add('Protocolo: '+ ACBrCTe1.WebServices.Retorno.Protocolo);

    if(dm.cdsCTESTATUS_CTE.AsString = '')then
    begin
      dm.con.AutoCommit := True;

      strEdita := 'UPDATE CTE SET NPROTCANCEL = ';
      strEdita := strEdita + QuotedStr(ACBrCTe1.WebServices.Retorno.Protocolo);
      strEdita := strEdita + ', STATUS_CTE = ';
      strEdita := strEdita + QuotedStr('Cancelado');

      strEdita := strEdita + ' WHERE CTE_NUMERO = ';
      strEdita := strEdita + (edtNumCte.Text);

      dm.con.StartTransaction;

      try
        dm.con.ExecuteDirect(strEdita);
        dm.con.Commit;

        MessageDlg('Protocolo Gravada com Sucesso.', mtInformation, [mbOK], 0);
        FormatSettings.DecimalSeparator := ',';
        dm.con.AutoCommit := False;

        if (dm.cdsCTE.Active)then
          dm.cdsCTE.Close;
        dm.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
        dm.cdsCTE.Params[1].AsInteger := StrToInt(edtNumCte.Text);
        dm.cdsCTE.Open;


      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;

    end;


    //memoRespWS.Lines.Text :=  UTF8Encode(ACBrCTe1.WebServices.Cancelamento.RetWS);
    //LoadXML(MemoResp, WBResposta);
    //ShowMessage(IntToStr(ACBrCTe1.WebServices.Cancelamento.cStat));
    //ShowMessage(ACBrCTe1.WebServices.Cancelamento.Protocolo);
  end;

end;

procedure TfrmDemo_ACBrCTe.btnCCClick(Sender: TObject);
var Chave , sCNPJ ,sGrupo , sCampo, sValor : string;
     nSequencia , iNumItem : integer ;
begin

  // PULEI   , existe ??
  

 ACBrCTe1.EventoCTe.Evento.Clear;

 chave      := edtChave.Text ;
 nSequencia := StrToInt(edtSequencia.Text);
 sGrupo     := edtGrupoAlterado.Text;
 sCampo     := edtsCampo.Text;
 sValor     := edtsValor.Text;
 iNumItem   := StrToInt(edtiNumItem.Text);
 sCNPJ      := edtEmitCNPJ.Text;

 with ACBrCTe1.EventoCTe.Evento.Add do
  begin
   infevento.chCTe      := Chave;
   infEvento.CNPJ       := sCNPJ;
   infEvento.dhEvento   := now;
   infEvento.tpEvento   := teCCe;
   infEvento.nSeqEvento := nSequencia;

   infEvento.detEvento.xCondUso := '';

   ACBrCTe1.EventoCTe.Evento.Items[0].InfEvento.detEvento.infCorrecao.Clear;

   with ACBrCTe1.EventoCTe.Evento.Items[0].InfEvento.detEvento.infCorrecao.Add do
    begin
     grupoAlterado   := sGrupo;
     campoAlterado   := sCampo;
     valorAlterado   := sValor;
     nroItemAlterado := iNumItem;
    end;
  end;
  ACBrCTe1.EnviarEvento(1);

 // ACBrCTe1.EventoCTe.GerarXML;
  //ACBrCTe1.EnviarEvento(iNumItem);
 // ACBrCTe1.EventoCTe.Items[0].GravarXML('','');

 // ShowMessage('Arquivo gerado em: '+ACBrCTe1.Conhecimentos.Items[0].NomeArq);
 // MemoDados.Lines.Add('Arquivo gerado em: '+ACBrCTe1.Conhecimentos.Items[0].NomeArq);
//  MemoResp.Lines.LoadFromFile(ACBrCTe1.Conhecimentos.Items[0].NomeArq);

end;

procedure TfrmDemo_ACBrCTe.btnImprimirClick(Sender: TObject);
begin
// AQUI
 OpenDialog1.Title := 'Selecione o CTe';
 OpenDialog1.DefaultExt := '*-cte.xml';
 OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

 if OpenDialog1.Execute then
  begin
   ACBrCTe1.Conhecimentos.Clear;
   ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
   ACBrCTe1.Conhecimentos.Imprimir;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnGerarPDFClick(Sender: TObject);
begin
 OpenDialog1.Title := 'Selecione o CTe';
 OpenDialog1.DefaultExt := '*-cte.xml';
 OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

 if OpenDialog1.Execute
  then begin
   ACBrCTe1.Conhecimentos.Clear;
   ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
   ACBrCTe1.Conhecimentos.ImprimirPDF;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnEnviarEmailClick(Sender: TObject);
var
 Para : String;
 CC   : Tstrings;
begin
 if not(InputQuery('Enviar Email', 'Email de destino', Para))
  then exit;

 OpenDialog1.Title := 'Selecione o CTe';
 OpenDialog1.DefaultExt := '*-cte.xml';
 OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

 if OpenDialog1.Execute then
  begin
   ACBrCTe1.Conhecimentos.Clear;
   ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
   CC:=TstringList.Create;
   CC.Add('email_1@provedor.com'); //especifique um email válido
   CC.Add('email_2@provedor.com.br'); //especifique um email válido

   ACBrCTe1.Conhecimentos.Items[0].EnviarEmail(Para
                                             , edtEmailAssunto.Text
                                             , mmEmailMsg.Lines
                                             , False //Enviar PDF junto
                                             , nil //Lista com emails que serão enviado cópias - TStrings
                                             , nil // Lista de anexos - TStrings
                                              );
   CC.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnImprimirEventoClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o CTe';
  OpenDialog1.DefaultExt := '*-cte.xml';
  OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

  ACBrCTe1.Conhecimentos.Clear;
  if OpenDialog1.Execute then
  begin
    ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione o Evento';
  OpenDialog1.DefaultExt := '*-procEventoCTe.xml';
  OpenDialog1.Filter := 'Arquivos Evento (*-procEventoCTe.xml)|*-procEventoCTe.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrCTe1.EventoCTe.Evento.Clear;
    ACBrCTe1.EventoCTe.LerXML(OpenDialog1.FileName);
    ACBrCTe1.ImprimirEvento;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnGerarPDFEventoClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o CTe';
  OpenDialog1.DefaultExt := '*-cte.xml';
  OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

  ACBrCTe1.Conhecimentos.Clear;
  if OpenDialog1.Execute then
  begin
    ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione o Evento';
  OpenDialog1.DefaultExt := '*-procEventoCTe.xml';
  OpenDialog1.Filter := 'Arquivos Evento (*-procEventoCTe.xml)|*-procEventoCTe.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrCTe1.EventoCTe.Evento.Clear;
    ACBrCTe1.EventoCTe.LerXML(OpenDialog1.FileName);
    ACBrCTe1.ImprimirEventoPDF;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnEnviarEventoEmailClick(Sender: TObject);
var
 Para : String;
 CC, Evento: Tstrings;
begin
  if not(InputQuery('Enviar Email', 'Email de destino', Para)) then
    exit;

  OpenDialog1.Title := 'Selecione o CTe';
  OpenDialog1.DefaultExt := '*-cte.xml';
  OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrCTe1.Conhecimentos.Clear;
    ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione o Evento';
  OpenDialog1.DefaultExt := '*-procEventoCTe.xml';
  OpenDialog1.Filter := 'Arquivos Evento (*-procEventoCTe.xml)|*-procEventoCTe.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;
  if OpenDialog1.Execute then
  begin
    Evento := TStringList.Create;
    Evento.Clear;
    Evento.Add(OpenDialog1.FileName);
    ACBrCTe1.EventoCTe.Evento.Clear;
    ACBrCTe1.EventoCTe.LerXML(OpenDialog1.FileName);
    CC:=TstringList.Create;
    CC.Add('andrefmoraes@gmail.com'); //especifique um email válido
    CC.Add('anfm@zipmail.com.br');    //especifique um email válido
    (*
    ACBrCTe1.EnviarEmailEvento(edtSmtpHost.Text
                             , edtSmtpPort.Text
                             , edtSmtpUser.Text
                             , edtSmtpPass.Text
                             , edtSmtpUser.Text
                             , Para
                             , edtEmailAssunto.Text
                             , mmEmailMsg.Lines
                             , cbEmailSSL.Checked // SSL - Conexão Segura
                             , True //Enviar PDF junto
                             , CC //Lista com emails que serão enviado cópias - TStrings
                             , Evento // Lista de anexos - TStrings
                             , False  //Pede confirmação de leitura do email
                             , False  //Aguarda Envio do Email(não usa thread)
                             , 'ACBrCTe' // Nome do Rementente
                             , cbEmailSSL.Checked ); // Auto TLS
    *)                         
    CC.Free;
    Evento.Free;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnExcluirClick(Sender: TObject);
var strExclui:string;
begin
  if (dm.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( dbGridQC.Columns[1].Field.Value <> '') then
    begin
      strExclui := 'DELETE FROM CTE_QC';
      strExclui := strExclui + ' WHERE COD_CTE_QC = ';
      strExclui := strExclui +  IntToStr(dm.qQCCOD_CTE_QC.AsInteger); //IntToStr(dbGridQC.Columns[0].Field.Value) ;//IntToStr(frmDemo_ACBrCTe.cdsQCCOD_CTE_QC.AsInteger);

      dm.con.AutoCommit := true;
      dm.con.StartTransaction;

      try
        dm.con.ExecuteDirect(strExclui);
        dm.con.Commit;
        MessageDlg('Quantidade de Carga Excluida com Sucesso.', mtInformation, [mbOK], 0);
        dm.qQC.Refresh;
      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnImprimirInutClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o ProcInutCTe';
  OpenDialog1.DefaultExt := '*-ProcInutCTe.xml';
  OpenDialog1.Filter := 'Arquivos ProcInutCTe (*-ProcInutCTe.xml)|*-ProcInutCTe.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrCTe1.InutCTe.LerXML(OpenDialog1.FileName);
    ACBrCTe1.ImprimirInutilizacao;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnGerarPDFInutClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o ProcInutCTe';
  OpenDialog1.DefaultExt := '*-ProcInutCTe.xml';
  OpenDialog1.Filter := 'Arquivos ProcInutCTe (*-ProcInutCTe.xml)|*-ProcInutCTe.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrCTe1.InutCTe.LerXML(OpenDialog1.FileName);
    ACBrCTe1.ImprimirInutilizacaoPDF;
  end;
end;

procedure TfrmDemo_ACBrCTe.btnGravarCTeClick(Sender: TObject);
var sql_retorno, strEdita: String;
begin
  if(edtCFOP.Text = '') then
  begin
    MessageDlg('Preecha o CFOP.', mtInformation, [mbOK], 0);
    edtCFOP.SetFocus;
    exit;
  end;

  if ((modoGravacao = 'INCLUIR') or (modoGravacao = 'DUPLICAR')) then
  begin
    strEdita := 'UPDATE SERIES SET ULTIMO_NUMERO = ';
    strEdita := strEdita + QuotedStr(edtNumCte.Text);
    strEdita := strEdita + ' WHERE MODELO = ';
    strEdita := strEdita + QuotedStr('CT');
    strEdita := strEdita + ' and CODSERIE = ';
    strEdita := strEdita + QuotedStr(edtCodEmitente.Text);
    sql_retorno := GravarCTe;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;
    try
      dm.con.ExecuteDirect(sql_retorno);
      dm.con.ExecuteDirect(strEdita);
      dm.con.Commit;
      if(vDup <> 1 ) then
      MessageDlg('CTe Gravada com sucesso.', mtInformation, [mbOK], 0);

      FormatSettings.DecimalSeparator := ',';
      modoGravacao := 'EDITAR';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;

  end
  else begin
    if (dm.cdsCTENPROT.AsString <> '') then
    begin
      MessageDlg('CTe Ja Enviada. Não Pode ser Editada', mtInformation, [mbOK], 0);
      exit;
    end;
    EditarA; //
    EditarB; // Aba Dados Complementares
    EditarC;
    EditarD; // Aba serviços e Impostos
    EditarE;
    EditarF; // aba outros docs
    EditarG;
    EditarEX;
    EditarT;
    EditarR;
    EditarREC;
    EditarRE;
    EditarDE;
  end;

  btnGravarCTe.Caption := 'Gravar CTE';
  btnGravarCte.Font.Style := [];
  btnPreVisu.Enabled := True;

  if (dm.cdsCTE.Active)then
    dm.cdsCTE.Close;
  dm.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
  dm.cdsCTE.Params[1].AsInteger := StrToInt(edtNumCte.Text);
  dm.cdsCTE.Open;

  vDup := 1;
  if((fQuantCarga.fcarga <> 1)and(fCompValor.fvalor <> 1)and (fNFe.fnfe <> 1) and(vDup <> 1) )then
  MessageDlg('CTe Gravada.', mtInformation, [mbOK], 0);

 //m.cdsCte.Cancel;

end;

procedure TfrmDemo_ACBrCTe.DadosBasicos;
begin
 if(dm.cdsEmpresa.State <> dsInsert)then
 begin
   dm.cdsEmpresa.Open;
   edtEmitCNPJ.Text := dm.cdsEmpresaCNPJ_CPF.AsString;
   edtEmitIE.Text := dm.cdsEmpresaIE_RG.AsString;
   edtEmitRazao.Text := dm.cdsEmpresaRAZAO.AsString;
   edtEmitFantasia.Text := dm.cdsEmpresaEMPRESA.AsString;
   edtEmitFone.Text := dm.cdsEmpresaFONE.AsString;
   edtEmitCEP.Text := dm.cdsEmpresaCEP.AsString;
   edtEmitLogradouro.Text := dm.cdsEmpresaENDERECO.AsString;
   edtEmitNumero.Text := dm.cdsEmpresaNUMERO.AsString;
   edtEmitComp.Text := dm.cdsEmpresaLOGRADOURO.AsString;
   edtEmitBairro.Text := dm.cdsEmpresaBAIRRO.AsString;
   edtEmitCodCidade.Text := LimparString(dm.cdsEmpresaCD_IBGE.AsString,'-');
   edtEmitCidade.Text := dm.cdsEmpresaCIDADE.AsString;
   edtEmitUF.Text := dm.cdsEmpresaUF.AsString;

   edtSmtpHost.Text      := dm.cdsEmpresaSMTP.AsString;
   edtSmtpPort.Text      := dm.cdsEmpresaPORTA.AsString;
   edtSmtpUser.Text      := dm.cdsEmpresaE_MAIL.AsString;
   edtSmtpPass.Text      := dm.cdsEmpresaSENHA.AsString;
   edtEmailAssunto.Text  := dm.cdsEmpresaDIVERSOS1.AsString;
   cbEmailSSL.Checked    := cbEmailSSL.Checked;

   dm.cdsEmpresa.Close;
 end;
end;
procedure TfrmDemo_ACBrCTe.edtDestBuscaChange(Sender: TObject);
begin
  if(edtDestBusca.Text = '') then
  begin
     MessageDlg('Escolha um Destinatario', mtWarning, [mbOK], 0);
     exit;
  end;

  if not(dm.cdsCliEnd.Active) Then
  begin
    dm.cdsCliEnd.Active := True;
    dm.cdsCliEnd.Locate(' CODCLIENTE', edtDestBusca.Text, [loPartialKey]);
    edtDestCodCidade.Text := LimparString(dm.cdsCliEndCD_IBGE.AsString,'-');
    edtDestCidade.Text := dm.cdsCliEndCIDADE.AsString;
    edtDestUF.Text := dm.cdsCliEndUF.AsString;
    edtDestNome.Text := dm.cdsCliEndNOMECLIENTE.AsString;
    edtDestRazao.Text := dm.cdsCliEndRAZAOSOCIAL.AsString;
    edtDestCNPJ.Text := dm.cdsCliEndCNPJ.AsString;
    edtDestIE.Text := dm.cdsCliEndINSCESTADUAL.AsString;
    edtDestFone.Text := dm.cdsCliEndDDD.AsString + '-' + dm.cdsCliEndTELEFONE.AsString;
    edtDestEnd.Text := dm.cdsCliEndLOGRADOURO.AsString;
    edtDestNum.Text := dm.cdsCliEndNUMERO.AsString;
    edtDestCidade.Text := dm.cdsCliEndCIDADE.AsString;
    edtDestBairro.Text := dm.cdsCliEndBAIRRO.AsString;
    edtDestCep.TExt := dm.cdsCliEndCEP.AsString;
    edtDestUF.Text := dm.cdsCliEndUF.AsString;
    dm.cdsCliEnd.Close;
  end;

end;

procedure TfrmDemo_ACBrCTe.edtRecBuscaChange(Sender: TObject);
begin
  // AQUI
  if(edtRecBusca.Text = '') then
  begin
     MessageDlg('Escolha um Recebedor', mtWarning, [mbOK], 0);
     exit;
  end;
  if not(dm.cdsCliEnd.Active) Then
  begin
    dm.cdsCliEnd.Active := True;
    dm.cdsCliEnd.Locate(' CODCLIENTE', edtRecBusca.Text, [loPartialKey]);
    edtRecCodCidade.Text := LimparString(dm.cdsCliEndCD_IBGE.AsString,'-');
    edtRecCidade.Text := dm.cdsCliEndCIDADE.AsString;
    edtRecUF.Text := dm.cdsCliEndUF.AsString;
    edtRecNome.Text := dm.cdsCliEndNOMECLIENTE.AsString;
    edtRecRazao.Text := dm.cdsCliEndRAZAOSOCIAL.AsString;
    edtRecCNPJ.Text := dm.cdsCliEndCNPJ.AsString;
    edtRecIE.Text := dm.cdsCliEndINSCESTADUAL.AsString;
    edtRecFone.Text := dm.cdsCliEndDDD.AsString + '-' + dm.cdsCliEndTELEFONE.AsString;
    edtRecEnd.Text := dm.cdsCliEndLOGRADOURO.AsString;
    edtRecNum.Text := dm.cdsCliEndNUMERO.AsString;
    edtRecCidade.Text := dm.cdsCliEndCIDADE.AsString;
    edtRecBairro.Text := dm.cdsCliEndBAIRRO.AsString;
    edtRecCep.TExt := dm.cdsCliEndCEP.AsString;
    edtRecUF.Text := dm.cdsCliEndUF.AsString;
    dm.cdsCliEnd.Close;
  end;
end;

procedure TfrmDemo_ACBrCTe.edtRemBuscaChange(Sender: TObject);
begin
  if(edtRemBusca.Text = '') then
  begin
     MessageDlg('Escolha um Remetente', mtWarning, [mbOK], 0);
     exit;
  end;
  if not(dm.cdsCliEnd.Active) Then
  begin
    dm.cdsCliEnd.Active := True;
    dm.cdsCliEnd.Locate('CODCLIENTE', trim(edtRemBusca.Text), [loPartialKey]);
    edtRemCodCidade.Text := LimparString(dm.cdsCliEndCD_IBGE.AsString,'-');
    edtRemCidade.Text := dm.cdsCliEndCIDADE.AsString;
    edtRemUF.Text := dm.cdsCliEndUF.AsString;
    edtRemNome.Text := dm.cdsCliEndNOMECLIENTE.AsString;
    edtRemRazao.Text := dm.cdsCliEndRAZAOSOCIAL.AsString;
    edtRemCNPJ.Text := dm.cdsCliEndCNPJ.AsString;
    edtRemIE.Text := dm.cdsCliEndINSCESTADUAL.AsString;
    edtRemFone.Text := dm.cdsCliEndDDD.AsString + '-' + dm.cdsCliEndTELEFONE.AsString;
    edtRemEnd.Text := dm.cdsCliEndLOGRADOURO.AsString;
    edtRemNum.Text := dm.cdsCliEndNUMERO.AsString;
    edtRemCidade.Text := dm.cdsCliEndCIDADE.AsString;
    edtRemBairro.Text := dm.cdsCliEndBAIRRO.AsString;
    edtRemCep.TExt := dm.cdsCliEndCEP.AsString;
    edtRemUF.Text := dm.cdsCliEndUF.AsString;
    dm.cdsCliEnd.Close;
  end;
end;

procedure TfrmDemo_ACBrCTe.edtBuscaTomadorChange(Sender: TObject);
begin

  if(edtBuscaTomador.Text = '') then
  begin
     MessageDlg('Escolha um Tomador', mtWarning, [mbOK], 0);
     exit;
  end;

  if not(dm.cdsCliEnd.Active) Then
  begin
    dm.cdsCliEnd.Active := True;
    dm.cdsCliEnd.Locate(' CODCLIENTE', edtBuscaTomador.Text, [loPartialKey]);
    edtTomadorCodCidade.Text := LimparString(dm.cdsCliEndCD_IBGE.AsString,'-');
    edtTomadorCidade.Text    := dm.cdsCliEndCIDADE.AsString;
    edtTomadorUF.Text        := dm.cdsCliEndUF.AsString;
    edtNomeTomador.Text      := dm.cdsCliEndNOMECLIENTE.AsString;
    edtRazaoTomador.Text     := dm.cdsCliEndRAZAOSOCIAL.AsString;
    edtCNPJTomador.Text      := dm.cdsCliEndCNPJ.AsString;
    edtIETomador.Text        := dm.cdsCliEndINSCESTADUAL.AsString;
    edtFoneTomador.Text      := dm.cdsCliEndDDD.AsString + '-' + dm.cdsCliEndTELEFONE.AsString;
    edtEndTomador.Text       := dm.cdsCliEndLOGRADOURO.AsString;
    edtNumTomador.Text       := dm.cdsCliEndNUMERO.AsString;
    edtTomadorCidade.Text    := dm.cdsCliEndCIDADE.AsString;
    edtBairroTomador.Text    := dm.cdsCliEndBAIRRO.AsString;
    edtCepTomador.TExt       := dm.cdsCliEndCEP.AsString;
    edtTomadorUF.Text        := dm.cdsCliEndUF.AsString;

    // Aba Doc Transp Anterior

    edtAntCNPJ.Text := dm.cdsCliEndCNPJ.AsString;
    edtAntUF.Text   := dm.cdsCliEndUF.AsString;
    edtAntIE.Text   := dm.cdsCliEndINSCESTADUAL.AsString;
    edtAntNome.Text := dm.cdsCliEndNOMECLIENTE.AsString;

    dm.cdsCliEnd.Close;
  end;
end;

procedure TfrmDemo_ACBrCTe.edtCFOPBuscaChange(Sender: TObject);
begin
  if not(dm.cdsCFOP.Active) Then
  begin
    dm.cdsCFOP.Active := True;
  end;
  dm.cdsCFOP.Locate('CFCOD', edtCFOPBusca.Text, [loPartialKey]);
  edtCFOP.Text := LimparString(dm.cdsCFOPCFCOD.AsString,'-');
  edtNatOpe.Text := Copy(dm.cdsCFOPCFNOME.AsString,1,60); //dm.cdsCFOPCFNOME.AsString;
  dm.cdsCFOP.Close;
end;
procedure TfrmDemo_ACBrCTe.edtEnvCodCidadeChange(Sender: TObject);
begin

end;

/// ver se precisa disso abaixo 08/11/2016
procedure TfrmDemo_ACBrCTe.edtExpBuscaChange(Sender: TObject);
begin
  // PULEI
  if(edtExpBusca.Text = '') then
  begin
     MessageDlg('Escolha um Expeditor', mtWarning, [mbOK], 0);
     exit;
  end;
    if not(dm.cdsCliEnd.Active) Then
  begin
    dm.cdsCliEnd.Active := True;
    dm.cdsCliEnd.Locate(' CODCLIENTE', edtExpBusca.Text, [loPartialKey]);
    edtExpCodCidade.Text := LimparString(dm.cdsCliEndCD_IBGE.AsString,'-');
    edtExpCidade.Text := dm.cdsCliEndCIDADE.AsString;
    edtExpUF.Text := dm.cdsCliEndUF.AsString;
    edtExpNome.Text := dm.cdsCliEndNOMECLIENTE.AsString;
    edtExpRazao.Text := dm.cdsCliEndRAZAOSOCIAL.AsString;
    edtExpCNPJ.Text := dm.cdsCliEndCNPJ.AsString;
    edtExpIE.Text := dm.cdsCliEndINSCESTADUAL.AsString;
    edtExpFone.Text := dm.cdsCliEndDDD.AsString + '-' + dm.cdsCliEndTELEFONE.AsString;
    edtExpEnd.Text := dm.cdsCliEndLOGRADOURO.AsString;
    edtExpNum.Text := dm.cdsCliEndNUMERO.AsString;
    edtExpCidade.Text := dm.cdsCliEndCIDADE.AsString;
    edtExpBairro.Text := dm.cdsCliEndBAIRRO.AsString;
    edtExpCep.TExt := dm.cdsCliEndCEP.AsString;
    edtExpUF.Text := dm.cdsCliEndUF.AsString;
    dm.cdsCliEnd.Close;
  end;
end;

function TfrmDemo_ACBrCTe.LimparString(ATExto, ACaracteres: string): string;
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

function TfrmDemo_ACBrCTe.editParaSql(tipo: String; conteudoEdit: String): String;
begin
  if (conteudoEdit <> '') then
  begin
    if (tipo = 'N') then
      result := conteudoEdit;
    if (tipo = 'S') then
      result := QuotedStr(conteudoEdit);
    if (tipo = 'I') then
    begin
      if (conteudoEdit = '0') then
        result := 'null'
      else
        result := conteudoEdit;
    end;
  end
  else begin
    result := 'null';
  end;
end;


procedure TfrmDemo_ACBrCTe.CarregarUF;
begin
  if dm.qUF.Active then
    dm.qUF.Close;
  dm.qUF.Open;
  dm.qUF.First;
  while not dm.qUF.Eof do
  begin
    comboEmi.Items.Add(dm.qUFCD_UF.AsString);
    comboIni.Items.Add(dm.qUFCD_UF.AsString);
    comboFim.Items.Add(dm.qUFCD_UF.AsString);
    dm.qUF.Next;
  end;
  dm.qUF.Close;
end;


procedure TfrmDemo_ACBrCTe.CheckBox1Click(Sender: TObject);
begin
    // AQUI
    if CheckBox1.Checked = true then
    begin
      combICMSDevido.Enabled := True;
      calValB.Enabled := True;
      valAliIn.Enabled := True;
      valAliInter.Enabled := True;
      valICMSPartI.Enabled := True;
      valIMCSPartF.Enabled := True;
      valCombIni.Enabled := True;
      valCombFim.Enabled := True;
    end;

    if CheckBox1.Checked = False then
    begin
      combICMSDevido.Enabled := False;
      calValB.Enabled := False;
      valAliIn.Enabled := False;
      valAliInter.Enabled := False;
      valICMSPartI.Enabled := False;
      valIMCSPartF.Enabled := False;
      valCombIni.Enabled := False;
      valCombFim.Enabled := False;
    end;

end;

procedure TfrmDemo_ACBrCTe.combCodSitTribChange(Sender: TObject);
begin
                                      // 000
  if(combCodSitTrib.ItemIndex = 0)then
  begin
    dbVALPREDBC.Enabled := False;  //  valpRedBC.Enabled := False;
    dbVALVBC.Enabled    := True;   //  valvBC.Enabled    := True;
    dbVALPICMS.Enabled  := True;   //  valpICMS.Enabled  := True;
    dbVALVICMS.Enabled := True;   //  valvICMS.Enabled  := True;
    dbVALVCRED.Enabled  := False;  //  valvCred.Enabled  := False;

  end;
                                      // 20   90 icms
  if((combCodSitTrib.ItemIndex = 1)or(combCodSitTrib.ItemIndex = 7))then
  begin
    dbvalpRedBC.Enabled := True;
    dbvalvBC.Enabled    := True;
    dbvalpICMS.Enabled  := True;
    dbvalvICMS.Enabled  := True;
    dbvalvCred.Enabled  := False;
  end;
                                    // 40  41  51  Simples Nacional
  if((combCodSitTrib.ItemIndex = 2)or(combCodSitTrib.ItemIndex = 3)or(combCodSitTrib.ItemIndex = 4)or(combCodSitTrib.ItemIndex = 8))then
  begin
    dbvalpRedBC.Enabled := False;
    dbvalvBC.Enabled    := False;
    dbvalpICMS.Enabled  := False;
    dbvalvICMS.Enabled  := False;
    dbvalvCred.Enabled  := False;
  end;
                                    // 60
  if(combCodSitTrib.ItemIndex = 5)then
  begin
    dbvalpRedBC.Enabled := False;
    dbvalvBC.Enabled    := True;
    dbvalpICMS.Enabled  := True;
    dbvalvICMS.Enabled  := True;
    dbvalvCred.Enabled  := True;
  end;
                                   // 90 outros
  if(combCodSitTrib.ItemIndex = 6)then
  begin
    dbvalpRedBC.Enabled := True;
    dbvalvBC.Enabled    := True;
    dbvalpICMS.Enabled  := True;
    dbvalvICMS.Enabled  := True;
    dbvalvCred.Enabled  := True;
  end;

end;

procedure TfrmDemo_ACBrCTe.comboCidadeEmiChange(Sender: TObject);
begin
  if not(dm.qCidade.Active) Then
  begin
    dm.qCidade.Active := True;
    dm.qCidade.Locate('NM_LOCALIDADE', comboCidadeEmi.Text , [loCaseInsensitive]);
  end;

  if not(dm.qcidadeE.Active) then
  begin
    dm.qCidadeE.Close;
    dm.qcidadeE.Params[0].AsString := '';
    dm.qcidadeE.Params[1].AsString := '';
    dm.qcidadeE.Params[0].AsString := comboCidadeEmi.Text;
    dm.qcidadeE.Params[1].AsString := comboEmi.Text;
    dm.qcidadeE.Open;

    edtEnvCidade.Text := dm.qcidadeENM_MUNICIPIO.AsString;
    edtEnvCodCidade.Text := LimparString(dm.qCidadeECD_IBGE.AsString,'-');
    edtEnvUF.Text := dm.qcidadeECD_UF.AsString;

    dm.qCidadeE.Close;
    dm.qCidade.Close;

  end;

end;

procedure TfrmDemo_ACBrCTe.comboCidadeFimChange(Sender: TObject);
begin
  if not(dm.qCidade.Active) Then
  begin
    dm.qCidade.Active := True;
    dm.qCidade.Locate('NM_LOCALIDADE', comboCidadeFim.Text , [loCaseInsensitive]);
  end;

  if not(dm.qcidadeE.Active) then
  begin
    dm.qCidadeE.Close;
    dm.qcidadeE.Params[0].AsString := '';
    dm.qcidadeE.Params[1].AsString := '';
    dm.qcidadeE.Params[0].AsString := comboCidadeFim.Text;
    dm.qcidadeE.Params[1].AsString := comboFim.Text;
    dm.qcidadeE.Open;

    edtFimCidade.Text := dm.qcidadeENM_MUNICIPIO.AsString;
    edtFimCodCidade.Text := LimparString(dm.qCidadeECD_IBGE.AsString,'-');
    edtFimUF.Text := dm.qcidadeECD_UF.AsString;

    dm.qCidadeE.Close;
    dm.qCidade.Close;

  end
end;

procedure TfrmDemo_ACBrCTe.comboCidadeIniChange(Sender: TObject);
begin
  if not(dm.qCidade.Active) Then
  begin
    dm.qCidade.Active := True;
    dm.qCidade.Locate('NM_LOCALIDADE', comboCidadeIni.Text , [loCaseInsensitive]);
  end;

  if not(dm.qcidadeE.Active) then
  begin
    dm.qCidadeE.Close;
    dm.qcidadeE.Params[0].AsString := '';
    dm.qcidadeE.Params[1].AsString := '';
    dm.qcidadeE.Params[0].AsString := comboCidadeIni.Text;
    dm.qcidadeE.Params[1].AsString := comboIni.Text;
    dm.qcidadeE.Open;

    edtIniCidade.Text := dm.qcidadeENM_MUNICIPIO.AsString;
    edtIniCodCidade.Text := LimparString(dm.qCidadeECD_IBGE.AsString,'-');
    edtIniUF.Text := dm.qcidadeECD_UF.AsString;

    dm.qCidadeE.Close;
    dm.qCidade.Close;

  end;
end;

procedure TfrmDemo_ACBrCTe.comboEmiChange(Sender: TObject);
begin
                             // UF
  comboCidadeEmi.Clear;
    if dm.qCidade.Active then
    dm.qCidade.Close;
  dm.qCidade.Params[0].AsString := comboEmi.Text;
  dm.qCidade.Open;
  dm.qCidade.First;
  while not dm.qCidade.Eof do
  begin
    comboCidadeEmi.Items.Add(dm.qCidadeNM_LOCALIDADE.AsString);
    dm.qCidade.Next;
  end;
  dm.qCidade.Close;
  comboCidadeEmi.ItemIndex := 0;
                                  // Cidades
  if not(dm.qCidade.Active) Then
  begin
    dm.qCidade.Active := True;
    dm.qCidade.Locate('NM_LOCALIDADE', comboCidadeEmi.Text , [loCaseInsensitive]);
  end;

  if not(dm.qcidadeE.Active) then
  begin
    dm.qCidadeE.Close;
    dm.qcidadeE.Params[0].AsString := '';
    dm.qcidadeE.Params[1].AsString := '';
    dm.qcidadeE.Params[0].AsString := comboCidadeEmi.Text;
    dm.qcidadeE.Params[1].AsString := comboEmi.Text;
    dm.qcidadeE.Open;

    edtEnvCidade.Text := dm.qCidadeENM_LOCALIDADE.AsString;
    edtEnvCodCidade.Text := LimparString(dm.qCidadeECD_IBGE.AsString,'-');
    edtEnvUF.Text := dm.qcidadeECD_UF.AsString;

    dm.qCidadeE.Close;
    dm.qCidade.Close;

  end;

end;

procedure TfrmDemo_ACBrCTe.comboEmpresaChange(Sender: TObject);
var cnpj , ie : string;
begin
   dm.zEmpresa.Close;
   dm.zEmpresa.SQL.Clear;
   dm.zEmpresa.SQL.Add('Select * From Empresa');
   dm.zEmpresa.SQL.Add('Where RAZAO = ' + QuotedStr(comboEmpresa.Text));
   dm.zEmpresa.Active:=True;
   dm.zEmpresa.Open;

   if copy(dm.zEmpresaCNPJ_CPF.Text,10,4)<>'0000'
   then begin
     CNPJ := dm.zEmpresaCNPJ_CPF.Text;
     IE := dm.zEmpresaIE_RG.Text;
   end
   else begin
     CNPJ := Copy(dm.zEmpresaCNPJ_CPF.Text, 1, 9) + Copy(dm.zEmpresaCNPJ_CPF.Text, 14, 2);
     IE := 'ISENTO';
   end;

   edtCodEmitente.Text := dm.zEmpresaCODIGO.AsString;
   edtEmitCNPJ.Text := dm.zEmpresaCNPJ_CPF.AsString;
   edtEmitIE.Text := dm.zEmpresaIE_RG.AsString;
   edtEmitRazao.Text := dm.zEmpresaRAZAO.AsString;
   edtEmitFantasia.Text := dm.zEmpresaEMPRESA.AsString;
   edtEmitFone.Text := dm.zEmpresaFONE.AsString;
   edtEmitCEP.Text := dm.zEmpresaCEP.AsString;
   edtEmitLogradouro.Text := dm.zEmpresaENDERECO.AsString;
   edtEmitNumero.Text := dm.zEmpresaNUMERO.AsString;
   edtEmitComp.Text := dm.zEmpresaLOGRADOURO.AsString;
   edtEmitBairro.Text := dm.zEmpresaBAIRRO.AsString;
   edtEmitCodCidade.Text := dm.zEmpresaCD_IBGE.AsString;
   edtEmitCidade.Text := dm.zEmpresaCIDADE.AsString;
   edtEmitUF.Text := dm.zEmpresaUF.AsString;

   label55.Caption := ' Emitente Iniciado' ;

  // PageControl1.ActivePage := TabSheet2;  // Dados
   PageControl1.ActivePage := TabSheet24;  // Cte GEradas
   label58.Caption := edtEmitRazao.Text;
   label59.Caption := edtEmitRazao.Text;
  //dm.zEmpresa.Active := True;
  //dm.zEmpresa.Open;

//  if (edtSerieCte.Text = '')  then
//  begin
    if (dm.qBuscaSerie.Active) then
      dm.qBuscaSerie.Close;
    dm.qBuscaSerie.sql.Clear;
    dm.qBuscaSerie.sql.Add('SELECT SERIE_CTE ,ULTIMO_NUMERO  FROM SERIES where MODELO = ' + QuotedStr('CT') +
                           ' and CODSERIE = ' + QuotedStr(edtCodEmitente.Text));
    dm.qBuscaSerie.Open;
    if (dm.qBuscaSerie.fieldByName('ULTIMO_NUMERO').asInteger > 0) then
    begin
      edtSerieCte.Text := '';
      edtNumCte.Text := '';
      edtSerieCte.Text := dm.qBuscaSerie.fieldByName('serie_cte').AsString;
      edtNumCte.Text := IntToStr(dm.qBuscaSerie.fieldByName('ULTIMO_NUMERO').asInteger + 1);
    end;

//  end;

end;

procedure TfrmDemo_ACBrCTe.comboFimChange(Sender: TObject);
begin
                             // UF
  comboCidadeFim.Clear;
    if dm.qCidade.Active then
    dm.qCidade.Close;
  dm.qCidade.Params[0].AsString := comboFim.Text;
  dm.qCidade.Open;
  dm.qCidade.First;
  while not dm.qCidade.Eof do
  begin
    comboCidadeFim.Items.Add(dm.qCidadeNM_LOCALIDADE.AsString);
    dm.qCidade.Next;
  end;
  dm.qCidade.Close;
  comboCidadeFim.ItemIndex := 0;
                                     //Cidades
  if not(dm.qCidade.Active) Then
  begin
    dm.qCidade.Active := True;
    dm.qCidade.Locate('NM_LOCALIDADE', comboCidadeFim.Text , [loCaseInsensitive]);
  end;

  if not(dm.qcidadeE.Active) then
  begin
    dm.qCidadeE.Close;
    dm.qcidadeE.Params[0].AsString := '';
    dm.qcidadeE.Params[1].AsString := '';
    dm.qcidadeE.Params[0].AsString := comboCidadeFim.Text;
    dm.qcidadeE.Params[1].AsString := comboFim.Text;
    dm.qcidadeE.Open;

    edtFimCidade.Text := dm.qCidadeENM_LOCALIDADE.AsString;
    edtFimCodCidade.Text := LimparString(dm.qCidadeECD_IBGE.AsString,'-');
    edtFimUF.Text := dm.qcidadeECD_UF.AsString;

    dm.qCidadeE.Close;
    dm.qCidade.Close;

  end
end;

procedure TfrmDemo_ACBrCTe.comboIniChange(Sender: TObject);
begin
                              // UF
  comboCidadeIni.Clear;
    if dm.qCidade.Active then
    dm.qCidade.Close;
  dm.qCidade.Params[0].AsString := comboIni.Text;
  dm.qCidade.Open;
  dm.qCidade.First;
  while not dm.qCidade.Eof do
  begin
    comboCidadeIni.Items.Add(dm.qCidadeNM_LOCALIDADE.AsString);
    dm.qCidade.Next;
  end;
  dm.qCidade.Close;
  comboCidadeIni.ItemIndex := 0;
                               // Cidades
  if not(dm.qCidade.Active) Then
  begin
    dm.qCidade.Active := True;
    dm.qCidade.Locate('NM_LOCALIDADE', comboCidadeIni.Text , [loCaseInsensitive]);
  end;

  if not(dm.qcidadeE.Active) then
  begin
    dm.qCidadeE.Close;
    dm.qcidadeE.Params[0].AsString := '';
    dm.qcidadeE.Params[1].AsString := '';
    dm.qcidadeE.Params[0].AsString := comboCidadeIni.Text;
    dm.qcidadeE.Params[1].AsString := comboIni.Text;
    dm.qcidadeE.Open;

    edtIniCidade.Text := dm.qCidadeENM_LOCALIDADE.AsString;
    edtIniCodCidade.Text := LimparString(dm.qCidadeECD_IBGE.AsString,'-');
    edtIniUF.Text := dm.qcidadeECD_UF.AsString;

    dm.qCidadeE.Close;
    dm.qCidade.Close;

  end;
end;

procedure TfrmDemo_ACBrCTe.combOutrosDocsChange(Sender: TObject);
begin
   if(combOutrosDocs.ItemIndex = 0) then
     edtOutrosDesc.Enabled := False ;
   if(combOutrosDocs.ItemIndex = 1) then
     edtOutrosDesc.Enabled := True ;
end;

procedure TfrmDemo_ACBrCTe.combOutrosDocsClick(Sender: TObject);
begin
     dataOutrosEmi.DateTime := now;
end;

procedure TfrmDemo_ACBrCTe.EditarA;
var  strEdita :string;
begin
  if (edtCFOP.Text <> '') then
   begin

    strEdita := 'UPDATE CTE SET CTE_CFOP = ' ;
    strEdita := strEdita +  QuotedStr(edtCFOP.Text);
    strEdita := strEdita +  ', CTE_NATOP = ' ;
    strEdita := strEdita + QuotedStr(Copy(edtNatOpe.Text,1,60)); //QuotedStr(edtNatOpe.Text);

    strEdita := strEdita +  ', DHEMI = ' ;
    strEdita := strEdita +  QuotedStr(FormatDateTime('mm/dd/yyyy',dataGerarCte.date));

    strEdita := strEdita +  ', ENV_CODCIDADE = ';
    strEdita := strEdita +  QuotedStr(edtEnvCodCidade.Text);
    strEdita := strEdita +  ', ENV_CIDADE = ' ;
    strEdita := strEdita +  QuotedStr(edtEnvCidade.Text);
    strEdita := strEdita +  ', ENV_ESTADO = ' ;
    strEdita := strEdita +  QuotedStr(edtEnvUF.Text);

    strEdita := strEdita +  ',INI_CODCIDADE = ';
    strEdita := strEdita +  QuotedStr(edtIniCodCidade.Text);
    strEdita := strEdita +  ',INI_CIDADE = ';
    strEdita := strEdita +  QuotedStr(edtIniCidade.Text);
    strEdita := strEdita +  ',INI_ESTADO = ';
    strEdita := strEdita +  QuotedStr(edtIniUF.Text);

    strEdita := strEdita +  ',FIM_CODCIDADE = ';
    strEdita := strEdita +  QuotedStr(edtFimCodCidade.Text);
    strEdita := strEdita +  ',FIM_CIDADE = ';
    strEdita := strEdita +  QuotedStr(edtFimCidade.Text);
    strEdita := strEdita +  ',FIM_ESTADO = ';
    strEdita := strEdita +  QuotedStr(edtFimUF.Text);

    strEdita := strEdita +  ',MODAL = ';
    strEdita := strEdita +  IntToStr(rgModal.ItemIndex);  //MODAL
    strEdita := strEdita +  ', TIPOSERVICO = ';
    strEdita := strEdita +  IntToStr(rgTipoServico.ItemIndex);  // TIPOSERVICO
    strEdita := strEdita +  ',TIPOCTE = ';
    strEdita := strEdita +  IntToStr(rgTiposCte.ItemIndex);     // TIPOCTE
    strEdita := strEdita +  ',TPOEMISSAO = ';
    strEdita := strEdita +  IntToStr(rgFormaEmissao.ItemIndex); // TPOEMISSAO
    strEdita := strEdita +  ',IFORPAG = ';
    strEdita := strEdita +  IntToStr(rgForPag.ItemIndex);       // IFORPAG
    strEdita := strEdita +  ',TPIMP = ';
    strEdita := strEdita +  IntToStr(rgTipoDACTe.ItemIndex);    // TPIMP

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);

    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEdita);

      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;

  end;
end;

procedure TfrmDemo_ACBrCTe.EditarB;   //  Aba Dados Complementares
var  strEdita :string;
begin
  if (edtNumCte.Text <> '') then
  begin
    strEdita := 'UPDATE CTE SET CARAC_TRANSP = ';
    strEdita := strEdita + QuotedStr(edtCaracAdTrans.Text); // CARAC_TRANSP
    strEdita := strEdita +  ',CARAC_SERV = ';
    strEdita := strEdita + QuotedStr(edtCaracAdServ.Text); // CARAC_SERV
    strEdita := strEdita +  ',FUNC_EMI = ';
    strEdita := strEdita + QuotedStr(edtFuncEmi.Text); // FUNC_EMI

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEdita);

      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.EditarC;  // Aba Dados da Retirada
var  strEdita :string;
begin
  if (edtNumCte.Text <> '') then
  begin
    strEdita := 'UPDATE CTE SET RETIRA = ';
    strEdita := strEdita + IntToStr(rgRetira.ItemIndex);
    strEdita := strEdita +  ',DET_RETIRA = ';
    strEdita := strEdita + QuotedStr(memDetRetira.Text);

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;
    try
      dm.con.ExecuteDirect(strEdita);

      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.EditarT;
var  strEdita :string;
begin

  if(rgTomador.ItemIndex <> 4) then
  begin
    strEdita := 'UPDATE CTE SET  TOMADORSERVICO = ';
    strEdita := strEdita + IntToStr(rgTomador.ItemIndex);
    strEdita := strEdita + ',T_CNPJCPF = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_IESTADUAL = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_RSOCIAL = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_FANTASIA = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_TELEFONE = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_ENDERECO = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_NUMERO = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_COMPLEMENTO = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_BAIRRO = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_CODIGOMUNICIPI = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_CIDADE = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_CEP = ';
    strEdita := strEdita + QuotedStr('');
    strEdita := strEdita +  ',T_ESTADO = ';
    strEdita := strEdita + QuotedStr('');

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;
    try
      dm.con.ExecuteDirect(strEdita);

      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;


  if(rgTomador.ItemIndex = 4) then
  begin
    strEdita := 'UPDATE CTE SET  TOMADORSERVICO = ';
    strEdita := strEdita + IntToStr(rgTomador.ItemIndex);
    strEdita := strEdita + ', T_CNPJCPF = ';
    strEdita := strEdita + QuotedStr(edtCNPJTomador.Text);
    strEdita := strEdita +  ',T_IESTADUAL = ';
    strEdita := strEdita + QuotedStr(edtIETomador.Text);
    strEdita := strEdita +  ',T_RSOCIAL = ';
    strEdita := strEdita + QuotedStr(edtRazaoTomador.Text);
    strEdita := strEdita +  ',T_FANTASIA = ';
    strEdita := strEdita + QuotedStr(edtNomeTomador.Text);
    strEdita := strEdita +  ',T_TELEFONE = ';
    strEdita := strEdita + QuotedStr(edtFoneTomador.Text);
    strEdita := strEdita +  ',T_ENDERECO = ';
    strEdita := strEdita + QuotedStr(edtEndTomador.Text);
    strEdita := strEdita +  ',T_NUMERO = ';
    strEdita := strEdita + QuotedStr(edtNumTomador.Text);
    strEdita := strEdita +  ',T_COMPLEMENTO = ';
    strEdita := strEdita + QuotedStr(edtCompTomador.Text);
    strEdita := strEdita +  ',T_BAIRRO = ';
    strEdita := strEdita + QuotedStr(edtBairroTomador.Text);
    strEdita := strEdita +  ',T_CODIGOMUNICIPI = ';
    strEdita := strEdita + QuotedStr(edtTomadorCodCidade.Text);
    strEdita := strEdita +  ',T_CIDADE = ';
    strEdita := strEdita + QuotedStr(edtTomadorCidade.Text);
    strEdita := strEdita +  ',T_CEP = ';
    strEdita := strEdita + QuotedStr(edtCepTomador.Text);
    strEdita := strEdita +  ',T_ESTADO = ';
    strEdita := strEdita + QuotedStr(edtTomadorUF.Text);

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;
    try
      dm.con.ExecuteDirect(strEdita);

      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;

end;

procedure TfrmDemo_ACBrCTe.EditarEX;      /// Conferir 04/09/19
var  strEdita :string;
begin

  if(rgTomador.ItemIndex = 4) then        /// Conferir 04/09/19
  begin
    strEdita := 'UPDATE CTE SET EX_CNPJCPF = ';
    strEdita := strEdita + QuotedStr(edtExpCNPJ.Text);
    strEdita := strEdita +  ',EX_IESTADUAL = ';
    strEdita := strEdita + QuotedStr(edtExpIE.Text);
    strEdita := strEdita +  ',EX_RSOCIAL = ';
    strEdita := strEdita + QuotedStr(edtExpRazao.Text);
    strEdita := strEdita +  ',EX_FANTASIA = ';
    strEdita := strEdita + QuotedStr(edtExpNome.Text);
    strEdita := strEdita +  ',EX_TELEFONE = ';
    strEdita := strEdita + QuotedStr(edtExpFone.Text);
    strEdita := strEdita +  ',EX_ENDERECO = ';
    strEdita := strEdita + QuotedStr(edtExpEnd.Text);
    strEdita := strEdita +  ',EX_NUMERO = ';
    strEdita := strEdita + QuotedStr(edtExpNum.Text);
    strEdita := strEdita +  ',EX_COMPLEMENTO = ';
    strEdita := strEdita + QuotedStr(edtExpComp.Text);
    strEdita := strEdita +  ',EX_BAIRRO = ';
    strEdita := strEdita + QuotedStr(edtExpBairro.Text);
    strEdita := strEdita +  ',EX_CODIGOMUNICIPI = ';
    strEdita := strEdita + QuotedStr(edtExpCodCidade.Text);
    strEdita := strEdita +  ',EX_CIDADE = ';
    strEdita := strEdita + QuotedStr(edtExpCidade.Text);
    strEdita := strEdita +  ',EX_CEP = ';
    strEdita := strEdita + QuotedStr(edtExpCep.Text);
    strEdita := strEdita +  ',EX_ESTADO = ';
    strEdita := strEdita + QuotedStr(edtExpUF.Text);

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;
    try
      dm.con.ExecuteDirect(strEdita);

      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;

end;
procedure TfrmDemo_ACBrCTe.EditarDE;
var  strEdita :string;
begin
  if(rgDest.ItemIndex = 0) then
  begin
    if (edtDestCNPJ.Text <> '') then
    begin
      strEdita := 'UPDATE CTE SET D_CNPJCPF = ';
      strEdita := strEdita + QuotedStr(edtDestCNPJ.Text);
      strEdita := strEdita +  ',D_IESTADUAL = ';
      strEdita := strEdita + QuotedStr(edtDestIE.Text);
      strEdita := strEdita +  ',D_RSOCIAL = ';
      strEdita := strEdita + QuotedStr(edtDestRazao.Text);
      strEdita := strEdita +  ',D_FANTASIA = ';
      strEdita := strEdita + QuotedStr(edtDestNome.Text);
      strEdita := strEdita +  ',D_TELEFONE = ';
      strEdita := strEdita + QuotedStr(edtDestFone.Text);
      strEdita := strEdita +  ',D_ENDERECO = ';
      strEdita := strEdita + QuotedStr(edtDestEnd.Text);
      strEdita := strEdita +  ',D_NUMERO = ';
      strEdita := strEdita + QuotedStr(edtDestNum.Text);
      strEdita := strEdita +  ',D_COMPLEMENTO = ';
      strEdita := strEdita + QuotedStr(edtDestComp.Text);
      strEdita := strEdita +  ',D_BAIRRO = ';
      strEdita := strEdita + QuotedStr(edtDestBairro.Text);
      strEdita := strEdita +  ',D_CODIGOMUNICIPI = ';
      strEdita := strEdita + QuotedStr(edtDestCodCidade.Text);
      strEdita := strEdita +  ',D_CIDADE = ';
      strEdita := strEdita + QuotedStr(edtDestCidade.Text);
      strEdita := strEdita +  ',D_CEP = ';
      strEdita := strEdita + QuotedStr(edtDestCep.Text);
      strEdita := strEdita +  ',D_ESTADO = ';
      strEdita := strEdita + QuotedStr(edtDestUF.Text);


      strEdita := strEdita +' where COD_CTE = ' ;
      strEdita := strEdita +  IntToStr(val_genCte);
      MemoDados.Text := strEdita;
      dm.con.AutoCommit := true;
      dm.con.StartTransaction;
      try
        dm.con.ExecuteDirect(strEdita);

        dm.con.Commit;
        FormatSettings.DecimalSeparator := ',';
      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dm.con.Rollback;
          exit;
        end;
      end;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.EditarR;
var  strEdita, str1 :string;
begin
  if (edtRemCNPJ.Text <> '') then
  begin
    strEdita := 'UPDATE CTE SET ';
    str1 := '';
    if (edtRemCNPJ.Text <> '') then
    begin
      strEdita := strEdita + ' R_CNPJCPF = ' + QuotedStr(edtRemCNPJ.Text);
      str1 := ', ';
    end;
    if (edtRemIE.Text <> '') then
    begin
      strEdita := strEdita + str1 + ' R_IESTADUAL = ' + QuotedStr(edtRemIE.Text);
      str1 := ', ';
    end;
    if (edtRemRazao.Text <> '') then
    begin
      strEdita := strEdita + str1 + ' R_RSOCIAL = ' + QuotedStr(edtRemRazao.Text);
      str1 := ', ';
    end;

    strEdita := strEdita +  ',R_FANTASIA = ';
    strEdita := strEdita + QuotedStr(edtRemNome.Text);
    strEdita := strEdita +  ',R_TELEFONE = ';
    strEdita := strEdita + QuotedStr(edtRemFone.Text);
    strEdita := strEdita +  ',R_ENDERECO = ';
    strEdita := strEdita + QuotedStr(edtRemEnd.Text);
    strEdita := strEdita +  ',R_NUMERO = ';
    strEdita := strEdita + QuotedStr(edtRemNum.Text);
    strEdita := strEdita +  ',R_COMPLEMENTO = ';
    strEdita := strEdita + QuotedStr(edtRemComp.Text);
    strEdita := strEdita +  ',R_BAIRRO = ';
    strEdita := strEdita + QuotedStr(edtRemBairro.Text);
    strEdita := strEdita +  ',R_CODIGOMUNICIPI = ';
    strEdita := strEdita + QuotedStr(edtRemCodCidade.Text);
    strEdita := strEdita +  ',R_CIDADE = ';
    strEdita := strEdita + QuotedStr(edtRemCidade.Text);
    strEdita := strEdita +  ',R_CEP = ';
    strEdita := strEdita + QuotedStr(edtRemCep.Text);
    strEdita := strEdita +  ',R_ESTADO = ';
    strEdita := strEdita + QuotedStr(edtRemUF.Text);

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;
    try
      dm.con.ExecuteDirect(strEdita);
      dm.con.Commit;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.EditarREC;
var  strEdita, str1 :string;
begin
  if (edtRecCNPJ.Text <> '') then
  begin
    strEdita := 'UPDATE CTE SET ';
    str1 := '';
    if (edtRecCNPJ.Text <> '') then
    begin
      strEdita := strEdita + ' RE_CNPJCPF = ' + QuotedStr(edtRecCNPJ.Text);
      str1 := ', ';
    end;
    if (edtRecIE.Text <> '') then
    begin
      strEdita := strEdita + str1 + ' RE_IESTADUAL = ' + QuotedStr(edtRecIE.Text);
      str1 := ', ';
    end;
    if (edtRecRazao.Text <> '') then
    begin
      strEdita := strEdita + str1 + ' RE_RSOCIAL = ' + QuotedStr(edtRecRazao.Text);
      str1 := ', ';
    end;

    strEdita := strEdita +  ',RE_FANTASIA = ';
    strEdita := strEdita + QuotedStr(edtRecNome.Text);
    strEdita := strEdita +  ',RE_TELEFONE = ';
    strEdita := strEdita + QuotedStr(edtRecFone.Text);
    strEdita := strEdita +  ',RE_ENDERECO = ';
    strEdita := strEdita + QuotedStr(edtRecEnd.Text);
    strEdita := strEdita +  ',RE_NUMERO = ';
    strEdita := strEdita + QuotedStr(edtRecNum.Text);
    strEdita := strEdita +  ',RE_COMPLEMENTO = ';
    strEdita := strEdita + QuotedStr(edtRecComp.Text);
    strEdita := strEdita +  ',RE_BAIRRO = ';
    strEdita := strEdita + QuotedStr(edtRecBairro.Text);
    strEdita := strEdita +  ',RE_CODIGOMUNICIPI = ';
    strEdita := strEdita + QuotedStr(edtRecCodCidade.Text);
    strEdita := strEdita +  ',RE_CIDADE = ';
    strEdita := strEdita + QuotedStr(edtRecCidade.Text);
    strEdita := strEdita +  ',RE_CEP = ';
    strEdita := strEdita + QuotedStr(edtRecCep.Text);
    strEdita := strEdita +  ',RE_ESTADO = ';
    strEdita := strEdita + QuotedStr(edtRecUF.Text);

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;
    try
      dm.con.ExecuteDirect(strEdita);
      dm.con.Commit;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.EditarRE;
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
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;
    try
      dm.con.ExecuteDirect(strEdita);
      dm.con.Commit;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.EditarD;  // Aba serviços e Impostos
var  strEdita :string;
begin
  if (edtNumCte.Text <> '') then
  begin
    val1 := 0;
    val2 := 0;
    if (dbValTotPrest.Field.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      val1 := dbValTotPrest.Field.Value;
    end;
    if (dbValTotTri.Field.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      val2 := dbValTotTri.Field.Value;
    end;
    FormatSettings.DecimalSeparator := '.';
    strEdita := 'UPDATE CTE SET VPREST = ';
    strEdita:= strEdita + FloatToStr(val1); //Format('%8.2f', [valTotPrest.Value]);
    strEdita:= strEdita +  ',VREC = ';
    if (dbValReceber.Field.Value <> null) then
    begin
      strEdita:= strEdita + FloatToStr(dbValReceber.Field.Value); //Format('%8.2f', [valReceber.Value]);
    end
    else begin
      strEdita:= strEdita + '0'
    end;
    strEdita:= strEdita +  ' ,VALTOTTRI = ';
    strEdita:= strEdita + FloatToStr(val2); //Format('%8.2f', [valTotTri.Value]);

    strEdita:= strEdita +  ',COMBCODSITTRIB = ';
    strEdita:= strEdita + IntToStr(combCodSitTrib.ItemIndex);

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEdita);

      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;

  if (edtNumCte.Text <> '') then
  begin

    pVALPREDBC := 0;
    pVALVBC    := 0;
    pVALPICMS  := 0;
    pVALVICMS  := 0;
    pVALVCRED  := 0;

    if (dbVALPREDBC.Field.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALPREDBC := dbVALPREDBC.Field.Value;
    end;

    if (dbVALVBC.Field.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALVBC := dbVALVBC.Field.Value;
    end;

     if (dbVALPICMS.Field.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALPICMS := dbVALPICMS.Field.Value;
    end;

     if (dbVALVICMS.Field.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALVICMS := dbVALVICMS.Field.Value;
    end;

      if (dbVALVCRED.Field.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALVCRED := dbVALVCRED.Field.Value;
    end;

    FormatSettings.DecimalSeparator := '.';


    strEdita := 'UPDATE CTE SET COMBCODSITTRIB = ';
    strEdita:= strEdita + IntToStr(combCodSitTrib.ItemIndex);

    strEdita:= strEdita +  ',VALPREDBC = ';
    strEdita:= strEdita + FloatToStr(pVALPREDBC);

    strEdita:= strEdita +  ',VALVBC = ';
    strEdita:= strEdita + FloatToStr(pVALVBC);

    strEdita:= strEdita +  ' ,VALPICMS = ';
    strEdita:= strEdita + FloatToStr(pVALPICMS);

    strEdita:= strEdita +  ',VALVICMS = ';
    strEdita:= strEdita + FloatToStr(pVALVICMS);

    strEdita:= strEdita +  ',VALVCRED = ';
    strEdita:= strEdita + FloatToStr(pVALVCRED);

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEdita);

      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;


end;

procedure TfrmDemo_ACBrCTe.EditarE;
var  strEdita :string;
begin
  if (edtNumCte.Text <> '') then
  begin

    FormatSettings.DecimalSeparator := ',';
    val1 := dbValInfCarga.Field.Value;
    FormatSettings.DecimalSeparator := '.';

    strEdita := 'UPDATE CTE SET VALINFCARGA = ';
    strEdita:= strEdita +  FloatToStr(val1)  ; //QuotedStr(Format('%8.2f', [valInfCarga.Value]));
    strEdita:= strEdita +  ', PROPRED = ';
    strEdita:= strEdita + QuotedStr(edtProPred.Text);
    strEdita:= strEdita +  ',OUTCAT = ';
    strEdita:= strEdita + QuotedStr(edtOutCat.Text);

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEdita);

      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        FormatSettings.DecimalSeparator := ',';
        exit;
      end;
    end;
  end;
end;

procedure TfrmDemo_ACBrCTe.EditarF;
var  strEdita, strEditaANT :string;
begin
  if (edtNumCte.Text <> '') then
  begin

    strEdita := 'UPDATE CTE SET RNTRC = ';
    strEdita := strEdita + QuotedStr(edtRodRNTRC.Text);
    strEdita := strEdita +  ',DATARODPREV = ';
    strEdita := strEdita + QuotedStr(FormatDateTime('mm/dd/yyyy',dataRodPrev.date));
    strEdita := strEdita +  ',RGRODLOTACAO = ';
    strEdita := strEdita + IntToStr(rgRodLotacao.ItemIndex);

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEdita);
      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;

  // 15/08/19

  if (edtNumCte.Text <> '') then
  begin

    strEditaANT := 'UPDATE CTE SET ANT_CNPJ = ';
    strEditaANT := strEditaANT + QuotedStr(edtAntCNPJ.Text);
    strEditaANT := strEditaANT +  ',ANT_IE = ';
    strEditaANT := strEditaANT + QuotedStr(edtAntIE.Text);
    strEditaANT := strEditaANT +  ',ANT_UF = ';
    strEditaANT := strEditaANT + QuotedStr(edtAntUF.Text);
    strEditaANT := strEditaANT +  ',ANT_NOME = ';
    strEditaANT := strEditaANT + QuotedStr(edtAntNome.Text);
    strEditaANT := strEditaANT +  ',ANT_CHCTE = ';
    strEditaANT := strEditaANT + QuotedStr(edtAntCHCTE.Text);


    strEditaANT := strEditaANT +' where COD_CTE = ' ;
    strEditaANT := strEditaANT +  IntToStr(val_genCte);
    MemoDados.Text := strEditaANT;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEditaANT);
      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;



end;
procedure TfrmDemo_ACBrCTe.EditarG;
var  strEdita :string;
begin
  if (edtNumCte.Text <> '') then
  begin

    FormatSettings.DecimalSeparator := ',';
    val1 := valOutrosVal.Value;
    FormatSettings.DecimalSeparator := '.';

    strEdita := 'UPDATE CTE SET OBS_GERAL = ';
    strEdita:= strEdita + QuotedStr(memxObs.Text);

    strEdita := strEdita +  ',OUTPDOC = ';
    strEdita := strEdita +  QuotedStr(Copy(combOutrosDocs.Text,1,2));
    strEdita := strEdita +  ',OUDESCOUTRO = ';
    strEdita := strEdita +  QuotedStr(edtOutrosDesc.Text);
    strEdita := strEdita +  ',OUNDOC = ';
    strEdita := strEdita +  QuotedStr(edtOutrosNum.Text);
    strEdita := strEdita +  ',OUDEMI = ';
    strEdita := strEdita +  QuotedStr(FormatDateTime('mm/dd/yyyy',dataOutrosEmi.date));
    strEdita := strEdita +  ',OUVDOCFISC= ';
    strEdita := strEdita +  FloatToStr(val1) ;

    strEdita := strEdita +' where COD_CTE = ' ;
    strEdita := strEdita +  IntToStr(val_genCte);
    MemoDados.Text := strEdita;
    dm.con.AutoCommit := true;
    dm.con.StartTransaction;

    try
      dm.con.ExecuteDirect(strEdita);
      dm.con.Commit;
      FormatSettings.DecimalSeparator := ',';
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dm.con.Rollback;
        exit;
      end;
    end;
  end;
end;

function TfrmDemo_ACBrCTe.GravarCTe:String;
var strInsere :string;
begin
  if (edtEmitCNPJ.Text <> '') then
  begin

    if dm.cdsGen.Active then
      dm.cdsGen.Close;
    dm.cdsGen.CommandText := 'SELECT CAST(GEN_ID(GEN_CTE, 1) AS INTEGER) AS CODIGO FROM RDB$DATABASE';
    dm.cdsGen.Open;
    val_genCte  := dm.cdsGen.Fields[0].AsInteger;
    dm.cdsGen.Close;

    strInsere := 'INSERT INTO CTE ( COD_CTE, CODEMITENTE, CTE_ESTADO , CTE_CHAVE, CTE_CFOP , CTE_NATOP, MODELO '+
      ', CTE_SERIE, CTE_NUMERO, DHEMI, MODAL, TIPOSERVICO, TIPOCTE, TPOEMISSAO,IFORPAG,  TPIMP , '+
      '  ENV_CODCIDADE '+
      ', ENV_CIDADE, ENV_ESTADO, INI_CODCIDADE, INI_CIDADE, INI_ESTADO, FIM_CODCIDADE, FIM_CIDADE '+
      ', FIM_ESTADO,E_CNPJCPF, E_IESTADUAL, E_RSOCIAL, E_FANTASIA '+
      ', E_TELEFONE , E_ENDERECO, E_NUMERO, E_COMPLEMENTO, E_BAIRRO, E_CODIGOMUNICIPI, E_CIDADE, E_CEP '+
      ', E_ESTADO,TOMADORSERVICO, T_CNPJCPF, T_IESTADUAL, T_RSOCIAL '+
      ', T_FANTASIA, T_TELEFONE, T_ENDERECO, T_NUMERO, T_COMPLEMENTO, T_BAIRRO, T_CODIGOMUNICIPI '+
      ', T_CIDADE, T_CEP, T_ESTADO, R_CNPJCPF, R_IESTADUAL '+
      ', R_RSOCIAL, R_FANTASIA, R_TELEFONE, R_ENDERECO, R_NUMERO, R_COMPLEMENTO,R_BAIRRO, R_CODIGOMUNICIPI '+
      ', R_CIDADE, R_CEP, R_ESTADO, D_CNPJCPF, D_IESTADUAL '+
      ', D_RSOCIAL,D_FANTASIA, D_TELEFONE, D_ENDERECO, D_NUMERO, D_COMPLEMENTO, D_BAIRRO, D_CODIGOMUNICIPI '+
      ', D_CIDADE, D_CEP, D_ESTADO, EX_CNPJCPF, EX_IESTADUAL '+
      ', EX_RSOCIAL , EX_FANTASIA, EX_TELEFONE, EX_ENDERECO, EX_NUMERO, EX_COMPLEMENTO, EX_BAIRRO '+
      ', EX_CODIGOMUNICIPI, EX_CIDADE, EX_CEP, EX_ESTADO ' +
      ', RE_CNPJCPF, RE_IESTADUAL, RE_RSOCIAL, RE_FANTASIA, RE_TELEFONE , RE_ENDERECO, RE_NUMERO ' +
      ', RE_COMPLEMENTO, RE_BAIRRO, RE_CODIGOMUNICIPI, RE_CIDADE, RE_CEP, RE_ESTADO ' +
      ', CARAC_TRANSP,CARAC_SERV , FUNC_EMI , RETIRA '+
      ', DET_RETIRA ,VPREST,VREC,VALTOTTRI ,COMBCODSITTRIB , VALINFCARGA ,PROPRED, OUTCAT,RNTRC,DATARODPREV,RGRODLOTACAO'+
      ', OBS_GERAL ,OUTPDOC ,OUDESCOUTRO ,OUNDOC ,OUDEMI,OUVDOCFISC ,EMITENTE '+
      ',ANT_CNPJ,ANT_IE,ANT_UF,ANT_NOME,ANT_CHCTE,VALPREDBC,VALVBC,VALPICMS,VALVICMS,VALVCRED ) VALUES ( ';
                       ///                        //
                                 // /**/
    // IFORPAG  /* IFORPAG,*/   /*, REFCTE, CODIGOMUNICIPIO, EMPRESACIDADE, EMPRESAESTADO, MODAL, TIPOSERVICO,*/
    // TPIMP    /*TPIMP, TPOEMISSAO, TIPOAMBIENTE, TIPOCTE, PROCEMI, VERPROC*/
    // TPOEMISSAO   /* RETIRA, DETRETIRA, EMITENTE, E_RG,*/
    // TIPOAMBIENTE  /* E_CODIGOPAIS, E_PAIS, TOMADORSERVICO, T_RG,*/
    // TIPOCTE       /* T_CODIGOPAIS, T_PAIS, REMETENTE, R_RG,*/
    // PROCEMI
    // VERPROC        /*R_CODIGOPAIS, R_PAIS, DESTINATARIO, D_RG ,*/
    // REFCTE         /* D_CODIGOPAIS, D_PAIS, EXPEDITOR, EX_RG,*/
    // CODIGOMUNICIPIO    /*, EX_CODIGOPAIS, EX_PAIS*/
    // EMPRESACIDADE
    // EMPRESAESTADO
    // MODAL
    // TIPOSERVICO
    // RETIRA
    // DETRETIRA
    // EMITENTE

    FormatSettings.DecimalSeparator := '.';

    strInsere := strInsere + IntToStr(val_genCte);  //COD_CTE
    strInsere := strInsere + ', ' + IntToStr(1); //CODEMITENTE
    strInsere := strInsere + ', ' + IntToStr(35);  //CTE_ESTADO
    strInsere := strInsere + ', ' + IntToStr(100);  //CTE_CHAVE
    strInsere := strInsere + ', ' + QuotedStr(edtCFOP.Text);  //CTE_CFOP
    strInsere := strInsere + ', ' + QuotedStr(Copy(edtNatOpe.Text,1,60));
    strInsere := strInsere + ', ' + QuotedStr(edtModelo.Text); // MODELO
    strInsere := strInsere + ', ' + QuotedStr(edtSerieCte.Text); //CTE_SERIE
    strInsere := strInsere + ', ' + QuotedStr(edtNumCte.Text);  //CTE_NUMERO
    strInsere := strInsere + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',dataGerarCte.date));  ///DHEMI

    strInsere := strInsere + ', ' + IntToStr(rgModal.ItemIndex);  //MODAL
    strInsere := strInsere + ', ' + IntToStr(rgTipoServico.ItemIndex);  // TIPOSERVICO
    strInsere := strInsere + ', ' + IntToStr(rgTiposCte.ItemIndex);     // TIPOCTE
    strInsere := strInsere + ', ' + IntToStr(rgFormaEmissao.ItemIndex); // TPOEMISSAO
    strInsere := strInsere + ', ' + IntToStr(rgForPag.ItemIndex);       // IFORPAG
    strInsere := strInsere + ', ' + IntToStr(rgTipoDACTe.ItemIndex);    // TPIMP


    strInsere := strInsere + ', ' + QuotedStr(edtEnvCodCidade.Text);  // ENV_CODCIDADE
    strInsere := strInsere + ', ' + QuotedStr(edtEnvCidade.Text);   // ENV_CIDADE
    strInsere := strInsere + ', ' + QuotedStr(edtEnvUF.Text);     // ENV_ESTADO
    strInsere := strInsere + ', ' + QuotedStr(edtIniCodCidade.Text); // INI_CODCIDADE
    strInsere := strInsere + ', ' + QuotedStr(edtIniCidade.Text); // INI_CIDADE
    strInsere := strInsere + ', ' + QuotedStr(edtIniUF.Text);    // INI_ESTADO
    strInsere := strInsere + ', ' + QuotedStr(edtFimCodCidade.Text);  // FIM_CODCIDADE
    strInsere := strInsere + ', ' + QuotedStr(edtFimCidade.Text); // FIM_CIDADE
    strInsere := strInsere + ', ' + QuotedStr(edtFimUF.Text);  // FIM_ESTADO

    // EMITENTE
    // E_RG
    // E_CODIGOPAIS
    // E_PAIS

    strInsere := strInsere + ', ' + QuotedStr(edtEmitCNPJ.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitIE.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitRazao.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitFantasia.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitFone.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitLogradouro.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitNumero.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitComp.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitBairro.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitCodCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitCep.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEmitUF.Text);

    strInsere := strInsere + ', ' +  IntToStr(rgTomador.ItemIndex);

    strInsere := strInsere + ', ' + QuotedStr(edtCNPJTomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtIETomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRazaoTomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtNomeTomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtFoneTomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtEndTomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtNumTomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtCompTomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtBairroTomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtTomadorCodCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtTomadorCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtCepTomador.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtTomadorUF.Text);

    strInsere := strInsere + ', ' + QuotedStr(edtRemCNPJ.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemIE.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemRazao.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemNome.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemFone.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemEnd.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemNum.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemComp.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemBairro.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemCodCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemCep.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRemUF.Text);

    strInsere := strInsere + ', ' + QuotedStr(edtDestCNPJ.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestIE.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestRazao.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestNome.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestFone.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestEnd.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestNum.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestComp.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestBairro.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestCodCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestCep.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtDestUF.Text);

    strInsere := strInsere + ', ' + QuotedStr(edtExpCNPJ.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpIE.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpRazao.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpNome.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpFone.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpEnd.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpNum.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpComp.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpBairro.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpCodCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpCep.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtExpUF.Text);

    strInsere := strInsere + ', ' + QuotedStr(edtRecCNPJ.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecIE.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecRazao.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecNome.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecFone.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecEnd.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecNum.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecComp.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecBairro.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecCodCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecCidade.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecCep.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRecUF.Text);

    strInsere := strInsere + ', ' + QuotedStr(edtCaracAdTrans.Text); // CARAC_TRANSP
    strInsere := strInsere + ', ' + QuotedStr(edtCaracAdServ.Text); // CARAC_SERV
    strInsere := strInsere + ', ' + QuotedStr(edtFuncEmi.Text); // FUNC_EMI

    strInsere := strInsere + ', ' + IntToStr(rgRetira.ItemIndex);  //
    strInsere := strInsere + ', ' + QuotedStr(memDetRetira.Text);


    val0 := 0;
    if (dbValTotPrest.Field.Value <> null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      val0 := dbValTotPrest.Field.Value;
      FormatSettings.DecimalSeparator := '.';
    end;
    strInsere := strInsere + ', '  + FloatToStr(val0) ; //+ Format('%8.2f', [valTotPrest.Value]);

    val0 := 0;
    if (dbValReceber.Field.Value <> null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      val0 := dbValReceber.Field.Value;
      FormatSettings.DecimalSeparator := '.';
    end;
    strInsere := strInsere + ', '  + FloatToStr(val0) ; //+ Format('%8.2f', [valReceber.Value]);

    val0 := 0;
    if (dbValTotTri.Field.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      val0 := dbValTotTri.Field.Value;
      FormatSettings.DecimalSeparator := '.';
    end;
    strInsere := strInsere + ', '  + FloatToStr(val0) ; //+ Format('%8.2f', [valTotTri.Value]);


    strInsere := strInsere + ', ' + QuotedStr(combCodSitTrib.ItemIndex.ToString); //COMBCODSITTRIB

    val1 := 0;
    if (dbValInfCarga.Field.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      val1 := dbValInfCarga.Field.Value;
      FormatSettings.DecimalSeparator := '.';
    end;
    strInsere := strInsere + ', ' + FloatToStr(val1) ;  // VAL TOTAL DA CARGA

    strInsere := strInsere + ', ' + QuotedStr(edtProPred.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtOutCat.Text);

    strInsere := strInsere + ', ' + QuotedStr(edtRodRNTRC.Text);
    strInsere := strInsere + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',dataRodPrev.date));
    strInsere := strInsere + ', ' + IntToStr(rgRodLotacao.ItemIndex);

    strInsere := strInsere + ', ' + QuotedStr(memxObs.Text);

    // outros docs

  val1 := 0;
    if (valOutrosVal.Value <> Null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      val1 := valOutrosVal.Value;
      FormatSettings.DecimalSeparator := '.';
    end;


    strInsere := strInsere + ', ' + QuotedStr(combOutrosDocs.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtOutrosDesc.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtOutrosNum.Text);
    strInsere := strInsere + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',dataRodPrev.date));
    strInsere := strInsere + ', ' + FloatToStr(val1); // FloatToStr(valOutrosVal.Value);


//, OUTPDOC                VARCHAR( 2 )
//, OUDESCOUTRO            VARCHAR( 100 )
//, OUNDOC                 VARCHAR( 20 )
//, OUDEMI                 TIMESTAMP
//, OUVDOCFISC             DOUBLE PRECISION

    // Esse é o ultimo Campo do Insert ' EMITENTE'
    strInsere := strInsere + ', ' + QuotedStr(edtCodEmitente.Text);


   // docs anterior 15/08/19

    strInsere := strInsere + ', ' + QuotedStr(edtAntCNPJ.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtAntIE.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtAntUF.Text );
    strInsere := strInsere + ', ' + QuotedStr(edtAntNome.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtAntCHCTE.Text);

    // impostos  , VALPREDBC,VALVBC,VALPICMS,VALVICMS,VALVCRED

    pVALPREDBC := 0;
    if (dbVALPREDBC.Field.Value <> null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALPREDBC := dbVALPREDBC.Field.Value;
      FormatSettings.DecimalSeparator := '.';
    end;
    strInsere := strInsere + ', '  + FloatToStr(pVALPREDBC) ;

    pVALVBC := 0;
    if (dbVALVBC.Field.Value <> null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALVBC := dbVALVBC.Field.Value;
      FormatSettings.DecimalSeparator := '.';
    end;
    strInsere := strInsere + ', '  + FloatToStr(pVALVBC) ;

    pVALPICMS := 0;
    if (dbVALPICMS.Field.Value <> null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALPICMS := dbVALPICMS.Field.Value;
      FormatSettings.DecimalSeparator := '.';
    end;
    strInsere := strInsere + ', '  + FloatToStr(pVALPICMS) ;

    pVALVICMS := 0;
    if (dbVALVICMS.Field.Value <> null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALVICMS := dbVALVICMS.Field.Value;
      FormatSettings.DecimalSeparator := '.';
    end;
    strInsere := strInsere + ', '  + FloatToStr(pVALVICMS) ;


    pVALVCRED := 0;
    if (dbVALVCRED.Field.Value <> null) then
    begin
      FormatSettings.DecimalSeparator := ',';
      pVALVCRED := dbVALVCRED.Field.Value;
      FormatSettings.DecimalSeparator := '.';
    end;
    strInsere := strInsere + ', '  + FloatToStr(pVALVCRED) ;



   // strInsere := strInsere + ', ' + FloatToStr(dbVALPREDBC.Field.Value);
   // strInsere := strInsere + ', ' + FloatToStr(dbVALVBC.Field.Value);
   // strInsere := strInsere + ', ' + FloatToStr(dbVALPICMS.Field.Value);
   // strInsere := strInsere + ', ' + FloatToStr(dbVALVCRED.Field.Value);
   // strInsere := strInsere + ', ' + FloatToStr(dbVALVCRED.Field.Value);

    strInsere := strInsere + ')';

    MemoDados.Text := strInsere;
    result := strInsere;
  end
  else
    result := '1';

  FormatSettings.DecimalSeparator := ',';
end;


end.
