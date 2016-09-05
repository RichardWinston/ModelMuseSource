inherited frmHintDelay: TfrmHintDelay
  Left = 554
  Top = 516
  Width = 329
  Height = 126
  HelpType = htKeyword
  HelpKeyword = 'Hint_Display_Time_Dialog_Box'
  ActiveControl = rdeHintDelay
  AutoScroll = True
  AutoSize = True
  Caption = 'Hint Display Time'
  ExplicitWidth = 329
  ExplicitHeight = 126
  PixelsPerInch = 120
  TextHeight = 18
  object lblHintDisplayTime: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 5
    Width = 136
    Height = 18
    Caption = 'Hint display time (s)'
  end
  object rdeHintDelay: TRbwDataEntry
    AlignWithMargins = True
    Left = 207
    Top = 3
    Width = 101
    Height = 28
    Cursor = crIBeam
    TabOrder = 0
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object btnCancel: TBitBtn
    AlignWithMargins = True
    Left = 219
    Top = 43
    Width = 89
    Height = 33
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object btnOK: TBitBtn
    AlignWithMargins = True
    Left = 123
    Top = 43
    Width = 89
    Height = 33
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnHelp: TBitBtn
    AlignWithMargins = True
    Left = 27
    Top = 43
    Width = 89
    Height = 33
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnHelpClick
  end
end
