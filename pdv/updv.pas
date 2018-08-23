unit uPdv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, SynEdit, RTTICtrls, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, MaskEdit, DBGrids, ActnList,
  Menus, dateutils, uMovimento, uVendedorBusca, uClienteBusca, base64;

type

  { TfPdv }

  TfPdv = class(TForm)
    acReceber: TAction;
    acFechar: TAction;
    acProcurar: TAction;
    acNova: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    BitBtn9: TBitBtn;
    btnInfo: TBitBtn;
    btnVnd2: TBitBtn;
    btnVnd3: TBitBtn;
    btnVnd4: TBitBtn;
    btnVnd5: TBitBtn;
    btnVnd6: TBitBtn;
    btnVnd7: TBitBtn;
    btnVnd8: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    btnVnd1: TBitBtn;
    btnNovo: TBitBtn;
    btnVendas: TBitBtn;
    btnReceber: TBitBtn;
    dsLanc: TDataSource;
    DBGrid1: TDBGrid;
    edCliente: TEdit;
    edVendedorNome: TEdit;
    edVendedor: TEdit;
    edCaixa: TEdit;
    edProdutoDesc: TEdit;
    edProduto: TEdit;
    edDesconto: TEdit;
    edTotalGeral: TMaskEdit;
    edClienteNome: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label10: TLabel;
    lblPedido: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblSenha: TLabel;
    lblNumItem: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edPreco: TMaskEdit;
    edTotal: TMaskEdit;
    MenuItem1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    pnInfo: TPanel;
    PopupMenu1: TPopupMenu;
    TIButton2: TTIButton;
    edQtde: TTIFloatSpinEdit;
    procedure acFecharExecute(Sender: TObject);
    procedure acNovaExecute(Sender: TObject);
    procedure acProcurarExecute(Sender: TObject);
    procedure acReceberExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnReceberClick(Sender: TObject);
    procedure btnVendasClick(Sender: TObject);
    procedure btnVnd1Click(Sender: TObject);
    procedure btnVnd2Click(Sender: TObject);
    procedure btnVnd3Click(Sender: TObject);
    procedure btnVnd4Click(Sender: TObject);
    procedure btnVnd5Click(Sender: TObject);
    procedure btnVnd6Click(Sender: TObject);
    procedure btnVnd7Click(Sender: TObject);
    procedure btnVnd8Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure edClienteChange(Sender: TObject);
    procedure edClienteKeyPress(Sender: TObject; var Key: char);
    procedure edPrecoChange(Sender: TObject);
    procedure edProdutoKeyPress(Sender: TObject; var Key: char);
    procedure edQtdeChange(Sender: TObject);
    procedure edVendedorKeyPress(Sender: TObject; var Key: char);
    procedure FlowPanel1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure btnVendaClick(Sender: TObject);
    procedure TIGroupBox1Click(Sender: TObject);
  private
    codproduto: Integer;
    codPro: String;
    proDesc: String;
    num_pedido: String;
    preco: Double;
    estoque: Double;
    caixa_local: Integer; // Sessao Caixa
    codCliente: Integer;
    codCaixa: Integer; // cod Usuario
    codVendedor: Integer;
    codMov: Integer;
    codDet: Integer;
    qtde_ped: Integer;
    procedure abrePedido(apCodMov: Integer);
    procedure iniciarVenda();
    procedure registrar_item();
    procedure alterar_item();
    procedure finalizarVenda();
    procedure calculaTotal();
    procedure calculaTotalGeral();
    procedure controlaPedidos(cpCodMov: Integer; cpStatus: Integer; cpTipo: Integer);
    procedure buscaPedidosAbertoCaixa(bpCodMov: Integer);
  public

  end;

var
  fPdv: TfPdv;
  FMov: TMovimento;

implementation

uses updv_rec,udmpdv, uMovimentoProc, uProdutoProc, uExecutaIntegracao;

{$R *.lfm}

{ TfPdv }

