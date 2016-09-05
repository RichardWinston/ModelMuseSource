unit ModflowSwrReachUnit;

interface

uses
  ModflowCellUnit, ModflowBoundaryUnit, GoPhastTypes, Classes,
  OrderedCollectionUnit, Generics.Collections,
  FormulaManagerUnit, ModflowSwrReachGeometryUnit, ZLib, RbwParser,
  SysUtils, SubscriptionUnit, ModflowSwrObsUnit;

type
  TSwrRouteType = (rtLevelPool, rtTiltedPool, rtDiffusiveWave);
  TSwrReachType = (srtActive, srtInactive, srtSpecifiedHead);


  TSwrReachTransientRecord = record
    // KRCH IRCH JRCH
    Cell: TCellLocation;
    // ISWRBND
    ReachType: TSwrReachType;
    // IGEONUMR
    GeometryName: string;
    // GZSHIFT
    VerticalOffset: double;
    VerticalOffsetAnnotation: string;
    // STAGE
    Stage: double;
    StageAnnotation: string;
    procedure Cache(Comp: TCompressionStream; Strings: TStringList);
    procedure Restore(Decomp: TDecompressionStream; Strings: TStringList);
    procedure RecordStrings(Strings: TStringList);
  end;

  TSwrReachTransientArray = array of TSwrReachTransientRecord;

  TSwrReachTransientStorage = class(TCustomBoundaryStorage)
  private
    FTransient: TSwrReachTransientArray;
    function GetTransient: TSwrReachTransientArray;
  protected
    procedure Restore(DecompressionStream: TDecompressionStream;
      Annotations: TStringList); override;
    procedure Store(Compressor: TCompressionStream); override;
    procedure Clear; override;
  public
    property Transient: TSwrReachTransientArray read GetTransient;
  end;

  TSwrReachRecord = record
    // KRCH IRCH JRCH
    Cell: TCellLocation;
    // KRCH
    MultiLayer: Boolean;
    // IRCH4A
    // @name starts at 1
    Reach: Integer;
    ReachAnnotation: string;
    // RLEN
    ReachLength: Double;
    ReachLengthAnnotation: string;
    // IROUTETYPE
    RouteType: TSwrRouteType;
    // IRGNUM
    Grouped: boolean;
    // IRGNUM
    ReachGroup: integer;
    // Link to data set 4d.
    // This is the name of the @link(TScreenObject) that defines the reach
    ObjectName: string;
    ScreenObject: TObject;
    // Link to data set 4d
    TabLocation: integer;
    ObsTypes: TSwrObsTypes;
  end;

  TSwrTransientReachItem = class(TCustomModflowBoundaryItem)
  private
    FReachType: TSwrReachType;
    FVerticalOffset: TFormulaObject;
    FGeom: TReachGeometryItem;
    FGeometryName: string;
    FStageOffset: TFormulaObject;
    function GetGeometryName: string;
    function GetVerticalOffset: string;
    procedure SetGeometryName(const Value: string);
    procedure SetReachType(const Value: TSwrReachType);
    procedure SetVerticalOffset(const Value: string);
    function GetStage: string;
    procedure SetStage(const Value: string);
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
    function BoundaryFormulaCount: integer; override;
    procedure RemoveGeom(Geom: TReachGeometryItem);
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    // ISWRBND (1, 0, -1)
    property ReachType: TSwrReachType read FReachType write SetReachType;
    // IGEONUMR
    property GeometryName: string read GetGeometryName Write SetGeometryName;
    // GZSHIFT
    property VerticalOffset: string read GetVerticalOffset write SetVerticalOffset;
    // STAGE
    property Stage: string read GetStage write SetStage;
  end;

  TSwrReachListLink = class(TTimeListsModelLink)
  private
    FVerticalOffset: TModflowTimeList;
    FStage: TModflowTimeList;
  protected
    procedure CreateTimeLists; override;
  public
    Destructor Destroy; override;
  end;

  TSwrReachCollection = class(TCustomMF_ListBoundColl)
  private
    procedure InvalidateVerticalOffset(Sender: TObject);
    procedure InvalidateStage(Sender: TObject);
  protected
    procedure AssignArrayCellValues(DataSets: TList; ItemIndex: Integer;
      AModel: TBaseModel); override;
    procedure AssignListCellLocation(BoundaryStorage: TCustomBoundaryStorage;
      ACellList: TObject); override;
    procedure AssignCellList(Expression: TExpression; ACellList: TObject;
      BoundaryStorage: TCustomBoundaryStorage; BoundaryFunctionIndex: integer;
      Variables, DataSets: TList; AModel: TBaseModel; AScreenObject: TObject); override;
    class function ItemClass: TBoundaryItemClass; override;
    function AdjustedFormula(FormulaIndex, ItemIndex: integer): string; override;
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
    procedure AddSpecificBoundary(AModel: TBaseModel); override;
    procedure SetBoundaryStartAndEndTime(BoundaryCount: Integer;
      Item: TCustomModflowBoundaryItem; ItemIndex: Integer;
      AModel: TBaseModel); override;
    procedure RemoveGeom(Geom: TReachGeometryItem);
  public
    function Add: TSwrTransientReachItem;
    constructor Create(Boundary: TModflowBoundary;
      Model: TBaseModel; ScreenObject: TObject); override;
  end;

  TSwrTransientCell = class(TValueCell)
  private
    FValues: TSwrReachTransientRecord;
    FStressPeriod: integer;
    // @name is set equal to @link(TReachGeometryItem).Index + 1;
    FGeoNumber: integer;
    FObjectName: string;
    function GetVerticalOffSet: double;
    function GetVerticalOffSetAnnotation: string;
    function GetStage: double;
    function GetStageAnnotation: string;
    function GetReachType: TSwrReachType;
  protected
    function GetColumn: integer; override;
    function GetLayer: integer; override;
    function GetRow: integer; override;
    procedure SetColumn(const Value: integer); override;
    procedure SetLayer(const Value: integer); override;
    procedure SetRow(const Value: integer); override;
    function GetIntegerValue(Index: integer; AModel: TBaseModel): integer; override;
    function GetRealValue(Index: integer; AModel: TBaseModel): double; override;
    function GetRealAnnotation(Index: integer; AModel: TBaseModel): string; override;
    function GetIntegerAnnotation(Index: integer; AModel: TBaseModel): string; override;
    procedure Cache(Comp: TCompressionStream; Strings: TStringList); override;
    procedure Restore(Decomp: TDecompressionStream; Annotations: TStringList); override;
    function GetSection: integer; override;
    procedure RecordStrings(Strings: TStringList); override;
    property ObjectName: string read FObjectName;
  public
    property VerticalOffSet: double read GetVerticalOffSet;
    property VerticalOffSetAnnotation: string read GetVerticalOffSetAnnotation;
    function IsIdentical(AnotherCell: TValueCell): boolean; override;
    // @name is set equal to @link(TReachGeometryItem).Index + 1;
    property GeoNumber: integer read FGeoNumber;
    property Stage: double read GetStage;
    property StageAnnotation: string read GetStageAnnotation;
    property ReachType: TSwrReachType read GetReachType;
  end;

  TSwrConnectionMethod = (scmObject, scmSpecifiedReach, scmSameCell);

  TSwrConnectionItem = class(TPhastCollectionItem)
  private
    FMethod: TSwrConnectionMethod;
    FReach: integer;
    FScreenObjectName: string;
    FScreenObject: TObject;
    function GetScreenObject: TObject;
    function GetScreenObjectName: string;
    procedure SetMethod(const Value: TSwrConnectionMethod);
    procedure SetReach(const Value: integer);
    procedure SetScreenObject(const Value: TObject);
    procedure SetScreenObjectName(const Value: string);
    function ParentModel: TBaseModel;
  public
    procedure Assign(Source: TPersistent); override;
    property ScreenObject: TObject read GetScreenObject write SetScreenObject;
    function IsSame(AnItem: TSwrConnectionItem): Boolean;
    procedure Loaded;
  published
    property ScreenObjectName: string read GetScreenObjectName write SetScreenObjectName;
    property Method: TSwrConnectionMethod read FMethod write SetMethod;
    property Reach: integer read FReach write SetReach;
  end;

  TSwrConnections = class(TPhastCollection)
  private
    FModel: TBaseModel;
    function GetInvalidateModelEvent: TNotifyEvent;
    function GetItem(Index: Integer): TSwrConnectionItem;
    procedure SetItem(Index: Integer; const Value: TSwrConnectionItem);
    property InvalidateModelEvent: TNotifyEvent read GetInvalidateModelEvent;
  public
    constructor Create(Model: TBaseModel);
    function IsSame(Connections: TSwrConnections): Boolean;
    property Items[Index: Integer]: TSwrConnectionItem read GetItem
      write SetItem; default;
    function Add: TSwrConnectionItem;
    procedure Loaded;
  end;

  TSwrReachBoundary = class(TModflowBoundary)
  private
    FRouteType: TSwrRouteType;
    FReachLengthFormula: TFormulaObject;
    FConnections: TSwrConnections;
    FMultiLayer: Boolean;
    FGroupNumber: Integer;
    FGrouped: boolean;
    FObsTypes: TSwrObsTypes;
    function GetReachLengthFormula: string;
    procedure SetReachLengthFormula(const Value: string);
    procedure SetRouteType(const Value: TSwrRouteType);
    procedure CreateFormulaObjects;
    function GetReachLengthObserver: TObserver;
    procedure SetConnections(const Value: TSwrConnections);
    procedure SetMultiLayer(const Value: Boolean);
    procedure SetGrouped(const Value: boolean);
    procedure SetGroupNumber(const Value: Integer);
    function GetReachNumberObserver: TObserver;
    function GetGroupNumberObserver: TObserver;
    function GetRoutingTypeObserver: TObserver;
    procedure LinkReachLength;
    procedure LinkReachNumber;
    procedure LinkGroupNumber;
    procedure LinkRoutingType;
    procedure SetObjectObs(const Value: TSwrObsTypes);
  protected
    procedure AssignCells(BoundaryStorage: TCustomBoundaryStorage;
      ValueTimeList: TList; AModel: TBaseModel); override;
    // See @link(TModflowBoundary.BoundaryCollectionClass
    // TModflowBoundary.BoundaryCollectionClass).
    class function BoundaryCollectionClass: TMF_BoundCollClass; override;
    procedure GetPropertyObserver(Sender: TObject; List: TList); override;
    property ReachLengthObserver: TObserver read GetReachLengthObserver;
    property ReachNumberObserver: TObserver read GetReachNumberObserver;
    property GroupNumberObserver: TObserver read GetGroupNumberObserver;
    property RoutingTypeObserver: TObserver read GetRoutingTypeObserver;
    function BoundaryObserverPrefix: string; override;
  public
    Procedure Assign(Source: TPersistent); override;
    Constructor Create(Model: TBaseModel; ScreenObject: TObject);
    destructor Destroy; override;
    procedure GetCellValues(ValueTimeList: TList; ParamList: TStringList;
      AModel: TBaseModel); override;
    procedure InvalidateDisplay; override;
    procedure Loaded;
    procedure RemoveGeom(Geom: TReachGeometryItem);
    class function DefaultReachLengthFormula: string;
    function ReachValues: TSwrReachCollection;
  published
    property MultiLayer: Boolean read FMultiLayer write SetMultiLayer;
    property RouteType: TSwrRouteType read FRouteType write SetRouteType;
    property ReachLengthFormula: string read GetReachLengthFormula
      write SetReachLengthFormula;
    property Connections: TSwrConnections read FConnections write SetConnections;
    property Grouped: boolean read FGrouped write SetGrouped;
    property GroupNumber: Integer read FGroupNumber write SetGroupNumber;
    property ObsTypes: TSwrObsTypes read FObsTypes write SetObjectObs;
  end;

