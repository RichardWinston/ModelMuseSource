unit frameScreenObjectStrUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, frameScreenObjectCondParamUnit,
  Grids, RbwDataGrid4, ArgusDataEntry, JvExControls, JvxCheckListBox,
  StdCtrls, Buttons, Mask, JvExMask, JvSpin, ExtCtrls,
  UndoItemsScreenObjects, ModflowStrUnit, Generics.Collections;

type
  TStrTimeColumns = (stcStartTime, stcEndTime, stcDownstreamSegment,
    stcDiversionSegment, stcFlow, stcStage, stcCond,
    stcSbot, stcStop, stcWidth, stcSlope, stcRough);

  TframeScreenObjectStr = class(TframeScreenObjectCondParam)
    pnlNumber: TPanel;
    seSegmentNumber: TJvSpinEdit;
    lblSegmentNumber: TLabel;
    procedure seNumberOfTimesChange(Sender: TObject);
    procedure dgModflowBoundarySetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure seSegmentNumberChange(Sender: TObject);
    procedure clbParametersClick(Sender: TObject);
    procedure comboFormulaInterpChange(Sender: TObject);
    procedure dgModflowBoundarySelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    FCalculateStage: Boolean;
    FFirstParamColumn: Integer;
    FChanging: boolean;
    FOnEdited: TNotifyEvent;
    procedure InitializeControls;
    procedure AssignFirstItem(LocalList: TList<TStrBoundary>);
    function UpdateTimeTable(Boundary: TStrBoundary): boolean;
    procedure UpdateTimeGridCell(Value: string; Column, Row: integer);
    procedure Edited;
    procedure UpdateConductanceCaption;
    { Private declarations }
  public
    procedure GetData(ScreenObjectList: TScreenObjectEditCollection);
    procedure SetData(List: TScreenObjectEditCollection; SetAll: boolean;
      ClearAll: boolean);
    property OnEdited: TNotifyEvent read FOnEdited write FOnEdited;
    { Public declarations }
  end;

var
  frameScreenObjectStr: TframeScreenObjectStr;

implementation

uses
  frmGoPhastUnit, GoPhastTypes, ModflowTransientListParameterUnit,
  OrderedCollectionUnit, frmScreenObjectPropertiesUnit,
  ScreenObjectUnit,
  ModflowTimeUnit, ModflowBoundaryUnit;

resourcestring
  StrOutflowSegmentItr = 'Outflow segment (Itrib)';
  StrDiversionSegmentI = 'Diversion segment (Iupseg)';
  StrFlow = 'Flow';
  StrHead = 'Head';
  StrConductanceCond = 'Conductance (Cond)';
  StrConductanceCondMult = 'Conductance multiplier (Condfact)';
  StrStreambedBottomSb = 'Streambed bottom (Sbot)';
  StrStreambedTopStop = 'Streambed top (Stop)';
  StrStreamWidthWidth = 'Stream width (Width)';
  StrStreamSlopeSlope = 'Stream slope (Slope)';
  StrManningsRoughness = 'Manning�s roughness coefficient (Rough)';
  StrNearest = 'Closest';
  StrF = 'F()';

{$R *.dfm}

{ TframeScreeenObjectStr }

procedure TframeScreenObjectStr.AssignFirstItem(
  LocalList: TList<TStrBoundary>);
var
  Boundary: TStrBoundary;
  ParamItem: TStrParamItem;
  Item: TStrItem;
  Values: TStrCollection;
  ItemIndex: Integer;
begin
  Boundary := LocalList[0];
  seSegmentNumber.Enabled := True;
  seSegmentNumber.AsInteger := Boundary.SegmentNumber;
  comboFormulaInterp.ItemIndex := Ord(Boundary.FormulaInterpretation);
  if Boundary.Parameters.Count > 0 then
  begin
    Assert(Boundary.Parameters.Count = 1);
    ParamItem := Boundary.Parameters[0] as TStrParamItem;
    Values := ParamItem.Param as TStrCollection;

