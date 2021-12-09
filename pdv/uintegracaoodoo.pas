unit uIntegracaoOdoo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, JsonTools, fpjson, jsonparser, fphttpclient, FileUtil;

type

  { TIntegracaoOdoo }

  TIntegracaoOdoo = class(TThread)
  public
    path_integracao : String;
    path_integracao_url: String;
    cod_caixa_integra: String;
    nome_empresa_integra: String;
  protected
    procedure Execute; override;
    procedure atualiza;
  end;

implementation

{ TIntegracaoOdoo }

procedure TIntegracaoOdoo.Execute;
begin
  atualiza;
end;

procedure TIntegracaoOdoo.atualiza;
var
  postJson: TJSONObject;
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
end;

end.