resourcestring
  StrSWRGeometryNotDef = 'SWR Geometry not defined';

implementation

uses
  PhastModelUnit, ScreenObjectUnit, ModflowTimeUnit, frmGoPhastUnit,
  frmErrorsAndWarningsUnit, DataSetUnit, GIS_Functions;

resourcestring
  StrVerticalOffset = 'Vertical Offset';
  StrStage = 'Stage';
  StrInSTheSWRGeome = 'In %s, the SWR Geometry is not defined';
  StrAssignedBy = 'Assigned by ';

const
  VerticalOffsetPosition = 0;
  StagePosition = 1;
  GeoNumberPosition = 2;
  ReachTypePosition = 3;

  ReachLengthPosition = 0;
  ReachNumberPosition = 1;
  GroupNumberPosition = 2;
  RoutingTypePosition = 3;

{ TSwrTransientReachItem }

procedure TSwrTransientReachItem.Assign(Source: TPersistent);
var
  AReach: TSwrTransientReachItem;
begin
  if Source is TSwrTransientReachItem then
  begin
    AReach := TSwrTransientReachItem(Source);
    ReachType := AReach.ReachType;
    GeometryName := AReach.GeometryName;
    VerticalOffset := AReach.VerticalOffset;
    Stage := AReach.Stage;
  end;
  inherited;
