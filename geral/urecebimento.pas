unit uRecebimento;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, math, dateutils;

type

  TRecebimento = class(TObject)
  private
    function getCaixa: Integer;
    function getCodCliente: Integer;
    function getCodOrigem: Integer;
    function getCodRec: Integer;
    function getCodUsuario: Integer;
    function getCodVenda: Integer;
    function getCodVendedor: Integer;
    function getDesconto: Double;
    function getDtBaixa: TDateTime;
    function getDtConsolida: TDateTime;
    function getDtEmissao: TDateTime;
    function getDtRec: TDateTime;
    function getDtVcto: TDateTime;
    function getFormaRec: String;
    function getJuros: Double;
    function getMulta: Double;
    function getNDoc: String;
    function getNParcela: Integer;
    function getObs: String;
    function getOutrosCred: Double;
    function getOutrosDeb: Double;
    function getPrazo: String;
    function getSerie: String;
    function getStatus: String;
    function getValor: Double;
    function getValorRec: Double;
    function getVia: SmallInt;
    procedure setCaixa(const Value: Integer);
    procedure setCodCliente(const Value: Integer);
    procedure setCodOrigem(const Value: Integer);
    procedure setCodRec(const Value: Integer);
    procedure setCodUsuario(const Value: Integer);
    procedure setCodVenda(const Value: Integer);
    procedure setCodVendedor(const Value: Integer);
    procedure setDesconto(const Value: Double);
    procedure setDtBaixa(const Value: TDateTime);
    procedure setDtConsolida(const Value: TDateTime);
    procedure setDtEmissao(const Value: TDateTime);
    procedure setDtRec(const Value: TDateTime);
    procedure setDtVcto(const Value: TDateTime);
    procedure setFormaRec(const Value: String);
    procedure setJuros(const Value: Double);
    procedure setMulta(const Value: Double);
    procedure setNDoc(const Value: String);
    procedure setNParcela(const Value: Integer);
    procedure setObs(const Value: String);
    procedure setOutrosCred(const Value: Double);
    procedure setOutrosDeb(const Value: Double);
    procedure setPrazo(const Value: String);
    procedure setSerie(const Value: String);
    procedure setStatus(const Value: String);
    procedure setValor(const Value: Double);
    procedure setValorRec(const Value: Double);
    procedure setVia(const Value: SmallInt);
    function getCodCCusto: Integer;
    procedure setCodCCusto(const Value: Integer);
    function getdataVenc: TStringList;
    procedure setdataVenc(const Value: TStringList);
    function getContaDebito: Integer;
    procedure setContaDebito(const Value: Integer);

  protected
    //Atributos
    _codVenda     : Integer;
    _codRec       : Integer;
    _codOrigem    : Integer;
    _contaDebito  : Integer;

    _codCliente   : Integer;
    _codVendedor  : Integer;
    _codUsuario   : Integer;

    _codCCusto    : Integer;
    _caixa        : Integer;
    _nParcela     : Integer;
    _via          : SmallInt;

    _dtEmissao    : TDateTime;
    _dtVcto       : TDateTime;
    _dtRec        : TDateTime;
    _dtBaixa      : TDateTime;
    _dtConsolida  : TDateTime;

    _valor        : Double;  // Valor Total
    _valorRec     : Double;  // Valor Recebido
    _desconto     : Double;
    _juros        : Double;
    _multa        : Double;
    _outrosDeb    : Double;
    _outrosCred   : Double;

    _status       : String;
    _titulo       : String;
    _serie        : String;

    _prazo        : String;
    _formaRec     : String;
    _nDoc         : String;
    _obs          : String;

    _datasVenc    : TStringList;

  public
    property CodVenda    : Integer read getCodVenda write setCodVenda;
    property CodRec      : Integer read getCodRec write setCodRec;
    property CodOrigem   : Integer read getCodOrigem write setCodOrigem;
    property ContaDebito : Integer read getContaDebito write setContaDebito;

    property CodCliente  : Integer read getCodCliente write setCodCliente;
    property CodUsuario  : Integer read getCodUsuario write setCodUsuario;
    property CodVendedor : Integer read getCodVendedor write setCodVendedor;

    property CodCCusto   : Integer read getCodCCusto write setCodCCusto;
    property Caixa       : Integer read getCaixa write setCaixa;
    property NParcela    : Integer read getNParcela write setNParcela;
    property Via         : SmallInt read getVia write setVia;

    property DtEmissao   : TDateTime read getDtEmissao write setDtEmissao;
    property DtVcto      : TDateTime read getDtVcto  write setDtVcto;
    property DtRec       : TDateTime read getDtRec   write setDtRec;
    property DtBaixa     : TDateTime read getDtBaixa write setDtBaixa;
    property DtConsolida : TDateTime read getDtConsolida   write setDtConsolida;

    property Valor       : Double read getValor write setValor;
    property ValorRec    : Double read getValorRec write setValorRec;
    property Desconto    : Double read getDesconto write setDesconto;
    property Juros       : Double read getJuros write setJuros;
    property Multa       : Double read getMulta write setMulta;
    property OutrosDeb   : Double read getOutrosDeb write setOutrosDeb;
    property OutrosCred  : Double read getOutrosCred write setOutrosCred;

    property Status      : String read getStatus write setStatus;
    property Titulo      : String read getSerie  write setSerie;
    property Prazo       : String read getPrazo  write setPrazo;
    property FormaRec    : String read getFormaRec  write setFormaRec;
    property NDoc        : String read getNDoc  write setNDoc;
    property Obs         : String read getObs  write setObs;
    property dataVenc    : TStringList read getdataVenc  write setdataVenc;

    //Metodos
    procedure gravaHistorico(CODREC_Hist: INTEGER; TITULO_Hist: String;
       CAIXA_Hist: Integer; USUARIO_Hist: Integer; TIPOHISTORICO, HISTORICO_Hist: String);
    function geraTitulo(CodRecR: Integer; CodVendaR: Integer): Integer;
    function baixaTitulo(VALOR_b :Double; FUNRURAL_b: Double; JUROS_b :Double; DESCONTO_b: Double; PERDA_b: Double;
                         DATA_b : TDateTime; DATAREC_b : TDateTime; DATACONSOLIDA_b : TDateTime; FORMAREC_b: String; NDOC_b: String; CAIXA_b : Integer;
                         CLIENTE_b : Integer; STATUS_b : string;  USERID_b : Integer; tipoBaixa_b: String): Integer;
    function excluiTitulo(codVendaE: Integer): Boolean;
    function alteraTitulo(codVendaA: Integer): Boolean;
    function cancelabaixa(CLIENTE_c: Integer; USERID_c: Integer): Boolean;
    constructor Create;
    Destructor Destroy; Override;
  end;

  const
    TABLENAME = 'RECEBIMENTO';

