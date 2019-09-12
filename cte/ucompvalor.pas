unit uCompValor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls;

type

  { TfCompValor }

  TfCompValor = class(TForm)
    btnEdita: TBitBtn;
    btnOk: TBitBtn;
    edtCompNome: TLabeledEdit;
    valComp: TLabeledEdit;
  private

  public
    fvalor : integer;
  end;

var
  fCompValor: TfCompValor;

implementation

{$R *.lfm}

end.

