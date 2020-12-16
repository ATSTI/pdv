unit uBuscaOrc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids, DBCtrls, udm, uRel;

type

  { TfBuscaOrc }

  TfBuscaOrc = class(TForm)
    BitBtn24: TBitBtn;
    btnDuplicar: TBitBtn;
    btnExcluir: TBitBtn;
    btnGravar: TBitBtn;
    btnProcurar: TBitBtn;
    btnSair1: TBitBtn;
    DBGrid1: TDBGrid;
    dsSqlOrc: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn24Click(Sender: TObject);
    procedure btnDuplicarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);

    procedure btnProcurarClick(Sender: TObject);
    procedure btnSair1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

  public
    vVal : String;
  end;

var
  fBuscaOrc: TfBuscaOrc;

implementation

uses uOrcamento;

{$R *.lfm}

{ TfBuscaOrc }

procedure TfBuscaOrc.btnProcurarClick(Sender: TObject);
var sql: String;
begin
  dm.sqlOrc.Close;

  if(edit1.Text <> '') then
  begin
    vVal := edit1.Text;
    sql   := ' SELECT distinct CODPROD , PRODUTO  FROM ORCAMENTO_VBS WHERE CODPROD = '
             + QuotedStr(edit1.Text)
             + 'order by CODPROD desc ';
    dm.sqlOrc.SQL.Text := (sql);
    dm.sqlOrc.Open;
  end else
  begin
    sql   := ' SELECT distinct CODPROD , PRODUTO  FROM ORCAMENTO_VBS order by CODPROD desc ';
    dm.sqlOrc.SQL.Text := (sql);
    dm.sqlOrc.Open;
  end;
end;

procedure TfBuscaOrc.btnSair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfBuscaOrc.DBGrid1DblClick(Sender: TObject);
begin
  Edit1.Text := dm.sqlOrcCODPROD.AsString ;
end;

procedure TfBuscaOrc.FormCreate(Sender: TObject);
begin

end;


procedure TfBuscaOrc.btnExcluirClick(Sender: TObject);
var excluir_orc:string;
begin
  if(edit1.Text <> '') then
  begin
    if MessageDlg('Confirma:', 'Excluir Este Orçamento Nº : ' +
      edit1.Text  + '  ? ' , mtConfirmation,
      [mbYes, mbNo],0) = mrYes then
    begin

      excluir_orc := 'delete from ORCAMENTO_VBS where codprod = ' + (edit1.Text);

      dm.executaSql(excluir_orc);
      dm.sTrans.Commit;

      ShowMessage('Orçamento Excluido.');

    end;
  end;
end;

procedure TfBuscaOrc.BitBtn24Click(Sender: TObject);
begin
  fRel.RLReport1.Preview();

  //fRel.ShowModal;
end;

procedure TfBuscaOrc.btnDuplicarClick(Sender: TObject);
begin

  fOrcamento.ShowModal;
end;

end.

