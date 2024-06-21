unit updv_rec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, DBGrids, MaskEdit, ActnList, Menus, ACBrPosPrinter, udmpdv,
  uvenda, uRecebimento, uClienteBusca, uNfce, sqldb, db, math, StrUtils,
  IniFiles, uCadeira, uPermissao, uIntegracaoOdoo, typinfo, LConvEncoding,
  fphttpclient, JsonTools, uIntegraSimples, fpjson, jsonparser;

type

  { TfPDV_Rec }

  TfPDV_Rec = class(TForm)
    ACBrPosPrinter1: TACBrPosPrinter;
    acDescontoValor: TAction;
    acDescontoPercentual: TAction;
    acCartaoDebito: TAction;
    acCartaoCredito: TAction;
    acPrazo: TAction;
    acCheque: TAction;
    acFechar: TAction;
    acDinheiro: TAction;
    acExcluirLancamento: TAction;
    acCancelaFechamento: TAction;
    acNfce: TAction;
    actionPix: TAction;
    acVoltarVenda: TAction;
    ActionListFechamento: TActionList;
    BitBtn1: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    btnCupom: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn24: TBitBtn;
    BitBtn25: TBitBtn;
    BitBtn27: TBitBtn;
    btnCadeira: TBitBtn;
    BitBtn9: TBitBtn;
    btnDsc: TBitBtn;
    chkPercent: TCheckBox;
    cbxModeloPosPrinter: TComboBox;
    DBGrid1: TDBGrid;
    dsPag: TDataSource;
    edCupom: TEdit;
    edDesconto: TMaskEdit;
    edParcela: TEdit;
    edRestante: TMaskEdit;
    edTroco: TMaskEdit;
    edValorTotal: TMaskEdit;
    edValorVendaTotal: TMaskEdit;
    edVDesconto: TMaskEdit;
    edVendedor: TMaskEdit;
    edCliente: TMaskEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    edPagamento: TMaskEdit;
    imgTroca: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblCupom: TLabel;
    lblStatus: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblForma: TLabel;
    lblParcela: TLabel;
    edValorPago: TMaskEdit;
    MemoImp: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Panel1: TPanel;
    pnCartoes: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PopupMenu1: TPopupMenu;
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
    procedure acCancelaFechamentoExecute(Sender: TObject);
    procedure acCartaoCreditoExecute(Sender: TObject);
    procedure acCartaoDebitoExecute(Sender: TObject);
    procedure acChequeExecute(Sender: TObject);
    procedure acDescontoPercentualExecute(Sender: TObject);
    procedure acDescontoValorExecute(Sender: TObject);
    procedure acDescPercentualExecute(Sender: TObject);
    procedure acDinheiroExecute(Sender: TObject);
    procedure acExcluirLancamentoExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
    procedure acNfceExecute(Sender: TObject);
    procedure acOutrosExecute(Sender: TObject);
    procedure acPrazoExecute(Sender: TObject);
    procedure actionPixExecute(Sender: TObject);
    procedure acVoltarVendaExecute(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn26Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnCadeiraClick(Sender: TObject);
    procedure btnCupomClick(Sender: TObject);
    procedure btnDescontoPercentClick(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure btnDscClick(Sender: TObject);
    procedure edCupomChange(Sender: TObject);
    procedure edCupomKeyPress(Sender: TObject; var Key: char);
    procedure edPagamentoKeyPress(Sender: TObject; var Key: char);
    procedure edPagoChange(Sender: TObject);
    procedure edParcelaChange(Sender: TObject);
    procedure edParcelaKeyPress(Sender: TObject; var Key: char);
    procedure edRestanteChange(Sender: TObject);
    procedure edTrocoChange(Sender: TObject);
    procedure edVDescontoKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox2Click(Sender: TObject);
    procedure lblParcelaClick(Sender: TObject);
  private
    cupom_mv: String;
    cod_compra: Integer;
    serie_cx: String;
    num_cx: Integer;
    vCodVenda: Integer;
    num_doc: Integer;
    vValorTotal: Double;
    vValorPago: Double;
    vValorVenda: Double;
    vResto: Double;
    vTroco: Double;
    function RemoveAcento(Str: string): string;
    procedure calcula_total(tipo: string);
    procedure carrega_valores;
    procedure grava_desconto;
    procedure registra_valores(v_vlr: Double);
    procedure encerra_venda();
    procedure imprimir();
    procedure imprimirTxt();
    procedure imprimirTxtOutro();
    procedure imprimiAcbr();
    procedure insereRecebimento(parc_rec: Integer; vlr_rec: Double;
      vlr_tot_rec: Double; via_rec: Integer; n_doc_rec: String; forma_rec: String;
      vlr_via_rec: Double);
    procedure gerarjson;
  public
    OutrosCartoes: String;
    v_log: String;
    vStatus : Integer;
    vVendedor: Integer;
    vUsuario: Integer;
    vCaixa_Local: Integer;
    vValor: String;
    vClienteNome: String;
    vVendedorNome: String;
    vCliente: Integer;
    vCodMovimento: Integer;
    vDesconto : Double;
    function strParaFloat(vlr_st: String): Double;
  end;

var
  fPDV_Rec: TfPDV_Rec;

implementation

{$R *.lfm}

{ TfPDV_Rec }

procedure TfPDV_Rec.FormShow(Sender: TObject);
var vr_curso: string;
begin
  cupom_mv := '0';
  cod_compra := 0;

  num_cx := 0;
  MemoImp.Clear;
  imgTroca.Visible:=False;
  lblCupom.Visible:=False;
  edCupom.Visible:=False;
  lblParcela.Visible:= False;
  edParcela.Visible := False;
  edParcela.Text := '1';
  edVDesconto.Color := clWhite;
  edPagamento.Color := clWhite;
  //edValorPago.Color := clWhite;
  lblStatus.Caption := 'Fechamento.';
  vStatus := 0;

  //vValor := FormatFloat('#,,,0.00',vValor);
  vValorVenda := StrParaFloat(vValor);
  vResto := vValorVenda;
  num_doc := 0;
  vValorTotal := 0;
  vValorPago := 0;
  edvDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  vDesconto:=0;
  lblForma.Caption:='1-Dinheiro';
  vCodVenda := 0;
  edCliente.Text := vClienteNome;
  edVendedor.Text := vVendedorNome;
  edValorTotal.Text:= FormatFloat('#,,,0.00',vValorVenda);
  edValorVendaTotal.Text := vValor;
  calcula_total('inicio');
  edVDesconto.SetFocus;
  edPagamento.SetFocus;

  if (dmPdv.usaCurso > 0) then
  begin
    //verifica se algum item vendido e do tipo curso
    dmPdv.sqLancamentos.Close;
    dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := vCodMovimento;
    dmPdv.sqLancamentos.Open;
    while not dmPdv.sqLancamentos.Eof do
    begin
      vr_curso := dmPdv.sqLancamentosRATEIO.AsString;
      if (Trim(vr_curso) = '5') then
      begin
        btnCadeira.Visible := True;
      end;
      dmPdv.sqLancamentos.Next;
    end;
    if (btnCadeira.Visible = True) then
    begin
      fCadeira.listaCurso := TStringList.Create;
      dmPdv.sqLancamentos.First;
      while not dmPdv.sqLancamentos.Eof do
      begin
        vr_curso := dmPdv.sqLancamentosRATEIO.AsString;
        if (Trim(vr_curso) = '5') then
        begin
          fCadeira.listaCurso.Add(IntToStr(dmPdv.sqLancamentosCODPRODUTO.AsInteger));
        end;
        dmPdv.sqLancamentos.Next;
      end;
    end;
  end;
  carrega_valores;
end;

procedure TfPDV_Rec.GroupBox2Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.lblParcelaClick(Sender: TObject);
begin

end;

function TfPDV_Rec.RemoveAcento(Str: string): string;
  const
  ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
   x: Integer;
   verAcento : String;
begin;
  for x := 1 to Length(Str) do
  if Pos(Str[x],ComAcento) <> 0 then
  begin
    verAcento := Str[x];
    if Str[x] > #120 then
      str[x] := Char('')
    else
      Str[x] := SemAcento[Pos(Str[x], ComAcento)];
    verAcento := Str[x];
  end;
  str := UTF8String(str);
  for x := 1 to Length(Str) do
    if Str[x] > #127 then
      str[x] := 'a';
  //Result := AnsiToUtf8(str);
  Result := str;
end;

procedure TfPDV_Rec.calcula_total(tipo: string);
var
 vaTroco: Double;
 vaTotal: Double;
 vaPagoC: Double;

 vaResto: Double;
 vaPago: Double;
 vaDesc: Double;

 vaRestoFim: Double;
 vaTrocoIni: Double;
 vaTrocoFim: Double;

 vaPagoFim: Double;
 vaDescIni: Double;
 vaDescFim: Double;
 vaA_pagarIni: Double;
 vaA_pagarFim: Double;

begin
  vaDesc := 0;
  //vaDesc := StrParaFloat(edDesconto.Text);
  vaTroco := 0.0;
  vaPago := 0.0;
  vaDesc := StrParaFloat(edVDesconto.Text);
  vaResto := StrParaFloat(edRestante.Text);
  if tipo <> 'desconto' then
    vaPago := StrParaFloat(edPagamento.Text);
  if vaPago > vaResto then
  begin
    vaTroco := 0.0;
    if ((vaPago - vaResto) > 0.001) then
    begin
      vaTroco := vaPago - vaResto;
      vaResto := 0.0;
    end;

    edTroco.Text := FormatFloat('#,,,0.00', vaTroco);
  end;
  vResto := vaResto - vaDesc;
  edValorPago.Text := FormatFloat('#,,,0.00', vaPago - vaTroco);
  {
  vaPagoIni := StrParaFloat(edValorPago.Text);
  vaTrocoIni := StrParaFloat(edTroco.Text);
  vaDescIni := StrParaFloat(edDesconto.Text);
  vaA_pagarIni := StrParaFloat(edPagamento.Text);
   }
  //valResto := StrParaFloat(edRestante.Text);
  //if vaTotal > 0.00 then
  //  vaTroco := vaTotal - vResto - vDesconto;
  {if sqPagamento.active then
    sqPagamento.Close;
  sqPagamento.Params.ParamByName('PCODMOV').AsInteger:=vCodMovimento;
  sqPagamento.Params.ParamByName('PCODCAIXA').AsInteger := StrToInt(dmPdv.idcaixa);
  sqPagamento.open;
  if (not sqPagamento.IsEmpty) then
  begin
    vStatus := sqPagamentoSTATE.AsInteger;
    vCodVenda:=sqPagamentoCOD_VENDA.AsInteger;
    while not sqPagamento.EOF do
    begin
      num_doc := num_doc + 1;
      vaDesc  := vaDesc + sqPagamentoDESCONTO.AsFloat;
      vaTroco := vaTroco + sqPagamentoTROCO.AsFloat;
      vaPagoC := vaPagoC + sqPagamentoVALOR_PAGO.AsFloat;
      sqPagamento.Next;
    end;
  end;
  vaDesc := vaDesc + vDesconto;

  //vResto := StrParaFloat(edPagamento.Text);
  //valResto := vValorVenda - vaDesc - vaPagoC - vaTotal;
  //vaDesc := vaDesc + vDesconto;

  if ((vaTotal + 0.00999) > vValorVenda) then
  begin
    vResto := 0;
  end
  else begin
    vResto := valResto; // vValorVenda - vaTotal - vaDesc - vaPagoC;
    if vResto < 0.01 then
      vResto := 0.0
  end;

  if tipo = 'desconto' then
  begin
    vResto := vaTotal - vaDesc;
    vValorVenda := vValorVenda - vaDesc;
  end;
  if tipo = 'pagamento' then
  begin
    vValorPago := vaTotal;
    if ((vaTotal > 0) and (vaTotal > vResto)) then
      vaTroco := vaTotal - vResto;
    vResto := vValorVenda - vaDesc - vaPagoC - vaTotal;
  end;

  edValorPago.Text := FormatFloat('#,,,0.00',vaPagoC + vValorPago);
  edTroco.Text := FormatFloat('#,,,0.00',vaTroco);
  //vResto := vResto - vaDesc;
  edDesconto.Text := FormatFloat('#,,,0.00',vaDesc);
  edRestante.Text := FormatFloat('#,,,0.00',vResto);
  if vResto > 0.009 then
  begin
    edPagamento.Text:= edRestante.Text;
  end
  else begin
    edPagamento.Text := '0,00';
    edRestante.Text := '0,00';
  end;
  edRestante.SetFocus;
  edPagamento.SetFocus;
  }
  if ((vStatus = 1) and (vResto < 0.009)) then
  begin
    edValorPago.Color := clSilver;
    edVDesconto.Color := clSilver;
    edPagamento.Color := clSilver;
    lblStatus.Caption := 'Venda Finalizada';
  end;
  if ((btnCadeira.Visible = True) and (vStatus = 0)) then
  begin
     btnCadeira.Enabled := False;
  end;
end;

procedure TfPDV_Rec.carrega_valores;
var vcResto,vcDesc,vcTroco, vcPago: Double;
begin
  vcResto := 0;
  vcDesc := StrParaFloat(edVDesconto.Text);
  vcTroco := 0;
  vcPago := 0;
  if sqPagamento.active then
    sqPagamento.Close;
  sqPagamento.Params.ParamByName('PCODMOV').AsInteger:=vCodMovimento;
  sqPagamento.Params.ParamByName('PCODCAIXA').AsInteger := StrToInt(dmPdv.idcaixa);
  sqPagamento.open;
  if (not sqPagamento.IsEmpty) then
  begin
    //vStatus := sqPagamentoSTATE.AsInteger;
   // vCodVenda:=sqPagamentoCOD_VENDA.AsInteger;
    while not sqPagamento.EOF do
    begin
      num_doc := num_doc + 1;
      vcDesc  += vcDesc + sqPagamentoDESCONTO.AsFloat;
      vcTroco := vcTroco + sqPagamentoTROCO.AsFloat;
      vcPago := vcPago + sqPagamentoVALOR_PAGO.AsFloat;
      sqPagamento.Next;
    end;
  end;
  if vcPago < 0.001 then
    vcPago := 0.0;

  edTroco.Text := FormatFloat('#,,,0.00',vcTroco);
  // desconto nao carrega senao grava duas vezes
  //edDesconto.Text := FormatFloat('#,,,0.00',vcDesc);
  vcResto := vValorVenda - vcDesc - vcPago;
  if vcResto < 0.001 then
    vcResto := 0.0;

  vResto := vcResto;
  edRestante.Text := FormatFloat('#,,,0.00',vcResto);
  edPagamento.Text := FormatFloat('#,,,0.00',vcResto);
  edValorPago.Text := FormatFloat('#,,,0.00',vcPago);
  edVDesconto.SetFocus;
  edPagamento.SetFocus;
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
  codForma: Integer;
  vlr_desc, vlr_Troco: Double;
  ver_str, insert_pag: String;
begin
  if vStatus = 1 then
  begin
    ShowMessage('Venda já finalizada');
    Exit;
  end;

  // vTeste := vCodVenda;
  if vCodVenda = 0 then
  begin
    dmPdv.sqUpdate.Close;
    dmPdv.sqUpdate.SQL.Clear;
    dmPdv.sqUpdate.SQL.Text := 'SELECT * FROM SERIES WHERE SERIE = ' +
      QuotedStr('PDV-'+dmPdv.varLogado);
    dmPdv.sqUpdate.Open;
    serie_cx := dmPdv.sqUpdate.FieldByName('SERIE').AsString;
    num_cx := dmPdv.sqUpdate.FieldByName('ULTIMO_NUMERO').AsInteger+1;
    dmPdv.sqUpdate.Close;
    dmPdv.sqUpdate.UpdateSQL.Clear;
    dmPdv.sqUpdate.UpdateSQL.Text := 'UPDATE SERIES SET ULTIMO_NUMERO = ' +
      IntToStr(num_cx) + ' WHERE SERIE = ' +
      QuotedStr('PDV-'+dmPdv.varLogado);

    dmPdv.sqUpdate.Open;
    dmPdv.sqUpdate.Edit;
    try
      dmPdv.sqUpdate.Post;
      dmPdv.sqUpdate.ApplyUpdates;
    except
      ShowMessage('Série não cadastrada para este usuário.');
      Exit;
    end;
    // insere venda
    fVnd := TVenda.Create;
    Try
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
      fVnd.NParcela   := 1;
      fVnd.Valor       := strParaFloat(vValor);
      fVnd.NotaFiscal  := num_cx;
      Label11.Caption := IntToStr(num_cx);
      fVnd.Serie       := serie_cx;
      vCodVenda := fVnd.inserirVenda(0);
      dmPdv.sTrans.Commit;
    Except
      fVnd.Free;
      ShowMessage('Erro no fechamento, tente novamente');
      Exit;
    end;
    fVnd.Free;
  end;
  if (dmPdv.sqGenerator.Active) then
    dmPdv.sqGenerator.Close;
  dmPdv.sqGenerator.SQL.Clear;
  dmPdv.sqGenerator.SQL.Text := 'SELECT CAST(GEN_ID(GEN_FORMA, 1) AS INTEGER) ' +
    'AS CODIGO FROM RDB$DATABASE';
  try
    dmPdv.sqGenerator.Open;
  except
    ShowMessage('Crie o Generator : CREATE GENERATOR gen_forma ');
  end;
  codForma := dmPdv.sqGenerator.Fields[0].AsInteger;
  dmPdv.sqGenerator.Close;
  // sqPagamento.Insert;
  insert_pag := 'INSERT INTO FORMA_ENTRADA (CODFORMA, CAIXA, COD_VENDA, '+
     ' FORMA_PGTO, ID_ENTRADA, CAIXINHA, N_DOC, STATE, VALOR_PAGO, DESCONTO, TROCO) VALUES(';
  insert_pag  += IntToStr(codForma) + ', ';
  insert_pag  += dmPdv.idcaixa + ', ';
  insert_pag  += IntToStr(vCodVenda) + ', ';
  insert_pag  += QuotedStr(Copy(lblForma.Caption,1,1)) + ', ';
  insert_pag  += IntToStr(vCodMovimento) + ', ';
  ver_str := Copy(lblForma.Caption,1,1);
  if ((cod_compra > 0) and (ver_str = '9')) then
    insert_pag  += IntToStr(cod_compra) + ', '
  else
    insert_pag  += 'Null, ';
  insert_pag  += QuotedStr(lblForma.Caption) + ', ';
  insert_pag  += '0, ';
  vlr_Troco := StrParaFloat(edTroco.Text);
  vValorPago := StrParaFloat(edPagamento.Text);
  vlr_desc := StrParaFloat(edVDesconto.Text);
  //if vValorPago > vResto then
  //begin
  //  vlr_desD := vValorPago - vResto - vlr_desTroco; // so pra ver o Troco
  //  vlr_desT := FloatToStr(vValorPago - vResto);
  //  //edTroco.Text := vlr_desT;
  //end
  //else begin
  //  vlr_desD := vValorPago - vlr_desTroco; // so pra ver o Troco
  //end;
  //vValorPago := vlr_desD;
  DecimalSeparator:='.';
  insert_pag  += FloatToStr(vValorPago-vlr_Troco) + ', ';

  insert_pag  += FloatToStr(vlr_desc) + ', ';
  if vlr_Troco > 0.0 then
    insert_pag  += FloatToStr(vlr_Troco)
  else
    insert_pag  += '0.0';
  insert_pag += ')';
  DecimalSeparator:=',';
  dmPdv.IbCon.ExecuteDirect(insert_pag);
  dmPdv.sTrans.Commit;

  if sqPagamento.Active then
     sqPagamento.Close;
  sqPagamento.Params.ParamByName('PCODMOV').AsInteger:=vCodMovimento;
  sqPagamento.Params.ParamByName('PCODCAIXA').AsInteger := StrToInt(dmPdv.idcaixa);
  sqPagamento.open;
  //calcula_total('inicio');
  vDesconto := 0;
  edvDesconto.Text:='0,00';
  num_doc := num_doc + 1;
  {if vResto > 0.0 then
    edPagamento.Text := edRestante.Text
  else
    edPagamento.Text := '0,00';
  edTroco.Text := '0,00';}
end;

procedure TfPDV_Rec.encerra_venda();
var vRec : TRecebimento;
   vlr_entrada: Double;
   vlr_troca: Double;
   vlr_prazo: Double;
   vlr_desc: Double;
   vlr_total_resto : Double;
   vlr_prim_via : Double;
   vlr_parc : Double;
   str_up: String;
   n_doc: String;
   n_prc: Integer;
   forma_pagto: String;
   tot_lanc: integer;
   num_lanc: Integer;
   i: Integer;
   ver_sql: String;
begin
  vlr_entrada := 0;
  vlr_desc := 0;
  vlr_troca := 0;
  vlr_prazo := 0;
  tot_lanc := 0;
  num_lanc := 0;
  dmPdv.IbCon.ExecuteDirect('UPDATE FORMA_ENTRADA SET STATE = 1 ' +
    ' WHERE STATE = 0 AND ID_ENTRADA = ' +
    IntToStr(vCodMovimento));
  try
    ver_sql := 'UPDATE MOVIMENTO SET STATUS = 1 ' +
      ' , CODCLIENTE = ' + IntToStr(vCliente) +
      ' , DATA_FECHOU = ' + QuotedStr(FormatDateTime('mm/dd/yyyy hh:MM:ss', Now)) +
      ' , CONTROLE = ' + QuotedStr(IntToStr(num_cx)) +
      ' WHERE CODMOVIMENTO  = ' +
      IntToStr(vCodMovimento) + ' AND STATUS = 0';
    dmPdv.IbCon.ExecuteDirect(ver_sql);
    dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTODETALHE SET BAIXA = 1 ' +
      ' WHERE CODMOVIMENTO  = ' + IntToStr(vCodMovimento) +
      ' AND BAIXA IS NULL AND STATUS = 0');
    dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTODETALHE SET BAIXA = NULL ' +
      ' WHERE CODMOVIMENTO  = ' + IntToStr(vCodMovimento) +
      ' AND BAIXA = 1 AND STATUS = 2');
  except
    {dmPdv.IbCon.ExecuteDirect('ALTER TABLE MOVIMENTO ' +
      ' ADD DATA_FECHOU TIMESTAMP');
    dmPdv.sTrans.Commit;
    dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 1 ' +
      ' , CODCLIENTE = ' + IntToStr(vCliente) +
      ' , DATA_FECHOU = ' + QuotedStr(FormatDateTime('mm/dd/yyyy hh:MM:ss', Now)) +
      ' WHERE CODMOVIMENTO  = ' +
      IntToStr(vCodMovimento) + ' AND STATUS = 0');}
    ShowMessage('Erro para baixar venda');
  end;

  vStatus := 1;

  dmPdv.busca_sql('SELECT CODFORMA, COD_VENDA, ID_ENTRADA, FORMA_PGTO' +
    ' , CAIXA , N_DOC, VALOR_PAGO, CAIXINHA, TROCO, DESCONTO, STATE' +
    ' FROM FORMA_ENTRADA WHERE STATE < 2 AND ID_ENTRADA = ' +
    InttoStr(vCodMovimento) + ' ORDER BY FORMA_PGTO');
  forma_pagto := '1';
  while not dmPdv.sqBusca.EOF do
  begin
    tot_lanc += 1;
    forma_pagto := Trim(dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString);
    vlr_entrada += dmPdv.sqBusca.FieldByName('VALOR_PAGO').AsFloat;
    vlr_desc += dmPdv.sqBusca.FieldByName('DESCONTO').AsFloat;
    if (forma_pagto = '4') then
    begin
      vlr_prazo += dmPdv.sqBusca.FieldByName('VALOR_PAGO').AsFloat;
    end;
    if (forma_pagto = '9') then
    begin
      vlr_troca += dmPdv.sqBusca.FieldByName('VALOR_PAGO').AsFloat;
    end;
    dmPdv.sqBusca.Next;
  end;
  vlr_prim_via := vlr_entrada;
  n_prc := 1;
  if (edParcela.Text <> '1') then
  begin
    n_prc := StrToInt(edParcela.Text);
  end;
  //if (vlr_entrada > 0) then
  //begin
  //  n_prc := n_prc + 1;
  //end;
  DecimalSeparator:='.';
  str_up := 'UPDATE VENDA SET ENTRADA = ' +
    FloatToStr(vlr_entrada) +
    ' , DESCONTO = ' + FloatToStr(vlr_desc) +
    ' , CAIXA = ' + IntToStr(dmPdv.contaCaixa) +
    ' , N_PARCELA = ' + IntToStr(n_prc) +
    ' WHERE CODVENDA  = ' +
    IntToStr(vCodVenda);
  DecimalSeparator:=',';
  dmPdv.IbCon.ExecuteDirect(str_up);

  dmPdv.sqBusca.First;
  while not dmPdv.sqBusca.EOF do
  begin
    num_lanc += 1;
    forma_pagto := Trim(dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString);
    n_doc := IntToStr(dmPdv.sqBusca.FieldByName('CODFORMA').AsInteger);
    if (forma_pagto <> '4') then
    begin
      //-dmPdv.sqBusca.FieldByName('DESCONTO').AsFloat  tirei isto estava indo desconto dobrado
      insereRecebimento(0,
        dmPdv.sqBusca.FieldByName('VALOR_PAGO').AsFloat,
        vlr_entrada,
        num_lanc,
        n_doc, forma_pagto, vlr_prim_via);
      vlr_prim_via := 0;
    end;
    if (forma_pagto = '4') then
    begin
      vlr_parc := roundTo((vlr_prazo / n_prc),-2);
      vlr_total_resto := vlr_prazo;
      for i := 1 to n_prc do
      begin
        if (i = n_prc) then
        begin
          vlr_parc := vlr_total_resto;
        end
        else begin
          vlr_total_resto -= vlr_parc;
        end;
        insereRecebimento(i,
          vlr_parc,
          vlr_entrada,
          num_lanc,
          n_doc, forma_pagto,vlr_prim_via);
        vlr_prim_via := 0;
        num_lanc += 1;
      end;
    end;
    // Troca
    if (forma_pagto = '9') then
    begin
      //teve troca :
      cod_compra := StrToInt(FloatToStr(dmPdv.sqBusca.FieldByName('CAIXINHA').AsFloat));
      if (cod_compra > 0) then
      begin
        // colocar o cupom como ja baixado
        dmPdv.IbCon.ExecuteDirect('UPDATE COMPRA SET STATUS = 9, N_BOLETO = ' +
          IntToStr(vCodMovimento) + ' WHERE CODMOVIMENTO = ' + IntToStr(cod_compra));
        dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 99 ' +
          ' WHERE CODMOVIMENTO = ' + intToStr(cod_compra));
      end;
    end;
    dmPdv.sqBusca.Next;
  end;
  try
    // 08/02/2021 Coloquei aqui pq no Caldana nao esta atualizando o estoque
    dmPdv.IbCon.ExecuteDirect('EXECUTE PROCEDURE ESTOQUE_ATUALIZA_V (' +
      IntToStr(vCodMovimento) + ')');
    dmPdv.sTrans.Commit;
  except
    on e: Exception do
    begin
      MessageDlg('Error','Erro na finalização da venda ' +
        e.Message,mtError,[mbOK],0);
      dmPdv.sTrans.Rollback;
    end;
  end;
