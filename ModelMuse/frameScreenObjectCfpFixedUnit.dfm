inherited frameScreenObjectCfpFixed: TframeScreenObjectCfpFixed
  Width = 344
  Height = 127
  ExplicitWidth = 344
  ExplicitHeight = 127
  DesignSize = (
    344
    127)
  object lblHint: TLabel
    Left = 3
    Top = 69
    Width = 321
    Height = 52
    Caption = 
      'It is only necessary to specify CFP fixed heads for nodes that a' +
      're CFP fixed head nodes. Other nodes will automatically have the' +
      'ir fixed heads set to -1 which is used to indicate that the head' +
      ' in the node should be calculated.'
    WordWrap = True
  end
  object pnlCaption: TPanel
    Left = 0
    Top = 0
    Width = 344
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object edFixedHead: TLabeledEdit
    Left = 3
    Top = 39
    Width = 227
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = 'Fixed head'
    TabOrder = 2
    OnChange = edFixedHeadChange
  end
  object btnFixedHead: TButton
    Left = 242
    Top = 36
    Width = 90
    Height = 30
    Anchors = [akTop, akRight]
    Caption = 'Edit F()...'
    TabOrder = 1
  end
end
