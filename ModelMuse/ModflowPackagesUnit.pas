unit ModflowPackagesUnit;

interface

Uses Classes, ModflowPackageSelectionUnit, GoPhastTypes;

type
  TModflowPackages = class(TPersistent)
  private
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    FModel: TBaseModel;
    FChdBoundary: TChdPackage;
    FLpfPackage: TLpfSelection;
    FPcgPackage: TPcgSelection;
    FGhbBoundary: TGhbPackage;
    FWelPackage: TWellPackage;
    FRivPackage: TRivPackage;
    FDrnPackage: TDrnPackage;
    FDrtPackage: TDrtPackage;
    FRchPackage: TRchPackageSelection;
    FEvtPackage: TEvtPackageSelection;
    FEtsPackage: TEtsPackageSelection;
    FResPackage: TResPackageSelection;
    FLakPackage: TLakePackageSelection;
    FSfrPackage: TSfrPackageSelection;
    FUzfPackage: TUzfPackageSelection;
    FGmgPackage: TGmgPackageSelection;
    FSipPackage: TSIPPackageSelection;
    FDe4Package: TDE4PackageSelection;
    FHobPackage: THobPackageSelection;
    FHfbPackage: TModflowPackageSelection;
    FModPath: TModpathSelection;
    FChobPackage: TModflowPackageSelection;
    FRvobPackage: TModflowPackageSelection;
    FGbobPackage: TModflowPackageSelection;
    FDrobPackage: TModflowPackageSelection;
    FHufPackage: THufPackageSelection;
    FMnw2Package: TMultinodeWellSelection;
    FBcfPackage: TModflowPackageSelection;
    FSubPackage: TSubPackageSelection;
    FZoneBudget: TZoneBudgetSelect;
    FSwtPackage: TSwtPackageSelection;
    FHydmodPackage: THydPackageSelection;
    FUpwPackage: TUpwPackageSelection;
    FNwtPackage: TNwtPackageSelection;
    FMt3dBasic: TMt3dBasic;
    FMt3dmsGCGSolver: TMt3dmsGCGSolverPackage;
    FMt3dmsAdvection: TMt3dmsAdvection;
    FMt3dmsDispersion: TMt3dmsDispersion;
    FMt3dmsSourceSink: TMt3dmsSourceSinkMixing;
    FMt3dmsChemReaction: TMt3dmsChemReaction;
    FMt3dmsTransObs: TMt3dmsTransportObservations;
    FPcgnPackage: TPcgnSelection;
    FStrPackage: TStrPackageSelection;
    FStobPackage: TModflowPackageSelection;
    FFhbPackage: TFhbPackageSelection;
    FFarmProcess: TFarmProcess;
    FConduitFlowProcess: TConduitFlowProcess;
    FSwiPackage: TSwiPackage;
    FSwrPackage: TSwrPackage;
    FMnw1Package: TMnw1Package;
    FNpfPackage: TNpfPackage;
    FStoPackage: TStoPackage;
    FSmsPackage: TSmsPackageSelection;
    FRipPackage: TRipPackage;
    procedure SetChdBoundary(const Value: TChdPackage);
    procedure SetLpfPackage(const Value: TLpfSelection);
    procedure SetPcgPackage(const Value: TPcgSelection);
    procedure SetGhbBoundary(const Value: TGhbPackage);
    procedure SetWelPackage(const Value: TWellPackage);
    procedure SetRivPackage(const Value: TRivPackage);
    procedure SetDrnPackage(const Value: TDrnPackage);
    procedure SetDrtPackage(const Value: TDrtPackage);
    procedure SetRchPackage(const Value: TRchPackageSelection);
    procedure SetEvtPackage(const Value: TEvtPackageSelection);
    procedure SetEtsPackage(const Value: TEtsPackageSelection);
    procedure SetResPackage(const Value: TResPackageSelection);
    procedure SetLakPackage(const Value: TLakePackageSelection);
    procedure SetSfrPackage(const Value: TSfrPackageSelection);
    procedure SetUzfPackage(const Value: TUzfPackageSelection);
    procedure SetGmgPackage(const Value: TGmgPackageSelection);
    procedure SetSipPackage(const Value: TSIPPackageSelection);
    procedure SetDe4Package(const Value: TDE4PackageSelection);
    procedure SetHobPackage(const Value: THobPackageSelection);
    procedure SetHfbPackage(const Value: TModflowPackageSelection);
    procedure SetModPath(const Value: TModpathSelection);
    procedure SetChobPackage(const Value: TModflowPackageSelection);
    procedure SetDrobPackage(const Value: TModflowPackageSelection);
    procedure SetGbobPackage(const Value: TModflowPackageSelection);
    procedure SetRvobPackage(const Value: TModflowPackageSelection);
    procedure SetHufPackage(const Value: THufPackageSelection);
    procedure SetMnw2Package(const Value: TMultinodeWellSelection);
    procedure SetBcfPackage(const Value: TModflowPackageSelection);
    procedure SetSubPackage(const Value: TSubPackageSelection);
    procedure SetZoneBudget(const Value: TZoneBudgetSelect);
    procedure SetSwtPackage(const Value: TSwtPackageSelection);
    procedure SetHydmodPackage(const Value: THydPackageSelection);
    procedure SetUpwPackage(const Value: TUpwPackageSelection);
    procedure SetNwtPackage(const Value: TNwtPackageSelection);
    procedure SetMt3dBasic(const Value: TMt3dBasic);
    procedure SetMt3dmsGCGSolver(const Value: TMt3dmsGCGSolverPackage);
    procedure SetMt3dmsAdvection(const Value: TMt3dmsAdvection);
    procedure SetMt3dmsDispersion(const Value: TMt3dmsDispersion);
    procedure SetMt3dmsSourceSink(const Value: TMt3dmsSourceSinkMixing);
    procedure SetMt3dmsChemReaction(const Value: TMt3dmsChemReaction);
    procedure SetMt3dmsTransObs(const Value: TMt3dmsTransportObservations);
    procedure SetPcgnPackage(const Value: TPcgnSelection);
    procedure SetStrPackage(const Value: TStrPackageSelection);
    procedure SetStobPackage(const Value: TModflowPackageSelection);
    procedure SetFhbPackage(const Value: TFhbPackageSelection);
    procedure SetFarmProcess(const Value: TFarmProcess);
    procedure SetConduitFlowProcess(const Value: TConduitFlowProcess);
    procedure SetSwiPackage(const Value: TSwiPackage);
    procedure SetSwrPackage(const Value: TSwrPackage);
    procedure SetMnw1Package(const Value: TMnw1Package);
    procedure SetNpfPackage(const Value: TNpfPackage);
    procedure SetStoPackage(const Value: TStoPackage);
    procedure SetSmsPackage(const Value: TSmsPackageSelection);
    procedure SetRipPackage(const Value: TRipPackage);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    property Model: TBaseModel read FModel;
    procedure Reset;
    // @name is used to set the progress bar limits when exporting
    // the MODFLOW input files.
    function SelectedModflowPackageCount: integer;
  published
    property ChdBoundary: TChdPackage read FChdBoundary write SetChdBoundary;
    property GhbBoundary: TGhbPackage read FGhbBoundary write SetGhbBoundary;
    property LpfPackage: TLpfSelection read FLpfPackage write SetLpfPackage;
    property PcgPackage: TPcgSelection read FPcgPackage write SetPcgPackage;
    property PcgnPackage: TPcgnSelection read FPcgnPackage write SetPcgnPackage;
    property WelPackage: TWellPackage read FWelPackage write SetWelPackage;
    property RivPackage: TRivPackage read FRivPackage write SetRivPackage;
    property DrnPackage: TDrnPackage read FDrnPackage write SetDrnPackage;
    property DrtPackage: TDrtPackage read FDrtPackage write SetDrtPackage;
    property RchPackage: TRchPackageSelection
      read FRchPackage write SetRchPackage;
    property EvtPackage: TEvtPackageSelection
      read FEvtPackage write SetEvtPackage;
    property EtsPackage: TEtsPackageSelection
      read FEtsPackage write SetEtsPackage;
    property ResPackage: TResPackageSelection
      read FResPackage write SetResPackage;
    property LakPackage: TLakePackageSelection
      read FLakPackage write SetLakPackage;
    property SfrPackage: TSfrPackageSelection
      read FSfrPackage write SetSfrPackage;
    property UzfPackage: TUzfPackageSelection
      read FUzfPackage write SetUzfPackage;
    property GmgPackage: TGmgPackageSelection
      read FGmgPackage write SetGmgPackage;
    property SipPackage: TSIPPackageSelection
      read FSipPackage write SetSipPackage;
    property De4Package: TDE4PackageSelection
      read FDe4Package write SetDe4Package;
    property HobPackage: THobPackageSelection
      read FHobPackage write SetHobPackage;
    property HfbPackage: TModflowPackageSelection
      read FHfbPackage write SetHfbPackage;
    property ModPath: TModpathSelection read FModPath write SetModPath;
    property ChobPackage: TModflowPackageSelection
      read FChobPackage write SetChobPackage;
    property DrobPackage: TModflowPackageSelection
      read FDrobPackage write SetDrobPackage;
    property GbobPackage: TModflowPackageSelection
      read FGbobPackage write SetGbobPackage;
    property RvobPackage: TModflowPackageSelection
      read FRvobPackage write SetRvobPackage;
    property StobPackage: TModflowPackageSelection
      read FStobPackage write SetStobPackage;
    property HufPackage: THufPackageSelection
      read FHufPackage write SetHufPackage;
    property Mnw2Package: TMultinodeWellSelection
      read FMnw2Package write SetMnw2Package;
    property BcfPackage: TModflowPackageSelection
      read FBcfPackage write SetBcfPackage;
    property SubPackage: TSubPackageSelection
      read FSubPackage write SetSubPackage;
    property ZoneBudget: TZoneBudgetSelect
      read FZoneBudget write SetZoneBudget;
    property SwtPackage: TSwtPackageSelection
      read FSwtPackage write SetSwtPackage;
    property HydmodPackage: THydPackageSelection
      read FHydmodPackage write SetHydmodPackage;
    property UpwPackage: TUpwPackageSelection
      read FUpwPackage write SetUpwPackage;
    property NwtPackage: TNwtPackageSelection
      read FNwtPackage write SetNwtPackage;
    property Mt3dBasic: TMt3dBasic read FMt3dBasic write SetMt3dBasic;
    property Mt3dmsGCGSolver: TMt3dmsGCGSolverPackage read FMt3dmsGCGSolver
      write SetMt3dmsGCGSolver;
    property Mt3dmsAdvection: TMt3dmsAdvection read FMt3dmsAdvection
      write SetMt3dmsAdvection;
    property Mt3dmsDispersion: TMt3dmsDispersion read FMt3dmsDispersion
      write SetMt3dmsDispersion;
    property Mt3dmsSourceSink: TMt3dmsSourceSinkMixing read FMt3dmsSourceSink
      write SetMt3dmsSourceSink;
    property Mt3dmsChemReact: TMt3dmsChemReaction read FMt3dmsChemReaction
      write SetMt3dmsChemReaction;
    property Mt3dmsTransObs: TMt3dmsTransportObservations read FMt3dmsTransObs
      write SetMt3dmsTransObs;
    property StrPackage: TStrPackageSelection read FStrPackage
      write SetStrPackage;
    property FhbPackage: TFhbPackageSelection read FFhbPackage
      write SetFhbPackage;
    property FarmProcess: TFarmProcess read FFarmProcess write SetFarmProcess;
    property ConduitFlowProcess: TConduitFlowProcess read FConduitFlowProcess
      write SetConduitFlowProcess;
    property SwiPackage: TSwiPackage read FSwiPackage write SetSwiPackage;
    property SwrPackage: TSwrPackage read FSwrPackage write SetSwrPackage;
    property Mnw1Package: TMnw1Package read FMnw1Package write SetMnw1Package;
    property NpfPackage: TNpfPackage read FNpfPackage write SetNpfPackage {$IFNDEF MF2015} stored False {$ENDIF};
    property StoPackage: TStoPackage read FStoPackage write SetStoPackage {$IFNDEF MF2015} stored False {$ENDIF};
    property SmsPackage: TSmsPackageSelection read FSmsPackage
      write SetSmsPackage {$IFNDEF MF2015} stored False {$ENDIF};
    property RipPackage: TRipPackage read FRipPackage
      write SetRipPackage;
    // Assign, Create, Destroy, SelectedModflowPackageCount
    // and Reset must be updated each time a new package is added.
  end;

