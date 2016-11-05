unit uobjProdutos;

interface

uses System.Classes, FireDAC.Comp.Client, uDataModule, system.SysUtils;

type
  TProduto = class

  private
    FID: integer;
    FDescricao: string;
    FValor: Extended;

  public
    property ID          :integer  read FID;
    property Descricao   :string   read FDescricao;
    property Valor       :Extended read FValor;

    constructor Create(AOwner: TComponent; AchProduto: integer); reintroduce;

  published

  end;

implementation

{ TProduto }

constructor TProduto.Create(AOwner: TComponent; AchProduto: integer);
var qry_generica: TFDQuery;
begin
  inherited Create;

  qry_generica := TFDQuery.Create(nil);
  try
    qry_generica.Connection := DM.CONEXAO;
    qry_generica.Close;

    qry_generica.SQL.Clear;
    qry_generica.SQL.Add('select * from cad_produto WHERE chave = '+QuotedStr(IntToStr(AchProduto)));
    qry_generica.Open;

    FID := qry_generica.FieldByName('chave').AsInteger;
    FDescricao := qry_generica.FieldByName('tdescricao').AsString;
    FValor := qry_generica.FieldByName('nvalor').AsFloat;
  finally
    FreeAndNil(qry_generica);
  end;
end;

end.
