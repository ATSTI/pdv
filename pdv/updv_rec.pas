unit updv_rec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,

  ExtCtrls, Buttons, DBGrids, MaskEdit, ActnList, udmpdv, uvenda, uRecebimento,
  sqldb, db;

type

  { TfPDV_Rec }

  TfPDV_Rec = class(TForm)
    acDescontoValor: TAction;
    acDescontoPercentual: TAction;
    acCartaoDebito: TAction;
    acCartaoCredito: TAction;
    acPrazo: TAction;
    acCheque: TAction;
    acOutros: TAction;
    acFechar: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn27: TBitBtn;
    btnDescontoPercent: TBitBtn;
    btnDescontoValor: TBitBtn;
    BitBtn24: TBitBtn;
    BitBtn25: TBitBtn;
    BitBtn26: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    btnDsc: TBitBtn;
    dsPag: TDataSource;
    DBGrid1: TDBGrid;
    edValorVendaTotal: TMaskEdit;
    edVDesconto: TMaskEdit;
    edVendedor: TMaskEdit;
    Edit2: TEdit;
    edCliente: TMaskEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    edPagamento: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblStatus: TLabel;
    lblForma: TLabel;
    edValorTotal: TMaskEdit;
    edDesconto: TMaskEdit;
    edValorPago: TMaskEdit;
    edRestante: TMaskEdit;
    edTroco: TMaskEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    sqPagamento: TSQLQuery;
    sqPagamentoCAIXA: TSmallintField;
    sqPagamentoCAIXINHA: TFloatField;
    sqPagamentoCOD_VENDA: TLongintField;
    sqPagamentoDESCONTO: TFloatField;
    sqPagamentoFORMA_PGTO: TStringField;
    sqPagamentoID_ENTRADA: TLongintField;
    sqPagamentoN_DOC: TStringField;
    sqPagamentoSTATE: TSmallintField;
    sqPagamentoTROCO: TFloatField;
    sqPagamentoVALOR_PAGO: TFloatField;
    procedure acCartaoCreditoExecute(Sender: TObject);
    procedure acCartaoDebitoExecute(Sender: TObject);
    procedure acChequeExecute(Sender: TObject);
    procedure acDescontoPercentualExecute(Sender: TObject);
    procedure acDescontoValorExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
    procedure acOutrosExecute(Sender: TObject);
    procedure acPrazoExecute(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn27Click(Sender: TObject);
    procedure btnDescontoPercentClick(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure btnDscClick(Sender: TObject);
    procedure edPagamentoKeyPress(Sender: TObject; var Key: char);
    procedure edVDescontoKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    vCodVenda: Integer;
    num_doc: Integer;
    vValorTotal: Double;
    vValorPago: Double;
    vValorVenda: Double;
    vResto: Double;
    vDesconto: Double;
    vTroco: Double;

    procedure calcula_total;
    procedure grava_desconto;
    procedure registra_valores(v_vlr: Double);
    procedure encerra_venda();
  public
    vStatus : Integer;
    vVendedor: Integer;
    vUsuario: Integer;
    vCaixa_Local: Integer;
    vValor: String;
    vClienteNome: String;
    vVendedorNome: String;
    vCliente: Integer;
    vCodMovimento: Integer;
  end;

var
  fPDV_Rec: TfPDV_Rec;

implementation

{$R *.lfm}

{ TfPDV_Rec }

procedure TfPDV_Rec.FormShow(Sender: TObject);
begin
  edValorPago.Color := clWhite;
  edVDesconto.Color := clWhite;
  edPagamento.Color := clWhite;
  lblStatus.Caption := 'Fechamento.';
  vStatus := 0;
  vValorVenda := StrToFloat(vValor);
  vResto := vValorVenda;
  num_doc := 0;
  vValorTotal := 0;
  edvDesconto.Text:='';
  vDesconto:=0;
  lblForma.Caption:='1-Dinheiro';
  vCodVenda := 0;
  edCliente.Text := vClienteNome;
  edVendedor.Text := vVendedorNome;
  edValorTotal.Text:= vValor;
  edValorVendaTotal.Text := vValor;
  calcula_total;
end;

procedure TfPDV_Rec.calcula_total;
var vaDesc: Double;
 vaTroco: Double;
 vaTotal: Double;
begin
  vaDesc := 0;
  vaTroco := 0;
  vaTotal := 0;
  if sqPagamento.active then
    sqPagamento.Close;
  sqPagamento.Params.ParamByName('PCODMOV').AsInteger:=vCodMovimento;
  sqPagamento.Open;
  if (not sqPagamento.IsEmpty) then
  begin
    vStatus := sqPagamentoSTATE.AsInteger;
    vCodVenda:=sqPagamentoCOD_VENDA.AsInteger;
    while not sqPagamento.EOF do
    begin
      num_doc := num_doc + 1;
      vaDesc  := vaDesc + sqPagamentoDESCONTO.AsFloat;
      vaTroco := vaTroco + sqPagamentoTROCO.AsFloat;
      vaTotal := vaTotal+ sqPagamentoVALOR_PAGO.AsFloat;
      sqPagamento.Next;
    end;
  end;
  vValorPago := vaTotal - vaDesc;
  if ((vaTotal + 0.00999) > vValorVenda) then
  begin
    vResto := 0;
  end
  else begin
    vResto := vValorVenda - vaTotal;
  end;
  edValorPago.Text := FormatFloat('#,,,0.00',vaTotal);
  edTroco.Text := FormatFloat('#,,,0.00',vaTroco);
  vaDesc := vaDesc + vDesconto;
  vResto := vResto - vaDesc;
  edDesconto.Text := FormatFloat('#,,,0.00',vaDesc);
  edRestante.Text := FormatFloat('#,,,0.00',vResto);
  edPagamento.Text:= edRestante.Text;
  if vResto > 0.009 then
  begin
    edPagamento.SetFocus;
  end;
  if (vStatus = 1) then
  begin
    edValorPago.Color := clSilver;
    edVDesconto.Color := clSilver;
    edPagamento.Color := clSilver;
    lblStatus.Caption := 'Venda Finalizada';
  end;
end;

procedure TfPDV_Rec.grava_desconto;
begin
  if vStatus = 1 then
  begin
    ShowMessage('Venda já finalizada');
    Exit;
  end;
  if sqPagamento.Active and not sqPagamento.IsEmpty then
  begin

    sqPagamento.Edit;
    sqPagamentoDESCONTO.AsFloat:=vDesconto;
    sqPagamento.ApplyUpdates;
    dmPdv.sTrans.Commit;
    vDesconto:=0;
    edvDesconto.Text:='';
  end;
end;

procedure TfPDV_Rec.registra_valores(v_vlr: Double);
var
  fVnd : TVenda;
  vTeste: Integer;
begin
  if vStatus = 1 then
  begin
    ShowMessage('Venda já finalizada');
    Exit;
  end;

 vTeste := vCodVenda;
  if vCodVenda = 0 then
  begin
    // insere venda
    Try
      fVnd := TVenda.Create;
      dmPdv.sTrans.Active := True;
      fVnd.CodMov := vCodMovimento;
      fVnd.Caixa  := vCaixa_Local;
      fVnd.CodCCusto   := vCaixa_Local;
      fVnd.CodCliente  := vCliente;
      fVnd.CodUsuario  := vUsuario;
      fVnd.CodVendedor := vVendedor;
      fVnd.Controle    := '';
      fVnd.DataVenda   := Now;
      fVnd.DataVcto    := Now;
      fVnd.Desconto    := 0;
      fVnd.Valor       := v_vlr;
      fVnd.NotaFiscal  := vCodMovimento;
      fVnd.Serie       := 'PDV';
      vCodVenda := fVnd.inserirVenda(0);
      dmPdv.sTrans.Commit;
    finally
      fVnd.Free;
    end;
  end;
  sqPagamento.Open;
  sqPagamento.Insert;
  sqPagamentoCAIXA.AsInteger     := num_doc;
  sqPagamentoCOD_VENDA.AsInteger := vCodVenda;
  sqPagamentoFORMA_PGTO.AsString := Copy(lblForma.Caption,1,1);
  sqPagamentoID_ENTRADA.AsInteger:= vCodMovimento;
  sqPagamentoN_DOC.AsString      := lblForma.Caption;
  sqPagamentoSTATE.AsInteger     := 0;
  vValorPago := StrToFloat(edPagamento.Text);
  if vValorPago > vResto then
  begin
    edTroco.Text := FloatToStr(vValorPago - vResto);
    vValorPago := vResto;
  end;
  sqPagamentoVALOR_PAGO.AsFloat  := vValorPago;

  sqPagamentoDESCONTO.AsFloat    := vDesconto;
  sqPagamentoTROCO.AsFloat       := StrToFloat(edTroco.Text);
  sqPagamento.ApplyUpdates;
  dmPdv.sTrans.Commit;
  num_doc := num_doc + 1;
  edPagamento.Text := '0,00';
  calcula_total;

end;

procedure TfPDV_Rec.encerra_venda();
//var vRec : TRecebimento;
begin

  dmPdv.IbCon.ExecuteDirect('UPDATE FORMA_ENTRADA SET STATE = 1 WHERE ID_ENTRADA = ' +
    IntToStr(vCodMovimento));
  dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 1 WHERE CODMOVIMENTO  = ' +
    IntToStr(vCodMovimento));
  dmPdv.sTrans.Commit;
  vStatus := 1;
  {
  vRec := TRecebimento.Create(Nil);
  try
    vRec.CodVendedor:= vVendedor;
    vRec.CodCliente := vCliente;
    vRec.Caixa      := vCaixa_Local;
    vRec.CodCCusto  := vCaixa_Local;
    vRec.CodOrigem  := vCodVenda;
    vRec.CodVenda   := vCodVenda;
    vRec.CodUsuario := vUsuario;
    vRec.Valor      := vValorVenda;
    vRec.ValorRec   := vValorVenda;
  finally
    vRec.Free;
  end;}
end;

procedure TfPDV_Rec.edPagamentoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if ((edPagamento.Text <> '') and (vResto > 0.01))  then
    begin
      registra_valores(StrToFloat(edPagamento.Text));
    end;
  end;
end;

procedure TfPDV_Rec.edVDescontoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if (edDesconto.Text <> '') then
    begin
      btnDsc.Click;
    end;
  end;
end;

procedure TfPDV_Rec.BitBtn9Click(Sender: TObject);
begin
  lblForma.Caption:='1-Dinheiro';
end;

procedure TfPDV_Rec.btnDscClick(Sender: TObject);
var percent : Double;
begin
  if btnDsc.Caption = 'R$' then
  begin
    vDesconto := StrToFloat(edVDesconto.Text);
    edDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  end;
  if btnDsc.Caption = '%' then
  begin
    percent := StrToFloat(edVDesconto.Text);
    percent := 1-(percent/100);
    vDesconto:= vValorPago * percent;;
    edDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  end;
  grava_desconto;
  calcula_total;
end;

procedure TfPDV_Rec.BitBtn18Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn19Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn17Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.acDescontoValorExecute(Sender: TObject);
begin
  vDesconto := StrToFloat(edVDesconto.Text);
  edDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  grava_desconto;
  calcula_total;
end;

procedure TfPDV_Rec.acFecharExecute(Sender: TObject);
begin
  if vStatus = 1 then
  begin
    Close;
  end;

  if (vResto > 0.009) then
  begin
    ShowMessage('Informe o Pagamento.');
    Exit;
  end;
  encerra_venda();
  Close;
end;

procedure TfPDV_Rec.acOutrosExecute(Sender: TObject);
begin
  lblForma.Caption:='6-Outros';
end;

procedure TfPDV_Rec.acPrazoExecute(Sender: TObject);
begin
  lblForma.Caption:='4-Crédito';
end;

procedure TfPDV_Rec.acDescontoPercentualExecute(Sender: TObject);
var percent: Double;
begin
  btnDsc.Caption:='%';
  percent := StrToFloat(edVDesconto.Text);
  percent := 1-(percent/100);
  vDesconto:= vValorPago * percent;;
  edDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  grava_desconto;
  calcula_total;
end;

procedure TfPDV_Rec.acCartaoDebitoExecute(Sender: TObject);
begin
  lblForma.Caption:='2-Cartão Débito';
end;

procedure TfPDV_Rec.acChequeExecute(Sender: TObject);
begin
  lblForma.Caption:='5-Cheque';
end;

procedure TfPDV_Rec.acCartaoCreditoExecute(Sender: TObject);
begin
  lblForma.Caption:='3-Cartão Crédito';
end;

procedure TfPDV_Rec.BitBtn20Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn21Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn27Click(Sender: TObject);
begin
  Close;
end;

procedure TfPDV_Rec.btnDescontoPercentClick(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn24Click(Sender: TObject);
begin
  Close;
end;

end.

