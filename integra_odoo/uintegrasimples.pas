unit uIntegraSimples;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, udmpdv, JsonTools, fpjson, fphttpclient,
  DB, StrUtils, opensslsockets, openssl, IniFiles;

type

  { TfIntegracaoOdoo }

  TfIntegracaoOdoo = class(TForm)
    BitBtn1: TBitBtn;
    btnCaixa: TButton;
    btnCliente: TButton;
    btnConecta: TBitBtn;
    btnConsultaUltimoPedido: TButton;
    btnConsultaUltimoPedidoGeral: TButton;
    btnDevolucao: TButton;
    btnEnviandoPedido: TButton;
    btnProduto: TButton;
    btnRecebimento: TButton;
    btnSangria_Rec: TButton;
    btnUsuario: TButton;
    Button1: TButton;
    btnTest: TButton;
    edEste: TEdit;
    edSessao: TEdit;
    edTentativa: TEdit;
    edtUltimpoPedidoA: TEdit;
    edUltima: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    memoDados: TMemo;
    memoResult: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Timer2: TTimer;
    Timer3: TTimer;
    TimerPedido: TTimer;
    TimerGeral: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnRecebimentoClick(Sender: TObject);
    procedure btnDevolucaoClick(Sender: TObject);
    procedure btnSangria_RecClick(Sender: TObject);
    procedure btnConectaClick(Sender: TObject);
    procedure btnCaixaClick(Sender: TObject);
    procedure btnConsultaUltimoPedidoGeralClick(Sender: TObject);
    procedure btnEnviandoPedidoClick(Sender: TObject);
    procedure btnConsultaUltimoPedidoClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnUsuarioClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerGeralTimer(Sender: TObject);
    procedure TimerPedidoTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    c_caixa: String;
    postJson : TJSONObject;
    httpClient : TFPHttpClient;
    autenticacao: String;
    edtUltimpoPedido: String;
    edEste_str: String;
    limpa_memo: String;
    exibe_sql : TStringList;
    function ler_retorno(responseData:String): String;
    function monta_arquivo_movimento(arquivo_linha: TJsonNode):TJsonNode;
    function monta_arquivo_recebimento(vcodmovimento: String; arquivo_linha: TJsonNode):TJsonNode;
    function monta_arquivo_movimentodetalhe(vcodmovimento: String; arquivo_linha: TJsonNode):TJsonNode;
  public
    function consultaUltimoPedido(): String;
    function consultaUltimoPedidoGeral(): String;
    function logar():TFPHttpClient;
    procedure cria_json(ultimoPedido: String);
    procedure envia_json(dados_json:TJSONObject);
    procedure executa_sql;
    procedure comunica_server(tabela: String; campo_chave: String; campos_select: String; campo_data: String);
    procedure envia_sangria_reforco;
    procedure envia_devolucao;
    procedure envia_recebimentos;
  end;

var
  fIntegracaoOdoo: TfIntegracaoOdoo;

implementation

{$R *.lfm}

{ TfIntegracaoOdoo }

procedure TfIntegracaoOdoo.btnConsultaUltimoPedidoClick(Sender: TObject);
begin
  edtUltimpoPedidoA.Text := consultaUltimoPedido;
  memoResult.Lines.Assign(exibe_sql);
end;

procedure TfIntegracaoOdoo.btnProdutoClick(Sender: TObject);
{Var
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
 url : String;}
begin
  comunica_server('PRODUTOS', 'CODPRODUTO', 'DATACADASTRO, CODPRODUTO', 'DATACADASTRO');
  exit;

  {
  FS := DefaultFormatSettings;
  FS.DateSeparator := '/';
  FS.ShortDateFormat := 'mm/dd/yyyy';
  FS.ShortTimeFormat := 'hh:mm:ss';
  memoDados.Lines.Clear;
  DecimalSeparator:='.';
  postJson.Clear;
  postJson.Add('title', 'Consultando Produto');
  //postJson.Add('cookies', autenticacao);
  httpClient := logar();

  httpClient.RequestBody := TStringStream.Create(postJson.AsJSON);
  responseData := httpClient.Post(dmPdv.path_integra_url + '/produtoconsulta');
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
              // preciso inserir
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
  executa_sql;
  }
end;

procedure TfIntegracaoOdoo.btnClienteClick(Sender: TObject);
{Var
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
  data_cad : TDateTime;}
begin
  comunica_server('CLIENTES', 'CODCLIENTE', 'DATA_MATRICULA, CODCLIENTE', 'DATA_MATRICULA');
  exit;

