{####################################################################################}
{                                                                                    }
{       DATA  AUTOR              Descrição                                           }
{-----------  ------------------ ----------------------------------------------------}
{ 04/11/2016  guilherme.chiarini Criação de arquivo                                  }
{####################################################################################}

unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DBXInterBase, Data.DB, Data.SqlExpr,
  Data.FMTBcd, Datasnap.Provider, Datasnap.DBClient, Data.DBXOdbc, Vcl.Forms,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdLPR, IdRawBase,
  IdRawClient, IdIcmpClient, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.ODBC, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.Client,
  FireDAC.Phys.ODBCDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    WCURSOR: TFDGUIxWaitCursor;
    CONEXAO: TFDConnection;
    procedure ICMPReply(ASender: TComponent; const ReplyStatus: TReplyStatus);
    procedure verificarconexao;

  private
    { Private declarations }
  public
    { Public declarations }
    Empresa_Atual: Integer;
    chusuario: Integer;
    DatahoraServidor: TDateTime;

    function execSql(strQry:string): boolean;

  end;

var
  DM: TDM;
  Respondeu: Boolean;
  ip: string;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses Winapi.Windows, IniFiles;

{$R *.dfm}

function TDM.execSql(strQry: string): boolean;
begin
end;

procedure TDM.ICMPReply(ASender: TComponent; const ReplyStatus: TReplyStatus);
var s: integer;
begin
  s := ReplyStatus.BytesReceived;
  if s=0 then Respondeu:=false else Respondeu:=true;
end;

procedure TDM.verificarconexao;
begin
  Application.ProcessMessages;
end;

end.