procedure TfPdv.Panel2Click(Sender: TObject);
begin

end;

procedure TfPdv.edClienteChange(Sender: TObject);
begin

end;

procedure TfPdv.edClienteKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if (edCliente.Text <> '') then
    begin
      fClienteBusca.cCodCliente := StrToInt(edCliente.Text);
      fClienteBusca.BuscaCliente;
      if fClienteBusca.cNomeCliente = '' then
      begin
        ShowMessage('Cliente não Encontrado');
        Exit;
      end;
      edClienteNome.Text := fClienteBusca.cNomeCliente;
      codCliente := fClienteBusca.cCodCliente;
    end;
  end;
end;

procedure TfPdv.edPrecoChange(Sender: TObject);
begin
  calculaTotal();
end;

procedure TfPdv.DBGrid1CellClick(Column: TColumn);
begin
  if (dmPdv.sqLancamentos.Active) then
  begin
    codDet := dmPdv.sqLancamentosCODDETALHE.AsInteger;
    edProduto.Text := dmPdv.sqLancamentosCODPRO.AsString;
    edQtde.Text    := FloatToStr(dmPdv.sqLancamentosQUANTIDADE.AsFloat);
    edPreco.Text   := FloatToStr(dmPdv.sqLancamentosPRECO.AsFloat);
    edDesconto.Text:= FloatToStr(dmPdv.sqLancamentosDESCONTO.AsFloat);
    edProdutoDesc.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
  end;
end;

procedure TfPdv.btnReceberClick(Sender: TObject);
begin

end;

procedure TfPdv.BitBtn7Click(Sender: TObject);
begin
  if ((edProduto.Text = '') and (codDet = 0)) then
  begin
    ShowMessage('Produto não informado.');
    edProduto.SetFocus;
    Exit;
  end;
  if (codProduto = 0) then
  begin
    // buscar produto

  end;
  alterar_item();
end;

procedure TfPdv.BitBtn1Click(Sender: TObject);
begin
  fProdutoProc.ShowModal;
end;

procedure TfPdv.BitBtn2Click(Sender: TObject);
begin
  if (edCliente.Text <> '') then
    fClienteBusca.cCodCliente:=StrToInt(edCliente.Text);
  fClienteBusca.ShowModal;
  edClienteNome.Text := fClienteBusca.cNomeCliente;
  codCliente := fClienteBusca.cCodCliente;
  edCliente.Text := IntToStr(codCliente);
end;

procedure TfPdv.BitBtn3Click(Sender: TObject);
begin
  if (edVendedor.Text <> '') then
    fVendedorBusca.uCodVendedor:=StrToInt(edVendedor.Text);
  fVendedorBusca.ShowModal;
  edVendedorNome.Text := fVendedorBusca.uNomeVendedor;
  codVendedor := fVendedorBusca.uCodVendedor;
  edVendedor.Text := IntToStr(codVendedor);
end;

procedure TfPdv.acReceberExecute(Sender: TObject);
begin
  fPDV_Rec.vValor  := edTotalGeral.Text;
  fPDV_Rec.vUsuario:= codCaixa;
  fPDV_Rec.vVendedor:= codVendedor;
  fPDV_Rec.vCliente := codCliente;
  fPDV_Rec.vClienteNome := edCliente.Text;
  fPDV_Rec.vVendedorNome:= edVendedor.Text;
  fPDV_Rec.vCaixa_Local := caixa_local;
  fPDV_Rec.vCodMovimento:= codMov;
  fPDV_Rec.ShowModal;
  if fPDV_Rec.vStatus = 1 then
  begin
    //controlaPedidos(codMov, 1, 1);
    buscaPedidosAbertoCaixa(codMov);
    btnNovo.Click;
  end;
end;

