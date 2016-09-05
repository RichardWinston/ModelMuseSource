unit ModflowUzfUnit;

interface

uses Windows, ZLib, SysUtils, Classes, Contnrs, RealListUnit,
  OrderedCollectionUnit, ModflowBoundaryUnit, DataSetUnit, ModflowCellUnit,
  ModflowRchUnit, ModflowEvtUnit, FormulaManagerUnit, SubscriptionUnit,
  SparseDataSets, GoPhastTypes;

type

  {
    @longcode(
  TUzfExtinctionDepthRecord = record
    Cell: TCellLocation;
    ExtinctionDepth: double;
    StartingTime: double;
    EndingTime: double;
    ExtinctionDepthAnnotation: string;
  end;
    )
    @name stores the location, time, and ET extinction depth for a cell.
  }
  TUzfExtinctionDepthRecord = record
    Cell: TCellLocation;
    ExtinctionDepth: double;
    StartingTime: double;
    EndingTime: double;
    ExtinctionDepthAnnotation: string;
    procedure Cache(Comp: TCompressionStream; Strings: TStringList);
    procedure Restore(Decomp: TDecompressionStream; Annotations: TStringList);
    procedure RecordStrings(Strings: TStringList);
  end;

  {
    @longcode(
  TUzfWaterContentRecord = record
    Cell: TCellLocation;
    MinimumWaterContent: double;
    StartingTime: double;
    EndingTime: double;
    MinimumWaterContentAnnotation: string;
  end;
    )
    @name stores the location, time, and ET extinction water content for a cell.
  }
  TUzfWaterContentRecord = record
    Cell: TCellLocation;
    MinimumWaterContent: double;
    StartingTime: double;
    EndingTime: double;
    MinimumWaterContentAnnotation: string;
    procedure Cache(Comp: TCompressionStream; Strings: TStringList);
    procedure Restore(Decomp: TDecompressionStream; Annotations: TStringList); 
    procedure RecordStrings(Strings: TStringList);
  end;

  // @name is an array of @link(TUzfExtinctionDepthRecord)s.
  TUzfExtinctDepthArray = array of TUzfExtinctionDepthRecord;
  // @name is an array of @link(TUzfWaterContentRecord)s.
  TUzfWaterContentArray = array of TUzfWaterContentRecord;

  // @name extends @link(TCustomBoundaryStorage) by adding
  // a @link(TUzfExtinctDepthArray).
  TUzfExtinctDepthStorage = class(TCustomBoundaryStorage)
  private
    FExtinctDepthArray: TUzfExtinctDepthArray;
    function GetExtinctDepthArray: TUzfExtinctDepthArray;
  protected
    procedure Restore(DecompressionStream: TDecompressionStream; Annotations: TStringList); override;
    procedure Store(Compressor: TCompressionStream); override;
    procedure Clear; override;
  public
    property ExtinctDepthArray: TUzfExtinctDepthArray read GetExtinctDepthArray;
  end;

  // @name extends @link(TCustomBoundaryStorage) by adding
  // a @link(TUzfWaterContentArray).
  TUzfWaterContentStorage = class(TCustomBoundaryStorage)
  private
    FWaterContentArray: TUzfWaterContentArray;
    function GetWaterContentArray: TUzfWaterContentArray;
  protected
    procedure Restore(DecompressionStream: TDecompressionStream; Annotations: TStringList); override;
    procedure Store(Compressor: TCompressionStream); override;
    procedure Clear; override;
  public
    property WaterContentArray: TUzfWaterContentArray read GetWaterContentArray;
  end;

  // @name represents a MODFLOW UZF Extinction Depth for one time interval.
  // @name is stored by @link(TUzfExtinctionDepthCollection).
  TUzfExtinctDepthItem = class(TCustomModflowBoundaryItem)
  private
    // See @link(UzfExtinctDepth).
    FUzfExtinctDepth: TFormulaObject;
    // See @link(UzfExtinctDepth).
    procedure SetUzfExtinctDepth(const Value: string);
    function GetUzfExtinctDepth: string;
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
  public
    // @name copies Source to this @classname.
    procedure Assign(Source: TPersistent);override;
    Destructor Destroy; override;
  published
    // @name is the formula used to set the recharge rate
    // or the recharge rate multiplier of this boundary.
    property UzfExtinctDepth: string read GetUzfExtinctDepth write SetUzfExtinctDepth;
  end;

  // @name represents a MODFLOW UZF Extinction water content for one time interval.
  // @name is stored by @link(TUzfWaterContentCollection).
  TUzfWaterContentItem = class(TCustomModflowBoundaryItem)
  private
    // See @link(UzfWaterContent).
    FUzfWaterContent: TFormulaObject;
    // See @link(UzfWaterContent).
    procedure SetUzfWaterContent(const Value: string);
    function GetUzfWaterContent: string;
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
  public
    // @name copies Source to this @classname.
    procedure Assign(Source: TPersistent);override;
    Destructor Destroy; override;
  published
    // @name is the formula used to set the recharge rate
    // or the recharge rate multiplier of this boundary.
    property UzfWaterContent: string read GetUzfWaterContent write SetUzfWaterContent;
  end;

  TUzfExtinctionDepthTimeListLink = class(TTimeListsModelLink)
  private
    // @name is used to compute the extinction depths for a series of
    // cells over a series of time intervals.
    FExtinctionDepthData: TModflowTimeList;
  protected
    procedure CreateTimeLists; override;
  public
    Destructor Destroy; override;
  end;

  // @name represents MODFLOW UZF extinction depth
  // for a series of time intervals.
  TUzfExtinctionDepthCollection = class(TCustomMF_ArrayBoundColl)
  private
    procedure InvalidateUzfExtinctDepthData(Sender: TObject);
  protected
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
    procedure AddSpecificBoundary(AModel: TBaseModel); override;
    // See @link(TCustomListArrayBoundColl.AssignArrayCellValues
    // TCustomListArrayBoundColl.AssignArrayCellValues)
    procedure AssignArrayCellValues(DataSets: TList; ItemIndex: Integer;
      AModel: TBaseModel); override;
    // See @link(TCustomListArrayBoundColl.InitializeTimeLists
    // TCustomListArrayBoundColl.InitializeTimeLists)
    procedure InitializeTimeLists(ListOfTimeLists: TList; AModel: TBaseModel); override;
    // See @link(TCustomNonSpatialBoundColl.ItemClass
    // TCustomNonSpatialBoundColl.ItemClass)
    class function ItemClass: TBoundaryItemClass; override;
    // @name calls inherited @name and then sets the length of
    // the @link(TEvtStorage.EvtArray) at ItemIndex in
    // @link(TCustomMF_BoundColl.Boundaries) to BoundaryCount.
    // @SeeAlso(TCustomMF_BoundColl.SetBoundaryStartAndEndTime
    // TCustomMF_BoundColl.SetBoundaryStartAndEndTime)
    procedure SetBoundaryStartAndEndTime(BoundaryCount: Integer;
      Item: TCustomModflowBoundaryItem; ItemIndex: Integer; AModel: TBaseModel); override;
  end;

  TUzfWaterContentTimeListLink = class(TTimeListsModelLink)
  private
    // @name is used to compute the water contents for a series of
    // cells over a series of time intervals.
    FWaterContentData: TModflowTimeList;
  protected
    procedure CreateTimeLists; override;
  public
    Destructor Destroy; override;
  end;

  // @name represents MODFLOW UZF water content boundaries
  // for a series of time intervals.
  TUzfWaterContentCollection = class(TCustomMF_ArrayBoundColl)
  private
    procedure InvalidateUzfWaterContentData(Sender: TObject);
  protected
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
    procedure AddSpecificBoundary(AModel: TBaseModel); override;
    // See @link(TCustomListArrayBoundColl.AssignArrayCellValues
    // TCustomListArrayBoundColl.AssignArrayCellValues)
    procedure AssignArrayCellValues(DataSets: TList;ItemIndex: Integer;
      AModel: TBaseModel); override;
    // See @link(TCustomListArrayBoundColl.InitializeTimeLists
    // TCustomListArrayBoundColl.InitializeTimeLists)
    procedure InitializeTimeLists(ListOfTimeLists: TList; AModel: TBaseModel); override;
    // See @link(TCustomNonSpatialBoundColl.ItemClass
    // TCustomNonSpatialBoundColl.ItemClass)
    class function ItemClass: TBoundaryItemClass; override;
    // @name calls inherited @name and then sets the length of
    // the @link(TEvtStorage.EvtArray) at ItemIndex in
    // @link(TCustomMF_BoundColl.Boundaries) to BoundaryCount.
    // @SeeAlso(TCustomMF_BoundColl.SetBoundaryStartAndEndTime
    // TCustomMF_BoundColl.SetBoundaryStartAndEndTime)
    procedure SetBoundaryStartAndEndTime(BoundaryCount: Integer;
      Item: TCustomModflowBoundaryItem; ItemIndex: Integer; AModel: TBaseModel); override;
  end;

  TUzfInfiltrationRateTimeListLink = class(TRchTimeListLink)
  protected
    procedure CreateTimeLists; override;
  end;

  TUzfInfiltrationRateCollection = class(TRchCollection)
  protected
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
    function PackageAssignmentMethod(AModel: TBaseModel): TUpdateMethod; override;
  end;

  TUzfEvtTimeListLink = class(TEvtTimeListLink)
  protected
    procedure CreateTimeLists; override;
  end;

  TUzfEvapotranspirationDemandCollection = class(TEvtCollection)
  protected
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
  end;

  TUzfExtinctionDepthCell = class(TValueCell)
  private
    FValues: TUzfExtinctionDepthRecord;
    FStressPeriod: integer;
    function GetExtinctionDepth: double;
    function GetExtinctionDepthAnnotation: string;
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
  public
    property ExtinctionDepth: double read GetExtinctionDepth;
    property ExtinctionDepthAnnotation: string read GetExtinctionDepthAnnotation;
    property StressPeriod: integer read FStressPeriod write FStressPeriod;
    property Values: TUzfExtinctionDepthRecord read FValues write FValues;
  end;

  TUzfWaterContentCell = class(TValueCell)
  private
    FValues: TUzfWaterContentRecord;
    FStressPeriod: integer;
    function GetWaterContent: double;
    function GetWaterContentAnnotation: string;
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
  public
    property WaterContent: double read GetWaterContent;
    property WaterContentAnnotation: string read GetWaterContentAnnotation;
    property StressPeriod: integer read FStressPeriod write FStressPeriod;
    property Values: TUzfWaterContentRecord read FValues write FValues;
  end;

  TUzfBoundary = class(TModflowBoundary)
  private
    FEvapotranspirationDemand: TUzfEvapotranspirationDemandCollection;
    FExtinctionDepth: TUzfExtinctionDepthCollection;
    FWaterContent: TUzfWaterContentCollection;
    FGageOption2: integer;
    FGageOption1: integer;
    procedure SetEvapotranspirationDemand(
      const Value: TUzfEvapotranspirationDemandCollection);
    procedure SetExtinctionDepth(const Value: TUzfExtinctionDepthCollection);
    procedure SetWaterContent(const Value: TUzfWaterContentCollection);
    procedure AssignEvapotranspirationDemandCells(BoundaryStorage: TEvtStorage;
      ValueTimeList: TList);
    procedure AssignExtinctionDepthCells(BoundaryStorage: TUzfExtinctDepthStorage;
      ValueTimeList: TList);
    procedure AssignWaterContentCells(BoundaryStorage: TUzfWaterContentStorage;
      ValueTimeList: TList);
    procedure SetGageOption1(const Value: integer);
    procedure SetGageOption2(const Value: integer);
  protected
    // @name fills ValueTimeList with a series of TObjectLists - one for
    // each stress period.  Each such TObjectList is filled with
    // @link(TRch_Cell)s for that stress period.
    procedure AssignCells(BoundaryStorage: TCustomBoundaryStorage;
      ValueTimeList: TList; AModel: TBaseModel); override;
    // See @link(TModflowBoundary.BoundaryCollectionClass
    // TModflowBoundary.BoundaryCollectionClass).
    class function BoundaryCollectionClass: TMF_BoundCollClass; override;
  public
    procedure Assign(Source: TPersistent);override;
    procedure Clear; override;
    Constructor Create(Model: TBaseModel; ScreenObject: TObject);
    Destructor Destroy; override;
    // @name fills ValueTimeList via a call to AssignCells for each
    // link  @link(TRchStorage) in
    // @link(TCustomMF_BoundColl.Boundaries Values.Boundaries);
    // Those represent non-parameter boundary conditions.
    // @name fills ParamList with the names of the
    // MODFLOW Recharge parameters that are in use.
    // The Objects property of ParamList has TObjectLists
    // Each such TObjectList is filled via a call to AssignCells
    // with each @link(TRchStorage) in @link(TCustomMF_BoundColl.Boundaries
    // Param.Param.Boundaries)
    // Those represent parameter boundary conditions.
    procedure GetCellValues(ValueTimeList: TList; ParamList: TStringList;
      AModel: TBaseModel); override;
    function Used: boolean; override;
    procedure EvaluateArrayBoundaries(AModel: TBaseModel); override;
    procedure InvalidateDisplay; override;
    procedure GetEvapotranspirationDemandCells(LayerTimeList: TList; AModel: TBaseModel);
    procedure GetExtinctionDepthCells(LayerTimeList: TList; AModel: TBaseModel);
    procedure GetWaterContentCells(LayerTimeList: TList; AModel: TBaseModel);
    procedure UpdateTimes(Times: TRealList; StartTestTime, EndTestTime: double;
      var StartRangeExtended, EndRangeExtended: boolean; AModel: TBaseModel); override;
  published
    property GageOption1: integer read FGageOption1 write SetGageOption1;
    property GageOption2: integer read FGageOption2 write SetGageOption2;
    property EvapotranspirationDemand: TUzfEvapotranspirationDemandCollection
      read FEvapotranspirationDemand write SetEvapotranspirationDemand;
    property ExtinctionDepth: TUzfExtinctionDepthCollection
      read FExtinctionDepth write SetExtinctionDepth;
    property WaterContent: TUzfWaterContentCollection
      read FWaterContent write SetWaterContent;
  end;

