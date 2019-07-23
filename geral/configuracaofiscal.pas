unit ConfiguracaoFiscal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, MaskEdit, DBGrids;

type

  { TfConfiguracaoFiscal }

  TfConfiguracaoFiscal = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    cbOrigemProd: TComboBox;
    cbIpiCst: TComboBox;
    cbCSTPis: TComboBox;
    cbCSTCofins: TComboBox;
    cbTipoFiscalF: TComboBox;
    cbTipoFiscal: TComboBox;
    cbNaoGeraFatura: TCheckBox;
    cbCST: TComboBox;
    cbCSOSN: TComboBox;
    DBGrid1: TDBGrid;
    edCfopF: TEdit;
    edCfop: TEdit;
    edDest: TMaskEdit;
    edDA1: TEdit;
    edDA2: TEdit;
    edDA3: TEdit;
    edDA4: TEdit;
    edMva: TMaskEdit;
    edNCM: TEdit;
    edOrigem: TMaskEdit;
    edProduto: TEdit;
    edPisAliq: TMaskEdit;
    edIPIAliq: TMaskEdit;
    edCofinsAliq: TMaskEdit;
    edIPIEnq: TMaskEdit;
    edFCP: TMaskEdit;
    edPIcmsUfDest: TMaskEdit;
    edPIcmsInter: TMaskEdit;
    edPIcmsPart: TMaskEdit;
    edUFF: TEdit;
    edUF: TEdit;
    gbICMSNormal: TGroupBox;
    gbCofins: TGroupBox;
    gbICMSSt: TGroupBox;
    gbPorProduto: TGroupBox;
    GroupBox1: TGroupBox;
    gbICMSSimples: TGroupBox;
    gbDifal: TGroupBox;
    gbIPI: TGroupBox;
    gbPis: TGroupBox;
    gbPorNcm: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edAliquota: TMaskEdit;
    edRBC: TMaskEdit;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    pnInfo: TPanel;
    txtProduto: TStaticText;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure cbCSOSNChange(Sender: TObject);
    procedure cbCSTChange(Sender: TObject);
    procedure cbTipoFiscalChange(Sender: TObject);
    procedure edCfopExit(Sender: TObject);
    procedure edProdutoChange(Sender: TObject);
    procedure edUFExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label27Click(Sender: TObject);
  private
    var_empresa: String;
    var_sql: String;
    tipo_cfop: Integer;
    procedure ocultarItens;
    procedure editar;
    procedure incluir;
    function validarCampos: Boolean;
  public

  end;

var
  fConfiguracaoFiscal: TfConfiguracaoFiscal;

implementation

uses udmpdv, uUtil;

{$R *.lfm}

{ TfConfiguracaoFiscal }

procedure TfConfiguracaoFiscal.FormShow(Sender: TObject);
begin
  {
  dmPdv.sqEmpresa.Open;
  // se a empresa e do simples ocultar CST ICMS
  if (dmPdv.sqEmpresaCRT.AsInteger = 0) then
  begin
    var_empresa := 'SIMPLES';
    gbICMSNormal.Visible  := False;
    gbICMSSimples.Visible := True;
  end;
  if (dmPdv.sqEmpresaCRT.AsInteger = 1) then
  begin
    var_empresa := 'SIMPLES';
    gbICMSNormal.Visible  := False;
    gbICMSSimples.Visible := True;
  end;

  if (dmPdv.sqEmpresaCRT.AsInteger = 2) then
  begin
    var_empresa := 'NORMAL';
    gbICMSNormal.Visible:=True;
    gbICMSSimples.Visible:=False;
  end;}
end;

procedure TfConfiguracaoFiscal.Label27Click(Sender: TObject);
begin
  pnInfo.Visible:=True;
end;

procedure TfConfiguracaoFiscal.ocultarItens;
begin
  if ((edUF.Text <> '') and
    (cbTipoFiscal.ItemIndex > -1) and
    (edUF.Text <> dmPdv.sqEmpresaUF.AsString) and
    (cbTipoFiscal.ItemIndex = 0))then
  begin
    gbDifal.Visible:=True;
  end;
end;

procedure TfConfiguracaoFiscal.editar;
  var executado: String;
    var_where: String;
