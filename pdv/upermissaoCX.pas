unit uPermissaoCX;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, udmpdv, uExcluirItem;

type

  { TfPermissaoCX }

  TfPermissaoCX = class(TForm)
    btnLogin: TBitBtn;
    edSenha: TLabeledEdit;
    procedure btnLoginClick(Sender: TObject);
    procedure edSenhaKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    permissao_inicio: String;
  public
    Permissao_Fazer: String;
    permCodMov : Integer;
    permCodDet : Integer;
    itemExcP: String;
    itemExcC: String;
  end;

var
  fPermissaoCX: TfPermissaoCX;

implementation
uses uPdv ;

{$R *.lfm}

{ TfPermissaoCX }

procedure TfPermissaoCX.btnLoginClick(Sender: TObject);
begin
  dmPdv.busca_sql('SELECT CODUSUARIO, NOMEUSUARIO, PERFIL ' +
      ' FROM USUARIO WHERE CODBARRA = ' + QuotedStr(edSenha.Text));
  if (dmPdv.sqBusca.IsEmpty) then
  begin
    Permissao_Fazer := 'NAO';
    ShowMessage('Sem Cadastro de usuário no sistema');
    Exit;
  end;

  if ((Trim(dmPdv.sqBusca.FieldByName('PERFIL').AsString) <> 'GERENTE') and
     (permissao_inicio <> 'EXCLUIR')) then
  begin
    Permissao_Fazer := 'NAO';
    ShowMessage('Usuário sem permissão.');
    Close;
  end;
  if ((Trim(dmPdv.sqBusca.FieldByName('PERFIL').AsString) = 'GERENTE') and
     (permissao_inicio <> 'EXCLUIR')) then
  begin
    Permissao_Fazer := 'SIM';
    Close;
  end;


end;

procedure TfPermissaoCX.edSenhaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnLogin.Click;
  end;
end;

procedure TfPermissaoCX.FormShow(Sender: TObject);
begin
  edSenha.Text := '';
  permissao_inicio := Permissao_Fazer;
  Permissao_Fazer := 'NAO';
end;

end.

