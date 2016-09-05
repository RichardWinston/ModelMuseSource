unit SutraBoundariesUnit;

interface

uses
  GoPhastTypes, Classes, OrderedCollectionUnit, ModflowBoundaryUnit,
  FormulaManagerUnit, Generics.Collections, RbwParser, DataSetUnit,
  SysUtils, SubscriptionUnit;

type
  TObservationFormat = (ofOBS, ofOBC);
  TObservationFormats = set of TObservationFormat;

  TSutraBoundaryType = (sbtFluidSource, sbtMassEnergySource, sbtSpecPress,
    sbtSpecConcTemp);

  TSutraBoundaryValue = record
    Time: double;
    Formula: string;
    Used: Boolean;
  end;

  TSutraBoundaryValueArray = array of TSutraBoundaryValue;

  TSutraTimeList = class(TCustomTimeList)
  private
    FScreenObject: TObject;
    FDescription: string;
    FUsed: array of boolean;
    function GetUsed(Index: Integer): Boolean;
  protected
    procedure CheckSameModel(const Data: TDataArray); override;
  public
    constructor Create(Model: TBaseModel; ScreenObject: TObject);
    procedure Initialize(BoundaryValues: TSutraBoundaryValueArray); reintroduce;
    property Description: string read FDescription write FDescription;
    property Used[Index: Integer]: Boolean read GetUsed;
  end;

  {
  Merge @link(TSutraTimeList)s as follows.

  1. Get a list of @link(TSutraTimeList)s in the same order as the
  @link(TScreenObject)s that define them.

  2. Get a combined list of all the times in the @link(TSutraTimeList)s

  3. Merge each @link(TSutraTimeList) in turn, into the combined list.
  For each data set in each @link(TSutraTimeList), apply from its
  start time up until but not including
  the next start time included in the @link(TSutraTimeList).

  3a. With specified pressures and specified temperature/concentration,
  use the value in the last @link(TSutraTimeList).

  3b. With specified flux, add the flux to the existing flux and compute
  a weighted average of the injection concentrations or temperatures.

  3c. With solute/energy sources, add the solute/energy source to
  the existing solute/energy sources.

  Merging @link(TSutraTimeList)s is done in
  @link(TSutraBoundaryWriter.UpdateMergeLists).

  @name can be used for both export and display.
  }
  TSutraMergedTimeList = class(TCustomTimeList)
  private
//    FOnGetUseList: TOnGetUseList;
    FOnInitialize: TNotifyEvent;
    procedure SetOnInitialize(const Value: TNotifyEvent);
  public
    procedure Initialize; override;
