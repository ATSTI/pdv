unit uDmCte;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb;

type

  { TdmCte }

  TdmCte = class(TDataModule)
    cdsCte: TSQLQuery;
  private

  public

  end;

var
  dmCte: TdmCte;

implementation

uses udmpdv;

{$R *.lfm}

end.

