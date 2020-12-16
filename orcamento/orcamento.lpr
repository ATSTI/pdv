program orcamento;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uprincipal, zcomponent, udm, uBuscaOrc, uRel, uLancados, datetimectrls,
  uOrcamento
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.CreateForm(TfBuscaOrc, fBuscaOrc);
  Application.CreateForm(TfRel, fRel);
  Application.CreateForm(TfLancados, fLancados);
  Application.CreateForm(TfOrcamento, fOrcamento);
  Application.Run;
end.

