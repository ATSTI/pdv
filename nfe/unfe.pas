unit uNFe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls;

type

  { TfNFe }

  TfNFe = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
  private

  public

  end;

var
  fNFe: TfNFe;

implementation

uses udmpdv;

{$R *.lfm}

end.