end;

procedure TSwrTransientReachItem.AssignObserverEvents(Collection: TCollection);
var
  ParentCollection: TSwrReachCollection;
  VerticalOffsetObserver: TObserver;
  StageObserver: TObserver;
begin
  ParentCollection := Collection as TSwrReachCollection;

  VerticalOffsetObserver := FObserverList[VerticalOffsetPosition];
  VerticalOffsetObserver.OnUpToDateSet := ParentCollection.InvalidateVerticalOffset;

  StageObserver := FObserverList[StagePosition];
  StageObserver.OnUpToDateSet := ParentCollection.InvalidateStage;
end;

function TSwrTransientReachItem.BoundaryFormulaCount: integer;
begin
  result := 2;
end;

procedure TSwrTransientReachItem.CreateFormulaObjects;
begin
  inherited;
  FVerticalOffset := CreateFormulaObject(dsoTop);
  FStageOffset := CreateFormulaObject(dsoTop);
end;

destructor TSwrTransientReachItem.Destroy;
begin
  VerticalOffset := '0';
  Stage := '0';
  inherited;
end;

function TSwrTransientReachItem.GetBoundaryFormula(Index: integer): string;
begin
  case Index of
    VerticalOffsetPosition: result := VerticalOffset;
    StagePosition: result := Stage;
    else
      Assert(False);
  end;
end;

function TSwrTransientReachItem.GetGeometryName: string;
begin
  if (Model <> nil) then
  begin
    if FGeom <> nil then
    begin
      FGeometryName := FGeom.Name;
    end;
  end;
  result := FGeometryName;
end;

procedure TSwrTransientReachItem.GetPropertyObserver(Sender: TObject;
  List: TList);
begin
  if Sender = FVerticalOffset then
  begin
    List.Add( FObserverList[VerticalOffsetPosition]);
  end;
  if Sender = FStageOffset then
  begin
    List.Add( FObserverList[StagePosition]);
  end;
end;

function TSwrTransientReachItem.GetStage: string;
begin
  Result := FStageOffset.Formula;
  ResetItemObserver(StagePosition);
end;

function TSwrTransientReachItem.GetVerticalOffset: string;
begin
  Result := FVerticalOffset.Formula;
  ResetItemObserver(VerticalOffsetPosition);
end;

function TSwrTransientReachItem.IsSame(AnotherItem: TOrderedItem): boolean;
var
  AReach: TSwrTransientReachItem;
begin
  result := inherited IsSame(AnotherItem) and (AnotherItem is TSwrTransientReachItem);
  if result then
  begin
    AReach := TSwrTransientReachItem(AnotherItem);
    result := (ReachType = AReach.ReachType)
      and (GeometryName = AReach.GeometryName)
      and (VerticalOffset = AReach.VerticalOffset)
      and (Stage = AReach.Stage);
  end;
end;

procedure TSwrTransientReachItem.RemoveFormulaObjects;
begin
  inherited;
  frmGoPhast.PhastModel.FormulaManager.Remove(FVerticalOffset,
    GlobalRemoveModflowBoundaryItemSubscription,
    GlobalRestoreModflowBoundaryItemSubscription, self);
  frmGoPhast.PhastModel.FormulaManager.Remove(FStageOffset,
    GlobalRemoveModflowBoundaryItemSubscription,
    GlobalRestoreModflowBoundaryItemSubscription, self);
end;

procedure TSwrTransientReachItem.RemoveGeom(Geom: TReachGeometryItem);
begin
  if FGeom = Geom then
  begin
    FGeom := nil;
  end;
end;

procedure TSwrTransientReachItem.SetBoundaryFormula(Index: integer;
  const Value: string);
begin
  inherited;
  case Index of
    VerticalOffsetPosition: VerticalOffset := Value;
    StagePosition: Stage := Value;
    else
      Assert(False);
  end;
end;

procedure TSwrTransientReachItem.SetGeometryName(const Value: string);
var
  LocalModel: TCustomModel;
  LocalName: string;
begin
  LocalName := GeometryName;
  if LocalName <> Value then
  begin
    if Model <> nil then
    begin
      LocalModel := Model as TCustomModel;
      FGeom := LocalModel.SwrReachGeometry.GetItemByName(Value);
      FGeometryName := FGeom.Name;
      LocalModel.InvalidateMfSwrGeometryNumber(Self)
    end
    else
    begin
      FGeometryName := Value;
    end;
    InvalidateModel;
  end;
end;

procedure TSwrTransientReachItem.SetReachType(const Value: TSwrReachType);
var
  LocalModel: TCustomModel;
begin
  if FReachType <> Value then
  begin
    FReachType := Value;
    if Model <> nil then
    begin
      LocalModel := Model as TCustomModel;
      LocalModel.InvalidateMfSwrBoundaryType(Self);
    end;
    InvalidateModel;
  end;
end;

procedure TSwrTransientReachItem.SetStage(const Value: string);
begin
  UpdateFormula(Value, StagePosition, FStageOffset);
end;

procedure TSwrTransientReachItem.SetVerticalOffset(const Value: string);
begin
  UpdateFormula(Value, VerticalOffsetPosition, FVerticalOffset);
end;

{ TSwrReachListLink }

