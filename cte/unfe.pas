unit uNFe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, EditBtn, DBCtrls, uCtePrincipal, ACBrNFe, DBDateTimePicker, db;

type

  { TfNFe }

  TfNFe = class(TForm)
    ACBrNFe1: TACBrNFe;
    btnOk: TBitBtn;
    btnEdita: TBitBtn;
    DBDateTimePicker1: TDBDateTimePicker;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    sbtnLerXmlCte1: TSpeedButton;
    procedure btnEditaClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure sbtnLerXmlCte1Click(Sender: TObject);
  private

  public
    fnfe : integer;
    path_xml: String;
    pvNfeEdit , pvNfeInseri : string;
  end;

var
  fNFe: TfNFe;

implementation

uses uDmCte, udmpdv;

{$R *.lfm}

{ TfNFe }

procedure TfNFe.btnOkClick(Sender: TObject);
var vNfe_str:String;
  vNum_nfe: Integer;
begin
   fCTePrincipal.ZsqNFeCHAVE.AsString := DBEdit1.Text;

   if (fCTePrincipal.ZsqNFeCHAVE.AsString = '') then
  begin
    ShowMessage('Informe a CHAVE da NFe.');
    Exit;
  end;
  vNfe_str := '';

  if (fCTePrincipal.DSZsqNFe.State in [dsEdit]) then
  begin
    vNfe_str := 'UPDATE CTE_NFE SET CHAVE = ';
    vNfe_str := vNfe_str +  QuotedStr(fCTePrincipal.ZsqNFeCHAVE.AsString);
    if(fCTePrincipal.ZsqNFePIN.AsInteger > 0)then
    begin
      vNfe_str := vNfe_str + ', PIN = ';
      vNfe_str := vNfe_str + QuotedStr(IntToStr(fCTePrincipal.ZsqNFePIN.AsInteger));
    end;
    vNfe_str := vNfe_str + ', DPREV = ';
    if (DBDateTimePicker1.DateIsNull = False) then
    begin
     //  vNfe_str := vNfe_str +  QuotedStr('19/12/2022');
      vNfe_str := vNfe_str +  QuotedStr(FormatDateTime('mm/dd/yyyy', fCTePrincipal.ZsqNFeDPREV.AsDateTime));
    end
    else begin
      vNfe_str := vNfe_str + ' NULL ';
    end;

    vNfe_str := vNfe_str + ' WHERE COD_CTE_NFE = ';
    vNfe_str := vNfe_str + IntToStr(fCTePrincipal.ZsqNFeCOD_CTE_NFE.AsInteger);
    pvNfeEdit := vNfe_str ;
    fCTePrincipal.edtNfe.Text:= vNfe_str ;
  end;


  if (fCTePrincipal.DSZsqNFe.State in [dsInsert]) then
  begin
    vNum_nfe := fCTePrincipal.busca_generator('GEN_CTE_NFE_ID');
    //vNum_nfe := dmPdv.busca_generator('GEN_CTE_NFE_ID');
    vNfe_str := 'INSERT INTO CTE_NFE (COD_CTE_NFE, CTE_NFE, CHAVE,DPREV, PIN  ' +
               ') VALUES ( ' + IntToStr(vNum_nfe);
    vNfe_str := vNfe_str + ', ' + IntToStr(fCTePrincipal.ZsqNFeCTE_NFE.AsInteger);
    vNfe_str := vNfe_str + ', ' + QuotedStr(fCTePrincipal.ZsqNFeCHAVE.AsString);
    if (DBDateTimePicker1.DateIsNull = False) then
    begin
      vNfe_str := vNfe_str + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',
        fCTePrincipal.ZsqNFeDPREV.AsDateTime));
    end
    else begin
      vNfe_str := vNfe_str + ', NULL ';
    end;

    if(fCTePrincipal.ZsqNFePIN.AsInteger > 0)then
    begin
      vNfe_str := vNfe_str + ', ' + QuotedStr(IntToStr(fCTePrincipal.ZsqNFePIN.AsInteger));
    end
    else begin
      vNfe_str := vNfe_str + ', NULL';
    end;
    vNfe_str := vNfe_str + ')';

    pvNfeInseri := vNfe_str ;
  end;

  //if (vNfe_str <> '') then
  //  dmPdv.Ibcon.ExecuteDirect(vNfe_str);
  fCTePrincipal.btnInserirvNfe.Click;

  //dmCte.sqNFeCOD_CTE_NFE.AsInteger := vNum_nfe;

  Close;

 { if (dmCte.sqNFeCHAVE.AsString = '') then
  begin
    ShowMessage('Informe a CHAVE da NFe.');
    Exit;
  end;
  vNfe_str := '';

  if (dmCte.dsNFe.State in [dsEdit]) then
  begin
    vNfe_str := 'UPDATE CTE_NFE SET CHAVE = ';
    vNfe_str := vNfe_str +  QuotedStr(dmCte.sqNFeCHAVE.AsString);
    if(dmCte.sqNFePIN.AsInteger > 0)then
    begin
      vNfe_str := vNfe_str + ', PIN = ';
      vNfe_str := vNfe_str + QuotedStr(IntToStr(dmCte.sqNFePIN.AsInteger));
    end;
    vNfe_str := vNfe_str + ', DPREV = ';
    if (DBDateTimePicker1.DateIsNull = False) then
    begin
     //  vNfe_str := vNfe_str +  QuotedStr('19/12/2022');
      vNfe_str := vNfe_str +  QuotedStr(FormatDateTime('mm/dd/yyyy', dmCte.sqNFeDPREV.AsDateTime));
    end
    else begin
      vNfe_str := vNfe_str + ' NULL ';
    end;

    vNfe_str := vNfe_str + ' WHERE COD_CTE_NFE = ';
    vNfe_str := vNfe_str + IntToStr(dmCte.sqNFeCOD_CTE_NFE.AsInteger);
    pvNfeEdit := vNfe_str ;
  end;


  if (dmCte.dsNFe.State in [dsInsert]) then
  begin
    vNum_nfe := dmPdv.busca_generator('GEN_CTE_NFE_ID');
    vNfe_str := 'INSERT INTO CTE_NFE (COD_CTE_NFE, CTE_NFE, CHAVE,DPREV, PIN  ' +
               ') VALUES ( ' + IntToStr(vNum_nfe);
    vNfe_str := vNfe_str + ', ' + IntToStr(dmCte.sqNFeCTE_NFE.AsInteger);
    vNfe_str := vNfe_str + ', ' + QuotedStr(dmCte.sqNFeCHAVE.AsString);
    if (DBDateTimePicker1.DateIsNull = False) then
    begin
      vNfe_str := vNfe_str + ', ' + QuotedStr(FormatDateTime('mm/dd/yyyy',
        dmCte.sqNFeDPREV.AsDateTime));
    end
    else begin
      vNfe_str := vNfe_str + ', NULL ';
    end;

    if(dmCte.sqNFePIN.AsInteger > 0)then
    begin
      vNfe_str := vNfe_str + ', ' + QuotedStr(IntToStr(dmCte.sqNFePIN.AsInteger));
    end
    else begin
      vNfe_str := vNfe_str + ', NULL';
    end;
    vNfe_str := vNfe_str + ')';

    pvNfeInseri := vNfe_str ;
  end;

  //if (vNfe_str <> '') then
  //  dmPdv.Ibcon.ExecuteDirect(vNfe_str);
  fCTePrincipal.btnInserirvNfe.Click;

  dmCte.sqNFeCOD_CTE_NFE.AsInteger := vNum_nfe;

  Close;
 }
