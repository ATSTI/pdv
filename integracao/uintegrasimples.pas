unit uIntegraSimples;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  JSONPropStorage, ExtCtrls, Buttons, IdHTTP, IdHTTPServer, IdSSLOpenSSL,
  udmpdv, JsonTools, fpjson, fphttpclient, DB, StrUtils, opensslsockets,
  openssl;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    btnCaixa: TButton;
    btnConsultaUltimoPedido: TButton;
    btnEnviandoPedido: TButton;
    btnUsuario: TButton;
    btnProduto: TButton;
    btnCliente: TButton;
    edEste: TEdit;
    edUltima: TEdit;
    edTentativa: TEdit;
    edtUltimpoPedido: TEdit;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdSSL: TIdSSLIOHandlerSocketOpenSSL;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    memoDados: TMemo;
    memoResult: TMemo;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnCaixaClick(Sender: TObject);
    procedure btnEnviandoPedidoClick(Sender: TObject);
    procedure btnConsultaUltimoPedidoClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure btnUsuarioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    postJson : TJSONObject;
    httpClient : TFPHttpClient;
    function ler_retorno(responseData:String): String;
    function monta_arquivo_movimento(arquivo_linha: TJsonNode):TJsonNode;
    function monta_arquivo_recebimento(vcodmovimento: String; arquivo_linha: TJsonNode):TJsonNode;
    function monta_arquivo_movimentodetalhe(vcodmovimento: String; arquivo_linha: TJsonNode):TJsonNode;
    procedure cria_json(ultimoPedido: String);
    procedure envia_json(dados_json:TJSONObject);
    procedure executa_sql;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnConsultaUltimoPedidoClick(Sender: TObject);
Var
  responseData: String;
  result: String;
begin
    postJson.Clear;
    postJson.Add('title', 'Consultando ultimo pedido');
    With httpClient do
    begin
        AddHeader('Content-Type', 'application/json');
        RequestBody := TStringStream.Create(postJson.AsJSON);
        responseData := Post(dmPdv.path_integra_url + '/pedidoconsulta');
        memoResult.Lines.Add(responseData);
        edtUltimpoPedido.Text := ler_retorno(responseData);
    end;
end;

procedure TForm1.btnProdutoClick(Sender: TObject);
Var
 responseData: String;
 object_name, field_name, field_value: String;
 jData : TJSONData;
 jDataB : TJSONData;
 jItemB : TJSONData;
 i: integer;
 J: integer;
 K: integer;
 ver: String;
 sql_campo, sql_valor, sql_update, sql_update1: String;
 codproduto, data_alterado : String;
 FS: TFormatSettings;
 data_cad : TDateTime;
