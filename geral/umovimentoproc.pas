unit uMovimentoProc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, DBGrids, ActnList, MaskEdit, Buttons,
   udmpdv, uabrircaixa, usangria, uVendedorBusca, uAbrirCaixa2, usaldo;

type

  { TfMovimentoProc }

  TfMovimentoProc = class(TForm)
    acBuscar: TAction;
    acFechar: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    btnSair: TBitBtn;
    btnConfirma: TBitBtn;
    btnProcurar: TBitBtn;
    btnSangria: TBitBtn;
    btnFecharCaixa: TBitBtn;
    btnReforco: TBitBtn;
    cbValorBusca: TComboBox;
    dsMovProc: TDataSource;
    edDataIni: TDateTimePicker;
    edDataFim: TDateTimePicker;
    DBGrid1: TDBGrid;
    edValorBusca: TMaskEdit;
    edTotalTroca: TMaskEdit;
    edLiquido: TMaskEdit;
    edVendedor: TEdit;
    edVendedorNome: TEdit;
    Label1: TLabel;
    edPedido: TLabeledEdit;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edValorTotal: TMaskEdit;
    edQtdeLancamento: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel3: TPanel;
    pnMemo: TPanel;
    rgForma: TRadioGroup;
    rgStatus: TRadioGroup;
    procedure acBuscarExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnFecharCaixaOdooClick(Sender: TObject);
    procedure btnFecharCaixaClick(Sender: TObject);
    procedure btnPROCClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure btnReforcoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
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

procedure TfMovimentoProc.btnProcurarClick(Sender: TObject);
begin
  acBuscar.Execute;
end;

procedure TfMovimentoProc.btnReforcoClick(Sender: TObject);
begin
  // Reforco
  fSangria.SangriaReforco:= 'Reforco';
  fSangria.Caption := 'Reforço';
  fSangria.Label6.Caption := 'Incluir Reforço';
  fSangria.Label7.Caption := 'Saldo em Caixa';
  fSangria.PanelSangria.Visible := False;
  fSangria.Edit1.Visible := True;
  fSangria.btnInsereMotivo.Visible := True;
  fSangria.GroupAbreCaixa.Visible := True;
  fSangria.btnReimprimirReforco.Visible:= True;
  fSangria.DBGrid2.Visible:= True;
  fSangria.ComboBox1.ItemIndex := 1;
  fSangria.ShowModal;
end;

procedure TfMovimentoProc.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfMovimentoProc.acBuscarExecute(Sender: TObject);
var sqlProc: String;
  total, troca, liquido : Double;
  qtde: Integer;
  vlrBusca : String;
  cod_venda_str: String;
