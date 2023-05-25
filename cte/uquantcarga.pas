unit uQuantCarga;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, EditBtn, DBCtrls, uCtePrincipal, db;

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
    Label3: TLabel;
    procedure btnEditarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    fcarga : integer;
    pQCInseri , pQCEdit : string;
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
  v_numQC: Integer;
begin
  vQCstr_sql := '';
  FormatSettings.DecimalSeparator := '.';
  if (fCTePrincipal.DSZqsQC.State in [dsInsert]) then
  begin
    if (fCTePrincipal.ZsqQCMEDIDA.AsString <> '') then
    begin
      v_numQC := fCTePrincipal.busca_generator('GEN_CTE_QC_ID');
      vQCstr_sql := 'INSERT INTO CTE_QC (COD_CTE_QC, COD_CTE ,UNID, ' +
        ' MEDIDA, QUANT) VALUES ( ' + IntToStr(v_numQC);
      vQCstr_sql := vQCstr_sql + ', ' +IntToStr(fCTePrincipal.ZsqQCCOD_CTE.AsInteger);
      vQCstr_sql := vQCstr_sql + ', ' + QuotedStr(Copy(cbTipoUn.Text,1,2));
      vQCstr_sql := vQCstr_sql + ', ' + QuotedStr(fCTePrincipal.ZsqQCMEDIDA.AsString);
      vQCstr_sql := vQCstr_sql + ', ' +  FloatToStr(fCTePrincipal.ZsqQCQUANT.AsFloat) ;
      vQCstr_sql := vQCstr_sql + ')';
      fCTePrincipal.ZsqQCCOD_CTE_QC.AsInteger := v_numQC;
      pQCInseri := vQCstr_sql ;
    end;
  end;
  if (fCTePrincipal.DSZqsQC.State in [dsEdit]) then
  begin
    vQCstr_sql := 'UPDATE CTE_QC SET UNID = ';
    vQCstr_sql := vQCstr_sql + QuotedStr(Copy(cbTipoUn.Text,1,2));
    vQCstr_sql := vQCstr_sql + ', MEDIDA = ';
    vQCstr_sql := vQCstr_sql +  QuotedStr(fCTePrincipal.ZsqQCMEDIDA.AsString);
    vQCstr_sql := vQCstr_sql + ', QUANT = ';
    vQCstr_sql := vQCstr_sql + FloatToStr(fCTePrincipal.ZsqQCQUANT.AsFloat);
    vQCstr_sql := vQCstr_sql + ' WHERE COD_CTE_QC = ';
    vQCstr_sql := vQCstr_sql + IntToStr(fCTePrincipal.ZsqQCCOD_CTE_QC.AsInteger);
    pQCEdit := vQCstr_sql ;
  end;
  FormatSettings.DecimalSeparator := ',';
  //if (vQCstr_sql <> '') then
  //  dmPdv.Ibcon.ExecuteDirect(vQCstr_sql);
  fCTePrincipal.btnInserirQC.Click;
  Close;
end;

procedure TfQuantCarga.FormShow(Sender: TObject);
begin
  cbTipoUN.ItemIndex := -1;
  if (fCTePrincipal.ZsqQCUNID.AsString = '00') then
    cbTipoUN.ItemIndex := 0;
  if (fCTePrincipal.ZsqQCUNID.AsString = '01') then
    cbTipoUN.ItemIndex := 1;
  if (fCTePrincipal.ZsqQCUNID.AsString = '02') then
    cbTipoUN.ItemIndex := 2;
  if (fCTePrincipal.ZsqQCUNID.AsString = '03') then
    cbTipoUN.ItemIndex := 3;
  if (fCTePrincipal.ZsqQCUNID.AsString = '04') then
    cbTipoUN.ItemIndex := 4;
  if(fCTePrincipal.ZsqQCUNID.AsString = '05') then
    cbTipoUN.ItemIndex := 5;
  dbQCtpMed.SetFocus;
  {
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
  dbQCtpMed.SetFocus;
  }

end;

end.