procedure TfPdv.acFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfPdv.acNovaExecute(Sender: TObject);
begin
  if qtde_ped = 8 then
  begin
    ShowMessage('Já existe 8 pedidos abertos, nao pode abrir mais.');
    Exit;
  end;
  iniciarVenda();
  buscaPedidosAbertoCaixa(codMov);
  //controlaPedidos(codMov, 0, 0);
  lblPedido.Caption:=IntToStr(codMov);
  edProduto.Text:='';
  edProduto.SetFocus;
end;

procedure TfPdv.acProcurarExecute(Sender: TObject);
begin
  fMovimentoProc.ShowModal;
  if (fMovimentoProc.codMovimentoProc > 0) then
  begin
    codMov:=fMovimentoProc.codMovimentoProc;
    lblPedido.Caption:=IntToStr(codMov);
    dmPdv.sqLancamentos.Close;
    dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger:=codMov;
    dmPdv.sqLancamentos.Open;
    codDet:=dmPdv.sqLancamentosCODDETALHE.AsInteger;
    edProduto.Text := dmPdv.sqLancamentosCODPRO.AsString;
    edProdutoDesc.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
    edQtde.Text    := FloatToStr(dmPdv.sqLancamentosQUANTIDADE.AsFloat);
    edPreco.Text   := FloatToStr(dmPdv.sqLancamentosPRECO.AsFloat);
    edDesconto.Text:= FloatToStr(dmPdv.sqLancamentosDESCONTO.AsFloat);
    edProdutoDesc.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
    //controlaPedidos(codMov, 0, 0);
    buscaPedidosAbertoCaixa(codMov);
    calculaTotalGeral();
  end;
end;

procedure TfPdv.BitBtn8Click(Sender: TObject);
begin
  Close;
end;

procedure TfPdv.BitBtn9Click(Sender: TObject);
begin
  pnInfo.Visible:=False;
end;

procedure TfPdv.btnInfoClick(Sender: TObject);
begin
  pnInfo.Visible:=True;
  fExecutaIntegracao.ShowModal;
end;

procedure TfPdv.btnNovoClick(Sender: TObject);
begin

end;

procedure TfPdv.btnVendasClick(Sender: TObject);
begin
end;

procedure TfPdv.btnVnd1Click(Sender: TObject);
begin
  if (btnVnd1.Caption <> '') then
  begin
    abrePedido(StrToInt(btnVnd1.Caption));
    btnVnd1.Font.Color := clRed;
    btnVnd8.Font.Color := clBlack;
    btnVnd2.Font.Color := clBlack;
    btnVnd3.Font.Color := clBlack;
    btnVnd4.Font.Color := clBlack;
    btnVnd5.Font.Color := clBlack;
    btnVnd6.Font.Color := clBlack;
    btnVnd7.Font.Color := clBlack;
  end;
end;

procedure TfPdv.btnVnd2Click(Sender: TObject);
begin
  if (btnVnd2.Caption <> '') then
  begin
    abrePedido(StrToInt(btnVnd2.Caption));
    btnVnd2.Font.Color := clRed;
    btnVnd8.Font.Color := clBlack;
    btnVnd1.Font.Color := clBlack;
    btnVnd3.Font.Color := clBlack;
    btnVnd4.Font.Color := clBlack;
    btnVnd5.Font.Color := clBlack;
    btnVnd6.Font.Color := clBlack;
    btnVnd7.Font.Color := clBlack;
  end;
end;

procedure TfPdv.btnVnd3Click(Sender: TObject);
begin
  if (btnVnd3.Caption <> '') then
  begin
    abrePedido(StrToInt(btnVnd3.Caption));
    btnVnd3.Font.Color := clRed;
    btnVnd8.Font.Color := clBlack;
    btnVnd2.Font.Color := clBlack;
    btnVnd1.Font.Color := clBlack;
    btnVnd4.Font.Color := clBlack;
    btnVnd5.Font.Color := clBlack;
    btnVnd6.Font.Color := clBlack;
    btnVnd7.Font.Color := clBlack;
  end;
end;

