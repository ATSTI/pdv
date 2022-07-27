unit uIntegracaoOdoo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, JsonTools, fpjson, jsonparser, fphttpclient, FileUtil, DB;
type

  { TIntegracaoOdoo }

  TIntegracaoOdoo = class(TThread)
  public
    c_caixa: String;
    constructor Create(CreateSuspended : boolean);
    destructor Destroy; override;
    procedure atualiza;
    //path_integracao : String;
    //path_integracao_url: String;
    //cod_caixa_integra: String;
    // nome_empresa_integra: String;
  private
    postJson : TJSONObject;
    httpClient_logado : TFPHttpClient;
    function logar(): TFPHttpClient;
    function monta_arquivo_movimento(arquivo_linha: TJsonNode):TJsonNode;
    function monta_arquivo_recebimento(vcodmovimento: String; arquivo_linha: TJsonNode):TJsonNode;
    function monta_arquivo_movimentodetalhe(vcodmovimento: String; arquivo_linha: TJsonNode):TJsonNode;
    procedure cria_json(ultimoPedido: String);
    procedure envia_json(dados_json:TJSONObject);
  protected
    procedure Execute; override;
  end;

implementation

uses udmpdv;

{ TIntegracaoOdoo }



procedure TIntegracaoOdoo.Execute;
begin
  //atualiza;
  //cria_json('');
  httpClient_logado := logar();
  cria_json('');
end;

constructor TIntegracaoOdoo.Create(CreateSuspended: boolean);
begin
  httpClient_logado := TFPHttpClient.Create(Nil);
  postJson := TJSONObject.Create;
  FreeOnTerminate := True;
  Inherited Create(CreateSuspended);
end;

destructor TIntegracaoOdoo.Destroy;
begin
  httpClient_logado.Free;
  postJson.Free;
  inherited Destroy;
end;

procedure TIntegracaoOdoo.atualiza;
var
  //postJson: TJSONObject;
  dadosJson: TJsonNode;
  responseData: String;
  listaArquivos : TStringList;
  logs:TextFile;
  ver : String;
  K, R: Integer;
  listaEnvia : TStringList;
  cod_arquivo: String;
  ini_arquivo: String;
  controle_arquivo: string;
begin


  // log
  {
  exit;

  ver := 'C:\home\log_integracao.txt';
  AssignFile(logs, ver);
  // VER SE EXISTE ARQUIVO
  listaArquivos := TStringList.Create;
  listaEnvia := TStringList.Create;
  try
    if FileExists(ver) then
      Append(logs)
    else
      Rewrite(logs);
    //FindAllFiles(listaArquivos, path_integracao, '*.txt', true);
    FindAllFiles(listaArquivos, path_integracao, '*.txt', true);
    controle_arquivo := '';
    for k:=0 to Pred(listaArquivos.Count) do
    begin
      cod_arquivo := Copy(listaArquivos[k], Length(path_integracao)+5,Length(listaArquivos[k]) - Length(path_integracao)+5);
      if pos(cod_arquivo, controle_arquivo) = 0 then // vejo se este arquivo ja foi
      begin
        controle_arquivo += cod_arquivo;
        cod_arquivo := '*' + cod_arquivo;
        Writeln(logs, 'Iniciando integracao : ' + FormatDateTime('mm/dd/yyyy hh:MM', Now));
        Writeln(logs, 'Path : ' + path_integracao);
        Writeln(logs, 'URL : ' + path_integracao_url);

        // SE EXISTE ENVIA
        postJson := TJSONObject.Create;
        dadosJson := TJsonNode.Create;
        postJson.Add('title', 'Enviando Movimento');

        Writeln(logs, 'Empresa : ' + nome_empresa_integra);
        ver := listaArquivos[k];
        //postJson.Add('body', nome_empresa_integra);
        //dadosJson.LoadFromFile(listaArquivos[k]);

        FindAllFiles(listaEnvia, path_integracao, cod_arquivo, true);
        for R:=0 to Pred(listaEnvia.Count) do
        begin
          ini_arquivo := Copy(listaEnvia[R], Length(path_integracao)+1,3);
          ver := listaEnvia[R];
          dadosJson.LoadFromFile(listaEnvia[R]);
          postJson.Add(ini_arquivo, dadosJson.ToString);
        end;

        //FindAllFiles(listaArquivos, path_integracao, 'mov_2961_1602.txt', true);
        //for k:=0 to Pred(listaArquivos.Count) do
        //begin

        Writeln(logs, 'Arquivo : ' + listaArquivos[k]);
        postJson.Add('userId', 1);
        postJson.Add('caixa', cod_caixa_integra);
        With TFPHttpClient.Create(Nil) do
        begin
          try
            AddHeader('Content-Type', 'application/json');
            RequestBody := TStringStream.Create(postJson.AsJSON);
            responseData := Post(path_integracao_url + '/pedidoinsere');
            if (responseData <> 'N') then
            begin
              Writeln(logs, 'Existe arquivo : ' + path_integracao + responseData + '_' + cod_caixa_integra + '.txt');
              if FileExists(path_integracao + responseData + '_' + cod_caixa_integra + '.txt') then
              begin
                Writeln(logs, 'Excluindo arquivo : ' + path_integracao + responseData + '_' + cod_caixa_integra + '.txt');
                // vou excluir se o pedido existir no PDV-Odoo
                //DeleteFile(path_integracao + responseData + '_' + cod_caixa_integra + '.txt');
              end;
            end;
          finally
           Free;
          end;
        end;
      end;
    end;
  finally
    listaArquivos.Free;
    listaEnvia.Free;
    CloseFile(logs);
  end;
  }
