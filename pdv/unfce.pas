unit uNfce;

{$mode objfpc}{$H+}

interface

uses
  Classes, typinfo, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  MaskEdit, Buttons, StdCtrls, ExtCtrls, ComCtrls, udmpdv, ACBrNFe,
  ACBrNFeDANFeESCPOS, ACBrDANFCeFortesFr, pcnConversao, pcnConversaoNFe,
  ACBrDFeSSL, ACBrPosPrinter, ACBrIntegrador , ACBrValidador, ACBrUtil, StrUtils;

type

  { TfNfce }

  TfNfce = class(TForm)
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes;
    ACBrNFeDANFeESCPOS1: TACBrNFeDANFeESCPOS;
    ACBrValidador1: TACBrValidador;
    BitBtn1: TBitBtn;
    btnFechar: TBitBtn;
    btnNFce: TBitBtn;
    btnNFce1: TBitBtn;
    cbxModeloPosPrinter: TComboBox;
    Label1: TLabel;
    edCPF: TMaskEdit;
    edCertificado: TLabeledEdit;
    edNFce: TLabeledEdit;
    MemoDados: TMemo;
    MemoResp: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure ACBrNFe1AntesDeAssinar(var ConteudoXML: String; const docElement,
      infElement, SignatureNode, SelectionNamespaces, IdSignature: String);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnNFceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function RemoveChar(Const Texto:String):String;
    procedure GerarNFCe(Num: String);
    procedure prepararImpressao();
    procedure pegaTributos(codMov: Integer; codProd: Integer);
    procedure pegaItens();
  public
    nfce_valor: Double;
    nfce_desconto: Double;
  end;

var
  fNfce: TfNfce;

implementation

{$R *.lfm}

{ TfNfce }

procedure TfNfce.btnNFceClick(Sender: TObject);
var
 vAux, vNumLote, vSincrono : String;
 Sincrono : boolean;
 Protocolo, Recibo: String;
 str: String;
