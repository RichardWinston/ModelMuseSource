inherited framePkgSms: TframePkgSms
  Width = 495
  Height = 410
  ExplicitWidth = 495
  ExplicitHeight = 410
  DesignSize = (
    495
    410)
  object lblPrintOption: TLabel [2]
    Left = 16
    Top = 160
    Width = 55
    Height = 13
    Caption = 'Print option'
  end
  object lblComplexity: TLabel [3]
    Left = 152
    Top = 160
    Width = 53
    Height = 13
    Caption = 'Complexity'
  end
  object lblSolutionGroupMaxIter: TLabel [4]
    Left = 264
    Top = 160
    Width = 140
    Height = 13
    Caption = 'Solution group max iterations'
  end
  inherited memoComments: TMemo
    Width = 464
    ExplicitWidth = 464
  end
  object comboPrintOption: TJvImageComboBox [6]
    Left = 16
    Top = 187
    Width = 113
    Height = 23
    Style = csOwnerDrawVariable
    ButtonStyle = fsLighter
    Color = clBtnFace
    DroppedWidth = 145
    Enabled = False
    ImageHeight = 0
    ImageWidth = 0
    ItemHeight = 17
    ItemIndex = 2
    TabOrder = 1
    Items = <
      item
        Brush.Style = bsClear
        Indent = 0
        Text = 'None (0)'
      end
      item
        Brush.Style = bsClear
        Indent = 0
        Text = 'Summary (1)'
      end
      item
        Brush.Style = bsClear
        Indent = 0
        Text = 'Full (2)'
      end>
  end
  object comboComplexity: TJvImageComboBox [7]
    Left = 152
    Top = 187
    Width = 97
    Height = 23
    Style = csOwnerDrawVariable
    ButtonStyle = fsLighter
    Color = clBtnFace
    DroppedWidth = 145
    Enabled = False
    ImageHeight = 0
    ImageWidth = 0
    ItemHeight = 17
    ItemIndex = -1
    TabOrder = 2
    OnChange = comboComplexityChange
    Items = <
      item
        Brush.Style = bsClear
        Indent = 0
        Text = 'Simple'
      end
      item
        Brush.Style = bsClear
        Indent = 0
        Text = 'Moderate'
      end
      item
        Brush.Style = bsClear
        Indent = 0
        Text = 'Complex'
      end
      item
        Brush.Style = bsClear
        Indent = 0
        Text = 'Specified'
      end>
  end
  object rdgOptions: TRbwDataGrid4 [8]
    Left = 0
    Top = 248
    Width = 495
    Height = 162
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 3
    Enabled = False
    FixedCols = 1
    RowCount = 26
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
    TabOrder = 5
    OnSelectCell = rdgOptionsSelectCell
    OnSetEditText = rdgOptionsSetEditText
    ExtendedAutoDistributeText = False
    AutoMultiEdit = False
    AutoDistributeText = False
    AutoIncreaseColCount = False
    AutoIncreaseRowCount = False
    SelectedRowOrColumnColor = clAqua
    UnselectableColor = clBtnFace
    OnStateChange = rdgOptionsStateChange
    ColorRangeSelection = False
    Columns = <
      item
        AutoAdjustRowHeights = False
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
        WordWrapCaptions = False
        WordWrapCells = False
        CaseSensitivePicklist = False
        CheckStyle = csCheck
        AutoAdjustColWidths = True
      end
      item
        AutoAdjustRowHeights = False
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
        Format = rcf4Boolean
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
        AutoAdjustRowHeights = False
        ButtonCaption = '...'
        ButtonFont.Charset = DEFAULT_CHARSET
        ButtonFont.Color = clWindowText
        ButtonFont.Height = -11
        ButtonFont.Name = 'Tahoma'
        ButtonFont.Style = []
        ButtonUsed = False
        ButtonWidth = 20
        CheckMax = False
        CheckMin = True
        ComboUsed = False
        Format = rcf4Real
        LimitToList = True
        Max = 1.000000000000000000
        MaxLength = 0
        ParentButtonFont = False
        WordWrapCaptions = True
        WordWrapCells = False
        CaseSensitivePicklist = False
        CheckStyle = csCheck
        AutoAdjustColWidths = True
      end>
    WordWrapRowCaptions = False
    ColWidths = (
      84
      64
      64)
  end
  object seSolutionGroupMaxIter: TJvSpinEdit [9]
    Left = 264
    Top = 189
    Width = 121
    Height = 21
    MaxValue = 2147483647.000000000000000000
    MinValue = 1.000000000000000000
    Value = 1.000000000000000000
    Enabled = False
    TabOrder = 3
  end
  object cbContinue: TCheckBox [10]
    Left = 16
    Top = 216
    Width = 249
    Height = 17
    Caption = 'Continue even if no convergence'
    Enabled = False
    TabOrder = 4
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
        Control = comboPrintOption
      end
      item
        Control = comboComplexity
      end
      item
        Control = rdgOptions
      end
      item
        Control = seSolutionGroupMaxIter
      end
      item
        Control = cbContinue
      end>
  end
end