begin
  FS := DefaultFormatSettings;
  FS.DateSeparator := '/';
  FS.ShortDateFormat := 'mm/dd/yyyy';
  FS.ShortTimeFormat := 'hh:mm:ss';
  memoDados.Lines.Clear;
  DecimalSeparator:='.';
  postJson.Clear;
  postJson.Add('title', 'Consultando Produto');
  With httpClient do
  begin
      AddHeader('Content-Type', 'application/json');
      RequestBody := TStringStream.Create(postJson.AsJSON);
      responseData := Post(dmPdv.path_integra_url + '/produtoconsulta');

      memoResult.Lines.Add(responseData);
      jData := GetJSON(responseData);
      for i := 0 to jData.Count - 1 do
      begin
        object_name := TJSONObject(jData).Names[i];
        if object_name = 'result' then
        begin
          jDataB := GetJSON(jData.Items[i].Value);
          for j := 0 to jDataB.Count - 1 do
          begin
            jItemB := jDataB.Items[j];
            ver := '';
            sql_campo := '';
            sql_valor := '';
            sql_update := '';
            sql_update1 := '';
            for k := 0 to jItemB.Count - 1 do
            begin
              field_name := TJSONObject(jItemB).Names[k];
              field_value := jItemB.FindPath(TJSONObject(jItemB).Names[k]).Value;
              if field_name = 'datacadastro' then
                data_alterado := field_value;
              if field_name = 'codproduto' then
              begin
                // verifico se o caixa ja existe
                dmpdv.busca_sql('SELECT CODPRODUTO, DATACADASTRO FROM PRODUTOS WHERE ' +
                  ' CODPRODUTO = ' + field_value);
                codproduto := field_value;
                if dmpdv.sqBusca.IsEmpty then
                begin
                  // presico inserir
                  ver := 'insere';
                end;
              end;
              if sql_campo <> '' then
              begin
                sql_campo += ', ' +  field_name;
                sql_valor += ', ' +  QuotedStr(field_value);
              end
              else begin
                sql_campo += field_name;
                sql_valor += QuotedStr(field_value);
              end;
              if ((sql_update1 <> '') and (field_name <> 'codproduto')) then
              begin
                  sql_update += ', ' + field_name + '=' + QuotedStr(field_value);
              end;
              if ((sql_update1 = '') and (field_name <> 'codproduto')) then
              begin
                sql_update1 += field_name + '=' + QuotedStr(field_value);
              end;
            end;
             if ver = 'insere' then
                memoDados.Lines.add('INSERT INTO PRODUTOS ('+ sql_campo + ') VALUES(' + sql_valor + ');')
             else
             begin
               data_cad := StrToDateTime(data_alterado, FS);
               if (dmpdv.sqBusca.FieldByName('DATACADASTRO').AsDateTime < data_cad) then
               begin
                 memoDados.Lines.add('UPDATE PRODUTOS SET ' + sql_update1 + sql_update +
                   ' WHERE CODPRODUTO = ' + codproduto + ';');
               end;
             end;
          end;
        end;
      end;
  end;
  executa_sql;
end;

procedure TForm1.btnClienteClick(Sender: TObject);
Var
  responseData: String;
  object_name, field_name, field_value: String;
  jData : TJSONData;
  jDataB : TJSONData;
  jItemB : TJSONData;
  i: integer;
  J: integer;
  K: integer;
  ver: String;
  sql_campo, sql_valor, sql_update, sql_update1: String;
  codproduto, data_alterado : String;
  FS: TFormatSettings;
  data_cad : TDateTime;
begin
  FS := DefaultFormatSettings;
  FS.DateSeparator := '/';
  FS.ShortDateFormat := 'mm/dd/yyyy';
  FS.ShortTimeFormat := 'hh:mm:ss';
  memoDados.Lines.Clear;
  DecimalSeparator:='.';
  postJson.Clear;
  postJson.Add('title', 'Consultando Clientes');
  With httpClient do
  begin
      AddHeader('Content-Type', 'application/json');
      RequestBody := TStringStream.Create(postJson.AsJSON);
      responseData := Post(dmPdv.path_integra_url + '/clienteconsulta');
      memoResult.Lines.Add(responseData);
      jData := GetJSON(responseData);
      for i := 0 to jData.Count - 1 do
      begin
        object_name := TJSONObject(jData).Names[i];
        if object_name = 'result' then
        begin
          jDataB := GetJSON(jData.Items[i].Value);
          for j := 0 to jDataB.Count - 1 do
          begin
            jItemB := jDataB.Items[j];
            ver := '';
            sql_campo := '';
            sql_valor := '';
            sql_update := '';
            sql_update1 := '';
            for k := 0 to jItemB.Count - 1 do
            begin
              field_name := TJSONObject(jItemB).Names[k];
              field_value := jItemB.FindPath(TJSONObject(jItemB).Names[k]).Value;
              if field_name = 'data_matricula' then
                data_alterado := field_value;
              if field_name = 'codcliente' then
              begin
                // verifico se o caixa ja existe
                dmpdv.busca_sql('SELECT CODCLIENTE, DATA_MATRICULA FROM CLIENTES WHERE ' +
                  ' CODCLIENTE = ' + field_value);
                codproduto := field_value;
                if dmpdv.sqBusca.IsEmpty then
                begin
                  // presico inserir
                  ver := 'insere';
                end;
              end;
              if sql_campo <> '' then
              begin
                sql_campo += ', ' +  field_name;
                sql_valor += ', ' +  QuotedStr(field_value);
              end
              else begin
                sql_campo += field_name;
                sql_valor += QuotedStr(field_value);
              end;
              if ((sql_update1 <> '') and (field_name <> 'codcliente')) then
              begin
                  sql_update += ', ' + field_name + '=' + QuotedStr(field_value);
              end;
              if ((sql_update1 = '') and (field_name <> 'codcliente')) then
              begin
                sql_update1 += field_name + '=' + QuotedStr(field_value);
              end;
            end;
             if ver = 'insere' then
                memoDados.Lines.add('INSERT INTO CLIENTES ('+ sql_campo + ') VALUES(' + sql_valor + ');')
             else
             begin
               data_cad := StrToDateTime(data_alterado, FS);
               if (dmpdv.sqBusca.FieldByName('DATA_MATRICULA').AsDateTime < data_cad) then
               begin
                 memoDados.Lines.add('UPDATE CLIENTES SET ' + sql_update1 + sql_update +
                   ' WHERE CODCLIENTE = ' + codproduto + ';');
               end;
             end;
          end;
        end;
      end;
  end;
  executa_sql;
