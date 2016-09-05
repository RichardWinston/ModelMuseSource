unit ModpathStartingLocationsWriter;

interface

uses Classes, SysUtils, Contnrs , PhastModelUnit, ScreenObjectUnit,
  CustomModflowWriterUnit, ModflowPackageSelectionUnit;

type
  TParticleLines = class(TObject)
  private
    FSimulatedLocations: TStringList;
    FNonSimulatedLocations: TStringList;
    FReleaseTimes: TStringList;
    FTrackingDirection: TTrackingDirection;
    function GetNonSimulatedLocation(Index: integer): string;
    function GetSimulatedLocation(Index: integer): string;
  public
    Constructor Create(ScreenObject: TScreenObject;
      TrackingDirection: TTrackingDirection; StartTime, EndTime: Real);
    Destructor Destroy; override;
    procedure UpdateLocationLines(Lines: TStringList;
      Layer, Row, Column: integer; SimulatedLayer: boolean);
    property SimulatedLocations[Index: integer]: string read GetSimulatedLocation;
    property NonSimulatedLocations[Index: integer]: string read GetNonSimulatedLocation;
  end;

  // MODPATH versions 5 and 6
  TModpathStartingLocationsWriter = class(TCustomModflowWriter)
  private
    FParticleLines: TList;
    FCellList: TCellAssignmentList;
    FParticleGrid: array of array of array of TParticleLines;
    FStartingLocations: TStringList;
    FStartTime: Real;
    FEndTime: Real;
    procedure AssignParticleLocationsToElements;
    procedure UpdateParticleLines;
    procedure WriteLines;
  public
    function PackageID_Comment(APackage: TModflowPackageSelection): string; override;
    class function Extension: string; override;
    Constructor Create(Model: TCustomModel; EvaluationType: TEvaluationType); override;
    Destructor Destroy; override;
    procedure WriteFile(const AFileName: string);
    procedure WriteFileVersion6(const AFileName: string);
  end;

implementation

uses
  ModpathParticleUnit, ModflowTimeUnit, frmErrorsAndWarningsUnit,
  ModelMuseUtilities, frmGoPhastUnit, Math;

resourcestring
  StrAStartingTimeFor = 'Starting times for the MODPATH particles defined '
    + 'with the following objects are not valid. Adjust the beginning and '
    + 'ending time for MODPATH or adjust the release time.';
  StrInvalidMODPATHRefe = 'Invalid MODPATH reference time';
  StrTheReferenceTimeF = 'The reference time for a MODPATH simulation must b' +
  'e %s of the simulation specified in the MODFLOW Time dialog box. The refe' +
  'rence time is specified in the MODFLOW Packages and Programs dialog box.';
  StrGreaterOrEqualTo = 'greater or equal to than the initial time';
  StrLessThanOrEqualT = 'less than or equal to the final time';
//  StrNoMODPATHStarting = 'No MODPATH starting locations defined';
//  StrNoObjectsDefineSt = 'No objects define starting locations for MODPATH';

{ TModpathStartingLocationsWriter }

constructor TModpathStartingLocationsWriter.Create(Model: TCustomModel; EvaluationType: TEvaluationType);
begin
  inherited;
  FArrayWritingFormat := awfModflow;
  FParticleLines := TObjectList.Create;
  FCellList:= TCellAssignmentList.Create;
  FStartingLocations := TStringList.Create;
end;

destructor TModpathStartingLocationsWriter.Destroy;
begin
  FStartingLocations.Free;
  FCellList.Free;
  FParticleLines.Free;
  inherited;
end;

class function TModpathStartingLocationsWriter.Extension: string;
begin
  result := '.strt';
end;

function TModpathStartingLocationsWriter.PackageID_Comment(
  APackage: TModflowPackageSelection): string;
begin
  result := File_Comment(APackage.PackageIdentifier + ' Starting Locations file');
end;

procedure TModpathStartingLocationsWriter.WriteFile(const AFileName: string);
var
  NameOfFile: string;
  StressPeriods: TModflowStressPeriods;
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    StressPeriods := Model.ModflowStressPeriods;
    if StressPeriods.CompletelyTransient then
    begin
      FStartTime := Model.ModflowPackages.ModPath.BeginningTime;
    end
    else
    begin
      FStartTime := StressPeriods[0].StartTime;
    end;
    if StressPeriods.TransientModel then
    begin
      FEndTime := Model.ModflowPackages.ModPath.EndingTime;
    end
    else
    begin
      FEndTime := StressPeriods[StressPeriods.Count-1].EndTime;
    end;
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrAStartingTimeFor);

    NameOfFile := FileName(AFileName);
    Model.AddModpathInputFile(NameOfFile);
    OpenFile(NameOfFile);
    try
      AssignParticleLocationsToElements;
      UpdateParticleLines;
      WriteLines;
    finally
      CloseFile;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

