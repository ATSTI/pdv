unit uCadeira;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, DBGrids, udmpdv, uAlunoBusca, uCursoBusca, db, IniFiles;

type

  { TfCadeira }

  TfCadeira = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    btnConfirmaTroca: TBitBtn;
    btnCancelarTroca: TBitBtn;
    ds: TDataSource;
    DBGrid1: TDBGrid;
    edCadeiraAtual: TEdit;
    edCadeiraNova: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    lblAlunoTroca: TLabel;
    lblAluno: TLabel;
    lblCurso: TLabel;
    Label2: TLabel;
    lblCadeira: TLabel;
    pnTrocaCadeira: TPanel;
    pnCursos: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnCancelarTrocaClick(Sender: TObject);
    procedure btnConfirmaTrocaClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure edCadeiraAtualExit(Sender: TObject);
    procedure edCadeiraAtualKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    //codCurso: Integer;
    codAluno: Integer;
    procedure atualizaCadeiras;
  public
    listaCurso: TStringList;
    cadCodCurso: Integer;
  procedure cadeiraMarcada(Sender: TObject);
  end;

var
  fCadeira: TfCadeira;

implementation

{$R *.lfm}

{ TfCadeira }

procedure TfCadeira.FormCreate(Sender: TObject);
var
  conf: TIniFile;
  B: TBitBtn;
  i: integer;
  linha: Integer;
  coluna: Integer;
  altura: Integer;
  largura: Integer;
  horizonte: Integer;
  vertical: Integer;
  fileira: integer;
  linha_coluna: integer;
  total_cadeira: integer;
begin
  conf := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'conf.ini');
  try
    altura := conf.ReadInteger('CADEIRA', 'Altura', 28);
    largura := conf.ReadInteger('CADEIRA', 'Largura', 100);
    horizonte := conf.ReadInteger('CADEIRA', 'PosicaoHorizontal', 150);
    vertical := conf.ReadInteger('CADEIRA', 'PosicaoVertical', 80);
    total_cadeira := conf.ReadInteger('CADEIRA', 'TotalCadeira', 60);
    // a pedido  do jose em cadeira por fila vou colocar fila por cadeira
    linha := conf.ReadInteger('CADEIRA', 'CadeiraFila', 6);
  finally
    conf.Free;
  end;
  fileira := 1;
  linha_coluna := 1;
  for i := 0 to (total_cadeira-1) do
  begin
    B := TBitBtn.Create(self);
    B.Caption := IntToStr(i+1);
    B.Parent := Self;
    B.Height := altura;
    B.Width := largura;
    B.OnClick := @cadeiraMarcada;
    if (fileira = 1) then
    begin
      B.Left := vertical;
    end
    else begin
      B.Left := vertical + ((largura+5) * (fileira-1)) ;
    end;
    B.Top := horizonte + linha_coluna * (altura+2);

    if (fileira > (linha-1)) then
    begin
      linha_coluna += 1;
      fileira := 1;
    end
    else begin
      //linha_coluna := 1;
      fileira += 1;
    end;
  end;
end;

procedure TfCadeira.FormShow(Sender: TObject);
var
  c_str: String;
  i: Integer;
begin
  cadCodCurso:= 0;
  for i := 0 to listaCurso.Count-1 do
  begin
    c_str := 'SELECT CODDADOS AS CODCURSO, DESCRICAO FROM DADOS_COMBOS' +
      ' WHERE CODIGOS = ' + QuotedStr(listaCurso[i]);
    dmPdv.busca_sql(c_str);
    if (dmPdv.sqBusca.RecordCount > 1) then
    begin
      pnCursos.Visible:=True;
      DBGrid1.Columns[0].FieldName := 'CODCURSO';
      DBGrid1.Columns[1].FieldName := 'DESCRICAO';
      DBGrid1.Columns[0].Title.Caption:='Código';
      DBGrid1.Columns[1].Title.Caption:='Curso';
    end
    else begin
      cadCodCurso := dmPdv.sqBusca.FieldByName('CODCURSO').AsInteger;
      lblCurso.Caption := dmPdv.sqBusca.FieldByName('DESCRICAO').AsString;
    end;
  end;
  atualizaCadeiras;