end;


procedure TfNFe.sbtnLerXmlCte1Click(Sender: TObject);
var n: integer ;
begin
  OpenDialog1.Title := 'Selecione a NFe';
  OpenDialog1.DefaultExt := '*.xml';
  OpenDialog1.Filter := 'Arquivos NFe (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := path_xml;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    for n:=0 to ACBrNFe1.NotasFiscais.Count-1 do
    begin
      with ACBrNFe1.NotasFiscais.Items[n].NFe do
      begin
        //dmCte.sqNFeCHAVE.AsString := procNFe.chNFe;
        DBEdit1.Text := Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, 44)
       // chNfe := DBEdit1.Text;
        {
        edtXMLCnpj.Text := Copy(Dest.CNPJCPF,1,2) + '.' + Copy(Dest.CNPJCPF,3,3) + '.' + Copy(Dest.CNPJCPF,6,3) + '/' + Copy(Dest.CNPJCPF,9,4) + '-' + Copy(Dest.CNPJCPF,13,2);
        edtXMLNome.Text := Dest.xNome ;
        edtXMLIE.Text := Dest.IE ;

        edtXMLLogradouro.Text := Dest.EnderDest.xLgr;
        edtXMLComp.Text   := Dest.EnderDest.xCpl;
        edtXMLCidade.Text := Dest.EnderDest.xMun ;
        edtXMLUF.Text     := Dest.EnderDest.UF ;
        edtXMLBairro.Text := Dest.EnderDest.xBairro ;
        edtXMLCEP.Text    := IntToStr(Dest.EnderDest.CEP) ;
        edtXMLFone.Text   := Dest.EnderDest.Fone;
        edtXMLNumero.Text := Dest.EnderDest.nro ;
        edtXMLCodCidade.Text := IntToStr(Dest.EnderDest.cMun);
        }
      end;
    end;
  end;
end;

procedure TfNFe.btnEditaClick(Sender: TObject);
begin
  Close;
end;

end.

