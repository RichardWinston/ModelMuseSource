inherited frmImportMultipleGriddedDataFiles: TfrmImportMultipleGriddedDataFiles
  HelpType = htKeyword
  HelpKeyword = 'Import_Gridded_Data_Files_Dial'
  Caption = 'Import Gridded Data Files'
  ExplicitWidth = 440
  ExplicitHeight = 264
  PixelsPerInch = 96
  TextHeight = 18
  inline frameGridFiles: TframeGrid
    Left = 0
    Top = 0
    Width = 424
    Height = 143
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 424
    ExplicitHeight = 143
    inherited Panel: TPanel
      Top = 102
      Width = 424
      ExplicitTop = 102
      ExplicitWidth = 424
      inherited lbNumber: TLabel
        Width = 55
        Height = 18
        ExplicitWidth = 55
        ExplicitHeight = 18
      end
      inherited sbAdd: TSpeedButton
        Left = 219
        ExplicitLeft = 219
      end
      inherited sbInsert: TSpeedButton
        Left = 259
        ExplicitLeft = 259
      end
      inherited sbDelete: TSpeedButton
        Left = 300
        ExplicitLeft = 300
      end
      inherited seNumber: TJvSpinEdit
        Height = 26
        ExplicitHeight = 26
      end
    end
    inherited Grid: TRbwDataGrid4
      Width = 424
      Height = 102
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowMoving, goEditing, goAlwaysShowEditor]
      OnButtonClick = frameGridFilesGridButtonClick
      Columns = <
        item
          AutoAdjustRowHeights = False
          ButtonCaption = '...'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
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
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end>
      ExplicitWidth = 424
      ExplicitHeight = 102
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 143
    Width = 424
    Height = 83
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      424
      83)
    object lblModel: TLabel
      Left = 8
      Top = 9
      Width = 43
      Height = 18
      Caption = 'Model'
    end
    object btnHelp: TBitBtn
      Left = 153
      Top = 38
      Width = 83
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnHelpClick
    end
    object btnOK: TBitBtn
      Left = 242
      Top = 38
      Width = 83
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 331
      Top = 38
      Width = 83
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 4
    end
    object btnOpenFiles: TButton
      Left = 8
      Top = 38
      Width = 97
      Height = 33
      Caption = 'Open files'
      TabOrder = 1
      OnClick = btnOpenFilesClick
    end
    object comboModel: TComboBox
      Left = 57
      Top = 6
      Width = 353
      Height = 26
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object dlgOpenFiles: TOpenDialog
    Filter = 'Text files (*.txt)|*.txt|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 168
    Top = 16
  end
end
