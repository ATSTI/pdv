unit uPdv;

{$mode objfpc}{$H+}

interface

uses
  Classes, windows,SysUtils, db, FileUtil, SynEdit, RTTICtrls, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, MaskEdit, DBGrids, ActnList,
  Menus, dateutils, uMovimento, uCompraCls, uUtil, uVendedorBusca,
  uClienteBusca, uPermissao, uComandaJuntar, uReceber,  Grids,
  ComCtrls, ACBrPosPrinter, MTProcs, strutils, fphttpclient, JsonTools, fpjson,
  uIntegraSimples, crt;

type

  { TfPdv }

  TfPdv = class(TForm)
    ACBrPosPrinter1: TACBrPosPrinter;
    acReceber: TAction;
    acFechar: TAction;
    acProcurar: TAction;
    acNova: TAction;
    acExcluirItemPedido: TAction;
    acQuantidade: TAction;
    acConsultaItem: TAction;
    acComandaJuntar: TAction;
    acEnviarPedido: TAction;
    ActionList1: TActionList;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    btnInfo: TBitBtn;
    btnNovo: TBitBtn;
    btnProdutoProc: TBitBtn;
    btnReceber: TBitBtn;
    btnVendas: TBitBtn;
    btnVnd1: TBitBtn;
    btnVnd2: TBitBtn;
    btnVnd3: TBitBtn;
    btnVnd4: TBitBtn;
    btnVnd5: TBitBtn;
    btnVnd6: TBitBtn;
    btnVnd7: TBitBtn;
    btnVnd8: TBitBtn;
    cbPercentual: TCheckBox;
    dsProdProc: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    dsLanc: TDataSource;
    edCaixa: TEdit;
    edCliente: TEdit;
    edClienteNome: TEdit;
    edDesconto: TMaskEdit;
    edLocalizacao: TMemo;
    edProduto_copia: TEdit;
    edMotivo: TEdit;
    edPreco: TMaskEdit;
    edProdNao: TEdit;
    edPreco1: TMaskEdit;
    edProduto: TEdit;
    edProdutoDesc: TMemo;
    edQtde: TMaskEdit;
    edQtde1: TMaskEdit;
    edTotalGeral: TMaskEdit;
    edProdutoDescX: TEdit;
    edVendedor: TEdit;
    edVendedorNome: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edBuscaDetalhe: TLabeledEdit;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblMSG: TLabel;
    lblPedido: TLabel;
    lblProdBusca: TLabel;
    Label9: TLabel;
    lblNumItem: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblSenha: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    memoImp: TMemo;
    memoDevolucao: TMemo;
    MemoIntegra: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    pnBotoesSistema: TPanel;
    pnComanda: TPanel;
    pnLogo: TPanel;
    pnIntegra: TPanel;
    pnPreco: TPanel;
    pnProdutoNaoLocalizado: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pnProdBusca: TPanel;
    pnAltera: TPanel;
    Panel4: TPanel;
    pnProdutoDescricao: TPanel;
    Panel9: TPanel;
    pnInfo: TPanel;
    pnQtde: TPanel;
    pnTroca: TPanel;
    PopupMenu1: TPopupMenu;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TIButton2: TTIButton;
    procedure acComandaJuntarExecute(Sender: TObject);
    procedure acConsultaItemExecute(Sender: TObject);
    procedure acEnviarPedidoExecute(Sender: TObject);
    procedure acExcluirItemPedidoExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
    procedure acNovaExecute(Sender: TObject);
    procedure acProcurarExecute(Sender: TObject);
    procedure acQuantidadeExecute(Sender: TObject);
    procedure acReceberExecute(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure btnProdutoProcClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure btnVnd1Click(Sender: TObject);
    procedure btnVnd2Click(Sender: TObject);
    procedure btnVnd3Click(Sender: TObject);
    procedure btnVnd4Click(Sender: TObject);
    procedure btnVnd5Click(Sender: TObject);
    procedure btnVnd6Click(Sender: TObject);
    procedure btnVnd7Click(Sender: TObject);
    procedure btnVnd8Click(Sender: TObject);
    procedure cbPercentualClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edClienteKeyPress(Sender: TObject; var Key: char);
    procedure edDescontoKeyPress(Sender: TObject; var Key: char);
    procedure edPreco1KeyPress(Sender: TObject; var Key: char);
    procedure edPrecoChange(Sender: TObject);
    procedure edPrecoKeyPress(Sender: TObject; var Key: char);
    procedure edProdutoKeyPress(Sender: TObject; var Key: char);
    procedure edQtde1KeyPress(Sender: TObject; var Key: char);
    procedure edQtdeChange(Sender: TObject);
    procedure edQtdeKeyPress(Sender: TObject; var Key: char);
    procedure edVendedorKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure TIButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure procFormShow;
  private
    ch_cp: String;
    e_comanda: String;
    statusPedido: Integer;
    consultaItem: String;
    ultimo_pedido: Integer;
    codproduto: Integer;
    fotoproduto : string;
    codPro: String;
    proDesc: String;
    pProd : string;
    num_pedido: String;
    precoL: Double;
    precoAtacadoL: Double;
    qtdeAtacadoL: Double;
    estoque: Double;
    vTotDesc: Double;
    vTotGeral: Double;
    caixa_local: Integer; // Sessao Caixa
    codCliente: Integer;
    codCaixa: Integer; // cod Usuario
    codVendedor: Integer;
    codVendedorAnterior : Integer;
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
    procedure buscaPedidoComanda(codComanda: String);
    procedure trocaDevolucao;
    procedure imprimirCupomTroca;
    procedure imprimirAcbr;
    procedure imprime_envio;
    procedure buscaProduto();


  public
     codMov: Integer;
     pSemValor : integer;
     pStatus : integer;
     bmp: TBitmap;
  end;

var
  fPdv: TfPdv;
  FMov: TMovimento;

implementation

uses updv_rec,udmpdv, uMovimentoProc, uProdutoProc, uIntegracaoOdoo,uAbrirCaixa2,uabrircaixa,usangria,umsgpromo;

{$R *.lfm}

{ TfPdv }

procedure TfPdv.edClienteKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if (statusPedido > 0) then
    begin
      ShowMessage('Pedido ja finalizado.');
      Exit;
    end;
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

procedure TfPdv.edDescontoKeyPress(Sender: TObject; var Key: char);
var calc_desc: Double;
begin
  if Key = #13 then
  begin
    Key := #0;
    // desconto
    //edDesconto.Text:=edDesconto.Text;
    if (dmPdv.descontoLivre > 0) then
    begin
      if (edDesconto.Text <> '0,00') then
      begin
        if (cbPercentual.Checked) then
        begin
          calc_desc := fPDV_Rec.strParaFloat(edDesconto.Text);
          if calc_desc > 0 then
            calc_desc := calc_desc / 100;
        end
        else begin
          calc_desc := fPDV_Rec.strParaFloat(edDesconto.Text);
          calc_desc := calc_desc / (fPDV_Rec.strParaFloat(edQtde1.Text) * fPDV_Rec.strParaFloat(edPreco1.Text));
        end;
        if (calc_desc > dmPdv.descontoLivre) then
        begin
          // TODO aqui pedirá senha GERENTE
          fPermissao.Permissao_Fazer := 'DESCONTO';
          fPermissao.ShowModal;
          if (fPermissao.Permissao_Fazer = 'NAO') then
          begin
            edDesconto.Text := '0,00';
            ShowMessage('Sem Permissao para este desconto.');
            Exit;
          end;
        end;
      end;
    end;
    alterar_item();
    calculaTotalGeral();
    edProduto.SetFocus;
    pnAltera.Visible:=False;
  end;

end;


procedure TfPdv.edPreco1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if(dmPdv.MudarPreco = 'NAO')then
    begin
      if (dmPdv.precoLivre <> 'LIVRE') then
      begin
        if (edPreco.Text <> edPreco1.Text) then
        begin
          fPermissao.Permissao_Fazer := 'PRECO';
          fPermissao.ShowModal;
          if (fPermissao.Permissao_Fazer = 'NAO') then
          begin
            ShowMessage('Sem Permissao para alterar o preço.');
            Exit;
          end;
        end;
      end;
    end;
    edPreco.Text := edPreco1.Text;
    //precoL := fPDV_Rec.strParaFloat(edPreco.Text);
    edDesconto.SetFocus;
  end;

end;

procedure TfPdv.edPrecoChange(Sender: TObject);
begin
  if (edPreco.Text <> '0,00') then
    calculaTotal();
end;

procedure TfPdv.edPrecoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    precoL := fPDV_Rec.strParaFloat(edPreco.Text);
    alterar_item();
    calculaTotalGeral();
  end;
end;

procedure TfPdv.DBGrid1CellClick(Column: TColumn);
begin
  if (dmPdv.sqLancamentos.Active) then
  begin
    codDet := dmPdv.sqLancamentosCODDETALHE.AsInteger;
    if (dmPdv.sqLancamentosCOD_BARRA.AsString <> '') then
      edProduto.Text := dmPdv.sqLancamentosCOD_BARRA.AsString
    else
      edProduto.Text := dmPdv.sqLancamentosCODPRO.AsString;
    if (dmpdv.tipo_buscaProd = 'CODPRO') then
    begin
      edProduto.Text := dmPdv.sqLancamentosCODPRO.AsString;
    end;
    edQtde.Text    := FormatFloat('#,,,0.00',dmPdv.sqLancamentosQUANTIDADE.AsFloat);
    edPreco.Text   := FormatFloat('#,,,0.00',dmPdv.sqLancamentosPRECO.AsFloat);
    precoL         := dmPdv.sqLancamentosPRECO.AsFloat;
    precoAtacadoL   := dmPdv.sqLancamentosPRECOATACADO.AsFloat;
    qtdeAtacadoL    := dmPdv.sqLancamentosQTDEATACADO.AsFloat;
    edDesconto.Text:= FormatFloat('#,,,0.00',dmPdv.sqLancamentosDESCONTO.AsFloat);
    edLocalizacao.Text:= dmPdv.sqLancamentosLOCALIZACAO.AsString;

    buscaVendedor(IntToStr(dmPdv.sqLancamentosCODVENDEDOR.AsInteger));
    preencherDescItem(dmPdv.sqLancamentosDESCPRODUTO.AsString);
  end;
end;

procedure TfPdv.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);

