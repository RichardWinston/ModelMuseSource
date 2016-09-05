inherited frmModflowOutputControl: TfrmModflowOutputControl
  HelpType = htKeyword
  HelpKeyword = 'MODFLOW_Output_Control_Dialog_Box'
  Caption = 'MODFLOW Output Control'
  ClientHeight = 403
  ClientWidth = 604
  ExplicitWidth = 622
  ExplicitHeight = 448
  PixelsPerInch = 120
  TextHeight = 18
  object JvNetscapeSplitter1: TJvNetscapeSplitter
    Left = 121
    Top = 0
    Height = 362
    Align = alLeft
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
    ExplicitLeft = 0
    ExplicitTop = 160
    ExplicitHeight = 100
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 362
    Width = 604
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      604
      41)
    object btnHelp: TBitBtn
      Left = 340
      Top = 6
      Width = 82
      Height = 27
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
    object btnOK: TBitBtn
      Left = 428
      Top = 6
      Width = 82
      Height = 27
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 516
      Top = 6
      Width = 83
      Height = 27
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object pltrPageNavigator: TJvPageListTreeView
    Left = 0
    Top = 0
    Width = 121
    Height = 362
    AutoExpand = False
    ShowLines = True
    PageDefault = 0
    PageList = jvPages
    Align = alLeft
    HideSelection = False
    Indent = 20
    RowSelect = True
    TabOrder = 0
    OnCustomDrawItem = pltrPageNavigatorCustomDrawItem
    Items.NodeData = {
      03050000002C0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000
      00000000000107470065006E006500720061006C002600000000000000000000
      00FFFFFFFFFFFFFFFFFFFFFFFF0100000000000000010448006500610064002E
      0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF020000000000000001
      08440072006100770064006F0077006E002A0000000000000000000000FFFFFF
      FFFFFFFFFFFFFFFFFF030000000000000001064200750064006700650074002A
      0000000000000000000000FFFFFFFFFFFFFFFF00000000040000000000000001
      064D005400330044004D005300}
    Items.Links = {050000000000000001000000020000000300000004000000}
  end
  object jvPages: TJvPageList
    Left = 131
    Top = 0
    Width = 473
    Height = 362
    ActivePage = jvspBudget
    PropagateEnable = False
    Align = alClient
    OnChange = jvPagesChange
    object jvspGeneral: TJvStandardPage
      Left = 0
      Top = 0
      Width = 473
      Height = 362
      HelpType = htKeyword
      HelpKeyword = 'General_Pane'
      Caption = 'jvspGeneral'
      DesignSize = (
        473
        362)
      object Comments: TLabel
        Left = 6
        Top = 144
        Width = 76
        Height = 18
        Caption = 'Comments'
      end
      object lblOutputSuppression: TLabel
        Left = 6
        Top = 78
        Width = 351
        Height = 18
        Caption = 'Output suppression (LSTLVL MODFLOW-OWHM) '
      end
      object cbPrintInputArrays: TJvCheckBox
        Left = 6
        Top = 3
        Width = 140
        Height = 20
        Caption = 'Print input arrays'
        Checked = True
        State = cbChecked
        TabOrder = 0
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = 17
        HotTrackFont.Name = 'Microsoft Sans Serif'
        HotTrackFont.Pitch = fpVariable
        HotTrackFont.Style = []
      end
      object cbPrintInputCellLists: TJvCheckBox
        Left = 6
        Top = 26
        Width = 151
        Height = 20
        Caption = 'Print input cell lists'
        Checked = True
        State = cbChecked
        TabOrder = 1
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = 17
        HotTrackFont.Name = 'Microsoft Sans Serif'
        HotTrackFont.Pitch = fpVariable
        HotTrackFont.Style = []
      end
      object memoComments: TMemo
        Left = 6
        Top = 168
        Width = 464
        Height = 188
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 4
      end
      object cbPrintObservations: TCheckBox
        Left = 6
        Top = 50
        Width = 403
        Height = 17
        Caption = 'Print observation data (inverse of NOPRINT option)'
        TabOrder = 2
      end
      object comboOutputSuppression: TJvImageComboBox
        Left = 6
        Top = 102
        Width = 345
        Height = 28
        Style = csOwnerDrawVariable
        ButtonStyle = fsLighter
        DroppedWidth = 345
        ImageHeight = 0
        ImageWidth = 0
        ItemHeight = 22
        ItemIndex = -1
        TabOrder = 3
        Items = <
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'No list file (1)'
          end
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'Only show errors (2)'
          end
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'Only show errors and warnings (3)'
          end
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'Show all (4)'
          end>
      end
    end
    object jvspHeads: TJvStandardPage
      Left = 0
      Top = 0
      Width = 473
      Height = 362
      HelpType = htKeyword
      HelpKeyword = 'Head_and_Drawdown_Panes'
      Caption = 'jvspHead'
      inline frameHead: TframeOutputControl
        Left = 0
        Top = 0
        Width = 473
        Height = 362
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 473
        ExplicitHeight = 362
        inherited lblOutputType: TLabel
          Width = 38
          Caption = 'Head'
          ExplicitWidth = 38
        end
        inherited lblExternalFormat: TLabel
          Width = 211
          Caption = 'External file format (CHEDFM)'
          ExplicitWidth = 211
        end
        inherited lblDot: TLabel
          Font.Pitch = fpVariable
        end
        inherited lblListinglFormat: TLabel
          Width = 192
          Caption = 'Listing file format (IHEDFM)'
          ExplicitWidth = 192
        end
        inherited comboFrequency: TJvImageComboBox
          Width = 448
          Anchors = [akLeft, akTop, akRight]
          DroppedWidth = 448
          ExplicitWidth = 448
        end
        inherited rcExternalFormat: TRbwController
          ControlList = <
            item
              Control = frameHead.adeD
            end
            item
              Control = frameHead.adeW
            end
            item
              Control = frameHead.comboP
            end
            item
              Control = frameHead.comboREdit
            end
            item
              Control = frameHead.lblResult
            end
            item
              Control = frameHead.lblDot
            end>
        end
        inherited rcListingFormat: TRbwController
          ControlList = <
            item
              Control = frameHead.comboPrintFormat
            end
            item
              Control = frameHead.comboPrintStyle
            end>
        end
      end
    end
    object jvspDrawdown: TJvStandardPage
      Left = 0
      Top = 0
      Width = 473
      Height = 362
      HelpType = htKeyword
      HelpKeyword = 'Head_and_Drawdown_Panes'
      Caption = 'jvspDrawdown'
      inline frameDrawdown: TframeOutputControl
        Left = 0
        Top = 0
        Width = 473
        Height = 362
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 473
        ExplicitHeight = 362
        inherited lblOutputType: TLabel
          Width = 74
          Caption = 'Drawdown'
          ExplicitWidth = 74
        end
        inherited lblExternalFormat: TLabel
          Width = 212
          Caption = 'External file format (CDDNFM)'
          ExplicitWidth = 212
        end
        inherited lblDot: TLabel
          Font.Pitch = fpVariable
        end
        inherited lblListinglFormat: TLabel
          Width = 193
          Caption = 'Listing file format (IDDNFM)'
          ExplicitWidth = 193
        end
        inherited comboFrequency: TJvImageComboBox
          Width = 448
          Anchors = [akLeft, akTop, akRight]
          DroppedWidth = 448
          ExplicitWidth = 448
        end
        inherited rcExternalFormat: TRbwController
          ControlList = <
            item
              Control = frameDrawdown.adeD
            end
            item
              Control = frameDrawdown.adeW
            end
            item
              Control = frameDrawdown.comboP
            end
            item
              Control = frameDrawdown.comboREdit
            end
            item
              Control = frameDrawdown.lblResult
            end
            item
              Control = frameDrawdown.lblDot
            end>
        end
        inherited rcListingFormat: TRbwController
          ControlList = <
            item
              Control = frameDrawdown.comboPrintFormat
            end
            item
              Control = frameDrawdown.comboPrintStyle
            end>
        end
      end
    end
    object jvspBudget: TJvStandardPage
      Left = 0
      Top = 0
      Width = 473
      Height = 362
      HelpType = htKeyword
      HelpKeyword = 'Budget_Pane'
      Caption = 'jvspBudget'
      DesignSize = (
        473
        362)
      object lblN: TLabel
        Left = 16
        Top = 113
        Width = 24
        Height = 18
        Caption = 'N ='
      end
      object lblFrequency: TLabel
        Left = 16
        Top = 54
        Width = 73
        Height = 18
        Caption = 'Frequency'
      end
      object lblBudget: TLabel
        Left = 16
        Top = 8
        Width = 50
        Height = 18
        Caption = 'Budget'
      end
      object cbCompact: TJvCheckBox
        Left = 16
        Top = 31
        Width = 140
        Height = 20
        Caption = 'Compact budget'
        Checked = True
        State = cbChecked
        TabOrder = 0
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = 17
        HotTrackFont.Name = 'Microsoft Sans Serif'
        HotTrackFont.Pitch = fpVariable
        HotTrackFont.Style = []
      end
      object rgSaveCellFlows: TJvRadioGroup
        Left = 16
        Top = 145
        Width = 385
        Height = 48
        Caption = 'Save cell flows'
        Columns = 3
        Items.Strings = (
          'None'
          'Binary'
          'Listing')
        TabOrder = 3
      end
      object comboFrequency: TJvImageComboBox
        Left = 16
        Top = 77
        Width = 448
        Height = 28
        Style = csOwnerDrawVariable
        Anchors = [akLeft, akTop, akRight]
        ButtonStyle = fsLighter
        DroppedWidth = 448
        ImageHeight = 0
        ImageWidth = 0
        ItemHeight = 22
        ItemIndex = 0
        TabOrder = 1
        Items = <
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'First N times steps and each N'#39'th time step thereafter'
          end
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'Last time step of each N'#39'th stress period'
          end>
      end
      object spN: TJvSpinEdit
        Left = 44
        Top = 110
        Width = 65
        Height = 26
        CheckMaxValue = False
        ButtonKind = bkClassic
        MinValue = 1.000000000000000000
        Value = 1.000000000000000000
        TabOrder = 2
      end
      object cbSaveBudgetSummary: TCheckBox
        Left = 16
        Top = 199
        Width = 441
        Height = 49
        Caption = 
          'Save budget summary flow rates to a separate file (WBGT in MODFL' +
          'OW-OWHM)'
        TabOrder = 4
        WordWrap = True
      end
    end
    object jvspMT3DMS: TJvStandardPage
      Left = 0
      Top = 0
      Width = 473
      Height = 362
      HelpType = htKeyword
      HelpKeyword = 'MT3DMS_Pane'
      Caption = 'jvspMT3DMS'
      object lblMt3dmsPrintN: TLabel
        Left = 255
        Top = 59
        Width = 11
        Height = 18
        Caption = 'N'
      end
      object lblMt3dmsPrintWhen: TLabel
        Left = 6
        Top = 33
        Width = 251
        Height = 18
        Caption = 'When to print and save data (NPRS)'
      end
      object lblMt3dmsPrintConc: TLabel
        Left = 79
        Top = 89
        Width = 318
        Height = 18
        Caption = 'Frequency for saving observations (NPROBS)'
      end
      object lblMt3dMsPrintMassBalance: TLabel
        Left = 79
        Top = 144
        Width = 327
        Height = 18
        Caption = 'Frequency for saving mass balance (NPRMAS)'
      end
      object cbMt3dSaveConc: TCheckBox
        Left = 6
        Top = 10
        Width = 395
        Height = 17
        Caption = 'Save concentrations to external file (SAVUCN)'
        TabOrder = 0
      end
      object comboSaveMt3msResults: TComboBox
        Left = 8
        Top = 54
        Width = 228
        Height = 26
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 1
        Text = 'at end of simulation'
        OnChange = comboSaveMt3msResultsChange
        Items.Strings = (
          'at specified times'
          'at end of simulation'
          'every N transport steps')
      end
      object spinMt3dmsPrintN: TJvSpinEdit
        Left = 272
        Top = 54
        Width = 71
        Height = 26
        MaxValue = 2147483647.000000000000000000
        MinValue = 1.000000000000000000
        Value = 1.000000000000000000
        TabOrder = 2
      end
      object spinMt3dmsPrintObs: TJvSpinEdit
        Left = 6
        Top = 86
        Width = 67
        Height = 26
        MaxValue = 2147483647.000000000000000000
        Value = 1.000000000000000000
        TabOrder = 3
      end
      object spinMt3dMsPrintMassBalance: TJvSpinEdit
        Left = 6
        Top = 141
        Width = 67
        Height = 26
        MaxValue = 2147483647.000000000000000000
        Value = 1.000000000000000000
        TabOrder = 5
      end
      object cbSummarizeMassBalance: TCheckBox
        Left = 6
        Top = 118
        Width = 369
        Height = 17
        Caption = 'Summarize mass balance (CHKMAS)'
        TabOrder = 4
      end
      inline frameMt3dmsTimes: TframeGrid
        Left = 0
        Top = 200
        Width = 473
        Height = 162
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 6
        ExplicitTop = 200
        ExplicitWidth = 473
        ExplicitHeight = 162
        inherited Panel: TPanel
          Top = 121
          Width = 473
          ExplicitTop = 121
          ExplicitWidth = 473
          inherited lbNumber: TLabel
            Width = 218
            Height = 18
            Caption = 'Number of output times (NPRS)'
            ExplicitWidth = 218
            ExplicitHeight = 18
          end
          inherited sbAdd: TSpeedButton
            Left = 353
            ExplicitLeft = 310
          end
          inherited sbInsert: TSpeedButton
            Left = 385
            ExplicitLeft = 339
          end
          inherited sbDelete: TSpeedButton
            Left = 417
            ExplicitLeft = 368
          end
          inherited seNumber: TJvSpinEdit
            Height = 26
            ExplicitHeight = 26
          end
        end
        inherited Grid: TRbwDataGrid4
          Width = 473
          Height = 121
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
              Format = rcf4Real
              LimitToList = False
              MaxLength = 0
              ParentButtonFont = False
              WordWrapCaptions = False
              WordWrapCells = False
              CaseSensitivePicklist = False
              CheckStyle = csCheck
              AutoAdjustColWidths = True
            end>
          ExplicitWidth = 473
          ExplicitHeight = 121
        end
      end
    end
  end
end
