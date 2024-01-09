unit Frm_Busca;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DBCtrls, ComCtrls, ExtCtrls, PythonEngine,
  Lcl.PythonGUIInputOutput, ZConnection, ZDataset, strutils;

type

  { TfBusca }

  TfBusca = class(TForm)
    btnCadastrar: TButton;
    btnExecEmpresa: TButton;
    Button1: TButton;
    btnImportaNfeOdoo: TButton;
    BtnAssinar: TButton;
    btnFechar: TButton;
    btnNotasGeradas: TButton;
    Button3: TButton;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBGrid2: TDBGrid;
    DsNotas: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    Dsemp: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;

    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    Panel2: TPanel;
    PythonEngine1: TPythonEngine;
    PythonGUIInputOutput1: TPythonGUIInputOutput;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ZConn: TZConnection;
    ZQemp: TZQuery;
    ZQempcnpj: TStringField;
    ZQempempresa_id: TLargeintField;
    ZQempnome: TStringField;
    ZQemprazao: TStringField;
    ZQnotas: TZQuery;

    procedure BtnAssinarClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnExecEmpresaClick(Sender: TObject);
    procedure btnNotasGeradasClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnImportaNfeOdooClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);

    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);

    procedure Edit1Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure ZQempFilterRecord(DataSet: TDataSet; var Accept: Boolean);

  private

  public
   // chave_nfe : string;
  end;

var
  fBusca: TfBusca;

implementation
uses Frm_ACBrNFe;
{$R *.lfm}

{ TfBusca }

procedure TfBusca.Button1Click(Sender: TObject);
begin
  OpenDialog1.FileName  :=  '';
  OpenDialog1.Title := 'Selecione Emitente ';
  OpenDialog1.DefaultExt := '*.INI';
  OpenDialog1.Filter := 'Todos os Arquivos (*.INI*)|*.INI*';

  if OpenDialog1.Execute then
  begin

   Edit1.Text := ExtractFileName(OpenDialog1.FileName);

  end;

end;

procedure TfBusca.btnImportaNfeOdooClick(Sender: TObject);
  var  script  : TStringList;
begin
script := TStringList.Create();
script.LoadFromFile('conecta_odoo_nfe.py');
script.Text := ReplaceStr(script.Text,'999999', DBEdit3.Text);
Memo1.Clear;
Memo2.Clear;
memo2.Text:= script.Text;
Memo1.Append('Starting Python Script');
PythonEngine1.ExecStrings(script);
Memo1.Append('Python Script Terminated');
end;

procedure TfBusca.btnFecharClick(Sender: TObject);
begin
  //close;
  ShowMessage('abriu o Form Busca');
end;

procedure TfBusca.Button3Click(Sender: TObject);
begin
  btnImportaNfeOdoo.Click;
  PageControl1.ActivePage:= TabSheet2;
end;



procedure TfBusca.DBGrid1DblClick(Sender: TObject);
var s : string;
begin
  S:= DBEdit1.Text;
  s:= stringReplace(S , '.',  '' ,[rfReplaceAll, rfIgnoreCase]);
  s:= stringReplace(S , '-',  '' ,[rfReplaceAll, rfIgnoreCase]);
  s:= stringReplace(S , '/',  '' ,[rfReplaceAll, rfIgnoreCase]);
  Edit1.Text := S +'.ini';

end;

procedure TfBusca.DBGrid2DblClick(Sender: TObject);
var s : string;
begin
  S:= DBEdit1.Text;
  s:= stringReplace(S , '.',  '' ,[rfReplaceAll, rfIgnoreCase]);
  s:= stringReplace(S , '-',  '' ,[rfReplaceAll, rfIgnoreCase]);
  s:= stringReplace(S , '/',  '' ,[rfReplaceAll, rfIgnoreCase]);
  Edit1.Text := S +'.ini';
  Edit2.Text:= DBEdit4.Text;
  //BtnAssinar.Click;
end;

procedure TfBusca.btnCadastrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfBusca.BtnAssinarClick(Sender: TObject);
var s : string;
begin
  S:= DBEdit1.Text;
  s:= stringReplace(S , '.',  '' ,[rfReplaceAll, rfIgnoreCase]);
  s:= stringReplace(S , '-',  '' ,[rfReplaceAll, rfIgnoreCase]);
  s:= stringReplace(S , '/',  '' ,[rfReplaceAll, rfIgnoreCase]);
  Edit1.Text := S +'.ini';
  //chave_nfe := Edit2.Text;
  Edit2.Text:= DBEdit4.Text;
  Edit5.Text:= DBEdit3.Text;
end;

procedure TfBusca.btnExecEmpresaClick(Sender: TObject);
begin
    PythonEngine1.ExecStrings( Memo2.Lines );
end;

procedure TfBusca.btnNotasGeradasClick(Sender: TObject);
var  script  : TStringList;
begin
  script := TStringList.Create();
  script.LoadFromFile('conecta_odoo_nfe.py');
  script.Text := ReplaceStr(script.Text,'999999', Edit4.Text);
  script.Text := ReplaceStr(script.Text,'PEGA_XML','ENVIA_AUTORIZADA');
  Memo1.Clear;
  Memo2.Clear;
  memo2.Text:= script.Text;
  Memo1.Append('Starting Python Script');
  PythonEngine1.ExecStrings(script);
  Memo1.Append('Python Script Terminated');

end;



procedure TfBusca.Edit1Change(Sender: TObject);
begin
  close;
end;

procedure TfBusca.Edit3Change(Sender: TObject);
begin
  if Trim(Edit3.Text) <> '' then
  begin
    if not ZQemp.Filtered then
      ZQemp.Filtered := True;
    ZQemp.Refresh;
  end
  else
    ZQemp.Filtered := False;
end;

procedure TfBusca.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  ZQemp.Active:= False;
  ZQnotas.Active:= False;
end;

procedure TfBusca.FormShow(Sender: TObject);
begin
  Edit3.SetFocus;
  ZQemp.Active:= True;
  //btnExecEmpresa.Click;
end;

procedure TfBusca.TabSheet2Show(Sender: TObject);
begin
  if (ZQnotas.Active)then
    ZQnotas.Close;
  ZQnotas.Params[0].AsInteger := StrToInt(DBEdit3.Text);
  ZQnotas.Open;
end;

procedure TfBusca.ZQempFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := Pos(UpperCase(Edit3.Text), UpperCase(DataSet.FieldByName('nome').AsString)) > 0;
end;



end.