begin


  {alterando a cor da fonte dos produtos cancelados}
  //if dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat = 0 then
  if   dmPdv.sqLancamentosPRECO.AsFloat = 0 then
  //if cdsProdutosCANCELADO.AsString=’S’ then {substituir pela sua condição}
      TDBGrid(Sender).Canvas.Font.Color:=clRed
          else TDBGrid(Sender).Canvas.Font.Color:=clBlack;



  {atualizando a visualização do DBGrid}
  DBGrid1.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

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
    if (consultaItem = 'NAO') then
    begin
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
    if (consultaItem = 'NAO') then
    begin
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

end;

procedure TfPdv.btnProdutoProcClick(Sender: TObject);
begin
  if (statusPedido > 0) then
  begin
    ShowMessage('Pedido ja finalizado/cancelado.');
    Exit;
  end;
  fProdutoProc.ShowModal;
  if fProdutoProc.codProduto > 0 then
  begin
    codproduto := fProdutoProc.codProduto;
    codPro     := fProdutoProc.codProd;
    edProduto.Text := codPro;
    precoL     := fProdutoProc.precoVenda;
    precoAtacadoL:=fProdutoProc.precoVendaAtacado;
    qtdeAtacadoL:= fProdutoProc.qtdeAtacado;
    estoque    := fProdutoProc.estoque;
    proDesc    := fProdutoProc.produto;
    //edProdutoDescX.Text := proDesc;
    preencherDescItem(proDesc);
    edPreco.Text:= FormatFloat('#,,,0.00',precoL);
    edQtde.Text:='1,00';
    edProduto.Text := codPro;
    edProduto.SetFocus;
    adicionaProduto();
  end;
end;

procedure TfPdv.BitBtn2Click(Sender: TObject);
begin
  if (statusPedido > 0) then
  begin
    ShowMessage('Pedido ja finalizado/cancelado.');
    Exit;
  end;
  if (edCliente.Text <> '') then
    fClienteBusca.cCodCliente:=StrToInt(edCliente.Text);
  fClienteBusca.ShowModal;
  edClienteNome.Text := fClienteBusca.cNomeCliente;
  codCliente := fClienteBusca.cCodCliente;
  edCliente.Text := IntToStr(codCliente);
end;

procedure TfPdv.BitBtn3Click(Sender: TObject);
begin
  //if (statusPedido > 0) then
  //begin
  //  ShowMessage('Pedido ja finalizado/cancelado.');
  //  Exit;
  //end;
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

procedure TfPdv.acReceberExecute(Sender: TObject);
begin
  if(codMov = 0) then
  begin
    exit;
  end;
  dmPdv.sqLancZero.Close;
  dmPdv.sqLancZero.Params[0].AsInteger:= CodMov;
  dmPdv.sqLancZero.Open;
  pSemValor := dmPdv.sqLancZeroCODMOVIMENTO.AsInteger;
  if(pSemValor > 0 )then
  begin
    if  MessageDlg('Confirma Receber com Produtos Sem Preços ?',
    mtConfirmation, [mbYes, mbNo],0) = mrNo then exit;
  end;

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
  if ((fPDV_Rec.vStatus = 1) and
    (dmPdv.usaComanda = 0)) then
  begin
    //controlaPedidos(codMov, 1, 1);
    buscaPedidosAbertoCaixa(codMov);
    {if (qtde_ped = 0) then
      btnNovo.Click
    else
      btnVnd1.Click;} //03/09/22019
    statusPedido:=9;
    dmPdv.sqLancamentos.Close;
    btnNovo.SetFocus;
  end;
  if (dmPdv.usaComanda > 0) then
  begin
     pnComanda.Caption := '';
     abrePedido(0);
     statusPedido:=9;
  end;
  Memo2.Text := fPDV_Rec.v_log;
