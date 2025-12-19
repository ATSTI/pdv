unit uNFe;

{$mode objfpc}{$H+}

interface

uses
  Windows, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, StdCtrls, DBGrids, Buttons, EditBtn, ACBrNFe, ACBrNFeDANFeRLClass,
  ACBrValidador, db, Spin, DBCtrls, uCertificadoLer, uInutilizar,Grids,
  ACBrUtil, ACBrMail, ACBrIntegrador, MaskUtils,  DOM, FileUtil, SynMemo, SynHighlighterXML,

  ACBrNFeDANFEClass, ACBrDANFCeFortesFr,ACBrDFeReport, ACBrDFeDANFeReport,
  ACBrBase, ACBrDFe, ACBrDANFCeFortesFrA4,

  Messages, Variants,  ShellAPI,   zlib;


type

  { TfNFe }

  TfNFe = class(TForm)
    ACBrIntegrador1: TACBrIntegrador;
    ACBrMail1: TACBrMail;
    ACBrNFe1: TACBrNFe;
    ACBrNFe2: TACBrNFe;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    ACBrValidador1: TACBrValidador;
    BitBtn1: TBitBtn;
    BitBtn8: TBitBtn;
    btnAbaPrincipal1: TBitBtn;
    BtnCCe1: TBitBtn;
    BtnEnvEmail: TBitBtn;
    btnGeraNFe1: TBitBtn;
    BtnCCe: TBitBtn;
    btnGeraPDF: TBitBtn;
    btnCancelaNFe: TBitBtn;
    btnGravArqNFEini: TButton;
    btnImprimirCCe: TBitBtn;
    btnImprimirCCe1: TBitBtn;
    btnListarCCe: TBitBtn;
    BtnPreVis: TBitBtn;
    btnListar: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    btnAbaPrincipal: TBitBtn;
    btnAlteraStatus: TBitBtn;
    btnConnDpec: TBitBtn;
    btnConsulta: TBitBtn;
    btnContingencia: TBitBtn;
    btnDpec: TBitBtn;
    btnFSDA: TBitBtn;
    btnInutilizar: TBitBtn;
    btnGeraNFe: TBitBtn;
    btnImprime: TBitBtn;
    BtnPreVis1: TBitBtn;
    btnPreVisCont: TBitBtn;
    btnPreVisDPEC: TBitBtn;
    btnPreVisFSDA: TBitBtn;
    btnPreVisSped: TBitBtn;
    btnSair: TBitBtn;
    btnSair1: TBitBtn;
    btnSPED: TBitBtn;
    btnStatus: TBitBtn;
    btnStatusMenMemo: TButton;
    btnStatusNaoEnviada: TBitBtn;
    btnSVCAN: TBitBtn;
    btnSvcanGera: TBitBtn;
    btnValidaNFe: TBitBtn;
    btnValidarRegrasNegocio: TButton;
    btnValidarXML: TButton;
    btnValidaXML: TBitBtn;
    Button3: TButton;
    Button4: TButton;
    cbCryptLib: TComboBox;
    cbHttpLib: TComboBox;
    cbSSLLib: TComboBox;
    cbTipoNota: TRadioGroup;
    cbXmlSignLib: TComboBox;
    cbSSLType: TComboBox;
    CCe: TTabSheet;
    Certificado: TTabSheet;
    CheckBox1: TCheckBox;
    chek1: TRadioButton;
    chek2: TRadioButton;
    chkScan: TCheckBox;
    chkTodas: TCheckBox;
    ckImpEAN: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    cbEmpresa: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    edDadosXml: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    edLocalEmbarque: TEdit;
    edNFCancelar: TEdit;
    edRecibo: TEdit;
    edSerie: TEdit;
    edtCaminho: TEdit;
    edtEmailCliente: TEdit;
    edtNumSerie: TEdit;
    edtNumSerie1: TEdit;
    edtNumSerie2: TEdit;
    edtChaveNfeCCe: TEdit;
    edtNumSerieABA: TEdit;
    edtPathSchemas: TEdit;
    edtPorta: TEdit;
    edtSenha: TEdit;
    edtSenhas: TEdit;
    edtSeuEmail: TEdit;
    edtSMTP: TEdit;
    edtSSL: TEdit;
    edtTLS: TEdit;
    edtUsername: TEdit;
    edUfEmbarque: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    FloatSpinEdit3: TFloatSpinEdit;
    FloatSpinEdit4: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    GroupBox16: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Image1: TImage;
    ImageList1: TImageList;
    ImageList2: TImageList;
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
    lblMsgSuframa: TLabel;
    lblVencimentoCert: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblMsgNfe: TLabel;
    lblSerieNfe: TLabel;
    lCryptLib: TLabel;
    lHttpLib: TLabel;
    lSSLLib: TLabel;
    lXmlSign: TLabel;
    cbSSLTypeLbl: TLabel;
    Memo1: TMemo;
    mDFe: TMemo;
    memoDados: TMemo;
    memoLog: TMemo;
    MemoResp: TMemo;
    memoRespWS: TMemo;
    NFe: TTabSheet;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    rgViaTransp: TRadioGroup;
    sbtnGetCert: TSpeedButton;
    sbtnGetCert1: TSpeedButton;
    sbtnGetCert2: TSpeedButton;
    sbtnGetCert3: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TestEmail: TButton;
    SynXMLSyn1: TSynXMLSyn;
    WBResposta: TSynMemo;
    procedure ACBrNFe1StatusChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure btnAbaPrincipalClick(Sender: TObject);
    procedure btnAlteraStatusClick(Sender: TObject);
    procedure BtnCCe1Click(Sender: TObject);
    procedure BtnCCeClick(Sender: TObject);
    procedure btnConnDpecClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure btnCancelaNFeClick(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure btnContingenciaClick(Sender: TObject);
    procedure btnDpecClick(Sender: TObject);
    procedure BtnEnvEmailClick(Sender: TObject);
    procedure btnFSDAClick(Sender: TObject);
    procedure btnGeraNFeClick(Sender: TObject);
    procedure btnGeraPDFClick(Sender: TObject);
    procedure btnGravArqNFEiniClick(Sender: TObject);
    procedure btnImprimeClick(Sender: TObject);
    procedure btnImprimirCCe1Click(Sender: TObject);
    procedure btnImprimirCCeClick(Sender: TObject);
    procedure btnInutilizarClick(Sender: TObject);
    procedure btnListarCCeClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure BtnPreVisClick(Sender: TObject);
    procedure btnPreVisContClick(Sender: TObject);
    procedure btnPreVisDPECClick(Sender: TObject);
    procedure btnPreVisFSDAClick(Sender: TObject);
    procedure btnPreVisSpedClick(Sender: TObject);
    procedure btnSair1Click(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnSPEDClick(Sender: TObject);
    procedure btnStatusClick(Sender: TObject);
    procedure btnStatusNaoEnviadaClick(Sender: TObject);
    procedure btnSVCANClick(Sender: TObject);
    procedure btnSvcanGeraClick(Sender: TObject);
    procedure btnValidaNFeClick(Sender: TObject);
    procedure btnValidarRegrasNegocioClick(Sender: TObject);
    procedure btnValidarXMLClick(Sender: TObject);
    procedure btnValidaXMLClick(Sender: TObject);
    procedure btnStatusMenMemoClick(Sender: TObject);

    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbEmpresaChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid2CellClick(Sender: TObject);
    procedure DBGrid2ColEnter(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FloatSpinEdit1Change(Sender: TObject);
    procedure FloatSpinEdit2Change(Sender: TObject);
    procedure FloatSpinEdit3Change(Sender: TObject);
    procedure FloatSpinEdit4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure nfe_carregalogo;
    procedure EnviaEmail;
    procedure EnviaEmailDireto;
    procedure PageControl2Change(Sender: TObject);
    procedure sbtnGetCert1Click(Sender: TObject);
    procedure sbtnGetCert3Click(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure TestEmailClick(Sender: TObject);
    procedure ACBrNFe1GerarLog(const Mensagem: String);
    procedure ACBrNFe1TransmitError(const HttpError, InternalError: Integer;
      const URL, DataSent, SoapAction: String; var TryAgain: Boolean);
  private
    codcliEmail : integer;
    micro : string;
    diretorio : string;
    envemail : string;
    tpNFe : integer;
    infCplTrib: string;
    cstSuframa : string; // 11/10/19 agroselect
    pSuframa : string; // 25/02/19
    ufDest: String;
    numnf : WideString;
    tot1: double;
    tot2: double;
    tot3: double;
    tot4: double;
    totIPIDevol: double;
    cst_utilizado: String;
    c_custo_open: String;
    nota_selec: String;
    forma_pag: String;
    resul : String;
    function validaNumNfeScan():Boolean;
    function GerarNFe: Boolean;
    procedure getPagamento;
    procedure pegaItens(tpNf: integer);
    procedure pegaTributos(codMov: Integer;codProd: Integer);
    procedure getEmpresa;
    procedure abrirEmpresa;
    procedure getCli_Fornec;
    procedure getItens(contador : integer);
    procedure getTransportadora;
    procedure LerConfiguracao ;
    procedure AtualizaSSLLibsCombo;
    procedure GravarConfiguracao;
    procedure CarregarXML(ChaveNFCe: String);
    procedure gravaRetornoEnvio(Protocolo: String; Recibo: String);
    procedure gravaRetornoCancelada(Protocolo: String);
    procedure carregaTudo;
    procedure abrindoSistema;
    //procedure LoadXML(MyMemo: TMemo; MyWebBrowser: TSynMemo);
  public
    danfe_larg_codprod: integer;
    imprimeDetalhamentoEspecifico: Boolean;
    quebraLinhaDanfe: Boolean;
    nfe_serie_receita : Integer;
    danfeDec : integer;
    situacaoCaixa, vTipoFiscal, varlogado ,email_tls,email_ssl : string;
    Computer: PChar;
    diretorio_schema : String;
    numCertificado : String;
    mascaraProduto : String;
    valida, codFisc , pCNPJ_CPF: String;
    tipoNota: Char;
    codnf: integer;
    Protocolo, Recibo, str, vAux : String;
    pIBS : double;
    pCBS : double;
    pReducao : double;
    pA : double;
    total_ibs : double;
    total_cbs : double;
    total_nota : double;
    baseIBS_CBS : double;
    pIBS_CBS : string;
    pCASTRIB : string;
    vpCBS  : double;
    vpIBS  : double;
    function GetVersion :  string;

  end;

var
  fNFe: TfNFe;
  conta_local: string;
  tp_amb : integer;
implementation

uses udmpdv , ufrmStatus,
StrUtils, math, TypInfo, DateUtils, synacode, blcksock, FileCtrl,
IniFiles, Printers,
pcnAuxiliar, ACBrNFe.Classes, pcnConversao, pcnConversaoNFe, pcnNFeRTXT, pcnRetConsReciDFe,
ACBrDFeConfiguracoes, ACBrDFeSSL, ACBrDFeOpenSSL, ACBrDFeUtil,
ACBrNFeNotasFiscais, ACBrNFeConfiguracoes,ACBrDFe.Conversao,
                                                               // Grids,


ACBrUtil.Base, ACBrUtil.FilesIO, ACBrUtil.DateTime, ACBrUtil.Strings,
ACBrUtil.XMLHTML;

const
  libName: String = 'fbclient.dll';

function GetComputerNameFunc : string;
var ipbuffer : string;
      nsize : dword;
begin
   nsize := 255;
   SetLength(ipbuffer,nsize);
   if GetComputerName(pchar(ipbuffer),nsize) then
      result := ipbuffer;
end;

Function RemoveChar(Const Texto:String):String;
// Remove caracteres de uma string deixando apenas numeros
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

{$R *.lfm}

{ TfNFe }

procedure TfNFe.btnListarClick(Sender: TObject);
var str_nf, str_proc, ver_str: string;
begin
  nota_selec := '';
  str_proc := '';
  dmPdv.IbCon.ExecuteDirect('ALTER TRIGGER PROIBE_ALT_DEL_NF INACTIVE');
  dmPdv.sTrans.Commit;
  dmPdv.executaSql('UPDATE NOTAFISCAL SET SELECIONOU = Null WHERE SELECIONOU = ' +
    QuotedStr('S'));
  dmPdv.IbCon.ExecuteDirect('ALTER TRIGGER PROIBE_ALT_DEL_NF ACTIVE');

  if(not dmPdv.qcds_ccusto.Active) then
    dmPdv.qcds_ccusto.Open;

  if (dmPdv.qcdsNF.Active) then
    dmPdv.qcdsNF.Close;
  if (cbTipoNota.ItemIndex = 0) then
  begin
    str_nf := 'select  nf.CFOP, nf.DTAEMISSAO, nf.DTASAIDA, nf.IDCOMPLEMENTAR, ' +
    ' nf.CORPONF1, nf.CORPONF2, nf.CORPONF3, nf.CORPONF4, nf.CORPONF5, nf.CORPONF6, ' +
    ' nf.XMLNFE, nf.CODCLIENTE, nf.NUMNF, nf.CODVENDA, nf.fatura, nf.natureza, ' +
    'UDF_ROUNDDEC(nf.BASE_ICMS, 2) as BASE_ICMS, ' +
    'UDF_ROUNDDEC(nf.VALOR_ICMS, 2) as VALOR_ICMS, ' +
    'UDF_ROUNDDEC(nf.BASE_ICMS_SUBST, 2) as BASE_ICMS_SUBST, ' +
    'UDF_ROUNDDEC(nf.VALOR_ICMS_SUBST, 2) as VALOR_ICMS_SUBST, ' +
    'UDF_ROUNDDEC(nf.VALOR_PRODUTO, 2) as VALOR_PRODUTO, nf.VALOR_FRETE, ' +
    'nf.VALOR_SEGURO, nf.OUTRAS_DESP, nf.VALOR_IPI,' +
    'UDF_ROUNDDEC(nf.VALOR_TOTAL_NOTA, 2) as VALOR_TOTAL_NOTA,  nf.FRETE,  ' +
    'nf.CNPJ_CPF,  udf_left(nf.NOMETRANSP, 60)as NOMETRANSP,  nf.INSCRICAOESTADUAL,' +
    'udf_left(nf.END_TRANSP,60)as END_TRANSP, '+
    'udf_left(nf.CIDADE_TRANSP, 60) as CIDADE_TRANSP, nf.UF_TRANSP, ' +
    'UDF_ROUNDDEC(nf.II, 2) as II, UDF_ROUNDDEC(nf.BCII, 2) as BCII, '+
    'nf.PLACATRANSP, nf.UF_VEICULO_TRANSP, nf.CODTRANSP, nf.QUANTIDADE,  ' +
    'nf.ESPECIE,  nf.MARCA, nf.NUMERO, nf.PESOLIQUIDO, nf.VALOR_DESCONTO, ' +
    'nf.PESOBRUTO, f.RAZAOSOCIAL, f.CNPJ , nf.HORASAIDA,  nf.NOTASERIE, ' +
    'nf.SELECIONOU, nf.REDUZICMS, nf.PROTOCOLOENV, ' +
    'nf.NUMRECIBO, nf.PROTOCOLOCANC, c.ENTRADA, c.VALOR_PAGAR, VALOR_PIS, VALOR_COFINS, ' +
    'nf.NOMETRANSP TRANSP2, nf.BASE_IPI, nf.BASE_PIS, nf.BASE_COFINS, ' +
    'UDF_ROUNDDEC(nf.VLRTOT_TRIB, 2) as VLRTOT_TRIB, nf.STATUS, nf.NOMEXML  ' +
    ', NFE_FINNFE, NFE_MODELO, NFE_VERSAO, NFE_DESTOPERACAO, NFE_FORMATODANFE,'+
    ' NFE_TIPOEMISSAO, NFE_INDFINAL, INTERM_CNPJ, INTERM_PERFIL ' +
    ', NFE_INDPRES ' +
    ', IND_IEDEST , NF.CCUSTO ' +
    ', nf.V_B_FCPUFDEST ' +
    ', nf.V_FCP ' +
    ', nf.V_FCPST ' +
    ', nf.V_FCPSTRET ' +
    ', nf.V_IPI_DEVOL ' +
    '  from NOTAFISCAL nf ' +
    ' inner join FORNECEDOR f on f.CODFORNECEDOR = nf.CODCLIENTE ' +
    ' inner join enderecoFORNECEDOR endeforn on endeforn.CODFORNECEDOR = f.CODFORNECEDOR ' +
    '  left outer join COMPRA c on c.CODCOMPRA = nf.CODVENDA ';
    str_nf := str_nf + ' where (nf.DTAEMISSAO between ' +
    QuotedStr(formatdatetime('mm/dd/yy', DateEdit1.Date)) +
    ' and ' + QuotedStr(formatdatetime('mm/dd/yy', DateEdit2.Date)) +') ';
    if (edSerie.Text <> '') then
      str_nf := str_nf + ' and (nf.SERIE = ' + QuotedStr(edSerie.text) + ')';
    str_nf := str_nf + ' and (endeforn.TIPOEND = 0) ';
    str_nf := str_nf + ' and ((NF.NATUREZA = 20) or (NF.NATUREZA = 21))';
    if (chkTodas.Checked = False) then
    begin
      str_proc := str_proc + ' and (nf.PROTOCOLOENV IS NULL)';
      str_proc := str_proc + ' and (nf.STATUS IS NULL)';
      //or (nf.STATUS = ' + QuotedStr('E') + ')) ';
    end;
    if (ComboBox1.Text <> '') then
    begin
      ver_str := ComboBox1.Text;
      dmPdv.qcds_ccusto.Close;
      dmPdv.qcds_ccusto.SQL.Clear;
      dmPdv.qcds_ccusto.SQL.Add('select CODIGO, CONTA, NOME from PLANO where plnCtaRoot(CONTA) = ' +
        QuotedStr(conta_local) + ' AND CONSOLIDA = ' + QuotedStr('S') + ' AND NOME = '+
        QuotedStr(ComboBox1.Text));
      dmPdv.qcds_ccusto.Open;
      str_nf := str_nf + ' and (nf.CCUSTO = ' + IntToStr(dmPdv.qcds_ccustoCODIGO.AsInteger) + ')';
      dmPdv.qcds_ccusto.Close;
      dmPdv.qcds_ccusto.SQL.Clear;
      dmPdv.qcds_ccusto.SQL.Add('select CODIGO, CONTA, NOME from PLANO where plnCtaRoot(CONTA) = ' +
        QuotedStr(conta_local) + ' AND CONSOLIDA = ' + QuotedStr('S'));
      dmPdv.qcds_ccusto.Open;
    end;
  end
  else
  begin
    str_nf := 'select  nf.CFOP, nf.DTAEMISSAO, nf.DTASAIDA, nf.CODTRANSP, ' +
    'nf.IDCOMPLEMENTAR,  nf.CORPONF1, nf.CORPONF2, nf.CORPONF3, nf.CORPONF4, '+
    'nf.CORPONF5, nf.CORPONF6, nf.XMLNFE, nf.CODCLIENTE, nf.NUMNF, ' +
    'nf.CODVENDA, nf.fatura, nf.natureza, UDF_ROUNDDEC(nf.BASE_ICMS, 2) as BASE_ICMS, ' +
    'UDF_ROUNDDEC(nf.VALOR_ICMS, 2) as VALOR_ICMS, ' +
    'UDF_ROUNDDEC(nf.BASE_ICMS_SUBST, 2) as BASE_ICMS_SUBST, ' +
    'UDF_ROUNDDEC(nf.VALOR_ICMS_SUBST, 2) as VALOR_ICMS_SUBST, ' +
    'UDF_ROUNDDEC(nf.II, 2) as II, UDF_ROUNDDEC(nf.BCII, 2) as BCII, ' +
    'UDF_ROUNDDEC(nf.VALOR_PRODUTO, 2) as VALOR_PRODUTO, nf.VALOR_FRETE, ' +
    'nf.VALOR_SEGURO, nf.OUTRAS_DESP, nf.VALOR_IPI,' +
    'UDF_ROUNDDEC(nf.VALOR_TOTAL_NOTA, 2) as VALOR_TOTAL_NOTA,  nf.FRETE, ' +
    'nf.CNPJ_CPF,  udf_left(nf.NOMETRANSP, 60)as NOMETRANSP,  '+
    'nf.INSCRICAOESTADUAL, udf_left(nf.END_TRANSP, 60)as END_TRANSP, ' +
    'udf_left(nf.CIDADE_TRANSP, 60)as CIDADE_TRANSP, ' +
    'nf.UF_TRANSP, nf.PLACATRANSP, nf.UF_VEICULO_TRANSP, nf.QUANTIDADE, ' +
    'nf.ESPECIE,  nf.MARCA, nf.NUMERO, nf.PESOLIQUIDO, nf.VALOR_DESCONTO, ' +
    'nf.PESOBRUTO, nf.HORASAIDA,  nf.NOTASERIE, nf.SELECIONOU, nf.REDUZICMS, ' +
    ' nf.PROTOCOLOENV, nf.NOMETRANSP TRANSP2, nf.NUMRECIBO, nf.PROTOCOLOCANC, ' +
    ' co.ENTRADA, co.VALOR_PAGAR, c.RAZAOSOCIAL, c.CNPJ, VALOR_PIS, VALOR_COFINS '+
    ', nf.BASE_IPI, nf.BASE_PIS, nf.BASE_COFINS, UDF_ROUNDDEC(nf.VLRTOT_TRIB, 2) ' +
    ' as VLRTOT_TRIB, nf.STATUS, nf.NOMEXML, IND_IEDEST  ' +
    ' , NFE_FINNFE, NFE_MODELO, NFE_VERSAO, NFE_DESTOPERACAO, NFE_FORMATODANFE,' +
    ' NFE_TIPOEMISSAO, NFE_INDFINAL, NFE_INDPRES , NF.CCUSTO ' +
    ', nf.V_B_FCPUFDEST ' +
    ', nf.V_FCP ' +
    ', nf.V_FCPST ' +
    ', nf.V_FCPSTRET ' +
    ', nf.V_IPI_DEVOL , INTERM_CNPJ, INTERM_PERFIL ' +
    '  from NOTAFISCAL nf ' +
    ' inner join CLIENTES c on c.CODCLIENTE = nf.CODCLIENTE ' +
    ' left outer join ENDERECOCLIENTE ec on ec.CODCLIENTE = c.CODCLIENTE '+
    ' left outer join VENDA co on co.CODVENDA = nf.CODVENDA  ';
    str_nf := str_nf + ' where (nf.DTAEMISSAO between ' +
      QuotedStr(formatdatetime('mm/dd/yy', DateEdit1.Date)) +
      ' and ' + QuotedStr(formatdatetime('mm/dd/yy', DateEdit2.Date)) +') ';
    if (edSerie.Text <> '') then
      str_nf := str_nf + ' and (nf.SERIE = ' + QuotedStr(edSerie.text) + ')';
    str_nf := str_nf + ' and ((ec.TIPOEND = 0) or (ec.TIPOEND IS NULL)) ';
    str_nf := str_nf + ' and ((NF.NATUREZA = 15) or (NF.NATUREZA = 12) or (NF.NATUREZA = 16))';
    if (chkTodas.Checked = False) then
    begin
      str_proc := str_proc + ' and (nf.PROTOCOLOENV IS NULL)';
      str_proc := str_proc + ' and (nf.STATUS IS NULL) ';
      //  ' or (nf.STATUS = ' + QuotedStr('E') + ') or (nf.STATUS = ' + QuotedStr('I') + ')) ';
    end;
    if (ComboBox1.Text <> '') then
    begin
      dmPdv.qcds_ccusto.Close;
      dmPdv.qcds_ccusto.SQL.Clear;
      dmPdv.qcds_ccusto.SQL.Add('select CODIGO, CONTA, NOME from PLANO where plnCtaRoot(CONTA) = ' +
        QuotedStr(conta_local) + ' AND CONSOLIDA = ' + QuotedStr('S') + ' AND NOME = '+
        QuotedStr(ComboBox1.Text));
      dmPdv.qcds_ccusto.Open;
      //ver_str := ComboBox1.Text;
      //dmPdv.qcds_ccusto.Locate('NOME', ComboBox1.Text,[loCaseInsensitive]);
      str_nf := str_nf + ' and (nf.CCUSTO = ' + IntToStr(dmPdv.qcds_ccustoCODIGO.AsInteger) + ')';
      dmPdv.qcds_ccusto.Close;
      dmPdv.qcds_ccusto.SQL.Clear;
      dmPdv.qcds_ccusto.SQL.Add('select CODIGO, CONTA, NOME from PLANO where plnCtaRoot(CONTA) = ' +
        QuotedStr(conta_local) + ' AND CONSOLIDA = ' + QuotedStr('S'));
      dmPdv.qcds_ccusto.Open;
    end;
  end;
  if (edtChaveNfeCCe.Text <> '') then
  begin
    str_nf := str_nf + 'AND nf.NOMEXML = ' + QuotedStr(edtChaveNfeCCe.Text +
      '-NFe.xml');
  end;
  str_nf := str_nf + str_proc + ' order by nf.NOTASERIE DESC';
  dmPdv.qcdsNF.SQL.Text := str_nf;
  dmPdv.qcdsNF.Open;

  //Seleciona Empresa de acordo com o CCusto selecionado
  if (dmPdv.qsEmpresa.Active) then
    dmPdv.qsEmpresa.Close;
  dmPdv.qsEmpresa.Params[0].AsInteger := dmPdv.qcdsNF.FieldByname('CCUSTO').AsInteger;
  dmPdv.qsEmpresa.Open;

  fNFe.Caption := dmPdv.qsEmpresaEMPRESA.AsString;

  //dmPdv.busca_sql('SELECT * FROM PARAMETRO WHERE PARAMETRO = ' +
 //  QuotedStr('CENTRORECEITA');
 // if (dmPdv.sqBusca.ParamByName('DADOS').AsString = '51') then
 {
  if (dmPdv.qsMenorData.Active) then
    dmPdv.qsMenorData.Close;
  dmPdv.qsMenorData.Params[0].AsDate := StrToDate(DateEdit1.Text);
  dmPdv.qsMenorData.Params[1].AsDate := StrToDate(DateEdit2.Text);
  dmPdv.qsMenorData.Params[2].Clear;

  if (edSerie.Text <> '') then
    dmPdv.qsMenorData.Params[2].AsString := edSerie.Text
  else
    dmPdv.qsMenorData.Params[2].AsString := 'todasasseriesdenotaf';
  dmPdv.qsMenorData.Open;

  if (dmPdv.qsMaiorData.Active) then
    dmPdv.qsMaiorData.Close;
  dmPdv.qsMaiorData.Params[0].AsDate := StrToDate(DateEdit1.Text);
  dmPdv.qsMaiorData.Params[1].AsDate := StrToDate(DateEdit2.Text);
  dmPdv.qsMaiorData.Params[2].Clear;
  if (edSerie.Text <> '') then
    dmPdv.qsMaiorData.Params[2].AsString := edSerie.Text
  else
    dmPdv.qsMaiorData.Params[2].AsString := 'todasasseriesdenotaf';
  dmPdv.qsMaiorData.Open;
  }

  if (not dmPdv.qcdsNF.Eof) then
  begin
    btnGeraNFe.Enabled :=      True;
    btnContingencia.Enabled := True;
    btnSPED.Enabled :=         True;
    btnDpec.Enabled :=         True;
    btnFSDA.Enabled :=         True;
    BtnPreVis.Enabled :=       True;
    btnPreVisCont.Enabled :=   True;
    btnPreVisSped.Enabled :=   True;
    btnPreVisDPEC.Enabled :=   True;
    btnPreVisFSDA.Enabled :=   True;
  end
  else
  begin
    btnGeraNFe.Enabled :=      False;
    btnContingencia.Enabled := False;
    btnSPED.Enabled :=         False;
    btnDpec.Enabled :=         False;
    btnFSDA.Enabled :=         False;
    BtnPreVis.Enabled :=       False;
    btnPreVisCont.Enabled :=   False;
    btnPreVisSped.Enabled :=   False;
    btnPreVisDPEC.Enabled :=   False;
    btnPreVisFSDA.Enabled :=   False;
   end;

end;

procedure TfNFe.btnImprimeClick(Sender: TObject);
var num_ln: integer;
begin
  Protocolo := '';
  abrirEmpresa;
  memoLog.Lines.Append('Abriu a Empresa');
  ACBrNFe1.Configuracoes.WebServices.UF := Trim(dmPdv.qsEmpresaUF.AsString);
  dmPdv.qcdsNF.DisableControls;
  num_ln := dmPdv.qcdsNF.RecNo;
  dmPdv.qcdsNF.First;
  while not dmPdv.qcdsNF.Eof do
  begin
    if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = 'S') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
    begin
      memoLog.Lines.Append('Carregando logo');
      nfe_carregalogo;
      num_ln := dmPdv.qcdsNF.RecNo;
      codnf := dmPdv.qcdsNFNUMNF.AsInteger;
      memoLog.Lines.Append('Limpa ACBR 1');
      ACBrNFe1.NotasFiscais.Clear;
      if (dmPdv.qcdsNFNOMEXML.AsString <> '') then
      begin
          memoLog.Lines.Append('Carrega com chave');
          CarregarXML(Copy(Trim(dmPdv.qcdsNFNOMEXML.AsString),0,44));
      end
      else begin
          memoLog.Lines.Append('Sem com chave');
          CarregarXML('');
      end;
      if (ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF <> StrToInt(Trim(dmPdv.qcdsNFNOTASERIE.AsString))) then
      begin
        ShowMessage('Nota Selecionada diferente do Xml');
        Exit;
      end;
      ACBrNFe1.Consultar;
      if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
      begin

      end
      else begin
        Protocolo := ACBrNFe1.WebServices.Consulta.protNFe.nProt;
      end;

      if(chek1.Checked = True)then
        ACBrNFeDANFeRL1.TipoDANFE := tiRetrato
      else ACBrNFeDANFeRL1.TipoDANFE := tiPaisagem  ;

      ACBrNFe1.NotasFiscais.Imprimir;
      if (AcbrNfe1.WebServices.Consulta.Protocolo <> '') then
        ACBrNFe1.NotasFiscais.Items[0].GravarXML;
    end;
    dmPdv.qcdsNf.Next;
  end;
  if (Protocolo <> '') then
  begin
    if ((dmPdv.qcdsNFPROTOCOLOENV.IsNull) and (trim(dmPdv.qcdsNFPROTOCOLOENV.AsString) = '')) then
      gravaRetornoEnvio(Protocolo, '');
    Protocolo := '';
    Protocolo := ACBrNFe1.WebServices.Consulta.retCancNFe.nProt;
    if ( Protocolo <> '' ) then
    begin
      gravaRetornoCancelada(Protocolo);
    end;
  end;
  dmPdv.qcdsNF.RecNo := num_ln;
  dmPdv.qcdsNF.EnableControls;
end;

procedure TfNFe.btnImprimirCCe1Click(Sender: TObject);
begin
  btnImprimirCCe.Click;
end;

procedure TfNFe.btnImprimirCCeClick(Sender: TObject);
  var path_eve: String;
    xCond : String;
    nome_evento: String;
begin
  dmPdv.qcds_ccusto.Close;
  dmPdv.qcds_ccusto.SQL.Clear;
  dmPdv.qcds_ccusto.SQL.Add('select CODIGO, CONTA, NOME from PLANO where plnCtaRoot(CONTA) = ' +
    QuotedStr(conta_local) + ' AND CONSOLIDA = ' + QuotedStr('S') + ' AND NOME = '+
    QuotedStr(ComboBox2.Text));
  dmPdv.qcds_ccusto.Open;

  //dmPdv.qcds_ccusto.Locate('NOME', ComboBox2.Text,[loCaseInsensitive]);

  //Seleciona Empresa de acordo com o CCusto selecionado
  if (dmPdv.qsEmpresa.Active) then
   dmPdv.qsEmpresa.Close;
  dmPdv.qsEmpresa.Params[0].AsInteger := dmPdv.qcds_ccustoCODIGO.AsInteger;
  dmPdv.qsEmpresa.Open;

  ACBrNFe1.Configuracoes.WebServices.UF := Trim(dmPdv.qsEmpresaUF.AsString);
  ACBrNFe1.Configuracoes.Arquivos.PathSchemas := diretorio_schema;
  AcbrNfe1.Configuracoes.Arquivos.PathEvento := edit3.Text + '\Eventos';
  path_eve := FormatDateTime('yyyymm', NOW);
  dmPdv.qsCCE.First;
  while not dmPdv.qsCCE.Eof do
  begin
    if (trim(dmPdv.qsCCESELECIONOU.AsString) = 'S') then
    begin
      // carregando o xml da nota
      memoLog.Lines.Add('Carregando XML da NOTA');
      nfe_carregalogo;
      CarregarXML(Copy(Trim(dmPdv.qsCCECHAVE.AsString),0,44));
      // carregando o xml do Evento
      path_eve := AcbrNfe1.Configuracoes.Arquivos.PathEvento + '\' + path_eve +
         '\110110' + Trim(dmPdv.qsCCECHAVE.AsString) + '0' + IntToStr(dmPdv.qsCCESEQUENCIA.AsInteger) +
         '-procEventoNFe.XML';
      memoLog.Lines.Add('Carregando XML do EVENTO');
      memoLog.Lines.Add(path_eve);
      if (not FilesExists(path_eve)) then
      begin
        OpenDialog1.Title := 'Selecione o Evento';
        OpenDialog1.DefaultExt := '*-procEventoNFe.XML';
        OpenDialog1.Filter := 'Arquivos CCe (*-procEventoNFe.XML)|*-procEventoNFe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
        OpenDialog1.InitialDir := AcbrNfe1.Configuracoes.Arquivos.PathEvento;
        if OpenDialog1.Execute then
        begin
          path_eve := OpenDialog1.FileName;
        end;
      end;
      ACBrNFe1.EventoNFe.LerXML(path_eve);
    end;
      dmPdv.qsCCE.Next;
    end;


    ACBrNFe1.ImprimirEvento;
end;

procedure TfNFe.btnInutilizarClick(Sender: TObject);
var str_sql: String;
  i : Integer;
begin
  fInutlizar.ShowModal;
  abrirEmpresa;
  if (edtNumSerie.Text = '') then
  begin
    MessageDlg('Selecione o Certificado!',mtWarning,[mbOk],0);
  end;

  ACBrNFe1.NotasFiscais.Clear;
  str_sql := Trim(dmPdv.qsEmpresaUF.AsString);
  ACBrNFe1.Configuracoes.WebServices.UF := str_sql;

  if (fInutlizar.inu_justificativa = '') then
  begin
    ShowMessage('Inutilização Cancelada.');
    Exit;
  end;
  str_sql := Trim(dmPdv.qsEmpresaCNPJ_CPF.AsString);
  ACBrNFe1.WebServices.Inutiliza(str_sql,
    fInutlizar.inu_justificativa,
    StrToInt(fInutlizar.inu_ano),
    StrToInt(fInutlizar.inu_modelo),
    StrToInt(fInutlizar.inu_serie),
    StrToInt(fInutlizar.inu_ini),
    StrToInt(fInutlizar.inu_fim));
  memoLog.Lines.Text :=  ACBrNFe1.WebServices.Inutilizacao.RetWS;
  memoLog.Lines.Text :=  ACBrNFe1.WebServices.Inutilizacao.RetornoWS;

  memoLog.Lines.Add('');
  memoLog.Lines.Add('Inutilização');
  memoLog.Lines.Add('tpAmb: '    +TpAmbToStr(ACBrNFe1.WebServices.Inutilizacao.tpAmb));
  memoLog.Lines.Add('verAplic: ' +ACBrNFe1.WebServices.Inutilizacao.verAplic);
  memoLog.Lines.Add('cStat: '    +IntToStr(ACBrNFe1.WebServices.Inutilizacao.cStat));
  memoLog.Lines.Add('xMotivo: '  +ACBrNFe1.WebServices.Inutilizacao.xMotivo);
  memoLog.Lines.Add('cUF: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.cUF));
  memoLog.Lines.Add('Ano: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.Ano));
  memoLog.Lines.Add('CNPJ: '      +ACBrNFe1.WebServices.Inutilizacao.CNPJ);
  memoLog.Lines.Add('Modelo: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.Modelo));
  memoLog.Lines.Add('Serie: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.Serie));
  memoLog.Lines.Add('NumeroInicial: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.NumeroInicial));
  memoLog.Lines.Add('NumeroInicial: '      +IntToStr(ACBrNFe1.WebServices.Inutilizacao.NumeroFinal));
  memoLog.Lines.Add('dhRecbto: ' +DateTimeToStr(ACBrNFe1.WebServices.Inutilizacao.dhRecbto));
  memoLog.Lines.Add('Protocolo: '      +ACBrNFe1.WebServices.Inutilizacao.Protocolo);
  for i := strtoInt(fInutlizar.inu_ini) to StrToInt(fInutlizar.inu_fim) do
  begin
    dmPdv.busca_sql('select GEN_ID(GEN_NF, 1) as GENID from RDB$DATABASE');
    str_sql := 'INSERT INTO NOTAFISCAL (NOTASERIE, NUMNF, NOTAFISCAL , SERIE, ' +
       'STATUS, DATA_SISTEMA, DTAEMISSAO, CORPONF1, CORPONF2, PROTOCOLOENV, NFE_FINNFE, ' +
       ' NATUREZA, CODCLIENTE, CFOP, CCUSTO) VALUES( ';
    str_sql := str_sql + QuotedStr(IntToStr(i)) + ', ';
    str_sql := str_sql + IntToStr(dmPdv.sqBusca.FieldByName('GENID').AsInteger) + ', ';
    str_sql := str_sql + IntToStr(i) + ', ';
    str_sql := str_sql + QuotedStr(fInutlizar.inu_serie) + ', ';
    str_sql := str_sql + QuotedStr('I') + ', ';
    str_sql := str_sql + QuotedStr(formatdatetime('mm/dd/yyyy', Now)) + ', ';
    str_sql := str_sql + QuotedStr(formatdatetime('mm/dd/yyyy', Now)) + ', ';
    str_sql := str_sql + QuotedStr('Usuário : ' + dmPdv.varLogado) + ', ';
    str_sql := str_sql + QuotedStr('Justificativa : ' + fInutlizar.inu_justificativa) + ', ';
    str_sql := str_sql + QuotedStr(ACBrNFe1.WebServices.Inutilizacao.Protocolo) + ', ';
    str_sql := str_sql + QuotedStr('fnInutilizado') + ', ';
    str_sql := str_sql + '12, 0,';  // Natureza , codcliente
    str_sql := str_sql + QuotedStr('INUTILIZADA') + ', ';
    dmPdv.qcds_ccusto.Close;
    dmPdv.qcds_ccusto.SQL.Clear;
    dmPdv.qcds_ccusto.SQL.Add('select CODIGO, CONTA, NOME from PLANO where plnCtaRoot(CONTA) = ' +
      QuotedStr(conta_local) + ' AND CONSOLIDA = ' + QuotedStr('S') + ' AND NOME = '+
      QuotedStr(ComboBox1.Text));
    dmPdv.qcds_ccusto.Open;
    //dmPdv.qcds_ccusto.Locate('NOME', ComboBox1.Text,[loCaseInsensitive]);
    str_sql := str_sql + IntToStr(dmPdv.qcds_ccustoCODIGO.AsInteger) + ')';
    dmPdv.executaSql(str_sql);
  end;
  dmPdv.strans.Commit;
  ShowMessage('Inutilização efetuada com sucesso, Protocolo : ' +
    ACBrNFe1.WebServices.Inutilizacao.Protocolo);
end;

procedure TfNFe.btnListarCCeClick(Sender: TObject);
  var str_cce   :string;
begin
  if (dmPdv.qsCCE.Active) then
    dmPdv.qsCCE.Close;
  dmPdv.qsCCE.SQL.Clear;
  //dmPdv.IbCon.ExecuteDirect('UPDATE CCE SET SELECIONOU = NULL '  +
  //  ' WHERE SELECIONOU = ' + QuotedStr('S'));
  //edtChaveNfeCCe.Text := '';
  //dmPdv.sTrans.Commit;

  if (CheckBox1.Checked) then
  begin
    str_cce := 'select * FROM CCE order by DHENVIO desc ';
    dmPdv.qsCCE.SQL.Text := str_cce;
  end
  else
  begin
    str_cce := 'select * FROM CCE WHERE PROTOCOLO IS NULL';
    dmPdv.qsCCE.SQL.Text := str_cce;
  end;
  if (edtChaveNfeCCe.Text <> '') then
  begin
    str_cce := 'select * FROM CCE WHERE CHAVE = ' +
      QuotedStr(edtChaveNfeCCe.Text);
    dmPdv.qsCCE.SQL.Text := str_cce;
  end;
  dmPdv.qsCCE.Open;

  BtnCCe.Enabled := True;
  btnImprimirCCe.Enabled := True;
end;

procedure TfNFe.btnGeraPDFClick(Sender: TObject);
var strAtualizaNota, nProtCanc: String;
arquivx: String;
begin
  abrirEmpresa;
  ACBrNFe1.Configuracoes.WebServices.UF := Trim(dmPdv.qsEmpresaUF.AsString);
  dmPdv.qcdsNF.First;
  while not dmPdv.qcdsNF.Eof do
  begin
    if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = 'S') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
    begin
      nfe_carregalogo;
      ACBrNFe1.NotasFiscais.Clear;
      CarregarXML(Copy(Trim(dmPdv.qcdsNFNOMEXML.AsString),0,44));
      if(chek1.Checked = True)then
        ACBrNFeDANFeRL1.TipoDANFE := tiRetrato
      else ACBrNFeDANFeRL1.TipoDANFE := tiPaisagem  ;
      ACBrNFe1.NotasFiscais.ImprimirPDF;
    end;
    dmPdv.qcdsNf.Next;
  end;

end;

procedure TfNFe.btnGravArqNFEiniClick(Sender: TObject);
begin
   if(edtNumSerie.Text = '') then
   begin
     MessageDlg('Certificado Não Selecionado', mtError, [mbOK], 0);
     exit;
   end;
   GravarConfiguracao;
end;

procedure TfNFe.BitBtn9Click(Sender: TObject);
begin
  Close;
end;

procedure TfNFe.btnCancelaNFeClick(Sender: TObject);
var
  caminho : String;
  NumeroLote : Integer;
  notaFCancela: String;
begin
  abrirEmpresa;

  ACBrNFe1.NotasFiscais.Clear;
  ACBrNFe1.Configuracoes.WebServices.UF := Trim(dmPdv.qsEmpresaUF.AsString);

  Protocolo := '';
  if (edNFCancelar.Text = '') then
  begin
    MessageDlg('Informe o número da nota a ser Cancelada.', mtWarning, [mbOK], 0);
    exit;
  end;

  dmPdv.qcdsNF.First;
  while not dmPdv.qcdsNF.Eof do
  begin
    if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = 'S') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
    begin
      notaFCancela := Trim(dmPdv.qcdsNFNOTASERIE.AsString);
      codnf := dmPdv.qcdsNFNUMNF.AsInteger;

      if (edNFCancelar.Text <> notaFCancela) then
      begin
        MessageDlg('Nota selecionada é diferente do número da Nota informada.', mtWarning, [mbOK], 0);
        exit;
      end;
      CarregarXML(Copy(Trim(dmPdv.qcdsNFNOMEXML.AsString),0,44));

      if not(InputQuery('WebServices Cancelamento', 'Justificativa (mais que 15 letras)', vAux)) then
         exit;
      if (Length(vAux) < 15) then
      begin
        MessageDlg('Justificativa deve ter no mínimo 15 caracteres.', mtWarning, [mbOK], 0);
        exit;
      end;
      NumeroLote := StrToInt(FormatDateTime('mmddhhmm', NOW));
      ACBrNFe1.EventoNFe.Evento.Clear;
      ACBrNFe1.EventoNFe.idLote := NumeroLote;
      with ACBrNFe1.EventoNFe.Evento.Add do
      begin
        InfEvento.tpAmb := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpAmb;
        infEvento.CNPJ := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
        InfEvento.cOrgao := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cUF;
        InfEvento.nSeqEvento := 1;
        InfEvento.chNFe := Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, 44);
        InfEvento.dhEvento := Now;
        InfEvento.tpEvento := teCancelamento;
        infEvento.detEvento.xJust := vAux;
        InfEvento.detEvento.nProt := ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.nProt;
      end;
      //ACBrNFe1.WebServices.EnvEvento.Executar;
      if ACBrNFe1.EnviarEvento(NumeroLote) then
      begin
        with ACBrNFe1.WebServices.EnvEvento do
        begin
          if EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <> 135 then
          begin
            raise Exception.CreateFmt(
               'Ocorreu o seguinte erro ao cancelar a nota fiscal eletrônica:'  + sLineBreak +
               'Código:%d' + sLineBreak +
               'Motivo: %s', [
               EventoRetorno.retEvento.Items[0].RetInfEvento.cStat,
                  EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo
                ]);
          end;
        end;
        MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.EnvEvento.RetWS);
        ShowMessage('Nº do Protocolo de Cancelamento ' + ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);
        Protocolo := ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt;
        gravaRetornoCancelada(Protocolo);
        AcbrNfe1.Configuracoes.Geral.Salvar := True;
      end;


    end;
    dmPdv.qcdsNF.Next;
  end;

  FormatSettings.DecimalSeparator := ',';
  chkTodas.Checked := True;
  btnListar.Click;

end;

procedure TfNFe.btnConsultaClick(Sender: TObject);
var
  atualiza_nf : String;
  nProtCanc: String;
  strAtualizaNota: String;
  num_ln: integer;
begin
  atualiza_nf := '';
  abrirEmpresa;

  ACBrNFe1.Configuracoes.WebServices.UF := Trim(dmPdv.qsEmpresaUF.AsString);
  dmPdv.qcdsNF.First;
  while not dmPdv.qcdsNF.Eof do
  begin
    if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = 'S') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
    begin
      num_ln := dmPdv.qcdsNF.RecNo;
      nfe_carregalogo;
      ACBrNFe1.NotasFiscais.Clear;
      codnf := dmPdv.qcdsNFNUMNF.AsInteger;
      CarregarXML(Copy(Trim(dmPdv.qcdsNFNOMEXML.AsString),0,44));

      if (ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF <> StrToInt(Trim(dmPdv.qcdsNFNOTASERIE.AsString))) then
      begin
        ShowMessage('Nota Selecionada diferente do Xml');
        Exit;
      end;
      ACBrNFe1.Consultar;

      if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
      begin

      end
      else begin
        gravaRetornoEnvio(ACBrNFe1.WebServices.Consulta.protNFe.nProt, '');
        if (ACBrNFe1.WebServices.Consulta.retCancNFe.nProt <> '') then
          gravaRetornoCancelada(ACBrNFe1.WebServices.Consulta.retCancNFe.nProt);
        dmPdv.qcdsNF.RecNo := num_ln;
        Break;
      end;
    end;
    dmPdv.qcdsNF.Next;
  end;
end;

procedure TfNFe.btnContingenciaClick(Sender: TObject);
begin
  tp_amb := 2;
  btnGeraNFeClick(Sender);
  tp_amb := 1;
end;

procedure TfNFe.btnDpecClick(Sender: TObject);
begin
  tp_amb := 4;
  btnGeraNFeClick(Sender);
  tp_amb := 1;
end;

procedure TfNFe.BitBtn7Click(Sender: TObject);
var nfDenegada : String;
begin
  nfDenegada := '';
  dmPdv.qcdsNF.First;
  while not dmPdv.qcdsNF.Eof do
  begin
    if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = 'S') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
    begin
      nfDenegada := Trim(dmPdv.qcdsNFNOTASERIE.AsString);
    end;
    dmPdv.qcdsNF.Next;
  end;

  if  MessageDlg('Confirma a alteração de Status da NF : ' + nfDenegada + ' , para DENEGADA ?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
    exit;

  if  MessageDlg('Isto somente deverá ser feito caso ao Gerar a NFe a RECEITA retornou como DENEGADA, ocorreu isso ?', mtWarning, [mbYes, mbNo],0) = mrNo then
    exit;

  if (nfDenegada <> '') then
  begin
    try
      str := 'UPDATE NOTAFISCAL SET ';
      str := str + ' STATUS = ' + QuotedStr('D');
      str := str + ' ,NFE_FINNFE = ' + quotedstr('fnDenegado');
      str := str + ' WHERE NOTASERIE = ' + nfDenegada;
      dmPdv.IbCon.ExecuteDirect(str);
      dmPdv.strans.Commit;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dmPdv.strans.Rollback; //on failure, undo the changes}
      end;
    end;

  end;



end;

procedure TfNFe.BitBtn4Click(Sender: TObject);
begin
  if (GroupBox11.Visible = False) then
  begin
    GroupBox11.Visible := true;
  end
  else begin
    GroupBox11.Visible := False;
  end;
end;

procedure TfNFe.btnConnDpecClick(Sender: TObject);
//var
// vAux : String;
begin
  if not(InputQuery('WebServices DPEC', 'Informe o Numero do Registro do DPEC ou a Chave da NFe', vAux)) then
    exit;
end;

procedure TfNFe.BitBtn3Click(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathNFe;
  if OpenDialog1.Execute then
  begin
  ACBrNFe1.NotasFiscais.Clear;
  ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
    begin
       // 29/12/2015 - DPEC nao existe mais nesta versao do acbr.
    end;
  ACBrNFe1.Enviar(0);
  end;
  ACBrNFe1.NotasFiscais.Items[0].GravarXML;
end;

procedure TfNFe.ACBrNFe1StatusChange(Sender: TObject);
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

procedure TfNFe.BitBtn1Click(Sender: TObject);
var
  cUFAutor, CNPJ, ultNSU, ANSU, sStat, sMotivo: string;
  IniFile  : String ;
  Ini     : TIniFile ;
  Ok : Boolean;
  StreamMemo : TMemoryStream;
  sChave, sEmissao, sCNPJ, sNome, sNumero, sSerie,
  sIEst, sNSU, sTipoNFe: String;
  Valor: Double;
  i, j, k: integer;
  v_insereMan: String;
  XMLDocument1: TXMLDocument;
  tipo_retorno: String;
begin
  mDFe.Lines.Clear;
  mDFe.Lines.Add('------------------------------------------------------');
  mDFe.Lines.Add(' =>  Consultando NFe Destinadas');
  mDFe.Lines.Add('------------------------------------------------------');

  IniFile := ChangeFileExt( Application.ExeName, '.ini') ;
  Ini := TIniFile.Create( IniFile );
  try
    cbSSLLib.ItemIndex:= Ini.ReadInteger( 'Certificado','SSLLib' ,0) ;
    cbCryptLib.ItemIndex := Ini.ReadInteger( 'Certificado','CryptLib' , 0) ;
    cbHttpLib.ItemIndex := Ini.ReadInteger( 'Certificado','HttpLib' , 0) ;
    cbXmlSignLib.ItemIndex := Ini.ReadInteger( 'Certificado','XmlSignLib' , 0) ;
    edtCaminho.Text  := Ini.ReadString( 'Certificado','Caminho' ,'') ;
    edtSenha.Text    := Ini.ReadString( 'Certificado','Senha'   ,'') ;
    cbSSLType.ItemIndex  := Ini.ReadInteger( 'WebService','SSLType' , 0) ;
    // cbCriaPasta.ItemIndex := Ini.ReadInteger ('Certificado','Criar Pasta', -1) ;
    ComboBox3.ItemIndex := Ini.ReadInteger ('Certificado','Pasta NFe', 0);
    if(edtNumSerie1.Text = '') then
      edtNumSerie1.Text := Ini.ReadString( 'Certificado','NumSerie','');
    ACBrNFe2.Configuracoes.Certificados.ArquivoPFX  := edtCaminho.Text;
    ACBrNFe2.Configuracoes.Certificados.Senha       := edtSenha.Text;
    ACBrNFe2.Configuracoes.Certificados.NumeroSerie := edtNumSerie1.Text;

    //  edtPathSchemas.Text  := Ini.ReadString( 'Certificado','PathSchemas'  ,PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\') ;

    ACBrNFe2.SSL.DescarregarCertificado;

    with ACBrNFe2.Configuracoes.Geral do
    begin
      SSLLib                := TSSLLib(cbSSLLib.ItemIndex);
      SSLCryptLib           := TSSLCryptLib(cbCryptLib.ItemIndex);
      SSLHttpLib            := TSSLHttpLib(cbHttpLib.ItemIndex);
      SSLXmlSignLib         := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
      cbSSLType.Enabled := (ACBrNFe2.Configuracoes.Geral.SSLHttpLib in [httpWinHttp, httpOpenSSL]);
      AtualizaSSLLibsCombo;
    end;
  finally
    Ini.Free ;
  end;
  abrirEmpresa;
  ACBrNFe2.Configuracoes.WebServices.Ambiente := taHomologacao;
  if (trim(dmPdv.qsEmpresa1TIPO.AsString) = '1') then
    ACBrNFe2.Configuracoes.WebServices.Ambiente := taProducao;

  ACBrNFe2.Configuracoes.Arquivos.PathNFe := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString) + 'Fornecedor\';
  if ( not DirectoryExists(ACBrNFe2.Configuracoes.Arquivos.PathNFe)) then
    CreateDir(ACBrNFe2.Configuracoes.Arquivos.PathNFe);
  ACBrNFe2.Configuracoes.Arquivos.PathEvento := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString) + 'Diversos\';
  if ( not DirectoryExists(ACBrNFe2.Configuracoes.Arquivos.PathEvento)) then
    CreateDir(ACBrNFe2.Configuracoes.Arquivos.PathEvento);

  diretorio := GetCurrentDir;
  diretorio_schema := diretorio + '\Schemas';

  ACBrNFe2.Configuracoes.Arquivos.PathSchemas := diretorio_schema;

  cUFAutor := Trim(dmPdv.qsEmpresaUF.AsString);
  ACBrNFe2.Configuracoes.WebServices.UF := Trim(dmPdv.qsEmpresaUF.AsString);

  if (cUFAutor = 'MS') then
    cUFAutor := '50'
  else
    cUFAutor := '35'; // SP

  //if not(InputQuery('WebServices Distribuição Documentos Fiscais', 'Código da UF do Autor', cUFAutor)) then
  //   exit;
  CNPJ := Trim(dmPdv.qsEmpresaCNPJ_CPF.AsString);;
  //if not(InputQuery('WebServices Distribuição Documentos Fiscais', 'CNPJ/CPF do interessado no DF-e', CNPJ)) then
  //   exit;
  dmpdv.busca_sql('SELECT DADOS FROM PARAMETRO WHERE PARAMETRO = ' + QuotedStr('NSU'));
  if (dmPdv.sqBusca.IsEmpty) then
    ultNSU := '0'
  else
    ultNSU := Trim(dmPdv.sqBusca.FieldByName('DADOS').AsString);
  //if not(InputQuery('WebServices Distribuição Documentos Fiscais', 'Último NSU recebido pelo ator', ultNSU)) then
  //  exit;
  ANSU := '';
  //if not(InputQuery('WebServices Distribuição Documentos Fiscais', 'NSU específico', ANSU)) then
  //  exit;

  ACBrNFe2.DistribuicaoDFe(StrToInt(cUFAutor),CNPJ,ultNSU,ANSU);
  sStat   := IntToStr(ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.cStat);
  sMotivo := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.xMotivo;
  ultNSU := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.ultNSU;
  dmpdv.executaSql('UPDATE PARAMETRO SET DADOS = ' + QuotedStr(ultNSU) +
    ' WHERE PARAMETRO = ' + QuotedStr('NSU'));
  tipo_retorno := IntToStr(ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.cStat);
  if (ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 138) then
  begin
    mDFe.Lines.Add(' Documento Localizado para o Destinatário');
    mDFe.Lines.Add(' Utilizar o número que esta no campo: Último NSU');
    mDFe.Lines.Add(' Para uma nova pesquisa.');
    mDFe.Lines.Add(' ');

    j := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count - 1;

    for i := 0 to j do
    begin
      sSerie   := '';
      sNumero  := '';
      sCNPJ    := '';
      sNome    := '';
      sIEst    := '';
      sNSU     := '';
      sEmissao := '';
      sTipoNFe := '';
      Valor    := 0.0;
      sChave := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.chDFe;
      // TODO parei aqui
      //tipo_retorno := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resEvento.tpEvento;
      //sNSU  := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe. NSU;
      //if (ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resEvento.tpEvento .schema = schprocNFe) then
      //if (ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFe.chNFe <> '') then

      //if (ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].schema = schprocNFe) then
      //begin
        // Conjunto de informações resumo da NF-e localizadas.
        // Este conjunto de informação será gerado quando a NF-e for autorizada ou denegada.
        //ArqXML := TStringStream.Create(ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].XML);
        //XMLDocument1.LoadFromStream(ArqXML);
        //XMLDocument1.Active;
        //XMLDocument1.SaveToFile(PastaSalvar+ChaveAcesso+'-nfe.xml');
        {Gravando no banco de dados o download da nota fiscal}
        //GravaXMLnoBanco(XMLDocument1.XML.Text, ChaveAcesso);
        //ArqXML.Free;
        //Result := true;

        //sChave := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFe.chNFe;

        //sSerie  := Copy(sChave, 23, 3);
        //sNumero := Copy(sChave, 26, 9);
        //sCNPJ := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFe.CNPJCPF;
        //sNome := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFe.xNome;
        //sIEst := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFe.IE;
        //case ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFe.tpNF of
        //  tnEntrada: sTipoNFe := 'E';
        //  tnSaida:   sTipoNFe := 'S';
        //end;
        sNSU  := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].NSU;
        //sEmissao := DateToStr(ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFe.dhEmi);
        //Valor := ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFe.vNF;

        // TODO parei aqui
        {ACBrNFe.DistribuicaoDFePorChaveNFe(CodigoUF, CNPJ, ChaveDFe);
        if ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeIntcStat = 138 then
        begin
          for i := 0 to ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count - 1 do
          begin
            try
              ArqXML := TStringStream.Create(ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].XML);
              ArqXML.LoadFromStream(ArqXML);
              ArqXML_Nome := ;
              ArqXML.SaveToFile(ACBrNFe.Configuracoes.Arquivos.PathSalvar + ChaveDFe + '-nfe.xml');
            finally
              FreeAndNil(ArqXML);
            end;
          end;
        end;}

        v_insereMan := 'INSERT INTO NOTAFISCAL_MANIFESTO (CHAVE, EMPRESA' +
          ' , CNPJ, NOME, IE, EMISSAO, TIPO, VALOR, CONFIRMACAO, NSU' +
          ' , DATAEVENTO, PROTOCOLO) VALUES(';
        v_insereMan += QuotedStr(sChave);
        v_insereMan += ', ' + IntToStr(dmPdv.qsEmpresaCODIGO.AsInteger);
        v_insereMan += ', ' + QuotedStr(sCNPJ);
        v_insereMan += ', ' + QuotedStr(sNome);
        v_insereMan += ', ' + QuotedStr(sIEst);
        v_insereMan += ', ' + QuotedStr(sEmissao);
        v_insereMan += ', ' + QuotedStr(sTipoNFe);
        DecimalSeparator := '.';
        v_insereMan += ', ' + FloatToStr(Valor);
        DecimalSeparator := ',';
        v_insereMan += ', Null';
        v_insereMan += ', ' + QuotedStr(sNSU);
      v_insereMan += ', Null';
      v_insereMan += ', Null)';
      dmPdv.executaSql(v_insereMan);
      {case ACBrNFe2.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFe.cSitNFe of
      snAutorizado: Impresso := 'A';
      snDenegado:   Impresso := 'D';
      snCancelada:  Impresso := 'C';
      end;}
    end;
  end
  else begin
     // Nenhum Documento Localizado para o Destinatário
     if (ACBrNFe2.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 137) then
     begin
       mDFe.Lines.Add(' Nenhum Documento Localizado para o Destinatário');
       mDFe.Lines.Add(' Utilizar o número que esta no campo: Último NSU');
       //mDFe.Lines.Add(' Para uma nova pesquisa ('+edtUltNSU.Text+').');
       mDFe.Lines.Add(' ');
     end
     else begin
       mDFe.Lines.Add(' Falha ao realizar a consulta.');
       mDFe.Lines.Add('  ' + sStat + ' - ' + sMotivo);
       mDFe.Lines.Add(' ');
     end;
   end;

  //MemoResp.Lines.Text := ACBrNFe2.WebServices.DistribuicaoDFe.RetWS;
  //memoRespWS.Lines.Text := ACBrNFe2.WebServices.DistribuicaoDFe.RetornoWS;

  //LoadXML(MemoResp, WBResposta);

  ACBrNFe2.Free;
