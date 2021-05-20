unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, RichMemo, JsonTools, fpjson, FileUtil, SynEdit, fphttpclient, IniFiles, Base64;

type

  { TfChatATS }

  TfChatATS = class(TForm)
    BitBtn1: TBitBtn;
    btnConsulta: TButton;
    Button1: TButton;
    edAssunto: TEdit;
    edCodCLiente: TEdit;
    edCNPJ: TEdit;
    edAtendimento: TEdit;
    edEmpresa: TEdit;
    edPath: TEdit;
    edRetorno: TEdit;
    edCanal: TEdit;
    edUsuario: TEdit;
    edMensagem: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    memoChat: TRichMemo;
    Timer1: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edAssuntoKeyPress(Sender: TObject; var Key: char);
    procedure edMensagemKeyPress(Sender: TObject; var Key: char);
    procedure edUsuarioChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure memoChatChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  fChatATS: TfChatATS;

implementation

{$R *.lfm}

{ TfChatATS }

procedure TfChatATS.BitBtn1Click(Sender: TObject);
var k: Integer;
  postJson: TJSONObject;
  dadosJson, c: TJsonNode;
  responseData: String;
  listaArquivos : TStringList;
  logs:TextFile;
  ver, usuario , retorno : String;
  path_integracao, path_integracao_url, nome_empresa_integra: String;
  somar : Integer;
begin
  if ((edAssunto.text = '') or (edMensagem.text = '')) then
    begin
      ShowMessage('Por favor preencher o Assunto e a Mensagem.');
      exit;
    end;
  somar := Length(memoChat.Lines.GetText);
  path_integracao := 'C:\home\';
  path_integracao_url := edPath.Text;
  nome_empresa_integra := edEmpresa.Text;
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
    //FindAllFiles(listaArquivos, path_integracao, '*.txt', true);
    //for k:=0 to Pred(listaArquivos.Count) do
    begin
      Writeln(logs, 'Iniciando integracao : ' + FormatDateTime('mm/dd/yyyy hh:MM', Now));
      Writeln(logs, 'Path : ' + path_integracao);
      Writeln(logs, 'URL : ' + path_integracao_url);

      // SE EXISTE ENVIA
      postJson := TJSONObject.Create;
      dadosJson := TJsonNode.Create;
      postJson.Add('title', edAssunto.text);

      Writeln(logs, 'Empresa : ' + nome_empresa_integra);

      postJson.Add('empresa', nome_empresa_integra);
      //dadosJson.LoadFromFile(listaArquivos[k]);
      //ver := listaArquivos[k];
      //Writeln(logs, 'Arquivo : ' + listaArquivos[k]);

      postJson.Add('chat', edMensagem.text);
      postJson.Add('user', 1);
      postJson.Add('cliente', edCodCliente.text);
      postJson.Add('cnpj', edCNPJ.text);
      postJson.Add('id', edAtendimento.Text);
      postJson.Add('canal', edCanal.Text);
      postJson.Add('img', '');
      if (edMensagem.Text <> '') then
      begin
        ver := edUsuario.text + ': ' + edMensagem.text;
        memoChat.Lines.Add(ver);
        memoChat.SetRangeColor(somar, Length(edUsuario.text)+ 1, clBlue);
        somar += Length(ver);
      end;
      With TFPHttpClient.Create(Nil) do
      begin
        try
          AddHeader('Content-Type', 'application/json');
          RequestBody := TStringStream.Create(postJson.AsJSON);
          responseData := Post(path_integracao_url);
          if (responseData <> 'N') then
          begin
            dadosJson.value := responseData;
            //for c in dadosJson do
            begin
              ver := dadosJson.value;
              retorno := dadosJson.find('msg').AsString;
              usuario := dadosJson.find('user').AsString;
              if (dadosJson.find('atendimento').AsString <> '00000') then
                edRetorno.Text := dadosJson.find('atendimento').AsString;
              if (dadosJson.find('canal').AsString <> '000') then
                edCanal.Text := dadosJson.find('canal').AsString;
            end;
            if (retorno <> '') then
            begin
              memoChat.Lines.Add(usuario + ': ' + retorno);
              memoChat.SetRangeColor(somar+1, Length(edUsuario.text)+ 1, clBlue);
              somar += Length(responseData);
              //memoChat.SetRangeColor(1, Length(responseData), clRed);
            end;
          end;
        finally
         Free;
        end;
      end;
      edAtendimento.Text := IntToStr(StrToInt(edAtendimento.Text)+1);
    end;
  finally
    listaArquivos.Free;
    CloseFile(logs);
  end;
  edMensagem.text := '';
  edMensagem.SetFocus;
