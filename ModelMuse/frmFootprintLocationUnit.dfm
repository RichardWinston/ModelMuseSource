inherited frmFootprintLocation: TfrmFootprintLocation
  AutoSize = True
  HelpType = htKeyword
  HelpKeyword = 'Footprint_Program_Location'
  Caption = 'Footprint Program Location'
  ClientHeight = 175
  ClientWidth = 604
  ExplicitWidth = 620
  ExplicitHeight = 213
  PixelsPerInch = 96
  TextHeight = 18
  object htlblSutra22: TJvHTLabel
    Left = 105
    Top = 17
    Width = 358
    Height = 19
    Caption = 
      '<a href="http://water.usgs.gov/nrp/gwsoftware/sutra/sutra.html">' +
      'http://water.usgs.gov/nrp/gwsoftware/sutra/sutra.html</a>'
    Visible = False
  end
  object lblFootprint: TLabel
    Left = 16
    Top = 17
    Width = 62
    Height = 18
    Caption = 'Footprint'
  end
  object lblTextEditor: TLabel
    Left = 17
    Top = 73
    Width = 71
    Height = 18
    Caption = 'Text editor'
  end
  object fedFootprint: TJvFilenameEdit
    Left = 16
    Top = 38
    Width = 580
    Height = 26
    Filter = 
      'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
      '.*)|*.*'
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = fedFootprintChange
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 134
    Width = 604
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      604
      41)
    object btnHelp: TBitBtn
      Left = 340
      Top = 6
      Width = 82
      Height = 27
      HelpType = htKeyword
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
    object btnOK: TBitBtn
      Left = 428
      Top = 6
      Width = 82
      Height = 27
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 516
      Top = 6
      Width = 83
      Height = 27
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object fedTextEditor: TJvFilenameEdit
    Left = 17
    Top = 94
    Width = 579
    Height = 26
    Filter = 
      'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
      '.*)|*.*'
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    OnChange = fedTextEditorChange
  end
end