end;






procedure TfNFe.BitBtn8Click(Sender: TObject);
begin
  Close;
end;

procedure TfNFe.btnAbaPrincipalClick(Sender: TObject);
begin
  PageControl2.ActivePage := TabSheet1;
end;

procedure TfNFe.btnAlteraStatusClick(Sender: TObject);
begin

end;

procedure TfNFe.BtnCCe1Click(Sender: TObject);
begin
  BtnCCe.Click;
end;

procedure TfNFe.BtnCCeClick(Sender: TObject);
var   xCond :string;
    envio :TDateTime;
    NumeroLote : Integer;
    tamanho: Integer;
    nfe_arquivo : String;
    ver_var: String;
begin
  ACBrNFe1.Configuracoes.Arquivos.SalvarEvento := True;
  if (edtNumSerie2.Text = '') then
  begin
    MessageDlg('Selecione o Certificado!',mtWarning,[mbOk],0);
    exit;
  end;
  if(ComboBox2.Text = '') then
  begin
    MessageDlg('Centro de custo não selecionado', mtError, [mbOK], 0);
    exit;
  end;
  dmPdv.qcds_ccusto.Close;
  dmPdv.qcds_ccusto.SQL.Clear;
  dmPdv.qcds_ccusto.SQL.Add('select CODIGO, CONTA, NOME from PLANO where plnCtaRoot(CONTA) = ' +
    QuotedStr(conta_local) + ' AND CONSOLIDA = ' + QuotedStr('S') + ' AND NOME = '+
    QuotedStr(ComboBox2.Text));
  dmPdv.qcds_ccusto.Open;
  //dmPdv.qcds_ccusto.Locate('NOME', ComboBox2.Text,[loCaseInsensitive]);

  //Seleciona Empresa de acordo com o CCusto selecionado
  if (dmPdv.qsEmpresa.Active) then
   dmPdv.qsEmpresa.Close;
  dmPdv.qsEmpresa.Params[0].AsInteger := dmPdv.qcds_ccustoCODIGO.AsInteger;
  dmPdv.qsEmpresa.Open;

  ACBrNFe1.Configuracoes.WebServices.UF := Trim(dmPdv.qsEmpresaUF.AsString);

  dmPdv.qsCCE.First;
  While not dmPdv.qsCCE.EOF do
  begin
    ver_var := dmPdv.qsCCECHAVE.AsString;
    ver_var := Trim(dmPdv.qsCCESELECIONOU.AsString);
    if (Trim(dmPdv.qsCCESELECIONOU.AsString) = 'S') then
    begin
      nfe_carregalogo;
      CarregarXML(Copy(Trim(dmPdv.qsCCECHAVE.AsString),0,44));
      envio := Now;
      AcbrNfe1.Configuracoes.Arquivos.PathNFe := edit3.Text;
      AcbrNfe1.Configuracoes.Arquivos.PathEvento := edit3.Text + '\Eventos';
      NumeroLote := StrToInt(FormatDateTime('mmddhhmm', NOW));
      ACBrNFe1.EventoNFe.Evento.Clear;
      Label28.Caption := diretorio_schema;
      ACBrNFe1.Configuracoes.Arquivos.PathSchemas := diretorio_schema;
      xCond := 'A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art. 7o do Convenio S/N, de 15 de dezembro de 1970 e pode ser utilizada para regularizacao de erro ocorrido na emissao ';
      xCond := xCond + 'de documento fiscal, desde que o erro nao esteja relacionado com: I - as variaveis que determinam o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, quantidade, valor da operacao ou da prestacao; II - a correcao de ';
      xCond := xCond + 'dados cadastrais que implique mudanca do remetente ou do destinatario; III - a data de emissao ou de saida';
      with ACBrNFe1.EventoNFe.Evento.Add do
      begin
      InfEvento.chNFe     := Trim(dmPdv.qsCCECHAVE.AsString);
      InfEvento.CNPJ      := RemoveChar(Copy(Trim(dmPdv.qsCCECHAVE.AsString) , 7, 14));
      InfEvento.cOrgao    := dmPdv.qsCCeORGAO.AsInteger;
      //InfEvento.versaoEvento := '1.0.00';
      InfEvento.dhEvento  := envio;
      infEvento.tpEvento := teCCe;
      InfEvento.nSeqEvento := dmPdv.qsCCeSEQUENCIA.AsInteger;
      InfEvento.detEvento.xCorrecao := Trim(dmPdv.qsCCeCORRECAO.AsString);
      //InfEvento.detEvento.xCondUso := xCond;
      end;

    if ACBrNFe1.EnviarEvento(NumeroLote) then
    begin
      with ACBrNFe1.WebServices.EnvEvento do
      begin
        if not(EventoRetorno.retEvento.Items[0].RetInfEvento.cStat in [135, 136]) then
        begin
          MessageDlg('Ocorreu o seguinte erro ao enviar a carta de correção:'  +
            #13+ 'Código: ' + IntToStr(EventoRetorno.retEvento.Items[0].RetInfEvento.cStat) + #13+
            'Motivo: ' + EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo
          , mtError, [mbOK], 0);
        end
        else
          MessageDlg('Evento de Carta de Correção Enviado com Sucesso!',mtInformation,[mbOk],0);
      end;
    end
    else
    begin
      with ACBrNFe1.WebServices.EnvEvento do
      begin
        MessageDlg('Ocorreram erros ao enviar a Carta de Correção:' + #13 +
          'Lote: '     + IntToStr(EventoRetorno.idLote) + #13 +
          'Ambiente: ' + TpAmbToStr(EventoRetorno.tpAmb) + #13 +
          'Orgao: '    + IntToStr(EventoRetorno.cOrgao) + #13 +
          'Status: '   + IntToStr(EventoRetorno.cStat) + #13 +
          'Motivo: '   + EventoRetorno.xMotivo, mtError, [mbOK], 0);
      end;
    end;

    //finally
    protocolo := AcbrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt;
    //cce_arquivo := AcbrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XML
    if (protocolo <> '') then
    begin
      FormatSettings.DecimalSeparator := '.';
      //SALVA OS PROTOCOLOS
        try
          str := 'UPDATE CCE SET PROTOCOLO = ' + quotedStr(protocolo)
          + ', DHENVIO = ' + QuotedStr(FormatDateTime('dd.mm.yyyy hh:mm:ss', envio))
          + ', CONDICAO = ' + QuotedStr(xCond)
          + ' WHERE CHAVE = ' + quotedStr(Trim(dmPdv.qsCCECHAVE.AsString))
          + ' AND SEQUENCIA = ' + IntToStr(dmPdv.qsCCESEQUENCIA.AsInteger);
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
    end;
    dmPdv.qsCCE.Next;
  end;
  //end;
  ACBrNFe1.ImprimirEvento;
  ACBrNFe1.Configuracoes.Arquivos.SalvarEvento := False;
  FormatSettings.DecimalSeparator := ',';

