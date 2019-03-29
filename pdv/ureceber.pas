unit uReceber;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, DBGrids, MaskEdit, uClienteBusca, udmpdv, db;

type

  { TfRecebimento }

  TfRecebimento = class(TForm)
    btnConfirma: TBitBtn;
    btnProcurar: TBitBtn;
    btnSair: TBitBtn;
    Button1: TButton;
    dsRec: TDataSource;
    DBGrid1: TDBGrid;
    edCodCliente: TEdit;
    edNomeCliente: TEdit;
    Cliente: TLabel;
    Label1: TLabel;
    edTotalGeral: TMaskEdit;
    Label2: TLabel;
    edPago: TMaskEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    rgSituacao: TRadioGroup;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edCodClienteKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
  private
    codClienteR : Integer;
  public

  end;

var
  fRecebimento: TfRecebimento;

implementation

{$R *.lfm}

{ TfRecebimento }

procedure TfRecebimento.Button1Click(Sender: TObject);
begin
  if (edCodCliente.Text <> '') then
    fClienteBusca.cCodCliente:=StrToInt(edCodCliente.Text);
  fClienteBusca.ShowModal;
  edNomeCliente.Text := fClienteBusca.cNomeCliente;
  codClienteR := fClienteBusca.cCodCliente;
  edCodCliente.Text := IntToStr(codClienteR);
end;

procedure TfRecebimento.edCodClienteKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if (edCodCliente.Text <> '') then
    begin
      fClienteBusca.cCodCliente := StrToInt(edCodCliente.Text);
      fClienteBusca.BuscaCliente;
      edNomeCliente.Text := fClienteBusca.cNomeCliente;
      btnProcurar.SetFocus;
    end;
  end;
end;

procedure TfRecebimento.FormCreate(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName:='CODRECEBIMENTO';
  DBGrid1.Columns[1].FieldName:='TITULO';
  DBGrid1.Columns[2].FieldName:='EMISSAO';
  DBGrid1.Columns[3].FieldName:='DATAVENCIMENTO';
  DBGrid1.Columns[4].FieldName:='VALOR_RESTO';
  DBGrid1.Columns[4].DisplayFormat:=',##0.00';
end;

procedure TfRecebimento.btnProcurarClick(Sender: TObject);
var
  sql_rec: String;
  total_rec : Double;
begin
  // buscar contas (recebimento)
  total_rec := 0;
  sql_rec := 'SELECT CODRECEBIMENTO, TITULO, EMISSAO, DATAVENCIMENTO ';
  sql_rec += ', VALOR_RESTO FROM RECEBIMENTO ';
  sql_rec += ' WHERE VALOR_RESTO > 0';
  if (edCodCliente.Text <> '') then
  begin
    sql_rec += ' AND CODCLIENTE = ' + edCodCliente.Text;
  end;
  Case rgSituacao.ItemIndex of
    0 : sql_rec += ' AND STATUS  = ' + QuotedStr('5-');
    1 : sql_rec += ' AND STATUS  = ' + QuotedStr('7-');
    2 : sql_rec += ' AND STATUS  IN (' +
       QuotedStr('5-') + ',' + QuotedStr('7-') + ')';
  end;
  sql_rec += ' ORDER BY DATAVENCIMENTO, EMISSAO, TITULO';
  dmPdv.busca_sql(sql_rec);
  While not dmPdv.sqBusca.EOF do
  begin
    total_rec += dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat;
    dmPdv.sqBusca.Next;
  end;
  dmPdv.sqBusca.First;
  edTotalGeral.Text := FormatFloat('#,,,0.00',total_rec);
end;

procedure TfRecebimento.btnConfirmaClick(Sender: TObject);
var
  vlr_pg: Double;
  vlr_rt: Double;
  str_rec : String;
  //vRec : TRecebimento;
begin
  // baixar pagamentos
  if (edPago.Text = '0,00') then
  begin
    ShowMessage('Informe o Valor Pago');
    Exit;
  end;
  vlr_pg := StrToFloat(edPago.Text);
  vlr_rt := vlr_pg;
  dmPdv.sqBusca.First;
  DecimalSeparator:='.';
  While vlr_rt > 0 do
  begin
    While not dmPdv.sqBusca.EOF do
    begin
      if (dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat > vlr_rt) then
      begin
        // duplico o lancamento na recebimento
        // este novo item o valor vai ser a diferenca do pago
        // um vai ficar em aberto o outro como pago
        str_rec := 'INSERT INTO RECEBIMENTO (  ' +
          ' CODRECEBIMENTO, TITULO, EMISSAO, CODCLIENTE, DATAVENCIMENTO' +
          ', CAIXA, STATUS, VIA, CODVENDA, CODALMOXARIFADO, CODVENDEDOR' +
          ', CODUSUARIO, DATASISTEMA, VALOR_PRIM_VIA, VALOR_RESTO, VALORTITULO' +
          ', PARCELAS) SELECT ' +
          ' CODRECEBIMENTO, TITULO, EMISSAO, CODCLIENTE, DATAVENCIMENTO' +
          ', CAIXA, STATUS, VIA, CODVENDA, CODALMOXARIFADO, CODVENDEDOR' +
          ', CODUSUARIO, DATASISTEMA, VALOR_PRIM_VIA, VALOR_RESTO, VALORTITULO' +
          ', PARCELAS FROM RECEBIMENTO WHERE CODRECEBIMENTO = ';

        vlr_pg := vlr_rt;
      end
      else begin
        vlr_pg := dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat;
      end;

      dmPdv.executaSql('UPDATE RECEBIMENTO SET STATUS = ' +
        QuotedStr('7-') + ', VALORRECEBIDO = ' + FloattoStr(vlr_pg) +
        ' WHERE CODRECEBIMENTO = ' +
        IntToStr(dmPdv.sqBusca.FieldByName('CODRECEBIMENTO').asInteger));
      vlr_rt -= vlr_pg;
      dmPdv.sqBusca.Next;
    end;
  end;
  DecimalSeparator:=',';

end;

procedure TfRecebimento.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.