end;

procedure TfPdv.BitBtn10Click(Sender: TObject);
begin
  edQtde.Text:=edQtde1.Text;
  if (edPreco.Text <> edPreco1.Text) then
  begin
    if (dmPdv.precoLivre <> 'LIVRE') then
    begin
      fPermissao.Permissao_Fazer := 'PRECO';
      fPermissao.ShowModal;
      if (fPermissao.Permissao_Fazer <> 'NAO') then
      begin
        edPreco.Text:=edPreco1.Text;
      end;
    end
    else begin
      edPreco.Text := edPreco1.Text;
    end;
  end;

  edDesconto.Text:=edDesconto.Text;
  alterar_item();
  calculaTotalGeral();
  fPermissao.Permissao_Fazer := 'PRECO';
  edProduto.SetFocus;
  pnAltera.Visible:=False;


  dmPdv.sqLancZero.Close;
  dmPdv.sqLancZero.Params[0].AsInteger:= CodMov;
  dmPdv.sqLancZero.Open;
  pSemValor := dmPdv.sqLancZeroCODMOVIMENTO.AsInteger;
  if(pSemValor > 0 )then
     Label8.Caption:= 'LINHAS EM VERMELHO  PRODUTOS PREÇO  0,00'
  else
     Label8.Caption:= '...';
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

procedure TfPdv.BitBtn13Click(Sender: TObject);
begin
  pnTroca.Visible := False;
end;

procedure TfPdv.acFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfPdv.acExcluirItemPedidoExecute(Sender: TObject);
begin
  fPermissao.Permissao_Fazer := 'EXCLUIR';
  fPermissao.permCodMov:=codMov;
  fPermissao.permCodDet:=dmPdv.sqLancamentosCODDETALHE.AsInteger;
  fPermissao.itemExcP := dmPdv.sqLancamentosDESCPRODUTO.AsString;
  fPermissao.itemExcC := dmPdv.sqLancamentosCODPRO.AsString;
  fPermissao.ShowModal;
  buscaPedidosAbertoCaixa(codMov);
  abrePedido(codMov);
  calculaTotalGeral();
end;

procedure TfPdv.acConsultaItemExecute(Sender: TObject);
begin
  statusPedido := 0;  //manoel
  if (edProduto.Color = clYellow) then
  begin
    edProduto.Color := $00E1E1E1;
    consultaItem := 'NAO';
    pnProdBusca.Visible:=False;
    abrePedido(ultimo_pedido);

  end
  else begin
    edProduto.Color := clYellow;
    consultaItem := 'SIM';
    pnProdBusca.Visible:=True;
  end;
  edProduto.SetFocus;
end;

procedure TfPdv.acEnviarPedidoExecute(Sender: TObject);
begin
  // mudo o status do pedido
  ch_cp := FormatDateTime('ddmmyyMMss', Now);
  ch_cp := Copy(ch_cp,7,4);
  dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 11 ' +
    ' , NFE = ' + QuotedStr(ch_cp) +
    ' WHERE CODMOVIMENTO  = ' + IntToStr(codMov));
  dmPdv.sTrans.Commit;
  if (dmPdv.CupomImp = 'Texto') then
    if not (DirectoryExists(ExtractFilePath(dmPdv.path_imp))) then
      CreateDir(ExtractFilePath(dmPdv.path_imp));
  imprime_envio;
  if (dmPdv.CupomImp <> 'Texto') then
    imprimirAcbr;
end;

procedure TfPdv.acComandaJuntarExecute(Sender: TObject);
begin
  fComandaJuntar.ShowModal;
end;

procedure TfPdv.acNovaExecute(Sender: TObject);
begin
  //if qtde_ped = 8 then
  //begin
  //  ShowMessage('Já existe 8 pedidos abertos, nao pode abrir mais.');
  //  Exit;
  //end;
  if (dmPdv.usaComanda = 0) then
  begin
    iniciarVenda();
    buscaPedidosAbertoCaixa(codMov);
    //controlaPedidos(codMov, 0, 0);
    lblPedido.Caption:=IntToStr(codMov);
    edProduto.Text:='';
    edProduto.SetFocus;
  end
  else begin
    edProduto.Enabled:= True;
    edProduto.Text:='';
    edProduto.SetFocus;
  end;
end;

procedure TfPdv.acProcurarExecute(Sender: TObject);
begin
  if (dmPdv.IbCon.Connected = False) then
    dmPdv.IbCon.Connected := True;
  if (dmPdv.usaComanda > 0) then
     pnComanda.Caption := '';

  if(dmPdv.nomeCaixa = 'FECHADO')then
  begin
    fMovimentoProc.btnSangria.Enabled := False;
    fMovimentoProc.btnReforco.Enabled := False;
  end;

  fMovimentoProc.ShowModal;
  if (fMovimentoProc.codMovimentoProc > 0) then
  begin
    codMov:=fMovimentoProc.codMovimentoProc;
    lblPedido.Caption:=IntToStr(codMov);
    dmPdv.sqLancamentos.Close;
    dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger:=codMov;
    dmPdv.sqLancamentos.Open;
    statusPedido := dmPdv.sqLancamentosSTATUS.AsInteger;
    codDet:=dmPdv.sqLancamentosCODDETALHE.AsInteger;
    edProduto.Text := dmPdv.sqLancamentosCODPRO.AsString;
    //edProdutoDescX.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
    preencherDescItem(dmPdv.sqLancamentosDESCPRODUTO.AsString);
    edQtde.Text    := FormatFloat('#,,,0.00',dmPdv.sqLancamentosQUANTIDADE.AsFloat);
    edPreco.Text   := FormatFloat('#,,,0.00',dmPdv.sqLancamentosPRECO.AsFloat);
    edDesconto.Text:= FormatFloat('#,,,0.00',dmPdv.sqLancamentosDESCONTO.AsFloat);
    codVendedor := dmPdv.sqLancamentosCODVENDEDOR.AsInteger;
    if codVendedor = 0 then
       codVendedor := dmPdv.vendedor_padrao;
    edVendedor.Text:= IntToStr(codVendedor);
    codCliente := dmpdv.sqLancamentosCODCLIENTE.AsInteger;
    Caixa_Local := dmpdv.sqLancamentosCODALMOXARIFADO.AsInteger;
    if (codCliente = 0) then
    begin
      codCliente := dmPdv.clientePadrao;
    end;
    edCliente.Text := IntToStr(codCliente);
    fClienteBusca.cCodCliente := StrToInt(edCliente.Text);
    fClienteBusca.BuscaCliente;
    edClienteNome.Text := fClienteBusca.cNomeCliente;
    codCliente := fClienteBusca.cCodCliente;
    if (dmPdv.usaComanda > 0) then
      pnComanda.Caption := edClienteNome.Text;
    //edProdutoDescX.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
    //controlaPedidos(codMov, 0, 0);
    buscaPedidosAbertoCaixa(codMov);
    buscaVendedor(edVendedor.Text);
    codVendedorAnterior := codVendedor;
    calculaTotalGeral();
  end;
