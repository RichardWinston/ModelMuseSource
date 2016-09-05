inherited frmExportModelOutline: TfrmExportModelOutline
  AutoSize = True
  HelpType = htKeyword
  HelpKeyword = 'Export_Model_Outline_Dialog_Bo'
  Caption = 'Export Model Outline'
  ClientHeight = 153
  ClientWidth = 309
  ExplicitWidth = 327
  ExplicitHeight = 198
  PixelsPerInch = 120
  TextHeight = 18
  object rgExportChoice: TRadioGroup
    Left = 8
    Top = 8
    Width = 293
    Height = 93
    Anchors = [akLeft, akTop, akRight]
    Caption = 'What to export'
    ItemIndex = 2
    Items.Strings = (
      'Grid outline'
      'Active cells'
      'Active and inactive cells')
    TabOrder = 0
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 107
    Width = 309
    Height = 46
    Align = alBottom
    ParentColor = True
    TabOrder = 1
    object btnCancel: TBitBtn
      Left = 207
      Top = 6
      Width = 91
      Height = 33
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnOK: TBitBtn
      Left = 110
      Top = 6
      Width = 91
      Height = 33
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnHelp: TBitBtn
      Left = 13
      Top = 6
      Width = 91
      Height = 33
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
  end
  object sdShapefile: TSaveDialog
    DefaultExt = '.shp'
    Filter = 'Shapefiles (*.shp)|*.shp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 96
    Top = 65528
  end
  object xbsShapeFile: TXBase
    Active = False
    AutoUpDate = True
    DebugErr = False
    Deleted = False
    Left = 136
    Top = 65528
  end
end
