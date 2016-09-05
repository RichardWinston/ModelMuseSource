unit ModflowTimeUnit;

interface

uses SysUtils, Classes, RbwDataGrid4, GoPhastTypes;

type
  // @name defines the types of stress periods supported by MODFLOW.
  // @value(sptSteadyState Steady-state stress period)
  // @value(sptTransient Transient stress period)
  TStressPeriodType = (sptSteadyState, sptTransient);

  // @name represents a single stress period in MODFLOW.
  TModflowStressPeriod = class(TCollectionItem)
  private
    // See @link(EndTime).
    FEndTime: double;
    // See @link(MaxLengthOfFirstTimeStep).
    FMaxLengthOfFirstTimeStep: double;
    // See @link(PeriodLength).
    FPeriodLength: double;
    // See @link(StartTime).
    FStartTime: double;
    // See @link(StressPeriodType).
    FStressPeriodType: TStressPeriodType;
    // See @link(TimeStepMultiplier).
    FTimeStepMultiplier: double;
    FDrawDownReference: boolean;
    // @name calls @link(TBaseModel.Invalidate) indirectly.
    procedure InvalidateModel;
    // See @link(EndTime).
    procedure SetEndTime(const Value: double);
    // See @link(MaxLengthOfFirstTimeStep).
    procedure SetMaxLengthOfFirstTimeStep(const Value: double);
    // See @link(PeriodLength).
    procedure SetPeriodLength(const Value: double);
    // See @link(StartTime).
    procedure SetStartTime(const Value: double);
    // See @link(StressPeriodType).
    procedure SetStressPeriodType(const Value: TStressPeriodType);
    // See @link(TimeStepMultiplier).
    procedure SetTimeStepMultiplier(const Value: double);
    procedure SetDrawDownReference(const Value: boolean);
  public
    // @name copies Source to the current @classname.
    procedure Assign(Source: TPersistent); override;
    // @name initializes the properties of the @classname
    // and calls @link(InvalidateModel).
    constructor Create(Collection: TCollection); override;
    // @name calls @link(InvalidateModel).
    destructor Destroy; override;
    // @name is the number of steps in a stress period.
    function NumberOfSteps: integer;
    function LengthOfFirstTimeStep: double;
  published
    // If @name is true, the head at the end of this stress period
    // will be used as a reference head for computing drawdown.
    property DrawDownReference: boolean read FDrawDownReference write SetDrawDownReference;
    // @name is the time of the end of the stress period.
    // @name is not exported but it is used in @link(TfrmModflowTime)
    // to calculate the length of the stress period (PeriodLength).
    property EndTime: double read FEndTime write SetEndTime;
    // @name is the maximum allowable length (as specified by the user)
    // of the first time step in a stress period.
    property MaxLengthOfFirstTimeStep: double read FMaxLengthOfFirstTimeStep
      write SetMaxLengthOfFirstTimeStep;
    // @name is the length of the stress period.
    property PeriodLength: double read FPeriodLength write SetPeriodLength;
    // @name is the time of the start of the stress period.
    // @name is not exported but it is used in @link(TfrmModflowTime)
    // to calculate the length of the stress period (PeriodLength).
    property StartTime: double read FStartTime write SetStartTime;
    // @name indicates whether this is a steady-state or transient
    // stress period.
    property StressPeriodType: TStressPeriodType read FStressPeriodType
      write SetStressPeriodType;
    // @name indicates the fraction by which each time step increases in size
    // over the length of the previous time step in the same stress period.
    property TimeStepMultiplier: double read FTimeStepMultiplier
      write SetTimeStepMultiplier;
  end;

  // @name is a collection of the data defining all the stress periods
  // in the model.
  TModflowStressPeriods = class(TCollection)
  private
    // @name is is used to invalidate a model
    FOnInvalidateModel: TNotifyEvent;
    // See @link(Items).
    function GetItems(Index: Integer): TModflowStressPeriod;
    // @name calls @link(TBaseModel.Invalidate) indirectly.
    procedure InvalidateModel;
    // See @link(Items).
    procedure SetItems(Index: Integer; const Value: TModflowStressPeriod);
    function GetNumberOfSteps: integer;
    function GetFirst: TModflowStressPeriod;
    function GetLast: TModflowStressPeriod;
  public
    // @name copies Source to the current @classname.
    procedure Assign(Source: TPersistent); override;
    // @name creates an instance of @classname.
    constructor Create(InvalidateModelEvent: TNotifyEvent);
    // @name is used to access a @link(TModflowStressPeriod)
    // stored in @classname.
    property Items[Index: Integer]: TModflowStressPeriod
      read GetItems write SetItems; default;
    // @name writes the stress periods to the MODFLOW discretization file.
    procedure WriteStressPeriods(const DiscretizationWriter: TObject);
    procedure WriteMt3dmsStressPeriods(const Mt3dmsBasicWriter: TObject);
    // @name returns true if any stress period in the model is transient.
    function TransientModel: boolean;
    // @name returns @true if every stress period is transient.
    Function CompletelyTransient: boolean;
    procedure FillPickListWithEndTimes(Grid: TRbwDataGrid4; Col: integer);
    procedure FillPickListWithStartTimes(Grid: TRbwDataGrid4; Col: integer);
    // @name determines the stress period and time step corresponding
    // to a particular time.  Period and Step are zero based.
    procedure TimeToPeriodAndStep(ATime: double; out Period, Step: integer);
    property NumberOfSteps: integer read GetNumberOfSteps;
    procedure FillStringsWithStartTimes(Strings: TStrings);
    procedure FillStringsWithEndTimes(Strings: TStrings);
    function MaxStepsInAnyStressPeriod: integer;
    // @name returns the number of the first stress period that contains ATime.
    function FindStressPeriod(ATime: double): integer;
    function FindEndStressPeriod(ATime: double): integer;
    property First: TModflowStressPeriod read GetFirst;
    property Last: TModflowStressPeriod read GetLast;
  end;

