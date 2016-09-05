unit LegendUnit;

interface

uses Classes, GoPhastTypes, ColorSchemes, DataSetUnit, ValueArrayStorageUnit,
  Math, Graphics, SysUtils, EdgeDisplayUnit, Types, SubscriptionUnit,
  ContourUnit, PathlineReader;

type
  TLegendType = (ltColor, ltContour, ltEndpoints);

  TValueAssignmentMethod = (vamNoLegend, vamAutomatic, vamManual);

  TLegend = class(TGoPhastPersistent)
  private
    FColoringLimits: TColoringLimits;
    FColorParameters: TColorParameters;
    FLegendType: TLegendType;
    FValues: TValueArrayStorage;
    FValueAssignmentMethod: TValueAssignmentMethod;
    FValueSource: TObserver;
    FEdgeDataToPlot: integer;
    FFractions: TValueArrayStorage;
    StringValues: TStringList;
    FContours: TContours;
    FValueSourceInterface: IDisplayer;
    procedure SetColoringLimits(const Value: TColoringLimits);
    procedure SetColorParameters(const Value: TColorParameters);
    procedure SetLegendType(const Value: TLegendType);
    procedure SetValues(const Value: TValueArrayStorage);
    procedure SetValueAssignmentMethod(const Value: TValueAssignmentMethod);
    procedure SetValueSource(const Value: TObserver);
    procedure HasChanged(Sender: TObject);
    procedure SetEdgeDataToPlot(const Value: integer);
    procedure GetStringValues(StringValues: TStringList; DataArray: TDataArray);
    procedure SetFractions(const Value: TValueArrayStorage);
    procedure GetIntegerLimits(var MinInteger, MaxInteger: Integer;
      DataArray: TDataArray);
    procedure GetRealNumberLimits(var MinReal, MaxReal: double;
      DataArray: TDataArray);
    procedure GetRealLimitsForEdgeDisplay(var MinReal, MaxReal: double;
      EdgeDisplay: TCustomModflowGridEdgeDisplay);
    function GetFractions: TValueArrayStorage;
    procedure SetValueSourceInterface(const Value: IDisplayer);
  public
    procedure Assign(Source: TPersistent); override;
    Constructor Create(InvalidateModelEvent: TNotifyEvent);
    destructor Destroy; override;
    property ValueSource: TObserver read FValueSource write SetValueSource;
    property ValueSourceInterface: IDisplayer read FValueSourceInterface
      write SetValueSourceInterface;
    procedure AutoAssignValues;
    function AssignFractions: Boolean;
    procedure Draw(Canvas: TCanvas; StartX, StartY: integer;
      out LegendRect: TRect; Font: TFont);
    property Fractions: TValueArrayStorage read GetFractions write SetFractions;
    property Contours: TContours read FContours write FContours;
  published
    property ColorParameters: TColorParameters read FColorParameters
      write SetColorParameters;
    property ColoringLimits: TColoringLimits read FColoringLimits
      write SetColoringLimits;
    property LegendType: TLegendType read FLegendType write SetLegendType;
    property Values: TValueArrayStorage read FValues write SetValues;
    property ValueAssignmentMethod: TValueAssignmentMethod
      read FValueAssignmentMethod write SetValueAssignmentMethod;
    property EdgeDataToPlot: integer read FEdgeDataToPlot
      write SetEdgeDataToPlot;
  end;

implementation

uses
  PhastModelUnit, RbwParser, frmGoPhastUnit, SutraMeshUnit, GR32;

{ TLegend }

procedure TLegend.Assign(Source: TPersistent);
var
  SourceLegend: TLegend;
begin
  if Source is TLegend then
  begin
    SourceLegend := TLegend(Source);
    ColorParameters := SourceLegend.ColorParameters;
    ColoringLimits := SourceLegend.ColoringLimits;
    LegendType := SourceLegend.LegendType;
    Values := SourceLegend.Values;
    ValueAssignmentMethod := SourceLegend.ValueAssignmentMethod;
    EdgeDataToPlot := SourceLegend.EdgeDataToPlot;
  end
  else
  begin
    inherited;
  end;
end;

function TLegend.AssignFractions: Boolean;
var
  DataArray: TDataArray;
  Index: Integer;
  MinInteger: Integer;
  MaxInteger: Integer;
  IntRange: Integer;
  StringPos: Integer;
  PhastModel: TPhastModel;
  MinReal: double;
  MaxReal: double;
  RealRange: Double;
  EdgeDisplay: TCustomModflowGridEdgeDisplay;
  AFraction: double;
  Contours: TContours;
