unit uPdv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, SynEdit, RTTICtrls, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, MaskEdit, DBGrids, dateutils
  , uMovimento;

type

  { TfPdv }

  TfPdv = class(TForm)
    BitBtn1: TBitBtn;
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
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    btnVnd1: TBitBtn;
    btnNovo: TBitBtn;
    btnVendas: TBitBtn;
    btnReceber: TBitBtn;
    dsLanc: TDataSource;
    DBGrid1: TDBGrid;
    edCliente: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    edProdutoDesc: TEdit;
    edProduto: TEdit;
    edDesconto: TEdit;
    edTotalGeral: TMaskEdit;
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
    Label11: TLabel;
    Label12: TLabel;
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
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    TIButton2: TTIButton;
    edQtde: TTIFloatSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnReceberClick(Sender: TObject);
    procedure btnVendasClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure edClienteChange(Sender: TObject);
    procedure edPrecoChange(Sender: TObject);
    procedure edProdutoKeyPress(Sender: TObject; var Key: char);
    procedure edQtdeChange(Sender: TObject);
    procedure FlowPanel1Click(Sender: TObject);
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
    preco: Double;
    estoque: Double;
    caixa_local: Integer;
    codCliente: Integer;
    codCaixa: Integer; // cod Usuario
    codVendedor: Integer;
    codMov: Integer;
    codDet: Integer;
    procedure iniciarVenda();
    procedure registrar_item();
    procedure alterar_item();
    procedure finalizarVenda();
    procedure calculaTotal();
    procedure calculaTotalGeral();
  public

  end;

var
  fPdv: TfPdv;
  FMov: TMovimento;

implementation

uses updv_rec,udmpdv, uMovimentoProc, uProdutoProc;

{$R *.lfm}

{ TfPdv }

procedure TfPdv.Panel2Click(Sender: TObject);
begin

end;

procedure TfPdv.edClienteChange(Sender: TObject);
begin

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
  fPDV_Rec.ShowModal;
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

procedure TfPdv.BitBtn8Click(Sender: TObject);
begin
  Close;
end;

procedure TfPdv.btnNovoClick(Sender: TObject);
begin
  iniciarVenda();
  edProduto.Text:='';
  edProduto.SetFocus;
end;

procedure TfPdv.btnVendasClick(Sender: TObject);
begin
  fMovimentoProc.ShowModal;
  if (fMovimentoProc.codMovimentoProc > 0) then
  begin
    codMov:=fMovimentoProc.codMovimentoProc;
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
    calculaTotalGeral();
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

procedure TfPdv.FlowPanel1Click(Sender: TObject);
begin

end;

procedure TfPdv.FormShow(Sender: TObject);
begin
  // TODO - carregar caixa logado na varivel abaixo
  codDet := 0;
  caixa_local := 51;
  codCaixa    := 1;
  codCliente  := 1;
  codVendedor := 1;
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

procedure TfPdv.iniciarVenda();
begin
  if (not dsLanc.DataSet.Active) then
    dsLanc.DataSet.Active := True;
  //dsLanc.DataSet.Insert;
  Try
    FMov := TMovimento.Create;
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
  FMov.Free;
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
  dmPdv.sqLancamentos.Open;
  dmPdv.sqLancamentos.First;
  while not dmPdv.sqLancamentos.EOF do
  begin
    vTotGeral += dmPdv.sqLancamentosVALTOTAL.AsFloat;
    qtde_itens += 1;
    dmPdv.sqLancamentos.Next;
  end;
  dmPdv.sqLancamentos.RecNo := num_linha;
  dmPdv.sqLancamentos.EnableControls;
  edTotalGeral.Text := FloatToStr(vTotGeral);
  lblNumItem.Caption:= IntToStr(qtde_itens);
end;

end.