procedure TSwrReachListLink.CreateTimeLists;
begin
  inherited;
  FVerticalOffset := TModflowTimeList.Create(Model, Boundary.ScreenObject);
  FVerticalOffset.NonParamDescription := StrVerticalOffset;
  FVerticalOffset.ParamDescription := ' ' + LowerCase(StrVerticalOffset);
  FVerticalOffset.DataType := rdtDouble;
  FVerticalOffset.Orientation := dsoTop;
  FVerticalOffset.Direction := dsoTop;
  if Model <> nil then
  begin
    FVerticalOffset.OnInvalidate := (Model as TCustomModel).InvalidateMfSwrVerticalOffset;
  end;
  AddTimeList(FVerticalOffset);

  FStage := TModflowTimeList.Create(Model, Boundary.ScreenObject);
  FStage.NonParamDescription := StrStage;
  FStage.ParamDescription := ' ' + LowerCase(StrStage);
  FStage.DataType := rdtDouble;
  FStage.Orientation := dsoTop;
  FStage.Direction := dsoTop;
  if Model <> nil then
  begin
    FStage.OnInvalidate := (Model as TCustomModel).InvalidateMfSwrStage;
  end;
  AddTimeList(FStage);
end;

destructor TSwrReachListLink.Destroy;
begin
  FStage.Free;
  FVerticalOffset.Free;
  inherited;
end;

{ TSwrReachCollection }

function TSwrReachCollection.Add: TSwrTransientReachItem;
begin
  Result := inherited Add as TSwrTransientReachItem;
end;

procedure TSwrReachCollection.AddSpecificBoundary(AModel: TBaseModel);
begin
  AddBoundary(TSwrReachTransientStorage.Create(AModel));
end;

function TSwrReachCollection.AdjustedFormula(FormulaIndex,
  ItemIndex: integer): string;
var
  Item: TSwrTransientReachItem;
begin
  Item := Items[ItemIndex] as TSwrTransientReachItem;
  result := Item.BoundaryFormula[FormulaIndex];
end;

procedure TSwrReachCollection.AssignArrayCellValues(DataSets: TList;
  ItemIndex: Integer; AModel: TBaseModel);
begin
  Assert(False);
end;

procedure TSwrReachCollection.AssignCellList(Expression: TExpression;
  ACellList: TObject; BoundaryStorage: TCustomBoundaryStorage;
  BoundaryFunctionIndex: integer; Variables, DataSets: TList;
  AModel: TBaseModel; AScreenObject: TObject);
var
  SwrStorage: TSwrReachTransientStorage;
  CellList: TCellAssignmentList;
  Index: Integer;
  ACell: TCellAssignment;
begin
  Assert(BoundaryFunctionIndex in [VerticalOffsetPosition, StagePosition]);
  Assert(Expression <> nil);

  SwrStorage := BoundaryStorage as TSwrReachTransientStorage;
  CellList := ACellList as TCellAssignmentList;
  for Index := 0 to CellList.Count - 1 do
  begin
    ACell := CellList[Index];
    UpdateCurrentScreenObject(AScreenObject as TScreenObject);
    UpdateRequiredListData(DataSets, Variables, ACell, AModel);

    Expression.Evaluate;
    with SwrStorage.Transient[Index] do
    begin
      case BoundaryFunctionIndex of
        VerticalOffsetPosition:
          begin
            VerticalOffset := Expression.DoubleResult;
            VerticalOffsetAnnotation := ACell.Annotation;
          end;
        StagePosition:
          begin
            Stage := Expression.DoubleResult;
            StageAnnotation := ACell.Annotation;
          end;
        else
          Assert(False);
      end;
    end;
  end;
end;

procedure TSwrReachCollection.AssignListCellLocation(
  BoundaryStorage: TCustomBoundaryStorage; ACellList: TObject);
var
  SwrStorage: TSwrReachTransientStorage;
  CellList: TCellAssignmentList;
  Index: Integer;
  ACell: TCellAssignment;
begin
  SwrStorage := BoundaryStorage as TSwrReachTransientStorage;
  CellList := ACellList as TCellAssignmentList;
  for Index := 0 to CellList.Count - 1 do
  begin
    ACell := CellList[Index];
    if ACell.LgrEdge then
    begin
      Continue;
    end;
    with SwrStorage.Transient[Index] do
    begin
      Cell.Layer := ACell.Layer;
      Cell.Row := ACell.Row;
      Cell.Column := ACell.Column;
      Cell.Section := ACell.Section;
    end;
  end;
end;

constructor TSwrReachCollection.Create(Boundary: TModflowBoundary;
  Model: TBaseModel; ScreenObject: TObject);
begin
  inherited;
  SectionDuplicatesAllowed := True;
end;

function TSwrReachCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TSwrReachListLink;
end;

procedure TSwrReachCollection.InvalidateStage(Sender: TObject);
var
  LocalModel: TCustomModel;
  Link: TSwrReachListLink;
  ChildIndex: Integer;
  ChildModel: TChildModel;
  PhastModel: TPhastModel;
begin
  if (not (Sender as TObserver).UpToDate) and (Model <> nil) then
  begin
    LocalModel := Model as TCustomModel;
    Link := TimeListLink.GetLink(LocalModel) as TSwrReachListLink;
    Link.FStage.Invalidate;
    if LocalModel is TPhastModel then
    begin
      PhastModel := TPhastModel(LocalModel);
      for ChildIndex := 0 to PhastModel.ChildModels.Count - 1 do
      begin
        ChildModel := PhastModel.ChildModels[ChildIndex].ChildModel;
        Link := TimeListLink.GetLink(ChildModel) as TSwrReachListLink;
        Link.FStage.Invalidate;
      end;
    end;
  end;
end;

procedure TSwrReachCollection.InvalidateVerticalOffset(Sender: TObject);
var
  LocalModel: TCustomModel;
  Link: TSwrReachListLink;
  ChildIndex: Integer;
  ChildModel: TChildModel;
  PhastModel: TPhastModel;
begin
  if (not (Sender as TObserver).UpToDate) and (Model <> nil) then
  begin
    LocalModel := Model as TCustomModel;
    Link := TimeListLink.GetLink(LocalModel) as TSwrReachListLink;
    Link.FVerticalOffset.Invalidate;
    if LocalModel is TPhastModel then
    begin
      PhastModel := TPhastModel(LocalModel);
      for ChildIndex := 0 to PhastModel.ChildModels.Count - 1 do
      begin
        ChildModel := PhastModel.ChildModels[ChildIndex].ChildModel;
        Link := TimeListLink.GetLink(ChildModel) as TSwrReachListLink;
        Link.FVerticalOffset.Invalidate;
      end;
    end;
  end;
end;