begin
  // Editar
  var_sql := '';
  if (Trim(UpperCase(edNCM.Text)) <> 'TODOS') then
  begin
    // verifica se o NCM existe
    dmPdv.busca_sql('SELECT NCM FROM NCM where NCM = ' +
      QuotedStr(Trim(edNCM.Text)));
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('NCM não encontrado, digite um NCM válido');
      Exit;
    end;
    var_sql := 'UPDATE CLASSIFICACAOFISCALNCM SET NCM = ' +
      QuotedStr(Trim(edNCM.Text));
  end;
  if (Trim(UpperCase(edProduto.Text)) <> 'TODOS') then
  begin
    if (txtProduto.Caption = '') then
    begin
      ShowMessage('Produto não encontrado, digite um Produto válido');
      Exit;
    end;
    var_sql := 'UPDATE CLASSIFICACAOFISCALPRODUTO SET COD_PROD = ' +
      QuotedStr(Trim(edProduto.Text));
  end;
  if (var_sql = '') then
  begin
    var_sql := 'UPDATE ESTADO_ICMS SET CFOP = ' +
      QuotedStr(Trim(edCfop.Text))
  end
  else begin
    var_sql += ' ,CFOP = ' + QuotedStr(Trim(edCfop.Text));
  end;

  var_sql += ' ,UF =  ' + QuotedStr(UpperCase(Trim(edUF.Text)));
  Case cbTipoFiscal.ItemIndex of
    0: var_sql += ',CODFISCAL = ' + QuotedStr('9');
    1: var_sql += ',CODFISCAL = ' + QuotedStr('F');
    2: var_sql += ',CODFISCAL = ' + QuotedStr('G');
    3: var_sql += ',CODFISCAL = ' + QuotedStr('H');
    4: var_sql += ',CODFISCAL = ' + QuotedStr('J');
    5: var_sql += ',CODFISCAL = ' + QuotedStr('K');
    6: var_sql += ',CODFISCAL = ' + QuotedStr('L');
  end;
  var_sql += ' ,ICMS_SUBST = ' + FloatTostr(uutil.strParaFloat(edMva.Text));
  var_sql += ' ,ICMS_SUBST_IC = ' + FloatTostr(uutil.strParaFloat(edOrigem.Text));
  var_sql += ' ,ICMS_SUBST_IND = ' + FloatTostr(uutil.strParaFloat(edDest.Text));
  var_sql += ' ,ICMS = ' + FloatTostr(uutil.strParaFloat(edAliquota.Text));
  var_sql += ' ,ICMS_BASE = ' + FloatTostr(uutil.strParaFloat(edRBC.Text));
  if (cbCST.ItemIndex > -1) then
    var_sql += ',CST = 0' + Copy(cbCST.Text,0,2)
  else
    var_sql += ',CST = Null';

  if (cbCSOSN.ItemIndex > -1) then
    var_sql += ',CSOSN = ' + Copy(cbCSOSN.Text,0,3)
  else
    var_sql += ',CSOSN = Null';

  var_sql += ' ,IPI = ' + FloatTostr(uutil.strParaFloat(edIPIAliq.Text));
  if (cbIpiCst.ItemIndex > -1) then
    var_sql += ',CSTIPI = ' + Copy(cbIpiCST.Text,0,2)
  else
    var_sql += ',CSTIPI = Null';

  if (cbCSTPis.ItemIndex > -1) then
    var_sql += ',CSTPIS = ' + Copy(cbCSTPis.Text,0,2)
  else
    var_sql += ',CSTPIS = Null';

  if (cbCSTCofins.ItemIndex > -1) then
    var_sql += ',CSTCOFINS = ' + Copy(cbCSTCofins.Text,0,2)
  else
    var_sql += ',CSTCOFINS = Null';
  var_sql += ' ,PIS = ' + FloatTostr(uutil.strParaFloat(edPisAliq.Text));
  var_sql += ' ,COFINS = ' + FloatTostr(uutil.strParaFloat(edCofinsAliq.Text));
  if (cbOrigemProd.ItemIndex > -1) then
    var_sql += ',ORIGEM = ' + Copy(cbOrigemProd.Text,0,1)
  else
    var_sql += ',ORIGEM = Null';
  var_sql += ' ,DADOSADC1 = ' + QuotedStr(Trim(edDA1.Text));
  var_sql += ' ,DADOSADC2 = ' + QuotedStr(Trim(edDA2.Text));
  var_sql += ' ,DADOSADC3 = ' + QuotedStr(Trim(edDA3.Text));
  var_sql += ' ,DADOSADC4 = ' + QuotedStr(Trim(edDA4.Text));
  var_sql += ' ,PFCPUFDEST = ' + FloatTostr(uutil.strParaFloat(edFCP.Text));
  var_sql += ' ,PICMSUFDEST = ' + FloatTostr(uutil.strParaFloat(edPIcmsUfDest.Text));
  var_sql += ' ,PICMSINTER = ' + FloatTostr(uutil.strParaFloat(edPIcmsInter.Text));
  var_sql += ' ,PICMSINTERPART = ' + FloatTostr(uutil.strParaFloat(edPIcmsPart.Text));
  var_sql += ' ,CST_IPI_CENQ = ' + QuotedStr(Trim(edIPIEnq.Text));
  var_where := '';
  if (Trim(UpperCase(edNCM.Text)) <> 'TODOS') then
  begin
    var_where := ' WHERE NCM = ' + Trim(UpperCase(edNCM.Text));
  end;
  if (Trim(UpperCase(edProduto.Text)) <> 'TODOS') then
  begin
    var_where := ' WHERE COD_PROD = ' + QuotedStr(Trim(edProduto.Text));
  end;
  if (var_where = '') then
  begin
    // @@@@@@@@@@@@@@  PAREI AQUI
    //var_where := ' WHERE CODESTADO = ' + cod_estado;
  end;
  var_where += ' AND CFOP = ' + Trim(edCfop.Text);
  var_where += ' AND UF = ' + Trim(edUF.Text);
  Case cbTipoFiscal.ItemIndex of
    0: var_where += ' AND CODFISCAL = ' + QuotedStr('9');
    1: var_where += ' AND CODFISCAL = ' + QuotedStr('F');
    2: var_where += ' AND CODFISCAL = ' + QuotedStr('G');
    3: var_where += ' AND CODFISCAL = ' + QuotedStr('H');
    4: var_where += ' AND CODFISCAL = ' + QuotedStr('J');
    5: var_where += ' AND CODFISCAL = ' + QuotedStr('K');
    6: var_where += ' AND CODFISCAL = ' + QuotedStr('L');
  end;
