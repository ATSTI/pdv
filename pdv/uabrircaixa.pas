unit uabrircaixa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, MaskEdit, Buttons, ExtCtrls, udmpdv;

type

  { TfAbrirCaixa }

  TfAbrirCaixa = class(TForm)
    BitBtn24: TBitBtn;
    btnSair: TBitBtn;
    btnAbrefecha: TBitBtn;
    dtData: TDateTimePicker;
    Label1: TLabel;
    edValor: TMaskEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edCcred: TMaskEdit;
    edCdeb: TMaskEdit;
    edCheque: TMaskEdit;
    edFaturado: TMaskEdit;
    edSangrias: TMaskEdit;
    edDinheiro: TMaskEdit;
    edTCaixa: TMaskEdit;
    edTBruto: TMaskEdit;
    edTLiquido: TMaskEdit;
    Panel1: TPanel;
    procedure BitBtn24Click(Sender: TObject);
    procedure btnAbrefechaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dtDataChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mostrarCaixa(usuarioCX: String);
  private
    procedure AbrirCaixa();
    procedure FecharCaixa();


  public
    AbrirFechar:string;

  end;

var
  fAbrirCaixa: TfAbrirCaixa;

implementation

{$R *.lfm}

{ TfAbrirCaixa }

procedure TfAbrirCaixa.btnAbrefechaClick(Sender: TObject);
begin
  if (AbrirFechar = 'Abrir') then
  begin
    AbrirCaixa();
  end
  else begin
    FecharCaixa();
  end;
end;

procedure TfAbrirCaixa.BitBtn24Click(Sender: TObject);
var
  IMPRESSORA:TextFile;
begin
  // leio um arquivo txt e imprimo
  //lFile := TStringList.Create;
  if (dmPdv.CupomImp = 'Texto') then
  begin
    AssignFile(IMPRESSORA, dmPdv.portaIMP);
  end
  else begin
    AssignFile(IMPRESSORA, dmPdv.path_imp);
  end;

  try
    Rewrite(IMPRESSORA);
    //lFile.LoadFromFile('caixa.txt');
    Writeln(IMPRESSORA, '');
    Writeln(Impressora, 'RESUMO CAIXA');
    Writeln(IMPRESSORA, '');
    Writeln(Impressora, 'CAIXA : ' + dmPdv.nomeCaixa);
    Writeln(IMPRESSORA, FormatDateTime('dd/mm/yyyy hh:MM:ss', Now));
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Dinheiro       - ' + edDinheiro.Text);
    Writeln(IMPRESSORA, 'Cartao Credito - ' + edCcred.Text);
    Writeln(IMPRESSORA, 'Cartao Debito  - ' + edCdeb.Text);
    Writeln(IMPRESSORA, 'Cheque         - ' + edCheque.Text);
    if (edFaturado.Text <> '0,00') then
      Writeln(IMPRESSORA, 'Faturado       - ' + edFaturado.Text);
    Writeln(IMPRESSORA, 'Sangria        - ' + edSangrias.Text);
    Writeln(IMPRESSORA, '---------------------------');
    Writeln(IMPRESSORA, 'Total Caixa    - ' + edTCaixa.Text);
    Writeln(IMPRESSORA, 'Total Bruto    - ' + edTBruto.Text);
    Writeln(IMPRESSORA, 'Total Liquido  - ' + edTLiquido.Text);
    Writeln(IMPRESSORA, '---------------------------');
    Writeln(IMPRESSORA, '');
  finally
    CloseFile(IMPRESSORA);
  end;
end;

procedure TfAbrirCaixa.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfAbrirCaixa.dtDataChange(Sender: TObject);
begin
  mostrarCaixa(dmPdv.varLogado);
end;

procedure TfAbrirCaixa.FormShow(Sender: TObject);
begin
  if (AbrirFechar = 'Abrir') then
  begin
    fAbrirCaixa.Caption:= 'Abrir Caixa';
    btnAbrefecha.Caption := 'Abrir';
    Label1.Caption:= 'Abrir Caixa';
  end
  else begin
    btnAbrefecha.Caption := 'Fechar';
    Label1.Caption:= 'Fechar Caixa';
    fAbrirCaixa.Caption:= 'Fechar Caixa';
  end;
  if (dmPdv.idCaixa = '0') then
  begin
    ShowMessage('Sem Caixa Aberto');
    //Exit;
  end;
  dtData.Date:=Now;
  mostrarCaixa(dmPdv.varLogado);
end;

procedure TfAbrirCaixa.mostrarCaixa(usuarioCX: String);
var
  sqlp : String;
  total : Double;
  totalliquido : Double;
  totalcaixa : Double;
  cx_m: String;
  data_hoje: String;