procedure TfPdv.btnVnd4Click(Sender: TObject);
begin
  if (btnVnd4.Caption <> '') then
  begin
    abrePedido(StrToInt(btnVnd4.Caption));
    btnVnd4.Font.Color := clRed;
    btnVnd8.Font.Color := clBlack;
    btnVnd2.Font.Color := clBlack;
    btnVnd3.Font.Color := clBlack;
    btnVnd1.Font.Color := clBlack;
    btnVnd5.Font.Color := clBlack;
    btnVnd6.Font.Color := clBlack;
    btnVnd7.Font.Color := clBlack;
  end;
end;

procedure TfPdv.btnVnd5Click(Sender: TObject);
begin
  if (btnVnd5.Caption <> '') then
  begin
    abrePedido(StrToInt(btnVnd5.Caption));
    btnVnd5.Font.Color := clRed;
    btnVnd8.Font.Color := clBlack;
    btnVnd2.Font.Color := clBlack;
    btnVnd3.Font.Color := clBlack;
    btnVnd4.Font.Color := clBlack;
    btnVnd1.Font.Color := clBlack;
    btnVnd6.Font.Color := clBlack;
    btnVnd7.Font.Color := clBlack;
  end;
end;

procedure TfPdv.btnVnd6Click(Sender: TObject);
begin
  if (btnVnd6.Caption <> '') then
  begin
    abrePedido(StrToInt(btnVnd6.Caption));
    btnVnd6.Font.Color := clRed;
    btnVnd8.Font.Color := clBlack;
    btnVnd2.Font.Color := clBlack;
    btnVnd3.Font.Color := clBlack;
    btnVnd4.Font.Color := clBlack;
    btnVnd5.Font.Color := clBlack;
    btnVnd1.Font.Color := clBlack;
    btnVnd7.Font.Color := clBlack;
  end;
end;

procedure TfPdv.btnVnd7Click(Sender: TObject);
begin
  if (btnVnd7.Caption <> '') then
  begin
    abrePedido(StrToInt(btnVnd7.Caption));
    btnVnd7.Font.Color := clRed;
    btnVnd8.Font.Color := clBlack;
    btnVnd2.Font.Color := clBlack;
    btnVnd3.Font.Color := clBlack;
    btnVnd4.Font.Color := clBlack;
    btnVnd5.Font.Color := clBlack;
    btnVnd6.Font.Color := clBlack;
    btnVnd1.Font.Color := clBlack;
  end;
end;

procedure TfPdv.btnVnd8Click(Sender: TObject);
begin
  if (btnVnd8.Caption <> '') then
  begin
    abrePedido(StrToInt(btnVnd8.Caption));
    btnVnd8.Font.Color := clRed;
    btnVnd1.Font.Color := clBlack;
    btnVnd2.Font.Color := clBlack;
    btnVnd3.Font.Color := clBlack;
    btnVnd4.Font.Color := clBlack;
    btnVnd5.Font.Color := clBlack;
    btnVnd6.Font.Color := clBlack;
    btnVnd7.Font.Color := clBlack;
  end;
end;

procedure TfPdv.edProdutoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if (edProduto.Text <> '') then
    begin
      // TODO - preciso definir aqui, qdo e codigo de barra qdo e codigo
      // do produto, se codigo comecar com 'X' e codigo produto ???!!!
      // se o codigo tiver mais q 'X' caracter e codigo de barras ??!!
      fProdutoProc.busca(edProduto.Text, '','', False);
      if (fProdutoProc.codProduto = 0) then
      begin
        ShowMessage('Produto não Localizado.');
        Exit;
      end;
      codproduto := fProdutoProc.codProduto;
      codPro     := fProdutoProc.codProd;
      preco      := fProdutoProc.precoVenda;
      estoque    := fProdutoProc.estoque;
      proDesc    := fProdutoProc.produto;
      edProdutoDesc.Text := proDesc;
      edPreco.Text:= FloatToStr(preco);
      edQtde.Text:='1,00';
      registrar_item();
    end;
  end;
end;

procedure TfPdv.edQtdeChange(Sender: TObject);
begin
  calculaTotal();