resourcestring
  StrBoundaryCondition = 'Boundary conditions';
  StrSpecifiedHeadPackages = 'Specified head';
  StrLPF_Identifier = 'LPF: Layer Property Flow package';
  StrSFR_Identifier = 'SFR: Stream-Flow Routing package';
  StrUPW_Identifier = 'UPW: Upstream Weighting package';
  StrFlow = 'Flow';
  StrSpecifiedFlux = 'Specified flux';
  StrHeaddependentFlux = 'Head-dependent flux';
  StrSolver = 'Solvers';
  StrObservations = 'Observations';
  StrPostProcessors = 'Post processors';
  StrSubsidence = 'Subsidence';
  StrSurfaceWaterRoutin = 'Surface-Water Routing';

  function BC_SpecHead: string;
  function BC_SpecifiedFlux: string;
  function BC_HeadDependentFlux: string;

implementation

uses
  frmGoPhastUnit, PhastModelUnit, OrderedCollectionUnit;

resourcestring
  StrHUF_Identifier = 'HUF2: Hydrogeologic Unit Flow package';
  StrOutput = 'Output';
  StrCHDTimeVariantSp = 'CHD: Time-Variant Specified-Head package';
  StrFHBPackage = 'FHB: Flow and Head Boundary package';
  StrPCGPreconditioned = 'PCG: Preconditioned Conjugate Gradient package';
  StrGHBGeneralHeadBo = 'GHB: General-Head Boundary package';
  StrWELWellPackage = 'WEL: Well package';
  StrRIVRiverPackage = 'RIV: River package';
  StrDRNDrainPackage = 'DRN: Drain package';
  StrDRTDrainReturnPa = 'DRT: Drain Return package';
  StrRCHRechargePackag = 'RCH: Recharge package';
  StrEVTEvapotranspirat = 'EVT: Evapotranspiration package';
  StrETSEvapotranspirat = 'ETS: Evapotranspiration Segments package';
  StrRESReservoirPacka = 'RES: Reservoir package';
  StrLAKLakePackage = 'LAK: Lake package';
  StrUZFUnsaturatedZon = 'UZF: Unsaturated-Zone Flow package';
  StrGMGGeometricMulti = 'GMG: Geometric Multigrid package';
  StrSIPStronglyImplic = 'SIP: Strongly Implicit Procedure package';
  StrDE4DirectSolverP = 'DE4: Direct Solver package';
  StrHOBHeadObservatio = 'HOB: Head Observation package';
  StrHFBHorizontalFlow = 'HFB: Horizontal Flow Barrier package';
  StrMODPATH = 'MODPATH';
  StrCHOBSpecifiedHead = 'CHOB: Specified-Head Flow Observation package';
  StrDROBDrainObservat = 'DROB: Drain Observation package';
  StrGBOBGeneralHeadB = 'GBOB: General-Head-Boundary Observation package';
  StrRVOBRiverObservat = 'RVOB: River Observation package';
  StrMNW2MultiNodeWel = 'MNW2: Multi-Node Well package';
  StrBCF6BlockCentered = 'BCF6: Block-Centered Flow package';
  StrSUBSubsidenceAnd = 'SUB: Subsidence and Aquifer-System Compaction Packa' +
  'ge';
  StrSWTSubsidenceAnd = 'SWT: Subsidence and Aquifer-System Compaction Packa' +
  'ge for Water-Table Aquifers';
  StrZONEBUDGET = 'ZONEBUDGET';
  StrHYDHYDMODPackage = 'HYD: HYDMOD package';
  StrNWTNewtonSolver = 'NWT: Newton Solver';
  StrBTNMT3DMSBasicTr = 'BTN: Basic Transport package';
  StrGCGGeneralizedCon = 'GCG: Generalized Conjugate Gradient Solver';
  StrADVAdvectionPacka = 'ADV: Advection package';
  StrDSPDispersionPack = 'DSP: Dispersion package';
  StrSSMSinkSourceM = 'SSM: Sink and Source Mixing package';
  StrRCTChemicalReacti = 'RCT: Chemical Reactions package';
  StrTOBTransportObser = 'TOB: Transport Observation package';
  StrPCGNPreconditioned = 'PCGN: Preconditioned Conjugate Gradient Solver wi' +
  'th Improved Nonlinear Control';
  StrSTRStreamPackage = 'STR: Stream package';
  StrSTOBStreamObserva = 'STOB: Stream Observation package';
  StrFarmProcess = 'FMP: Farm Process';
  StrFarmProcessClassification = 'Farm process';
  StrCFPConduitFlowPr = 'CFP: Conduit Flow process';
  StrConduitFlowProcess = 'Conduit Flow process';
  StrSWI2SeawaterIntru = 'SWI2: Seawater Intrusion package';
  StrSurfaceWaterRoutin2 = 'SWR: Surface-Water Routing process';
  StrMNW1MultiNodeWel = 'MNW1: Multi-Node Well package';
  StrNPFNodePropertyF = 'NPF: Node Property Flow package';
  StrSTOStoragePackage = 'STO: Storage package';
  StrSMSSparseMatrixS = 'SMS: Sparse Matrix Solution';
  StrRIPRiparianEvapot = 'RIP: Riparian Evapotranspiration Package';


