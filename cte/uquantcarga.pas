unit uQuantCarga;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type
  TfQuantCarga = class(TForm)
  private

  public
    fcarga : integer;
  end;

var
  fQuantCarga: TfQuantCarga;

implementation

{$R *.lfm}

end.