begin
  result := True;
  Assert(Assigned(ValueSourceInterface) or (ValueSource <> nil));
  if Assigned(ValueSourceInterface) then
  begin
    Fractions.Count := Values.Count;
    ValueSourceInterface.GetMinMaxValues(MaxReal, MinReal);
    if ColoringLimits.LogTransform then
    begin
      MinReal := Log10(MinReal);
      MaxReal := Log10(MaxReal);
      RealRange := MaxReal - MinReal;
      for Index := 0 to Values.Count - 1 do
      begin
        if RealRange = 0 then
        begin
          AFraction := 0.5
        end
        else
        begin
          if Values.RealValues[Index] <= MinReal then
          begin
            AFraction := 0;
          end
          else
          begin
            AFraction := 1 - (Log10(
              Values.RealValues[Index]) - MinReal)/RealRange;
          end;
        end;
        if AFraction < 0 then
        begin
          AFraction := 0;
        end
        else if AFraction > 1 then
        begin
          AFraction := 1;
        end;
        Fractions.RealValues[Index] := AFraction
      end
    end
    else
    begin
      RealRange := MaxReal - MinReal;
      for Index := 0 to Values.Count - 1 do
      begin
        if RealRange = 0 then
        begin
          AFraction := 0.5
        end
        else
        begin
          try
            AFraction := 1 - (Values.RealValues[Index] - MinReal)/RealRange;
          except on EOverflow do
            begin
              AFraction := 0.5;
            end;
          end;
        end;
        if AFraction < 0 then
        begin
          AFraction := 0;
        end
        else if AFraction > 1 then
        begin
          AFraction := 1;
        end;
        Fractions.RealValues[Index] := AFraction
      end
    end;
  end
  else if (ValueSource is TDataArray) then
  begin
    DataArray := TDataArray(ValueSource);
    DataArray.Initialize;
    Fractions.Count := Values.Count;
    case DataArray.DataType of
      rdtDouble:
        begin
          if (Fractions.Count = 1) then
          begin
            Fractions.RealValues[0] := 0.5
          end
          else
          begin
            case LegendType of
              ltColor, ltEndpoints:
                begin
                  GetRealNumberLimits(MinReal, MaxReal, DataArray);
                end;
              ltContour:
                begin
                  Contours := DataArray.Contours;
                  if Contours = nil then
                  begin
                    result := False;
                    Exit;
