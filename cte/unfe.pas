unit uNFe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfNFe }

  TfNFe = class(TForm)
    btnEdita: TBitBtn;
    edtNFserie: TEdit;
  private

  public
    fnfe : integer;
  end;

var
  fNFe: TfNFe;

implementation

{$R *.lfm}

end.

