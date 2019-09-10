program prjCTe;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, datetimectrls, uCtePrincipal, uDmCte, uNFe
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  SetFBLibPath('/usr/lib/x86-64-linux-gnu/libfbclient.so.2.5.9');
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfCTePrincipal, fCTePrincipal);
  Application.CreateForm(TdmCte, dmCte);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