implementation

uses udmpdv;


{ TRecebimento }

function TRecebimento.alteraTitulo(codVendaA: Integer): Boolean;
begin

end;

function TRecebimento.baixaTitulo( VALOR_b :Double; FUNRURAL_b: Double; JUROS_b :Double; DESCONTO_b: Double; PERDA_b: Double;
DATA_b : TDateTime; DATAREC_b : TDateTime; DATACONSOLIDA_b : TDateTime; FORMAREC_b: String; NDOC_b: String; CAIXA_b : Integer;
CLIENTE_b : Integer; STATUS_b : string; USERID_b : Integer; tipoBaixa_b: String): Integer;
var  strRec : String;
  codRecB: Integer;
  VLR_RESTO, VLR, VLRESTO, VLRATUAL, VLPAGO, VLJU, VLFUN, VLDESC, VLPER, VLJUT, VLFUNT, VLDESCT, VLPERT : DOUBLE;
begin
  VLRATUAL := (VALOR_b - FUNRURAL_b - JUROS_b + PERDA_b + DESCONTO_b);
  VLR_RESTO := 0;
  VLPAGO := (VALOR_b - JUROS_b - FUNRURAL_b);
  VLJUT := JUROS_b;
  VLFUNT := FUNRURAL_b;
  VLDESCT := DESCONTO_b;
  VLPERT := PERDA_b;

  strRec := 'SELECT CODRECEBIMENTO, VALOR_RESTO, TITULO FROM RECEBIMENTO ' +
    ' WHERE CODCLIENTE = ' + IntToStr(CLIENTE_b) + ' AND DP = 0 ' +
    '   AND STATUS IN (' + QuotedStr('5-') + ', ' + QuotedStr('9-') +
    ' ) AND USERID = ' + IntToStr(USERID_b) + ' order by DATAVENCIMENTO';
  //strRec := 'SELECT CODRECEBIMENTO, VALOR_RESTO FROM RECEBIMENTO WHERE CODRECEBIMENTO = ' + IntToStr(CODRECEBE);
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(strRec);
  dmPdv.sqBusca.Open;
  dmPdv.sqBusca.First;
  while not dmPdv.sqBusca.Eof do
  begin
    CODRECb := dmPdv.sqBusca.FieldByName('CODRECEBIMENTO').AsInteger;
    VLRESTO := dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat;
    //if (VLR_RESTO = 0) then
      VLR_RESTO := VLRESTO;
    VLJU := VLJUT - VLJU;
    if (VLJU < 0) then
      VLJU := 0;
    VLJUT := VLJUT - VLJU;
    VLFUN := VLFUNT - VLFUN;
    if (VLFUN < 0) then
      VLFUN := 0;
    VLFUNT := VLFUNT - VLFUN;
    if (VLDESC > VLDESCT) then
       VLDESC := 0;
    VLDESC := VLDESCT - VLDESC;
    if (VLDESC < 0) then
      VLDESC := 0;
    VLDESCT := VLDESCT - VLDESC;
    if (VLPER > VLPERT) then
      VLPER := 0;
    VLPER := VLPERT - VLPER;
    if (VLPER < 0) then
      VLPER := 0;
    VLPERT := VLPERT - VLPER;
    VLR_RESTO := VLR_RESTO + VLJU + VLFUN - VLPER - VLDESC;
    // Valor total a baixar - valor pago = valor atual
    if (VLRATUAL > VLRESTO) then
    begin
      VLRATUAL := VLRATUAL - VLRESTO;
      VLPAGO := VLPAGO - VLRESTO;
      VLR := VLRESTO;
    end
    else begin
      VLR := VLRATUAL;
      VLRATUAL := 0;
    end;
    if ((VLR - VLDESC - VLPER) < 0) then
    begin
      if (VLR = VLDESC) then
      begin
        vlpert := vlper;
        vlper := 0;
      end;
      if (VLR = VLPER) then
      begin
        vldesct := vldesc;
        vldesc := 0;
      end;
      if (VLR < VLDESC) then
      begin
        vldesct := vldesc - VLR;
        vldesc := vlr;
      end;
      if (VLR < VLPER) then
      begin
        vlpert := vlper - VLR;
        vlper := vlr;
      end;

    end;
    DecimalSeparator := '.';
    if (VLR > 0) then
    begin
      strRec :=  'UPDATE RECEBIMENTO SET ' +
          'STATUS = ' + QuotedStr(STATUS) +
          ', VALORRECEBIDO = ' + FloatToStr(VLR - VLDESC - VLPER) +
          ', VALOR_RESTO_SST = ' + FloatToStr(VLR - VLDESC - VLPER) +
          ', VALOR_RESTO = ' + FloatToStr(VLR) +
          ', FORMARECEBIMENTO = ' + QuotedStr(FORMAREC_b) +
          ', DATABAIXA = ' + QuotedStr(formatdatetime('mm/dd/yy', DATA_b)) +
          ', DATARECEBIMENTO = ' + QuotedStr(formatdatetime('mm/dd/yy', DATAREC_b)) +
          ', DATACONSOLIDA = ' + QuotedStr(formatdatetime('mm/dd/yy', DATACONSOLIDA_b)) +
          ', N_DOCUMENTO = ' + QuotedStr(NDOC_b) +
          ', CAIXA = ' + IntToStr(CAIXA_b) +
          ', FUNRURAL = ' + FloatToStr(VLFUN) +
          ', JUROS = ' + FloatToStr(VLJU) +
          ', DESCONTO = ' + FloatToStr(VLDESC) +
          ', PERDA = ' + FloatToStr(VLPER) +
          ',outro_credito = ' + FloatToStr(vldesct) +
          ',outro_debito = ' + FloatToStr(vlpert);

          if (tipoBaixa_b = 'DESCONTO') then
            strRec := strRec  + ', DESCONTADO  = ' + QuotedStr('S');

          strRec := strRec  + ' WHERE CODRECEBIMENTO = ' + IntToStr(CODRECb);

          {
          dmPdv.gravaLog(Now, dmPdv.varLogado, 'RECEBIMENTO', dmPdv.MICRO, 'REC.:' +
            FloatToStr(VLR - VLDESC) + '-DESC.:' + FloatToStr(VLDESC) + '-DT:' +
            formatdatetime('dd/mm/yy', DATAREC_b), '', +
            dmPdv.sqBusca.FieldByName('TITULO').asString, 'RECEBIDO');
           }
      dmPdv.executaSql(strRec);
    end;

   // Se Valor e negativo entao baixa o titulo
    if (VALOR < 0) then
    begin
      strRec :=  'UPDATE RECEBIMENTO SET ' +
          'STATUS = ' + QuotedStr(STATUS) +
          ', VALORRECEBIDO = 0 ' +
          ', VALOR_RESTO = 0 ' +
          ', FORMARECEBIMENTO = ' + QuotedStr(FORMAREC) +
          ', DATABAIXA = ' + QuotedStr(formatdatetime('mm/dd/yy', DATA_b)) +
          ', DATARECEBIMENTO = ' + QuotedStr(formatdatetime('mm/dd/yy', DATAREC_b)) +
          ', DATACONSOLIDA = ' + QuotedStr(formatdatetime('mm/dd/yy', DATACONSOLIDA_b)) +
          ', N_DOCUMENTO = ' + QuotedStr(NDOC_b) +
          ', CAIXA = ' + IntToStr(CAIXA_b) +
          ', FUNRURAL = ' + FloatToStr(VLFUN) +
          ', JUROS = ' + FloatToStr(VLJU) +
          ', DESCONTO = ' + FloatToStr(VLDESC) +
          ', PERDA = ' + FloatToStr(VLPER) +
          ',outro_credito = ' + FloatToStr(vldesct) +
          ',outro_debito = ' + FloatToStr(vlpert)  +
          ' WHERE CODRECEBIMENTO = ' + IntToStr(CODRECb);
      dmPdv.executaSql(strRec);
      {
      dm.gravaLog(Now, dm.varLogado, 'RECEBIMENTO', MICRO, 'REC.:' + FloatToStr(VLR - VLDESC) +
            '-DESC.:' + FloatToStr(VLDESC) + '-DT:' + formatdatetime('dd/mm/yy', DATAREC)
            , '', dmPdv.sqBusca.FieldByName('TITULO').asString, 'RECEBIDO');
      }
    end;
    VLR_RESTO := VLR_RESTO - (VLR + VLJU + VLFUN - VLPER - VLDESC);
    Result := 0;
    // Se sobrou algum valor então gera novo titulo
    if ((VLR_RESTO > 0.01) and (tipoBaixa_b <> 'DESCONTO') and (VLR_RESTO <> VLRESTO) )then
    begin
        Self.Valor := VLR_RESTO;
        Result := geraTitulo(codRecB, 0);
    end;
   dmPdv.sqBusca.Next;
  end;
  DecimalSeparator := ',';