{ TModflowPackages }

procedure TModflowPackages.Assign(Source: TPersistent);
var
  SourcePackages: TModflowPackages;
begin
  if Source is TModflowPackages then
  begin
    SourcePackages := TModflowPackages(Source);
    ChdBoundary := SourcePackages.ChdBoundary;
    LpfPackage := SourcePackages.LpfPackage;
    PcgPackage := SourcePackages.PcgPackage;
    PcgnPackage := SourcePackages.PcgnPackage;
    GhbBoundary := SourcePackages.GhbBoundary;
    WelPackage := SourcePackages.WelPackage;
    RivPackage := SourcePackages.RivPackage;
    DrnPackage := SourcePackages.DrnPackage;
    DrtPackage := SourcePackages.DrtPackage;
    RchPackage := SourcePackages.RchPackage;
    EvtPackage := SourcePackages.EvtPackage;
    EtsPackage := SourcePackages.EtsPackage;
    ResPackage := SourcePackages.ResPackage;
    LakPackage := SourcePackages.LakPackage;
    SfrPackage := SourcePackages.SfrPackage;
    StrPackage := SourcePackages.StrPackage;
    UzfPackage := SourcePackages.UzfPackage;
    GmgPackage := SourcePackages.GmgPackage;
    SipPackage := SourcePackages.SipPackage;
    De4Package := SourcePackages.De4Package;
    HobPackage := SourcePackages.HobPackage;
    HfbPackage := SourcePackages.HfbPackage;
    Modpath    := SourcePackages.Modpath;
    ChobPackage := SourcePackages.ChobPackage;
    DrobPackage := SourcePackages.DrobPackage;
    GbobPackage := SourcePackages.GbobPackage;
    RvobPackage := SourcePackages.RvobPackage;
    StobPackage := SourcePackages.StobPackage;
    HufPackage := SourcePackages.HufPackage;
    Mnw2Package := SourcePackages.Mnw2Package;
    BcfPackage := SourcePackages.BcfPackage;
    SubPackage := SourcePackages.SubPackage;
    ZoneBudget := SourcePackages.ZoneBudget;
    SwtPackage := SourcePackages.SwtPackage;
    HydmodPackage := SourcePackages.HydmodPackage;
    UpwPackage := SourcePackages.UpwPackage;
    NwtPackage := SourcePackages.NwtPackage;
    Mt3dBasic := SourcePackages.Mt3dBasic;
    Mt3dmsGCGSolver := SourcePackages.Mt3dmsGCGSolver;
    Mt3dmsAdvection := SourcePackages.Mt3dmsAdvection;
    Mt3dmsDispersion := SourcePackages.Mt3dmsDispersion;
    Mt3dmsSourceSink := SourcePackages.Mt3dmsSourceSink;
    Mt3dmsChemReact := SourcePackages.Mt3dmsChemReact;
    Mt3dmsTransObs := SourcePackages.Mt3dmsTransObs;
    FhbPackage := SourcePackages.FhbPackage;
    FarmProcess := SourcePackages.FarmProcess;
    ConduitFlowProcess := SourcePackages.ConduitFlowProcess;
    SwiPackage := SourcePackages.SwiPackage;
    SwrPackage := SourcePackages.SwrPackage;
    Mnw1Package := SourcePackages.Mnw1Package;
    NpfPackage := SourcePackages.NpfPackage;
    StoPackage := SourcePackages.StoPackage;
    SmsPackage := SourcePackages.SmsPackage;
    RipPackage := SourcePackages.RipPackage;
  end
  else
  begin
    inherited;
  end;