end;

procedure TfChatATS.btnConsultaClick(Sender: TObject);
var k: Integer;
  postJson: TJSONObject;
  dadosJson, c: TJsonNode;
  responseData: String;
  listaArquivos : TStringList;
  logs:TextFile;
  ver, usuario , retorno : String;
  path_integracao, path_integracao_url, nome_empresa_integra: String;
  somar : Integer;
begin
  //se deixar assim nao consulta
  {if ((edAssunto.text = '') or (edMensagem.text = '')) then
    begin
      exit;
    end;}
  // consulta se teve resposta
  somar := Length(memoChat.Lines.GetText);
  path_integracao := 'C:\home\';
  path_integracao_url := edPath.Text;
  nome_empresa_integra := edEmpresa.Text;
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
    begin
      Writeln(logs, 'Iniciando integracao : ' + FormatDateTime('mm/dd/yyyy hh:MM', Now));
      Writeln(logs, 'Path : ' + path_integracao);
      Writeln(logs, 'URL : ' + path_integracao_url);

      // SE EXISTE ENVIA
      postJson := TJSONObject.Create;
      dadosJson := TJsonNode.Create;
      postJson.Add('title', edAssunto.text);
      Writeln(logs, 'Empresa : ' + nome_empresa_integra);
      postJson.Add('empresa', nome_empresa_integra);
      postJson.Add('chat_retorno', edMensagem.text);
      postJson.Add('user', 1);
      postJson.Add('cliente', edCodCliente.text);
      postJson.Add('cnpj', edCNPJ.text);
      postJson.Add('id', edAtendimento.Text);
      postJson.Add('img', '');
      With TFPHttpClient.Create(Nil) do
      begin
        try
          AddHeader('Content-Type', 'application/json');
          RequestBody := TStringStream.Create(postJson.AsJSON);
          responseData := Post(path_integracao_url);
          if (responseData <> 'N') then
          begin
            dadosJson.value := responseData;
            //for c in dadosJson do
            begin
              ver := dadosJson.value;
              retorno := dadosJson.find('msg').AsString;
              usuario := dadosJson.find('user').AsString;
              if (dadosJson.find('atendimento').AsString <> '00000') then
                edRetorno.Text := dadosJson.find('atendimento').AsString;
              if (dadosJson.find('canal').AsString <> '000') then
                edCanal.Text := dadosJson.find('canal').AsString;
            end;
            if (retorno <> '') then
            begin
              memoChat.Lines.Add(usuario + ': ' + retorno);
              memoChat.SetRangeColor(somar+1, Length(edUsuario.text)+ 1, clBlue);
              somar += Length(responseData);
              OnBeep;
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

procedure TfChatATS.Button1Click(Sender: TObject);

Var
  Respo: TStringStream;
  S : String;
    img: TJPEGImage;
    imgstream, outputstream: tstream;
    encoder: TBase64EncodingStream;
    path_integracao_url: String;
    postJson: TJSONObject;
    dadosJson, c: TJsonNode;
    responseData: String;