//                    GetRealNumberLimits(MinReal, MaxReal, DataArray);
                  end
                  else
                  begin
                    if Contours.Count = 0 then
                    begin
                      Exit;
                    end;
                    MinReal := Contours.ContourValues[0];
                    MaxReal := Contours.ContourValues[
                      Length(Contours.ContourValues)-1];
                  end;
                end;
            end;
            if ColoringLimits.LogTransform then
            begin
              if (LegendType = ltContour) or ((MinReal > 0) and (MaxReal > 0)) then
              begin
                if LegendType in [ltColor, ltEndpoints] then
                begin
                  MinReal := Log10(MinReal);
                  MaxReal := Log10(MaxReal);
                end;
                RealRange := MaxReal - MinReal;
                for Index := 0 to Values.Count - 1 do
                begin
                  if RealRange = 0 then
                  begin
                    AFraction := 0.5
                  end
                  else
                  begin
                    if Values.RealValues[Index] <= MinReal then
                    begin
                      AFraction := 0;
                    end
                    else
                    begin
                      AFraction := 1 - (Log10(
                        Values.RealValues[Index]) - MinReal)/RealRange;
                    end;
                  end;
                  if AFraction < 0 then
                  begin
                    AFraction := 0;
                  end
                  else if AFraction > 1 then
                  begin
                    AFraction := 1;
                  end;
                  Fractions.RealValues[Index] := AFraction
                end;
              end;
            end
            else
            begin
              RealRange := MaxReal - MinReal;
              for Index := 0 to Values.Count - 1 do
              begin
                if RealRange = 0 then
                begin
                  AFraction := 0.5
                end
                else
                begin
                  try
                    AFraction := 1 - (Values.RealValues[Index] - MinReal)/RealRange;
                  except on EOverflow do
                    begin
                      AFraction := 0.5;
                    end;
                  end;
                end;
                if AFraction < 0 then
                begin
                  AFraction := 0;
                end
                else if AFraction > 1 then
                begin
                  AFraction := 1;
                end;
                Fractions.RealValues[Index] := AFraction
              end;
            end;
          end;
        end;
      rdtInteger:
        begin
          if (Fractions.Count = 1) then
          begin
            Fractions.RealValues[0] := 0.5
          end
          else
          begin
            GetIntegerLimits(MinInteger, MaxInteger, DataArray);
            IntRange := MaxInteger - MinInteger;
            for Index := 0 to Values.Count - 1 do
            begin
              if IntRange = 0 then
              begin
                AFraction := 0.5;
              end
              else
              begin
                AFraction := 1 - (Values.IntValues[Index] - MinInteger)/IntRange;
              end;
              if AFraction < 0 then
              begin
                AFraction := 0;
              end
              else if AFraction > 1 then
              begin
                AFraction := 1;
              end;
              Fractions.RealValues[Index] := AFraction;
            end;
          end;
        end;
      rdtBoolean:
        begin
          if Values.Count = 1 then
          begin
            Fractions.RealValues[0] := 0.5;
          end
          else
          begin
            for Index := 0 to Values.Count - 1 do
            begin
              Fractions.RealValues[Index] := Ord(Values.BooleanValues[Index]);
            end;
          end;
        end;
      rdtString:
        begin
          if Fractions.Count = 1 then
          begin
            Fractions.RealValues[0] := 0.5
          end
          else
          begin
            StringValues := TStringList.Create;
            try
              GetStringValues(StringValues, DataArray);
              for Index := 0 to Values.Count - 1 do
              begin
                StringPos := StringValues.IndexOf(Values.StringValues[Index]);
                if StringPos < 0 then
                begin
                  StringPos := StringValues.Add(Values.StringValues[Index]);
                  StringValues.Delete(StringPos);
                  if StringPos = StringValues.Count then
                  begin
                    Dec(StringPos);
                  end;
                end;
                Fractions.RealValues[Index] := 1 - StringPos/(StringValues.Count -1);
              end;
            finally
              StringValues.Free;
            end;
          end;
        end;
      else Assert(False);
    end;
    PhastModel := frmGoPhast.PhastModel;
    PhastModel.DataArrayManager.AddDataSetToCache(DataArray);
    PhastModel.DataArrayManager.CacheDataArrays;
  end
  else
  begin
    EdgeDisplay := ValueSource as TCustomModflowGridEdgeDisplay;
    Fractions.Count := Values.Count;
    if Fractions.Count = 1 then
    begin
      Fractions.RealValues[0] := 0.5
    end
    else
    begin
      GetRealLimitsForEdgeDisplay(MinReal, MaxReal, EdgeDisplay);
      if ColoringLimits.LogTransform then
      begin
        if (MinReal > 0) and (MaxReal > 0) then
        begin
          MinReal := Log10(MinReal);
          MaxReal := Log10(MaxReal);
          RealRange := MaxReal - MinReal;
          for Index := 0 to Values.Count - 1 do
          begin
            AFraction := 1 - (Log10(Values.RealValues[Index]) - MinReal)/RealRange;
            if AFraction < 0 then
            begin
              AFraction := 0;
            end
            else if AFraction > 1 then
            begin
              AFraction := 1;
            end;
            Fractions.RealValues[Index] := AFraction
          end;
        end;
      end
      else
      begin
        RealRange := MaxReal - MinReal;
        for Index := 0 to Values.Count - 1 do
        begin
          AFraction := 1 - (Values.RealValues[Index] - MinReal)/RealRange;
          if AFraction < 0 then
          begin
            AFraction := 0;
          end
          else if AFraction > 1 then
          begin
            AFraction := 1;
          end;
          Fractions.RealValues[Index] := AFraction
        end;
      end;
    end;
  end;
end;

procedure TLegend.AutoAssignValues;
Const
  IntervalCount = 9;
var
  DataArray: TDataArray;
  EdgeDisplay: TCustomModflowGridEdgeDisplay;
  PhastModel: TPhastModel;
  Delta: extended;
  MaxReal: double;
  MinReal: double;
  Range: integer;
  Index: Integer;
  MaxInteger: Integer;
  MinInteger: Integer;
  IntegerIntervals: Integer;
  MaxBoolean: Boolean;
  MinBoolean: Boolean;
  StringValues: TStringList;
  MaxString: string;
  MinString: string;
  StringPos: Integer;
  Contours: TContours;
  DSIndex: Integer;
  procedure  AssignRealValues;
  var
    Index: Integer;
  begin
    if MaxReal = MinReal then
    begin
      Values.Clear;
      Values.Add(MaxReal);
    end
    else
    begin
      Values.Count := IntervalCount+1;

      if ColoringLimits.LogTransform then
      begin
        if (MinReal > 0) and (MaxReal > 0) then
        begin
          MinReal := Log10(MinReal);
          MaxReal := Log10(MaxReal);
          Delta := (MaxReal - MinReal)/IntervalCount;
          for Index := 0 to IntervalCount do
          begin
            Values.RealValues[Index] := Power(10.,
              MinReal + Delta*Index);
          end;
        end;
      end
      else
      begin
        Delta := (MaxReal - MinReal)/IntervalCount;
        for Index := 0 to IntervalCount do
        begin
          Values.RealValues[Index] := MinReal
            + Delta*Index
        end;
      end;
    end;
  end;
