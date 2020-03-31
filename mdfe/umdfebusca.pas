unit umdfeBusca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, DBGrids, Buttons, udmpdv, DateTimePicker;

type

  { TfMDFeBusca }

  TfMDFeBusca = class(TForm)
    btnDuplicar: TBitBtn;
    btnFechar: TBitBtn;
    btnProcurar: TBitBtn;
    btnEditar: TBitBtn;
    btnIncluir: TBitBtn;
    CheckBox1: TCheckBox;
    dsMDFe: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    sqMDFe: TSQLQuery;
    sqMDFeCAPKG: TLongintField;
    sqMDFeCAPM3: TLongintField;
    sqMDFeCHAVE_MDF: TLongintField;
    sqMDFeCHAVE_MDFE: TStringField;
    sqMDFeCHAVE_NFE1: TStringField;
    sqMDFeCHAVE_NFE2: TStringField;
    sqMDFeCHAVE_NFE3: TStringField;
    sqMDFeCHAVE_NFE4: TStringField;
    sqMDFeCHAVE_NFE5: TStringField;
    sqMDFeCHAVE_NFE6: TStringField;
    sqMDFeCHAVE_NFE7: TStringField;
    sqMDFeCINT: TStringField;
    sqMDFeCIOT: TStringField;
    sqMDFeCNPJ_AUTORIZADO1: TStringField;
    sqMDFeCNPJ_AUTORIZADO2: TStringField;
    sqMDFeCNPJ_CONTRATANTE: TStringField;
    sqMDFeCODEMITENTE: TLongintField;
    sqMDFeCOD_MDFE: TLongintField;
    sqMDFeCOD_MUNICIPIO_CARREG: TStringField;
    sqMDFeCOD_MUNICIPIO_DESCARREG: TLongintField;
    sqMDFeCONDUTOR_CPF: TStringField;
    sqMDFeCONDUTOR_NOME: TStringField;
    sqMDFeDATA_MDF: TDateTimeField;
    sqMDFeDIGITO_MDF: TSmallintField;
    sqMDFeFORMA_EMISSAO: TSmallintField;
    sqMDFeIDENT_CARGA: TStringField;
    sqMDFeINFO_ADIC_CONTRIBUINTE: TStringField;
    sqMDFeINFO_ADIC_FISCO: TStringField;
    sqMDFeMODALIDADE: TSmallintField;
    sqMDFeMODELO: TSmallintField;
    sqMDFeMUNICIPO_CARREG: TStringField;
    sqMDFeMUNICIPO_DESCARREG: TStringField;
    sqMDFeNF1_CNPJ: TStringField;
    sqMDFeNF1_NUM: TLongintField;
    sqMDFeNF1_PIN: TLongintField;
    sqMDFeNF1_SERIE: TLongintField;
    sqMDFeNF1_UF: TStringField;
    sqMDFeNF1_VALOR: TFloatField;
    sqMDFeNF2_CNPJ: TStringField;
    sqMDFeNF2_NUM: TLongintField;
    sqMDFeNF2_PIN: TLongintField;
    sqMDFeNF2_SERIE: TLongintField;
    sqMDFeNF2_UF: TStringField;
    sqMDFeNF2_VALOR: TFloatField;
    sqMDFeNF3_CNPJ: TStringField;
    sqMDFeNF3_NUM: TLongintField;
    sqMDFeNF3_PIN: TLongintField;
    sqMDFeNF3_SERIE: TLongintField;
    sqMDFeNF3_UF: TStringField;
    sqMDFeNF3_VALOR: TFloatField;
    sqMDFeNUMERO_MDF: TLongintField;
    sqMDFePESO_BRUTO: TFloatField;
    sqMDFePESO_VOLUME1: TFloatField;
    sqMDFePESO_VOLUME2: TFloatField;
    sqMDFePESO_VOLUME3: TFloatField;
    sqMDFePESO_VOLUME4: TFloatField;
    sqMDFePESO_VOLUME5: TFloatField;
    sqMDFePESO_VOLUME6: TFloatField;
    sqMDFePESO_VOLUME7: TFloatField;
    sqMDFePLACA: TStringField;
    sqMDFePROP_CNPJ: TStringField;
    sqMDFePROP_IE: TStringField;
    sqMDFePROP_NOME: TStringField;
    sqMDFePROP_RNTRC: TStringField;
    sqMDFePROP_TIPO: TSmallintField;
    sqMDFePROP_UF: TStringField;
    sqMDFePROTOCOLOCAN: TStringField;
    sqMDFePROTOCOLOENC: TStringField;
    sqMDFePROTOCOLOENV: TStringField;
    sqMDFeQTDE_NFE: TSmallintField;
    sqMDFeREBOQUE_CAPKG: TLongintField;
    sqMDFeREBOQUE_CAPM3: TLongintField;
    sqMDFeREBOQUE_CINT: TStringField;
    sqMDFeREBOQUE_CNPJ: TStringField;
    sqMDFeREBOQUE_CPF: TStringField;
    sqMDFeREBOQUE_IE: TStringField;
    sqMDFeREBOQUE_NOME: TStringField;
    sqMDFeREBOQUE_PLACA: TStringField;
    sqMDFeREBOQUE_RNTRC: TStringField;
    sqMDFeREBOQUE_TARA: TLongintField;
    sqMDFeREBOQUE_TIPOCARROCERIA: TSmallintField;
    sqMDFeREBOQUE_TIPOPROP: TSmallintField;
    sqMDFeREBOQUE_UF: TStringField;
    sqMDFeREBOQUE_UFVEICULO: TStringField;
    sqMDFeRNTRC: TStringField;
    sqMDFeSEG_APOLICE: TStringField;
    sqMDFeSEG_AVERBA: TStringField;
    sqMDFeSEG_CNPJ_EMITENTE: TStringField;
    sqMDFeSEG_CNPJ_SEGURADORA: TStringField;
    sqMDFeSEG_RESP: TLongintField;
    sqMDFeSEG_SEGURADORA: TStringField;
    sqMDFeSERIE: TSmallintField;
    sqMDFeTARA: TLongintField;
    sqMDFeTIPOEMITENTE: TSmallintField;
    sqMDFeTIPO_CARGA: TSmallintField;
    sqMDFeTIPO_CARROCERIA: TSmallintField;
    sqMDFeTIPO_EMITENTE: TLongintField;
    sqMDFeTIPO_RODADO: TSmallintField;
    sqMDFeTIPO_TRANSP: TSmallintField;
    sqMDFeUF_CARREGAMENTO: TStringField;
    sqMDFeUF_DESCARREGAMENTO: TStringField;
    sqMDFeUF_PERCURSO: TStringField;
    sqMDFeUF_PERCURSO2: TStringField;
    sqMDFeUF_PERCURSO3: TStringField;
    sqMDFeUF_PERCURSO4: TStringField;
    sqMDFeUF_PERCURSO5: TStringField;
    sqMDFeUF_PERCURSO6: TStringField;
    sqMDFeUF_VEICULO: TStringField;
    sqMDFeUNID_CARGA: TStringField;
    sqMDFeUNID_PESO: TSmallintField;
    sqMDFeUNID_TRANSP: TStringField;
    sqMDFeVALOR_CARGA: TFloatField;
    sqMDFeVERSAO_APLICATIVO: TStringField;
  private

  public

  end;

var
  fMDFeBusca: TfMDFeBusca;

implementation

{$R *.lfm}

end.

