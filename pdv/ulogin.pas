unit uLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls, StdCtrls, udmpdv, uSenhaNova, uPdv, base64, Process;

type

  { TfLogin }

  TfLogin = class(TForm)
    BitBtn1: TBitBtn;
    btnInfo: TBitBtn;
    btnLogin: TBitBtn;
    edLogin: TLabeledEdit;
    edSenha: TLabeledEdit;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    pnInfo: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure edLoginKeyPress(Sender: TObject; var Key: char);
    procedure edSenhaKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  fLogin: TfLogin;

implementation

{$R *.lfm}

{ TfLogin }

procedure TfLogin.btnLoginClick(Sender: TObject);
var senha: String;
  snh: String;
begin
  if (edLogin.Text = '') then
  begin
    ShowMessage('Informe o nome do usuario');
    Exit;
  end;
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT CODUSUARIO, NOMEUSUARIO, SENHA, CODBARRA  ' +
      ' FROM USUARIO WHERE NOMEUSUARIO = ' + QuotedStr(edLogin.Text);
  dmPdv.sqBusca.Open;
  if (dmPdv.sqBusca.IsEmpty) then
  begin
    ShowMessage('Sem Cadastro de usuário no sistema');
    Exit;
  end;
  senha := dmPdv.sqBusca.FieldByName('SENHA').AsString;
  snh := EncodeStringBase64(edSenha.Text);
  if (snh = senha) then
  begin
    dmPdv.varLogado := IntToStr(dmPdv.sqBusca.Fields.FieldByName('CODUSUARIO').AsInteger);
    dmPdv.nomeLogado := dmPdv.sqBusca.Fields.FieldByName('NOMEUSUARIO').AsString;
    dmPdv.sqBusca.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqBusca.SQL.Text := 'SELECT IDCAIXACONTROLE, CODCAIXA, CODUSUARIO,' +
       'SITUACAO, NOMECAIXA ' +
       ' FROM CAIXA_CONTROLE WHERE SITUACAO = ' + QuotedStr('o') +
       ' AND CODUSUARIO = ' + dmPdv.varLogado;
    dmPdv.sqBusca.Open;
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('Sem Caixa Aberto para este usuário');
      Exit;
    end
    else begin
      // Sessao_id
      dmPdv.nomeCaixa := dmPdv.sqBusca.Fields.FieldByName('NOMECAIXA').AsString;
      dmPdv.ccusto := IntToStr(dmPdv.sqBusca.Fields.FieldByName('CODCAIXA').AsInteger);
    end;
    fPdv.ShowModal;
    Close;
  end
  else begin
    ShowMessage('Senha/Usuário Inválido.');
  end;
end;

procedure TfLogin.BitBtn1Click(Sender: TObject);
begin
end;

procedure TfLogin.btnInfoClick(Sender: TObject);
begin
  if pnInfo.Visible = True then
    pnInfo.Visible:=False
  else
    pnInfo.Visible:=True;
end;

procedure TfLogin.edLoginKeyPress(Sender: TObject; var Key: char);
begin
  if (key = #13) then
  begin
    SelectNext(Sender as TWinControl, True, True);
    Key := #0;
  end;
end;

procedure TfLogin.edSenhaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnLogin.Click;
  end;
end;

procedure TfLogin.FormShow(Sender: TObject);
begin
  {
end;

var
  AProcess: TProcess;
  ASlist: TStringList;
  script: String;
  i: integer;
begin
  //if dmPdv.path_python = '' then
  //begin
  //  ShowMessage('informe no conf.ini :  [PATH] Python=C:\....\python.exe .');
  //  Exit;
  //end;
  AProcess := TProcess.Create(nil);
  ASList := TStringList.Create;
  try
    //AProcess.Executable := 'C:\Users\ats\AppData\Local\Programs\Python\Python37-32\python.exe';
    AProcess.Executable := dmPdv.path_exe +  'atsProduto.exe';
    AProcess.Options := AProcess.Options + [poWaitOnExit, poUsePipes];
    //script:= dmPdv.path_exe +  'atsProduto.py';
    //AProcess.Parameters.Add(script);
    AProcess.Execute;
    ASlist.LoadFromStream(AProcess.Output);
    Memo1.Lines.Clear;
    for i := 0 to ASlist.Count - 1 do
      Memo1.Lines.Add(ASlist[i]);
    Memo1.Lines.Add('');
    Memo1.Lines.Add('.... Atualizado Produtos.');

    script:= dmPdv.path_exe +  'atsCliente.py';
    AProcess.Parameters.Add(script);
    AProcess.Execute;
    ASlist.LoadFromStream(AProcess.Output);
    for i := 0 to ASlist.Count - 1 do
       Memo1.Lines.Add(ASlist[i]);
    Memo1.Lines.Add('');
    Memo1.Lines.Add('.... Atualizado Clientes.');

    script:= dmPdv.path_exe +  'atsCaixa.py';
    AProcess.Parameters.Add(script);
    AProcess.Execute;
    ASlist.LoadFromStream(AProcess.Output);
    for i := 0 to ASlist.Count - 1 do
       Memo1.Lines.Add(ASlist[i]);
    Memo1.Lines.Add('');
    Memo1.Lines.Add('.... Atualizado Caixas.');

    ASlist.SaveToFile('saida.txt');
    //ShowMessage('fez');
    dmPdv.IbCon.Connected:=False;
    dmPdv.IbCon.Connected:=True;
    dmPdv.sqBusca.SQL.Text := 'SELECT IDCAIXACONTROLE, CODCAIXA, CODUSUARIO,' +
       'SITUACAO, NOMECAIXA ' +
       ' FROM CAIXA_CONTROLE WHERE SITUACAO = ' + QuotedStr('o') +
       ' AND CODUSUARIO = ' + dmPdv.varLogado;
    dmPdv.sqBusca.Open;
    while not dmPdv.sqBusca.EOF do
    begin
      Memo1.Lines.Add('');
      Memo1.Lines.Add('Caixas Disponiveis:');
      Memo1.Lines.Add(dmPdv.sqBusca.Fields.FieldByName('NOMECAIXA').AsString);
      dmPdv.sqBusca.Next;
    end;
  finally
    AProcess.Free;
    ASlist.Free;
  end;}
end;

procedure TfLogin.Label1Click(Sender: TObject);
begin
  if (edLogin.Text = '') then
  begin
    ShowMessage('Informe o nome do usuario');
    Exit;
  end;
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT CODUSUARIO, NOMEUSUARIO, SENHA ' +
      ' FROM USUARIO WHERE NOMEUSUARIO = ' + QuotedStr(edLogin.Text);
  dmPdv.sqBusca.Open;
  if (dmPdv.sqBusca.IsEmpty) then
  begin
    ShowMessage('Sem Cadastro de usuário no sistema');
    Exit;
  end;
  fSenhaNova.nomeUsuario:= edLogin.Text;
  fSenhaNova.ShowModal;
end;

end.