end;

procedure TForm1.btnUsuarioClick(Sender: TObject);
Var
  responseData: String;
  object_name, field_name, field_value: String;
 jData : TJSONData;
 jDataB : TJSONData;
 jItemB : TJSONData;
 i: integer;
 J: integer;
 K: integer;
 ver: String;
 sql_campo, sql_valor: String;
begin
  memoDados.Lines.Clear;
  postJson.Clear;
  postJson.Add('title', 'Consultando Usuario');
  With httpClient do
  begin
    AddHeader('Content-Type', 'application/json');
    RequestBody := TStringStream.Create(postJson.AsJSON);
    responseData := Post(dmPdv.path_integra_url + '/usuarioconsulta');
    memoResult.Lines.Add(responseData);
    jData := GetJSON(responseData);
    // #TODO colocar update
    for i := 0 to jData.Count - 1 do
    begin
      object_name := TJSONObject(jData).Names[i];
      if object_name = 'result' then
      begin
        jDataB := GetJSON(jData.Items[i].Value);
        for j := 0 to jDataB.Count - 1 do
        begin
          jItemB := jDataB.Items[j];
          ver := '';
          sql_campo := '';
          sql_valor := '';
          for k := 0 to jItemB.Count - 1 do
          begin
            field_name := TJSONObject(jItemB).Names[k];
            field_value := jItemB.FindPath(TJSONObject(jItemB).Names[k]).Value;
            if field_name = 'codusuario' then
            begin
              // verifico se o caixa ja existe
                dmpdv.busca_sql('SELECT CODUSUARIO FROM USUARIO WHERE CODUSUARIO = ' + field_value);
                if dmpdv.sqBusca.IsEmpty then
                begin
                  // presico inserir
                  ver := 'insere';
                end;
              end;
              if sql_campo <> '' then
              begin
                sql_campo += ', ' +  field_name;
                sql_valor += ', ' +  QuotedStr(field_value);
              end
              else begin
                sql_campo += field_name;
                sql_valor += QuotedStr(field_value);
              end;
            end;
             if ver = 'insere' then
                memoDados.Lines.add('INSERT INTO USUARIO ('+ sql_campo + ') VALUES(' + sql_valor + ');');
            //result := field_value;
          end;
        end;
      end;
    end;
  executa_sql;
end;

procedure TForm1.btnEnviandoPedidoClick(Sender: TObject);
begin
  btnConsultaUltimoPedido.Click;
  memoResult.Lines.Clear;
  memoDados.Lines.Clear;
  cria_json(edtUltimpoPedido.Text);