class function TSwrReachCollection.ItemClass: TBoundaryItemClass;
begin
  result := TSwrTransientReachItem;
end;

procedure TSwrReachCollection.RemoveGeom(Geom: TReachGeometryItem);
var
  index: Integer;
begin
  for index := 0 to Count - 1 do
  begin
    (Items[index] as TSwrTransientReachItem).RemoveGeom(Geom);
  end;
end;

procedure TSwrReachCollection.SetBoundaryStartAndEndTime(BoundaryCount: Integer;
  Item: TCustomModflowBoundaryItem; ItemIndex: Integer; AModel: TBaseModel);
begin
  SetLength((Boundaries[ItemIndex, AModel]
    as TSwrReachTransientStorage).FTransient, BoundaryCount);
  inherited;
end;

{ TSwrReachTransientStorage }

procedure TSwrReachTransientStorage.Clear;
begin
  SetLength(FTransient, 0);
  FCleared := True;
end;

function TSwrReachTransientStorage.GetTransient: TSwrReachTransientArray;
begin
  if FCached and FCleared then
  begin
    RestoreData;
  end;
  result := FTransient;
end;

procedure TSwrReachTransientStorage.Restore(
  DecompressionStream: TDecompressionStream; Annotations: TStringList);
var
  Count: Integer;
  Index: Integer;
begin
  DecompressionStream.Read(Count, SizeOf(Count));
  SetLength(FTransient, Count);
  for Index := 0 to Count - 1 do
  begin
    FTransient[Index].Restore(DecompressionStream, Annotations);
  end;
end;

procedure TSwrReachTransientStorage.Store(Compressor: TCompressionStream);
var
  Index: Integer;
  Count: Integer;
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    Strings.Sorted := true;
    Strings.Duplicates := dupIgnore;
    Count := Length(FTransient);
    for Index := 0 to Count - 1 do
    begin
      FTransient[Index].RecordStrings(Strings);
    end;
    WriteCompInt(Compressor, Strings.Count);

    for Index := 0 to Strings.Count - 1 do
    begin
      WriteCompString(Compressor, Strings[Index]);
    end;

    Compressor.Write(Count, SizeOf(Count));
    for Index := 0 to Count - 1 do
    begin
      FTransient[Index].Cache(Compressor, Strings);
    end;

  finally
    Strings.Free;
  end;
end;

{ TSwrReachTransientRecord }

procedure TSwrReachTransientRecord.Cache(Comp: TCompressionStream;
  Strings: TStringList);
var
  AnInteger: integer;
begin
  WriteCompCell(Comp, Cell);
  AnInteger := Ord(ReachType);
  WriteCompInt(Comp, AnInteger);
  WriteCompInt(Comp, Strings.IndexOf(GeometryName));
  WriteCompReal(Comp, VerticalOffset);
  WriteCompInt(Comp, Strings.IndexOf(VerticalOffsetAnnotation));
  WriteCompReal(Comp, Stage);
  WriteCompInt(Comp, Strings.IndexOf(StageAnnotation));
end;

procedure TSwrReachTransientRecord.RecordStrings(Strings: TStringList);
begin
  Strings.Add(GeometryName);
  Strings.Add(VerticalOffsetAnnotation);
  Strings.Add(StageAnnotation);
end;

procedure TSwrReachTransientRecord.Restore(Decomp: TDecompressionStream;
  Strings: TStringList);
begin
  Cell := ReadCompCell(Decomp);
  ReachType := TSwrReachType(ReadCompInt(Decomp));
  GeometryName := Strings[ReadCompInt(Decomp)];
  VerticalOffset := ReadCompReal(Decomp);
  VerticalOffsetAnnotation := Strings[ReadCompInt(Decomp)];
  Stage := ReadCompReal(Decomp);
  StageAnnotation := Strings[ReadCompInt(Decomp)];
end;

{ TSwrTransientCell }

procedure TSwrTransientCell.Cache(Comp: TCompressionStream;
  Strings: TStringList);
begin
  inherited;
  FValues.Cache(Comp, Strings);
  WriteCompInt(Comp, FStressPeriod);
  WriteCompInt(Comp, FGeoNumber);
  WriteCompString(Comp, ObjectName);
end;

function TSwrTransientCell.GetColumn: integer;
begin
  result := FValues.Cell.Column;
end;

function TSwrTransientCell.GetIntegerAnnotation(Index: integer;
  AModel: TBaseModel): string;
begin
  result := '';
  Assert(False);
end;

function TSwrTransientCell.GetIntegerValue(Index: integer;
  AModel: TBaseModel): integer;
begin
  result := 0;
  Assert(False);
end;

function TSwrTransientCell.GetLayer: integer;
begin
  result := FValues.Cell.Layer;
end;

function TSwrTransientCell.GetReachType: TSwrReachType;
begin
  result := FValues.ReachType;
end;

function TSwrTransientCell.GetRealAnnotation(Index: integer;
  AModel: TBaseModel): string;
begin
  result := '';
  case Index of
    VerticalOffsetPosition: result := VerticalOffSetAnnotation;
    StagePosition: result := StageAnnotation;
    GeoNumberPosition, ReachTypePosition: result := StrAssignedBy + ObjectName;
    else Assert(False);
  end;
end;

function TSwrTransientCell.GetRealValue(Index: integer;
  AModel: TBaseModel): double;
begin
  result := 0;
  case Index of
    VerticalOffsetPosition: result := VerticalOffSet;
    StagePosition: result := Stage;
    GeoNumberPosition: result := GeoNumber;
    ReachTypePosition: result := -(Ord(ReachType)-1);
    else Assert(False);
  end;
end;

function TSwrTransientCell.GetRow: integer;
begin
  result := FValues.Cell.Row;
end;

function TSwrTransientCell.GetSection: integer;
begin
  result := FValues.Cell.Section;
end;

function TSwrTransientCell.GetStage: double;
begin
  result := FValues.Stage;
end;

function TSwrTransientCell.GetStageAnnotation: string;
begin
  result := FValues.StageAnnotation;
end;

function TSwrTransientCell.GetVerticalOffSet: double;
begin
  result := FValues.VerticalOffset;
end;

function TSwrTransientCell.GetVerticalOffSetAnnotation: string;
begin
  result := FValues.VerticalOffsetAnnotation;