//    property OnGetUseList: TOnGetUseList read FOnGetUseList
//      write FOnGetUseList;
    property OnInitialize: TNotifyEvent read FOnInitialize
      write SetOnInitialize;
  end;

  TSutraBoundary = class(TModflowBoundary)
  end;

  TSutraBoundaryList = TList<TSutraBoundary>;

  TSutraObservations = class(TGoPhastPersistent)
  private
    FObservationName: AnsiString;
    FScheduleName: AnsiString;
    FTimes: TRealCollection;
    FObservationFormat: TObservationFormat;
    FExportScheduleName: AnsiString;
    procedure SetObservationName(Value: AnsiString);
    procedure SetScheduleName(const Value: AnsiString);
    procedure SetTimes(const Value: TRealCollection);
    procedure SetObservationFormat(const Value: TObservationFormat);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(InvalidateModelEvent: TNotifyEvent);
    destructor Destroy; override;
    function Used: boolean;
    property ExportScheduleName: AnsiString read FExportScheduleName
      write FExportScheduleName;
  published
    // OBSNAM
    property ObservationName: AnsiString read FObservationName
      write SetObservationName;

    // OBSSCH
    property ScheduleName: AnsiString read FScheduleName write SetScheduleName;
    property Times: TRealCollection read FTimes write SetTimes;
    // OBSFMT
    property ObservationFormat: TObservationFormat read FObservationFormat
      write SetObservationFormat;
  end;

  TSutraLake = class(TFormulaProperty)
  private
    const
    InitialStagePosition = 0;
    InitialConcentrationOrTemperaturePosition = 1;
    FractionRechargeDivertedPosition = 2;
    FractionDischargeDivertedPosition = 3;
    var
    FInitialStage: TFormulaObject;
    FInitialConcentrationOrTemperature: TFormulaObject;
    FFractionRechargeDiverted: TFormulaObject;
    FFractionDischargeDiverted: TFormulaObject;
    FInitialStageObserver: TObserver;
    FFracDisDivObserver: TObserver;
    FFracRechDivObserver: TObserver;
    FInitialUObserver: TObserver;
    FUsed: boolean;
    FUsedObserver: TObserver;
    function GetFractionDischargeDiverted: string;
    function GetFractionRechargeDiverted: string;
    function GetInitialConcentrationOrTemperature: string;
    function GetInitialStage: string;
    procedure SetFractionDischargeDiverted(const Value: string);
    procedure SetFractionRechargeDiverted(const Value: string);
    procedure SetInitialConcentrationOrTemperature(const Value: string);
    procedure SetInitialStage(const Value: string);
    procedure CreateFormulaObjects;
    function GetInitialStageObserver: TObserver;
    function GetFracDisDivObserver: TObserver;
    function GetFracRechDivObserver: TObserver;
    function GetInitialUObserver: TObserver;
    function GetUsedObserver: TObserver;
    procedure SetUsed(const Value: boolean);
    procedure HandleChangedValue(Observer: TObserver);
  protected
    property InitialStageObserver: TObserver read GetInitialStageObserver;
    property InitialUObserver: TObserver read GetInitialUObserver;
    property FracRechDivObserver: TObserver read GetFracRechDivObserver;
    property FracDisDivObserver: TObserver read GetFracDisDivObserver;
    property UsedObserver: TObserver read GetUsedObserver;
    procedure CreateObservers;
  public
    Constructor Create(Model: TBaseModel; ScreenObject: TObject);
    destructor Destroy; override;
    Procedure Assign(Source: TPersistent); override;
    function Used: boolean; override;
  published
    // STGI
    property InitialStage: string read GetInitialStage write SetInitialStage;
    // UWI
    property InitialConcentrationOrTemperature: string
      read GetInitialConcentrationOrTemperature
      write SetInitialConcentrationOrTemperature;
    // FRRO
    property FractionRechargeDiverted: string read GetFractionRechargeDiverted
      write SetFractionRechargeDiverted;
    // FDRO
    property FractionDischargeDiverted: string read GetFractionDischargeDiverted
      write SetFractionDischargeDiverted;
    property IsUsed: boolean read FUsed write SetUsed;
  end;

  TSutraLakeList = TList<TSutraLake>;

  TSutraObsList = TList<TSutraObservations>;

  TCustomSutraBoundaryItem = class(TCustomBoundaryItem)
  private
    UFormulaObject: TFormulaObject;
    FUsed: Boolean;
    procedure SetUFormula(const Value: string);
    function GetUFormula: string;
    procedure SetUsed(const Value: Boolean);
  protected
    function CreateFormulaObject(Orientation:
      TDataSetOrientation): TFormulaObject; override;
    procedure AssignObserverEvents(Collection: TCollection); override;
    procedure CreateFormulaObjects; override;
    procedure GetPropertyObserver(Sender: TObject; List: TList); override;
    procedure RemoveFormulaObjects; override;
    // See @link(BoundaryFormula).
    function GetBoundaryFormula(Index: integer): string; override;
    // See @link(BoundaryFormula).
    procedure SetBoundaryFormula(Index: integer; const Value: string); override;
    // @name checks whether AnotherItem is the same as the current @classname.
    function IsSame(AnotherItem: TOrderedItem): boolean; override;
    procedure InvalidateModel; override;
    function BoundaryFormulaCount: integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
  published
    // UINC, QUINC, UBC
    property UFormula: string read GetUFormula write SetUFormula;
    property Used: Boolean read FUsed write SetUsed;
  end;

  TCustomSutraBoundaryCollection = class(TCustomMF_ListBoundColl)
  private
    FScheduleName: AnsiString;
    procedure SetScheduleName(const Value: AnsiString);
  protected
    procedure UChangeHandler(Sender: TObject); virtual;
    procedure AssignListCellLocation(BoundaryStorage: TCustomBoundaryStorage;
      ACellList: TObject); override;
    procedure AssignCellList(Expression: TExpression; ACellList: TObject;
      BoundaryStorage: TCustomBoundaryStorage; BoundaryFunctionIndex: integer;
      Variables, DataSets: TList; AModel: TBaseModel; AScreenObject: TObject); override;
    function AdjustedFormula(FormulaIndex, ItemIndex: integer): string;
      override;
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
    procedure AddSpecificBoundary(AModel: TBaseModel); override;
    function CanInvalidate: boolean;
  public
    procedure Assign(Source: TPersistent); override;
  published
    // BCSSCH
    property ScheduleName: AnsiString read FScheduleName write SetScheduleName;
  end;

  TCustomSutraAssociatedBoundaryItem = class(TCustomSutraBoundaryItem)
  private
    FPQFormulaObject: TFormulaObject;
    procedure SetPQFormula(const Value: string);
    function GetPQFormula: string;
  protected
    procedure AssignObserverEvents(Collection: TCollection); override;
    procedure CreateFormulaObjects; override;
    procedure GetPropertyObserver(Sender: TObject; List: TList); override;
    procedure RemoveFormulaObjects; override;
    // See @link(BoundaryFormula).
    function GetBoundaryFormula(Index: integer): string; override;
    // See @link(BoundaryFormula).
    procedure SetBoundaryFormula(Index: integer; const Value: string); override;
    // @name checks whether AnotherItem is the same as the current @classname.
    function IsSame(AnotherItem: TOrderedItem): boolean; override;
    procedure InvalidateModel; override;
    function BoundaryFormulaCount: integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
  published
    // QINC, PBC
    property PQFormula: string read GetPQFormula write SetPQFormula;
  end;

  TCustomAssociatedSutraBoundaryCollection = class(TCustomSutraBoundaryCollection)
  protected
    procedure PQChangeHandler(Sender: TObject); virtual;
  end;

  TSutraFluidBoundaryItem = class(TCustomSutraAssociatedBoundaryItem)
  private
    function GetFluidSource: string;
    procedure SetFluidSource(const AValue: string);
  public
    property FluidSource: string read GetFluidSource write SetFluidSource;
  end;

  TSutraFluidBoundaryCollection = class(TCustomAssociatedSutraBoundaryCollection)
  protected
    class function ItemClass: TBoundaryItemClass; override;
    procedure PQChangeHandler(Sender: TObject); override;
    procedure UChangeHandler(Sender: TObject); override;
  public
    constructor Create(Boundary: TModflowBoundary;
      Model: TBaseModel; ScreenObject: TObject); override;
  end;

  TSutraFluidBoundary = class(TSutraBoundary)
  protected
    procedure AssignCells(BoundaryStorage: TCustomBoundaryStorage;
      ValueTimeList: TList; AModel: TBaseModel); override;
    class function BoundaryCollectionClass: TMF_BoundCollClass;
      override;
  public
    procedure GetCellValues(ValueTimeList: TList; ParamList: TStringList;
      AModel: TBaseModel); override;
  end;

  TSutraMassEnergySourceSinkItem = class(TCustomSutraBoundaryItem)
  private
    function GetSoluteEnergy: string;
    procedure SetSoluteEnergy(const AValue: string);
  published
    property SoluteEnergy: string read GetSoluteEnergy write SetSoluteEnergy;
  end;

  TSutraMassEnergySourceSinkCollection = class(TCustomSutraBoundaryCollection)
  protected
    class function ItemClass: TBoundaryItemClass; override;
    procedure UChangeHandler(Sender: TObject); override;
  public
    constructor Create(Boundary: TModflowBoundary;
      Model: TBaseModel; ScreenObject: TObject); override;
  end;

  TSutraMassEnergySourceSinkBoundary = class(TSutraBoundary)
  protected
    procedure AssignCells(BoundaryStorage: TCustomBoundaryStorage;
      ValueTimeList: TList; AModel: TBaseModel); override;
    class function BoundaryCollectionClass: TMF_BoundCollClass;
      override;
  public
    procedure GetCellValues(ValueTimeList: TList; ParamList: TStringList;
      AModel: TBaseModel); override;
  end;

  TSutraSpecifiedPressureBoundaryItem = class(TCustomSutraAssociatedBoundaryItem)
  private
    function GetPressure: string;
    procedure SetPressure(const AValue: string);
  public
    property Pressure: string read GetPressure write SetPressure;
  end;

  TSutraSpecifiedPressureCollection = class(TCustomAssociatedSutraBoundaryCollection)
  protected
    class function ItemClass: TBoundaryItemClass; override;
    procedure PQChangeHandler(Sender: TObject); override;
    procedure UChangeHandler(Sender: TObject); override;
  public
    constructor Create(Boundary: TModflowBoundary;
      Model: TBaseModel; ScreenObject: TObject); override;
  end;

  TSutraSpecifiedPressureBoundary = class(TSutraBoundary)
  protected
    procedure AssignCells(BoundaryStorage: TCustomBoundaryStorage;
      ValueTimeList: TList; AModel: TBaseModel); override;
    class function BoundaryCollectionClass: TMF_BoundCollClass;
      override;
  public
    procedure GetCellValues(ValueTimeList: TList; ParamList: TStringList;
      AModel: TBaseModel); override;
  end;

  TSutraSpecifiedConcTempItem = class(TCustomSutraBoundaryItem)
  private
    function GetConcTemp: string;
    procedure SetConcTemp(const AValue: string);
  published
    property ConcTemp: string read GetConcTemp write SetConcTemp;
  end;

  TSutraSpecifiedConcTempCollection = class(TCustomSutraBoundaryCollection)
  protected
    class function ItemClass: TBoundaryItemClass; override;
    procedure UChangeHandler(Sender: TObject); override;
  public
    constructor Create(Boundary: TModflowBoundary;
      Model: TBaseModel; ScreenObject: TObject); override;
  end;

  TSutraSpecifiedConcTempBoundary = class(TSutraBoundary)
  protected
    procedure AssignCells(BoundaryStorage: TCustomBoundaryStorage;
      ValueTimeList: TList; AModel: TBaseModel); override;
    class function BoundaryCollectionClass: TMF_BoundCollClass;
      override;
  public
    procedure GetCellValues(ValueTimeList: TList; ParamList: TStringList;
      AModel: TBaseModel); override;
  end;

  TSutraBoundaries = class(TGoPhastPersistent)
  private
    FSpecifiedPressure: TSutraSpecifiedPressureBoundary;
    FFluidSource: TSutraFluidBoundary;
    FSpecifiedConcTemp: TSutraSpecifiedConcTempBoundary;
    FMassEnergySource: TSutraMassEnergySourceSinkBoundary;
    FObservations: TSutraObservations;
    FLake: TSutraLake;
    procedure SetFluidSource(const Value: TSutraFluidBoundary);
    procedure SetMassEnergySource(
      const Value: TSutraMassEnergySourceSinkBoundary);
    procedure SetSpecifiedConcTemp(
      const Value: TSutraSpecifiedConcTempBoundary);
    procedure SetSpecifiedPressure(
      const Value: TSutraSpecifiedPressureBoundary);
    procedure SetObservations(const Value: TSutraObservations);
    procedure SetLake(const Value: TSutraLake);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with a TNotifyEvent or interface. }
    //
    Constructor Create(Model: TBaseModel; ScreenObject: TObject);
    destructor Destroy; override;
  published
    property FluidSource: TSutraFluidBoundary read FFluidSource
      write SetFluidSource;
    property MassEnergySource: TSutraMassEnergySourceSinkBoundary
      read FMassEnergySource write SetMassEnergySource;
    property SpecifiedPressure: TSutraSpecifiedPressureBoundary
      read FSpecifiedPressure write SetSpecifiedPressure;
    property SpecifiedConcTemp: TSutraSpecifiedConcTempBoundary
      read FSpecifiedConcTemp write SetSpecifiedConcTemp;
    property Observations: TSutraObservations
      read FObservations write SetObservations;
    property Lake: TSutraLake read FLake write SetLake
    {$IFNDEF Sutra30}
      stored False
    {$ENDIF}
      ;
  end;