end;

procedure TForm1.btnCaixaClick(Sender: TObject);
Var
  responseData: String;
  result: String;
  c: TJsonNode;
  sqlD: String;
  sqlP: String;
  dados: String;
  object_name, field_name, field_value, object_type, object_items: String;
 jData : TJSONData;
 jItem : TJSONData;
 jDataB : TJSONData;
 jItemB : TJSONData;
 i: integer;
 J: integer;
 K: integer;
 ver: String;
 sql_campo, sql_valor: String;
begin
  dados:= '[{';
  postJson.Clear;
  postJson.Add('title', 'Consultando Caixa');
  dmpdv.busca_sql('SELECT FIRST 3 CODCAIXA, SITUACAO FROM CAIXA_CONTROLE ORDER BY CODCAIXA DESC');
  While not dmpdv.sqBusca.EOF do
  begin
    if (dmPdv.sqBusca.FieldByName('SITUACAO').AsString = 'F') then
    begin
      if (dados <> '[{') then
        dados += '}, {';
      dados += '"CODCAIXA": ' + IntToStr(dmPdv.sqBusca.FieldByName('CODCAIXA').AsInteger);
      dados += ', "SITUACAO": "' + dmPdv.sqBusca.FieldByName('SITUACAO').AsString +'"';
    end;
    dmpdv.sqBusca.Next;
  end;
  dados += '}]';
  postJson.Add('caixa', dados);
  dados := '';
  memoDados.Lines.Clear;
  DecimalSeparator:='.';
  With httpClient do
  begin
      AddHeader('Content-Type', 'application/json');
      RequestBody := TStringStream.Create(postJson.AsJSON);
      responseData := Post(dmPdv.path_integra_url + '/caixaconsulta');
      memoResult.Lines.Add(responseData);
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
            ver := '';
            sql_campo := '';
            sql_valor := '';
            for k := 0 to jItemB.Count - 1 do
            begin
              field_name := TJSONObject(jItemB).Names[k];
              field_value := jItemB.FindPath(TJSONObject(jItemB).Names[k]).Value;
              if field_name = 'idcaixacontrole' then
                ver := '';
              if field_name = 'codcaixa' then
              begin
                // verifico se o caixa ja existe
                dmpdv.busca_sql('SELECT CODCAIXA FROM CAIXA_CONTROLE WHERE CODCAIXA = ' + field_value);
                if dmpdv.sqBusca.IsEmpty then
                begin
                  // presico inserir
                  ver := 'insere';
                end;
              end;
              if sql_campo <> '' then
              begin
                sql_campo += ', ' +  field_name;
                sql_valor += ', ' +  QuotedStr(field_value);
              end
              else begin
                sql_campo += field_name;
                sql_valor += QuotedStr(field_value);
              end;
            end;
            if ver = 'insere' then
              memoDados.Lines.add('INSERT INTO CAIXA_CONTROLE ('+ sql_campo + ') VALUES(' + sql_valor + ');');
          end;
        end;
      end;
      executa_sql;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  edEste.Text := '';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  httpClient := TFPHttpClient.Create(Nil);
  postJson := TJSONObject.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  httpClient.Free;
  postJson.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  btnEnviandoPedido.Click;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  btnProduto.Click;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  btnCliente.Click;
end;

function TForm1.ler_retorno(responseData: String): String;
var object_name, field_name, field_value, object_type, object_items: String;
 jData : TJSONData;
 jItem : TJSONData;
 jDataB : TJSONData;
 jItemB : TJSONData;
 i: integer;
 J: integer;
 K: integer;
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
          //MemoResult.Lines.Append(' - ' + field_name + ': ' + field_value);
        end;
        result := field_value;
      end;
    end;
  end;
end;

procedure TForm1.cria_json(ultimoPedido: String);
Var
  responseData: String;
  result: String;
  arquivo: TJsonNode;
  cod_mov: Integer;
  ver_str: String;
  sql_str: String;
