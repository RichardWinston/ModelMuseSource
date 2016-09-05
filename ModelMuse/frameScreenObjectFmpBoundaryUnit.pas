unit frameScreenObjectFmpBoundaryUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, frameScreenObjectNoParamUnit, Grids,
  RbwDataGrid4, StdCtrls, ArgusDataEntry, Buttons, Mask, JvExMask,
  JvSpin, ExtCtrls, UndoItemsScreenObjects, ScreenObjectUnit,
  ModflowBoundaryUnit;

type
  TPrecipColumns = (pcStartTime, pcEndTime, pcValue);

  TframeScreenObjectFmpBoundary = class(TframeScreenObjectNoParam)
    procedure seNumberOfTimesChange(Sender: TObject);
    procedure dgModflowBoundarySetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
  private
    FChanging: Boolean;
    FOnChange: TNotifyEvent;
    procedure ClearFmpGrid;
    procedure AssignFirstItem(ScreenObject: TScreenObject);
    { Private declarations }
  protected
    property Changing: Boolean read FChanging write FChanging;
    procedure DoChange;
    function GetBoundary(AScreenObject: TScreenObject): TModflowBoundary; virtual; abstract;
    procedure CreateScreenObjectBoundary(AScreenObject: TScreenObject); virtual; abstract;
    function CreateNewBoundary: TModflowBoundary; virtual; abstract;
    procedure InitializeControls; virtual;
  public
    procedure GetData(ScreenObjectList: TScreenObjectEditCollection);
    procedure SetData(List: TScreenObjectEditCollection; SetAll: boolean;
      ClearAll: boolean);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    { Public declarations }
  end;

var
  frameScreenObjectFmpBoundary: TframeScreenObjectFmpBoundary;

implementation

uses
  GoPhastTypes, ModflowTimeUnit, frmGoPhastUnit;

{$R *.dfm}

{ TframeScreenObjectFmpPrecip }

procedure TframeScreenObjectFmpBoundary.AssignFirstItem(
  ScreenObject: TScreenObject);
var
  ABoundary: TModflowBoundary;
  Items: TCustomMF_BoundColl;
  ItemIndex: Integer;
  AnItem: TCustomModflowBoundaryItem;
begin
  ABoundary := GetBoundary(ScreenObject);

  Assert(ABoundary <> nil);
  Items := ABoundary.Values;
  seNumberOfTimes.AsInteger := Items.Count;
  seNumberOfTimes.OnChange(nil);
  Assert(dgModflowBoundary.RowCount -1 = Items.Count);

  for ItemIndex := 0 to Items.Count - 1 do
  begin
    AnItem := Items[ItemIndex] as TCustomModflowBoundaryItem;
    dgModflowBoundary.Cells[Ord(pcStartTime), ItemIndex+1] := FloatToStr(AnItem.StartTime);
    dgModflowBoundary.Cells[Ord(pcEndTime), ItemIndex+1] := FloatToStr(AnItem.EndTime);
    dgModflowBoundary.Cells[Ord(pcValue), ItemIndex+1] := AnItem.BoundaryFormula[0];
  end;
end;

procedure TframeScreenObjectFmpBoundary.ClearFmpGrid;
begin
  ClearGrid(dgModflowBoundary);
end;

procedure TframeScreenObjectFmpBoundary.dgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  DoChange;
end;

procedure TframeScreenObjectFmpBoundary.DoChange;
begin
  if Changing then
  begin
    Exit;
  end;
  if Assigned(OnChange) then
  begin
    OnChange(Self);
  end;
end;

procedure TframeScreenObjectFmpBoundary.GetData(
  ScreenObjectList: TScreenObjectEditCollection);
var
  ListOfScreenObjects: TScreenObjectList;
  Item: TScreenObjectEditItem;
  AScreenObject: TScreenObject;
  ABoundary: TModflowBoundary;
  Items: TCustomMF_BoundColl;
  AnItem: TCustomModflowBoundaryItem;
  Index: Integer;
  ScreenObjectIndex: Integer;
  ItemIndex: Integer;