end;

procedure TfPDV_Rec.imprimir();
var
 IMPRESSORA:TextFile;
 Texto,Texto1,Texto2,Texto3,Texto4,texto5, texto6, logradouro,cep,fone, clientecupom, doccli : string;//Para recortar parte da descrição do produto,nome
 produto_cupomf : string;
begin
  if (not dmPdv.sqEmpresa.Active) then
    dmPdv.sqEmpresa.Open;
  {----- aqui monto o endereço-----}
  logradouro := '  ' + dmPdv.sqEmpresaENDERECO.Value +
     ', ' + dmPdv.sqEmpresaBAIRRO.Value;
  cep :=  '  ' + dmPdv.sqEmpresaCIDADE.Value + ' - ' + dmPdv.sqEmpresaUF.Value +
  ' - ' + dmPdv.sqEmpresaCEP.Value;
  fone := '  (19)' + dmPdv.sqEmpresaFONE.Value + ' / ' + dmPdv.sqEmpresaFONE_1.Value +
  ' / ' + dmPdv.sqEmpresaFONE_2.Value;
  {------------------------DADOS DO CLIENTE--------------------------}
  clientecupom := '  ' + IntToStr(vCliente) + '-' + vClienteNome;
  Texto  := '----------------------------------------' ;
  Texto1 := '  ' + FormatDateTime('dd/mm/yyyy hh:MM:ss', Now) + '  Pedido :  ' +
    IntToStr(vCodMovimento);
  Texto2 := '----------------------------------------' ;
  Texto4 := '  Produto       UN     Qtde   V.Un.  V.Total ' ;
  Texto5 := '  ' + DateTimeToStr(Now) + ' Total.: R$     ';
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT * FROM PARAMETRO WHERE PARAMETRO = ' +
    QuotedStr('PORTA IMPRESSORA');
  dmPdv.sqBusca.Open;
  if dmPdv.sqBusca.IsEmpty then
  begin
    ShowMessage('Parametro: PORTA IMPRESSORA não informado');
    Exit;
  end;
  //portaIMP := dmPdv.sqBusca.FieldByName('DADOS').AsString;
  //if (dm.portaImpressora2 <> '') then
  //,  portaIMP := dm.portaImpressora2;
  //portaIMP := 'C:\home\imprime.txt';
  AssignFile(IMPRESSORA, dmPdv.portaIMP);
  try
    Rewrite(IMPRESSORA);
    Writeln(Impressora, '  VENDA');
    Writeln(IMPRESSORA);
    Writeln(Impressora, RemoveAcento(Format('  %-36s',[dmPdv.sqEmpresaRAZAO.Value])));
    Writeln(Impressora, logradouro);
    Writeln(Impressora, cep);
    Writeln(Impressora, fone);
    // Writeln(Impressora, c10cpi + Format('%-36s',['CNPJ :' + dm.cds_empresaCNPJ_CPF.Value]));
    Writeln(Impressora, texto);
    Writeln(Impressora, clientecupom);
    Writeln(Impressora, doccli);
    Writeln(Impressora, texto);
    Writeln(Impressora, texto1);
    Writeln(Impressora, texto2);
    Writeln(Impressora, texto4);
    {-------------------Imprimi itens do boleto-----------------}
    dmPdv.sqLancamentos.Close;
    dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := vCodMovimento;
    dmPdv.sqLancamentos.Open;

    while not dmPdv.sqLancamentos.Eof do
    begin

      dmPdv.sqLancamentos.RecordCount;
      texto3 := '';
      texto6 := '  ';
      //texto6 := Format('%-4s',[fVendas.cds_Mov_detCODPRO.Value]);
      texto3 := texto3 + Format('                %-2s',[dmPdv.sqLancamentosUNIDADEMEDIDA.Value]);
      texto3 := texto3 + Format('    %6.2n',[dmPdv.sqLancamentosQUANTIDADE.AsFloat]);
      texto3 := texto3 + Format(' %6.2n',[dmPdv.sqLancamentosPRECO.AsFloat]);
      texto3 := texto3 + Format('   %6.2n',[dmPdv.sqLancamentosVALTOTAL.value]);

      //produto_cupomf := trim(dmPdv.sqLancamentosCODPRO.Value) + '-' +
      //   trim(dmPdv.sqLancamentosDESCPRODUTO.Value) + ' - ' + trim(fVendas.cds_Mov_detMARCA.Value);
      produto_cupomf := trim(RemoveAcento(dmPdv.sqLancamentosDESCPRODUTO.Value));
      texto6 := texto6 + '  ' + Copy(produto_cupomf, 0, 36);       //descrição do produto
      Writeln(Impressora, texto6);
      if (length(produto_cupomf)>36) then
      begin
        texto6 := '    ' + Copy(produto_cupomf, 37, 72);       //descrição do produto
        Writeln(Impressora, texto6);
      end;

      Writeln(Impressora, texto3);//NOME DO PRODUTO
      //with Printer.Canvas do
      //begin
      //  Font.Name := 'Courier New';
      //  Font.Size := 4;
      //end;
      dmPdv.sqLancamentos.next;
    end;
    texto3 := '';
    texto6 := '';

  finally
    CloseFile(IMPRESSORA);
  end;