end;

procedure TfConfiguracaoFiscal.incluir;
var executado: String;
begin
  // Incluir
  executado := 'N';
  if (Trim(UpperCase(edNCM.Text)) <> 'TODOS') then
  begin
    // verifica se o NCM existe
    dmPdv.busca_sql('SELECT NCM FROM NCM where NCM = ' +
      QuotedStr(Trim(edNCM.Text)));
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('NCM não encontrado, digite um NCM válido');
      Exit;
    end;
    var_sql := 'INSERT INTO CLASSIFICACAOFISCALNCM (NCM, CFOP, UF, ' +
      '  CODFISCAL, ICMS_SUBST, ICMS_SUBST_IC, ICMS_SUBST_IND ' +
      ', ICMS, ICMS_BASE, CST, CSOSN, IPI, ' +
      '  CSTIPI, CSTPIS, CSTCOFINS, PIS, COFINS, ' +
      '  ORIGEM, DADOSADC1, DADOSADC2, DADOSADC3, ' +
      '  DADOSADC4, DADOSADC5, DADOSADC6, ALIQ_CUPOM, ' +
      '  VBCUFDEST, PFCPUFDEST, PICMSUFDEST, ' +
      '  PICMSINTER, PICMSINTERPART, VFCPUFDEST, ' +
      '  VICMSUFDEST, VICMSUFREMET, CST_IPI_CENQ) VALUES (';
      //'  REDBASEPIS, REDBASECOFINS, REDBASEIPI, II_PERCENTUAL) ' +
      //'  VALUES (';
    var_sql += QuotedStr(Trim(edNCM.Text));
    var_sql += ',' + QuotedStr(Trim(edCfop.Text));
    var_sql += ',' + QuotedStr(UpperCase(Trim(edUF.Text)));
    Case cbTipoFiscal.ItemIndex of
      0: var_sql += ', ' + QuotedStr('9');
      1: var_sql += ', ' + QuotedStr('F');
      2: var_sql += ', ' + QuotedStr('G');
      3: var_sql += ', ' + QuotedStr('H');
      4: var_sql += ', ' + QuotedStr('J');
      5: var_sql += ', ' + QuotedStr('K');
      6: var_sql += ', ' + QuotedStr('L');
    end;
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edMva.Text));
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edOrigem.Text));
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edDest.Text));
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edAliquota.Text)); // ICMS
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edRBC.Text)); // ICMS_BASE

    if (cbCST.ItemIndex > -1) then
      var_sql += ', 0' + Copy(cbCST.Text,0,2)
    else
      var_sql += ', Null';

    if (cbCSOSN.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbCSOSN.Text,0,3)
    else
      var_sql += ', Null';

    var_sql += ',' + FloatTostr(uutil.strParaFloat(edIPIAliq.Text)); // IPI

    if (cbIpiCst.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbIpiCST.Text,0,2)
    else
      var_sql += ', Null';

    if (cbCSTPis.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbCSTPis.Text,0,2)
    else
      var_sql += ', Null';

    if (cbCSTCofins.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbCSTCofins.Text,0,2)
    else
      var_sql += ', Null';

    if (cbOrigemProd.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbOrigemProd.Text,0,1)
    else
      var_sql += ', Null';

    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPisAliq.Text)); // PIS
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edCofinsAliq.Text)); // COFINS

    //ORIGEM
    if (cbOrigemProd.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbOrigemProd.Text,0,1)
    else
      var_sql += ', Null';

    var_sql += QuotedStr(Trim(edDA1.Text)); // DADOSADC1
    var_sql += QuotedStr(Trim(edDA2.Text)); // DADOSADC2
    var_sql += QuotedStr(Trim(edDA3.Text)); // DADOSADC3
    var_sql += QuotedStr(Trim(edDA4.Text)); // DADOSADC4
    var_sql += ', NULL'; // VBCUFDEST
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edFCP.Text)); // PFCPUFDEST
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPIcmsUfDest.Text)); // PICMSUFDEST
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPIcmsInter.Text)); // PICMSINTER
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPIcmsPart.Text)); // PICMSINTERPART
    var_sql += QuotedStr(Trim(edIPIEnq.Text)); // CST_IPI_CENQ
    // , VFCPUFDEST, ' +
    //  '  VICMSUFDEST, VICMSUFREMET, CST_IPI_CENQ, ' +
    // '  REDBASEPIS, REDBASECOFINS, REDBASEIPI, II_PERCENTUAL
    executado := 'S';
  end; // FIM INCLUSAO POR NCM


  if ((executado = 'N') and (Trim(UpperCase(edProduto.Text)) <> 'TODOS')) then
  begin
    if (txtProduto.Caption                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               = '') then
    begin
      ShowMessage('Produto não encontrado, digite um Produto válido');
      Exit;
    end;
    var_sql := 'INSERT INTO CLASSIFICACAOFISCALPRODUTO (COD_PROD, CFOP, UF, ' +
      '  CODFISCAL, ICMS_SUBST, ICMS_SUBST_IC, ICMS_SUBST_IND ' +
      ', ICMS, ICMS_BASE, CST, CSOSN, IPI, ' +
      '  CSTIPI, CSTPIS, CSTCOFINS, PIS, COFINS, ' +
      '  VBCUFDEST, PFCPUFDEST, PICMSUFDEST, ' +
      '  PICMSINTER, PICMSINTERPART, VFCPUFDEST, ' +
      '  VICMSUFDEST, VICMSUFREMET, CST_IPI_CENQ) VALUES (';
    var_sql += QuotedStr(Trim(edProduto.Text));
    var_sql += ',' + QuotedStr(Trim(edCfop.Text));
    var_sql += ',' + QuotedStr(UpperCase(Trim(edUF.Text)));
    Case cbTipoFiscal.ItemIndex of
      0: var_sql += ', ' + QuotedStr('9');
      1: var_sql += ', ' + QuotedStr('F');
      2: var_sql += ', ' + QuotedStr('G');
      3: var_sql += ', ' + QuotedStr('H');
      4: var_sql += ', ' + QuotedStr('J');
      5: var_sql += ', ' + QuotedStr('K');
      6: var_sql += ', ' + QuotedStr('L');
    end;
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edMva.Text));
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edOrigem.Text));
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edDest.Text));
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edAliquota.Text)); // ICMS
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edRBC.Text)); // ICMS_BASE

    if (cbCST.ItemIndex > -1) then
      var_sql += ', 0' + Copy(cbCST.Text,0,2)
    else
      var_sql += ', Null';

    if (cbCSOSN.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbCSOSN.Text,0,3)
    else
      var_sql += ', Null';

    var_sql += ',' + FloatTostr(uutil.strParaFloat(edIPIAliq.Text)); // IPI

    if (cbIpiCst.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbIpiCST.Text,0,2)
    else
      var_sql += ', Null';

    if (cbCSTPis.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbCSTPis.Text,0,2)
    else
      var_sql += ', Null';

    if (cbCSTCofins.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbCSTCofins.Text,0,2)
    else
      var_sql += ', Null';

    if (cbOrigemProd.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbOrigemProd.Text,0,1)
    else
      var_sql += ', Null';

    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPisAliq.Text)); // PIS
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edCofinsAliq.Text)); // COFINS

    //ORIGEM
    if (cbOrigemProd.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbOrigemProd.Text,0,1)
    else
      var_sql += ', Null';
    {
    var_sql += QuotedStr(Trim(edDA1.Text)); // DADOSADC1
    var_sql += QuotedStr(Trim(edDA2.Text)); // DADOSADC2
    var_sql += QuotedStr(Trim(edDA3.Text)); // DADOSADC3
    var_sql += QuotedStr(Trim(edDA4.Text)); // DADOSADC4}
    var_sql += ', NULL'; // VBCUFDEST
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edFCP.Text)); // PFCPUFDEST
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPIcmsUfDest.Text)); // PICMSUFDEST
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPIcmsInter.Text)); // PICMSINTER
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPIcmsPart.Text)); // PICMSINTERPART
    var_sql += QuotedStr(Trim(edIPIEnq.Text)); // CST_IPI_CENQ
    executado := 'S';
  end; // FIM INCLUSAO POR PRODUTO

  if (executado = 'N') then
  begin
    var_sql := 'INSERT INTO ESTADO_ICMS (CODESTADO, CFOP, UF, ' +
      ' CODFISCAL, ICMS_SUBSTRIB, ICMS_SUBSTRIB_IC, ICMS_SUBSTRIB_IND, ' +
      ' ICMS, REDUCAO, CST, CSOSN, IPI, ' +
      ' CSTIPI, CSTPIS, CSTCOFINS, PIS, COFINS, ' +
      ' DADOSADC1, DADOSADC2, DADOSADC3, DADOSADC4, ' +
      ' VBCUFDEST, PFCPUFDEST, PICMSUFDEST, PICMSINTER, ' +
      ' PICMSINTERPART, VFCPUFDEST, VICMSUFDEST, ' +
      ' VICMSUFREMET, CST_IPI_CENQ) VALUES (';
    var_sql += 'GEN_ID(GENESTADO_ICMS, 1)';
    var_sql += ',' + QuotedStr(Trim(edCfop.Text));
    var_sql += ',' + QuotedStr(UpperCase(Trim(edUF.Text)));
    Case cbTipoFiscal.ItemIndex of
      0: var_sql += ', ' + QuotedStr('9');
      1: var_sql += ', ' + QuotedStr('F');
      2: var_sql += ', ' + QuotedStr('G');
      3: var_sql += ', ' + QuotedStr('H');
      4: var_sql += ', ' + QuotedStr('J');
      5: var_sql += ', ' + QuotedStr('K');
      6: var_sql += ', ' + QuotedStr('L');
    end;
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edMva.Text));
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edOrigem.Text));
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edDest.Text));
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edAliquota.Text)); // ICMS
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edRBC.Text)); // ICMS_BASE

    if (cbCST.ItemIndex > -1) then
      var_sql += ', 0' + Copy(cbCST.Text,0,2)
    else
      var_sql += ', Null';

    if (cbCSOSN.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbCSOSN.Text,0,3)
    else
      var_sql += ', Null';

    var_sql += ',' + FloatTostr(uutil.strParaFloat(edIPIAliq.Text)); // IPI

    if (cbIpiCst.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbIpiCST.Text,0,2)
    else
      var_sql += ', Null';

    if (cbCSTPis.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbCSTPis.Text,0,2)
    else
      var_sql += ', Null';

    if (cbCSTCofins.ItemIndex > -1) then
      var_sql += ', ' + Copy(cbCSTCofins.Text,0,2)
    else
      var_sql += ', Null';

    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPisAliq.Text)); // PIS
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edCofinsAliq.Text)); // COFINS

    var_sql += QuotedStr(Trim(edDA1.Text)); // DADOSADC1
    var_sql += QuotedStr(Trim(edDA2.Text)); // DADOSADC2
    var_sql += QuotedStr(Trim(edDA3.Text)); // DADOSADC3
    var_sql += QuotedStr(Trim(edDA4.Text)); // DADOSADC4
    var_sql += ', NULL'; // VBCUFDEST
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edFCP.Text)); // PFCPUFDEST
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPIcmsUfDest.Text)); // PICMSUFDEST
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPIcmsInter.Text)); // PICMSINTER
    var_sql += ',' + FloatTostr(uutil.strParaFloat(edPIcmsPart.Text)); // PICMSINTERPART
    var_sql += QuotedStr(Trim(edIPIEnq.Text)); // CST_IPI_CENQ
    executado := 'S';
  end;
