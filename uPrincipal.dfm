object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Sistemas'
  ClientHeight = 211
  ClientWidth = 457
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object mm1: TMainMenu
    Left = 192
    Top = 80
    object mnuCadastro1: TMenuItem
      Caption = 'Cadastro    '
      object mnuProduto: TMenuItem
        Caption = 'Produto'
        ShortCut = 16464
        OnClick = mnuProdutoClick
      end
      object mnuUnidade: TMenuItem
        Caption = 'Unidade'
        OnClick = mnuUnidadeClick
      end
    end
  end
end
