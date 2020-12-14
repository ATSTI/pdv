unit uabrircaixa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, MaskEdit, Buttons, ExtCtrls, ACBrPosPrinter, udmpdv;

type

  { TfAbrirCaixa }

  TfAbrirCaixa = class(TForm)
    ACBrPosPrinter1: TACBrPosPrinter;
    BitBtn24: TBitBtn;
    btnAbrefecha: TBitBtn;
    btnSair: TBitBtn;
    dtData: TDateTimePicker;
    edReforco: TMaskEdit;
    edSaldoini: TMaskEdit;
    edTLiquido: TMaskEdit;
    edTSaldoIni: TMaskEdit;
    edValor: TMaskEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
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
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn24Click(Sender: TObject);
    procedure btnAbrefechaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dtDataChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mostrarCaixa(usuarioCX: String);
  private
    cartao_debito_vlr: Double;
    cartao_credito_vlr: Double;
    cx_m: String;
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
  total, total1 : double;
  vlr_cartao : String;
  arquivo: TStringList;
  forma_pg : String;
  sqlP : String;
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
    Writeln(IMPRESSORA, 'Saldo Inicial  - ' + edSaldoIni.Text);
    Writeln(IMPRESSORA, 'Entradas       - ' + edDinheiro.Text);

    //TODO  Imprimindo TODOS tipos de Sangria

    sqlP := 'select FORMA_PAGTO, MOTIVO,  sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
    sqlP += ' where CAIXA = ' + cx_m;
    sqlP += ' and STATE = 1 and FORMA_PGTO IN (' + QuotedStr('S') + ', ' +
      QuotedStr('R') + ', ' + QuotedStr('F') + ', ' + QuotedStr('U') + ', ' +
      QuotedStr('V') + ', ' + QuotedStr('T') + ')';//Sangrias
    sqlP += ' and cod_venda = 1  ';//1 para Sangria, >1 para Outros
    sqlP += ' GROUP BY FORMA_PAGTO, MOTIVO';
    if (dmPdv.sqBusca.Active) then
      dmPdv.sqBusca.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqBusca.SQL.Add(sqlP);
    dmPdv.sqBusca.Active:=True;
    While not dmPdv.sqBusca.EOF do
    begin
      forma_pg := 'Sangria';
      Case dmPdv.sqBusca.FieldByName('FORMA_PAGTO').AsString of
        'S': forma_pg := 'Sangria';
        'R': forma_pg := 'Rec. Cliente';
        'F': forma_pg := 'Pag. Fornecedor';
        'U': forma_pg := 'Uso interno';
        'V': forma_pg := 'Vale';
        'T': forma_pg := 'Outros';
      end;
      //totalliquido -= dmPdv.sqBusca.FieldByName('Valor').AsFloat;
      //totalcaixa -= dmPdv.sqBusca.FieldByName('Valor').AsFloat;
      //edSangrias.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
      //Writeln(IMPRESSORA,  'Sangria        - ' + edSangrias.Text);
      Writeln(IMPRESSORA, forma_pg + '       - ' + format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat])
      );
      dmPdv.sqBusca.Next;
    end;


    Writeln(IMPRESSORA, 'Reforco        - ' + edReforco.Text);
    Writeln(IMPRESSORA, '---------------------------');
    Writeln(IMPRESSORA, 'Saldo Caixa    - ' + edTCaixa.Text);
    Writeln(IMPRESSORA, '');
    Writeln(IMPRESSORA, 'Dinheiro       - ' + edDinheiro.Text);
    total := 0;
    total1 := 0;
    if dmPdv.OutrosCartoes = 'S' then
    begin
      vlr_cartao := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
      vlr_cartao += ' where CAIXA = ' + cx_m;
      vlr_cartao += ' and STATE = 1 and FORMA_PGTO = 7';//Sia Net
      vlr_cartao += ' and cod_venda > 1  ';
      if (dmPdv.sqBusca.Active) then
        dmPdv.sqBusca.Close;
      dmPdv.sqBusca.SQL.Clear;
      dmPdv.sqBusca.SQL.Add(vlr_cartao);
      dmPdv.sqBusca.Active:=True;
      if (not dmPdv.sqBusca.IsEmpty) then
      begin
        total := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
      end;
      vlr_cartao := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
      vlr_cartao += ' where CAIXA = ' + cx_m;
      vlr_cartao += ' and STATE = 1 and FORMA_PGTO = 8';//Brasil Card
      vlr_cartao += ' and cod_venda > 1  ';
      if (dmPdv.sqBusca.Active) then
        dmPdv.sqBusca.Close;
      dmPdv.sqBusca.SQL.Clear;
      dmPdv.sqBusca.SQL.Add(vlr_cartao);
      dmPdv.sqBusca.Active:=True;
      if (not dmPdv.sqBusca.IsEmpty) then
      begin
        total1 := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
      end;
    end;
    cartao_credito_vlr := cartao_credito_vlr - total - total1;
    vlr_cartao := format('%6.2n',[cartao_credito_vlr]);
    Writeln(IMPRESSORA, 'Cartao Credito - ' + vlr_cartao);
    Writeln(IMPRESSORA, 'Cartao Debito  - ' + edCdeb.Text);
    if dmPdv.OutrosCartoes = 'S' then
    begin
      vlr_cartao := format('%6.2n',[total]);
      Writeln(IMPRESSORA, 'Sia Net        - ' + vlr_cartao);
      vlr_cartao := format('%6.2n',[total1]);
      Writeln(IMPRESSORA, 'Brasil Card    - ' + vlr_cartao);
    end;
    Writeln(IMPRESSORA, 'Cheque         - ' + edCheque.Text);
    if (edFaturado.Text <> '0,00') then
      Writeln(IMPRESSORA, 'Faturado       - ' + edFaturado.Text);

    //Writeln(IMPRESSORA, 'Total Liquido  - ' + edTLiquido.Text);
    Writeln(IMPRESSORA, '---------------------------');
    Writeln(IMPRESSORA, 'Total Vendas   - ' + edTBruto.Text);
    //Writeln(IMPRESSORA, 'Saldo Abertura  - ' + edTLiquido.Text);
    Writeln(IMPRESSORA, '');
  finally
    CloseFile(IMPRESSORA);
  end;


  if (dmPdv.CupomImp <> 'Texto') then
  begin
    arquivo := TStringList.Create();
    try
      arquivo.LoadFromFile(dmPdv.path_imp);
      Memo1.Clear;
      Memo1.Text := arquivo.Text;
    finally
      arquivo.free;
    end;
    ACBrPosPrinter1.Desativar;
    ACBrPosPrinter1.LinhasBuffer := dmpdv.imp_LinhasBuffer;
    ACBrPosPrinter1.LinhasEntreCupons := 0;
    ACBrPosPrinter1.EspacoEntreLinhas := dmpdv.espacoEntreLinhas;
    ACBrPosPrinter1.ColunasFonteNormal := dmpdv.imp_ColunaFonteNormal;
    ACBrPosPrinter1.Device.SendBytesCount:=1024;
    ACBrPosPrinter1.Device.SendBytesInterval := dmpdv.imp_Interval;
    ACBrPosPrinter1.ControlePorta :=  dmpdv.imp_controle_porta;
    ACBrPosPrinter1.Porta  := dmPdv.portaImp;
    ACBrPosPrinter1.CortaPapel := True;
    ACBrPosPrinter1.Modelo := TACBrPosPrinterModelo(dmPdv.ModeloImp);
    ACBrPosPrinter1.Ativar;

    ACBrPosPrinter1.Buffer.Text := Memo1.Lines.Text;
    ACBrPosPrinter1.Imprimir;

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
  vendacaixa : Double;
  saldoini : Double;
  data_hoje: String;
  data_sis : String;