begin
  postJson.Clear;
  postJson.Add('title', 'Enviando Movimento');
  arquivo := TJsonNode.Create;
  // buscando no odoo o ultimo integrado
  dmPdv.sqLancamentos.Close;
  if (edEste.Text <> '') then
  begin
    cod_mov := StrToInt(edEste.Text);
    dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := cod_mov;
    edEste.Text := IntToStr(cod_mov + 1);
  end
  else begin
    dmPdv.sqBusca1.Close;
    dmPdv.sqBusca1.Sql.Clear;
    sql_str := 'SELECT FIRST 10 m.CODMOVIMENTO ';
    sql_str += ' FROM MOVIMENTO m , VENDA v';

    sql_str += ' WHERE m.CODMOVIMENTO = v.CODMOVIMENTO';
    sql_str += '   AND m.CODMOVIMENTO NOT IN ' + ultimoPedido;
    sql_str += '   AND m.STATUS = 1 ';
    sql_str += ' ORDER BY m.CODMOVIMENTO DESC ';
    dmPdv.sqBusca1.SQL.Add(sql_str);
    dmPdv.sqBusca1.Open;
    while not dmPdv.sqBusca1.EOF do
    begin
      ver_str := dmPdv.sqBusca1.Fields[0].DisplayName;
      cod_mov := dmPdv.sqBusca1.Fields[0].AsInteger;
      {if (edUltima.Text = IntToStr(cod_mov)) then
      begin
        edTentativa.Text := IntToStr(StrToInt(edTentativa.Text)+1);
        edUltima.Text := IntToStr(cod_mov);
      end;
      if (edTentativa.Text = '0') then
      begin
        edUltima.Text := IntToStr(cod_mov);
      end;
      if (edTentativa.Text = '4') then
      begin
        edTentativa.Text := '0';
        cod_mov := StrToInt(edUltima.Text);
      end;}
      dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := cod_mov;
      dmPdv.sqBusca1.Next;
    end;
  end;
  dmPdv.sqLancamentos.Open;
  arquivo := monta_arquivo_movimento(arquivo);
  arquivo := monta_arquivo_recebimento(IntToStr(cod_mov), arquivo);
  arquivo := monta_arquivo_movimentodetalhe(IntToStr(cod_mov), arquivo);
  if not dmPdv.sqLancamentos.IsEmpty then
  begin
    if (dmPdv.sqLancamentosSTATUS.AsInteger = 1) then
    begin
      memoDados.Lines.Add(arquivo.ToString);
      postJson.Add('pedido', arquivo.ToString);
      envia_json(postJson);
      arquivo.Free;
    end;
  end
  else begin
    memoDados.Lines.Add('Último pedido enviado: ' + ultimoPedido + '. Sem mais pedidos para enviar.');
  end;
end;

function TForm1.monta_arquivo_movimento(arquivo_linha: TJsonNode): TJsonNode;
var i: Integer;
  campo: String;
  campos: String;
  valor: String;
  tipo : TFieldType;
begin
  for i:=0 to dmPdv.sqLancamentos.FieldDefs.Count-1 do
  begin
    campo := dmPdv.sqLancamentos.FieldDefs.Items[i].Name;
    campos := 'CODMOVIMENTO DATA_SISTEMA CODCLIENTE CONTROLE CODUSUARIO';
    campos += ' CODVENDEDOR CODALMOXARIFADO';
    if (pos(campo, Campos) <> 0) then
    begin
      if (not dmPdv.sqLancamentos.Fields[i].IsNull) then
      begin
        valor := '';
        if (Trim(dmPdv.sqLancamentos.Fields[i].Value) <> '') then
        begin
          tipo := dmPdv.sqLancamentos.Fields[i].DataType;
          if dmPdv.sqLancamentos.Fields[i].DataType = ftDateTime then
            valor := FormatDateTime('mm/dd/yyyy hh:MM', dmPdv.sqLancamentos.Fields[i].Value);
          if dmPdv.sqLancamentos.Fields[i].DataType = ftString then
            valor := dmPdv.sqLancamentos.Fields[i].Value;
          if dmPdv.sqLancamentos.Fields[i].DataType = ftInteger then
            valor := IntToStr(dmPdv.sqLancamentos.Fields[i].Value);
          if dmPdv.sqLancamentos.Fields[i].DataType = ftSmallint then
            valor := IntToStr(dmPdv.sqLancamentos.Fields[i].Value);
          if dmPdv.sqLancamentos.Fields[i].DataType = ftFloat then
          begin
            try
              valor := FloatToStr(dmPdv.sqLancamentos.Fields[i].Value);
            except
              valor := '';
            end;
          end;
          if (valor <> '') then
            arquivo_linha.Add(dmPdv.sqLancamentos.Fields[i].FieldName, valor);
          valor := '';
        end;
      end;
    end;
  end;
  result := arquivo_linha;
