unit uAbrirCaixa2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  MaskEdit, StdCtrls, udmpdv, DateTimePicker, db, IniFiles, JsonTools, fpjson, fphttpclient,StrUtils;

type

  { TfAbreCaixa }

  TfAbreCaixa = class(TForm)
    btnAbreCX: TBitBtn;
    btnAbrefecha: TBitBtn;
    btnSair: TBitBtn;
    dtData: TDateTimePicker;
    edSessao: TEdit;
    edValor: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblCaixa: TLabel;
    memoresult: TMemo;
    memodados: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAbreCXClick(Sender: TObject);
    procedure btnAbrefechaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    c_caixa: String;
    postJson : TJSONObject;
    httpClient : TFPHttpClient;
    autenticacao: String;
  public
   abri_cx : integer;
   function logar():TFPHttpClient;
   procedure executa_sql;
   procedure comunica_server(tabela: String; campo_chave: String; campos_select: String; campo_data: String);
  end;

var
  fAbreCaixa: TfAbreCaixa;

implementation
uses uPdv,uMovimentoProc;
{$R *.lfm}

{ TfAbreCaixa }

procedure TfAbreCaixa.btnAbrefechaClick(Sender: TObject);
var str:string;
  codCaixa:integer;
  vlrCaixa:double;
  ArquivoINI: TIniFile;
begin
  try
  codCaixa := dmPdv.busca_generator('GEN_CAIXA');
  str := 'insert into CAIXA_CONTROLE (IDCAIXACONTROLE, CODCAIXA, CODUSUARIO,' +
    'SITUACAO, NOMECAIXA, MAQUINA, DATAABERTURA, VALORABRE, DATAFECHAMENTO) values (';
  str := str + IntToStr(codCaixa);
  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    str := str + ', ' + IntToStr(codCaixa);
    ArquivoINI := TIniFile.Create('pdv_caixa.ini');
    ArquivoINI.WriteString('PDV', 'caixa', IntToStr(codCaixa));
    ArquivoINI.Free;
  end
  else
    //str := str + ', ' + dmpdv.ccusto_padrao; // Manoel
    str := str + ', ' + IntToStr(codCaixa);
  str := str + ', ' + dmpdv.varLogado;
  str := str + ', ' + QuotedStr('o');
  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    str := str + ', ' + QuotedStr(dmpdv.nomeLogado + '/' +  IntToStr(codCaixa));
    dmPdv.nomeCaixa := dmpdv.nomeLogado + '/' +  IntToStr(codCaixa);
  end
  else
    str := str + ', ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtData.Date));
  str := str + ', ' + QuotedStr(dmpdv.MICRO);
  str := str + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtData.Date));
  vlrCaixa := StrToFloat(edValor.Text);
  DecimalSeparator:='.';
  str := str + ', ' + FloatToStr(vlrCaixa);
  DecimalSeparator:=',';
  str := str + ',' + QuotedStr('01.01.11') + ')';
  dmPdv.IbCon.ExecuteDirect(str);
  dmPdv.sTrans.Commit;
  dmPdv.idcaixa := IntToStr(codCaixa);
  dmPdv.ccusto := IntToStr(codCaixa);

  ShowMessage('Caixa aberto com sucesso!');
        Except
        on dmPdv: EDatabaseError do
        begin
          MessageDlg('Error','Erro para abrir o caixa : ' +
            dmPdv.Message,mtError,[mbOK],0);
          //strans.Rollback;
        end;
      end;

  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
   btnAbreCX.Click;
   end;

   abri_cx := 1;
   btnSair.Click;
   fMovimentoProc.Close;
   fPdv.procFormShow;

   btnAbrefecha.Enabled := False;

end;

procedure TfAbreCaixa.btnAbreCXClick(Sender: TObject);
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

  comunica_server('CAIXA_CONTROLE', 'CODCAIXA', 'CODCAIXA, SITUACAO', '');
  exit;

  postJson.Add('caixa', dados);
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
  end;
end;


procedure TfAbreCaixa.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfAbreCaixa.FormCreate(Sender: TObject);
begin
  postJson := TJSONObject.Create;
  httpClient := TFPHttpClient.Create(Nil);
end;

procedure TfAbreCaixa.FormShow(Sender: TObject);
begin
  dtData.Date:=Now;
  dmPdv.busca_sql('SELECT NOMECAIXA FROM CAIXA_CONTROLE ' +
    ' WHERE CODCAIXA = ' + dmpdv.ccusto_padrao +
    '   AND CODUSUARIO = ' + dmpdv.varLogado +
    '   AND SITUACAO = ' + QuotedStr('o'));
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    btnAbrefecha.Enabled := False;
    lblCaixa.Caption:= dmPdv.sqBusca.FieldByName('NOMECAIXA').AsString;
  end;
end;

function TfAbreCaixa.logar: TFPHttpClient;
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

procedure TfAbreCaixa.executa_sql;
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

end;

procedure TfAbreCaixa.comunica_server(tabela: String; campo_chave: String;
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
  if (tabela = 'USUARIO') then
    url_server := '/usuarioconsulta';
  dados := '';

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

end.

