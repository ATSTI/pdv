unit uPadrao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DbCtrls, StdCtrls, uDm;
type

  { TfPadrao }

  TfPadrao = class(TForm)
    btnClose: TImage;
    ds: TDataSource;
    btnINC: TImage;
    btnEDT: TImage;
    btnEXC: TImage;
    btnPROC: TImage;
    btnCANC: TImage;
    btnSALV: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure btnCANC1Click(Sender: TObject);
    procedure btnCANCClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnEDTClick(Sender: TObject);
    procedure btnEXCClick(Sender: TObject);
    procedure btnINCClick(Sender: TObject);
    procedure btnPROCClick(Sender: TObject);
    procedure btnSALVClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ControlaBotoes;
    procedure HabilitaEdicao(Status:Boolean);
  public

  end;

var
  fPadrao: TfPadrao;

implementation


{$R *.lfm}

{ TfPadrao }

procedure TfPadrao.FormCreate(Sender: TObject);
begin
  btnINC.Visible := not(ds.DataSet.State in [DsInsert,DsEdit]);
  btnEDT.Visible := not(ds.DataSet.State in [DsInsert,DsEdit]);
  btnEXC.Visible := not(ds.DataSet.State in [DsInsert,DsEdit]);
  btnPROC.Visible := not(ds.DataSet.State in [DsInsert,DsEdit]);
  btnSALV.Visible := (ds.DataSet.State in [DsInsert,DsEdit]);
  btnCANC.Visible := (ds.DataSet.State in [DsInsert,DsEdit]);
end;

procedure TfPadrao.FormShow(Sender: TObject);
begin
  HabilitaEdicao(false);
  ds.DataSet.Active:=True;
end;

procedure TfPadrao.btnINCClick(Sender: TObject);
begin
  if (ds.DataSet.State in [dsBrowse, dsInactive]) then
    ds.DataSet.Active:=True;
  ds.DataSet.Insert;
  ControlaBotoes;
  HabilitaEdicao(true);
end;

procedure TfPadrao.btnPROCClick(Sender: TObject);
begin
  ControlaBotoes;
  HabilitaEdicao(false);
end;

procedure TfPadrao.btnSALVClick(Sender: TObject);
begin
  if (ds.DataSet.State in [dsEdit, dsInsert]) then
    ds.DataSet.Post;
  ControlaBotoes;
  HabilitaEdicao(false);
end;

procedure TfPadrao.btnEDTClick(Sender: TObject);
begin
  ds.DataSet.Edit;
  ControlaBotoes;
  HabilitaEdicao(true);
end;

procedure TfPadrao.btnCANCClick(Sender: TObject);
begin
  ds.DataSet.Cancel;
  ControlaBotoes;
  HabilitaEdicao(false);
end;

procedure TfPadrao.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfPadrao.btnCANC1Click(Sender: TObject);
begin

end;

procedure TfPadrao.btnEXCClick(Sender: TObject);
begin
  ds.DataSet.Delete;
  ControlaBotoes;
  HabilitaEdicao(false);
end;

procedure TfPadrao.ControlaBotoes;
begin
  btnINC.Visible := not(ds.DataSet.State in [DsInsert,DsEdit]);
  btnEDT.Visible := not(ds.DataSet.State in [DsInsert,DsEdit]);
  btnEXC.Visible := not(ds.DataSet.State in [DsInsert,DsEdit]);
  btnPROC.Visible := not(ds.DataSet.State in [DsInsert,DsEdit]);
  btnSALV.Visible := (ds.DataSet.State in [DsInsert,DsEdit]);
  btnCANC.Visible := (ds.DataSet.State in [DsInsert,DsEdit]);
end;

procedure TfPadrao.HabilitaEdicao(Status: Boolean);
var
  n : integer;
begin
  for n := 0 to ComponentCount - 1 do
  begin
    if components[n] is TDBEdit then
    begin
      TDBEdit(components[n]).Enabled    := Status;
      TDBEdit(components[n]).Color      := clwhite;
      TDBEdit(components[n]).Font.Color := clBlack;
    end
    else if components[n] is TEdit then
    begin
      TEdit(components[n]).Enabled    := Status;
      TEdit(components[n]).Color      := clwhite;
      TEdit(components[n]).Font.Color := clBlack;
    end
    else if components[n] is TComboBox then
    begin
      TComboBox(components[n]).Enabled    := Status;
      TComboBox(components[n]).Color      := clwhite;
      TComboBox(components[n]).Font.Color := clBlack;
    end
    else if components[n] is TDBLookupComboBox then
    begin
      TDBComboBox(components[n]).Enabled    := Status;
      TDBComboBox(components[n]).Color      := clwhite;
      TDBComboBOx(components[n]).Font.Color := clBlack;
    end
    else if components[n] is TDBLookupComboBox then
    begin
      TDBlookupComboBox(components[n]).Enabled    := Status;
      TDBlookupComboBox(components[n]).Color      := clwhite;
      TDBlookupComboBOx(components[n]).Font.Color := clBlack;
    end;
  end;
end;

end.

