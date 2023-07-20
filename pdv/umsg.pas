unit uMsg;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TfMsg }

  TfMsg = class(TForm)
    Label1: TLabel;
    TimerMSG: TTimer;
    procedure FormShow(Sender: TObject);
    procedure TimerMSGTimer(Sender: TObject);
  private

  public

  end;

var
  fMsg: TfMsg;

implementation

uses  uProdutoProc;
{$R *.lfm}

{ TfMsg }

procedure TfMsg.TimerMSGTimer(Sender: TObject);
begin
  TimerMSG.Enabled := False;
  fMsg.Close;
end;

procedure TfMsg.FormShow(Sender: TObject);
var
  minutos_ate_fechar: byte;
begin
  Label1.Caption:= 'Produto  = ' + fProdutoProc.Produto + ' ..Sem Preço' ;
  minutos_ate_fechar := 1; // 5 minutos
  TimerMSG.Enabled := False;
  TimerMSG.Interval := (1000 * 1) * minutos_ate_fechar;
  TimerMSG.Enabled := True;

end;

end.

