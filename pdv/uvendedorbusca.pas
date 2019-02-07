unit uVendedorBusca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, DbCtrls, uPadraoBusca, db, udmpdv;

type

  { TfVendedorBusca }

  TfVendedorBusca = class(TfPadraoBusca)
    dsVendedor: TDataSource;
    procedure btnProcurarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private

  public
    uCodVendedor: Integer;
    uNomeVendedor : String;
    procedure BuscaVendedor;
  end;

var
  fVendedorBusca: TfVendedorBusca;

implementation

{$R *.lfm}

{ TfVendedorBusca }



procedure TfVendedorBusca.btnProcurarClick(Sender: TObject);
var sql: String;
begin
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;

  if edit1.Text <> '' then
  begin
    sql := sql + ' WHERE CODUSUARIO = ' + Edit1.Text;
  end;
  if edit2.Text <> '' then
  begin
    if sql <> '' then
      sql := sql + ' AND '
    else
      sql := sql + ' WHERE ';
    sql := sql + '  NOMEUSUARIO LIKE ' + QuotedStr(Edit2.Text + '%');
  end;
  sql := 'SELECT * FROM USUARIO' + sql;
  dmPdv.sqBusca.SQL.Text := sql;
  dmPdv.sqBusca.Open;

end;

procedure TfVendedorBusca.DBGrid1CellClick(Column: TColumn);
begin
  uCodVendedor := dmPdv.sqBusca.FieldByName('CODUSUARIO').AsInteger;
  uNomeVendedor := dmPdv.sqBusca.FieldByName('NOMEUSUARIO').AsString;
end;

procedure TfVendedorBusca.FormShow(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName := 'CODUSUARIO';
  DBGrid1.Columns[1].FieldName := 'NOMEUSUARIO';
  DBGrid1.Columns[1].Title.Caption:='Vendedor';
  DBGrid1.Columns[0].Title.Caption:='Código';
  uNomeVendedor:='';
end;

procedure TfVendedorBusca.BuscaVendedor;
var sql: String;
begin
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;

  sql := 'SELECT * FROM USUARIO';
  sql := sql + ' WHERE CODUSUARIO = ' + IntToStr(uCodVendedor);
  dmPdv.sqBusca.SQL.Text := sql;
  dmPdv.sqBusca.Open;
  if not dmPdv.sqBusca.IsEmpty then
    uNomeVendedor := dmPdv.sqBusca.FieldByName('NOMEUSUARIO').AsString;
end;

end.

