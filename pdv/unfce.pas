unit uNfce;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, MaskEdit,
  Buttons, StdCtrls, ExtCtrls, ComCtrls, udmpdv, ACBrNFe, ACBrNFeDANFeESCPOS,
  ACBrDANFCeFortesFr, pcnConversao, pcnConversaoNFe, ACBrDFeSSL;

type

  { TfNfce }

  TfNfce = class(TForm)
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes;
    ACBrNFeDANFeESCPOS1: TACBrNFeDANFeESCPOS;
    BitBtn1: TBitBtn;
    btnFechar: TBitBtn;
    btnNFce: TBitBtn;
    btnNFce1: TBitBtn;
    Label1: TLabel;
    edCPF: TMaskEdit;
    edCertificado: TLabeledEdit;
    edNFce: TLabeledEdit;
    MemoDados: TMemo;
    MemoResp: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnNFceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure GerarNFCe(Num: String);
    procedure prepararImpressao();
  public

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
begin

end;

procedure TfNfce.FormShow(Sender: TObject);
begin
end;

procedure TfNfce.GerarNFCe(Num: String);
var serie_nfce: String;
 num_nfe: Integer;
begin
  // gerar nfce
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

end;

procedure TfNfce.prepararImpressao();
begin
  //imprimir

end;

procedure TfNfce.BitBtn1Click(Sender: TObject);
begin
  edCertificado.Text := ACBrNFe1.SSL.SelecionarCertificado;
end;

end.

