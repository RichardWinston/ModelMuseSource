inherited frameContourData: TframeContourData
  Height = 501
  ExplicitHeight = 501
  inherited pcChoices: TPageControl
    Height = 501
    ExplicitHeight = 501
    inherited tabSelection: TTabSheet
      ExplicitHeight = 470
      DesignSize = (
        562
        470)
      object lblContourInterval: TLabel [2]
        Left = 444
        Top = 60
        Width = 92
        Height = 16
        Caption = 'Contour Interval'
      end
      inherited udDataSets: TJvUpDown
        Left = 319
        Top = 23
        TabOrder = 2
        ExplicitLeft = 319
        ExplicitTop = 23
      end
      inherited virttreecomboDataSets: TRbwStringTreeCombo
        Top = 20
        Width = 305
        Tree.OnGetNodeDataSize = virttreecomboDataSetsTreeGetNodeDataSize
        TabOrder = 1
        ExplicitTop = 20
        ExplicitWidth = 305
      end
      inherited reComment: TRichEdit
        Height = 62
        TabOrder = 5
        ExplicitHeight = 62
      end
      object btnEditContours: TButton [6]
        Left = 443
        Top = 23
        Width = 119
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Edit contours...'
        Enabled = False
        TabOrder = 3
        OnClick = btnEditContoursClick
      end
      object cbSpecifyContours: TJvCheckBox [7]
        Left = 342
        Top = 13
        Width = 96
        Height = 41
        Anchors = [akTop, akRight]
        Caption = 'Specify contours'
        TabOrder = 0
        WordWrap = True
        OnClick = cbSpecifyContoursClick
        LinkedControls = <>
        AutoSize = False
      end
      object rdeContourInterval: TRbwDataEntry [8]
        Left = 344
        Top = 56
        Width = 94
        Height = 22
        TabOrder = 4
        Text = '0'
        DataType = dtReal
        Max = 1.000000000000000000
        CheckMin = True
        ChangeDisabledColor = True
      end
      inherited Panel1: TPanel
        Top = 160
        Height = 310
        TabOrder = 6
        ExplicitTop = 160
        ExplicitHeight = 310
        DesignSize = (
          562
          310)
        inherited lblColorScheme: TLabel
          Left = 13
          Top = 138
          ExplicitLeft = 13
          ExplicitTop = 138
        end
        inherited lblCycles: TLabel
          Top = 134
          ExplicitTop = 134
        end
        inherited pbColorScheme: TPaintBox
          Left = 8
          Top = 202
          ExplicitLeft = 8
          ExplicitTop = 202
        end
        inherited lblColorAdjustment: TLabel
          Left = 13
          Top = 241
          ExplicitLeft = 13
          ExplicitTop = 241
        end
        object lblSpacing: TLabel [4]
          Left = 297
          Top = 58
          Width = 123
          Height = 16
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Label spacing (pixels)'
        end
        object lblAlgorithm: TLabel [5]
          Left = 13
          Top = 7
          Width = 42
          Height = 16
          Caption = 'Method'
        end
        inherited rgUpdateLimitChoice: TRadioGroup
          Left = 8
          Top = 59
          ExplicitLeft = 8
          ExplicitTop = 59
        end
        inherited btnColorSchemes: TButton
          Left = 292
          Top = 110
          Width = 150
          ExplicitLeft = 292
          ExplicitTop = 110
          ExplicitWidth = 150
        end
        inherited comboColorScheme: TComboBox
          Left = 13
          Top = 157
          ExplicitLeft = 13
          ExplicitTop = 157
        end
        inherited seCycles: TJvSpinEdit
          ExplicitTop = 156
        end
        inherited jsColorExponent: TJvxSlider
          Left = 9
          Top = 257
        end
        inherited seColorExponent: TJvSpinEdit
          Left = 181
          Top = 262
          ExplicitLeft = 181
          ExplicitTop = 262
        end
        inherited cbLogTransform: TCheckBox
          Left = 252
          Top = 272
          ExplicitLeft = 252
          ExplicitTop = 272
        end
        object btnContourFont: TButton
          Left = 297
          Top = 27
          Width = 145
          Height = 25
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Contour label font'
          Enabled = False
          TabOrder = 7
          OnClick = btnContourFontClick
        end
        object cbLabelContours: TCheckBox
          Left = 297
          Top = 4
          Width = 194
          Height = 17
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Label contours'
          TabOrder = 8
          OnClick = cbLabelContoursClick
        end
        object comboAlgorithm: TComboBox
          Left = 13
          Top = 29
          Width = 145
          Height = 24
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 9
          Text = 'Simple'
          Items.Strings = (
            'Simple'
            'ACM 626')
        end
        object seLabelSpacing: TJvSpinEdit
          Left = 297
          Top = 80
          Width = 92
          Height = 24
          Increment = 20.000000000000000000
          MaxValue = 2147483647.000000000000000000
          MinValue = 1.000000000000000000
          Value = 1.000000000000000000
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 10
        end
      end
    end
    inherited tabFilters: TTabSheet
      ExplicitHeight = 470
      DesignSize = (
        562
        470)
      inherited lblNumberOfValuesToIgnore: TLabel
        Top = 443
        ExplicitTop = 441
      end
      inherited rdgValuesToIgnore: TRbwDataGrid4
        Height = 322
        ExplicitHeight = 322
      end
      inherited seNumberOfValuesToIgnore: TJvSpinEdit
        Top = 440
        ExplicitTop = 440
      end
    end
    inherited tabLegend: TTabSheet
      ExplicitHeight = 470
      inherited imLegend: TImage
        Height = 470
        ExplicitHeight = 471
      end
      inherited splColor: TSplitter
        Height = 470
        ExplicitHeight = 470
      end
      inherited pnlLegend: TPanel
        Height = 470
        ExplicitHeight = 470
        DesignSize = (
          201
          470)
        inherited lblColorLegendRows: TLabel
          Top = 412
          ExplicitTop = 410
        end
        inherited seLegendRows: TJvSpinEdit
          Top = 433
          ExplicitTop = 433
        end
        inherited rdgLegend: TRbwDataGrid4
          Height = 347
          ExplicitHeight = 347
        end
      end
    end
  end
  object fdContourFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 480
    Top = 232
  end
end