procedure TModpathStartingLocationsWriter.WriteFileVersion6(
  const AFileName: string);
const
  InputStyle = 2;
  Grid = 1;
var
  ReferenceTime: Real;
  LocalModel: TCustomModel;
  Index: Integer;
  ScreenObject: TScreenObject;
  UsedObjects: TList;
  NameOfFile: string;
  FOptions: TModpathSelection;
  GroupCount: Integer;
  GroupName: string;
  Particles: TParticles;
  ObjectIndex: Integer;
  Cell: TCellAssignment;
  LocationCount: Integer;
//  ParticleCount: Integer;
  ReleaseStartTime: Double;
  ReleaseOption: Integer;
  ReleaseEventCount: Integer;
  TimeIndex: Integer;
  ReleaseTimes: TModpathTimes;
  ATime: Double;
  Layer: Integer;
  ParticleIndex: Integer;
  ParticleLines: TParticleLines;
  LocalXYZ: string;
  ParticleLabelBase: string;
  MaxLabelBaseLength: Integer;
  ParticleLabel: string;
  Digits: Int64;
  FormatString: string;
  ParticleCount: Integer;
  StressPeriods: TModflowStressPeriods;
begin
  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrInvalidMODPATHRefe);
//  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrNoMODPATHStarting);
  StressPeriods := Model.ModflowStressPeriods;
  FStartTime := StressPeriods[0].StartTime;
  FEndTime := StressPeriods[StressPeriods.Count-1].EndTime;
  NameOfFile := FileName(AFileName);
  Model.AddModpathInputFile(NameOfFile);
  OpenFile(NameOfFile);
  try
    LocalModel := Model;
    FOptions := LocalModel.ModflowPackages.ModPath;
    // Data set 0
    WriteCommentLine(PackageID_Comment(FOptions));
    WriteCommentLines(FOptions.Comments);
    // Data set 1
    WriteInteger(InputStyle);
    WriteString(' # Data Set 1: InputStyle');
    NewLine;

    if FOptions.ReferenceTime < Model.ModflowStressPeriods.First.StartTime then
    begin
      frmErrorsAndWarnings.AddError(Model, StrInvalidMODPATHRefe,
        Format(StrTheReferenceTimeF, [StrGreaterOrEqualTo]));
    end;
    if FOptions.ReferenceTime > Model.ModflowStressPeriods.Last.EndTime then
    begin
      frmErrorsAndWarnings.AddError(Model, StrInvalidMODPATHRefe,
        Format(StrTheReferenceTimeF, [StrLessThanOrEqualT]));
    end;

    ReferenceTime := FOptions.ReferenceTime
      - Model.ModflowStressPeriods[0].StartTime;

    UsedObjects := TList.Create;
    try
      for Index := 0 to LocalModel.ScreenObjectCount - 1 do
      begin
        ScreenObject := LocalModel.ScreenObjects[Index];
        if (not ScreenObject.Deleted) and ScreenObject.ModpathParticles.Used then
        begin
          UsedObjects.Add(ScreenObject);
        end;
      end;

      // Data set 6
      GroupCount := UsedObjects.Count;
      WriteInteger(GroupCount);
      WriteString(' # Data Set 6: GroupCount');
      NewLine;

      for Index := 0 to UsedObjects.Count - 1 do
      begin
        ScreenObject := UsedObjects[Index];
        // data set 7
        GroupName := ScreenObject.Name;
        if Length(GroupName) > 16 then
        begin
          SetLength(GroupName, 16);
        end;
        WriteString(GroupName);
        WriteString(' # Data Set 7: GroupName');
        NewLine;

        Particles := ScreenObject.ModpathParticles.Particles;

        FCellList.Clear;
        ScreenObject.GetModpathCellList(FCellList, LocalModel);
        LocationCount := FCellList.Count * Particles.Count;

        // data set 8
        WriteInteger(LocationCount);
        ReleaseTimes := ScreenObject.ModpathParticles.ReleaseTimes;
        ReleaseStartTime := ReleaseTimes[0].Time;
        WriteFloat(ReleaseStartTime);
        if ReleaseTimes.Count = 1 then
        begin
          ReleaseOption := 1;
        end
        else
        begin
          ReleaseOption := 3;
        end;
        WriteInteger(ReleaseOption);
        WriteString(' # Data Set 8: LocationCount ReleaseStartTime ReleaseOption');
        NewLine;

        // Data Set 10
        if ReleaseOption = 3 then
        begin
          ReleaseEventCount := ReleaseTimes.Count-1;
          WriteInteger(ReleaseEventCount);
          WriteString(' # Data Set 10: ReleaseEventCount');
          NewLine;

          // Data Set 11
          for TimeIndex := 1 to ReleaseTimes.Count - 1 do
          begin
            ATime := ReleaseTimes[TimeIndex].Time;// - FOptions.ReferenceTime;
