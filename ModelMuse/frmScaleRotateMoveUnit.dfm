inherited frmScaleRotateMove: TfrmScaleRotateMove
  HelpType = htKeyword
  HelpKeyword = 'Scale_Rotate_and_Move_Objects'
  Caption = 'Scale, Rotate, and Move Objects'
  ClientHeight = 236
  ClientWidth = 618
  ExplicitWidth = 636
  ExplicitHeight = 283
  PixelsPerInch = 120
  TextHeight = 18
  object gbScale: TJvGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 303
    Height = 105
    Margins.Right = 8
    Margins.Bottom = 8
    BiDiMode = bdLeftToRight
    Caption = 'Scale'
    ParentBiDiMode = False
    TabOrder = 0
    Checkable = True
    PropagateEnable = True
    OnCheckBoxClick = EnableOk
    object lblXScale: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 20
      Width = 95
      Height = 18
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Caption = 'X scale factor'
      Enabled = False
      ParentBiDiMode = False
    end
    object lblYScale: TLabel
      AlignWithMargins = True
      Left = 152
      Top = 20
      Width = 93
      Height = 18
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Caption = 'Y scale factor'
      Enabled = False
      ParentBiDiMode = False
    end
    object rdeXScale: TRbwDataEntry
      AlignWithMargins = True
      Left = 8
      Top = 40
      Width = 133
      Height = 22
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Color = clBtnFace
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 1
      Text = '1'
      OnChange = rdeXScaleChange
      DataType = dtReal
      Max = 1.000000000000000000
      CheckMin = True
      ChangeDisabledColor = True
    end
    object cbLockAspectRatio: TCheckBox
      AlignWithMargins = True
      Left = 8
      Top = 68
      Width = 225
      Height = 17
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Caption = 'Lock aspect ratio'
      Checked = True
      Enabled = False
      ParentBiDiMode = False
      State = cbChecked
      TabOrder = 2
      OnClick = cbLockAspectRatioClick
    end
    object rdeYScale: TRbwDataEntry
      AlignWithMargins = True
      Left = 152
      Top = 40
      Width = 133
      Height = 22
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Color = clBtnFace
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 3
      Text = '1'
      OnChange = rdeXScaleChange
      DataType = dtReal
      Max = 1.000000000000000000
      CheckMin = True
      ChangeDisabledColor = True
    end
  end
  object gbRotate: TJvGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 114
    Width = 303
    Height = 75
    Margins.Right = 8
    Margins.Bottom = 8
    BiDiMode = bdLeftToRight
    Caption = 'Rotate'
    ParentBiDiMode = False
    TabOrder = 1
    Checkable = True
    PropagateEnable = True
    OnCheckBoxClick = EnableOk
    object lblAngle: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 20
      Width = 246
      Height = 18
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Caption = 'Angle of rotation (counterclockwise)'
      Enabled = False
      ParentBiDiMode = False
    end
    object rdeAngle: TRbwDataEntry
      AlignWithMargins = True
      Left = 8
      Top = 40
      Width = 133
      Height = 22
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Color = clBtnFace
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 1
      Text = '0'
      OnChange = rdeAngleChange
      DataType = dtReal
      Max = 1.000000000000000000
      ChangeDisabledColor = True
    end
  end
  object gbMove: TJvGroupBox
    AlignWithMargins = True
    Left = 312
    Top = 114
    Width = 298
    Height = 75
    Margins.Right = 8
    Margins.Bottom = 8
    BiDiMode = bdLeftToRight
    Caption = 'Move'
    ParentBiDiMode = False
    TabOrder = 2
    Checkable = True
    PropagateEnable = True
    OnCheckBoxClick = EnableOk
    object lblMoveX: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 20
      Width = 53
      Height = 18
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Caption = 'X offset'
      Enabled = False
      ParentBiDiMode = False
    end
    object lblMoveY: TLabel
      AlignWithMargins = True
      Left = 152
      Top = 20
      Width = 51
      Height = 18
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Caption = 'Y offset'
      Enabled = False
      ParentBiDiMode = False
    end
    object rdeMoveX: TRbwDataEntry
      AlignWithMargins = True
      Left = 8
      Top = 40
      Width = 133
      Height = 22
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Color = clBtnFace
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 1
      Text = '0'
      OnChange = rdeMoveXChange
      DataType = dtReal
      Max = 1.000000000000000000
      ChangeDisabledColor = True
    end
    object rdeMoveY: TRbwDataEntry
      AlignWithMargins = True
      Left = 152
      Top = 40
      Width = 133
      Height = 22
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Color = clBtnFace
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 2
      Text = '0'
      OnChange = rdeMoveYChange
      DataType = dtReal
      Max = 1.000000000000000000
      ChangeDisabledColor = True
    end
  end
  object btnHelp: TBitBtn
    AlignWithMargins = True
    Left = 320
    Top = 195
    Width = 91
    Height = 33
    Margins.Right = 8
    Margins.Bottom = 8
    BiDiMode = bdLeftToRight
    Kind = bkHelp
    NumGlyphs = 2
    ParentBiDiMode = False
    TabOrder = 3
    OnClick = btnHelpClick
  end
  object btnOK: TBitBtn
    AlignWithMargins = True
    Left = 419
    Top = 195
    Width = 91
    Height = 33
    Margins.Right = 8
    Margins.Bottom = 8
    BiDiMode = bdLeftToRight
    Enabled = False
    Kind = bkOK
    NumGlyphs = 2
    ParentBiDiMode = False
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    AlignWithMargins = True
    Left = 519
    Top = 195
    Width = 91
    Height = 33
    Margins.Right = 8
    Margins.Bottom = 8
    BiDiMode = bdLeftToRight
    Kind = bkCancel
    NumGlyphs = 2
    ParentBiDiMode = False
    TabOrder = 5
  end
  object gbCenter: TGroupBox
    AlignWithMargins = True
    Left = 312
    Top = 3
    Width = 298
    Height = 105
    Margins.Right = 8
    Margins.Bottom = 8
    BiDiMode = bdLeftToRight
    Caption = 'Reference point for scaling and rotation'
    ParentBiDiMode = False
    TabOrder = 6
    object lblXCenter: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 53
      Width = 62
      Height = 18
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Caption = 'X Center'
      Enabled = False
      ParentBiDiMode = False
    end
    object lblYCenter: TLabel
      AlignWithMargins = True
      Left = 152
      Top = 53
      Width = 60
      Height = 18
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Caption = 'Y Center'
      Enabled = False
      ParentBiDiMode = False
    end
    object comboCenterOfRotation: TJvImageComboBox
      AlignWithMargins = True
      Left = 8
      Top = 20
      Width = 145
      Height = 28
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Style = csOwnerDrawVariable
      BiDiMode = bdLeftToRight
      ButtonStyle = fsLighter
      Color = clBtnFace
      DroppedWidth = 145
      Enabled = False
      ImageHeight = 0
      ImageWidth = 0
      ItemHeight = 22
      ItemIndex = 0
      ParentBiDiMode = False
      TabOrder = 0
      OnChange = comboCenterOfRotationChange
      Items = <
        item
          Brush.Style = bsClear
          Indent = 0
          Text = 'Object center'
        end
        item
          Brush.Style = bsClear
          Indent = 0
          Text = 'Specified location'
        end>
    end
    object rdeXCenter: TRbwDataEntry
      AlignWithMargins = True
      Left = 8
      Top = 73
      Width = 133
      Height = 22
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Color = clBtnFace
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 1
      Text = '0'
      DataType = dtReal
      Max = 1.000000000000000000
      ChangeDisabledColor = True
    end
    object rdeYCenter: TRbwDataEntry
      AlignWithMargins = True
      Left = 152
      Top = 73
      Width = 133
      Height = 22
      Margins.Left = 8
      Margins.Right = 8
      Margins.Bottom = 8
      BiDiMode = bdLeftToRight
      Color = clBtnFace
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 2
      Text = '0'
      DataType = dtReal
      Max = 1.000000000000000000
      ChangeDisabledColor = True
    end
  end
end
