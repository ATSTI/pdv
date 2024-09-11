unit uReceber;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, DBGrids, MaskEdit, ActnList, Grids, DBCtrls, DBDateTimePicker,
  DateTimePicker, uClienteBusca, udmpdv, uIntegraSimples, db, math, sqldb,
  pqconnection, IniFiles, fpjson, fphttpclient, Types, DateUtils;

type

  { TfRecebimento }

  TfRecebimento = class(TForm)
    acDinheiro: TAction;
    acDebito: TAction;
    acCredito: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn24: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn9: TBitBtn;
    btnConfirma: TBitBtn;
    btnProcurar: TBitBtn;
    btnSair: TBitBtn;
    Button1: TButton;
    DateTimePicker1: TDateTimePicker;
    dsRec: TDataSource;
    DBGrid1: TDBGrid;
    edCodCliente: TEdit;
    edLimit: TEdit;
    edNomeCliente: TEdit;
    Cliente: TLabel;
    edJurosMulta: TMaskEdit;
    edPago1: TMaskEdit;
    edJuros: TMaskEdit;
    Label1: TLabel;
    edTotalGeral: TMaskEdit;
    Label10: TLabel;
    Label2: TLabel;
    edPago: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblForma: TLabel;
    lblGrava: TLabel;
    Memo1: TMemo;
    memoResult: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    conOdoo: TPQConnection;
    pnCartoes: TPanel;
    rgSituacao: TRadioGroup;
    sqlOdoo: TSQLQuery;
    sqlOdoocodrecebimento: TLongintField;
    sqlOdoodatarecebimento: TMemoField;
    sqlOdoodatavencimento: TDateField;
    sqlOdooemissao: TDateField;
    sqlOdooinvoice_id: TLongintField;
    sqlOdoonomecliente: TStringField;
    sqlOdooreconciled: TBooleanField;
    sqlOdootitulo: TStringField;
    sqlOdoovalortitulo: TBCDField;
    sqlOdoovalor_resto: TBCDField;
    StringGrid1: TStringGrid;
    transODoo: TSQLTransaction;
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
    procedure acCreditoExecute(Sender: TObject);
    procedure acDebitoExecute(Sender: TObject);
    procedure acDinheiroExecute(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edCodClienteExit(Sender: TObject);
    procedure edCodClienteKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure rgSituacaoClick(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);

  private

    rv_codForma: Integer;
    codClienteR : Integer;
    pCod : string; /// codigo do Odoo
    procedure enviar_caixa(valor_pago: Double; codRec: Integer);
    function RemoveAcento(Str: string): string;
  public

  end;

var
  fRecebimento: TfRecebimento;
  C, R :integer;

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

procedure TfRecebimento.edCodClienteExit(Sender: TObject);
begin
  if (edCodCliente.Text <> '') then
  begin
    edPago.Text:= '0,00';
    fClienteBusca.cCodCliente := StrToInt(edCodCliente.Text);
    fClienteBusca.BuscaCliente;
    edNomeCliente.Text := fClienteBusca.cNomeCliente;
    btnProcurar.SetFocus;
  end;
end;

procedure TfRecebimento.edCodClienteKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if (edCodCliente.Text <> '') then
    begin
      edPago.Text:= '0,00';
      fClienteBusca.cCodCliente := StrToInt(edCodCliente.Text);
      fClienteBusca.BuscaCliente;
      edNomeCliente.Text := fClienteBusca.cNomeCliente;
      btnProcurar.SetFocus;
    end;
  end;
end;

procedure TfRecebimento.FormCreate(Sender: TObject);
var
  conf: TIniFile;
  vstr, vstrhost: String;
begin
 { if (UpperCase(dmpdv.usoSistema) = 'ODOO') then
  begin
    conOdoo.Connected:=False;
    if FileExists(dmPdv.path_exe  + 'conf.ini') then
    begin
       conf := TIniFile.Create(dmPdv.path_exe + 'conf.ini');
       try
         vstr := conf.ReadString('DATABASEPG', 'Database', '');
         conOdoo.DatabaseName := vstr;
         vstrhost := conf.ReadString('DATABASEPG', 'HostName', '');
         conOdoo.HostName := vstrhost;
       finally
         conf.free;
       end;
    end;
    try
      conOdoo.Connected:=True;
    except
      ShowMessage('Erro conexao Database: ' + vstr + ' HostName: ' + vstrhost);
    end;
  end;
  }
  if (UpperCase(dmpdv.usoSistema) = 'ODOO') then
  begin
    StringGrid1.Visible := True;
    DBGrid1.Visible     := False;
    {
    rgSituacao.Enabled  := False;
    btnConfirma.Enabled := False;
    BitBtn24.Enabled    := False;
    BitBtn9.Enabled     := False;
    BitBtn18.Enabled    := False;
    BitBtn20.Enabled    := False;
    BitBtn21.Enabled    := False;
    }
  end;

  if (UpperCase(dmpdv.usoSistema) = 'ATS') then
  begin
    DBGrid1.Visible     := True;
    StringGrid1.Visible := False;
    DBGrid1.Columns[0].FieldName:='CODRECEBIMENTO';
    DBGrid1.Columns[1].FieldName:='TITULO';
    DBGrid1.Columns[2].FieldName:='EMISSAO';
    DBGrid1.Columns[3].FieldName:='DATAVENCIMENTO';
    DBGrid1.Columns[4].FieldName:='DATARECEBIMENTO';
    DBGrid1.Columns[5].FieldName:='NOMECLIENTE';
    DBGrid1.Columns[6].FieldName:='VALORTITULO';
    DBGrid1.Columns[7].FieldName:='VALOR_RESTO';
    DBGrid1.Columns[0].Title.Caption := 'Código';
    DBGrid1.Columns[1].Title.Caption := 'Título';
    DBGrid1.Columns[2].Title.Caption := 'Emissão';
    DBGrid1.Columns[3].Title.Caption := 'Vencimento';
    DBGrid1.Columns[5].Title.Caption := 'Recebido';
    DBGrid1.Columns[5].Title.Caption := 'Cliente';

    DBGrid1.Columns[6].DisplayFormat:=',##0.00';
    DBGrid1.Columns[7].DisplayFormat:=',##0.00';
  end;

end;

procedure TfRecebimento.FormShow(Sender: TObject);
begin
  StringGrid1.Clear;
  pnCartoes.Visible:=False;
  edPago.Enabled:=False;
  lblForma.Caption := '...';
  memoResult.Clear;
  edCodCliente.Text := '';
  edNomeCliente.Text:= '';
  pCod:='';
  label3.Caption:='...';
  edPago.Text:= '0,00';
  edPago1.Text:= '0,00';
  edJuros.Text:= '0,00';
  edJurosMulta.Text := '0,00';
  edTotalGeral.Text := '0,00';
 end;

procedure TfRecebimento.Label3Click(Sender: TObject);
begin

end;

procedure TfRecebimento.rgSituacaoClick(Sender: TObject);
begin
  btnProcurar.Click;
end;

procedure TfRecebimento.StringGrid1Click(Sender: TObject);
var a , c , f: string;
    b , d: integer;
    vt : Double;
begin
   b:= StringGrid1.Row;
   a:= StringGrid1.Cells[5,b];
   edJuros.Text:= a;

   d:= StringGrid1.Row;
   c:= StringGrid1.Cells[4,d];
  // f:= StringGrid1.Cells[1,d];

   vt:=(StrToFloat(a) + StrToFloat(c)) ;

   edPago1.Text:= FloatToStr(vt);
   //pCod := (StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row]);
   pCod := StringGrid1.Cells[0,d];
   Label3.Caption := pCod ;
   f := StringGrid1.Cells[1,d];
   Label8.Caption := f ;

  // edJuros.Text:= (StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row]);
end;

procedure TfRecebimento.StringGrid1DrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  if(Acol=0)and(Arow=R)then
  begin
    StringGrid1.Canvas.Brush.Color:= clSkyBlue;
    StringGrid1.Canvas.FillRect(aRect);
    StringGrid1.Canvas.TextOut(aRect.Left+2,aRect.Top+2,StringGrid1.Cells[ACol,ARow]);
  end;
end;

procedure TfRecebimento.StringGrid1SelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  R := ARow;
  C := ACol;
end;

procedure TfRecebimento.enviar_caixa(valor_pago: Double; codRec: Integer);
var insert_pag: String;
    juros : Double;
begin
  codRec := codRec + 9000000;
  // enviando o recebimento para o CAIXA
  rv_codForma := dmPdv.busca_generator('GEN_FORMA');

  insert_pag := 'INSERT INTO FORMA_ENTRADA (CODFORMA, CAIXA, COD_VENDA, '+
     ' FORMA_PGTO, ID_ENTRADA, CAIXINHA, N_DOC, STATE, VALOR_PAGO, DESCONTO, TROCO) VALUES(';
  {
  if (not sqPagamento.Active) then
    sqPagamento.Open;
  sqPagamento.Insert;
  sqPagamentoCODFORMA.AsInteger  := rv_codForma;
  sqPagamentoCAIXA.AsInteger     := StrToInt(dmPdv.idcaixa);
  sqPagamentoCOD_VENDA.AsInteger := 2;  // POR RECEBIMENTO
  sqPagamentoFORMA_PGTO.AsString := Copy(lblForma.Caption,1,1);
  sqPagamentoID_ENTRADA.AsInteger:= StrToInt(pCod); //codRec;
  sqPagamentoN_DOC.AsString      := lblForma.Caption;
  sqPagamentoSTATE.AsInteger     := 1;
  sqPagamentoVALOR_PAGO.AsFloat  := valor_pago;
  sqPagamentoDESCONTO.AsFloat    := 0;
  sqPagamentoTROCO.AsFloat       := StrToFloat(edJuros.Text);
  sqPagamento.ApplyUpdates;
  dmPdv.sTrans.Commit;}

  insert_pag  += IntToStr(rv_codForma) + ', ';
  insert_pag  += dmPdv.idcaixa + ', ';
  insert_pag  += '2, ';
  insert_pag  += QuotedStr(Copy(lblForma.Caption,1,1)) + ', ';
  insert_pag  += pCod + ', NULL, ';
  insert_pag  += QuotedStr(lblForma.Caption) + ', ';
  insert_pag  += '1, ';
  juros := strToFloat(edJuros.Text);
  DecimalSeparator:='.';
  insert_pag  += FloatToStr(valor_pago) + ', ';
  insert_pag  += '0 , ';

  insert_pag  += FloatToStr(juros);
  insert_pag += ')';
  DecimalSeparator:=',';

  //try
    dmPdv.IbCon.ExecuteDirect(insert_pag);
    dmPdv.sTrans.Commit;
  //except
  //  ShowMessage('Verifique se baixou no ODOO.');
  //end;

end;

function TfRecebimento.RemoveAcento(Str: string): string;
const
ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
 x: Integer;
 verAcento : String;
begin;
for x := 1 to Length(Str) do
if Pos(Str[x],ComAcento) <> 0 then
begin
  verAcento := Str[x];
  if Str[x] > #120 then
    str[x] := Char('')
  else
    Str[x] := SemAcento[Pos(Str[x], ComAcento)];
  verAcento := Str[x];
end;
str := UTF8String(str);
for x := 1 to Length(Str) do
  if Str[x] > #127 then
    str[x] := 'a';
//Result := AnsiToUtf8(str);
Result := str;


end;

procedure TfRecebimento.btnProcurarClick(Sender: TObject);
var
  sql_rec: String;
  total_rec , total_odoo , juros ,dias, multa , vJuros, tt: Double;
  juros_str: String;
  postJson : TJSONObject;
  httpClient : TFPHttpClient;
  fInteg: TfIntegracaoOdoo;
  responseData: String;
  i: integer;
  J: integer;
  K: integer;
  jData : TJSONData;
  jItem : TJSONData;
  jDataB : TJSONData;
  jItemB : TJSONData;
  a , b , c , d ,e ,f , g ,h ,v,vTotal: String;
  object_name, field_name, field_value, object_type, object_items: String;
  pJuros : string;
begin
  if (edCodCliente.Text = '') then
  begin
    ShowMessage('Informe o Código do Cliente.');
    Exit;
  end;
  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    memoResult.Clear;
    StringGrid1.Clear;
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
    StringGrid1.Cells[0, StringGrid1.RowCount - 1] := 'Codigo';
    StringGrid1.Cells[1, StringGrid1.RowCount - 1] := 'Fatura';
    StringGrid1.Cells[2, StringGrid1.RowCount - 1] := 'Data Emissão';
    StringGrid1.Cells[3, StringGrid1.RowCount - 1] := 'Data Vencimento' ;
    StringGrid1.Cells[4, StringGrid1.RowCount - 1] := 'Valor';
    StringGrid1.Cells[5, StringGrid1.RowCount - 1] := 'Multa/Juros';
    //  StringGrid1.Cells[5, StringGrid1.RowCount - 1] := 'Codigo';
    StringGrid1.ColWidths[1]:= 250;
    StringGrid1.ColWidths[2]:= 100;
    StringGrid1.ColWidths[3]:= 100;
    StringGrid1.ColWidths[4]:= 100;
    StringGrid1.ColWidths[5]:= 100;
    StringGrid1.ColWidths[6]:= 100;
    httpClient := TFPHttpClient.Create(Nil);
    postJson := TJSONObject.Create;
    try
      postJson.Add('title', 'Contas a Receber');
      postJson.Add('cod_cliente', edCodCliente.Text);
      postJson.Add('valor_pago', edPago.Text);
      postJson.Add('diario', lblForma.Caption);
      postJson.Add('caixa', dmPdv.idcaixa);
      postJson.Add('cod_forma', rv_codForma);
      postJson.Add('juro', edJuros.Text);
      postJson.Add('aml_id', pCod);
      fInteg := TfIntegracaoOdoo.Create(Self);
      httpClient := fInteg.logar();
      With httpClient do
      begin
        AddHeader('Content-Type', 'application/json');
        RequestBody := TStringStream.Create(postJson.AsJSON);
        responseData := Post(dmPdv.path_integra_url + '/contasconsulta');
        memoResult.Lines.Add(responseData);
      end;
      fInteg.Free;
      postJson.Free;
    except
    end;
  end;
  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    jData := GetJSON(responseData);
    for i := 0 to jData.Count - 1 do
    begin
      jItem := jData.Items[i];
      object_name := TJSONObject(jData).Names[i];
      if object_name = 'result' then
      begin
        jDataB := GetJSON(jData.Items[i].Value);
        for j := 0 to jDataB.Count - 1 do
        begin
          jItemB := jDataB.Items[j];
          for k := 0 to jItemB.Count - 1 do
            begin
              field_name := TJSONObject(jItemB).Names[k];
              field_value := jItemB.FindPath(TJSONObject(jItemB).Names[k]).Value;
              if (k = 0)then
              a := field_value;
              if (k = 1)then
              b := field_value;
              if (k = 2)then
              c := field_value;
              if (k = 3)then
              d := field_value;
              if (k = 4)then
              e := field_value;
              if (k = 5)then
              f := field_value;
              if (k = 6)then
              h := field_value;

            end;

          pJuros := dmPdv.CobraJuros;

          if(pJuros = 'Sim')then
          begin
            h := '0';
            total_odoo := total_odoo + StrToFloat(b) ;
            dias := (today - StrToDate(d)); // conto os dias
            vJuros := 0;
            if (dias > 0) then
            begin
              juros := (0.03 * dias); //  mostra juros por dia
              vJuros := ((juros * StrToFloat(b))/100);  // mostra juros mora

              if(dias <> 0) then
              begin
                multa := StrToFloat(b) * (2/100);
                h := FloatToStr(multa+vJuros) ;
              end;
            end
            else begin
              multa := 0;
              h := '0';
            end;
            tt := tt + StrToFloat(h);
            edJurosMulta.Text := FormatFloat('###0.00',(tt));  // FloatToStr(tt) ;
          end;

          if(pJuros = 'Nao')then
          begin
            h := '0';
            edJurosMulta.Text := FormatFloat('###0.00',(tt));
          end;

          StringGrid1.RowCount := StringGrid1.RowCount + 1;
          StringGrid1.Cells[0, StringGrid1.RowCount - 1] := f;
          StringGrid1.Cells[1, StringGrid1.RowCount - 1] := e;
          StringGrid1.Cells[2, StringGrid1.RowCount - 1] := c;
          StringGrid1.Cells[3, StringGrid1.RowCount - 1] := d;
          StringGrid1.Cells[4, StringGrid1.RowCount - 1] := FormatFloat('###0.00', StrToFloat(b));
          //StringGrid1.Cells[5, StringGrid1.RowCount - 1] := a;
          StringGrid1.Cells[5, StringGrid1.RowCount - 1] := FormatFloat('###0.00', StrToFloat(h));
          edTotalGeral.Caption:= FormatFloat('###0.00', total_odoo);
        end;
      end;
    end;
  end;

 if (UpperCase(dmPdv.usoSistema) = 'ATS') then
 begin
   total_rec := 0;
   //  total_juromulta := dmPdv.RecJuro;
   // juros_str := FormatFloat('#0.00000',total_juromulta);
   //juros_str := StringReplace(juros_str, ',', '.', [rfReplaceAll]);
   if ((UpperCase(dmpdv.usoSistema) = 'ATS') or (UpperCase(dmpdv.usoSistema) = 'ODOO')) then
   begin
     // buscar contas (recebimento)
     total_rec := 0;
     sql_rec := 'SELECT r.CODCLIENTE, r.CODRECEBIMENTO, r.TITULO, r.EMISSAO';
     sql_rec += ', r.DATAVENCIMENTO, r.DATARECEBIMENTO ';
     sql_rec += ' ,(r.VALOR_RESTO - COALESCE(r.VALORRECEBIDO,0)) AS RESTO ';
     sql_rec += ' , CASE WHEN r.DATAVENCIMENTO < (CURRENT_DATE - 30) THEN ';
     sql_rec += ' ((r.VALOR_RESTO * (1+(' + dmPdv.RecJuro + '*(current_date - r.datavencimento))))';
     sql_rec += ' - COALESCE(r.VALORRECEBIDO,0)) ';
     sql_rec += ' ELSE (r.VALOR_RESTO - COALESCE(r.VALORRECEBIDO,0)) END AS VALOR_RESTO, r.VALORTITULO ';
     sql_rec += ' AS VALORTITULO, c.NOMECLIENTE FROM RECEBIMENTO r, CLIENTES c ';
     sql_rec += ' WHERE r.CODCLIENTE = c.CODCLIENTE AND r.VALOR_RESTO > 0';
     //sql_rec += ' AND r.DATARECEBIMENTO = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', Now));
     if (edCodCliente.Text <> '') then
     begin
       sql_rec += ' AND r.CODCLIENTE = ' + edCodCliente.Text;
     end;
     Case rgSituacao.ItemIndex of
       0 : sql_rec += ' AND r.STATUS  = ' + QuotedStr('5-');
       1 : sql_rec += ' AND r.STATUS  = ' + QuotedStr('7-');
       2 : sql_rec += ' AND r.STATUS  IN (' +
       QuotedStr('5-') + ',' + QuotedStr('7-') + ')';
     end;
     sql_rec += ' ORDER BY r.DATAVENCIMENTO, r.EMISSAO, r.TITULO';
     dmPdv.busca_sql(sql_rec);
     While not dmPdv.sqBusca.EOF do
     begin
       total_rec += dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat;
       dmPdv.sqBusca.Next;
     end;
     dmPdv.sqBusca.First;
     edTotalGeral.Text := FormatFloat('#,,,0.00',total_rec);
   end;
   if (UpperCase(dmpdv.usoSistema) = 'ODOO-LOCAL') then
   begin
     sqlOdoo.Close;
     dsRec.DataSet := sqlOdoo;
     sql_rec := 'select aml.id as CODRECEBIMENTO, aml.ref as TITULO, aml.date as EMISSAO, ';
     sql_rec += 'aml.date_maturity as DATAVENCIMENTO, NULL as DATARECEBIMENTO, ';
     sql_rec += ' rp.id || ' + '-' + ' || rp.name as NOMECLIENTE,';
     sql_rec += 'aml.amount_residual as VALORTITULO, aml.amount_residual as VALOR_RESTO,';
     sql_rec += ' aml.reconciled, aml.invoice_id ';
     sql_rec += ' FROM account_move_line aml, account_account aa, account_account_type aat, res_partner rp';
     sql_rec += ' WHERE aa.id = aml.account_id and aat.id = aa.user_type_id ';
     sql_rec += '   AND aml.invoice_id IS NOT NULL ';
     sql_rec += '   AND rp.id = aml.partner_id and aat.type = ' + QuotedStr('receivable');
     if (edNomeCliente.Text <> '') then
     begin
       sql_rec += ' AND rp.NAME ILIKE ' + QuotedStr('%' + edNomeCliente.Text + '%');
     end;
     Case rgSituacao.ItemIndex of
       0 : sql_rec += ' AND aml.amount_residual > 0.0';
       1 : sql_rec += ' AND aml.amount_residual = 0.0';
     end;
     sql_rec += ' ORDER BY aml.date_maturity, aml.date, aml.ref LIMIT ' + edLimit.Text;
     sqlOdoo.SQL.Clear;
     sqlOdoo.SQL.Add(sql_rec);
     sqlOdoo.Open;
     While not sqlOdoo.EOF do
     begin
       total_rec += sqlOdoo.FieldByName('VALOR_RESTO').AsFloat;
     sqlOdoo.Next;
     end;
     sqlOdoo.First;
     edTotalGeral.Text := FormatFloat('#,,,0.00',total_rec);
   end;
 end;
 edPago.Text:= '0,00';
end;

procedure TfRecebimento.btnConfirmaClick(Sender: TObject);
var
  vlr_pg: Double;
  vlr_rt: Double;
  vlr_juro: Double;
  str_rec : String;
  //vRec : TRecebimento;
  vr_formaRec: String;

 IMPRESSORA :TextFile;
 lFile  : TStringList;
 i      : Integer;
 logradouro: String;
 cep: String;
 fone: String;
 clientecupom: string;
 texto3: String;
 texto6: String;
 produto_cupomf: String;
 linhaTxt : String;
 prazo : String;
 totalP: Double;
 totalD: Double;
 ItemDesc: Double;
 totalR: Double;
 sql_rec: string;
 v_log: string;
 dataRec: string;
 vtotalR: Double;
 ind : integer;
begin
  lblGrava.Caption := 'Iniciando gravação';
  if (edCodCliente.Text = '') then
  begin
    ShowMessage('Informe o Código do Cliente.');
    Exit;
  end;
  memo1.Lines.Clear;
  // baixar pagamentos
  if (rgSituacao.ItemIndex > 0) then
  begin
    ShowMessage('Selecione títulos  a Pagar.');
    Exit;
  end;

  if (lblForma.Caption = '...') then
  begin
    ShowMessage('Informe a FORMA de pagamento.');
    Exit;
  end;
  if (lblForma.Caption = '1-Dinheiro') then
    vr_formaRec := '1';
  if (lblForma.Caption = '2-Debito') then
    vr_formaRec := '7';
  if (lblForma.Caption = '3-Credito') then
    vr_formaRec := '6';

  if (edPago.Text = '0,00') then
  begin
    ShowMessage('Informe o Valor Pago');
    Exit;
  end;

  vlr_pg := StrToFloat(edPago.Text);
  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    lblGrava.Caption := 'if usoSistema = ODOO';
    //try
      enviar_caixa(vlr_pg,StrToInt(pCod)); // o codigo que foi selecionado no grid
    //except
    //  ShowMessage('Verifique se baixou no ODOO.');
    //end;

    // IMPRESSAO

    try
    lblGrava.Caption := 'if usoSistema = ODOO - imprimindo';
    v_log := 'Log de impressão - ';
    totalP := 0;
    totalD := 0;
    totalR := 0;
    if (not dmPdv.sqEmpresa.Active) then
      dmPdv.sqEmpresa.Open;
    v_log := 'Log de impressão 3 ';
    {----- aqui monto o endereço-----}
    logradouro := '  ' + dmPdv.sqEmpresaENDERECO.Value +
       ', ' + dmPdv.sqEmpresaBAIRRO.Value;
    cep :=  '  ' + dmPdv.sqEmpresaCIDADE.Value + ' - ' + dmPdv.sqEmpresaUF.Value +
    ' - ' + dmPdv.sqEmpresaCEP.Value;
    fone := '  (19)' + dmPdv.sqEmpresaFONE.Value + ' / ' + dmPdv.sqEmpresaFONE_1.Value +
    ' / ' + dmPdv.sqEmpresaFONE_2.Value;
    {------------------------DADOS DO CLIENTE--------------------------}
   // clientecupom := '  ' + IntToStr(dmPdv.sqBusca.FieldByName('CODCLIENTE').asInteger) +
    //    '-' + RemoveAcento(dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString);
    clientecupom := '  ' + edCodCliente.Text +
        '-' + edNomeCliente.Text;

    // leio um arquivo txt e imprimo
    v_log := 'Log de impressão - criando lFile ';
    lFile := TStringList.Create;
    if ((dmPdv.CupomImp = 'Texto') or (dmPdv.CupomImp = 'DB')) then
    begin
      v_log := 'Log portaImp - ' + dmPdv.portaIMP;
      AssignFile(IMPRESSORA, dmPdv.portaIMP);
    end
    else begin
      v_log := 'Log path_imp - ' + dmPdv.path_imp;
      AssignFile(IMPRESSORA, dmPdv.path_imp);
    end;
    v_log := 'Log abrindo cupomRec.txt ' + dmpdv.path_exe + 'cupomRec.txt';
    try
      Rewrite(IMPRESSORA);
      if not (FileExists(dmpdv.path_exe + 'cupomRec.txt')) then
      begin
        ShowMessage('Crie o arquivo cupomRec.txt');
        Exit;
      end;
      lFile.LoadFromFile(dmpdv.path_exe + 'cupomRec.txt');
      for i:=0 to lFile.Count-1 do
      begin
        v_log := 'Log lendo cupomRec.txt ';
        linhaTxt := Copy(lFile[i],0,1);
        if lFile[i] = 'empresa' then
          Writeln(Impressora, RemoveAcento(Format('  %-36s',[dmPdv.sqEmpresaRAZAO.Value])))
        else if lFile[i] = 'logradouro' then
          Writeln(Impressora, logradouro)
        else if lFile[i] = 'cep' then
          Writeln(Impressora, cep)
        else if lFile[i] = 'fone' then
        begin
          Writeln(Impressora, fone);
        end
        else if lFile[i] = 'usuario' then
        begin
          Writeln(Impressora,'');
          Writeln(Impressora,'-------------------------');
          Writeln(impressora, 'Usuario: ' + dmpdv.nomeLogado);
          Writeln(Impressora,'-------------------------');
          Writeln(Impressora, clientecupom);
        end
        else if lFile[i] = 'doc' then
          Writeln(Impressora,'Recebido Dia.' + FormatDateTime('dd/mm/yyyy hh:MM:ss', Now));

        ///else
         if lFile[i] = 'recebi' then
         begin
           Writeln(Impressora,'-------------------------');
           // Writeln(Impressora,'  Valor Pago : ' + edPago.Text);
           Writeln(IMPRESSORA, ' Valor Pago : ' + FormatFloat(',##0.00', StrToFloat(edPago.Text)));
           Writeln(Impressora,'--------------------------');
         end;

         if lFile[i] = 'pedido' then
          begin
            Writeln(Impressora,'Fatura :' + label8.Caption);
          end;


         Writeln(Impressora,'');
      end;
         Writeln(Impressora,'');
         Writeln(Impressora,'');
         Writeln(Impressora,'');
         Writeln(Impressora,'.');

    finally

      CloseFile(IMPRESSORA);
      lFile.Free;
    end;


    except
      btnProcurar.Click;
      ShowMessage('Erro na impressao');
    end;
    btnProcurar.Click;
    edPago.Text:= '0,00';
  end
  else begin
  if ((UpperCase(dmpdv.usoSistema) = 'ATS') or (UpperCase(dmpdv.usoSistema) = 'ODOO')) then
  begin
    dmPdv.sqBusca.First;
    str_rec := IntToStr(dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger);
    While not dmPdv.sqBusca.EOF do
    begin
      if (str_rec <> IntToStr(dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger)) then
      begin
        ShowMessage('Selecione um cliente para fazer a Baixa, não pode ter clientes diferentes');
        Exit;
      end;
      dmPdv.sqBusca.Next;
    end;

    vlr_rt := vlr_pg;
    dmPdv.sqBusca.First;
    str_rec := '';
    DecimalSeparator:='.';
    While vlr_rt > 0 do
    begin
      While not dmPdv.sqBusca.EOF do
      begin
        if (vlr_rt > 0) then
        begin
          vlr_juro:= RoundTo(dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat -
              dmPdv.sqBusca.FieldByName('RESTO').AsFloat, -2);
          if ((dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat - vlr_juro) > (vlr_rt-vlr_juro)) then
          begin
            // duplico o lancamento no recebimento
            // este novo item o valor vai ser a diferenca do pago
            // um vai ficar em aberto o outro como pago
            str_rec := 'INSERT INTO RECEBIMENTO (  ' +
              ' CODRECEBIMENTO, TITULO, EMISSAO, CODCLIENTE, DATAVENCIMENTO' +
              ', CAIXA, STATUS, VIA, CODVENDA, CODALMOXARIFADO, CODVENDEDOR' +
              ', CODUSUARIO, DATASISTEMA, VALOR_PRIM_VIA, VALOR_RESTO, VALORTITULO' +
              ', PARCELAS, FORMARECEBIMENTO) SELECT ' +
              ' GEN_ID(COD_AREC, 1), TITULO, EMISSAO, CODCLIENTE, DATAVENCIMENTO' +
              ', CAIXA, STATUS, VIA, CODVENDA, CODALMOXARIFADO, CODVENDEDOR' +
              ', CODUSUARIO, DATASISTEMA, ';
            vlr_pg := RoundTo(dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat - vlr_rt, -2);
            str_rec += FloatToStr(vlr_pg) + ', ' + FloatToStr(vlr_pg); //VALOR_PRIM_VIA, VALOR_RESTO
            str_rec += ', VALORTITULO, PARCELAS, FORMARECEBIMENTO ';
            str_rec += ' FROM RECEBIMENTO WHERE CODRECEBIMENTO = ';
            str_rec += IntToStr(dmPdv.sqBusca.FieldByName('CODRECEBIMENTO').AsInteger);
            dmPdv.executaSql(str_rec);
            vlr_pg := vlr_rt;
          end
          else begin
            vlr_pg := RoundTo(dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat, -2);
          end;
          dmPdv.executaSql('UPDATE RECEBIMENTO SET STATUS = ' +
            QuotedStr('7-') + ', VALORRECEBIDO = ' + FloattoStr(vlr_pg) +
            ' , JUROS = ' + FloattoStr(vlr_juro) +
            ' , FORMARECEBIMENTO = ' + QuotedStr(vr_formaRec) +
            ' , DATARECEBIMENTO = ' + QuotedStr(FormatDateTime('mm/dd/2022', Now)) +
            ' , DATABAIXA = ' + QuotedStr(FormatDateTime('mm/dd/2022', Now)) +
            ' , CAIXA = ' + dmPdv.idcaixa +
            ' , CODALMOXARIFADO = ' + dmPdv.ccusto +
            ' , CODUSUARIO = ' + dmPdv.varLogado +
            ' , HISTORICO = ' + QuotedStr('Pagamento Caixa PDV : ' +
              dmPdv.nomeLogado + ', ' + dmPdv.nomeCaixa) +
            ' WHERE CODRECEBIMENTO = ' +
            IntToStr(dmPdv.sqBusca.FieldByName('CODRECEBIMENTO').asInteger));
          enviar_caixa(vlr_pg, dmPdv.sqBusca.FieldByName('CODRECEBIMENTO').AsInteger);
          vlr_rt -= vlr_pg;
        end;
        dmPdv.sqBusca.Next;
      end;
    end;
    dmPdv.sTrans.Commit;
  end;
  if (UpperCase(dmpdv.usoSistema) = 'ODOO-LOCAL') then
  begin
    // inserir dados no Contas_receber odoo a rotina integracao vai fazer o resto no odoo
    vlr_pg := StrToFloat(edPago.Text);
    vlr_rt := vlr_pg;
    sqlOdoo.First;
    str_rec := '';
    DecimalSeparator:='.';
    While vlr_rt > 0 do
    begin
      While not sqlOdoo.EOF do
      begin
        if (vlr_rt > 0) then
        begin
          if (sqlOdoo.FieldByName('VALOR_RESTO').AsFloat > vlr_rt) then
          begin
            vlr_pg := sqlOdoo.FieldByName('VALOR_RESTO').AsFloat - vlr_rt;
          end
          else begin
            vlr_pg := sqlOdoo.FieldByName('VALOR_RESTO').AsFloat;
          end;
          str_rec := 'INSERT INTO CONTAS_RECEBER (name, invoice_id, valor_titulo,';
          str_rec += ' valor_recebido, data_recebido, caixa_recebeu, forma_recebimento) VALUES(';
          str_rec += QuotedStr(sqlOdoo.FieldByName('TITULO').AsString);
          str_rec += ', ' + IntToStr(sqlOdoo.FieldByName('invoice_id').AsInteger);
          str_rec += ', ' + FloattoStr(vlr_pg);
          str_rec += ', ' + FloattoStr(vlr_pg);
          str_rec += ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy', Now));
          str_rec += ', ' + dmPdv.idcaixa;
          str_rec += ', ' + QuotedStr(vr_formaRec)  + ')';
          vlr_rt -= vlr_pg;
          conOdoo.ExecuteDirect(str_rec);
          enviar_caixa(vlr_pg, sqlOdoo.FieldByName('CODRECEBIMENTO').AsInteger);
        end;
        sqlOdoo.Next;
      end;
    end;
    transODoo.Commit;
  end;
  end;

  DecimalSeparator:=',';
  ShowMessage('Baixa efetuada com sucesso.'+#13+
             'Se a Baixa foi Parcial o valor Sera Corrigido');
  edPago.Text:='0,00';
  edPago1.Text:='0,00';
  edJuros.Text:='0,00';
  edPago.Enabled:=False;
  if (UpperCase(dmpdv.usoSistema) = 'ODOO') then
  begin
     rgSituacao.ItemIndex := 0;
  end else
  rgSituacao.ItemIndex := 1;
  btnProcurar.Click;
end;

procedure TfRecebimento.BitBtn1Click(Sender: TObject);
begin
  StringGrid1.Clear;
  pnCartoes.Visible:=False;
  edPago.Enabled:=False;
  lblForma.Caption := '...';
  memoResult.Clear;
  edCodCliente.Text := '';
  edNomeCliente.Text := '';
end;

procedure TfRecebimento.BitBtn20Click(Sender: TObject);
begin
  if (dmPdv.OutrosCartoes = 'S') then
  begin
    pnCartoes.Visible:=True;
    BitBtn1.SetFocus;
  end
  else begin
    lblForma.Caption:='3-Cartao Credito';
    edPago.Enabled:=True;
    edPago.SetFocus;
  end;
end;

procedure TfRecebimento.BitBtn21Click(Sender: TObject);
begin
  lblForma.Caption:= '6-Pix';
  edPago.Enabled:=True;
  edPago.SetFocus;
end;

procedure TfRecebimento.BitBtn24Click(Sender: TObject);
  var
  IMPRESSORA:TextFile;
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
  prazo : String;
  totalP: Double;
  totalD: Double;
  ItemDesc: Double;
  totalR: Double;
  sql_rec: string;
  v_log: string;
  dataRec: string;
  vtotalR: Double;
begin
// buscando contas pagas
if(edCodCliente.Text = '')then
begin
  ShowMessage('Selecione Um Cliente.');
  Button1.Click;
  Exit;
end;
  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    ShowMessage('A Impressão pelo Odoo é Executada Quando Recebe !');
    exit;
  end;

  if (UpperCase(dmPdv.usoSistema) <> 'ODOO') then
  begin
    sql_rec := 'SELECT r.CODCLIENTE, r.CODRECEBIMENTO, r.TITULO, r.EMISSAO';
    sql_rec += ', r.DATAVENCIMENTO, r.DATARECEBIMENTO ';
    sql_rec += ' ,COALESCE(r.VALORRECEBIDO,0) AS VALOR_RECEBIDO, ';
    sql_rec += ' c.NOMECLIENTE FROM RECEBIMENTO r, CLIENTES c ';
    sql_rec += ' WHERE r.CODCLIENTE = c.CODCLIENTE ';
    if (edCodCliente.Text <> '') then
    begin
      sql_rec += ' AND r.CODCLIENTE = ' + edCodCliente.Text;
    end;
    sql_rec += ' AND r.STATUS  = ' + QuotedStr('7-');
    sql_rec += ' AND r.DATARECEBIMENTO = ' + QuotedStr(FormatDateTime('mm/dd/2022', Now));
    sql_rec += ' ORDER BY r.DATAVENCIMENTO, r.EMISSAO, r.TITULO';
    dmPdv.busca_sql(sql_rec);
    totalR := 0;
    While not dmPdv.sqBusca.EOF do
    begin
      totalR += dmPdv.sqBusca.FieldByName('VALOR_RECEBIDO').AsFloat;
      dmPdv.sqBusca.Next;
    end;
    dmPdv.sqBusca.First;

    v_log := 'Log de impressão - ';
    totalP := 0;
    totalD := 0;
    totalR := 0;
    if (not dmPdv.sqEmpresa.Active) then
      dmPdv.sqEmpresa.Open;
    v_log := 'Log de impressão 3 ';
    {----- aqui monto o endereço-----}
    logradouro := '  ' + dmPdv.sqEmpresaENDERECO.Value +
       ', ' + dmPdv.sqEmpresaBAIRRO.Value;
    cep :=  '  ' + dmPdv.sqEmpresaCIDADE.Value + ' - ' + dmPdv.sqEmpresaUF.Value +
    ' - ' + dmPdv.sqEmpresaCEP.Value;
    fone := '  (19)' + dmPdv.sqEmpresaFONE.Value + ' / ' + dmPdv.sqEmpresaFONE_1.Value +
    ' / ' + dmPdv.sqEmpresaFONE_2.Value;
    {------------------------DADOS DO CLIENTE--------------------------}
    clientecupom := '  ' + IntToStr(dmPdv.sqBusca.FieldByName('CODCLIENTE').asInteger) +
        '-' + RemoveAcento(dmPdv.sqBusca.FieldByName('NOMECLIENTE').AsString);
    // leio um arquivo txt e imprimo
    v_log := 'Log de impressão - criando lFile ';
    lFile := TStringList.Create;
    if ((dmPdv.CupomImp = 'Texto') or (dmPdv.CupomImp = 'DB')) then
    begin
      v_log := 'Log portaImp - ' + dmPdv.portaIMP;
      AssignFile(IMPRESSORA, dmPdv.portaIMP);
    end
    else begin
      v_log := 'Log path_imp - ' + dmPdv.path_imp;
      AssignFile(IMPRESSORA, dmPdv.path_imp);
    end;
    v_log := 'Log abrindo cupomRec.txt ' + dmpdv.path_exe + 'cupomRec.txt';
    try
      Rewrite(IMPRESSORA);
      lFile.LoadFromFile(dmpdv.path_exe + 'cupomRec.txt');
      for i:=0 to lFile.Count-1 do
      begin
        v_log := 'Log lendo cupomRec.txt ';
        linhaTxt := Copy(lFile[i],0,1);
        if lFile[i] = 'empresa' then
          Writeln(Impressora, RemoveAcento(Format('  %-36s',[dmPdv.sqEmpresaRAZAO.Value])))
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
        end

        else if ((lFile[i] = 'cliente') or (lFile[i] = 'clientecompleto')) then
        begin
          if lFile[i] = 'clientecompleto' then
          begin
            dmPdv.qsCliente.Close;
            dmPdv.qsCliente.Params.ParamByName('ID').AsInteger := StrToInt(edCodCliente.Text);
            dmPdv.qsCliente.Open;
            if dmPdv.qsCliente.IsEmpty then
            begin
              Writeln(Impressora, clientecupom);
            end
            else begin
              Writeln(Impressora, clientecupom);
              clientecupom := ' Doc.: ' + dmPdv.qsClienteCNPJ.AsString + ', ' + dmPdv.qsClienteINSCESTADUAL.AsString;
              Writeln(Impressora, clientecupom);
              clientecupom := ' End.: ' + dmPdv.qsClienteLOGRADOURO.AsString + ', ' + dmPdv.qsClienteNUMERO.AsString;
              Writeln(Impressora, clientecupom);
              clientecupom := ' ' + dmPdv.qsClienteBAIRRO.AsString + ', ' + dmPdv.qsClienteCIDADE.AsString + ', ' + dmPdv.qsClienteUF.AsString;
              Writeln(Impressora, clientecupom);
            end;
          end
          else begin
            Writeln(Impressora, clientecupom);
          end;
        end
        else if lFile[i] = 'doc' then
          Writeln(Impressora,'Recebido Dia.' + FormatDateTime('dd/mm/2022 hh:MM:ss', Now))
        else if lFile[i] = 'itens' then
        begin
          vtotalR := 0 ;
          while not dmPdv.sqBusca.EOF do
          begin
            vtotalR := vtotalR + dmPdv.sqBusca.FieldByName('VALOR_RECEBIDO').asFloat;
            texto3 := ' ';
            texto6 := ' ';
            dataRec := dmPdv.sqBusca.FieldByName('DATAVENCIMENTO').AsString +
                    '  -  ' + dmPdv.sqBusca.FieldByName('TITULO').AsString ;
            texto3 := texto3 + dataRec;
            texto3 := texto3 + Format('   %6.2n',[dmPdv.sqBusca.FieldByName('VALOR_RECEBIDO').asFloat]);
            Writeln(Impressora, texto3);
            dmPdv.sqBusca.next;
            texto6 := texto6 + 'Total                   :' + Format('   %6.2n',[vtotalR]);

          end;
          Writeln(Impressora,texto6);

        end
        else
          Writeln(Impressora,lFile[i]);
      end;
    finally
      CloseFile(IMPRESSORA);
      lFile.Free;
    end;
 end;
end;

procedure TfRecebimento.BitBtn2Click(Sender: TObject);
begin
  lblForma.Caption:='7-Sianet';
  pnCartoes.Visible:=False;
  edPago.Enabled:=True;
  edPago.SetFocus;
end;

procedure TfRecebimento.BitBtn3Click(Sender: TObject);
begin
  lblForma.Caption:='8-Brasil Card';
  pnCartoes.Visible:=False;
  edPago.Enabled:=True;
  edPago.SetFocus;
end;

procedure TfRecebimento.BitBtn4Click(Sender: TObject);
begin
  lblForma.Caption:='3-Cartao Credito';
  pnCartoes.Visible:=False;
  edPago.Enabled:=True;
  edPago.SetFocus;
end;

procedure TfRecebimento.BitBtn5Click(Sender: TObject);
begin
  pnCartoes.Visible:=False;
end;

procedure TfRecebimento.acDinheiroExecute(Sender: TObject);
begin
  lblForma.Caption := '1-Dinheiro';
  edPago.Enabled:=True;
  edPago.SetFocus;
end;

procedure TfRecebimento.BitBtn18Click(Sender: TObject);
begin
  lblForma.Caption := '2-Debito';
  edPago.Enabled:=True;
  edPago.SetFocus;
end;

procedure TfRecebimento.acDebitoExecute(Sender: TObject);
begin
  lblForma.Caption := '2-Debito';
  edPago.Enabled:=True;
  edPago.SetFocus;
end;

procedure TfRecebimento.acCreditoExecute(Sender: TObject);
begin
  lblForma.Caption := '3-Credito';
  edPago.Enabled:=True;
  edPago.SetFocus;
end;

procedure TfRecebimento.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.

