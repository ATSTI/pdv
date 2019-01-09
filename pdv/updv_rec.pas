unit updv_rec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, DBGrids, MaskEdit, ActnList, Menus, udmpdv, uvenda,
  uRecebimento, uClienteBusca, uNfce, sqldb, db, math;

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
    acDinheiro: TAction;
    acExcluirLancamento: TAction;
    acCancelaFechamento: TAction;
    acNfce: TAction;
    acVoltarVenda: TAction;
    ActionListFechamento: TActionList;
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
    BitBtn22: TBitBtn;
    BitBtn27: TBitBtn;
    btnDescontoPercent: TBitBtn;
    btnDescontoValor: TBitBtn;
    BitBtn24: TBitBtn;
    BitBtn25: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    btnDsc: TBitBtn;
    chkPercent: TCheckBox;
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
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
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
    procedure acVoltarVendaExecute(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn26Click(Sender: TObject);
    procedure btnDescontoPercentClick(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure btnDscClick(Sender: TObject);
    procedure edPagamentoKeyPress(Sender: TObject; var Key: char);
    procedure edVDescontoKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
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
    procedure calcula_total;
    procedure grava_desconto;
    procedure registra_valores(v_vlr: Double);
    procedure encerra_venda();
    procedure imprimir();
    procedure imprimirTxt();
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
    vDesconto : Double;
    function strParaFloat(vlr_st: String): Double;
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

  //vValor := FormatFloat('#,,,0.00',vValor);
  vValorVenda := StrParaFloat(vValor);
  vResto := vValorVenda;
  num_doc := 0;
  vValorTotal := 0;
  edvDesconto.Text := FormatFloat('#,,,0.00',vDesconto);
  vDesconto:=0;
  lblForma.Caption:='1-Dinheiro';
  vCodVenda := 0;
  edCliente.Text := vClienteNome;
  edVendedor.Text := vVendedorNome;
  edValorTotal.Text:= FormatFloat('#,,,0.00',vValorVenda);
  edValorVendaTotal.Text := vValor;
  calcula_total;
  edVDesconto.SetFocus;
  edPagamento.SetFocus;
end;

function TfPDV_Rec.RemoveAcento(Str: string): string;
  const
  ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
   x: Integer;
begin;
  for x := 1 to Length(Str) do
  if Pos(Str[x],ComAcento) <> 0 then
    Str[x] := SemAcento[Pos(Str[x], ComAcento)];
  Result := Str;
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
  if ((vStatus = 1) and (vResto < 0.009)) then
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
  codForma: Integer;
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
    dmPdv.sqUpdate.Post;
    dmPdv.sqUpdate.ApplyUpdates;
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
      fVnd.Serie       := serie_cx;
      vCodVenda := fVnd.inserirVenda(0);
      dmPdv.sTrans.Commit;
    finally
      fVnd.Free;
    end;
  end;
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
  sqPagamentoCAIXA.AsInteger     := num_doc;
  sqPagamentoCOD_VENDA.AsInteger := vCodVenda;
  sqPagamentoFORMA_PGTO.AsString := Copy(lblForma.Caption,1,1);
  sqPagamentoID_ENTRADA.AsInteger:= vCodMovimento;
  sqPagamentoN_DOC.AsString      := lblForma.Caption;
  sqPagamentoSTATE.AsInteger     := 0;


  vValorPago := StrParaFloat(edPagamento.Text);
  if vValorPago > vResto then
  begin
    edTroco.Text := FloatToStr(vValorPago - vResto);
    vValorPago := vResto;
  end;
  sqPagamentoVALOR_PAGO.AsFloat  := vValorPago;

  sqPagamentoDESCONTO.AsFloat    := vDesconto;
  sqPagamentoTROCO.AsFloat       := StrParaFloat(edTroco.Text);
  sqPagamento.ApplyUpdates;
  dmPdv.sTrans.Commit;
  vDesconto := 0;
  edDesconto.Text:='0,00';
  num_doc := num_doc + 1;
  edPagamento.Text := '0,00';
  calcula_total;
end;

procedure TfPDV_Rec.encerra_venda();
var vRec : TRecebimento;
   vlr_entrada: Double;
   str_up: String;
begin
  vlr_entrada := 0;
  dmPdv.IbCon.ExecuteDirect('UPDATE FORMA_ENTRADA SET STATE = 1 ' +
    ' WHERE STATE = 0 AND ID_ENTRADA = ' +
    IntToStr(vCodMovimento));
  dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 1 ' +
    ' , CODCLIENTE = ' + IntToStr(vCliente) +
    ' WHERE CODMOVIMENTO  = ' +
    IntToStr(vCodMovimento));

  vStatus := 1;

  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT CODFORMA, COD_VENDA, ID_ENTRADA, FORMA_PGTO' +
    ' , CAIXA , N_DOC, VALOR_PAGO, CAIXINHA, TROCO, DESCONTO, STATE' +
    ' FROM FORMA_ENTRADA WHERE STATE < 2 AND ID_ENTRADA = ' +
    InttoStr(vCodMovimento);
  dmPdv.sqBusca.Open;

  while not dmPdv.sqBusca.EOF do
  begin
    if (dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString <> '4') then
    begin
      vlr_entrada += dmPdv.sqBusca.FieldByName('VALOR_PAGO').AsFloat;
    end;
    dmPdv.sqBusca.Next;
  end;
  if (vlr_entrada > 0) then
  begin
    DecimalSeparator:='.';
    str_up := 'UPDATE VENDA SET ENTRADA = ' +
      FloatToStr(vlr_entrada) +
      ' WHERE CODVENDA  = ' +
      IntToStr(vCodVenda);
    DecimalSeparator:=',';
    dmPdv.IbCon.ExecuteDirect(str_up);
  end;
  dmPdv.sTrans.Commit;

  vRec := TRecebimento.Create();
  try
    vRec.geraTitulo(0,vCodVenda);
  finally
    vRec.Free;
  end;
  {try
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
  Texto1 := '  ' + FormatDateTime('dd/mm/yyyy', Now) + '  Pedido :  ' +
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
      produto_cupomf := trim(dmPdv.sqLancamentosDESCPRODUTO.Value);
      texto6 := texto6 + '  ' + Copy(produto_cupomf, 0, 36);       //descrição do produto
      Writeln(Impressora, RemoveAcento(texto6));
      if (length(produto_cupomf)>36) then
      begin
        texto6 := '    ' + Copy(produto_cupomf, 37, 72);       //descrição do produto
        Writeln(Impressora, RemoveAcento(texto6));
      end;

      Writeln(Impressora, RemoveAcento(texto3));//NOME DO PRODUTO
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
  totalR: Double;
begin
  if (not sqPagamento.Active) then
     sqPagamento.Open;
  prazo := 'N';
  totalP := 0;
  totalD := 0;
  totalR := 0;
  sqPagamento.First;
  while not sqPagamento.Eof do
  begin
    totalR += sqPagamentoVALOR_PAGO.AsFloat;
    totalD += sqPagamentoDESCONTO.AsFloat;
    if sqPagamentoFORMA_PGTO.AsString = '4' then
      prazo := 'S';
    sqPagamento.Next;
  end;
  totalP := totalR + totalD;
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
  clientecupom := '  ' + IntToStr(vCliente) + '-' + RemoveAcento(vClienteNome);
  dmPdv.sqLancamentos.Close;
  dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := vCodMovimento;
  dmPdv.sqLancamentos.Open;
  // leio um arquivo txt e imprimo
  lFile := TStringList.Create;
  AssignFile(IMPRESSORA, dmPdv.portaIMP);
  try
    Rewrite(IMPRESSORA);
    lFile.LoadFromFile('cupom.txt');
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
        Writeln(Impressora, '  ' + FormatDateTime('dd/mm/yyyy', Now) + '  Pedido :  ' + IntToStr(vCodMovimento))
      else if lFile[i] = 'itens' then
      begin
        while not dmPdv.sqLancamentos.Eof do
        begin
          dmPdv.sqLancamentos.RecordCount;
          texto3 := '';
          texto6 := '  ';
          texto3 := texto3 + Format('            %-2s',[dmPdv.sqLancamentosUNIDADEMEDIDA.Value]);
          texto3 := texto3 + Format('    %6.2n',[dmPdv.sqLancamentosQUANTIDADE.AsFloat]);
          texto3 := texto3 + Format(' %6.2n',[dmPdv.sqLancamentosPRECO.AsFloat]);
          texto3 := texto3 + Format('   %6.2n',[dmPdv.sqLancamentosVALTOTAL.value]);
          produto_cupomf := trim(dmPdv.sqLancamentosDESCPRODUTO.Value);
          texto6 := texto6 + '  ' + Copy(produto_cupomf, 0, 36);       //descrição do produto
          Writeln(Impressora, RemoveAcento(texto6));
          if (length(produto_cupomf)>36) then
          begin
            texto6 := '    ' + Copy(produto_cupomf, 37, 72);       //descrição do produto
            Writeln(Impressora, RemoveAcento(texto6));
          end;
          Writeln(Impressora, RemoveAcento(texto3));//NOME DO PRODUTO
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
           ' - Devolvido : ' + FormatFloat('#,,,0.00',sqPagamentoTROCO.AsFloat));
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
        else if lFile[i] = 'cliente' then
          Writeln(Impressora, clientecupom)
        else if lFile[i] = 'doc' then
          Writeln(Impressora, '  ' + FormatDateTime('dd/mm/yyyy', Now) + '  Pedido :  ' + IntToStr(vCodMovimento))
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
            produto_cupomf := trim(dmPdv.sqLancamentosDESCPRODUTO.Value);
            texto6 := texto6 + '  ' + Copy(produto_cupomf, 0, 36);       //descrição do produto
            Writeln(Impressora, RemoveAcento(texto6));
            if (length(produto_cupomf)>36) then
            begin
              texto6 := '    ' + Copy(produto_cupomf, 37, 72);       //descrição do produto
              Writeln(Impressora, RemoveAcento(texto6));
            end;
            Writeln(Impressora, RemoveAcento(texto3));//NOME DO PRODUTO
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
    end;
  finally
    CloseFile(IMPRESSORA);
    lFile.Free;
  end;
end;

function TfPDV_Rec.strParaFloat(vlr_st: String): Double;
var tam: Integer;
  vVlrStr: String;
begin
  if (Length(vlr_st) > 6) then
  begin
    tam := Length(vlr_st)-7;
    vVlrStr := copy(vlr_st,0,tam);
    tam := Length(vVlrStr)+2;
    vlr_st := vVlrStr + copy(vlr_st,tam,6);
  end;
  result := StrToFloat(vlr_st);
end;

procedure TfPDV_Rec.edPagamentoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if ((edPagamento.Text <> '') and (vResto > 0.01))  then
    begin
      if lblForma.Caption = '4-Faturar' then
      begin
        if vCliente = 1 then
        begin
          ShowMessage('Informe o Cliente');
          BitBtn12.Click;
          Exit;
        end;
      end;
      registra_valores(strParaFloat(edPagamento.Text));
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

procedure TfPDV_Rec.FormCreate(Sender: TObject);
begin
  vDesconto := 0;
end;

procedure TfPDV_Rec.BitBtn9Click(Sender: TObject);
begin

end;

procedure TfPDV_Rec.btnDscClick(Sender: TObject);
var percent : Double;
begin
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
      sqPagamento.Active:=False;
      dmPdv.sTrans.Commit;
      sqPagamento.Active:=True;
      calcula_total;
    end;
  end;
end;

procedure TfPDV_Rec.acFecharExecute(Sender: TObject);
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
  imprimirTxt();
  Close;
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
  close;

end;

procedure TfPDV_Rec.acOutrosExecute(Sender: TObject);
begin
  lblForma.Caption:='6-Outros';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acPrazoExecute(Sender: TObject);
begin
  lblForma.Caption:='4-Faturar';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acVoltarVendaExecute(Sender: TObject);
begin
  Close;
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
  lblForma.Caption:='2-Cartão Débito';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acChequeExecute(Sender: TObject);
begin
  lblForma.Caption:='5-Cheque';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acCartaoCreditoExecute(Sender: TObject);
begin
  lblForma.Caption:='3-Cartão Crédito';
  edPagamento.SetFocus;
end;

procedure TfPDV_Rec.acCancelaFechamentoExecute(Sender: TObject);
begin
  sqPagamento.First;
  While not sqPagamento.EOF do
  begin
    if sqPagamentoSTATE.AsInteger < 2 then
    begin
      ShowMessage('Cancele pagamentos ativos, primeiro (F12)');
      Exit;
    end;
    sqPagamento.Next;
  end;
  if (edValorPago.Text = '0,00') then
  begin
    dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 0 ' +
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
  fClienteBusca.ShowModal;
  edCliente.Text := fClienteBusca.cNomeCliente;
  vClienteNome   := fClienteBusca.cNomeCliente;
  vCliente       := fClienteBusca.cCodCliente;
  edPagamento.SetFocus;
end;



procedure TfPDV_Rec.BitBtn26Click(Sender: TObject);
begin
end;


procedure TfPDV_Rec.btnDescontoPercentClick(Sender: TObject);
begin

end;

procedure TfPDV_Rec.BitBtn24Click(Sender: TObject);
begin
  Close;
end;

end.

