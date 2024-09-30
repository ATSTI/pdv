unit umsgpromo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ExtDlgs;

type

  { TfMsgPromo }

  TfMsgPromo = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    TimerMSG: TTimer;
    procedure FormShow(Sender: TObject);
    procedure TimerMSGTimer(Sender: TObject);
  private

  public

  end;

var
  fMsgPromo: TfMsgPromo;

implementation
 uses  uProdutoProc,udmpdv;
{$R *.lfm}

{ TfMsgPromo }

procedure TfMsgPromo.TimerMSGTimer(Sender: TObject);
begin
  TimerMSG.Enabled := False;
  fMsgPromo.Close;
end;

procedure TfMsgPromo.FormShow(Sender: TObject);
var
  segundos_ate_fechar: byte;
  promo , onde : string;
  Arquivo : TStringList;
  pTempo : integer;
begin
  onde := 'C:\home\' ; //dmPdv.path_exe ;
  pTempo:= dmPdv.TempoPromocao;
  promo := onde + 'integracao_odoo\'+ dmPdv.sqBusca.FieldByName('FOTOPRODUTO').AsString;

  label2.Caption:= promo;

  if pos('txt',promo)>0 then
  begin
    Memo1.Visible:= True;
    Arquivo := TStringList.Create();
    Arquivo.LoadFromFile(promo);
    Memo1.Clear;
    Memo1.Text := Arquivo.Text;
    Arquivo.Free;
  end else
  begin
    Memo1.Visible:= False;
    Image1.Picture.LoadFromFile(promo);
  end;

  Label1.Caption:= fProdutoProc.Produto ;
  segundos_ate_fechar := pTempo;
  TimerMSG.Enabled := False;
  TimerMSG.Interval := (1000 * 1) * segundos_ate_fechar;
  TimerMSG.Enabled := True;

end;

end.

