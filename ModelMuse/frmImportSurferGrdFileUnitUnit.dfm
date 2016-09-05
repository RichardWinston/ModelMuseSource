inherited frmImportSurferGrdFile: TfrmImportSurferGrdFile
  HelpKeyword = 'Import_Surfer_Grid_File'
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  AutoSize = False
  Caption = 'Import Surfer Grid File'
  ClientHeight = 386
  ClientWidth = 603
  ExplicitWidth = 621
  ExplicitHeight = 433
  PixelsPerInch = 120
  TextHeight = 18
  inherited lblDataSet: TLabel
    Top = 148
    ExplicitTop = 148
  end
  inherited lblInterpolator: TLabel
    Top = 216
    ExplicitTop = 216
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 0
    Width = 99
    Height = 18
    Caption = 'Grid file extent'
  end
  inherited comboDataSets: TComboBox
    Top = 170
    Width = 569
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ExplicitTop = 170
    ExplicitWidth = 552
  end
  inherited comboInterpolators: TComboBox
    Top = 237
    TabOrder = 3
    ExplicitTop = 237
  end
  inherited cbEnclosedCells: TCheckBox
    Left = 496
    Top = 301
    Width = 41
    TabOrder = 6
    Visible = False
    ExplicitLeft = 496
    ExplicitTop = 301
    ExplicitWidth = 41
  end
  inherited cbIntersectedCells: TCheckBox
    Top = 269
    Width = 329
    TabOrder = 4
    ExplicitTop = 269
    ExplicitWidth = 329
  end
  inherited cbInterpolation: TCheckBox
    Top = 300
    Width = 321
    TabOrder = 5
    ExplicitTop = 300
    ExplicitWidth = 321
  end
  inherited rgEvaluatedAt: TRadioGroup
    Top = 337
    TabOrder = 7
    ExplicitTop = 337
  end
  inherited btnOK: TBitBtn
    Left = 398
    Top = 348
    TabOrder = 9
    OnClick = btnOKClick
    ExplicitLeft = 398
    ExplicitTop = 348
  end
  inherited btnCancel: TBitBtn
    Left = 495
    Top = 348
    TabOrder = 10
    ExplicitLeft = 495
    ExplicitTop = 348
  end
  inherited btnHelp: TBitBtn
    Left = 301
    Top = 348
    TabOrder = 8
    ExplicitLeft = 301
    ExplicitTop = 348
  end
  object rdgLimits: TRbwDataGrid4 [12]
    Left = 8
    Top = 21
    Width = 569
    Height = 121
    Anchors = [akLeft, akTop, akRight]
    ColCount = 4
    FixedCols = 1
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
    TabOrder = 0
    ExtendedAutoDistributeText = False
    AutoMultiEdit = True
    AutoDistributeText = False
    AutoIncreaseColCount = False
    AutoIncreaseRowCount = False
    SelectedRowOrColumnColor = clAqua
    UnselectableColor = clBtnFace
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
        Format = rcf4String
        LimitToList = False
        MaxLength = 0
        ParentButtonFont = False
        WordWrapCaptions = False
        WordWrapCells = False
        CaseSensitivePicklist = False
        CheckStyle = csCheck
        AutoAdjustColWidths = True
      end>
    WordWrapRowCaptions = False
    ExplicitWidth = 546
    ColWidths = (
      64
      64
      64
      64)
    RowHeights = (
      24
      24
      24)
  end
  object rgFilterMethod: TRadioGroup [13]
    Left = 343
    Top = 202
    Width = 252
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
    TabOrder = 2
  end
  inherited OpenDialogFile: TOpenDialog
    Filter = 'Surfer grid file (*.grd, *.dat)|*.grd;*.dat|All files (*.*)|*.*'
    Title = 'Open a Surfer grid file'
    Top = 216
  end
end