end;

function TfConfiguracaoFiscal.validarCampos: Boolean;
var var_enquadramento: Integer;
begin
  if (cbTipoFiscal.ItemIndex = -1) then
  begin
    ShowMessage('Informe o Tipo Fiscal');
    cbTipoFiscal.SetFocus;
    Result := False;
  end;
  if (Trim(edCfop.Text) = '') then
  begin
    ShowMessage('Informe um CFOP');
    Result := False;
  end;

  if (edCfop.Text <> '') then
  begin
    dmPdv.busca_sql('SELECT CFCOD FROM CFOP WHERE CFCOD = ' +
     QuotedStr(Trim(edCfop.Text)));
    if (dmPdv.sqBusca.IsEmpty) then
    begin
      ShowMessage('Informe um CFOP válido');
      Result := False;
    end;
  end;
  if (Trim(edUF.Text) = '') then
  begin
    ShowMessage('Informe um UF');
    Result := False;
  end;
  if ((var_empresa = 'SIMPLES') and (cbCSOSN.ItemIndex = -1)) then
  begin
    ShowMessage('Selecione o CSOSN');
    cbCSOSN.SetFocus;
    Result := False;
  end;
  if ((var_empresa = 'NORMAL') and (cbCST.ItemIndex = -1)) then
  begin
    ShowMessage('Selecione o CST do ICMS.');
    cbCST.SetFocus;
    Result := False;
  end;

  if ((var_empresa = 'NORMAL') and (Trim(cbIpiCst.Text) = '')) then
  begin
    ShowMessage('Informe o CST DO IPI.');
    Result := False;
  end;


  if (Trim(edIPIEnq.Text) <> '') then
  begin
    try
      var_enquadramento := StrToInt(Trim(edIpiEnq.Text));
    except
      ShowMessage('Código enquadramento precisa ser número, somente.');
      Result := False;
    end;
    if (cbIpiCst.ItemIndex in [2,9]) then
    begin
      if ((var_enquadramento < 301) or (var_enquadramento > 399)) then
      begin
        ShowMessage('Código enquadramento para este CST, deve ser entre 301 e 399');
        Result := False;
      end;
    end;
    if (cbIpiCst.ItemIndex in [4,11]) then
    begin
      if (var_enquadramento < 100) then
      begin
        ShowMessage('Código enquadramento para este CST, deve ser entre 01 e 99');
        Result := False;
      end;
    end;
    if (cbIpiCst.ItemIndex in [5,12]) then
    begin
      if ((var_enquadramento < 101) or (var_enquadramento > 199)) then
      begin
        ShowMessage('Código enquadramento para este CST, deve ser entre 101 e 199');
        Result := False;
      end;
    end;
  end;

  Result := True;
