unit uSuporte;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls, LCLIntf;

type

  { TfSuporte }

  TfSuporte = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    StaticText1: TStaticText;
    procedure BitBtn1Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
    procedure StaticText1MouseEnter(Sender: TObject);
    procedure StaticText1MouseLeave(Sender: TObject);
  private

  public

  end;

var
  fSuporte: TfSuporte;

implementation

{$R *.lfm}

{ TfSuporte }

procedure TfSuporte.StaticText1MouseEnter(Sender: TObject);
begin
  StaticText1.Cursor := crHandPoint;
  StaticText1.Font.Color:=clBlue;
end;

procedure TfSuporte.StaticText1MouseLeave(Sender: TObject);
begin
  StaticText1.Font.Color:=clDefault;
end;

procedure TfSuporte.BitBtn1Click(Sender: TObject);
begin
  OpenURL(StaticText1.Caption);
end;

procedure TfSuporte.StaticText1Click(Sender: TObject);
begin
  OpenURL(StaticText1.Caption);
end;

end.

