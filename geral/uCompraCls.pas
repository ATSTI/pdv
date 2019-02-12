unit uCompraCls;

interface

uses Classes, SysUtils, dateUtils;

type

  TCompraCls = class(TObject)
  private
    function getApagar: Double;
    function getCaixa: Integer;
    function getCodCCusto: Integer;
    function getCodFornecedor: Integer;
    function getCodMov: Integer;
    function getCodUsuario: Integer;
    function getCodCompra: Integer;
    function getCodComprador: Integer;
    function getDataVcto: TDateTime;
    function getDataCompra: TDateTime;
    function getDesconto: Double;
    function getEntrada: Double;
    function getFormaRec: String;
    function getFrete: Double;
    function getIcms: Double;
    function getIpi: Double;
    function getMultaJuros: Double;
    function getNDoc: String;
    function getNotaFiscal: Integer;
    function getNParcela: Integer;
    function getObs: String;
    function getOutrosVlr: Double;
    function getSeguro: Double;
    function getSerie: String;
    function getStatus: Integer;
    function getValor: Double;
    function getValorPagar: Double;
    procedure setApagar(const Value: Double);
    procedure setCaixa(const Value: Integer);
    procedure setCodCompra(const Value: Integer);
    procedure setCodCCusto(const Value: Integer);
    procedure setCodFornecedor(const Value: Integer);
    procedure setCodMov(const Value: Integer);
    procedure setCodUsuario(const Value: Integer);
    procedure setCodComprador(const Value: Integer);
    procedure setDataVcto(const Value: TDateTime);
    procedure setDataCompra(const Value: TDateTime);
    procedure setDesconto(const Value: Double);
    procedure setEntrada(const Value: Double);
    procedure setFormaRec(const Value: String);
    procedure setFrete(const Value: Double);
    procedure setIcms(const Value: Double);
    procedure setIpi(const Value: Double);
    procedure setMultaJuros(const Value: Double);
    procedure setNDoc(const Value: String);
    procedure setNotaFiscal(const Value: Integer);
    procedure setNParcela(const Value: Integer);
    procedure setObs(const Value: String);
    procedure setOutrosVlr(const Value: Double);
    procedure setSeguro(const Value: Double);
    procedure setSerie(const Value: String);
    procedure setStatus(const Value: Integer);
    procedure setValor(const Value: Double);
    procedure setValorPagar(const Value: Double);
    function getPrazo: String;
    procedure setPrazo(const Value: String);

  protected
    //Atributos
    _codCompra    : Integer;
    _codMov       : Integer;
    _codFornecedor: Integer;
    _codUsuario   : Integer;
    _codComprador  : Integer;
    _codCCusto    : Integer;
    _notaFiscal   : Integer;
    _status       : Integer;
    _caixa        : Integer;
    _nParcela     : Integer;
    _dataCompra   : TDateTime;
    _dataVcto     : TDateTime;
    _valor        : Double;
    _desconto     : Double;
    _multaJuros   : Double;
    _aPagar       : Double;
    _valorPagar   : Double;
    _entrada      : Double;
    _icms         : Double;
    _frete        : Double;
    _seguro       : Double;
    _outrosVlr    : Double;
    _ipi          : Double;
    _serie        : String;
    _prazo        : String;
    _formaRec     : String;
    _nDoc         : String;
    _obs          : String;

  public
    property CodCompra   : Integer read getCodCompra write setCodCompra;
    property CodMov      : Integer read getCodMov write setCodMov;
    property CodFornecedor  : Integer read getCodFornecedor write setCodFornecedor;
    property CodUsuario  : Integer read getCodUsuario write setCodUsuario;
    property CodComprador: Integer read getCodComprador write setCodComprador;
    property CodCCusto   : Integer read getCodCCusto write setCodCCusto;
    property NotaFiscal  : Integer read getNotaFiscal write setNotaFiscal;
    property Status      : Integer read getStatus write setStatus;
    property Caixa       : Integer read getCaixa write setCaixa;
    property NParcela    : Integer read getNParcela write setNParcela;

    property DataCompra   : TDateTime read getDataCompra write setDataCompra;
    property DataVcto    : TDateTime read getDataVcto write setDataVcto;

    property Valor       : Double read getValor write setValor;
    property Desconto    : Double read getDesconto write setDesconto;
    property MultaJuros  : Double read getMultaJuros write setMultaJuros;
    property Apagar      : Double read getApagar write setApagar;
    property ValorPagar  : Double read getValorPagar write setValorPagar;
    property Entrada     : Double read getEntrada write setEntrada;
    property Icms        : Double read getIcms write setIcms;
    property Frete       : Double read getFrete write setFrete;
    property Seguro      : Double read getSeguro write setSeguro;
    property OutrosVlr   : Double read getOutrosVlr write setOutrosVlr;
    property Ipi         : Double read getIpi write setIpi;

    property Serie       : String read getSerie  write setSerie;
    property Prazo       : String read getPrazo  write setPrazo;
    property FormaRec    : String read getFormaRec  write setFormaRec;
    property NDoc        : String read getNDoc  write setNDoc;
    property Obs         : String read getObs  write setObs;

    //Metodos
    function inserirCompra(CodCompraI: Integer): Integer;
    function verCompra(Controle: String; Campo: String; Tipo: String; codNat: Integer): Integer;
    function excluirCompra(codCompraE: Integer): Boolean;
    function alterarCompra(codCompraA: Integer): Boolean;
    constructor Create;
    Destructor Destroy; Override;
  end;

  const
    TABLENAME = 'COMPRA';

