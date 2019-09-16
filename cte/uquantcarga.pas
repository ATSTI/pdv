unit uQuantCarga;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, EditBtn;

type

  { TfQuantCarga }

  TfQuantCarga = class(TForm)
    btnGravar: TBitBtn;
    btnEditar: TBitBtn;
    btnFechar: TBitBtn;
    valQC: TCalcEdit;
    cbTipoUN: TComboBox;
    edCodUn: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnEditarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private

  public
    fcarga : integer;
  end;

var
  fQuantCarga: TfQuantCarga;

implementation

uses udmpdv, uDmCte;

{$R *.lfm}

{ TfQuantCarga }

procedure TfQuantCarga.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfQuantCarga.btnEditarClick(Sender: TObject);
var strEdita :string;
begin
  if (cbTipoUN.Text <> '') then
  begin
    FormatSettings.DecimalSeparator := '.';
    strEdita := 'UPDATE CTE_QC SET UNID = ';
    strEdita := strEdita + QuotedStr(Copy(cbTipoUn.Text,1,2));
    strEdita := strEdita + ', MEDIDA = ';
    strEdita := strEdita +  QuotedStr(edCodUn.Text);
    strEdita := strEdita + ', QUANT = ';
    strEdita := strEdita + FloatToStr(valQc.AsFloat) ; //+  Format('%8.2f', [valQCQ.Value]);
    strEdita := strEdita + ' WHERE COD_CTE_QC = ';
    strEdita := strEdita + IntToStr(dmCte.sqQCCOD_CTE_QC.AsInteger);
    FormatSettings.DecimalSeparator := ',';
    try
      dmPdv.Ibcon.ExecuteDirect(strEdita);
      dmPdv.sTrans.Commit;
      dmCte.sqQC.Refresh;
      fcarga := 1;
      close;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dmPdv.sTrans.Rollback;
        exit;
      end;
    end;
  end;
end;

procedure TfQuantCarga.btnGravarClick(Sender: TObject);
var strInsere :string;
begin
  if (dmCte.cdsCTENPROT.AsString <> '') then
  begin
    MessageDlg('CTe Ja Enviada.', mtInformation, [mbOK], 0);
    exit;
  end;
  if (cbTipoUn.Text <> '') then
  begin
    strInsere := 'INSERT INTO CTE_QC (COD_CTE ,UNID, MEDIDA, QUANT  ' +
                 ') VALUES ( ';
    FormatSettings.DecimalSeparator := '.';

    strInsere := strInsere + IntToStr(dmCte.sqQCCOD_CTE.AsInteger);
    strInsere := strInsere + ', ' + QuotedStr(Copy(cbTipoUn.Text,1,2));
    strInsere := strInsere + ', ' + QuotedStr(edCodUn.Text);
    strInsere := strInsere + ', ' +  FloatToStr(valQC.AsFloat) ;
    strInsere := strInsere + ')';
    FormatSettings.DecimalSeparator := ',';
    try
      dmPdv.Ibcon.ExecuteDirect(strInsere);
      dmPdv.sTrans.Commit;
      dmCte.sqQC.Refresh;
      fcarga := 1;
      Close;
    except
      on E : Exception do
      begin
        ShowMessage('Classe: ' + e.ClassName + chr(13) + 'Mensagem: ' + e.Message);
        dmPdv.sTrans.Rollback;
        exit;
      end;
    end;
  end
end;

end.