end;

function TRecebimento.cancelabaixa(CLIENTE_c, USERID_c: Integer): Boolean;
var  codrecc : Integer;
  strRec : String;
begin
  strRec := 'SELECT CODRECEBIMENTO, VALORRECEBIDO, DESCONTO, PERDA, FUNRURAL,' +
    ' JUROS, TITULO  FROM RECEBIMENTO ' +
    ' WHERE CODCLIENTE = ' + IntToStr(CLIENTE_c) +
    ' AND DP = 0 ' +
    ' AND STATUS IN (' + QuotedStr('1-') + ', ' + QuotedStr('2-') + ', ' +
    QuotedStr('7-') + ', ' + QuotedStr('9-') + ', ' + QuotedStr('13') +
    ') AND USERID = ' + IntToStr(USERID_c) +
    ' order by CODRECEBIMENTO';
  if (dmPdv.sqBusca.Active) then
    dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Add(strRec);
  dmPdv.sqBusca.Open;
  dmPdv.sqBusca.First;
  DecimalSeparator := '.';
  while not dmPdv.sqBusca.Eof do
  begin
    codrecc := dmPdv.sqBusca.FieldByName('CODRECEBIMENTO').AsInteger;
    strRec :=  'UPDATE RECEBIMENTO SET ' +
        'STATUS = ' + QuotedStr('5-') +
        ', VALOR_RESTO = ' +
           FloatToStr(dmPdv.sqBusca.FieldByName('VALORRECEBIDO').AsFloat +
           dmPdv.sqBusca.FieldByName('DESCONTO').AsFloat +
           dmPdv.sqBusca.FieldByName('PERDA').AsFloat) +
        ', VALORRECEBIDO = 0 ' +
        ', FORMARECEBIMENTO = ' + QuotedStr('0') +
        ', DATABAIXA = null' +
        ', DATARECEBIMENTO = null' +
        ', DATACONSOLIDA = null' +
        ', N_DOCUMENTO = null' +
        ', CAIXA = null ' +
        ', FUNRURAL = 0' + FloatToStr(dmPdv.sqBusca.FieldByName('FUNRURAL').AsFloat) +
        ', JUROS = 0' + FloatToStr(dmPdv.sqBusca.FieldByName('JUROS').AsFloat) +
        ', DESCONTO = 0' +
        ', PERDA = 0' +
        ' WHERE CODRECEBIMENTO = ' + IntToStr(codrecc);
    dmPdv.executaSql(strRec);
    {
    dm.gravaLog(Now, dmPdv.varLogado, 'RECEBIMENTO', dmPdv.MICRO, 'REC.:' +
      FloatToStr(dmPdv.sqBusca.FieldByName('VALORRECEBIDO').AsFloat) +
      '-DESC.:' + FloatToStr(dmPdv.sqBusca.FieldByName('DESCONTO').AsFloat)
      , '', dmPdv.sqBusca.FieldByName('TITULO').asString, 'CANCELADO RECEB.');
      }
    dmPdv.sqBusca.Next;
  END;
  DecimalSeparator := ',';
  Result := True;
