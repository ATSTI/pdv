unit uComandaJuntar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBGrids, Menus, udmpdv;

type

  { TfComandaJuntar }

  TfComandaJuntar = class(TForm)
    btnNovo: TBitBtn;
    btnProcurar: TBitBtn;
    btnProcurar1: TBitBtn;
    btnSair: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    dsPrincipal: TDataSource;
    dsAdic: TDataSource;
    edComandaPrincipal: TEdit;
    edComandaAdic: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure btnNovoClick(Sender: TObject);
    procedure btnProcurar1Click(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edComandaAdicKeyPress(Sender: TObject; var Key: char);
    procedure edComandaPrincipalKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    comandaPrincipal: Integer;
    comandaAdicionar: Integer;
    str_sql: String;
  public

  end;

var
  fComandaJuntar: TfComandaJuntar;

implementation

{$R *.lfm}

{ TfComandaJuntar }

procedure TfComandaJuntar.btnProcurarClick(Sender: TObject);
begin
  //dmPdv.busca_sql('SELECT CODMOVIMENTO FROM MOVIMENTO ' +
  //  ' WHERE STATUS = 0 AND CODALMOXARIFADO = ' + dmPdv.ccusto +
  //  '   AND CODCLIENTE = ' + edComandaPrincipal.Text);
  dmPdv.busca_sql(str_sql + ' AND m.CODCLIENTE = ' + edComandaPrincipal.Text);
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    comandaPrincipal := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
    edComandaAdic.SetFocus;
  end;

end;

procedure TfComandaJuntar.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfComandaJuntar.edComandaAdicKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnProcurar1.Click;
  end;
end;

procedure TfComandaJuntar.edComandaPrincipalKeyPress(Sender: TObject;
  var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnProcurar.Click;
  end;
end;

procedure TfComandaJuntar.FormCreate(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName := 'DESCPRODUTO';
  DBGrid1.Columns[1].FieldName := 'QUANTIDADE';
  DBGrid1.Columns[0].Title.Caption:='Item';
  DBGrid1.Columns[1].Title.Caption:='Quant.';
  DBGrid1.Columns[2].FieldName := 'PRECO';
  DBGrid1.Columns[2].Title.Caption:='Preco';
  DBGrid1.Columns[3].FieldName := 'TOTALITEM';
  DBGrid1.Columns[3].Title.Caption:='Total';

  DBGrid2.Columns[0].FieldName := 'DESCPRODUTO';
  DBGrid2.Columns[1].FieldName := 'QUANTIDADE';
  DBGrid2.Columns[0].Title.Caption:='Item';
  DBGrid2.Columns[1].Title.Caption:='Quant.';
  DBGrid2.Columns[2].FieldName := 'PRECO';
  DBGrid2.Columns[2].Title.Caption:='Preco';
  DBGrid2.Columns[3].FieldName := 'TOTALITEM';
  DBGrid2.Columns[3].Title.Caption:='Total';
end;

procedure TfComandaJuntar.FormShow(Sender: TObject);
begin
  comandaPrincipal:=0;
  comandaAdicionar:=0;
  str_sql := 'SELECT m.CODMOVIMENTO, a.CODPRODUTO, '+
    ' a.QUANTIDADE, a.PRECO, a.UN, a.DESCPRODUTO, ' +
    ' (COALESCE(A.VALTOTAL,0) - COALESCE(A.VALOR_DESCONTO, 0)) AS TOTALITEM ,' +
    ' c.NOMECLIENTE ' +
    ' FROM MOVIMENTO m ' +
    ' INNER JOIN CLIENTES c ON  c.CODCLIENTE = m.CODCLIENTE  ' +
    ' LEFT OUTER JOIN MOVIMENTODETALHE a ON M.CODMOVIMENTO = a.CODMOVIMENTO ' +
    ' WHERE m.STATUS = 0 AND ((a.STATUS = ' + QuotedStr('0') + ' ) or (a.STATUS is null))  ';
end;

procedure TfComandaJuntar.MenuItem1Click(Sender: TObject);
begin
  Close;
end;

procedure TfComandaJuntar.btnNovoClick(Sender: TObject);
begin
  if (comandaPrincipal = 0) then
  begin
    ShowMessage('Informe a comanda Principal');
    exit;
  end;
  if (comandaAdicionar = 0) then
  begin
    ShowMessage('Informe a comanda a Adicionar');
    exit;
  end;
  dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTODETALHE SET CODMOVIMENTO = ' +
    IntToStr(comandaPrincipal) +
    ' WHERE CODMOVIMENTO = ' + IntToStr(comandaAdicionar));
  dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 2 ' +
    ' WHERE CODMOVIMENTO = ' + IntToStr(comandaAdicionar));
  dmPdv.sTrans.Commit;
  btnProcurar.Click;
  edComandaAdic.Text:='';
  edComandaAdic.SetFocus;
  dmPdv.sqBusca1.Close;
end;

procedure TfComandaJuntar.btnProcurar1Click(Sender: TObject);
begin
  if (edComandaAdic.Text = edComandaPrincipal.Text) then
  begin
    ShowMessage('Mesma comanda principal.');
    Exit;
  end;
  dmPdv.sqBusca1.Close;
  dmPdv.sqBusca1.SQL.Clear;
  //dmPdv.sqBusca1.SQL.Text := 'SELECT CODMOVIMENTO FROM MOVIMENTO ' +
  //  ' WHERE STATUS = 0 AND CODALMOXARIFADO = ' + dmPdv.ccusto +
  //  '   AND CODCLIENTE = ' + edComandaAdic.Text;
  dmPdv.sqBusca1.SQL.Text := str_sql + ' AND m.CODCLIENTE = ' + edComandaAdic.Text;
  dmPdv.sqBusca1.Open;
  if (not dmPdv.sqBusca1.IsEmpty) then
  begin
    comandaAdicionar := dmPdv.sqBusca1.FieldByName('CODMOVIMENTO').AsInteger;
    btnNovo.SetFocus;
  end;
end;

end.

