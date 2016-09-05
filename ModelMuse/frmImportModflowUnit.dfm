inherited frmImportModflow: TfrmImportModflow
  HelpType = htKeyword
  HelpKeyword = 'Import_MODFLOW_Model_Dialog_Box'
  Caption = 'Import MODFLOW-2005 on -NWT Model'
  ClientHeight = 353
  ClientWidth = 468
  ExplicitWidth = 486
  ExplicitHeight = 400
  PixelsPerInch = 120
  TextHeight = 18
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 54
    Height = 18
    Caption = 'X origin'
  end
  object Label2: TLabel
    Left = 8
    Top = 43
    Width = 52
    Height = 18
    Caption = 'Y origin'
  end
  object Label3: TLabel
    Left = 191
    Top = 11
    Width = 144
    Height = 18
    Caption = 'Grid angle (degrees)'
  end
  object Label4: TLabel
    Left = 8
    Top = 75
    Width = 66
    Height = 18
    Caption = 'Name file'
  end
  object lblWarning: TLabel
    Left = 8
    Top = 160
    Width = 411
    Height = 36
    Caption = 
      'Warning: Importing a model will cause the destruction of the out' +
      'put files of the model; try importing a copy of the model. '
    WordWrap = True
  end
  object lblGridOrigin: TLabel
    Left = 8
    Top = 104
    Width = 73
    Height = 18
    Caption = 'Grid origin'
  end
  object rdeX: TRbwDataEntry
    Left = 89
    Top = 8
    Width = 96
    Height = 22
    TabOrder = 0
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object rdeY: TRbwDataEntry
    Left = 89
    Top = 40
    Width = 96
    Height = 22
    TabOrder = 2
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object rdeGridAngle: TRbwDataEntry
    Left = 346
    Top = 8
    Width = 96
    Height = 22
    TabOrder = 1
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
  end
  object edNameFile: TJvFilenameEdit
    Left = 89
    Top = 72
    Width = 357
    Height = 26
    Filter = 
      'Name files (*.nam, *.mfn, *.modflow.in)|*.nam;*.mfn;*.modflow.in' +
      '|All Files (*.*)|*.*'
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Text = ''
    OnChange = edNameFileChange
  end
  object btnHelp: TBitBtn
    Left = 201
    Top = 239
    Width = 83
    Height = 33
    Anchors = [akTop, akRight]
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 6
    OnClick = btnHelpClick
  end
  object btnOK: TBitBtn
    Left = 290
    Top = 239
    Width = 83
    Height = 33
    Anchors = [akTop, akRight]
    Enabled = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 7
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 377
    Top = 239
    Width = 83
    Height = 33
    Anchors = [akTop, akRight]
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 8
  end
  object sbStatusBar: TStatusBar
    Left = 0
    Top = 327
    Width = 468
    Height = 26
    Panels = <>
    ParentFont = True
    SimplePanel = True
    UseSystemFont = False
  end
  object pbProgress: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 298
    Width = 462
    Height = 29
    Margins.Bottom = 0
    Align = alBottom
    TabOrder = 9
  end
  object cbOldStream: TCheckBox
    Left = 8
    Top = 136
    Width = 411
    Height = 17
    Caption = 'The model is MODFLOW-2005 version 1.10 or older'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object comboGridOrigin: TComboBox
    Left = 89
    Top = 104
    Width = 145
    Height = 26
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 4
    Text = 'Upper left'
    Items.Strings = (
      'Upper left'
      'Lower left')
  end
end
