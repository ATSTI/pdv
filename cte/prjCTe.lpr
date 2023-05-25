program prjCTe;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, datetimectrls, uCtePrincipal, uDmCte, uNFe, uCompValor,
  uQuantCarga, udmpdv, ufrmStatus, uClienteBusca, umunicipiobusca, uVeiculoCte;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='ATS Conhecimento Transportes (CTe)';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TdmPdv, dmPdv);
  Application.CreateForm(TdmCte, dmCte);
  Application.CreateForm(TfCTePrincipal, fCTePrincipal);
  Application.CreateForm(TfCompValor, fCompValor);
  Application.CreateForm(TfQuantCarga, fQuantCarga);
  Application.CreateForm(TfClienteBusca, fClienteBusca);
  Application.CreateForm(TfMunicipioBusca, fMunicipioBusca);
  Application.CreateForm(TfVeiculoCte, fVeiculoCte);
  Application.CreateForm(TfNFe, fNFe);
  Application.Run;
end.

