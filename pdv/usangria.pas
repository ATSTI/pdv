unit usangria;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  Buttons, MaskEdit, StdCtrls, ExtCtrls, DBGrids, udmpdv, fphttpclient, fpjson,
  uIntegraSimples;

type

  { TfSangria }

  TfSangria = class(TForm)
    btnInsereMotivo: TBitBtn;
    btnFechar: TBitBtn;
    btnGravar: TBitBtn;
    btnReimprimir: TButton;
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    dsSangrias: TDataSource;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edMotivo: TMaskEdit;
    edValor: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    memoResult: TMemo;
    PanelSangria: TPanel;
    sqSangrias: TSQLQuery;
    sqPagamento: TSQLQuery;
    sqPagamentoCAIXA: TSmallintField;
    sqPagamentoCAIXINHA: TFloatField;
    sqPagamentoCODFORMA: TLongintField;
    sqPagamentoCOD_VENDA: TLongintField;
    sqPagamentoDESCONTO: TFloatField;
    sqPagamentoFORMA_PGTO: TStringField;
    sqPagamentoID_ENTRADA: TLongintField;
    sqPagamentoN_DOC: TStringField;
    sqPagamentoSTATE: TSmallintField;
    sqPagamentoTROCO: TFloatField;
    sqPagamentoVALOR_PAGO: TFloatField;
    sqSangriasCAIXA: TSmallintField;
    sqSangriasCAIXINHA: TFloatField;
    sqSangriasCODFORMA: TLongintField;
    sqSangriasCOD_VENDA: TLongintField;
    sqSangriasDESCONTO: TFloatField;
    sqSangriasFORMA_PGTO: TStringField;
    sqSangriasID_ENTRADA: TLongintField;
    sqSangriasN_DOC: TStringField;
    sqSangriasSTATE: TSmallintField;
    sqSangriasTROCO: TFloatField;
    sqSangriasVALOR_PAGO: TFloatField;
    procedure btnInsereMotivoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnReimprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public
    abri_cx : integer;
    SangriaReforco: String;
    procedure Sangria();
    procedure EnviaSangria;

  end;

var
  fSangria: TfSangria;

implementation
  uses uPdv,uMovimentoProc;
{$R *.lfm}

{ TfSangria }


procedure TfSangria.btnGravarClick(Sender: TObject);
var
  IMPRESSORA:TextFile;
begin
  if (ComboBox1.ItemIndex = -1) then
  begin
    ShowMessage('Informar o Tipo de Sangria ' + SangriaReforco);
    exit;
  end;
  if (edValor.Text = '') then
  begin
    ShowMessage('Informar Valor ' + SangriaReforco);
    exit;
  end;
  if (edMotivo.text = '') then
  begin
    ShowMessage('Informar Motivo ' + SangriaReforco);
    exit;
  end;

  Sangria();


  if (dmPdv.CupomImp = 'Texto') then
  begin
    AssignFile(IMPRESSORA, dmPdv.portaIMP);
  end
  else begin
    AssignFile(IMPRESSORA, dmPdv.path_imp);
  end;

  try
    Rewrite(IMPRESSORA);
    //lFile.LoadFromFile('caixa.txt');
    Writeln(IMPRESSORA, '');
    Writeln(Impressora, SangriaReforco + ' CAIXA');
    Writeln(IMPRESSORA, FormatDateTime('dd/mm/yyyy hh:MM:ss', Now));
    Writeln(IMPRESSORA, '');
    Writeln(Impressora, 'CAIXA : ' + dmPdv.nomeCaixa);
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Valor       - ' + edValor.Text);
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Motivo :');
    if (Length(edMotivo.Text) > dmPdv.tamanhoLinha) then
    begin
      Writeln(IMPRESSORA, Copy(edMotivo.Text,0,dmPdv.tamanhoLinha));
      Writeln(IMPRESSORA, Copy(edMotivo.Text,dmPdv.tamanhoLinha+1,dmPdv.tamanhoLinha));
    end
    else begin
        Writeln(IMPRESSORA, edMotivo.Text);
    end;
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Assinatura :');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '------------------------------');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
  finally
    CloseFile(IMPRESSORA);
  end;

  ShowMessage('Gravado com Sucesso!');
 // close;
  if (UpperCase(dmpdv.usoSistema) = 'ODOO') then
  begin
    EnviaSangria;
  end;
  abri_cx := 1;
  btnFechar.Click;
  fMovimentoProc.Close;
  fPdv.procFormShow;