end;

procedure TfPDV_Rec.imprimirTxt();
var
  IMPRESSORA:TextFile;
  lFile   : TStringList;
  i      : Integer;
  logradouro: String;
  cep: String;
  fone: String;
  clientecupom: string;
  texto3: String;
  texto6: String;
  produto_cupomf: String;
  linhaTxt : String;
  prazo : String;
  totalP: Double;
  totalD: Double;
  ItemDesc: Double;
  totalR: Double;
begin
  v_log := 'Log de impressão - ';
  if (not sqPagamento.Active) then
     sqPagamento.Open;
  v_log := 'Log de impressão 1 ';
  prazo := 'N';
  totalP := 0;
  totalD := 0;
  totalR := 0;
  sqPagamento.First;
  while not sqPagamento.Eof do
  begin
    totalR += sqPagamentoVALOR_PAGO.AsFloat;
    totalD += sqPagamentoDESCONTO.AsFloat;
    if Trim(sqPagamentoFORMA_PGTO.AsString) = '4' then
      prazo := 'S';
    sqPagamento.Next;
  end;
  v_log := 'Log de impressão 2 ';
  totalP := totalR + totalD;
  if (not dmPdv.sqEmpresa.Active) then
    dmPdv.sqEmpresa.Open;
  v_log := 'Log de impressão 3 ';
  {----- aqui monto o endereço-----}
  logradouro := '  ' + dmPdv.sqEmpresaENDERECO.Value +
     ', ' + dmPdv.sqEmpresaBAIRRO.Value;
  cep :=  '  ' + dmPdv.sqEmpresaCIDADE.Value + ' - ' + dmPdv.sqEmpresaUF.Value +
  ' - ' + dmPdv.sqEmpresaCEP.Value;
  fone := '  (19)' + dmPdv.sqEmpresaFONE.Value + ' / ' + dmPdv.sqEmpresaFONE_1.Value +
  ' / ' + dmPdv.sqEmpresaFONE_2.Value;
  {------------------------DADOS DO CLIENTE--------------------------}
  clientecupom := '  ' + IntToStr(vCliente) + '-' + RemoveAcento(vClienteNome);
  dmPdv.sqLancamentos.Close;
  dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := vCodMovimento;
  dmPdv.sqLancamentos.Open;
  // leio um arquivo txt e imprimo
  v_log := 'Log de impressão - criando lFile ';
  lFile := TStringList.Create;
  if ((dmPdv.CupomImp = 'Texto') or (dmPdv.CupomImp = 'DB')) then
  begin
    v_log := 'Log portaImp - ' + dmPdv.portaIMP;
    AssignFile(IMPRESSORA, dmPdv.portaIMP);
  end
  else begin
    v_log := 'Log path_imp - ' + dmPdv.path_imp;
    AssignFile(IMPRESSORA, dmPdv.path_imp);
  end;
  v_log := 'Log abrindo cupom.txt ' + dmpdv.path_exe + 'cupom.txt';
  try
    Rewrite(IMPRESSORA);
    lFile.LoadFromFile(dmpdv.path_exe + 'cupom.txt');
    for i:=0 to lFile.Count-1 do
    begin
      v_log := 'Log lendo cupom.txt ';
      linhaTxt := Copy(lFile[i],0,1);
      if lFile[i] = 'empresa' then
        Writeln(Impressora, RemoveAcento(Format('  %-36s',[dmPdv.sqEmpresaRAZAO.Value])))
      else if lFile[i] = 'logradouro' then
        Writeln(Impressora, logradouro)
      else if lFile[i] = 'cep' then
        Writeln(Impressora, cep)
      else if lFile[i] = 'fone' then
      begin
        Writeln(Impressora, fone);
      end
      else if lFile[i] = 'linha' then
      begin
        Writeln(IMPRESSORA, '');
      end
      else if lFile[i] = 'usuario' then
      begin
        Writeln(impressora, 'Usuario: ' + dmpdv.nomeLogado);
        Writeln(impressora, 'Vendedor: ' + RemoveAcento(edVendedor.Text));
      end
      else if ((lFile[i] = 'cliente') or (lFile[i] = 'clientecompleto')) then
      begin
        if lFile[i] = 'clientecompleto' then
        begin
          dmPdv.qsCliente.Close;
          dmPdv.qsCliente.Params.ParamByName('ID').AsInteger := vCliente;
          dmPdv.qsCliente.Open;
          if dmPdv.qsCliente.IsEmpty then
          begin
            Writeln(Impressora, clientecupom);
          end
          else begin
            clientecupom := '  ' + IntToStr(vCliente) + '-' + RemoveAcento(vClienteNome);
            Writeln(Impressora, clientecupom);
            clientecupom := ' Doc.: ' + dmPdv.qsClienteCNPJ.AsString + ', ' + dmPdv.qsClienteINSCESTADUAL.AsString;
            Writeln(Impressora, clientecupom);
            clientecupom := ' End.: ' + dmPdv.qsClienteLOGRADOURO.AsString + ', ' + dmPdv.qsClienteNUMERO.AsString;
            Writeln(Impressora, clientecupom);
            clientecupom := ' ' + dmPdv.qsClienteBAIRRO.AsString + ', ' + dmPdv.qsClienteCIDADE.AsString + ', ' + dmPdv.qsClienteUF.AsString;
            Writeln(Impressora, clientecupom);
            clientecupom :=  ' ' + dmPdv.qsClienteDDD.AsString + '-' + dmPdv.qsClienteTELEFONE.AsString;
            Writeln(Impressora, clientecupom);
          end;
        end
        else begin
          Writeln(Impressora, clientecupom);
        end;
      end
      else if lFile[i] = 'doc' then
        Writeln(Impressora, '  ' + FormatDateTime('dd/mm/yyyy hh:MM:ss', Now) +
          ' Pedido :' + IntToStr(vCodMovimento) + '/' + label11.Caption)
      else if lFile[i] = 'itens' then
      begin
        while not dmPdv.sqLancamentos.Eof do
        begin
          dmPdv.sqLancamentos.RecordCount;
          ItemDesc := 0;
          if not dmPdv.sqLancamentosVALOR_DESCONTO.IsNull then
              ItemDesc := dmPdv.sqLancamentosVALOR_DESCONTO.AsFloat;
          texto3 := '';
          texto6 := '  ';
          texto3 := texto3 + Format('       %-2s',[dmPdv.sqLancamentosUNIDADEMEDIDA.Value]);
          texto3 := texto3 + Format('    %6.3n',[dmPdv.sqLancamentosQUANTIDADE.AsFloat]);
          texto3 := texto3 + Format(' %6.2n',[dmPdv.sqLancamentosPRECO.AsFloat]);
          if ItemDesc > 0 then
            texto3 := texto3 + Format(' %6.2n',[ItemDesc]);
          texto3 := texto3 + Format('   %6.2n',[dmPdv.sqLancamentosVALTOTAL.value-ItemDesc]);
          //produto_cupomf := trim(RemoveAcento(dmPdv.sqLancamentosDESCPRODUTO.Value));
          produto_cupomf := trim(RemoveAcento(dmPdv.sqLancamentosCODPRO.Value)) + '-' + trim(RemoveAcento(dmPdv.sqLancamentosDESCPRODUTO.Value));
          texto6 := texto6 + '  ' + Copy(produto_cupomf, 0, dmPdv.tamanhoLinha);       //descrição do produto
          Writeln(Impressora, texto6);
          if (length(produto_cupomf)>dmPdv.tamanhoLinha) then
          begin
            texto6 := '    ' + Copy(produto_cupomf, dmPdv.tamanhoLinha+1, dmPdv.tamanhoLinha*2);       //descrição do produto
            Writeln(Impressora, texto6);
          end;
          Writeln(Impressora, texto3);//NOME DO PRODUTO
          dmPdv.sqLancamentos.next;
        end;
      end
      else if linhaTxt = 'P' then
      begin
        sqPagamento.First;
        while not sqPagamento.Eof do
        begin
          Writeln(Impressora, 'R$ ' + FormatFloat('#,,,0.00',sqPagamentoVALOR_PAGO.AsFloat) +
             ' - ' + RemoveAcento(sqPagamentoN_DOC.AsString));
          sqPagamento.Next;
        end;
      end
      else if linhaTxt = 'D' then
      begin
        if (totalD > 0) then
        begin
          linhaTxt := '   T. Bruto' + Copy(lFile[i],13,Length(lFile[i])-1);
          Writeln(Impressora, linhaTxt + FormatFloat('#,,,0.00', totalP));

          linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
          Writeln(Impressora, linhaTxt + FormatFloat('#,,,0.00', totalD));
        end;
      end
      else if linhaTxt = 'T' then
      begin
        linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
        Writeln(Impressora, linhaTxt + FormatFloat('#,,,0.00', totalR));
      end
      else if linhaTxt = 'Z' then
      begin
        linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
        Writeln(Impressora, linhaTxt +
           FormatFloat('#,,,0.00',totalR + sqPagamentoTROCO.AsFloat) +
           ' - Troco : ' + FormatFloat('#,,,0.00',sqPagamentoTROCO.AsFloat));
      end
      else if linhaTxt = 'V' then
      begin
        linhaTxt := 'Pedido: ' + IntToStr(dmPdv.sqLancamentosCODMOVIMENTO.AsInteger);  // Copy(lFile[i],2,Length(lFile[i])-1);
        Writeln(Impressora, linhaTxt);
      end
      else if linhaTxt = 'C' then
      begin
        linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
        Writeln(Impressora, chr(27)+chr(109));
      end
      else if linhaTxt = '1' then
      begin
      end
      else if linhaTxt = '2' then
      begin
      end
      else if linhaTxt = '3' then
      begin
      end
      else if linhaTxt = '4' then
      begin
      end
      else
        Writeln(Impressora,lFile[i]);
    end;



    // CUPOM PRAZO
    if prazo = 'S' then
    begin
      i := 0;
      for i:=0 to lFile.Count-1 do
      begin
        linhaTxt := Copy(lFile[i],0,1);
        if lFile[i] = 'empresa' then
          Writeln(Impressora, RemoveAcento(Format('  %-36s',[dmPdv.sqEmpresaRAZAO.Value])))
        else if lFile[i] = 'logradouro' then
          Writeln(Impressora, logradouro)
        else if lFile[i] = 'cep' then
          Writeln(Impressora, cep)
        else if lFile[i] = 'fone' then
        begin
          Writeln(Impressora, fone);
        end
        else if lFile[i] = 'linha' then
        begin
          Writeln(IMPRESSORA);
        end
        else if lFile[i] = 'usuario' then
        begin
          Writeln(impressora, 'Usuario: ' + dmpdv.nomeLogado);
          Writeln(impressora, 'Vendedor: ' + RemoveAcento(edVendedor.Text));
        end
        else if ((lFile[i] = 'cliente') or (lFile[i] = 'clientecompleto')) then
        begin
          clientecupom := '  ' + IntToStr(vCliente) + '-' + RemoveAcento(vClienteNome);
          Writeln(Impressora, clientecupom);
        end
        else if lFile[i] = 'doc' then
          Writeln(Impressora, '  ' + FormatDateTime('dd/mm/yyyy hh:MM:ss', Now) + ' Pedido : ' + IntToStr(vCodMovimento))
        else if lFile[i] = 'itens' then
        begin
          dmPdv.sqLancamentos.First;
          while not dmPdv.sqLancamentos.Eof do
          begin
            dmPdv.sqLancamentos.RecordCount;
            texto3 := '';
            texto6 := '  ';
            texto3 := texto3 + Format('                %-2s',[dmPdv.sqLancamentosUNIDADEMEDIDA.Value]);
            texto3 := texto3 + Format('    %6.2n',[dmPdv.sqLancamentosQUANTIDADE.AsFloat]);
            texto3 := texto3 + Format(' %6.2n',[dmPdv.sqLancamentosPRECO.AsFloat]);
            texto3 := texto3 + Format('   %6.2n',[dmPdv.sqLancamentosVALTOTAL.value]);
            //produto_cupomf := trim(dmPdv.sqLancamentosDESCPRODUTO.Value);
            produto_cupomf := trim(RemoveAcento(dmPdv.sqLancamentosCODPRO.Value)) + '-' + trim(RemoveAcento(dmPdv.sqLancamentosDESCPRODUTO.Value));
            texto6 := texto6 + '  ' + Copy(produto_cupomf, 0, dmPdv.tamanhoLinha);       //descrição do produto
            Writeln(Impressora, texto6);
            if (length(produto_cupomf)>dmPdv.tamanhoLinha) then
            begin
              texto6 := '    ' + Copy(produto_cupomf, dmPdv.tamanhoLinha+1, dmPdv.tamanhoLinha*2);       //descrição do produto
              Writeln(Impressora, texto6);
            end;
            Writeln(Impressora, texto3);//NOME DO PRODUTO
            dmPdv.sqLancamentos.next;
          end;

        end
        else if linhaTxt = 'D' then
        begin
          if (totalD > 0) then
          begin
            linhaTxt := '   T. Bruto' + Copy(lFile[i],13,Length(lFile[i])-1);
            Writeln(Impressora, linhaTxt + FormatFloat('#,,,0.00', totalP));

            linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
            Writeln(Impressora, linhaTxt + FormatFloat('#,,,0.00', totalD));
          end;
        end
        else if linhaTxt = 'T' then
        begin
          linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
          Writeln(Impressora, linhaTxt + FormatFloat('#,,,0.00', totalR));
        end

        else if linhaTxt = 'V' then
        begin
          linhaTxt := 'Pedido: ' + IntToStr(dmPdv.sqLancamentosCODMOVIMENTO.AsInteger);  // Copy(lFile[i],2,Length(lFile[i])-1);
          Writeln(Impressora, linhaTxt);
        end
        else if linhaTxt = 'Z' then
        begin
        end
        else if linhaTxt = '1' then
        begin
          linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
          Writeln(Impressora, linhaTxt);
        end
        else if linhaTxt = '2' then
        begin
          linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
          Writeln(Impressora, linhaTxt);
        end
        else if linhaTxt = '3' then
        begin
          linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
          Writeln(Impressora, linhaTxt);

        end
        else if linhaTxt = '4' then
        begin
          linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
          Writeln(Impressora, linhaTxt);
        end
        else if linhaTxt = 'C' then
        begin
          linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
          Writeln(Impressora, chr(27)+chr(109));
        end
        else
          Writeln(Impressora,lFile[i]);
      end;
             /////
      linhaTxt := 'P' ;
      if linhaTxt = 'P' then
      begin
        sqPagamento.First;
        Writeln(Impressora, 'Forma de Pagamento');
        while not sqPagamento.Eof do
        begin
          Writeln(Impressora, 'R$ ' + FormatFloat('#,,,0.00',sqPagamentoVALOR_PAGO.AsFloat) +
          ' - ' + RemoveAcento(sqPagamentoN_DOC.AsString));
          sqPagamento.Next;
        end;
       end

       ////

    end;

  finally
    CloseFile(IMPRESSORA);
    lFile.Free;
  end;
  v_log := 'Log Impressao: ';
  v_log += 'conf Cupom: ' + dmPdv.CupomImp;
  if (dmPdv.CupomImp = 'BD') then
  begin
    lFile := TStringList.Create;
    try
      v_log += ', PathIMP: ' + dmPdv.path_imp;
      lFile.LoadFromFile(dmPdv.path_imp);
      texto6 := lFile.Text;
    finally
      lFile.Free;
    end;
    try
      texto6 := 'INSERT INTO AVISOS (CODAVISOS, TIPO, DESCRICAO) VALUES ('+
        'GEN_ID(GEN_AVISOS, 1), ' + QuotedStr(dmPdv.MICRO) + ', ' +
        QuotedStr(texto6) + ')';
      dmPdv.IbCon.ExecuteDirect(texto6);
      v_log += ', SQL: ' +texto6;
      dmPdv.sTrans.Commit;
    except
      on dmPdv: EDatabaseError do
      begin
        MessageDlg('Error','Erro na conexao com a base de dados, erro : ' +
          dmPdv.Message,mtError,[mbOK],0);
      end;
    end;
  end;

