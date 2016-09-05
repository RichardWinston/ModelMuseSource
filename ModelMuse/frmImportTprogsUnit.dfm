inherited frmImportTprogs: TfrmImportTprogs
  HelpType = htKeyword
  HelpKeyword = 'Import_T_PROGS_File_Dialog_Box'
  Caption = 'Import T-PROGS File'
  ClientHeight = 428
  ClientWidth = 573
  ExplicitWidth = 591
  ExplicitHeight = 475
  PixelsPerInch = 120
  TextHeight = 18
  object lblTprogs: TLabel
    Left = 6
    Top = 8
    Width = 137
    Height = 18
    Caption = 'T-PROGS file name'
  end
  object lblXOrigin: TLabel
    Left = 6
    Top = 160
    Width = 57
    Height = 18
    Caption = 'X Origin'
  end
  object lblDeltaX: TLabel
    Left = 174
    Top = 160
    Width = 52
    Height = 18
    Caption = 'Delta X'
  end
  object lblYOrigin: TLabel
    Left = 6
    Top = 216
    Width = 55
    Height = 18
    Caption = 'Y Origin'
  end
  object lblDeltaY: TLabel
    Left = 174
    Top = 216
    Width = 50
    Height = 18
    Caption = 'Delta Y'
  end
  object lblZOrigin: TLabel
    Left = 6
    Top = 272
    Width = 55
    Height = 18
    Caption = 'Z Origin'
  end
  object lblDeltaZ: TLabel
    Left = 174
    Top = 272
    Width = 50
    Height = 18
    Caption = 'Delta Z'
  end
  object lblAngle: TLabel
    Left = 6
    Top = 328
    Width = 251
    Height = 18
    Caption = 'Angle (counterclockwise in degrees)'
  end
  object fedTprogs: TJvFilenameEdit
    Left = 6
    Top = 32
    Width = 559
    Height = 26
    Filter = 'T-PROGS file (*.bgr)|*.bgr|All files (*.*)|*.*'
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = ''
  end
  object rdeXOrigin: TRbwDataEntry
    Left = 6
    Top = 184
    Width = 153
    Height = 22
    TabOrder = 4
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object rdeDeltaX: TRbwDataEntry
    Left = 174
    Top = 184
    Width = 153
    Height = 22
    TabOrder = 5
    Text = '1'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeYOrigin: TRbwDataEntry
    Left = 6
    Top = 240
    Width = 153
    Height = 22
    TabOrder = 6
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object rdeDeltaY: TRbwDataEntry
    Left = 174
    Top = 240
    Width = 153
    Height = 22
    TabOrder = 7
    Text = '1'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeZOrigin: TRbwDataEntry
    Left = 6
    Top = 296
    Width = 153
    Height = 22
    TabOrder = 8
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object rdeDeltaZ: TRbwDataEntry
    Left = 174
    Top = 296
    Width = 153
    Height = 22
    TabOrder = 9
    Text = '1'
    DataType = dtReal
    Max = 1.000000000000000000
    CheckMin = True
    ChangeDisabledColor = True
  end
  object rdeAngle: TRbwDataEntry
    Left = 6
    Top = 352
    Width = 153
    Height = 22
    TabOrder = 10
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object btnHelp: TBitBtn
    Left = 306
    Top = 388
    Width = 83
    Height = 33
    Anchors = [akTop, akRight]
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 12
    OnClick = btnHelpClick
  end
  object btnOK: TBitBtn
    Left = 395
    Top = 388
    Width = 83
    Height = 33
    Anchors = [akTop, akRight]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 13
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 482
    Top = 388
    Width = 83
    Height = 33
    Anchors = [akTop, akRight]
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 14
  end
  object cbVisible: TCheckBox
    Left = 174
    Top = 356
    Width = 181
    Height = 17
    Margins.Left = 6
    Caption = 'Make objects visible'
    TabOrder = 11
  end
  object rgDataType: TRadioGroup
    Left = 6
    Top = 64
    Width = 153
    Height = 82
    Caption = 'Type of data'
    ItemIndex = 0
    Items.Strings = (
      'Real numbers'
      'Integers')
    TabOrder = 1
  end
  object rgFileType: TRadioGroup
    Left = 165
    Top = 64
    Width = 249
    Height = 82
    Caption = 'File type'
    ItemIndex = 0
    Items.Strings = (
      'Unformatted (Intel Fortran)'
      'True binary')
    TabOrder = 2
  end
  object rgEvaluatedAt: TRadioGroup
    Left = 420
    Top = 64
    Width = 145
    Height = 82
    Caption = 'Evaluated at'
    ItemIndex = 0
    Items.Strings = (
      'Elements'
      'Nodes')
    TabOrder = 3
  end
end