implementation

uses
  frmGoPhastUnit, PhastModelUnit, frmProgressUnit,
  ScreenObjectUnit, SutraMeshUnit, frmFormulaErrorsUnit;

const
  UFormulaPosition = 0;
  PQFormulaPosition = 1;

//  FractionRechargeDivertedPosition = 0;

{ TCustomSutraBoundaryCollection }

procedure TCustomSutraBoundaryCollection.AssignCellList(Expression: TExpression;
  ACellList: TObject; BoundaryStorage: TCustomBoundaryStorage;
  BoundaryFunctionIndex: integer; Variables, DataSets: TList;
  AModel: TBaseModel; AScreenObject: TObject);
begin
  inherited;
  // this needs to be changed.
  Assert(False);
end;

procedure TCustomSutraBoundaryCollection.AssignListCellLocation(
  BoundaryStorage: TCustomBoundaryStorage; ACellList: TObject);
begin
  inherited;
  // this needs to be changed.
  Assert(False);
end;

function TCustomSutraBoundaryCollection.CanInvalidate: boolean;
begin
  result := (Model <> nil) and (ScreenObject <> nil)
    and (ScreenObject as TScreenObject).CanInvalidateModel;
end;

function TCustomSutraBoundaryCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := nil;
  // this needs to be changed.
  Assert(False);
end;

//procedure TCustomSutraBoundaryCollection.SetBoundaryName(Value: AnsiString);
//const
//  MaxLength = 40;
//begin
//  if Length(Value) > MaxLength then
//  begin
//    SetLength(Value, MaxLength);
//  end;
//  if FBoundaryName <> Value then
//  begin
//    FBoundaryName := Value;
//
//    InvalidateModel;
//  end;
//end;


procedure TCustomSutraBoundaryCollection.AddSpecificBoundary(
  AModel: TBaseModel);
begin
  inherited;
  // this needs to be changed.
  Assert(False);
end;