end;

constructor TModflowPackages.Create(Model: TBaseModel);
begin
  inherited Create;
  FModel := Model;

  FChdBoundary := TChdPackage.Create(Model);
  FChdBoundary.PackageIdentifier := StrCHDTimeVariantSp;
  FChdBoundary.Classification := BC_SpecHead;

  FLpfPackage := TLpfSelection.Create(Model);
  FLpfPackage.PackageIdentifier := StrLPF_Identifier;
  FLpfPackage.Classification := StrFlow;
  FLpfPackage.SelectionType := stRadioButton;

  FHufPackage := THufPackageSelection.Create(Model);
  FHufPackage.PackageIdentifier := StrHUF_Identifier;
  FHufPackage.Classification := StrFlow;
  FHufPackage.SelectionType := stRadioButton;

  FPcgPackage := TPcgSelection.Create(Model);
  FPcgPackage.PackageIdentifier :=
    StrPCGPreconditioned;
  FPcgPackage.Classification := StrSolver;
  FPcgPackage.SelectionType := stRadioButton;

  FPcgnPackage := TPcgnSelection.Create(Model);
  FPcgnPackage.PackageIdentifier :=
    StrPCGNPreconditioned;
  FPcgnPackage.Classification := StrSolver;
  FPcgnPackage.SelectionType := stRadioButton;

  FGhbBoundary := TGhbPackage.Create(Model);
  FGhbBoundary.PackageIdentifier := StrGHBGeneralHeadBo;
  FGhbBoundary.Classification := BC_HeadDependentFlux;

  FWelPackage := TWellPackage.Create(Model);
  FWelPackage.PackageIdentifier := StrWELWellPackage;
  FWelPackage.Classification := BC_SpecifiedFlux;

  FRivPackage := TRivPackage.Create(Model);
  FRivPackage.PackageIdentifier := StrRIVRiverPackage;
  FRivPackage.Classification := BC_HeadDependentFlux;

  FDrnPackage := TDrnPackage.Create(Model);
  FDrnPackage.PackageIdentifier := StrDRNDrainPackage;
  FDrnPackage.Classification := BC_HeadDependentFlux;

  FDrtPackage := TDrtPackage.Create(Model);
  FDrtPackage.PackageIdentifier := StrDRTDrainReturnPa;
  FDrtPackage.Classification := BC_HeadDependentFlux;

  FRchPackage := TRchPackageSelection.Create(Model);
  FRchPackage.PackageIdentifier := StrRCHRechargePackag;
  FRchPackage.Classification := BC_SpecifiedFlux;

  FFhbPackage := TFhbPackageSelection.Create(Model);
  FFhbPackage.PackageIdentifier := StrFHBPackage;
  FFhbPackage.Classification := BC_SpecifiedFlux;
  FFhbPackage.AlternativeClassification := BC_SpecHead;
  FFhbPackage.SelectionType := stCheckBox;

  FEvtPackage := TEvtPackageSelection.Create(Model);
  FEvtPackage.PackageIdentifier := StrEVTEvapotranspirat;
  FEvtPackage.Classification := BC_HeadDependentFlux;

  FEtsPackage := TEtsPackageSelection.Create(Model);
  FEtsPackage.PackageIdentifier := StrETSEvapotranspirat;
  FEtsPackage.Classification := BC_HeadDependentFlux;

  FResPackage := TResPackageSelection.Create(Model);
  FResPackage.PackageIdentifier := StrRESReservoirPacka;
  FResPackage.Classification := BC_HeadDependentFlux;

  FLakPackage := TLakePackageSelection.Create(Model);
  LakPackage.PackageIdentifier := StrLAKLakePackage;
  LakPackage.Classification := BC_HeadDependentFlux;

  FSfrPackage := TSfrPackageSelection.Create(Model);
  SfrPackage.PackageIdentifier := StrSFR_Identifier;
  SfrPackage.Classification := BC_HeadDependentFlux;

  FStrPackage := TStrPackageSelection.Create(Model);
  FStrPackage.PackageIdentifier := StrSTRStreamPackage;;
  FStrPackage.Classification := BC_HeadDependentFlux;

  FUzfPackage := TUzfPackageSelection.Create(Model);
  UzfPackage.PackageIdentifier := StrUZFUnsaturatedZon;
  UzfPackage.Classification := StrFlow;

  FGmgPackage := TGmgPackageSelection.Create(Model);
  FGmgPackage.PackageIdentifier := StrGMGGeometricMulti;
  FGmgPackage.Classification := StrSolver;
  FGmgPackage.SelectionType := stRadioButton;

  FSipPackage := TSIPPackageSelection.Create(Model);
  FSipPackage.PackageIdentifier := StrSIPStronglyImplic;
  FSipPackage.Classification := StrSolver;
  FSipPackage.SelectionType := stRadioButton;

  FDe4Package := TDE4PackageSelection.Create(Model);
  FDe4Package.PackageIdentifier := StrDE4DirectSolverP;
  FDe4Package.Classification := StrSolver;
  FDe4Package.SelectionType := stRadioButton;

  FHobPackage := THobPackageSelection.Create(Model);
  FHobPackage.PackageIdentifier := StrHOBHeadObservatio;
  FHobPackage.Classification := StrObservations;
  FHobPackage.SelectionType := stCheckBox;

  FHfbPackage := TModflowPackageSelection.Create(Model);
  FHfbPackage.PackageIdentifier := StrHFBHorizontalFlow;
  FHfbPackage.Classification := StrFlow;
  FHfbPackage.SelectionType := stCheckBox;

  FModPath := TModpathSelection.Create(Model);
  FModPath.PackageIdentifier := StrMODPATH;
  FModPath.Classification := StrPostProcessors;
  FModPath.SelectionType := stCheckBox;

  FChobPackage := TModflowPackageSelection.Create(Model);
  FChobPackage.PackageIdentifier := StrCHOBSpecifiedHead;
  FChobPackage.Classification := StrObservations;
  FChobPackage.SelectionType := stCheckBox;

  FDrobPackage := TModflowPackageSelection.Create(Model);
  FDrobPackage.PackageIdentifier := StrDROBDrainObservat;
  FDrobPackage.Classification := StrObservations;
  FDrobPackage.SelectionType := stCheckBox;

  FGbobPackage := TModflowPackageSelection.Create(Model);
  FGbobPackage.PackageIdentifier := StrGBOBGeneralHeadB;
  FGbobPackage.Classification := StrObservations;
  FGbobPackage.SelectionType := stCheckBox;

  FRvobPackage := TModflowPackageSelection.Create(Model);
  FRvobPackage.PackageIdentifier := StrRVOBRiverObservat;
  FRvobPackage.Classification := StrObservations;
  FRvobPackage.SelectionType := stCheckBox;

  FStobPackage := TModflowPackageSelection.Create(Model);
  FStobPackage.PackageIdentifier := StrSTOBStreamObserva;
  FStobPackage.Classification := StrObservations;
  FStobPackage.SelectionType := stCheckBox;

  FMnw2Package := TMultinodeWellSelection.Create(Model);
  FMnw2Package.PackageIdentifier := StrMNW2MultiNodeWel;
  FMnw2Package.Classification := BC_HeadDependentFlux;
  FMnw2Package.SelectionType := stCheckBox;

  FBcfPackage := TModflowPackageSelection.Create(Model);
  FBcfPackage.PackageIdentifier := StrBCF6BlockCentered;
  FBcfPackage.Classification := StrFlow;
  FBcfPackage.SelectionType := stRadioButton;

  FSubPackage := TSubPackageSelection.Create(Model);
  FSubPackage.PackageIdentifier := StrSUBSubsidenceAnd;
  FSubPackage.Classification := StrSubsidence;
  FSubPackage.SelectionType := stCheckBox;

  FSwtPackage := TSwtPackageSelection.Create(Model);
  FSwtPackage.PackageIdentifier := StrSWTSubsidenceAnd;
  FSwtPackage.Classification := StrSubsidence;
  FSwtPackage.SelectionType := stCheckBox;

  FZoneBudget := TZoneBudgetSelect.Create(Model);
  FZoneBudget.PackageIdentifier := StrZONEBUDGET;
  FZoneBudget.Classification := StrPostProcessors;
  FZoneBudget.SelectionType := stCheckBox;

  FHydmodPackage := THydPackageSelection.Create(Model);
  FHydmodPackage.PackageIdentifier := StrHYDHYDMODPackage;
  FHydmodPackage.Classification := StrOutput;
  FHydmodPackage.SelectionType := stCheckBox;

  FUpwPackage := TUpwPackageSelection.Create(Model);
  FUpwPackage.PackageIdentifier := StrUPW_Identifier;
  FUpwPackage.Classification := StrFlow;
  FUpwPackage.SelectionType := stRadioButton;

  FNwtPackage := TNwtPackageSelection.Create(Model);
  FNwtPackage.PackageIdentifier := StrNWTNewtonSolver;
  FNwtPackage.Classification := StrSolver;
  FNwtPackage.SelectionType := stRadioButton;

  FMt3dBasic := TMt3dBasic.Create(Model);
  FMt3dBasic.PackageIdentifier := StrBTNMT3DMSBasicTr;
  FMt3dBasic.Classification := StrMT3DMS_Classificaton;
  FMt3dBasic.SelectionType := stCheckBox;

  FMt3dmsGCGSolver := TMt3dmsGCGSolverPackage.Create(Model);
  FMt3dmsGCGSolver.PackageIdentifier := StrGCGGeneralizedCon;
  FMt3dmsGCGSolver.Classification := StrMT3DMS_Classificaton;
  FMt3dmsGCGSolver.SelectionType := stCheckBox;

  FMt3dmsAdvection := TMt3dmsAdvection.Create(Model);
  FMt3dmsAdvection.PackageIdentifier := StrADVAdvectionPacka;
  FMt3dmsAdvection.Classification := StrMT3DMS_Classificaton;
  FMt3dmsAdvection.SelectionType := stCheckBox;

  FMt3dmsDispersion := TMt3dmsDispersion.Create(Model);
  FMt3dmsDispersion.PackageIdentifier := StrDSPDispersionPack;
  FMt3dmsDispersion.Classification := StrMT3DMS_Classificaton;
  FMt3dmsDispersion.SelectionType := stCheckBox;

  FMt3dmsSourceSink := TMt3dmsSourceSinkMixing.Create(Model);
  FMt3dmsSourceSink.PackageIdentifier := StrSSMSinkSourceM;
  FMt3dmsSourceSink.Classification := StrMT3DMS_Classificaton;
  FMt3dmsSourceSink.SelectionType := stCheckBox;

  FMt3dmsChemReaction := TMt3dmsChemReaction.Create(Model);
  FMt3dmsChemReaction.PackageIdentifier := StrRCTChemicalReacti;
  FMt3dmsChemReaction.Classification := StrMT3DMS_Classificaton;
  FMt3dmsChemReaction.SelectionType := stCheckBox;

  FMt3dmsTransObs := TMt3dmsTransportObservations.Create(Model);
  FMt3dmsTransObs.PackageIdentifier := StrTOBTransportObser;
  FMt3dmsTransObs.Classification := StrMT3DMS_Classificaton;
  FMt3dmsTransObs.SelectionType := stCheckBox;

  FFarmProcess := TFarmProcess.Create(Model);
  FFarmProcess.PackageIdentifier := StrFarmProcess;
  FFarmProcess.Classification := StrFarmProcessClassification;
  FFarmProcess.SelectionType := stCheckBox;

  FConduitFlowProcess := TConduitFlowProcess.Create(Model);
  FConduitFlowProcess.PackageIdentifier := StrCFPConduitFlowPr;
  FConduitFlowProcess.Classification := StrConduitFlowProcess;
  FConduitFlowProcess.SelectionType := stCheckBox;

  FSwiPackage := TSwiPackage.Create(Model);
  FSwiPackage.PackageIdentifier := StrSWI2SeawaterIntru;
  FSwiPackage.Classification := StrFlow;
  FSwiPackage.SelectionType := stCheckBox;

  FSwrPackage := TSwrPackage.Create(Model);
  FSwrPackage.PackageIdentifier := StrSurfaceWaterRoutin2;
  FSwrPackage.Classification := StrSurfaceWaterRoutin;
  FSwrPackage.SelectionType := stCheckBox;

  FMnw1Package := TMnw1Package.Create(Model);
  FMnw1Package.PackageIdentifier := StrMNW1MultiNodeWel;
  FMnw1Package.Classification := BC_HeadDependentFlux;
  FMnw1Package.SelectionType := stCheckBox;

  FNpfPackage := TNpfPackage.Create(Model);
  FNpfPackage.PackageIdentifier := StrNPFNodePropertyF;
  FNpfPackage.Classification := StrFlow;
  FNpfPackage.SelectionType := stRadioButton;

  FStoPackage := TStoPackage.Create(Model);
  FStoPackage.PackageIdentifier := StrSTOStoragePackage;
  FStoPackage.Classification := StrFlow;
  FStoPackage.SelectionType := stCheckBox;

  FSmsPackage := TSmsPackageSelection.Create(Model);
  FSmsPackage.PackageIdentifier := StrSMSSparseMatrixS;
  FSmsPackage.Classification := StrSolver;
  FSmsPackage.SelectionType := stRadioButton;

  FRipPackage := TRipPackage.Create(Model);
  FRipPackage.PackageIdentifier := StrRIPRiparianEvapot;
  FRipPackage.Classification := BC_HeadDependentFlux;
  FRipPackage.SelectionType := stCheckBox;
