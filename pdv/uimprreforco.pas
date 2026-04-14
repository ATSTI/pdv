unit uimprreforco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { Tfimprreforco }

  Tfimprreforco = class(TForm)
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel9: TRLLabel;
    RLReport2: TRLReport;
    procedure RLReport2BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private

  public

  end;

var
  fimprreforco: Tfimprreforco;

implementation
uses
  udmpdv,usangria;
{$R *.lfm}

{ Tfimprreforco }

procedure Tfimprreforco.RLReport2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  fimprreforco.RLLabel10.Caption := DateToStr(fSangria.Dtdata.Date);
  fimprreforco.RLLabel11.Caption := DateToStr(fSangria.Dtdata1.Date);
  fimprreforco.RLLabel16.Caption := 'Reforços';
end;

end.

