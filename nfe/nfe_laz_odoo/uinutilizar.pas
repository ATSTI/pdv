unit uInutilizar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfInutlizar }

  TfInutlizar = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edAno: TEdit;
    edJustificativa: TEdit;
    edModelo: TEdit;
    edSerie: TEdit;
    edIni: TEdit;
    edFim: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label6Click(Sender: TObject);
  private

  public
    inu_ano: String;
    inu_serie: String;
    inu_ini: String;
    inu_fim: String;
    inu_modelo: String;
    inu_justificativa: String;
  end;

var
  fInutlizar: TfInutlizar;

implementation

{$R *.lfm}

{ TfInutlizar }

procedure TfInutlizar.BitBtn2Click(Sender: TObject);
begin
  inu_ano := '';
  inu_serie := '';
  inu_ini := '';
  inu_fim := '';
  inu_modelo := '';
  inu_justificativa := '';
  Close;
end;

procedure TfInutlizar.FormShow(Sender: TObject);
begin
  edIni.Text := '';
  edFim.Text := '';
  edJustificativa.Text := '';
end;

procedure TfInutlizar.Label6Click(Sender: TObject);
begin

end;

procedure TfInutlizar.BitBtn1Click(Sender: TObject);
begin
  if (Length(edJustificativa.Text) < 15) then
  begin
    ShowMessage('O motivo precisa ter mais de 15 caracteres');
    edJustificativa.SetFocus;
    Exit;
  end;
  if (edIni.Text = '') then
  begin
    ShowMessage('Informe o número a ser inutilizado');
    edIni.SetFocus;
    exit;
  end;
  if (edAno.Text = '') then
  begin
    ShowMessage('Informe o ano');
    edAno.SetFocus;
    exit;
  end;
  if (edSerie.Text = '') then
  begin
    ShowMessage('Informe a Série(série usada emissão NFe');
    edSerie.SetFocus;
    exit;
  end;
  inu_ano := edAno.Text;
  inu_serie := edSerie.Text;
  inu_ini := edIni.Text;
  inu_fim := edFim.Text;
  inu_modelo := edModelo.Text;
  inu_justificativa := edJustificativa.Text;
  if (edFim.Text = '') then
    inu_fim := inu_ini;
  Close
end;

end.