end;

destructor TModflowPackages.Destroy;
begin
  FRipPackage.Free;
  FSmsPackage.Free;
  FStoPackage.Free;
  FNpfPackage.Free;
  FSwrPackage.Free;
  FSwiPackage.Free;
  FConduitFlowProcess.Free;
  FFarmProcess.Free;
  FMt3dmsTransObs.Free;
  FMt3dmsChemReaction.Free;
  FMt3dmsSourceSink.Free;
  FMt3dmsDispersion.Free;
  FMt3dmsAdvection.Free;
  FMt3dmsGCGSolver.Free;
  FMt3dBasic.Free;
  FNwtPackage.Free;
  FUpwPackage.Free;
  FHydmodPackage.Free;
  FSwtPackage.Free;
  FZoneBudget.Free;
  FSubPackage.Free;
  FBcfPackage.Free;
  FStobPackage.Free;
  FRvobPackage.Free;
  FGbobPackage.Free;
  FDrobPackage.Free;
  FChobPackage.Free;
  FHfbPackage.Free;
  FHobPackage.Free;
  FDe4Package.Free;
  FSipPackage.Free;
  FGmgPackage.Free;
  FUzfPackage.Free;
  FStrPackage.Free;
  FSfrPackage.Free;
  FLakPackage.Free;
  FResPackage.Free;
  FEtsPackage.Free;
  FEvtPackage.Free;
  FRchPackage.Free;
  FDrtPackage.Free;
  FDrnPackage.Free;
  FRivPackage.Free;
  FWelPackage.Free;
  FGhbBoundary.Free;
  FFhbPackage.Free;
  FChdBoundary.Free;
  FHufPackage.Free;
  FLpfPackage.Free;
  FPcgnPackage.Free;
  FPcgPackage.Free;
  FModPath.Free;
  FMnw2Package.Free;
  FMnw1Package.Free;
  inherited;