{  FS := DefaultFormatSettings;
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
  executa_sql;}
end;

procedure TfIntegracaoOdoo.btnTestClick(Sender: TObject);
  var
  Client: TFPHttpClient;
  Response: TStringStream;
  Params: string;
begin
  Params := '{"db": "' + dmPdv.odoo_database + '", "login": "' + dmpdv.odoo_user +
    '", "password": "' + dmpdv.odoo_acesso + '"}';
  Client := TFPHttpClient.Create(nil);
  Client.AddHeader('User-Agent', 'Mozilla/5.0 (compatible; fpweb)');
  Client.AddHeader('Content-Type', 'application/json; charset=UTF-8');
  Client.AddHeader('Accept', 'application/json');
  Client.AllowRedirect := true;
  Client.UserName := dmpdv.odoo_user;
  Client.Password := dmpdv.odoo_acesso;
  Client.RequestBody := TRawByteStringStream.Create(Params);
  Response := TStringStream.Create('');
  try
    try
      //Client.get('http://127.0.0.1:14069/web/session/authenticate',Response);
      Client.Post('http://127.0.0.1:14069/session/auth/login',Response);
      Memo1.Lines.Add('Response Code: ' + IntToStr(Client.ResponseStatusCode)); // better be 200
    except on E: Exception do
      Memo1.Lines.Add('Something bad happened: ' + E.Message);
    end;
  finally
    Client.RequestBody.Free;
    Client.Free;
    Response.Free;
  end;
end;

procedure TfIntegracaoOdoo.btnUsuarioClick(Sender: TObject);
{Var
  responseData: String;
  object_name, field_name, field_value: String;
 jData : TJSONData;
 jDataB : TJSONData;
 jItemB : TJSONData;
 i: integer;
 J: integer;
 K: integer;
 ver: String;
 sql_campo, sql_valor: String;}
begin
  comunica_server('USUARIO', 'CODUSUARIO', 'CODUSUARIO', '');
  exit;

   {

  memoDados.Lines.Clear;
  postJson.Clear;
  postJson.Add('title', 'Consultando Usuario');
  httpClient := logar();
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
  }
end;

procedure TfIntegracaoOdoo.Button1Click(Sender: TObject);
    procedure Executa ;
    begin
      fIntegracaoOdoo.edtUltimpoPedidoA.Text := consultaUltimoPedidoGeral();
      fIntegracaoOdoo.Caption:= 'Integrando Caixa : ' + c_caixa;
      if (fIntegracaoOdoo.edtUltimpoPedidoA.Text = '()') then
        fIntegracaoOdoo.edtUltimpoPedidoA.Text := '';
      fIntegracaoOdoo.memoResult.Lines.Clear;
      fIntegracaoOdoo.memoDados.Lines.Clear;
      //memoResult.Lines.Assign(exibe_sql);
      if (fIntegracaoOdoo.edtUltimpoPedidoA.Text <> '') then
        cria_json(' IN ' + fIntegracaoOdoo.edtUltimpoPedidoA.Text);
      Sleep(1000);
    end;
begin
 with TThread.CreateAnonymousThread(TProcedure(@Executa))do
 begin
   FreeOnTerminate:= True;
   Start;
 end;

end;

procedure TfIntegracaoOdoo.btnEnviandoPedidoClick(Sender: TObject);
begin
  if (edEste.Text <> '') then
    edEste_str:= edEste.Text;
  btnConsultaUltimoPedido.Click;
  memoResult.Lines.Clear;
  memoDados.Lines.Clear;
  exibe_sql.Clear;
  cria_json(' NOT IN ' + edtUltimpoPedidoA.Text);
  edtUltimpoPedidoA.Text := edtUltimpoPedido;
  memoResult.Lines.Assign(exibe_sql);
  edEste.Text := edEste_str;
end;

procedure TfIntegracaoOdoo.btnCaixaClick(Sender: TObject);
{Var
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
 sql_campo, sql_valor: String;}
