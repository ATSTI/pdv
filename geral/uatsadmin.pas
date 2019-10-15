unit uAtsAdmin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  uClienteCadastro, ufornecedorcadastro, uProdutoCadastro, uEmpresaCadastro,
  uUsuarioCadastro, ConfiguracaoFiscal, udmpdv;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnConfiguracaoFiscal: TBitBtn;
    btnCliente: TBitBtn;
    btnProduto: TBitBtn;
    btnUsuario: TBitBtn;
    btnFornecedor: TBitBtn;
    btnEmpresa: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure btnClienteClick(Sender: TObject);
    procedure btnConfiguracaoFiscalClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnFornecedorClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure btnUsuarioClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnClienteClick(Sender: TObject);
begin
  fClienteCadastro.ShowModal;
end;

procedure TForm1.btnConfiguracaoFiscalClick(Sender: TObject);
begin
  fConfiguracaoFiscal.ShowModal;
end;

procedure TForm1.btnEmpresaClick(Sender: TObject);
begin
  fEmpresaCadastro.ShowModal;
end;

procedure TForm1.btnFornecedorClick(Sender: TObject);
begin
  fFornecedorCadastro.ShowModal;
end;

procedure TForm1.btnProdutoClick(Sender: TObject);
begin
  fProdutoCadastro.ShowModal;
end;

procedure TForm1.btnUsuarioClick(Sender: TObject);
begin
  fUsuarioCadastro.ShowModal;
end;

end.

