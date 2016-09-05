unit ModflowOptionsUnit;

interface

uses SysUtils, Classes, GoPhastTypes;

Type
  TModflowOptions = class(TPersistent)
  private
    FOnInvalidateModel: TNotifyEvent;
    FLengthUnit: integer;
    FPrintTime: boolean;
    FProjectName: string;
    FProjectDate: string;
    FModeler: string;
    FComputeFluxesBetweenConstantHeadCells: boolean;
    FTimeUnit: integer;
    FDescription: TStrings;
    FHNoFlow: real;
    FHDry: real;
    FOpenInTextEditor: boolean;
    FInitialHeadFileName: string;
    FStoredStopErrorCriterion: TRealStorage;
    FStopError: Boolean;
    procedure InvalidateModel;
    procedure SetComputeFluxesBetweenConstantHeadCells(const Value: boolean);
    procedure SetDescription(const Value: TStrings);
    procedure SetHNoFlow(const Value: real);
    procedure SetLengthUnit(const Value: integer);
    procedure SetModeler(const Value: string);
    procedure SetPrintTime(const Value: boolean);
    procedure SetProjectDate(const Value: string);
    procedure SetProjectName(const Value: string);
    procedure SetTimeUnit(const Value: integer);
    procedure SetHDry(const Value: real);
    procedure SetOpenInTextEditor(const Value: boolean);
    procedure SetInitialHeadFileName(const Value: string);
    procedure SetStopError(const Value: Boolean);
    procedure SetStopErrorCriterion(const Value: double);
    procedure SetStoredStopErrorCriterion(const Value: TRealStorage);
    function GetStopErrorCriterion: double;
  protected
    // @name stores a value for @link(HNoFlow) when @link(HNoFlow) is zero.
    procedure DefineProperties(Filer: TFiler); override;
    // read a value for @link(HNoFlow).
    procedure ReadHNoFlow(Reader: TReader);
    // write a value for @link(HNoFlow).
    procedure WriteHNoFlow(Writer: TWriter);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(InvalidateModelEvent: TNotifyEvent);
    destructor Destroy; override;
    procedure Clear;
    property StopErrorCriterion: double read GetStopErrorCriterion write SetStopErrorCriterion;
  published
    property ComputeFluxesBetweenConstantHeadCells: boolean
      read FComputeFluxesBetweenConstantHeadCells
      write SetComputeFluxesBetweenConstantHeadCells default True;
    property Description: TStrings read FDescription write SetDescription;
    property HDry: real read FHDry write SetHDry;
    property HNoFlow: real read FHNoFlow write SetHNoFlow;
    property LengthUnit: integer read FLengthUnit write SetLengthUnit default 2;
    property Modeler: string read FModeler write SetModeler;
    property PrintTime: boolean read FPrintTime write SetPrintTime default True;
    property ProjectName: string read FProjectName write SetProjectName;
    property ProjectDate: string read FProjectDate write SetProjectDate;
    property TimeUnit: integer read FTimeUnit write SetTimeUnit default 1;
    property OpenInTextEditor: boolean read FOpenInTextEditor
      write SetOpenInTextEditor default True;
    property InitialHeadFileName: string read FInitialHeadFileName
      write SetInitialHeadFileName;
    property StopError: Boolean read FStopError write SetStopError;
    property StoredStopErrorCriterion: TRealStorage read FStoredStopErrorCriterion write SetStoredStopErrorCriterion;
  end;

  TWettingOptions = class(TPersistent)
  private
    FOnInvalidateModel: TNotifyEvent;
    FWettingFactor: real;
    FWettingEquation: integer;
    FWettingActive: boolean;
    FWettingIterations: integer;
    procedure SetWettingActive(const Value: boolean);
    procedure SetWettingEquation(const Value: integer);
    procedure SetWettingFactor(const Value: real);
    procedure InvalidateModel;
    procedure SetWettingIterations(Value: integer);
  published
    procedure Assign(Source: TPersistent); override;
    constructor Create(InvalidateModelEvent: TNotifyEvent);
    property WettingActive: boolean read FWettingActive write SetWettingActive;
    property WettingFactor: real read FWettingFactor write SetWettingFactor;
    property WettingIterations: integer read FWettingIterations
      write SetWettingIterations default 1;
    property WettingEquation: integer read FWettingEquation write SetWettingEquation;
  end;

implementation

const
  DefaultHNoFlow: real = -2e20;
  DefaultHDry: real = -1e20;

{ TModflowOptions }

procedure TModflowOptions.Assign(Source: TPersistent);
var
  SourceModel: TModflowOptions;
begin
  if Source is TModflowOptions then
  begin
    SourceModel := TModflowOptions(Source);
    ComputeFluxesBetweenConstantHeadCells := SourceModel.ComputeFluxesBetweenConstantHeadCells;
    Description := SourceModel.Description;
    LengthUnit := SourceModel.LengthUnit;
    HDry := SourceModel.HDry;
    HNoFlow := SourceModel.HNoFlow;
    Modeler := SourceModel.Modeler;
    PrintTime := SourceModel.PrintTime;
    ProjectName := SourceModel.ProjectName;
    ProjectDate := SourceModel.ProjectDate;
//    ShowProgress := SourceModel.ShowProgress;
    TimeUnit := SourceModel.TimeUnit;
    OpenInTextEditor := SourceModel.OpenInTextEditor;
    InitialHeadFileName := SourceModel.InitialHeadFileName;
    StopError := SourceModel.StopError;
    StopErrorCriterion := SourceModel.StopErrorCriterion;
  end
  else
  begin
    inherited;
  end;
end;

