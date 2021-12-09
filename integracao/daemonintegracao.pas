unit daemonIntegracao;

{$mode objfpc}{$H+}

interface

uses
  Interfaces, Classes, SysUtils, ExtCtrls, udmpdv, DaemonApp, fpjson, fphttpclient;

type

  { TdExecutaIntegracao }

  TdExecutaIntegracao = class(TDaemon)
    Timer1: TTimer;
    procedure DataModuleCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
    function busca_ultimo_integrado: String;
  end;

var
  dExecutaIntegracao: TdExecutaIntegracao;

implementation

procedure RegisterDaemon;
begin
  RegisterDaemonClass(TdExecutaIntegracao)
end;

{$R *.lfm}

{ TdExecutaIntegracao }

procedure TdExecutaIntegracao.Timer1Timer(Sender: TObject);
var integracao_log:TextFile;
 Path_log: String;
 ultimo : string;
begin
  Path_log := 'C:\home\log_integracao.txt';
  // executa integracao
  AssignFile(integracao_log,Path_log);
  Try
    Rewrite(integracao_log);
    Writeln('Executando integracao : ',DateTimeToStr(Now));
    // buscando no odoo o ultimo integrado
    ultimo := busca_ultimo_integrado;
    {dmPdv.sqBusca.SQL.Add('SELECT FIRST 10 m.CODMOVIMENTO, m.DATAMOVIMENTO, '+
    ' m.CODCLIENTE, m.CODNATUREZA, m.STATUS, m.CODUSUARIO, m.CODVENDEDOR, '+
    ' m.CODALMOXARIFADO, m.CONTROLE, m.OBS, m.USUARIOLOGADO, '+
    ' m.DESCONTO, a.CODDETALHE, a.CONTROLE, a.CODPRODUTO, '+
    ' a.QUANTIDADE, a.PRECO, a.ICMS, a.UN, a.QTDE_ALT, a.BAIXA, a.VALTOTAL,' +
    ' a.DESCPRODUTO, a.CST, a.VALOR_ICMS, a.VLR_BASE, a.CODIGO, ' +
    ' a.STATUS, a.VLR_BASEICMS, a.PIPI, a.VIPI, a.CFOP, a.CSOSN, ' +
    ' a.VALOR_DESCONTO, a.VALOR_SEGURO, a.VALOR_OUTROS, a.OBS OBS_MD, ' +
    ' a.VALOR_PIS, a.VALOR_COFINS, a.II, a.CSTIPI,' +
    ' a.CSTPIS, a.CSTCOFINS, a.PPIS, a.PCOFINS, a.NITEMPED, ' +
    ' a.DESCONTO_BC, a.VLRBC_IPI, a.VLRBC_PIS, ' +
    ' a.VLRBC_COFINS, a.VLRTOT_TRIB, p.ORIGEM, p.NCM, a.ALIQ_CUPOM, '+
    ' a.CEST, p.ESTOQUEATUAL, p.COD_BARRA, p.TIPO, p.CODPRO, '+
    ' p.USA, p.LOCALIZACAO,  p.TIPOPRECOVENDA, p.UNIDADEMEDIDA, ' +
    ' a.ORIGEM, p.OBS OBS_PROD, p.CEST, p.PRECOATACADO, p.QTDEATACADO,' +
    ' (COALESCE(A.VALTOTAL,0) - COALESCE(A.VALOR_DESCONTO, 0)) AS TOTALITEM ,' +
    ' a.ICMS_SUBST, c.NOMECLIENTE, p.RATEIO, m.DATA_SISTEMA ' +
    ' FROM MOVIMENTO m INNER JOIN CLIENTES c ON  c.CODCLIENTE = m.CODCLIENTE ' +
    ' LEFT OUTER JOIN MOVIMENTODETALHE a ON M.CODMOVIMENTO = a.CODMOVIMENTO ' +
    ' LEFT OUTER JOIN PRODUTOS P ON a.CODPRODUTO = P.CODPRODUTO ' +
    ' WHERE ((a.STATUS = '0') or (a.STATUS is null)) ' +
    ' ORDER BY m.CODMOVIMENTO DESC, a.NITEMPED');
    dmPdv.sqBusca.Open;
    // faco um loop testando se existe no odoo
    While not sqBusca.EOF do
    begin
      verifica_se_existe_odoo(sqBusca
    end;
    }
    Writeln(integracao_log,'Some Data');
  Finally
    CloseFile(integracao_log);
  End;
end;

procedure TdExecutaIntegracao.DataModuleCreate(Sender: TObject);
begin
  busca_ultimo_integrado;
end;

function TdExecutaIntegracao.busca_ultimo_integrado: String;
Var
 postJson: TJSONObject;
 responseData: String;
begin
  postJson := TJSONObject.Create;
  postJson.Add('title', 'Consultando ultimo pedido');
  With TFPHttpClient.Create(Nil) do
  begin
    try
      AddHeader('Content-Type', 'application/json');
      RequestBody := TStringStream.Create(postJson.AsJSON);
      responseData := Post(dmPdv.path_integra_url + '/pedidoconsulta');
      if (responseData <> 'N') then
      begin
        result := responseData;
      end
      else
        result := '0';
    finally
      Free;
    end;
  end;
  postJson.Free;


end;


initialization
  RegisterDaemon;
end.