function TCustomSutraBoundaryCollection.AdjustedFormula(FormulaIndex,
  ItemIndex: integer): string;
begin
  // this needs to be changed.
  Assert(False);
end;

procedure TCustomSutraBoundaryCollection.Assign(Source: TPersistent);
var
  SourceBoundary: TCustomSutraBoundaryCollection;
begin
  if Source is TCustomSutraBoundaryCollection then
  begin
    SourceBoundary := TCustomSutraBoundaryCollection(Source);
    ScheduleName := SourceBoundary.ScheduleName;
//    BoundaryName := SourceBoundary.BoundaryName;
  end;
  inherited;
end;

procedure TCustomSutraBoundaryCollection.SetScheduleName(const Value: AnsiString);
begin
  if FScheduleName <> Value then
  begin
    FScheduleName := Value;
    InvalidateModel;
  end;
end;

procedure TCustomSutraBoundaryCollection.UChangeHandler(Sender: TObject);
begin
  InvalidateModel;
end;

procedure TSutraObservations.Assign(Source: TPersistent);
var
  SourceCollection: TSutraObservations;
begin
  if Source is TSutraObservations then
  begin
    SourceCollection := TSutraObservations(Source);
    ObservationName := SourceCollection.ObservationName;
    ScheduleName := SourceCollection.ScheduleName;
    Times := SourceCollection.Times;
    ObservationFormat := SourceCollection.ObservationFormat;
  end
  else
  begin
    inherited;
  end;
end;

constructor TSutraObservations.Create(InvalidateModelEvent: TNotifyEvent);
begin
  inherited Create(InvalidateModelEvent);
  FTimes:= TRealCollection.Create(InvalidateModelEvent);
end;

destructor TSutraObservations.Destroy;
begin
  FTimes.Free;
  inherited;
end;

procedure TSutraObservations.SetObservationName(Value: AnsiString);
const
  MaxLength = 40;
begin
  if Length(Value) > MaxLength then
  begin
    SetLength(Value, MaxLength);
  end;
  if FObservationName <> Value then
  begin
    FObservationName := Value;

    InvalidateModel;
  end;
end;


procedure TSutraObservations.SetObservationFormat(
  const Value: TObservationFormat);
begin
  if FObservationFormat <> Value then
  begin
    FObservationFormat := Value;
    InvalidateModel;
  end;
end;

procedure TSutraObservations.SetScheduleName(const Value: AnsiString);
begin
  if FScheduleName <> Value then
  begin
    FScheduleName := Value;
    InvalidateModel;
  end;
end;

procedure TSutraObservations.SetTimes(const Value: TRealCollection);
begin
  FTimes.Assign(Value);
end;

function TSutraObservations.Used: boolean;
begin
  result := Times.Count > 0;
end;

{ TCustomSutraAssociatedBoundaryItem }

procedure TCustomSutraAssociatedBoundaryItem.Assign(Source: TPersistent);
begin
  if Source is TCustomSutraAssociatedBoundaryItem then
  begin
    PQFormula := TCustomSutraAssociatedBoundaryItem(Source).PQFormula;
  end;
  inherited;
end;

procedure TCustomSutraAssociatedBoundaryItem.AssignObserverEvents(
  Collection: TCollection);
var
  ParentCollection: TCustomAssociatedSutraBoundaryCollection;
  PQObserver: TObserver;
begin
  ParentCollection := Collection as TCustomAssociatedSutraBoundaryCollection;
  PQObserver := FObserverList[PQFormulaPosition];
  PQObserver.OnUpToDateSet := ParentCollection.PQChangeHandler;
  inherited;
end;

function TCustomSutraAssociatedBoundaryItem.BoundaryFormulaCount: integer;
begin
  result := 2;
end;

procedure TCustomSutraAssociatedBoundaryItem.CreateFormulaObjects;
begin
  FPQFormulaObject := CreateFormulaObject(dso3D);
  inherited;
end;

destructor TCustomSutraAssociatedBoundaryItem.Destroy;
begin
  PQFormula := '0';
  inherited;
end;

function TCustomSutraAssociatedBoundaryItem.GetBoundaryFormula(
  Index: integer): string;
begin
  case Index of
    1: result := PQFormula;
    else result := inherited;
  end;
end;

function TCustomSutraAssociatedBoundaryItem.GetPQFormula: string;
begin
  Result := FPQFormulaObject.Formula;
  ResetItemObserver(PQFormulaPosition);
end;

procedure TCustomSutraAssociatedBoundaryItem.GetPropertyObserver(
  Sender: TObject; List: TList);
begin
  if Sender = FPQFormulaObject then
  begin
    List.Add(FObserverList[PQFormulaPosition]);
  end
  else
  begin
    inherited;
  end;
end;

procedure TCustomSutraAssociatedBoundaryItem.InvalidateModel;
var
  PhastModel: TPhastModel;
begin
  inherited;
  PhastModel := Model as TPhastModel;
  if (PhastModel <> nil)
    and not (csDestroying in PhastModel.ComponentState)
    and not PhastModel.Clearing then
  begin
//    PhastModel.InvalidateMfWellPumpage(self);
  end;
end;

function TCustomSutraAssociatedBoundaryItem.IsSame(AnotherItem: TOrderedItem): Boolean;
var
  Item: TCustomSutraAssociatedBoundaryItem;
begin
  result := (AnotherItem is TCustomSutraAssociatedBoundaryItem)
    and inherited IsSame(AnotherItem);
  if result then
  begin
    Item := TCustomSutraAssociatedBoundaryItem(AnotherItem);
    result := (Item.PQFormula = PQFormula)
  end;
end;

procedure TCustomSutraAssociatedBoundaryItem.RemoveFormulaObjects;
begin
  frmGoPhast.PhastModel.FormulaManager.Remove(FPQFormulaObject,
    GlobalRemoveModflowBoundaryItemSubscription,
    GlobalRestoreModflowBoundaryItemSubscription, self);
  inherited;
end;

procedure TCustomSutraAssociatedBoundaryItem.SetBoundaryFormula(Index: integer;
  const Value: string);
begin
  case Index of
    1: PQFormula := Value;
    else inherited SetBoundaryFormula(Index, Value);
  end;
