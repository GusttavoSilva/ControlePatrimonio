object Dm: TDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 281
  Width = 259
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=patrimonio'
      'User_Name=root'
      'Password=1234'
      'Server=localhost'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 56
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 64
    Top = 112
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 64
    Top = 168
  end
end