begin
  sqlProc := 'SELECT m.CODMOVIMENTO, m.CONTROLE, m.DATA_SISTEMA as DATAMOVIMENTO, v.CODVENDA ';
  sqlProc += ' , u.NOMEUSUARIO as  VENDEDOR, c.NOMECLIENTE as CLIENTE ';
  sqlProc += ' ,CASE WHEN COALESCE(f.VALOR_PAGO, 0) > 0 THEN f.VALOR_PAGO WHEN COALESCE(v.VALOR, 0) > 0 THEN (v.VALOR-v.DESCONTO) ELSE ';
  sqlProc += ' (SELECT SUM(VALTOTAL) FROM MOVIMENTODETALHE MD WHERE MD.CODMOVIMENTO ';
  sqlProc += ' = m.CODMOVIMENTO) END ';
  sqlProc += ' AS VALOR, v.SERIE, m.STATUS ';
  sqlProc += ' ,((m.data_fechou-m.DATA_SISTEMA)*24*60) AS TEMPO ';
  sqlProc += ' , f.forma_pgto,  f.n_doc ';
  sqlProc += ' FROM MOVIMENTO m  ';
  sqlProc += ' INNER JOIN CLIENTES c ON c.CODCLIENTE = m.CODCLIENTE';
  sqlProc += ' LEFT OUTER JOIN USUARIO u ON m.codVendedor = u.codUsuario';
  sqlProc += ' LEFT OUTER JOIN VENDA v ON v.CODMOVIMENTO = m.CODMOVIMENTO ';
  sqlProc += ' LEFT OUTER join forma_entrada f on (m.codmovimento = f.id_entrada and f.state = 1)';
  Case rgStatus.ItemIndex of
    0 : sqlProc += ' WHERE m.STATUS IN (0,1) ';
    1 : sqlProc += ' WHERE m.STATUS = 1 ';
    2 : sqlProc += ' WHERE m.STATUS = 2 ';
    3 : sqlProc += ' WHERE m.STATUS = 1 AND v.SERIE LIKE ' + QuotedStr('NFCE%');
    4 : sqlProc += ' WHERE m.STATUS = 9 ';
  end;

  Case rgForma.ItemIndex of
    0 : sqlProc += '' ;
    1 : sqlProc += ' AND f.FORMA_PGTO = ' + QuotedStr('1') ;
    2 : sqlProc += ' AND f.FORMA_PGTO = ' + QuotedStr('2') ;
    3 : sqlProc += ' AND f.FORMA_PGTO = ' + QuotedStr('3') ;
    4 : sqlProc += ' AND f.FORMA_PGTO = ' + QuotedStr('4') ;
    5 : sqlProc += ' AND f.FORMA_PGTO = ' + QuotedStr('5') ;
    6 : sqlProc += ' AND f.FORMA_PGTO = ' + QuotedStr('6') ;
    7 : sqlProc += ' AND f.FORMA_PGTO = ' + QuotedStr('9') ;

  end;


  if (rgStatus.ItemIndex = 4) then
    sqlProc += ' AND m.CODNATUREZA = 1 '
  else
    sqlProc += ' AND m.CODNATUREZA = 3 ';
  // sqlProc += ' AND m.CODALMOXARIFADO = ' + dmPdv.ccusto;  tem q ser usuario
  // pois o  CCUSTO muda com o caixa todo dia
  sqlProc += ' AND m.CODCLIENTE > 0 ';
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
  if (edVendedor.Text <> '') then
  begin
    sqlProc += ' AND m.CODVENDEDOR = ' + edVendedor.Text;
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
  cod_venda_str:='';
  while not dmPdv.sqBusca.EOF do
  begin
    qtde := qtde + 1;
    total := total + dmPdv.sqBusca.FieldByName('VALOR').AsFloat;
    if (not dmPdv.sqBusca.FieldByName('CODVENDA').IsNull) then
    begin
      if (cod_venda_str = '') then
        cod_venda_str += IntToStr(dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger)
      else
        cod_venda_str += ',' + IntToStr(dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger)
    end;
    dmPdv.sqBusca.Next;
  end;
  edValorTotal.Text:= FormatFloat('#,,,0.00',total);
  edQtdeLancamento.Text:= FormatFloat('#,,,0',qtde);
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    dmPdv.sqBusca.First;
    codMovimentoProc := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
    codVendaProc     := dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger;
  end;
  edTotalTroca.Text:='0,00';
  troca := 0;
  if (cod_venda_str <> '') then
  begin
    dmpdv.sqBusca1.Close;
    dmpdv.sqBusca1.SQL.Clear;
    dmpdv.sqBusca1.sql.Add('SELECT SUM(VALOR_PAGO) AS VLR FROM FORMA_ENTRADA ' +
      'WHERE COD_VENDA IN (' + cod_venda_str + ')' +
      '  AND N_DOC = ' + QuotedStr('9-Devol./Troca') + 'AND STATE = ' + QuotedStr('1')  );
    dmpdv.sqBusca1.Open;
    if (not dmpdv.sqBusca1.IsEmpty) then
    begin
      troca := dmPdv.sqBusca1.FieldByName('VLR').AsFloat;
      edTotalTroca.Text:= FormatFloat('#,,,0.00',troca);
    end;
  end;
  liquido := total - troca;
  edLiquido.Text:= FormatFloat('#,,,0.00',liquido);