end;

procedure TfSangria.btnReimprimirClick(Sender: TObject);
var
  IMPRESSORA:TextFile;
begin
    if (dmPdv.CupomImp = 'Texto') then
  begin
    AssignFile(IMPRESSORA, dmPdv.portaIMP);
  end
  else begin
    AssignFile(IMPRESSORA, dmPdv.path_imp);
  end;

  try
    Rewrite(IMPRESSORA);
    //lFile.LoadFromFile('caixa.txt');
    Writeln(IMPRESSORA, 'Reimpressao');
    Writeln(Impressora, 'Sangria' + ' CAIXA');
    Writeln(IMPRESSORA, FormatDateTime('dd/mm/yyyy hh:MM:ss', Now));
    Writeln(IMPRESSORA, '');
    Writeln(Impressora, 'CAIXA : ' + sqSangriasCAIXA.AsString);
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Valor  - ' + FormatFloat(',##0.00', sqSangriasVALOR_PAGO.AsCurrency));
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Motivo :');
    if (Length(sqSangriasN_DOC.AsString) > dmPdv.tamanhoLinha) then
    begin
      Writeln(IMPRESSORA, Copy(sqSangriasN_DOC.AsString,0,dmPdv.tamanhoLinha));
      Writeln(IMPRESSORA, Copy(sqSangriasN_DOC.AsString,dmPdv.tamanhoLinha+1,dmPdv.tamanhoLinha));
    end
    else begin
        Writeln(IMPRESSORA,sqSangriasN_DOC.AsString);
    end;
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Assinatura :');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '------------------------------');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, '');
  finally
    CloseFile(IMPRESSORA);
  end;
end;



procedure TfSangria.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  sqSangrias.Active:= False;
end;

procedure TfSangria.FormShow(Sender: TObject);
begin
  edMotivo.Text := '';
  edValor.Text := '0,00';
  fSangria.sqSangrias.Active:= True;
  Edit1.Text := dmPdv.nomeCaixa;
end;

procedure TfSangria.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfSangria.btnInsereMotivoClick(Sender: TObject);
begin
  edMotivo.Text:= 'Abrir ' + Edit1.Text ;
end;

procedure TfSangria.Sangria();
var
  codForma: integer;
  vlrSangria: double;
  Campo : String;
  forma_pag : String;
  Valor : String;
  tipo :integer;
  postJson : TJSONObject;
  httpClient : TFPHttpClient;
  fInteg: TfIntegracaoOdoo;
  responseData: String;