begin
  limpa_memo := 'N';
  btnSangria_Rec.Click;
  btnRecebimento.Click;
  btnConsultaUltimoPedidoGeral.Click;
  if (edtUltimpoPedidoA.Text <> '') then
  begin
    ShowMessage('Execute o botão Cons. Pedido Geral');
    Exit;
  end;
  comunica_server('CAIXA_CONTROLE', 'CODCAIXA', 'CODCAIXA, SITUACAO', '');
  exit;

  //dados:= '[{';
  {postJson.Clear;
  postJson.Add('title', 'Consultando Caixa');
  dmpdv.busca_sql('SELECT FIRST 3 CODCAIXA, SITUACAO FROM CAIXA_CONTROLE ORDER BY CODCAIXA DESC');



  While not dmpdv.sqBusca.EOF do
  begin
    if (dmPdv.sqBusca.FieldByName('SITUACAO').AsString = 'F') then
    begin}
  //    if (dados <> '[{') then
  //      dados += '}, {';
  {    dados += '"CODCAIXA": ' + IntToStr(dmPdv.sqBusca.FieldByName('CODCAIXA').AsInteger);
      dados += ', "SITUACAO": "' + dmPdv.sqBusca.FieldByName('SITUACAO').AsString +'"';
    end;
    dmpdv.sqBusca.Next;
  end;}
  //dados += '}]';
  {postJson.Add('caixa', dados);
  dados := '';
  memoDados.Lines.Clear;
  DecimalSeparator:='.';
  httpClient := logar();
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
              //if field_name = 'idcaixacontrole' then
              //  ver := '';
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
            begin
              memoDados.Lines.add('INSERT INTO CAIXA_CONTROLE ('+ sql_campo + ') VALUES(' + sql_valor + ');');
              ver := '';
            end;
          end;
        end;
      end;
      executa_sql;
  end;}
end;

procedure TfIntegracaoOdoo.btnConsultaUltimoPedidoGeralClick(Sender: TObject);
begin
  edtUltimpoPedidoA.Text := consultaUltimoPedidoGeral();
  fIntegracaoOdoo.Caption:= 'Integrando Caixa : ' + c_caixa;
  if (edtUltimpoPedidoA.Text = '()') then
    edtUltimpoPedidoA.Text := '';
  if (limpa_memo = 'S') then
  begin
    memoResult.Lines.Clear;
    memoDados.Lines.Clear;
  end;
  //memoResult.Lines.Assign(exibe_sql);
  if (edtUltimpoPedidoA.Text <> '') then
    cria_json(' IN ' + edtUltimpoPedidoA.Text);
end;

procedure TfIntegracaoOdoo.BitBtn1Click(Sender: TObject);
begin
  edEste.Text := '';
end;

procedure TfIntegracaoOdoo.btnRecebimentoClick(Sender: TObject);
begin
  envia_recebimentos;
end;

procedure TfIntegracaoOdoo.btnDevolucaoClick(Sender: TObject);
begin
  envia_devolucao;
end;

procedure TfIntegracaoOdoo.btnSangria_RecClick(Sender: TObject);
begin
  envia_sangria_reforco;
end;

procedure TfIntegracaoOdoo.btnConectaClick(Sender: TObject);
var
  responseData: String;
  listaArquivos : TStringList;
  logs:TextFile;
  ver : String;
  url: STring;
  jData : TJSONData;
  jItem : TJSONData;
  jDataB : TJSONData;
  jItemB : TJSONData;
  i: integer;
  J: integer;
  K: integer;
  object_name, field_name, field_value, object_type, object_items: String;
begin
    // odoo12
   {
   autenticacao := '{"jsonrpc": "2.0", "params": {"login": "' + dmpdv.odoo_user +
    '", "password": "' + dmpdv.odoo_acesso + '", "db": "' +
    dmPdv.odoo_database + '"}}';
   }

  autenticacao := '{"db": "' + dmPdv.odoo_database +
                  '","login": "' + dmpdv.odoo_user +
                  '", "password": "' + dmpdv.odoo_acesso + '"}';


  httpClient.AllowRedirect := true;
  httpClient.AddHeader('User-Agent', 'Mozilla/5.0(compatible; fpweb)');
  {
  url := dmPdv.path_integra_url + '/session/auth/logout';
  With httpClient do
  begin
    AddHeader('Content-Type', 'application/json');
    RequestBody := TStringStream.Create(autenticacao);
    responseData := Post(url);
    ver := httpClient.ResponseHeaders.Text;
  end;
  }

  url := dmPdv.path_integra_url + '/session/auth/login';

  //  url := dmPdv.path_integra_url + '/web/session/authenticate/';

  With httpClient do
  begin
    AddHeader('Content-Type', 'application/json');
    RequestBody := TStringStream.Create(autenticacao);
    responseData := Post(url);
    ver := httpClient.ResponseHeaders.Text;
    memoDados.Lines.Add(responseData);
    Memo1.Lines.Add(responseData);
    ver := IntToStr(httpClient.ResponseStatusCode);
    ver := httpClient.ResponseStatusText;
    ver := httpclient.Cookies.Text;
    jData := GetJSON(responseData);

    for i := 0 to jData.Count - 1 do
    begin
      jItem := jData.Items[i];
      object_name := TJSONObject(jData).Names[i];
      if object_name = 'result' then
      begin
        jItemB := jData.Items[i];
        for k := 0 to jItemB.Count - 1 do
        begin
          field_name := TJSONObject(jItemB).Names[k];
          Memo1.Lines.Add(field_name);
          field_value := jItemB.FindPath(TJSONObject(jItemB).Names[k]).Value;
          Memo1.Lines.Add(field_value);
          if field_name = 'session_id' then
          begin
            edSessao.Text := field_value;
            autenticacao := '"login": "' +
              dmpdv.odoo_user + '", "session": "' +
              edSessao.Text + '", "db": "' +
              dmPdv.odoo_database + '"';
            Memo1.Lines.Add(autenticacao);
            exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfIntegracaoOdoo.FormCreate(Sender: TObject);
