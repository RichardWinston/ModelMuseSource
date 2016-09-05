inherited frameScreenObjectLAK: TframeScreenObjectLAK
  Width = 463
  Height = 567
  ExplicitWidth = 463
  ExplicitHeight = 567
  inherited pnlBottom: TPanel
    Top = 310
    Width = 463
    Height = 257
    ExplicitTop = 310
    ExplicitWidth = 463
    ExplicitHeight = 257
    DesignSize = (
      463
      257)
    object lblInitialStage: TLabel [1]
      Left = 79
      Top = 80
      Width = 66
      Height = 16
      Caption = 'Initial stage'
    end
    object lblCenterLake: TLabel [2]
      Left = 362
      Top = 48
      Width = 65
      Height = 16
      Caption = 'Center lake'
    end
    object lblSill: TLabel [3]
      Left = 362
      Top = 80
      Width = 17
      Height = 16
      Caption = 'Sill'
    end
    object lblLakeID: TLabel [4]
      Left = 79
      Top = 48
      Width = 42
      Height = 16
      Caption = 'Lake ID'
    end
    inherited btnDelete: TBitBtn
      Left = 375
      ExplicitLeft = 375
    end
    inherited btnInsert: TBitBtn
      Left = 291
      ExplicitLeft = 291
    end
    object rdeInitialStage: TRbwDataEntry
      Left = 8
      Top = 77
      Width = 65
      Height = 22
      TabOrder = 6
      Text = '0'
      DataType = dtReal
      Max = 1.000000000000000000
      ChangeDisabledColor = True
    end
    object rdeCenterLake: TRbwDataEntry
      Left = 291
      Top = 45
      Width = 65
      Height = 22
      TabOrder = 4
      Text = '0'
      OnChange = rdeCenterLakeChange
      DataType = dtInteger
      Max = 1.000000000000000000
      CheckMin = True
      ChangeDisabledColor = True
    end
    object rdeSill: TRbwDataEntry
      Left = 291
      Top = 73
      Width = 65
      Height = 22
      Color = clBtnFace
      Enabled = False
      TabOrder = 5
      Text = '0'
      DataType = dtReal
      Max = 1.000000000000000000
      ChangeDisabledColor = True
    end
    object rdeLakeID: TRbwDataEntry
      Left = 8
      Top = 45
      Width = 65
      Height = 22
      TabOrder = 3
      Text = '1'
      DataType = dtInteger
      Max = 1.000000000000000000
      Min = 1.000000000000000000
      CheckMin = True
      ChangeDisabledColor = True
    end
    object gbGage: TGroupBox
      Left = 8
      Top = 105
      Width = 449
      Height = 144
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Gage output'
      TabOrder = 7
      DesignSize = (
        449
        144)
      object cbGagStandard: TCheckBox
        Left = 3
        Top = 16
        Width = 430
        Height = 17
        AllowGrayed = True
        Caption = 'Time, stage, volume, and concentration'
        TabOrder = 0
        OnClick = cbGagStandardClick
      end
      object cbGagFluxAndCond: TCheckBox
        Left = 3
        Top = 39
        Width = 443
        Height = 17
        AllowGrayed = True
        Caption = 'Time-step fluxes for lake and total lake conductance'
        Enabled = False
        TabOrder = 1
        OnClick = cbGagFluxAndCondClick
      end
      object cbGagDelta: TCheckBox
        Left = 3
        Top = 62
        Width = 443
        Height = 17
        AllowGrayed = True
        Caption = 'Changes in stage, volume, and concentration for lake'
        Enabled = False
        TabOrder = 2
        OnClick = cbGagDeltaClick
      end
      object cbGage4: TCheckBox
        Left = 3
        Top = 85
        Width = 443
        Height = 56
        AllowGrayed = True
        Anchors = [akLeft, akTop, akRight]
        Caption = 
          'Time, lake stage, lake volume, solute concentration, rate of cha' +
          'nge of lake volume, volumetric rates for all inflows to and outf' +
          'lows from lakes, total lake conductance, and time-step budget er' +
          'ror. '
        TabOrder = 3
        WordWrap = True
        OnClick = cbGage4Click
      end
    end
  end
  inherited pnlTop: TPanel
    Width = 463
    ExplicitWidth = 463
    inherited pnlCaption: TPanel
      Width = 461
      ExplicitWidth = 461
    end
  end
  inherited pnlGrid: TPanel
    Width = 463
    Height = 96
    Align = alTop
    ExplicitWidth = 463
    ExplicitHeight = 96
    inherited pnlEditGrid: TPanel
      Width = 461
      ExplicitWidth = 461
    end
    inherited dgModflowBoundary: TRbwDataGrid4
      Width = 461
      Height = 44
      ColCount = 8
      Columns = <
        item
          AutoAdjustRowHeights = False
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = True
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4Real
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = True
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = True
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = True
        end
        item
          AutoAdjustRowHeights = False
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = False
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = False
        end
        item
          AutoAdjustRowHeights = False
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = False
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = False
        end
        item
          AutoAdjustRowHeights = False
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = False
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = False
        end
        item
          AutoAdjustRowHeights = False
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = False
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = False
        end
        item
          AutoAdjustRowHeights = False
          ButtonCaption = 'F()'
          ButtonFont.Charset = DEFAULT_CHARSET
          ButtonFont.Color = clWindowText
          ButtonFont.Height = -11
          ButtonFont.Name = 'Tahoma'
          ButtonFont.Style = []
          ButtonUsed = False
          ButtonWidth = 35
          CheckMax = False
          CheckMin = False
          ComboUsed = False
          Format = rcf4String
          LimitToList = False
          MaxLength = 0
          ParentButtonFont = False
          WordWrapCaptions = False
          WordWrapCells = False
          CaseSensitivePicklist = False
          CheckStyle = csCheck
          AutoAdjustColWidths = False
        end>
      ExplicitWidth = 461
      ExplicitHeight = 44
    end
  end
  object pcLake: TPageControl
    Left = 0
    Top = 121
    Width = 463
    Height = 189
    ActivePage = tabBathymetry
    Align = alClient
    TabOrder = 3
    object tabLakeProperties: TTabSheet
      Caption = 'Lake Properties'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object tabBathymetry: TTabSheet
      Caption = 'Bathymetry'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object rdgLakeTable: TRbwDataGrid4
        Left = 0
        Top = 105
        Width = 455
        Height = 53
        Align = alClient
        ColCount = 3
        FixedCols = 0
        RowCount = 152
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
        TabOrder = 1
        ExtendedAutoDistributeText = False
        AutoMultiEdit = False
        AutoDistributeText = True
        AutoIncreaseColCount = False
        AutoIncreaseRowCount = False
        SelectedRowOrColumnColor = clAqua
        UnselectableColor = clBtnFace
        ColorRangeSelection = False
        Columns = <
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = True
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = True
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end
          item
            AutoAdjustRowHeights = True
            ButtonCaption = '...'
            ButtonFont.Charset = DEFAULT_CHARSET
            ButtonFont.Color = clWindowText
            ButtonFont.Height = -11
            ButtonFont.Name = 'Tahoma'
            ButtonFont.Style = []
            ButtonUsed = False
            ButtonWidth = 20
            CheckMax = False
            CheckMin = True
            ComboUsed = False
            Format = rcf4Real
            LimitToList = False
            MaxLength = 0
            ParentButtonFont = False
            WordWrapCaptions = True
            WordWrapCells = False
            CaseSensitivePicklist = False
            CheckStyle = csCheck
            AutoAdjustColWidths = True
          end>
        WordWrapRowCaptions = False
        ExplicitHeight = 56
      end
      object pnlBathChoice: TPanel
        Left = 0
        Top = 0
        Width = 455
        Height = 105
        Align = alTop
        TabOrder = 0
        object rgBathChoice: TRadioGroup
          Left = 5
          Top = 3
          Width = 185
          Height = 54
          Caption = 'Bathymetry Choice'
          ItemIndex = 0
          Items.Strings = (
            'Internal'
            'External')
          TabOrder = 0
          OnClick = rgBathChoiceClick
        end
        object feLakeBathymetry: TJvFilenameEdit
          Left = 5
          Top = 63
          Width = 445
          Height = 21
          OnAfterDialog = feLakeBathymetryAfterDialog
          DisabledColor = clBtnFace
          Filter = '(*.lak_bath, *.txt)|*.lak_bath;*.txt|All files (*.*)|*.*'
          Enabled = False
          TabOrder = 1
          OnKeyUp = feLakeBathymetryKeyUp
        end
      end
    end
  end
end
