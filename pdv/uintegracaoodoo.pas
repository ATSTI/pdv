unit uIntegracaoOdoo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, udmpdv, fpjson, jsonparser, fphttpclient, db, sqldb;

type

  { TIntegracaoOdoo }

  TIntegracaoOdoo = class(TThread)
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
var i: Integer;
  postJson: TJSONObject;
  dadosJson: TJSONObject;
  responseData: String;
  ver: string;
  sqMovIntegra: TSQLQuery;
begin
 {
  sqMovIntegra := TSQLQuery.Create;
  sqMovIntegra.DataBase := dmPdv.IbCon;
  comDados := 'N';
  postJson := TJSONObject.Create;
  dadosJson := TJSONObject.Create;
  ver := 'SELECT FIRST 10 m.CODMOVIMENTO, m.DATAMOVIMENTO, ' +
               'm.CODCLIENTE, m.STATUS, m.CODUSUARIO, m.CODVENDEDOR, ' +
               'm.CODALMOXARIFADO, DATEADD(3 hour to m.DATA_SISTEMA) ' +
               '  FROM MOVIMENTO m ' +
               ' WHERE m.STATUS = 1 ' +
               '  ORDER BY m.CODMOVIMENTO DESC';
  sqMovIntegra.SQL.Text := ver;
  dmPdv.IbCon.Connected := True;
  //dmPdv.sTrans.Active   := True;
  sqMovIntegra.Transaction := dmPdv.sTrans;
  sqMovIntegra.Open;
   // inclusao
   postJson.Add('title', 'Movimento');
   postJson.Add('body', 'Insert');
   postJson.Add('movimento', dadosJson);
   postJson.Add('userId', 1);
   While not sqMovIntegra.EOF do
   begin
     for i:=0 to sqMovIntegra.FieldDefs.Count-1 do
     begin
       comDados := 'S';
       ver := sqMovIntegra.FieldDefs.Items[i].Name;
       ver := sqMovIntegra.Fields[i].Value;
       dadosJson.Add(sqMovIntegra.FieldDefs.Items[i].Name, sqMovIntegra.Fields[i].Value);
     end;
     sqMovIntegra.Next;
   end;
   sqMovIntegra.Free;
   }
      With TFPHttpClient.Create(Nil) do
        try
          AddHeader('Content-Type', 'application/json');
          RequestBody := TStringStream.Create(postJson.AsJSON);
          responseData := Post('vitton.atsti.com.br:8905');
          //ShowMessage(responseData);
        finally
         Free;
        end;

end;

end.