end;

function TIntegracaoOdoo.logar(): TFPHttpClient;
var autenticacao: String;
begin
  // retorna a session
  with httpClient_logado do
  begin
    autenticacao := '{"jsonrpc": "2.0", "params": {"login": "' + dmpdv.odoo_user +
      '", "password": "' + dmpdv.odoo_acesso + '", "db": "' +
      dmPdv.odoo_database + '"}}';
     AllowRedirect := true;
     AddHeader('User-Agent', 'Mozilla/5.0(compatible; fpweb)');
     AddHeader('Content-Type', 'application/json');
     RequestBody := TStringStream.Create(autenticacao);
     Post(dmPdv.path_integra_url + '/web/session/authenticate/');
  end;
  result := httpClient_logado;
end;

function TIntegracaoOdoo.monta_arquivo_movimento(arquivo_linha: TJsonNode
  ): TJsonNode;
var i: Integer;
  campo: String;
  campos: String;
  valor: String;
  tipo : TFieldType;
begin
  for i:=0 to dmPdv.sqLancamentos_th.FieldDefs.Count-1 do
  begin
    campo := dmPdv.sqLancamentos_th.FieldDefs.Items[i].Name;
    campos := 'CODMOVIMENTO DATA_SISTEMA CODCLIENTE CONTROLE CODUSUARIO';
    campos += ' CODVENDEDOR CODALMOXARIFADO';
    if (pos(campo, Campos) <> 0) then
    begin
      if (not dmPdv.sqLancamentos_th.Fields[i].IsNull) then
      begin
        valor := '';
        if (Trim(dmPdv.sqLancamentos_th.Fields[i].Value) <> '') then
        begin
          tipo := dmPdv.sqLancamentos_th.Fields[i].DataType;
          if dmPdv.sqLancamentos_th.Fields[i].DataType = ftDateTime then
            valor := FormatDateTime('mm/dd/yyyy hh:MM', dmPdv.sqLancamentos_th.Fields[i].Value);
          if dmPdv.sqLancamentos_th.Fields[i].DataType = ftString then
            valor := dmPdv.sqLancamentos_th.Fields[i].Value;
          if dmPdv.sqLancamentos_th.Fields[i].DataType = ftInteger then
            valor := IntToStr(dmPdv.sqLancamentos_th.Fields[i].Value);
          if dmPdv.sqLancamentos_th.Fields[i].DataType = ftSmallint then
            valor := IntToStr(dmPdv.sqLancamentos_th.Fields[i].Value);
          if dmPdv.sqLancamentos_th.Fields[i].DataType = ftFloat then
          begin
            try
              valor := FloatToStr(dmPdv.sqLancamentos_th.Fields[i].Value);
            except
              valor := '';
            end;
          end;
          if (valor <> '') then
            arquivo_linha.Add(dmPdv.sqLancamentos_th.Fields[i].FieldName, valor);
          valor := '';
        end;
      end;
    end;
  end;
  result := arquivo_linha;

end;

function TIntegracaoOdoo.monta_arquivo_recebimento(vcodmovimento: String;
  arquivo_linha: TJsonNode): TJsonNode;
var i: Integer;
  campo: String;
  campos: String;
  valor: String;
  tipo : TFieldType;
  itens : String;
  item : String;
  num: Integer;
  codproduto : String;
  forma_pagamento : Integer;
