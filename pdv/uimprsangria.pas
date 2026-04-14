unit uimprsangria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { Tfimprisangria }

  Tfimprisangria = class(TForm)
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLReport1: TRLReport;
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private

  public

  end;

var
  fimprisangria: Tfimprisangria;

implementation
uses
  udmpdv,usangria;

{$R *.lfm}

{ Tfimprisangria }

procedure Tfimprisangria.RLReport1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  fimprisangria.RLLabel2.Caption := DateToStr(fSangria.Dtdata2.Date);
  fimprisangria.RLLabel4.Caption := DateToStr(fSangria.Dtdata3.Date);
  fimprisangria.RLLabel6.Caption := 'Sangrias';
end;


end.

