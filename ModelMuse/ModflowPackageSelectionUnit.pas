unit ModflowPackageSelectionUnit;

interface

uses SysUtils, Classes, GoPhastTypes, OrderedCollectionUnit, DataSetUnit,
  ModpathParticleUnit, ModflowBoundaryDisplayUnit, ScreenObjectUnit,
  ModflowBoundaryUnit, Mt3dmsChemSpeciesUnit, System.Generics.Collections;

Type
  TSelectionType = (stCheckBox, stRadioButton);

  // modpath ordinals
  TCompositeBudgetFileOption = (cbfGenerateNew, cbfUseOldFile);
  TModpathOutputMode = (mopEndpoints, mopPathline, mopTimeSeries);
  TTimeMethod = (tmIntervals, tmIndividual);
  TTrackingDirection = (tdForward, tdBackward);
  TWeakSink = (wsPassThrough, wsStop, wsThreshold);
  TEndpointWrite = (ewAll, ewInStoppingZone);
  TTimeSeriesMethod = (tsmUniform, tsmIndividual);
  TStopOption = (soModelEnd, soExtend, soTrackingTime);
  TBudgetChecking = (bcNone, bcSummary, bcList, bcTrace);
  TRetardationOption = (roNone, roUsed);
  TAdvectiveObservations = (aoNone, aoAll, aoLast);
  TMpathVersion = (mp5, mp6);

  TModflowPackageSelection = class(TPersistent)
  private
    FComments: TStrings;
    { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
    // (FModel as TCustomModel).DischargeRoutingUpdate;
    // (FModel as TCustomModel).AddTimeList(TimeList);
    // (FModel as TCustomModel).RemoveTimeList(TimeList);
    // (FModel as TCustomModel).UpdateDisplayUseList
    // (FModel as TCustomModel).rpThreeDFormulaCompiler;
    FModel: TBaseModel;
    FPackageIdentifier: string;
    FClassification: string;
    FFrame: pointer;
    FNode: pointer;
    FSelectionType: TSelectionType;
    FAlternateNode: pointer;
    FAlternativeClassification: string;
    FOnSelectionChange: TNotifyEvent;
    procedure InvalidateModel;
    procedure SetComments(const Value: TStrings);
    procedure SetOnSelectionChange(const Value: TNotifyEvent);
  protected
    FIsSelected: boolean;
    procedure SetIsSelected(const Value: boolean); virtual;
    procedure DischargeRoutingUpdate;
    function PackageUsed(Sender: TObject): boolean;
    procedure AddTimeList(TimeList: TCustomTimeList);
    procedure RemoveTimeList(TimeList: TCustomTimeList);
    // @name is used when determining what data sets or global variables are
    // used when evaluating the formula for a MODFLOW boundary condition.
    procedure UpdateDisplayUseList(NewUseList: TStringList;
      ParamType: TParameterType; DataIndex: integer; const DisplayName: string);
    procedure UpdateUseList(DataIndex: integer; NewUseList: TStringList;
      Item: TCustomModflowBoundaryItem);
    procedure OnValueChanged(Sender: TObject);
    procedure SetIntegerProperty(var Field: integer; const Value: integer);
    procedure SetBooleanProperty(var Field: boolean; const Value: boolean);
    procedure SetRealProperty(var Field: real; const Value: real);
    procedure SetStringProperty(var Field: string; const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with a TNotifyEvent or interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    // @name is a string used to label items related to the package.
    // For example, in @link(TfrmShowHideObjects), @name is used to
    // label the objects that set the boundary conditions for a
    // particular package.
    property PackageIdentifier: string read FPackageIdentifier
      write FPackageIdentifier;
    // @name is used to set up a hierarchical arrangement of
    // @link(PackageIdentifier)s.
    property Classification: string read FClassification write FClassification;
    property AlternativeClassification: string read FAlternativeClassification
      write FAlternativeClassification;
    // @name is used in @link(TfrmModflowPackages) to associate a particular
    // package with a particular TFrame.
    property Frame: pointer read FFrame write FFrame;
    // @name is used in @link(TfrmModflowPackages) to display or change
    // @link(IsSelected).
    property Node: pointer read FNode write FNode;
    property AlternateNode: pointer read FAlternateNode write FAlternateNode;
    property SelectionType: TSelectionType read FSelectionType
      write FSelectionType;
    procedure InvalidateAllTimeLists; virtual;
    procedure InitializeVariables; virtual;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write SetOnSelectionChange;
  published
    property IsSelected: boolean read FIsSelected write SetIsSelected;
    property Comments: TStrings read FComments write SetComments;
  end;

  TPackageClass = class of TModflowPackageSelection;

  TWellPackage = class(TModflowPackageSelection)
  private
    FMfWellPumpage: TModflowBoundaryDisplayTimeList;
    FPublishedPhiRamp: TRealStorage;
//    FStoredLossFactor: TRealStorage;
//    FLossFactorOption: boolean;
    FUseTabFiles: boolean;
    procedure InvalidateMfWellPumpage(Sender: TObject);
    procedure InitializeMfWellPumpage(Sender: TObject);
    procedure GetMfWellUseList(Sender: TObject; NewUseList: TStringList);
    function GetPhiRamp: Double;
    procedure SetPhiRamp(const Value: Double);

    procedure SetPublishedPhiRamp(const Value: TRealStorage);
//    procedure SetStoredLossFactor(const Value: TRealStorage);
//    procedure SetLossFactorOption(const Value: boolean);
//    function GetLossFactor: double;
//    procedure SetLossFactor(const Value: double);
    procedure SetUseTabFiles(const Value: boolean);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfWellPumpage: TModflowBoundaryDisplayTimeList
      read FMfWellPumpage;
    procedure InvalidateAllTimeLists; override;
    procedure InitializeVariables; override;
    property PhiRamp: Double read GetPhiRamp write SetPhiRamp;
//    property LossFactor: double read GetLossFactor write SetLossFactor;
    function UseTabFilesInThisModel: boolean;
  published
    property PublishedPhiRamp: TRealStorage read FPublishedPhiRamp
      write SetPublishedPhiRamp;
    // LOSSFACTOR
//    property LossFactorOption: boolean read FLossFactorOption
//      write SetLossFactorOption;
    // factor
//    property StoredLossFactor: TRealStorage read FStoredLossFactor
//      write SetStoredLossFactor;
    // TABFILES
    property UseTabFiles: boolean read FUseTabFiles write SetUseTabFiles;
  end;

  TGhbPackage = class(TModflowPackageSelection)
  private
    FMfGhbConductance: TModflowBoundaryDisplayTimeList;
    FMfGhbBoundaryHead: TModflowBoundaryDisplayTimeList;
    procedure GetMfGhbConductanceUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfGhbBoundaryHeadUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure InitializeGhbDisplay(Sender: TObject);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfGhbConductance: TModflowBoundaryDisplayTimeList
      read FMfGhbConductance;
    property MfGhbBoundaryHead: TModflowBoundaryDisplayTimeList
      read FMfGhbBoundaryHead;
    procedure InvalidateAllTimeLists; override;
  end;

  TDrnPackage = class(TModflowPackageSelection)
  private
    FMfDrnElevation: TModflowBoundaryDisplayTimeList;
    FMfDrnConductance: TModflowBoundaryDisplayTimeList;
    procedure InitializeDrnDisplay(Sender: TObject);
    procedure GetMfDrnConductanceUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfDrnElevationUseList(Sender: TObject;
      NewUseList: TStringList);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfDrnConductance: TModflowBoundaryDisplayTimeList
      read FMfDrnConductance;
    property MfDrnElevation: TModflowBoundaryDisplayTimeList
      read FMfDrnElevation;
    procedure InvalidateAllTimeLists; override;
  end;

  TDrtPackage = class(TModflowPackageSelection)
  private
    FMfDrtReturnFraction: TModflowBoundaryDisplayTimeList;
    FMfDrtConductance: TModflowBoundaryDisplayTimeList;
    FMfDrtElevation: TModflowBoundaryDisplayTimeList;
    procedure InitializeDrtDisplay(Sender: TObject);
    procedure GetMfDrtConductanceUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfDrtElevationUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfDrtReturnFractionUseList(Sender: TObject;
      NewUseList: TStringList);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfDrtConductance: TModflowBoundaryDisplayTimeList
      read FMfDrtConductance;
    property MfDrtElevation: TModflowBoundaryDisplayTimeList
      read FMfDrtElevation;
    property MfDrtReturnFraction: TModflowBoundaryDisplayTimeList
      read FMfDrtReturnFraction;
    procedure InvalidateAllTimeLists; override;
  end;

  TRivPackage = class(TModflowPackageSelection)
  private
    FMfRivConductance: TModflowBoundaryDisplayTimeList;
    FMfRivBottom: TModflowBoundaryDisplayTimeList;
    FMfRivStage: TModflowBoundaryDisplayTimeList;
    procedure InitializeRivDisplay(Sender: TObject);
    procedure GetMfRivConductanceUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfRivStageUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfRivBottomUseList(Sender: TObject; NewUseList: TStringList);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfRivConductance: TModflowBoundaryDisplayTimeList
      read FMfRivConductance;
    property MfRivStage: TModflowBoundaryDisplayTimeList read FMfRivStage;
    property MfRivBottom: TModflowBoundaryDisplayTimeList read FMfRivBottom;
    procedure InvalidateAllTimeLists; override;
  end;

  TChdPackage = class(TModflowPackageSelection)
  private
    FMfChdStartingHead: TModflowBoundaryDisplayTimeList;
    FMfChdEndingHead: TModflowBoundaryDisplayTimeList;
    procedure InitializeChdDisplay(Sender: TObject);
    procedure GetMfChdStartingHeadUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfChdEndingHeadUseList(Sender: TObject;
      NewUseList: TStringList);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfChdStartingHead: TModflowBoundaryDisplayTimeList
      read FMfChdStartingHead;
    property MfChdEndingHead: TModflowBoundaryDisplayTimeList
      read FMfChdEndingHead;
    procedure InvalidateAllTimeLists; override;
  end;

  TCustomTransientArrayItem = class(TCollectionItem)
  private
    FFileName: string;
    FUniform: boolean;
    FArrayName: string;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ArrayName: string read FArrayName write FArrayName;
    property FileName: string read FFileName write FFileName;
    property Uniform: boolean read FUniform write FUniform;
  end;

  TTransientMultItem = class(TCustomTransientArrayItem)
  private
    FUniformValue: double;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property UniformValue: double read FUniformValue write FUniformValue;
  end;

  TTransientZoneItem = class(TCustomTransientArrayItem)
  private
    FUniformValue: integer;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property UniformValue: integer read FUniformValue write FUniformValue;
  end;

  TTransientMultCollection = class(TCollection)
  private
    function GetItem(Index: integer): TTransientMultItem;
    procedure SetItem(Index: integer; const Value: TTransientMultItem);
  public
    Constructor Create;
    function Add: TTransientMultItem;
    property Items[Index: integer]: TTransientMultItem
      read GetItem write SetItem; default;
  end;

  TTransientZoneCollection = class(TCollection)
  private
    function GetItem(Index: integer): TTransientZoneItem;
    procedure SetItem(Index: integer; const Value: TTransientZoneItem);
  public
    Constructor Create;
    function Add: TTransientZoneItem;
    property Items[Index: integer]: TTransientZoneItem
      read GetItem write SetItem; default;
  end;

  TLpfSelection = class(TModflowPackageSelection)
  private
    FUseSaturatedThickness: boolean;
    FUseConstantCV: boolean;
    FUseCvCorrection: boolean;
    FUseVerticalFlowCorrection: boolean;
    FUseStorageCoefficient: boolean;
    FMultZoneArraysExported: boolean;
    FNoParCheck: Boolean;
    procedure SetUseConstantCV(const Value: boolean);
    procedure SetUseCvCorrection(const Value: boolean);
    procedure SetUseSaturatedThickness(const Value: boolean);
    procedure SetUseVerticalFlowCorrection(const Value: boolean);
    procedure SetUseStorageCoefficient(const Value: boolean);
    procedure SetNoParCheck(const Value: Boolean);
  public
    procedure InitializeVariables; override;
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    property MultZoneArraysExported: boolean read FMultZoneArraysExported
      write FMultZoneArraysExported;
  published
    // CONSTANTCV
    property UseConstantCV: boolean read FUseConstantCV write SetUseConstantCV;
    // THICKSTRT
    property UseSaturatedThickness: boolean read FUseSaturatedThickness
      write SetUseSaturatedThickness;
    // inverse of NOCVCORRECTION
    property UseCvCorrection: boolean read FUseCvCorrection
      write SetUseCvCorrection default True;
    // NOVFC
    property UseVerticalFlowCorrection: boolean read FUseVerticalFlowCorrection
      write SetUseVerticalFlowCorrection default True;
    // STORAGECOEFFICIENT option
    property UseStorageCoefficient: boolean read FUseStorageCoefficient
      write SetUseStorageCoefficient;
    // NOPARCHECK
    property NoParCheck: Boolean read FNoParCheck write SetNoParCheck;
  end;

  TCellAveraging = (caHarmonic, caLogarithmic, caArithLog);

  TNpfPackage = class(TModflowPackageSelection)
  private
    FCellAveraging: TCellAveraging;
    FPerched: Boolean;
    FUseSaturatedThickness: boolean;
    FTimeVaryingVerticalConductance: boolean;
    FUseNewtonRaphson: boolean;
    FApplyHeadDampening: boolean;
    FDewatered: boolean;
    procedure SetCellAveraging(const Value: TCellAveraging);
    procedure SetApplyHeadDampening(const Value: boolean);
    procedure SetDewatered(const Value: boolean);
    procedure SetPerched(const Value: Boolean);
    procedure SetTimeVaryingVerticalConductance(const Value: boolean);
    procedure SetUseNewtonRaphson(const Value: boolean);
    procedure SetUseSaturatedThickness(const Value: boolean);
  public
    procedure InitializeVariables; override;
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
  published
    // CELL_AVERAGING
    property CellAveraging: TCellAveraging read FCellAveraging
      write SetCellAveraging stored True;
    // THICKSTRT
    property UseSaturatedThickness: boolean read FUseSaturatedThickness
      write SetUseSaturatedThickness stored True;
    // VARIABLECV
    property TimeVaryingVerticalConductance: boolean
      read FTimeVaryingVerticalConductance
      write SetTimeVaryingVerticalConductance stored True;
    // DEWATERED. Only used if @link(TimeVaryingVerticalConductance) is true;
    property Dewatered: boolean read FDewatered write SetDewatered stored True;
    // PERCHED
    property Perched: Boolean read FPerched write SetPerched stored True;
    // NEWTON (Wetting  can not be used if @name is true.)
    property UseNewtonRaphson: boolean read FUseNewtonRaphson
      write SetUseNewtonRaphson stored True;
    // NEWTON_HEAD_DAMPENING
    property ApplyHeadDampening: boolean read FApplyHeadDampening
      write SetApplyHeadDampening stored True;
  end;

  TStorageChoice = (scSpecificStorage, scStorageCoefficient);

  TStoPackage = class(TModflowPackageSelection)
  private
    FUseNewtonRaphson: Boolean;
    FStorageChoice: TStorageChoice;
    procedure SetStorageChoice(const Value: TStorageChoice);
    procedure SetUseNewtonRaphson(const Value: Boolean);
  public
    procedure InitializeVariables; override;
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
  published
    // STORAGECOEFFICIENT
    property StorageChoice: TStorageChoice read FStorageChoice
      write SetStorageChoice stored True;
    // NEWTON
    property UseNewtonRaphson: Boolean read FUseNewtonRaphson
      write SetUseNewtonRaphson stored True;
  end;

  THDryPrintOption = (hpoDontPrintHdry, hpoPrintHdry);

  TUpwPackageSelection = class(TModflowPackageSelection)
  private
    FHDryPrintOption: THDryPrintOption;
    FNoParCheck: Boolean;
    procedure SetHDryPrintOption(const Value: THDryPrintOption);
    procedure SetNoParCheck(const Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    procedure InitializeVariables; override;
  published
    property HDryPrintOption: THDryPrintOption read FHDryPrintOption
      write SetHDryPrintOption stored True;
    property NoParCheck: Boolean read FNoParCheck write SetNoParCheck;
  end;

  THufReferenceChoice = (hrcModelTop, hrcReferenceLayer);

  THufPackageSelection = class(TModflowPackageSelection)
  private
    FSaveHeads: boolean;
    FSaveFlows: boolean;
    FReferenceChoice: THufReferenceChoice;
    procedure SetSaveFlows(const Value: boolean);
    procedure SetSaveHeads(const Value: boolean);
    procedure SetReferenceChoice(const Value: THufReferenceChoice);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    procedure InitializeVariables; override;
  published
    property SaveHeads: boolean read FSaveHeads write SetSaveHeads default True;
    property SaveFlows: boolean read FSaveFlows write SetSaveFlows default True;
    property ReferenceChoice: THufReferenceChoice read FReferenceChoice
      write SetReferenceChoice;
  end;

  TPcgMethod = (pmCholesky, pmPolynomial);
  TPcgPrintSelection = (ppsAll, ppsIterations, ppsNone, ppsFail);
  TPcgEstimateMaxEigenvalue = (peeEstimate, peeDontEstimate);
  TPcgDryConvertOption = (dcoConvertWhenSurrounded, dcoConvertWhenNoFlow);

  TPcgSelection = class(TModflowPackageSelection)
  private
    FRELAX: TRealStorage;
    FNBPOL: TPcgEstimateMaxEigenvalue;
    FMUTPCG: TPcgPrintSelection;
    FRCLOSE: TRealStorage;
    FDAMPPCG: TRealStorage;
    FHCLOSE: TRealStorage;
    FNPCOND: TPcgMethod;
    FMXITER: integer;
    FITER1: integer;
    FIPRPCG: integer;
    FDAMPPCGT: TRealStorage;
    FIHCOFADD: TPcgDryConvertOption;
    procedure SetDAMPPCG(const Value: TRealStorage);
    procedure SetHCLOSE(const Value: TRealStorage);
    procedure SetIPRPCG(const Value: integer);
    procedure SetITER1(const Value: integer);
    procedure SetMUTPCG(const Value: TPcgPrintSelection);
    procedure SetMXITER(const Value: integer);
    procedure SetNBPOL(const Value: TPcgEstimateMaxEigenvalue);
    procedure SetNPCOND(const Value: TPcgMethod);
    procedure SetRCLOSE(const Value: TRealStorage);
    procedure SetRELAX(const Value: TRealStorage);
    procedure SetDAMPPCGT(const Value: TRealStorage);
    procedure SetIHCOFADD(const Value: TPcgDryConvertOption);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
  published
    property MXITER: integer read FMXITER write SetMXITER default 20;
    property ITER1: integer read FITER1 write SetITER1 default 30;
    property NPCOND: TPcgMethod read FNPCOND write SetNPCOND;
    property HCLOSE: TRealStorage read FHCLOSE write SetHCLOSE;
    property RCLOSE: TRealStorage read FRCLOSE write SetRCLOSE;
    property RELAX: TRealStorage read FRELAX write SetRELAX;
    property NBPOL: TPcgEstimateMaxEigenvalue read FNBPOL write SetNBPOL;
    property IPRPCG: integer read FIPRPCG write SetIPRPCG default 1;
    property MUTPCG: TPcgPrintSelection read FMUTPCG write SetMUTPCG;
    property DAMPPCG: TRealStorage read FDAMPPCG write SetDAMPPCG;
    property DAMPPCGT: TRealStorage read FDAMPPCGT write SetDAMPPCGT;
    property IHCOFADD: TPcgDryConvertOption read FIHCOFADD write SetIHCOFADD;
  end;

  TDamping = (dOrdinary, dAdaptive, dEnhanced);
  TConvergenceMode = (cmStandard, cmAdaptive, cmEnhanced);
  TProgressReporting = (prNone, prListing, prExternal);

  TPcgnSelection = class(TModflowPackageSelection)
  private
    FADAMP: TDamping;
    FITER_MI: integer;
    FCHGLIMIT: TRealStorage;
    FCLOSE_R: TRealStorage;
    FITER_MO: integer;
    FRELAX: TRealStorage;
    FRATE_C: TRealStorage;
    FUNIT_TS: boolean;
    FCLOSE_H: TRealStorage;
    FRATE_D: TRealStorage;
    FCNVG_LB: TRealStorage;
    FUNIT_PC: boolean;
    FDAMP_LB: TRealStorage;
    FDAMP: TRealStorage;
    FMCNVG: integer;
    FIFILL: integer;
    FIPUNIT: TProgressReporting;
    FACNVG: TConvergenceMode;
    procedure SetACNVG(const Value: TConvergenceMode);
    procedure SetADAMP(const Value: TDamping);
    procedure SetCHGLIMIT(const Value: TRealStorage);
    procedure SetCLOSE_H(const Value: TRealStorage);
    procedure SetCLOSE_R(const Value: TRealStorage);
    procedure SetCNVG_LB(const Value: TRealStorage);
    procedure SetDAMP(const Value: TRealStorage);
    procedure SetDAMP_LB(const Value: TRealStorage);
    procedure SetIFILL(const Value: integer);
    procedure SetIPUNIT(const Value: TProgressReporting);
    procedure SetITER_MI(const Value: integer);
    procedure SetITER_MO(const Value: integer);
    procedure SetMCNVG(const Value: integer);
    procedure SetRATE_C(const Value: TRealStorage);
    procedure SetRATE_D(const Value: TRealStorage);
    procedure SetRELAX(const Value: TRealStorage);
    procedure SetUNIT_PC(const Value: boolean);
    procedure SetUNIT_TS(const Value: boolean);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
  published
    // Line 1 variables

    // the maximum number of Picard (outer) iterations allowed
    property ITER_MO: integer read FITER_MO write SetITER_MO;
    //the maximum number of PCG (inner) iterations allowed
    property ITER_MI: integer read FITER_MI write SetITER_MI;
    //  the residual-based stopping criterion for iteration.
    property CLOSE_R: TRealStorage read FCLOSE_R write SetCLOSE_R;
    //  the head-based stopping criterion for iteration.
    property CLOSE_H: TRealStorage read FCLOSE_H write SetCLOSE_H;

    // Line 2 variables

    // relaxation parameter
    property RELAX: TRealStorage read FRELAX write SetRELAX;
    // fill level of the MIC preconditioner
    property IFILL: integer read FIFILL write SetIFILL;
    // integer variable: UNIT_PC is the unit number of an optional output file
    // where progress for the inner PCG iteration can be written.
    property UNIT_PC: boolean read FUNIT_PC write SetUNIT_PC;
    // integer variable: UNIT_TS is the unit number of an optional output file
    // where the actual time in the PCG solver is accumulated.
    property UNIT_TS: boolean read FUNIT_TS write SetUNIT_TS;

    // Line 3 variables - used only if ITER_MO > 1

    // ADAMP, integer variable: ADAMP defines the mode of damping
    // applied to the linear solution.
    property ADAMP: TDamping read FADAMP write SetADAMP;
    // DAMP restricts the damping parameter Theta
    property DAMP: TRealStorage read FDAMP write SetDAMP;
    // DAMP_LB, real variable: DAMP_LB represents a bound placed on Theta
    property DAMP_LB: TRealStorage read FDAMP_LB write SetDAMP_LB;
    // RATE_D, rate parameter
    property RATE_D: TRealStorage read FRATE_D write SetRATE_D;
    // This variable limits the maximum head change applicable to the
    // updated hydraulic heads in a Picard iteration.
    property CHGLIMIT: TRealStorage read FCHGLIMIT write SetCHGLIMIT;

    // Line 4 variables - used only if ITER_MO > 1

    // ACNVG defines the mode of convergence applied to the PCG solver.
    property ACNVG: TConvergenceMode read FACNVG write SetACNVG;
    // CNVG_LB is the minimum value that the relative convergence epsilon
    //  is allowed to take under the self-adjusting convergence option.
    property CNVG_LB: TRealStorage read FCNVG_LB write SetCNVG_LB;
    // MCNVG increases the relative PCG convergence criteria by
    // a power equal to MCNVG
    property MCNVG: integer read FMCNVG write SetMCNVG;
    // this option results in variable enhancement of epsilon.
    property RATE_C: TRealStorage read FRATE_C write SetRATE_C;
    // Variable IPUNIT enables progress reporting for the Picard iteration.
    property IPUNIT: TProgressReporting read FIPUNIT write SetIPUNIT;
  end;

  TGmgPackageSelection = class(TModflowPackageSelection)
  private
    FISM: integer;
    FCHGLIMIT: TRealStorage;
    FISC: integer;
    FIADAMP: integer;
    FDUP: TRealStorage;
    FRELAX: TRealStorage;
    FIITER: integer;
    FRCLOSE: TRealStorage;
    FIUNITMHC: Boolean;
    FDLOW: TRealStorage;
    FDAMP: TRealStorage;
    FHCLOSE: TRealStorage;
    FMXITER: integer;
    FIOUTGMG: integer;
    procedure SetCHGLIMIT(const Value: TRealStorage);
    procedure SetDAMP(const Value: TRealStorage);
    procedure SetDLOW(const Value: TRealStorage);
    procedure SetDUP(const Value: TRealStorage);
    procedure SetHCLOSE(const Value: TRealStorage);
    procedure SetIADAMP(const Value: integer);
    procedure SetIITER(const Value: integer);
    procedure SetIOUTGMG(const Value: integer);
    procedure SetISC(const Value: integer);
    procedure SetISM(const Value: integer);
    procedure SetIUNITMHC(const Value: Boolean);
    procedure SetMXITER(const Value: integer);
    procedure SetRCLOSE(const Value: TRealStorage);
    procedure SetRELAX(const Value: TRealStorage);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
  published
    property RCLOSE: TRealStorage read FRCLOSE write SetRCLOSE;
    property IITER: integer read FIITER write SetIITER;
    property HCLOSE: TRealStorage read FHCLOSE write SetHCLOSE;
    property MXITER: integer read FMXITER write SetMXITER;
    property DAMP: TRealStorage read FDAMP write SetDAMP;
    property IADAMP: integer read FIADAMP write SetIADAMP;
    property IOUTGMG: integer read FIOUTGMG write SetIOUTGMG;
    property IUNITMHC: Boolean read FIUNITMHC write SetIUNITMHC;
    property ISM: integer read FISM write SetISM;
    property ISC: integer read FISC write SetISC;
    property DUP: TRealStorage read FDUP write SetDUP;
    property DLOW: TRealStorage read FDLOW write SetDLOW;
    property CHGLIMIT: TRealStorage read FCHGLIMIT write SetCHGLIMIT;
    property RELAX: TRealStorage read FRELAX write SetRELAX;
  end;

  TSIPPackageSelection = class(TModflowPackageSelection)
  private
    FNPARM: integer;
    FIPRSIP: integer;
    FHCLOSE: TRealStorage;
    FIPCALC: integer;
    FMXITER: integer;
    FWSEED: TRealStorage;
    FACCL: TRealStorage;
    procedure SetACCL(const Value: TRealStorage);
    procedure SetHCLOSE(const Value: TRealStorage);
    procedure SetIPCALC(const Value: integer);
    procedure SetIPRSIP(const Value: integer);
    procedure SetMXITER(const Value: integer);
    procedure SetNPARM(const Value: integer);
    procedure SetWSEED(const Value: TRealStorage);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
  published
    property MXITER: integer read FMXITER write SetMXITER;
    property NPARM: integer read FNPARM write SetNPARM;
    property ACCL: TRealStorage read FACCL write SetACCL;
    property HCLOSE: TRealStorage read FHCLOSE write SetHCLOSE;
    property IPCALC: integer read FIPCALC write SetIPCALC;
    property WSEED: TRealStorage read FWSEED write SetWSEED;
    property IPRSIP: integer read FIPRSIP write SetIPRSIP;
  end;

  TDE4PackageSelection = class(TModflowPackageSelection)
  private
    FMUTD4: integer;
    FIFREQ: integer;
    FMXUP: integer;
    FITMX: integer;
    FHCLOSE: TRealStorage;
    FMXBW: integer;
    FIPRD4: integer;
    FMXLOW: integer;
    FACCL: TRealStorage;
    procedure SetACCL(const Value: TRealStorage);
    procedure SetHCLOSE(const Value: TRealStorage);
    procedure SetIFREQ(const Value: integer);
    procedure SetIPRD4(const Value: integer);
    procedure SetITMX(const Value: integer);
    procedure SetMUTD4(const Value: integer);
    procedure SetMXBW(const Value: integer);
    procedure SetMXLOW(const Value: integer);
    procedure SetMXUP(const Value: integer);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
  published
    property ITMX: integer read FITMX write SetITMX;
    property MXUP: integer read FMXUP write SetMXUP;
    property MXLOW: integer read FMXLOW write SetMXLOW;
    property MXBW: integer read FMXBW write SetMXBW;
    property IFREQ: integer read FIFREQ write SetIFREQ;
    property MUTD4: integer read FMUTD4 write SetMUTD4;
    property ACCL: TRealStorage read FACCL write SetACCL;
    property HCLOSE: TRealStorage read FHCLOSE write SetHCLOSE;
    property IPRD4: integer read FIPRD4 write SetIPRD4;
  end;

  TNewtonSolverMethod = (nsmGmres, nsmChiMD);
  TNewtonOption = (noSimple, noModerate, noComplex, noSpecified);
  TNewtonIluMethod = (nimDropTol, nimKOrder);
  TNewtonAccelMethod = (namCongGrad, namOthoMin, namBiCgstab);
  TNewtonOrderingMethod = (nomRCM, nomMinimumOrdering);
  TNewtonApplyReducedPrecondition = (narpDontApply, narpApply);
  TNewtonUseDropTolerance = (nudtDontUse, nudtUse);

  TNwtPackageSelection = class(TModflowPackageSelection)
  private
    FMaxGmresRestarts: integer;
    FStopTolerance: TRealStorage;
    FMomementumCoefficient: TRealStorage;
    FLevel: integer;
    FOrderingMethod: TNewtonOrderingMethod;
    FDropTolerancePreconditioning: TRealStorage;
    FCorrectForCellBottom: integer;
    FFillLimit: integer;
    FOption: TNewtonOption;
    FSolverMethod: TNewtonSolverMethod;
    FMaxBackIterations: integer;
    FDBDKappa: TRealStorage;
    FApplyReducedPrecondition: TNewtonApplyReducedPrecondition;
    FIluMethod: TNewtonIluMethod;
    FInnerHeadClosureCriterion: TRealStorage;
    FDBDGamma: TRealStorage;
    FFluxTolerance: TRealStorage;
    FResidReducConv: TRealStorage;
    FAccelMethod: TNewtonAccelMethod;
    FMaxOuterIterations: integer;
    FMaxIterInner: integer;
    FUseDropTolerance: TNewtonUseDropTolerance;
    FDBDTheta: TRealStorage;
    FHeadTolerance: TRealStorage;
    FFillLevel: integer;
    FPrintFlag: integer;
    FMaxInnerIterations: integer;
    FNumberOfOrthogonalizations: integer;
    FThicknessFactor: TRealStorage;
    FBackReduce: TRealStorage;
    FBackTol: TRealStorage;
    FBackFlag: integer;
    FContinueNWT: Boolean;
    procedure SetRealProperty(Field, NewValue: TRealStorage);
    procedure SetAccelMethod(const Value: TNewtonAccelMethod);
    procedure SetApplyReducedPrecondition(
      const Value: TNewtonApplyReducedPrecondition);
    procedure SetBackFlag(const Value: integer);
    procedure SetBackReduce(const Value: TRealStorage);
    procedure SetBackTol(const Value: TRealStorage);
    procedure SetCorrectForCellBottom(const Value: integer);
    procedure SetDBDGamma(const Value: TRealStorage);
    procedure SetDBDKappa(const Value: TRealStorage);
    procedure SetDBDTheta(const Value: TRealStorage);
    procedure SetDropTolerancePreconditioning(const Value: TRealStorage);
    procedure SetFillLevel(const Value: integer);
    procedure SetFillLimit(const Value: integer);
    procedure SetFluxTolerance(const Value: TRealStorage);
    procedure SetHeadTolerance(const Value: TRealStorage);
    procedure SetIluMethod(const Value: TNewtonIluMethod);
    procedure SetInnerHeadClosureCriterion(const Value: TRealStorage);
    procedure SetLevel(const Value: integer);
    procedure SetMaxBackIterations(const Value: integer);
    procedure SetMaxGmresRestarts(const Value: integer);
    procedure SetMaxInnerIterations(const Value: integer);
    procedure SetMaxIterInner(const Value: integer);
    procedure SetMaxOuterIterations(const Value: integer);
    procedure SetMomementumCoefficient(const Value: TRealStorage);
    procedure SetNumberOfOrthogonalizations(const Value: integer);
    procedure SetOption(const Value: TNewtonOption);
    procedure SetOrderingMethod(const Value: TNewtonOrderingMethod);
    procedure SetPrintFlag(const Value: integer);
    procedure SetResidReducConv(const Value: TRealStorage);
    procedure SetSolverMethod(const Value: TNewtonSolverMethod);
    procedure SetStopTolerance(const Value: TRealStorage);
    procedure SetThicknessFactor(const Value: TRealStorage);
    procedure SetUseDropTolerance(const Value: TNewtonUseDropTolerance);
    procedure SetContinueNWT(const Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
  published
    // @name is HEADTOL.
    property HeadTolerance: TRealStorage read FHeadTolerance
      write SetHeadTolerance;
    // @name is FLUXTOL.
    property FluxTolerance: TRealStorage read FFluxTolerance
      write SetFluxTolerance;
    // @name is MAXITEROUT.
    property MaxOuterIterations: integer read FMaxOuterIterations
      write SetMaxOuterIterations stored True;
    // @name is THICKFACT.
    // range = 0 to 1;
    property ThicknessFactor: TRealStorage read FThicknessFactor
      write SetThicknessFactor;
    // @name is LINMETH.
    property SolverMethod: TNewtonSolverMethod read FSolverMethod
      write SetSolverMethod stored True;
    // @name is IPRNWT.
    property PrintFlag: integer read FPrintFlag write SetPrintFlag stored True;
    // @name is IBOTAV.
    // Zero or one.
    Property CorrectForCellBottom: integer read FCorrectForCellBottom
      write SetCorrectForCellBottom stored True;
    // @name is OPTIONS.
    property Option: TNewtonOption read FOption write SetOption stored True;
    property DBDTheta: TRealStorage read FDBDTheta write SetDBDTheta;
    property DBDKappa: TRealStorage read FDBDKappa write SetDBDKappa;
    property DBDGamma: TRealStorage read FDBDGamma write SetDBDGamma;
    // @name is MOMFACT.
    property MomementumCoefficient: TRealStorage read FMomementumCoefficient
      write SetMomementumCoefficient;
    // Zero or one.
    property BackFlag: integer read FBackFlag write SetBackFlag stored True;
    // @name is MAXBACKITER.
    property MaxBackIterations: integer read FMaxBackIterations
      write SetMaxBackIterations stored True;
    // @name is BACKTOL.
    // range = 1 to 2;
    property BackTol: TRealStorage read FBackTol write SetBackTol;
    // @name is BACKREDUCE.
    property BackReduce: TRealStorage read FBackReduce write SetBackReduce;
    // @name is MAXITINNER.
    property MaxIterInner: integer read FMaxIterInner
      write SetMaxIterInner stored True;
    // @name is ILUMETHOD.
    property IluMethod: TNewtonIluMethod read FIluMethod
      write SetIluMethod stored True;
    // @name is LEVFILL is the fill limit for ILUMETHOD = 1
    property FillLimit: integer read FFillLimit write SetFillLimit stored True;
    // @name is LEVFILL is the level of fill for ILUMETHOD = 2
    property FillLevel: integer read FFillLevel write SetFillLevel stored True;
    // @name is STOPTOL.
    property StopTolerance: TRealStorage read FStopTolerance
      write SetStopTolerance;
    // @name is MSDR.
    property MaxGmresRestarts: integer read FMaxGmresRestarts
      write SetMaxGmresRestarts stored True;
    // @name is IACL.
    property AccelMethod: TNewtonAccelMethod read FAccelMethod
      write SetAccelMethod stored True;
    // @name is NORDER.
    property OrderingMethod: TNewtonOrderingMethod read FOrderingMethod
      write SetOrderingMethod stored True;
    // @name is LEVEL.
    property Level: integer read FLevel write SetLevel stored True;
    // @name is NORTH.
    property NumberOfOrthogonalizations: integer
      read FNumberOfOrthogonalizations write SetNumberOfOrthogonalizations
      stored True;
    // @name is IREDSYS
    property ApplyReducedPrecondition: TNewtonApplyReducedPrecondition
      read FApplyReducedPrecondition write SetApplyReducedPrecondition
      stored True;
    // @name is RRCTOLS.
    property ResidReducConv: TRealStorage read FResidReducConv
      write SetResidReducConv;
    // @name is IDROPTOL.
    // IDROPTOL <> 0 means to use the drop tolerance.
    property UseDropTolerance: TNewtonUseDropTolerance read FUseDropTolerance
      write SetUseDropTolerance stored True;
    // @name is EPSRN.
    property DropTolerancePreconditioning: TRealStorage
      read FDropTolerancePreconditioning write SetDropTolerancePreconditioning;
    // @name is HCLOSEXMD.
    property InnerHeadClosureCriterion: TRealStorage
      read FInnerHeadClosureCriterion write SetInnerHeadClosureCriterion;
    // @name is MXITERXMD.
    property MaxInnerIterations: integer read FMaxInnerIterations
      write SetMaxInnerIterations stored True;
    // @name is the GOFAIL OPTION in NWT now renamed CONTINUE.
    property GoFail: Boolean read FContinueNWT
      write SetContinueNWT stored False;
    // @name is the CONTINUE OPTION in NWT.
    property ContinueNWT: Boolean read FContinueNWT write SetContinueNWT;
  end;

  TSmsComplexityOption = (scoSimple, scoModerate, scoComplex, scoSpecified);
  TSmsPrint = (spPrintNone, spSummary, spFull);
  TSmsUnderRelaxation = (surNone, surDbd, surCooley);
  TSmsLinearSolver = (slsDefault, slsXMD);
  TSmsRcloseOption = (sroAbsolute, sroL2Norm, sroRelative);
  TSmsLinLinearAcceleration = (sllaCg, sllaBiCgStab);
  TSmsXmdLinearAcceleration = (sxlaCg, sxlaOrthomin, sxlaBiCgStab);
  TSmsScalingMethod = (ssmNone, ssmDiagonal, ssmL2Norm);
  TSmsReorderingMethod = (srmNone, srmReverseCuthillMcKee,
    srmMinimumDegreeOrdering);
  TSmsOverride = (soOuterHclose, soOuterMaxIt, soUnderRelax, soUnderRelaxTheta,
    soUnderRelaxKappa, soUnderRelaxGamma, soUnderRelaxMomentum,
    soBacktrackingNumber, soBacktrackingTolerance,
    soBacktrackingReductionFactor, soBacktrackingResidualLimit, soLinearSolver,
    soInnerMaxIterations, soInnerHclose, soInnerRclose, soRcloseOption,
    soLinLinearAcceleration, soXmdLinearAcceleration, soPreconditionerLevel,
    soPreconditionerDropTolerance, soNumberOfOrthoganalizations,
    soReorderingMethod, soRelaxationFactor,
    soScalingMethod, soRedBlackOrder);
  TSmsOverrides = set of TSmsOverride;

  TSmsPackageSelection = class(TModflowPackageSelection)
  private
    FNumberOfOrthoganalizations: Integer;
    FStoredBacktrackingResidualLimit: TRealStorage;
    FComplexity: TSmsComplexityOption;
    FScalingMethod: TSmsScalingMethod;
    FBacktrackingNumber: Integer;
    FLinLinearAcceleration: TSmsLinLinearAcceleration;
    FStoredUnderRelaxMomentum: TRealStorage;
    FReorderingMethod: TSmsReorderingMethod;
    FStoredInnerRclose: TRealStorage;
    FStoredOuterHclose: TRealStorage;
    FPreconditionerLevel: Integer;
    FUnderRelaxation: TSmsUnderRelaxation;
    FStoredBacktrackingTolerance: TRealStorage;
    FStoredUnderRelaxKappa: TRealStorage;
    FStoredPreconditionerDropTolerance: TRealStorage;
    FStoredBacktrackingReductionFactor: TRealStorage;
    FStoredUnderRelaxGamma: TRealStorage;
    FStoredInnerHclose: TRealStorage;
    FRcloseOption: TSmsRcloseOption;
    FMaxOuterIterations: integer;
    FPrint: TSmsPrint;
    FStoredRelaxationFactor: TRealStorage;
    FStoredUnderRelaxTheta: TRealStorage;
    FInnerMaxIterations: integer;
    FLinearSolver: TSmsLinearSolver;
    FRedBlackOrder: boolean;
    FXmdLinearAcceleration: TSmsXmdLinearAcceleration;
    FSmsOverrides: TSmsOverrides;
    FSolutionGroupMaxIteration: Integer;
    FContinueModel: boolean;
    procedure SetBacktrackingNumber(const Value: Integer);
    procedure SetComplexity(const Value: TSmsComplexityOption);
    procedure SetInnerMaxIterations(const Value: integer);
    procedure SetLinearSolver(const Value: TSmsLinearSolver);
    procedure SetLinLinearAcceleration(const Value: TSmsLinLinearAcceleration);
    procedure SetMaxOuterIterations(const Value: integer);
    procedure SetNumberOfOrthoganalizations(const Value: Integer);
    procedure SetPreconditionerLevel(const Value: Integer);
    procedure SetPrint(const Value: TSmsPrint);
    procedure SetRcloseOption(const Value: TSmsRcloseOption);
    procedure SetRedBlackOrder(const Value: boolean);
    procedure SetReorderingMethod(const Value: TSmsReorderingMethod);
    procedure SetScalingMethod(const Value: TSmsScalingMethod);
    procedure SetStoredBacktrackingReductionFactor(const Value: TRealStorage);
    procedure SetStoredBacktrackingResidualLimit(const Value: TRealStorage);
    procedure SetStoredBacktrackingTolerance(const Value: TRealStorage);
    procedure SetStoredInnerHclose(const Value: TRealStorage);
    procedure SetStoredInnerRclose(const Value: TRealStorage);
    procedure SetStoredPreconditionerDropTolerance(
      const Value: TRealStorage);
    procedure SetStoredOuterHclose(const Value: TRealStorage);
    procedure SetStoredRelaxationFactor(const Value: TRealStorage);
    procedure SetStoredUnderRelaxGamma(const Value: TRealStorage);
    procedure SetStoredUnderRelaxKappa(const Value: TRealStorage);
    procedure SetStoredUnderRelaxMomentum(const Value: TRealStorage);
    procedure SetStoredUnderRelaxTheta(const Value: TRealStorage);
    procedure SetUnderRelaxation(const Value: TSmsUnderRelaxation);
    procedure SetXmdLinearAcceleration(const Value: TSmsXmdLinearAcceleration);
    function GetBacktrackingReductionFactor: double;
    function GetBacktrackingResidualLimit: double;
    function GetBacktrackingTolerance: double;
    function GetInnerHclose: double;
    function GetInnerRclose: double;
    function GetPreconditionerDropTolerance: double;
    function GetOuterHclose: double;
    function GetRelaxationFactor: double;
    function GetUnderRelaxGamma: double;
    function GetUnderRelaxKappa: double;
    function GetUnderRelaxMomentum: double;
    function GetUnderRelaxTheta: double;
    procedure SetBacktrackingReductionFactor(const Value: double);
    procedure SetBacktrackingResidualLimit(const Value: double);
    procedure SetBacktrackingTolerance(const Value: double);
    procedure SetInnerHclose(const Value: double);
    procedure SetInnerRclose(const Value: double);
    procedure SetPreconditionerDropTolerance(const Value: double);
    procedure SetOuterHclose(const Value: double);
    procedure SetRelaxationFactor(const Value: double);
    procedure SetUnderRelaxGamma(const Value: double);
    procedure SetUnderRelaxKappa(const Value: double);
    procedure SetUnderRelaxMomentum(const Value: double);
    procedure SetUnderRelaxTheta(const Value: double);
    procedure SetSmsOverrides(const Value: TSmsOverrides);
    procedure SetSolutionGroupMaxIteration(const Value: Integer);
    procedure SetContinueModel(const Value: boolean);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;

    property OuterHclose: double read GetOuterHclose write SetOuterHclose;
    property UnderRelaxTheta: double read GetUnderRelaxTheta
      write SetUnderRelaxTheta;
    property UnderRelaxKappa: double read GetUnderRelaxKappa
      write SetUnderRelaxKappa;
    property UnderRelaxGamma: double read GetUnderRelaxGamma
      write SetUnderRelaxGamma;
    property UnderRelaxMomentum: double read GetUnderRelaxMomentum
      write SetUnderRelaxMomentum;
    property BacktrackingTolerance: double
      read GetBacktrackingTolerance write SetBacktrackingTolerance;
    property BacktrackingReductionFactor: double
      read GetBacktrackingReductionFactor write SetBacktrackingReductionFactor;
    property BacktrackingResidualLimit: double
      read GetBacktrackingResidualLimit write SetBacktrackingResidualLimit;
    property InnerHclose: double read GetInnerHclose write SetInnerHclose;
    property InnerRclose: double read GetInnerRclose write SetInnerRclose;
    property RelaxationFactor: double read GetRelaxationFactor
      write SetRelaxationFactor;
    property PreconditionerDropTolerance: double
      read GetPreconditionerDropTolerance
      write SetPreconditionerDropTolerance;
  published
    // CONTINUE option in MODFLOW-6 Simulation Name File
    property ContinueModel: boolean read FContinueModel write SetContinueModel;
    // MIXITER in MODFLOW-6 Simulation Name File
    property SolutionGroupMaxIteration: Integer read FSolutionGroupMaxIteration
      write SetSolutionGroupMaxIteration;
    property SmsOverrides: TSmsOverrides read FSmsOverrides write SetSmsOverrides;
    // OPTIONS block

    // PRINT_OPTION
    property Print: TSmsPrint read FPrint write SetPrint;
    // COMPLEXITY
    property Complexity: TSmsComplexityOption read FComplexity
      write SetComplexity;

    // NONLINEAR block

    // OUTER_HCLOSE
    // Default for SIMPLE = 1E-4
    // Default for MODERATE = 1E-3
    // Default for COMPLEX = 0.1
    property StoredOuterHclose: TRealStorage read FStoredOuterHclose
      write SetStoredOuterHclose;
    // OUTER_MAXIMUM
    // Default for SIMPLE = 25
    // Default for MODERATE = 50
    // Default for COMPLEX = 100
    property MaxOuterIterations: integer read FMaxOuterIterations
      write SetMaxOuterIterations;
    // UNDER_RELAXATION
    // by default: not used
    // Default for COMPLEX =  used DBD?
    property UnderRelaxation: TSmsUnderRelaxation read FUnderRelaxation
      write SetUnderRelaxation;
    // UNDER_RELAXATION_THETA, reduction factor for the learning rate.
    // range 0 to 1
    // usually 0.3-0.9. Use 0.7 as default.
    // Default for COMPLEX = 0.8
    property StoredUnderRelaxTheta: TRealStorage read FStoredUnderRelaxTheta
      write SetStoredUnderRelaxTheta;
    // UNDER_RELAXATION_KAPPA, increment for the learning rate.
    // range 0 to 1
    // usual range: 0.03-0.3
    // typical: 0.1
    // Default for COMPLEX = 1E-3
    property StoredUnderRelaxKappa: TRealStorage read FStoredUnderRelaxKappa
      write SetStoredUnderRelaxKappa;
    // UNDER_RELAXATION_GAMMA, memory term factor
    // range 0 to 1
    // usual range: 0.1-0.3
    // typical: 0.2
    // Default for COMPLEX = 0
    property StoredUnderRelaxGamma: TRealStorage read FStoredUnderRelaxGamma
      write SetStoredUnderRelaxGamma;
    // UNDER_RELAXATION_MOMEMTUM
    // range 0 to 1
    // usual range: 0.0001-0.1
    // typical: 0.001
    // Default for COMPLEX = 0
    property StoredUnderRelaxMomentum: TRealStorage
      read FStoredUnderRelaxMomentum write SetStoredUnderRelaxMomentum;
    // BACKTRACKING_NUMBER
    // minumum = 0
    // usually 2-20
    // typical 10
    // Default for COMPLEX = 20
    property BacktrackingNumber: Integer read FBacktrackingNumber
      write SetBacktrackingNumber;
    // BACKTRACKING_TOLERANCE
    // typical 1 to 1E6
    // usual 1e4
    // Default for COMPLEX = 1.05
    property StoredBacktrackingTolerance: TRealStorage
      read FStoredBacktrackingTolerance write SetStoredBacktrackingTolerance;
    // BACKTRACKING_REDUCTION_FACTOR
    // range 0 to 1
    // typical 0.1-0.3
    // usual 0.2
    // Default for COMPLEX = 0.1
    property StoredBacktrackingReductionFactor: TRealStorage
      read FStoredBacktrackingReductionFactor
      write SetStoredBacktrackingReductionFactor;
    // BACKTRACKING_RESIDUAL_LIMIT
    // usual 100
    // Default for COMPLEX = 0.002
    property StoredBacktrackingResidualLimit: TRealStorage
      read FStoredBacktrackingResidualLimit
      write SetStoredBacktrackingResidualLimit;
    // LINEAR_SOLVER
    // Default for SIMPLE = SMSLINEAR
    // Default for MODERATE = SMSLINEAR
    // Default for COMPLEX = SMSLINEAR
    property LinearSolver: TSmsLinearSolver read FLinearSolver
      write SetLinearSolver;

    // Variables used in both LINEAR and XMD block with the same
    // meaning and recommended values in both.

    // INNER_MAXIMUM, maximum number of inner iterations
    // typical: 60-600
    // usual: 100
    // Default for SIMPLE = 50
    // Default for MODERATE = 100
    // Default for COMPLEX = 500
    property InnerMaxIterations: integer read FInnerMaxIterations
      write SetInnerMaxIterations;
    // INNER_HCLOSE
    // typically 1 order of magnitude less than StoredOuterHclose
    // Default for SIMPLE = 0.60135-153.
    // Default for MODERATE = 0.60135-153.
    // Default for COMPLEX = 0.60135-153.
    property StoredInnerHclose: TRealStorage read FStoredInnerHclose
      write SetStoredInnerHclose;
    // INNER_RCLOSE
    // typical = 0.1 if units are meters and seconds
    // and RcloseOption = sroL2Norm.
    // typical = 1e-4 if units are meters and seconds
    // and RcloseOption = sroRelativeRclose.
    // In XMD, typically set to 0
    // Default for SIMPLE = 0.1.
    // Default for MODERATE = 0.1
    // Default for COMPLEX = 0.1
    property StoredInnerRclose: TRealStorage read FStoredInnerRclose
      write SetStoredInnerRclose;
    // LINEAR_ACCELERATION
    // Default for SIMPLE = CG
    // Default for MODERATE = CG
    // Default for COMPLEX = CG
    property LinLinearAcceleration: TSmsLinLinearAcceleration
      read FLinLinearAcceleration write SetLinLinearAcceleration;
    // PRECONDITIONER_LEVELS
    // Default for SIMPLE = 0
    // Default for MODERATE = 0
    // Default for COMPLEX = 0
    property PreconditionerLevel: Integer read FPreconditionerLevel
      write SetPreconditionerLevel;
    // NUMBER_ORTHOGANALIZATIONS
    // usually 4-10
    // default 0
    // Default for SIMPLE = 0
    // Default for MODERATE = 0
    // Default for COMPLEX = 2
    property NumberOfOrthoganalizations: Integer
      read FNumberOfOrthoganalizations write SetNumberOfOrthoganalizations;
    // REORDERING_METHOD
    // Default for SIMPLE = ORIGINAL ORDERING
    // Default for MODERATE = ORIGINAL ORDERING
    // Default for COMPLEX = ORIGINAL ORDERING
    property ReorderingMethod: TSmsReorderingMethod read FReorderingMethod
      write SetReorderingMethod;
    // PRECONDITIONER_DROP_TOLERANCE
    // Typical 1e-4
    // Default for SIMPLE = 0
    // Default for MODERATE = 0
    // Default for COMPLEX = 0
    property StoredPreconditionerDropTolerance: TRealStorage
      read FStoredPreconditionerDropTolerance
      write SetStoredPreconditionerDropTolerance;

    // LINEAR block. Variables in the Linear block are only used if
    // LinearSolver = slsDefault

    // rcloseoption
    // default = sroAbsolute. If this option is selected the keyword is not
    // printed.
    // Default for COMPLEX = 0
    property RcloseOption: TSmsRcloseOption read FRcloseOption
      write SetRcloseOption;
    // RELAXATION_FACTOR
    // Range 0-1
    // typical 0
    // Default for SIMPLE = 0
    // Default for MODERATE = 0.97
    // Default for COMPLEX = 0
    property StoredRelaxationFactor: TRealStorage read FStoredRelaxationFactor
      write SetStoredRelaxationFactor;
    // SCALING_METHOD
    // Default for SIMPLE = no scaling
    // Default for MODERATE = no scaling
    // Default for COMPLEX = no scaling
    property ScalingMethod: TSmsScalingMethod read FScalingMethod
      write SetScalingMethod;

    // XMD block. Variables in the XMD block are only used if
    // LinearSolver = slsXMD

    // LINEAR_ACCELERATION
    property XmdLinearAcceleration: TSmsXmdLinearAcceleration
      read FXmdLinearAcceleration write SetXmdLinearAcceleration;
    // RED_BLACK_ORDERING
    property RedBlackOrder: boolean read FRedBlackOrder write SetRedBlackOrder;
  end;

  TLayerOption = (loTop, loSpecified, loTopActive);

  // @name is used for MODFLOW packages in which
  // the user specifies an array of layer numbers
  // to which the package applies.
  TCustomLayerPackageSelection = class(TModflowPackageSelection)
  private
    FLayerOption: TLayerOption;
    FOnLayerChoiceChange: TNotifyEvent;
    procedure SetLayerOption(const Value: TLayerOption);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    procedure Assign(Source: TPersistent); override;
    property OnLayerChoiceChange: TNotifyEvent read FOnLayerChoiceChange
      write FOnLayerChoiceChange;
  published
    property LayerOption: TLayerOption read FLayerOption
      write SetLayerOption;
  end;

  // @name is used for MODFLOW boundary conditions packages in which,
  // for each stress period, the user specifies an array of layer numbers
  // to which the boundary condition applies.
  TCustomTransientLayerPackageSelection = class(TCustomLayerPackageSelection)
  private
    FTimeVaryingLayers: boolean;
    function GetTimeVaryingLayers: boolean;
    procedure SetTimeVaryingLayers(const Value: boolean);
  protected
    FMultiplierArrayNames: TTransientMultCollection;
    FZoneArrayNames: TTransientZoneCollection;
    procedure UpdateWithElevationFormula(Formula: string;
      ScreenObject: TScreenObject; NewUseList: TStringList);
    procedure SetMultiplierArrayNames(const Value: TTransientMultCollection);
    procedure SetZoneArrayNames(const Value: TTransientZoneCollection);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
  published
    property TimeVaryingLayers: boolean read GetTimeVaryingLayers
      write SetTimeVaryingLayers;
    property MultiplierArrayNames: TTransientMultCollection
      read FMultiplierArrayNames write SetMultiplierArrayNames;
    property ZoneArrayNames: TTransientZoneCollection read FZoneArrayNames
      write SetZoneArrayNames;
  end;

  TEvtPackageSelection = class(TCustomTransientLayerPackageSelection)
  private
    FMfEvtEvapDepth: TModflowBoundaryDisplayTimeList;
    FMfEvtEvapLayer: TModflowBoundaryDisplayTimeList;
    FMfEvtEvapRate: TModflowBoundaryDisplayTimeList;
    FMfEvtEvapSurface: TModflowBoundaryDisplayTimeList;
    procedure GetMfEvtDepthUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfEvtLayerUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfEvtRateUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfEvtSurfaceUseList(Sender: TObject; NewUseList: TStringList);
    procedure InitializeEvtDisplay(Sender: TObject);
    procedure UpdateEvtUseList(NewUseList: TStringList;
      ParamType: TParameterType; DataIndex: integer; const DisplayName: string);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InvalidateAllTimeLists; override;
    property MfEvtEvapDepth: TModflowBoundaryDisplayTimeList
      read FMfEvtEvapDepth;
    property MfEvtEvapLayer: TModflowBoundaryDisplayTimeList
      read FMfEvtEvapLayer;
    property MfEvtEvapRate: TModflowBoundaryDisplayTimeList
      read FMfEvtEvapRate;
    property MfEvtEvapSurface: TModflowBoundaryDisplayTimeList
      read FMfEvtEvapSurface;
    procedure InvalidateMfEvtEvapLayer(Sender: TObject);
  end;

  TRchPackageSelection = class(TCustomTransientLayerPackageSelection)
  private
    FMfRchLayer: TModflowBoundaryDisplayTimeList;
    FMfRchRate: TModflowBoundaryDisplayTimeList;
    FAssignmentMethod: TUpdateMethod;
    procedure GetMfRchRateUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfRchLayerUseList(Sender: TObject; NewUseList: TStringList);
    procedure InitializeRchDisplay(Sender: TObject);
    procedure SetAssignmentMethod(const Value: TUpdateMethod);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfRchRate: TModflowBoundaryDisplayTimeList read FMfRchRate;
    property MfRchLayer: TModflowBoundaryDisplayTimeList read FMfRchLayer;
    procedure InvalidateAllTimeLists; override;
    procedure InvalidateMfRchLayer(Sender: TObject);
  published
    property AssignmentMethod: TUpdateMethod read FAssignmentMethod
      write SetAssignmentMethod Stored True;
  end;

  TEtsPackageSelection = class(TCustomTransientLayerPackageSelection)
  private
    FSegmentCount: integer;
    FEtsRateFractionLists: TList;
    FEtsDepthFractionLists: TList;
    FMfEtsEvapLayer: TModflowBoundaryDisplayTimeList;
    FMfEtsEvapRate: TModflowBoundaryDisplayTimeList;
    FMfEtsEvapDepth: TModflowBoundaryDisplayTimeList;
    FMfEtsEvapSurface: TModflowBoundaryDisplayTimeList;
    procedure SetSegmentCount(const Value: integer);
    procedure InitializeEtsDisplay(Sender: TObject);
    procedure GetMfEtsDepthUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfEtsLayerUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfEtsRateUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfEtsSurfaceUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfEtsDepthFractionUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfEtsRateFractionUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure UpdateEtsUseList(NewUseList: TStringList;
      ParamType: TParameterType; DataIndex: integer; const DisplayName: string);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfEtsEvapRate: TModflowBoundaryDisplayTimeList
      read FMfEtsEvapRate;
    property MfEtsEvapSurface: TModflowBoundaryDisplayTimeList
      read FMfEtsEvapSurface;
    property MfEtsEvapDepth: TModflowBoundaryDisplayTimeList
      read FMfEtsEvapDepth;
    property MfEtsEvapLayer: TModflowBoundaryDisplayTimeList
      read FMfEtsEvapLayer;
    procedure InvalidateMfEtsEvapLayer(Sender: TObject);
    procedure InvalidateEtsDepthFractions(Sender: TObject);
    procedure InvalidateEtsRateFractions(Sender: TObject);
    procedure UpdateEtsSegmentCount;
    procedure InvalidateAllTimeLists; override;
  published
    property SegmentCount: integer read FSegmentCount
      write SetSegmentCount default 1;
  end;

  TResPackageSelection = class(TCustomTransientLayerPackageSelection)
  private
    FPrintStage: boolean;
    FTableStages: integer;
    procedure SetPrintStage(const Value: boolean);
    procedure SetTableStages(const Value: integer);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
  published
    property PrintStage: boolean read FPrintStage
      write SetPrintStage default True;
    property TableStages: integer read FTableStages
      write SetTableStages default 15;
  end;

  TExternalLakeChoice = (elcNone, elcAll);

  TLakePackageSelection = class(TModflowPackageSelection)
  private
    FPrintLakes: boolean;
    FNumberOfIterations: integer;
    FConvergenceCriterion: double;
    FTheta: double;
    FSurfDepth: TRealStorage;
    FExternalLakeChoice: TExternalLakeChoice;
    procedure SetConvergenceCriterion(const Value: double);
    procedure SetNumberOfIterations(const Value: integer);
    procedure SetPrintLakes(const Value: boolean);
    procedure SetTheta(const Value: double);
    procedure SetSurfDepth(const Value: TRealStorage);
    procedure SetExternalLakeChoice(const Value: TExternalLakeChoice);
  protected
    procedure SetIsSelected(const Value: boolean); override;
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    procedure InitializeVariables; override;
  published
    property ConvergenceCriterion: double read FConvergenceCriterion
      write SetConvergenceCriterion;
    property NumberOfIterations: integer read FNumberOfIterations
      write SetNumberOfIterations default 100;
    property PrintLakes: boolean read FPrintLakes write SetPrintLakes
      default True;
    property Theta: double read FTheta write SetTheta;
    property SurfDepth: TRealStorage read FSurfDepth write SetSurfDepth;
    property ExternalLakeChoice: TExternalLakeChoice read FExternalLakeChoice
      write SetExternalLakeChoice;
  end;

  TSfrParamInstance = class(TOrderedItem)
  private
    FStartTime: double;
    FEndTime: double;
    FParameterInstance: string;
    FParameterName: string;
    procedure SetEndTime(const Value: double);
    procedure SetParameterInstance(const Value: string);
    procedure SetParameterName(const Value: string);
    procedure SetStartTime(const Value: double);
  protected
    function IsSame(AnotherItem: TOrderedItem): boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ParameterName: string read FParameterName write SetParameterName;
    property ParameterInstance: string read FParameterInstance
      write SetParameterInstance;
    property StartTime: double read FStartTime write SetStartTime;
    property EndTime: double read FEndTime write SetEndTime;
  end;

  TSfrParamInstances = class(TOrderedCollection)
  private
    function GetItems(Index: integer): TSfrParamInstance;
    procedure SetItems(Index: integer; const Value: TSfrParamInstance);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    constructor Create(Model: TBaseModel);
    property Items[Index: integer]: TSfrParamInstance read GetItems
      write SetItems;
    function ParameterInstanceExists
     (const ParamName, InstaName: string): boolean;
    procedure DeleteInstancesOfParameter(const ParamName: string);
    procedure UpdateParamName(const OldParamName, NewParamName: string);
  end;

  TPrintFlows = (pfNoPrint, pfListing, pfText);

  TStrPackageSelection = class(TModflowPackageSelection)
  private
    FCalculateStage: Boolean;
    FMfStrBedTopElevation: TModflowBoundaryDisplayTimeList;
    FMfStrBedBottomElevation: TModflowBoundaryDisplayTimeList;
    FMfStrStage: TModflowBoundaryDisplayTimeList;
    FMfStrConductance: TModflowBoundaryDisplayTimeList;
    FMfStrFlow: TModflowBoundaryDisplayTimeList;
    FMfStrRoughness: TModflowBoundaryDisplayTimeList;
    FMfStrSlope: TModflowBoundaryDisplayTimeList;
    FMfStrWidth: TModflowBoundaryDisplayTimeList;
    FMfStrSegmentNumber: TModflowBoundaryDisplayTimeList;
    FMfStrReachNumber: TModflowBoundaryDisplayTimeList;
    FMfStrOutflowSegmentNumber: TModflowBoundaryDisplayTimeList;
    FMfStrDiversionSegmentNumber: TModflowBoundaryDisplayTimeList;
    procedure SetCalculateStage(const Value: Boolean);
    procedure InitializeStrDisplay(Sender: TObject);
    procedure GetMfStrConductanceUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfStrBedTopElevationUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfStrBedBottomElevationUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfStrStageUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfStrFlowUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfStrWidthUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfStrSlopeUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfStrRoughnessUseList(Sender: TObject;
      NewUseList: TStringList);
    function StageUsed(Sender: TObject): boolean;
    procedure GetMfStrUseList(Sender: TObject; NewUseList: TStringList);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfStrConductance: TModflowBoundaryDisplayTimeList
      read FMfStrConductance;
    property MfStrBedTopElevation: TModflowBoundaryDisplayTimeList
      read FMfStrBedTopElevation;
    property MfStrBedBottomElevation: TModflowBoundaryDisplayTimeList
      read FMfStrBedBottomElevation;
    property MfStrStage: TModflowBoundaryDisplayTimeList
      read FMfStrStage;
    property MfStrFlow: TModflowBoundaryDisplayTimeList
      read FMfStrFlow;
    property MfStrWidth: TModflowBoundaryDisplayTimeList
      read FMfStrWidth;
    property MfStrSlope: TModflowBoundaryDisplayTimeList
      read FMfStrSlope;
    property MfStrRoughness: TModflowBoundaryDisplayTimeList
      read FMfStrRoughness;
    property MfStrSegmentNumber: TModflowBoundaryDisplayTimeList
      read FMfStrSegmentNumber;
    property MfStrReachNumber: TModflowBoundaryDisplayTimeList
      read FMfStrReachNumber;
    property MfStrOutflowSegmentNumber: TModflowBoundaryDisplayTimeList
      read FMfStrOutflowSegmentNumber;
    property MfStrDiversionSegmentNumber: TModflowBoundaryDisplayTimeList
      read FMfStrDiversionSegmentNumber;

    procedure InvalidateAllTimeLists; override;
    procedure InitializeVariables; override;
  published
    // ICALC
    property CalculateStage: Boolean read FCalculateStage
      write SetCalculateStage;
  end;

  TSfrPackageSelection = class(TModflowPackageSelection)
  private
    FNstrail: integer;
    FNsfrsets: integer;
    FIsuzn: integer;
    FDleak: double;
    FIsfropt: integer;
    FPrintStreams: boolean;
    FParameterInstances: TSfrParamInstances;
    FAssignParameterInstances: boolean;
    FKinematicRouting: boolean;
    FTimeStepsForKinematicRouting: integer;
    FKinematicRoutingTolerance: double;
    FKinematicRoutingWeight: double;
    FMfSfrDownstreamHydraulicConductivity: TModflowBoundaryDisplayTimeList;
    FMfSfrWidthExponent: TModflowBoundaryDisplayTimeList;
    FMfSfrDiversionSegment: TModflowBoundaryDisplayTimeList;
    FMfSfrVerticalUnsatK: TModflowBoundaryDisplayTimeList;
    FMfSfrInitialWaterContent: TModflowBoundaryDisplayTimeList;
    FMfSfrUpstreamUnsatInitialWaterContent: TModflowBoundaryDisplayTimeList;
    FMfSfrSaturatedWaterContent: TModflowBoundaryDisplayTimeList;
    FMfSfrReachLength: TModflowBoundaryDisplayTimeList;
    FMfSfrSegmentNumber: TModflowBoundaryDisplayTimeList;
    FMfSfrUpstreamUnsaturatedWaterContent: TModflowBoundaryDisplayTimeList;
    FMfSfrDownstreamBrooksCorey: TModflowBoundaryDisplayTimeList;
    FMfSfrBankRoughness: TModflowBoundaryDisplayTimeList;
    FMfSfrUpstreamHydraulicConductivity: TModflowBoundaryDisplayTimeList;
    FMfSfrDepthCoefficient: TModflowBoundaryDisplayTimeList;
    FMfSfrDepthExponent: TModflowBoundaryDisplayTimeList;
    FMfSfrBrooksCorey: TModflowBoundaryDisplayTimeList;
    FMfSfrIcalc: TModflowBoundaryDisplayTimeList;
    FMfSfrUpstreamBrooksCorey: TModflowBoundaryDisplayTimeList;
    FMfSfrDownstreamThickness: TModflowBoundaryDisplayTimeList;
    FMfSfrDownstreamWidth: TModflowBoundaryDisplayTimeList;
    FMfSfrStreamTop: TModflowBoundaryDisplayTimeList;
    FMfSfrOutSegment: TModflowBoundaryDisplayTimeList;
    FMfSfrDownstreamElevation: TModflowBoundaryDisplayTimeList;
    FMfSfrDownstreamUnsatKz: TModflowBoundaryDisplayTimeList;
    FMfSfrUpstreamThickness: TModflowBoundaryDisplayTimeList;
    FMfSfrUpstreamWidth: TModflowBoundaryDisplayTimeList;
    FMfSfrStreamK: TModflowBoundaryDisplayTimeList;
    FMfSfrEvapotranspiration: TModflowBoundaryDisplayTimeList;
    FMfSfrReachNumber: TModflowBoundaryDisplayTimeList;
    FMfSfrDownstreamDepth: TModflowBoundaryDisplayTimeList;
    FMfSfrUpstreamElevation: TModflowBoundaryDisplayTimeList;
    FMfSfrIprior: TModflowBoundaryDisplayTimeList;
    FMfSfrUpstreamUnsatKz: TModflowBoundaryDisplayTimeList;
    FMfSfrPrecipitation: TModflowBoundaryDisplayTimeList;
    FMfSfrFlow: TModflowBoundaryDisplayTimeList;
    FMfSfrDownstreamUnsatInitialWaterContent: TModflowBoundaryDisplayTimeList;
    FMfSfrRunoff: TModflowBoundaryDisplayTimeList;
    FMfSfrStreamSlope: TModflowBoundaryDisplayTimeList;
    FMfSfrDownstreamUnsaturatedWaterContent: TModflowBoundaryDisplayTimeList;
    FMfSfrUpstreamDepth: TModflowBoundaryDisplayTimeList;
    FMfSfrWidthCoefficient: TModflowBoundaryDisplayTimeList;
    FMfSfrChannelRoughness: TModflowBoundaryDisplayTimeList;
    FMfSfrStreamThickness: TModflowBoundaryDisplayTimeList;
    FPrintFlows: TPrintFlows;
    FGageOverallBudget: boolean;
    FUseGsflowFormat: boolean;
    FLossFactorOption: boolean;
    FStoredLossFactor: TRealStorage;
    procedure SetDleak(const Value: double);
    procedure SetIsfropt(const Value: integer);
    procedure SetIsuzn(const Value: integer);
    procedure SetNsfrsets(const Value: integer);
    procedure SetNstrail(const Value: integer);
    procedure SetPrintStreams(const Value: boolean);
    procedure SetParameterInstances(const Value: TSfrParamInstances);
    procedure SetKinematicRouting(const Value: boolean);
    procedure SetKinematicRoutingTolerance(const Value: double);
    procedure SetTimeStepsForKinematicRouting(const Value: integer);
    procedure SetKinematicRoutingWeight(const Value: double);
    procedure InitializeSfrDisplay(Sender: TObject);
    // @name is an empty procedure used for SFR segment numbers, reach numbers
    // and ICALC.  None of those can depend on any data set so the Use-List for
    // them should be empty.
    procedure GetMfSfrUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfSfrReachLengthUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrReachUseList(DataIndex: integer; NewUseList: TStringList);
    procedure GetMfSfrStreamTopUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrStreamSlopeUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrStreamThicknessUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrStreamKUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfSfrStreamSatWatContentUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrStreamInitialWatContentUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrBrooksCoreyUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUnsatKzUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfSfrFlowUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfSfrFlowItemUseList(DataIndex: integer;
      NewUseList: TStringList);
    procedure GetMfSfrRunoffUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfSfrPrecipitationUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrEvapotranspirationUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrChannelRoughnessUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrChanelItemUseList(DataIndex: integer;
      NewUseList: TStringList);
    procedure GetMfSfrBankRoughnessUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDepthCoefficientUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrEquationItemUseList(DataIndex: integer;
      NewUseList: TStringList);
    procedure GetMfSfrDepthExponentUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrWidthCoefficientUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrWidthExponentUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamHydraulicConductivityUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamItemUseList(DataIndex: integer;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamHydraulicConductivityUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamItemUseList(DataIndex: integer;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamWidthUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamWidthUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamThicknessUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamThicknessUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamElevationUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamElevationUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamDepthUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamDepthUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamSatWatContentUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamUnsatItemUseList(DataIndex: integer;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamSatWatContentUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamUnsatItemUseList(DataIndex: integer;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamInitialWatContentUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamInitialWatContentUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamBrooksCoreyUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamBrooksCoreyUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrUpstreamUnsatKzUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfSfrDownstreamUnsatKzUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure SetPrintFlows(const Value: TPrintFlows);
    procedure SetGageOverallBudget(const Value: boolean);
    procedure SetUseGsflowFormat(const Value: boolean);
    function GetLossFactor: double;
    procedure SetLossFactor(const Value: double);
    procedure SetLossFactorOption(const Value: boolean);
    procedure SetStoredLossFactor(const Value: TRealStorage);
  protected
    procedure SetIsSelected(const Value: boolean); override;
  public
    procedure InitializeVariables; override;
    procedure ComputeAverages(List: TModflowBoundListOfTimeLists);
    procedure GetDisplayLists(List: TModflowBoundListOfTimeLists);
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    Function StreamConstant: double;
    property AssignParameterInstances: boolean read FAssignParameterInstances
      write FAssignParameterInstances;
    property MfSfrSegmentNumber: TModflowBoundaryDisplayTimeList
      read FMfSfrSegmentNumber;
    property MfSfrReachNumber: TModflowBoundaryDisplayTimeList
      read FMfSfrReachNumber;
    property MfSfrIcalc: TModflowBoundaryDisplayTimeList read FMfSfrIcalc;
    property MfSfrReachLength: TModflowBoundaryDisplayTimeList
      read FMfSfrReachLength;
    property MfSfrStreamTop : TModflowBoundaryDisplayTimeList
      read FMfSfrStreamTop;
    property MfSfrStreamSlope : TModflowBoundaryDisplayTimeList
      read FMfSfrStreamSlope;
    property MfSfrStreamThickness : TModflowBoundaryDisplayTimeList
      read FMfSfrStreamThickness;
    property MfSfrStreamK : TModflowBoundaryDisplayTimeList
      read FMfSfrStreamK;
    property MfSfrSaturatedWaterContent : TModflowBoundaryDisplayTimeList
      read FMfSfrSaturatedWaterContent;
    property MfSfrInitialWaterContent : TModflowBoundaryDisplayTimeList
      read FMfSfrInitialWaterContent;
    property MfSfrBrooksCorey : TModflowBoundaryDisplayTimeList
      read FMfSfrBrooksCorey;
    property MfSfrVerticalUnsatK : TModflowBoundaryDisplayTimeList
      read FMfSfrVerticalUnsatK;
    property MfSfrOutSegment : TModflowBoundaryDisplayTimeList
      read FMfSfrOutSegment;
    property MfSfrDiversionSegment : TModflowBoundaryDisplayTimeList
      read FMfSfrDiversionSegment;
    property MfSfrIprior: TModflowBoundaryDisplayTimeList read FMfSfrIprior;
    property MfSfrFlow: TModflowBoundaryDisplayTimeList read FMfSfrFlow;
    property MfSfrRunoff: TModflowBoundaryDisplayTimeList read FMfSfrRunoff;
    property MfSfrPrecipitation: TModflowBoundaryDisplayTimeList
      read FMfSfrPrecipitation;
    property MfSfrEvapotranspiration: TModflowBoundaryDisplayTimeList
      read FMfSfrEvapotranspiration;
    property MfSfrChannelRoughness: TModflowBoundaryDisplayTimeList
      read FMfSfrChannelRoughness;
    property MfSfrBankRoughness: TModflowBoundaryDisplayTimeList
      read FMfSfrBankRoughness;
    property MfSfrDepthCoefficient: TModflowBoundaryDisplayTimeList
      read FMfSfrDepthCoefficient;
    property MfSfrDepthExponent: TModflowBoundaryDisplayTimeList
      read FMfSfrDepthExponent;
    property MfSfrWidthCoefficient: TModflowBoundaryDisplayTimeList
      read FMfSfrWidthCoefficient;
    property MfSfrWidthExponent: TModflowBoundaryDisplayTimeList
      read FMfSfrWidthExponent;
    property MfSfrUpstreamHydraulicConductivity: TModflowBoundaryDisplayTimeList
      read FMfSfrUpstreamHydraulicConductivity;
    property MfSfrDownstreamHydraulicConductivity:
      TModflowBoundaryDisplayTimeList
      read FMfSfrDownstreamHydraulicConductivity;
    property MfSfrUpstreamWidth: TModflowBoundaryDisplayTimeList
      read FMfSfrUpstreamWidth;
    property MfSfrDownstreamWidth: TModflowBoundaryDisplayTimeList
      read FMfSfrDownstreamWidth;
    property MfSfrUpstreamThickness: TModflowBoundaryDisplayTimeList
      read FMfSfrUpstreamThickness;
    property MfSfrDownstreamThickness: TModflowBoundaryDisplayTimeList
      read FMfSfrDownstreamThickness;
    property MfSfrUpstreamElevation: TModflowBoundaryDisplayTimeList
      read FMfSfrUpstreamElevation;
    property MfSfrDownstreamElevation: TModflowBoundaryDisplayTimeList
      read FMfSfrDownstreamElevation;
    property MfSfrUpstreamDepth: TModflowBoundaryDisplayTimeList
      read FMfSfrUpstreamDepth;
    property MfSfrDownstreamDepth: TModflowBoundaryDisplayTimeList
      read FMfSfrDownstreamDepth;
    property MfSfrUpstreamUnsaturatedWaterContent:
      TModflowBoundaryDisplayTimeList
      read FMfSfrUpstreamUnsaturatedWaterContent;
    property MfSfrDownstreamUnsaturatedWaterContent:
      TModflowBoundaryDisplayTimeList
      read FMfSfrDownstreamUnsaturatedWaterContent;
    property MfSfrUpstreamUnsatInitialWaterContent:
      TModflowBoundaryDisplayTimeList
      read FMfSfrUpstreamUnsatInitialWaterContent;
    property MfSfrDownstreamUnsatInitialWaterContent:
      TModflowBoundaryDisplayTimeList
      read FMfSfrDownstreamUnsatInitialWaterContent;
    property MfSfrUpstreamBrooksCorey: TModflowBoundaryDisplayTimeList
      read FMfSfrUpstreamBrooksCorey;
    property MfSfrDownstreamBrooksCorey: TModflowBoundaryDisplayTimeList
      read FMfSfrDownstreamBrooksCorey;
    property MfSfrUpstreamUnsatKz: TModflowBoundaryDisplayTimeList
      read FMfSfrUpstreamUnsatKz;
    property MfSfrDownstreamUnsatKz: TModflowBoundaryDisplayTimeList
      read FMfSfrDownstreamUnsatKz;
    procedure InvalidateMfSfrSegmentReachAndIcalc(Sender: TObject);
    procedure InvalidateAllTimeLists; override;
    function ModflowSfrSpatialVariationSelected(Sender: TObject): boolean;
    function ModflowSfrUnsatSpatialVariationSelected(Sender: TObject): boolean;
    function ModflowSfrUnsatKzSpatialVariationSelected(
      Sender: TObject): boolean;
    function ModflowSfrUpstreamDownstreamUsed(Sender: TObject): boolean;
    function ModflowSfrUpstreamDownstreamUnsatUsed(Sender: TObject): boolean;
    function ModflowSfrUpstreamDownstreamUnsatKzUsed(Sender: TObject): boolean;
    property LossFactor: double read GetLossFactor write SetLossFactor;
  published
    property Dleak: double read FDleak write SetDleak;
    property Isfropt: integer read FIsfropt write SetIsfropt;
    property Nstrail: integer read FNstrail write SetNstrail;
    property Isuzn: integer read FIsuzn write SetIsuzn;
    property Nsfrsets: integer read FNsfrsets write SetNsfrsets;
    // @name is for backwards compatibility.
    // PrintStreams is no longer used as of version 2.0.0.10.
    property PrintStreams: boolean read FPrintStreams
      write SetPrintStreams Stored False;
    property PrintFlows: TPrintFlows read FPrintFlows write SetPrintFlows
      default pfListing;
    property ParameterInstances: TSfrParamInstances read FParameterInstances
      write SetParameterInstances stored FIsSelected;
    property KinematicRouting: boolean read FKinematicRouting
      write SetKinematicRouting;
    property TimeStepsForKinematicRouting: integer
      read FTimeStepsForKinematicRouting write SetTimeStepsForKinematicRouting
      default 1;
    property KinematicRoutingTolerance: double read FKinematicRoutingTolerance
      write SetKinematicRoutingTolerance;
    property KinematicRoutingWeight: double read FKinematicRoutingWeight
      write SetKinematicRoutingWeight stored True;
    property GageOverallBudget: boolean read FGageOverallBudget
      write SetGageOverallBudget;
    property UseGsflowFormat: boolean read FUseGsflowFormat
      write SetUseGsflowFormat;
    // LOSSFACTOR
    property LossFactorOption: boolean read FLossFactorOption
      write SetLossFactorOption;
    // factor
    property StoredLossFactor: TRealStorage read FStoredLossFactor
      write SetStoredLossFactor;
  end;

  TUzfPackageSelection = class(TCustomLayerPackageSelection)
  private
    FSimulateET: boolean;
    FNumberOfWaveSets: integer;
    FRouteDischargeToStreams: boolean;
    FVerticalKSource: integer;
    FNumberOfTrailingWaves: integer;
    FPrintSummary: integer;
    FDepthOfUndulations: double;
    FMfUzfInfiltration: TModflowBoundaryDisplayTimeList;
    FMfUzfExtinctionDepth: TModflowBoundaryDisplayTimeList;
    FMfUzfWaterContent: TModflowBoundaryDisplayTimeList;
    FMfUzfEtDemand: TModflowBoundaryDisplayTimeList;
    FAssignmentMethod: TUpdateMethod;
    FSpecifyResidualWaterContent: boolean;
    FCalulateSurfaceLeakage: boolean;
    FSpecifyInitialWaterContent: boolean;
    FStoredSmoothFactor: TRealStorage;
    FETSmoothed: boolean;
    FWriteRechargeAndDischarge: boolean;
    FSurfaceKUsedToCalculateSeepage: boolean;
    FSurfaceKUsedToCalculateRejection: boolean;
//    FSpecifySurfaceK: boolean;
    procedure SetNumberOfTrailingWaves(const Value: integer);
    procedure SetNumberOfWaveSets(const Value: integer);
    procedure SetRouteDischargeToStreams(const Value: boolean);
    procedure SetSimulateET(const Value: boolean);
    procedure SetVerticalKSource(const Value: integer);
    procedure SetPrintSummary(const Value: integer);
    procedure SetDepthOfUndulations(const Value: double);
    procedure InitializeUzfDisplay(Sender: TObject);
    procedure GetMfUzfInfiltrationUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfUzfExtinctionDepthUseList(Sender: TObject;
      NewUseList: TStringList);
    function ModflowUztEtSimulated(Sender: TObject): boolean;
    procedure GetMfUzfEtDemandUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfUzfWaterContentUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure SetAssignmentMethod(const Value: TUpdateMethod);
    procedure SetCalulateSurfaceLeakage(const Value: boolean);
    procedure SetSpecifyInitialWaterContent(const Value: boolean);
    procedure SetSpecifyResidualWaterContent(const Value: boolean);
    procedure SetETSmoothed(const Value: boolean);
//    procedure SetSpecifySurfaceK(const Value: boolean);
    procedure SetStoredSmoothFactor(const Value: TRealStorage);
    procedure SetSurfaceKUsedToCalculateRejection(const Value: boolean);
    procedure SetSurfaceKUsedToCalculateSeepage(const Value: boolean);
    procedure SetWriteRechargeAndDischarge(const Value: boolean);
    function GetSmoothFactor: double;
    procedure SetSmoothFactor(const Value: double);
    function GetSpecifySurfaceK: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property MfUzfInfiltration: TModflowBoundaryDisplayTimeList
      read FMfUzfInfiltration;
    property MfUzfEtDemand: TModflowBoundaryDisplayTimeList
      read FMfUzfEtDemand;
    property MfUzfExtinctionDepth: TModflowBoundaryDisplayTimeList
      read FMfUzfExtinctionDepth;
    property MfUzfWaterContent: TModflowBoundaryDisplayTimeList
      read FMfUzfWaterContent;
    procedure InvalidateAllTimeLists; override;
    procedure InitializeVariables; override;
    // smoothfact
    property SmoothFactor: double read GetSmoothFactor write SetSmoothFactor;
    property SpecifySurfaceK: Boolean read GetSpecifySurfaceK;
  published
    property VerticalKSource: integer read FVerticalKSource
      write SetVerticalKSource;
    property RouteDischargeToStreams: boolean read FRouteDischargeToStreams
      write SetRouteDischargeToStreams;
    property SimulateET: boolean read FSimulateET write SetSimulateET;
    property NumberOfTrailingWaves: integer read FNumberOfTrailingWaves
      write SetNumberOfTrailingWaves;
    property NumberOfWaveSets: integer read FNumberOfWaveSets
      write SetNumberOfWaveSets;
    // IFTUNIT
    property PrintSummary: integer read FPrintSummary write SetPrintSummary;
    property DepthOfUndulations: double read FDepthOfUndulations
      write SetDepthOfUndulations;
    property AssignmentMethod: TUpdateMethod read FAssignmentMethod
      write SetAssignmentMethod stored True;
    // SPECIFYTHTR
    property SpecifyResidualWaterContent: boolean
      read FSpecifyResidualWaterContent write SetSpecifyResidualWaterContent;
    // SPECIFYTHTI
    property SpecifyInitialWaterContent: boolean
      read FSpecifyInitialWaterContent write SetSpecifyInitialWaterContent;
    // inverse of NOSURFLEAK
    property CalulateSurfaceLeakage: boolean read FCalulateSurfaceLeakage
      write SetCalulateSurfaceLeakage default True;
    // new options in MODFLOW-NWT version 1.1.
    // REJECTSURFK and SPECIFYSURFK
    property SurfaceKUsedToCalculateRejection: boolean
      read FSurfaceKUsedToCalculateRejection
      write SetSurfaceKUsedToCalculateRejection;
    // SEEPSURFK and SPECIFYSURFK
    property SurfaceKUsedToCalculateSeepage: boolean
      read FSurfaceKUsedToCalculateSeepage
      write SetSurfaceKUsedToCalculateSeepage;
    // ETSQUARE
    property ETSmoothed: boolean read FETSmoothed write SetETSmoothed;
    // smoothfact
    property StoredSmoothFactor: TRealStorage read FStoredSmoothFactor
      write SetStoredSmoothFactor;
    // NETFLUX
    property WriteRechargeAndDischarge: boolean read FWriteRechargeAndDischarge
      write SetWriteRechargeAndDischarge;
  end;

  THobPackageSelection = class(TModflowPackageSelection)
  private
    FDryHead: double;
    procedure SetDryHead(const Value: double);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    procedure InitializeVariables; override;
  published
    property DryHead: double read FDryHead write SetDryHead;
  end;

  TSurfaceApplicationPosition = (sapInternal, sapVertical);


  TModpathSelection = class(TModflowPackageSelection)
  private
    FMaximumSize: integer;
    FRCH_Source: TSurfaceApplicationPosition;
    FEVT_Sink: TSurfaceApplicationPosition;
    FCompact: boolean;
    FBinary: boolean;
    FEndingTime: Real;
    FBeginningTime: Real;
    FReferenceTime: real;
    FOutputMode: TModpathOutputMode;
    FOutputTimes: TModpathTimes;
    FStopAfterMaxTime: boolean;
    FMaxTime: real;
    FTrackingDirection: TTrackingDirection;
    FWeakSink: TWeakSink;
    FWeakSinkThreshold: real;
    FStopInZone: boolean;
    FStopZoneNumber: integer;
    FEndpointWrite: TEndpointWrite;
    FComputeBudgetInAllCells: boolean;
    FErrorTolerance: real;
    FSummarize: boolean;
    FMakeBigBudgetFile: boolean;
    FTimeSeriesMaxCount: integer;
    FTimeSeriesInterval: double;
    FTimeSeriesMethod: TTimeSeriesMethod;
    FBackwardsTrackingReleaseTime: double;
    FWeakSource: TWeakSink;
    FStopOption: TStopOption;
    FBudgetChecking: TBudgetChecking;
    FRetardationOption: TRetardationOption;
    FAdvectiveObservations: TAdvectiveObservations;
    FMpathVersion: TMpathVersion;
    FStopTime: real;
    FTraceID: Integer;
    FUzf_Source: TSurfaceApplicationPosition;
    FSfr_Source: TSurfaceApplicationPosition;
    FMnw2_Source: TSurfaceApplicationPosition;
    FRes_Source: TSurfaceApplicationPosition;
    FEts_Sink: TSurfaceApplicationPosition;
    FLak_Source: TSurfaceApplicationPosition;
    procedure SetMaximumSize(const Value: integer);
    procedure SetEVT_Sink(const Value: TSurfaceApplicationPosition);
    procedure SetRCH_Source(const Value: TSurfaceApplicationPosition);
    procedure SetBinary(const Value: boolean);
    procedure SetCompact(const Value: boolean);
    procedure SetBeginningTime(const Value: Real);
    procedure SetEndingTime(const Value: Real);
    procedure SetReferenceTime(const Value: real);
    procedure SetOutputMode(const Value: TModpathOutputMode);
    procedure SetOutputTimes(const Value: TModpathTimes);
    procedure SetStopAfterMaxTime(const Value: boolean);
    procedure SetMaxTime(const Value: real);
    procedure SetTrackingDirection(const Value: TTrackingDirection);
    procedure SetWeakSink(const Value: TWeakSink);
    procedure SetWeakSinkThreshold(const Value: real);
    procedure SetStopInZone(const Value: boolean);
    procedure SetStopZoneNumber(const Value: integer);
    procedure SetEndpointWrite(const Value: TEndpointWrite);
    procedure SetComputeBudgetInAllCells(const Value: boolean);
    procedure SetErrorTolerance(const Value: real);
    procedure SetSummarize(const Value: boolean);
    procedure SetMakeBigBudgetFile(const Value: boolean);
    procedure SetTimeSeriesInterval(const Value: double);
    procedure SetTimeSeriesMaxCount(const Value: integer);
    procedure SetTimeSeriesMethod(const Value: TTimeSeriesMethod);
    procedure SetBackwardsTrackingReleaseTime(const Value: double);
    procedure SetWeakSource(const Value: TWeakSink);
    procedure SetStopOption(const Value: TStopOption);
    procedure SetBudgetChecking(const Value: TBudgetChecking);
    procedure SetRetardationOption(const Value: TRetardationOption);
    procedure SetAdvectiveObservations(const Value: TAdvectiveObservations);
    procedure SetMpathVersion(const Value: TMpathVersion);
    procedure SetStopTime(const Value: real);
    procedure SetTraceID(const Value: Integer);
    procedure SetEts_Sink(const Value: TSurfaceApplicationPosition);
    procedure SetMnw2_Source(const Value: TSurfaceApplicationPosition);
    procedure SetRes_Source(const Value: TSurfaceApplicationPosition);
    procedure SetSfr_Source(const Value: TSurfaceApplicationPosition);
    procedure SetUzf_Source(const Value: TSurfaceApplicationPosition);
    procedure SetLak_Source(const Value: TSurfaceApplicationPosition);
  protected
    procedure SetIsSelected(const Value: boolean); override;
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure InitializeVariables; override;
    function ShouldCreateTimeFile: boolean;
  published
    // Version 5 only.
    property MaximumSize: integer read FMaximumSize write SetMaximumSize;
    // versions 5 and 6.
    // IEVTTP
    property EVT_Sink: TSurfaceApplicationPosition
      read FEVT_Sink write SetEVT_Sink default sapVertical;
    // versions 5 and 6.
    // IRCHTP
    property RCH_Source: TSurfaceApplicationPosition
      read FRCH_Source write SetRCH_Source default sapVertical;
    // Version 5 only.
    property Compact: boolean read FCompact write SetCompact;
    // Version 5 only.
    property Binary: boolean read FBinary write SetBinary;
    // Version 5 only.
    property BeginningTime: Real read FBeginningTime write SetBeginningTime;
    // Version 5 only.
    property EndingTime: Real read FEndingTime write SetEndingTime;
    // versions 5 and 6.
    // ReferenceTime
    property ReferenceTime: real read FReferenceTime write SetReferenceTime;
    // versions 5 and 6.
    // SimulationType
    property OutputMode: TModpathOutputMode read FOutputMode
      write SetOutputMode;
    // versions 5 and 6.
    // TimePointCount, TimePoints
    property OutputTimes: TModpathTimes read FOutputTimes write SetOutputTimes;
    // Version 5 only.
    property StopAfterMaxTime: boolean read FStopAfterMaxTime
      write SetStopAfterMaxTime;
    // Version 5 only.
    property MaxTime: real read FMaxTime write SetMaxTime;
    // versions 5 and 6.
    // TrackingDirection
    property TrackingDirection: TTrackingDirection read FTrackingDirection
      write SetTrackingDirection;
    // versions 5 and 6.
    // WeakSinkOption
    property WeakSink: TWeakSink read FWeakSink write SetWeakSink;
    // version 5.
    property WeakSinkThreshold: real read FWeakSinkThreshold
      write SetWeakSinkThreshold;
    // versions 5 and 6.
    // ZoneArrayOption
    property StopInZone: boolean read FStopInZone write SetStopInZone;
    // versions 5 and 6.
    // StopZone
    property StopZoneNumber: integer read FStopZoneNumber
      write SetStopZoneNumber;
    // version 5.
    property EndpointWrite: TEndpointWrite read FEndpointWrite
      write SetEndpointWrite;
    // version 5.
    property ComputeBudgetInAllCells: boolean read FComputeBudgetInAllCells
      write SetComputeBudgetInAllCells;
    // version 5.
    property ErrorTolerance: real read FErrorTolerance write SetErrorTolerance;
    // version 5.
    property Summarize: boolean read FSummarize write SetSummarize;
    // version 5.
    property MakeBigBudgetFile: boolean read FMakeBigBudgetFile
      write SetMakeBigBudgetFile default True;
    // new properties
    // versions 5 and 6.
    // TimePointOption
    property TimeSeriesMethod: TTimeSeriesMethod read FTimeSeriesMethod
      write SetTimeSeriesMethod;
    // versions 5 and 6.
    // ReleaseTimeIncrement
    property TimeSeriesInterval: double read FTimeSeriesInterval
      write SetTimeSeriesInterval stored True;
    // versions 5 and 6.
    // TimePointCount
    property TimeSeriesMaxCount: integer read FTimeSeriesMaxCount
      write SetTimeSeriesMaxCount;
    // version 5.
    property BackwardsTrackingReleaseTime: double
      read FBackwardsTrackingReleaseTime write SetBackwardsTrackingReleaseTime;
    // MODPATH 6 options
    property MpathVersion: TMpathVersion read FMpathVersion
      write SetMpathVersion stored True;
    // WeakSource.
    property WeakSource: TWeakSink read FWeakSource write SetWeakSource;
    // StopOption.
    property StopOption: TStopOption read FStopOption write SetStopOption;
    // StopTime
    property StopTime: real read FStopTime write SetStopTime;
    // BudgetOutputOption
    property BudgetChecking: TBudgetChecking read FBudgetChecking
      write SetBudgetChecking;
    // TraceID
    property TraceID: Integer read FTraceID write SetTraceID default 1;
    // RetardationOption
    property RetardationOption: TRetardationOption read FRetardationOption
      write SetRetardationOption;
    // AdvectiveObservationsOption
    property AdvectiveObservations: TAdvectiveObservations
      read FAdvectiveObservations write SetAdvectiveObservations;
    property Ets_Sink: TSurfaceApplicationPosition
      read FEts_Sink write SetEts_Sink default sapVertical;
    property Uzf_Source: TSurfaceApplicationPosition
      read FUzf_Source write SetUzf_Source default sapVertical;
    property Mnw2_Source: TSurfaceApplicationPosition
      read FMnw2_Source write SetMnw2_Source default sapInternal;
    property Res_Source: TSurfaceApplicationPosition
      read FRes_Source write SetRes_Source default sapVertical;
    property Sfr_Source: TSurfaceApplicationPosition
      read FSfr_Source write SetSfr_Source default sapVertical;
    property Lak_Source: TSurfaceApplicationPosition
      read FLak_Source write SetLak_Source default sapVertical;
  end;

  ZZoneItem = class(TOrderedItem)
  private
    FZoneNumber: integer;
    procedure SetZoneNumber(const Value: integer);
  public
    procedure Assign(Source: TPersistent); override;
    function IsSame(AnotherItem: TOrderedItem): boolean; override;
  published
    property ZoneNumber: integer read FZoneNumber write SetZoneNumber;
  end;

  TCompositeZone = class(TOrderedCollection)
  private
    FZoneName: string;
    function GetItem(Index: integer): ZZoneItem;
    procedure SetItem(Index: integer; const Value: ZZoneItem);
    procedure SetZoneName(Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    constructor Create(Model: TBaseModel);
    function IsSame(AnOrderedCollection: TOrderedCollection): boolean; override;
    property Items[Index: integer]: ZZoneItem read GetItem
      write SetItem; default;
  published
    property ZoneName: string read FZoneName write SetZoneName;
  end;

  TCompositeZoneItem = class(TOrderedItem)
  private
    FCompositeZone: TCompositeZone;
    procedure SetCompositeZone(const Value: TCompositeZone);
  public
    procedure Assign(Source: TPersistent); override;
    function IsSame(AnotherItem: TOrderedItem): boolean; override;
    constructor Create(Collection: TCollection); override;
    Destructor Destroy; override;
  published
    property CompositeZone: TCompositeZone read FCompositeZone
      write SetCompositeZone;
  end;

  TCompositeZoneCollection = class(TOrderedCollection)
  private
    function GetItem(Index: integer): TCompositeZoneItem;
    procedure SetItem(Index: integer; const Value: TCompositeZoneItem);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    constructor Create(Model: TBaseModel);
    property Items[Index: integer]: TCompositeZoneItem read GetItem
      write SetItem; default;
  end;

  TZoneBudgetSelect = class(TModflowPackageSelection)
  private
    FCompositeZones: TCompositeZoneCollection;
    FExportZBLST: boolean;
    FExportCSV2: boolean;
    FExportCSV: boolean;
    procedure SetCompositeZones(const Value: TCompositeZoneCollection);
    procedure SetExportCSV(const Value: boolean);
    procedure SetExportCSV2(const Value: boolean);
    procedure SetExportZBLST(const Value: boolean);
  public
    procedure InitializeVariables; override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property CompositeZones: TCompositeZoneCollection read FCompositeZones
      write SetCompositeZones;
    property ExportZBLST: boolean read FExportZBLST
      write SetExportZBLST Stored True;
    property ExportCSV: boolean read FExportCSV write SetExportCSV Stored True;
    property ExportCSV2: boolean read FExportCSV2
      write SetExportCSV2 Stored True;
  end;

  TMnw2PrintOption = (mpoNone, mpoIntermediate, mpoMost);

  TMultinodeWellSelection = class(TModflowPackageSelection)
  private
    FPrintOption: TMnw2PrintOption;
    FSummarizeByWell: Boolean;
    FCreateWellFile: Boolean;
    FSummarizeByNode: Boolean;
    FMfMnwWellRadius: TModflowBoundaryDisplayTimeList;
    FMfMnwCellToWellConductance: TModflowBoundaryDisplayTimeList;
    FMfMnwP: TModflowBoundaryDisplayTimeList;
    FMfMnwSkinK: TModflowBoundaryDisplayTimeList;
    FMfMnwSkinRadius: TModflowBoundaryDisplayTimeList;
    FMfMnwPartialPenetration: TModflowBoundaryDisplayTimeList;
    FMfMnwB: TModflowBoundaryDisplayTimeList;
    FMfMnwC: TModflowBoundaryDisplayTimeList;
    procedure SetPrintOption(const Value: TMnw2PrintOption);
    procedure SetCreateWellFile(const Value: Boolean);
    procedure SetSummarizeByNode(const Value: Boolean);
    procedure SetSummarizeByWell(const Value: Boolean);
    procedure InitializeMnw2Display(Sender: TObject);
    procedure GetMfMnwWellRadiusUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfMnwSkinRadiusUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfMnwUseList(Sender: TObject; NewUseList: TStringList;
      DataIndex: integer);
    procedure GetMfMnwSkinKUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfMnwBUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfMnwCUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfMnwPUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfMnwCellToWellConductanceUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfMnwPartialPenetrationUseList(Sender: TObject;
      NewUseList: TStringList);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property MfMnwWellRadius: TModflowBoundaryDisplayTimeList
      read FMfMnwWellRadius;
    property MfMnwSkinRadius: TModflowBoundaryDisplayTimeList
      read FMfMnwSkinRadius;
    property MfMnwSkinK: TModflowBoundaryDisplayTimeList read FMfMnwSkinK;
    property MfMnwB: TModflowBoundaryDisplayTimeList read FMfMnwB;
    property MfMnwC: TModflowBoundaryDisplayTimeList read FMfMnwC;
    property MfMnwP: TModflowBoundaryDisplayTimeList read FMfMnwP;
    property MfMnwCellToWellConductance: TModflowBoundaryDisplayTimeList
      read FMfMnwCellToWellConductance;
    property MfMnwPartialPenetration: TModflowBoundaryDisplayTimeList
      read FMfMnwPartialPenetration;
  published
    property PrintOption: TMnw2PrintOption read FPrintOption
      write SetPrintOption default mpoMost;
    property CreateWellFile: Boolean read FCreateWellFile
      write SetCreateWellFile;
    property SummarizeByWell: Boolean read FSummarizeByWell
      write SetSummarizeByWell;
    property SummarizeByNode: Boolean read FSummarizeByNode
      write SetSummarizeByNode;
  end;

  TCustomPrintItem = class(TOrderedItem)
  private
    FStartTime: double;
    FEndTime: double;
    procedure SetStartTime(const Value: double);
    procedure SetEndTime(const Value: double);
  protected
    function IsSame(AnotherItem: TOrderedItem): boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property StartTime: double read FStartTime write SetStartTime;
    property EndTime: double read FEndTime write SetEndTime;
  end;

  TSubPrintItem = class(TCustomPrintItem)
  private
    FPrintVerticalDisplacement: boolean;
    FSaveCompactionByInterbedSystem: boolean;
    FSaveCriticalHeadDelay: boolean;
    FPrintCompactionByInterbedSystem: boolean;
    FPrintCriticalHeadDelay: boolean;
    FSaveCriticalHeadNoDelay: boolean;
    FPrintDelayBudgets: boolean;
    FPrintCriticalHeadNoDelay: boolean;
    FSaveSubsidence: boolean;
    FSaveCompactionByModelLayer: boolean;
    FPrintSubsidence: boolean;
    FPrintCompactionByModelLayer: boolean;
    FSaveVerticalDisplacement: boolean;
    procedure SetPrintCompactionByInterbedSystem(const Value: boolean);
    procedure SetPrintCompactionByModelLayer(const Value: boolean);
    procedure SetPrintCriticalHeadDelay(const Value: boolean);
    procedure SetPrintCriticalHeadNoDelay(const Value: boolean);
    procedure SetPrintDelayBudgets(const Value: boolean);
    procedure SetPrintSubsidence(const Value: boolean);
    procedure SetPrintVerticalDisplacement(const Value: boolean);
    procedure SetSaveCompactionByInterbedSystem(const Value: boolean);
    procedure SetSaveCompactionByModelLayer(const Value: boolean);
    procedure SetSaveCriticalHeadDelay(const Value: boolean);
    procedure SetSaveCriticalHeadNoDelay(const Value: boolean);
    procedure SetSaveSubsidence(const Value: boolean);
    procedure SetSaveVerticalDisplacement(const Value: boolean);
  public
    procedure Assign(Source: TPersistent); override;
    function IsSame(AnotherItem: TOrderedItem): boolean; override;
  published
    // Ifl1
    property PrintSubsidence: boolean read FPrintSubsidence
      write SetPrintSubsidence;
    // Ifl2
    property SaveSubsidence: boolean read FSaveSubsidence
      write SetSaveSubsidence;
    // Ifl3
    property PrintCompactionByModelLayer: boolean
      read FPrintCompactionByModelLayer write SetPrintCompactionByModelLayer;
    // Ifl4
    property SaveCompactionByModelLayer: boolean
      read FSaveCompactionByModelLayer write SetSaveCompactionByModelLayer;
    // Ifl5
    property PrintCompactionByInterbedSystem: boolean
      read FPrintCompactionByInterbedSystem
      write SetPrintCompactionByInterbedSystem;
    // Ifl6
    property SaveCompactionByInterbedSystem: boolean
      read FSaveCompactionByInterbedSystem
      write SetSaveCompactionByInterbedSystem;
    // Ifl7
    property PrintVerticalDisplacement: boolean read FPrintVerticalDisplacement
      write SetPrintVerticalDisplacement;
    // Ifl8
    property SaveVerticalDisplacement: boolean read FSaveVerticalDisplacement
      write SetSaveVerticalDisplacement;
    // Ifl9
    property PrintCriticalHeadNoDelay: boolean read FPrintCriticalHeadNoDelay
      write SetPrintCriticalHeadNoDelay;
    // Ifl10
    property SaveCriticalHeadNoDelay: boolean read FSaveCriticalHeadNoDelay
      write SetSaveCriticalHeadNoDelay;
    // Ifl11
    property PrintCriticalHeadDelay: boolean read FPrintCriticalHeadDelay
      write SetPrintCriticalHeadDelay;
    // Ifl12
    property SaveCriticalHeadDelay: boolean read FSaveCriticalHeadDelay
      write SetSaveCriticalHeadDelay;
    // Ifl13
    property PrintDelayBudgets: boolean read FPrintDelayBudgets
      write SetPrintDelayBudgets;
  end;

  TSubPrintCollection = class(TOrderedCollection)
  private
    function GetItem(Index: integer): TSubPrintItem;
    procedure SetItem(Index: integer; const Value: TSubPrintItem);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    constructor Create(Model: TBaseModel);
    property Items[Index: integer]: TSubPrintItem read GetItem
      write SetItem; default;
    procedure ReportErrors;
  end;

  TSubPrintFormats = class(TGoPhastPersistent)
  private
    FDelayPreconsolidationHeadFormat: integer;
    FVerticalDisplacementFormat: integer;
    FNoDelayPreconsolidationHeadFormat: integer;
    FCompactionByInterbedSystemFormat: integer;
    FSubsidenceFormat: integer;
    FCompactionByModelLayerFormat: integer;
    procedure SetCompactionByInterbedSystemFormat(const Value: integer);
    procedure SetCompactionByModelLayerFormat(const Value: integer);
    procedure SetDelayPreconsolidationHeadFormat(const Value: integer);
    procedure SetNoDelayPreconsolidationHeadFormat(const Value: integer);
    procedure SetSubsidenceFormat(const Value: integer);
    procedure SetVerticalDisplacementFormat(const Value: integer);
  public
    procedure Assign(Source: TPersistent); override;
    procedure InitializeVariables;
  published
    property SubsidenceFormat : integer read FSubsidenceFormat
      write SetSubsidenceFormat;
    property CompactionByModelLayerFormat: integer
      read FCompactionByModelLayerFormat write SetCompactionByModelLayerFormat;
    property CompactionByInterbedSystemFormat: integer
      read FCompactionByInterbedSystemFormat
      write SetCompactionByInterbedSystemFormat;
    property VerticalDisplacementFormat: integer
      read FVerticalDisplacementFormat write SetVerticalDisplacementFormat;
    property NoDelayPreconsolidationHeadFormat: integer
      read FNoDelayPreconsolidationHeadFormat
      write SetNoDelayPreconsolidationHeadFormat;
    property DelayPreconsolidationHeadFormat: integer
      read FDelayPreconsolidationHeadFormat
      write SetDelayPreconsolidationHeadFormat;
  end;

  TSubBinaryOutputChoice = (sbocSingleFile, sbocMultipleFiles);

  TSubPackageSelection = class(TModflowPackageSelection)
  private
    FPrintChoices: TSubPrintCollection;
    FReadDelayRestartFileName: string;
    FAccelerationParameter2: double;
    FAccelerationParameter1: double;
    FMinIterations: integer;
    FNumberOfNodes: integer;
    FPrintFormats: TSubPrintFormats;
    FSaveDelayRestart: boolean;
    FSubBinaryOutputChoice: TSubBinaryOutputChoice;
    procedure SetPrintChoices(const Value: TSubPrintCollection);
    procedure SetAccelerationParameter1(const Value: double);
    procedure SetAccelerationParameter2(const Value: double);
    procedure SetMinIterations(const Value: integer);
    procedure SetNumberOfNodes(const Value: integer);
    procedure SetPrintFormats(const Value: TSubPrintFormats);
    procedure SetReadDelayRestartFileName(const Value: string);
    procedure SetSaveDelayRestart(const Value: boolean);
    procedure SetSubBinaryOutputChoice(const Value: TSubBinaryOutputChoice);
  public
    procedure Assign(Source: TPersistent); override;
    procedure InitializeVariables; override;
    { TODO -cRefactor : Consider replacing Model with a TNotifyEvent or interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
  published
    property PrintFormats: TSubPrintFormats read FPrintFormats
      write SetPrintFormats;
    property PrintChoices: TSubPrintCollection read FPrintChoices
      write SetPrintChoices;
    // NN
    property NumberOfNodes: integer read FNumberOfNodes write SetNumberOfNodes;
    // AC1
    property AccelerationParameter1: double read FAccelerationParameter1
      write SetAccelerationParameter1;
    // AC2
    property AccelerationParameter2: double read FAccelerationParameter2
      write SetAccelerationParameter2;
    // ITMIN
    property MinIterations: integer read FMinIterations write SetMinIterations;
    // IDSAVE
    property SaveDelayRestart: boolean read FSaveDelayRestart
      write SetSaveDelayRestart;
    // IDREST
    property ReadDelayRestartFileName: string read FReadDelayRestartFileName
      write SetReadDelayRestartFileName;
    property BinaryOutputChoice: TSubBinaryOutputChoice
      read FSubBinaryOutputChoice write SetSubBinaryOutputChoice;
  end;

  TSwtPrintItem = class(TCustomPrintItem)
  private
    FSaveDeltaGeostaticStress: boolean;
    FPrintGeostaticStress: boolean;
    FPrintVerticalDisplacement: boolean;
    FSavePreconsolidationStress: boolean;
    FSaveCompactionByInterbedSystem: boolean;
    FPrintVoidRatio: boolean;
    FPrintDeltaEffectiveStress: boolean;
    FPrintDeltaGeostaticStress: boolean;
    FSaveDeltaPreconsolidationStress: boolean;
    FPrintPreconsolidationStress: boolean;
    FPrintCompactionByInterbedSystem: boolean;
    FPrintDeltaPreconsolidationStress: boolean;
    FSaveThicknessCompressibleSediments: boolean;
    FSaveSubsidence: boolean;
    FSaveEffectiveStress: boolean;
    FSaveCompactionByModelLayer: boolean;
    FSaveLayerCenterElevation: boolean;
    FPrintThicknessCompressibleSediments: boolean;
    FSaveGeostaticStress: boolean;
    FSaveVerticalDisplacement: boolean;
    FSaveVoidRatio: boolean;
    FPrintSubsidence: boolean;
    FSaveDeltaEffectiveStress: boolean;
    FPrintEffectiveStress: boolean;
    FPrintCompactionByModelLayer: boolean;
    FPrintLayerCenterElevation: boolean;
    procedure SetPrintCompactionByInterbedSystem(const Value: boolean);
    procedure SetPrintCompactionByModelLayer(const Value: boolean);
    procedure SetPrintDeltaEffectiveStress(const Value: boolean);
    procedure SetPrintDeltaGeostaticStress(const Value: boolean);
    procedure SetPrintDeltaPreconsolidationStress(const Value: boolean);
    procedure SetPrintEffectiveStress(const Value: boolean);
    procedure SetPrintGeostaticStress(const Value: boolean);
    procedure SetPrintLayerCenterElevation(const Value: boolean);
    procedure SetPrintPreconsolidationStress(const Value: boolean);
    procedure SetPrintSubsidence(const Value: boolean);
    procedure SetPrintThicknessCompressibleSediments(const Value: boolean);
    procedure SetPrintVerticalDisplacement(const Value: boolean);
    procedure SetPrintVoidRatio(const Value: boolean);
    procedure SetSaveCompactionByInterbedSystem(const Value: boolean);
    procedure SetSaveCompactionByModelLayer(const Value: boolean);
    procedure SetSaveDeltaEffectiveStress(const Value: boolean);
    procedure SetSaveDeltaGeostaticStress(const Value: boolean);
    procedure SetSaveDeltaPreconsolidationStress(const Value: boolean);
    procedure SetSaveEffectiveStress(const Value: boolean);
    procedure SetSaveGeostaticStress(const Value: boolean);
    procedure SetSaveLayerCenterElevation(const Value: boolean);
    procedure SetSavePreconsolidationStress(const Value: boolean);
    procedure SetSaveSubsidence(const Value: boolean);
    procedure SetSaveThicknessCompressibleSediments(const Value: boolean);
    procedure SetSaveVerticalDisplacement(const Value: boolean);
    procedure SetSaveVoidRatio(const Value: boolean);
  public
    procedure Assign(Source: TPersistent); override;
    function IsSame(AnotherItem: TOrderedItem): boolean; override;
  published
    // Ifl1
    property PrintSubsidence: boolean read FPrintSubsidence
      write SetPrintSubsidence;
    // Ifl2
    property SaveSubsidence: boolean read FSaveSubsidence
      write SetSaveSubsidence;
    // Ifl3
    property PrintCompactionByModelLayer: boolean
      read FPrintCompactionByModelLayer write SetPrintCompactionByModelLayer;
    // Ifl4
    property SaveCompactionByModelLayer: boolean
      read FSaveCompactionByModelLayer write SetSaveCompactionByModelLayer;
    // Ifl5
    property PrintCompactionByInterbedSystem: boolean
      read FPrintCompactionByInterbedSystem
      write SetPrintCompactionByInterbedSystem;
    // Ifl6
    property SaveCompactionByInterbedSystem: boolean
      read FSaveCompactionByInterbedSystem
      write SetSaveCompactionByInterbedSystem;
    // Ifl7
    property PrintVerticalDisplacement: boolean read FPrintVerticalDisplacement
      write SetPrintVerticalDisplacement;
    // Ifl8
    property SaveVerticalDisplacement: boolean read FSaveVerticalDisplacement
      write SetSaveVerticalDisplacement;
    // Ifl9
    property PrintPreconsolidationStress: boolean
      read FPrintPreconsolidationStress write SetPrintPreconsolidationStress;
    // Ifl10
    property SavePreconsolidationStress: boolean
      read FSavePreconsolidationStress write SetSavePreconsolidationStress;
    // Ifl11
    property PrintDeltaPreconsolidationStress: boolean
      read FPrintDeltaPreconsolidationStress
      write SetPrintDeltaPreconsolidationStress;
    // Ifl12
    property SaveDeltaPreconsolidationStress: boolean
      read FSaveDeltaPreconsolidationStress
      write SetSaveDeltaPreconsolidationStress;
    // Ifl13
    property PrintGeostaticStress: boolean read FPrintGeostaticStress
      write SetPrintGeostaticStress;
    // Ifl14
    property SaveGeostaticStress: boolean read FSaveGeostaticStress
      write SetSaveGeostaticStress;
    // Ifl15
    property PrintDeltaGeostaticStress: boolean read FPrintDeltaGeostaticStress
      write SetPrintDeltaGeostaticStress;
    // Ifl16
    property SaveDeltaGeostaticStress: boolean read FSaveDeltaGeostaticStress
      write SetSaveDeltaGeostaticStress;
    // Ifl17
    property PrintEffectiveStress: boolean read FPrintEffectiveStress
      write SetPrintEffectiveStress;
    // Ifl18
    property SaveEffectiveStress: boolean read FSaveEffectiveStress
      write SetSaveEffectiveStress;
    // Ifl19
    property PrintDeltaEffectiveStress: boolean read FPrintDeltaEffectiveStress
      write SetPrintDeltaEffectiveStress;
    // Ifl20
    property SaveDeltaEffectiveStress: boolean read FSaveDeltaEffectiveStress
      write SetSaveDeltaEffectiveStress;
    // Ifl21
    property PrintVoidRatio: boolean read FPrintVoidRatio
      write SetPrintVoidRatio;
    // Ifl22
    property SaveVoidRatio: boolean read FSaveVoidRatio write SetSaveVoidRatio;
    // Ifl23
    property PrintThicknessCompressibleSediments: boolean
      read FPrintThicknessCompressibleSediments
      write SetPrintThicknessCompressibleSediments;
    // Ifl24
    property SaveThicknessCompressibleSediments: boolean
      read FSaveThicknessCompressibleSediments
      write SetSaveThicknessCompressibleSediments;
    // Ifl25
    property PrintLayerCenterElevation: boolean read FPrintLayerCenterElevation
      write SetPrintLayerCenterElevation;
    // Ifl26
    property SaveLayerCenterElevation: boolean read FSaveLayerCenterElevation
      write SetSaveLayerCenterElevation;
  end;

  TSwtPrintCollection = class(TOrderedCollection)
  private
    function GetItem(Index: integer): TSwtPrintItem;
    procedure SetItem(Index: integer; const Value: TSwtPrintItem);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    constructor Create(Model: TBaseModel);
    property Items[Index: integer]: TSwtPrintItem read GetItem
      write SetItem; default;
    procedure ReportErrors;
  end;

  TSwtInitialPrint = class(TGoPhastPersistent)
  private
    FPrintInitialLayerCenterElevations: boolean;
    FPrintInitialEquivalentStorageProperties: boolean;
    FInitialEquivalentStoragePropertiesFormat: integer;
    FPrintInitialGeostaticStress: boolean;
    FInitialLayerCenterElevationFormat: integer;
    FInitialGeostaticStressFormat: integer;
    FPrintInitialPreconsolidationStress: boolean;
    FInitialPreconsolidationStressFormat: integer;
    FPrintInitialEffectiveStress: boolean;
    FInitialEffectiveStressFormat: integer;
    procedure SetInitialEquivalentStoragePropertiesFormat(const Value: integer);
    procedure SetInitialGeostaticStressFormat(const Value: integer);
    procedure SetInitialLayerCenterElevationFormat(const Value: integer);
    procedure SetInitialPreconsolidationStressFormat(const Value: integer);
    procedure SetPrintInitialEquivalentStorageProperties(const Value: boolean);
    procedure SetPrintInitialGeostaticStress(const Value: boolean);
    procedure SetPrintInitialLayerCenterElevations(const Value: boolean);
    procedure SetPrintInitialPreconsolidationStress(const Value: boolean);
    procedure SetInitialEffectiveStressFormat(const Value: integer);
    procedure SetPrintInitialEffectiveStress(const Value: boolean);
  public
    procedure Assign(Source: TPersistent); override;
    procedure InitializeVariables;
  published
    // IZCFL
    property PrintInitialLayerCenterElevations: boolean
      read FPrintInitialLayerCenterElevations
      write SetPrintInitialLayerCenterElevations;
    // IZCFM
    property InitialLayerCenterElevationFormat: integer
      read FInitialLayerCenterElevationFormat
      write SetInitialLayerCenterElevationFormat;
    // IGLFL
    property PrintInitialGeostaticStress: boolean
      read FPrintInitialGeostaticStress write SetPrintInitialGeostaticStress;
    // IGLFM
    property InitialGeostaticStressFormat: integer
      read FInitialGeostaticStressFormat write SetInitialGeostaticStressFormat;
    // IESTFL
    property PrintInitialEffectiveStress: boolean
      read FPrintInitialEffectiveStress write SetPrintInitialEffectiveStress;
    // IESTFM
    property InitialEffectiveStressFormat: integer
      read FInitialEffectiveStressFormat write SetInitialEffectiveStressFormat;
    // IPCSFL
    property PrintInitialPreconsolidationStress: boolean
      read FPrintInitialPreconsolidationStress
      write SetPrintInitialPreconsolidationStress;
    // IPCSFM
    property InitialPreconsolidationStressFormat: integer
      read FInitialPreconsolidationStressFormat
      write SetInitialPreconsolidationStressFormat;
    // ISTFL
    property PrintInitialEquivalentStorageProperties: boolean
      read FPrintInitialEquivalentStorageProperties
      write SetPrintInitialEquivalentStorageProperties;
    // ISTFM
    property InitialEquivalentStoragePropertiesFormat: integer
      read FInitialEquivalentStoragePropertiesFormat
      write SetInitialEquivalentStoragePropertiesFormat;
  end;

  TSwtPrintFormats = class(TGoPhastPersistent)
  private
    FVerticalDisplacementFormat: integer;
    FCompactionByInterbedSystemFormat: integer;
    FSubsidenceFormat: integer;
    FCompactionByModelLayerFormat: integer;
    FThicknessCompressibleSediments: integer;
    FEffectiveStress: integer;
    FLayerCenterElevation: integer;
    FGeostaticStress: integer;
    FVoidRatio: integer;
    FDeltaEffectiveStress: integer;
    FDeltaGeostaticStress: integer;
    FPreconsolidationStress: integer;
    FDeltaPreconsolidationStress: integer;
    procedure SetCompactionByInterbedSystemFormat(const Value: integer);
    procedure SetCompactionByModelLayerFormat(const Value: integer);
    procedure SetSubsidenceFormat(const Value: integer);
    procedure SetVerticalDisplacementFormat(const Value: integer);
    procedure SetDeltaEffectiveStress(const Value: integer);
    procedure SetDeltaGeostaticStress(const Value: integer);
    procedure SetDeltaPreconsolidationStress(const Value: integer);
    procedure SetEffectiveStress(const Value: integer);
    procedure SetGeostaticStress(const Value: integer);
    procedure SetLayerCenterElevation(const Value: integer);
    procedure SetPreconsolidationStress(const Value: integer);
    procedure SetThicknessCompressibleSediments(const Value: integer);
    procedure SetVoidRatio(const Value: integer);
  public
    procedure Assign(Source: TPersistent); override;
    procedure InitializeVariables;
  published
    // Ifm1
    property SubsidenceFormat : integer read FSubsidenceFormat
      write SetSubsidenceFormat;
    // Ifm2
    property CompactionByModelLayerFormat: integer
      read FCompactionByModelLayerFormat write SetCompactionByModelLayerFormat;
    // Ifm3
    property CompactionByInterbedSystemFormat: integer
      read FCompactionByInterbedSystemFormat
      write SetCompactionByInterbedSystemFormat;
    // Ifm4
    property VerticalDisplacementFormat: integer
      read FVerticalDisplacementFormat write SetVerticalDisplacementFormat;
    // Ifm5
    property PreconsolidationStress: integer read FPreconsolidationStress
      write SetPreconsolidationStress;
    // Ifm6
    property DeltaPreconsolidationStress: integer
      read FDeltaPreconsolidationStress write SetDeltaPreconsolidationStress;
    // Ifm7
    property GeostaticStress: integer read FGeostaticStress
      write SetGeostaticStress;
    // Ifm8
    property DeltaGeostaticStress: integer read FDeltaGeostaticStress
      write SetDeltaGeostaticStress;
    // Ifm9
    property EffectiveStress: integer read FEffectiveStress
      write SetEffectiveStress;
    // Ifm10
    property DeltaEffectiveStress: integer read FDeltaEffectiveStress
      write SetDeltaEffectiveStress;
    // Ifm11
    property VoidRatio: integer read FVoidRatio write SetVoidRatio;
    // Ifm12
    property ThicknessCompressibleSediments: integer
      read FThicknessCompressibleSediments
      write SetThicknessCompressibleSediments;
    // Ifm13
    property LayerCenterElevation: integer read FLayerCenterElevation
      write SetLayerCenterElevation;
  end;

  TThickResponse = (trConstant, trVariable);
  TVoidRatioResponse = (vrrConstant, vrrVariable);
  TPreconsolidationSource = (pcSpecified, pcOffsets);
  TCompressionSource = (csCompressionReComp, csSpecificStorage);

  TSwtPackageSelection = class(TModflowPackageSelection)
  private
    FInitialPrint: TSwtInitialPrint;
    FThickResponse: TThickResponse;
    FPrintChoices: TSwtPrintCollection;
    FCompressionSource: TCompressionSource;
    FPreconsolidationSource: TPreconsolidationSource;
    FVoidRatioResponse: TVoidRatioResponse;
    FPrintFormats: TSwtPrintFormats;
    FSubBinaryOutputChoice: TSubBinaryOutputChoice;
    procedure SetCompressionSource(const Value: TCompressionSource);
    procedure SetInitialPrint(const Value: TSwtInitialPrint);
    procedure SetPreconsolidationSource(const Value: TPreconsolidationSource);
    procedure SetPrintChoices(const Value: TSwtPrintCollection);
    procedure SetPrintFormats(const Value: TSwtPrintFormats);
    procedure SetThickResponse(const Value: TThickResponse);
    procedure SetVoidRatioResponse(const Value: TVoidRatioResponse);
    procedure SetSubBinaryOutputChoice(const Value: TSubBinaryOutputChoice);
  public
    procedure Assign(Source: TPersistent); override;
    procedure InitializeVariables; override;
    { TODO -cRefactor : Consider replacing Model with a TNotifyEvent or interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
  published
    // Data set 1, ITHK
    property ThickResponse: TThickResponse read FThickResponse
      write SetThickResponse;
    // Data set 1, IVOID
    property VoidRatioResponse: TVoidRatioResponse read FVoidRatioResponse
      write SetVoidRatioResponse;
    // Data set 1, ISTPCS
    property PreconsolidationSource: TPreconsolidationSource
      read FPreconsolidationSource write SetPreconsolidationSource
      default pcSpecified;
    // Data set 1, ICRCC
    property CompressionSource: TCompressionSource read FCompressionSource
      write SetCompressionSource;
    //  Data set 16
    property PrintFormats: TSwtPrintFormats read FPrintFormats
      write SetPrintFormats;
    // data set 17
    property PrintChoices: TSwtPrintCollection read FPrintChoices
      write SetPrintChoices;
    // Data set 3
    property InitialPrint: TSwtInitialPrint read FInitialPrint
      write SetInitialPrint;
    property BinaryOutputChoice: TSubBinaryOutputChoice
      read FSubBinaryOutputChoice write SetSubBinaryOutputChoice;
  end;

  THydPackageSelection = class(TModflowPackageSelection)
  private
    FStoredHYDNOH: TRealStorage;
    procedure SetStoredHYDNOH(const Value: TRealStorage);
    function GetHYDNOH: double;
    procedure SetHYDNOH(const Value: double);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property HYDNOH: double read GetHYDNOH write SetHYDNOH;
    procedure InitializeVariables; override;
  published
    property StoredHYDNOH: TRealStorage read FStoredHYDNOH
      write SetStoredHYDNOH;
  end;

  TFhbSteadyStateInterpolation = (fssiNoInterpolation, fssiInterpolationUsed);

  TFhbPackageSelection = class(TModflowPackageSelection)
  private
    // not used
    FSteadyStateInterpolation: TFhbSteadyStateInterpolation;

    FMfFhbHeads: TModflowBoundaryDisplayTimeList;
    FMfFhbFlows: TModflowBoundaryDisplayTimeList;
    procedure SetSteadyStateInterpolation(
      const Value: TFhbSteadyStateInterpolation);
    procedure InitializeFhbDisplay(Sender: TObject);
    procedure GetMfFhbHeadUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfFhbFlowUseList(Sender: TObject;
      NewUseList: TStringList);
  public
    procedure Assign(Source: TPersistent); override;
    procedure InitializeVariables; override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    property MfFhbHeads: TModflowBoundaryDisplayTimeList read FMfFhbHeads;
    property MfFhbFlows: TModflowBoundaryDisplayTimeList read FMfFhbFlows;
  published
    // not used
    property SteadyStateInterpolation: TFhbSteadyStateInterpolation
      read FSteadyStateInterpolation
      write SetSteadyStateInterpolation stored False;
  end;

  TMt3dBasic = class(TModflowPackageSelection)
  private
    FMinimumSaturatedFraction: TRealStorage;
    FInactiveConcentration: TRealStorage;
    FMassUnit: TStringStorage;
    FInitialConcentrationTransportStep: Integer;
    FInitialConcentrationTimeStep: Integer;
    FInitialConcentrationStressPeriod: Integer;
    procedure SetStoredInactiveConcentration(const Value: TRealStorage);
    procedure SetStoredMassUnit(const Value: TStringStorage);
    procedure SetStoredMinimumSaturatedFraction(const Value: TRealStorage);
    function GetInactiveConcentration: double;
    function GetMassUnit: string;
    function GetMinimumSaturatedFraction: double;
    procedure SetInactiveConcentration(const Value: double);
    procedure SetMassUnit(const Value: string);
    procedure SetMinimumSaturatedFraction(const Value: double);
//    procedure Changed(Sender: TObject);
    procedure UpdateDataSets;
    procedure SetInitialConcentrationStressPeriod(const Value: Integer);
    procedure SetInitialConcentrationTimeStep(const Value: Integer);
    procedure SetInitialConcentrationTransportStep(const Value: Integer);
  protected
    procedure SetIsSelected(const Value: boolean); override;
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
    property MassUnit: string read GetMassUnit write SetMassUnit;
    property InactiveConcentration: double read GetInactiveConcentration
      write SetInactiveConcentration;
    property MinimumSaturatedFraction: double read GetMinimumSaturatedFraction
      write SetMinimumSaturatedFraction;
  published
    property StoredMassUnit: TStringStorage read FMassUnit
      write SetStoredMassUnit;
    property StoredInactiveConcentration: TRealStorage
      read FInactiveConcentration write SetStoredInactiveConcentration;
    property StoredMinimumSaturatedFraction: TRealStorage
      read FMinimumSaturatedFraction write SetStoredMinimumSaturatedFraction;
    property InitialConcentrationStressPeriod: Integer
      read FInitialConcentrationStressPeriod
      write SetInitialConcentrationStressPeriod default 1;
    property InitialConcentrationTimeStep: Integer
      read FInitialConcentrationTimeStep
      write SetInitialConcentrationTimeStep default 1;
    property InitialConcentrationTransportStep: Integer
      read FInitialConcentrationTransportStep
      write SetInitialConcentrationTransportStep default 1;
  end;

  TGcgPreconditioner = (gpJacobi, gpSSOR, gpCholesky);
  TDispersionTensorTreatment = (dtcLump, dtcFull);

  TMt3dmsGCGSolverPackage = class(TModflowPackageSelection)
  private
    FPrintoutInterval: integer;
    FDispersionTensorChoice: TDispersionTensorTreatment;
    FPreconditionerChoice: TGcgPreconditioner;
    FMaxOuterIterations: integer;
    FStoredRelaxationFactor: TRealStorage;
    FStoredConvergenceCriterion: TRealStorage;
    FMaxInnerIterations: integer;
    procedure SetDispersionTensorChoice(const Value: TDispersionTensorTreatment);
    procedure SetMaxInnerIterations(const Value: integer);
    procedure SetMaxOuterIterations(const Value: integer);
    procedure SetPreconditionerChoice(const Value: TGcgPreconditioner);
    procedure SetPrintoutInterval(const Value: integer);
    procedure SetStoredConvergenceCriterion(const Value: TRealStorage);
    procedure SetStoredRelaxationFactor(const Value: TRealStorage);
//    procedure Changed(Sender: TObject);
    function GetConvergenceCriterion: double;
    function GetRelaxationFactor: double;
    procedure SetConvergenceCriterion(const Value: double);
    procedure SetRelaxationFactor(const Value: double);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
    // ACCL
    property RelaxationFactor: double read GetRelaxationFactor
      write SetRelaxationFactor;
    // CCLOSE
    property ConvergenceCriterion: double read GetConvergenceCriterion
      write SetConvergenceCriterion;
  published
    // MXITER
    property MaxOuterIterations: integer read FMaxOuterIterations
      write SetMaxOuterIterations stored True;
    // ITER1
    property MaxInnerIterations: integer read FMaxInnerIterations
      write SetMaxInnerIterations stored True;
    // ISOLVE
    property PreconditionerChoice: TGcgPreconditioner read FPreconditionerChoice
      write SetPreconditionerChoice stored True;
    // NCRS
    property DispersionTensorChoice: TDispersionTensorTreatment
      read FDispersionTensorChoice write SetDispersionTensorChoice stored True;
    // ACCL
    property StoredRelaxationFactor: TRealStorage read FStoredRelaxationFactor
      write SetStoredRelaxationFactor stored True;
    // CCLOSE
    property StoredConvergenceCriterion: TRealStorage
      read FStoredConvergenceCriterion
      write SetStoredConvergenceCriterion stored True;
    // IPRGCG
    property PrintoutInterval: integer read FPrintoutInterval
      write SetPrintoutInterval stored True;
  end;

  TAdvectionSolution = (asUltimate, asStandard, asMoc, asMmoc, asHmoc);
  TWeightingScheme = (wsUpstream, wsCentral);
  TParticleTrackMethod = (ptmEuler, ptmRungeKutta, ptmHybrid);
  TParticlePlacementMethod = (ppmRandom, ppmFixed);

  TMt3dmsAdvection = class(TModflowPackageSelection)
  private
    FStoredRelCelConcGrad: TRealStorage;
    FStoredCriticalConcGradient: TRealStorage;
    FSinkNumberOfParticlePlanes: integer;
    FSinkParticlePlacementMethod: TParticlePlacementMethod;
    FNumberOfParticlePlanes: integer;
    FParticlePlacementMethod: TParticlePlacementMethod;
    FWeightingScheme: TWeightingScheme;
    FMaxParticlesPerCell: integer;
    FLowGradientParticleCount: integer;
    FAdvectionSolution: TAdvectionSolution;
    FStoredCourant: TRealStorage;
    FHighGradientParticleCount: integer;
    FStoredConcWeight: TRealStorage;
    FMaximumParticles: integer;
    FSinkParticleCount: integer;
    FMinParticlePerCell: integer;
    FParticleTrackMethod: TParticleTrackMethod;
    function GetConcWeight: double;
    function GetCourant: double;
    function GetCriticalConcGradient: double;
    function GetRelCelConcGrad: double;
    procedure SetAdvectionSolution(const Value: TAdvectionSolution);
    procedure SetConcWeight(const Value: double);
    procedure SetCourant(const Value: double);
    procedure SetCriticalConcGradient(const Value: double);
    procedure SetHighGradientParticleCount(const Value: integer);
    procedure SetLowGradientParticleCount(const Value: integer);
    procedure SetMaximumParticles(const Value: integer);
    procedure SetMaxParticlesPerCell(const Value: integer);
    procedure SetMinParticlePerCell(const Value: integer);
    procedure SetNumberOfParticlePlanes(const Value: integer);
    procedure SetParticlePlacementMethod(const Value: TParticlePlacementMethod);
    procedure SetParticleTrackMethod(const Value: TParticleTrackMethod);
    procedure SetRelCelConcGrad(const Value: double);
    procedure SetSinkNumberOfParticlePlanes(const Value: integer);
    procedure SetSinkParticleCount(const Value: integer);
    procedure SetSinkParticlePlacementMethod(
      const Value: TParticlePlacementMethod);
    procedure SetStoredConcWeight(const Value: TRealStorage);
    procedure SetStoredCourant(const Value: TRealStorage);
    procedure SetStoredCriticalConcGradient(const Value: TRealStorage);
    procedure SetStoredRelCelConcGrad(const Value: TRealStorage);
    procedure SetWeightingScheme(const Value: TWeightingScheme);
//    procedure Changed(Sender: TObject);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
    // PERCEL
    property Courant: double read GetCourant write SetCourant;
    // WD
    property ConcWeight: double read GetConcWeight write SetConcWeight;
    // DCEPS
    property RelCelConcGrad: double read GetRelCelConcGrad
      write SetRelCelConcGrad;
    // DCHMOC
    property CriticalConcGradient: double
      read GetCriticalConcGradient write SetCriticalConcGradient;
  published
    // MIXELM
    property AdvectionSolution: TAdvectionSolution
      read FAdvectionSolution write SetAdvectionSolution stored True;
    // PERCEL
    property StoredCourant: TRealStorage
      read FStoredCourant write SetStoredCourant stored True;
    // MXPART
    property MaximumParticles: integer
      read FMaximumParticles write SetMaximumParticles stored True;
    // NADVFD
    property WeightingScheme: TWeightingScheme
      read FWeightingScheme write SetWeightingScheme stored True;
    // ITRACK
    property ParticleTrackMethod: TParticleTrackMethod
      read FParticleTrackMethod write SetParticleTrackMethod stored True;
    // WD is a concentration weighting factor
    property StoredConcWeight: TRealStorage
      read FStoredConcWeight write SetStoredConcWeight;
    // DCEPS
    property StoredRelCelConcGrad: TRealStorage
      read FStoredRelCelConcGrad write SetStoredRelCelConcGrad stored True;
    // NPLANE
    property ParticlePlacementMethod: TParticlePlacementMethod
      read FParticlePlacementMethod
      write SetParticlePlacementMethod stored True;
    // NPLANE
    property NumberOfParticlePlanes: integer
      read FNumberOfParticlePlanes write SetNumberOfParticlePlanes stored True;
    // NPL
    property LowGradientParticleCount: integer
      read FLowGradientParticleCount
      write SetLowGradientParticleCount stored True;
    // NPH
    property HighGradientParticleCount: integer
      read FHighGradientParticleCount
      write SetHighGradientParticleCount stored True;
    // NPMIN
    property MinParticlePerCell: integer
      read FMinParticlePerCell write SetMinParticlePerCell stored True;
    // NPMAX
    property MaxParticlesPerCell: integer
      read FMaxParticlesPerCell write SetMaxParticlesPerCell stored True;
    // NLSINK
    property SinkParticlePlacementMethod: TParticlePlacementMethod
      read FSinkParticlePlacementMethod
      write SetSinkParticlePlacementMethod stored True;
    // NLSINK
    property SinkNumberOfParticlePlanes: integer
      read FSinkNumberOfParticlePlanes
      write SetSinkNumberOfParticlePlanes stored True;
    // NPSINK
    property SinkParticleCount: integer
      read FSinkParticleCount write SetSinkParticleCount stored True;
    // DCHMOC
    property StoredCriticalConcGradient: TRealStorage
      read FStoredCriticalConcGradient write SetStoredCriticalConcGradient;
  end;

  TMt3dmsDispersion = class(TModflowPackageSelection)
  private
    FMultiDifussion: boolean;
    procedure SetMultiDifussion(const Value: boolean);
    procedure UpdateDataSets;
  protected
    procedure SetIsSelected(const Value: boolean); override;
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    procedure InitializeVariables; override;
  published
    property MultiDifussion: boolean read FMultiDifussion
      write SetMultiDifussion;
  end;

  TMt3dmsSourceSinkMixing = class(TModflowPackageSelection)
  private
    FConcentrations: TModflowBoundaryDisplayTimeList;
    procedure InitializeConcentrationDisplay(Sender: TObject);
    procedure GetConcentrationUseList(Sender: TObject; NewUseList: TStringList);
  public
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    property Concentrations: TModflowBoundaryDisplayTimeList
      read FConcentrations;
  end;

  TSorptionChoice = (scNone, scLinear, scFreundlich, scLangmuir,
    scFirstOrderKinetic, scDualDomainNoSorption, scDualDomainWithSorption);
  TKineticChoice = (kcNone, kcFirstOrder, kcZeroOrder);
  TOtherInitialConcChoice = (oicDontUse, oicUse);

  TMt3dmsChemReaction = class(TModflowPackageSelection)
  private
    FSorptionChoice: TSorptionChoice;
    FOtherInitialConcChoice: TOtherInitialConcChoice;
    FKineticChoice: TKineticChoice;
    procedure SetKineticChoice(const Value: TKineticChoice);
    procedure SetOtherInitialConcChoice(const Value: TOtherInitialConcChoice);
    procedure SetSorptionChoice(const Value: TSorptionChoice);
    procedure UpdateDataSets;
  protected
    procedure SetIsSelected(const Value: boolean); override;
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    procedure InitializeVariables; override;
  published
    // ISOTHM
    property SorptionChoice: TSorptionChoice read FSorptionChoice
      write SetSorptionChoice stored True;
    // IREACT
    property KineticChoice: TKineticChoice read FKineticChoice
      write SetKineticChoice stored True;
    // IGETSC
    property OtherInitialConcChoice: TOtherInitialConcChoice
      read FOtherInitialConcChoice write SetOtherInitialConcChoice stored True;
  end;

  TConcObsResult = (corConc, corConcResid);
  TMassFluxObsResult = (mfoMassFlux, mfoMassFluxResid);
  TTransformType = (ltNoConversion, ltLogConverion);
  TInterpolateObs = (ioNoInterpolation, ioBilinear);
  TSaveBinary = (sbNoSave, sbSave);

  TMt3dmsTransportObservations = class(TModflowPackageSelection)
  private
    FInterpolateObs: TInterpolateObs;
    FSaveBinary: TSaveBinary;
    FStoredConcScaleFactor: TRealStorage;
    FStoredFluxScaleFactor: TRealStorage;
    FConcObsResult: TConcObsResult;
    FTransformType: TTransformType;
    FMassFluxObsResult: TMassFluxObsResult;
    function GetConcScaleFactor: double;
    procedure SetConcObsResult(const Value: TConcObsResult);
    procedure SetConcScaleFactor(const Value: double);
    procedure SetInterpolateObs(const Value: TInterpolateObs);
    procedure SetSaveBinary(const Value: TSaveBinary);
    procedure SetStoredConcScaleFactor(const Value: TRealStorage);
    procedure SetTransformType(const Value: TTransformType);
//    procedure Changed(Sender: TObject);
    procedure SetStoredFluxScaleFactor(const Value: TRealStorage);
    function GetFluxScaleFactor: double;
    procedure SetFluxScaleFactor(const Value: double);
    procedure SetMassFluxObsResult(const Value: TMassFluxObsResult);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    procedure InitializeVariables; override;
    // CScale
    property ConcScaleFactor: double read GetConcScaleFactor
      write SetConcScaleFactor;
    // FScale
    property FluxScaleFactor: double read GetFluxScaleFactor
      write SetFluxScaleFactor;
  published
    // inSaveObs
    property SaveBinary: TSaveBinary read FSaveBinary
      write SetSaveBinary stored True;
    // CScale
    property StoredConcScaleFactor: TRealStorage read FStoredConcScaleFactor
      write SetStoredConcScaleFactor stored True;
    // iOutCobs
    property ConcObsResult: TConcObsResult read FConcObsResult
      write SetConcObsResult stored True;
    // iConcLOG
    property TransformType: TTransformType read FTransformType
      write SetTransformType stored True;
    // iConcINTP
    property InterpolateObs: TInterpolateObs read FInterpolateObs
      write SetInterpolateObs stored True;
    // FScale
    property StoredFluxScaleFactor: TRealStorage read FStoredFluxScaleFactor
      write SetStoredFluxScaleFactor;
    // iOutFlux
    property MassFluxObsResult: TMassFluxObsResult read FMassFluxObsResult
      write SetMassFluxObsResult stored True;
  end;

  // IRTFL (1 & 2, 3)
  TRootingDepth = (rdSpecified, rdCalculated);
  // ICUFL (3, 2, 1, -1)
  TConsumptiveUse = (cuCalculated, cuPotentialET, cuPotentialAndReferenceET,
    cuCropCoefficient);
  // IPFL (2, 3)
  TPrecipitation = (pSpatiallyDistributed, pTimeSeries);
  // IIESWFL (0, 1 and 2)
  TFractionOfInefficiencyLosses = (filCalculated, filSpecified);
  // IEBFL (0 and 1, 2 and 3)
  // @name is used in conjunction with @link(TEfficiencyReset)
  // to specify IEBFL. egfConstant and egfVaries are for backwards
  // compatiblility. They are equivalent to egfDeliveriesVary,
  // egfEfficienciesVary respectively.
  TEfficiencyGroundwaterFunction = (egfDeliveriesVary, egfEfficienciesVary,
    egfConstant, egfVaries);
  // IEBFL (0 and 2, 1 and 3)
  // @name is used in conjunction with @link(TEfficiencyGroundwaterFunction)
  // to specify IEBFL.
  TEfficiencyReset = (erStressPeriod, erTimeStep);
  // IDEFFL (-2, -1, 0, 1, 2)
  TDeficiencyPolicy = (dpWaterStacking, dpDeficitIrrigation, dpNoPolicy,
    dpAcreageOptimization, dpAcreageOptimizationWithConservationPool);

  // This is for backward compatiblity only. It is not used.
  TWaterCostCoefficients = (wccLumped, wccByFarm);

  // ICCFL (1 and 3, 2 and 4)
  // @name is used in conjunction with @link(TCropConsumptiveLinkage)
  // to specify ICCFL
  TCropConsumptiveConcept = (cccConcept1, cccConcept2);
  // ICCFL (1 and 2, 3 and 4)
  // @name is used in conjunction with @link(TCropConsumptiveConcept)
  // to specify ICCFL
  TCropConsumptiveLinkage = (cclNotLinked, cclLinked);
  // IALLOTSW (0, 1, 2, 3)
  TSurfaceWaterAllotment = (swaNone, swaEqual, swaPriorWithCalls,
    swaPriorWithoutCalls);
  // IFWLCB
  // swfrListing and above are for backwards compatibility but are not used.
  TSaveWellFlowRates = (swfrDefault, swfrAscii,
    swfrListing, swfrNone, swfrBinary, swfrBudget);
  // IFNRCB snrListing and above are for backwards compatibility but are not used.
  TSaveNetRecharge = (snrDefault, snrAsciiByCell, snrAsciiByFarm, snrBinary,
    snrListing, snrNone);

  // ISDPFL
  // sadListingEachTimeStepWhenBudgetSaved, sadNone, sadBinary are only for
  // backwards compatibity;
  TSupplyAndDemand = (sadDefault, sadListingEveryIteration,
    sadListingEachTimeStep, sadAscii,
    sadListingEachTimeStepWhenBudgetSaved, sadNone, sadBinary);

  // IFBPFL
  // fbpAsciiCompact is not used. it is retained for backwards compatibility.
  // (0, 1 or 2, > 2)
  TFarmBudgetPrintFlags = (fbpNone, fbpAscii, fbpBinary, fbpAsciiCompact);
  // IFBPFL: (odd number, even number)
  TFarmBudgetPrintHowMuch = (fbpCompact, fbpDetailed);
  // IRTPFL (-2 and -1, 0, 1 and 2)
  TPrintRouting = (prNoRoutingPrinted, prListingFile, prAscii);
  // IRTPFL (1 and -1, 2 and -2)
  TPrintRoutingFrequency = (prfAllPeriods, prfFirstPeriod);
  // IOPFL (0, 1 and -1, 2 and -2, 3 and -3, 4 and -4)
  // @name is used in conjunction with @link(TAcerageOptimizationPrintLocation)
  // to specify IOPFL
  TAcerageOptimizationPrintChoice = (aopcNone, aopcCellFractions,
    aopcResourceConstraints, aopcCellFractionsAndResourceConstraints,
    aopcMatrix);
  // IOPFL (-1 to -4, 1 to 4)
  // @name is used in conjunction with @link(TAcerageOptimizationPrintChoice)
  // to specify IOPFL
  TAcerageOptimizationPrintLocation = (aoplListing, aoplExternal);
  // IPAPFL
  TDiversionBudgetLocation = (dblListing, dblExternal);
  // inverse of AUX NOCIRNOQ
  // cirNotNeeded, cirNeeded are only for backwards compatiblity
  TCropIrrigationRequirement = (cirContinuously, cirOnlyWhenNeeded,
    cirNotNeeded, cirNeeded);

  //  IRDFL 0, 1, -1
  TRoutedDelivery = (rdNone, rdDiversion, rdAny);

  //  IRRFL 1, -1
  //  IRRFL = 0 can be inferred
  TRoutedReturn = (rrNonDiversion, rrAny);

  // RECOMP_Q_BD option
  TRecomputeOption = (roNotComputed, roComputed);

  // IETPFL
  TEtPrintLocation = (eplText, eplListing);
  // IETPFL
  TEtPrintType = (eptNone, eptET, eptEvapAndTrans, eptList, eptArrayAndList);

  TFarmProcess = class(TModflowPackageSelection)
  private
    FCropIrrigationRequirement: TCropIrrigationRequirement;
    FSaveNetRecharge: TSaveNetRecharge;
    FCropConsumptiveConcept: TCropConsumptiveConcept;
    FEfficiencyReset: TEfficiencyReset;
    FSurfaceWaterAllotment: TSurfaceWaterAllotment;
    FFarmBudgetPrintFlags: TFarmBudgetPrintFlags;
    FPrecipitation: TPrecipitation;
    FConsumptiveUse: TConsumptiveUse;
    FAcerageOptimizationPrintLocation: TAcerageOptimizationPrintLocation;
    FEfficiencyGroundwaterFunction: TEfficiencyGroundwaterFunction;
    FSaveWellFlowRates: TSaveWellFlowRates;
    FFractionOfInefficiencyLosses: TFractionOfInefficiencyLosses;
    FSupplyAndDemand: TSupplyAndDemand;
    FAcerageOptimizationPrintChoice: TAcerageOptimizationPrintChoice;
    FCropConsumptiveLinkage: TCropConsumptiveLinkage;
    FPrintRouting: TPrintRouting;
    FDiversionBudgetLocation: TDiversionBudgetLocation;
    FDeficiencyPolicy: TDeficiencyPolicy;
    FRootingDepth: TRootingDepth;
    FAssignmentMethod: TUpdateMethod;
    FRoutedDelivery: TRoutedDelivery;
    FRoutedReturn: TRoutedReturn;
    FStoredSurfaceWaterClosure: TRealStorage;
    FFarmBudgetPrintHowMuch: TFarmBudgetPrintHowMuch;
    FRecomputeOption: TRecomputeOption;
    FMfFmpEvapRate: TModflowBoundaryDisplayTimeList;
    FMfFmpPrecip: TModflowBoundaryDisplayTimeList;
    FMfFmpCropID: TModflowBoundaryDisplayTimeList;
    FMfFmpMaxPumpingRate: TModflowBoundaryDisplayTimeList;
    FMfFmpFarmWellFarmID: TModflowBoundaryDisplayTimeList;
    FMfFmpFarmWellPumpIfRequired: TModflowBoundaryDisplayTimeList;
    FPrintRoutingFrequency: TPrintRoutingFrequency;
    FGroundwaterAllotmentsUsed: boolean;
    FEtPrintLocation: TEtPrintLocation;
    FEtPrintType: TEtPrintType;
    FMfFmpFarmID: TModflowBoundaryDisplayTimeList;
    FResetMnwQMax: boolean;
    FStoredMnwClosureCriterion: TRealStorage;
    FStoredResidualChangeReduction: TRealStorage;
    FMnwClose: Boolean;
    FStoredHeadChangeReduction: TRealStorage;
    FStoredPsiRampf: TRealStorage;
    FStoredSatThick: TRealStorage;
//    FSurfaceWaterAllotments: Boolean;
    procedure SetAcerageOptimizationPrintChoice(
      const Value: TAcerageOptimizationPrintChoice);
    procedure SetAcerageOptimizationPrintLocation(
      const Value: TAcerageOptimizationPrintLocation);
    procedure SetConsumptiveUse(const Value: TConsumptiveUse);
    procedure SetCropConsumptiveConcept(const Value: TCropConsumptiveConcept);
    procedure SetCropConsumptiveLinkage(const Value: TCropConsumptiveLinkage);
    procedure SetCropIrrigationRequirement(
      Value: TCropIrrigationRequirement);
    procedure SetDeficiencyPolicy(const Value: TDeficiencyPolicy);
    procedure SetDiversionBudgetLocation(const Value: TDiversionBudgetLocation);
    procedure SetEfficiencyGroundwaterFunction(
      Value: TEfficiencyGroundwaterFunction);
    procedure SetEfficiencyReset(const Value: TEfficiencyReset);
    procedure SetFarmBudgetPrintFlags(Value: TFarmBudgetPrintFlags);
    procedure SetFractionOfInefficiencyLosses(
      const Value: TFractionOfInefficiencyLosses);
    procedure SetPrecipitation(const Value: TPrecipitation);
    procedure SetPrintRouting(const Value: TPrintRouting);
    procedure SetRootingDepth(const Value: TRootingDepth);
    procedure SetSaveNetRecharge(Value: TSaveNetRecharge);
    procedure SetSaveWellFlowRates(Value: TSaveWellFlowRates);
    procedure SetSupplyAndDemand(Value: TSupplyAndDemand);
    procedure SetSurfaceWaterAllotment(const Value: TSurfaceWaterAllotment);
    procedure SetAssignmentMethod(const Value: TUpdateMethod);
    procedure SetRoutedDelivery(const Value: TRoutedDelivery);
    procedure SetRoutedReturn(const Value: TRoutedReturn);
    procedure SetStoredSurfaceWaterClosure(const Value: TRealStorage);
    function GetSurfaceWaterClosure: Double;
    procedure SetSurfaceWaterClosure(const Value: Double);
    procedure SetFarmBudgetPrintHowMuch(const Value: TFarmBudgetPrintHowMuch);
    procedure SetRecomputeOption(const Value: TRecomputeOption);
    procedure GetMfFmpEvapUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfFmpPrecipUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfFmpCropIDUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfFmpFarmIDUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfFmpMaxPumpRateUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfFmpFarmWellFarmIDUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetMfFmpFarmWellPumpIfRequiredUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure InitializeFarmRefEtDisplay(Sender: TObject);
    procedure InitializeFarmPrecipDisplay(Sender: TObject);
    procedure InitializeFarmCropIdDisplay(Sender: TObject);
    procedure InitializeFarmIdDisplay(Sender: TObject);
    procedure InitializeFarmWellDisplay(Sender: TObject);
    procedure SetPrintRoutingFrequency(const Value: TPrintRoutingFrequency);
    procedure SetGroundwaterAllotmentsUsed(const Value: boolean);
    procedure SetEtPrintLocation(const Value: TEtPrintLocation);
    procedure SetEtPrintType(const Value: TEtPrintType);
    procedure SetResetMnwQMax(const Value: boolean);
    procedure SetMnwClose(const Value: Boolean);
    procedure SetStoredHeadChangeReduction(const Value: TRealStorage);
    procedure SetStoredMnwClosureCriterion(const Value: TRealStorage);
    procedure SetStoredResidualChangeReduction(const Value: TRealStorage);
    function GetHeadChangeReduction: double;
    function GetMnwClosureCriterion: double;
    function GetResidualChangeReduction: double;
    procedure SetHeadChangeReduction(const Value: double);
    procedure SetMnwClosureCriterion(const Value: double);
    procedure SetResidualChangeReduction(const Value: double);
    procedure SetStoredPsiRampf(const Value: TRealStorage);
    procedure SetStoredSatThick(const Value: TRealStorage);
    function GetPsiRampf: double;
    function GetSatThick: double;
    procedure SetPsiRampf(const Value: double);
    procedure SetSatThick(const Value: double);
    function GetWaterCostCoefficients: TWaterCostCoefficients;
    procedure SetWaterCostCoefficients(const Value: TWaterCostCoefficients);
//    procedure SetSurfaceWaterAllotments(const Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    procedure InitializeVariables; override;
    function EvapUsed (Sender: TObject): boolean;
    function PrecipUsed (Sender: TObject): boolean;
    function CropIdUsed (Sender: TObject): boolean;
    function FarmIdUsed (Sender: TObject): boolean;
    function FarmWellsUsed (Sender: TObject): boolean;
    function FarmWellsPumpRequiredUsed (Sender: TObject): boolean;
    property MfFmpFarmID: TModflowBoundaryDisplayTimeList read FMfFmpFarmID;
    property MfFmpEvapRate: TModflowBoundaryDisplayTimeList read FMfFmpEvapRate;
    property MfFmpPrecip: TModflowBoundaryDisplayTimeList read FMfFmpPrecip;
    property MfFmpCropID: TModflowBoundaryDisplayTimeList read FMfFmpCropID;
    property MfFmpMaxPumpingRate: TModflowBoundaryDisplayTimeList
      read FMfFmpMaxPumpingRate;
    property MfFmpFarmWellFarmID: TModflowBoundaryDisplayTimeList read FMfFmpFarmWellFarmID;
    property MfFmpFarmWellPumpIfRequired: TModflowBoundaryDisplayTimeList
      read FMfFmpFarmWellPumpIfRequired;
    // PCLOSE
    property SurfaceWaterClosure: Double read GetSurfaceWaterClosure
      write SetSurfaceWaterClosure;
    // QCLOSE
    property MnwClosureCriterion: double read GetMnwClosureCriterion
      write SetMnwClosureCriterion;
    // HPCT
    property HeadChangeReduction: double read GetHeadChangeReduction
      write SetHeadChangeReduction;
    // RPCT
    property ResidualChangeReduction: double read GetResidualChangeReduction
      write SetResidualChangeReduction;
    // PSIRAMPF
    property PsiRampf: double read GetPsiRampf write SetPsiRampf;
    // SATTHK
    property SatThick: double read GetSatThick write SetSatThick;
  published
    // IRTFL (1 & 2, 3)
    property RootingDepth: TRootingDepth read FRootingDepth
      write SetRootingDepth;
    // ICUFL (3, 2, 1, -1)
    property ConsumptiveUse: TConsumptiveUse read FConsumptiveUse
      write SetConsumptiveUse;
    // IPFL (2, 3)
    property Precipitation: TPrecipitation read FPrecipitation
      write SetPrecipitation;
    // IIESWFL (0, 1 and 2)
    property FractionOfInefficiencyLosses: TFractionOfInefficiencyLosses
      read FFractionOfInefficiencyLosses write SetFractionOfInefficiencyLosses;
    property FractionOfInefficiencyLoses: TFractionOfInefficiencyLosses
      read FFractionOfInefficiencyLosses write SetFractionOfInefficiencyLosses stored False;
    // IEBFL (0 and 1, 2 and 3)
    // @name is used in conjunction with @link(EfficiencyReset)
    // to specify IEBFL.
    property EfficiencyGroundwaterFunction: TEfficiencyGroundwaterFunction
      read FEfficiencyGroundwaterFunction
      write SetEfficiencyGroundwaterFunction;
    // IEBFL (0 and 2, 1 and 3)
    // @name is used in conjunction with @link(EfficiencyGroundwaterFunction)
    // to specify IEBFL.
    property EfficiencyReset: TEfficiencyReset read FEfficiencyReset
      write SetEfficiencyReset;
    // IDEFFL (-2, -1, 0, 1, 2)
    property DeficiencyPolicy: TDeficiencyPolicy read FDeficiencyPolicy
      write SetDeficiencyPolicy;
    // IALLOTGW
    property GroundwaterAllotmentsUsed: boolean read FGroundwaterAllotmentsUsed
      write SetGroundwaterAllotmentsUsed;

    // ICCFL (1 and 3, 2 and 4)
    // @name is used in conjunction with @link(CropConsumptiveLinkage)
    // to specify ICCFL
    property CropConsumptiveConcept: TCropConsumptiveConcept
      read FCropConsumptiveConcept write SetCropConsumptiveConcept;
    // ICCFL (1 and 2, 3 and 4)
    // @name is used in conjunction with @link(CropConsumptiveConcept)
    // to specify ICCFL
    property CropConsumptiveLinkage: TCropConsumptiveLinkage
      read FCropConsumptiveLinkage write SetCropConsumptiveLinkage;
    // IALLOTSW
    property SurfaceWaterAllotment: TSurfaceWaterAllotment
      read FSurfaceWaterAllotment write SetSurfaceWaterAllotment;
    // IFWLCB
    property SaveWellFlowRates: TSaveWellFlowRates read FSaveWellFlowRates
      write SetSaveWellFlowRates;
    // IFNRCB
    property SaveNetRecharge: TSaveNetRecharge read FSaveNetRecharge
      write SetSaveNetRecharge;
    // ISDPFL
    property SupplyAndDemand: TSupplyAndDemand read FSupplyAndDemand
      write SetSupplyAndDemand;
    // IFBPFL
    // (0, 1 or 2, > 2)
    property FarmBudgetPrintFlags: TFarmBudgetPrintFlags
      read FFarmBudgetPrintFlags write SetFarmBudgetPrintFlags;
    // IFBPFL: (odd number, even number)
    property FarmBudgetPrintHowMuch: TFarmBudgetPrintHowMuch
      read FFarmBudgetPrintHowMuch write SetFarmBudgetPrintHowMuch;
    // IETPFL (positive or negative)
    property EtPrintLocation: TEtPrintLocation read FEtPrintLocation
      write SetEtPrintLocation;
    // IETPFL (0, 1, 2, 3, 4)
    property EtPrintType: TEtPrintType read FEtPrintType write SetEtPrintType;

    // IRTPFL (-2 and -1, 0, 1 and 2)
    property PrintRouting: TPrintRouting read FPrintRouting
      write SetPrintRouting;
  // IRTPFL (1 and -1, 2 and -2)
    property PrintRoutingFrequency: TPrintRoutingFrequency
      read FPrintRoutingFrequency write SetPrintRoutingFrequency;
    // IOPFL (0, 1 and -1, 2 and -2, 3 and -3, 4 and -4)
    // @name is used in conjunction with @link(AcerageOptimizationPrintLocation)
    // to specify IOPFL
    property AcerageOptimizationPrintChoice: TAcerageOptimizationPrintChoice
      read FAcerageOptimizationPrintChoice
      write SetAcerageOptimizationPrintChoice;
    // IOPFL (-1 to -4, 1 to 4)
    // @name is used in conjunction with @link(AcerageOptimizationPrintChoice)
    // to specify IOPFL
    property AcerageOptimizationPrintLocation: TAcerageOptimizationPrintLocation
      read FAcerageOptimizationPrintLocation
      write SetAcerageOptimizationPrintLocation;
    // IPAPFL
    property DiversionBudgetLocation: TDiversionBudgetLocation
      read FDiversionBudgetLocation write SetDiversionBudgetLocation;
    // inverse of AUX NOCIRNOQ
    property CropIrrigationRequirement: TCropIrrigationRequirement
      read FCropIrrigationRequirement write SetCropIrrigationRequirement;
    //  IRDFL 0, 1, -1
    property RoutedDelivery: TRoutedDelivery read FRoutedDelivery
      write SetRoutedDelivery;
    //  IRRFL 0, 1, -1
    property RoutedReturn: TRoutedReturn read FRoutedReturn
      write SetRoutedReturn;

    // PCLOSE
    property StoredSurfaceWaterClosure: TRealStorage
      read FStoredSurfaceWaterClosure write SetStoredSurfaceWaterClosure;
    // RECOMP_Q_BD option
    property RecomputeOption: TRecomputeOption read FRecomputeOption
      write SetRecomputeOption;
    property AssignmentMethod: TUpdateMethod read FAssignmentMethod
      write SetAssignmentMethod Stored True;
    // QMAXRESET
    property ResetMnwQMax: boolean read FResetMnwQMax write SetResetMnwQMax;
    // MNWCLOSE option
    property MnwClose: Boolean read FMnwClose write SetMnwClose;
    // QCLOSE
    property StoredMnwClosureCriterion: TRealStorage
      read FStoredMnwClosureCriterion write SetStoredMnwClosureCriterion;
    // HPCT
    property StoredHeadChangeReduction: TRealStorage
      read FStoredHeadChangeReduction write SetStoredHeadChangeReduction;
    // RPCT
    property StoredResidualChangeReduction: TRealStorage
      read FStoredResidualChangeReduction write SetStoredResidualChangeReduction;
    // PSIRAMPF
    property StoredPsiRampf: TRealStorage read FStoredPsiRampf write SetStoredPsiRampf;
    // SATTHK
    property StoredSatThick: TRealStorage read FStoredSatThick write SetStoredSatThick;

    // @name is only for backwards compatibility.
    property WaterCostCoefficients: TWaterCostCoefficients
      read GetWaterCostCoefficients write SetWaterCostCoefficients stored False;
  end;

  TCfpElevationChoice = (cecIndividual, cecGroup);
  TCfpExchange = (ceNodeConductance, ceWallPermeability);
  TCfpPrintIterations = (cpiNoPrint, cpiPrint);

  TConduitFlowProcess = class(TModflowPackageSelection)
  private
    FConduitLayersUsed: Boolean;
    FStoredLayerTemperature: TRealStorage;
    FCfpPrintIterations: TCfpPrintIterations;
    FPipesUsed: Boolean;
    FMaxIterations: integer;
    FStoredRelax: TRealStorage;
    FStoredElevationOffset: TRealStorage;
    FStoredEpsilon: TRealStorage;
    FCfpExchange: TCfpExchange;
    FCfpElevationChoice: TCfpElevationChoice;
    FStoredConduitTemperature: TRealStorage;
    FMfConduitRechargeFraction: TModflowBoundaryDisplayTimeList;
    FConduitRechargeUsed: boolean;
    FOutputInterval: integer;
    function GetConduitTemperature: double;
    function GetElevationOffset: double;
    function GetEpsilon: double;
    function GetLayerTemperature: double;
    function GetRelax: double;
    procedure SetCfpElevationChoice(const Value: TCfpElevationChoice);
    procedure SetCfpExchange(const Value: TCfpExchange);
    procedure SetCfpPrintIterations(const Value: TCfpPrintIterations);
    procedure SetConduitLayersUsed(const Value: Boolean);
    procedure SetConduitTemperature(const Value: double);
    procedure SetElevationOffset(const Value: double);
    procedure SetEpsilon(const Value: double);
    procedure SetLayerTemperature(const Value: double);
    procedure SetMaxIterations(const Value: integer);
    procedure SetPipesUsed(const Value: Boolean);
    procedure SetRelax(const Value: double);
    procedure SetStoredConduitTemperature(const Value: TRealStorage);
    procedure SetStoredElevationOffset(const Value: TRealStorage);
    procedure SetStoredEpsilon(const Value: TRealStorage);
    procedure SetStoredLayerTemperature(const Value: TRealStorage);
    procedure SetStoredRelax(const Value: TRealStorage);
//    procedure ModelChanged(Sender: TObject);
    procedure SetConduitRechargeUsed(const Value: boolean);
    procedure SetOutputInterval(const Value: integer);
    procedure InitializeRchFractionDisplay(Sender: TObject);
    procedure GetMfRechargeFractionUseList(Sender: TObject;
      NewUseList: TStringList);
    function RechargeFractionUsed (Sender: TObject): boolean;
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    procedure InitializeVariables; override;
    // data set 6
    property ConduitTemperature: double read GetConduitTemperature
      write SetConduitTemperature;
    // data set 12.
    property ElevationOffset: double read GetElevationOffset
      write SetElevationOffset;
    // data set 16.
    property Epsilon: double read GetEpsilon write SetEpsilon;
    // data set 20.
    property Relax: double read GetRelax write SetRelax;
    // data set 36
    property LayerTemperature: double read GetLayerTemperature
      write SetLayerTemperature;
    property MfConduitRechargeFraction: TModflowBoundaryDisplayTimeList
      read FMfConduitRechargeFraction;
  published
    // Mode 1 (or 3)
    property PipesUsed: Boolean read FPipesUsed write SetPipesUsed stored True;
    // Mode 2 (or 3)
    property ConduitLayersUsed: Boolean read FConduitLayersUsed
      write SetConduitLayersUsed stored True;
    property ConduitRechargeUsed: boolean read FConduitRechargeUsed
      write SetConduitRechargeUsed stored True;
    // data set 6
    property StoredConduitTemperature: TRealStorage
      read FStoredConduitTemperature write SetStoredConduitTemperature;
    // data set 12.
    property CfpElevationChoice: TCfpElevationChoice read FCfpElevationChoice
      write SetCfpElevationChoice stored True;
    // data set 12.
    property StoredElevationOffset: TRealStorage read FStoredElevationOffset
      write SetStoredElevationOffset;
    // data set 14.
    property CfpExchange: TCfpExchange read FCfpExchange write SetCfpExchange;
    // data set 16.
    property StoredEpsilon: TRealStorage read FStoredEpsilon
      write SetStoredEpsilon;
    // data set 18.
    property MaxIterations: integer read FMaxIterations
      write SetMaxIterations stored True;
    // data set 20.
    property StoredRelax: TRealStorage read FStoredRelax write SetStoredRelax;
    // data set 22.
    property CfpPrintIterations: TCfpPrintIterations read FCfpPrintIterations
      write SetCfpPrintIterations;
    // data set 36
    property StoredLayerTemperature: TRealStorage read FStoredLayerTemperature
      write SetStoredLayerTemperature;
    // COC file: N_NTS and T_NTS
    property OutputInterval: integer read FOutputInterval
      write SetOutputInterval stored True;
  end;

  TDensityChoice = (dcLinear, dcZoned);
  TSwiObsChoice = (socNone, socAscii, socBinary);
  TSwiSolver = (ssDirect, ssPCG);
  TSwiSolverPrintChoice = (sspcTables, sspcIterationCount, sspcNone,
    sspcOnFailure);

  TModflowPrecision = (mpSingle, mpDouble);
  TSwiPackage = class(TModflowPackageSelection)
  private
    FTipSlope: TRealStorage;
    FSolver: TSwiSolver;
    FAdaptive: Boolean;
    FRELAX: TRealStorage;
    FZCLOSE: TRealStorage;
    FObsChoice: TSwiObsChoice;
    FMaxAdaptiveTimeSteps: integer;
    FZoneDimensionlessDensities: TRealCollection;
    FNBPOL: TPcgEstimateMaxEigenvalue;
    FDensityChoice: TDensityChoice;
    FRCLOSE: TRealStorage;
    FSaveZeta: Boolean;
    FNumberOfSurfaces: integer;
    FAlpha: TRealStorage;
    FDAMPT: TRealStorage;
    FMinAdaptiveTimeSteps: integer;
    FDAMP: TRealStorage;
    FAdaptiveFactor: TRealStorage;
    FToeSlope: TRealStorage;
    FNPCOND: TPcgMethod;
    FSolverPrintChoice: TSwiSolverPrintChoice;
    FMXITER: integer;
    FBeta: TRealStorage;
    FITER1: integer;
    FSolverPrintoutInterval: integer;
    FModflowPrecision: TModflowPrecision;
    procedure SetAdaptive(const Value: Boolean);
    procedure SetAdaptiveFactor(const Value: TRealStorage);
    procedure SetAlpha(const Value: TRealStorage);
    procedure SetBeta(const Value: TRealStorage);
    procedure SetDAMP(const Value: TRealStorage);
    procedure SetDAMPT(const Value: TRealStorage);
    procedure SetDensityChoice(const Value: TDensityChoice);
    procedure SetITER1(const Value: integer);
    procedure SetMaxAdaptiveTimeSteps(const Value: integer);
    procedure SetMinAdaptiveTimeSteps(const Value: integer);
    procedure SetMXITER(const Value: integer);
    procedure SetNBPOL(const Value: TPcgEstimateMaxEigenvalue);
    procedure SetNPCOND(const Value: TPcgMethod);
    procedure SetNumberOfSurfaces(const Value: integer);
    procedure SetObsChoice(const Value: TSwiObsChoice);
    procedure SetRCLOSE(const Value: TRealStorage);
    procedure SetRELAX(const Value: TRealStorage);
    procedure SetSaveZeta(const Value: Boolean);
    procedure SetSolver(const Value: TSwiSolver);
    procedure SetSolverPrintChoice(const Value: TSwiSolverPrintChoice);
    procedure SetSolverPrintoutInterval(const Value: integer);
    procedure SetTipSlope(const Value: TRealStorage);
    procedure SetToeSlope(const Value: TRealStorage);
    procedure SetZCLOSE(const Value: TRealStorage);
    procedure SetZoneDimensionlessDensities(const Value: TRealCollection);
    procedure ValuesChanged(Sender: TObject);
    procedure SetModflowPrecision(const Value: TModflowPrecision);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    Constructor Create(Model: TBaseModel);
    destructor Destroy; override;
    procedure InitializeVariables; override;
  published
    // NSRF
    property NumberOfSurfaces: integer read FNumberOfSurfaces
      write SetNumberOfSurfaces;
    // ISTRAT
    property DensityChoice: TDensityChoice read FDensityChoice
      write SetDensityChoice;
    // ISWIZT
    property SaveZeta: Boolean read FSaveZeta write SetSaveZeta;
    // ISWIOBS  (0, positive number, negative number)
    property ObsChoice: TSwiObsChoice read FObsChoice write SetObsChoice;
    // OPTIONS
    property Adaptive: Boolean read FAdaptive write SetAdaptive;
    // NSOLVER
    property Solver: TSwiSolver read FSolver write SetSolver;
    // IPRSOL
    property SolverPrintoutInterval: integer read FSolverPrintoutInterval
      write SetSolverPrintoutInterval;
    // MUTSOL
    property SolverPrintChoice: TSwiSolverPrintChoice read FSolverPrintChoice
      write SetSolverPrintChoice;

    property MXITER: integer read FMXITER write SetMXITER default 20;
    property ITER1: integer read FITER1 write SetITER1 default 30;
    property NPCOND: TPcgMethod read FNPCOND write SetNPCOND;
    property ZCLOSE: TRealStorage read FZCLOSE write SetZCLOSE;
    property RCLOSE: TRealStorage read FRCLOSE write SetRCLOSE;
    property RELAX: TRealStorage read FRELAX write SetRELAX;
    property NBPOL: TPcgEstimateMaxEigenvalue read FNBPOL write SetNBPOL;
    property DAMP: TRealStorage read FDAMP write SetDAMP;
    property DAMPT: TRealStorage read FDAMPT write SetDAMPT;
    // TOESLOPE
    property ToeSlope: TRealStorage read FToeSlope write SetToeSlope;
    // TIPSLOPE
    property TipSlope: TRealStorage read FTipSlope write SetTipSlope;
    // ALPHA
    property Alpha: TRealStorage read FAlpha write SetAlpha;
    // BETA
    property Beta: TRealStorage read FBeta write SetBeta;
    // NADPTMX
    property MaxAdaptiveTimeSteps: integer read FMaxAdaptiveTimeSteps
      write SetMaxAdaptiveTimeSteps;
    // NADPTMN
    property MinAdaptiveTimeSteps: integer read FMinAdaptiveTimeSteps
      write SetMinAdaptiveTimeSteps;
    // ADPTFCT
    property AdaptiveFactor: TRealStorage read FAdaptiveFactor
      write SetAdaptiveFactor;
    // NU
    property ZoneDimensionlessDensities: TRealCollection
      read FZoneDimensionlessDensities write SetZoneDimensionlessDensities;
    property ModflowPrecision: TModflowPrecision read FModflowPrecision write SetModflowPrecision;
  end;

  TSwrScaling = (ssNone, ssDiagonal, ssL2Norm);
  TSwrReordering = (srNone, srUse, srUseIfImproved);
  TSwrNewtonCorrection = (sncNone, sncImplicit, sncExplicit);
  TSwrFlowToleranceOption = (rtoNone, rtoFractional, rtoL2Norm);
  TSwrExchangeTolerance = (etNone, etGlobal, etAbsolute);
  TSwrPrintOption = (spoNone, spoASCII, spoBinary);
  TSwrSaveRiver = (ssrNone, ssrSaveActive, ssrSaveAll);
  TSwrSaveObservations = (ssoNone, ssoSaveObs, ssoSaveObsAll);
  TSwrObsFormat = (swofAscii, swofBinary);
  TSwrSolver = (ssCrout, ssBi_CGSTAB, ssGMRES);
  TSwrPrintConvergence = (spcPrintMaxResidual, spcIterations, spcNone,
    spcPrintOnFailure);
  TSwrPreconditioner = (spNone, spJacobi, spIlu, spMilu, spIlut);

  TSwrPackage = class(TModflowPackageSelection)
  private
    FExchangeToleranceOption: TSwrExchangeTolerance;
    FPrintInflowsAndOutflows: TSwrPrintOption;
    FScaling: TSwrScaling;
    FFlowToleranceOption: TSwrFlowToleranceOption;
    FSolver: TSwrSolver;
    FContinueDespiteNonConvergence: boolean;
    FLateralInflowSpecification: TSwrSpecificationMethod;
    FReordering: TSwrReordering;
    FConvergencePrintoutInterval: integer;
    FSaveRiver: TSwrSaveRiver;
    FStoredMaxStageChangePerStep: TRealStorage;
    FTimeStepIncreaseFrequency: integer;
    FSaveSwrTimeStepLength: TSwrPrintOption;
    FStoredMinTimeStepLength: TRealStorage;
    FStoredMaxInflowChange: TRealStorage;
    FPreconditioner: TSwrPreconditioner;
    FStageSpecification: TSwrSpecificationMethod;
    FStoredTimeStepMultiplier: TRealStorage;
    FNewtonCorrection: TSwrNewtonCorrection;
    FUseUpstreamWeightingForDiffusiveWave: Boolean;
    FStoredExchangeTolerance: TRealStorage;
    FUseInexactNewton: boolean;
    FStoredFlowTolerance: TRealStorage;
    FStoredSaveFrequency: TRealStorage;
    FPrintReachExchangeAndProperties: TSwrPrintOption;
    FPrintLineSearchInterval: integer;
    FPrintStage: TSwrPrintOption;
    FOnlyUseSWR: boolean;
    FSaveObs: TSwrSaveObservations;
    FUseSteadyStateStorage: Boolean;
    FStoredAlternativeFlowTolerance: TRealStorage;
    FStoredInitialTimeStepLength: TRealStorage;
    FUseLinearDepthScaling: Boolean;
    FStoredTransientDampingFactor: TRealStorage;
    FStoredMaxRainfallForStepAdjustment: TRealStorage;
    FMaxOuterIterations: integer;
    FStoredStageTolerance: TRealStorage;
    FSaveConvergenceHistory: boolean;
    FPrintSwrDataToScreen: boolean;
    FPrintMaxFroude: Boolean;
    FStoredDropThreshold: TRealStorage;
    FSaveAverageSimulatedResults: boolean;
    FPrintConvergence: TSwrPrintConvergence;
    FPrintStructureFlow: TSwrPrintOption;
    FRainSpecification: TSwrSpecificationMethod;
    FMaxLineSearchIterations: integer;
    FUseLaggedStagesAndFlows: Boolean;
    FMaxLevels: integer;
    FMaxInnerIterations: integer;
    FPrintReachLateralFlow: TSwrPrintOption;
    FEvapSpecification: TSwrSpecificationMethod;
    FStoredMaxTimeStepLength: TRealStorage;
    FStoredMinGradientForDiffusiveFlow: TRealStorage;
    FStoredSteadyStateDampingFactor: TRealStorage;
    FStoredMinDepthForOutflow: TRealStorage;
    FRainAssignmentMethod: TUpdateMethod;
    FMfRainfall: TModflowBoundaryDisplayTimeList;
    FEvapAssignmentMethod: TUpdateMethod;
    FMfEvaporation: TModflowBoundaryDisplayTimeList;
    FLatInflowAssignmentMethod: TUpdateMethod;
    FStageAssignmentMethod: TUpdateMethod;
    FMfStage: TModflowBoundaryDisplayTimeList;
    FMfLatInflow: TModflowBoundaryDisplayTimeList;
    FMfDirectRunoffReach: TModflowBoundaryDisplayTimeList;
    FMfDirectRunoffValue: TModflowBoundaryDisplayTimeList;
    FObsFormat: TSwrObsFormat;
    FMfVerticalOffset: TModflowBoundaryDisplayTimeList;
    FMfBoundaryType: TModflowBoundaryDisplayTimeList;
    FMfGeometryNumber: TModflowBoundaryDisplayTimeList;
    procedure SetContinueDespiteNonConvergence(const Value: boolean);
    procedure SetConvergencePrintoutInterval(const Value: integer);
    procedure SetStoredDropThreshold(const Value: TRealStorage);
    procedure SetEvapSpecification(const Value: TSwrSpecificationMethod);
    procedure SetExchangeToleranceOption(const Value: TSwrExchangeTolerance);
    procedure SetFlowToleranceOption(const Value: TSwrFlowToleranceOption);
    procedure SetLateralInflowSpecification(
      const Value: TSwrSpecificationMethod);
    procedure SetStoredMaxInflowChange(const Value: TRealStorage);
    procedure SetMaxInnerIterations(const Value: integer);
    procedure SetMaxLevels(const Value: integer);
    procedure SetMaxLineSearchIterations(const Value: integer);
    procedure SetMaxOuterIterations(const Value: integer);
    procedure SetStoredMaxStageChangePerStep(const Value: TRealStorage);
    procedure SetNewtonCorrection(const Value: TSwrNewtonCorrection);
    procedure SetOnlyUseSWR(const Value: boolean);
    procedure SetPreconditioner(const Value: TSwrPreconditioner);
    procedure SetPrintConvergence(const Value: TSwrPrintConvergence);
    procedure SetPrintInflowsAndOutflows(const Value: TSwrPrintOption);
    procedure SetPrintLineSearchInterval(const Value: integer);
    procedure SetPrintMaxFroude(const Value: Boolean);
    procedure SetPrintReachExchangeAndProperties(const Value: TSwrPrintOption);
    procedure SetPrintReachLateralFlow(const Value: TSwrPrintOption);
    procedure SetPrintStage(const Value: TSwrPrintOption);
    procedure SetPrintStructureFlow(const Value: TSwrPrintOption);
    procedure SetPrintSwrDataToScreen(const Value: boolean);
    procedure SetRainSpecification(const Value: TSwrSpecificationMethod);
    procedure SetReordering(const Value: TSwrReordering);
    procedure SetSaveAverageSimulatedResults(const Value: boolean);
    procedure SetSaveConvergenceHistory(const Value: boolean);
    procedure SetSaveObs(const Value: TSwrSaveObservations);
    procedure SetSaveRiver(const Value: TSwrSaveRiver);
    procedure SetSaveSwrTimeStepLength(const Value: TSwrPrintOption);
    procedure SetScaling(const Value: TSwrScaling);
    procedure SetSolver(const Value: TSwrSolver);
    procedure SetStageSpecification(const Value: TSwrSpecificationMethod);
    procedure SetStoredAlternativeFlowTolerance(const Value: TRealStorage);
    procedure SetStoredExchangeTolerance(const Value: TRealStorage);
    procedure SetStoredFlowTolerance(const Value: TRealStorage);
    procedure SetStoredInitialTimeStepLength(const Value: TRealStorage);
    procedure SetStoredMaxRainfallForStepAdjustment(const Value: TRealStorage);
    procedure SetStoredMaxTimeStepLength(const Value: TRealStorage);
    procedure SetStoredMinDepthForOutflow(const Value: TRealStorage);
    procedure SetStoredMinGradientForDiffusiveFlow(const Value: TRealStorage);
    procedure SetStoredMinTimeStepLength(const Value: TRealStorage);
    procedure SetStoredSaveFrequency(const Value: TRealStorage);
    procedure SetStoredStageTolerance(const Value: TRealStorage);
    procedure SetStoredSteadyStateDampingFactor(const Value: TRealStorage);
    procedure SetStoredTimeStepMultiplier(const Value: TRealStorage);
    procedure SetStoredTransientDampingFactor(const Value: TRealStorage);
    procedure SetTimeStepIncreaseFrequency(const Value: integer);
    procedure SetUseInexactNewton(const Value: boolean);
    procedure SetUseLaggedStagesAndFlows(const Value: Boolean);
    procedure SetUseLinearDepthScaling(const Value: Boolean);
    procedure SetUseSteadyStateStorage(const Value: Boolean);
    procedure SetUseUpstreamWeightingForDiffusiveWave(const Value: Boolean);
    function GetAlternativeFlowTolerance: double;
    function GetDropThreshold: double;
    function GetExchangeTolerance: double;
    function GetFlowTolerance: double;
    function GetInitialTimeStepLength: double;
    function GetMaxInflowChange: double;
    function GetMaxRainfallForStepAdjustment: double;
    function GetMaxStageChangePerStep: double;
    function GetMaxTimeStepLength: double;
    function GetMinDepthForOutflow: double;
    function GetMinGradientForDiffusiveFlow: double;
    function GetMinTimeStepLength: double;
    function GetStageTolerance: double;
    function GetSteadyStateDampingFactor: double;
    function GetTimeStepMultiplier: double;
    function GetTransientDampingFactor: double;
    procedure SetAlternativeFlowTolerance(const Value: double);
    procedure SetDropThreshold(const Value: double);
    procedure SetExchangeTolerance(const Value: double);
    procedure SetFlowTolerance(const Value: double);
    procedure SetInitialTimeStepLength(const Value: double);
    procedure SetMaxInflowChange(const Value: double);
    procedure SetMaxRainfallForStepAdjustment(const Value: double);
    procedure SetMaxStageChangePerStep(const Value: double);
    procedure SetMaxTimeStepLength(const Value: double);
    procedure SetMinDepthForOutflow(const Value: double);
    procedure SetMinGradientForDiffusiveFlow(const Value: double);
    procedure SetMinTimeStepLength(const Value: double);
    procedure SetStageTolerance(const Value: double);
    procedure SetSteadyStateDampingFactor(const Value: double);
    procedure SetTimeStepMultiplier(const Value: double);
    procedure SetTransientDampingFactor(const Value: double);
    function GetSaveFrequency: Double;
    procedure SetSaveFrequency(const Value: Double);
    procedure SetRainAssignmentMethod(const Value: TUpdateMethod);
    procedure InitializeSwrRainDisplay(Sender: TObject);
    procedure InitializeSwrEvapDisplay(Sender: TObject);
    procedure InitializeSwrLatInflowDisplay(Sender: TObject);
    procedure InitializeSwrStageDisplay(Sender: TObject);
    procedure InitializeSwrDirectRunoffDisplay(Sender: TObject);
    procedure InitializeVerticalOffsetDisplay(Sender: TObject);
    procedure InitializeBoundaryTypeDisplay(Sender: TObject);
    procedure InitializeGeometryNumberDisplay(Sender: TObject);
    procedure GetMfRainUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfEvapUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfLatInflUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfStageUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfVerticalOffsetUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetEmptyUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfDirectRunoffReachUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMfDirectRunoffValueUseList(Sender: TObject; NewUseList: TStringList);
    procedure SetEvapAssignmentMethod(const Value: TUpdateMethod);
    procedure SetLatInflowAssignmentMethod(const Value: TUpdateMethod);
    procedure SetStageAssignmentMethod(const Value: TUpdateMethod);
    procedure SaveObsFormat(const Value: TSwrObsFormat);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with a TNotifyEvent or interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
    procedure ValuesChanged(Sender: TObject);
    // Group 2: Time step options

    //  RTINI, Data Set 2
    property InitialTimeStepLength: double read GetInitialTimeStepLength
      write SetInitialTimeStepLength;
    //  RTMIN, Data Set 2
    property MinTimeStepLength: double read GetMinTimeStepLength
      write SetMinTimeStepLength;
    //  RTMAX, Data Set 2
    property MaxTimeStepLength: double read GetMaxTimeStepLength
      write SetMaxTimeStepLength;
    //  RTMULT, Data Set 2
    property TimeStepMultiplier: double read GetTimeStepMultiplier
      write SetTimeStepMultiplier;
    //  DMINGRAD, Data Set 2
    property MinGradientForDiffusiveFlow: double
      read GetMinGradientForDiffusiveFlow write SetMinGradientForDiffusiveFlow;
    //  DMINDPTH, Data Set 2
    property MinDepthForOutflow: double read GetMinDepthForOutflow
      write SetMinDepthForOutflow;
    //  DMAXRAI, Data Set 2
    property MaxRainfallForStepAdjustment: double
      read GetMaxRainfallForStepAdjustment write SetMaxRainfallForStepAdjustment;
    //  DMAXSTG, Data Set 2
    property MaxStageChangePerStep: double read GetMaxStageChangePerStep
      write SetMaxStageChangePerStep;
    //  DMAXINF, Data Set 2
    property MaxInflowChange: double read GetMaxInflowChange
      write SetMaxInflowChange;
    // RTPRN, Data Set 2
    property SaveFrequency: Double read GetSaveFrequency write SetSaveFrequency;
    // Group 5: Solver

    // TOLS Data Set 3
    property StageTolerance: double read GetStageTolerance
      write SetStageTolerance;
    // TOLR Data Set 3
    property FlowTolerance: double read GetFlowTolerance write SetFlowTolerance;
    // TOLA Data Set 3
    property ExchangeTolerance: double read GetExchangeTolerance
      write SetExchangeTolerance;
    // DAMPSS Data Set 3
    property SteadyStateDampingFactor: double read GetSteadyStateDampingFactor
      write SetSteadyStateDampingFactor;
    // DAMPTR Data Set 3
    property TransientDampingFactor: double read GetTransientDampingFactor
      write SetTransientDampingFactor;
    // DROPTOL Data Set 3
    property DropThreshold: double read GetDropThreshold write SetDropThreshold;
    // PTOLR Data Set 3
    property AlternativeFlowTolerance: double read GetAlternativeFlowTolerance
      write SetAlternativeFlowTolerance;

    property MfRainfall: TModflowBoundaryDisplayTimeList
      read FMfRainfall;
    property MfEvaporation: TModflowBoundaryDisplayTimeList
      read FMfEvaporation;
    property MfLatInflow: TModflowBoundaryDisplayTimeList
      read FMfLatInflow;
    property MfStage: TModflowBoundaryDisplayTimeList
      read FMfStage;
    property MfDirectRunoffReach: TModflowBoundaryDisplayTimeList
      read FMfDirectRunoffReach;
    property MfDirectRunoffValue: TModflowBoundaryDisplayTimeList
      read FMfDirectRunoffValue;
    property MfVerticalOffset: TModflowBoundaryDisplayTimeList
      read FMfVerticalOffset;
    property MfBoundaryType: TModflowBoundaryDisplayTimeList
      read FMfBoundaryType;
    property MfGeometryNumber: TModflowBoundaryDisplayTimeList
      read FMfGeometryNumber;
  published
    // Group 1: solution options

    // ISWRONLY Data set 1a
    property OnlyUseSWR: boolean read FOnlyUseSWR write SetOnlyUseSWR
      stored True;
    // CSWROPT USE_NONCONVERGENCE_CONTINUE Data set 1b
    property ContinueDespiteNonConvergence: boolean
      read FContinueDespiteNonConvergence write SetContinueDespiteNonConvergence
      stored True;
    // CSWROPT USE_UPSTREAM_WEIGHTING Data set 1b
    property UseUpstreamWeightingForDiffusiveWave: Boolean
      read FUseUpstreamWeightingForDiffusiveWave
      write SetUseUpstreamWeightingForDiffusiveWave stored True;
    // CSWROPT USE_INEXACT_NEWTON Data set 1b
    property UseInexactNewton: boolean read FUseInexactNewton
      write SetUseInexactNewton stored True;
    // CSWROPT USE_STEADYSTATE_STORAGE Data set 1b
    property UseSteadyStateStorage: Boolean read FUseSteadyStateStorage
      write SetUseSteadyStateStorage stored True;
    // CSWROPT USE_LAGGED_OPR_DATA Data set 1b
    property UseLaggedStagesAndFlows: Boolean read FUseLaggedStagesAndFlows
      write SetUseLaggedStagesAndFlows stored True;
    // CSWROPT USE_LINEAR_DEPTH_SCALING Data set 1b
    property UseLinearDepthScaling: Boolean read FUseLinearDepthScaling
      write SetUseLinearDepthScaling stored True;
    // CSWROPT USE_DIAGONAL_SCALING Data set 1b
    // CSWROPT USE_L2NORM_SCALING Data set 1b
    property Scaling: TSwrScaling read FScaling write SetScaling stored True;
    // CSWROPT USE_RCMREORDERING Data set 1b
    // CSWROPT USE_RCMREORDERING_IF_IMPROVEMENT Data set 1b
    property Reordering: TSwrReordering read FReordering write SetReordering
      stored True;
    // CSWROPT USE_IMPLICIT_NEWTON_CORRECTION Data set 1b
    // CSWROPT USE_EXPLICIT_NEWTON_CORRECTION Data set 1b
    property NewtonCorrection: TSwrNewtonCorrection read FNewtonCorrection
      write SetNewtonCorrection stored True;

    // Group 2: Time step options

    //  RTINI, Data Set 2
    property StoredInitialTimeStepLength: TRealStorage
      read FStoredInitialTimeStepLength write SetStoredInitialTimeStepLength;
    //  RTMIN, Data Set 2
    property StoredMinTimeStepLength: TRealStorage read FStoredMinTimeStepLength
      write SetStoredMinTimeStepLength;
    //  RTMAX, Data Set 2
    property StoredMaxTimeStepLength: TRealStorage read FStoredMaxTimeStepLength
      write SetStoredMaxTimeStepLength;
    //  RTMULT, Data Set 2
    property StoredTimeStepMultiplier: TRealStorage
      read FStoredTimeStepMultiplier write SetStoredTimeStepMultiplier;
    //  NTMULT, Data Set 2
    property TimeStepIncreaseFrequency: integer read FTimeStepIncreaseFrequency
      write SetTimeStepIncreaseFrequency stored True;
    //  DMINGRAD, Data Set 2
    property StoredMinGradientForDiffusiveFlow: TRealStorage
      read FStoredMinGradientForDiffusiveFlow
      write SetStoredMinGradientForDiffusiveFlow;
    //  DMINDPTH, Data Set 2
    property StoredMinDepthForOutflow: TRealStorage
      read FStoredMinDepthForOutflow write SetStoredMinDepthForOutflow;
    //  DMAXRAI, Data Set 2
    property StoredMaxRainfallForStepAdjustment: TRealStorage
      read FStoredMaxRainfallForStepAdjustment
      write SetStoredMaxRainfallForStepAdjustment;
    //  DMAXSTG, Data Set 2
    property StoredMaxStageChangePerStep: TRealStorage
      read FStoredMaxStageChangePerStep write SetStoredMaxStageChangePerStep;
    //  DMAXINF, Data Set 2
    property StoredMaxInflowChange: TRealStorage read FStoredMaxInflowChange
      write SetStoredMaxInflowChange;

    // Group 3 Methods for specifying data, Data Set 5

    //  Sign of IRDRAI, Data Set 5
    property RainSpecification: TSwrSpecificationMethod read FRainSpecification
      write SetRainSpecification stored True;
    //  Sign of IRDEVP, Data Set 5
    property EvapSpecification: TSwrSpecificationMethod read FEvapSpecification
      write SetEvapSpecification stored True;
    //  Sign of IRDLIN, Data Set 5
    property LateralInflowSpecification: TSwrSpecificationMethod
      read FLateralInflowSpecification write SetLateralInflowSpecification
      stored True;
    //  Sign of IRDSTG, Data Set 5
    property StageSpecification: TSwrSpecificationMethod
      read FStageSpecification write SetStageSpecification stored True;

    // Group 4:   Print flags
    //
    //  ISWRPRGF Data Set 1a
    property PrintInflowsAndOutflows: TSwrPrintOption
      read FPrintInflowsAndOutflows write SetPrintInflowsAndOutflows
      stored True;
    //  ISWRPSTG Data Set 1a
    property PrintStage: TSwrPrintOption read FPrintStage write SetPrintStage
      stored True;
    //  ISWRPQAQ Data Set 1a
    property PrintReachExchangeAndProperties: TSwrPrintOption
      read FPrintReachExchangeAndProperties
      write SetPrintReachExchangeAndProperties stored True;
    //  ISWRPQM Data Set 1a
    property PrintReachLateralFlow: TSwrPrintOption read FPrintReachLateralFlow
      write SetPrintReachLateralFlow stored True;
    //  ISWRPSTR Data Set 1a
    property PrintStructureFlow: TSwrPrintOption read FPrintStructureFlow
      write SetPrintStructureFlow stored True;
    //  ISWRPFRN Data Set 1a
    property PrintMaxFroude: Boolean read FPrintMaxFroude
      write SetPrintMaxFroude stored True;
    // CSWROPT PRINT_SWR_TO_SCREEN, Data Set 1b
    property PrintSwrDataToScreen: boolean read FPrintSwrDataToScreen
      write SetPrintSwrDataToScreen stored True;
    // CSWROPT SAVE_SWRDT, Data Set 1b
    property SaveSwrTimeStepLength: TSwrPrintOption read FSaveSwrTimeStepLength
      write SetSaveSwrTimeStepLength stored True;
    // CSWROPT SAVE_AVERAGE_RESULTS, Data Set 1b
    property SaveAverageSimulatedResults: boolean
      read FSaveAverageSimulatedResults write SetSaveAverageSimulatedResults
      stored True;
    // CSWROPT SAVE_CONVERGENCE_HISTORY, Data Set 1b
    property SaveConvergenceHistory: boolean read FSaveConvergenceHistory
      write SetSaveConvergenceHistory stored True;
    // CSWROPT SAVE_RIVER_PACKAGE, SAVE_RIVER_PACKAGE_ALL, Data Set 1b
    Property SaveRiver: TSwrSaveRiver read FSaveRiver write SetSaveRiver
      stored True;
    // CSWROPT SAVE_SWROBSERVATIONS, SAVE_SWROBSERVATIONS_ALL,  Data Set 1b
    property SaveObs: TSwrSaveObservations read FSaveObs write SetSaveObs
      stored True;
    // CSWROPT SAVE_SWROBSERVATIONS, SAVE_SWROBSERVATIONS_ALL,  Data Set 1b
    property ObsFormat: TSwrObsFormat read FObsFormat Write SaveObsFormat
      stored True;
    //  Data Set 2: RTPRN
    property StoredSaveFrequency: TRealStorage read FStoredSaveFrequency
      write SetStoredSaveFrequency;

    // Group 5: Solver

    // ISOLVER Data Set 3
    property Solver: TSwrSolver read FSolver write SetSolver stored True;
    // NOUTER Data Set 3
    property MaxOuterIterations: integer read FMaxOuterIterations
      write SetMaxOuterIterations stored True;
    // NINNER Data Set 3
    property MaxInnerIterations: integer read FMaxInnerIterations
      write SetMaxInnerIterations stored True;
    // IBT Data Set 3
    property MaxLineSearchIterations: integer read FMaxLineSearchIterations
      write SetMaxLineSearchIterations stored True;
    // TOLS Data Set 3
    property StoredStageTolerance: TRealStorage read FStoredStageTolerance
      write SetStoredStageTolerance;
    // CSWROPT USE_FRACTIONAL_TOLR Data set 1b
    // CSWROPT USE_L2NORM_TOLR Data set 1b
    property FlowToleranceOption: TSwrFlowToleranceOption
      read FFlowToleranceOption write SetFlowToleranceOption stored True;
    // TOLR Data Set 3
    property StoredFlowTolerance: TRealStorage read FStoredFlowTolerance
      write SetStoredFlowTolerance;
    // CSWROPT USE_GLOBAL_TOLA Data set 1b
    // CSWROPT USE_ABSOLUTE_TOLA Data set 1b
    property ExchangeToleranceOption: TSwrExchangeTolerance
      read FExchangeToleranceOption write SetExchangeToleranceOption
      stored True;
    // TOLA Data Set 3
    property StoredExchangeTolerance: TRealStorage read FStoredExchangeTolerance
      write SetStoredExchangeTolerance;
    // DAMPSS Data Set 3
    property StoredSteadyStateDampingFactor: TRealStorage
      read FStoredSteadyStateDampingFactor
      write SetStoredSteadyStateDampingFactor;
    // DAMPTR Data Set 3
    property StoredTransientDampingFactor: TRealStorage
      read FStoredTransientDampingFactor write SetStoredTransientDampingFactor;
    // IPRSWR Data Set 3
    property ConvergencePrintoutInterval: integer
      read FConvergencePrintoutInterval write SetConvergencePrintoutInterval
      stored True;
    // MUTSWR Data Set 3
    property PrintConvergence: TSwrPrintConvergence read FPrintConvergence
      write SetPrintConvergence stored True;
    // IPC Data Set 3
    property Preconditioner: TSwrPreconditioner read FPreconditioner
      write SetPreconditioner stored True;
    // NLEVELS Data Set 3
    property MaxLevels: integer read FMaxLevels write SetMaxLevels stored True;
    // DROPTOL Data Set 3
    property StoredDropThreshold: TRealStorage read FStoredDropThreshold
      write SetStoredDropThreshold;
    // IBTPRT Data Set 3
    property PrintLineSearchInterval: integer read FPrintLineSearchInterval
      write SetPrintLineSearchInterval stored True;
    // PTOLR Data Set 3
    property StoredAlternativeFlowTolerance: TRealStorage
      read FStoredAlternativeFlowTolerance
      write SetStoredAlternativeFlowTolerance;
    // other
    property RainAssignmentMethod: TUpdateMethod read FRainAssignmentMethod
      write SetRainAssignmentMethod Stored True;
    property EvapAssignmentMethod: TUpdateMethod read FEvapAssignmentMethod
      write SetEvapAssignmentMethod Stored True;
    property LatInflowAssignmentMethod: TUpdateMethod
      read FLatInflowAssignmentMethod
      write SetLatInflowAssignmentMethod Stored True;
    property StageAssignmentMethod: TUpdateMethod read FStageAssignmentMethod
      write SetStageAssignmentMethod Stored True;
  end;

  TMnw1LossType = (mlt1Skin, mlt1Linear, mlt1NonLinear);
  TMnw1LossTypes = set of TMnw1LossType;
  TMnw1PrintFrequency = (mpfOutputControl, mpfAll);

  //  inferred  values
  //  kspref reference stress period for calculating drawdown.
  //  IWELPT Print well information

  //
  TMnw1Package = class(TModflowPackageSelection)
  private
    FLossType: TMnw1LossType;
    FStoredLossExponent: TRealStorage;
    FMaxMnwIterations: integer;
    FWellFileName: string;
    FQSumFileName: string;
    FByNodeFileName: string;
    FQSumPrintFrequency: TMnw1PrintFrequency;
    FByNodePrintFrequency: TMnw1PrintFrequency;
    FMfDesiredPumpingRate: TModflowBoundaryDisplayTimeList;
    FMfSkinFactor: TModflowBoundaryDisplayTimeList;
    FMfReactivationPumpingRate: TModflowBoundaryDisplayTimeList;
    FMfWellRadius: TModflowBoundaryDisplayTimeList;
    FMfWaterQualityGroup: TModflowBoundaryDisplayTimeList;
    FMfWaterQuality: TModflowBoundaryDisplayTimeList;
    FMfConductance: TModflowBoundaryDisplayTimeList;
    FMfNonLinearLossCoefficient: TModflowBoundaryDisplayTimeList;
    FMfLimitingWaterLevel: TModflowBoundaryDisplayTimeList;
    FMfReferenceElevation: TModflowBoundaryDisplayTimeList;
    FMfMinimumPumpingRate: TModflowBoundaryDisplayTimeList;

    procedure InitializeMnw1(Sender: TObject);
    procedure GetDesiredPumpingRateUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetWaterQualityUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetWellRadiusUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetConductanceUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetSkinUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetLimitingWaterLevelUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetReferenceElevationUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetWaterQualityGroupUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetNonLinearLossCoefficientUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetMinimumPumpingRateUseList(Sender: TObject; NewUseList: TStringList);
    procedure GetReactivationPumpingRateUseList(Sender: TObject; NewUseList: TStringList);

    function GetLossExponent: Double;
    procedure SetByNodeFileName(const Value: string);
    procedure SetLossExponent(const Value: Double);
    procedure SetLossType(const Value: TMnw1LossType);
    procedure SetMaxMnwIterations(const Value: integer);
    procedure SetQSumFileName(const Value: string);
    procedure SetStoredLossExponent(const Value: TRealStorage);
    procedure SetWellFileName(const Value: string);
    procedure SetByNodePrintFrequency(const Value: TMnw1PrintFrequency);
    procedure SetQSumPrintFrequency(const Value: TMnw1PrintFrequency);
    procedure GetUseList(ParameterIndex: Integer; NewUseList: TStringList);
    function GetRelativeQSumFileName: string;
    procedure SetRelativeQSumFileName(const Value: string);
    function GetRelativeByNodeFileName: string;
    function GetRelativeWellFileName: string;
    procedure SetRelativeByNodeFileName(const Value: string);
    procedure SetRelativeWellFileName(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    { TODO -cRefactor : Consider replacing Model with a TNotifyEvent or interface. }
    //
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure InitializeVariables; override;
    // PLossMNW
    property LossExponent: Double read GetLossExponent write  SetLossExponent;

    property MfDesiredPumpingRate: TModflowBoundaryDisplayTimeList
      read FMfDesiredPumpingRate;
    property MfWaterQuality: TModflowBoundaryDisplayTimeList
      read FMfWaterQuality;
    property MfWellRadius: TModflowBoundaryDisplayTimeList
      read FMfWellRadius;
    property MfConductance: TModflowBoundaryDisplayTimeList
      read FMfConductance;
    property MfSkinFactor: TModflowBoundaryDisplayTimeList
      read FMfSkinFactor;
    property MfLimitingWaterLevel: TModflowBoundaryDisplayTimeList
      read FMfLimitingWaterLevel;
    property MfReferenceElevation: TModflowBoundaryDisplayTimeList
      read FMfReferenceElevation;
    property MfWaterQualityGroup: TModflowBoundaryDisplayTimeList
      read FMfWaterQualityGroup;
    property MfNonLinearLossCoefficient: TModflowBoundaryDisplayTimeList
      read FMfNonLinearLossCoefficient;
    property MfMinimumPumpingRate: TModflowBoundaryDisplayTimeList
      read FMfMinimumPumpingRate;
    property MfReactivationPumpingRate: TModflowBoundaryDisplayTimeList
      read FMfReactivationPumpingRate;
  published
    // NOMOITER
    property MaxMnwIterations: integer read FMaxMnwIterations
      write SetMaxMnwIterations;
    // LOSSTYPE
    property LossType: TMnw1LossType read FLossType write SetLossType;
    // PLossMNW
    property StoredLossExponent: TRealStorage read FStoredLossExponent
      write SetStoredLossExponent;
    // iunw1
    property WellFileName: string read FWellFileName write SetWellFileName
      stored False;
    property RelativeWellFileName: string read GetRelativeWellFileName
      write SetRelativeWellFileName;
    // iunby
    property ByNodeFileName: string read FByNodeFileName
      write SetByNodeFileName stored False;
    property RelativeByNodeFileName: string read GetRelativeByNodeFileName
      write SetRelativeByNodeFileName;
    property ByNodePrintFrequency: TMnw1PrintFrequency
      read FByNodePrintFrequency write SetByNodePrintFrequency;
    // iunqs
    property QSumFileName: string read FQSumFileName write SetQSumFileName stored False;
    property RelativeQSumFileName: string Read GetRelativeQSumFileName
      write SetRelativeQSumFileName;
    property QSumPrintFrequency: TMnw1PrintFrequency read FQSumPrintFrequency
      write SetQSumPrintFrequency;
  end;

  TWritePlantGroupET = (wpgDontWrite, wpgWrite);

  TRipPackage = class(TModflowPackageSelection)
  private
    FWritePlantGroupET: TWritePlantGroupET;
    FMfRipLandElevation: TModflowBoundaryDisplayTimeList;
    FCoverageTimeLists: TObjectModflowBoundListOfTimeLists;
    FCoverageIDs: TList<Integer>;
    procedure SetWritePlantGroupET(const Value: TWritePlantGroupET);
    procedure GetMfRipLandElevationUseList(Sender: TObject;
      NewUseList: TStringList);
    procedure GetUseList(ParameterIndex: Integer; NewUseList: TStringList);
    procedure InitializeRipDisplay(Sender: TObject);
    procedure GetCoverageUseList(Sender: TObject; NewUseList: TStringList);
  public
    Constructor Create(Model: TBaseModel);
    Destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property MfRipLandElevation: TModflowBoundaryDisplayTimeList
      read FMfRipLandElevation;
    procedure UpdateCoverageTimeLists;
    procedure InitializeVariables; override;
    procedure InvalidateCoverages;
  published
    property WritePlantGroupET: TWritePlantGroupET read FWritePlantGroupET
      write SetWritePlantGroupET;
  end;

const
  KMaxRainfallForStepAdjustment = 0.15;
  KMaxStageChangePerStep = 0.5;
  KPreconditioner = spMilu;
  KMaxLevels = 7;
  KDropThreshold = 1e-3;
  KAlternativeFlowTolerance = 100;

implementation

uses Math, Contnrs , PhastModelUnit, ModflowOptionsUnit,
  frmErrorsAndWarningsUnit, ModflowSfrParamIcalcUnit,
  ModflowWellWriterUnit, ModflowGHB_WriterUnit,
  ModflowDRN_WriterUnit, ModflowDRT_WriterUnit, ModflowRiverWriterUnit,
  ModflowCHD_WriterUnit, ModflowEVT_WriterUnit, ModflowEvtUnit, RbwParser,
  frmFormulaErrorsUnit, ModflowRCH_WriterUnit, ModflowRchUnit,
  ModflowETS_WriterUnit, ModflowEtsUnit, ModflowUzfWriterUnit, ModflowUzfUnit,
  ModflowSfrWriterUnit, ModflowSfrUnit, ModflowSfrReachUnit, ModflowSfrFlows,
  ModflowSfrChannelUnit, ModflowSfrEquationUnit, ModflowSfrSegment,
  ModflowSfrUnsatSegment, ModflowMNW2_WriterUnit, ModflowMnw2Unit,
  LayerStructureUnit, ModflowSubsidenceDefUnit, frmGridValueUnit,
  frmGoPhastUnit, CustomModflowWriterUnit, frmDisplayDataUnit,
  Mt3dmsSsmWriterUnit, Mt3dmsChemUnit, ModflowStrUnit, ModflowStrWriterUnit,
  ModflowFhbWriterUnit, ModflowFmpEvapUnit, ModflowFmpWriterUnit,
  ModflowFmpPrecipitationUnit, ModflowFmpCropUnit, ModflowFmpCropSpatialUnit,
  ModflowFmpWellUnit, ModflowCfpWriterUnit, ModflowCfpRechargeUnit,
  ModflowSwrWriterUnit, ModflowSwrUnit, ModflowSwrDirectRunoffUnit,
  ModflowSwrReachUnit, ModflowMnw1Writer, ModflowMnw1Unit, ModflowFmpFarmIdUnit,
  ModflowRipUnit, ModflowRipWriterUnit, ModflowRipPlantGroupsUnit;

resourcestring
  StrLengthUnitsForMod = 'Length units for model are undefined';
  SfrError = 'SFR Error';
  StrTimeUnitsForModel = 'Time units for model are undefined';
  StrInTheSubsidencePa = 'In the Subsidence package, one or more starting ti' +
  'me is after the ending time';
  StrInTheSubsidenceAn = 'In the Subsidence and Aquifer-System Compaction Pa' +
  'ckage for Water-Table Aquifers, one or more starting time is after the en' +
  'ding time';
  StrStartingTime0g = 'StartingTime: %:0g; EndingTime: %1:g';
  StrXYOrZCoordinat = 'X, Y, or Z coordinate formula';
  StrWellPumpingRate = 'Well Pumping Rate';
  StrGHBBoundaryHead = 'GHB Boundary Head';
  StrGHBConductance = 'GHB Conductance';
  StrDrainConductance = 'Drain Conductance';
  StrDrainReturnConduct = 'Drain Return Conductance';
  StrDrainReturnElevati = 'Drain Return Elevation';
  StrDrainReturnFractio = 'Drain Return Fraction';
  StrRiverBottomElevati = 'River Bottom Elevation';
  StrRiverConductance = 'River Conductance';
  StrCHDEndingHead = 'CHD Ending Head';
  StrCHDStartingHead = 'CHD Starting Head';


{ TModflowPackageSelection }

procedure TModflowPackageSelection.AddTimeList(TimeList: TCustomTimeList);
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  Assert(FModel <> nil);
  (FModel as TCustomModel).AddTimeList(TimeList);
end;

procedure TModflowPackageSelection.Assign(Source: TPersistent);
var
  SourceItem: TModflowPackageSelection;
begin
  if Source is TModflowPackageSelection then
  begin
    SourceItem := TModflowPackageSelection(Source);
    Comments := SourceItem.Comments;
    IsSelected := SourceItem.IsSelected;
  end
  else
  begin
    inherited;
  end;
end;

constructor TModflowPackageSelection.Create(Model: TBaseModel);
begin
  inherited Create;
  Assert((Model = nil) or (Model is TCustomModel));
  FModel := Model;
  FComments := TStringList.Create;
end;

destructor TModflowPackageSelection.Destroy;
begin
  FComments.Free;
  inherited;
end;

procedure TModflowPackageSelection.InitializeVariables;
begin
  IsSelected := False;
  Comments.Clear;
end;

procedure TModflowPackageSelection.InvalidateAllTimeLists;
begin

end;

procedure TModflowPackageSelection.InvalidateModel;
begin
  if FModel <> nil then
  begin
    { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent. }
    FModel.Invalidate(self);
  end;
end;

function TModflowPackageSelection.PackageUsed(Sender: TObject): boolean;
begin
  result := IsSelected;
end;

procedure TModflowPackageSelection.RemoveTimeList(TimeList: TCustomTimeList);
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  if (FModel <> nil) then
  begin
    (FModel as TCustomModel).RemoveTimeList(TimeList);
  end;
end;

procedure TModflowPackageSelection.SetBooleanProperty(var Field: boolean;
  const Value: boolean);
begin
  if Field <> Value then
  begin
    Field := Value;
    InvalidateModel;
  end;
end;

procedure TModflowPackageSelection.SetComments(const Value: TStrings);
begin
  FComments.Assign(Value);
  InvalidateModel;
end;

procedure TModflowPackageSelection.SetIntegerProperty(var Field: integer;
  const Value: integer);
begin
  if Field <> Value then
  begin
    Field := Value;
    InvalidateModel;
  end;
end;

procedure TModflowPackageSelection.SetIsSelected(const Value: boolean);
begin
  if FIsSelected <> Value then
  begin
    InvalidateModel;
    FIsSelected := Value;
    { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
    if FModel <> nil then
    begin
      InvalidateAllTimeLists;
      UpdateFrmDisplayData;
      UpdateFrmGridValue;
    end;
    if Assigned(OnSelectionChange) then
    begin
      OnSelectionChange(Self);
    end;
  end;
end;

procedure TModflowPackageSelection.SetOnSelectionChange(
  const Value: TNotifyEvent);
begin
  FOnSelectionChange := Value;
end;

procedure TModflowPackageSelection.SetRealProperty(var Field: real;
  const Value: real);
begin
  if Field <> Value then
  begin
    Field := Value;
    InvalidateModel;
  end;
end;

procedure TModflowPackageSelection.SetStringProperty(var Field: string;
  const Value: string);
begin
  if Field <> Value then
  begin
    Field := Value;
    InvalidateModel;
  end;
end;

procedure TModflowPackageSelection.UpdateDisplayUseList(NewUseList: TStringList;
  ParamType: TParameterType; DataIndex: integer; const DisplayName: string);
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }

  (FModel as TCustomModel).UpdateDisplayUseList(NewUseList,
    ParamType, DataIndex, DisplayName);
end;

procedure TModflowPackageSelection.UpdateUseList(DataIndex: integer;
  NewUseList: TStringList; Item: TCustomModflowBoundaryItem);
var
  Formula: string;
  TempUseList: TStringList;
  VariableIndex: Integer;
  ScreenObject: TScreenObject;
  Parser: TRbwParser;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  Parser := (FModel as TCustomModel).rpThreeDFormulaCompiler;
  Formula := Item.BoundaryFormula[DataIndex];
  try
    Parser.Compile(Formula);
  except on E: ErbwParserError do
    begin
      ScreenObject := Item.ScreenObject as TScreenObject;
      frmFormulaErrors.AddFormulaError(ScreenObject.Name,
        StrModflowSfrReachLength, Formula, E.Message);
      Formula := '0';
      Parser.Compile(Formula);
    end;
  end;
  TempUseList := Parser.CurrentExpression.VariablesUsed;
  for VariableIndex := 0 to TempUseList.Count - 1 do
  begin
    if NewUseList.IndexOf(TempUseList[VariableIndex]) < 0 then
    begin
      NewUseList.Add(TempUseList[VariableIndex]);
    end;
  end;
end;

procedure TCustomTransientLayerPackageSelection.
  UpdateWithElevationFormula(Formula: string;
  ScreenObject: TScreenObject; NewUseList: TStringList);
var
  TempUseList: TStringList;
  VariableIndex: Integer;
  Parser : TRbwParser;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  Parser := (FModel as TCustomModel).rpTopFormulaCompiler;
  try
    Parser.Compile(Formula);
  except on E: ErbwParserError do
    begin
      frmFormulaErrors.AddFormulaError(ScreenObject.Name, StrXYOrZCoordinat,
        Formula, E.Message);
      Formula := '0';
      Parser.Compile(Formula);
    end;
  end;
  TempUseList := Parser.CurrentExpression.VariablesUsed;
  for VariableIndex := 0 to TempUseList.Count - 1 do
  begin
    if NewUseList.IndexOf(TempUseList[VariableIndex]) < 0 then
    begin
      NewUseList.Add(TempUseList[VariableIndex]);
    end;
  end;
end;

{ TPcgSelection }

procedure TPcgSelection.Assign(Source: TPersistent);
var
  PcgSource: TPcgSelection;
begin
  if Source is TPcgSelection then
  begin
    PcgSource := TPcgSelection(Source);
    MXITER := PcgSource.MXITER;
    ITER1 := PcgSource.ITER1;
    NPCOND := PcgSource.NPCOND;
    HCLOSE := PcgSource.HCLOSE;
    RCLOSE := PcgSource.RCLOSE;
    RELAX := PcgSource.RELAX;
    NBPOL := PcgSource.NBPOL;
    IPRPCG := PcgSource.IPRPCG;
    MUTPCG := PcgSource.MUTPCG;
    DAMPPCG := PcgSource.DAMPPCG;
    DAMPPCGT := PcgSource.DAMPPCGT;
    IHCOFADD := PcgSource.IHCOFADD;
  end;
  inherited;
end;

constructor TPcgSelection.Create(Model: TBaseModel);
begin
  inherited;
  FHCLOSE := TRealStorage.Create;
  FRCLOSE := TRealStorage.Create;
  FRELAX := TRealStorage.Create;
  FDAMPPCG := TRealStorage.Create;
  FDAMPPCGT:= TRealStorage.Create;

  FHCLOSE.OnChange := OnValueChanged;
  FRCLOSE.OnChange := OnValueChanged;
  FRELAX.OnChange := OnValueChanged;
  FDAMPPCG.OnChange := OnValueChanged;
  FDAMPPCGT.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor TPcgSelection.Destroy;
begin
  FHCLOSE.Free;
  FRCLOSE.Free;
  FRELAX.Free;
  FDAMPPCG.Free;
  FDAMPPCGT.Free;
  inherited;
end;

procedure TPcgSelection.InitializeVariables;
begin
  inherited;
  IsSelected := True;
  SelectionType := stRadioButton;
  FIsSelected := True;
  FMXITER := 20;
  FITER1 := 30;
  FHCLOSE.Value := 0.001;
  FRCLOSE.Value := 0.001;
  FRELAX.Value := 1;
  FIPRPCG := 1;
  FDAMPPCG.Value := 1;
  FDAMPPCGT.Value := 1;
  FIHCOFADD := dcoConvertWhenSurrounded;
end;

procedure TPcgSelection.SetDAMPPCG(const Value: TRealStorage);
begin
  if FDAMPPCG.Value <> Value.Value then
  begin
    FDAMPPCG.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetDAMPPCGT(const Value: TRealStorage);
begin
  if FDAMPPCGT.Value <> Value.Value then
  begin
    FDAMPPCGT.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetHCLOSE(const Value: TRealStorage);
begin
  if FHCLOSE.Value <> Value.Value then
  begin
    FHCLOSE.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetIHCOFADD(const Value: TPcgDryConvertOption);
begin
  if FIHCOFADD <> Value then
  begin
    FIHCOFADD := Value;
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetIPRPCG(const Value: integer);
begin
  if FIPRPCG <> Value then
  begin
    FIPRPCG := Value;
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetITER1(const Value: integer);
begin
  if FITER1 <> Value then
  begin
    FITER1 := Value;
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetMUTPCG(const Value: TPcgPrintSelection);
begin
  if FMUTPCG <> Value then
  begin
    FMUTPCG := Value;
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetMXITER(const Value: integer);
begin
  if FMXITER <> Value then
  begin
    FMXITER := Value;
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetNBPOL(const Value: TPcgEstimateMaxEigenvalue);
begin
  if FNBPOL <> Value then
  begin
    FNBPOL := Value;
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetNPCOND(const Value: TPcgMethod);
begin
  if FNPCOND <> Value then
  begin
    FNPCOND := Value;
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetRCLOSE(const Value: TRealStorage);
begin
  if FRCLOSE.Value <> Value.Value then
  begin
    FRCLOSE.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TPcgSelection.SetRELAX(const Value: TRealStorage);
begin
  if FRELAX.Value <> Value.Value then
  begin
    FRELAX.Assign(Value);
    InvalidateModel;
  end;
end;

{ TRchPackageSelection }

procedure TCustomTransientLayerPackageSelection.Assign(Source: TPersistent);
var
  SourceItem: TCustomTransientLayerPackageSelection;
begin
  if Source is TCustomTransientLayerPackageSelection then
  begin
    SourceItem := TCustomTransientLayerPackageSelection(Source);
    LayerOption := SourceItem.LayerOption;
    TimeVaryingLayers := SourceItem.TimeVaryingLayers;
  end;
  inherited;
end;

constructor TCustomTransientLayerPackageSelection.Create(Model: TBaseModel);
begin
  inherited Create(Model);
  FZoneArrayNames := TTransientZoneCollection.Create;
  FMultiplierArrayNames := TTransientMultCollection.Create;
  FLayerOption := loTop;
end;

destructor TCustomTransientLayerPackageSelection.Destroy;
begin
  FMultiplierArrayNames.Free;
  FZoneArrayNames.Free;
  inherited;
end;

function TCustomTransientLayerPackageSelection.GetTimeVaryingLayers: boolean;
begin
  if LayerOption = loSpecified then
  begin
    result := FTimeVaryingLayers
  end
  else
  begin
    result := False;
  end;
end;

procedure TCustomTransientLayerPackageSelection.SetTimeVaryingLayers(
  const Value: boolean);
begin
  if FTimeVaryingLayers <> Value then
  begin
    InvalidateModel;
    FTimeVaryingLayers := Value;
    if Assigned(OnLayerChoiceChange) then
    begin
      OnLayerChoiceChange(self);
    end;
  end;
end;

{ TRchPackageSelection }

procedure TRchPackageSelection.Assign(Source: TPersistent);
begin
  if Source is TRchPackageSelection then
  begin
    AssignmentMethod := TRchPackageSelection(Source).AssignmentMethod;
  end;
  inherited;
end;

constructor TRchPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
//  FAssignmentMethod := umAdd;
  if Model <> nil then
  begin
    OnLayerChoiceChange := (Model as TCustomModel).InvalidateMfRchLayer;

    FMfRchRate := TModflowBoundaryDisplayTimeList.Create(Model);
    MfRchRate.OnInitialize := InitializeRchDisplay;
    MfRchRate.OnGetUseList := GetMfRchRateUseList;
    MfRchRate.OnTimeListUsed := PackageUsed;
    MfRchRate.Name := StrMODFLOWRchRate;
    AddTimeList(MfRchRate);

    FMfRchLayer := TModflowBoundaryDisplayTimeList.Create(Model);
    MfRchLayer.OnInitialize := InitializeRchDisplay;
    MfRchLayer.OnGetUseList := GetMfRchLayerUseList;
    MfRchLayer.OnTimeListUsed := PackageUsed;
    MfRchLayer.Name := StrMODFLOWRchLayer;
    AddTimeList(MfRchLayer);
  end;
end;

destructor TRchPackageSelection.Destroy;
begin
  FMfRchRate.Free;
  FMfRchLayer.Free;
  inherited;
end;

procedure TRchPackageSelection.GetMfRchLayerUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TRchLayerItem;
  ValueIndex: Integer;
  Boundary: TRchBoundary;
  LocalModel: TCustomModel;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowRchBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      if TimeVaryingLayers then
      begin
        for ValueIndex := 0 to Boundary.RechargeLayers.Count -1 do
        begin
          Item := Boundary.RechargeLayers[ValueIndex] as TRchLayerItem;
          UpdateUseList(0, NewUseList, Item);
        end;
      end
      else
      begin
        case ScreenObject.ElevationCount of
          ecZero:
            begin
              // do nothing
            end;
          ecOne:
            begin
              UpdateWithElevationFormula(ScreenObject.ElevationFormula,
                ScreenObject, NewUseList);
            end;
          ecTwo:
            begin
              UpdateWithElevationFormula(ScreenObject.HigherElevationFormula,
                ScreenObject, NewUseList);
              UpdateWithElevationFormula(ScreenObject.LowerElevationFormula,
                ScreenObject, NewUseList);
            end;
          else Assert(False);
        end;
      end;
    end;
  end;
end;

procedure TRchPackageSelection.GetMfRchRateUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptRCH, 0, StrMODFLOWRchRate);
end;

procedure TRchPackageSelection.InitializeRchDisplay(Sender: TObject);
var
  RchWriter: TModflowRCH_Writer;
  List: TModflowBoundListOfTimeLists;
begin
  MfRchRate.CreateDataSets;
  if LayerOption = loSpecified then
  begin
    MfRchLayer.CreateDataSets;
  end
  else
  begin
    MfRchLayer.Clear;
    MfRchLayer.SetUpToDate(True);
  end;


  List := TModflowBoundListOfTimeLists.Create;
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  RchWriter := TModflowRCH_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfRchRate);
    if LayerOption = loSpecified then
    begin
      List.Add(MfRchLayer);
    end
    else
    begin
      List.Add(nil);
    end;
    RchWriter.UpdateDisplay(List);
  finally
    RchWriter.Free;
    List.Free;
  end;
  MfRchRate.LabelAsSum;
end;

procedure TRchPackageSelection.InvalidateAllTimeLists;
begin
  inherited;
//  if PackageUsed(FModel) then
  begin
    MfRchRate.Invalidate;
    MfRchLayer.Invalidate;
  end;
end;

procedure TRchPackageSelection.InvalidateMfRchLayer(Sender: TObject);
begin
  MfRchLayer.Invalidate;
end;

procedure TRchPackageSelection.SetAssignmentMethod(const Value: TUpdateMethod);
begin
  if FAssignmentMethod <> Value then
  begin
    FAssignmentMethod := Value;
    InvalidateModel;
    { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
    if FModel <> nil then
    begin
      MfRchRate.Invalidate;
    end;
  end;
end;
{ TEtsPackageSelection }

procedure TEtsPackageSelection.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TEtsPackageSelection then
  begin
    SegmentCount := TEtsPackageSelection(Source).SegmentCount;
    if FModel <> nil then
    begin
      UpdateEtsSegmentCount;
    end;
  end;
end;

constructor TEtsPackageSelection.Create(Model: TBaseModel);
begin
  inherited Create(Model);
  FSegmentCount := 1;
  if Model <> nil then
  begin
    FEtsRateFractionLists := TObjectList.Create;
    FEtsDepthFractionLists := TObjectList.Create;

    OnLayerChoiceChange := InvalidateMfEtsEvapLayer;

    FMfEtsEvapRate := TModflowBoundaryDisplayTimeList.Create(Model);
    MfEtsEvapRate.OnInitialize := InitializeEtsDisplay;
    MfEtsEvapRate.OnGetUseList := GetMfEtsRateUseList;
    MfEtsEvapRate.OnTimeListUsed := PackageUsed;
    MfEtsEvapRate.Name := StrMODFLOWEtsRate;
    AddTimeList(MfEtsEvapRate);

    FMfEtsEvapSurface := TModflowBoundaryDisplayTimeList.Create(Model);
    MfEtsEvapSurface.OnInitialize := InitializeEtsDisplay;
    MfEtsEvapSurface.OnGetUseList := GetMfEtsSurfaceUseList;
    MfEtsEvapSurface.OnTimeListUsed := PackageUsed;
    MfEtsEvapSurface.Name := StrMODFLOWEtsSurface;
    AddTimeList(MfEtsEvapSurface);

    FMfEtsEvapDepth := TModflowBoundaryDisplayTimeList.Create(Model);
    MfEtsEvapDepth.OnInitialize := InitializeEtsDisplay;
    MfEtsEvapDepth.OnGetUseList := GetMfEtsDepthUseList;
    MfEtsEvapDepth.OnTimeListUsed := PackageUsed;
    MfEtsEvapDepth.Name := StrMODFLOWEtsDepth;
    AddTimeList(MfEtsEvapDepth);

    FMfEtsEvapLayer := TModflowBoundaryDisplayTimeList.Create(Model);
    MfEtsEvapLayer.OnInitialize := InitializeEtsDisplay;
    MfEtsEvapLayer.OnGetUseList := GetMfEtsLayerUseList;
    MfEtsEvapLayer.OnTimeListUsed := PackageUsed;
    MfEtsEvapLayer.Name := StrMODFLOWEtsLayer;
    AddTimeList(MfEtsEvapLayer);

    UpdateEtsSegmentCount;
  end;
end;

destructor TEtsPackageSelection.Destroy;
begin
  FEtsRateFractionLists.Free;
  FEtsDepthFractionLists.Free;
  FMfEtsEvapLayer.Free;
  FMfEtsEvapRate.Free;
  FMfEtsEvapDepth.Free;
  FMfEtsEvapSurface.Free;
  inherited;
end;

procedure TEtsPackageSelection.GetMfEtsDepthFractionUseList(Sender: TObject;
  NewUseList: TStringList);
var
  Index: integer;
  DataSetName: string;
begin
  Index := FEtsRateFractionLists.IndexOf(Sender);
  DataSetName := StrMODFLOWEtsDepthFraction + IntToStr(Index+1);
  Index := Index*2+2;
  UpdateEtsUseList(NewUseList, ptETS, Index, DataSetName);
end;

procedure TEtsPackageSelection.GetMfEtsDepthUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateEtsUseList(NewUseList, ptETS, 2, StrMODFLOWEtsRate);
end;

procedure TEtsPackageSelection.GetMfEtsLayerUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TEvtLayerItem;
  ValueIndex: Integer;
  Boundary: TEtsBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowEtsBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      if TimeVaryingLayers then
      begin
        for ValueIndex := 0 to Boundary.EvapotranspirationLayers.Count -1 do
        begin
          Item := Boundary.EvapotranspirationLayers[ValueIndex]
            as TEvtLayerItem;
          UpdateUseList(0, NewUseList, Item);
        end;
      end
      else
      begin
        case ScreenObject.ElevationCount of
          ecZero:
            begin
              // do nothing
            end;
          ecOne:
            begin
              UpdateWithElevationFormula(ScreenObject.ElevationFormula,
                ScreenObject, NewUseList);
            end;
          ecTwo:
            begin
              UpdateWithElevationFormula(ScreenObject.HigherElevationFormula,
                ScreenObject, NewUseList);
              UpdateWithElevationFormula(ScreenObject.LowerElevationFormula,
                ScreenObject, NewUseList);
            end;
          else Assert(False);
        end;
      end;
    end;
  end;
end;

procedure TEtsPackageSelection.GetMfEtsRateFractionUseList(Sender: TObject;
  NewUseList: TStringList);
var
  Index: integer;
  DataSetName: string;
begin
  Index := FEtsRateFractionLists.IndexOf(Sender);
  DataSetName := StrMODFLOWEtsRateFraction + IntToStr(Index+1);
  Index := Index*2+3;
  UpdateEtsUseList(NewUseList, ptETS, Index, DataSetName);
end;

procedure TEtsPackageSelection.GetMfEtsRateUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptETS, 0, StrMODFLOWEtsRate);
end;

procedure TEtsPackageSelection.GetMfEtsSurfaceUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateEtsUseList(NewUseList, ptETS, 1, StrMODFLOWEtsRate);
end;

procedure TEtsPackageSelection.InitializeEtsDisplay(Sender: TObject);
var
  EtsWriter: TModflowETS_Writer;
  List: TModflowBoundListOfTimeLists;
  Index: Integer;
  TimeList: TModflowBoundaryDisplayTimeList;
begin
  MfEtsEvapRate.CreateDataSets;
  MfEtsEvapSurface.CreateDataSets;
  MfEtsEvapDepth.CreateDataSets;
  if LayerOption = loSpecified then
  begin
    MfEtsEvapLayer.CreateDataSets;
  end
  else
  begin
    MfEtsEvapLayer.Clear;
    MfEtsEvapLayer.SetUpToDate(True);
  end;

  List := TModflowBoundListOfTimeLists.Create;
  EtsWriter := TModflowETS_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfEtsEvapRate);
    List.Add(MfEtsEvapSurface);
    List.Add(MfEtsEvapDepth);
    if LayerOption = loSpecified then
    begin
      List.Add(MfEtsEvapLayer);
    end
    else
    begin
      List.Add(nil);
    end;
    Assert(FEtsRateFractionLists.Count = FEtsDepthFractionLists.Count);
    for Index := 0 to FEtsRateFractionLists.Count - 1 do
    begin
      TimeList := FEtsDepthFractionLists[Index];
      TimeList.CreateDataSets;
      List.Add(TimeList);

      TimeList := FEtsRateFractionLists[Index];
      TimeList.CreateDataSets;
      List.Add(TimeList);
    end;
    EtsWriter.UpdateDisplay(List);
  finally
    EtsWriter.Free;
    List.Free;
  end;
  MfEtsEvapRate.LabelAsSum;
end;

procedure TEtsPackageSelection.InvalidateAllTimeLists;
begin
  inherited;
//  if PackageUsed(nil) then
  begin
    MfEtsEvapDepth.Invalidate;
    InvalidateMfEtsEvapLayer(nil);
    MfEtsEvapRate.Invalidate;
    MfEtsEvapSurface.Invalidate;
    InvalidateEtsDepthFractions(nil);
    InvalidateEtsRateFractions(nil);
  end;
end;

procedure TEtsPackageSelection.InvalidateEtsDepthFractions(Sender: TObject);
var
  Index: Integer;
  TimeList: TModflowBoundaryDisplayTimeList;
begin
  for Index := 0 to FEtsDepthFractionLists.Count - 1 do
  begin
    TimeList := FEtsRateFractionLists[Index];
    TimeList.Invalidate;
  end;
end;

procedure TEtsPackageSelection.InvalidateEtsRateFractions(Sender: TObject);
var
  Index: Integer;
  TimeList: TModflowBoundaryDisplayTimeList;
begin
  for Index := 0 to FEtsRateFractionLists.Count - 1 do
  begin
    TimeList := FEtsRateFractionLists[Index];
    TimeList.Invalidate;
  end;
end;

procedure TEtsPackageSelection.InvalidateMfEtsEvapLayer(Sender: TObject);
begin
  MfEtsEvapLayer.Invalidate;
end;

procedure TEtsPackageSelection.SetSegmentCount(const Value: integer);
begin
  if FSegmentCount <> Value then
  begin
    InvalidateModel;
    FSegmentCount := Value;
  end;
end;

procedure TEtsPackageSelection.UpdateEtsSegmentCount;
var
  TimeList: TModflowBoundaryDisplayTimeList;
  Index: Integer;
begin
  if IsSelected then
  begin
    while FEtsRateFractionLists.Count >
      SegmentCount -1 do
    begin
      TimeList := FEtsRateFractionLists[FEtsRateFractionLists.Count-1];
      RemoveTimeList(TimeList);
      FEtsRateFractionLists.Delete(FEtsRateFractionLists.Count-1);

      TimeList := FEtsDepthFractionLists[FEtsDepthFractionLists.Count-1];
      RemoveTimeList(TimeList);
      FEtsDepthFractionLists.Delete(FEtsRateFractionLists.Count-1);
    end;
    while FEtsRateFractionLists.Count <
      SegmentCount -1 do
    begin
      TimeList := TModflowBoundaryDisplayTimeList.Create(FModel);
      AddTimeList(TimeList);
      FEtsRateFractionLists.Add(TimeList);
      TimeList.OnInitialize := InitializeEtsDisplay;
      TimeList.OnGetUseList := GetMfEtsRateFractionUseList;
      TimeList.Name := StrMODFLOWEtsRateFraction
        + IntToStr(FEtsRateFractionLists.Count);

      TimeList := TModflowBoundaryDisplayTimeList.Create(FModel);
      AddTimeList(TimeList);
      FEtsDepthFractionLists.Add(TimeList);
      TimeList.OnInitialize := InitializeEtsDisplay;
      TimeList.OnGetUseList := GetMfEtsDepthFractionUseList;
      TimeList.Name := StrMODFLOWEtsDepthFraction
        + IntToStr(FEtsDepthFractionLists.Count);
    end;
  end
  else
  begin
    for Index := 0 to FEtsRateFractionLists.Count - 1 do
    begin
      TimeList := FEtsRateFractionLists[Index];
      RemoveTimeList(TimeList);
    end;
    for Index := 0 to FEtsDepthFractionLists.Count - 1 do
    begin
      TimeList := FEtsDepthFractionLists[Index];
      RemoveTimeList(TimeList);
    end;
    FEtsRateFractionLists.Clear;
    FEtsDepthFractionLists.Clear;
  end;
end;

procedure TEtsPackageSelection.UpdateEtsUseList(NewUseList: TStringList;
  ParamType: TParameterType; DataIndex: integer; const DisplayName: string);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  Boundary: TEtsBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowEtsBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.EtsSurfDepthCollection.Count -1 do
      begin
        Item := Boundary.EtsSurfDepthCollection[ValueIndex]
          as TCustomModflowBoundaryItem;
        UpdateUseList(DataIndex, NewUseList, Item);
      end;
    end;
  end;
end;

{ TResPackageSelection }

procedure TResPackageSelection.Assign(Source: TPersistent);
var
  ResSource: TResPackageSelection;
begin
  if Source is TResPackageSelection then
  begin
    ResSource := TResPackageSelection(Source);
    PrintStage := ResSource.PrintStage;
    TableStages := ResSource.TableStages;
  end;
  inherited;
end;

constructor TResPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FPrintStage := True;
  FTableStages := 15;
end;

procedure TResPackageSelection.SetPrintStage(const Value: boolean);
begin
  if FPrintStage <> Value then
  begin
    InvalidateModel;
    FPrintStage := Value;
  end;
end;

procedure TResPackageSelection.SetTableStages(const Value: integer);
begin
  if FTableStages <> Value then
  begin
    InvalidateModel;
    FTableStages := Value;
  end;
end;

{ TLakePackageSelection }

procedure TLakePackageSelection.Assign(Source: TPersistent);
var
  Lake: TLakePackageSelection;
begin
  if Source is TLakePackageSelection then
  begin
    Lake := TLakePackageSelection(Source);
    ConvergenceCriterion := Lake.ConvergenceCriterion;
    NumberOfIterations := Lake.NumberOfIterations;
    SurfDepth := Lake.SurfDepth;
    PrintLakes := Lake.PrintLakes;
    Theta := Lake.Theta;
    ExternalLakeChoice := Lake.ExternalLakeChoice;
  end;
  inherited;
end;

constructor TLakePackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FSurfDepth := TRealStorage.Create;
  FSurfDepth.OnChange := OnValueChanged;
  InitializeVariables;
end;

destructor TLakePackageSelection.Destroy;
begin
  FSurfDepth.Free;
  inherited;
end;

procedure TLakePackageSelection.InitializeVariables;
begin
  inherited;
  FTheta := 0.5;
  FConvergenceCriterion := 0.00001;
  FNumberOfIterations := 100;
  FSurfDepth.Value := 0.2;
  FPrintLakes := True;
  FExternalLakeChoice := elcNone;
end;

procedure TLakePackageSelection.SetConvergenceCriterion(const Value: double);
begin
  if FConvergenceCriterion <> Value then
  begin
    InvalidateModel;
    FConvergenceCriterion := Value;
  end;
end;

procedure TLakePackageSelection.SetExternalLakeChoice(
  const Value: TExternalLakeChoice);
begin
  if FExternalLakeChoice <> Value then
  begin
    InvalidateModel;
    FExternalLakeChoice := Value;
  end;
end;

procedure TLakePackageSelection.SetIsSelected(const Value: boolean);
begin
  inherited;
  DischargeRoutingUpdate;
end;

procedure TLakePackageSelection.SetNumberOfIterations(const Value: integer);
begin
  if FNumberOfIterations <> Value then
  begin
    InvalidateModel;
    FNumberOfIterations := Value;
  end;
end;

procedure TLakePackageSelection.SetPrintLakes(const Value: boolean);
begin
  if FPrintLakes <> Value then
  begin
    InvalidateModel;
    FPrintLakes := Value;
  end;
end;

procedure TLakePackageSelection.SetSurfDepth(const Value: TRealStorage);
begin
  if FSurfDepth.Value <> Value.Value then
  begin
    InvalidateModel;
    FSurfDepth.Assign(Value);
  end;
end;

procedure TLakePackageSelection.SetTheta(const Value: double);
begin
  if FTheta <> Value then
  begin
    InvalidateModel;
    FTheta := Value;
  end;
end;

{ TEvtPackageSelection }

constructor TEvtPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  if Model <> nil then
  begin
    OnLayerChoiceChange := InvalidateMfEvtEvapLayer;

    FMfEvtEvapRate := TModflowBoundaryDisplayTimeList.Create(Model);
    MfEvtEvapRate.OnInitialize := InitializeEvtDisplay;
    MfEvtEvapRate.OnGetUseList := GetMfEvtRateUseList;
    MfEvtEvapRate.OnTimeListUsed := PackageUsed;
    MfEvtEvapRate.Name := StrMODFLOWEvtRate;
    AddTimeList(MfEvtEvapRate);

    FMfEvtEvapSurface := TModflowBoundaryDisplayTimeList.Create(Model);
    MfEvtEvapSurface.OnInitialize := InitializeEvtDisplay;
    MfEvtEvapSurface.OnGetUseList := GetMfEvtSurfaceUseList;
    MfEvtEvapSurface.OnTimeListUsed := PackageUsed;
    MfEvtEvapSurface.Name := StrMODFLOWEvtSurface;
    AddTimeList(MfEvtEvapSurface);

    FMfEvtEvapDepth := TModflowBoundaryDisplayTimeList.Create(Model);
    MfEvtEvapDepth.OnInitialize := InitializeEvtDisplay;
    MfEvtEvapDepth.OnGetUseList := GetMfEvtDepthUseList;
    MfEvtEvapDepth.OnTimeListUsed := PackageUsed;
    MfEvtEvapDepth.Name := StrMODFLOWEvtDepth;
    AddTimeList(MfEvtEvapDepth);

    FMfEvtEvapLayer := TModflowBoundaryDisplayTimeList.Create(Model);
    MfEvtEvapLayer.OnInitialize := InitializeEvtDisplay;
    MfEvtEvapLayer.OnGetUseList := GetMfEvtLayerUseList;
    MfEvtEvapLayer.OnTimeListUsed := PackageUsed;
    MfEvtEvapLayer.Name := StrMODFLOWEvtLayer;
    AddTimeList(MfEvtEvapLayer);
  end;
end;

destructor TEvtPackageSelection.Destroy;
begin
  FMfEvtEvapLayer.Free;
  FMfEvtEvapRate.Free;
  FMfEvtEvapSurface.Free;
  FMfEvtEvapDepth.Free;
  inherited;
end;

procedure TEvtPackageSelection.GetMfEvtDepthUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateEvtUseList(NewUseList, ptEVT, 1, StrMODFLOWEvtRate);
end;

procedure TEvtPackageSelection.GetMfEvtLayerUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TEvtLayerItem;
  ValueIndex: Integer;
  Boundary: TEvtBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowEvtBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      if TimeVaryingLayers then
      begin
        for ValueIndex := 0 to Boundary.EvapotranspirationLayers.Count -1 do
        begin
          Item := Boundary.EvapotranspirationLayers[ValueIndex]
            as TEvtLayerItem;
          UpdateUseList(0, NewUseList, Item);
        end;
      end
      else
      begin
        case ScreenObject.ElevationCount of
          ecZero:
            begin
              // do nothing
            end;
          ecOne:
            begin
              UpdateWithElevationFormula(ScreenObject.ElevationFormula,
                ScreenObject, NewUseList);
            end;
          ecTwo:
            begin
              UpdateWithElevationFormula(ScreenObject.HigherElevationFormula,
                ScreenObject, NewUseList);
              UpdateWithElevationFormula(ScreenObject.LowerElevationFormula,
                ScreenObject, NewUseList);
            end;
          else Assert(False);
        end;
      end;
    end;
  end;
end;

procedure TEvtPackageSelection.GetMfEvtRateUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptEVT, 0, StrMODFLOWEvtRate);
end;

procedure TEvtPackageSelection.GetMfEvtSurfaceUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateEvtUseList(NewUseList, ptEVT, 0, StrMODFLOWEtsRate);
end;

procedure TEvtPackageSelection.InitializeEvtDisplay(Sender: TObject);
var
  EvtWriter: TModflowEVT_Writer;
  List: TModflowBoundListOfTimeLists;
begin
  MfEvtEvapRate.CreateDataSets;
  MfEvtEvapSurface.CreateDataSets;
  MfEvtEvapDepth.CreateDataSets;
  if LayerOption = loSpecified then
  begin
    MfEvtEvapLayer.CreateDataSets;
  end
  else
  begin
    MfEvtEvapLayer.Clear;
    MfEvtEvapLayer.SetUpToDate(True);
  end;


  List := TModflowBoundListOfTimeLists.Create;
  EvtWriter := TModflowEVT_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfEvtEvapRate);
    List.Add(MfEvtEvapSurface);
    List.Add(MfEvtEvapDepth);
    if LayerOption = loSpecified then
    begin
      List.Add(MfEvtEvapLayer);
    end
    else
    begin
      List.Add(nil);
    end;
    EvtWriter.UpdateDisplay(List);
  finally
    EvtWriter.Free;
    List.Free;
  end;
  MfEvtEvapRate.LabelAsSum;
end;

procedure TEvtPackageSelection.InvalidateAllTimeLists;
begin
  inherited;
//  if PackageUsed(FModel) then
  begin
    MfEvtEvapDepth.Invalidate;
    MfEvtEvapLayer.Invalidate;
    MfEvtEvapRate.Invalidate;
    MfEvtEvapSurface.Invalidate;
  end;
end;

procedure TEvtPackageSelection.InvalidateMfEvtEvapLayer(Sender: TObject);
begin
  MfEvtEvapLayer.Invalidate;
end;

procedure TEvtPackageSelection.UpdateEvtUseList(NewUseList: TStringList;
  ParamType: TParameterType; DataIndex: integer; const DisplayName: string);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  Boundary: TEvtBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowEvtBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.EvtSurfDepthCollection.Count -1 do
      begin
        Item := Boundary.EvtSurfDepthCollection[ValueIndex]
          as TCustomModflowBoundaryItem;
        UpdateUseList(DataIndex, NewUseList, Item);
      end;
    end;
  end;
end;

{ TSfrPackageSelection }

procedure TSfrPackageSelection.Assign(Source: TPersistent);
var
  Stream: TSfrPackageSelection;
begin
  if Source is TSfrPackageSelection then
  begin
    Stream := TSfrPackageSelection(Source);
    Dleak := Stream.Dleak;
    Isfropt := Stream.Isfropt;
    Nstrail := Stream.Nstrail;
    Isuzn := Stream.Isuzn;
    Nsfrsets := Stream.Nsfrsets;
    // PrintStreams has been replaced by PrintFlows.
//    PrintStreams := Stream.PrintStreams;
    PrintFlows := Stream.PrintFlows;
    KinematicRouting := Stream.KinematicRouting;
    GageOverallBudget := Stream.GageOverallBudget;
    UseGsflowFormat := Stream.UseGsflowFormat;
    TimeStepsForKinematicRouting := Stream.TimeStepsForKinematicRouting;
    KinematicRoutingTolerance := Stream.KinematicRoutingTolerance;
    KinematicRoutingWeight := Stream.KinematicRoutingWeight;
    StoredLossFactor := Stream.StoredLossFactor;
    LossFactorOption := Stream.LossFactorOption;
    if AssignParameterInstances then
    begin
      ParameterInstances := Stream.ParameterInstances;
    end;

  end;
  inherited;
end;

constructor TSfrPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FStoredLossFactor := TRealStorage.Create;
  FStoredLossFactor.OnChange := OnValueChanged;
  InitializeVariables;
  FParameterInstances := TSfrParamInstances.Create(Model);
  AssignParameterInstances := True;
  if Model <> nil then
  begin
    FMfSfrSegmentNumber := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrSegmentNumber.OnTimeListUsed := PackageUsed;
    FMfSfrSegmentNumber.OnInitialize := InitializeSfrDisplay;
    FMfSfrSegmentNumber.OnGetUseList := GetMfSfrUseList;
    FMfSfrSegmentNumber.Name := StrModflowSfrSegment;
    AddTimeList(FMfSfrSegmentNumber);

    FMfSfrReachNumber := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrReachNumber.OnTimeListUsed := PackageUsed;
    FMfSfrReachNumber.OnInitialize := InitializeSfrDisplay;
    FMfSfrReachNumber.OnGetUseList := GetMfSfrUseList;
    FMfSfrReachNumber.Name := StrModflowSfrReach;
    AddTimeList(FMfSfrReachNumber);

    FMfSfrIcalc := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrIcalc.OnTimeListUsed := PackageUsed;
    FMfSfrIcalc.OnInitialize := InitializeSfrDisplay;
    FMfSfrIcalc.OnGetUseList := GetMfSfrUseList;
    FMfSfrIcalc.Name := StrModflowSfrIcalc;
    AddTimeList(FMfSfrIcalc);

    FMfSfrReachLength := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrReachLength.OnTimeListUsed := PackageUsed;
    FMfSfrReachLength.OnInitialize := InitializeSfrDisplay;
    FMfSfrReachLength.OnGetUseList := GetMfSfrReachLengthUseList;
    FMfSfrReachLength.Name := StrModflowSfrReachLength;
    AddTimeList(FMfSfrReachLength);

    FMfSfrStreamTop := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrStreamTop.OnTimeListUsed := ModflowSfrSpatialVariationSelected;
    FMfSfrStreamTop.OnInitialize := InitializeSfrDisplay;
    FMfSfrStreamTop.OnGetUseList := GetMfSfrStreamTopUseList;
    FMfSfrStreamTop.Name := StrModflowSfrStreamTop;
    AddTimeList(FMfSfrStreamTop);

    FMfSfrStreamSlope := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrStreamSlope.OnTimeListUsed := ModflowSfrSpatialVariationSelected;
    FMfSfrStreamSlope.OnInitialize := InitializeSfrDisplay;
    FMfSfrStreamSlope.OnGetUseList := GetMfSfrStreamSlopeUseList;
    FMfSfrStreamSlope.Name := StrModflowSfrStreamSlope;
    AddTimeList(FMfSfrStreamSlope);

    FMfSfrStreamThickness := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrStreamThickness.OnTimeListUsed := ModflowSfrSpatialVariationSelected;
    FMfSfrStreamThickness.OnInitialize := InitializeSfrDisplay;
    FMfSfrStreamThickness.OnGetUseList := GetMfSfrStreamThicknessUseList;
    FMfSfrStreamThickness.Name := StrModflowSfrStreamThickness;
    AddTimeList(FMfSfrStreamThickness);

    FMfSfrStreamK := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrStreamK.OnTimeListUsed := ModflowSfrSpatialVariationSelected;
    FMfSfrStreamK.OnInitialize := InitializeSfrDisplay;
    FMfSfrStreamK.OnGetUseList := GetMfSfrStreamKUseList;
    FMfSfrStreamK.Name := StrModflowSfrStreamK;
    AddTimeList(FMfSfrStreamK);

    FMfSfrSaturatedWaterContent :=
      TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrSaturatedWaterContent.OnTimeListUsed :=
      ModflowSfrUnsatSpatialVariationSelected;
    FMfSfrSaturatedWaterContent.OnInitialize := InitializeSfrDisplay;
    FMfSfrSaturatedWaterContent.OnGetUseList :=
      GetMfSfrStreamSatWatContentUseList;
    FMfSfrSaturatedWaterContent.Name := StrModflowSfrSatWatCont;
    AddTimeList(FMfSfrSaturatedWaterContent);

    FMfSfrInitialWaterContent := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrInitialWaterContent.OnTimeListUsed :=
      ModflowSfrUnsatSpatialVariationSelected;
    FMfSfrInitialWaterContent.OnInitialize := InitializeSfrDisplay;
    FMfSfrInitialWaterContent.OnGetUseList :=
      GetMfSfrStreamInitialWatContentUseList;
    FMfSfrInitialWaterContent.Name := StrModflowSfrInitWatCont;
    AddTimeList(FMfSfrInitialWaterContent);

    FMfSfrBrooksCorey := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrBrooksCorey.OnTimeListUsed := ModflowSfrUnsatSpatialVariationSelected;
    FMfSfrBrooksCorey.OnInitialize := InitializeSfrDisplay;
    FMfSfrBrooksCorey.OnGetUseList := GetMfSfrBrooksCoreyUseList;
    FMfSfrBrooksCorey.Name := StrModflowSfrBrooksCorey;
    AddTimeList(FMfSfrBrooksCorey);

    FMfSfrVerticalUnsatK := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrVerticalUnsatK.OnTimeListUsed :=
      ModflowSfrUnsatKzSpatialVariationSelected;
    FMfSfrVerticalUnsatK.OnInitialize := InitializeSfrDisplay;
    FMfSfrVerticalUnsatK.OnGetUseList := GetMfSfrUnsatKzUseList;
    FMfSfrVerticalUnsatK.Name := StrModflowSfrVertK;
    AddTimeList(FMfSfrVerticalUnsatK);

    FMfSfrOutSegment := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrOutSegment.OnTimeListUsed := PackageUsed;
    FMfSfrOutSegment.OnInitialize := InitializeSfrDisplay;
    FMfSfrOutSegment.OnGetUseList := GetMfSfrUseList;
    FMfSfrOutSegment.Name := StrModflowSfrDownstreamSegment;
    AddTimeList(FMfSfrOutSegment);

    FMfSfrDiversionSegment := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDiversionSegment.OnTimeListUsed := PackageUsed;
    FMfSfrDiversionSegment.OnInitialize := InitializeSfrDisplay;
    FMfSfrDiversionSegment.OnGetUseList := GetMfSfrUseList;
    FMfSfrDiversionSegment.Name := StrModflowSfrDiversionSegment;
    AddTimeList(FMfSfrDiversionSegment);

    FMfSfrIprior := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrIprior.OnTimeListUsed := PackageUsed;
    FMfSfrIprior.OnInitialize := InitializeSfrDisplay;
    FMfSfrIprior.OnGetUseList := GetMfSfrUseList;
    FMfSfrIprior.Name := StrModflowSfrIprior;
    AddTimeList(FMfSfrIprior);

    FMfSfrFlow := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrFlow.OnTimeListUsed := PackageUsed;
    FMfSfrFlow.OnInitialize := InitializeSfrDisplay;
    FMfSfrFlow.OnGetUseList := GetMfSfrFlowUseList;
    FMfSfrFlow.Name := StrModflowSfrFlow;
    AddTimeList(FMfSfrFlow);

    FMfSfrRunoff := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrRunoff.OnTimeListUsed := PackageUsed;
    FMfSfrRunoff.OnInitialize := InitializeSfrDisplay;
    FMfSfrRunoff.OnGetUseList := GetMfSfrRunoffUseList;
    FMfSfrRunoff.Name := StrModflowSfrRunoff;
    AddTimeList(FMfSfrRunoff);

    FMfSfrPrecipitation := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrPrecipitation.OnTimeListUsed := PackageUsed;
    FMfSfrPrecipitation.OnInitialize := InitializeSfrDisplay;
    FMfSfrPrecipitation.OnGetUseList := GetMfSfrPrecipitationUseList;
    FMfSfrPrecipitation.Name := StrModflowSfrPrecipitation;
    AddTimeList(FMfSfrPrecipitation);

    FMfSfrEvapotranspiration := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrEvapotranspiration.OnTimeListUsed := PackageUsed;
    FMfSfrEvapotranspiration.OnInitialize := InitializeSfrDisplay;
    FMfSfrEvapotranspiration.OnGetUseList := GetMfSfrEvapotranspirationUseList;
    FMfSfrEvapotranspiration.Name := StrModflowSfrEvapotranspiration;
    AddTimeList(FMfSfrEvapotranspiration);

    FMfSfrChannelRoughness := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrChannelRoughness.OnTimeListUsed := PackageUsed;
    FMfSfrChannelRoughness.OnInitialize := InitializeSfrDisplay;
    FMfSfrChannelRoughness.OnGetUseList := GetMfSfrChannelRoughnessUseList;
    FMfSfrChannelRoughness.Name := StrModflowSfrChannelRoughness;
    AddTimeList(FMfSfrChannelRoughness);

    FMfSfrBankRoughness := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrBankRoughness.OnTimeListUsed := PackageUsed;
    FMfSfrBankRoughness.OnInitialize := InitializeSfrDisplay;
    FMfSfrBankRoughness.OnGetUseList := GetMfSfrBankRoughnessUseList;
    FMfSfrBankRoughness.Name := StrModflowSfrBankRoughness;
    AddTimeList(FMfSfrBankRoughness);

    FMfSfrDepthCoefficient := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDepthCoefficient.OnTimeListUsed := PackageUsed;
    FMfSfrDepthCoefficient.OnInitialize := InitializeSfrDisplay;
    FMfSfrDepthCoefficient.OnGetUseList := GetMfSfrDepthCoefficientUseList;
    FMfSfrDepthCoefficient.Name := StrModflowSfrDepthCoefficient;
    AddTimeList(FMfSfrDepthCoefficient);

    FMfSfrDepthExponent := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDepthExponent.OnTimeListUsed := PackageUsed;
    FMfSfrDepthExponent.OnInitialize := InitializeSfrDisplay;
    FMfSfrDepthExponent.OnGetUseList := GetMfSfrDepthExponentUseList;
    FMfSfrDepthExponent.Name := StrModflowSfrDepthExponent;
    AddTimeList(FMfSfrDepthExponent);

    FMfSfrWidthCoefficient := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrWidthCoefficient.OnTimeListUsed := PackageUsed;
    FMfSfrWidthCoefficient.OnInitialize := InitializeSfrDisplay;
    FMfSfrWidthCoefficient.OnGetUseList := GetMfSfrWidthCoefficientUseList;
    FMfSfrWidthCoefficient.Name := StrModflowSfrWidthCoefficient;
    AddTimeList(FMfSfrWidthCoefficient);

    FMfSfrWidthExponent := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrWidthExponent.OnTimeListUsed := PackageUsed;
    FMfSfrWidthExponent.OnInitialize := InitializeSfrDisplay;
    FMfSfrWidthExponent.OnGetUseList := GetMfSfrWidthExponentUseList;
    FMfSfrWidthExponent.Name := StrModflowSfrWidthExponent;
    AddTimeList(FMfSfrWidthExponent);

    FMfSfrUpstreamHydraulicConductivity :=
      TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrUpstreamHydraulicConductivity.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUsed;
    FMfSfrUpstreamHydraulicConductivity.OnInitialize := InitializeSfrDisplay;
    FMfSfrUpstreamHydraulicConductivity.OnGetUseList :=
      GetMfSfrUpstreamHydraulicConductivityUseList;
    FMfSfrUpstreamHydraulicConductivity.Name :=
      StrModflowSfrUpstreamHydraulicConductivity;
    AddTimeList(FMfSfrUpstreamHydraulicConductivity);

    FMfSfrDownstreamHydraulicConductivity :=
      TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDownstreamHydraulicConductivity.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUsed;
    FMfSfrDownstreamHydraulicConductivity.OnInitialize := InitializeSfrDisplay;
    FMfSfrDownstreamHydraulicConductivity.OnGetUseList :=
      GetMfSfrDownstreamHydraulicConductivityUseList;
    FMfSfrDownstreamHydraulicConductivity.Name :=
      StrModflowSfrDownstreamHydraulicConductivity;
    AddTimeList(FMfSfrDownstreamHydraulicConductivity);

    FMfSfrUpstreamWidth := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrUpstreamWidth.OnTimeListUsed := PackageUsed;
    FMfSfrUpstreamWidth.OnInitialize := InitializeSfrDisplay;
    FMfSfrUpstreamWidth.OnGetUseList := GetMfSfrUpstreamWidthUseList;
    FMfSfrUpstreamWidth.Name := StrModflowSfrUpstreamWidth;
    AddTimeList(FMfSfrUpstreamWidth);

    FMfSfrDownstreamWidth := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDownstreamWidth.OnTimeListUsed := PackageUsed;
    FMfSfrDownstreamWidth.OnInitialize := InitializeSfrDisplay;
    FMfSfrDownstreamWidth.OnGetUseList := GetMfSfrDownstreamWidthUseList;
    FMfSfrDownstreamWidth.Name := StrModflowSfrDownstreamWidth;
    AddTimeList(FMfSfrDownstreamWidth);

    FMfSfrUpstreamThickness := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrUpstreamThickness.OnTimeListUsed := ModflowSfrUpstreamDownstreamUsed;
    FMfSfrUpstreamThickness.OnInitialize := InitializeSfrDisplay;
    FMfSfrUpstreamThickness.OnGetUseList := GetMfSfrUpstreamThicknessUseList;
    FMfSfrUpstreamThickness.Name := StrModflowSfrUpstreamThickness;
    AddTimeList(FMfSfrUpstreamThickness);

    FMfSfrDownstreamThickness := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDownstreamThickness.OnTimeListUsed := ModflowSfrUpstreamDownstreamUsed;
    FMfSfrDownstreamThickness.OnInitialize := InitializeSfrDisplay;
    FMfSfrDownstreamThickness.OnGetUseList := GetMfSfrDownstreamThicknessUseList;
    FMfSfrDownstreamThickness.Name := StrModflowSfrDownstreamThickness;
    AddTimeList(FMfSfrDownstreamThickness);

    FMfSfrUpstreamElevation := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrUpstreamElevation.OnTimeListUsed := ModflowSfrUpstreamDownstreamUsed;
    FMfSfrUpstreamElevation.OnInitialize := InitializeSfrDisplay;
    FMfSfrUpstreamElevation.OnGetUseList := GetMfSfrUpstreamElevationUseList;
    FMfSfrUpstreamElevation.Name := StrModflowSfrUpstreamElevation;
    AddTimeList(FMfSfrUpstreamElevation);

    FMfSfrDownstreamElevation := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDownstreamElevation.OnTimeListUsed := ModflowSfrUpstreamDownstreamUsed;
    FMfSfrDownstreamElevation.OnInitialize := InitializeSfrDisplay;
    FMfSfrDownstreamElevation.OnGetUseList := GetMfSfrDownstreamElevationUseList;
    FMfSfrDownstreamElevation.Name := StrModflowSfrDownstreamElevation;
    AddTimeList(FMfSfrDownstreamElevation);

    FMfSfrUpstreamDepth := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrUpstreamDepth.OnTimeListUsed := PackageUsed;
    FMfSfrUpstreamDepth.OnInitialize := InitializeSfrDisplay;
    FMfSfrUpstreamDepth.OnGetUseList := GetMfSfrUpstreamDepthUseList;
    FMfSfrUpstreamDepth.Name := StrModflowSfrUpstreamDepth;
    AddTimeList(FMfSfrUpstreamDepth);

    FMfSfrDownstreamDepth := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDownstreamDepth.OnTimeListUsed := PackageUsed;
    FMfSfrDownstreamDepth.OnInitialize := InitializeSfrDisplay;
    FMfSfrDownstreamDepth.OnGetUseList := GetMfSfrDownstreamDepthUseList;
    FMfSfrDownstreamDepth.Name := StrModflowSfrDownstreamDepth;
    AddTimeList(FMfSfrDownstreamDepth);

    FMfSfrUpstreamUnsaturatedWaterContent :=
      TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrUpstreamUnsaturatedWaterContent.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUnsatUsed;
    FMfSfrUpstreamUnsaturatedWaterContent.OnInitialize := InitializeSfrDisplay;
    FMfSfrUpstreamUnsaturatedWaterContent.OnGetUseList :=
      GetMfSfrUpstreamSatWatContentUseList;
    FMfSfrUpstreamUnsaturatedWaterContent.Name :=
      StrModflowSfrUpstreamSaturatedWaterContent;
    AddTimeList(FMfSfrUpstreamUnsaturatedWaterContent);

    FMfSfrDownstreamUnsaturatedWaterContent :=
      TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDownstreamUnsaturatedWaterContent.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUnsatUsed;
    FMfSfrDownstreamUnsaturatedWaterContent.OnInitialize := InitializeSfrDisplay;
    FMfSfrDownstreamUnsaturatedWaterContent.OnGetUseList :=
      GetMfSfrDownstreamSatWatContentUseList;
    FMfSfrDownstreamUnsaturatedWaterContent.Name :=
      StrModflowSfrDownstreamSaturatedWaterContent;
    AddTimeList(FMfSfrDownstreamUnsaturatedWaterContent);

    FMfSfrUpstreamUnsatInitialWaterContent :=
      TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrUpstreamUnsatInitialWaterContent.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUnsatUsed;
    FMfSfrUpstreamUnsatInitialWaterContent.OnInitialize := InitializeSfrDisplay;
    FMfSfrUpstreamUnsatInitialWaterContent.OnGetUseList :=
      GetMfSfrUpstreamInitialWatContentUseList;
    FMfSfrUpstreamUnsatInitialWaterContent.Name :=
      StrModflowSfrUpstreamInitialUnsaturatedWaterContent;
    AddTimeList(FMfSfrUpstreamUnsatInitialWaterContent);

    FMfSfrDownstreamUnsatInitialWaterContent :=
      TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDownstreamUnsatInitialWaterContent.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUnsatUsed;
    FMfSfrDownstreamUnsatInitialWaterContent.OnInitialize :=
      InitializeSfrDisplay;
    FMfSfrDownstreamUnsatInitialWaterContent.OnGetUseList :=
      GetMfSfrDownstreamInitialWatContentUseList;
    FMfSfrDownstreamUnsatInitialWaterContent.Name :=
      StrModflowSfrDownstreamInitialUnsaturatedWaterContent;
    AddTimeList(FMfSfrDownstreamUnsatInitialWaterContent);

    FMfSfrUpstreamBrooksCorey := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrUpstreamBrooksCorey.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUnsatUsed;
    FMfSfrUpstreamBrooksCorey.OnInitialize := InitializeSfrDisplay;
    FMfSfrUpstreamBrooksCorey.OnGetUseList := GetMfSfrUpstreamBrooksCoreyUseList;
    FMfSfrUpstreamBrooksCorey.Name := StrModflowSfrUpstreamBrooksCoreyExponent;
    AddTimeList(FMfSfrUpstreamBrooksCorey);

    FMfSfrDownstreamBrooksCorey := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDownstreamBrooksCorey.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUnsatUsed;
    FMfSfrDownstreamBrooksCorey.OnInitialize := InitializeSfrDisplay;
    FMfSfrDownstreamBrooksCorey.OnGetUseList :=
      GetMfSfrDownstreamBrooksCoreyUseList;
    FMfSfrDownstreamBrooksCorey.Name :=
      StrModflowSfrDownstreamBrooksCoreyExponent;
    AddTimeList(FMfSfrDownstreamBrooksCorey);

    FMfSfrUpstreamUnsatKz := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrUpstreamUnsatKz.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUnsatKzUsed;
    FMfSfrUpstreamUnsatKz.OnInitialize := InitializeSfrDisplay;
    FMfSfrUpstreamUnsatKz.OnGetUseList := GetMfSfrUpstreamUnsatKzUseList;
    FMfSfrUpstreamUnsatKz.Name := StrModflowSfrUpstreamMaxUnsaturatedKz;
    AddTimeList(FMfSfrUpstreamUnsatKz);

    FMfSfrDownstreamUnsatKz := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSfrDownstreamUnsatKz.OnTimeListUsed :=
      ModflowSfrUpstreamDownstreamUnsatKzUsed;
    FMfSfrDownstreamUnsatKz.OnInitialize := InitializeSfrDisplay;
    FMfSfrDownstreamUnsatKz.OnGetUseList := GetMfSfrDownstreamUnsatKzUseList;
    FMfSfrDownstreamUnsatKz.Name := StrModflowSfrDownstreamMaxUnsaturatedKz;
    AddTimeList(FMfSfrDownstreamUnsatKz);
  end;
end;

destructor TSfrPackageSelection.Destroy;
begin
  FParameterInstances.Free;

  FMfSfrUpstreamUnsaturatedWaterContent.Free;
  FMfSfrDownstreamUnsaturatedWaterContent.Free;
  FMfSfrUpstreamUnsatInitialWaterContent.Free;
  FMfSfrDownstreamUnsatInitialWaterContent.Free;
  FMfSfrUpstreamBrooksCorey.Free;
  FMfSfrDownstreamBrooksCorey.Free;
  FMfSfrUpstreamUnsatKz.Free;
  FMfSfrDownstreamUnsatKz.Free;
  FMfSfrUpstreamDepth.Free;
  FMfSfrDownstreamDepth.Free;
  FMfSfrUpstreamElevation.Free;
  FMfSfrDownstreamElevation.Free;
  FMfSfrUpstreamThickness.Free;
  FMfSfrDownstreamThickness.Free;
  FMfSfrUpstreamWidth.Free;
  FMfSfrDownstreamWidth.Free;
  FMfSfrUpstreamHydraulicConductivity.Free;
  FMfSfrDownstreamHydraulicConductivity.Free;
  FMfSfrDepthCoefficient.Free;
  FMfSfrDepthExponent.Free;
  FMfSfrWidthCoefficient.Free;
  FMfSfrWidthExponent.Free;
  FMfSfrBankRoughness.Free;
  FMfSfrChannelRoughness.Free;
  FMfSfrEvapotranspiration.Free;
  FMfSfrPrecipitation.Free;
  FMfSfrRunoff.Free;
  FMfSfrFlow.Free;
  FMfSfrIprior.Free;
  FMfSfrDiversionSegment.Free;
  FMfSfrOutSegment.Free;
  FMfSfrVerticalUnsatK.Free;
  FMfSfrBrooksCorey.Free;
  FMfSfrInitialWaterContent.Free;
  FMfSfrSaturatedWaterContent.Free;
  FMfSfrStreamK.Free;
  FMfSfrStreamThickness.Free;
  FMfSfrStreamSlope.Free;
  FMfSfrStreamTop.Free;
  FMfSfrReachLength.Free;
  FMfSfrIcalc.Free;
  FMfSfrReachNumber.Free;
  FMfSfrSegmentNumber.Free;
  FStoredLossFactor.Free;

  inherited;
end;

procedure TSfrPackageSelection.GetMfSfrBankRoughnessUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrChanelItemUseList(1, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrBrooksCoreyUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrReachUseList(7, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrChanelItemUseList(DataIndex: integer;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TSfrChannelItem;
  ValueIndex: Integer;
  Boundary: TSfrBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSfrBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.ChannelValues.Count -1 do
      begin
        Item := Boundary.ChannelValues[ValueIndex] as TSfrChannelItem;
        UpdateUseList(DataIndex, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSfrPackageSelection.GetMfSfrChannelRoughnessUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrChanelItemUseList(0, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDepthCoefficientUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrEquationItemUseList(0, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDepthExponentUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrEquationItemUseList(1, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamBrooksCoreyUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrDownstreamUnsatItemUseList(2, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamDepthUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrDownstreamItemUseList(4, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamElevationUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrDownstreamItemUseList(2, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamHydraulicConductivityUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrDownstreamItemUseList(0, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamInitialWatContentUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrDownstreamUnsatItemUseList(1, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamItemUseList(DataIndex: integer;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TSfrSegmentItem;
  ValueIndex: Integer;
  Boundary: TSfrBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSfrBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.DownstreamSegmentValues.Count -1 do
      begin
        Item := Boundary.DownstreamSegmentValues[ValueIndex]
          as TSfrSegmentItem;
        UpdateUseList(DataIndex, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamSatWatContentUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrDownstreamUnsatItemUseList(0, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamThicknessUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrDownstreamItemUseList(1, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamUnsatItemUseList(
  DataIndex: integer; NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TSfrUnsatSegmentItem;
  ValueIndex: Integer;
  Boundary: TSfrBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  if (Isfropt >= 2) then
  begin
    for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
    begin
      ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
      if ScreenObject.Deleted then
      begin
        Continue;
      end;
      Boundary := ScreenObject.ModflowSfrBoundary;
      if (Boundary <> nil) and Boundary.Used then
      begin
        for ValueIndex := 0 to Boundary.DownstreamUnsatSegmentValues.Count -1 do
        begin
          Item := Boundary.DownstreamUnsatSegmentValues[ValueIndex]
            as TSfrUnsatSegmentItem;
          UpdateUseList(DataIndex, NewUseList, Item);
        end;
      end;
    end;
  end;
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamUnsatKzUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrDownstreamUnsatItemUseList(3, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrDownstreamWidthUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrDownstreamItemUseList(3, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrEquationItemUseList(DataIndex: integer;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TSfrEquationItem;
  ValueIndex: Integer;
  Boundary: TSfrBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSfrBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.EquationValues.Count -1 do
      begin
        Item := Boundary.EquationValues[ValueIndex] as TSfrEquationItem;
        UpdateUseList(DataIndex, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSfrPackageSelection.GetMfSfrEvapotranspirationUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrFlowItemUseList(2, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrFlowItemUseList(DataIndex: integer;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TSfrSegmentFlowItem;
  ValueIndex: Integer;
  Boundary: TSfrBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSfrBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.SegmentFlows.Count -1 do
      begin
        Item := Boundary.SegmentFlows[ValueIndex] as TSfrSegmentFlowItem;
        UpdateUseList(DataIndex, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSfrPackageSelection.GetMfSfrFlowUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrFlowItemUseList(0, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrPrecipitationUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrFlowItemUseList(1, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrReachLengthUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrReachUseList(0, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrReachUseList(DataIndex: integer;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TSfrItem;
  ValueIndex: Integer;
  Boundary: TSfrBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSfrBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TSfrItem;
        UpdateUseList(DataIndex, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSfrPackageSelection.GetMfSfrRunoffUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrFlowItemUseList(3, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrStreamInitialWatContentUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrReachUseList(6, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrStreamKUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrReachUseList(1, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrStreamSatWatContentUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrReachUseList(5, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrStreamSlopeUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrReachUseList(4, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrStreamThicknessUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrReachUseList(2, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrStreamTopUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrReachUseList(3, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUnsatKzUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrReachUseList(8, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamBrooksCoreyUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrUpstreamUnsatItemUseList(2, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamDepthUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrUpstreamItemUseList(4, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamElevationUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrUpstreamItemUseList(2, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamHydraulicConductivityUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrUpstreamItemUseList(0, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamInitialWatContentUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrUpstreamUnsatItemUseList(1, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamItemUseList(DataIndex: integer;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TSfrSegmentItem;
  ValueIndex: Integer;
  Boundary: TSfrBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSfrBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.UpstreamSegmentValues.Count -1 do
      begin
        Item := Boundary.UpstreamSegmentValues[ValueIndex] as TSfrSegmentItem;
        UpdateUseList(DataIndex, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamSatWatContentUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfSfrUpstreamUnsatItemUseList(0, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamThicknessUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrUpstreamItemUseList(1, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamUnsatItemUseList(
  DataIndex: integer; NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TSfrUnsatSegmentItem;
  ValueIndex: Integer;
  Boundary: TSfrBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  if (Isfropt >= 2) then
  begin
    for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
    begin
      ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
      if ScreenObject.Deleted then
      begin
        Continue;
      end;
      Boundary := ScreenObject.ModflowSfrBoundary;
      if (Boundary <> nil) and Boundary.Used then
      begin
        for ValueIndex := 0 to Boundary.UpstreamUnsatSegmentValues.Count -1 do
        begin
          Item := Boundary.UpstreamUnsatSegmentValues[ValueIndex]
            as TSfrUnsatSegmentItem;
          UpdateUseList(DataIndex, NewUseList, Item);
        end;
      end;
    end;
  end;
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamUnsatKzUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrUpstreamUnsatItemUseList(3, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUpstreamWidthUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrUpstreamItemUseList(3, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  // do nothing.

  // The segment number, reach number and ICALC
  // can not depend on other data sets
end;

procedure TSfrPackageSelection.GetMfSfrWidthCoefficientUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrEquationItemUseList(2, NewUseList);
end;

procedure TSfrPackageSelection.GetMfSfrWidthExponentUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetMfSfrEquationItemUseList(3, NewUseList);
end;

procedure TSfrPackageSelection.ComputeAverages(List: TModflowBoundListOfTimeLists);
var
  Index: Integer;
  DisplayList: TModflowBoundaryDisplayTimeList;
begin
  for Index := 0 to List.Count - 1 do
  begin
    DisplayList := List[Index];
    DisplayList.ComputeAverage;
  end;
end;

procedure TSfrPackageSelection.InitializeSfrDisplay(Sender: TObject);
var
  SfrWriter: TModflowSFR_Writer;
  List: TModflowBoundListOfTimeLists;
begin
  List := TModflowBoundListOfTimeLists.Create;
  SfrWriter := TModflowSFR_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    GetDisplayLists(List);

    SfrWriter.UpdateDisplay(List);

    ComputeAverages(List);
  finally
    SfrWriter.Free;
    List.Free;
  end;
end;

procedure TSfrPackageSelection.InvalidateAllTimeLists;
begin
  inherited;
//  if PackageUsed(nil) then
  begin
    MfSfrBankRoughness.Invalidate;
    MfSfrBrooksCorey.Invalidate;
    MfSfrUpstreamHydraulicConductivity.Invalidate;
    MfSfrDownstreamHydraulicConductivity.Invalidate;
    MfSfrDepthCoefficient.Invalidate;
    MfSfrDepthExponent.Invalidate;
    MfSfrDownstreamBrooksCorey.Invalidate;
    MfSfrDownstreamDepth.Invalidate;
    MfSfrDownstreamElevation.Invalidate;
    MfSfrDownstreamThickness.Invalidate;
    MfSfrDownstreamUnsatInitialWaterContent.Invalidate;
    MfSfrDownstreamUnsatKz.Invalidate;
    MfSfrDownstreamUnsaturatedWaterContent.Invalidate;
    MfSfrDownstreamWidth.Invalidate;
    MfSfrEvapotranspiration.Invalidate;
    MfSfrFlow.Invalidate;
    MfSfrInitialWaterContent.Invalidate;
    MfSfrIprior.Invalidate;
    MfSfrPrecipitation.Invalidate;
    MfSfrReachLength.Invalidate;
    MfSfrRunoff.Invalidate;
    MfSfrSaturatedWaterContent.Invalidate;
    InvalidateMfSfrSegmentReachAndIcalc(nil);
    MfSfrStreamK.Invalidate;
    MfSfrStreamSlope.Invalidate;
    MfSfrStreamThickness.Invalidate;
    MfSfrStreamTop.Invalidate;
    MfSfrUpstreamBrooksCorey.Invalidate;
    MfSfrUpstreamDepth.Invalidate;
    MfSfrUpstreamElevation.Invalidate;
    MfSfrUpstreamThickness.Invalidate;
    MfSfrUpstreamUnsatInitialWaterContent.Invalidate;
    MfSfrDownstreamUnsatKz.Invalidate;
    MfSfrDownstreamUnsaturatedWaterContent.Invalidate;
    MfSfrUpstreamWidth.Invalidate;
    MfSfrVerticalUnsatK.Invalidate;
    MfSfrWidthCoefficient.Invalidate;
    MfSfrWidthExponent.Invalidate;
  end;
end;

procedure TSfrPackageSelection.InitializeVariables;
begin
  inherited;
  Dleak := 0.0001;
  Isfropt := 0;
  Nstrail := 10;
  Isuzn := 10;
  Nsfrsets := 30;
  FKinematicRoutingTolerance := 0.0001;
  FPrintStreams := True;
  FPrintFlows := pfListing;
  FTimeStepsForKinematicRouting := 1;
  FKinematicRoutingWeight := 1;
  GageOverallBudget := False;
  UseGsflowFormat := False;
  KinematicRouting := False;
  LossFactorOption := False;
  LossFactor := 1;
end;

procedure TSfrPackageSelection.GetDisplayLists(List: TModflowBoundListOfTimeLists);
var
  Index: Integer;
  DisplayList: TModflowBoundaryDisplayTimeList;
begin
  List.Add(MfSfrSegmentNumber);
  List.Add(MfSfrReachNumber);
  List.Add(MfSfrIcalc);
  List.Add(MfSfrReachLength);
  List.Add(MfSfrStreamTop);
  List.Add(MfSfrStreamSlope);
  List.Add(MfSfrStreamThickness);
  List.Add(MfSfrStreamK);
  List.Add(MfSfrSaturatedWaterContent);
  List.Add(MfSfrInitialWaterContent);
  List.Add(MfSfrBrooksCorey);
  List.Add(MfSfrVerticalUnsatK);
  List.Add(MfSfrOutSegment);
  List.Add(MfSfrDiversionSegment);
  List.Add(MfSfrIprior);
  List.Add(MfSfrFlow);
  List.Add(MfSfrRunoff);
  List.Add(MfSfrPrecipitation);
  List.Add(MfSfrEvapotranspiration);
  List.Add(MfSfrChannelRoughness);
  List.Add(MfSfrBankRoughness);
  List.Add(MfSfrDepthCoefficient);
  List.Add(MfSfrDepthExponent);
  List.Add(MfSfrWidthCoefficient);
  List.Add(MfSfrWidthExponent);
  List.Add(MfSfrUpstreamHydraulicConductivity);
  List.Add(MfSfrDownstreamHydraulicConductivity);
  List.Add(MfSfrUpstreamWidth);
  List.Add(MfSfrDownstreamWidth);
  List.Add(MfSfrUpstreamThickness);
  List.Add(MfSfrDownstreamThickness);
  List.Add(MfSfrUpstreamElevation);
  List.Add(MfSfrDownstreamElevation);
  List.Add(MfSfrUpstreamDepth);
  List.Add(MfSfrDownstreamDepth);
  List.Add(MfSfrUpstreamUnsaturatedWaterContent);
  List.Add(MfSfrDownstreamUnsaturatedWaterContent);
  List.Add(MfSfrUpstreamUnsatInitialWaterContent);
  List.Add(MfSfrDownstreamUnsatInitialWaterContent);
  List.Add(MfSfrUpstreamBrooksCorey);
  List.Add(MfSfrDownstreamBrooksCorey);
  List.Add(MfSfrUpstreamUnsatKz);
  List.Add(MfSfrDownstreamUnsatKz);
  for Index := 0 to List.Count - 1 do
  begin
    DisplayList := List[Index];
    DisplayList.CreateDataSets;
  end;
end;

procedure TSfrPackageSelection.InvalidateMfSfrSegmentReachAndIcalc(
  Sender: TObject);
begin
  MfSfrSegmentNumber.Invalidate;
  MfSfrReachNumber.Invalidate;
  MfSfrIcalc.Invalidate;
  MfSfrOutSegment.Invalidate;
  MfSfrDiversionSegment.Invalidate;
  MfSfrChannelRoughness.Invalidate;
  MfSfrBankRoughness.Invalidate;
  MfSfrDepthCoefficient.Invalidate;
  MfSfrDepthExponent.Invalidate;
  MfSfrWidthCoefficient.Invalidate;
  MfSfrWidthExponent.Invalidate;
  MfSfrUpstreamHydraulicConductivity.Invalidate;
  MfSfrDownstreamHydraulicConductivity.Invalidate;
  MfSfrUpstreamWidth.Invalidate;
  MfSfrDownstreamWidth.Invalidate;
  MfSfrUpstreamThickness.Invalidate;
  MfSfrDownstreamThickness.Invalidate;
  MfSfrUpstreamElevation.Invalidate;
  MfSfrDownstreamElevation.Invalidate;
  MfSfrUpstreamDepth.Invalidate;
  MfSfrDownstreamDepth.Invalidate;
  MfSfrUpstreamUnsaturatedWaterContent.Invalidate;
  MfSfrDownstreamUnsaturatedWaterContent.Invalidate;
  MfSfrUpstreamUnsatInitialWaterContent.Invalidate;
  MfSfrDownstreamUnsatInitialWaterContent.Invalidate;
  MfSfrUpstreamBrooksCorey.Invalidate;
  MfSfrDownstreamBrooksCorey.Invalidate;
  MfSfrUpstreamUnsatKz.Invalidate;
  MfSfrDownstreamUnsatKz.Invalidate;
end;

function TSfrPackageSelection.ModflowSfrSpatialVariationSelected(
  Sender: TObject): boolean;
begin
  result := IsSelected and (Isfropt in [1,2,3]);
end;

function TSfrPackageSelection.ModflowSfrUnsatKzSpatialVariationSelected(
  Sender: TObject): boolean;
begin
  result := IsSelected and (Isfropt = 3);
end;

function TSfrPackageSelection.ModflowSfrUnsatSpatialVariationSelected(
  Sender: TObject): boolean;
begin
  result := IsSelected and (Isfropt in [2,3]);
end;

function TSfrPackageSelection.ModflowSfrUpstreamDownstreamUnsatKzUsed(
  Sender: TObject): boolean;
begin
  result := IsSelected and (Isfropt = 5);
end;

function TSfrPackageSelection.ModflowSfrUpstreamDownstreamUnsatUsed(
  Sender: TObject): boolean;
begin
  result := IsSelected and (Isfropt in [4,5]);
end;

function TSfrPackageSelection.ModflowSfrUpstreamDownstreamUsed(
  Sender: TObject): boolean;
begin
  result := IsSelected and (Isfropt in [0,4,5]);
end;

procedure TSfrPackageSelection.SetDleak(const Value: double);
begin
  if FDleak <> Value then
  begin
    InvalidateModel;
    FDleak := Value;
  end;
end;

procedure TSfrPackageSelection.SetGageOverallBudget(const Value: boolean);
begin
  if FGageOverallBudget <> Value then
  begin
    InvalidateModel;
    FGageOverallBudget := Value;
  end;
end;

procedure TSfrPackageSelection.SetIsfropt(const Value: integer);
var
  SelectionChanged: boolean;
  PhastModel: TCustomModel;
begin
  if FIsfropt <> Value then
  begin
    InvalidateModel;
    if FModel <> nil then
    begin
      SelectionChanged := (FIsfropt in [1,2,3]) <> (Value in [1,2,3]);
      PhastModel := nil;
      if SelectionChanged then
      begin
        PhastModel := FModel as TCustomModel;
        PhastModel.InvalidateMfSfrStreamTop(self);
        PhastModel.InvalidateMfSfrStreamSlope(self);
        PhastModel.InvalidateMfSfrStreamThickness(self);
        PhastModel.InvalidateMfSfrStreamK(self);
      end;
      SelectionChanged := (FIsfropt in [2,3]) <> (Value in [2,3]);
      if SelectionChanged then
      begin
        if PhastModel = nil then
        begin
          PhastModel := FModel as TCustomModel;
        end;
        PhastModel.InvalidateMfSfrSaturatedWaterContent(self);
        PhastModel.InvalidateMfSfrInitialWaterContent(self);
        PhastModel.InvalidateMfSfrBrooksCorey(self);
      end;
      SelectionChanged := (FIsfropt = 3) <> (Value = 3);
      if SelectionChanged then
      begin
        if PhastModel = nil then
        begin
          PhastModel := FModel as TCustomModel;
        end;
        PhastModel.InvalidateMfSfrVerticalUnsatK(self);
      end;
      SelectionChanged := (FIsfropt in [0,4,5]) <> (Value in [0,4,5]);
      if SelectionChanged then
      begin
        if PhastModel = nil then
        begin
          PhastModel := FModel as TCustomModel;
        end;
        PhastModel.InvalidateMfSfrUpstreamHydraulicConductivity(self);
        PhastModel.InvalidateMfSfrDownstreamHydraulicConductivity(self);
      end;
      SelectionChanged := (FIsfropt in [0,1,2,3]) <> (Value in [0,1,2,3]);
      if SelectionChanged then
      begin
        if PhastModel = nil then
        begin
          PhastModel := FModel as TCustomModel;
        end;
        PhastModel.InvalidateMfSfrUpstreamWidth(self);
        PhastModel.InvalidateMfSfrDownstreamWidth(self);
      end;
      SelectionChanged := (FIsfropt  <> Value);
      if SelectionChanged then
      begin
        if PhastModel = nil then
        begin
          PhastModel := FModel as TCustomModel;
        end;
        PhastModel.InvalidateMfSfrUpstreamThickness(self);
        PhastModel.InvalidateMfSfrDownstreamThickness(self);
        PhastModel.InvalidateMfSfrUpstreamElevation(self);
        PhastModel.InvalidateMfSfrDownstreamElevation(self);
      end;
      SelectionChanged := (FIsfropt in [4,5]) <> (Value in [4,5]);
      if SelectionChanged then
      begin
        if PhastModel = nil then
        begin
          PhastModel := FModel as TCustomModel;
        end;
        PhastModel.InvalidateMfSfrUpstreamUnsaturatedWaterContent(self);
        PhastModel.InvalidateMfSfrDownstreamUnsaturatedWaterContent(self);
        PhastModel.InvalidateMfSfrUpstreamUnsatInitialWaterContent(self);
        PhastModel.InvalidateMfSfrDownstreamUnsatInitialWaterContent(self);
        PhastModel.InvalidateMfSfrUpstreamBrooksCorey(self);
        PhastModel.InvalidateMfSfrDownstreamBrooksCorey(self);
      end;
      SelectionChanged := (FIsfropt = 5) <> (Value = 5);
      if SelectionChanged then
      begin
        if PhastModel = nil then
        begin
          PhastModel := FModel as TCustomModel;
        end;
        PhastModel.InvalidateMfSfrUpstreamUnsatKz(self);
        PhastModel.InvalidateMfSfrDownstreamUnsatKz(self);
      end;

    end;
    FIsfropt := Value;
  end;
end;

procedure TSfrPackageSelection.SetIsSelected(const Value: boolean);
begin
  inherited;
  DischargeRoutingUpdate;
end;

procedure TSfrPackageSelection.SetIsuzn(const Value: integer);
begin
  if FIsuzn <> Value then
  begin
    InvalidateModel;
    FIsuzn := Value;
  end;
end;

procedure TSfrPackageSelection.SetKinematicRouting(const Value: boolean);
begin
  if FKinematicRouting <> Value then
  begin
    InvalidateModel;
    FKinematicRouting := Value;
  end;
end;

procedure TSfrPackageSelection.SetKinematicRoutingTolerance(
  const Value: double);
begin
  if FKinematicRoutingTolerance <> Value then
  begin
    InvalidateModel;
    FKinematicRoutingTolerance := Value;
  end;
end;

procedure TSfrPackageSelection.SetKinematicRoutingWeight(const Value: double);
begin
  if FKinematicRoutingWeight <> Value then
  begin
    InvalidateModel;
    FKinematicRoutingWeight := Value;
  end;
end;

procedure TSfrPackageSelection.SetNsfrsets(const Value: integer);
begin
  if FNsfrsets <> Value then
  begin
    InvalidateModel;
    FNsfrsets := Value;
  end;
end;

procedure TSfrPackageSelection.SetNstrail(const Value: integer);
begin
  if FNstrail <> Value then
  begin
    InvalidateModel;
    FNstrail := Value;
  end;
end;

procedure TSfrPackageSelection.SetParameterInstances(
  const Value: TSfrParamInstances);
begin
  FParameterInstances.Assign(Value);
end;

procedure TSfrPackageSelection.SetPrintFlows(const Value: TPrintFlows);
begin
  if FPrintFlows <> Value then
  begin
    InvalidateModel;
    FPrintFlows := Value;
  end;
end;

procedure TSfrPackageSelection.SetPrintStreams(const Value: boolean);
begin
  if FPrintStreams <> Value then
  begin
    InvalidateModel;
    FPrintStreams := Value;
  end;
  if FPrintStreams then
  begin
    PrintFlows := pfNoPrint;
  end
  else
  begin
    PrintFlows := pfListing;
  end;
end;

procedure TSfrPackageSelection.SetTimeStepsForKinematicRouting(
  const Value: integer);
begin
  if FTimeStepsForKinematicRouting <> Value then
  begin
    InvalidateModel;
    FTimeStepsForKinematicRouting := Value;
  end;
end;

procedure TSfrPackageSelection.SetUseGsflowFormat(const Value: boolean);
begin
  if FUseGsflowFormat <> Value then
  begin
    InvalidateModel;
    FUseGsflowFormat := Value;
  end;
end;

function TSfrPackageSelection.StreamConstant: double;
var
  ModflowOptions: TModflowOptions;
begin
  frmErrorsAndWarnings.RemoveErrorGroup(FModel, SfrError);
  result := 1;
  ModflowOptions := (FModel as TCustomModel).ModflowOptions;
  case ModflowOptions.LengthUnit of
    0: // undefined
      begin
        frmErrorsAndWarnings.AddError(FModel, SfrError, StrLengthUnitsForMod);
      end;
    1: // feet
      begin
        result := 1 / 0.3048;
      end;
    2: // m
      begin
      end;
    3: // cm
      begin
        result := 1 / 100;
      end;
  else
    Assert(False);
  end;
  if result <> 1 then
  begin
    result := Power(result, 1 / 3);
  end;
  case ModflowOptions.TimeUnit of
    0: // Undefined
      begin
//        ErrorMessage :=
//          StrTimeUnitsForModel;
        frmErrorsAndWarnings.AddError(FModel, SfrError, StrTimeUnitsForModel);
      end;
    1: // Seconds
      begin
      end;
    2: // Minutes
      begin
        result := result * 60;
      end;
    3: // Hours
      begin
        result := result * 60 * 60;
      end;
    4: // Days
      begin
        result := result * 60 * 60 * 24;
      end;
    5: // Years
      begin
        result := result * 60 * 60 * 24 * 365.25;
      end;
  else
    Assert(False);
  end;
end;

{ TSfrParamInstance }

procedure TSfrParamInstance.Assign(Source: TPersistent);
var
  AnotherItem: TSfrParamInstance;
begin
  // if Assign is updated, update IsSame too.
  AnotherItem := Source as TSfrParamInstance;
  StartTime := AnotherItem.StartTime;
  EndTime := AnotherItem.EndTime;
  ParameterName := AnotherItem.ParameterName;
  ParameterInstance := AnotherItem.ParameterInstance;
  inherited;

end;

function TSfrParamInstance.IsSame(AnotherItem: TOrderedItem): boolean;
var
  Item: TSfrParamInstance;
begin
  result := (AnotherItem is TSfrParamInstance);
  if result then
  begin
    Item := TSfrParamInstance(AnotherItem);
    result :=
      (StartTime = Item.StartTime) and
      (EndTime = Item.EndTime) and
      (ParameterName = Item.ParameterName) and
      (ParameterInstance = Item.ParameterInstance);
  end;
end;

procedure TSfrParamInstance.SetEndTime(const Value: double);
begin
  if FEndTime <> Value then
  begin
    InvalidateModel;
    FEndTime := Value;
  end;
end;

procedure TSfrParamInstance.SetParameterInstance(const Value: string);
var
  LocalModel: TCustomModel;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  ParamIndex: Integer;
  Item: TSfrParamIcalcItem;
begin
  if FParameterInstance <> Value then
  begin
    InvalidateModel;
    LocalModel := (Collection as TOrderedCollection).Model as TCustomModel;
    if LocalModel <> nil then
    begin
      for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
      begin
        ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
        if ScreenObject.ModflowSfrBoundary <> nil then
        begin
          for ParamIndex := 0 to ScreenObject.ModflowSfrBoundary.ParamIcalc.Count - 1 do
          begin
            Item := ScreenObject.ModflowSfrBoundary.ParamIcalc.Items[ParamIndex];
            if (Item.Param = FParameterName)
              and (Item.ParamInstance = FParameterInstance) then
            begin
              Item.ParamInstance := Value;
            end;
          end;
        end;
      end;
    end;
    FParameterInstance := Value;
  end;
end;

procedure TSfrParamInstance.SetParameterName(const Value: string);
var
  LocalModel: TCustomModel;
  ScreenObjectIndex: integer;
  ScreenObject: TScreenObject;
  ParamIndex: Integer;
  Item: TSfrParamIcalcItem;
  NewName: string;
begin
  NewName := CorrectParamName(Value);
  if FParameterName <> NewName then
  begin
    InvalidateModel;
    LocalModel := (Collection as TOrderedCollection).Model as TCustomModel;
    if LocalModel <> nil then
    begin
      for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
      begin
        ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
        if ScreenObject.ModflowSfrBoundary <> nil then
        begin
          for ParamIndex := 0 to ScreenObject.ModflowSfrBoundary.ParamIcalc.Count - 1 do
          begin
            Item := ScreenObject.ModflowSfrBoundary.ParamIcalc.Items[ParamIndex];
            if Item.Param = FParameterName then
            begin
              Item.Param := NewName;
            end;
          end;
        end;
      end;
    end;
    FParameterName := NewName;
  end;
end;

procedure TSfrParamInstance.SetStartTime(const Value: double);
begin
  if FStartTime <> Value then
  begin
    InvalidateModel;
    FStartTime := Value;
  end;
end;

{ TSfrParamInstances }

constructor TSfrParamInstances.Create(Model: TBaseModel);
begin
  inherited Create(TSfrParamInstance, Model);
end;

procedure TSfrParamInstances.DeleteInstancesOfParameter(
  const ParamName: string);
var
  Index: Integer;
begin
  for Index := Count - 1 downto 0 do
  begin
    if Items[Index].ParameterName = ParamName then
    begin
      Delete(Index);
    end;
  end;
end;

function TSfrParamInstances.GetItems(Index: integer): TSfrParamInstance;
begin
  result := inherited Items[Index] as TSfrParamInstance
end;

function TSfrParamInstances.ParameterInstanceExists(const ParamName,
  InstaName: string): boolean;
var
  Index: Integer;
  Item: TSfrParamInstance;
begin
  result := False;
  for Index := 0 to Count - 1 do
  begin
    Item := Items[Index];
    if (Item.ParameterName = ParamName) and (Item.ParameterInstance = InstaName) then
    begin
      result := True;
      Exit;
    end;
  end;
end;

procedure TSfrParamInstances.SetItems(Index: integer;
  const Value: TSfrParamInstance);
begin
  inherited Items[Index] := Value;
end;

procedure TSfrParamInstances.UpdateParamName(const OldParamName,
  NewParamName: string);
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
  begin
    if Items[Index].ParameterName = OldParamName then
    begin
      Items[Index].ParameterName := NewParamName;
    end;
  end;
end;

procedure TCustomLayerPackageSelection.Assign(Source: TPersistent);
var
  LayerSource: TCustomLayerPackageSelection;
begin
  if Source is TCustomLayerPackageSelection then
  begin
    LayerSource := TCustomLayerPackageSelection(Source);
    LayerOption := LayerSource.LayerOption;
  end;
  inherited;
end;

constructor TCustomLayerPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FLayerOption := loTop;
end;

procedure TCustomLayerPackageSelection.SetLayerOption(const Value: TLayerOption);
begin
  if FLayerOption <> Value then
  begin
    InvalidateModel;
    FLayerOption := Value;
    if Assigned(OnLayerChoiceChange) then
    begin
      OnLayerChoiceChange(self);
    end;
  end;
end;

{ TUzfPackageSelection }

procedure TUzfPackageSelection.Assign(Source: TPersistent);
var
  UZF: TUzfPackageSelection;
begin
  if Source is TUzfPackageSelection then
  begin
    UZF := TUzfPackageSelection(Source);
    VerticalKSource := UZF.VerticalKSource;
    RouteDischargeToStreams := UZF.RouteDischargeToStreams;
    SimulateET := UZF.SimulateET;
    NumberOfTrailingWaves := UZF.NumberOfTrailingWaves;
    NumberOfWaveSets := UZF.NumberOfWaveSets;
    PrintSummary := UZF.PrintSummary;
    DepthOfUndulations := UZF.DepthOfUndulations;
    AssignmentMethod := UZF.AssignmentMethod;
    SpecifyResidualWaterContent := UZF.SpecifyResidualWaterContent;
    SpecifyInitialWaterContent := UZF.SpecifyInitialWaterContent;
    CalulateSurfaceLeakage := UZF.CalulateSurfaceLeakage;

    SurfaceKUsedToCalculateRejection := UZF.SurfaceKUsedToCalculateRejection;
    SurfaceKUsedToCalculateSeepage := UZF.SurfaceKUsedToCalculateSeepage;
    ETSmoothed := UZF.ETSmoothed;
    StoredSmoothFactor := UZF.StoredSmoothFactor;
    WriteRechargeAndDischarge := UZF.WriteRechargeAndDischarge;

  end;
  inherited;
end;

constructor TUzfPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FStoredSmoothFactor := TRealStorage.Create;
  FStoredSmoothFactor.OnChange := OnValueChanged;

  InitializeVariables;

  if Model <> nil then
  begin
    FMfUzfInfiltration := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfUzfInfiltration.OnInitialize := InitializeUzfDisplay;
    FMfUzfInfiltration.OnGetUseList := GetMfUzfInfiltrationUseList;
    FMfUzfInfiltration.OnTimeListUsed := PackageUsed;
    FMfUzfInfiltration.Name := StrUzfInfiltrationRate;
    AddTimeList(FMfUzfInfiltration);

    FMfUzfExtinctionDepth := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfUzfExtinctionDepth.OnInitialize := InitializeUzfDisplay;
    FMfUzfExtinctionDepth.OnGetUseList := GetMfUzfExtinctionDepthUseList;
    FMfUzfExtinctionDepth.OnTimeListUsed := ModflowUztEtSimulated;
    FMfUzfExtinctionDepth.Name := StrUzfExtinctionDepth;
    AddTimeList(FMfUzfExtinctionDepth);

    FMfUzfWaterContent := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfUzfWaterContent.OnInitialize := InitializeUzfDisplay;
    FMfUzfWaterContent.OnGetUseList := GetMfUzfWaterContentUseList;
    FMfUzfWaterContent.OnTimeListUsed := ModflowUztEtSimulated;
    FMfUzfWaterContent.Name := StrUzfWaterContent;
    AddTimeList(FMfUzfWaterContent);

    FMfUzfEtDemand := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfUzfEtDemand.OnInitialize := InitializeUzfDisplay;
    FMfUzfEtDemand.OnGetUseList := GetMfUzfEtDemandUseList;
    FMfUzfEtDemand.OnTimeListUsed := ModflowUztEtSimulated;
    FMfUzfEtDemand.Name := StrUzfEtDemand;
    AddTimeList(FMfUzfEtDemand);
  end;

end;

destructor TUzfPackageSelection.Destroy;
begin
  FStoredSmoothFactor.Free;
  FMfUzfInfiltration.Free;
  FMfUzfExtinctionDepth.Free;
  FMfUzfWaterContent.Free;
  FMfUzfEtDemand.Free;
  inherited;
end;

procedure TUzfPackageSelection.GetMfUzfExtinctionDepthUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  Boundary: TUzfBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowUzfBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.ExtinctionDepth.Count -1 do
      begin
        Item := Boundary.ExtinctionDepth[ValueIndex]
          as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TUzfPackageSelection.GetMfUzfInfiltrationUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  Boundary: TUzfBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowUzfBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TUzfPackageSelection.GetMfUzfWaterContentUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  Boundary: TUzfBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowUzfBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.WaterContent.Count -1 do
      begin
        Item := Boundary.WaterContent[ValueIndex] as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

function TUzfPackageSelection.GetSmoothFactor: double;
begin
  result := StoredSmoothFactor.Value;
end;

function TUzfPackageSelection.GetSpecifySurfaceK: Boolean;
begin
  result := SurfaceKUsedToCalculateRejection or SurfaceKUsedToCalculateSeepage;
end;

procedure TUzfPackageSelection.GetMfUzfEtDemandUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  Boundary: TUzfBoundary;
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowUzfBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.EvapotranspirationDemand.Count -1 do
      begin
        Item := Boundary.EvapotranspirationDemand[ValueIndex]
          as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TUzfPackageSelection.InitializeUzfDisplay(Sender: TObject);
var
  UzfWriter: TModflowUzfWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfUzfInfiltration.CreateDataSets;
  if SimulateET then
  begin
    MfUzfEtDemand.CreateDataSets;
    MfUzfExtinctionDepth.CreateDataSets;
    MfUzfWaterContent.CreateDataSets;
  end
  else
  begin
    MfUzfEtDemand.Clear;
    MfUzfEtDemand.SetUpToDate(True);

    MfUzfExtinctionDepth.Clear;
    MfUzfExtinctionDepth.SetUpToDate(True);

    MfUzfWaterContent.Clear;
    MfUzfWaterContent.SetUpToDate(True);
  end;

  List := TModflowBoundListOfTimeLists.Create;
  UzfWriter := TModflowUzfWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfUzfInfiltration);
    if SimulateET then
    begin
      List.Add(MfUzfEtDemand);
      List.Add(MfUzfExtinctionDepth);
      List.Add(MfUzfWaterContent);
    end
    else
    begin
      List.Add(nil);
      List.Add(nil);
      List.Add(nil);
    end;
    UzfWriter.UpdateDisplay(List);
  finally
    UzfWriter.Free;
    List.Free;
  end;
end;

procedure TUzfPackageSelection.InitializeVariables;
begin
  inherited;
  VerticalKSource := 1;
  RouteDischargeToStreams := True;
  SimulateET := True;
  NumberOfTrailingWaves := 15;
  NumberOfWaveSets:= 20;
  FDepthOfUndulations := 1;
  FSpecifyResidualWaterContent := False;
  FSpecifyInitialWaterContent := False;
  FCalulateSurfaceLeakage := True;

  SurfaceKUsedToCalculateRejection := False;
  SurfaceKUsedToCalculateSeepage := False;
  ETSmoothed := False;
  SmoothFactor := 0.1;
  WriteRechargeAndDischarge := False;

end;

procedure TUzfPackageSelection.InvalidateAllTimeLists;
begin
  inherited;
//  if PackageUsed(FModel) then
  begin
    MfUzfInfiltration.Invalidate;
    MfUzfEtDemand.Invalidate;
    MfUzfExtinctionDepth.Invalidate;
    MfUzfWaterContent.Invalidate;
  end;
end;

function TUzfPackageSelection.ModflowUztEtSimulated(Sender: TObject): boolean;
begin
  result := PackageUsed(Sender) and SimulateET;
end;

procedure TUzfPackageSelection.SetAssignmentMethod(const Value: TUpdateMethod);
begin
  if FAssignmentMethod <> Value then
  begin
    FAssignmentMethod := Value;
    InvalidateModel;
    if FModel <> nil then
    begin
      MfUzfInfiltration.Invalidate;
    end;
  end;
end;

procedure TUzfPackageSelection.SetCalulateSurfaceLeakage(const Value: boolean);
begin
  SetBooleanProperty(FCalulateSurfaceLeakage, Value);
end;

procedure TUzfPackageSelection.SetDepthOfUndulations(const Value: double);
begin
  if FDepthOfUndulations <> Value then
  begin
    InvalidateModel;
    FDepthOfUndulations := Value;
  end;
end;

procedure TUzfPackageSelection.SetETSmoothed(const Value: boolean);
begin
  SetBooleanProperty(FETSmoothed, Value);
end;

procedure TUzfPackageSelection.SetNumberOfTrailingWaves(const Value: integer);
begin
  if FNumberOfTrailingWaves <> Value then
  begin
    InvalidateModel;
    FNumberOfTrailingWaves := Value;
  end;
end;

procedure TUzfPackageSelection.SetNumberOfWaveSets(const Value: integer);
begin
  if FNumberOfWaveSets <> Value then
  begin
    InvalidateModel;
    FNumberOfWaveSets := Value;
  end;
end;

procedure TUzfPackageSelection.SetPrintSummary(const Value: integer);
begin
  if FPrintSummary <> Value then
  begin
    InvalidateModel;
    Assert(Value in [0,1]);
    FPrintSummary := Value;
  end;
end;

procedure TUzfPackageSelection.SetRouteDischargeToStreams(const Value: boolean);
begin
  if FRouteDischargeToStreams <> Value then
  begin
    InvalidateModel;
    FRouteDischargeToStreams := Value;
  end;
end;

procedure TUzfPackageSelection.SetSimulateET(const Value: boolean);
begin
  if FSimulateET <> Value then
  begin
    InvalidateModel;
    FSimulateET := Value;
  end;
end;

procedure TUzfPackageSelection.SetSmoothFactor(const Value: double);
begin
  StoredSmoothFactor.Value := Value;
end;

procedure TUzfPackageSelection.SetSpecifyInitialWaterContent(
  const Value: boolean);
begin
  SetBooleanProperty(FSpecifyInitialWaterContent, Value);
end;

procedure TUzfPackageSelection.SetSpecifyResidualWaterContent(
  const Value: boolean);
begin
  SetBooleanProperty(FSpecifyResidualWaterContent, Value);
end;

procedure TUzfPackageSelection.SetStoredSmoothFactor(const Value: TRealStorage);
begin
  FStoredSmoothFactor.Assign(Value);
end;

procedure TUzfPackageSelection.SetSurfaceKUsedToCalculateRejection(
  const Value: boolean);
begin
  SetBooleanProperty(FSurfaceKUsedToCalculateRejection, Value);
end;

procedure TUzfPackageSelection.SetSurfaceKUsedToCalculateSeepage(
  const Value: boolean);
begin
  SetBooleanProperty(FSurfaceKUsedToCalculateSeepage, Value);
end;

procedure TUzfPackageSelection.SetVerticalKSource(const Value: integer);
begin
  if FVerticalKSource <> Value then
  begin
    InvalidateModel;
    FVerticalKSource := Value;
  end;
end;

procedure TUzfPackageSelection.SetWriteRechargeAndDischarge(
  const Value: boolean);
begin
  SetBooleanProperty(FWriteRechargeAndDischarge, Value);
end;

procedure TModflowPackageSelection.DischargeRoutingUpdate;
begin
  if FModel <> nil then
  begin
    (FModel as TCustomModel).DischargeRoutingUpdate;
  end;
end;

{ TGmgPackageSelection }

procedure TGmgPackageSelection.Assign(Source: TPersistent);
var
  SourcePkg: TGmgPackageSelection;
begin
  if Source is TGmgPackageSelection then
  begin
    SourcePkg := TGmgPackageSelection(Source);
    RCLOSE := SourcePkg.RCLOSE;
    IITER := SourcePkg.IITER;
    HCLOSE := SourcePkg.HCLOSE;
    MXITER := SourcePkg.MXITER;
    DAMP := SourcePkg.DAMP;
    IADAMP := SourcePkg.IADAMP;
    IOUTGMG := SourcePkg.IOUTGMG;
    IUNITMHC := SourcePkg.IUNITMHC;
    ISM := SourcePkg.ISM;
    ISC := SourcePkg.ISC;
    DUP := SourcePkg.DUP;
    DLOW := SourcePkg.DLOW;
    CHGLIMIT := SourcePkg.CHGLIMIT;
    RELAX := SourcePkg.RELAX;
  end;
  inherited;
end;

constructor TGmgPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FCHGLIMIT:= TRealStorage.Create;
  FDUP:= TRealStorage.Create;
  FRELAX:= TRealStorage.Create;
  FRCLOSE:= TRealStorage.Create;
  FDLOW:= TRealStorage.Create;
  FDAMP:= TRealStorage.Create;
  FHCLOSE:= TRealStorage.Create;

  FCHGLIMIT.OnChange := OnValueChanged;
  FDUP.OnChange := OnValueChanged;
  FRELAX.OnChange := OnValueChanged;
  FRCLOSE.OnChange := OnValueChanged;
  FDLOW.OnChange := OnValueChanged;
  FDAMP.OnChange := OnValueChanged;
  FHCLOSE.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor TGmgPackageSelection.Destroy;
begin
  FCHGLIMIT.Free;
  FDUP.Free;
  FRELAX.Free;
  FRCLOSE.Free;
  FDLOW.Free;
  FDAMP.Free;
  FHCLOSE.Free;
  inherited;
end;

procedure TGmgPackageSelection.InitializeVariables;
begin
  inherited;
  FRCLOSE.Value := 1E-05;
  FIITER := 100;
  FMXITER := 100;
  FHCLOSE.Value := 1E-05;
  FDAMP.Value := 1;
  FIADAMP := 0;
  FIOUTGMG := 1;
  FISM := 0;
  FISC := 1;
  FDLOW.Value := 0.001;
  FDUP.Value := 0.7;
  FCHGLIMIT.Value := 0.001;
  FRELAX.Value := 1;
  FIUNITMHC := False;
end;

procedure TGmgPackageSelection.SetCHGLIMIT(const Value: TRealStorage);
begin
  if FCHGLIMIT.Value <> Value.Value then
  begin
    FCHGLIMIT.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TGmgPackageSelection.SetDAMP(const Value: TRealStorage);
begin
  if FDAMP.Value <> Value.Value then
  begin
    FDAMP.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TGmgPackageSelection.SetDLOW(const Value: TRealStorage);
begin
  if FDLOW.Value <> Value.Value then
  begin
    FDLOW.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TGmgPackageSelection.SetDUP(const Value: TRealStorage);
begin
  if FDUP.Value <> Value.Value then
  begin
    FDUP.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TGmgPackageSelection.SetHCLOSE(const Value: TRealStorage);
begin
  if FHCLOSE.Value <> Value.Value then
  begin
    FHCLOSE.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TGmgPackageSelection.SetIADAMP(const Value: integer);
begin
  if FIADAMP <> Value then
  begin
    InvalidateModel;
    FIADAMP := Value;
  end;
end;

procedure TGmgPackageSelection.SetIITER(const Value: integer);
begin
  if FIITER <> Value then
  begin
    InvalidateModel;
    FIITER := Value;
  end;
end;

procedure TGmgPackageSelection.SetIOUTGMG(const Value: integer);
begin
  if FIOUTGMG <> Value then
  begin
    InvalidateModel;
    FIOUTGMG := Value;
  end;
end;

procedure TGmgPackageSelection.SetISC(const Value: integer);
begin
  if FISC <> Value then
  begin
    InvalidateModel;
    FISC := Value;
  end;
end;

procedure TGmgPackageSelection.SetISM(const Value: integer);
begin
  if FISM <> Value then
  begin
    InvalidateModel;
    FISM := Value;
  end;
end;

procedure TGmgPackageSelection.SetIUNITMHC(const Value: Boolean);
begin
  if FIUNITMHC <> Value then
  begin
    InvalidateModel;
    FIUNITMHC := Value;
  end;
end;

procedure TGmgPackageSelection.SetMXITER(const Value: integer);
begin
  if FMXITER <> Value then
  begin
    InvalidateModel;
    FMXITER := Value;
  end;
end;

procedure TGmgPackageSelection.SetRCLOSE(const Value: TRealStorage);
begin
  if FRCLOSE.Value <> Value.Value then
  begin
    FRCLOSE.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TGmgPackageSelection.SetRELAX(const Value: TRealStorage);
begin
  if FRELAX.Value <> Value.Value then
  begin
    FRELAX.Assign(Value);
    InvalidateModel;
  end;
end;

{ TSIPPackageSelection }

procedure TSIPPackageSelection.Assign(Source: TPersistent);
var
  SourcePkg: TSIPPackageSelection;
begin
  if Source is TSIPPackageSelection then
  begin
    SourcePkg := TSIPPackageSelection(Source);
    MXITER := SourcePkg.MXITER;
    NPARM := SourcePkg.NPARM;
    ACCL := SourcePkg.ACCL;
    HCLOSE := SourcePkg.HCLOSE;
    IPCALC := SourcePkg.IPCALC;
    WSEED := SourcePkg.WSEED;
    IPRSIP := SourcePkg.IPRSIP;
  end;
  inherited;
end;

constructor TSIPPackageSelection.Create(Model: TBaseModel);
begin
  inherited Create(Model);
  FACCL := TRealStorage.Create;
  FHCLOSE := TRealStorage.Create;
  FWSEED := TRealStorage.Create;

  FACCL.OnChange := OnValueChanged;
  FHCLOSE.OnChange := OnValueChanged;
  FWSEED.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor TSIPPackageSelection.Destroy;
begin
  FACCL.Free;
  FHCLOSE.Free;
  FWSEED.Free;
  inherited;
end;

procedure TSIPPackageSelection.InitializeVariables;
begin
  inherited;
  MXITER := 100;
  NPARM := 5;
  ACCL.Value := 1;
  HCLOSE.Value := 0.001;
  IPCALC := 1;
  WSEED.Value := 9999;
  IPRSIP := 999;
end;

procedure TSIPPackageSelection.SetACCL(const Value: TRealStorage);
begin
  if FACCL.Value <> Value.Value then
  begin
    FACCL.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TSIPPackageSelection.SetHCLOSE(const Value: TRealStorage);
begin
  if FHCLOSE.Value <> Value.Value then
  begin
    FHCLOSE.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TSIPPackageSelection.SetIPCALC(const Value: integer);
begin
  if FIPCALC <> Value then
  begin
    FIPCALC := Value;
    InvalidateModel;
  end;
end;

procedure TSIPPackageSelection.SetIPRSIP(const Value: integer);
begin
  if FIPRSIP <> Value then
  begin
    FIPRSIP := Value;
    InvalidateModel;
  end;
end;

procedure TSIPPackageSelection.SetMXITER(const Value: integer);
begin
  if FMXITER <> Value then
  begin
    FMXITER := Value;
    InvalidateModel;
  end;
end;

procedure TSIPPackageSelection.SetNPARM(const Value: integer);
begin
  if FNPARM <> Value then
  begin
    FNPARM := Value;
    InvalidateModel;
  end;
end;

procedure TSIPPackageSelection.SetWSEED(const Value: TRealStorage);
begin
  if FWSEED.Value <> Value.Value then
  begin
    FWSEED.Assign(Value);
    InvalidateModel;
  end;
end;

{ TDE4PackageSelection }

procedure TDE4PackageSelection.Assign(Source: TPersistent);
var
  SourcePkg: TDE4PackageSelection;
begin
  if Source is TDE4PackageSelection then
  begin
    SourcePkg := TDE4PackageSelection(Source);
    ITMX := SourcePkg.ITMX;
    MXUP := SourcePkg.MXUP;
    MXLOW := SourcePkg.MXLOW;
    MXBW := SourcePkg.MXBW;
    IFREQ := SourcePkg.IFREQ;
    MUTD4 := SourcePkg.MUTD4;
    ACCL := SourcePkg.ACCL;
    HCLOSE := SourcePkg.HCLOSE;
    IPRD4 := SourcePkg.IPRD4;
  end;
  inherited;
end;

constructor TDE4PackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FHCLOSE := TRealStorage.Create;
  FACCL := TRealStorage.Create;

  FHCLOSE.OnChange := OnValueChanged;
  FACCL.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor TDE4PackageSelection.Destroy;
begin
  FHCLOSE.Free;
  FACCL.Free;
  inherited;
end;

procedure TDE4PackageSelection.InitializeVariables;
begin
  inherited;
  ITMX := 5;
  MXUP := 0;
  MXLOW := 0;
  MXBW := 0;
  IFREQ := 3;
  MUTD4 := 0;
  ACCL.Value := 1;
  HCLOSE.Value := 0.001;
  IPRD4 := 1;
end;

procedure TDE4PackageSelection.SetACCL(const Value: TRealStorage);
begin
  if FACCL.Value <> Value.Value then
  begin
    FACCL.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TDE4PackageSelection.SetHCLOSE(const Value: TRealStorage);
begin
  if FHCLOSE.Value <> Value.Value then
  begin
    FHCLOSE.Assign(Value);
    InvalidateModel;
  end;
end;

procedure TDE4PackageSelection.SetIFREQ(const Value: integer);
begin
  if FIFREQ <> Value then
  begin
    FIFREQ := Value;
    InvalidateModel;
  end;
end;

procedure TDE4PackageSelection.SetIPRD4(const Value: integer);
begin
  if FIPRD4 <> Value then
  begin
    FIPRD4 := Value;
    InvalidateModel;
  end;
end;

procedure TDE4PackageSelection.SetITMX(const Value: integer);
begin
  if FITMX <> Value then
  begin
    FITMX := Value;
    InvalidateModel;
  end;
end;

procedure TDE4PackageSelection.SetMUTD4(const Value: integer);
begin
  if FMUTD4 <> Value then
  begin
    FMUTD4 := Value;
    InvalidateModel;
  end;
end;

procedure TDE4PackageSelection.SetMXBW(const Value: integer);
begin
  if FMXBW <> Value then
  begin
    FMXBW := Value;
    InvalidateModel;
  end;
end;

procedure TDE4PackageSelection.SetMXLOW(const Value: integer);
begin
  if FMXLOW <> Value then
  begin
    FMXLOW := Value;
    InvalidateModel;
  end;
end;

procedure TDE4PackageSelection.SetMXUP(const Value: integer);
begin
  if FMXUP <> Value then
  begin
    FMXUP := Value;
    InvalidateModel;
  end;
end;

{ THobPackageSelection }

procedure THobPackageSelection.Assign(Source: TPersistent);
begin
  if Source is THobPackageSelection then
  begin
    DryHead := THobPackageSelection(Source).DryHead;
  end;
  inherited;
end;

constructor THobPackageSelection.Create(Model: TBaseModel);
begin
  inherited Create(Model);
  InitializeVariables;
end;

procedure THobPackageSelection.InitializeVariables;
begin
  inherited;
  FDryHead := -1000000;
end;

procedure THobPackageSelection.SetDryHead(const Value: double);
begin
  if FDryHead <> Value then
  begin
    InvalidateModel;
    FDryHead := Value;
  end;
end;

{ TLpfSelection }

procedure TLpfSelection.Assign(Source: TPersistent);
var
  LpfSource: TLpfSelection;
begin
  if Source is TLpfSelection then
  begin
    LpfSource := TLpfSelection( Source);
    UseConstantCV := LpfSource.UseConstantCV;
    UseSaturatedThickness := LpfSource.UseSaturatedThickness;
    UseCvCorrection := LpfSource.UseCvCorrection;
    UseVerticalFlowCorrection := LpfSource.UseVerticalFlowCorrection;
    UseStorageCoefficient := LpfSource.UseStorageCoefficient;
    NoParCheck := LpfSource.NoParCheck;
  end;
  inherited;
end;

constructor TLpfSelection.Create(Model: TBaseModel);
begin
  inherited;
  InitializeVariables;
end;

destructor TLpfSelection.Destroy;
begin
  inherited;
end;

procedure TLpfSelection.InitializeVariables;
begin
  inherited;
  IsSelected := True;
  FUseCvCorrection := True;
  FUseVerticalFlowCorrection := True;
  FUseSaturatedThickness := False;
  FUseConstantCV := False;
  FUseStorageCoefficient := False;
  FNoParCheck := False;
end;

procedure TLpfSelection.SetNoParCheck(const Value: Boolean);
begin
  if FNoParCheck <> Value then
  begin
    InvalidateModel;
    FNoParCheck := Value;
  end;
end;

procedure TLpfSelection.SetUseConstantCV(const Value: boolean);
begin
  if FUseConstantCV <> Value then
  begin
    InvalidateModel;
    FUseConstantCV := Value;
  end;
end;

procedure TLpfSelection.SetUseCvCorrection(const Value: boolean);
begin
  if FUseCvCorrection <> Value then
  begin
    InvalidateModel;
    FUseCvCorrection := Value;
  end;
end;

procedure TLpfSelection.SetUseSaturatedThickness(const Value: boolean);
begin
  if FUseSaturatedThickness <> Value then
  begin
    InvalidateModel;
    FUseSaturatedThickness := Value;
  end;
end;

procedure TLpfSelection.SetUseStorageCoefficient(const Value: boolean);
begin
  if FUseStorageCoefficient <> Value then
  begin
    InvalidateModel;
    FUseStorageCoefficient := Value;
  end;
end;

procedure TLpfSelection.SetUseVerticalFlowCorrection(const Value: boolean);
begin
  if FUseVerticalFlowCorrection <> Value then
  begin
    InvalidateModel;
    FUseVerticalFlowCorrection := Value;
  end;
end;

{ TModpathSelection }

procedure TModpathSelection.Assign(Source: TPersistent);
var
  ModpathSource: TModpathSelection;
begin
  if Source is TModpathSelection then
  begin
    ModpathSource := TModpathSelection(Source);
    MaximumSize := ModpathSource.MaximumSize;
    EVT_Sink := ModpathSource.EVT_Sink;
    RCH_Source := ModpathSource.RCH_Source;
    Compact := ModpathSource.Compact;
    Binary := ModpathSource.Binary;
    BeginningTime := ModpathSource.BeginningTime;
    EndingTime := ModpathSource.EndingTime;
    ReferenceTime := ModpathSource.ReferenceTime;
    OutputMode := ModpathSource.OutputMode;
    OutputTimes := ModpathSource.OutputTimes;

    StopAfterMaxTime := ModpathSource.StopAfterMaxTime;
    MaxTime := ModpathSource.MaxTime;
    TrackingDirection := ModpathSource.TrackingDirection;
    WeakSink := ModpathSource.WeakSink;
    WeakSinkThreshold := ModpathSource.WeakSinkThreshold;
    StopInZone := ModpathSource.StopInZone;
    StopZoneNumber := ModpathSource.StopZoneNumber;
    EndpointWrite := ModpathSource.EndpointWrite;
    ComputeBudgetInAllCells := ModpathSource.ComputeBudgetInAllCells;
    ErrorTolerance := ModpathSource.ErrorTolerance;
    Summarize := ModpathSource.Summarize;
    MakeBigBudgetFile := ModpathSource.MakeBigBudgetFile;

    TimeSeriesMethod := ModpathSource.TimeSeriesMethod;
    TimeSeriesInterval := ModpathSource.TimeSeriesInterval;
    TimeSeriesMaxCount := ModpathSource.TimeSeriesMaxCount;
    BackwardsTrackingReleaseTime := ModpathSource.BackwardsTrackingReleaseTime;

    // MPATH 6.
    WeakSource := ModpathSource.WeakSource;
    StopOption := ModpathSource.StopOption;
    BudgetChecking := ModpathSource.BudgetChecking;
    RetardationOption := ModpathSource.RetardationOption;
    AdvectiveObservations := ModpathSource.AdvectiveObservations;
    MpathVersion := ModpathSource.MpathVersion;
    StopTime := ModpathSource.StopTime;
    TraceID := ModpathSource.TraceID;

    Ets_Sink := ModpathSource.Ets_Sink;
    Uzf_Source := ModpathSource.Uzf_Source;
    Mnw2_Source := ModpathSource.Mnw2_Source;
    Res_Source := ModpathSource.Res_Source;
    Sfr_Source := ModpathSource.Sfr_Source;
    Lak_Source := ModpathSource.Lak_Source;

  end;
  inherited;
end;

constructor TModpathSelection.Create(Model: TBaseModel);
begin
  inherited;
  FOutputTimes := TModpathTimes.Create(Model);
  InitializeVariables;
end;

destructor TModpathSelection.Destroy;
begin
  FOutputTimes.Free;
  inherited;
end;

procedure TModpathSelection.InitializeVariables;
begin
  inherited;
  FMaximumSize := 0;
  FRCH_Source := sapVertical;
  FEVT_Sink := sapVertical;
  FCompact := False;
  FBinary := False;
  FBeginningTime := 0;
  FEndingTime := 0;
  FReferenceTime := 0;
  FOutputMode := mopEndpoints;
  FOutputTimes.Clear;
  FStopAfterMaxTime := False;
  FMaxTime := 0;
  FTrackingDirection := tdForward;
  FWeakSink := wsPassThrough;
  FWeakSource := wsPassThrough;
  FWeakSinkThreshold := 0;
  FStopInZone := False;
  FStopZoneNumber := 0;
  FEndpointWrite := ewAll;
  FComputeBudgetInAllCells := False;
  FErrorTolerance := 0;
  FSummarize := False;
  FMakeBigBudgetFile := True;
  FTimeSeriesMethod := tsmUniform;
  FTimeSeriesInterval := 1;
  FTimeSeriesMaxCount := 0;
  FBackwardsTrackingReleaseTime := 0;
  FStopOption := soModelEnd;
  FBudgetChecking := bcNone;
  FRetardationOption := roNone;
  FAdvectiveObservations := aoNone;
  FMpathVersion := mp6;
  FStopTime := 0;
  FTraceID := 1;

  FEts_Sink := sapVertical;
  FUzf_Source := sapVertical;
  FMnw2_Source := sapInternal;
  FRes_Source := sapVertical;
  FSfr_Source := sapVertical;
  FLak_Source := sapVertical;
end;

procedure TModpathSelection.SetAdvectiveObservations(
  const Value: TAdvectiveObservations);
begin
  if FAdvectiveObservations <> Value then
  begin
    InvalidateModel;
    FAdvectiveObservations := Value;
  end;
end;

procedure TModpathSelection.SetBackwardsTrackingReleaseTime(
  const Value: double);
begin
  if FBackwardsTrackingReleaseTime <> Value then
  begin
    InvalidateModel;
    FBackwardsTrackingReleaseTime := Value;
  end;
end;

procedure TModpathSelection.SetBeginningTime(const Value: Real);
begin
  if FBeginningTime <> Value then
  begin
    InvalidateModel;
    FBeginningTime := Value;
  end;
end;

procedure TModpathSelection.SetBinary(const Value: boolean);
begin
  if FBinary <> Value then
  begin
    InvalidateModel;
    FBinary := Value;
  end;
end;

procedure TModpathSelection.SetBudgetChecking(const Value: TBudgetChecking);
begin
  if FBudgetChecking <> Value then
  begin
    InvalidateModel;
    FBudgetChecking := Value;
  end;
end;

procedure TModpathSelection.SetCompact(const Value: boolean);
begin
  if FCompact <> Value then
  begin
    InvalidateModel;
    FCompact := Value;
  end;
end;

procedure TModpathSelection.SetComputeBudgetInAllCells(const Value: boolean);
begin
  if FComputeBudgetInAllCells <> Value then
  begin
    InvalidateModel;
    FComputeBudgetInAllCells := Value;
  end;
end;

procedure TModpathSelection.SetEndingTime(const Value: Real);
begin
  if FEndingTime <> Value then
  begin
    InvalidateModel;
    FEndingTime := Value;
  end;
end;

procedure TModpathSelection.SetEndpointWrite(const Value: TEndpointWrite);
begin
  if FEndpointWrite <> Value then
  begin
    InvalidateModel;
    FEndpointWrite := Value;
  end;
end;

procedure TModpathSelection.SetErrorTolerance(const Value: real);
begin
  if FErrorTolerance <> Value then
  begin
    InvalidateModel;
    FErrorTolerance := Value;
  end;
end;

procedure TModpathSelection.SetEts_Sink(
  const Value: TSurfaceApplicationPosition);
begin
  if FEts_Sink <> Value then
  begin
    InvalidateModel;
    FEts_Sink := Value;
  end;
end;

procedure TModpathSelection.SetEVT_Sink(
  const Value: TSurfaceApplicationPosition);
begin
  if FEVT_Sink <> Value then
  begin
    InvalidateModel;
    FEVT_Sink := Value;
  end;
end;

procedure TModpathSelection.SetIsSelected(const Value: boolean);
begin
  inherited;
  if FModel <> nil then
  begin
    (FModel as TCustomModel).DataArrayManager.UpdateClassifications;
  end;
end;

procedure TModpathSelection.SetLak_Source(
  const Value: TSurfaceApplicationPosition);
begin
  if FLak_Source <> Value then
  begin
    InvalidateModel;
    FLak_Source := Value;
  end;
end;

procedure TModpathSelection.SetMakeBigBudgetFile(const Value: boolean);
begin
  if FMakeBigBudgetFile <> Value then
  begin
    InvalidateModel;
    FMakeBigBudgetFile := Value;
  end;
end;

procedure TModpathSelection.SetMaximumSize(const Value: integer);
begin
  if FMaximumSize <> Value then
  begin
    InvalidateModel;
    FMaximumSize := Value;
  end;
end;

procedure TModpathSelection.SetMaxTime(const Value: real);
begin
  if FMaxTime <> Value then
  begin
    InvalidateModel;
    FMaxTime := Value;
  end;
end;

procedure TModpathSelection.SetMnw2_Source(
  const Value: TSurfaceApplicationPosition);
begin
  if FMnw2_Source <> Value then
  begin
    InvalidateModel;
    FMnw2_Source := Value;
  end;
end;

procedure TModpathSelection.SetMpathVersion(const Value: TMpathVersion);
begin
  if FMpathVersion <> Value then
  begin
    InvalidateModel;
    FMpathVersion := Value;
  end;
end;

procedure TModpathSelection.SetOutputMode(const Value: TModpathOutputMode);
begin
  if FOutputMode <> Value then
  begin
    InvalidateModel;
    FOutputMode := Value;
  end;
end;

procedure TModpathSelection.SetOutputTimes(const Value: TModpathTimes);
begin
  FOutputTimes.Assign(Value);
end;

procedure TModpathSelection.SetRCH_Source(
  const Value: TSurfaceApplicationPosition);
begin
  if FRCH_Source <> Value then
  begin
    InvalidateModel;
    FRCH_Source := Value;
  end;
end;

procedure TModpathSelection.SetReferenceTime(const Value: real);
begin
  if FReferenceTime <> Value then
  begin
    InvalidateModel;
    FReferenceTime := Value;
  end;
end;

procedure TModpathSelection.SetRes_Source(
  const Value: TSurfaceApplicationPosition);
begin
  if FRes_Source <> Value then
  begin
    InvalidateModel;
    FRes_Source := Value;
  end;
end;

procedure TModpathSelection.SetRetardationOption(
  const Value: TRetardationOption);
begin
  if FRetardationOption <> Value then
  begin
    InvalidateModel;
    FRetardationOption := Value;
  end;
end;

procedure TModpathSelection.SetSfr_Source(
  const Value: TSurfaceApplicationPosition);
begin
  if FSfr_Source <> Value then
  begin
    InvalidateModel;
    FSfr_Source := Value;
  end;
end;

procedure TModpathSelection.SetStopAfterMaxTime(const Value: boolean);
begin
  if FStopAfterMaxTime <> Value then
  begin
    InvalidateModel;
    FStopAfterMaxTime := Value;
  end;
end;

procedure TModpathSelection.SetStopInZone(const Value: boolean);
begin
  if FStopInZone <> Value then
  begin
    InvalidateModel;
    FStopInZone := Value;
  end;
end;

procedure TModpathSelection.SetStopOption(const Value: TStopOption);
begin
  if FStopOption <> Value then
  begin
    InvalidateModel;
    FStopOption := Value;
  end;
end;

procedure TModpathSelection.SetStopTime(const Value: real);
begin
  SetRealProperty(FStopTime, Value);
end;

procedure TModpathSelection.SetStopZoneNumber(const Value: integer);
begin
  if FStopZoneNumber <> Value then
  begin
    InvalidateModel;
    FStopZoneNumber := Value;
  end;
end;

procedure TModpathSelection.SetSummarize(const Value: boolean);
begin
  if FSummarize <> Value then
  begin
    InvalidateModel;
    FSummarize := Value;
  end;
end;

procedure TModpathSelection.SetTimeSeriesInterval(const Value: double);
begin
  if FTimeSeriesInterval <> Value then
  begin
    InvalidateModel;
    FTimeSeriesInterval := Value;
  end;
end;

procedure TModpathSelection.SetTimeSeriesMaxCount(const Value: integer);
begin
  if FTimeSeriesMaxCount <> Value then
  begin
    InvalidateModel;
    FTimeSeriesMaxCount := Value;
  end;
end;

procedure TModpathSelection.SetTimeSeriesMethod(const Value: TTimeSeriesMethod);
begin
  if FTimeSeriesMethod <> Value then
  begin
    InvalidateModel;
    FTimeSeriesMethod := Value;
  end;
end;

procedure TModpathSelection.SetTraceID(const Value: Integer);
begin
  SetIntegerProperty(FTraceID, Value);
end;

procedure TModpathSelection.SetTrackingDirection(
  const Value: TTrackingDirection);
begin
  if FTrackingDirection <> Value then
  begin
    InvalidateModel;
    FTrackingDirection := Value;
  end;
end;

procedure TModpathSelection.SetUzf_Source(
  const Value: TSurfaceApplicationPosition);
begin
  if FUzf_Source <> Value then
  begin
    InvalidateModel;
    FUzf_Source := Value;
  end;
end;

procedure TModpathSelection.SetWeakSink(const Value: TWeakSink);
begin
  if FWeakSink <> Value then
  begin
    InvalidateModel;
    FWeakSink := Value;
  end;
end;

procedure TModpathSelection.SetWeakSinkThreshold(const Value: real);
begin
  if FWeakSinkThreshold <> Value then
  begin
    InvalidateModel;
    FWeakSinkThreshold := Value;
  end;
end;

procedure TModpathSelection.SetWeakSource(const Value: TWeakSink);
begin
  if FWeakSource <> Value then
  begin
    InvalidateModel;
    FWeakSource := Value;
  end;
end;

function TModpathSelection.ShouldCreateTimeFile: boolean;
begin
  result := (OutputMode in [mopPathline,mopTimeSeries])
      and (TimeSeriesMethod = tsmIndividual)
      and (OutputTimes.Count > 0)
end;

{ TWellPackage }

procedure TWellPackage.Assign(Source: TPersistent);
var
  WellSource: TWellPackage;
begin
  if Source is TWellPackage then
  begin
    WellSource := TWellPackage(Source);
    PublishedPhiRamp := WellSource.PublishedPhiRamp;
    UseTabFiles := WellSource.UseTabFiles;
  end;
  inherited;

end;

constructor TWellPackage.Create(Model: TBaseModel);
begin
  inherited;
  FPublishedPhiRamp := TRealStorage.Create;
  FPublishedPhiRamp.OnChange := OnValueChanged;
  if Model <> nil then
  begin
    FMfWellPumpage := TModflowBoundaryDisplayTimeList.Create(Model);
    MfWellPumpage.OnInitialize := InitializeMfWellPumpage;
    MfWellPumpage.OnGetUseList := GetMfWellUseList;
    MfWellPumpage.OnTimeListUsed := PackageUsed;
    MfWellPumpage.Name := StrMODFLOWWellPumping;
    AddTimeList(MfWellPumpage);
  end;
  InitializeVariables;
end;

destructor TWellPackage.Destroy;
begin
  FMfWellPumpage.Free;
  FPublishedPhiRamp.Free;
  inherited;
end;

function TSfrPackageSelection.GetLossFactor: double;
begin
  result := StoredLossFactor.Value;
end;

procedure TWellPackage.GetMfWellUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptQ, 0, StrWellPumpingRate);
end;

function TWellPackage.GetPhiRamp: Double;
begin
  result := FPublishedPhiRamp.Value;
end;

procedure TWellPackage.InitializeMfWellPumpage(Sender: TObject);
var
  WellWriter: TModflowWEL_Writer;
  List: TModflowBoundListOfTimeLists;
begin
  MfWellPumpage.CreateDataSets;
  List := TModflowBoundListOfTimeLists.Create;
  WellWriter := TModflowWEL_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfWellPumpage);
    WellWriter.UpdateDisplay(List, [0]);
  finally
    WellWriter.Free;
    List.Free;
  end;
  MfWellPumpage.LabelAsSum;
end;

procedure TWellPackage.InitializeVariables;
begin
  PhiRamp := 1e-6;
  UseTabFiles := False;
  inherited;
end;

procedure TWellPackage.InvalidateAllTimeLists;
begin
  inherited;
//  if PackageUsed(FModel) then
  begin
    InvalidateMfWellPumpage(FModel);
  end;
end;

procedure TWellPackage.InvalidateMfWellPumpage(Sender: TObject);
begin
  MfWellPumpage.Invalidate;
end;

procedure TSfrPackageSelection.SetStoredLossFactor(const Value: TRealStorage);
begin
  FStoredLossFactor.Assign(Value);
end;

procedure TWellPackage.SetUseTabFiles(const Value: boolean);
begin
  SetBooleanProperty(FUseTabFiles, Value);
end;

function TWellPackage.UseTabFilesInThisModel: boolean;
begin
  result := UseTabFiles and ((FModel as TCustomModel).NWT_Format = nf1_1)
end;

procedure TSfrPackageSelection.SetLossFactor(const Value: double);
begin
  StoredLossFactor.Value := Value;
end;

procedure TSfrPackageSelection.SetLossFactorOption(const Value: boolean);
begin
  SetBooleanProperty(FLossFactorOption, Value);
end;

procedure TWellPackage.SetPhiRamp(const Value: Double);
begin
  FPublishedPhiRamp.Value := Value;
end;

procedure TWellPackage.SetPublishedPhiRamp(const Value: TRealStorage);
begin
  FPublishedPhiRamp.Assign(Value);
end;

{ TGhbPackage }

constructor TGhbPackage.Create(Model: TBaseModel);
begin
  inherited;
  if Model <> nil then
  begin
    FMfGhbConductance := TModflowBoundaryDisplayTimeList.Create(FModel);
    MfGhbConductance.OnInitialize := InitializeGhbDisplay;
    MfGhbConductance.OnGetUseList := GetMfGhbConductanceUseList;
    MfGhbConductance.OnTimeListUsed := PackageUsed;
    MfGhbConductance.Name := StrMODFLOWGhbConductance;
    AddTimeList(MfGhbConductance);

    FMfGhbBoundaryHead := TModflowBoundaryDisplayTimeList.Create(FModel);
    MfGhbBoundaryHead.OnInitialize := InitializeGhbDisplay;
    MfGhbBoundaryHead.OnGetUseList := GetMfGhbBoundaryHeadUseList;
    MfGhbBoundaryHead.OnTimeListUsed := PackageUsed;
    MfGhbBoundaryHead.Name := StrMODFLOWGhbHead;
    AddTimeList(MfGhbBoundaryHead);
  end;
end;

destructor TGhbPackage.Destroy;
begin
  FMfGhbConductance.Free;
  FMfGhbBoundaryHead.Free;
  inherited;
end;

procedure TGhbPackage.GetMfGhbBoundaryHeadUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptGHB, 0, StrGHBBoundaryHead);
end;

procedure TGhbPackage.GetMfGhbConductanceUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptGHB, 1, StrGHBConductance);
end;

procedure TGhbPackage.InitializeGhbDisplay(Sender: TObject);
var
  GhbWriter: TModflowGHB_Writer;
  List: TModflowBoundListOfTimeLists;
begin
  MfGhbConductance.CreateDataSets;
  MfGhbBoundaryHead.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  GhbWriter := TModflowGHB_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfGhbBoundaryHead);
    List.Add(MfGhbConductance);
    GhbWriter.UpdateDisplay(List, [1]);
  finally
    GhbWriter.Free;
    List.Free;
  end;
  MfGhbConductance.ComputeAverage;
  MfGhbBoundaryHead.ComputeAverage;
end;

procedure TGhbPackage.InvalidateAllTimeLists;
begin
//  if PackageUsed(FModel) then
  begin
    MfGhbBoundaryHead.Invalidate;
    MfGhbConductance.Invalidate;
  end;
end;

{ TDrnPackage }

constructor TDrnPackage.Create(Model: TBaseModel);
begin
  inherited;
  if Model <> nil then
  begin
    FMfDrnConductance := TModflowBoundaryDisplayTimeList.Create(Model);
    MfDrnConductance.OnInitialize := InitializeDrnDisplay;
    MfDrnConductance.OnGetUseList := GetMfDrnConductanceUseList;
    MfDrnConductance.OnTimeListUsed := PackageUsed;
    MfDrnConductance.Name := StrMODFLOWDrainConductance;
    AddTimeList(MfDrnConductance);

    FMfDrnElevation := TModflowBoundaryDisplayTimeList.Create(Model);
    MfDrnElevation.OnInitialize := InitializeDrnDisplay;
    MfDrnElevation.OnGetUseList := GetMfDrnElevationUseList;
    MfDrnElevation.OnTimeListUsed := PackageUsed;
    MfDrnElevation.Name := StrMODFLOWDrainElevation;
    AddTimeList(MfDrnElevation);
  end;
end;

destructor TDrnPackage.Destroy;
begin
  FMfDrnConductance.Free;
  FMfDrnElevation.Free;
  inherited;
end;

procedure TDrnPackage.GetMfDrnConductanceUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptDRN, 1, StrDrainConductance);
end;

procedure TDrnPackage.GetMfDrnElevationUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptDRN, 0, StrDrainElevation);
end;

procedure TDrnPackage.InitializeDrnDisplay(Sender: TObject);
var
  DrnWriter: TModflowDRN_Writer;
  List: TModflowBoundListOfTimeLists;
begin
  MfDrnConductance.CreateDataSets;
  MfDrnElevation.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  DrnWriter := TModflowDRN_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfDrnElevation);
    List.Add(MfDrnConductance);
    DrnWriter.UpdateDisplay(List, [1]);
  finally
    DrnWriter.Free;
    List.Free;
  end;
  MfDrnConductance.ComputeAverage;
  MfDrnElevation.ComputeAverage;
end;

procedure TDrnPackage.InvalidateAllTimeLists;
begin
//  if PackageUsed(FModel) then
  begin
    MfDrnElevation.Invalidate;
    MfDrnConductance.Invalidate;
  end;
end;

{ TDrtPackage }

constructor TDrtPackage.Create(Model: TBaseModel);
begin
  inherited;
  if Model <> nil then
  begin
    FMfDrtConductance := TModflowBoundaryDisplayTimeList.Create(Model);
    MfDrtConductance.OnInitialize := InitializeDrtDisplay;
    MfDrtConductance.OnGetUseList := GetMfDrtConductanceUseList;
    MfDrtConductance.OnTimeListUsed := PackageUsed;
    MfDrtConductance.Name := StrMODFLOWDrainReturnConductance;
    AddTimeList(MfDrtConductance);

    FMfDrtElevation := TModflowBoundaryDisplayTimeList.Create(Model);
    MfDrtElevation.OnInitialize := InitializeDrtDisplay;
    MfDrtElevation.OnGetUseList := GetMfDrtElevationUseList;
    MfDrtElevation.OnTimeListUsed := PackageUsed;
    MfDrtElevation.Name := StrMODFLOWDrainReturnElevation;
    AddTimeList(MfDrtElevation);

    FMfDrtReturnFraction := TModflowBoundaryDisplayTimeList.Create(Model);
    MfDrtReturnFraction.OnInitialize := InitializeDrtDisplay;
    MfDrtReturnFraction.OnGetUseList := GetMfDrtReturnFractionUseList;
    MfDrtReturnFraction.OnTimeListUsed := PackageUsed;
    MfDrtReturnFraction.Name := StrMODFLOWDrainReturnFraction;
    AddTimeList(MfDrtReturnFraction);
  end;
end;

destructor TDrtPackage.Destroy;
begin
  FMfDrtReturnFraction.Free;
  FMfDrtElevation.Free;
  FMfDrtConductance.Free;
  inherited;
end;

procedure TDrtPackage.GetMfDrtConductanceUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptDRT, 1, StrDrainReturnConduct);
end;

procedure TDrtPackage.GetMfDrtElevationUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptDRT, 0, StrDrainReturnElevati);
end;

procedure TDrtPackage.GetMfDrtReturnFractionUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptDRT, 2, StrDrainReturnFractio);
end;

procedure TDrtPackage.InitializeDrtDisplay(Sender: TObject);
var
  DrtWriter: TModflowDRT_Writer;
  List: TModflowBoundListOfTimeLists;
begin
  MfDrtConductance.CreateDataSets;
  MfDrtElevation.CreateDataSets;
  MfDrtReturnFraction.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  DrtWriter := TModflowDRT_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfDrtElevation);
    List.Add(MfDrtConductance);
    List.Add(MfDrtReturnFraction);
    DrtWriter.UpdateDisplay(List, [1]);
  finally
    DrtWriter.Free;
    List.Free;
  end;
  MfDrtConductance.ComputeAverage;
  MfDrtElevation.ComputeAverage;
  MfDrtReturnFraction.ComputeAverage;
end;

procedure TDrtPackage.InvalidateAllTimeLists;
begin
  inherited;
//  if PackageUsed(FModel) then
  begin
    MfDrtConductance.Invalidate;
    MfDrtElevation.Invalidate;
    MfDrtReturnFraction.Invalidate;
  end;
end;

{ TRivPackage }

constructor TRivPackage.Create(Model: TBaseModel);
begin
  inherited;
  if Model <> nil then
  begin
    FMfRivConductance := TModflowBoundaryDisplayTimeList.Create(Model);
    MfRivConductance.OnInitialize := InitializeRivDisplay;
    MfRivConductance.OnGetUseList := GetMfRivConductanceUseList;
    MfRivConductance.OnTimeListUsed := PackageUsed;
    MfRivConductance.Name := StrMODFLOWRiverConductance;
    AddTimeList(MfRivConductance);

    FMfRivStage := TModflowBoundaryDisplayTimeList.Create(Model);
    MfRivStage.OnInitialize := InitializeRivDisplay;
    MfRivStage.OnGetUseList := GetMfRivStageUseList;
    MfRivStage.OnTimeListUsed := PackageUsed;
    MfRivStage.Name := StrMODFLOWRiverStage;
    AddTimeList(MfRivStage);

    FMfRivBottom := TModflowBoundaryDisplayTimeList.Create(Model);
    MfRivBottom.OnInitialize := InitializeRivDisplay;
    MfRivBottom.OnGetUseList := GetMfRivBottomUseList;
    MfRivBottom.OnTimeListUsed := PackageUsed;
    MfRivBottom.Name := StrMODFLOWRiverBottom;
    AddTimeList(MfRivBottom);
  end;
end;

destructor TRivPackage.Destroy;
begin
  FMfRivConductance.Free;
  FMfRivBottom.Free;
  FMfRivStage.Free;
  inherited;
end;

procedure TRivPackage.GetMfRivBottomUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptRIV, 2, StrRiverBottomElevati);
end;

procedure TRivPackage.GetMfRivConductanceUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptRIV, 1, StrRiverConductance);
end;

procedure TRivPackage.GetMfRivStageUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptRIV, 0, StrRiverStage);
end;

procedure TRivPackage.InitializeRivDisplay(Sender: TObject);
var
  RivWriter: TModflowRIV_Writer;
  List: TModflowBoundListOfTimeLists;
begin
  MfRivConductance.CreateDataSets;
  MfRivStage.CreateDataSets;
  MfRivBottom.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  RivWriter := TModflowRIV_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfRivStage);
    List.Add(MfRivConductance);
    List.Add(MfRivBottom);
    RivWriter.UpdateDisplay(List, [1]);
  finally
    RivWriter.Free;
    List.Free;
  end;
  MfRivConductance.ComputeAverage;
  MfRivStage.ComputeAverage;
  MfRivBottom.ComputeAverage;
end;

procedure TRivPackage.InvalidateAllTimeLists;
begin
  inherited;
//  if PackageUsed(FModel) then
  begin
    MfRivConductance.Invalidate;
    MfRivStage.Invalidate;
    MfRivBottom.Invalidate;
  end;
end;

{ TChdPackage }

constructor TChdPackage.Create(Model: TBaseModel);
begin
  inherited;
  if Model <> nil then
  begin
    FMfChdStartingHead := TModflowBoundaryDisplayTimeList.Create(Model);
    MfChdStartingHead.OnInitialize := InitializeChdDisplay;
    MfChdStartingHead.OnGetUseList := GetMfChdStartingHeadUseList;
    MfChdStartingHead.OnTimeListUsed := PackageUsed;
    MfChdStartingHead.Name := StrMODFLOWCHDStartingHead;
    AddTimeList(MfChdStartingHead);

    FMfChdEndingHead := TModflowBoundaryDisplayTimeList.Create(Model);
    MfChdEndingHead.OnInitialize := InitializeChdDisplay;
    MfChdEndingHead.OnGetUseList := GetMfChdEndingHeadUseList;
    MfChdEndingHead.OnTimeListUsed := PackageUsed;
    MfChdEndingHead.Name := StrMODFLOWCHDEndingHead;
    AddTimeList(MfChdEndingHead);
  end;
end;

destructor TChdPackage.Destroy;
begin
  FMfChdStartingHead.Free;
  FMfChdEndingHead.Free;
  inherited;
end;

procedure TChdPackage.GetMfChdEndingHeadUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptCHD, 1, StrCHDEndingHead);
end;

procedure TChdPackage.GetMfChdStartingHeadUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptCHD, 0, StrCHDStartingHead);
end;

procedure TChdPackage.InitializeChdDisplay(Sender: TObject);
var
  ChdWriter: TModflowCHD_Writer;
  List: TModflowBoundListOfTimeLists;
begin
  MfChdStartingHead.CreateDataSets;
  MfChdEndingHead.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  ChdWriter := TModflowCHD_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfChdStartingHead);
    List.Add(MfChdEndingHead);
    ChdWriter.UpdateDisplay(List, [0,1]);
  finally
    ChdWriter.Free;
    List.Free;
  end;
  MfChdStartingHead.LabelAsSum;
  MfChdEndingHead.LabelAsSum;
end;

procedure TChdPackage.InvalidateAllTimeLists;
begin
  inherited;
//  if PackageUsed(FModel) then
  begin
    FMfChdStartingHead.Invalidate;
    FMfChdEndingHead.Invalidate;
  end;
end;

{ THufPackageSelection }

procedure THufPackageSelection.Assign(Source: TPersistent);
var
  HufPkg: THufPackageSelection;
begin
  if Source is THufPackageSelection then
  begin
    HufPkg := THufPackageSelection(Source);
    SaveHeads := HufPkg.SaveHeads;
    SaveFlows := HufPkg.SaveFlows;
    ReferenceChoice := HufPkg.ReferenceChoice;
  end;
  inherited;

end;

constructor THufPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  InitializeVariables;
end;

procedure THufPackageSelection.InitializeVariables;
begin
  inherited;
  FSaveFlows := True;
  FSaveHeads := True;
  FReferenceChoice := hrcModelTop;
end;

procedure THufPackageSelection.SetReferenceChoice(
  const Value: THufReferenceChoice);
begin
  if FReferenceChoice <> Value then
  begin
    InvalidateModel;
    FReferenceChoice := Value;
  end;
end;

procedure THufPackageSelection.SetSaveFlows(const Value: boolean);
begin
  if FSaveFlows <> Value then
  begin
    InvalidateModel;
    FSaveFlows := Value;
  end;
end;

procedure THufPackageSelection.SetSaveHeads(const Value: boolean);
begin
  if FSaveHeads <> Value then
  begin
    InvalidateModel;
    FSaveHeads := Value;
  end;
end;

{ TMultinodeWellSelection }

procedure TMultinodeWellSelection.Assign(Source: TPersistent);
var
  MnwSource: TMultinodeWellSelection;
begin
  if Source is TMultinodeWellSelection then
  begin
    MnwSource := TMultinodeWellSelection(Source);
    PrintOption := MnwSource.PrintOption;
    CreateWellFile := MnwSource.CreateWellFile;
    SummarizeByWell := MnwSource.SummarizeByWell;
    SummarizeByNode := MnwSource.SummarizeByNode;
  end;
  inherited;
end;

constructor TMultinodeWellSelection.Create(Model: TBaseModel);
begin
  inherited;
  FPrintOption := mpoMost;

  if Model <> nil then
  begin
    FMfMnwWellRadius := TModflowBoundaryDisplayTimeList.Create(Model);
    MfMnwWellRadius.OnInitialize := InitializeMnw2Display;
    MfMnwWellRadius.OnGetUseList := GetMfMnwWellRadiusUseList;
    MfMnwWellRadius.OnTimeListUsed := PackageUsed;
    MfMnwWellRadius.Name := StrWellRadius;
    AddTimeList(MfMnwWellRadius);

    FMfMnwSkinRadius := TModflowBoundaryDisplayTimeList.Create(Model);
    MfMnwSkinRadius.OnInitialize := InitializeMnw2Display;
    MfMnwSkinRadius.OnGetUseList := GetMfMnwSkinRadiusUseList;
    MfMnwSkinRadius.OnTimeListUsed := PackageUsed;
    MfMnwSkinRadius.Name := StrSkinRadius;
    AddTimeList(MfMnwSkinRadius);

    FMfMnwSkinK := TModflowBoundaryDisplayTimeList.Create(Model);
    MfMnwSkinK.OnInitialize := InitializeMnw2Display;
    MfMnwSkinK.OnGetUseList := GetMfMnwSkinKUseList;
    MfMnwSkinK.OnTimeListUsed := PackageUsed;
    MfMnwSkinK.Name := StrSkinK;
    AddTimeList(MfMnwSkinK);

    FMfMnwB := TModflowBoundaryDisplayTimeList.Create(Model);
    MfMnwB.OnInitialize := InitializeMnw2Display;
    MfMnwB.OnGetUseList := GetMfMnwBUseList;
    MfMnwB.OnTimeListUsed := PackageUsed;
    MfMnwB.Name := StrB;
    AddTimeList(MfMnwB);

    FMfMnwC := TModflowBoundaryDisplayTimeList.Create(Model);
    MfMnwC.OnInitialize := InitializeMnw2Display;
    MfMnwC.OnGetUseList := GetMfMnwCUseList;
    MfMnwC.OnTimeListUsed := PackageUsed;
    MfMnwC.Name := StrC;
    AddTimeList(MfMnwC);

    FMfMnwP := TModflowBoundaryDisplayTimeList.Create(Model);
    MfMnwP.OnInitialize := InitializeMnw2Display;
    MfMnwP.OnGetUseList := GetMfMnwPUseList;
    MfMnwP.OnTimeListUsed := PackageUsed;
    MfMnwP.Name := StrP;
    AddTimeList(MfMnwP);

    FMfMnwCellToWellConductance :=
      TModflowBoundaryDisplayTimeList.Create(Model);
    MfMnwCellToWellConductance.OnInitialize := InitializeMnw2Display;
    MfMnwCellToWellConductance.OnGetUseList :=
      GetMfMnwCellToWellConductanceUseList;
    MfMnwCellToWellConductance.OnTimeListUsed := PackageUsed;
    MfMnwCellToWellConductance.Name := StrCellToWellConductance;
    AddTimeList(MfMnwCellToWellConductance);

    FMfMnwPartialPenetration := TModflowBoundaryDisplayTimeList.Create(Model);
    MfMnwPartialPenetration.OnInitialize := InitializeMnw2Display;
    MfMnwPartialPenetration.OnGetUseList := GetMfMnwPartialPenetrationUseList;
    MfMnwPartialPenetration.OnTimeListUsed := PackageUsed;
    MfMnwPartialPenetration.Name := StrPartialPenetration;
    AddTimeList(MfMnwPartialPenetration);
  end;

end;

destructor TMultinodeWellSelection.Destroy;
begin
  FMfMnwPartialPenetration.Free;
  FMfMnwCellToWellConductance.Free;
  FMfMnwP.Free;
  FMfMnwC.Free;
  FMfMnwB.Free;
  FMfMnwSkinK.Free;
  FMfMnwSkinRadius.Free;
  FMfMnwWellRadius.Free;
  inherited;
end;

procedure TMultinodeWellSelection.GetMfMnwUseList(
  Sender: TObject; NewUseList: TStringList; DataIndex: integer);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  Boundary: TMnw2Boundary;
  PhastModel: TCustomModel;
begin
  PhastModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to PhastModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := PhastModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowMnw2Boundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      if Boundary.DataTypeUsed(DataIndex) then
      begin
        for ValueIndex := 0 to Boundary.Values.Count -1 do
        begin
          Item := Boundary.Values[ValueIndex] as TCustomModflowBoundaryItem;
          UpdateUseList(DataIndex, NewUseList, Item);
        end;
      end;
    end;
  end;
end;

procedure TMultinodeWellSelection.GetMfMnwWellRadiusUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfMnwUseList(Sender, NewUseList, WellRadiusPosition);
end;

procedure TMultinodeWellSelection.GetMfMnwSkinRadiusUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfMnwUseList(Sender, NewUseList, SkinRadiusPosition);
end;

procedure TMultinodeWellSelection.GetMfMnwSkinKUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfMnwUseList(Sender, NewUseList, SkinKPosition);
end;

procedure TMultinodeWellSelection.GetMfMnwBUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfMnwUseList(Sender, NewUseList, BPosition);
end;

procedure TMultinodeWellSelection.GetMfMnwCUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfMnwUseList(Sender, NewUseList, CPosition);
end;

procedure TMultinodeWellSelection.GetMfMnwPUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfMnwUseList(Sender, NewUseList, PPosition);
end;

procedure TMultinodeWellSelection.GetMfMnwCellToWellConductanceUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfMnwUseList(Sender, NewUseList, CellToWellConductancePosition);
end;

procedure TMultinodeWellSelection.GetMfMnwPartialPenetrationUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  GetMfMnwUseList(Sender, NewUseList, PartialPenetrationPosition);
end;

procedure TMultinodeWellSelection.InitializeMnw2Display(Sender: TObject);
var
  List: TModflowBoundListOfTimeLists;
  Mnw2Writer: TModflowMNW2_Writer;
  Index: Integer;
  TimeList: TModflowBoundaryDisplayTimeList;
begin
  List := TModflowBoundListOfTimeLists.Create;
  Mnw2Writer := TModflowMNW2_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfMnwWellRadius);
    List.Add(MfMnwSkinRadius);
    List.Add(MfMnwSkinK);
    List.Add(MfMnwB);
    List.Add(MfMnwC);
    List.Add(MfMnwP);
    List.Add(MfMnwCellToWellConductance);
    List.Add(MfMnwPartialPenetration);
    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.CreateDataSets;
    end;
    Mnw2Writer.UpdateDisplay(List);
    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.ComputeAverage;
    end;
  finally
    Mnw2Writer.Free;
    List.Free;
  end;
end;

procedure TMultinodeWellSelection.SetCreateWellFile(const Value: Boolean);
begin
  if FCreateWellFile <> Value then
  begin
    FCreateWellFile := Value;
    InvalidateModel;
  end;
end;

procedure TMultinodeWellSelection.SetPrintOption(const Value: TMnw2PrintOption);
begin
  if FPrintOption <> Value then
  begin
    FPrintOption := Value;
    InvalidateModel;
  end;
end;

procedure TMultinodeWellSelection.SetSummarizeByNode(const Value: Boolean);
begin
  if FSummarizeByNode <> Value then
  begin
    FSummarizeByNode := Value;
    InvalidateModel;
  end;
end;

procedure TMultinodeWellSelection.SetSummarizeByWell(const Value: Boolean);
begin
  if FSummarizeByWell <> Value then
  begin
    FSummarizeByWell := Value;
    InvalidateModel;
  end;
end;

{ TSubPrintItem }

procedure TSubPrintItem.Assign(Source: TPersistent);
var
  SourceItem: TSubPrintItem;
begin
  // if Assign is updated, update IsSame too.
  if Source is TSubPrintItem then
  begin
    SourceItem := TSubPrintItem(Source);
    PrintSubsidence := SourceItem.PrintSubsidence;
    SaveSubsidence := SourceItem.SaveSubsidence;
    PrintCompactionByModelLayer := SourceItem.PrintCompactionByModelLayer;
    SaveCompactionByModelLayer := SourceItem.SaveCompactionByModelLayer;
    PrintCompactionByInterbedSystem :=
      SourceItem.PrintCompactionByInterbedSystem;
    SaveCompactionByInterbedSystem :=
      SourceItem.SaveCompactionByInterbedSystem;
    PrintVerticalDisplacement := SourceItem.PrintVerticalDisplacement;
    SaveVerticalDisplacement := SourceItem.SaveVerticalDisplacement;
    PrintCriticalHeadNoDelay := SourceItem.PrintCriticalHeadNoDelay;
    SaveCriticalHeadNoDelay := SourceItem.SaveCriticalHeadNoDelay;
    PrintCriticalHeadDelay := SourceItem.PrintCriticalHeadDelay;
    SaveCriticalHeadDelay := SourceItem.SaveCriticalHeadDelay;
    PrintDelayBudgets := SourceItem.PrintDelayBudgets;
  end;
  inherited;

end;

function TSubPrintItem.IsSame(AnotherItem: TOrderedItem): boolean;
var
  SourceItem: TSubPrintItem;
begin
  if AnotherItem is TSubPrintItem then
  begin
    Result := inherited;
    if Result then
    begin
      SourceItem := TSubPrintItem(AnotherItem);
      result := (PrintSubsidence = SourceItem.PrintSubsidence)
        and (SaveSubsidence = SourceItem.SaveSubsidence)
        and (PrintCompactionByModelLayer = SourceItem.PrintCompactionByModelLayer)
        and (SaveCompactionByModelLayer = SourceItem.SaveCompactionByModelLayer)
        and (PrintCompactionByInterbedSystem = SourceItem.PrintCompactionByInterbedSystem)
        and (SaveCompactionByInterbedSystem = SourceItem.SaveCompactionByInterbedSystem)
        and (PrintVerticalDisplacement = SourceItem.PrintVerticalDisplacement)
        and (SaveVerticalDisplacement = SourceItem.SaveVerticalDisplacement)
        and (PrintCriticalHeadNoDelay = SourceItem.PrintCriticalHeadNoDelay)
        and (SaveCriticalHeadNoDelay = SourceItem.SaveCriticalHeadNoDelay)
        and (PrintCriticalHeadDelay = SourceItem.PrintCriticalHeadDelay)
        and (SaveCriticalHeadDelay = SourceItem.SaveCriticalHeadDelay)
        and (PrintDelayBudgets = SourceItem.PrintDelayBudgets);
    end;
  end
  else
  begin
    result := False;
  end;
end;

procedure TSubPrintItem.SetPrintCompactionByInterbedSystem(
  const Value: boolean);
begin
  SetBooleanProperty(FPrintCompactionByInterbedSystem, Value);
end;

procedure TSubPrintItem.SetPrintCompactionByModelLayer(const Value: boolean);
begin
  SetBooleanProperty(FPrintCompactionByModelLayer, Value);
end;

procedure TSubPrintItem.SetPrintCriticalHeadDelay(const Value: boolean);
begin
  SetBooleanProperty(FPrintCriticalHeadDelay, Value);
end;

procedure TSubPrintItem.SetPrintCriticalHeadNoDelay(const Value: boolean);
begin
  SetBooleanProperty(FPrintCriticalHeadNoDelay, Value);
end;

procedure TSubPrintItem.SetPrintDelayBudgets(const Value: boolean);
begin
  SetBooleanProperty(FPrintDelayBudgets, Value);
end;

procedure TSubPrintItem.SetPrintSubsidence(const Value: boolean);
begin
  SetBooleanProperty(FPrintSubsidence, Value);
end;

procedure TSubPrintItem.SetPrintVerticalDisplacement(const Value: boolean);
begin
  SetBooleanProperty(FPrintVerticalDisplacement, Value);
end;

procedure TSubPrintItem.SetSaveCompactionByInterbedSystem(const Value: boolean);
begin
  SetBooleanProperty(FSaveCompactionByInterbedSystem, Value);
end;

procedure TSubPrintItem.SetSaveCompactionByModelLayer(const Value: boolean);
begin
  SetBooleanProperty(FSaveCompactionByModelLayer, Value);
end;

procedure TSubPrintItem.SetSaveCriticalHeadDelay(const Value: boolean);
begin
  SetBooleanProperty(FSaveCriticalHeadDelay, Value);
end;

procedure TSubPrintItem.SetSaveCriticalHeadNoDelay(const Value: boolean);
begin
  SetBooleanProperty(FSaveCriticalHeadNoDelay, Value);
end;

procedure TSubPrintItem.SetSaveSubsidence(const Value: boolean);
begin
  SetBooleanProperty(FSaveSubsidence, Value);
end;

procedure TSubPrintItem.SetSaveVerticalDisplacement(const Value: boolean);
begin
  SetBooleanProperty(FSaveVerticalDisplacement, Value);
end;

{ TSubPrintCollection }
constructor TSubPrintCollection.Create(Model: TBaseModel);
begin
  inherited Create(TSubPrintItem, Model);
end;

function TSubPrintCollection.GetItem(Index: integer): TSubPrintItem;
begin
  result := inherited Items[Index] as TSubPrintItem;
end;

procedure TSubPrintCollection.ReportErrors;
var
  Index: Integer;
  PrintChoice: TSubPrintItem;
begin
  frmErrorsAndWarnings.RemoveErrorGroup(frmGoPhast.PhastModel,
    StrInTheSubsidencePa);
  for Index := 0 to Count -1 do
  begin
    PrintChoice := Items[Index];
    if PrintChoice.StartTime > PrintChoice.EndTime then
    begin
      frmErrorsAndWarnings.AddError(frmGoPhast.PhastModel, StrInTheSubsidencePa,
        Format(StrStartingTime0g, [PrintChoice.StartTime, PrintChoice.EndTime]));
    end;
  end;
end;

procedure TSubPrintCollection.SetItem(Index: integer;
  const Value: TSubPrintItem);
begin
  inherited Items[Index] := Value;
end;

{ TSubPackageSelection }

procedure TSubPackageSelection.Assign(Source: TPersistent);
var
  SubSource: TSubPackageSelection;
begin
  if Source is TSubPackageSelection then
  begin
    SubSource := TSubPackageSelection(Source);
    PrintFormats := SubSource.PrintFormats;
    PrintChoices := SubSource.PrintChoices;
    NumberOfNodes := SubSource.NumberOfNodes;
    AccelerationParameter1 := SubSource.AccelerationParameter1;
    AccelerationParameter2 := SubSource.AccelerationParameter2;
    MinIterations := SubSource.MinIterations;
    SaveDelayRestart := SubSource.SaveDelayRestart;
    ReadDelayRestartFileName := SubSource.ReadDelayRestartFileName;
    BinaryOutputChoice := SubSource.BinaryOutputChoice;

  end;
  inherited;

end;

constructor TSubPackageSelection.Create(Model: TBaseModel);
var
  OnInvalidate: TNotifyEvent;
begin
  if Model = nil then
  begin
    OnInvalidate := nil;
  end
  else
  begin
    OnInvalidate := Model.Invalidate;
  end;
  inherited;
  FPrintChoices := TSubPrintCollection.Create(Model);
  FPrintFormats := TSubPrintFormats.Create(OnInvalidate);
  InitializeVariables;
end;

destructor TSubPackageSelection.Destroy;
begin
  FPrintFormats.Free;
  FPrintChoices.Free;
  inherited;
end;

procedure TSubPackageSelection.InitializeVariables;
begin
  inherited;
  FNumberOfNodes := 10;
  FAccelerationParameter1 := 0;
  FAccelerationParameter2 := 1;
  FMinIterations := 5;
  FSaveDelayRestart := False;
  FReadDelayRestartFileName := '';
  FSubBinaryOutputChoice := sbocSingleFile;
  PrintFormats.InitializeVariables;
  PrintChoices.Clear;
end;

procedure TSubPackageSelection.SetAccelerationParameter1(const Value: double);
begin
  if FAccelerationParameter1 <> Value then
  begin
    FAccelerationParameter1 := Value;
    InvalidateModel;
  end;
end;

procedure TSubPackageSelection.SetAccelerationParameter2(const Value: double);
begin
  if FAccelerationParameter2 <> Value then
  begin
    FAccelerationParameter2 := Value;
    InvalidateModel;
  end;
end;

procedure TSubPackageSelection.SetMinIterations(const Value: integer);
begin
  if FMinIterations <> Value then
  begin
    FMinIterations := Value;
    InvalidateModel;
  end;
end;

procedure TSubPackageSelection.SetNumberOfNodes(const Value: integer);
begin
  if FNumberOfNodes <> Value then
  begin
    FNumberOfNodes := Value;
    InvalidateModel;
  end;
end;

procedure TSubPackageSelection.SetPrintChoices(
  const Value: TSubPrintCollection);
begin
  FPrintChoices.Assign(Value);
end;

procedure TSubPackageSelection.SetPrintFormats(const Value: TSubPrintFormats);
begin
  FPrintFormats.Assign(Value);
end;

procedure TSubPackageSelection.SetReadDelayRestartFileName(const Value: string);
var
  LayerStructure: TLayerStructure;
  LayerIndex: Integer;
  LayerGroup: TLayerGroup;
  Index: Integer;
  DelayItem: TSubDelayBedLayerItem;
begin
  if FReadDelayRestartFileName <> Value then
  begin
    FReadDelayRestartFileName := Value;
    InvalidateModel;
    if FModel <> nil then
    begin
      // ensure that related data sets have been created.
      LayerStructure := (FModel as TCustomModel).LayerStructure;
      for LayerIndex := 0 to LayerStructure.Count - 1 do
      begin
        LayerGroup := LayerStructure[LayerIndex];
        for Index := 0 to LayerGroup.SubDelayBedLayers.Count - 1 do
        begin
          DelayItem := LayerGroup.SubDelayBedLayers[Index];
          DelayItem.InterbedStartingHeadDataArrayName :=
            DelayItem.InterbedStartingHeadDataArrayName;
          DelayItem.InterbedPreconsolidationHeadDataArrayName :=
            DelayItem.InterbedPreconsolidationHeadDataArrayName;
        end;
      end;
    end;
  end;
end;

procedure TSubPackageSelection.SetSaveDelayRestart(const Value: boolean);
begin
  if FSaveDelayRestart <> Value then
  begin
    FSaveDelayRestart := Value;
    InvalidateModel;
  end;
end;

procedure TSubPackageSelection.SetSubBinaryOutputChoice(
  const Value: TSubBinaryOutputChoice);
begin
  if FSubBinaryOutputChoice <> Value then
  begin
    FSubBinaryOutputChoice := Value;
    InvalidateModel;
  end;
end;

{ TSubPrintFormats }

procedure TSubPrintFormats.Assign(Source: TPersistent);
var
  SubPrintSource: TSubPrintFormats;
begin
  if Source is TSubPrintFormats then
  begin
    SubPrintSource := TSubPrintFormats(Source);
    SubsidenceFormat := SubPrintSource.SubsidenceFormat;
    CompactionByModelLayerFormat := SubPrintSource.CompactionByModelLayerFormat;
    CompactionByInterbedSystemFormat :=
      SubPrintSource.CompactionByInterbedSystemFormat;
    VerticalDisplacementFormat := SubPrintSource.VerticalDisplacementFormat;
    NoDelayPreconsolidationHeadFormat :=
      SubPrintSource.NoDelayPreconsolidationHeadFormat;
    DelayPreconsolidationHeadFormat :=
      SubPrintSource.DelayPreconsolidationHeadFormat;
  end
  else
  begin
    inherited;
  end;
end;

procedure TSubPrintFormats.InitializeVariables;
begin
  SubsidenceFormat := 0;
  CompactionByModelLayerFormat := 0;
  CompactionByInterbedSystemFormat := 0;
  VerticalDisplacementFormat := 0;
  NoDelayPreconsolidationHeadFormat := 0;
  DelayPreconsolidationHeadFormat := 0;
end;

procedure TSubPrintFormats.SetCompactionByInterbedSystemFormat(
  const Value: integer);
begin
  SetIntegerProperty(FCompactionByInterbedSystemFormat, Value);
end;

procedure TSubPrintFormats.SetCompactionByModelLayerFormat(
  const Value: integer);
begin
  SetIntegerProperty(FCompactionByModelLayerFormat, Value);
end;

procedure TSubPrintFormats.SetDelayPreconsolidationHeadFormat(
  const Value: integer);
begin
  SetIntegerProperty(FDelayPreconsolidationHeadFormat, Value);
end;

procedure TSubPrintFormats.SetNoDelayPreconsolidationHeadFormat(
  const Value: integer);
begin
  SetIntegerProperty(FNoDelayPreconsolidationHeadFormat, Value);
end;

procedure TSubPrintFormats.SetSubsidenceFormat(const Value: integer);
begin
  SetIntegerProperty(FSubsidenceFormat, Value);
end;

procedure TSubPrintFormats.SetVerticalDisplacementFormat(const Value: integer);
begin
  SetIntegerProperty(FVerticalDisplacementFormat, Value);
end;

{ ZZoneItem }

procedure ZZoneItem.Assign(Source: TPersistent);
begin
  // if Assign is updated, update IsSame too.
  if Source is ZZoneItem then
  begin
    ZoneNumber := ZZoneItem(Source).ZoneNumber;
  end;
  inherited;
end;

function ZZoneItem.IsSame(AnotherItem: TOrderedItem): boolean;
begin
  result := AnotherItem is ZZoneItem;
  if result then
  begin
    result := ZoneNumber = ZZoneItem(AnotherItem).ZoneNumber;
  end;
end;

procedure ZZoneItem.SetZoneNumber(const Value: integer);
begin
  if FZoneNumber <> Value then
  begin
    FZoneNumber := Value;
    InvalidateModel;
  end;
end;

{ TCompositeZone }

procedure TCompositeZone.Assign(Source: TPersistent);
begin
  // if Assign is updated, update IsSame too.
  if Source is TCompositeZone then
  begin
    ZoneName := TCompositeZone(Source).ZoneName;
  end;
  inherited;
end;

constructor TCompositeZone.Create(Model: TBaseModel);
begin
  inherited Create(ZZoneItem, Model);
end;

function TCompositeZone.GetItem(Index: integer): ZZoneItem;
begin
  result := inherited Items[Index] as ZZoneItem;
end;

function TCompositeZone.IsSame(
  AnOrderedCollection: TOrderedCollection): boolean;
begin
  result := AnOrderedCollection is TCompositeZone;
  if result then
  begin
    result := ZoneName = TCompositeZone(AnOrderedCollection).ZoneName;
  end;
  if result then
  begin
    result := inherited IsSame(AnOrderedCollection);
  end;
end;

procedure TCompositeZone.SetItem(Index: integer; const Value: ZZoneItem);
begin
  inherited Items[Index] := Value;
end;

procedure TCompositeZone.SetZoneName(Value: string);
begin
  Value := ValidName(Value);
  Value := Copy(Value, 1, 10);
  if FZoneName <> Value then
  begin
    FZoneName := Value;
    InvalidateModel;
  end;
end;

{ TCompositeZoneItem }

procedure TCompositeZoneItem.Assign(Source: TPersistent);
begin
  // if Assign is updated, update IsSame too.
  if Source is TCompositeZoneItem then
  begin
    CompositeZone := TCompositeZoneItem(Source).CompositeZone;
  end;
  inherited;
end;

constructor TCompositeZoneItem.Create(Collection: TCollection);
begin
  inherited;
  FCompositeZone:= TCompositeZone.Create(Model);
end;

destructor TCompositeZoneItem.Destroy;
begin
  FCompositeZone.Free;
  inherited;
end;

function TCompositeZoneItem.IsSame(AnotherItem: TOrderedItem): boolean;
begin
  result := AnotherItem is TCompositeZoneItem;
  if result then
  begin
    result := TCompositeZoneItem(AnotherItem).CompositeZone.
      IsSame(CompositeZone);
  end;
end;

procedure TCompositeZoneItem.SetCompositeZone(const Value: TCompositeZone);
begin
  FCompositeZone.Assign(Value);
end;

{ TCompositeZoneCollection }

constructor TCompositeZoneCollection.Create(Model: TBaseModel);
begin
  inherited Create(TCompositeZoneItem, Model);
end;

function TCompositeZoneCollection.GetItem(Index: integer): TCompositeZoneItem;
begin
  result := inherited Items[Index] as TCompositeZoneItem;
end;

procedure TCompositeZoneCollection.SetItem(Index: integer;
  const Value: TCompositeZoneItem);
begin
  inherited Items[Index] := Value;
end;

{ TZoneBudgetSelect }

procedure TZoneBudgetSelect.Assign(Source: TPersistent);
var
  SourceBudget: TZoneBudgetSelect;
begin
  if Source is TZoneBudgetSelect then
  begin
    SourceBudget := TZoneBudgetSelect(Source);
    CompositeZones := SourceBudget.CompositeZones;
    ExportZBLST := SourceBudget.ExportZBLST;
    ExportCSV := SourceBudget.ExportCSV;
    ExportCSV2 := SourceBudget.ExportCSV2;
  end;
  inherited;
end;

constructor TZoneBudgetSelect.Create(Model: TBaseModel);
begin
  inherited;
  FCompositeZones := TCompositeZoneCollection.Create(Model);
  InitializeVariables;
end;

destructor TZoneBudgetSelect.Destroy;
begin
  FCompositeZones.Free;
  inherited;
end;

procedure TZoneBudgetSelect.InitializeVariables;
begin
  inherited;
  FExportZBLST := True;
  FExportCSV2 := True;
  FExportCSV := True;
  FCompositeZones.Clear
end;

procedure TZoneBudgetSelect.SetCompositeZones(
  const Value: TCompositeZoneCollection);
begin
  FCompositeZones.Assign(Value);
end;

procedure TZoneBudgetSelect.SetExportCSV(const Value: boolean);
begin
  if FExportCSV <> Value then
  begin
    FExportCSV := Value;
    InvalidateModel;
  end;
end;

procedure TZoneBudgetSelect.SetExportCSV2(const Value: boolean);
begin
  if FExportCSV2 <> Value then
  begin
    FExportCSV2 := Value;
    InvalidateModel;
  end;
end;

procedure TZoneBudgetSelect.SetExportZBLST(const Value: boolean);
begin
  if FExportZBLST <> Value then
  begin
    FExportZBLST := Value;
    InvalidateModel;
  end;
end;

{ TSwtPrintFormats }

procedure TSwtPrintFormats.Assign(Source: TPersistent);
var
  SwtPrintSource: TSwtPrintFormats;
begin
  if Source is TSwtPrintFormats then
  begin
    SwtPrintSource := TSwtPrintFormats(Source);
    SubsidenceFormat := SwtPrintSource.SubsidenceFormat;
    CompactionByModelLayerFormat := SwtPrintSource.CompactionByModelLayerFormat;
    CompactionByInterbedSystemFormat :=
      SwtPrintSource.CompactionByInterbedSystemFormat;
    VerticalDisplacementFormat := SwtPrintSource.VerticalDisplacementFormat;
    PreconsolidationStress := SwtPrintSource.PreconsolidationStress;
    DeltaPreconsolidationStress := SwtPrintSource.DeltaPreconsolidationStress;
    GeostaticStress := SwtPrintSource.GeostaticStress;
    DeltaGeostaticStress := SwtPrintSource.DeltaGeostaticStress;
    EffectiveStress := SwtPrintSource.EffectiveStress;
    DeltaEffectiveStress := SwtPrintSource.DeltaEffectiveStress;
    VoidRatio := SwtPrintSource.VoidRatio;
    ThicknessCompressibleSediments := SwtPrintSource.ThicknessCompressibleSediments;
    LayerCenterElevation := SwtPrintSource.LayerCenterElevation;
  end
  else
  begin
    inherited;
  end;
end;

procedure TSwtPrintFormats.InitializeVariables;
begin
  SubsidenceFormat := 0;
  CompactionByModelLayerFormat := 0;
  CompactionByInterbedSystemFormat := 0;
  VerticalDisplacementFormat := 0;
  PreconsolidationStress := 0;
  DeltaPreconsolidationStress := 0;
  GeostaticStress := 0;
  DeltaGeostaticStress := 0;
  EffectiveStress := 0;
  DeltaEffectiveStress := 0;
  VoidRatio := 0;
  ThicknessCompressibleSediments := 0;
  LayerCenterElevation := 0;
end;

procedure TSwtPrintFormats.SetCompactionByInterbedSystemFormat(
  const Value: integer);
begin
  SetIntegerProperty(FCompactionByInterbedSystemFormat, Value);
end;

procedure TSwtPrintFormats.SetCompactionByModelLayerFormat(
  const Value: integer);
begin
  SetIntegerProperty(FCompactionByModelLayerFormat, Value);
end;

procedure TSwtPrintFormats.SetDeltaEffectiveStress(const Value: integer);
begin
  SetIntegerProperty(FDeltaEffectiveStress, Value);
end;

procedure TSwtPrintFormats.SetDeltaGeostaticStress(const Value: integer);
begin
  SetIntegerProperty(FDeltaGeostaticStress, Value);
end;

procedure TSwtPrintFormats.SetDeltaPreconsolidationStress(const Value: integer);
begin
  SetIntegerProperty(FDeltaPreconsolidationStress, Value);
end;

procedure TSwtPrintFormats.SetEffectiveStress(const Value: integer);
begin
  SetIntegerProperty(FEffectiveStress, Value);
end;

procedure TSwtPrintFormats.SetGeostaticStress(const Value: integer);
begin
  SetIntegerProperty(FGeostaticStress, Value);
end;

procedure TSwtPrintFormats.SetLayerCenterElevation(const Value: integer);
begin
  SetIntegerProperty(FLayerCenterElevation, Value);
end;

procedure TSwtPrintFormats.SetPreconsolidationStress(const Value: integer);
begin
  SetIntegerProperty(FPreconsolidationStress, Value);
end;

procedure TSwtPrintFormats.SetSubsidenceFormat(const Value: integer);
begin
  SetIntegerProperty(FSubsidenceFormat, Value);
end;

procedure TSwtPrintFormats.SetThicknessCompressibleSediments(
  const Value: integer);
begin
  SetIntegerProperty(FThicknessCompressibleSediments, Value);
end;

procedure TSwtPrintFormats.SetVerticalDisplacementFormat(const Value: integer);
begin
  SetIntegerProperty(FVerticalDisplacementFormat, Value);
end;

procedure TSwtPrintFormats.SetVoidRatio(const Value: integer);
begin
  SetIntegerProperty(FVoidRatio, Value);
end;

{ TSwtPrintItem }

procedure TSwtPrintItem.Assign(Source: TPersistent);
var
  SourceItem: TSwtPrintItem;
begin
  // if Assign is updated, update IsSame too.
  if Source is TSwtPrintItem then
  begin
    SourceItem := TSwtPrintItem(Source);
    PrintSubsidence := SourceItem.PrintSubsidence;
    SaveSubsidence := SourceItem.SaveSubsidence;
    PrintCompactionByModelLayer := SourceItem.PrintCompactionByModelLayer;
    SaveCompactionByModelLayer := SourceItem.SaveCompactionByModelLayer;
    PrintCompactionByInterbedSystem := SourceItem.PrintCompactionByInterbedSystem;
    SaveCompactionByInterbedSystem := SourceItem.SaveCompactionByInterbedSystem;
    PrintVerticalDisplacement := SourceItem.PrintVerticalDisplacement;
    SaveVerticalDisplacement := SourceItem.SaveVerticalDisplacement;
    PrintPreconsolidationStress := SourceItem.PrintPreconsolidationStress;
    SavePreconsolidationStress := SourceItem.SavePreconsolidationStress;
    PrintDeltaPreconsolidationStress := SourceItem.PrintDeltaPreconsolidationStress;
    SaveDeltaPreconsolidationStress := SourceItem.SaveDeltaPreconsolidationStress;
    PrintGeostaticStress := SourceItem.PrintGeostaticStress;
    SaveGeostaticStress := SourceItem.SaveGeostaticStress;
    PrintDeltaGeostaticStress := SourceItem.PrintDeltaGeostaticStress;
    SaveDeltaGeostaticStress := SourceItem.SaveDeltaGeostaticStress;
    PrintEffectiveStress := SourceItem.PrintEffectiveStress;
    SaveEffectiveStress := SourceItem.SaveEffectiveStress;
    PrintDeltaEffectiveStress := SourceItem.PrintDeltaEffectiveStress;
    SaveDeltaEffectiveStress := SourceItem.SaveDeltaEffectiveStress;
    PrintVoidRatio := SourceItem.PrintVoidRatio;
    SaveVoidRatio := SourceItem.SaveVoidRatio;
    PrintThicknessCompressibleSediments := SourceItem.PrintThicknessCompressibleSediments;
    SaveThicknessCompressibleSediments := SourceItem.SaveThicknessCompressibleSediments;
    PrintLayerCenterElevation := SourceItem.PrintLayerCenterElevation;
    SaveLayerCenterElevation := SourceItem.SaveLayerCenterElevation;
  end;
  inherited;
end;

function TSwtPrintItem.IsSame(AnotherItem: TOrderedItem): boolean;
var
  SourceItem: TSwtPrintItem;
begin
  if AnotherItem is TSwtPrintItem then
  begin
    result := inherited;
    if result then
    begin

      SourceItem := TSwtPrintItem(AnotherItem);
      result := (PrintSubsidence = SourceItem.PrintSubsidence)
        and (SaveSubsidence = SourceItem.SaveSubsidence)
        and (PrintCompactionByModelLayer = SourceItem.PrintCompactionByModelLayer)
        and (SaveCompactionByModelLayer = SourceItem.SaveCompactionByModelLayer)
        and (PrintCompactionByInterbedSystem = SourceItem.PrintCompactionByInterbedSystem)
        and (SaveCompactionByInterbedSystem = SourceItem.SaveCompactionByInterbedSystem)
        and (PrintVerticalDisplacement = SourceItem.PrintVerticalDisplacement)
        and (SaveVerticalDisplacement = SourceItem.SaveVerticalDisplacement)
        and (PrintPreconsolidationStress = SourceItem.PrintPreconsolidationStress)
        and (SavePreconsolidationStress = SourceItem.SavePreconsolidationStress)
        and (PrintDeltaPreconsolidationStress = SourceItem.PrintDeltaPreconsolidationStress)
        and (SaveDeltaPreconsolidationStress = SourceItem.SaveDeltaPreconsolidationStress)
        and (PrintGeostaticStress = SourceItem.PrintGeostaticStress)
        and (SaveGeostaticStress = SourceItem.SaveGeostaticStress)
        and (PrintDeltaGeostaticStress = SourceItem.PrintDeltaGeostaticStress)
        and (SaveDeltaGeostaticStress = SourceItem.SaveDeltaGeostaticStress)
        and (PrintEffectiveStress = SourceItem.PrintEffectiveStress)
        and (SaveEffectiveStress = SourceItem.SaveEffectiveStress)
        and (PrintDeltaEffectiveStress = SourceItem.PrintDeltaEffectiveStress)
        and (SaveDeltaEffectiveStress = SourceItem.SaveDeltaEffectiveStress)
        and (PrintVoidRatio = SourceItem.PrintVoidRatio)
        and (SaveVoidRatio = SourceItem.SaveVoidRatio)
        and (PrintThicknessCompressibleSediments = SourceItem.PrintThicknessCompressibleSediments)
        and (SaveThicknessCompressibleSediments = SourceItem.SaveThicknessCompressibleSediments)
        and (PrintLayerCenterElevation = SourceItem.PrintLayerCenterElevation)
        and (SaveLayerCenterElevation = SourceItem.SaveLayerCenterElevation)
    end;
  end
  else
  begin
    result := False;
  end;
end;

procedure TSwtPrintItem.SetPrintCompactionByInterbedSystem(
  const Value: boolean);
begin
  SetBooleanProperty(FPrintCompactionByInterbedSystem, Value);
end;

procedure TSwtPrintItem.SetPrintCompactionByModelLayer(const Value: boolean);
begin
  SetBooleanProperty(FPrintCompactionByModelLayer, Value);
end;

procedure TSwtPrintItem.SetPrintDeltaEffectiveStress(const Value: boolean);
begin
  SetBooleanProperty(FPrintDeltaEffectiveStress, Value);
end;

procedure TSwtPrintItem.SetPrintDeltaGeostaticStress(const Value: boolean);
begin
  SetBooleanProperty(FPrintDeltaGeostaticStress, Value);
end;

procedure TSwtPrintItem.SetPrintDeltaPreconsolidationStress(
  const Value: boolean);
begin
  SetBooleanProperty(FPrintDeltaPreconsolidationStress, Value);
end;

procedure TSwtPrintItem.SetPrintEffectiveStress(const Value: boolean);
begin
  SetBooleanProperty(FPrintEffectiveStress, Value);
end;

procedure TSwtPrintItem.SetPrintGeostaticStress(const Value: boolean);
begin
  SetBooleanProperty(FPrintGeostaticStress, Value);
end;

procedure TSwtPrintItem.SetPrintLayerCenterElevation(const Value: boolean);
begin
  SetBooleanProperty(FPrintLayerCenterElevation, Value);
end;

procedure TSwtPrintItem.SetPrintPreconsolidationStress(const Value: boolean);
begin
  SetBooleanProperty(FPrintPreconsolidationStress, Value);
end;

procedure TSwtPrintItem.SetPrintSubsidence(const Value: boolean);
begin
  SetBooleanProperty(FPrintSubsidence, Value);
end;

procedure TSwtPrintItem.SetPrintThicknessCompressibleSediments(
  const Value: boolean);
begin
  SetBooleanProperty(FPrintThicknessCompressibleSediments, Value);
end;

procedure TSwtPrintItem.SetPrintVerticalDisplacement(const Value: boolean);
begin
  SetBooleanProperty(FPrintVerticalDisplacement, Value);
end;

procedure TSwtPrintItem.SetPrintVoidRatio(const Value: boolean);
begin
  SetBooleanProperty(FPrintVoidRatio, Value);
end;

procedure TSwtPrintItem.SetSaveCompactionByInterbedSystem(const Value: boolean);
begin
  SetBooleanProperty(FSaveCompactionByInterbedSystem, Value);
end;

procedure TSwtPrintItem.SetSaveCompactionByModelLayer(const Value: boolean);
begin
  SetBooleanProperty(FSaveCompactionByModelLayer, Value);
end;

procedure TSwtPrintItem.SetSaveDeltaEffectiveStress(const Value: boolean);
begin
  SetBooleanProperty(FSaveDeltaEffectiveStress, Value);
end;

procedure TSwtPrintItem.SetSaveDeltaGeostaticStress(const Value: boolean);
begin
  SetBooleanProperty(FSaveDeltaGeostaticStress, Value);
end;

procedure TSwtPrintItem.SetSaveDeltaPreconsolidationStress(
  const Value: boolean);
begin
  SetBooleanProperty(FSaveDeltaPreconsolidationStress, Value);
end;

procedure TSwtPrintItem.SetSaveEffectiveStress(const Value: boolean);
begin
  SetBooleanProperty(FSaveEffectiveStress, Value);
end;

procedure TSwtPrintItem.SetSaveGeostaticStress(const Value: boolean);
begin
  SetBooleanProperty(FSaveGeostaticStress, Value);
end;

procedure TSwtPrintItem.SetSaveLayerCenterElevation(const Value: boolean);
begin
  SetBooleanProperty(FSaveLayerCenterElevation, Value);
end;

procedure TSwtPrintItem.SetSavePreconsolidationStress(const Value: boolean);
begin
  SetBooleanProperty(FSavePreconsolidationStress, Value);
end;

procedure TSwtPrintItem.SetSaveSubsidence(const Value: boolean);
begin
  SetBooleanProperty(FSaveSubsidence, Value);
end;

procedure TSwtPrintItem.SetSaveThicknessCompressibleSediments(
  const Value: boolean);
begin
  SetBooleanProperty(FSaveThicknessCompressibleSediments, Value);
end;

procedure TSwtPrintItem.SetSaveVerticalDisplacement(const Value: boolean);
begin
  SetBooleanProperty(FSaveVerticalDisplacement, Value);
end;

procedure TSwtPrintItem.SetSaveVoidRatio(const Value: boolean);
begin
  SetBooleanProperty(FSaveVoidRatio, Value);
end;

{ TSwtPrintCollection }

constructor TSwtPrintCollection.Create(Model: TBaseModel);
begin
  inherited Create(TSwtPrintItem, Model);
end;

function TSwtPrintCollection.GetItem(Index: integer): TSwtPrintItem;
begin
  result := inherited Items[Index] as TSwtPrintItem;
end;

procedure TSwtPrintCollection.ReportErrors;
var
  Index: Integer;
  PrintChoice: TSwtPrintItem;
begin
  frmErrorsAndWarnings.RemoveErrorGroup(frmGoPhast.PhastModel, StrInTheSubsidenceAn);
  for Index := 0 to Count -1 do
  begin
    PrintChoice := Items[Index];
    if PrintChoice.StartTime > PrintChoice.EndTime then
    begin
      frmErrorsAndWarnings.AddError(frmGoPhast.PhastModel, StrInTheSubsidenceAn,
        Format(StrStartingTime0g,
          [PrintChoice.StartTime, PrintChoice.EndTime]));
    end;
  end;
end;

procedure TSwtPrintCollection.SetItem(Index: integer;
  const Value: TSwtPrintItem);
begin
  inherited Items[Index] := Value;
end;

{ TSwtInitialPrint }

procedure TSwtInitialPrint.Assign(Source: TPersistent);
var
  SwtInitialPrintSource: TSwtInitialPrint;
begin
  if Source is TSwtInitialPrint then
  begin
    SwtInitialPrintSource := TSwtInitialPrint(Source);
    PrintInitialLayerCenterElevations :=
      SwtInitialPrintSource.PrintInitialLayerCenterElevations;
    InitialLayerCenterElevationFormat :=
      SwtInitialPrintSource.InitialLayerCenterElevationFormat;
    PrintInitialGeostaticStress :=
      SwtInitialPrintSource.PrintInitialGeostaticStress;
    InitialGeostaticStressFormat :=
      SwtInitialPrintSource.InitialGeostaticStressFormat;
    PrintInitialEffectiveStress :=
      SwtInitialPrintSource.PrintInitialEffectiveStress;
    InitialEffectiveStressFormat :=
      SwtInitialPrintSource.InitialEffectiveStressFormat;
    PrintInitialPreconsolidationStress :=
      SwtInitialPrintSource.PrintInitialPreconsolidationStress;
    InitialPreconsolidationStressFormat :=
      SwtInitialPrintSource.InitialPreconsolidationStressFormat;
    PrintInitialEquivalentStorageProperties :=
      SwtInitialPrintSource.PrintInitialEquivalentStorageProperties;
    InitialEquivalentStoragePropertiesFormat :=
      SwtInitialPrintSource.InitialEquivalentStoragePropertiesFormat;
  end
  else
  begin
    inherited;
  end;
end;

procedure TSwtInitialPrint.InitializeVariables;
begin
  PrintInitialLayerCenterElevations := False;
  InitialLayerCenterElevationFormat := 0;

  PrintInitialGeostaticStress := False;
  InitialGeostaticStressFormat := 0;

  PrintInitialEffectiveStress := False;
  InitialEffectiveStressFormat := 0;

  PrintInitialPreconsolidationStress := False;
  InitialPreconsolidationStressFormat := 0;

  PrintInitialEquivalentStorageProperties := False;
  InitialEquivalentStoragePropertiesFormat := 0;
end;

procedure TSwtInitialPrint.SetInitialEffectiveStressFormat(
  const Value: integer);
begin
  SetIntegerProperty(FInitialEffectiveStressFormat, Value);
end;

procedure TSwtInitialPrint.SetInitialEquivalentStoragePropertiesFormat(
  const Value: integer);
begin
  SetIntegerProperty(FInitialEquivalentStoragePropertiesFormat, Value);
end;

procedure TSwtInitialPrint.SetInitialGeostaticStressFormat(
  const Value: integer);
begin
  SetIntegerProperty(FInitialGeostaticStressFormat, Value);
end;

procedure TSwtInitialPrint.SetInitialLayerCenterElevationFormat(
  const Value: integer);
begin
  SetIntegerProperty(FInitialLayerCenterElevationFormat, Value);
end;

procedure TSwtInitialPrint.SetInitialPreconsolidationStressFormat(
  const Value: integer);
begin
  SetIntegerProperty(FInitialPreconsolidationStressFormat, Value);
end;

procedure TSwtInitialPrint.SetPrintInitialEffectiveStress(const Value: boolean);
begin
  SetBooleanProperty(FPrintInitialEffectiveStress, Value);
end;

procedure TSwtInitialPrint.SetPrintInitialEquivalentStorageProperties(
  const Value: boolean);
begin
  SetBooleanProperty(FPrintInitialEquivalentStorageProperties, Value);
end;

procedure TSwtInitialPrint.SetPrintInitialGeostaticStress(const Value: boolean);
begin
  SetBooleanProperty(FPrintInitialGeostaticStress, Value);
end;

procedure TSwtInitialPrint.SetPrintInitialLayerCenterElevations(
  const Value: boolean);
begin
  SetBooleanProperty(FPrintInitialLayerCenterElevations, Value);
end;

procedure TSwtInitialPrint.SetPrintInitialPreconsolidationStress(
  const Value: boolean);
begin
  SetBooleanProperty(FPrintInitialPreconsolidationStress, Value);
end;

{ TSwtPackageSelection }

procedure TSwtPackageSelection.Assign(Source: TPersistent);
var
  SwtSource: TSwtPackageSelection;
begin
  if Source is TSwtPackageSelection then
  begin
    SwtSource := TSwtPackageSelection(Source);
    ThickResponse := SwtSource.ThickResponse;
    VoidRatioResponse := SwtSource.VoidRatioResponse;
    PreconsolidationSource := SwtSource.PreconsolidationSource;
    CompressionSource := SwtSource.CompressionSource;
    PrintFormats := SwtSource.PrintFormats;
    PrintChoices := SwtSource.PrintChoices;
    InitialPrint := SwtSource.InitialPrint;
    BinaryOutputChoice := SwtSource.BinaryOutputChoice;
  end;
  inherited;
end;

constructor TSwtPackageSelection.Create(Model: TBaseModel);
var
  OnInvalidate: TNotifyEvent;
begin
  if Model = nil then
  begin
    OnInvalidate := nil;
  end
  else
  begin
    OnInvalidate := Model.Invalidate;
  end;
  inherited;
  FPrintChoices := TSwtPrintCollection.Create(Model);
  FInitialPrint := TSwtInitialPrint.Create(OnInvalidate);
  FPrintFormats := TSwtPrintFormats.Create(OnInvalidate);
  InitializeVariables;
end;

destructor TSwtPackageSelection.Destroy;
begin
  FPrintFormats.Free;
  FInitialPrint.Free;
  FPrintChoices.Free;
  inherited;
end;

procedure TSwtPackageSelection.InitializeVariables;
begin
  inherited;
  FThickResponse := trConstant;
  FCompressionSource := csSpecificStorage;
  FPreconsolidationSource := pcSpecified;
  FVoidRatioResponse := vrrConstant;
  FSubBinaryOutputChoice := sbocSingleFile;
  PrintFormats.InitializeVariables;
  PrintChoices.Clear;
  InitialPrint.InitializeVariables;
end;

procedure TSwtPackageSelection.SetCompressionSource(
  const Value: TCompressionSource);
var
  LayerStructure: TLayerStructure;
  LayerIndex: Integer;
  LayerGroup: TLayerGroup;
  Index: Integer;
  WtItem: TSwtWaterTableItem;
begin
  if FCompressionSource <> Value then
  begin
    FCompressionSource := Value;
    InvalidateModel;
    if FModel <> nil then
    begin
      // ensure that related data sets have been created.
      LayerStructure := (FModel as TCustomModel).LayerStructure;
      if LayerStructure <> nil then
      begin
        for LayerIndex := 0 to LayerStructure.Count - 1 do
        begin
          LayerGroup := LayerStructure[LayerIndex];
          for Index := 0 to LayerGroup.WaterTableLayers.Count - 1 do
          begin
            WtItem := LayerGroup.WaterTableLayers[Index];
            WtItem.WaterTableInitialElasticSkeletalSpecificStorageDataArrayName :=
              WtItem.WaterTableInitialElasticSkeletalSpecificStorageDataArrayName;
            WtItem.WaterTableInitialInelasticSkeletalSpecificStorageDataArrayName :=
              WtItem.WaterTableInitialInelasticSkeletalSpecificStorageDataArrayName;
            WtItem.WaterTableRecompressionIndexDataArrayName :=
              WtItem.WaterTableRecompressionIndexDataArrayName;
            WtItem.WaterTableCompressionIndexDataArrayName :=
              WtItem.WaterTableCompressionIndexDataArrayName;
          end;
        end;
      end;
    end;
  end;
end;

procedure TSwtPackageSelection.SetInitialPrint(const Value: TSwtInitialPrint);
begin
  FInitialPrint.Assign(Value);
end;

procedure TSwtPackageSelection.SetPreconsolidationSource(
  const Value: TPreconsolidationSource);
begin
  if FPreconsolidationSource <> Value then
  begin
    FPreconsolidationSource := Value;
    InvalidateModel;
  end;
end;

procedure TSwtPackageSelection.SetPrintChoices(
  const Value: TSwtPrintCollection);
begin
  FPrintChoices.Assign(Value);
end;

procedure TSwtPackageSelection.SetPrintFormats(const Value: TSwtPrintFormats);
begin
  FPrintFormats.Assign(Value);
end;

procedure TSwtPackageSelection.SetSubBinaryOutputChoice(
  const Value: TSubBinaryOutputChoice);
begin
  if FSubBinaryOutputChoice <> Value then
  begin
    FSubBinaryOutputChoice := Value;
    InvalidateModel;
  end;
end;

procedure TSwtPackageSelection.SetThickResponse(const Value: TThickResponse);
begin
  if FThickResponse <> Value then
  begin
    FThickResponse := Value;
    InvalidateModel;
  end;
end;

procedure TSwtPackageSelection.SetVoidRatioResponse(
  const Value: TVoidRatioResponse);
begin
  if FVoidRatioResponse <> Value then
  begin
    FVoidRatioResponse := Value;
    InvalidateModel;
  end;
end;

procedure TCustomPrintItem.SetStartTime(const Value: double);
begin
  SetRealProperty(FStartTime, Value);
end;

procedure TCustomPrintItem.Assign(Source: TPersistent);
var
  SourceItem: TCustomPrintItem;
begin
  inherited;
  // if Assign is updated, update IsSame too.
  if Source is TCustomPrintItem then
  begin
    SourceItem := TCustomPrintItem(Source);
    StartTime := SourceItem.StartTime;
    EndTime := SourceItem.EndTime;
  end;
end;

function TCustomPrintItem.IsSame(AnotherItem: TOrderedItem): boolean;
var
  SourceItem: TCustomPrintItem;
begin
  Result := false;
  if AnotherItem is TCustomPrintItem then
  begin
    SourceItem := TCustomPrintItem(AnotherItem);
    result := (StartTime = SourceItem.StartTime)
      and (EndTime = SourceItem.EndTime)
  end;
end;

procedure TCustomPrintItem.SetEndTime(const Value: double);
begin
  SetRealProperty(FEndTime, Value);
end;

{ THydPackageSelection }

procedure THydPackageSelection.Assign(Source: TPersistent);
begin
  if Source is THydPackageSelection then
  begin
    StoredHYDNOH := THydPackageSelection(Source).StoredHYDNOH;
  end;
  inherited;
end;

constructor THydPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FStoredHYDNOH := TRealStorage.Create;
  FStoredHYDNOH.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor THydPackageSelection.Destroy;
begin
  FStoredHYDNOH.Free;
  inherited;
end;

procedure THydPackageSelection.InitializeVariables;
begin
  inherited;
  HYDNOH := -1E+20;
end;

function THydPackageSelection.GetHYDNOH: double;
begin
  result := StoredHYDNOH.Value;
end;

procedure THydPackageSelection.SetHYDNOH(const Value: double);
begin
  if StoredHYDNOH.Value <> Value then
  begin
    StoredHYDNOH.Value := Value;
    InvalidateModel;
  end;
end;

procedure THydPackageSelection.SetStoredHYDNOH(const Value: TRealStorage);
begin
  if FStoredHYDNOH.Value <> Value.Value then
  begin
    FStoredHYDNOH.Assign(Value);
    InvalidateModel;
  end;
end;

{ TUpwPackageSelection }

procedure TUpwPackageSelection.Assign(Source: TPersistent);
begin
  if Source is TUpwPackageSelection then
  begin
    HDryPrintOption := TUpwPackageSelection(Source).HDryPrintOption;
    NoParCheck := TUpwPackageSelection(Source).NoParCheck;
  end;
  inherited;

end;

constructor TUpwPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  InitializeVariables;
end;

destructor TUpwPackageSelection.Destroy;
begin
  inherited;
end;

procedure TUpwPackageSelection.InitializeVariables;
begin
  inherited;
  FHDryPrintOption := hpoPrintHdry;
  FNoParCheck := False;
end;

procedure TUpwPackageSelection.SetHDryPrintOption(
  const Value: THDryPrintOption);
begin
  if FHDryPrintOption <> Value then
  begin
    InvalidateModel;
    FHDryPrintOption := Value;
  end;
end;

procedure TUpwPackageSelection.SetNoParCheck(const Value: Boolean);
begin
  if FNoParCheck <> Value then
  begin
    InvalidateModel;
    FNoParCheck := Value;
  end;
end;

{ TNwtPackageSelection }

procedure TNwtPackageSelection.Assign(Source: TPersistent);
var
  SourceNwt: TNwtPackageSelection;
begin
  if Source is TNwtPackageSelection then
  begin
    SourceNwt := TNwtPackageSelection(Source);
    HeadTolerance := SourceNwt.HeadTolerance;
    FluxTolerance := SourceNwt.FluxTolerance;
    MaxOuterIterations := SourceNwt.MaxOuterIterations;
    ThicknessFactor := SourceNwt.ThicknessFactor;
    SolverMethod := SourceNwt.SolverMethod;
    PrintFlag := SourceNwt.PrintFlag;
    CorrectForCellBottom := SourceNwt.CorrectForCellBottom;
    Option := SourceNwt.Option;
    DBDTheta := SourceNwt.DBDTheta;
    DBDKappa := SourceNwt.DBDKappa;
    DBDGamma := SourceNwt.DBDGamma;
    MomementumCoefficient := SourceNwt.MomementumCoefficient;
    BackFlag := SourceNwt.BackFlag;
    MaxBackIterations := SourceNwt.MaxBackIterations;
    BackTol := SourceNwt.BackTol;
    BackReduce := SourceNwt.BackReduce;
    MaxIterInner := SourceNwt.MaxIterInner;
    IluMethod := SourceNwt.IluMethod;
    FillLimit := SourceNwt.FillLimit;
    FillLevel := SourceNwt.FillLevel;
    StopTolerance := SourceNwt.StopTolerance;
    MaxGmresRestarts := SourceNwt.MaxGmresRestarts;
    AccelMethod := SourceNwt.AccelMethod;
    OrderingMethod := SourceNwt.OrderingMethod;
    Level := SourceNwt.Level;
    NumberOfOrthogonalizations := SourceNwt.NumberOfOrthogonalizations;
    ApplyReducedPrecondition := SourceNwt.ApplyReducedPrecondition;
    ResidReducConv := SourceNwt.ResidReducConv;
    UseDropTolerance := SourceNwt.UseDropTolerance;
    DropTolerancePreconditioning := SourceNwt.DropTolerancePreconditioning;
    InnerHeadClosureCriterion := SourceNwt.InnerHeadClosureCriterion;
    MaxInnerIterations := SourceNwt.MaxInnerIterations;
    ContinueNWT := SourceNwt.ContinueNWT;
  end;
  inherited;
end;

constructor TNwtPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FStopTolerance := TRealStorage.Create;
  FMomementumCoefficient := TRealStorage.Create;
  FDropTolerancePreconditioning := TRealStorage.Create;
  FDBDKappa := TRealStorage.Create;
  FInnerHeadClosureCriterion := TRealStorage.Create;
  FDBDGamma := TRealStorage.Create;
  FFluxTolerance := TRealStorage.Create;
  FResidReducConv := TRealStorage.Create;
  FDBDTheta := TRealStorage.Create;
  FHeadTolerance := TRealStorage.Create;
  FThicknessFactor := TRealStorage.Create;
  FBackReduce := TRealStorage.Create;
  FBackTol := TRealStorage.Create;

  FStopTolerance.OnChange := OnValueChanged;
  FMomementumCoefficient.OnChange := OnValueChanged;
  FDropTolerancePreconditioning.OnChange := OnValueChanged;
  FDBDKappa.OnChange := OnValueChanged;
  FInnerHeadClosureCriterion.OnChange := OnValueChanged;
  FDBDGamma.OnChange := OnValueChanged;
  FFluxTolerance.OnChange := OnValueChanged;
  FResidReducConv.OnChange := OnValueChanged;
  FDBDTheta.OnChange := OnValueChanged;
  FHeadTolerance.OnChange := OnValueChanged;
  FThicknessFactor.OnChange := OnValueChanged;
  FBackReduce.OnChange := OnValueChanged;
  FBackTol.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor TNwtPackageSelection.Destroy;
begin
  FBackTol.Free;
  FBackReduce.Free;
  FThicknessFactor.Free;
  FHeadTolerance.Free;
  FDBDTheta.Free;
  FResidReducConv.Free;
  FFluxTolerance.Free;
  FDBDGamma.Free;
  FInnerHeadClosureCriterion.Free;
  FDBDKappa.Free;
  FDropTolerancePreconditioning.Free;
  FMomementumCoefficient.Free;
  FStopTolerance.Free;
  inherited;
end;

procedure TNwtPackageSelection.InitializeVariables;
begin
  inherited;
  HeadTolerance.Value := 1e-4;
  // The recomended value is 500 with units of m and days
  // The default units in ModelMuse are m and seconds
  // 0.006 is approximately equal to 500/24/3600
  FluxTolerance.Value := 0.06;
  MaxOuterIterations := 100;
  ThicknessFactor.Value := 0.00001;
  SolverMethod := nsmChiMD;
  PrintFlag := 1;
  CorrectForCellBottom := 0;
  Option := noSimple;
  DBDTheta.Value := 0.9;
  DBDKappa.Value := 0.0001;
  DBDGamma.Value := 0;
  MomementumCoefficient.Value := 0.1;
  BackFlag := 1;
  MaxBackIterations := 50;
  BackTol.Value := 1.1;
  BackReduce.Value := 0.7;
  MaxIterInner := 50;
  IluMethod := nimKOrder;
  FillLimit := 7;
  FillLevel := 1;
  StopTolerance.Value := 1e-10;
  MaxGmresRestarts := 10;
  AccelMethod := namOthoMin;
  OrderingMethod := nomRCM;
  Level := 3;
  NumberOfOrthogonalizations := 5;
  ApplyReducedPrecondition := narpApply;
  ResidReducConv.Value := 0;
  UseDropTolerance := nudtUse;
  DropTolerancePreconditioning.Value := 1e-4;
  InnerHeadClosureCriterion.Value := 1e-4;
  MaxInnerIterations := 50;
  ContinueNWT := False;
end;

procedure TNwtPackageSelection.SetAccelMethod(const Value: TNewtonAccelMethod);
begin
  if FAccelMethod <> Value then
  begin
    FAccelMethod := Value;
    InvalidateModel;
  end;
end;

procedure TNwtPackageSelection.SetApplyReducedPrecondition(
  const Value: TNewtonApplyReducedPrecondition);
begin
  if FApplyReducedPrecondition <> Value then
  begin
    FApplyReducedPrecondition := Value;
    InvalidateModel;
  end;
end;

procedure TNwtPackageSelection.SetBackFlag(const Value: integer);
begin
  SetIntegerProperty(FBackFlag , Value);
end;

procedure TNwtPackageSelection.SetBackReduce(const Value: TRealStorage);
begin
  SetRealProperty(FBackReduce , Value);
end;

procedure TNwtPackageSelection.SetBackTol(const Value: TRealStorage);
begin
  SetRealProperty(FBackTol , Value);
end;

procedure TNwtPackageSelection.SetCorrectForCellBottom(const Value: integer);
begin
  SetIntegerProperty(FCorrectForCellBottom , Value);
end;

procedure TNwtPackageSelection.SetDBDGamma(const Value: TRealStorage);
begin
  SetRealProperty(FDBDGamma , Value);
end;

procedure TNwtPackageSelection.SetDBDKappa(const Value: TRealStorage);
begin
  SetRealProperty(FDBDKappa , Value);
end;

procedure TNwtPackageSelection.SetDBDTheta(const Value: TRealStorage);
begin
  SetRealProperty(FDBDTheta , Value);
end;

procedure TNwtPackageSelection.SetDropTolerancePreconditioning(
  const Value: TRealStorage);
begin
  SetRealProperty(FDropTolerancePreconditioning , Value);
end;

procedure TNwtPackageSelection.SetFillLevel(const Value: integer);
begin
  SetIntegerProperty(FFillLevel , Value);
end;

procedure TNwtPackageSelection.SetFillLimit(const Value: integer);
begin
  SetIntegerProperty(FFillLimit , Value);
end;

procedure TNwtPackageSelection.SetFluxTolerance(const Value: TRealStorage);
begin
  SetRealProperty(FFluxTolerance , Value);
end;

procedure TNwtPackageSelection.SetContinueNWT(const Value: Boolean);
begin
  SetBooleanProperty(FContinueNWT, Value);
end;

procedure TNwtPackageSelection.SetHeadTolerance(const Value: TRealStorage);
begin
  SetRealProperty(FHeadTolerance , Value);
end;

procedure TNwtPackageSelection.SetIluMethod(const Value: TNewtonIluMethod);
begin
  if FIluMethod <> Value then
  begin
    FIluMethod := Value;
    InvalidateModel;
  end;
end;

procedure TNwtPackageSelection.SetInnerHeadClosureCriterion(
  const Value: TRealStorage);
begin
  SetRealProperty(FInnerHeadClosureCriterion , Value);
end;

procedure TNwtPackageSelection.SetLevel(const Value: integer);
begin
  SetIntegerProperty(FLevel , Value);
end;

procedure TNwtPackageSelection.SetMaxBackIterations(const Value: integer);
begin
  SetIntegerProperty(FMaxBackIterations , Value);
end;

procedure TNwtPackageSelection.SetMaxGmresRestarts(const Value: integer);
begin
  SetIntegerProperty(FMaxGmresRestarts , Value);
end;

procedure TNwtPackageSelection.SetMaxInnerIterations(const Value: integer);
begin
  SetIntegerProperty(FMaxInnerIterations , Value);
end;

procedure TNwtPackageSelection.SetMaxIterInner(const Value: integer);
begin
  SetIntegerProperty(FMaxIterInner , Value);
end;

procedure TNwtPackageSelection.SetMaxOuterIterations(const Value: integer);
begin
  SetIntegerProperty(FMaxOuterIterations , Value);
end;

procedure TNwtPackageSelection.SetMomementumCoefficient(
  const Value: TRealStorage);
begin
  SetRealProperty(FMomementumCoefficient , Value);
end;

procedure TNwtPackageSelection.SetNumberOfOrthogonalizations(
  const Value: integer);
begin
  SetIntegerProperty(FNumberOfOrthogonalizations , Value);
end;

procedure TNwtPackageSelection.SetOption(const Value: TNewtonOption);
begin
  if FOption <> Value then
  begin
    FOption := Value;
    InvalidateModel;
  end;
end;

procedure TNwtPackageSelection.SetOrderingMethod(
  const Value: TNewtonOrderingMethod);
begin
  if FOrderingMethod <> Value then
  begin
    FOrderingMethod := Value;
    InvalidateModel;
  end;
end;

procedure TNwtPackageSelection.SetPrintFlag(const Value: integer);
begin
  SetIntegerProperty(FPrintFlag , Value);
end;

procedure TNwtPackageSelection.SetRealProperty(Field, NewValue: TRealStorage);
begin
  if Field.Value <> NewValue.Value then
  begin
    Field.Assign(NewValue);
    InvalidateModel;
  end;
end;

procedure TNwtPackageSelection.SetResidReducConv(const Value: TRealStorage);
begin
  SetRealProperty(FResidReducConv , Value);
end;

procedure TNwtPackageSelection.SetSolverMethod(
  const Value: TNewtonSolverMethod);
begin
  if FSolverMethod <> Value then
  begin
    FSolverMethod := Value;
    InvalidateModel;
  end;
end;

procedure TNwtPackageSelection.SetStopTolerance(const Value: TRealStorage);
begin
  SetRealProperty(FStopTolerance , Value);
end;

procedure TNwtPackageSelection.SetThicknessFactor(const Value: TRealStorage);
begin
  SetRealProperty(FThicknessFactor , Value);
end;

procedure TNwtPackageSelection.SetUseDropTolerance(
  const Value: TNewtonUseDropTolerance);
begin
  if FUseDropTolerance <> Value then
  begin
    FUseDropTolerance := Value;
    InvalidateModel;
  end;
end;

procedure TCustomTransientLayerPackageSelection.SetMultiplierArrayNames
  (const Value: TTransientMultCollection);
begin
  FMultiplierArrayNames.Assign(Value);
end;

procedure TCustomTransientLayerPackageSelection.SetZoneArrayNames
  (const Value: TTransientZoneCollection);
begin
  FZoneArrayNames.Assign(Value);
end;

{ TCustomTransientArrayItem }

procedure TCustomTransientArrayItem.Assign(Source: TPersistent);
var
  TransSource: TCustomTransientArrayItem;
begin
  if Source is TCustomTransientArrayItem then
  begin
    TransSource := TCustomTransientArrayItem(Source);
    ArrayName := TransSource.ArrayName;
    FileName := TransSource.FileName;
    Uniform := TransSource.Uniform;
  end
  else
  begin
    inherited;
  end;
end;

{ TTransientMultItem }

procedure TTransientMultItem.Assign(Source: TPersistent);
var
  TransSource: TTransientMultItem;
begin
  if Source is TTransientMultItem then
  begin
    TransSource := TTransientMultItem(Source);
    UniformValue := TransSource.UniformValue
  end;
  inherited;
end;

{ TTransientZoneItem }

procedure TTransientZoneItem.Assign(Source: TPersistent);
var
  TransSource: TTransientZoneItem;
begin
  if Source is TTransientZoneItem then
  begin
    TransSource := TTransientZoneItem(Source);
    UniformValue := TransSource.UniformValue
  end;
  inherited;
end;

{ TTransientMultCollection }

function TTransientMultCollection.Add: TTransientMultItem;
begin
  result := inherited Add as TTransientMultItem;
end;

constructor TTransientMultCollection.Create;
begin
  inherited Create(TTransientMultItem);
end;

function TTransientMultCollection.GetItem(Index: integer): TTransientMultItem;
begin
  result := inherited Items[Index] as TTransientMultItem
end;

procedure TTransientMultCollection.SetItem(Index: integer;
  const Value: TTransientMultItem);
begin
  inherited Items[Index] := Value;
end;

{ TTransientZoneCollection }

function TTransientZoneCollection.Add: TTransientZoneItem;
begin
  result := inherited Add as TTransientZoneItem;
end;

constructor TTransientZoneCollection.Create;
begin
  inherited Create(TTransientZoneItem);
end;

function TTransientZoneCollection.GetItem(Index: integer): TTransientZoneItem;
begin
  result := inherited Items[Index] as TTransientZoneItem;
end;

procedure TTransientZoneCollection.SetItem(Index: integer;
  const Value: TTransientZoneItem);
begin
  inherited Items[Index] := Value;
end;

{ TMt3dBasic }

procedure TMt3dBasic.Assign(Source: TPersistent);
var
  BasicSource: TMt3dBasic;
begin
  if Source is TMt3dBasic then
  begin
    BasicSource := TMt3dBasic(Source);
    StoredMinimumSaturatedFraction :=
      BasicSource.StoredMinimumSaturatedFraction;
    StoredInactiveConcentration := BasicSource.StoredInactiveConcentration;
    StoredMassUnit := BasicSource.StoredMassUnit;

    InitialConcentrationStressPeriod :=
      BasicSource.InitialConcentrationStressPeriod;
    InitialConcentrationTimeStep := BasicSource.InitialConcentrationTimeStep;
    InitialConcentrationTransportStep :=
      BasicSource.InitialConcentrationTransportStep;

  end;
  inherited;
end;

//procedure TMt3dBasic.Changed(Sender: TObject);
//begin
//  InvalidateModel;
//end;

constructor TMt3dBasic.Create(Model: TBaseModel);
begin
  inherited;
  FMinimumSaturatedFraction := TRealStorage.Create;
  FMinimumSaturatedFraction.OnChange := OnValueChanged;

  FInactiveConcentration := TRealStorage.Create;
  FInactiveConcentration.OnChange := OnValueChanged;

  FMassUnit := TStringStorage.Create;
  FMassUnit.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor TMt3dBasic.Destroy;
begin
  FMassUnit.Free;
  FInactiveConcentration.Free;
  FMinimumSaturatedFraction.Free;
  inherited;
end;

function TMt3dBasic.GetInactiveConcentration: double;
begin
  result := StoredInactiveConcentration.Value;
end;

function TMt3dBasic.GetMassUnit: string;
begin
  result := StoredMassUnit.Value;
end;

function TMt3dBasic.GetMinimumSaturatedFraction: double;
begin
  result := StoredMinimumSaturatedFraction.Value;
end;

procedure TMt3dBasic.InitializeVariables;
begin
  inherited;
  IsSelected := False;
  MassUnit := 'g';
  InactiveConcentration := -1e30;
  MinimumSaturatedFraction := 0.01;
  FInitialConcentrationStressPeriod := 1;
  FInitialConcentrationTimeStep := 1;
  FInitialConcentrationTransportStep := 1;
end;

procedure TMt3dBasic.SetInactiveConcentration(const Value: double);
begin
  StoredInactiveConcentration.Value := Value;
end;

procedure TMt3dBasic.SetInitialConcentrationStressPeriod(const Value: Integer);
begin
  SetIntegerProperty(FInitialConcentrationStressPeriod, Value);
end;

procedure TMt3dBasic.SetInitialConcentrationTimeStep(const Value: Integer);
begin
  SetIntegerProperty(FInitialConcentrationTimeStep, Value);
end;

procedure TMt3dBasic.SetInitialConcentrationTransportStep(const Value: Integer);
begin
  SetIntegerProperty(FInitialConcentrationTransportStep, Value);
end;

procedure TMt3dBasic.SetIsSelected(const Value: boolean);
begin
  inherited;
  if FModel <> nil then
  begin
    (FModel as TCustomModel).DataArrayManager.UpdateClassifications;
  end;
  UpdateDataSets;
end;

procedure TMt3dBasic.SetStoredInactiveConcentration(const Value: TRealStorage);
begin
  FInactiveConcentration.Assign(Value)
end;

procedure TMt3dBasic.SetStoredMassUnit(const Value: TStringStorage);
begin
  FMassUnit.Assign(Value)
end;

procedure TMt3dBasic.SetStoredMinimumSaturatedFraction(const Value: TRealStorage);
begin
  FMinimumSaturatedFraction.Assign(Value)
end;

procedure TMt3dBasic.UpdateDataSets;
var
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  if (LocalModel <> nil) and IsSelected then
  begin
    LocalModel.UpdateMt3dmsChemDataSets
//    MobileComponents.UpdateDataArrays;
//    ImMobileComponents.UpdateDataArrays;
    // update diffusion data sets.
  end;
end;

procedure TMt3dBasic.SetMassUnit(const Value: string);
begin
  StoredMassUnit.Value := Value;
end;

procedure TMt3dBasic.SetMinimumSaturatedFraction(const Value: double);
begin
  StoredMinimumSaturatedFraction.Value := Value;
end;

{ TMt3dmsGCGSolverPackage }

procedure TMt3dmsGCGSolverPackage.Assign(Source: TPersistent);
var
  SourceSolver: TMt3dmsGCGSolverPackage;
begin
  if Source is TMt3dmsGCGSolverPackage then
  begin
    SourceSolver := TMt3dmsGCGSolverPackage(Source);
    RelaxationFactor := SourceSolver.RelaxationFactor;
    ConvergenceCriterion := SourceSolver.ConvergenceCriterion;
    MaxOuterIterations := SourceSolver.MaxOuterIterations;
    MaxInnerIterations := SourceSolver.MaxInnerIterations;
    PreconditionerChoice := SourceSolver.PreconditionerChoice;
    DispersionTensorChoice := SourceSolver.DispersionTensorChoice;
    PrintoutInterval := SourceSolver.PrintoutInterval;
  end;
  inherited;

end;

//procedure TMt3dmsGCGSolverPackage.Changed;
//begin
//  InvalidateModel;
//end;

constructor TMt3dmsGCGSolverPackage.Create(Model: TBaseModel);
begin
  inherited;
  FStoredRelaxationFactor := TRealStorage.Create;
  FStoredRelaxationFactor.OnChange := OnValueChanged;
  FStoredConvergenceCriterion := TRealStorage.Create;
  FStoredConvergenceCriterion.OnChange := OnValueChanged;
  InitializeVariables;
end;

destructor TMt3dmsGCGSolverPackage.Destroy;
begin
  FStoredRelaxationFactor.Free;
  FStoredConvergenceCriterion.Free;
  inherited;
end;

function TMt3dmsGCGSolverPackage.GetConvergenceCriterion: double;
begin
  result := StoredConvergenceCriterion.Value;
end;

function TMt3dmsGCGSolverPackage.GetRelaxationFactor: double;
begin
  result := StoredRelaxationFactor.Value;
end;

procedure TMt3dmsGCGSolverPackage.InitializeVariables;
begin
  inherited;
  IsSelected := False;
  FStoredRelaxationFactor.Value := 1;
  FStoredConvergenceCriterion.Value := 1e-6;
  FMaxOuterIterations := 1;
  FMaxInnerIterations := 200;
  FPreconditionerChoice := gpCholesky;
  FDispersionTensorChoice := dtcLump;
  FPrintoutInterval := 1;
end;

procedure TMt3dmsGCGSolverPackage.SetConvergenceCriterion(const Value: double);
begin
  StoredConvergenceCriterion.Value := Value;
end;

procedure TMt3dmsGCGSolverPackage.SetDispersionTensorChoice(
  const Value: TDispersionTensorTreatment);
begin
  if FDispersionTensorChoice <> Value then
  begin
    FDispersionTensorChoice := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsGCGSolverPackage.SetMaxInnerIterations(const Value: integer);
begin
  if FMaxInnerIterations <> Value then
  begin
    FMaxInnerIterations := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsGCGSolverPackage.SetMaxOuterIterations(const Value: integer);
begin
  if FMaxOuterIterations <> Value then
  begin
    FMaxOuterIterations := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsGCGSolverPackage.SetPreconditionerChoice(
  const Value: TGcgPreconditioner);
begin
  if FPreconditionerChoice <> Value then
  begin
    FPreconditionerChoice := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsGCGSolverPackage.SetPrintoutInterval(const Value: integer);
begin
  if FPrintoutInterval <> Value then
  begin
    FPrintoutInterval := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsGCGSolverPackage.SetRelaxationFactor(const Value: double);
begin
  StoredRelaxationFactor.Value := Value;
end;

procedure TMt3dmsGCGSolverPackage.SetStoredConvergenceCriterion(
  const Value: TRealStorage);
begin
  FStoredConvergenceCriterion.Assign(Value);
end;

procedure TMt3dmsGCGSolverPackage.SetStoredRelaxationFactor(
  const Value: TRealStorage);
begin
  FStoredRelaxationFactor.Assign(Value);
end;

{ TMt3dmsAdvection }

procedure TMt3dmsAdvection.Assign(Source: TPersistent);
var
  AdvSource: TMt3dmsAdvection;
begin
  if Source is TMt3dmsAdvection then
  begin
    AdvSource := TMt3dmsAdvection(Source);
    Courant := AdvSource.Courant;
    ConcWeight := AdvSource.ConcWeight;
    RelCelConcGrad := AdvSource.RelCelConcGrad;
    CriticalConcGradient := AdvSource.CriticalConcGradient;
    AdvectionSolution := AdvSource.AdvectionSolution;
    MaximumParticles := AdvSource.MaximumParticles;
    WeightingScheme := AdvSource.WeightingScheme;
    ParticleTrackMethod := AdvSource.ParticleTrackMethod;
    StoredConcWeight := AdvSource.StoredConcWeight;
    StoredRelCelConcGrad := AdvSource.StoredRelCelConcGrad;
    ParticlePlacementMethod := AdvSource.ParticlePlacementMethod;
    NumberOfParticlePlanes := AdvSource.NumberOfParticlePlanes;
    LowGradientParticleCount := AdvSource.LowGradientParticleCount;
    HighGradientParticleCount := AdvSource.HighGradientParticleCount;
    MinParticlePerCell := AdvSource.MinParticlePerCell;
    MaxParticlesPerCell := AdvSource.MaxParticlesPerCell;
    SinkParticlePlacementMethod := AdvSource.SinkParticlePlacementMethod;
    SinkNumberOfParticlePlanes := AdvSource.SinkNumberOfParticlePlanes;
    SinkParticleCount := AdvSource.SinkParticleCount;
  end;
  inherited;
end;

//procedure TMt3dmsAdvection.Changed(Sender: TObject);
//begin
//  InvalidateModel;
//end;

constructor TMt3dmsAdvection.Create(Model: TBaseModel);
begin
  inherited;
  FStoredCourant := TRealStorage.Create;
  FStoredCourant.OnChange := OnValueChanged;

  FStoredConcWeight := TRealStorage.Create;
  FStoredConcWeight.OnChange := OnValueChanged;

  FStoredRelCelConcGrad := TRealStorage.Create;
  FStoredRelCelConcGrad.OnChange := OnValueChanged;

  FStoredCriticalConcGradient := TRealStorage.Create;
  FStoredCriticalConcGradient.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor TMt3dmsAdvection.Destroy;
begin
  FStoredCriticalConcGradient.Free;
  FStoredRelCelConcGrad.Free;
  FStoredConcWeight.Free;
  FStoredCourant.Free;
  inherited;
end;

function TMt3dmsAdvection.GetConcWeight: double;
begin
  result := StoredConcWeight.Value;
end;

function TMt3dmsAdvection.GetCourant: double;
begin
  result := StoredCourant.Value;
end;

function TMt3dmsAdvection.GetCriticalConcGradient: double;
begin
  result := StoredCriticalConcGradient.Value;
end;

function TMt3dmsAdvection.GetRelCelConcGrad: double;
begin
  result := StoredRelCelConcGrad.Value
end;

procedure TMt3dmsAdvection.InitializeVariables;
begin
  inherited;
  Courant := 1;
  ConcWeight := 0.5;
  RelCelConcGrad := 1e-5;
  CriticalConcGradient := 0.01;
  AdvectionSolution := asUltimate;
  MaximumParticles := 75000;
  WeightingScheme  := wsUpstream;
  ParticleTrackMethod := ptmHybrid;
  ParticlePlacementMethod := ppmRandom;
  NumberOfParticlePlanes := 1;
  LowGradientParticleCount := 0;
  HighGradientParticleCount := 10;
  MinParticlePerCell := 2;
  MaxParticlesPerCell := 20;
  SinkParticlePlacementMethod := ppmRandom;
  SinkNumberOfParticlePlanes := 1;
  SinkParticleCount := 10;
end;

procedure TMt3dmsAdvection.SetAdvectionSolution(
  const Value: TAdvectionSolution);
begin
  if FAdvectionSolution <> Value then
  begin
    FAdvectionSolution := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetConcWeight(const Value: double);
begin
  StoredConcWeight.Value := Value;
end;

procedure TMt3dmsAdvection.SetCourant(const Value: double);
begin
  StoredCourant.Value := Value;
end;

procedure TMt3dmsAdvection.SetCriticalConcGradient(const Value: double);
begin
  StoredCriticalConcGradient.Value := Value;
end;

procedure TMt3dmsAdvection.SetHighGradientParticleCount(const Value: integer);
begin
  if FHighGradientParticleCount <> Value then
  begin
    FHighGradientParticleCount := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetLowGradientParticleCount(const Value: integer);
begin
  if FLowGradientParticleCount <> Value then
  begin
    FLowGradientParticleCount := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetMaximumParticles(const Value: integer);
begin
  if FMaximumParticles <> Value then
  begin
    FMaximumParticles := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetMaxParticlesPerCell(const Value: integer);
begin
  if FMaxParticlesPerCell <> Value then
  begin
    FMaxParticlesPerCell := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetMinParticlePerCell(const Value: integer);
begin
  if FMinParticlePerCell <> Value then
  begin
    FMinParticlePerCell := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetNumberOfParticlePlanes(const Value: integer);
begin
  if FNumberOfParticlePlanes <> Value then
  begin
    FNumberOfParticlePlanes := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetParticlePlacementMethod(
  const Value: TParticlePlacementMethod);
begin
  if FParticlePlacementMethod <> Value then
  begin
    FParticlePlacementMethod := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetParticleTrackMethod(
  const Value: TParticleTrackMethod);
begin
  if FParticleTrackMethod <> Value then
  begin
    FParticleTrackMethod := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetRelCelConcGrad(const Value: double);
begin
  StoredRelCelConcGrad.Value := Value;
end;

procedure TMt3dmsAdvection.SetSinkNumberOfParticlePlanes(const Value: integer);
begin
  if FSinkNumberOfParticlePlanes <> Value then
  begin
    FSinkNumberOfParticlePlanes := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetSinkParticleCount(const Value: integer);
begin
  if FSinkParticleCount <> Value then
  begin
    FSinkParticleCount := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetSinkParticlePlacementMethod(
  const Value: TParticlePlacementMethod);
begin
  if FSinkParticlePlacementMethod <> Value then
  begin
    FSinkParticlePlacementMethod := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsAdvection.SetStoredConcWeight(const Value: TRealStorage);
begin
  FStoredConcWeight.Assign(Value);
end;

procedure TMt3dmsAdvection.SetStoredCourant(const Value: TRealStorage);
begin
  FStoredCourant.Assign(Value);
end;

procedure TMt3dmsAdvection.SetStoredCriticalConcGradient(
  const Value: TRealStorage);
begin
  FStoredCriticalConcGradient.Assign(Value);
end;

procedure TMt3dmsAdvection.SetStoredRelCelConcGrad(const Value: TRealStorage);
begin
  FStoredRelCelConcGrad.Assign(Value);
end;

procedure TMt3dmsAdvection.SetWeightingScheme(const Value: TWeightingScheme);
begin
  if FWeightingScheme <> Value then
  begin
    FWeightingScheme := Value;
    InvalidateModel;
  end;
end;

{ TMt3dmsDispersion }

procedure TMt3dmsDispersion.Assign(Source: TPersistent);
begin
  if Source is TMt3dmsDispersion then
  begin
    MultiDifussion := TMt3dmsDispersion(Source).MultiDifussion;
  end;
  inherited;
end;

constructor TMt3dmsDispersion.Create(Model: TBaseModel);
begin
  inherited;
  InitializeVariables;
end;

procedure TMt3dmsDispersion.InitializeVariables;
begin
  inherited;
  MultiDifussion := False;
end;

procedure TMt3dmsDispersion.SetIsSelected(const Value: boolean);
begin
  inherited;
  UpdateDataSets;
end;

procedure TMt3dmsDispersion.SetMultiDifussion(const Value: boolean);
begin
  if FMultiDifussion <> Value then
  begin
    FMultiDifussion := Value;
    InvalidateModel;
    UpdateDataSets;
  end;
end;

procedure TMt3dmsDispersion.UpdateDataSets;
var
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  if (LocalModel <> nil) and IsSelected
    and (LocalModel.MobileComponents <> nil) then
  begin
    LocalModel.MobileComponents.UpdateDataArrays;
    // update diffusion data sets.
  end;
end;

{ TMt3dmsChemReaction }

procedure TMt3dmsChemReaction.Assign(Source: TPersistent);
var
  React: TMt3dmsChemReaction;
begin
  if Source is TMt3dmsChemReaction then
  begin
    React := TMt3dmsChemReaction(Source);
    SorptionChoice := React.SorptionChoice;
    KineticChoice := React.KineticChoice;
    OtherInitialConcChoice := React.OtherInitialConcChoice;
  end;
  inherited;
end;

constructor TMt3dmsChemReaction.Create(Model: TBaseModel);
begin
  inherited;
  InitializeVariables;
end;

procedure TMt3dmsChemReaction.InitializeVariables;
begin
  inherited;
  SorptionChoice := scLinear;
  KineticChoice := kcNone;
  OtherInitialConcChoice := oicDontUse;
end;

procedure TMt3dmsChemReaction.SetIsSelected(const Value: boolean);
begin
  inherited;
  UpdateDataSets;
end;

procedure TMt3dmsChemReaction.SetKineticChoice(const Value: TKineticChoice);
begin
  if FKineticChoice <> Value then
  begin
    FKineticChoice := Value;
    InvalidateModel;
    UpdateDataSets;
  end;
end;

procedure TMt3dmsChemReaction.SetOtherInitialConcChoice(
  const Value: TOtherInitialConcChoice);
begin
  if FOtherInitialConcChoice <> Value then
  begin
    FOtherInitialConcChoice := Value;
    InvalidateModel;
    UpdateDataSets;
  end;
end;

procedure TMt3dmsChemReaction.SetSorptionChoice(const Value: TSorptionChoice);
begin
  if FSorptionChoice <> Value then
  begin
    FSorptionChoice := Value;
    InvalidateModel;
    UpdateDataSets;
  end;
end;

procedure TMt3dmsChemReaction.UpdateDataSets;
var
  LocalModel: TCustomModel;
begin
  LocalModel := FModel as TCustomModel;
  if (LocalModel <> nil) and IsSelected then
  begin
    LocalModel.ModflowPackages.Mt3dBasic.UpdateDataSets;
    // update diffusion data sets.
  end;
end;

{ TMt3dmsTransportObservations }

procedure TMt3dmsTransportObservations.Assign(Source: TPersistent);
var
  TransObsSource: TMt3dmsTransportObservations;
begin
  if Source is TMt3dmsTransportObservations then
  begin
    TransObsSource := TMt3dmsTransportObservations(Source);
    ConcScaleFactor := TransObsSource.ConcScaleFactor;
    SaveBinary := TransObsSource.SaveBinary;
    ConcObsResult := TransObsSource.ConcObsResult;
    TransformType := TransObsSource.TransformType;
    InterpolateObs := TransObsSource.InterpolateObs;
    FluxScaleFactor := TransObsSource.FluxScaleFactor;
    MassFluxObsResult := TransObsSource.MassFluxObsResult;

  end;
  inherited;
end;

//procedure TMt3dmsTransportObservations.Changed(Sender: TObject);
//begin
//  InvalidateModel;
//end;

constructor TMt3dmsTransportObservations.Create(Model: TBaseModel);
begin
  inherited;
  FStoredConcScaleFactor := TRealStorage.Create;
  FStoredConcScaleFactor.OnChange := OnValueChanged;
  FStoredFluxScaleFactor := TRealStorage.Create;
  FStoredFluxScaleFactor.OnChange := OnValueChanged;
  InitializeVariables;
end;

destructor TMt3dmsTransportObservations.Destroy;
begin
  FStoredFluxScaleFactor.Free;
  FStoredConcScaleFactor.Free;
  inherited;
end;

function TMt3dmsTransportObservations.GetConcScaleFactor: double;
begin
  Result := StoredConcScaleFactor.Value;
end;

function TMt3dmsTransportObservations.GetFluxScaleFactor: double;
begin
  Result := StoredFluxScaleFactor.Value;
end;

procedure TMt3dmsTransportObservations.InitializeVariables;
begin
  inherited;
  ConcScaleFactor := 1;
  FluxScaleFactor := 1;
  SaveBinary := sbSave;
  ConcObsResult := corConcResid;
  TransformType := ltNoConversion;
  InterpolateObs := ioBilinear;
  MassFluxObsResult := mfoMassFluxResid;
end;

procedure TMt3dmsTransportObservations.SetConcObsResult(
  const Value: TConcObsResult);
begin
  if FConcObsResult <> Value then
  begin
    FConcObsResult := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsTransportObservations.SetConcScaleFactor(const Value: double);
begin
  StoredConcScaleFactor.Value := Value;
end;

procedure TMt3dmsTransportObservations.SetFluxScaleFactor(const Value: double);
begin
  StoredFluxScaleFactor.Value := Value;
end;

procedure TMt3dmsTransportObservations.SetInterpolateObs(
  const Value: TInterpolateObs);
begin
  if FInterpolateObs <> Value then
  begin
    FInterpolateObs := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsTransportObservations.SetMassFluxObsResult(
  const Value: TMassFluxObsResult);
begin
  FMassFluxObsResult := Value;
end;

procedure TMt3dmsTransportObservations.SetSaveBinary(const Value: TSaveBinary);
begin
  if FSaveBinary <> Value then
  begin
    FSaveBinary := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dmsTransportObservations.SetStoredConcScaleFactor(
  const Value: TRealStorage);
begin
  FStoredConcScaleFactor.Assign(Value);
end;

procedure TMt3dmsTransportObservations.SetStoredFluxScaleFactor(
  const Value: TRealStorage);
begin
  FStoredFluxScaleFactor.Assign(Value);
end;

procedure TMt3dmsTransportObservations.SetTransformType(
  const Value: TTransformType);
begin
  if FTransformType <> Value then
  begin
    FTransformType := Value;
    InvalidateModel;
  end;
end;

{ TMt3dmsSourceSinkMixing }

constructor TMt3dmsSourceSinkMixing.Create(Model: TBaseModel);
begin
  inherited;
  if Model <> nil then
  begin
    FConcentrations := TModflowBoundaryDisplayTimeList.Create(Model);
    Concentrations.OnInitialize := InitializeConcentrationDisplay;
    Concentrations.OnGetUseList := GetConcentrationUseList;
    Concentrations.OnTimeListUsed := PackageUsed;
    Concentrations.Name := StrMT3DMSSSMConcentra;
    AddTimeList(Concentrations);
  end;
end;

destructor TMt3dmsSourceSinkMixing.Destroy;
begin
  FConcentrations.Free;
  inherited;
end;

procedure TMt3dmsSourceSinkMixing.GetConcentrationUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  PhastModel: TCustomModel;
  Boundary: TMt3dmsConcBoundary;
begin
  PhastModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to PhastModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := PhastModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.Mt3dmsConcBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TMt3dmsSourceSinkMixing.InitializeConcentrationDisplay(Sender: TObject);
var
  SsmWriter: TMt3dmsSsmWriter;
  List: TModflowBoundListOfTimeLists;
begin
  FConcentrations.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  SsmWriter := TMt3dmsSsmWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(FConcentrations);
    SsmWriter.UpdateDisplay(List);
  finally
    SsmWriter.Free;
    List.Free;
  end;
  FConcentrations.ComputeAverage;
end;

{ TPcgnSelection }

procedure TPcgnSelection.Assign(Source: TPersistent);
var
  PcgnSource: TPcgnSelection;
begin
  if Source is TPcgnSelection then
  begin
    PcgnSource := TPcgnSelection(Source);
    ITER_MO := PcgnSource.ITER_MO;
    ITER_MI := PcgnSource.ITER_MI;
    CLOSE_R := PcgnSource.CLOSE_R;
    CLOSE_H := PcgnSource.CLOSE_H;
    RELAX := PcgnSource.RELAX;
    IFILL := PcgnSource.IFILL;
    UNIT_PC := PcgnSource.UNIT_PC;
    UNIT_TS := PcgnSource.UNIT_TS;
    ADAMP := PcgnSource.ADAMP;
    DAMP := PcgnSource.DAMP;
    DAMP_LB := PcgnSource.DAMP_LB;
    RATE_D := PcgnSource.RATE_D;
    CHGLIMIT := PcgnSource.CHGLIMIT;
    ACNVG := PcgnSource.ACNVG;
    CNVG_LB := PcgnSource.CNVG_LB;
    MCNVG := PcgnSource.MCNVG;
    RATE_C := PcgnSource.RATE_C;
    IPUNIT := PcgnSource.IPUNIT;
  end;
  inherited;
end;

constructor TPcgnSelection.Create(Model: TBaseModel);
begin
  inherited;
  FCHGLIMIT := TRealStorage.Create;
  FCHGLIMIT.OnChange := OnValueChanged;

  FCLOSE_R := TRealStorage.Create;
  FCLOSE_R.OnChange := OnValueChanged;

  FRELAX := TRealStorage.Create;
  FRELAX.OnChange := OnValueChanged;

  FRATE_C := TRealStorage.Create;
  FRATE_C.OnChange := OnValueChanged;

  FCLOSE_H := TRealStorage.Create;
  FCLOSE_H.OnChange := OnValueChanged;

  FRATE_D := TRealStorage.Create;
  FRATE_D.OnChange := OnValueChanged;

  FCNVG_LB := TRealStorage.Create;
  FCNVG_LB.OnChange := OnValueChanged;

  FDAMP_LB := TRealStorage.Create;
  FDAMP_LB.OnChange := OnValueChanged;

  FDAMP := TRealStorage.Create;
  FDAMP.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor TPcgnSelection.Destroy;
begin
  FDAMP.Free;
  FDAMP_LB.Free;
  FCNVG_LB.Free;
  FRATE_D.Free;
  FCLOSE_H.Free;
  FRATE_C.Free;
  FRELAX.Free;
  FCLOSE_R.Free;
  FCHGLIMIT.Free;
  inherited;
end;

procedure TPcgnSelection.InitializeVariables;
begin
  inherited;
  ITER_MO := 50;
  ITER_MI := 20;
  CLOSE_R.Value := 0.001;
  CLOSE_H.Value := 0.00001;

  RELAX.Value := 0.99;
  IFILL := 0;
  UNIT_PC := False;
  UNIT_TS := False;

  ADAMP := dOrdinary;
  DAMP.Value := 0.5;
  DAMP_LB.Value := 0.1;
  RATE_D.Value := 0.05;
  CHGLIMIT.Value := 0;

  ACNVG := cmStandard;
  CNVG_LB.Value := 0.01;
  MCNVG := 2;
  RATE_C.Value := 0.1;
  IPUNIT := prListing;
end;

procedure TPcgnSelection.SetACNVG(const Value: TConvergenceMode);
begin
  if FACNVG <> Value then
  begin
    FACNVG := Value;
    InvalidateModel;
  end;
end;

procedure TPcgnSelection.SetADAMP(const Value: TDamping);
begin
  if FADAMP <> Value then
  begin
    FADAMP := Value;
    InvalidateModel;
  end;
end;

procedure TPcgnSelection.SetCHGLIMIT(const Value: TRealStorage);
begin
  FCHGLIMIT.Assign(Value);
end;

procedure TPcgnSelection.SetCLOSE_H(const Value: TRealStorage);
begin
  FCLOSE_H.Assign(Value);
end;

procedure TPcgnSelection.SetCLOSE_R(const Value: TRealStorage);
begin
  FCLOSE_R.Assign(Value);
end;

procedure TPcgnSelection.SetCNVG_LB(const Value: TRealStorage);
begin
  FCNVG_LB.Assign(Value);
end;

procedure TPcgnSelection.SetDAMP(const Value: TRealStorage);
begin
  FDAMP.Assign(Value);
end;

procedure TPcgnSelection.SetDAMP_LB(const Value: TRealStorage);
begin
  FDAMP_LB.Assign(Value);
end;

procedure TPcgnSelection.SetIFILL(const Value: integer);
begin
  SetIntegerProperty(FIFILL, Value);
end;

procedure TPcgnSelection.SetIPUNIT(const Value: TProgressReporting);
begin
  if FIPUNIT <> Value then
  begin
    FIPUNIT := Value;
    InvalidateModel;
  end;
end;

procedure TPcgnSelection.SetITER_MI(const Value: integer);
begin
  SetIntegerProperty(FITER_MI, Value);
end;

procedure TPcgnSelection.SetITER_MO(const Value: integer);
begin
  SetIntegerProperty(FITER_MO, Value);
end;

procedure TPcgnSelection.SetMCNVG(const Value: integer);
begin
  SetIntegerProperty(FMCNVG, Value);
end;

procedure TPcgnSelection.SetRATE_C(const Value: TRealStorage);
begin
  FRATE_C.Assign(Value);
end;

procedure TPcgnSelection.SetRATE_D(const Value: TRealStorage);
begin
  FRATE_D.Assign(Value);
end;

procedure TPcgnSelection.SetRELAX(const Value: TRealStorage);
begin
  FRELAX.Assign(Value);
end;

procedure TPcgnSelection.SetUNIT_PC(const Value: boolean);
begin
  SetBooleanProperty(FUNIT_PC, Value);
end;

procedure TPcgnSelection.SetUNIT_TS(const Value: boolean);
begin
  SetBooleanProperty(FUNIT_TS, Value);
end;

procedure TModflowPackageSelection.OnValueChanged(Sender: TObject);
begin
  InvalidateModel;
end;

{ TStrPackageSelection }

procedure TStrPackageSelection.Assign(Source: TPersistent);
var
  Str: TStrPackageSelection;
begin
  if Source is TStrPackageSelection then
  begin
    Str := TStrPackageSelection(Source);
    CalculateStage := Str.CalculateStage;
  end;
  inherited;

end;

constructor TStrPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  if Model <> nil then
  begin
    FMfStrSegmentNumber := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrSegmentNumber.OnTimeListUsed := PackageUsed;
    FMfStrSegmentNumber.OnInitialize := InitializeStrDisplay;
    FMfStrSegmentNumber.OnGetUseList := GetMfStrUseList;
    FMfStrSegmentNumber.Name := StrModflowStrSegment;
    AddTimeList(FMfStrSegmentNumber);

    FMfStrReachNumber := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrReachNumber.OnTimeListUsed := PackageUsed;
    FMfStrReachNumber.OnInitialize := InitializeStrDisplay;
    FMfStrReachNumber.OnGetUseList := GetMfStrUseList;
    FMfStrReachNumber.Name := StrModflowStrReach;
    AddTimeList(FMfStrReachNumber);

    FMfStrOutflowSegmentNumber := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrOutflowSegmentNumber.OnTimeListUsed := PackageUsed;
    FMfStrOutflowSegmentNumber.OnInitialize := InitializeStrDisplay;
    FMfStrOutflowSegmentNumber.OnGetUseList := GetMfStrUseList;
    FMfStrOutflowSegmentNumber.Name := StrModflowStrDownstreamSegment;
    AddTimeList(FMfStrOutflowSegmentNumber);

    FMfStrDiversionSegmentNumber := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrDiversionSegmentNumber.OnTimeListUsed := PackageUsed;
    FMfStrDiversionSegmentNumber.OnInitialize := InitializeStrDisplay;
    FMfStrDiversionSegmentNumber.OnGetUseList := GetMfStrUseList;
    FMfStrDiversionSegmentNumber.Name := StrModflowStrDiversionSegment;
    AddTimeList(FMfStrDiversionSegmentNumber);



    FMfStrBedTopElevation := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrBedTopElevation.OnInitialize := InitializeStrDisplay;
    FMfStrBedTopElevation.OnGetUseList := GetMfStrBedTopElevationUseList;
    FMfStrBedTopElevation.OnTimeListUsed := PackageUsed;
    FMfStrBedTopElevation.Name := StrSTRStreamTopElev;
    AddTimeList(FMfStrBedTopElevation);

    FMfStrBedBottomElevation := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrBedBottomElevation.OnInitialize := InitializeStrDisplay;
    FMfStrBedBottomElevation.OnGetUseList := GetMfStrBedBottomElevationUseList;
    FMfStrBedBottomElevation.OnTimeListUsed := PackageUsed;
    FMfStrBedBottomElevation.Name := StrSTRStreamBottomElev;
    AddTimeList(FMfStrBedBottomElevation);

    FMfStrStage := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrStage.OnInitialize := InitializeStrDisplay;
    FMfStrStage.OnGetUseList := GetMfStrStageUseList;
    FMfStrStage.OnTimeListUsed := StageUsed;
    FMfStrStage.Name := StrSTRStreamStage;
    AddTimeList(FMfStrStage);

    FMfStrConductance := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrConductance.OnInitialize := InitializeStrDisplay;
    FMfStrConductance.OnGetUseList := GetMfStrConductanceUseList;
    FMfStrConductance.OnTimeListUsed := PackageUsed;
    FMfStrConductance.Name := StrSTRStreamConductance;
    AddTimeList(FMfStrConductance);

    FMfStrFlow := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrFlow.OnInitialize := InitializeStrDisplay;
    FMfStrFlow.OnGetUseList := GetMfStrFlowUseList;
    FMfStrFlow.OnTimeListUsed := PackageUsed;
    FMfStrFlow.Name := StrSTRStreamFlow;
    AddTimeList(FMfStrFlow);

    FMfStrWidth := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrWidth.OnInitialize := InitializeStrDisplay;
    FMfStrWidth.OnGetUseList := GetMfStrWidthUseList;
    FMfStrWidth.OnTimeListUsed := PackageUsed;
    FMfStrWidth.Name := StrSTRStreamWidth;
    AddTimeList(FMfStrWidth);

    FMfStrSlope := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrSlope.OnInitialize := InitializeStrDisplay;
    FMfStrSlope.OnGetUseList := GetMfStrSlopeUseList;
    FMfStrSlope.OnTimeListUsed := PackageUsed;
    FMfStrSlope.Name := StrSTRStreamSlope;
    AddTimeList(FMfStrSlope);

    FMfStrRoughness := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStrRoughness.OnInitialize := InitializeStrDisplay;
    FMfStrRoughness.OnGetUseList := GetMfStrRoughnessUseList;
    FMfStrRoughness.OnTimeListUsed := PackageUsed;
    FMfStrRoughness.Name := StrSTRStreamRoughness;
    AddTimeList(FMfStrRoughness);
  end;
  InitializeVariables;

end;

destructor TStrPackageSelection.Destroy;
begin
  FMfStrWidth.Free;
  FMfStrSlope.Free;
  FMfStrRoughness.Free;
  FMfStrBedTopElevation.Free;
  FMfStrBedBottomElevation.Free;
  FMfStrStage.Free;
  FMfStrConductance.Free;
  FMfStrFlow.Free;
  FMfStrSegmentNumber.Free;
  FMfStrReachNumber.Free;
  FMfStrOutflowSegmentNumber.Free;
  FMfStrDiversionSegmentNumber.Free;
  inherited;
end;

procedure TStrPackageSelection.GetMfStrBedBottomElevationUseList(
  Sender: TObject; NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptStr, StreamBedBottomPosition, StrSTRStreamBottomElev);
end;

procedure TStrPackageSelection.GetMfStrUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  // do nothing
end;

procedure TStrPackageSelection.GetMfStrBedTopElevationUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptStr, StreamBedTopPosition, StrSTRStreamTopElev);
end;

procedure TStrPackageSelection.GetMfStrConductanceUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptStr, StreamConductancePosition, StrSTRStreamConductance);
end;

procedure TStrPackageSelection.GetMfStrFlowUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptStr, StreamFlowPosition, StrSTRStreamFlow);
end;

procedure TStrPackageSelection.GetMfStrRoughnessUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptStr, StreamRoughnessPosition, StrSTRStreamRoughness);
end;

procedure TStrPackageSelection.GetMfStrSlopeUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptStr, StreamSlopePosition, StrSTRStreamSlope);
end;

procedure TStrPackageSelection.GetMfStrStageUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptStr, StreamStagePosition, StrSTRStreamStage);
end;

procedure TStrPackageSelection.GetMfStrWidthUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptStr, StreamWidthPosition, StrSTRStreamWidth);
end;

procedure TStrPackageSelection.InitializeStrDisplay(Sender: TObject);
var
  StrWriter: TStrWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfStrSegmentNumber.CreateDataSets;
  MfStrReachNumber.CreateDataSets;
  MfStrOutflowSegmentNumber.CreateDataSets;
  MfStrDiversionSegmentNumber.CreateDataSets;
  MfStrFlow.CreateDataSets;
  MfStrStage.CreateDataSets;
  MfStrConductance.CreateDataSets;
  MfStrBedBottomElevation.CreateDataSets;
  MfStrBedTopElevation.CreateDataSets;
  MfStrWidth.CreateDataSets;
  MfStrSlope.CreateDataSets;
  MfStrRoughness.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  StrWriter := TStrWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfStrSegmentNumber);
    List.Add(MfStrReachNumber);
    List.Add(MfStrOutflowSegmentNumber);
    List.Add(MfStrDiversionSegmentNumber);
    List.Add(MfStrFlow);
    List.Add(MfStrStage);
    List.Add(MfStrConductance);
    List.Add(MfStrBedBottomElevation);
    List.Add(MfStrBedTopElevation);
    List.Add(MfStrWidth);
    List.Add(MfStrSlope);
    List.Add(MfStrRoughness);
    StrWriter.UpdateDisplay(List);
  finally
    StrWriter.Free;
    List.Free;
  end;

  MfStrSegmentNumber.ComputeAverage;
  MfStrReachNumber.ComputeAverage;
  MfStrOutflowSegmentNumber.ComputeAverage;
  MfStrDiversionSegmentNumber.ComputeAverage;
  MfStrFlow.ComputeAverage;
  MfStrStage.ComputeAverage;
  MfStrConductance.ComputeAverage;
  MfStrBedBottomElevation.ComputeAverage;
  MfStrBedTopElevation.ComputeAverage;
  MfStrWidth.ComputeAverage;
  MfStrSlope.ComputeAverage;
  MfStrRoughness.ComputeAverage;
end;

procedure TStrPackageSelection.InitializeVariables;
begin
  inherited;
  FCalculateStage := False;
end;

procedure TStrPackageSelection.InvalidateAllTimeLists;
begin
  inherited;
  MfStrSegmentNumber.Invalidate;
  MfStrOutflowSegmentNumber.Invalidate;
  MfStrDiversionSegmentNumber.Invalidate;
  MfStrReachNumber.Invalidate;
  MfStrBedTopElevation.Invalidate;
  MfStrBedBottomElevation.Invalidate;
  MfStrStage.Invalidate;
  MfStrConductance.Invalidate;
  MfStrFlow.Invalidate;

  MfStrRoughness.Invalidate;
  MfStrSlope.Invalidate;
  MfStrWidth.Invalidate;

end;

procedure TStrPackageSelection.SetCalculateStage(const Value: Boolean);
begin
  FCalculateStage := Value;
end;

function TStrPackageSelection.StageUsed(Sender: TObject): boolean;
begin
  result := PackageUsed(Sender) and not CalculateStage;
end;

{ TFhbPackageSelection }

procedure TFhbPackageSelection.Assign(Source: TPersistent);
begin
  if Source is TFhbPackageSelection then
  begin
    SteadyStateInterpolation :=
      TFhbPackageSelection(Source).SteadyStateInterpolation;
  end;
  inherited;
end;

constructor TFhbPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  InitializeVariables;

  if Model <> nil then
  begin
    FMfFhbHeads := TModflowBoundaryDisplayTimeList.Create(Model);
    MfFhbHeads.OnInitialize := InitializeFhbDisplay;
    MfFhbHeads.OnGetUseList := GetMfFhbHeadUseList;
    MfFhbHeads.OnTimeListUsed := PackageUsed;
    MfFhbHeads.Name := StrMODFLOWFHBHeads;
    AddTimeList(MfFhbHeads);

    FMfFhbFlows := TModflowBoundaryDisplayTimeList.Create(Model);
    MfFhbFlows.OnInitialize := InitializeFhbDisplay;
    MfFhbFlows.OnGetUseList := GetMfFhbFlowUseList;
    MfFhbFlows.OnTimeListUsed := PackageUsed;
    MfFhbFlows.Name := StrMODFLOWFHBFlows;
    AddTimeList(MfFhbFlows);
  end;

end;

destructor TFhbPackageSelection.Destroy;
begin
  FMfFhbHeads.Free;
  FMfFhbFlows.Free;
  inherited;
end;

procedure TFhbPackageSelection.GetMfFhbFlowUseList(Sender: TObject;
  NewUseList: TStringList);
begin

end;

procedure TFhbPackageSelection.GetMfFhbHeadUseList(Sender: TObject;
  NewUseList: TStringList);
begin

end;

procedure TFhbPackageSelection.InitializeFhbDisplay(Sender: TObject);
var
  FhbWriter: TModflowFhbWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfFhbHeads.CreateDataSets;
  FMfFhbFlows.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  FhbWriter := TModflowFhbWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfFhbHeads);
    List.Add(FMfFhbFlows);
    FhbWriter.UpdateDisplay(List);
  finally
    FhbWriter.Free;
    List.Free;
  end;
  MfFhbHeads.ComputeAverage;
  FMfFhbFlows.ComputeAverage;


end;

procedure TFhbPackageSelection.InitializeVariables;
begin
  inherited;
  SteadyStateInterpolation := fssiNoInterpolation;
end;

procedure TFhbPackageSelection.SetSteadyStateInterpolation(
  const Value: TFhbSteadyStateInterpolation);
begin
  if FSteadyStateInterpolation <> Value then
  begin
    FSteadyStateInterpolation := Value;
    InvalidateModel;
  end;
end;

{ TFarmProcess }

procedure TFarmProcess.Assign(Source: TPersistent);
var
  SourceFarm: TFarmProcess;
begin
  if Source is TFarmProcess then
  begin
    SourceFarm := TFarmProcess(Source);
    RootingDepth := SourceFarm.RootingDepth;
    ConsumptiveUse := SourceFarm.ConsumptiveUse;
    Precipitation := SourceFarm.Precipitation;
    FractionOfInefficiencyLosses := SourceFarm.FractionOfInefficiencyLosses;
    EfficiencyGroundwaterFunction := SourceFarm.EfficiencyGroundwaterFunction;
    EfficiencyReset := SourceFarm.EfficiencyReset;
    DeficiencyPolicy := SourceFarm.DeficiencyPolicy;
    GroundwaterAllotmentsUsed := SourceFarm.GroundwaterAllotmentsUsed;
    CropConsumptiveConcept := SourceFarm.CropConsumptiveConcept;
    CropConsumptiveLinkage := SourceFarm.CropConsumptiveLinkage;
    SurfaceWaterAllotment := SourceFarm.SurfaceWaterAllotment;
    SaveWellFlowRates := SourceFarm.SaveWellFlowRates;
    SaveNetRecharge := SourceFarm.SaveNetRecharge;
    SupplyAndDemand := SourceFarm.SupplyAndDemand;
    FarmBudgetPrintFlags := SourceFarm.FarmBudgetPrintFlags;
    FarmBudgetPrintHowMuch := SourceFarm.FarmBudgetPrintHowMuch;
    EtPrintLocation := SourceFarm.EtPrintLocation;
    EtPrintType := SourceFarm.EtPrintType;
    PrintRouting := SourceFarm.PrintRouting;
    PrintRoutingFrequency := SourceFarm.PrintRoutingFrequency;
    AcerageOptimizationPrintChoice := SourceFarm.AcerageOptimizationPrintChoice;
    AcerageOptimizationPrintLocation := SourceFarm.AcerageOptimizationPrintLocation;
    DiversionBudgetLocation := SourceFarm.DiversionBudgetLocation;
    CropIrrigationRequirement := SourceFarm.CropIrrigationRequirement;
    RoutedDelivery := SourceFarm.RoutedDelivery;
    RoutedReturn := SourceFarm.RoutedReturn;
    AssignmentMethod := SourceFarm.AssignmentMethod;
    SurfaceWaterClosure := SourceFarm.SurfaceWaterClosure;
    RecomputeOption := SourceFarm.RecomputeOption;
    ResetMnwQMax := SourceFarm.ResetMnwQMax;
    MnwClose := SourceFarm.MnwClose;
    MnwClosureCriterion := SourceFarm.MnwClosureCriterion;
    HeadChangeReduction := SourceFarm.HeadChangeReduction;
    ResidualChangeReduction := SourceFarm.ResidualChangeReduction;
    PsiRampf := SourceFarm.PsiRampf;
    SatThick := SourceFarm.SatThick;
//    WellFieldOption := SourceFarm.WellFieldOption;
  end;
  inherited;

end;

constructor TFarmProcess.Create(Model: TBaseModel);
begin
  inherited;
  FStoredSurfaceWaterClosure := TRealStorage.Create;
  FStoredSurfaceWaterClosure.OnChange := OnValueChanged;
  FStoredMnwClosureCriterion := TRealStorage.Create;
  FStoredMnwClosureCriterion.OnChange := OnValueChanged;
  FStoredResidualChangeReduction := TRealStorage.Create;
  FStoredResidualChangeReduction.OnChange := OnValueChanged;
  FStoredHeadChangeReduction := TRealStorage.Create;
  FStoredHeadChangeReduction.OnChange := OnValueChanged;
  FStoredPsiRampf := TRealStorage.Create;
  FStoredPsiRampf.OnChange := OnValueChanged;
  FStoredSatThick := TRealStorage.Create;
  FStoredSatThick.OnChange := OnValueChanged;

  InitializeVariables;

  if Model <> nil then
  begin
    FMfFmpEvapRate := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfFmpEvapRate.OnInitialize := InitializeFarmRefEtDisplay;
    FMfFmpEvapRate.OnGetUseList := GetMfFmpEvapUseList;
    FMfFmpEvapRate.OnTimeListUsed := EvapUsed;
    FMfFmpEvapRate.Name := StrFarmEvap;
    AddTimeList(FMfFmpEvapRate);

    FMfFmpPrecip := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfFmpPrecip.OnInitialize := InitializeFarmPrecipDisplay;
    FMfFmpPrecip.OnGetUseList := GetMfFmpPrecipUseList;
    FMfFmpPrecip.OnTimeListUsed := PrecipUsed;
    FMfFmpPrecip.Name := StrFarmPrecip;
    AddTimeList(FMfFmpPrecip);

    FMfFmpFarmID := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfFmpFarmID.OnInitialize := InitializeFarmIdDisplay;
    FMfFmpFarmID.OnGetUseList := GetMfFmpFarmIDUseList;
    FMfFmpFarmID.OnTimeListUsed := FarmIdUsed;
    FMfFmpFarmID.Name := StrFarmID2;
    FMfFmpFarmID.DataType := rdtInteger;
    FMfFmpFarmID.AddMethod := vamReplace;
    FMfFmpFarmID.Orientation := dsoTop;
    AddTimeList(FMfFmpFarmID);

    FMfFmpCropID := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfFmpCropID.OnInitialize := InitializeFarmCropIdDisplay;
    FMfFmpCropID.OnGetUseList := GetMfFmpCropIDUseList;
    FMfFmpCropID.OnTimeListUsed := CropIdUsed;
    FMfFmpCropID.Name := StrFarmCropID;
    FMfFmpCropID.DataType := rdtInteger;
    FMfFmpCropID.AddMethod := vamReplace;
    FMfFmpCropID.Orientation := dsoTop;
    AddTimeList(FMfFmpCropID);

    FMfFmpMaxPumpingRate := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfFmpMaxPumpingRate.OnInitialize := InitializeFarmWellDisplay;
    FMfFmpMaxPumpingRate.OnGetUseList := GetMfFmpMaxPumpRateUseList;
    FMfFmpMaxPumpingRate.OnTimeListUsed := FarmWellsUsed;
    FMfFmpMaxPumpingRate.Name := StrFarmMaxPumpRate;
    AddTimeList(FMfFmpMaxPumpingRate);

    FMfFmpFarmWellFarmID := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfFmpFarmWellFarmID.OnInitialize := InitializeFarmWellDisplay;
    FMfFmpFarmWellFarmID.OnGetUseList := GetMfFmpFarmWellFarmIDUseList;
    FMfFmpFarmWellFarmID.OnTimeListUsed := FarmWellsUsed;
    FMfFmpFarmWellFarmID.Name := StrFarmWellFarmID;
    AddTimeList(FMfFmpFarmWellFarmID);

    FMfFmpFarmWellPumpIfRequired := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfFmpFarmWellPumpIfRequired.OnInitialize := InitializeFarmWellDisplay;
    FMfFmpFarmWellPumpIfRequired.OnGetUseList := GetMfFmpFarmWellPumpIfRequiredUseList;
    FMfFmpFarmWellPumpIfRequired.OnTimeListUsed := FarmWellsPumpRequiredUsed;
    FMfFmpFarmWellPumpIfRequired.Name := StrFarmWellPumpRequired;
    AddTimeList(FMfFmpFarmWellPumpIfRequired);
  end;

end;

function TFarmProcess.CropIdUsed(Sender: TObject): boolean;
begin
  result := PackageUsed(Sender);
end;

destructor TFarmProcess.Destroy;
begin
  FMfFmpFarmWellPumpIfRequired.Free;
  FMfFmpFarmWellFarmID.Free;
  FMfFmpMaxPumpingRate.Free;
  FMfFmpCropID.Free;
  FMfFmpFarmID.Free;
  FMfFmpPrecip.Free;
  FMfFmpEvapRate.Free;
  FStoredSurfaceWaterClosure.Free;
  FStoredMnwClosureCriterion.Free;
  FStoredResidualChangeReduction.Free;
  FStoredHeadChangeReduction.Free;
  FStoredPsiRampf.Free;
  FStoredSatThick.Free;
  inherited;
end;

function TFarmProcess.EvapUsed(Sender: TObject): boolean;
begin
  result := PackageUsed(Sender)
    and (ConsumptiveUse in [cuPotentialAndReferenceET, cuCropCoefficient]);
end;

function TFarmProcess.FarmIdUsed(Sender: TObject): boolean;
begin
  result := PackageUsed(Sender);
end;

function TFarmProcess.FarmWellsPumpRequiredUsed(Sender: TObject): boolean;
begin
  Result := FarmWellsUsed(Sender)
    and (CropIrrigationRequirement = cirOnlyWhenNeeded);
end;

function TFarmProcess.FarmWellsUsed(Sender: TObject): boolean;
begin
  result := PackageUsed(Sender);
end;

function TFarmProcess.GetHeadChangeReduction: double;
begin
  result := StoredHeadChangeReduction.Value;
end;

procedure TFarmProcess.GetMfFmpCropIDUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  PhastModel: TCustomModel;
  Boundary: TFmpCropIDBoundary;
begin
  PhastModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to PhastModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := PhastModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowFmpCropID;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TFarmProcess.GetMfFmpEvapUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  PhastModel: TCustomModel;
  Boundary: TFmpRefEvapBoundary;
begin
  PhastModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to PhastModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := PhastModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowFmpRefEvap;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TFarmProcess.GetMfFmpFarmIDUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  PhastModel: TCustomModel;
  Boundary: TFmpFarmIDBoundary;
begin
  PhastModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to PhastModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := PhastModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowFmpFarmID;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TFarmProcess.GetMfFmpFarmWellFarmIDUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  PhastModel: TCustomModel;
  Boundary: TFmpFarmIDBoundary;
begin
  PhastModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to PhastModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := PhastModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowFmpFarmID;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TFarmProcess.GetMfFmpFarmWellPumpIfRequiredUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptQMAX,
    FmpWellPumpOnlyIfCropRequiresWaterPosition, StrFarmWellPumpRequired);
end;

procedure TFarmProcess.GetMfFmpMaxPumpRateUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  UpdateDisplayUseList(NewUseList, ptQMAX,
    FmpWellMaxPumpingRatePosition, StrFarmMaxPumpRate);
end;

procedure TFarmProcess.GetMfFmpPrecipUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  PhastModel: TCustomModel;
  Boundary: TFmpPrecipBoundary;
begin
  PhastModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to PhastModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := PhastModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowFmpPrecip;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

function TFarmProcess.GetMnwClosureCriterion: double;
begin
  result := StoredMnwClosureCriterion.Value;
end;

function TFarmProcess.GetPsiRampf: double;
begin
  result := StoredPsiRampf.Value
end;

function TFarmProcess.GetResidualChangeReduction: double;
begin
  result := StoredResidualChangeReduction.Value;
end;

function TFarmProcess.GetSatThick: double;
begin
  result := StoredSatThick.Value
end;

function TFarmProcess.GetSurfaceWaterClosure: Double;
begin
  result := StoredSurfaceWaterClosure.Value;
end;

function TFarmProcess.GetWaterCostCoefficients: TWaterCostCoefficients;
begin
  result := wccLumped
end;

procedure TFarmProcess.InitializeFarmCropIdDisplay(Sender: TObject);
var
  List: TModflowBoundListOfTimeLists;
  FarmWriter: TModflowFmpWriter;
  Index: Integer;
  TimeList: TModflowBoundaryDisplayTimeList;
begin
  List := TModflowBoundListOfTimeLists.Create;
  FarmWriter := TModflowFmpWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfFmpCropID);

    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.CreateDataSets;
    end;

    FarmWriter.UpdateCropIDDisplay(List);

    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.ComputeAverage;
    end;
  finally
    FarmWriter.Free;
    List.Free;
  end;
end;

procedure TFarmProcess.InitializeFarmIdDisplay(Sender: TObject);
var
  List: TModflowBoundListOfTimeLists;
  FarmWriter: TModflowFmpWriter;
  Index: Integer;
  TimeList: TModflowBoundaryDisplayTimeList;
begin
  List := TModflowBoundListOfTimeLists.Create;
  FarmWriter := TModflowFmpWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfFmpFarmID);

    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.CreateDataSets;
    end;

    FarmWriter.UpdateFarmIDDisplay(List);

    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.ComputeAverage;
    end;
  finally
    FarmWriter.Free;
    List.Free;
  end;
end;

procedure TFarmProcess.InitializeFarmPrecipDisplay(Sender: TObject);
var
  List: TModflowBoundListOfTimeLists;
  FarmWriter: TModflowFmpWriter;
  Index: Integer;
  TimeList: TModflowBoundaryDisplayTimeList;
begin
  List := TModflowBoundListOfTimeLists.Create;
  FarmWriter := TModflowFmpWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfFmpPrecip);

    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.CreateDataSets;
    end;

    FarmWriter.UpdatePrecipDisplay(List);

    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.ComputeAverage;
    end;
  finally
    FarmWriter.Free;
    List.Free;
  end;
end;

procedure TFarmProcess.InitializeFarmRefEtDisplay(Sender: TObject);
var
  List: TModflowBoundListOfTimeLists;
  FarmWriter: TModflowFmpWriter;
  Index: Integer;
  TimeList: TModflowBoundaryDisplayTimeList;
begin
  List := TModflowBoundListOfTimeLists.Create;
  FarmWriter := TModflowFmpWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfFmpEvapRate);

    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.CreateDataSets;
    end;

    FarmWriter.UpdateRefEtDisplay(List);

    for Index := 0 to List.Count - 1 do
    begin
      TimeList := List[Index];
      TimeList.ComputeAverage;
    end;
  finally
    FarmWriter.Free;
    List.Free;
  end;
end;

procedure TFarmProcess.InitializeFarmWellDisplay(Sender: TObject);
var
  FarmWriter: TModflowFmpWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfFmpMaxPumpingRate.CreateDataSets;
  MfFmpFarmWellFarmID.CreateDataSets;
  MfFmpFarmWellPumpIfRequired.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  FarmWriter := TModflowFmpWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfFmpMaxPumpingRate);
    List.Add(MfFmpFarmWellFarmID);
    List.Add(MfFmpFarmWellPumpIfRequired);
    FarmWriter.UpdateDisplay(List, [FmpWellMaxPumpingRatePosition,
      FmpWellFarmIDPosition, FmpWellPumpOnlyIfCropRequiresWaterPosition]);
  finally
    FarmWriter.Free;
    List.Free;
  end;
  MfFmpMaxPumpingRate.LabelAsSum;
  MfFmpFarmWellFarmID.ComputeAverage;
  MfFmpFarmWellPumpIfRequired.ComputeAverage;
end;

procedure TFarmProcess.InitializeVariables;
begin
  inherited;
  RootingDepth := rdSpecified;
  ConsumptiveUse := cuPotentialAndReferenceET;
  Precipitation := pTimeSeries;
  FractionOfInefficiencyLosses := filCalculated;
  EfficiencyGroundwaterFunction := egfDeliveriesVary;
  EfficiencyReset := erStressPeriod;
  DeficiencyPolicy := dpNoPolicy;
  GroundwaterAllotmentsUsed := False;
  CropConsumptiveConcept := cccConcept1;
  CropConsumptiveLinkage := cclNotLinked;
  SurfaceWaterAllotment := swaNone;
  SaveWellFlowRates := swfrDefault;
  SaveNetRecharge := snrDefault;
  SupplyAndDemand := sadDefault;
  FarmBudgetPrintFlags := fbpNone;
  FarmBudgetPrintHowMuch := fbpCompact;
  EtPrintLocation := eplText;
  EtPrintType := eptNone;
  PrintRouting := prListingFile;
  PrintRoutingFrequency := prfAllPeriods;
  AcerageOptimizationPrintChoice := aopcCellFractionsAndResourceConstraints;
  AcerageOptimizationPrintLocation := aoplListing;
  DiversionBudgetLocation := dblListing;
  CropIrrigationRequirement := cirContinuously;
  RoutedDelivery := rdNone;
  RoutedReturn := rrAny;
  AssignmentMethod := umAssign;
  SurfaceWaterClosure := 0.001;
  RecomputeOption := roNotComputed;
  ResetMnwQMax := False;

  MnwClose := False;
  MnwClosureCriterion := 1e-6;
  HeadChangeReduction := 0.1;
  ResidualChangeReduction := 0.1;
  PsiRampf := 0.1;
  SatThick := 0.1;
end;

function TFarmProcess.PrecipUsed(Sender: TObject): boolean;
begin
  result := PackageUsed(Sender)
    and (Precipitation = pSpatiallyDistributed);
end;

procedure TFarmProcess.SetAcerageOptimizationPrintChoice(
  const Value: TAcerageOptimizationPrintChoice);
begin
  if FAcerageOptimizationPrintChoice <> Value then
  begin
    FAcerageOptimizationPrintChoice := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetAcerageOptimizationPrintLocation(
  const Value: TAcerageOptimizationPrintLocation);
begin
  if FAcerageOptimizationPrintLocation <> Value then
  begin
    FAcerageOptimizationPrintLocation := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetAssignmentMethod(const Value: TUpdateMethod);
begin
  if FAssignmentMethod <> Value then
  begin
    FAssignmentMethod := Value;
    InvalidateModel;
    if FModel <> nil then
    begin
      MfFmpPrecip.Invalidate;
    end;
  end;
end;

procedure TFarmProcess.SetConsumptiveUse(const Value: TConsumptiveUse);
begin
  if FConsumptiveUse <> Value then
  begin
    FConsumptiveUse := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetCropConsumptiveConcept(
  const Value: TCropConsumptiveConcept);
begin
  if FCropConsumptiveConcept <> Value then
  begin
    FCropConsumptiveConcept := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetCropConsumptiveLinkage(
  const Value: TCropConsumptiveLinkage);
begin
  if FCropConsumptiveLinkage <> Value then
  begin
    FCropConsumptiveLinkage := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetCropIrrigationRequirement(
  Value: TCropIrrigationRequirement);
begin
  // This is for backwards compatibility
  if Value = cirNotNeeded then
  begin
    Value := cirContinuously;
  end
  else if Value = cirNeeded then
  begin
    Value := cirOnlyWhenNeeded;
  end;

  if FCropIrrigationRequirement <> Value then
  begin
    FCropIrrigationRequirement := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetDeficiencyPolicy(const Value: TDeficiencyPolicy);
begin
  if FDeficiencyPolicy <> Value then
  begin
    FDeficiencyPolicy := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetDiversionBudgetLocation(
  const Value: TDiversionBudgetLocation);
begin
  if FDiversionBudgetLocation <> Value then
  begin
    FDiversionBudgetLocation := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetEfficiencyGroundwaterFunction(
  Value: TEfficiencyGroundwaterFunction);
begin
  // The
  if Value = egfConstant then
  begin
    Value := egfDeliveriesVary;
  end
  else if Value = egfVaries then
  begin
    Value := egfEfficienciesVary;
  end;

  if FEfficiencyGroundwaterFunction <> Value then
  begin
    FEfficiencyGroundwaterFunction := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetEfficiencyReset(const Value: TEfficiencyReset);
begin
  if FEfficiencyReset <> Value then
  begin
    FEfficiencyReset := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetEtPrintLocation(const Value: TEtPrintLocation);
begin
  if FEtPrintLocation <> Value then
  begin
    FEtPrintLocation := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetEtPrintType(const Value: TEtPrintType);
begin
  if FEtPrintType <> Value then
  begin
    FEtPrintType := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetFarmBudgetPrintFlags(Value: TFarmBudgetPrintFlags);
begin
  if Value = fbpAsciiCompact then
  begin
    Value := fbpAscii;
  end;
  if FFarmBudgetPrintFlags <> Value then
  begin
    FFarmBudgetPrintFlags := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetFarmBudgetPrintHowMuch(
  const Value: TFarmBudgetPrintHowMuch);
begin
  if FFarmBudgetPrintHowMuch <> Value then
  begin
    FFarmBudgetPrintHowMuch := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetFractionOfInefficiencyLosses(
  const Value: TFractionOfInefficiencyLosses);
begin
  if FFractionOfInefficiencyLosses <> Value then
  begin
    FFractionOfInefficiencyLosses := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetGroundwaterAllotmentsUsed(const Value: boolean);
begin
  SetBooleanProperty(FGroundwaterAllotmentsUsed, Value);
end;

procedure TFarmProcess.SetHeadChangeReduction(const Value: double);
begin
  StoredHeadChangeReduction.Value := Value;
end;

procedure TFarmProcess.SetMnwClose(const Value: Boolean);
begin
  SetBooleanProperty(FMnwClose, Value);
end;

procedure TFarmProcess.SetMnwClosureCriterion(const Value: double);
begin
  StoredMnwClosureCriterion.Value := Value;
end;

procedure TFarmProcess.SetPrecipitation(const Value: TPrecipitation);
begin
  if FPrecipitation <> Value then
  begin
    FPrecipitation := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetPrintRouting(const Value: TPrintRouting);
begin
  if FPrintRouting <> Value then
  begin
    FPrintRouting := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetPrintRoutingFrequency(
  const Value: TPrintRoutingFrequency);
begin
  if FPrintRoutingFrequency <> Value then
  begin
    FPrintRoutingFrequency := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetPsiRampf(const Value: double);
begin
  StoredPsiRampf.Value := Value;
end;

procedure TFarmProcess.SetRecomputeOption(const Value: TRecomputeOption);
begin
  if FRecomputeOption <> Value then
  begin
    FRecomputeOption := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetResetMnwQMax(const Value: boolean);
begin
  SetBooleanProperty(FResetMnwQMax, Value);
end;

procedure TFarmProcess.SetResidualChangeReduction(const Value: double);
begin
  StoredResidualChangeReduction.Value := Value;
end;

procedure TFarmProcess.SetRootingDepth(const Value: TRootingDepth);
begin
  if FRootingDepth <> Value then
  begin
    FRootingDepth := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetRoutedDelivery(const Value: TRoutedDelivery);
begin
  if FRoutedDelivery <> Value then
  begin
    FRoutedDelivery := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetRoutedReturn(const Value: TRoutedReturn);
begin
  if FRoutedReturn <> Value then
  begin
    FRoutedReturn := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetSatThick(const Value: double);
begin
  StoredSatThick.Value := Value;
end;

procedure TFarmProcess.SetSaveNetRecharge(Value: TSaveNetRecharge);
begin
  if Value in [snrListing, snrNone] then
  begin
    Value := snrDefault;
  end;
  if FSaveNetRecharge <> Value then
  begin
    FSaveNetRecharge := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetSaveWellFlowRates(Value: TSaveWellFlowRates);
begin
  case Value of
    swfrDefault: ;
    swfrAscii: ;
    swfrListing, swfrNone, swfrBinary, swfrBudget: Value := swfrDefault;
  end;
  if FSaveWellFlowRates <> Value then
  begin
    FSaveWellFlowRates := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetStoredHeadChangeReduction(const Value: TRealStorage);
begin
  FStoredHeadChangeReduction.Assign(Value)
end;

procedure TFarmProcess.SetStoredMnwClosureCriterion(const Value: TRealStorage);
begin
  FStoredMnwClosureCriterion.Assign(Value)
end;

procedure TFarmProcess.SetStoredPsiRampf(const Value: TRealStorage);
begin
  FStoredPsiRampf.Assign(Value)
end;

procedure TFarmProcess.SetStoredResidualChangeReduction(
  const Value: TRealStorage);
begin
  FStoredResidualChangeReduction.Assign(Value)
end;

procedure TFarmProcess.SetStoredSatThick(const Value: TRealStorage);
begin
  FStoredSatThick.Assign(Value)
end;

procedure TFarmProcess.SetStoredSurfaceWaterClosure(const Value: TRealStorage);
begin
  FStoredSurfaceWaterClosure.Assign(Value);
end;

procedure TFarmProcess.SetSupplyAndDemand(Value: TSupplyAndDemand);
begin
  // This is done for backwards compatibility.
  if Value in [sadListingEachTimeStepWhenBudgetSaved, sadNone, sadBinary] then
  begin
    Value := sadDefault;
  end;

  if FSupplyAndDemand <> Value then
  begin
    FSupplyAndDemand := Value;
    InvalidateModel;
  end;
end;

procedure TFarmProcess.SetSurfaceWaterAllotment(
  const Value: TSurfaceWaterAllotment);
begin
  if FSurfaceWaterAllotment <> Value then
  begin
    FSurfaceWaterAllotment := Value;
    InvalidateModel;
  end;
end;

//procedure TFarmProcess.SetSurfaceWaterAllotments(const Value: Boolean);
//begin
//  SetBooleanProperty(FSurfaceWaterAllotments, Value);
//end;

procedure TFarmProcess.SetSurfaceWaterClosure(const Value: Double);
begin
  StoredSurfaceWaterClosure.Value := Value;
end;

procedure TFarmProcess.SetWaterCostCoefficients(
  const Value: TWaterCostCoefficients);
begin
  // do nothing
end;

{ TConduitFlowProcess }

procedure TConduitFlowProcess.Assign(Source: TPersistent);
var
  ConduitSource: TConduitFlowProcess;
begin
  if Source is TConduitFlowProcess then
  begin
    ConduitSource := TConduitFlowProcess(Source);
    ConduitTemperature := ConduitSource.ConduitTemperature;
    ElevationOffset := ConduitSource.ElevationOffset;
    Epsilon := ConduitSource.Epsilon;
    Relax := ConduitSource.Relax;
    LayerTemperature := ConduitSource.LayerTemperature;
    PipesUsed := ConduitSource.PipesUsed;
    ConduitLayersUsed := ConduitSource.ConduitLayersUsed;
    CfpElevationChoice := ConduitSource.CfpElevationChoice;
    CfpExchange := ConduitSource.CfpExchange;
    MaxIterations := ConduitSource.MaxIterations;
    CfpPrintIterations := ConduitSource.CfpPrintIterations;
    ConduitRechargeUsed := ConduitSource.ConduitRechargeUsed;
    OutputInterval := ConduitSource.OutputInterval;
  end;
  inherited;
end;

constructor TConduitFlowProcess.Create(Model: TBaseModel);
begin
  inherited;
  FStoredLayerTemperature := TRealStorage.Create;
  FStoredRelax := TRealStorage.Create;
  FStoredElevationOffset := TRealStorage.Create;
  FStoredEpsilon := TRealStorage.Create;
  FStoredConduitTemperature := TRealStorage.Create;

  FStoredConduitTemperature.OnChange := OnValueChanged;
  FStoredLayerTemperature.OnChange := OnValueChanged;
  FStoredRelax.OnChange := OnValueChanged;
  FStoredElevationOffset.OnChange := OnValueChanged;
  FStoredEpsilon.OnChange := OnValueChanged;

  InitializeVariables;

  if Model <> nil then
  begin
    FMfConduitRechargeFraction := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfConduitRechargeFraction.OnInitialize := InitializeRchFractionDisplay;
    FMfConduitRechargeFraction.OnGetUseList := GetMfRechargeFractionUseList;
    FMfConduitRechargeFraction.OnTimeListUsed := RechargeFractionUsed;
    FMfConduitRechargeFraction.Name := StrCfpRecharge;
    AddTimeList(FMfConduitRechargeFraction);
  end;

end;

destructor TConduitFlowProcess.Destroy;
begin
  FMfConduitRechargeFraction.Free;
  FStoredConduitTemperature.Free;
  FStoredEpsilon.Free;
  FStoredElevationOffset.Free;
  FStoredRelax.Free;
  FStoredLayerTemperature.Free;
  inherited;
end;

function TConduitFlowProcess.GetConduitTemperature: double;
begin
  result := StoredConduitTemperature.Value;
end;

function TConduitFlowProcess.GetElevationOffset: double;
begin
  result := StoredElevationOffset.Value;
end;

function TConduitFlowProcess.GetEpsilon: double;
begin
  result := StoredEpsilon.Value;
end;

function TConduitFlowProcess.GetLayerTemperature: double;
begin
  result := StoredLayerTemperature.Value;
end;

procedure TConduitFlowProcess.GetMfRechargeFractionUseList(Sender: TObject;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TCustomModflowBoundaryItem;
  ValueIndex: Integer;
  PhastModel: TCustomModel;
  Boundary: TCfpRchFractionBoundary;
begin
  PhastModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to PhastModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := PhastModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowCfpRchFraction;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomModflowBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

function TConduitFlowProcess.GetRelax: double;
begin
  result := StoredRelax.Value;
end;

procedure TConduitFlowProcess.InitializeRchFractionDisplay(Sender: TObject);
var
  CfpWriter: TModflowCfpWriter;
  List: TModflowBoundListOfTimeLists;
  ADataArray: TDataArray;
  DataArrayIndex: Integer;
begin
  MfConduitRechargeFraction.CreateDataSets;


  List := TModflowBoundListOfTimeLists.Create;
  CfpWriter := TModflowCfpWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfConduitRechargeFraction);
    CfpWriter.UpdateDisplay(List);
  finally
    CfpWriter.Free;
    List.Free;
  end;
  for DataArrayIndex := 0 to MfConduitRechargeFraction.Count - 1 do
  begin
    ADataArray := MfConduitRechargeFraction[DataArrayIndex];
    ADataArray.UpToDate := True;
  end;
  MfConduitRechargeFraction.SetUpToDate(True);
end;

procedure TConduitFlowProcess.InitializeVariables;
begin
  inherited;
  ConduitTemperature := 25;
  ElevationOffset := 0;
  Epsilon := 1e-10;
  Relax := 1;
  LayerTemperature := 25;
  PipesUsed := False;
  ConduitLayersUsed := True;
  CfpElevationChoice := cecIndividual;
  CfpExchange := ceNodeConductance;
  MaxIterations := 1000;
  CfpPrintIterations := cpiPrint;
  FOutputInterval := 1;
end;

//procedure TConduitFlowProcess.ModelChanged(Sender: TObject);
//begin
//  InvalidateModel;
//end;

function TConduitFlowProcess.RechargeFractionUsed(Sender: TObject): boolean;
var
  LocalModel: TCustomModel;
begin
  LocalModel:= FModel as TCustomModel;
  result := IsSelected and PipesUsed and ConduitRechargeUsed
    and LocalModel.ModflowPackages.RchPackage.IsSelected;
end;

procedure TConduitFlowProcess.SetCfpElevationChoice(
  const Value: TCfpElevationChoice);
begin
  if FCfpElevationChoice <> Value then
  begin
    FCfpElevationChoice := Value;
    InvalidateModel;
  end;
end;

procedure TConduitFlowProcess.SetCfpExchange(const Value: TCfpExchange);
begin
  if FCfpExchange <> Value then
  begin
    FCfpExchange := Value;
    InvalidateModel;
  end;
end;

procedure TConduitFlowProcess.SetCfpPrintIterations(
  const Value: TCfpPrintIterations);
begin
  if FCfpPrintIterations <> Value then
  begin
    FCfpPrintIterations := Value;
    InvalidateModel;
  end;
end;

procedure TConduitFlowProcess.SetConduitLayersUsed(const Value: Boolean);
begin
  SetBooleanProperty(FConduitLayersUsed, Value);
end;

procedure TConduitFlowProcess.SetConduitRechargeUsed(const Value: boolean);
begin
  SetBooleanProperty(FConduitRechargeUsed, Value);
end;

procedure TConduitFlowProcess.SetConduitTemperature(const Value: double);
begin
  StoredConduitTemperature.Value := Value;
end;

procedure TConduitFlowProcess.SetElevationOffset(const Value: double);
begin
  StoredElevationOffset.Value := Value;
end;

procedure TConduitFlowProcess.SetEpsilon(const Value: double);
begin
  StoredEpsilon.Value := Value;
end;

procedure TConduitFlowProcess.SetLayerTemperature(const Value: double);
begin
  StoredLayerTemperature.Value := Value;
end;

procedure TConduitFlowProcess.SetMaxIterations(const Value: integer);
begin
  SetIntegerProperty(FMaxIterations, Value);
end;

procedure TConduitFlowProcess.SetOutputInterval(const Value: integer);
begin
  SetIntegerProperty(FOutputInterval, Value);
end;

procedure TConduitFlowProcess.SetPipesUsed(const Value: Boolean);
begin
  SetBooleanProperty(FPipesUsed, Value);
end;

procedure TConduitFlowProcess.SetRelax(const Value: double);
begin
  StoredRelax.Value := Value;
end;

procedure TConduitFlowProcess.SetStoredConduitTemperature(
  const Value: TRealStorage);
begin
  FStoredConduitTemperature.Assign(Value);
end;

procedure TConduitFlowProcess.SetStoredElevationOffset(
  const Value: TRealStorage);
begin
  FStoredElevationOffset.Assign(Value);
end;

procedure TConduitFlowProcess.SetStoredEpsilon(const Value: TRealStorage);
begin
  FStoredEpsilon.Assign(Value);
end;

procedure TConduitFlowProcess.SetStoredLayerTemperature(
  const Value: TRealStorage);
begin
  FStoredLayerTemperature.Assign(Value);
end;

procedure TConduitFlowProcess.SetStoredRelax(const Value: TRealStorage);
begin
  FStoredRelax.Assign(Value);
end;

{ TSwiPackage }

procedure TSwiPackage.Assign(Source: TPersistent);
var
  SourcePackage: TSwiPackage;
begin
  inherited;
  if Source is TSwiPackage then
  begin
    SourcePackage := TSwiPackage(Source);
    NumberOfSurfaces := SourcePackage.NumberOfSurfaces;
    DensityChoice := SourcePackage.DensityChoice;
    SaveZeta := SourcePackage.SaveZeta;
    ObsChoice := SourcePackage.ObsChoice;
    Adaptive := SourcePackage.Adaptive;
    Solver := SourcePackage.Solver;
    SolverPrintoutInterval := SourcePackage.SolverPrintoutInterval;
    SolverPrintChoice := SourcePackage.SolverPrintChoice;
    MXITER := SourcePackage.MXITER;
    ITER1 := SourcePackage.ITER1;
    NPCOND := SourcePackage.NPCOND;
    ZCLOSE := SourcePackage.ZCLOSE;
    RCLOSE := SourcePackage.RCLOSE;
    RELAX := SourcePackage.RELAX;
    NBPOL := SourcePackage.NBPOL;
    DAMP := SourcePackage.DAMP;
    DAMPT := SourcePackage.DAMPT;
    ToeSlope := SourcePackage.ToeSlope;
    TipSlope := SourcePackage.TipSlope;
    Alpha := SourcePackage.Alpha;
    Beta := SourcePackage.Beta;
    MaxAdaptiveTimeSteps := SourcePackage.MaxAdaptiveTimeSteps;
    MinAdaptiveTimeSteps := SourcePackage.MinAdaptiveTimeSteps;
    AdaptiveFactor := SourcePackage.AdaptiveFactor;
    ZoneDimensionlessDensities := SourcePackage.ZoneDimensionlessDensities;
    ModflowPrecision := SourcePackage.ModflowPrecision;
  end;
end;

constructor TSwiPackage.Create(Model: TBaseModel);
var
  InvalidateModelEvent: TNotifyEvent;
begin
  inherited;
  FTipSlope := TRealStorage.Create;
  FRELAX := TRealStorage.Create;
  FZCLOSE := TRealStorage.Create;
  FRCLOSE := TRealStorage.Create;
  FDAMP := TRealStorage.Create;
  FDAMPT := TRealStorage.Create;
  FAdaptiveFactor := TRealStorage.Create;
  FToeSlope := TRealStorage.Create;
  FAlpha := TRealStorage.Create;
  FBeta := TRealStorage.Create;

  FTipSlope.OnChange := ValuesChanged;
  FRELAX.OnChange := ValuesChanged;
  FZCLOSE.OnChange := ValuesChanged;
  FRCLOSE.OnChange := ValuesChanged;
  FAlpha.OnChange := ValuesChanged;
  FDAMP.OnChange := ValuesChanged;
  FDAMPT.OnChange := ValuesChanged;
  FAdaptiveFactor.OnChange := ValuesChanged;
  FToeSlope.OnChange := ValuesChanged;
  FAlpha.OnChange := ValuesChanged;
  FBeta.OnChange := ValuesChanged;

  if Model = nil then
  begin
    InvalidateModelEvent := nil;
  end
  else
  begin
    InvalidateModelEvent := Model.Invalidate;
  end;
  FZoneDimensionlessDensities := TRealCollection.Create(InvalidateModelEvent);

  InitializeVariables;
end;

destructor TSwiPackage.Destroy;
begin
  FTipSlope.Free;
  FRELAX.Free;
  FZCLOSE.Free;
  FRCLOSE.Free;
  FDAMP.Free;
  FDAMPT.Free;
  FAdaptiveFactor.Free;
  FToeSlope.Free;
  FAlpha.Free;
  FBeta.Free;

  FZoneDimensionlessDensities.Free;


  inherited;
end;

procedure TSwiPackage.InitializeVariables;
begin
  inherited;
  FNumberOfSurfaces := 1;
  FDensityChoice := dcLinear;
  FSaveZeta := True;
  FObsChoice := socNone;
  FAdaptive := False;
  FSolver := ssDirect;
  FSolverPrintoutInterval := 1;
  FSolverPrintChoice := sspcTables;
  FMXITER := 20;
  FITER1 := 30;
  FZCLOSE.Value := 0.001;
  FRCLOSE.Value := 0.001;
  FRELAX.Value := 1;
  FDAMP.Value := 1;
  FDAMPT.Value := 1;
  NPCOND := pmCholesky;
  NBPOL := peeEstimate;
  TipSlope.Value := 0.04;
  ToeSlope.Value := 0.04;
  Alpha.Value := 0.1;
  Beta.Value := 0.1;
  MinAdaptiveTimeSteps := 1;
  MaxAdaptiveTimeSteps := 10;
  AdaptiveFactor.Value := 0.5;
  FModflowPrecision := mpSingle;



//    // NU
//    property ZoneDimensionlessDensities: TRealCollection
//      read FZoneDimensionlessDensities write SetZoneDimensionlessDensities;


end;

procedure TSwiPackage.SetAdaptive(const Value: Boolean);
begin
  SetBooleanProperty(FAdaptive, Value);
end;

procedure TSwiPackage.SetAdaptiveFactor(const Value: TRealStorage);
begin
  FAdaptiveFactor.Assign(Value);
end;

procedure TSwiPackage.SetAlpha(const Value: TRealStorage);
begin
  FAlpha.Assign(Value);
end;

procedure TSwiPackage.SetBeta(const Value: TRealStorage);
begin
  FBeta.Assign(Value);
end;

procedure TSwiPackage.SetDAMP(const Value: TRealStorage);
begin
  FDAMP.Assign(Value);
end;

procedure TSwiPackage.SetDAMPT(const Value: TRealStorage);
begin
  FDAMPT.Assign(Value);
end;

procedure TSwiPackage.SetDensityChoice(const Value: TDensityChoice);
begin
  if FDensityChoice <> Value then
  begin
    FDensityChoice := Value;
    InvalidateModel;
  end;
end;

procedure TSwiPackage.SetITER1(const Value: integer);
begin
  SetIntegerProperty(FITER1, Value);
end;

procedure TSwiPackage.SetMaxAdaptiveTimeSteps(const Value: integer);
begin
  SetIntegerProperty(FMaxAdaptiveTimeSteps, Value);
end;

procedure TSwiPackage.SetMinAdaptiveTimeSteps(const Value: integer);
begin
  SetIntegerProperty(FMinAdaptiveTimeSteps, Value);
end;

procedure TSwiPackage.SetModflowPrecision(const Value: TModflowPrecision);
begin
  if FModflowPrecision <> Value then
  begin
    FModflowPrecision := Value;
    InvalidateModel;
  end;
end;

procedure TSwiPackage.SetMXITER(const Value: integer);
begin
  SetIntegerProperty(FMXITER, Value);
end;

procedure TSwiPackage.SetNBPOL(const Value: TPcgEstimateMaxEigenvalue);
begin
  if FNBPOL <> Value then
  begin
    FNBPOL := Value;
    InvalidateModel;
  end;
end;

procedure TSwiPackage.SetNPCOND(const Value: TPcgMethod);
begin
  if FNPCOND <> Value then
  begin
    FNPCOND := Value;
    InvalidateModel;
  end;
end;

procedure TSwiPackage.SetNumberOfSurfaces(const Value: integer);
begin
  SetIntegerProperty(FNumberOfSurfaces, Value);
end;

procedure TSwiPackage.SetObsChoice(const Value: TSwiObsChoice);
begin
  if FObsChoice <> Value then
  begin
    FObsChoice := Value;
    InvalidateModel;
  end;
end;

procedure TSwiPackage.SetRCLOSE(const Value: TRealStorage);
begin
  FRCLOSE.Assign(Value);
end;

procedure TSwiPackage.SetRELAX(const Value: TRealStorage);
begin
  FRELAX.Assign(Value);
end;

procedure TSwiPackage.SetSaveZeta(const Value: Boolean);
begin
  SetBooleanProperty(FSaveZeta, Value);
end;

procedure TSwiPackage.SetSolver(const Value: TSwiSolver);
begin
  if FSolver <> Value then
  begin
    FSolver := Value;
    InvalidateModel;
  end;
end;

procedure TSwiPackage.SetSolverPrintChoice(const Value: TSwiSolverPrintChoice);
begin
  if FSolverPrintChoice <> Value then
  begin
    FSolverPrintChoice := Value;
    InvalidateModel;
  end;
end;

procedure TSwiPackage.SetSolverPrintoutInterval(const Value: integer);
begin
  SetIntegerProperty(FSolverPrintoutInterval, Value);
end;

procedure TSwiPackage.SetTipSlope(const Value: TRealStorage);
begin
  FTipSlope.Assign(Value);
end;

procedure TSwiPackage.SetToeSlope(const Value: TRealStorage);
begin
  FToeSlope.Assign(Value);
end;

procedure TSwiPackage.SetZCLOSE(const Value: TRealStorage);
begin
  FZCLOSE.Assign(Value);
end;

procedure TSwiPackage.SetZoneDimensionlessDensities(
  const Value: TRealCollection);
begin
  FZoneDimensionlessDensities.Assign(Value);
end;

procedure TSwiPackage.ValuesChanged(Sender: TObject);
begin
  InvalidateModel;
end;

{ TSwrPackage }

procedure TSwrPackage.Assign(Source: TPersistent);
var
  SwiSource: TSwrPackage;
begin
  if Source is TSwrPackage then
  begin
    SwiSource := TSwrPackage(Source);
    OnlyUseSWR := SwiSource.OnlyUseSWR;
    ContinueDespiteNonConvergence := SwiSource.ContinueDespiteNonConvergence;
    UseUpstreamWeightingForDiffusiveWave := SwiSource.UseUpstreamWeightingForDiffusiveWave;
    UseInexactNewton := SwiSource.UseInexactNewton;
    UseSteadyStateStorage := SwiSource.UseSteadyStateStorage;
    UseLaggedStagesAndFlows := SwiSource.UseLaggedStagesAndFlows;
    UseLinearDepthScaling := SwiSource.UseLinearDepthScaling;
    Scaling := SwiSource.Scaling;
    Reordering := SwiSource.Reordering;
    NewtonCorrection := SwiSource.NewtonCorrection;

    InitialTimeStepLength := SwiSource.InitialTimeStepLength;
    MinTimeStepLength := SwiSource.MinTimeStepLength;
    MaxTimeStepLength := SwiSource.MaxTimeStepLength;
    TimeStepMultiplier := SwiSource.TimeStepMultiplier;
    TimeStepIncreaseFrequency := SwiSource.TimeStepIncreaseFrequency;
    MinGradientForDiffusiveFlow := SwiSource.MinGradientForDiffusiveFlow;
    MinDepthForOutflow := SwiSource.MinDepthForOutflow;
    MaxRainfallForStepAdjustment := SwiSource.MaxRainfallForStepAdjustment;
    MaxStageChangePerStep := SwiSource.MaxStageChangePerStep;
    MaxInflowChange := SwiSource.MaxInflowChange;

    // Group 3 Method3 for specifying data, Data Set 5

    RainSpecification := SwiSource.RainSpecification;
    EvapSpecification := SwiSource.EvapSpecification;
    LateralInflowSpecification := SwiSource.LateralInflowSpecification;
    StageSpecification := SwiSource.StageSpecification;

    // Group 4:   Print flags

    PrintInflowsAndOutflows := SwiSource.PrintInflowsAndOutflows;
    PrintStage := SwiSource.PrintStage;
    PrintReachExchangeAndProperties := SwiSource.PrintReachExchangeAndProperties;
    PrintReachLateralFlow := SwiSource.PrintReachLateralFlow;
    PrintStructureFlow := SwiSource.PrintStructureFlow;
    PrintMaxFroude := SwiSource.PrintMaxFroude;
    PrintSwrDataToScreen := SwiSource.PrintSwrDataToScreen;
    SaveSwrTimeStepLength := SwiSource.SaveSwrTimeStepLength;
    SaveAverageSimulatedResults := SwiSource.SaveAverageSimulatedResults;
    SaveConvergenceHistory := SwiSource.SaveConvergenceHistory;
    SaveRiver := SwiSource.SaveRiver;
    SaveObs := SwiSource.SaveObs;
    ObsFormat := SwiSource.ObsFormat;
    SaveFrequency := SwiSource.SaveFrequency;

    // Group 5: Solver

    Solver := SwiSource.Solver;
    MaxOuterIterations := SwiSource.MaxOuterIterations;
    MaxInnerIterations := SwiSource.MaxInnerIterations;
    MaxLineSearchIterations := SwiSource.MaxLineSearchIterations;
    StageTolerance := SwiSource.StageTolerance;
    FlowToleranceOption := SwiSource.FlowToleranceOption;
    FlowTolerance := SwiSource.FlowTolerance;
    ExchangeToleranceOption := SwiSource.ExchangeToleranceOption;
    ExchangeTolerance := SwiSource.ExchangeTolerance;
    SteadyStateDampingFactor := SwiSource.SteadyStateDampingFactor;
    TransientDampingFactor := SwiSource.TransientDampingFactor;
    ConvergencePrintoutInterval := SwiSource.ConvergencePrintoutInterval;
    PrintConvergence := SwiSource.PrintConvergence;
    Preconditioner := SwiSource.Preconditioner;
    MaxLevels := SwiSource.MaxLevels;
    DropThreshold := SwiSource.DropThreshold;
    PrintLineSearchInterval := SwiSource.PrintLineSearchInterval;
    AlternativeFlowTolerance := SwiSource.AlternativeFlowTolerance;

    RainAssignmentMethod := SwiSource.RainAssignmentMethod;
    EvapAssignmentMethod := SwiSource.EvapAssignmentMethod;
    LatInflowAssignmentMethod := SwiSource.LatInflowAssignmentMethod;
    StageAssignmentMethod := SwiSource.StageAssignmentMethod;
  end;
  inherited;
end;

constructor TSwrPackage.Create(Model: TBaseModel);
begin
  inherited;

  FStoredMaxStageChangePerStep := TRealStorage.Create;
  FStoredMaxStageChangePerStep.OnChange := ValuesChanged;

  FStoredMinTimeStepLength := TRealStorage.Create;
  FStoredMinTimeStepLength.OnChange := ValuesChanged;

  FStoredMaxInflowChange := TRealStorage.Create;
  FStoredMaxInflowChange.OnChange := ValuesChanged;

  FStoredTimeStepMultiplier := TRealStorage.Create;
  FStoredTimeStepMultiplier.OnChange := ValuesChanged;

  FStoredExchangeTolerance := TRealStorage.Create;
  FStoredExchangeTolerance.OnChange := ValuesChanged;

  FStoredFlowTolerance := TRealStorage.Create;
  FStoredFlowTolerance.OnChange := ValuesChanged;

  FStoredSaveFrequency := TRealStorage.Create;
  FStoredSaveFrequency.OnChange := ValuesChanged;

  FStoredAlternativeFlowTolerance := TRealStorage.Create;
  FStoredAlternativeFlowTolerance.OnChange := ValuesChanged;

  FStoredInitialTimeStepLength := TRealStorage.Create;
  FStoredInitialTimeStepLength.OnChange := ValuesChanged;

  FStoredTransientDampingFactor := TRealStorage.Create;
  FStoredTransientDampingFactor.OnChange := ValuesChanged;

  FStoredMaxRainfallForStepAdjustment := TRealStorage.Create;
  FStoredMaxRainfallForStepAdjustment.OnChange := ValuesChanged;

  FStoredStageTolerance := TRealStorage.Create;
  FStoredStageTolerance.OnChange := ValuesChanged;

  FStoredDropThreshold := TRealStorage.Create;
  FStoredDropThreshold.OnChange := ValuesChanged;

  FStoredMaxTimeStepLength := TRealStorage.Create;
  FStoredMaxTimeStepLength.OnChange := ValuesChanged;

  FStoredMinGradientForDiffusiveFlow := TRealStorage.Create;
  FStoredMinGradientForDiffusiveFlow.OnChange := ValuesChanged;

  FStoredSteadyStateDampingFactor := TRealStorage.Create;
  FStoredSteadyStateDampingFactor.OnChange := ValuesChanged;

  FStoredMinDepthForOutflow := TRealStorage.Create;
  FStoredMinDepthForOutflow.OnChange := ValuesChanged;

  InitializeVariables;

  if Model <> nil then
  begin
    FMfRainfall := TModflowBoundaryDisplayTimeList.Create(Model);
    MfRainfall.OnInitialize := InitializeSwrRainDisplay;
    MfRainfall.OnGetUseList := GetMfRainUseList;
    MfRainfall.OnTimeListUsed := PackageUsed;
    MfRainfall.Name := StrSWR_Rain;
    MfRainfall.Orientation := dsoTop;
    AddTimeList(MfRainfall);

    FMfEvaporation := TModflowBoundaryDisplayTimeList.Create(Model);
    MfEvaporation.OnInitialize := InitializeSwrEvapDisplay;
    MfEvaporation.OnGetUseList := GetMfEvapUseList;
    MfEvaporation.OnTimeListUsed := PackageUsed;
    MfEvaporation.Name := StrSWR_Evap;
    MfEvaporation.Orientation := dsoTop;
    AddTimeList(MfEvaporation);

    FMfLatInflow := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfLatInflow.OnInitialize := InitializeSwrLatInflowDisplay;
    FMfLatInflow.OnGetUseList := GetMfLatInflUseList;
    FMfLatInflow.OnTimeListUsed := PackageUsed;
    FMfLatInflow.Name := StrSWR_LatInflow;
    FMfLatInflow.Orientation := dsoTop;
    AddTimeList(FMfLatInflow);

    FMfStage := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfStage.OnInitialize := InitializeSwrStageDisplay;
    FMfStage.OnGetUseList := GetMfStageUseList;
    FMfStage.OnTimeListUsed := PackageUsed;
    FMfStage.Name := StrSWR_Stage;
    FMfStage.Orientation := dsoTop;
    AddTimeList(FMfStage);

    FMfVerticalOffset := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfVerticalOffset.OnInitialize := InitializeVerticalOffsetDisplay;
    FMfVerticalOffset.OnGetUseList := GetMfVerticalOffsetUseList;
    FMfVerticalOffset.OnTimeListUsed := PackageUsed;
    FMfVerticalOffset.Name := StrSWR_Vertical_Offset;
    FMfVerticalOffset.Orientation := dsoTop;
    AddTimeList(FMfVerticalOffset);

    FMfBoundaryType := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfBoundaryType.OnInitialize := InitializeBoundaryTypeDisplay;
    FMfBoundaryType.OnGetUseList := GetEmptyUseList;
    FMfBoundaryType.OnTimeListUsed := PackageUsed;
    FMfBoundaryType.Name := StrSWR_BoundaryType;
    FMfBoundaryType.Orientation := dsoTop;
    AddTimeList(FMfBoundaryType);

    FMfDirectRunoffReach := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfDirectRunoffReach.OnInitialize := InitializeSwrDirectRunoffDisplay;
    FMfDirectRunoffReach.OnGetUseList := GetMfDirectRunoffReachUseList;
    FMfDirectRunoffReach.OnTimeListUsed := PackageUsed;
    FMfDirectRunoffReach.Name := StrSWR_DirectRunoffReach;
    FMfDirectRunoffReach.DataType := rdtInteger;
    FMfDirectRunoffReach.Orientation := dsoTop;
    AddTimeList(FMfDirectRunoffReach);

    FMfGeometryNumber := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfGeometryNumber.OnInitialize := InitializeGeometryNumberDisplay;
    FMfGeometryNumber.OnGetUseList := GetEmptyUseList;
    FMfGeometryNumber.OnTimeListUsed := PackageUsed;
    FMfGeometryNumber.Name := StrSWR_GeometryNumber;
    FMfGeometryNumber.DataType := rdtInteger;
    FMfGeometryNumber.Orientation := dsoTop;
    AddTimeList(FMfGeometryNumber);

    FMfDirectRunoffValue := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfDirectRunoffValue.OnInitialize := InitializeSwrDirectRunoffDisplay;
    FMfDirectRunoffValue.OnGetUseList := GetMfDirectRunoffValueUseList;
    FMfDirectRunoffValue.OnTimeListUsed := PackageUsed;
    FMfDirectRunoffValue.Name := StrSWR_DirectRunoffValue;
    FMfDirectRunoffValue.Orientation := dsoTop;
    AddTimeList(FMfDirectRunoffValue);

  end;

end;

destructor TSwrPackage.Destroy;
begin
  FMfGeometryNumber.Free;
  FMfBoundaryType.Free;
  FMfVerticalOffset.Free;
  FMfDirectRunoffValue.Free;
  FMfDirectRunoffReach.Free;
  FMfStage.Free;
  FMfLatInflow.Free;
  FMfEvaporation.Free;
  FMfRainfall.Free;

  FStoredMaxStageChangePerStep.Free;
  FStoredMinTimeStepLength.Free;
  FStoredMaxInflowChange.Free;
  FStoredTimeStepMultiplier.Free;
  FStoredExchangeTolerance.Free;
  FStoredFlowTolerance.Free;
  FStoredSaveFrequency.Free;
  FStoredAlternativeFlowTolerance.Free;
  FStoredInitialTimeStepLength.Free;
  FStoredTransientDampingFactor.Free;
  FStoredMaxRainfallForStepAdjustment.Free;
  FStoredStageTolerance.Free;
  FStoredDropThreshold.Free;
  FStoredMaxTimeStepLength.Free;
  FStoredMinGradientForDiffusiveFlow.Free;
  FStoredSteadyStateDampingFactor.Free;
  FStoredMinDepthForOutflow.Free;

  inherited;
end;

function TSwrPackage.GetAlternativeFlowTolerance: double;
begin
  result := StoredAlternativeFlowTolerance.Value;
end;

function TSwrPackage.GetDropThreshold: double;
begin
  result := StoredDropThreshold.Value;
end;

procedure TSwrPackage.GetEmptyUseList(Sender: TObject; NewUseList: TStringList);
begin
  NewUseList.Clear;
end;

function TSwrPackage.GetExchangeTolerance: double;
begin
  result := StoredExchangeTolerance.Value;
end;

function TSwrPackage.GetFlowTolerance: double;
begin
  result := StoredFlowTolerance.Value;
end;

function TSwrPackage.GetInitialTimeStepLength: double;
begin
  result := StoredInitialTimeStepLength.Value;
end;

function TSwrPackage.GetMaxInflowChange: double;
begin
  result := StoredMaxInflowChange.Value;
end;

function TSwrPackage.GetMaxRainfallForStepAdjustment: double;
begin
  result := StoredMaxRainfallForStepAdjustment.Value;
end;

function TSwrPackage.GetMaxStageChangePerStep: double;
begin
  result := StoredMaxStageChangePerStep.Value;
end;

function TSwrPackage.GetMaxTimeStepLength: double;
begin
  result := StoredMaxTimeStepLength.Value;
end;

procedure TSwrPackage.GetMfDirectRunoffReachUseList(Sender: TObject;
  NewUseList: TStringList);
var
  LocalModel: TCustomModel;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TSwrDirectRunoffBoundary;
  ValueIndex: Integer;
  Item: TSwrDirectRunoffItem;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSwrDirectRunoff;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TSwrDirectRunoffItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSwrPackage.GetMfDirectRunoffValueUseList(Sender: TObject;
  NewUseList: TStringList);
var
  LocalModel: TCustomModel;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TSwrDirectRunoffBoundary;
  ValueIndex: Integer;
  Item: TSwrDirectRunoffItem;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSwrDirectRunoff;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TSwrDirectRunoffItem;
        UpdateUseList(1, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSwrPackage.GetMfEvapUseList(Sender: TObject;
  NewUseList: TStringList);
var
  LocalModel: TCustomModel;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TSwrEvapBoundary;
  ValueIndex: Integer;
  Item: TCustomSwrBoundaryItem;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSwrEvap;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomSwrBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSwrPackage.GetMfLatInflUseList(Sender: TObject;
  NewUseList: TStringList);
var
  LocalModel: TCustomModel;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TSwrLatInflowBoundary;
  ValueIndex: Integer;
  Item: TCustomSwrBoundaryItem;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSwrLatInflow;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomSwrBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSwrPackage.GetMfRainUseList(Sender: TObject;
  NewUseList: TStringList);
var
  LocalModel: TCustomModel;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TSwrRainBoundary;
  ValueIndex: Integer;
  Item: TCustomSwrBoundaryItem;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowSwrRain;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count -1 do
      begin
        Item := Boundary.Values[ValueIndex] as TCustomSwrBoundaryItem;
        UpdateUseList(0, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TSwrPackage.GetMfStageUseList(Sender: TObject;
  NewUseList: TStringList);
var
  LocalModel: TCustomModel;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  StageBoundary: TSwrStageBoundary;
  ValueIndex: Integer;
  StageItem: TCustomSwrBoundaryItem;
  ReachBoundary: TSwrReachBoundary;
  ReachItem: TSwrTransientReachItem;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    if LocalModel.ModflowPackages.SwrPackage.StageSpecification = smArray then
    begin
      StageBoundary := ScreenObject.ModflowSwrStage;
      if (StageBoundary <> nil) and StageBoundary.Used then
      begin
        for ValueIndex := 0 to StageBoundary.Values.Count -1 do
        begin
          StageItem := StageBoundary.Values[ValueIndex] as TCustomSwrBoundaryItem;
          UpdateUseList(0, NewUseList, StageItem);
        end;
      end;
    end
    else
    begin
      ReachBoundary := ScreenObject.ModflowSwrReaches;
      if (ReachBoundary <> nil) and ReachBoundary.Used then
      begin
        for ValueIndex := 0 to ReachBoundary.Values.Count -1 do
        begin
          ReachItem := ReachBoundary.Values[ValueIndex] as TSwrTransientReachItem;
          UpdateUseList(1, NewUseList, ReachItem);
        end;
      end;
    end;
  end;
end;

procedure TSwrPackage.GetMfVerticalOffsetUseList(Sender: TObject;
  NewUseList: TStringList);
var
  LocalModel: TCustomModel;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
//  StageBoundary: TSwrStageBoundary;
  ValueIndex: Integer;
//  StageItem: TCustomSwrBoundaryItem;
  ReachBoundary: TSwrReachBoundary;
  ReachItem: TSwrTransientReachItem;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    ReachBoundary := ScreenObject.ModflowSwrReaches;
    if (ReachBoundary <> nil) and ReachBoundary.Used then
    begin
      for ValueIndex := 0 to ReachBoundary.Values.Count -1 do
      begin
        ReachItem := ReachBoundary.Values[ValueIndex] as TSwrTransientReachItem;
        UpdateUseList(0, NewUseList, ReachItem);
      end;
    end;
  end;
end;

function TSwrPackage.GetMinDepthForOutflow: double;
begin
  result := StoredMinDepthForOutflow.Value;
end;

function TSwrPackage.GetMinGradientForDiffusiveFlow: double;
begin
  result := StoredMinGradientForDiffusiveFlow.Value;
end;

function TSwrPackage.GetMinTimeStepLength: double;
begin
  result := StoredMinTimeStepLength.Value;
end;

function TSwrPackage.GetSaveFrequency: Double;
begin
  result := StoredSaveFrequency.Value;
end;

function TSwrPackage.GetStageTolerance: double;
begin
  result := StoredStageTolerance.Value;
end;

function TSwrPackage.GetSteadyStateDampingFactor: double;
begin
  result := StoredSteadyStateDampingFactor.Value;
end;

function TSwrPackage.GetTimeStepMultiplier: double;
begin
  result := StoredTimeStepMultiplier.Value;
end;

function TSwrPackage.GetTransientDampingFactor: double;
begin
  result := StoredTransientDampingFactor.Value;
end;

procedure TSwrPackage.InitializeBoundaryTypeDisplay(Sender: TObject);
var
  SwrWriter: TModflowSwrWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfBoundaryType.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  SwrWriter := TModflowSwrWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfBoundaryType);
    SwrWriter.UpdateBoundaryTypeDisplay(List);
  finally
    SwrWriter.Free;
    List.Free;
  end;
  MfBoundaryType.ComputeAverage;
end;

procedure TSwrPackage.InitializeGeometryNumberDisplay(Sender: TObject);
var
  SwrWriter: TModflowSwrWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfGeometryNumber.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  SwrWriter := TModflowSwrWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfGeometryNumber);
    SwrWriter.UpdateGeometryNumberDisplay(List);
  finally
    SwrWriter.Free;
    List.Free;
  end;
  MfGeometryNumber.ComputeAverage;
end;

procedure TSwrPackage.InitializeSwrDirectRunoffDisplay(Sender: TObject);
var
  SwrWriter: TModflowSwrWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfDirectRunoffReach.CreateDataSets;
  MfDirectRunoffValue.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  SwrWriter := TModflowSwrWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfDirectRunoffReach);
    List.Add(MfDirectRunoffValue);
    SwrWriter.UpdateDirectRunoffDisplay(List);
  finally
    SwrWriter.Free;
    List.Free;
  end;
  MfDirectRunoffReach.ComputeAverage;
  MfDirectRunoffValue.ComputeAverage;
end;

procedure TSwrPackage.InitializeSwrEvapDisplay(Sender: TObject);
var
  SwrWriter: TModflowSwrWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfEvaporation.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  SwrWriter := TModflowSwrWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfEvaporation);
    SwrWriter.UpdateEvapDisplay(List);
  finally
    SwrWriter.Free;
    List.Free;
  end;
  if (EvapSpecification = smArray) and (EvapAssignmentMethod = umAdd) then
  begin
    MfEvaporation.LabelAsSum;
  end
  else
  begin
    MfEvaporation.ComputeAverage;
  end;
end;

procedure TSwrPackage.InitializeSwrLatInflowDisplay(Sender: TObject);
var
  SwrWriter: TModflowSwrWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfLatInflow.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  SwrWriter := TModflowSwrWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfLatInflow);
    SwrWriter.UpdateLatInflowDisplay(List);
  finally
    SwrWriter.Free;
    List.Free;
  end;
  if (LateralInflowSpecification = smArray)
    and (LatInflowAssignmentMethod = umAdd) then
  begin
    MfLatInflow.LabelAsSum;
  end
  else
  begin
    MfLatInflow.ComputeAverage;
  end;
end;

procedure TSwrPackage.InitializeSwrRainDisplay(Sender: TObject);
var
  SwrWriter: TModflowSwrWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfRainfall.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  SwrWriter := TModflowSwrWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfRainfall);
    SwrWriter.UpdateRainDisplay(List);
  finally
    SwrWriter.Free;
    List.Free;
  end;
  if (RainSpecification = smArray) and (RainAssignmentMethod = umAdd) then
  begin
    MfRainfall.LabelAsSum;
  end
  else
  begin
    MfRainfall.ComputeAverage;
  end;
end;

procedure TSwrPackage.InitializeSwrStageDisplay(Sender: TObject);
var
  SwrWriter: TModflowSwrWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfStage.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  SwrWriter := TModflowSwrWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfStage);
    SwrWriter.UpdateStageDisplay(List);
  finally
    SwrWriter.Free;
    List.Free;
  end;
  if (StageSpecification = smArray) and (StageAssignmentMethod = umAdd) then
  begin
    MfStage.LabelAsSum;
  end
  else
  begin
    MfStage.ComputeAverage;
  end;
end;

procedure TSwrPackage.InitializeVariables;
begin
  inherited;
  // Group 1
  OnlyUseSWR := False;
  ContinueDespiteNonConvergence := False;
  UseUpstreamWeightingForDiffusiveWave := False;
  UseInexactNewton := False;
  UseSteadyStateStorage := False;
  UseLaggedStagesAndFlows := False;
  UseLinearDepthScaling := False;
  Scaling := ssNone;
  Reordering := srNone;
  NewtonCorrection := sncExplicit;

  // Group 2: Time step options
  InitialTimeStepLength := 1e-2;
  MinTimeStepLength := 1e-4;
  MaxTimeStepLength := 1e-2;
  TimeStepMultiplier := 1.01;
  TimeStepIncreaseFrequency := 10;
  MinGradientForDiffusiveFlow := 1.0E-12;
  MinDepthForOutflow := 1.0E-03;
  MaxRainfallForStepAdjustment := KMaxRainfallForStepAdjustment;
  MaxStageChangePerStep := KMaxStageChangePerStep;
  MaxInflowChange := 0;

  // Group 3 Methods for specifying data, Data Set 5

  RainSpecification := smArray;
  EvapSpecification := smArray;
  LateralInflowSpecification := smArray;
  StageSpecification := smObject;

   // Group 4:   Print flags
  PrintInflowsAndOutflows := spoNone;
  PrintStage := spoNone;
  PrintReachExchangeAndProperties := spoNone;
  PrintReachLateralFlow := spoNone;
  PrintStructureFlow := spoNone;
  PrintMaxFroude := False;
  PrintSwrDataToScreen := False;
  SaveSwrTimeStepLength := spoNone;
  SaveAverageSimulatedResults := True;
  SaveConvergenceHistory := True;
  SaveRiver := ssrNone;
  SaveObs := ssoNone;
  ObsFormat := swofAscii;
  SaveFrequency := 0;

    // Group 5: Solver
//  TSwrSolver = (ssCrout, ssBi_CGSTAB, ssGMRES);
//  TSwrPrintConvergence = (spcPrintMaxResidual, spcIterations, spcNone,
//    spcPrintOnFailure);
//  TSwrPreconditioner = (spNone, spJacobi, spIlu, spMilu, spIlut);
//  TSwrFlowToleranceOption = (rtoNone, rtoFractional, rtoL2Norm);
//  TSwrExchangeTolerance = (etNone, etGlobal, etAbsolute);

    // ISOLVER Data Set 3
    Solver := ssBi_CGSTAB;
    // NOUTER Data Set 3
    MaxOuterIterations := 31;
    // NINNER Data Set 3
    MaxInnerIterations := 100;
    // IBT Data Set 3
    MaxLineSearchIterations := 10;
    // TOLS Data Set 3
    StageTolerance := 1.0E-09;
    // CSWROPT USE_FRACTIONAL_TOLR Data set 1b
    // CSWROPT USE_L2NORM_TOLR Data set 1b
    FlowToleranceOption := rtoNone;
    // TOLR Data Set 3
    FlowTolerance := 100;
    // CSWROPT USE_GLOBAL_TOLA Data set 1b
    // CSWROPT USE_ABSOLUTE_TOLA Data set 1b
    ExchangeToleranceOption := etNone;
    // TOLA Data Set 3
    ExchangeTolerance := 0.01;
    // DAMPSS Data Set 3
    SteadyStateDampingFactor := 1;
    // DAMPTR Data Set 3
    TransientDampingFactor := 1;
    // IPRSWR Data Set 3
    ConvergencePrintoutInterval := 1;
    // MUTSWR Data Set 3
    PrintConvergence := spcPrintMaxResidual;
    // IPC Data Set 3
    Preconditioner := KPreconditioner;
    // NLEVELS Data Set 3
    MaxLevels := KMaxLevels;
    // DROPTOL Data Set 3
    DropThreshold := KDropThreshold;
    // IBTPRT Data Set 3
    PrintLineSearchInterval := 0;
    // PTOLR Data Set 3
    AlternativeFlowTolerance := KAlternativeFlowTolerance;

    RainAssignmentMethod := umAssign;
    EvapAssignmentMethod := umAssign;
    LatInflowAssignmentMethod := umAssign;
    StageAssignmentMethod := umAssign;
end;

procedure TSwrPackage.InitializeVerticalOffsetDisplay(Sender: TObject);
var
  SwrWriter: TModflowSwrWriter;
  List: TModflowBoundListOfTimeLists;
begin
  MfVerticalOffset.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  SwrWriter := TModflowSwrWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfVerticalOffset);
    SwrWriter.UpdateVerticalOffsetDisplay(List);
  finally
    SwrWriter.Free;
    List.Free;
  end;
  MfVerticalOffset.ComputeAverage;
end;

procedure TSwrPackage.SaveObsFormat(const Value: TSwrObsFormat);
begin
  if FObsFormat <> Value then
  begin
    FObsFormat := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetAlternativeFlowTolerance(const Value: double);
begin
  StoredAlternativeFlowTolerance.Value := Value;
end;

procedure TSwrPackage.SetContinueDespiteNonConvergence(const Value: boolean);
begin
  SetBooleanProperty(FContinueDespiteNonConvergence, Value);
end;

procedure TSwrPackage.SetConvergencePrintoutInterval(const Value: integer);
begin
  SetIntegerProperty(FConvergencePrintoutInterval, Value);
end;

procedure TSwrPackage.SetDropThreshold(const Value: double);
begin
  StoredDropThreshold.Value := Value;
end;

procedure TSwrPackage.SetStoredDropThreshold(const Value: TRealStorage);
begin
  FStoredDropThreshold.Assign(Value);
end;

procedure TSwrPackage.SetEvapAssignmentMethod(const Value: TUpdateMethod);
begin
  if FEvapAssignmentMethod <> Value then
  begin
    FEvapAssignmentMethod := Value;
    InvalidateModel;
    if FMfEvaporation <> nil then
    begin
      FMfEvaporation.Invalidate;
    end;
  end;
end;

procedure TSwrPackage.SetEvapSpecification(
  const Value: TSwrSpecificationMethod);
begin
  if FEvapSpecification <> Value then
  begin
    FEvapSpecification := Value;
    InvalidateModel;
    if FMfEvaporation <> nil then
    begin
      FMfEvaporation.Invalidate;
    end;
  end;
end;

procedure TSwrPackage.SetExchangeTolerance(const Value: double);
begin
  StoredExchangeTolerance.Value := Value;
end;

procedure TSwrPackage.SetExchangeToleranceOption(
  const Value: TSwrExchangeTolerance);
begin
  if FExchangeToleranceOption <> Value then
  begin
    FExchangeToleranceOption := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetFlowTolerance(const Value: double);
begin
  StoredFlowTolerance.Value := Value;
end;

procedure TSwrPackage.SetFlowToleranceOption(
  const Value: TSwrFlowToleranceOption);
begin
  if FFlowToleranceOption <> Value then
  begin
    FFlowToleranceOption := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetInitialTimeStepLength(const Value: double);
begin
  StoredInitialTimeStepLength.Value := Value;
end;

procedure TSwrPackage.SetLateralInflowSpecification(
  const Value: TSwrSpecificationMethod);
begin
  if FLateralInflowSpecification <> Value then
  begin
    FLateralInflowSpecification := Value;
    InvalidateModel;
    if FMfLatInflow <> nil then
    begin
      FMfLatInflow.Invalidate;
    end;
  end;
end;

procedure TSwrPackage.SetLatInflowAssignmentMethod(const Value: TUpdateMethod);
begin
  if FLatInflowAssignmentMethod <> Value then
  begin
    FLatInflowAssignmentMethod := Value;
    InvalidateModel;
    if FMfLatInflow <> nil then
    begin
      FMfLatInflow.Invalidate;
    end;
  end;
end;

procedure TSwrPackage.SetStoredMaxInflowChange(const Value: TRealStorage);
begin
  FStoredMaxInflowChange.Assign(Value);
end;

procedure TSwrPackage.SetMaxInflowChange(const Value: double);
begin
  StoredMaxInflowChange.Value := Value;
end;

procedure TSwrPackage.SetMaxInnerIterations(const Value: integer);
begin
  SetIntegerProperty(FMaxInnerIterations, Value);
end;

procedure TSwrPackage.SetMaxLevels(const Value: integer);
begin
  SetIntegerProperty(FMaxLevels, Value);
end;

procedure TSwrPackage.SetMaxLineSearchIterations(const Value: integer);
begin
  SetIntegerProperty(FMaxLineSearchIterations, Value);
end;

procedure TSwrPackage.SetMaxOuterIterations(const Value: integer);
begin
  SetIntegerProperty(FMaxOuterIterations, Value);
end;

procedure TSwrPackage.SetMaxRainfallForStepAdjustment(const Value: double);
begin
  StoredMaxRainfallForStepAdjustment.Value := Value;
end;

procedure TSwrPackage.SetMaxStageChangePerStep(const Value: double);
begin
  StoredMaxStageChangePerStep.Value := Value;
end;

procedure TSwrPackage.SetMaxTimeStepLength(const Value: double);
begin
  StoredMaxTimeStepLength.Value := Value;
end;

procedure TSwrPackage.SetMinDepthForOutflow(const Value: double);
begin
  StoredMinDepthForOutflow.Value := Value;
end;

procedure TSwrPackage.SetMinGradientForDiffusiveFlow(const Value: double);
begin
  StoredMinGradientForDiffusiveFlow.Value := Value;
end;

procedure TSwrPackage.SetMinTimeStepLength(const Value: double);
begin
  StoredMinTimeStepLength.Value := Value;
end;

procedure TSwrPackage.SetStoredMaxStageChangePerStep(const Value: TRealStorage);
begin
  FStoredMaxStageChangePerStep.Assign(Value);
end;

procedure TSwrPackage.SetNewtonCorrection(const Value: TSwrNewtonCorrection);
begin
  if FNewtonCorrection <> Value then
  begin
    FNewtonCorrection := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetOnlyUseSWR(const Value: boolean);
begin
  SetBooleanProperty(FOnlyUseSWR, Value);
end;

procedure TSwrPackage.SetPreconditioner(const Value: TSwrPreconditioner);
begin
  if FPreconditioner <> Value then
  begin
    FPreconditioner := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetPrintConvergence(const Value: TSwrPrintConvergence);
begin
  if FPrintConvergence <> Value then
  begin
    FPrintConvergence := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetPrintInflowsAndOutflows(const Value: TSwrPrintOption);
begin
  if FPrintInflowsAndOutflows <> Value then
  begin
    FPrintInflowsAndOutflows := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetPrintLineSearchInterval(const Value: integer);
begin
  SetIntegerProperty(FPrintLineSearchInterval, Value);
end;

procedure TSwrPackage.SetPrintMaxFroude(const Value: Boolean);
begin
  SetBooleanProperty(FPrintMaxFroude,  Value);
end;

procedure TSwrPackage.SetPrintReachExchangeAndProperties(
  const Value: TSwrPrintOption);
begin
  if FPrintReachExchangeAndProperties <> Value then
  begin
    FPrintReachExchangeAndProperties := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetPrintReachLateralFlow(const Value: TSwrPrintOption);
begin
  if FPrintReachLateralFlow <> Value then
  begin
    FPrintReachLateralFlow := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetPrintStage(const Value: TSwrPrintOption);
begin
  if FPrintStage <> Value then
  begin
    FPrintStage := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetPrintStructureFlow(const Value: TSwrPrintOption);
begin
  if FPrintStructureFlow <> Value then
  begin
    FPrintStructureFlow := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetPrintSwrDataToScreen(const Value: boolean);
begin
  SetBooleanProperty(FPrintSwrDataToScreen, Value);
end;

procedure TSwrPackage.SetRainAssignmentMethod(const Value: TUpdateMethod);
begin
  if FRainAssignmentMethod <> Value then
  begin
    FRainAssignmentMethod := Value;
    InvalidateModel;
    if FMfRainfall <> nil then
    begin
      FMfRainfall.Invalidate;
    end;
  end;
end;

procedure TSwrPackage.SetRainSpecification(
  const Value: TSwrSpecificationMethod);
begin
  if FRainSpecification <> Value then
  begin
    FRainSpecification := Value;
    InvalidateModel;
    if FMfRainfall <> nil then
    begin
      FMfRainfall.Invalidate;
    end;
  end;
end;

procedure TSwrPackage.SetReordering(const Value: TSwrReordering);
begin
  if FReordering <> Value then
  begin
    FReordering := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetSaveAverageSimulatedResults(
  const Value: boolean);
begin
  SetBooleanProperty(FSaveAverageSimulatedResults, Value);
end;

procedure TSwrPackage.SetSaveConvergenceHistory(const Value: boolean);
begin
  SetBooleanProperty(FSaveConvergenceHistory, Value);
end;

procedure TSwrPackage.SetSaveFrequency(const Value: Double);
begin
  StoredSaveFrequency.Value := Value;
end;

procedure TSwrPackage.SetSaveObs(const Value: TSwrSaveObservations);
begin
  if FSaveObs <> Value then
  begin
    FSaveObs := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetSaveRiver(const Value: TSwrSaveRiver);
begin
  if FSaveRiver <> Value then
  begin
    FSaveRiver := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetSaveSwrTimeStepLength(const Value: TSwrPrintOption);
begin
  if FSaveSwrTimeStepLength <> Value then
  begin
    FSaveSwrTimeStepLength := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetScaling(const Value: TSwrScaling);
begin
  if FScaling <> Value then
  begin
    FScaling := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetSolver(const Value: TSwrSolver);
begin
  if FSolver <> Value then
  begin
    FSolver := Value;
    InvalidateModel;
  end;
end;

procedure TSwrPackage.SetStageAssignmentMethod(const Value: TUpdateMethod);
begin
  if FStageAssignmentMethod <> Value then
  begin
    FStageAssignmentMethod := Value;
    InvalidateModel;
    if FMfStage <> nil then
    begin
      FMfStage.Invalidate;
    end;
  end;
  FStageAssignmentMethod := Value;
end;

procedure TSwrPackage.SetStageSpecification(
  const Value: TSwrSpecificationMethod);
begin
  if FStageSpecification <> Value then
  begin
    FStageSpecification := Value;
    InvalidateModel;
    if FMfStage <> nil then
    begin
      FMfStage.Invalidate;
    end;
  end;
end;

procedure TSwrPackage.SetStageTolerance(const Value: double);
begin
  StoredStageTolerance.Value := Value;
end;

procedure TSwrPackage.SetSteadyStateDampingFactor(const Value: double);
begin
  StoredSteadyStateDampingFactor.Value := Value;
end;

procedure TSwrPackage.SetStoredAlternativeFlowTolerance(
  const Value: TRealStorage);
begin
  FStoredAlternativeFlowTolerance.Assign(Value);
end;

procedure TSwrPackage.SetStoredExchangeTolerance(const Value: TRealStorage);
begin
  FStoredExchangeTolerance.Assign(Value);
end;

procedure TSwrPackage.SetStoredFlowTolerance(const Value: TRealStorage);
begin
  FStoredFlowTolerance.Assign(Value);
end;

procedure TSwrPackage.SetStoredInitialTimeStepLength(const Value: TRealStorage);
begin
  FStoredInitialTimeStepLength.Assign(Value);
end;

procedure TSwrPackage.SetStoredMaxRainfallForStepAdjustment(
  const Value: TRealStorage);
begin
  FStoredMaxRainfallForStepAdjustment.Assign(Value);
end;

procedure TSwrPackage.SetStoredMaxTimeStepLength(const Value: TRealStorage);
begin
  FStoredMaxTimeStepLength.Assign(Value);
end;

procedure TSwrPackage.SetStoredMinDepthForOutflow(const Value: TRealStorage);
begin
  FStoredMinDepthForOutflow.Assign(Value);
end;

procedure TSwrPackage.SetStoredMinGradientForDiffusiveFlow(
  const Value: TRealStorage);
begin
  FStoredMinGradientForDiffusiveFlow.Assign(Value);
end;

procedure TSwrPackage.SetStoredMinTimeStepLength(const Value: TRealStorage);
begin
  FStoredMinTimeStepLength.Assign(Value);
end;

procedure TSwrPackage.SetStoredSaveFrequency(const Value: TRealStorage);
begin
  FStoredSaveFrequency.Assign(Value);
end;

procedure TSwrPackage.SetStoredStageTolerance(const Value: TRealStorage);
begin
  FStoredStageTolerance.Assign(Value);
end;

procedure TSwrPackage.SetStoredSteadyStateDampingFactor(
  const Value: TRealStorage);
begin
  FStoredSteadyStateDampingFactor.Assign(Value);
end;

procedure TSwrPackage.SetStoredTimeStepMultiplier(const Value: TRealStorage);
begin
  FStoredTimeStepMultiplier.Assign(Value);
end;

procedure TSwrPackage.SetStoredTransientDampingFactor(
  const Value: TRealStorage);
begin
  FStoredTransientDampingFactor.Assign(Value);
end;

procedure TSwrPackage.SetTimeStepIncreaseFrequency(const Value: integer);
begin
  SetIntegerProperty(FTimeStepIncreaseFrequency, Value);
end;

procedure TSwrPackage.SetTimeStepMultiplier(const Value: double);
begin
  StoredTimeStepMultiplier.Value := Value;
end;

procedure TSwrPackage.SetTransientDampingFactor(const Value: double);
begin
  StoredTransientDampingFactor.Value := Value;
end;

procedure TSwrPackage.SetUseInexactNewton(const Value: boolean);
begin
  SetBooleanProperty(FUseInexactNewton, Value);
end;

procedure TSwrPackage.SetUseLaggedStagesAndFlows(const Value: Boolean);
begin
  SetBooleanProperty(FUseLaggedStagesAndFlows, Value);
end;

procedure TSwrPackage.SetUseLinearDepthScaling(const Value: Boolean);
begin
  SetBooleanProperty(FUseLinearDepthScaling, Value);
end;

procedure TSwrPackage.SetUseSteadyStateStorage(const Value: Boolean);
begin
  SetBooleanProperty(FUseSteadyStateStorage, Value);
end;

procedure TSwrPackage.SetUseUpstreamWeightingForDiffusiveWave(
  const Value: Boolean);
begin
  SetBooleanProperty(FUseUpstreamWeightingForDiffusiveWave, Value);
end;

procedure TSwrPackage.ValuesChanged(Sender: TObject);
begin
  InvalidateModel;
end;

{ TMnw1Package }

procedure TMnw1Package.Assign(Source: TPersistent);
var
  MnwSource: TMnw1Package;
begin
  if Source is TMnw1Package then
  begin
    MnwSource := TMnw1Package(Source);
    MaxMnwIterations := MnwSource.MaxMnwIterations;
    LossType := MnwSource.LossType;
    LossExponent := MnwSource.LossExponent;
    WellFileName := MnwSource.WellFileName;
    ByNodeFileName := MnwSource.ByNodeFileName;
    QSumFileName := MnwSource.QSumFileName;
    ByNodePrintFrequency := MnwSource.ByNodePrintFrequency;
    QSumPrintFrequency := MnwSource.QSumPrintFrequency;
  end;
  inherited;
end;

constructor TMnw1Package.Create(Model: TBaseModel);
begin
  inherited;
  FStoredLossExponent := TRealStorage.Create;
  FStoredLossExponent.OnChange := OnValueChanged;
  InitializeVariables;

  if Model <> nil then
  begin
    FMfDesiredPumpingRate := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfDesiredPumpingRate.OnInitialize := InitializeMnw1;
    FMfDesiredPumpingRate.OnGetUseList := GetDesiredPumpingRateUseList;
    FMfDesiredPumpingRate.OnTimeListUsed := PackageUsed;
    FMfDesiredPumpingRate.Name := StrMNW1DesiredPumping;
    FMfDesiredPumpingRate.Orientation := dso3D;
    AddTimeList(FMfDesiredPumpingRate);

    FMfWaterQuality := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfWaterQuality.OnInitialize := InitializeMnw1;
    FMfWaterQuality.OnGetUseList := GetWaterQualityUseList;
    FMfWaterQuality.OnTimeListUsed := PackageUsed;
    FMfWaterQuality.Name := StrMNW1WaterQuality;
    FMfWaterQuality.Orientation := dso3D;
    AddTimeList(FMfWaterQuality);

    FMfWellRadius := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfWellRadius.OnInitialize := InitializeMnw1;
    FMfWellRadius.OnGetUseList := GetWellRadiusUseList;
    FMfWellRadius.OnTimeListUsed := PackageUsed;
    FMfWellRadius.Name := StrMNW1WellRadius;
    FMfWellRadius.Orientation := dso3D;
    AddTimeList(FMfWellRadius);

    FMfConductance := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfConductance.OnInitialize := InitializeMnw1;
    FMfConductance.OnGetUseList := GetConductanceUseList;
    FMfConductance.OnTimeListUsed := PackageUsed;
    FMfConductance.Name := StrMNW1Conductance;
    FMfConductance.Orientation := dso3D;
    AddTimeList(FMfConductance);

    FMfSkinFactor := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfSkinFactor.OnInitialize := InitializeMnw1;
    FMfSkinFactor.OnGetUseList := GetSkinUseList;
    FMfSkinFactor.OnTimeListUsed := PackageUsed;
    FMfSkinFactor.Name := StrMNW1Skin;
    FMfSkinFactor.Orientation := dso3D;
    AddTimeList(FMfSkinFactor);

    FMfLimitingWaterLevel := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfLimitingWaterLevel.OnInitialize := InitializeMnw1;
    FMfLimitingWaterLevel.OnGetUseList := GetLimitingWaterLevelUseList;
    FMfLimitingWaterLevel.OnTimeListUsed := PackageUsed;
    FMfLimitingWaterLevel.Name := StrMNW1LimitingWater;
    FMfLimitingWaterLevel.Orientation := dso3D;
    AddTimeList(FMfLimitingWaterLevel);

    FMfReferenceElevation := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfReferenceElevation.OnInitialize := InitializeMnw1;
    FMfReferenceElevation.OnGetUseList := GetReferenceElevationUseList;
    FMfReferenceElevation.OnTimeListUsed := PackageUsed;
    FMfReferenceElevation.Name := StrMNW1ReferenceEleva;
    FMfReferenceElevation.Orientation := dso3D;
    AddTimeList(FMfReferenceElevation);

    FMfWaterQualityGroup := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfWaterQualityGroup.OnInitialize := InitializeMnw1;
    FMfWaterQualityGroup.OnGetUseList := GetWaterQualityGroupUseList;
    FMfWaterQualityGroup.OnTimeListUsed := PackageUsed;
    FMfWaterQualityGroup.Name := StrMNW1WaterQualityG;
    FMfWaterQualityGroup.Orientation := dso3D;
    AddTimeList(FMfWaterQualityGroup);

    FMfNonLinearLossCoefficient := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfNonLinearLossCoefficient.OnInitialize := InitializeMnw1;
    FMfNonLinearLossCoefficient.OnGetUseList := GetNonLinearLossCoefficientUseList;
    FMfNonLinearLossCoefficient.OnTimeListUsed := PackageUsed;
    FMfNonLinearLossCoefficient.Name := StrMNW1NonlinearLoss;
    FMfNonLinearLossCoefficient.Orientation := dso3D;
    AddTimeList(FMfNonLinearLossCoefficient);

    FMfMinimumPumpingRate := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfMinimumPumpingRate.OnInitialize := InitializeMnw1;
    FMfMinimumPumpingRate.OnGetUseList := GetMinimumPumpingRateUseList;
    FMfMinimumPumpingRate.OnTimeListUsed := PackageUsed;
    FMfMinimumPumpingRate.Name := StrMNW1MinimumPumping;
    FMfMinimumPumpingRate.Orientation := dso3D;
    AddTimeList(FMfMinimumPumpingRate);

    FMfReactivationPumpingRate := TModflowBoundaryDisplayTimeList.Create(Model);
    FMfReactivationPumpingRate.OnInitialize := InitializeMnw1;
    FMfReactivationPumpingRate.OnGetUseList := GetReactivationPumpingRateUseList;
    FMfReactivationPumpingRate.OnTimeListUsed := PackageUsed;
    FMfReactivationPumpingRate.Name := StrMNW1ReactivationPu;
    FMfReactivationPumpingRate.Orientation := dso3D;
    AddTimeList(FMfReactivationPumpingRate);

  end;

end;

destructor TMnw1Package.Destroy;
begin
  FMfReactivationPumpingRate.Free;
  FMfMinimumPumpingRate.Free;
  FMfNonLinearLossCoefficient.Free;
  FMfWaterQualityGroup.Free;
  FMfReferenceElevation.Free;
  FMfLimitingWaterLevel.Free;
  FMfSkinFactor.Free;
  FMfConductance.Free;
  FMfWellRadius.Free;
  FMfWaterQuality.Free;
  FMfDesiredPumpingRate.Free;
  FStoredLossExponent.Free;
  inherited;
end;

procedure TMnw1Package.GetConductanceUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(ConductancePosition, NewUseList);
end;

procedure TMnw1Package.GetDesiredPumpingRateUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(DesiredPumpingRatePosition, NewUseList);
end;

procedure TMnw1Package.GetLimitingWaterLevelUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(LimitingWaterLevelPosition, NewUseList);
end;

function TMnw1Package.GetLossExponent: Double;
begin
  result := FStoredLossExponent.Value;
end;

procedure TMnw1Package.GetMinimumPumpingRateUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(MinimumPumpingRatePosition, NewUseList);
end;

procedure TMnw1Package.GetNonLinearLossCoefficientUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(NonLinearLossCoefficientPosition, NewUseList);
end;

procedure TMnw1Package.GetReactivationPumpingRateUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(ReactivationPumpingRatePosition, NewUseList);
end;

procedure TMnw1Package.GetReferenceElevationUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(ReferenceElevationPosition, NewUseList);
end;

function TMnw1Package.GetRelativeByNodeFileName: string;
begin
  if FModel = nil then
  begin
    result := ByNodeFileName;
  end
  else
  begin
    result := ExtractRelativePath((FModel as TCustomModel).ModelFileName,
      ByNodeFileName);
  end;
end;

function TMnw1Package.GetRelativeQSumFileName: string;
begin
  if FModel = nil then
  begin
    result := QSumFileName;
  end
  else
  begin
    result := ExtractRelativePath((FModel as TCustomModel).ModelFileName,
      QSumFileName);
  end;
end;

function TMnw1Package.GetRelativeWellFileName: string;
begin
  if FModel = nil then
  begin
    result := WellFileName;
  end
  else
  begin
    result := ExtractRelativePath((FModel as TCustomModel).ModelFileName,
      WellFileName);
  end;
end;

procedure TMnw1Package.GetSkinUseList(Sender: TObject; NewUseList: TStringList);
begin
  GetUseList(SkinFactorPosition, NewUseList);
end;

procedure TMnw1Package.InitializeMnw1(Sender: TObject);
var
  List: TModflowBoundListOfTimeLists;
  Mnw1Writer: TModflowMNW1_Writer;
begin
  MfDesiredPumpingRate.CreateDataSets;
  MfWaterQuality.CreateDataSets;
  MfWellRadius.CreateDataSets;
  MfConductance.CreateDataSets;
  MfSkinFactor.CreateDataSets;
  MfLimitingWaterLevel.CreateDataSets;
  MfReferenceElevation.CreateDataSets;
  MfWaterQualityGroup.CreateDataSets;
  MfNonLinearLossCoefficient.CreateDataSets;
  MfMinimumPumpingRate.CreateDataSets;
  MfReactivationPumpingRate.CreateDataSets;

  List := TModflowBoundListOfTimeLists.Create;
  Mnw1Writer := TModflowMNW1_Writer.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfDesiredPumpingRate);
    List.Add(MfWaterQuality);
    List.Add(MfWellRadius);
    List.Add(MfConductance);
    List.Add(MfSkinFactor);
    List.Add(MfLimitingWaterLevel);
    List.Add(MfReferenceElevation);
    List.Add(MfWaterQualityGroup);
    List.Add(MfNonLinearLossCoefficient);
    List.Add(MfMinimumPumpingRate);
    List.Add(MfReactivationPumpingRate);

    Mnw1Writer.UpdateDisplay(List);
  finally
    Mnw1Writer.Free;
    List.Free;
  end;
  MfDesiredPumpingRate.ComputeAverage;
  MfWaterQuality.ComputeAverage;
  MfWellRadius.ComputeAverage;
  MfConductance.ComputeAverage;
  MfSkinFactor.ComputeAverage;
  MfLimitingWaterLevel.ComputeAverage;
  MfReferenceElevation.ComputeAverage;
  MfWaterQualityGroup.ComputeAverage;
  MfNonLinearLossCoefficient.ComputeAverage;
  MfMinimumPumpingRate.ComputeAverage;
  MfReactivationPumpingRate.ComputeAverage;
end;

procedure TMnw1Package.InitializeVariables;
begin
  inherited;
  LossExponent := 1;
  MaxMnwIterations := 9999;
  LossType := mlt1Skin;
  WellFileName := '';
  ByNodeFileName := '';
  QSumFileName := '';
  ByNodePrintFrequency := mpfOutputControl;
  QSumPrintFrequency := mpfOutputControl;
end;

procedure TMnw1Package.GetUseList(ParameterIndex: Integer; NewUseList: TStringList);
var
  Item: TMnw1Item;
  ScreenObjectIndex: Integer;
  Boundary: TMnw1Boundary;
  LocalModel: TCustomModel;
  ScreenObject: TScreenObject;
  ValueIndex: Integer;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowMnw1Boundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count - 1 do
      begin
        Item := Boundary.Values[ValueIndex] as TMnw1Item;
        UpdateUseList(ParameterIndex, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TMnw1Package.GetWaterQualityGroupUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(WaterQualityGroupPosition, NewUseList);
end;

procedure TMnw1Package.GetWaterQualityUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(WaterQualityPosition, NewUseList);
end;

procedure TMnw1Package.GetWellRadiusUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(WellRadiusPosition, NewUseList);
end;

procedure TMnw1Package.SetByNodeFileName(const Value: string);
begin
  SetStringProperty(FByNodeFileName, Value);
end;

procedure TMnw1Package.SetByNodePrintFrequency(
  const Value: TMnw1PrintFrequency);
begin
  if FByNodePrintFrequency <> Value then
  begin
    FByNodePrintFrequency := Value;
    InvalidateModel;
  end;
end;

procedure TMnw1Package.SetLossExponent(const Value: Double);
begin
  FStoredLossExponent.Value := Value;
end;

procedure TMnw1Package.SetLossType(const Value: TMnw1LossType);
begin
  if FLossType <> Value then
  begin
    FLossType := Value;
    InvalidateModel;
  end;
end;

procedure TMnw1Package.SetMaxMnwIterations(const Value: integer);
begin
  SetIntegerProperty(FMaxMnwIterations, Value);
end;

procedure TMnw1Package.SetQSumFileName(const Value: string);
begin
  SetStringProperty(FQSumFileName, Value);
end;

procedure TMnw1Package.SetQSumPrintFrequency(const Value: TMnw1PrintFrequency);
begin
  if FQSumPrintFrequency <> Value then
  begin
    FQSumPrintFrequency := Value;
    InvalidateModel;
  end;
end;

procedure TMnw1Package.SetRelativeByNodeFileName(const Value: string);
begin
  ByNodeFileName := ExpandFileName(Value);
end;

procedure TMnw1Package.SetRelativeQSumFileName(const Value: string);
begin
  QSumFileName := ExpandFileName(Value);
end;

procedure TMnw1Package.SetRelativeWellFileName(const Value: string);
begin
  WellFileName := ExpandFileName(Value);
end;

procedure TMnw1Package.SetStoredLossExponent(const Value: TRealStorage);
begin
  FStoredLossExponent.Assign(Value);
end;

procedure TMnw1Package.SetWellFileName(const Value: string);
begin
  SetStringProperty(FWellFileName, Value);
end;

{ TNpfSelection }

procedure TNpfPackage.Assign(Source: TPersistent);
var
  SourceNfp: TNpfPackage;
begin
  if Source is TNpfPackage then
  begin
    SourceNfp := TNpfPackage(Source);
    CellAveraging := SourceNfp.CellAveraging;
    UseSaturatedThickness := SourceNfp.UseSaturatedThickness;
    FTimeVaryingVerticalConductance := SourceNfp.FTimeVaryingVerticalConductance;
    Dewatered := SourceNfp.Dewatered;
    Perched := SourceNfp.Perched;
    UseNewtonRaphson := SourceNfp.UseNewtonRaphson;
    ApplyHeadDampening := SourceNfp.ApplyHeadDampening;
  end;
  inherited;
end;

constructor TNpfPackage.Create(Model: TBaseModel);
begin
  inherited;
  InitializeVariables;
end;

procedure TNpfPackage.InitializeVariables;
begin
  inherited;
  CellAveraging := caHarmonic;
  UseSaturatedThickness := False;
  FTimeVaryingVerticalConductance := False;
  Dewatered := False;
  Perched := False;
  UseNewtonRaphson := False;
  ApplyHeadDampening := False;
end;

procedure TNpfPackage.SetApplyHeadDampening(const Value: boolean);
begin
  if FApplyHeadDampening <> Value then
  begin
    FApplyHeadDampening := Value;
    InvalidateModel;
  end;
end;

procedure TNpfPackage.SetCellAveraging(const Value: TCellAveraging);
begin
  if FCellAveraging <> Value then
  begin
    FCellAveraging := Value;
    InvalidateModel;
  end;
end;

procedure TNpfPackage.SetDewatered(const Value: boolean);
begin
  if FDewatered <> Value then
  begin
    FDewatered := Value;
    InvalidateModel;
  end;
end;

procedure TNpfPackage.SetPerched(const Value: Boolean);
begin
  if FPerched <> Value then
  begin
    FPerched := Value;
    InvalidateModel;
  end;
end;

procedure TNpfPackage.SetTimeVaryingVerticalConductance(const Value: boolean);
begin
  if FTimeVaryingVerticalConductance <> Value then
  begin
    FTimeVaryingVerticalConductance := Value;
    InvalidateModel;
  end;
end;

procedure TNpfPackage.SetUseNewtonRaphson(const Value: boolean);
begin
  if FUseNewtonRaphson <> Value then
  begin
    FUseNewtonRaphson := Value;
    InvalidateModel;
  end;
end;

procedure TNpfPackage.SetUseSaturatedThickness(const Value: boolean);
begin
  if FUseSaturatedThickness <> Value then
  begin
    FUseSaturatedThickness := Value;
    InvalidateModel;
  end;
end;

{ TStoPackage }

procedure TStoPackage.Assign(Source: TPersistent);
var
  SourcePkg: TStoPackage;
begin
  if Source is TStoPackage then
  begin
    SourcePkg := TStoPackage(Source);
    StorageChoice := SourcePkg.StorageChoice;
    UseNewtonRaphson := SourcePkg.UseNewtonRaphson;
  end;
  inherited;
end;

constructor TStoPackage.Create(Model: TBaseModel);
begin
  inherited;
  InitializeVariables;
end;

procedure TStoPackage.InitializeVariables;
begin
  inherited;
  StorageChoice := scSpecificStorage;
  UseNewtonRaphson := False;
end;

procedure TStoPackage.SetStorageChoice(const Value: TStorageChoice);
begin
  if FStorageChoice <> Value then
  begin
    FStorageChoice := Value;
    InvalidateModel;
  end;
end;

procedure TStoPackage.SetUseNewtonRaphson(const Value: Boolean);
begin
  if FUseNewtonRaphson <> Value then
  begin
    FUseNewtonRaphson := Value;
    InvalidateModel;
  end;
end;

{ TSmsPackageSelection }

procedure TSmsPackageSelection.Assign(Source: TPersistent);
var
  SourceSms: TSmsPackageSelection;
begin
  if Source is TSmsPackageSelection then
  begin
    SourceSms := TSmsPackageSelection(Source);
    OuterHclose := SourceSms.OuterHclose;
    UnderRelaxTheta := SourceSms.UnderRelaxTheta;
    UnderRelaxKappa := SourceSms.UnderRelaxKappa;
    UnderRelaxGamma := SourceSms.UnderRelaxGamma;
    UnderRelaxMomentum := SourceSms.UnderRelaxMomentum;
    BacktrackingTolerance := SourceSms.BacktrackingTolerance;
    BacktrackingReductionFactor := SourceSms.BacktrackingReductionFactor;
    BacktrackingResidualLimit := SourceSms.BacktrackingResidualLimit;
    InnerHclose := SourceSms.InnerHclose;
    InnerRclose := SourceSms.InnerRclose;
    RelaxationFactor := SourceSms.RelaxationFactor;
    PreconditionerDropTolerance := SourceSms.PreconditionerDropTolerance;
    Print := SourceSms.Print;
    Complexity := SourceSms.Complexity;
    MaxOuterIterations := SourceSms.MaxOuterIterations;
    UnderRelaxation := SourceSms.UnderRelaxation;
    BacktrackingNumber := SourceSms.BacktrackingNumber;
    LinearSolver := SourceSms.LinearSolver;
    InnerMaxIterations := SourceSms.InnerMaxIterations;
    LinLinearAcceleration := SourceSms.LinLinearAcceleration;
    PreconditionerLevel := SourceSms.PreconditionerLevel;
    NumberOfOrthoganalizations := SourceSms.NumberOfOrthoganalizations;
    ReorderingMethod := SourceSms.ReorderingMethod;
    RcloseOption := SourceSms.RcloseOption;
    ScalingMethod := SourceSms.ScalingMethod;
    XmdLinearAcceleration := SourceSms.XmdLinearAcceleration;
    RedBlackOrder := SourceSms.RedBlackOrder;
    SmsOverrides := SourceSms.SmsOverrides;
    SolutionGroupMaxIteration := SourceSms.SolutionGroupMaxIteration;
    ContinueModel := SourceSms.ContinueModel;
  end;
  inherited;
end;

constructor TSmsPackageSelection.Create(Model: TBaseModel);
begin
  inherited;
  FStoredBacktrackingResidualLimit := TRealStorage.Create;
  FStoredBacktrackingResidualLimit.OnChange := OnValueChanged;

  FStoredUnderRelaxMomentum := TRealStorage.Create;
  FStoredUnderRelaxMomentum.OnChange := OnValueChanged;

  FStoredInnerRclose := TRealStorage.Create;
  FStoredInnerRclose.OnChange := OnValueChanged;

  FStoredOuterHclose := TRealStorage.Create;
  FStoredOuterHclose.OnChange := OnValueChanged;

  FStoredBacktrackingTolerance := TRealStorage.Create;
  FStoredBacktrackingTolerance.OnChange := OnValueChanged;

  FStoredUnderRelaxKappa := TRealStorage.Create;
  FStoredUnderRelaxKappa.OnChange := OnValueChanged;

  FStoredPreconditionerDropTolerance := TRealStorage.Create;
  FStoredPreconditionerDropTolerance.OnChange := OnValueChanged;

  FStoredBacktrackingReductionFactor := TRealStorage.Create;
  FStoredBacktrackingReductionFactor.OnChange := OnValueChanged;

  FStoredUnderRelaxGamma := TRealStorage.Create;
  FStoredUnderRelaxGamma.OnChange := OnValueChanged;

  FStoredInnerHclose := TRealStorage.Create;
  FStoredInnerHclose.OnChange := OnValueChanged;

  FStoredRelaxationFactor := TRealStorage.Create;
  FStoredRelaxationFactor.OnChange := OnValueChanged;

  FStoredUnderRelaxTheta := TRealStorage.Create;
  FStoredUnderRelaxTheta.OnChange := OnValueChanged;

  InitializeVariables;
end;

destructor TSmsPackageSelection.Destroy;
begin
  FStoredInnerRclose.Free;
  FStoredOuterHclose.Free;
  FStoredBacktrackingTolerance.Free;
  FStoredUnderRelaxKappa.Free;
  FStoredPreconditionerDropTolerance.Free;
  FStoredBacktrackingReductionFactor.Free;
  FStoredUnderRelaxGamma.Free;
  FStoredInnerHclose.Free;
  FStoredRelaxationFactor.Free;
  FStoredUnderRelaxTheta.Free;
  FStoredUnderRelaxMomentum.Free;
  FStoredBacktrackingResidualLimit.Free;
  inherited;
end;

function TSmsPackageSelection.GetBacktrackingReductionFactor: double;
begin
  Result := StoredBacktrackingReductionFactor.Value;
end;

function TSmsPackageSelection.GetBacktrackingResidualLimit: double;
begin
  Result := StoredBacktrackingResidualLimit.Value;
end;

function TSmsPackageSelection.GetBacktrackingTolerance: double;
begin
  Result := StoredBacktrackingTolerance.Value;
end;

function TSmsPackageSelection.GetInnerHclose: double;
begin
  Result := StoredInnerHclose.Value;
end;

function TSmsPackageSelection.GetInnerRclose: double;
begin
  Result := StoredInnerRclose.Value;
end;

function TSmsPackageSelection.GetPreconditionerDropTolerance: double;
begin
  Result := StoredPreconditionerDropTolerance.Value;
end;

function TSmsPackageSelection.GetOuterHclose: double;
begin
  Result := StoredOuterHclose.Value;
end;

function TSmsPackageSelection.GetRelaxationFactor: double;
begin
  Result := StoredRelaxationFactor.Value;
end;

function TSmsPackageSelection.GetUnderRelaxGamma: double;
begin
  Result := StoredUnderRelaxGamma.Value;
end;

function TSmsPackageSelection.GetUnderRelaxKappa: double;
begin
  Result := StoredUnderRelaxKappa.Value;
end;

function TSmsPackageSelection.GetUnderRelaxMomentum: double;
begin
  Result := StoredUnderRelaxMomentum.Value;
end;

function TSmsPackageSelection.GetUnderRelaxTheta: double;
begin
  Result := StoredUnderRelaxTheta.Value;
end;

procedure TSmsPackageSelection.InitializeVariables;
begin
  inherited;
  OuterHclose := 1e-3;
  UnderRelaxTheta := 0.7;
  UnderRelaxKappa := 0.1;
  UnderRelaxGamma := 0.2;
  UnderRelaxMomentum := 1E-3;
  BacktrackingTolerance := 1E4;
  BacktrackingReductionFactor := 0.2;
  BacktrackingResidualLimit := 100;
  InnerHclose := 1E-4;
  InnerRclose := 0.1;
  RelaxationFactor := 0;
  PreconditionerDropTolerance := 0;
  Print := spFull;
  Complexity := scoSimple;
  MaxOuterIterations := 100;
  UnderRelaxation := surNone;
  BacktrackingNumber := 10;
  LinearSolver := slsDefault;
  InnerMaxIterations := 100;
  LinLinearAcceleration := sllaCg;
  PreconditionerLevel := 0;
  NumberOfOrthoganalizations := 7;
  ReorderingMethod := srmNone;
  RcloseOption := sroAbsolute;
  ScalingMethod := ssmNone;
  XmdLinearAcceleration := sxlaCg;
  RedBlackOrder := False;
  SmsOverrides := [];
  SolutionGroupMaxIteration := 1;
  ContinueModel := False;
end;

procedure TSmsPackageSelection.SetBacktrackingNumber(const Value: Integer);
begin
  if FBacktrackingNumber <> Value then
  begin
    FBacktrackingNumber := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetBacktrackingReductionFactor(
  const Value: double);
begin
  StoredBacktrackingReductionFactor.Value := Value;
end;

procedure TSmsPackageSelection.SetBacktrackingResidualLimit(
  const Value: double);
begin
  StoredBacktrackingResidualLimit.Value := Value;
end;

procedure TSmsPackageSelection.SetBacktrackingTolerance(const Value: double);
begin
  StoredBacktrackingTolerance.Value := Value;
end;

procedure TSmsPackageSelection.SetComplexity(const Value: TSmsComplexityOption);
begin
  if FComplexity <> Value then
  begin
    FComplexity := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetContinueModel(const Value: boolean);
begin
  if FContinueModel <> Value then
  begin
    FContinueModel := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetInnerHclose(const Value: double);
begin
  StoredInnerHclose.Value := Value;
end;

procedure TSmsPackageSelection.SetInnerMaxIterations(const Value: integer);
begin
  if FInnerMaxIterations <> Value then
  begin
    FInnerMaxIterations := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetInnerRclose(const Value: double);
begin
  StoredInnerRclose.Value := Value;
end;

procedure TSmsPackageSelection.SetLinearSolver(const Value: TSmsLinearSolver);
begin
  if FLinearSolver <> Value then
  begin
    FLinearSolver := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetLinLinearAcceleration(
  const Value: TSmsLinLinearAcceleration);
begin
  if FLinLinearAcceleration <> Value then
  begin
    FLinLinearAcceleration := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetPreconditionerDropTolerance(
  const Value: double);
begin
  StoredPreconditionerDropTolerance.Value := Value;
end;

procedure TSmsPackageSelection.SetMaxOuterIterations(const Value: integer);
begin
  if FMaxOuterIterations <> Value then
  begin
    FMaxOuterIterations := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetNumberOfOrthoganalizations(
  const Value: Integer);
begin
  if FNumberOfOrthoganalizations <> Value then
  begin
    FNumberOfOrthoganalizations := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetOuterHclose(const Value: double);
begin
  StoredOuterHclose.Value := Value;
end;

procedure TSmsPackageSelection.SetPreconditionerLevel(const Value: Integer);
begin
  if FPreconditionerLevel <> Value then
  begin
    FPreconditionerLevel := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetPrint(const Value: TSmsPrint);
begin
  if FPrint <> Value then
  begin
    FPrint := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetRcloseOption(const Value: TSmsRcloseOption);
begin
  if FRcloseOption <> Value then
  begin
    FRcloseOption := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetRedBlackOrder(const Value: boolean);
begin
  if FRedBlackOrder <> Value then
  begin
    FRedBlackOrder := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetRelaxationFactor(const Value: double);
begin
  StoredRelaxationFactor.Value := Value;
end;

procedure TSmsPackageSelection.SetReorderingMethod(
  const Value: TSmsReorderingMethod);
begin
  if FReorderingMethod <> Value then
  begin
    FReorderingMethod := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetScalingMethod(const Value: TSmsScalingMethod);
begin
  if FScalingMethod <> Value then
  begin
    FScalingMethod := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetSmsOverrides(const Value: TSmsOverrides);
begin
  if FSmsOverrides <> Value then
  begin
    FSmsOverrides := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetSolutionGroupMaxIteration(
  const Value: Integer);
begin
  if FSolutionGroupMaxIteration <> Value then
  begin
    FSolutionGroupMaxIteration := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetStoredBacktrackingReductionFactor(
  const Value: TRealStorage);
begin
  FStoredBacktrackingReductionFactor.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredBacktrackingResidualLimit(
  const Value: TRealStorage);
begin
  FStoredBacktrackingResidualLimit.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredBacktrackingTolerance(
  const Value: TRealStorage);
begin
  FStoredBacktrackingTolerance.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredInnerHclose(const Value: TRealStorage);
begin
  FStoredInnerHclose.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredInnerRclose(const Value: TRealStorage);
begin
  FStoredInnerRclose.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredPreconditionerDropTolerance(
  const Value: TRealStorage);
begin
  FStoredPreconditionerDropTolerance.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredOuterHclose(const Value: TRealStorage);
begin
  FStoredOuterHclose.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredRelaxationFactor(
  const Value: TRealStorage);
begin
  FStoredRelaxationFactor.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredUnderRelaxGamma(
  const Value: TRealStorage);
begin
  FStoredUnderRelaxGamma.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredUnderRelaxKappa(
  const Value: TRealStorage);
begin
  FStoredUnderRelaxKappa.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredUnderRelaxMomentum(
  const Value: TRealStorage);
begin
  FStoredUnderRelaxMomentum.Assign(Value);
end;

procedure TSmsPackageSelection.SetStoredUnderRelaxTheta(
  const Value: TRealStorage);
begin
  FStoredUnderRelaxTheta.Assign(Value);
end;

procedure TSmsPackageSelection.SetUnderRelaxation(
  const Value: TSmsUnderRelaxation);
begin
  if FUnderRelaxation <> Value then
  begin
    FUnderRelaxation := Value;
    InvalidateModel;
  end;
end;

procedure TSmsPackageSelection.SetUnderRelaxGamma(const Value: double);
begin
  StoredUnderRelaxGamma.Value := Value;
end;

procedure TSmsPackageSelection.SetUnderRelaxKappa(const Value: double);
begin
  StoredUnderRelaxKappa.Value := Value;
end;

procedure TSmsPackageSelection.SetUnderRelaxMomentum(const Value: double);
begin
  StoredUnderRelaxMomentum.Value := Value;
end;

procedure TSmsPackageSelection.SetUnderRelaxTheta(const Value: double);
begin
  StoredUnderRelaxTheta.Value := Value;
end;

procedure TSmsPackageSelection.SetXmdLinearAcceleration(
  const Value: TSmsXmdLinearAcceleration);
begin
  if FXmdLinearAcceleration <> Value then
  begin
    FXmdLinearAcceleration := Value;
    InvalidateModel;
  end;
end;

{ TRipPackage }

procedure TRipPackage.Assign(Source: TPersistent);
var
  RipSource: TRipPackage;
begin
  if Source is TRipPackage then
  begin
    RipSource := TRipPackage(Source);
    WritePlantGroupET := RipSource.WritePlantGroupET;
  end;
  inherited;

end;

constructor TRipPackage.Create(Model: TBaseModel);
begin
  inherited;
  if Model <> nil then
  begin
    FMfRipLandElevation := TModflowBoundaryDisplayTimeList.Create(Model);
    MfRipLandElevation.OnInitialize := InitializeRipDisplay;
    MfRipLandElevation.OnGetUseList := GetMfRipLandElevationUseList;
    MfRipLandElevation.OnTimeListUsed := PackageUsed;
    MfRipLandElevation.Name := StrRipGroundElevation;
    AddTimeList(MfRipLandElevation);

    FCoverageTimeLists:= TObjectModflowBoundListOfTimeLists.Create;
    FCoverageIDs := TList<Integer>.Create;

//    UpdateCoverageTimeLists;
  end;
end;

destructor TRipPackage.Destroy;
begin
  FCoverageIDs.Free;
  FCoverageTimeLists.Free;
  FMfRipLandElevation.Free;

  inherited;
end;

procedure TRipPackage.GetMfRipLandElevationUseList(Sender: TObject;
  NewUseList: TStringList);
begin
  GetUseList(0, NewUseList);
end;

procedure TRipPackage.GetCoverageUseList(Sender: TObject;
  NewUseList: TStringList);
var
  FormulaIndex: Integer;
begin
  FormulaIndex := FCoverageTimeLists.IndexOf(Sender
    as TModflowBoundaryDisplayTimeList);
  Assert(FormulaIndex >= 0);
  GetUseList(FormulaIndex+1, NewUseList);
end;

procedure TRipPackage.GetUseList(ParameterIndex: Integer;
  NewUseList: TStringList);
var
  ScreenObjectIndex: Integer;
  LocalModel: TCustomModel;
  ScreenObject: TScreenObject;
  ValueIndex: Integer;
  Boundary: TRipBoundary;
  Item: TRipItem;
begin
  { TODO -cRefactor : Consider replacing FModel with a TNotifyEvent or interface. }
  LocalModel := FModel as TCustomModel;
  for ScreenObjectIndex := 0 to LocalModel.ScreenObjectCount - 1 do
  begin
    ScreenObject := LocalModel.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowRipBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      for ValueIndex := 0 to Boundary.Values.Count - 1 do
      begin
        Item := Boundary.Values[ValueIndex] as TRipItem;
        UpdateUseList(ParameterIndex, NewUseList, Item);
      end;
    end;
  end;
end;

procedure TRipPackage.InitializeRipDisplay(Sender: TObject);
var
  RipWriter: TModflowRipWriter;
  List: TModflowBoundListOfTimeLists;
  CoverageIndex: Integer;
begin
  MfRipLandElevation.CreateDataSets;
  for CoverageIndex := 0 to FCoverageTimeLists.Count - 1 do
  begin
    FCoverageTimeLists[CoverageIndex].CreateDataSets;
  end;

  List := TModflowBoundListOfTimeLists.Create;
  RipWriter := TModflowRipWriter.Create(FModel as TCustomModel, etDisplay);
  try
    List.Add(MfRipLandElevation);
    for CoverageIndex := 0 to FCoverageTimeLists.Count - 1 do
    begin
      List.Add(FCoverageTimeLists[CoverageIndex]);
    end;
    RipWriter.UpdateDisplay(List);
  finally
    RipWriter.Free;
    List.Free;
  end;
  MfRipLandElevation.ComputeAverage;
  for CoverageIndex := 0 to FCoverageTimeLists.Count - 1 do
  begin
    FCoverageTimeLists[CoverageIndex].ComputeAverage;
  end;
end;

procedure TRipPackage.InitializeVariables;
begin
  inherited;
  WritePlantGroupET := wpgDontWrite;
  UpdateCoverageTimeLists;
end;

procedure TRipPackage.InvalidateCoverages;
var
  index: Integer;
begin
  for index := 0 to FCoverageTimeLists.Count - 1 do
  begin
    FCoverageTimeLists[index].Invalidate;
  end;
end;

procedure TRipPackage.SetWritePlantGroupET(const Value: TWritePlantGroupET);
begin
  if FWritePlantGroupET <> Value then
  begin
    FWritePlantGroupET := Value;
    InvalidateModel;
  end;
end;

procedure TRipPackage.UpdateCoverageTimeLists;
var
  PlantGroups: TRipPlantGroups;
  PlantGroupIndex: Integer;
//  APlantGroup: TObject;
  NewPlantGroupIDs: TList<Integer>;
  APlantGroup: TRipPlantGroup;
  NewID: Integer;
  OldId: Integer;
  CoverageTimeList: TModflowBoundaryDisplayTimeList;
  TimeListIndex: integer;
begin
  if FModel <> nil then
  begin
    for TimeListIndex := 0 to FCoverageTimeLists.Count - 1 do
    begin
      RemoveTimeList(FCoverageTimeLists[TimeListIndex])
    end;
    NewPlantGroupIDs := TList<Integer>.Create;
    try
      PlantGroups := ((FModel as TCustomModel).ParentModel
        as TPhastModel).RipPlantGroups;
      for PlantGroupIndex := 0 to PlantGroups.Count - 1 do
      begin
        APlantGroup := PlantGroups[PlantGroupIndex];
        NewPlantGroupIDs.Add(APlantGroup.ID);
      end;
      for PlantGroupIndex := FCoverageIDs.Count - 1 downto 0 do
      begin
        OldId := FCoverageIDs[PlantGroupIndex];
        if NewPlantGroupIDs.IndexOf(OldId) < 0 then
        begin
          FCoverageIDs.Delete(PlantGroupIndex);
          FCoverageTimeLists.Delete(PlantGroupIndex);
        end;
      end;
      for PlantGroupIndex := NewPlantGroupIDs.Count - 1 downto 0 do
      begin
        NewID := NewPlantGroupIDs[PlantGroupIndex];
        if FCoverageIDs.IndexOf(NewID) >= 0 then
        begin
          NewPlantGroupIDs.Delete(PlantGroupIndex);
        end;
      end;
      for PlantGroupIndex := 0 to PlantGroups.Count - 1 do
      begin
        APlantGroup := PlantGroups[PlantGroupIndex];
        if NewPlantGroupIDs.IndexOf(APlantGroup.ID) >= 0 then
        begin
          // Create new time list
          CoverageTimeList := TModflowBoundaryDisplayTimeList.Create(FModel);
          CoverageTimeList.OnInitialize := InitializeRipDisplay;
          CoverageTimeList.OnGetUseList := GetCoverageUseList;
          CoverageTimeList.OnTimeListUsed := PackageUsed;
          CoverageTimeList.Name := APlantGroup.Name;
          FCoverageTimeLists.Insert(PlantGroupIndex, CoverageTimeList);
          FCoverageIDs.Insert(PlantGroupIndex, APlantGroup.ID);
          AddTimeList(CoverageTimeList);
        end
        else
        begin
          CoverageTimeList := FCoverageTimeLists[PlantGroupIndex];
          CoverageTimeList.Name := APlantGroup.Name;
        end;
      end;
    finally
      NewPlantGroupIDs.Free;
    end;
  end;
end;

end.
