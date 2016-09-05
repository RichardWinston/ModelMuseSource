inherited frmUpdateDataSets: TfrmUpdateDataSets
  Width = 449
  Height = 216
  AutoScroll = True
  AutoSize = True
  Caption = 'Update Data Sets'
  Font.Height = -21
  ExplicitWidth = 449
  ExplicitHeight = 216
  PixelsPerInch = 120
  TextHeight = 24
  object Label1: TLabel
    AlignWithMargins = True
    Left = 16
    Top = 8
    Width = 407
    Height = 72
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 
      'One or more of the result data sets already exist.  How do you w' +
      'ant this situation to be handled?'
    WordWrap = True
  end
  object btnUpdate: TButton
    AlignWithMargins = True
    Left = 8
    Top = 83
    Width = 194
    Height = 78
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Update the existing data sets with new values'
    ModalResult = 1
    TabOrder = 0
    WordWrap = True
  end
  object btnCreate: TButton
    AlignWithMargins = True
    Left = 221
    Top = 83
    Width = 194
    Height = 78
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Create new data sets'
    ModalResult = 2
    TabOrder = 1
    WordWrap = True
  end
end