end;

procedure TfConfiguracaoFiscal.edUFExit(Sender: TObject);
begin
  ocultarItens;
end;

procedure TfConfiguracaoFiscal.cbTipoFiscalChange(Sender: TObject);
begin
  ocultarItens;
end;

procedure TfConfiguracaoFiscal.edCfopExit(Sender: TObject);
begin
  if (edCfop.Text <> '') then
  begin
    tipo_cfop := StrToInt(Copy(Trim(edCfop.Text),0,1));
    if (tipo_cfop in [1,2,3]) then
    begin
      cbIpiCst.Items.Clear;
      cbIpiCst.Items.Add('00-Entrada Recuperação Crédito');
      cbIpiCst.Items.Add('01-Entrada Tributada Alíq. Zero');
      cbIpiCst.Items.Add('02-Entrada Isenta');
      cbIpiCst.Items.Add('03-Entrada Não Tributada');
      cbIpiCst.Items.Add('04-Entrada Imune');
      cbIpiCst.Items.Add('05-Entrada com Suspensão');
      cbIpiCst.Items.Add('06-Outras Entradas');
    end;
    if (tipo_cfop in [5,6,7]) then
    begin
      cbIpiCst.Items.Clear;
      cbIpiCst.Items.Add('50-Saída Tributada');
      cbIpiCst.Items.Add('51-Saída Tributável Alíq. Zero');
      cbIpiCst.Items.Add('52-Saída Isenta');
      cbIpiCst.Items.Add('53-Saída Não Tributada');
      cbIpiCst.Items.Add('54-Saída Imune');
      cbIpiCst.Items.Add('55-Saída com Suspensão');
      cbIpiCst.Items.Add('99-Outras Saídas');
    end;
  end;