end;

procedure TfNFe.BitBtn2Click(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathNFe;
  if OpenDialog1.Execute then
  begin
  ACBrNFe1.NotasFiscais.Clear;
  ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
    begin
       // 29/12/2015 - DPEC nao existe mais nesta versao do acbr.
     end;
  ACBrNFe1.Enviar(0);
  end;
  ACBrNFe1.NotasFiscais.Items[0].GravarXML;
end;

procedure TfNFe.BitBtn5Click(Sender: TObject);
var
  aux, nota_rec: String;
begin
  if (edRecibo.Text = '') then
  begin
    if not(InputQuery('Consultar Recibo Lote', 'Número do Recibo', aux)) then
      exit;
  end else
  begin
    aux := edRecibo.Text;
  end;
  ACBrNFe1.WebServices.Recibo.Recibo := aux;

  ACBrNFe1.WebServices.Recibo.Executar;

  MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.Recibo.RetWS);
  memoRespWS.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.Recibo.RetornoWS);
  //LoadXML(MemoResp, WBResposta);
  nota_rec := edit1.Text + ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtDFe.Items[0].chDFe + '_rec.xml';
  // .ProtNFe.Items[0].chNFe
  MemoResp.Lines.SaveToFile(nota_rec);

  //pgRespostas.ActivePageIndex := 1;

  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Consultar Recibo');
  MemoDados.Lines.Add('tpAmb: '    +TpAmbToStr(ACBrNFe1.WebServices.Recibo.tpAmb));
  MemoDados.Lines.Add('versao: ' +ACBrNFe1.WebServices.Recibo.versao);
  MemoDados.Lines.Add('verAplic: ' +ACBrNFe1.WebServices.Recibo.verAplic);
  MemoDados.Lines.Add('cStat: '    +IntToStr(ACBrNFe1.WebServices.Recibo.cStat));
  MemoDados.Lines.Add('xMotivo: '  +ACBrNFe1.WebServices.Recibo.xMotivo);
  MemoDados.Lines.Add('cUF: '    +IntToStr(ACBrNFe1.WebServices.Recibo.cUF));
  MemoDados.Lines.Add('xMsg: ' +ACBrNFe1.WebServices.Recibo.xMsg);
  MemoDados.Lines.Add('cMsg: '    +IntToStr(ACBrNFe1.WebServices.Recibo.cMsg));
  MemoDados.Lines.Add('Recibo: ' +ACBrNFe1.WebServices.Recibo.Recibo);
  // 120419 MemoDados.Lines.Add('Chave: ' +ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].chNFe);
  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('');
  MemoDados.Lines.Add(' ** Retorno gravado no arquivo : ' + nota_rec + ' **');


end;

procedure TfNFe.BtnEnvEmailClick(Sender: TObject);
var caminho : string;
begin
  if (Trim(dmPdv.qcdsNFSTATUS.AsString) = 'E') then
  begin
    EnviaEmail;
    ShowMessage('Email enviado com sucesso.');
  end
  else begin
    ShowMessage('NFe não ENVIADA.');
  end;
end;

procedure TfNFe.btnFSDAClick(Sender: TObject);
begin
  tp_amb := 5;
  btnGeraNFeClick(Sender);
  tp_amb := 1;
end;

procedure TfNFe.btnGeraNFeClick(Sender: TObject);
var v_vlr , pvalor: String;
begin
  //EnviaEmail;
  //exit;
  if (GerarNFe = False) then
  begin
    ShowMessage('Erro pra gerar a Nota');
    Exit;
  end;

  //Gera Envio da Nota
  //ACBrNFeDANFCeFortes1.Site := Trim(dmPdv.qsEmpresaWEB.AsString);
  //ACBrNFeDANFCeFortes1.Email := Trim(dmPdv.qsEmpresaE_MAIL.AsString);
  //ACBrNFeDANFCeFortes1.CasasDecimais.vUnCom := danfeDec;

  ACBrNFeDANFeRL1.Site := Trim(dmPdv.qsEmpresaWEB.AsString);
  ACBrNFeDANFeRL1.Email := Trim(dmPdv.qsEmpresaE_MAIL.AsString);
  ACBrNFeDANFeRL1.CasasDecimais.vUnCom := danfeDec;
  lblMsgNfe.Caption := 'Forma Pagamento : '+ forma_pag;
  lblMsgNfe.Caption := ', Enviando arquivo para a Receita Federal';
  if ((tp_amb = 2) or (tp_amb = 5)) then
  begin
    ACBrNFe1.NotasFiscais.Assinar;
    ACBrNFe1.NotasFiscais.Validar;
    if(chek1.Checked = True)then
      ACBrNFeDANFeRL1.TipoDANFE := tiRetrato
    else ACBrNFeDANFeRL1.TipoDANFE := tiPaisagem  ;
    ACBrNFe1.NotasFiscais.Imprimir;
  end
  else if (tp_amb = 4) then
  begin
    MessageDlg('Este ambiente não existe mais.', mtWarning, [mbOK], 0);
  end
  else
  begin
    // 12/04/2021 adicionei este gravarRetornoEnvio linha 1730
    // gravando aqui pq se der algo no Enviar, nao grava o nome xml e da erro imprimir
    codcliEmail := dmPdv.qcdsNFCODCLIENTE.AsInteger;
    pvalor := dmPdv.qcdsNFRAZAOSOCIAL.AsString;
    gravaRetornoEnvio('', '');
    pvalor := dmPdv.qcdsNFRAZAOSOCIAL.AsString;

    ACBrNFe1.Enviar(0, True, True);
    AcbrNfe1.Configuracoes.Arquivos.PathNFe := Edit1.Text;

    //ShowMessage('Nº do Protocolo de envio ' + ACBrNFe1.WebServices.Retorno.Protocolo);
    StatusBar1.SimpleText := 'Nº do Protocolo de envio : ' + ACBrNFe1.WebServices.Retorno.Protocolo +
      ', Nº do Recibo de envio : ' + ACBrNFe1.WebServices.Retorno.Recibo;
    //ShowMessage('Nº do Recibo de envio ' + ACBrNFe1.WebServices.Retorno.Recibo);
    //Recibo := ACBrNFe1.WebServices.Retorno.Recibo;  01/09/2025
    //Protocolo := ACBrNFe1.WebServices.Retorno.Protocolo;
    Recibo := ACBrNFe1.WebServices.Enviar.Recibo;
    Protocolo := ACBrNFe1.WebServices.Enviar.Protocolo;


    FormatSettings.DecimalSeparator := ',';
    gravaRetornoEnvio(Protocolo, Recibo);
    Memolog.Lines.Add('Email Automatico:' + envemail);
    if (envemail = 'S') then
    begin
      lblMsgNfe.Caption := 'Enviando o email para o Cliente';
      if (cbTipoNota.ItemIndex = 1) then
      begin
        EnviaEmailDireto;
      end;
    end;
  end;
  btnListar.Click;
  ACBrNFe1.NotasFiscais.Items[0].GravarXML;
  acbrnfe1.NotasFiscais.ImprimirPDF;
  dmPdv.qcdsNF.Refresh;
  MessageDlg('Nota Fiscal gerada com sucesso.', mtInformation, [mbOK], 0);
end;

procedure TfNFe.BtnPreVisClick(Sender: TObject);
begin
  lblMsgNfe.Caption := 'Forma Pagamento : '+ forma_pag;
  if (GerarNFe = False) then
  begin
    Exit;
  end;
  if(chek1.Checked = True)then
    ACBrNFeDANFeRL1.TipoDANFE := tiRetrato
  else ACBrNFeDANFeRL1.TipoDANFE := tiPaisagem  ;
  ACBrNFe1.NotasFiscais.Imprimir;
end;

procedure TfNFe.btnPreVisContClick(Sender: TObject);
begin
  tp_amb := 2;
  BtnPreVisClick(Sender);
  tp_amb := 1;
end;

procedure TfNFe.btnPreVisDPECClick(Sender: TObject);
begin
  BtnPreVisClick(Sender);
end;

procedure TfNFe.btnPreVisFSDAClick(Sender: TObject);
begin
  tp_amb := 5;
  BtnPreVisClick(Sender);
  tp_amb := 1;
end;

procedure TfNFe.btnPreVisSpedClick(Sender: TObject);
begin
  if (chkScan.Checked) then
  begin
    //tp_amb := 3;
    BtnPreVisClick(Sender);
    //tp_amb := 1;
  end;
end;

procedure TfNFe.btnSair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfNFe.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfNFe.btnSPEDClick(Sender: TObject);
begin
  if (tp_amb = 1) then
  begin
    MessageDlg('Altere a noda para o Modo Scan.', mtWarning, [mbOK], 0);
    exit;
  end;
  if (chkScan.Checked) then
  begin
    //tp_amb := 3;
    btnGeraNFeClick(Sender);
    //tp_amb := 1;
  end;
end;



procedure TfNFe.btnStatusClick(Sender: TObject);
begin
  ACBrNFe1.WebServices.StatusServico.Executar;

  MemoResp.Lines.Text := ACBrNFe1.WebServices.StatusServico.RetWS;
  memoRespWS.Lines.Text := ACBrNFe1.WebServices.StatusServico.RetornoWS;
  //LoadXML(MemoResp, WBResposta);



  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Status Serviço');
  MemoDados.Lines.Add('tpAmb: '    +TpAmbToStr(ACBrNFe1.WebServices.StatusServico.tpAmb));
  MemoDados.Lines.Add('verAplic: ' +ACBrNFe1.WebServices.StatusServico.verAplic);
  MemoDados.Lines.Add('cStat: '    +IntToStr(ACBrNFe1.WebServices.StatusServico.cStat));
  MemoDados.Lines.Add('xMotivo: '  +ACBrNFe1.WebServices.StatusServico.xMotivo);
  MemoDados.Lines.Add('cUF: '      +IntToStr(ACBrNFe1.WebServices.StatusServico.cUF));
  MemoDados.Lines.Add('dhRecbto: ' +DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRecbto));
  MemoDados.Lines.Add('tMed: '     +IntToStr(ACBrNFe1.WebServices.StatusServico.TMed));
  MemoDados.Lines.Add('dhRetorno: '+DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRetorno));
  MemoDados.Lines.Add('xObs: '     +ACBrNFe1.WebServices.StatusServico.xObs);

  if (ACBrNFe1.Integrador= ACBrIntegrador1) then
  begin
    if (ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Codigo <> '') then
    begin
      MemoDados.Lines.Add('[Integrador]');
      MemoDados.Lines.Add('Codigo='+ ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Codigo );
      MemoDados.Lines.Add('Valor='+ ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Valor );

      ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Codigo:= '';
      ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Valor:= '';

    end;
  end;
end;

procedure TfNFe.btnStatusNaoEnviadaClick(Sender: TObject);
var strNEnv: String;
begin
  if  MessageDlg('Confirma a alteração de Status da NF : ' +
    Trim(dmPdv.qcdsNFNOTASERIE.AsString) + ' ?', mtConfirmation,
    [mbYes, mbNo],0) = mrNo then
    exit;
  if (Length(Trim(dmPdv.qcdsNFPROTOCOLOENV.AsString)) > 5) then
  begin
    MessageDlg('Nota com protocolo de envio, utilize o botão imprimir DANFE.',mtWarning,[mbOk],0);
    exit;
  end;
  strNEnv := 'UPDATE NOTAFISCAL SET STATUS = Null, PROTOCOLOENV = Null ' +
  ' WHERE NUMNF = ' + IntToStr(dmPdv.qcdsNFNUMNF.AsInteger);

  try
    dmPdv.IbCon.ExecuteDirect(strNEnv);
    dmPdv.sTrans.Commit;
  except
    on E : Exception do
    begin
      ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
      dmPdv.sTrans.Rollback;
    end;
  end;

end;

procedure TfNFe.btnSVCANClick(Sender: TObject);
begin
  tp_amb := 6;
  BtnPreVisClick(Sender);
  tp_amb := 1;
end;

procedure TfNFe.btnSvcanGeraClick(Sender: TObject);
begin
  tp_amb := 6;
  btnGeraNFe.Click;
  tp_amb := 1;
end;

procedure TfNFe.btnValidaNFeClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathNFe;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFe1.NotasFiscais.Validar;
    showmessage('Nota Fiscal Eletrônica Valida');
  end;
end;

procedure TfNFe.btnValidarRegrasNegocioClick(Sender: TObject);
var
  Msg : String;
  Inicio: TDateTime;
  Ok: Boolean;
  Tempo: String;
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    Inicio := Now;
    Ok := ACBrNFe1.NotasFiscais.ValidarRegrasdeNegocios(Msg);
    Tempo := FormatDateTime('hh:nn:ss:zzz', Now - Inicio);

    if not Ok then
    begin
      MemoDados.Lines.Add('Erro: '+Msg);
      ShowMessage('Erros encontrados'+ sLineBreak + 'Tempo: '+Tempo);
    end
    else
      ShowMessage('Tudo OK'+sLineBreak + 'Tempo: '+Tempo);
  end;

end;

procedure TfNFe.btnValidarXMLClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
// Configuração padrão para exibição dos erros de validação
//  ACBrNFe1.Configuracoes.Geral.ExibirErroSchema := True;
//  ACBrNFe1.Configuracoes.Geral.FormatoAlerta := 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.';
// ACBrNFe1.Configuracoes.Geral.RetirarAcentos

// Sugestão de configuração para apresentação de mensagem mais amigável ao usuário final
  ACBrNFe1.Configuracoes.Geral.ExibirErroSchema := False;
  ACBrNFe1.Configuracoes.Geral.FormatoAlerta := 'Campo:%DESCRICAO% - %MSG%';

  if OpenDialog1.Execute then
   begin
     ACBrNFe1.NotasFiscais.Clear;
     ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName, True);
     try
        ACBrNFe1.NotasFiscais.Validar;
        if ACBrNFe1.NotasFiscais.Items[0].Alertas <> '' then
          MemoDados.Lines.Add('Alertas: '+ACBrNFe1.NotasFiscais.Items[0].Alertas);
        ShowMessage('Nota Fiscal Eletrônica Valida');
     except
        on E: Exception do
        begin
         // pgRespostas.ActivePage := Dados;
          memoLog.Lines.Add('Exception: '+E.Message);
          memoLog.Lines.Add('Erro: '+ACBrNFe1.NotasFiscais.Items[0].ErroValidacao);
          memoLog.Lines.Add('Erro Completo: '+ACBrNFe1.NotasFiscais.Items[0].ErroValidacaoCompleto); //Útil para gravar em arquivos de LOG
        end;
     end;
   end;
end;

procedure TfNFe.btnValidaXMLClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathNFe;
  if OpenDialog1.Execute then
  begin
  ACBrNFe1.NotasFiscais.Clear;
  ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
    begin
       //  DPEC nao existe mais nesta versao do acbr.
      end;
  ACBrNFe1.Enviar(0);
  end;
  ACBrNFe1.NotasFiscais.Items[0].GravarXML;
end;

procedure TfNFe.btnStatusMenMemoClick(Sender: TObject);
begin
  ACBrNFe1.WebServices.StatusServico.Executar;

  MemoResp.Lines.Text := ACBrNFe1.WebServices.StatusServico.RetWS;
  memoRespWS.Lines.Text := ACBrNFe1.WebServices.StatusServico.RetornoWS;
  //LoadXML(MemoResp, WBResposta);



  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Status Serviço');
  MemoDados.Lines.Add('tpAmb: '    +TpAmbToStr(ACBrNFe1.WebServices.StatusServico.tpAmb));
  MemoDados.Lines.Add('verAplic: ' +ACBrNFe1.WebServices.StatusServico.verAplic);
  MemoDados.Lines.Add('cStat: '    +IntToStr(ACBrNFe1.WebServices.StatusServico.cStat));
  MemoDados.Lines.Add('xMotivo: '  +ACBrNFe1.WebServices.StatusServico.xMotivo);
  MemoDados.Lines.Add('cUF: '      +IntToStr(ACBrNFe1.WebServices.StatusServico.cUF));
  MemoDados.Lines.Add('dhRecbto: ' +DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRecbto));
  MemoDados.Lines.Add('tMed: '     +IntToStr(ACBrNFe1.WebServices.StatusServico.TMed));
  MemoDados.Lines.Add('dhRetorno: '+DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRetorno));
  MemoDados.Lines.Add('xObs: '     +ACBrNFe1.WebServices.StatusServico.xObs);

  if (ACBrNFe1.Integrador= ACBrIntegrador1) then
  begin
    if (ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Codigo <> '') then
    begin
      MemoDados.Lines.Add('[Integrador]');
      MemoDados.Lines.Add('Codigo='+ ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Codigo );
      MemoDados.Lines.Add('Valor='+ ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Valor );

      ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Codigo:= '';
      ACBrIntegrador1.ComandoIntegrador.IntegradorResposta.Valor:= '';

    end;
  end;

end;



procedure TfNFe.Button3Click(Sender: TObject);
begin
  if (edtNumSerieABA.Text <> '') then
  begin
    try
      abrirEmpresa;
      str := 'UPDATE EMPRESA SET CERTIFICADO = ' + quotedStr(edtNumSerieABA.Text)
        + ' WHERE CCUSTO = ' + quotedStr(IntToStr(dmpdv.qsEmpresaCCUSTO.AsInteger));
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
end;

procedure TfNFe.Button4Click(Sender: TObject);
begin
  try
    abrirEmpresa;
    str := 'UPDATE EMPRESA SET CERTIFICADO = ' + 'NULL'
    + ' WHERE CCUSTO = ' + quotedStr(IntToStr(dmpdv.qsEmpresaCCUSTO.AsInteger));
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

procedure TfNFe.cbCryptLibChange(Sender: TObject);
begin
  try
    if cbCryptLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLCryptLib := TSSLCryptLib(cbCryptLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfNFe.cbEmpresaChange(Sender: TObject);
begin
  ComboBox1.ItemIndex := cbEmpresa.ItemIndex;
  ComboBox2.ItemIndex := cbEmpresa.ItemIndex;
end;

procedure TfNFe.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfNFe.cbSSLLibChange(Sender: TObject);
begin
  try
    if cbSSLLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfNFe.cbXmlSignLibChange(Sender: TObject);
begin
  try
    if cbXmlSignLib.ItemIndex <> -1 then
      ACBrNFe1.Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TfNFe.ComboBox1Change(Sender: TObject);
begin
  cbEmpresa.ItemIndex := ComboBox1.ItemIndex;
  ComboBox2.ItemIndex := ComboBox1.ItemIndex;
  abrirEmpresa;
  carregaTudo;
  abrindoSistema;
end;

procedure TfNFe.ComboBox2Change(Sender: TObject);
begin
  ComboBox1.ItemIndex := ComboBox2.ItemIndex;
  cbEmpresa.ItemIndex := ComboBox2.ItemIndex;
end;

procedure TfNFe.DBGrid1CellClick(Column: TColumn);
var num_ln: integer;
  ver_str: String;
begin
  num_ln := dmPdv.qcdsNF.RecNo;
  if nota_selec = '' then
    nota_selec := Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString)
  else
    nota_selec := '';
  if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = '') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
  begin
    dmPdv.IbCon.ExecuteDirect('UPDATE NOTAFISCAL SET SELECIONOU = '
    + QuotedStr('S') + ' WHERE NUMNF = ' + QuotedStr(Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString)));
    dmPdv.sTrans.Commit;
  end else
  begin
    dmPdv.IbCon.ExecuteDirect('UPDATE NOTAFISCAL SET SELECIONOU = '
    + QuotedStr('') + ' WHERE NUMNF = ' + QuotedStr(Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString))); //QuotedStr('2386'));
    dmPdv.sTrans.Commit;
  end;
  // corrigir para ficar na mesma linha 21/09/19
//   btnListar.Click;;
  dmPdv.qcdsNF.DisableControls;
  dmPdv.qcdsNF.Close;
  dmPdv.qcdsNF.Open;
  dmPdv.qcdsNF.RecNo := num_ln;
  dmPdv.qcdsNF.EnableControls;
 //   dmPdv.qcdsNF.Refresh;
  ver_str := trim(dmPdv.qcdsNFSELECIONOU.AsString);
  //  dmPdv.qcdsNF.ApplyUpdates;
  //edDadosXml.Text
  StatusBar1.SimpleText := dmPdv.qcdsnfNFE_FINNFE.AsString + '-' + dmPdv.qcdsnfNFE_MODELO.AsString + '-' + dmPdv.qcdsnfNFE_VERSAO.AsString + '-' +
  dmPdv.qcdsnfNFE_DESTOPERACAO.AsString + '-' + dmPdv.qcdsnfNFE_FORMATODANFE.AsString + '-' + dmPdv.qcdsnfNFE_TIPOEMISSAO.AsString + '-' +
  dmPdv.qcdsnfNFE_INDFINAL.AsString + '-' + dmPdv.qcdsnfNFE_INDPRES.AsString + '-' + dmPdv.qcdsNFIND_IEDEST.AsString;

  if (dmPdv.qsEmpresa.Active) then
    dmPdv.qsEmpresa.Close;
  dmPdv.qsEmpresa.Params[0].AsInteger := dmPdv.qcdsNFCCUSTO.AsInteger;
  dmPdv.qsEmpresa.Open;
  fNFe.Caption := dmPdv.qsEmpresaEMPRESA.AsString;
end;

procedure TfNFe.DBGrid1ColEnter(Sender: TObject);
begin
  if DBGrid1.SelectedField = dmPdv.qcdsNFSELECIONOU then
    DBGrid1.Options := DBGrid1.Options - [dgEditing]
  else
    DBGrid1.Options := DBGrid1.Options + [dgEditing];
end;

procedure TfNFe.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.Field = dmPdv.qcdsNFSELECIONOU then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    ImageList2.Draw(DBGrid1.Canvas,Rect.Left+10,Rect.top, 1);
    if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = 'S') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
      ImageList2.Draw(DBGrid1.Canvas,Rect.Left+10,Rect.top, 2)
    else
      ImageList2.Draw(DBGrid1.Canvas,Rect.Left+10,Rect.top, 0);
  end;
end;

procedure TfNFe.DBGrid2CellClick(Column: TColumn);
var str_cce: string;
begin
  if (trim(dmPdv.qsCCESELECIONOU.AsString) = '') then
  begin
    dmPdv.IbCon.ExecuteDirect('UPDATE CCE SET SELECIONOU = ' + QuotedStr('S') +
      ' WHERE CHAVE = ' + QuotedStr(Trim(dmPdv.qsCCE.FieldByName('CHAVE').AsString)) +
      ' AND SEQUENCIA = ' + IntToStr(dmPdv.qsCCE.FieldByName('SEQUENCIA').AsInteger));
    edtChaveNfeCCe.Text := Trim(dmPdv.qsCCE.FieldByName('CHAVE').AsString);
    dmPdv.sTrans.Commit;
  end else
  begin
    dmPdv.IbCon.ExecuteDirect('UPDATE CCE SET SELECIONOU = NULL '  +
      ' WHERE CHAVE = ' + QuotedStr(Trim(dmPdv.qsCCE.FieldByName('CHAVE').AsString)) +
      ' AND SEQUENCIA = ' + IntToStr(dmPdv.qsCCE.FieldByName('SEQUENCIA').AsInteger));
    edtChaveNfeCCe.Text := '';
    dmPdv.sTrans.Commit;
  end;

  if (edtChaveNfeCCe.Text <> '') then
  begin
    //btnListar.Click;
    StatusBar1.SimpleText := dmPdv.qcdsnfNFE_FINNFE.AsString + '-' + dmPdv.qcdsnfNFE_MODELO.AsString + '-' + dmPdv.qcdsnfNFE_VERSAO.AsString + '-' +
    dmPdv.qcdsnfNFE_DESTOPERACAO.AsString + '-' + dmPdv.qcdsnfNFE_FORMATODANFE.AsString + '-' + dmPdv.qcdsnfNFE_TIPOEMISSAO.AsString + '-' +
    dmPdv.qcdsnfNFE_INDFINAL.AsString + '-' + dmPdv.qcdsnfNFE_INDPRES.AsString + '-' + dmPdv.qcdsNFIND_IEDEST.AsString;

    if (dmPdv.qsEmpresa.Active) then
      dmPdv.qsEmpresa.Close;
    dmPdv.qsEmpresa.Params[0].AsInteger := dmPdv.qcdsNFCCUSTO.AsInteger;
    dmPdv.qsEmpresa.Open;
    fNFe.Caption := dmPdv.qsEmpresaEMPRESA.AsString;
  end;

  // 25/11/2020 , era antes do if acima, mudei pra ca e  adicionei este bloco do if
  if (edtChaveNfeCCe.Text <> '') then
  begin
    if (dmPdv.qsCCE.Active) then
      dmPdv.qsCCE.Close;
    dmPdv.qsCCE.SQL.Clear;

    str_cce := 'select * FROM CCE WHERE CHAVE = ' +
      QuotedStr(edtChaveNfeCCe.Text) +
      ' AND SELECIONOU = ' + QuotedStr('S');
    dmPdv.qsCCE.SQL.Text := str_cce;
  end;
  dmPdv.qsCCE.Open;


  // 25/11/2020  comentei e adicionei as 2 linhas abaixo
  //btnListarCCe.Click;
  BtnCCe.Enabled := True;
  btnImprimirCCe.Enabled := True;
end;

procedure TfNFe.DBGrid2CellClick(Sender: TObject);
begin

end;

procedure TfNFe.DBGrid2ColEnter(Sender: TObject);
begin
  if DBGrid2.SelectedField = dmPdv.qsCCESELECIONOU then
    DBGrid2.Options := DBGrid2.Options - [dgEditing]
  else
    DBGrid2.Options := DBGrid2.Options + [dgEditing];
end;

procedure TfNFe.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.Field = dmPdv.qsCCESELECIONOU then
  begin
    DBGrid2.Canvas.FillRect(Rect);
    ImageList2.Draw(DBGrid2.Canvas,Rect.Left+10,Rect.top, 1);
    if (trim(dmPdv.qsCCESELECIONOU.AsString) = 'S') then
      ImageList2.Draw(DBGrid2.Canvas,Rect.Left+10,Rect.top, 2)
    else
      ImageList2.Draw(DBGrid2.Canvas,Rect.Left+10,Rect.top, 0);
  end;

end;

procedure TfNFe.FloatSpinEdit1Change(Sender: TObject);
begin
  ACBrNFeDANFeRL1.MargemSuperior:=FloatSpinEdit1.Value;
end;

procedure TfNFe.FloatSpinEdit2Change(Sender: TObject);
begin
  ACBrNFeDANFeRL1.MargemInferior:=FloatSpinEdit2.Value;
end;

procedure TfNFe.FloatSpinEdit3Change(Sender: TObject);
begin
  ACBrNFeDANFeRL1.MargemEsquerda:=FloatSpinEdit3.Value;
end;

procedure TfNFe.FloatSpinEdit4Change(Sender: TObject);
begin
  ACBrNFeDANFeRL1.MargemDireita:=FloatSpinEdit4.Value;
end;

procedure TfNFe.FormCreate(Sender: TObject);
begin
  carregaTudo;
end;

procedure TfNFe.FormShow(Sender: TObject);
begin
  abrindoSistema;
  totIPIDevol:= 0;
end;

procedure TfNFe.Label5Click(Sender: TObject);
begin

end;




