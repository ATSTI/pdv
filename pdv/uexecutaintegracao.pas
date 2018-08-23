unit uExecutaIntegracao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, Process;

type

  { TfExecutaIntegracao }

  TfExecutaIntegracao = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private

  public

  end;

var
  fExecutaIntegracao: TfExecutaIntegracao;

implementation

{$R *.lfm}

{ TfExecutaIntegracao }

procedure TfExecutaIntegracao.BitBtn1Click(Sender: TObject);
var
  AProcess: TProcess;
  ASlist: TStringList;
  i: integer;
begin
   AProcess := TProcess.Create(nil);
   ASList := TStringList.Create;
   try
     AProcess.Executable := 'C:\Users\ats\AppData\Local\Programs\Python\Python37-32\python.exe';
     AProcess.Options := AProcess.Options + [poWaitOnExit, poUsePipes];
     AProcess.Parameters.Add('atsProduto.py');
     //('C:\home\programas\lazarus\pdv\pdv\atsProduto.py');
     //AProcess.CommandLine := ' C:\home\programas\lazarus\pdv\pdv\atsProduto.py';
     AProcess.Execute;
     ASlist.LoadFromStream(AProcess.Output);
     Memo1.Lines.Clear;
     for i := 0 to ASlist.Count - 1 do
        Memo1.Lines.Add(ASlist[i]);
     Memo1.Lines.Add('');
     Memo1.Lines.Add('.... Finalizado com sucesso.');
     ASlist.SaveToFile('saida.txt');
     //ShowMessage('fez');
   finally
     AProcess.Free;
     ASlist.Free;
   end;
end;

end.