end;

constructor TRecebimento.Create;
begin
  _datasVenc := TStringList.Create;
  _formaRec := '';
end;

destructor TRecebimento.Destroy;
begin
  _datasVenc.Destroy;
  inherited;
end;

function TRecebimento.excluiTitulo(codVendaE: Integer): Boolean;
begin
 // Excluir Recebimento
  if (dmPdv.executaSql('DELETE FROM RECEBIMENTO WHERE CODVENDA = ' + IntToStr(codVendaE))) then
    Result := True
  else
    Result := False;
end;

function TRecebimento.geraTitulo(CodRecR: Integer; CodVendaR: Integer): Integer;
var strG, strR, strP, strV: String;
            i, DtaAlt : integer;
          rec : Boolean;
      VlrParc, UltParc, VlrT, vlrSt, VlrEnt, difV : Double;
      vDataVenc : TDateTime;
begin
  // Se codVendaR > 0, então é uma Venda então busca os dados da Venda;
  if (CodVendaR > 0) then
  begin
    Try
      strR := 'SELECT CODVENDA, CODMOVIMENTO, CODCLIENTE, DATAVENDA, ' +
        ' DATAVENCIMENTO, NUMEROBORDERO, BANCO, CODVENDEDOR, STATUS, CODUSUARIO,' +
        ' DATASISTEMA, VALOR, NOTAFISCAL, SERIE, ' +
        ' DESCONTO, CODCCUSTO, N_PARCELA,' +
        ' OPERACAO, FORMARECEBIMENTO, N_DOCUMENTO, CAIXA, MULTA_JUROS, APAGAR,  ' +
        ' VALOR_PAGAR, ENTRADA, N_BOLETO, STATUS1, CONTROLE, OBS, VALOR_ICMS,   ' +
        ' VALOR_FRETE, VALOR_SEGURO, OUTRAS_DESP, VALOR_IPI, PRAZO, CODORIGEM,  ' +
        ' TROCO, COALESCE(VALOR_ST,0) VALOR_ST ' +
        '  FROM VENDA ' +
        ' WHERE CODVENDA = ' + InttoStr(CodVendaR);
      dmPdv.sqBusca.Close;
      dmPdv.sqBusca.SQL.Clear;
      dmPdv.sqBusca.SQL.Add(strR);
      dmPdv.sqBusca.Open;
      if (not dmPdv.sqBusca.isEmpty) then
      begin
        Self.CodVenda      := dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger;
        Self.CodCliente    := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
        Self.CodVendedor   := dmPdv.sqBusca.FieldByName('CODVENDEDOR').AsInteger;
        Self.CodUsuario    := dmPdv.sqBusca.FieldByName('CODUSUARIO').AsInteger;
        Self.NParcela      := dmPdv.sqBusca.FieldByName('N_PARCELA').AsInteger;
        Self.Valor         := dmPdv.sqBusca.FieldByName('VALOR').AsFloat;
        VlrEnt             := dmPdv.sqBusca.FieldByName('ENTRADA').AsFloat;
        Self.ValorRec      := dmPdv.sqBusca.FieldByName('ENTRADA').AsFloat;
        vlrSt              := dmPdv.sqBusca.FieldByName('VALOR_ST').AsFloat;
        //Self.Desconto      := sqlBuscaR.FieldByName('DESCONTO').AsFloat;
        Self.DtEmissao     := dmPdv.sqBusca.FieldByName('DATAVENDA').AsDateTime;
        Self.DtVcto        := dmPdv.sqBusca.FieldByName('DATAVENCIMENTO').AsDateTime;
        Self.Prazo         := dmPdv.sqBusca.FieldByName('PRAZO').AsString;
        Self.CodOrigem     := dmPdv.sqBusca.FieldByName('CODORIGEM').AsInteger;
        if (dmPdv.sqBusca.FieldByName('STATUS1').AsString = 'T') then
          Self.ContaDebito := dmPdv.sqBusca.FieldByName('CONTROLE').AsInteger;
        Self.CodCCusto     := dmPdv.sqBusca.FieldByName('CODCCUSTO').AsInteger;
        Self.Titulo        := Trim(IntToStr(dmPdv.sqBusca.FieldByName('NOTAFISCAL').AsInteger) +
          '-' + dmPdv.sqBusca.FieldByName('SERIE').AsString);
        Self.NDoc          := dmPdv.sqBusca.FieldByName('N_DOCUMENTO').AsString;
        Self.FormaRec      := dmPdv.sqBusca.FieldByName('FORMARECEBIMENTO').AsString;
        Self.Caixa         := dmPdv.sqBusca.FieldByName('CAIXA').AsInteger;
      end;
    Finally

    end;
    // Busca o PARAMETRO Cadastro para ver como sera carregado o valor da ST nos titulos
    // vou deixar carregando 100 % na primeira parcela
    if (vlrSt > 0) then
    begin
      Try
        strP := 'SELECT DADOS' +
          '  FROM PARAMETRO ' +
          ' WHERE PARAMETRO = ' + quotedstr('SUBSTITUICAOTRIBUTARIA');
        dmPdv.sqBusca.Close;
        dmPdv.sqBusca.SQL.Clear;
        dmPdv.sqBusca.SQL.Add(strP);
        dmPdv.sqBusca.Open;
        //if (not sqlPrazo.isEmpty) then
        begin
          //vlrSt := 1;
        end;
      Finally

      end;
    end;
    Try
      strP := 'SELECT D1, D2, D3, D4, D5, D6, D7, D8' +
        '  FROM PARAMETRO ' +
        ' WHERE PARAMETRO = ' + quotedstr(Self.Prazo);
      dmPdv.sqBusca.Close;
      dmPdv.sqBusca.SQL.Clear;
      dmPdv.sqBusca.SQL.Add(strP);
      dmPdv.sqBusca.Open;
      if (not dmPdv.sqBusca.isEmpty) then
      begin
        Self.dataVenc.Add(dmPdv.sqBusca.FieldByName('D1').AsString);
        Self.dataVenc.Add(dmPdv.sqBusca.FieldByName('D2').AsString);
        Self.dataVenc.Add(dmPdv.sqBusca.FieldByName('D3').AsString);
        Self.dataVenc.Add(dmPdv.sqBusca.FieldByName('D4').AsString);
        Self.dataVenc.Add(dmPdv.sqBusca.FieldByName('D5').AsString);
        Self.dataVenc.Add(dmPdv.sqBusca.FieldByName('D6').AsString);
        Self.dataVenc.Add(dmPdv.sqBusca.FieldByName('D7').AsString);
        Self.dataVenc.Add(dmPdv.sqBusca.FieldByName('D8').AsString);
      end
      else begin
        Self.dataVenc.Add('0');
        //MessageDlg('Prazo informado : ' + Self.Prazo + ', não está cadastrado em Prazos.', mtWarning, [mbOK], 0);
      end;
    Finally

    end;
  end
  else
  begin
    Try
      strR := 'SELECT CODRECEBIMENTO, CODVENDA, CODCLIENTE, EMISSAO, ' +
        ' DATAVENCIMENTO, CODVENDEDOR, CODUSUARIO,' +
        ' VALOR_RESTO, TITULO, VIA, PARCELAS, CAIXA,' +
        ' FORMARECEBIMENTO, CODALMOXARIFADO, UDF_RTRIM(VIA) as VIA, CONTADEBITO ' +
        '  FROM RECEBIMENTO ' +
        ' WHERE CODRECEBIMENTO = ' + InttoStr(CodRecR);
      dmPdv.sqBusca.Close;
      dmPdv.sqBusca.SQL.Clear;
      dmPdv.sqBusca.SQL.Add(strR);
      dmPdv.sqBusca.Open;
      if (not dmPdv.sqBusca.isEmpty) then
      begin
        Self.CodVenda      := dmPdv.sqBusca.FieldByName('CODVENDA').AsInteger;
        Self.CodCliente    := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
        Self.CodVendedor   := dmPdv.sqBusca.FieldByName('CODVENDEDOR').AsInteger;
        Self.CodUsuario    := dmPdv.sqBusca.FieldByName('CODUSUARIO').AsInteger;
        Self.NParcela      := dmPdv.sqBusca.FieldByName('PARCELAS').AsInteger;
        Self.Valor         := dmPdv.sqBusca.FieldByName('VALOR_RESTO').AsFloat;
        //VlrEnt             := dmPdv.sqBusca.FieldByName('ENTRADA').AsFloat;
        Self.ValorRec      := 0;//dmPdv.sqBusca.FieldByName('ENTRADA').AsFloat;
        Self.DtEmissao     := dmPdv.sqBusca.FieldByName('EMISSAO').AsDateTime;
        Self.DtVcto        := dmPdv.sqBusca.FieldByName('DATAVENCIMENTO').AsDateTime;
        //Self.Prazo         := dmPdv.sqBusca.FieldByName('PRAZO').AsString;
        Self.CodOrigem     := dmPdv.sqBusca.FieldByName('CODRECEBIMENTO').AsInteger;
        Self.CodCCusto     := dmPdv.sqBusca.FieldByName('CODALMOXARIFADO').AsInteger;
        Self.Titulo        := dmPdv.sqBusca.FieldByName('TITULO').AsString;
        vDataVenc          := dmPdv.sqBusca.FieldByName('DATAVENCIMENTO').AsDateTime;
        Self.Via           := StrToInt(StringReplace(dmPdv.sqBusca.FieldByName('VIA').AsString, ' ', '', [rfReplaceAll,rfIgnoreCase]))+1;
        VlrParc            := Self.Valor;
        Self.Caixa         := dmPdv.sqBusca.FieldByName('CAIXA').AsInteger;
        Self.ContaDebito   := dmPdv.sqBusca.FieldByName('CONTADEBITO').AsInteger;
        CodRecR := 1;
      end;
    Finally

    end;

  end;

  difV := 0;
  if (Self.ValorRec > 0) then
    difV := Self.Valor - Self.ValorRec;
  if (Self.ValorRec > 0) then
  if ((Self.NParcela = 1) and (difV > 0.009)) then
  begin
    MessageDlg('Parcela não pode ser 1, se o valor de Entrada e menor que o Valor Total.', mtWarning, [mbOK], 0);
    exit;
  end;
  if (VlrEnt = Self.Valor) then
  begin
    Self.Status := '7-';

  end
  else begin
    Self.Status   := '5-';
  end;
  if ( Self.FormaRec = '') then
    Self.FormaRec := '0';
  if (CodRecR <> 1) then
  begin
    //if ((Self.ValorRec > 0) and (Self.ValorRec < Self.Valor)) then
    //  VlrParc := ((Self.Valor - vlrSt) - Self.ValorRec) / (Self.NParcela-1)
    //else
    if (VlrEnt > 0) then
    begin
      if ((Self.Valor - vlrSt - VlrEnt) > 0) then
      begin
        if (Self.NParcela > 1) then
          VlrParc := (Self.Valor - vlrSt - VlrEnt) / (Self.NParcela -1)
        else
          VlrParc := (Self.Valor - vlrSt - VlrEnt) / 1;
      end;
    end
    else
      VlrParc := (Self.Valor - vlrSt) / Self.NParcela;
  end
  else
  begin
    Self.NParcela := 1;
  end;
  DecimalSeparator := '.';

  UltParc := Self.Valor;
  VlrT := roundTo(VlrParc, -2);

  for i := 1 to Self.NParcela do
  begin
    if (i = 1) then
      if (VlrEnt > 0) then
        VlrParc := VlrEnt
      else
        VlrParc := roundTo((VlrT + vlrSt),-2)
    else
      VlrParc := vlrT;
    if ((CodRecR = 0) or (CodRecR = 1)) then   //CodRecR = 1  novo titulo de baixa Parcial...
    begin
      if (dmPdv.sqGenerator.Active) then
        dmPdv.sqGenerator.Close;
      dmPdv.sqGenerator.SQL.Text := 'SELECT CAST(GEN_ID(COD_AREC, 1) AS INTEGER) AS CODIGO FROM RDB$DATABASE';
      dmPdv.sqGenerator.Open;
      Self.CodRec := dmPdv.sqGenerator.Fields[0].AsInteger;
      dmPdv.sqGenerator.Close;
    end;

    //Tratar a Data de Vencimento da Parcela
    if (CodRecR = 0) then
      if( Self.Prazo <> '' ) then
      begin
        vDataVenc := IncDay(Self.DtEmissao, StrToInt(Self.dataVenc.Strings[i-1]));
      end
      else
          vDataVenc := IncMonth(Self.DtVcto, (i-1));

    //TRATA VENCIMENTOS NOS FINS DE SEMANA
    Try
      strV := 'SELECT DADOS' +
        '  FROM PARAMETRO ' +
        ' WHERE PARAMETRO = ' + quotedstr('VENCFDSSEG');
      dmPdv.sqBusca.Close;
      dmPdv.sqBusca.SQL.Clear;
      dmPdv.sqBusca.SQL.Add(strV);
      dmPdv.sqBusca.Open;
      if (not dmPdv.sqBusca.isEmpty) then
      begin
        //VERIFICA SE O VENCIMENTO É EM UM SABADO OU DOMINGO E PASSA PARA A SEGUNDA}
         DtaAlt := DayOfWeek(vDataVenc);
         IF (DtaAlt = 1) then
           vDataVenc := IncDay(vDataVenc, 1);
         IF (DtaAlt = 7) then
           vDataVenc := IncDay(vDataVenc, 2);
      end;
    Finally

    end;

    strG := ' INSERT INTO RECEBIMENTO ' +
          ' (CODRECEBIMENTO, TITULO,          EMISSAO,         CODCLIENTE,      ' +
          ' DATAVENCIMENTO,  STATUS,          VIA,             FORMARECEBIMENTO,' +
          ' CODVENDA ,       CODALMOXARifADO, CODVENDEDOR,     CODUSUARIO,      ' +
          ' DATASISTEMA,     VALOR_PRIM_VIA,  VALOR_RESTO,     VALORTITULO,     ' +
          ' VALORRECEBIDO,   PARCELAS,        DESCONTO,        JUROS,           ' +
          ' FUNRURAL,        PERDA,           TROCA,           N_DOCUMENTO,     ' +
          ' OUTRO_CREDITO,   CAIXA,           SITUACAO,        CODORIGEM, CONTADEBITO   ' +
          ') VALUES(';

    strG := strG + InttoStr(Self.CodRec) + ', ';
    strG := strG + QuotedStr(Self.Titulo) + ', ';
    strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy', Self.DtEmissao)) + ', ';
    strG := strG + IntToStr(Self.CodCliente) + ', ';
    //strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy', (IncDay(Self.DtEmissao, StrToInt(Self.dataVenc.Strings[i-1]))))) + ', ';
    strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy', vDataVenc)) + ', ';

    strG := strG + QuotedStr(Self.Status) + ', ';
    if (CodRecR > 0) then
      strG := strG + IntToStr(Self.Via) + ', '
    else
      strG := strG + IntToStr(i) + ', ';
    strG := strG + QuotedStr(Self.FormaRec) + ', ';
    strG := strG + InttoStr(Self.CodVenda) + ', ';
    strG := strG + InttoStr(Self.CodCCusto) + ', ';
    strG := strG + InttoStr(Self.CodVendedor) + ', ';
    strG := strG + InttoStr(Self.CodUsuario) + ', ';
    strG := strG + QuotedStr(FormatDateTime('mm/dd/yyyy hh:MM', Now)) + ', ';  // DataSistema

    if ((i = 1) and (CodRecR = 0)) then
      strG := strG + FloattoStr(Self.Valor) + ', ' // Valor_prim_via
    else
      strG := strG + '0, '; // Valor_prim_via

    //COLOCA O CAMPO COM 2 CASAS DECIMAIS
    //    VlrParc := Trunc(VlrParc * 100) / 100;

    if (i = 1) then
    begin
      if (Self.ValorRec > 0) then
          strG := strG + FloattoStr(Self.ValorRec) + ', ' // Valor_Resto
      else
          strG := strG + FloattoStr(VlrParc) + ', '; // Valor_Resto
    end
    else
      if ( i = Self.NParcela) then
        strG := strG + FloattoStr(UltParc) + ', ' // Valor_Resto
      else
        strG := strG + FloattoStr(VlrParc) + ', '; // Valor_Resto

    strG := strG + FloattoStr(Self.Valor) + ', ';  // Valortitulo
    if (self.ValorRec > 0) then
    begin
      strG := strG + FloattoStr(Self.ValorRec) + ', ';
    end
    else begin
      strG := strG + '0, ';  // ValorRecebido
    end;
    strG := strG + IntToStr(Self.NParcela) + ', ';
    strG := strG + '0, ';  // Desconto
    strG := strG + '0, ';  // Juros
    strG := strG + '0, ';  // FUNRURAL
    strG := strG + '0, ';  // Perda
    strG := strG + '0, ';  // Troca
    strG := strG + QuotedStr(Self.NDoc) + ', '; // N.Doc.
    strG := strG + '0, ';  // Outro_Credito
    strG := strG + IntToStr(Self.Caixa) + ', '; // Caixa
    strG := strG + IntToStr(1) + ', '; // Situacao
    strG := strG + IntToStr(1) + ', '; // CodOrigem
    strG := strG + IntToStr(Self.ContaDebito) + ')'; //
    //if (Self.ContaDebito = 0) then
    //  MessageDlg('epa ...', mtWarning, [mbOK], 0);
    Rec  := dmPdv.executaSql(strG);
    UltParc := UltParc - VlrParc;
  end;

  DecimalSeparator := ',';
  Result := 0;
  if (Rec) then
    Result := Self.CodRec;
