unit uClienteCadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, ComCtrls, Buttons, udmpdv, Types;

type

  { TfClienteCadastro }

  TfClienteCadastro = class(TForm)
    btnProcurar: TBitBtn;
    procedure btnGravar2Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabSheet5ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private

  public

  end;

var
  fClienteCadastro: TfClienteCadastro;

implementation

{$R *.lfm}

{ TfClienteCadastro }

procedure TfClienteCadastro.TabSheet1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TfClienteCadastro.TabSheet5ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TfClienteCadastro.Panel2Click(Sender: TObject);
begin

end;

procedure TfClienteCadastro.btnGravar2Click(Sender: TObject);
begin

end;

procedure TfClienteCadastro.PageControl1Change(Sender: TObject);
begin

end;

end.