//    AParam := ParamItem.Param.ParamName;
    clbParameters.CheckedIndex := clbParameters.Items.IndexOf(ParamItem.Param.ParamName);
  end
  else
  begin
    Values := Boundary.Values as TStrCollection;
    if clbParameters.Items.Count > 0 then
    begin
      clbParameters.CheckedIndex := 0;
    end;
  end;

  seNumberOfTimes.AsInteger := Values.Count;
  for ItemIndex := 0 to Values.Count - 1 do
  begin
    Item := Values[ItemIndex] as TStrItem;
    dgModflowBoundary.Cells[Ord(stcStartTime), ItemIndex+1] :=
      FloatToStr(Item.StartTime);
    dgModflowBoundary.Cells[Ord(stcEndTime), ItemIndex+1] :=
      FloatToStr(Item.EndTime);
    dgModflowBoundary.Cells[Ord(stcDownstreamSegment), ItemIndex+1] :=
      IntToStr(Item.OutflowSegment);
    dgModflowBoundary.Cells[Ord(stcDiversionSegment), ItemIndex+1] :=
      IntToStr(Item.DiversionSegment);
    dgModflowBoundary.Cells[Ord(stcFlow), ItemIndex+1] := Item.Flow;
    dgModflowBoundary.Cells[Ord(stcStage), ItemIndex+1] := Item.Stage;
    dgModflowBoundary.Cells[Ord(stcCond), ItemIndex+1] := Item.Conductance;
    dgModflowBoundary.Cells[Ord(stcSbot), ItemIndex+1] := Item.BedBottom;
    dgModflowBoundary.Cells[Ord(stcStop), ItemIndex+1] := Item.BedTop;
    if FCalculateStage then
    begin
      dgModflowBoundary.Cells[Ord(stcWidth), ItemIndex+1] := Item.Width;
      dgModflowBoundary.Cells[Ord(stcSlope), ItemIndex+1] := Item.Slope;
      dgModflowBoundary.Cells[Ord(stcRough), ItemIndex+1] := Item.Roughness;
    end;
  end;

end;

procedure TframeScreenObjectStr.clbParametersClick(Sender: TObject);
begin
  inherited;
  UpdateConductanceCaption;
  Edited;
end;

procedure TframeScreenObjectStr.comboFormulaInterpChange(Sender: TObject);
begin
  inherited;
  UpdateConductanceCaption;
  Edited;
end;

procedure TframeScreenObjectStr.dgModflowBoundarySelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  if FCalculateStage and (ARow > 0) and (ACol = Ord(stcStage)) then
  begin
    CanSelect := false;
  end;
end;

procedure TframeScreenObjectStr.dgModflowBoundarySetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
begin
  inherited;
  Edited;
end;

procedure TframeScreenObjectStr.Edited;
begin
  if Assigned(FOnEdited) and not FChanging then
  begin
    FOnEdited(self);
  end;
end;

procedure TframeScreenObjectStr.GetData(
  ScreenObjectList: TScreenObjectEditCollection);
var
  LocalList: TList<TStrBoundary>;
  Index: Integer;
  Item: TScreenObjectEditItem;
  AScreenObject: TScreenObject;
begin
  ConductanceColumn := Ord(stcCond);
  FChanging := True;
  try
    InitializeControls;

    LocalList := TList<TStrBoundary>.Create;
    try
      for Index := 0 to ScreenObjectList.Count - 1 do
      begin
        Item := ScreenObjectList[Index];
        AScreenObject := Item.ScreenObject;
        if (AScreenObject.ModflowStrBoundary <> nil)
          and (AScreenObject.ModflowStrBoundary.Used) then
        begin
          LocalList.Add(AScreenObject.ModflowStrBoundary)
        end;
      end;
      if LocalList.Count > 0 then
      begin
        AssignFirstItem(LocalList);
        for Index := 1 to LocalList.Count - 1 do
        begin
          if not UpdateTimeTable(LocalList[Index]) then
          begin
            Break;
          end;
        end;
      end;
    finally
      LocalList.Free;
    end;
    UpdateConductanceCaption;
  finally
    FChanging := False;
  end;
end;

type TGridCrack = class(TStringGrid);