function GetNumberOfTimeSteps(const PerLength, MaxFirstTimeStepLength,
  TimeStepMultiplier: real): integer;

implementation

uses RTLConsts, Math, ModflowDiscretizationWriterUnit,
  frmErrorsAndWarningsUnit, Mt3dmsBtnWriterUnit, Mt3dmsTimesUnit,
  ModflowPackageSelectionUnit;

resourcestring
  StrUnusualUseOfDrawd = 'Unusual use of Drawdown reference option';
  StrTheFirstAndOnlyS = 'The first and only stress period in the model is '
    + 'also used as a reference period for computing drawdown.  Drawdown will '
    + 'always be zero under these conditions.';
  StrInStressPeriodD = 'In stress period %d, a transient stress period is us' +
  'ed as a reference stress period for computing drawdown.';

{ TModflowStressPeriod }

function GetNumberOfTimeSteps(const PerLength, MaxFirstTimeStepLength,
  TimeStepMultiplier: real): integer;
const
  Epsilon = 1e-8;
  AdjustmentFactor = 1-Epsilon;
var
  TimeStepLength: double;
  TotalTime: double;
begin
  if PerLength <= 0 then
  begin
    result := 1;
  end
  else if MaxFirstTimeStepLength <= 0 then
  begin
    result := MAXINT;
  end
  else if TimeStepMultiplier = 1 then
  begin
    result := Ceil((PerLength/MaxFirstTimeStepLength)*AdjustmentFactor);
  end
  else
  begin
    TimeStepLength := MaxFirstTimeStepLength;
    TotalTime := MaxFirstTimeStepLength;
    result := 1;
    while TotalTime < PerLength*AdjustmentFactor do
    begin
      TimeStepLength := TimeStepLength * TimeStepMultiplier;
      TotalTime := TotalTime + TimeStepLength;
      Inc(result);
    end;
  end;
end;


procedure TModflowStressPeriod.Assign(Source: TPersistent);
var
  SourceMFStressPeriod: TModflowStressPeriod;
begin
  if Source is TModflowStressPeriod then
  begin
    SourceMFStressPeriod := TModflowStressPeriod(Source);
    StartTime := SourceMFStressPeriod.StartTime;
    EndTime := SourceMFStressPeriod.EndTime;
    MaxLengthOfFirstTimeStep := SourceMFStressPeriod.MaxLengthOfFirstTimeStep;
    PeriodLength := SourceMFStressPeriod.PeriodLength;
    TimeStepMultiplier := SourceMFStressPeriod.TimeStepMultiplier;
    StressPeriodType := SourceMFStressPeriod.StressPeriodType;
    DrawDownReference := SourceMFStressPeriod.DrawDownReference;
  end
  else
  begin
    inherited;
  end;
end;

constructor TModflowStressPeriod.Create(Collection: TCollection);
begin
  inherited;
  FStartTime := 0;
  FEndTime := 0;
  FPeriodLength := 0;
  FTimeStepMultiplier := 0;
  FDrawDownReference := False;
  FStressPeriodType := sptSteadyState;
  InvalidateModel;
end;