end;

procedure TCustomSutraAssociatedBoundaryItem.SetPQFormula(const Value: string);
begin
  UpdateFormula(Value, PQFormulaPosition, FPQFormulaObject);
end;

{ TSutraFluidBoundaryItem }

function TSutraFluidBoundaryItem.GetFluidSource: string;
begin
  result := PQFormula;
end;

procedure TSutraFluidBoundaryItem.SetFluidSource(const AValue: string);
begin
  PQFormula := AValue;
end;

{ TSutraMassSourceSinkItem }

function TSutraMassEnergySourceSinkItem.GetSoluteEnergy: string;
begin
  result := UFormula;
end;

procedure TSutraMassEnergySourceSinkItem.SetSoluteEnergy(const AValue: string);
begin
  UFormula := AValue;
end;

{ TSutraSpecifiedPressureBoundaryItem }

function TSutraSpecifiedPressureBoundaryItem.GetPressure: string;
begin
  result := PQFormula;
end;

procedure TSutraSpecifiedPressureBoundaryItem.SetPressure(const AValue: string);
begin
  PQFormula := AValue;
end;

{ TSutraSpecifiedConcTempItem }

function TSutraSpecifiedConcTempItem.GetConcTemp: string;
begin
  result := UFormula;
end;

procedure TSutraSpecifiedConcTempItem.SetConcTemp(const AValue: string);
begin
  UFormula := AValue;
end;

{ TSutraBoundaries }

procedure TSutraBoundaries.Assign(Source: TPersistent);
var
  SourceBoundaries: TSutraBoundaries;
begin
  if Source is TSutraBoundaries then
  begin
    SourceBoundaries := TSutraBoundaries(Source);
    FluidSource := SourceBoundaries.FluidSource;
    MassEnergySource := SourceBoundaries.MassEnergySource;
    SpecifiedPressure := SourceBoundaries.SpecifiedPressure;
    SpecifiedConcTemp := SourceBoundaries.SpecifiedConcTemp;
    Observations := SourceBoundaries.Observations;
    Lake := SourceBoundaries.Lake;
  end
  else
  begin
    inherited;
  end;
end;

constructor TSutraBoundaries.Create(Model: TBaseModel; ScreenObject: TObject);
var
  InvalidateModelEvent: TNotifyEvent;
begin
  if Model = nil then
  begin
    InvalidateModelEvent := nil;
  end
  else
  begin
    InvalidateModelEvent := Model.Invalidate;
  end;
  inherited Create(InvalidateModelEvent);
  FFluidSource := TSutraFluidBoundary.Create(Model, ScreenObject);
  FMassEnergySource := TSutraMassEnergySourceSinkBoundary.Create(Model, ScreenObject);
  FSpecifiedPressure := TSutraSpecifiedPressureBoundary.Create(Model, ScreenObject);
  FSpecifiedConcTemp := TSutraSpecifiedConcTempBoundary.Create(Model, ScreenObject);
  FObservations := TSutraObservations.Create(InvalidateModelEvent);
  FLake := TSutraLake.Create(Model, ScreenObject);
end;

destructor TSutraBoundaries.Destroy;
begin
  FLake.Free;
  FObservations.Free;
  FSpecifiedConcTemp.Free;
  FSpecifiedPressure.Free;
  FMassEnergySource.Free;
  FFluidSource.Free;
  inherited;
end;

procedure TSutraBoundaries.SetFluidSource(
  const Value: TSutraFluidBoundary);
begin
  FFluidSource.Assign(Value);
end;

procedure TSutraBoundaries.SetLake(const Value: TSutraLake);
begin
  FLake.Assign(Value);
end;

procedure TSutraBoundaries.SetMassEnergySource(
  const Value: TSutraMassEnergySourceSinkBoundary);
begin
  FMassEnergySource.Assign(Value);
end;

procedure TSutraBoundaries.SetObservations(const Value: TSutraObservations);
begin
  FObservations.Assign(Value);
end;

procedure TSutraBoundaries.SetSpecifiedConcTemp(
  const Value: TSutraSpecifiedConcTempBoundary);
begin
  FSpecifiedConcTemp.Assign(Value);
end;

procedure TSutraBoundaries.SetSpecifiedPressure(
  const Value: TSutraSpecifiedPressureBoundary);
begin
  FSpecifiedPressure.Assign(Value);
end;

{ TCustomSutraBoundaryItem }

procedure TCustomSutraBoundaryItem.Assign(Source: TPersistent);
begin
  // if Assign is updated, update IsSame too.
  if Source is TCustomSutraBoundaryItem then
  begin
    UFormula := TCustomSutraBoundaryItem(Source).UFormula;
    Used := TCustomSutraBoundaryItem(Source).Used;
  end;
  inherited;
end;

procedure TCustomSutraBoundaryItem.AssignObserverEvents(
  Collection: TCollection);
var
  ParentCollection: TCustomSutraBoundaryCollection;
  PumpingRateObserver: TObserver;
begin
  ParentCollection := Collection as TCustomSutraBoundaryCollection;
  PumpingRateObserver := FObserverList[UFormulaPosition];
  PumpingRateObserver.OnUpToDateSet := ParentCollection.UChangeHandler;
end;

function TCustomSutraBoundaryItem.BoundaryFormulaCount: integer;
begin
  result := 1;
end;

function TCustomSutraBoundaryItem.CreateFormulaObject(
  Orientation: TDataSetOrientation): TFormulaObject;
begin
  result := frmGoPhast.PhastModel.FormulaManager.Add;
  case Orientation of
    dsoTop:
      begin
        result.Parser := frmGoPhast.PhastModel.rpTopFormulaCompilerNodes;
      end;
    dso3D:
      begin
        result.Parser := frmGoPhast.PhastModel.rpThreeDFormulaCompilerNodes;
      end;
    else Assert(False);
  end;
  result.AddSubscriptionEvents(
    GlobalRemoveModflowBoundaryItemSubscription,
    GlobalRestoreModflowBoundaryItemSubscription, self);
end;

procedure TCustomSutraBoundaryItem.CreateFormulaObjects;
begin
  inherited;
  UFormulaObject := CreateFormulaObject(dso3D);
