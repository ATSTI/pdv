unit uSenhaNova;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, MaskEdit, udmpdv, base64;

type

  { TfSenhaNova }

  TfSenhaNova = class(TForm)
    btnFechar: TBitBtn;
    btnConfirma: TBitBtn;
    edSenhaNova: TLabeledEdit;
    edSenhaConfirma: TLabeledEdit;
    edSenhaAtual: TLabeledEdit;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edSenhaConfirmaKeyPress(Sender: TObject; var Key: char);
  private

  public
    nomeUsuario: String;
  end;

var
  fSenhaNova: TfSenhaNova;

implementation

{$R *.lfm}

{ TfSenhaNova }

procedure TfSenhaNova.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfSenhaNova.edSenhaConfirmaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnConfirma.Click;
  end;
end;

procedure TfSenhaNova.btnConfirmaClick(Sender: TObject);
var senha: String;
  snh: String;
begin
  if (edSenhaNova.Text <> edSenhaConfirma.Text) then
  begin
    ShowMessage('Senha nova e Confirma , não são iguais');
    Exit;
  end;

  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT CODUSUARIO, NOMEUSUARIO, PERFIL ' +
    ' FROM USUARIO WHERE NOMEUSUARIO = ' + QuotedStr(nomeUsuario);
  dmPdv.sqBusca.Open;
  if (dmPdv.sqBusca.IsEmpty) then
  begin
    ShowMessage('Sem Cadastro de usuário no sistema');
    Exit;
  end;

  senha := dmPdv.sqBusca.Fields.FieldByName('PERFIL').AsString;
  snh := EncodeStringBase64(edSenhaAtual.Text);
  if ((snh = senha) or (senha = 'CAIXA')) then
  begin
    dmPdv.varLogado := IntToStr(dmPdv.sqBusca.Fields.FieldByName('CODUSUARIO').AsInteger);
    snh := EncodeStringBase64(edSenhaNova.Text);
    dmPdv.IbCon.ExecuteDirect('UPDATE USUARIO SET PERFIL = ' +
      QuotedStr(snh) + ' WHERE CODUSUARIO = ' + dmPdv.varLogado);
    dmPdv.sTrans.Commit;
  end
  else begin
     ShowMessage('Senha/Usuário Inválido.');
  end;
end;

end.