end;

procedure TfPdv.acQuantidadeExecute(Sender: TObject);
var i: Integer;
begin
  if ((edProduto.Text = '') and (edProduto_copia.Text = '')) then
  begin
    ShowMessage('Selecione o ITEM.');
    Exit;
  end;

  if (edProduto.Text = '') then
  begin
    edProduto.Text := edProduto_copia.Text;
  end;

  if (statusPedido > 0) then
  begin
    ShowMessage('Pedido ja finalizado.');
    Exit;
  end;
  // 23/07/2022 vou buscar o produto novamente, pois, preciso dos precos
 // buscaProduto();
 if (dmpdv.tipo_buscaProd = 'CODPRO') then
  begin
    fProdutoProc.busca(edProduto.Text, '','', False);
  end
  else begin
    if not TryStrToInt(Copy(edProduto.Text,0,1),i) then
    begin
      fProdutoProc.busca('', '',edProduto.Text, False);
    end
    else if Length(edProduto.Text) > 7 then
      fProdutoProc.busca('',edProduto.Text, '', False)
    else
      fProdutoProc.busca(edProduto.Text, '','', False);
  end;
  qtdeAtacadoL := fProdutoProc.qtdeAtacado;
  precoAtacadoL:= fProdutoProc.precoVendaAtacado;
  precoL := fProdutoProc.precoVenda;
  //consultaItem := 'SIM';
  pnAltera.Visible:=True;
  edQtde1.Enabled:= True;
  edQtde.Enabled:= True;
  edQtde1.Text := edQtde.Text;
  edPreco1.Text:= FormatFloat('#,,,0.00',precoL);
  edPreco.Text:= FormatFloat('#,,,0.00',precoL);
  edDesconto.Text:=edDesconto.Text;
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
  PopupMenu1.PopUp;
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

procedure TfPdv.cbPercentualClick(Sender: TObject);
begin
  edDesconto.SetFocus;
end;

