inherited frmCropProperties: TfrmCropProperties
  HelpType = htKeyword
  HelpKeyword = 'Farm_Crop_Properties_Dialog_Bo'
  AutoSize = False
  Caption = 'Farm Crop Properties'
  ClientHeight = 513
  ClientWidth = 681
  ExplicitWidth = 699
  ExplicitHeight = 560
  PixelsPerInch = 120
  TextHeight = 18
  object splitterMain: TJvNetscapeSplitter
    Left = 225
    Top = 0
    Height = 469
    Align = alLeft
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
    ExplicitLeft = 280
    ExplicitTop = 136
    ExplicitHeight = 100
  end
  object jvpltvMain: TJvPageListTreeView
    Left = 0
    Top = 0
    Width = 225
    Height = 469
    ShowButtons = True
    PageDefault = 0
    PageList = jplMain
    Align = alLeft
    HideSelection = False
    Indent = 19
    TabOrder = 0
    OnChange = jvpltvMainChange
    OnCustomDrawItem = jvpltvMainCustomDrawItem
    Items.Links = {00000000}
    ExplicitHeight = 149
  end
  object jplMain: TJvPageList
    Left = 235
    Top = 0
    Width = 446
    Height = 469
    ActivePage = jvspRootDepth
    PropagateEnable = False
    Align = alClient
    OnChange = jplMainChange
    ExplicitWidth = 67
    ExplicitHeight = 149
    object jvspCropName: TJvStandardPage
      Left = 0
      Top = 0
      Width = 446
      Height = 469
      HelpType = htKeyword
      HelpKeyword = 'Crops_Pane'
      Caption = 'jvspCropName'
      ExplicitWidth = 67
      ExplicitHeight = 149
      inline frameCropName: TframeFormulaGrid
        Left = 0
        Top = 0
        Width = 446
        Height = 469
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 67
        ExplicitHeight = 149
        inherited Panel: TPanel
          Top = 428
          Width = 446
          ExplicitTop = 108
          ExplicitWidth = 67
          inherited lbNumber: TLabel
            Top = 6
            Width = 115
            Height = 18
            Caption = 'Number of crops'
            ExplicitTop = 6
            ExplicitWidth = 115
            ExplicitHeight = 18
          end
          inherited sbAdd: TSpeedButton
            Left = 229
            OnClick = frameCropNamesbAddClick
            ExplicitLeft = 148
          end
          inherited sbInsert: TSpeedButton
            Left = 275
            OnClick = frameCropNamesbInsertClick
            ExplicitLeft = 176
          end
          inherited sbDelete: TSpeedButton
            Left = 315
            OnClick = frameCropNamesbDeleteClick
            ExplicitLeft = 204
          end
          inherited seNumber: TJvSpinEdit
            Height = 26
            OnChange = frameCropNameseNumberChange
            ExplicitHeight = 26
          end
        end
        inherited Grid: TRbwDataGrid4
          Width = 446
          Height = 371
          OnSetEditText = frameCropNameGridSetEditText
          OnBeforeDrawCell = frameCropNameGridBeforeDrawCell
          OnButtonClick = GridButtonClick
          ExplicitWidth = 67
          ExplicitHeight = 51
          ColWidths = (
            64)
          RowHeights = (
            24
            24)
        end
        inherited pnlTop: TPanel
          Width = 446
          ExplicitWidth = 67
          inherited edFormula: TLabeledEdit
            Height = 26
            EditLabel.Width = 57
            EditLabel.Height = 18
            EditLabel.ExplicitLeft = 128
            EditLabel.ExplicitTop = 9
            EditLabel.ExplicitWidth = 57
            EditLabel.ExplicitHeight = 18
            ExplicitHeight = 26
          end
        end
      end
    end
    object jvspRootDepth: TJvStandardPage
      Left = 0
      Top = 0
      Width = 446
      Height = 469
      HelpType = htKeyword
      HelpKeyword = 'Rooting_Depth_Pane'
      Caption = 'jvspRootDepth'
      inline frameRootDepth: TframeFormulaGrid
        Left = 0
        Top = 0
        Width = 446
        Height = 469
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 446
        ExplicitHeight = 469
        inherited Panel: TPanel
          Top = 428
          Width = 446
          ExplicitTop = 428
          ExplicitWidth = 446
          inherited lbNumber: TLabel
            Width = 55
            Height = 18
            ExplicitWidth = 55
            ExplicitHeight = 18
          end
          inherited sbAdd: TSpeedButton
            Left = 231
            ExplicitLeft = 148
          end
          inherited sbInsert: TSpeedButton
            Left = 274
            ExplicitLeft = 176
          end
          inherited sbDelete: TSpeedButton
            Left = 317
            ExplicitLeft = 204
          end
          inherited seNumber: TJvSpinEdit
            Height = 26
            ExplicitHeight = 26
          end
        end
        inherited Grid: TRbwDataGrid4
          Width = 446
          Height = 371
          OnSetEditText = GridSetEditText
          OnButtonClick = GridButtonClick
          OnEndUpdate = frameRootDepthGridEndUpdate
          ExplicitWidth = 446
          ExplicitHeight = 371
          ColWidths = (
            64)
          RowHeights = (
            24
            24)
        end
        inherited pnlTop: TPanel
          Width = 446
          ExplicitWidth = 446
          inherited edFormula: TLabeledEdit
            Height = 26
            EditLabel.Width = 57
            EditLabel.Height = 18
            EditLabel.ExplicitLeft = 128
            EditLabel.ExplicitTop = 9
            EditLabel.ExplicitWidth = 57
            EditLabel.ExplicitHeight = 18
            ExplicitHeight = 26
          end
        end
      end
    end
    object jvspEvapFractions: TJvStandardPage
      Left = 0
      Top = 0
      Width = 446
      Height = 469
      HelpType = htKeyword
      HelpKeyword = 'Consumptive_Use_Factors_Pane'
      Caption = 'jvspEvapFractions'
      inline frameEvapFractions: TframeFormulaGrid
        Left = 0
        Top = 0
        Width = 446
        Height = 469
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 446
        ExplicitHeight = 469
        inherited Panel: TPanel
          Top = 428
          Width = 446
          ExplicitTop = 428
          ExplicitWidth = 446
          inherited lbNumber: TLabel
            Width = 55
            Height = 18
            ExplicitWidth = 55
            ExplicitHeight = 18
          end
          inherited sbAdd: TSpeedButton
            Left = 231
            ExplicitLeft = 148
          end
          inherited sbInsert: TSpeedButton
            Left = 274
            ExplicitLeft = 176
          end
          inherited sbDelete: TSpeedButton
            Left = 317
            ExplicitLeft = 204
          end
          inherited seNumber: TJvSpinEdit
            Height = 26
            ExplicitHeight = 26
          end
        end
        inherited Grid: TRbwDataGrid4
          Width = 446
          Height = 371
          OnSetEditText = GridSetEditText
          OnButtonClick = GridButtonClick
          OnEndUpdate = frameEvapFractionsGridEndUpdate
          ExplicitWidth = 446
          ExplicitHeight = 371
          ColWidths = (
            64)
          RowHeights = (
            24
            24)
        end
        inherited pnlTop: TPanel
          Width = 446
          ExplicitWidth = 446
          inherited edFormula: TLabeledEdit
            Height = 26
            EditLabel.Width = 57
            EditLabel.Height = 18
            EditLabel.ExplicitLeft = 128
            EditLabel.ExplicitTop = 9
            EditLabel.ExplicitWidth = 57
            EditLabel.ExplicitHeight = 18
            ExplicitHeight = 26
          end
        end
      end
    end
    object jvspLosses: TJvStandardPage
      Left = 0
      Top = 0
      Width = 446
      Height = 469
      HelpType = htKeyword
      HelpKeyword = 'Inefficiency_Losses_to_Surface'
      Caption = 'jvspLosses'
      inline frameLosses: TframeFormulaGrid
        Left = 0
        Top = 0
        Width = 446
        Height = 469
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 446
        ExplicitHeight = 469
        inherited Panel: TPanel
          Top = 428
          Width = 446
          ExplicitTop = 428
          ExplicitWidth = 446
          inherited lbNumber: TLabel
            Width = 55
            Height = 18
            ExplicitWidth = 55
            ExplicitHeight = 18
          end
          inherited sbAdd: TSpeedButton
            Left = 231
            ExplicitLeft = 148
          end
          inherited sbInsert: TSpeedButton
            Left = 274
            ExplicitLeft = 176
          end
          inherited sbDelete: TSpeedButton
            Left = 317
            ExplicitLeft = 204
          end
          inherited seNumber: TJvSpinEdit
            Height = 26
            ExplicitHeight = 26
          end
        end
        inherited Grid: TRbwDataGrid4
          Width = 446
          Height = 371
          OnSetEditText = GridSetEditText
          OnButtonClick = GridButtonClick
          OnEndUpdate = frameLossesGridEndUpdate
          ExplicitWidth = 446
          ExplicitHeight = 371
          ColWidths = (
            64)
          RowHeights = (
            24
            24)
        end
        inherited pnlTop: TPanel
          Width = 446
          ExplicitWidth = 446
          inherited edFormula: TLabeledEdit
            Height = 26
            EditLabel.Width = 57
            EditLabel.Height = 18
            EditLabel.ExplicitLeft = 128
            EditLabel.ExplicitTop = 9
            EditLabel.ExplicitWidth = 57
            EditLabel.ExplicitHeight = 18
            ExplicitHeight = 26
          end
        end
      end
    end
    object jvspCropFunction: TJvStandardPage
      Left = 0
      Top = 0
      Width = 446
      Height = 469
      HelpType = htKeyword
      HelpKeyword = 'Crop_Price_Function_Pane'
      Caption = 'jvspCropFunction'
      inline frameCropFunction: TframeFormulaGrid
        Left = 0
        Top = 0
        Width = 446
        Height = 469
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 446
        ExplicitHeight = 469
        inherited Panel: TPanel
          Top = 428
          Width = 446
          ExplicitTop = 428
          ExplicitWidth = 446
          inherited lbNumber: TLabel
            Width = 55
            Height = 18
            ExplicitWidth = 55
            ExplicitHeight = 18
          end
          inherited sbAdd: TSpeedButton
            Left = 231
            ExplicitLeft = 148
          end
          inherited sbInsert: TSpeedButton
            Left = 274
            ExplicitLeft = 176
          end
          inherited sbDelete: TSpeedButton
            Left = 317
            ExplicitLeft = 204
          end
          inherited seNumber: TJvSpinEdit
            Height = 26
            ExplicitHeight = 26
          end
        end
        inherited Grid: TRbwDataGrid4
          Width = 446
          Height = 371
          OnSetEditText = GridSetEditText
          OnButtonClick = GridButtonClick
          OnEndUpdate = frameCropFunctionGridEndUpdate
          ExplicitWidth = 446
          ExplicitHeight = 371
          ColWidths = (
            64)
          RowHeights = (
            24
            24)
        end
        inherited pnlTop: TPanel
          Width = 446
          ExplicitWidth = 446
          inherited edFormula: TLabeledEdit
            Height = 26
            EditLabel.Width = 57
            EditLabel.Height = 18
            EditLabel.ExplicitLeft = 128
            EditLabel.ExplicitTop = 9
            EditLabel.ExplicitWidth = 57
            EditLabel.ExplicitHeight = 18
            ExplicitHeight = 26
          end
        end
      end
    end
    object jvspCropWaterUse: TJvStandardPage
      Left = 0
      Top = 0
      Width = 446
      Height = 469
      HelpType = htKeyword
      HelpKeyword = 'Consumptive_Use_Flux_or_Crop_C'
      Caption = 'jvspCropWaterUse'
      inline frameCropWaterUse: TframeFormulaGrid
        Left = 0
        Top = 0
        Width = 446
        Height = 469
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 446
        ExplicitHeight = 469
        inherited Panel: TPanel
          Top = 428
          Width = 446
          ExplicitTop = 428
          ExplicitWidth = 446
          inherited lbNumber: TLabel
            Width = 55
            Height = 18
            ExplicitWidth = 55
            ExplicitHeight = 18
          end
          inherited sbAdd: TSpeedButton
            Left = 231
            ExplicitLeft = 148
          end
          inherited sbInsert: TSpeedButton
            Left = 274
            ExplicitLeft = 176
          end
          inherited sbDelete: TSpeedButton
            Left = 317
            ExplicitLeft = 204
          end
          inherited seNumber: TJvSpinEdit
            Height = 26
            ExplicitHeight = 26
          end
        end
        inherited Grid: TRbwDataGrid4
          Width = 446
          Height = 371
          OnSetEditText = GridSetEditText
          OnBeforeDrawCell = frameCropWaterUseGridBeforeDrawCell
          OnButtonClick = GridButtonClick
          OnEndUpdate = frameCropWaterUseGridEndUpdate
          ExplicitWidth = 446
          ExplicitHeight = 371
          ColWidths = (
            64)
          RowHeights = (
            24
            24)
        end
        inherited pnlTop: TPanel
          Width = 446
          ExplicitWidth = 446
          inherited edFormula: TLabeledEdit
            Height = 26
            EditLabel.Width = 57
            EditLabel.Height = 18
            EditLabel.ExplicitLeft = 128
            EditLabel.ExplicitTop = 9
            EditLabel.ExplicitWidth = 57
            EditLabel.ExplicitHeight = 18
            ExplicitHeight = 26
          end
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 469
    Width = 681
    Height = 44
    Align = alBottom
    ParentColor = True
    TabOrder = 2
    ExplicitTop = 149
    ExplicitWidth = 302
    object btnCancel: TBitBtn
      Left = 502
      Top = 6
      Width = 91
      Height = 33
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnOK: TBitBtn
      Left = 405
      Top = 6
      Width = 91
      Height = 33
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnHelp: TBitBtn
      Left = 308
      Top = 6
      Width = 91
      Height = 33
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
  end
  object rbwprsrGlobal: TRbwParser
    Left = 112
    Top = 8
  end
end
