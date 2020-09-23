unit uEstoqueExecuta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, udmpdv;

type

  { TEstoqueThread }

  TEstoqueThread = class(TThread)
  protected
    procedure Execute; override;
    procedure atualiza;
  end;

implementation

{ TEstoqueThread }

procedure TEstoqueThread.Execute;
begin
  atualiza;
end;

procedure TEstoqueThread.atualiza;
begin
  try
    dmPdv.IbCon.ExecuteDirect('EXECUTE PROCEDURE ESTOQUE_ATUALIZA_V (' +
        IntToStr(dmPdv.codMovimentoEst) + ')');
    dmPdv.sTrans.Commit;
  except
    on E : Exception do
    begin
      dmPdv.sTrans.Rollback;
    end;
  end;
end;

end.