end;

procedure TfCadeira.atualizaCadeiras;
var
  alu_str: String;
    i: Integer;
begin
  //limpando todos os botoes
  for i := fCadeira.ComponentCount -1 downto 0 do
  begin
    if (fCadeira.Components[i] is TBitBtn) then
    begin
      (fCadeira.Components[i] as TBitBtn).Glyph.Clear;
      (fCadeira.Components[i] as TBitBtn).Enabled:=True;
    end;
  end;
  alu_str := 'SELECT CODCLIENTE, ASSUNTO AS NOME_ALUNO, STATUS AS CADEIRA ' +
    ' FROM AGENDAMENTO WHERE CODVENDA = ' + InttoStr(cadCodCurso);
  dmPdv.busca_sql(alu_str);
  While not dmPdv.sqBusca.EOF do
  begin
    for i := fCadeira.ComponentCount -1 downto 0 do
    begin
      if (fCadeira.Components[i] is TBitBtn) then
      begin
        if ((fCadeira.Components[i] as TBitBtn).Caption = dmPdv.sqBusca.FieldByName('CADEIRA').AsString) then
        begin
          (fCadeira.Components[i] as TBitBtn).Enabled:=False;
          (fCadeira.Components[i] as TBitBtn).Hint := dmPdv.sqBusca.FieldByName('NOME_ALUNO').AsString;
          (fCadeira.Components[i] as TBitBtn).ShowHint := True;
          (fCadeira.Components[i] as TBitBtn).Glyph.LoadFromFile('limpa.bmp');
        end;
      end;
    end;
    dmPdv.sqBusca.Next;
  end;
end;

procedure TfCadeira.BitBtn1Click(Sender: TObject);
var str_cad: String;
begin
  {
  str_cad := 'INSERT INTO AGENDAMENTO (' +
    ' COD_AGENDAMENTO, CODCLIENTE, ASSUNTO, DATA, STATUS ' +
    ', CODVENDA, CODUSUARIO) VALUES ( ' +
    IntToStr(dmPdv.busca_generator('GEN_AGENDA')) +
    // CODCLIENTE,
    // CURSO
    // DATA

    // CODCURSO
    dmPdv.varLogado +
    ')';  }
  if (codAluno = 0) then
  begin
    ShowMessage('Aluno não informado.');
    Exit;
  end;

  if (cadCodCurso = 0) then
  begin
    ShowMessage('Selecione o Curso Desejado.');
    Exit;
  end;
  if (lblCadeira.Caption = '.') then
  begin
    ShowMessage('Selecione a Cadeira Desejada.');
    Exit;
  end;

  // a agendamento vai vir com os dados do odooo os
  // alunos cadastrados nos cursos
  // aqui vou fazer um UPDATE na AGENDAMENTO apenas;
  str_cad := 'UPDATE AGENDAMENTO SET STATUS = ' + QuotedStr(lblCadeira.Caption) +
    ' ,DATA  = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', Now)) +
    ' ,CODUSUARIO = ' +  dmPdv.varLogado +
    ' WHERE CODVENDA = ' + IntToStr(cadCodCurso) +
    '   AND CODCLIENTE = ' + IntToStr(codAluno);
  dmPdv.IbCon.ExecuteDirect(str_cad);
  dmPdv.sTrans.Commit;
  ShowMessage('Cadeira GRAVADA com sucesso.');
  atualizaCadeiras;
end;

procedure TfCadeira.BitBtn2Click(Sender: TObject);
begin
  // nao preciso disto, os cursos vão vir da VENDA, dos itens vendidos
  // mostrar o que tem na DADOS_COMBOS
  pnCursos.Visible:=True;
end;

procedure TfCadeira.BitBtn3Click(Sender: TObject);
begin
  // mostrar o que tem na AGENDAMENTO , com o campo STATUS = 0 (zero)
  fAlunoBusca.aluCodCurso:=cadCodCurso;
  fAlunoBusca.ShowModal;
  lblAluno.Caption := fAlunoBusca.aluNome;
  codAluno:= fAlunoBusca.aluCodAluno;
