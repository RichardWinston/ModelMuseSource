object frmDisplayData: TfrmDisplayData
  Left = 0
  Top = 0
  HelpType = htKeyword
  HelpKeyword = 'Data_Visualization_Dialog_Box'
  Caption = 'Data Visualization'
  ClientHeight = 542
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object splSplit: TSplitter
    Left = 201
    Top = 0
    Width = 5
    Height = 501
  end
  object pglstMain: TJvPageList
    Left = 206
    Top = 0
    Width = 578
    Height = 501
    ActivePage = jvspSwrReachConnections
    PropagateEnable = False
    Align = alClient
    OnChange = pglstMainChange
    object jvspModpathPathline: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'MODPATH_Display_Dialog_Box'
      Caption = 'jvspModpathPathline'
      inline frameModpathDisplay: TframeModpathDisplay
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited pcMain: TPageControl
          Width = 578
          Height = 501
          ActivePage = frameModpathDisplay.tabBasic
          ExplicitWidth = 578
          ExplicitHeight = 501
          inherited tabBasic: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 457
            ExplicitHeight = 319
            inherited pbColorScheme: TPaintBox
              Width = 559
              ExplicitWidth = 559
            end
            inherited lblCycles: TLabel
              Left = 238
              Top = 219
              ExplicitLeft = 238
              ExplicitTop = 219
            end
            inherited fedModpathFile: TJvFilenameEdit
              Width = 559
              Height = 24
              ExplicitWidth = 559
              ExplicitHeight = 24
            end
            inherited comboColorScheme: TComboBox
              Width = 559
              ExplicitWidth = 559
              ExplicitHeight = 24
            end
            inherited seColorExponent: TJvSpinEdit
              Height = 24
              ExplicitHeight = 24
            end
            inherited seCycles: TJvSpinEdit
              Left = 238
              Height = 24
              ExplicitLeft = 238
              ExplicitHeight = 24
            end
          end
          inherited tabOptions: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 570
            ExplicitHeight = 470
            inherited rgShow2D: TRadioGroup
              Width = 550
              Items.Strings = (
                'Show all'
                'Specify columns, rows, layers, times and/or groups to show'
                
                  'Specify starting columns, rows, layers, times and/or groups to s' +
                  'how'
                
                  'Specify ending columns, rows, layers, times and/or groups to sho' +
                  'w')
              ExplicitWidth = 550
            end
            inherited rdgLimits: TRbwDataGrid4
              Width = 407
              Height = 514
              ExplicitWidth = 407
              ExplicitHeight = 514
              ColWidths = (
                64
                64
                64)
              RowHeights = (
                24
                24
                24
                24
                24
                24)
            end
          end
        end
      end
    end
    object jvspSfrStreamLinks: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'Stream_Links_Pane'
      Caption = 'jvspSfrStreamLinks'
      inline frameSfrStreamLink: TframeStreamLink
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited shpStreamColor: TShape
          Top = 4
          ExplicitTop = 4
        end
        inherited shpDiversionColor: TShape
          Top = 35
          ExplicitTop = 35
        end
        inherited shpUnconnectedColor: TShape
          Top = 66
          ExplicitTop = 66
        end
        inherited btnStreamColor: TButton
          Top = 4
          ExplicitTop = 4
        end
        inherited btnDiversionColor: TButton
          Top = 35
          ExplicitTop = 35
        end
        inherited rgItemsToPlot: TRadioGroup
          Height = 112
          ExplicitHeight = 112
        end
        inherited cbStreams: TCheckBox
          Width = 150
          ExplicitWidth = 150
        end
        inherited cbPlotDiversions: TCheckBox
          Width = 166
          ExplicitWidth = 166
        end
        inherited cbPlotUnconnected: TCheckBox
          Width = 222
          ExplicitWidth = 222
        end
        inherited btnUnconnectedColor: TButton
          Top = 66
          ExplicitTop = 66
        end
        inherited dlgLinkColor: TColorDialog
          Left = 208
        end
      end
    end
    object jvspHeadObsResults: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'Head_Observation_Results'
      Caption = 'jvspHeadObsResults'
      inline frameHeadObservationResults: TframeHeadObservationResults
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited pgcHeadObs: TPageControl
          Width = 578
          Height = 465
          ExplicitWidth = 578
          ExplicitHeight = 465
          inherited tabControls: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 520
            ExplicitHeight = 401
            inherited lblMaxSymbolSize: TLabel
              Top = 351
              ExplicitTop = 351
            end
            inherited clrbtnNegative: TJvColorButton
              Top = 321
              ExplicitTop = 321
            end
            inherited clrbtnPositive: TJvColorButton
              Top = 321
              ExplicitTop = 321
            end
            inherited spinSymbolSize: TJvSpinEdit
              Top = 348
              ExplicitTop = 348
            end
          end
          inherited tabValues: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 520
            ExplicitHeight = 401
            inherited rdgHeadObs: TRbwDataGrid4
              ColWidths = (
                64
                64
                64
                64
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
            inherited pnlValueControls: TPanel
              inherited btnCopy: TButton
                Left = 151
                Width = 146
                ExplicitLeft = 151
                ExplicitWidth = 146
              end
              inherited btnHightlightObjects: TButton
                Top = 2
                Width = 141
                Height = 55
                ExplicitTop = 2
                ExplicitWidth = 141
                ExplicitHeight = 55
              end
              inherited btnRestore: TButton
                Left = 151
                Top = 2
                Width = 146
                ExplicitLeft = 151
                ExplicitTop = 2
                ExplicitWidth = 146
              end
            end
          end
          inherited tabLegend: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 520
            ExplicitHeight = 401
          end
          inherited tabGraph: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 570
            ExplicitHeight = 434
            inherited pbHeadObs: TPaintBox
              Width = 570
              Height = 353
              ExplicitWidth = 570
              ExplicitHeight = 403
            end
            inherited pnlGraphControls: TPanel
              Top = 353
              Width = 570
              ExplicitTop = 353
              ExplicitWidth = 570
              inherited lblGraphInstructions: TLabel
                Width = 169
                Height = 16
                Anchors = [akLeft, akTop, akRight]
                ExplicitWidth = 169
                ExplicitHeight = 16
              end
            end
          end
        end
        inherited pnlBottom: TPanel
          Top = 465
          Width = 578
          ExplicitTop = 465
          ExplicitWidth = 578
          inherited comboModels: TComboBox
            Top = 4
            ExplicitTop = 4
          end
        end
      end
    end
    object jvspModpathTimeSeries: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'MODPATH_Time_Series_Display'
      Caption = 'jvspModpathTimeSeries'
      inline frameModpathTimeSeriesDisplay: TframeModpathTimeSeriesDisplay
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited pcMain: TPageControl
          Width = 578
          Height = 501
          ExplicitWidth = 578
          ExplicitHeight = 501
          inherited tabBasic: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 570
            ExplicitHeight = 470
            inherited pbColorScheme: TPaintBox
              Width = 559
              ExplicitWidth = 559
            end
            inherited lblCycles: TLabel
              Left = 244
              ExplicitLeft = 244
            end
            inherited fedModpathFile: TJvFilenameEdit
              Top = 32
              Width = 559
              ExplicitTop = 32
              ExplicitWidth = 559
            end
            inherited comboColorScheme: TComboBox
              Left = 2
              Top = 190
              Width = 559
              ExplicitLeft = 2
              ExplicitTop = 190
              ExplicitWidth = 559
            end
            inherited seCycles: TJvSpinEdit
              Left = 244
              ExplicitLeft = 244
            end
          end
          inherited tabOptions: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 457
            ExplicitHeight = 367
            inherited rgShow2D: TRadioGroup
              Width = 551
              ExplicitWidth = 551
            end
            inherited rdgLimits: TRbwDataGrid4
              Width = 511
              Height = 423
              Anchors = [akLeft, akTop, akRight, akBottom]
              ExplicitWidth = 511
              ExplicitHeight = 423
              ColWidths = (
                64
                64
                64)
              RowHeights = (
                24
                24
                24
                24
                24
                24)
            end
          end
        end
      end
    end
    object jvspModpathEndpoints: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'MODPATH_Endpoint_Display'
      Caption = 'jvspModpathEndpoints'
      inline frameModpathEndpointDisplay1: TframeModpathEndpointDisplay
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited pcMain: TPageControl
          Width = 578
          Height = 501
          ActivePage = frameModpathEndpointDisplay1.tabBasic
          ExplicitWidth = 578
          ExplicitHeight = 501
          inherited tabBasic: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 468
            ExplicitHeight = 328
            inherited pbColorScheme: TPaintBox
              Width = 559
              ExplicitWidth = 559
            end
            inherited lblCycles: TLabel
              Left = 238
              ExplicitLeft = 238
            end
            inherited fedModpathFile: TJvFilenameEdit
              Left = 2
              Top = 30
              Width = 559
              ExplicitLeft = 2
              ExplicitTop = 30
              ExplicitWidth = 559
            end
            inherited comboColorScheme: TComboBox
              Width = 559
              ExplicitWidth = 559
              ExplicitHeight = 24
            end
            inherited seColorExponent: TJvSpinEdit
              Top = 235
              ExplicitTop = 235
            end
            inherited seCycles: TJvSpinEdit
              Left = 238
              Top = 235
              Width = 84
              ExplicitLeft = 238
              ExplicitTop = 235
              ExplicitWidth = 84
            end
            inherited comboModelSelection: TComboBox
              Left = 2
              Top = 297
              ExplicitLeft = 2
              ExplicitTop = 297
            end
          end
          inherited tabOptions: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 468
            ExplicitHeight = 328
            inherited rgShow2D: TRadioGroup
              Width = 316
              ExplicitWidth = 316
            end
            inherited rgWhereToPlot: TRadioGroup
              Left = 331
              ExplicitLeft = 331
            end
            inherited rgColorBy: TRadioGroup
              Height = 270
              ExplicitHeight = 270
            end
            inherited rdgLimits: TRbwDataGrid4
              Width = 379
              Height = 354
              Anchors = [akLeft, akTop, akRight, akBottom]
              ExplicitWidth = 379
              ExplicitHeight = 354
              ColWidths = (
                64
                64
                64)
              RowHeights = (
                24
                24
                24
                24
                24
                24)
            end
          end
          inherited tabLegend: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 570
            ExplicitHeight = 470
            inherited imLegend: TImage
              Width = 364
              Height = 470
              ExplicitWidth = 364
              ExplicitHeight = 468
            end
            inherited splColor: TSplitter
              Height = 470
              ExplicitHeight = 468
            end
            inherited pnlLegend: TPanel
              Height = 470
              ExplicitHeight = 470
              inherited lblColorLegendRows: TLabel
                Top = 381
                ExplicitTop = 381
              end
              inherited comboMethod: TComboBox
                ExplicitHeight = 24
              end
              inherited seLegendRows: TJvSpinEdit
                Top = 402
                ExplicitTop = 402
              end
              inherited rdgLegend: TRbwDataGrid4
                Height = 310
                ExplicitHeight = 310
                ColWidths = (
                  64)
                RowHeights = (
                  24
                  24
                  24
                  24
                  24)
              end
              inherited btnFont: TButton
                Top = 432
                ExplicitTop = 432
              end
            end
          end
        end
      end
    end
    object jvspColorGrid: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'Color_Grid_Dialog_Box'
      Caption = 'jvspColorGrid'
      inline frameColorGrid: TframeColorGrid
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        OnResize = frameColorGridResize
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited pcChoices: TPageControl
          Width = 578
          Height = 501
          ExplicitWidth = 578
          ExplicitHeight = 501
          inherited tabSelection: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 570
            ExplicitHeight = 470
            inherited lblTime: TLabel
              Left = 369
              ExplicitLeft = 429
            end
            inherited udDataSets: TJvUpDown
              Left = 346
              ExplicitLeft = 346
            end
            inherited virttreecomboDataSets: TRbwStringTreeCombo
              Width = 338
              Anchors = [akLeft, akTop, akRight]
              ExplicitWidth = 358
            end
            inherited reComment: TRichEdit
              Width = 549
              Height = 284
              OnResizeRequest = frameColorGridreCommentResizeRequest
              ExplicitWidth = 549
              ExplicitHeight = 284
            end
            inherited udTime: TJvUpDown
              Left = 454
              Height = 26
              ExplicitLeft = 454
              ExplicitHeight = 26
            end
            inherited comboTime3D: TJvComboBox
              Left = 429
              ExplicitLeft = 429
            end
            inherited Panel1: TPanel
              Top = 225
              Width = 570
              ExplicitTop = 225
              ExplicitWidth = 570
              inherited rgUpdateLimitChoice: TRadioGroup
                Width = 315
                ExplicitWidth = 315
              end
              inherited btnColorSchemes: TButton
                Left = 345
                Width = 144
                ExplicitLeft = 345
                ExplicitWidth = 144
              end
            end
          end
          inherited tabFilters: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitHeight = 397
            inherited lblNumberOfValuesToIgnore: TLabel
              Left = 135
              Top = 402
              ExplicitLeft = 135
              ExplicitTop = 402
            end
            inherited cbActiveOnly: TCheckBox
              Width = 145
              ExplicitWidth = 145
            end
            inherited rdgValuesToIgnore: TRbwDataGrid4
              Height = 281
              ExplicitHeight = 281
              ColWidths = (
                64)
              RowHeights = (
                24
                24)
            end
            inherited seNumberOfValuesToIgnore: TJvSpinEdit
              Top = 399
              ExplicitTop = 399
            end
          end
          inherited tabLegend: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitHeight = 397
            inherited imLegend: TImage
              ExplicitHeight = 395
            end
            inherited splColor: TSplitter
              OnMoved = frameColorGridsplColorMoved
              ExplicitHeight = 395
            end
            inherited pnlLegend: TPanel
              inherited lblColorLegendRows: TLabel
                Top = 390
                ExplicitTop = 390
              end
              inherited seLegendRows: TJvSpinEdit
                Top = 411
                ExplicitTop = 411
              end
              inherited rdgLegend: TRbwDataGrid4
                Height = 325
                ExplicitHeight = 325
                ColWidths = (
                  64)
                RowHeights = (
                  24
                  24
                  24
                  24
                  24)
              end
              inherited btnFont: TButton
                Top = 441
                Anchors = [akLeft, akBottom]
                ExplicitTop = 441
              end
            end
          end
        end
        inherited dlgFontLegend: TFontDialog
          Top = 456
        end
      end
    end
    object jvspContourData: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'Contour_Data_Dialog_Box'
      Caption = 'jvspContourData'
      inline frameContourData: TframeContourData
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        OnResize = frameContourDataResize
        ExplicitWidth = 578
        inherited pcChoices: TPageControl
          Width = 578
          ExplicitWidth = 578
          inherited tabSelection: TTabSheet
            inherited lblDataSet: TLabel
              Width = 47
              Caption = 'Data set'
              ExplicitWidth = 47
            end
            inherited lblContourInterval: TLabel
              Left = 448
              Top = 61
              Anchors = [akTop, akRight]
              ExplicitLeft = 440
              ExplicitTop = 61
            end
            inherited udDataSets: TJvUpDown
              Left = 304
              Top = 28
              TabOrder = 3
              ExplicitLeft = 296
              ExplicitTop = 28
            end
            inherited virttreecomboDataSets: TRbwStringTreeCombo
              Top = 25
              Width = 323
              Anchors = [akLeft, akTop, akRight]
              OnChange = frameContourDatavirttreecomboDataSetsChange
              ExplicitTop = 25
              ExplicitWidth = 315
            end
            inherited reComment: TRichEdit
              Top = 85
              Height = 60
              ExplicitTop = 85
              ExplicitHeight = 60
            end
            inherited btnEditContours: TButton
              Left = 448
              Top = 26
              TabOrder = 2
              ExplicitLeft = 440
              ExplicitTop = 26
            end
            inherited cbSpecifyContours: TJvCheckBox
              Left = 354
              Top = 18
              ExplicitLeft = 346
              ExplicitTop = 18
            end
            inherited rdeContourInterval: TRbwDataEntry
              Left = 354
              Top = 58
              Width = 79
              Anchors = [akTop, akRight]
              ExplicitLeft = 346
              ExplicitTop = 58
              ExplicitWidth = 79
            end
            inherited Panel1: TPanel
              Width = 570
              inherited lblColorScheme: TLabel
                Left = 21
                Top = 150
                ExplicitLeft = 21
                ExplicitTop = 150
              end
              inherited lblCycles: TLabel
                Left = 459
                Top = 150
                ExplicitLeft = 459
                ExplicitTop = 150
              end
              inherited pbColorScheme: TPaintBox
                Left = 16
              end
              inherited lblColorAdjustment: TLabel
                Left = 21
              end
              inherited lblSpacing: TLabel
                Left = 328
                Top = 62
                Width = 131
                ExplicitLeft = 328
                ExplicitTop = 62
                ExplicitWidth = 131
              end
              inherited rgUpdateLimitChoice: TRadioGroup
                Left = 16
                Top = 71
                Width = 306
                ExplicitLeft = 16
                ExplicitTop = 71
                ExplicitWidth = 306
              end
              inherited btnColorSchemes: TButton
                Left = 328
                Top = 125
                Width = 117
                ExplicitLeft = 328
                ExplicitTop = 125
                ExplicitWidth = 117
              end
              inherited comboColorScheme: TComboBox
                Left = 16
                Top = 172
                Width = 437
                ExplicitLeft = 16
                ExplicitTop = 172
                ExplicitWidth = 437
              end
              inherited seCycles: TJvSpinEdit
                Left = 459
                Top = 172
                ExplicitLeft = 459
                ExplicitTop = 172
              end
              inherited jsColorExponent: TJvxSlider
                Left = 17
              end
              inherited seColorExponent: TJvSpinEdit
                Left = 189
              end
              inherited cbLogTransform: TCheckBox
                Left = 260
              end
              inherited btnContourFont: TButton
                Left = 328
                Top = 31
                Width = 153
                ExplicitLeft = 328
                ExplicitTop = 31
                ExplicitWidth = 153
              end
              inherited cbLabelContours: TCheckBox
                Left = 328
                Top = 8
                Width = 202
                ExplicitLeft = 328
                ExplicitTop = 8
                ExplicitWidth = 202
              end
              inherited seLabelSpacing: TJvSpinEdit
                Left = 328
                Top = 84
                Width = 100
                ExplicitLeft = 328
                ExplicitTop = 84
                ExplicitWidth = 100
              end
            end
          end
          inherited tabFilters: TTabSheet
            inherited lblNumberOfValuesToIgnore: TLabel
              Top = 437
              ExplicitTop = 437
            end
            inherited cbActiveOnly: TCheckBox
              Width = 177
              ExplicitWidth = 177
            end
            inherited rdgValuesToIgnore: TRbwDataGrid4
              Height = 316
              ExplicitHeight = 316
              ColWidths = (
                64)
              RowHeights = (
                24
                24)
            end
            inherited seNumberOfValuesToIgnore: TJvSpinEdit
              Top = 434
              ExplicitTop = 434
            end
          end
          inherited tabLegend: TTabSheet
            ExplicitWidth = 570
            inherited imLegend: TImage
              Width = 364
              ExplicitWidth = 344
              ExplicitHeight = 468
            end
            inherited splColor: TSplitter
              OnMoved = frameContourDatasplColorMoved
              ExplicitHeight = 468
            end
            inherited pnlLegend: TPanel
              inherited lblMethod: TLabel
                Left = 2
                Anchors = [akLeft, akBottom]
                ExplicitLeft = 2
              end
              inherited lblColorLegendRows: TLabel
                Left = 2
                Top = 380
                ExplicitLeft = 2
                ExplicitTop = 380
              end
              inherited comboMethod: TComboBox
                Left = 2
                ExplicitLeft = 2
              end
              inherited seLegendRows: TJvSpinEdit
                Left = 2
                Top = 401
                ExplicitLeft = 2
                ExplicitTop = 401
              end
              inherited rdgLegend: TRbwDataGrid4
                Left = 2
                Width = 193
                Height = 315
                ExplicitLeft = 2
                ExplicitWidth = 193
                ExplicitHeight = 315
                ColWidths = (
                  64)
                RowHeights = (
                  24
                  24
                  24
                  24
                  24)
              end
              inherited btnFont: TButton
                Left = 2
                Top = 433
                Anchors = [akLeft, akBottom]
                ExplicitLeft = 2
                ExplicitTop = 433
              end
            end
          end
        end
        inherited dlgFontLegend: TFontDialog
          Left = 240
          Top = 208
        end
        inherited fdContourFont: TFontDialog
          Left = 488
          Top = 216
        end
      end
    end
    object jvspVectors: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'Vectors_Pane'
      Caption = 'jvspVectors'
      inline frameVectors: TframeVectors
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        HelpType = htKeyword
        HelpKeyword = 'Vectors_Pane'
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited comboVectorSource: TComboBox
          Width = 543
          Anchors = [akLeft, akTop, akRight]
          ExplicitWidth = 543
        end
        inherited udVectors: TJvUpDown
          Left = 546
          ExplicitLeft = 546
        end
      end
    end
    object jvspStrStreamLinks: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'Stream_Links_Pane'
      Caption = 'jvspStrStreamLinks'
      inline frameStrStreamLink: TframeStreamLink
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited shpStreamColor: TShape
          Top = 4
          ExplicitTop = 4
        end
        inherited shpDiversionColor: TShape
          Top = 35
          ExplicitTop = 35
        end
        inherited shpUnconnectedColor: TShape
          Top = 66
          ExplicitTop = 66
        end
        inherited btnStreamColor: TButton
          Top = 4
          ExplicitTop = 4
        end
        inherited btnDiversionColor: TButton
          Top = 35
          ExplicitTop = 35
        end
        inherited rgItemsToPlot: TRadioGroup
          Height = 112
          ExplicitHeight = 112
        end
        inherited cbStreams: TCheckBox
          Width = 150
          ExplicitWidth = 150
        end
        inherited cbPlotDiversions: TCheckBox
          Width = 166
          ExplicitWidth = 166
        end
        inherited cbPlotUnconnected: TCheckBox
          Width = 222
          ExplicitWidth = 222
        end
        inherited btnUnconnectedColor: TButton
          Top = 66
          ExplicitTop = 66
        end
      end
    end
    object jvspCrossSection: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'Cross_Sections_Pane'
      Caption = 'jvspCrossSection'
      inline frameDrawCrossSection: TframeDrawCrossSection
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited btnAddDataSet: TSpeedButton
          Left = 273
          ExplicitLeft = 273
        end
        inherited btnRemoveDataSet: TSpeedButton
          Left = 273
          ExplicitLeft = 273
        end
        inherited vstAvailableDataSets: TVirtualStringTree
          Width = 264
          Height = 495
          ExplicitWidth = 264
          ExplicitHeight = 495
        end
        inherited pnlUsed: TPanel
          Left = 371
          Height = 501
          ExplicitLeft = 371
          ExplicitHeight = 501
          inherited spl1: TSplitter
            Top = 367
            ExplicitTop = 318
          end
          inherited pnlTop: TPanel
            Height = 367
            ExplicitHeight = 367
            inherited lstSelectedDataSets: TListBox
              Height = 334
              ExplicitHeight = 334
            end
          end
          inherited pnlBottom: TPanel
            Top = 372
            ExplicitTop = 372
          end
        end
      end
    end
    object jvspSwrReachConnections: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'SWR_Reach_Connections'
      Caption = 'jvspSwrReachConnections'
      inline frameSwrReachConnections: TframeSwrReachConnections
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited shpReachColor: TShape
          Left = 453
          Top = 4
          ExplicitLeft = 453
          ExplicitTop = 4
        end
        inherited shpUnconnectedColor: TShape
          Left = 453
          Top = 34
          ExplicitLeft = 453
          ExplicitTop = 34
        end
        inherited shpStructureColor: TShape
          Left = 453
          Top = 64
          ExplicitLeft = 453
          ExplicitTop = 64
        end
        inherited cbReaches: TCheckBox
          Width = 150
          OnClick = nil
          ExplicitWidth = 150
        end
        inherited btnReachColor: TButton
          Left = 247
          Top = 4
          OnClick = frameSwrReachConnectionsbtnReachColorClick
          ExplicitLeft = 247
          ExplicitTop = 4
        end
        inherited cbPlotUnconnected: TCheckBox
          Width = 206
          OnClick = nil
          ExplicitWidth = 206
        end
        inherited btnUnconnectedColor: TButton
          Left = 247
          Top = 34
          OnClick = frameSwrReachConnectionsbtnUnconnectedColorClick
          ExplicitLeft = 247
          ExplicitTop = 34
        end
        inherited rgItemsToPlot: TRadioGroup
          Height = 112
          ExplicitHeight = 112
        end
        inherited cbPlotStructures: TCheckBox
          Top = 67
          ExplicitTop = 67
        end
        inherited btnStructureColor: TButton
          Left = 247
          Top = 64
          ExplicitLeft = 247
          ExplicitTop = 64
        end
      end
    end
    object jvspSwrObsDisplay: TJvStandardPage
      Left = 0
      Top = 0
      Width = 578
      Height = 501
      HelpType = htKeyword
      HelpKeyword = 'SWR_Observations'
      Caption = 'jvspSwrObsDisplay'
      inline frameSwrObsDisplay: TframeSwrObsDisplay
        Left = 0
        Top = 0
        Width = 578
        Height = 501
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 578
        ExplicitHeight = 501
        inherited pbPlot: TPaintBox
          Width = 452
          Height = 372
          ExplicitWidth = 452
          ExplicitHeight = 436
        end
        inherited spl1: TSplitter
          Height = 372
          ExplicitHeight = 436
        end
        inherited pnlTop: TPanel
          Width = 578
          ExplicitWidth = 578
          inherited fedObservationFile: TJvFilenameEdit
            Height = 24
            ExplicitHeight = 24
          end
          inherited seIncrement: TJvSpinEdit
            Height = 24
            ExplicitHeight = 24
          end
        end
        inherited rdgTimes: TRbwDataGrid4
          Height = 372
          ExplicitTop = 129
          ExplicitHeight = 372
          ColWidths = (
            50)
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
  object tvpglstMain: TJvPageListTreeView
    Left = 0
    Top = 0
    Width = 201
    Height = 501
    PageDefault = 0
    PageList = pglstMain
    Align = alLeft
    HideSelection = False
    Indent = 20
    TabOrder = 0
    OnChanging = tvpglstMainChanging
    OnCustomDrawItem = tvpglstMainCustomDrawItem
    Items.NodeData = {
      0307000000320000000000000000000000FFFFFFFFFFFFFFFF00000000050000
      0000000000010A43006F006C006F007200200047007200690064003600000000
      00000000000000FFFFFFFFFFFFFFFF000000000600000000000000010C43006F
      006E0074006F0075007200200044006100740061004000000000000000000000
      00FFFFFFFFFFFFFFFF00000000000000000000000001114D004F004400500041
      0054004800200050006100740068006C0069006E006500730042000000000000
      0000000000FFFFFFFFFFFFFFFF00000000040000000000000001124D004F0044
      005000410054004800200045006E006400200050006F0069006E007400730044
      0000000000000000000000FFFFFFFFFFFFFFFF00000000030000000000000001
      134D004F00440050004100540048002000540069006D00650020005300650072
      006900650073004E0000000000000000000000FFFFFFFFFFFFFFFF0000000002
      000000000000000118480065006100640020004F006200730065007200760061
      00740069006F006E00200052006500730075006C007400730036000000000000
      0000000000FFFFFFFFFFFFFFFF000000000100000000000000010C5300740072
      00650061006D0020004C0069006E006B007300}
    Items.Links = {
      0700000005000000060000000000000004000000030000000200000001000000}
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 501
    Width = 784
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      784
      41)
    object btnHelp: TBitBtn
      Left = 448
      Top = 6
      Width = 101
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
    object btnApply: TBitBtn
      Left = 555
      Top = 6
      Width = 101
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Apply'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
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
      OnClick = btnApplyClick
    end
    object btnClose: TBitBtn
      Left = 662
      Top = 6
      Width = 101
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
    end
  end
end