implementation

uses RbwParser, ScreenObjectUnit, PhastModelUnit, ModflowTimeUnit,
  ModflowTransientListParameterUnit, TempFiles, frmGoPhastUnit;

resourcestring
  StrEvapoTranspiration = 'Evapo- transpiration demand';
  StrETExtinctionDepth = 'ET extinction depth';
  StrETExtinctionWater = 'ET extinction water content';
  StrInfiltrationRate = 'Infiltration rate';

{ TUzfRateCollection }

const
  UzfExtinctDepthPosition = 0;
  UzfWaterContentPosition = 0;

{ TUzfBoundary }

procedure TUzfBoundary.Assign(Source: TPersistent);
var
  SourceBoundary: TUzfBoundary;
begin
  if Source is TUzfBoundary then
  begin
    SourceBoundary := TUzfBoundary(Source);
    EvapotranspirationDemand := SourceBoundary.EvapotranspirationDemand;
    ExtinctionDepth := SourceBoundary.ExtinctionDepth;
    WaterContent := SourceBoundary.WaterContent;
    GageOption1 := SourceBoundary.GageOption1;
    GageOption2 := SourceBoundary.GageOption2;
  end;
  inherited;
end;

procedure TUzfBoundary.AssignCells(BoundaryStorage: TCustomBoundaryStorage;
  ValueTimeList: TList; AModel: TBaseModel);
