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
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TdmPdv, dmPdv);
  Application.CreateForm(TdmCte, dmCte);
  Application.CreateForm(TfCTePrincipal, fCTePrincipal);
  Application.CreateForm(TfNFe, fNFe);
  Application.CreateForm(TfCompValor, fCompValor);
  Application.CreateForm(TfQuantCarga, fQuantCarga);
  Application.CreateForm(TfClienteBusca, fClienteBusca);
  Application.CreateForm(TfMunicipioBusca, fMunicipioBusca);
  Application.CreateForm(TfVeiculoCte, fVeiculoCte);
  Application.Run;
end.

