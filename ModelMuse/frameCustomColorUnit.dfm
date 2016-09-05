object frameCustomColor: TframeCustomColor
  Left = 0
  Top = 0
  Width = 570
  Height = 428
  TabOrder = 0
  OnResize = FrameResize
  object pcChoices: TPageControl
    Left = 0
    Top = 0
    Width = 570
    Height = 428
    ActivePage = tabSelection
    Align = alClient
    TabOrder = 0
    object tabSelection: TTabSheet
      Caption = 'Selection'
      DesignSize = (
        562
        397)
      object lblDataSet: TLabel
        Left = 8
        Top = 4
        Width = 175
        Height = 16
        Caption = 'Data set or boundary condition'
      end
      object lblComment: TLabel
        Left = 8
        Top = 61
        Width = 171
        Height = 16
        Caption = 'Data set comment (read only)'
      end
      object udDataSets: TJvUpDown
        Left = 479
        Top = 28
        Width = 21
        Height = 25
        Anchors = [akTop, akRight]
        TabOrder = 1
        OnChangingEx = udDataSetsChangingEx
      end
      object virttreecomboDataSets: TRbwStringTreeCombo
        Left = 8
        Top = 25
        Width = 465
        Height = 24
        Tree.Left = 0
        Tree.Top = 0
        Tree.Width = 302
        Tree.Height = 193
        Tree.Align = alClient
        Tree.Header.AutoSizeIndex = 0
        Tree.Header.Font.Charset = DEFAULT_CHARSET
        Tree.Header.Font.Color = clWindowText
        Tree.Header.Font.Height = -11
        Tree.Header.Font.Name = 'Tahoma'
        Tree.Header.Font.Style = []
        Tree.Header.MainColumn = -1
        Tree.TabOrder = 0
        Tree.TreeOptions.SelectionOptions = [toFullRowSelect]
        Tree.OnChange = virttreecomboDataSetsTreeChange
        Tree.OnGetText = virttreecomboDataSetsTreeGetText
        Tree.OnInitNode = virttreecomboDataSetsTreeInitNode
        Tree.ExplicitWidth = 200
        Tree.ExplicitHeight = 100
        Tree.Columns = <>
        Enabled = True
        Glyph.Data = {
          36020000424D3602000000000000360000002800000010000000080000000100
          2000000000000002000000000000000000000000000000000000D8E9EC00D8E9
          EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00D8E9EC0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00D8E9EC00C0C0C000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00C0C0C000C0C0C000C0C0C000D8E9EC00D8E9EC00D8E9EC00D8E9EC000000
          000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000D8E9EC00D8E9EC00000000000000
          00000000000000000000000000000000000000000000D8E9EC00C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000D8E9EC00D8E9EC00D8E9
          EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
          EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}
        NumGlyphs = 2
        TabOrder = 0
        OnChange = virttreecomboDataSetsChange
      end
      object reComment: TRichEdit
        Left = 8
        Top = 83
        Width = 549
        Height = 67
        Anchors = [akLeft, akTop, akRight, akBottom]
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 2
        Zoom = 100
      end
      object Panel1: TPanel
        Left = 0
        Top = 152
        Width = 562
        Height = 245
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
        DesignSize = (
          562
          245)
        object lblColorScheme: TLabel
          Left = 24
          Top = 92
          Width = 78
          Height = 16
          Anchors = [akTop, akRight]
          Caption = 'Color scheme'
        end
        object lblCycles: TLabel
          Left = 434
          Top = 119
          Width = 36
          Height = 16
          Anchors = [akTop, akRight]
          Caption = 'Cycles'
        end
        object pbColorScheme: TPaintBox
          Left = 19
          Top = 156
          Width = 359
          Height = 33
          Anchors = [akTop, akRight]
          OnPaint = pbColorSchemePaint
        end
        object lblColorAdjustment: TLabel
          Left = 24
          Top = 195
          Width = 98
          Height = 16
          Anchors = [akTop, akRight]
          Caption = 'Color adjustment'
        end
        object rgUpdateLimitChoice: TRadioGroup
          Left = 24
          Top = 12
          Width = 297
          Height = 73
          Anchors = [akTop, akRight]
          Caption = 'When changing data sets:'
          ItemIndex = 0
          Items.Strings = (
            'Update limits and legend (default)'
            'Retain limits and legend (animations)')
          TabOrder = 0
        end
        object btnColorSchemes: TButton
          Left = 338
          Top = 32
          Width = 183
          Height = 41
          Anchors = [akTop, akRight]
          Cancel = True
          Caption = 'Edit custom color schemes'
          TabOrder = 1
          WordWrap = True
          OnClick = btnColorSchemesClick
        end
        object comboColorScheme: TComboBox
          Left = 24
          Top = 111
          Width = 404
          Height = 24
          Style = csDropDownList
          Anchors = [akTop, akRight]
          DropDownCount = 12
          ItemIndex = 0
          TabOrder = 2
          Text = 'Rainbow'
          OnChange = comboColorSchemeChange
          Items.Strings = (
            'Rainbow'
            'Green to Magenta'
            'Blue to Red'
            'Blue to Dark Orange'
            'Blue to Green'
            'Brown to Blue'
            'Blue to Gray'
            'Blue to Orange'
            'Blue to Orange-Red'
            'Light Blue to Dark Blue'
            'Modified Spectral Scheme'
            'Stepped Sequential')
        end
        object seCycles: TJvSpinEdit
          Left = 434
          Top = 156
          Width = 101
          Height = 24
          ButtonKind = bkClassic
          MaxValue = 2147483647.000000000000000000
          MinValue = 1.000000000000000000
          Value = 1.000000000000000000
          Anchors = [akTop, akRight]
          TabOrder = 3
          OnChange = seCyclesChange
          OnKeyUp = seCyclesKeyUp
        end
        object jsColorExponent: TJvxSlider
          Left = 20
          Top = 211
          Width = 150
          Height = 40
          Increment = 2
          MaxValue = 200
          TabOrder = 4
          Value = 40
          Anchors = [akTop, akRight]
          OnChange = jsColorExponentChange
        end
        object seColorExponent: TJvSpinEdit
          Left = 176
          Top = 222
          Width = 65
          Height = 24
          ButtonKind = bkClassic
          Increment = 0.010000000000000000
          MaxValue = 2.000000000000000000
          ValueType = vtFloat
          Value = 0.400000000000000000
          Anchors = [akTop, akRight]
          TabOrder = 5
          OnChange = seColorExponentChange
        end
        object cbLogTransform: TCheckBox
          Left = 263
          Top = 226
          Width = 137
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Log transform'
          TabOrder = 6
        end
      end
    end
    object tabFilters: TTabSheet
      Caption = 'Filters'
      ImageIndex = 1
      DesignSize = (
        562
        397)
      object lblLowerLimit: TLabel
        Left = 8
        Top = 3
        Width = 63
        Height = 16
        Caption = 'Lower limit'
      end
      object lblUpperLimit: TLabel
        Left = 299
        Top = 3
        Width = 62
        Height = 16
        Caption = 'Upper limit'
      end
      object lblValuesToIgnore: TLabel
        Left = 8
        Top = 81
        Width = 93
        Height = 16
        Caption = 'Values to ignore'
      end
      object lblNumberOfValuesToIgnore: TLabel
        Left = 130
        Top = 370
        Width = 155
        Height = 16
        Anchors = [akLeft, akBottom]
        Caption = 'Number of values to ignore'
      end
      object lblEpsilon: TLabel
        Left = 203
        Top = 81
        Width = 142
        Height = 16
        Caption = 'Epsilon (margin of error)'
      end
      inline frameCheck3DMax: TframeDisplayLimit
        Left = 299
        Top = 24
        Width = 243
        Height = 35
        HorzScrollBar.Range = 188
        VertScrollBar.Range = 30
        TabOrder = 1
        TabStop = True
        ExplicitLeft = 299
        ExplicitTop = 24
        inherited rdeLimit: TRbwDataEntry
          Height = 28
          TabOrder = 0
          ExplicitHeight = 28
        end
        inherited comboBoolLimit: TComboBox
          Left = 89
          TabOrder = 1
          ExplicitLeft = 89
        end
      end
      inline frameCheck3DMin: TframeDisplayLimit
        Left = 8
        Top = 24
        Width = 243
        Height = 35
        HorzScrollBar.Range = 188
        VertScrollBar.Range = 30
        TabOrder = 0
        TabStop = True
        ExplicitLeft = 8
        ExplicitTop = 24
        inherited rdeLimit: TRbwDataEntry
          Height = 28
          ExplicitHeight = 28
        end
      end
      object cbActiveOnly: TCheckBox
        Left = 8
        Top = 58
        Width = 97
        Height = 17
        Caption = 'Only active'
        TabOrder = 2
      end
      object rdgValuesToIgnore: TRbwDataGrid4
        Left = 8
        Top = 112
        Width = 177
        Height = 249
        Anchors = [akLeft, akTop, akBottom]
        ColCount = 1
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
        TabOrder = 3
        ExtendedAutoDistributeText = False
        AutoMultiEdit = True
        AutoDistributeText = True
        AutoIncreaseColCount = False
        AutoIncreaseRowCount = True
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
          end>
        OnEndUpdate = rdgValuesToIgnoreEndUpdate
        WordWrapRowCaptions = False
      end
      object seNumberOfValuesToIgnore: TJvSpinEdit
        Left = 8
        Top = 367
        Width = 121
        Height = 24
        CheckMinValue = True
        ButtonKind = bkClassic
        Anchors = [akLeft, akBottom]
        TabOrder = 5
        OnChange = seNumberOfValuesToIgnoreChange
      end
      object rdeEpsilon: TRbwDataEntry
        Left = 203
        Top = 112
        Width = 145
        Height = 22
        TabOrder = 4
        Text = '0'
        DataType = dtReal
        Max = 1.000000000000000000
        CheckMin = True
        ChangeDisabledColor = True
      end
    end
    object tabLegend: TTabSheet
      Caption = 'Legend'
      ImageIndex = 2
      TabVisible = False
      object imLegend: TImage
        Left = 206
        Top = 0
        Width = 356
        Height = 397
        Align = alClient
        ExplicitLeft = 224
        ExplicitTop = -2
        ExplicitWidth = 380
        ExplicitHeight = 335
      end
      object splColor: TSplitter
        Left = 201
        Top = 0
        Width = 5
        Height = 397
        ExplicitLeft = 218
        ExplicitHeight = 400
      end
      object pnlLegend: TPanel
        Left = 0
        Top = 0
        Width = 201
        Height = 397
        Align = alLeft
        BevelInner = bvRaised
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          201
          397)
        object lblMethod: TLabel
          Left = 8
          Top = 6
          Width = 42
          Height = 16
          Caption = 'Method'
        end
        object lblColorLegendRows: TLabel
          Left = 8
          Top = 303
          Width = 92
          Height = 16
          Anchors = [akLeft, akBottom]
          Caption = 'Number of rows'
        end
        object comboMethod: TComboBox
          Left = 8
          Top = 27
          Width = 145
          Height = 24
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'Automatic'
          OnChange = comboMethodChange
          Items.Strings = (
            'Automatic'
            'Manual')
        end
        object seLegendRows: TJvSpinEdit
          Left = 8
          Top = 322
          Width = 121
          Height = 24
          CheckMaxValue = False
          ButtonKind = bkClassic
          MinValue = 1.000000000000000000
          Value = 1.000000000000000000
          Enabled = False
          Anchors = [akLeft, akBottom]
          TabOrder = 2
          OnChange = seLegendRowsChange
        end
        object rdgLegend: TRbwDataGrid4
          Left = 8
          Top = 59
          Width = 184
          Height = 238
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clBtnFace
          ColCount = 1
          Enabled = False
          FixedCols = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
          TabOrder = 1
          OnSetEditText = rdgLegendSetEditText
          ExtendedAutoDistributeText = False
          AutoMultiEdit = True
          AutoDistributeText = True
          AutoIncreaseColCount = False
          AutoIncreaseRowCount = True
          SelectedRowOrColumnColor = clAqua
          UnselectableColor = clBtnFace
          OnStateChange = rdgLegendStateChange
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
            end>
          OnEndUpdate = rdgLegendEndUpdate
          WordWrapRowCaptions = False
        end
        object btnFont: TButton
          Left = 8
          Top = 360
          Width = 75
          Height = 25
          Caption = 'Font'
          TabOrder = 3
          OnClick = btnFontClick
        end
      end
    end
  end
  object timerLegend: TTimer
    Interval = 100
    OnTimer = timerLegendTimer
    Left = 264
    Top = 40
  end
  object dlgFontLegend: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 160
    Top = 352
  end
end
