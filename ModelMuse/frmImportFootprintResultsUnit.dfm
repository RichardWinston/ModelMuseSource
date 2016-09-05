inherited frmImportFootprintResults: TfrmImportFootprintResults
  Width = 419
  Height = 257
  HelpType = htKeyword
  HelpKeyword = 'Import_Footprint_Results'
  AutoScroll = True
  AutoSize = True
  Caption = 'Import Footprint Results'
  ExplicitWidth = 419
  ExplicitHeight = 257
  PixelsPerInch = 120
  TextHeight = 18
  object lblColorMesh: TLabel
    Left = 0
    Top = 127
    Width = 153
    Height = 18
    Caption = 'Color or contour mesh'
  end
  object lblDataToImport: TLabel
    Left = 0
    Top = 0
    Width = 99
    Height = 18
    Caption = 'Data to import'
  end
  object chklstDataToImport: TCheckListBox
    Left = 0
    Top = 24
    Width = 401
    Height = 52
    OnClickCheck = chklstDataToImportClickCheck
    ItemHeight = 18
    Items.Strings = (
      'Distributed withdrawals'
      'Footprint code')
    TabOrder = 0
  end
  object rgDisplayChoice: TRadioGroup
    Left = 0
    Top = 79
    Width = 401
    Height = 42
    Caption = 'Display choice'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Color mesh'
      'Contour mesh'
      'Neither')
    TabOrder = 1
  end
  object comboColorContourGrid: TComboBox
    Left = 0
    Top = 148
    Width = 401
    Height = 26
    Style = csDropDownList
    TabOrder = 2
  end
  object btnHelp: TBitBtn
    Left = 142
    Top = 180
    Width = 82
    Height = 30
    Anchors = [akTop, akRight]
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnHelpClick
  end
  object btnOK: TBitBtn
    Left = 230
    Top = 180
    Width = 82
    Height = 30
    Anchors = [akTop, akRight]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 318
    Top = 180
    Width = 83
    Height = 30
    Anchors = [akTop, akRight]
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 5
  end
  object dlgOpenFootprintFile: TJvOpenDialog
    DefaultExt = '.nod'
    Filter = 
      'Footprint output files (*.fpb; *.fpt)|*.fpb; *.fpt|Footprint bin' +
      'ary output files (*.fpb)|*.fpb|Footprint output files (*.fpt)|*.' +
      'fpt'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Height = 0
    Width = 0
    Left = 128
    Top = 104
  end
end
