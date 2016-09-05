{@abstract(The main purpose of @name is to define @link(TfrmShowHideBitmaps)
  which is used to show or hide imported
  bitmaps stored in @link(TCompressedBitmapItem)s.)}
unit frmShowHideBitmapsUnit;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frmCustomGoPhastUnit, Buttons, ExtCtrls, CheckLst,
  Vcl.Grids, RbwDataGrid4;

type
  {@abstract(@name is used to show or hide imported
    bitmaps stored in @link(TCompressedBitmapItem)s.)}
  TfrmShowHideBitmaps = class(TfrmCustomGoPhast)
    // @name: TBitBtn;
    // Clicking @name closes @classname.
    btnClose: TBitBtn;
    // @name: TBitBtn;
    // Clicking @name displays help on @classname.
    btnHelp: TBitBtn;
    // @name: TButton;
    // Clicking @name causes all the checkboxes in @link(clbBitmaps)
    // to be checked.
    // See @link(btnShowClick).
    btnShowAll: TButton;
    // @name: TButton;
    // Clicking @name causes none of the checkboxes in @link(clbBitmaps)
    // to be checked.
    // See @link(btnShowClick).
    btnShowNone: TButton;
    // @name: TButton;
    // See @link(btnToggleClick).
    btnToggle: TButton;
    // @name: TPanel;
    // @name holds the buttons on the bottom of @classname.
    pnlBottom: TPanel;
    rdgBitmaps: TRbwDataGrid4;
    // @name calls @link(GetData).
    procedure FormCreate(Sender: TObject); override;
    // @name shows or hides all the @link(TCompressedBitmapItem)s
    // depending on whether Sender is @link(btnShowAll) or @link(btnShowNone).
    procedure btnShowClick(Sender: TObject);
    // @name causes the checked state
    // of all the checkboxes in @link(clbBitmaps)
    // to be toggled.
    procedure btnToggleClick(Sender: TObject);
    procedure rdgBitmapsStateChange(Sender: TObject; ACol, ARow: Integer;
      const Value: TCheckBoxState);
    procedure rdgBitmapsRowMoved(Sender: TObject; FromIndex, ToIndex: Integer);
  private
    FGettingData: Boolean;
    // @name fills @link(clbBitmaps) with the names of the
    //  imported bitmaps
    // and sets the checked state of each line depending
    // on the @link(TCompressedBitmapItem.Visible) property of the
    // @link(TCompressedBitmapItem).
    procedure GetData;
    procedure SetAllChecks(ShouldCheck: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses frmGoPhastUnit, CompressedImageUnit, GoPhastTypes;

{$R *.dfm}

{ TfrmShowHideBitmaps }

procedure TfrmShowHideBitmaps.GetData;
var
  BitmapIndex: integer;
  Item: TCompressedBitmapItem;
begin
  FGettingData := True;
  rdgBitmaps.BeginUpdate;
  try
    rdgBitmaps.RowCount := frmGoPhast.PhastModel.Bitmaps.Count;
    for BitmapIndex := 0 to frmGoPhast.PhastModel.Bitmaps.Count - 1 do
    begin
      Item := frmGoPhast.PhastModel.Bitmaps.Items[BitmapIndex] as
        TCompressedBitmapItem;
      rdgBitmaps.Cells[1,BitmapIndex] := Item.Name;
      rdgBitmaps.Objects[1,BitmapIndex] := Item;
      rdgBitmaps.Checked[1,BitmapIndex] := Item.Visible;
    end;
  finally
    rdgBitmaps.EndUpdate;
    FGettingData := False;
  end;
end;

procedure TfrmShowHideBitmaps.SetAllChecks(ShouldCheck: Boolean);
var
  Index: Integer;
begin
  for Index := 0 to rdgBitmaps.RowCount - 1 do
  begin
    rdgBitmaps.Checked[1, Index] := ShouldCheck;
  end;
end;

procedure TfrmShowHideBitmaps.rdgBitmapsRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var
  AnItem: TCompressedBitmapItem;
begin
  inherited;
  AnItem := frmGoPhast.PhastModel.Bitmaps.Items[FromIndex] as TCompressedBitmapItem;
  AnItem.Index := ToIndex;
  case AnItem.ViewDirection of
    vdTop:
      begin
        frmGoPhast.frameTopView.ModelChanged := True;
        frmGoPhast.InvalidateTop;
      end;
    vdFront:
      begin
        frmGoPhast.frameFrontView.ModelChanged := True;
        frmGoPhast.InvalidateFront;
      end;
    vdSide:
      begin
        frmGoPhast.frameSideView.ModelChanged := True;
        frmGoPhast.InvalidateSide;
      end
    else Assert(False);
  end;
end;

procedure TfrmShowHideBitmaps.rdgBitmapsStateChange(Sender: TObject; ACol,
  ARow: Integer; const Value: TCheckBoxState);
var
  Item: TCompressedBitmapItem;
begin
  inherited;
  if not FGettingData then
  begin
    Item := rdgBitmaps.Objects[1,ARow] as TCompressedBitmapItem;
    Item.Visible := rdgBitmaps.Checked[1,ARow];
  end;
end;

procedure TfrmShowHideBitmaps.FormCreate(Sender: TObject);
var
  SelectRect: TGridRect;
begin
  inherited;
  GetData;
  SelectRect.Left := 0;
  SelectRect.Top := 0;
  SelectRect.BottomRight := SelectRect.TopLeft;
  rdgBitmaps.Selection := SelectRect;
end;

procedure TfrmShowHideBitmaps.btnShowClick(Sender: TObject);
var
  ShouldCheck: boolean;
begin
  inherited;
  ShouldCheck := (Sender = btnShowAll);
  SetAllChecks(ShouldCheck);
//  clbBitmapsClickCheck(nil);
end;

procedure TfrmShowHideBitmaps.btnToggleClick(Sender: TObject);
var
  Index: integer;
begin
  inherited;
  for Index := 0 to rdgBitmaps.RowCount - 1 do
  begin
    rdgBitmaps.Checked[1,Index] := not rdgBitmaps.Checked[1,Index];
  end;
//  clbBitmapsClickCheck(nil);
end;

end.

