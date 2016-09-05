unit AdjustSutraBoundaryValuesUnit;

interface

uses
  SutraBoundariesUnit, GoPhastTypes, SutraTimeScheduleUnit;

procedure AdjustBoundaryValues(ASchedule: TSutraTimeSchedule;
  SutraValues: TCustomSutraBoundaryCollection);

implementation

uses
  ModflowBoundaryUnit, RealListUnit, frmGoPhastUnit;

procedure AdjustBoundaryValues(ASchedule: TSutraTimeSchedule;
  SutraValues: TCustomSutraBoundaryCollection);
var
//  SutraValues: TCustomSutraBoundaryCollection;
//  ASchedule: TSutraTimeSchedule;
//  SameValues: Boolean;
  TimeIndex: Integer;
//  Form: TfrmSutraTimeAdjustChoice;
//  AdjustChoice: TAdjustChoice;
  SutraTimeOptions: TSutraTimeOptions;
  TimeValues: TOneDRealArray;
  TimeList: TRealList;
  Item: TCustomBoundaryItem;
  TimePos: Integer;
begin
  SutraTimeOptions := frmGoPhast.PhastModel.SutraTimeOptions;
//  ASchedule := comboSchedule.Items.Objects[comboSchedule.ItemIndex]
//    as TSutraTimeSchedule;
  TimeValues := ASchedule.TimeValues(SutraTimeOptions.InitialTime,
     SutraTimeOptions.Schedules);

  TimeList := TRealList.Create;
  try
    for TimeIndex := 0 to Length(TimeValues) - 1 do
    begin
      TimeList.Add(TimeValues[TimeIndex]);
    end;
    TimeList.Sort;

    for TimeIndex := SutraValues.Count - 1 downto 0 do
    begin
      Item := SutraValues[TimeIndex];
      TimePos := TimeList.IndexOfClosest(Item.StartTime);
      Item.StartTime := TimeList[TimePos];
    end;

    for TimeIndex := SutraValues.Count - 1 downto 1 do
    begin
      if SutraValues[TimeIndex].StartTime = SutraValues[TimeIndex-1].StartTime then
      begin
        SutraValues.Delete(TimeIndex-1);
      end;
    end;
  finally
    TimeList.Free;
  end;

//  SameValues := Length(TimeValues) = SutraValues.Count;
//  if SameValues then
//  begin
//    for TimeIndex := 0 to SutraValues.Count - 1 do
//    begin
//      SameValues := TimeValues[TimeIndex] = SutraValues[TimeIndex].StartTime;
//      if not SameValues then
//      begin
//        break;
//      end;
//    end;
//  end;
//  if not SameValues then
//  begin
//    Beep;
//    Form := TfrmSutraTimeAdjustChoice.Create(nil);
//    try
//      Form.ShowModal;
//      AdjustChoice := Form.AdjustChoice;
//    finally
//      Form.Free;
//    end;
//    case AdjustChoice of
//      acUseSchedule:
//        begin
//          if Length(TimeValues) = SutraValues.Count then
//          begin
//            for TimeIndex := 0 to SutraValues.Count - 1 do
//            begin
//              SutraValues[TimeIndex].StartTime := TimeValues[TimeIndex];
//            end;
//          end
//          else
//          begin
//            AdjustBoundaryTimes(TimeValues, SutraValues);
//          end;
//          DisplayBoundaries(SutraValues);
//        end;
//      acConvert:
//        begin
//          comboSchedule.ItemIndex := 0;
//        end;
//    else
//      Assert(False);
//    end;
//  end;
end;

end.
