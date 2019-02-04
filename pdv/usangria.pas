unit usangria;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  Buttons, MaskEdit, StdCtrls, udmpdv;

type

  { TfSangria }

  TfSangria = class(TForm)
    btnFechar: TBitBtn;
    btnGravar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    edMotivo: TMaskEdit;
    edValor: TMaskEdit;
    sqPagamento: TSQLQuery;
    sqPagamentoCAIXA: TSmallintField;
    sqPagamentoCAIXINHA: TFloatField;
    sqPagamentoCODFORMA: TLongintField;
    sqPagamentoCOD_VENDA: TLongintField;
    sqPagamentoDESCONTO: TFloatField;
    sqPagamentoFORMA_PGTO: TStringField;
    sqPagamentoID_ENTRADA: TLongintField;
    sqPagamentoN_DOC: TStringField;
    sqPagamentoSTATE: TSmallintField;
    sqPagamentoTROCO: TFloatField;
    sqPagamentoVALOR_PAGO: TFloatField;
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private

  public
    procedure Sangria();

  end;

var
  fSangria: TfSangria;

implementation

{$R *.lfm}

{ TfSangria }


procedure TfSangria.btnGravarClick(Sender: TObject);
begin
  if (edValor.Text = '') then
  begin
    ShowMessage('Informar Valor da Sangria!');
    exit;
  end;
  if (edMotivo.text = '') then
  begin
    ShowMessage('Informar Motivo da Sangria!');
    exit;
  end;
  Sangria();
  ShowMessage('Gravado com Sucesso!');
  close;
end;

procedure TfSangria.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfSangria.Sangria();
var
  codForma: integer;
  vlrSangria: double;
begin
  if (dmPdv.sqGenerator.Active) then
    dmPdv.sqGenerator.Close;
  dmPdv.sqGenerator.SQL.Clear;
  dmPdv.sqGenerator.SQL.Text := 'SELECT CAST(GEN_ID(GEN_FORMA, 1) AS INTEGER) ' +
    'AS CODIGO FROM RDB$DATABASE';
  dmPdv.sqGenerator.Open;
  codForma := dmPdv.sqGenerator.Fields[0].AsInteger;
  dmPdv.sqGenerator.Close;
  sqPagamento.Open;
  sqPagamento.Insert;
  sqPagamentoCODFORMA.AsInteger  := codForma;
  sqPagamentoCAIXA.AsInteger     := StrToInt(dmPdv.idcaixa);
  sqPagamentoCOD_VENDA.AsInteger := 1;
  sqPagamentoFORMA_PGTO.AsString := '1';
  sqPagamentoID_ENTRADA.AsInteger:= StrToINT(dmPdv.idcaixa);
  sqPagamentoN_DOC.AsString      := edMotivo.Text;
  sqPagamentoSTATE.AsInteger     := 1;
  vlrSangria := StrToFloat(edValor.Text);
  //DecimalSeparator:='.';
  sqPagamentoVALOR_PAGO.AsFloat := vlrSangria;
  //DecimalSeparator:=',';
  sqPagamentoDESCONTO.AsFloat    := 0;
  sqPagamentoTROCO.AsFloat       := 0;
  sqPagamento.ApplyUpdates;
  dmPdv.sTrans.Commit;

end;

end.

