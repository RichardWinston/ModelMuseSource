inherited frmSwrTabfiles: TfrmSwrTabfiles
  HelpType = htKeyword
  HelpKeyword = 'SWR_Tab_Files_Dialog_Box'
  Caption = 'SWR Tabfiles'
  ClientHeight = 377
  ClientWidth = 782
  OnResize = FormResize
  ExplicitWidth = 798
  ExplicitHeight = 415
  PixelsPerInch = 96
  TextHeight = 18
  object pnlBottom: TPanel
    Left = 0
    Top = 335
    Width = 782
    Height = 42
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      782
      42)
    object btnHelp: TBitBtn
      Left = 511
      Top = 6
      Width = 83
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
    end
    object btnOK: TBitBtn
      Left = 600
      Top = 6
      Width = 83
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 689
      Top = 6
      Width = 83
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  inline frameTabFiles: TframeGrid
    Left = 0
    Top = 41
    Width = 782
    Height = 294
    Align = alClient
    TabOrder = 1
    ExplicitTop = 41
    ExplicitWidth = 782
    ExplicitHeight = 294
    inherited Panel: TPanel
      Top = 253
      Width = 782
      ExplicitTop = 253
      ExplicitWidth = 782
      inherited lbNumber: TLabel
        Width = 55
        Height = 18
        ExplicitWidth = 55
        ExplicitHeight = 18
      end
      inherited sbAdd: TSpeedButton
        Left = 414
        ExplicitLeft = 219
      end
      inherited sbInsert: TSpeedButton
        Left = 487
        ExplicitLeft = 259
      end
      inherited sbDelete: TSpeedButton
        Left = 562
        ExplicitLeft = 300
      end
      inherited seNumber: TJvSpinEdit
        Height = 26
        OnChange = frameTabFilesseNumberChange
        ExplicitHeight = 26
      end
    end
    inherited Grid: TRbwDataGrid4
      Width = 782
      Height = 253
      ColCount = 7
      DefaultColWidth = 100
      FixedCols = 1
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goAlwaysShowEditor]
      OnMouseDown = frameTabFilesGridMouseDown
      OnMouseUp = frameTabFilesGridMouseUp
      OnSelectCell = frameTabFilesGridSelectCell
      OnSetEditText = frameTabFilesGridSetEditText
      OnButtonClick = frameTabFilesGridButtonClick
      OnColSize = frameTabFilesGridColSize
      OnHorizontalScroll = frameTabFilesGridHorizontalScroll
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
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = True
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
          ComboUsed = True
          Format = rcf4String
          LimitToList = True
          MaxLength = 0
          ParentButtonFont = False
          PickList.Strings = (
            'RAIN'
            'EVAP'
            'LATFLOW'
            'STAGE'
            'STRUCTURE'
            'TIME')
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = True
          ButtonCaption = 'Browse'
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
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
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
          ComboUsed = True
          Format = rcf4String
          LimitToList = True
          MaxLength = 0
          ParentButtonFont = False
          PickList.Strings = (
            'Text'
            'Binary')
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = True
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
          ComboUsed = True
          Format = rcf4String
          LimitToList = True
          MaxLength = 0
          ParentButtonFont = False
          PickList.Strings = (
            'NONE'
            'AVERAGE'
            'INTERPOLATE')
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = True
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
          ComboUsed = True
          Format = rcf4String
          LimitToList = True
          MaxLength = 0
          ParentButtonFont = False
          PickList.Strings = (
            'All'
            'Objects'
            'Vertex Value'
            'Reach Numbers')
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = True
          ButtonCaption = 'Edit'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = True
          ButtonWidth = 50
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = True
          WordWrapCells = True
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end>
      ExplicitWidth = 782
      ExplicitHeight = 253
      ColWidths = (
        25
        75
        69
        68
        71
        83
        156)
    end
  end
  object pnlTob: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 41
    Align = alTop
    TabOrder = 0
    object comboType: TJvImageComboBox
      Left = 48
      Top = 7
      Width = 73
      Height = 28
      Style = csOwnerDrawVariable
      ButtonStyle = fsLighter
      Color = clBtnFace
      DroppedWidth = 145
      Enabled = False
      ImageHeight = 0
      ImageWidth = 0
      ItemHeight = 22
      ItemIndex = -1
      TabOrder = 0
      OnChange = comboTypeChange
      Items = <>
    end
    object comboFileType: TJvImageComboBox
      Left = 127
      Top = 7
      Width = 73
      Height = 28
      Style = csOwnerDrawVariable
      ButtonStyle = fsLighter
      Color = clBtnFace
      DroppedWidth = 145
      Enabled = False
      ImageHeight = 0
      ImageWidth = 0
      ItemHeight = 22
      ItemIndex = -1
      TabOrder = 1
      OnChange = comboFileTypeChange
      Items = <>
    end
    object comboInterpolation: TJvImageComboBox
      Left = 206
      Top = 7
      Width = 73
      Height = 28
      Style = csOwnerDrawVariable
      ButtonStyle = fsLighter
      Color = clBtnFace
      DroppedWidth = 145
      Enabled = False
      ImageHeight = 0
      ImageWidth = 0
      ItemHeight = 22
      ItemIndex = -1
      TabOrder = 2
      OnChange = comboInterpolationChange
      Items = <>
    end
    object comboMethod: TJvImageComboBox
      Left = 285
      Top = 7
      Width = 73
      Height = 28
      Style = csOwnerDrawVariable
      ButtonStyle = fsLighter
      Color = clBtnFace
      DroppedWidth = 145
      Enabled = False
      ImageHeight = 0
      ImageWidth = 0
      ItemHeight = 22
      ItemIndex = -1
      TabOrder = 3
      OnChange = comboMethodChange
      Items = <>
    end
  end
  object dlgOpen: TOpenDialog
    DefaultExt = '.txt'
    Filter = 'Text files (*.txt)|*.txt|All Files (*.*)|*.*'
    Left = 128
    Top = 80
  end
end