destructor TModflowStressPeriod.Destroy;
begin
  InvalidateModel;
  inherited;
end;

procedure TModflowStressPeriod.InvalidateModel;
begin
  (Collection as TModflowStressPeriods).InvalidateModel;
end;

function TModflowStressPeriod.LengthOfFirstTimeStep: double;
begin
  if TimeStepMultiplier = 1 then
  begin
    result := PeriodLength/NumberOfSteps;
  end
  else
  begin
    result := PeriodLength*(TimeStepMultiplier-1)/
      (Power(TimeStepMultiplier,NumberOfSteps) - 1);
  end;
end;

function TModflowStressPeriod.NumberOfSteps: integer;
begin
  result := GetNumberOfTimeSteps(PeriodLength, MaxLengthOfFirstTimeStep,
    TimeStepMultiplier);
end;

procedure TModflowStressPeriod.SetMaxLengthOfFirstTimeStep(
  const Value: double);
begin
  if FMaxLengthOfFirstTimeStep <> Value then
  begin
    FMaxLengthOfFirstTimeStep := Value;
    InvalidateModel;
  end;
end;

procedure TModflowStressPeriod.SetDrawDownReference(const Value: boolean);
begin
  if FDrawDownReference <> Value then
  begin
    FDrawDownReference := Value;
    InvalidateModel;
  end;
end;

procedure TModflowStressPeriod.SetEndTime(const Value: double);
begin
  if FEndTime <> Value then
  begin
    FEndTime := Value;
    InvalidateModel;
  end;
end;

procedure TModflowStressPeriod.SetPeriodLength(const Value: double);
begin
  if FPeriodLength <> Value then
  begin
    FPeriodLength := Value;
    InvalidateModel;
  end;
end;

procedure TModflowStressPeriod.SetStartTime(const Value: double);
begin
  if FStartTime <> Value then
  begin
    FStartTime := Value;
    InvalidateModel;
  end;
end;

procedure TModflowStressPeriod.SetStressPeriodType(
  const Value: TStressPeriodType);
begin
  if FStressPeriodType <> Value then
  begin
    FStressPeriodType := Value;
    InvalidateModel;
  end;
end;

procedure TModflowStressPeriod.SetTimeStepMultiplier(const Value: double);
begin
  if FTimeStepMultiplier <> Value then
  begin
    FTimeStepMultiplier := Value;
    InvalidateModel;
  end;
end;

{ TModflowStressPeriods }

procedure TModflowStressPeriods.Assign(Source: TPersistent);
var
  SourceName: string;
  SourceMFStressPeriods: TModflowStressPeriods;
  Index: Integer;
begin
  if Source is TModflowStressPeriods then
  begin
    SourceMFStressPeriods := TModflowStressPeriods(Source);
    if Count = SourceMFStressPeriods.Count then
    begin
      for Index := 0 to Count - 1 do
      begin
        Items[Index].Assign(SourceMFStressPeriods[Index]);
      end;
    end
    else
    begin
      inherited Assign(Source);
    end;
  end
  else
  begin
    if Source <> nil then
      SourceName := Source.ClassName else
      SourceName := 'nil';
    raise EConvertError.CreateResFmt(@SAssignError, [SourceName, ClassName]);
  end;
end;

function TModflowStressPeriods.CompletelyTransient: boolean;
var
  Index: Integer;
begin
  result := True;
  for Index := 0 to Count - 1 do
  begin
    if Items[Index].StressPeriodType <> sptTransient then
    begin
      result := False;
      Exit;
    end;
  end;
end;

constructor TModflowStressPeriods.Create(InvalidateModelEvent: TNotifyEvent);
begin
  FOnInvalidateModel := InvalidateModelEvent;
  inherited Create(TModflowStressPeriod);
end;

procedure TModflowStressPeriods.FillPickListWithEndTimes(Grid: TRbwDataGrid4; Col: integer);
var
  Strings: TStrings;
begin
  Strings := Grid.Columns[Col].PickList;
  FillStringsWithEndTimes(Strings);
end;

procedure TModflowStressPeriods.FillPickListWithStartTimes(Grid: TRbwDataGrid4;
  Col: integer);
var
  Strings: TStrings;
begin
  Strings := Grid.Columns[Col].PickList;
  FillStringsWithStartTimes(Strings);
end;

function TModflowStressPeriods.GetFirst: TModflowStressPeriod;
begin
  result := Items[0];
end;

function TModflowStressPeriods.GetItems(Index: Integer): TModflowStressPeriod;
begin
  result := inherited Items[Index] as TModflowStressPeriod;
end;