procedure TfNFe.nfe_carregalogo;
var tem_logo: String;
begin
  tem_logo := '';
  if ((tem_logo = '') and (FilesExists(diretorio + '\' +  Trim(dmPdv.qsEmpresaDIVERSOS2.AsString)))) then
    tem_logo := diretorio + '\' +  Trim(dmPdv.qsEmpresaDIVERSOS2.AsString);
  if (FilesExists(diretorio + '\logo_nfe.jpg')) then
    tem_logo := diretorio + '\logo_nfe.jpg';
  if (tem_logo = '') and (FilesExists(diretorio + '\logo.bmp')) then
    tem_logo := diretorio + '\logo.bmp';

  if (tem_logo <> '') then
  begin
    //ACBrNFeDANFCeFortes1.Logo := diretorio + '\' +  Trim(dmPdv.qsEmpresaDIVERSOS2.AsString);
    ACBrNFeDANFeRL1.Logo := tem_logo;
    Image1.Picture.LoadFromFile(tem_logo);
    fNFe.Caption := dmPdv.qsEmpresaRAZAO.AsString + ', Logo ' + tem_logo;
  end;

end;

procedure TfNFe.EnviaEmail;
var
 IDNFE, RAZAO, CNPJ, TRANSP, Assunto, caminho, email : String;
 enumnf ,serie, num_xml, num_posicao : Integer;
 CC, Texto: Tstrings;
begin
  ACBrNFe1.MAIL := ACBrMail1;
  dmPdv.qcdsNF.DisableControls;
  num_posicao := dmPdv.qcdsNF.RecNo;
  dmPdv.qcdsNF.First;
  while not dmPdv.qcdsNF.Eof do
  begin
    if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = 'S') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
    begin
      //Memolog.Lines.Add('Email Nota:' + Trim(dmPdv.qcdsNFNOTASERIE.AsString));
      nfe_carregalogo;
      //if (enumnf <> StrToInt(Trim(dmPdv.qcdsNFNOTASERIE.AsString))) then
      enumNF :=  StrToInt(Trim(dmPdv.qcdsNFNOTASERIE.AsString));
      num_xml  := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;
      //if (num_xml = '') then
      //  num_xml := '0';
      if (enumNF <> num_xml) then
      begin
        ACBrNFe1.NotasFiscais.Clear;
        CarregarXML(Copy(Trim(dmPdv.qcdsNFNOMEXML.AsString),0,44));
      end;
      email := '';
      if (cbTipoNota.ItemIndex = 1) then
      begin
        if (dmPdv.qsCliente.Active) then
          dmPdv.qsCliente.Close;
        dmPdv.qsCliente.Params[0].AsInteger := dmPdv.qcdsNFCODCLIENTE.AsInteger;
        dmPdv.qsCliente.Open;
        email := Trim(dmPdv.qsClienteE_MAIL.AsString);
      end;
      if (cbTipoNota.ItemIndex = 0) then
      begin
        if (dmPdv.qsFornec.Active) then
          dmPdv.qsFornec.Close;
        dmPdv.qsFornec.Params[0].AsInteger := dmPdv.qcdsNFCODCLIENTE.AsInteger;
        dmPdv.qsFornec.Open;
        email := Trim(dmPdv.qsFornecE_MAIL.AsString);
      end;

    if (email = '') then
    begin
      if (cbTipoNota.ItemIndex = 1) then
        ShowMessage('Cliente sem email no cadastro.');
      if (cbTipoNota.ItemIndex = 0) then
        ShowMessage('Fornecedor sem email no cadastro.');
      Exit;
    end;

      CC := TstringList.Create;
    try
      //ABRE A NOTA
      IDNFE  := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
      enumnf  := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;
      RAZAO  := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.xNome;
      CNPJ   := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.CNPJCPF;
      serie  := ACBrNFe1.NotasFiscais.Items[0].NFe.ide.serie;
      TRANSP := ACBrNFe1.NotasFiscais.Items[0].NFe.Transp.Transporta.xNome;
      Texto := TStringList.Create;
      Texto.Add('Empresa emissora da NF-e: ' + Trim(dmPdv.qsEmpresaRAZAO.AsString));
      Texto.Add('CNPJ/CPF da Empresa Emissora: ' + Trim(dmPdv.qsEmpresaCNPJ_CPF.AsString));
      Texto.Add('Empresa destacada na NF-e: ' + RAZAO);
      Texto.Add('CNPJ/CPF da Empresa/Cliente destacado: ' + CNPJ);
      Texto.Add('Numero da NF: ' + InttoStr(enumnf) + ' Serie ' + IntToStr(serie));
      Texto.Add('Chave de identificacaoo: ' + IDNFE);
      Texto.Add('');
      Texto.Add('');
      Texto.Add('Consulte no Portal Nacional da NFe: https://www.nfe.fazenda.gov.br/portal/FormularioDePesquisa.aspx?tipoconsulta=completa .');
      Texto.Add('Ou consulte pela pagina do SEFAZ do seu estado.');
      Memolog.Lines.Add(Texto.Text);
      Assunto := Trim(dmPdv.qsEmpresaE_MAIL.AsString);
      CC.Add(Assunto); //especifique um email válido
      Assunto := 'Nota Fiscal Eletronica ' + InttoStr(enumnf);
      begin
        ACBrMail1.Port     := Trim(dmPdv.qsEmpresaPORTA.AsString);
        ACBrMail1.Host     := Trim(dmPdv.qsEmpresaSMTP.AsString);
        ACBrMail1.Username := Trim(dmPdv.qsEmpresaE_MAIL.AsString);
        ACBrMail1.Password := Trim(dmPdv.qsEmpresaSENHA.AsString);
        ACBrMail1.From     := Trim(dmPdv.qsEmpresaE_MAIL.AsString);
        ACBrMail1.FromName := Trim(dmPdv.qsEmpresaEMPRESA.AsString);
        ACBrMail1.AddAddress(email);
        Memolog.Lines.Add('Porta Servidor:' + Trim(dmPdv.qsEmpresaPORTA.AsString));
        Memolog.Lines.Add('Email Destino:' + email);

        if (email_tls = 'S') then
          ACBrMail1.SetTLS := True;
        if (email_ssl = 'S') then
          ACBrMail1.SetSSL := True;
        //ACBrMail1.AddAttachment(ACBrNFe1.NotasFiscais.Items[0].XML,'', adAttachment);
        //sPara, sAssunto: String; sMensagem: TStrings;
        //       EnviaPDF: Boolean; sCC: TStrings; Anexos: TStrings)
        Memolog.Lines.Add('Assunto:'  + Assunto);

        //ACBrNFe1.NotasFiscais.Items[0].EnviarEmail
        //, True //Enviar PDF junto
        caminho := email;
        ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(caminho
                            , Assunto
                            , Texto
                            , True
                            , CC //com copia
                            , nil // Lista de anexos - TStrings
                            );

        //ShowMessage('Email enviado com sucesso!');
        StatusBar1.SimpleText := StatusBar1.SimpleText + ', EMAIL enviado com Sucesso.';
        lblMsgNfe.Caption := '';
      end;
    finally
      CC.Clear;
      CC.Free;
      Texto.Free;
      //fNFeletronica.ACBrNFe1.NotasFiscais.Clear;
    end;
    end;
    dmPdv.qcdsNF.Next;
  end;
  dmPdv.qcdsNF.RecNo := num_posicao;
  dmPdv.qcdsNF.EnableControls;
end;

procedure TfNFe.EnviaEmailDireto;
var
 IDNFE, RAZAO, CNPJ, TRANSP, Assunto, caminho, email , pdadosEmp : String;
 enumnf ,serie, num_xml, num_posicao : Integer;
 CC, Texto: Tstrings;
begin
  ACBrNFe1.MAIL := ACBrMail1;
      //Memolog.Lines.Add('Email Nota:' + Trim(dmPdv.qcdsNFNOTASERIE.AsString));
      nfe_carregalogo;
      {enumNF :=  StrToInt(Trim(dmPdv.qcdsNFNOTASERIE.AsString));
      num_xml  := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;
      if (enumNF <> num_xml) then
      begin
        ACBrNFe1.NotasFiscais.Clear;
        CarregarXML(Copy(Trim(dmPdv.qcdsNFNOMEXML.AsString),0,44));
      end;
      }

      if (dmPdv.qsEmpresa.Active) then
        dmPdv.qsEmpresa.Close;
      dmPdv.qsEmpresa.Params[0].AsInteger := dmPdv.qcdsNFCCUSTO.AsInteger;
      dmPdv.qsEmpresa.Open;

      email := '';
      if (cbTipoNota.ItemIndex = 1) then
      begin
        if (dmPdv.qsCliente.Active) then
          dmPdv.qsCliente.Close;
        dmPdv.qsCliente.Params[0].AsInteger := codcliEmail ;//  dmPdv.qcdsNFCODCLIENTE.AsInteger;
        dmPdv.qsCliente.Open;
        email := Trim(dmPdv.qsClienteE_MAIL.AsString);
      end;
      if (cbTipoNota.ItemIndex = 0) then
      begin
        if (dmPdv.qsFornec.Active) then
          dmPdv.qsFornec.Close;
        dmPdv.qsFornec.Params[0].AsInteger := codcliEmail;// dmPdv.qcdsNFCODCLIENTE.AsInteger;
        dmPdv.qsFornec.Open;
        email := Trim(dmPdv.qsFornecE_MAIL.AsString);
      end;

    if (email = '') then
    begin
      if (cbTipoNota.ItemIndex = 1) then
        ShowMessage('Cliente sem email no cadastro.');
      if (cbTipoNota.ItemIndex = 0) then
        ShowMessage('Fornecedor sem email no cadastro.');
      Exit;
    end;

    pdadosEmp := Trim(dmPdv.qsEmpresaSMTP.AsString);

    CC := TstringList.Create;
    try
      //ABRE A NOTA
      IDNFE  := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
      enumnf  := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;
      RAZAO  := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.xNome;
      CNPJ   := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.CNPJCPF;
      serie  := ACBrNFe1.NotasFiscais.Items[0].NFe.ide.serie;
      TRANSP := ACBrNFe1.NotasFiscais.Items[0].NFe.Transp.Transporta.xNome;
      Texto := TStringList.Create;
      Texto.Add('Empresa emissora da NF-e: ' + Trim(dmPdv.qsEmpresaRAZAO.AsString));
      Texto.Add('CNPJ/CPF da Empresa Emissora: ' + Trim(dmPdv.qsEmpresaCNPJ_CPF.AsString));
      Texto.Add('Empresa destacada na NF-e: ' + RAZAO);
      Texto.Add('CNPJ/CPF da Empresa/Cliente destacado: ' + CNPJ);
      Texto.Add('Numero da NF: ' + InttoStr(enumnf) + ' Serie ' + IntToStr(serie));
      Texto.Add('Chave de identificacaoo: ' + IDNFE);
      Texto.Add('');
      Texto.Add('');
      Texto.Add('Consulte no Portal Nacional da NFe: https://www.nfe.fazenda.gov.br/portal/FormularioDePesquisa.aspx?tipoconsulta=completa .');
      Texto.Add('Ou consulte pela pagina do SEFAZ do seu estado.');
      Memolog.Lines.Add(Texto.Text);
      Assunto := Trim(dmPdv.qsEmpresaE_MAIL.AsString);
      CC.Add(Assunto); //especifique um email válido
      Assunto := 'Nota Fiscal Eletronica ' + InttoStr(enumnf);
      begin
        ACBrMail1.Port     := Trim(dmPdv.qsEmpresaPORTA.AsString);
        ACBrMail1.Host     := Trim(dmPdv.qsEmpresaSMTP.AsString);
        ACBrMail1.Username := Trim(dmPdv.qsEmpresaE_MAIL.AsString);
        ACBrMail1.Password := Trim(dmPdv.qsEmpresaSENHA.AsString);
        ACBrMail1.From     := Trim(dmPdv.qsEmpresaE_MAIL.AsString);
        ACBrMail1.FromName := Trim(dmPdv.qsEmpresaEMPRESA.AsString);
        ACBrMail1.AddAddress(email);
        Memolog.Lines.Add('Porta Servidor:' + Trim(dmPdv.qsEmpresaPORTA.AsString));
        Memolog.Lines.Add('Email Destino:' + email);

        if (email_tls = 'S') then
          ACBrMail1.SetTLS := True;
        if (email_ssl = 'S') then
          ACBrMail1.SetSSL := True;
        Memolog.Lines.Add('Assunto:'  + Assunto);

        caminho := email;
        ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(caminho
                            , Assunto
                            , Texto
                            , True
                            , CC //com copia
                            , nil // Lista de anexos - TStrings
                            );
        StatusBar1.SimpleText := StatusBar1.SimpleText + ', EMAIL enviado com Sucesso.';
        lblMsgNfe.Caption := '';
      end;
    finally
      CC.Clear;
      CC.Free;
      Texto.Free;
    end;
end;

procedure TfNFe.PageControl2Change(Sender: TObject);
begin

end;

procedure TfNFe.sbtnGetCert1Click(Sender: TObject);
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
        edtNumSerieABA.Text := edtNumSerie.Text;
        edtNumSerie2.Text := edtNumSerie.Text;
        ACBrNFe1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;
      end;
    finally
       frSelecionarCertificado.Free;
    end;
  if ( ((ACBrNFe1.SSL.CertDataVenc - Now) < 30) and ((ACBrNFe1.SSL.CertDataVenc - Now) > 0)) then
    MessageDlg( 'Seu certificado expira dia ' + DateToStr(ACBrNFe1.SSL.CertDataVenc) , mtInformation, [mbOK], 0);

end;

procedure TfNFe.sbtnGetCert3Click(Sender: TObject);
begin

end;

procedure TfNFe.sbtnGetCertClick(Sender: TObject);
var
  I: Integer;
begin
  with ACBrNFe1.Configuracoes.Geral do
  begin
    SSLLib                := TSSLLib(cbSSLLib.ItemIndex);
    SSLCryptLib           := TSSLCryptLib(cbCryptLib.ItemIndex);
    SSLHttpLib            := TSSLHttpLib(cbHttpLib.ItemIndex);
    SSLXmlSignLib         := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
    AtualizaSSLLibsCombo;
  end;
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
      edtNumSerieABA.Text := edtNumSerie.Text;
      edtNumSerie1.Text := edtNumSerie.Text;
      edtNumSerie2.Text := edtNumSerie.Text;
    end;
  finally
    frSelecionarCertificado.Free;
  end;
  if ( ((ACBrNFe1.SSL.CertDataVenc - Now) < 30) and ((ACBrNFe1.SSL.CertDataVenc - Now) > 0)) then
     MessageDlg( 'Seu certificado expira dia ' + DateToStr(ACBrNFe1.SSL.CertDataVenc) , mtInformation, [mbOK], 0);
  //lblVencimentoCert.Caption := DateToStr(ACBrNFe1.SSL.CertDataVenc);
end;

procedure TfNFe.SpeedButton1Click(Sender: TObject);
begin
end;

procedure TfNFe.SpeedButton2Click(Sender: TObject);
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
        edtNumSerieABA.Text := edtNumSerie.Text;
        edtNumSerie2.Text := edtNumSerie.Text;
      end;
    finally
       frSelecionarCertificado.Free;
    end;
  if ( ((ACBrNFe1.SSL.CertDataVenc - Now) < 30) and ((ACBrNFe1.SSL.CertDataVenc - Now) > 0)) then
    MessageDlg( 'Seu certificado expira dia ' + DateToStr(ACBrNFe1.SSL.CertDataVenc) , mtInformation, [mbOK], 0);

end;

procedure TfNFe.SpeedButton3Click(Sender: TObject);
begin

end;

procedure TfNFe.TestEmailClick(Sender: TObject);
var
 IDNFE, RAZAO, CNPJ, TRANSP, Assunto, caminho , ttl, ssl, email : String;
 numnfemail, serie : Integer;
 CC, Texto: Tstrings;
begin
  dmPdv.qcdsNF.DisableControls;
  dmPdv.qcdsNF.First;
  while not dmPdv.qcdsNF.Eof do
  begin
    if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = 'S') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
    begin
      if (Trim(dmPdv.qcdsNFXMLNFE.AsString) <> '') then
      begin
        ACBrNFe1.NotasFiscais.Clear;
        ACBrNFe1.NotasFiscais.LoadFromString(Trim(dmPdv.qcdsNFXMLNFE.AsString));
      end
      else begin
         OpenDialog1.Title := 'Selecione a NFE';
         OpenDialog1.DefaultExt:= '*-nfe.XML';
         OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
         OpenDialog1.InitialDir := Edit1.Text;
         if OpenDialog1.Execute then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           caminho := OpenDialog1.FileName;
           ACBrNFe1.NotasFiscais.LoadFromFile(caminho);
         end;
      end;
      if (numnfemail <> StrToInt(Trim(dmPdv.qcdsNFNOTASERIE.AsString))) then
        numnfemail :=  StrToInt(Trim(dmPdv.qcdsNFNOTASERIE.AsString));
      if not(dmPdv.qsCliente.Active) then
      begin
        dmPdv.qsCliente.Params[0].AsInteger := dmPdv.qcdsNFCODCLIENTE.AsInteger;
        dmPdv.qsCliente.Open;
      end;
    end;
    dmPdv.qcdsNF.Next;
  end;
  dmPdv.qcdsNF.EnableControls;

  CC := TstringList.Create;
  //ABRE A NOTA
  IDNFE       := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
  numnfemail  := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF; //StrToInt(cdsNFNOTASERIE.AsString);
  RAZAO       := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.xNome;
  CNPJ        := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.CNPJCPF;
  serie       := ACBrNFe1.NotasFiscais.Items[0].NFe.ide.serie;
  TRANSP      := ACBrNFe1.NotasFiscais.Items[0].NFe.Transp.Transporta.xNome;


  //Protocolo := ACBrNFe1.WebServices.Retorno.Protocolo;
  Texto := TStringList.Create;
  Texto.Add('Empresa emissora da NF-e: ' + dmPdv.qsEmpresaRAZAO.AsString);
  Texto.Add('CNPJ/CPF da Empresa Emissora: ' + dmPdv.qsEmpresaCNPJ_CPF.AsString);
  Texto.Add('Empresa destacada na NF-e: ' + RAZAO);
  Texto.Add('CNPJ/CPF da Empresa/Cliente destacado: ' + CNPJ);
  Texto.Add('Número da NF: ' + InttoStr(numnfemail) + ' Série ' + IntToStr(serie));
  Texto.Add('Chave de identificação: ' + IDNFE);
  Texto.Add('');
  Texto.Add('');
  Texto.Add('Consulte no Portal Nacional da NFe: https://www.nfe.fazenda.gov.br/portal/FormularioDePesquisa.aspx?tipoconsulta=completa .');
  Texto.Add('Ou consulte pela página do SEFAZ do seu estado.');

  CC.Add(Trim(dmPdv.qsEmpresaE_MAIL.AsString)); //especifique um email válido
  Assunto := 'Nota Fiscal Eletrônica ' + InttoStr(numnfemail);

  email := edtSeuEmail.Text;

  Try
    begin
      try
        // 29/12/2015
        ACBrMail1.Port       := edtPorta.Text;        // sEmpresaPORTA.AsString;
        ACBrMail1.Host       := edtSMTP.Text;         //sEmpresaSMTP.AsString;
        ACBrMail1.Username   := edtUsername.Text;     // sEmpresaE_MAIL.AsString;
        ACBrMail1.Password   := edtSenhas.Text;       // sEmpresaSENHA.AsString;
        ACBrMail1.From       := edtSeuEmail.Text;     // sEmpresaE_MAIL.AsString;
        ACBrMail1.FromName   := 'TESTE EMAIL ATS ';    //sEmpresaEMPRESA.AsString;
        ACBrMail1.AddAddress(email);     // (sClienteE_MAIL.AsString);


        ttl := edtTLS.Text;
        ssl := edtSSL.Text;

        if(ttl = 'S') then
        begin
          if (email_tls = 'S') then
            ACBrMail1.SetTLS := True;
          if (email_ssl = 'S') then
            ACBrMail1.SetSSL := True;
        end;

        if(ttl = 'N') then
        begin
          if (email_tls = 'N') then
            ACBrMail1.SetTLS := False;
          if (email_ssl = 'N') then
            ACBrMail1.SetSSL := False;
        end;

        //sPara, sAssunto: String; sMensagem: TStrings;
        //       EnviaPDF: Boolean; sCC: TStrings; Anexos: TStrings)
        ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(Trim(dmPdv.qsClienteE_MAIL.AsString)
                                                 , Assunto
                                                 , Texto
                                                 , True //Enviar PDF junto
                                                 , CC //com copia
                                                 , nil // Lista de anexos - TStrings
                                                 );

        ShowMessage('Email enviado com sucesso!');
        lblMsgNfe.Caption := '';
      except
         on E: Exception do
          begin
            raise Exception.Create('Erro ao enviar email'+sLineBreak+E.Message);
          end;
      end;
    end;
  finally
    CC.Clear;
    CC.Free;
    Texto.Free;
    //fNFeletronica.ACBrNFe1.NotasFiscais.Clear;
  end;

end;

procedure TfNFe.ACBrNFe1GerarLog(const Mensagem: String);
begin
  memoLog.Lines.Add(Mensagem);
end;

procedure TfNFe.ACBrNFe1TransmitError(const HttpError, InternalError: Integer;
  const URL, DataSent, SoapAction: String; var TryAgain: Boolean);
begin
  ShowMessage('HTTPError: '+IntToStr(HttpError) + sLineBreak +
              'InternalError: '+IntToStr(InternalError)  );

  TryAgain := False;
end;


function TfNFe.validaNumNfeScan(): Boolean;
begin
  //
end;

procedure TfNFe.getPagamento;
var
 c : integer;
 vlr_total , A , B , pTroco: double;
 num_fat: Integer;
begin
  num_fat := 1;
  with ACBrNFe1.NotasFiscais.Items[0].NFe do
  begin
    if(trim(dmPdv.qsCFOPNAOENVFATURA.AsString) = 'S') then
    begin
       with pag.Add do
       begin
         tPag := fpSemPagamento;        //11
       end;
    end
    else begin
      if (dmPdv.qcdsNFVALOR_PAGAR.AsFloat = dmPdv.qcdsNFENTRADA.AsFloat) then
        Ide.indPag    := ipVista
      else
        Ide.indPag    := ipPrazo;
      //pesquisa pagamento
      if ((dmPdv.qcdsNFFATURA.IsNull) or (Trim(dmPdv.qcdsNFFATURA.AsString) = '')) then
      begin
        if(dmPdv.qcdsFatura.Active) then
          dmPdv.qcdsFatura.Close;
        dmPdv.qcdsFatura.Params[0].AsInteger := dmPdv.qcdsNFCODVENDA.AsInteger;
        dmPdv.qcdsFatura.Params[1].AsInteger := cbTipoNota.ItemIndex;
        dmPdv.qcdsFatura.Open;
        if (dmPdv.qsNFC.Active) then
          dmPdv.qsNFC.Close;
        dmPdv.qsNFC.Params[0].AsInteger := dmPdv.qcdsNFNUMNF.AsInteger;
        dmPdv.qsNFC.Open;
        //Carrega dados do Pagamento
        dmPdv.qcdsFatura.first;
        c := 0;
        vlr_total := 0;

       // 03/07/18
       //forma_pag := trim(dmPdv.qcdsFaturaFORMAPAGAMENTO.AsString);
       // if ((forma_pag <> '') and (forma_pag <> 'R')) then

       forma_pag := trim(dmPdv.qcdsFaturaFORMAPAGAMENTO.AsString);
       while not dmPdv.qcdsFatura.eof do
       begin
         vlr_total := vlr_total + dmPdv.qcdsFaturaVALOR.AsCurrency;
         dmPdv.qcdsFatura.next;
       end;
        A := dmPdv.qcdsNFVALOR_PAGAR.AsFloat;
        B := dmPdv.qcdsNFENTRADA.AsFloat ;

        if ((forma_pag <> '') and (forma_pag <> 'R') and
             (dmPdv.qcdsNFVALOR_PAGAR.AsFloat <> dmPdv.qcdsNFENTRADA.AsFloat)) then

        begin
          dmPdv.qcdsFatura.First;

          while not dmPdv.qcdsFatura.eof do
          begin
            if ((dmPdv.qcdsFaturaVALOR.AsFloat > 0) and (dmPdv.qcdsFaturaDATAFATURA.AsDateTime <> dmPdv.qcdsNFDTAEMISSAO.AsDateTime)) then
            begin
              Cobr.Dup.Add;
              if (num_fat < 10) then
                Cobr.Dup.Items[c].nDup  := '00'+IntToStr(num_fat)
              else
                Cobr.Dup.Items[c].nDup  := '0' + IntToStr(num_fat);// cdsFaturaNUMEROFATURA.ASSTRING;
              Cobr.Dup.Items[c].dVenc := dmPdv.qcdsFaturaDATAFATURA.AsDateTime;
              Cobr.Dup.Items[c].vDup  := dmPdv.qcdsFaturaVALOR.AsCurrency;
              num_fat := num_fat + 1;
              Inc ( c );
            end;
            dmPdv.qcdsFatura.next;
          end;
        end;

        if (dmPdv.qcdsFaturaVALOR.AsFloat > 0) then
        begin
          cobr.Fat.nFat  := Trim(dmPdv.qcdsNFNOTASERIE.ASSTRING);
          cobr.Fat.vOrig := vlr_total + dmPdv.qcdsNFVALOR_DESCONTO.AsVariant;

          cobr.Fat.vDesc := RoundTo(dmPdv.qcdsNFVALOR_DESCONTO.AsCurrency, -2);

          cobr.Fat.vLiq  := vlr_total;

        end;

        if (c = 0) then
          Ide.indPag    := ipOutras;

        end;

    if(forma_pag = '' )then
    begin
      ShowMessage('Falta a Forma de Pagamento!');
      Exit
    end;

    with pag.Add do
    begin
      if (Trim(dmPdv.qcdsFaturaFORMAPAGAMENTO.AsString) = '1' )then
      begin
        tPag := fpDinheiro;            // 0
      end;
      if((forma_pag = '2' )or(forma_pag = '3' )or(forma_pag = 'F' )) then
      begin
        tPag := fpCheque;              // 1
      end;
      if((forma_pag = '6' )or(forma_pag = 'I' )or
         (forma_pag = 'K' )or(forma_pag = 'M' ))
      then
      begin
        tPag := fpCartaoCredito;       // 2
      end;
      if((forma_pag = '7' )or(forma_pag = 'J' )or(forma_pag = 'L' )) then
      begin
        tPag := fpCartaoDebito;        // 3
      end;
      if(forma_pag = 'N' )then  // ?
      begin
        tPag := fpCreditoLoja;         // 4
      end;
      if(forma_pag = 'O' )then  // ?
      begin
        tPag := fpValeAlimentacao;     // 5
      end;
      if(forma_pag = 'P' )then  // ?
      begin
        tPag := fpValeRefeicao;        // 6
      end;
      if(forma_pag = 'G' )then  // ?
      begin
        tPag := fpValePresente;        // 7
      end;
      if(forma_pag = 'Q' )then  // ?
      begin
        tPag := fpValeCombustivel;     // 8
      end;
      if(forma_pag = '5' )then
      begin
        tPag := fpDuplicataMercantil;  // 9
      end;
      if(forma_pag = '4' )then
      begin
        tPag := fpBoletoBancario;      //10
      end;
      if(forma_pag = 'R' )then  // ?
      begin
        tPag := fpSemPagamento;        //11
      end;
      if(forma_pag = 'D' )then  // ?
      begin
        tPag := fpTransfBancario;        //11
      end;
      if(forma_pag = '8' )then  // ?
      begin
        tPag := fpDepositoBancario;        //11
      end;
      if((forma_pag = '9') or
         (forma_pag = 'A') or
         (forma_pag = 'B') or
         (forma_pag = 'C') or
         (forma_pag = 'E') or
         (forma_pag = 'H')
      )then
      begin
        tPag := fpDepositoBancario;               //12
      end;
      pTroco := dmPdv.qcdsNFVALOR_PAGAR.AsFloat - dmPdv.qcdsNFVALOR_TOTAL_NOTA.AsVariant;

      if (forma_pag <> 'R' )then
        begin
          if (vlr_total = 0) then
            vPag := dmPdv.qcdsNFVALOR_PAGAR.AsFloat
          else
            vPag := vlr_total;
           if( pTroco > 0.00)then   // manoel
          // pag.vTroco := dmPdv.qcdsNFVALOR_PAGAR.AsFloat - dmPdv.qcdsNFVALOR_TOTAL_NOTA.AsVariant;
          vPag := dmPdv.qcdsNFVALOR_TOTAL_NOTA.AsVariant;
        end;
    end;

  end;
  end;

end;

procedure TfNFe.pegaItens(tpNf: integer);
var strItens: String;
begin
  //Carrega os itens da NF
  if (cbTipoNota.ItemIndex = 0) then
  begin
  strItens := 'select md.CODPRODUTO, md.coddetalhe, md.pIPI, md.vIPI, UDF_ROUNDDEC(md.QUANTIDADE, 4) QUANTIDADE ' +
      ' , md.CFOP, md.PRECO, md.DESCPRODUTO, md.OBS, '+
      'case when udf_Pos(' + quotedstr('-') +', pr.CODPRO) > 0 then udf_Copy(pr.CODPRO, 0, (udf_Pos(' + quotedstr('-') + ', pr.CODPRO)-1)) ' +
      'ELSE pr.CODPRO END as codpro, md.VLR_BASEICMS, md.CSTIPI, md.CSTPIS, md.CSTCOFINS, md.PPIS, md.PCOFINS, ' +
      'md.UN AS UNIDADEMEDIDA , UDF_TRIM(md.CST) CST, md.CSOSN, md.ICMS, md.pIPI, md.vIPI, md.VLR_BASEICMS, ' +
      ' UDF_ROUNDDEC(md.VALOR_ICMS, 2) as VALOR_ICMS, UDF_ROUNDDEC(md.VLR_BASE, 10) as VLR_BASE, ' +
      'UDF_ROUNDDEC(md.ICMS_SUBST, 2) as ICMS_SUBST, md.ICMS_SUBSTD, UDF_ROUNDDEC(md.FRETE, 2) as FRETE, UDF_ROUNDDEC(md.VALOR_DESCONTO, 2) as VALOR_DESCONTO, (md.VLR_BASE * md.QUANTIDADE) as VALTOTAL, ' +
      'UDF_ROUNDDEC(md.VALOR_PIS, 2) as VALOR_PIS, UDF_ROUNDDEC(md.VALOR_COFINS, 2) as VALOR_COFINS, md.VALOR_SEGURO, md.VALOR_OUTROS, UDF_ROUNDDEC(md.II, 2) as II, UDF_ROUNDDEC(md.BCII, 2) as BCII ' +
      ' ,md.NITEMPED, md.PEDIDO, MD.VLRBC_IPI, MD.VLRBC_PIS, md.VLRBC_COFINS, UDF_ROUNDDEC(md.VLRTOT_TRIB, 2) as VLRTOT_TRIB ' +
      ' , pr.COD_BARRA ' +
      ' , md.VBCUFDEST' +
      ' , md.PFCPUFDEST' +
      ' , md.PICMSUFDEST' +
      ' , md.PICMSINTER' +
      ' , md.PICMSINTERPART' +
      ' , UDF_ROUNDDEC(md.VFCPUFDEST,2) as VFCPUFDEST' +
      ' , UDF_ROUNDDEC(md.VICMSUFDEST,2) as VICMSUFDEST' +
      ' , UDF_ROUNDDEC(md.VICMSUFREMET,2) as VICMSUFREMET ' +
      ' , md.CST_IPI_CENQ ' +
      ' , md.CEST ' +
      ' , cp.CODMOVIMENTO ' +
      ' , md.PERCIPIDEVOL ' +
      ' , md.VALORIPIDEVOL ' +
      ' , md.ICMS_PST ' +
      ' , md.V_B_FCP ' +
      ' , md.V_FCP ' +
      ' , md.P_FCP ' +
      ' , md.V_B_FCPST ' +
      ' , md.V_FCPST ' +
      ' , md.P_FCPST ' +
      ' , md.V_B_FCPSTRET ' +
      ' , md.V_FCPSTRET ' +
      ' , md.P_FCPSTRET ' +
      ' , md.VBCSTRET ' +
      ' , md.VICMSSTRET ' +
      ' , md.VBCSTDEST ' +
      ' , md.VICMSSTDEST ' +
      ' , md.VBFCPUFDEST ' +
      ' , pr.pGLP ' +
      ' , pr.pGNn ' +
      ' , pr.vPart ' +
      ' , pr.pGNi ' +
      ' , LOTE ' +
      ' , DTAFAB ' +
      ' , DTAVCTO ' +
      ' , md.CST_IBS_CBS ' +
      ' , md.CCLASSTRIB ' +
      ' , md.P_IBS ' +
      ' , md.P_CBS ' +
      ' , md.REDUCAO_IBS ' +
      ' , md.REDUCAO_CBS ' +

      ' from compra cp  inner join MOVIMENTODETALHE md on md.CODMOVIMENTO = cp.CODMOVIMENTO ' +
      'inner join NOTAFISCAL nf on nf.CODVENDA = cp.CODCOMPRA ' +
      'inner join PRODUTOS pr on pr.CODPRODUTO = md.CODPRODUTO ' +
      'where cp.CODCOMPRA = ' + IntToStr(dmPdv.qcdsNFCODVENDA.AsInteger)  + ' and ((nf.NATUREZA = 20) or (nf.NATUREZA = 21))' ;
  end
  else
  begin
  strItens :=  'select md.CODPRODUTO, md.coddetalhe, UDF_ROUNDDEC(md.QUANTIDADE, 4) QUANTIDADE, ' +
      ' md.PRECO, md.CFOP, md.DESCPRODUTO, ' +
      'case when udf_Pos(' + quotedstr('-') +', pr.CODPRO) > 0 then udf_Copy(pr.CODPRO, 0, ' +
      ' (udf_Pos(' + quotedstr('-') + ', pr.CODPRO)-1)) ' +
      'ELSE pr.CODPRO END as codpro, md.UN AS UNIDADEMEDIDA, UDF_TRIM(md.CST) CST, md.ICMS, md.pIPI, md.OBS, ' +
      'md.vIPI, md.CSOSN, md.VLR_BASEICMS, UDF_ROUNDDEC(md.VALOR_ICMS, 2) as VALOR_ICMS, md.PPIS, md.PCOFINS, ' +
      'UDF_ROUNDDEC(md.VLR_BASE, 10) as VLR_BASE, UDF_ROUNDDEC(md.ICMS_SUBST, 2) as ICMS_SUBST, md.CSTIPI, ' +
      'md.CSTPIS, md.CSTCOFINS, ' +
      'UDF_ROUNDDEC(md.VALOR_PIS, 2) as VALOR_PIS, UDF_ROUNDDEC(md.VALOR_COFINS, 2) as VALOR_COFINS, ' +
      '  UDF_ROUNDDEC(md.FRETE, 2) as FRETE, UDF_ROUNDDEC(md.VALOR_DESCONTO, 2) as VALOR_DESCONTO, ' +
      'md.ICMS_SUBSTD, UDF_ROUNDDEC((md.VLR_BASE * md.QUANTIDADE), 2) as VALTOTAL, md.VALOR_SEGURO, md.VALOR_OUTROS, UDF_ROUNDDEC(md.II, 2) as II, UDF_ROUNDDEC(md.BCII, 2) as BCII ' +
      ' ,md.NITEMPED, md.PEDIDO, MD.VLRBC_IPI, MD.VLRBC_PIS, md.VLRBC_COFINS, UDF_ROUNDDEC(md.VLRTOT_TRIB, 2) as VLRTOT_TRIB' +
      ' ,pr.COD_BARRA' +
      ' , md.VBCUFDEST' +
      ' , md.PFCPUFDEST' +
      ' , md.PICMSUFDEST' +
      ' , md.PICMSINTER' +
      ' , md.PICMSINTERPART' +
      ' ,UDF_ROUNDDEC(md.VFCPUFDEST,2) as VFCPUFDEST' +
      ' , UDF_ROUNDDEC(md.VICMSUFDEST,2) as VICMSUFDEST' +
      ' , UDF_ROUNDDEC(md.VICMSUFREMET,2) as VICMSUFREMET ' +
      ' , md.CST_IPI_CENQ ' +
      ' , md.CEST ' +
      ' , vd.CODMOVIMENTO ' +
      ' , md.PERCIPIDEVOL ' +
      ' , md.VALORIPIDEVOL ' +
      ' , md.ICMS_PST ' +
      ' , md.V_B_FCP ' +
      ' , md.V_FCP ' +
      ' , md.P_FCP ' +
      ' , md.V_B_FCPST ' +
      ' , md.V_FCPST ' +
      ' , md.P_FCPST ' +
      ' , md.V_B_FCPSTRET ' +
      ' , md.V_FCPSTRET ' +
      ' , md.P_FCPSTRET ' +
      ' , md.VBCSTRET ' +
      ' , md.VICMSSTRET ' +
      ' , md.VBCSTDEST ' +
      ' , md.VICMSSTDEST ' +
      ' , md.VBFCPUFDEST ' +
      ' , pr.pGLP ' +
      ' , pr.pGNn ' +
      ' , pr.vPart ' +
      ' , pr.pGNi ' +
      ' , LOTE ' +
      ' , DTAFAB ' +
      ' , DTAVCTO ' +
      ' , md.CST_IBS_CBS ' +
      ' , md.CCLASSTRIB ' +
      ' , md.P_IBS ' +
      ' , md.P_CBS ' +
      ' , md.REDUCAO_IBS ' +
      ' , md.REDUCAO_CBS ' +
      ' from VENDA vd inner join MOVIMENTODETALHE md on md.CODMOVIMENTO = vd.CODMOVIMENTO ' +
      'inner join NOTAFISCAL nf on nf.CODVENDA = vd.CODVENDA ' +
      'inner join PRODUTOS pr on pr.CODPRODUTO = md.CODPRODUTO ' +
      'where vd.CODVENDA = ' + IntToStr(dmPdv.qcdsNFCODVENDA.AsInteger)  + ' and ((nf.NATUREZA = 12) or (nf.NATUREZA = 15) or (nf.NATUREZA = 16))' ;
  end;

  if (dmPdv.cdsItensNF.Active) then
    dmPdv.cdsItensNF.Close;

  dmPdv.cdsItensNF.SQL.Text := strItens;
  dmPdv.cdsItensNF.Open;


end;

procedure TfNFe.pegaTributos(codMov: Integer; codProd: Integer);
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
      ' SUM(TRIB_FED) ' +
      ' , SUM(TRIB_EST) ' +
      ' , SUM(TRIB_MUN) ' +
      ' FROM TOTAL_TRIBUTOS(' +
      IntToStr(codMov) + ')';
  end;
  if (dmPdv.sqlTotal_tributos.Active) then
    dmPdv.sqlTotal_tributos.Close;
  dmPdv.sqlTotal_tributos.SQL.Clear;
  dmPdv.sqlTotal_tributos.SQL.Add(pegaTribSql);
  dmPdv.sqlTotal_tributos.Open;


end;

procedure TfNFe.getEmpresa;
begin
 with ACBrNFe1.NotasFiscais.Items[0].NFe do
  begin
    Emit.CNPJCPF           := RemoveChar(Trim(dmPdv.qsEmpresaCNPJ_CPF.AsString));
    Emit.xNome             := Trim(dmPdv.qsEmpresaRAZAO.AsString);
    Emit.xFant             := Trim(dmPdv.qsEmpresaEMPRESA.AsString);
    Emit.EnderEmit.xLgr    := Trim(dmPdv.qsEmpresaENDERECO.AsString);
    Emit.EnderEmit.nro     := Trim(dmPdv.qsEmpresaNUMERO.AsString);
    if ((not dmPdv.qsEmpresaOUTRAS_INFO.IsNull) or (Trim(dmPdv.qsEmpresaOUTRAS_INFO.AsString) <> '')) then
      Emit.EnderEmit.xCpl  := Trim(dmPdv.qsEmpresaLOGRADOURO.AsString);
    Emit.EnderEmit.xBairro := Trim(dmPdv.qsEmpresaBAIRRO.AsString);
    Emit.EnderEmit.cMun    := StrToInt(RemoveChar(Trim(dmPdv.qsEmpresaCD_IBGE.AsString)));
    Emit.EnderEmit.xMun    := Trim(dmPdv.qsEmpresaCIDADE.AsString);
    Emit.EnderEmit.UF      := Trim(dmPdv.qsEmpresaUF.AsString);
    if (not dmPdv.qsEmpresaCEP.IsNull) then
      Emit.EnderEmit.CEP     := StrToInt(RemoveChar(Trim(dmPdv.qsEmpresaCEP.AsString)));
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';
    Emit.EnderEmit.fone    := Trim(dmPdv.qsEmpresaDDD.AsString) + Trim(dmPdv.qsEmpresaFONE.AsString);
    Emit.IE                := RemoveChar(Trim(dmPdv.qsEmpresaIE_RG.AsString));
    if (dmPdv.qsEmpresaCRT.AsInteger = 0) Then
      Emit.CRT               := crtSimplesNacional
    else if (dmPdv.qsEmpresaCRT.AsInteger = 1) Then
      Emit.CRT               := crtSimplesExcessoReceita
    else if (dmPdv.qsEmpresaCRT.AsInteger = 2) Then
      Emit.CRT               := crtRegimeNormal;
  end;
end;

procedure TfNFe.abrirEmpresa;
var a, v_semp: String;
begin
  //if (dmPdv.qcds_ccusto.Active) then
  //  dmPdv.qcds_ccusto.Close;
  // dmPdv.qcds_ccusto.Params[0].AsString := conta_local;
  //dmPdv.qcds_ccusto.sql.Clear;
  v_semp := 'select CODIGO, CONTA, NOME from PLANO ' +
    ' WHERE CONTAPAI = ' + QuotedStr(Trim(conta_local)) +
    '   AND CONSOLIDA = ' + QuotedStr('S');
 // dmPdv.qcds_ccusto.sql.Add(v_semp);


  //ComboBox1.ItemIndex := 0 ;
  ///*
  //if (PageControl1.ActivePageIndex = 0) then
  begin
    if(ComboBox1.Text <> '') then
    begin
      v_semp += ' AND NOME = ' + QuotedStr(Trim(ComboBox1.Text));
    end;
  end;

  //if (PageControl1.ActivePageIndex = 1) then
  {begin
    if(ComboBox2.Text = '') then
    begin
      MessageDlg('Centro de custo não selecionado', mtError, [mbOK], 0);
    end;
    v_semp += ' AND NOME = ' + QuotedStr(Trim(ComboBox2.Text));
  end;

  //if (PageControl1.ActivePageIndex = 3) then
  begin
    if(cbEmpresa.Text = '') then
    begin
      MessageDlg('Centro de custo não selecionado', mtError, [mbOK], 0);
    end;
    v_semp += ' AND NOME = ' + QuotedStr(Trim(cbEmpresa.Text));
  end;}

  ///
  //dmPdv.qcds_ccusto.SQL.Add(v_semp);
  //dmPdv.qcds_ccusto.Open;
  dmPdv.busca_sql(v_semp);
  v_semp := IntToStr(dmPdv.sqBusca.FieldByName('CODIGO').AsInteger);
  //Seleciona Empresa de acordo com o CCusto selecionado
  if (dmPdv.qsEmpresa.Active) then
    dmPdv.qsEmpresa.Close;
  //if (dmPdv.qcds_ccusto.IsEmpty) then
  if (dmPdv.sqBusca.IsEmpty) then
    dmPdv.qsEmpresa.Params[0].AsInteger := 0
  else
    dmPdv.qsEmpresa.Params[0].AsInteger := dmPdv.sqBusca.FieldByName('CODIGO').AsInteger;
  a := IntToStr(dmPdv.sqBusca.FieldByName('CODIGO').AsInteger);
  dmPdv.qsEmpresa.Open;
  fNFe.Caption := dmPdv.qsEmpresaEMPRESA.AsString;
end;

procedure TfNFe.getCli_Fornec;
var
  IERG : integer;
  ver_str:String;
begin
  pSuframa := '';
  vTipoFiscal := '';
  with ACBrNFe1.NotasFiscais.Items[0].NFe do
  begin
    //Carrega dados do Destinatário
    // FORNECEDOR
    if (cbTipoNota.ItemIndex = 0) then
    begin
      Dest.CNPJCPF           := RemoveChar(Trim(dmPdv.qsFornecCNPJ.AsString));
      Dest.xNome             := Trim(dmPdv.qsFornecRAZAOSOCIAL.AsString);
      Dest.EnderDest.xLgr    := Trim(dmPdv.qsFornecLOGRADOURO.AsString);
      if ((dmPdv.qsFornecNUMERO.IsNull) or (Trim(dmPdv.qsFornecNUMERO.AsString) = '')) then
      begin
        Dest.EnderDest.nro     := 'S/N';
      end
      else
        Dest.EnderDest.nro     := Trim(dmPdv.qsFornecNUMERO.AsString);
      if ((not dmPdv.qsFornecCOMPLEMENTO.IsNull) or (Trim(dmPdv.qsFornecCOMPLEMENTO.AsString) <> '')) then
        Dest.EnderDest.xCpl    := Trim(dmPdv.qsFornecCOMPLEMENTO.AsString);
      Dest.EnderDest.xBairro := Trim(dmPdv.qsFornecBAIRRO.AsString);
      if (trim(dmPdv.qsFornecCD_IBGE.AsString) = '') then
      begin
        MessageDlg('Fornecedor' + dmPdv.qsFornecRAZAOSOCIAL.AsString +  'sem Código do IBGE.', mtWarning, [mbOK], 0);
        Exit;
      end
      else
        Dest.EnderDest.cMun    := StrToInt(RemoveChar(Trim(dmPdv.qsFornecCD_IBGE.AsString)));
      Dest.EnderDest.xMun    := Trim(dmPdv.qsFornecCIDADE.AsString);
      Dest.EnderDest.UF      := Trim(dmPdv.qsFornecUF.AsString);
      if (trim(dmPdv.qsFornecCEP.AsString) = '') then
      begin
        MessageDlg('Fornecedor' + dmPdv.qsFornecRAZAOSOCIAL.AsString +  'sem CEP.', mtWarning, [mbOK], 0);
        Exit;
      end
      else
        Dest.EnderDest.CEP     := StrToInt(RemoveChar(Trim(dmPdv.qsFornecCEP.AsString)));

      if (trim(dmPdv.qsFornecCODPAIS.AsString) = '') then
      begin
        MessageDlg('Fornecedor' + dmPdv.qsFornecRAZAOSOCIAL.AsString +  'sem PAIS.', mtWarning, [mbOK], 0);
        Exit;
      end
      else
        Dest.EnderDest.cPais   := StrToInt(Trim(dmPdv.qsFornecCODPAIS.asString));
      Dest.EnderDest.xPais   := Trim(dmPdv.qsFornecPAIS.AsString);
      Dest.EnderDest.Fone    := Trim(dmPdv.qsFornecDDD.AsString) + Trim(dmPdv.qsFornecTELEFONE.AsString);
      IERG := 0;
      IERG := StrLen(PChar(RemoveChar(Trim(dmPdv.qsFornecINSCESTADUAL.AsString))));
      if ((dmPdv.qsFornecTIPOFIRMA.AsInteger = 0) and (Trim(dmPdv.qsFornecCODFISCAL.AsString) = '9')) then
      begin
        IERG := 0;
      end;
      if (Trim(dmPdv.qsFornecCODFISCAL.AsString) = '9') then
      begin
        vTipoFiscal := '9';
      end;

      if (IERG = 0) then
      begin
        Dest.indIEDest := inNaoContribuinte;
      end
      else begin
        if (Trim(dmPdv.qsFornecINSCESTADUAL.AsString) = 'ISENTO') then
        begin
          Dest.indIEDest := inIsento;
        end
        else begin
          Dest.indIEDest := inContribuinte; //, inIsento, inNaoContribuinte
          if ((Trim(dmPdv.qsFornecUF.AsString) = 'SP') or (Trim(dmPdv.qsFornecUF.AsString) = 'MG')) then
          begin
            if (IERG > 11) then
            begin
              Dest.IE := RemoveChar(Trim(dmPdv.qsFornecINSCESTADUAL.AsString));
            end;
            if (Trim(dmPdv.qsFornecUF.AsString) = 'MG') then
            begin
              ver_str := AddChar('0', RemoveChar(Trim(dmPdv.qsFornecINSCESTADUAL.AsString)), 13);
              Dest.IE := ver_str;
            end
          end
          else begin
            if (Trim(dmPdv.qsFornecUF.AsString) <> 'EX') then
            begin
              if (IERG >= 5) then
                Dest.IE := RemoveChar(Trim(dmPdv.qsFornecINSCESTADUAL.AsString));
            end;
          end;
        end;
      end;
    end
    //CLIENTE
    else
    begin

      if (Trim(dmPdv.qsClienteUF.AsString) <> 'EX') then
        Dest.CNPJCPF := RemoveChar(Trim(dmPdv.qsClienteCNPJ.AsString));
      Dest.xNome             := Trim(dmPdv.qsClienteRAZAOSOCIAL.AsString);

      lblMsgSuframa.Caption := Trim(dmPdv.qsClienteSUFRAMA.AsString);
      if (Length(Trim(dmPdv.qsClienteSUFRAMA.AsString)) = 9) then
      begin
        pSuframa  := Trim(dmPdv.qsClienteSUFRAMA.AsString);
        Dest.ISUF := Trim(dmPdv.qsClienteSUFRAMA.AsString);
        lblMsgSuframa.Caption := lblMsgSuframa.Caption + ' SUFRAMA';
      end;
      Dest.EnderDest.xLgr := Trim(dmPdv.qsClienteLOGRADOURO.AsString);

      if ((dmPdv.qsClienteNUMERO.IsNull) or (Trim(dmPdv.qsClienteNUMERO.AsString) = '')) then
      begin
        Dest.EnderDest.nro     := 'S/N';
      end
      else
        Dest.EnderDest.nro     := Trim(dmPdv.qsClienteNUMERO.AsString);
      if ((not dmPdv.qsClienteCOMPLEMENTO.IsNull) or ( Trim(dmPdv.qsClienteCOMPLEMENTO.AsString) <> '')) then
        Dest.EnderDest.xCpl    := Trim(dmPdv.qsClienteCOMPLEMENTO.AsString);
      Dest.EnderDest.xBairro := Trim(dmPdv.qsClienteBAIRRO.AsString);

      if (trim(dmPdv.qsClienteCD_IBGE.AsString) = '') then
      begin
        MessageDlg('Cliente' + dmPdv.qsClienteRAZAOSOCIAL.AsString +  'sem Código do IBGE.', mtWarning, [mbOK], 0);
        Exit;
      end
      else
        Dest.EnderDest.cMun    := StrToInt(RemoveChar(Trim(dmPdv.qsClienteCD_IBGE.AsString)));

      Dest.EnderDest.xMun    := Trim(dmPdv.qsClienteCIDADE.AsString);
      Dest.EnderDest.UF      := Trim(dmPdv.qsClienteUF.AsString);

      if (RemoveChar(Trim(dmPdv.qsClienteCEP.AsString)) = '') then
      begin
        MessageDlg('Cliente' + dmPdv.qsClienteRAZAOSOCIAL.AsString +  ' sem CEP.', mtWarning, [mbOK], 0);
        Exit;
      end
      else
        Dest.EnderDest.CEP     := StrToInt(RemoveChar(Trim(dmPdv.qsClienteCEP.AsString)));
      if (Trim(dmPdv.qsClienteCODPAIS.AsString) = '') then
      begin
        MessageDlg('Código do Pais não informado.', mtWarning, [mbOK], 0);
        Exit;
      end;
      Dest.EnderDest.cPais   := StrToInt(Trim(dmPdv.qsClienteCODPAIS.AsString));
      Dest.EnderDest.xPais   := Trim(dmPdv.qsClientePAIS.AsString);
      Dest.EnderDest.Fone    := Trim(dmPdv.qsClienteDDD.AsString) + Trim(dmPdv.qsClienteTELEFONE.AsString);
      if (Trim(dmPdv.qsClienteINSCESTADUAL.AsString) = 'ISENTO') then
      begin
        //Dest.indIEDest := inIsento;
      end
      else begin
        IERG := 0;
        IERG := StrLen(PChar(RemoveChar(Trim(dmPdv.qsClienteINSCESTADUAL.AsString))));
        if ((dmPdv.qsClienteTIPOFIRMA.AsInteger = 0)
          and (Trim(dmPdv.qsClienteCODFISCAL.AsString) = '9')
          and (Trim(dmPdv.qsClienteTEM_IE.AsString) <> 'S')) then
        begin
          IERG := 0;
        end;
        if (Trim(dmPdv.qsClienteCODFISCAL.AsString) = '9') then
        begin
          vTipoFiscal := '9';
        end;

        if (IERG = 0) then
        begin
          //Dest.indIEDest := inNaoContribuinte;
        end
        else begin
          { 20/07/16 fazendo nada
          if (sClienteTem_IE.AsString = 'S') then
          begin
            //Dest.indIEDest := inNaoContribuinte;
          end
          else begin
            //Dest.indIEDest := inContribuinte;
          end;
          //Dest.indIEDest := inContribuinte; //, inIsento, inNaoContribuinte
          }
          if ((Trim(dmPdv.qsClienteUF.AsString) = 'SP') or (Trim(dmPdv.qsClienteUF.AsString) = 'MG')) then
          begin
            if (IERG > 11) then
            begin
              Dest.IE := RemoveChar(Trim(dmPdv.qsClienteINSCESTADUAL.AsString));
            end;
            if (Trim(dmPdv.qsClienteUF.AsString) = 'MG') then
            begin
              ver_str := AddChar('0', RemoveChar(Trim(dmPdv.qsClienteINSCESTADUAL.AsString)), 13);
              Dest.IE := ver_str;
            end;
          end
          else begin
            if (Trim(dmPdv.qsClienteUF.AsString) <> 'EX') then
            begin
              if (IERG >= 5) then
                Dest.IE := RemoveChar(Trim(dmPdv.qsClienteINSCESTADUAL.AsString));
            end;
          end;
        end;


      end;
      //if (sClienteUF.AsString = 'EX') then
      //begin
      //  Dest.indIEDest := inNaoContribuinte;
      //end;
      if (Trim(dmPdv.qcdsNFIND_IEDEST.AsString) = 'inNaoContribuinte') then
        Dest.indIEDest := inNaoContribuinte
      else
        Dest.indIEDest := inContribuinte;
      if (Trim(dmPdv.qcdsNFIND_IEDEST.AsString) = 'inIsento') then
        Dest.indIEDest := inIsento;

      // ENDERECO ENTREGA
      if (dmPdv.qcds_parametro.Active) then
         dmPdv.qcds_parametro.Close;
      dmPdv.qcds_parametro.Params[0].AsString := 'NFE_END_ENTREGA';
      dmPdv.qcds_parametro.Open;
      if (trim(dmPdv.qcds_parametroCONFIGURADO.AsString) = 'S') then
      begin
        if (dmPdv.qsEndEntrega.Active) then
          dmPdv.qsEndEntrega.Close;
        dmPdv.qsEndEntrega.Params[0].AsInteger := dmPdv.qcdsNFCODCLIENTE.AsInteger;
        dmPdv.qsEndEntrega.Open;
        if not dmPdv.qsEndEntrega.IsEmpty then
        begin
          Entrega.CNPJCPF := RemoveChar(Trim(dmPdv.qsClienteCNPJ.AsString));
          Entrega.xLgr := Trim(dmPdv.qsEndEntregaLOGRADOURO.AsString);
          Entrega.nro := Trim(dmPdv.qsEndEntregaNUMERO.AsString);
          Entrega.xBairro := Trim(dmPdv.qsEndEntregaBAIRRO.AsString);
          Entrega.cMun := StrToInt(RemoveChar(dmPdv.qsClienteCD_IBGE.AsString));
          Entrega.xMun := Trim(dmPdv.qsEndEntregaCIDADE.AsString);
          Entrega.UF := Trim(dmPdv.qsEndEntregaUF.AsString);
          Entrega.CEP := StrToInt(RemoveChar(Trim(dmPdv.qsClienteCEP.AsString)));
        end;
      end;

    end;
  end;


end;

procedure TfNFe.getItens(contador: integer);
var
  BC, BCST, desc : Variant;
  cst_parte: String;
  inf_add_prd, prd : String;
  nfe_itens_tottrib ,vu, valun ,vt, vUnTrib: String;
  ver_valor : Double;
  IBSCBS: TIBSCBS;
  //LcClassTrib: TcClassTrib;
  LCST      : TCSTIBSCBS;
 // Produto: TDetCollectionItem;
begin
  BC := 0;
  BCST := 4;
  with ACBrNFe1.NotasFiscais.Items[0].NFe do
  begin
    with Det.Add do
    begin
      if (not dmPdv.cdsItensNFPEDIDO.IsNull) then
        Prod.xPed := Trim(dmPdv.cdsItensNFPEDIDO.AsString);
      if (not dmPdv.cdsItensNFNITEMPED.IsNull) then
        Prod.nItemPed := IntToStr(dmPdv.cdsItensNFNITEMPED.AsInteger);
      if (dmPdv.qsCFOP.Active) then
        dmPdv.qsCFOP.Close;
      dmPdv.qsCFOP.Params[1].AsString := Trim(dmPdv.cdsItensNFCFOP.AsString);
      if (cbTipoNota.ItemIndex = 1) then
        dmPdv.qsCFOP.Params[0].AsString := Trim(dmPdv.qsClienteUF.AsString)
      else
        dmPdv.qsCFOP.Params[0].AsString := Trim(dmPdv.qsFornecUF.AsString);
      dmPdv.qsCFOP.Open;

      Prod.nItem    := contador;
      if (mascaraProduto <> '') then
        Prod.cProd    := FormatMaskText(mascaraProduto+';0;_', Trim(dmPdv.cdsItensNFCODPRO.AsString))
      else
        Prod.cProd    := Trim(dmPdv.cdsItensNFCODPRO.AsString);

      Prod.xProd    := LeftStr(Trim(dmPdv.cdsItensNFDESCPRODUTO.AsString), 99);
      Prod.CFOP     := Trim(dmPdv.cdsItensNFCFOP.AsString);
      Prod.uCom     := Trim(dmPdv.cdsItensNFUNIDADEMEDIDA.AsString);
      Prod.qCom     := dmPdv.cdsItensNFQUANTIDADE.AsFloat;
      ver_valor     := dmPdv.cdsItensNFVLR_BASE.AsFloat;


      ACBrNFeDANFeRL1.CasasDecimais.vUnCom := danfeDec;
      Case danfeDec of
         2 : vu := ',0.00';
         3 : vu := ',0.000';
         4 : vu := ',0.0000';
         5 : vu := ',0.00000';
         6 : vu := ',0.000000';
         7 : vu := ',0.0000000';
         8 : vu := ',0.00000000';
      end;

      // Prod.vUnCom   := dmPdv.cdsItensNFVLR_BASE.AsFloat;
      valun  :=  formatfloat(vu,dmPdv.cdsItensNFVLR_BASE.Value);
      Prod.vUnCom := StrToFloat(StringReplace(valun, '.', '', [rfReplaceAll]));

      Prod.uTrib    := Trim(dmPdv.qsProdutosUNIDADEMEDIDA.AsString);
      Prod.qTrib    := dmPdv.cdsItensNFQUANTIDADE.AsFloat;

      ACBrNFeDANFeRL1.CasasDecimais.vUnCom := danfeDec;
      Case danfeDec of
         2 : vt := ',0.00';
         3 : vt := ',0.000';
         4 : vt := ',0.0000';
         5 : vt := ',0.00000';
         6 : vt := ',0.000000';
         7 : vt := ',0.0000000';
         8 : vt := ',0.00000000';
      end;

      //Prod.vUnTrib  := dmPdv.cdsItensNFVLR_BASE.AsFloat;
      vUnTrib  :=  formatfloat(vt,dmPdv.cdsItensNFVLR_BASE.Value);
      Prod.vUnTrib  :=  StrToFloat(StringReplace(vUnTrib, '.', '', [rfReplaceAll]));



      if((Trim(dmPdv.cdsItensNFLOTE.AsString) <> '0')and(Trim(dmPdv.cdsItensNFLOTE.AsString) <> '')) then
      begin
        with prod.rastro.Add do
        begin
          nLote  := Trim(dmPdv.cdsItensNFLOTE.AsString);
          qLote  := dmPdv.cdsItensNFQUANTIDADE.AsFloat;
          dFab   := dmPdv.cdsItensNFDTAFAB.AsDateTime;
          dVal   := dmPdv.cdsItensNFDTAVCTO.AsDateTime;
          cAgreg := Trim(dmPdv.cdsItensNFCODPRO.AsString);
        end;
      end;

      prd := dmPdv.cdsItensNFCOD_BARRA.AsString ;

      if (EAN13Valido(Trim(dmPdv.cdsItensNFCOD_BARRA.AsString))) then
      begin
        Prod.cEAN     := Trim(dmPdv.cdsItensNFCOD_BARRA.AsString);
        Prod.cEANTrib := Trim(dmPdv.cdsItensNFCOD_BARRA.AsString);
      end else
      begin
        Prod.cEAN     := 'SEM GTIN';
        Prod.cEANTrib := 'SEM GTIN';
      end;

      desc := StrLen(PChar(MidStr(Trim(dmPdv.cdsItensNFDESCPRODUTO.AsString), 100, 200)));
      if ( desc > 0) then
        inf_add_prd := MidStr(Trim(dmPdv.cdsItensNFDESCPRODUTO.AsString), 100, 200)  + Trim(dmPdv.cdsItensNFOBS.AsString)
      else
        inf_add_prd := inf_add_prd + Trim(dmPdv.cdsItensNFOBS.AsString);
      //if ((cdsItensNFVLRTOT_TRIB.AsFloat > 0) and (dm.vTipoFiscal = '9'))  then
      if (dmPdv.cdsItensNFVLRTOT_TRIB.AsFloat > 0)  then
      begin
        pegaTributos(dmPdv.cdsItensNFCODMOVIMENTO.AsInteger, dmPdv.cdsItensNFCODPRODUTO.AsInteger);
        nfe_itens_tottrib := 'Trib aprox R$:' +
          format('%8.2n', [dmPdv.sqlTotal_tributos.Fields[1].AsFloat]) + '-Fed, ' +
          format('%8.2n', [dmPdv.sqlTotal_tributos.Fields[2].AsFloat]) + '-Est e ' +
          format('%8.2n', [dmPdv.sqlTotal_tributos.Fields[3].AsFloat]) + '-Mun ';
        nfe_itens_tottrib := nfe_itens_tottrib + 'Fonte:'+
          dmPdv.sqlTotal_tributos.Fields[7].AsString + '-' +
          dmPdv.sqlTotal_tributos.Fields[8].AsString;//Fonte: IBPT/FECOMERCIO RJ Xe67eQ
        inf_add_prd := inf_add_prd + ' ' + nfe_itens_tottrib;
      end;
      infAdProd := inf_add_prd;
      Prod.NCM      := Trim(dmPdv.qsProdutosNCM.AsString);
      if (Trim(dmPdv.cdsItensNFCEST.AsString) <> '') then
        Prod.CEST := Trim(dmPdv.cdsItensNFCEST.AsString);
      Prod.vProd  := dmPdv.cdsItensNFVALTOTAL.AsFloat;
      Prod.vFrete := dmPdv.cdsItensNFFRETE.AsCurrency;

      if (dmPdv.cdsItensNFVALOR_DESCONTO.AsCurrency > 0) then
        Prod.vDesc    := RoundTo(dmPdv.cdsItensNFVALOR_DESCONTO.AsCurrency, -2);

      Prod.vOutro   := dmPdv.cdsItensNFVALOR_OUTROS.AsCurrency;
      Prod.vSeg     := dmPdv.cdsItensNFVALOR_SEGURO.AsCurrency;

      if (dmPdv.cdsItensNFVALORIPIDEVOL.AsFloat > 0) then
      begin
        totIPIDevol := totIPIDevol + dmPdv.cdsItensNFVALORIPIDEVOL.AsFloat;
        vIPIDevol := dmPdv.cdsItensNFVALORIPIDEVOL.AsFloat;
        pDevol := dmPdv.cdsItensNFPERCIPIDEVOL.AsFloat;
      end;

      if(dmPdv.qsFornec.Active) then
        if (Trim(dmPdv.qsFornecUF.AsString) = 'EX') then
        begin
          if(dmPdv.sAdicao.Active) then
            dmPdv.sAdicao.Close;
          dmPdv.sAdicao.Params[0].AsInteger := dmPdv.cdsItensNFCODDETALHE.AsInteger;
          dmPdv.sAdicao.Open;
          if(dmPdv.sDI.Active) then
            dmPdv.sDI.Close;
          dmPdv.sDi.Params[0].AsInteger := dmPdv.sAdicaoADIC_CODDI.AsInteger;
          dmPdv.sDI.Open;
          with prod.DI.Add do
          begin
            nDi         := Trim(dmPdv.sDIDI_NUMDI.AsString);
            dDi         := dmPdv.sDIDI_DATA.AsDateTime;
            xLocDesemb  := Trim(dmPdv.sDIDI_LOCALDESEMB.AsString);
            UFDesemb    := Trim(dmPdv.sDIDI_UFDESEMB.AsString);
            dDesemb     := dmPdv.sDIDI_DATADESEMB.AsDateTime;
            cExportador := Trim(dmPdv.sDIDI_CODEXPORTADOR.AsString);
            with adi.Add do
            begin
              nAdicao     := dmPdv.sAdicaoADIC_NADICAO.AsInteger;
              nSeqAdi     := dmPdv.sAdicaoADIC_NSEQUEN.AsInteger;
              cFabricante := Trim(dmPdv.sAdicaoADIC_CODFAB.AsString);
              vDescDI     := dmPdv.sAdicaoADIC_VDESC.AsInteger;
            end;
          end;
        end;

        if (dmPdv.sdsProd_Comb.Active) then
          dmPdv.sdsProd_Comb.Close;
        dmPdv.sdsProd_Comb.Params[0].AsInteger := dmPdv.cdsItensNFCODPRODUTO.AsInteger;
        dmPdv.sdsProd_Comb.Open;

        if (not dmPdv.sdsProd_Comb.IsEmpty) then
        begin
          with prod.comb do
          begin
            try
              cProdANP := StrToInt(Trim(dmPdv.sdsProd_CombCPRODANP.AsString));
            except
              MessageDlg('O Código tem que ser Númerico.', mtWarning, [mbOK], 0);
              exit;
            end;
           {incluido 02/05/2025}
           descANP  := Trim(dmPdv.sdsProd_CombEMBALAGEM.AsString);
           UFcons := ufDest;


           {incluido 02/05/2025}


           { comentado dia 02/07/2025

            //pMixGN := sdsProd_CombPMIXGN.AsFloat;  // removido 27/07/18
            UFcons := ufDest;
           // CODIF := '0';      // removido 30/07/18
            qTemp := dmPdv.cdsItensNFQUANTIDADE.AsFloat;

            // incluido 27/07/18
            Prod.comb.descANP := Trim(dmPdv.cdsItensNFOBS.AsString);
              //-- Percentual de GLP --
            pGLP  := dmPdv.cdsItensNFPGLP.AsCurrency; // 60.00
            //-- Percentual de Gás Natural --
            pGNn  := dmPdv.cdsItensNFPGNN.AsCurrency; // 40.00 ;
            vPart := dmPdv.cdsItensNFVPART.AsCurrency; // 10.00 ;
            pGNi  := dmPdv.cdsItensNFPGNI.AsCurrency; // 0.00;
            // incluido 27/07/18
             comentado dia 02/07/2025 }
          end;
        end;



      //Prod.genero   := sProdutosGENERO.AsInteger;
      //IMPOSTOS Do Produto

      with Imposto do
      begin
        Imposto.vTotTrib := dmPdv.cdsItensNFVLRTOT_TRIB.AsCurrency;

        Imposto.IPI.cEnq := trim(dmPdv.cdsItensNFCST_IPI_CENQ.AsString);
        with IPI do
        begin
          if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '00') then
            CST := ipi00
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '01') then
            CST := ipi01
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '02') then
            CST := ipi02
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '03') then
            CST := ipi03
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '04') then
            CST :=  ipi04
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '05') then
            CST :=  ipi05
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '49') then
            CST :=  ipi49
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '50') then
            CST := ipi50
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '51') then
            CST := ipi51
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '52') then
            CST := ipi52
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '53') then
            CST := ipi53
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '54') then
            CST := ipi54
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '55') then
            CST := ipi55
          else if (Trim(dmPdv.cdsItensNFCSTIPI.AsString) = '99') then
            CST := ipi99
          else
            CST := ipi00;

          vBC  := dmPdv.cdsItensNFVLRBC_IPI.AsCurrency;
          pIPI := dmPdv.cdsItensNFpIPI.AsCurrency;
          vIPI := dmPdv.cdsItensNFvIPI.AsCurrency;
        end;
        with ICMS do
        begin
          // Verifica Origem do Produto
          if (dmPdv.qsProdutosORIGEM.IsNull) then
            MessageDlg('Origem do Produto não definida', mtError, [mbOK], 0);

          //CSOSN PREENCHIDO APENAS QUANDO EMPRESA OPTANTE PELO SIMPLES.
          //101 - Tributada pelo Simples Nacional com permissão de crédito - Classificam-se neste código as operações que permitem a indicação da alíquota do ICMS devido no Simples Nacional e o valor do crédito correspondente.
          //102 - Tributada pelo Simples Nacional sem permissão de crédito - Classificam-se neste código as operações que não permitem a indicação da alíquota do ICMS devido pelo Simples Nacional e do valor do crédito, e não estejam abrangidas nas hipóteses dos códigos 103, 203, 300, 400, 500 e 900.
          //103 - Isenção do ICMS no Simples Nacional para faixa de receita bruta - Classificam-se neste código as operações praticadas por optantes pelo Simples Nacional contemplados com isenção concedida para faixa de receita bruta nos termos da Lei Complementar nº 123, de 2006.
          //201 - Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS por substituição tributária - Classificam-se neste código as operações que permitem a indicação da alíquota do ICMS devido pelo Simples Nacional e do valor do crédito, e com cobrança do ICMS por substituição tributária.
          //202 - Tributada pelo Simples Nacional sem permissão de crédito e com cobrança do ICMS por substituição tributária - Classificam-se neste código as operações que não permitem a indicação da alíquota do ICMS devido pelo Simples Nacional e do valor do crédito, e não estejam abrangidas nas hipóteses dos códigos 103, 203, 300, 400, 500 e 900, e com cobrança do ICMS por substituição tributária.
          //203 - Isenção do ICMS no Simples Nacional para faixa de receita bruta e com cobrança do ICMS por substituição tributária - Classificam-se neste código as operações praticadas por optantes pelo Simples Nacional contemplados com isenção para faixa de receita bruta nos termos da Lei Complementar nº 123, de 2006, e com cobrança do ICMS por substituição tributária.
          //300 - Imune - Classificam-se neste código as operações praticadas por optantes pelo Simples Nacional contempladas com imunidade do ICMS.
          //400 - Não tributada pelo Simples Nacional - Classificam-se neste código as operações praticadas por optantes pelo Simples Nacional não sujeitas à tributação pelo ICMS dentro do Simples Nacional.
          //500 - ICMS cobrado anteriormente por substituição tributária (substituído) ou por antecipação - Classificam-se neste código as operações sujeitas exclusivamente ao regime de substituição tributária na condição de substituído tributário ou no caso de antecipações.
          //900 - Outros - Classificam-se neste código as demais operações que não se enquadrem nos códigos 101, 102, 103, 201, 202, 203, 300, 400 e 500.
          if(dmPdv.qsEmpresaCRT.AsInteger = 0) then
          begin
            cst_parte := '00';
            if ((Trim(dmPdv.cdsItensNFCSOSN.AsString) = null) or (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '')) then
            begin
              CSOSN := csosnVazio;
            end
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '101') then
            begin
              CSOSN := csosn101;
              if (ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional ) then
              begin
                if (dmPdv.cdsItensNFICMS.AsVariant > 0 ) then
                begin
                  pCredSN := dmPdv.cdsItensNFICMS.AsVariant; //Aliquota ICMS SIMPLES
                  vCredICMSSN := dmPdv.cdsItensNFVALOR_ICMS.AsVariant; //ICMS SIMPLES
                end;
              end;
            end
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '102') then
              CSOSN := csosn102
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '103') then
              CSOSN := csosn103
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '201') then
            begin
              CSOSN := csosn201;
              vBCFCPST := dmPdv.cdsItensNFV_B_FCPST.Value;
              pFCPST   := dmPdv.cdsItensNFP_FCPST.Value;
              vFCPST   := dmPdv.cdsItensNFV_FCPST.Value;
              if (ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional ) then
              begin
                if (dmPdv.cdsItensNFICMS.AsVariant > 0 ) then
                begin
                  pCredSN     := dmPdv.cdsItensNFICMS.AsVariant; //Aliquota ICMS SIMPLES
                  vCredICMSSN := dmPdv.cdsItensNFVALOR_ICMS.AsVariant; //ICMS SIMPLES
                end;
              end;
            end
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '202') then
            begin
              CSOSN := csosn202;
              vBCFCPST := dmPdv.cdsItensNFV_B_FCPST.Value;
              pFCPST   := dmPdv.cdsItensNFP_FCPST.Value;
              vFCPST   := dmPdv.cdsItensNFV_FCPST.Value;
            end
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '203') then
              CSOSN := csosn203
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '300') then
              CSOSN := csosn300
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '400') then
              CSOSN := csosn400
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '500') then
            begin
              CSOSN            := csosn500;
              pST              := dmPdv.cdsItensNFICMS_PST.Value;
              vBCFCPSTRet      := dmPdv.cdsItensNFV_B_FCPSTRET.Value;
              pFCPSTRet        := dmPdv.cdsItensNFP_FCPSTRET.Value;
              vFCPSTRet        := dmPdv.cdsItensNFV_FCPSTRET.Value;
              vICMSSubstituto  := dmPdv.cdsItensNFICMS_SUBST.Value;
              vICMSSTRet       := dmPdv.cdsItensNFVICMSSTRET.Value;
              vBCSTRet         := dmPdv.cdsItensNFVBCSTRET.Value;
            end
            else if (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '900') then
            begin
              CSOSN := csosn900;
              vBCFCPST := dmPdv.cdsItensNFV_B_FCPST.Value;
              pFCPST   := dmPdv.cdsItensNFP_FCPST.Value;
              vFCPST   := dmPdv.cdsItensNFV_FCPST.Value;

            end;
          end;

          //TODO PAREI AQUI DE COLOCAR O TRIM

          // CST's
          //10 TRIBUTADA
          //10 TRIBUTADA E COM COBRANÇA DO ICMS POR SUBS.TRIBUTÁRIA
          //20 COM REDUÇÃO DE BASE DE CÁLCULO
          //30 ISENTA OU NÃO TRIBUTADA E COM COBRANÇA DE ICMS POR SUBS.TRIBUTÁRIA
          //40 - ISENTA
          //41 NÃO TRIBUTADA
          //50 SUSPENSÃO
          //51 DIFERIMENTO A EXIGÊNCIA DO PREENCHIMENTO DAS INFORMAÇÕES DO ICMS DIFERIDO FICA a CRITÉRIO DE CADA UF
          //60 ICMS COBRADO ANTERIORMENTE POR SUBS.TRIBUTÁRIA
          //70 COM REDUÇÃO DA BASE DE CALCULO E COBRANÇA DO ICMS POR SUBS.TRIB. ICMS POR SUBS.TRIB.
          //90 OUTROS

          if ((Trim(dmPdv.cdsItensNFCST.AsString) = '') and (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '')) then
          begin
            if ((Trim(dmPdv.cdsItensNFCSOSN.AsString) = '') or (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '0')) then
              MessageDlg('CST do ICMS em branco no item ' + dmPdv.cdsItensNFDESCPRODUTO.AsString, mtWarning, [mbOK], 0);
            Exit;
          end
          else
          begin
            cst_parte :=  dmPdv.cdsItensNFCST.AsString;
            cst_parte := copy(Trim(dmPdv.cdsItensNFCST.AsString),2,2);
            if (cst_parte = '00') then
            begin
              CST  := cst00;
              pFCP := dmPdv.cdsItensNFP_FCP.Value;
              vFCP := dmPdv.cdsItensNFV_FCP.Value;
            end;
            if (cst_parte = '10') then
            begin
              CST      := cst10;
              vBCFCPST := dmPdv.cdsItensNFV_B_FCPST.Value;
              pFCPST   := dmPdv.cdsItensNFP_FCPST.Value;
              vFCPST   := dmPdv.cdsItensNFV_FCPST.Value;
            end;
            if (cst_parte = '20') then
            begin
              CST    := cst20;
              vBCFCP := dmPdv.cdsItensNFV_B_FCP.Value;
              pFCP   := dmPdv.cdsItensNFP_FCP.Value;
              vFCP   := dmPdv.cdsItensNFV_FCP.Value;
            end;
            if (cst_parte = '30') then
            begin
              CST := cst30;
              vBCFCPST := dmPdv.cdsItensNFV_B_FCPST.Value;
              pFCPST   := dmPdv.cdsItensNFP_FCPST.Value;
              vFCPST   := dmPdv.cdsItensNFV_FCPST.Value;
            end;
            if (cst_parte = '40') then
            begin
              CST := cst40;
              if( Trim(pSuframa) <> '') then
              begin
                vICMSDeson := dmPdv.cdsItensNFVALOR_ICMS.Value;
                //vICMS      := cdsItensNFVALOR_ICMS.Value;
                motDesICMS := mdiSuframa ;
                indDeduzDeson := tieSim;
                //vBC := cdsItensNFVLR_BASEICMS.AsVariant - cdsItensNFVALOR_ICMS.AsVariant;
                //pICMS := cdsItensNFICMS.AsVariant;
                //vICMS := cdsItensNFVALOR_ICMS.AsVariant;
              end;
            end;

            if (cst_parte = '41') then
            begin
              CST := cst41;
              vBCSTRet    := dmPdv.cdsItensNFVBCSTRET.Value;
              vICMSSTRet  := dmPdv.cdsItensNFVICMSSTRET.Value;
              vBCSTDest   := dmPdv.cdsItensNFVBCSTDEST.Value;
              vICMSSTDest := dmPdv.cdsItensNFVICMSSTDEST.Value;
            end;
            if (cst_parte = '50') then
              CST := cst50;
            if (cst_parte = '51') then
            begin
              CST := cst51;
              vBCFCP := dmPdv.cdsItensNFV_B_FCP.Value;
              pFCP   := dmPdv.cdsItensNFP_FCP.Value;
              vFCP   := dmPdv.cdsItensNFV_FCP.Value;
            end;
            if (cst_parte = '60') then
            begin
              CST         := cst60;
              pST         := dmPdv.cdsItensNFICMS_PST.Value;
              vBCFCPST    := dmPdv.cdsItensNFV_B_FCPST .Value;
              pFCPSTRet   := dmPdv.cdsItensNFP_FCPSTRET.Value;
              vFCPSTRet   := dmPdv.cdsItensNFV_FCPSTRET.Value;
              vBCSTRet    := dmPdv.cdsItensNFVBCSTRET.Value;
              vICMSSTRet  := dmPdv.cdsItensNFVICMSSTRET.Value;
              vBCSTDest   := dmPdv.cdsItensNFVBCSTDEST.Value;
              vICMSSTDest := dmPdv.cdsItensNFVICMSSTDEST.Value;
            end;
            if (cst_parte = '70') then
            begin
              CST := cst70;
              vBCFCPST := dmPdv.cdsItensNFV_B_FCPST.Value;
              pFCPST   := dmPdv.cdsItensNFP_FCPST.Value;
              vFCPST   := dmPdv.cdsItensNFV_FCPST.Value;
            end;
            if (cst_parte = '90') then
            begin
              CST := cst90;
              vBCFCPST := dmPdv.cdsItensNFV_B_FCPST.Value;
              pFCPST   := dmPdv.cdsItensNFP_FCPST.Value;
              vFCPST   := dmPdv.cdsItensNFV_FCPST.Value;
              vBCFCP   := dmPdv.cdsItensNFV_B_FCP.Value;
              pFCP     := dmPdv.cdsItensNFP_FCP.Value;
              vFCP     := dmPdv.cdsItensNFV_FCP.Value;
            end;
            { Substitui pela rotina acima 05/01/2016
            if ((cdsItensNFCST.AsString = '000') or (cdsItensNFCST.AsString = '100') or (cdsItensNFCST.AsString = '200') or (cdsItensNFCST.AsString = '00')) then
              CST := cst00
            else if ((cdsItensNFCST.AsString = '010') or (cdsItensNFCST.AsString = '110') or (cdsItensNFCST.AsString = '210') or (cdsItensNFCST.AsString = '10')) then
              CST := cst10
            else if ((cdsItensNFCST.AsString = '020') or (cdsItensNFCST.AsString = '120') or (cdsItensNFCST.AsString = '220') or (cdsItensNFCST.AsString = '20')) then
              CST := cst20
            else if ((cdsItensNFCST.AsString = '030') or (cdsItensNFCST.AsString = '130') or (cdsItensNFCST.AsString = '230') or (cdsItensNFCST.AsString = '30')) then
              CST := cst30
            else if ((cdsItensNFCST.AsString = '040') or (cdsItensNFCST.AsString = '140') or (cdsItensNFCST.AsString = '240') or (cdsItensNFCST.AsString = '40')) then
              CST :=  cst40
            else if ((cdsItensNFCST.AsString = '041') or (cdsItensNFCST.AsString = '141') or (cdsItensNFCST.AsString = '241') or (cdsItensNFCST.AsString = '41')) then
              CST :=  cst41
            else if ((cdsItensNFCST.AsString = '050') or (cdsItensNFCST.AsString = '150') or (cdsItensNFCST.AsString = '250') or (cdsItensNFCST.AsString = '50')) then
              CST :=  cst50
            else if ((cdsItensNFCST.AsString = '051') or (cdsItensNFCST.AsString = '151') or (cdsItensNFCST.AsString = '251') or (cdsItensNFCST.AsString = '51')) then
              CST := cst51
            else if ((cdsItensNFCST.AsString = '060') or (cdsItensNFCST.AsString = '160') or (cdsItensNFCST.AsString = '260') or (cdsItensNFCST.AsString = '60')) then
              CST := cst60
            else if ((cdsItensNFCST.AsString = '070') or (cdsItensNFCST.AsString = '170') or (cdsItensNFCST.AsString = '270') or (cdsItensNFCST.AsString = '70')) then
              CST := cst70
            else if ((cdsItensNFCST.AsString = '090') or (cdsItensNFCST.AsString = '190') or (cdsItensNFCST.AsString = '290') or (cdsItensNFCST.AsString = '90')) then
              CST := cst90
            else
              CST := cst00;
            }
          end;

          // Reforma Tributaria
          if(dmPdv.ReformaTributaria = 'SIM' )then
          begin

            pIBS_CBS := dmPdv.cdsItensNFCST_IBS_CBS.AsString;
            pCASTRIB := dmPdv.cdsItensNFCCLASSTRIB.AsString;

          //  DecimalSeparator := '.';
            pIBS := StrToFloat(dmPdv.cdsItensNFP_IBS.AsString);
            pCBS := StrToFloat(dmPdv.cdsItensNFP_CBS.AsString);

            pReducao  := dmPdv.cdsItensNFREDUCAO_CBS.AsFloat;  // criar outro IBS

            // CST
            for LCST := Low(TCSTIBSCBS) to High(TCSTIBSCBS) do
            begin
              if Trim(pIBS_CBS) = TCSTIBSCBSArrayStrings[LCST] then
              begin
                IBSCBS.CST := LCST;
              end;
            end;

            // CASTRIB
            {
            for LcClassTrib := Low(TcClassTrib) to High(TcClassTrib) do
            begin
              if Trim(pCASTRIB) = TcClassTribArrayStrings[LcClassTrib] then
              begin
                IBSCBS.cClassTrib := LcClassTrib;
              end;
            end;

           }
