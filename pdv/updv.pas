unit uPdv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, SynEdit, RTTICtrls, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, MaskEdit, DBGrids, ActnList,
  Menus, dateutils, uMovimento, uVendedorBusca, uClienteBusca, uPermissao,
  Grids,  MTProcs;

type

  { TfPdv }

  TfPdv = class(TForm)
    acReceber: TAction;
    acFechar: TAction;
    acProcurar: TAction;
    acNova: TAction;
    acExcluirItemPedido: TAction;
    acQuantidade: TAction;
    ActionList1: TActionList;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn5: TBitBtn;
    btnProdutoProc: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    btnInfo: TBitBtn;
    btnVnd1: TBitBtn;
    btnVnd2: TBitBtn;
    btnVnd3: TBitBtn;
    btnVnd4: TBitBtn;
    btnVnd5: TBitBtn;
    btnVnd6: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnNovo: TBitBtn;
    btnVendas: TBitBtn;
    btnReceber: TBitBtn;
    btnVnd7: TBitBtn;
    btnVnd8: TBitBtn;
    cbPercentual: TCheckBox;
    cbPercentual1: TCheckBox;
    dsProdProc: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    dsLanc: TDataSource;
    edCliente: TEdit;
    edDesconto1: TMaskEdit;
    edProdNao: TEdit;
    edPreco: TMaskEdit;
    edDesconto: TMaskEdit;
    edPreco1: TMaskEdit;
    edProduto: TEdit;
    edQtde1: TMaskEdit;
    edTotalGeral: TMaskEdit;
    edVendedorNome: TEdit;
    edVendedor: TEdit;
    edCaixa: TEdit;
    edProdutoDescX: TEdit;
    edClienteNome: TEdit;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edBuscaDetalhe: TLabeledEdit;
    Label20: TLabel;
    lblMSG: TLabel;
    lblProdBusca: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    lblNumItem: TLabel;
    lblPedido: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edQtde: TMaskEdit;
    edProdutoDesc: TMemo;
    lblSenha: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    MemoIntegra: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    pnIntegra: TPanel;
    pnProdutoNaoLocalizado: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pnProdBusca: TPanel;
    pnAltera: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pnInfo: TPanel;
    PopupMenu1: TPopupMenu;
    TIButton2: TTIButton;
    procedure acExcluirItemPedidoExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
    procedure acNovaExecute(Sender: TObject);
    procedure acProcurarExecute(Sender: TObject);
    procedure acQuantidadeExecute(Sender: TObject);
    procedure acReceberExecute(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure btnProdutoProcClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
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
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid2Enter(Sender: TObject);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid2KeyPress(Sender: TObject; var Key: char);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBuscaDetalheChange(Sender: TObject);
    procedure edClienteChange(Sender: TObject);
    procedure edClienteKeyPress(Sender: TObject; var Key: char);
    procedure edDesconto1Change(Sender: TObject);
    procedure edDesconto1KeyPress(Sender: TObject; var Key: char);
    procedure edDescontoKeyPress(Sender: TObject; var Key: char);
    procedure edPreco1KeyPress(Sender: TObject; var Key: char);
    procedure edPrecoChange(Sender: TObject);
    procedure edPrecoKeyPress(Sender: TObject; var Key: char);
    procedure edProdutoKeyPress(Sender: TObject; var Key: char);
    procedure edQtde1KeyPress(Sender: TObject; var Key: char);
    procedure edQtdeChange(Sender: TObject);
    procedure edQtdeKeyPress(Sender: TObject; var Key: char);
    procedure edVendedorKeyPress(Sender: TObject; var Key: char);
    procedure FlowPanel1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure btnVendaClick(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
    procedure TIGroupBox1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    codproduto: Integer;
    codPro: String;
    proDesc: String;
    num_pedido: String;
    preco: Double;
    precoAtacado: Double;
    qtdeAtacado: Double;
    estoque: Double;
    vTotDesc: Double;
    caixa_local: Integer; // Sessao Caixa
    codCliente: Integer;
    codCaixa: Integer; // cod Usuario
    codVendedor: Integer;
    codMov: Integer;
    codDet: Integer;
    qtde_ped: Integer;
    num_item: Integer;
    procedure abrePedido(apCodMov: Integer);
    procedure iniciarVenda();
    procedure registrar_item();
    procedure alterar_item();
    procedure finalizarVenda();
    procedure calculaTotal();
    procedure calculaTotalGeral();
    procedure abreSqLanc();
    procedure adicionaProduto();
    procedure controlaPedidos(cpCodMov: Integer; cpStatus: Integer; cpTipo: Integer);
    procedure buscaPedidosAbertoCaixa(bpCodMov: Integer);
    procedure preencherDescItem(descItem: String);
    procedure buscaVendedor(codBarraV: String);
    procedure executaIntegracao(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
    procedure Executa(script: String);
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

procedure TfPdv.edDesconto1Change(Sender: TObject);
begin

end;

procedure TfPdv.edDesconto1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    // desconto
    edDesconto.Text:=edDesconto1.Text;
    alterar_item();
    calculaTotalGeral();
    edProduto.SetFocus;
    pnAltera.Visible:=False;
  end;

end;

procedure TfPdv.edDescontoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    // desconto
    alterar_item();
    calculaTotalGeral();
  end;
end;

procedure TfPdv.edPreco1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    edPreco.Text := edPreco1.Text;
    preco := fPDV_Rec.strParaFloat(edPreco.Text);
    edDesconto1.SetFocus;
  end;

end;

procedure TfPdv.edPrecoChange(Sender: TObject);
begin
  calculaTotal();
end;

procedure TfPdv.edPrecoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    preco := fPDV_Rec.strParaFloat(edPreco.Text);
    alterar_item();
    calculaTotalGeral();
  end;
end;

procedure TfPdv.DBGrid1CellClick(Column: TColumn);
begin
  if (dmPdv.sqLancamentos.Active) then
  begin
    codDet := dmPdv.sqLancamentosCODDETALHE.AsInteger;
    edProduto.Text := dmPdv.sqLancamentosCODPRO.AsString;
    edQtde.Text    := FormatFloat('#,,,0.00',dmPdv.sqLancamentosQUANTIDADE.AsFloat);
    edPreco.Text   := FormatFloat('#,,,0.00',dmPdv.sqLancamentosPRECO.AsFloat);
    preco          := dmPdv.sqLancamentosPRECO.AsFloat;
    precoAtacado   := dmPdv.sqLancamentosPRECOATACADO.AsFloat;
    qtdeAtacado    := dmPdv.sqLancamentosQTDEATACADO.AsInteger;
    edDesconto.Text:= FormatFloat('#,,,0.00',dmPdv.sqLancamentosDESCONTO.AsFloat);
    buscaVendedor(IntToStr(dmPdv.sqLancamentosCODVENDEDOR.AsInteger));
    preencherDescItem(dmPdv.sqLancamentosDESCPRODUTO.AsString);
  end;
end;

procedure TfPdv.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  try
    try
      bmp.LoadFromFile('atacado.bmp');
      if  dmPdv.sqLancamentosII.AsFloat > 0 then
      begin
        if Column.Title.Caption = 'Preço' then
          DBGrid1.Canvas.Draw(Rect.Left, Rect.Top, bmp);
      end;
    Except
      ShowMessage('Arquivo atacado.bmp não localizado.');
    end;
  finally
    bmp.Free;
  end;
end;

procedure TfPdv.DBGrid2CellClick(Column: TColumn);
begin
  lblProdBusca.Caption:=dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
end;

procedure TfPdv.DBGrid2Enter(Sender: TObject);
begin
end;

procedure TfPdv.DBGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 27) then
  begin
    edProduto.SetFocus;
    pnProdBusca.Visible:=False;
  end;
  if (Key = 39) then
  begin
    //Key := #0;
    fProdutoProc.codProduto := dmPdv.sqBusca.FieldByName('CODPRODUTO').AsInteger;
    fProdutoProc.produto    := dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
    fProdutoProc.codProd    := dmPdv.sqBusca.FieldByName('CODPRO').AsString;
    fProdutoProc.precoVenda := dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
    fProdutoProc.precoVendaAtacado := dmPdv.sqBusca.FieldByName('PRECOATACADO').AsFloat;
    fProdutoProc.qtdeAtacado:= dmPdv.sqBusca.FieldByName('QTDEATACADO').AsFloat;
    fProdutoProc.estoque    := dmPdv.sqBusca.FieldByName('ESTOQUEATUAL').AsFloat;
    fProdutoProc.tipo_venda := dmPdv.sqBusca.FieldByName('RATEIO').AsString;
    pnProdBusca.Visible := False;
    adicionaProduto();
  end;

end;

procedure TfPdv.DBGrid2KeyPress(Sender: TObject; var Key: char);
begin
end;

procedure TfPdv.DBGrid2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if (Key = 27) then
  begin
    edProduto.SetFocus;
    pnProdBusca.Visible:=False;
  end;
  if (Key = 37) then
  begin
    //Key := #0;
    fProdutoProc.codProduto := dmPdv.sqBusca.FieldByName('CODPRODUTO').AsInteger;
    fProdutoProc.produto    := dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
    fProdutoProc.codProd    := dmPdv.sqBusca.FieldByName('CODPRO').AsString;
    fProdutoProc.precoVenda := dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
    fProdutoProc.precoVendaAtacado := dmPdv.sqBusca.FieldByName('PRECOATACADO').AsFloat;
    fProdutoProc.qtdeAtacado:= dmPdv.sqBusca.FieldByName('QTDEATACADO').AsFloat;
    fProdutoProc.estoque    := dmPdv.sqBusca.FieldByName('ESTOQUEATUAL').AsFloat;
    fProdutoProc.tipo_venda := dmPdv.sqBusca.FieldByName('RATEIO').AsString;
    pnProdBusca.Visible := False;
    adicionaProduto();
  end;

end;

procedure TfPdv.edBuscaDetalheChange(Sender: TObject);
begin

end;

procedure TfPdv.btnReceberClick(Sender: TObject);
begin

end;

procedure TfPdv.BitBtn7Click(Sender: TObject);
begin
end;

procedure TfPdv.btnProdutoProcClick(Sender: TObject);
begin
  fProdutoProc.ShowModal;
  if fProdutoProc.codProduto > 0 then
  begin
    codproduto := fProdutoProc.codProduto;
    codPro     := fProdutoProc.codProd;
    edProduto.Text := codPro;
    preco      := fProdutoProc.precoVenda;
    precoAtacado:=fProdutoProc.precoVendaAtacado;
    qtdeAtacado:= fProdutoProc.qtdeAtacado;
    estoque    := fProdutoProc.estoque;
    proDesc    := fProdutoProc.produto;
    //edProdutoDescX.Text := proDesc;
    preencherDescItem(proDesc);
    edPreco.Text:= FormatFloat('#,,,0.00',preco);
    edQtde.Text:='1,00';
    edProduto.Text := codPro;
    edProduto.SetFocus;
    adicionaProduto();
  end;
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

procedure TfPdv.BitBtn4Click(Sender: TObject);
begin
  acQuantidade.Execute;
end;

procedure TfPdv.BitBtn5Click(Sender: TObject);
begin

end;

procedure TfPdv.acReceberExecute(Sender: TObject);
begin
  if (dmpdv.sqLancamentosSTATUS.AsInteger = 2) then
  begin
    ShowMessage('Pedido Cancelado;');
    Exit;
  end;
  if edVendedor.Text = '' then
  begin
    ShowMessage('Vendedor não informado;');
    edProduto.Text := '';
    edProduto.SetFocus;
    Exit;
  end;
  buscaVendedor(edVendedor.Text);
  if (codVendedor = 0) then
  begin
    ShowMessage('Vendedor não informado;');
    edProduto.Text := '';
    edProduto.SetFocus;
    Exit;
  end;
  //if (dmPdv.sqLancamentosCODCLIENTE.AsInteger <> codCliente) then
  //begin
  dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET CODCLIENTE = ' +
      IntToStr(codCliente) + ', CODVENDEDOR = ' + IntToStr(codVendedor) +
      ' WHERE CODMOVIMENTO = ' + IntToStr(codMov) +
      ' AND STATUS = 0');
  //end;
  fPDV_Rec.vValor  := edTotalGeral.Text;
  fPDV_Rec.vUsuario:= codCaixa;
  fPDV_Rec.vVendedor:= codVendedor;
  fPDV_Rec.vCliente := codCliente;
  fPDV_Rec.vClienteNome := edClienteNome.Text;
  fPDV_Rec.vVendedorNome:= edVendedorNome.Text;
  fPDV_Rec.vCaixa_Local := caixa_local;
  fPDV_Rec.vCodMovimento:= codMov;
  //fPDV_Rec.vDesconto := vTotDesc;
  fPDV_Rec.ShowModal;
  if fPDV_Rec.vStatus = 1 then
  begin
    //controlaPedidos(codMov, 1, 1);
    buscaPedidosAbertoCaixa(codMov);
    if (qtde_ped = 0) then
      btnNovo.Click
    else
      btnVnd1.Click;
  end;
end;

procedure TfPdv.BitBtn10Click(Sender: TObject);
begin
  edQtde.Text:=edQtde1.Text;
  edPreco.Text:=edPreco1.Text;
  edDesconto.Text:=edDesconto1.Text;
  alterar_item();
  calculaTotalGeral();
  edProduto.SetFocus;
  pnAltera.Visible:=False;
end;

procedure TfPdv.BitBtn11Click(Sender: TObject);
begin
  edProduto.SetFocus;
  pnProdBusca.Visible:=False;
end;

procedure TfPdv.BitBtn12Click(Sender: TObject);
begin
  pnProdutoNaoLocalizado.Visible:=False;
  edProduto.SetFocus;
end;

procedure TfPdv.acFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfPdv.acExcluirItemPedidoExecute(Sender: TObject);
begin
  fPermissao.permCodMov:=codMov;
  fPermissao.permCodDet:=dmPdv.sqLancamentosCODDETALHE.AsInteger;
  fPermissao.ShowModal;
  buscaPedidosAbertoCaixa(codMov);
  abrePedido(codMov);
  calculaTotalGeral();
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
  //dmPdv.IbCon.Connected:=False;
  //dmPdv.IbCon.Connected:=True;
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
    //edProdutoDescX.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
    preencherDescItem(dmPdv.sqLancamentosDESCPRODUTO.AsString);
    edQtde.Text    := FormatFloat('#,,,0.00',dmPdv.sqLancamentosQUANTIDADE.AsFloat);
    edPreco.Text   := FormatFloat('#,,,0.00',dmPdv.sqLancamentosPRECO.AsFloat);
    edDesconto.Text:= FormatFloat('#,,,0.00',dmPdv.sqLancamentosDESCONTO.AsFloat);
    codVendedor := dmPdv.sqLancamentosCODVENDEDOR.AsInteger;
    edVendedor.Text:= IntToStr(codVendedor);
    codCliente := dmpdv.sqLancamentosCODCLIENTE.AsInteger;
    edCliente.Text := IntToStr(codCliente);
    fClienteBusca.cCodCliente := StrToInt(edCliente.Text);
    fClienteBusca.BuscaCliente;
    edClienteNome.Text := fClienteBusca.cNomeCliente;
    codCliente := fClienteBusca.cCodCliente;
    //edProdutoDescX.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
    //controlaPedidos(codMov, 0, 0);
    buscaPedidosAbertoCaixa(codMov);
    buscaVendedor(edVendedor.Text);
    calculaTotalGeral();
  end;
end;

procedure TfPdv.acQuantidadeExecute(Sender: TObject);
begin
  pnAltera.Visible:=True;
  edQtde1.Enabled:= True;
  edQtde.Enabled:= True;
  edQtde1.Text:=edQtde.Text;
  edPreco1.Text:=edPreco.Text;
  edDesconto1.Text:=edDesconto.Text;
  edQtde1.SetFocus;
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
var  logs:TextFile;
begin
  if (btnVnd3.Caption <> '') then
  begin
    abrePedido(StrToInt(btnVnd3.Caption));
    AssignFile(logs, 'log1.txt');
    try
      Rewrite(logs);
      Writeln(logs, 'Botao 3');
      btnVnd3.Font.Color := clRed;
      btnVnd8.Font.Color := clBlack;
      btnVnd2.Font.Color := clBlack;
      btnVnd1.Font.Color := clBlack;
      btnVnd4.Font.Color := clBlack;
      btnVnd5.Font.Color := clBlack;
      btnVnd6.Font.Color := clBlack;
      btnVnd7.Font.Color := clBlack;
      Writeln(logs, 'Terminou Botao 3');
    finally
      CloseFile(logs);
    end;
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
var i: Integer;
begin
  if Key = #13 then
  begin
    Key := #0;
    if (edProduto.Text <> '') then
    begin
      fProdutoProc.num_busca:=0;
      // TODO - preciso definir aqui, qdo e codigo de barra qdo e codigo
      // do produto, se codigo comecar com 'X' e codigo produto ???!!!
      // se o codigo tiver mais q 'X' caracter e codigo de barras ??!!

      // digitou letras entao busca pela descricao
      if not TryStrToInt(Copy(edProduto.Text,0,1),i) then
      begin
        fProdutoProc.busca('', '',edProduto.Text, False);
      end
      else if ((Copy(edProduto.Text,0,2)='04') and (Length(edProduto.Text) > 6)) then
      begin
        buscaVendedor(edProduto.Text);
        Exit;
      end
      else if Length(edProduto.Text) > 7 then
        fProdutoProc.busca('',edProduto.Text, '', False)
      else
        fProdutoProc.busca(edProduto.Text, '','', False);
      if (fProdutoProc.codProduto = 0) then
      begin
        //ShowMessage('Produto não Localizado.');
        pnProdutoNaoLocalizado.Visible:=True;
        edProdNao.SetFocus;
        fProdutoProc.Edit2.Text := edProduto.Text;
        //btnProdutoProc.Click;
      end;
    end;
    if fProdutoProc.num_busca > 1 then
    begin
      pnProdBusca.Visible:=True;
      DBGrid2.SetFocus;
      Beep;
      Beep;
    end;
    //pnProdBusca.Visible:=False;
    if fProdutoProc.num_busca = 1 then
    begin
      adicionaProduto();
    end;
    if fProdutoProc.num_busca = 0 then
    begin
      edProduto.Text:='';
      Beep;
      Beep;
      Beep;
    end;
  end;
end;

procedure TfPdv.edQtde1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    edQtde.Text:=edQtde1.Text;
    edPreco1.SetFocus;
  end;

end;

procedure TfPdv.edQtdeChange(Sender: TObject);
begin
  calculaTotal();
end;

procedure TfPdv.edQtdeKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
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
    edQtde.Enabled:= False;
    if pnAltera.Visible then
    begin
      edQtde.Text:=edQtde1.Text;
      edPreco1.SetFocus;
      Exit;
    end;
    edProduto.SetFocus;
  end;
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

procedure TfPdv.FormCreate(Sender: TObject);
begin
  Image1.Picture.LoadFromFile('logo.png');
end;

procedure TfPdv.FormShow(Sender: TObject);
var sqlP: String;
begin
  DBGrid2.Columns[0].FieldName:='CODPRO';
  DBGrid2.Columns[1].FieldName:='PRODUTO';
  DBGrid2.Columns[2].FieldName:='UNIDADEMEDIDA';
  DBGrid2.Columns[3].FieldName:='VALOR_PRAZO';
  DBGrid2.Columns[3].DisplayFormat:=',##0.00';

  sqlP := 'SELECT CODCAIXA, NOMECAIXA ';
  sqlP += ' FROM CAIXA_CONTROLE  ';
  sqlP += ' WHERE CODUSUARIO = ' + dmPdv.varLogado;
  sqlP += '   AND SITUACAO = ' + QuotedStr('o');
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    dmPdv.ccusto := IntToStr(dmPdv.sqBusca.FieldByName('CODCAIXA').AsInteger);
    num_pedido := dmPdv.sqBusca.FieldByName('NOMECAIXA').AsString;
  end;
  // TODO - carregar caixa logado na varivel abaixo
  qtde_ped := 0;
  codDet := 0;
  caixa_local := StrToInt(dmPdv.ccusto);
  codCaixa    := StrToInt(dmPdv.varLogado); // usuario
  codCliente  := 1;
  edClienteNome.Text := 'Consumidor';
  edCliente.Text     := '1';
  codVendedor := dmpdv.vendedor_padrao;
  edVendedor.Text := IntToStr(dmpdv.vendedor_padrao);
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

procedure TfPdv.Panel6Click(Sender: TObject);
begin

end;

procedure TfPdv.TIGroupBox1Click(Sender: TObject);
begin

end;

procedure TfPdv.Timer1Timer(Sender: TObject);
begin
  //lblMSG.Caption:='Integrando pedidos ...';
  //executa('atsOrder.py');
end;

procedure TfPdv.Timer2Timer(Sender: TObject);
begin
  //lblMSG.Caption:='Integrando produtos ...';
  //Executa('atsProduto.py');
  //lblMSG.Caption:='Integrando clientes ...';
  //Executa('atsCliente.py');
end;

procedure TfPdv.abrePedido(apCodMov: Integer);
var  logs:TextFile;
  vdr: String;
begin
  vdr := edVendedor.Text;
  edVendedor.Text := '0';
  vdr := edVendedor.Text;
  codVendedor := 0;
  if (dmpdv.vendedor_padrao > 0) then
  begin
    codVendedor := dmpdv.vendedor_padrao;
    edVendedor.Text := IntToStr(dmpdv.vendedor_padrao);
    edVendedorNome.Text := '';
  end;
  AssignFile(logs, 'log.txt');
  try
    Rewrite(logs);
    Writeln(logs, 'Abrindo Pedido');
  lblMSG.Caption:='Abrindo Pedido';
  try
    dmPdv.sqLancamentos.Close;
    dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger:=apCodMov;
    dmPdv.sqLancamentos.Open;
  except
    on E:Exception do
    begin
      ShowMessage(E.ClassName+ ' Erro para abrir Pedido: ' + E.Message);
    end;
  end;
  Writeln(logs, 'Abrindo Pedido-1');
  lblMSG.Caption:='Abrindo Pedido-1';
  //dmPdv.sqLancamentos.Last;
  codMov := apCodMov;
  lblPedido.Caption:=IntToStr(codMov);
  if not dmPdv.sqLancamentos.IsEmpty then
  begin
    num_item:=dmPdv.sqLancamentosNITEMPED.AsInteger+1;
    //lblNumItem.Caption := IntToStr(dmpdv.sqLancamentos.RecordCount);
    codDet:=dmPdv.sqLancamentosCODDETALHE.AsInteger;
    edProduto.Text := dmPdv.sqLancamentosCODPRO.AsString;
    //edProdutoDescX.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
    lblMSG.Caption:='Abrindo Pedido-2';
    Writeln(logs, 'Abrindo Pedido-2');
    preencherDescItem(dmPdv.sqLancamentosDESCPRODUTO.AsString);
    edQtde.Text    := FormatFloat('#,,,0.00',dmPdv.sqLancamentosQUANTIDADE.AsFloat);
    edPreco.Text   := FormatFloat('#,,,0.00',dmPdv.sqLancamentosPRECO.AsFloat);
    edDesconto.Text:= FormatFloat('#,,,0.00',dmPdv.sqLancamentosDESCONTO.AsFloat);
    buscaVendedor(IntToStr(dmPdv.sqLancamentosCODVENDEDOR.AsInteger));
    //edProdutoDescX.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
    //controlaPedidos(codMov, 0, 0);
  end;
  lblMSG.Caption:='Abrindo Pedido-3';
  Writeln(logs, 'Abrindo Pedido-3');
  edProduto.Enabled := True;
  Writeln(logs, 'Abrindo Pedido-4');
  calculaTotalGeral();
  Writeln(logs, 'Calculou Total');
  //edProduto.SetFocus;
  Writeln(logs, 'Foco Produto');
  finally
    CloseFile(logs);
  end;
  vdr := edVendedor.Text;
end;

procedure TfPdv.iniciarVenda();
begin
  if (dmPdv.nomeCaixa <> 'FECHADO') then
  begin
    num_item:=1;
    edProduto.Enabled := True;
    edProdutoDesc.Lines.Clear;
    edProdutoDesc.Lines.Add('Produto:');
    edCliente.Text := '1';
    codCliente :=1;
    edClienteNome.Text := 'Consumidor';
    if (dmPdv.vendedor_padrao > 0) then
    begin
      edVendedor.Text := IntToStr(dmPdv.vendedor_padrao);
      edVendedorNome.Text := 'Vendedor';
    end
    else begin
      edVendedor.Text  := '';
      edVendedorNome.Text := '';
    end;

    edTotalGeral.Text := '0,00';
    //edTotal.Text := '0,00';
    if (not dsLanc.DataSet.Active) then
      dsLanc.DataSet.Active := True;
    //dsLanc.DataSet.Insert;
    FMov := TMovimento.Create;
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
      FMov.Controle    := num_pedido;
      FMov.DataMov     := Now;
      codMov := FMov.inserirMovimento(0);
      //num_pedido := IntToStr(codMov);
      dmPdv.sTrans.Commit;
      dmPdv.sqLancamentos.Close;
      dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger:=codMov;
      dmPdv.sqLancamentos.Open;
    finally
      FMov.Free;
    end;
  end
  else begin
    ShowMessage('Caixa Fechado.');
  end;
end;

procedure TfPdv.registrar_item();
begin
  if (codProduto = 0)  then
     exit;
  if not dmPdv.sqLancamentos.Active then
  begin
    if dmPdv.sqLancamentosSTATUS.AsInteger > 0 then
    begin
      ShowMessage('Pedido já finalizado.');
      Exit;
    end;
  end;
  if (fPDV_Rec.strParaFloat(edQtde.Text) > 1000) then
  begin
    ShowMessage('Quantidade parece errada.');
    Exit;
  end;
  FMov := TMovimento.Create;
  Try
    //lblNumItem.Caption := IntToStr(StrToInt(lblNumItem.Caption) + 1);
    dmPdv.sTrans.Active := True;
    // TODO - Tratar as variaveis abaixo
    FMov.MovDetalhe.CodMov     := codMov;
    FMov.MovDetalhe.CodProduto := codproduto;
    FMov.MovDetalhe.Descricao  := proDesc;
    FMov.MovDetalhe.nItem      := num_item;
    FMov.MovDetalhe.Cortesia   := fProdutoProc.tipo_venda;
    FMov.MovDetalhe.Qtde       := fPDV_Rec.strParaFloat(edQtde.Text);
    if (edDesconto.Text <> '') then
      FMov.MovDetalhe.Desconto := fPDV_Rec.strParaFloat(edDesconto.Text);
    FMov.MovDetalhe.Preco         := fPDV_Rec.strParaFloat(edPreco.Text);
    //edTotal.Text := FloatToStr(FMov.MovDetalhe.Qtde * FMov.MovDetalhe.Preco);
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
    FMov.Free;
  end;
end;

procedure TfPdv.alterar_item();
var qAtac:Double;
  calc_desc: Double;
begin
  if not dmPdv.sqLancamentos.Active then
  begin
    if dmPdv.sqLancamentosSTATUS.AsInteger > 0 then
    begin
      ShowMessage('Pedido já finalizado.');
      Exit;
    end;
  end;
  FMov := TMovimento.Create;
  Try
    dmPdv.sqLancamentos.Last;
    dmPdv.sTrans.Active := True;
    FMov.MovDetalhe.CodMov := codMov;
    fMov.MovDetalhe.CodDet := codDet;
    FMov.MovDetalhe.Qtde   := fPDV_Rec.strParaFloat(edQtde.Text);
    qAtac := fPDV_Rec.strParaFloat(edQtde.Text);
    if ((qtdeAtacado > 0) and (qAtac >= qtdeAtacado)) then
    begin
      FMov.MovDetalhe.Ii    := preco;
      FMov.MovDetalhe.Preco := precoAtacado;
      edPreco.Text := FormatFloat('#,,,0.00',precoAtacado);
    end
    else begin
      FMov.MovDetalhe.Ii    := 0;
      FMov.MovDetalhe.Preco := fPDV_Rec.strParaFloat(edPreco.Text);
    end;
    if (edDesconto.Text <> '0,00') then
    begin
      if cbPercentual.Checked then
      begin
        calc_desc := fPDV_Rec.strParaFloat(edDesconto.Text);
        calc_desc := FMov.MovDetalhe.Preco * (calc_desc / 100);
        FMov.MovDetalhe.Desconto := calc_desc;
      end
      else
        FMov.MovDetalhe.Desconto:=fPDV_Rec.strParaFloat(edDesconto.Text);
    end;

    FMov.MovDetalhe.Status := '0';
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
    FMov.Free;
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
    tQtde := fPDV_Rec.strParaFloat(sQtde);
  except
    tQtde := fPDV_Rec.strParaFloat(StringReplace(sQtde,',','.',[rfReplaceAll]));;
  end;
  try
    tPrc := fPDV_Rec.strParaFloat(edPreco.Text);
  except
    tPrc := fPDV_Rec.strParaFloat(StringReplace(sPrc,',','.',[rfReplaceAll]));
  end;
  // TODO - Tratar o Desconto
  if (sDesc <> '') then
    tDesc := fPDV_Rec.strParaFloat(sDesc);
  if (tDesc > 0) then
  begin
    if (cbPercentual.Checked) then
    begin
      tDesc := (tDesc / 100)*(tPrc*tQtde);
      tDesc := (tPrc*tQtde)-tDesc;
    end
    else begin
      tDesc := ((tPrc*tQtde)-tDesc);
    end;
    edDesconto.Text:= FormatFloat('#,,,0.00',tDesc);
  end;
end;

procedure TfPdv.calculaTotalGeral();
var vTotGeral: Double;
   num_linha: Integer;
   //qtde_itens: Integer;
begin
  vTotGeral:= 0;
  vTotDesc := 0;
  num_item := 1;
  num_linha := dmPdv.sqLancamentos.RecNo;
  if not dmPdv.sqLancamentos.Active then
    dmPdv.sqLancamentos.Open;
  dmPdv.sqLancamentos.DisableControls;
  //dmPdv.sqLancamentos.Open;
  dmPdv.sqLancamentos.First;
  while not dmPdv.sqLancamentos.EOF do
  begin
    vTotGeral += dmPdv.sqLancamentosTOTALITEM.AsFloat;
    vTotDesc  += dmPdv.sqLancamentosVALOR_DESCONTO.AsFloat;
    num_item := dmPdv.sqLancamentosNITEMPED.AsInteger;
    num_item += 1;
    dmPdv.sqLancamentos.Next;
  end;
  if (num_linha > 0) then
  begin
    dmPdv.sqLancamentos.RecNo := num_linha;
    edTotalGeral.Text := FormatFloat('#,,,0.00', vTotGeral);
  end;
  lblNumItem.Caption:= IntToStr(num_item-1);
  dmPdv.sqLancamentos.EnableControls;
  edProduto.Text:='';
  if (edProduto.Enabled = True) then
    edProduto.SetFocus;
end;

procedure TfPdv.abreSqLanc();
var aSql: String;
begin
  dmPdv.sqLancamentos.Close;
  dmPdv.sqLancamentos.SQL.Clear;
  aSql := 'SELECT m.CODMOVIMENTO, m.DATAMOVIMENTO, ' +
   ' m.CODCLIENTE, m.CODNATUREZA, m.STATUS, m.CODUSUARIO, m.CODVENDEDOR,' +
   ' m.CODALMOXARIFADO, m.CONTROLE, m.OBS, m.USUARIOLOGADO, ' +
   ' m.DESCONTO, a.CODDETALHE, a.CONTROLE, a.CODPRODUTO, ' +
   ' a.QUANTIDADE, a.PRECO, a.ICMS, a.UN, a.QTDE_ALT, a.BAIXA, a.VALTOTAL, ' +
   ' a.DESCPRODUTO, a.CST, a.VALOR_ICMS, a.VLR_BASE, a.CODIGO, ' +
   ' a.STATUS, a.VLR_BASEICMS, a.PIPI, a.VIPI, a.CFOP, a.CSOSN, ' +
   ' a.VALOR_DESCONTO, a.VALOR_SEGURO, a.VALOR_OUTROS, a.OBS OBS_MD, ' +
   ' a.VALOR_PIS, a.VALOR_COFINS, a.II, a.CSTIPI, ' +
   ' a.CSTPIS, a.CSTCOFINS, a.PPIS, a.PCOFINS, a.NITEMPED,' +
   ' a.DESCONTO_BC, a.VLRBC_IPI, a.VLRBC_PIS, ' +
   ' a.VLRBC_COFINS, a.VLRTOT_TRIB, a.ORIGEM, a.NCM, a.ALIQ_CUPOM,' +
   ' a.CEST, p.ESTOQUEATUAL, p.COD_BARRA, p.TIPO, p.CODPRO,' +
   ' p.USA, p.LOCALIZACAO,  p.TIPOPRECOVENDA, p.UNIDADEMEDIDA, ' +
   ' p.ORIGEM, p.NCM, p.OBS OBS_PROD, p.CEST,' +
   ' p.PRECOATACADO, p.QTDEATACADO, ' +
   ' (COALESCE(A.VALTOTAL,0) - COALESCE(A.VALOR_DESCONTO, 0)) AS TOTALITEM ' +
   ' FROM MOVIMENTO m,  MOVIMENTODETALHE a,  PRODUTOS P ' +
   ' WHERE M.CODMOVIMENTO = a.CODMOVIMENTO ' +
   '   AND a.CODPRODUTO = P.CODPRODUTO ';
  aSql := aSql + '  AND M.CODMOVIMENTO = :PMOV';
  aSql := aSql + '   AND a.STATUS = ' + QuotedStr('0');

  dmPdv.sqLancamentos.SQL.Text := aSql;
  dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger:=codMov;
  dmPdv.sqLancamentos.Open;
end;

procedure TfPdv.adicionaProduto();
begin
    codproduto := fProdutoProc.codProduto;
    codPro     := fProdutoProc.codProd;
    preco      := fProdutoProc.precoVenda;
    precoAtacado:=fProdutoProc.precoVendaAtacado;
    qtdeAtacado:= fProdutoProc.qtdeAtacado;
    estoque    := fProdutoProc.estoque;
    proDesc    := fProdutoProc.produto;
    //edProdutoDescX.Text := proDesc;
    preencherDescItem(proDesc);
    edPreco.Text:= FormatFloat('#,,,0.00',preco);
    edPreco1.Text:= FormatFloat('#,,,0.00',preco);
    edQtde.Text:='1,00';
    edQtde1.Text:='1,00';
    edDesconto.Text:='0,00';
    edDesconto1.Text:='0,00';
    registrar_item();
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
  qtde_ped := 0;
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

procedure TfPdv.preencherDescItem(descItem: String);
var tam_desc: Integer;
begin
  edProdutoDesc.Lines.Clear;
  tam_desc := Length(descItem);
  edProdutoDesc.Lines.Add(copy(descItem,0,30));
  if (tam_desc > 30) then
  begin
    edProdutoDesc.Lines.Add(copy(descItem,30,60));
  end;
  if (tam_desc > 60) then
  begin
    edProdutoDesc.Lines.Add(copy(descItem,60,90));
  end;
  if (tam_desc > 90) then
  begin
    edProdutoDesc.Lines.Add(copy(descItem,90,120));
  end;
  edProdutoDesc.SelStart := 1;
end;

procedure TfPdv.buscaVendedor(codBarraV: String);
begin
  codVendedor := 0;
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  if (Length(codBarraV) < 7) then
  begin
    dmPdv.sqBusca.SQL.Text := 'SELECT CODUSUARIO, NOMEUSUARIO, SENHA ' +
      ' FROM USUARIO WHERE CODUSUARIO = ' + codBarraV;
  end
  else begin
    dmPdv.sqBusca.SQL.Text := 'SELECT CODUSUARIO, NOMEUSUARIO, SENHA ' +
      ' FROM USUARIO WHERE CODBARRA = ' + QuotedStr(codBarraV);
  end;
  dmPdv.sqBusca.Open;
  if (dmPdv.sqBusca.IsEmpty) then
  begin
    ShowMessage('Sem Cadastro do Vendedor no sistema');
    Exit;
  end;
  edVendedor.Text := IntToStr(dmPdv.sqBusca.FieldByName('CODUSUARIO').AsInteger);
  codVendedor := dmPdv.sqBusca.FieldByName('CODUSUARIO').AsInteger;
  edVendedorNome.Text := dmPdv.sqBusca.FieldByName('NOMEUSUARIO').AsString;
end;

procedure TfPdv.executaIntegracao(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
var ultimo_int : integer; // ultima venda enviada odoo
begin
  // executar integracao faturas se tiver acontecido venda
  //sleep(3000);
  {
  Memo2.Lines.LoadFromFile(dmpdv.path_exe + '\atsProduto.py');
  if fMovimentoProc.PythonEngine1.IsHandleValid then
  begin
    fMovimentoProc.PythonEngine1.ExecStrings((Memo2.Lines));
  end
  else writeln('invalid library handle!', dynlibs.GetLoadErrorStr);
  lblMSG.Caption:= 'Sucesso.';
  }
end;

procedure TfPdv.Executa(script: String);
var tamanho: Integer;
begin
  {
  MemoIntegra.Lines.LoadFromFile(dmPdv.path_script + '\' + script);
  if fMovimentoProc.PythonEngine1.IsHandleValid then
  begin
    fMovimentoProc.PythonEngine1.ExecStrings((MemoIntegra.Lines));
    tamanho := Length(MemoIntegra.Text);
    MemoIntegra.SelStart := tamanho;
    MemoIntegra.SetFocus;
  end
  else writeln('invalid library handle!', dynlibs.GetLoadErrorStr)
  }
end;

end.

