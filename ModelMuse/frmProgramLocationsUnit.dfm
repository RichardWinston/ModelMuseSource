inherited frmProgramLocations: TfrmProgramLocations
  AutoSize = True
  HelpType = htKeyword
  HelpKeyword = 'MODFLOW_Program_Locations_Dialog_Box'
  Caption = 'MODFLOW Program Locations'
  ClientHeight = 586
  ClientWidth = 623
  ExplicitWidth = 639
  ExplicitHeight = 624
  PixelsPerInch = 96
  TextHeight = 18
  object pnlBottom: TPanel
    Left = 0
    Top = 545
    Width = 623
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      623
      41)
    object btnHelp: TBitBtn
      Left = 359
      Top = 6
      Width = 82
      Height = 27
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
    object btnOK: TBitBtn
      Left = 447
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
      Left = 535
      Top = 6
      Width = 83
      Height = 27
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 545
    Align = alClient
    TabOrder = 0
    object jvrltModflow2005: TJvRollOut
      Left = 1
      Top = 85
      Width = 621
      Height = 84
      Align = alTop
      Caption = 'Modflow 2005'
      ImageOptions.Images = ilShowHide
      TabOrder = 1
      OnExpand = jvrltExpand
      DesignSize = (
        621
        84)
      FAWidth = 145
      FAHeight = 84
      FCWidth = 22
      FCHeight = 22
      object htlblModflow: TJvHTLabel
        Left = 15
        Top = 25
        Width = 355
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/ogw/modflow/MODFLOW.html">http://' +
          'water.usgs.gov/ogw/modflow/MODFLOW.html</a>'
      end
      object fedModflow: TJvFilenameEdit
        Left = 15
        Top = 50
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltModflowLGR: TJvRollOut
      Left = 1
      Top = 169
      Width = 621
      Height = 22
      Align = alTop
      Caption = 'MODFLOW-LGR'
      Collapsed = True
      ImageOptions.Images = ilShowHide
      TabOrder = 2
      OnExpand = jvrltExpand
      DesignSize = (
        621
        22)
      FAWidth = 145
      FAHeight = 82
      FCWidth = 22
      FCHeight = 22
      object JvHTLabel1: TJvHTLabel
        Left = 15
        Top = 25
        Width = 262
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/ogw/modflow-lgr/">http://water.us' +
          'gs.gov/ogw/modflow-lgr/</a>'
      end
      object fedModflowLgr: TJvFilenameEdit
        Left = 15
        Top = 50
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltModflowLgr2: TJvRollOut
      Left = 1
      Top = 191
      Width = 621
      Height = 22
      Align = alTop
      Caption = 'MODFLOW-LGR V2'
      Collapsed = True
      ImageOptions.Images = ilShowHide
      TabOrder = 3
      OnExpand = jvrltExpand
      DesignSize = (
        621
        22)
      FAWidth = 145
      FAHeight = 84
      FCWidth = 22
      FCHeight = 22
      object jvhtlblMfLgr2: TJvHTLabel
        Left = 15
        Top = 25
        Width = 262
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/ogw/modflow-lgr/">http://water.us' +
          'gs.gov/ogw/modflow-lgr/</a>'
      end
      object fedModflowLgr2: TJvFilenameEdit
        Left = 15
        Top = 50
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltModflowNWT: TJvRollOut
      Left = 1
      Top = 213
      Width = 621
      Height = 22
      Align = alTop
      Caption = 'MODFLOW-NWT'
      Collapsed = True
      ImageOptions.Images = ilShowHide
      TabOrder = 4
      OnExpand = jvrltExpand
      DesignSize = (
        621
        22)
      FAWidth = 145
      FAHeight = 80
      FCWidth = 22
      FCHeight = 22
      object htlblModflowNWT: TJvHTLabel
        Left = 15
        Top = 25
        Width = 268
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/ogw/modflow-nwt/">http://water.us' +
          'gs.gov/ogw/modflow-nwt/</a>'
      end
      object fedModflowNWT: TJvFilenameEdit
        Left = 15
        Top = 50
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltModpath: TJvRollOut
      Left = 1
      Top = 279
      Width = 621
      Height = 22
      Align = alTop
      Caption = 'MODPATH'
      Collapsed = True
      ImageOptions.Images = ilShowHide
      TabOrder = 7
      OnExpand = jvrltExpand
      DesignSize = (
        621
        22)
      FAWidth = 145
      FAHeight = 80
      FCWidth = 22
      FCHeight = 22
      object htlblModPath: TJvHTLabel
        Left = 15
        Top = 25
        Width = 430
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/nrp/gwsoftware/modpath5/modpath5.' +
          'html">http://water.usgs.gov/nrp/gwsoftware/modpath5/modpath5.htm' +
          'l</a>'
      end
      object fedModpath: TJvFilenameEdit
        Left = 15
        Top = 50
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltZoneBudget: TJvRollOut
      Left = 1
      Top = 301
      Width = 621
      Height = 22
      Align = alTop
      Caption = 'ZONEBUDGET'
      Collapsed = True
      ImageOptions.Images = ilShowHide
      TabOrder = 8
      OnExpand = jvrltExpand
      DesignSize = (
        621
        22)
      FAWidth = 145
      FAHeight = 84
      FCWidth = 22
      FCHeight = 22
      object htlblZoneBudger: TJvHTLabel
        Left = 15
        Top = 25
        Width = 448
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/nrp/gwsoftware/zonebud3/zonebudge' +
          't3.html">http://water.usgs.gov/nrp/gwsoftware/zonebud3/zonebudge' +
          't3.html</a>'
      end
      object fedZonebudget: TJvFilenameEdit
        Left = 15
        Top = 50
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltMt3dms: TJvRollOut
      Left = 1
      Top = 323
      Width = 621
      Height = 22
      Align = alTop
      Caption = 'MT3DMS'
      Collapsed = True
      ImageOptions.Images = ilShowHide
      TabOrder = 9
      OnExpand = jvrltExpand
      DesignSize = (
        621
        22)
      FAWidth = 145
      FAHeight = 84
      FCWidth = 22
      FCHeight = 22
      object htlblMt3dms: TJvHTLabel
        Left = 15
        Top = 25
        Width = 200
        Height = 19
        Caption = 
          '<a href="http://hydro.geo.ua.edu/mt3d/">http://hydro.geo.ua.edu/' +
          'mt3d/</a>'
      end
      object fedMt3dms: TJvFilenameEdit
        Left = 15
        Top = 50
        Width = 588
        Height = 26
        Filter = 'Executables (*.exe)|*.exe|All files (*.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltModelMate: TJvRollOut
      Left = 1
      Top = 345
      Width = 621
      Height = 22
      Align = alTop
      Caption = 'ModelMate'
      Collapsed = True
      ImageOptions.Images = ilShowHide
      TabOrder = 10
      OnExpand = jvrltExpand
      DesignSize = (
        621
        22)
      FAWidth = 145
      FAHeight = 84
      FCWidth = 22
      FCHeight = 22
      object htlblModelMate: TJvHTLabel
        Left = 15
        Top = 25
        Width = 290
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/software/ModelMate/">http://water' +
          '.usgs.gov/software/ModelMate/</a>'
      end
      object fedModelMate: TJvFilenameEdit
        Left = 15
        Top = 50
        Width = 588
        Height = 26
        Filter = 'Executables (*.exe)|*.exe|All files (*.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltTextEditor: TJvRollOut
      Left = 1
      Top = 367
      Width = 621
      Height = 56
      Align = alTop
      Caption = 'Text editor'
      ImageOptions.Images = ilShowHide
      TabOrder = 11
      OnExpand = jvrltExpand
      DesignSize = (
        621
        56)
      FAWidth = 145
      FAHeight = 56
      FCWidth = 22
      FCHeight = 22
      object fedTextEditor: TJvFilenameEdit
        Left = 15
        Top = 24
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltModelMonitor: TJvRollOut
      Left = 1
      Top = 423
      Width = 621
      Height = 56
      Align = alTop
      Caption = 'ModelMonitor'
      ImageOptions.Images = ilShowHide
      TabOrder = 12
      OnExpand = jvrltExpand
      DesignSize = (
        621
        56)
      FAWidth = 145
      FAHeight = 56
      FCWidth = 22
      FCHeight = 22
      object fedModelMonitor: TJvFilenameEdit
        Left = 15
        Top = 24
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltModflowFmp: TJvRollOut
      Left = 1
      Top = 257
      Width = 621
      Height = 22
      Align = alTop
      Caption = 'MF2005-OWHM'
      Collapsed = True
      ImageOptions.Images = ilShowHide
      TabOrder = 6
      DesignSize = (
        621
        22)
      FAWidth = 145
      FAHeight = 120
      FCWidth = 22
      FCHeight = 22
      object htlblModflowFmp: TJvHTLabel
        Left = 15
        Top = 25
        Width = 286
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/ogw/modflow-owhm/">http://water.u' +
          'sgs.gov/ogw/modflow-owhm/</a>'
      end
      object htlbl1: TJvHTLabel
        Left = 15
        Top = 55
        Width = 356
        Height = 19
        Caption = 
          '<a href="https://sourceforge.net/projects/modflow-owhm/files/">h' +
          'ttps://sourceforge.net/projects/modflow-owhm/files/</a>'
      end
      object fedModflowFmp: TJvFilenameEdit
        Left = 15
        Top = 80
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltModflowCFP: TJvRollOut
      Left = 1
      Top = 235
      Width = 621
      Height = 22
      Align = alTop
      Caption = 'MF2005-CFP'
      Collapsed = True
      ImageOptions.Images = ilShowHide
      TabOrder = 5
      DesignSize = (
        621
        22)
      FAWidth = 145
      FAHeight = 82
      FCWidth = 22
      FCHeight = 22
      object htlblModflowCFP: TJvHTLabel
        Left = 15
        Top = 25
        Width = 253
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/ogw/cfp/cfp.htm">http://water.usg' +
          's.gov/ogw/cfp/cfp.htm</a>'
      end
      object fedModflowCFP: TJvFilenameEdit
        Left = 15
        Top = 48
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
    object jvrltModflow6: TJvRollOut
      Left = 1
      Top = 1
      Width = 621
      Height = 84
      Align = alTop
      Caption = 'Modflow 6'
      ImageOptions.Images = ilShowHide
      TabOrder = 0
      OnExpand = jvrltExpand
      DesignSize = (
        621
        84)
      FAWidth = 145
      FAHeight = 84
      FCWidth = 22
      FCHeight = 22
      object htlblModflow6: TJvHTLabel
        Left = 15
        Top = 25
        Width = 355
        Height = 19
        Caption = 
          '<a href="http://water.usgs.gov/ogw/modflow/MODFLOW.html">http://' +
          'water.usgs.gov/ogw/modflow/MODFLOW.html</a>'
      end
      object fedModflow6: TJvFilenameEdit
        Left = 15
        Top = 50
        Width = 588
        Height = 26
        Filter = 
          'Executables (*.exe)|*.exe|Batch Files (*.bat)|*.bat|All files (*' +
          '.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = fedModflowChange
      end
    end
  end
  object ilShowHide: TImageList
    Height = 12
    Width = 12
    Left = 448
    Top = 48
    Bitmap = {
      494C01010200050010000C000C00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000300000000C00000001002000000000000009
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000808080008080
      80008080800080808000808080008080800080808000C0C0C000000000000000
      000000000000C0C0C00080808000808080008080800080808000808080008080
      800080808000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000808080008080
      80008080800080808000808080008080800080808000C0C0C000000000000000
      000000000000C0C0C00080808000808080008080800080808000808080008080
      800080808000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000300000000C0000000100010000000000600000000000000000000000
      000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000
      8038030000000000BFBBFB0000000000BFBBBB0000000000BFBBBB0000000000
      A0BA0B0000000000BFBBBB0000000000BFBBBB0000000000BFBBFB0000000000
      8038030000000000FFFFFF000000000000000000000000000000000000000000
      000000000000}
  end
end
