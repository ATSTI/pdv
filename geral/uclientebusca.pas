unit uClienteBusca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, Buttons, db, udmpdv, uPadraoBusca;

type

  { TfClienteBusca }

  TfClienteBusca = class(TfPadraoBusca)
    chCurso: TCheckBox;
    chDesc: TCheckBox;
    dsCliente: TDataSource;
    Label2: TLabel;
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure chInativoChange(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    procedure Procurar();
  public
    cCodCliente: Integer;
    cNomeCliente : String;
    cCnpjCliente : String;
    procedure BuscaCliente;
  end;

var
  fClienteBusca: TfClienteBusca;

implementation

{$R *.lfm}

{ TfClienteBusca }



procedure TfClienteBusca.btnProcurarClick(Sender: TObject);
begin
    Procurar();
end;

procedure TfClienteBusca.chInativoChange(Sender: TObject);
begin
  Procurar();
end;

procedure TfClienteBusca.btnExcluirClick(Sender: TObject);
var update_cli:string;
begin
  //inherited;
  if MessageDlg('Confirma:', 'Confirma INATIVAR o Cliente: ' +
    cNomeCliente , mtConfirmation,
    [mbYes, mbNo, mbIgnore],0) = mrYes then
  begin
    update_cli := 'UPDATE CLIENTES SET STATUS = 0 WHERE CODCLIENTE = ' +
      IntToStr(cCodCliente);
    dmPdv.executaSql(update_cli);
    dmPdv.sTrans.Commit;
  end;
end;

procedure TfClienteBusca.btnGravarClick(Sender: TObject);
  var update_cli:string;
begin
    //inherited;
    if MessageDlg('Confirma:', 'Confirma ATIVAR o Cliente: ' +
      cNomeCliente , mtConfirmation,
      [mbYes, mbNo, mbIgnore],0) = mrYes then
    begin
      update_cli := 'UPDATE CLIENTES SET STATUS = 1 WHERE CODCLIENTE = ' +
        IntToStr(cCodCliente);
      dmPdv.executaSql(update_cli);
      dmPdv.sTrans.Commit;
    end;
end;


procedure TfClienteBusca.DBGrid1CellClick(Column: TColumn);
begin
  cNomeCliente := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;
  cCodCliente  := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
  cCnpjCliente := dmPdv.sqBusca.FieldByName('CNPJ').AsString;
end;

procedure TfClienteBusca.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if (key = #13) then
  begin
    Key := #0;
    if (edit1.Text <> '') then
      Procurar();
  end;
end;

procedure TfClienteBusca.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if (key = #13) then
  begin
    Key := #0;
    if (edit2.Text <> '') then
      Procurar();
  end;
end;

procedure TfClienteBusca.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if (chInativo.Checked) then
  begin
    cCodCliente := dmPdv.clientePadrao;
    cNomeCliente:= 'Consumidor';
  end;
end;

procedure TfClienteBusca.FormShow(Sender: TObject);
begin
  //dmPdv.IbCon.Connected:=False;
  //dmPdv.IbCon.Connected:=True;
  edit1.Text := '';
  edit2.Text := '';
  Edit2.SetFocus;
  DBGrid1.Columns[0].FieldName := 'CODCLIENTE';
  DBGrid1.Columns[1].FieldName := 'NOMECLIENTE';
  DBGrid1.Columns[0].Title.Caption:='Código';
  DBGrid1.Columns[1].Title.Caption:='Cliente';
  cCodCliente  := 0;
  cNomeCliente := '';
  cCnpjCliente := '';
  if (dmPdv.usaCurso = 0) then
  begin
    chCurso.Checked := False;
    chCurso.Visible := False;
  end;
end;

procedure TfClienteBusca.Procurar();
var sql: String;
begin
  sql := '';
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;

  if chCurso.Checked then
  begin
    sql := ' WHERE STATUS = 1 AND REGIAO = 1';
  end
  else begin
    sql := ' WHERE STATUS = 1 AND REGIAO = 0';
  end;

  if ((chCurso.Checked) and (chInativo.Checked)) then
  begin
    sql := ' WHERE STATUS = 0 AND REGIAO = 1';
  end;

  if edit1.Text <> '' then
  begin
    sql := sql + ' AND CODCLIENTE = ' + Edit1.Text;
  end;
  if edit2.Text <> '' then
  begin
    sql := sql + ' AND UPPER(NOMECLIENTE) LIKE UPPER(' + QuotedStr('%' + Edit2.Text + '%') + ')';
  end;

  if (chDesc.Checked) then
  begin
    sql := 'SELECT * FROM CLIENTES ' + sql + ' order by codcliente desc';
  end;

  if (chDesc.Checked = False) then
  begin
    sql := 'SELECT * FROM CLIENTES ' + sql ;
  end;

  dmPdv.sqBusca.SQL.Text := sql;
  dmPdv.sqBusca.Open;
  cNomeCliente := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;
  cCodCliente  := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
  cCnpjCliente  := dmPdv.sqBusca.FieldByName('CNPJ').AsString;
end;

procedure TfClienteBusca.BuscaCliente;
var sql: String;
begin
  sql := 'SELECT c.CODCLIENTE, c.NOMECLIENTE, c.RAZAOSOCIAL, c.CNPJ, ' +
      '   c.INSCESTADUAL, d.LOGRADOURO, d.NUMERO, d.CIDADE, d.BAIRRO, ' +
      '   d.CEP, d.UF, d.CD_IBGE ' +
      ' FROM CLIENTES c, ENDERECOCLIENTE d ' +
      ' WHERE c.CODCLIENTE = d.CODCLIENTE ' +
      ' AND d.TIPOEND = 0 ';
  sql := sql + ' AND c.CODCLIENTE = ' + IntToStr(cCodCliente);
  sql := sql + ' AND c.STATUS = 1';
  dmPdv.busca_sql(sql);
  if not dmPdv.sqBusca.IsEmpty then
  begin
    cNomeCliente := dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString;
    cCodCliente  := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
    cCnpjCliente  := dmPdv.sqBusca.FieldByName('CNPJ').AsString;
  end;
end;

end.

