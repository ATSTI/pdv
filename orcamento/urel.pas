unit uRel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, udm, DB,
  RLReport;

type

  { TfRel }

  TfRel = class(TForm)
    dsOrc: TDataSource;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDetailGrid1: TRLDetailGrid;
    RLReport1: TRLReport;
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private

  public

  end;

var
  fRel: TfRel;

implementation

uses uBuscaOrc;

{$R *.lfm}

{ TfRel }

procedure TfRel.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  var sql: String;
begin
    dm.sqlOrcamento.Close;

    if(fBuscaOrc.edit1.Text <> '') then
    begin
      sql   := ' SELECT * FROM ORCAMENTO_VBS WHERE CODPROD = ' + QuotedStr(fBuscaOrc.edit1.Text);
      dm.sqlOrcamento.SQL.Text := (sql);
      dm.sqlOrcamento.Open;
    end else
    begin
      sql   := ' SELECT * FROM ORCAMENTO_VBS ';
      dm.sqlOrcamento.SQL.Text := (sql);
      dm.sqlOrcamento.Open;
    end;



end;

end.

