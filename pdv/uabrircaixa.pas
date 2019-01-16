unit uabrircaixa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, MaskEdit, Buttons, udmpdv;

type

  { TfAbrirCaixa }

  TfAbrirCaixa = class(TForm)
    btnAbrefecha: TBitBtn;
    dtData: TDateTimePicker;
    Label1: TLabel;
    edValor: TMaskEdit;
    procedure btnAbrefechaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure AbrirCaixa();
    procedure FecharCaixa();


  public
    AbrirFechar:string;

  end;

var
  fAbrirCaixa: TfAbrirCaixa;

implementation

{$R *.lfm}

{ TfAbrirCaixa }

procedure TfAbrirCaixa.btnAbrefechaClick(Sender: TObject);
begin

  if (AbrirFechar = 'Abrir') then
  begin
    AbrirCaixa();
  end
  else begin
    FecharCaixa();
  end;
end;

procedure TfAbrirCaixa.FormShow(Sender: TObject);
begin
  if (AbrirFechar = 'Abrir') then
  begin
    btnAbrefecha.Caption := 'Abrir';
    Label1.Caption:= 'Abrir Caixa';
  end
  else begin
    btnAbrefecha.Caption := 'Fechar';
    Label1.Caption:= 'Fechar Caixa';

  end;

end;

procedure TfAbrirCaixa.AbrirCaixa();
var str:string;
  codCaixa:integer;
  vlrCaixa:double;
begin
  if (dmPdv.sqGenerator.Active) then
    dmPdv.sqGenerator.Close;
  dmPdv.sqGenerator.SQL.Clear;
  dmPdv.sqGenerator.SQL.Text := 'SELECT CAST(GEN_ID(GEN_CAIXA, 1) AS INTEGER) ' +
    'AS CODIGO FROM RDB$DATABASE';
  dmPdv.sqGenerator.Open;
  codCaixa := dmPdv.sqGenerator.Fields[0].AsInteger;
  dmPdv.sqGenerator.Close;

  str := 'insert into CAIXA_CONTROLE (IDCAIXACONTROLE, CODCAIXA, CODUSUARIO,' +
    'SITUACAO, NOMECAIXA, MAQUINA, DATAABERTURA, VALORABRE) values (';
  str := str + IntToStr(codCaixa);
  str := str + ', ' + dmpdv.ccusto_padrao;
  str := str + ', ' + dmpdv.varLogado;
  str := str + ', ' + QuotedStr('o');
  str := str + ', ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtData.Date));
  str := str + ', ' + QuotedStr(dmpdv.MICRO);
  str := str + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtData.Date));
  vlrCaixa := StrToFloat(edValor.Text);
  DecimalSeparator:='.';
  str := str + ', ' + FloatToStr(vlrCaixa);
  DecimalSeparator:=',';
  str := str + ')';
  dmPdv.IbCon.ExecuteDirect(str);
  dmPdv.sTrans.Commit;
  ShowMessage('Caixa aberto com sucesso!');


end;

procedure TfAbrirCaixa.FecharCaixa();
var str:string;
  codCaixa:integer;
  vlrCaixa:double;
begin

  str := 'update CAIXA_CONTROLE set SITUACAO = ';
  str := str + QuotedStr('F');
  str := str + ', DATAFECHAMENTO = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', now));
  vlrCaixa := StrToFloat(edValor.Text);
  DecimalSeparator:='.';
  str := str + ', VALORFECHA = ' + FloatToStr(vlrCaixa);
  str := str + ' where IDCAIXACONTROLE = ' + dmpdv.idcaixa;
  DecimalSeparator:=',';
  dmPdv.IbCon.ExecuteDirect(str);
  dmPdv.sTrans.Commit;
  ShowMessage('Caixa fechado com sucesso!');


end;

end.