begin
  memo1.Lines.Clear;
  imgstream := TMemoryStream.create();
  outputstream := TStringStream.Create('');
   img := TJPEGImage.Create;
   img.LoadFromFile('C:\home\sisadmin\logo.jpg');
   img.SaveToStream(imgstream);
   encoder := TBase64EncodingStream.create(outputstream);
   imgstream.Position:=0;
   encoder.CopyFrom(TStringStream(imgstream), imgstream.Size);
   encoder.Flush;
   memo1.Text:='data:image/jpg;base64,'+ TStringStream(outputstream).DataString;
  With TFPHttpClient.Create(Nil) do
    try
      {Respo := TStringStream.Create('');
      FileFormPost(edPath.text,'PostFilenameParam (ex. file)','C:\home\sisadmin\logo.jpg',Respo);
      S := Respo.DataString;
      Respo.Destroy;}
        path_integracao_url := edPath.Text;
        postJson := TJSONObject.Create;
        dadosJson := TJsonNode.Create;
        postJson.Add('title', edAssunto.text);
        postJson.Add('empresa', edEmpresa.Text);
        postJson.Add('chat', 'imagem');
        postJson.Add('user', 1);
        postJson.Add('cliente', edCodCliente.text);
        postJson.Add('cnpj', edCNPJ.text);
        postJson.Add('id', edAtendimento.Text);
        postJson.Add('img', memo1.Text);
        postJson.Add('canal', edCanal.Text);
        AddHeader('Content-Type', 'application/json');
        RequestBody := TStringStream.Create(postJson.AsJSON);
        responseData := Post(path_integracao_url);

    finally
      imgstream.free;
      img.free;
      Free;
    end;

end;

procedure TfChatATS.edAssuntoKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
  begin
     SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfChatATS.edMensagemKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
  begin
     SelectNext(ActiveControl, True, True);
     BitBtn1.Click;
  end;
end;

procedure TfChatATS.edUsuarioChange(Sender: TObject);
begin

end;

procedure TfChatATS.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
   Ini : TIniFile;
   path_exe : String;
begin
  path_exe := ExtractFilePath(ParamStr(0));
  if FileExists(path_exe  + 'dbxconnections.ini') then
  begin
    Ini := TIniFile.Create(path_exe + 'dbxconnections.ini');
    try
      Ini.WriteString( 'CHAT','path_url',edPath.Text);
      Ini.WriteString( 'CHAT','CNPJ' ,edCNPJ.Text);
      Ini.WriteString( 'CHAT','Empresa',edEmpresa.Text);
      Ini.WriteString( 'CHAT','CodOdoo',edCodCLiente.Text);
      Ini.WriteString( 'CHAT','User' ,edUsuario.Text);
    finally
      Ini.Free;
    end;
  end;
end;

procedure TfChatATS.FormCreate(Sender: TObject);
var
   Ini : TIniFile;
   path_exe : String;
begin
  // carrega as configuracoes
  path_exe := ExtractFilePath(ParamStr(0));
  if FileExists(path_exe  + 'dbxconnections.ini') then
    begin
      Ini := TIniFile.Create(path_exe + 'dbxconnections.ini');
      try
        edPath.Text := Ini.ReadString('CHAT', 'path_url', 'http://atsadmin.atsti.com.br:8905');
        edCNPJ.Text := Ini.ReadString('CHAT', 'CNPJ', '');
        edEmpresa.Text := Ini.ReadString('CHAT', 'Empresa', '');
        edCodCLiente.Text := Ini.ReadString('CHAT', 'CodOdoo', '');
        edUsuario.Text := Ini.ReadString('CHAT', 'User', '');
        if (edCNPJ.text <> '') then
          edCNPJ.Enabled:= false;
        if (edEmpresa.text <> '') then
          edEmpresa.Enabled:= false;
        if (edCodCliente.text <> '') then
          edCodCliente.Enabled:= false;
      finally
        Ini.free;
      end;
    end;
end;

procedure TfChatATS.memoChatChange(Sender: TObject);
begin

end;

procedure TfChatATS.Timer1Timer(Sender: TObject);
begin
  // consulta se teve resposta
  btnConsulta.Click;
end;

end.

end;

end.

