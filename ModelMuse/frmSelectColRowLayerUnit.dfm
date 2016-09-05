inherited frmSelectColRowLayer: TfrmSelectColRowLayer
  Width = 342
  Height = 196
  HelpType = htKeyword
  HelpKeyword = 'Select_Column_Row_and_Layer'
  ActiveControl = seCol
  AutoScroll = True
  AutoSize = True
  Caption = 'Select Column, Row, and Layer'
  ExplicitWidth = 342
  ExplicitHeight = 196
  PixelsPerInch = 120
  TextHeight = 18
  object lblCol: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 10
    Width = 115
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Selected column'
  end
  object lblRow: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 42
    Width = 91
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Selected row'
  end
  object lblLayer: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 74
    Width = 99
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Selected layer'
  end
  object seCol: TJvSpinEdit
    AlignWithMargins = True
    Left = 152
    Top = 8
    Width = 164
    Height = 26
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ButtonKind = bkClassic
    TabOrder = 0
  end
  object seRow: TJvSpinEdit
    AlignWithMargins = True
    Left = 152
    Top = 40
    Width = 164
    Height = 26
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ButtonKind = bkClassic
    TabOrder = 2
  end
  object seLayer: TJvSpinEdit
    AlignWithMargins = True
    Left = 152
    Top = 72
    Width = 164
    Height = 26
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ButtonKind = bkClassic
    TabOrder = 5
  end
  object btnOK: TBitBtn
    AlignWithMargins = True
    Left = 112
    Top = 108
    Width = 100
    Height = 33
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    AlignWithMargins = True
    Left = 216
    Top = 108
    Width = 100
    Height = 33
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object btnHelp: TBitBtn
    AlignWithMargins = True
    Left = 8
    Top = 108
    Width = 100
    Height = 33
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btnHelpClick
  end
end
