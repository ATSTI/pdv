program prjPDV;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, runtimetypeinfocontrols, datetimectrls, uPdv, updv_rec, uMovimento,
  uMovimentoDetalhe, udmpdv, uprodutoproc, uMovimentoProc;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tdmpdv, dmpdv);
  Application.CreateForm(TfPdv, fPdv);
  Application.CreateForm(TfPDV_Rec, fPDV_Rec);
  Application.CreateForm(TfProdutoProc, fProdutoProc);
  Application.CreateForm(TfMovimentoProc, fMovimentoProc);
  Application.Run;
end.