end;

procedure TfPDV_Rec.imprimirTxtOutro();
var
  IMPRESSORA:TextFile;
  lFile   : TStringList;
  i      : Integer;
  logradouro: String;
  cep: String;
  fone: String;
  clientecupom: string;
  texto3: String;
  texto6: String;
  produto_cupomf: String;
  linhaTxt : String;
  prazo : String;
  totalP: Double;
  totalD: Double;
  ItemDesc: Double;
  totalR: Double;
begin
  v_log := 'Log de impressão - ';
  totalP := 0;
  totalD := 0;
  totalR := 0;
  if (not dmPdv.sqEmpresa.Active) then
    dmPdv.sqEmpresa.Open;
  v_log := 'Log de impressão 3 ';
  {----- aqui monto o endereço-----}
  logradouro := '  ' + dmPdv.sqEmpresaENDERECO.Value +
     ', ' + dmPdv.sqEmpresaBAIRRO.Value;
  cep :=  '  ' + dmPdv.sqEmpresaCIDADE.Value + ' - ' + dmPdv.sqEmpresaUF.Value +
  ' - ' + dmPdv.sqEmpresaCEP.Value;
  fone := '  (19)' + dmPdv.sqEmpresaFONE.Value + ' / ' + dmPdv.sqEmpresaFONE_1.Value +
  ' / ' + dmPdv.sqEmpresaFONE_2.Value;
  {------------------------DADOS DO CLIENTE--------------------------}
  clientecupom := '  ' + IntToStr(vCliente) + '-' + RemoveAcento(vClienteNome);
  dmPdv.sqLancamentos.Close;
  dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := vCodMovimento;
  dmPdv.sqLancamentos.Open;
  // leio um arquivo txt e imprimo
  v_log := 'Log de impressão - criando lFile ';
  lFile := TStringList.Create;
  if ((dmPdv.CupomImp = 'Texto') or (dmPdv.CupomImp = 'DB')) then
  begin
    v_log := 'Log portaImp - ' + dmPdv.portaIMP;
    AssignFile(IMPRESSORA, dmPdv.portaIMP);
  end
  else begin
    v_log := 'Log path_imp - ' + dmPdv.path_imp;
    AssignFile(IMPRESSORA, dmPdv.path_imp);
  end;
  v_log := 'Log abrindo cupom.txt ' + dmpdv.path_exe + 'cupom.txt';
  try
    Rewrite(IMPRESSORA);
    lFile.LoadFromFile(dmpdv.path_exe + 'cupom_outro.txt');
    for i:=0 to lFile.Count-1 do
    begin
      v_log := 'Log lendo cupom.txt ';
      linhaTxt := Copy(lFile[i],0,1);
      if lFile[i] = 'empresa' then
        Writeln(Impressora, RemoveAcento(Format('  %-36s',[dmPdv.sqEmpresaRAZAO.Value])))
      else if lFile[i] = 'logradouro' then
        Writeln(Impressora, logradouro)
      else if lFile[i] = 'cep' then
        Writeln(Impressora, cep)
      else if lFile[i] = 'fone' then
      begin
        Writeln(Impressora, fone);
      end
      else if lFile[i] = 'linha' then
      begin
        Writeln(IMPRESSORA, '');
      end
      else if lFile[i] = 'usuario' then
      begin
        Writeln(impressora, 'Usuario: ' + dmpdv.nomeLogado);
        Writeln(impressora, 'Vendedor: ' + RemoveAcento(edVendedor.Text));
      end
      else if lFile[i] = 'cliente' then
        Writeln(Impressora, clientecupom)
      else if lFile[i] = 'doc' then
        Writeln(Impressora, '  ' + FormatDateTime('dd/mm/yyyy hh:MM:ss', Now) +
          ' Pedido :' + IntToStr(vCodMovimento) + '/' + label11.Caption)
      else if lFile[i] = 'itens' then
      begin
        while not dmPdv.sqLancamentos.Eof do
        begin
          dmPdv.sqLancamentos.RecordCount;
          texto3 := '';
          //texto6 := ' ';
          texto3 := Format('%6.1n',[dmPdv.sqLancamentosQUANTIDADE.AsFloat]);
          texto3 := texto3 + ' ' + Format(' %-2s',[dmPdv.sqLancamentosUNIDADEMEDIDA.Value]);
          produto_cupomf := texto3 + ' ' + trim(RemoveAcento(dmPdv.sqLancamentosDESCPRODUTO.Value));
          texto6 := Copy(produto_cupomf, 0, dmPdv.tamanhoLinha);       //descrição do produto
          Writeln(Impressora, texto6);
          if (length(produto_cupomf)>dmPdv.tamanhoLinha) then
          begin
            texto6 := '           ' + Copy(produto_cupomf, dmPdv.tamanhoLinha+1, dmPdv.tamanhoLinha*2);       //descrição do produto
            Writeln(Impressora, texto6);
          end;
          //Writeln(Impressora, texto3);//NOME DO PRODUTO
          dmPdv.sqLancamentos.next;
        end;
      end
      else if linhaTxt = 'V' then
      begin
        linhaTxt := 'Pedido: ' + IntToStr(dmPdv.sqLancamentosCODMOVIMENTO.AsInteger);  // Copy(lFile[i],2,Length(lFile[i])-1);
        Writeln(Impressora, linhaTxt);
      end
      else if linhaTxt = 'C' then
      begin
        linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
        Writeln(Impressora, chr(27)+chr(109));
      end
      else if linhaTxt = '1' then
      begin
      end
      else if linhaTxt = '2' then
      begin
      end
      else if linhaTxt = '3' then
      begin
      end
      else if linhaTxt = '4' then
      begin
      end
      else
        Writeln(Impressora,lFile[i]);
    end;
  finally
    CloseFile(IMPRESSORA);
    lFile.Free;
  end;
  v_log := 'Log Impressao: ';
  v_log += 'conf Cupom: ' + dmPdv.CupomImp;
  if (dmPdv.CupomImp = 'BD') then
  begin
    lFile := TStringList.Create;
    try
      v_log += ', PathIMP: ' + dmPdv.path_imp;
      lFile.LoadFromFile(dmPdv.path_imp);
      texto6 := lFile.Text;
    finally
      lFile.Free;
    end;
    {
    try
      texto6 := 'INSERT INTO AVISOS (CODAVISOS, TIPO, DESCRICAO) VALUES ('+
        'GEN_ID(GEN_AVISOS, 1), ' + QuotedStr(dmPdv.MICRO) + ', ' +
        QuotedStr(texto6) + ')';
      dmPdv.IbCon.ExecuteDirect(texto6);
      v_log += ', SQL: ' +texto6;
      dmPdv.sTrans.Commit;
    except
      on dmPdv: EDatabaseError do
      begin
        MessageDlg('Error','Erro na conexao com a base de dados, erro : ' +
          dmPdv.Message,mtError,[mbOK],0);
      end;
    end;
    }
  end;