;
            IBSCBS.cClassTrib := pCASTRIB;

            baseIBS_CBS := dmPdv.cdsItensNFVALTOTAL.AsFloat - dmPdv.cdsItensNFVALOR_ICMS.AsFloat - dmPdv.cdsItensNFVALOR_COFINS.AsFloat
            - dmPdv.cdsItensNFVALOR_PIS.AsFloat;

            IBSCBS.gIBSCBS.vBC := baseIBS_CBS ; //dmPdv.cdsItensNFVALTOTAL.AsFloat;


            IBSCBS.gIBSCBS.vIBS := ((baseIBS_CBS*pIBS)/100);

         pA :=  RoundABNT((baseIBS_CBS*pIBS)/100,2);

         pA := ((100 - pReducao)/100);

         pA :=  (pA*(pIBS))/100;

         pA := (baseIBS_CBS)*(pA);

         if(pIBS_CBS <> '000')then
         begin
           IBSCBS.gIBSCBS.vIBS := pA ;
         end;



            IBSCBS.gIBSCBS.gIBSUF.pIBSUF := pIBS;
           // IBSCBS.gIBSCBS.gIBSUF.vIBSUF := ((dmPdv.cdsItensNFVALTOTAL.AsFloat*pReducaoIBS)/100);

         pA:= (baseIBS_CBS*pIBS)/100;

         pA := ((100 - pReducao)/100);

         pA :=  (pA*(pIBS))/100;

         pA := (baseIBS_CBS)*(pA);

         vpIBS := ((pIBS)*(100- pReducao)/100);


        // if(pIBS_CBS <> '000')then
        // begin
           IBSCBS.gIBSCBS.gIBSUF.vIBSUF := pA ; //vpIBS;
           total_ibs += pA;
        // end;

         if(pReducao > 0)then
         begin
           IBSCBS.gIBSCBS.gIBSUF.gRed.pRedAliq := dmPdv.cdsItensNFREDUCAO_IBS.AsFloat;
           IBSCBS.gIBSCBS.gIBSUF.gRed.pAliqEfet := ((baseIBS_CBS*pIBS)/100);
         end;

         IBSCBS.gIBSCBS.gIBSMun.pIBSMun := 0;
         IBSCBS.gIBSCBS.gIBSMun.vIBSMun := 0;

         if(pIBS_CBS <> '000')then
         begin
           vpIBS := ((pIBS)*(100- pReducao)/100);
           IBSCBS.gIBSCBS.gIBSUF.gRed.pAliqEfet := vpIBS ;
         end;

            IBSCBS.gIBSCBS.gIBSMun.pIBSMun := 0;
            IBSCBS.gIBSCBS.gIBSMun.vIBSMun := 0;

            IBSCBS.gIBSCBS.gIBSMun.gRed.pRedAliq := dmPdv.cdsItensNFREDUCAO_IBS.AsFloat;
            IBSCBS.gIBSCBS.gIBSMun.gRed.pAliqEfet := 0;

        if(pReducao > 0 )then
        begin

          vpCBS := ((pCBS)*(100- pReducao)/100);

          IBSCBS.gIBSCBS.gCBS.gRed.pRedAliq := dmPdv.cdsItensNFREDUCAO_CBS.AsFloat;
          IBSCBS.gIBSCBS.gCBS.gRed.pAliqEfet := vpCBS ; //RoundABNT((dmPdv.sqLancamentosVALTOTAL.AsFloat*pReducaoCBS)/100,2);

          vpIBS := ((pIBS)*(100- pReducao)/100);

        // pA := ((dmPdv.sqLancamentosVALTOTAL.AsFloat)*(pA),2);

       // xx  IBSCBS.gIBSCBS.gIBSUF.gRed.pRedAliq := dmPdv.cdsItensNFREDUCAO_IBS.AsFloat;
       // xx  IBSCBS.gIBSCBS.gIBSUF.gRed.pAliqEfet := vpIBS ;
        end;

           


            IBSCBS.gIBSCBS.gCBS.pCBS := pCBS;

      //  xx    IBSCBS.gIBSCBS.gIBSMun.gRed.pRedAliq := 0.00;
       // xx   IBSCBS.gIBSCBS.gIBSMun.gRed.pAliqEfet := 0.00;

            IBSCBS.gIBSCBS.gCBS.vCBS := ((baseIBS_CBS*pCBS)/100);


       // if(pIBS_CBS <> '000')then
       // begin
            pA := ((100 - pReducao)/100);

            pA :=  (pA*(pCBS))/100;

            pA := RoundABNT((baseIBS_CBS)*(pA),2);

            total_cbs += pA;
            IBSCBS.gIBSCBS.gCBS.vCBS := pA ;
       // end;


          end;  //Fim da reforma

          orig :=     dmPdv.qsProdutosORIGEM.AsVariant;                       //ORIGEM DO PRODUTO
          modBC :=    BC;                                              //MODO DE BASE DE CALCULO (0) POR %
          //Não carregar ICMS para Simples Nacional
         {
         if not ((ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional) and (cdsItensNFCSOSN.AsString <> '900')) then
          begin
            if(Trim(pSuframa) = '') then
            begin
              vBC := cdsItensNFVLR_BASEICMS.AsVariant;                //VALOR DA BASE DE CALCULO
              pICMS := cdsItensNFICMS.AsVariant;                     //ALIQUOTA DO ICMS
              vICMS := cdsItensNFVALOR_ICMS.AsVariant;                  //VALOR DO ICMS
            end;
          end;
         }
          if not ((ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional) and (dmPdv.cdsItensNFCSOSN.AsString <> '900')) then
          begin
            if ((cst_parte = '00') OR (Trim(pSuframa) = '')) then
            begin
              cstSuframa := '00';
              vBC   := dmPdv.cdsItensNFVLR_BASEICMS.AsVariant;                //VALOR DA BASE DE CALCULO
              pICMS := dmPdv.cdsItensNFICMS.AsVariant;                     //ALIQUOTA DO ICMS
              vICMS := dmPdv.cdsItensNFVALOR_ICMS.AsVariant;                  //VALOR DO ICMS
            end;
          end;

          modBCST :=  BCST;                                         //MODO DE BASE DE CALCULO SUBST. TRIBUTÁRIA(4) POR %
          vBCST := 0;
          if (not dmPdv.cdsItensNFICMS_SUBSTD.IsNull) then
           begin
            vBCST := dmPdv.cdsItensNFICMS_SUBSTD.AsVariant;                 //VALOR DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA
          end;
          if (not dmPdv.cdsItensNFICMS_SUBSTD.IsNull) then
           begin
            vBCST := dmPdv.cdsItensNFICMS_SUBSTD.AsVariant;                 //VALOR DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA
          end;


          // ve se e tributado por NCM
          if (dmPdv.sdsCfopNCM.Active) then
            dmPdv.sdsCfopNCM.Close;
          dmPdv.sdsCfopNCM.Params[0].AsString := dmPdv.qsProdutosNCM.AsString;
          if(cbTipoNota.ItemIndex = 0) then
            dmPdv.sdsCfopNCM.Params[1].AsString := dmPdv.qsFornecUF.AsString
          else
            dmPdv.sdsCfopNCM.Params[1].AsString := dmPdv.qsClienteUF.AsString;
          dmPdv.sdsCfopNCM.Params[2].AsString := dmPdv.qcdsNFCFOP.AsString;
          if (cbTipoNota.ItemIndex = 0) then
            dmPdv.sdsCfopNCM.Params[3].AsString := dmPdv.qsFornecCODFISCAL.AsString
          else
            dmPdv.sdsCfopNCM.Params[3].AsString := dmPdv.qsClienteCODFISCAL.AsString;
          dmPdv.sdsCfopNCM.Open;

          if (not dmPdv.sdsCfopNCM.IsEmpty) then
          begin
            if (dmPdv.sdsCfopNCMICMS_SUBST.IsNull) then
              pMVAST := 0
            else
              pMVAST := dmPdv.sdsCfopNCMICMS_SUBST.AsVariant;                //% MARGEM DE VALOR ADICIONADO DO ICMSST
            if (dmPdv.sdsCfopNCMICMS_SUBST_IC.IsNull) then
              pRedBCST := 0
            else
              pRedBCST := dmPdv.sdsCfopNCMICMS_SUBST_IC.AsVariant;                 //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA
            if (dmPdv.sdsCfopNCMICMS_SUBST_IND.IsNull) then
              pICMSST := 0
            else
              pICMSST := dmPdv.sdsCfopNCMICMS_SUBST_IND.AsVariant;                    //ALIQUOTA DO ICMS DA SUBST. TRIBUTÁRIA
          end
          else begin
            // ve se e tributado no produto
            if (dmPdv.sdsCfopProd.Active) then
              dmPdv.sdsCfopProd.Close;
            dmPdv.sdsCfopProd.Params[0].AsInteger := dmPdv.cdsItensNFCODPRODUTO.AsInteger;
            if (cbTipoNota.ItemIndex = 0) then
              dmPdv.sdsCfopProd.Params[1].AsString := dmPdv.qsFornecUF.AsString
            else
              dmPdv.sdsCfopProd.Params[1].AsString := dmPdv.qsClienteUF.AsString;
            dmPdv.sdsCfopProd.Params[2].AsString := dmPdv.qcdsNFCFOP.AsString;
            dmPdv.sdsCfopProd.Open;

            if (not dmPdv.sdsCfopProd.IsEmpty) then
            begin
              if (dmPdv.sdsCfopProdICMS_SUBST.IsNull) then
                pMVAST := 0
              else
                pMVAST := dmPdv.sdsCfopProdICMS_SUBST.AsVariant;                //% MARGEM DE VALOR ADICIONADO DO ICMSST
              if (dmPdv.sdsCfopProdICMS_SUBST_IC.IsNull) then
                pRedBCST := 0
              else
                pRedBCST := dmPdv.sdsCfopProdICMS_SUBST_IC.AsVariant;                 //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA
              if (dmPdv.sdsCfopProdICMS_SUBST_IND.IsNull) then
                pICMSST := 0
              else
                pICMSST :=  dmPdv.sdsCfopProdICMS_SUBST_IND.AsVariant;                    //ALIQUOTA DO ICMS DA SUBST. TRIBUTÁRIA
            end  // busca tributado cfop_uf
            else begin
              if (dmPdv.qsCFOPICMS_SUBSTRIB.IsNull) then
                pMVAST := 0
              else
                pMVAST := dmPdv.qsCFOPICMS_SUBSTRIB.AsVariant;                //% MARGEM DE VALOR ADICIONADO DO ICMSST
              if (dmPdv.qsCFOPICMS_SUBSTRIB_IC.IsNull) then
                pRedBCST := 0
              else
                pRedBCST := dmPdv.qsCFOPICMS_SUBSTRIB_IC.AsVariant;                 //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA
              if (dmPdv.qsCFOPICMS_SUBSTRIB_IND.IsNull) then
                pICMSST := 0
              else
                pICMSST := dmPdv.qsCFOPICMS_SUBSTRIB_IND.AsVariant;                    //ALIQUOTA DO ICMS DA SUBST. TRIBUTÁRIA
            end;
          end;
          if (dmPdv.qsCFOPREDUCAO.IsNull) then
            pRedBC := 0
          else
            pRedBC := 100 - dmPdv.qsCFOPREDUCAO.AsVariant;                          //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO
          if (dmPdv.cdsItensNFICMS_SUBST.isnull) then
            vICMSST := 0
          else
            vICMSST := dmPdv.cdsItensNFICMS_SUBST.AsVariant;                  //VALOR DO ICMS DA SUBST. TRIBUTÁRIA

        end;

        //CST PIS E COFINS
        //01	Operação Tributável com Alíquota Básica
        //02	Operação Tributável com Alíquota Diferenciada
        //03	Operação Tributável com Alíquota por Unidade de Medida de Produto
        //04	Operação Tributável Monofásica - Revenda a Alíquota Zero
        //05	Operação Tributável por Substituição Tributária
        //06	Operação Tributável a Alíquota Zero
        //07	Operação Isenta da Contribuição
        //08	Operação sem Incidência da Contribuição
        //09	Operação com Suspensão da Contribuição
        //49	Outras Operações de Saída
        //50	Operação com Direito a Crédito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
        //51	Operação com Direito a Crédito - Vinculada Exclusivamente a Receita Não Tributada no Mercado Interno
        //52	Operação com Direito a Crédito - Vinculada Exclusivamente a Receita de Exportação
        //53	Operação com Direito a Crédito - Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno
        //54	Operação com Direito a Crédito - Vinculada a Receitas Tributadas no Mercado Interno e de Exportação
        //55	Operação com Direito a Crédito - Vinculada a Receitas Não-Tributadas no Mercado Interno e de Exportação
        //56	Operação com Direito a Crédito - Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno, e de Exportação
        //60	Crédito Presumido - Operação de Aquisição Vinculada Exclusivamente a Receita Tributada no Mercado Interno
        //61	Crédito Presumido - Operação de Aquisição Vinculada Exclusivamente a Receita Não-Tributada no Mercado Interno
        //62	Crédito Presumido - Operação de Aquisição Vinculada Exclusivamente a Receita de Exportação
        //63	Crédito Presumido - Operação de Aquisição Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno
        //64	Crédito Presumido - Operação de Aquisição Vinculada a Receitas Tributadas no Mercado Interno e de Exportação
        //65	Crédito Presumido - Operação de Aquisição Vinculada a Receitas Não-Tributadas no Mercado Interno e de Exportação
        //66	Crédito Presumido - Operação de Aquisição Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno, e de Exportação
        //67	Crédito Presumido - Outras Operações
        //70	Operação de Aquisição sem Direito a Crédito
        //71	Operação de Aquisição com Isenção
        //72	Operação de Aquisição com Suspensão
        //73	Operação de Aquisição a Alíquota Zero
        //74	Operação de Aquisição sem Incidência da Contribuição
        //75	Operação de Aquisição por Substituição Tributária
        //98	Outras Operações de Entrada
        //99	Outras Operações

        with PIS do
        begin
          if (Trim(dmPdv.cdsItensNFCSTPIS.AsString) = '') then
          begin
            if ((Trim(dmPdv.cdsItensNFCSOSN.AsString) = '') or (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '0')) then
              MessageDlg('CST do PIS em branco  no item ' + dmPdv.cdsItensNFDESCPRODUTO.AsString, mtWarning, [mbOK], 0);
            Exit;
          end
          else
          begin
            if (dmPdv.cdsItensNFCSTPIS.AsString = '01') then
              CST   := pis01
            else if (dmPdv.cdsItensNFCSTPIS.AsString = '02') then
              CST   := pis02
            else if (dmPdv.cdsItensNFCSTPIS.AsString = '03') then
              CST   := pis03
            else if (dmPdv.cdsItensNFCSTPIS.AsString = '04') then
              CST   := pis04
            else if (dmPdv.cdsItensNFCSTPIS.AsString = '06') then
              CST   := pis06
            else if (dmPdv.cdsItensNFCSTPIS.AsString = '07') then
              CST   := pis07
            else if (dmPdv.cdsItensNFCSTPIS.AsString = '08') then
              CST   := pis08
            else if (dmPdv.cdsItensNFCSTPIS.AsString = '09') then
              CST   := pis09
            else if (dmPdv.cdsItensNFCSTPIS.AsString = '99') then
              CST   := pis99;
          end;

          if (dmPdv.cdsItensNFPPIS.AsFloat > 0) then
            //vBC   := (cdsItensNFVALOR_PIS.AsVariant *100 ) / cdsItensNFPPIS.AsVariant //-cdsItensNFVALTOTAL.AsVariant
            vBC := dmPdv.cdsItensNFVLRBC_PIS.AsCurrency
          else
          vBC   := 0;
          vPIS  := dmPdv.cdsItensNFVALOR_PIS.AsVariant;
          if(dmPdv.cdsItensNFPPIS.AsVariant = null)then
            pPIS  := 0
          else
          pPIS  := dmPdv.cdsItensNFPPIS.AsVariant;

        end;
        with COFINS do
        begin
          if (Trim(dmPdv.cdsItensNFCSTCOFINS.AsString) = '') then
          begin
            if ((Trim(dmPdv.cdsItensNFCSOSN.AsString) = '') or (Trim(dmPdv.cdsItensNFCSOSN.AsString) = '0')) then
              MessageDlg('CST do COFINS em branco no item ' + dmPdv.cdsItensNFDESCPRODUTO.AsString, mtWarning, [mbOK], 0);
            Exit;
          end
          else
          begin
            if (dmPdv.cdsItensNFCSTCOFINS.AsString = '01') then
              CST   := cof01
            else if (dmPdv.cdsItensNFCSTCOFINS.AsString = '02') then
              CST   := cof02
            else if (dmPdv.cdsItensNFCSTCOFINS.AsString = '03') then
              CST   := cof03
            else if (dmPdv.cdsItensNFCSTCOFINS.AsString = '04') then
              CST   := cof04
            else if (dmPdv.cdsItensNFCSTCOFINS.AsString = '06') then
              CST   := cof06
            else if (dmPdv.cdsItensNFCSTCOFINS.AsString = '07') then
              CST   := cof07
            else if (dmPdv.cdsItensNFCSTCOFINS.AsString = '08') then
              CST   := cof08
            else if (dmPdv.cdsItensNFCSTCOFINS.AsString = '09') then
              CST   := cof09
            else if (dmPdv.cdsItensNFCSTCOFINS.AsString = '99') then
              CST   := cof99;
          end;

         if ( dmPdv.cdsItensNFPCOFINS.AsFloat > 0) then
           //vBC   := (cdsItensNFVALOR_COFINS.AsVariant * 100) / cdsItensNFPCOFINS.AsVariant //cdsItensNFVALTOTAL.AsVariant;
           vBC := dmPdv.cdsItensNFVLRBC_COFINS.AsCurrency
         else
           vBC   := 0;
           if(dmPdv.cdsItensNFPCOFINS.AsVariant = null) then
             pCOFINS  := 0
           else
           pCOFINS  := dmPdv.cdsItensNFPCOFINS.AsVariant;
           vCOFINS  := dmPdv.cdsItensNFVALOR_COFINS.AsVariant;
        end;
        if (dmPdv.cdsItensNFII.asFloat > 0) then
        begin
          with II do
          begin
            vBc := dmPdv.cdsItensNFBCII.AsVariant;
            vII := dmPdv.cdsItensNFII.AsVariant;
          end;
        end;

        if ((dmPdv.qcdsNFNFE_MODELO.AsString = 'moNFe') and
          (dmPdv.qcdsNFNFE_DESTOPERACAO.AsString = 'doInterestadual') and
          (dmPdv.qcdsNFNFE_INDFINAL.AsString = 'cfConsumidorFinal') and
          (dmPdv.qcdsNFIND_IEDEST.AsString = 'inNaoContribuinte') and
          (cst_parte <> '10') and (cst_parte <> '90')) then
         begin
           with ICMSUFDest do
           begin
             vBCUFDest      := dmPdv.cdsItensNFVBCUFDEST.AsCurrency;
             pFCPUFDest     := dmPdv.cdsItensNFPFCPUFDEST.AsCurrency;
             pICMSUFDest    := dmPdv.cdsItensNFPICMSUFDEST.AsCurrency;
             pICMSInter     := dmPdv.cdsItensNFPICMSINTER.AsCurrency;
             pICMSInterPart := dmPdv.cdsItensNFPICMSINTERPART.AsCurrency;
             tot4           := tot4 + dmPdv.cdsItensNFVFCPUFDEST.AsCurrency;
             vFCPUFDest     := dmPdv.cdsItensNFVFCPUFDEST.AsCurrency;
             tot1           := tot1 + dmPdv.cdsItensNFVFCPUFDEST.AsCurrency;
             vICMSUFDest    := dmPdv.cdsItensNFVICMSUFDEST.AsCurrency;
             tot2           := tot2 + dmPdv.cdsItensNFVICMSUFDEST.AsCurrency;
             vICMSUFRemet   := dmPdv.cdsItensNFVICMSUFREMET.AsCurrency;
             tot3           := tot3 + dmPdv.cdsItensNFVICMSUFREMET.AsCurrency;
             vBCFCPUFDest   := dmPdv.cdsItensNFVBFCPUFDEST.AsCurrency;

           end;
         end;

      end; //IMPOSTOS Do Produto
    end;
  end;


