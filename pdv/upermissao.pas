unit uPermissao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, udmpdv, uExcluirItem;

type

  { TfPermissao }

  TfPermissao = class(TForm)
    btnLogin: TBitBtn;
    edSenha: TLabeledEdit;
    procedure btnLoginClick(Sender: TObject);
    procedure edSenhaKeyPress(Sender: TObject; var Key: char);
  private

  public
    permCodMov : Integer;
    permCodDet : Integer;
  end;

var
  fPermissao: TfPermissao;

implementation

{$R *.lfm}

{ TfPermissao }

procedure TfPermissao.btnLoginClick(Sender: TObject);
begin
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT CODUSUARIO, NOMEUSUARIO, PERFIL ' +
      ' FROM USUARIO WHERE CODBARRA = ' + QuotedStr(edSenha.Text);
  dmPdv.sqBusca.Open;
  if (dmPdv.sqBusca.IsEmpty) then
  begin
    ShowMessage('Sem Cadastro de usuário no sistema');
    Exit;
  end;
  if (dmPdv.sqBusca.FieldByName('PERFIL').AsString = 'GERENTE') then
  begin
    edSenha.Text:='';
    fExclusao.excCodDet := permCodDet;
    fExclusao.excCodUser := dmPdv.sqBusca.FieldByName('CODUSUARIO').AsInteger;
    fExclusao.excUser := dmPdv.sqBusca.FieldByName('NOMEUSUARIO').AsString;
    fExclusao.excCodMov  :=permCodMov;
    fExclusao.ShowModal;
    Close;
  end
  else begin
    ShowMessage('Usuário não tem permissão.');
  end;
end;

procedure TfPermissao.edSenhaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnLogin.Click;
  end;
end;

end.