var
  ArquivoINI: TIniFile;
begin
  exibe_sql:=TStringList.Create;
  ArquivoINI := TIniFile.Create('pdv_caixa.ini');
  c_caixa := ArquivoINI.ReadString('PDV', 'caixa', dmPdv.ccusto);
  ArquivoINI.Free;
  httpClient := TFPHttpClient.Create(Nil);
  postJson := TJSONObject.Create;
end;

procedure TfIntegracaoOdoo.FormDestroy(Sender: TObject);
begin
  httpClient.Free;
  postJson.Free;
  exibe_sql.Free;
end;

procedure TfIntegracaoOdoo.FormShow(Sender: TObject);
begin
  limpa_memo := 'S';
  if (dmPdv.NFE_Teste = 'S') then
  begin
    TimerPedido.Enabled:=False;
    Timer2.Enabled:=False;
    Timer3.Enabled:=False;
    TimerGeral.Enabled:=False;
  end;
  fIntegracaoOdoo.Caption:= 'Integrando Caixa : ' + c_caixa;
end;

procedure TfIntegracaoOdoo.TimerGeralTimer(Sender: TObject);
begin
  TimerPedido.Enabled:=False;
  Sleep(5000);
  btnConsultaUltimoPedidoGeral.Click;
  TimerPedido.Enabled:=True;
end;

procedure TfIntegracaoOdoo.TimerPedidoTimer(Sender: TObject);
begin
  btnEnviandoPedido.Click;
end;

procedure TfIntegracaoOdoo.Timer2Timer(Sender: TObject);
begin
  btnProduto.Click;
end;

procedure TfIntegracaoOdoo.Timer3Timer(Sender: TObject);
begin
  btnCliente.Click;
  btnSangria_Rec.Click;
end;

function TfIntegracaoOdoo.ler_retorno(responseData: String): String;
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

procedure TfIntegracaoOdoo.cria_json(ultimoPedido: String);
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
  dmPdv.sqBusca1.Close;
  dmPdv.sqBusca1.Sql.Clear;
  sql_str := 'SELECT FIRST 10 m.CODMOVIMENTO ';
  sql_str += ' FROM MOVIMENTO m , VENDA v, MOVIMENTODETALHE md';
  sql_str += ' WHERE m.CODMOVIMENTO = v.CODMOVIMENTO';
  sql_str += '   AND md.CODMOVIMENTO = m.CODMOVIMENTO';
  if (edEste_str <> '') then
  begin
    sql_str += ' AND m.CODMOVIMENTO = ' + edEste_str;
    edEste_str := IntToStr(StrToInt(edEste_str) + 1);
  end
  else begin
    sql_str += '   AND m.CODMOVIMENTO ' + ultimoPedido;
    sql_str += '   AND m.CODALMOXARIFADO = ' + c_caixa;
  end;
  sql_str += '   AND m.STATUS = 1 ';
  sql_str += '   AND md.STATUS = ' + QuotedStr('0');
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
      dmPdv.sqLancamentos.Close;
      dmPdv.sqLancamentos.Params.ParamByName('PMOV').AsInteger := cod_mov;

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
          arquivo.Clear;
          postJson.Clear;
        end;
      end
      else begin
        exibe_sql.Add('Último pedido enviado: ' + ultimoPedido + '. Sem mais pedidos para enviar.');
      end;
      dmPdv.sqBusca1.Next;
  end;
  arquivo.Free;
end;