function TModflowStressPeriods.GetLast: TModflowStressPeriod;
begin
  result := Items[Count-1];
end;

function TModflowStressPeriods.GetNumberOfSteps: integer;
var
  Index: Integer;
  StressPeriod: TModflowStressPeriod;
begin
  result := 0;
  for Index := 0 to Count - 1 do
  begin
    StressPeriod := Items[Index];
    result := result + StressPeriod.NumberOfSteps;
  end;
end;

procedure TModflowStressPeriods.InvalidateModel;
begin
  if Assigned(FOnInvalidateModel) then
  begin
    FOnInvalidateModel(self);
  end;
end;

function TModflowStressPeriods.MaxStepsInAnyStressPeriod: integer;
var
  Index: Integer;
  StressPeriod: TModflowStressPeriod;
begin
  result := 0;
  for Index := 0 to Count - 1 do
  begin
    StressPeriod := Items[Index];
    if result < StressPeriod.NumberOfSteps then
    begin
      result := StressPeriod.NumberOfSteps;
    end;
  end;
end;

procedure TModflowStressPeriods.SetItems(Index: Integer;
  const Value: TModflowStressPeriod);
begin
  inherited Items[Index] := Value;
end;

procedure TModflowStressPeriods.TimeToPeriodAndStep(ATime: double; out Period,
  Step: integer);
var
  PeriodIndex: Integer;
  StressPeriod: TModflowStressPeriod;
  ElapsedTime: Double;
  StepCount: Integer;
  TimeStepLength: Double;
  StepIndex: Integer;
begin
  Period := -1;
  Step := -1;
  for PeriodIndex := 0 to Count - 1 do
  begin
    StressPeriod := Items[PeriodIndex];
    if (StressPeriod.StartTime <= ATime) and (StressPeriod.EndTime > ATime) then
    begin
      Period := PeriodIndex;
      ElapsedTime := StressPeriod.StartTime;
      StepCount := StressPeriod.NumberOfSteps;
      TimeStepLength := StressPeriod.LengthOfFirstTimeStep;
      for StepIndex := 0 to StepCount - 1 do
      begin
        ElapsedTime := ElapsedTime + TimeStepLength;
        if (ElapsedTime >= ATime) then
        begin
          Step := StepIndex;
          Exit;
        end;
        TimeStepLength := TimeStepLength*StressPeriod.TimeStepMultiplier;
      end;
      Step := StepCount-1;
      Exit;
    end;
  end;
  Period := Count - 1;
  StressPeriod := Items[Period];
  Step := StressPeriod.NumberOfSteps-1;
end;

procedure TModflowStressPeriods.FillStringsWithEndTimes(Strings: TStrings);
var
  TimeIndex: Integer;
  StressPeriod: TModflowStressPeriod;
begin
  Strings.Clear;
  Strings.Capacity := Count;
  for TimeIndex := 0 to Count - 1 do
  begin
    StressPeriod := Items[TimeIndex];
    Strings.Add(FloatToStr(StressPeriod.EndTime));
  end;
end;

procedure TModflowStressPeriods.FillStringsWithStartTimes(Strings: TStrings);
var
  StressPeriod: TModflowStressPeriod;
  TimeIndex: Integer;
begin
  Strings.Clear;
  Strings.Capacity := Count;
  for TimeIndex := 0 to Count - 1 do
  begin
    StressPeriod := Items[TimeIndex];
    Strings.Add(FloatToStr(StressPeriod.StartTime));
  end;
end;

function TModflowStressPeriods.FindEndStressPeriod(ATime: double): integer;
var
  Index: Integer;
  StressPeriod: TModflowStressPeriod;
begin
  result := -1;
  for Index := 0 to Count - 1 do
  begin
    StressPeriod := Items[Index];
    if (StressPeriod.StartTime <= ATime)
      and (StressPeriod.EndTime >= ATime) then
    begin
      result := Index;
      Exit;
    end;
  end;
end;

function TModflowStressPeriods.FindStressPeriod(ATime: double): integer;
var
  Index: Integer;
  StressPeriod: TModflowStressPeriod;
begin
  result := -1;
  for Index := 0 to Count - 1 do
  begin
    StressPeriod := Items[Index];
    if (StressPeriod.StartTime <= ATime) then
    begin
      if Index = Count -1 then
      begin
        if (StressPeriod.EndTime >= ATime) then
        begin
          result := Index;
          Exit;
        end;
      end
      else
      begin
        if (StressPeriod.EndTime > ATime) then
        begin
          result := Index;
          Exit;
        end;
      end;
    end;
  end;
