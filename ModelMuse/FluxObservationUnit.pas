{
@abstract(@name defines classes for flux observations in MODFLOW.)

The locations of flux observations will be defined by a
list of objects that define a flux of the specified
type (constant-head, general, river, or drain). Each
object will have a formula for the FACTOR for each
flux observation of which it is a part.
If the formula evaluates to zero at any cell, that cell
will not be included in the observation locations for
that observation.  Each observation group will also have
a series of observation times and associated observation
values.  The group will have a name and this name will
be used to assign an observation name at each observation
time.  Only the group names will be editable by the user.

Each object that defines a flux boundary will have a list
of the observations of which it is a part and a formula
to define the FACTOR for each list.

@author(Richard B. Winston <rbwinst@usgs.gov>)
}
unit FluxObservationUnit;

interface

uses SysUtils, Classes, GoPhastTypes, FormulaManagerUnit;

type
  TCustomFluxObservationItem = class(TPhastCollectionItem)
  private
    // See @link(Time).
    FTime: double;
    // See @link(ObservedValue).
    FObservedValue: double;
    FComment: string;
    // See @link(Time).
    procedure SetTime(const Value: double);
    // See @link(ObservedValue).
    procedure SetObservedValue(const Value: double);
    procedure SetComment(const Value: string);
  public
    // If Source is a @classname, @name copies the published properties
    // of @classname from the source.
    procedure Assign(Source: TPersistent); override;
    function ObsNameTimeString: string;
  published
    // @name is the time at which the observation was made.
    property Time: double read FTime write SetTime;
    // @name is the observed value of flux.  In automated calibration
    // procedures, the observed value is compared with the
    // simulated value to evaluate the quality of the calibration.
    property ObservedValue: double read FObservedValue write SetObservedValue;
    property Comment: string read FComment write SetComment;
  end;

  // @name represents a single flux observation
  TFluxObservation = class(TCustomFluxObservationItem)
  private
    FStatFlag: TStatFlag;
    FStatistic: double;
    procedure SetStatFlag(const Value: TStatFlag);
    procedure SetStatistic(const Value: double);
  public
    // If Source is a @classname, @name copies the published properties
    // of @classname from the source.
    procedure Assign(Source: TPersistent); override;
  published
    property Statistic: double read FStatistic write SetStatistic;
    property StatFlag: TStatFlag read FStatFlag write SetStatFlag;
  end;

  TCustomTFluxObservations = class(TPhastCollection)
  public
    // If Source is a @classname, @name copies the contents
    // of @classname from the source.
    procedure Assign(Source: TPersistent); override;
  end;

  {@name is a collection of @link(TFluxObservation)s.}
  TFluxObservations = class(TCustomTFluxObservations)
  private
    // See @link(Items).
    function GetItems(Index: integer): TFluxObservation;
    // See @link(Items).
    procedure SetItems(Index: integer; const Value: TFluxObservation);
  public
    // If Source is a @classname, @name copies the contents
    // of @classname from the source.
    constructor Create(InvalidateModelEvent: TNotifyEvent);
    // @name provides read and write access to the @link(TFluxObservation)s
    // stored in @classname.
    property Items[Index: integer]: TFluxObservation read GetItems
      write SetItems; default;
    // @name adds a new @link(TFluxObservation) to the @link(Items).
    function Add: TFluxObservation;
  end;

  // @name stores a @link(TScreenObject) and an asociated
  // factor.  The factor is a formula that determines what
  // proportion of each the flux through each of the flux cells
  // defined by @link(ScreenObject) is part of the flux observation.
  TObservationFactor = class(TPhastCollectionItem)
  private
    // See link(Factor)
    FFactor: TFormulaObject;
    // See link(ObjectName)
    FObjectName: string;
    // See link(ScreenObject)
    FScreenObject: TObject;
    // See link(Factor)
    procedure SetFactor(const Value: string);
    // See link(ObjectName)
    procedure SetObjectName(const Value: string);
    // See link(ScreenObject)
    procedure SetScreenObject(const Value: TObject);
    // See link(ObjectName)
    function GetObjectName: string;
    function GetFactor: string;
  public
    {If Source is a @classname, @name copies the public and published
     properties from Source.}
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    // @name sets @link(ScreenObject) to the @link(TScreenObject) indicated by
    // @link(ObjectName)
    procedure Loaded;
    // @name is the @link(TScreenObject) associated with a group of cells
    // in the flux observation.  Setting @name will also cause @link(ObjectName)
    // to be set.
    property ScreenObject: TObject read FScreenObject write SetScreenObject;
  published
    {When being read, @name is the @link(TObserver.Name TScreenObject.Name)
     of the @link(ScreenObject).  However, if @link(ScreenObject)
     is nil, @name returns @link(FObjectName).  Writing ObjectName sets
     @link(FObjectName)}
    property ObjectName: string read GetObjectName write SetObjectName;
    // @name is a formula used to determine what proportion of the flux
    // at a cell will be part of the observation. Typically, Factor will be 1.
    //
    // If Factor is to be displayed on the grid, @link(SetFactor)
    // will have to be changed to respond to changes in what it depends on.
    property Factor: string read GetFactor write SetFactor;
  end;

  // @name is a collection of @link(TObservationFactor)s.
  TObservationFactors = class(TPhastCollection)
  strict private
    { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
    //
    FModel: TBaseModel;
  private
    // See @link(Items).
    function GetItems(Index: integer): TObservationFactor;
    // See @link(Items).
    procedure SetItems(Index: integer; const Value: TObservationFactor);
  public
    // if Source is a @classname, @name copies the contents of Source.
    procedure Assign(Source: TPersistent); override;
    constructor Create(Model: TBaseModel);
    // @name provides access to the @link(TObservationFactor)s in
    // the @classname.
    property Items[Index: integer]: TObservationFactor read GetItems
      write SetItems; default;
    // @name calls @link(TObservationFactor.Loaded)
    // for each @link(TObservationFactor).
    procedure Loaded;
    // @name deletes any items for which the
    // @link(TObservationFactor.ScreenObject)
    // is nil or deleted.
    procedure EliminatedDeletedScreenObjects;
    // @name returns the number of the item whose
    // @link(TObservationFactor.ScreenObject)
    // is ScreenObject.  If none match, @name returns -1.
    function IndexOfScreenObject(ScreenObject: TObject): integer;
    // @name adds a @link(TObservationFactor) to @link(Items).
    function Add: TObservationFactor;
    { TODO -cRefactor : Consider replacing Model with a TNotifyEvent or interface. }
    //
    property Model: TBaseModel read FModel;
  end;

  TFluxObsType = (fotHead, fotRiver, fotDrain, fotGHB, fotSTR);

  TCustomFluxObservationGroup = class(TPhastCollectionItem)
  private
    // See @link(ObservationName).
    FObservationName: string;
    // See @link(ObservationFactors).
    FObservationFactors: TObservationFactors;
    FPurpose: TObservationPurpose;
    // See @link(ObservationName).
    procedure SetObservationName(Value: string);
    // See @link(ObservationFactors).
    procedure SetObservationFactors(const Value: TObservationFactors);
    procedure SetPurpose(const Value: TObservationPurpose);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    // @name adds a new @link(TObservationFactor) to @link(ObservationFactors)
    // and makes ScreenObject its @link(TObservationFactor.ScreenObject).
    // If ScreenObject has already been added, it will be skipped.
    function AddObject(ScreenObject: TObject): integer;
    // @name removes the @link(TObservationFactor) from
    // @link(ObservationFactors) that has ScreenObject as its
    // @link(TObservationFactor.ScreenObject).
    procedure RemoveObject(ScreenObject: TObject);
    // @name calls @link(TObservationFactors.Loaded ObservationFactors.Loaded).
    procedure Loaded;
    // @name calls @link(TObservationFactors.EliminatedDeletedScreenObjects
    // ObservationFactors.EliminatedDeletedScreenObjects).
    procedure EliminatedDeletedScreenObjects;
  published
    // @name identifies the group of observations.
    // each group has the same flux cells and the same observation times.
    // @name is used to generate names for each of the observations.
    property ObservationName: string read FObservationName
      write SetObservationName;
    // @name stores the @link(TScreenObject)s that define the
    // flux observation cells and the formula for the factor that
    // specifies how much of the flux from each cell should be included
    // in the observation.
    property ObservationFactors: TObservationFactors read FObservationFactors
      write SetObservationFactors;
    property Purpose: TObservationPurpose read FPurpose write SetPurpose;
  end;

  // @name defines one group of flux observation.  Each group
  // includes the same flux cells and the same observation times.
  TFluxObservationGroup = class(TCustomFluxObservationGroup)
  private
    // See @link(ObservationTimes).
    FObservationTimes: TFluxObservations;
    // See @link(ObservationTimes).
    procedure SetObservationTimes(const Value: TFluxObservations);
  public
    // if Source is a @classname, name copies the published
    // properties of Source.
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    // @name checks that the observations times are valid.
    // If some are not, a description of the errors will be
    // added to ErrorRoots and ErrorMessages
    procedure CheckObservationTimes(ErrorRoots, ErrorMessages: TStringList);
    function FluxObsType: TFluxObsType;
  published
    // @name stores the observation times and observed fluxes at
    // those times.
    property ObservationTimes: TFluxObservations read FObservationTimes
      write SetObservationTimes;
  end;

  TCustomFluxObservationGroups = class(TPhastCollection)
  strict private
    { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
    //
    FModel: TBaseModel;
  private
    // See @link(Items).
    function GetItems(Index: integer): TCustomFluxObservationGroup;
    // See @link(Items).
    procedure SetItems(Index: integer; const Value: TCustomFluxObservationGroup);
  public
   // stored in the @classname.
    property Items[Index: integer]: TCustomFluxObservationGroup read GetItems
      write SetItems; default;
    // @name calls @link(TCustomFluxObservationGroups.EliminatedDeletedScreenObjects)
    // for each @link(TCustomFluxObservationGroups) in @link(Items).
    procedure EliminatedDeletedScreenObjects;
    // @name calls @link(TCustomFluxObservationGroups.Loaded)
    // for each @link(TCustomFluxObservationGroups) in @link(Items).
    procedure Loaded;
    // @name deletes Item from @link(Items).
    procedure Remove(Item: TCustomFluxObservationGroup);
    // If Source is a @classname, @name copies the contents of Source.
    procedure Assign(Source: TPersistent); override;
    constructor Create(ItemClass: TCollectionItemClass; Model: TBaseModel);
    { TODO -cRefactor : Consider replacing Model with a TNotifyEvent or interface. }
    //
    property Model: TBaseModel read FModel;
  end;

  // @name is a collection of @link(TFluxObservationGroup)s.
  TFluxObservationGroups = class(TCustomFluxObservationGroups)
  strict private
    { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
    //
    FModel: TBaseModel;
  private
    FFluxObservationType: TFluxObsType;
    // See @link(Items).
    function GetItems(Index: integer): TFluxObservationGroup;
    // See @link(Items).
    procedure SetItems(Index: integer; const Value: TFluxObservationGroup);
  public
    constructor Create(Model: TBaseModel);
   // @name provides read and write access to the @link(TFluxObservationGroup)
   // stored in the @classname.
    property Items[Index: integer]: TFluxObservationGroup read GetItems
      write SetItems; default;
    // @name adds a new @link(TFluxObservationGroup) to @link(Items).
    function Add: TFluxObservationGroup;
    property FluxObservationType: TFluxObsType read FFluxObservationType
      write FFluxObservationType;
    // @name calls @link(TFluxObservationGroup.CheckObservationTimes)
    // for each @link(TFluxObservationGroup) in @link(Items).
    procedure CheckObservationTimes(ErrorRoots, ErrorMessages: TStringList);
    { TODO -cRefactor : Consider replacing Model with a TNotifyEvent or interface. }
    //
    property Model: TBaseModel read FModel;
  end;

implementation

uses
  PhastModelUnit, ScreenObjectUnit, ModflowBoundaryUnit, frmGoPhastUnit;

resourcestring
  StrInvalidObservation = 'Invalid observation time in the %0:s observation: '
    + '"%1:s."';
  Str0gIsNotUsedIn = '%0:g is not used in %1:s in the %2:s package';
  StrInvalidObjectsIncl = 'Invalid objects included in the %0:s observation' +
  ' "%1:s."';
  StrThe0sPackageIs = 'The %0:s  package is not used in %1:s.';

{ TObservationGroup }

procedure TFluxObservationGroup.Assign(Source: TPersistent);
var
  SourceItem: TFluxObservationGroup;
begin
  if Source is TFluxObservationGroup then
  begin
    SourceItem := TFluxObservationGroup(Source);
    ObservationTimes := SourceItem.ObservationTimes;
  end;
  inherited;
end;

procedure TFluxObservationGroup.CheckObservationTimes(ErrorRoots,
  ErrorMessages: TStringList);
var
  TimeIndex: Integer;
  Time: double;
  ObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TModflowParamBoundary;
  BoundaryPackageID: string;
  PackageID: string;
  ErrorMessage: string;
  ErrorRoot: string;
  function TimeUsedInBoundary(Time: double; Boundary:TModflowParamBoundary): boolean;
  var
    Item: TCustomModflowBoundaryItem;
    ParamIndex: Integer;
    Param: TModflowParamItem;
    ItemIndex: Integer;
  begin
    result := False;
    for ItemIndex := 0 to Boundary.Values.Count - 1 do
    begin
      Item := Boundary.Values[ItemIndex] as TCustomModflowBoundaryItem;
      result := (Item.StartTime <= Time) and (Time <= Item.EndTime);
      if result then Exit;
    end;
    for ParamIndex := 0 to Boundary.Parameters.Count - 1 do
    begin
      Param := Boundary.Parameters[ParamIndex];
      for ItemIndex := 0 to Param.Param.Count - 1 do
      begin
        Item := Param.Param.Items[ItemIndex] as TCustomModflowBoundaryItem;
        result := (Item.StartTime <= Time) and (Time <= Item.EndTime);
        if result then Exit;
      end;
    end;
  end;
begin
  for ObjectIndex := 0 to ObservationFactors.Count - 1 do
  begin
    ScreenObject :=
      ObservationFactors[ObjectIndex].ScreenObject as TScreenObject;
    Boundary := nil;
    case FluxObsType of
      fotHead:
        begin
          Boundary := ScreenObject.ModflowChdBoundary;
          BoundaryPackageID := 'CHD';
          PackageID := 'CHOB';
        end;
      fotRiver:
        begin
          Boundary := ScreenObject.ModflowRivBoundary;
          BoundaryPackageID := 'RIV';
          PackageID := 'RVOB';
        end;
      fotDrain:
        begin
          Boundary := ScreenObject.ModflowDrnBoundary;
          BoundaryPackageID := 'DRN';
          PackageID := 'DROB';
        end;
      fotGHB:
        begin
          Boundary := ScreenObject.ModflowGhbBoundary;
          BoundaryPackageID := 'GHB';
          PackageID := 'GBOB';
        end;
      fotSTR:
        begin
          Boundary := ScreenObject.ModflowStrBoundary;
          BoundaryPackageID := 'STR';
          PackageID := 'STOB';
        end;
      else Assert(False);
    end;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for TimeIndex := 0 to ObservationTimes.Count - 1 do
      begin
        Time := ObservationTimes[TimeIndex].Time;
        if not TimeUsedInBoundary(Time, Boundary) then
        begin
          ErrorRoot := Format(StrInvalidObservation,
            [PackageID, ObservationName]);
          ErrorMessage := Format(Str0gIsNotUsedIn,
            [Time, ScreenObject.Name, BoundaryPackageID]);
          ErrorRoots.Add(ErrorRoot);
          ErrorMessages.AddObject(ErrorMessage, ScreenObject);
        end;
      end;
    end
    else
    begin
      ErrorRoot := Format(StrInvalidObjectsIncl, [PackageID, ObservationName]);
      ErrorMessage := Format(StrThe0sPackageIs,
        [BoundaryPackageID, ScreenObject.Name]);
      ErrorRoots.Add(ErrorRoot);
      ErrorMessages.AddObject(ErrorMessage, ScreenObject);
    end;
  end;
end;

constructor TFluxObservationGroup.Create(Collection: TCollection);
begin
  inherited;
  FObservationTimes := TFluxObservations.Create(OnInvalidateModel);
//    (Collection as TCustomFluxObservationGroups).Model);
end;

destructor TFluxObservationGroup.Destroy;
begin
  FObservationTimes.Free;
  inherited;
end;

function TFluxObservationGroup.FluxObsType: TFluxObsType;
begin
  result := (Collection as TFluxObservationGroups).FluxObservationType;
end;

procedure TFluxObservationGroup.SetObservationTimes(
  const Value: TFluxObservations);
begin
  FObservationTimes.Assign(Value);
end;

{ TFluxObservation }

procedure TFluxObservation.Assign(Source: TPersistent);
var
  SourceItem: TFluxObservation;
begin
  if Source is TFluxObservation then
  begin
    SourceItem := TFluxObservation(Source);
    Statistic := SourceItem.Statistic;
    StatFlag := SourceItem.StatFlag;
  end;
  inherited;
end;

procedure TFluxObservation.SetStatFlag(const Value: TStatFlag);
begin
  if FStatFlag <> Value then
  begin
    InvalidateModel;
    FStatFlag := Value;
  end;
end;

procedure TFluxObservation.SetStatistic(const Value: double);
begin
  if FStatistic <> Value then
  begin
    InvalidateModel;
    FStatistic := Value;
  end;
end;
{ TFluxObservations }

function TFluxObservations.Add: TFluxObservation;
begin
  result := inherited Add as TFluxObservation;
end;

constructor TFluxObservations.Create(InvalidateModelEvent: TNotifyEvent);
//var
//  InvalidateModelEvent: TNotifyEvent;
begin
//  FModel := Model;
//  if Model = nil then
//  begin
//    InvalidateModelEvent := nil;
//  end
//  else
//  begin
//    InvalidateModelEvent := Model.Invalidate;
//  end;
  inherited Create(TFluxObservation, InvalidateModelEvent);
end;

function TFluxObservations.GetItems(Index: integer): TFluxObservation;
begin
  result := inherited Items[Index] as TFluxObservation
end;

procedure TFluxObservations.SetItems(Index: integer;
  const Value: TFluxObservation);
begin
  inherited Items[Index] := Value;
end;

{ TFluxObservationGroups }

function TFluxObservationGroups.Add: TFluxObservationGroup;
begin
  result := inherited Add as TFluxObservationGroup;
end;

constructor TFluxObservationGroups.Create(Model: TBaseModel);
var
  InvalidateModelEvent: TNotifyEvent;
begin
  FModel := Model;
  if Model = nil then
  begin
    InvalidateModelEvent := nil;
  end
  else
  begin
    InvalidateModelEvent := Model.Invalidate;
  end;
  inherited Create(TFluxObservationGroup, Model);
end;

function TFluxObservationGroups.GetItems(Index: integer): TFluxObservationGroup;
begin
  result := inherited Items[Index] as TFluxObservationGroup;
end;

procedure TFluxObservationGroups.SetItems(Index: integer;
  const Value: TFluxObservationGroup);
begin
  inherited Items[Index] := Value;
end;

{ TObservationFactor }

procedure TObservationFactor.Assign(Source: TPersistent);
var
  SourceObs: TObservationFactor;
begin
  if Source is TObservationFactor then
  begin
    SourceObs := TObservationFactor(Source);
    Factor := SourceObs.Factor;
    ScreenObject := SourceObs.ScreenObject;
    ObjectName := SourceObs.ObjectName;
  end
  else
  begin
    inherited;
  end;
end;

constructor TObservationFactor.Create(Collection: TCollection);
begin
  inherited;
  FFactor := frmGoPhast.PhastModel.FormulaManager.Add;
  FFactor.Parser := frmGoPhast.PhastModel.rpThreeDFormulaCompiler;
  frmGoPhast.PhastModel.FormulaManager.ChangeFormula(
    FFactor, '1.', frmGoPhast.PhastModel.rpThreeDFormulaCompiler,
    nil, nil, self);
end;

destructor TObservationFactor.Destroy;
begin
  if frmGoPhast.PhastModel <> nil then
  begin
    frmGoPhast.PhastModel.FormulaManager.Remove(FFactor, nil, nil, self);
  end;
  inherited;
end;

function TObservationFactor.GetFactor: string;
begin
  result := FFactor.Formula;
end;

function TObservationFactor.GetObjectName: string;
begin
  if ScreenObject = nil then
  begin
    result := FObjectName;
  end
  else
  begin
    result := TScreenObject(ScreenObject).Name;
  end;
end;

procedure TObservationFactor.Loaded;
begin
  ScreenObject := ((Collection as TObservationFactors).Model as TCustomModel).
    GetScreenObjectByName(ObjectName);
//  Assert(ScreenObject <> nil);
end;

procedure TObservationFactor.SetFactor(const Value: string);
begin
  if FFactor.Formula <> Value then
  begin
    InvalidateModel;
    frmGoPhast.PhastModel.FormulaManager.ChangeFormula(
      FFactor, Value, frmGoPhast.PhastModel.rpThreeDFormulaCompiler,
      nil, nil, self);
  end;
end;

procedure TObservationFactor.SetObjectName(const Value: string);
begin
  if FObjectName <> Value then
  begin
    InvalidateModel;
    FObjectName := Value;
  end;
end;

procedure TObservationFactor.SetScreenObject(const Value: TObject);
begin
  FScreenObject := Value;
  if FScreenObject <> nil then
  begin
    ObjectName := (FScreenObject as TScreenObject).Name;
  end;
end;

{ TObservationFactors }

function TObservationFactors.Add: TObservationFactor;
begin
  result := inherited Add as TObservationFactor;
end;

procedure TObservationFactors.Assign(Source: TPersistent);
var
  SourceFactors: TObservationFactors;
  Index: Integer;
  SourceItem: TObservationFactor;
  Item: TObservationFactor;
begin
  if (Source is TObservationFactors) then
  begin
    SourceFactors :=  TObservationFactors(Source);
    if SourceFactors.Count = Count then
    begin
      for Index := 0 to Count - 1 do
      begin
        SourceItem := SourceFactors.Items[Index];
        Item := Items[Index];
        Item.Assign(SourceItem);
      end;
    end
    else
    begin
      inherited;
    end;
  end
  else
  begin
    inherited;
  end;
end;

constructor TObservationFactors.Create(Model: TBaseModel);
var
  InvalidateModelEvent: TNotifyEvent;
begin
  FModel := Model;
  if Model = nil then
  begin
    InvalidateModelEvent := nil;
  end
  else
  begin
    InvalidateModelEvent := Model.Invalidate;
  end;
  inherited Create(TObservationFactor, InvalidateModelEvent);
end;

procedure TObservationFactors.EliminatedDeletedScreenObjects;
var
  Index: Integer;
begin
  for Index := Count -1 downto 0 do
  begin
    if (Items[Index].ScreenObject = nil)
      or TScreenObject(Items[Index].ScreenObject).Deleted then
    begin
      Delete(Index);
    end;
  end;
end;

function TObservationFactors.GetItems(Index: integer): TObservationFactor;
begin
  result := inherited Items[Index] as TObservationFactor;
end;

function TObservationFactors.IndexOfScreenObject(
  ScreenObject: TObject): integer;
var
  Index: Integer;
begin
  Assert(ScreenObject is TScreenObject);
  result := -1;
  for Index := 0 to Count - 1 do
  begin
    if Items[Index].ScreenObject = ScreenObject then
    begin
      result := Index;
      break;
    end;
  end;
end;

procedure TObservationFactors.Loaded;
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
  begin
    Items[Index].Loaded;
  end;
  for Index := Count-1 downto 0 do
  begin
    if Items[Index].ScreenObject = nil then
    begin
      Delete(Index);
    end;
  end;
end;

procedure TObservationFactors.SetItems(Index: integer;
  const Value: TObservationFactor);
begin
  inherited Items[Index] := Value;
end;

procedure TCustomFluxObservationItem.SetTime(const Value: double);
begin
  if FTime <> Value then
  begin
    InvalidateModel;
    FTime := Value;
  end;
end;

procedure TCustomFluxObservationItem.SetObservedValue(const Value: double);
begin
  if FObservedValue <> Value then
  begin
    InvalidateModel;
    FObservedValue := Value;
  end;
end;

procedure TCustomFluxObservationItem.Assign(Source: TPersistent);
var
  SourceItem: TCustomFluxObservationItem;
begin
  if Source is TCustomFluxObservationItem then
  begin
    SourceItem := TCustomFluxObservationItem(Source);
    Time := SourceItem.Time;
    ObservedValue := SourceItem.ObservedValue;
    Comment := SourceItem.Comment;
  end
  else
  begin
    inherited;
  end;
end;

procedure TCustomFluxObservationItem.SetComment(const Value: string);
begin
  if FComment <> Value then
  begin
    InvalidateModel;
    FComment := Value;
  end;
end;

{ TCustomTFluxObservations }

procedure TCustomTFluxObservations.Assign(Source: TPersistent);
var
  SourceCollection: TCustomTFluxObservations;
  Index: integer;
begin
  if Source is TCustomTFluxObservations then
  begin
    SourceCollection := TCustomTFluxObservations(Source);
    if Count = SourceCollection.Count then
    begin
      for Index := 0 to Count - 1 do
      begin
        Items[Index].Assign(SourceCollection.Items[Index]);
      end;
    end
    else
    begin
      InvalidateModel;
      inherited
    end;
  end
  else
  begin
    inherited;
  end;
end;

procedure TCustomFluxObservationGroup.SetObservationName(Value: string);
begin
  Value := StringReplace(Value, ' ', '_', [rfReplaceAll]);
  Value := StringReplace(Value, '"', '', [rfReplaceAll]);
  Value := StringReplace(Value, '''', '', [rfReplaceAll]);
  Value := StringReplace(Value, '/', '_', [rfReplaceAll]);
  Value := StringReplace(Value, '\', '_', [rfReplaceAll]);
  if FObservationName <> Value then
  begin
    InvalidateModel;
    FObservationName := Value;
  end;
end;

procedure TCustomFluxObservationGroup.Assign(Source: TPersistent);
var
  SourceItem: TCustomFluxObservationGroup;
begin
  if Source is TCustomFluxObservationGroup then
  begin
    SourceItem := TCustomFluxObservationGroup(Source);
    ObservationName := SourceItem.ObservationName;
    ObservationFactors := SourceItem.ObservationFactors;
    Purpose := SourceItem.Purpose;
  end
  else
  begin
    inherited;
  end;
end;

constructor TCustomFluxObservationGroup.Create(Collection: TCollection);
begin
  inherited;
  FObservationFactors:= TObservationFactors.Create(
    (Collection as TCustomFluxObservationGroups).Model);
end;

destructor TCustomFluxObservationGroup.Destroy;
begin
  FObservationFactors.Free;
  inherited;
end;

procedure TCustomFluxObservationGroup.SetObservationFactors
  (const Value: TObservationFactors);
begin
  FObservationFactors.Assign(Value);
end;

procedure TCustomFluxObservationGroup.SetPurpose(const Value
  : TObservationPurpose);
begin
  if FPurpose <> Value then
  begin
    InvalidateModel;
    FPurpose := Value;
  end;
end;

function TCustomFluxObservationGroup.AddObject(ScreenObject: TObject): integer;
var
  Item: TObservationFactor;
begin
  Assert(ScreenObject is TScreenObject);
  result := ObservationFactors.IndexOfScreenObject(ScreenObject);
  if result < 0 then
  begin
    Item := ObservationFactors.Add;
    Item.ScreenObject := ScreenObject;
    InvalidateModel;
    result := ObservationFactors.Count - 1;
  end;
end;

procedure TCustomFluxObservationGroup.RemoveObject(ScreenObject: TObject);
begin
  Assert(ScreenObject is TScreenObject);
  Index := ObservationFactors.IndexOfScreenObject(ScreenObject);
  if Index >= 0 then
  begin
    ObservationFactors.Delete(Index);
  end;
  InvalidateModel;
end;

procedure TCustomFluxObservationGroup.Loaded;
begin
  ObservationFactors.Loaded;
end;

procedure TCustomFluxObservationGroup.EliminatedDeletedScreenObjects;
begin
  ObservationFactors.EliminatedDeletedScreenObjects;
end;

{ TCustomFluxObservationGroups }

function TCustomFluxObservationGroups.GetItems(
  Index: integer): TCustomFluxObservationGroup;
begin
  result := inherited Items[Index] as TCustomFluxObservationGroup
end;

procedure TCustomFluxObservationGroups.SetItems(Index: integer;
  const Value: TCustomFluxObservationGroup);
begin
  inherited Items[Index] := Value;
end;

constructor TCustomFluxObservationGroups.Create(ItemClass: TCollectionItemClass;
  Model: TBaseModel);
var
  InvalidateModelEvent: TNotifyEvent;
begin
  FModel := Model;
  if Model = nil then
  begin
    InvalidateModelEvent := nil;
  end
  else
  begin
    InvalidateModelEvent := Model.Invalidate;
  end;
  inherited Create(ItemClass, InvalidateModelEvent);
end;

procedure TCustomFluxObservationGroups.EliminatedDeletedScreenObjects;
var
  Index: integer;
begin
  for Index := 0 to Count - 1 do
  begin
    Items[Index].EliminatedDeletedScreenObjects;
  end;
end;

procedure TCustomFluxObservationGroups.Loaded;
var
  Index: integer;
begin
  for Index := 0 to Count - 1 do
  begin
    Items[Index].Loaded;
  end;
end;

procedure TCustomFluxObservationGroups.Remove
  (Item: TCustomFluxObservationGroup);
var
  Index: integer;
  AnItem: TCustomFluxObservationGroup;
begin
  for Index := 0 to Count - 1 do
  begin
    AnItem := Items[Index];
    if AnItem = Item then
    begin
      Delete(Index);
      break;
    end;
  end;
end;

procedure TCustomFluxObservationGroups.Assign(Source: TPersistent);
var
  SourceGroup: TCustomFluxObservationGroups;
  Index: integer;
  SourceItem: TCustomFluxObservationGroup;
  Item: TCustomFluxObservationGroup;
begin
  if (Source is TCustomFluxObservationGroups) then
  begin
    SourceGroup := TCustomFluxObservationGroups(Source);
    if SourceGroup.Count = Count then
    begin
      for Index := 0 to Count - 1 do
      begin
        SourceItem := SourceGroup.Items[Index];
        Item := Items[Index];
        Item.Assign(SourceItem);
      end;
    end
    else
    begin
      inherited;
    end;
  end
  else
  begin
    inherited;
  end;
end;

procedure TFluxObservationGroups.CheckObservationTimes(ErrorRoots,
  ErrorMessages: TStringList);
var
  Index: integer;
begin
  for Index := 0 to Count - 1 do
  begin
    Items[Index].CheckObservationTimes(ErrorRoots, ErrorMessages);
  end;
end;

function TCustomFluxObservationItem.ObsNameTimeString: string;
var
  MaxTimeStringLength: integer;
begin
  result := IntToStr(Index + 1);
  if Collection <> nil then
  begin
    MaxTimeStringLength := Length(IntToStr(Collection.Count));
    while Length(result) < MaxTimeStringLength do
    begin
      result := '0' + result;
    end;
  end;
end;

end.