end;

procedure TfPDV_Rec.imprimiAcbr();
var arquivo: TStringList;
begin
  arquivo := TStringList.Create();
  try
    arquivo.LoadFromFile(dmPdv.path_imp);
    MemoImp.Clear;
    MemoImp.Text := arquivo.Text;
  finally
    arquivo.free;
  end;
  ACBrPosPrinter1.Desativar;
  ACBrPosPrinter1.LinhasBuffer := dmpdv.imp_LinhasBuffer;
  ACBrPosPrinter1.LinhasEntreCupons := 0;
  ACBrPosPrinter1.EspacoEntreLinhas := dmpdv.espacoEntreLinhas;
  ACBrPosPrinter1.ColunasFonteNormal := dmpdv.imp_ColunaFonteNormal;
  ACBrPosPrinter1.Device.SendBytesCount:=1024;
  ACBrPosPrinter1.Device.SendBytesInterval := dmpdv.imp_Interval;
  ACBrPosPrinter1.ControlePorta :=  dmpdv.imp_controle_porta;
  ACBrPosPrinter1.Porta  := dmPdv.portaImp;
  //ACBrPosPrinter1.ControlePorta := cbControlePorta.Checked;
  ACBrPosPrinter1.CortaPapel := True;
  //ACBrPosPrinter1.TraduzirTags := cbTraduzirTags.Checked;
  //ACBrPosPrinter1.IgnorarTags := cbIgnorarTags.Checked;
  // ACBrPosPrinter1.PaginaDeCodigo := TACBrPosPaginaCodigo( cbxPagCodigo.ItemIndex );
  // ACBrPosPrinter1.ConfigBarras.MostrarCodigo := cbHRI.Checked;
  // ACBrPosPrinter1.ConfigBarras.LarguraLinha := seBarrasLargura.Value;
  // ACBrPosPrinter1.ConfigBarras.Altura := seBarrasAltura.Value;
  // ACBrPosPrinter1.ConfigQRCode.Tipo := seQRCodeTipo.Value;
  // ACBrPosPrinter1.ConfigQRCode.LarguraModulo := seQRCodeLarguraModulo.Value;
  // ACBrPosPrinter1.ConfigQRCode.ErrorLevel := seQRCodeErrorLevel.Value;
  // ACBrPosPrinter1.ConfigLogo.KeyCode1 := seLogoKC1.Value;
  // ACBrPosPrinter1.ConfigLogo.KeyCode2 := seLogoKC2.Value;
  // ACBrPosPrinter1.ConfigLogo.FatorX := seLogoFatorX.Value;
  // ACBrPosPrinter1.ConfigLogo.FatorY := seLogoFatorY.Value;
  ACBrPosPrinter1.Modelo := TACBrPosPrinterModelo(cbxModeloPosPrinter.ItemIndex);
  ACBrPosPrinter1.Ativar;

  ACBrPosPrinter1.Buffer.Text := MemoImp.Lines.Text;
  ACBrPosPrinter1.Imprimir;
  if (dmPdv.imp_vias = 2) then
  begin
    Sleep(1000);
    ACBrPosPrinter1.Desativar;
    ACBrPosPrinter1.Ativar;
    ACBrPosPrinter1.Buffer.Text := MemoImp.Lines.Text;
    ACBrPosPrinter1.Imprimir;
  end;
  {if (dmPdv.imp_vias = 3) then
  begin
    ACBrPosPrinter1.Imprimir;
    ACBrPosPrinter1.Imprimir;
    ACBrPosPrinter1.Imprimir;
  end;}