begin
  if (ValueAssignmentMethod = vamAutomatic) then
  begin
    if Assigned(ValueSourceInterface) then
    begin
      ValueSourceInterface.GetMinMaxValues(MaxReal, MinReal);
      AssignRealValues;
    end
    else
    begin

      Assert(ValueSource <> nil);
      if (ValueSource is TDataArray) then
      begin
        DataArray := TDataArray(ValueSource);
        Values.DataType := DataArray.DataType;
        DataArray.Initialize;
        case LegendType of
          ltColor, ltEndpoints:
            begin
              case DataArray.DataType of
                rdtDouble:
                  begin
                    GetRealNumberLimits(MinReal, MaxReal, DataArray);
                    AssignRealValues;
                  end;
                rdtInteger:
                  begin
                    GetIntegerLimits(MinInteger, MaxInteger, DataArray);

                    if MaxInteger = MinInteger then
                    begin
                      Values.Clear;
                      Values.Add(MaxInteger);
                    end
                    else
                    begin
                      Range := MaxInteger-MinInteger;
                      IntegerIntervals := Min(Range,IntervalCount);
                      Values.Count := Min(Range,IntervalCount)+1;
                      for Index := 0 to Values.Count -1 do
                      begin
                        Values.IntValues[Index] := Round(MinInteger
                          + Range / IntegerIntervals * Index);
                      end;
                    end;
                  end;
                rdtBoolean:
                  begin
                    if ColoringLimits.UpperLimit.UseLimit then
                    begin
                      MaxBoolean := ColoringLimits.UpperLimit.BooleanLimitValue;
                    end
                    else
                    begin
                      MaxBoolean := True;
                    end;

                    if ColoringLimits.LowerLimit.UseLimit then
                    begin
                      MinBoolean := ColoringLimits.LowerLimit.BooleanLimitValue;
                    end
                    else
                    begin
                      MinBoolean := False;
                    end;

                    if MaxBoolean = MinBoolean then
                    begin
                      Values.Clear;
                      Values.Add(MaxBoolean);
                    end
                    else
                    begin
                      Values.Clear;
                      Values.Add(MinBoolean);
                      Values.Add(MaxBoolean);
                    end;
                  end;
                rdtString:
                  begin
                    StringValues := TStringList.Create;
                    try
                      GetStringValues(StringValues, DataArray);

                      if ColoringLimits.UpperLimit.UseLimit then
                      begin
                        MaxString := ColoringLimits.UpperLimit.StringLimitValue;
                      end
                      else
                      begin
                        if StringValues.Count > 0 then
                        begin
                          MaxString := StringValues[StringValues.Count-1];
                        end
                        else
                        begin
                          MaxString := DataArray.MaxString;
                        end;
                      end;

                      if ColoringLimits.LowerLimit.UseLimit then
                      begin
                        MinString := ColoringLimits.LowerLimit.StringLimitValue;
                      end
                      else
                      begin
                        if StringValues.Count > 0 then
                        begin
                          MinString := StringValues[0];
                        end
                        else
                        begin
                          MinString := DataArray.MinString;
                        end;
                      end;

                      if MaxString = MinString then
                      begin
                        Values.Clear;
                        Values.Add(MaxString);
                      end
                      else
                      begin
                        MinInteger := 0;
                        MaxInteger := StringValues.Count -1;

                        Range := MaxInteger-MinInteger;
                        IntegerIntervals := Min(Range,IntervalCount);
                        Values.Count := Min(Range,IntervalCount)+1;
                        if IntegerIntervals = 0 then
                        begin
                          IntegerIntervals := 1;
                        end;
                        for Index := 0 to Values.Count -1 do
                        begin
                          StringPos := MinInteger
                            + (Range div IntegerIntervals) * Index;
                          Values.StringValues[Index] := StringValues[StringPos];
                        end;
                      end;
                    finally
                      StringValues.Free;
                    end;
                  end;
                else Assert(False)
              end;
            end;
          ltContour:
            begin
              Contours := DataArray.Contours;
              if Contours <> nil then
              begin
                Values.Count := Contours.Count;
                case DataArray.DataType of
                  rdtDouble:
                    begin
                      if ColoringLimits.LogTransform then
                      begin
                        if Length(Contours.ContourValues) > 0 then
                        begin
                          MinReal := Contours.ContourValues[0];
                        end
                        else
                        begin
                          MinReal := 0;
                        end;
  //                      if MinReal > 0 then
                        begin
                          for Index := 0 to Contours.Count - 1 do
                          begin
                            Values.RealValues[Index] := Power(10.,Contours.ContourValues[Index]);
                          end;
                        end;
                      end
                      else
                      begin
                        for Index := 0 to Contours.Count - 1 do
                        begin
                          Values.RealValues[Index] := Contours.ContourValues[Index]
                        end;
                      end;
                    end;
                  rdtInteger:
                    begin
                      for Index := 0 to Contours.Count - 1 do
                      begin
                        Values.IntValues[Index] := Round(Contours.ContourValues[Index]);
                      end;
                    end;
                  rdtBoolean:
                    begin
                      if Contours.Count = 1 then
                      begin
                        Values.BooleanValues[0] := False;
                      end
                      else if Contours.Count <> 0 then
                      begin
                        Assert(False);
                      end;
                    end;
                    rdtString:
                      begin
                        for Index := 0 to Contours.Count - 1 do
                        begin
                          DSIndex := Round(Contours.ContourValues[Index]);
                          Values.StringValues[Index] :=
                            Contours.ContourStringValues[DSIndex]
                        end;
                      end;
                  else
                    Assert(False);
                end;
              end;
            end;
          else
            Assert(False);
        end;
        PhastModel := frmGoPhast.PhastModel;
        PhastModel.DataArrayManager.AddDataSetToCache(DataArray);
        PhastModel.DataArrayManager.CacheDataArrays;
      end
      else
      begin
        Assert(ValueSource is TCustomModflowGridEdgeDisplay);
        EdgeDisplay := TCustomModflowGridEdgeDisplay(ValueSource);
        EdgeDisplay.UpdateData;
        Values.DataType := rdtDouble;
        GetRealLimitsForEdgeDisplay(MinReal, MaxReal, EdgeDisplay);

        if MaxReal = MinReal then
        begin
          Values.Clear;
          Values.Add(MaxReal);
        end
        else
        begin
          Values.Count := IntervalCount+1;
          Delta := (MaxReal - MinReal)/IntervalCount;
          for Index := 0 to IntervalCount do
          begin
            Values.RealValues[Index] := MinReal
              + Delta*Index
          end;
        end;
      end;
    end;
  end;
