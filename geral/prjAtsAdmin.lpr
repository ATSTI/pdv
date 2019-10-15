program prjAtsAdmin;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uAtsAdmin, uClienteCadastro, ufornecedorcadastro, uProdutoCadastro,
  uUsuarioCadastro, uEmpresaCadastro
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfClienteCadastro, fClienteCadastro);
  Application.CreateForm(TfFornecedorCadastro, fFornecedorCadastro);
  Application.CreateForm(TfProdutoCadastro, fProdutoCadastro);
  Application.CreateForm(TfUsuarioCadastro, fUsuarioCadastro);
  Application.CreateForm(TfEmpresaCadastro, fEmpresaCadastro);
  Application.Run;
end.

