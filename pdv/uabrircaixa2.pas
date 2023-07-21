unit uAbrirCaixa2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  MaskEdit, StdCtrls, udmpdv, DateTimePicker, db, IniFiles;

type

  { TfAbreCaixa }

  TfAbreCaixa = class(TForm)
    btnAbrefecha: TBitBtn;
    btnSair: TBitBtn;
    dtData: TDateTimePicker;
    edValor: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblCaixa: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAbrefechaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fAbreCaixa: TfAbreCaixa;

implementation

{$R *.lfm}

{ TfAbreCaixa }

procedure TfAbreCaixa.btnAbrefechaClick(Sender: TObject);
var str:string;
  codCaixa:integer;
  vlrCaixa:double;
  ArquivoINI: TIniFile;
begin
  try
  codCaixa := dmPdv.busca_generator('GEN_CAIXA');
  str := 'insert into CAIXA_CONTROLE (IDCAIXACONTROLE, CODCAIXA, CODUSUARIO,' +
    'SITUACAO, NOMECAIXA, MAQUINA, DATAABERTURA, VALORABRE, DATAFECHAMENTO) values (';
  str := str + IntToStr(codCaixa);
  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    str := str + ', ' + IntToStr(codCaixa);
    ArquivoINI := TIniFile.Create('pdv_caixa.ini');
    ArquivoINI.WriteString('PDV', 'caixa', IntToStr(codCaixa));
    ArquivoINI.Free;
  end
  else
    str := str + ', ' + dmpdv.ccusto_padrao;
  str := str + ', ' + dmpdv.varLogado;
  str := str + ', ' + QuotedStr('o');
  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    str := str + ', ' + QuotedStr(dmpdv.nomeLogado + '/' +  IntToStr(codCaixa));
    dmPdv.nomeCaixa := dmpdv.nomeLogado + '/' +  IntToStr(codCaixa);
  end
  else
    str := str + ', ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtData.Date));
  str := str + ', ' + QuotedStr(dmpdv.MICRO);
  str := str + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtData.Date));
  vlrCaixa := StrToFloat(edValor.Text);
  DecimalSeparator:='.';
  str := str + ', ' + FloatToStr(vlrCaixa);
  DecimalSeparator:=',';
  str := str + ',' + QuotedStr('01.01.11') + ')';
  dmPdv.IbCon.ExecuteDirect(str);
  dmPdv.sTrans.Commit;
  dmPdv.idcaixa := IntToStr(codCaixa);
  dmPdv.ccusto := IntToStr(codCaixa);

  ShowMessage('Caixa aberto com sucesso!');
        Except
        on dmPdv: EDatabaseError do
        begin
          MessageDlg('Error','Erro para abrir o caixa : ' +
            dmPdv.Message,mtError,[mbOK],0);
          //strans.Rollback;
        end;
      end;
end;

procedure TfAbreCaixa.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfAbreCaixa.FormShow(Sender: TObject);
begin
  dtData.Date:=Now;
  dmPdv.busca_sql('SELECT NOMECAIXA FROM CAIXA_CONTROLE ' +
    ' WHERE CODCAIXA = ' + dmpdv.ccusto_padrao +
    '   AND CODUSUARIO = ' + dmpdv.varLogado +
    '   AND SITUACAO = ' + QuotedStr('o'));
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    btnAbrefecha.Enabled := False;
    lblCaixa.Caption:= dmPdv.sqBusca.FieldByName('NOMECAIXA').AsString;
  end;
end;

end.