end;

procedure TfPdv.edVendedorKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if (edVendedor.Text <> '') then
    begin
      fVendedorBusca.uCodVendedor := StrToInt(edVendedor.Text);
      fVendedorBusca.BuscaVendedor;
      if fVendedorBusca.uNomeVendedor = '' then
      begin
        ShowMessage('Vendedor não Encontrado');
        Exit;
      end;
      edVendedorNome.Text := fVendedorBusca.uNomeVendedor;
      codVendedor := fVendedorBusca.uCodVendedor;
    end;
  end;
end;

procedure TfPdv.FlowPanel1Click(Sender: TObject);
begin

end;

procedure TfPdv.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FMov.Free;
end;

procedure TfPdv.FormShow(Sender: TObject);
begin
  // TODO - carregar caixa logado na varivel abaixo
  qtde_ped := 0;
  codDet := 0;
  caixa_local := StrToInt(dmPdv.ccusto);
  codCaixa    := StrToInt(dmPdv.varLogado); // usuario
  codCliente  := 1;
  codVendedor := 1;
  num_pedido := 'x';
  FMov := TMovimento.Create;
  edCaixa.Text := dmPdv.nomeLogado + '-' + dmPdv.nomeCaixa;
  buscaPedidosAbertoCaixa(0);
end;

procedure TfPdv.Image1Click(Sender: TObject);
begin

end;

procedure TfPdv.Image2Click(Sender: TObject);
begin

end;

procedure TfPdv.Image3Click(Sender: TObject);
begin
  finalizarVenda();
  fPDV_Rec.ShowModal;
  iniciarVenda();
end;

procedure TfPdv.btnVendaClick(Sender: TObject);
begin

end;

procedure TfPdv.TIGroupBox1Click(Sender: TObject);
begin

end;

procedure TfPdv.abrePedido(apCodMov: Integer);
begin
  dmPdv.sqLancamentos.Close;
  dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger:=apCodMov;
  dmPdv.sqLancamentos.Open;
  codMov := apCodMov;
  codDet:=dmPdv.sqLancamentosCODDETALHE.AsInteger;
  edProduto.Text := dmPdv.sqLancamentosCODPRO.AsString;
  edProdutoDesc.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
  edQtde.Text    := FloatToStr(dmPdv.sqLancamentosQUANTIDADE.AsFloat);
  edPreco.Text   := FloatToStr(dmPdv.sqLancamentosPRECO.AsFloat);
  edDesconto.Text:= FloatToStr(dmPdv.sqLancamentosDESCONTO.AsFloat);
  edProdutoDesc.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
  //controlaPedidos(codMov, 0, 0);
  calculaTotalGeral();
  lblPedido.Caption:=IntToStr(codMov);
  edProduto.SetFocus;
end;

procedure TfPdv.iniciarVenda();
begin
  edTotalGeral.Text := '0,00';
  edTotal.Text := '0,00';
  if (not dsLanc.DataSet.Active) then
    dsLanc.DataSet.Active := True;
  //dsLanc.DataSet.Insert;
  Try
    dmPdv.sTrans.Active := True;
    FMov.CodMov      := 0;
    // TODO - Tratar as variaveis abaixo
    FMov.CodCCusto   := caixa_local;
    FMov.CodCliente  := codCliente;
    FMov.CodNatureza := 3; // Venda
    FMov.Status      := 0;
    FMov.CodUsuario  := codCaixa;
    FMov.CodVendedor := codVendedor;
    // TODO - Usar o campo Controle para Informar a SESSAO do PDV
    FMov.Controle    := 'SESSEAO-1';
    FMov.DataMov     := Now;
    codMov := FMov.inserirMovimento(0);
    num_pedido := IntToStr(codMov);
    dmPdv.sTrans.Commit;
    dmPdv.sqLancamentos.Close;
    dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger:=codMov;
    dmPdv.sqLancamentos.Open;
  finally

  end;
end;