end;

procedure TLegend.GetStringValues(StringValues: TStringList;
  DataArray: TDataArray);
var
  MaxString: string;
  MinString: string;
  StringPos: Integer;
  Index: Integer;
  Model: TCustomModel;
  MinMax: TMinMax;
begin
  Model := DataArray.Model as TCustomModel;

  if Model.Grid <> nil then
  begin
    Model.Grid.GetMinMax(MinMax, DataArray, StringValues);
  end
  else
  begin
    Model.Mesh.GetMinMax(MinMax, DataArray, StringValues);
  end;


//  DataArray.Initialize;

  if ColoringLimits.UpperLimit.UseLimit then
  begin
    MaxString := ColoringLimits.UpperLimit.StringLimitValue;
  end
  else
  begin
    MaxString := MinMax.SMax;
  end;

  if ColoringLimits.LowerLimit.UseLimit then
  begin
    MinString := ColoringLimits.LowerLimit.StringLimitValue;
  end
  else
  begin
    MinString := MinMax.SMin;
  end;

//  StringValues.Clear;
//  StringValues.CaseSensitive := False;
//  StringValues.Duplicates := dupIgnore;
//  StringValues.Sorted := True;
//  StringValues.Capacity := DataArray.LayerCount
//    * DataArray.RowCount * DataArray.ColumnCount;
//  for LayerIndex := 0 to DataArray.LayerCount - 1 do
//  begin
//    for RowIndex := 0 to DataArray.RowCount - 1 do
//    begin
//      for ColIndex := 0 to DataArray.ColumnCount - 1 do
//      begin
//        if DataArray.IsValue[LayerIndex, RowIndex, ColIndex] then
//        begin
//          StringValues.Add(DataArray.StringData[LayerIndex, RowIndex, ColIndex]);
//        end;
//      end;
//    end;
//  end;

  if StringValues.Count > 0 then
  begin
    if StringValues[StringValues.Count -1] <> MaxString then
    begin
      if not StringValues.Find(MaxString, StringPos) then
      begin
        Dec(StringPos)
      end;
      Assert(StringPos >= -1);
      for Index := StringValues.Count -1 downto StringPos + 1 do
      begin
        StringValues.Delete(Index);
      end;
    end;

    StringValues.Find(MinString, StringPos);
  //  StringPos := StringValues.IndexOf(MinString);
    Assert(StringPos >= 0);
    if StringPos > 0 then
    begin
      for Index := StringPos-1 downto 0 do
      begin
        StringValues.Delete(Index);
      end;
    end;
  end;
