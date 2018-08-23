program prjPDV;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, runtimetypeinfocontrols, datetimectrls, uPdv, updv_rec, uMovimento,
  uMovimentoDetalhe, udmpdv, uprodutoproc, uMovimentoProc, uvenda, uRecebimento,
  uExecutaIntegracao, uLogin, uVendedorBusca, uClienteBusca, uSenhaNova, uPdv2;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tdmpdv, dmpdv);
  Application.CreateForm(TfLogin, fLogin);
  Application.CreateForm(TfPdv, fPdv);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfPDV_Rec, fPDV_Rec);
  Application.CreateForm(TfProdutoProc, fProdutoProc);
  Application.CreateForm(TfMovimentoProc, fMovimentoProc);
  Application.CreateForm(TfExecutaIntegracao, fExecutaIntegracao);
  Application.CreateForm(TfVendedorBusca, fVendedorBusca);
  Application.CreateForm(TfClienteBusca, fClienteBusca);
  Application.CreateForm(TfSenhaNova, fSenhaNova);
  Application.Run;
end.

