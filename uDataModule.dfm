object DM: TDM
  OldCreateOrder = False
  Height = 143
  Width = 176
  object WCURSOR: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 72
  end
  object CONEXAO: TFDConnection
    Params.Strings = (
      'User_Name=issoftware'
      'ConnectionDef=Teste')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 16
  end
end