end;

constructor TLegend.Create(InvalidateModelEvent: TNotifyEvent);
begin
  inherited;
  FValueSource := nil;
  FValues := TValueArrayStorage.Create;
  FFractions := TValueArrayStorage.Create;
  FFractions.DataType := rdtDouble;
  FColoringLimits := TColoringLimits.Create;
  FColorParameters := TColorParameters.Create;

  FColoringLimits.OnChange := HasChanged;
  FColorParameters.OnChange := HasChanged;
end;

destructor TLegend.Destroy;
begin
  FColorParameters.Free;
  FColoringLimits.Free;
  FFractions.Free;
  FValues.Free;
  inherited;
end;

procedure TLegend.Draw(Canvas: TCanvas; StartX, StartY: integer;
  out LegendRect: TRect; Font: TFont);
var
  Index: Integer;
  X: Integer;
  AColor: TColor;
  Y: Integer;
  YLine: Integer;
  LegendText: string;
  TextHeight: Integer;
  TextX: Integer;
  DeltaY: integer;
  BoxWidth: integer;
  TextSeparation: integer;
  ARect: TRect;
  Extent: TSize;
  CustomColorSchemes: TUserDefinedColorSchemeCollection;
  ACustomColorScheme: TUserDefinedColorSchemeItem;
  ContourValues: TOneDRealArray;
  ContourColors: TArrayOfColor32;
  ColorIndex: Integer;
  ColorItem: TColorItem;
  AMinValue: Double;
  AMaxValue: Double;
  DeltaValue: Double;
begin
  LegendRect.Top := StartY;
  LegendRect.Left := StartX;
  LegendRect.BottomRight := LegendRect.TopLeft;

  Canvas.Font.Assign(Font);

  TextHeight := Canvas.TextHeight('0');
  DeltaY := (TextHeight * 3) div 2;
  BoxWidth := DeltaY * 2;
  TextSeparation := DeltaY div 2;
  X := StartX;
  TextX := X + BoxWidth + TextSeparation;

  Canvas.Pen.Color := clBlack;

  case LegendType of
    ltColor: LegendText := 'Color legend';
    ltContour: LegendText := 'Contour legend';
    ltEndpoints: LegendText := 'Endpoints legend';
    else Assert(False);
  end;
  Extent := Canvas.TextExtent(LegendText);
  ARect.Left := StartX;
  ARect.Top := StartY;
  ARect.Right := TextX + Extent.cx;
  ARect.Bottom := StartY + Extent.cy;

  {$IF CompilerVersion >= 23.0}
  // Delphi XE2 and up
  System.Types.UnionRect(LegendRect, LegendRect, ARect);
  {$ELSE}
  // Delphi XE and earlier
  Types.UnionRect(LegendRect, LegendRect, ARect);
  {$IFEND}

  Canvas.TextOut(X, StartY, LegendText);
  StartY := StartY + DeltaY;

  CustomColorSchemes := nil;
  ACustomColorScheme := nil;
  try

    if (LegendType = ltContour) and (Contours <> nil)
      and Contours.SpecifyContours and not Contours.AutomaticColors then
    begin
      CustomColorSchemes := TUserDefinedColorSchemeCollection.Create(nil);
      ACustomColorScheme := CustomColorSchemes.Add;
      ContourValues := Contours.ContourValues;
      ContourColors := Contours.ContourColors;
      if Length(ContourValues) <> Length(ContourColors) then
      begin
        Exit;
      end;
      Assert(Length(ContourValues) = Length(ContourColors));
      if Length(ContourValues) > 0  then
      begin
        AMinValue := ContourValues[0];
        AMaxValue := ContourValues[Length(ContourValues)-1];
        DeltaValue := AMaxValue-AMinValue;
        for ColorIndex := 0 to Length(ContourValues) - 1 do
        begin
          ColorItem := ACustomColorScheme.Colors.Add;
          ColorItem.Color := WinColor(ContourColors[ColorIndex]);
          if ColorIndex = 0 then
          begin
            ColorItem.Fraction := 0;
          end
          else if ColorIndex = Length(ContourValues)-1 then
          begin
            ColorItem.Fraction := 1;
          end
          else if (AMinValue = AMaxValue) then
          begin
            ColorItem.Fraction := 0.5;
          end
          else
          begin
            ColorItem.Fraction := (ContourValues[ColorIndex]-AMinValue)/DeltaValue;
          end;
        end;
      end
      else
      begin
        ACustomColorScheme := nil;
      end;
    end;
