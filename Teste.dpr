program Teste;

uses
  Vcl.Forms,
  uFrmProdutos in 'uFrmProdutos.pas' {frmCadProdutos},
  uDataModule in 'uDataModule.pas' {DM: TDataModule},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  ucadUnidade in 'ucadUnidade.pas' {frmUnidade},
  uobjProdutos in 'uobjProdutos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
