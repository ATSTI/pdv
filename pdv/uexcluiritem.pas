unit uExcluirItem;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, uMovimento, udmpdv;

type

  { TfExclusao }

  TfExclusao = class(TForm)
    btnExcluiItem: TBitBtn;
    btnExcluirPedido: TBitBtn;
    edItemExcluir: TLabeledEdit;
    lblItem: TLabel;
    edPedidoExcluir: TLabeledEdit;
    procedure btnExcluiItemClick(Sender: TObject);
    procedure btnExcluirPedidoClick(Sender: TObject);
    procedure edItemExcluirExit(Sender: TObject);
    procedure edItemExcluirKeyPress(Sender: TObject; var Key: char);
    procedure edPedidoExcluirKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private

  public
    excCodMov :Integer;
    excCodUser: Integer;
    excUser: String;
  end;

var
  fExclusao: TfExclusao;

implementation

{$R *.lfm}

{ TfExclusao }

procedure TfExclusao.btnExcluiItemClick(Sender: TObject);
var dsqlAltera: String;
begin
  if MessageDlg('Confirma:', 'Confirma a exclusão do item: ' +
    lblItem.Caption , mtConfirmation,
    [mbYes, mbNo, mbIgnore],0) = mrYes then
  begin
    dmPdv.sqBusca.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqBusca.SQL.Text := 'SELECT md.CODDETALHE, md.STATUS ' +
       ' FROM MOVIMENTO m, MOVIMENTODETALHE md ' +
       ' WHERE m.CODMOVIMENTO = md.CODMOVIMENTO ' +
       '   AND m.CODMOVIMENTO  = ' + IntToStr(excCodMov) +
       '   AND md.BAIXA IS NULL ' +
       '   AND md.NITEMPED = ' + edItemExcluir.Text +
       '   AND m.STATUS = 0';
    dmPdv.sqBusca.Open;
    if (not dmPdv.sqBusca.IsEmpty) then
    begin
      dsqlAltera := 'UPDATE MOVIMENTODETALHE SET ';
      dsqlAltera := dsqlAltera + ' STATUS        = ' + QuotedStr('2');
      dsqlAltera := dsqlAltera + ', OBS = ' +
        QuotedStr('Usuario: ' + IntToStr(excCodUser) + '-' + excUser +
        ' Data : ' + DateToStr(Now));
      dsqlAltera := dsqlAltera + ' WHERE CODDETALHE = ' + IntToStr(
        dmPdv.sqBusca.FieldByName('CODDETALHE').AsInteger);
      dmPdv.IbCon.ExecuteDirect(dsqlAltera);
      dmPdv.sTrans.Commit;
    end
    else
    begin
      ShowMessage('Pedido ja finalizado, nao e possível excluir item.');
    end;
  end;
end;

procedure TfExclusao.btnExcluirPedidoClick(Sender: TObject);
var
  psqlAltera: String;
begin
  if MessageDlg('Confirma:', 'Confirma a exclusão do Pedido: ' +
    edPedidoExcluir.Text , mtConfirmation,
   [mbYes, mbNo, mbIgnore],0) = mrYes then
  begin
    dmPdv.sqBusca.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqBusca.SQL.Text := 'SELECT CODMOVIMENTO, STATUS ' +
        ' FROM MOVIMENTO WHERE CODMOVIMENTO  = ' + IntToStr(excCodMov) +
        ' AND STATUS = 0';
    dmPdv.sqBusca.Open;
    if (not dmPdv.sqBusca.IsEmpty) then
    begin
      psqlAltera := 'UPDATE MOVIMENTO SET ';
      psqlAltera := psqlAltera + ' STATUS        = 2';
      psqlAltera := psqlAltera + ',OBS = ' +
        QuotedStr('Usuario: ' + IntToStr(excCodUser) + '-' + excUser +
        ' Data : ' + DateToStr(Now));
      psqlAltera := psqlAltera + ' WHERE CODMOVIMENTO = ' + IntToStr(excCodMov);
      dmPdv.IbCon.ExecuteDirect(psqlAltera);
      dmPdv.sTrans.Commit;
    end
    else
    begin
      ShowMessage('Pedido ja finalizado, nao e possível excluir item.');
    end;
  end;
end;

procedure TfExclusao.edItemExcluirExit(Sender: TObject);
begin
end;

procedure TfExclusao.edItemExcluirKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dmPdv.sqBusca.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqBusca.SQL.Text := 'SELECT md.CODDETALHE, md.STATUS, md.DESCPRODUTO ' +
       ' FROM MOVIMENTO m, MOVIMENTODETALHE md ' +
       ' WHERE m.CODMOVIMENTO = md.CODMOVIMENTO ' +
       '   AND m.CODMOVIMENTO  = ' + IntToStr(excCodMov) +
       '   AND md.BAIXA IS NULL ' +
       '   AND md.NITEMPED = ' + edItemExcluir.Text +
       '   AND m.STATUS = 0';
    dmPdv.sqBusca.Open;
    if not dmPdv.sqBusca.IsEmpty then
    begin
      lblItem.Caption := dmPdv.sqBusca.FieldByName('DESCPRODUTO').AsString;
    end;
  end;
end;

procedure TfExclusao.edPedidoExcluirKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
  end;

end;

procedure TfExclusao.FormShow(Sender: TObject);
begin
  edItemExcluir.Text:='';
  edPedidoExcluir.Text:='';
end;

end.