end;

function TSwrTransientCell.IsIdentical(AnotherCell: TValueCell): boolean;
var
  Swr_Cell: TSwrTransientCell;
begin
  result := AnotherCell is TSwrTransientCell;
  if result then
  begin
    Swr_Cell := TSwrTransientCell(AnotherCell);
    result :=
      (VerticalOffSet = Swr_Cell.VerticalOffSet)
      and (IFace = Swr_Cell.IFace);
  end;
end;

procedure TSwrTransientCell.RecordStrings(Strings: TStringList);
begin
  inherited;
  FValues.RecordStrings(Strings);
end;

procedure TSwrTransientCell.Restore(Decomp: TDecompressionStream;
  Annotations: TStringList);
begin
  inherited;
  FValues.Restore(Decomp, Annotations);
  FStressPeriod := ReadCompInt(Decomp);
  FGeoNumber := ReadCompInt(Decomp);
  FObjectName := ReadCompStringSimple(Decomp);
end;

procedure TSwrTransientCell.SetColumn(const Value: integer);
begin
  FValues.Cell.Column := Value;
end;

procedure TSwrTransientCell.SetLayer(const Value: integer);
begin
  FValues.Cell.Layer := Value;
end;

procedure TSwrTransientCell.SetRow(const Value: integer);
begin
  FValues.Cell.Row := Value;
end;

{ TSwrReachBoundary }

procedure TSwrReachBoundary.Assign(Source: TPersistent);
var
  SourceSwr: TSwrReachBoundary;
begin
  if Source is TSwrReachBoundary then
  begin
    SourceSwr := TSwrReachBoundary(Source);
    ReachLengthFormula := SourceSwr.ReachLengthFormula;
    RouteType := SourceSwr.RouteType;
    MultiLayer := SourceSwr.MultiLayer;
    Connections := SourceSwr.Connections;
    Grouped := SourceSwr.Grouped;
    GroupNumber := SourceSwr.GroupNumber;
    ObsTypes := SourceSwr.ObsTypes;
  end;
  inherited;
end;

procedure TSwrReachBoundary.AssignCells(BoundaryStorage: TCustomBoundaryStorage;
  ValueTimeList: TList; AModel: TBaseModel);
var
  Cell: TSwrTransientCell;
  BoundaryValues: TSwrReachTransientRecord;
  BoundaryIndex: Integer;
  StressPeriod: TModflowStressPeriod;
  TimeIndex: Integer;
  Cells: TValueCellList;
  LocalBoundaryStorage: TSwrReachTransientStorage;
  LocalModel: TCustomModel;
  SwrItem: TSwrTransientReachItem;
  GeoItem: TReachGeometryItem;
  LocalScreenObject: TScreenObject;
begin
  LocalModel := AModel as TCustomModel;
  LocalBoundaryStorage := BoundaryStorage as TSwrReachTransientStorage;
  for TimeIndex := 0 to
    LocalModel.ModflowFullStressPeriods.Count - 1 do
  begin
    if TimeIndex < ValueTimeList.Count then
    begin
      Cells := ValueTimeList[TimeIndex];
    end
    else
    begin
      Cells := TValueCellList.Create(TSwrTransientCell);
      ValueTimeList.Add(Cells);
    end;
    StressPeriod := LocalModel.ModflowFullStressPeriods[TimeIndex];
    // Check if the stress period is completely enclosed within the times
    // of the LocalBoundaryStorage;
    if (StressPeriod.StartTime + LocalModel.SP_Epsilon >= LocalBoundaryStorage.StartingTime)
      and (StressPeriod.EndTime - LocalModel.SP_Epsilon <= LocalBoundaryStorage.EndingTime) then
    begin
      SwrItem := Values.GetItemContainingTime(StressPeriod.StartTime) as TSwrTransientReachItem;
      Assert(SwrItem <> nil);
      Assert(ScreenObject <> nil);
      LocalScreenObject := ScreenObject as TScreenObject;
      GeoItem := LocalModel.SwrReachGeometry.GetItemByName(SwrItem.GeometryName);
      if GeoItem = nil then
      begin
        frmErrorsAndWarnings.AddError(AModel, StrSWRGeometryNotDef,
          Format(StrInSTheSWRGeome, [LocalScreenObject.Name]), LocalScreenObject);
        Exit;
      end;
      if Cells.Capacity < Cells.Count + Length(LocalBoundaryStorage.Transient) then
      begin
        Cells.Capacity := Cells.Count + Length(LocalBoundaryStorage.Transient)
      end;
//      Cells.CheckRestore;
      for BoundaryIndex := 0 to Length(LocalBoundaryStorage.Transient) - 1 do
      begin
        BoundaryValues := LocalBoundaryStorage.Transient[BoundaryIndex];
        Cell := TSwrTransientCell.Create;
        Cell.IFace := LocalScreenObject.IFace;
        Cells.Add(Cell);
        Cell.FStressPeriod := TimeIndex;
        Cell.FValues := BoundaryValues;
        Cell.FGeoNumber := GeoItem.Index + 1;
        Cell.FValues.ReachType := SwrItem.ReachType;
        Cell.FObjectName := LocalScreenObject.Name;
        LocalModel.AdjustCellPosition(Cell);
      end;
      Cells.Cache;
    end;
  end;
  LocalBoundaryStorage.CacheData;
end;

class function TSwrReachBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  Result := TSwrReachCollection;
end;

function TSwrReachBoundary.BoundaryObserverPrefix: string;
begin
  result := 'SwrBoundary_';
end;

constructor TSwrReachBoundary.Create(Model: TBaseModel; ScreenObject: TObject);
var
  Index: Integer;
  Observer: TObserver;
  LocalScreenObject: TScreenObject;
begin
  inherited;
  FConnections := TSwrConnections.Create(Model);

  CreateFormulaObjects;
  CreateBoundaryObserver;

  // create observers for reach length, reach number, group number
  //  and routing type.
  for Index := 0 to 3 do
  begin
    Observer := TObserver.Create(nil);
    FObserverList.Add(Observer);
    LocalScreenObject := ScreenObject as TScreenObject;
    if (LocalScreenObject <> nil) and LocalScreenObject.CanInvalidateModel then
    begin
      LocalScreenObject.TalksTo(Observer);
    end;
  end;

  LinkReachLength;
  LinkReachNumber;
  LinkGroupNumber;
  LinkRoutingType;

  ReachLengthFormula :=  DefaultReachLengthFormula;