end;

function TModflowStressPeriods.TransientModel: boolean;
var
  Index: Integer;
begin
  result := False;
  for Index := 0 to Count - 1 do
  begin
    if Items[Index].StressPeriodType = sptTransient then
    begin
      result := True;
      Exit;
    end;
  end;
end;

procedure TModflowStressPeriods.WriteMt3dmsStressPeriods(
  const Mt3dmsBasicWriter: TObject);
var
  Mt3dmsBtnWriter: TMt3dmsBtnWriter;
  Index: Integer;
  StressPeriod: TModflowStressPeriod;
  Mt3dmsTime: TMt3dmsTimeItem;
  Mt3dmsAdvection: TMt3dmsAdvection;
  SSFlag: Boolean;
begin
  Mt3dmsBtnWriter := Mt3dmsBasicWriter as TMt3dmsBtnWriter;
  for Index := 0 to Count - 1 do
  begin
    StressPeriod := Items[Index];
    Mt3dmsBtnWriter.WriteF10Float(StressPeriod.PeriodLength);
    Mt3dmsBtnWriter.WriteI10Integer(
      StressPeriod.NumberOfSteps, 'MT3DMS Basic, NSTP');
    Mt3dmsBtnWriter.WriteF10Float(StressPeriod.TimeStepMultiplier);


    Mt3dmsAdvection :=  Mt3dmsBtnWriter.Model.ModflowPackages.Mt3dmsAdvection;
    if not Mt3dmsAdvection.IsSelected
      or (Mt3dmsAdvection.AdvectionSolution <> asStandard) then
    begin
      SSFlag := False;
    end
    else
    begin
      Mt3dmsTime := Mt3dmsBtnWriter.Model.Mt3dmsTimes.GetItemFromTime(StressPeriod.StartTime);
      if Mt3dmsTime = nil then
      begin
        frmErrorsAndWarnings.AddError(Mt3dmsBtnWriter.Model, StrTimeDataForMT3DMS,
          Format(StrNoTimeDataHasBee, [StressPeriod.Index+1]) );
        Exit;
      end;
      SSFlag :=  Mt3dmsTime.SteadyState;
    end;
    if SSFlag then
    begin
      Mt3dmsBtnWriter.WriteString(' SSTATE');
    end;

    Mt3dmsBtnWriter.WriteString(
      ' # Data Set 21: PERLEN NSTP TSMULT SSflag (Stress period '
      + IntToStr(Index+1) + ')');
    Mt3dmsBtnWriter.NewLine;
    Mt3dmsBtnWriter.WriteDataSet22(StressPeriod);
    Mt3dmsBtnWriter.WriteDataSet23(StressPeriod);
  end;
end;

procedure TModflowStressPeriods.WriteStressPeriods(
  const DiscretizationWriter: TObject);
var
  Mt3dmsBtnWriter: TModflowDiscretizationWriter;
  Index: Integer;
  StressPeriod: TModflowStressPeriod;
begin
  Mt3dmsBtnWriter := DiscretizationWriter as TModflowDiscretizationWriter;
  for Index := 0 to Count - 1 do
  begin
    StressPeriod := Items[Index];
    Mt3dmsBtnWriter.WriteFloat(StressPeriod.PeriodLength);
    Mt3dmsBtnWriter.WriteInteger(StressPeriod.NumberOfSteps);
    Mt3dmsBtnWriter.WriteFloat(StressPeriod.TimeStepMultiplier);
    case StressPeriod.StressPeriodType of
      sptSteadyState: Mt3dmsBtnWriter.WriteString(' SS');
      sptTransient: Mt3dmsBtnWriter.WriteString(' TR');
      else Assert(False);
    end;
    Mt3dmsBtnWriter.WriteString(' # PERLEN NSTP TSMULT Ss/tr (Stress period '
      + IntToStr(Index+1) + ')');
    Mt3dmsBtnWriter.NewLine;

    if (Count = 1) then
    begin
      if StressPeriod.DrawDownReference then
      begin
        frmErrorsAndWarnings.AddWarning(Mt3dmsBtnWriter.Model,
          StrUnusualUseOfDrawd, StrTheFirstAndOnlyS);
      end;
    end;
    if StressPeriod.DrawDownReference
      and (StressPeriod.StressPeriodType = sptTransient) then
    begin
      frmErrorsAndWarnings.AddWarning(Mt3dmsBtnWriter.Model, StrUnusualUseOfDrawd,
        Format(StrInStressPeriodD, [Index+1]));
    end;
  end;
end;

end.
