program prjPDV;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, runtimetypeinfocontrols, datetimectrls, lhelpcontrolpkg, uPdv,
  updv_rec, uMovimento, uMovimentoDetalhe, udmpdv, uprodutoproc, uMovimentoProc,
  uvenda, uRecebimento, uExecutaIntegracao, uLogin, uVendedorBusca,
  uClienteBusca, uSenhaNova, uPermissao, uExcluirItem, uNfce, uabrircaixa,
  uCadeira, usangria, uAbrirCaixa2, uCursoBusca, uAlunoBusca, uComandaJuntar,
  uReceber, uEstoqueExecuta, uIntegracaoOdoo, uIntegraSimples, uMsg, usaldo;

{$R *.res}

begin
  Application.Title:='ATS-PDV';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tdmpdv, dmpdv);
  Application.CreateForm(TfLogin, fLogin);
  Application.CreateForm(TfPdv, fPdv);
  Application.CreateForm(TfPDV_Rec, fPDV_Rec);
  Application.CreateForm(TfProdutoProc, fProdutoProc);
  Application.CreateForm(TfMovimentoProc, fMovimentoProc);
  Application.CreateForm(TfExecutaIntegracao, fExecutaIntegracao);
  Application.CreateForm(TfVendedorBusca, fVendedorBusca);
  Application.CreateForm(TfClienteBusca, fClienteBusca);
  Application.CreateForm(TfSenhaNova, fSenhaNova);
  Application.CreateForm(TfPermissao, fPermissao);
  Application.CreateForm(TfNfce, fNfce);
  Application.CreateForm(TfExclusao, fExclusao);
  Application.CreateForm(TfAbrirCaixa, fAbrirCaixa);
  Application.CreateForm(TfSangria, fSangria);
  Application.CreateForm(TfCadeira, fCadeira);
  Application.CreateForm(TfAbreCaixa, fAbreCaixa);
  Application.CreateForm(TfCursoBusca, fCursoBusca);
  Application.CreateForm(TfAlunoBusca, fAlunoBusca);
  Application.CreateForm(TfComandaJuntar, fComandaJuntar);
  Application.CreateForm(TfRecebimento, fRecebimento);
  Application.CreateForm(TfMsg, fMsg);
  Application.CreateForm(Tfsaldo, fsaldo);
  Application.Run;
end.