end;

procedure TfPDV_Rec.insereRecebimento(parc_rec: Integer; vlr_rec: Double;
  vlr_tot_rec: Double; via_rec: Integer; n_doc_rec: String; forma_rec: String;
  vlr_via_rec: Double);
var strG: String;
  status: String;
  vencimento: TDate;
  vlr : Double;
begin
  if (forma_rec = '1') then
    forma_rec := '1'
  else if (forma_rec = '2') then
    forma_rec := '7'
  else if (forma_rec = '3') then
    forma_rec := '6'
  else if (forma_rec = '5') then
    forma_rec := '2'
  else if (forma_rec = '9') then
    forma_rec := 'G' // Vale
  else
    forma_rec := '0';
  // TODO tratar prazo , parcelas
  if (parc_rec > 0) then // ja pago
  begin
    status := '5-';
    vlr := 0;
  end;
  if (parc_rec = 0) then // ja pago
  begin
    status := '7-';
    vlr := vlr_rec;
    parc_rec := 0;
  end;
  if (num_cx = 0) then
  begin
    dmPdv.busca_sql('SELECT NOTAFISCAL, SERIE FROM VENDA WHERE CODVENDA = ' +
     InttoStr(vCodVenda));
    if not dmPdv.sqBusca.IsEmpty then
    begin
      num_cx:=dmPdv.sqBusca.FieldByName('NOTAFISCAL').AsInteger;
      serie_cx:=dmPdv.sqBusca.FieldByName('SERIE').AsString;
    end;
  end;

  DecimalSeparator:='.';
  strG := IntToStr(dmPdv.busca_generator('COD_AREC')) + ', ';
  strG := strG + QuotedStr(IntToStr(num_cx)+'-'+serie_cx) + ', ';
  strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy', Now)) + ', ';
  strG := strG + IntToStr(vCliente) + ', ';
  strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy', IncMonth(Now,parc_rec))) + ', ';
  //strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy', (IncDay(Self.DtEmissao, StrToInt(Self.dataVenc.Strings[i-1]))))) + ', ';
  //strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy', Now)) + ', ';
  strG := strG + QuotedStr(status) + ', ';
  strG := strG + IntToStr(via_rec) + ', ';
  strG := strG + QuotedStr(forma_rec) + ', ';
  strG := strG + FloattoStr(vlr_via_rec) + ', '; // Valor_prim_via
  strG := strG + FloattoStr(vlr_rec) + ', '; // Valor_Resto
  strG := strG + FloattoStr(vlr_tot_rec) + ', ';  // Valortitulo
  strG := strG + FloattoStr(vlr) + ', ';    // valorRecebido
  strG := strG + IntToStr(parc_rec) + ', ';
  strG := strG + '0, ';  // Desconto
  if (status = '7-') then
  begin
    strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy', Now)) + ', ';  // DataBaixa
  end
  else begin
    strG := strG + ' Null, ';
  end;
  strG := strG + InttoStr(vCodVenda) + ', ';
  strG := strG + InttoStr(vCaixa_Local) + ', ';
  strG := strG + InttoStr(vVendedor) + ', ';
  strG := strG + InttoStr(vUsuario) + ', ';
  strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy hh:MM', Now)) + ', ';  // DataSistema

  strG := strG + '0, ';  // Juros
  strG := strG + '0, ';  // FUNRURAL
  strG := strG + '0, ';  // Perda
  strG := strG + '0, ';  // Troca
  strG := strG + QuotedStr(n_doc_rec) + ', '; // N.Doc.
  strG := strG + '0, ';  // Outro_Credito
  strG := strG + IntToStr(dmPdv.contaCaixa) + ', '; // Caixa
  strG := strG + IntToStr(1) + ', '; // Situacao
  strG := strG + IntToStr(1) + ', '; // CodOrigem
  strG := strG + '0)'; //
  DecimalSeparator:=',';
  strG := ' INSERT INTO RECEBIMENTO ' +
        ' (CODRECEBIMENTO, TITULO,          EMISSAO,         CODCLIENTE,      ' +
        ' DATAVENCIMENTO,  STATUS,          VIA,             FORMARECEBIMENTO,' +
        ' VALOR_PRIM_VIA,  VALOR_RESTO,     VALORTITULO,     ' +
        ' VALORRECEBIDO,   PARCELAS,        DESCONTO,        DATABAIXA,       ' +
        ' CODVENDA ,       CODALMOXARifADO, CODVENDEDOR,     CODUSUARIO,      ' +
        ' DATASISTEMA,             JUROS,           ' +
        ' FUNRURAL,        PERDA,           TROCA,           N_DOCUMENTO,     ' +
        ' OUTRO_CREDITO,   CAIXA,           SITUACAO,        CODORIGEM, CONTADEBITO   ' +
        ') VALUES(' + strG;
  dmPdv.executaSql(strG);
end;

procedure TfPDV_Rec.gerarjson;
var
  Campo : String;
  Valor : String;
  tipo : TFieldType;
  arquivo: TJsonNode;
  postJson: TJSONObject;
  itens: String;
  i: Integer;
  num: Integer;
  campos: String;
    responseData: String;