end;

function TForm1.monta_arquivo_recebimento(vcodmovimento: String;
  arquivo_linha: TJsonNode): TJsonNode;
var i: Integer;
  campo: String;
  campos: String;
  valor: String;
  tipo : TFieldType;
  itens : String;
  item : String;
  num: Integer;
begin
  // PAGAMENTOS
  dmPdv.busca_sql('SELECT CODFORMA, COD_VENDA, ID_ENTRADA, FORMA_PGTO' +
    ' , CAIXA , N_DOC, VALOR_PAGO, CAIXINHA, TROCO, DESCONTO, STATE' +
    ' FROM FORMA_ENTRADA WHERE STATE < 2 AND ID_ENTRADA = ' +
    vCodMovimento + ' ORDER BY FORMA_PGTO');
  item := '';
  itens := '[';
  num := 0;
  while not dmPdv.sqBusca.EOF do
  begin
    item += '{';
    num += 1;
    for i:=0 to dmPdv.sqBusca.FieldDefs.Count-1 do
    begin
      try
      campo := dmPdv.sqBusca.FieldDefs.Items[i].Name;
      campos := 'FORMA_PGTO VALOR_PAGO CODCLIENTE DESCONTO ID_ENTRADA';
      if (pos(campo, Campos) <> 0) then
      begin
        if (not dmPdv.sqBusca.Fields[i].IsNull) then
        begin
          valor := '';
          if (Trim(dmPdv.sqBusca.Fields[i].Value) <> '') then
          begin
            tipo := dmPdv.sqBusca.Fields[i].DataType;
            if dmPdv.sqBusca.Fields[i].DataType = ftDate then
               valor := FormatDateTime('mm/dd/yyyy', dmPdv.sqBusca.Fields[i].Value);
            if dmPdv.sqBusca.Fields[i].DataType = ftString then
               valor := dmPdv.sqBusca.Fields[i].Value;
            if dmPdv.sqBusca.Fields[i].DataType = ftInteger then
               valor := IntToStr(dmPdv.sqBusca.Fields[i].Value);
            if dmPdv.sqBusca.Fields[i].DataType = ftSmallint then
               valor := IntToStr(dmPdv.sqBusca.Fields[i].Value);
            if dmPdv.sqBusca.Fields[i].DataType = ftFixedChar then
               valor := dmPdv.sqBusca.Fields[i].Value;

            if dmPdv.sqBusca.Fields[i].DataType = ftFloat then
            begin
              try
                 valor := FloatToStr(dmPdv.sqBusca.Fields[i].Value);
              except
                valor := '';
              end;
            end;
            if (valor <> '') then
            begin
              if item <> '{' then
                item += ',';
              item += '"' + campo + '": "' + valor + '"';
            end;
            valor := '';
          end;
        end;
      end;
      except
         ShowMessage('Erro Campo : ' + campo + ' Valor : ' + valor);
         valor := '0';
      end;
    end;
    item += ', "CODMOVIMENTO": "' + IntToStr(dmpdv.sqLancamentosCODMOVIMENTO.AsInteger) + '"';
    item += '}';
    if itens <> '[' then
      itens += ',' + item
    else
      itens += item;
    item := '';
    dmPdv.sqBusca.Next;
  end;
  itens += ']';
  arquivo_linha.add('pagamentos', itens);
  result := arquivo_linha;