procedure TframeScreenObjectStr.InitializeControls;
var
  Parameters: TModflowTransientListParameters;
  ParamIndex: Integer;
  AParameter: TModflowTransientListParameter;
  RowIndex: Integer;
  ColIndex: Integer;
  StartTimes: TStrings;
  EndTimes: TStrings;
  TimeIndex: Integer;
  StressPeriod: TModflowStressPeriod;
begin
  comboFormulaInterp.ItemIndex := 0;
  Parameters := frmGoPhast.PhastModel.ModflowTransientParameters;
  clbParameters.Clear;
  if Parameters.CountParam(ptSTR) > 0 then
  begin
    if clbParameters.Visible  then
    begin
      pnlTop.ClientHeight := pnlCaption.Height + pnlNumber.Height
        + clbParameters.Height;
    end;
    clbParameters.Visible := True;
    clbParameters.Items.Add(StrNoParameter);
    for ParamIndex := 0 to Parameters.Count - 1 do
    begin
      AParameter := Parameters[ParamIndex];
      if AParameter.ParameterType = ptSTR then
      begin
        clbParameters.Items.AddObject(AParameter.ParameterName, AParameter);
      end;
    end;
    clbParameters.CheckedIndex := 0;
    clbParameters.EnabledItem[0] := False;
  end
  else
  begin
    clbParameters.Visible := False;
    pnlTop.ClientHeight := pnlCaption.Height + pnlNumber.Height;
  end;


  dgModflowBoundary.Column := 0;
  TGridCrack(dgModflowBoundary).HideEditor;
  dgModflowBoundary.Invalidate;
  dgModflowBoundary.BeginUpdate;
  try
    FCalculateStage := frmGoPhast.PhastModel.ModflowPackages.StrPackage.CalculateStage;
    if FCalculateStage then
    begin
      FFirstParamColumn := Ord(High(TStrTimeColumns))+1;
    end
    else
    begin
      FFirstParamColumn := Ord(stcStop)+1;
    end;
    dgModflowBoundary.ColCount := FFirstParamColumn;
    dgModflowBoundary.Cells[Ord(stcStartTime), 0] := StrStartingTime;
    dgModflowBoundary.Cells[Ord(stcEndTime), 0] := StrEndingTime;
    dgModflowBoundary.Cells[Ord(stcDownstreamSegment), 0] := StrOutflowSegmentItr;
    dgModflowBoundary.Cells[Ord(stcDiversionSegment), 0] := StrDiversionSegmentI;
    dgModflowBoundary.Cells[Ord(stcFlow), 0] := StrFlow;
    dgModflowBoundary.Cells[Ord(stcStage), 0] := StrHead;
    dgModflowBoundary.Cells[Ord(stcCond), 0] := ConductanceCaption(StrConductanceCond);
    dgModflowBoundary.Cells[Ord(stcSbot), 0] := StrStreambedBottomSb;
    dgModflowBoundary.Cells[Ord(stcStop), 0] := StrStreambedTopStop;
    if FCalculateStage then
    begin
      dgModflowBoundary.Cells[Ord(stcWidth), 0] := StrStreamWidthWidth;
      dgModflowBoundary.Cells[Ord(stcSlope), 0] := StrStreamSlopeSlope;
      dgModflowBoundary.Cells[Ord(stcRough), 0] := StrManningsRoughness;
    end;

    for RowIndex := dgModflowBoundary.FixedRows to
      dgModflowBoundary.RowCount - 1 do
    begin
      for ColIndex := dgModflowBoundary.FixedCols to
        dgModflowBoundary.ColCount - 1 do
      begin
        dgModflowBoundary.Cells[ColIndex, RowIndex] := '';
      end;
    end;
    for ColIndex := 0 to dgModflowBoundary.ColCount - 1 do
    begin
      dgModflowBoundary.ColWidths[ColIndex] := dgModflowBoundary.DefaultColWidth;
      dgModflowBoundary.Columns[ColIndex].AutoAdjustColWidths := True;
      dgModflowBoundary.Columns[ColIndex].AutoAdjustRowHeights := True;
      dgModflowBoundary.Columns[ColIndex].WordWrapCaptions := True;
    end;

    dgModflowBoundary.Columns[ord(stcStartTime)].Format := rcf4Real;
    dgModflowBoundary.Columns[ord(stcEndTime)].Format := rcf4Real;
    dgModflowBoundary.Columns[ord(stcDownstreamSegment)].Format := rcf4Integer;
    dgModflowBoundary.Columns[ord(stcDiversionSegment)].Format := rcf4Integer;
    dgModflowBoundary.Columns[ord(stcFlow)].Format := rcf4String;
    dgModflowBoundary.Columns[ord(stcStage)].Format := rcf4String;
    dgModflowBoundary.Columns[ord(stcCond)].Format := rcf4String;
    dgModflowBoundary.Columns[ord(stcSbot)].Format := rcf4String;
    dgModflowBoundary.Columns[ord(stcStop)].Format := rcf4String;

    dgModflowBoundary.Columns[ord(stcDownstreamSegment)].Min := 0;
    dgModflowBoundary.Columns[ord(stcDownstreamSegment)].CheckMin := True;
    dgModflowBoundary.Columns[ord(stcDiversionSegment)].Min := 0;
    dgModflowBoundary.Columns[ord(stcDownstreamSegment)].CheckMin := True;

    if FCalculateStage then
    begin
      dgModflowBoundary.Columns[ord(stcWidth)].Format := rcf4String;
      dgModflowBoundary.Columns[ord(stcSlope)].Format := rcf4String;
      dgModflowBoundary.Columns[ord(stcRough)].Format := rcf4String;
    end;

    StartTimes := dgModflowBoundary.Columns[Ord(stcStartTime)].PickList;
    StartTimes.Clear;
    EndTimes := dgModflowBoundary.Columns[Ord(stcEndTime)].PickList;
    EndTimes.Clear;
    for TimeIndex := 0 to frmGoPhast.PhastModel.ModflowStressPeriods.Count - 1 do
    begin
      StressPeriod := frmGoPhast.PhastModel.ModflowStressPeriods[TimeIndex];
      StartTimes.Add(FloatToStr(StressPeriod.StartTime));
      EndTimes.Add(FloatToStr(StressPeriod.EndTime));
    end;

    for ColIndex := Ord(stcDownstreamSegment) to Ord(stcDiversionSegment) do
    begin
      dgModflowBoundary.Columns[ColIndex].UseButton := True;
      dgModflowBoundary.Columns[ColIndex].ButtonCaption := StrNearest;
      dgModflowBoundary.Columns[ColIndex].ButtonWidth := 70;
      dgModflowBoundary.ColWidths[ColIndex] := 100;
    end;
    for ColIndex := Ord(stcFlow) to dgModflowBoundary.ColCount-1 do
    begin
      dgModflowBoundary.Columns[ColIndex].UseButton := True;
      dgModflowBoundary.Columns[ColIndex].ButtonCaption := StrF;
      dgModflowBoundary.Columns[ColIndex].ButtonWidth := 40;
    end;
  finally
    dgModflowBoundary.EndUpdate
  end;

  for ColIndex := Ord(stcFlow) to dgModflowBoundary.ColCount - 1 do
  begin
    dgModflowBoundary.Columns[ColIndex].AutoAdjustColWidths := false;
  end;