end;

procedure TfNFe.getTransportadora;
var
  tpfrete: integer;
  tfrete: Variant;
begin
  with ACBrNFe1.NotasFiscais.Items[0].NFe do
  begin
    if ((dmPdv.qcdsNFFRETE.IsNull) or (Trim(dmPdv.qcdsNFFRETE.AsString) = ''))then
      tpfrete := 9
    else
      tpfrete := StrToInt(trim(dmPdv.qcdsNFFRETE.AsString));
    tfrete := IntToStr(tpfrete);
    //Carrega dados da transportadora
    with Transp do
    begin
      with transporta do
      begin
        case tfrete of
          0 : modFrete := mfContaEmitente;
          1 : modFrete := mfContaDestinatario;
          2 : modFrete := mfContaTerceiros;
          3 : modFrete := mfProprioRemetente;
          4 : modFrete := mfProprioDestinatario;
          9 : modFrete := mfSemFrete;
        end;
        CNPJCPF := RemoveChar(dmPdv.qcdsNFCNPJ_CPF.AsString);
        xNome   := trim(dmPdv.qcdsNFNOMETRANSP.AsString);
        if (dmPdv.qcdsNFNOMETRANSP.AsString <> '') then
        begin
          if (dmPdv.qsTransp.Active) then
            dmPdv.qsTransp.Close;
          dmPdv.qsTransp.Params[0].AsInteger := dmPdv.qcdsNFCODTRANSP.AsInteger;
          dmPdv.qsTransp.Open;
          if (not dmPdv.qsTransp.IsEmpty) then
            xNome := dmPdv.qsTranspNOMETRANSP.AsString
          else begin
            dmPdv.qsListaTransp.Open;
            dmPdv.qsListaTransp.Locate('FANTASIA',dmPdv.qcdsNFTRANSP2.AsString,[loCaseInsensitive]);
            xNome := dmPdv.qslistaTranspNOMETRANSP.AsString;
            dmPdv.qslistaTransp.Close;
          end;
        end;
        IE := RemoveChar(dmPdv.qcdsNFINSCRICAOESTADUAL.AsString);
        xEnder := dmPdv.qcdsNFEND_TRANSP.AsString;
        xMun := dmPdv.qcdsNFCIDADE_TRANSP.AsString;
        UF :=  dmPdv.qcdsNFUF_TRANSP.AsString;
        //Carrega dados da Carga para Transporte
        with Vol.Add do
        begin
          if (dmPdv.qcdsNFQUANTIDADE.AsVariant > 0) then
            qVol := dmPdv.qcdsNFQUANTIDADE.AsVariant
          else
            qVol := 0;

          if ((dmPdv.qcdsNFESPECIE.AsString <> '') and (dmPdv.qcdsNFESPECIE.AsString <> Null) ) then
            esp := dmPdv.qcdsNFESPECIE.AsString
          else
            esp := '';

          if ((dmPdv.qcdsNFMARCA.AsString <> '') and (dmPdv.qcdsNFMARCA.AsString <>  null) ) then
             marca := dmPdv.qcdsNFMARCA.AsString
          else
            marca := '';

          if ((dmPdv.qcdsNFNUMERO.AsString <> '') and (dmPdv.qcdsNFNUMERO.AsString <> null) ) then
            nVol := dmPdv.qcdsNFNUMERO.AsString
          else
            nVol := '';

          if (dmPdv.qcdsNFPESOLIQUIDO.AsCurrency > 0) then
            pesoL := dmPdv.qcdsNFPESOLIQUIDO.AsCurrency
          else
            pesoL := 0;

          if (dmPdv.qcdsNFPESOBRUTO.AsCurrency > 0) then
            pesoB := dmPdv.qcdsNFPESOBRUTO.AsCurrency
          else
            pesoB := 0;
        end;

        if ((trim(StringReplace(dmPdv.qcdsNFPLACATRANSP.AsString, '-', '', [rfReplaceAll])) <> '') and (trim(RemoveChar(dmPdv.qcdsNFPLACATRANSP.AsString)) <> null) ) then
         if ((dmPdv.qcdsNFUF_VEICULO_TRANSP.AsString <> '') and (dmPdv.qcdsNFUF_VEICULO_TRANSP.AsString <> null) ) then
         begin
           veicTransp.placa := trim(StringReplace(dmPdv.qcdsNFPLACATRANSP.AsString, '-', '', [rfReplaceAll]));
           veicTransp.UF := dmPdv.qcdsNFUF_VEICULO_TRANSP.AsString;
         end;
      end;
    end;
  end;


