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
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    edtCaracAdTrans1: TEdit;
    edtCaracAdTrans2: TEdit;
    edtCaracAdTrans3: TEdit;
    edtCodEmitente: TEdit;
    edtEmitBairro: TEdit;
    edtCaracAdTrans: TEdit;
    edtCaracAdServ: TEdit;
    edtFuncEmi: TEdit;
    edtNumCte10: TEdit;
    edtNumCte21: TEdit;
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
    memDetRetira: TStaticText;
    memDetRetira1: TStaticText;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    PageControl4: TPageControl;
    PageControl5: TPageControl;
    Panel1: TPanel;
    rgFormaEmissao: TRadioGroup;
    rgGlobalizado: TRadioGroup;
    rgModal: TRadioGroup;
    rgModal1: TRadioGroup;
    rgModal2: TRadioGroup;
    rgDest: TRadioGroup;
    rgRetira1: TRadioGroup;
    rgRetira2: TRadioGroup;
    rgTiposCte: TRadioGroup;
    rgTipoServico: TRadioGroup;
    rgRec: TRadioGroup;
    rgTomador: TRadioGroup;
    rgTipoServico2: TRadioGroup;
    rgTipoServico3: TRadioGroup;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    TabSheet19: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet20: TTabSheet;
    TabSheet22: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    procedure StaticText7Click(Sender: TObject);
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

end.

