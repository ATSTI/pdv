unit urelcteOS;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TfrelcteOS }

  TfrelcteOS = class(TForm)
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
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
  frelcteOS: TfrelcteOS;

implementation
uses
udmpdv,uCtePrincipal;

{$R *.lfm}

{ TfrelcteOS }

procedure TfrelcteOS.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean
  );
begin
    frelcteOS.RLLabel2.Caption := DateToStr(fCtePrincipal.DateTimePicker1.Date);
    frelcteOS.RLLabel4.Caption := DateToStr(fCtePrincipal.DateTimePicker2.Date);
    frelcteOS.RLLabel6.Caption := fCtePrincipal.edtEmitenteCte.Text;
end;

end.