function TfIntegracaoOdoo.monta_arquivo_movimento(arquivo_linha: TJsonNode): TJsonNode;
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

function TfIntegracaoOdoo.monta_arquivo_recebimento(vcodmovimento: String;
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
  dmPdv.busca_sql('SELECT CODFORMA, COD_VENDA, ID_ENTRADA, FORMA_PGTO' +
    ' , CAIXA , N_DOC, VALOR_PAGO, CAIXINHA, TROCO, DESCONTO, STATE' +
    ' FROM FORMA_ENTRADA WHERE STATE < 2 AND ID_ENTRADA = ' +
    vCodMovimento + ' ORDER BY FORMA_PGTO');

  forma_pagamento := dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsInteger;

  item := '';
  itens := '[';
  num := 0;
  while not dmPdv.sqBusca.EOF do
  begin
    codproduto := '' ;
    if forma_pagamento = 9 then
    begin
      dmPdv.sqBusca1.Close;
      //busca movimentodetalhe o codproduto devolvido
      dmPdv.sqBusca1.SQL.Clear;
      dmPdv.sqBusca1.SQL.Add('SELECT CODPRODUTO' +
        ' FROM MOVIMENTODETALHE WHERE CODMOVIMENTO = ' +
      vCodMovimento );
      dmPdv.sqBusca1.Open;
      //busca movimentodetalhe o codproduto devolvido
      codproduto := dmPdv.sqBusca1.FieldByName('CODPRODUTO').AsString;
    end;
    item += '{';
    num += 1;
    for i:=0 to dmPdv.sqBusca.FieldDefs.Count-1 do
    begin
      try
      campo := dmPdv.sqBusca.FieldDefs.Items[i].Name;
      campos := 'FORMA_PGTO VALOR_PAGO CODCLIENTE DESCONTO ID_ENTRADA PROD_TROCA';
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
    item += ', "PROD_TROCA": "' + codproduto + '"';
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

function TfIntegracaoOdoo.monta_arquivo_movimentodetalhe(vcodmovimento: String;
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

function TfIntegracaoOdoo.logar(): TFPHttpClient;
begin
  // retorna a session
  autenticacao := '{"jsonrpc": "2.0", "params": {"login": "' + dmpdv.odoo_user +
    '", "password": "' + dmpdv.odoo_acesso + '", "db": "' +
    dmPdv.odoo_database + '"}}';
  httpClient.AllowRedirect := true;
  httpClient.AddHeader('User-Agent', 'Mozilla/5.0(compatible; fpweb)');
  httpClient.AddHeader('Content-Type', 'application/json');
  httpClient.RequestBody := TStringStream.Create(autenticacao);
  httpClient.Post(dmPdv.path_integra_url + '/web/session/authenticate/');
  result := httpClient;
end;

function TfIntegracaoOdoo.consultaUltimoPedido(): String;
Var
  responseData: String;
  ArquivoINI: TIniFile;
begin
  edtUltimpoPedido:='';
    ArquivoINI := TIniFile.Create('pdv_caixa.ini');
    c_caixa := ArquivoINI.ReadString('PDV', 'caixa', dmPdv.ccusto);
    fIntegracaoOdoo.Caption:= 'Integrando Caixa : ' + c_caixa;
    ArquivoINI.Free;
    postJson.Clear;
    postJson.Add('title', 'Consultando ultimo pedido');
    postJson.Add('caixa', c_caixa);
    exibe_sql.Clear;
    httpClient := logar();
    With httpClient do
    begin
        AddHeader('Content-Type', 'application/json');
        RequestBody := TStringStream.Create(postJson.AsJSON);
        responseData := Post(dmPdv.path_integra_url + '/pedidoconsulta');
        exibe_sql.Add(responseData);
        edtUltimpoPedido := ler_retorno(responseData);
    end;
    result := edtUltimpoPedido;
end;

function TfIntegracaoOdoo.consultaUltimoPedidoGeral(): String;
Var
  responseData: String;
  ArquivoINI: TIniFile;
  sql_str: string;
  pedidos : string;
begin
    ArquivoINI := TIniFile.Create('pdv_caixa.ini');
    c_caixa := ArquivoINI.ReadString('PDV', 'caixa', dmPdv.ccusto);
    ArquivoINI.Free;
    postJson.Clear;

    dmPdv.sqBusca1.Close;
    dmPdv.sqBusca1.Sql.Clear;
    sql_str := 'SELECT m.CODMOVIMENTO ';
    sql_str += ' FROM MOVIMENTO m , VENDA v, MOVIMENTODETALHE md';
    sql_str += ' WHERE m.CODMOVIMENTO = v.CODMOVIMENTO';
    sql_str += '   AND md.CODMOVIMENTO = m.CODMOVIMENTO';
    sql_str += '   AND m.STATUS = 1 ';
    sql_str += '   AND md.STATUS = ' + QuotedStr('0');
    sql_str += '   AND m.CODALMOXARIFADO = ' + c_caixa;
    sql_str += ' ORDER BY m.CODMOVIMENTO DESC ';
    dmPdv.sqBusca1.SQL.Add(sql_str);
    dmPdv.sqBusca1.Open;
    pedidos := '[';
    while not dmPdv.sqBusca1.EOF do
    begin
      if pedidos <> '[' then
        pedidos += ', ';
      pedidos += IntToStr(dmPdv.sqBusca1.Fields[0].AsInteger);
      dmPdv.sqBusca1.Next;
    end;
    postJson.Add('title', 'Consultando todos pedidos');
    postJson.Add('todos', pedidos + ']');
    postJson.Add('caixa', c_caixa);

    httpClient := logar();
    With httpClient do
    begin
        AddHeader('Content-Type', 'application/json');
        RequestBody := TStringStream.Create(postJson.AsJSON);
        responseData := Post(dmPdv.path_integra_url + '/pedidoconsultageral');
        exibe_sql.Add(responseData);
        edtUltimpoPedido := ler_retorno(responseData);
    end;
  result := edtUltimpoPedido;
end;

procedure TfIntegracaoOdoo.envia_json(dados_json: TJSONObject);
var responseData: String;
begin
  httpClient := logar();
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

procedure TfIntegracaoOdoo.executa_sql;
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

procedure TfIntegracaoOdoo.comunica_server(tabela: String; campo_chave: String;
  campos_select: String; campo_data: String);
Var
  responseData: String;
  result: String;
  //c: TJsonNode;
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
  ver, ver_x: String;
  sql_campo, sql_valor, sql_update, sql_update1: String;
  url_server : String;
  FS: TFormatSettings;
  data_cad, data_ultimo : TDateTime;
  cod_chave, data_alterado : String;
begin
  FS := DefaultFormatSettings;
  FS.DateSeparator := '/';
  FS.ShortDateFormat := 'mm/dd/yyyy';
  FS.ShortTimeFormat := 'hh:mm:ss';

  if (limpa_memo = 'S') then
    memoDados.Lines.Clear;

  DecimalSeparator:='.';

  dados:= '[{';
  postJson.Clear;
  postJson.Add('title', tabela);

  if (tabela = 'CAIXA_CONTROLE') then
  begin
    dmpdv.busca_sql('SELECT FIRST 3 ' + campos_select + ' FROM ' + tabela + ' ORDER BY CODCAIXA DESC');
    While not dmpdv.sqBusca.EOF do
    begin
      //if (dmPdv.sqBusca.Fields[1].AsString = 'F') then   // comentado dia 22/02/20
      //begin
        if (dados <> '[{') then
          dados += '}, {';
        dados += '"CODCAIXA": ' + IntToStr(dmPdv.sqBusca.Fields[0].AsInteger);
        dados += ', "SITUACAO": "' + dmPdv.sqBusca.Fields[1].AsString +'"';
      //end;
      dmpdv.sqBusca.Next;
    end;
    dados += '}]';
    postJson.Add('caixa', dados);
  end;

  if (tabela = 'CAIXA_CONTROLE') then
    url_server := '/caixaconsulta';
  if (tabela = 'PRODUTOS') then
    url_server := '/produtoconsulta';
  if (tabela = 'CLIENTES') then
    url_server := '/clienteconsulta';
  if (tabela = 'USUARIO') then
    url_server := '/usuarioconsulta';
  //if (tabela = 'RECEBER') then
  //  url_server := '/contasconsulta';
  dados := '';

  if (limpa_memo = 'S') then
    memoDados.Lines.Clear;

  DecimalSeparator:='.';
  httpClient := logar();
  With httpClient do
  begin
    AddHeader('Content-Type', 'application/json');
    RequestBody := TStringStream.Create(postJson.AsJSON);
    responseData := Post(dmPdv.path_integra_url + url_server);
    memoResult.Lines.Add(responseData);
   // memo2.Lines.Add(responseData);
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
            if field_name = LowerCase(campo_chave) then
            begin
              dmpdv.busca_sql('SELECT ' + campos_select + ' FROM ' + tabela +
                ' WHERE ' + campo_chave + ' = ' + field_value);
              if dmpdv.sqBusca.IsEmpty then
              begin
                ver := 'insere';
              end;
              cod_chave := field_value;
            end;
            if (field_name = LowerCase(campo_data)) then
              data_alterado := field_value;
            if sql_campo <> '' then
            begin
              sql_campo += ', ' +  field_name;
              sql_valor += ', ' +  QuotedStr(field_value);
            end
            else begin
              sql_campo += field_name;
              sql_valor += QuotedStr(field_value);
            end;
            //if ((field_name = 'codpro') and (copy(field_value,0,15) = 'Q471A0286PMARIN')) then
            //   ver_x:= sql_campo;
            if ((sql_update1 <> '') and (field_name <> LowerCase(campo_chave))) then
            begin
                sql_update += ', ' + field_name + '=' + QuotedStr(field_value);
            end;
            if ((sql_update1 = '') and (field_name <> LowerCase(campo_chave))) then
            begin
              sql_update1 += field_name + '=' + QuotedStr(field_value);
            end;
          end;
          if ver = 'insere' then
          begin
            memoDados.Lines.add('INSERT INTO ' + tabela + '('+ sql_campo +
              ') VALUES(' + sql_valor + ');');
            ver := '';
            sql_update := '';
            sql_update1 := '';
          end
          else begin
            if (campo_data <> '') then
            begin
              data_cad := StrToDateTime(data_alterado, FS);
              if (dmpdv.sqBusca.Fields[0].AsDateTime < data_cad) then
              begin
                memoDados.Lines.add('UPDATE ' + tabela + ' SET ' + sql_update1 + sql_update +
                  ' WHERE ' + campo_chave + ' = ' + cod_chave + ';');
              end;
            end;
            sql_update := '';
            sql_update1 := '';
          end;
        end;
      end;
    end;
    executa_sql;
  end;
end;

procedure TfIntegracaoOdoo.envia_sangria_reforco;
var
  codForma: integer;
  vlrSangria: double;
  Campo : String;
  forma_pag : String;
  Valor : String;
  tipo :integer;
  //fInteg: TfIntegracaoOdoo;
  responseData: String;
  sql_str , pedidos: string;
begin
  dmPdv.sqBusca1.Close;
  dmPdv.sqBusca1.Sql.Clear;
  sql_str := 'SELECT CAIXA,N_DOC,VALOR_PAGO,CODFORMA ,COD_VENDA ';
  sql_str += 'FROM FORMA_ENTRADA  ';
  sql_str += 'WHERE CAIXA = ' + QuotedStr(c_caixa);
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

  if(pedidos <> '[{}]') then
  begin
    //httpClient := TFPHttpClient.Create(Nil);
    //postJson := TJSONObject.Create;
    try
      postJson.Add('title', 'Sangria/Reforço');
      postJson.Add('todos', pedidos);
      //fInteg := TfIntegracaoOdoo.Create(Self);
      httpClient := logar();
      With httpClient do
      begin
        AddHeader('Content-Type', 'application/json');
        RequestBody := TStringStream.Create(postJson.AsJSON);
        responseData := Post(dmPdv.path_integra_url + '/enviasangria');
        //memoDados.Lines.Add(responseData);
      end;
      //fInteg.Free;
      //postJson.Free;
    except
    end;

  end;

end;

procedure TfIntegracaoOdoo.envia_devolucao;
var
  codForma: integer;
  vlrSangria: double;
  Campo : String;
  forma_pag : String;
  Valor : String;
  tipo :integer;
  //fInteg: TfIntegracaoOdoo;
  responseData: String;
  sql_str , devolucao: string;
begin
  dmPdv.sqBusca1.Close;
  dmPdv.sqBusca1.Sql.Clear;
  sql_str := 'select first 1 mov.codmovimento,mov.codnatureza,mov.hist_mov, ';
  sql_str += 'movd.quantidade,movd.codproduto, p.produto ';
  sql_str += 'from produtos p ';
  sql_str += 'inner join movimentodetalhe movd on (p.codproduto = movd.codproduto) ';
  sql_str += 'inner join movimento mov on (movd.codmovimento = mov.codmovimento) ';
  sql_str += 'where mov.codnatureza = ' + QuotedStr('1');
  sql_str += 'order by mov.codmovimento desc ';
  dmPdv.sqBusca1.SQL.Add(sql_str);
  dmPdv.sqBusca1.Open;
  DecimalSeparator:='.';
  devolucao := '[{';
  while not dmPdv.sqBusca1.EOF do
  begin
    if devolucao <> '[{' then
      devolucao += '}, {';
    devolucao += '"motivo": "' + dmPdv.sqBusca1.Fields[2].AsString + '",' +
      '"origin": "' + IntToStr(dmPdv.sqBusca1.Fields[0].AsInteger)+ '",' +
      '"quantidade": "' + FloatToStr(dmPdv.sqBusca1.Fields[3].AsFloat) + '",' +
      '"produto": "' + IntToStr(dmPdv.sqBusca1.Fields[4].AsInteger) + '",'+
     '"nproduto": "' + dmPdv.sqBusca1.Fields[5].AsString + '"';

    dmPdv.sqBusca1.Next;
  end;
  devolucao += '}]';
  memoResult.Lines.Add(devolucao);

  if(devolucao <> '[{}]') then
  begin
    //httpClient := TFPHttpClient.Create(Nil);
    //postJson := TJSONObject.Create;
    try
      postJson.Add('title', 'Devolucao');
      postJson.Add('motivo', dmPdv.sqBusca1.Fields[2].AsString);
      postJson.Add('origin', IntToStr(dmPdv.sqBusca1.Fields[0].AsInteger));
      postJson.Add('quantidade',FloatToStr(dmPdv.sqBusca1.Fields[3].AsFloat));
      postJson.Add('produto', IntToStr(dmPdv.sqBusca1.Fields[4].AsInteger));
      postJson.Add('nproduto', dmPdv.sqBusca1.Fields[5].AsString);
      //fInteg := TfIntegracaoOdoo.Create(Self);
      httpClient := logar();
      With httpClient do
      begin
        AddHeader('Content-Type', 'application/json');
        RequestBody := TStringStream.Create(postJson.AsJSON);
        responseData := Post(dmPdv.path_integra_url + '/devolucao');
        memoDados.Lines.Add(responseData);
      end;
      //fInteg.Free;
      //postJson.Free;
    except
    end;
  end;

end;

procedure TfIntegracaoOdoo.envia_recebimentos;
var
  responseData: String;
  sql_str: string;
begin
  memoResult.Lines.Clear;
  memoResult.Lines.Add('Verificando baixa do Contas a Receber');
  dmPdv.sqBusca1.Close;
  dmPdv.sqBusca1.Sql.Clear;
  sql_str := 'SELECT CAIXA, N_DOC, VALOR_PAGO ,CODFORMA ,COD_VENDA, TROCO, ID_ENTRADA ';
  sql_str += 'FROM FORMA_ENTRADA  ';
  sql_str += 'WHERE CAIXA = ' + QuotedStr(c_caixa);
  sql_str += 'AND COD_VENDA = 2';
  sql_str += 'ORDER BY CODFORMA DESC ';
  dmPdv.sqBusca1.SQL.Add(sql_str);
  dmPdv.sqBusca1.Open;
  DecimalSeparator:='.';
  sql_str := '';
  //if (limpa_memo = 'S') then
  httpClient := logar();
  while not dmPdv.sqBusca1.EOF do
  begin
    // Envia os Recebimentos novamente
    postJson.Clear;
    postJson.Add('title', 'Contas a Receber');
    postJson.Add('cod_cliente', '0');
    postJson.Add('valor_pago', FloatToStr(dmPdv.sqBusca1.Fields[2].AsFloat));
    postJson.Add('diario', dmPdv.sqBusca1.Fields[1].AsString);
    postJson.Add('caixa', IntToStr(dmPdv.sqBusca1.Fields[0].AsInteger));
    postJson.Add('cod_forma', IntToStr(dmPdv.sqBusca1.Fields[3].AsInteger));
    postJson.Add('juro', FloatToStr(dmPdv.sqBusca1.Fields[5].AsFloat));
    postJson.Add('aml_id', IntToStr(dmPdv.sqBusca1.Fields[6].AsInteger));
    memoResult.Lines.Add('Conta baixada: ' + IntToStr(dmPdv.sqBusca1.Fields[6].AsInteger));
    sql_str := 'tem';
    With httpClient do
    begin
      AddHeader('Content-Type', 'application/json');
      RequestBody := TStringStream.Create(postJson.AsJSON);
      responseData := Post(dmPdv.path_integra_url + '/contasconsulta');
      memoResult.Lines.Add(responseData);
    end;
    dmPdv.sqBusca1.Next;
  end;
  if (sql_str = '') then
    memoResult.Lines.Add('Sem contas para baixar.');
end;
end.

