object frmImportShapeFile: TfrmImportShapeFile
  Left = 264
  Top = 223
  HelpType = htKeyword
  HelpKeyword = 'Import_Shapefile_Dialog_Box'
  ActiveControl = btnHelp
  Caption = 'Import Shapefile'
  ClientHeight = 553
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 120
  TextHeight = 16
  object pnlButton: TPanel
    Left = 0
    Top = 512
    Width = 779
    Height = 41
    Align = alBottom
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      779
      41)
    object lblNumShapes: TLabel
      Left = 10
      Top = 10
      Width = 117
      Height = 16
      Caption = 'Number of shapes ='
    end
    object btnCancel: TBitBtn
      Left = 656
      Top = 2
      Width = 115
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnOK: TBitBtn
      Left = 536
      Top = 2
      Width = 115
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnHelp: TBitBtn
      Left = 415
      Top = 2
      Width = 115
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
  end
  object pcImportShape: TPageControl
    Left = 0
    Top = 0
    Width = 779
    Height = 512
    ActivePage = tabOptions
    Align = alClient
    TabOrder = 0
    object tabOptions: TTabSheet
      Caption = 'Options'
      ImageIndex = 3
      DesignSize = (
        771
        481)
      object lblImportCriterion: TLabel
        Left = 8
        Top = 154
        Width = 89
        Height = 16
        Caption = 'Import criterion'
      end
      object lblCombineShapes: TLabel
        Left = 8
        Top = 187
        Width = 111
        Height = 16
        Caption = 'Import shapes as...'
      end
      object lblVisibility: TLabel
        Left = 8
        Top = 219
        Width = 155
        Height = 16
        Caption = 'Imported shapes should be'
      end
      object lblZ: TLabel
        Left = 8
        Top = 355
        Width = 72
        Height = 16
        Caption = 'Z-coordinate'
        Enabled = False
      end
      object lblHighZ: TLabel
        Left = 8
        Top = 387
        Width = 113
        Height = 16
        Caption = 'Higher Z-coordinate'
        Enabled = False
      end
      object lblLowZ: TLabel
        Left = 8
        Top = 420
        Width = 111
        Height = 16
        Caption = 'Lower Z-coordinate'
        Enabled = False
      end
      object cbImportObjects: TCheckBox
        Left = 7
        Top = 0
        Width = 315
        Height = 25
        Caption = 'Import shapes as objects'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbImportObjectsClick
      end
      object cbEnclosedCells: TCheckBox
        Left = 7
        Top = 31
        Width = 315
        Height = 25
        Caption = 'Set values of enclosed elements'
        TabOrder = 3
        OnClick = cbEnclosedCellsClick
      end
      object cbIntersectedCells: TCheckBox
        Left = 7
        Top = 62
        Width = 331
        Height = 25
        Caption = 'Set values of intersected elements'
        TabOrder = 4
        OnClick = cbEnclosedCellsClick
      end
      object cbInterpolation: TCheckBox
        Left = 7
        Top = 93
        Width = 347
        Height = 25
        Caption = 'Set values of elements by interpolation'
        TabOrder = 5
        OnClick = cbEnclosedCellsClick
      end
      object cbImportGrid: TCheckBox
        Left = 7
        Top = 124
        Width = 161
        Height = 25
        Caption = 'Import grid'
        TabOrder = 6
        OnClick = cbImportGridClick
      end
      object edImportCriterion: TEdit
        Left = 152
        Top = 151
        Width = 505
        Height = 24
        Cursor = crIBeam
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 8
        Text = 'True'
        OnExit = edImportCriterionExit
      end
      object comboJoinObjects: TJvImageComboBox
        Left = 145
        Top = 184
        Width = 281
        Height = 26
        Style = csOwnerDrawVariable
        ButtonStyle = fsLighter
        DroppedWidth = 281
        ImageHeight = 0
        ImageWidth = 0
        ItemHeight = 20
        ItemIndex = 0
        TabOrder = 10
        OnChange = comboJoinObjectsChange
        Items = <
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'separate objects'
          end
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'a single, multipart object'
          end>
      end
      object comboVisibility: TJvImageComboBox
        Left = 213
        Top = 216
        Width = 213
        Height = 26
        Style = csOwnerDrawVariable
        ButtonStyle = fsLighter
        DroppedWidth = 213
        ImageHeight = 0
        ImageWidth = 0
        ItemHeight = 20
        ItemIndex = 1
        TabOrder = 11
        Items = <
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'selected'
          end
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'visible but not selected'
          end
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'hidden'
          end>
      end
      object rgEvaluatedAt: TRadioGroup
        Left = 360
        Top = 8
        Width = 145
        Height = 81
        Caption = 'Evaluated at'
        ItemIndex = 0
        Items.Strings = (
          'Elements'
          'Nodes')
        TabOrder = 1
        OnClick = rgEvaluatedAtClick
      end
      object btnImportCriterion: TButton
        Left = 663
        Top = 148
        Width = 90
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Edit F()...'
        TabOrder = 7
        OnClick = btnImportCriterionClick
      end
      object rgElevationCount: TRadioGroup
        Left = 8
        Top = 296
        Width = 337
        Height = 49
        Caption = 'Number of Z formulas'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Zero'
          'One'
          'Two')
        TabOrder = 14
        OnClick = rgElevationCountClick
      end
      object edZ: TRbwEdit
        Left = 206
        Top = 351
        Width = 456
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        Enabled = False
        TabOrder = 16
        Text = '0'
        OnExit = edZExit
      end
      object edHighZ: TRbwEdit
        Left = 206
        Top = 384
        Width = 456
        Height = 24
        Cursor = crIBeam
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        Enabled = False
        TabOrder = 18
        Text = '0'
        OnExit = edHighZExit
      end
      object edLowZ: TRbwEdit
        Left = 206
        Top = 417
        Width = 456
        Height = 24
        Cursor = crIBeam
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        Enabled = False
        TabOrder = 20
        Text = '0'
        OnExit = edLowZExit
      end
      object btnZ: TButton
        Left = 668
        Top = 349
        Width = 90
        Height = 30
        Anchors = [akTop, akRight]
        Caption = 'Edit F()...'
        Enabled = False
        TabOrder = 15
        OnClick = btnElevFormulaEdit
      end
      object btnHighZ: TButton
        Left = 668
        Top = 382
        Width = 90
        Height = 30
        Anchors = [akTop, akRight]
        Caption = 'Edit F()...'
        Enabled = False
        TabOrder = 17
        OnClick = btnElevFormulaEdit
      end
      object btnLowZ: TButton
        Left = 668
        Top = 415
        Width = 90
        Height = 30
        Anchors = [akTop, akRight]
        Caption = 'Edit F()...'
        Enabled = False
        TabOrder = 19
        OnClick = btnElevFormulaEdit
      end
      object memoMultipleParts: TMemo
        Left = 432
        Top = 183
        Width = 321
        Height = 114
        Anchors = [akLeft, akTop, akRight]
        ScrollBars = ssVertical
        TabOrder = 9
      end
      object cbImportZ: TCheckBox
        Left = 8
        Top = 248
        Width = 346
        Height = 17
        Caption = 'Import Z coordinate and slope for each point'
        TabOrder = 12
      end
      object cbImportMeasured: TCheckBox
        Left = 8
        Top = 271
        Width = 314
        Height = 17
        Caption = 'Import measured value for each point'
        TabOrder = 13
      end
      object memoShapeFileInfo: TMemo
        Left = 528
        Top = 16
        Width = 225
        Height = 126
        ScrollBars = ssBoth
        TabOrder = 2
        WordWrap = False
      end
    end
    object tabData: TTabSheet
      Caption = 'Data'
      object pnlData: TPanel
        Left = 0
        Top = 436
        Width = 771
        Height = 45
        Align = alBottom
        ParentColor = True
        TabOrder = 1
        object btnAll: TButton
          Left = 6
          Top = 6
          Width = 115
          Height = 33
          Caption = 'Select All'
          TabOrder = 0
          OnClick = btnSelectClick
        end
        object btnNone: TButton
          Left = 127
          Top = 6
          Width = 115
          Height = 33
          Caption = 'Select None'
          TabOrder = 1
          OnClick = btnSelectClick
        end
        object btnToggle: TButton
          Left = 248
          Top = 6
          Width = 115
          Height = 33
          Caption = 'Toggle'
          TabOrder = 2
          OnClick = btnToggleClick
        end
      end
      object pnlDataGrids: TPanel
        Left = 0
        Top = 0
        Width = 771
        Height = 436
        Align = alClient
        TabOrder = 0
        object dgFields: TRbwDataGrid4
          Left = 1
          Top = 42
          Width = 769
          Height = 393
          Align = alClient
          ColCount = 4
          FixedCols = 1
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goAlwaysShowEditor]
          TabOrder = 1
          OnDrawCell = dgFieldsDrawCell
          OnMouseUp = dgFieldsMouseUp
          OnSelectCell = dgFieldsSelectCell
          OnSetEditText = dgFieldsSetEditText
          ExtendedAutoDistributeText = False
          AutoMultiEdit = True
          AutoDistributeText = True
          AutoIncreaseColCount = False
          AutoIncreaseRowCount = False
          SelectedRowOrColumnColor = clAqua
          UnselectableColor = clBtnFace
          OnColSize = dgFieldsColSize
          ColorRangeSelection = False
          Columns = <
            item
              AutoAdjustRowHeights = False
              ButtonCaption = '...'
              ButtonFont.Charset = DEFAULT_CHARSET
              ButtonFont.Color = clWindowText
              ButtonFont.Height = -11
              ButtonFont.Name = 'MS Sans Serif'
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
              ButtonFont.Name = 'MS Sans Serif'
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
              ButtonFont.Name = 'MS Sans Serif'
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
            end
            item
              AutoAdjustRowHeights = False
              ButtonCaption = '...'
              ButtonFont.Charset = DEFAULT_CHARSET
              ButtonFont.Color = clWindowText
              ButtonFont.Height = -11
              ButtonFont.Name = 'MS Sans Serif'
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
          ColWidths = (
            64
            64
            64
            64)
          RowHeights = (
            24
            24
            24
            24
            24)
        end
        object pnlDataTop: TPanel
          Left = 1
          Top = 1
          Width = 769
          Height = 41
          Align = alTop
          TabOrder = 0
          object cbSelect: TCheckBox
            Left = 72
            Top = 18
            Width = 65
            Height = 17
            Caption = 'Import'
            Enabled = False
            TabOrder = 1
            OnClick = cbSelectClick
          end
          object comboInterpolaters: TComboBox
            Left = 200
            Top = 9
            Width = 121
            Height = 24
            Style = csDropDownList
            Enabled = False
            TabOrder = 0
            OnChange = comboInterpolatersChange
          end
        end
      end
    end
    object tabFeatures: TTabSheet
      Caption = 'Features'
      ImageIndex = 2
      TabVisible = False
      object pnlBoundaryCondition: TPanel
        Left = 0
        Top = 0
        Width = 771
        Height = 481
        Align = alClient
        TabOrder = 0
        object splitterBoundary: TSplitter
          Left = 1
          Top = 221
          Width = 769
          Height = 5
          Cursor = crVSplit
          Align = alBottom
          ExplicitTop = 201
        end
        object pnlBoundaryControls: TPanel
          Left = 1
          Top = 1
          Width = 769
          Height = 41
          Align = alTop
          TabOrder = 0
          object lblBoundaryTimeCount: TLabel
            Left = 602
            Top = 11
            Width = 95
            Height = 16
            Caption = 'Number of times'
          end
          object lblBoundaryChoice: TLabel
            Left = 367
            Top = 11
            Width = 84
            Height = 16
            Caption = 'Feature choice'
          end
          object comboBoundaryChoice: TComboBox
            Left = 5
            Top = 10
            Width = 356
            Height = 24
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 1
            Text = 'none'
            OnChange = comboBoundaryChoiceChange
            Items.Strings = (
              'none')
          end
          object seBoundaryTimeCount: TJvSpinEdit
            Left = 535
            Top = 8
            Width = 61
            Height = 24
            ButtonKind = bkClassic
            MaxValue = 2147483647.000000000000000000
            MinValue = 1.000000000000000000
            Value = 1.000000000000000000
            Enabled = False
            TabOrder = 0
            OnChange = seBoundaryTimeCountChange
          end
        end
        object rdgBoundaryConditions: TRbwDataGrid4
          Left = 1
          Top = 42
          Width = 769
          Height = 179
          Align = alClient
          ColCount = 4
          Enabled = False
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs, goAlwaysShowEditor]
          TabOrder = 1
          ExtendedAutoDistributeText = False
          AutoMultiEdit = True
          AutoDistributeText = True
          AutoIncreaseColCount = False
          AutoIncreaseRowCount = True
          SelectedRowOrColumnColor = clAqua
          UnselectableColor = clBtnFace
          OnBeforeDrawCell = BoundaryGridBeforeDrawCell
          ColorRangeSelection = False
          OnDistributeTextProgress = rdgBoundaryConditionsDistributeTextProgress
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
          WordWrapRowCaptions = False
          ColWidths = (
            64
            64
            64
            64)
          RowHeights = (
            24
            24)
        end
        object plBoundary: TJvPageList
          Left = 1
          Top = 226
          Width = 769
          Height = 254
          ActivePage = jvspModflowCFP
          PropagateEnable = False
          Align = alBottom
          object jvspNone: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspNone'
          end
          object jvspPhastSpecifiedHead: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspPhastSpecifiedHead'
            object lblSolutionType: TLabel
              Left = 16
              Top = 6
              Width = 91
              Height = 16
              Caption = 'Type of solution'
            end
            object comboSolutionType: TComboBox
              Left = 16
              Top = 40
              Width = 273
              Height = 24
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 0
              Text = 'Associated solution'
              OnChange = comboRealFieldChange
              Items.Strings = (
                'Associated solution'
                'Specified solution')
            end
          end
          object jvspPhastLeaky: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspPhastLeaky'
            object lblLeakyHydraulicConductivity: TLabel
              Left = 8
              Top = 12
              Width = 122
              Height = 16
              Caption = 'Hydraulic conductivity'
            end
            object lblLeakyThickness: TLabel
              Left = 8
              Top = 60
              Width = 56
              Height = 16
              Caption = 'Thickness'
            end
            object comboLeakyHydraulicConductivity: TComboBox
              Left = 199
              Top = 14
              Width = 464
              Height = 24
              TabOrder = 0
              OnChange = comboRealFieldChange
            end
            object comboLeakyThickness: TComboBox
              Left = 199
              Top = 56
              Width = 464
              Height = 24
              TabOrder = 1
              OnChange = comboRealFieldChange
            end
          end
          object jvspPhastRiver: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspPhastRiver'
            object lblRiverDescripton: TLabel
              Left = 8
              Top = 16
              Width = 33
              Height = 16
              Caption = 'Name'
            end
            object lblRiverHydraulicConductivity: TLabel
              Left = 8
              Top = 52
              Width = 66
              Height = 32
              Caption = 'Hydraulic conductivity'
              WordWrap = True
            end
            object lblRiverWidth: TLabel
              Left = 196
              Top = 64
              Width = 33
              Height = 16
              Caption = 'Width'
            end
            object lblRiverDepth: TLabel
              Left = 384
              Top = 64
              Width = 33
              Height = 16
              Caption = 'Depth'
            end
            object lblRiverBedThickness: TLabel
              Left = 574
              Top = 52
              Width = 52
              Height = 32
              Caption = 'Bed thickness'
              WordWrap = True
            end
            object comboRiverDescripton: TComboBox
              Left = 64
              Top = 13
              Width = 145
              Height = 24
              TabOrder = 0
            end
            object comboRiverHydraulicConductivity: TComboBox
              Left = 3
              Top = 89
              Width = 145
              Height = 24
              TabOrder = 1
              OnChange = comboRealFieldChange
            end
            object comboRiverWidth: TComboBox
              Left = 196
              Top = 96
              Width = 145
              Height = 24
              TabOrder = 2
              OnChange = comboRealFieldChange
            end
            object comboRiverDepth: TComboBox
              Left = 384
              Top = 96
              Width = 145
              Height = 24
              TabOrder = 3
              OnChange = comboRealFieldChange
            end
            object comboRiverBedThickness: TComboBox
              Left = 574
              Top = 96
              Width = 145
              Height = 24
              TabOrder = 4
              OnChange = comboRealFieldChange
            end
          end
          object jvspPhastWell: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspPhastWell'
            object pnlPhastWell: TPanel
              Left = 0
              Top = 0
              Width = 369
              Height = 254
              Align = alLeft
              TabOrder = 0
              object lblWellDescription: TLabel
                Left = 3
                Top = 9
                Width = 61
                Height = 16
                Caption = 'Well name'
              end
              object lblWellDiameter: TLabel
                Left = 3
                Top = 40
                Width = 52
                Height = 16
                Caption = 'Diameter'
              end
              object lblWellLandSurfaceDatum: TLabel
                Left = 3
                Top = 71
                Width = 113
                Height = 16
                Caption = 'Land surface datum'
              end
              object lblWellPumpAllocation: TLabel
                Left = 3
                Top = 102
                Width = 189
                Height = 16
                Caption = 'Allocate by pressure and mobility'
              end
              object lblWellIntervalStyle: TLabel
                Left = 3
                Top = 133
                Width = 104
                Height = 16
                Caption = 'Specify interval by'
              end
              object lblWellIntervals: TLabel
                Left = 3
                Top = 169
                Width = 112
                Height = 16
                Caption = 'Number of intervals'
              end
              object WellDescription: TComboBox
                Left = 96
                Top = 6
                Width = 197
                Height = 24
                TabOrder = 0
              end
              object comboWellDiameter: TComboBox
                Left = 188
                Top = 37
                Width = 105
                Height = 24
                TabOrder = 1
                OnChange = comboRealFieldChange
              end
              object comboWellLandSurfaceDatum: TComboBox
                Left = 188
                Top = 68
                Width = 105
                Height = 24
                TabOrder = 2
                OnChange = comboRealFieldChange
              end
              object comboWellPumpAllocation: TComboBox
                Left = 222
                Top = 99
                Width = 145
                Height = 24
                TabOrder = 3
                OnChange = comboBooleanFieldChange
              end
              object comboWellIntervalStyle: TComboBox
                Left = 188
                Top = 130
                Width = 105
                Height = 24
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 4
                Text = 'Elevation'
                Items.Strings = (
                  'Elevation'
                  'Depth')
              end
              object seWellIntervals: TJvSpinEdit
                Left = 188
                Top = 161
                Width = 105
                Height = 24
                ButtonKind = bkClassic
                MaxValue = 2147483647.000000000000000000
                MinValue = 1.000000000000000000
                Value = 1.000000000000000000
                TabOrder = 5
                OnChange = seWellIntervalsChange
              end
            end
            object dgWellElevations: TRbwDataGrid4
              Left = 369
              Top = 0
              Width = 400
              Height = 254
              Align = alClient
              ColCount = 3
              DefaultColWidth = 20
              FixedCols = 1
              RowCount = 2
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 19
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowMoving, goEditing, goTabs, goAlwaysShowEditor]
              ParentFont = False
              TabOrder = 1
              ExtendedAutoDistributeText = False
              AutoMultiEdit = True
              AutoDistributeText = True
              AutoIncreaseColCount = False
              AutoIncreaseRowCount = True
              SelectedRowOrColumnColor = clAqua
              UnselectableColor = clBtnFace
              OnBeforeDrawCell = BoundaryGridBeforeDrawCell
              ColorRangeSelection = False
              Columns = <
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = 'F()'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'MS Sans Serif'
                  ButtonFont.Pitch = fpVariable
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 25
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
                  ButtonCaption = 'F()'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'MS Sans Serif'
                  ButtonFont.Pitch = fpVariable
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 40
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = True
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
                  ButtonCaption = 'F()'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'MS Sans Serif'
                  ButtonFont.Pitch = fpVariable
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 40
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = True
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
                20
                26
                26)
              RowHeights = (
                24
                24)
            end
          end
          object jvspConductanceInterp: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspConductanceInterp'
            object lblConductanceInterpretation: TLabel
              Left = 5
              Top = 6
              Width = 154
              Height = 16
              Caption = 'Conductance interpretation'
            end
            object comboFormulaInterp: TComboBox
              Left = 201
              Top = 3
              Width = 145
              Height = 24
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 0
              Text = 'Specific'
              Items.Strings = (
                'Specific'
                'Direct'
                'Total')
            end
          end
          object jvspModflowSFR: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspModflowSFR'
            object pcSFR: TPageControl
              Left = 0
              Top = 0
              Width = 769
              Height = 254
              ActivePage = tabSfrBasic
              Align = alClient
              TabOrder = 0
              object tabSfrBasic: TTabSheet
                Caption = 'Basic'
                object lblSfrSegmentNumber: TLabel
                  Left = 13
                  Top = 9
                  Width = 99
                  Height = 16
                  Caption = 'Segment number'
                end
                object lblReachLength: TLabel
                  Left = 13
                  Top = 40
                  Width = 133
                  Height = 16
                  Caption = 'Reach length (RCHLEN)'
                end
                object lblStreamTop: TLabel
                  Left = 363
                  Top = 9
                  Width = 147
                  Height = 16
                  Caption = 'Streambed top (STRTOP)'
                end
                object lblStreambedThickness: TLabel
                  Left = 363
                  Top = 40
                  Width = 192
                  Height = 16
                  Caption = 'Streambed thickness (STRTHICK)'
                end
                object lblSlope: TLabel
                  Left = 13
                  Top = 71
                  Width = 127
                  Height = 16
                  Caption = 'Stream slope (SLOPE)'
                end
                object lblStreambedK: TLabel
                  Left = 363
                  Top = 71
                  Width = 141
                  Height = 16
                  Caption = 'Streambed Kv (STRHC1)'
                end
                object comboSfrSegmentNumber: TComboBox
                  Left = 199
                  Top = 6
                  Width = 145
                  Height = 24
                  TabOrder = 0
                end
                object comboSfrReachLength: TComboBox
                  Left = 199
                  Top = 37
                  Width = 145
                  Height = 24
                  TabOrder = 2
                  Text = 'ObjectIntersectLength'
                end
                object comboSfrStreambedTop: TComboBox
                  Left = 607
                  Top = 6
                  Width = 145
                  Height = 24
                  TabOrder = 1
                end
                object comboSfrStreamSlope: TComboBox
                  Left = 199
                  Top = 68
                  Width = 145
                  Height = 24
                  TabOrder = 4
                end
                object comboSfrStreambedThickness: TComboBox
                  Left = 607
                  Top = 37
                  Width = 145
                  Height = 24
                  TabOrder = 3
                end
                object comboSfrStreambedKv: TComboBox
                  Left = 607
                  Top = 68
                  Width = 145
                  Height = 24
                  TabOrder = 5
                end
              end
              object tabSfrUnsaturated: TTabSheet
                Caption = 'Unsaturated'
                ImageIndex = 1
                object lblSaturatedVolumetricWater: TLabel
                  Left = 3
                  Top = 6
                  Width = 248
                  Height = 16
                  Caption = 'Saturated volumetric water content (THTS)'
                end
                object lblInitialVolumetricWater: TLabel
                  Left = 3
                  Top = 37
                  Width = 219
                  Height = 16
                  Caption = 'Initial volumetric water content (THTI)'
                end
                object lblBrooksCoreyExponent: TLabel
                  Left = 3
                  Top = 68
                  Width = 168
                  Height = 16
                  Caption = 'Brooks-Corey exponent (EPS)'
                end
                object lblMaxUnsaturatedKz: TLabel
                  Left = 3
                  Top = 99
                  Width = 150
                  Height = 16
                  Caption = 'Max unsaturated Kz (UHC)'
                end
                object comboSaturatedVolumetricWater: TComboBox
                  Left = 312
                  Top = 3
                  Width = 145
                  Height = 24
                  TabOrder = 0
                end
                object comboInitialVolumetricWater: TComboBox
                  Left = 312
                  Top = 34
                  Width = 145
                  Height = 24
                  TabOrder = 1
                end
                object comboBrooksCoreyExponent: TComboBox
                  Left = 312
                  Top = 65
                  Width = 145
                  Height = 24
                  TabOrder = 2
                end
                object comboaxUnsaturatedKz: TComboBox
                  Left = 312
                  Top = 96
                  Width = 145
                  Height = 24
                  TabOrder = 3
                end
              end
            end
          end
          object jvspModflowLAK: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspModflowLAK'
            object LblLakeID: TLabel
              Left = 13
              Top = 9
              Width = 42
              Height = 16
              Caption = 'Lake ID'
            end
            object lblInitialStage: TLabel
              Left = 13
              Top = 41
              Width = 66
              Height = 16
              Caption = 'Initial stage'
            end
            object lblSill: TLabel
              Left = 13
              Top = 105
              Width = 17
              Height = 16
              Caption = 'Sill'
            end
            object lblCenterLake: TLabel
              Left = 13
              Top = 73
              Width = 65
              Height = 16
              Caption = 'Center lake'
            end
            object comboLakeID: TComboBox
              Left = 127
              Top = 6
              Width = 145
              Height = 24
              TabOrder = 0
            end
            object comboInitialStage: TComboBox
              Left = 127
              Top = 38
              Width = 145
              Height = 24
              TabOrder = 1
            end
            object comboSill: TComboBox
              Left = 127
              Top = 101
              Width = 145
              Height = 24
              TabOrder = 3
            end
            object comboCenterLake: TComboBox
              Left = 127
              Top = 70
              Width = 145
              Height = 24
              TabOrder = 2
            end
          end
          object jvspModflowDRT: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspModflowDRT'
            object lblConductanceInterpretationDRT: TLabel
              Left = 5
              Top = 6
              Width = 154
              Height = 16
              Caption = 'Conductance interpretation'
            end
            object lblDrainReturnLocationMethod: TLabel
              Left = 5
              Top = 38
              Width = 133
              Height = 16
              Caption = 'Return location method'
            end
            object comboFormulaInterpDRT: TComboBox
              Left = 209
              Top = 3
              Width = 145
              Height = 24
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 0
              Text = 'Specific'
              Items.Strings = (
                'Specific'
                'Direct'
                'Total')
            end
            object comboDrainReturnLocationMethod: TComboBox
              Left = 209
              Top = 35
              Width = 145
              Height = 24
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 1
              Text = 'none'
              OnChange = comboDrainReturnLocationMethodChange
              Items.Strings = (
                'none'
                'Location'
                'Cell')
            end
            object pcDrtReturnLChoice: TJvPageControl
              Left = 16
              Top = 66
              Width = 525
              Height = 116
              ActivePage = tabDrtLocation
              TabOrder = 2
              ClientBorderWidth = 0
              object tabDrtNone: TTabSheet
                Caption = 'tabDrtNone'
                TabVisible = False
              end
              object tabDrtLocation: TTabSheet
                Caption = 'tabDrtLocation'
                ImageIndex = 2
                TabVisible = False
                object lblDrtX: TLabel
                  Left = 3
                  Top = 7
                  Width = 8
                  Height = 16
                  Caption = 'X'
                end
                object lblDrtY: TLabel
                  Left = 151
                  Top = 3
                  Width = 7
                  Height = 16
                  Caption = 'Y'
                end
                object lblDrtZ: TLabel
                  Left = 302
                  Top = 7
                  Width = 7
                  Height = 16
                  Caption = 'Z'
                end
                object rdeDrtX: TRbwDataEntry
                  Left = 3
                  Top = 32
                  Width = 145
                  Height = 24
                  Style = csDropDown
                  TabOrder = 0
                  Text = '0'
                  Items.Strings = (
                    'False'
                    'True')
                  DataType = dtCustom
                  Max = 1.000000000000000000
                  ChangeDisabledColor = True
                end
                object rdeDrtY: TRbwDataEntry
                  Left = 151
                  Top = 32
                  Width = 145
                  Height = 24
                  Style = csDropDown
                  TabOrder = 1
                  Text = '0'
                  Items.Strings = (
                    'False'
                    'True')
                  DataType = dtCustom
                  Max = 1.000000000000000000
                  ChangeDisabledColor = True
                end
                object rdeDrtZ: TRbwDataEntry
                  Left = 302
                  Top = 32
                  Width = 145
                  Height = 24
                  Style = csDropDown
                  TabOrder = 2
                  Text = '0'
                  Items.Strings = (
                    'False'
                    'True')
                  DataType = dtCustom
                  Max = 1.000000000000000000
                  ChangeDisabledColor = True
                end
              end
              object tabDrtCell: TTabSheet
                Caption = 'tabDrtCell'
                ImageIndex = 3
                TabVisible = False
                object lblDrtCol: TLabel
                  Left = 3
                  Top = 7
                  Width = 18
                  Height = 16
                  Caption = 'Col'
                end
                object lblDrtRow: TLabel
                  Left = 151
                  Top = 3
                  Width = 25
                  Height = 16
                  Caption = 'Row'
                end
                object lblDrtLay: TLabel
                  Left = 302
                  Top = 7
                  Width = 31
                  Height = 16
                  Caption = 'Layer'
                end
                object rdeDrtLay: TRbwDataEntry
                  Left = 302
                  Top = 32
                  Width = 145
                  Height = 24
                  Style = csDropDown
                  TabOrder = 2
                  Text = '1'
                  Items.Strings = (
                    'False'
                    'True')
                  DataType = dtCustom
                  Max = 1.000000000000000000
                  Min = 1.000000000000000000
                  CheckMin = True
                  ChangeDisabledColor = True
                end
                object rdeDrtRow: TRbwDataEntry
                  Left = 151
                  Top = 32
                  Width = 145
                  Height = 24
                  Style = csDropDown
                  TabOrder = 1
                  Text = '1'
                  Items.Strings = (
                    'False'
                    'True')
                  DataType = dtCustom
                  Max = 1.000000000000000000
                  Min = 1.000000000000000000
                  CheckMin = True
                  ChangeDisabledColor = True
                end
                object rdeDrtCol: TRbwDataEntry
                  Left = 3
                  Top = 32
                  Width = 145
                  Height = 24
                  Style = csDropDown
                  TabOrder = 0
                  Text = '1'
                  Items.Strings = (
                    'False'
                    'True')
                  DataType = dtCustom
                  Max = 1.000000000000000000
                  Min = 1.000000000000000000
                  CheckMin = True
                  ChangeDisabledColor = True
                end
              end
            end
          end
          object jvspModflowHFB: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspModflowHFB'
            object lblHydraulicConductivity: TLabel
              Left = 8
              Top = 14
              Width = 164
              Height = 16
              Margins.Left = 8
              Caption = 'Barrier hydraulic conductivity'
            end
            object lblBarrierThickness: TLabel
              Left = 8
              Top = 42
              Width = 95
              Height = 16
              Margins.Left = 8
              Caption = 'Barrier thickness'
            end
            object rgAngleAdjustment: TRadioGroup
              Left = 8
              Top = 67
              Width = 567
              Height = 85
              Margins.Left = 8
              Margins.Right = 8
              Caption = 'Angle adjustment method'
              ItemIndex = 1
              Items.Strings = (
                'None'
                'Distribute conductivity among all sections'
                
                  'Distribute conductivity among sections most nearly parallel to t' +
                  'he grid')
              TabOrder = 2
            end
            object comboHfbHydCond: TComboBox
              Left = 224
              Top = 11
              Width = 145
              Height = 24
              TabOrder = 0
            end
            object comboHfbThickness: TComboBox
              Left = 224
              Top = 36
              Width = 145
              Height = 24
              TabOrder = 1
            end
          end
          object jvspModflowHOB: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspModflowHOB'
            object lblHeadObservationNames: TLabel
              Left = 13
              Top = 9
              Width = 104
              Height = 16
              Caption = 'Observation name'
            end
            object lblHeadObsType: TLabel
              Left = 13
              Top = 73
              Width = 60
              Height = 16
              Caption = 'Treatment'
            end
            object lblIgnoreValues: TLabel
              Left = 13
              Top = 105
              Width = 93
              Height = 16
              Caption = 'Values to ignore'
            end
            object lblITT: TLabel
              Left = 13
              Top = 31
              Width = 146
              Height = 32
              Caption = 'How will observations be analyzed? (ITT)'
              WordWrap = True
            end
            object comboHeadObservationNames: TComboBox
              Left = 175
              Top = 6
              Width = 145
              Height = 24
              TabOrder = 0
            end
            object comboHeadObsType: TComboBox
              Left = 175
              Top = 70
              Width = 145
              Height = 24
              ItemIndex = 0
              TabOrder = 2
              Text = 'Observation'
              Items.Strings = (
                'Observation'
                'Prediction'
                'Inactive')
            end
            object rdeIgnoreValues: TRbwDataEntry
              Left = 175
              Top = 102
              Width = 145
              Height = 22
              TabOrder = 3
              Text = '9999'
              DataType = dtReal
              Max = 1.000000000000000000
              ChangeDisabledColor = True
            end
            object comboITT: TComboBox
              Left = 175
              Top = 38
              Width = 338
              Height = 24
              ItemIndex = 1
              TabOrder = 1
              Text = 'Calculate drawdown relative to first head (2)'
              Items.Strings = (
                'All heads (1)'
                'Calculate drawdown relative to first head (2)')
            end
          end
          object jvspModflowMNW2: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspModflowMNW2'
            object pcMnw2: TPageControl
              Left = 0
              Top = 0
              Width = 769
              Height = 254
              ActivePage = tabBasic
              Align = alClient
              TabOrder = 0
              object tabBasic: TTabSheet
                HelpType = htKeyword
                HelpKeyword = 'MNW2_Basic_Tab'
                Caption = 'Basic'
                object lblWellId: TLabel
                  Left = 3
                  Top = 6
                  Width = 181
                  Height = 16
                  Caption = 'Unique well identifier (WELLID) '
                end
                object lblLossType: TLabel
                  Left = 3
                  Top = 38
                  Width = 181
                  Height = 16
                  Caption = 'Model for well loss (LOSSTYPE)'
                end
                object lblPartialPenetration: TLabel
                  Left = 366
                  Top = 70
                  Width = 180
                  Height = 16
                  Caption = 'Partial penetration fraction (PP)'
                end
                object lblZPump: TLabel
                  Left = 3
                  Top = 102
                  Width = 140
                  Height = 16
                  Caption = 'Pump elevation (Zpump)'
                end
                object lblMnw2PumplocX: TLabel
                  Left = 216
                  Top = 134
                  Width = 8
                  Height = 16
                  Caption = 'X'
                end
                object lblMnw2PumplocY: TLabel
                  Left = 216
                  Top = 165
                  Width = 7
                  Height = 16
                  Caption = 'Y'
                end
                object lblMnw2PumplocZ: TLabel
                  Left = 216
                  Top = 198
                  Width = 7
                  Height = 16
                  Caption = 'Z'
                end
                object lblPumpLocation: TLabel
                  Left = 3
                  Top = 134
                  Width = 80
                  Height = 16
                  Caption = 'Pump location'
                end
                object lblSpecifyPump: TLabel
                  Left = 3
                  Top = 70
                  Width = 146
                  Height = 16
                  Caption = 'Specify pump (PUMPLOC)'
                end
                object lblConstrainPumping: TLabel
                  Left = 366
                  Top = 6
                  Width = 154
                  Height = 16
                  Caption = 'Constrain pumping (Qlimit)'
                end
                object lblPartialPenetrationFlag: TLabel
                  Left = 366
                  Top = 38
                  Width = 228
                  Height = 16
                  Caption = 'Correct for partial penetration (PPFLAG)'
                end
                object lblPumpCap: TLabel
                  Left = 366
                  Top = 102
                  Width = 184
                  Height = 32
                  Caption = 'Adjust discharge for changes in lift (PUMPCAP) '
                  WordWrap = True
                end
                object comboMnw2WellId: TComboBox
                  Left = 233
                  Top = 3
                  Width = 115
                  Height = 24
                  TabOrder = 0
                end
                object comboMnw2LossType: TComboBox
                  Left = 233
                  Top = 35
                  Width = 115
                  Height = 24
                  TabOrder = 2
                end
                object comboSpecifyPump: TComboBox
                  Left = 233
                  Top = 67
                  Width = 115
                  Height = 24
                  TabOrder = 4
                end
                object comboZPump: TComboBox
                  Left = 233
                  Top = 99
                  Width = 115
                  Height = 24
                  TabOrder = 6
                end
                object comboMnw2PumplocX: TComboBox
                  Left = 233
                  Top = 131
                  Width = 115
                  Height = 24
                  TabOrder = 8
                end
                object comboMnw2PumplocY: TComboBox
                  Left = 233
                  Top = 163
                  Width = 115
                  Height = 24
                  TabOrder = 9
                end
                object comboMnw2PumplocZ: TComboBox
                  Left = 233
                  Top = 195
                  Width = 115
                  Height = 24
                  TabOrder = 10
                end
                object comboConstrainPumping: TComboBox
                  Left = 653
                  Top = 3
                  Width = 115
                  Height = 24
                  TabOrder = 1
                end
                object comboPartialPenetrationFlag: TComboBox
                  Left = 653
                  Top = 35
                  Width = 115
                  Height = 24
                  TabOrder = 3
                end
                object comboPartialPenetration: TComboBox
                  Left = 653
                  Top = 67
                  Width = 115
                  Height = 24
                  TabOrder = 5
                end
                object comboPumpCap: TComboBox
                  Left = 653
                  Top = 107
                  Width = 115
                  Height = 24
                  TabOrder = 7
                end
              end
              object tabLossControls: TTabSheet
                HelpType = htKeyword
                HelpKeyword = 'MNW2_Loss_Controls_Tab'
                Caption = 'Loss Controls'
                ImageIndex = 1
                object lblWellRadius: TLabel
                  Left = 3
                  Top = 6
                  Width = 96
                  Height = 16
                  Caption = 'Well radius (Rw)'
                end
                object lblSkinRadius: TLabel
                  Left = 3
                  Top = 38
                  Width = 107
                  Height = 16
                  Caption = 'Skin radius (Rskin)'
                end
                object lblBCoefficient: TLabel
                  Left = 3
                  Top = 102
                  Width = 171
                  Height = 16
                  Caption = 'Linear well loss coefficient (B)'
                end
                object lblCCoefficient: TLabel
                  Left = 3
                  Top = 134
                  Width = 196
                  Height = 16
                  Caption = 'Non-linear well loss coefficient (C)'
                end
                object lblPCoefficient: TLabel
                  Left = 3
                  Top = 166
                  Width = 88
                  Height = 16
                  Caption = 'Power term (P)'
                end
                object lblCellToWellConductance: TLabel
                  Left = 3
                  Top = 198
                  Width = 180
                  Height = 16
                  Caption = 'Cell to well conductance (CWC)'
                end
                object lblKSkin: TLabel
                  Left = 3
                  Top = 70
                  Width = 192
                  Height = 16
                  Caption = 'Skin hydraulic conductivity (Kskin)'
                end
                object comboWellRadius: TComboBox
                  Left = 249
                  Top = 3
                  Width = 115
                  Height = 24
                  TabOrder = 0
                end
                object comboSkinRadius: TComboBox
                  Left = 249
                  Top = 35
                  Width = 115
                  Height = 24
                  TabOrder = 1
                end
                object comboKSkin: TComboBox
                  Left = 249
                  Top = 67
                  Width = 115
                  Height = 24
                  TabOrder = 2
                end
                object comboBCoefficient: TComboBox
                  Left = 249
                  Top = 99
                  Width = 115
                  Height = 24
                  TabOrder = 3
                end
                object comboCCoefficient: TComboBox
                  Left = 249
                  Top = 131
                  Width = 115
                  Height = 24
                  TabOrder = 4
                end
                object comboPCoefficient: TComboBox
                  Left = 249
                  Top = 163
                  Width = 115
                  Height = 24
                  TabOrder = 5
                end
                object comboCellToWellConductance: TComboBox
                  Left = 249
                  Top = 195
                  Width = 115
                  Height = 24
                  TabOrder = 6
                end
              end
              object tabDischargeAdjustment: TTabSheet
                HelpType = htKeyword
                HelpKeyword = 'MNW2_Discharge_Adjustment_Tab'
                Caption = 'Discharge Adjustment'
                ImageIndex = 2
                object lblReferenceHead: TLabel
                  Left = 8
                  Top = 6
                  Width = 126
                  Height = 16
                  Caption = 'Reference head (Hlift)'
                end
                object lblLiftQ0: TLabel
                  Left = 8
                  Top = 38
                  Width = 126
                  Height = 16
                  Caption = 'Maximum lift (LIFTq0)'
                end
                object lblLiftQMax: TLabel
                  Left = 8
                  Top = 70
                  Width = 242
                  Height = 16
                  Caption = 'Lift at maximum pumping rate (LIFTqmax)'
                end
                object lblWellTolerance: TLabel
                  Left = 8
                  Top = 102
                  Width = 130
                  Height = 16
                  Caption = 'Well tolerance (HWtol)'
                end
                object comboReferenceHead: TComboBox
                  Left = 305
                  Top = 3
                  Width = 115
                  Height = 24
                  TabOrder = 0
                end
                object comboLiftQ0: TComboBox
                  Left = 305
                  Top = 35
                  Width = 115
                  Height = 24
                  TabOrder = 1
                end
                object comboLiftQMax: TComboBox
                  Left = 305
                  Top = 67
                  Width = 115
                  Height = 24
                  TabOrder = 2
                end
                object comboWellTolerance: TComboBox
                  Left = 305
                  Top = 99
                  Width = 115
                  Height = 24
                  TabOrder = 3
                end
              end
            end
          end
          object jvspModflowSTR: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspModflowSTR'
            object lblConductanceInterpSTR: TLabel
              Left = 12
              Top = 52
              Width = 154
              Height = 16
              Caption = 'Conductance interpretation'
            end
            object lblStrSegmentNumber: TLabel
              Left = 12
              Top = 20
              Width = 99
              Height = 16
              Caption = 'Segment number'
            end
            object lblParameterName: TLabel
              Left = 12
              Top = 84
              Width = 96
              Height = 16
              Caption = 'Parameter name'
            end
            object comboConductanceInterpSTR: TComboBox
              Left = 205
              Top = 49
              Width = 145
              Height = 24
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 1
              Text = 'Specific'
              Items.Strings = (
                'Specific'
                'Direct'
                'Total')
            end
            object comboStrSegmentNumber: TComboBox
              Left = 205
              Top = 17
              Width = 145
              Height = 24
              TabOrder = 0
            end
            object comboStrParameterName: TComboBox
              Left = 205
              Top = 81
              Width = 145
              Height = 24
              TabOrder = 2
            end
          end
          object jvspFootprintWell: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            Caption = 'jvspFootprintWell'
            object lblFootprintWell: TLabel
              Left = 13
              Top = 9
              Width = 65
              Height = 16
              Caption = 'Withdrawal'
            end
            object comboFootprintWell: TComboBox
              Left = 127
              Top = 6
              Width = 145
              Height = 24
              TabOrder = 0
            end
          end
          object jvspModflowCFP: TJvStandardPage
            Left = 0
            Top = 0
            Width = 769
            Height = 254
            object lblCfpDiameter: TLabel
              Left = 8
              Top = 14
              Width = 52
              Height = 16
              Margins.Left = 8
              Caption = 'Diameter'
            end
            object lblCfpTortuosity: TLabel
              Left = 8
              Top = 46
              Width = 57
              Height = 16
              Margins.Left = 8
              Caption = 'Tortuosity'
            end
            object lblCfpRoughnessHeight: TLabel
              Left = 8
              Top = 78
              Width = 101
              Height = 16
              Margins.Left = 8
              Caption = 'Roughness height'
            end
            object lblCfpLowerReynolds: TLabel
              Left = 8
              Top = 110
              Width = 138
              Height = 16
              Margins.Left = 8
              Caption = 'Lower Reynolds number'
            end
            object lblCfbConductance: TLabel
              Left = 8
              Top = 179
              Width = 145
              Height = 16
              Margins.Left = 8
              Caption = 'Conduit wall conductance'
            end
            object lblCfpPipeElevation: TLabel
              Left = 8
              Top = 211
              Width = 79
              Height = 16
              Margins.Left = 8
              Caption = 'Pipe elevation'
            end
            object lblCfpHigherReynolds: TLabel
              Left = 8
              Top = 147
              Width = 140
              Height = 16
              Margins.Left = 8
              Caption = 'Higher Reynolds number'
            end
            object lblCfpSavePipeValues: TLabel
              Left = 349
              Top = 14
              Width = 96
              Height = 16
              Margins.Left = 8
              Caption = 'Save pipe values'
            end
            object lblCfpSaveNodeValues: TLabel
              Left = 349
              Top = 51
              Width = 100
              Height = 16
              Margins.Left = 8
              Caption = 'Save node values'
            end
            object comboCfpDiameter: TComboBox
              Left = 193
              Top = 11
              Width = 145
              Height = 24
              TabOrder = 0
            end
            object comboCfpTortuosity: TComboBox
              Left = 193
              Top = 51
              Width = 145
              Height = 24
              TabOrder = 3
            end
            object comboCfpRoughnessHeight: TComboBox
              Left = 193
              Top = 83
              Width = 145
              Height = 24
              TabOrder = 4
            end
            object comboCfpLowerReynolds: TComboBox
              Left = 193
              Top = 115
              Width = 145
              Height = 24
              TabOrder = 5
              Text = '2000'
            end
            object comboCfbConductance: TComboBox
              Left = 193
              Top = 184
              Width = 145
              Height = 24
              TabOrder = 7
            end
            object comboCfpPipeElevation: TComboBox
              Left = 193
              Top = 216
              Width = 145
              Height = 24
              TabOrder = 8
            end
            object comboCfpHigherReynolds: TComboBox
              Left = 193
              Top = 152
              Width = 145
              Height = 24
              TabOrder = 6
              Text = '4000'
            end
            object comboCfpSavePipeValues: TComboBox
              Left = 531
              Top = 11
              Width = 145
              Height = 24
              TabOrder = 1
            end
            object comboCfpSaveNodeValues: TComboBox
              Left = 531
              Top = 43
              Width = 145
              Height = 24
              TabOrder = 2
            end
          end
        end
      end
    end
    object tabCoordinateConversion: TTabSheet
      Caption = 'Coordinate Conversion'
      ImageIndex = 1
      object imageUtmZones: TImage
        Left = 8
        Top = 55
        Width = 743
        Height = 423
        Picture.Data = {
          07544269746D61708ED10400424D8ED10400000000003604000028000000E702
          0000A7010000010008000000000058CD04000000000000000000000100000001
          0000000000000000AA0000AA000000AAAA00AA000000AA00AA00AAAA00005555
          5500FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F040F0F0F0F0F0F040404040F0F04040F040404040F0F040F0F0F0F
          0F040F0F0F040F0F040F0F0F0F0F0404040F0F0F0404040404040F040F0F040F
          0404040404040F0F0F0F040404040F040F0F0F040F0F0F0F040F0F0F04040404
          0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F040F0F0F0F0F0F040F040F0F0F
          0F0F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F040F0F040F0F040F0F0F
          0F040F040F0F040F040F0F0F0F040F0F0F040F0F0F0F04040F0F0F040F0F0F0F
          040F0F040F0F0F0F040F0F0F0F040F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0404040404
          0F0F040F04040404040F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F040F
          0F0F040F0F04040404040F040F0F040F0F04040404040F0F0F0F04040404040F
          040F0F0F040F0F0F0F040F0F04040404040F04040404040F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404
          040F0F040F0F0F040F0F040F040F0F0F040F0F040F0F0F0F0F04040404040F0F
          0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F040F0F040F0F0F0F0F0F040F0F
          0F040F0F0F0F040F040F0F0F040F0F0F0F040F040F0F0F0F040F040F0F040F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F040F0F0F040F0F0404040F0F0404040F0404040F0F0F04040F0F0F
          0F040F0F0F040F0F0F0F0F0F0F0F040F0F0F040F0F040404040F0F0404040F0F
          0F040404040F0F0F0F040F0F0F0F040F040F0F0F0F040F0F0F040F040F0F0F0F
          040F0F040F040F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F040F0F040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F040F0F040F0F0F040F0F
          0F0F04040F0F0F0F040F0F0F04040F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040F0F0F0F0F0F0F
          0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F0404
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040F0F
          0F0404040404040F0F0F040F040404040F0F0F0F0F040F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404040F0F0F0F0F0F
          0F0F04040F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0F0F040F0F0F0F0F
          0F0F0F0F0F0F04040404040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040404
          040F0F0F0F0F0F0F04040404040F0F0F04040F0F0F04040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F04040404
          040F0F0F04040F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F04040404040F0F
          0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F04040404040F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F04040404040F0F0F0F0F0F0F0F0F04040404040F0F0F
          0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0404040F0F0F0F0F04040F0F0F0F0F
          0F0F04040404040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040404040F0F0F
          0F0F0F0F04040404040F0F0F04040F0F0F0F040404040F0F0F0F0F040404040F
          0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F04040F0F0F0F0F0404040F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F04040F0F0F
          0F0F0F0F0F0F04040404040F0F0F0F0F0F0F040404040F0F0F0F0F0404040404
          0F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404
          040404040F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F
          0F0404040F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F04040F0F0F0F0F
          0F0F0404040404040404040F0F0F0F040404040404040F04040F0F0F0F04040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F
          0F0F0F040404040404040F04040F0F0F0F04040F0F0F0F0F0F04040F0F0F0F04
          04040404040404040F0F0F0F0F0F0F0404040F0F0F0F0F0F0F0F040404040404
          04040F0F0F0F0F04040F0F0F0F0F0F0F0404040404040404040F0F0F0F0F0404
          0404040404040F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0404040F0F0F0F
          0F04040F0F0F0F0F04040404040404040F0F0F0F0F04040F0F0F0F0F0F0F0F04
          0404040404040F0F0F0F0F040404040404040F04040F0F0F0F04040404040F0F
          0F04040404040404040F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F04040404040404040404040F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0404040F0F0F0F0F04040F0F0F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404040404040F0F0F0F0F
          0F0F0F0404040F0F0F0F0F0F0404040404040404040F0F0F0F04040404040F0F
          0F04040404040404040F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          040404040F0F0F0F0F040404040F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F
          04040F0F0F0F0F0F0F0404040F0F0F0F0F0F0F0404040F0F0F0F0F04040F0F0F
          0F04040F0F0F0F0F0F0404040F0F0F0F0F0404040F0F0404040F0F0F0F040404
          040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F04040F0F0F0F0F0F0404040F0F0F0F040404040F0F0F0F04040F0F0F0F0F
          0F04040F0F0F0404040F0F0F0F0F0404040F0F0F0F0F0F0404040F0F0F0F0F0F
          0F0404040F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0404040F0F0F0F0F04
          04040F0F0F0404040F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F
          0F0404040F0F0F0F0F04040F0F0F0F0404040F0F0F0F0F04040F0F0F0F04040F
          0F0F0F0F0F0F0404040F0F0F0404040F0F0F0404040F0F0F0F040404040F0F0F
          0F04040F0F0F0F0F0404040F0F0F0F0404040F0F0F0F04040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F040404040F0F0F0F0F040404040F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0404040F0F0F0F
          0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F
          0F0404040F0F0F0F0F0F040404040F0F0F0F0F0404040F0F0F0F0F0404040F0F
          0F04040F0F0F0F0F0404040F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0404
          0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F04040F0F0F0F
          0F0F04040F0F0F0F04040F0F0F0F0F0F04040F04040F0F0F0F0F0F04040F0F0F
          0F0F0F0F04040F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F04040F0F0404
          0F0F0F0F0F0F0404040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0404040F0F0F
          0F04040F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F0F04040F0F0F0F0F0404
          0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F04
          040F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F
          0F0F04040F0F0F0F04040F04040F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0F
          04040F0F0F04040F0F0F0F0F0F0F04040F0F0F0F0F0404040F0F04040F0F0F0F
          0F0F0404040F0F0F0F04040F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F04040F0F0F0F0F0F
          0F0F0F04040F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F
          04040F04040F0F0F0F04040F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04
          04040F0F0F0F0F0F0F0F04040F0F0F0F0F0F040404040F0F0F0F0F04040F0F0F
          0F0F0F0F04040F0F0F04040F0F0F0F0F04040F0F0F0F0F0F0F04040F0F0F0404
          0F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0404040F0F
          0F0F04040F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F04040F04040F0F0F
          0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F04040F0F04040F0F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F
          0F0F0F04040F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F04040F04040F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F04040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04040F04040F0F0F0F04040F0F0F0404
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0404
          0F0F04040F0F0F0F0F0F0F04040F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0F
          0F04040F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F04040F0F0F0F04040F04040F0F0F0F04040F0F0F0F0F0F0F04040F0F0F0F
          0F0F0F0F0F0F0404040F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F04040F04040F
          0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F04
          04040F0404040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F0F0F0F040404040F0F0404040F0F0F0F0F0F04040F0F0F0F04040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F
          0F0F0404040F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F040404040F0F0F0F0404040F0404040F0F0F0F04040F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F040404040F0F04040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04040F04040F0F0F
          0F04040F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F04040F
          0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F04040F0F0F0F04040F0F0F0F04
          040F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F04040F0F0F0F04040F04040F0F0F0F04040F0F0F0F0F
          0F0F04040F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F
          0F04040F0F04040F0F0F0F0F0F0F0F0F0F0F040404040F0F0F04040F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F04040F0F0F0F
          04040F0F0F0F0F04040F0F0F04040F0F0F0F0404040404040404040404040F0F
          0F04040F0F0F0F0F0F0F0F0F040404040404040F0F0F0F04040404040F0F0F04
          040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F04040F0F0F0F0F0F0F04040404040F0F0F04040F0F0F0F04040F0F0F0F0F
          0F04040F0F0F0F0F0F040404040404040F0F0F0F0F04040F0F0F04040F0F0F0F
          0404040404040404040404040F0F0F04040F0F0F0F0F0F0F0F0F040404040404
          040F0F0F0404040404040404040404040F0F0F0F0F0F0F0F0F0F04040F0F0F04
          040F0F0F04040F0F0F04040F0F0F0404040404040404040404040F0F0F04040F
          0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F04040404040F0F0F04040F0F0F
          0F04040F0F0F0F04040F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F04040F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F04040F0F0F04040F0F
          0F04040F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F
          0F0F0F04040F0F0F0F04040F0F04040F0F0F0F0F0F0F040404040404040F0F0F
          0F04040F0F0F0F0404040404040404040404040F0F0F04040F0F0F0F0F0F0404
          0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04040F0F0F0F
          0F0F04040F0F0F0F04040F0F0F0F0F04040F0F0F04040F0F0F0F040404040404
          0404040404040F0F0F04040F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F
          0404040404040404040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0404040404040404040F0F0F
          0F04040F0F0F0F0F0F04040F0F0F0F04040404040404040F0F0F0F0F0F04040F
          0F0F04040F0F0F0F0404040404040404040404040F0F0F04040F0F0F0F0F0F0F
          04040404040404040F0F0F0F0404040404040404040404040F0F0F0F0F0F0F0F
          0F0F04040F0F0F04040F0F0F04040F0F0F04040F0F0F04040404040404040404
          04040F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F04040404
          04040404040F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0F0F04040F0F0F0404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F04
          040F0F0F04040F0F0F04040F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F04040F0F0F04040F0F0F0F04040404
          040404040F0F0F0F0F04040F0F0F0F0404040404040404040404040F0F0F0404
          0F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F
          0F0F04040F0F0F0F0F0F04040F0F0F0F04040F0F0F0F04040F0F0F0F0F04040F
          0F0F04040F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F04040404040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F04040404040F0F0F0F04040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F
          04040404040F0F0F0F04040F0F0F0F0F0F04040F0F0F04040404040F0F0F0F0F
          0F0F0F0F04040F0F0F0F0F04040F0F0F04040F0F0F0F0F0F0F0F04040F0F0F04
          040F0F0F0F0F0F04040404040F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0404
          0F0F0F0F0F0F0F0F0F0F04040F0F0F04040F0F0F04040F0F0F04040F0F0F0404
          0F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F04040404040F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0F
          0F04040F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F04040F0F0F04040F0F0F04040F0F0F04040F0F0F0F0F0F0F04040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040F0F0F0F0F04040F0F0F0404
          0F0F0F04040404040F0F0F0F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0F
          0F04040F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0404
          0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F04040F0F0F0404
          0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F04040F0F0F04040F0F0F0F0F0F
          0F0F04040F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F
          0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F04040F0F04040F0F0F0F0F04040F
          0F04040F0F0F04040F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F04040F
          0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04040F0F0F0F04
          040F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F04040F0F04040F0F0F0F0F04040F0F04040F0F0F0F0F
          0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F
          04040F0F0F0F04040F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04
          040F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0404040F0F0F0F0F04040F0F0F0F
          04040F0F0F04040F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F04040F0F0F
          0F0404040F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F04
          040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0404040F0F0F0F0F04040F0F0F0F0F0F0F04040F0F0F0F0404040F0F0F0F
          0F04040F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F04040F0F
          0F04040F0F0F0F0F0F04040F0F0F0F0404040F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0404
          0F0F0F0F0F04040F0F04040F0F0F0F04040F0F0F0F0F0F04040F0F0F0F040404
          0F0F0F0F0F0F04040F0F0F0F0F0404040F0F04040F0F0F0F0F0F0F04040F0F0F
          0F04040F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0404040F0F0F0F0F0F0F
          0F0F0F0F0F0F04040F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F04040F0F0F0F0F04040F
          0F04040F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404
          040F0F0F0F0F0F0F04040F0F0F0F0F04040F0F04040F0F0F0F0F0F0F0F0F0F0F
          0F04040F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0404040F0F0F0F0F0404
          040F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F040404040F0F
          0F0404040F0F0F0F04040F0F0F04040F0F0F0F0F0F0F04040F0F0F0404040F0F
          0F0F0404040F0F0F0F0404040F0F0F0F0F0404040F0F0F0F0F04040F0F0F0F04
          040F0F0F0F0F0404040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F04040F0F0F0F0F0404040F0F0F
          0F040404040F0F0F0404040F0F0F0404040F0F0F0F0F04040F0F0F04040F0F0F
          0F0F0F0F04040F0F0F0404040F0F0F0F0404040F0F0F0F0404040F0F0F0F0F04
          04040F0F0F0F0F04040F0F0F0F0404040F0F0F0F0404040F0F0F0F0F0F0F0F0F
          0F0F04040F0F04040F0F0F0F0F04040F0F04040F0F0F0F0404040F0F0F0F0404
          040F0F0F0F0404040F0F0F0F0F0F0404040F0F0F0404040F0F0F0F04040F0F0F
          0F0F0404040F0F0F0F04040F0F0F0F0F0404040F0F0F0F0404040F0F0F0F0404
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0404
          0F0F0F0F0F04040F0F04040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F
          04040404040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F04040F0F0404040F0F
          0F0F0F04040F0F0F0F04040F0F0F0F0F0404040F0F0F0F0404040F0F0F0F0404
          04040F0F0F04040404040F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F
          0F0F0404040404040404040F0F0F0F0F04040F0F04040F0F0F0F0F0F0F0F0F04
          040F0F0F04040404040404040F0F0F0F0F040404040404040F0F040404040404
          0404040F0F0F0F0404040404040404040F0F0F0F0F04040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F040404040404040F0F0404040404
          040404040F0F0F0F0F0404040404040404040F0F0F0F0F040404040404040404
          0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F04040404040404040F0F0F0F0F04
          0404040404040F0F0404040404040404040F0F0F0F0F04040404040404040F0F
          0F0F0F0F0F0F0F0F0F0F04040F04040F0F0F0F0F0F0F04040F04040F0F0F0F0F
          04040404040404040F0F0F0F0F040404040404040F0F0F040404040404040F0F
          0F0F0F0404040404040404040F0F0F040404040404040F0F0F04040404040404
          040F0F0F0F0F040404040404040F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F04040F04040F0F0F0F0F0F0F04040F04040F0F0F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          04040F0F0404040404040404040F0F040404040404040F0F0F04040404040404
          040F0F0F0F0F04040F0404040404040F040404040404040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F04040F0F0F0F04040F0F040404040F0F0F0F0F0F04040F0F04040F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F040404040F0F0F0F0F0F0F04040F04040404
          0F0F0F0404040404040F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F04040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F040404
          040F0F0F0F0404040404040F0F0F0F0F0F04040F0F040404040F0F0F0F0F0F0F
          0404040404040F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F04040404
          0F0F0F0F0F0F0F04040F040404040F0F0F0404040404040F0F0F0F0F0F0F0F0F
          040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F04040F0F0F0F0F0F0F0404
          0F04040F0F0F0F0F0F0F040404040F0F0F0F0F0F0F04040F040404040F0F0F0F
          04040404040F0F0F0F0F0F0F0F0404040404040F0F0F0F040404040404040F0F
          0F0F0F040404040F0F0F0F0F0F0F04040F040404040F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F04040F04040F0F0F0F0F0F0F04040F04040F0F0F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F04040F0F04
          040F0F0F0F0F0F0F04040F0F0F0404040404040F0F0F0F040404040404040F0F
          0F0F0F040404040F0F0F0F0F0F0F04040F0F040404040F0F0F0F040404040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F04040F
          0F0F0F0F0F0F04040F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F04040F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F04040F0F0F0F0F0F0F0404
          0F04040F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F040404040F0F0F0F0F0F0F0F0F040404040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F040404040F0F
          0F0F0F0F0F0F0F040404040F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F040404040F0F0F0F0F0F0F0F0F040404040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F040404040F0F0F0F0F0F0F0F0F040404040F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F
          0F0F0F0F0F0F0F0F0F04040404040404040404040404040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040F0F0F0F0F0F0F0F0F04
          0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F0F04040404040404
          040404040404040F0F0F040404040F0F0F0F0F0F0F0F0F040404040F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404040404040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F04040404040404040404040404040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F
          0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F04040F0F0F04040F0F0F0F0F0F0F0F0F0F0F04040F0F
          0F04040404040404040404040404040F0F0F0404040F0F0F0F0F0F0F0F0F0F0F
          0404040F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404
          040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F040404
          04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0404
          0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404
          04040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404
          0404040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F
          0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404
          0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F
          0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F
          0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0404040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F040F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F04040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F040F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404
          0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040F0F04040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0404040F0F0F0F0F0F0F
          0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404
          040F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F
          0F0F0F0F0F0F0F040F0F0F040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404
          04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          0F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0404040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F
          0F0F0F0F0F0F0F0F0F0F0F040F0F0F040404040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040F04040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F04040F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F04040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F040404040F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F040F0F0F04
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F04040F
          040F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F040F0F0F040F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F
          0F040F0F0F0F0F0F0F0F0F0F0F0F0F040F0404040404040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F040F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F0404040404
          0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F
          04040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F
          040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0404040404040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F040F
          0F0F040F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F040F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F04
          0F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F
          040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F04040F04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          040F0F04040404040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040404040F0F040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F040404040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040F04040404040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040F0F040F0F0F0F0F0F0F0F0F0F
          0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F
          0F0F0F0F04040404040F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F
          0F0F0F0F0F04040F04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F
          0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404
          040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040F0F040F0F0F0F0F0F
          0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404
          04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F04040404040F0F0F0F0F
          0F0F0F0F0F0F0F0F04040F04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F
          0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F040F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404
          04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0404040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F
          0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F04
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F04040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F04
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F
          0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          040F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0404040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F04040F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0404040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F
          0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F
          0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404
          040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F
          0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F
          0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F
          0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F
          0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F04040F040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F040F
          0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          0F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F040F0F0F
          0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F
          040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F040F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F040F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F04040F040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F04
          0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F040F0F0F04040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F
          0F040F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F04040F040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F
          0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0F040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F040F0F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F04040404040F0F0F0F0F0F0F0F
          0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404
          0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F
          0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F04
          040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F
          0F0F0F0F0F0F0F04040404040F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F040404
          04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F
          0F0F0F0F0F0F0F0F04040F04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040F0F040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          040404040F0F040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F
          0F0F0F0F0F0F0F0F0F0F04040F04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F
          0F0F0F0F0F0F0F0F0F0F0F04040404040F0F040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F04040F04040404040F0F
          0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F
          0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F04040404040F0F040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F04040F04040404040F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F
          0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0404040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040404040404
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F04
          04040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F
          0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0404040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F04040404
          040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404
          040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F04040404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F04
          0F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F04040F0404040F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0404040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F0F0F04040404040404040F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F04040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040404040F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F00040F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F00040F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00040F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00040F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F00040F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F
          0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F
          0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F
          0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F
          0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F00
          0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F
          0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F
          0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000000
          0606000000000000000000060600000000000000000006060000000000000000
          060600000000000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000000000000060600
          000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F060600000000000000000006060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0606000000000000000000060600000F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F00000000000606000000000000000006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F000000000000000006060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0000000000000000060600000F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000000
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0000
          060600000F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000000000000006060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000
          000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0000000000000F0F06060F0F0F0F0F0F0F0F0F06060000000000000000000606
          00000000000000000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0404040F0F0F0404040F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0006060000000F0F0F0F00000606000000000000000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0000000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00
          0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040F0F0F040F040F0F0F040F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F00060600000000000000000F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000000
          000006060000000000000F0F0F06060F00000000000000000606000F0F0F0F0F
          0F0F00060600000000000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0000
          00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F04040F040F0F0F040F040F0F0F040F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0000
          06060000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000000000000
          0606000F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F0606000000000000000F
          0F06060F0F0F0F0F0F0F0F060600000000000000000006060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F000000000006060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040404
          0F0F040F0F0F040F000000000000000202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020202020202020202020202000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F040F0F0F040F040F0F0F040F0F0F0F0F0F0F0F020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          020202020202020202020202020202020202020202000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040F0F0F040F040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0000
          0606000F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000000000606000F0F0F0F0F
          0F0F06060F0F0F00000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F000000000F0F0F0F06060F00000000000F0F0F06060F0F0F0F0F
          0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F000F0F0606000000000000000006060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0404040F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060000000F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000000
          0606000000000000000F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000006060000000000000F0F
          0F06060F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000000000F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F
          0000000F00000606000000000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F00060600
          000000000000000006060F0F0F0F0000000006060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000000000F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000000F
          0F000006060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F040F0F0F0F0F0F040F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          000000060600000000000F000F0F06060F0F0F0F0000000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F000006060F0F0F0F00000000000606000000000F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F000000000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F060600000F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F04040F0F0F0F0F0F040F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000000000000
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F000000000F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F0F0F0F0F04040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0000000F00000006060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000000
          0606000000000000000006060000000F0F0F00000006060000000F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000000
          0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F000000000000000606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F0F0F00000006060000
          000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F060600000000000000000006060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000000
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0000000000000000060600000000000000000006060000000000
          0000000006060000000F000000000F0606000000000F0F000006060000000000
          000F0F0F0606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F00000000000006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606000F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060000000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0000000F000000000606000F0F000F0F000F000606000F0F0000000F
          0F06060F0F0F0F0F0F0F0F0F0606000F000F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F00000000000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0000000F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F0F0F04040404040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F000606000000000000000000060600000F0F0F0F0F0F0006
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F00060600000000000F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606000000000000000F00
          060600000000000000000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0000
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F00000F0000000F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000060600000F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F040F0F0F0F0F0F
          040F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F
          0F0F0F040F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606000F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060000
          000000000000000606000000000000000000060600000000000000000F06060F
          0F0F0F00000000000606000F000000000F0F060600000000000000000006060F
          0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000000000006
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F04040404040404040F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F04040F0F0F040F0F0F0F0F04040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0006060F0F0F0000000000000606000F0F0F0F0F0F0F0F06060000000F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F000F0F0F0F060600000000
          0000000F0006060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F04040404040F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F04040F0000000000000002
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F040F
          0F0F0F0F0F0F0F02020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000006060000000F0F0F00000F06060F
          0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F000000000F0F0F0606000F0F0F0F0F000F0F06060F0F0F00000000000006
          060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000000606000F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F
          000F000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F04040404040F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F060600000000
          000000000F06060F0F0F0F0F0000000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0606000000000000000F0F060600000000000000000F060600
          00000000000000000606000000000000000F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F0606
          000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          000606000000000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0C0F0F0F0F0F0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000000
          0F0F060600000F0F000F000F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00060600000000
          0F0F0F0F0F0606000000000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0000000F0F0F06060F0000000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F040404040F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0606000F0F00000000000006060F0F0F000000000F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0000000F0F06060F0F0F0F0F0F00000006060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0006060000000000000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F04040404040404
          040F0F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0F0F0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000000000F0F0F0000060600
          00000000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0000000006060F0F0F0F0F0F0F0000
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F
          0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F000006060F000000000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F040F0F0F0F0F0F04040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0C0C0C0C0F
          0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F00060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000000000F0F0606
          0F0F0F0F0F0F0F0F0F06060F000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F000000000F060600000F0F0F0F000F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0F0F0F0C0C0C0F0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0000000000060600000F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000000060600000F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0006060000000000000000000606000000
          0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0F0F0F0C0C0C0C0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F000F000006060F0000000F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F00060600000000000F0F0F0F06060F0F0F000000000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F000F0006060000000000000F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000F0F0F0F0F0F06060F0F0F0F
          0000000000060600000F0F00000F0F0F06060F0F000000000F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0000000006060000000F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0F0F0F0C0C0C0C0F0F0F0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F
          0F000000000F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F06060F0F0000000F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F060600000000000000
          0006060000000000000F0F0006060F0F0F0F0F0F00000006060F0F0000000F0F
          0F0F060600000000000F0F0F0F06060F0000000000000000060600000F0F0F00
          000006060F0F0F000F0F0F000006060000000000000F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0F0F0F0F0C0C0C
          0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F0606000000000F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000000606
          00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06
          060F0F0F0F0F0F0F0F06060F0F0F0F000000000006060000000000000F0F0F06
          060F0F0F0F000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F000606000000000000000F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0C0C0C0C0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F00000F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040404040404040404040F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F040F040404040404
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000000000000
          060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F04040F040F0F0F
          040F040F0F0F040F000000000000000202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020202020202020202020202000F0F0F0F0F0F0F0F0F0F0F0C0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F040404040F0F0F040F0F040F0F0F0F0F0F0F0F020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          020202020202020202020202020202020202020202000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F040F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000000
          00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F04040F0F040F0F0F0F04040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F00
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040404
          0F0F0F0F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F0F040F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F040F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F040F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040F0F0F0F040F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F0F040F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F040F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F040F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040404
          0F0F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F040F0F0F040F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F04040F0F0F0F0F040F040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F040F040404040F0F
          0000000000000002020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F04040404
          0F0F040F0F0F0F0F0F0F0F0F0F0F0F0202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020202020202020202020202000F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F
          0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F040F0F0F0F04040F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000000
          00000000000606000F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F040404040F0F0404040F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0606000000000F000F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0006060000000F00000F000F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000606000000000F00000F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F040F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F
          0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000060600000000
          0000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F040F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F
          0C0C0C0C0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          00000606000000000000000F0F06060F0F0F0F0F0F0F0F0F06060000000F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F040F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F000006060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F
          0606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F040F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F00000006060F0F0F0F000F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F040F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000006060F0F0F0F
          0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000
          000006060F0F0F0F0F0000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040404040404040404040F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0000000006060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F04040404
          0404040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0000000006060F0F0F0F0F0F0F000006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F04040F040F0F0F040F040F0F0F040F00000000000000020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          020202020202020202020202020202020202020202000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0404040F0F0F0F0F0F0F0F0F02
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202000F0F
          0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F040F040F0F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F000000000F0606000F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F00000000000606000F0F0F0F0F0F000006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000000000606000F0F0F
          0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0006060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F040404040F0F0F040F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F00060600000F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0006060F0F0F0F00000F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040404040F0F0F040F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F00060600000F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F040F0F0F
          04040F0F0F000F0F0F0F0F0F0F0F0F0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00060600000F0F0F0F0F0F0F060600
          000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0606000F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040F0F0F040F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000606000F0F0F
          0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0606000000000F0000000006060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F040F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          00000606000F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F00000000000F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0000000000000606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0000000F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F00000F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F0F0F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0F0F0F0F0C0C0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0606000F0F0F0F0F0F0F0F06060F
          0000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F
          00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F04040F0F0F0F04040F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0F0F0F0F0F0C0C
          0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000606000F0F0F
          0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          060600000F0F00000F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060000000F0F0F0F0F
          0F06060F0F0F0F0F0F04040404040404040F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0F0F0F0F0C0C0F0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040404040404040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          000F0606000F0F0F0F0F0F0F0F06060F0000000000000F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F060600000000000000000F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00000606
          00000F000F0F0F0F0F06060F0F0F0F0F0F0F0404040404040F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0F0F0F0F0C0C0F0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F04040F040F0F0F040F040F0F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F000F0606000F0F0F0F0F0F0F0F06060F000F0F0F00000F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F00000F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F000006060F000000000F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0C0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040F0F
          040F040F0F0F040F000000000000000202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020202020202020202020202000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0F0F
          0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F040F040F040F0F0F040F0F0F0F0F0F0F0F020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          020202020202020202020202020202020202020202000F0F0F0F0F0F0F0F0F0F
          0C0C0C0C0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F04040F040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F00060600000F0F0F0F0F0F0F06060F0F0F0F0F0F000000060600000F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0006060F000000000F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          000F0F0F0F0000000F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0006060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F000000000F06060000000F0F000F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F060600000F0F0F000F000F06060F0F0F0F0F0404040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000006060F000F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F060600000F0F0F0F
          00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F00000000000F06060F0F0F0F0F
          040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000006060F000F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0006060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F040F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F00060600000F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F040F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000000000006060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0000000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0000000000000F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F000000000606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F060600000F000000000F000606000F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0000000F060600
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0404040F0F04040404040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0606000F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F000F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F000000060600000000000F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F
          0F0F0F0F0F0606000000000000000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          00000F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F
          040F0F040F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F000F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F060600000F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F
          0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F04040F0F0F0F0F040F0F0F04040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F00
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F0606000F00
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0000
          06060F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0000000F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F04040F0000000000000002
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202000F0F
          0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F040F
          0F0F0F0F0F0F0F02020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F
          040F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F000F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F000F0F00000006060F0F0F0000000F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0404040F0F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0000
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000000000F0F06060F0F0F
          0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F060600000F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F060600000F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000000
          0F0F0F06060F0F0F0F0000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000006060F000F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F060600000F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0000
          0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F060600000F00000F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F000606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F060600000F0F0F0F0F0F0F
          06060F0F0F0F0F00000006060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0404040404040404040F0F0F000F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F0F
          000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F
          0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F
          00000F0F0F0F0F0F06060F0F0F0F0F0F0F0006060F0F0F0F000F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F000F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000
          00000006060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F000F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F00000F0F00000F0F06060F0F0F0F0F0F0F0F0F
          06060F0000000F0000000006060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F00000F0F0F06060F0F00000F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0C0C0C0C0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F0F00000F0F06060F
          0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0006060F0F0F0F0F0F0F0F000606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F00000000000F0F
          06060F0F0F0F0F0F0F0F06060F000F0000000F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          04040F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0C0C0C0F0F0F0C0C0F0F0F0F0F0F
          0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F
          0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F
          0F0000000F00000F0606000F0F0F0F0F0F0F06060F000F0000000F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0404040F0F0F0F0F0F0F0F0F0F000F0F0F0F0C0C0C0F0F0C
          0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F04040404040F0F0F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F000F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F0F
          0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          000F0F0F0F06060F0F0000000F0F000006060000000F0F0F0F0F06060F0F0000
          00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0C0C0C0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040F0F0F0F040404040404
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F000F0F00000F0F06060F0F0F0F0F0F0F0F0F
          06060F0000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F000F0F0F0F06060F0F00000F0F0F0F0F06060F0F000F0F0F
          0F0F06060F0F0F000F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F000F0F
          00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0C0C0C0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F04040F0F0F0404
          0F0F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F0F0F00000F06060F
          0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          00000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F0F000F0F0F0F0F0F
          06060F0F0000000F0F0F06060F0F0F000F0F0F0F0006060F0F0F0F0F0F0F0F0F
          06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0C0C0C0F0F0C0C0C0C0F0F0F0F0F
          0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F0F040F0F040F00000000000000020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          020202020202020202020202020202020202020202000F0F0F0F0C0C0C0F0F0F
          0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F040F0F0F0F0F0F0F0F02
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020204020202020202020204020202000F0F
          0F0F0F0C0C0C0F0F0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F04040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F000F0F0F0F000006060F0F000F0F0F000F0F
          06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000
          0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F00000F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F
          000006060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040F0F0F0F0F
          04040F0F0F000F0F0F0F0F0F0C0C0F0F0F0F0F0C0C0C0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040404
          0F0F0F0F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F00000F0F00000F060600
          00000000000F0F0F06060F0F0F00000000000F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0000000F0F0F0F
          06060F0F0F0F0F0F0F000606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0404040F0F0F0F04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F00
          0F0F000F0F06060F0F0F0F0F0F000F0F06060F0F0F000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F
          0F0F0F000F0F0F0F06060F0F0F0F0F0F000006060F0F0F0F000F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0404040F04040F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F000F0F000F0F06060F0F0F0F0F0F000F0F06060F0F0F000F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F
          0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F00000F06060F0F0F0F
          000F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F0606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F040404040F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F000F00000F0F06060F0F0F0F0F0F000F0F
          06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0000
          0F0F06060F0F0F0F000F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F000F0F
          0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F04040F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F000F00000F0F06060F
          0F0F0F0F0F00000006060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F
          06060F0F0F00000F0F0F06060F0F0F0F0F000F0F0006060F0F0F0F0F0F0F0F0F
          06060F0F0F000F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F04040F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0000
          0F00000F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F
          0F0F0F000F0F0F0F06060F0F00000F0F0F0F06060F0F0F0F00000F0F0006060F
          0F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F0606000F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F000F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F
          0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F000F0F0F0F0F06060F0F0F0F
          00000F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F000F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040404040404040404040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F000000000F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000F0006060F000F000F0F
          0F0F06060F0F0F0F0F000F0F0F060600000F0F0F0F0F0F0F06060F0F0F000F0F
          0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0404040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F
          0F0F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F060600000F0000000F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000000000000
          060600000000000F0F0F06060F0F0F0F0F000F0F0F06060F00000F0F0F0F0F0F
          06060F0F00000F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F00000F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F0F0F0F06060F0F0F000F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F040F0F0F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F0F
          000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000000000000000006060F
          0F0F0F0F0F0F00000606000F0F0F0F000F0F06060F0F0F0F0F000F0F0006060F
          0F000000000F0F0F06060F0F0F000F0F0F0F0F06060F00000F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F00000F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F00000F0F0F
          06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0000
          0006060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0C0F0F0F0F0F0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F04040F0F0F040F0F0F040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0006060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F000006060F0F0F00
          00000F0F0006060F0F0F0F0F00000F0F06060F0F0F000F0F0F0F0F06060F0F00
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F00000000000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          00000F0F000F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040404040F0F
          0000000000000002020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0F0F0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F040F
          0F0F040F0F0F0F0F0F0F0F0F0F0F0F0202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020202020202020202020202000F0F0F0F0F0F0F0F0F0C0C0C0F0C0C0C0C0F
          0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F04040F0F0F04040F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F0F0F06060F0F0F0F
          000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0006060F
          0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0006060F0F0F000F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0000
          06060F0F00000000000F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F000F0F
          06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0F0F0F0C0C0C0F0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0404040F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F
          0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F06060F0F0000
          000000000006060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F
          000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F000606000F00000F000F0F06060F0F0F0F0F0F00000006060F
          0F0F0F0F0F000F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0F0F0F0C0C0C0C0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F00000F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F
          0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F000F0F06060F0F0F0F
          0F0F00000006060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0F0F0F0C0C0C0C0F0F0F0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F06060F0F0F0F0F000F0F0F06060F
          0F0F0F0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F
          06060F0F0F0F0F0F0F0006060F0F0F0F00000F0F0006060F0F0F0F0F0F0F000F
          06060F0F0F0F0F0F0F0F0F0606000F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00
          000F06060F0F0F0F0F0F00000006060F0F0F0F0F0F000F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0F0F0F0F0C0C0C
          0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F06060F0F0F0F
          0F000F0F0F06060F0F000000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F
          0F0F0F0F0F00000006060F0F0F0F0F0F0F0006060F0F0F0F0F000F000006060F
          0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060000000F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F000006060F0F0F0F0F0F0F000006060F0F0F0F0F0F000F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0C0C0C0C0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F
          0F0F06060F0F0F0F0F000F0F0F06060F0000000F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000000000006060F0F0F0F
          0F0000000F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F0606000000
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00060600000000000000000006060F
          0F0F0F0F0F000F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          0606000F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F060600000F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000000
          000006060F0F0F0F0F000F000006060000000F000F0F000F06060F00000F0F0F
          0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0000060600000000
          0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F00000000000F0F060600
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F000000
          060600000F0F0F0F000006060F0F0F0F0F00000F0006060F0F0F000000000000
          06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          00000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F0F0C0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F
          0F0F0000000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F
          0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0006060F0F0F0F0F00000F0006060F
          0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F
          06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060000000F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F
          0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0006060F0F0F0F
          0F0000000006060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          0F0F0F0F0000000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00000606000F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0C0F0F0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F00
          06060F0F0F0F0F0F0F0006060F00000F0F0F0F0F0F0606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F
          000006060F0F0F0F000000000F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F000F0006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0000000006060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0C0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F
          06060F0F0F0F0F0F0F0006060F0F0000000F0F0F0F06060F0F0F0F0F00000F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F000F0000000006060000000F0F0F0F0000060600000F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000000000006060F0F0F0F000F
          0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0C
          0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F000006060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F
          0F0F0F0F00000F0F06060F0F0F0F0F0F0F0006060000000F0F0F0F0F0F06060F
          0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0000000000000606000000000000000000060600000000000F0F0000
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000F0F000F0F0F
          06060F0F00000F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F00000000
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0C0C0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F0000000000000002
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F
          0F0F0F0F0F0F0F02020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020404040404040404
          0404020202000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F00000F0F06060F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F000006060F0F0F000F0F0F0F0F
          06060F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0000000F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000F060600000000000000
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F00000F0F0F0F06060F000F0F0F000F0F0F06060F0F0F0F0F00
          0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0F
          0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0006060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000000000F00000F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F0606000F0F0F0F000F0F0F
          06060F0F0F0F00000F0F0006060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F040404040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F
          0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000F
          0F000F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F
          0F0F0F0F000F0F0F06060F0F0F000F0F0F0000060600000F000F0F0F0F000606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F04040404040F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0000
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F060600000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F000F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F0606000F000000000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F0F0F0F0F000F0F0F06060F0F0F000F0F0F0F0F06060F0F00
          0F000F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F04040404040F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F00000000000006060F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060000000000000F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F000F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F0606000F0000000F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0000000F06060F0F0F0F0F000F0F0F06060F00000F0F0F
          0F0F0F06060F0F0F0000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0404040F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0000000F0006060F0F0F0F0F0F0F0F06060F0F0000
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F00000F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F
          0F0F00000F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F000F0F06
          060F0F0F0F0F0F0F0F0F06060F0000000F0F0F0F0F060600000F0F000F0F0F0F
          06060F0F000F0F0F0F0006060F000F0F000F0F0F0F06060F0F0F0F0F000F0F0F
          0606000F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F04040404040F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F
          0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0000
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F
          0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F060600000F0F
          0F0F0F0F0F06060F0F000F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F000F0F06060F0F0F0F0F0F00000F0606000F0F000F0F0F0F00060600
          000F000F0F0F0F0F0606000000000000000006060F0000000F00000F0F06060F
          0F0F0F0F000F000006060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F04040404040F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F
          060600000F0F0F0F0F0F06060F0F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F000000
          000606000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00
          000F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F00060600000F0F0F0F0F0F0F06060F00000F0F0F0F000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F00000F0606000F0F0F0000000F0006060F0F0F00
          0F0F0F0F0006060F0F000F0F0F0F0F0F06060F0F00000000000F06060000000F
          000F0F000F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F000F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0000000F0F06060F0F000F0F0F0F0006060000000F000F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000F0606
          0F0F0F0F000000000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F00000F0F0606000000000F0F00000F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F00060600000F0F0F0F0F0F0F0606000F0F0F0F0F0F0000
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0006060F0F0F000F0F0F
          0F0F06060F0F0F000F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F
          000F060600000000000F0F0F0006060F0F0000000F0F0F0F06060F0F0F0F000F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C
          0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F000F0F000006060F0F0F0F
          000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000
          000F0000000006060F0F0F0000000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F0606000F0F000F0F0F000F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0006060F
          0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0006060F0F0F0F0F0000000F06
          060F0F0F000F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F00000F000F0000
          06060F00000F0F00000F06060F0F0F000F0F000000060600000F0F0F0F0F0F0F
          06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F000000
          000F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F000000000F0F0F0606000000000F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F00
          0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F060600000000
          000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0006060F0F
          0F00000F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F000F0F0F0F060600
          000F0F00000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F000F0F000F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0C0F0F0F0F0F0F0C0C0C0C0C0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F
          06060F0F0F0000000F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F000F060600000F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F
          0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F000606000F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F000F06060F0F000F000F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F
          0F000F0F0F0606000F0000000F0F0F0F06060F00000F0F0F0F0F06060000000F
          0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0C0C0C
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F040F0F0F040F000000000000000202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020202020202020202020202000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          020202020202020202020202020202020202020202000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F
          0F0F06060F0F0F00000F0F0F0006060000000F0F0F0F0F0F06060F00000F0F0F
          0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000006060F000000
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F0F
          0F0F0F000006060F0F0F0F0F0F0F0F0006060F0F00000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F000F000F0F0F06060F00
          0000000F0F0F0F06060F000F000000000F0F06060F0F0F0F0F0F00000F060600
          0F00000000000F0006060F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040404040404040404040F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F00
          06060F0F0F0F0F0F0F0F06060F0F0F00000000000006060F0F00000F0F0F0F0F
          0606000F00000000000F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00
          0F0F06060F0000000F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F000F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0006060F0F0F00000F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F0F
          000F0F0F0606000000000F0F0F0F0F06060F0F000000000F00000606000F0F0F
          0F0F0F000F06060F000F0F0F0F0F000F06060F0F00000F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F
          0F0F00000F0F0F0F06060F0F0F0F0000000000060600000F0F0F000F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0000000606000000000000000F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0006060F0F0F0F0F0F0F0F00
          06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0606000F0F0F000F0F0F000606000F0F000F0F0F0F0F06060F0F000F0F000F
          0F0F06060F000F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0404040F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F000F06060F0F0F000F0F0F0F0F06060F0F0F0F000F00000006060F0000
          0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F00000F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0006060F
          0F0F0F0F0F0F0F0006060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0606000F0F000F0F0F000F06060F0F000F0F0F0F0F0F06
          060F0F0F0F0F00000F0F06060F000F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0006060F0F000F0F000F0F0F06060F0F0F00000F
          0F0F0F06060F0F000F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F000F0F06060F0F0F0F
          0F0F00000F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F00
          0F0F0F000006060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F000006060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F0F0F000F0F06060F0F
          000F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F000F0F000F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F04040F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F00000000000F0F
          0606000F00000F0F0F0F0F06060F0F0000000F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000000
          0F0F06060F0F0F0F00000F00000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F060600000000000000000F06060F0F0000000000000006060F0F0F0F0F0F
          0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F0F0F
          000F0F0006060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F000F
          0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0404040F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F
          00000F0F0F0000000606000F00000F0F0F0F0F06060F0F0000000F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          06000000000000000F0F06060F0F0F0F000F0F0F0F0606000F0F000000000000
          06060F0F0F0F0F0000000606000F0F0F0F0F0F0000060600000F0F0F0F0F0F00
          060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0606000F0F00000F0F0F0006060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F060600000F00000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F04040F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F000F06060F0F0F0F0F0F0F0F0006060F0F0F00000F0F0F0F06060F0000
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F000F0F00060600000000000000000006060F0F
          0F0F0F0F0F0F0F060600000000000F0F0F0F06060F0F0F0F000F0F0F0F060600
          0000000F0F0F000006060000000000000F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F000000000F0F0F0F0606000F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F00000F0F0F0F000006060F00000F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060000000F0F0F0F000F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0006060F0F0F0F000F
          000F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F0F0F0006060F00000000
          000F0F0006060F0F0F0F0F0F0F0F0006060F0F0F0F000F0F0F0F06060F0F0F00
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F000F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F0606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F0F0F0F0F000006060000
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F00000006060F
          0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040404040404040404040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          0606000F0F0F0F0F0F0F06060F0F0F0F000000000006060F0F0F0F0F0F0F0000
          06060F0F0F00000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0000
          0006060F0F0F0F00000F0F0F0606000000000F0F0F0F0006060F0F0F0F00000F
          0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F
          0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          000F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000
          000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F00000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00
          0F0F000F0F060600000F0F0F0F0F000F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F
          0F0F0F0F0F0F0F0006060F0000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          0600000F0F0F000F0F06060F0F0F0F000F0F0F0F06060000000F000000000F06
          060F0F0F0F0F00000F0006060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F000F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F000F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0000000F0F06060F0F0F0F0F0F0F0F060600000000
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0606000F0F0000000F0F06060F0F0F0F0F000F0F0F0606000F
          000F000F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F00000F0F0F06060F
          0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F06060F0F0F0F0F0F0F000F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F00000F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F000F0F000F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0000000006060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F000F0F0F000F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0000000000000002
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F
          0F0F0F0F0F0F0F02020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          000000000000000006060000000F0F0F0F0F060600000F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006
          060F0000000F0F000F06060F0F0F0F0F000F0F0F0606000F000F000F0F0F0F06
          060F0F0F0F0F0F0F0F0F0606000F0F00000F0F0F0F06060000000F0F0F0F0F00
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0000000F0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00
          0F0606000F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F00000F00000F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0000000006060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F00000F0F0F00000006060F0F00000F0F0F00060600000F0F
          0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F00000006060F000F0F0F0F000F06060F0F000F0F000F0F0F0606000F
          000F0F000F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F
          0F0000000F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F
          0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F000F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F000F060600000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0000000F0F06060F0F0F0F000F00000F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F00000F0F0F00
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F040404040F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F000000060600000F0F0F0F0F0F0F06060F0F0F000F0F
          0F0F060600000F0F0F0F0F0F0F06060000000F000000000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F000000000606000F0F0F0F00000F06060F00000000
          000F0F0F0606000F000F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F000000
          00000F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F000F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F
          0F000F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F000F000F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F
          0F0F000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F
          0F0F000F0000000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F04040404040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F0606000F0F0F0F0F0F0F0F
          06060F0F0F0000000F0F0606000F0F0F0F0F00000006060F0F00000000000000
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000F0F06060F0F0F0F0F0000
          00060600000F0F0F000F0F0F060600000F0F0F0F000F0F06060F0F0F0F0F0F0F
          0F0F06060F00000F00000F0F0F06060F0F0F0F0F00000F0006060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F0606000000000000
          0F000F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F00000F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F00
          000F0F0F06060F0F0000000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F0F0F000000000F0006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F04040F0F
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F
          0F0F0F0F0F0F0F0F06060F0F0F000000000006060000000F0F0F000F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F06
          060F0F0F0F0F000F0F060600000F0F0F0000000006060000000F0F0F000F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0000000F0F0F0F06060F0F0F0F0F0F000000
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F
          06060000000F0F00000000060600000F0F00000F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F
          0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0000000F0F06060F0F000F0F0000000F060600000F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0006060F0F0F00000F00000006060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F040F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0C0F0F0F0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000060600000000
          00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          00000000000F0F06060F0F0F0F00000F0F060600000F0F0F0F0F0F0F06060F00
          00000F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F
          0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060000000F0F0F0F0F0F06060000000000000F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F00000F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0000000F0F06060F000F0F0F0F00000F06
          0600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F000F00
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F040F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F
          0C0C0C0F0F0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F00000F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F060600000F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F000000000F000F0F060600000000000F0F0F06060F00000F0F
          0F0F0F0F06060F0F0F000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00
          000F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000F0F0F0F0F0F06060F0F0F
          0000000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F00000F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F00000F0F0F06060F0F0F0F000F00000F06060000
          0F0F0F0F0F000006060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F000F0F0000000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F040F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F0606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F00000000000000000606000F0F00000F0F
          0F06060F0F00000F0F0F0F0F06060F0F00000F0F000F0F06060F0F0F0F000000
          0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000000
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F000F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F06060F0F0F0F00
          000000000606000F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060000000F0F0000000F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F040F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0F0F0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000000000F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000000000000F0F06
          06000F0F0F0F0F0F0F06060F0F0000000F0F0F0F06060F00000F0F0F0F000F06
          0600000000000F0000000606000000000F0F0F0F0F06060F0F0F0F0F0F000F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F
          060600000F0F0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F
          0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F
          0F06060F0F0F0000000000000606000F0F0F0F0F0F0F0F06060F00000F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F060600000F000000000F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0F
          0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F000000
          0F0000000F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00
          00000000000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060000
          0F0F0F0F0F00000606000F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F
          0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F000606000F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F000F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0000000F0F00060600000F0F0F0F00000F06
          060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000F0000000F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0404040F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00
          000F060600000F0F0F0F0F00000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F00000F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F
          0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F060600000F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F0F000F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F06060F00
          0000000000000006060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F00000F0F060600000F0F0F0F0F0F000606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F00
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F0606000F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F000606000F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F00060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F000000060600000F0F0F0F
          0F0F0F06060F0F000000000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F06060F0F0F000F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0000
          0F0F0F0F06060F0F0F0F0F00000F0F06060F000F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F0606000F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F
          0F0F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F000F000F0F06060F00000000000F0F0F060600
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F000006
          0600000000000000000606000F0F0F0F0F0F0F0F06060F0F00000000000F0F06
          060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0000
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0000000F
          0606000F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F
          0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0006060F0F0000000F0F0F0F06060F0F0F0F0F00000F0F060600000F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0F
          0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F040F0F0F040404040F0F00000000000000020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          020202020202020202020202020202020202020202000F0F0F0F0F0F0F0F0F0F
          0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040F040F0F0F040F0F0F0F0F0F0F0F0F0F0F0F02
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202000F0F
          0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F04040F0F0F04040F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F00000606000F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F000F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F00000F00000F0F0F060600000000000F
          0F0F0F06060F0F0F0F0F0F0F000F060600000F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000006060F00000000
          0F0F0F0F06060F0F0F0F000F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F0606000F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F
          0F0F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060000000F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060000000F0F0F0F0F0606000F0F0F0F0F0F0F0006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F0F0F0F
          06060000000F0F0F0F0F0F0606000F0F0F0F0F0F000F06060F0000000F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0006060F0000000F0F0F0F00060600000F00000F00000F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F0606000F0F000F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F04
          0F0F04040404040F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F000006060F0F0F0F0F0F0F0F0F06060F000000000000000F06060F000000
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F000000060600000000
          00000F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000000000F000F0F0606
          0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F000006060F0F00000F0F0F0F000606000000000F0000000F06
          06000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F040404040404040404040F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0000
          000006060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          000F0606000F0F0F0000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F00000F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0000000F06060F0F0F000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F
          0F0F0F0F0F0F0F06060F0F0F0F0F00000F06060F0F00000F0F0F0F0F06060F0F
          0F000000000F0F0606000F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F0F0F0F04040F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F0F00000F0F0F0F
          06060F0F0F0F0F0F0F000606000F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F000006060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F00000F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F00000F06060F0F0F000F
          0F0F000006060F0F0F00000F000F0F0606000F0F0F00000F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F0F0F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060000000000000F0006060000000F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F06
          06000F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0000
          0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0000
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F000000
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0000000F0F0F0F0F06060F0F0F0F00000F
          0F06060F0F0F00000000000006060F0F0F00000000000F06060F000000000F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0404040F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0000
          0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F000F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0000000F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00
          000F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          00000F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F
          0F0F0F0F00000F0F0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          000F0F0F0000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F000F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606
          00000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06
          060F0F0F00000F0F0F06060F0F0F0F0F0F00000F06060F0F0000000F0F000006
          060F0F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F040F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F
          0F0F0606000F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0000000F0F
          000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F00000F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F
          0F000F0F0F06060F0F0F00000F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F000F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F000F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F000000060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F000F0F0F0F06060F0F00000F0F0F0F06060F0F0F0F0F0F0F000006060F00
          0000000F0F0F0006060F0F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F000F0F000F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F000006
          060F0F0F0F0F0F0F0F0F06060F00000000000F0F00060600000F0F0F0F000000
          060600000F0F0F0F0F000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F060600000000000000000006060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F00000F0F
          0F0F06060F0F0F0F00000F0F0F06060F00000F0F0F0F0F0F0606000F0F0F0F0F
          0F0F06060F0F0F0F0F0F00000F06060F000F0F0F000F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F00000F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F000000000006060F0F00000F0F0F0F06060F0F0F0F0F
          0F000000060600000F0F0F0F0F0F00060600000000000000000F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F0F0F0F0F
          040F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F
          0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          0F000000000F000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0006
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F00000F0F06060F0F0F0F00000F0F0F0606000F0F0F0F0F0F0F0F
          0606000000000000000006060000000000000F0000060600000F0F00000F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F000F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F060600000F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0000000606000F0000000F0F
          0F06060F0F0F0F0F0000000F0606000F0F0F0F0F0F00000606000F0F0F0F0F00
          00000606000F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F04040404040404040F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F04040404040F0F0F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F06060F0F0F000F
          0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F00000F0F0F000F0006060F0F0F0F0F00000F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00
          000F0F0F0F000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0000000F0F0F06060F
          0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F00060600
          0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606
          0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0006
          0600000000000F0F0F06060F0F0F0F0F00000F0F060600000000000F00000006
          060F0F0F0F0F0F0F0F000606000000000F0F0F0F0F06060F000F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F04040404040F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0404040404040F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00
          0006060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060000000000000F0F0F06060F0F0F00000F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F000F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060000000F
          00000F000006060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F00000F06060F000F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F00000F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F000006060000000000000F0F06060F0F0F0F0F00000F0F06060F0F
          0F0F000000000F06060F0F0F0F0F0F0F0F0F06060F000000000F0F0F0F06060F
          000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F04040F0F040F0F0F040F
          0000000000000002020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F0F040F0F040F0F0F0F0F0F0F0F0202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020202020202020202020202000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F040F0F0F040F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F000F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F000F0F0F0F06060000000F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F000F0F0F0F06060F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F
          000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F0606
          000000000F0F0F0F06060F0F0000000F0F0F0F060600000F0F0F0F0F0F000606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06
          060F0000000F0F0F0006060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060000000F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040F0F0F040F0F0F0F04040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F000F0F
          0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F000F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0606000F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0000000F0F0F06060F0000000F0000000606000000000000000000060600000F
          0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F000006060000000F0F0F0F0006060F0F0F00000F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F
          00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0000000F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000006
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F0F000F0F
          0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060000000000000F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0000060600000F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F000000000F0F0F06060F0F000000000F0F06060F0F00000F0F
          0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0006060F0F0F0F00
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F0F040404
          040F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F060600000F000F0F000006060F0F0F0F0F0F0F0F0F06060F0F
          0F0F00000F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F00000F0F000F000606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000F06
          060F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          0606000F0F0F0F0F0F0F06060F0F0F0F0F0F00000F0606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F060600000000000F0F0F
          06060F0F0F0000000F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F000000000000000006060000000F0F0F0F
          0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F04040F0F040404040F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F000F0F00000F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F000F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F000F0F0F000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F000F06060F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F00000606
          0F000000000F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F000F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060000000F0F0F00000006
          060000000F0F0F0F0F060600000F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F
          06060F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F040404040F0F04040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F00000F00000F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F000006060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F000F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F000006060000000000000F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F
          0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F
          0F0F0000000F06060F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F
          0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F
          0F0F0F0000000006060F0000000F0F0F0F060600000000000F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F04040F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          0600000F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0006
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F000F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606000F0F0F0F000F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F
          0F0F06060F0F0F0F0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F0606000F0F0F00000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F000F
          0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F00
          00000F0F06060F000000000F00000F060600000F00000F0F0F0606000000000F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060000000F0F0F0F0F0F06060F0F0F0F00000F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F04040F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0606000F000F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F
          000F0F0F0F0F0F0606000F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F
          000F0F0F000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          0600000F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          0606000F0F0F0F0F0F0F06060F0F0F0F00000F000006060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F00000F000606000F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F
          0F06060F0F0F00000F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F000000
          0F06060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F00
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F040F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F
          0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F000006060F00000F0F0F0F0F06060F0F0F0F0F
          0F000F0006060000000F0F0F0F0F0F06060000000F0F00000F00060600000F0F
          0F0F0F0F0F060600000F0F0F000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F00000F0F00000006060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F00000F0F00060600
          0F0F0F0F0F0F0F0F06060F0F0F00000F0F000F06060F0F0F00000F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0000000000000006060F0F0F0F0F0F0F0F0F0606
          0F000F0F0F0F0F0F0F06060F0F0F000F0F0F0F0006060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F00000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F040F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F000F0F0F0F0F
          0F06060F0F0F0F0F00000F0F0606000F0F0F0F0F0F0F0F06060F000F00000F00
          000F0606000F0F0F0F0F0F000006060F0F0F0F000F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F00060600000F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F
          000F0F0F0006060F00000F0F0F0F0F0F06060F0F000F0F0F0F0F000606000F00
          000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F00000F0F0F0F0F000606000F0F
          0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0000000F000F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F040F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0404040F0F04040404040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0006
          0600000F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F060600000000000000000F06060F0F0F000F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F
          0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000
          0F0F06060F0F0F0F0F0F0F0F0F06060000000F0F0F0F0F0F0606000F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F000006060F0F00000F0F0F0F0F06060F00000F0F0F
          0F0F0F0606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F0F0F
          0F0F0F0606000F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F06060F0F0F0000
          00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F
          040F0F040F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F00000F000606000F0F000000000006060F0F0F00000F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F
          0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F000F0F0F0F0F06060F0F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F000F000F06060F0F0F0F0F0F0F000006060F0F000F0F0F0F0F0F
          0606000F0F0F0F0000000606000F0F00000000000F06060F0F000F0F0F0F0F0F
          060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F000F0F0F0F0F06060000000F0F0F0F0F0F06060F0F0F00000F0F0F
          0F06060F0000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F
          000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F
          0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F040F0F0F04040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F000F0F00060600000000000000000606000000000F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F00000F0F0F0F06060F0F0F00000F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F000000000F06060F0F0F0F0F00000F0F06060F
          0F000F0F0F0F0F0F06060000000000000F0F060600000000000F0F000006060F
          0000000F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0000000F0F0F0F0F06060F00000000000F0F0F0606
          0F0F0F0F000F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F
          06060F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0C0C0C0C0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F04040F0F0F0F0F04040F0000000000000002
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F040F
          0F0F0F0F0F0F0F02020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F
          040F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F00000F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06
          060F0F00000F0F0F0F0006060F000F0F0F0F0F0F0F06060F0F0F0F0F00000F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F
          06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F000F0F0F0F
          0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F00
          000F0606000000000F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0404040F0F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F000006060F0F0F0F0F0F0F000F06060F0F
          0F0F0F0F0F0F0F06060F0F000F0F0F00000006060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          0F0F0F0F0F00000F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0000000606
          0F0F0F000F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F00000006060000000F000000000F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0404040F0F0F0F040F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F000F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F00000F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F000F0F0F0606000F0F0F0F0F0F0F0006060F0F0F0F0F00000F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F
          0F0F0F000F0006060F0F00000F00000F0F06060F00000F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F0606000F0F0F00000F00060600000000000000000006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F040404040F0F0F04040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0000000F06060F0F0F0F0F0F0F0F0F06060F0F0F000F0F0F
          000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F
          0F0F06060F0F0F00000000000F0606000F0F0F0F0F0F0F0006060F0F0F0F0F00
          000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0000000F000006060F0F00000F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F00000000000F0F0606000F0F00
          00000000000606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F04040F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F000000000000000006060F0F0F0F0F0F0F0F0F06
          060F0F0F000F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          0606000000000F0F0F0F06060F0F0F0F000000000006060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F00000000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0006060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F000F
          0F0F060600000000000000000F06060F000000000F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040F0F0F04040F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0F0F0F0F0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000000F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F060600000F0F0F0F0F0F000606000F
          0F0F0F0F0F0F0F06060F0F0F000F0F0F000006060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0F0F0000000000060600
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F00000F0F0000000F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F00000006060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F
          0606000F0F0F0F000F0F06060F0F0F0F0F000F000F06060F0F0F0F000F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F04040F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F00000000
          00000F0F06060000000000000F0F0006060F0F0F000F0F00000006060F0F0F00
          00000F0F0F06060F0F0F0F0F0000000006060F0F0F0F000000000606000F0000
          000F0000000606000000000000000F0F06060F0F0F0F00000F0F0F06060F0F0F
          0F000000000F06060F0F0F0F0F0F0F0F06060000000F0F0F0F000006060F0F0F
          0F0F0F0F0F0F0606000F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          00000F0F0F0F0F0F0606000F0F0F0F000F0F06060F0F0F0F0F0F0F000006060F
          0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F04040F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000000
          0006060F0F0F0F0F0F00000F06060F0F0F0F0000000000060600000000000000
          000006060F00000000000F0F0F06060F0F0F0F0F0000000006060F0F0F0F0000
          000006060000000F0F0F0F0F000606000F0F00000F000000060600000000000F
          0F0F0F06060F0F0F00000F0F0F0006060F0F0F0F0F0F0F0F0606000F0F0F0F0F
          0F0F0006060000000000000F0F0F06060000000000000F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0006060F0000000F0F0F0F0F0606000F0F0F0F000F0F06060F0F0F0F
          0F0F0F0F000606000F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F04040F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0C0C0C0C0F0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F00000F0006060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F060600000F0F0000000F0F06060F0F0F0F00000F0000
          06060F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          060600000F00000F0F0F0F0606000000000F0F0F0F0F0606000F0F0F0F000000
          06060F0F0F0F0F0F0F0F0F060600000F0F0F0000000F06060F00000000000F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F00060600000000000F0F0F00060600000F0F000F
          0F0F06060F0F0F0F0F0F0F0F00060600000F0F00000F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          04040F0F0F0F0404040F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0C0C0C0C0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00
          00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F00000F0006060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000000000000000F06060F
          0F0F0F000000000006060F0F0000000F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F0606000F0F0F0F0F0F0F0F0606
          0F00000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00000606
          0F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0000
          06060F00000F000F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0000000F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F040F0F0F0F0404040F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0C0C0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040404040404040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000000000F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F0006060F0F0F0F0F
          0F0F0F0F06060000000F0F0F0F0F0F06060F0F0F0000000F0F0F06060F0F0F0F
          0F0F00000006060F0F0F0F00000F000006060F0F0F00000F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F0000000F0606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0006060F0F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F
          00000F0F0F0F0F0F06060F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F000F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F040F040F0F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F00000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F
          0006060F0F0F0F0F0F0F0F0F06060F0F000000000F0F0F06060F0F0F00000000
          0F0F06060F0F0F0F0F0F000F0006060F0F0F00000F0F000006060F0F0000000F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000000
          0F000006060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F00000006060F0000000F0F0F0F0006060F000F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F00000F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0C0C0F0F0F0F0F0F0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040F0F
          040F040F0F0F040F000000000000000202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020202020202020202020202000F0F0F0F0F0F0F0F0F0C0C0C0F0C0C0C0C0F
          0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F040F040F040F0F0F040F0F0F0F0F0F0F0F020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          020202020202020202020202020202020202020202000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F04040F040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00
          000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F06060F0F0F0F0F
          0F0F0F0F06060F0000000F0F0F0F0F06060F0F0F000000000F0F06060F000000
          0F0F0F000006060F000F00000000000F0606000000000000000006060000000F
          0F0F0F0F0F060600000000000000000006060F00000F0F0F0F0F0F06060F000F
          0F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606000F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          00000F0F0F0F0F0F06060F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F060600000000000F0F0F0F
          06060F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F06060F0F0F0F00000F
          0F0F060600000F0F0F0F000F0F06060F0000000F0F0F00000606000000000F0F
          000006060F0F0000000F0F0F0F060600000F0F0F0F0F0F00060600000F0F0F0F
          0F0F0F0606000F0F0F0F0F0F000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F000000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F00000F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F000F0F0F060600
          000000000000000F06060F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F06
          060F0F0F0F00000F0F0006060F0F0F000000000F0F060600000F000F0F0F0000
          06060F0F0F000000000F06060F0F0F0F000000000006060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F060600000F0F000F00000006060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000000
          0F0006060F0F0F0F0F0F0F0F0F06060F0F000000000F000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00
          0F0F000F0F06060F000F0F0F0000000006060F0F0F0F0F0F0F0F06060F00000F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060000
          000000000F0F0F06060F0F0F0F00000F000006060F0F00000F0F0F0F0F060600
          0000000F0F0F000F06060F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F060600000000000000000006060F0F0F0F0F0F0F0F0F06
          0600000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F00000006060000000F0F0F0F0F0F06060F0F0000000000000F
          0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F000F000F0F0F06060F00000F0F0F0F0000060600000F0F0F0F
          0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F06060F00000000
          0000000006060F0F0F0F0F00000000060600000F0F0F000F000F06060F0F000F
          0F0F00000006060F0F0F0F0F0F0F000006060F0F0F0F0F0F000006060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F00000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F00000006060F0F0F00000F0F0F0F06060F
          0F0F0000000F0F0F06060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040404040404040404040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F000F000F0F0F06060000000F0F0F0F0000
          06060000000F0F0F0F0F06060F0F0000000F0F0F0F060600000F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00
          00060600000F00000F0F0F0006060F0F0F0F0F0F00000006060F0000000F0F00
          000F06060000000F0F0000000F06060F0F0F0F0F0F0F00000606000000000F00
          000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F0006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F000F0F0F06060F0F0F0F0F00000F0F060600000F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040404040404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F000F0F0F060600
          000F000F0F0F0F0F06060F00000F0F0F0F0F06060F0F0F0F0000000F0F060600
          0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06
          060F0000000000000F0F0606000F0F0F00000F0F0F06060F0F0F0F0F0F000000
          06060F0F0F00000F0F0006060F0F0F0F0F0F00000F06060F0F0F00000F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F0F00
          060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F000F0006060F000F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000
          000F00000F0606000F0F000000000F0F06060F0F0F00000000000606000F0F0F
          0F0000000006060F00000F000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F
          0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F0606000F0000000F0F0F0F06060F
          0F0F0F0F0000000F06060F0F0F0F0F0F0F0006060F0F0F0F0F00000F0006060F
          00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F000F0F0F0606
          0F0F0F0F0F0F000F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F000F0F0F0F0F06060F0F0000000F00000F06060F0F0F0F0F0F0F0F0F06
          060F0000000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F00060600000F0F0F0F0F000006060F0F0F0F0F0F000000
          06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F00000F000006060F0F00000F000F0F0F06060F0F0F0F0F0F
          0F0F06060000000F0F0F0F00000606000F0F000F0F00000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0006060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F060600000000
          000F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F000006060F0F0F0F
          000F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F000000000606000F0F0F0F0F0F0006060F0F000F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F000000000F06060F0F
          0F0F0F0F0F0F0F060600000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060000000F0F0F0F0F0F06060F
          0F0F0F0F0F00000F06060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000000060600000000000F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F000F0F0F0F000F06060F000000000000000F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F060600000000000000
          000F06060F00000F0F0F0F0F00060600000000000F0F0F0F06060F0F0F0F0F0F
          000F0606000F0F00000000000006060F0F000F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F000F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000000000F06060F0F0F0F0F
          0F00000F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00
          000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0000
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          040F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F000F00000000000006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F00000F0F0F000F06060F
          000000000F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06
          0600000F000F00000000060600000000000000000006060F0F0F0F00000F0F0F
          06060F0F0F0F0F0F000F060600000000000F0F0F0F0606000F0F00000F0F0F0F
          06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0006060F0F0F0F0F0F0F0F
          060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000000
          000606000F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F000F0F0F0F0F0606000F0F0F0F0F00000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F040404040404040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000000
          000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0000060600000000
          0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F00
          0F000F000F06060F000F000F0F0F0F0F06060F0F0F0F0F0F0F0F000606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F
          0F0F0F0F0F0F0F060600000F0F0F0000000006060F0F0F0F0F0F00000F06060F
          0F0F0F0F00000F0F06060F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F
          00000000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000000000F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060000000F0F0F0F0F0F06
          06000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F000F0F0F0F000F00
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040F0F0F040F040F0F0F040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F000F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0006060F0F00000F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F00000000000F0F060600000F0F0F0F0F0F0F0606000000000000
          000000060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000000
          00000F0F06060F0F0F0F0F0F0F0F0F06060F0000000000000000060600000F0F
          0F0F0F00000606000F0F0F0F0F00000F06060000000F00000F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          000F0F0F0F0F000606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000000000F0F0006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0006060000000F000F0F0F0F06060F
          00000F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040F0F040F0F0404040F0F
          0000000000000002020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F
          040F040F0F0F040F0F0F0F0F0F0F0F0202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020404040404040404020202000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F04040F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F000000
          000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F000F0F060600000000000000000F06060F0F0F000F0F0000000606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00000606000F
          0F0F0F0F0F0F0F0606000000000F0F0F0F0F060600000F0F0F0F0F0F0F060600
          000000000000000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000000000006
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          0600000000000000000006060F0F0F0F000000000F06060F0F0F0F0F0F0F0F0F
          06060F0F000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F000F
          0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0404040F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0006060F000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F000006060F0F0000000000000006060F0F0F0F0000
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F060600000F0F0F
          0F0F000006060000000F0F0F0F00000606000F0F0F0F0F0F0F0F0606000F0F0F
          0F0F0F000F060600000F0F0F0F0F000006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F000606000F0F0F0F0F00000606000000000F0F0F0F0F06060F0F
          0F000F0F0F0F0F0606000F0F0F0F0F0F0F0F060600000000000F0F000006060F
          0F0F0F0F0F0F0F0F06060F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F000F0F000F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0000060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000000000F0F0F0F
          060600000F0F000F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F060600000000000000000F06060F0F000F00000000000606000F0F0F0F0F0F
          0F0F06060000000F0F0F00000006060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000000000F06060F0F0F0000
          0F0F0F0F060600000000000000000006060F0F0F0F0F0F0F0F0F0606000F0F0F
          0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F000F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F00000F00000F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F000000000F00000606000000000000000F0F06
          060F0F0F0F0F0F0F0F0F06060F0F00000000000F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F
          0F06060F0F0F000F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F000F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0000000F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F000F000006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F00000000000F06060F0000000000000F0F06060000
          000F0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F00000F00000006060F0F0F0F0000000F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F000F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F000F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F00000F000F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F0F0000
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000000F00000006060F0000000F
          0F0F0F0F06060F00000F0F0F00000F060600000F0F0F0F0F0F0F06060F0F0F0F
          000F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F000000000006060F0F
          0F0F0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F000F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          000F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          000F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0006
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F0F0F00
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000000000F
          0F06060F0F00000F0F0F0F0F0606000F000F0F0F0F0000060600000F0F0F0F0F
          0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F00060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F0606000F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F000F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F00000F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0000000F0F0F06060F0F000000000F0F0F06060000000F0F0F0F0F0006
          0600000000000F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F060600000000000000000006060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0404040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C
          0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060000000F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F000F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F00000F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F00000F0F0F0F06060F0F0F0F0F000F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0000000000000F0006060F0F0000000F0F0F0F06060F
          0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F000F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606000F0F00000F0F0000
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F04040404040404040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0404040F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F00000F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F00000F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F000F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000000000F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000000000606000F0F0F00
          000F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F000F00000006060000000F
          000000000F060600000000000000000006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0606000F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F
          00000F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F040F040F0F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606
          0F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0000
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000000
          0006060000000000000F000006060F0F0F0F0F0F0F0F0F06060F0F0F00000000
          0000060600000F0F00000F0F000606000F0000000F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000F000F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F000006060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          040F040F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0000060600000F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F00060600000F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000000060600
          000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F000006060000000F0F0F0F000006060F0F0F0F0F0F0F0F0F06
          060F0F0F000000000000060600000000000F0F0F0F06060F0F0F0F000F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F040F0F0F040F040404040F0F00000000000000020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          020202020202020202020202020202020202020202000F0F0F0F0F0F0F0F0F0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040404040F0F040F0F0F0F0F0F0F0F0F0F0F0F02
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020204020202000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040F0F0F0F04040F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F000F000006060F0F000000000F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000000000606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F060600000F0F0F0F00000F06060F0F0F0F06060F0F0F0F0F0F0F0F00000000
          000F0606000F0F0F0F0F0F00000606000F0F0F0F000F0F0006060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0404
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F040404
          040F0F0404040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F0606000000
          0000000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          00000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F00060600000000000000000F06060F0F0F0F06060F0F0F0F
          0F0F0F0F0F0F0F00000F06060F0F0F0F0F0F0F000F060600000F0F0F0000000F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F0606000F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F040404040F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F000F06060F00000F0000000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F000000000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F000006060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0006060000000000000F0F0F06060F0F
          0F0F06060F0F0F0F0707000000000F0F0F0006060F0F0F0F0F0F0F000006060F
          0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F
          0F0606000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F040404040F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          060600000000000000000F06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F060600000000000F00000F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000000
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F00000000000F0F06060F0F0F0F000F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F00000000
          000F0F0F06060F0F0F0F06060F0F0F0F070F07070F000000000006060F0F0F0F
          0F0F00000006060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F00000F0F0F06060000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F040404040F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F0006060F0F000F0F0F0000000606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F00000F00000F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F000000060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F0606000F0F000F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F00000F0F0F06060F0F0F0F06060F0F0F0F070F0F0F0F0F0000
          000006060F0F0F0F0F0F0000000606000F0F0F0F0F0F00000606000F0F000000
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060000000000000000000606000000
          00000000000006060F0F0F0F0F0F00000F060600000F000F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F04040F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0000000F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F
          0000000000000606000000000F0F0F0F06060000000000000000000606000F0F
          00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F000F0F0F0F0F060600
          000F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F00000F000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F06060F0F0F0F
          070F0F0F0F0F0F0F00000606000F0F0F0F0F0F0000060600000F0F0F0F0F0000
          06060000000F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0006060F0F000000
          0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          040404040F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F00000F0F0F0F0F0F06060000000F0000000F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F000000000F06060F0000000000000006060F0F0F0F0F00
          00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F00
          0F0F0F0F0F06060F0F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0000000000000006060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F
          0F0F06060F0F0F0F0707000F0F0F0F0F0F0F0606000F0F0F0F0F0F0F00060600
          0F0F0F0F000000000606000000000000000006060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F0606000F0F0F0F00000F06060000000000000F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F040404040F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000000000F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F00000000000F0F
          06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000000000606000F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F00060600000000000000000006060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F06060F0F0F0F0F0000000F0F0F0F0F0F0606000F0F0F
          0F0F0F0F0006060F0F0F0F0F000F0F0F06060F0F0F0F0F0F000006060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          000F0F0F0F0F00000006060F00000F0F0F0F0F06060F0F0F0F0F0F0000000606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F040404040F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000000000F06
          060F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F000F0F0F00
          0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F06060F0F0F0F0F0700000F0F0F0F
          0F0F0606000F0F0F0F0F0F0F0006060F0F0F0F0F000F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0000000000000F0F0606000F000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0404
          04040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0000060600000F0000000F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F00000000000006060F0F0F0F000000000006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0000000606
          0F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F06060F0F0F0F
          0F0000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F00000F0F0F
          06060F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000000F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0404040F0F0F0F0F0F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000000F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F00
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F000F0006060F0F00000000000006060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F
          0F0F0F0F0F060600000F0F0F0F0F0F0F060600000F0F0F0F0F0F06060F0F0000
          0F0F0F000006060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F00000F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F06060F0F0F0F0F0F000000000F0F0F0F06060F0F0F0F0F0F0F0F00060600
          0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000000
          0006060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F040F0F0F040F0404040404040F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F00000000000006060F0F0F0F0F00000000
          0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          000006060F0F0F0F0F0F00000006060F000F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F060600000F0F0F0F000F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F000000000F06060F0F0F0F0F0F0F0F0F0606000F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F06060F0F0F0F0F0F000000000000000006060F0F0F0F
          0F0F0F0F0F06060000000F0F0000000F06060F0F0F0F0F0F0F0F06060F00000F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F040F0F0F040F040F0F0F040F
          0000000000000002020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F04040404
          0F0F0F040F0F040F0F0F0F0F0F0F0F0202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          02020202020202020204020202000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F040F0F0F0F0F0F0F040F040F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F00000F0F0F0F0F060600000F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F00
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00
          0F0F000F0F06060F00000F0F0F0F0F0F06060F000F0F0F000F0F06060F0F0F0F
          0F0F0F0F000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F00
          000000000F0F06060F0F0F0F0F0F0F0F0F06060000000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F0F
          0F0F0F00000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F00000F0F0F0F0F06060F
          0F0F0F00000F0F0F060600000F0F0F0F0F0F0606000F0F0F0F0F0F0F00060600
          000000000F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000
          0006060F0F0F0F0F0F0F0F000F0F040404040F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F04040F0F040F0F0F0F04040F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0000000F0F000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0000000000000F0F0606000F0F0F0F0F0F0F0F060600000000000F
          0F0F06060F0F0F0F0F0F0F000F06060F00000000000F0F0F06060F0F0F0F0F0F
          0F0F0F06060F00000000000F0F0F06060F0F0F0F0F0F0F0F0F06060000000000
          000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000000
          000F0F0F06060F0F0F0F0F0000000F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F00
          0F0F0F0F0F06060F0F0F0F0F0000000F06060F000F0F0F0F0F0F06060F0F0F0F
          0F0F0F000F06060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F0606000F0000000F000004040404040400000F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600
          00000F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0000000F0000000F0606000000000F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F060600000F0F0F0F00000006060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F000F0F06060F0F0F0F0F0F0F000F0606000F0F0F0F0F000F0F
          06060F0F0F0F0F0F0F0F0F06060000000000000F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F00000000000606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F0606000000000000000000060600000F000000000F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F060600000000000F0F0F0F06060F0F0F0F0F000000000606000F0F0F0F0F
          0F0F0606000F0F0F0F0F00000F06060F0F0000000000000006060F0F00000F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0404040404040F0F
          0F0F0F0000000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F00000000000F0606000000000F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000000000000000006060000
          00000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000000060600
          000F0F0F0F0F0F0F06060F0F0F0F0F00000F06060F0F0F0F0F0F0F000006060F
          0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000606000000000F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0006060000000000000F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0000000F000F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F00000F0F00060600000F0F0F0F000000
          060600000F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00000606000F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F
          0404040F00000F0F0F0000000F000F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F00
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F00000F0F0F0F0F06060F0F0F0F0F0F0F0006060F0F0F0F
          0F0F0F0F0F06060F0F0F0000000F0F0F06060F0F0F0F0F0F0F0F0F0606000000
          000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F00
          00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000000000F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F00000000000F06060F
          0F0F0F0F0F0F0F0F06060F0F0F000F0F00000006060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606
          0F00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0404040404040400000F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000000000F0F
          000606000F0F0F0F0F0F0F0F060600000000000F0F00000606000F0F0F0F0F0F
          0F0F06060F0F000000000F0F0F06060F0F0F000F0F0F0F0F06060F0F00000F0F
          0F0006060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F0606000000000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F00
          000000000F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F000000000F0F0606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F0606000F0F00000F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0000040404040404040F0F0F000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006
          060F0F0F0F0F00000F060600000F0F000000000006060F0F0F0F0F00000F0F06
          060F00000F0F0F0F0F0F06060F0F000F0F0F000F0F06060F0F000F0F0F0F0F0F
          06060F000F0F0F0F000F06060F0F0F0F0F0F0F0F000606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F0606000000000000000F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F000000060600000F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F000000000006060F00000F0F0F0F000006060F0F0F0F0F0F
          0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F00000000
          000F0F06060F000000000F0F0F0F0606000F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0000000F0F0F0F06060F000F0F000F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000F0F0F0F0F0F04
          04040F0F0F000F0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F000000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F000F0F0F0606000000
          0000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0000000000000006060000000000000000060600000000000F0F0F0006060F0F
          0F0F0F000000000606000F00000F0F0F0F0F06060000000F0F0F00000006060F
          0F00000F0F0F0F0F06060F0F0F0F0F0F000F06060F0F0F0F0F0F00000F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000000000F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F0606
          0F000000000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0000000000000606000F00000000000000
          060600000F0F0F0F0F0006060F0F0F0F0F0F0F0F0F06060F000000000F0F0F0F
          06060F0000000F0F0F0F0F06060000000F0F0000000006060F00000000000000
          0606000F0F0F0F0F0F0F0F060600000F0F00000F0F0F06060F00000000000000
          0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F
          0F0F0F040404040404040F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F00
          0F0F0006060F0F0F0F0F00000F0F060600000F0F0F0F0F0F0F06060F0F00000F
          0F0F0F0F060600000F0F0F0F00000006060F0F0F0F0F0F0F0F06060000000000
          0000000F06060F0F0F0F00000F0F0F06060F00000F0F0F0F0F0006060F0F0F0F
          0F0F0F0000060600000F0F0F0F0F0F0F06060F0F000000000F0F06060F0F0F0F
          0F0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F
          0F0000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F00000F00060600
          00000000000F0F0F06060F0F000F0F0F0F0006060F0F0F0F0F00000000060600
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F0606
          000F0F0F0F0F0F0F06060F000F0F0F0F0F0F0006060F0F00000F0F0F0F0F0606
          000F0F00000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00
          0006060F0F0F0F0F0F0F0F0606000F0F0F000F0F0F0F06060F0F0F0F0F000000
          0006060F0F0F0F0F040404040404040F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F00
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00
          06060F000000000000000F06060F0F0F0F0F0F0F000006060000000000000F00
          000606000F000F000000000006060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F000606000F0F0F0F0F0000000606000F0F0F0F0F00
          000F06060F0F0F0F0F0F0000000606000000000000000000060600000F0F0F0F
          0F0F06060F0F0F0F0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F0606000000000000000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F0F0F0F060600000F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F00000F0006060F0F000000000000060600000000
          00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F00060600000000000000000F06060F000F
          0F0F0F0F0F0F0606000F000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F00000F0F0606000000000000000006060000000F0F000000000606
          00000000000F0F0F0F06060F0F0F0F0F0404040F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F0F0F04040404040F
          0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F0F0F0F0F0F0F00000606
          000000000000000F0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F00000F0F0F000F0F06060F000F0F0F0F0F0F0F06060F0F0F0F0F0F00000006
          0600000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F06
          060F0F0F0F0F00000F0F06060F0F0F0000000F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0000000F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F00060600000F0000000F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000000000000
          000606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000006060000000F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F00000F0F0006060F0F0F0F0F0F
          0F0F0F06060F00000F0F0F0F0F0F0606000F000F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040404040F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F040F
          0F0F0F040F0F0F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000000000606000000
          000000000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F000000000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F
          0F0F0F0F0F0F0F06060F0F0F0F000F0F0F0F06060F00000F0F0F00000006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000000000F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0000000000000F06060F0000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0000
          06060000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606000F000000000F0F
          06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F0F0606000F000F0F0F0F0F
          0006060F0F0F0F0F0F0F000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F00000000000006060000000000000F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00000606000000000F
          0F0F0F0404040404040F0F0F0F000F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F040F0F0F0F0F04040F0F0F0F0F0F0F0F0F06000F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00
          0000000006060F0000000000000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          00000F0F06060F0F0F0F000000000F06060F0F0F000F0F0F0F0F06060F00000F
          0F0F00000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F000006060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0000000606000000
          00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F000000000000000606000000000F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000000606
          0F0F000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000F0F0F0F0F0F0606
          0F00000F0F0000000006060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F000F0F0606000F0F00000000000006060000000F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060000000F0F0F0F0F0F0F0F040404040F0F0F000F0F0F0F0F0F0F0F0F0C
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F04040F0000000000000002
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020204020202000F0F
          0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F0F040F
          0F0F0F0F0F0F0F02020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202020202020202020202020202020202020202020202020202020202
          0202020202000F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F04
          040F040F0F0F040F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000F0F0F0F0F0F0F06060F0F
          0F00000000000006060F00000F0F00000F06060000000000000F0F0F06060F0F
          00000F0F00000F06060F0F0F0F0F0F0F00000606000000000F0F00000006060F
          0F0F0000000F000006060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F00000000000006060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F000606000000000F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F000F0F0F
          0F06060F000F00000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000000606000F0F0F0F0F0F
          0F000606000F0F0F0F0F0F0F000606000000000F0F0F0F0F06060F0F00000000
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F04040404040F0F0404040F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F
          0F0F0F0F06060F0F0F0F0F0000000F06060F0F0F0F0F0F0F0F06060F0F0F0F00
          0F0F0F0F06060F0000000000000000060600000F0F0F0F0F0F0006060F0F0F0F
          000000000F06060000000F00000000000606000F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F000F0F00000606000000000000000F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          00000F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0006
          06000000000F0F000000060600000000000000000006060F0F0F0F0000000000
          060600000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000000000F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F00000F0F0F0F0F060600000000000F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000000000000
          000F06060F0F000000000F0F0F06060F0000000F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0000
          000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F000F06060F0F000000
          0000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060000000F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0000000F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F00000000000F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F06060F
          0F0F00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F000000000006060F0F0F0F0F0F0F0F0F06
          06000000000000000F060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060000000F0F0F000000060600000F0F0F0F0000000606000F0F0F00000F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0000000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F000F0F0F0F0F060600000F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F000000000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000000000006060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F060600000000000000000006060F0F0F0F0F000000000606000F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0000000006060000000F0F00000006060F0F00000F0F0F0F0F0606000F
          0000000000000F0606000F00000F000F0F0F060600000000000000000006060F
          0F0F0F0F0F000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0000000000000006060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000000000000F
          06060F0F000000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F00000F0F06060F0F0F0F000000000006060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F00000F0006060F0F0F0F0F0F0F00000606000000000000
          000000060600000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0404040F0F0F0F0404040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0000000006060F0F0F0F000000000F060600000000000F000F06060000000F0F
          0F0F0F0F060600000000000F0F000F06060F000F0F0F000F0F000606000F0F0F
          0F0F0F0F0F06060000000000000F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F000000000606000000000F0F0F000006060000000F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000000000006060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F00060600000F00000000000006060000000F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060000000000000000060600000F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F000F0F0606000F00000000000000
          0606000F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0404040F0F0404040F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F00000000060600000000000000000006060F0F0F0F0F0000
          0006060F0F0F0F0F0000000F0606000F0000000000000F060600000000000000
          00000606000000000000000000060600000000000000000006060F0F0F0F0F0F
          0F0F06060F0F0F0F000000000006060000000F0000000F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00000000
          00000F0006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F000F0F0F00000006060F0F0F
          00000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0606000F0000000000000006060F0F
          0F0F0F0F000000060600000F000F0000000F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          000F0F0F00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0404040404040F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F000F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F0F0F0F0F0F0006
          06000000000F0F0F0F0F06060F000000000F0F0F0F06060F0F0F00000000000F
          06060F0F0F0F0F0F0F0F060600000000000000000006060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0000000000000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F00000000000F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F060600000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0006060F0F0F0F0F0F0F0F0606000F0F0F0F
          0F0F0F0006060F0F0F0F00000000000606000F000F000F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F04040F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F00
          000000000F0F0F06060F00000000000F0F06060F0F0F0F00000F0F0F06060F0F
          0F0F0F0F0F0F0F0606000000000F0F0F0F0F06060F0F0000000F000000060600
          0F0F0F000000000006060F0F0F0F0F0F0F0F060600000000000000000006060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0000000000000006060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F000000000000000F0F000F0F0F06060F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0606000000000000000F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0404040404040F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000000000F06060F0F0F0F0F
          000000000606000000000F0F0F0000060600000F0F0F000000000606000F0F0F
          000000000006060F000F0F0F0F0F0F0F060600000000000F0F00060600000F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000000F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0000000000000000000F00
          0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000006060000000000000F0F0006
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0404040F0F0404040F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000000000F
          0F06060F0F0F0F000000000F06060F0000000F0F00000006060F0F0F0F000000
          000F06060F000000000000000006060000000F0F0F0F0F0F06060F0F0000000F
          0F0F06060000000000000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0000
          00000F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F00000F00
          000000000F00000F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0000000000000006060F0F
          0F0F0F000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0404040F0F0F0F0404040F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0000000000000606000F0F0F0F0F0F0F0F06
          060F000000000000000006060F0F000F0F000000000606000F00000F0F0F0F0F
          06060000000000000F0F06060F0F0F0F0F000000000606000F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0000000F000F00000000000F0F0F06060F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F000000060600000F0F0F
          00000F00060600000000000F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F040F0F0F0F0F0F0F
          0F040F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0000000F0F06060000000F0F0F0F0F0F06060F0F0F0F0000000000060600
          00000000000F0F0F06060F0F0F0F0F00000006060F0F0F0F0F0F0F0F0F06060F
          00000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0000000006060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F00000000000000000F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F00
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000000000000
          0006060F0F0000000000000F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F00000F0F0F06060000000F0F0F0F0F0F060600000000
          0F0F00000006060F000000000000000006060F0F0F0F0F0F0F0F060600000000
          0F0F0F00000606000000000F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F000000000006060000
          000F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F06060F0F0F00000000000006060000000000000F00000606
          0F0F00000000000006060000000F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0000000000000006060000000F000F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F000000000F0F
          0000060600000000000000000F06060000000F000000000006060000000F0F0F
          0F0F06060F000000000000000006060000000000000F000006060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060000000F0F
          0F0000000606000000000000000F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0000000000000606000000
          0000000F0F0F06060000000000000000060600000000000000000006060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0000000F0F0F0F06060F0F
          0F0F0F0F0F0F0F0606000F0F000000000006060000000F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0404040F0F0F0F0F0F040F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F000000000000000606000000000000000F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F000000000006060000000F0F00000F00
          06060F00000000000F0F0F0606000F0F0F0F0000000F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F00000F0F06060F0F0F000000000F
          0F06060F000000000000000006060F0F0F0F0F0F0F000006060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0000000000000006060F0F0F0F0000
          00000006060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F060600000F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F040F0F0F04
          0F0404040404040F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606000000000000000F0F060600
          0000000F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          00000000000000000606000000000000000000060600000000000000000F0606
          000000000000000F0006060F0F0F0F0F0F0F0F06060F0F0F0F00000000000606
          00000000000000000006060000000000000F0F0F060600000000000000000F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0000
          06060F0F0F0F00000F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F040F0F0F040F040F0F0F040F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0000000606000000000F0F0F0F0F06060000000F0F0F0F0F06060F0F0F0F
          0F0000000F06060F0F00000000000F0F06060F0F0F0F0F0F00000006060F0F0F
          0F0000000000060600000000000000000006060000000F00000F0F060600000F
          000F0F0F0F0F06060F0F0F0F0F0F000000060600000000000F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0404040F0F0F040F0F040F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F00000000000606000000000000
          00000606000000000000000F00060600000F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F000000000000000006060000000000
          00000006060000000000000000000606000000000000000000060600000F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F040F0F0F040F0F0F040F040F00
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F000F000F060600000000000000000006060000000000000F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F040F0F0F04
          0F0F0F0F04040F00000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0404040F0F0F0F0F0F040F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F
          0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F
          0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F
          0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F
          0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F
          0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F0606
          0F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06
          060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F
          06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F0F06060F0F0F0F0F0F0F0F
          0F06060F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F
          040F0F0F0F040F0F0F0404040F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F0F
          040F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F040F0F0F0F0F040F0F0F04
          0F0F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F0F040F0F
          040F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0404040F0F0F0F0F0F040F
          0F040F0F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F040F
          0F040F0F0F0F0F0F0F040F040F0F0F0F0F0F0F0F040F0F040F0F0F0F0F0F0F04
          0F0F040F0F0F0F0F0404040F0F040F0F0F0F0404040F0F0F0F040F0F0F040404
          0F0F0404040F0F0F0404040F0F040F0F0F0F0F0404040F0F0F040F0F0F0F0404
          040F0F040F0F0F0F0F0404040F0F040F0F0F0F0F0404040F040F0F0F0F0F0404
          040F0F0F040F0F0F0F0404040F0F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F
          040F0F0F0F040F0F0F0F0F040F0F0404040F0F0F0F0F040F0F0F040F0F0F0F0F
          040F0F0F0F0F040F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F0F040F0F0F0F
          0F040F0F040F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F040F0F0F0F
          0F0F0F040F0F040F0F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0404040F0F
          0F0F0F040F0F040F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F040F0F0F
          0F0F0F0F040F0F040F0F0F0F0F0F0F040F040F0F0F0F0F0F0F040F0F0F040F0F
          0F0F0F0F040F0F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F0F040F
          0F0F0F0F040F0F0404040F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F0F04
          0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F040F0F
          0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F04
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0404040F0F0F0F040F0F0F0404040F0F0404040F0F0F0404040F0404040F0F
          0F0F0404040F0F0F040F0F0F0F0404040F0404040F0F0F0F0404040F0404040F
          0F0F0404040F0F040F0F0F0F0F0404040F0F0404040F0F0F0404040F0404040F
          0F0F0F0F0F040F0404040F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F040404
          0F0F0F0F0F0F040F0404040F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0404
          040F0F0F0F0F040F0404040F0F0F0F0F0F040F040F0F0F0F0F0F0F0F040F0404
          040F0F0F0F0F0F040F0404040F0F0F0F0404040F0404040F0F0F0404040F0F0F
          0F040F0F0F0404040F0F0404040F0F0F0404040F0404040F0F0F0F0404040F0F
          0F040F0F0F0F0404040F0404040F0F0F0F0404040F0404040F0F0F0F0404040F
          040F0F0F0F0F0404040F0F0404040F0F0F0404040F0F0404040F0F0F0404040F
          0404040F0F0F0F0404040F0F0F040F0F0F0F0404040F0404040F0F0F0F040404
          0F0404040F0F0F0404040F0F0F0F040F0F0F0404040F0F0404040F0F0F040404
          0F0F0404040F0F0F0404040F040F0F0F0F0F0F0404040F0404040F0F0F0F0404
          040F0404040F0F0F0F0F0F040F0404040F0F0F0F0F040F0F0F0F040F0F0F0F0F
          040F0F0404040F0F0F0F0F040F0404040F0F0F0F0F0F040F0F0F040F0F0F0F0F
          0F040F0404040F0F0F0F0F0F040F0404040F0F0F0F0F0F040F040F0F0F0F0F0F
          0F040F0F0404040F0F0F0F0F040F0F0404040F0F0F0404040F0404040F0F0F0F
          0404040F0F0F040F0F0F0F0404040F0404040F0F0F0F0404040F0404040F0F0F
          0F0404040F0F0F040F0F0F0404040F0F0404040F0F0F0404040F0F0404040F0F
          0F0404040F040F0F0F0F0F0F0404040F0404040F0F0F0F0404040F0404040F0F
          0F0F0404040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F040F0F0F0F040F0F0F040F040F0F04040F0F0F0F04
          0F040F040F040F0F0F0F040F040F040404040F0F0F040F040F040F040F0F0F0F
          040F040F040F040F0F0F040F040F0F040F0F0F0F0F040F040F0F040F040F0F0F
          040F040F040F040F0F0F0F0F0F040F040F040F0F0F0F0F0F040F0F0F040F0F0F
          0F0F0F040F04040F0F0F0F0F0F0F040F040F040F0F0F0F0F040F0F040404040F
          0F0F0F040F0F040F040F0F0F0F0F040F040F040F0F0F0F0F0F040F040F0F0F0F
          0F0F0F0F040F040F040F0F0F0F0F0F040F040F040F0F0F0F04040F0F040F040F
          0F0F04040F0F0F0F0F040F0F0F04040F0F0F04040F0F0F0F04040F0F040F040F
          0F0F0F04040F0F040404040F0F0F04040F0F040F040F0F0F0F04040F0F040F04
          0F0F0F0F04040F0F040F0F0F0F0F04040F0F0F040F040F0F0F04040F0F0F040F
          040F0F0F040F040F040F040F0F0F0F040F040F0F0F040F0F0F0F040F040F0404
          0F0F0F0F0F040F040F040F040F0F0F040F040F0F040404040F0F040F040F0F04
          0F040F0F0F040F040F0F040F040F0F0F040F040F040F0F0F0F0F0F040F040F04
          0F040F0F0F0F040F040F040F040F0F0F0F04040404040F040F0F0F040404040F
          0F0F040F0F0F040404040F04040F0F0F0F04040404040F040F0F0F0F04040404
          040404040F0F0F04040404040F040F0F0F0F04040404040F040F0F0F0F040404
          04040F0F0F0F0F040404040F040F040F0F0F040404040F040F040F0F0F040F04
          0F040F040F0F0F0F040F040F0F0F040F0F0F0F040F040F04040F0F0F0F0F040F
          040F040F040F0F0F0F040F040F040404040F0F040F040F0F040F040F0F0F040F
          040F0F040F040F0F0F040F040F040F0F0F0F0F0F040F040F040F040F0F0F0F04
          0F040F040F040F0F0F0F040F040F040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F040F0F0F0F040F0F0F040F040F
          0F0F040F0F0F0F040F040F040F040F0F0F0F040F040F040404040F0F0F040F04
          0F040F040F0F0F0F040F040F040F040F0F0F040F040F0F040F0F0F0F0F040F04
          0F0F040F040F0F0F040F040F0F0F040F0F0F0F0F0F040F040F040F0F0F0F0F0F
          040F0F0F040F0F0F0F0F0F040F0F040F0F0F0F0F0F0F040F040F040F0F0F0F0F
          040F0F040404040F0F0F0F040F0F040F040F0F0F0F0F040F040F040F0F0F0F0F
          0F040F040F0F0F0F0F0F0F0F040F040F040F0F0F0F0F0F040F0F0F040F0F0F0F
          0F040F0F040F040F0F0F0F040F0F0F0F0F040F0F0F0F040F0F0F0F040F0F0F0F
          0F040F0F040F040F0F0F0F0F040F0F040404040F0F0F0F040F0F040F040F0F0F
          0F0F040F0F040F040F0F0F0F0F040F0F040F0F0F0F0F0F040F0F0F040F040F0F
          0F0F040F0F0F0F0F040F0F0F040F040F040F040F0F0F0F040F040F0F0F040F0F
          0F0F040F040F0F040F0F0F0F0F040F040F040F040F0F0F040F040F0F04040404
          0F0F040F040F0F040F040F0F0F040F040F0F040F040F0F0F040F040F040F0F0F
          0F0F0F040F040F040F040F0F0F0F040F040F0F0F040F0F0F0F04040404040F04
          0F0F0F040404040F0F0F040F0F0F040404040F0F040F0F0F0F04040404040F04
          0F0F0F0F04040404040404040F0F0F04040404040F040F0F0F0F04040404040F
          040F0F0F0F04040404040F0F0F0F0F040404040F040F040F0F0F040404040F0F
          0F040F0F0F040F040F040F040F0F0F0F040F040F0F0F040F0F0F0F040F040F0F
          040F0F0F0F0F040F040F040F040F0F0F0F040F040F040404040F0F040F040F0F
          040F040F0F0F040F040F0F040F040F0F0F040F040F040F0F0F0F0F0F040F040F
          040F040F0F0F0F040F040F0F0F040F0F0F0F040F040F040F040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F040F0F0F0F
          040F0F0F040F040F0F0F040F0F0F0F040F040F0F0F040F0F0F0F040F040F040F
          040F0F0F0F040F040F0F0F040F0F0F0F040F040F040F040F0F0F040F040F0F04
          0F0F0F0F0F040F040F0F040F040F0F0F040F040F0F04040F0F0F0F0F0F040F04
          0F040F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F040F0F0F0F0F0F0F040F
          0F0F040F0F0F0F0F040F0F040F040F0F0F0F0F040F0F0F0F040F0F0F0F0F040F
          040F040F0F0F0F0F0F040F040F0F0F0F0F0F0F0F040F040F040F0F0F0F0F0F04
          0F0F04040F0F0F0F0F040F0F040F040F0F0F0F040F0F0F0F0F040F0F0F0F040F
          0F0F0F040F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F040F040F0F0F0F0F04
          0F0F0F0F040F0F0F0F0F040F0F040F040F0F0F0F0F040F0F040F0F0F0F0F0F04
          0F0F0F040F040F0F0F0F040F0F0F0F04040F0F0F0F0F040F040F040F0F0F0F0F
          0F040F0F0F040F0F0F0F0F0F040F0F040F0F0F0F0F0F0F040F0F0F040F0F0F0F
          0F040F0F040F040F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F040F040F0F0F
          0F0F040F040F0F0F0F0F0F0F0F040F040F040F0F0F0F0F0F040F0F04040F0F0F
          0F040F040F040F040F0F0F040F040F0F0F0F040F0F0F040F040F0F0F040F0F0F
          0F040F040F0F0F040F0F0F0F040F040F040F040F0F0F0F040F040F0F0F040F0F
          0F0F040F040F040F040F0F0F0F040F040F040F0F0F0F0F040F040F0F040F040F
          0F0F040F040F0F0F04040F0F0F0F0F040F040F040F0F0F0F0F0F040F0F0F040F
          0F0F0F0F0F040F0F040F0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F040F04
          0F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F040F040F0F0F0F0F040F040F0F
          0F0F0F0F0F0F040F040F040F0F0F0F0F0F040F0F04040F0F0F0F040F040F040F
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F040F040F0F0F0F040F0F0F040F040F0F0F04040F0F0F040F040F0F0F040F0F
          0F0F040F040F040F040F0F0F0F040F040F040F040F0F0F0F040F040F040F040F
          0F0F040F040F0F0F040F0F0F0F040F040F0F0404040F0F0F040F040F0404040F
          0F0F0F0F0F040F040F040F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0404
          0F0F0F0F0F0F040F0F0F040F0F0F0F0F040F0F040F040F0F0F0F0F040F0F040F
          040F0F0F0F0F040F040F040F0F0F0F0F0F040F0F040F0F0F0F0F0F0F040F0404
          040F0F0F0F0F0F040F0404040F0F0F0F0F04040F040F040F0F0F0F04040F0F0F
          0F040F0F0F0F04040F0F0F04040F0F0F0F04040F0F0F040F0F0F0F0F04040F04
          0F040F0F0F0F0F04040F040F040F0F0F0F0F04040F040F040F0F0F0F0F04040F
          0F040F0F0F0F0F04040F0F0404040F0F0F0F04040F0F0404040F0F0F0F0F040F
          040F040F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F04040F0F0F0F0F0F04
          0F0F0F040F0F0F0F0F040F0F040F040F0F0F0F0F040F0F040F040F0F0F0F0F04
          0F0F040F040F0F0F0F0F040F0F040F0F0F0F0F0F0F040F0404040F0F0F0F0F0F
          040F0404040F0F0F0F040F040F040F040F0F0F040F040F0F0F0F040F0F0F040F
          040F0F0F04040F0F0F040F040F0F0F040F0F0F0F040F040F040F040F0F0F0F04
          0F040F040F040F0F0F0F040F040F040F040F0F0F0F040F040F0F040F0F0F0F04
          0F040F0F0404040F0F0F040F040F0F0404040F0F0F040F040F040F040F0F0F0F
          040F040F0F0F040F0F0F0F040F040F0F04040F0F0F0F040F040F0F0F040F0F0F
          0F040F040F040F040F0F0F040F040F0F040F040F0F0F040F040F0F040F040F0F
          0F040F040F0F040F0F0F0F0F040F040F0404040F0F0F0F040F040F0404040F0F
          0F0F040F040F040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F040F040F0F0F0F040F0F0F040F040F0F0F0F040F0F0F04
          0F040F0F04040F0F0F0F040F040F0F04040F0F0F0F040F040F0404040F0F0F0F
          040F040F0404040F0F0F040F040F0F0F040F0F0F0F040F040F0F0F040F0F0F0F
          040F040F040F040F0F0F0F0F0F040F040F040F0F0F0F0F0F040F0F0F040F0F0F
          0F0F0F040F0F0F040F0F0F0F0F0F040F0F04040F0F0F0F0F040F0F0F04040F0F
          0F0F0F040F0F0404040F0F0F0F0F040F0404040F0F0F0F0F0F040F0F040F0F0F
          0F0F0F0F040F0F040F0F0F0F0F0F0F040F040F040F0F0F0F0F0F040F040F040F
          0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F04040F
          0F0F0F0F0F040F0F04040F0F0F0F0F0F040F0404040F0F0F0F0F0F040F040404
          0F0F0F0F0F0F040F0F040F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F040F
          040F0F0F0F04040F040F040F0F0F0F0F04040F0F0F040F0F0F0F0F04040F0F0F
          040F0F0F0F0F04040F0F04040F0F0F0F04040F0F0F04040F0F0F0F04040F0F04
          04040F0F0F0F04040F0F0404040F0F0F0F04040F0F040F0F0F0F0F0F04040F0F
          040F0F0F0F0F0F04040F040F040F0F0F0F0F04040F040F040F0F0F0F04040F0F
          0F0F040F0F0F0F04040F0F0F0F040F0F0F0F04040F0F04040F0F0F0F0F04040F
          0F04040F0F0F0F0F04040F0404040F0F0F0F0F04040F0404040F0F0F0F0F0404
          0F0F040F0F0F0F0F04040F0F0F040F0F0F0F0F04040F0F040F040F0F0F040404
          0F040F040F0F0F0F0404040F0F0F040F0F0F0F0404040F0F0F040F0F0F0F0404
          040F0F04040F0F0F0F0404040F0F04040F0F0F0404040F0F0404040F0F0F0404
          040F0F0404040F0F0F0404040F0F040F0F0F0F0F0404040F0F040F0F0F0F0F04
          04040F040F040F0F0F0F0404040F040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F040F0F0F0F040F0F0F040F040F
          0F0F0F040F0F0F040F040F0F04040F0F0F0F040F040F0F04040F0F0F0F040F04
          0F04040F0F0F0F0F040F040F04040F0F0F0F040F040F0F0F040F0F0F0F040F04
          0F0F040F040F0F0F040F040F040F040F0F0F0F0F0F040F040F040F0F0F0F0F0F
          040F0F0F040F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F04040F0F0F0F0F
          040F0F0F04040F0F0F0F0F040F0F04040F0F0F0F0F0F040F04040F0F0F0F0F0F
          0F040F0F040F0F0F0F0F0F0F040F040F040F0F0F0F0F0F040F040F040F0F0F0F
          0F0F040F040F040F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F0F040F0F0F
          0F0F040F0F04040F0F0F0F0F0F040F0F04040F0F0F0F0F0F040F04040F0F0F0F
          0F0F0F040F04040F0F0F0F0F0F0F040F0F040F0F0F0F0F0F040F0F040F040F0F
          0F0F0F040F0F040F040F0F0F0F04040F040F040F0F0F0F0F04040F0F0F040F0F
          0F0F0F04040F0F0F040F0F0F0F0F04040F0F04040F0F0F0F04040F0F0F04040F
          0F0F0F04040F0F04040F0F0F0F0F04040F0F04040F0F0F0F0F04040F0F040F0F
          0F0F0F0F04040F040F040F0F0F0F0F04040F040F040F0F0F0F0F04040F040F04
          0F0F0F0F04040F0F0F0F040F0F0F0F04040F0F0F0F040F0F0F0F04040F0F0404
          0F0F0F0F0F04040F0F04040F0F0F0F0F04040F04040F0F0F0F0F0F04040F0404
          0F0F0F0F0F0F04040F0F040F0F0F0F0F04040F0F040F040F0F0F0F04040F0F04
          0F040F0F0F04040F0F040F040F0F0F0F04040F0F0F0F040F0F0F0F04040F0F0F
          0F040F0F0F0F04040F0F0F04040F0F0F0F04040F0F0F04040F0F0F04040F0F0F
          04040F0F0F0F04040F0F0F04040F0F0F0F04040F0F0F040F0F0F0F0F04040F0F
          040F040F0F0F0F04040F0F040F040F0F0F0F04040F0F040F040F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F040F0F0F04
          040F0F0F040F040F0F040F040F0F0F040F040F0F0F040F0F0F0F040F040F0F04
          040F0F0F0F040F040F040F0F0F0F0F0F040F040F040F0F0F0F0F040F040F0F0F
          040F0F0F0F040F040F0F040F040F0F0F040F040F040F040F0F0F0F0F04040F04
          0F040F0F0F0F0F04040F0F04040F0F0F0F0F04040F040F040F0F0F0F0F04040F
          0F0F040F0F0F0F04040F0F0F04040F0F0F0F04040F0F040F0F0F0F0F0F04040F
          040F0F0F0F0F0F0F04040F0F040F0F0F0F0F0F04040F040F040F0F0F0F0F0404
          0F040F040F0F0F0F040F040F040F040F0F0F040F040F0F0F04040F0F0F040F04
          0F0F040F040F0F0F040F040F0F0F040F0F0F0F040F040F0F04040F0F0F0F040F
          040F040F0F0F0F0F0F040F040F040F0F0F0F0F0F040F040F0F040F0F0F0F040F
          040F0F040F040F0F0F040F040F0F040F040F0F0F0F0F040F040F040F0F0F0F0F
          0F040F0F04040F0F0F0F0F0F040F040F040F0F0F0F0F0F040F0F0F040F0F0F0F
          0F040F0F0F04040F0F0F0F0F040F0F040F0F0F0F0F0F0F040F0F040F0F0F0F0F
          0F0F040F0F040F0F0F0F0F0F0F040F040F040F0F0F0F0F0F040F040F040F0F0F
          0F0F04040F040F040F0F0F0F04040F0F0F04040F0F0F0F04040F0F040F040F0F
          0F0F04040F0F0F040F0F0F0F0F04040F0F04040F0F0F0F0F04040F040F0F0F0F
          0F0F0F04040F040F0F0F0F0F0F0F04040F0F040F0F0F0F0F04040F0F040F040F
          0F0F0F04040F0F040F040F0F0F040F0F0F040F040F0F0F0F040F0F0F0F04040F
          0F0F0F040F0F0F040F040F0F0F0F040F0F0F0F0F040F0F0F0F040F0F0F0F0404
          0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F0F040F
          0F0F0F0F040F0F0F040F040F0F0F0F040F0F0F040F040F0F0F0F040F0F0F040F
          040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F040F040F0F0F04040F0F0F040F040F0F040F040F0F0F040F040F040F040F0F
          0F0F040F040F0F04040F0F0F0F040F040F0F040F0F0F0F0F040F040F040F040F
          0F0F040F040F0F0F0F040F0F0F040F040F0F040F040F0F0F040F040F040F040F
          0F0F0F0F04040F040F040F0F0F0F0F04040F0F04040F0F0F0F0F04040F040F04
          0F0F0F0F0F04040F040F040F0F0F0F04040F0F0F04040F0F0F0F04040F0F0F04
          0F0F0F0F0F04040F040F040F0F0F0F0F04040F0F0F040F0F0F0F0F04040F040F
          040F0F0F0F0F04040F040F040F0F0F0F040F040F040F040F0F0F040F040F0F0F
          04040F0F0F040F040F0F040F040F0F0F040F040F040F040F0F0F0F040F040F0F
          04040F0F0F0F040F040F0F040F0F0F0F0F040F040F040F040F0F0F0F040F040F
          0F0F040F0F0F040F040F0F040F040F0F0F040F040F0F040F040F0F0F040F040F
          040F040F0F0F0F040F040F0F04040F0F0F0F040F040F040F040F0F0F0F040F04
          0F040F040F0F0F040F040F0F0F04040F0F0F040F040F0F0F040F0F0F0F040F04
          0F0F040F040F0F0F040F040F0F0F040F0F0F0F040F040F040F040F0F0F0F040F
          040F040F040F0F0F0F0F04040F040F040F0F0F0F04040F0F0F04040F0F0F0F04
          040F0F040F040F0F0F0F04040F040F040F0F0F0F0F04040F0F04040F0F0F0F0F
          04040F0F040F0F0F0F0F0F04040F040F040F0F0F0F0F04040F0F0F040F0F0F0F
          04040F0F040F040F0F0F0F04040F0F040F040F0F0F0F040F0F040F040F0F0F0F
          0F040F0F0F04040F0F0F0F0F040F0F040F040F0F0F0F0F040F0F040F040F0F0F
          0F0F040F0F0F04040F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F040F040F0F
          0F0F040F0F0F0F040F0F0F0F0F040F0F040F040F0F0F0F0F040F0F040F040F0F
          0F0F040F040F040F040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0404040F0F0F0F040F0F0F0404040F0F0404040F0F0F04
          04040F0404040F0F0F0F0404040F0F0F040F0F0F0F0404040F0F04040F0F0F0F
          0404040F0404040F0F0F0404040F0F0404040F0F0F0404040F0F0404040F0F0F
          0404040F0404040F0F0F0F0F0F040F0404040F0F0F0F0F0F040F0F0F040F0F0F
          0F0F0F040F0404040F0F0F0F0F0F040F0404040F0F0F0F0F040F0F0F0F040F0F
          0F0F0F040F0F0F04040F0F0F0F0F040F0404040F0F0F0F0F0F040F0404040F0F
          0F0F0F0F040F0404040F0F0F0F0F0F040F0404040F0F0F0F0404040F0404040F
          0F0F0404040F0F0F0F040F0F0F0404040F0F0404040F0F0F0404040F0404040F
          0F0F0F0404040F0F0F040F0F0F0F0404040F0F04040F0F0F0F0404040F040404
          0F0F0F0F0404040F0404040F0F0F0404040F0F0404040F0F0F0404040F0F0404
          040F0F0F0404040F0404040F0F0F0F0404040F0F0F040F0F0F0F0404040F0404
          040F0F0F0F0404040F0404040F0F0F0404040F0F0F0F040F0F0F0404040F0F0F
          04040F0F0F0404040F0F0404040F0F0F0404040F0404040F0F0F0F0404040F04
          04040F0F0F0F0404040F0404040F0F0F0F0F0F040F0404040F0F0F0F0F040F0F
          0F0F040F0F0F0F0F040F0F0404040F0F0F0F0F040F0404040F0F0F0F0F0F040F
          0F0F040F0F0F0F0F0F040F0F04040F0F0F0F0F0F040F0404040F0F0F0F0F0F04
          0F0404040F0F0F0F0F040F0F0404040F0F0F0F0F040F0F0404040F0F0F0F0404
          0F0404040F0F0F0F0F04040F0F0F040F0F0F0F0F04040F0404040F0F0F0F0F04
          040F0404040F0F0F0F0F04040F0F0F040F0F0F0F04040F0F0F04040F0F0F0F04
          040F0F0404040F0F0F0F04040F0404040F0F0F0F0F04040F0404040F0F0F0F0F
          04040F0404040F0F0F0F0404040F0404040F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F040F0F0F0F0F040F0F0F0F040F0F
          0F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F0F040F0F0F0F0F040F
          0F0F04040F0F0F0F0F040F0F0F040F0F0F0F0F040F0F0F0404040F0F0F0F040F
          0F0F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F0F040F0F040F0F0F0F0F0F0F
          040F0F0F040F0F0F0F0F0F040F0F040F0F0F0F0F0F0F040F0F040F0F0F0F0F0F
          040F0F0F0F040F0F0F0F0F040F0F0F04040F0F0F0F0F040F0F040F0F0F0F0F0F
          0F040F0404040F0F0F0F0F0F040F0F040F0F0F0F0F0F0F040F0F040F0F0F0F0F
          0F040F0F0F040F0F0F0F0F040F0F0F0F0F040F0F0F0F040F0F0F0F040F0F0F0F
          0F040F0F0F040F0F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F04040F0F0F
          0F0F040F0F0F040F0F0F0F0F0F040F0F0404040F0F0F0F040F0F0F0F040F0F0F
          0F0F040F0F0F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F0F040F0F
          0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F040F0F0F0F0F040F0F0F0F0F040F
          0F0F0F040F0F0F0F04040F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0404040F
          0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F040F0F040F
          0F0F0F0F0F040F0F0F0F040F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F040F
          0F0F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F04040F0F0F0F0F0F040F0F04
          0F0F0F0F0F0F0F040F0404040F0F0F0F0F040F0F0F040F0F0F0F0F0F040F0F0F
          040F0F0F0F0F04040F0F040F0F0F0F0F0F04040F0F0F040F0F0F0F0F04040F0F
          040F0F0F0F0F0F04040F0F040F0F0F0F0F0F04040F0F0F040F0F0F0F04040F0F
          0F04040F0F0F0F04040F0F0F040F0F0F0F0F04040F0404040F0F0F0F0F04040F
          0F040F0F0F0F0F0F04040F0F040F0F0F0F0F0F040F0F0F040F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C
          0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0F0F0F0F0F0C0C0C0C0C0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F
          0F0F0F0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0C
          0C0C0C0F0F0F0F0F0F0C0C0C0C0C0F0C0C0C0F0F0F0C0C0C0F0F0F0F0C0C0C0F
          0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0C0C0C0C0F0F0F0F0F0F0F0F0C0C0C0C
          0C0C0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0F0F0F0C0C0C0C0C0C0C0C0C0F0F0F0F0F0C0C0C0F0F0F
          0F0F0C0C0C0F0F0F0F0F0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0C0C0C
          0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0F0F0F0C0C0C
          0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0F0F0F
          0F0F0F0C0C0C0C0C0C0C0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0C0C0C
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F
          0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0C0C0C0C0F0F0F0C0C0C0C0F0F
          0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0F
          0F0F0F0F0F0C0C0C0F0F0F0F0F0F0C0C0C0C0C0F0F0F0F0C0C0C0C0F0F0F0C0C
          0C0C0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0C0C
          0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0C0C0C0F0F0F0F0F0F
          0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0F0F0F0F0F0C0C0C0C0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0C0C0F0F0F0F
          0C0C0C0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F
          0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0C0C0C0C0C0F0F0F0F0C
          0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F
          0F0F0F0C0C0C0C0F0F0F0F0F0C0C0C0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F
          0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0C0C0C0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F
          0F0F0C0C0C0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C
          0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0F0F0C0C0C0F
          0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0F0F0F0C0C0C0F0F0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0F0F0C0C0C0F0F0F0C0C0F0C0C0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0C0C0C
          0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0F
          0F0F0C0C0C0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0C0C0C
          0F0F0F0F0C0C0C0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C
          0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0F0F0F0C0C0C0F
          0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0C0C0C
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0F0C0C0F0F0F0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0C0C0C0F
          0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F
          0F0F0F0F0F0C0C0C0F0F0F0F0C0C0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C
          0C0C0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F
          0F0F0F0F0C0C0C0F0F0C0C0C0C0C0C0C0C0C0C0C0C0F0F0C0C0C0F0F0F0F0F0F
          0F0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0C0C0C0F0C0C0C0F0F
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F
          0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0F0F0F
          0F0C0C0C0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0C0C0C0F0F0F0F0C
          0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F
          0F0F0F0C0C0C0F0F0F0F0F0F0C0C0C0F0F0C0C0C0F0F0F0F0F0F0C0C0C0F0F0C
          0C0C0F0F0F0F0F0F0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F
          0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0C
          0C0C0F0C0C0C0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F
          0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F
          0C0C0C0F0F0F0F0F0F0C0C0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0F0F0F
          0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0F0F0F0C0C0C0F
          0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0F0F0F0C0C0C0F0F0C0C0C0F0F0F0F
          0F0F0C0C0F0F0F0C0C0C0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0C0C0C0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0F0F0C0C0C0F0F0C0C0F0F0F0C0C0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0F0F0F0F0F0F0F0C0C0C0C0F0F0F0C0C0C0C0F0F0F0F0C0C0C0C0F0F
          0F0C0C0C0C0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0C0C0C
          0F0F0C0C0C0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C
          0C0F0F0F0C0C0C0C0F0F0C0C0C0C0F0F0F0F0F0C0C0C0C0F0F0F0F0C0C0C0F0F
          0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0C0C0C0C0F0F0F0F0F0C0C0C0F0F0F0F0F
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C
          0C0C0F0F0F0F0F0F0F0F0C0C0C0F0C0C0C0F0F0F0C0C0C0F0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0F0F0F
          0F0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0C0C0C0C0C0C0C0C0F0F0F0F0F0F
          0F0F0F0F0F0C0C0C0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0C0C0C0F0F0F0F0F0C
          0C0C0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0C0C0C0C0C
          0C0C0C0C0C0F0F0F0F0F0F0C0C0C0C0C0C0C0C0F0F0F0F0C0C0C0C0C0C0C0C0F
          0F0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F
          0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0C0C0C0F0F0F0C0C0C0F
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C
          0C0C0C0F0F0F0F0F0F0F0C0C0C0F0C0C0C0C0C0F0F0F0F0F0F0F0F0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0C0C0F0F0F0F0F0C0C0C0F0F0F0F0C
          0C0C0F0F0F0F0F0C0C0C0F0F0F0C0C0C0F0C0C0C0C0C0F0F0C0C0C0C0F0F0F0F
          0F0F0F0C0C0C0F0F0C0C0C0C0F0F0F0F0F0F0F0F0C0C0C0C0C0C0F0F0F0F0F0C
          0C0C0F0C0C0C0C0F0F0F0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F
          0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0C0C
          0F0F0F0F0F0C0C0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0F0F0F0F0F
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F
          0F0F0C0C0C0C0C0C0F0F0F0F0F0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C
          0C0C0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F0F0F0C0C0C0C0C0C
          0C0C0C0C0C0C0C0F0F0F0C0C0C0C0C0C0F0F0F0F0F0C0C0C0C0C0C0F0F0F0F0F
          0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0C0C0C0C0C0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0C0C0C0F
          0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0C0C0C0C0C0F0F0F0F0F0F0F0C0C
          0C0C0C0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0C0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F
          0F0F0F0F0C0C0C0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C0C0F0F0F0C0C0C0C0C0F
          0F0F0F0F0F0F0C0C0C0C0C0F0F0F0F0F0F0F0F0F0C0C0C0C0C0C0C0C0C0C0C0C
          0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F
          0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0C0C0C0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00000F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
          0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0000}
      end
      object Shape1: TShape
        Left = 0
        Top = 160
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object Shape2: TShape
        Left = 0
        Top = 168
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object Shape3: TShape
        Left = 0
        Top = 176
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object Shape4: TShape
        Left = 0
        Top = 184
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object Shape5: TShape
        Left = 0
        Top = 192
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object Shape7: TShape
        Left = 0
        Top = 208
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object Shape6: TShape
        Left = 0
        Top = 200
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object Shape8: TShape
        Left = 0
        Top = 216
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object Shape9: TShape
        Left = 0
        Top = 224
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object Shape10: TShape
        Left = 0
        Top = 232
        Width = 7
        Height = 7
        Brush.Color = clRed
        Shape = stCircle
        Visible = False
      end
      object lblUtmZoneNumber: TLabel
        Left = 80
        Top = 37
        Width = 105
        Height = 16
        Caption = 'UTM zone number'
      end
      object lblEllipsoid: TLabel
        Left = 560
        Top = 36
        Width = 166
        Height = 16
        Caption = 'Ellipsoid (and where applied)'
      end
      object lblCoordinates: TLabel
        Left = 432
        Top = 8
        Width = 164
        Height = 16
        Caption = 'Coordinates of first point = ?'
      end
      object lblCoordinateConversionInfo: TLabel
        Left = 8
        Top = 528
        Width = 594
        Height = 16
        Caption = 
          'If coordinate conversions are to be performed, 10 points from th' +
          'e shape file will be plotted on this map.'
      end
      object cbCoordinateConversion: TCheckBox
        Left = 8
        Top = 8
        Width = 473
        Height = 17
        Caption = 'Convert coordinates from decimal degrees to UTM'
        TabOrder = 0
        OnClick = cbCoordinateConversionClick
      end
      object comboEllipsoid: TComboBox
        Left = 232
        Top = 32
        Width = 321
        Height = 24
        Style = csDropDownList
        Enabled = False
        TabOrder = 2
        OnChange = comboEllipsoidChange
        Items.Strings = (
          'Airy (1830) Great Britain'
          'Bessel (1841) Japan'
          'Clarke (1866) North America'
          'Clarke (1880) France, Africa'
          'Everest (1830) India'
          'Fischer 1960'
          'Fishcer 1968'
          'GRS 67 (1967) Australia, South America'
          'GRS 75 (1975)'
          'GRS 80 (1979)'
          'Hough (1956)'
          'International (1924) Europe'
          'Krassowsky (1940) Russia'
          'South American 1969'
          'WGS 60'
          'WGS 66 (1966) USA/DoD'
          'WGS 72 (1972) USA/DoD'
          'WGS 84')
      end
      object seZoneNumber: TJvSpinEdit
        Left = 8
        Top = 32
        Width = 66
        Height = 24
        ButtonKind = bkClassic
        MaxValue = 60.000000000000000000
        MinValue = 1.000000000000000000
        Value = 1.000000000000000000
        Enabled = False
        TabOrder = 1
      end
    end
  end
  object xbShapeDataBase: TXBase
    Active = False
    AutoUpDate = True
    DebugErr = False
    Deleted = False
    Left = 24
    Top = 104
  end
  object OpenDialogShape: TOpenDialog
    Filter = 'Shape Files (*.shp)|*.shp'
    FilterIndex = 0
    Title = 'Open a Shapefile'
    Left = 64
    Top = 104
  end
  object rpShapeCompiler: TRbwParser
    Left = 472
    Top = 136
  end
end
