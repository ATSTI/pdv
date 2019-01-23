unit fSangria;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  MaskEdit, StdCtrls;

type

  { TfSangria }

  TfSangria = class(TForm)
    btnGravar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure Sangria();

  end;

var
  fSangria: TfSangria;

implementation

{$R *.lfm}

{ TfSangria }

procedure TfSangria.btnSangriaClick(Sender: TObject);
begin

end;

end.

