unit uOrcamento;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, SQLDB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids, DBCtrls, Buttons, DateTimePicker;

type

  { TfOrcamento }

  TfOrcamento = class(TForm)
    btnIncCte: TBitBtn;
    btnSair1: TBitBtn;
    DataSource1: TDataSource;
    dataORC: TDateTimePicker;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    dsOrcDados: TDataSource;
    dbData: TDBEdit;

    DBGrid1: TDBGrid;
    edTNome: TEdit;
    edtNOrc: TEdit;
    edtNomeCliente: TEdit;
    edtQTDE: TEdit;
    edtValUn: TEdit;
    edtValT: TEdit;
    edtProduto: TEdit;
    Label1: TLabel;
    sqlOrcDados: TSQLQuery;
    sqlOrcDadosDATACADASTRO: TDateField;
    sqlOrcDadosDESCRICAO_A: TStringField;
    sqlOrcDadosDESCRICAO_B: TStringField;
    sqlOrcDadosDESCRICAO_C: TStringField;
    sqlOrcDadosDESCRICAO_D: TStringField;
    sqlOrcDadosDESCRICAO_E: TStringField;
    sqlOrcDadosID: TLongintField;
    sqlOrcDadosID_ORCAMENTO: TLongintField;
    sqlOrcDadosNOMECLIENTE: TStringField;
    sqlOrcDadosVALOR_A: TFloatField;
    sqlOrcDadosVALOR_B: TFloatField;
    sqlOrcDadosVALOR_C: TFloatField;
    sqlOrcDadosVALOR_D: TFloatField;
    sqlOrcDadosVALOR_E: TFloatField;
    sqlOrcDadosVALOR_PORC_A: TFloatField;
    sqlOrcDadosVALOR_PORC_B: TFloatField;
    sqlOrcDadosVALOR_PORC_C: TFloatField;
    sqlOrcDadosVALOR_PORC_D: TFloatField;
    sqlOrcDadosVALOR_PORC_E: TFloatField;
    sqlOrcDadosVALOR_TOTAL_A: TFloatField;
    sqlOrcDadosVALOR_TOTAL_B: TFloatField;
    sqlOrcDadosVALOR_TOTAL_C: TFloatField;
    sqlOrcDadosVALOR_TOTAL_D: TFloatField;
    sqlOrcDadosVALOR_TOTAL_E: TFloatField;
    sqlOrcDadosVALOR_TOTAL_GERAL: TFloatField;
    procedure btnIncCteClick(Sender: TObject);
    procedure btnSair1Click(Sender: TObject);
    procedure DBEdit6Exit(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure CarrregarEdits;
  private

  public
  function strParaFloat(vlr_st: String): Double;
  end;

var
  fOrcamento: TfOrcamento;

implementation

uses udm;

{$R *.lfm}

{ TfOrcamento }

procedure TfOrcamento.FormShow(Sender: TObject);
var sql, sqld: String;
begin
  dm.sqlOrcamento.Close;
  sql   := ' SELECT  *  FROM ORCAMENTO_VBS WHERE CODPROD = '
           + QuotedStr(dm.sqlOrcCODPROD.AsString);
  dm.sqlOrcamento.SQL.Text := (sql);
  dm.sqlOrcamento.Open;

  sqlOrcDados.Close;
  sqld   := ' SELECT  *  FROM ORCAMENTOS_DADOS WHERE ID_ORCAMENTO = '
           + QuotedStr(dm.sqlOrcCODPROD.AsString);
  sqlOrcDados.SQL.Text := (sqld);
  sqlOrcDados.Open;


  CarrregarEdits;


end;

procedure TfOrcamento.CarrregarEdits;
begin
  edtNOrc.Text    := dm.sqlOrcamentoCODPROD.AsString;
  edTNome.Text    := dm.sqlOrcamentoPRODUTO.AsString ;
  edtQTDE.Text    := dm.sqlOrcamentoQTDE.AsString;
  edtValUn.Text   := dm.sqlOrcamentoCUSTOUNIT.AsString;
  edtValT.Text    := dm.sqlOrcamentoCUSTOTOT.AsString;
  edtProduto.Text := dm.sqlOrcamentoMATPRIMA.AsString;
end;

function TfOrcamento.strParaFloat(vlr_st: String): Double;
var tam: Integer;
  vVlrStr: String;
  vVlr_decimais: String;
begin
  if (Length(vlr_st) > 6) then
  begin
    vVlr_decimais := Copy(vlr_st,pos(',',vlr_st)+1,Length(vlr_st));
    Vlr_st := Copy(vlr_st,0,pos(',',vlr_st)-1);
    if (Length(vlr_st) > 3) then
    begin
      vVlrStr := StringReplace(vlr_st, '.', '', [rfReplaceAll]);
      vlr_st := vVlrStr + ',' + vVlr_decimais;
    end
    else begin
      vlr_st := vlr_st + ',' + vVlr_decimais;
    end;
  end;
  result := StrToFloat(vlr_st);

end;

procedure TfOrcamento.btnIncCteClick(Sender: TObject);
var sql_up ,  sql, sqld , pORC : String;
 // pA : Double;
begin
  pORC := edtNOrc.Text;
  sql_up := 'UPDATE ORCAMENTOS_DADOS SET DATACADASTRO = ';
          if(dbData.Text = '' )then
            sql_up := sql_up + QuotedStr(formatdatetime('mm/dd/yyyy',dataORC.Date))
          else
          sql_up := sql_up +  QuotedStr(formatdatetime('mm/dd/yyyy', StrToDate(dbData.Text)));
          sql_up := sql_up + ', NOMECLIENTE = ';
          sql_up := sql_up + QuotedStr(edtNomeCliente.Text) + ', ';

          DecimalSeparator := '.';
          sql_up := sql_up + 'VALOR_A = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_A.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_B = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_B.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_C = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_C.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_D = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_D.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_E = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_E.AsFloat)+ ', ';

          sql_up := sql_up + 'VALOR_PORC_A = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_PORC_A.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_PORC_B = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_PORC_B.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_PORC_C = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_PORC_C.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_PORC_D = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_PORC_D.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_PORC_E = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_PORC_E.AsFloat)+ ', ';

          sql_up := sql_up + 'VALOR_TOTAL_A = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_TOTAL_A.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_TOTAL_B = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_TOTAL_B.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_TOTAL_C = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_TOTAL_C.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_TOTAL_D = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_TOTAL_D.AsFloat)+ ', ';
          sql_up := sql_up + 'VALOR_TOTAL_E = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_TOTAL_E.AsFloat)+ ', ';

          sql_up := sql_up + 'VALOR_TOTAL_GERAL  = ';
          sql_up := sql_up + FloatToStr(sqlOrcDadosVALOR_TOTAL_GERAL.AsFloat)+ ', ';

          DecimalSeparator := ',';

          sql_up := sql_up + 'DESCRICAO_A = ';
          sql_up := sql_up + QuotedStr(sqlOrcDadosDESCRICAO_A.AsString) + ', ';
          sql_up := sql_up + 'DESCRICAO_B = ';
          sql_up := sql_up + QuotedStr(sqlOrcDadosDESCRICAO_B.AsString) + ', ';
          sql_up := sql_up + 'DESCRICAO_C = ';
          sql_up := sql_up + QuotedStr(sqlOrcDadosDESCRICAO_C.AsString) + ', ';
          sql_up := sql_up + 'DESCRICAO_D = ';
          sql_up := sql_up + QuotedStr(sqlOrcDadosDESCRICAO_D.AsString) + ', ';
          sql_up := sql_up + 'DESCRICAO_E = ';
          sql_up := sql_up + QuotedStr(sqlOrcDadosDESCRICAO_E.AsString);

          sql_up := sql_up + ' where ID_ORCAMENTO = ';
          sql_up := sql_up + QuotedStr(pORC);


  dm.executaSql(sql_up);
  dm.sTrans.Commit;



  dm.sqlOrcamento.Close;
  sql   := ' SELECT  *  FROM ORCAMENTO_VBS WHERE CODPROD = '
           + QuotedStr(pORC);
  dm.sqlOrcamento.SQL.Text := (sql);
  dm.sqlOrcamento.Open;

  sqlOrcDados.Close;
  sqld   := ' SELECT  *  FROM ORCAMENTOS_DADOS WHERE ID_ORCAMENTO = '
           + QuotedStr(pORC);
  sqlOrcDados.SQL.Text := (sqld);
  sqlOrcDados.Open;

  CarrregarEdits;


end;

procedure TfOrcamento.btnSair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfOrcamento.DBEdit6Exit(Sender: TObject);
begin
  sqlOrcDadosVALOR_TOTAL_A.AsFloat := (sqlOrcDadosVALOR_A.AsFloat * sqlOrcDadosVALOR_PORC_A.AsFloat/100);
end;

procedure TfOrcamento.DBGrid1CellClick(Column: TColumn);
begin
  CarrregarEdits;
end;

procedure TfOrcamento.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CarrregarEdits;
end;

procedure TfOrcamento.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CarrregarEdits;
end;

end.