end;

procedure TframeScreenObjectStr.seNumberOfTimesChange(Sender: TObject);
begin
  inherited;
  Edited;
end;

procedure TframeScreenObjectStr.seSegmentNumberChange(Sender: TObject);
begin
  inherited;
  Edited;
end;

procedure TframeScreenObjectStr.SetData(List: TScreenObjectEditCollection;
  SetAll, ClearAll: boolean);
var
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TStrBoundary;
  BoundaryUsed: Boolean;
  ParamItem: TStrParamItem;
  Values: TStrCollection;
  RowIndex: Integer;
  StartTime: double;
  EndTime: double;
  ItemIndex: Integer;
  StrItem: TStrItem;
  SegNum: Integer;
  Formula: string;
begin
  for Index := 0 to List.Count - 1 do
  begin
    Item := List.Items[Index];
//    ScreenObject := Item.ScreenObject;
    Boundary := Item.ScreenObject.ModflowStrBoundary;
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
        Item.ScreenObject.CreateStrBoundary;
        Boundary := Item.ScreenObject.ModflowStrBoundary;
      end;
      if comboFormulaInterp.ItemIndex >= 0 then
      begin
        Boundary.FormulaInterpretation :=
          TFormulaInterpretation(comboFormulaInterp.ItemIndex);
      end;
      if seSegmentNumber.Enabled then
      begin
        Boundary.SegmentNumber := seSegmentNumber.AsInteger;
      end;
      if clbParameters.CheckedIndex > 0 then
      begin
        if Boundary.Parameters.Count = 0 then
        begin
          ParamItem := Boundary.Parameters.Add as TStrParamItem;
          if Boundary.Values.Count > 0 then
          begin
            ParamItem.Param.Assign(Boundary.Values);
            Boundary.Values.Clear;
          end;
        end
        else
        begin
          ParamItem := Boundary.Parameters[0] as TStrParamItem;
        end;
        ParamItem.Param.Param := clbParameters.Items.Objects[
          clbParameters.CheckedIndex] as TModflowTransientListParameter;
        Values := ParamItem.Param as TStrCollection;
      end
      else
      begin
        Values := Boundary.Values as TStrCollection;
        if Boundary.Parameters.Count > 0 then
        begin
          ParamItem := Boundary.Parameters[0] as TStrParamItem;
          Values.Assign(ParamItem.Param);
          Boundary.Parameters.Clear;
        end;
      end;
      ItemIndex := 0;
      for RowIndex := 1 to dgModflowBoundary.RowCount - 1 do
      begin
        if TryStrToFloat(dgModflowBoundary.Cells[Ord(stcStartTime), RowIndex], StartTime)
          and TryStrToFloat(dgModflowBoundary.Cells[Ord(stcEndTime), RowIndex], EndTime) then
        begin
          if ItemIndex >= Values.Count then
          begin
            StrItem := Values.Add as TStrItem;
          end
          else
          begin
            StrItem := Values[ItemIndex] as TStrItem;
          end;
          Inc(ItemIndex);
          StrItem.StartTime := StartTime;
          StrItem.EndTime := EndTime;

          if TryStrToInt(dgModflowBoundary.Cells[
            Ord(stcDownstreamSegment), RowIndex], SegNum) then
          begin
            StrItem.OutflowSegment := SegNum
          end;

          if TryStrToInt(dgModflowBoundary.Cells[
            Ord(stcDiversionSegment), RowIndex], SegNum) then
          begin                                
            StrItem.DiversionSegment := SegNum
          end;

          Formula := dgModflowBoundary.Cells[Ord(stcFlow), RowIndex];
          if Formula <> '' then
          begin
            StrItem.Flow := Formula;
          end;

          Formula := dgModflowBoundary.Cells[Ord(stcStage), RowIndex];
          if Formula <> '' then
          begin
            StrItem.Stage := Formula;
          end;

          Formula := dgModflowBoundary.Cells[Ord(stcCond), RowIndex];
          if Formula <> '' then
          begin
            StrItem.Conductance := Formula;
          end;

          Formula := dgModflowBoundary.Cells[Ord(stcSbot), RowIndex];
          if Formula <> '' then
          begin
            StrItem.BedBottom := Formula;
          end;

          Formula := dgModflowBoundary.Cells[Ord(stcStop), RowIndex];
          if Formula <> '' then
          begin
            StrItem.BedTop := Formula;
          end;

          if FCalculateStage then
          begin
            Formula := dgModflowBoundary.Cells[Ord(stcWidth), RowIndex];
            if Formula <> '' then
            begin
              StrItem.Width := Formula;
            end;

            Formula := dgModflowBoundary.Cells[Ord(stcSlope), RowIndex];
            if Formula <> '' then
            begin
              StrItem.Slope := Formula;
            end;

            Formula := dgModflowBoundary.Cells[Ord(stcRough), RowIndex];
            if Formula <> '' then
            begin
              StrItem.Roughness := Formula;
            end;
          end;
        end;
      end;
    end;
  end;

