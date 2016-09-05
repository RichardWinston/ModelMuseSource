inherited frmMeshInformation: TfrmMeshInformation
  HelpType = htKeyword
  HelpKeyword = 'Mesh_Information_Dialog_Box'
  Caption = 'Mesh Information'
  ClientHeight = 396
  ClientWidth = 522
  ExplicitWidth = 540
  ExplicitHeight = 443
  PixelsPerInch = 120
  TextHeight = 18
  object pnl1: TPanel
    Left = 0
    Top = 355
    Width = 522
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 152
    ExplicitWidth = 302
    object btnHelp: TBitBtn
      AlignWithMargins = True
      Left = 264
      Top = 6
      Width = 89
      Height = 33
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
    object btnOK: TBitBtn
      Left = 359
      Top = 6
      Width = 89
      Height = 33
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 522
    Height = 81
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 302
    object lblBandwidth: TLabel
      Left = 8
      Top = 8
      Width = 77
      Height = 18
      Caption = 'Bandwidth:'
    end
    object lblNumberOfNodes: TLabel
      Left = 8
      Top = 32
      Width = 123
      Height = 18
      Caption = 'Number of nodes:'
    end
    object lblNumberOfElements: TLabel
      Left = 8
      Top = 56
      Width = 143
      Height = 18
      Caption = 'Number of elements:'
    end
  end
  object pc1: TPageControl
    Left = 0
    Top = 81
    Width = 522
    Height = 274
    ActivePage = tabElementCounts
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 302
    ExplicitHeight = 71
    object tabElementAngles: TTabSheet
      Caption = 'Element Angles'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object splitterVertical: TSplitter
        Left = 297
        Top = 41
        Width = 5
        Height = 200
        Align = alRight
        ExplicitLeft = 277
        ExplicitTop = 128
        ExplicitHeight = 236
      end
      object pbHistogram: TPaintBox
        Left = 0
        Top = 41
        Width = 297
        Height = 200
        Align = alClient
        OnPaint = pbHistogramPaint
        ExplicitLeft = -1
        ExplicitTop = 39
        ExplicitWidth = 299
        ExplicitHeight = 209
      end
      object pnl3: TPanel
        Left = 0
        Top = 0
        Width = 514
        Height = 41
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 516
        object lblBinSize: TLabel
          Left = 137
          Top = 8
          Width = 55
          Height = 18
          Caption = 'Bin size'
        end
        object seBinSize: TJvSpinEdit
          Left = 10
          Top = 5
          Width = 121
          Height = 26
          MaxValue = 360.000000000000000000
          MinValue = 1.000000000000000000
          Value = 10.000000000000000000
          TabOrder = 0
          OnChange = seBinSizeChange
        end
      end
      object pnl4: TPanel
        Left = 302
        Top = 41
        Width = 212
        Height = 200
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitLeft = 304
        ExplicitHeight = 209
        object splHorizontal: TSplitter
          Left = 0
          Top = 104
          Width = 212
          Height = 5
          Cursor = crVSplit
          Align = alTop
          ExplicitWidth = 172
        end
        object rdgBadElements: TRbwDataGrid4
          Left = 0
          Top = 0
          Width = 212
          Height = 104
          Align = alTop
          ColCount = 1
          DefaultColWidth = 160
          FixedCols = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          TabOrder = 0
          ExtendedAutoDistributeText = False
          AutoMultiEdit = False
          AutoDistributeText = False
          AutoIncreaseColCount = False
          AutoIncreaseRowCount = False
          SelectedRowOrColumnColor = clAqua
          UnselectableColor = clBtnFace
          OnButtonClick = rdgBadElementsButtonClick
          ColorRangeSelection = False
          Columns = <
            item
              AutoAdjustRowHeights = True
              ButtonCaption = 'Go to'
              ButtonFont.Charset = DEFAULT_CHARSET
              ButtonFont.Color = clWindowText
              ButtonFont.Height = -11
              ButtonFont.Name = 'Tahoma'
              ButtonFont.Style = []
              ButtonUsed = True
              ButtonWidth = 60
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
          ColWidths = (
            160)
          RowHeights = (
            24
            24
            24
            24
            24)
        end
        object rdgElementAngles: TRbwDataGrid4
          Left = 0
          Top = 109
          Width = 212
          Height = 91
          Align = alClient
          ColCount = 2
          DefaultColWidth = 80
          FixedCols = 1
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          TabOrder = 1
          ExtendedAutoDistributeText = False
          AutoMultiEdit = False
          AutoDistributeText = False
          AutoIncreaseColCount = False
          AutoIncreaseRowCount = False
          SelectedRowOrColumnColor = clAqua
          UnselectableColor = clBtnFace
          OnButtonClick = rdgElementAnglesButtonClick
          ColorRangeSelection = False
          Columns = <
            item
              AutoAdjustRowHeights = False
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
              AutoAdjustRowHeights = True
              ButtonCaption = 'Go to'
              ButtonFont.Charset = DEFAULT_CHARSET
              ButtonFont.Color = clWindowText
              ButtonFont.Height = -11
              ButtonFont.Name = 'Tahoma'
              ButtonFont.Style = []
              ButtonUsed = True
              ButtonWidth = 60
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
          ExplicitHeight = 100
          ColWidths = (
            55
            125)
          RowHeights = (
            24
            24
            24
            24
            24)
        end
      end
    end
    object tabAspectRatio: TTabSheet
      Caption = 'Aspect Ratios'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object splAspectRatio: TSplitter
        Left = 509
        Top = 41
        Width = 5
        Height = 200
        Align = alRight
        ExplicitLeft = 325
        ExplicitTop = 4
        ExplicitHeight = 250
      end
      object pbAspectRatio: TPaintBox
        Left = 0
        Top = 41
        Width = 305
        Height = 200
        Align = alClient
        OnPaint = pbAspectRatioPaint
        ExplicitLeft = 153
        ExplicitTop = 39
        ExplicitWidth = 157
        ExplicitHeight = 209
      end
      object rdgAspectRatio: TRbwDataGrid4
        Left = 305
        Top = 41
        Width = 204
        Height = 200
        Align = alRight
        ColCount = 2
        DefaultColWidth = 80
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 1
        ExtendedAutoDistributeText = False
        AutoMultiEdit = False
        AutoDistributeText = False
        AutoIncreaseColCount = False
        AutoIncreaseRowCount = False
        SelectedRowOrColumnColor = clAqua
        UnselectableColor = clBtnFace
        OnButtonClick = rdgAspectRatioButtonClick
        ColorRangeSelection = False
        Columns = <
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
            Format = rcf4String
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
            ButtonCaption = 'Go to'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = True
            ButtonWidth = 60
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
        ExplicitLeft = 307
        ExplicitHeight = 209
        ColWidths = (
          74
          95)
        RowHeights = (
          24
          24
          24
          24
          24)
      end
      object pnlAspectRatio: TPanel
        Left = 0
        Top = 0
        Width = 514
        Height = 41
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 516
        object lblAspectRatioBinSize: TLabel
          Left = 137
          Top = 8
          Width = 55
          Height = 18
          Caption = 'Bin size'
        end
        object seAspectRatioBinSize: TJvSpinEdit
          Left = 10
          Top = 5
          Width = 121
          Height = 26
          Increment = 0.100000000000000000
          MaxValue = 2147483647.000000000000000000
          ValueType = vtFloat
          Value = 0.100000000000000000
          TabOrder = 0
          OnChange = seAspectRatioBinSizeChange
        end
      end
    end
    object tabElementCounts: TTabSheet
      Caption = 'Elements per Node'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 294
      ExplicitHeight = 38
      object splNodes: TSplitter
        Left = 305
        Top = 0
        Width = 5
        Height = 241
        Align = alRight
        ExplicitLeft = 325
        ExplicitTop = 4
        ExplicitHeight = 250
      end
      object pbElementPerNode: TPaintBox
        Left = 0
        Top = 0
        Width = 305
        Height = 241
        Align = alClient
        OnPaint = pbElementPerNodePaint
        ExplicitLeft = 149
        ExplicitTop = -2
        ExplicitWidth = 157
        ExplicitHeight = 250
      end
      object rdgNodes: TRbwDataGrid4
        Left = 310
        Top = 0
        Width = 204
        Height = 241
        Align = alRight
        ColCount = 2
        DefaultColWidth = 80
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        ExtendedAutoDistributeText = False
        AutoMultiEdit = False
        AutoDistributeText = False
        AutoIncreaseColCount = False
        AutoIncreaseRowCount = False
        SelectedRowOrColumnColor = clAqua
        UnselectableColor = clBtnFace
        OnButtonClick = rdgNodesButtonClick
        ColorRangeSelection = False
        Columns = <
          item
            AutoAdjustRowHeights = False
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
            AutoAdjustRowHeights = True
            ButtonCaption = 'Go to'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = True
            ButtonWidth = 60
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
        ExplicitLeft = 90
        ExplicitHeight = 38
        ColWidths = (
          74
          95)
        RowHeights = (
          24
          24
          24
          24
          24)
      end
    end
  end
end