end;

function TRecebimento.getCaixa: Integer;
begin
  Result := _caixa;
end;

function TRecebimento.getCodCCusto: Integer;
begin
  Result := _codCCusto;
end;

function TRecebimento.getCodCliente: Integer;
begin
  Result := _codCliente;
end;

function TRecebimento.getCodOrigem: Integer;
begin
  Result := _codOrigem;
end;

function TRecebimento.getCodRec: Integer;
begin
  Result := _codRec;
end;

function TRecebimento.getCodUsuario: Integer;
begin
  Result := _codUsuario;
end;

function TRecebimento.getCodVenda: Integer;
begin
  Result := _codVenda;
end;

function TRecebimento.getCodVendedor: Integer;
begin
  Result := _codVendedor;
end;

function TRecebimento.getContaDebito: Integer;
begin
  Result := _contaDebito;
end;

function TRecebimento.getdataVenc: TStringList;
begin
  Result := _datasVenc;
end;

function TRecebimento.getDesconto: Double;
begin
  Result := _desconto;
end;

function TRecebimento.getDtBaixa: TDateTime;
begin
  Result := _dtBaixa;
end;

function TRecebimento.getDtConsolida: TDateTime;
begin
  Result := _dtConsolida;
end;

function TRecebimento.getDtEmissao: TDateTime;
begin
  Result := _dtEmissao;
