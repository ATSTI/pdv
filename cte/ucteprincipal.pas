unit uCtePrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Menus, Types;

type

  { TfCTePrincipal }

  TfCTePrincipal = class(TForm)
    edtModelo: TEdit;
    edtNumCte1: TEdit;
    edtNumCte10: TEdit;
    edtNumCte11: TEdit;
    edtNumCte12: TEdit;
    edtNumCte13: TEdit;
    edtNumCte14: TEdit;
    edtNumCte15: TEdit;
    edtNumCte16: TEdit;
    edtNumCte17: TEdit;
    edtNumCte18: TEdit;
    edtNumCte19: TEdit;
    edtNumCte2: TEdit;
    edtNumCte20: TEdit;
    edtNumCte21: TEdit;
    edtNumCte22: TEdit;
    edtNumCte23: TEdit;
    edtNumCte24: TEdit;
    edtNumCte26: TEdit;
    edtNumCte3: TEdit;
    edtNumCte4: TEdit;
    edtNumCte5: TEdit;
    edtNumCte6: TEdit;
    edtNumCte7: TEdit;
    edtNumCte8: TEdit;
    edtNumCte9: TEdit;
    edtSerieCte: TEdit;
    edtNumCte: TEdit;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    Panel1: TPanel;
    rgModal: TRadioGroup;
    rgGlobalizado: TRadioGroup;
    rgModal1: TRadioGroup;
    rgModal2: TRadioGroup;
    rgTipoServico: TRadioGroup;
    rgTiposCte: TRadioGroup;
    rgFormaEmissao: TRadioGroup;
    StaticText1: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    procedure Label15Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure rgModalClick(Sender: TObject);
    procedure TabSheet6ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private

  public

  end;

var
  fCTePrincipal: TfCTePrincipal;

implementation

{$R *.lfm}

{ TfCTePrincipal }

procedure TfCTePrincipal.rgModalClick(Sender: TObject);
begin

end;

procedure TfCTePrincipal.PageControl2Change(Sender: TObject);
begin

end;

procedure TfCTePrincipal.Label7Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.Label15Click(Sender: TObject);
begin

end;

procedure TfCTePrincipal.TabSheet6ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

end.