constructor TModflowOptions.Create(InvalidateModelEvent: TNotifyEvent);
begin
  inherited Create;
  FDescription := TStringList.Create;
  FStoredStopErrorCriterion := TRealStorage.Create;
  Clear;
  FOnInvalidateModel := InvalidateModelEvent;
  FProjectDate := DateTimeToStr(Trunc(Now));
end;

procedure TModflowOptions.DefineProperties(Filer: TFiler);
begin
  inherited;
  // Real-value properties that are equal to zero are not stored
  // even if the storage specifier is set to true.
  // This is a work-around for that limitation
  Filer.DefineProperty('HNoFlow', ReadHNoFlow,
    WriteHNoFlow, (HNoFlow = 0));
end;

destructor TModflowOptions.Destroy;
begin
  FStoredStopErrorCriterion.Free;
  FDescription.Free;
  inherited;
end;

function TModflowOptions.GetStopErrorCriterion: double;
begin
  result := FStoredStopErrorCriterion.Value;
end;

procedure TModflowOptions.Clear;
begin
  FDescription.Clear;
  FHDry := DefaultHDry;
  FHNoFlow := DefaultHNoFlow;
  FTimeUnit := 1;
  FLengthUnit := 2;
  FPrintTime := True;
  FProjectName := '';
  FProjectDate := '';
  FModeler := '';
  FComputeFluxesBetweenConstantHeadCells := True;
  FOpenInTextEditor := True;
  FInitialHeadFileName := '';
  StopError := False;
  StopErrorCriterion := 1;
end;

procedure TModflowOptions.InvalidateModel;
begin
  if Assigned(FOnInvalidateModel) then
  begin
    FOnInvalidateModel(self);
  end;
end;

procedure TModflowOptions.ReadHNoFlow(Reader: TReader);
begin
  HNoFlow := Reader.ReadFloat;
end;

procedure TModflowOptions.SetComputeFluxesBetweenConstantHeadCells(
  const Value: boolean);
begin
  if FComputeFluxesBetweenConstantHeadCells <> Value then
  begin
    FComputeFluxesBetweenConstantHeadCells := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetDescription(const Value: TStrings);
begin
  Assert(Value <> nil);
  if not FDescription.Equals(Value) then
  begin
    FDescription.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetHDry(const Value: real);
begin
  if FHDry <> Value then
  begin
    FHDry := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetHNoFlow(const Value: real);
begin
  if FHNoFlow <> Value then
  begin
    FHNoFlow := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetInitialHeadFileName(const Value: string);
begin
  if FInitialHeadFileName <> Value then
  begin
    FInitialHeadFileName := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetLengthUnit(const Value: integer);
begin
  if FLengthUnit <> Value then
  begin
    FLengthUnit := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetModeler(const Value: string);
begin
  if FModeler <> Value then
  begin
    FModeler := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetOpenInTextEditor(const Value: boolean);
begin
  if FOpenInTextEditor <> Value then
  begin
    FOpenInTextEditor := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetPrintTime(const Value: boolean);
begin
  if FPrintTime <> Value then
  begin
    FPrintTime := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetProjectDate(const Value: string);
begin
  if FProjectDate <> Value then
  begin
    FProjectDate := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetProjectName(const Value: string);
begin
  if FProjectName <> Value then
  begin
    FProjectName := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetStopError(const Value: Boolean);
begin
  if FStopError <> Value then
  begin
    FStopError := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.SetStopErrorCriterion(const Value: double);
begin
  FStoredStopErrorCriterion.Value := Value;
end;

procedure TModflowOptions.SetStoredStopErrorCriterion(
  const Value: TRealStorage);
begin
  FStoredStopErrorCriterion.Assign(Value);
end;

procedure TModflowOptions.SetTimeUnit(const Value: integer);
begin
  if FTimeUnit <> Value then
  begin
    FTimeUnit := Value;
    InvalidateModel;
  end;
end;

procedure TModflowOptions.WriteHNoFlow(Writer: TWriter);
begin
  Writer.WriteFloat(HNoFlow);
end;

{ TWettingOptions }

procedure TWettingOptions.Assign(Source: TPersistent);
var
  WettingOptions: TWettingOptions;
begin
  if Source is TWettingOptions then
  begin
    WettingOptions := TWettingOptions(Source);
    WettingActive := WettingOptions.WettingActive;
    WettingFactor := WettingOptions.WettingFactor;
    WettingIterations := WettingOptions.WettingIterations;
    WettingEquation := WettingOptions.WettingEquation;
  end
  else
  begin
    inherited;
  end;
end;

constructor TWettingOptions.Create(InvalidateModelEvent: TNotifyEvent);
begin
  FOnInvalidateModel := InvalidateModelEvent;
  FWettingFactor := 1;
  FWettingIterations := 1;
end;

procedure TWettingOptions.InvalidateModel;
begin
  if Assigned(FOnInvalidateModel) then
  begin
    FOnInvalidateModel(self);
  end;
end;

procedure TWettingOptions.SetWettingActive(const Value: boolean);
begin
  if FWettingActive <> Value then
  begin
    FWettingActive := Value;
    InvalidateModel;
  end;
end;

procedure TWettingOptions.SetWettingEquation(const Value: integer);
begin
  if FWettingEquation <> Value then
  begin
    FWettingEquation := Value;
    InvalidateModel;
  end;
end;

procedure TWettingOptions.SetWettingFactor(const Value: real);
begin
  if FWettingFactor <> Value then
  begin
    FWettingFactor := Value;
    InvalidateModel;
  end;
end;

procedure TWettingOptions.SetWettingIterations(Value: integer);
begin
  if Value <= 0 then
  begin
    Value := 1;
  end;
  if FWettingIterations <> Value then
  begin
    FWettingIterations := Value;
    InvalidateModel;
  end;
end;

end.
