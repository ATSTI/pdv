unit umunicipiobusca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBGrids, uPadraoBusca, db;

type

  { TfMunicipioBusca }

  TfMunicipioBusca = class(TfPadraoBusca)
    dsMunicipio: TDataSource;
    procedure btnProcurarClick(Sender: TObject);
    procedure btnSair1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    procedure Procurar();
  public
    cCodMun : String;
    cNomeMun : String;
    cUfMun : String;
    procedure BuscaMunicipio;
  end;

var
  fMunicipioBusca: TfMunicipioBusca;

implementation

uses udmpdv;

{$R *.lfm}

{ TfMunicipioBusca }

procedure TfMunicipioBusca.FormShow(Sender: TObject);
begin
  DBGrid1.Columns[0].FieldName := 'CD_IBGE';
  DBGrid1.Columns[1].FieldName := 'NM_MUNICIPIO';
  DBGrid1.Columns[2].FieldName := 'CD_UF';
  DBGrid1.Columns[0].Title.Caption:='Código';
  DBGrid1.Columns[1].Title.Caption:='Municipio';
  DBGrid1.Columns[2].Title.Caption:='UF';
  cNomeMun := '';
  cCodMun := '';
  cUfMun := '';
  Procurar();
end;

procedure TfMunicipioBusca.btnSair1Click(Sender: TObject);
begin

  inherited;
end;

procedure TfMunicipioBusca.DBGrid1DblClick(Sender: TObject);
begin
  cNomeMun := dmPdv.sqBusca.FieldByName('NM_MUNICIPIO').AsString;
  cCodMun  := dmPdv.sqBusca.FieldByName('CD_IBGE').AsString;
  cUfMun   := dmPdv.sqBusca.FieldByName('CD_UF').AsString;
  Close;
end;

procedure TfMunicipioBusca.Edit2Change(Sender: TObject);
begin
  if (edit2.Text <> '') then
  begin
    Procurar();
  end;
end;

procedure TfMunicipioBusca.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  cNomeMun := dmPdv.sqBusca.FieldByName('NM_MUNICIPIO').AsString;
  cCodMun  := dmPdv.sqBusca.FieldByName('CD_IBGE').AsString;
  cUfMun   := dmPdv.sqBusca.FieldByName('CD_UF').AsString;
end;

procedure TfMunicipioBusca.btnProcurarClick(Sender: TObject);
begin
  Procurar();
end;

procedure TfMunicipioBusca.Procurar();
var sql: String;
begin
  sql := '';
  if edit1.Text <> '' then
  begin
    sql := ' WHERE CD_IBGE = ' + Edit1.Text;
  end;
  if edit2.Text <> '' then
  begin
    sql := ' WHERE UPPER(NM_MUNICIPIO) LIKE UPPER(' + QuotedStr('%' + Edit2.Text + '%') + ')';
  end;
  sql := 'SELECT DISTINCT CD_IBGE, NM_MUNICIPIO, CD_UF FROM TB_IBGE ' + sql;
  dmPdv.busca_sql(sql);
  cNomeMun := dmPdv.sqBusca.FieldByName('NM_MUNICIPIO').AsString;
  cCodMun  := dmPdv.sqBusca.FieldByName('CD_IBGE').AsString;
  cUfMun   := dmPdv.sqBusca.FieldByName('CD_UF').AsString;
end;

procedure TfMunicipioBusca.BuscaMunicipio;
var sql: String;
begin
  sql := 'SELECT FIRST 1 NM_LOCALIDADE , CD_IBGE '  +
      ', NM_MUNICIPIO, NM_TIPO_LOCALIDADE ' +
      ', SQ_IBGE , CD_UF  FROM TB_IBGE';
  sql := sql + ' WHERE UPPER(NM_MUNICIPIO) LIKE UPPER(' +
    QuotedStr('%' + cCodMun + '%') + ')';
  dmPdv.busca_sql(sql);
  if not dmPdv.sqBusca.IsEmpty then
  begin
    cNomeMun := dmPdv.sqBusca.FieldByName('NM_MUNICIPIO').AsString;
    cCodMun  := dmPdv.sqBusca.FieldByName('CD_IBGE').AsString;
    cUfMun   := dmPdv.sqBusca.FieldByName('CD_UF').AsString;
  end;
end;

end.