begin
  total :=0;
  totalliquido :=0;
  totalcaixa :=0;
  cx_m := dmpdv.idcaixa;
  data_hoje := FormatDateTime('dd/mm/yyyy', Now);
  if (FormatDateTime('dd/mm/yyyy', dtData.Date) <> data_hoje) then
  begin
    dmPdv.busca_sql('SELECT FIRST 1 IDCAIXACONTROLE, CODCAIXA, CODUSUARIO,' +
       'SITUACAO, NOMECAIXA ' +
       ' FROM CAIXA_CONTROLE WHERE CODUSUARIO = ' + dmPdv.varLogado +
       ' AND DATAABERTURA = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtData.Date)) +
       ' ORDER BY IDCAIXACONTROLE DESC');
    cx_m := IntToStr(dmPdv.sqBusca.FieldByName('IDCAIXACONTROLE').AsInteger);
  end;
  sqlP := 'select COALESCE(VALORABRE,0) as Valor from CAIXA_CONTROLE';
  sqlP += ' where IDCAIXACONTROLE = ' + cx_m;
  dmPdv.busca_sql(sqlP);
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    total := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalcaixa := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edDinheiro.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;
  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = 1';//Dinheiro
  sqlP += ' and cod_venda > 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    total += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalcaixa += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edDinheiro.Text:= format('%6.2n',[totalcaixa]);
  end;

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = 2';//Cartão Débito
  sqlP += ' and cod_venda > 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    total += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edCdeb.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = 3';//Cartão Crédito
  sqlP += ' and cod_venda > 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    total += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edCcred.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = 4';//Faturado
  sqlP += ' and cod_venda > 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    total += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edFaturado.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = 5';//Cheque
  sqlP += ' and cod_venda > 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    total += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edCheque.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = 1';//Sangrias
  sqlP += ' and cod_venda = 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    totalliquido -= dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalcaixa -= dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edSangrias.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;
  edTCaixa.Text:= format('%6.2n',[totalcaixa]);
  edTBruto.Text:= format('%6.2n',[total]);
  edTLiquido.Text:= format('%6.2n',[totalliquido]);
end;

procedure TfAbrirCaixa.AbrirCaixa();
var str:string;
  codCaixa:integer;
  vlrCaixa:double;
begin
  if (dmPdv.sqGenerator.Active) then
    dmPdv.sqGenerator.Close;
  dmPdv.sqGenerator.SQL.Clear;
  dmPdv.sqGenerator.SQL.Text := 'SELECT CAST(GEN_ID(GEN_CAIXA, 1) AS INTEGER) ' +
    'AS CODIGO FROM RDB$DATABASE';
  dmPdv.sqGenerator.Open;
  codCaixa := dmPdv.sqGenerator.Fields[0].AsInteger;
  dmPdv.sqGenerator.Close;

  str := 'insert into CAIXA_CONTROLE (IDCAIXACONTROLE, CODCAIXA, CODUSUARIO,' +
    'SITUACAO, NOMECAIXA, MAQUINA, DATAABERTURA, VALORABRE) values (';
  str := str + IntToStr(codCaixa);
  str := str + ', ' + dmpdv.ccusto_padrao;
  str := str + ', ' + dmpdv.varLogado;
  str := str + ', ' + QuotedStr('o');
  str := str + ', ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtData.Date));
  str := str + ', ' + QuotedStr(dmpdv.MICRO);
  str := str + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtData.Date));
  vlrCaixa := StrToFloat(edValor.Text);
  DecimalSeparator:='.';
  str := str + ', ' + FloatToStr(vlrCaixa);
  DecimalSeparator:=',';
  str := str + ')';
  dmPdv.IbCon.ExecuteDirect(str);
  dmPdv.sTrans.Commit;
  ShowMessage('Caixa aberto com sucesso!');


end;

procedure TfAbrirCaixa.FecharCaixa();
var str:string;
  codCaixa:integer;
  vlrCaixa:double;
begin

  str := 'update CAIXA_CONTROLE set SITUACAO = ';
  str := str + QuotedStr('F');
  str := str + ', DATAFECHAMENTO = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', now));
  vlrCaixa := StrToFloat(edValor.Text);
  DecimalSeparator:='.';
  if (UpperCase(dmPdv.usoSistema) = 'ODOO') then
  begin
    str := str + ', VALORFECHA = 1';
  end
  else begin
    str := str + ', VALORFECHA = ' + FloatToStr(vlrCaixa);
  end;
  str := str + ' where IDCAIXACONTROLE = ' + dmpdv.idcaixa;
  DecimalSeparator:=',';
  dmPdv.IbCon.ExecuteDirect(str);

  // cancelo pedidos abertos sem valores
  dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 2' +
      ' WHERE CODORIGEM = ' + dmPdv.idcaixa +
      '   AND CODALMOXARIFADO = ' + dmPdv.ccusto +
      '   AND STATUS = 0');
  dmPdv.nomeCaixa := 'FECHADO';
  dmPdv.sTrans.Commit;
  ShowMessage('Caixa fechado com sucesso!');
end;

end.

