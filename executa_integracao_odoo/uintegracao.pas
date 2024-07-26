unit uIntegracao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Buttons, PythonEngine, Lcl.PythonGUIInputOutput, strUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Memo2: TMemo;
    PageControl1: TPageControl;
    ProgressBar1: TProgressBar;
    PythonEngine1: TPythonEngine;
    PythonGUIInputOutput1: TPythonGUIInputOutput;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PythonEngine1AfterInit(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BitBtn1Click(Sender: TObject);
var  script  : TStringList;
begin
  ProgressBar1.Min:=10;
  ProgressBar1.Min:=100;
  ProgressBar1.Position:=10;
  script := TStringList.Create();
  script.LoadFromFile('pos_order.py');
  ProgressBar1.Position:=20;
  //script.Text := ReplaceStr(script.Text,'1-executa_tudo', 'executa_produto');
  Memo1.Clear;
  ProgressBar1.Position:=30;
  Memo2.Clear;
  ProgressBar1.Position:=60;
  Memo2.Text:= script.Text;
  PythonEngine1.ExecStrings( Memo2.Lines );
  ProgressBar1.Position:=80;
  script.LoadFromFile('logs\log.txt');
  Memo1.Text:= script.Text;
  ProgressBar1.Position:=90;
  Memo1.Append('Produtos atualizados com sucesso.');
  ProgressBar1.Position:=100;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Memo1.Clear;
  Memo2.Clear;
end;

procedure TForm1.PythonEngine1AfterInit(Sender: TObject);
begin

end;

end.