end;

procedure TfMovimentoProc.acFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMovimentoProc.BitBtn1Click(Sender: TObject);
begin
  fsaldo.ShowModal;
end;

procedure TfMovimentoProc.BitBtn3Click(Sender: TObject);
begin
  if (edVendedor.Text <> '') then
    fVendedorBusca.uCodVendedor:=StrToInt(edVendedor.Text);
  fVendedorBusca.ShowModal;
  edVendedorNome.Text := fVendedorBusca.uNomeVendedor;
  edVendedor.Text := IntToStr(fVendedorBusca.uCodVendedor);
end;

procedure TfMovimentoProc.btnConfirmaClick(Sender: TObject);
begin
  Close;
end;

procedure TfMovimentoProc.btnFecharCaixaOdooClick(Sender: TObject);
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
var nao_fechado: String;
  pedido: String;
  tamanho: Integer;
begin
  if (btnFecharCaixa.Caption = 'Abrir Caixa') then
  begin
    fAbreCaixa.ShowModal;
    btnFecharCaixa.Caption:= 'Fechar Caixa';
  end
  else begin
    rgStatus.ItemIndex := 0;
    acBuscar.Execute;
    dmPdv.sqBusca.First;
    nao_fechado := '';
    while not dmPdv.sqBusca.EOF do
    begin
      pedido := IntToStr(dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger);
      if ((dmPdv.sqBusca.FieldByName('STATUS').AsInteger = 0) and
        (dmPdv.sqBusca.FieldByName('VALOR').AsFloat > 0)) then
      begin
        nao_fechado += pedido + ', ';
      end;
      dmPdv.sqBusca.Next;
    end;
    if (nao_fechado <> '') then
    begin
      ShowMessage('Existe pedidos nao Encerrados : ' + nao_fechado);
    end;
    fAbrirCaixa.AbrirFechar:= 'Fechar';
    fAbrirCaixa.cxsangria := 0 ;
    fAbrirCaixa.ShowModal;
    acBuscar.Execute;
  end;
end;

procedure TfMovimentoProc.btnSALVClick(Sender: TObject);
begin
  Close;
end;

procedure TfMovimentoProc.btnSangriaClick(Sender: TObject);
begin
  //fSangria.ShowModal;
  fSangria.SangriaReforco:= 'Sangria';
  fSangria.Caption := 'Sangria';
  fSangria.Label6.Caption := 'Incluir Sangria';
  fSangria.Label7.Caption := 'Disponivel Sangria';
  fSangria.PanelSangria.Visible := True;
  fSangria.Edit1.Visible := False;
  fSangria.btnInsereMotivo.Visible := False;
  fSangria.GroupAbreCaixa.Visible := False;
  fSangria.btnReimprimirReforco.Visible:= False;
  fSangria.DBGrid2.Visible:= False;
  fSangria.ComboBox1.ItemIndex := 0;
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
  DBGrid1.Columns[7].FieldName:='TEMPO';
  DBGrid1.Columns[7].DisplayFormat:=',##0.00';
  DBGrid1.Columns[8].FieldName:='N_DOC';
end;

procedure TfMovimentoProc.FormShow(Sender: TObject);
begin
  codMovimentoProc:=0;
  codVendaProc:=0;
  edDataIni.Date:=Now;
  edDataFim.Date:=Now;
  //if ((dmPdv.nomeCaixa = 'FECHADO')  and (UpperCase(dmPdv.usoSistema) <> 'ODOO'))then
  if (dmPdv.nomeCaixa = 'FECHADO') then
  begin
    btnFecharCaixa.Caption:= 'Abrir Caixa';
  end;
  acBuscar.Execute;
end;

end.