begin
  if (dmPdv.sqGenerator.Active) then
    dmPdv.sqGenerator.Close;
  dmPdv.sqGenerator.SQL.Clear;
  dmPdv.sqGenerator.SQL.Text := 'SELECT CAST(GEN_ID(GEN_FORMA, 1) AS INTEGER) ' +
    'AS CODIGO FROM RDB$DATABASE';
  dmPdv.sqGenerator.Open;
  codForma := dmPdv.sqGenerator.Fields[0].AsInteger;
  dmPdv.sqGenerator.Close;
  sqPagamento.Open;
  sqPagamento.Insert;
  sqPagamentoCODFORMA.AsInteger  := codForma;
  sqPagamentoCAIXA.AsInteger     := StrToInt(dmPdv.idcaixa);
  if SangriaReforco = 'Sangria' then
  begin
    sqPagamentoCOD_VENDA.AsInteger := 1;
    tipo := 1;
  end
  else begin
    sqPagamentoCOD_VENDA.AsInteger := 0;
    tipo := 0;
  end;
  {Sangria
   Recebimento Cliente
   Pagamento Fornecedor
   Retirada Uso
   Pagamento Func.(Vale)
   Outros}
  Case ComboBox1.ItemIndex of
    0: forma_pag := 'S';
    1: forma_pag := 'R';
    2: forma_pag := 'F';
    3: forma_pag := 'U';
    4: forma_pag := 'V';
    5: forma_pag := 'T';
  end;

  //ComboBox1.ItemIndex
  sqPagamentoFORMA_PGTO.AsString := forma_pag;
  sqPagamentoID_ENTRADA.AsInteger:= StrToINT(dmPdv.idcaixa);
  sqPagamentoN_DOC.AsString      := edMotivo.Text;
  sqPagamentoSTATE.AsInteger     := 1;
  vlrSangria := StrToFloat(edValor.Text);
  //DecimalSeparator:='.';
  sqPagamentoVALOR_PAGO.AsFloat := vlrSangria;
  //DecimalSeparator:=',';
  sqPagamentoDESCONTO.AsFloat    := 0;
  sqPagamentoTROCO.AsFloat       := 0;
  sqPagamento.ApplyUpdates;
  dmPdv.sTrans.Commit;
  //dmpdv.gera_integra_caixa_mov;
  //dmpdv.integra_caixa_mov;

  // rotina de envio para o ODoo se usar o odoo
  // 21/07/2023 parece errado abaixo esta executando a consulta do caixa
  {if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
      httpClient := TFPHttpClient.Create(Nil);
    postJson := TJSONObject.Create;
    try
      postJson.Add('title', 'Sangria/Reforço');
      postJson.Add('caixa',dmPdv.idcaixa);
      postJson.Add('cod_venda',tipo);
      postJson.Add('valor',edValor.Text);
      postJson.Add('cod_forma',codForma);
      postJson.Add('diario','1-');
      postJson.Add('situacao','O');

      fInteg := TfIntegracaoOdoo.Create(Self);
      httpClient := fInteg.logar();
      With httpClient do
      begin
        AddHeader('Content-Type', 'application/json');
        RequestBody := TStringStream.Create(postJson.AsJSON);
        responseData := Post(dmPdv.path_integra_url + '/caixaconsulta');
        //memoResult.Lines.Add(responseData);
      end;
      fInteg.Free;
      postJson.Free;
    except
    end;
  end;}
end;

procedure TfSangria.EnviaSangria;
var
  vlrSangria: double;
  Campo : String;
  forma_pag : String;
  Valor : String;
  tipo :integer;
  fInteg: TfIntegracaoOdoo;
  responseData: String;
  sql_str , pedidos: string;
  postJson : TJSONObject;
  httpClient : TFPHttpClient;
begin
  dmPdv.sqBusca1.Close;
  dmPdv.sqBusca1.Sql.Clear;
  sql_str := 'SELECT CAIXA,N_DOC,VALOR_PAGO,CODFORMA ,COD_VENDA ';
  sql_str += 'FROM FORMA_ENTRADA  ';
  sql_str += 'WHERE CAIXA = ' + QuotedStr(dmPdv.idcaixa);
  sql_str += 'AND COD_VENDA IN (0,1,2)';
  sql_str += 'ORDER BY CODFORMA DESC ';
  dmPdv.sqBusca1.SQL.Add(sql_str);
  dmPdv.sqBusca1.Open;
  DecimalSeparator:='.';
  pedidos := '[{';
  while not dmPdv.sqBusca1.EOF do
  begin
    if pedidos <> '[{' then
      pedidos += '}, {';
    pedidos += '"caixa": "' + IntToStr(dmPdv.sqBusca1.Fields[0].AsInteger) + '",' +
      '"motivo": "' + dmPdv.sqBusca1.Fields[1].AsString + '",' +
      '"valor": "' + FloatToStr(dmPdv.sqBusca1.Fields[2].AsFloat) + '",' +
      '"codforma": "' + IntToStr(dmPdv.sqBusca1.Fields[3].AsInteger) + '",'+
     '"codvenda": "' + IntToStr(dmPdv.sqBusca1.Fields[4].AsInteger) + '"';
    dmPdv.sqBusca1.Next;
  end;
  pedidos += '}]';
  memoResult.Lines.Add(pedidos);

  httpClient := TFPHttpClient.Create(Nil);
  postJson := TJSONObject.Create;
  try
    postJson.Add('title', 'Sangria/Reforço');
    postJson.Add('todos', pedidos);
    fInteg := TfIntegracaoOdoo.Create(Self);
    httpClient := fInteg.logar();
    With httpClient do
    begin
      AddHeader('Content-Type', 'application/json');
      RequestBody := TStringStream.Create(postJson.AsJSON);
      responseData := Post(dmPdv.path_integra_url + '/enviasangria');
      //memoDados.Lines.Add(responseData);
    end;
    fInteg.Free;
    postJson.Free;
  except
  end;

end;

end.