procedure TfPdv.edProdutoKeyPress(Sender: TObject; var Key: char);
var achou : string;
begin
  if (dmPdv.IbCon.Connected = False) then
    dmPdv.IbCon.Connected := True;
  if ((Key = #13) and (edProduto.Text <> '')) then
  begin
    Key := #0;
    buscaProduto();
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

procedure TfPdv.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if dmpdv.empresa_integra <> 'ATS' then
  begin
    dmpdv.integra_caixa;
    dmpdv.gera_integra_caixa_mov;
    dmpdv.integra_caixa_mov;
  end;
end;

procedure TfPdv.FormCreate(Sender: TObject);
begin
  DBGrid1.Columns[2].Width := dmPdv.tamanhoDescProd;
  DBGrid1.Columns[1].Width := dmPdv.tamanhoCodProd;
  Image1.Picture.LoadFromFile('logo.png');
end;

procedure TfPdv.FormShow(Sender: TObject);
begin
  procFormShow;
end;



procedure TfPdv.Image3Click(Sender: TObject);
begin
  finalizarVenda();
  fPDV_Rec.ShowModal;
  iniciarVenda();
end;

procedure TfPdv.MenuItem10Click(Sender: TObject);
begin
  if MessageDlg('Confirma:', 'Confirma a ALTERAÇAO no VENDEDOR do pedido :  ',
     mtConfirmation,  [mbYes, mbNo, mbIgnore],0) = mrYes then
   begin
     dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET CODVENDEDOR = ' + edVendedor.Text +
      ' , HIST_MOV = ' + QuotedStr('VENDEDOR ERA :' + IntToStr(codVendedorAnterior) + ', ALTERADO para ' +
       edVendedor.Text + ' em : ' + FormatDateTime('dd/mm/yyyy hh:MM', Now)) +
      ' WHERE CODMOVIMENTO  = ' + IntToStr(codMov));
     try
       dmPdv.sTrans.Commit;
     except
       dmpdv.sTrans.Rollback;
       ShowMessage('Erro para finalizar a venda.');
     end;
   end;
end;

procedure TfPdv.MenuItem13Click(Sender: TObject);
begin
     dmpdv.IbCon.ExecuteDirect('UPDATE PRODUTOS SET FOTOPRODUTO = null WHERE FOTOPRODUTO ='+ QuotedStr('Null'));
     dmpdv.sTrans.Commit;
     ShowMessage('Promoção Corrigida');
end;

procedure TfPdv.MenuItem5Click(Sender: TObject);
begin
  if (statusPedido > 0) then
  begin
    ShowMessage('Pedido ja finalizado.');
    Exit;
  end;

  pnTroca.Visible:=True;
end;

procedure TfPdv.MenuItem6Click(Sender: TObject);
begin
  pnInfo.Visible:=True;
  //fExecutaIntegracao.ShowModal;
end;

procedure TfPdv.MenuItem8Click(Sender: TObject);
begin
  fRecebimento.ShowModal;
end;

procedure TfPdv.TIButton2Click(Sender: TObject);
begin
  if (edMotivo.Text = '') then
  begin
    ShowMessage('Informe o Motivo');
    exit;
  end;
  trocaDevolucao;
  btnNovo.Click;
  pnTroca.Visible := False;
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

  dmPdv.sqUltimoLanc.Close;
  dmPdv.sqUltimoLanc.Params[0].AsInteger:= apCodMov;
  dmPdv.sqUltimoLanc.Open;
  pStatus := dmPdv.sqUltimoLancSTATUS.AsInteger;

  if(pStatus = 1 )then
  begin
    edProduto.Text:= '';
    lblPedido.Caption:= '';
    edTotalGeral.Text:= '';
    exit;
  end;
  edProduto_copia.Text:= '';
  statusPedido:=0;
  edProdutoDesc.Lines.Clear;
  edQtde.Text:='0';
  edPreco.Text:='0';
  fProdutoProc.num_pedidos := fProdutoProc.num_pedidos + 1;
  ultimo_pedido := apCodMov;
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
    edLocalizacao.Text:= dmPdv.sqLancamentosLOCALIZACAO.AsString;
    buscaVendedor(IntToStr(dmPdv.sqLancamentosCODVENDEDOR.AsInteger));
    codCliente := dmpdv.sqLancamentosCODCLIENTE.AsInteger;
    edCliente.Text := IntToStr(codCliente);
    edClienteNome.Text := dmpdv.sqLancamentosNOMECLIENTE.AsString;
    //edProdutoDescX.Text:= dmPdv.sqLancamentosDESCPRODUTO.AsString;
    //controlaPedidos(codMov, 0, 0);
    if (dmPdv.sqLancamentosSTATUS.AsInteger = 2) then
    begin
      statusPedido:=2;
    end;
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
  caixa_local := StrToInt(dmPdv.ccusto);
  if (dmPdv.IbCon.Connected = False) then
    dmPdv.IbCon.Connected := True;
  if (dmPdv.nomeCaixa <> 'FECHADO') then
  begin
    statusPedido:=0;
    num_item:=1;
    codVendedor := 0;
    edPreco.Text := '0,00';
    lblNumItem.Caption := '0';
    edProduto.Enabled := True;
    edProdutoDesc.Lines.Clear;
    edProdutoDesc.Lines.Add('Produto:');
    if (dmPdv.usaComanda = 0) then
    begin
      edCliente.Text := IntToStr(dmpdv.clientePadrao);
      codCliente := dmpdv.clientePadrao;
      edClienteNome.Text := 'Consumidor';
    end;
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
      if (codCliente = 0) then
        codCliente := dmpdv.clientePadrao;
      FMov.CodCliente  := codCliente;
      FMov.CodOrigem   := StrToInt(dmPdv.idcaixa);
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
  if(CodMov = 0 )then
  begin
    ShowMessage('Atenção Iniciar uma Venda Para Continuar. ' );
    edProduto.text := '';
    exit;
  end;

  dmPdv.sqUltimoLanc.Close;
  dmPdv.sqUltimoLanc.Params[0].AsInteger:= CodMov;
  dmPdv.sqUltimoLanc.Open;
  pStatus := dmPdv.sqUltimoLancSTATUS.AsInteger;
  // manoel
  if(pStatus = 1 )then
  begin
    edProduto.Text:= '';
    lblPedido.Caption:= '';
    edTotalGeral.Text:= '';
    edQtde.Text:= '';
    edPreco.Text:= '';
    lblNumItem.Caption:= '';
    exit;
  end;
  { manoel
  if not dmPdv.sqLancamentos.Active then
  begin
    if dmPdv.sqLancamentosSTATUS.AsInteger > 0 then
    begin
      ShowMessage('Pedido já finalizado.');
      Exit;
    end;
  end;
  }
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
  calc_atacado: Double;
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
    if ((qtdeAtacadoL > 0) and (qAtac >= qtdeAtacadoL)) then
    begin
      FMov.MovDetalhe.Ii    := precoL;
      // o preco de atacado e somente para as qtdes de atacado
      // ex.: qtde atacado = 10, e comprei 12, somente 10 com  preco de atacado
      // as outras 2 unidades preco normal

      // verifico se tem unidades fora da qtde atacado
      try
        calc_atacado := Trunc(qAtac) mod Trunc(qtdeAtacadoL);
      except
        calc_atacado := 0;
        precoAtacadoL := precoL;
      end;
      if (calc_atacado > 0) then
      begin
        calc_atacado := ((calc_atacado * precoL) + ((qAtac - calc_atacado) * precoAtacadoL)) / qAtac;
        precoAtacadoL := calc_atacado;
      end;
      FMov.MovDetalhe.Preco := precoAtacadoL;
      edPreco.Text := FormatFloat('#,,,0.00',precoAtacadoL);
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
        calc_desc := (FMov.MovDetalhe.Preco*FMov.MovDetalhe.Qtde) * (calc_desc / 100);
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
var
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
  asql := aSql + ' AND m.CODUSUARIO = ' + dmPdv.varLogado;
  aSql := aSql + '   AND a.STATUS = ' + QuotedStr('0');

  dmPdv.sqLancamentos.SQL.Text := aSql;
  dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger:=codMov;
  dmPdv.sqLancamentos.Open;
end;

procedure TfPdv.adicionaProduto();
begin
    fotoproduto:= dmPdv.sqBusca.FieldByName('FOTOPRODUTO').AsString;
    if(fotoproduto <> '' )then
    begin
      fMsgPromo.ShowModal;
    end ;
    edProduto_copia.Text := fProdutoProc.codProd;
    codproduto := fProdutoProc.codProduto;
    codPro     := fProdutoProc.codProd;
    precoL     := fProdutoProc.precoVenda;
    precoAtacadoL:=fProdutoProc.precoVendaAtacado;
    qtdeAtacadoL:= fProdutoProc.qtdeAtacado;
    estoque    := fProdutoProc.estoque;
    proDesc    := fProdutoProc.produto;
    //edProdutoDescX.Text := proDesc;
    preencherDescItem(proDesc);
    edPreco.Text:= FormatFloat('#,,,0.00',precoL);
    edPreco1.Text:= FormatFloat('#,,,0.00',precoL);
    edQtde.Text  := FormatFloat('#,,,0.000', fProdutoProc.quantidadeVenda);
    edQtde1.Text := FormatFloat('#,,,0.000', fProdutoProc.quantidadeVenda);
    edDesconto.Text:='0,00';
    edDesconto.Text:='0,00';
    registrar_item();

    dmPdv.sqLancZero.Close;
    dmPdv.sqLancZero.Params[0].AsInteger:= CodMov;
    dmPdv.sqLancZero.Open;
    pSemValor := dmPdv.sqLancZeroCODMOVIMENTO.AsInteger;

    if(pSemValor > 0 )then
       Label8.Caption:= 'LINHAS EM VERMELHO  PRODUTOS PREÇO  0,00'
    else
      Label8.Caption:= '...' ;
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
   ver_str: String;
begin
  if (dmPdv.IbCon.Connected = False) then
    dmPdv.IbCon.Connected := True;
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
  //if (dmPdv.usaComanda > 0) then
  //begin
  //  ver_str := 'SELECT CODMOVIMENTO FROM MOVIMENTO ' +
  //    ' WHERE STATUS = 0 AND CODALMOXARIFADO = ' + dmPdv.ccusto +
  //    '   AND CODCLIENTE = ' + edProduto.Text;
  //  dmPdv.sqBusca.SQL.Text := ver_str;
  //end
  begin
    dmPdv.sqBusca.SQL.Text := 'SELECT CODMOVIMENTO FROM MOVIMENTO ' +
      ' WHERE STATUS = 0 AND CODNATUREZA = 3 ' +
      ' AND CODALMOXARIFADO = ' + dmPdv.ccusto +
      ' AND CODUSUARIO = ' + dmPdv.varLogado +
      ' ORDER BY CODMOVIMENTO DESC';
  end;
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
  if (codBarraV = '0') then
  begin
    Exit;
  end;
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
  memoImp.Lines.LoadFromFile(dmpdv.path_exe + '\atsProduto.py');
  if fMovimentoProc.PythonEngine1.IsHandleValid then
  begin
    fMovimentoProc.PythonEngine1.ExecStrings((memoImp.Lines));
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

procedure TfPdv.buscaPedidoComanda(codComanda: String);
begin
  // coloquei pra fechar a conexao e abrir novamente, pois
  // qdo recebia no caixa nao atualizava no terminal
  //dmPdv.IbCon.Connected:=False;
  //dmPdv.IbCon.Connected:=False;
  // verifico se ja existe um pedido pra esta comanda
  // se nao cria
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT CODMOVIMENTO FROM MOVIMENTO ' +
    ' WHERE STATUS = 0 AND CODALMOXARIFADO = ' + dmPdv.ccusto +
    '   AND CODCLIENTE = ' + edProduto.Text;
  dmPdv.sqBusca.Open;
  if not dmpdv.sqBusca.IsEmpty then
  begin
    e_comanda:='S';
    //numeroComanda := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
    CodMov:= dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
  end
  else begin
    fClienteBusca.cCodCliente := StrToInt(codComanda);
    fClienteBusca.BuscaCliente;
    if fClienteBusca.cNomeCliente = '' then
    begin
      e_comanda:='N';
      exit;
    end
    else begin
      e_comanda:='V';
      if MessageDlg('COMANDA/MESA VAZIA', 'Incluir ?', mtConfirmation,
        [mbYes, mbNo],0) = mrYes then
      begin
        e_comanda:='S';
        codCliente := StrToInt(codComanda);
        edCliente.Text := codComanda;
        edClienteNome.Text :=  'Comanda ' + codComanda;
        pnComanda.Caption := 'Comanda ' + codComanda;
        //btnNovo.Click;
        iniciarVenda(); // 03/09/2019  // 27/01/2020
        buscaPedidosAbertoCaixa(codMov);
        //controlaPedidos(codMov, 0, 0);
        lblPedido.Caption:=IntToStr(codMov);
        edProduto.Text:='';
        edProduto.SetFocus;
      end;
    end;
  end;
end;

procedure TfPdv.trocaDevolucao;
var
   fCpr : TCompraCls;
   num_cp: Integer;
   postJson : TJSONObject;
   httpClient : TFPHttpClient;
   fInteg: TfIntegracaoOdoo;
   responseData: String;
begin
  caixa_local := StrToInt(dmPdv.ccusto);
  if (statusPedido > 0) then
  begin
    ShowMessage('Pedido ja finalizado.');
    Exit;
  end;
  num_cp := dmPdv.busca_serie('I');
  // colocr status = 9
  // codnatureza = 1 - entrada

  // chave cupom
  ch_cp := FormatDateTime('ddmmyyMMss', Now);
  ch_cp := Copy(ch_cp,7,4);

  dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 9 ' +
    ' , CODNATUREZA = 1 ' +
    ' , HIST_MOV = ' + QuotedStr(edMotivo.Text) +
    ' , NFE = ' + QuotedStr(ch_cp) +
    ' WHERE CODMOVIMENTO  = ' + IntToStr(codMov));

  // criar uma compra pra finalizar esta entrada no estoque
  fCpr := TCompraCls.Create;
  Try
    dmPdv.sTrans.Active := True;
    fCpr.CodMov := codMov;
    fCpr.Caixa  := caixa_local;
    fCpr.CodCCusto   := caixa_local;
    fCpr.CodFornecedor  := 0;
    fCpr.CodUsuario  := codVendedor;
    fCpr.CodComprador := codVendedor;
    fCpr.DataCompra   := Now;
    fCpr.DataVcto    := Now;
    fCpr.Desconto    := 0;
    fCpr.NParcela    := 1;
    fCpr.NDoc        := ch_cp;
    fCpr.Valor       := vTotGeral;
    fCpr.NotaFiscal  := num_cp;
    fCpr.Serie       := 'I';
    fCpr.inserirCompra(0);
  finally
    fCpr.Free;
  end;
  dmPdv.sTrans.Commit;
  if (dmPdv.CupomImp <> 'Texto') then
    if not (DirectoryExists(ExtractFilePath(dmPdv.path_imp))) then
      CreateDir(ExtractFilePath(dmPdv.path_imp));
  imprimirCupomTroca;
  if (dmPdv.CupomImp = 'Texto') then  // BARRA
    imprimirAcbr;


  // devolucao  odooo;

  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    httpClient := TFPHttpClient.Create(Nil);
    postJson := TJSONObject.Create;
    try
      postJson.Add('title', 'Devolucao');
      postJson.Add('motivo', edMotivo.Text);
      postJson.Add('origin', codMov);
      postJson.Add('quantidade',dmPdv.sqLancamentosQUANTIDADE.Value);
      postJson.Add('produto', dmPdv.sqLancamentosCODPRODUTO.Value);
      postJson.Add('nproduto', dmPdv.sqLancamentosDESCPRODUTO.Value);
     // postJson.Add('caixa', dmPdv.idcaixa);
     // postJson.Add('cod_forma', rv_codForma);
      fInteg := TfIntegracaoOdoo.Create(Self);
      httpClient := fInteg.logar();
      With httpClient do
      begin
        AddHeader('Content-Type', 'application/json');
        RequestBody := TStringStream.Create(postJson.AsJSON);
        responseData := Post(dmPdv.path_integra_url + '/devolucao');
        //memoDevolucao.Lines.Add(responseData); //para ver o json
      end;
      fInteg.Free;
      postJson.Free;
      ShowMessage('Devolução de Produto Realizada' );
    except
      ShowMessage('Devolução em Processo, Rodar o Integração Para Finalizar' );
    end;
  end;
  edMotivo.Text:='';