end;

procedure TframeScreenObjectStr.UpdateConductanceCaption;
begin
  if clbParameters.CheckedIndex > 0 then
  begin
    dgModflowBoundary.Cells[Ord(stcCond), 0] :=
      ConductanceCaption(StrConductanceCondMult);
  end
  else
  begin
    dgModflowBoundary.Cells[Ord(stcCond), 0] :=
      ConductanceCaption(StrConductanceCond);
  end;
end;

procedure TframeScreenObjectStr.UpdateTimeGridCell(Value: string; Column,
  Row: integer);
begin
  if dgModflowBoundary.Cells[Column,Row] <> Value then
  begin
    dgModflowBoundary.Cells[Column,Row] := '';
  end;
end;

function TframeScreenObjectStr.UpdateTimeTable(Boundary: TStrBoundary): boolean;
var
  ParamItem: TStrParamItem;
  Item: TStrItem;
//  AParam: TModflowTransientListParameter;
  Values: TStrCollection;
  ItemIndex: Integer;
  RowIndex: Integer;
  ColIndex: Integer;
  NewItemIndex: Integer;
begin
  seSegmentNumber.Enabled := False;
  if comboFormulaInterp.ItemIndex <> Ord(Boundary.FormulaInterpretation) then
  begin
    comboFormulaInterp.ItemIndex := -1;
  end;
  if Boundary.Parameters.Count > 0 then
  begin
    Assert(Boundary.Parameters.Count = 1);
    ParamItem := Boundary.Parameters[0] as TStrParamItem;
    Values := ParamItem.Param as TStrCollection;

