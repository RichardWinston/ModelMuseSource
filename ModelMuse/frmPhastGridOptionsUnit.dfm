inherited frmPhastGridOptions: TfrmPhastGridOptions
  Left = 558
  Top = 536
  Width = 305
  Height = 310
  HelpType = htKeyword
  HelpKeyword = 'Grid_Options_Dialog_Box'
  ActiveControl = clbChemistryDimensions
  AutoScroll = True
  AutoSize = True
  Caption = 'PHAST Grid Options'
  ExplicitWidth = 305
  ExplicitHeight = 310
  PixelsPerInch = 120
  TextHeight = 18
  object lblChemistrDimensions: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 158
    Height = 18
    Caption = 'Chemistry dimensions '
  end
  object clbChemistryDimensions: TCheckListBox
    AlignWithMargins = True
    Left = 3
    Top = 27
    Width = 281
    Height = 81
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 18
    Items.Strings = (
      'X'
      'Y'
      'Z')
    TabOrder = 0
  end
  object rgPrintOrientation: TRadioGroup
    AlignWithMargins = True
    Left = 3
    Top = 115
    Width = 281
    Height = 105
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Print orientation'
    ItemIndex = 0
    Items.Strings = (
      'XY'
      'XZ')
    TabOrder = 1
  end
  object btnOK: TBitBtn
    AlignWithMargins = True
    Left = 99
    Top = 227
    Width = 89
    Height = 33
    Caption = 'OK'
    Default = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      04000000000068010000120B0000120B00001000000010000000000000000000
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
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    AlignWithMargins = True
    Left = 195
    Top = 227
    Width = 89
    Height = 33
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object btnHelp: TBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 226
    Width = 89
    Height = 33
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnHelpClick
  end
end