var
  Cell: TRch_Cell;
  BoundaryValues: TRchRecord;
  BoundaryIndex: Integer;
  StressPeriod: TModflowStressPeriod;
  TimeIndex: Integer;
  Cells: TValueCellList;
  LocalBoundaryStorage: TRchStorage;
  LocalModel: TCustomModel;
begin
  LocalModel := AModel as TCustomModel;
  LocalBoundaryStorage := BoundaryStorage as TRchStorage;
  for TimeIndex := 0 to
    LocalModel.ModflowFullStressPeriods.Count - 1 do
  begin
    if TimeIndex < ValueTimeList.Count then
    begin
      Cells := ValueTimeList[TimeIndex];
    end
    else
    begin
      Cells := TValueCellList.Create(TRch_Cell);
      ValueTimeList.Add(Cells);
    end;
    StressPeriod := LocalModel.ModflowFullStressPeriods[TimeIndex];
    // Check if the stress period is completely enclosed within the times
    // of the LocalBoundaryStorage;
    if (StressPeriod.StartTime + LocalModel.SP_Epsilon >= LocalBoundaryStorage.StartingTime)
      and (StressPeriod.EndTime - LocalModel.SP_Epsilon <= LocalBoundaryStorage.EndingTime) then
    begin
      if Cells.Capacity < Cells.Count + Length(LocalBoundaryStorage.RchArray) then
      begin
        Cells.Capacity := Cells.Count + Length(LocalBoundaryStorage.RchArray)
      end;
//      Cells.CheckRestore;
      for BoundaryIndex := 0 to Length(LocalBoundaryStorage.RchArray) - 1 do
      begin
//        Cells.Cached := False;
        BoundaryValues := LocalBoundaryStorage.RchArray[BoundaryIndex];
        Cell := TRch_Cell.Create;
        Cells.Add(Cell);
        Cell.StressPeriod := TimeIndex;
        Cell.Values := BoundaryValues;
        LocalModel.AdjustCellPosition(Cell);
      end;
      Cells.Cache;
    end;
  end;
  LocalBoundaryStorage.CacheData;
end;

procedure TUzfBoundary.AssignEvapotranspirationDemandCells(
  BoundaryStorage: TEvtStorage; ValueTimeList: TList);
var
  Cell: TEvt_Cell;
  BoundaryValues: TEvtRecord;
  BoundaryIndex: Integer;
  StressPeriod: TModflowStressPeriod;
  TimeIndex: Integer;
  Cells: TValueCellList;
  LocalBoundaryStorage: TEvtStorage;
begin
  LocalBoundaryStorage := BoundaryStorage;
  for TimeIndex := 0 to
    (ParentModel as TPhastModel).ModflowFullStressPeriods.Count - 1 do
  begin
    if TimeIndex < ValueTimeList.Count then
    begin
      Cells := ValueTimeList[TimeIndex];
    end
    else
    begin
      Cells := TValueCellList.Create(TEvt_Cell);
      ValueTimeList.Add(Cells);
    end;
    StressPeriod := (ParentModel as TPhastModel).ModflowFullStressPeriods[TimeIndex];
    // Check if the stress period is completely enclosed within the times
    // of the LocalBoundaryStorage;
    if (StressPeriod.StartTime >= LocalBoundaryStorage.StartingTime)
      and (StressPeriod.EndTime <= LocalBoundaryStorage.EndingTime) then
    begin
//      Cells.CheckRestore;
      for BoundaryIndex := 0 to Length(LocalBoundaryStorage.EvtArray) - 1 do
      begin
//        Cells.Cached := False;
        BoundaryValues := LocalBoundaryStorage.EvtArray[BoundaryIndex];
        Cell := TEvt_Cell.Create;
        Cells.Add(Cell);
        Cell.StressPeriod := TimeIndex;
        Cell.Values := BoundaryValues;
      end;
      Cells.Cache;
    end;
  end;
  LocalBoundaryStorage.CacheData;
end;

procedure TUzfBoundary.AssignExtinctionDepthCells(
  BoundaryStorage: TUzfExtinctDepthStorage; ValueTimeList: TList);
var
  Cell: TUzfExtinctionDepthCell;
  BoundaryValues: TUzfExtinctionDepthRecord;
  BoundaryIndex: Integer;
  StressPeriod: TModflowStressPeriod;
  TimeIndex: Integer;
  Cells: TValueCellList;
  LocalBoundaryStorage: TUzfExtinctDepthStorage;
begin
  LocalBoundaryStorage := BoundaryStorage;
  for TimeIndex := 0 to
    (ParentModel as TPhastModel).ModflowFullStressPeriods.Count - 1 do
  begin
    if TimeIndex < ValueTimeList.Count then
    begin
      Cells := ValueTimeList[TimeIndex];
    end
    else
    begin
      Cells := TValueCellList.Create(TUzfExtinctionDepthCell);
      ValueTimeList.Add(Cells);
    end;
    StressPeriod := (ParentModel as TPhastModel).ModflowFullStressPeriods[TimeIndex];
    // Check if the stress period is completely enclosed within the times
    // of the LocalBoundaryStorage;
    if (StressPeriod.StartTime >= LocalBoundaryStorage.StartingTime)
      and (StressPeriod.EndTime <= LocalBoundaryStorage.EndingTime) then
    begin
//      Cells.CheckRestore;
      for BoundaryIndex := 0 to Length(LocalBoundaryStorage.ExtinctDepthArray) - 1 do
      begin
//        Cells.Cached := False;
        BoundaryValues := LocalBoundaryStorage.ExtinctDepthArray[BoundaryIndex];
        Cell := TUzfExtinctionDepthCell.Create;
        Assert(ScreenObject <> nil);
        Cell.IFace := (ScreenObject as TScreenObject).IFace;
        Cells.Add(Cell);
        Cell.StressPeriod := TimeIndex;
        Cell.Values := BoundaryValues;
      end;
      Cells.Cache;
    end;
  end;
  LocalBoundaryStorage.CacheData;
end;

procedure TUzfBoundary.AssignWaterContentCells(
  BoundaryStorage: TUzfWaterContentStorage; ValueTimeList: TList);
var
  Cell: TUzfWaterContentCell;
  BoundaryValues: TUzfWaterContentRecord;
  BoundaryIndex: Integer;
  StressPeriod: TModflowStressPeriod;
  TimeIndex: Integer;
  Cells: TValueCellList;
  LocalBoundaryStorage: TUzfWaterContentStorage;
begin
  LocalBoundaryStorage := BoundaryStorage;
  for TimeIndex := 0 to
    (ParentModel as TPhastModel).ModflowFullStressPeriods.Count - 1 do
  begin
    if TimeIndex < ValueTimeList.Count then
    begin
      Cells := ValueTimeList[TimeIndex];
    end
    else
    begin
      Cells := TValueCellList.Create(TUzfWaterContentCell);
      ValueTimeList.Add(Cells);
    end;
    StressPeriod := (ParentModel as TPhastModel).ModflowFullStressPeriods[TimeIndex];
    // Check if the stress period is completely enclosed within the times
    // of the LocalBoundaryStorage;
    if (StressPeriod.StartTime >= LocalBoundaryStorage.StartingTime)
      and (StressPeriod.EndTime <= LocalBoundaryStorage.EndingTime) then
    begin
