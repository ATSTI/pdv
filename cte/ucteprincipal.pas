unit uCtePrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Menus, Buttons, DBGrids, EditBtn, Spin, DBCtrls, ZConnection,
  ZDataset, DateTimePicker, Types, IniFiles, ACBrCTe, ACBrCTeDACTEClass,
  ACBrCTeDACTeRLClass, ACBrMail, ACBrBase, ACBrDFe, ACBrNFe, pcnConversao,
  pcteConversaoCTe, DateUtils, ACBrUtil, db, ACBrDFeSSL;

type

  { TfCTePrincipal }

  TfCTePrincipal = class(TForm)
    ACBrCTe1: TACBrCTe;
    ACBrCTe2: TACBrCTe;
    ACBrCTeDACTeRL1: TACBrCTeDACTeRL;
    ACBrNFe1: TACBrNFe;
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    btnEditarNFe1: TBitBtn;
    btnExcluirNFe1: TBitBtn;
    btnGerarCte1: TBitBtn;
    btnGravarCTe1: TBitBtn;
    btnIncluirNFe1: TBitBtn;
    btnInserirvNfe: TButton;
    btnLimpaBusca: TBitBtn;
    btnConsCad: TButton;
    btnConsultar: TButton;
    btnConsultarChave: TButton;
    btnConsultarRecibo: TButton;
    btnEnviarEmail: TBitBtn;
    btnGerar: TBitBtn;
    btnGerarPDF: TBitBtn;
    btnGerarPDFEvento: TBitBtn;
    btnGerarPDFInut: TBitBtn;
    btnImprimir: TButton;
    btnImprimirEvento: TBitBtn;
    btnImprimirInut: TBitBtn;
    btnInutilizar: TBitBtn;
    btnCancelarCte: TBitBtn;
    btnCorrigirSerie: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn9: TBitBtn;
    btnAtualizarBD: TButton;
    btnCC: TButton;
    btnDuplicar: TBitBtn;
    btnEditarComp: TBitBtn;
    btnEditarCte: TBitBtn;
    btnEditarNFe: TBitBtn;
    btnEnvEPEC: TBitBtn;
    btnEnviarEventoEmail: TBitBtn;
    btnExcluirComp: TBitBtn;
    btnExcluirNFe: TBitBtn;
    btnSair: TBitBtn;
    BitBtn2: TBitBtn;
    btnGravarCTe: TBitBtn;
    btnCancelarEdicaoCTe: TBitBtn;
    btnImportarXML: TBitBtn;
    btnImportarXML1: TButton;
    btnIncCte: TBitBtn;
    btnIncluirNFe: TBitBtn;
    btnInfCargaEdita: TBitBtn;
    btnInfCargaEdita1: TBitBtn;
    btnInfCargaExclui: TBitBtn;
    btnInfCargaExclui1: TBitBtn;
    btnInfCargaInclui: TBitBtn;
    btnInfCargaInclui1: TBitBtn;
    btnListarCte: TBitBtn;
    btnProximo: TBitBtn;
    btnProximo1: TBitBtn;
    btnProximo10: TBitBtn;
    btnProximo2: TBitBtn;
    btnProximo3: TBitBtn;
    btnProximo4: TBitBtn;
    btnProximo5: TBitBtn;
    btnProximo6: TBitBtn;
    btnProximo7: TBitBtn;
    btnProximo8: TBitBtn;
    btnProximo9: TBitBtn;
    btnStatusServ: TButton;
    btnValidarXML: TButton;
    btnVeicEditar: TBitBtn;
    btnVeicEditar1: TBitBtn;
    btnVeicExcluir: TBitBtn;
    btnVeicExcluir1: TBitBtn;
    btnVeicIncluir: TBitBtn;
    btnVeicIncluir1: TBitBtn;
    btnInsertComp: TButton;
    btnInserirQC: TButton;
    Button30: TButton;
    calValB: TDBEdit;
    cbCryptLib: TComboBox;
    cbEmailSSL: TCheckBox;
    cbHttpLib: TComboBox;
    cbSSLLib: TComboBox;
    cbSSLType: TComboBox;
    cbUF: TComboBox;
    cbVersaoDF: TComboBox;
    cbXmlSignLib: TComboBox;
    CheckBox1: TCheckBox;
    ckSalvar: TCheckBox;
    ckVisualizar: TCheckBox;
    combCodSitTrib: TComboBox;
    combICMSDevido: TComboBox;
    comboEmpresa: TComboBox;
    combOutrosDocs: TComboBox;
    dataGerarCte: TDateTimePicker;
    dataEmissaoCte: TDateTimePicker;
    dataOutrosEmi: TDateTimePicker;
    dataRodPrev: TDateTimePicker;
    DataSource1: TDataSource;
    DSZqsQC: TDataSource;
    DSZsqcomp: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    dbSeguroNome: TDBEdit;
    dbSeguroApolice: TDBEdit;
    dbSeguroAverbacao: TDBEdit;
    dbSeguroValor: TDBEdit;
    DSZsqNFe: TDataSource;
    edCteCancelar: TLabeledEdit;
    edInutNumeroIni: TEdit;
    edInutNumeroFim: TEdit;
    edInutAno: TEdit;
    edInutModelo: TEdit;
    edInutSerie: TEdit;
    edInutJustificativa: TEdit;
    Edit1: TEdit;
    edtComp: TEdit;
    edtQC: TEdit;
    edModeloAtualiza: TEdit;
    edSerieAtualiza: TEdit;
    edtAntCHNFE: TEdit;
    edtAntCHCTEAnula: TEdit;
    edtCaminho: TEdit;
    edtCfop1: TEdit;
    edtDestNome1: TEdit;
    edtEmailAssunto: TEdit;
    edtEnvCidade1: TEdit;
    edtEnvCodCidade1: TEdit;
    edtEnvUF1: TEdit;
    edtFimCidade1: TEdit;
    edtFimCodCidade1: TEdit;
    edtFimUF1: TEdit;
    edtIniCidade1: TEdit;
    edtIniCodCidade1: TEdit;
    edtIniUF1: TEdit;
    edtLogoMarca: TEdit;
    edtCteImportar: TEdit;
    edtNatOpe1: TEdit;
    edtNumCte1: TEdit;
    edtPathLogs: TEdit;
    edtSenha: TEdit;
    edtSmtpHost: TEdit;
    edtSmtpPass: TEdit;
    edtSmtpPort: TEdit;
    edtSmtpUser: TEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    dbGridComp: TDBGrid;
    DBGridNFe: TDBGrid;
    dbGridQC: TDBGrid;
    dbValInfCarga: TDBEdit;
    dbValInfCarga13: TEdit;
    dbValInfCarga16: TEdit;
    dbValInfCarga17: TEdit;
    dbValPIcms: TDBEdit;
    dbValpRedBC: TDBEdit;
    dbValReceber: TDBEdit;
    dbValTotPrest: TDBEdit;
    dbValTotTri: TDBEdit;
    dbValvBC: TDBEdit;
    dbValVCred: TDBEdit;
    dbValVICMS: TDBEdit;
    dgGridCTE: TDBGrid;
    edtAntCHCTE: TEdit;
    edtAntCNPJ: TEdit;
    edtAntIE: TEdit;
    edtAntNome: TEdit;
    edtAntUF: TEdit;
    edtBairroTomador: TEdit;
    edtBuscaTomador: TEdit;
    edtCaracAdServ: TEdit;
    edtCaracAdTrans: TEdit;
    edtCepTomador: TEdit;
    edtCfop: TEdit;
    edtCNPJTomador: TEdit;
    edtCodEmitente: TEdit;
    edtCompTomador: TEdit;
    edtDestBairro: TEdit;
    edtDestBusca: TEdit;
    edtDestCEP: TEdit;
    edtDestCidade: TEdit;
    edtDestCNPJ: TEdit;
    edtDestCodCidade: TEdit;
    edtDestComp: TEdit;
    edtDestEnd: TEdit;
    edtDestFone: TEdit;
    edtDestIE: TEdit;
    edtDestISUF: TEdit;
    edtDestNome: TEdit;
    edtDestNum: TEdit;
    edtDestRazao: TEdit;
    edtDestUF: TEdit;
    edtEmitBairro: TEdit;
    edtEmitCEP: TEdit;
    edtEmitCidade: TEdit;
    edtEmitCNPJ: TEdit;
    edtEmitCodCidade: TEdit;
    edtEmitComp: TEdit;
    edtEmitenteCte: TEdit;
    edtEmitFantasia: TEdit;
    edtEmitFone: TEdit;
    edtEmitIE: TEdit;
    edtEmitLogradouro: TEdit;
    edtEmitNumero: TEdit;
    edtEmitRazao: TEdit;
    edtEmitUF: TEdit;
    edtEndTomador: TEdit;
    edtEnvCidade: TEdit;
    edtEnvCodCidade: TEdit;
    edtEnvUF: TEdit;
    edtExpBairro: TEdit;
    edtExpBusca: TEdit;
    edtExpCep: TEdit;
    edtExpCidade: TEdit;
    edtExpCNPJ: TEdit;
    edtExpCodCidade: TEdit;
    edtExpComp: TEdit;
    edtExpEnd: TEdit;
    edtExpFone: TEdit;
    edtExpIE: TEdit;
    edtExpNome: TEdit;
    edtExpNum: TEdit;
    edtExpRazao: TEdit;
    edtExpUF: TEdit;
    edtFimCidade: TEdit;
    edtFimCodCidade: TEdit;
    edtFimUF: TEdit;
    edtFoneTomador: TEdit;
    edtFuncEmi: TEdit;
    edtIETomador: TEdit;
    edtIniCidade: TEdit;
    edtIniCodCidade: TEdit;
    edtIniUF: TEdit;
    edtModelo: TEdit;
    edtNatOpe: TEdit;
    edtNomeTomador: TEdit;
    edtNumCte: TEdit;
    edtCceChave: TEdit;
    edtCceGrupo: TEdit;
    edtCceSequencia: TEdit;
    edtCceTextoVelho: TEdit;
    edtCceTextoNovo: TEdit;
    edtCceNumItem: TEdit;
    edtCteReferenciada: TEdit;
    edtNumSerie: TEdit;
    edtNumTomador: TEdit;
    edtOutCat: TEdit;
    edtOutrosDesc: TEdit;
    edtOutrosNum: TEdit;
    edtProPred: TEdit;
    edtRazaoTomador: TEdit;
    edtRecBairro: TEdit;
    edtRecBusca: TEdit;
    edtRecCep: TEdit;
    edtRecCidade: TEdit;
    edtRecCNPJ: TEdit;
    edtRecCodCidade: TEdit;
    edtRecComp: TEdit;
    edtRecEnd: TEdit;
    edtRecFone: TEdit;
    edtRecIE: TEdit;
    edtRecNome: TEdit;
    edtRecNum: TEdit;
    edtRecRazao: TEdit;
    edtRecUF: TEdit;
    edtRemBairro: TEdit;
    edtRemBusca: TEdit;
    edtRemCep: TEdit;
    edtRemCidade: TEdit;
    edtRemCNPJ: TEdit;
    edtRemCodCidade: TEdit;
    edtRemComp: TEdit;
    edtRemEnd: TEdit;
    edtRemFone: TEdit;
    edtRemIE: TEdit;
    edtRemNome: TEdit;
    edtRemNum: TEdit;
    edtRemRazao: TEdit;
    edtRemUF: TEdit;
    edtRodRNTRC: TEdit;
    edtSerieCte: TEdit;
    edtTomadorCidade: TEdit;
    edtTomadorCodCidade: TEdit;
    edtTomadorUF: TEdit;
    edtXMLBairro: TEdit;
    edtXMLCEP: TEdit;
    edtXMLCidade: TEdit;
    edtXMLCnpj: TEdit;
    edtXMLCod: TEdit;
    edtXMLCodCidade: TEdit;
    edtXMLComp: TEdit;
    edtXMLFone: TEdit;
    edtXMLIE: TEdit;
    edtXMLLogradouro: TEdit;
    edtXMLNome: TEdit;
    edtXMLNumero: TEdit;
    edtXMLRazao: TEdit;
    edtXMLUF: TEdit;
    edUltimoAtualiza: TEdit;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    GroupBox15: TGroupBox;
    GroupBox16: TGroupBox;
    GroupBox17: TGroupBox;
    GroupBox18: TGroupBox;
    GroupBox19: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox20: TGroupBox;
    GroupBox21: TGroupBox;
    GroupBox22: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    GroupBoxDestinatario: TGroupBox;
    GroupBoxExpeditor: TGroupBox;
    GroupBoxRecebedor: TGroupBox;
    GroupBoxRemetente: TGroupBox;
    GroupBoxTomador: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label11: TLabel;
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
    Label12: TLabel;
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
    Label13: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label14: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    Label15: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    Label159: TLabel;
    Label16: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    Label174: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    Label179: TLabel;
    Label180: TLabel;
    lblCteAtual: TLabel;
    Label17: TLabel;
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
    Label9: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    lblCteAtual1: TLabel;
    lblDetRetira: TStaticText;
    lblDetRetira1: TStaticText;
    lblEmailAssunto: TLabel;
    lCryptLib: TLabel;
    lHttpLib: TLabel;
    lSSLLib: TLabel;
    lSSLLib1: TLabel;
    lXmlSign: TLabel;
    memDetRetira: TMemo;
    memInfAdFisco: TMemo;
    edtnfe: TMemo;
    MemoDados: TMemo;
    memoResp: TMemo;
    memoRespWS: TMemo;
    memxObs: TMemo;
    mmEmailMsg: TMemo;
    OpenDialog1: TOpenDialog;
    btnPreVisu: TBitBtn;
    BitBtn8: TBitBtn;
    btnGerarCte: TBitBtn;
    PageControl3: TPageControl;
    PageControl4: TPageControl;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pcCte: TPageControl;
    pcPrincipal: TPageControl;
    rbAlteradoTomador: TRadioButton;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    rgForPag1: TRadioGroup;
    rgSeguroResp: TRadioGroup;
    rgDest: TRadioGroup;
    rgExp: TRadioGroup;
    rgFormaEmissao: TRadioGroup;
    rgForPag: TRadioGroup;
    rgGlobalizado: TRadioGroup;
    rgModal: TRadioGroup;
    rgRec: TRadioGroup;
    rgRem: TRadioGroup;
    rgRetira: TRadioGroup;
    rgRodLotacao: TRadioGroup;
    rgTipoAmb: TRadioGroup;
    rgTipoDACTe: TRadioGroup;
    rgTiposCte: TRadioGroup;
    rgTipoServico: TRadioGroup;
    rgTipoServico1: TRadioGroup;
    rgTomador: TRadioGroup;
    sbtnCaminhoCert: TSpeedButton;
    sbtnLerXmlCte: TSpeedButton;
    sbtnLerXmlCte1: TSpeedButton;
    sbtnLogoMarca: TSpeedButton;
    sbtnGetCert: TSpeedButton;
    sbtnCteImportar: TSpeedButton;
    sbtnPathSalvar: TSpeedButton;
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
    StaticText30: TStaticText;
    StaticText4: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StatusBar1: TStatusBar;
    Label18: TLabel;
    Panel1: TPanel;
    TabCte: TTabSheet;
    TabCteGeradas: TTabSheet;
    TabDados: TTabSheet;
    TabDadosComplementares: TTabSheet;
    TabDadosCte: TTabSheet;
    TabDestinatario: TTabSheet;
    TabExpedidor: TTabSheet;
    TabInfoCarga: TTabSheet;
    TabNfe: TTabSheet;
    TabRecebedor: TTabSheet;
    TabRodoviario: TTabSheet;
    TabServicosImpostos: TTabSheet;
    tabSeguro: TTabSheet;
    TabSheet1: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    TabSheet19: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet20: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet6: TTabSheet;
    TabTomador: TTabSheet;
    valAliIn: TDBEdit;
    valAliInter: TEdit;
    valICMSPartI: TEdit;
    valIMCSPartF: TEdit;
    valOutrosVal: TDBEdit;
    ZConn: TZConnection;
    ZQuery1: TZQuery;
    ZQuery1RAZAO: TStringField;
    ZsqQC: TZQuery;
    ZsqQCCOD_CTE: TLongintField;
    ZsqQCCOD_CTE_QC: TLongintField;
    ZsqQCMEDIDA: TStringField;
    ZsqComp: TZQuery;
    ZsqCompCOD_CTE: TLongintField;
    ZsqCompCOD_CTE_COMP: TLongintField;
    ZsqCompCOMP_NOME: TStringField;
    ZsqCompCOMP_VALOR: TFloatField;
    ZsqQCQUANT: TFloatField;
    ZsqQCUNID: TStringField;
    ZsqQCUNIDADE: TStringField;
    ZsqGenerator: TZQuery;
    ZsqNFe: TZQuery;
    ZsqNFeCHAVE: TStringField;
    ZsqNFeCOD_CTE_NFE: TLongintField;
    ZsqNFeCTE_NFE: TLongintField;
    ZsqNFeDPREV: TDateField;
    ZsqNFePIN: TLongintField;
    function busca_generator(generator: String): integer;
    procedure ACBrCTe1StatusChange(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure btnCCClick(Sender: TObject);
    procedure btnEditarNFe1Click(Sender: TObject);
    procedure btnExcluirNFe1Click(Sender: TObject);
    procedure btnGerarCte1Click(Sender: TObject);
    procedure btnGravarCTe1Click(Sender: TObject);
    procedure btnImportarXML1Click(Sender: TObject);
    procedure btnIncluirNFe1Click(Sender: TObject);
    procedure btnInserirQCClick(Sender: TObject);
    procedure btnInserirvNfeClick(Sender: TObject);
    procedure btnLimpaBuscaClick(Sender: TObject);
    procedure btnProximo10Click(Sender: TObject);
    procedure btnProximo1Click(Sender: TObject);
    procedure btnProximo2Click(Sender: TObject);
    procedure btnProximo3Click(Sender: TObject);
    procedure btnProximo4Click(Sender: TObject);
    procedure btnProximo5Click(Sender: TObject);
    procedure btnProximo6Click(Sender: TObject);
    procedure btnProximo7Click(Sender: TObject);
    procedure btnProximo8Click(Sender: TObject);
    procedure btnProximo9Click(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure btnEditarNFeClick(Sender: TObject);
    procedure btnExcluirNFeClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnGerarPDFInutClick(Sender: TObject);
    procedure btnCancelarEdicaoCTeClick(Sender: TObject);
    procedure btnImprimirInutClick(Sender: TObject);
    procedure btnInfCargaEditaClick(Sender: TObject);
    procedure btnInfCargaExcluiClick(Sender: TObject);
    procedure btnInfCargaGravaClick(Sender: TObject);
    procedure btnInfCargaIncluiClick(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure btnAtualizarBDClick(Sender: TObject);
    procedure btnCancelarCteClick(Sender: TObject);
    procedure btnCorrigirSerieClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnEnviarEventoEmailClick(Sender: TObject);
    procedure btnExcluirCompClick(Sender: TObject);
    procedure btnConsCadClick(Sender: TObject);
    procedure btnConsultarChaveClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnConsultarReciboClick(Sender: TObject);
    procedure btnDuplicarClick(Sender: TObject);
    procedure btnEditarCompClick(Sender: TObject);
    procedure btnEditarCteClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnGerarCteClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnGerarPDFEventoClick(Sender: TObject);
    procedure btnGravarCTeClick(Sender: TObject);
    procedure btnImportarXMLClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnImprimirEventoClick(Sender: TObject);
    procedure btnIncCteClick(Sender: TObject);
    procedure btnIncluirNFeClick(Sender: TObject);
    procedure btnInutilizarClick(Sender: TObject);
    procedure btnListarCteClick(Sender: TObject);
    procedure btnPreVisuClick(Sender: TObject);
    procedure btnStatusServClick(Sender: TObject);
    procedure btnValidarXMLClick(Sender: TObject);
    procedure btnVeicEditarClick(Sender: TObject);
    procedure btnVeicExcluirClick(Sender: TObject);
    procedure btnVeicIncluirClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure btnInsertCompClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbSSLTypeChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure comboEmpresaChange(Sender: TObject);
    procedure dbGridCompCellClick(Column: TColumn);
    procedure dbGridQCCellClick(Column: TColumn);
    procedure dbValInfCargaChange(Sender: TObject);
    procedure dbValReceberChange(Sender: TObject);
    procedure dbValTotPrestChange(Sender: TObject);
    procedure dbValTotPrestExit(Sender: TObject);
    procedure dbValTotPrestKeyPress(Sender: TObject; var Key: char);
    procedure dbValTotTriChange(Sender: TObject);
    procedure dgGridCTEDblClick(Sender: TObject);
    procedure edtBuscaTomadorExit(Sender: TObject);
    procedure edtCfopExit(Sender: TObject);
    procedure edtCompChange(Sender: TObject);
    procedure edtCteImportarClick(Sender: TObject);
    procedure edtDestBuscaExit(Sender: TObject);
    procedure edtDestNome1Change(Sender: TObject);
    procedure edtDestNome1KeyPress(Sender: TObject; var Key: char);
    procedure edtEmitCompChange(Sender: TObject);
    procedure edtEmitenteCteChange(Sender: TObject);
    procedure edtExpBuscaExit(Sender: TObject);
    procedure edtRecBuscaExit(Sender: TObject);
    procedure edtRemBuscaExit(Sender: TObject);
    procedure edtXMLCodChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure Label120Click(Sender: TObject);
    procedure Label138Click(Sender: TObject);
    procedure Label155Click(Sender: TObject);
    procedure Label176Click(Sender: TObject);
    procedure Label60Click(Sender: TObject);
    procedure mmEmailMsgChange(Sender: TObject);
    procedure pcCteChange(Sender: TObject);
    procedure pcCteChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pcPrincipalChange(Sender: TObject);
    procedure rgDestClick(Sender: TObject);
    procedure rgExpClick(Sender: TObject);
    procedure rgFormaEmissaoClick(Sender: TObject);
    procedure rgRecClick(Sender: TObject);
    procedure rgRemClick(Sender: TObject);
    procedure rgTomadorClick(Sender: TObject);
    procedure sbtnCaminhoCertClick(Sender: TObject);
    procedure sbtnCteImportarClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure sbtnLerXmlCteClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
    procedure StaticText13Click(Sender: TObject);
    procedure StaticText22Click(Sender: TObject);
    procedure StaticText7Click(Sender: TObject);
    procedure TabCteGeradasContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabCteGeradasShow(Sender: TObject);
    procedure TabDadosComplementaresShow(Sender: TObject);
    procedure TabDadosCteShow(Sender: TObject);
    procedure TabExpedidorShow(Sender: TObject);
    procedure TabInfoCargaShow(Sender: TObject);
    procedure TabNfeShow(Sender: TObject);
    procedure TabRecebedorShow(Sender: TObject);
    procedure TabRodoviarioShow(Sender: TObject);
    procedure TabServicosImpostosContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure TabServicosImpostosShow(Sender: TObject);
    procedure TabSheet11Show(Sender: TObject);
    procedure TabSheet12ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabInfoCargaContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabDestinatarioShow(Sender: TObject);
    procedure TabSheet2ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabTomadorShow(Sender: TObject);
  private
    vModeloCTe : integer;
    ver_cod_cte: Integer;
    vCteStr: String;
    modoGravacao : string;
    modoInicio: String;
    val_genCte : integer;
    val0 , val1, val2, percentualFrete,valordokilo ,pqCarga , pvalordokilo: Double;
    valC :string;
    strInsere : string;
    generetor : integer;
    pVALPREDBC,pVALVBC,pVALPICMS,pVALVICMS,pVALVCRED : Double;
    percent_icms: Double;
    vDup : integer;
    cfop_padrao: String;
    nat_padrao: String;
    rntrc_padrao: String;
    carga_prodpre: String;
    carga_desc: String;
    carga_un : String;
    componente_nome: String;
    pCompExclui : String;
    pQCExclui : String;
    pvNfeExclui : String;
    naoexecuta : integer;
    procedure GravarConfiguracao;
    procedure DadosBasicos;
    procedure LerConfiguracao;
    procedure EditarRe;
    procedure GerarCTe(NumCTe : String);
    procedure buscaEmpresa(Razao: String);
    procedure CarregarUF;
    procedure duplicar(velhaCte: String);
    procedure CarregarCte(NumCte: String);
    procedure CarregarXML(ChaveCte: String);
    procedure CarregarAcbr;
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
    procedure EditarDE;
    procedure EditarREC;
    procedure cadastraClientes(camposCliente, camposEnd: String);
    procedure buscaDestinatario;
    procedure buscaTomador;
    procedure buscaRemetente;
    procedure buscaExpedidor;
    procedure buscaRecebedor;
    function LimparString(ATExto, ACaracteres: string): string;
    function GravarCTe: String;
    procedure AtualizaSSLLibsCombo;
  public

  end;

var
  fCTePrincipal: TfCTePrincipal;
const
  SELDIRHELP = 1000;

implementation

uses udmpdv, ufrmStatus, uDmCte, uNFe, uCompValor, uQuantCarga, uVeiculoCte,
  uClienteBusca, umunicipiobusca, uCertificadoLer,TypInfo, blcksock;

{$R *.lfm}

{ TfCTePrincipal }


procedure TfCTePrincipal.StaticText7Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.TabCteGeradasContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TfCTePrincipal.TabCteGeradasShow(Sender: TObject);
begin
end;

procedure TfCTePrincipal.TabDadosComplementaresShow(Sender: TObject);
begin
  //edtCaracAdTrans.SetFocus;
end;

procedure TfCTePrincipal.TabDadosCteShow(Sender: TObject);
begin

end;

procedure TfCTePrincipal.TabExpedidorShow(Sender: TObject);
begin
  //edtExpBusca.SetFocus;
end;

procedure TfCTePrincipal.TabInfoCargaShow(Sender: TObject);
begin
 {
  if (modoGravacao = 'INCLUIR') then
  begin
    btnGravarCTe.Click;
  end;
  dbValInfCarga.SetFocus;
  if(edtNumCte.Text <> '') then
  begin
    if not(dmCte.sqQC.Active)then
      dmCte.sqQC.Active;
    dmCte.sqQC.Params[0].AsInteger := val_genCte;
    dmCte.sqQC.Open;
  end;
  }
 if (ZsqQC.Active)then
   ZsqQC.Close;
 ZsqQC.Params[0].AsInteger := val_genCte;
 ZsqQC.Open;

end;

procedure TfCTePrincipal.TabNfeShow(Sender: TObject);
begin
  {
  if(edtNumCte.Text <> '') then
  begin
    if not(dmCte.sqNFe.Active)then
      dmCte.sqNFe.Active;
    dmCte.sqNFe.Params[0].AsInteger := val_genCte;
    dmCte.sqNFe.Open;
  end;
  }
  if (ZsqNFe.Active)then
    ZsqNFe.Close;
  ZsqNFe.Params[0].AsInteger := val_genCte;
  ZsqNFe.Open;
end;

procedure TfCTePrincipal.TabRecebedorShow(Sender: TObject);
begin
  //edtRecBusca.SetFocus;
end;

procedure TfCTePrincipal.TabRodoviarioShow(Sender: TObject);
begin
  //edtRodRNTRC.SetFocus;
end;

procedure TfCTePrincipal.TabServicosImpostosContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TfCTePrincipal.TabServicosImpostosShow(Sender: TObject);
begin
  {
  if(modoGravacao = 'INCLUIR')then
 begin
   btnGravarCTe.Click;
 end;
 //Lazarus-Cte

 if(edtNumCte.Text <> '') then
 begin
   if not(dm.qCOMP.Active)then
     dm.qCOMP.Active;
   dm.qCOMP.Params[0].AsInteger := val_genCte;
   dm.qCOMP.Open;
 end;

 CheckBox1.Enabled := False;
 calValB.Enabled := False;
 valAliIn.Enabled := False;
 valAliInter.Enabled := False;
 valICMSPartI.Enabled := False;
 valIMCSPartF.Enabled := False;
 //Lazarus-Cte
 //valCombIni.Enabled := False;
 //valCombFim.Enabled := False;
 }

end;

procedure TfCTePrincipal.TabSheet11Show(Sender: TObject);
begin

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
  //edtDestBusca.SetFocus;
end;

procedure TfCTePrincipal.TabSheet2ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TfCTePrincipal.TabTomadorShow(Sender: TObject);
begin
  //edtBuscaTomador.SetFocus;
end;

procedure TfCTePrincipal.GravarConfiguracao;
var
  IniFile    : String;
  Ini        : TIniFile;
  StreamMemo : TMemoryStream;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini');
  Ini := TIniFile.Create( IniFile );
  try
    Ini.WriteString( 'Certificado','Caminho' ,edtCaminho.Text);
    Ini.WriteString( 'Certificado','Senha'   ,edtSenha.Text);
    Ini.WriteString( 'Certificado','NumSerie',edtNumSerie.Text);

    Ini.WriteInteger( 'Certificado','SSLLib' , cbSSLLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','CryptLib' , cbCryptLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','HttpLib' , cbHttpLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','XmlSignLib' , cbXmlSignLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','SSLType' , cbSSLType.ItemIndex) ;

    Ini.WriteInteger( 'Geral','DACTE'       ,rgTipoDACTe.ItemIndex);
    Ini.WriteInteger( 'Geral','FormaEmissao',rgFormaEmissao.ItemIndex);
    Ini.WriteInteger( 'Geral','TipoServico',rgTipoServico.ItemIndex);
    Ini.WriteInteger( 'Geral','TipoCTe',rgTiposCte.ItemIndex);
    Ini.WriteString( 'Geral', 'CFOPCTe'  , edtCfop.Text);
    Ini.WriteString( 'Geral', 'NatOpeCTe'  , edtNatOpe.Text);
    Ini.WriteString( 'Geral', 'RNTRC'  , edtRodRNTRC.Text);
    Ini.WriteInteger('Geral','TipoTomador', rgTomador.ItemIndex);
    Ini.WriteInteger('Geral','TipoDestinatario', rgDest.ItemIndex);
    Ini.WriteInteger('Geral','TipoRemetente', rgRem.ItemIndex);
    Ini.WriteInteger('Geral','TipoRecebedor', rgRec.ItemIndex);
    Ini.WriteInteger('Geral','TipoExpedidor', rgExp.ItemIndex);

    Ini.WriteInteger('Geral','CodSitTributario',combCodSitTrib.ItemIndex);

    if (edtModelo.Text <> '') then
      Ini.WriteInteger( 'Geral','ModeloCTe', StrToInt(Trim(edtModelo.Text)));
    Ini.WriteString( 'Geral','LogoMarca'   ,edtLogoMarca.Text);
    Ini.WriteBool(   'Geral','Salvar'      ,ckSalvar.Checked);
    Ini.WriteString( 'Geral','PathSalvar'  ,edtPathLogs.Text);
    Ini.WriteString( 'Geral','PathCTe'  ,edtCteImportar.Text);

    Ini.WriteString( 'Carga','ProdutoPredominante', edtProPred.Text);
    Ini.WriteString( 'Carga','DescricaoQuantidade', carga_desc);
    Ini.WriteString( 'Carga','UnidadeMedida', carga_un);
    Ini.WriteString( 'Componente','Descricao', componente_nome);

    Ini.WriteString( 'WebService','UF'        ,Trim(cbUF.Text));
    Ini.WriteInteger( 'WebService','Ambiente'  ,rgTipoAmb.ItemIndex);
    Ini.WriteBool(   'WebService','Visualizar',ckVisualizar.Checked);

    //Ini.WriteString( 'Proxy','Host'   ,edtProxyHost.Text);
    //Ini.WriteString( 'Proxy','Porta'  ,edtProxyPorta.Text);
    //Ini.WriteString( 'Proxy','User'   ,edtProxyUser.Text);
    //Ini.WriteString( 'Proxy','Pass'   ,edtProxySenha.Text);

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
    edtEmitCodCidade.Text:= dmPdv.sqEmpresaCD_IBGE.AsString;
    edtEmitCidade.Text   := dmPdv.sqEmpresaCIDADE.AsString;
    edtEmitUF.Text       := dmPdv.sqEmpresaUF.AsString;

    edtEnvUF.Text := dmPdv.sqEmpresaUF.AsString;
    edtEnvCodCidade.Text := dmPdv.sqEmpresaCD_IBGE.AsString;
    edtEnvCidade.Text := dmPdv.sqEmpresaCIDADE.AsString;

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
 StreamMemo : TMemoryStream;
 Margem_ver : Double;
begin
 IniFile := ChangeFileExt( Application.ExeName, '.ini');

 Ini := TIniFile.Create( IniFile );
 try
   edtCaminho.Text  := Ini.ReadString( 'Certificado','Caminho' ,'');
   edtSenha.Text    := Ini.ReadString( 'Certificado','Senha'   ,'');
   ACBrCTe1.Configuracoes.Certificados.ArquivoPFX := edtCaminho.Text;
   ACBrCTe1.Configuracoes.Certificados.Senha := edtSenha.Text;

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
   ACBrCte1.DACTE := ACBrCTeDACTeRL1;
   ACBrCTeDACTeRL1.ACBrCTE := ACBrCTe1;
   //edtNumSerie.Text := ACBrCTe1.Configuracoes.Certificados.NumeroSerie;
   {Label1.Caption := 'Informe o número de série do certificado'#13+
                     'Disponível no Internet Explorer no menu'#13+
                     'Ferramentas - Opções da Internet - Conteúdo '#13+
                     'Certificados - Exibir - Detalhes - '#13+
                     'Número do certificado';}
   //Label2.Visible     := False;
   //edtCaminho.Visible := False;
   //edtSenha.Visible   := False;
   //sbtnCaminhoCert.Visible := False;
  {$ENDIF}
  cbSSLLib.ItemIndex:= Ini.ReadInteger( 'Certificado','SSLLib' ,0) ;
  cbCryptLib.ItemIndex := Ini.ReadInteger( 'Certificado','CryptLib' , 0) ;
  cbHttpLib.ItemIndex := Ini.ReadInteger( 'Certificado','HttpLib' , 0) ;
  cbXmlSignLib.ItemIndex := Ini.ReadInteger( 'Certificado','XmlSignLib' , 0) ;
  cbSSLType.ItemIndex    := Ini.ReadInteger( 'Certificado','SSLType' , 0) ;
  rgFormaEmissao.ItemIndex := Ini.ReadInteger('Geral','FormaEmissao',0);
  rgTomador.ItemIndex := Ini.ReadInteger('Geral','TipoTomador',0);
  rgDest.ItemIndex := Ini.ReadInteger('Geral','TipoDestinatario',0);
  rgRem.ItemIndex := Ini.ReadInteger('Geral','TipoRemetente',0);
  rgRec.ItemIndex := Ini.ReadInteger('Geral','TipoRecebedor',0);
  rgExp.ItemIndex := Ini.ReadInteger('Geral','TipoExpedidor',0);
  combCodSitTrib.ItemIndex := Ini.ReadInteger('Geral','CodSitTributario',0);
  percentualFrete := Ini.ReadFloat('Geral','PercentualFrete',0);
  valordokilo := Ini.ReadFloat('Geral','Valordokilo',0);
  Edit1.Text :=  floattostr(valordokilo) ;
  pvalordokilo := StrToFloat(Edit1.Text) ;

  ckSalvar.Checked         := Ini.ReadBool(   'Geral','Salvar'      ,True);
  edtPathLogs.Text         := Ini.ReadString( 'Geral','PathSalvar'  ,'');
  edtCteImportar.Text      := Ini.ReadString( 'Geral','PathCTe'  ,'');
  edtCfop.Text             := Ini.ReadString( 'Geral','CFOPCTe'  ,'6932');
  cfop_padrao := edtCfop.Text;
  edtNatOpe.Text           := Ini.ReadString( 'Geral','NatOpeCTe'  ,
    'Prestação Serviço Transporte Iniciada UF diversa');
  nat_padrao := edtNatOpe.Text;

  edtRodRNTRC.Text := Ini.ReadString( 'Geral', 'RNTRC'  , '');
  rntrc_padrao := edtRodRNTRC.Text;


  percent_icms     := Ini.ReadFloat( 'ICMS','Percentual'   , 0);

  cbUF.ItemIndex       := cbUF.Items.IndexOf(Ini.ReadString('WebService','UF','SP'));
  rgTipoAmb.ItemIndex  := Ini.ReadInteger('WebService','Ambiente'  ,0);
  ckVisualizar.Checked :=Ini.ReadBool(    'WebService','Visualizar',False);

  //edtProxyHost.Text  := Ini.ReadString( 'Proxy','Host'   ,'');
  //edtProxyPorta.Text := Ini.ReadString( 'Proxy','Porta'  ,'');
  //edtProxyUser.Text  := Ini.ReadString( 'Proxy','User'   ,'');
  //edtProxySenha.Text := Ini.ReadString( 'Proxy','Pass'   ,'');
  //ACBrCTe1.Configuracoes.WebServices.ProxyHost := edtProxyHost.Text;
  //ACBrCTe1.Configuracoes.WebServices.ProxyPort := edtProxyPorta.Text;
  //ACBrCTe1.Configuracoes.WebServices.ProxyUser := edtProxyUser.Text;
  //ACBrCTe1.Configuracoes.WebServices.ProxyPass := edtProxySenha.Text;

  rgTipoDACTe.ItemIndex   := Ini.ReadInteger('Geral','DACTE'       ,0);
  rgTiposCte.ItemIndex    := Ini.ReadInteger('Geral','TipoCTe'     ,0);
  rgTipoServico.ItemIndex := Ini.ReadInteger('Geral','TipoServico' ,0);
  edtLogoMarca.Text       := Ini.ReadString ('Geral','LogoMarca'   ,'');

  //edtEmitCNPJ.Text       := Ini.ReadString( 'Emitente','CNPJ'       ,'');
  //edtEmitIE.Text         := Ini.ReadString( 'Emitente','IE'         ,'');
  //edtEmitRazao.Text      := Ini.ReadString( 'Emitente','RazaoSocial','');
  //edtEmitFantasia.Text   := Ini.ReadString( 'Emitente','Fantasia'   ,'');
  //edtEmitFone.Text       := Ini.ReadString( 'Emitente','Fone'       ,'');
  //edtEmitCEP.Text        := Ini.ReadString( 'Emitente','CEP'        ,'');
  //edtEmitLogradouro.Text := Ini.ReadString( 'Emitente','Logradouro' ,'');
  //edtEmitNumero.Text     := Ini.ReadString( 'Emitente','Numero'     ,'');
  //edtEmitComp.Text       := Ini.ReadString( 'Emitente','Complemento','');
  //edtEmitBairro.Text     := Ini.ReadString( 'Emitente','Bairro'     ,'');
  //edtEmitCodCidade.Text  := Ini.ReadString( 'Emitente','CodCidade'  ,'');
  //edtEmitCidade.Text     := Ini.ReadString( 'Emitente','Cidade'     ,'');
  //edtEmitUF.Text         := Ini.ReadString( 'Emitente','UF'         ,'');

  edtSmtpHost.Text      := Ini.ReadString( 'Email','Host'   ,'');
  edtSmtpPort.Text      := Ini.ReadString( 'Email','Port'   ,'');
  edtSmtpUser.Text      := Ini.ReadString( 'Email','User'   ,'');
  edtSmtpPass.Text      := Ini.ReadString( 'Email','Pass'   ,'');
  edtEmailAssunto.Text  := Ini.ReadString( 'Email','Assunto','');
  cbEmailSSL.Checked    := Ini.ReadBool(   'Email','SSL'    ,False);

  carga_prodpre         := Ini.ReadString( 'Carga','ProdutoPredominante', '');
  carga_desc            := Ini.ReadString( 'Carga','DescricaoQuantidade', '');
  carga_un              := Ini.ReadString( 'Carga','UnidadeMedida', '');
  componente_nome       := Ini.ReadString( 'Componente','Descricao', '');

  vModeloCte := Ini.ReadInteger('Geral','ModeloCTe' ,57);
  {StreamMemo := TMemoryStream.Create;
  Ini.ReadBinaryStream( 'Email','Mensagem',StreamMemo);
  mmEmailMsg.Lines.LoadFromStream(StreamMemo);
  StreamMemo.Free;}

  ACBrCTeDACTeRL1.MargemDireita := Ini.ReadFloat('Danfe','MargemDireita',0.7);
  ACBrCTeDACTeRL1.MargemEsquerda := Ini.ReadFloat('Danfe','MargemEsquerda',5.0);
  ACBrCTeDACTeRL1.MargemSuperior := Ini.ReadFloat('Danfe','MargemSuperior',3.0);
  ACBrCTeDACTeRL1.MargemInferior := Ini.ReadFloat('Danfe','MargemInferior',0.7);

  ACBrCTe1.DACTE.MargemDireita := Ini.ReadFloat('Danfe','MargemDireita',3.0);
  ACBrCTe1.DACTE.MargemEsquerda := Ini.ReadFloat('Danfe','MargemEsquerda',2.0);
  ACBrCTe1.DACTE.MargemSuperior := Ini.ReadFloat('Danfe','MargemSuperior',3.0);
  ACBrCTe1.DACTE.MargemInferior := Ini.ReadFloat('Danfe','MargemInferior',0.7);
  Margem_ver := Ini.ReadFloat('Danfe','MargemDireita',3.7);
  Margem_ver := Ini.ReadFloat('Danfe','MargemEsquerda',2.0);
 finally
  Ini.Free;
 end;


end;

procedure TfCTePrincipal.EditarRe;
begin
  {if ((rgRec.ItemIndex = 1) and (edtNumCte.Text <> '')) then
  begin
    vCteStr := 'UPDATE CTE SET ';
    vCteStr := vCteStr + ' RE_CNPJCPF = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_IESTADUAL = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_RSOCIAL = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_FANTASIA = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_TELEFONE = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_ENDERECO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_NUMERO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_COMPLEMENTO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_BAIRRO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_CODIGOMUNICIPI = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_CIDADE = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_CEP = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr + ' ,RE_ESTADO = ';
    vCteStr := vCteStr + QuotedStr('');

    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    //dmPdv.IbCon.AutoCommit := true;
    // dmPdv.IbCon.StartTransaction;

    try
      dmPdv.IbCon.ExecuteDirect(vCteStr);
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
  }
end;

procedure TfCTePrincipal.GerarCTe(NumCTe: String);
var
 i, j, CodigoMunicipio, Tomador: Integer;
 IE  : string;
begin
  //if ((rgTipoServico.ItemIndex = 1) or (rgTiposCte.ItemIndex = 1) and (edtAntCHCTE.Text = '')) then
  if (((rgTipoServico.ItemIndex = 1) or (rgTiposCte.ItemIndex = 1)) and (edtAntCHCTE.Text = '')) then
  begin
    ShowMessage('Informe a Chave da Cte Anterior');
    edtAntCHCTE.SetFocus;
    Exit;
  end;

  if ((rgTiposCte.ItemIndex = 2) and
      (edtAntCHCTE.Text = '')) then
  begin
    ShowMessage('Informe a Chave da Cte Anterior a ser Anulada');
    edtAntCHCTE.SetFocus;
    Exit;
  end;

  // O código abaixo faz parte da minha aplicação devendo ser feitas as alterações
  // necessárias para ser utilizado na sua.
  with ACBrCTe1.Conhecimentos.Add.CTe do
  begin

      case cbVersaoDF.ItemIndex of
        0: infCTe.versao := 2.0;
        1: infCTe.versao := 3.0;
        2: infCTe.versao := 4.0;
      end;

    //
    // Dados de Identificação do CT-e
    //
    if (rgTiposCte.ItemIndex = 1) then
      infCteComp.chave := edtAntCHCTE.Text;

    if (rgTiposCte.ItemIndex = 2) then
    begin
      infCteAnu.chCTe:=edtAntCHCTE.Text;
      infCteAnu.dEmi:=dataEmissaoCte.DateTime;
      with infCTeNorm do
      begin
      // chave do CTe a ser substituido (original)

      infCteSub.chCTe :=  edtAntCHCTE.Text;
      // indAlteraToma= se informado 1 significa que tem alteração de tomador
      infCteSub.indAlteraToma := tiNao;
      if (rbAlteradoTomador.Checked = True) then
         infCteSub.indAlteraToma := tiSim;
      // refCteAnu= chave do CTe de anulaç
      if edtAntCHCTEAnula.Text <> '' then
        infCteSub.refCteAnu := edtAntCHCTEAnula.Text;
      if edtAntCHNFE.Text <> '' then
        infCteSub.refCteAnu := edtAntCHNFE.Text;
      end;
    end;

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


   Ide.modelo:= StrToInt(Trim(edtModelo.Text));
   Ide.serie:= StrToInt(Trim(edtSerieCte.Text)) ;// Criar ou ver da onde Vira DM_CNT.Conhec2Serie.AsInteger;
   Ide.nCT:= StrToInt(Trim(edtNumCte.Text));
   Ide.dhEmi:= dataGerarCte.DateTime;  // StringToDateTime(dataGerarCte.Text); //  Now;
   if (rgTipoDACTe.ItemIndex = 0) then
     Ide.tpImp:=  tiRetrato
   else
     Ide.tpImp:=  tiPaisagem;

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
   case rgTiposCte.ItemIndex of
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
    if (Trim(edtModelo.Text) = '57') then
    begin
      case rgTipoServico.ItemIndex of
        0: Ide.tpServ := tsNormal;
        1: Ide.tpServ := tsSubcontratacao;
        2: Ide.tpServ := tsRedespacho;
        3: Ide.tpServ := tsIntermediario;
        4: Ide.tpServ := tsMultimodal;
      end;
    end;
    if (Trim(edtModelo.Text) = '67') then
    begin
      case rgTipoServico.ItemIndex of
        0: Ide.tpServ:=tsTranspPessoas;
        1: Ide.tpServ:=tsTranspValores;
        2: Ide.tpServ:=tsExcessoBagagem;
      end;
    end;



    // incluir na aba Dados

    // Emissão
    Ide.cMunEnv := StrToInt(LimparString(edtEnvCodCidade.Text, '-'));
    Ide.xMunEnv := edtEnvCidade.Text;
    Ide.UFEnv := Trim(edtEnvUF.Text);

    // Inicio da Prestação
    Ide.cMunIni:= StrToInt(LimparString(edtIniCodCidade.Text,'-')); // DM_CNT.Conhec2CodCidadeColeta.AsInteger;
    Ide.xMunIni:= edtIniCidade.Text; //DM_CNT.Conhec2NomeCidadeColeta.AsString;
    Ide.UFIni:= Trim(edtIniUF.Text); // DM_CNT.Conhec2EstadoColeta.AsString;

    // Termino da Prestação
    Ide.cMunFim:= StrToInt(LimparString(edtFimCodCidade.Text, '-')); // DM_CNT.Conhec2CodCidadeEntrega.AsInteger;
    Ide.xMunFim:= edtFimCidade.Text; // DM_CNT.Conhec2NomeCidadeEntrega.AsString;
    Ide.UFFim:= Trim(edtFimUF.Text); //DM_CNT.Conhec2EstadoEntrega.AsString;

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
   rgTomador.ItemIndex := dmCte.cdsCTETOMADORSERVICO.AsInteger;

    case rgTomador.ItemIndex of
      0: rgTomador.ItemIndex := 0;
      1: rgTomador.ItemIndex := 1;
      2: rgTomador.ItemIndex := 2;
      3: rgTomador.ItemIndex := 3;
      4: rgTomador.ItemIndex := 4;
    end;

    Case  RadioGroup3.ItemIndex of
      0:  Ide.indIEToma := inContribuinte;
      1:  Ide.indIEToma := inIsento;
      2:  Ide.indIEToma := inNaoContribuinte;
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
     Ide.Toma4.EnderToma.nro:= Trim(edtNumTomador.Text);
     Ide.Toma4.EnderToma.xCpl:= edtCompTomador.Text;
     Ide.Toma4.EnderToma.xBairro:= edtBairroTomador.Text;

     CodigoMunicipio:= StrToInt(LimparString(edtTomadorCodCidade.Text,'-'));
     Ide.Toma4.EnderToma.cMun:= CodigoMunicipio;
     Ide.Toma4.EnderToma.xMun:= edtTomadorCidade.Text;
     Ide.Toma4.EnderToma.CEP:= StrToInt(LimparString(edtCepTomador.TExt,'-')); //StrToIntDef(edtCepTomador.TExt, 0); 199
     Ide.Toma4.EnderToma.UF:= Trim(edtTomadorUF.Text);
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

   if dmPdv.sqEmpresaCRT.AsInteger = 0 then
     Emit.CRT := crtSimplesNacional;
   if dmPdv.sqEmpresaCRT.AsInteger = 1 then
     Emit.CRT := crtSimplesExcessoReceita;
   if dmPdv.sqEmpresaCRT.AsInteger = 2 then
     Emit.CRT := crtRegimeNormal;

    Emit.xNome := dmPdv.sqEmpresaRAZAO.AsString;
    Emit.xFant := dmPdv.sqEmpresaEMPRESA.AsString;
    Emit.EnderEmit.xLgr := dmPdv.sqEmpresaENDERECO.AsString;
    Emit.EnderEmit.nro := Trim(dmPdv.sqEmpresaNUMERO.AsString);
    Emit.EnderEmit.xCpl := dmPdv.sqEmpresaLOGRADOURO.AsString;
    Emit.EnderEmit.xBairro := dmPdv.sqEmpresaBAIRRO.AsString;
    /// refazer aqui ta errado
    //  CodigoMunicipio := StrToInt(dm.zEmpresaCD_IBGE.AsString);
    CodigoMunicipio := StrToInt(LimparString(dmPdv.sqEmpresaCD_IBGE.AsString,'-'));
    Emit.EnderEmit.cMun := CodigoMunicipio;

    Emit.EnderEmit.xMun := dmPdv.sqEmpresaCIDADE.AsString;
    Emit.EnderEmit.CEP := StrToInt(LimparString(dmPdv.sqEmpresaCEP.AsString,'-'));
    Emit.EnderEmit.UF := Trim(dmPdv.sqEmpresaUF.AsString);
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
      Rem.EnderReme.nro:= Trim(edtRemNum.Text);
      Rem.EnderReme.xCpl:= edtRemComp.Text;
      Rem.EnderReme.xBairro:= edtRemBairro.Text;

      CodigoMunicipio:= StrToInt(LimparString(edtRemCodCidade.Text,'-'));

      Rem.EnderReme.cMun := CodigoMunicipio;
      Rem.EnderReme.xMun := edtRemCidade.Text;
      Rem.EnderReme.CEP :=  StrToInt(LimparString(edtRemCep.Text,'-')); //StrToIntDef(edtRemCep.Text, 0); 199
      Rem.EnderReme.UF := Trim(edtRemUF.Text);
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

   //dmCte.sqNFe.Close;


   if (dmCte.sqNFe.Active) then
   begin
     dmCte.sqNFe.Params[0].AsInteger := val_genCte;
     dmCte.sqNFe.Open;
   end;

   dmCte.sqNFe.First;
   while(not dmCte.sqNFe.Eof) do begin
     with infCTeNorm.infDoc.infNFe.Add do
     begin
       chave := dmCte.sqNFeCHAVE.AsString;
       PIN := dmCte.sqNFePIN.AsString;
       dPrev := StrToDate(FormatDateTime('dd/mm/yyyy',dmCte.sqNFeDPREV.Value)); //dm.cdsNFeDPREV.AsString;  antes dmCte.sqNFeDPREV.Value; // ;
     end;
     dmCte.sqNFe.Next;
   end;

   case  rgGlobalizado.ItemIndex of
     0: Ide.indGlobalizado :=tiSim;
     1: Ide.indGlobalizado :=tiNao;
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

    if(combOutrosDocs.Text <> '') then
    begin
      with infCTeNorm.infDoc.infOutros.Add do
      begin
        if (dmCte.cdsCTEOUTPDOC.AsString = '00' ) then
        tpDoc := tdDeclaracao;
        if (dmCte.cdsCTEOUTPDOC.AsString = '99' ) then
        tpDoc := tdOutros;
        dEmi       := dataOutrosEmi.DateTime;
        nDoc       := edtOutrosNum.Text;
        descOutros := edtOutrosDesc.Text;
       // vDocFisc   := StringToFloat(Format('%8.2f', [valOutrosVal.Value])); // valOutrosVal.Value;
      end;
    end;

   //
   //  Dados do Destinatario    // Aba Destinatarios Inicio

   //
    if(trim(edtDestCNPJ.Text)<>'') then
    begin
      Dest.xNome:= edtDestNome.Text ;//DM_CTA.PessoaFJRSocial.AsString;
      Dest.EnderDest.xLgr:= edtDestEnd.Text ;// DM_CTA.PessoaFJEndereco.AsString;
      Dest.EnderDest.nro:= Trim(edtDestNum.Text);// DM_CTA.PessoaFJNumero.AsString;
      Dest.EnderDest.xCpl:= edtDestComp.Text ;//DM_CTA.PessoaFJComplemento.AsString;
      Dest.EnderDest.xBairro:= edtDestBairro.Text ;// DM_CTA.PessoaFJBairro.AsString;

      CodigoMunicipio:= StrToInt(LimparString(edtDestCodCidade.Text,'-'));

      Dest.EnderDest.cMun:= CodigoMunicipio;
      Dest.EnderDest.xMun:= edtDestCidade.Text ;//DM_CTA.PessoaFJCidade.AsString;
      Dest.EnderDest.CEP:= StrToInt(LimparString(edtDestCEP.Text,'-')); //StrToIntDef(edtDestCEP.Text, 0); 199
      Dest.EnderDest.UF:= Trim(edtDestUF.Text);// DM_CTA.PessoaFJEstado.AsString;
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
      try
      Exped.xNome:= edtExpRazao.Text;
      Exped.EnderExped.xLgr:= edtExpEnd.Text;
      Exped.EnderExped.nro:= Trim(edtExpNum.Text);//DM_CTA.PessoaFJNumero.AsString;
      Exped.EnderExped.xCpl:= edtExpComp.Text;//DM_CTA.PessoaFJComplemento.AsString;
      Exped.EnderExped.xBairro:= edtExpBairro.Text;//DM_CTA.PessoaFJBairro.AsString;

      CodigoMunicipio:= StrToInt(LimparString(edtExpCodCidade.Text,'-'));
      Exped.EnderExped.cMun:=CodigoMunicipio;
      Exped.EnderExped.xMun:= edtExpCidade.Text;//DM_CTA.PessoaFJCidade.AsString;
      Exped.EnderExped.CEP:= StrToInt(LimparString(edtExpCep.Text,'-')); // StrToIntDef(edtExpCep.Text, 0); 199
      Exped.EnderExped.UF:= Trim(edtExpUF.Text);//DM_CTA.PessoaFJEstado.AsString;
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
      except
        ShowMessage('Verifique informações Expedidor, está marcado que tem.');
      end;
    end;
    // ABA RECEBEDOR
    //  Dados do Recebedor

    if (rgRec.ItemIndex = 0)then
    begin
      Receb.xNome:= edtRecRazao.Text;// DM_CTA.PessoaFJRSocial.AsString;
      Receb.EnderReceb.xLgr:= edtRecEnd.Text;// DM_CTA.PessoaFJEndereco.AsString;
      Receb.EnderReceb.nro:= Trim(edtRecNum.Text);// DM_CTA.PessoaFJNumero.AsString;
      Receb.EnderReceb.xCpl:= edtRecComp.Text;// DM_CTA.PessoaFJComplemento.AsString;
      Receb.EnderReceb.xBairro:= edtRecBairro.Text;// DM_CTA.PessoaFJBairro.AsString;

      CodigoMunicipio:= StrToInt(LimparString(edtRecCodCidade.Text,'-'));
      Receb.EnderReceb.cMun:=CodigoMunicipio;
      Receb.EnderReceb.xMun:= edtRecCidade.Text;// DM_CTA.PessoaFJCidade.AsString;
      Receb.EnderReceb.CEP:= StrToInt(LimparString(edtRecCep.Text,'-')); //StrToIntDef(edtRecCep.Text, 0); 199
      Receb.EnderReceb.UF:= Trim(edtRecUF.Text);// DM_CTA.PessoaFJEstado.AsString;
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
    vPrest.vTPrest := dmCte.cdsCteVPREST.AsFloat;
    vPrest.vRec    := dmCte.cdsCteVREC.AsFloat;

    if (dmCte.sqComp.Active)then
    begin
      dmCte.sqComp.Params[0].AsInteger := val_genCte;
      dmCte.sqComp.Open;
    end;
    dmCte.sqComp.First;  //14/12/2022 MANOEL
    while( not dmCte.sqComp.Eof) do begin
      with vPrest.comp.Add do
      begin
        xNome := dmCte.sqCompCOMP_NOME.AsString;
        vComp := dmCte.sqCompCOMP_VALOR.AsFloat;
      end;
      dmCte.sqComp.Next;
    end;


    //  Docs Anterior 15/08/19
    if ((edtAntCHCTE.Text <> '') and (rgTiposCte.ItemIndex = 0)) then
    begin
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
    end;
   //  Valores dos Impostos
   // TpcnCSTIcms = (cst00, cst10, cst20, cst30, cst40, cst41, cst45, cst50, cst51, cst60, cst70, cst80, cst81, cst90);
   // 80 e 81 apenas para CTe

   //Lazarus-Cte

   case combCodSitTrib.ItemIndex of    //00 - Tributação Normal do ICMS
    0: begin
         Imp.ICMS.SituTrib     := cst00;
         Imp.ICMS.ICMS00.CST   := cst00;
         Imp.ICMS.ICMS00.vBC   := dmCte.cdsCteVALVBC.AsFloat;
         Imp.ICMS.ICMS00.pICMS := dmCte.cdsCteVALPICMS.AsFloat;
         Imp.ICMS.ICMS00.vICMS := dmCte.cdsCteVALVICMS.AsFloat;
       end;

    1: begin                        //20 - Tributação com Redulçao da BC do ICMS
         Imp.ICMS.SituTrib      := cst20;
         Imp.ICMS.ICMS20.CST    := cst20; // Tributação com BC reduzida do ICMS
         Imp.ICMS.ICMS20.vBC   := dmCte.cdsCteVALVBC.AsFloat;
         Imp.ICMS.ICMS20.pICMS := dmCte.cdsCteVALPICMS.AsFloat;
         Imp.ICMS.ICMS20.vICMS := dmCte.cdsCteVALVICMS.AsFloat;
         Imp.ICMS.ICMS20.pRedBC := dmCte.cdsCteVALPREDBC.AsFloat;
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
         // TODO incluir calc. ST
         {
         Imp.ICMS.ICMS60.vBCSTRet   := StringToFloat(dbvalvBC.Field.Value);
         Imp.ICMS.ICMS60.vICMSSTRet := StringToFloat(dbvalpICMS.Field.Value);     // invertido
         Imp.ICMS.ICMS60.pICMSSTRet := StringToFloat(dbvalvICMS.Field.Value);     // invertido
         Imp.ICMS.ICMS60.vCred      := StringToFloat(dbvalvCred.Field.Value);
         }
        end;
                                 // 90 - ICMS outros
    6: begin
         Imp.ICMS.SituTrib      := cst90;
         Imp.ICMS.ICMS90.CST    := cst90; // Tributação atribuida ao tomador ou 3. por ST
         Imp.ICMS.ICMS90.vBC    := dmCte.cdsCteVALVBC.AsFloat;
         Imp.ICMS.ICMS90.pICMS  := dmCte.cdsCteVALPICMS.AsFloat;
         Imp.ICMS.ICMS90.vICMS  := dmCte.cdsCteVALVICMS.AsFloat;
         Imp.ICMS.ICMS90.pRedBC := dmCte.cdsCteVALPREDBC.AsFloat;
         Imp.ICMS.ICMS90.vCred  := dmCte.cdsCteVALVCRED.AsFloat;
       end;

    7: begin                        // 90 - ICMS Outra UF
         Imp.ICMS.SituTrib      := cst90;
         Imp.ICMS.ICMS90.CST    := cst90;
         Imp.ICMS.ICMS90.vBC    := dmCte.cdsCteVALVBC.AsFloat;
         Imp.ICMS.ICMS90.pICMS  := dmCte.cdsCteVALPICMS.AsFloat;
         Imp.ICMS.ICMS90.vICMS  := dmCte.cdsCteVALVICMS.AsFloat;
         Imp.ICMS.ICMS90.pRedBC := dmCte.cdsCteVALPREDBC.AsFloat;
       end;

    8: begin                    // 90 - SIMPLES NACIONAL
         Imp.ICMS.SituTrib := cstICMSSN ;
         Imp.ICMS.ICMSSN.indSN := 1;
       end;
    end;

    //
    //  Informações da Carga
    //                                  //Format('%8.2f', [edPesoVol1.Value]);

    infCTeNorm.infCarga.vCarga  := dmCte.cdsCteVALINFCARGA.AsFloat;
    infCTeNorm.infCarga.proPred := edtProPred.Text; //DM_CNT.Conhec2Especie.AsString;
    infCTeNorm.infCarga.xOutCat := edtOutCat.Text; // DM_CNT.Conhec2Natureza.AsString;

    //  Dados do Modal Rodoviário
    infCTeNorm.rodo.RNTRC := edtRodRNTRC.Text;
    //removido CTe 3.0
    //if (dataRodPrev.Checked) then
    //  infCTeNorm.rodo.dPrev := dataRodPrev.Date;

    case rgRodLotacao.ItemIndex of
      0: infCTeNorm.rodo.lota := ltNao;
      1: infCTeNorm.rodo.lota := ltsim;
    end;

    // Lazarus-Cte

    if (not dmCte.sqVeic.Active)then
    begin
      dmCte.sqVeic.Params[0].AsInteger := val_genCte;
      dmCte.sqVeic.Open;
    end;
    dmCte.sqVeic.First;
    while( not dmCte.sqVeic.Eof) do
    begin
      with infCTeNorm.rodo.veic.Add  do
      begin
        cInt  := dmCte.sqVeicCINT.AsString ;
        RENAVAM := dmCte.sqVeicRENAVAM.AsString ;
        placa := dmCte.sqVeicPlaca.AsString ;
        tara := dmCte.sqVeicTara.AsInteger ;
        capKG := dmCte.sqVeicCAPKG.AsInteger ;
        capM3 := dmCte.sqVeicCAPM3.AsInteger ;
        if (dmCte.sqVeicTPPROP.AsString = 'P' ) then
          tpProp  := tpProprio;
        if (dmCte.sqVeicTPPROP.AsString = 'T' ) then
          tpProp  := tpTerceiro;
        if (dmCte.sqVeicTPVEIC.AsString = '0' ) then
        tpVeic  := tvTracao;
        if (dmCte.sqVeicTPVEIC.AsString = '1' ) then
          tpVeic  := tvReboque;
        if (dmCte.sqVeicTPCAR.AsString = '00' ) then
          tpRod := trNaoAplicavel;
        if (dmCte.sqVeicTPCAR.AsString = '01' ) then
          tpRod := trTruck;
        if (dmCte.sqVeicTPCAR.AsString = '02' ) then
          tpRod := trToco;
        if (dmCte.sqVeicTPCAR.AsString = '03' ) then
          tpRod := trCavaloMecanico;
        if (dmCte.sqVeicTPCAR.AsString = '04' ) then
          tpRod := trVAN;
        if (dmCte.sqVeicTPCAR.AsString = '05' ) then
          tpRod := trUtilitario;
        if (dmCte.sqVeicTPCAR.AsString = '06' ) then
          tpRod := trOutros;
        if (dmCte.sqVeicTPCAR.AsString = '00' ) then
          tpCar := tcNaoAplicavel ;
        if (dmCte.sqVeicTPCAR.AsString = '01' ) then
          tpCar := tcAberta ;
        if (dmCte.sqVeicTPCAR.AsString = '02' ) then
          tpCar := tcFechada;
        if (dmCte.sqVeicTPCAR.AsString = '03' ) then
          tpCar := tcGraneleira;
        if (dmCte.sqVeicTPCAR.AsString = '04' ) then
          tpCar := tcPortaContainer;
        if (dmCte.sqVeicTPCAR.AsString = '05' ) then
          tpCar := tcSider;
        UF := dmCte.sqVeicVUF.AsString ;
        Prop.CNPJCPF := dmCte.sqVeicCNPJ.AsString;
        Prop.RNTRC   := dmCte.sqVeicRNTRC.AsString;
        Prop.xNome   := dmCte.sqVeicNOME.AsString;
        if (dmCte.sqVeicIE.Text = '') then
          Prop.IE := 'ISENTO';
        if (dmCte.sqVeicIE.Text <> '') then
          Prop.IE := dmCte.sqVeicIE.AsString;
        Prop.UF   := dmCte.sqVeicVUF.AsString;

        if (dmCte.sqVeicVTPPROP.AsString = '0' ) then
          Prop.tpProp := tpTACAgregado;
        if (dmCte.sqVeicVTPPROP.AsString = '1' ) then
          Prop.tpProp := tpTACIndependente;
        if (dmCte.sqVeicVTPPROP.AsString = '2' ) then
          Prop.tpProp := tpOutros;
      end;
      dmCte.sqVeic.Next;
    end;

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
    }
    // ABA SEGURO
    if (not dmCte.sqSeg.Active)then
    begin
      dmCte.sqSeg.Params[0].AsInteger := val_genCte;
      dmCte.sqSeg.Open;
    end;
    dmCte.sqSeg.First;
    while ( not dmCte.sqSeg.Eof) do begin
      with infCTeNorm.seg.New do
      begin
        if(dmCte.sqSegRESP.AsInteger = 0 )then
          respSeg  := rsRemetente;
        if(dmCte.sqSegRESP.AsInteger = 1 )then
          respSeg  := rsExpedidor;
        if(dmCte.sqSegRESP.AsInteger = 2 )then
          respSeg  := rsRecebedor;
        if(dmCte.sqSegRESP.AsInteger = 3 )then
          respSeg  := rsDestinatario;
        if(dmCte.sqSegRESP.AsInteger = 4 )then
          respSeg  := rsEmitenteCTe;
        if(dmCte.sqSegRESP.AsInteger = 5 )then
          respSeg  := rsTomadorServico;

        xSeg   := dmCte.sqSegNOME_SEGURADORA.AsString;
        nApol  := dmCte.sqSegNUMERO_APOLICE.AsString;
        nAver  := dmCte.sqSegNUMERO_AVERBACAO.AsString;
        vCarga := dmCte.sqSegVALOR.Value;
      end;
      dmCte.sqSeg.Next;
    end;

    case  rgForPag.ItemIndex of
     0: Ide.forPag := fpPago;
     1: Ide.forPag := fpAPagar;
     2: Ide.forPag := fpOutros;
    end;


    if not (dmCte.sqQC.Active)then
    begin
      dmCte.sqQC.Params[0].AsInteger := val_genCte;
      dmCte.sqQC.Open;
    end;
    dmCte.sqQC.First;
    while( not dmCte.sqQC.Eof) do
    begin
      // UnidMed = (uM3,uKG, uTON, uUNIDADE, uLITROS , uMMBTU);
      with infCTeNorm.infCarga.InfQ.Add do
      begin
        if (dmCte.sqQCUNID.AsString = '00') then
          cUnid  := uM3;
        if (dmCte.sqQCUNID.AsString = '01') then
          cUnid  := uKG;
        if (dmCte.sqQCUNID.AsString = '02') then
          cUnid  := uTON;
        if (dmCte.sqQCUNID.AsString = '03') then
          cUnid  := uUNIDADE;
        if (dmCte.sqQCUNID.AsString = '04') then
          cUnid  := uLITROS;
        if (dmCte.sqQCUNID.AsString = '05') then
          cUnid  := uMMBTU;
        tpMed  := dmCte.sqQCMEDIDA.AsString;
        qCarga := dmCte.sqQCQUANT.Value;
      end;
      dmCte.sqQC.Next;
    end;
  end;
end;

procedure TfCTePrincipal.buscaEmpresa(Razao: String);
begin
 if (comboEmpresa.Text <> '') then
 begin
   dmPdv.busca_sql('SELECT * FROM empresa ' +
     ' WHERE razao = ' + QuotedStr(comboEmpresa.Text));
 end
 else begin
   dmPdv.busca_sql('SELECT * FROM empresa');
 end;

 edtCodEmitente.Text := IntToStr(dmPdv.sqBusca.FieldByName('CODIGO').AsInteger);
 edtEmitCNPJ.Text := dmPdv.sqBusca.FieldByName('CNPJ_CPF').AsString;
 edtEmitIE.Text := dmPdv.sqBusca.FieldByName('IE_RG').AsString;
 edtEmitRazao.Text := dmPdv.sqBusca.FieldByName('RAZAO').AsString;
 edtEmitFantasia.Text := dmPdv.sqBusca.FieldByName('EMPRESA').AsString;
 edtEmitFone.Text := dmPdv.sqBusca.FieldByName('FONE').AsString;
 edtEmitCEP.Text := dmPdv.sqBusca.FieldByName('CEP').AsString;
 edtEmitLogradouro.Text := dmPdv.sqBusca.FieldByName('ENDERECO').AsString;
 edtEmitNumero.Text := dmPdv.sqBusca.FieldByName('NUMERO').AsString;
 edtEmitComp.Text := dmPdv.sqBusca.FieldByName('LOGRADOURO').AsString;
 edtEmitBairro.Text := dmPdv.sqBusca.FieldByName('BAIRRO').AsString;
 edtEmitCodCidade.Text := dmPdv.sqBusca.FieldByName('CD_IBGE').AsString;
 edtEmitCidade.Text := dmPdv.sqBusca.FieldByName('CIDADE').AsString;
 edtEmitUF.Text := dmPdv.sqBusca.FieldByName('UF').AsString;
 edtEmitenteCte.Text := dmPdv.sqBusca.FieldByName('EMPRESA').AsString;
 label55.Caption := ' Emitente Iniciado' ;

 // pcPrincipal.ActivePage := TabDados;  // Dados
 //pcPrincipal.ActivePage := TabSheet24;  // Cte GEradas
 //label58.Caption := edtEmitRazao.Text;
 //label59.Caption := edtEmitRazao.Text;
 dmPdv.busca_sql('SELECT SERIE_CTE ,ULTIMO_NUMERO FROM SERIES ' +
   ' WHERE MODELO = ' + QuotedStr('CT') +
   '   AND CODSERIE = ' + QuotedStr(edtCodEmitente.Text));
 if (dmPdv.sqBusca.FieldByName('ULTIMO_NUMERO').asInteger > 0) then
 begin
   edtSerieCte.Text := dmPdv.sqBusca.FieldByName('SERIE_CTE').AsString;
   edInutSerie.Text := dmPdv.sqBusca.FieldByName('SERIE_CTE').AsString;
   edSerieAtualiza.Text := dmPdv.sqBusca.FieldByName('SERIE_CTE').AsString;
   edUltimoAtualiza.Text := IntToStr(dmPdv.sqBusca.FieldByName('ULTIMO_NUMERO').AsInteger);
 end;
 if (edtEnvUF.Text = '') then
 begin
   edtEnvUF.Text := edtEmitUF.Text;
   edtEnvCidade.Text := edtEmitCidade.Text;
   edtEnvCodCidade.TExt := edtEmitCodCidade.Text;
 end;

end;

procedure TfCTePrincipal.CarregarUF;
begin
  dmPdv.busca_sql('select distinct(CD_UF) from TB_IBGE');
  while not dmPdv.sqBusca.Eof do
  begin
    // TODO  - Criar as Buscas por cidade
    //comboEmi.Items.Add(dmPdv.sqBusca.FieldByName('CD_UF').AsString);
    //comboIni.Items.Add(dmPdv.sqBusca.FieldByName('CD_UF').AsString);
    //comboFim.Items.Add(dmPdv.sqBusca.FieldByName('CD_UF').AsString);
    dmPdv.sqBusca.Next;
  end;
end;

procedure TfCTePrincipal.duplicar(velhaCte: String);
var val_gen:integer;
  //CDSCloneQC: TClientDataSet;
  //CDSClone: TClientDataSet;
  //CDSCloneCOMP: TClientDataSet;
  I: Integer;
  prox: Integer;
  vallor : double;
  strEdita : string;
begin
  // VOU VER COMO FAZER ISSO ....
  {
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
  }
end;

procedure TfCTePrincipal.CarregarCte(NumCte: String);
var v_str_c: String;
begin
  FormatSettings.DecimalSeparator := '.';
  val_genCte := dmCte.cdsCTECOD_CTE.AsInteger;
  if (dmCte.cdsCTE.Active) then
    dmCte.cdsCTE.Edit;
  v_str_c := dmCte.cdsCTECTE_CFOP.AsString;
  edtCFOP.Text            := dmCte.cdsCTECTE_CFOP.AsString;
  edtNatOpe.Text          := dmCte.cdsCTECTE_NATOP.AsString;
  edtModelo.Text          := dmCte.cdsCTEMODELO.AsString;
  edtSerieCte.Text        := dmCte.cdsCTECTE_SERIE.AsString;
  edtNumCte.Text          := dmCte.cdsCTECTE_NUMERO.AsString;
  dataGerarCte.DateTime   := dmCte.cdsCTEDHEMI.AsDateTime;
  edtEmitenteCte.Text     := dmCte.cdsCTEE_FANTASIA.AsString;
  v_str_c  := Trim(dmCte.cdsCTEMODAL.AsString);
  rgModal.ItemIndex       := StrToInt(v_str_c);

  if (Trim(edtModelo.Text) = '57') then
  begin
    rgTipoServico.Items.Clear;
    rgTipoServico.Items.Add('Normal');
    rgTipoServico.Items.Add('SubContratação');
    rgTipoServico.Items.Add('Redespacho');
    rgTipoServico.Items.Add('Red. Intermediário');
    rgTipoServico.Items.Add('Serv. Multimodal');
  end;
  if (Trim(edtModelo.Text) = '67') then
  begin
   rgTipoServico.Items.Clear;
   rgTipoServico.Items.Add('Trasporte de pessoas');
   rgTipoServico.Items.Add('Transporte de Valores');
   rgTipoServico.Items.Add('Excesso de Bagagem');
  end;
  rgTipoServico.ItemIndex := dmCte.cdsCTETIPOSERVICO.AsInteger;
  rgTiposCte.ItemIndex    := dmCte.cdsCTETIPOCTE.AsInteger;
  rgFormaEmissao.ItemIndex := dmCte.cdsCTETPOEMISSAO.AsInteger;
  rgForPag.ItemIndex      := dmCte.cdsCTEIFORPAG.AsInteger;
  rgTipoDACTe.ItemIndex   := dmCte.cdsCTETPIMP.AsInteger;
  edtEnvCodCidade.Text    := dmCte.cdsCTEENV_CODCIDADE.AsString;
  edtEnvCidade.Text       := dmCte.cdsCTEENV_CIDADE.AsString;
  edtEnvUF.Text           := dmCte.cdsCTEENV_ESTADO.AsString;
  edtIniCodCidade.Text    := dmCte.cdsCTEINI_CODCIDADE.AsString;
  edtIniCidade.Text       := dmCte.cdsCTEINI_CIDADE.AsString;
  edtIniUF.Text           := dmCte.cdsCTEINI_ESTADO.AsString;
  edtFimCodCidade.Text    := dmCte.cdsCTEFIM_CODCIDADE.AsString;
  edtFimCidade.Text       := dmCte.cdsCTEFIM_CIDADE.AsString;
  edtFimUF.Text           := dmCte.cdsCTEFIM_ESTADO.AsString;
  rgTomador.ItemIndex     := dmCte.cdsCteTOMADORSERVICO.AsInteger;

  // emitente
  comboEmpresa.Text       := dmCte.cdsCTEE_RSOCIAL.AsString;
  edtCodEmitente.Text     := dmCte.cdsCTEEMITENTE.AsString;
  edtEmitCNPJ.Text        := dmCte.cdsCTEE_CNPJCPF.AsString;
  edtEmitIE.Text          := dmCte.cdsCTEE_IESTADUAL.AsString;
  edtEmitRazao.Text       := dmCte.cdsCTEE_RSOCIAL.AsString;
  edtEmitFantasia.Text    := dmCte.cdsCTEE_FANTASIA.AsString;
  edtEmitFone.Text        := dmCte.cdsCTEE_TELEFONE.AsString;
  edtEmitLogradouro.Text  := dmCte.cdsCTEE_ENDERECO.AsString;
  edtEmitNumero.Text      := dmCte.cdsCTEE_NUMERO.AsString;
  edtEmitComp.Text        := dmCte.cdsCTEE_COMPLEMENTO.AsString;
  edtEmitBairro.Text      := dmCte.cdsCTEE_BAIRRO.AsString;
  edtEmitCodCidade.Text   := dmCte.cdsCTEE_CODIGOMUNICIPI.AsString;
  edtEmitCidade.Text      := dmCte.cdsCTEE_CIDADE.AsString;
  edtEmitCep.Text         := dmCte.cdsCTEE_CEP.AsString;
  edtEmitUF.Text          := dmCte.cdsCTEE_ESTADO.AsString;
  // tomador
  if(dmCte.cdsCTET_CNPJCPF.AsString <> '') then
  begin
    rgTomador.ItemIndex      := dmCte.cdsCTETOMADORSERVICO.AsInteger;
    edtCNPJTomador.Text      := dmCte.cdsCTET_CNPJCPF.AsString;
    edtIETomador.Text        := dmCte.cdsCTET_IESTADUAL.AsString;
    edtRazaoTomador.Text     := dmCte.cdsCTET_RSOCIAL.AsString;
    edtNomeTomador.Text      := dmCte.cdsCTET_FANTASIA.AsString;
    edtFoneTomador.Text      := dmCte.cdsCTET_TELEFONE.AsString;
    edtEndTomador.Text       := dmCte.cdsCTET_ENDERECO.AsString;
    edtNumTomador.Text       := dmCte.cdsCTET_NUMERO.AsString;
    edtCompTomador.Text      := dmCte.cdsCTET_COMPLEMENTO.AsString;
    edtBairroTomador.Text    := dmCte.cdsCTET_BAIRRO.AsString;
    edtTomadorCodCidade.Text := dmCte.cdsCTET_CODIGOMUNICIPI.AsString;
    edtTomadorCidade.Text    := dmCte.cdsCTET_CIDADE.AsString;
    edtCepTomador.Text       := dmCte.cdsCTET_CEP.AsString;
    edtTomadorUF.Text        := dmCte.cdsCTET_ESTADO.AsString;
  end;
  // rememtente
  edtRemCNPJ.Text          := dmCte.cdsCTER_CNPJCPF.AsString;
  edtRemIE.Text            := dmCte.cdsCTER_IESTADUAL.AsString;
  edtRemRazao.Text         := dmCte.cdsCTER_RSOCIAL.AsString;
  edtRemNome.Text          := dmCte.cdsCTER_FANTASIA.AsString;
  edtRemFone.Text          := dmCte.cdsCTER_TELEFONE.AsString;
  edtRemEnd.Text           := dmCte.cdsCTER_ENDERECO.AsString;
  edtRemNum.Text           := dmCte.cdsCTER_NUMERO.AsString;
  edtRemComp.Text          := dmCte.cdsCTER_COMPLEMENTO.AsString;
  edtRemBairro.Text        := dmCte.cdsCTER_BAIRRO.AsString;
  edtRemCodCidade.Text     := dmCte.cdsCTER_CODIGOMUNICIPI.AsString;
  edtRemCidade.Text        := dmCte.cdsCTER_CIDADE.AsString;
  edtRemCep.Text           := dmCte.cdsCTER_CEP.AsString;
  edtRemUF.Text            := dmCte.cdsCTER_ESTADO.AsString;
  // destinatario
  edtDestCNPJ.Text         := dmCte.cdsCTED_CNPJCPF.AsString;
  edtDestIE.Text           := dmCte.cdsCTED_IESTADUAL.AsString;
  edtDestRazao.Text        := dmCte.cdsCTED_RSOCIAL.AsString;
  edtDestNome.Text         := dmCte.cdsCTED_FANTASIA.AsString;
  edtDestFone.Text         := dmCte.cdsCTED_TELEFONE.AsString;
  edtDestEnd.Text          := dmCte.cdsCTED_ENDERECO.AsString;
  edtDestNum.Text          := dmCte.cdsCTED_NUMERO.AsString;
  edtDestComp.Text         := dmCte.cdsCTED_COMPLEMENTO.AsString;
  edtDestBairro.Text       := dmCte.cdsCTED_BAIRRO.AsString;
  edtDestCodCidade.Text    := dmCte.cdsCTED_CODIGOMUNICIPI.AsString;
  edtDestCidade.Text       := dmCte.cdsCTED_CIDADE.AsString;
  edtDestCep.Text          := dmCte.cdsCTED_CEP.AsString;
  edtDestUF.Text           := dmCte.cdsCTED_ESTADO.AsString;
  // receedor
  if(dmCte.cdsCTERE_CNPJCPF.AsString <> '') then
  begin
    rgRec.ItemIndex := 0 ;
    edtRecCNPJ.Text          := dmCte.cdsCTERE_CNPJCPF.AsString;
    edtRecIE.Text            := dmCte.cdsCTERE_IESTADUAL.AsString;
    edtRecNome.Text          := dmCte.cdsCTERE_ENDERECO.AsString;
    edtRecRazao.Text         := dmCte.cdsCTERE_RSOCIAL.AsString;
    edtRecFone.Text          := dmCte.cdsCTERE_TELEFONE.AsString;
    edtRecEnd.Text           := dmCte.cdsCTERE_ENDERECO.AsString;
    edtRecNum.Text           := dmCte.cdsCTERE_NUMERO.AsString;
    edtRecComp.Text          := dmCte.cdsCTERE_COMPLEMENTO.AsString;
    edtRecBairro.Text        := dmCte.cdsCTERE_BAIRRO.AsString;
    edtRecCodCidade.Text     := dmCte.cdsCTERE_CODIGOMUNICIPI.AsString;
    edtRecCidade.Text        := dmCte.cdsCTERE_CIDADE.AsString;
    edtRecCep.TExt           := dmCte.cdsCTERE_CEP.AsString;
    edtRecUF.Text            := dmCte.cdsCTERE_ESTADO.AsString;
  end;

  if(dmCte.cdsCTEEX_CNPJCPF.AsString <> '') then
  begin
    GroupBoxExpeditor.Visible := True;
    rgExp.ItemIndex := 0;
    edtExpCNPJ.Text          := dmCte.cdsCTEEX_CNPJCPF.AsString;
    edtExpIE.Text            := dmCte.cdsCTEEX_IESTADUAL.AsString;
    edtExpRazao.Text         := dmCte.cdsCTEEX_RSOCIAL.AsString;
    edtExpNome.Text          := dmCte.cdsCTEEX_FANTASIA.AsString;
    edtExpFone.Text          := dmCte.cdsCTEEX_TELEFONE.AsString;
    edtExpEnd.Text           := dmCte.cdsCTEEX_ENDERECO.AsString;
    edtExpNum.Text           := dmCte.cdsCteEX_NUMERO.AsString;
    edtExpComp.Text          := dmCte.cdsCTEEX_COMPLEMENTO.AsString;
    edtExpBairro.Text        := dmCte.cdsCTEEX_BAIRRO.AsString;
    edtExpCodCidade.Text     := dmCte.cdsCTEEX_CODIGOMUNICIPI.AsString;
    edtExpCidade.Text        := dmCte.cdsCTEEX_CIDADE.AsString;
    edtExpCep.Text           := dmCte.cdsCTEEX_CEP.AsString;
    edtExpUF.Text            := dmCte.cdsCTEEX_ESTADO.AsString;
  end;

  if(dmCte.cdsCTEEX_CNPJCPF.AsString = '') then
  begin
    GroupBoxExpeditor.Visible := False;
    rgExp.ItemIndex := 1;
  end;
  edtCaracAdTrans.Text := dmCte.cdsCTECARAC_TRANSP.AsString;
  edtCaracAdServ.Text  := dmCte.cdsCTECARAC_SERV.AsString;
  edtFuncEmi.Text      := dmCte.cdsCTEFUNC_EMI.AsString;

  rgRetira.ItemIndex   := dmCte.cdsCTERETIRA.AsInteger;
  memDetRetira.Text    := dmCte.cdsCTEDET_RETIRA.AsString;

  //if(dmCte.cdsCTENPROT.AsString = '')then
  //begin
  //  dbValInfCarga.Text := FloatToStr(dmCte.cdsCTEVALINFCARGA.Value);
  //end;
  edtProPred.Text      := dmCte.cdsCTEPROPRED.AsString;
  edtOutCat.Text       := dmCte.cdsCTEOUTCAT.AsString;

  edtRodRNTRC.Text     := dmCte.cdsCTERNTRC.AsString;
  if (dmCte.cdsCTEDATARODPREV.IsNull) then
  begin
    dataRodPrev.Checked := False;
    dataRodPrev.TextForNullDate:='';
  end
  else begin
    dataRodPrev.Checked := True;
    dataRodPrev.date     := dmCte.cdsCTEDATARODPREV.Value;
  end;
  rgRodLotacao.ItemIndex := dmCte.cdsCTERGRODLOTACAO.Value;

  memxObs.Text         := dmCte.cdsCTEOBS_GERAL.Value;

  // para Clonar  colocar cds da tabela
  if (dmCte.sqComp.Active)then
    dmCte.sqComp.Close;
  dmCte.sqComp.Params[0].AsInteger := val_genCte;
  dmCte.sqComp.Open;

  if (ZsqComp.Active)then
    ZsqComp.Close;
  ZsqComp.Params[0].AsInteger := val_genCte;
  ZsqComp.Open;

  if (dmCte.sqQC.Active)then
    dmCte.sqQC.Close;
  dmCte.sqQC.Params[0].AsInteger := val_genCte;
  dmCte.sqQC.Open;

  if (ZsqQC.Active)then
    ZsqQC.Close;
  ZsqQC.Params[0].AsInteger := val_genCte;
  ZsqQC.Open;

  if (dmCte.sqNFe.Active)then
    dmCte.sqNFe.Close;
  dmCte.sqNFe.Params[0].AsInteger := val_genCte;
  dmCte.sqNFe.Open;

  if (ZsqNFe.Active)then
    ZsqNFe.Close;
  ZsqNFe.Params[0].AsInteger := val_genCte;
  ZsqNFe.Open;

  if (dmCte.sqSeg.Active)then
    dmCte.sqSeg.Close;
  dmCte.sqSeg.Params[0].AsInteger := val_genCte;
  dmCte.sqSeg.Open;


  { PULEI
  if (dm.cdsVeic.Active)then
    dm.cdsVeic.Close;
  dm.cdsVeic.Params[0].AsInteger := val_genCte;
  dm.cdsVeic.Open;

  if (dm.cdsMot.Active)then
    dm.cdsMot.Close;
  dm.cdsMot.Params[0].AsInteger := val_genCte;
  dm.cdsMot.Open;
  }
  // outros
  combOutrosDocs.Text    := dmCte.cdsCTEOUTPDOC.AsString;
  if (dmCte.cdsCTEOUDEMI.IsNull) then
  begin
    dataOutrosEmi.Checked := False;
    dataOutrosEmi.TextForNullDate:='';
  end
  else begin
    dataOutrosEmi.Checked := True;
    dataOutrosEmi.DateTime := dmCte.cdsCTEOUDEMI.AsDateTime;
  end;
  edtOutrosNum.Text      := dmCte.cdsCTEOUNDOC.AsString;
  edtOutrosDesc.Text     := dmCte.cdsCTEOUDESCOUTRO.AsString;

  // 15/08/19

  edtAntCNPJ.Text  := dmCte.cdsCTEANT_CNPJ.AsString;
  edtAntIE.Text    := dmCte.cdsCTEANT_IE.AsString;
  edtAntUF.Text    := dmCte.cdsCTEANT_UF.AsString;
  edtAntNome.Text  := dmCte.cdsCTEANT_NOME.AsString;
  edtAntCHCTE.Text := dmCte.cdsCTEANT_CHCTE.AsString;

  // impostos

  //if(dmCte.cdsCTENPROT.AsString = '')then
  begin
    combCodSitTrib.ItemIndex := dmCte.cdsCTECOMBCODSITTRIB.Value;
    //dbValpRedBC.AsFloat := dmCte.cdsCTEVALPREDBC.AsFloat;
    //dbValvBC.AsFloat    := dmCte.cdsCTEVALVBC.AsFloat;
    //dbValPIcms.AsFloat  := dmCte.cdsCTEVALPICMS.AsFloat;
    //dbValVICMS.AsFloat  := dmCte.cdsCTEVALVICMS.AsFloat;
    //dbValVCred.AsFloat  := dmCte.cdsCTEVALVCRED.AsFloat;
  end;

  if (dmCte.cdsCTE.Active)then
    dmCte.cdsCTE.Close;
  dmCte.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
  dmCte.cdsCTE.Params[1].AsInteger := StrToInt(edtNumCte.Text);
  dmCte.cdsCTE.Open;
  FormatSettings.DecimalSeparator := ',';
end;

procedure TfCTePrincipal.CarregarXML(ChaveCte: String);
var Dia, Mes, Ano: Word;
  path_dosxml: String;
begin
  DecodeDate(Now, Ano, Mes, Dia);
  OpenDialog1.Title := 'Selecione o CTe';
  OpenDialog1.DefaultExt := '*-cte.xml';
  OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  path_dosxml := ACBrCTe1.Configuracoes.Arquivos.PathSalvar +
    IntToStr(Ano) + IntToStr(mes) + '\';
  OpenDialog1.InitialDir := path_dosxml;
  ACBrCTe1.Conhecimentos.Clear;
  if (Length(ChaveCte) > 30) then
  begin
    if (FileExists(path_dosxml +
      dmCte.cdsCteCHCTE.AsString + '-cte.xml')) then
    begin
      ACBrCTe1.Conhecimentos.LoadFromFile(path_dosxml + ChaveCte + '-cte.xml');
    end
    else begin
      if OpenDialog1.Execute then
      begin
        ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
      end;
    end;
  end
  else begin
    if OpenDialog1.Execute then
    begin
      ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
    end;
  end;
end;

procedure TfCTePrincipal.CarregarAcbr;
var Ok         : Boolean;
begin
 try
   ACBrCTe1.Configuracoes.Geral.VersaoDF := TVersaoCTe(ve400);
   ACBrCTe1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;
   ACBrCTe1.DACTE.UsaSeparadorPathPDF := True;
   //ShowMessage('Carregou certificado');
   if (edtCaminho.Text <> '') then
   begin
     ACBrCTe1.Configuracoes.Certificados.ArquivoPFX := edtCaminho.Text;
     ACBrCTe1.Configuracoes.Certificados.Senha := edtSenha.Text;
   end;
   //ShowMessage('Carregando SSLLib');
   with ACBrNFe1.Configuracoes.Geral do
   begin
     SSLLib                := TSSLLib(cbSSLLib.ItemIndex);
     SSLCryptLib           := TSSLCryptLib(cbCryptLib.ItemIndex);
     SSLHttpLib            := TSSLHttpLib(cbHttpLib.ItemIndex);
     SSLXmlSignLib         := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
   end;
   ACBrNFe1.SSL.SSLType := TSSLType( cbSSLType.ItemIndex );
   //ShowMessage('Tipo Emissao');
   case rgFormaEmissao.ItemIndex of
    0: ACBrCTe1.Configuracoes.Geral.FormaEmissao := teNormal;
    1: ACBrCTe1.Configuracoes.Geral.FormaEmissao := teDPEC; // o mesmo que EPEC
    2: ACBrCTe1.Configuracoes.Geral.FormaEmissao := teFSDA;
    3: ACBrCTe1.Configuracoes.Geral.FormaEmissao := teSVCRS;
    4: ACBrCTe1.Configuracoes.Geral.FormaEmissao := tESVCSP;
   end;
   //ShowMessage('Caminho dos Logs');
   ACBrCTe1.Configuracoes.Geral.Salvar := ckSalvar.Checked;
   ACBrCTe1.Configuracoes.Arquivos.PathSalvar := edtPathLogs.Text;
   ACBrCTe1.Configuracoes.Arquivos.PathSchemas := dmPdv.path_exe + 'Schemas';
   ACBrCTe1.Configuracoes.WebServices.UF         := cbUF.Text;
   ACBrCTe1.Configuracoes.WebServices.Ambiente   := StrToTpAmb(Ok,IntToStr(rgTipoAmb.ItemIndex+1));
   ACBrCTe1.Configuracoes.WebServices.Visualizar := ckVisualizar.Checked;
   //ShowMessage('Acbr Dacte');

   //if ACBrCTe1.DACTe <> nil then
   begin
     ACBrCTe1.DACTe.TipoDACTe := StrToTpImp(OK,IntToStr(rgTipoDaCTe.ItemIndex+1));
     if (edtLogoMarca.Text <> '') then
       ACBrCTe1.DACTe.Logo := edtLogoMarca.Text;
     if (edtPathLogs.Text <> '') then
     begin
       ACBrCTe1.DACTe.PathPDF := edtPathLogs.Text;
       ACBrCTeDACTeRL1.PathPDF := edtPathLogs.Text;

     end;
     ACBrCTe1.DACTe.TamanhoPapel := tpA4_2vias;
     ACBrCTe1.DACTE.NomeDocumento:= edtNumCte.Text;
   end;
   if (edtSmtpHost.Text <> '') then
   begin
     ACBrCTe1.MAIL.Host := edtSmtpHost.Text;
     ACBrCTe1.MAIL.Port := edtSmtpPort.Text;
     ACBrCTe1.MAIL.Username := edtSmtpUser.Text;
     ACBrCTe1.MAIL.Password := edtSmtpPass.Text;
     ACBrCTe1.MAIL.SetSSL   := cbEmailSSL.Checked;
     ACBrCTe1.MAIL.ReadingConfirmation := False;
   end;
 except
   on E:Exception do
     ShowMessage('Erro carregar DACTe' + E.Message);
 end;

end;

procedure TfCTePrincipal.EditarA;
begin
  if (edtCFOP.Text <> '') then
  begin
    vCteStr := 'UPDATE CTE SET CTE_CFOP = ' ;
    vCteStr := vCteStr +  QuotedStr(edtCFOP.Text);
    vCteStr := vCteStr +  ', CTE_NATOP = ' ;
    vCteStr := vCteStr + QuotedStr(Copy(edtNatOpe.Text,1,60)); //QuotedStr(edtNatOpe.Text);
    vCteStr := vCteStr +  ', DHEMI = ' ;
    vCteStr := vCteStr +  QuotedStr(FormatDateTime('mm/dd/yyyy hh:nn:ss',
      dataGerarCte.DateTime));
    vCteStr := vCteStr +  ', MODELO = ';
    vCteStr := vCteStr +  QuotedStr(Trim(edtModelo.Text));
    vCteStr := vCteStr +  ', ENV_CODCIDADE = ';
    vCteStr := vCteStr +  QuotedStr(edtEnvCodCidade.Text);
    vCteStr := vCteStr +  ', ENV_CIDADE = ' ;
    vCteStr := vCteStr +  QuotedStr(edtEnvCidade.Text);
    vCteStr := vCteStr +  ', ENV_ESTADO = ' ;
    vCteStr := vCteStr +  QuotedStr(edtEnvUF.Text);
    vCteStr := vCteStr +  ',INI_CODCIDADE = ';
    vCteStr := vCteStr +  QuotedStr(edtIniCodCidade.Text);
    vCteStr := vCteStr +  ',INI_CIDADE = ';
    vCteStr := vCteStr +  QuotedStr(edtIniCidade.Text);
    vCteStr := vCteStr +  ',INI_ESTADO = ';
    vCteStr := vCteStr +  QuotedStr(edtIniUF.Text);

    vCteStr := vCteStr +  ',FIM_CODCIDADE = ';
    vCteStr := vCteStr +  QuotedStr(edtFimCodCidade.Text);
    vCteStr := vCteStr +  ',FIM_CIDADE = ';
    vCteStr := vCteStr +  QuotedStr(edtFimCidade.Text);
    vCteStr := vCteStr +  ',FIM_ESTADO = ';
    vCteStr := vCteStr +  QuotedStr(edtFimUF.Text);

    vCteStr := vCteStr +  ',MODAL = ';
    vCteStr := vCteStr +  IntToStr(rgModal.ItemIndex);  //MODAL
    vCteStr := vCteStr +  ', TIPOSERVICO = ';
    vCteStr := vCteStr +  IntToStr(rgTipoServico.ItemIndex);  // TIPOSERVICO
    vCteStr := vCteStr +  ',TIPOCTE = ';
    vCteStr := vCteStr +  IntToStr(rgTiposCte.ItemIndex);     // TIPOCTE
    vCteStr := vCteStr +  ',TPOEMISSAO = ';
    vCteStr := vCteStr +  IntToStr(rgFormaEmissao.ItemIndex); // TPOEMISSAO
    vCteStr := vCteStr +  ',IFORPAG = ';
    vCteStr := vCteStr +  IntToStr(rgForPag.ItemIndex);       // IFORPAG
    vCteStr := vCteStr +  ',TPIMP = ';
    vCteStr := vCteStr +  IntToStr(rgTipoDACTe.ItemIndex);    // TPIMP
    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;
end;

procedure TfCTePrincipal.EditarB;
begin
  if (edtNumCte.Text <> '') then
  begin
    vCteStr := 'UPDATE CTE SET CARAC_TRANSP = ';
    vCteStr := vCteStr + QuotedStr(edtCaracAdTrans.Text); // CARAC_TRANSP
    vCteStr := vCteStr +  ',CARAC_SERV = ';
    vCteStr := vCteStr + QuotedStr(edtCaracAdServ.Text); // CARAC_SERV
    vCteStr := vCteStr +  ',FUNC_EMI = ';
    vCteStr := vCteStr + QuotedStr(edtFuncEmi.Text); // FUNC_EMI
    vCteStr := vCteStr +  ',CTE_NUMERO = ';
    vCteStr := vCteStr +  edtNumCte.Text;
    vCteStr := vCteStr + ' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;
end;

procedure TfCTePrincipal.EditarC;
begin
  if (edtNumCte.Text <> '') then
  begin
    vCteStr := 'UPDATE CTE SET RETIRA = ';
    vCteStr := vCteStr + IntToStr(rgRetira.ItemIndex);
    vCteStr := vCteStr +  ',DET_RETIRA = ';
    vCteStr := vCteStr + QuotedStr(memDetRetira.Text);

    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;
end;

procedure TfCTePrincipal.EditarD;
begin
  if (edtNumCte.Text <> '') then
  begin
    vCteStr := 'UPDATE CTE SET VPREST = ';
    vCteStr:= vCteStr + FloatToStr(dmCte.cdsCteVPREST.AsFloat);
    if (dmCte.cdsCteVREC.AsFloat > 0) then
    begin
      vCteStr:= vCteStr +  ',VREC = ' + FloatToStr(dmCte.cdsCteVREC.AsFloat);
    end
    else begin
      vCteStr:= vCteStr +  ',VREC = ' + '0';
    end;
    vCteStr:= vCteStr +  ' ,VALTOTTRI = ';
    vCteStr:= vCteStr + FloatToStr(dmCte.cdsCteVALTOTTRI.AsFloat);
    vCteStr:= vCteStr +  ',COMBCODSITTRIB = ';
    vCteStr:= vCteStr + IntToStr(combCodSitTrib.ItemIndex);
    vCteStr += ',VALPREDBC = ' + FloatToStr(dmCte.cdsCteVALPREDBC.AsFloat);
    vCteStr += ',VALVBC = ' + FloatToStr(dmCte.cdsCteVALVBC.AsFloat);
    vCteStr += ',VALPICMS = ' + FloatToStr(dmCte.cdsCteVALPICMS.AsFloat);
    vCteStr += ',VALVICMS = ' + FloatToStr(dmCte.cdsCteVALVICMS.AsFloat);
    vCteStr += ',VALVCRED = ' + FloatToStr(dmCte.cdsCteVALVCRED.AsFloat);
    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;
end;

procedure TfCTePrincipal.EditarE;
begin
  if (edtNumCte.Text <> '') then
  begin
    vCteStr := 'UPDATE CTE SET VALINFCARGA = ';
    vCteStr:= vCteStr +  FloatToStr(dmCte.cdsCteVALINFCARGA.AsFloat);
    vCteStr:= vCteStr +  ', PROPRED = ';
    vCteStr:= vCteStr + QuotedStr(edtProPred.Text);
    vCteStr:= vCteStr +  ',OUTCAT = ';
    vCteStr:= vCteStr + QuotedStr(edtOutCat.Text);

    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;
end;

procedure TfCTePrincipal.EditarF;
begin
  if (edtNumCte.Text <> '') then
  begin
    vCteStr := 'UPDATE CTE SET RNTRC = ';
    vCteStr := vCteStr + QuotedStr(edtRodRNTRC.Text);
    vCteStr := vCteStr +  ',DATARODPREV = ';
    if (dataRodPrev.Checked) then
      vCteStr := vCteStr + QuotedStr(FormatDateTime('mm/dd/yyyy',dataRodPrev.date))
    else
      vCteStr := vCteStr +  ' NULL ';
    vCteStr := vCteStr +  ',RGRODLOTACAO = ';
    vCteStr := vCteStr + IntToStr(rgRodLotacao.ItemIndex);

    vCteStr += ',ANT_CNPJ = ' + QuotedStr(edtAntCNPJ.Text);
    vCteStr := vCteStr +  ',ANT_IE = ';
    vCteStr := vCteStr + QuotedStr(edtAntIE.Text);
    vCteStr := vCteStr +  ',ANT_UF = ';
    vCteStr := vCteStr + QuotedStr(edtAntUF.Text);
    vCteStr := vCteStr +  ',ANT_NOME = ';
    vCteStr := vCteStr + QuotedStr(edtAntNome.Text);
    vCteStr := vCteStr +  ',ANT_CHCTE = ';
    vCteStr := vCteStr + QuotedStr(edtAntCHCTE.Text);

    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;
end;

procedure TfCTePrincipal.EditarG;
begin
  if (edtNumCte.Text <> '') then
  begin
    vCteStr := 'UPDATE CTE SET OBS_GERAL = ';
    vCteStr:= vCteStr + QuotedStr(memxObs.Text);
    vCteStr := vCteStr +  ',OUTPDOC = ';
    vCteStr := vCteStr +  QuotedStr(Copy(combOutrosDocs.Text,1,2));
    vCteStr := vCteStr +  ',OUDESCOUTRO = ';
    vCteStr := vCteStr +  QuotedStr(edtOutrosDesc.Text);
    vCteStr := vCteStr +  ',OUNDOC = ';
    vCteStr := vCteStr +  QuotedStr(edtOutrosNum.Text);
    vCteStr := vCteStr +  ',OUDEMI = ';
    if (dataOutrosEmi.Checked) then
      vCteStr := vCteStr +  QuotedStr(FormatDateTime('mm/dd/yyyy',dataOutrosEmi.date))
    else
      vCteStr := vCteStr +  'NULL ';
    vCteStr := vCteStr +  ',OUVDOCFISC= ';
    vCteStr := vCteStr +  FloatToStr(dmCte.cdsCteOUVDOCFISC.AsFloat);

    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;
end;

procedure TfCTePrincipal.EditarEX;
begin
  if(rgExp.ItemIndex = 0) then        /// Conferir 22/12/22
  begin
    vCteStr := 'UPDATE CTE SET EX_CNPJCPF = ';
    vCteStr := vCteStr + QuotedStr(edtExpCNPJ.Text);
    vCteStr := vCteStr +  ',EX_IESTADUAL = ';
    vCteStr := vCteStr + QuotedStr(edtExpIE.Text);
    vCteStr := vCteStr +  ',EX_RSOCIAL = ';
    vCteStr := vCteStr + QuotedStr(edtExpRazao.Text);
    vCteStr := vCteStr +  ',EX_FANTASIA = ';
    vCteStr := vCteStr + QuotedStr(edtExpNome.Text);
    vCteStr := vCteStr +  ',EX_TELEFONE = ';
    vCteStr := vCteStr + QuotedStr(edtExpFone.Text);
    vCteStr := vCteStr +  ',EX_ENDERECO = ';
    vCteStr := vCteStr + QuotedStr(edtExpEnd.Text);
    vCteStr := vCteStr +  ',EX_NUMERO = ';
    vCteStr := vCteStr + QuotedStr(edtExpNum.Text);
    vCteStr := vCteStr +  ',EX_COMPLEMENTO = ';
    vCteStr := vCteStr + QuotedStr(edtExpComp.Text);
    vCteStr := vCteStr +  ',EX_BAIRRO = ';
    vCteStr := vCteStr + QuotedStr(edtExpBairro.Text);
    vCteStr := vCteStr +  ',EX_CODIGOMUNICIPI = ';
    vCteStr := vCteStr + QuotedStr(edtExpCodCidade.Text);
    vCteStr := vCteStr +  ',EX_CIDADE = ';
    vCteStr := vCteStr + QuotedStr(edtExpCidade.Text);
    vCteStr := vCteStr +  ',EX_CEP = ';
    vCteStr := vCteStr + QuotedStr(edtExpCep.Text);
    vCteStr := vCteStr +  ',EX_ESTADO = ';
    vCteStr := vCteStr + QuotedStr(edtExpUF.Text);

    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;

   if(rgExp.ItemIndex = 1) then        /// Conferir 04/09/19
  begin
    vCteStr := 'UPDATE CTE SET EX_CNPJCPF = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_IESTADUAL = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_RSOCIAL = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_FANTASIA = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_TELEFONE = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_ENDERECO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_NUMERO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_COMPLEMENTO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_BAIRRO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_CODIGOMUNICIPI = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_CIDADE = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_CEP = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',EX_ESTADO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;

end;

procedure TfCTePrincipal.EditarT;
begin
  if(rgTomador.ItemIndex <> 4) then
  begin
    vCteStr := 'UPDATE CTE SET  TOMADORSERVICO = ';
    vCteStr := vCteStr + IntToStr(rgTomador.ItemIndex);
    vCteStr := vCteStr + ',T_CNPJCPF = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_IESTADUAL = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_RSOCIAL = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_FANTASIA = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_TELEFONE = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_ENDERECO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_NUMERO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_COMPLEMENTO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_BAIRRO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_CODIGOMUNICIPI = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_CIDADE = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_CEP = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_ESTADO = ';
    vCteStr := vCteStr + QuotedStr('');

    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
  end;
  if(rgTomador.ItemIndex = 4) then
  begin
    vCteStr := 'UPDATE CTE SET  TOMADORSERVICO = ';
    vCteStr := vCteStr + IntToStr(rgTomador.ItemIndex);
    vCteStr := vCteStr + ', T_CNPJCPF = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_IESTADUAL = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_RSOCIAL = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_FANTASIA = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_TELEFONE = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_ENDERECO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_NUMERO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_COMPLEMENTO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_BAIRRO = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_CODIGOMUNICIPI = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_CIDADE = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_CEP = ';
    vCteStr := vCteStr + QuotedStr('');
    vCteStr := vCteStr +  ',T_ESTADO = ';
    vCteStr := vCteStr + QuotedStr('');

    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
  end;
  dmPdv.IbCon.ExecuteDirect(vCteStr);
end;

procedure TfCTePrincipal.EditarR;
begin
  if (edtRemCNPJ.Text <> '') then
  begin
    vCteStr := 'UPDATE CTE SET ';
    vCteStr := vCteStr + ' R_CNPJCPF = ' + QuotedStr(edtRemCNPJ.Text);
    if (edtRemIE.Text <> '') then
    begin
      vCteStr := vCteStr + ', R_IESTADUAL = ' + QuotedStr(edtRemIE.Text);
    end;
    if (edtRemRazao.Text <> '') then
    begin
      vCteStr := vCteStr + ', R_RSOCIAL = ' + QuotedStr(edtRemRazao.Text);
    end;
    vCteStr := vCteStr +  ',R_FANTASIA = ';
    vCteStr := vCteStr + QuotedStr(edtRemNome.Text);
    vCteStr := vCteStr +  ',R_TELEFONE = ';
    vCteStr := vCteStr + QuotedStr(edtRemFone.Text);
    vCteStr := vCteStr +  ',R_ENDERECO = ';
    vCteStr := vCteStr + QuotedStr(edtRemEnd.Text);
    vCteStr := vCteStr +  ',R_NUMERO = ';
    vCteStr := vCteStr + QuotedStr(edtRemNum.Text);
    vCteStr := vCteStr +  ',R_COMPLEMENTO = ';
    vCteStr := vCteStr + QuotedStr(edtRemComp.Text);
    vCteStr := vCteStr +  ',R_BAIRRO = ';
    vCteStr := vCteStr + QuotedStr(edtRemBairro.Text);
    vCteStr := vCteStr +  ',R_CODIGOMUNICIPI = ';
    vCteStr := vCteStr + QuotedStr(edtRemCodCidade.Text);
    vCteStr := vCteStr +  ',R_CIDADE = ';
    vCteStr := vCteStr + QuotedStr(edtRemCidade.Text);
    vCteStr := vCteStr +  ',R_CEP = ';
    vCteStr := vCteStr + QuotedStr(edtRemCep.Text);
    vCteStr := vCteStr +  ',R_ESTADO = ';
    vCteStr := vCteStr + QuotedStr(edtRemUF.Text);

    vCteStr := vCteStr +' where COD_CTE = ' ;
    vCteStr := vCteStr +  IntToStr(val_genCte);
    MemoDados.Text := vCteStr;
    dmPdv.IbCon.ExecuteDirect(vCteStr);
  end;
end;

procedure TfCTePrincipal.EditarDE;
begin
  if(rgDest.ItemIndex = 0) then
  begin
    if (edtDestCNPJ.Text <> '') then
    begin
      vCteStr := 'UPDATE CTE SET D_CNPJCPF = ';
      vCteStr := vCteStr + QuotedStr(edtDestCNPJ.Text);
      vCteStr := vCteStr +  ',D_IESTADUAL = ';
      vCteStr := vCteStr + QuotedStr(edtDestIE.Text);
      vCteStr := vCteStr +  ',D_RSOCIAL = ';
      vCteStr := vCteStr + QuotedStr(edtDestRazao.Text);
      vCteStr := vCteStr +  ',D_FANTASIA = ';
      vCteStr := vCteStr + QuotedStr(edtDestNome.Text);
      vCteStr := vCteStr +  ',D_TELEFONE = ';
      vCteStr := vCteStr + QuotedStr(edtDestFone.Text);
      vCteStr := vCteStr +  ',D_ENDERECO = ';
      vCteStr := vCteStr + QuotedStr(edtDestEnd.Text);
      vCteStr := vCteStr +  ',D_NUMERO = ';
      vCteStr := vCteStr + QuotedStr(edtDestNum.Text);
      vCteStr := vCteStr +  ',D_COMPLEMENTO = ';
      vCteStr := vCteStr + QuotedStr(edtDestComp.Text);
      vCteStr := vCteStr +  ',D_BAIRRO = ';
      vCteStr := vCteStr + QuotedStr(edtDestBairro.Text);
      vCteStr := vCteStr +  ',D_CODIGOMUNICIPI = ';
      vCteStr := vCteStr + QuotedStr(edtDestCodCidade.Text);
      vCteStr := vCteStr +  ',D_CIDADE = ';
      vCteStr := vCteStr + QuotedStr(edtDestCidade.Text);
      vCteStr := vCteStr +  ',D_CEP = ';
      vCteStr := vCteStr + QuotedStr(edtDestCep.Text);
      vCteStr := vCteStr +  ',D_ESTADO = ';
      vCteStr := vCteStr + QuotedStr(edtDestUF.Text);
      vCteStr := vCteStr +' where COD_CTE = ' ;
      vCteStr := vCteStr +  IntToStr(val_genCte);
      MemoDados.Text := vCteStr;
      dmPdv.IbCon.ExecuteDirect(vCteStr);
    end;
  end;
end;

procedure TfCTePrincipal.EditarREC;
begin
  if(rgRec.ItemIndex = 0) then        /// Conferir 22/12/2022
  begin
    if (edtRecCNPJ.Text <> '') then
    begin
      vCteStr := 'UPDATE CTE SET ';
      vCteStr := vCteStr + ' RE_CNPJCPF = ' + QuotedStr(edtRecCNPJ.Text);
      if (edtRecIE.Text <> '') then
      begin
        vCteStr := vCteStr + ',RE_IESTADUAL = ' + QuotedStr(edtRecIE.Text);
      end;
      if (edtRecRazao.Text <> '') then
      begin
        vCteStr := vCteStr + ',RE_RSOCIAL = ' + QuotedStr(edtRecRazao.Text);
      end;
      vCteStr := vCteStr +  ',RE_FANTASIA = ';
      vCteStr := vCteStr + QuotedStr(edtRecNome.Text);
      vCteStr := vCteStr +  ',RE_TELEFONE = ';
      vCteStr := vCteStr + QuotedStr(edtRecFone.Text);
      vCteStr := vCteStr +  ',RE_ENDERECO = ';
      vCteStr := vCteStr + QuotedStr(edtRecEnd.Text);
      vCteStr := vCteStr +  ',RE_NUMERO = ';
      vCteStr := vCteStr + QuotedStr(edtRecNum.Text);
      vCteStr := vCteStr +  ',RE_COMPLEMENTO = ';
      vCteStr := vCteStr + QuotedStr(edtRecComp.Text);
      vCteStr := vCteStr +  ',RE_BAIRRO = ';
      vCteStr := vCteStr + QuotedStr(edtRecBairro.Text);
      vCteStr := vCteStr +  ',RE_CODIGOMUNICIPI = ';
      vCteStr := vCteStr + QuotedStr(edtRecCodCidade.Text);
      vCteStr := vCteStr +  ',RE_CIDADE = ';
      vCteStr := vCteStr + QuotedStr(edtRecCidade.Text);
      vCteStr := vCteStr +  ',RE_CEP = ';
      vCteStr := vCteStr + QuotedStr(edtRecCep.Text);
      vCteStr := vCteStr +  ',RE_ESTADO = ';
      vCteStr := vCteStr + QuotedStr(edtRecUF.Text);

      vCteStr := vCteStr +' where COD_CTE = ' ;
      vCteStr := vCteStr +  IntToStr(val_genCte);
      MemoDados.Text := vCteStr;
      dmPdv.IbCon.ExecuteDirect(vCteStr);
    end;
  end;

  if(rgRec.ItemIndex = 1) then
  begin
    if (edtRecCNPJ.Text <> '') then
    begin
      vCteStr := 'UPDATE CTE SET ';
      vCteStr := vCteStr + ' RE_CNPJCPF = ' + QuotedStr('');
      if (edtRecIE.Text <> '') then
      begin
        vCteStr := vCteStr + ',RE_IESTADUAL = ' + QuotedStr('');
      end;
      if (edtRecRazao.Text <> '') then
      begin
        vCteStr := vCteStr + ',RE_RSOCIAL = ' + QuotedStr('');
      end;
      vCteStr := vCteStr +  ',RE_FANTASIA = ';
      vCteStr := vCteStr + QuotedStr('');
      vCteStr := vCteStr +  ',RE_TELEFONE = ';
      vCteStr := vCteStr + QuotedStr('');
      vCteStr := vCteStr +  ',RE_ENDERECO = ';
      vCteStr := vCteStr + QuotedStr('');
      vCteStr := vCteStr +  ',RE_NUMERO = ';
      vCteStr := vCteStr + QuotedStr('');
      vCteStr := vCteStr +  ',RE_COMPLEMENTO = ';
      vCteStr := vCteStr + QuotedStr('');
      vCteStr := vCteStr +  ',RE_BAIRRO = ';
      vCteStr := vCteStr + QuotedStr('');
      vCteStr := vCteStr +  ',RE_CODIGOMUNICIPI = ';
      vCteStr := vCteStr + QuotedStr('');
      vCteStr := vCteStr +  ',RE_CIDADE = ';
      vCteStr := vCteStr + QuotedStr('');
      vCteStr := vCteStr +  ',RE_CEP = ';
      vCteStr := vCteStr + QuotedStr('');
      vCteStr := vCteStr +  ',RE_ESTADO = ';
      vCteStr := vCteStr + QuotedStr('');

      vCteStr := vCteStr +' where COD_CTE = ' ;
      vCteStr := vCteStr +  IntToStr(val_genCte);
      MemoDados.Text := vCteStr;
      dmPdv.IbCon.ExecuteDirect(vCteStr);
    end;
  end;

end;

procedure TfCTePrincipal.cadastraClientes(camposCliente, camposEnd: String);
var strEndereco: String;
begin
  generetor := dmPdv.busca_generator('GEN_CLI');
  strInsere := 'INSERT INTO CLIENTES (CODCLIENTE, NOMECLIENTE, RAZAOSOCIAL, TIPOFIRMA ' +
              ', CNPJ, INSCESTADUAL, SEGMENTO, REGIAO, DATACADASTRO  , CODUSUARIO, STATUS ' +
              ') VALUES (' + IntToStr(generetor) +', ';
  strInsere := strInsere + camposCliente + ')';
  {
  strInsere := strInsere +   IntToStr(generetor);
  strInsere := strInsere + ', ' + QuotedStr(edtXMLNome.Text);
  strInsere := strInsere + ', ' + QuotedStr(edtXMLRazao.Text);
  strInsere := strInsere + ', ' + IntToStr(1);
  strInsere := strInsere + ', ' + QuotedStr(edtXMLCnpj.Text);
  strInsere := strInsere + ', ' + QuotedStr(edtXMLIE.Text);
  strInsere := strInsere + ', ' + IntToStr(1);
  strInsere := strInsere + ', ' + IntToStr(1);
  strInsere := strInsere + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now));
  strInsere := strInsere + ', ' + IntToStr(1);
  strInsere := strInsere + ', ' + IntToStr(1);
  strInsere := strInsere + ')';
  }
  strEndereco := 'INSERT INTO ENDERECOCLIENTE (CODENDERECO , CODCLIENTE, ' +
               ' LOGRADOURO , BAIRRO, COMPLEMENTO '+
               ', CIDADE , UF , CEP , TELEFONE , TIPOEND , DDD , ' +
               ' NUMERO, CD_IBGE, PAIS  ' +
               ') VALUES (GEN_ID(GEN_CLI_END,1), ' + IntToStr(generetor) + ', ';
  strEndereco := strEndereco + camposEnd + ')';
  {
  strEndereco := strEndereco +   IntToStr(generetor);
  generetor := dmPdv.busca_generator('GEN_CLI_END');
  strEndereco := strEndereco + ', ' + IntToStr(generetor);
  strEndereco := strEndereco + ', ' + QuotedStr(edtXMLLogradouro.Text);
  strEndereco := strEndereco + ', ' + QuotedStr(edtXMLBairro.Text);
  strEndereco := strEndereco + ', ' + QuotedStr(edtXMLComp.Text);
  strEndereco := strEndereco + ', ' + QuotedStr(edtXMLCidade.Text);
  strEndereco := strEndereco + ', ' + QuotedStr(edtXMLUF.Text);
  strEndereco := strEndereco + ', ' + QuotedStr(edtXMLCEP.Text);
  strEndereco := strEndereco + ', ' + QuotedStr(Copy(edtXMLFone.Text,2,12));
  strEndereco := strEndereco + ', ' + IntToStr(0);
  strEndereco := strEndereco + ', ' + QuotedStr(Copy(edtXMLFone.Text,0,2));
  strEndereco := strEndereco + ', ' + QuotedStr(edtXMLNumero.Text);
  strEndereco := strEndereco + ', ' + QuotedStr(edtXMLCodCidade.Text);
  strEndereco := strEndereco + ', ' + QuotedStr('Brasil');
  strEndereco := strEndereco + ')';
  }
  try
   dmPdv.IbCon.ExecuteDirect(strInsere);
   dmPdv.IbCon.ExecuteDirect(strEndereco);
   dmPdv.sTrans.Commit;
  except
   on E : Exception do
   begin
     ShowMessage('Cadastro do Cliente, não pode ser criado, Classe: ' +
       e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
     dmPdv.sTrans.Rollback;
     exit;
   end;
  end;

end;

procedure TfCTePrincipal.buscaDestinatario;
begin
  if (edtDestBusca.Text <> '') then
  begin
    dmPdv.busca_sql('SELECT c.NOMECLIENTE, c.RAZAOSOCIAL, c.CNPJ, ' +
      ' c.INSCESTADUAL, d.LOGRADOURO, d.NUMERO, d.CIDADE, d.BAIRRO, ' +
      ' d.CEP, d.UF, d.CD_IBGE, d.DDD , d.TELEFONE  ' +
      ' FROM CLIENTES c, ENDERECOCLIENTE d ' +
      ' WHERE c.CODCLIENTE = d.CODCLIENTE ' +
      ' AND d.TIPOEND = 0 AND c.CODCLIENTE = ' + edtDestBusca.Text);
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('Código do Cliente não existe.');
      Exit;
    end;
    edtDestCodCidade.Text := dmPdv.sqBusca.FieldByName('CD_IBGE').AsString;
    edtDestCidade.Text := dmPdv.sqBusca.FieldByName('CIDADE').AsString;
    edtDestUF.Text := dmPdv.sqBusca.FieldByName('UF').AsString;
    edtDestNome.Text := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;
    edtDestRazao.Text := dmPdv.sqBusca.FieldByName('RAZAOSOCIAL').AsString;
    edtDestCNPJ.Text := dmPdv.sqBusca.FieldByName('CNPJ').AsString;
    edtDestIE.Text := dmPdv.sqBusca.FieldByName('INSCESTADUAL').AsString;
    edtDestFone.Text := dmPdv.sqBusca.FieldByName('DDD').AsString +
      '-' + dmPdv.sqBusca.FieldByName('TELEFONE').AsString;
    edtDestEnd.Text := dmPdv.sqBusca.FieldByName('LOGRADOURO').AsString;
    edtDestNum.Text := dmPdv.sqBusca.FieldByName('NUMERO').AsString;
    edtDestCidade.Text := dmPdv.sqBusca.FieldByName('CIDADE').AsString;
    edtDestBairro.Text := dmPdv.sqBusca.FieldByName('BAIRRO').AsString;
    edtDestCep.TExt := dmPdv.sqBusca.FieldByName('CEP').AsString;
    edtDestUF.Text := dmPdv.sqBusca.FieldByName('UF').AsString;
    if (Trim(edtFimUF.Text) = '') then
    begin
      edtFimUF.Text := edtDestUF.Text;
      edtFimCidade.Text := edtDestCidade.Text;
      edtFimCodCidade.TExt := edtDestCodCidade.Text;
    end;
  end;
end;

procedure TfCTePrincipal.buscaTomador;
begin
  if (edtBuscaTomador.Text <> '') then
  begin
    dmPdv.busca_sql('SELECT c.NOMECLIENTE, c.RAZAOSOCIAL, c.CNPJ, ' +
      ' c.INSCESTADUAL, d.LOGRADOURO, d.NUMERO, d.CIDADE, d.BAIRRO, ' +
      ' d.CEP, d.UF, d.CD_IBGE, d.DDD , d.TELEFONE  ' +
      ' FROM CLIENTES c, ENDERECOCLIENTE d ' +
      ' WHERE c.CODCLIENTE = d.CODCLIENTE ' +
      ' AND d.TIPOEND = 0 AND c.CODCLIENTE = ' + edtBuscaTomador.Text);
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('Código do Cliente não existe.');
      Exit;
    end;
    edtTomadorCodCidade.Text := dmPdv.sqBusca.FieldByName('CD_IBGE').AsString;
    edtTomadorCidade.Text := dmPdv.sqBusca.FieldByName('CIDADE').AsString;
    edtTomadorUF.Text := dmPdv.sqBusca.FieldByName('UF').AsString;
    edtNomeTomador.Text := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;
    edtRazaoTomador.Text := dmPdv.sqBusca.FieldByName('RAZAOSOCIAL').AsString;
    edtCNPJTomador.Text := dmPdv.sqBusca.FieldByName('CNPJ').AsString;
    edtIETomador.Text := dmPdv.sqBusca.FieldByName('INSCESTADUAL').AsString;
    edtFoneTomador.Text := dmPdv.sqBusca.FieldByName('DDD').AsString +
      '-' + dmPdv.sqBusca.FieldByName('TELEFONE').AsString;
    edtEndTomador.Text := dmPdv.sqBusca.FieldByName('LOGRADOURO').AsString;
    edtNumTomador.Text := dmPdv.sqBusca.FieldByName('NUMERO').AsString;
    edtBairroTomador.Text := dmPdv.sqBusca.FieldByName('BAIRRO').AsString;
    edtCepTomador.TExt := dmPdv.sqBusca.FieldByName('CEP').AsString;
  end;
end;

procedure TfCTePrincipal.buscaRemetente;
begin
  if (edtRemBusca.Text <> '') then
  begin
    dmPdv.busca_sql('SELECT c.NOMECLIENTE, c.RAZAOSOCIAL, c.CNPJ, ' +
      ' c.INSCESTADUAL, d.LOGRADOURO, d.NUMERO, d.CIDADE, d.BAIRRO, ' +
      ' d.CEP, d.UF, d.CD_IBGE, d.DDD , d.TELEFONE  ' +
      ' FROM CLIENTES c, ENDERECOCLIENTE d ' +
      ' WHERE c.CODCLIENTE = d.CODCLIENTE ' +
      ' AND d.TIPOEND = 0 AND c.CODCLIENTE = ' + edtRemBusca.Text);
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('Código do Cliente não existe.');
      Exit;
    end;
    edtRemCodCidade.Text := dmPdv.sqBusca.FieldByName('CD_IBGE').AsString;
    edtRemCidade.Text := dmPdv.sqBusca.FieldByName('CIDADE').AsString;
    edtRemUF.Text := dmPdv.sqBusca.FieldByName('UF').AsString;
    edtRemNome.Text := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;
    edtRemRazao.Text := dmPdv.sqBusca.FieldByName('RAZAOSOCIAL').AsString;
    edtRemCNPJ.Text := dmPdv.sqBusca.FieldByName('CNPJ').AsString;
    edtRemIE.Text := dmPdv.sqBusca.FieldByName('INSCESTADUAL').AsString;
    edtRemFone.Text := dmPdv.sqBusca.FieldByName('DDD').AsString +
      '-' + dmPdv.sqBusca.FieldByName('TELEFONE').AsString;
    edtRemEnd.Text := dmPdv.sqBusca.FieldByName('LOGRADOURO').AsString;
    edtRemNum.Text := dmPdv.sqBusca.FieldByName('NUMERO').AsString;
    edtRemBairro.Text := dmPdv.sqBusca.FieldByName('BAIRRO').AsString;
    edtRemCep.TExt := dmPdv.sqBusca.FieldByName('CEP').AsString;
    if (Trim(edtIniUf.Text) = '') then
    begin
      edtIniUf.Text := edtRemUF.Text;
      edtIniCidade.Text := edtRemCidade.Text;
      edtIniCodCidade.TExt := edtRemCodCidade.Text;
    end;
  end;
end;

procedure TfCTePrincipal.buscaExpedidor;
begin
  if (edtExpBusca.Text <> '') then
  begin
    dmPdv.busca_sql('SELECT c.NOMECLIENTE, c.RAZAOSOCIAL, c.CNPJ, ' +
      ' c.INSCESTADUAL, d.LOGRADOURO, d.NUMERO, d.CIDADE, d.BAIRRO, ' +
      ' d.CEP, d.UF, d.CD_IBGE, d.DDD , d.TELEFONE  ' +
      ' FROM CLIENTES c, ENDERECOCLIENTE d ' +
      ' WHERE c.CODCLIENTE = d.CODCLIENTE ' +
      ' AND d.TIPOEND = 0 AND c.CODCLIENTE = ' + edtExpBusca.Text);
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('Código do Cliente não existe.');
      Exit;
    end;
    edtExpCodCidade.Text := LimparString(dmPdv.sqBusca.FieldByName('CD_IBGE').AsString,'-');
    edtExpCidade.Text := dmPdv.sqBusca.FieldByName('CIDADE').AsString;
    edtExpUF.Text := dmPdv.sqBusca.FieldByName('UF').AsString;
    edtExpNome.Text := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;
    edtExpRazao.Text := dmPdv.sqBusca.FieldByName('RAZAOSOCIAL').AsString;
    edtExpCNPJ.Text := dmPdv.sqBusca.FieldByName('CNPJ').AsString;
    edtExpIE.Text := dmPdv.sqBusca.FieldByName('INSCESTADUAL').AsString;
    edtExpFone.Text := dmPdv.sqBusca.FieldByName('DDD').AsString +
      '-' + dmPdv.sqBusca.FieldByName('TELEFONE').AsString;
    edtExpEnd.Text := dmPdv.sqBusca.FieldByName('LOGRADOURO').AsString;
    edtExpNum.Text := dmPdv.sqBusca.FieldByName('NUMERO').AsString;
    edtExpBairro.Text := dmPdv.sqBusca.FieldByName('BAIRRO').AsString;
    edtExpCep.TExt := dmPdv.sqBusca.FieldByName('CEP').AsString;
  end;
end;

procedure TfCTePrincipal.buscaRecebedor;
begin
  if (edtRecBusca.Text <> '') then
  begin
    dmPdv.busca_sql('SELECT c.NOMECLIENTE, c.RAZAOSOCIAL, c.CNPJ, ' +
      ' c.INSCESTADUAL, d.LOGRADOURO, d.NUMERO, d.CIDADE, d.BAIRRO, ' +
      ' d.CEP, d.UF, d.CD_IBGE, d.DDD , d.TELEFONE  ' +
      ' FROM CLIENTES c, ENDERECOCLIENTE d ' +
      ' WHERE c.CODCLIENTE = d.CODCLIENTE ' +
      ' AND d.TIPOEND = 0 AND c.CODCLIENTE = ' + edtRecBusca.Text);
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('Código do Cliente não existe.');
      Exit;
    end;
    edtRecCodCidade.Text := LimparString(dmPdv.sqBusca.FieldByName('CD_IBGE').AsString,'-');
    edtRecCidade.Text := dmPdv.sqBusca.FieldByName('CIDADE').AsString;
    edtRecUF.Text := dmPdv.sqBusca.FieldByName('UF').AsString;
    edtRecNome.Text := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;
    edtRecRazao.Text := dmPdv.sqBusca.FieldByName('RAZAOSOCIAL').AsString;
    edtRecCNPJ.Text := dmPdv.sqBusca.FieldByName('CNPJ').AsString;
    edtRecIE.Text := dmPdv.sqBusca.FieldByName('INSCESTADUAL').AsString;
    edtRecFone.Text := dmPdv.sqBusca.FieldByName('DDD').AsString +
      '-' + dmPdv.sqBusca.FieldByName('TELEFONE').AsString;
    edtRecEnd.Text := dmPdv.sqBusca.FieldByName('LOGRADOURO').AsString;
    edtRecNum.Text := dmPdv.sqBusca.FieldByName('NUMERO').AsString;
    edtRecBairro.Text := dmPdv.sqBusca.FieldByName('BAIRRO').AsString;
    edtRecCep.TExt := dmPdv.sqBusca.FieldByName('CEP').AsString;
  end;
end;

function TfCTePrincipal.LimparString(ATExto, ACaracteres: string): string;
 var
   strAux            : string;
   I                 : integer;
 begin
   strAux := '';
   ACaracteres := '-';
   for I := 1 to Length(ATexto) do
     if Pos(Copy(ATexto, I, 1), ACaracteres) <= 0 then
       strAux := strAux + Copy(ATexto, I, 1);
   Result := strAux;
end;

function TfCTePrincipal.GravarCTe: String;
var verVlr: String;
begin
  if (edtEmitCNPJ.Text <> '') then
  begin
    val_genCte := dmPdv.busca_generator('GEN_CTE');
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
      ',ANT_CNPJ,ANT_IE,ANT_UF,ANT_NOME,ANT_CHCTE,VALPREDBC,VALVBC,VALPICMS,VALVICMS,VALVCRED';
    if (Trim(edtModelo.Text) = '67') then
    begin
      strInsere += ', UFPER , INFADFISCO, VPIS, VCOFINS, VIR, VINSS, VCSLL';
      strInsere += ', XDESCSERV, QCARGA, TPSERV, TAF, NROREGESTADUAL, VEICRENAVAM';
      strInsere += ', VEICPLACA, VEIUF, OBSCONT, TCPF, TCNPJ, TTAF, TNROREGESTADUAL';
      strInsere += ', TXNOME, TIE, TUF, TTPPROP, TUFT, OBSFISCO';
    end;
    strInsere += ') VALUES ( ';
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
    strInsere := strInsere + ', ' + QuotedStr(FormatDateTime(
      'mm/dd/yyyy hh:nn:ss',dataGerarCte.DateTime));  ///DHEMI
    strInsere := strInsere + ', ' + IntToStr(rgModal.ItemIndex);  //MODAL
    strInsere := strInsere + ', ' + IntToStr(rgTipoServico.ItemIndex);  // TIPOSERVICO
    strInsere := strInsere + ', ' + IntToStr(rgTiposCte.ItemIndex);     // TIPOCTE
    strInsere := strInsere + ', ' + IntToStr(rgFormaEmissao.ItemIndex); // TPOEMISSAO
    strInsere := strInsere + ', ' + IntToStr(rgForPag.ItemIndex);       // IFORPAG
    strInsere := strInsere + ', ' + IntToStr(rgTipoDACTe.ItemIndex);    // TPIMP

    strInsere := strInsere + ', ' + QuotedStr(Trim(edtEnvCodCidade.Text));  // ENV_CODCIDADE
    strInsere := strInsere + ', ' + QuotedStr(Trim(edtEnvCidade.Text));   // ENV_CIDADE
    strInsere := strInsere + ', ' + QuotedStr(Trim(edtEnvUF.Text));     // ENV_ESTADO
    strInsere := strInsere + ', ' + QuotedStr(Trim(edtIniCodCidade.Text)); // INI_CODCIDADE
    strInsere := strInsere + ', ' + QuotedStr(Trim(edtIniCidade.Text)); // INI_CIDADE
    strInsere := strInsere + ', ' + QuotedStr(Trim(edtIniUF.Text));    // INI_ESTADO
    strInsere := strInsere + ', ' + QuotedStr(Trim(edtFimCodCidade.Text));  // FIM_CODCIDADE
    strInsere := strInsere + ', ' + QuotedStr(Trim(edtFimCidade.Text)); // FIM_CIDADE
    strInsere := strInsere + ', ' + QuotedStr(Trim(edtFimUF.Text));  // FIM_ESTADO

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
    verVlr := FloatToStr(dmCte.cdsCteVPREST.AsFloat);
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteVPREST.AsFloat);
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteVREC.AsFloat);
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteVALTOTTRI.AsFloat);
    strInsere := strInsere + ', ' + QuotedStr(combCodSitTrib.ItemIndex.ToString);
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteVALINFCARGA.AsFloat);
    strInsere := strInsere + ', ' + QuotedStr(edtProPred.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtOutCat.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtRodRNTRC.Text);
    if (dataRodPrev.Checked) then
      strInsere := strInsere + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',dataRodPrev.date))
    else
      strInsere := strInsere + ', NULL';
    strInsere := strInsere + ', ' + IntToStr(rgRodLotacao.ItemIndex);
    strInsere := strInsere + ', ' + QuotedStr(memxObs.Text);
    // outros docs
    strInsere := strInsere + ', ' + QuotedStr(combOutrosDocs.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtOutrosDesc.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtOutrosNum.Text);
    if (dataRodPrev.Checked) then
      strInsere := strInsere + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',dataRodPrev.date))
    else
      strInsere := strInsere + ', NULL';
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteOUVDOCFISC.AsFloat);
    // Esse é o ultimo Campo do Insert ' EMITENTE'
    strInsere := strInsere + ', ' + QuotedStr(edtCodEmitente.Text);
   // docs anterior 15/08/19
    strInsere := strInsere + ', ' + QuotedStr(edtAntCNPJ.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtAntIE.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtAntUF.Text );
    strInsere := strInsere + ', ' + QuotedStr(edtAntNome.Text);
    strInsere := strInsere + ', ' + QuotedStr(edtAntCHCTE.Text);
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteVALPREDBC.AsFloat);
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteVALVBC.AsFloat);
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteVALPICMS.AsFloat);
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteVALVICMS.AsFloat);
    strInsere := strInsere + ', ' + FloatToStr(dmCte.cdsCteVALVCRED.AsFloat);

    {strInsere += ', UFPER , INFADFISCO, VPIS, VCOFINS, VIR, VINSS, VCSLL';
    strInsere += ', XDESCSERV, QCARGA, TPSERV, TAF, NROREGESTADUAL, VEICRENAVAM';
    strInsere += ', VEICPLACA, VEIUF, OBSCONT, TCPF, TCNPJ, TTAF, TNROREGESTADUAL';
    strInsere += ', TXNOME, TIE, TUF, TTPPROP, TUFT, OBSFISCO}

    if (Trim(edtModelo.Text) = '67') then
    begin
      DecimalSeparator := '.';
      strInsere += ', ' + QuotedStr(Trim(edtFimUF.Text));
      if (Trim(memInfAdFisco.Text) <> '') then
        strInsere += ', ' + QuotedStr(Trim(memInfAdFisco.Text))
      else
        strInsere += ', NULL';
      strInsere += ', ' + FloatToStr(dmCte.cdsCteVPIS.AsFloat);
      strInsere += ', ' + FloatToStr(dmCte.cdsCteVCOFINS.AsFloat);
      strInsere += ', ' + FloatToStr(dmCte.cdsCteVIR.AsFloat);
      strInsere += ', ' + FloatToStr(dmCte.cdsCteVINSS.AsFloat);
      strInsere += ', ' + FloatToStr(dmCte.cdsCteVCSLL.AsFloat);

      DecimalSeparator := ',';
    end;

    strInsere := strInsere + ')';
    MemoDados.Text := strInsere;
    result := strInsere;
  end
  else
    result := '1';
  FormatSettings.DecimalSeparator := ',';
end;

procedure TfCTePrincipal.AtualizaSSLLibsCombo;
begin
 cbSSLLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLLib );
 cbCryptLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLCryptLib );
 cbHttpLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLHttpLib );
 cbXmlSignLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLXmlSignLib );

 cbSSLType.Enabled := (ACBrNFe1.Configuracoes.Geral.SSLHttpLib in [httpWinHttp, httpOpenSSL]) ;