implementation

uses udmpdv;

{ TCompraCls }

function TCompraCls.alterarCompra(codCompraA: Integer): Boolean;
begin
  // Alterar Compra
end;

constructor TCompraCls.Create;
begin

end;

destructor TCompraCls.Destroy;
begin

  inherited;
end;

function TCompraCls.excluirCompra(codCompraE: Integer): Boolean;
begin
  // Excluir Compra
  if (dmPdv.executaSql('DELETE FROM COMPRA WHERE CODCOMPRA = ' + IntToStr(codCompraE))) then
    Result := True
  else
    Result := False;
end;


function TCompraCls.getApagar: Double;
begin
  Result := _aPagar;
end;

function TCompraCls.getCaixa: Integer;
begin
  Result := _caixa;
end;

function TCompraCls.getCodCCusto: Integer;
begin
  if (dmPdv.usaCentroCusto = 'S') then
    Result := _codCCusto
  else
    Result := StrToInt(dmPdv.ccusto_padrao);
end;

function TCompraCls.getCodFornecedor: Integer;
begin
  Result := _codFornecedor;
end;

function TCompraCls.getCodMov: Integer;
begin
  Result := _codMov;
end;

function TCompraCls.getCodUsuario: Integer;
begin
  Result := _codUsuario;
end;

function TCompraCls.getCodCompra: Integer;
begin
  Result := _codCompra;
end;

function TCompraCls.getCodComprador: Integer;
begin
  Result := _codComprador;
end;

function TCompraCls.getDataVcto: TDateTime;
begin
  Result := _dataVcto;
end;

function TCompraCls.getDataCompra: TDateTime;
begin
  Result := _dataCompra;
end;

function TCompraCls.getDesconto: Double;
begin
  Result := _desconto;
end;

function TCompraCls.getEntrada: Double;
begin
  Result := _entrada;
end;

function TCompraCls.getFormaRec: String;
begin
  Result := Trim(_formaRec);
end;

function TCompraCls.getFrete: Double;
begin
  Result := _frete;
end;

function TCompraCls.getIcms: Double;
begin
  Result := _icms;
end;

function TCompraCls.getIpi: Double;
begin
  Result := _ipi;
end;

function TCompraCls.getMultaJuros: Double;
begin
  Result := _multaJuros;
end;

function TCompraCls.getNDoc: String;
begin
  Result := Trim(_nDoc);
end;

function TCompraCls.getNotaFiscal: Integer;
begin
  Result := _NotaFiscal;
end;

function TCompraCls.getNParcela: Integer;
begin
  Result := _nParcela;
end;

function TCompraCls.getObs: String;
begin
  Result := Trim(_obs);
end;

function TCompraCls.getOutrosVlr: Double;
begin
  Result := _outrosVlr;
end;

function TCompraCls.getPrazo: String;
begin
  Result := Trim(_prazo);
end;

function TCompraCls.getSeguro: Double;
begin
  Result := _seguro;
end;

function TCompraCls.getSerie: String;
begin
  Result := Trim(_serie);
end;

function TCompraCls.getStatus: Integer;
begin
  Result := _status;
end;

function TCompraCls.getValor: Double;
begin
  Result := _valor;
end;

function TCompraCls.getValorPagar: Double;
begin
  Result := _valorPagar;
end;

