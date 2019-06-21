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
    edNCM: TEdit;
    edProduto: TEdit;
    edPisAliq: TMaskEdit;
    edIPIAliq: TMaskEdit;
    edCofinsAliq: TMaskEdit;
    edIPIEnq: TMaskEdit;
    edRBC1: TMaskEdit;
    edRBC2: TMaskEdit;
    edRBC3: TMaskEdit;
    edRBC4: TMaskEdit;
    edMva: TMaskEdit;
    edOrigem: TMaskEdit;
    edDest: TMaskEdit;
    edUFF: TEdit;
    edUF: TEdit;
    gbICMSNormal: TGroupBox;
    gbCofins: TGroupBox;
    gbPorProduto: TGroupBox;
    GroupBox1: TGroupBox;
    gbICMSSimples: TGroupBox;
    gbDifal: TGroupBox;
    gbICMSSt: TGroupBox;
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
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
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
    procedure BitBtn4Click(Sender: TObject);
    procedure cbCSOSNChange(Sender: TObject);
    procedure cbCSTChange(Sender: TObject);
    procedure cbTipoFiscalChange(Sender: TObject);
    procedure edCfopExit(Sender: TObject);
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
  end;
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
begin
  // Editar
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
      '  CODFISCAL, ICMS_SUBST, ICMS_SUBST_IC, ' +
      '  ICMS_SUBST_IND, ICMS, ICMS_BASE, CST, IPI, ' +
      '  CSOSN, CSTIPI, CSTPIS, CSTCOFINS, PIS, COFINS, ' +
      '  ORIGEM, DADOSADC1, DADOSADC2, DADOSADC3, ' +
      '  DADOSADC4, DADOSADC5, DADOSADC6, ALIQ_CUPOM, ' +
      '  VBCUFDEST, PFCPUFDEST, PICMSUFDEST, ' +
      '  PICMSINTER, PICMSINTERPART, VFCPUFDEST, ' +
      '  VICMSUFDEST, VICMSUFREMET, CST_IPI_CENQ, ' +
      '  REDBASEPIS, REDBASECOFINS, REDBASEIPI, II_PERCENTUAL) ' +
      '  VALUES (';
    var_sql += QuotedStr(Trim(edNCM.Text));
    var_sql += ',' + QuotedStr(Trim(edCfop.Text));
    var_sql += ',' + QuotedStr(Trim(edUF.Text));
    Case cbTipoFiscal.ItemIndex of
      0: var_sql += ', ' + QuotedStr('9');
      1: var_sql += ', ' + QuotedStr('F');
      2: var_sql += ', ' + QuotedStr('G');
      3: var_sql += ', ' + QuotedStr('H');
      4: var_sql += ', ' + QuotedStr('J');
      5: var_sql += ', ' + QuotedStr('K');
      6: var_sql += ', ' + QuotedStr('L');
    end;
  end;
end;

procedure TfConfiguracaoFiscal.incluir;
begin
  // Incluir


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

end.

