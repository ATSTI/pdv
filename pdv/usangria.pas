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
    procedure FormShow(Sender: TObject);
  private

  public
    SangriaReforco: String;
    procedure Sangria();

  end;

var
  fSangria: TfSangria;

implementation

{$R *.lfm}

{ TfSangria }


procedure TfSangria.btnGravarClick(Sender: TObject);
var
  IMPRESSORA:TextFile;
begin
  if (edValor.Text = '') then
  begin
    ShowMessage('Informar Valor ' + SangriaReforco);
    exit;
  end;
  if (edMotivo.text = '') then
  begin
    ShowMessage('Informar Motivo ' + SangriaReforco);
    exit;
  end;

  Sangria();
  ShowMessage('Gravado com Sucesso!');

  if (dmPdv.CupomImp = 'Texto') then
  begin
    AssignFile(IMPRESSORA, dmPdv.portaIMP);
  end
  else begin
    AssignFile(IMPRESSORA, dmPdv.path_imp);
  end;

  try
    Rewrite(IMPRESSORA);
    //lFile.LoadFromFile('caixa.txt');
    Writeln(IMPRESSORA, '');
    Writeln(Impressora, SangriaReforco + ' CAIXA');
    Writeln(IMPRESSORA, FormatDateTime('dd/mm/yyyy hh:MM:ss', Now));
    Writeln(IMPRESSORA, '');
    Writeln(Impressora, 'CAIXA : ' + dmPdv.nomeCaixa);
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Valor       - ' + edValor.Text);
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Motivo :');
    if (Length(edMotivo.Text) > dmPdv.tamanhoLinha) then
    begin
      Writeln(IMPRESSORA, Copy(edMotivo.Text,0,dmPdv.tamanhoLinha));
      Writeln(IMPRESSORA, Copy(edMotivo.Text,dmPdv.tamanhoLinha+1,dmPdv.tamanhoLinha));
    end
    else begin
        Writeln(IMPRESSORA, edMotivo.Text);
    end;
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Assinatura :');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '------------------------------');
    Writeln(IMPRESSORA, '');
  finally
    CloseFile(IMPRESSORA);
  end;

  close;
end;

procedure TfSangria.FormShow(Sender: TObject);
begin
  edMotivo.Text := '';
  edValor.Text := '0,00';
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
  if SangriaReforco = 'Sangria' then
    sqPagamentoCOD_VENDA.AsInteger := 1
  else
    sqPagamentoCOD_VENDA.AsInteger := 0;
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