begin
  // PAGAMENTOS
  dmPdv.sqBusca_th.Close;
  dmPdv.sqBusca_th.Sql.Clear;
  dmPdv.sqBusca_th.Sql.Add('SELECT CODFORMA, COD_VENDA, ID_ENTRADA, FORMA_PGTO' +
    ' , CAIXA , N_DOC, VALOR_PAGO, CAIXINHA, TROCO, DESCONTO, STATE' +
    ' FROM FORMA_ENTRADA WHERE STATE < 2 AND ID_ENTRADA = ' +
    vCodMovimento + ' ORDER BY FORMA_PGTO');
  dmPdv.sqBusca_th.Open;
  forma_pagamento := dmPdv.sqBusca_th.FieldByName('FORMA_PGTO').AsInteger;

  item := '';
  itens := '[';
  num := 0;
  while not dmPdv.sqBusca_th.EOF do
  begin
    codproduto := '' ;
    if forma_pagamento = 9 then
    begin
      dmPdv.sqBusca_th1.Close;
      //busca movimentodetalhe o codproduto devolvido
      dmPdv.sqBusca_th1.SQL.Clear;
      dmPdv.sqBusca_th1.SQL.Add('SELECT CODPRODUTO' +
        ' FROM MOVIMENTODETALHE WHERE CODMOVIMENTO = ' +
      vCodMovimento );
      dmPdv.sqBusca_th1.Open;
      //busca movimentodetalhe o codproduto devolvido
      codproduto := dmPdv.sqBusca_th1.FieldByName('CODPRODUTO').AsString;
    end;
    item += '{';
    num += 1;
    for i:=0 to dmPdv.sqBusca_th.FieldDefs.Count-1 do
    begin
      try
      campo := dmPdv.sqBusca_th.FieldDefs.Items[i].Name;
      campos := 'FORMA_PGTO VALOR_PAGO CODCLIENTE DESCONTO ID_ENTRADA PROD_TROCA';
      if (pos(campo, Campos) <> 0) then
      begin
        if (not dmPdv.sqBusca_th.Fields[i].IsNull) then
        begin
          valor := '';
          if (Trim(dmPdv.sqBusca_th.Fields[i].Value) <> '') then
          begin
            tipo := dmPdv.sqBusca_th.Fields[i].DataType;
            if dmPdv.sqBusca_th.Fields[i].DataType = ftDate then
               valor := FormatDateTime('mm/dd/yyyy', dmPdv.sqBusca_th.Fields[i].Value);
            if dmPdv.sqBusca_th.Fields[i].DataType = ftString then
               valor := dmPdv.sqBusca_th.Fields[i].Value;
            if dmPdv.sqBusca_th.Fields[i].DataType = ftInteger then
               valor := IntToStr(dmPdv.sqBusca_th.Fields[i].Value);
            if dmPdv.sqBusca_th.Fields[i].DataType = ftSmallint then
               valor := IntToStr(dmPdv.sqBusca_th.Fields[i].Value);
            if dmPdv.sqBusca_th.Fields[i].DataType = ftFixedChar then
               valor := dmPdv.sqBusca_th.Fields[i].Value;

            if dmPdv.sqBusca_th.Fields[i].DataType = ftFloat then
            begin
              try
                 valor := FloatToStr(dmPdv.sqBusca_th.Fields[i].Value);
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
         //ShowMessage('Erro Campo : ' + campo + ' Valor : ' + valor);
         valor := '0';
      end;
    end;
    item += ', "CODMOVIMENTO": "' + IntToStr(dmpdv.sqLancamentos_thCODMOVIMENTO.AsInteger) + '"';
    item += ', "PROD_TROCA": "' + codproduto + '"';
    item += '}';
    if itens <> '[' then
      itens += ',' + item
    else
      itens += item;
    item := '';
    dmPdv.sqBusca_th.Next;
  end;
  itens += ']';
  arquivo_linha.add('pagamentos', itens);
  result := arquivo_linha;

end;

