Program prjIntegracaoDaemon;

Uses
{$IFDEF UNIX}{$IFDEF UseCThreads}
  CThreads,
{$ENDIF}{$ENDIF}
  DaemonApp, lazdaemonapp, daemonIntegra, daemonIntegracao
  { add your units here };

begin
  Application.Title:='Daemon application';
  Application.Initialize;
  Application.Run;
end.
