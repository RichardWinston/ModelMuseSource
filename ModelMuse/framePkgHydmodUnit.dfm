inherited framePkgHydmod: TframePkgHydmod
  Height = 209
  ExplicitHeight = 209
  inherited lblComments: TLabel
    Margins.Bottom = 0
  end
  inherited lblPackage: TLabel
    Margins.Bottom = 0
  end
  object lblHYDNOH: TLabel [2]
    Left = 16
    Top = 157
    Width = 274
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Value printed when no value can be computed (HYDNOH)'
    Enabled = False
  end
  inherited memoComments: TMemo
    Anchors = [akLeft, akTop, akRight, akBottom]
  end
  object rdeHYDNOH: TRbwDataEntry [4]
    Left = 16
    Top = 176
    Width = 145
    Height = 22
    Anchors = [akLeft, akBottom]
    Color = clBtnFace
    Enabled = False
    ItemHeight = 13
    TabOrder = 1
    Text = '0'
    DataType = dtReal
    Max = 1.000000000000000000
    ChangeDisabledColor = True
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
        Control = lblHYDNOH
      end
      item
        Control = rdeHYDNOH
      end>
  end
end
