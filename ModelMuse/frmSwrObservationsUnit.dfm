inherited frmSwrObservations: TfrmSwrObservations
  HelpType = htKeyword
  HelpKeyword = 'SWR_Observations_Dialog_Box'
  Caption = 'SWR Observations'
  ClientHeight = 351
  ClientWidth = 630
  OnResize = FormResize
  ExplicitWidth = 648
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 18
  object pnlBottom: TPanel
    Left = 0
    Top = 309
    Width = 630
    Height = 42
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      630
      42)
    object btnHelp: TBitBtn
      Left = 359
      Top = 6
      Width = 83
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
    end
    object btnOK: TBitBtn
      Left = 448
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
      Left = 537
      Top = 6
      Width = 83
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  inline frameObservations: TframeGrid
    Left = 0
    Top = 41
    Width = 630
    Height = 268
    Align = alClient
    TabOrder = 1
    ExplicitTop = 41
    ExplicitWidth = 630
    ExplicitHeight = 268
    inherited Panel: TPanel
      Top = 227
      Width = 630
      ExplicitTop = 227
      ExplicitWidth = 630
      inherited lbNumber: TLabel
        Width = 55
        Height = 18
        ExplicitWidth = 55
        ExplicitHeight = 18
      end
      inherited sbAdd: TSpeedButton
        Left = 330
        ExplicitLeft = 219
      end
      inherited sbInsert: TSpeedButton
        Left = 389
        ExplicitLeft = 259
      end
      inherited sbDelete: TSpeedButton
        Left = 451
        ExplicitLeft = 300
      end
      inherited seNumber: TJvSpinEdit
        Height = 26
        ExplicitHeight = 26
      end
    end
    inherited Grid: TRbwDataGrid4
      Width = 630
      Height = 227
      ColCount = 6
      OnMouseUp = frameObservationsGridMouseUp
      OnSelectCell = frameObservationsGridSelectCell
      OnSetEditText = frameObservationsGridSetEditText
      OnColSize = frameObservationsGridColSize
      OnHorizontalScroll = frameObservationsGridHorizontalScroll
      Columns = <
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
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 20
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
            'Stage'
            'Depth'
            'Reach bottom'
            'Flow'
            'Structure'
            'Base flow')
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
          CheckMin = True
          ComboUsed = False
          Format = rcf4Integer
          LimitToList = False
          Max = 1.000000000000000000
          MaxLength = 0
          Min = 1.000000000000000000
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
          CheckMin = True
          ComboUsed = False
          Format = rcf4Integer
          LimitToList = False
          Max = 1.000000000000000000
          MaxLength = 0
          Min = 1.000000000000000000
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
          CheckMin = True
          ComboUsed = False
          Format = rcf4Integer
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end>
      ExplicitWidth = 630
      ExplicitHeight = 227
      ColWidths = (
        64
        119
        64
        64
        64
        64)
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 630
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object comboType: TJvImageComboBox
      Left = 64
      Top = 7
      Width = 145
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
  end
end
