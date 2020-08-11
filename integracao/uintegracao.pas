unit uIntegracao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls, PythonGUIInputOutput, PythonEngine, IniFiles,
  Process, dynlibs;
type

  { TfIntegracao }

  TfIntegracao = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnVenda: TBitBtn;
    btnProduto: TBitBtn;
    btnCliente: TBitBtn;
    btnCaixa: TBitBtn;
    lblMsg: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    OpenDialog1: TOpenDialog;
    PythonEngine1: TPythonEngine;
    PythonGUIInputOutput1: TPythonGUIInputOutput;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnCaixaClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure btnVendaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    path_exe : String;
    pathScript: String;
    pathPython: String;
    procedure executeScript;
    procedure Executa(script: String);
  public

  end;

var
  fIntegracao: TfIntegracao;

implementation

{$R *.lfm}

{ TfIntegracao }

procedure TfIntegracao.BitBtn1Click(Sender: TObject);
var logS: TStringList;
begin
  Memo1.Lines.Clear;
  executeScript;
  logS := TStringList.Create;
  try
    logS.LoadFromFile(path_exe + 'log_caixa.log');
    memo1.Lines.Add(logS.Text);
  finally
    logS.Free;
  end;
  logS := TStringList.Create;
  try
    logS.LoadFromFile(path_exe + 'log_cliente.log');
    memo1.Lines.Add(logS.Text);
  finally
    logS.Free;
  end;
  logS := TStringList.Create;
  try
    logS.LoadFromFile(path_exe + 'log_pedido.log');
    memo1.Lines.Add(logS.Text);
  finally
    logS.Free;
  end;
end;

procedure TfIntegracao.BitBtn2Click(Sender: TObject);
//var
  //Result : PPyObject;
begin
  Executa('atsProduto.py');
  {
  with PythonEngine1 do
  begin
    Result := EvalStrings( Memo1.Lines );
    if Assigned(Result) then
    begin
      ShowMessage(Format('Eval: %s',[PyObjectAsString(Result)]));
      Py_DECREF(Result);
    end
    else
      ShowMessage('Could not evaluate the script');
    // Or you could simply use:
    // ShowMessage('Eval: ' + EvalStringsAsStr( Memo1.Lines ) );
  end;
   }
end;

procedure TfIntegracao.BitBtn3Click(Sender: TObject);
begin
end;

procedure TfIntegracao.btnCaixaClick(Sender: TObject);
begin
  Executa('atsCaixa.py');
end;

procedure TfIntegracao.btnClienteClick(Sender: TObject);
begin
  Executa('atsCliente.py');
end;

procedure TfIntegracao.btnProdutoClick(Sender: TObject);
begin
  Executa('atsProduto.py');
end;

procedure TfIntegracao.btnVendaClick(Sender: TObject);
begin
  Executa('atsOrder.py');
end;

procedure TfIntegracao.FormCreate(Sender: TObject);
begin
  PythonEngine1.RegVersion:='3.7';
  PythonEngine1.DllName:='python37.dll';
end;

procedure TfIntegracao.FormShow(Sender: TObject);
var
  conf: TIniFile;
  sl: TStringList;
  i: integer;
begin
  //extrac
  path_exe := ExtractFilePath(ParamStr(0));
  conf := TIniFile.Create(path_exe + 'conf.ini');
  try
    pathScript := conf.ReadString('PATH', 'PathScript', '');
    pathPython := conf.ReadString('PATH', 'PathPython', '');
  finally
    conf.free;
  end;
  conf := TIniFile.Create(path_exe + 'log_integracao.log');
  try

  finally
    conf.free;
  end;
  sl := FindAllFiles(pathScript, '*.py', True);
  memo2.Lines.Clear;
  Try
    for i:=0 to sl.Count-1 do
       Memo2.Append(sl.Strings[i]);
  finally
    sl.Free;
  end;
  //memo1.Lines.LoadFromFile('log_integracao.txt');
  btnCaixa.Click;
end;

procedure TfIntegracao.Timer1Timer(Sender: TObject);
begin
  btnProduto.Click;
  btnCliente.Click;
end;

procedure TfIntegracao.Timer2Timer(Sender: TObject);
begin
  btnCaixa.Click;
  btnVenda.Click;
end;

procedure TfIntegracao.executeScript;
var   sl: TStringList;
  i: integer;
  arquivo: String;
begin
  sl := TStringList.Create;
  try
    sl.Assign(Memo2.Lines);
    for i:= 0 to sl.Count - 1 do
    begin
      arquivo := sl.Strings[i];
      executa(sl.Strings[i]);
      //for i := 0 to ASlist.Count - 1 do
      //Memo1.Lines.Add(sl.Strings[i]);
      //Memo1.Lines.Add('');
    end;
  finally
    sl.Free;
  end;
  Memo1.Lines.Add('.... Finalizado com sucesso.');
end;

procedure TfIntegracao.Executa(script: String);
var tamanho: Integer;
begin
  PythonEngine1.RegVersion:='3.7';
  PythonEngine1.DllName:='python37.dll';
  Memo1.Lines.LoadFromFile(pathScript + '\' + script);
  if PythonEngine1.IsHandleValid then
  begin
    PythonEngine1.ExecStrings((Memo1.Lines));
    tamanho := Length(Memo1.Text);
    Memo1.SelStart := tamanho;
    Memo1.SetFocus;
  end
  else writeln('invalid library handle!', dynlibs.GetLoadErrorStr)
end;

end.