end;

destructor TCustomSutraBoundaryItem.Destroy;
begin
  UFormula := '0';
  inherited;
end;

function TCustomSutraBoundaryItem.GetBoundaryFormula(Index: integer): string;
begin
  case Index of
    0: result := UFormula;
    else Assert(False);
  end;
end;

procedure TCustomSutraBoundaryItem.GetPropertyObserver(Sender: TObject;
  List: TList);
begin
  Assert(Sender = UFormulaObject);
  List.Add(FObserverList[UFormulaPosition]);
end;

function TCustomSutraBoundaryItem.GetUFormula: string;
begin
  Result := UFormulaObject.Formula;
  ResetItemObserver(UFormulaPosition);
end;

procedure TCustomSutraBoundaryItem.InvalidateModel;
var
  PhastModel: TPhastModel;
begin
  inherited;
  PhastModel := Model as TPhastModel;
  if (PhastModel <> nil)
    and not (csDestroying in PhastModel.ComponentState)
    and not PhastModel.Clearing then
  begin
//    PhastModel.InvalidateMfWellPumpage(self);
  end;
end;

function TCustomSutraBoundaryItem.IsSame(AnotherItem: TOrderedItem): Boolean;
var
  Item: TCustomSutraBoundaryItem;
begin
  result := (AnotherItem is TCustomSutraBoundaryItem) and inherited IsSame(AnotherItem);
  if result then
  begin
    Item := TCustomSutraBoundaryItem(AnotherItem);
    result := (Item.UFormula = UFormula)
      and (Item.Used = Used);
  end;
end;

procedure TCustomSutraBoundaryItem.RemoveFormulaObjects;
begin
  frmGoPhast.PhastModel.FormulaManager.Remove(UFormulaObject,
    GlobalRemoveModflowBoundaryItemSubscription,
    GlobalRestoreModflowBoundaryItemSubscription, self);
end;

procedure TCustomSutraBoundaryItem.SetBoundaryFormula(Index: integer;
  const Value: string);
begin
  inherited;
  case Index of
    0: UFormula := Value;
    else Assert(False);
  end;
end;

procedure TCustomSutraBoundaryItem.SetUFormula(const Value: string);
begin
  UpdateFormula(Value, UFormulaPosition, UFormulaObject);
end;

procedure TCustomSutraBoundaryItem.SetUsed(const Value: Boolean);
begin
  if FUsed <> Value then
  begin
    FUsed := Value;
    InvalidateModel;
  end;
end;

{ TCustomAssociatedSutraBoundaryCollection }

procedure TCustomAssociatedSutraBoundaryCollection.PQChangeHandler(
  Sender: TObject);
begin
  InvalidateModel;
end;

{ TSutraFluidBoundaryCollection }

constructor TSutraFluidBoundaryCollection.Create(Boundary: TModflowBoundary;
  Model: TBaseModel; ScreenObject: TObject);
begin
  inherited;

end;

class function TSutraFluidBoundaryCollection.ItemClass: TBoundaryItemClass;
begin
  result := TSutraFluidBoundaryItem;
end;

procedure TSutraFluidBoundaryCollection.PQChangeHandler(Sender: TObject);
begin
  inherited;
  if CanInvalidate then
  begin
    (Model as TCustomModel).InvalidateSutraFluidFlux(Sender);
  end;
end;

procedure TSutraFluidBoundaryCollection.UChangeHandler(Sender: TObject);
begin
  inherited;
  if CanInvalidate then
  begin
    (Model as TCustomModel).InvalidateSutraFluidFluxU(Sender);
  end;
end;

{ TSutraMassEnergySourceSinkCollection }

constructor TSutraMassEnergySourceSinkCollection.Create(
  Boundary: TModflowBoundary; Model: TBaseModel; ScreenObject: TObject);
begin
  inherited;
end;

class function TSutraMassEnergySourceSinkCollection.ItemClass: TBoundaryItemClass;
begin
  result := TSutraMassEnergySourceSinkItem;
end;

procedure TSutraMassEnergySourceSinkCollection.UChangeHandler(Sender: TObject);
begin
  inherited;
  if CanInvalidate then
  begin
    (Model as TCustomModel).InvalidateSutraUFlux(Sender);
  end;
end;

{ TSutraSpecifiedPressureCollection }

constructor TSutraSpecifiedPressureCollection.Create(Boundary: TModflowBoundary;
  Model: TBaseModel; ScreenObject: TObject);
begin
  inherited;

end;

class function TSutraSpecifiedPressureCollection.ItemClass: TBoundaryItemClass;
begin
  result := TSutraSpecifiedPressureBoundaryItem;
end;

procedure TSutraSpecifiedPressureCollection.PQChangeHandler(Sender: TObject);
begin
  inherited;
  if CanInvalidate then
  begin
    (Model as TCustomModel).InvalidateSutraSpecPressure(Sender);
  end;
end;

procedure TSutraSpecifiedPressureCollection.UChangeHandler(Sender: TObject);
begin
  inherited;
  if CanInvalidate then
  begin
    (Model as TCustomModel).InvalidateSutraSpecPressureU(Sender);
  end;
end;

{ TSutraSpecifiedConcTempCollection }

constructor TSutraSpecifiedConcTempCollection.Create(Boundary: TModflowBoundary;
  Model: TBaseModel; ScreenObject: TObject);
begin
  inherited;

end;

class function TSutraSpecifiedConcTempCollection.ItemClass: TBoundaryItemClass;
begin
  result := TSutraSpecifiedConcTempItem;
end;

procedure TSutraSpecifiedConcTempCollection.UChangeHandler(Sender: TObject);
begin
  inherited;
  if CanInvalidate then
  begin
    (Model as TCustomModel).InvalidateSutraSpecifiedU(Sender);
  end;
end;

{ TSutraFluidBoundary }

procedure TSutraFluidBoundary.AssignCells(
  BoundaryStorage: TCustomBoundaryStorage; ValueTimeList: TList;
  AModel: TBaseModel);
begin
  inherited;
  Assert(False);
end;

class function TSutraFluidBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := TSutraFluidBoundaryCollection;
end;