//      CustomColorSchemes := TUserDefinedColorSchemeItem.Create;
//      CustomColorSchemes.
//    end;

  //  Assert(Fractions.Count <= Values.Count);
    for Index := 0 to Min(Fractions.Count, Values.Count) - 1 do
    begin
      if ACustomColorScheme = nil then
      begin
        AColor := ColorParameters.FracToColor(Fractions.RealValues[Index]);
      end
      else
      begin
        AColor := ColorParameters.FracToColor(Fractions.RealValues[Index],
          ACustomColorScheme);
      end;
      Y := StartY + DeltaY*Index;
      Canvas.Brush.Color := AColor;
      case LegendType of
        ltColor, ltEndpoints:
          begin
            ARect := Rect(X,Y,X+BoxWidth,Y+DeltaY);
          end;
        ltContour:
          begin
            Canvas.Pen.Color := AColor;
            YLine := Y + DeltaY div 2;
            ARect := Rect(X,YLine-1,X+BoxWidth,YLine+1);
          end;
        else Assert(False);
      end;
      Canvas.Rectangle(ARect);

      {$IF CompilerVersion >= 23.0}
      // Delphi XE2 and up
      System.Types.UnionRect(LegendRect, LegendRect, ARect);
      {$ELSE}
      // Delphi XE and earlier
      Types.UnionRect(LegendRect, LegendRect, ARect);
      {$IFEND}

      Canvas.Brush.Color := clWhite;
      Y := Y + ((DeltaY - TextHeight) div 2);

      case Values.DataType of
        rdtDouble:
          begin
//            if ColoringLimits.LogTransform then
//            begin
//              LegendText := FloatToStrF(Power(10,Values.RealValues[Index]), ffGeneral, 7, 0);
//            end
//            else
//            begin
              LegendText := FloatToStrF(Values.RealValues[Index], ffGeneral, 7, 0);
//            end;
          end;
        rdtInteger:
          begin
            LegendText := IntToStr(Values.IntValues[Index])
          end;
        rdtBoolean:
          begin
            if Values.BooleanValues[Index] then
            begin
              LegendText := 'True';
            end
            else
            begin
              LegendText := 'False';
            end;
          end;
        rdtString:
          begin
            LegendText := Values.StringValues[Index];
          end;
        else Assert(False);
      end;

      Extent := Canvas.TextExtent(LegendText);
      ARect.Left := TextX;
      ARect.Top := Y;
      ARect.Right := TextX + Extent.cx;
      ARect.Bottom := Y + Extent.cy;
      {$IF CompilerVersion >= 23.0}
      // Delphi XE2 and up
      System.Types.UnionRect(LegendRect, LegendRect, ARect);
      {$ELSE}
      // Delphi XE and earlier
      Types.UnionRect(LegendRect, LegendRect, ARect);
      {$IFEND}

      Canvas.TextOut(TextX, Y, LegendText);
    end;
  finally
    CustomColorSchemes.Free;
  end;
end;

procedure TLegend.GetRealLimitsForEdgeDisplay(var MinReal, MaxReal: double;
  EdgeDisplay: TCustomModflowGridEdgeDisplay);
var
  Index: Integer;
  Edge: TCustomModflowGridEdgeFeature;
begin
  MaxReal := 0;
  MinReal := 0;
  for Index := 0 to EdgeDisplay.Count - 1 do
  begin
    Edge := EdgeDisplay.Edges[Index];
    if Index = 0 then
    begin
      MaxReal := Edge.RealValue[EdgeDataToPlot];
      MinReal := MaxReal;
    end
    else
    begin
      if MaxReal < Edge.RealValue[EdgeDataToPlot] then
      begin
        MaxReal := Edge.RealValue[EdgeDataToPlot];
      end;
      if MinReal > Edge.RealValue[EdgeDataToPlot] then
      begin
        MinReal := Edge.RealValue[EdgeDataToPlot];
      end;
    end;
  end;
  if ColoringLimits.UpperLimit.UseLimit then
  begin
    MaxReal := ColoringLimits.UpperLimit.RealLimitValue;
  end;
  if ColoringLimits.LowerLimit.UseLimit then
  begin
    MinReal := ColoringLimits.LowerLimit.RealLimitValue;
  end;
