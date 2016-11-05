{####################################################################################}
{                                                                                    }
{       DATA  AUTOR              Descrição                                           }
{-----------  ------------------ ----------------------------------------------------}
{ 04/11/2016  guilherme.chiarini Criação de arquivo                                  }
{####################################################################################}

unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmProdutos, Vcl.Menus, ucadUnidade;

type
  TfrmPrincipal = class(TForm)
    mm1: TMainMenu;
    mnuCadastro1: TMenuItem;
    mnuProduto: TMenuItem;
    mnuUnidade: TMenuItem;
    procedure mnuProdutoClick(Sender: TObject);
    procedure mnuUnidadeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.mnuProdutoClick(Sender: TObject);
var cadProduto: TfrmCadProdutos;
begin
  cadProduto := TfrmCadProdutos.Create(self);
  try
    cadProduto.ShowModal;
  finally
    FreeAndNil(cadProduto);
  end;
end;

procedure TfrmPrincipal.mnuUnidadeClick(Sender: TObject);
var unidade: TfrmUnidade;
begin
  unidade := TfrmUnidade.Create(self);
  try
    unidade.ShowModal;
  finally
    FreeAndNil(unidade);
  end;
end;

end.