procedure TSutraFluidBoundary.GetCellValues(ValueTimeList: TList;
  ParamList: TStringList; AModel: TBaseModel);
begin
  inherited;
  Assert(False);
end;

{ TSutraMassEnergySourceSinkBoundary }

procedure TSutraMassEnergySourceSinkBoundary.AssignCells(
  BoundaryStorage: TCustomBoundaryStorage; ValueTimeList: TList;
  AModel: TBaseModel);
begin
  inherited;
  Assert(False);
end;

class function TSutraMassEnergySourceSinkBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := TSutraMassEnergySourceSinkCollection;
end;

procedure TSutraMassEnergySourceSinkBoundary.GetCellValues(ValueTimeList: TList;
  ParamList: TStringList; AModel: TBaseModel);
begin
  inherited;
  Assert(False);
end;

{ TSutraSpecifiedPressureBoundary }

procedure TSutraSpecifiedPressureBoundary.AssignCells(
  BoundaryStorage: TCustomBoundaryStorage; ValueTimeList: TList;
  AModel: TBaseModel);
begin
  inherited;
  Assert(False);
end;

class function TSutraSpecifiedPressureBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := TSutraSpecifiedPressureCollection;
end;

procedure TSutraSpecifiedPressureBoundary.GetCellValues(ValueTimeList: TList;
  ParamList: TStringList; AModel: TBaseModel);
begin
  inherited;
  Assert(False);
end;

{ TSutraSpecifiedConcTempBoundary }

procedure TSutraSpecifiedConcTempBoundary.AssignCells(
  BoundaryStorage: TCustomBoundaryStorage; ValueTimeList: TList;
  AModel: TBaseModel);
begin
  inherited;
  Assert(False);
end;

class function TSutraSpecifiedConcTempBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := TSutraSpecifiedConcTempCollection;
end;

procedure TSutraSpecifiedConcTempBoundary.GetCellValues(ValueTimeList: TList;
  ParamList: TStringList; AModel: TBaseModel);
begin
  inherited;
  Assert(False);
end;

{ TSutraBoundary }

{ TSutraTimeList }

procedure TSutraTimeList.CheckSameModel(const Data: TDataArray);
begin
  if Data <> nil then
  begin
    Assert(Model = Data.Model);
  end;
end;

constructor TSutraTimeList.Create(Model: TBaseModel; ScreenObject: TObject);
begin
  inherited Create(Model);
  FScreenObject := ScreenObject;
end;

function TSutraTimeList.GetUsed(Index: Integer): Boolean;
begin
  result := FUsed[Index]
end;

procedure TSutraTimeList.Initialize(BoundaryValues: TSutraBoundaryValueArray);
var
  LocalScreenObject: TScreenObject;
  LocalModel: TCustomModel;
  Mesh: TSutraMesh3D;
  StoredUpToDate: Boolean;
  Index: Integer;
  Time: Double;
  Formula: string;
  DataArray: TDataArray;
  TimeIndex: Integer;
begin
  if not frmProgressMM.ShouldContinue then
  begin
    Exit;
  end;
  if UpToDate then
    Exit;

  SetLength(FUsed, Length(BoundaryValues));
  for TimeIndex := 0 to Length(BoundaryValues) - 1 do
  begin
    FUsed[TimeIndex] := BoundaryValues[TimeIndex].Used;
  end;

  LocalScreenObject := FScreenObject as TScreenObject;
  Assert(LocalScreenObject <> nil);
  LocalModel := Model as TCustomModel;
  Assert(LocalModel <> nil);

  Mesh := LocalModel.SutraMesh;
  StoredUpToDate := LocalModel.UpToDate;
  try
    Clear;

    for Index := 0 to Length(BoundaryValues) - 1 do
    begin
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      Time := BoundaryValues[Index].Time;
      if Used[Index] then
      begin

        Formula := BoundaryValues[Index].Formula;
        DataArray := nil;
        case DataType of
          rdtDouble:
            begin
              DataArray := TTransientRealSparseDataSet.Create(LocalModel);
              DataArray.DataType := rdtDouble;
            end;
//          rdtInteger:
//            begin
//              DataArray := TTransientIntegerSparseDataSet.Create(LocalModel);
//              DataArray.DataType := rdtInteger;
//            end;
          else Assert(False);
        end;
        DataArray.Name := ValidName(Description) + '_' + IntToStr(Index+1);
        Add(Time, DataArray);
        DataArray.UseLgrEdgeCells := lctUse;
        DataArray.EvaluatedAt := eaNodes;
        DataArray.Orientation := dso3D;
        LocalModel.UpdateDataArrayDimensions(DataArray);

        try
          LocalScreenObject.AssignValuesToSutraDataSet(Mesh, DataArray,
            Formula, LocalModel);
        except on E: ErbwParserError do
          begin
            frmFormulaErrors.AddFormulaError(LocalScreenObject.Name, Name,
              Formula, E.Message);
            Formula := '0';
            BoundaryValues[Index].Formula := Formula;
            LocalScreenObject.AssignValuesToSutraDataSet(Mesh, DataArray,
              Formula, LocalModel);
          end;
        end;
        LocalModel.DataArrayManager.CacheDataArrays;
        DataArray.UpToDate := True;
        DataArray.CacheData;
      end
      else
      begin
        Add(Time, nil);
      end;
    end;
    SetUpToDate(True);
  finally
    LocalModel.UpToDate := StoredUpToDate;
  end
end;

{ TSutraMergedTimeList }

procedure TSutraMergedTimeList.Initialize;
var
  index: Integer;
  DataArray: TDataArray;
begin
  if Assigned(OnInitialize) then
  begin
    OnInitialize(Self);
    for index := 0 to Count - 1 do
    begin
      DataArray := Items[index];
      DataArray.UpToDate := True;
      DataArray.CacheData;
    end;
    SetUpToDate(True);
  end;
end;

procedure TSutraMergedTimeList.SetOnInitialize(const Value: TNotifyEvent);
begin
  if Addr(FOnInitialize) <> Addr(Value) then
  begin
    FOnInitialize := Value;
    Invalidate;
  end;
end;

{ TSutraLake }

