unit uAlunoBusca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBGrids, uPadraoBusca, udmpdv, db;

type

  { TfAlunoBusca }

  TfAlunoBusca = class(TfPadraoBusca)
    DataSource1: TDataSource;
    procedure btnProcurarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    aluCodAluno: Integer;
    aluCodCurso: Integer;
    aluNome: String;
  end;

var
  fAlunoBusca: TfAlunoBusca;

implementation

{$R *.lfm}

{ TfAlunoBusca }

procedure TfAlunoBusca.btnProcurarClick(Sender: TObject);
var a_b: String;
begin
//  a_b := 'SELECT CODDADOS, DESCRICAO, USO, CODIGOS, OUTROS' +
//    ' FROM DADOS_COMBOS WHERE USO = ' + QuotedStr('CURSO');
  a_b := 'SELECT CODCLIENTE, ASSUNTO AS NOME_ALUNO, STATUS AS CADEIRA ' +
    ' FROM AGENDAMENTO WHERE CODVENDA = ' + InttoStr(aluCodCurso) +
    ' AND ((STATUS IS NULL) OR (STATUS = ' + QuotedStr('0') + '))';
  {
  if (edit1.Text <> '') then
  begin
    a_b += ' AND CODDADOS = ' + Edit1.Text;
  end;
  if (edit2.Text <> '') then
  begin
    a_b += ' AND DESCRICAO LIKE ' + QuotedStr('%' + Edit2.Text + '%');
  end;
  }
  dmPdv.busca_sql(a_b);
  aluCodAluno := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
  aluNome := dmPdv.sqBusca.FieldByName('NOME_ALUNO').AsString;

end;

procedure TfAlunoBusca.DBGrid1CellClick(Column: TColumn);
begin
  aluCodAluno := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
  aluNome := dmPdv.sqBusca.FieldByName('NOME_ALUNO').AsString;
end;

procedure TfAlunoBusca.FormCreate(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName := 'CODCLIENTE';
  DBGrid1.Columns[1].FieldName := 'NOME_ALUNO';
  DBGrid1.Columns[0].Title.Caption:='Código';
  DBGrid1.Columns[1].Title.Caption:='Aluno';
end;

procedure TfAlunoBusca.FormShow(Sender: TObject);
begin
  btnProcurar.Click;
end;

end.