function TCompraCls.inserirCompra(CodCompraI: Integer): Integer;
var str: String;
begin
  // Inserir Compra
  _codCompra := CodCompraI;
  if (Self.CodCompra = 0) then
  begin
    _codCompra := dmPdv.busca_generator('GEN_COD_COMPRA');
  end;
  DecimalSeparator := '.';
  Try
    str := 'INSERT INTO COMPRA (CODCOMPRA, CODMOVIMENTO, CODFORNECEDOR, DATACOMPRA, DATAVENCIMENTO, ';
    str := str + 'BANCO, CODCOMPRADOR, STATUS, CODUSUARIO, DATASISTEMA, VALOR, ';
    str := str + 'NOTAFISCAL, SERIE, DESCONTO, CODCCUSTO, N_PARCELA, FORMAPAGAMENTO, ';
    str := str + 'N_DOCUMENTO, CAIXA, MULTA_JUROS, APAGAR, VALOR_PAGAR, ENTRADA, ';
    str := str + 'VALOR_ICMS, VALOR_FRETE, VALOR_SEGURO, OUTRAS_DESP, ';
    str := str + 'VALOR_IPI, PRAZO) VALUES (';
    str := str + IntToStr(Self.CodCompra)    + ', ' + IntToStr(Self.CodMov)       + ', ';
    str := str + IntToStr(Self.CodFornecedor)  + ', ';
    str := str + QuotedStr(FormatDateTime('mm/dd/yyyy',Self.DataCompra))          + ', ';
    str := str + QuotedStr(FormatDateTime('mm/dd/yyyy',Self.DataVcto))           + ', ';
    str := str + '0, ';  // Banco
    str := str + IntToStr(Self.CodComprador) + ' ,' + IntToStr(Self.Status)       + ', ';
    str := str + IntToStr(Self.CodUsuario)  + ' ,';
    str := str + QuotedStr(FormatDateTime('mm/dd/yyyy', Today))                  + ', ';
    str := str + FloatToStr(Self.Valor)     + ', ';
    str := str + IntToStr(Self.NotaFiscal)  + ', ' + QuotedStr(Self.Serie)       + ', ';
    str := str + FloatToStr(Self.Desconto)  + ', ';
    str := str + IntToStr(Self.CodCCusto)   + ', ' + IntToStr(Self.NParcela)     + ', ';
    str := str + QuotedStr(Self.FormaRec)   + ', ' + QuotedStr(Self.NDoc)        + ', ';
    str := str + IntToStr(Self.Caixa)       + ', ' + FloatToStr(Self.MultaJuros) + ', ';
    str := str + FloatToStr(Self.Apagar)    + ', ' + FloatToStr(Self.ValorPagar) + ', ';
    str := str + FloatToStr(Self.Entrada)   + ', ';
    str := str + FloatToStr(Self.Icms)      + ', ';
    str := str + FloatToStr(Self.Frete)     + ', ' + FloatToStr(Self.Seguro)     + ', ';
    str := str + FloatToStr(Self.OutrosVlr) + ', ' + FloatToStr(Self.Ipi)        + ', ';
    str := str + QuotedStr(Self.Prazo)      + ')';
  finally
     DecimalSeparator := ',';
  end;
  if (dmPdv.executaSql(str)) then
    Result := Self.CodCompra
  else
    Result := 0;
end;

procedure TCompraCls.setApagar(const Value: Double);
begin
  _aPagar := Value;
end;

procedure TCompraCls.setCaixa(const Value: Integer);
begin
  _caixa := Value;
end;

procedure TCompraCls.setCodCCusto(const Value: Integer);
begin
  _codCCusto := Value;
end;

procedure TCompraCls.setCodFornecedor(const Value: Integer);
begin
  _codFornecedor := Value;
end;

procedure TCompraCls.setCodMov(const Value: Integer);
begin
  _codMov := Value;
end;

procedure TCompraCls.setCodUsuario(const Value: Integer);
begin
  _codUsuario := Value;
end;

procedure TCompraCls.setCodCompra(const Value: Integer);
begin
  _codCompra := Value;
end;

procedure TCompraCls.setCodComprador(const Value: Integer);
begin
  _codComprador := Value;
end;

procedure TCompraCls.setDataVcto(const Value: TDateTime);
begin
  _dataVcto := Value;
end;

procedure TCompraCls.setDataCompra(const Value: TDateTime);
begin
  _dataCompra := Value;
end;

procedure TCompraCls.setDesconto(const Value: Double);
begin
  _desconto := Value;
end;

procedure TCompraCls.setEntrada(const Value: Double);
begin
  _entrada := Value;
end;

procedure TCompraCls.setFormaRec(const Value: String);
begin
  _formaRec := Value;
end;

procedure TCompraCls.setFrete(const Value: Double);
begin
  _frete := Value;
end;

procedure TCompraCls.setIcms(const Value: Double);
begin
  _icms := Value;
end;

procedure TCompraCls.setIpi(const Value: Double);
begin
  _ipi := Value;
end;

procedure TCompraCls.setMultaJuros(const Value: Double);
begin
  _multaJuros := Value;
end;

procedure TCompraCls.setNDoc(const Value: String);
begin
  _nDoc := Value;
end;

procedure TCompraCls.setNotaFiscal(const Value: Integer);
begin
  _notaFiscal := Value;
end;

procedure TCompraCls.setNParcela(const Value: Integer);
begin
  _nParcela := Value;
end;

procedure TCompraCls.setObs(const Value: String);
begin
  _obs := Value;
end;

procedure TCompraCls.setOutrosVlr(const Value: Double);
begin
  _outrosVlr := Value;
end;

procedure TCompraCls.setPrazo(const Value: String);
begin
  _prazo := Value;
end;

procedure TCompraCls.setSeguro(const Value: Double);
begin
  _seguro := Value;
end;

procedure TCompraCls.setSerie(const Value: String);
begin
  _serie := Value;
end;

procedure TCompraCls.setStatus(const Value: Integer);
begin
  _status := Value;
end;

procedure TCompraCls.setValor(const Value: Double);
begin
  _valor := Value;
end;

procedure TCompraCls.setValorPagar(const Value: Double);
begin
  _valorPagar := Value;
end;

function TCompraCls.verCompra(Controle, Campo, Tipo: String;
  codNat: Integer): Integer;
begin
  // Ver Compra
end;

end.
