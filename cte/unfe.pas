unit uNFe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, EditBtn, DBCtrls, DBDateTimePicker, db;

type

  { TfNFe }

  TfNFe = class(TForm)
    btnOk: TBitBtn;
    btnEdita: TBitBtn;
    DBDateTimePicker1: TDBDateTimePicker;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnEditaClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private

  public
    fnfe : integer;
  end;

var
  fNFe: TfNFe;

implementation

uses uDmCte, udmpdv;

{$R *.lfm}

{ TfNFe }

procedure TfNFe.btnOkClick(Sender: TObject);
var vNfe_str:String;
begin
  // TODO testar o IF do Campo DATA
  if (dmCte.sqNFeCHAVE.AsString = '') then
  begin
    ShowMessage('Informe a CHAVE da NFe.');
    Exit;
  end;
  if (dmCte.sqNFeDPREV.IsNull) then
  begin
    ShowMessage('Informe a Data da NFe.');
    Exit;
  end;
  vNfe_str := '';
  if (dmCte.dsNFe.State in [dsEdit]) then
  begin
    vNfe_str := 'UPDATE CTE_NFE SET CHAVE = ';
    vNfe_str := vNfe_str + QuotedStr(dmCte.sqNFeCHAVE.AsString);
    if(dmCte.sqNFePIN.AsInteger > 0)then
    begin
      vNfe_str := vNfe_str + ', PIN = ';
      vNfe_str := vNfe_str +  QuotedStr(IntToStr(dmCte.sqNFePIN.AsInteger));
    end;
    vNfe_str := vNfe_str + ', DPREV = ';
    vNfe_str := vNfe_str +  QuotedStr(FormatDateTime('mm/dd/yyyy',
      dmCte.sqNFeDPREV.AsDateTime));
    vNfe_str := vNfe_str + ' WHERE COD_CTE_NFE = ';
    vNfe_str := vNfe_str + IntToStr(dmCte.sqNFeCOD_CTE_NFE.AsInteger);
  end;
  if (dmCte.dsNFe.State in [dsInsert]) then
  begin
    vNfe_str := 'INSERT INTO CTE_NFE (CTE_NFE, CHAVE,DPREV, PIN  ' +
               ') VALUES ( ';
    vNfe_str := vNfe_str + IntToStr(dmCte.cdsCteCOD_CTE.AsInteger);
    vNfe_str := vNfe_str + ', ' + QuotedStr(dmCte.sqNFeCHAVE.AsString);
    vNfe_str := vNfe_str + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',
      dmCte.sqNFeDPREV.AsDateTime));
    if(dmCte.sqNFePIN.AsInteger > 0)then
    begin
      vNfe_str := vNfe_str + ', ' + QuotedStr(IntToStr(dmCte.sqNFePIN.AsInteger));
    end
    else begin
      vNfe_str := vNfe_str + ', NULL';
    end;
    vNfe_str := vNfe_str + ')';
  end;
  if (vNfe_str <> '') then
    dmPdv.Ibcon.ExecuteDirect(vNfe_str);
  Close;
end;

procedure TfNFe.btnEditaClick(Sender: TObject);
begin
  Close;
end;

end.

