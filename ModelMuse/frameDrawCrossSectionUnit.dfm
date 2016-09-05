object frameDrawCrossSection: TframeDrawCrossSection
  Left = 0
  Top = 0
  Width = 445
  Height = 322
  TabOrder = 0
  OnResize = FrameResize
  object btnAddDataSet: TSpeedButton
    Left = 209
    Top = 88
    Width = 23
    Height = 22
    Hint = 'Add data set'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333FF3333333333333003333
      3333333333773FF3333333333309003333333333337F773FF333333333099900
      33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
      99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
      33333333337F3F77333333333309003333333333337F77333333333333003333
      3333333333773333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = btnAddDataSetClick
  end
  object btnRemoveDataSet: TSpeedButton
    Left = 209
    Top = 116
    Width = 23
    Height = 22
    Hint = 'Remove Data Set'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333FF3333333333333003333333333333F77F33333333333009033
      333333333F7737F333333333009990333333333F773337FFFFFF330099999000
      00003F773333377777770099999999999990773FF33333FFFFF7330099999000
      000033773FF33777777733330099903333333333773FF7F33333333333009033
      33333333337737F3333333333333003333333333333377333333333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    OnClick = btnRemoveDataSetClick
  end
  object vstAvailableDataSets: TVirtualStringTree
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 200
    Height = 316
    Align = alLeft
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -13
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    TabOrder = 1
    TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect]
    OnChange = vstAvailableDataSetsChange
    OnGetText = vstAvailableDataSetsGetText
    OnGetNodeDataSize = vstAvailableDataSetsGetNodeDataSize
    OnInitNode = vstAvailableDataSetsInitNode
    Columns = <>
  end
  object clrbtnSelectedColor: TJvColorButton
    Left = 209
    Top = 192
    Width = 57
    Height = 25
    OtherCaption = '&Other...'
    Options = []
    OnChange = clrbtnSelectedColorChange
    TabOrder = 2
    Visible = False
  end
  object pnlUsed: TPanel
    Left = 238
    Top = 0
    Width = 207
    Height = 322
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object spl1: TSplitter
      Left = 0
      Top = 188
      Width = 207
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 190
    end
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 207
      Height = 188
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object lblDataSets: TLabel
        Left = 8
        Top = 8
        Width = 80
        Height = 13
        Caption = 'Data sets to plot'
      end
      object lstSelectedDataSets: TListBox
        AlignWithMargins = True
        Left = 3
        Top = 30
        Width = 201
        Height = 155
        Margins.Top = 30
        Style = lbOwnerDrawFixed
        Align = alClient
        ItemHeight = 25
        MultiSelect = True
        TabOrder = 0
        OnClick = lstSelectedDataSetsClick
        OnDrawItem = lstSelectedDataSetsDrawItem
        OnExit = lstSelectedDataSetsExit
      end
    end
    object pnlBottom: TPanel
      Left = 0
      Top = 193
      Width = 207
      Height = 129
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object lblLayers: TLabel
        Left = 11
        Top = 3
        Width = 66
        Height = 13
        Caption = 'Layers to plot'
      end
      object clbLayers: TJvCheckListBox
        AlignWithMargins = True
        Left = 3
        Top = 30
        Width = 201
        Height = 96
        Margins.Top = 30
        Align = alClient
        DoubleBuffered = False
        ItemHeight = 13
        ParentDoubleBuffered = False
        TabOrder = 0
      end
    end
  end
end
