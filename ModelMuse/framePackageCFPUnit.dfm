inherited framePackageCFP: TframePackageCFP
  Width = 530
  Height = 507
  ExplicitWidth = 530
  ExplicitHeight = 507
  DesignSize = (
    530
    507)
  inherited memoComments: TMemo
    Width = 499
    Height = 60
    ExplicitWidth = 499
    ExplicitHeight = 60
  end
  object pgcConduits: TPageControl [3]
    Left = 0
    Top = 128
    Width = 530
    Height = 379
    ActivePage = tabCFP
    Align = alBottom
    TabOrder = 1
    object tabCFP: TTabSheet
      Caption = 'CFP'
      object lblLayerTemperature: TLabel
        Left = 163
        Top = 320
        Width = 285
        Height = 16
        Caption = 'Temperature of water in layers (Celsius) (LTEMP)'
      end
      object lblRelaxationParameter: TLabel
        Left = 163
        Top = 269
        Width = 174
        Height = 16
        Caption = 'Relaxation parameter (RELAX)'
      end
      object lblMaxIterations: TLabel
        Left = 163
        Top = 242
        Width = 224
        Height = 16
        Caption = 'Maximum number of iterations (NITER)'
      end
      object lblEpsilon: TLabel
        Left = 163
        Top = 214
        Width = 214
        Height = 16
        Caption = 'Pipe convergence criterion (EPSILON)'
      end
      object lblPipeExchange: TLabel
        Left = 12
        Top = 163
        Width = 316
        Height = 16
        Caption = 'Method used to specify pipe exchange (SA_EXCHANGE)'
      end
      object lblPipeElevationOffset: TLabel
        Left = 163
        Top = 133
        Width = 201
        Height = 16
        Caption = 'Node elevation offset (GEOHEIGHT)'
      end
      object lblElevationChoice: TLabel
        Left = 12
        Top = 82
        Width = 295
        Height = 16
        Caption = 'Method used to specify pipe elevation (GEOHEIGHT)'
      end
      object lblConduitTemperature: TLabel
        Left = 163
        Top = 52
        Width = 329
        Height = 16
        Caption = 'Temperature of water in pipes (Celsius) (TEMPERATURE)'
      end
      object cbPipes: TCheckBox
        Left = 12
        Top = 3
        Width = 361
        Height = 17
        Caption = 'Conduit pipes active (MODE)'
        Color = clBtnFace
        Enabled = False
        ParentColor = False
        TabOrder = 0
        OnClick = cbPipesClick
      end
      object rdeLayerTemperature: TRbwDataEntry
        Left = 12
        Top = 317
        Width = 145
        Height = 22
        Color = clBtnFace
        Enabled = False
        TabOrder = 10
        Text = '0'
        DataType = dtReal
        Max = 100.000000000000000000
        CheckMax = True
        CheckMin = True
        ChangeDisabledColor = True
      end
      object cbPrintIterations: TCheckBox
        Left = 12
        Top = 294
        Width = 268
        Height = 17
        Caption = 'Print solution information (P_NR)'
        Enabled = False
        TabOrder = 9
      end
      object rdeRelaxationParameter: TRbwDataEntry
        Left = 12
        Top = 266
        Width = 145
        Height = 22
        Color = clBtnFace
        Enabled = False
        TabOrder = 8
        Text = '0'
        DataType = dtReal
        Max = 1.000000000000000000
        ChangeDisabledColor = True
      end
      object seMaxIterations: TJvSpinEdit
        Left = 12
        Top = 239
        Width = 145
        Height = 24
        MaxValue = 2147483647.000000000000000000
        MinValue = 1.000000000000000000
        Value = 1.000000000000000000
        Enabled = False
        TabOrder = 7
      end
      object rdeEpsilon: TRbwDataEntry
        Left = 12
        Top = 211
        Width = 145
        Height = 22
        Color = clBtnFace
        Enabled = False
        TabOrder = 6
        Text = '0'
        DataType = dtReal
        Max = 1.000000000000000000
        ChangeDisabledColor = True
      end
      object comboPipeExchange: TJvImageComboBox
        Left = 12
        Top = 182
        Width = 361
        Height = 26
        Style = csOwnerDrawVariable
        ButtonStyle = fsLighter
        Color = clBtnFace
        DroppedWidth = 361
        Enabled = False
        ImageHeight = 0
        ImageWidth = 0
        ItemHeight = 20
        ItemIndex = -1
        TabOrder = 5
        OnChange = comboElevationChoiceChange
        Items = <
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'Pipe conductance (L^2/T) (0)'
          end
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'Conduit wall permeability term (L/T) (1)'
          end>
      end
      object rdePipeElevationOffset: TRbwDataEntry
        Left = 12
        Top = 130
        Width = 145
        Height = 22
        Color = clBtnFace
        Enabled = False
        TabOrder = 4
        Text = '0'
        DataType = dtReal
        Max = 1.000000000000000000
        ChangeDisabledColor = True
      end
      object comboElevationChoice: TJvImageComboBox
        Left = 12
        Top = 101
        Width = 361
        Height = 26
        Style = csOwnerDrawVariable
        ButtonStyle = fsLighter
        Color = clBtnFace
        DroppedWidth = 361
        Enabled = False
        ImageHeight = 0
        ImageWidth = 0
        ItemHeight = 20
        ItemIndex = -1
        TabOrder = 3
        OnChange = comboElevationChoiceChange
        Items = <
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'Specify individually'
          end
          item
            Brush.Style = bsClear
            Indent = 0
            Text = 'Use offset from cell center'
          end>
      end
      object rdeConduitTemperature: TRbwDataEntry
        Left = 12
        Top = 49
        Width = 145
        Height = 22
        Color = clBtnFace
        Enabled = False
        TabOrder = 2
        Text = '0'
        DataType = dtReal
        Max = 100.000000000000000000
        CheckMax = True
        CheckMin = True
        ChangeDisabledColor = True
      end
      object cbLayers: TCheckBox
        Left = 12
        Top = 26
        Width = 369
        Height = 17
        Caption = 'Conduit layers active (MODE)'
        Enabled = False
        TabOrder = 1
        OnClick = cbLayersClick
      end
    end
    object tabCRCH_COC: TTabSheet
      Caption = 'CRCH, COC'
      ImageIndex = 1
      object lblOutputInterval: TLabel
        Left = 12
        Top = 34
        Width = 318
        Height = 16
        Caption = 'Output interval for nodes and conduits (N_NTS, T_NTS)'
      end
      object cbConduitRecharge: TCheckBox
        Left = 12
        Top = 3
        Width = 237
        Height = 17
        Caption = 'Conduit recharge used (CRCH)'
        Enabled = False
        TabOrder = 0
      end
      object seOutputInterval: TJvSpinEdit
        Left = 12
        Top = 56
        Width = 121
        Height = 24
        MaxValue = 2147483647.000000000000000000
        Enabled = False
        TabOrder = 1
      end
    end
  end
  inherited rcSelectionController: TRbwController
    ControlList = <
      item
        Control = lblComments
      end
      item
        Control = memoComments
      end
      item
        Control = cbPipes
      end
      item
      end>
    OnEnabledChange = rcSelectionControllerEnabledChange
  end
end
