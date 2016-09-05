inherited frameMt3dBasicPkg: TframeMt3dBasicPkg
  Width = 528
  Height = 398
  ExplicitWidth = 528
  ExplicitHeight = 398
  DesignSize = (
    528
    398)
  object lblInactiveConcentration: TLabel [2]
    Left = 87
    Top = 149
    Width = 228
    Height = 16
    Caption = 'Concentration at inactive cells (CINACT)'
  end
  object lblMinimumSaturatedFraction: TLabel [3]
    Left = 87
    Top = 177
    Width = 216
    Height = 16
    Caption = 'Minimum saturated fraction (THKMIN)'
  end
  object rdeInactiveConcentration: TRbwDataEntry [4]
    Left = 16
    Top = 146
    Width = 65
    Height = 22
    Color = clBtnFace
    Enabled = False
    TabOrder = 2
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object rdeMinimumSaturatedFraction: TRbwDataEntry [5]
    Left = 16
    Top = 174
    Width = 65
    Height = 22
    Color = clBtnFace
    Enabled = False
    TabOrder = 3
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMax = True
    CheckMin = True
    ChangeDisabledColor = True
  end
  object pnlSpecies: TPanel [6]
    Left = 0
    Top = 264
    Width = 528
    Height = 134
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 5
    object Splitter1: TSplitter
      Left = 249
      Top = 1
      Width = 5
      Height = 132
      ExplicitLeft = 145
      ExplicitHeight = 115
    end
    inline frameGridImmobile: TframeGrid
      Left = 254
      Top = 1
      Width = 273
      Height = 132
      Align = alClient
      Enabled = False
      TabOrder = 0
      ExplicitLeft = 254
      ExplicitTop = 1
      ExplicitWidth = 273
      ExplicitHeight = 132
      inherited Panel: TPanel
        Top = 91
        Width = 273
        ExplicitTop = 91
        ExplicitWidth = 273
        inherited seNumber: TJvSpinEdit
          Height = 24
          ExplicitHeight = 24
        end
      end
      inherited Grid: TRbwDataGrid4
        Width = 273
        Height = 91
        ColCount = 3
        OnSelectCell = frameGridImmobileGridSelectCell
        OnButtonClick = frameGridSpeciesGridButtonClick
        Columns = <
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
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
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = False
            ButtonCaption = 'Select...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -13
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = True
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4String
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = False
            WordWrapCells = False
            CaseSensitivePicklist = False
            AutoAdjustColWidths = False
          end>
        ExplicitWidth = 273
        ExplicitHeight = 91
      end
    end
    inline frameGridMobile: TframeGrid
      Left = 1
      Top = 1
      Width = 248
      Height = 132
      Align = alLeft
      Enabled = False
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 248
      ExplicitHeight = 132
      inherited Panel: TPanel
        Top = 91
        Width = 248
        ExplicitTop = 91
        ExplicitWidth = 248
        inherited seNumber: TJvSpinEdit
          Height = 24
          ExplicitHeight = 24
        end
      end
      inherited Grid: TRbwDataGrid4
        Width = 248
        Height = 91
        ColCount = 3
        OnSelectCell = frameGridMobileGridSelectCell
        OnButtonClick = frameGridSpeciesGridButtonClick
        OnStateChange = frameSpeciesGridStateChange
        Columns = <
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
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
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = False
            ButtonCaption = 'Select...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -13
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = True
            ButtonWidth = 20
            CheckMax = False
            CheckMin = False
            ComboUsed = False
            Format = rcf4String
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = False
            WordWrapCells = False
            CaseSensitivePicklist = False
            AutoAdjustColWidths = True
          end>
        ExplicitWidth = 248
        ExplicitHeight = 91
      end
    end
  end
  object edMassUnit: TLabeledEdit [7]
    Left = 16
    Top = 119
    Width = 50
    Height = 24
    EditLabel.Width = 106
    EditLabel.Height = 16
    EditLabel.Caption = 'Mass unit (MUNIT)'
    Enabled = False
    LabelPosition = lpRight
    MaxLength = 4
    TabOrder = 1
  end
  object grpInitialConcentrationTimes: TGroupBox [8]
    Left = 16
    Top = 202
    Width = 509
    Height = 57
    Caption = 'Concentration file transport step for initial concentrations'
    TabOrder = 4
    object lblStressPeriod: TLabel
      Left = 16
      Top = 24
      Width = 76
      Height = 16
      Caption = 'Stress period'
    end
    object lblTimeStep: TLabel
      Left = 176
      Top = 24
      Width = 57
      Height = 16
      Caption = 'Time step'
    end
    object lblTransportStep: TLabel
      Left = 318
      Top = 24
      Width = 84
      Height = 16
      Caption = 'Transport step'
    end
    object seStressPeriod: TJvSpinEdit
      Left = 98
      Top = 22
      Width = 71
      Height = 24
      MaxValue = 2147483647.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 2
    end
    object seTimeStep: TJvSpinEdit
      Left = 241
      Top = 21
      Width = 71
      Height = 24
      MaxValue = 2147483647.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 0
    end
    object seTransportStep: TJvSpinEdit
      Left = 408
      Top = 21
      Width = 71
      Height = 24
      MaxValue = 2147483647.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 1
    end
  end
  inherited memoComments: TMemo
    Width = 497
    Height = 51
    ExplicitWidth = 497
    ExplicitHeight = 51
  end
  inherited rcSelectionController: TRbwController
    ControlList = <
      item
        Control = lblComments
      end
      item
        Control = memoComments
      end
      item
        Control = edMassUnit
      end
      item
        Control = rdeInactiveConcentration
      end
      item
        Control = rdeMinimumSaturatedFraction
      end
      item
        Control = frameGridImmobile
      end
      item
        Control = frameGridMobile
      end>
  end
  object dlgOpenSelectFile: TOpenDialog
    Filter = 'Concentration file (*.ucn)|*.ucn|All files (*.*)|*.*'
    Left = 352
    Top = 184
  end
end
