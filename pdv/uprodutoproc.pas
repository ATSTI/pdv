unit uProdutoProc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons, udmpdv, strutils;

type

  { TfProdutoProc }

  TfProdutoProc = class(TForm)
    BitBtn2: TBitBtn;
    btnSair: TBitBtn;
    btnConfirma: TBitBtn;
    btnProcurar: TBitBtn;
    chInativo: TCheckBox;
    cbSubGrupo: TComboBox;
    cbGrupo: TComboBox;
    DBGrid1: TDBGrid;
    dsProc: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnEXCClick(Sender: TObject);
    procedure btnPROCClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnSALVClick(Sender: TObject);
    procedure cbGrupoChange(Sender: TObject);
    procedure cbSubGrupoChange(Sender: TObject);
    procedure chInativoChange(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: char);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    num_pedidos : Integer;
    codProduto: Integer;
    produto: String;
    codProd: String;
    precoVenda: Double;
    quantidadeVenda: Double;
    precoVendaAtacado: Double;
    qtdeAtacado: Double;
    estoque: Double;
    tipo_venda: String;
    num_busca: Integer;
    procedure busca(codigo: String; barCode: String; produtoDesc: String; inativo: Boolean);
  end;

var
  fProdutoProc: TfProdutoProc;

implementation

{$R *.lfm}

{ TfProdutoProc }

procedure TfProdutoProc.Edit1Enter(Sender: TObject);
begin

end;

