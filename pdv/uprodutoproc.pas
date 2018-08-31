unit uProdutoProc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons, udmpdv;

type

  { TfProdutoProc }

  TfProdutoProc = class(TForm)
    BitBtn1: TBitBtn;
    btnEXC: TImage;
    btnSALV: TImage;
    chInativo: TCheckBox;
    DBGrid1: TDBGrid;
    dsProc: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnEXCClick(Sender: TObject);
    procedure btnPROCClick(Sender: TObject);
    procedure btnSALVClick(Sender: TObject);
    procedure chInativoChange(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: char);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private

  public
    codProduto: Integer;
    produto: String;
    codProd: String;
    precoVenda: Double;
    precoVendaAtacado: Double;
    qtdeAtacado: Double;
    estoque: Double;

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
    Close;
  end;
end;

procedure TfProdutoProc.btnPROCClick(Sender: TObject);
begin

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

procedure TfProdutoProc.btnSALVClick(Sender: TObject);
begin
  codProduto:= dmPdv.sqBusca.FieldByName('CODPRODUTO').AsInteger;
  produto   := dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
  precoVenda:= dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
  estoque   := dmPdv.sqBusca.FieldByName('ESTOQUEATUAL').AsFloat;
  precoVendaAtacado := dmPdv.sqBusca.FieldByName('PRECOATACADO').AsFloat;
  qtdeAtacado:= dmPdv.sqBusca.FieldByName('QTDEATACADO').AsFloat;
  Close;
end;

procedure TfProdutoProc.chInativoChange(Sender: TObject);
begin

end;

procedure TfProdutoProc.FormCreate(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName:='CODPRO';
  DBGrid1.Columns[1].FieldName:='PRODUTO';
  DBGrid1.Columns[2].FieldName:='UNIDADEMEDIDA';
  DBGrid1.Columns[3].FieldName:='ESTOQUEATUAL';
end;

procedure TfProdutoProc.FormKeyPress(Sender: TObject; var Key: char);
begin
end;

procedure TfProdutoProc.FormShow(Sender: TObject);
begin
  codProduto :=0;
  produto    :='';
  codProd    :='';
  precoVenda :=0;
  estoque    :=0;
  edit1.SetFocus;
end;

procedure TfProdutoProc.busca(codigo: String; barCode: String; produtoDesc: String; inativo: Boolean);
var sqlProc: String;
begin
  sqlProc := 'SELECT * FROM PRODUTOS ';
  sqlProc := sqlProc + 'WHERE ((USA IS NULL) OR (USA <> ' +
    QuotedStr('N') + '))';
  if (inativo = True) then
  begin
    sqlProc := 'SELECT * FROM PRODUTOS WHERE USA = ' +
      QuotedStr('N');
  end;
  if (codigo <> '') then
  begin
    sqlProc := sqlProc + ' AND CODPRO = ' + QuotedStr(codigo);
  end;
  if (barCode <> '') then
  begin
    // TODO - Colocar aqui o tratamento do codigo de barras do odoo
    // se 21 ... se 23 .....
    sqlProc := sqlProc + ' AND COD_BARRA = ' + QuotedStr(barCode);
  end;
  if (produtoDesc <> '') then
  begin
    sqlProc := sqlProc + ' AND UPPER(PRODUTO) LIKE UPPER(' +
      QuotedStr('%' + produtoDesc + '%') + ')';
  end;
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlProc);
  dmPdv.sqBusca.Active:=True;
  if ((dmPdv.sqBusca.IsEmpty) and (barCode <> '')) then
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
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    codProduto := dmPdv.sqBusca.FieldByName('CODPRODUTO').AsInteger;
    produto    := dmPdv.sqBusca.FieldByName('PRODUTO').AsString;
    codProd    := dmPdv.sqBusca.FieldByName('CODPRO').AsString;
    precoVenda := dmPdv.sqBusca.FieldByName('VALOR_PRAZO').AsFloat;
    precoVendaAtacado := dmPdv.sqBusca.FieldByName('PRECOATACADO').AsFloat;
    qtdeAtacado:= dmPdv.sqBusca.FieldByName('QTDEATACADO').AsFloat;
    estoque    := dmPdv.sqBusca.FieldByName('ESTOQUEATUAL').AsFloat;
  end;
end;

end.

