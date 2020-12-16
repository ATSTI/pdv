unit uprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, ExtCtrls,
  StdCtrls, Buttons, DBGrids, ComCtrls, udm, DateTimePicker, DB;

type

  { TfPrincipal }

  TfPrincipal = class(TForm)
    btnNFce2: TBitBtn;
    btnNovo: TBitBtn;
    btnSair1: TBitBtn;
    Image2: TImage;
    procedure btnNFce2Click(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSair1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fPrincipal: TfPrincipal;

implementation

uses uBuscaOrc, uLancados;

{$R *.lfm}

{ TfPrincipal }

procedure TfPrincipal.FormShow(Sender: TObject);
begin
  if (dm.sqEmpresa.Active) then
  dm.sqEmpresa.Close;
  dm.sqEmpresa.Open;
end;

procedure TfPrincipal.btnSair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfPrincipal.btnNovoClick(Sender: TObject);
begin
  fLancados.ShowModal;
end;

procedure TfPrincipal.btnNFce2Click(Sender: TObject);
begin
  fBuscaOrc.ShowModal;
end;

end.

