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
begin
  // VER SE EXISTE ARQUIVO
  listaArquivos := TStringList.Create;
  try
    FindAllFiles(listaArquivos, path_integracao, '*.txt', true);
    for k:=0 to Pred(listaArquivos.Count) do
    begin
      // SE EXISTE ENVIA
      postJson := TJSONObject.Create;
      dadosJson := TJsonNode.Create;
      postJson.Add('title', 'Enviando Movimento');
      postJson.Add('body', nome_empresa_integra);
      dadosJson.LoadFromFile(listaArquivos[k]);
      postJson.Add('tab_venda', dadosJson.ToString);
      postJson.Add('userId', 1);
      With TFPHttpClient.Create(Nil) do
        try
          AddHeader('Content-Type', 'application/json');
          RequestBody := TStringStream.Create(postJson.AsJSON);
          responseData := Post(path_integracao_url);
          if FileExists(path_integracao + responseData + '_' + cod_caixa_integra + '.txt') then
            DeleteFile(path_integracao + responseData + '_' + cod_caixa_integra + '.txt');
        finally
         Free;
        end;
    end;
  finally
    listaArquivos.Free;
  end;
end;

end.