//            if FOptions.TrackingDirection = tdBackward then
//            begin
//              ATime := -ATime;
//            end;
            WriteFloat(ATime);
            if ((TimeIndex mod 10) = 0) and (TimeIndex <> ReleaseTimes.Count - 1) then
            begin
              NewLine;
            end;
          end;
          if ReleaseTimes.Count > 0 then
          begin
            WriteString('Data Set 11: MultipleReleaseTimes');
            NewLine;
          end;
        end;

        // Data Set 12
        ParticleLabelBase := ScreenObject.Name;
        if LocationCount <= 0 then
        begin
          Digits := 0;
//          frmErrorsAndWarnings.AddError(Model, StrNoMODPATHStarting,
//            StrNoObjectsDefineSt);
        end
        else
        begin
          Digits := Trunc(Log10(LocationCount))+1;
        end;
        MaxLabelBaseLength := 39 - Digits;
        FormatString := '%.' + IntToStr(Digits) + 'd';
        if Length(ParticleLabelBase) > MaxLabelBaseLength then
        begin
          SetLength(ParticleLabelBase, MaxLabelBaseLength);
        end;
        ParticleLabelBase := ParticleLabelBase + '-';
        ParticleCount := 0;
        ParticleLines := TParticleLines.Create(ScreenObject,
          FOptions.TrackingDirection,
          FStartTime, FEndTime);
        try
          for ObjectIndex := 0 to FCellList.Count - 1 do
          begin
            Cell := FCellList[ObjectIndex];
            Layer := Model.DataSetLayerToModflowLayer(Cell.Layer);
            if not Model.IsLayerSimulated(Cell.Layer) then
            begin
              Dec(Layer);
            end;

            for ParticleIndex := 0 to Particles.Count - 1 do
            begin
              WriteInteger(Grid);
              WriteInteger(Layer);
              WriteInteger(Cell.Row+1);
              WriteInteger(Cell.Column+1);
              if Model.IsLayerSimulated(Cell.Layer) then
              begin
                LocalXYZ := ParticleLines.SimulatedLocations[ParticleIndex]
              end
              else
              begin
                LocalXYZ := ParticleLines.NonSimulatedLocations[ParticleIndex]
              end;
              WriteString(' ' + LocalXYZ);
              Inc(ParticleCount);
              ParticleLabel := ParticleLabelBase + Format(FormatString, [ParticleCount]);
              WriteString(ParticleLabel);
              WriteString(' # Data Set 12: Grid Layer Row Column LocalX LocalY LocalZ Label');
              NewLine;
            end;

          end;
        finally
          ParticleLines.Free;
        end;


      end;
    finally
      UsedObjects.Free;
    end;
  finally
    CloseFile;
  end;

end;

procedure TModpathStartingLocationsWriter.WriteLines;
var
  LineIndex: Integer;
begin
  for LineIndex := 0 to FStartingLocations.Count - 1 do
  begin
    WriteString(FStartingLocations[LineIndex]);
    NewLine;
  end;
end;

procedure TModpathStartingLocationsWriter.UpdateParticleLines;
var
  LayerIndex: Integer;
  SimulatedLayer: Boolean;
  RowIndex: Integer;
  ColumnIndex: Integer;
  ParticleLines: TParticleLines;
begin
  for LayerIndex := 0 to Model.Grid.LayerCount - 1 do
  begin
    SimulatedLayer := Model.IsLayerSimulated(LayerIndex);
    for RowIndex := 0 to Model.Grid.RowCount - 1 do
    begin
      for ColumnIndex := 0 to Model.Grid.ColumnCount - 1 do
      begin
        ParticleLines := FParticleGrid[LayerIndex, RowIndex, ColumnIndex];
        if ParticleLines <> nil then
        begin
          ParticleLines.UpdateLocationLines(FStartingLocations,
            LayerIndex + 1, RowIndex + 1, ColumnIndex + 1, SimulatedLayer);
        end;
      end;
    end;
  end;
end;

procedure TModpathStartingLocationsWriter.AssignParticleLocationsToElements;
var
  ScreenObject: TScreenObject;
  Index: Integer;
  Cell: TCellAssignment;
  ObjectIndex: Integer;
  ParticleLines: TParticleLines;
  LocalModel: TCustomModel;
begin
  LocalModel := Model;
  SetLength(FParticleGrid, LocalModel.Grid.LayerCount,
    LocalModel.Grid.RowCount, LocalModel.Grid.ColumnCount);
  for Index := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[Index];
    if (not ScreenObject.Deleted) and ScreenObject.ModpathParticles.Used then
    begin
      ParticleLines := TParticleLines.Create(ScreenObject,
        LocalModel.ModflowPackages.ModPath.TrackingDirection,
        FStartTime, FEndTime);
      FParticleLines.Add(ParticleLines);
      FCellList.Clear;
      ScreenObject.GetModpathCellList(FCellList, LocalModel);
      for ObjectIndex := 0 to FCellList.Count - 1 do
      begin
        Cell := FCellList[ObjectIndex];
        FParticleGrid[Cell.Layer, Cell.Row, Cell.Column] := ParticleLines;
      end;
    end;
  end;
