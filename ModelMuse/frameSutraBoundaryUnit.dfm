inherited frameSutraBoundary: TframeSutraBoundary
  inherited pnlBottom: TPanel
    inherited lblNumTimes: TLabel
      Top = 12
      ExplicitTop = 12
    end
    inherited seNumberOfTimes: TJvSpinEdit
      Left = 9
      Top = 9
      TabOrder = 2
      ExplicitLeft = 9
      ExplicitTop = 9
    end
    inherited btnDelete: TBitBtn
      Left = 236
      TabOrder = 1
      ExplicitLeft = 236
    end
    inherited btnInsert: TBitBtn
      TabOrder = 0
    end
  end
  inherited pnlGrid: TPanel
    Top = 81
    Height = 198
    ExplicitTop = 81
    ExplicitHeight = 198
    inherited rdgSutraFeature: TRbwDataGrid4
      Top = 51
      Height = 146
      TabOrder = 1
      OnMouseUp = rdgSutraFeatureMouseUp
      OnSelectCell = rdgSutraFeatureSelectCell
      OnSetEditText = rdgSutraFeatureSetEditText
      OnBeforeDrawCell = rdgSutraFeatureBeforeDrawCell
      OnColSize = rdgSutraFeatureColSize
      OnHorizontalScroll = rdgSutraFeatureHorizontalScroll
      Columns = <
        item
          AutoAdjustRowHeights = True
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = True
          Format = rcf4Real
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = True
          ButtonCaption = '...'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -13
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 20
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4Boolean
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = False
        end
        item
          AutoAdjustRowHeights = True
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = True
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = True
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = True
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end>
      OnEndUpdate = rdgSutraFeatureEndUpdate
      ExplicitTop = 51
      ExplicitHeight = 146
    end
    object pnlEditGrid: TPanel
      Left = 1
      Top = 1
      Width = 318
      Height = 50
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblFormula: TLabel
        Left = 136
        Top = 5
        Width = 38
        Height = 13
        Alignment = taCenter
        Caption = 'Formula'
      end
      object rdeFormula: TRbwDataEntry
        Left = 136
        Top = 24
        Width = 57
        Height = 22
        Color = clBtnFace
        Enabled = False
        TabOrder = 0
        OnChange = rdeFormulaChange
        Max = 1.000000000000000000
        ChangeDisabledColor = True
      end
      object cbUsed: TCheckBox
        Left = 63
        Top = 27
        Width = 67
        Height = 17
        Caption = 'Used'
        Enabled = False
        TabOrder = 1
        OnClick = cbUsedClick
      end
    end
  end
  inherited pnlTop: TPanel
    Height = 81
    ExplicitHeight = 81
    DesignSize = (
      320
      81)
    inherited lblSchedule: TLabel
      Left = 1
      Top = 30
      Width = 93
      Caption = 'Schedule (BCSSCH)'
      ExplicitLeft = 1
      ExplicitTop = 30
      ExplicitWidth = 93
    end
    inherited comboSchedule: TComboBox
      Left = 1
      Top = 49
      ExplicitLeft = 1
      ExplicitTop = 49
    end
  end
end