procedure TSutraLake.Assign(Source: TPersistent);
var
  SourceLake: TSutraLake;
begin
  if Source is TSutraLake then
  begin
    SourceLake := TSutraLake(Source);
    InitialStage := SourceLake.InitialStage;
    InitialConcentrationOrTemperature := SourceLake.InitialConcentrationOrTemperature;
    FractionRechargeDiverted := SourceLake.FractionRechargeDiverted;
    FractionDischargeDiverted := SourceLake.FractionDischargeDiverted;
    IsUsed := SourceLake.IsUsed;
  end
  else
  begin
    inherited;
  end;
end;

constructor TSutraLake.Create(Model: TBaseModel; ScreenObject: TObject);
begin
  inherited;
  CreateFormulaObjects;
  CreateObservers;

  InitialStage := '0';
  InitialConcentrationOrTemperature := '0';
  FractionRechargeDiverted := '0';
  FractionDischargeDiverted := '0';
end;

procedure TSutraLake.CreateFormulaObjects;
begin
  FInitialStage := CreateFormulaObject(dsoTop);
  FInitialConcentrationOrTemperature := CreateFormulaObject(dsoTop);
  FFractionRechargeDiverted := CreateFormulaObject(dsoTop);
  FFractionDischargeDiverted := CreateFormulaObject(dsoTop);
end;

procedure TSutraLake.CreateObservers;
begin
  if ScreenObject <> nil then
  begin
    FObserverList.Add(InitialStageObserver);
    FObserverList.Add(InitialUObserver);
    FObserverList.Add(FracRechDivObserver);
    FObserverList.Add(FracDisDivObserver);
  end;
end;

destructor TSutraLake.Destroy;
begin
  InitialStage := '0';
  InitialConcentrationOrTemperature := '0';
  FractionRechargeDiverted := '0';
  FractionDischargeDiverted := '0';
  FUsedObserver.Free;
  inherited;
end;

function TSutraLake.GetFracDisDivObserver: TObserver;
var
  Observer: TObserver;
begin
  if FFracDisDivObserver = nil then
  begin
    Observer := nil;
    CreateObserver('SutraLakeFracDisDiv_', FFracDisDivObserver, Observer);
  end;
  result := FFracDisDivObserver;
end;

function TSutraLake.GetFracRechDivObserver: TObserver;
var
  Observer: TObserver;
begin
  if FFracRechDivObserver = nil then
  begin
    Observer := nil;
    CreateObserver('SutraLakeFracRechDiv_', FFracRechDivObserver, Observer);
  end;
  result := FFracRechDivObserver;
end;

function TSutraLake.GetFractionDischargeDiverted: string;
begin
  Result := FFractionDischargeDiverted.Formula;
  ResetItemObserver(FractionDischargeDivertedPosition);
end;

function TSutraLake.GetFractionRechargeDiverted: string;
begin
  Result := FFractionRechargeDiverted.Formula;
  ResetItemObserver(FractionRechargeDivertedPosition);
end;

function TSutraLake.GetInitialConcentrationOrTemperature: string;
begin
  Result := FInitialConcentrationOrTemperature.Formula;
  ResetItemObserver(InitialConcentrationOrTemperaturePosition);
end;

function TSutraLake.GetInitialStage: string;
begin
  Result := FInitialStage.Formula;
  ResetItemObserver(InitialStagePosition);
end;

function TSutraLake.GetInitialStageObserver: TObserver;
var
  Observer: TObserver;
begin
  if FInitialStageObserver = nil then
  begin
    Observer := nil;
    CreateObserver('SutraLakeInitialStage_', FInitialStageObserver, Observer);
  end;
  result := FInitialStageObserver;
end;

function TSutraLake.GetInitialUObserver: TObserver;
var
  Observer: TObserver;
begin
  if FInitialUObserver = nil then
  begin
    Observer := nil;
    CreateObserver('SutraLakeInitialU_', FInitialUObserver, Observer);
  end;
  result := FInitialUObserver;
end;

function TSutraLake.GetUsedObserver: TObserver;
var
  Observer: TObserver;
begin
  if FUsedObserver = nil then
  begin
    Observer := nil;
    CreateObserver('SutraLakeUsed_', FUsedObserver, Observer);
  end;
  result := FUsedObserver;
end;

procedure TSutraLake.HandleChangedValue(Observer: TObserver);
var
  Model: TPhastModel;
//  ChildIndex: Integer;
begin
  Model := ParentModel as TPhastModel;
  if not (csDestroying in Model.ComponentState)
    and not Model.Clearing then
  begin
    Observer.UpToDate := True;
    Observer.UpToDate := False;
//    Model.HfbDisplayer.Invalidate;
//    for ChildIndex := 0 to Model.ChildModels.Count - 1 do
//    begin
//      Model.ChildModels[ChildIndex].ChildModel.HfbDisplayer.Invalidate;
//    end;
    Observer.UpToDate := True;
  end;
end;

procedure TSutraLake.SetFractionDischargeDiverted(const Value: string);
begin
  UpdateFormula(Value, FractionDischargeDivertedPosition, FFractionDischargeDiverted);
end;

procedure TSutraLake.SetFractionRechargeDiverted(const Value: string);
begin
  UpdateFormula(Value, FractionRechargeDivertedPosition, FFractionRechargeDiverted);
end;

procedure TSutraLake.SetInitialConcentrationOrTemperature(const Value: string);
begin
  UpdateFormula(Value, InitialConcentrationOrTemperaturePosition, FInitialConcentrationOrTemperature);
end;

procedure TSutraLake.SetInitialStage(const Value: string);
begin
  UpdateFormula(Value, InitialStagePosition, FInitialStage);
end;

procedure TSutraLake.SetUsed(const Value: boolean);
var
  ScreenObject: TScreenObject;
begin
  if FUsed <> Value then
  begin
    ScreenObject := FScreenObject as TScreenObject;
    if FScreenObject <> nil then
    begin
      if ScreenObject.CanInvalidateModel then
      begin
        HandleChangedValue(UsedObserver);
      end;
    end;
    FUsed := Value;
    InvalidateModel;
  end;
end;

function TSutraLake.Used: boolean;
begin
  result := IsUsed;
end;

end.