//      Cells.CheckRestore;
      for BoundaryIndex := 0 to Length(LocalBoundaryStorage.WaterContentArray) - 1 do
      begin
//        Cells.Cached := False;
        BoundaryValues := LocalBoundaryStorage.WaterContentArray[BoundaryIndex];
        Cell := TUzfWaterContentCell.Create;
        Assert(ScreenObject <> nil);
        Cell.IFace := (ScreenObject as TScreenObject).IFace;
        Cells.Add(Cell);
        Cell.StressPeriod := TimeIndex;
        Cell.Values := BoundaryValues;
      end;
      Cells.Cache;
    end;
  end;
  LocalBoundaryStorage.CacheData;
end;

class function TUzfBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := TUzfInfiltrationRateCollection;
end;

procedure TUzfBoundary.Clear;
begin
  inherited;
  EvapotranspirationDemand.Clear;
  ExtinctionDepth.Clear;
  WaterContent.Clear;
  GageOption1 := 0;
  GageOption2 := 0;
end;

constructor TUzfBoundary.Create(Model: TBaseModel; ScreenObject: TObject);
begin
  inherited Create(Model, ScreenObject);
  FEvapotranspirationDemand := TUzfEvapotranspirationDemandCollection.
    Create(self, Model, ScreenObject);
  FExtinctionDepth := TUzfExtinctionDepthCollection.
    Create(self, Model, ScreenObject);
  FWaterContent := TUzfWaterContentCollection.
    Create(self, Model, ScreenObject);
end;

destructor TUzfBoundary.Destroy;
begin
  FWaterContent.Free;
  FExtinctionDepth.Free;
  FEvapotranspirationDemand.Free;
  inherited;
end;

procedure TUzfBoundary.EvaluateArrayBoundaries(AModel: TBaseModel);
begin
  inherited;
  if (ParentModel as TPhastModel).ModflowPackages.UzfPackage.SimulateET then
  begin
    EvapotranspirationDemand.EvaluateArrayBoundaries(AModel);
    ExtinctionDepth.EvaluateArrayBoundaries(AModel);
    FWaterContent.EvaluateArrayBoundaries(AModel);
  end;
end;

