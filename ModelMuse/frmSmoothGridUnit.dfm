inherited frmSmoothGrid: TfrmSmoothGrid
  Left = 672
  Top = 476
  Width = 318
  Height = 144
  HelpType = htKeyword
  HelpKeyword = 'Smooth_Grid_Dialog_Box'
  ActiveControl = cbColumns
  AutoScroll = True
  AutoSize = True
  Caption = 'Smooth Grid'
  ExplicitWidth = 318
  ExplicitHeight = 144
  PixelsPerInch = 120
  TextHeight = 18
  object lblCriterion: TLabel
    Left = 0
    Top = 36
    Width = 166
    Height = 18
    Caption = 'Grid smoothing criterion'
  end
  object cbColumns: TCheckBox
    Left = 0
    Top = 0
    Width = 100
    Height = 30
    Caption = 'Columns'
    TabOrder = 0
    OnClick = cbClick
  end
  object cbRows: TCheckBox
    Left = 112
    Top = 0
    Width = 81
    Height = 30
    Caption = 'Rows'
    TabOrder = 1
    OnClick = cbClick
  end
  object cbLayers: TCheckBox
    Left = 200
    Top = 0
    Width = 100
    Height = 30
    Caption = 'Layers'
    TabOrder = 2
    OnClick = cbClick
  end
  object rdeCriterion: TRbwDataEntry
    Left = 200
    Top = 32
    Width = 100
    Height = 28
    Cursor = crIBeam
    Color = clWhite
    TabOrder = 4
    Text = '1.2'
    DataType = dtReal
    Max = 1.000000000000000000
    Min = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object btnCancel: TBitBtn
    Left = 209
    Top = 64
    Width = 91
    Height = 33
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object btnOK: TBitBtn
    Left = 113
    Top = 64
    Width = 91
    Height = 33
    Enabled = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 6
    OnClick = btnOKClick
  end
  object btnHelp: TBitBtn
    Left = 17
    Top = 64
    Width = 91
    Height = 33
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 5
    OnClick = btnHelpClick
  end
end
