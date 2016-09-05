inherited frmGridAngle: TfrmGridAngle
  Left = 672
  Top = 486
  Width = 345
  Height = 126
  HelpType = htKeyword
  HelpKeyword = 'Grid_Angle_Dialog_Box'
  ActiveControl = rdeGridAngle
  AutoScroll = True
  AutoSize = True
  Caption = 'Grid Angle'
  ExplicitWidth = 345
  ExplicitHeight = 126
  PixelsPerInch = 120
  TextHeight = 18
  object lblGridAngle: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 6
    Width = 76
    Height = 18
    Caption = 'Grid angle:'
  end
  object rdeGridAngle: TRbwDataEntry
    AlignWithMargins = True
    Left = 115
    Top = 3
    Width = 209
    Height = 28
    Cursor = crIBeam
    Color = clWhite
    TabOrder = 0
    Text = '0'
    OnChange = rdeGridAngleChange
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object btnOK: TBitBtn
    AlignWithMargins = True
    Left = 139
    Top = 43
    Width = 91
    Height = 33
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    AlignWithMargins = True
    Left = 235
    Top = 43
    Width = 89
    Height = 33
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object btnHelp: TBitBtn
    AlignWithMargins = True
    Left = 43
    Top = 43
    Width = 91
    Height = 33
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnHelpClick
  end
end