end;

procedure TfConfiguracaoFiscal.edProdutoChange(Sender: TObject);
begin
  if (Trim(UpperCase(edProduto.Text)) <> 'TODOS') then
  begin
    edDA1.Enabled:=False;
    edDA2.Enabled:=False;
    edDA3.Enabled:=False;
    edDA4.Enabled:=False;
  end
  else begin
    edDA1.Enabled:=True;
    edDA2.Enabled:=True;
    edDA3.Enabled:=True;
    edDA4.Enabled:=True;
  end;
end;

procedure TfConfiguracaoFiscal.cbCSTChange(Sender: TObject);
begin
  if (cbCST.ItemIndex in [1,3,9]) then
  begin
    edMva.Enabled := True;
    edOrigem.Enabled := True;
    edDest.Enabled := True;
  end
  else begin
    edMva.Enabled := False;
    edOrigem.Enabled := False;
    edDest.Enabled := False;
  end;
end;

procedure TfConfiguracaoFiscal.cbCSOSNChange(Sender: TObject);
begin
  if (cbCSOSN.ItemIndex in [3,4,5,8]) then
  begin
    edMva.Enabled := True;
    edOrigem.Enabled := True;
    edDest.Enabled := True;
  end
  else begin
    edMva.Enabled := False;
    edOrigem.Enabled := False;
    edDest.Enabled := False;
  end;
end;

procedure TfConfiguracaoFiscal.BitBtn4Click(Sender: TObject);
begin
  pnInfo.Visible := False;
end;

procedure TfConfiguracaoFiscal.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TfConfiguracaoFiscal.BitBtn1Click(Sender: TObject);
var i: Integer;
begin
  for i := 0 to ComponentCount-1 do
  begin
    if (Components[i] is TEdit) then
      TEdit(Components[i]).Text := '';
    if (Components[i] is TComboBox) then
      TComboBox(Components[i]).ItemIndex := -1;
    if (Components[i] is TMaskEdit) then
      TMaskEdit(Components[i]).Text := '';
  end;
  edCfop.SetFocus;
end;

end.