end;

function TRecebimento.getDtRec: TDateTime;
begin
  Result := _dtRec;
end;

function TRecebimento.getDtVcto: TDateTime;
begin
  Result := _dtVcto;
end;

function TRecebimento.getFormaRec: String;
begin
  Result := _formaRec;
end;

function TRecebimento.getJuros: Double;
begin
  Result := _juros;
end;

function TRecebimento.getMulta: Double;
begin
  Result := _multa;
end;

function TRecebimento.getNDoc: String;
begin
  Result := _nDoc;
end;

function TRecebimento.getNParcela: Integer;
begin
  Result := _nParcela;
end;

function TRecebimento.getObs: String;
begin
  Result := _obs;
end;

function TRecebimento.getOutrosCred: Double;
begin
  Result := _outrosCred;
end;

function TRecebimento.getOutrosDeb: Double;
begin
  Result := _outrosDeb;
end;

function TRecebimento.getPrazo: String;
begin
  Result := _prazo;
end;

function TRecebimento.getSerie: String;
begin
  Result := _serie;
end;

function TRecebimento.getStatus: String;
begin
  Result := _status;
end;

function TRecebimento.getValor: Double;
begin
  Result := _valor;
end;

function TRecebimento.getValorRec: Double;
begin
  Result := _valorRec;
