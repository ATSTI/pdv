unit uMovimentoProc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, DBGrids, ActnList, MaskEdit, Buttons,
   udmpdv, uabrircaixa;

type

  { TfMovimentoProc }

  TfMovimentoProc = class(TForm)
    acBuscar: TAction;
    acFechar: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    btnSangria: TBitBtn;
    btnFecharCaixa: TBitBtn;
    btnEXC: TImage;
    btnPROC: TImage;
    btnSALV: TImage;
    cbValorBusca: TComboBox;
    dsMovProc: TDataSource;
    edDataIni: TDateTimePicker;
    edDataFim: TDateTimePicker;
    DBGrid1: TDBGrid;
    edValorBusca: TMaskEdit;
    Label1: TLabel;
    edPedido: TLabeledEdit;
    Label2: TLabel;
    Label3: TLabel;
    edValorTotal: TMaskEdit;
    edQtdeLancamento: TMaskEdit;
    Label4: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pnMemo: TPanel;
    rgStatus: TRadioGroup;
    procedure acBuscarExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnFecharCaixaClick(Sender: TObject);
    procedure btnPROCClick(Sender: TObject);
    procedure btnSALVClick(Sender: TObject);
    procedure btnSangriaClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure edPedidoKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    codMovimentoProc: Integer;
    codVendaProc: Integer;
  end;

var
  fMovimentoProc: TfMovimentoProc;

implementation

{$R *.lfm}

{ TfMovimentoProc }

procedure TfMovimentoProc.btnPROCClick(Sender: TObject);
begin
  acBuscar.Execute;
end;

procedure TfMovimentoProc.acBuscarExecute(Sender: TObject);
var sqlProc: String;
  total : Double;
  qtde: Integer;
  vlrBusca : String;
begin
  sqlProc := 'SELECT m.CODMOVIMENTO, m.CONTROLE, m.DATA_SISTEMA as DATAMOVIMENTO, v.CODVENDA ';
  sqlProc += ' , u.NOMEUSUARIO as  VENDEDOR, c.NOMECLIENTE as CLIENTE ';
  sqlProc += ' ,COALESCE(CASE WHEN v.ENTRADA > 0 THEN v.ENTRADA ELSE v.VALOR END, 0) AS VALOR, v.SERIE, m.STATUS ';
  sqlProc += ' FROM MOVIMENTO m  ';
  sqlProc += ' INNER JOIN CLIENTES c ON c.CODCLIENTE = m.CODCLIENTE';
  sqlProc += ' LEFT OUTER JOIN USUARIO u ON m.codVendedor = u.codUsuario';
  sqlProc += ' LEFT OUTER JOIN VENDA v ON v.CODMOVIMENTO = m.CODMOVIMENTO ';
  Case rgStatus.ItemIndex of
    0 : sqlProc += ' WHERE m.STATUS > -1 ';
    1 : sqlProc += ' WHERE m.STATUS > 0 ';
    2 : sqlProc += ' WHERE m.STATUS = 2 ';
    3 : sqlProc += ' WHERE m.STATUS = 1 AND v.SERIE LIKE ' + QuotedStr('NFCE%');
  end;
  // sqlProc += ' AND m.CODALMOXARIFADO = ' + dmPdv.ccusto;  tem q ser usuario
  // pois o  CCUSTO muda com o caixa todo dia
  sqlProc += ' AND m.CODUSUARIO = ' + dmPdv.varLogado;
  if (edPedido.Text = '') then
  begin
    sqlProc += ' AND m.DATAMOVIMENTO BETWEEN ';
    sqlProc += QuotedStr(FormatDateTime( 'mm-dd-yyyy', edDataIni.Date));
    sqlProc += '   AND ';
    sqlProc += QuotedStr(FormatDateTime( 'mm-dd-yyyy', edDataFim.Date));
  end;
  if edValorBusca.Text <> '0,00' then
  begin
    vlrBusca  := StringReplace(edValorBusca.Text,'.','',[rfReplaceAll]);
    vlrBusca  := StringReplace(vlrBusca,',','.',[rfReplaceAll]);
    Case cbValorBusca.ItemIndex of
      0 : sqlProc += ' AND v.VALOR > ' + vlrBusca;
      1 : sqlProc += ' AND v.VALOR < ' + vlrBusca;
      2 : sqlProc += ' AND v.VALOR = ' + vlrBusca;
    end;
  end;
  if (edPedido.Text <> '') then
  begin
    sqlProc += ' AND m.CODMOVIMENTO = ' + edPedido.Text;
  end;
  sqlProc += '  ORDER BY m.CODMOVIMENTO DESC ';
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlProc);
  dmPdv.sqBusca.Active:=True;
  total := 0;
  qtde := 0;
  while not dmPdv.sqBusca.EOF do
  begin
    qtde := qtde + 1;
    total := total + dmPdv.sqBusca.FieldByName('VALOR').AsFloat;
    dmPdv.sqBusca.Next;
  end;
  edValorTotal.Text:= FormatFloat('#,,,0.00',total);
  edQtdeLancamento.Text:= FormatFloat('#,,,0',qtde);
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    codMovimentoProc := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
    codVendaProc     := dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger;
  end;
  dmPdv.sqBusca.First;
  codMovimentoProc := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
  codVendaProc     := dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger
end;

procedure TfMovimentoProc.acFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMovimentoProc.BitBtn1Click(Sender: TObject);
var nao_fechado: String;
  pedido: String;
  tamanho: Integer;
begin
  // Fechando o caixa (libera no odoo o fechamento)
  rgStatus.ItemIndex := 0;
  acBuscar.Execute;
  dmPdv.sqBusca.First;
  nao_fechado := '';
  while not dmPdv.sqBusca.EOF do
  begin
    pedido := IntToStr(dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger);
    if (dmPdv.sqBusca.FieldByName('STATUS').AsInteger = 0) then
    begin
      nao_fechado += pedido + ', ';
    end;
    dmPdv.sqBusca.Next;
  end;
  if (nao_fechado <> '') then
  begin
    ShowMessage('Existe pedidos nao Encerrados : ' + nao_fechado);
    Exit;
  end;
  dmPdv.IbCon.ExecuteDirect('UPDATE CAIXA_CONTROLE SET VALORFECHA = 1 ' +
        ' , SITUACAO = ' + QuotedStr('F') +
        ' WHERE NOMECAIXA = ' + QuotedStr(dmPdv.nomeCaixa));
  dmPdv.nomeCaixa := 'FECHADO';
  dmPdv.sTrans.Commit;
  //try
  //  pnMemo.Visible:=True;
  //  Memo1.Lines.LoadFromFile(dmPdv.path_script + '\' + 'atsOrder.py');
    {
    if PythonEngine1.IsHandleValid then
    begin
      PythonEngine1.ExecStrings((Memo1.Lines));
      tamanho := Length(Memo1.Text);
      Memo1.SelStart := tamanho;
      Memo1.SetFocus;
    end
    else begin
      writeln('Erro para carregar sistema!', dynlibs.GetLoadErrorStr);
    end;}
  //finally
  //  pnMemo.Visible:=False;
  //end;
end;

procedure TfMovimentoProc.btnFecharCaixaClick(Sender: TObject);
begin
  fAbrirCaixa.AbrirFechar:= 'Fechar';
  fAbrirCaixa.ShowModal;
end;

procedure TfMovimentoProc.btnSALVClick(Sender: TObject);
begin
  //codMovimentoProc := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
  //codVendaProc     := dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger;
  Close;
end;

procedure TfMovimentoProc.btnSangriaClick(Sender: TObject);
begin
  fSangria.Sangria:= 'Sangria';
  fSangria.ShowModal;
end;

procedure TfMovimentoProc.DBGrid1CellClick(Column: TColumn);
begin
  codMovimentoProc := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
  codVendaProc     := dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger;
end;

procedure TfMovimentoProc.edPedidoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if (edPedido.Text <> '') then
    begin
      acBuscar.Execute;
    end;
  end;
end;

procedure TfMovimentoProc.FormCreate(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName:='CODMOVIMENTO';
  DBGrid1.Columns[1].FieldName:='DATAMOVIMENTO';
  DBGrid1.Columns[2].FieldName:='CONTROLE';
  DBGrid1.Columns[3].FieldName:='SERIE';
  DBGrid1.Columns[4].FieldName:='VENDEDOR';
  DBGrid1.Columns[5].FieldName:='CLIENTE';
  DBGrid1.Columns[6].FieldName:='VALOR';
  DBGrid1.Columns[6].DisplayFormat:=',##0.00';
end;

procedure TfMovimentoProc.FormShow(Sender: TObject);
begin
  codMovimentoProc:=0;
  codVendaProc:=0;
  edDataIni.Date:=Now;
  edDataFim.Date:=Now;
  acBuscar.Execute;
end;

end.

