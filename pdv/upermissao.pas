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
    procedure FormShow(Sender: TObject);
  private
    permissao_inicio: String;
  public
    Permissao_Fazer: String;
    permCodMov : Integer;
    permCodDet : Integer;
    itemExcP: String;
    itemExcC: String;
    nPode: String;
  end;

var
  fPermissao: TfPermissao;

implementation
uses uPdv ;

{$R *.lfm}

{ TfPermissao }

procedure TfPermissao.btnLoginClick(Sender: TObject);
begin
  dmPdv.busca_sql('SELECT CODUSUARIO, NOMEUSUARIO, PERFIL ' +
      ' FROM USUARIO WHERE CODBARRA = ' + QuotedStr(edSenha.Text));
  if (dmPdv.sqBusca.IsEmpty) then
  begin
    Permissao_Fazer := 'NAO';
    ShowMessage('Sem Cadastro de usuário no sistema');
    nPode := 'NAO';
    Close;
    Exit;
  end;

  if ((Trim(dmPdv.sqBusca.FieldByName('PERFIL').AsString) = 'GERENTE') and
     (permissao_inicio = 'EXCLUIR')) then
  begin
    edSenha.Text:='';
    fExclusao.excCodDet := permCodDet;
    fExclusao.excCodUser := dmPdv.sqBusca.FieldByName('CODUSUARIO').AsInteger;
    fExclusao.excUser := Trim(dmPdv.sqBusca.FieldByName('NOMEUSUARIO').AsString);
    fExclusao.excCodMov  :=permCodMov;
    fExclusao.ItemExc := itemExcP;
    fExclusao.ItemExcC:= itemExcC;
    fExclusao.ShowModal;
    Close;
  end;
  if ((Trim(dmPdv.sqBusca.FieldByName('PERFIL').AsString) <> 'GERENTE') and
     (permissao_inicio <> 'EXCLUIR')) then
  begin
    Permissao_Fazer := 'NAO';
    ShowMessage('Usuário sem permissão.');
    nPode := 'NAO';
    Close;
  end;
  if ((Trim(dmPdv.sqBusca.FieldByName('PERFIL').AsString) = 'GERENTE') and
     (permissao_inicio <> 'EXCLUIR')) then
  begin
    Permissao_Fazer := 'SIM';
    nPode := 'SIM';
    Close;
  end;

  dmPdv.sqLancZero.Close;
  dmPdv.sqLancZero.Params[0].AsInteger:= fPdv.CodMov;
  dmPdv.sqLancZero.Open;
  fPdv.pSemValor := dmPdv.sqLancZeroCODMOVIMENTO.AsInteger;

  if(fPdv.pSemValor > 0 )then
    fPdv.Label8.Caption:= 'LINHAS EM VERMELHO  PRODUTOS PREÇO  0,00'
  else
     fPdv.Label8.Caption:= '...' ;

end;

procedure TfPermissao.edSenhaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnLogin.Click;
  end;
end;

procedure TfPermissao.FormShow(Sender: TObject);
begin
  edSenha.Text := '';
  permissao_inicio := Permissao_Fazer;
  Permissao_Fazer := 'NAO';
end;

end.

