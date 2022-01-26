program prjIntegraSimples;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, indylaz, uIntegraSimples, udmpdv;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tdmpdv, dmpdv);
  Application.CreateForm(TfIntegracaoOdoo, fIntegracaoOdoo);
  Application.Run;
end.