end;

procedure TSwrReachBoundary.CreateFormulaObjects;
begin
  FReachLengthFormula := CreateFormulaObject(dsoTop);
end;

class function TSwrReachBoundary.DefaultReachLengthFormula: string;
begin
  result := 'IfR((ObjectIntersectLength > 0.), ObjectIntersectLength, Sqrt(Sqr(ColumnWidth) + Sqr(RowWidth)))';
end;

destructor TSwrReachBoundary.Destroy;
begin
  ReachLengthFormula := '0';

  FConnections.Free;
  inherited;
end;

procedure TSwrReachBoundary.GetCellValues(ValueTimeList: TList;
  ParamList: TStringList; AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TSwrReachTransientStorage;
begin
  EvaluateListBoundaries(AModel);
  for ValueIndex := 0 to Values.Count - 1 do
  begin
    if ValueIndex < Values.BoundaryCount[AModel] then
    begin
      BoundaryStorage := Values.Boundaries[ValueIndex, AModel] as TSwrReachTransientStorage;
      AssignCells(BoundaryStorage, ValueTimeList, AModel);
    end;
  end;
end;

function TSwrReachBoundary.GetGroupNumberObserver: TObserver;
begin
  result := FObserverList[GroupNumberPosition];
end;

procedure TSwrReachBoundary.GetPropertyObserver(Sender: TObject; List: TList);
begin
  if Sender = FReachLengthFormula then
  begin
    List.Add(FObserverList[ReachLengthPosition]);
  end;
end;

function TSwrReachBoundary.GetReachLengthFormula: string;
begin
  Result := FReachLengthFormula.Formula;
  if ScreenObject <> nil then
  begin
    ResetItemObserver(ReachLengthPosition);
  end;
end;

function TSwrReachBoundary.GetReachLengthObserver: TObserver;
begin
  result := FObserverList[ReachLengthPosition];
end;

function TSwrReachBoundary.GetReachNumberObserver: TObserver;
begin
  result := FObserverList[ReachNumberPosition];
end;

function TSwrReachBoundary.GetRoutingTypeObserver: TObserver;
begin
  result := FObserverList[RoutingTypePosition];
end;

procedure TSwrReachBoundary.InvalidateDisplay;
var
  LocalModel: TCustomModel;
begin
  inherited;
  if Used and (ParentModel <> nil) then
  begin
    LocalModel := ParentModel as TCustomModel;
    if LocalModel.ModflowPackages.SwrPackage.StageSpecification = smObject then
    begin
      LocalModel.InvalidateMfSwrStage(self);
    end;
    LocalModel.InvalidateMfSwrVerticalOffset(self);
    LocalModel.InvalidateMfSwrBoundaryType(self);
    LocalModel.InvalidateMfSwrGeometryNumber(self);
  end;
end;

procedure TSwrReachBoundary.Loaded;
begin
  inherited;
  Connections.Loaded;
  LinkReachLength;
  LinkReachNumber;
  LinkGroupNumber;
  LinkRoutingType;
end;

function TSwrReachBoundary.ReachValues: TSwrReachCollection;
begin
  result := Values as TSwrReachCollection;
end;

procedure TSwrReachBoundary.RemoveGeom(Geom: TReachGeometryItem);
begin
  (Values as TSwrReachCollection).RemoveGeom(Geom);
end;

procedure TSwrReachBoundary.LinkGroupNumber;
var
  LocalScreenObject: TScreenObject;
  SwrGroupNumberArray: TDataArray;
begin
  LocalScreenObject := ScreenObject as TScreenObject;
  if (LocalScreenObject <> nil) and LocalScreenObject.CanInvalidateModel then
  begin
    LocalScreenObject.TalksTo(GroupNumberObserver);
    if ParentModel <> nil then
    begin
      SwrGroupNumberArray := (ParentModel as TCustomModel).DataArrayManager.
        GetDataSetByName(KSwrReachGroup);
      if SwrGroupNumberArray <> nil then
      begin
        GroupNumberObserver.TalksTo(SwrGroupNumberArray);
      end;
    end;
  end;
end;

procedure TSwrReachBoundary.LinkReachLength;
var
  LocalScreenObject: TScreenObject;
  SwrReachLengthArray: TDataArray;
begin
  LocalScreenObject := ScreenObject as TScreenObject;
  if (LocalScreenObject <> nil) and LocalScreenObject.CanInvalidateModel then
  begin
    LocalScreenObject.TalksTo(ReachLengthObserver);
    if ParentModel <> nil then
    begin
      SwrReachLengthArray := (ParentModel as TCustomModel).DataArrayManager.
        GetDataSetByName(KSwrReachLength);
      if SwrReachLengthArray <> nil then
      begin
        ReachLengthObserver.TalksTo(SwrReachLengthArray);
      end;
    end;
  end;
end;

procedure TSwrReachBoundary.LinkReachNumber;
var
  LocalScreenObject: TScreenObject;
  SwrReachNumberArray: TDataArray;
begin
  LocalScreenObject := ScreenObject as TScreenObject;
  if (LocalScreenObject <> nil) and LocalScreenObject.CanInvalidateModel then
  begin
    LocalScreenObject.TalksTo(ReachNumberObserver);
    if ParentModel <> nil then
    begin
      SwrReachNumberArray := (ParentModel as TCustomModel).DataArrayManager.
        GetDataSetByName(KSwrReach);
      if SwrReachNumberArray <> nil then
      begin
        ReachNumberObserver.TalksTo(SwrReachNumberArray);
      end;
    end;
  end;
end;

procedure TSwrReachBoundary.LinkRoutingType;
var
  LocalScreenObject: TScreenObject;
  SwrRoutingTypeArray: TDataArray;
begin
  LocalScreenObject := ScreenObject as TScreenObject;
  if (LocalScreenObject <> nil) and LocalScreenObject.CanInvalidateModel then
  begin
    LocalScreenObject.TalksTo(RoutingTypeObserver);
    if ParentModel <> nil then
    begin
      SwrRoutingTypeArray := (ParentModel as TCustomModel).DataArrayManager.
        GetDataSetByName(KSwrRoutingType);
      if SwrRoutingTypeArray <> nil then
      begin
        RoutingTypeObserver.TalksTo(SwrRoutingTypeArray);
      end;
    end;
  end;
end;

procedure TSwrReachBoundary.SetConnections(const Value: TSwrConnections);
begin
  FConnections.Assign(Value);
end;

procedure TSwrReachBoundary.SetGrouped(const Value: boolean);
begin
  if FGrouped <> Value then
  begin
    FGrouped := Value;
    GroupNumberObserver.UpToDate := True;
    GroupNumberObserver.UpToDate := False;
    InvalidateModel;
  end;
end;

procedure TSwrReachBoundary.SetGroupNumber(const Value: Integer);
begin
  if FGroupNumber <> Value then
  begin
    FGroupNumber := Value;
    InvalidateModel;
  end;
end;

procedure TSwrReachBoundary.SetMultiLayer(const Value: Boolean);
begin
  if FMultiLayer <> Value then
  begin
    FMultiLayer := Value;
    GroupNumberObserver.UpToDate := True;
    GroupNumberObserver.UpToDate := False;
    InvalidateModel;
  end;
end;

procedure TSwrReachBoundary.SetObjectObs(const Value: TSwrObsTypes);
begin
  if FObsTypes <> Value then
  begin
    FObsTypes := Value;
    InvalidateModel;
  end;
end;

procedure TSwrReachBoundary.SetReachLengthFormula(const Value: string);
begin
  UpdateFormula(Value, ReachLengthPosition, FReachLengthFormula);
end;

procedure TSwrReachBoundary.SetRouteType(const Value: TSwrRouteType);
begin
  if FRouteType <> Value then
  begin
    FRouteType := Value;
    RoutingTypeObserver.UpToDate := True;
    RoutingTypeObserver.UpToDate := False;
    InvalidateModel;
  end;
end;

{ TSwrConnectionItem }

procedure TSwrConnectionItem.Assign(Source: TPersistent);
var
  SourceItem: TSwrConnectionItem;
begin
  if Source is TSwrConnectionItem then
  begin
    SourceItem := TSwrConnectionItem(Source);
    ScreenObjectName := SourceItem.ScreenObjectName;
    Method := SourceItem.Method;
    Reach := SourceItem.Reach;
  end
  else
  begin
    inherited;
  end;
end;

function TSwrConnectionItem.GetScreenObject: TObject;
var
  LocalModel: TCustomModel;
begin
  if FScreenObject = nil then
  begin
    LocalModel := ParentModel as TCustomModel;
    if (LocalModel <> nil) and (FScreenObjectName <> '') then
    begin
      FScreenObject := LocalModel.GetScreenObjectByName(FScreenObjectName);
    end;
  end;
  result := FScreenObject;
end;

function TSwrConnectionItem.GetScreenObjectName: string;
begin
  if FScreenObject = nil then
  begin
    result := FScreenObjectName;
  end
  else
  begin
    result := (FScreenObject as TScreenObject).Name;
  end;
end;

function TSwrConnectionItem.IsSame(AnItem: TSwrConnectionItem): Boolean;
begin
  result := (ScreenObjectName = AnItem.ScreenObjectName)
    and (Method = AnItem.Method)
    and (Reach = AnItem.Reach);
end;

procedure TSwrConnectionItem.Loaded;
begin
  ScreenObject;
end;

function TSwrConnectionItem.ParentModel: TBaseModel;
begin
  result := (Collection as TSwrConnections).FModel;
end;

procedure TSwrConnectionItem.SetMethod(const Value: TSwrConnectionMethod);
begin
  if FMethod <> Value then
  begin
    FMethod := Value;
    InvalidateModel;
  end;
end;

procedure TSwrConnectionItem.SetReach(const Value: integer);
begin
  SetIntegerProperty(FReach, Value);
end;

procedure TSwrConnectionItem.SetScreenObject(const Value: TObject);
begin
  if FScreenObject <> Value then
  begin
    FScreenObject := Value;
    InvalidateModel;
    if FScreenObject <> nil then
    begin
      FScreenObjectName := (FScreenObject as TScreenObject).Name;
    end
    else
    begin
      FScreenObjectName := '';
    end;
  end;
end;

procedure TSwrConnectionItem.SetScreenObjectName(const Value: string);
var
  AScreenObject: TScreenObject;
  LocalModel: TCustomModel;
begin
  if FScreenObjectName <> Value then
  begin
    FScreenObjectName := Value;
    LocalModel := ParentModel as TCustomModel;
    if (LocalModel <> nil) and (FScreenObjectName <> '') then
    begin
      AScreenObject := LocalModel.GetScreenObjectByName(FScreenObjectName);
      if AScreenObject <> nil then
      begin
        FScreenObjectName := AScreenObject.Name;
//      end
//      else
//      begin
//        FScreenObjectName := '';
      end;
      FScreenObject := AScreenObject;
    end;
  end;
end;

{ TSwrConnections }

function TSwrConnections.Add: TSwrConnectionItem;
begin
  result := inherited Add as TSwrConnectionItem;
end;

constructor TSwrConnections.Create(Model: TBaseModel);
begin
  FModel := Model;
  inherited Create(TSwrConnectionItem, InvalidateModelEvent);
end;

function TSwrConnections.GetInvalidateModelEvent: TNotifyEvent;
begin
  if FModel = nil then
  begin
    result := nil;
  end
  else
  begin
    result := FModel.Invalidate;
  end;
end;

function TSwrConnections.GetItem(Index: Integer): TSwrConnectionItem;
begin
  result := inherited Items[Index] as TSwrConnectionItem;
end;

function TSwrConnections.IsSame(Connections: TSwrConnections): Boolean;
var
  index: Integer;
begin
  result := Count = Connections.Count;
  if result then
  begin
    for index := 0 to Count - 1 do
    begin
      result := Items[index].IsSame(Connections[index]);
      if not Result then
      begin
        break;
      end;
    end;
  end;
end;

procedure TSwrConnections.Loaded;
var
  index: Integer;
begin
  inherited;
  for index := 0 to Count - 1 do
  begin
    Items[Index].Loaded;
  end;
end;

procedure TSwrConnections.SetItem(Index: Integer;
  const Value: TSwrConnectionItem);
begin
  inherited Items[Index] := Value;
end;

end.