end;

{ TParticleLines }

constructor TParticleLines.Create(ScreenObject: TScreenObject;
TrackingDirection: TTrackingDirection; StartTime, EndTime: Real);
var
  TimeIndex: Integer;
  ParticleReleaseTimes: TModpathTimes;
  TimeItem: TModpathTimeItem;
  Particles: TParticles;
  Index: Integer;
  ParticleItem: TParticleLocation;
  XYString: string;
  ReleaseTimeErrorDetected: boolean;
begin

  Assert(ScreenObject <> nil);
  Assert(not ScreenObject.Deleted);
  Assert(ScreenObject.ModpathParticles.Used);
  FTrackingDirection := TrackingDirection;
  FSimulatedLocations:= TStringList.Create;
  FNonSimulatedLocations:= TStringList.Create;
  FReleaseTimes:= TStringList.Create;
  ParticleReleaseTimes := ScreenObject.ModpathParticles.ReleaseTimes;
  FReleaseTimes.Capacity := ParticleReleaseTimes.Count;
  ReleaseTimeErrorDetected := False;
  for TimeIndex := 0 to ParticleReleaseTimes.Count - 1 do
  begin
    TimeItem := ParticleReleaseTimes.Items[TimeIndex] as TModpathTimeItem;
    if (not ReleaseTimeErrorDetected) and (FTrackingDirection = tdForward) and
      ((TimeItem.Time < 0) or (TimeItem.Time > EndTime-StartTime)) then
    begin
      frmErrorsAndWarnings.AddError(frmGoPhast.PhastModel, StrAStartingTimeFor,
        ScreenObject.Name, ScreenObject);
      ReleaseTimeErrorDetected := True;
    end;
    FReleaseTimes.Add(FortranFloatToStr(TimeItem.Time));
  end;
  Particles := ScreenObject.ModpathParticles.Particles;
  for Index := 0 to Particles.Count - 1 do
  begin
    ParticleItem := Particles.Items[Index] as TParticleLocation;
    XYString := FortranFloatToStr(ParticleItem.X) + ' '
      + FortranFloatToStr(1-ParticleItem.Y) + ' ';
    FSimulatedLocations.Add(XYString + FortranFloatToStr(ParticleItem.Z)
      + ' 0 0 0 ');
    FNonSimulatedLocations.Add(XYString + FortranFloatToStr(1-ParticleItem.Z)
      + ' 0 0 0 ');
  end;
end;

destructor TParticleLines.Destroy;
begin
  FSimulatedLocations.Free;
  FNonSimulatedLocations.Free;
  FReleaseTimes.Free;
  inherited;
end;

function TParticleLines.GetNonSimulatedLocation(Index: integer): string;
begin
  result := FNonSimulatedLocations[Index];
end;

function TParticleLines.GetSimulatedLocation(Index: integer): string;
begin
  result := FSimulatedLocations[Index];
end;

procedure TParticleLines.UpdateLocationLines(Lines: TStringList; Layer, Row,
  Column: integer; SimulatedLayer: boolean);
var
  CellLine: string;
  TimeIndex: Integer;
  TimeString: string;
  ParticleIndex: Integer;
  TimeCount: integer;
begin
  CellLine := IntToStr(Column) + ' '
    + IntToStr(Row) + ' ' + IntToStr(Layer) + ' ';
  TimeCount := FReleaseTimes.Count;
  if FTrackingDirection = tdBackward then
  begin
    TimeCount := 1;
  end;
  for TimeIndex := 0 to TimeCount - 1 do
  begin
    case FTrackingDirection of
      tdForward:
        begin
          TimeString := FReleaseTimes[TimeIndex];
        end;
      tdBackward:
        begin
          TimeString := '0';
        end;
      else Assert(False);
    end;
    if SimulatedLayer then
    begin
      for ParticleIndex := 0 to FSimulatedLocations.Count - 1 do
      begin
        Lines.Add(CellLine + FSimulatedLocations[ParticleIndex]
          + TimeString + ' # J I K X Y Z JCODE ICODE KCODE TRELEAS');
      end;
    end
    else
    begin
      for ParticleIndex := 0 to FNonSimulatedLocations.Count - 1 do
      begin
        Lines.Add(CellLine + FNonSimulatedLocations[ParticleIndex]
          + TimeString + ' # J I K X Y Z JCODE ICODE KCODE TRELEAS');
      end;
    end;
  end;
end;

end.
