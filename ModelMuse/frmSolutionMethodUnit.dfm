inherited frmSolutionMethod: TfrmSolutionMethod
  Left = 554
  Top = 516
  Width = 355
  Height = 423
  HelpType = htKeyword
  HelpKeyword = 'Solution_Method_Dialog_Box'
  HorzScrollBar.Range = 313
  VertScrollBar.Range = 293
  ActiveControl = rgSolver
  AutoSize = True
  Caption = 'PHAST Solution Method'
  ExplicitWidth = 355
  ExplicitHeight = 423
  PixelsPerInch = 120
  TextHeight = 18
  object lblSpaceDifferencing: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 99
    Width = 131
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Space differencing'
  end
  object lblTimeDifferencing: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 131
    Width = 119
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Time differencing'
  end
  object lblTolerance: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 163
    Width = 67
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Tolerance'
  end
  object lblSaveDirections: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 195
    Width = 108
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Save directions'
  end
  object lblMaximumIterations: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 227
    Width = 135
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Maximum iterations'
  end
  object lblRebalanceFraction: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 258
    Width = 150
    Height = 36
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Rebalance fraction'#13#10'(Parallel PHAST only)'
  end
  object rgSolver: TRadioGroup
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 305
    Height = 49
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Solver'
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'Direct'
      'Iterative')
    TabOrder = 0
    OnClick = rgSolverClick
  end
  object rdeSpaceDifferencing: TRbwDataEntry
    AlignWithMargins = True
    Left = 208
    Top = 96
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    TabOrder = 2
    Text = '0'
    DataType = dtReal
    Max = 0.500000000000000000
    CheckMax = True
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeTimeDifferencing: TRbwDataEntry
    AlignWithMargins = True
    Left = 208
    Top = 128
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    TabOrder = 5
    Text = '1'
    DataType = dtReal
    Max = 1.000000000000000000
    Min = 0.500000000000000000
    CheckMax = True
    CheckMin = True
    ChangeDisabledColor = True
  end
  object cbCrossDispersion: TCheckBox
    AlignWithMargins = True
    Left = 8
    Top = 64
    Width = 217
    Height = 25
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Use cross dispersion'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object btnOK: TBitBtn
    AlignWithMargins = True
    Left = 124
    Top = 335
    Width = 89
    Height = 33
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
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
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    AlignWithMargins = True
    Left = 220
    Top = 335
    Width = 91
    Height = 33
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object rdeTolerance: TRbwDataEntry
    AlignWithMargins = True
    Left = 208
    Top = 160
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    TabOrder = 6
    Text = '0'
    DataType = dtReal
    Max = 0.500000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeSaveDirections: TRbwDataEntry
    AlignWithMargins = True
    Left = 208
    Top = 192
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    TabOrder = 7
    Text = '1'
    DataType = dtInteger
    Max = 1.000000000000000000
    Min = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeMaximumIterations: TRbwDataEntry
    AlignWithMargins = True
    Left = 208
    Top = 224
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    TabOrder = 8
    Text = '1'
    DataType = dtInteger
    Max = 1.000000000000000000
    Min = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object btnHelp: TBitBtn
    AlignWithMargins = True
    Left = 28
    Top = 335
    Width = 89
    Height = 33
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 9
    OnClick = btnHelpClick
  end
  object cbRebalanceByCell: TCheckBox
    AlignWithMargins = True
    Left = 8
    Top = 295
    Width = 321
    Height = 25
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Rebalance by cell (Parallel PHAST only)'
    TabOrder = 10
  end
  object rdeRebalanceFraction: TRbwDataEntry
    AlignWithMargins = True
    Left = 208
    Top = 258
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    TabOrder = 11
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMax = True
    CheckMin = True
    ChangeDisabledColor = True
  end
end