end;

procedure TModflowPackages.Reset;
begin
  DrtPackage.InitializeVariables;
  DrnPackage.InitializeVariables;
  RivPackage.InitializeVariables;
  WelPackage.InitializeVariables;
  ChdBoundary.InitializeVariables;
  GhbBoundary.InitializeVariables;
  LpfPackage.InitializeVariables;
  PcgPackage.InitializeVariables;
  PcgnPackage.InitializeVariables;
  RchPackage.InitializeVariables;
  EvtPackage.InitializeVariables;
  EtsPackage.InitializeVariables;
  ResPackage.InitializeVariables;
  LakPackage.InitializeVariables;
  SfrPackage.InitializeVariables;
  UzfPackage.InitializeVariables;
  GmgPackage.InitializeVariables;
  SipPackage.InitializeVariables;
  De4Package.InitializeVariables;
  HobPackage.InitializeVariables;
  HfbPackage.InitializeVariables;
  ModPath.InitializeVariables;
  ChobPackage.InitializeVariables;
  DrobPackage.InitializeVariables;
  GbobPackage.InitializeVariables;
  RvobPackage.InitializeVariables;
  StobPackage.InitializeVariables;
  HufPackage.InitializeVariables;
  BcfPackage.InitializeVariables;
  SubPackage.InitializeVariables;
  ZoneBudget.InitializeVariables;
  SwtPackage.InitializeVariables;
  HydmodPackage.InitializeVariables;
  UpwPackage.InitializeVariables;
  NwtPackage.InitializeVariables;
  Mt3dBasic.InitializeVariables;
  Mt3dmsGCGSolver.InitializeVariables;
  Mt3dmsAdvection.InitializeVariables;
  Mt3dmsDispersion.InitializeVariables;
  Mt3dmsSourceSink.InitializeVariables;
  Mt3dmsChemReact.InitializeVariables;
  Mt3dmsTransObs.InitializeVariables;
  StrPackage.InitializeVariables;
  FhbPackage.InitializeVariables;
  FarmProcess.InitializeVariables;
  ConduitFlowProcess.InitializeVariables;
  SwiPackage.InitializeVariables;
  SwrPackage.InitializeVariables;
  Mnw1Package.InitializeVariables;
  NpfPackage.InitializeVariables;
  StoPackage.InitializeVariables;
  SmsPackage.InitializeVariables;
  RipPackage.InitializeVariables;
