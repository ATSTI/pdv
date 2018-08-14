unit uMovimento;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uMovimentoDetalhe, Dialogs;

type

  { TMovimento }

  TMovimento = class(TObject)

  private
    function getCodCCusto: Integer;
    function getCodCliente: Integer;
    function getCodFornec: Integer;
    function getCodMov: Integer;
    function getCodNatureza: Integer;
    function getCodOrigem: Integer;
    function getCodPedido: Integer;
    function getCodUsuario: Integer;
    function getCodVendedor: Integer;
    function getControle: String;
    function getDataEntrega: TDateTime;
    function getDataMov: TDateTime;
    function getEntrega: String;
    function getMovDetalhe: TMovimentoDetalhe;
    function getObs: String;
    function getStatus: Integer;
    function getTipoPedido: String;
    procedure setCodCCusto(AValue: Integer);
    procedure setCodCliente(AValue: Integer);
    procedure setCodFornec(AValue: Integer);
    procedure setCodMov(AValue: Integer);
    procedure setCodNatureza(AValue: Integer);
    procedure setCodOrigem(AValue: Integer);
    procedure setCodPedido(AValue: Integer);
    procedure setCodUsuario(AValue: Integer);
    procedure setCodVendedor(AValue: Integer);
    procedure setControle(AValue: String);
    procedure setDataEntrega(AValue: TDateTime);
    procedure setDataMov(AValue: TDateTime);
    procedure setEntrega(AValue: String);
    procedure setMovDetalhe(AValue: TMovimentoDetalhe);
    procedure setObs(AValue: String);
    procedure setStatus(AValue: Integer);
    procedure setTipoPedido(AValue: String);
  protected
    //Atributos
    _codMov          : Integer;
    _codPedido       : Integer;
    _codCliente      : Integer;
    _codNatureza     : Integer;
    _status          : Integer;
    _codUsuario      : Integer;
    _codVendedor     : Integer;
    _codCCusto       : Integer;
    _codFornec       : Integer;
    _codOrigem       : Integer;
    _controle        : String;
    _obs             : String;
    _dataMov         : TDateTime;
    _dataEntrega     : TDateTime;
    _movDetalhe      : TMovimentoDetalhe;
    _TipoPedido      : String;
    _entrega         : String;
  public
    property CodMov      : Integer read getCodMov write setCodMov;
    property CodPedido   : Integer read getCodPedido write setCodPedido;
    property CodCliente  : Integer read getCodCliente write setCodCliente;
    property CodNatureza : Integer read getCodNatureza write setCodNatureza;
    property Status      : Integer read getStatus write setStatus;
    property CodUsuario  : Integer read getCodUsuario write setCodUsuario;
    property CodVendedor : Integer read getCodVendedor write setCodVendedor;
    property CodCCusto   : Integer read getCodCCusto write setCodCCusto;
    property CodFornec   : Integer read getCodFornec write setCodFornec;
    property CodOrigem   : Integer read getCodOrigem write setCodOrigem;
    property Controle    : String  read getControle write setControle;
    property Obs         : String  read getObs write setObs;
    property Entrega     : String  read getEntrega write setEntrega;
    property DataMov     : TDateTime read getDataMov write setDataMov;
    property DataEntrega : TDateTime read getDataEntrega write setDataEntrega;
    property MovDetalhe  : TMovimentoDetalhe read getMovDetalhe write setMovDetalhe;
    property TipoPedido  : String  read getTipoPedido write setTipoPedido;
    //Metodos
    function inserirMovimento(CodMovI: Integer): Integer;
    function verMovimento(Controle_mov: String; Campo: String; Tipo: String; codNat: Integer): Integer;
    function excluirMovimento(codMovE: Integer): Boolean;
    function alterarMovimento(codMovA: Integer): Boolean;
    constructor Create;
    Destructor Destroy; Override;
  end;
implementation

uses udmpdv;

{ TMovimento }

function TMovimento.getCodCCusto: Integer;
begin
  if (dmPdv.usaCentroCusto = 'S') then
    Result := _codCCusto
  else
    Result := StrToInt(dmPdv.ccusto_padrao);
end;

function TMovimento.getCodCliente: Integer;
begin
  Result := _codCliente;
end;

function TMovimento.getCodFornec: Integer;
begin
  Result := _codFornec;
end;

function TMovimento.getCodMov: Integer;
begin
  Result := _codMov;
end;

function TMovimento.getCodNatureza: Integer;
begin
  Result := _codNatureza;
end;

function TMovimento.getCodOrigem: Integer;
begin
  Result := _codOrigem;
end;

