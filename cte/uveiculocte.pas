unit uVeiculoCte;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, Buttons, uPadrao, db;

type

  { TfVeiculoCte }

  TfVeiculoCte = class(TfPadrao)
    btnBuscaProprietario: TBitBtn;
    cbProprietario: TComboBox;
    cbTpVeic: TComboBox;
    cbTpRodado: TComboBox;
    cbTpCarroceria: TComboBox;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    gbProprietario: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnBuscaProprietarioClick(Sender: TObject);
    procedure btnSALVClick(Sender: TObject);
    procedure cbProprietarioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fVeiculoCte: TfVeiculoCte;

implementation

uses uDmCte, uClienteBusca, udmpdv;

{$R *.lfm}

{ TfVeiculoCte }

procedure TfVeiculoCte.btnSALVClick(Sender: TObject);
begin
  if (cbProprietario.ItemIndex = 0) then
    dmCte.sqVeicTPPROP.AsString := 'P';
  if (cbProprietario.ItemIndex = 1) then
    dmCte.sqVeicTPPROP.AsString := 'T';
  if (cbTpVeic.ItemIndex = 0) then
    dmCte.sqVeicTPVEIC.AsString := '0';
  if (cbTpVeic.ItemIndex = 1) then
    dmCte.sqVeicTPVEIC.AsString := '1';
  if (cbTpRodado.ItemIndex = 0) then
    dmCte.sqVeicTPROD.AsString := '00';
  if (cbTpRodado.ItemIndex = 1) then
    dmCte.sqVeicTPROD.AsString := '01';
  if (cbTpRodado.ItemIndex = 2) then
    dmCte.sqVeicTPROD.AsString := '02';
  if (cbTpRodado.ItemIndex = 3) then
    dmCte.sqVeicTPROD.AsString := '03';
  if (cbTpRodado.ItemIndex = 4) then
    dmCte.sqVeicTPROD.AsString := '04';
  if (cbTpRodado.ItemIndex = 5) then
    dmCte.sqVeicTPROD.AsString := '05';
  if (cbTpRodado.ItemIndex = 6) then
    dmCte.sqVeicTPROD.AsString := '06';
  if (cbTpRodado.ItemIndex = 7) then
    dmCte.sqVeicTPROD.AsString := '99';
  if (cbTpCarroceria.ItemIndex = 0) then
    dmCte.sqVeicTPCAR.AsString := '00';
  if (cbTpCarroceria.ItemIndex = 1) then
    dmCte.sqVeicTPCAR.AsString := '01';
  if (cbTpCarroceria.ItemIndex = 2) then
    dmCte.sqVeicTPCAR.AsString := '02';
  if (cbTpCarroceria.ItemIndex = 3) then
    dmCte.sqVeicTPCAR.AsString := '03';
  if (cbTpCarroceria.ItemIndex = 4) then
    dmCte.sqVeicTPCAR.AsString := '04';
  if (cbTpCarroceria.ItemIndex = 5) then
    dmCte.sqVeicTPCAR.AsString := '05';
  inherited;
end;

procedure TfVeiculoCte.btnBuscaProprietarioClick(Sender: TObject);
begin
  fClienteBusca.ShowModal;
  if (fClienteBusca.cCodCliente > 0) then
  begin
    fClienteBusca.BuscaCliente;
    dmCte.sqVeicCNPJ.AsString := fClienteBusca.cCnpjCliente;
    dmCte.sqVeicNOME.AsString := fClienteBusca.cNomeCliente;
    dmCte.sqVeicIE.AsString := dmPdv.sqBusca.FieldByName('INSCESTADUAL').AsString;
    dmCte.sqVeicUF.AsString := dmPdv.sqBusca.FieldByName('UF').AsString;
  end;
end;

procedure TfVeiculoCte.cbProprietarioChange(Sender: TObject);
begin
  if (cbProprietario.ItemIndex = 0) then
    gbProprietario.Visible := False;
  if (cbProprietario.ItemIndex = 1) then
    gbProprietario.Visible := True;

end;

procedure TfVeiculoCte.FormCreate(Sender: TObject);
begin
  ds.DataSet := dmCte.sqVeic;
  inherited;
end;

procedure TfVeiculoCte.FormShow(Sender: TObject);
begin
  inherited;
  if (dmCte.sqVeicTPPROP.AsString = 'P') then
    cbProprietario.ItemIndex := 0;
  if (dmCte.sqVeicTPPROP.AsString = 'T') then
    cbProprietario.ItemIndex := 1;
  if (dmCte.sqVeicTPVEIC.AsString = '0') then
    cbTpVeic.ItemIndex := 0;
  if (dmCte.sqVeicTPVEIC.AsString = '1') then
    cbTpVeic.ItemIndex := 1;
  if (dmCte.sqVeicTPROD.AsString = '00') then
    cbTpRodado.ItemIndex := 0;
  if (dmCte.sqVeicTPROD.AsString = '01') then
    cbTpRodado.ItemIndex := 1;
  if (dmCte.sqVeicTPROD.AsString = '02') then
    cbTpRodado.ItemIndex := 2;
  if (dmCte.sqVeicTPROD.AsString = '03') then
    cbTpRodado.ItemIndex := 3;
  if (dmCte.sqVeicTPROD.AsString = '04') then
    cbTpRodado.ItemIndex := 4;
  if (dmCte.sqVeicTPROD.AsString = '05') then
    cbTpRodado.ItemIndex := 5;
  if (dmCte.sqVeicTPROD.AsString = '06') then
    cbTpRodado.ItemIndex := 6;
  if (dmCte.sqVeicTPROD.AsString = '99') then
    cbTpRodado.ItemIndex := 7;
  if (dmCte.sqVeicTPCAR.AsString = '00') then
    cbTpCarroceria.ItemIndex := 0;
  if (dmCte.sqVeicTPCAR.AsString = '01') then
    cbTpCarroceria.ItemIndex := 1;
  if (dmCte.sqVeicTPCAR.AsString = '02') then
    cbTpCarroceria.ItemIndex := 2;
  if (dmCte.sqVeicTPCAR.AsString = '03') then
    cbTpCarroceria.ItemIndex := 3;
  if (dmCte.sqVeicTPCAR.AsString = '04') then
    cbTpCarroceria.ItemIndex := 4;
  if (dmCte.sqVeicTPCAR.AsString = '05') then
    cbTpCarroceria.ItemIndex := 5;

end;

end.

