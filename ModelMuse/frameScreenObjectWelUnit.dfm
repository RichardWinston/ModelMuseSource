inherited frameScreenObjectWel: TframeScreenObjectWel
  Height = 314
  ExplicitHeight = 314
  inherited pnlBottom: TPanel
    Top = 208
    Height = 106
    ExplicitTop = 208
    ExplicitHeight = 106
    DesignSize = (
      320
      106)
    object lblTabfile: TLabel [2]
      Left = 255
      Top = 83
      Width = 39
      Height = 16
      Caption = 'Tabfile'
    end
    object fedTabfile: TJvFilenameEdit
      Left = 8
      Top = 80
      Width = 241
      Height = 24
      Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
      TabOrder = 4
      OnChange = fedTabfileChange
    end
  end
  inherited pnlGrid: TPanel
    Height = 116
    ExplicitHeight = 116
    inherited dgModflowBoundary: TRbwDataGrid4
      Height = 64
      ExplicitHeight = 64
    end
  end
end