procedure TfPdv.registrar_item();
begin
  Try
    lblNumItem.Caption := IntToStr(StrToInt(lblNumItem.Caption) + 1);
    dmPdv.sTrans.Active := True;
    // TODO - Tratar as variaveis abaixo
    FMov.MovDetalhe.CodMov        := codMov;
    FMov.MovDetalhe.CodProduto    := codproduto;
    FMov.MovDetalhe.Descricao     := proDesc;
    FMov.MovDetalhe.Qtde          := StrToFloat(edQtde.Text);
    FMov.MovDetalhe.Preco         := StrToFloat(edPreco.Text);
    edTotal.Text := FloatToStr(FMov.MovDetalhe.Qtde * FMov.MovDetalhe.Preco);
    //FMov.MovDetalhe.Baixa         := '1';
    codDet := Fmov.MovDetalhe.inserirMovDet();
    dmPdv.sTrans.Commit;
    dmPdv.sqLancamentos.Close;
    dmPdv.sqLancamentos.DisableControls;
    dmPdv.sqLancamentos.Open;
    dmPdv.sqLancamentos.Last;
    dmPdv.sqLancamentos.EnableControls;
    codDet := dmPdv.sqLancamentosCODDETALHE.AsInteger;
    edProduto.Text:='';
    fProdutoProc.codProduto := 0;
    calculaTotalGeral();
  finally
  end;
end;

procedure TfPdv.alterar_item();
begin
  Try
    dmPdv.sTrans.Active := True;
    FMov.MovDetalhe.CodMov := codMov;
    fMov.MovDetalhe.CodDet := codDet;
    FMov.MovDetalhe.Qtde   := StrToFloat(edQtde.Text);
    FMov.MovDetalhe.Preco  := StrToFloat(edPreco.Text);
    fMov.MovDetalhe.alterarMovDet();
    dmPdv.sTrans.Commit;
    dmPdv.sqLancamentos.Close;
    dmPdv.sqLancamentos.DisableControls;
    dmPdv.sqLancamentos.Open;
    dmPdv.sqLancamentos.Last;
    dmPdv.sqLancamentos.EnableControls;
    codDet := dmPdv.sqLancamentosCODDETALHE.AsInteger;
    calculaTotalGeral();
  finally
  end;
end;

procedure TfPdv.finalizarVenda();
begin

end;

procedure TfPdv.calculaTotal();
var tPrc: Double;
   tQtde: Double;
   tDesc: Double;
   sPrc: String;
   sQtde: String;
   sDesc: String;
begin
  tQtde:=0;
  tPrc :=0;
  tDesc:=0;
  sPrc  := edPreco.Text;
  sQtde := edQtde.Text;
  sDesc := edDesconto.Text;
  try
    tQtde := StrToFloat(sQtde);
  except
    tQtde := StrToFloat(StringReplace(sQtde,',','.',[rfReplaceAll]));;
  end;
  try
    tPrc := StrToFloat(edPreco.Text);
  except
    tPrc := StrToFloat(StringReplace(sPrc,',','.',[rfReplaceAll]));
  end;
  // TODO - Tratar o Desconto
  if (tDesc > 0) then
  begin
    edTotal.Text := FloatToStr((tPrc*tQtde)-tDesc);
  end
  else begin
    edTotal.Text := FloatToStr(tPrc*tQtde);
  end;

end;

procedure TfPdv.calculaTotalGeral();
var vTotGeral: Double;
   num_linha: Integer;
   qtde_itens: Integer;
begin
  vTotGeral := 0;
  qtde_itens := 0;
  num_linha := dmPdv.sqLancamentos.RecNo;
  dmPdv.sqLancamentos.DisableControls;
  //dmPdv.sqLancamentos.Open;
  dmPdv.sqLancamentos.First;
  while not dmPdv.sqLancamentos.EOF do
  begin
    vTotGeral += dmPdv.sqLancamentosVALTOTAL.AsFloat;
    qtde_itens += 1;
    dmPdv.sqLancamentos.Next;
  end;
  if (num_linha > 0) then
  begin
    dmPdv.sqLancamentos.RecNo := num_linha;
    edTotalGeral.Text := FloatToStr(vTotGeral);
    lblNumItem.Caption:= IntToStr(qtde_itens);
  end;
  dmPdv.sqLancamentos.EnableControls;