end;

function TModflowPackages.SelectedModflowPackageCount: integer;
begin
  result := 0;
  if ChdBoundary.IsSelected then
  begin
    Inc(Result);
  end;
  if FhbPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if GhbBoundary.IsSelected then
  begin
    Inc(Result);
  end;
  if LpfPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if PcgPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if PcgnPackage.IsSelected then
  begin
    Inc(Result);
  end;

  if WelPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if RivPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if DrnPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if DrtPackage.IsSelected then
  begin
    Inc(Result);
  end;

  if RchPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if EvtPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if EtsPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if ResPackage.IsSelected then
  begin
    Inc(Result);
  end;

  if LakPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if SfrPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if UzfPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if GmgPackage.IsSelected then
  begin
    Inc(Result);
  end;

  if SipPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if De4Package.IsSelected then
  begin
    Inc(Result);
  end;
  if HobPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if HfbPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if ChobPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if DrobPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if GbobPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if RvobPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if StobPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if HufPackage.IsSelected then
  begin
    Inc(Result);
    if (FModel as TCustomModel).HufParameters.CountParameters(
      [ptHUF_KDEP]) > 0 then
    begin
      Inc(Result);
    end;
    if (FModel as TCustomModel).ModflowSteadyParameters.CountParameters(
      [ptHUF_LVDA]) > 0 then
    begin
      Inc(Result);
    end;
  end;
  if Mnw2Package.IsSelected then
  begin
    Inc(Result);
  end;
  if BcfPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if SubPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if SwtPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if HydmodPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if UpwPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if NwtPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if StrPackage.IsSelected then
  begin
    Inc(Result);
  end;
  if FHfbPackage.IsSelected then
  begin
    Inc(Result);
  end;

  if FarmProcess.IsSelected and (Model.ModelSelection = msModflowFmp) then
  begin
    Inc(Result);
  end;

  if RipPackage.IsSelected and (Model.ModelSelection = msModflowFmp) then
  begin
    Inc(Result);
  end;

  if ConduitFlowProcess.IsSelected and (Model.ModelSelection = msModflowCfp) then
  begin
    Inc(Result);
  end;

  if SwiPackage.IsSelected
    and (Model.ModelSelection in [msModflow, msModflowNWT]) then
  begin
    Inc(Result);
  end;

  if SwrPackage.IsSelected
    and (Model.ModelSelection = msModflowNWT) then
  begin
    Inc(Result);
  end;

  if Mnw1Package.IsSelected then
  begin
    Inc(Result);
  end;

  if NpfPackage.IsSelected then
  begin
    Inc(Result);
  end;

  if StoPackage.IsSelected then
  begin
    Inc(Result);
  end;

  if SmsPackage.IsSelected then
  begin
    Inc(Result);
  end;

  // Don't count Modpath or ZoneBudget
  // because they are exported seperately from MODFLOW.
//  if ZoneBudget.IsSelected then
//  begin
//    Inc(Result);
//  end;
end;

procedure TModflowPackages.SetBcfPackage(const Value: TModflowPackageSelection);
begin
  FBcfPackage.Assign(Value);
end;

procedure TModflowPackages.SetChdBoundary(
  const Value: TChdPackage);
begin
  FChdBoundary.Assign(Value);
end;

procedure TModflowPackages.SetChobPackage(
  const Value: TModflowPackageSelection);
begin
  FChobPackage.Assign(Value);
end;

procedure TModflowPackages.SetConduitFlowProcess(
  const Value: TConduitFlowProcess);
begin
  FConduitFlowProcess.Assign(Value);
end;

procedure TModflowPackages.SetDe4Package(const Value: TDE4PackageSelection);
begin
  FDe4Package.Assign(Value);
end;

procedure TModflowPackages.SetDrnPackage(const Value: TDrnPackage);
begin
  FDrnPackage.Assign(Value);
end;

procedure TModflowPackages.SetDrobPackage(
  const Value: TModflowPackageSelection);
begin
  FDrobPackage.Assign(Value);
end;

procedure TModflowPackages.SetDrtPackage(const Value: TDrtPackage);
begin
  FDrtPackage.Assign(Value);
end;

procedure TModflowPackages.SetEtsPackage(const Value: TEtsPackageSelection);
begin
  FEtsPackage.Assign(Value);
end;

procedure TModflowPackages.SetEvtPackage(const Value: TEvtPackageSelection);
begin
  FEvtPackage.Assign(Value);
end;

procedure TModflowPackages.SetFarmProcess(const Value: TFarmProcess);
begin
  FFarmProcess.Assign(Value);
end;

procedure TModflowPackages.SetFhbPackage(const Value: TFhbPackageSelection);
begin
  FFhbPackage.Assign(Value);
end;

procedure TModflowPackages.SetGbobPackage(
  const Value: TModflowPackageSelection);
begin
  FGbobPackage.Assign(Value);
end;

procedure TModflowPackages.SetGhbBoundary(
  const Value: TGhbPackage);
begin
  FGhbBoundary.Assign(Value);
end;

procedure TModflowPackages.SetGmgPackage(const Value: TGmgPackageSelection);
begin
  FGmgPackage.Assign(Value);
end;

procedure TModflowPackages.SetHfbPackage(const Value: TModflowPackageSelection);
begin
  FHfbPackage.Assign(Value);
end;

procedure TModflowPackages.SetHobPackage(const Value: THobPackageSelection);
begin
  FHobPackage.Assign(Value);
end;

procedure TModflowPackages.SetHufPackage(const Value: THufPackageSelection);
begin
  FHufPackage.Assign(Value);
end;