end;

function TForm1.monta_arquivo_movimentodetalhe(vcodmovimento: String;
  arquivo_linha: TJsonNode): TJsonNode;
var i: Integer;
  campo: String;
  campos: String;
  valor: String;
  tipo : TFieldType;
  itens : String;
  item : String;
  num: Integer;
begin
  // ITENS
  itens := '[';
  item := '';
  dmPdv.sqLancamentos.First;
  while not dmPdv.sqLancamentos.Eof do
  begin
    item += '{';
    num += 1;
    for i:=0 to dmPdv.sqLancamentos.FieldDefs.Count-1 do
    begin
      try
        campo := dmPdv.sqLancamentos.FieldDefs.Items[i].Name;
        campos := 'CODPRODUTO PRECO QUANTIDADE';
        campos += ' VALOR_DESCONTO DESCPRODUTO CORTESIA';
        if (pos(campo, Campos) <> 0) then
        begin
          valor := '';
          if (campo = 'VALOR_DESCONTO') then
          begin
            valor := FloatToStr(dmPdv.sqLancamentosVALOR_DESCONTO.Value);
          end;
          if (campo = 'CODPRODUTO') then
          begin
            valor := IntToStr(dmPdv.sqLancamentosCODPRODUTO.Value);
          end;
          if (campo = 'PRECO') then
          begin
            valor := FloatToStr(dmPdv.sqLancamentosPRECO.Value);
          end;
          if (campo = 'QUANTIDADE') then
          begin
            valor := FloatToStr(dmPdv.sqLancamentosQUANTIDADE.Value);
          end;
          if (campo = 'CODPRO') then
          begin
            valor := dmPdv.sqLancamentosCODPRO.Value;
          end;
          if (campo = 'DESCPRODUTO') then
          begin
            valor := dmPdv.sqLancamentosDESCPRODUTO.Value;
          end;
          if (campo = 'CORTESIA') then
          begin
            valor := dmPdv.sqLancamentosCORTESIA.Value;
          end;
          if (valor <> '') then
          begin
            if item <> '{' then
              item += ',';
            item += '"' + campo + '": "' + valor + '"';
          end;
          valor := '';
        end;
      except
         ShowMessage('Erro Campo : ' + campo + ' Valor : ' + valor);
         valor := '0';
      end;
    end;
    item += ', "CODMOVIMENTO": "' + IntToStr(dmpdv.sqLancamentosCODMOVIMENTO.AsInteger) + '"';
    item += '}';
    if itens <> '[' then
      itens += ',' + item
    else
      itens += item;
    item := '';
    dmPdv.sqLancamentos.Next;
  end;
  itens += ']';
  arquivo_linha.add('itens', itens);
  result := arquivo_linha;
end;

procedure TForm1.envia_json(dados_json: TJSONObject);
var responseData: String;
begin
  With httpClient do
  begin
      AddHeader('Content-Type', 'application/json');
      RequestBody := TStringStream.Create(dados_json.AsJSON);
      responseData := Post(dmPdv.path_integra_url + '/pedidoinsere');
      if (responseData <> 'N') then
      begin
      end;
  end;
end;

procedure TForm1.executa_sql;
var   Linha: string;
  i: Integer;
  sql: String;
begin
    sql := '';
    for i := 0 to memoDados.Lines.Count-1 do
    begin
      linha := memoDados.Lines.Strings[i];
      sql += linha;
      if AnsiEndsText(';', linha) then
      begin
        dmPdv.IbCon.ExecuteDirect(sql);
        dmPdv.sTrans.Commit;
        sql := '';
      end;
    end;
    //memoDados.Lines.Clear;
end;

end.

