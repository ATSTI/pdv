unit daemonIntegra;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, daemonIntegracao, DaemonApp;

type

  { TDaemonMapper1 }

  TDaemonMapper1 = class(TDaemonMapper)
    procedure DaemonMapper1Run(Sender: TObject);
  private

  public

  end;

var
  DaemonMapper1: TDaemonMapper1;

implementation

procedure RegisterMapper;
begin
  RegisterDaemonMapper(TDaemonMapper1)
end;

{$R *.lfm}

{ TDaemonMapper1 }

procedure TDaemonMapper1.DaemonMapper1Run(Sender: TObject);
var tx: TdExecutaIntegracao;
begin
  tx.DataModuleCreate(Nil);
  tx.OnStart := busca_ultimo_integrado;
end;


initialization
  RegisterMapper;
end.

