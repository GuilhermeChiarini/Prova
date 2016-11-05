{####################################################################################}
{                                                                                    }
{       DATA  AUTOR              Descrição                                           }
{-----------  ------------------ ----------------------------------------------------}
{ 04/11/2016  guilherme.chiarini Criação de arquivo                                  }
{####################################################################################}

unit ucadUnidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, dxSkinsCore, dxSkinsDefaultPainters, cxControls,
  dxSkinscxPCPainter, cxPCdxBarPopupMenu, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, cxPC,
  cxButtons, Vcl.ExtCtrls, Data.FMTBcd, Datasnap.Provider, Data.SqlExpr,
  Datasnap.DBClient, dxBarBuiltInMenu, cxNavigator, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmUnidade = class(TForm)
    pnl2: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    pnl8: TPanel;
    pnl9: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl10: TPanel;
    btnNovo: TcxButton;
    btnSalvar: TcxButton;
    btnCancelar: TcxButton;
    btnAlterar: TcxButton;
    btnExcluir: TcxButton;
    btnAnterior: TcxButton;
    btnProximo: TcxButton;
    btnSair: TcxButton;
    pnl11: TPanel;
    pnl12: TPanel;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    pnl5: TPanel;
    pnl6: TPanel;
    cxGrid7: TcxGrid;
    cxGridDBTableView6: TcxGridDBTableView;
    cxGridDBTableView6Column1: TcxGridDBColumn;
    cxGridDBTableView6Column2: TcxGridDBColumn;
    cxGridLevel6: TcxGridLevel;
    pnl1: TPanel;
    lbl13: TLabel;
    lbl14: TLabel;
    edtCHAVE: TDBEdit;
    edtDescricao: TDBEdit;
    dsUnidade: TDataSource;
    qryUnidade: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryUnidadechave: TIntegerField;
    qryUnidadetdescricao: TWideStringField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnNovoClick(Sender: TObject);
    procedure Controle;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function verificar_gen(Sequence: string): Integer;

  private
    { Private declarations }
  public
    { Public declarations }
    Aux_gnid: integer;

  end;

const UNIDADE = 'cad_unidade';

var
  frmUnidade: TfrmUnidade;

implementation

{$R *.dfm}

uses uDataModule;

procedure TfrmUnidade.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUnidade.btnSalvarClick(Sender: TObject);
begin
  if (qryUnidade.State in [dsInsert , dsEdit]) then
  begin
    if qryUnidade.FieldByName('TDESCRICAO').AsString = EmptyStr then
    begin
      Application.MessageBox(PChar('Insira o nome da unidade.'), PChar('Aviso'), MB_OK + MB_ICONINFORMATION);
      edtDescricao.Color := $006F6FFD;
      Abort;
    end
    else
    begin
      edtDescricao.Color := clWhite;
    end;

    if edtchave.text = emptystr then
    begin
      qryUnidade.FieldByName('CHAVE').asinteger := verificar_gen(UNIDADE);
    end;

    qryUnidade.Post;

    if qryUnidade.ApplyUpdates(0) <> 0 then
    begin
      Application.MessageBox(PChar('Erro ao gravar Unidade.'), PChar('Erro'), MB_OK + MB_ICONSTOP);
      Abort;
    end;
    qryUnidade.Close;
    qryUnidade.open;
  end;
  Controle;
end;

procedure TfrmUnidade.Controle;
begin
  if (qryUnidade.State in [dsInsert, dsEdit]) then
  begin
    btnSalvar.Enabled := True;
    btnCancelar.Enabled := True;
    btnNovo.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
    btnProximo.Enabled := False;
    btnAnterior.Enabled := False;
    edtCHAVE.ReadOnly := False;
    edtDescricao.ReadOnly := False;
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
    edtCHAVE.ReadOnly := True;
    edtDescricao.ReadOnly := True;
  end;
end;

procedure TfrmUnidade.btnAlterarClick(Sender: TObject);
begin
  qryUnidade.Edit;
  Controle;
end;

procedure TfrmUnidade.btnAnteriorClick(Sender: TObject);
begin
  qryUnidade.Prior;
end;

procedure TfrmUnidade.btnCancelarClick(Sender: TObject);
begin
  qryUnidade.Cancel;
  Controle;
end;

procedure TfrmUnidade.btnExcluirClick(Sender: TObject);
begin
  Controle;
  if Application.MessageBox(PChar('Deseja realmente excluir a unidade?'), PChar('Alerta'), MB_YESNO + MB_ICONWARNING) = IDYES then
  begin
    qryUnidade.Delete;
    if qryUnidade.ApplyUpdates(0) <> 0 then
    begin
      Application.MessageBox(PChar('Erro ao excluir unidade.'), PChar('Erro'), MB_OK + MB_ICONINFORMATION);
      Abort;
    end;
  end;
end;

procedure TfrmUnidade.btnNovoClick(Sender: TObject);
begin
  qryUnidade.Open;
  qryUnidade.Append;
  Controle;
  FocusControl(edtDescricao);
end;

procedure TfrmUnidade.btnProximoClick(Sender: TObject);
begin
  qryUnidade.Next;
end;

procedure TfrmUnidade.FormCreate(Sender: TObject);
begin
  Controle;
  qryUnidade.Open;
end;

procedure TfrmUnidade.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Close;
  end;
end;

function TfrmUnidade.verificar_gen(Sequence: string): Integer;
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