begin
  Assert(ScreenObjectList.Count >= 1);
  Changing := True;
  try
    InitializeControls;
    ListOfScreenObjects := TScreenObjectList.Create;
    try
      for Index := 0 to ScreenObjectList.Count - 1 do
      begin
        Item := ScreenObjectList[Index];
        AScreenObject := Item.ScreenObject;
        ABoundary := GetBoundary(AScreenObject);
        if (ABoundary <> nil) and ABoundary.Used then
        begin
          ListOfScreenObjects.Add(AScreenObject);
        end;
      end;
      if ListOfScreenObjects.Count > 0 then
      begin
        AssignFirstItem(ListOfScreenObjects[0]);
      end;
      for ScreenObjectIndex := 1 to ListOfScreenObjects.Count - 1 do
      begin
        ABoundary := GetBoundary(ListOfScreenObjects[ScreenObjectIndex]);
        Items := ABoundary.Values;
        if Items.Count = seNumberOfTimes.AsInteger then
        begin
          for ItemIndex := 0 to Items.Count - 1 do
          begin
            AnItem := Items[ItemIndex] as TCustomModflowBoundaryItem;
            if (dgModflowBoundary.Cells[Ord(pcStartTime), ItemIndex+1]
              <> FloatToStr(AnItem.StartTime))
              or (dgModflowBoundary.Cells[Ord(pcEndTime), ItemIndex+1]
              <> FloatToStr(AnItem.EndTime))
              or (dgModflowBoundary.Cells[Ord(pcValue), ItemIndex+1]
              <> AnItem.BoundaryFormula[0]) then
            begin
              ClearFmpGrid;
              Exit;
            end;
          end;
        end
        else
        begin
          ClearFmpGrid;
          break;
        end;
      end;

    finally
      ListOfScreenObjects.Free;
    end;
  finally
    Changing := False;
  end;
end;

procedure TframeScreenObjectFmpBoundary.InitializeControls;
begin
  ClearFmpGrid;
  dgModflowBoundary.Cells[Ord(pcStartTime), 0] := StrStartingTime;
  dgModflowBoundary.Cells[Ord(pcEndTime), 0] := StrEndingTime;
  GetStartTimes(Ord(pcStartTime));
  GetEndTimes(Ord(pcEndTime));
  seNumberOfTimes.AsInteger := 0;
  seNumberOfTimes.OnChange(nil);
  LayoutMultiRowEditControls;
end;

procedure TframeScreenObjectFmpBoundary.seNumberOfTimesChange(Sender: TObject);
begin
  inherited;
  DoChange;
end;

procedure TframeScreenObjectFmpBoundary.SetData(List: TScreenObjectEditCollection;
  SetAll, ClearAll: boolean);
var
  ScreenObjectIndex: Integer;
  Item: TScreenObjectEditItem;
  ScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  BoundaryUsed: Boolean;
  NewBoundary: TModflowBoundary;
  RowIndex: Integer;
  FirstTime: Double;
  StressPeriods: TModflowStressPeriods;
  LastTime: Double;
  StartTime: double;
  EndTime: double;
  NewItem: TCustomModflowBoundaryItem;
begin
  NewBoundary := nil;
  try
    if SetAll or not ClearAll then
    begin
      NewBoundary := CreateNewBoundary;

      StressPeriods := frmGoPhast.PhastModel.ModflowStressPeriods;
      FirstTime := StressPeriods.First.StartTime;
      LastTime :=  StressPeriods.Last.EndTime;

      for RowIndex := 1 to dgModflowBoundary.RowCount - 1 do
      begin
        if TryStrToFloat(dgModflowBoundary.Cells[Ord(pcStartTime), RowIndex], StartTime)
          and TryStrToFloat(dgModflowBoundary.Cells[Ord(pcEndTime), RowIndex], EndTime)
          and (dgModflowBoundary.Cells[Ord(pcValue), RowIndex] <> '') then
        begin

          NewItem := NewBoundary.Values.Add as TCustomModflowBoundaryItem;
          NewItem.StartTime := StartTime;
          NewItem.EndTime := EndTime;
          NewItem.BoundaryFormula[0] := dgModflowBoundary.Cells[Ord(pcValue), RowIndex];
        end;
      end;
      if NewBoundary.Values.Count = 0 then
      begin
        Exit;
      end;
    end;
    for ScreenObjectIndex := 0 to List.Count - 1 do
    begin
      Item := List[ScreenObjectIndex];
      ScreenObject := Item.ScreenObject;
      Boundary := GetBoundary(ScreenObject);
      BoundaryUsed := (Boundary <> nil) and Boundary.Used;
      if ClearAll then
      begin
        if BoundaryUsed then
        begin
          Boundary.Clear;
        end;
      end
      else if SetAll or BoundaryUsed then
      begin
        if Boundary = nil then
        begin
          CreateScreenObjectBoundary(Item.ScreenObject);
          Boundary := GetBoundary(Item.ScreenObject);
        end;
        if Boundary <> nil then
        begin
          Boundary.Assign(NewBoundary);
        end;
      end;
    end;
  finally
    NewBoundary.Free;
  end;
end;

end.
