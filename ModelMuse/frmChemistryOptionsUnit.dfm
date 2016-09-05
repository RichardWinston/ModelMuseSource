inherited frmChemistryOptions: TfrmChemistryOptions
  Left = 554
  Top = 516
  Width = 308
  Height = 344
  HelpType = htKeyword
  HelpKeyword = 'Chemistry_Options_Dialog_Box'
  ActiveControl = cbChemistry
  AutoScroll = True
  AutoSize = True
  Caption = 'PHAST Chemistry Options'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  OldCreateOrder = True
  ExplicitWidth = 308
  ExplicitHeight = 344
  PixelsPerInch = 120
  TextHeight = 16
  object lblDiffusivity: TLabel
    AlignWithMargins = True
    Left = 4
    Top = 231
    Width = 54
    Height = 16
    Caption = 'Diffusivity'
  end
  object cbChemistry: TCheckBox
    AlignWithMargins = True
    Left = 4
    Top = 3
    Width = 273
    Height = 31
    Caption = 'Use solute transport'
    TabOrder = 0
    OnClick = cbChemistryClick
  end
  object cbEquilibriumPhases: TCheckBox
    AlignWithMargins = True
    Left = 4
    Top = 35
    Width = 263
    Height = 31
    Caption = 'Use equilibrium phases'
    TabOrder = 1
  end
  object cbSurface: TCheckBox
    AlignWithMargins = True
    Left = 4
    Top = 67
    Width = 263
    Height = 31
    Caption = 'Use surface assemblages'
    TabOrder = 2
  end
  object cbExchange: TCheckBox
    AlignWithMargins = True
    Left = 4
    Top = 99
    Width = 263
    Height = 31
    Caption = 'Use exchange'
    TabOrder = 3
  end
  object cbGasPhases: TCheckBox
    AlignWithMargins = True
    Left = 4
    Top = 131
    Width = 263
    Height = 31
    Caption = 'Use gas phases'
    TabOrder = 4
  end
  object cbSolidSolution: TCheckBox
    AlignWithMargins = True
    Left = 4
    Top = 163
    Width = 263
    Height = 31
    Caption = 'Use solid solution'
    TabOrder = 5
  end
  object cbKinetics: TCheckBox
    AlignWithMargins = True
    Left = 4
    Top = 195
    Width = 263
    Height = 31
    Caption = 'Use kinetics'
    TabOrder = 6
  end
  object btnOK: TBitBtn
    AlignWithMargins = True
    Left = 100
    Top = 261
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
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 9
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    AlignWithMargins = True
    Left = 196
    Top = 261
    Width = 91
    Height = 33
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 10
  end
  object rdeDiffusivity: TRbwDataEntry
    AlignWithMargins = True
    Left = 101
    Top = 227
    Width = 101
    Height = 28
    Cursor = crIBeam
    TabOrder = 7
    Text = '1e-9'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object btnHelp: TBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 261
    Width = 89
    Height = 33
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 8
    OnClick = btnHelpClick
  end
end