end;

procedure TfPdv.imprimirCupomTroca;
var
  IMPRESSORA : Text;
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
  barcode : String;
  prazo : String;
  totalP: Double;
  totalD: Double;
  totalR: Double;
  pos_mx : Integer;
  tamanho : Integer;
  texto : String;
begin
  prazo := 'N';
  totalP := 0;
  totalD := 0;
  totalR := 0;
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
  clientecupom := '  ' + IntToStr(codCliente) + '-' + uutil.RemoveAcento(edClienteNome.Text);
  dmPdv.sqLancamentos.Close;
  dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := CodMov;
  dmPdv.sqLancamentos.Open;
  // leio um arquivo txt e imprimo
  lFile := TStringList.Create;
  //Aqui uso o ACBR pra imprimir , entao nao precisa disto 10/11/2020

  if ((dmPdv.CupomImp = 'Texto') or (dmPdv.CupomImp = 'DB')) then
  begin
    //v_log := 'Log portaImp - ' + dmPdv.portaIMP;
    //AssignFile(IMPRESSORA, dmPdv.portaIMP);
    AssignFile(IMPRESSORA, dmPdv.path_imp);
  end
  else begin
    //v_log := 'Log path_imp - ' + dmPdv.path_imp;
    //AssignFile(IMPRESSORA, dmPdv.path_imp);
    AssignFile(IMPRESSORA, dmPdv.portaIMP);
  end;


  //AssignFile(IMPRESSORA, dmpdv.path_imp);
  try
    Rewrite(IMPRESSORA);
    lFile.LoadFromFile('cupomTroca.txt');
    for i:=0 to lFile.Count-1 do
    begin
      tamanho := Length(lFile[i]);
      linhaTxt := Copy(lFile[i],0,1);
      if lFile[i] = 'empresa' then
        Writeln(Impressora, uutil.RemoveAcento(Format('  %-36s',[dmPdv.sqEmpresaRAZAO.Value])))
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
        Writeln(impressora, 'Vendedor: ' + uutil.RemoveAcento(edVendedor.Text));
      end
      else if lFile[i] = 'cliente' then
        Writeln(Impressora, clientecupom)
      else if Copy(lFile[i],0,3) = 'doc' then
      begin
        pos_mx := pos('<', lFile[i]);
        if (pos_mx > 1) then
        begin
          Writeln(Impressora, '  ' + FormatDateTime('dd/mm/yyyy hh:MM:ss', Now) + '    COD: ' + IntToStr(CodMov));
          texto := lFile[i];
          texto := Copy(texto,pos_mx, tamanho-pos_mx+1);
          //texto := stringReplace('texto' , 'F',  'T' ,[rfReplaceAll, rfIgnoreCase]);
          texto := ReplaceStr(texto,'texto','VALE DE TROCA/DEVOLUCAO');
          Writeln(Impressora, texto);
        end
        else begin
          Writeln(Impressora, '  ' + FormatDateTime('dd/mm/yyyy hh:MM:ss', Now) + '    COD: ' + IntToStr(CodMov));
          Writeln(Impressora, 'VALE DE TROCA/DEVOLUCAO');
        end;
      end
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
          totalR := totalR + dmPdv.sqLancamentosVALTOTAL.value;
          produto_cupomf := trim(uutil.RemoveAcento(dmPdv.sqLancamentosDESCPRODUTO.Value));
          texto6 := texto6 + '  ' + Copy(produto_cupomf, 0, 36);       //descrição do produto
          Writeln(Impressora, uutil.RemoveAcento(texto6));
          if (length(produto_cupomf)>36) then
          begin
            texto6 := '    ' + Copy(produto_cupomf, 37, 72);       //descrição do produto
            Writeln(Impressora, uutil.RemoveAcento(texto6));
          end;
          Writeln(Impressora, uutil.RemoveAcento(texto3));//NOME DO PRODUTO
          dmPdv.sqLancamentos.next;
        end;
      end
      else if linhaTxt = 'T' then
      begin
        linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
        Writeln(Impressora, linhaTxt + FormatFloat('#,,,0.00', totalR));
      end
      else if linhaTxt = 'C' then
      begin
        linhaTxt := Copy(lFile[i],2,Length(lFile[i])-1);
        Writeln(Impressora, chr(27)+chr(109));
      end
      else if linhaTxt = 'm' then
      begin
        Writeln(Impressora, 'Motivo : ');
        Writeln(Impressora, uutil.RemoveAcento(edMotivo.Text));//Motivo
      end
      else if linhaTxt = 'b' then
      begin
        barcode := IntToStr(codMov);
        barcode := '3' + ch_cp + AddChar('0', barcode, 7);
        barcode := barcode + uutil.EAN13(barcode);
        Writeln(Impressora, '<ean13>' + barcode + '</ean13>');//Motivo
        //Writeln(Impressora, barcode)
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