//    AParam := ParamItem.Param.Param;
    NewItemIndex := clbParameters.Items.IndexOf(ParamItem.Param.ParamName);
  end
  else
  begin
    Values := Boundary.Values as TStrCollection;
    if clbParameters.Items.Count > 0 then
    begin
      NewItemIndex := 0;
    end
    else
    begin
      NewItemIndex := -1;
    end;
  end;

  if clbParameters.CheckedIndex <> NewItemIndex then
  begin
    clbParameters.CheckedIndex := -1;
  end;

  if Values.Count = seNumberOfTimes.AsInteger then
  begin
    result := True;
    for ItemIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[ItemIndex] as TStrItem;
      UpdateTimeGridCell(FloatToStr(Item.StartTime),
        Ord(stcStartTime), ItemIndex+1);
      UpdateTimeGridCell(FloatToStr(Item.EndTime),
        Ord(stcEndTime), ItemIndex+1);
      UpdateTimeGridCell(IntToStr(Item.OutflowSegment),
        Ord(stcDownstreamSegment), ItemIndex+1);
      UpdateTimeGridCell(IntToStr(Item.DiversionSegment),
        Ord(stcDiversionSegment), ItemIndex+1);
      UpdateTimeGridCell(Item.Flow, Ord(stcFlow), ItemIndex+1);
      UpdateTimeGridCell(Item.Stage, Ord(stcStage), ItemIndex+1);
      UpdateTimeGridCell(Item.Conductance, Ord(stcCond), ItemIndex+1);
      UpdateTimeGridCell(Item.BedBottom, Ord(stcSbot), ItemIndex+1);
      UpdateTimeGridCell(Item.BedTop, Ord(stcStop), ItemIndex+1);
      if FCalculateStage then
      begin
        UpdateTimeGridCell(Item.Width, Ord(stcWidth), ItemIndex+1);
        UpdateTimeGridCell(Item.Slope, Ord(stcSlope), ItemIndex+1);
        UpdateTimeGridCell(Item.Roughness, Ord(stcRough), ItemIndex+1);
      end;
    end;
  end
  else
  begin
    result := False;
    for RowIndex := 1 to dgModflowBoundary.RowCount - 1 do
    begin
      for ColIndex := 0 to dgModflowBoundary.ColCount - 1 do
      begin
        dgModflowBoundary.Cells[ColIndex, RowIndex] := '';
      end;
    end;
  end;
end;

end.