end;

procedure TfNFe.LerConfiguracao;
Var IniFile  : String ;
    Ini     : TIniFile ;
    Ok : Boolean;
    StreamMemo : TMemoryStream;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini') ;

  Ini := TIniFile.Create( IniFile );
  try
      cbSSLLib.ItemIndex:= Ini.ReadInteger( 'Certificado','SSLLib' ,0) ;
      cbCryptLib.ItemIndex := Ini.ReadInteger( 'Certificado','CryptLib' , 0) ;
      cbHttpLib.ItemIndex := Ini.ReadInteger( 'Certificado','HttpLib' , 0) ;
      cbXmlSignLib.ItemIndex := Ini.ReadInteger( 'Certificado','XmlSignLib' , 0) ;
      edtCaminho.Text  := Ini.ReadString( 'Certificado','Caminho' ,'') ;
      edtSenha.Text    := Ini.ReadString( 'Certificado','Senha'   ,'') ;
      cbSSLType.ItemIndex  := Ini.ReadInteger( 'WebService','SSLType' , 0) ;
     // cbCriaPasta.ItemIndex := Ini.ReadInteger ('Certificado','Criar Pasta', -1) ;
      ComboBox3.ItemIndex := Ini.ReadInteger ('Certificado','Pasta NFe', 0);

      if(edtNumSerie.Text = '') then
        edtNumSerie.Text := Ini.ReadString( 'Certificado','NumSerie','');

      if(edtNumSerie2.Text = '') then
        edtNumSerie2.Text := Ini.ReadString( 'Certificado','NumSerie','');

      if(edtNumSerie1.Text = '') then
        edtNumSerie1.Text := Ini.ReadString( 'Certificado','NumSerie','');

      ACBrNFe1.Configuracoes.Certificados.ArquivoPFX  := edtCaminho.Text;
      ACBrNFe1.Configuracoes.Certificados.Senha       := edtSenha.Text;
      ACBrNFe1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;

    //  edtPathSchemas.Text  := Ini.ReadString( 'Certificado','PathSchemas'  ,PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\') ;

      ACBrNFe1.SSL.DescarregarCertificado;

      with ACBrNFe1.Configuracoes.Geral do
      begin
        SSLLib                := TSSLLib(cbSSLLib.ItemIndex);
        SSLCryptLib           := TSSLCryptLib(cbCryptLib.ItemIndex);
        SSLHttpLib            := TSSLHttpLib(cbHttpLib.ItemIndex);
        SSLXmlSignLib         := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
        cbSSLType.Enabled := (ACBrNFe1.Configuracoes.Geral.SSLHttpLib in [httpWinHttp, httpOpenSSL]);
        AtualizaSSLLibsCombo;
      end;

      with ACBrNFe1.Configuracoes.Arquivos do
      begin
        PathSchemas        := edtPathSchemas.Text;
      end;

  finally
     Ini.Free ;
  end;

end;

procedure TfNFe.AtualizaSSLLibsCombo;
begin
  cbSSLLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLLib );
  cbCryptLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLCryptLib );
  cbHttpLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLHttpLib );
  cbXmlSignLib.ItemIndex := Integer( ACBrNFe1.Configuracoes.Geral.SSLXmlSignLib );
  cbSSLTypeLbl.Enabled := (ACBrNFe1.Configuracoes.Geral.SSLHttpLib in [httpWinHttp, httpOpenSSL]) ;
end;

procedure TfNFe.GravarConfiguracao;
var
 IniFile    : String;
 Ini        : TIniFile;
 StreamMemo : TMemoryStream;
begin
  // IniFile := (ExtractFilePath(Application.ExeName) + 'dbxconnections.ini');    // arquivo dbxconnections.ini

  IniFile := ChangeFileExt( Application.ExeName, '.ini');  // arquivo nfe.ini


  Ini := TIniFile.Create( IniFile );
  try

    Ini.WriteString( 'Certificado','NumSerie',edtNumSerie.Text);
    Ini.WriteString( 'Certificado','Caminho' ,edtCaminho.Text);
    Ini.WriteString( 'Certificado','Senha'   ,edtSenha.Text);

    Ini.WriteInteger( 'Certificado','SSLLib' , cbSSLLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','CryptLib' , cbCryptLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','HttpLib' , cbHttpLib.ItemIndex) ;
    Ini.WriteInteger( 'Certificado','XmlSignLib' , cbXmlSignLib.ItemIndex) ;
    Ini.WriteInteger( 'WebService','SSLType' , cbSSLType.ItemIndex);
    Ini.WriteInteger( 'Certificado','Pasta NFe' , ComboBox3.ItemIndex);
    Ini.WriteFloat( 'NFe','MargemSuperior' , FloatSpinEdit1.Value);
    Ini.WriteFloat( 'NFe','MargemInferior' , FloatSpinEdit2.Value);
    Ini.WriteFloat( 'NFe','MargemEsquerda' , FloatSpinEdit3.Value);
    Ini.WriteFloat( 'NFe','MargemDireita' , FloatSpinEdit4.Value);
    Ini.WriteBool('NFe','ImprimeCodigoEan',ckImpEAN.Checked);


   // Ini.WriteString( 'Geral','PathSchemas'  ,PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\') ;

   // edtPathSchemas.Text  := Ini.ReadString( 'Geral','PathSchemas'  ,PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\') ;

    with ACBrNFe1.Configuracoes.Geral do
    begin
     SSLLib                := TSSLLib(cbSSLLib.ItemIndex);
     SSLCryptLib           := TSSLCryptLib(cbCryptLib.ItemIndex);
     SSLHttpLib            := TSSLHttpLib(cbHttpLib.ItemIndex);
     SSLXmlSignLib         := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
     AtualizaSSLLibsCombo;
    end;
       // manoel
    // cbSSLTypeLbl.ItemIndex    := Ini.ReadInteger('WebService','SSLType' , 0) ;

    StreamMemo := TMemoryStream.Create;

    StreamMemo.Seek(0,soFromBeginning);

    StreamMemo.Free;
  finally
    Ini.Free;
  end;

end;

procedure TfNFe.CarregarXML(ChaveNFCe: String);
var Dia, Mes, Ano: Word;
  path_dosxml: String;
begin
  memoLog.Lines.Add('Entrou Carrega XML');
  DecodeDate(Now, Ano, Mes, Dia);
  OpenDialog1.Title := 'Selecione a NFe';
  OpenDialog1.DefaultExt := '*-nfe.xml';
  OpenDialog1.Filter := 'Arquivos NFe (*-nfe.xml)|*-nfe.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  path_dosxml := Edit1.Text + '\' + IntToStr(Ano) + FormatFloat('00', mes);// + '\';
  OpenDialog1.InitialDir := path_dosxml;
  memoLog.Lines.Add('Limpa o acbr nfe1');
  ACBrNFe1.NotasFiscais.Clear;
  if (Length(ChaveNFCe) > 30) then
  begin
    memoLog.Lines.Add('Tem a chave XML');
    if (FileExists(path_dosxml + '\' +
      ChaveNFCe + '-nfe.xml')) then
    begin
      ACBrNFe1.NotasFiscais.LoadFromFile(path_dosxml + '\' + ChaveNFCe + '-nfe.xml');
    end
    else begin
      if OpenDialog1.Execute then
      begin
        ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
      end;
    end;
  end
  else begin
    //memoLog.Lines.Add('Não tem a chave');
    if (OpenDialog1.Execute) then
    begin
      //memoLog.Lines.Add('Não tem a chave, abrindo acbr');
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    end;
  end;
end;

procedure TfNFe.gravaRetornoEnvio(Protocolo: String; Recibo: String);
var strAtualizaNota: String;
  atualiza_nf: String;
begin
  atualiza_nf := '';
  if (Protocolo <> '') then
  begin
    strAtualizaNota := 'UPDATE NOTAFISCAL SET STATUS = ' + QuotedStr('E') +
      ', NFE_VERSAO = ' + QuotedStr('4.0');
  end
  else begin
    strAtualizaNota := 'UPDATE NOTAFISCAL SET ' +
      ' NFE_VERSAO = ' + QuotedStr('4.0');
  end;

  if (Protocolo <> '') then
      atualiza_nf := ' , PROTOCOLOENV = ' + QuotedStr(Protocolo);

  //if ((dmPdv.qcdsNFNUMRECIBO.AsString = '') or (dmPdv.qcdsNFNUMRECIBO.IsNull)) then
  //begin
    if (Recibo <> '') then
      atualiza_nf += ' , NUMRECIBO = ' + QuotedStr(Recibo);
  //end;
  //if ((dmPdv.qcdsNFNOMEXML.AsString = '') or (dmPdv.qcdsNFNOMEXML.IsNull)) then
  //begin
    atualiza_nf += ' , NOMEXML = ' +
      QuotedStr(copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, (length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml');
  //end;
  //if (dmPdv.qcdsNFXMLNFE.IsNull) then
  //begin
    atualiza_nf += ' , XMLNFE = ' + quotedStr(ACBrNFe1.NotasFiscais.Items[0].XML);
  //end;
  if (atualiza_nf <> '') then
  begin
    strAtualizaNota :=  strAtualizaNota + atualiza_nf;
  end;
  strAtualizaNota :=  strAtualizaNota + ' WHERE NUMNF = ' + IntToStr(codnf) +
    ' AND ((PROTOCOLOENV IS NULL) OR (PROTOCOLOENV = ' + QuotedStr('') + '))';
  try
     dmPdv.IbCon.ExecuteDirect(strAtualizaNota);
     dmPdv.sTrans.Commit;
     dmPdv.qcdsNF.Open;
  except
     on E : Exception do
     begin
       ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
       dmPdv.sTrans.Rollback; //on failure, undo the changes}
       dmPdv.qcdsNF.Open;
     end;
  end;
end;

procedure TfNFe.gravaRetornoCancelada(Protocolo: String);
begin
  try
    str := 'UPDATE NOTAFISCAL SET ';
    str := str + ' STATUS = ' + QuotedStr('C');
    if (protocolo <> '') then
        str := str + ' , PROTOCOLOCANC = ' + quotedstr(Protocolo);
    str := str + ' , NFE_FINNFE = ' + quotedstr('fnCancelado');
    str := str + ' WHERE NUMNF = ' + IntToStr(codnf);
    dmPdv.IbCon.ExecuteDirect(str);
    dmPdv.sTrans.Commit;
    dmPdv.qcdsNF.Open;
  except
    on E : Exception do
    begin
      ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
      dmPdv.sTrans.Rollback; //on failure, undo the changes}
      dmPdv.qcdsNF.Open;
    end;
  end;

end;

procedure TfNFe.carregaTudo;
var Ini: TIniFile;
    IniFile , onde : String;
    ImpressoraDet: TIniFile;

    T: TSSLLib;
    U: TSSLCryptLib;
    V: TSSLHttpLib;
    X: TSSLXmlSignLib;
    Y: TSSLType;
begin
  //messagedlg('inicio carrega tudo!',mterror,[mbok],0);
  if (label26.Caption = '...') then
  begin
    fNFe.Caption := 'ATS-NFe ' + GetVersion;
    micro := Trim(GetComputerNameFunc);

    ACBrNFe1.DANFE := ACBrNFeDANFeRL1;
    ACBrNFeDANFeRL1.ACBrNFe := ACBrNFe1;
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

   begin
    Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'dbxconnections.ini');
   {
     con.Connected       := False;
     con.HostName        := Ini.ReadString('nfe', 'Hostname', '');
     con.Port            := Ini.ReadInteger('nfe', 'Port', 0);
     con.Protocol        := Ini.ReadString('nfe', 'Protocol', '');
     con.User            := Ini.ReadString('nfe', 'User', '');
     con.Password        := Ini.ReadString('nfe', 'Password', '');
     con.Database        := Ini.ReadString('nfe', 'Database', '');
     con.ClientCodepage  := Ini.ReadString('nfe', 'ClientCodepage', '');
     con.LibraryLocation := Ini.ReadString('nfe', 'LibraryLocation', '');
   }
     edtPathSchemas.Text  := Ini.ReadString( 'nfe','PathSchemas',PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\');
     Ini.Free;
   end;


    // LerConfiguracao;

    nfe_serie_receita := 1;

    ImpressoraDet := TIniFile.Create(ExtractFilePath(Application.ExeName)+ 'prjAtsAdmin.ini' );
    try
      nfe_serie_receita  := ImpressoraDet.ReadInteger('SISTEMA','SERIERECEITA',1);
      email_tls          := ImpressoraDet.ReadString('EMAIL','TLS','');
      email_ssl          := ImpressoraDet.ReadString('EMAIL','SSL','');
      edtNumSerie.Text  := Ini.ReadString('Certificado', 'NumSerie', '');
    finally
      ImpressoraDet.Free;
    end;

    IniFile := ChangeFileExt( Application.ExeName, '.ini');
    ImpressoraDet := TIniFile.Create( IniFile );
    try
      ACBrNFeDANFeRL1.MargemDireita := ImpressoraDet.ReadFloat('NFe','MargemDireita',0.7);
      ACBrNFeDANFeRL1.MargemEsquerda := ImpressoraDet.ReadFloat('NFe','MargemEsquerda',5.0);
      ACBrNFeDANFeRL1.MargemSuperior := ImpressoraDet.ReadFloat('NFe','MargemSuperior',3.0);
      ACBrNFeDANFeRL1.MargemInferior := ImpressoraDet.ReadFloat('NFe','MargemInferior',0.7);
      FloatSpinEdit1.Value := ImpressoraDet.ReadFloat('NFe','MargemSuperior',3.0);
      FloatSpinEdit2.Value := ImpressoraDet.ReadFloat('NFe','MargemInferior',0.7);
      FloatSpinEdit3.Value := ImpressoraDet.ReadFloat('NFe','MargemEsquerda',5.0);
      FloatSpinEdit4.Value := ImpressoraDet.ReadFloat('NFe','MargemDireita',0.7);

      ckImpEAN.Checked   := Ini.ReadBool('NFe','ImprimeCodigoEan',False);

      if ckImpEAN.Checked = True then
      begin
        ACBrNFeDANFeRL1.TipoDANFE := tiPaisagem ;
        ACBrNFeDANFeRL1.ImprimeCodigoEan := True;
        ACBrNFeDANFeRL1.ExibeEAN := True;
      end;

    finally
      ImpressoraDet.Free;
    end;

    dmPdv.IbCon.ExecuteDirect('ALTER TRIGGER PROIBE_ALT_DEL_NF INACTIVE');
    dmPdv.sTrans.Commit;
    dmPdv.IbCon.ExecuteDirect('UPDATE NOTAFISCAL SET SELECIONOU = null '
      + ' WHERE SELECIONOU = ' + QuotedStr('S'));
    dmPdv.IbCon.ExecuteDirect('UPDATE CCE SET SELECIONOU = null '
      + ' WHERE SELECIONOU = ' + QuotedStr('S'));
    dmPdv.IbCon.ExecuteDirect('ALTER TRIGGER PROIBE_ALT_DEL_NF ACTIVE');
    dmPdv.sTrans.Commit;

    if dmPdv.qcds_parametro.Active then
      dmPdv.qcds_parametro.Close;
    dmPdv.qcds_parametro.Params[0].AsString := 'CENTRORECEITA';
    dmPdv.qcds_parametro.Open;
    conta_local := Trim(dmPdv.qcds_parametroDADOS.AsString);
    dmPdv.qcds_parametro.Close;

    if dmPdv.qcds_parametro.Active then
      dmPdv.qcds_parametro.Close;
    dmPdv.qcds_parametro.Params[0].AsString := 'EMPRESA';
    dmPdv.qcds_parametro.Open;
    danfeDec := 2;
    if (Trim(dmPdv.qcds_parametroD5.AsString) <> '') then
      danfeDec := StrToInt(Trim(dmPdv.qcds_parametroD5.AsString));

    quebraLinhaDanfe := True;
    if (Trim(dmPdv.qcds_parametroD6.AsString) <> '') then
      quebraLinhaDanfe := False;
    imprimeDetalhamentoEspecifico := True;
    if (Trim(dmPdv.qcds_parametroD7.AsString) <> '') then
      imprimeDetalhamentoEspecifico := False;
    danfe_larg_codprod := 46;
    if (Trim(dmPdv.qcds_parametroD2.AsString) <> '') then
    begin
      try
        danfe_larg_codprod := StrToInt(Trim(dmPdv.qcds_parametroD2.AsString));
      except
      end;
    end;
    dmPdv.qcds_parametro.Close;

    //ACBrNFeDANFCeFortes1.UsaSeparadorPathPDF := True;
    ACBrNFeDANFeRL1.UsaSeparadorPathPDF := True;
    {ACBrNFeDANFCeFortes1.CasasDecimais.vUnCom := danfeDec;
    Case danfeDec of
       2 : ACBrNFeDANFCeFortes1.CasasDecimais.MaskvUnCom := ',0.00';
       3 : ACBrNFeDANFCeFortes1.CasasDecimais.MaskvUnCom := ',0.000';
       4 : ACBrNFeDANFCeFortes1.CasasDecimais.MaskvUnCom := ',0.0000';
       5 : ACBrNFeDANFCeFortes1.CasasDecimais.MaskvUnCom := ',0.00000';
       6 : ACBrNFeDANFCeFortes1.CasasDecimais.MaskvUnCom := ',0.000000';
       7 : ACBrNFeDANFCeFortes1.CasasDecimais.MaskvUnCom := ',0.0000000';
       8 : ACBrNFeDANFCeFortes1.CasasDecimais.MaskvUnCom := ',0.00000000';
    end;}
    ACBrNFeDANFeRL1.CasasDecimais.vUnCom := danfeDec;
    Case danfeDec of
       2 : ACBrNFeDANFeRL1.CasasDecimais.MaskvUnCom := ',0.00';
       3 : ACBrNFeDANFeRL1.CasasDecimais.MaskvUnCom := ',0.000';
       4 : ACBrNFeDANFeRL1.CasasDecimais.MaskvUnCom := ',0.0000';
       5 : ACBrNFeDANFeRL1.CasasDecimais.MaskvUnCom := ',0.00000';
       6 : ACBrNFeDANFeRL1.CasasDecimais.MaskvUnCom := ',0.000000';
       7 : ACBrNFeDANFeRL1.CasasDecimais.MaskvUnCom := ',0.0000000';
       8 : ACBrNFeDANFeRL1.CasasDecimais.MaskvUnCom := ',0.00000000';
    end;


    if dmPdv.qcds_ccusto.Active then
      dmPdv.qcds_ccusto.Close;
    dmPdv.qcds_ccusto.Params[0].AsString := conta_local;
    dmPdv.qcds_ccusto.Open;
    // populo a combobox
    dmPdv.qcds_ccusto.First;
    while not dmPdv.qcds_ccusto.Eof do
    begin
      ComboBox1.Items.Add(Trim(dmPdv.qcds_ccustoNOME.AsString));
      ComboBox2.Items.Add(Trim(dmPdv.qcds_ccustoNOME.AsString));
      cbEmpresa.Items.Add(Trim(dmPdv.qcds_ccustoNOME.AsString));
      dmPdv.qcds_ccusto.Next;
    end;
    if (dmPdv.qcds_ccusto.RecNo = 1) then
    begin
      ComboBox1.ItemIndex := 0;
      ComboBox2.ItemIndex := 0;
    end;

    if (dmPdv.qsEmpresa1.Active) then
      dmPdv.qsEmpresa1.Close;
    dmPdv.qsEmpresa1.Open;

    Edit1.Text := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString);
    Edit3.Text := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString);
    Edit6.Text := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString);
    edtPorta.Text := IntToStr(dmPdv.qsEmpresa1PORTA.AsInteger);
    edtSMTP.Text := dmPdv.qsEmpresa1SMTP.AsString;
    edtUsername.Text := dmPdv.qsEmpresa1E_MAIL.AsString;
    edtSenha.PasswordChar:=Chr(149);
    edtSenha.Font.Style:= edtSenha.Font.Style + [fsBold];
    edtSenha.Text := dmPdv.qsEmpresa1SENHA.Text;

    //onde       := Trim(dmPdv.qsEmpresa1TIPO.AsString);

    if (trim(dmPdv.qsEmpresa1TIPO.AsString) = '0') then
    begin
      ACBrNFe1.Configuracoes.WebServices.Ambiente := taHomologacao;
      label5.Font.Color := clRed;
      Label5.Caption :=  'HOMOLOGAÇÃO.';
      label8.Font.Color := clRed;
      Label8.Caption :=  'HOMOLOGAÇÃO.';
    end
    else
    begin
      ACBrNFe1.Configuracoes.WebServices.Ambiente := taProducao;
      label5.Font.Color := clBlue;
      Label5.Caption :=  'PRODUÇÃO.';
      label8.Font.Color := clBlue;
      Label8.Caption :=  'PRODUÇÃO.';
    end;
    ACBrNFe1.Configuracoes.Arquivos.PathNFe := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString);
    if ( not DirectoryExists(Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString))) then
       CreateDir(Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString));
    ACBrNFe1.Configuracoes.Arquivos.PathEvento := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString) + 'Canceladas\';
    if ( not DirectoryExists(ACBrNFe1.Configuracoes.Arquivos.PathEvento)) then
      CreateDir(ACBrNFe1.Configuracoes.Arquivos.PathEvento);
    ACBrNFe1.Configuracoes.Arquivos.PathEvento := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString) + 'CCe\';
    if ( not DirectoryExists(ACBrNFe1.Configuracoes.Arquivos.PathEvento)) then
      CreateDir(ACBrNFe1.Configuracoes.Arquivos.PathEvento);

    ACBrNFe1.Configuracoes.Arquivos.PathEvento := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString) + 'Inutilizadas\';
    if ( not DirectoryExists(ACBrNFe1.Configuracoes.Arquivos.PathEvento)) then
      CreateDir(ACBrNFe1.Configuracoes.Arquivos.PathEvento);
    ACBrNFe1.Configuracoes.Arquivos.PathNFe := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString);

    if ( not DirectoryExists(ACBrNFe1.Configuracoes.Arquivos.PathNFe)) then
    CreateDir(ACBrNFe1.Configuracoes.Arquivos.PathNFe);

    tp_amb := 1;

    diretorio := GetCurrentDir;
    diretorio_schema := diretorio + '\Schemas';
    //envemail := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString);
    ACBrNFe1.DANFE.PathPDF := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString) + '\';
    {if (FilesExists(diretorio + '\logo_nfe.jpg')) then
      ACBrNFeDANFCeFortes1.Logo := diretorio + '\logo_nfe.jpg';
    if (FilesExists(diretorio + '\logo.bmp')) then
      ACBrNFeDANFCeFortes1.Logo := diretorio + '\logo.bmp';
    ACBrNFeDANFCeFortes1.PathPDF := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString) + '\';}

    if (FilesExists(diretorio + '\logo.jpg')) then
      ACBrNFeDANFeRL1.Logo := diretorio + '\logo.jpg';
    if (FilesExists(diretorio + '\logo.bmp')) then
      ACBrNFeDANFeRL1.Logo := diretorio + '\logo.bmp';
    ACBrNFeDANFeRL1.PathPDF := Trim(dmPdv.qsEmpresa1DIVERSOS1.AsString) + '\';

    // tamanho da coluna produto na DANFE

    ACBrNFeDANFeRL1.LarguraCodProd := danfe_larg_codprod;

    ACBrNFe1.NotasFiscais.Add.NFe.Ide.tpEmis    := teNormal;
    ACBrNFe1.Configuracoes.Arquivos.PathSchemas := diretorio_schema;


    dmPdv.qsEmpresa1.Close;

    if dmPdv.qcds_parametro.Active then
      dmPdv.qcds_parametro.Close;
    dmPdv.qcds_parametro.Params[0].AsString := 'EMAILAUTOMATICO';
    dmPdv.qcds_parametro.Open;
    envemail := 'N';
    if (not dmPdv.qcds_parametro.IsEmpty) then
      envemail := Trim(dmPdv.qcds_parametroCONFIGURADO.AsString);

    dmPdv.qcds_parametro.Close;
  end;
  //messagedlg('Fim carrega tudo!',mterror,[mbok],0);
end;

procedure TfNFe.abrindoSistema;
var  CSize: DWORD;
     ccusto_emp : Integer;
     sq, sq_condicao, sq_condicao1: string;
