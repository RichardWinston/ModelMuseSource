inherited frmSteadyFlow: TfrmSteadyFlow
  Left = 366
  Top = 676
  Width = 631
  Height = 301
  HelpType = htKeyword
  HelpKeyword = 'Steady_Flow_Dialog_Box'
  ActiveControl = cbSteadyFlow
  AutoScroll = True
  AutoSize = True
  Caption = 'PHAST Steady Flow'
  ExplicitWidth = 631
  ExplicitHeight = 301
  PixelsPerInch = 120
  TextHeight = 18
  object lblHeadTolerance: TLabel
    AlignWithMargins = True
    Left = 296
    Top = 13
    Width = 106
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Head tolerance'
    Enabled = False
  end
  object lblFlowBalanceTolerance: TLabel
    AlignWithMargins = True
    Left = 296
    Top = 45
    Width = 160
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Flow balance tolerance'
    Enabled = False
  end
  object lblMinTimeStep: TLabel
    AlignWithMargins = True
    Left = 296
    Top = 109
    Width = 131
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Minimum time step'
    Enabled = False
  end
  object lblMaxTimeStep: TLabel
    AlignWithMargins = True
    Left = 296
    Top = 141
    Width = 135
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Maximum time step'
    Enabled = False
  end
  object lblHeadChangeLimit: TLabel
    AlignWithMargins = True
    Left = 296
    Top = 173
    Width = 137
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Head change target'
    Enabled = False
  end
  object lblIterations: TLabel
    AlignWithMargins = True
    Left = 296
    Top = 77
    Width = 63
    Height = 18
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Iterations'
    Enabled = False
  end
  object cbSteadyFlow: TCheckBox
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 129
    Height = 31
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Steady flow'
    TabOrder = 0
    OnClick = cbSteadyFlowClick
  end
  object rdeHeadTolerance: TRbwDataEntry
    AlignWithMargins = True
    Left = 504
    Top = 9
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Color = clBtnFace
    Enabled = False
    TabOrder = 1
    Text = '10e-5'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeFlowBalanceTolerance: TRbwDataEntry
    AlignWithMargins = True
    Left = 504
    Top = 41
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Color = clBtnFace
    Enabled = False
    TabOrder = 2
    Text = '0.001'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeMinTimeStep: TRbwDataEntry
    AlignWithMargins = True
    Left = 504
    Top = 105
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Color = clBtnFace
    Enabled = False
    TabOrder = 8
    Text = '1'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeMaxTimeStep: TRbwDataEntry
    AlignWithMargins = True
    Left = 504
    Top = 137
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Color = clBtnFace
    Enabled = False
    TabOrder = 12
    Text = '1000'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeHeadChangeLimit: TRbwDataEntry
    AlignWithMargins = True
    Left = 504
    Top = 169
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Color = clBtnFace
    Enabled = False
    TabOrder = 3
    Text = '1'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object btnOK: TBitBtn
    AlignWithMargins = True
    Left = 416
    Top = 213
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
    NumGlyphs = 2
    TabOrder = 6
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    AlignWithMargins = True
    Left = 512
    Top = 213
    Width = 91
    Height = 33
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 7
  end
  object cbDefaultMinTimeStep: TCheckBox
    AlignWithMargins = True
    Left = 8
    Top = 104
    Width = 241
    Height = 31
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Default minimum time step'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 5
    OnClick = cbDefaultMinTimeStepClick
  end
  object cbDefaultMaxTimeStep: TCheckBox
    AlignWithMargins = True
    Left = 8
    Top = 136
    Width = 241
    Height = 31
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Default maximum time step'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 9
    OnClick = cbDefaultMaxTimeStepClick
  end
  object cbDefaultHeadChangeLimit: TCheckBox
    AlignWithMargins = True
    Left = 8
    Top = 168
    Width = 241
    Height = 31
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Default head change target'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 10
    OnClick = cbDefaultHeadChangeLimitClick
  end
  object btnHelp: TBitBtn
    AlignWithMargins = True
    Left = 320
    Top = 213
    Width = 89
    Height = 33
    HelpType = htKeyword
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 11
    OnClick = btnHelpClick
  end
  object rdeIterations: TRbwDataEntry
    AlignWithMargins = True
    Left = 504
    Top = 73
    Width = 101
    Height = 28
    Cursor = crIBeam
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Color = clBtnFace
    Enabled = False
    TabOrder = 4
    Text = '100'
    DataType = dtInteger
    Max = 100000.000000000000000000
    Min = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
end
