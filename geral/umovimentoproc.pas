unit uMovimentoProc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, DBGrids, udmpdv;

type

  { TfMovimentoProc }

  TfMovimentoProc = class(TForm)
    btnEXC: TImage;
    btnPROC: TImage;
    btnSALV: TImage;
    dsMovProc: TDataSource;
    edDataIni: TDateTimePicker;
    edDataFim: TDateTimePicker;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnPROCClick(Sender: TObject);
    procedure btnSALVClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    codMovimentoProc: Integer;
    codVendaProc: Integer;
  end;

var
  fMovimentoProc: TfMovimentoProc;

implementation

{$R *.lfm}

{ TfMovimentoProc }

procedure TfMovimentoProc.btnPROCClick(Sender: TObject);
var sqlProc: String;
begin
  sqlProc := 'SELECT m.CODMOVIMENTO, m.CONTROLE, m.DATAMOVIMENTO, v.CODVENDA ';
  sqlProc += ' FROM MOVIMENTO m  ';
  sqlProc += ' LEFT OUTER JOIN VENDA v ON v.CODMOVIMENTO = m.CODMOVIMENTO ';
  sqlProc += ' WHERE m.DATAMOVIMENTO BETWEEN ';
  sqlProc += QuotedStr(FormatDateTime( 'mm-dd-yyyy', edDataIni.Date));
  sqlProc += '   AND ';
  sqlProc += QuotedStr(FormatDateTime( 'mm-dd-yyyy', edDataFim.Date));
  sqlProc += '  ORDER BY m.CODMOVIMENTO DESC ';
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlProc);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    codMovimentoProc := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
    codVendaProc     := dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger;
  end;
end;

procedure TfMovimentoProc.btnSALVClick(Sender: TObject);
begin
  Close;
end;

procedure TfMovimentoProc.DBGrid1CellClick(Column: TColumn);
begin
  codMovimentoProc := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
  codVendaProc     := dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger;
end;

procedure TfMovimentoProc.FormCreate(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName:='CODMOVIMENTO';
  DBGrid1.Columns[1].FieldName:='DATAMOVIMENTO';
  DBGrid1.Columns[2].FieldName:='CONTROLE';
  DBGrid1.Columns[3].FieldName:='CODVENDA';
end;

procedure TfMovimentoProc.FormShow(Sender: TObject);
begin
  codMovimentoProc:=0;
  codVendaProc:=0;
end;

end.