end;

procedure TfPdv.imprimirAcbr;
var arquivo: TStringList;
begin
  arquivo := TStringList.Create();
  try
    if ((dmPdv.CupomImp <> 'Texto') or (dmPdv.CupomImp = 'DB')) then
    begin
      //v_log := 'Log portaImp - ' + dmPdv.portaIMP;
      arquivo.LoadFromFile(dmpdv.portaIMP);
    end
    else begin
      //v_log := 'Log path_imp - ' + dmPdv.path_imp;
      arquivo.LoadFromFile(dmpdv.path_imp);
    end;
    MemoImp.Clear;
    MemoImp.Text := arquivo.Text;
  finally
    arquivo.free;
  end;
  ACBrPosPrinter1.Desativar;
  ACBrPosPrinter1.LinhasBuffer := dmPdv.imp_LinhasBuffer;
  ACBrPosPrinter1.LinhasEntreCupons := 0;
  ACBrPosPrinter1.EspacoEntreLinhas := dmPdv.espacoEntreLinhas;
  ACBrPosPrinter1.ColunasFonteNormal := 48;
  ACBrPosPrinter1.Porta  := dmPdv.portaImp;
  ACBrPosPrinter1.ConfigBarras.MostrarCodigo := True;
  ACBrPosPrinter1.ConfigBarras.Margem:= dmPdv.margemCodBarra;


  ACBrPosPrinter1.TraduzirTags:=True;
  ACBrPosPrinter1.Modelo := TACBrPosPrinterModelo(dmPdv.ModeloImp);
  ACBrPosPrinter1.Ativar ;

  ACBrPosPrinter1.Buffer.Text := MemoImp.Lines.Text;
  ACBrPosPrinter1.Imprimir;
  ACBrPosPrinter1.CortaPapel := True;
end;

procedure TfPdv.imprime_envio;
var
  IMPRESSORA : Text;
  i      : Integer;
  logradouro: String;
  cep: String;
  fone: String;
  clientecupom: string;
  texto3: String;
  texto6: String;
  produto_cupomf: String;
  linhaTxt : String;
  barcode : String;
  prazo : String;
  totalP: Double;
  totalD: Double;
  totalR: Double;
  pos_mx : Integer;
  tamanho : Integer;
  texto : String;
begin
  prazo := 'N';
  totalP := 0;
  totalD := 0;
  totalR := 0;
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
  clientecupom := '  ' + IntToStr(codCliente) + '-' + uutil.RemoveAcento(edClienteNome.Text);
  dmPdv.sqLancamentos.Close;
  dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := CodMov;
  dmPdv.sqLancamentos.Open;
  AssignFile(IMPRESSORA, dmPdv.path_imp);
  try
    Rewrite(IMPRESSORA);
    Writeln(Impressora, uutil.RemoveAcento(Format('  %-36s',[dmPdv.sqEmpresaRAZAO.Value])));
    Writeln(IMPRESSORA, '');
    Writeln(impressora, 'Usuario: ' + dmpdv.nomeLogado);
    Writeln(impressora, 'Vendedor: ' + uutil.RemoveAcento(edVendedor.Text));
    Writeln(Impressora, '  ' + FormatDateTime('dd/mm/yyyy hh:MM:ss', Now) + '    COD: ' + IntToStr(CodMov));
    Writeln(Impressora, 'Pedido enviado');
    barcode := IntToStr(codMov);
    barcode := '7' + ch_cp + AddChar('0', barcode, 7);
    barcode := barcode + uutil.EAN13(barcode);
    Writeln(Impressora, '<code128>' + barcode + '</code128>');//Motivo
  finally
    CloseFile(IMPRESSORA);
  end;