begin
  // novo 16/11/21
  postJson := TJSONObject.Create;
  postJson.Add('title', 'Enviando Movimento');

  arquivo := TJsonNode.Create;
  if ( not dmPdv.sqLancamentos.Active) then
    dmPdv.sqLancamentos.Open;
  dmPdv.sqLancamentos.First;
  while not dmPdv.sqLancamentos.Eof do
  begin
    for i:=0 to dmPdv.sqLancamentos.FieldDefs.Count-1 do
    begin
      try
      campo := dmPdv.sqLancamentos.FieldDefs.Items[i].Name;
      campos := 'CODMOVIMENTO DATA_SISTEMA CODCLIENTE CONTROLE CODUSUARIO';
      campos += ' CODVENDEDOR CODALMOXARIFADO';
      if (pos(campo, Campos) <> 0) then
      begin
        if (not dmPdv.sqLancamentos.Fields[i].IsNull) then
        begin
          valor := '';
          if (Trim(dmPdv.sqLancamentos.Fields[i].Value) <> '') then
          begin
            tipo := dmPdv.sqLancamentos.Fields[i].DataType;
            if dmPdv.sqLancamentos.Fields[i].DataType = ftDateTime then
               valor := FormatDateTime('mm/dd/yyyy hh:MM', dmPdv.sqLancamentos.Fields[i].Value);
            if dmPdv.sqLancamentos.Fields[i].DataType = ftString then
               valor := dmPdv.sqLancamentos.Fields[i].Value;
            if dmPdv.sqLancamentos.Fields[i].DataType = ftInteger then
               valor := IntToStr(dmPdv.sqLancamentos.Fields[i].Value);
            if dmPdv.sqLancamentos.Fields[i].DataType = ftSmallint then
               valor := IntToStr(dmPdv.sqLancamentos.Fields[i].Value);
            if dmPdv.sqLancamentos.Fields[i].DataType = ftFloat then
            begin
              try
                 valor := FloatToStr(dmPdv.sqLancamentos.Fields[i].Value);
              except
                valor := '';
              end;
            end;
            if (valor <> '') then
              arquivo.Add(dmPdv.sqLancamentos.Fields[i].FieldName,valor);
            valor := '';
          end;
        end;
      end;
      except
         ShowMessage('Erro Campo : ' + campo + ' Valor : ' + valor);
         valor := '0';
      end;
    end;
    dmPdv.sqLancamentos.Next;
  end;
  num := 0;
  //campo := dmpdv.path_integra + 'mov_' + IntToStr(dmpdv.sqLancamentosCODMOVIMENTO.AsInteger) +
  //   '_' + IntToStr(dmpdv.sqLancamentosCODALMOXARIFADO.AsInteger) + '.txt';
  //arquivo.SaveToFile(campo);
  //arquivo.Free;
  //arquivo := TJsonNode.Create;
  // ITENS
  itens := '';
  dmPdv.sqLancamentos.First;
  while not dmPdv.sqLancamentos.Eof do
  begin
    itens += '[{';
    num += 1;
    for i:=0 to dmPdv.sqLancamentos.FieldDefs.Count-1 do
    begin
      try
      campo := dmPdv.sqLancamentos.FieldDefs.Items[i].Name;
      campos := 'CODPRODUTO PRECO QUANTIDADE';
      campos += ' VALOR_DESCONTO DESCPRODUTO';
      if (pos(campo, Campos) <> 0) then
      begin
        valor := '';
        if (campo = 'VALOR_DESCONTO') then
        begin
          valor := FloatToStr(dmPdv.sqLancamentosVALOR_DESCONTO.Value);
        end;
        if (campo = 'CODPRODUTO') then
        begin
          valor := IntToStr(dmPdv.sqLancamentosCODPRODUTO.Value);
        end;
        if (campo = 'PRECO') then
        begin
          valor := FloatToStr(dmPdv.sqLancamentosPRECO.Value);
        end;
        if (campo = 'QUANTIDADE') then
        begin
          valor := FloatToStr(dmPdv.sqLancamentosQUANTIDADE.Value);
        end;
        if (campo = 'CODPRO') then
        begin
          valor := dmPdv.sqLancamentosCODPRO.Value;
        end;
        if (campo = 'DESCPRODUTO') then
        begin
          valor := dmPdv.sqLancamentosDESCPRODUTO.Value;
        end;
        {
        if (not dmPdv.sqLancamentos.Fields[i-1].IsNull) then
        begin
          valor := '';
          if (Trim(dmPdv.sqLancamentos.Fields[i-1].Value) <> '') then
          begin
            tipo := dmPdv.sqLancamentos.FieldDefs[i].DataType;
            if dmPdv.sqLancamentos.FieldDefs[i].DataType = ftDate then
               valor := FormatDateTime('mm/dd/yyyy', dmPdv.sqLancamentos.Fields[i-1].Value);
            if dmPdv.sqLancamentos.FieldDefs[i].DataType = ftString then
               valor := dmPdv.sqLancamentos.Fields[i-1].Value;
            if dmPdv.sqLancamentos.FieldDefs[i].DataType = ftInteger then
               valor := IntToStr(dmPdv.sqLancamentos.Fields[i-1].Value);
            if dmPdv.sqLancamentos.FieldDefs[i].DataType = ftFloat then
            begin
              try
                 valor := FloatToStr(dmPdv.sqLancamentos.Fields[i-1].Value);
              except
                valor := '';
              end;
            end;
          }
        if (valor <> '') then
        begin
          if itens <> '[{' then
            itens += ',';
          itens += '"' + campo + '": "' + valor + '"';
        end;
        valor := '';
        //end;
      end;
      except
         ShowMessage('Erro Campo : ' + campo + ' Valor : ' + valor);
         valor := '0';
      end;
    end;
    itens += ', "CODMOVIMENTO": "' + IntToStr(dmpdv.sqLancamentosCODMOVIMENTO.AsInteger) + '"';
    itens += '}]';
    //arquivo.add(itens, nkString);
    arquivo.add('item-'+IntTostr(num), itens);
    itens := '';
    dmPdv.sqLancamentos.Next;
  end;
  //campo := dmpdv.path_integra + 'det_' + IntToStr(dmpdv.sqLancamentosCODMOVIMENTO.AsInteger) +
  //   '_' + IntToStr(dmpdv.sqLancamentosCODALMOXARIFADO.AsInteger) + '.txt';
  //arquivo.SaveToFile(campo);
  //arquivo.Free;


  // PAGAMENTOS
  //arquivo := TJsonNode.Create;
  dmPdv.busca_sql('SELECT CODFORMA, COD_VENDA, ID_ENTRADA, FORMA_PGTO' +
    ' , CAIXA , N_DOC, VALOR_PAGO, CAIXINHA, TROCO, DESCONTO, STATE' +
    ' FROM FORMA_ENTRADA WHERE STATE < 2 AND ID_ENTRADA = ' +
    InttoStr(vCodMovimento) + ' ORDER BY FORMA_PGTO');
  itens := '';
  num := 0;
  while not dmPdv.sqBusca.EOF do
  begin
    itens += '[{';
    num += 1;
    for i:=0 to dmPdv.sqBusca.FieldDefs.Count-1 do
    begin
      try
      campo := dmPdv.sqBusca.FieldDefs.Items[i].Name;
      campos := 'FORMA_PGTO VALOR_PAGO CODCLIENTE DESCONTO ID_ENTRADA';
      if (pos(campo, Campos) <> 0) then
      begin
        if (not dmPdv.sqBusca.Fields[i].IsNull) then
        begin
          valor := '';
          if (Trim(dmPdv.sqBusca.Fields[i].Value) <> '') then
          begin
            tipo := dmPdv.sqBusca.Fields[i].DataType;
            if dmPdv.sqBusca.Fields[i].DataType = ftDate then
               valor := FormatDateTime('mm/dd/yyyy', dmPdv.sqBusca.Fields[i].Value);
            if dmPdv.sqBusca.Fields[i].DataType = ftString then
               valor := dmPdv.sqBusca.Fields[i].Value;
            if dmPdv.sqBusca.Fields[i].DataType = ftInteger then
               valor := IntToStr(dmPdv.sqBusca.Fields[i].Value);
            if dmPdv.sqBusca.Fields[i].DataType = ftSmallint then
               valor := IntToStr(dmPdv.sqBusca.Fields[i].Value);
            if dmPdv.sqBusca.Fields[i].DataType = ftFixedChar then
               valor := dmPdv.sqBusca.Fields[i].Value;

            if dmPdv.sqBusca.Fields[i].DataType = ftFloat then
            begin
              try
                 valor := FloatToStr(dmPdv.sqBusca.Fields[i].Value);
              except
                valor := '';
              end;
            end;
            if (valor <> '') then
            begin
              if itens <> '[{' then
                itens += ',';
              itens += '"' + campo + '": "' + valor + '"';
            end;
            valor := '';
          end;
        end;
      end;
      except
         ShowMessage('Erro Campo : ' + campo + ' Valor : ' + valor);
         valor := '0';
      end;
    end;
    itens += ', "CODMOVIMENTO": "' + IntToStr(dmpdv.sqLancamentosCODMOVIMENTO.AsInteger) + '"';
    itens += '}]';
    arquivo.add('pag-'+IntTostr(num), itens);
    itens := '';
    dmPdv.sqBusca.Next;
  end;
  //campo := dmpdv.path_integra + 'pag_' + IntToStr(dmpdv.sqLancamentosCODMOVIMENTO.AsInteger) +
  //   '_' + IntToStr(dmpdv.sqLancamentosCODALMOXARIFADO.AsInteger) + '.txt';
  //arquivo.SaveToFile(campo);

  // comentei pra gerar o arquivo acima, aqui adicionei pra enviar  o post 16/11/21
    postJson.Add('pedido', arquivo.ToString);
          With TFPHttpClient.Create(Nil) do
        begin
          try
            AddHeader('Content-Type', 'application/json');
            RequestBody := TStringStream.Create(postJson.AsJSON);
            responseData := Post(dmPdv.path_integra_url + '/pedidoinsere');
            if (responseData <> 'N') then
            begin
            end;
          finally
           Free;
          end;
        end;

  postJson.Free;
  arquivo.Free;

  // isso e executado na dmpv pelo timer
  //dmpdv.executa_integracao;
end;

function TfPDV_Rec.strParaFloat(vlr_st: String): Double;
var tam: Integer;
  vVlrStr: String;
  vVlr_decimais: String;
begin
  if (Length(vlr_st) > 6) then
  begin
    vVlr_decimais := Copy(vlr_st,pos(',',vlr_st)+1,Length(vlr_st));
    Vlr_st := Copy(vlr_st,0,pos(',',vlr_st)-1);
    if (Length(vlr_st) > 3) then
    begin
      vVlrStr := StringReplace(vlr_st, '.', '', [rfReplaceAll]);
      vlr_st := vVlrStr + ',' + vVlr_decimais;
    end
    else begin
      vlr_st := vlr_st + ',' + vVlr_decimais;
    end;
  end;
  result := StrToFloat(vlr_st);
end;

procedure TfPDV_Rec.edPagamentoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if lblForma.Caption = '4-Faturar' then
    begin
      edParcela.SetFocus;
      exit;
    end;
    if lblForma.Caption = '9-Devol./Troca' then
    begin
      if (imgTroca.Visible = False) then
      begin
        ShowMessage('Cupom nao informado.');
        exit;
      end;
    end;

    if ((edPagamento.Text <> '') and (vResto > 0.01))  then
    begin
      if lblForma.Caption = '4-Faturar' then
      begin
        if vCliente = dmPdv.clientePadrao then
        begin
          ShowMessage('Informe o Cliente');
          Exit;
        end;
      end;
      calcula_total('pagamento');
      registra_valores(strParaFloat(edPagamento.Text));
      carrega_valores;
    end;
    if lblForma.Caption = '9-Devol./Troca' then
    begin
      edCupom.Text:='';
      edCupom.Visible:=False;
      lblCupom.Visible:=False;
      imgTroca.Visible:=False;
      lblForma.Caption:='1-Dinheiro';
    end;
  end;
end;

procedure TfPDV_Rec.edPagoChange(Sender: TObject);
begin

end;

procedure TfPDV_Rec.edParcelaChange(Sender: TObject);
begin

end;

procedure TfPDV_Rec.edParcelaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if ((edPagamento.Text <> '') and (vResto > 0.01))  then
    begin
      if lblForma.Caption = '4-Faturar' then
      begin
        if vCliente = dmPdv.clientePadrao then
        begin
          ShowMessage('Informe o Cliente');
          Exit;
        end;
      end;
      registra_valores(strParaFloat(edPagamento.Text));
    end;
  end;
end;

procedure TfPDV_Rec.edRestanteChange(Sender: TObject);
begin

end;

procedure TfPDV_Rec.edTrocoChange(Sender: TObject);
begin

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

procedure TfPDV_Rec.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  edPagamento.Text := '0,00';
end;

procedure TfPDV_Rec.FormCreate(Sender: TObject);
var N: TACBrPosPrinterModelo;
begin
  vDesconto := 0;
  cbxModeloPosPrinter.Items.Clear ;
  For N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
     cbxModeloPosPrinter.Items.Add(GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(N) ));
  cbxModeloPosPrinter.ItemIndex := dmPdv.ModeloImp;
end;

procedure TfPDV_Rec.BitBtn9Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.btnDscClick(Sender: TObject);
var percent : Double;
begin
  percent := 0;
  if ((btnDsc.Caption = 'R$') and (chkPercent.Checked=False)) then
  begin
    vDesconto := strParaFloat(edVDesconto.Text);
    edDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  end
  else begin
    percent := StrParaFloat(edVDesconto.Text);
    percent := 1-(percent/100);
    vDesconto:= vValorVenda - (vValorVenda * percent);
    edDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  end;
  if ((dmPdv.descontoLivre > 0) and (vDesconto > 0)) then
  begin
    percent := vDesconto / vValorVenda;
    if (percent > dmPdv.descontoLivre) then
    begin
      // TODO aqui pedirá senha GERENTE
      fPermissao.Permissao_Fazer := 'DESCONTO';
      fPermissao.ShowModal;
      if (fPermissao.Permissao_Fazer = 'NAO') then
      begin
        edVDesconto.Text := '0,00';
        edDesconto.Text := '0,00';
        ShowMessage('Sem Permissao para este desconto.');
        Exit;
      end;
    end;
  end;
  grava_desconto;
  calcula_total('desconto');
  carrega_valores;
