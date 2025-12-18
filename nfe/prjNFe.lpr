program prjNFe;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, datetimectrls, uNFe, udmPdv, uCertificadoLer, uInutilizar;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='ATS-NFe Nota Fiscal Eletrônica';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TdmPdv, dmPdv);
  Application.CreateForm(TfNFe, fNFe);
  Application.CreateForm(TfInutlizar, fInutlizar);
  Application.Run;
end.

