inherited frameScreenObjectCondParam: TframeScreenObjectCondParam
  inherited pnlBottom: TPanel
    Top = 235
    Height = 81
    ExplicitTop = 235
    ExplicitHeight = 81
    DesignSize = (
      320
      81)
    object lblConductanceInterpretation: TLabel [1]
      Left = 8
      Top = 51
      Width = 154
      Height = 16
      Caption = 'Conductance interpretation'
    end
    object comboFormulaInterp: TComboBox
      Left = 174
      Top = 48
      Width = 145
      Height = 24
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'Calculated'
        'Direct'
        'Total per layer')
    end
  end
  inherited pnlGrid: TPanel
    Height = 143
    ExplicitHeight = 143
    inherited dgModflowBoundary: TRbwDataGrid4
      Height = 91
      ExplicitHeight = 91
    end
  end
end