function TIntegracaoOdoo.monta_arquivo_movimentodetalhe(vcodmovimento: String;
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
  dmPdv.sqLancamentos_th.First;
  while not dmPdv.sqLancamentos_th.Eof do
  begin
    item += '{';
    num += 1;
    for i:=0 to dmPdv.sqLancamentos_th.FieldDefs.Count-1 do
    begin
      try
        campo := dmPdv.sqLancamentos_th.FieldDefs.Items[i].Name;
        campos := 'CODPRODUTO PRECO QUANTIDADE';
        campos += ' VALOR_DESCONTO DESCPRODUTO CORTESIA';
        if (pos(campo, Campos) <> 0) then
        begin
          valor := '';
          if (campo = 'VALOR_DESCONTO') then
          begin
            valor := FloatToStr(dmPdv.sqLancamentos_thVALOR_DESCONTO.Value);
          end;
          if (campo = 'CODPRODUTO') then
          begin
            valor := IntToStr(dmPdv.sqLancamentos_thCODPRODUTO.Value);
          end;
          if (campo = 'PRECO') then
          begin
            valor := FloatToStr(dmPdv.sqLancamentos_thPRECO.Value);
          end;
          if (campo = 'QUANTIDADE') then
          begin
            valor := FloatToStr(dmPdv.sqLancamentos_thQUANTIDADE.Value);
          end;
          if (campo = 'CODPRO') then
          begin
            valor := dmPdv.sqLancamentos_thCODPRO.Value;
          end;
          if (campo = 'DESCPRODUTO') then
          begin
            valor := dmPdv.sqLancamentos_thDESCPRODUTO.Value;
          end;
          if (campo = 'CORTESIA') then
          begin
            valor := dmPdv.sqLancamentos_thCORTESIA.Value;
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
         //ShowMessage('Erro Campo : ' + campo + ' Valor : ' + valor);
         valor := '0';
      end;
    end;
    item += ', "CODMOVIMENTO": "' + IntToStr(dmpdv.sqLancamentos_thCODMOVIMENTO.AsInteger) + '"';
    item += '}';
    if itens <> '[' then
      itens += ',' + item
    else
      itens += item;
    item := '';
    dmPdv.sqLancamentos_th.Next;
  end;
  itens += ']';
  arquivo_linha.add('itens', itens);
  result := arquivo_linha;
end;

procedure TIntegracaoOdoo.cria_json(ultimoPedido: String);
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
  dmPdv.sqLancamentos_th.Close;
  dmPdv.sqBusca_th.Close;
  dmPdv.sqBusca_th.Sql.Clear;
  sql_str := 'SELECT FIRST 10 m.CODMOVIMENTO ';
  sql_str += ' FROM MOVIMENTO m , VENDA v';
  sql_str += ' WHERE m.CODMOVIMENTO = v.CODMOVIMENTO';
  //if (edEste_str <> '') then
  //begin
  //  sql_str += ' AND m.CODMOVIMENTO = ' + edEste_str;
  //  edEste_str := IntToStr(StrToInt(edEste_str) + 1);
  //end
  //else begin
  //  sql_str += '   AND m.CODMOVIMENTO ' + ultimoPedido;
  sql_str += '   AND m.CODALMOXARIFADO = ' + c_caixa;
  //end;
  sql_str += '   AND m.STATUS = 1 ';
  sql_str += ' ORDER BY m.CODMOVIMENTO DESC ';
  dmPdv.sqBusca_th.SQL.Add(sql_str);
  dmPdv.sqBusca_th.Open;
  while not dmPdv.sqBusca_th.EOF do
  begin
      ver_str := dmPdv.sqBusca_th.Fields[0].DisplayName;
      cod_mov := dmPdv.sqBusca_th.Fields[0].AsInteger;
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
      dmPdv.sqLancamentos_th.Close;
      dmPdv.sqLancamentos_th.Params.ParamByName('PMOV').AsInteger := cod_mov;

      dmPdv.sqLancamentos_th.Open;
      arquivo := monta_arquivo_movimento(arquivo);
      arquivo := monta_arquivo_recebimento(IntToStr(cod_mov), arquivo);
      arquivo := monta_arquivo_movimentodetalhe(IntToStr(cod_mov), arquivo);
      if not dmPdv.sqLancamentos_th.IsEmpty then
      begin
        if (dmPdv.sqLancamentos_thSTATUS.AsInteger = 1) then
        begin
          //memoDados.Lines.Add(arquivo.ToString);
          postJson.Add('pedido', arquivo.ToString);
          envia_json(postJson);
          arquivo.Clear;
          postJson.Clear;
        end;
      end
      else begin
        //exibe_sql.Add('Último pedido enviado: ' + ultimoPedido + '. Sem mais pedidos para enviar.');
      end;
      dmPdv.sqBusca_th.Next;
  end;
  arquivo.Free;
end;

procedure TIntegracaoOdoo.envia_json(dados_json: TJSONObject);
var responseData: String;
begin
  With httpClient_logado do
  begin
      AddHeader('Content-Type', 'application/json');
      RequestBody := TStringStream.Create(dados_json.AsJSON);
      responseData := Post(dmPdv.path_integra_url + '/pedidoinsere');
      if (responseData <> 'N') then
      begin
      end;
  end;
end;

end.

