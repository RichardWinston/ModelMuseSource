inherited frmImportAsciiRaster: TfrmImportAsciiRaster
  AutoSize = True
  Width = 656
  HelpKeyword = 'Import_ASCII_Raster_File'
  Caption = 'Import ASCII Raster File'
  ExplicitWidth = 656
  PixelsPerInch = 120
  TextHeight = 18
  inherited lblDataSet: TLabel
    Top = 13
    ExplicitTop = 13
  end
  inherited lblInterpolator: TLabel
    Top = 67
    ExplicitTop = 67
  end
  inherited comboDataSets: TComboBox
    Top = 37
    Width = 488
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    ExplicitTop = 37
    ExplicitWidth = 488
  end
  inherited comboInterpolators: TComboBox
    Top = 91
    TabOrder = 4
    ExplicitTop = 91
  end
  inherited cbEnclosedCells: TCheckBox
    Left = 132
    Top = 0
    TabOrder = 0
    Visible = False
    ExplicitLeft = 132
    ExplicitTop = 0
  end
  inherited cbIntersectedCells: TCheckBox
    Top = 118
    TabOrder = 5
    ExplicitTop = 118
  end
  inherited cbInterpolation: TCheckBox
    Left = 8
    Top = 150
    TabOrder = 6
    ExplicitLeft = 8
    ExplicitTop = 150
  end
  inherited rgEvaluatedAt: TRadioGroup
    Top = 215
    TabOrder = 8
    ExplicitTop = 215
  end
  inherited btnOK: TBitBtn
    Left = 446
    Top = 230
    TabOrder = 10
    OnClick = btnOKClick
    ExplicitLeft = 446
    ExplicitTop = 230
  end
  inherited btnCancel: TBitBtn
    Left = 543
    Top = 230
    TabOrder = 11
    ExplicitLeft = 543
    ExplicitTop = 230
  end
  inherited btnHelp: TBitBtn
    Left = 351
    Top = 230
    TabOrder = 9
    ExplicitLeft = 351
    ExplicitTop = 230
  end
  object rgFilterMethod: TRadioGroup [11]
    Left = 360
    Top = 84
    Width = 240
    Height = 140
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Filter method'
    ItemIndex = 2
    Items.Strings = (
      'Lowest point in cell'
      'Highest point in cell'
      'Average of points in cell'
      'Point closest to cell center'
      'None')
    TabOrder = 3
    ExplicitWidth = 274
  end
  object rdgFilesAndDataSets: TRbwDataGrid4 [12]
    Left = 8
    Top = 8
    Width = 592
    Height = 53
    Anchors = [akLeft, akTop, akRight]
    ColCount = 3
    DefaultColWidth = 20
    FixedCols = 1
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowMoving, goEditing, goAlwaysShowEditor]
    TabOrder = 1
    Visible = False
    ExtendedAutoDistributeText = False
    AutoMultiEdit = False
    AutoDistributeText = True
    AutoIncreaseColCount = False
    AutoIncreaseRowCount = True
    SelectedRowOrColumnColor = clAqua
    UnselectableColor = clBtnFace
    OnButtonClick = rdgFilesAndDataSetsButtonClick
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
        AutoAdjustColWidths = False
      end
      item
        AutoAdjustRowHeights = False
        ButtonCaption = '...'
        ButtonFont.Charset = ANSI_CHARSET
        ButtonFont.Color = clBlack
        ButtonFont.Height = -16
        ButtonFont.Name = 'Arial'
        ButtonFont.Pitch = fpVariable
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
        CheckStyle = csCheck
        AutoAdjustColWidths = True
      end
      item
        AutoAdjustRowHeights = False
        ButtonCaption = '...'
        ButtonFont.Charset = ANSI_CHARSET
        ButtonFont.Color = clBlack
        ButtonFont.Height = -16
        ButtonFont.Name = 'Arial'
        ButtonFont.Pitch = fpVariable
        ButtonFont.Style = []
        ButtonUsed = False
        ButtonWidth = 20
        CheckMax = False
        CheckMin = False
        ComboUsed = True
        Format = rcf4String
        LimitToList = True
        MaxLength = 0
        ParentButtonFont = False
        WordWrapCaptions = False
        WordWrapCells = False
        CaseSensitivePicklist = False
        CheckStyle = csCheck
        AutoAdjustColWidths = True
      end>
    WordWrapRowCaptions = False
    ExplicitWidth = 626
  end
  object comboModel: TComboBox [13]
    Left = 8
    Top = 187
    Width = 281
    Height = 26
    Style = csDropDownList
    TabOrder = 7
  end
  inherited OpenDialogFile: TOpenDialog
    Filter = 'Text files (*.txt; *.asc)|*.txt;*.asc|All files (*.*)|*.*'
    FilterIndex = 1
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Open a ASCII raster file(s)'
    Left = 528
    Top = 23
  end
end
