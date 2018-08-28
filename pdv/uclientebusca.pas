unit uClienteBusca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, uPadraoBusca, db, udmpdv;

type

  { TfClienteBusca }

  TfClienteBusca = class(TfPadraoBusca)
    dsCliente: TDataSource;
    procedure btnPROCClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private

  public
    cCodCliente: Integer;
    cNomeCliente : String;
    procedure BuscaCliente;
  end;

var
  fClienteBusca: TfClienteBusca;

implementation

{$R *.lfm}

{ TfClienteBusca }

procedure TfClienteBusca.btnPROCClick(Sender: TObject);
var sql: String;
begin
  DBGrid1.Columns[0].FieldName := 'CODCLIENTE';
  DBGrid1.Columns[1].FieldName := 'NOMECLIENTE';
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;

  if edit1.Text <> '' then
  begin
    sql := sql + ' WHERE CODCLIENTE = ' + Edit1.Text;
  end;
  if edit2.Text <> '' then
  begin
    if sql <> '' then
      sql := sql + ' AND '
    else
      sql := sql + ' WHERE ';
    sql := sql + ' NOMECLIENTE LIKE ' + QuotedStr(Edit2.Text + '%');
  end;
  sql := 'SELECT * FROM CLIENTES' + sql;

  dmPdv.sqBusca.SQL.Text := sql;
  dmPdv.sqBusca.Open
end;

procedure TfClienteBusca.DBGrid1CellClick(Column: TColumn);
begin
  cNomeCliente := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;
  cCodCliente  := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
end;

procedure TfClienteBusca.FormShow(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName := 'CODCLIENTE';
  DBGrid1.Columns[1].FieldName := 'NOMECLIENTE';
  cNomeCliente:='';
end;

procedure TfClienteBusca.BuscaCliente;
var sql: String;
begin
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;

  sql := 'SELECT * FROM CLIENTES';
  sql := sql + ' WHERE CODCLIENTE = ' + IntToStr(cCodCliente);
  dmPdv.sqBusca.SQL.Text := sql;
  dmPdv.sqBusca.Open;
  if not dmPdv.sqBusca.IsEmpty then
    cNomeCliente := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;

end;

end.

