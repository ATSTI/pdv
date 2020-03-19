program prjNFe;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, uNFe, udmPdv, uCertificadoLer, uInutilizar
  { you can add units after this };

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

