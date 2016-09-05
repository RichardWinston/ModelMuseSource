inherited frameColorGrid: TframeColorGrid
  Width = 608
  ExplicitWidth = 608
  inherited pcChoices: TPageControl
    Width = 608
    ExplicitWidth = 608
    inherited tabSelection: TTabSheet
      ExplicitWidth = 600
      DesignSize = (
        600
        397)
      object lblTime: TLabel [2]
        Left = 494
        Top = 4
        Width = 29
        Height = 16
        Anchors = [akTop, akRight]
        Caption = 'Time'
      end
      inherited udDataSets: TJvUpDown
        Left = 473
        Top = 25
        Width = 20
        Height = 24
        Associate = virttreecomboDataSets
        ExplicitLeft = 473
        ExplicitTop = 25
        ExplicitWidth = 20
        ExplicitHeight = 24
      end
      inherited virttreecomboDataSets: TRbwStringTreeCombo
        Tree.OnGetNodeDataSize = virttreecomboDataSetsTreeGetNodeDataSize
        Text = '0'
        ExplicitWidth = 485
      end
      inherited reComment: TRichEdit
        Width = 587
        TabOrder = 4
        ExplicitWidth = 587
      end
      object udTime: TJvUpDown [6]
        Left = 579
        Top = 25
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Max = 0
        TabOrder = 3
        OnChangingEx = udTimeChangingEx
      end
      object comboTime3D: TJvComboBox [7]
        Left = 494
        Top = 25
        Width = 85
        Height = 24
        Anchors = [akTop, akRight]
        TabOrder = 2
        Text = '0'
        OnChange = comboTime3DChange
      end
      inherited Panel1: TPanel
        Width = 600
        TabOrder = 5
        DesignSize = (
          600
          245)
      end
    end
    inherited tabFilters: TTabSheet
      ExplicitWidth = 600
      DesignSize = (
        600
        397)
    end
    inherited tabLegend: TTabSheet
      ExplicitWidth = 600
      inherited imLegend: TImage
        Width = 394
        ExplicitWidth = 395
      end
    end
  end
end