procedure TUzfBoundary.GetCellValues(ValueTimeList: TList;
  ParamList: TStringList; AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TRchStorage;
begin
  EvaluateArrayBoundaries(AModel);
  for ValueIndex := 0 to Values.Count - 1 do
  begin
    if ValueIndex < Values.BoundaryCount[AModel] then
    begin
      BoundaryStorage := Values.Boundaries[ValueIndex, AModel] as TRchStorage;
      AssignCells(BoundaryStorage, ValueTimeList, AModel);
    end;
  end;
end;

procedure TUzfBoundary.GetEvapotranspirationDemandCells(LayerTimeList: TList; AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TEvtStorage;
begin
  for ValueIndex := 0 to EvapotranspirationDemand.Count - 1 do
  begin
    if ValueIndex < EvapotranspirationDemand.BoundaryCount[AModel] then
    begin
      BoundaryStorage := EvapotranspirationDemand.Boundaries[ValueIndex, AModel] as TEvtStorage;
      AssignEvapotranspirationDemandCells(BoundaryStorage, LayerTimeList);
    end;
  end;
end;

procedure TUzfBoundary.GetExtinctionDepthCells(LayerTimeList: TList; AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TUzfExtinctDepthStorage;
begin
  for ValueIndex := 0 to ExtinctionDepth.Count - 1 do
  begin
    if ValueIndex < ExtinctionDepth.BoundaryCount[AModel] then
    begin
      BoundaryStorage := ExtinctionDepth.Boundaries[ValueIndex, AModel] as TUzfExtinctDepthStorage;
      AssignExtinctionDepthCells(BoundaryStorage, LayerTimeList);
    end;
  end;
end;

procedure TUzfBoundary.GetWaterContentCells(LayerTimeList: TList; AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TUzfWaterContentStorage;
begin
  for ValueIndex := 0 to WaterContent.Count - 1 do
  begin
    if ValueIndex < WaterContent.BoundaryCount[AModel] then
    begin
      BoundaryStorage := WaterContent.Boundaries[ValueIndex, AModel] as TUzfWaterContentStorage;
      AssignWaterContentCells(BoundaryStorage, LayerTimeList);
    end;
  end;
end;

procedure TUzfBoundary.InvalidateDisplay;
var
  Model: TPhastModel;
begin
  inherited;
  if Used and (ParentModel <> nil) then
  begin
    Model := ParentModel as TPhastModel;
    Model.InvalidateMfUzfInfiltration(self);
    Model.InvalidateMfUzfEtDemand(self);
    Model.InvalidateMfUzfExtinctionDepth(self);
    Model.InvalidateMfUzfWaterContent(self);
  end;
end;

procedure TUzfBoundary.SetEvapotranspirationDemand(
  const Value: TUzfEvapotranspirationDemandCollection);
begin
  FEvapotranspirationDemand.Assign(Value);
end;

procedure TUzfBoundary.SetExtinctionDepth(
  const Value: TUzfExtinctionDepthCollection);
begin
  FExtinctionDepth.Assign(Value);
end;

procedure TUzfBoundary.SetGageOption1(const Value: integer);
begin
  if FGageOption1 <> Value then
  begin
    Assert(Value in [0, 1, 2]);
    FGageOption1 := Value;
    if ScreenObject <> nil then
    begin
      (ScreenObject as TScreenObject).UpdateUzfGage1and2;
    end;
    InvalidateModel;
  end;
end;

procedure TUzfBoundary.SetGageOption2(const Value: integer);
begin
  if FGageOption2 <> Value then
  begin
    Assert(Value in [0, 3]);
    FGageOption2 := Value;
    if ScreenObject <> nil then
    begin
      (ScreenObject as TScreenObject).UpdateUzfGage3;
    end;
    InvalidateModel;
  end;
end;

procedure TUzfBoundary.SetWaterContent(const Value: TUzfWaterContentCollection);
begin
  FWaterContent.Assign(Value);
end;

procedure TUzfBoundary.UpdateTimes(Times: TRealList;
  StartTestTime, EndTestTime: double; var StartRangeExtended,
  EndRangeExtended: boolean; AModel: TBaseModel);
begin
  inherited;
  AddBoundaryTimes(EvapotranspirationDemand, Times, StartTestTime, EndTestTime, StartRangeExtended, EndRangeExtended);
  AddBoundaryTimes(ExtinctionDepth, Times, StartTestTime, EndTestTime, StartRangeExtended, EndRangeExtended);
  AddBoundaryTimes(WaterContent, Times, StartTestTime, EndTestTime, StartRangeExtended, EndRangeExtended);
end;

function TUzfBoundary.Used: boolean;
begin
  result := inherited Used
    or EvapotranspirationDemand.Used
    or ExtinctionDepth.Used
    or WaterContent.Used
    or (GageOption1 <> 0)
    or (GageOption2 <> 0)
end;

{ TUzfEvapotranspirationDemandCollection }

function TUzfEvapotranspirationDemandCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TUzfEvtTimeListLink;
end;

{ TUzfExtinctDepthItem }

procedure TUzfExtinctDepthItem.Assign(Source: TPersistent);
begin
  // if Assign is updated, update IsSame too.
  if Source is TUzfExtinctDepthItem then
  begin
    UzfExtinctDepth := TUzfExtinctDepthItem(Source).UzfExtinctDepth;
  end;
  inherited;
end;

procedure TUzfExtinctDepthItem.AssignObserverEvents(Collection: TCollection);
var
  ParentCollection: TUzfExtinctionDepthCollection;
  UzfExtinctDepthObserver: TObserver;
begin
  ParentCollection := Collection as TUzfExtinctionDepthCollection;
  UzfExtinctDepthObserver := FObserverList[UzfExtinctDepthPosition];
  UzfExtinctDepthObserver.OnUpToDateSet := ParentCollection.InvalidateUzfExtinctDepthData;
end;

function TUzfExtinctDepthItem.BoundaryFormulaCount: integer;
begin
  result := 1;
end;

procedure TUzfExtinctDepthItem.CreateFormulaObjects;
begin
  FUzfExtinctDepth := CreateFormulaObject(dso3D);
end;

destructor TUzfExtinctDepthItem.Destroy;
begin
  UzfExtinctDepth := '0';
  inherited;
end;

function TUzfExtinctDepthItem.GetBoundaryFormula(Index: integer): string;
begin
  case Index of
    UzfExtinctDepthPosition: result := UzfExtinctDepth;
    else Assert(False);
  end;
end;

procedure TUzfExtinctDepthItem.GetPropertyObserver(Sender: TObject; List: TList);
begin
  Assert(Sender = FUzfExtinctDepth);
  List.Add( FObserverList[UzfExtinctDepthPosition]);
end;

function TUzfExtinctDepthItem.GetUzfExtinctDepth: string;
begin
  Result := FUzfExtinctDepth.Formula;
  ResetItemObserver(UzfExtinctDepthPosition);
end;

function TUzfExtinctDepthItem.IsSame(AnotherItem: TOrderedItem): boolean;
var
  Item: TUzfExtinctDepthItem;
begin
  result := (AnotherItem is TUzfExtinctDepthItem) and inherited IsSame(AnotherItem);
  if result then
  begin
    Item := TUzfExtinctDepthItem(AnotherItem);
    result := (Item.UzfExtinctDepth = UzfExtinctDepth)
  end;
end;

procedure TUzfExtinctDepthItem.RemoveFormulaObjects;
begin
  frmGoPhast.PhastModel.FormulaManager.Remove(FUzfExtinctDepth,
    GlobalRemoveModflowBoundaryItemSubscription, GlobalRestoreModflowBoundaryItemSubscription, self);
end;

procedure TUzfExtinctDepthItem.SetBoundaryFormula(Index: integer;
  const Value: string);
begin
  case Index of
    UzfExtinctDepthPosition: UzfExtinctDepth := Value;
    else Assert(False);
  end;
end;

procedure TUzfExtinctDepthItem.SetUzfExtinctDepth(const Value: string);
begin
  UpdateFormula(Value, UzfExtinctDepthPosition, FUzfExtinctDepth);
end;

{ TUzfWaterContentItem }

procedure TUzfWaterContentItem.Assign(Source: TPersistent);
begin
  // if Assign is updated, update IsSame too.
  if Source is TUzfWaterContentItem then
  begin
    UzfWaterContent := TUzfWaterContentItem(Source).UzfWaterContent;
  end;
  inherited;
end;

procedure TUzfWaterContentItem.AssignObserverEvents(Collection: TCollection);
var
  ParentCollection: TUzfWaterContentCollection;
  UzfWaterContentObserver: TObserver;
begin
  ParentCollection := Collection as TUzfWaterContentCollection;
  UzfWaterContentObserver := FObserverList[UzfWaterContentPosition];
  UzfWaterContentObserver.OnUpToDateSet := ParentCollection.InvalidateUzfWaterContentData;
end;

function TUzfWaterContentItem.BoundaryFormulaCount: integer;
begin
  result := 1;
end;

procedure TUzfWaterContentItem.CreateFormulaObjects;
begin
  FUzfWaterContent := CreateFormulaObject(dso3D);
end;

destructor TUzfWaterContentItem.Destroy;
begin
  UzfWaterContent := '0';
  inherited;
end;

function TUzfWaterContentItem.GetBoundaryFormula(Index: integer): string;
begin
  case Index of
    UzfWaterContentPosition: result := UzfWaterContent;
    else Assert(False);
  end;
end;

procedure TUzfWaterContentItem.GetPropertyObserver(Sender: TObject; List: TList);
begin
  Assert(Sender = FUzfWaterContent);
  List.Add( FObserverList[UzfWaterContentPosition]);
end;

function TUzfWaterContentItem.GetUzfWaterContent: string;
begin
  Result := FUzfWaterContent.Formula;
  ResetItemObserver(UzfWaterContentPosition);
end;

function TUzfWaterContentItem.IsSame(AnotherItem: TOrderedItem): boolean;
var
  Item: TUzfWaterContentItem;
begin
  result := (AnotherItem is TUzfWaterContentItem) and inherited IsSame(AnotherItem);
  if result then
  begin
    Item := TUzfWaterContentItem(AnotherItem);
    result := (Item.UzfWaterContent = UzfWaterContent)
  end;
end;

procedure TUzfWaterContentItem.RemoveFormulaObjects;
begin
  frmGoPhast.PhastModel.FormulaManager.Remove(FUzfWaterContent,
    GlobalRemoveModflowBoundaryItemSubscription, GlobalRestoreModflowBoundaryItemSubscription, self);
end;

procedure TUzfWaterContentItem.SetBoundaryFormula(Index: integer;
  const Value: string);
begin
  case Index of
    UzfWaterContentPosition: UzfWaterContent := Value;
    else Assert(False);
  end;
end;

procedure TUzfWaterContentItem.SetUzfWaterContent(const Value: string);
begin
  UpdateFormula(Value, UzfWaterContentPosition, FUzfWaterContent);
end;

{ TUzfExtinctionDepthCollection }

procedure TUzfExtinctionDepthCollection.AddSpecificBoundary(AModel: TBaseModel);
begin
  AddBoundary(TUzfExtinctDepthStorage.Create(AModel));
end;

procedure TUzfExtinctionDepthCollection.AssignArrayCellValues(DataSets: TList;
  ItemIndex: Integer; AModel: TBaseModel);
var
  ExtinctionDepthRateArray: TDataArray;
  Boundary: TUzfExtinctDepthStorage;
  LayerIndex: Integer;
  RowIndex: Integer;
  ColIndex: Integer;
  BoundaryIndex: Integer;
  LocalModel: TCustomModel;
  LayerMin: Integer;
  RowMin: Integer;
  ColMin: Integer;
  LayerMax: Integer;
  RowMax: Integer;
  ColMax: Integer;
begin
  LocalModel := AModel as TCustomModel;
  BoundaryIndex := 0;
  ExtinctionDepthRateArray := DataSets[UzfExtinctDepthPosition];
  Boundary := Boundaries[ItemIndex, AModel] as TUzfExtinctDepthStorage;
  ExtinctionDepthRateArray.GetMinMaxStoredLimits(LayerMin, RowMin, ColMin,
    LayerMax, RowMax, ColMax);
  if LayerMin >= 0 then
  begin
    for LayerIndex := LayerMin to LayerMax do
    begin
      if LocalModel.IsLayerSimulated(LayerIndex) then
      begin
        for RowIndex := RowMin to RowMax do
        begin
          for ColIndex := ColMin to ColMax do
          begin
            if ExtinctionDepthRateArray.IsValue[LayerIndex, RowIndex, ColIndex] then
            begin
              with Boundary.ExtinctDepthArray[BoundaryIndex] do
              begin
                Cell.Layer := LayerIndex;
                Cell.Row := RowIndex;
                Cell.Column := ColIndex;
//                Cell.Section := Sections[LayerIndex, RowIndex, ColIndex];
                ExtinctionDepth := ExtinctionDepthRateArray.
                  RealData[LayerIndex, RowIndex, ColIndex];
                ExtinctionDepthAnnotation := ExtinctionDepthRateArray.
                  Annotation[LayerIndex, RowIndex, ColIndex];
              end;
              Inc(BoundaryIndex);
            end;
          end;
        end;
      end;
    end;
  end;
  ExtinctionDepthRateArray.CacheData;
  Boundary.CacheData;
end;

function TUzfExtinctionDepthCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TUzfExtinctionDepthTimeListLink;
end;

procedure TUzfExtinctionDepthCollection.InitializeTimeLists(
  ListOfTimeLists: TList; AModel: TBaseModel);
var
  TimeIndex: Integer;
  BoundaryValues: TBoundaryValueArray;
  Index: Integer;
  Item: TUzfExtinctDepthItem;
  ScreenObject: TScreenObject;
  ALink: TUzfExtinctionDepthTimeListLink;
  FExtinctionDepthData: TModflowTimeList;
begin
  ScreenObject := BoundaryGroup.ScreenObject as TScreenObject;
  SetLength(BoundaryValues, Count);
  for Index := 0 to Count - 1 do
  begin
    Item := Items[Index] as TUzfExtinctDepthItem;
    BoundaryValues[Index].Time := Item.StartTime;
    BoundaryValues[Index].Formula := Item.UzfExtinctDepth;
  end;
  ALink := TimeListLink.GetLink(AModel) as TUzfExtinctionDepthTimeListLink;
  FExtinctionDepthData := ALink.FExtinctionDepthData;
  FExtinctionDepthData.Initialize(BoundaryValues, ScreenObject, lctUse);
  Assert(FExtinctionDepthData.Count = Count);
  ClearBoundaries(AModel);
  SetBoundaryCapacity(FExtinctionDepthData.Count, AModel);
  for TimeIndex := 0 to FExtinctionDepthData.Count - 1 do
  begin
    AddBoundary(TUzfExtinctDepthStorage.Create(AModel));
  end;
  ListOfTimeLists.Add(FExtinctionDepthData);
end;

procedure TUzfExtinctionDepthCollection.InvalidateUzfExtinctDepthData(
  Sender: TObject);
var
  PhastModel: TPhastModel;
  Link: TUzfExtinctionDepthTimeListLink;
  ChildIndex: Integer;
  ChildModel: TChildModel;
begin
  if not (Sender as TObserver).UpToDate then
  begin
    PhastModel := frmGoPhast.PhastModel;
    Link := TimeListLink.GetLink(PhastModel) as TUzfExtinctionDepthTimeListLink;
    Link.FExtinctionDepthData.Invalidate;
    for ChildIndex := 0 to PhastModel.ChildModels.Count - 1 do
    begin
      ChildModel := PhastModel.ChildModels[ChildIndex].ChildModel;
      Link := TimeListLink.GetLink(ChildModel) as TUzfExtinctionDepthTimeListLink;
      Link.FExtinctionDepthData.Invalidate;
    end;
  end;
end;

class function TUzfExtinctionDepthCollection.ItemClass: TBoundaryItemClass;
begin
  result := TUzfExtinctDepthItem
end;

procedure TUzfExtinctionDepthCollection.SetBoundaryStartAndEndTime(
  BoundaryCount: Integer; Item: TCustomModflowBoundaryItem; ItemIndex: Integer; AModel: TBaseModel);
begin
  SetLength((Boundaries[ItemIndex, AModel] as TUzfExtinctDepthStorage).
    FExtinctDepthArray, BoundaryCount);
  inherited;
end;

{ TUzfWaterContentCollection }

procedure TUzfWaterContentCollection.AddSpecificBoundary(AModel: TBaseModel);
begin
  AddBoundary(TUzfWaterContentStorage.Create(AModel));
end;

procedure TUzfWaterContentCollection.AssignArrayCellValues(DataSets: TList;
  ItemIndex: Integer; AModel: TBaseModel);
var
  WaterContentArray: TDataArray;
  Boundary: TUzfWaterContentStorage;
  LayerIndex: Integer;
  RowIndex: Integer;
  ColIndex: Integer;
  BoundaryIndex: Integer;
  LocalModel: TCustomModel;
  LayerMin: Integer;
  RowMin: Integer;
  ColMin: Integer;
  LayerMax: Integer;
  RowMax: Integer;
  ColMax: Integer;
begin
  LocalModel := AModel as TCustomModel;
  BoundaryIndex := 0;
  WaterContentArray := DataSets[UzfWaterContentPosition];
  Boundary := Boundaries[ItemIndex, AModel] as TUzfWaterContentStorage;
  WaterContentArray.GetMinMaxStoredLimits(LayerMin, RowMin, ColMin,
    LayerMax, RowMax, ColMax);
  if LayerMin >= 0 then
  begin
    for LayerIndex := LayerMin to LayerMax do
    begin
      if LocalModel.IsLayerSimulated(LayerIndex) then
      begin
        for RowIndex := RowMin to RowMax do
        begin
          for ColIndex := ColMin to ColMax do
          begin
            if WaterContentArray.IsValue[LayerIndex, RowIndex, ColIndex] then
            begin
              with Boundary.WaterContentArray[BoundaryIndex] do
              begin
                Cell.Layer := LayerIndex;
                Cell.Row := RowIndex;
                Cell.Column := ColIndex;
//                Cell.Section := Sections[LayerIndex, RowIndex, ColIndex];
                MinimumWaterContent := WaterContentArray.
                  RealData[LayerIndex, RowIndex, ColIndex];
                MinimumWaterContentAnnotation := WaterContentArray.
                  Annotation[LayerIndex, RowIndex, ColIndex];
              end;
              Inc(BoundaryIndex);
            end;
          end;
        end;
      end;
    end;
  end;
  WaterContentArray.CacheData;
  Boundary.CacheData;
end;

function TUzfWaterContentCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TUzfWaterContentTimeListLink;
end;

procedure TUzfWaterContentCollection.InitializeTimeLists(
  ListOfTimeLists: TList; AModel: TBaseModel);
var
  TimeIndex: Integer;
  BoundaryValues: TBoundaryValueArray;
  Index: Integer;
  Item: TUzfWaterContentItem;
  ScreenObject: TScreenObject;
  ALink: TUzfWaterContentTimeListLink;
  WaterContentData: TModflowTimeList;
begin
  ScreenObject := BoundaryGroup.ScreenObject as TScreenObject;
  SetLength(BoundaryValues, Count);
  for Index := 0 to Count - 1 do
  begin
    Item := Items[Index] as TUzfWaterContentItem;
    BoundaryValues[Index].Time := Item.StartTime;
    BoundaryValues[Index].Formula := Item.UzfWaterContent;
  end;
  ALink := TimeListLink.GetLink(AModel) as TUzfWaterContentTimeListLink;
  WaterContentData := ALink.FWaterContentData;
  WaterContentData.Initialize(BoundaryValues, ScreenObject, lctUse);
  Assert(WaterContentData.Count = Count);
  ClearBoundaries(AModel);
  SetBoundaryCapacity(WaterContentData.Count, AModel);
  for TimeIndex := 0 to WaterContentData.Count - 1 do
  begin
    AddBoundary(TUzfWaterContentStorage.Create(AModel));
  end;
  ListOfTimeLists.Add(WaterContentData);
end;

procedure TUzfWaterContentCollection.InvalidateUzfWaterContentData(
  Sender: TObject);
var
  PhastModel: TPhastModel;
  Link: TUzfWaterContentTimeListLink;
  ChildIndex: Integer;
  ChildModel: TChildModel;
begin
  if not (Sender as TObserver).UpToDate then
  begin
    PhastModel := frmGoPhast.PhastModel;
    Link := TimeListLink.GetLink(PhastModel) as TUzfWaterContentTimeListLink;
    Link.FWaterContentData.Invalidate;
    for ChildIndex := 0 to PhastModel.ChildModels.Count - 1 do
    begin
      ChildModel := PhastModel.ChildModels[ChildIndex].ChildModel;
      Link := TimeListLink.GetLink(ChildModel) as TUzfWaterContentTimeListLink;
      Link.FWaterContentData.Invalidate;
    end;
  end;
end;

class function TUzfWaterContentCollection.ItemClass: TBoundaryItemClass;
begin
  result := TUzfWaterContentItem;
end;

procedure TUzfWaterContentCollection.SetBoundaryStartAndEndTime(
  BoundaryCount: Integer; Item: TCustomModflowBoundaryItem; ItemIndex: Integer; AModel: TBaseModel);
begin
  SetLength((Boundaries[ItemIndex, AModel] as TUzfWaterContentStorage).
    FWaterContentArray, BoundaryCount);
  inherited;
end;

{ TUzfExtinctionDepthCell }

procedure TUzfExtinctionDepthCell.Cache(Comp: TCompressionStream; Strings: TStringList);
begin
  inherited;
  Values.Cache(Comp, Strings);
  WriteCompInt(Comp, StressPeriod);
end;

function TUzfExtinctionDepthCell.GetColumn: integer;
begin
  result := Values.Cell.Column;
end;

function TUzfExtinctionDepthCell.GetExtinctionDepth: double;
begin
  result := Values.ExtinctionDepth;
end;

function TUzfExtinctionDepthCell.GetExtinctionDepthAnnotation: string;
begin
  result := Values.ExtinctionDepthAnnotation;
end;

function TUzfExtinctionDepthCell.GetIntegerAnnotation(Index: integer; AModel: TBaseModel): string;
begin
  result := '';
  Assert(False);
end;

function TUzfExtinctionDepthCell.GetIntegerValue(Index: integer; AModel: TBaseModel): integer;
begin
  result := 0;
  Assert(False);
end;

function TUzfExtinctionDepthCell.GetLayer: integer;
begin
  result := Values.Cell.Layer;
end;

function TUzfExtinctionDepthCell.GetRealAnnotation(Index: integer; AModel: TBaseModel): string;
begin
  result := '';
  case Index of
    UzfExtinctDepthPosition: result := ExtinctionDepthAnnotation;
    else Assert(False);
  end;
end;

function TUzfExtinctionDepthCell.GetRealValue(Index: integer; AModel: TBaseModel): double;
begin
  result := 0;
  case Index of
    UzfExtinctDepthPosition: result := ExtinctionDepth;
    else Assert(False);
  end;
end;

function TUzfExtinctionDepthCell.GetRow: integer;
begin
  result := Values.Cell.Row;
end;

function TUzfExtinctionDepthCell.GetSection: integer;
begin
  result := Values.Cell.Section;
end;

procedure TUzfExtinctionDepthCell.RecordStrings(Strings: TStringList);
begin
  inherited;
  Values.RecordStrings(Strings);
end;

procedure TUzfExtinctionDepthCell.Restore(Decomp: TDecompressionStream; Annotations: TStringList);
begin
  inherited;
  Values.Restore(Decomp, Annotations);
  StressPeriod := ReadCompInt(Decomp);
end;

procedure TUzfExtinctionDepthCell.SetColumn(const Value: integer);
begin
  FValues.Cell.Column := Value;
end;

procedure TUzfExtinctionDepthCell.SetLayer(const Value: integer);
begin
  FValues.Cell.Layer := Value;
end;

procedure TUzfExtinctionDepthCell.SetRow(const Value: integer);
begin
  FValues.Cell.Row := Value;
end;

{ TUzfWaterContentCell }

procedure TUzfWaterContentCell.Cache(Comp: TCompressionStream; Strings: TStringList);
begin
  inherited;
  Values.Cache(Comp, Strings);
  WriteCompInt(Comp, StressPeriod);
end;

function TUzfWaterContentCell.GetColumn: integer;
begin
  result := Values.Cell.Column;
end;

function TUzfWaterContentCell.GetIntegerAnnotation(Index: integer; AModel: TBaseModel): string;
begin
  result := '';
  Assert(False);
end;

function TUzfWaterContentCell.GetIntegerValue(Index: integer; AModel: TBaseModel): integer;
begin
  result := 0;
  Assert(False);
end;

function TUzfWaterContentCell.GetLayer: integer;
begin
  result := Values.Cell.Layer;
end;

function TUzfWaterContentCell.GetRealAnnotation(Index: integer; AModel: TBaseModel): string;
begin
  result := '';
  case Index of
    UzfWaterContentPosition: result := WaterContentAnnotation;
    else Assert(False);
  end;
end;

function TUzfWaterContentCell.GetRealValue(Index: integer; AModel: TBaseModel): double;
begin
  result := 0;
  case Index of
    UzfWaterContentPosition: result := WaterContent;
    else Assert(False);
  end;
end;

function TUzfWaterContentCell.GetRow: integer;
begin
  result := Values.Cell.Row;
end;

function TUzfWaterContentCell.GetSection: integer;
begin
  result := Values.Cell.Section;
end;

function TUzfWaterContentCell.GetWaterContent: double;
begin
  result := Values.MinimumWaterContent;
end;

function TUzfWaterContentCell.GetWaterContentAnnotation: string;
begin
  result := Values.MinimumWaterContentAnnotation;
end;

procedure TUzfWaterContentCell.RecordStrings(Strings: TStringList);
begin
  inherited;
  Values.RecordStrings(Strings);
end;

procedure TUzfWaterContentCell.Restore(Decomp: TDecompressionStream; Annotations: TStringList);
begin
  inherited;
  Values.Restore(Decomp, Annotations);
  StressPeriod := ReadCompInt(Decomp);
end;

procedure TUzfWaterContentCell.SetColumn(const Value: integer);
begin
  FValues.Cell.Column := Value;
end;

procedure TUzfWaterContentCell.SetLayer(const Value: integer);
begin
  FValues.Cell.Layer := Value;
end;

procedure TUzfWaterContentCell.SetRow(const Value: integer);
begin
  FValues.Cell.Row := Value;
end;

{ TUzfExtinctionDepthRecord }

procedure TUzfExtinctionDepthRecord.Cache(Comp: TCompressionStream; Strings: TStringList);
begin
  WriteCompCell(Comp, Cell);
  WriteCompReal(Comp, ExtinctionDepth);
  WriteCompReal(Comp, StartingTime);
  WriteCompReal(Comp, EndingTime);
  WriteCompInt(Comp, Strings.IndexOf(ExtinctionDepthAnnotation));
//  WriteCompString(Comp, ExtinctionDepthAnnotation);
end;

procedure TUzfExtinctionDepthRecord.RecordStrings(Strings: TStringList);
begin
  Strings.Add(ExtinctionDepthAnnotation);
end;

procedure TUzfExtinctionDepthRecord.Restore(Decomp: TDecompressionStream; Annotations: TStringList);
begin
  Cell := ReadCompCell(Decomp);
  ExtinctionDepth := ReadCompReal(Decomp);
  StartingTime := ReadCompReal(Decomp);
  EndingTime := ReadCompReal(Decomp);
  ExtinctionDepthAnnotation := Annotations[ReadCompInt(Decomp)];
//  ExtinctionDepthAnnotation := ReadCompString(Decomp, Annotations);
end;

{ TUzfWaterContentRecord }

procedure TUzfWaterContentRecord.Cache(Comp: TCompressionStream; Strings: TStringList);
begin
  WriteCompCell(Comp, Cell);
  WriteCompReal(Comp, MinimumWaterContent);
  WriteCompReal(Comp, StartingTime);
  WriteCompReal(Comp, EndingTime);
  WriteCompInt(Comp, Strings.IndexOf(MinimumWaterContentAnnotation));
//  WriteCompString(Comp, MinimumWaterContentAnnotation);
end;

procedure TUzfWaterContentRecord.RecordStrings(Strings: TStringList);
begin
  Strings.Add(MinimumWaterContentAnnotation);
end;

procedure TUzfWaterContentRecord.Restore(Decomp: TDecompressionStream; Annotations: TStringList);
begin
  Cell := ReadCompCell(Decomp);
  MinimumWaterContent := ReadCompReal(Decomp);
  StartingTime := ReadCompReal(Decomp);
  EndingTime := ReadCompReal(Decomp);
  MinimumWaterContentAnnotation := Annotations[ReadCompInt(Decomp)];
//  MinimumWaterContentAnnotation := ReadCompString(Decomp, Annotations);
end;

{ TUzfExtinctDepthStorage }

procedure TUzfExtinctDepthStorage.Clear;
begin
  SetLength(FExtinctDepthArray, 0);
  FCleared := True;
end;

procedure TUzfExtinctDepthStorage.Store(Compressor: TCompressionStream);
var
  Index: Integer;
  Count: Integer;
  Strings: TStringList;
begin

  Strings := TStringList.Create;
  try
    Strings.Sorted := true;
    Strings.Duplicates := dupIgnore;
    Count := Length(FExtinctDepthArray);
    for Index := 0 to Count - 1 do
    begin
      FExtinctDepthArray[Index].RecordStrings(Strings);
    end;
    WriteCompInt(Compressor, Strings.Count);

    for Index := 0 to Strings.Count - 1 do
    begin
      WriteCompString(Compressor, Strings[Index]);
    end;

    Compressor.Write(Count, SizeOf(Count));
    for Index := 0 to Count - 1 do
    begin
      FExtinctDepthArray[Index].Cache(Compressor, Strings);
    end;
  finally
    Strings.Free;
  end;
end;

procedure TUzfExtinctDepthStorage.Restore(DecompressionStream: TDecompressionStream; Annotations: TStringList);
var
  Index: Integer;
  Count: Integer;
begin
  DecompressionStream.Read(Count, SizeOf(Count));
  SetLength(FExtinctDepthArray, Count);
  for Index := 0 to Count - 1 do
  begin
    FExtinctDepthArray[Index].Restore(DecompressionStream, Annotations);
  end;
end;

function TUzfExtinctDepthStorage.GetExtinctDepthArray: TUzfExtinctDepthArray;
begin
  if FCached and FCleared then
  begin
    RestoreData;
  end;
  result := FExtinctDepthArray;
end;

{ TUzfWaterContentStorage }

procedure TUzfWaterContentStorage.Clear;
begin
  SetLength(FWaterContentArray, 0);
  FCleared := True;
end;

procedure TUzfWaterContentStorage.Store(Compressor: TCompressionStream);
var
  Index: Integer;
  Count: Integer;
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    Strings.Sorted := true;
    Strings.Duplicates := dupIgnore;
    Count := Length(FWaterContentArray);
    for Index := 0 to Count - 1 do
    begin
      FWaterContentArray[Index].RecordStrings(Strings);
    end;
    WriteCompInt(Compressor, Strings.Count);

    for Index := 0 to Strings.Count - 1 do
    begin
      WriteCompString(Compressor, Strings[Index]);
    end;

    Compressor.Write(Count, SizeOf(Count));
    for Index := 0 to Count - 1 do
    begin
      FWaterContentArray[Index].Cache(Compressor, Strings);
    end;
  finally
    Strings.Free;
  end;
end;

procedure TUzfWaterContentStorage.Restore(DecompressionStream: TDecompressionStream; Annotations: TStringList);
var
  Index: Integer;
  Count: Integer;
begin
  DecompressionStream.Read(Count, SizeOf(Count));
  SetLength(FWaterContentArray, Count);
  for Index := 0 to Count - 1 do
  begin
    FWaterContentArray[Index].Restore(DecompressionStream, Annotations);
  end;
end;

function TUzfWaterContentStorage.GetWaterContentArray: TUzfWaterContentArray;
begin
  if FCached and FCleared then
  begin
    RestoreData;
  end;
  result := FWaterContentArray;
end;

{ TUzfEvtTimeListLink }

procedure TUzfEvtTimeListLink.CreateTimeLists;
begin
  inherited;
  EvapotranspirationRateData.NonParamDescription :=
    StrEvapoTranspiration;
  if Model <> nil then
  begin
    EvapotranspirationRateData.OnInvalidate :=
      (Model as TCustomModel).InvalidateMfUzfEtDemand;
  end;
end;

{ TUzfExtinctionDepthTimeListLink }

procedure TUzfExtinctionDepthTimeListLink.CreateTimeLists;
begin
  inherited;
  FExtinctionDepthData := TModflowTimeList.Create(Model, Boundary.ScreenObject);
  FExtinctionDepthData.NonParamDescription := StrETExtinctionDepth;
  FExtinctionDepthData.ParamDescription := ' ' + StrETExtinctionDepth;
  AddTimeList(FExtinctionDepthData);
  if Model <> nil then
  begin
    FExtinctionDepthData.OnInvalidate := (Model as TCustomModel).InvalidateMfUzfExtinctionDepth;
  end;
end;

destructor TUzfExtinctionDepthTimeListLink.Destroy;
begin
  FExtinctionDepthData.Free;
  inherited;
end;

{ TUzfWaterContentTimeListLink }

procedure TUzfWaterContentTimeListLink.CreateTimeLists;
begin
  inherited;
  FWaterContentData := TModflowTimeList.Create(Model, Boundary.ScreenObject);
  FWaterContentData.NonParamDescription := StrETExtinctionWater;
  FWaterContentData.ParamDescription := ' ' + StrETExtinctionWater;
  AddTimeList(FWaterContentData);
  if Model <> nil then
  begin
    FWaterContentData.OnInvalidate := (Model as TCustomModel).InvalidateMfUzfWaterContent;
  end;
end;

destructor TUzfWaterContentTimeListLink.Destroy;
begin
  FWaterContentData.Free;
  inherited;
end;

{ TUzfInfiltrationRateTimeListLink }

procedure TUzfInfiltrationRateTimeListLink.CreateTimeLists;
begin
  inherited;
  RechargeRateData.NonParamDescription := StrInfiltrationRate;
  if Model <> nil then
  begin
    RechargeRateData.OnInvalidate := (Model as TCustomModel).InvalidateMfUzfInfiltration;
  end;
end;

function TUzfInfiltrationRateCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TUzfInfiltrationRateTimeListLink;
end;

function TUzfInfiltrationRateCollection.PackageAssignmentMethod(
  AModel: TBaseModel): TUpdateMethod;
var
  LocalModel: TCustomModel;
begin
  LocalModel := AModel as TCustomModel;
  result := LocalModel.ModflowPackages.UzfPackage.AssignmentMethod;
end;

end.

