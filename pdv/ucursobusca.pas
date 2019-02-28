unit uCursoBusca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBGrids, uPadraoBusca, db, udmpdv;

type

  { TfCursoBusca }

  TfCursoBusca = class(TfPadraoBusca)
    dsCurso: TDataSource;
    procedure btnProcurarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private

  public
    curCodCurso: Integer;
    curCurso: String;
  end;

var
  fCursoBusca: TfCursoBusca;

implementation

{$R *.lfm}

{ TfCursoBusca }

procedure TfCursoBusca.btnProcurarClick(Sender: TObject);
var c_b: String;
begin
  c_b := 'SELECT CODDADOS, DESCRICAO, USO, CODIGOS, OUTROS' +
    ' FROM DADOS_COMBOS WHERE USO = ' + QuotedStr('CURSO');
  if (edit1.Text <> '') then
  begin
    c_b += ' AND CODDADOS = ' + Edit1.Text;
  end;
  if (edit2.Text <> '') then
  begin
    c_b += ' AND DESCRICAO LIKE ' + QuotedStr('%' + Edit2.Text + '%');
  end;

  dmPdv.busca_sql(c_b);
  curCodCurso := dmPdv.sqBusca.FieldByName('CODDADOS').AsInteger;
  curCurso := dmPdv.sqBusca.FieldByName('DESCRICAO').AsString;
end;

procedure TfCursoBusca.DBGrid1CellClick(Column: TColumn);
begin
  curCodCurso := dmPdv.sqBusca.FieldByName('CODDADOS').AsInteger;
  curCurso := dmPdv.sqBusca.FieldByName('DESCRICAO').AsString;
end;

procedure TfCursoBusca.FormCreate(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName := 'CODDADOS';
  DBGrid1.Columns[1].FieldName := 'DESCRICAO';
  DBGrid1.Columns[0].Title.Caption:='Código';
  DBGrid1.Columns[1].Title.Caption:='Curso';
end;

end.