end;

procedure TfCadeira.BitBtn4Click(Sender: TObject);
begin
  pnCursos.Visible:=False;
end;

procedure TfCadeira.BitBtn5Click(Sender: TObject);
begin
  pnTrocaCadeira.Visible:=True;
end;

procedure TfCadeira.btnCancelarTrocaClick(Sender: TObject);
begin
  pnTrocaCadeira.Visible:=False;
end;

procedure TfCadeira.btnConfirmaTrocaClick(Sender: TObject);
var str_atualiza: sTring;
begin
  if (lblAlunoTroca.Caption <> '') then
  begin
    {
    str_atualiza := 'UPDATE AGENDAMENTO SET STATUS = ' + QuotedStr('0') +
      ' ,CODUSUARIO = ' +  dmPdv.varLogado +
      ' WHERE CODVENDA = ' + IntToStr(cadCodCurso) +
      '   AND CODCLIENTE = ' + IntToStr(codAluno);
    dmPdv.IbCon.ExecuteDirect(str_atualiza);}
    str_atualiza := 'UPDATE AGENDAMENTO SET STATUS = ' + QuotedStr(edCadeiraNova.Text) +
      ' ,DATA  = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', Now)) +
      ' ,CODUSUARIO = ' +  dmPdv.varLogado +
      ' WHERE CODVENDA = ' + IntToStr(cadCodCurso) +
      '   AND CODCLIENTE = ' + IntToStr(codAluno);
    dmPdv.IbCon.ExecuteDirect(str_atualiza);
    dmPdv.sTrans.Commit;
    ShowMessage('Cadeira GRAVADA com sucesso.');
    atualizaCadeiras;
  end;
end;

procedure TfCadeira.DBGrid1CellClick(Column: TColumn);
begin
  cadCodCurso := dmPdv.sqBusca.FieldByName('CODCURSO').AsInteger;
  lblCurso.Caption := dmPdv.sqBusca.FieldByName('DESCRICAO').AsString;
  pnCursos.Visible:=False;
end;

procedure TfCadeira.edCadeiraAtualExit(Sender: TObject);
var bca_str:string;
begin
  if (lblAlunoTroca.Caption = '') then
  begin
    bca_str := 'SELECT CODCLIENTE, ASSUNTO AS NOME_ALUNO, STATUS AS CADEIRA ' +
      ' FROM AGENDAMENTO WHERE STATUS = ' + edCadeiraAtual.Text;
    dmPdv.busca_sql(bca_str);
    if not dmPdv.sqBusca.IsEmpty then
    begin
      lblAlunoTroca.Caption:=dmPdv.sqBusca.FieldByName('NOME_ALUNO').AsString;
      codAluno := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
    end;
  end;
end;

procedure TfCadeira.edCadeiraAtualKeyPress(Sender: TObject; var Key: char);
var bc_str:string;
begin
  if Key = #13 then
  begin
    Key := #0;
    bc_str := 'SELECT CODCLIENTE, ASSUNTO AS NOME_ALUNO, STATUS AS CADEIRA ' +
      ' FROM AGENDAMENTO WHERE STATUS = ' + edCadeiraAtual.Text;
    dmPdv.busca_sql(bc_str);
    if not dmPdv.sqBusca.IsEmpty then
    begin
      lblAlunoTroca.Caption:=dmPdv.sqBusca.FieldByName('NOME_ALUNO').AsString;
      codAluno := dmPdv.sqBusca.FieldByName('CODCLIENTE').AsInteger;
    end;
  end;
end;

procedure TfCadeira.cadeiraMarcada(Sender: TObject);
var
  i: integer;
begin
  if (Sender is TBitBtn) and
    TryStrToInt(TBitBtn(Sender).Caption, i)
  then begin
    //Btn := Sender as TButton;
    //ShowMessage(IntToStr(i) + ' - fui clicado');
    lblCadeira.Caption := intToStr(i);
  end;
end;

end.