end;

procedure TfPdv.buscaProduto();
var i: Integer;
  str_bsc  : String;
begin
  if ((statusPedido > 0) and (dmPdv.usaComanda = 0)) then
  begin
    ShowMessage('Pedido ja finalizado. Clique no Incluir para novo pedido.');
    Exit;
  end;
  if (edProduto.Text <> '') then
  begin
    str_bsc := Copy(edProduto.Text,0,1);
    if (dmpdv.usaComanda > 0) then
    begin
      if (str_bsc = '0') then
      begin
        str_bsc := edProduto.Text;
        buscaPedidoComanda(edProduto.Text);
        if (e_comanda = 'V') then // comanda vazia , sai
        begin
          edProduto.Text:='';
          exit;
        end;
        if ((codMov > 0) and (e_comanda = 'S')) then
        begin
          abrePedido(codMov);
          pnComanda.Caption := edClienteNome.Text;//'Comanda ' + str_bsc;
          e_comanda:='N';
          exit;
        end;
      end
      else begin
        if ((statusPedido > 0) and (dmPdv.usaComanda > 0)) then
        begin
          ShowMessage('Informe a comanda/mesa.');
          Exit;
        end;
      end;
    end;
    fProdutoProc.num_busca:=0;
    // TODO - preciso definir aqui, qdo e codigo de barra qdo e codigo
    // do produto, se codigo comecar com 'X' e codigo produto ???!!!
    // se o codigo tiver mais q 'X' caracter e codigo de barras ??!!

    // digitou letras entao busca pela descricao
    if (dmpdv.tipo_buscaProd = 'CODPRO') then
    begin
      fProdutoProc.busca(edProduto.Text, '','', False);
    end
    else begin
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
    end;
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
    if (consultaItem = 'NAO') then
      adicionaProduto();
  end;
  if fProdutoProc.num_busca = 0 then
  begin
    edProduto.Text:='';
    Beep;
    Beep;
    Beep;
  end;
  if fProdutoProc.num_busca > 0 then
  begin
 //   btnVnd1.Click;
  end;

end;

procedure TfPdv.procFormShow;
var sqlP , camin : String;
  logs:TextFile;
begin
  AssignFile(logs, 'log.txt');
  try
    Rewrite(logs);
    Writeln(logs, 'Abrindo sistema');

  codVendedorAnterior := 0;
  if (dmpdv.empresa_integra <> 'ATS') then
  begin
    dmpdv.integra_caixa;
    dmpdv.integra_caixa_mov;
    dmpdv.integra_cliente;
    dmpdv.integra_usuario;
    dmpdv.integra_produtos;
  end;
  ACBrPosPrinter1.ControlePorta:=dmPdv.imp_controle_porta;
  ACBrPosPrinter1.LinhasBuffer:=dmPdv.imp_LinhasBuffer;
  ACBrPosPrinter1.Device.SendBytesInterval:=dmpdv.imp_Interval;

  ultimo_pedido := 0;
  consultaItem := 'NAO';
  DBGrid2.Columns[0].FieldName:='CODPRO';
  DBGrid2.Columns[1].FieldName:='PRODUTO';
  DBGrid2.Columns[2].FieldName:='UNIDADEMEDIDA';
  DBGrid2.Columns[3].FieldName:='VALOR_PRAZO';
  DBGrid2.Columns[3].DisplayFormat:=',##0.00';
  fPDV_Rec.OutrosCartoes:='N';
  dmPdv.OutrosCartoes := 'N';
  sqlP := 'SELECT * FROM PARAMETRO WHERE PARAMETRO = ' + QuotedStr('OUTROSCARTOES');
  dmPdv.busca_sql(sqlP);
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    fPDV_Rec.OutrosCartoes:='S';
    dmPdv.OutrosCartoes := 'S';
  end;
  Writeln(logs, 'Abrindo sistema 2');
  sqlP := 'SELECT CODCAIXA, NOMECAIXA ';
  sqlP += ' FROM CAIXA_CONTROLE  ';
  sqlP += ' WHERE CODUSUARIO = ' + dmPdv.varLogado;
  sqlP += '   AND SITUACAO = ' + QuotedStr('o');
  sqlP += ' ORDER BY IDCAIXACONTROLE DESC';
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
  codCliente  := dmPdv.clientePadrao;
  edClienteNome.Text := 'Consumidor';
  edCliente.Text     := IntToStr(dmpdv.clientePadrao);
  codVendedor := dmpdv.vendedor_padrao;
  edVendedor.Text := IntToStr(dmpdv.vendedor_padrao);
  edCaixa.Text := dmPdv.nomeLogado + '-' + dmPdv.nomeCaixa;
  buscaPedidosAbertoCaixa(0);
  Writeln(logs, 'Abrindo sistema 3');
  if (dmPdv.usaComanda > 0) then
  begin
    if (btnVnd1.Caption <> '') then
      abrePedido(StrToInt(btnVnd1.Caption));
    pnComanda.Visible:=True;
  end;
  Writeln(logs, 'Abrindo sistema 4');
  finally
    CloseFile(logs);
  end;

  camin := dmPdv.caminhoEXEpdv ;

  if(fSangria.abri_cx = 1)then
  begin
    ShowMessage('O Progama Sera Reiniciado para Atualizar o Caixa ');
    fPdv.Close;
    //WINEXEC('C:\home\felicita_linux\prjPDV.exe',SW_SHOWNORMAL);
    ShellExecute(Application.Handle, PChar('open'), PChar(camin), PChar(' /e,C:\temp'), nil, SW_NORMAL);
  end;



  if(fAbreCaixa.abri_cx = 1)then
  begin
    ShowMessage('O Progama Sera Reiniciado para Atualizar o Caixa ');
    fPdv.Close;
   // WINEXEC('C:\home\felicita_linux\prjPDV.exe',SW_SHOWNORMAL);
    ShellExecute(Application.Handle, PChar('open'), PChar(camin), PChar(' /e,C:\temp'), nil, SW_NORMAL);
  end;

  if(fAbrirCaixa.abri_cx = 1)then
  begin
    ShowMessage('O Progama Sera Reiniciado para Atualizar o Caixa ');
    fPdv.Close;
    //WINEXEC('C:\home\felicita_linux\prjPDV.exe',SW_SHOWNORMAL);
    ShellExecute(Application.Handle, PChar('open'), PChar(camin), PChar(' /e,C:\temp'), nil, SW_NORMAL);
  end;

end;
end.

