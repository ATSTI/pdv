unit uCadeira;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons;

type

  { TfCadeira }

  TfCadeira = class(TForm)
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  fCadeira: TfCadeira;

implementation

{$R *.lfm}

{ TfCadeira }

procedure TfCadeira.FormCreate(Sender: TObject);
var
  B: TBitBtn;
  i: integer;
  linha: Integer;
  coluna: Integer;
  fileira: integer;
  linha_coluna: integer;
  total_cadeira: integer;
begin
  total_cadeira := 60;
  linha := 15;
  fileira := 0;
  linha_coluna := 1;
  for i := 0 to (total_cadeira-1) do
  begin
    B := TBitBtn.Create(self);
    B.Caption := IntToStr(i+1);
    B.Parent := Self;
    B.Height := 23;
    B.Width := 100;

    if (fileira = 0) then
    begin
      B.Left := 10;
    end
    else begin
      B.Left := 10 + (100 * fileira) ;
    end;
    B.Top := 10 + linha_coluna * 25;

    if (linha_coluna > (linha-1)) then
    begin
      linha_coluna := 1;
      fileira += 1;
    end
    else begin
      linha_coluna += 1;
    end;
  end;
end;

end.

