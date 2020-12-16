unit uLancados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, DBGrids;

type

  { TfLancados }

  TfLancados = class(TForm)
    btnBuscaOrc: TBitBtn;
    btnGravar: TBitBtn;
    btnSair1: TBitBtn;
    dsLancados: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnBuscaOrcClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnSair1Click(Sender: TObject);
  private

  public

  end;

var
  fLancados: TfLancados;

implementation

uses  udm;

{$R *.lfm}

{ TfLancados }



procedure TfLancados.btnBuscaOrcClick(Sender: TObject);
var sql: String;
begin

  sql   := ' SELECT distinct( codprod ), codprodpro ,  produto FROM MATERIAPRIMA_CUSTO order by codprod desc ' ;
  dm.sqBuscaOrc.SQL.Text := (sql);
  dm.sqBuscaOrc.Open;

end;

procedure TfLancados.btnGravarClick(Sender: TObject);
var incluir_orc , sql , incl , pCod :string;
begin

  dm.sqlOrc.Close;

  sql   := ' SELECT * FROM ORCAMENTO_VBS WHERE CODPROD = ' + dm.sqBuscaOrcCODPROD.AsString;
  dm.sqlOrc.SQL.Text := (sql);
  dm.sqlOrc.Open;
  if (dm.sqlOrc.IsEmpty) then
  begin

    if MessageDlg('Confirma:', 'Confirma Gerar Orçamento N º : ' +
      dm.sqBuscaOrcCODPROD.AsString + ' ?' , mtConfirmation,
      [mbYes, mbNo],0) = mrYes then
    begin

      incluir_orc := 'insert into ORCAMENTO_VBS (id,codorc, codprod ,codprodpro ,codprodmat , qtde ,'+
                    'custounit ,custotot ,produto , matprima )'+
      ' select GEN_ID("GEN_ORC_VBS",1), codmat, codprod ,codprodpro ,codprodmat , qtde ,'+
               ' custounit ,custotot ,produto , matprima '+
               ' from MATERIAPRIMA_CUSTO where codprod = ' + (dm.sqBuscaOrcCODPROD.AsString);

      pCod := dm.sqBuscaOrcCODPROD.AsString;
      dm.executaSql(incluir_orc);
      dm.sTrans.Commit;


       incl := 'INSERT INTO ORCAMENTOS_DADOS (ID,ID_ORCAMENTO)' +
                     'VALUES ( ';
       incl := incl + 'GEN_ID("GEN_ORCD_VBS",1)' + ',';
       incl := incl + QuotedStr(pCod) + ')';
       dm.executaSql(incl);
       dm.sTrans.Commit;


      ShowMessage('Orçamento Inlcuido com Sucesso');

    end;

  end else
  ShowMessage('Orçamento Já Inlcuido');

end;

procedure TfLancados.btnSair1Click(Sender: TObject);
begin
  Close;
end;

end.

