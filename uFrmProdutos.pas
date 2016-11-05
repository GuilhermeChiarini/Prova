{####################################################################################}
{                                                                                    }
{       DATA  AUTOR              Descrição                                           }
{-----------  ------------------ ----------------------------------------------------}
{ 04/11/2016  guilherme.chiarini Criação de arquivo                                  }
{####################################################################################}

unit uFrmProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls,
  cxControls, dxBarBuiltInMenu, Vcl.DBCtrls, Vcl.Mask, cxPC, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDataModule, ucadUnidade, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, uobjProdutos;

type
  TfrmCadProdutos = class(TForm)
    pnl3: TPanel;
    pnl4: TPanel;
    pnl25: TPanel;
    pnl26: TPanel;
    pnl27: TPanel;
    btnNovo: TcxButton;
    btnSalvar: TcxButton;
    btnCancelar: TcxButton;
    btnAlterar: TcxButton;
    btnExcluir: TcxButton;
    btnAnterior: TcxButton;
    btnProximo: TcxButton;
    btnSair: TcxButton;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    edtDescricao: TDBEdit;
    lblDescricao: TLabel;
    cboUnidade: TDBLookupComboBox;
    lblUnidade: TLabel;
    btnunidade: TcxButton;
    chkInativo: TDBCheckBox;
    edtValor: TDBEdit;
    lbl1: TLabel;
    qryProdutos: TFDQuery;
    dsProdutos: TDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryProdutoschave: TIntegerField;
    qryProdutostdescricao: TWideStringField;
    qryProdutosnchunidade: TIntegerField;
    qryProdutosnvalor: TFloatField;
    qryProdutoslativo: TWideStringField;
    qryUnidade: TFDQuery;
    qryUnidadechave: TIntegerField;
    qryUnidadetdescricao: TWideStringField;
    dsUnidade: TDataSource;
    cxGrid7: TcxGrid;
    cxGridDBTableView6: TcxGridDBTableView;
    cxGridDBTableView6Column1: TcxGridDBColumn;
    cxGridDBTableView6Column2: TcxGridDBColumn;
    cxGridLevel6: TcxGridLevel;
    cxGridDBTableView6Column3: TcxGridDBColumn;
    procedure btnAlterarClick(Sender: TObject);
    procedure controle;
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    function verificar_gen(Sequence: string): Integer;
    procedure btnunidadeClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const cad_produto = 'cad_produto';
var
  frmCadProdutos: TfrmCadProdutos;

implementation

{$R *.dfm}

procedure TfrmCadProdutos.btnAlterarClick(Sender: TObject);
begin
  qryProdutos.Edit;
  Controle;
end;

procedure TfrmCadProdutos.btnAnteriorClick(Sender: TObject);
begin
  qryProdutos.Prior;
end;

procedure TfrmCadProdutos.btnCancelarClick(Sender: TObject);
begin
  qryProdutos.cancel;
  controle;
end;

procedure TfrmCadProdutos.btnExcluirClick(Sender: TObject);
begin
  Controle;
  if Application.MessageBox(PChar('Deseja realmente excluir o produto?'), PChar('Erro'), MB_YESNO +MB_ICONWARNING) = IDYES then
  begin
    qryProdutos.Delete;
    qryProdutos.ApplyUpdates(0);

    qryProdutos.Close;
    qryProdutos.Open;
  end;
end;

procedure TfrmCadProdutos.btnNovoClick(Sender: TObject);
begin
  qryProdutos.Close;
  qryProdutos.Open;
  qryUnidade.open;
  qryProdutos.Append;
  Controle;
end;

procedure TfrmCadProdutos.btnProximoClick(Sender: TObject);
begin
  qryProdutos.next;
end;

procedure TfrmCadProdutos.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadProdutos.btnSalvarClick(Sender: TObject);
var produto: Tproduto;
    chave: Integer;
    descricao: string;
    valor: extended;
begin
  if (qryProdutos.State in [dsInsert , dsEdit]) then
  begin
    if qryProdutos.FieldByName('TDESCRICAO').AsString = EmptyStr then
    begin
      Application.MessageBox('Insira a descrição do produto!', 'Aviso', MB_OK + MB_ICONINFORMATION);
      edtDescricao.Color := $006F6FFD;
      FocusControl(edtDescricao);
      Abort;
    end;

    {#######################
    # Exemplo  simples de
    # orientação objeto
    #########################}
    produto := Tproduto.Create(Self, qryProdutos.FieldByName('chave').AsInteger);
    try
      chave := produto.ID;
      descricao := produto.Descricao;
      valor := produto.Valor;
    finally
      FreeAndNil(produto);
    end;

    if chkInativo.Checked then
    begin
      qryProdutos.FieldByName('lativo').AsString := 'T';
    end
    else
    begin
      qryProdutos.FieldByName('lativo').AsString := 'F';
    end;

    if edtCodigo.Text = emptystr then
    begin
      qryProdutos.FieldByName('CHAVE').AsInteger := verificar_gen(cad_produto);
    end;

    qryProdutos.Post;

    if qryProdutos.ApplyUpdates(0) <> 0 then
    begin
       Application.MessageBox('Erro ao gravar Produto!', 'Erro', MB_OK + MB_ICONSTOP);
    end;

    qryprodutos.close;
    qryprodutos.open;
  end;
  Controle;
end;

procedure TfrmCadProdutos.btnunidadeClick(Sender: TObject);
var unidade: TfrmUnidade;
begin
  unidade := TfrmUnidade.Create(self);
  try
    unidade.ShowModal;

    qryUnidade.Close;
    qryUnidade.Open;
  finally
    FreeAndNil(unidade);
  end;
end;

procedure TfrmCadProdutos.controle;
begin
  if (qryProdutos.State in [dsInsert, dsEdit]) then
  begin
    btnSalvar.Enabled := True;
    btnCancelar.Enabled := True;
    btnNovo.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
    btnProximo.Enabled := False;
    btnAnterior.Enabled := False;
    chkInativo.ReadOnly := false;
    cboUnidade.Enabled := true;
    edtDescricao.ReadOnly := false;
    edtValor.ReadOnly := False;
  end
  else
  begin
    btnSalvar.Enabled := False;
    btnCancelar.Enabled := False;
    btnNovo.Enabled := true;
    btnAlterar.Enabled := True;
    btnExcluir.Enabled := True;
    btnProximo.Enabled := True;
    btnAnterior.Enabled := True;
    chkInativo.ReadOnly := True;
    cboUnidade.Enabled := False;
    edtDescricao.ReadOnly := True;
    edtValor.ReadOnly := true;
  end;
end;

procedure TfrmCadProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryProdutos.close;
  qryUnidade.close;
end;

procedure TfrmCadProdutos.FormShow(Sender: TObject);
begin
  qryProdutos.Open;
  qryUnidade.open;
  controle;
end;

function TfrmCadProdutos.verificar_gen(Sequence: string): Integer;
  var qrySequence : TFDQuery;
begin
  Result := 0;
  qrySequence := TFDQuery.Create(nil);
  try
    qrySequence.Connection := DM.CONEXAO;
    qrySequence.Close;

    qrySequence.SQL.Clear;
    qrySequence.SQL.Add('select max(chave) nextval from '+Sequence);
    qrySequence.Open;

    Result := qrySequence.FieldByName('nextval').AsInteger + 1;
  finally
    qrySequence.Free;
  end;
end;

end.
