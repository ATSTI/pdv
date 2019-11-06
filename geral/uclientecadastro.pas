unit uClienteCadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  udmpdv;

type

  { TfClienteCadastro }

  TfClienteCadastro = class(TForm)
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    dsCliente: TDataSource;
    DBEdit1: TDBEdit;
    Panel1: TPanel;
    Panel2: TPanel;
  private

  public

  end;

var
  fClienteCadastro: TfClienteCadastro;

implementation

{$R *.lfm}

end.

