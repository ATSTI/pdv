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
var k: Integer;
  postJson: TJSONObject;
  dadosJson: TJsonNode;
  responseData: String;
  listaArquivos : TStringList;
  logs:TextFile;
  ver : String;
begin
  // log
  ver := 'C:\home\log_integracao.txt';
  AssignFile(logs, ver);
  // VER SE EXISTE ARQUIVO
  listaArquivos := TStringList.Create;
  try
    if FileExists(ver) then
      Append(logs)
    else
      Rewrite(logs);
    FindAllFiles(listaArquivos, path_integracao, '*.txt', true);
    for k:=0 to Pred(listaArquivos.Count) do
    begin
      Writeln(logs, 'Iniciando integracao : ' + FormatDateTime('mm/dd/yyyy hh:MM', Now));
      Writeln(logs, 'Path : ' + path_integracao);
      Writeln(logs, 'URL : ' + path_integracao_url);

      // SE EXISTE ENVIA
      postJson := TJSONObject.Create;
      dadosJson := TJsonNode.Create;
      postJson.Add('title', 'Enviando Movimento');

      Writeln(logs, 'Empresa : ' + nome_empresa_integra);

      postJson.Add('body', nome_empresa_integra);
      dadosJson.LoadFromFile(listaArquivos[k]);
      ver := listaArquivos[k];
      Writeln(logs, 'Arquivo : ' + listaArquivos[k]);

      postJson.Add('tab_venda', dadosJson.ToString);
      postJson.Add('userId', 1);
      With TFPHttpClient.Create(Nil) do
      begin
        try
          AddHeader('Content-Type', 'application/json');
          RequestBody := TStringStream.Create(postJson.AsJSON);
          responseData := Post(path_integracao_url);
          if (responseData <> 'N') then
          begin
            Writeln(logs, 'Existe arquivo : ' + path_integracao + responseData + '_' + cod_caixa_integra + '.txt');
            if FileExists(path_integracao + responseData + '_' + cod_caixa_integra + '.txt') then
            begin
              Writeln(logs, 'Excluindo arquivo : ' + path_integracao + responseData + '_' + cod_caixa_integra + '.txt');
              DeleteFile(path_integracao + responseData + '_' + cod_caixa_integra + '.txt');
            end;
          end;
        finally
         Free;
        end;
      end;
    end;
  finally
    listaArquivos.Free;
    CloseFile(logs);
  end;
end;

end.

