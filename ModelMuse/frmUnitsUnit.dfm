object frmUnits: TfrmUnits
  Left = 399
  Top = 49
  HelpType = htKeyword
  HelpKeyword = 'Title_and_Units_Dialog_Box'
  ActiveControl = memoTitle
  Caption = 'PHAST Title and Units'
  ClientHeight = 572
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  DesignSize = (
    719
    572)
  PixelsPerInch = 120
  TextHeight = 16
  object lblTitle: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 328
    Height = 16
    Caption = 'Title (Only the first two lines will be printed in the output)'
  end
  object lblTimeUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 94
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Time units'
  end
  object lblHorizGridUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 128
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Horizontal grid units'
  end
  object lblVertGridUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 159
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Vertical grid units'
  end
  object lblHeadUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 190
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Head units'
  end
  object lblHydraulicCondLengthUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 221
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Hydraulic conductivity units'
  end
  object lblHydraulicCondTimeUnits: TLabel
    Left = 507
    Top = 221
    Width = 19
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'per'
    ExplicitTop = 277
  end
  object lblSpecificStorageUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 252
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Specific storage units'
  end
  object lblDispersivityUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 283
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Dispersivity units'
  end
  object lblFluxLengthUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 314
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Flux units'
  end
  object lblFluxTimeUnits: TLabel
    Left = 506
    Top = 314
    Width = 19
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'per'
    ExplicitTop = 370
  end
  object lblLeakyHydCondLengthUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 345
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Leaky hydraulic conductivity units'
  end
  object lblLeakyHydCondTimeUnits: TLabel
    Left = 507
    Top = 345
    Width = 19
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'per'
    ExplicitTop = 401
  end
  object lblLeakyThicknessUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 376
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Leaky thickness units'
  end
  object lblWellDiameterUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 407
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Well diameter units'
  end
  object lblWellFlowVolumeUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 438
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Well flow rate units'
  end
  object lblWellFlowTimeUnits: TLabel
    Left = 506
    Top = 438
    Width = 19
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'per'
    ExplicitTop = 494
  end
  object lblRiverHydCondLengthUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 469
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'River bed hydraulic conductivity units'
  end
  object lblRiverHydCondTimeUnits: TLabel
    Left = 506
    Top = 469
    Width = 19
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'per'
    ExplicitTop = 525
  end
  object lblRiverThicknessUnits: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 500
    Width = 300
    Height = 18
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'River bed thickness units'
  end
  object memoTitle: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 35
    Width = 660
    Height = 53
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object btnOK: TBitBtn
    Left = 523
    Top = 534
    Width = 89
    Height = 33
    Anchors = [akLeft, akBottom]
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
    TabOrder = 21
    OnClick = btnOKClick
    ExplicitTop = 590
  end
  object btnCancel: TBitBtn
    Left = 619
    Top = 534
    Width = 91
    Height = 33
    Anchors = [akLeft, akBottom]
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 22
    ExplicitTop = 590
  end
  object comboTimeUnits: TComboBox
    Left = 323
    Top = 91
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    Items.Strings = (
      'seconds'
      'minutes'
      'hours'
      'days'
      'years')
    ExplicitTop = 147
  end
  object comboHorizGridUnits: TComboBox
    Left = 323
    Top = 125
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 2
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 181
  end
  object comboVertGridUnits: TComboBox
    Left = 323
    Top = 156
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 3
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 212
  end
  object comboHeadUnits: TComboBox
    Left = 323
    Top = 187
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 4
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 243
  end
  object comboHydraulicCondLengthUnits: TComboBox
    Left = 323
    Top = 218
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 5
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 274
  end
  object comboHydraulicCondTimeUnits: TComboBox
    Left = 536
    Top = 218
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 6
    Items.Strings = (
      'second'
      'minute'
      'hour'
      'day'
      'year')
    ExplicitTop = 274
  end
  object comboSpecificStorageUnits: TComboBox
    Left = 323
    Top = 249
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 7
    Items.Strings = (
      '1/inches'
      '1/feet'
      '1/miles'
      '1/millimeters'
      '1/centimeters'
      '1/meters'
      '1/kilometers')
    ExplicitTop = 305
  end
  object comboDispersivityUnits: TComboBox
    Left = 323
    Top = 280
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 8
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 336
  end
  object comboFluxLengthUnits: TComboBox
    Left = 323
    Top = 311
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 9
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 367
  end
  object comboFluxTimeUnits: TComboBox
    Left = 536
    Top = 311
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 10
    Items.Strings = (
      'second'
      'minute'
      'hour'
      'day'
      'year')
    ExplicitTop = 367
  end
  object comboLeakyHydCondLengthUnits: TComboBox
    Left = 323
    Top = 342
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 11
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 398
  end
  object comboLeakyHydCondTimeUnits: TComboBox
    Left = 536
    Top = 342
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 12
    Items.Strings = (
      'second'
      'minute'
      'hour'
      'day'
      'year')
    ExplicitTop = 398
  end
  object comboLeakyThicknessUnits: TComboBox
    Left = 323
    Top = 373
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 13
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 429
  end
  object comboWellDiameterUnits: TComboBox
    Left = 323
    Top = 404
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 14
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 460
  end
  object comboWellFlowVolumeUnits: TComboBox
    Left = 323
    Top = 435
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 15
    Items.Strings = (
      'gallons'
      'inches^3'
      'feet^3'
      'miles^3'
      'liters'
      'millimeters^3'
      'centimeters^3'
      'meters^3'
      'kilometers^3')
    ExplicitTop = 491
  end
  object comboWellFlowTimeUnits: TComboBox
    Left = 536
    Top = 435
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 16
    Items.Strings = (
      'second'
      'minute'
      'hour'
      'day'
      'year')
    ExplicitTop = 491
  end
  object comboRiverHydCondLengthUnits: TComboBox
    Left = 323
    Top = 466
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 17
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 522
  end
  object comboRiverHydCondTimeUnits: TComboBox
    Left = 536
    Top = 466
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 18
    Items.Strings = (
      'second'
      'minute'
      'hour'
      'day'
      'year')
    ExplicitTop = 522
  end
  object comboRiverThicknessUnits: TComboBox
    Left = 323
    Top = 497
    Width = 177
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    TabOrder = 19
    Items.Strings = (
      'inches'
      'feet'
      'miles'
      'millimeters'
      'centimeters'
      'meters'
      'kilometers')
    ExplicitTop = 553
  end
  object btnHelp: TBitBtn
    Left = 428
    Top = 534
    Width = 89
    Height = 33
    HelpType = htKeyword
    Anchors = [akLeft, akBottom]
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 20
    OnClick = btnHelpClick
    ExplicitTop = 590
  end
end
