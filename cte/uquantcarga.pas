unit uQuantCarga;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, EditBtn, DBCtrls, db;

type

  { TfQuantCarga }

  TfQuantCarga = class(TForm)
    btnGravar: TBitBtn;
    btnFechar: TBitBtn;
    dbQCtpMed: TDBEdit;
    dbQCQuant: TDBEdit;
    cbTipoUN: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnEditarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    fcarga : integer;
  end;

var
  fQuantCarga: TfQuantCarga;

implementation

uses udmpdv, uDmCte;

{$R *.lfm}

{ TfQuantCarga }

procedure TfQuantCarga.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfQuantCarga.btnEditarClick(Sender: TObject);
begin
end;

procedure TfQuantCarga.btnGravarClick(Sender: TObject);
var vQCstr_sql :string;
begin
  vQCstr_sql := '';
  FormatSettings.DecimalSeparator := '.';
  if (dmCte.dsQC.State in [dsInsert]) then
  begin
    vQCstr_sql := 'INSERT INTO CTE_QC (COD_CTE ,UNID, MEDIDA, QUANT  ' +
                 ') VALUES ( ';
    vQCstr_sql := vQCstr_sql + IntToStr(dmCte.cdsCteCOD_CTE.AsInteger);
    vQCstr_sql := vQCstr_sql + ', ' + QuotedStr(Copy(cbTipoUn.Text,1,2));
    vQCstr_sql := vQCstr_sql + ', ' + QuotedStr(dmCte.sqQCMEDIDA.AsString);
    vQCstr_sql := vQCstr_sql + ', ' +  FloatToStr(dmCte.sqQCQUANT.AsFloat) ;
    vQCstr_sql := vQCstr_sql + ')';
  end;
  if (dmCte.dsQC.State in [dsEdit]) then
  begin
    vQCstr_sql := 'UPDATE CTE_QC SET UNID = ';
    vQCstr_sql := vQCstr_sql + QuotedStr(Copy(cbTipoUn.Text,1,2));
    vQCstr_sql := vQCstr_sql + ', MEDIDA = ';
    vQCstr_sql := vQCstr_sql +  QuotedStr(dmCte.sqQCMEDIDA.AsString);
    vQCstr_sql := vQCstr_sql + ', QUANT = ';
    vQCstr_sql := vQCstr_sql + FloatToStr(dmCte.sqQCQUANT.AsFloat);
    vQCstr_sql := vQCstr_sql + ' WHERE COD_CTE_QC = ';
    vQCstr_sql := vQCstr_sql + IntToStr(dmCte.sqQCCOD_CTE_QC.AsInteger);
  end;
  FormatSettings.DecimalSeparator := ',';
  if (vQCstr_sql <> '') then
    dmPdv.Ibcon.ExecuteDirect(vQCstr_sql);
  Close;
end;

procedure TfQuantCarga.FormShow(Sender: TObject);
begin
  cbTipoUN.ItemIndex := -1;
  if (dmCte.sqQCUNID.AsString = '00') then
    cbTipoUN.ItemIndex := 0;
  if (dmCte.sqQCUNID.AsString = '01') then
    cbTipoUN.ItemIndex := 1;
  if (dmCte.sqQCUNID.AsString = '02') then
    cbTipoUN.ItemIndex := 2;
  if (dmCte.sqQCUNID.AsString = '03') then
    cbTipoUN.ItemIndex := 3;
  if (dmCte.sqQCUNID.AsString = '04') then
    cbTipoUN.ItemIndex := 4;
  if(dmCte.sqQCUNID.AsString = '05') then
    cbTipoUN.ItemIndex := 5;
end;

end.