function TMovimento.getCodPedido: Integer;
begin
  Result := _codPedido;
end;

function TMovimento.getCodUsuario: Integer;
begin
  Result := _codUsuario;
end;

function TMovimento.getCodVendedor: Integer;
begin
  Result := _codVendedor;
end;

function TMovimento.getControle: String;
begin
  Result := _controle;
end;

function TMovimento.getDataEntrega: TDateTime;
begin
  Result := _dataEntrega;
end;

function TMovimento.getDataMov: TDateTime;
begin
  Result := _dataMov;
end;

function TMovimento.getEntrega: String;
begin
  Result := _entrega;
end;

function TMovimento.getMovDetalhe: TMovimentoDetalhe;
begin
  Result := _movDetalhe;
end;

function TMovimento.getObs: String;
begin
  Result := _obs;
end;

function TMovimento.getStatus: Integer;
begin
  Result := _status;
end;

function TMovimento.getTipoPedido: String;
begin
  Result := _TipoPedido;
end;

procedure TMovimento.setCodCCusto(AValue: Integer);
begin
  _codCCusto := AValue;
end;

procedure TMovimento.setCodCliente(AValue: Integer);
begin
  _codCliente := AValue;
end;

procedure TMovimento.setCodFornec(AValue: Integer);
begin
  _codFornec := AValue;
end;

procedure TMovimento.setCodMov(AValue: Integer);
begin
  _codMov := AValue;
end;

procedure TMovimento.setCodNatureza(AValue: Integer);
begin
  _codNatureza := AValue;
end;

procedure TMovimento.setCodOrigem(AValue: Integer);
begin
  _codOrigem := AValue;
end;

procedure TMovimento.setCodPedido(AValue: Integer);
begin
  _codPedido := AValue;
end;

procedure TMovimento.setCodUsuario(AValue: Integer);
begin
  _codUsuario := AValue;
end;

procedure TMovimento.setCodVendedor(AValue: Integer);
begin
 _codVendedor := AValue;
end;

procedure TMovimento.setControle(AValue: String);
begin
  _controle := Trim(AValue);
end;

procedure TMovimento.setDataEntrega(AValue: TDateTime);
begin
  _dataEntrega := AValue;
end;

procedure TMovimento.setDataMov(AValue: TDateTime);
begin
  _dataMov := AValue;
end;

procedure TMovimento.setEntrega(AValue: String);
begin
  _entrega := AValue;
end;

procedure TMovimento.setMovDetalhe(AValue: TMovimentoDetalhe);
begin
  _movDetalhe := AValue;
end;

procedure TMovimento.setObs(AValue: String);
begin
  _obs := AValue;
end;

procedure TMovimento.setStatus(AValue: Integer);
begin
  _status := AValue;
end;

procedure TMovimento.setTipoPedido(AValue: String);
begin
  _TipoPedido := AValue;
end;

function TMovimento.inserirMovimento(CodMovI: Integer): Integer;
var str: String;
begin
  // Inserindo o Movimento
  _codMov := CodMovI;
  if (Self.CodMov = 0) then
  begin
    if (dmPdv.sqGenerator.Active) then
      dmPdv.sqGenerator.Close;
    dmPdv.sqBusca.SQL.Clear;
    dmPdv.sqGenerator.SQL.Text := 'SELECT CAST(GEN_ID(GENMOV, 1) AS INTEGER) ' +
      'AS CODIGO FROM RDB$DATABASE';
    dmPdv.sqGenerator.Open;
    _codMov := dmPdv.sqGenerator.Fields[0].AsInteger;
    dmPdv.sqGenerator.Close;
  end;
  str := 'INSERT INTO MOVIMENTO (CODMOVIMENTO, DATAMOVIMENTO, CODCLIENTE, ';
  str := str + 'CODNATUREZA, STATUS, CODUSUARIO, CODVENDEDOR, CODALMOXARIFADO, ';
  str := str + 'CODFORNECEDOR, DATA_SISTEMA, CONTROLE, CODPEDIDO, DATA_ENTREGA, ';
  str := str + 'OBS, CODORIGEM, TIPO_PEDIDO, ENTREGA) VALUES (';
  str := str + IntToStr(Self.CodMov) + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',Self.DataMov));
  str := str + ', ' + IntToStr(Self.CodCliente) + ', ' + IntToStr(Self.CodNatureza);
  str := str + ', ' + IntToStr(Self.Status) + ', ' + IntToStr(Self.CodUsuario);
  str := str + ', ' + IntToStr(Self.CodVendedor) + ', ' + IntToStr(Self.CodCCusto);
  str := str + ', ' + IntToStr(Self.CodFornec) + ', CURRENT_TIMESTAMP ';
  str := str + ', ' + QuotedStr(Self.Controle) + ', ' + IntToStr(Self.CodPedido);
  if (Self.DataEntrega > 0) then
    str := str + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',Self.DataEntrega))
  else
    str := str + ', null';
  str := str + ', ' + QuotedStr(Self.Obs);
  str := str + ', ' + IntToStr(Self.CodOrigem);
  str := str + ', ' + QuotedStr(Self.TipoPedido);
  str := str + ', ' + QuotedStr(Self.Entrega);
  str := str + ')';
  if (dmPdv.executaSql(str)) then
    Result := Self.CodMov
  else
    Result := 0;