begin
  total :=0;
  totalliquido :=0;
  totalcaixa := 0;
  vendacaixa := 0;
  saldoini := 0;
  cx_m := dmpdv.idcaixa;
  data_hoje := FormatDateTime('dd/mm/yyyy', Now);
  data_sis := FormatDateTime('dd/mm/yyyy', dtData.Date);
  if (data_sis <> data_hoje) then
  begin
    dmPdv.busca_sql('SELECT FIRST 1 IDCAIXACONTROLE, CODCAIXA, CODUSUARIO,' +
       'SITUACAO, NOMECAIXA ' +
       ' FROM CAIXA_CONTROLE WHERE CODUSUARIO = ' + dmPdv.varLogado +
       ' AND DATAABERTURA = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtData.Date)) +
       '  ORDER BY IDCAIXACONTROLE DESC');
    // ' ) OR (DATAFECHAMENTO = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtData.Date)) +
    cx_m := IntToStr(dmPdv.sqBusca.FieldByName('IDCAIXACONTROLE').AsInteger);
  end;
  sqlP := 'select COALESCE(VALORABRE,0) as Valor from CAIXA_CONTROLE';
  sqlP += ' where IDCAIXACONTROLE = ' + cx_m;
  dmPdv.busca_sql(sqlP);
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    //total := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    saldoini := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalcaixa := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edDinheiro.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
    edSaldoini.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;
  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = ' + QuotedStr('1');//Dinheiro
  sqlP += ' and cod_venda > 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    vendacaixa += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    total += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalcaixa += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edDinheiro.Text:= format('%6.2n',[vendacaixa]);
  end;

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = ' + QuotedStr('2');//Cartão Débito
  sqlP += ' and cod_venda > 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    cartao_debito_vlr := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    total += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edCdeb.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO in (' + QuotedStr('3') + ',' +
    QuotedStr('7') + ',' + QuotedStr('8') + ')';//Cartão Crédito
  sqlP += ' and cod_venda > 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    cartao_credito_vlr := dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    total += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edCcred.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = ' + QuotedStr('4');//Faturado
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
  sqlP += ' and STATE = 1 and FORMA_PGTO = ' + QuotedStr('5');//Cheque
  sqlP += ' and cod_venda > 1  ';//1 para Sangria, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    vendacaixa += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    total += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edCheque.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO IN (' + QuotedStr('S') + ', ' +
    QuotedStr('R') + ', ' + QuotedStr('F') + ', ' + QuotedStr('U') + ', ' +
    QuotedStr('V') + ', ' + QuotedStr('T') + ')';//Sangrias
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

  sqlP := 'select sum(VALOR_PAGO) as Valor from FORMA_ENTRADA';
  sqlP += ' where CAIXA = ' + cx_m;
  sqlP += ' and STATE = 1 and FORMA_PGTO = ' + QuotedStr('1');//Sangrias/Reforco
  sqlP += ' and cod_venda = 0  ';//0 para Reforco Caixa, >1 para Outros
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(sqlP);
  dmPdv.sqBusca.Active:=True;
  if (not dmPdv.sqBusca.IsEmpty) then
  begin
    totalliquido += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    totalcaixa += dmPdv.sqBusca.FieldByName('Valor').AsFloat;
    edReforco.Text:= format('%6.2n',[dmPdv.sqBusca.FieldByName('Valor').AsFloat]);
  end;
  edTCaixa.Text:= format('%6.2n',[totalcaixa]);
  edTBruto.Text:= format('%6.2n',[total]);
  edTLiquido.Text:= format('%6.2n',[vendacaixa]);
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
  IMPRESSORA:TextFile;
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
  //str := str + ' where IDCAIXACONTROLE = ' + dmpdv.idcaixa;
  str := str + ' WHERE CODUSUARIO = ' + dmPdv.varLogado;
  str := str + '   AND SITUACAO = ' + QuotedStr('o');
  DecimalSeparator:=',';
  try
    dmPdv.IbCon.ExecuteDirect(str);

    // cancelo pedidos abertos sem valores
    dmPdv.IbCon.ExecuteDirect('UPDATE MOVIMENTO SET STATUS = 2' +
      ' WHERE CODORIGEM = ' + dmPdv.idcaixa +
      '   AND CODALMOXARIFADO = ' + dmPdv.ccusto +
      '   AND STATUS = 0');
    dmPdv.nomeCaixa := 'FECHADO';
    dmPdv.sTrans.Commit;
    ShowMessage('Caixa fechado com sucesso!');
    begin  // IMPRESSAO
      BitBtn24.Click;
      // leio um arquivo txt e imprimo
      //lFile := TStringList.Create;
      {
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
        Writeln(Impressora, 'FECHAMENTO DO CAIXA');
        Writeln(IMPRESSORA, '');
        Writeln(Impressora, 'CAIXA : ' + dmPdv.nomeCaixa);
        Writeln(IMPRESSORA, FormatDateTime('dd/mm/yyyy hh:MM:ss', Now));
        Writeln(IMPRESSORA, '');
        Writeln(IMPRESSORA, 'Saldo Inicial  - ' + edSaldoIni.Text);
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
        }
    end; // FIM IMPRESSAO
  except
    on e: Exception do
    begin
      dmpdv.sTrans.Rollback;
      ShowMessage('Erro para fechar o Caixa : ' + e.Message);
    end;
  end;
end;

end.

