inherited frmCustomImportSimpleFile: TfrmCustomImportSimpleFile
  Left = 541
  Top = 541
  Width = 577
  Height = 304
  HelpType = htKeyword
  HorzScrollBar.Range = 555
  VertScrollBar.Range = 217
  ActiveControl = comboDataSets
  AutoSize = True
  Caption = 'frmCustomImportSimpleFile'
  ExplicitWidth = 577
  ExplicitHeight = 304
  PixelsPerInch = 120
  TextHeight = 18
  object lblDataSet: TLabel
    Left = 8
    Top = 0
    Width = 62
    Height = 18
    Caption = 'Data Set'
  end
  object lblInterpolator: TLabel
    Left = 8
    Top = 56
    Width = 77
    Height = 18
    Caption = 'Interpolator'
  end
  object comboDataSets: TComboBox
    Left = 8
    Top = 24
    Width = 551
    Height = 26
    Style = csDropDownList
    TabOrder = 0
    OnChange = comboDataSetsChange
  end
  object comboInterpolators: TComboBox
    Left = 8
    Top = 77
    Width = 257
    Height = 26
    Style = csDropDownList
    TabOrder = 1
    OnChange = comboInterpolatorsChange
  end
  object cbEnclosedCells: TCheckBox
    Left = 8
    Top = 109
    Width = 395
    Height = 31
    Caption = 'Set values of enclosed elements'
    TabOrder = 2
    OnClick = cbEnclosedCellsClick
  end
  object cbIntersectedCells: TCheckBox
    Left = 8
    Top = 141
    Width = 395
    Height = 31
    Caption = 'Set values of intersected elements'
    TabOrder = 3
    OnClick = cbEnclosedCellsClick
  end
  object cbInterpolation: TCheckBox
    Left = 8
    Top = 173
    Width = 465
    Height = 31
    Caption = 'Set values of elements by interpolation'
    TabOrder = 4
    OnClick = cbEnclosedCellsClick
  end
  object rgEvaluatedAt: TRadioGroup
    Left = 0
    Top = 208
    Width = 257
    Height = 49
    Caption = 'Evaluated at'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Elements'
      'Nodes')
    TabOrder = 5
    OnClick = rgEvaluatedAtClick
  end
  object btnOK: TBitBtn
    Left = 360
    Top = 220
    Width = 91
    Height = 33
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 7
  end
  object btnCancel: TBitBtn
    Left = 456
    Top = 220
    Width = 91
    Height = 33
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 8
  end
  object btnHelp: TBitBtn
    Left = 264
    Top = 220
    Width = 91
    Height = 33
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 6
    OnClick = btnHelpClick
  end
  object OpenDialogFile: TOpenDialog
    Filter = 'DXF files (*.dxf)|*.dxf;*.DXF'
    FilterIndex = 0
    Title = 'Open a DXF file'
    Left = 64
    Top = 88
  end
end