end;

procedure TfPdv.controlaPedidos(cpCodMov: Integer; cpStatus: Integer; cpTipo: Integer);
begin
  if (cpTipo = 0) then // inclusao
  begin
    if btnVnd1.Caption = '' then
    begin
      btnVnd1.Caption := IntToStr(cpCodMov);
      btnVnd1.Font.Color := clRed;
    end
    else if btnVnd2.Caption = '' then
    begin
      btnVnd2.Caption := IntToStr(cpCodMov);
      btnVnd1.Font.Color := clBlack;
      btnVnd2.Font.Color := clRed;
    end
    else if btnVnd3.Caption = '' then
    begin
      btnVnd3.Caption := IntToStr(cpCodMov);
      btnVnd1.Font.Color := clBlack;
      btnVnd3.Font.Color := clRed;
      btnVnd2.Font.Color := clBlack;
    end
    else if btnVnd4.Caption = '' then
    begin
      btnVnd4.Caption := IntToStr(cpCodMov);
      btnVnd4.Font.Color := clRed;
      btnVnd1.Font.Color := clBlack;
      btnVnd2.Font.Color := clBlack;
      btnVnd3.Font.Color := clBlack;
    end
    else if btnVnd5.Caption = '' then
    begin
      btnVnd5.Caption := IntToStr(cpCodMov);
      btnVnd5.Font.Color := clRed;
      btnVnd1.Font.Color := clBlack;
      btnVnd2.Font.Color := clBlack;
      btnVnd3.Font.Color := clBlack;
      btnVnd4.Font.Color := clBlack;
    end
    else if btnVnd6.Caption = '' then
    begin
      btnVnd6.Caption := IntToStr(cpCodMov);
      btnVnd6.Font.Color := clRed;
      btnVnd1.Font.Color := clBlack;
      btnVnd2.Font.Color := clBlack;
      btnVnd3.Font.Color := clBlack;
      btnVnd4.Font.Color := clBlack;
      btnVnd5.Font.Color := clBlack;
    end
    else if btnVnd7.Caption = '' then
    begin
      btnVnd7.Caption := IntToStr(cpCodMov);
      btnVnd7.Font.Color := clRed;
      btnVnd1.Font.Color := clBlack;
      btnVnd2.Font.Color := clBlack;
      btnVnd3.Font.Color := clBlack;
      btnVnd4.Font.Color := clBlack;
      btnVnd5.Font.Color := clBlack;
      btnVnd6.Font.Color := clBlack;
    end
    else if btnVnd8.Caption = '' then
    begin
      btnVnd8.Caption := IntToStr(cpCodMov);
      btnVnd8.Font.Color := clRed;
      btnVnd1.Font.Color := clBlack;
      btnVnd2.Font.Color := clBlack;
      btnVnd3.Font.Color := clBlack;
      btnVnd4.Font.Color := clBlack;
      btnVnd5.Font.Color := clBlack;
      btnVnd6.Font.Color := clBlack;
      btnVnd7.Font.Color := clBlack;
    end;
  end else
  begin
    if (btnVnd1.Caption = IntToStr(cpCodMov)) then
    begin
      if cpStatus = 1 then
        btnVnd1.Caption:=''
      else
        btnVnd1.Caption:= IntToStr(cpCodMov);
    end;
    if (btnVnd2.Caption = IntToStr(cpCodMov)) then
    begin
      if cpStatus = 1 then
        btnVnd2.Caption:=''
      else
        btnVnd2.Caption:= IntToStr(cpCodMov);
    end;
    if (btnVnd3.Caption = IntToStr(cpCodMov)) then
    begin
      if cpStatus = 1 then
        btnVnd3.Caption:=''
      else
        btnVnd3.Caption:= IntToStr(cpCodMov);
    end;
    if (btnVnd4.Caption = IntToStr(cpCodMov)) then
    begin
      if cpStatus = 1 then
        btnVnd4.Caption:=''
      else
        btnVnd4.Caption:= IntToStr(cpCodMov);
    end;
    if (btnVnd5.Caption = IntToStr(cpCodMov)) then
    begin
      if cpStatus = 1 then
        btnVnd5.Caption:=''
      else
        btnVnd5.Caption:= IntToStr(cpCodMov);
    end;
    if (btnVnd6.Caption = IntToStr(cpCodMov)) then
    begin
      if cpStatus = 1 then
        btnVnd6.Caption:=''
      else
        btnVnd6.Caption:= IntToStr(cpCodMov);
    end;
    if (btnVnd7.Caption = IntToStr(cpCodMov)) then
    begin
      if cpStatus = 1 then
        btnVnd7.Caption:=''
      else
        btnVnd7.Caption:= IntToStr(cpCodMov);
    end;
    if (btnVnd8.Caption = IntToStr(cpCodMov)) then
    begin
      if cpStatus = 1 then
        btnVnd8.Caption:=''
      else
        btnVnd8.Caption:= IntToStr(cpCodMov);
    end;
  end;