end;

procedure TfPDV_Rec.edCupomChange(Sender: TObject);
begin

end;

procedure TfPDV_Rec.edCupomKeyPress(Sender: TObject; var Key: char);
var
  cupom_ch: String;
begin
  if Key = #13 then
  begin
    Key := #0;
    if (edCupom.Text <> '') then
    begin
      // ver se o cupom existe
      cupom_ch := Copy(edCupom.Text,2,4);
      cupom_mv := Copy(edCupom.Text,6,7);
      dmPdv.busca_sql('SELECT CODCOMPRA, VALOR FROM COMPRA ' +
        ' WHERE CODMOVIMENTO = ' + cupom_mv +
        ' AND N_DOCUMENTO = ' + QuotedStr(cupom_ch) +
        ' AND STATUS = 0 AND N_BOLETO IS NULL');
      if (dmPdv.sqBusca.IsEmpty) then
      begin
        ShowMessage('Cupom ja baixado ou invalido.');
        edCupom.Text := '';
        exit;
      end;
      cod_compra := StrToInt(cupom_mv);//dmPdv.sqBusca.FieldByName('CODCOMPRA').AsInteger;
      // se existir lancar ele como credito

      edPagamento.Text := FormatFloat('#,,,0.00', dmPdv.sqBusca.FieldByName('VALOR').AsFloat);
      //registra_valores(strParaFloat(edPagamento.Text));
      imgTroca.Visible:=True;
      edPagamento.SetFocus;
    end;
  end;

end;

procedure TfPDV_Rec.BitBtn18Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn19Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn1Click(Sender: TObject);
begin
  lblForma.Caption:='7-Sianet';
  pnCartoes.Visible:=False;
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.BitBtn17Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.acDescontoValorExecute(Sender: TObject);
begin
  //vDesconto := StrToFloat(edVDesconto.Text);
  //edDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  //grava_desconto;
  //calcula_total;
end;

procedure TfPDV_Rec.acDescPercentualExecute(Sender: TObject);
begin
  btnDsc.Caption:='%';
end;

procedure TfPDV_Rec.acDinheiroExecute(Sender: TObject);
begin
  lblForma.Caption:='1-Dinheiro';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acExcluirLancamentoExecute(Sender: TObject);
begin
  if ((vStatus = 1) and (dmpdv.permiteCancelarBaixao = 0)) then
  begin
    ShowMessage('Não pode excluir pedido já finalizado.');
    exit;
  end;
  if MessageDlg('Confirma:', 'Confirma a exclusão do lançamento: ' +
    sqPagamentoN_DOC.AsString , mtConfirmation,
    [mbYes, mbNo, mbIgnore],0) = mrYes then
  begin
    if sqPagamento.Active then
    begin
      //sqPagamento.Edit;
      //sqPagamentoSTATE.AsInteger := 2;
      dmPdv.IbCon.ExecuteDirect('UPDATE FORMA_ENTRADA SET STATE = 2 ' +
        ' WHERE CODFORMA = ' + IntToStr(sqPagamentoCODFORMA.AsInteger));
      //sqPagamento.ApplyUpdates;
      dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTODETALHE SET BAIXA = NULL ' +
        ' WHERE CODMOVIMENTO  = ' + IntToStr(vCodMovimento));
      sqPagamento.Active:=False;
      dmPdv.sTrans.Commit;
      sqPagamento.Active:=True;
      //calcula_total('inicio');
      carrega_valores;
    end;
  end;
end;

procedure TfPDV_Rec.acFecharExecute(Sender: TObject);
var ult_pedido: String;
begin
  if (vResto > 0.009) then
  begin
    ShowMessage('Informe o Pagamento.');
    Exit;
  end;
  if vStatus = 0 then
  begin
    encerra_venda();
  end;
  if (dmPdv.CupomImp = 'Texto') then
  begin
    imprimirTxt();
    if (dmPdv.imp_vias = 2) then
    begin
      Sleep(300);
      imprimirTxt();
    end;
  end
  else begin
    imprimirTxt();
    if (dmPdv.CupomImp <> 'BD') then
      imprimiAcbr();
  end;
  if (btnCadeira.Visible = True) then
  begin
    btnCadeira.Enabled := True;
  end
  else begin
    //Close;
  end;
    // Executa atualizacao estoque
  // sendo chamado pelo dmpdv
  //dmpdv.codMovimentoEst := vCodMovimento;
  //EstoqueExe := TEstoqueThread.Create(True);
  //EstoqueExe.FreeOnTerminate := True;
  //EstoqueExe.Resume;
  // 26/11/21 Carlos
  //if (dmpdv.empresa_integra <> 'ATS') then
  //  gerarjson;

  {if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    try
      ult_pedido := fIntegracaoOdoo.consultaUltimoPedido();
      fIntegracaoOdoo.cria_json(' NOT IN ' + ult_pedido);
    except
    end;
  end;}
  Close;
  // sendo chamado pelo dmpdv
  //IntegracaoOdoo := TIntegracaoOdoo.Create(True);
  //IntegracaoOdoo.FreeOnTerminate := True;
  //IntegracaoOdoo.Resume;
end;

procedure TfPDV_Rec.acNfceExecute(Sender: TObject);
var
  NFP: Double;
  NFD: Double;
  NFR: Double;
begin
  if (vResto > 0.009) then
  begin
    ShowMessage('Informe o Pagamento.');
    Exit;
  end;
  if (not sqPagamento.Active) then
     sqPagamento.Open;
  NFP := 0;
  NFD := 0;
  NFR := 0;
  sqPagamento.First;
  while not sqPagamento.Eof do
  begin
    NFR += sqPagamentoVALOR_PAGO.AsFloat;
    NFD += sqPagamentoDESCONTO.AsFloat;
    sqPagamento.Next;
  end;
  NFP := NFR + NFD;


  if vStatus = 0 then
  begin
    encerra_venda();
  end;
  fNfce.nfce_valor    := RoundTo(NFP, -2);
  fNfce.nfce_desconto := RoundTo(NFD, -2);
  fNfce.nfce_codVenda := vCodVenda;
  dmPdv.sqLancamentos.Close;
  dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := vCodMovimento;
  dmPdv.sqLancamentos.Open;
  fNfce.ShowModal;
  if (btnCadeira.Visible = True) then
  begin
    btnCadeira.Enabled := True;
  end
  else begin
    Close;
  end;
  //26/11/21 Carlos
  //if (dmpdv.empresa_integra <> 'ATS') then
  //  gerarjson;
  if (dmpdv.outro_cupom = 'S') then
  begin
    imprimirTxtOutro();
    if (dmPdv.CupomImp <> 'Texto') then
      imprimiAcbr();
  end;
  if (dmpdv.outro_cupom = 'P') then
  begin
    BitBtn24.Click;
  end;
end;

procedure TfPDV_Rec.acOutrosExecute(Sender: TObject);
begin
  lblForma.Caption:='6-Outros';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acPrazoExecute(Sender: TObject);
begin
  lblForma.Caption:='4-Faturar';
  lblParcela.Visible:=True;
  edParcela.Visible:=True;
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.actionPixExecute(Sender: TObject);
begin
  // PIX
  lblForma.Caption:='6-Pix';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acVoltarVendaExecute(Sender: TObject);
begin
  Close;
end;

procedure TfPDV_Rec.BitBtn12Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.acDescontoPercentualExecute(Sender: TObject);
var percent: Double;
begin
  {
  btnDsc.Caption:='%';
  percent := StrToFloat(edVDesconto.Text);
  percent := 1-(percent/100);
  vDesconto:= vValorTotal * percent;;
  edDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  grava_desconto;
  calcula_total;}
  if (edVDesconto.Text <> '') then
    btnDsc.Click;
end;

procedure TfPDV_Rec.acCartaoDebitoExecute(Sender: TObject);
begin
  lblForma.Caption:='2-Cartao Debito';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acChequeExecute(Sender: TObject);
begin
  lblForma.Caption:='5-Cheque';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acCartaoCreditoExecute(Sender: TObject);
begin
  if (OutrosCartoes = 'S') then
  begin
    pnCartoes.Visible:=True;
    BitBtn1.SetFocus;
  end
  else begin
    lblForma.Caption:='3-Cartao Credito';
    edPagamento.SetFocus;
  end;
end;

procedure TfPDV_Rec.acCancelaFechamentoExecute(Sender: TObject);
begin
  if (dmpdv.permiteCancelarBaixao = 0) then
  begin
    ShowMessage('Não pode excluir pedido já finalizado.');
    exit;
  end;
  sqPagamento.First;
  While not sqPagamento.EOF do
  begin
    if sqPagamentoSTATE.AsInteger < 2 then
    begin
      ShowMessage('Cancele pagamentos ativos, primeiro');
      Exit;
    end;
    sqPagamento.Next;
  end;
  if (edValorPago.Text = '0,00') then
  begin
    dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 0 ' +
      ' WHERE CODMOVIMENTO  = ' + IntToStr(vCodMovimento));
    dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTODETALHE SET BAIXA = NULL ' +
      ' WHERE CODMOVIMENTO  = ' + IntToStr(vCodMovimento));
    dmPdv.sTrans.Commit;
    vStatus := 0;
  end;
end;

procedure TfPDV_Rec.BitBtn20Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn21Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn22Click(Sender: TObject);
begin
  if (vStatus = 1) then
  begin
    ShowMessage('Venda já finalizada');
    Exit;
  end;
  fClienteBusca.ShowModal;
  edCliente.Text := fClienteBusca.cNomeCliente;
  vClienteNome   := fClienteBusca.cNomeCliente;
  vCliente       := fClienteBusca.cCodCliente;
  edPagamento.SetFocus;
end;



procedure TfPDV_Rec.BitBtn26Click(Sender: TObject);
begin
end;

procedure TfPDV_Rec.BitBtn2Click(Sender: TObject);
begin
  lblForma.Caption:='8-Brasil Card';
  pnCartoes.Visible:=False;
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.BitBtn3Click(Sender: TObject);
begin
  lblForma.Caption:='0-Cartao Servipa';
  pnCartoes.Visible:=False;
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.BitBtn4Click(Sender: TObject);
begin
  lblForma.Caption:='3-Cartao Credito';
  pnCartoes.Visible:=False;
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.BitBtn5Click(Sender: TObject);
begin
  pnCartoes.Visible:=False;
end;

procedure TfPDV_Rec.btnCadeiraClick(Sender: TObject);
begin
  // tenho q levar para o fCadeira o código do Curso
  // vou pegar ele do produto
  // se tiver mais de um curso ???
  fCadeira.ShowModal;
  fCadeira.listaCurso.Free;
  btnCadeira.Visible:=False;
end;

procedure TfPDV_Rec.btnCupomClick(Sender: TObject);
begin
  edCupom.Visible:=true;
  lblCupom.Visible:=true;
  lblForma.Caption := '9-Devol./Troca';
  edCupom.SetFocus;
end;


procedure TfPDV_Rec.btnDescontoPercentClick(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn24Click(Sender: TObject);
begin
  Close;
end;

end.