end;

function TRecebimento.getVia: SmallInt;
begin
  Result := _via;
end;

procedure TRecebimento.gravaHistorico(CODREC_Hist: INTEGER; TITULO_Hist: String;
  CAIXA_Hist: Integer; USUARIO_Hist: Integer; TIPOHISTORICO, HISTORICO_Hist: String);
var strHist, id_hist: String;
begin
  {
  Try
    sqlId :=  TSqlQuery.Create(nil);
    sqlId.SQLConnection := dm.sqlsisAdimin;
    strHist := 'SELECT MAX(ID_HIST) ' +
      '  FROM RECEBIMENTO_HIST ' +
      ' WHERE CODRECEBIMENTO = ' + InttoStr(CodRec);
    sqlId.SQL.Add(strHist);
    sqlId.Open;
    if (sqlId.isEmpty) then
      id_hist := '1'
    else
      id_hist := IntToStr(sqlId.fields[0].asInteger + 1);
  Finally
    sqlId.Free;
  end;
  strHist := 'INSERT INTO RECEBIMENTO_HIST VALUES(';
  strHist := strHist + IntToStr(CODREC);
  strHist := strHist + ', ' + id_hist;
  strHist := strHist + ', ' + QuotedStr(titulo);
  strHist := strHist + ', ' + IntToStr(caixa);
  strHist := strHist + ', ' + QuotedStr(tipoHistorico);
  strHist := strHist + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy', Now));
  strHist := strHist + ', ' + QuotedStr(Historico);
  strHist := strHist + ', ' + IntToStr(Usuario);
  strHist := strHist + ')';
  dm.sqlsisAdimin.ExecuteDirect(strHist);
  }