begin
  //messagedlg('inicio abrindo sistema!',mterror,[mbok],0);
  edtChaveNfeCCe.Text := '';
  if (label26.Caption = '...') then
  begin
    label48.Caption := GetVersion;
    label26.caption := Trim(GetComputerNameFunc);

    lblSerieNfe.Caption := IntToStr(nfe_serie_receita);
    if (DateEdit1.Text = '') then
      DateEdit1.Text := DateToStr(Now);
    if (DateEdit2.Text = '') then
      DateEdit2.Text := DateToStr(Now);

    begin
      dmPdv.qsCentroCusto.Close;
      dmPdv.qsCentroCusto.SQL.Clear;
      sq := 'select  CODEMPRESA , NOMEEMPRESA , TIPONOTA, UCMACHINENAME,UCDATA, UCLOGIN ' +
        ' from UCTABUSERSLOGGED UL, uctabusers UU ' +
        ' WHERE ( (UL.uciduser = UU.uciduser)';
      sq_condicao := ' AND ( UL.nomeempresa <> ' + QuotedStr('') + ')';
      //ccusto_emp := Length(micro);
      sq_condicao1 := copy(micro,0,20);
      sq_condicao1 := ' AND (UL.UCMACHINENAME = ' + QuotedStr(Trim(sq_condicao1)) + ')';
      sq_condicao1 += ' ) ORDER BY UL.ucdata DESC';
      dmPdv.qsCentroCusto.SQL.Add(sq + sq_condicao + sq_condicao1);
      dmPdv.qsCentroCusto.Open;
      dmPdv.qcds_ccusto.First;
      While not dmPdv.qcds_ccusto.Eof do begin
        sq_condicao1 := IntToStr(dmPdv.qsCentroCustoCODEMPRESA.AsInteger);
        sq_condicao1 := IntToStr(dmPdv.qcds_ccustoCODIGO.AsInteger);
        if (dmPdv.qsCentroCustoCODEMPRESA.AsInteger = dmPdv.qcds_ccustoCODIGO.AsInteger) then
        begin
          ccusto_emp          := dmPdv.qcds_ccustoCODIGO.AsInteger;
          ComboBox1.ItemIndex := dmPdv.qcds_ccusto.RecNo-1;
          ComboBox2.ItemIndex := dmPdv.qcds_ccusto.RecNo-1;
          ComboBox1.Text      := Trim(dmPdv.qsCentroCustoNOMEEMPRESA.AsString);
          ComboBox2.Text      := Trim(dmPdv.qsCentroCustoNOMEEMPRESA.AsString);
          cbEmpresa.ItemIndex := dmPdv.qcds_ccusto.RecNo-1;
          cbEmpresa.Text      := Trim(dmPdv.qsCentroCustoNOMEEMPRESA.AsString);
        end;
        dmPdv.qcds_ccusto.Next;
      end;
      c_custo_open := IntToStr(dmPdv.qsCentroCustoTIPONOTA.AsInteger);
      c_custo_open := Copy(c_custo_open, 0, 1);
      cbTipoNota.ItemIndex := StrToInt(c_custo_open);
      c_custo_open := IntToStr(dmPdv.qsCentroCustoTIPONOTA.AsInteger);
      c_custo_open := Copy(c_custo_open, 1, Length(c_custo_open));
      Label25.Caption      := Trim(dmPdv.qsCentroCustoUCLOGIN.AsString);
    end;

    if(trim(dmPdv.qsCentroCustoNOMEEMPRESA.AsString) = '' ) then
    begin
      cbTipoNota.ItemIndex := 1;
    end;
    abrirEmpresa;
  end;
  if (ComboBox1.Text <> '') then
  begin
    //Seleciona Empresa de acordo com o CCusto selecionado
    // ja esta aberta 10/11/20
    {
    if (dmPdv.qsEmpresa.Active) then
      dmPdv.qsEmpresa.Close;
    dmPdv.qsEmpresa.Params[0].AsInteger := ccusto_emp;
    dmPdv.qsEmpresa.Open;}
    ACBrNFe1.Configuracoes.WebServices.UF := Trim(dmPdv.qsEmpresaUF.AsString);

    //  se e multi empresa carrega estes dados novamente
    if (not dmPdv.qsEmpresa.IsEmpty) then
    begin
      if(trim(dmPdv.qsEmpresaCERTIFICADO.AsString) <> '')then
      begin
        edtNumSerie.Text := Trim(dmPdv.qsEmpresaCERTIFICADO.AsString);
        edtNumSerie1.Text := Trim(dmPdv.qsEmpresaCERTIFICADO.AsString);
        edtNumSerie2.Text := Trim(dmPdv.qsEmpresaCERTIFICADO.AsString);
        edtNumSerieABA.Text := Trim(dmPdv.qsEmpresaCERTIFICADO.AsString);
      end;
      Edit1.Text := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString);
      Edit3.Text := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString);
      Edit6.Text := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString);
      //sq := trim(dmPdv.qsEmpresaTIPO.AsString);
      if (trim(dmPdv.qsEmpresaTIPO.AsString) = '0') then
      begin
        ACBrNFe1.Configuracoes.WebServices.Ambiente := taHomologacao;
        label5.Font.Color := clRed;
        Label5.Caption :=  'HOMOLOGAÇÃO.';
        label8.Font.Color := clRed;
        Label8.Caption :=  'HOMOLOGAÇÃO.';
      end
      else
      begin
        ACBrNFe1.Configuracoes.WebServices.Ambiente := taProducao;
        label5.Font.Color := clBlue;
        Label5.Caption :=  'PRODUÇÃO.';
        label8.Font.Color := clBlue;
        Label8.Caption :=  'PRODUÇÃO.';
      end;
      ACBrNFe1.Configuracoes.Arquivos.PathNFe := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString);
      if ( not DirectoryExists(Trim(dmPdv.qsEmpresaDIVERSOS1.AsString))) then
        CreateDir(Trim(dmPdv.qsEmpresaDIVERSOS1.AsString));
      ACBrNFe1.Configuracoes.Arquivos.PathEvento := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString) + 'Canceladas\';
      if ( not DirectoryExists(ACBrNFe1.Configuracoes.Arquivos.PathEvento)) then
        CreateDir(ACBrNFe1.Configuracoes.Arquivos.PathEvento);
      ACBrNFe1.Configuracoes.Arquivos.PathEvento := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString) + 'CCe\';
      if ( not DirectoryExists(ACBrNFe1.Configuracoes.Arquivos.PathEvento)) then
        CreateDir(ACBrNFe1.Configuracoes.Arquivos.PathEvento);
      ACBrNFe1.Configuracoes.Arquivos.PathEvento := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString) + 'Inutilizadas\';
      if ( not DirectoryExists(ACBrNFe1.Configuracoes.Arquivos.PathEvento)) then
        CreateDir(ACBrNFe1.Configuracoes.Arquivos.PathEvento);
      //ACBrNFe1.Configuracoes.Arquivos.PathNFe := dmPdv.qsEmpresaDIVERSOS1.AsString;

      if ( not DirectoryExists(ACBrNFe1.Configuracoes.Arquivos.PathNFe)) then
        CreateDir(ACBrNFe1.Configuracoes.Arquivos.PathNFe);

      //ACBrNFeDANFCeFortes1.PathPDF := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString)  + '\';

      ACBrNFeDANFeRL1.PathPDF := Trim(dmPdv.qsEmpresaDIVERSOS1.AsString)  + '\';
    end;
  end;
  LerConfiguracao;
  cstSuframa := '';
  nfe_carregalogo;
  //messagedlg('Fim abrindo sistema!',mterror,[mbok],0);
end;


{
procedure TfNFe.LoadXML(MyMemo: TMemo; MyWebBrowser: TSynMemo);
  var
    vText: String;
begin
  vText := MyMemo.Text;

  // formata resposta
  vText := StringReplace(vText, '>', '>' + LineEnding + '    ', [rfReplaceAll]);
  vText := StringReplace(vText, '<', LineEnding + '  <', [rfReplaceAll]);
  vText := StringReplace(vText, '>' + LineEnding + '    ' + LineEnding +
              '  <', '>' + LineEnding + '  <', [rfReplaceAll]);
  vText := StringReplace(vText, '  </ret', '</ret', []);

  // exibe resposta
  MyWebBrowser.Text := Trim(vText);

end;
}
function TfNFe.GerarNFe: Boolean;
var i: integer;
     var_str: String;
     NotaF: NotaFiscal;
begin
  ///*
  codnf := 0;
  if (edtNumSerie.Text = '') then
  begin
    MessageDlg('Selecione o Certificado!',mtWarning,[mbOk],0);
    Result := False;
    Exit;
  end;
  if (tp_amb = 3) then
  begin
    if (validaNumNfeScan = false) then
    begin
        MessageDlg('Número da Nota Fiscal errado.', mtError, [mbOK], 0);
        Result := False;
    end;
  end;
  lblMsgNfe.Caption := 'Gerando o arquivo da Nota';

  ///*

  abrirEmpresa;

  if(dmPdv.qsEmpresaCONTADOR_CPF.AsString <> '')then
  begin
     pCNPJ_CPF := dmPdv.qsEmpresaCONTADOR_CPF.AsString;
  end;

  if(dmPdv.qsEmpresaCONTADOR_CNPJ.AsString <> '')then
  begin
       pCNPJ_CPF := dmPdv.qsEmpresaCONTADOR_CNPJ.AsString;
  end;

  ///
  ACBrNFe1.Configuracoes.WebServices.UF := dmPdv.qsEmpresaUF.AsString;
  ///

  nfe_carregalogo;

  //verifica se o CC foi selecionado caso não da mensagem avisando
  if(dmPdv.qsEmpresa.IsEmpty) then
  begin
      MessageDlg('Centro de custo não selecionado', mtError, [mbOK], 0);
      Result := False;
      Exit;
  end;

  dmPdv.qcdsNF.First;
  while not dmPdv.qcdsNF.Eof do
  begin
    var_str := trim(dmPdv.qcdsNFSELECIONOU.AsString);
    if (trim(dmPdv.qcdsNFSELECIONOU.AsString) = 'S') or (Trim(dmPdv.qcdsNF.FieldByName('NUMNF').AsString) = nota_selec) then
    begin
      if (dmPdv.qcdsNFSTATUS.AsString = 'E') then
      begin
        MessageDlg('Nota com Status ENVIADO, altere o Status na aba OUTROS para reenviar.',mtWarning,[mbOk],0);
        Result := False;
        Exit;
      end;
      if(not dmPdv.qcdsNFPROTOCOLOENV.IsNull) then
      begin
        if (trim(dmPdv.qcdsNFPROTOCOLOENV.AsString) <> '') then
        begin
          MessageDlg('Nota com Protocolo de Envio(já enviada, portanto), use o botão Imprimir Danfe.',mtWarning,[mbOk],0);
          Result := False;
          Exit;
        end;
      end;
      codnf := dmPdv.qcdsNFNUMNF.AsInteger;
      tipoNota := trim(dmPdv.qcdsNFCFOP.AsString)[1];
      if (tipoNota in ['1','2','3']) then
        tpNFe := 0;
      if (tipoNota in ['5','6','7']) then
        tpNFe := 1;
      if (cbTipoNota.ItemIndex = 1) then
      begin
        if (dmPdv.qsFornec.Active) then
          dmPdv.qsFornec.Close;

        if (dmPdv.qsCliente.Active) then
          dmPdv.qsCliente.Close;
        dmPdv.qsCliente.Params[0].AsInteger := dmPdv.qcdsNFCODCLIENTE.AsInteger;
        dmPdv.qsCliente.Open;
        codFisc := dmPdv.qsClienteCODFISCAL.AsString;
        if (trim(dmPdv.qsClienteCODFISCAL.AsVariant) = '') then
        begin
          MessageDlg(dmPdv.qsClienteNOMECLIENTE.AsString +
            ' - informe o CODIGO FISCAL no cadastro do cliente.',
              mtWarning, [mbOK], 0);
          Result := False;
          Exit;
        end;

        if ((trim(dmPdv.qsClienteUF.AsString) = 'EX') and (trim(dmPdv.qcdsNFCFOP.AsString) <> '3202'))  then
        begin
          if (edUfEmbarque.Text = '') then
          begin
            MessageDlg('Preencha o UF e Local de Embarque.', mtWarning, [mbOK], 0);
            PageControl2.ActivePage := TabSheet7;
            edUfEmbarque.SetFocus;
            Result := False;
            Exit;
          end;
        end;
      end
      else begin
          if (dmPdv.qsCliente.Active) then
            dmPdv.qsCliente.Close;

          if (dmPdv.qsFornec.Active) then
            dmPdv.qsFornec.Close;
          dmPdv.qsFornec.Params[0].AsInteger := dmPdv.qcdsNFCODCLIENTE.AsInteger;
          dmPdv.qsFornec.Open;

          codFisc := dmPdv.qsFornecCODFISCAL.AsString;
          if (dmPdv.qsFornecCODFISCAL.AsString = '') then
          begin
            MessageDlg(dmPdv.qsFornecNOMECLIENTE.AsString +
              ' - informe o CODIGO FISCAL no cadastro do fornecedor.',
              mtWarning, [mbOK], 0);
            Result := False;
            Exit;
          end;
      end;
      ///
      if (dmPdv.qsCFOP.Active) then
        dmPdv.qsCFOP.Close;
      if (cbTipoNota.ItemIndex = 1) then
      begin
        dmPdv.qsCFOP.Params[0].AsString := dmPdv.qsClienteUF.AsString;
        dmPdv.qsCFOP.Params[1].AsString := dmPdv.qcdsNFCFOP.AsString;
        ufDest := dmPdv.qsClienteUF.AsString;
      end
      else begin
        dmPdv.qsCFOP.Params[0].AsString := dmPdv.qsFornecUF.AsString;
        dmPdv.qsCFOP.Params[1].AsString := dmPdv.qcdsNFCFOP.AsString;
        ufDest := dmPdv.qsFornecUF.AsString;
      end;
      dmPdv.qsCFOP.Open;
      if (dmPdv.qsCFOP.IsEmpty) then
      begin
        MessageDlg('Não existe este CFOP cadastrado para este ESTADO.'+#13+#10+'(Cadastros -> CFOP-ESTADO).', mtWarning, [mbOK], 0);
        Result := False;
        Exit;
      end;
      ///
      ACBrNFe1.NotasFiscais.Clear;
      with ACBrNFe1.NotasFiscais.Add.NFe do
      begin
        //infNFe.ID := 0    // Chave de acesso da NF-e precedida do literal NFe acrescentado a validação do formato 2.0
        if (dmPdv.qsEstado.Active) then
          dmPdv.qsEstado.Close;
        dmPdv.qsEstado.Params[0].AsString := dmPdv.qsEmpresaUF.asString;
        dmPdv.qsEstado.Open;
        Ide.cUF       := dmPdv.qsEstadoCODIGO.AsInteger;   // Codigo do UF do Emitente do documento fiscal
        Ide.cNF       := (dmPdv.qcdsNFNUMNF.AsInteger*99) ; //Para não ser o mesmo numero

        Ide.natOp     := copy(dmPdv.qsCFOPCFNOME.AsString,0,59);
           //Verifica tipo de Pagamento
        getPagamento;
        try
          Ide.cMunFG    := StrToInt(RemoveChar(dmPdv.qsEmpresaCD_IBGE.AsString));
        except
          MessageDlg('Codigo do IBGE do Emitente não informado(Cadastro Empresa)', mtError, [mbOK], 0);
          Result := False;
          Exit;
        end;
        Ide.modelo    := 55;
        if (tp_amb = 1) then
        begin
          Ide.serie     := nfe_serie_receita;
          Ide.tpEmis    := teNormal;
        end
        else if (tp_amb = 2) then
        begin
          Ide.tpEmis    := teContingencia;
          Ide.serie     := nfe_serie_receita;
        end
        else if (tp_amb = 3) then
        begin
          Ide.tpEmis    := teSCAN;
          Ide.serie     := 900;
        end
        else if (tp_amb = 4) then
        begin
          Ide.tpEmis    := teDPEC;
          Ide.serie     := nfe_serie_receita;
        end
        else if (tp_amb = 5) then
        begin
          Ide.tpEmis    := teFSDA;
          Ide.serie     := nfe_serie_receita;
        end
        else if (tp_amb = 6) then
        begin
          Ide.tpEmis    := teSVCAN;
          Ide.serie     := nfe_serie_receita;
        end;

        // Reforma Tributaria   5 – Nota de Crédito 6 – Nota de Débito
        if(dmPdv.ReformaTributaria = 'SIM')then
        begin
         // NotaF := ACBrNFe1.NotasFiscais.Add;
         // NotaF.NFe.Ide.cMunFGIBS := 717177;
        end;

        // pcNao, pcPresencial, pcInternet, pcTeleatendimento, pcEntregaDomicilio, pcPresencialForaEstabelecimento, pcOutros
        if (dmPdv.qcdsNFNFE_INDPRES.AsString = 'pcPresencial') then
          ide.indPres := pcPresencial
        else if (dmPdv.qcdsNFNFE_INDPRES.AsString = 'pcNao') then
          ide.indPres := pcNao
        else if (dmPdv.qcdsNFNFE_INDPRES.AsString = 'pcInternet') then
          ide.indPres := pcInternet
        else if (dmPdv.qcdsNFNFE_INDPRES.AsString = 'pcTeleatendimento') then
          ide.indPres := pcTeleatendimento
        else if (dmPdv.qcdsNFNFE_INDPRES.AsString = 'pcPresencialForaEst.') then
          ide.indPres := pcPresencialForaEstabelecimento
        else if (dmPdv.qcdsNFNFE_INDPRES.AsString = 'pcEntregaDomicilio') then
          ide.indPres := pcEntregaDomicilio
        else if (dmPdv.qcdsNFNFE_INDPRES.AsString = 'pcOutros') then
          ide.indPres := pcOutros;
        //iiSemOperacao, iiOperacaoSemIntermediador, iiOperacaoComIntermediador)
        if ((dmPdv.qcdsNFNFE_INDPRES.AsString = 'pcNao') or
          (dmPdv.qcdsNFNFE_INDPRES.AsString = 'pcPresencial')) then
          ide.indIntermed := iiSemOperacao
        else begin
          ide.indIntermed := iiOperacaoSemIntermediador;
          if (RemoveChar(Trim(dmPdv.qcdsNFINTERM_CNPJ.AsString)) <> '') then
          begin
            ide.indIntermed := iiOperacaoComIntermediador;
            infIntermed.CNPJ := RemoveChar(Trim(dmPdv.qcdsNFINTERM_CNPJ.AsString));
            infIntermed.idCadIntTran := dmPdv.qcdsNFINTERM_PERFIL.AsString;
          end;
        end;
        if (tpNFe = 0) then
        begin
           ide.indPres := pcNao;
           ide.indIntermed:= iiSemOperacao;
        end;

        //Carrega os itens da NF
        pegaItens(cbTipoNota.ItemIndex);

        if((dmPdv.qcdsNFIDCOMPLEMENTAR.IsNull) or (dmPdv.qcdsNFIDCOMPLEMENTAR.AsString = '')) then
          ide.finNFe    := fnNormal
        else begin
          ide.finNFe    := fnComplementar;
        end;

        if (length(dmPdv.qcdsNFIDCOMPLEMENTAR.AsString) > 20) then
        begin
           ide.NFref.Add.refNFe := dmPdv.qcdsNFIDCOMPLEMENTAR.AsString;
        end;

        Ide.nNF       := StrToInt(dmPdv.qcdsNFNOTASERIE.AsString);
        Ide.dEmi      := dmPdv.qcdsNFDTAEMISSAO.AsDateTime;
        Ide.dSaiEnt   := dmPdv.qcdsNFDTASAIDA.AsDateTime;
        Ide.hSaiEnt   := dmPdv.qcdsNFHORASAIDA.AsDateTime;


        if (dmPdv.qcdsNFNFE_FINNFE.AsString = 'fnAjuste') then
        begin
          InputQuery('Justificativa do estorno nas Informações Adicionais de Interesse do Fisco', 'Justificativa', vAux);
          infAdic.infAdFisco := vAux;
        end;



        if (dmPdv.qcdsNFCORPONF6.AsString <> '') then
        begin
          compra.xPed := dmPdv.qcdsNFCORPONF6.AsString;
        end;

        // Tipo de movimentação 0 entrada 1 saida
        if (tpNFe = 0) then
          Ide.tpNF   := tnEntrada;

        if (tpNFe = 1) then
          Ide.tpNF   := tnSaida;

        if (tipoNota in ['1','5']) then
          ide.idDest := doInterna;

        if (tipoNota in ['2','6']) then
          ide.idDest := doInterestadual;

        ///
        if (tipoNota in ['3', '7']) then
        begin
          ide.idDest := doExterior;
          if (cbTipoNota.ItemIndex = 0) then
             Dest.idEstrangeiro := dmPdv.qsFornecINSCESTADUAL.AsString
          else
             Dest.idEstrangeiro := dmPdv.qsClienteINSCESTADUAL.AsString;
          Dest.indIEDest := inNaoContribuinte;
        end;

        ///

        {Ide.tpAmb     := tn2;                           // 1 - Produção // 2 Homologação}
        Ide.verProc   := '1.0.0.0';

        // Responsavel Tecnico
        ACBrNFe1.NotasFiscais.Items[0].NFe.infRespTec.CNPJ := '08382545000111';
        ACBrNFe1.NotasFiscais.Items[0].NFe.infRespTec.xContato := 'CARLOS RODRIGUES SILVEIRA';
        ACBrNFe1.NotasFiscais.Items[0].NFe.infRespTec.email := 'ats@atsti.com.br';
        ACBrNFe1.NotasFiscais.Items[0].NFe.infRespTec.fone :='19974014694';
        if((trim(dmPdv.qsEmpresaCONTADOR_CNPJ.AsString) <> '') or
          (trim(dmPdv.qsEmpresaCONTADOR_CPF.AsString) <> '')) then
        begin
          with autXML.Add do
          begin
             CNPJCPF := pCNPJ_CPF;
          end;
        end;

        ///
        if (dmPdv.qcdsNFNFE_FINNFE.AsString = 'fnNormal') then
          Ide.finNFe := fnNormal;

        if (dmPdv.qcdsNFNFE_FINNFE.AsString = 'fnDevolucao') then
          Ide.finNFe := fnDevolucao;

        if (dmPdv.qcdsNFNFE_FINNFE.AsString = 'fnAjuste') then
          Ide.finNFe := fnAjuste;

        if (dmPdv.qcdsNFNFE_FINNFE.AsString = 'fnComplementar') then
          ide.finNFe    := fnComplementar;
        ///

        if (dmPdv.sTabIBGE.Active) then
          dmPdv.sTabIBGE.Close;
        dmPdv.sTabIBGE.Params[0].AsString := dmPdv.qsEmpresaCIDADE.AsString;
        dmPdv.sTabIBGE.Open;
        //Carrega dados do Emitente
        //VERIFICA SE CODIGO IBGE ESTÁ PREENCHIDO NA EMPRESA
        if ( (dmPdv.qsEmpresaCD_IBGE.IsNull) or (dmPdv.qsEmpresaCD_IBGE.AsString = '') ) then
        begin
          MessageDlg('Codigo do IBGE da empresa não definido', mtError, [mbOK], 0);
          valida := 'N';
          Result := False;
          Exit;
        end;

        getEmpresa();
        //CARREGA OS DADOS DO DESTINATARIO CLIENTE/FORNECEDOR
        if( dmPdv.qsFornec.Active) then
          if ((dmPdv.qsFornecCD_IBGE.IsNull) or (dmPdv.qsFornecCD_IBGE.AsString = '') ) then
          begin
            MessageDlg('Codigo do IBGE do Fornecedor não definido', mtError, [mbOK], 0);
            Result := False;
            Exit;
          end;
        if(dmPdv.qsCliente.Active) then
          if ((dmPdv.qsClienteCD_IBGE.IsNull) or (dmPdv.qsClienteCD_IBGE.AsString = '') ) then
          begin
            MessageDlg('Codigo do IBGE do Cliente não definido', mtError, [mbOK], 0);
            Result := False;
            Exit;
          end;
        getCLi_Fornec();
        ///
        ide.indFinal := cfNao;
        if (vTipoFiscal = '9') then
          ide.indFinal  := cfConsumidorFinal; //(cfNao, cfConsumidorFinal);

        pegaItens(cbTipoNota.ItemIndex);
        tot1 := 0;
        tot2 := 0;
        tot3 := 0;
        tot4 := 0;

        infCplTrib := '';
        //if ((cdsNFVLRTOT_TRIB.AsFloat > 0) and (dm.vTipoFiscal = '9'))  then
        if (dmPdv.qcdsNFVLRTOT_TRIB.AsFloat > 0)  then
        begin
          pegaTributos(dmPdv.cdsItensNFCODMOVIMENTO.AsInteger, 0);
          infCplTrib := 'Trib aprox R$:' +
            format('%8.2n', [dmPdv.sqlTotal_tributos.Fields[0].AsFloat]) + '-Fed, ' +
            format('%8.2n', [dmPdv.sqlTotal_tributos.Fields[1].AsFloat]) + '-Est e ' +
            format('%8.2n', [dmPdv.sqlTotal_tributos.Fields[2].AsFloat]) + '-Mun ';
          infCplTrib := infCplTrib + 'Fonte: IBPT';//Fonte: IBPT/FECOMERCIO RJ Xe67eQ
        end;

        infCplTrib := dmPdv.qcdsNFCORPONF1.AsString + ' ' + dmPdv.qcdsNFCORPONF2.AsString + ' ' +
          dmPdv.qcdsNFCORPONF3.AsString + ' ' + dmPdv.qcdsNFCORPONF4.AsString + ' ' +
          dmPdv.qcdsNFCORPONF5.AsString + infCplTrib; // + ' ' + cdsNFCORPONF6.AsString;(usando para codigo pedido de compra)

        InfAdic.infCpl := infCplTrib;

        i := 1;
        total_ibs := 0;  // reforma tributaria
        total_cbs :=0;

        while not dmPdv.cdsItensNF.Eof do // Escrevo os itens
        begin
          if (dmPdv.qsProdutos.Active) then
            dmPdv.qsProdutos.Close;
          dmPdv.qsProdutos.Params[0].AsInteger := dmPdv.cdsItensNFCODPRODUTO.AsInteger;
          dmPdv.qsProdutos.Open;

          if ((dmPdv.cdsItensNFUNIDADEMEDIDA.AsString = '') or
            (dmPdv.cdsItensNFUNIDADEMEDIDA.IsNull) or (dmPdv.cdsItensNFUNIDADEMEDIDA.AsString = ' ')) then
          begin
            MessageDlg('Produto ' + dmPdv.cdsItensNFDESCPRODUTO.AsString + ' sem Unidade de Medida', mtError, [mbOK], 0);
            Result := False;
            Exit;
          end;
          if (dmPdv.qsProdutosNCM.IsNull) then
          begin
            MessageDlg('Produto ' + dmPdv.cdsItensNFDESCPRODUTO.AsString + ' com NCM Nulo ou Inválido', mtError, [mbOK], 0);
            Result := False;
            Exit;
          end;
          if ((dmPdv.qsProdutosORIGEM.IsNull) ) then
          begin
            MessageDlg('Produto ' + dmPdv.cdsItensNFDESCPRODUTO.AsString + ' com Origem Nula', mtError, [mbOK], 0);
            Result := False;
            Exit;
          end;
          if (((dmPdv.cdsItensNFCSOSN.IsNull) or (dmPdv.cdsItensNFCSOSN.AsString = '')) and ((dmPdv.cdsItensNFCST.IsNull) or (dmPdv.cdsItensNFCST.AsString = ''))) then
          begin
            MessageDlg('Produto ' + dmPdv.cdsItensNFDESCPRODUTO.AsString + ' sem CST ou CSOSN', mtError, [mbOK], 0);
            Result := False;
            Exit;
          end;

          // DADOS DOS PRODUTOS DA NOTA
          getItens(i);
          i := i + 1;
          dmPdv.cdsItensNF.Next;
        end;


        //end; // fim with nfe
        getTransportadora();

        if (dmPdv.qsCliente.Active) then
        if ((trim(dmPdv.qsClienteUF.AsString) = 'EX') and (trim(dmPdv.qcdsNFCFOP.AsString) <> '3202'))  then
        begin
          exporta.UFembarq := edUfEmbarque.Text;
          exporta.xLocEmbarq := edLocalEmbarque.Text;
          exporta.UFSaidaPais:= edUfEmbarque.Text;
          exporta.xLocExporta:= Edit2.Text;
          exporta.xLocDespacho:= edit4.Text;
        end;

        // NotaF.NFe.Total.ISTot.vIS := 999;
        //VALOR TORAL
        cst_utilizado := Trim(dmPdv.cdsItensNFCSOSN.AsString);
        if not ((ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional) and (dmPdv.cdsItensNFCSOSN.AsString <> '900')) then
        begin
          if ((cstSuframa = '00') OR ( pSuframa = '')) then
          begin
            Total.ICMSTot.vBC   := dmPdv.qcdsNFBASE_ICMS.AsVariant;
            Total.ICMSTot.vICMS   := dmPdv.qcdsNFVALOR_ICMS.AsVariant;
          end;
        end;
        Total.ICMSTot.vBCST := dmPdv.qcdsNFBASE_ICMS_SUBST.AsVariant;
        Total.ICMSTot.vST   := dmPdv.qcdsNFVALOR_ICMS_SUBST.AsVariant;
        Total.ICMSTot.vProd := dmPdv.qcdsNFVALOR_PRODUTO.AsVariant;
        try
          Total.ICMSTot.vFrete := dmPdv.qcdsNFVALOR_FRETE.AsVariant;
        except
          Total.ICMSTot.vFrete := 0;
        end;
        try
          Total.ICMSTot.vSeg := dmPdv.qcdsNFVALOR_SEGURO.AsVariant;
        except
          Total.ICMSTot.vSeg := 0;
        end;
        try
          if (dmPdv.qcdsNFVALOR_DESCONTO.AsVariant > 0) then
            Total.ICMSTot.vDesc := (dmPdv.qcdsNFVALOR_DESCONTO.AsVariant);
        except
          Total.ICMSTot.vDesc := roundto(0,-2);
        end;
        Total.ICMSTot.vIPI := dmPdv.qcdsNFVALOR_IPI.AsVariant;
        if ((dmPdv.qcdsNFVALOR_PIS.AsFloat <> 0 )or (dmPdv.qcdsNFVALOR_PIS.AsFloat <> null )) then
          Total.ICMSTot.vPIS := dmPdv.qcdsNFVALOR_PIS.AsFloat;
        if ((dmPdv.qcdsNFVALOR_COFINS.AsFloat <> 0) or (dmPdv.qcdsNFVALOR_COFINS.AsFloat <> null )) then
          Total.ICMSTot.vCOFINS := dmPdv.qcdsNFVALOR_COFINS.AsFloat;
        Total.ICMSTot.vOutro := dmPdv.qcdsNFOUTRAS_DESP.AsVariant;
        Total.ICMSTot.vICMSUFDest:=tot2;
        Total.ICMSTot.vFCPUFDest:=tot4;


        // Reforma Tributaria

        total_nota := dmPdv.qcdsNFVALOR_TOTAL_NOTA.AsFloat - dmPdv.qcdsNFVALOR_ICMS.AsFloat - dmPdv.qcdsNFVALOR_IPI.AsFloat
        - dmPdv.qcdsNFVALOR_COFINS.AsFloat - dmPdv.qcdsNFVALOR_PIS.AsFloat;

        if(dmPdv.ReformaTributaria = 'SIM')then
        begin
          Total.IBSCBSTot.vBCIBSCBS := total_nota;


          Total.IBSCBSTot.gIBS.vIBS := ((total_nota*pIBS)/100);



          if(pIBS_CBS <> '000')then
          begin
            pA := ((100 - pReducao)/100);
            pA :=  (pA*(pIBS))/100;
            pA := ((total_nota)*(pA));

            Total.IBSCBSTot.gIBS.vIBS  := total_ibs ;
          end;



          //Total.IBSCBSTot.gIBS.vCredPres := 0.00;
          //Total.IBSCBSTot.gIBS.vCredPresCondSus := 0.00;

          // conferir como deve ser 14/11/2025 e corrigir

          Total.IBSCBSTot.gIBS.gIBSUFTot.vDif := 0.00;
          Total.IBSCBSTot.gIBS.gIBSUFTot.vDevTrib := 0.00;

         // Total.IBSCBSTot.gIBS.gIBSUFTot.vIBSUF := ((dmPdv.qcdsNFVALOR_TOTAL_NOTA.AsVariant*0.10)/100);

         // if(pIBS_CBS <> '000')then
         // begin
            pA := ((100 - pReducao)/100);

            pA :=  (pA*(pIBS))/100;

            pA := ((total_nota)*(pA));

            Total.IBSCBSTot.gIBS.gIBSUFTot.vIBSUF := total_ibs ;
         // end;

          Total.IBSCBSTot.gIBS.gIBSMunTot.vDif := 0.00;
          Total.IBSCBSTot.gIBS.gIBSMunTot.vDevTrib := 0.00;
          Total.IBSCBSTot.gIBS.gIBSMunTot.vIBSMun := 0.00;

          Total.IBSCBSTot.gCBS.vDif := 0.00;
          Total.IBSCBSTot.gCBS.vDevTrib := 0.00;

        //  Total.IBSCBSTot.gCBS.vCBS := ((dmPdv.qcdsNFVALOR_TOTAL_NOTA.AsVariant* pReducaoCBS)/100);


        pA := ((100 - pReducao)/100);

        pA := (pA*(pCBS))/100;

        pA := (total_nota)*(pA);


        //if(pIBS_CBS <> '000')then
       // begin
          Total.IBSCBSTot.gCBS.vCBS := total_cbs ;
       // end;




          Total.IBSCBSTot.gCBS.vCredPres := 0.00;
          Total.IBSCBSTot.gCBS.vCredPresCondSus := 0.00;

        end;

        Total.ICMSTot.vNF   := dmPdv.qcdsNFVALOR_TOTAL_NOTA.AsVariant;
        Total.ICMSTot.vTotTrib := dmPdv.qcdsNFVLRTOT_TRIB.AsVariant;

        if (totIPIDevol > 0) then
           Total.ICMSTot.vIPIDevol := totIPIDevol;

        if (dmPdv.qcdsNFII.AsFloat > 0) then
        begin
          Total.ICMSTot.vII := dmPdv.qcdsNFII.AsFloat;
        end;
        if ((cstSuframa <> '00') and ( pSuframa <> '')) then
        begin
          // comentei o if abaixo por causa da DNZ
          if (cst_utilizado <> '101') then  // foi descomentado dia 15/09/2025 Velopark
            Total.ICMSTot.vICMSDeson := dmPdv.qcdsNFVALOR_ICMS.AsVariant;
        end;
      end;
      break; // saio do while se a já peguei a nota selecionada
    end; // fim do if (se nota selecionada)
    dmPdv.qcdsNF.Next;

  end; // fim do 1. while

  AcbrNfe1.Configuracoes.Arquivos.PathNFe := Edit1.Text;
  ACBrNFe1.NotasFiscais.Items[0].GravarXML;
  //MemoResp.Lines.LoadFromFile(ACBrNFe1.Configuracoes.Arquivos.PathSalvar+'\' +copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, (length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml');
  //MessageDlg('Arquivo gerado com sucesso.', mtInformation, [mbOK], 0);
  Result := True;
end;

function TfNFe.GetVersion: string;
 var
   VerInfoSize: DWORD;
   VerInfo: Pointer;
   VerValueSize: DWORD;
   VerValue: PVSFixedFileInfo;
   Dummy: DWORD;
 begin
   Result := '';
   VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
   if VerInfoSize = 0 then Exit;
   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
   VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
   with VerValue^ do
   begin
     Result := IntToStr(dwFileVersionMS shr 16);
     Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
     Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
     Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
   end;
   FreeMem(VerInfo, VerInfoSize);
end;








end.