procedure TfProdutoProc.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if (key = #13) then
  begin
    Key := #0;
    busca(Edit1.Text, '', Edit2.Text, chInativo.Checked);
    DBGrid1.SetFocus;
  end;

end;

procedure TfProdutoProc.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if (key = #13) then
  begin
    Key := #0;
    busca(Edit1.Text, '', Edit2.Text, chInativo.Checked);
    DBGrid1.SetFocus;
  end;
end;

procedure TfProdutoProc.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  cbGrupo.Text    := '';
  cbSubGrupo.Text := '';
end;

procedure TfProdutoProc.DBGrid1CellClick(Column: TColumn);
begin
end;

procedure TfProdutoProc.DBGrid1DblClick(Sender: TObject);
begin
  codProduto:= dmPdv.sqBusca.FieldByName('CODPRODUTO').AsInteger;
  produto   := dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
  codProd   := dmPdv.sqBusca.FieldByName('CODPRO').AsString;
  precoVendaAtacado := dmPdv.sqBusca.FieldByName('PRECOATACADO').AsFloat;
  qtdeAtacado:= dmPdv.sqBusca.FieldByName('QTDEATACADO').AsFloat;
  precoVenda:= dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
  tipo_venda := dmPdv.sqBusca.FieldByName('RATEIO').AsString;
  Close;
end;

procedure TfProdutoProc.DBGrid1KeyPress(Sender: TObject; var Key: char);
begin
  if (key = #13) then
  begin
    Key := #0;
    codProduto:= dmPdv.sqBusca.FieldByName('CODPRODUTO').AsInteger;
    produto   := dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
    codProd   := dmPdv.sqBusca.FieldByName('CODPRO').AsString;
    precoVendaAtacado := dmPdv.sqBusca.FieldByName('PRECOATACADO').AsFloat;
    qtdeAtacado:= dmPdv.sqBusca.FieldByName('QTDEATACADO').AsFloat;
    precoVenda:= dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
    tipo_venda := dmPdv.sqBusca.FieldByName('RATEIO').AsString;
    Close;
  end;
end;

procedure TfProdutoProc.Edit1Change(Sender: TObject);
begin

end;

procedure TfProdutoProc.btnPROCClick(Sender: TObject);
begin

end;

procedure TfProdutoProc.btnProcurarClick(Sender: TObject);
begin
  busca(Edit1.Text, '', Edit2.Text, chInativo.Checked);
end;

procedure TfProdutoProc.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfProdutoProc.btnEXCClick(Sender: TObject);
begin
  Edit1.Text:='';
  Edit2.Text:='';
end;

procedure TfProdutoProc.BitBtn1Click(Sender: TObject);
begin
  busca(Edit1.Text, '', Edit2.Text, chInativo.Checked);
end;

procedure TfProdutoProc.BitBtn2Click(Sender: TObject);
begin
  if dmpdv.empresa_integra <> 'ATS' then
    dmPdv.integra_produtos;
  dmPdv.IbCon.Connected:=False;
  dmPdv.IbCon.Connected:=True;
  num_pedidos := 0;
  busca(Edit1.Text, '', Edit2.Text, chInativo.Checked);
end;

procedure TfProdutoProc.btnConfirmaClick(Sender: TObject);
begin
  codProduto:= dmPdv.sqBusca.FieldByName('CODPRODUTO').AsInteger;
  produto   := dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
  codProd   := dmPdv.sqBusca.FieldByName('CODPRO').AsString;
  precoVenda:= dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
  estoque   := dmPdv.sqBusca.FieldByName('ESTOQUEATUAL').AsFloat;
  precoVendaAtacado := dmPdv.sqBusca.FieldByName('PRECOATACADO').AsFloat;
  qtdeAtacado:= dmPdv.sqBusca.FieldByName('QTDEATACADO').AsFloat;
  tipo_venda := dmPdv.sqBusca.FieldByName('RATEIO').AsString;
  Close;
end;

procedure TfProdutoProc.btnSALVClick(Sender: TObject);
begin
  codProduto:= dmPdv.sqBusca.FieldByName('CODPRODUTO').AsInteger;
  produto   := dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
  codProd   := dmPdv.sqBusca.FieldByName('CODPRO').AsString;
  precoVenda:= dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
  estoque   := dmPdv.sqBusca.FieldByName('ESTOQUEATUAL').AsFloat;
  precoVendaAtacado := dmPdv.sqBusca.FieldByName('PRECOATACADO').AsFloat;
  qtdeAtacado:= dmPdv.sqBusca.FieldByName('QTDEATACADO').AsFloat;
  tipo_venda := dmPdv.sqBusca.FieldByName('RATEIO').AsString;
  Close;
end;

procedure TfProdutoProc.cbGrupoChange(Sender: TObject);
begin
  cbSubGrupo.Items.Clear;
  dmPdv.busca_sql('SELECT COD_FAMILIA FROM FAMILIAPRODUTOS WHERE DESCFAMILIA = ' +
    QuotedStr(cbGrupo.Text));
  dmPdv.busca_sql('SELECT DESCCATEGORIA, COD_FAMILIA FROM CATEGORIAPRODUTO ' +
    ' WHERE COD_FAMILIA = ' + IntToStr(dmPdv.sqBusca.FieldByName('COD_FAMILIA').AsInteger));
  While not dmPdv.sqBusca.EOF do
  begin
    cbSubGrupo.Items.Add(dmPdv.sqBusca.FieldByName('DESCCATEGORIA').AsString);
    dmPdv.sqBusca.Next;
  end;
  btnProcurar.Click;
end;

procedure TfProdutoProc.cbSubGrupoChange(Sender: TObject);
begin
  btnProcurar.Click;
end;

procedure TfProdutoProc.chInativoChange(Sender: TObject);
begin

end;

procedure TfProdutoProc.FormCreate(Sender: TObject);
begin
  num_pedidos:=0;
  DBGrid1.Columns[0].FieldName:='CODPRO';
  DBGrid1.Columns[1].FieldName:='PRODUTO';
  DBGrid1.Columns[2].FieldName:='UNIDADEMEDIDA';
  DBGrid1.Columns[3].FieldName:='VALOR_PRAZO';
  DBGrid1.Columns[3].DisplayFormat:=',##0.00';
end;


procedure TfProdutoProc.FormShow(Sender: TObject);
begin
  num_busca  :=0;
  codProduto :=0;
  produto    :='';
  codProd    :='';
  precoVenda :=0;
  estoque    :=0;
  tipo_venda :='1';
  DBGrid1.SetFocus;
  busca(Edit1.Text, '', Edit2.Text, chInativo.Checked);
  cbSubGrupo.Items.Clear;
  cbGrupo.Items.Clear;
  dmPdv.busca_sql('SELECT DESCFAMILIA, COD_FAMILIA FROM FAMILIAPRODUTOS');
  While not dmPdv.sqBusca.EOF do
  begin
    cbGrupo.Items.Add(dmPdv.sqBusca.FieldByName('DESCFAMILIA').AsString);
    dmPdv.sqBusca.Next;
  end;
  dmPdv.busca_sql('SELECT DESCCATEGORIA, COD_FAMILIA FROM CATEGORIAPRODUTO');
  While not dmPdv.sqBusca.EOF do
  begin
    cbSubGrupo.Items.Add(dmPdv.sqBusca.FieldByName('DESCCATEGORIA').AsString);
    dmPdv.sqBusca.Next;
  end;
end;

procedure TfProdutoProc.busca(codigo: String; barCode: String; produtoDesc: String; inativo: Boolean);
var sqlProc: String;
  cod_bs: String;
  sqlP: String;
  busca_wrd: String;
  j: integer;
  i: integer;
begin
  quantidadeVenda := 1;
  if (num_pedidos = 5) then
  begin
    dmPdv.IbCon.Connected:=False;
    dmPdv.IbCon.Connected:=True;
    sqlP := 'SELECT CODCAIXA, NOMECAIXA ';
    sqlP += ' FROM CAIXA_CONTROLE  ';
    sqlP += ' WHERE CODUSUARIO = ' + dmPdv.varLogado;
    sqlP += '   AND SITUACAO = ' + QuotedStr('o');
    if (dmPdv.sqBusca.Active) then
      dmPdv.sqBusca.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqBusca.SQL.Add(sqlP);
    dmPdv.sqBusca.Active:=True;
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      dmPdv.nomeCaixa := 'FECHADO';
    end;
    num_pedidos := 0;
  end;
  codProduto := 0;
  cod_bs := '';
  sqlProc := 'SELECT * FROM PRODUTOS ';
  sqlProc := sqlProc + 'WHERE ((USA IS NULL) OR (USA <> ' +
    QuotedStr('N') + '))';
  if (inativo = True) then
  begin
    sqlProc := 'SELECT * FROM PRODUTOS WHERE USA = ' +
      QuotedStr('N');
  end;
  if (cbGrupo.Text <> '') then
  begin
    sqlProc := sqlProc + ' AND FAMILIA = ' + QuotedStr(cbGrupo.Text);
  end;
  if (cbSubGrupo.Text <> '') then
  begin
    sqlProc := sqlProc + ' AND CATEGORIA = ' + QuotedStr(cbSubGrupo.Text);
  end;

  if (codigo <> '') then
  begin
    sqlProc := sqlProc + ' AND (UPPER(CODPRO) LIKE UPPER(' +
      QuotedStr(codigo + '%') + ')';
    sqlProc := sqlProc + ' OR UPPER(CAST(PRODUTO AS VARCHAR(300) ' +
      ' character set UTF8)) LIKE UPPER(' +
      QuotedStr('%' + codigo + '%') + '))';
  end;
  if (barCode <> '') then
  begin
    // TODO - Colocar aqui o tratamento do codigo de barras do odoo
    // se 21 ... se 23 .....
    cod_bs := Copy(barCode,0,2);
    if cod_bs = '20' then
    begin
      cod_bs := Copy(barCode,0,7);
      sqlProc := sqlProc + ' AND COD_BARRA LIKE ' + QuotedStr(cod_bs + '%');
      cod_bs := Copy(barCode,8,5);
    end
    else begin
      cod_bs := '';
      sqlProc := sqlProc + ' AND COD_BARRA = ' + QuotedStr(barCode);
    end;
  end;
  if (produtoDesc <> '') then
  begin
    i := 0;
    j := WordCount(produtoDesc, [' ']);
    //busca_str := '';
    While i < j do
    begin
      i += 1;
      busca_wrd := ExtractWord(i, produtoDesc, [' ']);
      //busca_str := busca_str + '%' + busca_wrd;
      sqlProc := sqlProc + ' AND UPPER(CAST(PRODUTO AS VARCHAR(300) ' +
        ' character set UTF8)) LIKE UPPER(' +
        QuotedStr('%' + busca_wrd + '%') + ')';
    end;
    //busca_str := busca_str + '%';
  end;
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlProc);
  dmPdv.sqBusca.Active:=True;
  if ((dmPdv.sqBusca.IsEmpty) and (barCode <> '')) then
  begin
    sqlProc := 'SELECT * FROM PRODUTOS ';
    sqlProc := sqlProc + 'WHERE ((USA IS NULL) OR (USA <> ' +
      QuotedStr('N') + '))';

    if (Length(barCode) > 12) then
    begin
      cod_bs := '';
      sqlProc := sqlProc + ' AND COD_BARRA LIKE ' +
         QuotedStr(Copy(barCode,0,12) + '%');
    end;
    if (dmPdv.sqBusca.Active) then
      dmPdv.sqBusca.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqBusca.SQL.Add(sqlProc);
    dmPdv.sqBusca.Active:=True;
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      // refaco a busca usando o codpro se tentou pelo codigo de barra
      sqlProc := 'SELECT * FROM PRODUTOS ';
      sqlProc := sqlProc + 'WHERE ((USA IS NULL) OR (USA <> ' +
        QuotedStr('N') + '))';
      sqlProc := sqlProc + ' AND CODPRO = ' + QuotedStr(barCode);
      dmPdv.sqBusca.Close;
      dmPdv.sqBusca.SQL.Clear;
      dmPdv.sqBusca.SQL.Add(sqlProc);
      dmPdv.sqBusca.Active:=True;
    end;
  end;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    num_busca := dmPdv.sqBusca.RecordCount;
    codProduto := dmPdv.sqBusca.FieldByName('CODPRODUTO').AsInteger;
    produto    := dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
    codProd    := dmPdv.sqBusca.FieldByName('CODPRO').AsString;
    if cod_bs <> '' then
    begin
      if (dmPdv.tipo_CodBarra = 'PESO') then
      begin
        cod_bs := cod_bs
      end
      else begin
        cod_bs := Copy(cod_bs,0,3) + ',' + Copy(cod_bs,4,4);
      end;
      quantidadeVenda := 1;
      if (dmPdv.tipo_CodBarra = 'PESO') then
      begin
        precoVenda := dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
        quantidadeVenda := StrToFloat(cod_bs)/1000;
      end
      else
        precoVenda := StrToFloat(cod_bs);
    end
    else begin
      precoVenda := dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
    end;
    precoVendaAtacado := dmPdv.sqBusca.FieldByName('PRECOATACADO').AsFloat;
    qtdeAtacado:= dmPdv.sqBusca.FieldByName('QTDEATACADO').AsFloat;
    estoque    := dmPdv.sqBusca.FieldByName('ESTOQUEATUAL').AsFloat;
    tipo_venda := dmPdv.sqBusca.FieldByName('RATEIO').AsString;
  end;
end;

end.

