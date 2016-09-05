inherited framePkgSto: TframePkgSto
  Width = 447
  Height = 240
  Enabled = False
  ExplicitWidth = 447
  ExplicitHeight = 240
  DesignSize = (
    447
    240)
  object lblConfinedStorageMethod: TLabel [2]
    Left = 16
    Top = 162
    Width = 247
    Height = 13
    Caption = 'Confined storage method (STORAGECOEFFICIENT)'
  end
  inherited memoComments: TMemo
    Width = 416
  end
  object comboStorageChoice: TJvImageComboBox [4]
    Left = 16
    Top = 181
    Width = 225
    Height = 23
    Style = csOwnerDrawVariable
    ButtonStyle = fsLighter
    DroppedWidth = 225
    ImageHeight = 0
    ImageWidth = 0
    ItemHeight = 17
    ItemIndex = 1
    TabOrder = 1
    Items = <
      item
        Brush.Style = bsClear
        Indent = 0
        Text = 'Specific Storage'
      end
      item
        Brush.Style = bsClear
        Indent = 0
        Text = 'Storage Coefficient'
      end>
  end
  object cbNewton: TCheckBox [5]
    Left = 16
    Top = 210
    Width = 385
    Height = 17
    Caption = 'Use Newton-Raphson formulation for groundwater storage (NEWTON)'
    Enabled = False
    TabOrder = 2
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
        Control = Owner
      end
      item
        Control = cbNewton
      end>
  end
end