begin
  if (dmPdv.tk = '') then
  begin
    ShowMessage('Cadastre: '+#13+#10+''+#13+#10+'Natureza Operação : 30 ' +
      'para Nota Fiscal Consumidor;'+#13+#10+''+#13+#10+'Série :' +
      'para ser usada na NFCe;'+#13+#10+''+#13+#10+'Parametro: ' +
      'SERIENFCe com a série criada no campo D1.');
    exit;
  end;

  if (edCPF.Text = '   .   .   -  ') then
  begin
    if MessageDlg('DESEJA CPF NA NOTA ?', mtConfirmation,
      [mbYes, mbNo, mbIgnore],0) = mrYes then
    begin
      edCPF.SetFocus;
      Exit;
    end;
  end;
  if (edCertificado.Text = '') then
  begin
    MessageDlg('Informe o certificado.',mtError,[mbok],0);
    exit;
  end;

  vAux := edNFCe.Text;
  //if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
  //  exit;

  //if not(InputQuery('WebServices Enviar', 'Numero do Lote', vNumLote)) then
  //  exit;

  vSincrono := '1';
  Sincrono := True;
  //if not(InputQuery('WebServices Enviar', 'Envio Síncrono(1=Sim, 0=Não)', vSincrono)) then
  //  exit;

  vNumLote := '1';

  if Trim(vNumLote) = '' then
  begin
    MessageDlg('Número do Lote inválido.',mtError,[mbok],0);
    exit;
  end;

  if (Trim(vSincrono) <> '1') and
     (Trim(vSincrono) <> '0') then
  begin
     MessageDlg('Valor Inválido.',mtError,[mbok],0);
     exit;
  end;
  Sincrono := False;

  // carlos 23/12/14
  ACBrNFe1.Configuracoes.Geral.ModeloDF := moNFCe;
  ACBrNFe1.Configuracoes.Geral.VersaoDF := ve400;

  ACBrNFe1.Configuracoes.Geral.IdCSC := dmPdv.id_tk;
  ACBrNFe1.Configuracoes.Geral.CSC := dmPdv.tk;

  ACBrNFe1.Configuracoes.Geral.SSLLib := libCapicom;

  // TODO
  GerarNFCe(vAux);

  AcbrNfe1.Configuracoes.Arquivos.PathSalvar := dmpdv.path_exe + '\NFce\';

  //edtCaminho.Text := ACBrNFe1.SSL.CertCNPJ;
  ACBrNFe1.NotasFiscais.Assinar;
  ACBrNFe1.NotasFiscais.Validar;
  //LoadXML(ACBrNFe1.NotasFiscais.Items[0].XML,  mRecebido);

  // TODO
  prepararImpressao();
  ACBrNFe1.DANFE := ACBrNFeDANFCeFortes1;

  //ACBrNFe1.DANFE.TipoDANFE := tiNFCeA4;

  ACBrNFe1.Enviar(vNumLote,True,Sincrono);

  MemoResp.Lines.Add(UTF8Encode(ACBrNFe1.WebServices.Retorno.RetWS));
  memoResp.Lines.Add(UTF8Encode(ACBrNFe1.WebServices.Retorno.RetornoWS));

  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Envio NFe');
  MemoDados.Lines.Add('tpAmb: '+ TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb));
  MemoDados.Lines.Add('verAplic: '+ ACBrNFe1.WebServices.Retorno.verAplic);
  MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cStat));
  MemoDados.Lines.Add('cUF: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cUF));
  MemoDados.Lines.Add('xMotivo: '+ ACBrNFe1.WebServices.Retorno.xMotivo);
  MemoDados.Lines.Add('cMsg: '+ IntToStr(ACBrNFe1.WebServices.Retorno.cMsg));
  MemoDados.Lines.Add('xMsg: '+ ACBrNFe1.WebServices.Retorno.xMsg);
  MemoDados.Lines.Add('Recibo: '+ ACBrNFe1.WebServices.Retorno.Recibo);
  MemoDados.Lines.Add('Protocolo: '+ ACBrNFe1.WebServices.Retorno.Protocolo);

  ShowMessage('Nº do Protocolo de envio ' + ACBrNFe1.WebServices.Retorno.Protocolo);
  ShowMessage('Nº do Recibo de envio ' + ACBrNFe1.WebServices.Retorno.Recibo);

  Protocolo := ACBrNFe1.WebServices.Retorno.Protocolo;
  Recibo := ACBrNFe1.WebServices.Retorno.Recibo;
  //LoadXML(ACBrNFe1.NotasFiscais.Items[0].XML,  mRecebido);
  //ACBrNFe1.NotasFiscais.Imprimir;

  try
    str := 'UPDATE NOTAFISCAL SET ';
    str := str + ' XMLNFE = ' + quotedStr(ACBrNFe1.NotasFiscais.Items[0].XML);
    str := str + ', NOMEXML = ' + QuotedStr(copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
      (length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml');
    str := str + ', STATUS = ' + QuotedStr('E');
    if (Protocolo <> '') then
      str := str + ', PROTOCOLOENV = ' + quotedStr(Protocolo);
    if (Recibo <> '') then
      str := str + ', NUMRECIBO = ' + QuotedStr(Recibo);
    str := str + ' WHERE NUMNF = ' + edNFce.Text;
    dmPdv.IbCon.ExecuteDirect(str);
    dmPdv.sTrans.Commit;
  except
    on E : Exception do
    begin
      ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
      dmPdv.sTrans.Rollback; //on failure, undo the changes}
    end;
  end;
  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Nota Fiscal Consumidor, gerada com sucesso.');
  MemoDados.Lines.Add('');
  ACBrNFe1.NotasFiscais.Clear;
end;

procedure TfNfce.FormCreate(Sender: TObject);
var  N: TACBrPosPrinterModelo;
begin
  ACBrNFeDANFeESCPOS1 := TACBrNFeDANFeESCPOS.Create(nil);
  ACBrNFeDANFCeFortes1 := TACBrNFeDANFCeFortes.Create(nil);
  cbxModeloPosPrinter.Items.Clear ;
  For N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
     cbxModeloPosPrinter.Items.Add(GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(N) ) ) ;

end;

procedure TfNfce.FormDestroy(Sender: TObject);
begin
  ACBrNFeDANFeESCPOS1.Destroy;
  ACBrNFeDANFCeFortes1.Destroy;
end;

procedure TfNfce.FormShow(Sender: TObject);
begin

end;

function TfNfce.RemoveChar(const Texto: String): String;
var
  I: integer;
  S: string;
begin
  S := '';
  for I := 1 To Length(Texto) Do
  begin
    if (Texto[I] in ['0'..'9']) then
    begin
     S := S + Copy(Texto, I, 1);
    end;
  end;
  result := S;

end;

procedure TfNfce.GerarNFCe(Num: String);
var serie_nfce: String;
 num_nfe: Integer;
 tributos :string;
 vlr : Double;
begin
  // gerar nfce
  // usando no CODSERIE o CODUSUARIO .. pra pegar a SERIE por USUARIO
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT * FROM SERIES WHERE CODSERIE = ' +
    dmPdv.varLogado;
  dmPdv.sqBusca.Open;
  if dmPdv.sqBusca.IsEmpty then
  begin
    ShowMessage('Série não cadastrada para o Usuario deste Caixa.');
    Exit;
  end;
  serie_nfce := dmPdv.sqBusca.FieldByName('SERIE').AsString;
  num_nfe := dmPdv.sqBusca.FieldByName('ULTIMO_NUMERO').AsInteger+1;

  if (dmPdv.sqEmpresa.Active) then
    dmPdv.sqEmpresa.Close;
  ////dmPdv.sqEmpresa.Params[0].AsInteger := dm.CCustoPadrao; //Buscar de parametro
  dmPdv.sqEmpresa.Open;

  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    Ide.cNF       := num_nfe; //Caso não seja preenchido será gerado um número aleatório pelo componente
    Ide.natOp     := 'VENDA';
    ////if (chkAvista.Checked) then
      Ide.indPag    := ipVista;
    ////else
     //// Ide.indPag    := ipPrazo;
    Ide.modelo    := 65;
    Ide.serie     := 1;
    Ide.nNF       := num_nfe;
    Ide.dEmi      := now;
    Ide.dSaiEnt   := now;
    Ide.hSaiEnt   := now;
    Ide.tpNF      := tnSaida;
    Ide.tpEmis    := teNormal;
    ////Ide.tpEmis    := TpcnTipoEmissao(cbFormaEmissao.ItemIndex); ;
    if(dmPdv.sqEmpresaTIPO.AsInteger = 1) then
      Ide.tpAmb := taHomologacao
    else
      Ide.tpAmb := taProducao;

    Ide.cUF       := 35; // SP
    Ide.cMunFG    := StrToInt(RemoveChar(dmPdv.sqEmpresaCD_IBGE.AsString));
    Ide.finNFe    := fnNormal;
    Ide.tpImp     := tiNFCe;
    Ide.indFinal  := cfConsumidorFinal;
    Ide.indPres   := pcPresencial;
    //autXML.Add.CNPJCPF := RemoveChar(sEmpresaCNPJ_CPF.AsString);

    //     Ide.dhCont := date;
    //     Ide.xJust  := 'Justificativa Contingencia';
    ////label8.Caption := RemoveChar(dmPdv.sqEmpresaCNPJ_CPF.AsString);
    Emit.CNPJCPF           := RemoveChar(dmPdv.sqEmpresaCNPJ_CPF.AsString);
    Emit.IE                := RemoveChar(dmPdv.sqEmpresaIE_RG.AsString);
    Emit.xNome             := dmPdv.sqEmpresaRAZAO.AsString;
    Emit.xFant             := dmPdv.sqEmpresaEMPRESA.AsString;
    Emit.EnderEmit.fone    := RemoveChar(dmPdv.sqEmpresaDDD.AsString + dmPdv.sqEmpresaFONE.AsString);
    Emit.EnderEmit.CEP     := StrToInt(RemoveChar(dmPdv.sqEmpresaCEP.AsString));
    Emit.EnderEmit.xLgr    := dmPdv.sqEmpresaENDERECO.AsString;
    Emit.EnderEmit.nro     := dmPdv.sqEmpresaNUMERO.AsString;
    Emit.EnderEmit.xCpl    := dmPdv.sqEmpresaLOGRADOURO.AsString;
    Emit.EnderEmit.xBairro := dmPdv.sqEmpresaBAIRRO.AsString;
    Emit.EnderEmit.cMun    := StrToInt(RemoveChar(dmPdv.sqEmpresaCD_IBGE.AsString));
    Emit.EnderEmit.xMun    := dmPdv.sqEmpresaCIDADE.AsString;
    Emit.EnderEmit.UF      := dmPdv.sqEmpresaUF.AsString;
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';

    Emit.IEST              := '';


    //case rgRegime.ItemIndex of
    Emit.CRT := crtSimplesNacional;// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)
    //  1: Emit.CRT := crtSimplesExcessoReceita;
    //  2: Emit.CRT := crtRegimeNormal;
    //end;

    if (edCPF.Text = '   .   .   -  ') then
    begin
      Dest.CNPJCPF := RemoveChar(edCPF.Text);
      Dest.indIEDest := inNaoContribuinte;
      Dest.EnderDest.cPais := 1058;
    end;

    pegaItens;

    {  TpcnFormaPagamento = (fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito, fpCreditoLoja,
                        fpValeAlimentacao, fpValeRefeicao, fpValePresente, fpValeCombustivel,
                        fpOutro}
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := 'SELECT CODFORMA, COD_VENDA, ID_ENTRADA, FORMA_PGTO' +
    ' , CAIXA , N_DOC, VALOR_PAGO, CAIXINHA, TROCO, DESCONTO, STATE' +
    ' FROM FORMA_ENTRADA WHERE STATE < 2 AND ID_ENTRADA = ' +
    InttoStr(dmPdv.sqLancamentosCODMOVIMENTO.AsInteger);
  dmPdv.sqBusca.Open;

    while not dmPdv.sqBusca.EOF do
    begin
      with pag.Add do
      begin
        tPag := fpCreditoLoja;
        if (dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString = '1') then
          tPag := fpDinheiro
        else if (dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString = '3') then
          tPag := fpCartaoCredito
        else if dmPdv.sqBusca.FieldByName('FORMA_PGTO').AsString = '2' then
          tPag := fpCartaoDebito
        else
          tPag := fpOutro;

        vPag := dmPdv.sqBusca.FieldByName('VALOR_PAGO').AsFloat;
      end;
      dmPdv.sqBusca.Next;
    end;



    pegaTributos(dmPdv.sqLancamentosCODMOVIMENTO.AsInteger, 0);
    if (not dmPdv.sqBusca.IsEmpty)  then
    begin
      vlr :=  dmPdv.sqBusca.FieldByName('TRIB_EST').AsFloat;
      vlr :=  dmPdv.sqBusca.FieldByName('TRIB_FED').AsFloat;
      tributos := 'Trib aprox R$:' +
        format('%8.2n', [dmPdv.sqBusca.FieldByName('TRIB_FED').AsFloat]) + '-Fed, ' +
        format('%8.2n', [dmPdv.sqBusca.FieldByName('TRIB_EST').AsFloat]) + '-Est e ' +
        format('%8.2n', [dmPdv.sqBusca.FieldByName('TRIB_MUN').AsFloat]) + '-Mun ';
      InfAdic.infCpl := tributos + 'Fonte: IBPT';//Fonte: IBPT/FECOMERCIO RJ Xe67eQ
      // DESCOMENTAR #################################
      ACBrNFeDANFCeFortes1.FonteTributos := 'Fonte: IBPT';
      ACBrNFeDANFCeFortes1.vTribFed := dmPdv.sqBusca.FieldByName('TRIB_FED').AsFloat;
      ACBrNFeDANFCeFortes1.vTribEst := dmPdv.sqBusca.FieldByName('TRIB_EST').AsFloat;
      ACBrNFeDANFCeFortes1.vTribMun := dmPdv.sqBusca.FieldByName('TRIB_MUN').AsFloat;
      ACBrNFeDANFeESCPOS1.FonteTributos := 'Fonte: IBPT';
      ACBrNFeDANFeESCPOS1.vTribFed := dmPdv.sqBusca.FieldByName('TRIB_FED').AsFloat;
      ACBrNFeDANFeESCPOS1.vTribEst := dmPdv.sqBusca.FieldByName('TRIB_EST').AsFloat;
      ACBrNFeDANFeESCPOS1.vTribMun := dmPdv.sqBusca.FieldByName('TRIB_MUN').AsFloat;
    end;


      Total.ICMSTot.vBC     := 0;
      Total.ICMSTot.vICMS   := 0;
      Total.ICMSTot.vBCST   := 0;
      Total.ICMSTot.vST     := 0;
      Total.ICMSTot.vProd   := nfce_valor; //sqlBuscaNota.fieldByName('VALOR').AsFloat; // totalNFCe;
      Total.ICMSTot.vFrete  := 0;
      Total.ICMSTot.vSeg    := 0;
      Total.ICMSTot.vDesc   := nfce_desconto;
      Total.ICMSTot.vII     := 0;
      Total.ICMSTot.vIPI    := 0;
      Total.ICMSTot.vPIS    := 0;
      Total.ICMSTot.vCOFINS := 0;
      Total.ICMSTot.vOutro  := 0;
      Total.ICMSTot.vNF     := nfce_valor - nfce_desconto; //totalNFCe;

      Total.ISSQNtot.vServ   := 0;
      Total.ISSQNTot.vBC     := 0;
      Total.ISSQNTot.vISS    := 0;
      Total.ISSQNTot.vPIS    := 0;
      Total.ISSQNTot.vCOFINS := 0;



   end;
////
end;

procedure TfNfce.prepararImpressao();
begin
  //imprimir

end;

procedure TfNfce.pegaTributos(codMov: Integer; codProd: Integer);
var pegaTribSql : String;
begin
  pegaTribSql := 'SELECT CODPRODUTO ' +
    ' , TRIB_FED ' +
    ' , TRIB_EST ' +
    ' , TRIB_MUN ' +
    ' , TOT_TRIB_FED ' +
    ' , TOT_TRIB_EST ' +
    ' , TOT_TRIB_MUN ' +
    ' , FONTE ' +
    ' , CHAVE ' +
    ' FROM TOTAL_TRIBUTOS(' +
    IntToStr(codMov) + ')';
  if (codProd > 0) then
  begin
    pegaTribSql := pegaTribSql +
      ' WHERE CODPRODUTO = ' + IntToStr(codProd);
  end;
  if (codProd = 0) then
  begin
    pegaTribSql := 'SELECT ' +
      ' SUM(TRIB_FED) as TRIB_FED ' +
      ' , SUM(TRIB_EST) as TRIB_EST ' +
      ' , SUM(TRIB_MUN) as  TRIB_MUN ' +
      ' FROM TOTAL_TRIBUTOS(' +
      IntToStr(codMov) + ')';
  end;
  dmPdv.sqBusca.Close;
  dmPdv.sqBusca.SQL.Clear;
  dmPdv.sqBusca.SQL.Text := pegaTribSql;
  dmPdv.sqBusca.Open;
end;

procedure TfNfce.pegaItens();
var contaItens :integer;
  desc, BC, BCST : variant;
  totalNFCe: Double;
begin
  totalNFCe := 0;
  with ACBrNFe1.NotasFiscais.Items[0].NFe do
  begin
    with Transp do
    modFrete := mfSemFrete;
    //Adicionando Produtos
    contaItens := 0;
    dmPdv.sqLancamentos.First;
    while not dmPdv.sqLancamentos.Eof do
    begin
      totalNFCe := totalNFCe + dmPdv.sqLancamentosTOTALITEM.AsFloat;
      contaItens := contaItens + 1;
      with Det.Add do
      begin
        Prod.nItem    := contaItens; // Número sequencial, para cada item deve ser incrementado

        Prod.cProd    := dmPdv.sqLancamentosCODPRO.AsString;
        //Prod.cEAN     := '7896523206646';
        Prod.xProd    := LeftStr(dmPdv.sqLancamentosDESCPRODUTO.AsString, 99);
        Prod.CFOP     := dmPdv.sqLancamentosCFOP.AsString;
        Prod.uCom     := dmPdv.sqLancamentosUNIDADEMEDIDA.AsString;
        Prod.qCom     := dmPdv.sqLancamentosQUANTIDADE.AsFloat;
        Prod.vUnCom   := dmPdv.sqLancamentosPRECO.AsFloat;
        Prod.uTrib    := dmPdv.sqLancamentosUNIDADEMEDIDA.AsString;
        Prod.qTrib    := dmPdv.sqLancamentosQUANTIDADE.AsFloat;
        Prod.vUnTrib  := dmPdv.sqLancamentosPRECO.AsFloat;

        Prod.NCM      := dmPdv.sqLancamentosNCM.AsString;
        Prod.EXTIPI   := '';

        // TODO instalar VALIDADDOR
        if (EAN13Valido(dmPdv.sqLancamentosCOD_BARRA.AsString)) then
        begin
          Prod.cEAN := dmPdv.sqLancamentosCOD_BARRA.AsString;
          Prod.cEANTrib := dmPdv.sqLancamentosCOD_BARRA.AsString;;
        end;
        desc := StrLen(PChar(MidStr(dmPdv.sqLancamentosDESCPRODUTO.AsString, 100, 200)));
        if ( desc > 0) then
          infAdProd     := MidStr(dmPdv.sqLancamentosDESCPRODUTO.AsString, 100, 200)  +
                           dmPdv.sqLancamentosOBS.AsString
        else
          infAdProd     := dmPdv.sqLancamentosOBS.AsString;

        Prod.vProd    := dmPdv.sqLancamentosTOTALITEM.AsFloat;
        Prod.vFrete   := 0 ; //dmPdv.sqLancamentosFRETE.AsCurrency;
        Prod.vDesc    := dmPdv.sqLancamentosVALOR_DESCONTO.AsCurrency;
        Prod.vOutro   := dmPdv.sqLancamentosVALOR_OUTROS.AsCurrency;
        Prod.vSeg     := dmPdv.sqLancamentosVALOR_SEGURO.AsCurrency;

        with Imposto do
        begin
          // lei da transparencia nos impostos
          vTotTrib := dmPdv.sqLancamentosVLRTOT_TRIB.AsFloat;
          // ***********************  ICMS ********************************
          with ICMS do
          begin
            if (dmPdv.sqLancamentosORIGEM.IsNull) then
            begin
              MessageDlg('Origem do Produto(CADASTRO PRODUTO) não informado, Cod. Prod: ' +
                          dmPdv.sqLancamentosCODPRO.AsString, mtError, [mbOK], 0);
              //exit;
            end;

            if( dmPdv.sqEmpresaCRT.AsInteger = 0) then
            begin
              if ((dmPdv.sqLancamentosCSOSN.AsString = null) or ( dmPdv.sqLancamentosCSOSN.AsString = '')) then
              begin
                CSOSN := csosnVazio;
              end
              else if (dmPdv.sqLancamentosCSOSN.AsString = '101') then
              begin
                CSOSN := csosn101;
                if (ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional ) then
                begin
                  if (dmPdv.sqLancamentosICMS.AsVariant > 0 ) then
                  begin
                    pCredSN := dmPdv.sqLancamentosICMS.AsVariant; //Aliquota ICMS SIMPLES
                    vCredICMSSN := dmPdv.sqLancamentosVALOR_ICMS.AsVariant; //ICMS SIMPLES
                  end;
                end;
              end
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '102') then
                CSOSN := csosn102
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '103') then
                CSOSN := csosn103
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '201') then
              begin
                CSOSN := csosn201;
                if (ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional ) then
                begin
                  if (dmPdv.sqLancamentosICMS.AsVariant > 0 ) then
                  begin
                    pCredSN := dmPdv.sqLancamentosICMS.AsVariant; //Aliquota ICMS SIMPLES
                    vCredICMSSN := dmPdv.sqLancamentosVALOR_ICMS.AsVariant; //ICMS SIMPLES
                  end;
                end;
              end
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '202') then
                CSOSN := csosn202
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '203') then
                CSOSN := csosn203
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '300') then
                CSOSN := csosn300
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '400') then
                CSOSN := csosn400
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '500') then
                CSOSN := csosn500
              else if ( dmPdv.sqLancamentosCSOSN.AsString = '900') then
                CSOSN := csosn900;
            end; // CRT = 0

            // CST's

            if ((Trim(dmPdv.sqLancamentosCST.AsString) = '') and (Trim(dmPdv.sqLancamentosCSOSN.AsString) = '')) then
            begin
              if ((Trim(dmPdv.sqLancamentosCSOSN.AsString) = '') or (Trim(dmPdv.sqLancamentosCSOSN.AsString) = '0')) then
                MessageDlg('CST do ICMS em branco no item ' + dmPdv.sqLancamentosDESCPRODUTO.AsString, mtWarning, [mbOK], 0);
              Exit;
            end
            else
            begin
              if ((dmPdv.sqLancamentosCST.AsString = '000') or (dmPdv.sqLancamentosCST.AsString = '100') or (dmPdv.sqLancamentosCST.AsString = '200') or (dmPdv.sqLancamentosCST.AsString = '00')) then
                CST := cst00
              else if ((dmPdv.sqLancamentosCST.AsString = '010') or (dmPdv.sqLancamentosCST.AsString = '110') or (dmPdv.sqLancamentosCST.AsString = '210') or (dmPdv.sqLancamentosCST.AsString = '10')) then
                CST := cst10
              else if ((dmPdv.sqLancamentosCST.AsString = '020') or (dmPdv.sqLancamentosCST.AsString = '120') or (dmPdv.sqLancamentosCST.AsString = '220') or (dmPdv.sqLancamentosCST.AsString = '20')) then
                CST := cst20
              else if ((dmPdv.sqLancamentosCST.AsString = '030') or (dmPdv.sqLancamentosCST.AsString = '130') or (dmPdv.sqLancamentosCST.AsString = '230') or (dmPdv.sqLancamentosCST.AsString = '30')) then
                CST := cst30
              else if ((dmPdv.sqLancamentosCST.AsString = '040') or (dmPdv.sqLancamentosCST.AsString = '140') or (dmPdv.sqLancamentosCST.AsString = '240') or (dmPdv.sqLancamentosCST.AsString = '40')) then
                CST :=  cst40
              else if ((dmPdv.sqLancamentosCST.AsString = '041') or (dmPdv.sqLancamentosCST.AsString = '141') or (dmPdv.sqLancamentosCST.AsString = '241') or (dmPdv.sqLancamentosCST.AsString = '41')) then
                CST :=  cst41
              else if ((dmPdv.sqLancamentosCST.AsString = '050') or (dmPdv.sqLancamentosCST.AsString = '150') or (dmPdv.sqLancamentosCST.AsString = '250') or (dmPdv.sqLancamentosCST.AsString = '50')) then
                CST :=  cst50
              else if ((dmPdv.sqLancamentosCST.AsString = '051') or (dmPdv.sqLancamentosCST.AsString = '151') or (dmPdv.sqLancamentosCST.AsString = '251') or (dmPdv.sqLancamentosCST.AsString = '51')) then
                CST := cst51
              else if ((dmPdv.sqLancamentosCST.AsString = '060') or (dmPdv.sqLancamentosCST.AsString = '160') or (dmPdv.sqLancamentosCST.AsString = '260') or (dmPdv.sqLancamentosCST.AsString = '60')) then
                CST := cst60
              else if ((dmPdv.sqLancamentosCST.AsString = '070') or (dmPdv.sqLancamentosCST.AsString = '170') or (dmPdv.sqLancamentosCST.AsString = '270') or (dmPdv.sqLancamentosCST.AsString = '70')) then
                CST := cst70
              else if ((dmPdv.sqLancamentosCST.AsString = '090') or (dmPdv.sqLancamentosCST.AsString = '190') or (dmPdv.sqLancamentosCST.AsString = '290') or (dmPdv.sqLancamentosCST.AsString = '90')) then
                CST := cst90
              else
                CST := cst00;
            end;

            if dmPdv.sqLancamentosORIGEM.AsString = '0' then
              orig  := oeNacional                       //ORIGEM DO PRODUTO
            else if dmPdv.sqLancamentosORIGEM.AsString = '1' then
              orig  := oeEstrangeiraAdquiridaBrasil
            else
              orig  := oeEstrangeiraImportacaoDireta;
            modBC := BC;                                              //MODO DE BASE DE CALCULO (0) POR %
            //Não carregar ICMS para Simples Nacional
            if not ((ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CRT = crtSimplesNacional) and (dmPdv.sqLancamentosCSOSN.AsString <> '900')) then
            begin
              vBC := dmPdv.sqLancamentosVLR_BASEICMS.AsVariant;                //VALOR DA BASE DE CALCULO
              pICMS := dmPdv.sqLancamentosICMS.AsVariant;                     //ALIQUOTA DO ICMS
              vICMS := dmPdv.sqLancamentosVALOR_ICMS.AsVariant;                  //VALOR DO ICMS
            end;
            modBCST :=  BCST;                                         //MODO DE BASE DE CALCULO SUBST. TRIBUTÁRIA(4) POR %
            vBCST := 0;
            if (not dmPdv.sqLancamentosICMS_SUBST.IsNull) then
              vBCST :=    dmPdv.sqLancamentosICMS_SUBST.AsVariant;                 //VALOR DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA

            if (dmPdv.sqLancamentosCFOP.AsString <> '') then
            begin
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pMVAST := 0
              else
                pMVAST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                //% MARGEM DE VALOR ADICIONADO DO ICMSST
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pRedBCST := 0
              else
                pRedBCST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                 //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pICMSST := 0
              else
                pICMSST :=  dmPdv.sqLancamentosICMS_SUBST.AsVariant;                    //ALIQUOTA DO ICMS DA SUBST. TRIBUTÁRIA
            end
            else begin
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pMVAST := 0
              else
                pMVAST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                //% MARGEM DE VALOR ADICIONADO DO ICMSST
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pRedBCST := 0
              else
                pRedBCST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                 //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO DA SUBST. TRIBUTÁRIA
              if (dmPdv.sqLancamentosICMS_SUBST.IsNull) then
                pICMSST := 0
              else
                pICMSST := dmPdv.sqLancamentosICMS_SUBST.AsVariant;                    //ALIQUOTA DO ICMS DA SUBST. TRIBUTÁRIA
            end;

            //if (sCFOPREDUCAO.IsNull) then
            pRedBC := 0;
            //else
            //  pRedBC :=   sCFOPREDUCAO.AsVariant;                          //ALIQUOTA DA REDUÇÃO DA BASE DE CALCULO
            if (dmPdv.sqLancamentosICMS_SUBST.isnull) then
              vICMSST := 0
            else
              vICMSST :=  dmPdv.sqLancamentosICMS_SUBST.AsVariant;                  //VALOR DO ICMS DA SUBST. TRIBUTÁRIA
          end;
          //ICMS.orig    := oeNacional;
          //ICMS.modBC   := dbiValorOperacao;
          //ICMS.modBCST := dbisMargemValorAgregado;

          // ***********************  FIM ICMS ********************************

          // ***********************  PIS ********************************
          with PIS do
          begin
            CST      := pis99;
            PIS.vBC  := 0;
            PIS.pPIS := 0;
            PIS.vPIS := 0;

            PIS.qBCProd   := 0;
            PIS.vAliqProd := 0;
            PIS.vPIS      := 0;
          end;
          // ***********************  FIM PIS ********************************
          with PISST do
          begin
            vBc       := 0;
            pPis      := 0;
            qBCProd   := 0;
            vAliqProd := 0;
            vPIS      := 0;
          end;

          with COFINS do
          begin
            CST            := cof99;
            COFINS.vBC     := 0;
            COFINS.pCOFINS := 0;
            COFINS.vCOFINS := 0;
            COFINS.qBCProd   := 0;
            COFINS.vAliqProd := 0;
          end;

          with COFINSST do
          begin
            vBC       := 0;
            pCOFINS   := 0;
            qBCProd   := 0;
            vAliqProd := 0;
            vCOFINS   := 0;
          end;

        end;
        end ;
      dmPdv.sqLancamentos.Next;
      end;

    end;


end;

procedure TfNfce.BitBtn1Click(Sender: TObject);
begin
  edCertificado.Text := ACBrNFe1.SSL.SelecionarCertificado;
end;

procedure TfNfce.ACBrNFe1AntesDeAssinar(var ConteudoXML: String;
  const docElement, infElement, SignatureNode, SelectionNamespaces,
  IdSignature: String);
begin

end;

end.