end;

procedure TLegend.GetRealNumberLimits(var MinReal, MaxReal: double;
  DataArray: TDataArray);
var
  Model: TCustomModel;
  MinMax: TMinMax;
  StringList: TStringList;
  Mesh: TSutraMesh3D;
begin
  Model := DataArray.Model as TCustomModel;

  StringList := TStringList.Create;
  try
    if Model.Grid <> nil then
    begin
      Model.Grid.GetMinMax(MinMax, DataArray, StringList);
    end
    else
    begin
      Mesh := Model.Mesh;
      if Mesh <> nil then
      begin
        Mesh.GetMinMax(MinMax, DataArray, StringList);
      end;
    end;

  finally
    StringList.Free;
  end;

//  Model.Grid.GetRealMinMax(DataArray, MinMax);
  MaxReal := MinMax.RMax;
  if ColoringLimits.LogTransform then
  begin
    MinReal := MinMax.RMinPositive;
  end
  else
  begin
    MinReal := MinMax.RMin;
  end;
end;

function TLegend.GetFractions: TValueArrayStorage;
begin
  result := FFractions;
end;

procedure TLegend.GetIntegerLimits(var MinInteger, MaxInteger: Integer;
  DataArray: TDataArray);
var
  Model: TCustomModel;
  MinMax: TMinMax;
  StringList: TStringList;
  Mesh: TSutraMesh3D;
begin
  Model := DataArray.Model as TCustomModel;

  StringList := TStringList.Create;
  try
    if Model.Grid <> nil then
    begin
      Model.Grid.GetMinMax(MinMax, DataArray, StringList);
    end
    else
    begin
      Mesh := Model.Mesh;
      if Mesh <> nil then
      begin
        Mesh.GetMinMax(MinMax, DataArray, StringList);
      end;
    end;
  finally
    StringList.Free;
  end;

  if ColoringLimits.UpperLimit.UseLimit then
  begin
    MaxInteger := ColoringLimits.UpperLimit.IntegerLimitValue;
  end
  else
  begin
    MaxInteger := MinMax.IMax
  end;
  if ColoringLimits.LowerLimit.UseLimit then
  begin
    MinInteger := ColoringLimits.LowerLimit.IntegerLimitValue;
  end
  else
  begin
    MinInteger := MinMax.IMin
  end;
end;

procedure TLegend.HasChanged(Sender: TObject);
begin
  InvalidateModel;
end;

procedure TLegend.SetColoringLimits(const Value: TColoringLimits);
begin
  FColoringLimits.Assign(Value);
end;

procedure TLegend.SetColorParameters(const Value: TColorParameters);
begin
  FColorParameters.Assign(Value);
end;

procedure TLegend.SetEdgeDataToPlot(const Value: integer);
begin
  if FEdgeDataToPlot <> Value then
  begin
    FEdgeDataToPlot := Value;
    InvalidateModel;
  end;
end;

procedure TLegend.SetFractions(const Value: TValueArrayStorage);
begin
  FFractions.Assign(Value);
end;

procedure TLegend.SetLegendType(const Value: TLegendType);
begin
  if FLegendType <> Value then
  begin
    FLegendType := Value;
    InvalidateModel;
  end;
end;

procedure TLegend.SetValueAssignmentMethod(const Value: TValueAssignmentMethod);
begin
  if FValueAssignmentMethod <> Value then
  begin
    FValueAssignmentMethod := Value;
    InvalidateModel;
  end;
end;

procedure TLegend.SetValues(const Value: TValueArrayStorage);
begin
  FValues.Assign(Value);
end;

procedure TLegend.SetValueSource(const Value: TObserver);
begin
  if FValueSource <> Value then
  begin
    if Value <> nil then
    begin
      Assert((Value is TDataArray) or (Value is TCustomModflowGridEdgeDisplay));
    end;
    FValueSource := Value;
    InvalidateModel;
  end;
end;

procedure TLegend.SetValueSourceInterface(const Value: IDisplayer);
begin
  FValueSourceInterface := Value;
end;

end.