end;

procedure TRecebimento.setCaixa(const Value: Integer);
begin
  _caixa := Value;
end;

procedure TRecebimento.setCodCCusto(const Value: Integer);
begin
  _codCCusto := Value;
end;

procedure TRecebimento.setCodCliente(const Value: Integer);
begin
  _codCliente := Value;
end;

procedure TRecebimento.setCodOrigem(const Value: Integer);
begin
  _codOrigem := Value;
end;

procedure TRecebimento.setCodRec(const Value: Integer);
begin
  _codRec := Value;
end;

procedure TRecebimento.setCodUsuario(const Value: Integer);
begin
  _codUsuario := Value;
end;

procedure TRecebimento.setCodVenda(const Value: Integer);
begin
  _codVenda := Value;
end;

procedure TRecebimento.setCodVendedor(const Value: Integer);
begin
  _codVendedor := Value;
end;

procedure TRecebimento.setContaDebito(const Value: Integer);
begin
  _contaDebito := Value;
end;

procedure TRecebimento.setdataVenc(const Value: TStringList);
begin
  _datasVenc := Value;
end;

procedure TRecebimento.setDesconto(const Value: Double);
begin
  _desconto := Value;
end;

procedure TRecebimento.setDtBaixa(const Value: TDateTime);
begin
  _dtBaixa := Value;
end;

procedure TRecebimento.setDtConsolida(const Value: TDateTime);
begin
  _dtConsolida := Value;
end;

procedure TRecebimento.setDtEmissao(const Value: TDateTime);
begin
  _dtEmissao := Value;
end;

procedure TRecebimento.setDtRec(const Value: TDateTime);
begin
  _dtRec := Value;
end;

procedure TRecebimento.setDtVcto(const Value: TDateTime);
begin
  _dtVcto := Value;
end;

procedure TRecebimento.setFormaRec(const Value: String);
begin
  _formaRec := Value;
end;

procedure TRecebimento.setJuros(const Value: Double);
begin
  _juros := Value;
end;

procedure TRecebimento.setMulta(const Value: Double);
begin
  _multa := Value;
end;

procedure TRecebimento.setNDoc(const Value: String);
begin
  _nDoc := Value;
end;

procedure TRecebimento.setNParcela(const Value: Integer);
begin
  _nParcela := Value;
end;

procedure TRecebimento.setObs(const Value: String);
begin
  _obs := Value;
end;

procedure TRecebimento.setOutrosCred(const Value: Double);
begin
  _outrosCred := Value;
end;

procedure TRecebimento.setOutrosDeb(const Value: Double);
begin
  _outrosDeb := Value;
end;

procedure TRecebimento.setPrazo(const Value: String);
begin
  _prazo := Value;
end;

procedure TRecebimento.setSerie(const Value: String);
begin
  _serie := Value;
end;

procedure TRecebimento.setStatus(const Value: String);
begin
  _status := Value;
end;

procedure TRecebimento.setValor(const Value: Double);
begin
  _valor := Value;
end;

procedure TRecebimento.setValorRec(const Value: Double);
begin
  _valorRec := Value;
end;

procedure TRecebimento.setVia(const Value: SmallInt);
begin
  _via := Value;
end;

end.