end;

procedure TfCTePrincipal.dbValTotPrestExit(Sender: TObject);
begin
  if ((modoGravacao = 'EDITAR') or (modoGravacao = 'INSERIR')) then
  begin
    dmCte.cdsCteVREC.AsFloat := dmCte.cdsCteVPREST.AsFloat;
    if combCodSitTrib.ItemIndex < 6 then
        dmCte.cdsCteVALVBC.AsFloat := dmCte.cdsCteVPREST.AsFloat;
    dmCte.cdsCteVALVICMS.AsFloat := dmCte.cdsCteVPREST.AsFloat *
      (dmCte.cdsCteVALPICMS.AsFloat/100);
  end;
end;

procedure TfCTePrincipal.dbValTotPrestKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TfCTePrincipal.dbValTotTriChange(Sender: TObject);
begin
  if (dmCte.cdsCte.State in [dsInactive, dsBrowse]) then
  begin
    if (dmCte.cdsCteVALTOTTRI.NewValue <> dmCte.cdsCteVALTOTTRI.OldValue) then
    begin
      if (Trim(dmCte.cdsCTENPROT.AsString) = '') then
      begin
        if (modoInicio = 'ALTERAR') then
          if ((modoGravacao <> 'EDITAR') and (modoGravacao <> 'INCLUIR')) then
             modoGravacao := 'EDITAR';
        if (modoInicio = 'NOVO') then
          if ((modoGravacao <> 'EDITAR') and (modoGravacao <> 'INCLUIR')) then
             modoGravacao := 'INCLUIR';
      end;
    end;
  end;

