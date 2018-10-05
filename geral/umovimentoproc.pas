unit uMovimentoProc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, DBGrids, ActnList, udmpdv;

type

  { TfMovimentoProc }

  TfMovimentoProc = class(TForm)
    acBuscar: TAction;
    acFechar: TAction;
    ActionList1: TActionList;
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
    procedure acBuscarExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
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
begin
  acBuscar.Execute;
end;

procedure TfMovimentoProc.acBuscarExecute(Sender: TObject);
var sqlProc: String;
begin
  sqlProc := 'SELECT m.CODMOVIMENTO, m.CONTROLE, m.DATA_SISTEMA as DATAMOVIMENTO, v.CODVENDA ';
  sqlProc += ' , u.NOMEUSUARIO as  VENDEDOR, c.NOMECLIENTE as CLIENTE, v.VALOR ';
  sqlProc += ' FROM MOVIMENTO m  ';
  sqlProc += ' INNER JOIN USUARIO u ON m.codVendedor = u.codUsuario';
  sqlProc += ' INNER JOIN CLIENTES c ON c.CODCLIENTE = m.CODCLIENTE';
  sqlProc += ' LEFT OUTER JOIN VENDA v ON v.CODMOVIMENTO = m.CODMOVIMENTO ';
  sqlProc += ' WHERE  m.DATAMOVIMENTO BETWEEN ';
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

procedure TfMovimentoProc.acFecharExecute(Sender: TObject);
begin
  Close;
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
  DBGrid1.Columns[3].FieldName:='VENDEDOR';
  DBGrid1.Columns[4].FieldName:='CLIENTE';
  DBGrid1.Columns[5].FieldName:='VALOR';
  DBGrid1.Columns[5].DisplayFormat:=',##0.00';
end;

procedure TfMovimentoProc.FormShow(Sender: TObject);
begin
  codMovimentoProc:=0;
  codVendaProc:=0;
  edDataIni.Date:=Now;
  edDataFim.Date:=Now;
  acBuscar.Execute;
end;

end.

