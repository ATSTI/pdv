unit uNFe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, EditBtn;

type

  { TfNFe }

  TfNFe = class(TForm)
    btnOk: TBitBtn;
    btnEdita: TBitBtn;
    dataNFePrev: TDateEdit;
    edtNFeChave: TLabeledEdit;
    edtNFePin: TLabeledEdit;
    Label1: TLabel;
  private

  public
    fnfe : integer;
  end;

var
  fNFe: TfNFe;

implementation

{$R *.lfm}

end.

