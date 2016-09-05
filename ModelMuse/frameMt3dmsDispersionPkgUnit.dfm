inherited frameMt3dmsDispersionPkg: TframeMt3dmsDispersionPkg
  Height = 215
  ExplicitHeight = 215
  object cbMultiDiffusion: TCheckBox [3]
    Left = 16
    Top = 157
    Width = 265
    Height = 28
    Caption = 
      'Specify diffusion coefficient separately for each mobile compone' +
      'nt  (MultiDiffusion)'
    Enabled = False
    TabOrder = 1
    WordWrap = True
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
        Control = cbMultiDiffusion
      end>
  end
end