end;

procedure TfPdv.buscaPedidosAbertoCaixa(bpCodMov: Integer);
var bCodMov: Integer;
begin
  //limpa todos pedidos
  btnVnd1.Caption:='';
  btnVnd2.Caption:='';
  btnVnd3.Caption:='';
  btnVnd4.Caption:='';
  btnVnd5.Caption:='';
  btnVnd6.Caption:='';
  btnVnd7.Caption:='';
  btnVnd8.Caption:='';
  btnVnd1.Font.Color := clBlack;
  btnVnd2.Font.Color := clBlack;
  btnVnd3.Font.Color := clBlack;
  btnVnd4.Font.Color := clBlack;
  btnVnd5.Font.Color := clBlack;
  btnVnd6.Font.Color := clBlack;
  btnVnd7.Font.Color := clBlack;
  btnVnd8.Font.Color := clBlack;
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT CODMOVIMENTO FROM MOVIMENTO ' +
    ' WHERE STATUS = 0 AND CODALMOXARIFADO = ' + dmPdv.ccusto;
  dmPdv.sqBusca.Open;
  while not dmpdv.sqBusca.EOF do
  begin
    bCodMov:= dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
    Case dmPdv.sqBusca.RecNo of
      1 : btnVnd1.Caption:= IntToStr(bCodMov);
      2 : btnVnd2.Caption:= IntToStr(bCodMov);
      3 : btnVnd3.Caption:= IntToStr(bCodMov);
      4 : btnVnd4.Caption:= IntToStr(bCodMov);
      5 : btnVnd5.Caption:= IntToStr(bCodMov);
      6 : btnVnd6.Caption:= IntToStr(bCodMov);
      7 : btnVnd7.Caption:= IntToStr(bCodMov);
      8 : btnVnd8.Caption:= IntToStr(bCodMov);
    end;
    qtde_ped := qtde_ped + 1;
    //controlaPedidos(bCodMov,1,0);
    if (bpCodMov = bCodMov) then
    begin
      Case dmPdv.sqBusca.RecNo of
        1 : btnVnd1.Font.Color := clRed;
        2 : btnVnd2.Font.Color := clRed;
        3 : btnVnd3.Font.Color := clRed;
        4 : btnVnd4.Font.Color := clRed;
        5 : btnVnd5.Font.Color := clRed;
        6 : btnVnd6.Font.Color := clRed;
        7 : btnVnd7.Font.Color := clRed;
        8 : btnVnd8.Font.Color := clRed;
      end;
    end;
    dmPdv.sqBusca.Next;
  end;
end;

end.

