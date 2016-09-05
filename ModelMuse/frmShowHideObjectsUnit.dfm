inherited frmShowHideObjects: TfrmShowHideObjects
  Left = 170
  Top = 162
  HelpType = htKeyword
  HelpKeyword = 'Show_or_Hide_Objects_Dialog_Box'
  VertScrollBar.Range = 41
  Caption = 'Show or Hide Objects'
  KeyPreview = True
  Position = poDesigned
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  PixelsPerInch = 120
  TextHeight = 18
  inherited pnlBottom: TPanel
    inherited btnHelp: TBitBtn
      OnClick = btnHelpClick
    end
  end
  inherited vstObjects: TVirtualStringTree
    Images = ilAngles
    PopupMenu = pmSelectEdit
    OnChecked = vstObjectsChecked
    OnContextPopup = vstObjectsContextPopup
    OnDblClick = miEditClick
    OnPaintText = vstObjectsPaintText
    OnGetImageIndexEx = vstObjectsGetImageIndexEx
    OnMouseDown = vstObjectsMouseDown
  end
  object pmSelectEdit: TPopupMenu
    Left = 144
    Top = 112
    object miSelect: TMenuItem
      Caption = 'Select'
      Enabled = False
      Hint = 'Select an object'
      OnClick = miSelectClick
    end
    object miEdit: TMenuItem
      Caption = 'Edit'
      Enabled = False
      Hint = 'Edit an object in the Object Properties dialog box'
      OnClick = miEditClick
    end
    object miGoto: TMenuItem
      Caption = 'Go to'
      Hint = 'Go to the location of the object'
      OnClick = miGotoClick
    end
  end
  object ilAngles: TImageList
    Height = 20
    Masked = False
    Width = 20
    Left = 248
    Top = 80
  end
  object ilDifferentAngle: TImageList
    Height = 20
    Masked = False
    Width = 20
    Left = 304
    Top = 80
  end
end
