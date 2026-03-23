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
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLReport1: TRLReport;
    RLReport2: TRLReport;
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLReport2BeforePrint(Sender: TObject; var PrintIt: Boolean);
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
    fimprisangria.RLLabel2.Caption := DateToStr(fSangria.Dtdata.Date);
    fimprisangria.RLLabel4.Caption := DateToStr(fSangria.Dtdata1.Date);
    fimprisangria.RLLabel6.Caption := 'Sangrias';
end;

procedure Tfimprisangria.RLReport2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
    fimprisangria.RLLabel10.Caption := DateToStr(fSangria.Dtdata2.Date);
    fimprisangria.RLLabel11.Caption := DateToStr(fSangria.Dtdata3.Date);
    fimprisangria.RLLabel16.Caption := 'Reforços';
end;

end.