procedure TModflowPackages.SetHydmodPackage(const Value: THydPackageSelection);
begin
  FHydmodPackage.Assign(Value);
end;

procedure TModflowPackages.SetLakPackage(const Value: TLakePackageSelection);
begin
  FLakPackage.Assign(Value);
end;

procedure TModflowPackages.SetLpfPackage(const Value: TLpfSelection);
begin
  FLpfPackage.Assign(Value);
end;

procedure TModflowPackages.SetMnw1Package(const Value: TMnw1Package);
begin
  FMnw1Package.Assign(Value);
end;

procedure TModflowPackages.SetMnw2Package(const Value: TMultinodeWellSelection);
begin
  FMnw2Package.Assign(Value);
end;

procedure TModflowPackages.SetModPath(const Value: TModpathSelection);
begin
  if FModel <> nil then
  begin
    if (Value.IsSelected)
      and ((Value.BeginningTime <> FModPath.BeginningTime)
      or (Value.EndingTime <> FModPath.EndingTime)) then
    begin
      frmGoPhast.CreateNewCompositeBudgetFile := True;
    end;
  end;
  FModPath.Assign(Value);
end;

procedure TModflowPackages.SetMt3dBasic(const Value: TMt3dBasic);
begin
  FMt3dBasic.Assign(Value);
end;

procedure TModflowPackages.SetMt3dmsAdvection(const Value: TMt3dmsAdvection);
begin
  FMt3dmsAdvection.Assign(Value);
end;

procedure TModflowPackages.SetMt3dmsChemReaction(
  const Value: TMt3dmsChemReaction);
begin
  FMt3dmsChemReaction.Assign(Value);
end;

procedure TModflowPackages.SetMt3dmsDispersion(const Value: TMt3dmsDispersion);
begin
  FMt3dmsDispersion.Assign(Value);
end;

procedure TModflowPackages.SetMt3dmsGCGSolver(
  const Value: TMt3dmsGCGSolverPackage);
begin
  FMt3dmsGCGSolver.Assign(Value);
end;

procedure TModflowPackages.SetMt3dmsSourceSink(
  const Value: TMt3dmsSourceSinkMixing);
begin
  FMt3dmsSourceSink.Assign(Value);
end;

procedure TModflowPackages.SetMt3dmsTransObs(
  const Value: TMt3dmsTransportObservations);
begin
  FMt3dmsTransObs.Assign(Value);
end;

procedure TModflowPackages.SetNpfPackage(const Value: TNpfPackage);
begin
  FNpfPackage.Assign(Value);
end;

procedure TModflowPackages.SetNwtPackage(const Value: TNwtPackageSelection);
begin
  FNwtPackage.Assign(Value);
end;

procedure TModflowPackages.SetPcgnPackage(const Value: TPcgnSelection);
begin
  FPcgnPackage.Assign(Value);
end;

procedure TModflowPackages.SetPcgPackage(const Value: TPcgSelection);
begin
  FPcgPackage.Assign(Value);
end;

procedure TModflowPackages.SetRchPackage(const Value: TRchPackageSelection);
begin
  FRchPackage.Assign(Value);
end;

procedure TModflowPackages.SetResPackage(const Value: TResPackageSelection);
begin
  FResPackage.Assign(Value);
end;

procedure TModflowPackages.SetRipPackage(const Value: TRipPackage);
begin
  FRipPackage.Assign(Value);
end;

procedure TModflowPackages.SetRivPackage(const Value: TRivPackage);
begin
  FRivPackage.Assign(Value);
end;

procedure TModflowPackages.SetRvobPackage(
  const Value: TModflowPackageSelection);
begin
  FRvobPackage.Assign(Value);
end;

procedure TModflowPackages.SetSfrPackage(const Value: TSfrPackageSelection);
begin
  FSfrPackage.Assign(Value);
end;

procedure TModflowPackages.SetSipPackage(const Value: TSIPPackageSelection);
begin
  FSipPackage.Assign(Value);
end;

procedure TModflowPackages.SetSmsPackage(const Value: TSmsPackageSelection);
begin
  FSmsPackage.Assign(Value);
end;

procedure TModflowPackages.SetStobPackage(
  const Value: TModflowPackageSelection);
begin
  FStobPackage.Assign(Value);
end;

procedure TModflowPackages.SetStoPackage(const Value: TStoPackage);
begin
  FStoPackage.Assign(Value);
end;

procedure TModflowPackages.SetStrPackage(const Value: TStrPackageSelection);
begin
  FStrPackage.Assign(Value);
end;

procedure TModflowPackages.SetSubPackage(const Value: TSubPackageSelection);
begin
  FSubPackage.Assign(Value);
end;

procedure TModflowPackages.SetSwiPackage(const Value: TSwiPackage);
begin
  FSwiPackage.Assign(Value);
end;

procedure TModflowPackages.SetSwrPackage(const Value: TSwrPackage);
begin
  FSwrPackage.Assign(Value);
end;

procedure TModflowPackages.SetSwtPackage(const Value: TSwtPackageSelection);
begin
  FSwtPackage.Assign(Value);
end;

procedure TModflowPackages.SetUpwPackage(const Value: TUpwPackageSelection);
begin
  FUpwPackage.Assign(Value);
end;

procedure TModflowPackages.SetUzfPackage(const Value: TUzfPackageSelection);
begin
  FUzfPackage.Assign(Value);
end;

procedure TModflowPackages.SetWelPackage(const Value: TWellPackage);
begin
  FWelPackage.Assign(Value);
end;

procedure TModflowPackages.SetZoneBudget(const Value: TZoneBudgetSelect);
begin
  FZoneBudget.Assign(Value);
end;

  // Except in the initialization section, the following variables
  // should be treated as constants.
var
  FBC_SpecHead: string;
  FBC_SpecifiedFlux: string;
  FBC_HeadDependentFlux: string;

function BC_SpecHead: string;
begin
  result := FBC_SpecHead;
end;

function BC_SpecifiedFlux: string;
begin
  result := FBC_SpecifiedFlux;
end;

function BC_HeadDependentFlux: string;
begin
  result := FBC_HeadDependentFlux;
end;

initialization
  FBC_SpecHead := StrBoundaryCondition + '|' + StrSpecifiedHeadPackages;
  FBC_SpecifiedFlux := StrBoundaryCondition + '|' + StrSpecifiedFlux;
  FBC_HeadDependentFlux := StrBoundaryCondition + '|' + StrHeaddependentFlux;

end.

