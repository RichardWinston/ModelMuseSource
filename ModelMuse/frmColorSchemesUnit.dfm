inherited frmColorSchemes: TfrmColorSchemes
  HelpType = htKeyword
  HelpKeyword = 'Custom_Color_Schemes_Dialog_Bo'
  Caption = 'Custom Color Schemes'
  ClientHeight = 442
  ClientWidth = 432
  ExplicitWidth = 450
  ExplicitHeight = 489
  PixelsPerInch = 120
  TextHeight = 18
  object spl1: TSplitter
    Left = 137
    Top = 0
    Width = 5
    Height = 401
    ExplicitHeight = 266
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 401
    Width = 432
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      432
      41)
    object btnHelp: TBitBtn
      Left = 93
      Top = 4
      Width = 108
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
    object btnOK: TBitBtn
      Left = 207
      Top = 4
      Width = 108
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 321
      Top = 4
      Width = 108
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object pnlSelect: TPanel
    Left = 0
    Top = 0
    Width = 137
    Height = 401
    Align = alLeft
    TabOrder = 0
    object grdpnl1: TGridPanel
      Left = 1
      Top = 368
      Width = 135
      Height = 32
      Align = alBottom
      ColumnCollection = <
        item
          Value = 33.333333333333330000
        end
        item
          Value = 33.333333333333330000
        end
        item
          Value = 33.333333333333330000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = btnAdd
          Row = 0
        end
        item
          Column = 1
          Control = btnInsertUnit
          Row = 0
        end
        item
          Column = 2
          Control = btnDeleteUnit
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 1
      DesignSize = (
        135
        32)
      object btnAdd: TSpeedButton
        Left = 11
        Top = 5
        Width = 23
        Height = 22
        Hint = 
          'Add custom color scheme|Add a  custom color scheme after the las' +
          't custom color scheme.'
        Anchors = []
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF00000000000FF0FF0CCCCCCCCC0F000F0CCCCCCC
          CC0FF0FF0CCCCCCCCC0FFFFF00000000000FFFFF0FFFFFFFFF0FFFFF0FFFFFFF
          FF0FFFFF0FFFFFFFFF0FFFFF00000000000FFFFF0FFFFFFFFF0FFFFF0FFFFFFF
          FF0FFFFF0FFFFFFFFF0FFFFF00000000000FFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnAddClick
        ExplicitTop = 6
      end
      object btnInsertUnit: TSpeedButton
        Left = 55
        Top = 5
        Width = 23
        Height = 22
        Hint = 
          'Insert custom color scheme|Insert a custom color scheme above th' +
          'e selected custom color scheme.'
        Anchors = []
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF00000000000FFFFF0FFFFFFFFF0FFFFF0FFFFFFF
          FF0FFFFF0FFFFFFFFF0FFFFF00000000000FF0FF0CCCCCCCCC0F000F0CCCCCCC
          CC0FF0FF0CCCCCCCCC0FFFFF00000000000FFFFF0FFFFFFFFF0FFFFF0FFFFFFF
          FF0FFFFF0FFFFFFFFF0FFFFF00000000000FFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnInsertUnitClick
        ExplicitLeft = 48
        ExplicitTop = 15
      end
      object btnDeleteUnit: TSpeedButton
        Left = 100
        Top = 5
        Width = 23
        Height = 22
        Hint = 
          'Delete a custom color scheme|Delete the selected custom color sc' +
          'heme.'
        Anchors = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000FFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
          0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
          0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF
          000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnDeleteUnitClick
        ExplicitLeft = 107
        ExplicitTop = 6
      end
    end
    object tvColorSchemes: TTreeView
      Left = 1
      Top = 1
      Width = 135
      Height = 367
      Align = alClient
      HideSelection = False
      Indent = 20
      MultiSelect = True
      ReadOnly = True
      TabOrder = 0
      OnChange = tvColorSchemesChange
    end
  end
  object pnlColorScheme: TPanel
    Left = 142
    Top = 0
    Width = 290
    Height = 401
    HelpType = htKeyword
    HelpKeyword = 'Custom_Color_Schemes_Dialog_Bo'
    Align = alClient
    TabOrder = 1
    inline frameColorScheme: TframeGrid
      Left = 1
      Top = 42
      Width = 288
      Height = 358
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 48
      ExplicitWidth = 288
      ExplicitHeight = 371
      inherited Panel: TPanel
        Top = 317
        Width = 288
        ExplicitTop = 358
        ExplicitWidth = 288
        inherited lbNumber: TLabel
          Width = 55
          Height = 18
          ExplicitWidth = 55
          ExplicitHeight = 18
        end
        inherited sbAdd: TSpeedButton
          Left = 145
          Hint = 
            'Add a new color and fraction|Add a new color and fraction after ' +
            'the last one.'
          ExplicitLeft = 141
        end
        inherited sbInsert: TSpeedButton
          Left = 173
          Hint = 
            'Insert a new color and fraction|Insert a new color and fraction ' +
            'above the selected one.'
          ExplicitLeft = 168
        end
        inherited sbDelete: TSpeedButton
          Left = 200
          Hint = 
            'Delete selected color and fraction|Delete the selected color and' +
            ' fraction.'
          ExplicitLeft = 195
        end
        inherited seNumber: TJvSpinEdit
          Height = 26
          ExplicitHeight = 26
        end
      end
      inherited Grid: TRbwDataGrid4
        Width = 288
        Height = 317
        ColCount = 2
        DefaultColWidth = 90
        OnBeforeDrawCell = frameColorSchemeGridBeforeDrawCell
        OnButtonClick = frameColorSchemeGridButtonClick
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
            CheckMax = True
            CheckMin = True
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            Max = 1.000000000000000000
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
            ButtonFont.Height = -13
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = True
            ButtonWidth = 20
            CheckMax = False
            CheckMin = True
            ComboUsed = False
            Format = rcf4Integer
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = False
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end>
        ExplicitTop = 72
        ExplicitWidth = 288
        ExplicitHeight = 286
        ColWidths = (
          90
          90)
        RowHeights = (
          24
          24)
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 288
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = 65
      ExplicitWidth = 185
      DesignSize = (
        288
        41)
      object edName: TLabeledEdit
        Left = 5
        Top = 8
        Width = 212
        Height = 26
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 42
        EditLabel.Height = 18
        EditLabel.Caption = 'Name'
        LabelPosition = lpRight
        TabOrder = 0
        OnChange = edNameChange
      end
    end
  end
  object dlgColor: TColorDialog
    Left = 152
    Top = 128
  end
end
