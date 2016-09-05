inherited frmColors: TfrmColors
  Left = 875
  Top = 432
  HelpType = htKeyword
  HelpKeyword = '3D_Lighting_Controls_Dialog_Box'
  ActiveControl = rdeAmb
  Caption = '3D Lighting Controls'
  ClientHeight = 167
  ClientWidth = 287
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  OnHide = FormHide
  ExplicitWidth = 305
  ExplicitHeight = 214
  PixelsPerInch = 120
  TextHeight = 16
  object lblAmbient: TLabel
    AlignWithMargins = True
    Left = 147
    Top = 35
    Width = 47
    Height = 16
    Caption = 'Ambient'
  end
  object lblDiffuse: TLabel
    AlignWithMargins = True
    Left = 147
    Top = 67
    Width = 39
    Height = 16
    Caption = 'Diffuse'
  end
  object lblSpecular: TLabel
    AlignWithMargins = True
    Left = 147
    Top = 99
    Width = 50
    Height = 16
    Caption = 'Specular'
  end
  object lblLightPosition: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 75
    Height = 16
    Caption = 'Light Position'
  end
  object lblX: TLabel
    AlignWithMargins = True
    Left = 11
    Top = 27
    Width = 8
    Height = 16
    Caption = 'X'
  end
  object lblY: TLabel
    AlignWithMargins = True
    Left = 11
    Top = 67
    Width = 7
    Height = 16
    Caption = 'Y'
  end
  object lblZ: TLabel
    AlignWithMargins = True
    Left = 11
    Top = 99
    Width = 7
    Height = 16
    Caption = 'Z'
  end
  object lblLightIntensity: TLabel
    AlignWithMargins = True
    Left = 179
    Top = 3
    Width = 79
    Height = 16
    Caption = 'Light Intensity'
  end
  object rdeAmb: TRbwDataEntry
    AlignWithMargins = True
    Left = 219
    Top = 27
    Width = 65
    Height = 28
    Cursor = crIBeam
    TabOrder = 3
    Text = '0.3'
    OnChange = rdeValuesChange
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMax = True
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeDiff: TRbwDataEntry
    AlignWithMargins = True
    Left = 219
    Top = 59
    Width = 65
    Height = 28
    Cursor = crIBeam
    TabOrder = 4
    Text = '0.002'
    OnChange = rdeValuesChange
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMax = True
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeSpec: TRbwDataEntry
    AlignWithMargins = True
    Left = 219
    Top = 91
    Width = 65
    Height = 28
    Cursor = crIBeam
    TabOrder = 5
    Text = '0.015'
    OnChange = rdeValuesChange
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMax = True
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeX: TRbwDataEntry
    AlignWithMargins = True
    Left = 35
    Top = 27
    Width = 65
    Height = 28
    Cursor = crIBeam
    TabOrder = 0
    Text = '60'
    OnChange = rdeValuesChange
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object rdeY: TRbwDataEntry
    AlignWithMargins = True
    Left = 35
    Top = 59
    Width = 65
    Height = 28
    Cursor = crIBeam
    TabOrder = 1
    Text = '60'
    OnChange = rdeValuesChange
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object rdeZ: TRbwDataEntry
    AlignWithMargins = True
    Left = 35
    Top = 91
    Width = 65
    Height = 28
    Cursor = crIBeam
    TabOrder = 2
    Text = '40'
    OnChange = rdeValuesChange
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object btnClose: TBitBtn
    AlignWithMargins = True
    Left = 195
    Top = 131
    Width = 89
    Height = 33
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 8
  end
  object btnApply: TButton
    AlignWithMargins = True
    Left = 99
    Top = 131
    Width = 89
    Height = 33
    Caption = 'Apply'
    TabOrder = 7
    OnClick = btnApplyClick
  end
  object btnHelp: TBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 131
    Width = 89
    Height = 33
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 6
    OnClick = btnHelpClick
  end
end