end;

function TMovimento.verMovimento(Controle_mov: String; Campo: String; Tipo: String;
  codNat: Integer): Integer;
var sql_str: String;
begin
  Try
    Result := 0;

    With dmPdv.sqBusca do begin
      Close;
      Clear;
      sql_str := 'SELECT * FROM MOVIMENTO';
      if (Tipo = 'INTEGER') then
      begin
        sql_str := sql_str + ' WHERE ' + Campo + ' = ' + Controle_mov;
      end;
      if (Tipo = 'STRING') then
      begin
        sql_str := sql_str + ' WHERE ' + Campo + ' = ' + QuotedStr(Controle_mov);
      end;
      sql_str := sql_str + '   AND CODNATUREZA  = ' + IntToStr(codNat);
      SQL.Text := sql_str;
      Open;
    end;

    if (dmPdv.sqBusca.RecordCount > 0) then
    begin
      Self.CodMov        := dmPdv.sqBusca.FieldByName('CODMOVIMENTO').AsInteger;
      Self.CodPedido     := dmPdv.sqBusca.FieldByName('CODPEDIDO').AsInteger;
      Self.CodCliente    := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
      Self.CodFornec     := dmPdv.sqBusca.FieldByName('CODFORNECEDOR').AsInteger;
      Self.CodUsuario    := dmPdv.sqBusca.FieldByName('CODUSUARIO').AsInteger;
      Self.CodVendedor   := dmPdv.sqBusca.FieldByName('CODVENDEDOR').AsInteger;
      Self.CodNatureza   := dmPdv.sqBusca.FieldByName('CODNATUREZA').AsInteger;
      Self.Status        := dmPdv.sqBusca.FieldByName('STATUS').AsInteger;
      Self.CodCCusto     := dmPdv.sqBusca.FieldByName('CODALMOXARIFADO').AsInteger;
      Self.Controle      := dmPdv.sqBusca.FieldByName('CONTROLE').AsString;
      Self.DataMov       := dmPdv.sqBusca.FieldByName('DATAMOVIMENTO').AsDateTime;
      Result := Self.CodMov;
    end
    else
      //ShowMessage('Registro não encontrado');
      Result := 0;
  Except
    on E : Exception do
      ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
  end;
end;

function TMovimento.excluirMovimento(codMovE: Integer): Boolean;
begin
  if (dmPdv.executaSql('DELETE FROM MOVIMENTO WHERE CODMOVIMENTO = ' + IntToStr(codMovE))) then
    Result := True
  else
    Result := False;
end;

function TMovimento.alterarMovimento(codMovA: Integer): Boolean;
var sqlAltera : String;
begin
  sqlAltera := 'UPDATE MOVIMENTO SET ';
  sqlAltera := sqlAltera + '  DATAMOVIMENTO = ' + QuotedStr(FormatDateTime('mm/dd/yyyy',Self.DataMov));
  sqlAltera := sqlAltera + ', CODCLIENTE    = ' + IntToStr(Self.CodCliente);
  sqlAltera := sqlAltera + ', STATUS        = ' + IntToStr(Self.Status);
  sqlAltera := sqlAltera + ', CODVENDEDOR   = ' + IntToStr(Self.CodVendedor);
  sqlAltera := sqlAltera + ', CONTROLE      = ' + QuotedStr(Self.Controle);
  sqlAltera := sqlAltera + ', OBS           = ' + QuotedStr(Self.Obs);
  sqlAltera := sqlAltera + ' WHERE CODMOVIMENTO = ' + IntToStr(codMovA);
  if (dmPdv.executaSql(sqlAltera)) then
    Result := True
  else
    Result := False;
end;

constructor TMovimento.Create;
begin
  _movDetalhe := TMovimentoDetalhe.Create;
end;

destructor TMovimento.Destroy;
begin
  _movDetalhe.Destroy;
  inherited Destroy;
end;

end.