end;

procedure TfCTePrincipal.dgGridCTEDblClick(Sender: TObject);
begin
  btnEditarCte.Click;
end;



procedure TfCTePrincipal.edtBuscaTomadorExit(Sender: TObject);
begin
  buscaTomador;
end;


procedure TfCTePrincipal.edtCfopExit(Sender: TObject);
begin
  if (edtCfop.Text <> '') then
  begin
    dmPdv.busca_sql('SELECT * FROM CFOP WHERE CFCOD = ' +
      QuotedStr(edtCfop.Text));
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('Este CFOP não existe.');
      Exit;
    end;
    edtCFOP.Text := LimparString(dmPdv.sqBusca.FieldByName('CFCOD').AsString,'-');
    edtNatOpe.Text := Copy(dmPdv.sqBusca.FieldByName('CFNOME').AsString,1,60);
  end;
end;

procedure TfCTePrincipal.edtCompChange(Sender: TObject);
begin

end;

procedure TfCTePrincipal.edtCteImportarClick(Sender: TObject);
begin
end;

procedure TfCTePrincipal.edtDestBuscaExit(Sender: TObject);
begin

end;

procedure TfCTePrincipal.edtDestNome1Change(Sender: TObject);
begin

end;

procedure TfCTePrincipal.edtDestNome1KeyPress(Sender: TObject; var Key: char);
begin
  if (key = #13) then
  begin
    key:= #0;
    SelectNext((Sender as TwinControl),True,True);
    btnListarCte.Click;
  end;
end;

procedure TfCTePrincipal.edtEmitCompChange(Sender: TObject);
begin

end;

procedure TfCTePrincipal.edtEmitenteCteChange(Sender: TObject);
begin

end;

procedure TfCTePrincipal.edtExpBuscaExit(Sender: TObject);
begin
  buscaExpedidor;
end;


procedure TfCTePrincipal.edtRecBuscaExit(Sender: TObject);
begin
  buscaRecebedor;
end;

procedure TfCTePrincipal.edtRemBuscaExit(Sender: TObject);
begin
  buscaRemetente;
end;

procedure TfCTePrincipal.BitBtn20Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.btnAtualizarBDClick(Sender: TObject);
begin
  dmPdv.executaDSql('ALTER TABLE CTE_VEICULOS ADD VALINFCARGA DOUBLE PRECISION');
  dmPdv.executaDSql('ALTER TABLE CTE_VEICULOS ADD CNPJ VARCHAR(20)');
  dmPdv.executaDSql('ALTER TABLE CTE_VEICULOS ADD RNTRC VARCHAR(8)');
  dmPdv.executaDSql('ALTER TABLE CTE_VEICULOS ADD NOME VARCHAR(60)');
  dmPdv.executaDSql('ALTER TABLE CTE_VEICULOS ADD IE VARCHAR(20)');
  dmPdv.executaDSql('ALTER TABLE CTE_VEICULOS ADD VTPPROP INTEGER');
  dmPdv.executaDSql('ALTER TABLE CTE_VEICULOS ADD VUF VARCHAR(2)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD STATUS VARCHAR(60)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD VALINFCARGA DOUBLE PRECISION');
  dmPdv.executaDSql('ALTER TABLE CTE ADD PROPRED VARCHAR(60)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD OUTCAT VARCHAR(30)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RNTRC VARCHAR(8)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD DATARODPREV DATE');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RGRODLOTACAO INTEGER');
  dmPdv.executaDSql('ALTER TABLE CTE ADD OBS_GERAL VARCHAR(300)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD NPROT VARCHAR(20)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD CHCTE VARCHAR(50)');
  dmPdv.executaDSql('ALTER TABLE SERIES ADD SERIE_CTE VARCHAR(3)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RECEBEDOR INTEGER');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_RG VARCHAR( 20 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_CNPJCPF VARCHAR( 20 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_IESTADUAL VARCHAR( 20 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_RSOCIAL VARCHAR( 60 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_FANTASIA VARCHAR( 60 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_TELEFONE VARCHAR( 15 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_ENDERECO VARCHAR( 60 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_NUMERO VARCHAR( 10 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_COMPLEMENTO VARCHAR( 60 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_BAIRRO VARCHAR( 60 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_CODIGOMUNICIPI VARCHAR( 10 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_CIDADE  VARCHAR(60)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_CEP VARCHAR(10)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_ESTADO CHAR(2)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_CODIGOPAIS INTEGER');
  dmPdv.executaDSql('ALTER TABLE CTE ADD RE_PAIS VARCHAR( 60 )');
  dmPdv.executaDSql('ALTER TABLE CTE ADD OutpDoc  VARCHAR(2)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD OudescOutro VARCHAR(100)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD OuNDoc  VARCHAR(20)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD OuDEmi  TIMESTAMP');
  dmPdv.executaDSql('ALTER TABLE CTE ADD OuVDocFisc DOUBLE PRECISION');
  dmPdv.executaDSql('ALTER TABLE CTE ADD ANT_CNPJ VARCHAR(20)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD ANT_IE VARCHAR(20)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD ANT_UF  VARCHAR(2)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD ANT_NOME  VARCHAR(60)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD ANT_CHCTE  VARCHAR(60)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD IN_IMPOSTOS INTEGER');
  dmPdv.executaDSql('ALTER TABLE CTE ADD valpRedBC DOUBLE PRECISION');
  dmPdv.executaDSql('ALTER TABLE CTE ADD valvBC DOUBLE PRECISION');
  dmPdv.executaDSql('ALTER TABLE CTE ADD valpICMS DOUBLE PRECISION');
  dmPdv.executaDSql('ALTER TABLE CTE ADD valvICMS DOUBLE PRECISION');
  dmPdv.executaDSql('ALTER TABLE CTE ADD valvCred DOUBLE PRECISION');
  dmPdv.executaDSql('ALTER TABLE CTE ADD NPROTCANCEL VARCHAR(30)');
  dmPdv.executaDSql('ALTER TABLE CTE ADD STATUS_CTE  VARCHAR(30)');
  //dmPdv.executaDSql('');
end;

procedure TfCTePrincipal.btnCancelarCteClick(Sender: TObject);
var
 vAux ,strEdita : String;
begin
  if (edCteCancelar.Text = '') then
  begin
    ShowMessage('Informe o Número da CTe para fazer o Cancelamento.');
    edCteCancelar.SetFocus;
    exit;
  end;
  ACBrCTe1.Conhecimentos.Clear;
  CarregarXML(dmCte.cdsCteCHCTE.AsString);
  if (acbrCte1.Conhecimentos.Items[0].CTe.ide.nCT <> StrToInt(edCteCancelar.Text)) then
  begin
    ShowMessage('XML da CTe diferente do númeto CTe informado.');
    edCteCancelar.SetFocus;
    exit;
  end;

  if not(InputQuery('WebServices Cancelamento', 'Justificativa', vAux))
    then exit;
  {
  with ACBrCTe1.EventoCTe.Evento.Add do
  begin
    InfEvento.nSeqEvento := 1;
    InfEvento.chCTe := dmCte.cdsCteCHCTE.AsString;
    InfEvento.CNPJ :=  dmpdv.sqEmpresaCNPJ_CPF.AsString;
    InfEvento.dhEvento := Now;
    infEvento.tpEvento := teCancelamento;
    infEvento.detEvento.xJust := vAux;
    InfEvento.detEvento.UF := Trim(dmPdv.sqEmpresaUF.AsString);
    infEvento.detEvento.nProt := dmCte.cdsCteNPROT.AsString;
  end;}
  ACBrCTe1.Cancelamento(vAux, 1);
  MemoResp.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.EnvEvento.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.EnvEvento.RetWS);
  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Cancelar CTe status');
  MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrCTe1.WebServices.EnvEvento.cStat));
  MemoDados.Lines.Add('xMotivo: '+ ACBrCTe1.WebServices.EnvEvento.xMotivo);
  MemoDados.Lines.Add('xMsg: '+ ACBrCTe1.WebServices.EnvEvento.Msg);
  //MemoDados.Lines.Add('Protocolo: '+ ACBrCTe1.WebServices.EnvEvento.EventoRetorno.InfEvento.p Retorno.Protocolo .Protocolo);
  // TODO descomentar abaixo

  //if (dmCte.cdsCTESTATUS_CTE.AsString = '')then
  begin
    //strEdita := 'UPDATE CTE SET NPROTCANCEL = ';
    //strEdita := strEdita + QuotedStr(ACBrCTe1.WebServices.Retorno.Protocolo);
    // nao tem protocolo cancelamento
    strEdita := strEdita + 'UPDATE CTE SET  STATUS_CTE = ';
    strEdita := strEdita + QuotedStr('CTe CANCELADA');
    strEdita := strEdita + ' WHERE CTE_NUMERO = ';
    strEdita := strEdita + (edCteCancelar.Text); // corrigido manoel 24/03/2022(edtNumCte.Text);
    try
      dmPdv.IbCon.ExecuteDirect(strEdita);
      dmPdv.sTrans.Commit;
      MessageDlg('CTe cancelada com Sucesso.', mtInformation, [mbOK], 0);
      FormatSettings.DecimalSeparator := ',';
      if (dmCte.cdsCTE.Active)then
         dmCte.cdsCTE.Close;
      dmCte.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
      dmCte.cdsCTE.Params[1].AsInteger := StrToInt(edCteCancelar.Text); // corrigido manoel 24/03/2022(edtNumCte.Text);
      dmCte.cdsCTE.Open;
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

procedure TfCTePrincipal.btnCorrigirSerieClick(Sender: TObject);
begin
  vCteStr := 'UPDATE SERIES SET ULTIMO_NUMERO = ';
  vCteStr += edUltimoAtualiza.Text;
  vCteStr += ' WHERE MODELO = ';
  vCteStr += QuotedStr(edModeloAtualiza.Text);
  vCteStr += ' AND SERIE_CTE = ';
  vCteStr += QuotedStr(edSerieAtualiza.Text);

  dmPdv.IbCon.ExecuteDirect(vCteStr);
  dmPdv.sTrans.Commit;
end;

procedure TfCTePrincipal.btnEnviarEmailClick(Sender: TObject);
var
 Para : String;
 CC   : Tstrings;
begin
  if (not dmCte.cdsCte.Active) then
  begin
    ShowMessage('Selecione a CTe a editar.');
    Exit;
  end;
  if (edtSmtpHost.Text <> '') then
  begin
    ACBrCTe1.MAIL.Host := edtSmtpHost.Text;
    ACBrCTe1.MAIL.Port := edtSmtpPort.Text;
    ACBrCTe1.MAIL.Username := edtSmtpUser.Text;
    ACBrCTe1.MAIL.Password := edtSmtpPass.Text;
    ACBrCTe1.MAIL.SetSSL   := cbEmailSSL.Checked;
    ACBrCTe1.MAIL.ReadingConfirmation := False;
  end;
  if not(InputQuery('Enviar Email', 'Email de destino', Para))
    then exit;

    CarregarXML(dmCte.cdsCteCHCTE.AsString);
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
  //end;
end;

procedure TfCTePrincipal.btnEnviarEventoEmailClick(Sender: TObject);
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

procedure TfCTePrincipal.btnExcluirCompClick(Sender: TObject);
var strExclui :string;
begin
  pcompExclui := '';
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( dbGridQC.Columns[1].Field.Value <> '') then
    begin
      strExclui := 'DELETE FROM CTE_COMP';
      strExclui += ' WHERE COD_CTE_COMP = ';
      strExclui += IntToStr(ZsqCOMP.FieldByName('COD_CTE_COMP').AsInteger);
      try
       // dmPdv.Ibcon.ExecuteDirect(strExclui);
       // dmCte.sqComp.Delete;
       pcompExclui:= strExclui ;
       btnInsertComp.Click;
       MessageDlg('Componente Excluido com Sucesso.', mtInformation, [mbOK], 0);
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
end;

procedure TfCTePrincipal.btnConsCadClick(Sender: TObject);
var  UF, Documento : String;
begin
  uf := '';
  documento := '';
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

  ShowMessage(ACBrCTe1.WebServices.ConsultaCadastro.xMotivo);
  ShowMessage(ACBrCTe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xNome);
end;

procedure TfCTePrincipal.btnConsultarChaveClick(Sender: TObject);
var
 vChave : String;
begin
  if not(InputQuery('WebServices Consultar', 'Chave do CT-e:', vChave)) then
    exit;

  ACBrCTe1.WebServices.Consulta.CTeChave := vChave;
  ACBrCTe1.WebServices.Consulta.Executar;

  MemoResp.Lines.Text :=  UTF8Encode(ACBrCTe1.WebServices.Consulta.RetWS);
  memoRespWS.Lines.Text :=  UTF8Encode(ACBrCTe1.WebServices.Consulta.RetornoWS);
end;

procedure TfCTePrincipal.btnConsultarClick(Sender: TObject);
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
  end;
end;

procedure TfCTePrincipal.btnConsultarReciboClick(Sender: TObject);
var
 aux : String;
begin
 if not(InputQuery('Consultar Recibo Lote', 'Número do Recibo', aux))
  then exit;

  ACBrCTe1.WebServices.Recibo.Recibo := aux;
  ACBrCTe1.WebServices.Recibo.Executar;

  MemoResp.Lines.Text   := UTF8Encode(ACBrCTe1.WebServices.Recibo.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Recibo.RetWS);
end;

procedure TfCTePrincipal.btnDuplicarClick(Sender: TObject);
var velha_nCte: Integer;
    nova_nCte: Integer;
    v_duplCte: String;
    dataAtual : TDateTime;
begin
  dataAtual := Now;

  btnGravarCTe.Enabled := False;
  btnCancelarEdicaoCTe.Enabled := False;
  btnPreVisu.Enabled := False;
  btnGerarCte.Enabled := False;
  if (not dmCte.cdsCte.Active) then
  begin
    ShowMessage('Informe uma CTE para Duplicar');
    Exit;
  end;

  if (dmCte.cdsCte.IsEmpty) then
  begin
     ShowMessage('Informe uma CTE para Duplicar');
     Exit;
  end;

  if MessageDlg('Confirma DUPLICAR a CTe número : ' +
     dmCte.cdsCteCTE_NUMERO.AsString +
     ' ?',mtConfirmation, [mbYes,mbNo],0) = mrNo then exit;

  try
    velha_nCte := dmCte.cdsCteCOD_CTE.AsInteger;
    dmPdv.busca_sql('SELECT * FROM cte_duplicar_cte(' +
      IntToStr(velha_nCte) + ')');
    if (not dmPdv.sqBusca.IsEmpty) then
    begin
      nova_nCte := dmPdv.sqBusca.FieldByName('cod_nova_cte').AsInteger;
      edtNumCte.Text := IntToStr(dmPdv.sqBusca.FieldByName('num_nova_cte').AsInteger);
      dmPdv.sTrans.Commit;
      v_duplCte := 'EXECUTE PROCEDURE cte_duplicar(' +
        IntToStr(velha_nCte) + ', ' + IntToStr(nova_nCte) + ')';
      dmPdv.Ibcon.ExecuteDirect(v_duplCte);
    end;
    dmPdv.Ibcon.ExecuteDirect('UPDATE SERIES SET ' +
      ' ULTIMO_NUMERO = ' + edtNumCte.Text +
      ' WHERE MODELO = ' + QuotedStr('CT') +
      '   AND CODSERIE = ' + QuotedStr(edtCodEmitente.Text));
    dmPdv.sTrans.Commit;
    MessageDlg('CTe duplicada com sucesso.', mtInformation, [mbOK], 0);
    btnListarCte.Click;
  except
    on E : Exception do
    begin
      ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
      dmPdv.sTrans.Rollback;
      exit;
    end;
  end;

 {
  btnEditarCte.Click;
  velha_nCte := dmCte.cdsCTECOD_CTE.AsInteger;;
  modoGravacao := 'DUPLICAR';
  FormatSettings.DecimalSeparator := '.';
  val_genCte := dmCte.cdsCTECOD_CTE.AsInteger;
  if (dmCte.cdsCte.Active) then
    dmCte.cdsCte.Edit;

  edtCFOP.Text             := dmCte.cdsCTECTE_CFOP.AsString;
  edtNatOpe.Text           := dmCte.cdsCTECTE_NATOP.AsString;
  edtModelo.Text           := dmCte.cdsCTEMODELO.AsString;
  edtSerieCte.Text         := dmCte.cdsCTECTE_SERIE.AsString;
  edtNumCte.Text           := dmCte.cdsCTECTE_NUMERO.AsString;
  dataGerarCte.date        := dmCte.cdsCTEDHEMI.Value;
  rgModal.ItemIndex        := StrToInt(Trim(dmCte.cdsCTEMODAL.AsString));
  rgTipoServico.ItemIndex  := dmCte.cdsCTETIPOSERVICO.AsInteger;
  rgTiposCte.ItemIndex     := dmCte.cdsCTETIPOCTE.AsInteger;
  rgFormaEmissao.ItemIndex := dmCte.cdsCTETPOEMISSAO.AsInteger;
  rgForPag.ItemIndex       := dmCte.cdsCTEIFORPAG.AsInteger;
  rgTipoDACTe.ItemIndex    := dmCte.cdsCTETPIMP.AsInteger;
  edtEnvCodCidade.Text     := dmCte.cdsCTEENV_CODCIDADE.AsString;
  edtEnvCidade.Text :=    dmCte.cdsCTEENV_CIDADE.AsString;
  edtEnvUF.Text :=        dmCte.cdsCTEENV_ESTADO.AsString;
  edtIniCodCidade.Text := dmCte.cdsCTEINI_CODCIDADE.AsString;
  edtIniCidade.Text :=    dmCte.cdsCTEINI_CIDADE.AsString;
  edtIniUF.Text :=        dmCte.cdsCTEINI_ESTADO.AsString;
  edtFimCodCidade.Text := dmCte.cdsCTEFIM_CODCIDADE.AsString;
  edtFimCidade.Text :=    dmCte.cdsCTEFIM_CIDADE.AsString;
  edtFimUF.Text :=        dmCte.cdsCTEFIM_ESTADO.AsString;
  // emitente
  comboEmpresa.Text       := dmCte.cdsCTEE_RSOCIAL.AsString;
  edtCodEmitente.Text     := dmCte.cdsCTEEMITENTE.AsString;
  edtEmitCNPJ.Text        := dmCte.cdsCTEE_CNPJCPF.AsString;
  edtEmitIE.Text          := dmCte.cdsCTEE_IESTADUAL.AsString;
  edtEmitRazao.Text       := dmCte.cdsCTEE_RSOCIAL.AsString;
  edtEmitFantasia.Text    := dmCte.cdsCTEE_FANTASIA.AsString;
  edtEmitFone.Text        := dmCte.cdsCTEE_TELEFONE.AsString;
  edtEmitLogradouro.Text  := dmCte.cdsCTEE_ENDERECO.AsString;
  edtEmitNumero.Text      := dmCte.cdsCTEE_NUMERO.AsString;
  edtEmitComp.Text        := dmCte.cdsCTEE_COMPLEMENTO.AsString;
  edtEmitBairro.Text      := dmCte.cdsCTEE_BAIRRO.AsString;
  edtEmitCodCidade.Text   := dmCte.cdsCTEE_CODIGOMUNICIPI.AsString;
  edtEmitCidade.Text      := dmCte.cdsCTEE_CIDADE.AsString;
  edtEmitCep.Text         := dmCte.cdsCTEE_CEP.AsString;
  edtEmitUF.Text          := dmCte.cdsCTEE_ESTADO.AsString;
  // tomador
  if(dmCTe.cdsCTET_CNPJCPF.AsString <> '') then
  begin
    rgTomador.ItemIndex      := dmCTe.cdsCTETOMADORSERVICO.AsInteger;
    edtCNPJTomador.Text      := dmCTe.cdsCTET_CNPJCPF.AsString;
    edtIETomador.Text        := dmCTe.cdsCTET_IESTADUAL.AsString;
    edtRazaoTomador.Text     := dmCTe.cdsCTET_RSOCIAL.AsString;
    edtNomeTomador.Text      := dmCTe.cdsCTET_FANTASIA.AsString;
    edtFoneTomador.Text      := dmCTe.cdsCTET_TELEFONE.AsString;
    edtEndTomador.Text       := dmCTe.cdsCTET_ENDERECO.AsString;
    edtNumTomador.Text       := dmCTe.cdsCTET_NUMERO.AsString;
    edtCompTomador.Text      := dmCTe.cdsCTET_COMPLEMENTO.AsString;
    edtBairroTomador.Text    := dmCTe.cdsCTET_BAIRRO.AsString;
    edtTomadorCodCidade.Text := dmCTe.cdsCTET_CODIGOMUNICIPI.AsString;
    edtTomadorCidade.Text    := dmCTe.cdsCTET_CIDADE.AsString;
    edtCepTomador.Text       := dmCTe.cdsCTET_CEP.AsString;
    edtTomadorUF.Text        := dmCTe.cdsCTET_ESTADO.AsString;
  end;
  // rememtente
  edtRemCNPJ.Text          := dmCTe.cdsCTER_CNPJCPF.AsString;
  edtRemIE.Text            := dmCTe.cdsCTER_IESTADUAL.AsString;
  edtRemRazao.Text         := dmCTe.cdsCTER_RSOCIAL.AsString;
  edtRemNome.Text          := dmCTe.cdsCTER_FANTASIA.AsString;
  edtRemFone.Text          := dmCTe.cdsCTER_TELEFONE.AsString;
  edtRemEnd.Text           := dmCTe.cdsCTER_ENDERECO.AsString;
  edtRemNum.Text           := dmCTe.cdsCTER_NUMERO.AsString;
  edtRemComp.Text          := dmCTe.cdsCTER_COMPLEMENTO.AsString;
  edtRemBairro.Text        := dmCTe.cdsCTER_BAIRRO.AsString;
  edtRemCodCidade.Text     := dmCTe.cdsCTER_CODIGOMUNICIPI.AsString;
  edtRemCidade.Text        := dmCTe.cdsCTER_CIDADE.AsString;
  edtRemCep.Text           := dmCTe.cdsCTER_CEP.AsString;
  edtRemUF.Text            := dmCTe.cdsCTER_ESTADO.AsString;
  // destinatario
  edtDestCNPJ.Text         := dmCTe.cdsCTED_CNPJCPF.AsString;
  edtDestIE.Text           := dmCTe.cdsCTED_IESTADUAL.AsString;
  edtDestRazao.Text        := dmCTe.cdsCTED_RSOCIAL.AsString;
  edtDestNome.Text         := dmCTe.cdsCTED_FANTASIA.AsString;
  edtDestFone.Text         := dmCTe.cdsCTED_TELEFONE.AsString;
  edtDestEnd.Text          := dmCTe.cdsCTED_ENDERECO.AsString;
  edtDestNum.Text          := dmCTe.cdsCTED_NUMERO.AsString;
  edtDestComp.Text         := dmCTe.cdsCTED_COMPLEMENTO.AsString;
  edtDestBairro.Text       := dmCTe.cdsCTED_BAIRRO.AsString;
  edtDestCodCidade.Text    := dmCTe.cdsCTED_CODIGOMUNICIPI.AsString;
  edtDestCidade.Text       := dmCTe.cdsCTED_CIDADE.AsString;
  edtDestCep.Text          := dmCTe.cdsCTED_CEP.AsString;
  edtDestUF.Text           := dmCTe.cdsCTED_ESTADO.AsString;
  // recebedor
  if(dmCTe.cdsCTERE_CNPJCPF.AsString <> '') then
  begin
    rgRec.ItemIndex := 0 ;
    edtRecCNPJ.Text      := dmCTe.cdsCTERE_CNPJCPF.AsString;
    edtRecIE.Text        := dmCTe.cdsCTERE_IESTADUAL.AsString;
    edtRecNome.Text      := dmCTe.cdsCTERE_ENDERECO.AsString;
    edtRecRazao.Text     := dmCTe.cdsCTERE_RSOCIAL.AsString;
    edtRecFone.Text      := dmCTe.cdsCTERE_TELEFONE.AsString;
    edtRecEnd.Text       := dmCTe.cdsCTERE_ENDERECO.AsString;
    edtRecNum.Text       := dmCTe.cdsCTERE_NUMERO.AsString;
    edtRecComp.Text      := dmCTe.cdsCTERE_COMPLEMENTO.AsString;
    edtRecBairro.Text    := dmCTe.cdsCTERE_BAIRRO.AsString;
    edtRecCodCidade.Text := dmCTe.cdsCTERE_CODIGOMUNICIPI.AsString;
    edtRecCidade.Text    := dmCTe.cdsCTERE_CIDADE.AsString;
    edtRecCep.TExt       := dmCTe.cdsCTERE_CEP.AsString;
    edtRecUF.Text        := dmCTe.cdsCTERE_ESTADO.AsString;
  end;

  if(dmCte.cdsCTEEX_CNPJCPF.AsString <> '') then
  begin
    rgExp.ItemIndex := 0;
    edtExpCNPJ.Text      := dmCTe.cdsCTEEX_CNPJCPF.AsString;
    edtExpIE.Text        := dmCTe.cdsCTEEX_IESTADUAL.AsString;
    edtExpRazao.Text     := dmCTe.cdsCTEEX_RSOCIAL.AsString;
    edtExpNome.Text      := dmCTe.cdsCTEEX_FANTASIA.AsString;
    edtExpFone.Text      := dmCTe.cdsCTEEX_TELEFONE.AsString;
    edtExpEnd.Text       := dmCTe.cdsCTEEX_ENDERECO.AsString;
    edtExpNum.Text       := dmCTe.cdsCTEEX_COMPLEMENTO.AsString;
    edtExpComp.Text      := dmCTe.cdsCTEEX_COMPLEMENTO.AsString;
    edtExpBairro.Text    := dmCTe.cdsCTEEX_BAIRRO.AsString;
    edtExpCodCidade.Text := dmCTe.cdsCTEEX_CODIGOMUNICIPI.AsString;
    edtExpCidade.Text    := dmCTe.cdsCTEEX_CIDADE.AsString;
    edtExpCep.Text       := dmCTe.cdsCTEEX_CEP.AsString;
    edtExpUF.Text        := dmCTe.cdsCTEEX_ESTADO.AsString;
  end;
  edtCaracAdTrans.Text := dmCTe.cdsCTECARAC_TRANSP.AsString;
  edtCaracAdServ.Text  := dmCTe.cdsCTECARAC_SERV.AsString;
  edtFuncEmi.Text      := dmCTe.cdsCTEFUNC_EMI.AsString;

  rgRetira.ItemIndex   := dmCTe.cdsCTERETIRA.AsInteger;
  memDetRetira.Text    := dmCTe.cdsCTEDET_RETIRA.AsString;

  combCodSitTrib.ItemIndex := dmCTe.cdsCTECOMBCODSITTRIB.Value;

  // TODO trocar o componente abaixo
  //dbValInfCarga.AsFloat := dmCTe.cdsCTEVALINFCARGA.Field.Value;
  edtProPred.Text := dmCTe.cdsCTEPROPRED.AsString;
  edtOutCat.Text := dmCTe.cdsCTEOUTCAT.AsString;

  edtRodRNTRC.Text := dmCTe.cdsCTERNTRC.AsString;
  dataRodPrev.date := dmCTe.cdsCTEDATARODPREV.Value;
  rgRodLotacao.ItemIndex := dmCTe.cdsCTERGRODLOTACAO.Value;
  memxObs.Text := dmCTe.cdsCTEOBS_GERAL.Value;

  // para Clonar  colocar cds da tabela
  if (dmCte.sqComp.Active)then
    dmCte.sqComp.Close;
  dmCte.sqComp.Params[0].AsInteger := val_genCte;
  dmCte.sqComp.Open;
  // para Clonar  colocar cds da tabela
  if (dmCte.sqQC.Active)then
    dmCte.sqQC.Close;
  dmCte.sqQC.Params[0].AsInteger := val_genCte;
  dmCte.sqQC.Open;

  if (dmCte.sqNFe.Active)then
    dmCte.sqNFe.Close;
  dmCte.sqNFe.Params[0].AsInteger := val_genCte;
  dmCte.sqNFe.Open;

  if (dmCte.sqVeic.Active)then
    dmCte.sqVeic.Close;
  dmCte.sqVeic.Params[0].AsInteger := val_genCte;
  dmCte.sqVeic.Open;

  if (dmCte.sqMot.Active)then
    dmCte.sqMot.Close;
  dmCte.sqMot.Params[0].AsInteger := val_genCte;
  dmCte.sqMot.Open;
  // outros
  combOutrosDocs.Text    := dmCte.cdsCTEOUTPDOC.AsString ;
  dataOutrosEmi.DateTime := dmCte.cdsCTEOUDEMI.AsDateTime  ;
  edtOutrosNum.Text      := dmCte.cdsCTEOUNDOC.AsString ;
  edtOutrosDesc.Text     := dmCte.cdsCTEOUDESCOUTRO.AsString ;
  //valOutrosVal.AsFloat   := dmCte.cdsCTEOUVDOCFISC.AsFloat;

  if (dmCte.cdsCTE.Active)then
    dmCte.cdsCTE.Close;
  dmCte.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
  dmCte.cdsCTE.Params[1].AsInteger := StrToInt(edtNumCte.Text);
  dmCte.cdsCTE.Open;

  // comentei aqui, pois não entra
  {
  if (modoGravacao = 'EDITAR') then
  begin
    // vai pra primeira ABA
    pcPrincipal.ActivePage:=TabDados;
    btnGerar.Enabled := True;
    modoGravacao := 'EDITAR';
    FormatSettings.DecimalSeparator := ',';
    if (dmCte.cdsCTENPROT.AsString = '') then
    begin
      btnGravarCTe.Caption := 'Gravar CTE *';
      btnGravarCte.Font.Style := [fsBold];
      dmCte.cdsCTE.Edit;
    end;
    edtCFOP.ReadOnly := False;
    edtNatOpe.ReadOnly := False;
    btnPreVisu.Enabled := True;
  end;
  }
  btnIncCte.Click;
  btnGravarCTe.Click;
  duplicar(IntToStr(velha_nCte));
  }
end;

procedure TfCTePrincipal.btnEditarCompClick(Sender: TObject);
begin
  if (dmCte.sqComp.IsEmpty) then
  begin
    ShowMessage('Não existe item pra ser editado.');
    Exit;
  end;
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  ZsqCOMP.Edit;
  fCompValor.ShowModal;
  {
    if (dmCte.sqComp.IsEmpty) then
  begin
    ShowMessage('Não existe item pra ser editado.');
    Exit;
  end;
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  dmCte.sqCOMP.Edit;
  fCompValor.ShowModal;
  }
end;

procedure TfCTePrincipal.btnEditarCteClick(Sender: TObject);
begin
  if (not dmCte.cdsCte.Active) then
  begin
    ShowMessage('Selecione a CTe a editar.');
    Exit;
  end;
  modoInicio := 'ALTERAR';
  if (not dmCte.cdsCte.IsEmpty) then
  begin
    lblCteAtual.Caption := IntToStr(dmCte.cdsCteCTE_NUMERO.AsInteger) +
      '-' + Copy(dmCte.cdsCteD_FANTASIA.AsString,0,30) + '...';
  end;
  lblCteAtual1.Font.Color:=clBlack;
  if (rgTipoAmb.ItemIndex = 1) then
    lblCteAtual1.Font.Color:=clRed;
  lblCteAtual1.Caption := lblCteAtual.Caption;
  StatusBar1.SimpleText := 'Editando CTe : ' +
    IntToStr(dmCte.cdsCTECOD_CTE.AsInteger);
  modoGravacao := 'EDITAR';
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe já enviada. Não é possível GRAVAR alterações.', mtInformation, [mbOK], 0);
    StatusBar1.SimpleText := 'Consultando CTe : ' +
      IntToStr(dmCte.cdsCTECOD_CTE.AsInteger) + ' já enviada.';
    btnGravarCTe.Caption := 'Não Grava';
  end;
  CarregarCte(IntToStr(dmCte.cdsCTECOD_CTE.AsInteger));
  // vai pra primeira ABA
  //pcPrincipal.ActivePage:=TabDados;
  btnGerar.Enabled := True;
  btnCC.Enabled := True;
  if (dmCte.cdsCTENPROT.AsString = '') then
  begin
    btnGravarCTe.Caption := 'Gravar CTE *';
    dmCte.cdsCTE.Edit;
    btnGravarCTe.Enabled := True;
  end
  else begin
    btnGravarCTe.Enabled := False;
  end;
  edtCFOP.ReadOnly      := False;
  edtNatOpe.ReadOnly    := False;
  btnPreVisu.Enabled    := True;
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 0;
  btnGravarCTe.Enabled := True;
  btnCancelarEdicaoCTe.Enabled := True;
  btnPreVisu.Enabled := True;
  btnGerarCte.Enabled := True;
  sbtnLerXmlCte.Enabled := True;
  sbtnLerXmlCte1.Enabled := True;
  edtCfop.SetFocus;

  ZConn.Connected := False;
  ZConn.Connected := True;

  if(ZsqQC.Active)then
    ZsqQC.Close;
  ZsqQC.Params[0].AsInteger := val_genCte;
  ZsqQC.Open;

  if(ZsqComp.Active)then
    ZsqComp.Close;
  ZsqComp.Params[0].AsInteger := val_genCte;
  ZsqComp.Open;

  if(ZsqNFe.Active)then
    ZsqNFe.Close;
  ZsqNFe.Params[0].AsInteger := val_genCte;
  ZsqNFe.Open;


end;

procedure TfCTePrincipal.btnGerarClick(Sender: TObject);
var   vAux : String;
 strEdita :string;
begin
  btnGerarCte.Click;
  {
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    ShowMessage('Arquivo ja Gerado e Enviado' );
    exit;
  end;
  vAux := edtNumCte.Text;
  ACBrCTe1.Conhecimentos.Clear;
  GerarCTe(vAux);
  ACBrCTe1.Conhecimentos.Items[0].GravarXML('','');

  ShowMessage('Arquivo gerado em: '+ACBrCTe1.Conhecimentos.Items[0].NomeArq);
  MemoDados.Lines.Add('Arquivo gerado em: '+ACBrCTe1.Conhecimentos.Items[0].NomeArq);
  MemoResp.Lines.LoadFromFile(ACBrCTe1.Conhecimentos.Items[0].NomeArq);

  ACBrCTe1.Conhecimentos.Assinar;
  ACBrCTe1.Conhecimentos.Validar;
  showmessage('Conhecimento de Transporte Eletrônico Valido');

  ACBrCTe1.Enviar(1); //(StrToInt(vNumLote));

  MemoResp.Lines.Text   := UTF8Encode(ACBrCTe1.WebServices.Retorno.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Retorno.RetWS);
  //LoadXML(MemoResp, WBResposta);

  pcCte.ActivePageIndex := 5;
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
    strEdita := 'UPDATE CTE SET NPROT = ';
    strEdita := strEdita + QuotedStr(ACBrCTe1.WebServices.Retorno.Protocolo);
    strEdita := strEdita + ', CHCTE = ';
    strEdita := strEdita + QuotedStr(ACBrCTe1.WebServices.Retorno.Recibo);

    strEdita := strEdita + ', STATUS_CTE = ';
    strEdita := strEdita + QuotedStr('Autorizada');

    strEdita := strEdita + ' WHERE COD_CTE = ';
    strEdita := strEdita + IntToStr(val_genCte);
    try
      dmPdv.IbCon.ExecuteDirect(strEdita);
      dmPdv.sTrans.Commit;

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
  }
end;

procedure TfCTePrincipal.btnGerarCteClick(Sender: TObject);
var
  vAux : String;
  strEdita :string;
  vChave_cte: String;
begin
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    ShowMessage('Arquivo ja Gerado e Enviado' );
    exit;
  end;
  // if not(InputQuery('WebServices Enviar', 'Numero do Conhecimento', vAux))
  // then exit;
  vAux := edtNumCte.Text;
  ACBrCTe1.Conhecimentos.Clear;
  //ShowMessage('Vai carregar acbr');
  ACBrCTe1.Configuracoes.Geral.VersaoDF := ve400;
  CarregarAcbr;
  //ShowMessage('Vai Gerar o xml');
  try
    GerarCTe(vAux);
    //ShowMessage('Gravando');
    ACBrCTe1.Conhecimentos.Items[0].GravarXML('','');
    vChave_cte := ACBrCTe1.Conhecimentos.Items[0].NomeArq;
    StatusBar1.SimpleText := 'Gerando CTe, Arquivo gerado em: ' + vChave_cte;
    MemoDados.Lines.Add('Arquivo gerado em: '+ vChave_cte);
    MemoResp.Lines.LoadFromFile(vChave_cte);
    //pcCte.ActivePageIndex := 1;
    //ShowMessage('Assinando');
    ACBrCTe1.Conhecimentos.Assinar;
    //ShowMessage('Validadndo');
    ACBrCTe1.Conhecimentos.Validar;
    StatusBar1.SimpleText := StatusBar1.SimpleText + ' - Situação : Valido';
    if (dmPdv.modoDesenvolvedor = 'N') then
    begin
      //ShowMessage('Enviando');
      ACBrCTe1.Enviar(1); //(StrToInt(vNumLote));

      MemoResp.Lines.Text   := ACBrCTe1.WebServices.Enviar.RetWS;
      memoRespWS.Lines.Text := ACBrCTe1.WebServices.Enviar.RetornoWS;


      with MemoDados do
      begin
        Lines.Add('');
        Lines.Add('Envio CTe');
        Lines.Add('tpAmb: '     + TpAmbToStr(ACBrCTe1.WebServices.Enviar.tpAmb));
        Lines.Add('verAplic: '  + ACBrCTe1.WebServices.Enviar.verAplic);
        Lines.Add('cStat: '     + IntToStr(ACBrCTe1.WebServices.Enviar.cStat));
        Lines.Add('xMotivo: '   + ACBrCTe1.WebServices.Enviar.xMotivo);
        Lines.Add('cUF: '       + IntToStr(ACBrCTe1.WebServices.Enviar.cUF));
        Lines.Add('xMsg: '      + ACBrCTe1.WebServices.Enviar.Msg);
        Lines.Add('Recibo: '    + ACBrCTe1.WebServices.Enviar.Recibo);
        Lines.Add('Protocolo: ' + ACBrCTe1.WebServices.Enviar.Protocolo);
      end;


     if (edtNumCte.Text <> '') then
     begin
      strEdita := 'UPDATE CTE SET NPROT = ';
      strEdita := strEdita + QuotedStr(ACBrCTe1.WebServices.Enviar.Protocolo);
      //strEdita := strEdita + ', CHCTE = ';
      //strEdita := strEdita + QuotedStr(ACBrCTe1.WebServices.Retorno.ChaveCTe);
      strEdita := strEdita + ', STATUS_CTE = ';
      strEdita := strEdita + QuotedStr('AUTORIZADA');
      strEdita := strEdita + ' WHERE COD_CTE = ';
      strEdita := strEdita + IntToStr(val_genCte);
      try
      dmPdv.IbCon.ExecuteDirect(strEdita);
      dmPdv.sTrans.Commit;
      MessageDlg('CTe enviada com Sucesso.', mtInformation, [mbOK], 0);
      FormatSettings.DecimalSeparator := ',';
      ACBrCTe1.Conhecimentos.ImprimirPDF;
      except
        on E : Exception do
        begin
          ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
          dmPdv.sTrans.Rollback;
          exit;
        end;
      end;
    end;
  end
  else begin
    ShowMessage('XML gerado, mas sistema no modoDesenvolvedor (Outros)');
  end;
  except
    on E:Exception do
      ShowMessage('Erro para gerar CTe : ' + E.Message);
  end;
end;

procedure TfCTePrincipal.btnGerarPDFClick(Sender: TObject);
begin
  CarregarXML(dmCte.cdsCteCHCTE.AsString);
  ACBrCTe1.Conhecimentos.ImprimirPDF;
end;

procedure TfCTePrincipal.btnGerarPDFEventoClick(Sender: TObject);
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

function TfCTePrincipal.busca_generator(generator: String): integer;
begin
  if (ZsqGenerator.Active) then
    ZsqGenerator.Close;
  ZsqGenerator.SQL.Clear;
  ZsqGenerator.SQL.Text := 'SELECT CAST(GEN_ID(' + generator +
     ', 1) AS INTEGER) AS CODIGO FROM RDB$DATABASE';
  ZsqGenerator.Open;
  Result := ZsqGenerator.Fields[0].AsInteger;
  ZsqGenerator.Close


end;



procedure TfCTePrincipal.ACBrCTe1StatusChange(Sender: TObject);
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

procedure TfCTePrincipal.BitBtn10Click(Sender: TObject);
begin
  // busca emitente
  if (edtExpBusca.Text <> '') then
  begin
    fClienteBusca.cCodCliente := StrToInt(edtExpBusca.Text);
    fClienteBusca.BuscaCliente;
    if fClienteBusca.cNomeCliente = '' then
    begin
      ShowMessage('Cliente não Encontrado');
      Exit;
    end;
    edtExpNome.Text := fClienteBusca.cNomeCliente;
    edtExpBusca.Text := IntToStr(fClienteBusca.cCodCliente);
  end
  else begin
    fClienteBusca.ShowModal;
    edtExpBusca.Text := IntToStr(fClienteBusca.cCodCliente);
    edtExpNome.Text := fClienteBusca.cNomeCliente;
  end;
  buscaExpedidor;
end;

procedure TfCTePrincipal.BitBtn11Click(Sender: TObject);
begin
  // busca emitente
  if (edtRecBusca.Text <> '') then
  begin
    fClienteBusca.cCodCliente := StrToInt(edtRecBusca.Text);
    fClienteBusca.BuscaCliente;
    if fClienteBusca.cNomeCliente = '' then
    begin
      ShowMessage('Cliente não Encontrado');
      Exit;
    end;
    edtRecNome.Text := fClienteBusca.cNomeCliente;
    edtRecBusca.Text := IntToStr(fClienteBusca.cCodCliente);
  end
  else begin
    fClienteBusca.ShowModal;
    edtRecBusca.Text := IntToStr(fClienteBusca.cCodCliente);
    edtRecNome.Text := fClienteBusca.cNomeCliente;
  end;
  buscaRecebedor;
end;

procedure TfCTePrincipal.BitBtn12Click(Sender: TObject);
begin
  // busca emitente
  if (edtDestBusca.Text <> '') then
  begin
    fClienteBusca.cCodCliente := StrToInt(edtDestBusca.Text);
    fClienteBusca.BuscaCliente;
    if fClienteBusca.cNomeCliente = '' then
    begin
      ShowMessage('Cliente não Encontrado');
      Exit;
    end;
    edtDestNome.Text := fClienteBusca.cNomeCliente;
    edtDestBusca.Text := IntToStr(fClienteBusca.cCodCliente);
  end
  else begin
    fClienteBusca.ShowModal;
    edtDestBusca.Text := IntToStr(fClienteBusca.cCodCliente);
    edtDestNome.Text := fClienteBusca.cNomeCliente;
  end;
  lblCteAtual.Caption := IntToStr(dmCte.cdsCteCTE_NUMERO.AsInteger) +
    '-' + dmCte.cdsCteD_FANTASIA.AsString;
  lblCteAtual1.Font.Color:=clBlack;
  if (rgTipoAmb.ItemIndex = 1) then
    lblCteAtual1.Font.Color:=clRed;
  lblCteAtual1.Caption := lblCteAtual.Caption;
  //edtDestBuscaExit(Nil);
  buscaDestinatario;
end;

procedure TfCTePrincipal.BitBtn13Click(Sender: TObject);
begin
  // busca Destinatario
  fClienteBusca.ShowModal;
  edtDestNome1.Text := fClienteBusca.cNomeCliente;
  btnListarCte.Click;
end;


procedure TfCTePrincipal.btnCCClick(Sender: TObject);
var
  vGrupo, vCampo, vConteudo, vIndice: String;
  iLote: Integer;
begin
  CarregarAcbr;
  OpenDialog1.Title := 'Selecione o CTe a ser Corrigido por CC-e';
  OpenDialog1.DefaultExt := '*-cte.xml';
  OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrCTe1.Conhecimentos.Clear;
    ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);

    vGrupo := edtCceGrupo.Text;
    if (edtCceGrupo.Text = '') then
    begin
      ShowMessage('Informe o grupo para ser corrigido');
      exit;
    end;

    vCampo := edtCceTextoVelho.Text;
    if (edtCceTextoVelho.Text = '') then
    begin
      ShowMessage('Informe o Campo para ser corrigido');
      exit;
    end;

    vConteudo := edtCceTextoNovo.Text;
    if (edtCceTextoNovo.Text = '') then
    begin
      ShowMessage('Informe o Conteúdo novo');
      exit;
    end;

    vIndice := edtCceNumItem.Text;
    if (edtCceNumItem.Text = '') then
    begin
      ShowMessage('Informe o Indice');
      exit;
    end;

    ACBrCTe1.EventoCTe.Evento.Clear;

    with ACBrCTe1.EventoCTe.Evento.New do
    begin
      // Para o Evento de CCe: nSeqEvento varia de 1 até 20 por CT-e
      infEvento.nSeqEvento      := StrToInt(edtCceSequencia.Text);
      infEvento.chCTe           := Copy(edtCceChave.Text, 4, 44);
      infEvento.CNPJ            := edtEmitCNPJ.Text;
      infEvento.dhEvento        := now;
      infEvento.tpEvento        := teCCe;

      infEvento.detEvento.xCondUso := '';

      ACBrCTe1.EventoCTe.Evento.Items[0].InfEvento.detEvento.infCorrecao.Clear;

      with ACBrCTe1.EventoCTe.Evento.Items[0].InfEvento.detEvento.infCorrecao.New do
      begin
        grupoAlterado   := vGrupo;
        campoAlterado   := vCampo;
        valorAlterado   := vConteudo;
        nroItemAlterado := StrToIntDef(vIndice, 1);
      end;
    end;

    iLote := 1; // Numero do Lote do Evento
    ACBrCTe1.EnviarEvento(iLote);
    ACBrCTe1.Conhecimentos.ImprimirPDF;

    MemoResp.Lines.Text   := ACBrCTe1.WebServices.EnvEvento.RetWS;
    memoRespWS.Lines.Text := ACBrCTe1.WebServices.EnvEvento.RetornoWS;

    //LoadXML(MemoResp, WBResposta);

    ShowMessage(IntToStr(ACBrCTe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat));
    ShowMessage(ACBrCTe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);
  end;
end;

procedure TfCTePrincipal.btnEditarNFe1Click(Sender: TObject);
begin
  if (not dmCte.sqSeg.Active) then
    dmCte.sqSeg.Open;
  dmCte.sqSeg.Edit;
  dbSeguroNome.SetFocus;
end;

procedure TfCTePrincipal.btnExcluirNFe1Click(Sender: TObject);
begin
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( DBGridNFe.Columns[1].Field.Value <> '') then
    begin
      vCteStr := 'DELETE FROM CTE_SEGURO';
      vCteStr := vCteStr + ' WHERE COD_CTE_SEGURO = ';
      vCteStr := vCteStr +  IntToStr(dmCte.sqSegCOD_CTE_SEGURO.AsInteger);
      try
        dmPdv.IbCon.ExecuteDirect(vCteStr);
        dmCte.sqSeg.Close;
        dmCte.sqSeg.Open;
        //dmPdv.sTrans.Commit;
        MessageDlg('Seguro excluida com sucesso.', mtInformation, [mbOK], 0);
        dmCte.sqNFe.Refresh;
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
end;

procedure TfCTePrincipal.btnGerarCte1Click(Sender: TObject);
begin

  Close;
end;

procedure TfCTePrincipal.btnGravarCTe1Click(Sender: TObject);
begin
  GravarConfiguracao;
end;

procedure TfCTePrincipal.btnImportarXML1Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.btnIncluirNFe1Click(Sender: TObject);
var vNum_seg: Integer;
begin
  if (not dmCte.sqSeg.Active) then
    dmCte.sqSeg.Open;
  dmCte.sqSeg.Append;
  dmCte.sqSegCOD_CTE.AsInteger := val_genCte;
  vNum_seg := dmPdv.busca_generator('GEN_CTE_SEGURO_ID');
  dmCte.sqSegCOD_CTE_SEGURO.AsInteger := vNum_seg;
  dbSeguroNome.SetFocus;
end;

procedure TfCTePrincipal.btnInserirQCClick(Sender: TObject);
begin

  if(pQCExclui <> '')then
  begin
    ZConn.StartTransaction;
    try
      ZConn.ExecuteDirect(pQCExclui);
      ZConn.Commit;
    except
      ZConn.Rollback;
      raise;
    end;
    pQCExclui := '' ;
  end;

  if(fQuantCarga.pQCInseri  <> '')then
  begin
    edtQC.Text:= fQuantCarga.pQCInseri ;
    ZConn.StartTransaction;
    try
      ZConn.ExecuteDirect(fQuantCarga.pQCInseri);
      ZConn.Commit;
    except
      ZConn.Rollback;
      raise;
    end;
    fQuantCarga.pQCInseri := '';
  end;


  if(fQuantCarga.pQCEdit <> '')then
  begin
    edtQC.Text:= fQuantCarga.pQCEdit ;
    ZConn.StartTransaction;
    try
      ZConn.ExecuteDirect(fQuantCarga.pQCEdit);
      ZConn.Commit;
    except
      ZConn.Rollback;
      raise;
    end;
    fQuantCarga.pQCEdit := '';
  end;

  dmCte.sqQC.Refresh;

  if (ZsqQC.Active)then
    ZsqQC.Close;
  ZsqQC.Params[0].AsInteger := val_genCte;
  ZsqQC.Open;


end;

procedure TfCTePrincipal.btnInserirvNfeClick(Sender: TObject);
begin

  if(pvNfeExclui <> '')then
  begin
    try
      ZQuery1.Close;
      ZQuery1.SQL.Text:= pvNfeExclui;
      ZQuery1.ExecSQL;
    except
      on E:Exception do
      begin
        ShowMessage('An error occurs: '+E.Message);
      end;
    end;
    pvNfeExclui := '';
  end;


  if(fNFe.pvNfeInseri <> '')then
  begin
    try
      ZQuery1.Close;
      ZQuery1.SQL.Text:= fNFe.pvNfeInseri;
      ZQuery1.ExecSQL;
    except
      on E:Exception do
      begin
        ShowMessage('An error occurs: '+E.Message);
      end;
    end;
    fNFe.pvNfeInseri := '' ;
  end;


  if(fNFe.pvNfeEdit <> '')then
  begin
    try
      ZQuery1.SQL.Text:= fNFe.pvNfeEdit;
      ZQuery1.ExecSQL;
    except
      on E:Exception do
      begin
        ShowMessage('An error occurs: '+E.Message);
      end;
    end;
    fNFe.pvNfeEdit := '';
  end;


  dmCte.sqNFe.Refresh;

  if (ZsqNFe.Active)then
    ZsqNFe.Close;
  ZsqNFe.Params[0].AsInteger := val_genCte;
  ZsqNFe.Open;

end;

procedure TfCTePrincipal.btnLimpaBuscaClick(Sender: TObject);
begin
  edtDestNome1.Text := '';
  edtDestNome1.SetFocus;
end;

procedure TfCTePrincipal.btnProximo10Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 9;
end;

procedure TfCTePrincipal.btnProximo1Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 2;
end;

procedure TfCTePrincipal.btnProximo2Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 3;
end;

procedure TfCTePrincipal.btnProximo3Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 4;
end;

procedure TfCTePrincipal.btnProximo4Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 5;
end;

procedure TfCTePrincipal.btnProximo5Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 6;
end;

procedure TfCTePrincipal.btnProximo6Click(Sender: TObject);
begin
 pcPrincipal.ActivePageIndex := 1;
 pcCte.ActivePageIndex := 7;
 PageControl4.ActivePageIndex := 1;
end;

procedure TfCTePrincipal.btnProximo7Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 8;
  PageControl4.ActivePageIndex := 0;
end;

procedure TfCTePrincipal.btnProximo8Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 8;
  PageControl4.ActivePageIndex := 1;
end;

procedure TfCTePrincipal.btnProximo9Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 8;
  PageControl4.ActivePageIndex := 2;
end;

procedure TfCTePrincipal.btnProximoClick(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 1;
end;

procedure TfCTePrincipal.BitBtn15Click(Sender: TObject);
begin
   if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  if (modoGravacao = 'INCLUIR') then
    btnGravarCTe.Click;

  ZsqComp.Append;
  ZsqCompCOD_CTE.AsInteger := val_genCte;
  if (componente_nome <> '') then
    ZsqCompCOMP_NOME.AsString := componente_nome;
  fCompValor.ShowModal;
  ZsqComp.Close;
  ZsqComp.Params[0].AsInteger := val_genCte;
  ZsqComp.Open;
  componente_nome := ZsqCompCOMP_NOME.AsString;
 {
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  if (modoGravacao = 'INCLUIR') then
    btnGravarCTe.Click;

  dmCte.sqComp.Append;
  dmCte.sqCompCOD_CTE.AsInteger := val_genCte;
  if (componente_nome <> '') then
    dmCte.sqCompCOMP_NOME.AsString := componente_nome;
  fCompValor.ShowModal;
  dmCte.sqComp.Close;
  dmCte.sqComp.Params[0].AsInteger := val_genCte;
  dmCte.sqComp.Open;
  componente_nome := dmCte.sqCompCOMP_NOME.AsString;
  }
end;

procedure TfCTePrincipal.BitBtn19Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.BitBtn1Click(Sender: TObject);
begin
  if (edtEnvCidade.Text <> '') then
  begin
    fMunicipioBusca.cCodMun := edtEnvCidade.Text;
    fMunicipioBusca.BuscaMunicipio;
    if fMunicipioBusca.cNomeMun = '' then
    begin
      ShowMessage('Municipio não encontrado');
      Exit;
    end;
  end
  else begin
    fMunicipioBusca.ShowModal;
  end;
  edtEnvCidade.Text := fMunicipioBusca.cNomeMun;
  edtEnvCodCidade.Text := fMunicipioBusca.cCodMun;
  edtEnvUF.Text := fMunicipioBusca.cUfMun;
end;

procedure TfCTePrincipal.BitBtn2Click(Sender: TObject);
begin
  pcPrincipal.PageIndex:=0;
  btnListarCte.Click;
end;

procedure TfCTePrincipal.BitBtn3Click(Sender: TObject);
begin
  if (edtIniCidade.Text <> '') then
  begin
    fMunicipioBusca.cCodMun := edtIniCidade.Text;
    fMunicipioBusca.BuscaMunicipio;
    if fMunicipioBusca.cNomeMun = '' then
    begin
      ShowMessage('Municipio não encontrado');
      Exit;
    end;
  end
  else begin
    fMunicipioBusca.ShowModal;
  end;
  edtIniCidade.Text := fMunicipioBusca.cNomeMun;
  edtIniCodCidade.Text := fMunicipioBusca.cCodMun;
  edtIniUF.Text := fMunicipioBusca.cUfMun;
end;

procedure TfCTePrincipal.BitBtn4Click(Sender: TObject);
begin
  if (edtFimCidade.Text <> '') then
  begin
    fMunicipioBusca.cCodMun := edtFimCidade.Text;
    fMunicipioBusca.BuscaMunicipio;
    if fMunicipioBusca.cNomeMun = '' then
    begin
      ShowMessage('Municipio não encontrado');
      Exit;
    end;
  end
  else begin
    fMunicipioBusca.ShowModal;
  end;
  edtFimCidade.Text := fMunicipioBusca.cNomeMun;
  edtFimCodCidade.Text := fMunicipioBusca.cCodMun;
  edtFimUF.Text := fMunicipioBusca.cUfMun;
end;

procedure TfCTePrincipal.BitBtn5Click(Sender: TObject);
begin
  btnGravarCTe.Enabled := False;
  btnCancelarEdicaoCTe.Enabled := False;
  btnPreVisu.Enabled := False;
  btnGerarCte.Enabled := False;
  btnCC.Enabled := False;
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  if MessageDlg('Confirma EXCLUIR a CTe número : ' +
     dmCte.cdsCteCTE_NUMERO.AsString +
     ' ?',mtConfirmation, [mbYes,mbNo],1) = mrNo then exit;

  dmPdv.IbCon.ExecuteDirect('DELETE FROM CTE_COMP WHERE COD_CTE = ' +
    IntToStr(dmCte.cdsCTECOD_CTE.AsInteger));
  dmPdv.IbCon.ExecuteDirect('DELETE FROM CTE_MOTORISTA WHERE COD_CTE = ' +
    IntToStr(dmCte.cdsCTECOD_CTE.AsInteger));
  dmPdv.IbCon.ExecuteDirect('DELETE FROM CTE_NFE WHERE CTE_NFE = ' +
    IntToStr(dmCte.cdsCTECOD_CTE.AsInteger));
  dmPdv.IbCon.ExecuteDirect('DELETE FROM CTE_QC WHERE COD_CTE = ' +
    IntToStr(dmCte.cdsCTECOD_CTE.AsInteger));
  dmPdv.IbCon.ExecuteDirect('DELETE FROM CTE_SEGURO WHERE COD_CTE = ' +
    IntToStr(dmCte.cdsCTECOD_CTE.AsInteger));
  dmPdv.IbCon.ExecuteDirect('DELETE FROM CTE_VEICULOS WHERE COD_CTE = ' +
    IntToStr(dmCte.cdsCTECOD_CTE.AsInteger));
  dmPdv.IbCon.ExecuteDirect('DELETE FROM CTE WHERE COD_CTE = ' +
    IntToStr(dmCte.cdsCTECOD_CTE.AsInteger));
  dmPdv.sTrans.Commit;
  btnListarCte.Click;
end;

procedure TfCTePrincipal.BitBtn6Click(Sender: TObject);
begin
  // busca emitente
  if (edtCodEmitente.Text <> '') then
  begin
    fClienteBusca.cCodCliente := StrToInt(edtCodEmitente.Text);
    fClienteBusca.BuscaCliente;
    if fClienteBusca.cNomeCliente = '' then
    begin
      ShowMessage('Cliente não Encontrado');
      Exit;
    end;
    edtEmitFantasia.Text := fClienteBusca.cNomeCliente;
    edtCodEmitente.Text := IntToStr(fClienteBusca.cCodCliente);
  end
  else begin
    fClienteBusca.ShowModal;
    edtCodEmitente.Text := IntToStr(fClienteBusca.cCodCliente);
    edtEmitFantasia.Text := fClienteBusca.cNomeCliente;
  end;
  edtCodEmitente.SetFocus;
end;

procedure TfCTePrincipal.BitBtn7Click(Sender: TObject);
begin
  // busca emitente
  if (edtBuscaTomador.Text <> '') then
  begin
    fClienteBusca.cCodCliente := StrToInt(edtBuscaTomador.Text);
    fClienteBusca.BuscaCliente;
    if fClienteBusca.cNomeCliente = '' then
    begin
      ShowMessage('Cliente não Encontrado');
      Exit;
    end;
    edtNomeTomador.Text := fClienteBusca.cNomeCliente;
    edtBuscaTomador.Text := IntToStr(fClienteBusca.cCodCliente);
  end
  else begin
    fClienteBusca.ShowModal;
    edtBuscaTomador.Text := IntToStr(fClienteBusca.cCodCliente);
    edtNomeTomador.Text := fClienteBusca.cNomeCliente;
  end;
  buscaTomador;
end;

procedure TfCTePrincipal.BitBtn9Click(Sender: TObject);
begin
 // busca emitente
 if (edtRemBusca.Text <> '') then
 begin
   fClienteBusca.cCodCliente := StrToInt(edtRemBusca.Text);
   fClienteBusca.BuscaCliente;
   if fClienteBusca.cNomeCliente = '' then
   begin
     ShowMessage('Cliente não Encontrado');
     Exit;
   end;
   edtRemNome.Text := fClienteBusca.cNomeCliente;
   edtRemBusca.Text := IntToStr(fClienteBusca.cCodCliente);
 end
 else begin
   fClienteBusca.ShowModal;
   edtRemBusca.Text := IntToStr(fClienteBusca.cCodCliente);
   edtRemNome.Text := fClienteBusca.cNomeCliente;
 end;
 buscaRemetente;
end;

procedure TfCTePrincipal.btnEditarNFeClick(Sender: TObject);
begin
    if (fCTePrincipal.ZsqNFe.IsEmpty) then
 begin
   ShowMessage('Não existe item pra ser editado.');
   Exit;
 end;
   {
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  }
  fCTePrincipal.ZsqNFe.Edit;
  //fNFe.path_xml := edtCteImportar.Text;
  fNFe.ShowModal;
  {
 if (dmCte.sqNFe.IsEmpty) then
 begin
   ShowMessage('Não existe item pra ser editado.');
   Exit;
 end;
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  dmCte.sqNFe.Edit;
  fNFe.path_xml := edtCteImportar.Text;
  fNFe.ShowModal;
  }
end;

procedure TfCTePrincipal.btnExcluirNFeClick(Sender: TObject);
begin
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( DBGridNFe.Columns[1].Field.Value <> '') then
    begin
      vCteStr := 'DELETE FROM CTE_NFE';
      vCteStr := vCteStr + ' WHERE COD_CTE_NFE = ';
      vCteStr := vCteStr +  IntToStr(ZsqNFeCOD_CTE_NFE.AsInteger);
      try
       // dmPdv.IbCon.ExecuteDirect(vCteStr);
       // dmCte.sqNFe.Delete;
        //dmPdv.sTrans.Commit;
        pvNfeExclui := vCteStr ;
        btnInserirvNfe.Click;
        MessageDlg('NFe excluida com sucesso.', mtInformation, [mbOK], 0);
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
end;

procedure TfCTePrincipal.btnSairClick(Sender: TObject);
begin
  if (dmCte.cdsCTENPROT.AsString  = '') then
  begin
    if (modoGravacao = 'EDITAR') then
    begin
      ShowMessage('Grave ou Cancele a edição da Cte');
      Exit;
    end;
    if (modoGravacao = 'INCLUIR') then
    begin
      ShowMessage('Grave ou Cancele a Cte iniciada.');
      Exit;
    end;
  end;
  Close;
end;

procedure TfCTePrincipal.btnGerarPDFInutClick(Sender: TObject);
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

procedure TfCTePrincipal.btnCancelarEdicaoCTeClick(Sender: TObject);
begin
  if MessageDlg('Confirma CANCELAR ? Todas as alterações serão perdidas'
     ,mtConfirmation, [mbYes,mbNo],1) = mrNo then exit;
  dmCte.cdsCte.Cancel;
  modoGravacao:='CONSULTAR';
  btnGravarCTe.Caption := 'Gravar';
end;

procedure TfCTePrincipal.btnImprimirInutClick(Sender: TObject);
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

procedure TfCTePrincipal.btnInfCargaEditaClick(Sender: TObject);
begin
  if (dmCte.sqQC.IsEmpty) then
  begin
    ShowMessage('Não existe item pra ser editado.');
    Exit;
  end;

  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  ZsqQC.Edit;
  fQuantCarga.ShowModal;
  carga_un := dmCte.sqQCUNID.AsString;
  carga_desc := dmCte.sqQCMEDIDA.AsString;
end;

procedure TfCTePrincipal.btnInfCargaExcluiClick(Sender: TObject);
begin
  pQCExclui := '';
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( dbGridQC.Columns[1].Field.Value <> '') then
    begin
      vCteStr := 'DELETE FROM CTE_QC';
      vCteStr += ' WHERE COD_CTE_QC = ';
      vCteStr += IntToStr(ZsqQC.FieldByName('COD_CTE_QC').AsInteger);

      try
        //dmPdv.IbCon.ExecuteDirect(vCteStr);
        //dmPdv.sTrans.Commit;
       //  dmCte.sqQC.Delete;
        pQCExclui:= vCteStr ;
        btnInserirQC.Click;
        MessageDlg('Quantidade de Carga Excluida com Sucesso.', mtInformation, [mbOK], 0);
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
end;

procedure TfCTePrincipal.btnInfCargaGravaClick(Sender: TObject);
begin

end;

procedure TfCTePrincipal.btnInfCargaIncluiClick(Sender: TObject);
begin
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  if (modoGravacao = 'INCLUIR') then
    btnGravarCTe.Click;

  ZsqQC.Append;
  if (carga_desc <> '') then
    ZsqQCMEDIDA.AsString := carga_desc;
  if (carga_un <> '') then
    ZsqQCUNID.AsString := carga_un;
  ZsqQCCOD_CTE.AsInteger := val_genCte;
  fQuantCarga.ShowModal;
  dmCte.sqQC.Close;
  dmCte.sqQC.Params[0].AsInteger := val_genCte;
  dmCte.sqQC.Open;

  ZsqQC.Close;
  ZsqQC.Params[0].AsInteger := val_genCte;
  ZsqQC.Open;


  //carga_un := dmCte.sqQCUNID.AsString;
  //carga_desc := dmCte.sqQCMEDIDA.AsString;

  carga_un := ZsqQCUNID.AsString;
  carga_desc := ZsqQCMEDIDA.AsString;
end;

procedure TfCTePrincipal.btnGravarCTeClick(Sender: TObject);
var sql_retorno, strEdita: String;
begin
  if (edtNumCte.Text = '') then
  begin
    Exit;
  end;
  if(edtCFOP.Text = '') then
  begin
    MessageDlg('Preecha o CFOP.', mtInformation, [mbOK], 0);
    edtCFOP.SetFocus;
    exit;
  end;
  strEdita := FloatToStr(dmCte.cdsCteVPREST.AsFloat);
  if ((modoGravacao = 'INCLUIR') or (modoGravacao = 'DUPLICAR')) then
  begin
    strEdita := 'UPDATE SERIES SET ULTIMO_NUMERO = ';
    strEdita := strEdita + QuotedStr(edtNumCte.Text);
    strEdita := strEdita + ' WHERE MODELO = ';
    strEdita := strEdita + QuotedStr('CT');
    strEdita := strEdita + ' and CODSERIE = ';
    strEdita := strEdita + QuotedStr(edtCodEmitente.Text);
    sql_retorno := GravarCTe;
    if (dmCte.dsCte.State in [dsEdit, dsInsert]) then
    begin
      dmCte.cdsCteCOD_CTE.AsInteger := val_genCte;
      dmCte.cdsCte.Post;
    end;
    try
      dmPdv.IbCon.ExecuteDirect(sql_retorno);
      dmPdv.IbCon.ExecuteDirect(strEdita);
      if (dmCte.dsSeguro.State in [dsInsert]) then
      begin
        DecimalSeparator := '.';
        vCteStr := 'INSERT INTO CTE_SEGURO (COD_CTE_SEGURO, COD_CTE, RESP ' +
          ', NOME_SEGURADORA, NUMERO_APOLICE, VALOR, NUMERO_AVERBACAO) VALUES (';
        vCteStr += IntToStr(dmCte.sqSegCOD_CTE_SEGURO.AsInteger);
        vCteStr += ', ' +  IntToStr(dmCte.sqSegCOD_CTE.AsInteger);
        vCteStr += ', ' + IntToStr(rgSeguroResp.ItemIndex);
        vCteStr += ', ' +  QuotedStr(dmCte.sqSegNOME_SEGURADORA.AsString);
        if (dmCte.sqSegNUMERO_APOLICE.AsString <> '') then
          vCteStr += ', ' +  QuotedStr(dmCte.sqSegNUMERO_APOLICE.AsString)
        else
          vCteStr += ', NULL';
        vCteStr += ', ' +  FloatToStr(dmCte.sqSegVALOR.AsFloat);
        if (dmCte.sqSegNUMERO_AVERBACAO.AsString <> '') then
          vCteStr += ', ' +  QuotedStr(dmCte.sqSegNUMERO_AVERBACAO.AsString)
        else
          vCteStr += ', NULL';
        vCteStr += ')';
        DecimalSeparator := ',';
        dmPdv.IbCon.ExecuteDirect(vCteStr);
        dmCte.sqSeg.post;
      end;
      dmPdv.sTrans.Commit;
      if (vDup <> 1 ) then
        MessageDlg('CTe Gravada com sucesso.', mtInformation, [mbOK], 0);
      FormatSettings.DecimalSeparator := ',';
      //modoGravacao := 'EDITAR'; // Comentei aqui
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dmPdv.sTrans.Rollback;
        exit;
      end;
    end;
  end
  else begin
    try
      vCteStr:= edtCodEmitente.Text;
      vCteStr:= edtNumCte.Text;
      if (dmCte.cdsCTENPROT.AsString <> '') then
      begin
        MessageDlg('CTe Ja Enviada. Não Pode ser Editada', mtInformation, [mbOK], 0);
        exit;
      end;
      if (dmCte.dsSeguro.State in [dsInsert]) then
      begin
        DecimalSeparator := '.';
        vCteStr := 'INSERT INTO CTE_SEGURO (COD_CTE_SEGURO, COD_CTE, RESP ' +
          ', NOME_SEGURADORA, NUMERO_APOLICE, VALOR, NUMERO_AVERBACAO) VALUES (';
        vCteStr += IntToStr(dmCte.sqSegCOD_CTE_SEGURO.AsInteger);
        vCteStr += ', ' +  IntToStr(dmCte.sqSegCOD_CTE.AsInteger);
        vCteStr += ', ' + IntToStr(rgSeguroResp.ItemIndex);
        vCteStr += ', ' +  QuotedStr(dmCte.sqSegNOME_SEGURADORA.AsString);
        if (dmCte.sqSegNUMERO_APOLICE.AsString <> '') then
          vCteStr += ', ' +  QuotedStr(dmCte.sqSegNUMERO_APOLICE.AsString)
        else
          vCteStr += ', NULL';
        vCteStr += ', ' +  FloatToStr(dmCte.sqSegVALOR.AsFloat);
        if (dmCte.sqSegNUMERO_AVERBACAO.AsString <> '') then
          vCteStr += ', ' +  QuotedStr(dmCte.sqSegNUMERO_AVERBACAO.AsString)
        else
          vCteStr += ', NULL';
        vCteStr += ')';
        DecimalSeparator := ',';
        dmPdv.IbCon.ExecuteDirect(vCteStr);
        dmCte.sqSeg.post;
      end;

      if (dmCte.dsSeguro.State in [dsEdit]) then
      begin
        dmCte.sqSegRESP.AsInteger := rgSeguroResp.ItemIndex;
        DecimalSeparator := '.';
        vCteStr := 'UPDATE CTE_SEGURO SET ';
        vCteStr += ' RESP = ' + IntToStr(rgSeguroResp.ItemIndex);
        vCteStr += ', NOME_SEGURADORA = ' +  QuotedStr(dmCte.sqSegNOME_SEGURADORA.AsString);
        if (dmCte.sqSegNUMERO_APOLICE.AsString <> '') then
          vCteStr += ', NUMERO_APOLICE = ' +  QuotedStr(dmCte.sqSegNUMERO_APOLICE.AsString);
        vCteStr += ', VALOR = ' +  FloatToStr(dmCte.sqSegVALOR.AsFloat);
        if (dmCte.sqSegNUMERO_AVERBACAO.AsString <> '') then
          vCteStr += ', NUMERO_AVERBACAO = ' +  QuotedStr(dmCte.sqSegNUMERO_AVERBACAO.AsString);
        vCteStr +=  ' WHERE COD_CTE_SEGURO = ' +
         IntToStr(dmCte.sqSegCOD_CTE_SEGURO.AsInteger);
        DecimalSeparator := ',';
        dmPdv.IbCon.ExecuteDirect(vCteStr);
        dmCte.sqSeg.post;
      end;

      FormatSettings.DecimalSeparator := '.';

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

      FormatSettings.DecimalSeparator := ',';



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
  dmPdv.sTrans.Commit;
  vCteStr:= edtNumCte.Text;
  vCteStr:= edtCodEmitente.Text;
  btnGravarCTe.Caption := 'Gravar CTE';
  btnPreVisu.Enabled := True;
  modoGravacao := 'CONSULTAR';
  vCteStr:= edtCodEmitente.Text;
  vCteStr:= edtNumCte.Text;
  if (dmCTe.cdsCTE.Active)then
    dmCTe.cdsCTE.Close;
  dmCTe.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
  dmCTe.cdsCTE.Params[1].AsInteger := StrToInt(edtNumCte.Text);
  dmCte.cdsCTE.Params[2].AsDate := DateTimePicker1.DateTime;
  dmCte.cdsCTE.Params[3].AsDate := DateTimePicker2.DateTime;
  dmCTe.cdsCTE.Open;

  //CarregarCte(IntToStr(val_genCte));

 //  if (dmCte.sqNFe.Active)then
 //   dmCte.sqNFe.Close;
 // dmCte.sqNFe.Params[0].AsInteger := val_genCte;
  //dmCte.sqNFe.Open;
  //dmCte.sqNFe.Refresh;


  dmCte.sqNFe.Open;
  dmCte.sqVeic.Open;
  dmCte.sqComp.Open;
  dmCte.sqMot.Open;
  dmCte.sqQC.Open;
  dmCte.sqSeg.Open;

  vDup := 1;
  if ((fQuantCarga.fcarga <> 1) and (fCompValor.fvalor <> 1)
    and (fNFe.fnfe <> 1) and (vDup <> 1)) then
    MessageDlg('CTe Gravada.', mtInformation, [mbOK], 0);
end;

procedure TfCTePrincipal.btnImportarXMLClick(Sender: TObject);
var
  i, j, k, n  : integer;
  //Nota, Node, NodePai, NodeItem: TTreeNode;
  //NFeRTXT: TNFeRTXT;
  nome : string;
  strEndereco: String;
begin
  //dm.cdsCli.Open;
  //dm.cdsCli.Close;
  edtXMLCod.Text  := '';
  edtXMLNome.Text  := '';
  edtXMLRazao.Text  := '';
  edtXMLCnpj.Text  := '';
  edtXMLIE.Text  := '';
  edtXMLLogradouro.Text  := '';
  edtXMLNumero.Text  := '';
  edtXMLComp.Text  := '';
  edtXMLBairro.Text  := '';
  edtXMLCEP.Text := '';
  edtXMLCodCidade.Text := '';
  edtXMLCidade.Text := '';
  edtXMLUF.Text := '';
  edtXMLFone.Text := '';
  //trvwNFe.Items.Clear;
  OpenDialog1.FileName  :=  '';
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Arquivos TXT (*.TXT)|*.TXT|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
  if OpenDialog1.Execute then
  begin
    //tenta TXT
    //ACBrNFe1.NotasFiscais.Add;
    //NFeRTXT := TNFeRTXT.Create(ACBrNFe1.NotasFiscais.Items[0].NFe);
    //NFeRTXT.CarregarArquivo(OpenDialog1.FileName);
    //if NFeRTXT.LerTxt then
    //   NFeRTXT.Free
    //else
    //begin
    //   NFeRTXT.Free;
    //tenta XML
    ACBrNFe1.NotasFiscais.Clear;
    try
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    except
      ShowMessage('Arquivo NFe Inválido');
      exit;
    end;
  end;

  for n:=0 to ACBrNFe1.NotasFiscais.Count-1 do
  begin
    with ACBrNFe1.NotasFiscais.Items[n].NFe do
    begin
      edtXMLCnpj.Text := Copy(Dest.CNPJCPF,1,2) + '.' + Copy(Dest.CNPJCPF,3,3) + '.' + Copy(Dest.CNPJCPF,6,3) + '/' + Copy(Dest.CNPJCPF,9,4) + '-' + Copy(Dest.CNPJCPF,13,2);
      edtXMLNome.Text := Dest.xNome ;
      edtXMLIE.Text := Dest.IE ;

      edtXMLLogradouro.Text := Dest.EnderDest.xLgr;
      edtXMLComp.Text   := Dest.EnderDest.xCpl;
      edtXMLCidade.Text := Dest.EnderDest.xMun ;
      edtXMLUF.Text     := Dest.EnderDest.UF ;
      edtXMLBairro.Text := Dest.EnderDest.xBairro ;
      edtXMLCEP.Text    := IntToStr(Dest.EnderDest.CEP) ;
      edtXMLFone.Text   := Dest.EnderDest.Fone;
      edtXMLNumero.Text := Dest.EnderDest.nro ;
      edtXMLCodCidade.Text := IntToStr(Dest.EnderDest.cMun);
    end;
  end;

  if(edtXMLCnpj.Text <> '') then
  begin
    dmPdv.busca_sql('SELECT CODCLIENTE FROM CLIENTES WHERE CNPJ = ' +
      QuotedStr(edtXMLCnpj.Text));
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      nome := QuotedStr(edtXMLNome.Text);
      nome += ', ' + QuotedStr(edtXMLRazao.Text);
      nome += ', 1, ' + QuotedStr(edtXMLCnpj.Text);
      nome += ', ' + QuotedStr(edtXMLIE.Text);
      nome += ', 1, 1, ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now));
      nome += ', 1, 1';

      strEndereco := QuotedStr(edtXMLLogradouro.Text);
      strEndereco += ', ' + QuotedStr(edtXMLBairro.Text);
      strEndereco += ', ' + QuotedStr(edtXMLComp.Text);
      strEndereco += ', ' + QuotedStr(edtXMLCidade.Text);
      strEndereco += ', ' + QuotedStr(edtXMLUF.Text);
      strEndereco += ', ' + QuotedStr(edtXMLCEP.Text);
      strEndereco += ', ' + QuotedStr(Copy(edtXMLFone.Text,2,12));
      strEndereco += ', ' + IntToStr(0);
      strEndereco += ', ' + QuotedStr(Copy(edtXMLFone.Text,0,2));
      strEndereco += ', ' + QuotedStr(edtXMLNumero.Text);
      strEndereco += ', ' + QuotedStr(edtXMLCodCidade.Text);
      strEndereco += ', ' + QuotedStr('Brasil');
      cadastraClientes(nome, strEndereco);
    end;
  end;

end;

procedure TfCTePrincipal.btnImprimirClick(Sender: TObject);
begin
  CarregarXML(dmCte.cdsCteCHCTE.AsString);
  ACBrCTe1.Consultar;
  ACBrCTe1.Conhecimentos.Imprimir;
end;

procedure TfCTePrincipal.btnImprimirEventoClick(Sender: TObject);
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

procedure TfCTePrincipal.btnIncCteClick(Sender: TObject);
var
  strEdita :string;
  i: Integer;
begin
  // Limpando tudo
  //DateTimePicker2.DateTime := Now;
  DateTimePicker2.DateTime := EndOfTheDay(date);
  lblCteAtual.Caption := '';
  lblCteAtual1.Caption := '';
  for i := 0 to fCTePrincipal.ComponentCount-1 do
  begin
    if fCTePrincipal.Components[i] is TEdit then
      TEdit(fCTePrincipal.Components[i]).Clear;
  end;
  modoInicio := 'NOVO';
  edtModelo.Text := IntToStr(vModeloCte);
  if (Trim(edtModelo.Text) = '57') then
  begin
    rgTipoServico.Items.Clear;
    rgTipoServico.Items.Add('Normal');
    rgTipoServico.Items.Add('SubContratação');
    rgTipoServico.Items.Add('Redespacho');
    rgTipoServico.Items.Add('Red. Intermediário');
    rgTipoServico.Items.Add('Serv. Multimodal');
  end;
  if (Trim(edtModelo.Text) = '67') then
  begin
   rgTipoServico.Items.Clear;
   rgTipoServico.Items.Add('Trasporte de pessoas');
   rgTipoServico.Items.Add('Transporte de Valores');
   rgTipoServico.Items.Add('Excesso de Bagagem');
  end;
  edModeloAtualiza.Text := 'CT';
  buscaEmpresa(comboEmpresa.Text);
  LerConfiguracao;
  edtProPred.Text := carga_prodpre;

  //dataOutrosEmi.Date := StrToDate('01/01/01');
  //dataRodPrev.Date := StrToDate('01/01/01');
  dataOutrosEmi.Checked := False;
  dataRodPrev.Checked := False;

  if(edtCodEmitente.Text = '') then
  begin
    MessageDlg('Inicie um Emitente .', mtInformation, [mbOK], 0);
    pcPrincipal.ActivePage := TabCteGeradas;
  end;

  dmPdv.busca_sql('SELECT SERIE_CTE ,ULTIMO_NUMERO FROM SERIES ' +
    ' WHERE MODELO = ' + QuotedStr('CT') +
    '   AND CODSERIE = ' + QuotedStr(edtCodEmitente.Text));
  if (dmPdv.sqBusca.FieldByName('ULTIMO_NUMERO').asInteger > 0) then
  begin
    edtSerieCte.Text := '';
    edtNumCte.Text := '';
    edtSerieCte.Text := dmPdv.sqBusca.FieldByName('serie_cte').AsString;
    edtNumCte.Text := IntToStr(dmPdv.sqBusca.FieldByName('ULTIMO_NUMERO').asInteger + 1);
  end;
  rgDest.ItemIndex:=0;
  dataGerarCte.DateTime := now;
  edtCFOP.ReadOnly := False;
  edtNatOpe.ReadOnly := False;
  btnGerar.Enabled := True;
  StatusBar1.SimpleText := 'CTe Iniciada com Sucesso. MODO : INCLUSÃO' ;
  modoGravacao := 'INCLUIR';
  sbtnLerXmlCte.Enabled := True;
  sbtnLerXmlCte1.Enabled := True;
  edtRodRNTRC.Text := rntrc_padrao;
  edtCfop.Text := cfop_padrao;
  edtNatOpe.Text := nat_padrao;

  /// Começa aqui Correção dia 15/08/17
  if (dmCte.sqComp.Active)then
    dmCte.sqComp.Close;
  dmCte.sqComp.Params[0].AsInteger := 0;
  dmCte.sqComp.Open;

  if (dmCte.sqQC.Active)then
    dmCte.sqQC.Close;
  dmCte.sqQC.Params[0].AsInteger := 0;
  dmCte.sqQC.Open;

  if (dmCte.sqNFe.Active)then
    dmCte.sqNFe.Close;
  dmCte.sqNFe.Params[0].AsInteger := 0;
  dmCte.sqNFe.Open;

  if (dmCte.sqSeg.Active)then
    dmCte.sqSeg.Close;
  dmCte.sqSeg.Params[0].AsInteger := 0;
  dmCte.sqSeg.Open;

  if (dmCte.sqVeic.Active)then
    dmCte.sqVeic.Close;
  dmCte.sqVeic.Params[0].AsInteger := 0;
  dmCte.sqVeic.Open;

  if (dmCte.sqMot.Active)then
    dmCte.sqMot.Close;
  dmCte.sqMot.Params[0].AsInteger := 0;
  dmCte.sqMot.Open;

  {  if (dm.cdsNF.Active)then
      dm.cdsNF.Close;
    dm.cdsNF.Params[0].AsInteger := 0;
    dm.cdsNF.Open;}

  edtAntCHCTE.Text := '';

  if (not dmCte.cdsCte.Active)then
    dmCte.cdsCte.Open;
  dmCte.cdsCte.Append;

  //dbValPIcms.Text := FloatToStr(percent_icms);
  dmCte.cdsCteVALPICMS.AsFloat := percent_icms;
  pcPrincipal.ActivePageIndex := 1;
  pcCte.ActivePageIndex := 0;
  edtCfop.SetFocus;

  btnGravarCTe.Enabled := True;
  btnCancelarEdicaoCTe.Enabled := True;
  btnPreVisu.Enabled := True;
  btnGerarCte.Enabled := True;
  btnGravarCTe.Caption := 'Gravar CTE *';
end;

procedure TfCTePrincipal.btnIncluirNFeClick(Sender: TObject);
begin
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if(edtNumCte.Text = '') then
  begin
   MessageDlg('Inclua uma CTe', mtWarning,[mbOK],0);
   exit;
  end;
     if not(ZsqNFe.Active)then
      ZsqNFe.Active;
    //fNFe.path_xml := edtCteImportar.Text;
    ZsqNFe.Append;
    ZsqNFeCTE_NFE.AsInteger := val_genCte;
    fNFe.btnEdita.Visible :=False;
    fNFe.ShowModal;
  {if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if(edtNumCte.Text = '') then
  begin
   MessageDlg('Inclua uma CTe', mtWarning,[mbOK],0);
   exit;
  end;
  if (modoGravacao = 'INCLUIR') then
    btnGravarCTe.Click;
  if not(dmCte.sqNFe.Active)then
    dmCte.sqNFe.Active;
  fNFe.path_xml := edtCteImportar.Text;
  dmCte.sqNFe.Append;
  dmCte.sqNFeCTE_NFE.AsInteger := val_genCte;
  fNFe.btnEdita.Visible :=False;
  fNFe.ShowModal;
 {
  fNFe := TfNFe.Create(Application);
  try
    fNFe.path_xml := edtCteImportar.Text;
    dmCte.sqNFe.Append;
    dmCte.sqNFeCTE_NFE.AsInteger := val_genCte;
    fNFe.btnEdita.Visible :=False;
    fNFe.ShowModal;
  finally
   fNFe.Free;
  end;
  }
 {
  dmCte.sqNFe.Close;
  dmCte.sqNFe.Params[0].AsInteger := val_genCte;
  dmCte.sqNFe.Open;
 }
  }
end;

procedure TfCTePrincipal.btnInutilizarClick(Sender: TObject);
var
 Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : String;
begin
  if (edInutAno.Text = '') then
  begin
    ShowMessage('Informe o ano para inutilizar.');
    Exit;
  end;
  ano := edInutAno.Text;
  Modelo := edInutModelo.Text;
  Serie := edInutSerie.Text;
  NumeroInicial := edInutNumeroIni.Text;
  NumeroFinal := edInutNumeroFim.Text;
  if (edInutJustificativa.Text = '') then
  begin
    ShowMessage('Justifique o motivo da Inutilização.');
    Exit;
  end;
  Justificativa := edInutJustificativa.Text;
  ACBrCTe1.WebServices.Inutiliza(edtEmitCNPJ.Text, Justificativa, StrToInt(Ano),
                                StrToInt(Modelo), StrToInt(Serie),
                                StrToInt(NumeroInicial), StrToInt(NumeroFinal));
  MemoResp.Lines.Text   := UTF8Encode(ACBrCTe1.WebServices.Inutilizacao.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.Inutilizacao.RetWS);
end;

procedure TfCTePrincipal.btnListarCteClick(Sender: TObject);
begin
  lblCteAtual.Caption := '';
  lblCteAtual1.Caption := '';
  modoInicio := 'CONSULTAR';
  modoGravacao := 'CONSULTAR';
  btnGravarCTe.Enabled := False;
  btnCancelarEdicaoCTe.Enabled := False;
  btnPreVisu.Enabled := False;
  btnGerarCte.Enabled := False;
  btnCC.Enabled := False;
  sbtnLerXmlCte.Enabled := False;
  sbtnLerXmlCte1.Enabled := False;

  dmCte.cdsCte.Close;
  dmCte.cdsCte.SQL.Clear;
  dmCte.cdsCte.SQL.Add('SELECT * FROM CTE ' +
    ' WHERE ((emitente = :pEmi ) ' +
    '   AND ((cte_numero = :num_cte) or (:num_cte = 0)) ' +
    '   AND (DHEMI between :Data1 and  :Data2)) ' +
    ' ORDER BY CTE_NUMERO DESC');

  if(edtCodEmitente.Text = '') then
  begin
   MessageDlg('Inicie um Emitente .', mtInformation, [mbOK], 0);
   exit;
  end;

  dmCte.cdsCTE.Close;
  if (edtDestNome1.Text <> '') then
  begin
    dmCte.cdsCte.SQL.Clear;
    dmCte.cdsCte.SQL.Add('SELECT * FROM CTE ' +
      ' WHERE ((emitente = :pEmi ) ' +
      '   AND ((cte_numero = :num_cte) or (:num_cte = 0)) ' +
      '   AND (DHEMI between :Data1 and  :Data2) ' +
      '   AND (UPPER(D_FANTASIA) LIKE UPPER(' + QuotedStr('%' +
          edtDestNome1.Text + '%') + '))) ORDER BY CTE_NUMERO DESC');
  end;
  if not(dmCte.cdsCTE.Active)then
    dmCte.cdsCTE.Active;
  dmCte.cdsCTE.Params[0].AsInteger := StrToInt(edtCodEmitente.Text);
  dmCte.cdsCTE.Params[1].AsInteger := 0;
  dmCte.cdsCTE.Params[2].AsDateTime := DateTimePicker1.DateTime;
  dmCte.cdsCTE.Params[3].AsDateTime := DateTimePicker2.DateTime;
  dmCte.cdsCTE.Open;
  btnEditarCte.SetFocus;
end;

procedure TfCTePrincipal.btnPreVisuClick(Sender: TObject);
var   vAux : String;
 nome_arq: String;
begin
  vAux := edtNumCte.Text;
  if(naoexecuta <> 1)then
  naoexecuta := 0;
  btnGravarCTe.Click;
  CarregarAcbr;
  ACBrCTe1.Conhecimentos.Clear;
  if (dmCte.cdsCTENPROT.AsString = '') then
  begin
    GerarCTe(vAux);
    ACBrCTe1.Conhecimentos.Items[0].GravarXML('','');
    ACBrCTe1.Conhecimentos.Imprimir;
  end
  else begin
    CarregarXML(dmCte.cdsCteCHCTE.AsString);
    ACBrCTe1.Conhecimentos.Imprimir;
  end;
end;

procedure TfCTePrincipal.btnStatusServClick(Sender: TObject);
begin
  ACBrCTe1.WebServices.StatusServico.Executar;
  MemoResp.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.StatusServico.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(ACBrCTe1.WebServices.StatusServico.RetWS);
  //LoadXML(MemoResp);

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

procedure TfCTePrincipal.btnValidarXMLClick(Sender: TObject);
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

procedure TfCTePrincipal.btnVeicEditarClick(Sender: TObject);
begin
  if ((modoGravacao = 'INCLUIR') or (modoGravacao = 'EDITAR')) then
  begin
    dmCte.sqVeic.Edit;
    fVeiculoCte.ShowModal;
  end;
end;

procedure TfCTePrincipal.btnVeicExcluirClick(Sender: TObject);
begin
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;

  if MessageDlg('Deseja realmente excluir este registro?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if ( dbGridQC.Columns[1].Field.Value <> '') then
    begin
      strInsere := 'DELETE FROM CTE_VEICULOS';
      strInsere := strInsere + ' WHERE COD_CTE_VEICULOS = ';
      strInsere := strInsere +  IntToStr(dmCte.sqVeicCOD_CTE_VEICULOS.AsInteger);
      dmPdv.IbCon.ExecuteDirect(strInsere);
      dmCte.sqVeic.Delete;
    end;
  end;
end;

procedure TfCTePrincipal.btnVeicIncluirClick(Sender: TObject);
begin
  if ((modoGravacao = 'INCLUIR') or (modoGravacao = 'EDITAR')) then
  begin
    dmCte.sqVeic.Append;
    dmCte.sqVeicCOD_CTE.AsInteger := val_genCte;
    fVeiculoCte.ShowModal;
  end;
end;

procedure TfCTePrincipal.Button11Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.btnInsertCompClick(Sender: TObject);
begin
  if(pCompExclui <> '')then
  begin
    edtComp.Text := pCompExclui;
    ZConn.StartTransaction;
    try
      ZConn.ExecuteDirect(pCompExclui);
      ZConn.Commit;
    except
      ZConn.Rollback;
      raise;
    end;
    pCompExclui := '';
  end;


  if(fCompValor.pcompInsere  <> '')then
  begin
    edtComp.Text := fCompValor.pcompInsere;
    ZConn.StartTransaction;
    try
      ZConn.ExecuteDirect(fCompValor.pcompInsere);
      ZConn.Commit;
    except
      ZConn.Rollback;
      raise;
    end;
    fCompValor.pcompInsere := '';
  end;


  if(fCompValor.pcompEdit <> '')then
  begin
    edtComp.Text := fCompValor.pcompEdit;
    ZConn.StartTransaction;
    try
      ZConn.ExecuteDirect(fCompValor.pcompEdit);
      ZConn.Commit;
    except
      ZConn.Rollback;
      raise;
    end;
    fCompValor.pcompEdit := '';
  end;

  dmCte.sqComp.Refresh;

  if (ZsqComp.Active)then
    ZsqComp.Close;
  ZsqComp.Params[0].AsInteger := val_genCte;
  ZsqComp.Open;

end;

procedure TfCTePrincipal.Button1Click(Sender: TObject);
begin

end;



procedure TfCTePrincipal.Button30Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.cbCryptLibChange(Sender: TObject);
begin
  try
    if cbCryptLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLCryptLib := TSSLCryptLib(cbCryptLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfCTePrincipal.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfCTePrincipal.cbSSLLibChange(Sender: TObject);
begin
 try
   if cbSSLLib.ItemIndex <> -1 then
     ACBrNFe1.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
 finally
   AtualizaSSLLibsCombo;
 end;

end;

procedure TfCTePrincipal.cbSSLTypeChange(Sender: TObject);
begin
    if cbSSLType.ItemIndex <> -1 then
     ACBrNFe1.SSL.SSLType := TSSLType(cbSSLType.ItemIndex);
end;

procedure TfCTePrincipal.cbXmlSignLibChange(Sender: TObject);
begin
  try
    if cbXmlSignLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfCTePrincipal.comboEmpresaChange(Sender: TObject);
begin
  buscaEmpresa(comboEmpresa.Text);
end;

procedure TfCTePrincipal.dbGridCompCellClick(Column: TColumn);
begin
  componente_nome := dmCte.sqCompCOMP_NOME.AsString;
end;

procedure TfCTePrincipal.dbGridQCCellClick(Column: TColumn);
begin
  carga_un := dmCte.sqQCUNID.AsString;
  carga_desc := dmCte.sqQCMEDIDA.AsString;
end;

procedure TfCTePrincipal.dbValInfCargaChange(Sender: TObject);
begin
  //if (dmCte.cdsCteVPREST.NewValue <> dmCte.cdsCteVPREST.OldValue) then
  //begin
  //  if (Trim(dmCte.cdsCTENPROT.AsString) = '') then
  //  begin
  //    if ((modoGravacao <> 'EDITAR') and (modoGravacao <> 'INCLUIR')) then
  //      modoGravacao := 'EDITAR';
  //  end;
  //end;
end;

procedure TfCTePrincipal.dbValReceberChange(Sender: TObject);
begin

end;

procedure TfCTePrincipal.dbValTotPrestChange(Sender: TObject);
begin
  if (dmCte.cdsCte.State in [dsInactive, dsBrowse]) then
  begin
    if (dmCte.cdsCteVPREST.NewValue <> dmCte.cdsCteVPREST.OldValue) then
    begin
      if (Trim(dmCte.cdsCTENPROT.AsString) = '') then
      begin
        if (modoInicio = 'ALTERAR') then
          if ((modoGravacao <> 'EDITAR') and (modoGravacao <> 'INCLUIR')) then
             modoGravacao := 'EDITAR';
        if (modoInicio = 'NOVO') then
          if ((modoGravacao <> 'EDITAR') and (modoGravacao <> 'INCLUIR')) then
             modoGravacao := 'INCLUIR';
      end;
    end;
  end;
end;

procedure TfCTePrincipal.edtXMLCodChange(Sender: TObject);
begin

end;





procedure TfCTePrincipal.FormCreate(Sender: TObject);
var
 T : TSSLLib;
 I : TpcnTipoEmissao;
 FS: TFileStream;
 U: TSSLCryptLib;
 V: TSSLHttpLib;
 X: TSSLXmlSignLib;
 Y: TSSLType;
 K: TVersaoCTe;
 vlr_dpi: Integer;
 conf: TIniFile;
 Ini: TIniFile;
begin
  fCTePrincipal.Caption := 'CTe - Conhecimento de Transporte Eletrônico ';
  if FileExists(dmPdv.path_exe  + 'conf.ini') then
  begin
    conf := TIniFile.Create(dmPdv.path_exe + 'conf.ini');
    try
      vlr_dpi := conf.ReadInteger('OUTROS', 'Dpi', 96);
    finally
      conf.free;
    end;
  end;
 self.DesignTimePPI := vlr_dpi;
 self.AutoAdjustLayout(lapAutoAdjustForDPI, vlr_dpi, Screen.PixelsPerInch, Self.Width, ScaleX(Self.Width, vlr_dpi));
 cbSSLLib.Items.Clear ;
 For T := Low(TSSLLib) to High(TSSLLib) do
   cbSSLLib.Items.Add( GetEnumName(TypeInfo(TSSLLib), integer(T) ) ) ;
 cbSSLLib.ItemIndex := 0 ;

 cbCryptLib.Items.Clear ;
 For U := Low(TSSLCryptLib) to High(TSSLCryptLib) do
   cbCryptLib.Items.Add( GetEnumName(TypeInfo(TSSLCryptLib), integer(U) ) ) ;
 cbCryptLib.ItemIndex := 0 ;

 cbHttpLib.Items.Clear ;
 For V := Low(TSSLHttpLib) to High(TSSLHttpLib) do
   cbHttpLib.Items.Add( GetEnumName(TypeInfo(TSSLHttpLib), integer(V) ) ) ;
 cbHttpLib.ItemIndex := 0 ;

 cbXmlSignLib.Items.Clear ;
 For X := Low(TSSLXmlSignLib) to High(TSSLXmlSignLib) do
   cbXmlSignLib.Items.Add( GetEnumName(TypeInfo(TSSLXmlSignLib), integer(X) ) ) ;
 cbXmlSignLib.ItemIndex := 0 ;

 cbSSLType.Items.Clear ;
 For Y := Low(TSSLType) to High(TSSLType) do
   cbSSLType.Items.Add( GetEnumName(TypeInfo(TSSLType), integer(Y) ) ) ;
 cbSSLType.ItemIndex := 0 ;

  cbVersaoDF.Items.Clear;
  for K := Low(TVersaoCTe) to High(TVersaoCTe) do
     cbVersaoDF.Items.Add( GetEnumName(TypeInfo(TVersaoCTe), integer(K) ) );
  cbVersaoDF.ItemIndex := 2;

  ZConn.Connected := False;
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'conf.ini');
  try
      ZConn.Connected       := False;
      ZConn.HostName        := Ini.ReadString('ZConn', 'Hostname', '');
      ZConn.Port            := Ini.ReadInteger('ZConn', 'Port', 0);
      ZConn.Protocol        := Ini.ReadString('ZConn', 'Protocol', '');
      ZConn.LibraryLocation := Ini.ReadString('ZConn', 'LibraryLocation', '');
      ZConn.User            := Ini.ReadString('ZConn', 'User', '');
      ZConn.Password        := Ini.ReadString('ZConn', 'Password', '');
      ZConn.Database        := Ini.ReadString('ZConn', 'Database', '');
      ZConn.ClientCodepage  := Ini.ReadString('ZConn', 'Charset', '');
      ZQuery1.Open;
  except
       on E:Exception do
       MessageDlg('Erro ao conectar!'#13'Erro: ' + e.Message, mtError, [mbOK], 0);
  end;

end;

procedure TfCTePrincipal.FormKeyPress(Sender: TObject; var Key: char);
begin
  if (key = #13) then
  begin
    key:= #0;
    SelectNext((Sender as TwinControl),True,True);
  end;
end;

procedure TfCTePrincipal.FormShow(Sender: TObject);
var
   emp,nomexeC ,nomexebd : string ;
   vDate1 , vDate2 : TdateTime;
begin
  //fCTePrincipal.Caption := 'CTe - Conhecimento de Transporte Eletrônico, versão ' +

  dmPdv.sqEmpresa.Open;
  while not dmPdv.sqEmpresa.Eof do
  begin
    comboEmpresa.Items.Add(dmPdv.sqEmpresaRAZAO.AsString);
    dmPdv.sqEmpresa.Next;
  end;
  if (dmPdv.sqEmpresa.RecordCount = 1) then
  begin
    comboEmpresa.ItemIndex :=0;
    buscaEmpresa(dmPdv.sqEmpresaRAZAO.AsString);
  end;
  {
  combCodSitTrib.Items.Add('00 - Trib. Normal do ICMS');
  combCodSitTrib.Items.Add('20 - Trib. Redução BC do ICMS');
  combCodSitTrib.Items.Add('40 - ICMS Isenção');
  combCodSitTrib.Items.Add('41 - ICMS não Tributado');
  combCodSitTrib.Items.Add('51 - ICMS Deferido');
  combCodSitTrib.Items.Add('60 - ICMS Cobrado Anterior ST');
  combCodSitTrib.Items.Add('90 - ICMS Outros');}

  LerConfiguracao;

  edInutModelo.Text := IntToStr(vModeloCTe);
  dmPdv.busca_sql('SELECT SERIE_CTE ,ULTIMO_NUMERO FROM SERIES ' +
    ' WHERE MODELO = ' + QuotedStr('CT') +
    '   AND CODSERIE = ' + QuotedStr(edtCodEmitente.Text));
  if (dmPdv.sqBusca.FieldByName('ULTIMO_NUMERO').asInteger > 0) then
  begin
    edtSerieCte.Text := dmPdv.sqBusca.FieldByName('SERIE_CTE').AsString;
    edInutSerie.Text := dmPdv.sqBusca.FieldByName('SERIE_CTE').AsString;
    edSerieAtualiza.Text := dmPdv.sqBusca.FieldByName('SERIE_CTE').AsString;
    edUltimoAtualiza.Text := IntToStr(dmPdv.sqBusca.FieldByName('ULTIMO_NUMERO').AsInteger);
  end;

  dmPdv.sqParametro.Open;
  While not  dmPdv.sqParametro.EOF do
  begin
    if (dmPdv.sqParametroPARAMETRO.AsString = 'EMPRESA') then
    begin
      nomexebd := dmPdv.sqParametroD1.Text;
      if(nomexebd <> 'Cte.exe') then
      begin
        if(nomexeC = 'ats_CTe.exe') then
        begin
          MessageDlg('Abra o Programa pelo Aplicativo Cte ' , mtInformation, [mbOK], 0);
          Application.Terminate;
        end;
      end;
      if(dmPdv.sqParametroINSTRUCOES.Text = 'A Licença de uso expirada.') then
      begin
        comboEmpresa.Enabled    := False;
        btnListarCte.Enabled    := False;
        btnIncCte.Enabled       := False;
        btnEditarCte.Enabled    := False;
        btnDuplicar.Enabled     := False;
        //btnImpPeriodo.Enabled   := False;
        btnGerar.Enabled        := False;
        BitBtn1.Enabled         := False;
        btnGravarCTe.Enabled    := False;
        //btnSalvarConfig.Enabled := False;
        //SpeedButton1.Enabled    := False;
      end
      else begin
        DadosBasicos;
        CarregarUF;
      end;
    end;
    dmPdv.sqParametro.Next;
  end;
  //vDate1 := StartOfTheMonth(today);
  //DateTimePicker1.Date := vDate1 ;
  //DateTimePicker1.DateTime:= Now;
  //vDate2 := today;
  //DateTimePicker2.Date := vDate2;
  //DateTimePicker2.DateTime := Now;

  DateTimePicker1.DateTime:= StartofTheDay(date);
  DateTimePicker2.DateTime:= EndOfTheDay(date);


  modoGravacao := 'CONSULTAR';
  pcPrincipal.PageIndex := 0;
end;

procedure TfCTePrincipal.Label120Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.Label138Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.Label155Click(Sender: TObject);
begin
  end;

procedure TfCTePrincipal.Label176Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.Label60Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.mmEmailMsgChange(Sender: TObject);
begin

end;





procedure TfCTePrincipal.pcCteChange(Sender: TObject);
begin
  Case pcCte.ActivePageIndex of
    0: edtCfop.SetFocus;
    1: edtCodEmitente.SetFocus;
    2: edtBuscaTomador.SetFocus;
    3: if rgRem.ItemIndex = 0 then edtRemBusca.SetFocus;
    4: if rgExp.ItemIndex = 0 then edtExpBusca.SetFocus;
    5: if rgRec.ItemIndex = 0 then edtRecBusca.SetFocus;
    6: if rgDest.ItemIndex = 0 then edtDestBusca.SetFocus;
    7: dbValTotPrest.SetFocus;
    8: if PageControl4.ActivePageIndex = 0 then dbValInfCarga.SetFocus;
    9: edtRodRNTRC.SetFocus;
  end;

end;

procedure TfCTePrincipal.pcCteChanging(Sender: TObject; var AllowChange: Boolean
  );
begin
  {Case pcCte.ActivePageIndex of
    0: edtCfop.SetFocus;
    7: dbValTotPrest.SetFocus;
    8: dbValInfCarga.SetFocus;
  end;}
end;

procedure TfCTePrincipal.pcPrincipalChange(Sender: TObject);
begin
end;

procedure TfCTePrincipal.rgDestClick(Sender: TObject);
begin
  if rgDest.ItemIndex = 0 then
  begin
    GroupBoxDestinatario.Visible := True;
  end;

  if rgDest.ItemIndex <> 0 then
  begin
    GroupBoxDestinatario.Visible := False;
  end;
end;

procedure TfCTePrincipal.rgExpClick(Sender: TObject);
begin
  if rgExp.ItemIndex = 1 then
  begin
    GroupBoxExpeditor.Visible := False;
  end;

  if rgExp.ItemIndex = 0 then
  begin
    GroupBoxExpeditor.Visible := True;
  end;
end;

procedure TfCTePrincipal.rgFormaEmissaoClick(Sender: TObject);
begin

end;

procedure TfCTePrincipal.rgRecClick(Sender: TObject);
begin
  if rgRec.ItemIndex = 1 then
  begin
    GroupBoxRecebedor.Visible := False;
  end;

  if rgRec.ItemIndex = 0 then
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
  if rgRem.ItemIndex = 1 then
  begin
    GroupBoxRemetente.Visible := False;
  end;

  if rgRem.ItemIndex <> 1 then
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

procedure TfCTePrincipal.sbtnCaminhoCertClick(Sender: TObject);
begin

end;

procedure TfCTePrincipal.sbtnCteImportarClick(Sender: TObject);
var
 Dir : string;
begin
  if Length(edtPathLogs.Text) <= 0 then
    Dir := ExtractFileDir(application.ExeName)
  else
    Dir := edtPathLogs.Text;
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
    edtCteImportar.Text := Dir;
end;

procedure TfCTePrincipal.sbtnGetCertClick(Sender: TObject);
var
  I: Integer;
begin
  {frSelecionarCertificado := TfrSelecionarCertificado.Create(Self);
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
      edtNumSerie.Text := frSelecionarCertificado.StringGrid1.Cells[ 0,
                            frSelecionarCertificado.StringGrid1.Row];

  finally
     frSelecionarCertificado.Free;
  end;
   }
  edtNumSerie.Text := ACBrCTe1.SSL.SelecionarCertificado;
end;

procedure TfCTePrincipal.sbtnLerXmlCteClick(Sender: TObject);
 var v_lerxml: String;
   i: Integer;
   cod_gen : Integer;
   v_xml2, nome, strEndereco: String;
   vstr_sql :string;
   num_cod_comp: Integer;
begin
  // lendo xml
                                                                        pvalordokilo := StrToFloat(Edit1.Text);

 if (modoGravacao = 'INCLUIR') then
 begin
   btnGravarCTe.Click;
   btnEditarCte.Click;
 end;
 if (modoGravacao = 'EDITAR') then
 begin
   OpenDialog1.Title := 'Selecione o CTe';
   OpenDialog1.DefaultExt := '*.xml';
   OpenDialog1.Filter := 'Arquivos CTe (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
   OpenDialog1.InitialDir := edtCteImportar.Text;
   if OpenDialog1.Execute then
   begin
     ACBrCTe2.Conhecimentos.Clear;
     ACBrCTe2.Conhecimentos.LoadFromFile(OpenDialog1.FileName);
     with ACBrCTe2.Conhecimentos.Items[0].CTe do
     begin
       // Destinatario
       v_lerxml := dest.CNPJCPF;
       if (Length(v_lerxml) > 11) then
         v_lerxml := Copy(v_lerxml,0,2) + '.' + Copy(v_lerxml,3,3) + '.' +
           Copy(v_lerxml,6,3) + '/' + Copy(v_lerxml,9,4) + '-' +
           Copy(v_lerxml,13,2);
       dmPdv.busca_sql('SELECT CODCLIENTE FROM CLIENTES ' +
         ' WHERE CNPJ = ' + QuotedStr(v_lerxml));
       if (dmPdv.sqBusca.IsEmpty) then
       begin
         nome := QuotedStr(dest.xNome);
         nome += ', ' + QuotedStr(dest.xNome);
         nome += ', 1, ' + QuotedStr(v_lerxml);
         nome += ', ' + QuotedStr(dest.IE);
         nome += ', 1, 0, ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now));
         nome += ', 1, 1';

         strEndereco := QuotedStr(Copy(dest.enderDest.xLgr,0,50));
         strEndereco += ', ' + QuotedStr(Copy(dest.enderDest.xBairro,0,29));
         strEndereco += ', ' + QuotedStr(Copy(dest.enderDest.xCpl,0,29));
         strEndereco += ', ' + QuotedStr(Copy(dest.enderDest.xMun,0,39));
         strEndereco += ', ' + QuotedStr(dest.enderDest.UF);
         strEndereco += ', ' + QuotedStr(IntToStr(dest.enderDest.CEP));
         strEndereco += ', ' + QuotedStr(Copy(dest.fone,2,12));
         strEndereco += ', ' + IntToStr(0);
         strEndereco += ', ' + QuotedStr(Copy(dest.Fone,0,2));
         strEndereco += ', ' + QuotedStr(dest.enderDest.nro);
         strEndereco += ', ' + QuotedStr(IntToStr(dest.enderDest.cMun));
         strEndereco += ', ' + QuotedStr('Brasil');
         cadastraClientes(nome, strEndereco);
         dmCte.cdsCte.Open;
         dmCte.cdsCte.Edit;
         dmPdv.busca_sql('SELECT CODCLIENTE FROM CLIENTES ' +
           ' WHERE CNPJ = ' + QuotedStr(v_lerxml));
       end;

       if (not dmPdv.sqBusca.IsEmpty) then
       begin
         edtDestBusca.Text := IntToStr(dmPdv.sqBusca.FieldByName('CODCLIENTE').asInteger);
         fClienteBusca.cCodCliente := StrToInt(edtDestBusca.Text);
         fClienteBusca.BuscaCliente;
         rgDest.ItemIndex:=0;
         buscaDestinatario;
       end;
       // Expedidor
       v_lerxml := emit.CNPJ;
       if (Length(v_lerxml) > 11) then
         v_lerxml := Copy(v_lerxml,0,2) + '.' + Copy(v_lerxml,3,3) + '.' +
           Copy(v_lerxml,6,3) + '/' + Copy(v_lerxml,9,4) + '-' +
           Copy(v_lerxml,13,2);
       dmPdv.busca_sql('SELECT CODCLIENTE FROM CLIENTES ' +
         ' WHERE CNPJ = ' + QuotedStr(v_lerxml));
       if (dmPdv.sqBusca.IsEmpty) then
       begin
           nome := QuotedStr(emit.xNome);
           nome += ', ' + QuotedStr(emit.xNome);
           nome += ', 1, ' + QuotedStr(v_lerxml);
           nome += ', ' + QuotedStr(emit.IE);
           nome += ', 1, 1, ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now));
           nome += ', 1, 1';

           strEndereco := QuotedStr(emit.enderEmit.xLgr);
           strEndereco += ', ' + QuotedStr(emit.enderEmit.xBairro);
           strEndereco += ', ' + QuotedStr(emit.enderEmit.xCpl);
           strEndereco += ', ' + QuotedStr(emit.enderEmit.xMun);
           strEndereco += ', ' + QuotedStr(emit.enderEmit.UF);
           strEndereco += ', ' + QuotedStr(IntToStr(emit.enderEmit.CEP));
           strEndereco += ', ' + QuotedStr(Copy(emit.enderEmit.fone,2,12));
           strEndereco += ', ' + IntToStr(0);
           strEndereco += ', ' + QuotedStr(Copy(emit.enderEmit.Fone,0,2));
           strEndereco += ', ' + QuotedStr(emit.enderEmit.nro);
           strEndereco += ', ' + QuotedStr(IntToStr(emit.enderEmit.cMun));
           strEndereco += ', ' + QuotedStr('Brasil');
           cadastraClientes(nome, strEndereco);
           dmCte.cdsCte.Open;
           dmCte.cdsCte.Edit;
           dmPdv.busca_sql('SELECT CODCLIENTE FROM CLIENTES ' +
             ' WHERE CNPJ = ' + QuotedStr(v_lerxml));
       end;
       if (not dmPdv.sqBusca.IsEmpty) then
       begin
         edtExpBusca.Text := IntToStr(dmPdv.sqBusca.FieldByName('CODCLIENTE').asInteger);
         fClienteBusca.cCodCliente := StrToInt(edtExpBusca.Text);
         fClienteBusca.BuscaCliente;
         edtExpBuscaExit(Nil);
         rgExp.ItemIndex:=0;
         edtAntNome.Text := edtExpRazao.Text;
         edtAntCNPJ.Text := edtExpCNPJ.Text;
         edtAntIE.Text := edtExpIE.Text;
         edtAntUF.Text := edtExpUF.Text;
         v_lerxml := procCTe.chCTe;
         edtAntCHCTE.Text := v_lerxml;
       end;
       // Remetente
       v_lerxml := rem.CNPJCPF;
       if (Length(v_lerxml) > 11) then
         v_lerxml := Copy(v_lerxml,0,2) + '.' + Copy(v_lerxml,3,3) + '.' +
           Copy(v_lerxml,6,3) + '/' + Copy(v_lerxml,9,4) + '-' +
           Copy(v_lerxml,13,2);
       dmPdv.busca_sql('SELECT CODCLIENTE FROM CLIENTES ' +
         ' WHERE CNPJ = ' + QuotedStr(v_lerxml));
       if (dmPdv.sqBusca.IsEmpty) then
       begin
         nome := QuotedStr(rem.xNome);
         nome += ', ' + QuotedStr(rem.xNome);
         nome += ', 1, ' + QuotedStr(v_lerxml);
         nome += ', ' + QuotedStr(rem.IE);
         nome += ', 1, 1, ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now));
         nome += ', 1, 1';

         strEndereco := QuotedStr(rem.enderReme.xLgr);
         strEndereco += ', ' + QuotedStr(rem.enderReme.xBairro);
         strEndereco += ', ' + QuotedStr(rem.enderReme.xCpl);
         strEndereco += ', ' + QuotedStr(rem.enderReme.xMun);
         strEndereco += ', ' + QuotedStr(rem.enderReme.UF);
         strEndereco += ', ' + QuotedStr(IntToStr(rem.enderReme.CEP));
         strEndereco += ', ' + QuotedStr(Copy(rem.fone,2,12));
         strEndereco += ', ' + IntToStr(0);
         strEndereco += ', ' + QuotedStr(Copy(rem.Fone,0,2));
         strEndereco += ', ' + QuotedStr(rem.enderReme.nro);
         strEndereco += ', ' + QuotedStr(IntToStr(rem.enderReme.cMun));
         strEndereco += ', ' + QuotedStr('Brasil');
         cadastraClientes(nome, strEndereco);
         dmCte.cdsCte.Open;
         dmCte.cdsCte.Edit;
         dmPdv.busca_sql('SELECT CODCLIENTE FROM CLIENTES ' +
           ' WHERE CNPJ = ' + QuotedStr(v_lerxml));
       end;
       if (not dmPdv.sqBusca.IsEmpty) then
       begin
         edtRemBusca.Text := IntToStr(dmPdv.sqBusca.FieldByName('CODCLIENTE').asInteger);
         fClienteBusca.cCodCliente := StrToInt(edtRemBusca.Text);
         fClienteBusca.BuscaCliente;
         rgRem.ItemIndex:=0;
         edtRemBuscaExit(Nil);
       end;

       // Componentes
       dmCte.cdsCteVREC.AsFloat := 0; // vPrest.vRec;
       dmCte.cdsCteVPREST.AsFloat := 0; // vPrest.vTPrest;
       dmPdv.Ibcon.ExecuteDirect('DELETE FROM CTE_COMP' +
         ' WHERE COD_CTE = ' +  IntToStr(val_genCte));
       {
       for i := 0 to vPrest.Comp.Count  -1 do
       begin
         with vPrest.Comp.Items[i] do
         begin
           FormatSettings.DecimalSeparator := '.';
           v_lerxml := 'INSERT INTO CTE_COMP (COD_CTE_COMP, COD_CTE ,COMP_NOME, ' +
             ' COMP_VALOR) VALUES ( GEN_ID(GEN_CTE_COMP_ID,1)';
           v_lerxml += ', ' + IntToStr(val_genCte);
           v_lerxml += ', ' + QuotedStr(vPrest.Comp.Items[i].xNome);
           v_lerxml += ', '  + FloatToStr(vPrest.Comp.Items[i].vComp);
           v_lerxml += ')';
           FormatSettings.DecimalSeparator := ',';
           dmPdv.Ibcon.ExecuteDirect(v_lerxml);
         end;
       end;
       }
       // icms
       with imp.ICMS do
       begin
         dmCte.cdsCteVALPICMS.AsFloat := percent_icms; // ICMS00.pICMS;
         dmCte.cdsCteVALVBC.AsFloat := 0; //ICMS00.vBC;
         dmCte.cdsCteVALVICMS.AsFloat := 0; //ICMS00.vICMS;
       end;
       //combCodSitTrib.ItemIndex := CodSitTributario;
       // Documentacao carga
       with infCTeNorm.infCarga do
       begin

           dmPdv.Ibcon.ExecuteDirect('DELETE FROM CTE_QC' +
             ' WHERE COD_CTE = ' +  IntToStr(val_genCte));
           for i := 0 to infQ.Count  -1 do
           begin
             FormatSettings.DecimalSeparator := '.';
             v_lerxml := 'INSERT INTO CTE_QC (COD_CTE_QC, COD_CTE ,UNID, ' +
                   ' MEDIDA, QUANT) VALUES ( GEN_ID(GEN_CTE_QC_ID, 1)';
             v_lerxml += ', ' + IntToStr(val_genCte);
             //uM3,uKG, uTON, uUNIDADE, uLITROS, uMMBTU
             if (infQ.Items[i].cUnid = uM3) then
                v_xml2 := '00';
             if (infQ.Items[i].cUnid = uKG) then
                v_xml2 := '01';
             if (infQ.Items[i].cUnid = uTON) then
                v_xml2 := '02';
             if (infQ.Items[i].cUnid = uUNIDADE) then
                v_xml2 := '03';
             if (infQ.Items[i].cUnid = uLITROS) then
                v_xml2 := '04';
             if (infQ.Items[i].cUnid = uMMBTU) then
                v_xml2 := '05';
             v_lerxml += ', ' + QuotedStr(v_xml2);
             v_lerxml += ', ' + QuotedStr(infQ.Items[i].tpMed);
             v_lerxml += ', ' +  FloatToStr(infQ.Items[i].qCarga);
             v_lerxml += ')';
             pqCarga := (infQ.Items[i].qCarga);
             FormatSettings.DecimalSeparator := ',';
             dmPdv.Ibcon.ExecuteDirect(v_lerxml);





           dmCte.cdsCteVALINFCARGA.AsFloat := vCarga;
           if percentualFrete > 0 then
           begin
             //dmCte.cdsCteVPREST.AsFloat := (percentualFrete/100) * vCarga;
             //dmCte.cdsCteVREC.AsFloat := (percentualFrete/100) * vCarga;
             dmCte.cdsCteVPREST.AsFloat := (pvalordokilo) * (pqCarga);
             dmCte.cdsCteVREC.AsFloat := (pvalordokilo) * (pqCarga);

             if (componente_nome <> '') then
             begin
               FormatSettings.DecimalSeparator := '.';
               num_cod_comp := dmPdv.busca_generator('GEN_CTE_COMP_ID');
               vstr_sql := 'INSERT INTO CTE_COMP (COD_CTE_COMP, COD_CTE ,COMP_NOME, ' +
                 ' COMP_VALOR) VALUES ( ' + IntToStr(num_cod_comp);
               vstr_sql := vstr_sql + ', ' + IntToStr(val_genCte) ;
               vstr_sql := vstr_sql + ', ' + QuotedStr(componente_nome);
               //vstr_sql := vstr_sql + ', '  + FloatToStr((percentualFrete/100) * vCarga);
               vstr_sql := vstr_sql + ', '  + FloatToStr((pvalordokilo) * (pqCarga));
               vstr_sql := vstr_sql + ')';
               FormatSettings.DecimalSeparator := ',';
               dmPdv.Ibcon.ExecuteDirect(vstr_sql);
               //fCompValor.ShowModal;
               dmCte.sqComp.Close;
               dmCte.sqComp.Params[0].AsInteger := val_genCte;
               dmCte.sqComp.Open;
               componente_nome := dmCte.sqCompCOMP_NOME.AsString;
             end;
           end;
         edtProPred.Text := proPred;
         edtOutCat.Text := xOutCat;
         end;
       end;
       // NF-e
       with infCTeNorm.infDoc do
       begin
         dmPdv.Ibcon.ExecuteDirect('DELETE FROM CTE_NFE' +
           ' WHERE CTE_NFE = ' +  IntToStr(val_genCte));
         for i := 0 to infNFe.Count  -1 do
         begin
           v_lerxml := 'INSERT INTO CTE_NFE (COD_CTE_NFE, CTE_NFE, CHAVE ' +
                      ') VALUES ( GEN_ID(GEN_CTE_NFE_ID, 1)';
           v_lerxml += ', ' + IntToStr(val_genCte);
           v_lerxml += ', ' + QuotedStr(infNFe.Items[i].chave);
           v_lerxml += ')';
           dmPdv.Ibcon.ExecuteDirect(v_lerxml);
         end;
       end;
     end; // fim do xml
     edtEnvUF.Text := Trim(edtEmitUF.Text);
     edtEnvCidade.Text := Trim(edtEmitCidade.Text);
     edtEnvCodCidade.Text := Trim(edtEmitCodCidade.Text);
     edtFimUF.Text := Trim(edtDestUF.Text);
     edtFimCidade.Text := Trim(edtDestCidade.Text);
     edtFimCodCidade.Text := Trim(edtDestCodCidade.Text);
     edtIniUF.Text := edtRemUF.Text;
     edtIniCidade.Text := edtRemCidade.Text;
     edtIniCodCidade.Text := edtRemCodCidade.Text;

     //dmCte.sqComp.Close;
     //dmCte.sqNFe.Close;
     //dmCte.sqComp.Open;

     //dmCte.sqNFe.Open;
     btnGravarCTe.Click;
     btnEditarCte.Click;
   end; // fim do abrir xml
 end;
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

procedure TfCTePrincipal.StaticText22Click(Sender: TObject);
begin

end;

end.

