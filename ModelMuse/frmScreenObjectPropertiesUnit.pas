﻿{@abstract(The main purpose of @name is to define
 @link(TfrmScreenObjectProperties) which is
 used to edit one or more
 @link(ScreenObjectUnit.TScreenObject)s.)

@author(Richard B. Winston <rbwinst@usgs.gov>)
}
unit frmScreenObjectPropertiesUnit;      

interface

uses Windows,       
  SysUtils, Types, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  frmCustomGoPhastUnit, ExtCtrls, Buttons, ScreenObjectUnit, ClassificationUnit,
  Grids, RbwDataGrid4, ComCtrls, RbwParser, DataSetUnit, Contnrs,
  GoPhastTypes, PhastDataSets, framePhastInterpolationUnit, ModflowBoundaryUnit,
  RealListUnit, Spin, ArgusDataEntry, RbwEdit, FastGEO, OrderedCollectionUnit,
  JvPageList, JvExExtCtrls, JvNetscapeSplitter, JvExControls, JvComponent,
  JvExComCtrls, JvPageListTreeView, JvxCheckListBox, frameScreenObjectParamUnit,
  ImgList, UndoItemsScreenObjects, frameScreenObjectCondParamUnit,
  frameScreenObjectNoParamUnit, frameScreenObjectLAK_Unit, FluxObservationUnit,
  frameScreenObjectSFR_Unit, JvComCtrls, JvExStdCtrls,
  frameHeadObservationsUnit, frameHfbScreenObjectUnit, Mask, JvExMask, JvSpin,
  ValueArrayStorageUnit, frameIfaceUnit, frameModpathParticlesUnit,
  frameFluxObsUnit, ModflowPackageSelectionUnit, frameScreenObjectMNW2Unit,
  frameScreenObjectHydmodUnit, CheckLst, frameScreenObjectUnit,
  frameScreenObjectSsmUnit, frameCustomCellObservationUnit,
  frameConcentrationObservationUnit, CustomFrameFluxObsUnit,
  frameMt3dmsFluxObsUnit, frameCustomSutraFeatureUnit, frameScreenObjectWelUnit,
  frameSutraObservationsUnit, frameSutraBoundaryUnit, frameScreenObjectStrUnit,
  frameScreenObjectFhbHeadUnit, frameScreenObjectFhbFlowUnit,
  frameScreenObjectFmpBoundaryUnit,
  frameScreenObjectFmpPrecipUnit, frameScreenObjectFmpEvapUnit,
  frameScreenObjectCropIDUnit, frameScreenObjectCfpPipesUnit,
  frameScreenObjectCfpFixedUnit, frameScreenObjectSwrUnit,
  frameScreenObjectSwrReachUnit, ModflowSwrReachUnit, frameScreenObjectMnw1Unit,
  frameScreenObjectFarmIDUnit, frameScreenObjectFootprintWellUnit,
  frameSwiObsInterpolatedUnit, frameScreenObjectRIPUnit, frameSutraLakeUnit,
  frameActivatibleFeatureUnit, System.ImageList;

  { TODO : Consider making this a property sheet like the Object Inspector that
  could stay open at all times.  Boundary conditions and vertices might be
  accessed through an property editor. }

  { TODO : Consider using a non-modal window here. }

type
  // @name is used in storing values for MODFLOW parameters.
  TTimeValues = record
    TimeOK: boolean;
    StartTime: double;
    EndTime: double;
  end;

  TTimeArray = array of TTimeValues;

  TParameterTime = class(TObject)
  public
    StartTime: double;
    EndTime: double;
  end;

  TGetBoundaryCollectionEvent =
    function (Boundary: TModflowBoundary): TCustomMF_BoundColl of Object;

  TParameterTimeList = class(TObject)
  private
    FList: TList;
    FSorted: boolean;
    function GetCount: integer;
    function GetItems(Index: integer): TParameterTime;
    procedure SetItems(Index: integer; const Value: TParameterTime);
    procedure SetSorted(const Value: boolean);
  public
    procedure Add(Item: TParameterTime);
    property Count: integer read GetCount;
    constructor Create;
    procedure Delete(Index: integer);
    Destructor Destroy; override;
    property Items[Index: integer]: TParameterTime read GetItems write SetItems; default;
    procedure Sort;
    property Sorted: boolean read FSorted write SetSorted;
    function IndexOfTime(const StartTime, EndTime: double): integer;
  end;

  // @name represents the columns for the grid used for the well intervals
  // in the well boundary condition
  // (TfrmScreenObjectProperties.@link(
  // TfrmScreenObjectProperties.dgWellElevations)).
  TWellIntervalColumns = (wicNone, wicFirst, wicSecond);

  {@abstract(@name is used to edit one or more
   @link(ScreenObjectUnit.TScreenObject)s.)  When a
   @link(ScreenObjectUnit.TScreenObject)
   is first created, @link(GetData) is called to read
   the @link(ScreenObjectUnit.TScreenObject) properties
   and TfrmScreenObjectProperties.@link(
   TfrmScreenObjectProperties.SetData) is called to set the
   @link(ScreenObjectUnit.TScreenObject) properties.  When one or
   more @link(ScreenObjectUnit.TScreenObject)s are being edited,
   @link(GetDataForMultipleScreenObjects) is called
   to read the data and @link(SetMultipleScreenObjectData)
   is called to set the
   @link(ScreenObjectUnit.TScreenObject) properties.}
  TfrmScreenObjectProperties = class(TfrmCustomGoPhast)
    // @name is the parent of controls related to MODFLOW packages.
    tabModflowBoundaryConditions: TTabSheet;
    jvtlModflowBoundaryNavigator: TJvPageListTreeView;
    jvplModflowBoundaries: TJvPageList;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    jvspCHD: TJvStandardPage;
    frameChdParam: TframeScreenObjectParam;
    // @name stores the checkbox images for @link(jvtlModflowBoundaryNavigator).
    ilCheckImages: TImageList;
    jvspGHB: TJvStandardPage;
    frameGhbParam: TframeScreenObjectCondParam;
    jvspWell: TJvStandardPage;
    frameWellParam: TframeScreenObjectWel;
    jvspRIV: TJvStandardPage;
    frameRivParam: TframeScreenObjectCondParam;
    jvspDRN: TJvStandardPage;
    frameDrnParam: TframeScreenObjectCondParam;
    jvspDRT: TJvStandardPage;
    frameDrtParam: TframeScreenObjectCondParam;
    pnlDrtLocation: TPanel;
    comboDrtLocationChoice: TComboBox;
    lblReturnLocationMethod: TLabel;
    pcDrtReturnLChoice: TJvPageControl;
    tabDrtNone: TTabSheet;
    tabDrtObject: TTabSheet;
    tabDrtLocation: TTabSheet;
    tabDrtCell: TTabSheet;
    comboDrtReturnObject: TComboBox;
    rdeDrtX: TRbwDataEntry;
    rdeDrtY: TRbwDataEntry;
    rdeDrtZ: TRbwDataEntry;
    lblDrtX: TLabel;
    lblDrtY: TLabel;
    lblDrtZ: TLabel;
    lblDrtCol: TLabel;
    lblDrtRow: TLabel;
    lblDrtLay: TLabel;
    rdeDrtLay: TRbwDataEntry;
    rdeDrtRow: TRbwDataEntry;
    rdeDrtCol: TRbwDataEntry;
    jvspRCH: TJvStandardPage;
    frameRchParam: TframeScreenObjectParam;
    jvspBlank: TJvStandardPage;
    jvspEVT: TJvStandardPage;
    frameEvtParam: TframeScreenObjectParam;
    jvspETS: TJvStandardPage;
    frameEtsParam: TframeScreenObjectParam;
    jvspRES: TJvStandardPage;
    frameRes: TframeScreenObjectNoParam;
    jvspLAK: TJvStandardPage;
    frameLak: TframeScreenObjectLAK;
    jvspSFR: TJvStandardPage;
    frameScreenObjectSFR: TframeScreenObjectSFR;
    jvspUZF: TJvStandardPage;
    frameScreenObjectUZF: TframeScreenObjectNoParam;
    pnlUzfGage: TPanel;
    cbUzfGage1: TCheckBox;
    cbUzfGage2: TCheckBox;
    cbUzfGage3: TCheckBox;
    pnlDataSets: TPanel;
    JvNetscapeSplitter2: TJvNetscapeSplitter;
    Panel1: TPanel;
    lblDataSetFormula: TLabel;
    // @name is used to edit the formula of a data set when the user
    // clicks the button in above @link(reDataSetFormula).
    btnDataSetFormula: TButton;
    Panel2: TPanel;
    tvDataSets: TTreeView;
    jvspHOB: TJvStandardPage;
    frameHeadObservations: TframeHeadObservations;
    jvspHFB: TJvStandardPage;
    frameHfbBoundary: TframeHfbScreenObject;
    jvplObjectInfo: TJvPageList;
    jvspSingleObject: TJvStandardPage;
    jvspMultipleObjects: TJvStandardPage;
    lblNames: TLabel;
    memoNames: TMemo;
    tabImportedData: TTabSheet;
    rdgImportedData: TRbwDataGrid4;
    gbObjectInfo: TGroupBox;
    lblObjectLength: TLabel;
    edObjectLength: TEdit;
    lblObjectArea: TLabel;
    edObjectArea: TEdit;
    lblObjectOrder: TLabel;
    edObjectOrder: TEdit;
    jvspModpath: TJvStandardPage;
    frameIface: TframeIface;
    frameModpathParticles: TframeModpathParticles;
    jvspCHOB: TJvStandardPage;
    frameCHOB: TframeFluxObs;
    jvspDROB: TJvStandardPage;
    frameDROB: TframeFluxObs;
    jvspGBOB: TJvStandardPage;
    frameGBOB: TframeFluxObs;
    jvspRVOB: TJvStandardPage;
    frameRVOB: TframeFluxObs;
    Panel3: TPanel;
    reDataSetComment: TRichEdit;
    lblDataComment: TLabel;
    lblAssociatedModelDataSets: TLabel;
    reAssocModDataSets: TRichEdit;
    jvspGAGE: TJvStandardPage;
    gbGageObservationTypes: TGroupBox;
    cbGageStandard: TCheckBox;
    cbGage1: TCheckBox;
    cbGage2: TCheckBox;
    cbGage3: TCheckBox;
    cbGage5: TCheckBox;
    cbGage6: TCheckBox;
    cbGage7: TCheckBox;
    lblGageCaption: TLabel;
    btnCopyVertices: TButton;
    jvspMNW2: TJvStandardPage;
    frameMNW2: TframeScreenObjectMNW2;
    tabComments: TTabSheet;
    memoComments: TMemo;
    lblComments: TLabel;
    jvspHYDMOD: TJvStandardPage;
    frameHydmod: TframeScreenObjectHydmod;
    tabLGR: TTabSheet;
    tabVertexValues: TTabSheet;
    rdgVertexValues: TRbwDataGrid4;
    pnlLgrTop: TPanel;
    pnlLgrBottom: TPanel;
    clbChildModels: TJvxCheckListBox;
    lblLgrChildModel: TLabel;
    Splitter1: TSplitter;
    lblObjectUsedWithModels: TLabel;
    cbLgrAllModels: TCheckBox;
    clbLgrUsedModels: TCheckListBox;
    cbLock: TCheckBox;
    jvspMT3DMS_SSM: TJvStandardPage;
    frameMT3DMS_SSM: TframeScreenObjectSsm;
    jvspMT3DMS_TOB_Conc: TJvStandardPage;
    frameMt3dmsTobConc: TframeConcentrationObservation;
    jvspMT3DMS_TOB_Flux: TJvStandardPage;
    frameMt3dmsFluxObs: TframeMt3dmsFluxObs;
    reDataSetFormula: TRichEdit;
    tabSutraFeatures: TTabSheet;
    jvplSutraFeatures: TJvPageList;
    jvpltvSutraFeatures: TJvPageListTreeView;
    splttrSutraFeatures: TJvNetscapeSplitter;
    jvspSutraObservations: TJvStandardPage;
    frameSutraObservations: TframeSutraObservations;
    jvspSutraSpecifiedPressure: TJvStandardPage;
    jvspSutraSpecTempConc: TJvStandardPage;
    jvspSutraFluidFlux: TJvStandardPage;
    jvspSutraMassEnergyFlux: TJvStandardPage;
    frameSutraSpecifiedPressure: TframeSutraBoundary;
    frameSutraSpecTempConc: TframeSutraBoundary;
    frameSutraFluidFlux: TframeSutraBoundary;
    frameSutraMassEnergyFlux: TframeSutraBoundary;
    jvspSutraBlank: TJvStandardPage;
    cbDuplicatesAllowed: TCheckBox;
    jvspSTR: TJvStandardPage;
    frameScreenObjectSTR: TframeScreenObjectStr;
    jvspSTOB: TJvStandardPage;
    frameSTOB: TframeFluxObs;
    jvspFhbHeads: TJvStandardPage;
    frameFhbHead: TframeScreenObjectFhbHead;
    jvspFhbFlows: TJvStandardPage;
    frameFhbFlow: TframeScreenObjectFhbFlow;
    jvspFarmWell: TJvStandardPage;
    frameFarmWell: TframeScreenObjectCondParam;
    jvspFarmPrecip: TJvStandardPage;
    frameFarmPrecip: TframeScreenObjectFmpPrecip;
    jvspFarmRefEvap: TJvStandardPage;
    frameFarmRefEvap: TframeScreenObjectFmpEvap;
    jvspFarmCropID: TJvStandardPage;
    frameFarmCropID: TframeScreenObjectCropID;
    jvspCfpPipes: TJvStandardPage;
    frameCfpPipes: TframeScreenObjectCfpPipes;
    jvspCfpFixedHeads: TJvStandardPage;
    frameCfpFixedHeads: TframeScreenObjectCfpFixed;
    jvspCfpRechargeFraction: TJvStandardPage;
    frameCfpRechargeFraction: TframeScreenObjectNoParam;
    jvspSWR_Rain: TJvStandardPage;
    frameSWR_Rain: TframeScreenObjectNoParam;
    jvspSWR_Evap: TJvStandardPage;
    frameSWR_Evap: TframeScreenObjectNoParam;
    jvspSwr_LatInfl: TJvStandardPage;
    jvspSWR_Stage: TJvStandardPage;
    frameSWR_LatInfl: TframeScreenObjectSwr;
    frameSWR_Stage: TframeScreenObjectNoParam;
    jvspSWR_DirectRunoff: TJvStandardPage;
    frameSWR_DirectRunoff: TframeScreenObjectNoParam;
    jvspSwrReaches: TJvStandardPage;
    frameSwrReach: TframeScreenObjectSwrReach;
    splComment: TSplitter;
    cbCaptionVisible: TCheckBox;
    lblCaptionX: TLabel;
    lblCaptionY: TLabel;
    memoCaption: TMemo;
    rdeCaptionX: TRbwDataEntry;
    rdeCaptionY: TRbwDataEntry;
    dlgFontCaption: TFontDialog;
    btnCaptionFont: TButton;
    grpCaption: TGroupBox;
    grpComment: TGroupBox;
    jvspMNW1: TJvStandardPage;
    frameMNW1: TframeScreenObjectMnw1;
    jvspFarmID: TJvStandardPage;
    frameFarmID: TframeScreenObjectFarmID;
    btnConvertTimeUnits: TButton;
    btnEditFeatureFormulas: TButton;
    tabFootprintFeatures: TTabSheet;
    frameScreenObjectFootprintWell: TframeScreenObjectFootprintWell;
    pnlText: TPanel;
    grpLabelVertices: TGroupBox;
    lblVertexXOffset: TLabel;
    lblVertexYOffset: TLabel;
    btnVertexFont: TButton;
    rdeVertexXOffset: TRbwDataEntry;
    rdeVertexYOffset: TRbwDataEntry;
    cbVertexLabelVisible: TCheckBox;
    rdeMinimumCellFraction: TRbwDataEntry;
    lblMinimumCellFraction: TLabel;
    jvspSWI_Obs: TJvStandardPage;
    frameSwiObs: TframeSwiObsInterpolated;
    jvspRIP: TJvStandardPage;
    frameRIP: TframeScreenObjectRIP;
    jvspSutraLake: TJvStandardPage;
    frameSutraLake: TframeSutraLake;
    // @name changes which check image is displayed for the selected item
    // in @link(jvtlModflowBoundaryNavigator).
    procedure jvtlModflowBoundaryNavigatorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure frameChdParamdgModflowBoundaryButtonClick(Sender: TObject; ACol,
      ARow: Integer);
    procedure dgVerticiesBeforeDrawCell(Sender: TObject; ACol, ARow: Integer);
    procedure frameChdParamclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure frameChdParamdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameGhbParamdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure comboGhbConductanceInterpChange(Sender: TObject);
    procedure frameWellParamdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameWellParamcomboFormulaInterpChange(Sender: TObject);
    procedure frameRivParamdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameRivParamcomboFormulaInterpChange(Sender: TObject);
    procedure frameDrnParamdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameDrnParamcomboFormulaInterpChange(Sender: TObject);
    procedure comboDrtLocationChoiceChange(Sender: TObject);
    procedure frameDrtParamdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameDrtParamcomboFormulaInterpChange(Sender: TObject);
    procedure rdeDrtLocationControlExit(Sender: TObject);
    procedure frameRchParamdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameRchParamcomboFormulaInterpChange(Sender: TObject);
    procedure frameEvtParamcomboFormulaInterpChange(Sender: TObject);
    procedure frameEvtParamdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameEtsParamdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameEtsParamcomboFormulaInterpChange(Sender: TObject);
    procedure frameResdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameLakdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameLakrdeLakeIDChange(Sender: TObject);
    procedure frameLakrdeInitialStageChange(Sender: TObject);
    procedure frameLakrdeSillChange(Sender: TObject);
    procedure frameLakrdeCenterLakeChange(Sender: TObject);
    procedure frameResdgModflowBoundaryButtonClick(Sender: TObject; ACol,
      ARow: Integer);
    procedure frameEtsParamclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure frameDrnParamclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure frameDrtParamclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure frameEvtParamclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure frameGhbParamclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure frameRchParamclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure frameRivParamclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure frameWellParamclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure FormShow(Sender: TObject);
    procedure frameScreenObjectSFRjceButtonClick(Sender: TObject);
    procedure frameScreenObjectUZFdgModflowBoundarySetEditText(Sender: TObject;
      ACol, ARow: Integer; const Value: string);
    procedure cbUzfGage1Click(Sender: TObject);
    procedure cbUzfGage2Click(Sender: TObject);
    procedure cbUzfGage3Click(Sender: TObject);
    procedure comboDrtReturnObjectChange(Sender: TObject);
    procedure frameScreenObjectSFRpcSFRChange(Sender: TObject);
    procedure jvplModflowBoundariesChange(Sender: TObject);
    procedure frameLakcbGagStandardClick(Sender: TObject);
    procedure frameLakcbGagFluxAndCondClick(Sender: TObject);
    procedure frameLakcbGagDeltaClick(Sender: TObject);
    procedure tvDataSetsChange(Sender: TObject; Node: TTreeNode);
    procedure btnDataSetFormulaClick(Sender: TObject);
    procedure reDataSetFormulaEnter(Sender: TObject);
    procedure tvDataSetsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure reDataSetFormulaChange(Sender: TObject);
    procedure reDataSetFormulaExit(Sender: TObject);
    procedure frameHfbBoundarybtnEditHfbHydraulicConductivityFormulaClick(
      Sender: TObject);
    procedure frameHfbBoundarybtnEditHfbThicknessyFormulaClick(Sender: TObject);
    procedure dgBoundaryFluxDistributeTextProgress(Sender: TObject; Position,
      Max: Integer);
    procedure dgBoundaryLeakyDistributeTextProgress(Sender: TObject; Position,
      Max: Integer);
    procedure dgBoundaryRiverDistributeTextProgress(Sender: TObject; Position,
      Max: Integer);
    procedure dgSpecifiedHeadDistributeTextProgress(Sender: TObject; Position,
      Max: Integer);
    procedure dgWellDistributeTextProgress(Sender: TObject; Position,
      Max: Integer);
    procedure dgWellElevationsDistributeTextProgress(Sender: TObject; Position,
      Max: Integer);
    procedure frameGhbParamcomboFormulaInterpChange(Sender: TObject);
    procedure frameChdParamdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameWellParamdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameDrnParamdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameDrtParamdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameEtsParamdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameEvtParamdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameGhbParamdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameLakdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameRchParamdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameResdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameRivParamdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameScreenObjectUZFdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameIfacerbHorizontalClick(Sender: TObject);
    procedure frameModpathParticlesrgChoiceClick(Sender: TObject);
    procedure frameModpathParticlesgbParticlesCheckBoxClick(Sender: TObject);
    procedure frameModpathParticlescbLeftFaceClick(Sender: TObject);
    procedure frameModpathParticlesseXChange(Sender: TObject);
    procedure frameModpathParticlesrgCylinderOrientationClick(Sender: TObject);
    procedure frameModpathParticlesseSpecificParticleCountChange(
      Sender: TObject);
    procedure frameModpathParticlesrdgSpecificSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameModpathParticlesseTimeCountChange(Sender: TObject);
    procedure frameModpathParticlesseCylRadiusClick(Sender: TObject);
    procedure frameChdParamseNumberOfTimesChange(Sender: TObject);
    procedure frameDrnParamseNumberOfTimesChange(Sender: TObject);
    procedure frameDrtParamseNumberOfTimesChange(Sender: TObject);
    procedure frameEtsParamseNumberOfTimesChange(Sender: TObject);
    procedure frameEvtParamseNumberOfTimesChange(Sender: TObject);
    procedure frameGhbParamseNumberOfTimesChange(Sender: TObject);
    procedure frameLakseNumberOfTimesChange(Sender: TObject);
    procedure frameRchParamseNumberOfTimesChange(Sender: TObject);
    procedure frameResseNumberOfTimesChange(Sender: TObject);
    procedure frameRivParamseNumberOfTimesChange(Sender: TObject);
    procedure frameScreenObjectUZFseNumberOfTimesChange(Sender: TObject);
    procedure frameWellParamseNumberOfTimesChange(Sender: TObject);
    procedure frameCHOBrdgObservationGroupsStateChange(Sender: TObject; ACol,
      ARow: Integer; const Value: TCheckBoxState);
    procedure frameCHOBrdgObservationGroupsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameDROBrdgObservationGroupsStateChange(Sender: TObject; ACol,
      ARow: Integer; const Value: TCheckBoxState);
    procedure frameDROBrdgObservationGroupsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameGBOBrdgObservationGroupsStateChange(Sender: TObject; ACol,
      ARow: Integer; const Value: TCheckBoxState);
    procedure frameGBOBrdgObservationGroupsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameRVOBrdgObservationGroupsStateChange(Sender: TObject; ACol,
      ARow: Integer; const Value: TCheckBoxState);
    procedure frameRVOBrdgObservationGroupsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure rdgImportedDataSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure frameScreenObjectSFRrdgNetworkButtonClick(Sender: TObject; ACol,
      ARow: Integer);
    procedure frameFluxObsbtnAddOrRemoveFluxObservationsClick(Sender: TObject);
    procedure jvtlModflowBoundaryNavigatorChanging(Sender: TObject;
      Node: TTreeNode; var AllowChange: Boolean);
    procedure jvtlModflowBoundaryNavigatorCustomDrawItem(
      Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure cbGageStandardClick(Sender: TObject);
    procedure frameHeadObservationsrdgHeadsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopyVerticesClick(Sender: TObject);
    procedure dgVerticiesEndUpdate(Sender: TObject);
    procedure frameLakcbGage4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frameMNW2pcMnw2Change(Sender: TObject);
    procedure dgVerticiesStateChange(Sender: TObject; ACol, ARow: Integer;
      const Value: TCheckBoxState);
    procedure dgVerticiesEnter(Sender: TObject);
    procedure frameHydmodclbBasicClickCheck(Sender: TObject);
    procedure frameHydmodclbSubClickCheck(Sender: TObject);
    procedure frameHydmodclbSFRClickCheck(Sender: TObject);
    procedure clbChildModelsClickCheck(Sender: TObject);
    procedure cbLgrAllModelsClick(Sender: TObject);
    procedure clbLgrUsedModelsClickCheck(Sender: TObject);
    procedure cbLockClick(Sender: TObject);
    procedure frameMT3DMSdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameMT3DMSdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameMT3DMSseNumberOfTimesChange(Sender: TObject);
    procedure frameMT3DMScbSpecifiedConcentrationClick(Sender: TObject);
    procedure frameMT3DMScbMassLoadingClick(Sender: TObject);
    procedure frameMt3dmsTobConcrdgObservationsSetEditText(Sender: TObject;
      ACol, ARow: Integer; const Value: string);
    procedure frameMt3dmsTobConcseTimesChange(Sender: TObject);
    procedure frameHeadObservationsseTimesChange(Sender: TObject);
    procedure frameMt3dmsFluxObsrdgObservationGroupsSetEditText(Sender: TObject;
      ACol, ARow: Integer; const Value: string);
    procedure frameMt3dmsFluxObsrdgObservationGroupsStateChange(Sender: TObject;
      ACol, ARow: Integer; const Value: TCheckBoxState);
    procedure frameHydmodcomboLayerGroupChange(Sender: TObject);
    procedure frameHydmodcomboNoDelayBedChange(Sender: TObject);
    procedure jvpltvSutraFeaturesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure frameSutraObservationsbtnDeleteClick(Sender: TObject);
    procedure frameSutraObservationsbtnInsertClick(Sender: TObject);
    procedure frameSutraObservationsedNameExit(Sender: TObject);
    procedure SutraBoundaryButtonClick(
      Sender: TObject; ACol, ARow: Integer);
    procedure cbDuplicatesAllowedClick(Sender: TObject);
    procedure frameSTOBrdgObservationGroupsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameSTOBrdgObservationGroupsStateChange(Sender: TObject; ACol,
      ARow: Integer; const Value: TCheckBoxState);
    procedure frameScreenObjectSTRdgModflowBoundaryButtonClick(Sender: TObject;
      ACol, ARow: Integer);
    procedure frameLakrdgLakeTableEndUpdate(Sender: TObject);
    procedure frameLakfeLakeBathymetryChange(Sender: TObject);
    procedure frameLakrgBathChoiceClick(Sender: TObject);
    procedure jvplSutraFeaturesChange(Sender: TObject);
    procedure frameFarmWellclbParametersStateChange(Sender: TObject;
      Index: Integer);
    procedure frameFarmWelldgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameFarmWelldgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameFarmWellseNumberOfTimesChange(Sender: TObject);
    procedure frameFarmWellcomboFormulaInterpChange(Sender: TObject);
    procedure jvpltvSutraFeaturesCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
//    procedure frameScreenObjectFarmpcMainChange(Sender: TObject);
    procedure frameCfpRechargeFractiondgModflowBoundaryEndUpdate(
      Sender: TObject);
    procedure frameCfpRechargeFractiondgModflowBoundarySetEditText(
      Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure frameCfpRechargeFractionseNumberOfTimesChange(Sender: TObject);
    procedure frameSWR_RaindgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameSWR_RaindgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameSWR_RainseNumberOfTimesChange(Sender: TObject);
    procedure frameSWR_EvapdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameSWR_EvapseNumberOfTimesChange(Sender: TObject);
    procedure frameSWR_EvapdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameSWR_LatInfldgModflowBoundarySetEditText(Sender: TObject;
      ACol, ARow: Integer; const Value: string);
    procedure frameSWR_LatInflseNumberOfTimesChange(Sender: TObject);
    procedure frameSWR_LatInflcomboFormulaInterpChange(Sender: TObject);
    procedure frameSWR_LatInfldgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameSWR_StagedgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure frameSWR_StagedgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameSWR_StageseNumberOfTimesChange(Sender: TObject);
    procedure frameSWR_DirectRunoffdgModflowBoundarySetEditText(Sender: TObject;
      ACol, ARow: Integer; const Value: string);
    procedure frameSWR_DirectRunoffseNumberOfTimesChange(Sender: TObject);
    procedure frameSWR_DirectRunoffdgModflowBoundaryEndUpdate(Sender: TObject);
    procedure frameSwrdgModflowBoundarySetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure cbCaptionVisibleClick(Sender: TObject);
    procedure memoCaptionChange(Sender: TObject);
    procedure btnCaptionFontClick(Sender: TObject);
    procedure btnConvertTimeUnitsClick(Sender: TObject);
    procedure btnEditFeatureFormulasClick(Sender: TObject);
    procedure cbVertexLabelVisibleClick(Sender: TObject);
    procedure btnVertexFontClick(Sender: TObject);
    procedure rdeMinimumCellFractionChange(Sender: TObject);
    procedure frameSwiObsGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure frameWellParamfedTabfileChange(Sender: TObject);
  published
    // Clicking @name closes the @classname without changing anything.
    // See @link(btnCancelClick),
    btnCancel: TBitBtn;

    // @name is used to change the color used to draw the interior of
    // @link(ScreenObjectUnit.TScreenObject)s.
    // See @link(btnColorClick)
    btnFillColor: TButton;

    // Clicking name displays help on the active page in @link(pageMain).
    btnHelp: TBitBtn;

    // @name is used to edit the formula for the higher elevation
    // in @link(edHighZ).
    // See @link(btnFormulaClick).
    btnHighZ: TButton;

    // @name is used to edit the formula for the leaky hydraulic conductivity
    // in @link(edLeakyHydraulicConductivity).
    // See @link(btnFormulaClick).
    btnLeakyHydraulicConductivity: TButton;

    // @name is used to edit the formula for the
    // thickness of the leaky boundary
    // in @link(edLeakyThickness).
    // See @link(btnFormulaClick).
    btnLeakyThickness: TButton;

    // @name is used to change the color used to draw the lines of
    // @link(ScreenObjectUnit.TScreenObject)s.
    // See @link(btnColorClick)
    btnLineColor: TButton;

    // @name is used to edit the formula for the lower elevation
    // in @link(edLowZ).
    // See @link(btnFormulaClick).
    btnLowZ: TButton;

    // See @link(btnOKClick).
    btnOK: TBitBtn;

    // @name is used to edit the formula for the
    // thickness of the bed in the river boundary
    // in @link(edRiverBedThickness).
    // See @link(btnFormulaClick).
    btnRiverBedThickness: TButton;

    // @name is used to edit the formula for the
    // depth of the river in the river boundary
    // in @link(edRiverDepth).
    // See @link(btnFormulaClick).
    btnRiverDepth: TButton;

    // @name is used to edit the formula for the
    // hydraulic conductivity of the river bed in the river boundary
    // in @link(edRiverHydraulicConductivity).
    // See @link(btnFormulaClick).
    btnRiverHydraulicConductivity: TButton;

    // @name is used to edit the formula for the
    // width of the river in the river boundary
    // in @link(edRiverWidth).
    // See @link(btnFormulaClick).
    btnRiverWidth: TButton;

    // @name is used to edit the formula for the single elevation
    // in @link(edZ).
    // See @link(btnFormulaClick).
    btnZ: TButton;

    { TODO : Change name to remove "cell". }
    // @name specifies whether the values of cells or elements
    // enclosed by the @link(TScreenObject) will be set by the
    // @link(TScreenObject)
    // @seealso(cbEnclosedCellsClick).
    // @seealso(TScreenObject.SetValuesOfEnclosedCells)
    cbEnclosedCells: TCheckBox;

    // @name specifies whether the interior of
    // @link(ScreenObjectUnit.TScreenObject)s
    // will be colored.
    // See @link(cbFillColorClick).
    cbFillColor: TCheckBox;

    // @name specifies whether the values of cells or elements
    // will be set by interpolation using this
    // @link(ScreenObjectUnit.TScreenObject).
    // See @link(cbInterpolationClick).
    cbInterpolation: TCheckBox;

    { TODO : Change name to remove "cell". }
    // @name: TCheckBox;
    // @name specifies whether the values of cells or elements
    // intersected by the @link(TScreenObject) will be set by the
    // @link(TScreenObject)
    // See @link(cbIntersectedCellsClick).
    cbIntersectedCells: TCheckBox;

    // @name specifies whether the lines of
    // @link(ScreenObjectUnit.TScreenObject)s
    // will be colored.
    // See @link(cbLineColorClick).
    cbLineColor: TCheckBox;

    { TODO : Change name to remove "cell". }
    // @name specifies whether this
    // @link(ScreenObjectUnit.TScreenObject) will be used
    // to set the size of elements in the @link(TPhastGrid).
    // See @link(cbSetGridCellSizeClick).
    cbSetGridCellSize: TCheckBox;

    // @name specifies whether the well boundary condition specified by
    // this @link(ScreenObjectUnit.TScreenObject)
    // will allocate pumping by pressure and
    // mobility.
    // See @link(cbWellPumpAllocationClick).
    cbWellPumpAllocation: TCheckBox;

    // @name is used in @link(btnColorClick) to pick a color for the
    // lines or interior of @link(ScreenObjectUnit.TScreenObject)s.
    coldlgColors: TColorDialog;

    // @name is used to specify whether the solution in a specified state
    // boundary is a specified solution or an associated solution.
    // See @link(comboSolutionTypeChange).
    comboSolutionType: TComboBox;

    // @name specifies whether the open intervals in a well boundary are
    // specified in terms of absolute elevation or depth below a datum.
    // See @link(comboWellIntervalStyleChange).
    comboWellIntervalStyle: TComboBox;

    // @name stores the PHAST specified flux boundary values.
    dgBoundaryFlux: TRbwDataGrid4;

    // @name stores the PHAST leaky boundary values.
    dgBoundaryLeaky: TRbwDataGrid4;

    // @name stores the PHAST river boundary values.
    dgBoundaryRiver: TRbwDataGrid4;

    // @name stores the PHAST specified head boundary values.
    dgSpecifiedHead: TRbwDataGrid4;

    // @name stores the locations of the points for a single
    // @link(TScreenObject).
    dgVerticies: TRbwDataGrid4;

    // @name stores the PHAST well boundary values.
    dgWell: TRbwDataGrid4;

    // @name stores the PHAST well open interval elevations
    dgWellElevations: TRbwDataGrid4;

    // @name holds the formula for the higher elevation formula.
    // See @link(edHighZExit).
    // See @link(btnHighZ) and @link(btnFormulaClick).
    edHighZ: TRbwEdit;

    // @name holds the formula for the hydraulic conductivity of a
    // leaky boundary.
    // See @link(edLeakyHydraulicConductivityExit)
    // and @link(btnLeakyHydraulicConductivity).
    edLeakyHydraulicConductivity: TEdit;

    // @name holds the formula for the thickness of a
    // leaky boundary.
    // See @link(edLeakyHydraulicConductivityExit)
    // and @link(btnLeakyThickness).
    edLeakyThickness: TEdit;

    // @name holds the formula for the lower of two elevations.
    // See @link(edLowZExit),
    // @link(btnLowZ) and @link(btnFormulaClick).
    edLowZ: TRbwEdit;

    // @name holds the name of the @link(ScreenObjectUnit.TScreenObject).
    // See @link(edNameExit).
    edName: TEdit;

    // @name holds the formula for the thickness of a
    // river boundary.
    // See @link(edRiverExit)
    // and @link(btnRiverBedThickness).
    edRiverBedThickness: TEdit;

    // @name holds the formula for the depth of a
    // river boundary.
    // See @link(edRiverExit)
    // and @link(btnRiverDepth).
    edRiverDepth: TEdit;

    // @name holds the the name of a
    // river boundary.
    // See @link(edRiverDescriptonExit).
    edRiverDescripton: TEdit;

    // @name holds the formula for the hydraulic conductivity of a
    // river boundary.
    // See @link(edRiverExit)
    // and @link(btnRiverHydraulicConductivity).
    edRiverHydraulicConductivity: TEdit;

    // @name holds the formula for the width of a
    // river boundary.
    // See @link(edRiverExit)
    // and @link(btnRiverWidth).
    edRiverWidth: TEdit;

    // @name holds the the name of a
    // well boundary.
    // See @link(edWellExit).
    edWellDescription: TEdit;

    // @name is for editing the @link(TScreenObject.ElevationFormula).
    edZ: TRbwEdit;

    // @name is used to specify PHAST-style interpolation
    // for boundary conditions. See @link(TPhastInterpolationValues).
    framePhastInterpolationBoundaries: TframePhastInterpolation;

    // @name is used to specify PHAST-style interpolation
    // for @link(TDataArray)s. See @link(TPhastInterpolationValues).
    framePhastInterpolationData: TframePhastInterpolation;

    // @name holds and labels @link(framePhastInterpolationBoundaries).
    gbBoundaryPhastInterpolation: TGroupBox;

    // @name holds and labels @link(framePhastInterpolationData).
    gbPhastInterpolation: TGroupBox;

    // @name displays "Number of times".
    lblBoundaryTimes: TLabel;

    { TODO : remove "cell" from name. }
    // @name displays "Grid element size".
    lblGridCellSize: TLabel;

    // @name displays "Higher X-coordinate", "Higher Y-coordinate",
    // or "Higher Z-coordinate".
    // The text is changed in @link(GetData) depending the the
    // TScreenObject.@link(ScreenObjectUnit.TScreenObject.ViewDirection).
    lblHighZ: TLabel;

    // @name displays "Hydraulic Conductivity".
    lblLeakyHydraulicConductivity: TLabel;

    // @name displays "Thickness".
    lblLeakyThickness: TLabel;

    // @name displays "Lower X-coordinate", "Lower Y-coordinate",
    // or "Lower Z-coordinate".
    // The text is changed in @link(GetData) depending the the
    // TScreenObject.@link(ScreenObjectUnit.TScreenObject.ViewDirection).
    lblLowZ: TLabel;

    // @name displays "Name". It labels @link(edName).
    lblName: TLabel;

    // @name displays "Bed Thickness".
    lblRiverBedThickness: TLabel;

    // @name displays "Depth".
    lblRiverDepth: TLabel;

    // @name displays "Name".
    lblRiverDescripton: TLabel;

    // @name displays "Hydraulic Conductivity".
    lblRiverHydraulicConductivity: TLabel;

    // @name displays "Width".
    lblRiverWidth: TLabel;

    // @name displays "Type of Solution".
    lblSolutionType: TLabel;

    // @name displays "Name".
    lblWellDescription: TLabel;

    // @name displays "Diameter".
    lblWellDiameter: TLabel;

    // @name displays "Number of intervals".
    lblWellIntervals: TLabel;

    // @name displays "Specify interval by".
    lblWellIntervalStyle: TLabel;

    // @name displays "Land surface datum".
    lblWellLandSurfaceDatum: TLabel;

    // @name displays "X-coordinate", "Y-coordinate", or "Z-coordinate".
    // The text is changed in @link(GetData) depending the the
    // TScreenObject.@link(ScreenObjectUnit.TScreenObject.ViewDirection).
    lblZ: TLabel;

    // @name holds @link(tabBoundaryNone), @link(tabBoundarySpecifiedHead),
    // @link(tabBoundaryFlux), and @link(tabBoundaryLeaky),
    // @link(tabBoundaryRiver), and @link(tabBoundaryWell).
    // See @link(pcPhastBoundariesChange).
    pcPhastBoundaries: TJvPageList;

    // @name holds @link(tabProperties), @link(tabDataSets),
    // @link(tabBoundaries), and @link(tabNodes).
    // See @link(pageMainChange).
    pageMain: TPageControl;

    // @name holds the buttons at the bottom of @classname.
    pnlBottom: TPanel;

    // @name holds the controls on the left side of @link(tabBoundaries).
    pnlBoundaries: TPanel;

    // @name holds the controls on the top of @link(tabBoundaryLeaky).
    pnlLeaky: TPanel;

    // @name holds the controls on the top of @link(tabBoundaryRiver).
    pnlRiver: TPanel;

    // @name holds the controls on the top of @link(tabBoundarySpecifiedHead).
    pnlSolutionType: TPanel;

    // @name holds the controls on the top of @link(tabBoundaryWell).
    pnlWellBoundary: TPanel;

    { TODO : remove "cell" from name. }
    // @name is used to hold the size of elements in the @link(TPhastGrid) to
    // be generated using the @link(TScreenObject) being edited in @classname.
    rdeGridCellSize: TRbwDataEntry;

    // @name is used to specify the diameter of a well in a well boundary.
    // See @link(edWellExit).
    rdeWellDiameter: TRbwDataEntry;

    // @name is used to specify the land surface data in a well boundary.
    // See @link(edWellExit).
    rdeWellLandSurfaceDatum: TRbwDataEntry;

    // @name is used to specify the type of boundary specified by the
    // @link(TScreenObject) that is being edited.  The items in @name
    // must correspond to the elements in @link(TBoundaryTypes).
    // See @link(rgBoundaryTypeClick).
    rgBoundaryType: TRadioGroup;

    // @name is used to specify the number of elevations associated with
    // the @link(TScreenObject) being edited.
    // The items in @name must correspond with the elements in
    // @link(TElevationCount).
    // See @link(rgElevationCountClick).
    rgElevationCount: TRadioGroup;

    // @name specifies whether the @link(TScreenObject) being edited is
    // evaluated at elements or at nodes.
    // The items in @name must correspond with the elements in
    // @link(TEvaluatedAt).
    rgEvaluatedAt: TRadioGroup;

    // @name is used to compile formulas that will be evaluated at elements
    // for @link(TDataArray)s whose @link(TDataArray.Orientation) is dsoTop.
    // See @link(TDataSetOrientation).
    // The primary purpose of @name is to ensure that formulas are valid.
    rparserFrontFormulaElements: TRbwParser;

    // @name is used to compile formulas that will be evaluated at nodes
    // for @link(TDataArray)s whose @link(TDataArray.Orientation) is dsoTop.
    // See @link(TDataSetOrientation).
    // The primary purpose of @name is to ensure that formulas are valid.
    rparserFrontFormulaNodes: TRbwParser;

    // @name is used to compile formulas that will be evaluated at elements
    // for @link(TDataArray)s whose @link(TDataArray.Orientation) is dsoSide.
    // See @link(TDataSetOrientation).
    // The primary purpose of @name is to ensure that formulas are valid.
    rparserSideFormulaElements: TRbwParser;

    // @name is used to compile formulas that will be evaluated at nodes
    // for @link(TDataArray)s whose @link(TDataArray.Orientation) is dsoSide.
    // See @link(TDataSetOrientation).
    // The primary purpose of @name is to ensure that formulas are valid.
    rparserSideFormulaNodes: TRbwParser;

    // @name is used to compile formulas that will be evaluated at elements
    // for @link(TDataArray)s whose @link(TDataArray.Orientation) is dso3D.
    // See @link(TDataSetOrientation).
    // The primary purpose of @name is to ensure that formulas are valid.
    rparserThreeDFormulaElements: TRbwParser;

    // @name is used to compile formulas that will be evaluated at nodes
    // for @link(TDataArray)s whose @link(TDataArray.Orientation) is dso3D.
    // See @link(TDataSetOrientation).
    // The primary purpose of @name is to ensure that formulas are valid.
    rparserThreeDFormulaNodes: TRbwParser;

    // @name is used to compile formulas that will be evaluated at elements
    // for @link(TDataArray)s whose @link(TDataArray.Orientation) is dsoTop.
    // See @link(TDataSetOrientation).
    // The primary purpose of @name is to ensure that formulas are valid.
    rparserTopFormulaElements: TRbwParser;

    // @name is used to compile formulas that will be evaluated at nodes
    // for @link(TDataArray)s whose @link(TDataArray.Orientation) is dsoTop.
    // See @link(TDataSetOrientation).
    // The primary purpose of @name is to ensure that formulas are valid.
    rparserTopFormulaNodes: TRbwParser;

    // @name is used to specify how many times are associated with the
    // boundary condition of the @link(TScreenObject) that is being edited.
    // See @link(seBoundaryTimesChange).
    seBoundaryTimes: TJvSpinEdit;

    // @name has the number of open intervals in a well boundary.
    seWellIntervals: TJvSpinEdit;

    // @name displays a preview of the color used to draw the interior
    // of the @link(TScreenObject) that is being edited.
    shpFillColor: TShape;

    // @name displays a preview of the color used to draw the lines
    // of the @link(TScreenObject) that is being edited.
    shpLineColor: TShape;

    // @name is used to change the relative sizes of  @link(dgWell)
    // and @link(dgWellElevations) on @link(tabBoundaryWell).
    splitterWell: TSplitter;

    // @name is used to hold controls related to boundary conditions on
    // @link(pageMain).
    tabBoundaries: TTabSheet;

    // @name is used to hold controls related to specified flux boundaries on
    // @link(pcPhastBoundaries).
    tabBoundaryFlux: TJvStandardPage;

    // @name is used to hold controls related to leaky boundaries on
    // @link(pcPhastBoundaries).
    tabBoundaryLeaky: TJvStandardPage;

    // @name is used as a place-holder for @link(TScreenObject)s that
    // do not specify any boundary condition on
    // @link(pcPhastBoundaries).
    tabBoundaryNone: TJvStandardPage;

    // @name is used to hold controls related to river boundaries on
    // @link(pcPhastBoundaries).
    tabBoundaryRiver: TJvStandardPage;

    // @name is used to hold controls related to specified head boundaries on
    // @link(pcPhastBoundaries).
    tabBoundarySpecifiedHead: TJvStandardPage;

    // @name is used to hold controls related to well boundaries on
    // @link(pcPhastBoundaries).
    tabBoundaryWell: TJvStandardPage;

    // @name is used to hold controls related to @link(TDataArray)s on
    // @link(pageMain).
    tabDataSets: TTabSheet;

    // @name is used to hold controls related to the vertices of the
    // @link(TScreenObject) being edited on
    // @link(pageMain).
    tabNodes: TTabSheet;

    // @name is used to hold controls related to miscellaneous properties on
    // @link(pageMain).
    tabProperties: TTabSheet;

    // If the user hasn't changed anything, don't force the user
    // to save the model.
    procedure btnCancelClick(Sender: TObject);

    // allow the user to edit the line or fill color of a
    // @link(ScreenObjectUnit.TScreenObject).
    // See @link(btnLineColor) and @link(btnFillColor).
    procedure btnColorClick(Sender: TObject);

    // @name is used to edit a formula that is not part of a @link(TDataArray)
    // or boundary condition @link(TDataArray).
    // Examples include the formulas for the elevations associated with
    // a @link(TScreenObject).
    procedure btnFormulaClick(Sender: TObject);

    // @name warns user about potential problems and gives the user
    // a chance to correct them.
    // It then applies the changes to the @link(ScreenObjectUnit.TScreenObject)
    // or @link(ScreenObjectUnit.TScreenObject)s
    // using @link(SetMultipleScreenObjectData),
    // or @link(SetData).
    procedure btnOKClick(Sender: TObject);

    { TODO : remove "cell" from name. }
    // @name marks all used @link(TDataArray)s affected by the
    // @link(TScreenObject)s being edited as in need of updating when this
    // check box is checked.
    // @name sets (TScreenObject.SetValuesOfEnclosedCells
    //  TScreenObject.SetValuesOfEnclosedCells)
    procedure cbEnclosedCellsClick(Sender: TObject);

    // @name responds to the user checking the @link(cbFillColor)
    // check box by enabling the associated button (@link(btnFillColor)).
    // @name sets @link(TScreenObject.FillScreenObject
    // TScreenObject.FillScreenObject)
    procedure cbFillColorClick(Sender: TObject);

    // @name responds to the user checking the
    // @link(cbInterpolation) check box by
    // marking all @link(TDataArray)s affected by the @link(TScreenObject)
    // being edited as in need of updating.
    // @name sets @link(TScreenObject.SetValuesByInterpolation
    // TScreenObject.SetValuesByInterpolation).
    procedure cbInterpolationClick(Sender: TObject);

    // @name responds to the user checking the @link(cbIntersectedCells)
    // check box by
    // marking all @link(TDataArray)s affected by the @link(TScreenObject)
    // being edited as in need of updating.
    // @name sets @link(TScreenObject.SetValuesOfIntersectedCells
    // TScreenObject.SetValuesOfIntersectedCells).
    procedure cbIntersectedCellsClick(Sender: TObject);

    // @name responds to the user checking the @link(cbLineColor)
    // check box by enabling
    // the associated button (@link(btnLineColor)).
    procedure cbLineColorClick(Sender: TObject);

    // @name enables controls related to setting the grid cell size and
    // sets @link(TScreenObject.CellSizeUsed).
    procedure cbSetGridCellSizeClick(Sender: TObject);

    // @name calls @link(StorePhastWellBoundary)
    procedure cbWellPumpAllocationClick(Sender: TObject);

    // @name responds to a change in @link(comboSolutionType)
    // by changing a title in @link(dgSpecifiedHead).
    // @name calls @link(StorePhastSpecifiedHeads)
    procedure comboSolutionTypeChange(Sender: TObject);

    // @name changes the captions on the table that shows the well intervals
    // depending on the selection in @link(comboWellIntervalStyle).
    // @name calls @link(StorePhastWellBoundary).
    procedure comboWellIntervalStyleChange(Sender: TObject);

    // Allow the user to edit a formula with the formula editor in
    // one of the boundary condition grids (@link(dgSpecifiedHead),
    // @link(dgBoundaryFlux), @link(dgBoundaryLeaky), @link(dgBoundaryRiver),
    // and @link(dgWell)).
    procedure dgBoundaryButtonClick(Sender: TObject; ACol, ARow:
      Integer);

    // with Grids that represent boundary conditions, @name shows the cell at
    // (1,1) as gray because the user shouldn't be able to edit it.
    // (@link(dgSpecifiedHead),
    // @link(dgBoundaryFlux), @link(dgBoundaryLeaky), @link(dgBoundaryRiver),
    // and @link(dgWell))
    procedure dgBoundaryDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);

    // @name Doesn't allow a row to be moved to the top of the grid because
    // the cell at (1,1) shouldn't be edited.
    // (@link(dgSpecifiedHead),
    // @link(dgBoundaryFlux), @link(dgBoundaryLeaky), @link(dgBoundaryRiver),
    // and @link(dgWell))
    procedure dgBoundaryRowMoving(Sender: TObject; const Origin,
      Destination: Integer; var CanMove: Boolean);

    // Show the @link(TPhastInterpolationValues) when the user clicks on a cell
    // in a boundary grid.
    // (@link(dgSpecifiedHead),
    // @link(dgBoundaryFlux), @link(dgBoundaryLeaky), @link(dgBoundaryRiver),
    // and @link(dgWell))
    procedure dgBoundarySelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);

    // When the user edits text in one of the grids for
    // PHAST boundary conditions,
    // record that the data was changed (@link(StorePhastBoundary)).
    // @Seealso(dgSpecifiedHead)
    // @Seealso(dgBoundaryFlux)
    // @Seealso(dgBoundaryLeaky)
    // @Seealso(dgBoundaryRiver)
    // @Seealso(dgWell)
    procedure dgBoundarySetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);

    // update the displayed @link(TPhastInterpolationValues)
    // when the use clicks one of the
    // check boxes in a boundary table.
    // (@link(dgSpecifiedHead),
    // @link(dgBoundaryFlux), @link(dgBoundaryLeaky), @link(dgBoundaryRiver),
    // and @link(dgWell))
    procedure dgBoundaryStateChanged(Sender: TObject; ACol, ARow: Integer;
      const Value: TCheckBoxState);

    // If the user has changed the value displayed in @link(dgWellElevations),
    // @link(StorePhastWellBoundary) for later use in
    // @link(SetMultipleScreenObjectData).
    procedure dgWellElevationsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);

    // @name validates the upper formula and stores
    // @link(TScreenObject.HigherElevationFormula).
    procedure edHighZExit(Sender: TObject);

    // @name validates the leaky hydraulic conductivity formula
    // and calls @link(StorePhastLeakyBoundary).
    procedure edLeakyHydraulicConductivityExit(Sender: TObject);

    // @name validates the lower Z formula and stores
    // @link(TScreenObject.LowerElevationFormula).
    procedure edLowZExit(Sender: TObject);

    // @name ensures that the value given for the name of a
    // @link(ScreenObjectUnit.TScreenObject)
    // is valid.
    procedure edNameExit(Sender: TObject);

    // @name calls @link(StorePhastRiverBoundary).
    procedure edRiverDescriptonExit(Sender: TObject);

    // @name validates a river formula and calls @link(StorePhastRiverBoundary).
    procedure edRiverExit(Sender: TObject);

    // @name calls @link(StorePhastWellBoundary).
    procedure edWellExit(Sender: TObject);
    // @name validates the formula for the Z.

    procedure edZExit(Sender: TObject);
    // @name create variables and initialize the form.

    procedure FormCreate(Sender: TObject); override;
    // @name destroy variables.

    procedure FormDestroy(Sender: TObject); override;

    // See @link(FInitialWidth).
    procedure FormResize(Sender: TObject);

    // Respond to the user activating or deactivating PHAST-style Interpolation
    // for a boundary condition. See @link(TPhastInterpolationValues).
    procedure framePhastInterpolationBoundariescbPhastInterpolationClick(Sender:
      TObject);

    // @name responds to the user finishing editing the
    // PHAST-style Interpolation mixture formula
    // for a boundary condition by storing the value.
    // See @link(TPhastInterpolationValues).
    procedure framePhastInterpolationBoundariesedMixFormulaExit(
      Sender: TObject);

    // @name calls @link(StorePhastBoundary).
    procedure framePhastInterpolationBoundariesExit(Sender: TObject);

    // @name responds to the user finishing editing the
    // PHAST-style Interpolation Distance 1
    // for a boundary condition by storing the value.
    // See @link(TPhastInterpolationValues).
    procedure framePhastInterpolationBoundariesrdeDistance1Exit(Sender:
      TObject);

    // @name responds to the user finishing editing the
    // PHAST-style Interpolation Distance 2
    // for a boundary condition by storing the value.
    // See @link(TPhastInterpolationValues).
    procedure framePhastInterpolationBoundariesrdeDistance2Exit(Sender:
      TObject);

    // @name responds to the user finishing editing the
    // PHAST-style Interpolation Value 1
    // for a boundary condition by storing the value.
    // See @link(TPhastInterpolationValues).
    procedure framePhastInterpolationBoundariesrdeValue1Exit(Sender: TObject);

    // @name responds to the user finishing editing the
    // PHAST-style Interpolation Value 2
    // for a boundary condition by storing the value.
    // See @link(TPhastInterpolationValues).
    procedure framePhastInterpolationBoundariesrdeValue2Exit(Sender: TObject);

    // @name responds to the user changing the interpolation direction
    // for a boundary condition by storing the value.
    // See @link(TPhastInterpolationValues).
    procedure framePhastInterpolationBoundariesrgInterpolationDirectionClick(
      Sender: TObject);

    // @name responds to the user clicking the button for editing the
    // mixture formula by displaying the @link(TfrmFormula).
    procedure framePhastInterpolationDatabtnEditMixtureFormulaClick(
      Sender: TObject);

    // @name responds to the user activating or
    // deactivating PHAST-Interpolation for a
    // @link(TDataArray).
    procedure framePhastInterpolationDatacbPhastInterpolationClick(Sender:
      TObject);

    // @name stores a copy of the mixture formula in case it
    // needs to be restored later.
    procedure framePhastInterpolationDataedMixFormulaEnter(
      Sender: TObject);

    // @name checks that the mixture formula is valid.
    procedure framePhastInterpolationDataedMixFormulaExit(Sender: TObject);

    // @name responds to the user having finished editing the
    // PHAST-Interpolation distance 1 by storing the new value.
    // See @link(TPhastInterpolationValues).
    // @name calls @link(AssignPhastInterpolation)
    procedure framePhastInterpolationDatardeDistance1Exit(Sender: TObject);

    // @name responds to the user having finished editing the
    // PHAST-Interpolation distance 2 by storing the new value.
    // See @link(TPhastInterpolationValues).
    // @name calls @link(AssignPhastInterpolation)
    procedure framePhastInterpolationDatardeDistance2Exit(Sender: TObject);

    // @name responds to the user having finished editing the
    // PHAST-Interpolation Value 1 by storing the new value.
    // See @link(TPhastInterpolationValues).
    // @name calls @link(AssignPhastInterpolation)
    procedure framePhastInterpolationDatardeValue1Exit(Sender: TObject);

    // @name responds to the user having finished editing the
    // PHAST-Interpolation Value 2 by storing the new value.
    // See @link(TPhastInterpolationValues).
    // @name calls @link(AssignPhastInterpolation)
    procedure framePhastInterpolationDatardeValue2Exit(Sender: TObject);

    // @name responds to the user having edited the
    // PHAST-Interpolation interpolation direction by storing the new value.
    // See @link(TPhastInterpolationValues).
    // @name calls @link(AssignPhastInterpolation)
    procedure framePhastInterpolationDatargInterpolationDirectionClick(Sender:
      TObject);

    // @name updates @link(seBoundaryTimes).Value based
    // on the active page in @link(pcPhastBoundaries).
    procedure pcPhastBoundariesChange(Sender: TObject);

    // @name sets @link(btnHelp).HelpKeyword to
    // @link(pageMain).ActivePage.HelpKeyword
    procedure pageMainChange(Sender: TObject);

    // @name stores @link(TScreenObject.CellSize).
    procedure rdeGridCellSizeExit(Sender: TObject);

    // @name responds to the user selecting a different type of boundary
    // condition to use with the @link(ScreenObjectUnit.TScreenObject)
    // by setting @link(pcPhastBoundaries).ActivePageIndex
    // to the appropriate value.
    procedure rgBoundaryTypeClick(Sender: TObject);

    // @name responds to the user changing the number of elevations for the
    // @link(ScreenObjectUnit.TScreenObject).
    // @name sets @link(cbFillColor).Enabled as well as the enabled
    // property of other controls.
    // Some @link(TDataArray)s may no longer be affected by the
    // @link(TScreenObject) being edited. due to a change in the number of
    // elevations used.
    procedure rgElevationCountClick(Sender: TObject);

    // respond to the user changing where the
    // @link(ScreenObjectUnit.TScreenObject) is to be evaluated.
    // @name changes the captions of @link(cbEnclosedCells),
    // @link(cbIntersectedCells), and @link(cbInterpolation).
    procedure rgEvaluatedAtClick(Sender: TObject);

    // @name responds to the user changing the number of boundary times
    // by changing the number of rows in one of the grids related to
    // boundary conditions.
    // (@link(dgSpecifiedHead),
    // @link(dgBoundaryFlux), @link(dgBoundaryLeaky), @link(dgBoundaryRiver),
    // and @link(dgWell))
    procedure seBoundaryTimesChange(Sender: TObject);

    // @name responds to the user changing
    // the number of open intervals in a well
    // by changing the number of rows in @link(dgWellElevations).
    procedure seWellIntervalsChange(Sender: TObject);

    // See @link(FInitialWidth).
    procedure splitterBoundaryMoved(Sender: TObject);
  private
    FWellTabFileChanged: Boolean;
    FCHD_Node: TJvPageIndexNode;
    FGHB_Node: TJvPageIndexNode;
    FWEL_Node: TJvPageIndexNode;
    FRIV_Node: TJvPageIndexNode;
    FDRN_Node: TJvPageIndexNode;
    FDRT_Node: TJvPageIndexNode;
    FRCH_Node: TJvPageIndexNode;
    FEVT_Node: TJvPageIndexNode;
    FETS_Node: TJvPageIndexNode;
    FRES_Node: TJvPageIndexNode;
    FLAK_Node: TJvPageIndexNode;
    FMNW2_Node: TJvPageIndexNode;
    FMNW1_Node: TJvPageIndexNode;
    FSFR_Node: TJvPageIndexNode;
    FSTR_Node: TJvPageIndexNode;
    FUZF_Node: TJvPageIndexNode;
    FChob_Node: TJvPageIndexNode;
    FDrob_Node: TJvPageIndexNode;
    FGbob_Node: TJvPageIndexNode;
    FRvob_Node: TJvPageIndexNode;
    FStob_Node: TJvPageIndexNode;
    FGage_Node: TJvPageIndexNode;
    FFhbHead_Node: TJvPageIndexNode;
    FFhbFlow_Node: TJvPageIndexNode;
    FMt3dmsSsm_Node: TJvPageIndexNode;
    FMt3dmsTobConc_Node: TJvPageIndexNode;
    FMt3dmsTobFlux_Node: TJvPageIndexNode;
//    FFmpFarm_Node: TJvPageIndexNode;
    FFarmWell_Node: TJvPageIndexNode;
    FFarmPrecip_Node: TJvPageIndexNode;
    FFarmRevEvap_Node: TJvPageIndexNode;
    FFarmCropID_Node: TJvPageIndexNode;
    FFarmID_Node: TJvPageIndexNode;
    FCfpPipe_Node: TJvPageIndexNode;
    FCfpFixedHead_Node: TJvPageIndexNode;
    FCRCH_Node: TJvPageIndexNode;
    FSWR_Rain_Node: TJvPageIndexNode;
    FSWR_Evap_Node: TJvPageIndexNode;
    FSWR_LatInflow_Node: TJvPageIndexNode;
    FSWR_Stage_Node: TJvPageIndexNode;
    FSWR_DirectRunoff_Node: TJvPageIndexNode;
    FSWR_Reach_Node: TJvPageIndexNode;
    // @name is used to store the column that the user last selected
    // in one of the grids for boundary-condition, time-varying stress.
    // For boundary conditions that allow PHAST-style interpolation,
    // @name is adjusted to be the column with the checkbox for
    // turning on or off PHAST-style interpolation.
    // See @link(TPhastInterpolationValues).
    FBoundaryCol: integer;

    // @name is the TRbwDataGrid4 that is being used to specify
    // boundary conditions for the current @link(TScreenObject).
    // @name is one of the following:
    // @nil, @link(dgSpecifiedHead), @link(dgBoundaryFlux),
    // @link(dgBoundaryLeaky), @link(dgBoundaryRiver), or
    // @link(dgWell).
    FBoundaryGrid: TRbwDataGrid4;

    // @name holds @link(TInterpValuesCollection)s.
    // The @link(TInterpValuesCollection)s are also stored in the Objects
    // property of the related TRbwDataGrid4.  @name is used to ensure that
    // they are destroyed when the @classname is destroyed.
    FBoundaryPhastInterpolationList: TObjectList;

    // @name is the selected row in the grid used to specify boundary
    // conditions for the current @link(TScreenObject).
    FBoundaryRow: integer;

    // @name is the @link(TExpression) that represents the formula in @link(edHighZ).
    // If @name is @nil, btnOK.Enabled may be set to @false.
    FHighZFormula: TExpression;

    // @name is set to Width - pnlBoundaries.Width in @link(FormCreate).
    // It is used in @link(splitterBoundaryMoved) and @link(FormResize)
    // to make sure that
    // the panels on @link(pcPhastBoundaries) don't get too small.
    FInitialWidth: integer;

    // @name is used in event handlers to decide
    // whether or not anything should be done.
    FIsLoaded: boolean;

    // @name is the @link(TExpression) that represents the formula in @link(edLowZ).
    // If @name is @nil, btnOK.Enabled may be set to @false.
    FLowZFormula: TExpression;

    // See @link(MultipleScreenObjects).
    FMultipleScreenObjects: boolean;

    // @name is used to store a copy of the @link(TScreenObject)s being edited.
    // Those @link(TScreenObject)s are then edited in @classname.  They
    // are used to set the properties of the @link(TScreenObject)s
    // in @link(TUndoSetScreenObjectProperties.DoCommand
    // TUndoSetScreenObjectProperties.DoCommand).
    FNewProperties: TScreenObjectEditCollection;

    // @name is set to @link(framePhastInterpolationData).edMixFormula.Text
    // @link(framePhastInterpolationDataedMixFormulaEnter)
    // It is used in @link(framePhastInterpolationDataedMixFormulaExit)
    // to restore the formula if the user enters an invalid formula.
    FOldMixFormula: string;

    // @name is used to store a copy of the @link(TScreenObject)s being edited.
    // They are used to restore the properties of the @link(TScreenObject)s
    // in @link(TUndoSetScreenObjectProperties.Undo
    // TUndoSetScreenObjectProperties.Undo).
    FOldProperties: TScreenObjectEditCollection;

    // @name is set to frmGoPhast.Model.@link(TBaseModel.UpToDate)
    // in @link(FormCreate).  If @link(btnCancel) is clicked,
    // frmGoPhast.Model.@link(TBaseModel.UpToDate) is restored to @name.
    FPriorModelUpToDate: boolean;

    // If only a single @link(TScreenObject) is being edited, @name is that
    //  @link(TScreenObject). If more than one is being edited, @name is @nil.
    // @seealso(FScreenObjectList);
    FScreenObject: TScreenObject;

    // If multiple @link(TScreenObject)s are being editted, @name holds the
    // @link(TScreenObject)s that are being edited.
    // @seealso(FScreenObject);
    FScreenObjectList: TList;

    // @name is set to @true to indicate that the colors of the cells will
    // need to be recalculated.
    FSetCellsColor: boolean;

    // @name is used to set or undo the setting of the properties
    // of a @link(TScreenObject).
    FUndoSetScreenObjectProperties: TUndoSetScreenObjectProperties;

    // @name is the @link(TViewDirection) of the @link(TScreenObject)(s)
    // that are being edited.
    FViewDirection: TViewDirection;

    // @name is the @link(TExpression) that represents the formula in @link(edZ).
    // If @name is @nil, btnOK.Enabled may be set to @false.
    FZFormula: TExpression;
    FStoredCanSetPoints: boolean;
    FCanSetPointsOutOfDate: Boolean;
    FDataEdits: TList;
    FFillingDataSetTreeView: Boolean;
    FCurrentEdit: TScreenObjectDataEdit;
    FUpdatingCurrentEdit: Boolean;
    FFormulaEdit: TScreenObjectDataEdit;
    FSelectedDataArrayName: string;
    FHOB_Node: TJvPageIndexNode;
    FHFB_Node: TJvPageIndexNode;
    FHydmod_Node: TJvPageIndexNode;
    FDeletingPhastTime: Boolean;
    FPriorElevationCount: integer;
    FModpath_Node: Pointer;
    FCanFillTreeView: Boolean;
    FSettingVerticies: Boolean;
    FVertexRowCount: Integer;
    FFilledDataSetTreeView: Boolean;
    FChildModels: TList;
    FChildModelsScreenObjects: TList;
    FSutraObs_Node: TJvPageIndexNode;
    FSutraSpecPressure_Node: TJvPageIndexNode;
    FSutraSpecTempConc_Node: TJvPageIndexNode;
    FSutraFluidFlux_Node: TJvPageIndexNode;
    FSutraMassEnergyFlux_Node: TJvPageIndexNode;
    FSutraLake_Node: TJvPageIndexNode;
    FCaptionFontChanged: Boolean;
    FCaptionTextChanged: Boolean;
    FCaptionFont: TFont;
    FVertexCaptionFontChanged: Boolean;
    FVertexCaptionFont: TFont;
    FSWiObs_Node: TJvPageIndexNode;
    FRipNode: TJvPageIndexNode;
    Function GenerateNewDataSetFormula(DataArray: TDataArray): string;
    // @name assigns new formulas for @link(TDataArray)s for each
    // @link(TScreenObject) in @link(FNewProperties).
    procedure AssignNewDataSetFormula(DSIndex: Integer;
      const NewFormula: string);

    // @name assigns the TInterpValuesItem for @link(TDataArray DataArray)
    // based on the values in @link(framePhastInterpolationData).
    procedure AssignPhastInterpolation(DataArray: TDataArray);

    {@name tests whether the boundary specified in Grid is
     identical to the one in Boundary.}
    function PhastBoundaryIsIdentical(const Grid: TRbwDataGrid4;
      const UsedTimes: TRealList;
      const Boundary: TCustomPhastBoundaryCollection;
      const ExpressionCol, PhastInterpolateCol: integer): boolean;

    {@name checks to see if Expression uses itself. If it does, it tries
     to restore the old formula for it using OldFormula,
     OldFormulaOK, and EditIndex.  DSetName is the name of the @link(TDataArray)
     to which Expression applies.}
    procedure CheckForCircularReference(const Expression: TExpression;
      const DSetName: string; const EditIndex: integer;
      const OldFormulaOK: boolean; const OldFormula: string);

    {@name checks to see if Expression uses itself. If it does, it tries
     to restore the old formula for it using OldFormula,
     and ARow.  DSetName is the name of the @link(TDataArray)
     to whose mixture formula Expression applies.}
    procedure CheckForCircularReferencesInMixtureFormulas(
      var Expression: TExpression; const DSName, OldFormula: string;
      const EditIndex: integer);

    // @name creates an @link(TExpression) for a boundary condition
    // based on the text in DataGrid at ACol, ARow.
    // Orientation, and EvaluatedAt
    // are used to chose the TRbwParser.
    procedure CreateBoundaryFormula(const DataGrid: TRbwDataGrid4;
      const ACol, ARow: integer; Formula: string;
      const Orientation: TDataSetOrientation; const EvaluatedAt: TEvaluatedAt);

    // @name creates a @link(TExpression) for a @link(TScreenObjectDataEdit).
    procedure CreateFormula(const DataSetIndex: integer;
      const NewFormula: string; const ShowError: boolean = True);

    // @name attempts to create a @link(TExpression) for the mixture
    // the the @link(TDataArray) identified by DataSetIndex.
    function CreateMixtureFormula(const DataSetIndex: integer): TExpression;

    // @name creates a TCustomVariable to represent the @link(TDataArray)
    //  specified by @link(TScreenObjectDataEdit Edit) in
    // each TRbwParser that needs it.
    procedure CreateVariable(const Edit: TScreenObjectDataEdit);

    // @name changes the appearances of @link(cbSetGridCellSize),
    // @link(cbEnclosedCells),
    // @link(cbIntersectedCells), and @link(cbInterpolation) so that if none
    // of them is checked, their appearance is emphasized.
    procedure EmphasizeValueChoices;

    // @name allows the OK button to be pressed if all of the
    // formulas for the data sets and elevation formulas are valid.
    procedure EnableOK_Button;

    // @name is used to store copies of the @link(TScreenObject)s in List.
    // The copies are stored in Collection.
    // @param(Collection Collection will hold copies of the
    // @link(TScreenObject)s in List)
    // @param(List List contains a series of @link(TScreenObject)s that are
    // being edited.  Copies of those @link(TScreenObject)s will be placed in
    // Collection.)
    // See also @link(TfrmEditFeatureFormula.FillPropertyCollection).
    procedure FillPropertyCollection(Collection: TScreenObjectEditCollection;
      List: TList);

    // @name stores the appropriate MODFLOW parameters for each MODFLOW package
    // in the appropriate @link(TframeScreenObjectParam).
    procedure GetAvailableParameters;

    // @name stores the times of MODFLOW stress periods in
    // @link(TframeScreenObjectParam).
    procedure GetAvailableTimes;

    // @name fills Times with all the times in Boundaries.
    procedure GetBoundaryTimes(
      const Boundaries: array of TCustomPhastBoundaryCollection;
      const Times: TRealList);

    // @name returns the appropriate TRbwParser based on the
    // combination of Orientation and EvaluatedAt.
    function GetCompiler(const Orientation: TDataSetOrientation; const
      EvaluatedAt: TEvaluatedAt): TRbwParser;

    // @name determines the @link(TDataArray.Orientation) and
    // @link(TDataArray.EvaluatedAt) of the data set
    // at Index and returns the appropriate compiler based on that combination.
    function GetCompilerByIndex(const Index: integer): TRbwParser;

    // @name returns the position of the @link(TScreenObjectDataEdit)
    // whose @link(TScreenObjectDataEdit.DataArray) has the same name as
    // DataSetName in @link(FDataEdits).
    // If such a @link(TScreenObjectDataEdit) isn't in @link(FDataEdits),
    // @name returns -1.  
    function GetDataSetIndexByName(const DataSetName: string): integer;

    // @name returns the TRbwParser that is appropriate
    // for specifying the elevation formula for a
    // @link(TScreenObject) based on the
    // direction from which the @link(TScreenObject)
    // is viewed and whether it is evaluated
    // by blocks or nodes.
    function GetElevationCompiler: TRbwParser;

    // @name stores the @link(TCustomVariable)s that can be used
    // in the formula for the @link(TDataArray) whose name is DSetName.
    procedure GetListOfOkVariables(EvaluatedAt: TEvaluatedAt;
      Orientation: TDataSetOrientation; VariableList: TList;
      DataSetIndex: Integer; DSEdit: TScreenObjectDataEdit);

    // @name sets the data stored in controls in @classname to default values
    // and otherwise prepares the @classname to edit objects.
    procedure InitializeControls(AScreenObject: TScreenObject);

    // @name initializes the grids.  It sets the Objects property corresponding
    // to each cell to nil and sets each cell that isn't a fixed cell to a
    // blank.  The cell at [1,1] for boundary conditions is set to hold a
    // '0' as required by boundary conditions.
    procedure InitializeGridObjects;

    // @name resets the data displayed in @link(dgBoundaryFlux).
    // It is called by @link(GetDataForMultipleScreenObjects) when two
    // @link(TScreenObject)s have Flux
    // boundaries that differ.
    procedure ResetFluxGrid;

    // @name resets the data displayed in @link(dgBoundaryLeaky).
    // It is called by @link(GetDataForMultipleScreenObjects) when two
    // @link(TScreenObject)s have Leaky
    // boundaries that differ.
    procedure ResetLeakyGrid;

    // @name resets the data displayed in @link(dgBoundaryRiver).
    // It is called by @link(GetDataForMultipleScreenObjects) when two
    // @link(TScreenObject)s have River
    // boundaries that differ.
    procedure ResetRiverGrid;

    // @name resets the data displayed in @link(dgSpecifiedHead).
    // It is called by @link(GetDataForMultipleScreenObjects)
    // when two @link(TScreenObject)s have
    // Specified Head boundaries that differ.
    procedure ResetSpecifiedHeadGrid;

    // @name resets the data displayed in @link(dgWellElevations).
    // It is called by @link(GetDataForMultipleScreenObjects)
    // when two @link(TScreenObject)s have
    // Well boundaries with well elevations that differ.
    procedure ResetWellElevationGrid;

    // @name resets the data displayed in  @link(dgWell).
    // It is called by @link(GetDataForMultipleScreenObjects)
    // when two @link(TScreenObject)s have
    // Well boundaries that differ.
    procedure ResetWellGrid;

    // @name calls @link(dgBoundaryStateChanged) for the first check box
    // in the TRbwDataGrid4 for the selected boundary condition that is
    // checked.
    procedure SelectBoundaryCell;

    { Set the captions of @link(cbEnclosedCells), @link(cbIntersectedCells),
      and @link(cbInterpolation) based on @link(rgEvaluatedAt).ItemIndex.}
    procedure SetCheckBoxCaptions;

    // @name is used to set the data for a single @link(TScreenObject)
    // when it is first created.
    // See @Link(SetMultipleScreenObjectData)
    // if there is more than one @link(TScreenObject) being edited.
    procedure SetData;

    // @name sets @link(FIsLoaded) and sets
    // @link(TframeScreenObject.FrameLoaded
    // TframeScreenObject.FrameLoaded).
    procedure SetIsLoaded(const Value: boolean);

    // @name is called when the user press the @link(btnOK) button
    // after editing the properties of one or more
    // @link(TScreenObject)s.
    // It set up a @link(TUndoSetScreenObjectProperties)
    // based on the data that the
    // user has changed.  @SeeAlso(SetData)
    procedure SetMultipleScreenObjectData;

    // @name is the setter for @link(MultipleScreenObjects);
    // It sets AllowGrayed for several check boxes.
    procedure SetMultipleScreenObjects(const Value: boolean);

    // @name shows or hides the tab for PHAST boundaries as appropriate.
    procedure ShowOrHideTabs;

    // @name stores time-varying values for PHAST boundary conditions
    // of the @link(TScreenObject)s begin edited.
    procedure StoreInterpolatedBoundary(Boundary: TCustomInterpolatedBoundary;
      DataGrid: TRbwDataGrid4);

    // @name stores the time-varying values of the Well and river boundaries.
    procedure StoreNonInterpolatedBoundary(
      Boundary: TCustomInterpolatedBoundary; DataGrid: TRbwDataGrid4);

    // @name stores the PHAST boundary condition for the @link(TScreenObject).
    procedure StorePhastBoundary;

    // @name assigns the PHAST leaky boundary conditions to the
    // @link(TScreenObject)s in @link(FNewProperties) based in the values
    // shown on @link(tabBoundaryRiver).
    procedure StorePhastLeakyBoundary;

    // @name assigns the PHAST river boundary conditions to the
    // @link(TScreenObject)s in @link(FNewProperties) based in the values
    // shown on @link(tabBoundaryLeaky).
    procedure StorePhastRiverBoundary;

    // @name assigns the PHAST specified flux boundary conditions to the
    // @link(TScreenObject)s in @link(FNewProperties) based in the values
    // shown on @link(tabBoundaryFlux).
    procedure StorePhastSpecifiedFlux;

    // @name assigns the PHAST specified head boundary conditions to the
    // @link(TScreenObject)s in @link(FNewProperties) based in the values
    // shown on @link(tabBoundarySpecifiedHead).
    procedure StorePhastSpecifiedHeads;

    // @name assigns the PHAST well boundary conditions to the
    // @link(TScreenObject)s in @link(FNewProperties) based in the values
    // shown on @link(tabBoundaryWell).
    procedure StorePhastWellBoundary;

    // @name returns @True if all the times recorded in Grid
    // in column TimeCol are identical to those in UsedTimes.
    function TimesIdentical(const Grid: TRbwDataGrid4;
      const UsedTimes: TRealList; const TimeCol: integer): boolean;

    // @name ensures that when a formula has been entered at
    // one of the elevation edit boxes, that the formula is valid.
    // See @link(edZ), @link(edHighZ), and @link(edLowZ).
    procedure ValidateEdFormula(const Ed: TEdit);
    procedure FillDataSetsTreeView(ListOfScreenObjects: TList);
    function AssignPoint(const Row: integer; out APoint: TPoint2D): boolean;
    procedure StoreChdBoundary;
    procedure GetChdBoundary(ScreenObjectList: TList);
    procedure StoreGhbBoundary;
    procedure GetGhbBoundary(ScreenObjectList: TList);
    procedure StoreWellBoundary;
    procedure StoreFarmWell;
    procedure GetWellBoundary(ScreenObjectList: TList);
    procedure GetFarmWell(ScreenObjectList: TList);
    procedure GetRivBoundary(ScreenObjectList: TList);
    procedure StoreRivBoundary;
    procedure GetDrnBoundary(ScreenObjectList: TList);
    procedure StoreDrnBoundary;
    procedure GetDrtBoundary(ScreenObjectList: TList);
    procedure StoreDrtBoundary;
    procedure StoreRchBoundary;
    procedure GetRchBoundary(ScreenObjectList: TList);
    function GetBoundaryValues(Boundary: TModflowBoundary): TCustomMF_BoundColl;
    function GetRechargeLayers(Boundary: TModflowBoundary): TCustomMF_BoundColl;
    function GetEvapLayers(Boundary: TModflowBoundary): TCustomMF_BoundColl;
    function GetEvapSurfaceDepth(Boundary: TModflowBoundary): TCustomMF_BoundColl;
    procedure GetEvtBoundary(ScreenObjectList: TList);
    procedure StoreEvtBoundary;
    procedure GetEtsBoundary(ScreenObjectList: TList);
    function GetEtsLayers(Boundary: TModflowBoundary): TCustomMF_BoundColl;
    function GetEtsSurfaceDepth(
      Boundary: TModflowBoundary): TCustomMF_BoundColl;
    procedure StoreEtsBoundary;
    procedure GetResBoundary(ScreenObjectList: TList);
    procedure GetReservoirBoundaryCollection(DataGrid: TRbwDataGrid4;
      ColumnOffset: Integer; ScreenObjectList: TList;
      TimeList: TParameterTimeList);
    procedure StoreResBoundary;

    procedure GetSwrRainBoundary(ScreenObjectList: TList);
    procedure GetSwrRainBoundaryCollection(DataGrid: TRbwDataGrid4;
      ColumnOffset: Integer; ScreenObjectList: TList;
      TimeList: TParameterTimeList);
    procedure StoreSwrRainBoundary;
    procedure GetSwrEvapBoundary(ScreenObjectList: TList);
    procedure StoreSwrEvapBoundary;
    procedure CreateSWR_Reach_Node(AScreenObject: TScreenObject);
    procedure CreateSWR_Rain_Node(AScreenObject: TScreenObject);
    procedure CreateSWR_Evap_Node(AScreenObject: TScreenObject);
    procedure GetSwrEvapBoundaryCollection(DataGrid: TRbwDataGrid4;
      ColumnOffset: Integer; ScreenObjectList: TList;
      TimeList: TParameterTimeList);
    procedure CreateSWR_LatInflow_Node(AScreenObject: TScreenObject);
    procedure GetSwrLatInflowBoundary(ScreenObjectList: TList);
    procedure StoreSwrLatInflowBoundary;
    procedure GetSwrLatInflowBoundaryCollection(DataGrid: TRbwDataGrid4;
      ColumnOffset: Integer; ScreenObjectList: TList;
      TimeList: TParameterTimeList);
    procedure CreateSWR_Stage_Node(AScreenObject: TScreenObject);
    procedure GetSwrStageBoundary(ScreenObjectList: TList);
    procedure GetSwrStageBoundaryCollection(DataGrid: TRbwDataGrid4;
      ColumnOffset: Integer; ScreenObjectList: TList;
      TimeList: TParameterTimeList);
    procedure StoreSwrStageBoundary;

    procedure GetGlobalVariables;
    procedure GetLakBoundary(ScreenObjectList: TList);
    procedure GetLakeBoundaryCollection(DataGrid: TRbwDataGrid4;
      ColumnOffset: Integer; ScreenObjectList: TList;
      TimeList: TParameterTimeList);
    procedure StoreLakBoundary;
    procedure StoreUzfBoundary;
    procedure GetUzfBoundary(ScreenObjectList: TList);
    function GetUzfEtRate(Boundary: TModflowBoundary): TCustomMF_BoundColl;
    function GetUzfInfiltrationRate(
      Boundary: TModflowBoundary): TCustomMF_BoundColl;
    function GetUzfEtExtinctionDepth(
      Boundary: TModflowBoundary): TCustomMF_BoundColl;
    function GetUzfEtExtinctionWaterContent(
      Boundary: TModflowBoundary): TCustomMF_BoundColl;
    procedure UpdateSfrNode(Sender: TObject);
    // @name validates the cell formula in @link(reDataSetFormula)
    // of @link(FCurrentEdit).
    // @name ensures that a formula entered
    // in @link(reDataSetFormula) is valid.
    procedure ValidateDataSetFormula(ShowError: boolean = True);
    // @name updates the list of which variables depend on which
    // others.
    procedure UpdateDataSetLinkages(const Expression: TExpression;
      const DataSetIndex: integer; const DSName: string);
    procedure CheckIfDataSetCanBeEdited(var CanEdit: boolean;
      Edit: TScreenObjectDataEdit; ListOfScreenObjects: TList);
    procedure GetHeadObservations(const ScreenObjectList: TList);
    procedure CreateHobNode(AScreenObject: TScreenObject);
    procedure GetHfbBoundary(const ScreenObjectList: TList);
    procedure CreateHfbNode(AScreenObject: TScreenObject);
    procedure CreateModpathNode;
    procedure StoreModPath;
    procedure CreateChobNode;
    procedure CreateDrobNode;
    procedure CreateGbobNode;
    procedure CreateRvobNode;
    procedure CreateMt3dmsSsmNode;
    procedure GetDrainFluxObservations(const AScreenObjectList: TList);
    procedure GetGhbFluxObservations(const AScreenObjectList: TList);
    procedure GetRiverFluxObservations(const AScreenObjectList: TList);
    procedure CreateGageNode;
    procedure GetGages(ListOfScreenObjects: TList);
    procedure SetGages(List: TList);
    procedure CreateMnw2Node;
    procedure CreateMnw1Node;
    procedure GetMnw2Boundary(const ScreenObjectList: TList);
    procedure Mnw2Changed(Sender: TObject);
    procedure GetMnw1Boundary(const ScreenObjectList: TList);
    procedure Mnw1Changed(Sender: TObject);
    procedure CreateHydmodNode(AScreenObject: TScreenObject);
    procedure GetHydmod(const ScreenObjectList: TList);
    procedure GetChildModels(const ScreenObjectList: TList);
    procedure UpdateNonParamCheckBox(Frame: TframeScreenObjectParam; ParamCol,
      ACol, ARow: Integer; const Value: string);
    procedure GetMt3dmsChemBoundary(ScreenObjectList: TList);
    procedure GetMt3dmsBoundaryCollection(DataGrid: TRbwDataGrid4;
      ColumnOffset: Integer; ScreenObjectList: TList;
      TimeList: TParameterTimeList);
    procedure StoreMt3dmsChemBoundary;
    procedure CreateMt3dmsTobConcNode(AScreenObject: TScreenObject);
    procedure GetMt3dConcObservations(const ScreenObjectList: TList);
    procedure GetMt3dmsFluxObservations(const AScreenObjectList: TList);
    procedure CreateMt3dmsTobFluxNode;
    procedure SetMt3dFluxObs(List: TList);
    procedure CreateSutraObsNode;
    procedure ActivateSutraFeature(Sender: TObject; CheckState: TCheckBoxState);
    procedure CreateSutraSpecPressNode;
    procedure CreateSutraSpecTempConcNode;
    procedure CreateSutraFluidFluxNode;
    procedure CreateSutraMassEnergyFluxNode;
    procedure SetSelectedSutraBoundaryNode;
    procedure GetDuplicatesAllowedForAdditionalObject(
      AScreenObject: TScreenObject);
    procedure GetStrBoundary(const ScreenObjectList: TList);
    procedure UpdateStrNode(Sender: TObject);
    procedure GetStreamFluxObservations(const AScreenObjectList: TList);
    procedure CreateStobNode;
    procedure GetFhbHeadBoundary(const ScreenObjectList: TList);
    procedure FhbHeadChanged(Sender: TObject);
    procedure FhbFlowChanged(Sender: TObject);
    procedure CreateFhbFlowNode;
    procedure GetFhbFlowBoundary(const ScreenObjectList: TList);
    procedure FarmPrecipChanged(Sender: TObject);
    procedure FarmRefEvapChanged(Sender: TObject);
    procedure FarmCropIDChanged(Sender: TObject);
    procedure FarmIDChanged(Sender: TObject);
    procedure GetFarmPrecip(const ScreenObjectList: TList);
    procedure GetFarmRefEvap(const ScreenObjectList: TList);
    procedure GetFarmCropID(const ScreenObjectList: TList);
    procedure GetFarmID(const ScreenObjectList: TList);
    procedure CreateCfpPipeNode(AScreenObject: TScreenObject);
    procedure CfpPipesChanged(Sender: TObject);
    procedure GetCfpPipes(const ScreenObjectList: TList);
    procedure CreateCfpFixedHeadNode(AScreenObject: TScreenObject);
    procedure CfpFixedHeadsChanged(Sender: TObject);
    procedure GetCfpFixedHeads(const ScreenObjectList: TList);
    procedure CreateCfpRechargeNode;
    procedure GetCfpRechargeBoundary(ScreenObjectList: TList);
    procedure StoreCfpRechargeFraction;
    procedure CreateSWR_DirectRunoff_Node(AScreenObject: TScreenObject);
    procedure GetSwrDirectRunoffBoundary(ScreenObjectList: TList);
    procedure StoreSwrDirectRunoffBoundary;
    procedure GetSwrDirectRunoffBoundaryCollection(DataGrid: TRbwDataGrid4;
      ColumnOffset: Integer; ScreenObjectList: TList;
      TimeList: TParameterTimeList);
    procedure GetSwrReaches(const ScreenObjectList: TList);
    procedure GetFootprintWells;
    procedure CreateSwiObsNode(AScreenObject: TScreenObject);
    procedure GetSwiObsBoundray(const ScreenObjectList: TList);
    procedure CreateRipNode(AScreenObject: TScreenObject);
    procedure GetRip(const ScreenObjectList: TList);
    procedure RipChanged(Sender: TObject);
    procedure CreateSutraLakeNode;
    procedure UpdateWellNodeState;
{$IFDEF SUTRA30}
    function ShouldCreateSutraLakeBoundary: Boolean;
{$ENDIF}

    // @name is set to @true when the @classname has stored values of the
    // @link(TScreenObject)s being edited.
    property IsLoaded: boolean read FIsLoaded write SetIsLoaded;

    // @name is set to @true if more than one @link(TScreenObject)s are
    // being edited at one time. Also AllowGrayed is set to @name for
    //  @link(cbLineColor), @link(cbInterpolation), @link(cbIntersectedCells),
    // @link(cbEnclosedCells), and @link(cbFillColor).
    property MultipleScreenObjects: boolean read FMultipleScreenObjects
      write SetMultipleScreenObjects;

    function CanSetPoints: Boolean;
    procedure InitializeModflowBoundaryFrames(const AScreenObject:
      TScreenObject);
    procedure StoreModflowBoundary(Frame: TframeScreenObjectParam;
      ParamType: TParameterType; Node: TJvPageIndexNode);
    procedure GetModflowBoundary(Frame: TframeScreenObjectParam;
      Parameter: TParameterType; ScreenObjectList: TList;
      Node: TJvPageIndexNode);
    procedure StoreFormulaInterpretation(Frame: TframeScreenObjectCondParam;
      ParamType: TParameterType);
    procedure GetFormulaInterpretation(Frame: TframeScreenObjectCondParam;
      Parameter: TParameterType; ScreenObjectList: TList);
    procedure GetModflowBoundaries(const AScreenObjectList: TList);
    procedure StoreModflowBoundaryParameters(Boundary: TModflowParamBoundary;
      Times: TTimeArray; Frame: TframeScreenObjectParam);
    procedure StoreModflowBoundaryValues(Frame: TframeScreenObjectNoParam;
      Times: TTimeArray; Boundary: TModflowBoundary);
    procedure StoreMF_BoundColl(ColumnOffset: Integer;
      BoundaryValues: TCustomMF_BoundColl; const Times: TTimeArray;
      Frame: TframeScreenObjectNoParam);
    procedure GetMF_BoundaryTimes(var Times: TTimeArray;
      Frame: TframeScreenObjectNoParam);
    procedure GetModflowBoundaryParameters(Parameter: TParameterType;
      ScreenObjectList: TList; Frame: TframeScreenObjectParam;
      TimeList: TParameterTimeList);
    procedure GetModflowBoundaryValues(Parameter: TParameterType;
      ScreenObjectList: TList; TimeList: TParameterTimeList;
      DataGrid: TRbwDataGrid4);
    procedure GetModflowBoundaryTimes(ScreenObjectList: TList;
      Parameter: TParameterType; TimeList: TParameterTimeList);
    procedure GetModflowBoundaryCollection(DataGrid: TRbwDataGrid4;
      ValuesFunction: TGetBoundaryCollectionEvent; ColumnOffset: Integer;
      ScreenObjectList: TList; Parameter: TParameterType;
      TimeList: TParameterTimeList);
    function DataSetsSpecified: Boolean;
    Function GetSfrParser(Sender: TObject): TRbwParser;
    procedure GetUzfCollection(TimeList: TParameterTimeList;
      ScreenObjectList: TList; ColumnOffset: Integer; DataGrid: TRbwDataGrid4;
      Method: TGetBoundaryCollectionEvent);
    procedure UpdateBoundaryState(Boundary: TFormulaProperty;
      ScreenObjectIndex: Integer; var State: TCheckBoxState);
    procedure GetSfrBoundary(const ScreenObjectList: TList);
    function ShouldStoreBoundary(Node: TJvPageIndexNode;
      Boundary: TFormulaProperty): boolean;
    procedure UpdateNodeState(Node: TJvPageIndexNode);
    procedure CreateChdNode;
    procedure CreateGhbNode;
    procedure CreateFhbHeadNode;
    procedure CreateWelNode;
    procedure CreateRivNode;
    procedure CreateDrnNode;
    procedure CreateDrtNode;
    procedure CreateRchNode(AScreenObject: TScreenObject);
    procedure CreateEvtNode(AScreenObject: TScreenObject);
    procedure CreateEtsNode(AScreenObject: TScreenObject);
    procedure CreateResNode(AScreenObject: TScreenObject);
    procedure CreateLakNode;
    procedure CreateSfrNode(AScreenObject: TScreenObject);
    procedure CreateStrNode(AScreenObject: TScreenObject);
    procedure CreateUzfNode(AScreenObject: TScreenObject);
    procedure CreateFarmWelNode;
    procedure CreateFarmPrecipNode(AScreenObject: TScreenObject);
    procedure CreateFarmRefEvapNode(AScreenObject: TScreenObject);
    procedure CreateFarmCropIDNode(AScreenObject: TScreenObject);
    procedure CreateFarmIDNode(AScreenObject: TScreenObject);
    procedure SetSelectedMfBoundaryNode;
    procedure InitializeVertexGrid;
    procedure InitializePhastSpecifiedHeadGrid;
    procedure InitializePhastSpecifiedFluxGrid;
    procedure InitializePhastLeakyBoundaryGrid;
    procedure InitializePhastRiverBoundaryGrid;
    procedure InitializePhastWellGrid;
    procedure SetColWidthsInPhastBoundaryGrids;
    procedure InitializePhastBoundaryControls;
    procedure GetPhastBoundariesForSingleObject;
    procedure GetPhastFluxBoundaryForSingleObject(UsedTimes: TRealList);
    procedure GetPhastLeakyBoundaryForSingleObject(UsedTimes: TRealList);
    procedure GetPhastRiverBoundaryForSingleObject(UsedTimes: TRealList);
    procedure GetPhastSpecifiedHeadBoundaryForSingleObject(
      UsedTimes: TRealList);
    procedure GetPhastWellBoundaryForSingleObject(UsedTimes: TRealList);
    procedure GetScreenObjectVerticies;
    procedure SetZLabelCaptions;
    procedure GetPhastBoundaryConditionsForAdditionalObjects(
      AScreenObject: TScreenObject; var TempType: TPhastBoundaryTypes);
    procedure GetPhastSpecifiedHeadBoundaryForAdditionalObject(
      AScreenObject: TScreenObject; UsedTimes: TRealList;
      var TempType: TPhastBoundaryTypes);
    procedure GetPhastSpecifiedFluxBoundaryForAdditionalObject(
      AScreenObject: TScreenObject; UsedTimes: TRealList;
      var TempType: TPhastBoundaryTypes);
    procedure GetPhastLeakyBoundaryForAdditionalObject(
      AScreenObject: TScreenObject; UsedTimes: TRealList;
      var TempType: TPhastBoundaryTypes);
    procedure GetPhastRiverBoundaryForAdditionalObject(
      AScreenObject: TScreenObject; UsedTimes: TRealList;
      var TempType: TPhastBoundaryTypes);
    procedure GetPhastWellBoundaryForAdditionalObject(
      AScreenObject: TScreenObject; UsedTimes: TRealList;
      var TempType: TPhastBoundaryTypes);
    procedure GetElevationFormulasForAdditionalObject(
      AScreenObject: TScreenObject);
    procedure GetDataSetsForAdditionalObject(AScreenObject: TScreenObject);
    procedure GetCellSizeUsedForAdditionalObject(AScreenObject: TScreenObject);
    procedure GetColorDataForAdditionalObject(AScreenObject: TScreenObject);
    procedure GetAssignmentMethodForAdditionalObject(AScreenObject: TScreenObject);
    procedure GetEvaluatedAtForAdditionalObject(AScreenObject: TScreenObject);
    procedure SetScreenObjectVerticies;
    procedure GetDataSetsForSingleObject;
    procedure SetGridCellSizeDataForSingleObject;
    procedure SetElevationDataForSingleObject;
    procedure GetColorDataForSingleObject;
    procedure GetAssignmentMethodForSingleObject;
    procedure AddGisFunctionsToAllParsers;
    procedure CreateDataSetEdits(ListOfScreenObjects: TList);
    procedure FillCompilerList(CompilerList: TList);
    procedure CheckIfDataSetUsedInElevationFormula(var CreateNode: Boolean;
      DataSet: TDataArray; ElevationFormula: string; Ed: TRbwEdit);
    procedure UpdateCurrentEdit;
    procedure UpdateScreenObjectData;
    procedure InvalidateAllDataSets;
    procedure UpdateDataSetTreeViewNodeStates;
    procedure SetSelectedName;
    procedure AssignHfbFormulas(Ed: TEdit);
    procedure DisableAllowGrayed(CheckBox: TCheckBox);
    procedure SetDisabledElevationFormulas(FirstScreenObject: TScreenObject);
    procedure AssignImportedValuesColumn(var First: boolean; var
      ColIndex: Integer; ValueStorage: TValueArrayStorage;
      const ColumnCaption: string);
    function GetCoordinateCaption(const AScreenObject: TScreenObject): string;
    function GetHigherCoordinateCaption(const AScreenObject: TScreenObject): string;
    function GetLowerCoordinateCaption(const AScreenObject: TScreenObject): string;
    procedure AssignConductanceCaptions(Frame: TframeScreenObjectCondParam;
      Boundary: TSpecificModflowBoundary);
    procedure GetIFaceForAdditionalObject(AScreenObject: TScreenObject);
    procedure GetModpathParticles(ListOfScreenObjects: TList);
    procedure GetFluxObservationsForFrame(Node: TJvPageIndexNode;
      FluxObservations: TFluxObservationGroups; const AScreenObjectList: TList;
      FluxFrame: TframeFluxObs);
    procedure GetHeadFluxObservations(const AScreenObjectList: TList);
    procedure CreateFluxNode(var NewNode: TJvPageIndexNode;
      FluxPackage: TModflowPackageSelection; AFrame: TframeFluxObs;
      APage: TJvStandardPage; FluxObservations: TFluxObservationGroups);
    procedure SetFluxObservations(List: TList; ANode: TJvPageIndexNode;
      AFrame: TframeFluxObs; FluxObservations: TFluxObservationGroups);
    procedure SetAllFluxObservations(List: TList);
    procedure GetNearestOutflowSegment(var NewText: string; ParameterType: TParameterType);
    procedure GetNearestDiversionSegment(var NewText: string; ParameterType: TParameterType);
    procedure GetFluxObservations(const AScreenObjectList: TList);
    procedure SetGageNodeStateIndex;
    // If the points in a @link(ScreenObjectUnit.TScreenObject)
    // are being changed, all the data sets that
    // are being affected by the @link(ScreenObjectUnit.TScreenObject)
    // must be updated.
    procedure UpdateVertices;
    procedure SetFrameData;
    procedure UpdateVertexNumbers;
    procedure UpdateSectionNumbers;
    procedure SetupChildModelControls(AScreenObject: TScreenObject);
    function CanSpecifyChildModels(AScreenObject: TScreenObject): Boolean;
    procedure GetVertexValues;
    procedure SetVertexValues(AScreenObject: TScreenObject);
    procedure GetUsedLgrModels(const AScreenObject: TScreenObject);
    procedure GetAdditionalUsedModels(const AScreenObjectList: TList);
    procedure EnableChildModelList(AScreenObject: TScreenObject);
    procedure FillChildModelList;
    procedure GetPositionLockedForAdditionalObject(AScreenObject: TScreenObject);
    procedure GetCanSelectNode(Node: TTreeNode; var AllowChange: Boolean);
    function ShouldCreateSutraBoundary: Boolean;
    procedure CreateSutraFeatureNodes;
    procedure SetDefaultCellSize;
    procedure SetModflowBoundaryColCount;
    procedure GetObjectLabelForAdditionalScreenObject(AScreenObject: TScreenObject);
    procedure SetObjectCaption(List: TList);
    procedure EnableWellTabfile;
    { Private declarations }
  public
    procedure Initialize;
    procedure ClearExpressionsAndVariables;
    // When a @link(TScreenObject) is first created,
    // @name is called to display it's properties.
    // GetDataForMultipleScreenObjects)
    procedure GetData(const AScreenObject: TScreenObject);
    // When the properties of one or more
    // @link(TScreenObject)s is being edited,
    // GetDataForMultipleScreenObjects is called to display their properties.
    // @SeeAlso(GetData)
    procedure GetDataForMultipleScreenObjects(const AScreenObjectList: TList);
    procedure HideGLViewersWithMicrosoftOpenGL;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  // @name is the instance of @link(TfrmScreenObjectProperties)
  // used in GoPhast.
  frmScreenObjectProperties: TfrmScreenObjectProperties = nil;

resourcestring
  StrLowerZcoordinate = 'Lower Z-coordinate';
  StrLowerYcoordinate = 'Lower Y-coordinate';
  StrLowerXcoordinate = 'Lower X-coordinate';
  StrHigherZcoordinate = 'Higher Z-coordinate';
  StrHigherYcoordinate = 'Higher Y-coordinate';
  StrHigherXcoordinate = 'Higher X-coordinate';
  StrZcoordinate = 'Z-coordinate';
  StrYcoordinate = 'Y-coordinate';
  StrXcoordinate = 'X-coordinate';
  StrNoParameter = 'no parameter';

implementation

uses Math, StrUtils, JvToolEdit, frmGoPhastUnit, AbstractGridUnit,
  frmFormulaUnit, frmConvertChoiceUnit, GIS_Functions, PhastModelUnit,
  ModflowConstantHeadBoundaryUnit, ModflowTransientListParameterUnit,
  ModflowGhbUnit, ModflowDrtUnit, ModflowRchUnit, ModflowEvtUnit,
  ModflowEtsUnit, ModflowLakUnit, frameCrossSectionUnit, frameFlowTableUnit,
  ModflowUzfUnit, ModflowSfrUnit, ModflowHobUnit, ModflowHfbUnit,
  LayerStructureUnit, ModpathParticleUnit, IntListUnit,
  frmManageFluxObservationsUnit, ModflowGageUnit, ModflowMnw2Unit, JvGroupBox,
  ModflowHydmodUnit, ModelMuseUtilities, Mt3dmsChemUnit, Mt3dmsChemSpeciesUnit,
  Mt3dmsTobUnit, Mt3dmsFluxObservationsUnit, frmDataSetsUnits,
  SutraBoundariesUnit, SutraMeshUnit, SutraOptionsUnit, ZoomBox2,
  ModflowStrUnit, ModflowFhbUnit, ModflowFmpFarmUnit,
  ModflowFmpPrecipitationUnit, ModflowFmpEvapUnit, ModflowFmpCropSpatialUnit,
  ModflowFmpWellUnit, ModflowCfpPipeUnit, ModflowCfpFixedUnit,
  ModflowCfpRechargeUnit, ModflowSwrUnit, ModflowSwrDirectRunoffUnit,
  ObjectLabelUnit, ModflowMnw1Unit, ModflowFmpFarmIdUnit, OpenGL,
  frmTimeUnitsConverterUnit, frmEditFeatureFormulaUnit, FootprintBoundary,
  ModflowSwiObsUnit, ModflowRipUnit, ModflowWellUnit;

resourcestring
  StrConcentrationObserv = 'Concentration Observations: ';
  StrFluxObserv = 'Flux Observations: ';
  StrUseToSetGridElem = 'Use to set grid element size';
  StrGridElementSize = 'Grid element size';
  StrUseToSetGridCell = 'Use to set grid cell size';
  StrGridCellSize = 'Grid cell size';
  StrUseToSetMeshElem = 'Use to set mesh element size';
  StrMeshElementSize = 'Mesh element size';
  StrNumberOfZFormulas = 'Number of Z formulas';
  StrNumberOfYFormulas = 'Number of Y formulas';
  StrNumberOfXFormulas = 'Number of X formulas';
  StrObjEditing = 'The object or objects you are editing will not '
        + 'affect the values of any data set because neither enclosed nor '
        + 'intersected elements or nodes will have their values set by the '
        + 'object or objects and element and node values will not be set by '
        + 'interpolation.  '
        + sLineBreak + sLineBreak
        + 'Is this really what you want?';
  StrYouAreAttemptingT = 'You are attempting to specify the value of a data ' +
  'set by interpolation but at least one of the data sets, %s, does not have' +
  ' an interpolator assigned.'#13#10'Is this really what you want?';
  StrErrorIn0sRow = 'Error in %0:s Row: %1:d Column: %2:d. %3:s';
  StrFormulaForSDat = 'Formula for "%s" data set';
  StrFormula = 'Formula';
  StrVertexNumbers = 'Vertex numbers';
  StrIfMoreThanOneObj = 'If more than one object is being edited, vertices c' +
  'an not be edited.';
  StrSorryThisFunction = 'Sorry, This function can only be performed when a ' +
  'single object is being edited.';
  StrThereIsNoOtherSt = 'There is no other stream or lake';
  StrTime = 'Time';
  StrSolution = 'Solution';
  StrHead = 'Head';
  StrAssociatedSolution = 'Associated solution';
  StrInterpolateHead = 'Interpolate head';
  StrInterpolateSolution = 'Interpolate solution';
  StrFlux = 'Flux';
  StrInterpolateFlux = 'Interpolate flux';
  StrSectionNumber = 'Section Number';
  StrNewSection = 'New section';
  StrX = 'X';
  StrY = 'Y';
  StrZ = 'Z';
  StrGAGEForS = 'GAGE: for %s';
  StrErrorThereAppears = 'Error: There appears to be a cirular reference to ' +
  '"%0:s" in the formula for %1:s.  Do you wish to restore the old formula';
  StrErrorThereAppearsNoRevert = 'Error: There appears to be a cirular refer' +
  'ence to %0:s"" in the formula for %1:s.';
  StrErrorInFormulaS = 'Error in formula: %s';
  StrErrorInMixtureFor = 'Error in mixture formula for the data set "%0:s ' +
  '%1:s": ';
  StrTheFormulaYouEnte = 'The formula you entered is does not return the cor' +
  'rect data type.  It will be automatically converted.';
  StrErrorInFormulaFor = 'Error in formula for the data set "%0:s": %1:s';
  StrSThisMightBeD = '%s '#13#10'This might be due to a circular reference. ' +
  ' Do you wish to restore the old formula?';
  StrSThisMightBeDNoRevert = '%s '#13#10'This might be due to a circular ref' +
  'erence.';
  StrYouMustSpecifyNod = 'You must specify nodes or elements before editing ' +
  'the formula.';
  StrErrorTheFormulaI = 'Error: the formula does not result in a real num' +
  'ber';
  StrThisObjectWillNo = 'This object will no longer set the properties of 2D' +
  ' data sets that are used in its elevation formula(s) either directly or i' +
  'ndirectly.';
  StrTheseObjectsWillN = 'These objects will no longer set the properties of' +
  ' 2D data sets that are used in their elevation formula(s) either directly' +
  ' or indirectly.';
  StrSpecifiedHead = 'Specified head';
  StrSpecifiedFlux = 'Specified flux';
  StrLeakyBoundaryHead = 'Leaky boundary head';
  StrRiver = 'River';
  StrWellRate = 'Well rate';
  StrInterpolated = 'Interpolated';
  StrFirstValue = 'First Value';
  StrSecondValue = 'Second Value';
  StrFirstElevation = 'First Elevation';
  StrSecondElevation = 'Second Elevation';
  StrFirstDepth = 'First Depth';
  StrSecondDepth = 'Second Depth';
  StrSpecifiedSolution = 'Specified solution';
  StrErrorThereAppearsCirc = 'Error: There appears to be an error or a cirular' +
  ' reference in this formula.  Do you wish to restore the old formula';
  StrErrorThereAppears2 = 'Error: There appears to be a cirular reference to' +
  ' "%s" in this formula.  Do you wish to restore the old formula';
  StrInvalidMethod = 'You are attempting to specify MODFLOW features but' +
  ' they won''t be specified correctly because neither "Set properties of en' +
  'closed cells" nor "Set properties of intersected cells" is checked.'#13#10 +
  #13#10'Is this really what you want?';
  StrSutraObservations = 'Observations';
  StrSutraSpecifiedHead = 'Specified Head';
  StrSpecifiedPressure = 'Specified Pressure';

  StrDuplicateSAllowed = 'Duplicate %s allowed';
  StrThereIsNoOtherSteam = 'There is no other stream.';
  StrFarmWellsInS = 'Farm Wells in %s';
  StrFarmPrecipInS = 'Precip. in %s';
  StrFarmRefEvapIn = 'Ref. Evap. in %s';
  StrFarmsInS = 'Farms in %s';
  StrCropIDInS = 'Crop ID in %s';
  StrFarmIDInS = 'Farm ID in %s';
  StrCFPFixedHeads = 'CFP: Fixed Heads';
  StrCRCHConduitRechar = 'CRCH: Conduit Recharge';
  StrYouCanOnlyDefine = 'You can only define conduits in CFP with objects th' +
  'at have one %s formula on the Properties tab.';
  StrThereAreTooManyI = 'There are too many imported values for %s. The extr' +
  'a values will be deleted.';
  StrThereAreTooFewIm = 'There are too few imported values for %s. Default v' +
  'alues will be added.';
//  StrMassOrEnergyFlux = 'Mass or Energy Flux';

{$R *.dfm}

type
  TVertexColumn = (vcN, vcSection, vcX, vcY, vcNewSection);

  // @name represents the columns for the grid used in the specified head,
  // leaky, and flux boundary conditions.
  //
  // See TfrmScreenObjectProperties.@link(
  // TfrmScreenObjectProperties.dgSpecifiedHead).
  //
  // See TfrmScreenObjectProperties.@link(
  // TfrmScreenObjectProperties.dgBoundaryFlux).
  //
  // See TfrmScreenObjectProperties.@link(
  // TfrmScreenObjectProperties.dgBoundaryLeaky).
  TInterpolatedBoundaryColumns = (ibcNone, ibcTime, ibcBoundaryValue,
    ibcBoundaryInterpolate, ibcSolution, ibcSolutionInterpolate);

  // @name represents the columns for the grid used in the river and well
  // boundary condition
  //
  // See TfrmScreenObjectProperties.@link(
  // TfrmScreenObjectProperties.dgBoundaryRiver).
  //
  // See TfrmScreenObjectProperties.@link(TfrmScreenObjectProperties.dgWell).
  TNonInterpolateColumns = (nicNone, nicTime, nicBoundaryValue, nicSolution);


function CompareStartAndEndTimes(Item1, Item2: pointer): integer;
var
  Time1, Time2: TParameterTime;
begin
  Time1 := Item1;
  Time2 := Item2;
  result := Sign(Time1.StartTime - Time2.StartTime);
  if result = 0 then
  begin
    result := Sign(Time1.EndTime - Time2.EndTime);
  end;
end;

procedure TfrmScreenObjectProperties.EnableOK_Button;
var
  Index: integer;
  Enable: boolean;
  Edit: TScreenObjectDataEdit;
begin
  // EnableOK_Button allows the OK button to be pressed if all of the
  // formulas for the data sets and elevation formulas are valid.
  Enable := True;
  for Index := 1 to FDataEdits.Count - 1 do
  begin
    Edit := FDataEdits[Index];
    if (Edit.Used = cbChecked)and (Edit.Expression = nil)
      and (Edit.Formula <> '') then
    begin
      Enable := False;
      break;
    end;
  end;
  if edZ.Enabled and (edZ.Text <> '') and (FZFormula = nil) then
  begin
    Enable := False;
  end;
  if edHighZ.Enabled and (edHighZ.Text <> '') and (FHighZFormula = nil) then
  begin
    Enable := False;
  end;
  if edLowZ.Enabled and (edLowZ.Text <> '') and (FLowZFormula = nil) then
  begin
    Enable := False;
  end;

  btnOK.Enabled := Enable;
end;

procedure TfrmScreenObjectProperties.btnColorClick(Sender: TObject);
var
  AShape: TShape;
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
    // allow the user to edit the line or fill color of a @link(TScreenObject).
    // See @link(btnLineColor) and @link(btnFillColor).
  inherited;
  if Sender = btnLineColor then
  begin
    AShape := shpLineColor;
  end
  else if Sender = btnFillColor then
  begin
    AShape := shpFillColor;
  end
  else
  begin
    Assert(False);
    AShape := nil;
  end;

  coldlgColors.Color := AShape.Brush.Color;
  if coldlgColors.Execute then
  begin
    AShape.Brush.Color := coldlgColors.Color;
    AShape.Visible := True;
    if Sender = btnLineColor then
    begin
      AShape.Pen.Color := coldlgColors.Color;
      if IsLoaded then
      begin
        for Index := 0 to FNewProperties.Count - 1 do
        begin
          Item := FNewProperties[Index];
          Item.ScreenObject.LineColor := coldlgColors.Color;
        end;
      end;
    end
    else if Sender = btnFillColor then
    begin
      if IsLoaded then
      begin
        for Index := 0 to FNewProperties.Count - 1 do
        begin
          Item := FNewProperties[Index];
          Item.ScreenObject.FillColor := coldlgColors.Color;
        end;
      end;
    end
    else
    begin
      Assert(False);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.btnConvertTimeUnitsClick(Sender: TObject);
var
  frmTimeUnitsConverter: TfrmTimeUnitsConverter;
begin
  inherited;
  frmTimeUnitsConverter := TfrmTimeUnitsConverter.Create(nil);
  frmTimeUnitsConverter.Show;
end;

procedure TfrmScreenObjectProperties.btnDataSetFormulaClick(Sender: TObject);
var
  NewFormula: string;
  Variable: TCustomValue;
  Index: integer;
  Used: TStringList;
  Orientation: TDataSetOrientation;
  VariableList: TList;
  Expression: TExpression;
  OldFormula: string;
  OldFormulaOK: boolean;
  NewValue: string;
  EvaluatedAt: TEvaluatedAt;
  DSetName: string;
  ActiveOK: boolean;
  SpecifiedHeadOK: boolean;
  DsIndex: integer;
  ActiveDataArray: TDataArray;
begin
  inherited;

  Assert(FCurrentEdit <> nil);

  DSetName := FCurrentEdit.DataArray.DisplayName;

  VariableList := TList.Create;
  // VariableList will hold a list of variables that can
  // be used in the function
  Used := TStringList.Create;
  // "Used" will be a list of variables that depend on
  // the data set whose formula will be edited.
  try
    Orientation := FCurrentEdit.DataArray.Orientation;
    EvaluatedAt := FCurrentEdit.DataArray.EvaluatedAt;
    // Add the variable whose value is being set to "Used".

    Used.Assign(FCurrentEdit.UsedBy);

    Used.Sorted := True;
    GetListOfOkVariables(EvaluatedAt, Orientation, VariableList,
      FDataEdits.IndexOf(FCurrentEdit), FCurrentEdit);

    // if the user makes an invalid formula, it
    // may be necessary to restore it but only
    // if the formula that was already present
    // was OK to begin with.
    OldFormulaOK := FCurrentEdit.Expression <> nil;
    OldFormula := FCurrentEdit.Formula;
    NewValue := reDataSetFormula.Text;
    if (NewValue = '') and OldFormulaOK then
    begin
      NewValue := FCurrentEdit.Expression.DecompileDisplay;
    end;
    with TfrmFormula.Create(self) do
    begin
      try
        IncludeGIS_Functions(EvaluatedAt);
        ActiveDataArray := frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(rsActive);
        ActiveOK := (ActiveDataArray <> nil)
          and not ActiveDataArray.IsListeningTo(FCurrentEdit.DataArray);
        SpecifiedHeadOK := True;
        PopupParent := self;

        // register the appropriate variables with the
        // parser.
        for Index := 0 to VariableList.Count - 1 do
        begin
          Variable := VariableList[Index];
          rbFormulaParser.RegisterVariable(Variable);
          if UpperCase(Variable.Name) = UpperCase(rsActive) then
          begin
            ActiveOK := False;
          end;
          if UpperCase(Variable.Name) = UpperCase(rsModflowSpecifiedHead) then
          begin
            SpecifiedHeadOK := False;
          end;
        end;
        if not ActiveOK then
        begin
          RemoveActiveOnLayer;
        end;
        if not SpecifiedHeadOK then
        begin
          RemoveSpecifiedHeadOnLayer;
        end;
        RemoveGetVCont;
        RemoveHufFunctions;

        // show the variables and functions
        UpdateTreeList;

        // put the formula in the TfrmFormula.
        Formula := NewValue;

        // The user edits the formula.
        ShowModal;
        if ResultSet then
        begin
          NewFormula := Formula;
          DsIndex := FDataEdits.IndexOf(FCurrentEdit);
          if FCurrentEdit.Formula <> NewFormula then
          begin
            FCurrentEdit.Formula := NewFormula;
            FSetCellsColor := True;
            CreateFormula(DsIndex, NewFormula);
            Expression := FCurrentEdit.Expression;

            if Expression <> nil then
            begin
              CheckForCircularReference(Expression, DSetName, DsIndex,
                OldFormulaOK, OldFormula);

              // update the list of which variables depend on which
              // others.;
              UpdateDataSetLinkages(Expression, DsIndex, DSetName);

            end;
          end;
          AssignNewDataSetFormula(DsIndex, FCurrentEdit.Formula);
          reDataSetFormula.Text := FCurrentEdit.Formula;
        end;                                                            
      finally
        Free;
      end;
    end;
  finally
    Used.Free;
    VariableList.Free;
    // Don't allow the user to click the OK button if any formulas are invalid.
    EnableOK_Button;
  end;
end;

procedure TfrmScreenObjectProperties.btnEditFeatureFormulasClick(
  Sender: TObject);
var
  ScreenObjects: TScreenObjectList;
  index: Integer;
  frmEditFeatureFormula: TfrmEditFeatureFormula;
begin
  inherited;
  Hide;
  ModalResult := mrCancel;
  ScreenObjects := TScreenObjectList.Create;
  try
    ScreenObjects.Capacity := FScreenObjectList.Count;
    for index := 0 to FScreenObjectList.Count - 1 do
    begin
      ScreenObjects.Add(
        TScreenObject(FScreenObjectList[index]));
    end;
    frmEditFeatureFormula := TfrmEditFeatureFormula.Create(nil);
    try
      frmEditFeatureFormula.GetData(ScreenObjects);
      frmEditFeatureFormula.ShowModal;
    finally
      frmEditFeatureFormula.Free
    end;
  finally
    ScreenObjects.Free;
  end;
end;

procedure TfrmScreenObjectProperties.InitializeGridObjects;
var
  List: TList;
  GridIndex, RowIndex, ColIndex: integer;
  Grid: TRbwDataGrid4;
begin
  List := TList.Create;
  try
    List.Add(dgSpecifiedHead);
    List.Add(dgBoundaryFlux);
    List.Add(dgBoundaryLeaky);
    List.Add(dgBoundaryRiver);
    List.Add(dgWell);
    List.Add(dgWellElevations);

    for GridIndex := 0 to List.Count -1 do
    begin
      Grid := List[GridIndex];
      for RowIndex := 0 to Grid.RowCount -1 do
      begin
        for ColIndex := 0 to Grid.ColCount -1 do
        begin
          Grid.Objects[ColIndex,RowIndex] := nil;
          if (ColIndex >= Grid.FixedCols) and (RowIndex >= Grid.FixedRows) then
          begin
            Grid.Cells[ColIndex,RowIndex] := '';
            if Grid.Columns[ColIndex].Format = rcf4Boolean then
            begin
              Grid.Checked[ColIndex,RowIndex] := False;
            end;
          end;
        end;
      end;
    end;
    // remove dgWellElevations.
    List.Remove(dgWellElevations);
    // reset the first time for boundary conditions.
    for GridIndex := 0 to List.Count -1 do
    begin
      Grid := List[GridIndex];
      Grid.Cells[1,1] := '0';
    end;
  finally
    List.Free;
  end;
end;

procedure TfrmScreenObjectProperties.comboDrtLocationChoiceChange(
  Sender: TObject);
begin
  inherited;
  UpdateNodeState(FDRT_Node);
  if comboDrtLocationChoice.ItemIndex >= 0 then
  begin
    pcDrtReturnLChoice.ActivePageIndex :=
      comboDrtLocationChoice.ItemIndex;
  end
  else
  begin
    pcDrtReturnLChoice.ActivePageIndex := 0;
  end;
  StoreDrtBoundary;
end;

procedure TfrmScreenObjectProperties.comboDrtReturnObjectChange(
  Sender: TObject);
begin
  inherited;
  UpdateNodeState(FDRT_Node);
end;

procedure TfrmScreenObjectProperties.comboGhbConductanceInterpChange(Sender: TObject);
begin
  inherited;
  UpdateNodeState(FGHB_Node);
  StoreGhbBoundary;
end;

procedure TfrmScreenObjectProperties.jvplModflowBoundariesChange(
  Sender: TObject);
begin
  inherited;
  if IsLoaded then
  begin
    HelpKeyWord := jvplModflowBoundaries.ActivePage.HelpKeyword;
    btnHelp.HelpKeyword := HelpKeyWord;
  end;
end;

procedure TfrmScreenObjectProperties.jvplSutraFeaturesChange(Sender: TObject);
begin
  inherited;
  HelpKeyWord := jvplSutraFeatures.ActivePage.HelpKeyword;
  btnHelp.HelpKeyword := HelpKeyWord;
end;

procedure TfrmScreenObjectProperties.jvpltvSutraFeaturesCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  inherited;
  if Node.Selected and not Sender.Focused then
  begin
    Sender.Canvas.Brush.Color := clMenuHighlight;
  end;
end;

procedure TfrmScreenObjectProperties.jvpltvSutraFeaturesMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CanSelectNode: Boolean;
begin
  inherited;
  CanSelectNode := True;
//  jvtlModflowBoundaryNavigatorChanging(Sender,
//    jvpltvSutraFeatures.GetNodeAt(X,Y), CanSelectNode);
  if not CanSelectNode then
  begin
    Exit;
  end;
  if htOnStateIcon in jvpltvSutraFeatures.GetHitTestInfoAt(X, Y) then
  begin
    case jvpltvSutraFeatures.Selected.StateIndex of
      1:
        begin
          jvpltvSutraFeatures.Selected.StateIndex := 2;
        end;
      2:
        begin
          jvpltvSutraFeatures.Selected.StateIndex := 1;
        end;
      3:
        begin
          jvpltvSutraFeatures.Selected.StateIndex := 2;
        end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.jvtlModflowBoundaryNavigatorChanging(
  Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  GetCanSelectNode(Node, AllowChange);
end;

procedure TfrmScreenObjectProperties.jvtlModflowBoundaryNavigatorCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  CanSelect: boolean;
begin
  inherited;
  CanSelect := True;
  GetCanSelectNode(Node, CanSelect);
  if not CanSelect then
  begin
    Sender.Canvas.Brush.Color := clBtnFace;
  end;
  if Node.Selected then
  begin
    Sender.Canvas.Brush.Color := clMenuHighlight;
    Sender.Canvas.Font.Color := clWhite;
  end;
end;

procedure TfrmScreenObjectProperties.jvtlModflowBoundaryNavigatorMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CanSelectNode: Boolean;
  ANode: TTreeNode;
  ViewDirString: string;
begin
  inherited;
  CanSelectNode := True;
  ANode := jvtlModflowBoundaryNavigator.GetNodeAt(X,Y);
  jvtlModflowBoundaryNavigatorChanging(Sender,
    ANode, CanSelectNode);
  if not CanSelectNode then
  begin
    if ANode = FCfpPipe_Node then
    begin
      Beep;
      case FViewDirection of
        vdTop: ViewDirString := StrZ;
        vdFront: ViewDirString := StrY;
        vdSide: ViewDirString := StrX;
      end;
      MessageDlg(Format(StrYouCanOnlyDefine, [ViewDirString]), mtInformation, [mbOK], 0);
    end;
    Exit;
  end;
  if htOnStateIcon in jvtlModflowBoundaryNavigator.GetHitTestInfoAt(X, Y) then
  begin
    case jvtlModflowBoundaryNavigator.Selected.StateIndex of
      1:
        begin
          jvtlModflowBoundaryNavigator.Selected.StateIndex := 2;
        end;
      2:
        begin
          jvtlModflowBoundaryNavigator.Selected.StateIndex := 1;
        end;
      3:
        begin
          jvtlModflowBoundaryNavigator.Selected.StateIndex := 2;
        end;
    end;
    if jvtlModflowBoundaryNavigator.Selected = FCHD_Node then
    begin
      StoreChdBoundary;
      if (FChob_Node <> nil) and (FCHD_Node.StateIndex = 1) then
      begin
        FChob_Node.StateIndex := 1;
      end;
      jvtlModflowBoundaryNavigator.Invalidate;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FGHB_Node then
    begin
      StoreGhbBoundary;
      if (FGbob_Node <> nil) and (FGHB_Node.StateIndex = 1) then
      begin
        FGbob_Node.StateIndex := 1;
      end;
      jvtlModflowBoundaryNavigator.Invalidate;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FWEL_Node then
    begin
      StoreWellBoundary;
      EnableWellTabfile;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FRIV_Node then
    begin
      StoreRivBoundary;
      if (FRvob_Node <> nil) and (FRIV_Node.StateIndex = 1) then
      begin
        FRvob_Node.StateIndex := 1;
      end;
      jvtlModflowBoundaryNavigator.Invalidate;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FDRN_Node then
    begin
      StoreDrnBoundary;
      if (FDrob_Node <> nil) and (FDRN_Node.StateIndex = 1) then
      begin
        FDrob_Node.StateIndex := 1;
      end;
      jvtlModflowBoundaryNavigator.Invalidate;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FDRT_Node then
    begin
      StoreDrtBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FRCH_Node then
    begin
      StoreRchBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FEVT_Node then
    begin
      StoreEvtBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FETS_Node then
    begin
      StoreEtsBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FRES_Node then
    begin
      StoreResBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FLAK_Node then
    begin
      StoreLakBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FMNW2_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FMNW1_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FSFR_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FSTR_Node then
    begin
      if (FStob_Node <> nil) and (FSTR_Node.StateIndex = 1) then
      begin
        FStob_Node.StateIndex := 1;
      end;
      jvtlModflowBoundaryNavigator.Invalidate;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FHOB_Node then
    begin
      if jvtlModflowBoundaryNavigator.Selected.StateIndex <= 1 then
      begin
        frameHeadObservations.seTimes.AsInteger := 0;
      end;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FHFB_Node then
    begin
      frameHfbBoundary.Enabled :=
        jvtlModflowBoundaryNavigator.Selected.StateIndex > 1;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FUZF_Node then
    begin
      StoreUzfBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FChob_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FDrob_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FGbob_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FRvob_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FStob_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FGage_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FHydmod_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FFhbHead_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FFhbFlow_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FMt3dmsSsm_Node then
    begin
      StoreMt3dmsChemBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FMt3dmsTobConc_Node then
    begin
      if jvtlModflowBoundaryNavigator.Selected.StateIndex <= 1 then
      begin
        frameMt3dmsTobConc.seTimes.AsInteger := 0;
      end;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FMt3dmsTobFlux_Node then
    begin
      // do nothing
    end
//    else if jvtlModflowBoundaryNavigator.Selected = FFmpFarm_Node then
//    begin
//      // do nothing
//    end
    else if jvtlModflowBoundaryNavigator.Selected = FFarmWell_Node then
    begin
      StoreFarmWell;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FFarmPrecip_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FFarmRevEvap_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FFarmCropID_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FFarmID_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FCfpPipe_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FCfpFixedHead_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FCRCH_Node then
    begin
      StoreCfpRechargeFraction;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FSWR_Reach_Node then
    begin
      jvtlModflowBoundaryNavigator.Invalidate;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FSWR_Rain_Node then
    begin
      StoreSwrRainBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FSWR_Evap_Node then
    begin
      StoreSwrEvapBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FSWR_LatInflow_Node then
    begin
      StoreSwrLatInflowBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FSWR_Stage_Node then
    begin
      StoreSwrStageBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FSWR_DirectRunoff_Node then
    begin
      StoreSwrDirectRunoffBoundary;
    end
    else if jvtlModflowBoundaryNavigator.Selected = FSWiObs_Node then
    begin
      // do nothing
    end
    else if jvtlModflowBoundaryNavigator.Selected = FRipNode then
    begin
      // do nothing
    end

    else
    begin
      Assert(False);
    end;
//    if (FMt3dms_Node <> nil)
//      and (FMt3dms_Node.StateIndex <> 1)
//      and not CanSelectMt3dms then
//    begin
//      FMt3dms_Node.StateIndex := 1;
//      StoreMt3dmsChemBoundary;
//      jvtlModflowBoundaryNavigator.Invalidate;
//    end;
  end;
end;

procedure TfrmScreenObjectProperties.memoCaptionChange(Sender: TObject);
begin
  inherited;
  FCaptionTextChanged := True;
end;

procedure TfrmScreenObjectProperties.InitializeControls(
  AScreenObject: TScreenObject);
var
  Index: integer;
  CompilerList: TList;
  Compiler: TRbwParser;
begin

  CustomizeControls;
  GetAvailableParameters;
  GetAvailableTimes;
  InitializeGridObjects;

  tabNodes.TabVisible := True;
  if dgVerticies.RowCount <= 1 then
  begin
    dgVerticies.RowCount := 2;
  end;
  dgVerticies.FixedRows := 1;

  edName.Enabled := True;

  pageMain.ActivePageIndex := 0;
  FScreenObjectList := nil;
  memoNames.Lines.Clear;
  rgBoundaryType.ItemIndex := 0;
  comboSolutionType.ItemIndex := 0;
  comboSolutionTypeChange(nil);
  edLeakyHydraulicConductivity.Text := '';
  edLeakyThickness.Text := '';
  edRiverDescripton.Text := '';
  edRiverHydraulicConductivity.Text := '';
  edRiverWidth.Text := '';
  edRiverDepth.Text := '';
  edRiverBedThickness.Text := '';
  edWellDescription.Text := '';
  rdeWellDiameter.Text := '';
  rdeWellLandSurfaceDatum.Text := '';
  cbWellPumpAllocation.Checked := False;
  comboWellIntervalStyle.ItemIndex := 0;
  seWellIntervals.Value := 1;
  edZ.Text := '0';
  edHighZ.Text := '0';
  edLowZ.Text := '0';

  rdeGridCellSize.Text := '1';

  rgBoundaryType.Handle;
  rgBoundaryType.Buttons[Ord(btRiver)].Enabled := True;
  rgBoundaryType.Buttons[Ord(btWell)].Enabled := True;
//  rgBoundaryType.Controls[Ord(btRiver)].Enabled := True;
//  rgBoundaryType.Controls[Ord(btWell)].Enabled := True;

  CompilerList := TList.Create;
  try
    FillCompilerList(CompilerList);
    for Index := 0 to CompilerList.Count - 1 do
    begin
      Compiler := CompilerList[Index];
      Compiler.ClearExpressions;
      Compiler.ClearVariables;
    end;
    GetGlobalVariables;
  finally
    CompilerList.Free;
  end;


  // If FUndoSetScreenObjectProperties was submitted, it will have
  // been set to nil.
  FBoundaryPhastInterpolationList.Clear;

  jvtlModflowBoundaryNavigator.Items.Clear;

  // The nodes in jvtlModflowBoundaryNavigator should be created
  // in the order in which they ought to be displayed.
  CreateChdNode;
  CreateChobNode;
  CreateDrnNode;
  CreateDrobNode;
  CreateDrtNode;
  CreateEtsNode(AScreenObject);
  CreateEvtNode(AScreenObject);
  CreateFhbFlowNode;
  CreateFhbHeadNode;
  CreateGhbNode;
  CreateGbobNode;
  CreateHfbNode(AScreenObject);
  CreateHydmodNode(AScreenObject);
  CreateHobNode(AScreenObject);
  CreateLakNode;
  CreateMnw1Node;
  CreateMnw2Node;
  CreateRchNode(AScreenObject);
  CreateResNode(AScreenObject);
  CreateRipNode(AScreenObject);
  CreateRivNode;
  CreateRvobNode;
  CreateSfrNode(AScreenObject);
  CreateStrNode(AScreenObject);
  CreateStobNode;
  CreateGageNode;
  CreateSwiObsNode(AScreenObject);;
  CreateUzfNode(AScreenObject);
  CreateWelNode;
  CreateCfpPipeNode(AScreenObject);
  CreateCfpFixedHeadNode(AScreenObject);
  CreateCfpRechargeNode;
//  CreateFarmNode(AScreenObject);
  CreateFarmIDNode(AScreenObject);
  CreateFarmWelNode;
  CreateFarmCropIDNode(AScreenObject);
  CreateFarmPrecipNode(AScreenObject);
  CreateFarmRefEvapNode(AScreenObject);
  CreateModpathNode;
  CreateMt3dmsSsmNode;
  CreateMt3dmsTobConcNode(AScreenObject);
  CreateMt3dmsTobFluxNode;
  CreateSWR_Reach_Node(AScreenObject);
  CreateSWR_Rain_Node(AScreenObject);
  CreateSWR_Evap_Node(AScreenObject);
  CreateSWR_LatInflow_Node(AScreenObject);
  CreateSWR_Stage_Node(AScreenObject);
  CreateSWR_DirectRunoff_Node(AScreenObject);

  CreateSutraFeatureNodes;

  tabLGR.TabVisible := frmGoPhast.PhastModel.LgrUsed;
  SetupChildModelControls(AScreenObject);
  jvplModflowBoundaries.ActivePage := jvspBlank;
  jvplSutraFeatures.ActivePage := jvspSutraBlank;
end;

procedure TfrmScreenObjectProperties.GetGlobalVariables;
var
  CompilerList: TList;
begin
  CompilerList := TList.Create;
  try
    FillCompilerList(CompilerList);
    frmGoPhast.PhastModel.RefreshGlobalVariables(CompilerList);
  finally
    CompilerList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.ActivateSutraFeature(Sender: TObject;
  CheckState: TCheckBoxState);
begin
  if Sender = frameSutraObservations then
  begin
    if FSutraObs_Node <> nil then
    begin
      FSutraObs_Node.StateIndex := Ord(CheckState)+1;
    end;
  end
  else if Sender = frameSutraSpecifiedPressure then
  begin
    if FSutraSpecPressure_Node <> nil then
    begin
      FSutraSpecPressure_Node.StateIndex := Ord(CheckState)+1;
    end;
  end
  else if Sender = frameSutraSpecTempConc then
  begin
    if FSutraSpecTempConc_Node <> nil then
    begin
      FSutraSpecTempConc_Node.StateIndex := Ord(CheckState)+1;
    end;
  end
  else if Sender = frameSutraFluidFlux then
  begin
    if FSutraSpecTempConc_Node <> nil then
    begin
      FSutraFluidFlux_Node.StateIndex := Ord(CheckState)+1;
    end;
  end
  else if Sender = frameSutraMassEnergyFlux then
  begin
    if FSutraMassEnergyFlux_Node <> nil then
    begin
      FSutraMassEnergyFlux_Node.StateIndex := Ord(CheckState)+1;
    end;
  end
  else if Sender = frameSutraLake then
  begin
    if FSutraLake_Node <> nil then
    begin
      FSutraLake_Node.StateIndex := Ord(CheckState)+1;
    end;
  end
end;

procedure TfrmScreenObjectProperties.GetData(const AScreenObject:
  TScreenObject);
var
  List: TList;
  NumberOfColumns: Integer;
  ColIndex: Integer;
  First: Boolean;
  ACaption: string;
  Index: Integer;
  ValueItem: TValueArrayItem;
  TreeViewFilled: boolean;
  SelectCell: TGridRect;
  ObjectLabel: TObjectLabel;
  ObjectVertexLabel: TObjectVertexLabel;
begin
  // This line should always be the first line.
  IsLoaded := False;
  Initialize;
  tvDataSets.Items.Clear;

  rgElevationCount.Enabled := frmGoPhast.ModelSelection <> msFootPrint;
  if not rgElevationCount.Enabled  then
  begin
    edZ.Enabled := False;
    edHighZ.Enabled := False;
    edLowZ.Enabled := False;
    btnZ.Enabled := False;
    btnHighZ.Enabled := False;
    btnLowZ.Enabled := False;
  end;

  HideGLViewersWithMicrosoftOpenGL;

  memoComments.Enabled := True;
  SetModflowBoundaryColCount;

//  clbChildModels.Handle;

  frameSutraSpecifiedPressure.BoundaryType := sbtSpecPress;
  frameSutraSpecTempConc.BoundaryType := sbtSpecConcTemp;
  frameSutraFluidFlux.BoundaryType := sbtFluidSource;
  frameSutraMassEnergyFlux.BoundaryType := sbtMassEnergySource;

  // Ensure that the check boxes in frameSTOB.rdgObservationGroups
  // are visible.
  SelectCell.Top := 1;
  SelectCell.Bottom := 1;
  SelectCell.Left := 2;
  SelectCell.Right := 2;
  frameSTOB.rdgObservationGroups.Selection := SelectCell;

  // This will cause TCustomRadioGroup.UpdateButtons to be called.
  rgBoundaryType.WordWrap := not rgBoundaryType.WordWrap;
  rgBoundaryType.WordWrap := not rgBoundaryType.WordWrap;

  FillChildModelList;
  FCurrentEdit := nil;

  case AScreenObject.ViewDirection of
    vdTop: rgElevationCount.Caption := StrNumberOfZFormulas;
    vdFront: rgElevationCount.Caption := StrNumberOfYFormulas;
    vdSide: rgElevationCount.Caption := StrNumberOfXFormulas;
    else Assert(False);
  end;

  FCanFillTreeView := False;
  tabImportedData.TabVisible := True;
  memoComments.Text := AScreenObject.Comment;

  FCaptionFontChanged := False;
  FVertexCaptionFontChanged := False;
  ObjectLabel := AScreenObject.ObjectLabel;
  cbCaptionVisible.AllowGrayed := False;
  cbCaptionVisible.Checked := ObjectLabel.Visible;
  rdeCaptionX.IntegerValue := ObjectLabel.OffSet.X;
  rdeCaptionY.IntegerValue := ObjectLabel.OffSet.Y;
  memoCaption.Lines.Text := ObjectLabel.Caption;
  FCaptionTextChanged := False;

  ObjectVertexLabel := AScreenObject.ObjectVertexLabel;
  cbVertexLabelVisible.AllowGrayed := False;
  cbVertexLabelVisible.Checked := ObjectVertexLabel.Visible;
  rdeVertexXOffset.IntegerValue := ObjectVertexLabel.OffSet.X;
  rdeVertexYOffset.IntegerValue := ObjectVertexLabel.OffSet.Y;


  SetCheckBoxCaptions;
  frameModpathParticles.InitializeFrame;
  edObjectOrder.Text := IntToStr(
    frmGoPhast.PhastModel.IndexOfScreenObject(AScreenObject)+1);

  frameSwrReach.InitializeFrame;

  InitializeGridObjects;
  seBoundaryTimes.Value := 1;
  rgEvaluatedAt.Enabled := frmGoPhast.PhastModel.ModelSelection in
    [msPhast, msSutra22, msSutra30];

  rgEvaluatedAt.Items[Ord(eaBlocks)] := EvalAtToString(eaBlocks,
    frmGoPhast.PhastModel.ModelSelection, True, True);
  rgEvaluatedAt.Items[Ord(eaNodes)] := EvalAtToString(eaNodes,
    frmGoPhast.PhastModel.ModelSelection, True, True);

  FPriorModelUpToDate := frmGoPhast.PhastModel.UpToDate;
  FScreenObjectList := nil;
  InitializeModflowBoundaryFrames(AScreenObject);
  AddGisFunctionsToAllParsers;

  InitializeControls(AScreenObject);

//  GetGlobalVariables;
  memoNames.Visible := False;
  lblNames.Visible := False;
  FScreenObject := AScreenObject;
  memoNames.Lines.Add(AScreenObject.Name);

  FViewDirection := FScreenObject.ViewDirection;
  if FViewDirection <> vdTop then
  begin
    rgBoundaryType.Handle;
    rgBoundaryType.Buttons[Ord(btRiver)].Enabled := False;
    rgBoundaryType.Buttons[Ord(btWell)].Enabled := False;
//    rgBoundaryType.Controls[Ord(btRiver)].Enabled := False;
//    rgBoundaryType.Controls[Ord(btWell)].Enabled := False;
  end;

  if AScreenObject.Count > 1 then
  begin
    rgBoundaryType.Handle;
    rgBoundaryType.Buttons[Ord(btWell)].Enabled := False;
//    rgBoundaryType.Controls[Ord(btWell)].Enabled := False;
  end;
  if AScreenObject.Closed or (AScreenObject.Count <= 1) then
  begin
    rgBoundaryType.Handle;
    rgBoundaryType.Buttons[Ord(btRiver)].Enabled := False;
//    rgBoundaryType.Controls[Ord(btRiver)].Enabled := False;
  end;

  rgEvaluatedAt.ItemIndex := Ord(AScreenObject.EvaluatedAt);

  SetZLabelCaptions;

  cbLock.Checked := FScreenObject.PositionLocked;
  cbLock.AllowGrayed := False;

  // Display the name of the screen object.
  EdName.Text := FScreenObject.Name;
  GetColorDataForSingleObject;
  GetAssignmentMethodForSingleObject;
  cbDuplicatesAllowed.Checked := FScreenObject.DuplicatesAllowed;
  cbDuplicatesAllowed.AllowGrayed := False;


  // Set AllowGrayed.
  MultipleScreenObjects := False;

  GetScreenObjectVerticies;

  cbFillColor.Enabled := FScreenObject.Closed or (FScreenObject.ElevationCount =
    ecTwo);

  cbEnclosedCells.Enabled := FScreenObject.Closed;
  rdeMinimumCellFraction.Enabled := (FScreenObject.ScreenObjectLength > 0)
    and (cbIntersectedCells.State <> cbUnchecked);


  FSetCellsColor := False;


  List := TList.Create;
  TreeViewFilled := False;
  try
    List.Add(AScreenObject);
    CreateDataSetEdits(List);
    GetGages(List);
    GetModpathParticles(List);

    GetDataSetsForSingleObject;
    GetPhastBoundariesForSingleObject;

    EnableOK_Button;
    SetElevationDataForSingleObject;
    SetGridCellSizeDataForSingleObject;

    if (FNewProperties = nil) or (FNewProperties.Count <= 1) then
    begin
      FCanFillTreeView := True;
      FillDataSetsTreeView(List);
      TreeViewFilled := True;
    end;

  finally
    List.Free;
  end;

  EmphasizeValueChoices;

  frameScreenObjectSFR.Initialize;
  if FNewProperties = nil then
  begin
    FNewProperties := TScreenObjectEditCollection.Create;
    FNewProperties.OwnScreenObject := True;
  end;
  List := TList.Create;
  try
    List.Add(AScreenObject);
    if FNewProperties.Count = 0 then
    begin
      FillPropertyCollection(FNewProperties, List);
    end;
    GetModflowBoundaries(List);
    GetFootprintWells;
  finally
    List.Free;
  end;

  if frmGoPhast.PhastModel.ModelSelection in SutraSelection then
  begin
    frameSutraObservations.OnActivate := ActivateSutraFeature;
    frameSutraObservations.GetData(FNewProperties);

    frameSutraSpecifiedPressure.OnActivate := ActivateSutraFeature;
    frameSutraSpecifiedPressure.GetData(FNewProperties);

    frameSutraSpecTempConc.OnActivate := ActivateSutraFeature;
    frameSutraSpecTempConc.GetData(FNewProperties);

    frameSutraFluidFlux.OnActivate := ActivateSutraFeature;
    frameSutraFluidFlux.GetData(FNewProperties);

    frameSutraMassEnergyFlux.OnActivate := ActivateSutraFeature;
    frameSutraMassEnergyFlux.GetData(FNewProperties);

    frameSutraLake.OnActivate := ActivateSutraFeature;
    frameSutraLake.GetData(FNewProperties);

    SetSelectedSutraBoundaryNode;
  end;

  SetDisabledElevationFormulas(AScreenObject);

  // The first condition is because TStringGrid can't handle too many rows.
  if (FScreenObject.Count < 1048560)
    and ((AScreenObject.ImportedSectionElevations.Count > 0)
    or (AScreenObject.ImportedHigherSectionElevations.Count > 0)
    or (AScreenObject.ImportedLowerSectionElevations.Count > 0)
    or (AScreenObject.ImportedValues.Count > 0)) then
  begin
    tabImportedData.TabVisible := True;
    NumberOfColumns := 1;
    if AScreenObject.ImportedSectionElevations.Count > 0 then
    begin
      Inc(NumberOfColumns);
    end;
    if AScreenObject.ImportedHigherSectionElevations.Count > 0 then
    begin
      Inc(NumberOfColumns);
    end;
    if AScreenObject.ImportedLowerSectionElevations.Count > 0 then
    begin
      Inc(NumberOfColumns);
    end;
    NumberOfColumns := NumberOfColumns + AScreenObject.ImportedValues.Count;
    rdgImportedData.ColCount := NumberOfColumns;
    for ColIndex := 0 to rdgImportedData.ColCount - 1 do
    begin
      rdgImportedData.Columns[ColIndex].AutoAdjustColWidths:= True;
      rdgImportedData.Columns[ColIndex].WordWrapCaptions := True;
    end;
    rdgImportedData.Cells[0,0] := 'Section';
    ColIndex := 0;
    First := True;

    rdgImportedData.BeginUpdate;
    try
      if AScreenObject.ImportedSectionElevations.Count > 0 then
      begin
        ACaption := GetCoordinateCaption(AScreenObject);
        AssignImportedValuesColumn(First, ColIndex,
          AScreenObject.ImportedSectionElevations, ACaption);
      end;
      if AScreenObject.ImportedHigherSectionElevations.Count > 0 then
      begin
        ACaption := GetHigherCoordinateCaption(AScreenObject);
        AssignImportedValuesColumn(First, ColIndex,
          AScreenObject.ImportedHigherSectionElevations, ACaption);
      end;
      if AScreenObject.ImportedLowerSectionElevations.Count > 0 then
      begin
        ACaption := GetLowerCoordinateCaption(AScreenObject);
        AssignImportedValuesColumn(First, ColIndex,
          AScreenObject.ImportedLowerSectionElevations, ACaption);
      end;
      for Index := 0 to AScreenObject.ImportedValues.Count - 1 do
      begin
        ValueItem := AScreenObject.ImportedValues.Items[Index];
        AssignImportedValuesColumn(First, ColIndex,
          ValueItem.Values, ValueItem.Name);
      end;
    finally
      rdgImportedData.EndUpdate;
    end;
  end
  else
  begin
    tabImportedData.TabVisible := False;
  end;
  GetVertexValues;

  frameIface.IFACE := AScreenObject.IFACE;

  edObjectLength.Text := FloatToStr(AScreenObject.ScreenObjectLength);
  if AScreenObject.SectionCount > 1000 then
  begin
    edObjectArea.Text := '?';
  end
  else
  begin
    try
      edObjectArea.Text := FloatToStr(AScreenObject.ScreenObjectArea);
    except on EExternal do
      // EStackOverflow is caught here.
      edObjectArea.Text := '?';
    end;
  end;
  jvplObjectInfo.ActivePage := jvspSingleObject;
  FPriorElevationCount := rgElevationCount.ItemIndex;

  GetUsedLgrModels(AScreenObject);
  EnableWellTabfile;

  // Set Loaded to True.  FLoaded is used in event handlers to decide
  // whether or not anything should be done.
  IsLoaded := True;
  UpdateSubComponents(self);
  if TreeViewFilled then
  begin
    UpdateCurrentEdit;
    tvDataSetsChange(nil, nil);
  end;
  SetDefaultCellSize;
end;

procedure TfrmScreenObjectProperties.GetChdBoundary(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectParam;
  Parameter: TParameterType;
begin
  if not frmGoPhast.PhastModel.ChdIsSelected then
  begin
    Exit;
  end;
  Frame := frameChdParam;
  Parameter := ptCHD;
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FCHD_Node);
end;

procedure TfrmScreenObjectProperties.btnOKClick(Sender: TObject);
var
  Columns: array of Integer;
  Orientation: TDataSetOrientation;
  DataGrid: TRbwDataGrid4;
  EvaluatedAt: TEvaluatedAt;
  NewValue: string;
  RowIndex, ColIndex, Col, Row: integer;
  DataSet: TDataArray;
  CanSelect: boolean;
  ShowError: boolean;
  Edit: TScreenObjectDataEdit;
  ListOfScreenObjects: TList;
  BoundaryNodeList: TList;
  BoundaryNodeIndex: integer;
  ANode: TJvPageIndexNode;
begin
  inherited;
  frmGoPhast.BeginSuppressDrawing;
  try
    ShowError := False;
      // Warn the user about potential problems.
      // and apply the changes to the @link(TScreenObject) or @link(TScreenObject)s.
    if (cbEnclosedCells.State = cbUnchecked)
      and (cbIntersectedCells.State = cbUnchecked)
      and (cbInterpolation.State = cbUnchecked)
      and not rdeGridCellSize.Enabled then
    begin
      ShowError := True;
    end;
    if not ShowError then
    begin
      if (cbEnclosedCells.State = cbUnchecked)
        and (cbIntersectedCells.State = cbUnchecked)
        and (cbInterpolation.State = cbUnchecked) then
      begin
        ShowError := DataSetsSpecified;
      end;
    end;
    if ShowError then
    begin
      pageMain.ActivePageIndex := 0;
      if cbEnclosedCells.Enabled then
      begin
        cbEnclosedCells.SetFocus;
      end
      else
      begin
        cbIntersectedCells.SetFocus;
      end;

      if MessageDlg(StrObjEditing, mtWarning, [mbYes, mbNo], 0, mbNo) = mrNo then
      begin
        Exit;
      end;
    end;

    if cbInterpolation.Checked and not cbIntersectedCells.Checked
      and not cbEnclosedCells.Checked then
    begin
      for RowIndex := 0 to FDataEdits.Count -1 do
      begin
        Edit := FDataEdits[RowIndex];
        // determine if the cell can be selected.
        CanSelect := True;
        // prevent the grid from validating the formula in a grid cell while
        // the grid cell is being drawn.

        ListOfScreenObjects := TList.Create;
        try
          if FScreenObject <> nil then
          begin
            ListOfScreenObjects.Add(FScreenObject)
          end;
          if FScreenObject <> nil then
          begin
            CheckIfDataSetCanBeEdited(CanSelect, Edit, ListOfScreenObjects);
          end
          else
          begin
            CheckIfDataSetCanBeEdited(CanSelect, Edit, FScreenObjectList);
          end;
        finally
          ListOfScreenObjects.Free;
        end;

        if CanSelect and (Edit.Used <> cbUnchecked)  then
        begin
          DataSet := Edit.DataArray;
          if DataSet.TwoDInterpolator = nil then
          begin
            Beep;
            if MessageDlg(Format(StrYouAreAttemptingT, [DataSet.Name]),
              mtWarning, [mbYes, mbNo], 0, mbNo) = mrNo then
            begin
              Exit;
            end
            else
            begin
              break;
            end;
          end;
        end;
      end;
    end;

    if (cbIntersectedCells.State = cbUnchecked)
      and (cbEnclosedCells.State = cbUnchecked) then
    begin
//      ShowError :=
//        ((FDRN_Node <> nil) and (FDRN_Node.StateIndex <> 1));
      BoundaryNodeList := TList.Create;
      try
        BoundaryNodeList.Add(FCHD_Node);
        BoundaryNodeList.Add(FGHB_Node);
        BoundaryNodeList.Add(FWEL_Node);
        BoundaryNodeList.Add(FRIV_Node);
        BoundaryNodeList.Add(FDRN_Node);
        BoundaryNodeList.Add(FDRT_Node);
        BoundaryNodeList.Add(FRCH_Node);
        BoundaryNodeList.Add(FEVT_Node);
        BoundaryNodeList.Add(FETS_Node);
        BoundaryNodeList.Add(FRES_Node);
        BoundaryNodeList.Add(FLAK_Node);
        BoundaryNodeList.Add(FMNW1_Node);
        BoundaryNodeList.Add(FMNW2_Node);
        BoundaryNodeList.Add(FSFR_Node);
        BoundaryNodeList.Add(FSTR_Node);
        BoundaryNodeList.Add(FUZF_Node);
        BoundaryNodeList.Add(FChob_Node);
        BoundaryNodeList.Add(FDrob_Node);
        BoundaryNodeList.Add(FGbob_Node);
        BoundaryNodeList.Add(FRvob_Node);
        BoundaryNodeList.Add(FStob_Node);
        BoundaryNodeList.Add(FGage_Node);
        BoundaryNodeList.Add(FSWiObs_Node);
        BoundaryNodeList.Add(FMt3dmsSsm_Node);
        BoundaryNodeList.Add(FMt3dmsTobConc_Node);
        BoundaryNodeList.Add(FMt3dmsTobFlux_Node);
        BoundaryNodeList.Add(FHOB_Node);
        BoundaryNodeList.Add(FHFB_Node);
        BoundaryNodeList.Add(FHydmod_Node);
        BoundaryNodeList.Add(FFhbFlow_Node);
        BoundaryNodeList.Add(FFhbHead_Node);
//        BoundaryNodeList.Add(FFmpFarm_Node);
        BoundaryNodeList.Add(FFarmID_Node);
        BoundaryNodeList.Add(FFarmWell_Node);
        BoundaryNodeList.Add(FFarmPrecip_Node);
        BoundaryNodeList.Add(FFarmRevEvap_Node);
        BoundaryNodeList.Add(FFarmCropID_Node);
        BoundaryNodeList.Add(FCfpPipe_Node);
        BoundaryNodeList.Add(FCfpFixedHead_Node);
        BoundaryNodeList.Add(FCRCH_Node);
        BoundaryNodeList.Add(FSWR_Reach_Node);
        BoundaryNodeList.Add(FSWR_Rain_Node);
        BoundaryNodeList.Add(FSWR_Evap_Node);
        BoundaryNodeList.Add(FSWR_LatInflow_Node);
        BoundaryNodeList.Add(FSWR_Stage_Node);
        BoundaryNodeList.Add(FSWR_DirectRunoff_Node);
        BoundaryNodeList.Add(FRipNode);


        BoundaryNodeList.Pack;
        ShowError := False;
        for BoundaryNodeIndex := 0 to BoundaryNodeList.Count - 1 do
        begin
          ANode := BoundaryNodeList[BoundaryNodeIndex];
          if ANode.StateIndex <> 1 then
          begin
            ShowError := True;
            break;
          end;
        end;
      finally
        BoundaryNodeList.Free;
      end;
      if ShowError then
      begin
        if MessageDlg(StrInvalidMethod, mtWarning,
          [mbYes, mbNo], 0, mbNo) = mrNo then
        begin
          Exit;
        end;
      end;
    end;

    if rgEvaluatedAt.ItemIndex = 1 then
    begin
      DataGrid := nil;
      if rgBoundaryType.ItemIndex >= 0 then
      begin
        case rgBoundaryType.ItemIndex of
          Ord(btNone):
            begin
              DataGrid := nil;
            end;
          Ord(btSpecifiedHead):
            begin
              DataGrid := dgSpecifiedHead;
              SetLength(Columns, 2);
              Columns[0] := Ord(ibcBoundaryValue);
              Columns[1] := Ord(ibcSolution);
            end;
          Ord(btFlux):
            begin
              DataGrid := dgBoundaryFlux;
              SetLength(Columns, 2);
              Columns[0] := Ord(ibcBoundaryValue);
              Columns[1] := Ord(ibcSolution);
            end;
          Ord(btLeaky):
            begin
              DataGrid := dgBoundaryLeaky;
              SetLength(Columns, 2);
              Columns[0] := Ord(ibcBoundaryValue);
              Columns[1] := Ord(ibcSolution);
            end;
          Ord(btRiver):
            begin
              DataGrid := dgBoundaryRiver;
              SetLength(Columns, 2);
              Columns[0] := Ord(nicBoundaryValue);
              Columns[1] := Ord(nicSolution);
            end;
          Ord(btWell):
            begin
              DataGrid := dgWell;
              SetLength(Columns, 2);
              Columns[0] := Ord(nicBoundaryValue);
              Columns[1] := Ord(nicSolution);
            end;
        else
          Assert(False);
        end;
      end;
      if DataGrid <> nil then
      begin
        Col := 0;
        Row := 0;
        try
          if (DataGrid = dgSpecifiedHead) or
            (DataGrid = dgBoundaryFlux) or (DataGrid = dgBoundaryLeaky) then
          begin
            Orientation := dso3D;
          end
          else if (DataGrid = dgBoundaryRiver) or (DataGrid = dgWell) then
          begin
            Orientation := dsoTop;
          end
          else
          begin
            Assert(False);
            Orientation := dso3D;
          end;
          // All the PHAST boundary conditions are evaluated at nodes.
          EvaluatedAt := eaNodes;
          for RowIndex := 1 to DataGrid.RowCount - 1 do
          begin
            Row := RowIndex;
            for ColIndex := 0 to Length(Columns) - 1 do
            begin
              Col := Columns[ColIndex];
              NewValue := DataGrid.Cells[Col, RowIndex];
              if NewValue <> '' then
              begin
                CreateBoundaryFormula(DataGrid, Col, RowIndex, NewValue,
                  Orientation, EvaluatedAt);
              end;
            end;
          end;
        except on E: Exception do
          begin
            Beep;
            MessageDlg(Format(StrErrorIn0sRow,
              [rgBoundaryType.Items[rgBoundaryType.ItemIndex],
              Row + 1, Col, E.Message]), mtError,[mbOK], 0);
            Exit;
          end;
        end;
      end;
    end;

    SetSelectedName;
    // apply the changes to the screen object or screen objects.
    Screen.Cursor := crHourGlass;
    try
      Enabled := False;
      if FScreenObject <> nil then
      begin
        SetData;
      end
      else
      begin
        Assert(FScreenObjectList <> nil);
        SetMultipleScreenObjectData;
      end;
    finally
      Application.ProcessMessages;
      ModalResult := mrOK;
      Enabled := True;
      Screen.Cursor := crDefault;
    end;
  finally
    frmGoPhast.EndSupressDrawing;
    frmGoPhast.frameTopView.ZoomBox.InvalidateImage32;
    frmGoPhast.frameFrontView.ZoomBox.InvalidateImage32;
    frmGoPhast.frameSideView.ZoomBox.InvalidateImage32;
  end;
end;

procedure TfrmScreenObjectProperties.btnVertexFontClick(Sender: TObject);
var
  AScreenObject: TScreenObject;
begin
  inherited;
  if FScreenObject <> nil then
  begin
    dlgFontCaption.Font := FScreenObject.ObjectVertexLabel.Font;
  end
  else
  begin
    AScreenObject := FScreenObjectList[0];
    dlgFontCaption.Font := AScreenObject.ObjectVertexLabel.Font;
  end;
  if dlgFontCaption.Execute then
  begin
    FVertexCaptionFont.Free;
    FVertexCaptionFont := TFont.Create;
    FVertexCaptionFont.Assign(dlgFontCaption.Font);
    FVertexCaptionFontChanged := True;
  end;
end;

procedure TfrmScreenObjectProperties.btnCopyVerticesClick(Sender: TObject);
begin
  inherited;
  dgVerticies.Options := dgVerticies.Options - [goEditing];
  dgVerticies.SelectAll;
  dgVerticies.CopySelectedCellsToClipboard;
  dgVerticies.ClearSelection;
//  ActiveControl := dgVerticies;
end;

procedure TfrmScreenObjectProperties.GetAvailableTimes;
var
  Index: integer;
  Frame: TframeScreenObjectNoParam;
begin
  for Index := 0 to ComponentCount - 1 do
  begin
    if Components[Index] is TframeScreenObjectNoParam then
    begin
      Frame := TframeScreenObjectParam(Components[Index]);
      Frame.GetStartTimes(0);
      Frame.GetEndTimes(1);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.SetDefaultCellSize;
var
  ZoomBox: TQRbwZoomBox2;
  XWidth: double;
  YWidth: double;
  DefaultValue: Extended;
begin
  if not rdeGridCellSize.Enabled then
  begin
    ZoomBox:= nil;
    case FNewProperties[0].ScreenObject.ViewDirection of
      vdTop: ZoomBox := frmGoPhast.frameTopView.ZoomBox;
      vdFront: ZoomBox := frmGoPhast.frameFrontView.ZoomBox;
      vdside: ZoomBox := frmGoPhast.frameSideView.ZoomBox;
      else Assert(False);
    end;

    XWidth := Abs(ZoomBox.X(ZoomBox.Width) - ZoomBox.X(0));
    YWidth := Abs(ZoomBox.Y(ZoomBox.Height) - ZoomBox.Y(0));

    if (frmGoPhast.ModelSelection in SutraSelection)
      and (frmGoPhast.PhastModel.SutraMesh.MeshType = mtProfile) then
    begin
      YWidth := YWidth * frmGoPhast.PhastModel.Exaggeration;
    end;

    DefaultValue := Min(XWidth,YWidth)/20;
    if DefaultValue > 0 then
    begin
      DefaultValue := Round(log10(DefaultValue));
      DefaultValue := Power(10,DefaultValue);
      rdeGridCellSize.Text := FloatToStr(DefaultValue);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetAvailableParameters;
var
  Index: integer;
  Param: TModflowParameter;
begin
  SetModflowBoundaryColCount;

  frameChdParam.clbParameters.Items.Clear;
  frameGhbParam.clbParameters.Items.Clear;
  frameWellParam.clbParameters.Items.Clear;
  frameRivParam.clbParameters.Items.Clear;
  frameDrnParam.clbParameters.Items.Clear;
  frameDrtParam.clbParameters.Items.Clear;
  frameRchParam.clbParameters.Items.Clear;
  frameEvtParam.clbParameters.Items.Clear;
  frameEtsParam.clbParameters.Items.Clear;
  frameFarmWell.clbParameters.Items.Clear;

  frameChdParam.clbParameters.Items.Add(StrNoParameter);
  frameGhbParam.clbParameters.Items.Add(StrNoParameter);
  frameWellParam.clbParameters.Items.Add(StrNoParameter);
  frameFarmWell.clbParameters.Items.Add(StrNoParameter);
  frameRivParam.clbParameters.Items.Add(StrNoParameter);
  frameDrnParam.clbParameters.Items.Add(StrNoParameter);
  frameDrtParam.clbParameters.Items.Add(StrNoParameter);
  frameRchParam.clbParameters.Items.Add(StrNoParameter);
  frameEvtParam.clbParameters.Items.Add(StrNoParameter);
  frameEtsParam.clbParameters.Items.Add(StrNoParameter);

  for Index := 0 to frmGoPhast.PhastModel.ModflowTransientParameters.Count - 1 do
  begin
    Param := frmGoPhast.PhastModel.ModflowTransientParameters[Index];
    case Param.ParameterType of
      ptUndefined: Assert(False);
      ptLPF_HK..ptLPF_VKCB: Assert(False);
      ptCHD:
        begin
          frameChdParam.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      ptGHB:
        begin
          frameGhbParam.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      ptQ:
        begin
          frameWellParam.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      ptRIV:
        begin
          frameRivParam.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      ptDRN:
        begin
          frameDrnParam.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      ptDRT:
        begin
          frameDrtParam.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      ptRCH:
        begin
          frameRchParam.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      ptEVT:
        begin
          frameEvtParam.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      ptETS:
        begin
          frameEtsParam.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      ptSFR, ptSTR:
        begin
          // do nothing
        end;
      ptQMAX:
        begin
          frameFarmWell.clbParameters.Items.
            AddObject(Param.ParameterName, Param);
        end;
      else Assert(False);
    end;
  end;

  if frameChdParam.clbParameters.Items.Count = 1 then
  begin
    frameChdParam.clbParameters.Items.Clear;
  end;
  if frameGhbParam.clbParameters.Items.Count = 1 then
  begin
    frameGhbParam.clbParameters.Items.Clear;
  end;
  if frameWellParam.clbParameters.Items.Count = 1 then
  begin
    frameWellParam.clbParameters.Items.Clear;
  end;
  if frameFarmWell.clbParameters.Items.Count = 1 then
  begin
    frameFarmWell.clbParameters.Items.Clear;
  end;
  if frameRivParam.clbParameters.Items.Count = 1 then
  begin
    frameRivParam.clbParameters.Items.Clear;
  end;
  if frameDrnParam.clbParameters.Items.Count = 1 then
  begin
    frameDrnParam.clbParameters.Items.Clear;
  end;
  if frameDrtParam.clbParameters.Items.Count = 1 then
  begin
    frameDrtParam.clbParameters.Items.Clear;
  end;
  if frameRchParam.clbParameters.Items.Count = 1 then
  begin
    frameRchParam.clbParameters.Items.Clear;
  end;
  if frameEvtParam.clbParameters.Items.Count = 1 then
  begin
    frameEvtParam.clbParameters.Items.Clear;
  end;
  if frameEtsParam.clbParameters.Items.Count = 1 then
  begin
    frameEtsParam.clbParameters.Items.Clear;
  end;

end;

procedure TfrmScreenObjectProperties.SetIsLoaded(const Value: boolean);
var
  Index: integer;
  Component: TComponent;
begin
  FIsLoaded := Value;
  for Index := 0 to ComponentCount - 1 do
  begin
    Component := Components[Index];
    if Component is TframeScreenObject then
    begin
      TframeScreenObject(Component).FrameLoaded := Value;
    end;
  end;
  frameSwrReach.frameSwr.FrameLoaded := Value;
end;

procedure TfrmScreenObjectProperties.Mnw1Changed(Sender: TObject);
begin
  if (FMNW1_Node <> nil) and (FMNW1_Node.StateIndex <> 3) then
  begin
    FMNW1_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.Mnw2Changed(Sender: TObject);
begin
  if (FMNW2_Node <> nil) and (FMNW2_Node.StateIndex <> 3) then
  begin
    FMNW2_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.FhbHeadChanged(Sender: TObject);
begin
  if (FFhbHead_Node <> nil) and (FFhbHead_Node.StateIndex <> 3) then
  begin
    FFhbHead_Node.StateIndex := 2;
  end;
end;

//procedure TfrmScreenObjectProperties.FarmChanged(Sender: TObject);
//begin
//  if (FFmpFarm_Node <> nil) and (FFmpFarm_Node.StateIndex <> 3) then
//  begin
//    FFmpFarm_Node.StateIndex := 2;
//  end;
//end;

procedure TfrmScreenObjectProperties.FarmPrecipChanged(Sender: TObject);
begin
  if (FFarmPrecip_Node <> nil) and (FFarmPrecip_Node.StateIndex <> 3) then
  begin
    FFarmPrecip_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.FarmRefEvapChanged(Sender: TObject);
begin
  if (FFarmRevEvap_Node <> nil) and (FFarmRevEvap_Node.StateIndex <> 3) then
  begin
    FFarmRevEvap_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.FarmCropIDChanged(Sender: TObject);
begin
  if (FFarmCropID_Node <> nil) and (FFarmCropID_Node.StateIndex <> 3) then
  begin
    FFarmCropID_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.FarmIDChanged(Sender: TObject);
begin
  if (FFarmID_Node <> nil) and (FFarmID_Node.StateIndex <> 3) then
  begin
    FFarmID_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.CfpPipesChanged(Sender: TObject);
begin
  if (FCfpPipe_Node <> nil) and (FCfpPipe_Node.StateIndex <> 3) then
  begin
    FCfpPipe_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.CfpFixedHeadsChanged(Sender: TObject);
begin
  if (FCfpFixedHead_Node <> nil) and (FCfpFixedHead_Node.StateIndex <> 3) then
  begin
    FCfpFixedHead_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.RipChanged(Sender: TObject);
begin
  if (FRipNode <> nil) and (FRipNode.StateIndex <> 3) then
  begin
    FRipNode.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.FhbFlowChanged(Sender: TObject);
begin
  if (FFhbFlow_Node <> nil) and (FFhbFlow_Node.StateIndex <> 3) then
  begin
    FFhbFlow_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.SetMultipleScreenObjectData;
var
  List: TList;
  index: Integer;
begin
  UpdateScreenObjectData;

  SetFrameData;

  List := TList.Create;
  try
    for index := 0 to FNewProperties.Count - 1 do
    begin
      List.Add(FNewProperties[index].ScreenObject)
    end;
    SetObjectCaption(List);
  finally
    List.Free;
  end;

  FUndoSetScreenObjectProperties.Free;
  FUndoSetScreenObjectProperties :=
    TUndoSetScreenObjectProperties.Create(FScreenObjectList,
    FNewProperties, FOldProperties, FChildModelsScreenObjects);
  // SetMultipleScreenObjectData is called when the user press the OK button
  // after editing the properties of one or more screen objects.
  // It set up an TUndoSetScreenObjectProperties based on the data that the
  // user has changed.  @SeeAlso(SetData)
  FUndoSetScreenObjectProperties.FSetCellsColor := FSetCellsColor;

  if FUndoSetScreenObjectProperties <> nil then
  begin
    SetGages(FScreenObjectList);
    SetAllFluxObservations(FScreenObjectList);
    FUndoSetScreenObjectProperties.UpdateObservations;
    frmGoPhast.UndoStack.Submit(FUndoSetScreenObjectProperties);
    FUndoSetScreenObjectProperties := nil;
  end;

end;

procedure TfrmScreenObjectProperties.SetData;
var
  List: TList;
begin
  // set the data for a single screen object when it is first created.
  // See SetMultipleScreenObjectData if there is more than one screen object.

  if FSetCellsColor then
  begin
    frmGoPhast.PhastGrid.NeedToRecalculateCellColors;
    frmGoPhast.ModflowGrid.NeedToRecalculateCellColors;
  end;

  if FScreenObject.SetValuesOfEnclosedCells or
    FScreenObject.SetValuesOfIntersectedCells then
  begin
    frmGoPhast.PhastGrid.NeedToRecalculateCellColors;
    frmGoPhast.ModflowGrid.NeedToRecalculateCellColors;
  end;
  SetScreenObjectVerticies;

  FScreenObject.ClearDataSets;

  UpdateScreenObjectData;

  Assert(FNewProperties.Count = 1);

  SetFrameData;

  FScreenObject.Assign(FNewProperties.Items[0].ScreenObject);
  FScreenObject.Comment := memoComments.Text;

  List := TList.Create;
  try
    List.Add(FScreenObject);
    SetGages(List);
    SetAllFluxObservations(List);
    SetObjectCaption(List);
  finally
    List.Free;
  end;

  case FScreenObject.ViewDirection of
    vdTop:
      begin
        frmGoPhast.TopScreenObjectsChanged := True;
      end;
    vdFront:
      begin
        frmGoPhast.FrontScreenObjectsChanged := True;
      end;
    vdSide:
      begin
        frmGoPhast.SideScreenObjectsChanged := True;
      end;
  else
    Assert(False);
  end;
  frmGoPhast.timTimer.Enabled := False;
  frmGoPhast.timTimer.OnTimer := frmGoPhast.ReDrawAllViews;
  frmGoPhast.timTimer.Interval := 100;
  frmGoPhast.timTimer.Enabled := True;
end;

procedure TfrmScreenObjectProperties.cbLgrAllModelsClick(Sender: TObject);
var
  ItemIndex: Integer;
  Index: Integer;
begin
  inherited;
  if IsLoaded then
  begin
    cbLgrAllModels.AllowGrayed := False;
    for ItemIndex := 0 to FNewProperties.Count - 1 do
    begin
      FNewProperties[ItemIndex].ScreenObject.UsedModels.UsedWithAllModels
        := cbLgrAllModels.Checked;
    end;
    if cbLgrAllModels.Checked then
    begin
      for Index := 0 to clbLgrUsedModels.Items.Count - 1 do
      begin
        clbLgrUsedModels.Checked[Index] := True;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.cbLineColorClick(Sender: TObject);
var
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  inherited;
  btnLineColor.Enabled := cbLineColor.Checked;
  if IsLoaded then
  begin
    if cbLineColor.Checked and (shpLineColor.Brush.Color = clBlack) then
    begin
      btnColorClick(btnLineColor);
    end;
    DisableAllowGrayed(cbLineColor);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.ColorLine := cbLineColor.Checked;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.cbLockClick(Sender: TObject);
var
  Index: integer;
  Item: TScreenObjectEditItem;
begin
  inherited;
  if IsLoaded then
  begin
    DisableAllowGrayed(cbLock);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.PositionLocked := cbLock.Checked;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.cbFillColorClick(Sender: TObject);
var
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  inherited;
  btnFillColor.Enabled := cbFillColor.Checked and cbFillColor.Enabled;
  if IsLoaded then
  begin
    if cbFillColor.Checked and (shpFillColor.Brush.Color = clBlack) then
    begin
      btnColorClick(btnFillColor);
    end;
    DisableAllowGrayed(cbFillColor);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.FillScreenObject := cbFillColor.Checked;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.cbGageStandardClick(Sender: TObject);
begin
  inherited;
  (Sender as TCheckBox).AllowGrayed := False;
  SetGageNodeStateIndex;
end;

procedure TfrmScreenObjectProperties.cbCaptionVisibleClick(Sender: TObject);
begin
  inherited;
  cbCaptionVisible.AllowGrayed := False;
end;

procedure TfrmScreenObjectProperties.cbDuplicatesAllowedClick(Sender: TObject);
var
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  inherited;
  DisableAllowGrayed(cbDuplicatesAllowed);
  if IsLoaded then
  begin
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.DuplicatesAllowed := cbDuplicatesAllowed.Checked;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.cbEnclosedCellsClick(Sender: TObject);
var
  Index: integer;
  Item: TScreenObjectEditItem;
begin
  // Mark all used data sets as in need of updating when this
  // check box is checked.

  inherited;
  InvalidateAllDataSets;

  ShowOrHideTabs;
  EmphasizeValueChoices;
  if IsLoaded then
  begin
    DisableAllowGrayed(cbEnclosedCells);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.SetValuesOfEnclosedCells := cbEnclosedCells.Checked;
    end;
  end;

end;

procedure TfrmScreenObjectProperties.cbIntersectedCellsClick(
  Sender: TObject);
var
  Index: integer;
  Item: TScreenObjectEditItem;
  LinePresent: Boolean;
begin
  inherited;

  InvalidateAllDataSets;

  ShowOrHideTabs;
  EmphasizeValueChoices;
  LinePresent := False;
  if IsLoaded then
  begin
    DisableAllowGrayed(cbIntersectedCells);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.SetValuesOfIntersectedCells
        := cbIntersectedCells.Checked;
      if not LinePresent then
      begin
        LinePresent := Item.ScreenObject.ScreenObjectLength > 0;
      end;
    end;
  end;
  rdeMinimumCellFraction.Enabled := LinePresent
    and (cbIntersectedCells.State <> cbUnchecked);
end;

procedure TfrmScreenObjectProperties.FillPropertyCollection(
  Collection: TScreenObjectEditCollection; List: TList);
var
  Index: Integer;
  ScreenObject: TScreenObject;
  Item: TScreenObjectEditItem;
  ScreenObjectClass: TScreenObjectClass;
  PriorCanInvalidateModel: boolean;
begin
  Collection.Clear;
  for Index := 0 to List.Count - 1 do
  begin
    ScreenObject := List[Index];
    Item := Collection.Add as TScreenObjectEditItem;
    ScreenObjectClass := TScreenObjectClass(ScreenObject.ClassType);
    Item.ScreenObject := ScreenObjectClass.Create(nil);
    Item.ScreenObject.CanInvalidateModel := False;
//    ScreenObject := List[Index];
    PriorCanInvalidateModel := ScreenObject.CanInvalidateModel;
    try
      ScreenObject.CanInvalidateModel := False;
      Item.ScreenObject.Assign(ScreenObject);
    finally
      ScreenObject.CanInvalidateModel := PriorCanInvalidateModel;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  RowIndex: Integer;
  ColIndex: Integer;
begin
  inherited;
  // release memory asociated with rdgImportedData.
  rdgImportedData.BeginUpdate;
  try
    for RowIndex := 1 to rdgImportedData.RowCount - 1 do
    begin
      for ColIndex := 1 to rdgImportedData.ColCount - 1 do
      begin
        rdgImportedData.Cells[ColIndex, RowIndex] := '';
      end;
    end;
    rdgImportedData.ColCount := 2;
    rdgImportedData.RowCount := 2;
  finally
    rdgImportedData.EndUpdate;
  end;
  if FNewProperties <> nil then
  begin
    FNewProperties.Clear;
  end;
  if FOldProperties <> nil then
  begin
    FOldProperties.Clear;
  end;
  FCurrentEdit := nil;
  FDataEdits.Clear;
end;

procedure TfrmScreenObjectProperties.FormCreate(Sender: TObject);
begin
  inherited;

  {$IFDEF Win64}
//      frameModpathParticles.GLSceneViewer1.Visible := False;
  {$ENDIF}

  reDataSetFormula.DoubleBuffered := False;
  frameMnw2.OnChange := Mnw2Changed;
  frameMnw1.OnChange := Mnw1Changed;
  frameFhbHead.OnChange := FhbHeadChanged;
  frameFhbFlow.OnChange := FhbFlowChanged;
//  frameScreenObjectFarm.OnChange := FarmChanged;
  frameFarmPrecip.OnChange := FarmPrecipChanged;
  frameFarmRefEvap.OnChange := FarmRefEvapChanged;
  frameFarmCropID.OnChange := FarmCropIDChanged;
  frameFarmID.OnChange := FarmIDChanged;
  frameCfpPipes.OnChange := CfpPipesChanged;
  frameCfpFixedHeads.OnChange := CfpFixedHeadsChanged;
  frameRIP.OnChange := RipChanged;

  frameDrnParam.ConductanceColumn := 1;
  frameDrtParam.ConductanceColumn := 1;
  frameGhbParam.ConductanceColumn := 1;
  frameRivParam.ConductanceColumn := 1;
  frameWellParam.ConductanceColumn := 0;
  frameFarmWell.ConductanceColumn := 0;

  FFormulaEdit := nil;
  FDataEdits := TObjectList.Create;

  frameRchParam.UnselectableColumnsIfParametersUsed := [2];
  frameEvtParam.UnselectableColumnsIfParametersUsed := [2];
  frameEtsParam.UnselectableColumnsIfParametersUsed := [2];

  frameScreenObjectSFR.OnEdited := UpdateSfrNode;
  frameScreenObjectSTR.OnEdited := UpdateStrNode;

  // See FInitialWidth for details.
  FInitialWidth := Width - pnlBoundaries.Width;

  rgEvaluatedAtClick(nil);
  seBoundaryTimes.MaxValue := MAXINT;
  seWellIntervals.MaxValue := MAXINT;

  FBoundaryPhastInterpolationList := TObjectList.Create;

  InitializeVertexGrid;

  pageMain.ActivePageIndex := 0;
  btnHelp.HelpKeyword := HelpKeyword;

  InitializePhastBoundaryControls;

  Constraints.MinWidth := Width;

  frameScreenObjectSFR.GetParser := GetSfrParser;

  frameScreenObjectSFR.OnButtonClick := frameResdgModflowBoundaryButtonClick;

  frameScreenObjectSFR.pnlSegmentUpstream.Height :=
    (frameScreenObjectSFR.pnlSegmentUpstream.Height +
    frameScreenObjectSFR.pnlSegmentDownstream.Height) div 2;

  frameHeadObservations.InitializeControls;
  frameMt3dmsTobConc.InitializeControls;

end;

procedure TfrmScreenObjectProperties.ResetSpecifiedHeadGrid;
begin
  // ResetSpecifiedHeadGrid resets the data displayed in dgSpecifiedHead.
  // It is called by GetDataForMultipleScreenObjects when two screen objects have
  // Specified Head boundaries that differ.
  pcPhastBoundaries.ActivePage := tabBoundarySpecifiedHead;
  seBoundaryTimes.Value := 1;
  dgSpecifiedHead.RowCount := 2;
  dgSpecifiedHead.Cells[Ord(ibcBoundaryValue), 1] := '';
  dgSpecifiedHead.Cells[Ord(ibcSolution), 1] := '';
  dgSpecifiedHead.Checked[Ord(ibcBoundaryInterpolate), 1] := False;
  dgSpecifiedHead.Checked[Ord(ibcSolutionInterpolate), 1] := False;
end;

procedure TfrmScreenObjectProperties.ResetFluxGrid;
begin
  // ResetFluxGrid resets the data displayed in dgBoundaryFlux.
  // It is called by GetDataForMultipleScreenObjects when two screen objects have Flux
  // boundaries that differ.
  pcPhastBoundaries.ActivePage := tabBoundaryFlux;
  seBoundaryTimes.Value := 1;
  dgBoundaryFlux.RowCount := 2;
  dgBoundaryFlux.Cells[Ord(ibcBoundaryValue), 1] := '';
  dgBoundaryFlux.Cells[Ord(ibcSolution), 1] := '';
  dgBoundaryFlux.Checked[Ord(ibcBoundaryInterpolate), 1] := False;
  dgBoundaryFlux.Checked[Ord(ibcSolutionInterpolate), 1] := False;
end;

procedure TfrmScreenObjectProperties.ResetLeakyGrid;
begin
  // ResetFluxGrid resets the data displayed in dgBoundaryLeaky.
  // It is called by GetDataForMultipleScreenObjects when two screen objects have Leaky
  // boundaries that differ.
  pcPhastBoundaries.ActivePage := tabBoundaryLeaky;
  seBoundaryTimes.Value := 1;
  dgBoundaryLeaky.RowCount := 2;
  dgBoundaryLeaky.Cells[Ord(ibcBoundaryValue), 1] := '';
  dgBoundaryLeaky.Cells[Ord(ibcSolution), 1] := '';
  dgBoundaryLeaky.Checked[Ord(ibcBoundaryInterpolate), 1] := False;
  dgBoundaryLeaky.Checked[Ord(ibcSolutionInterpolate), 1] := False;
end;

procedure TfrmScreenObjectProperties.ResetRiverGrid;
begin
  // ResetRiverGrid resets the data displayed in dgBoundaryRiver.
  // It is called by GetDataForMultipleScreenObjects when two screen objects have River
  // boundaries that differ.
  pcPhastBoundaries.ActivePage := tabBoundaryRiver;
  seBoundaryTimes.Value := 1;
  dgBoundaryRiver.RowCount := 2;
  dgBoundaryRiver.Cells[Ord(nicBoundaryValue), 1] := '';
  dgBoundaryRiver.Cells[Ord(nicSolution), 1] := '';
end;

procedure TfrmScreenObjectProperties.ResetWellGrid;
begin
  // ResetWellGrid resets the data displayed in dgWell.
  // It is called by GetDataForMultipleScreenObjects when two screen objects have
  // Well boundaries that differ.
  pcPhastBoundaries.ActivePage := tabBoundaryWell;
  seBoundaryTimes.Value := 1;
  dgWell.RowCount := 2;
  dgWell.Cells[Ord(nicBoundaryValue), 1] := '';
  dgWell.Cells[Ord(nicSolution), 1] := '';
end;

procedure TfrmScreenObjectProperties.ResetWellElevationGrid;
begin
  // ResetWellElevationGrid resets the data displayed in dgWellElevations.
  // It is called by GetDataForMultipleScreenObjects when two screen objects have
  // Well boundaries with well elevations that differ.
  seWellIntervals.Value := 1;
  dgWellElevations.Cells[Ord(wicFirst), 1] := '';
  dgWellElevations.Cells[Ord(wicSecond), 1] := '';
end;

procedure TfrmScreenObjectProperties.GetBoundaryTimes(const Boundaries:
  array of TCustomPhastBoundaryCollection; const Times: TRealList);
var
  BoundaryIndex: integer;
  timeIndex: integer;
  Boundary: TCustomPhastBoundaryCollection;
begin
  // GetBoundaryTimes fills Times with all the times in  Boundaries.
  Times.Clear;
  Times.AddUnique(0);
  for BoundaryIndex := 0 to Length(Boundaries) - 1 do
  begin
    Boundary := Boundaries[BoundaryIndex];
    for timeIndex := 0 to Boundary.Count - 1 do
    begin
      Times.AddUnique((Boundary.Items[timeIndex]
        as TCustomPhastBoundaryCondition).Time);
    end;
  end;
end;

function TfrmScreenObjectProperties.TimesIdentical(const Grid: TRbwDataGrid4;
  const UsedTimes: TRealList; const TimeCol: integer): boolean;
var
  Index: integer;
begin
  // TimesIdentical returns True if all the times recorded in Grid
  // in column TimeCol are identical to those in UsedTimes.
  result := True;
  if UsedTimes.Count + 1 <> Grid.RowCount then
  begin
    result := False;
  end;
  if result then
  begin
    for Index := 0 to UsedTimes.Count - 1 do
    begin
      if FloatToStr(UsedTimes[Index]) <> Grid.Cells[TimeCol, Index + 1] then
      begin
        result := False;
        Break;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.Initialize;
begin
  FCurrentEdit := nil;
  FSelectedDataArrayName := '';
  tvDataSets.Selected := nil;
  tvDataSetsChange(nil, nil);
end;

procedure TfrmScreenObjectProperties.tvDataSetsChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  if IsLoaded then
  begin
    UpdateCurrentEdit;
    if (tvDataSets.Selected <> nil) and (tvDataSets.Selected.Data <> nil) then
    begin
      lblDataSetFormula.Caption := Format(StrFormulaForSDat,
        [tvDataSets.Selected.Text]);
    end
    else
    begin
      lblDataSetFormula.Caption := StrFormula;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.tvDataSetsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Edit: TScreenObjectDataEdit;
begin
  inherited;
  if htOnStateIcon in tvDataSets.GetHitTestInfoAt(X, Y) then
  begin
    if (tvDataSets.Selected <> nil) and (tvDataSets.Selected.Data <> nil) then
    begin
      Edit := tvDataSets.Selected.Data;
      case Edit.Used of
        cbUnchecked: Edit.Used := cbChecked;
        cbChecked: Edit.Used := cbUnchecked;
        cbGrayed: Edit.Used := cbChecked;
      end;
      UpdateCurrentEdit;
      UpdateCurrentEdit;
      if (Edit.Used <> cbUnchecked) and (FCurrentEdit.Formula = '') then
      begin
        FCurrentEdit.Formula := GenerateNewDataSetFormula(FCurrentEdit.DataArray);
        UpdateCurrentEdit;
      end;
    end;
  end;
end;

function TfrmScreenObjectProperties.PhastBoundaryIsIdentical(const Grid:
  TRbwDataGrid4;
  const UsedTimes: TRealList; const Boundary: TCustomPhastBoundaryCollection;
  const ExpressionCol, PhastInterpolateCol: integer): boolean;
var
  Index: integer;
  Item: TCustomPhastBoundaryCondition;
  RealItem: TRealPhastBoundaryCondition;
  IntegerItem: TIntegerPhastBoundaryCondition;
  InterpValuesCollection: TInterpValuesCollection;
  InterpValuesItem: TInterpValuesItem;
  RowIndex: integer;
begin
  {BoundaryIsIdentical tests whether the boundary specified in Grid is
   identical to the one in Boundary.}
  result := True;
  for Index := 0 to Boundary.Count - 1 do
  begin
    Item := Boundary.Items[Index] as TCustomPhastBoundaryCondition;
    RowIndex := UsedTimes.IndexOf(Item.Time) + 1;
    if RowIndex <= 0 then
    begin
      result := false;
      Break;
    end;
    if (PhastInterpolateCol >= 0) and (Item.UsePHAST_Interpolation
      <> Grid.Checked[PhastInterpolateCol, RowIndex]) then
    begin
      result := false;
      Break;
    end;
    if (PhastInterpolateCol < 0) or not Item.UsePHAST_Interpolation then
    begin
      if Item.FormulaExpression <> Grid.Cells[ExpressionCol, RowIndex] then
      begin
        result := false;
        Break;
      end;
    end
    else
    begin
      Assert(Grid.Objects[PhastInterpolateCol, RowIndex] <> nil);
      InterpValuesCollection := Grid.Objects[PhastInterpolateCol, RowIndex]
        as TInterpValuesCollection;
      Assert(InterpValuesCollection.Count > 0);
      InterpValuesItem := InterpValuesCollection.Items[0] as TInterpValuesItem;
      if Item.Distance1 <> InterpValuesItem.Values.Distance1 then
      begin
        result := false;
        Break;
      end;
      if Item.Distance2 <> InterpValuesItem.Values.Distance2 then
      begin
        result := false;
        Break;
      end;
      if Item.InterpolationDirection <>
        InterpValuesItem.Values.InterpolationDirection then
      begin
        result := false;
        Break;
      end;
      if Item is TRealPhastBoundaryCondition then
      begin
        RealItem := TRealPhastBoundaryCondition(Item);
        if RealItem.Value1 <> InterpValuesItem.Values.RealValue1 then
        begin
          result := false;
          Break;
        end;
        if RealItem.Value2 <> InterpValuesItem.Values.RealValue2 then
        begin
          result := false;
          Break;
        end;
      end
      else if Item is TIntegerPhastBoundaryCondition then
      begin
        IntegerItem := TIntegerPhastBoundaryCondition(Item);
        if IntegerItem.Value1 <> InterpValuesItem.Values.IntValue1 then
        begin
          result := false;
          Break;
        end;
        if IntegerItem.Value2 <> InterpValuesItem.Values.IntValue2 then
        begin
          result := false;
          Break;
        end;
      end
      else
      begin
        Assert(False);
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetDataForMultipleScreenObjects(
  const AScreenObjectList: TList);
var
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  TempList: TStringList;
  TempType: TPhastBoundaryTypes;
  CompilerList: TList;
  Index: Integer;
  Compiler: TRbwParser;
  FirstScreenObject: TScreenObject;
begin
  // This line should always be the first line.
  IsLoaded := False;

  FCanFillTreeView := False;
//  OutputDebugString('SAMPLING ON');
  if FNewProperties = nil then
  begin
    FNewProperties := TScreenObjectEditCollection.Create;
    FNewProperties.OwnScreenObject := True;
  end;
  FillPropertyCollection(FNewProperties, AScreenObjectList);

  TempList := TStringList.Create;
  try
    if AScreenObjectList.Count >= 1 then
    begin
      // get data for first screen object
      GetData(AScreenObjectList[0]);
      FCanFillTreeView := False;
      IsLoaded := False;
    end;
    if AScreenObjectList.Count > 1 then
    begin
      memoComments.Enabled := False;
      memoComments.Lines.Clear;

      tabVertexValues.TabVisible := False;
      clbChildModels.Enabled := False;
//      tabImportedData.TabVisible := False;
      tabImportedData.TabVisible := False;
      CompilerList := TList.Create;
      try
        FillCompilerList(CompilerList);
        for Index := 0 to CompilerList.Count - 1 do
        begin
          Compiler := CompilerList[Index];
          Compiler.ClearVariables;
        end;
        GetGlobalVariables;
      finally
        CompilerList.Free;
      end;
      CreateDataSetEdits(AScreenObjectList);
    end;


    if FOldProperties = nil then
    begin
      FOldProperties := TScreenObjectEditCollection.Create;
      FOldProperties.OwnScreenObject := True;
    end;
    FillPropertyCollection(FOldProperties, AScreenObjectList);

    FScreenObjectList := AScreenObjectList;
    FScreenObject := nil;
    if AScreenObjectList.Count > 1 then
    begin

      memoNames.Visible := True;
      lblNames.Visible := True;
      // Don't allow user to change the name because each screen object should
      // have a unique name.
      EdName.Text := '';
      EdName.Enabled := False;
      MultipleScreenObjects := True;

      //Get data for the remaining screen objects.
      GetGages(AScreenObjectList);
      GetModpathParticles(AScreenObjectList);
      TempType := btNone;
      for ScreenObjectIndex := 1 to AScreenObjectList.Count - 1 do
      begin
        AScreenObject := AScreenObjectList[ScreenObjectIndex];
        memoNames.Lines.Add(AScreenObject.Name);

        GetObjectLabelForAdditionalScreenObject(AScreenObject);
        GetEvaluatedAtForAdditionalObject(AScreenObject);
        GetPositionLockedForAdditionalObject(AScreenObject);
        GetDataSetsForAdditionalObject(AScreenObject);
        GetElevationFormulasForAdditionalObject(AScreenObject);
        GetCellSizeUsedForAdditionalObject(AScreenObject);
        GetColorDataForAdditionalObject(AScreenObject);
        GetAssignmentMethodForAdditionalObject(AScreenObject);
        GetIFaceForAdditionalObject(AScreenObject);
        GetDuplicatesAllowedForAdditionalObject(AScreenObject);

        GetPhastBoundaryConditionsForAdditionalObjects(AScreenObject, TempType);
      end;
      // Don't allow users to edit more than one type of boundary
      // condition at a time.
      if (TempType=btNone) and (rgBoundaryType.ItemIndex <> 0) then
      begin
        rgBoundaryType.ItemIndex := -1;
      end;

      ShowOrHideTabs;
      // don't allow the users to edit nodes if the number of screen objects
      // is greater than 1.
      tabNodes.TabVisible := False;
      GetModflowBoundaries(AScreenObjectList);
      GetFootprintWells;
      GetAdditionalUsedModels(AScreenObjectList);
      SetSelectedSutraBoundaryNode;
    end;
    FCanFillTreeView := True;
    if AScreenObjectList.Count > 1 then
    begin
      FillDataSetsTreeView(AScreenObjectList);
    end;

  finally
    TempList.Free;
  end;

  if AScreenObjectList.Count >= 1 then
  begin
    FirstScreenObject := AScreenObjectList[0];
    SetDisabledElevationFormulas(FirstScreenObject);
  end;

  FSetCellsColor := False;

  if AScreenObjectList.Count = 1 then
  begin
    jvplObjectInfo.ActivePage := jvspSingleObject;
  end
  else
  begin
    jvplObjectInfo.ActivePage := jvspMultipleObjects;
  end;

  FPriorElevationCount := rgElevationCount.ItemIndex;
  EnableWellTabfile;

  IsLoaded := True;
  SelectBoundaryCell;
  EnableOK_Button;
  EmphasizeValueChoices;
  UpdateSubComponents(self);
  UpdateCurrentEdit;
  SetDefaultCellSize;
  tvDataSetsChange(nil, nil);
//  OutputDebugString('SAMPLING OFF');
end;

procedure TfrmScreenObjectProperties.HideGLViewersWithMicrosoftOpenGL;
{$IFDEF Win64}
var
  VendorString: PAnsiChar;
{$ENDIF}
begin
  // Work-around for buggy Microsoft OpenGL driver.
{$IFDEF Win64}
  Handle;
  VendorString := glGetString(GL_VENDOR);
  if (VendorString <> '') and (VendorString <> 'Microsoft Corporation') then
  begin
    frameModpathParticles.GLSceneViewer1.Visible := True;
    frameIface.glsvViewer.Visible := True;

    frameModpathParticles.lblMessage.Visible := False;
    frameIface.lblMessage.Visible := False;
  end;
{$ELSE}
  frameModpathParticles.GLSceneViewer1.Visible := True;
  frameIface.glsvViewer.Visible := True;

  frameModpathParticles.lblMessage.Visible := False;
  frameIface.lblMessage.Visible := False;
{$ENDIF}
end;

procedure TfrmScreenObjectProperties.SetObjectCaption(List: TList);
var
  AScreenObject: TScreenObject;
  ObjectLabel: TObjectLabel;
  ObjectVertexLabel: TObjectVertexLabel;
  index: Integer;
begin
  for index := 0 to List.Count - 1 do
  begin
    AScreenObject := List[index];
    ObjectLabel := AScreenObject.ObjectLabel;
    if cbCaptionVisible.State <> cbGrayed then
    begin
      ObjectLabel.Visible := cbCaptionVisible.Checked;
    end;
    if (rdeCaptionX.Text <> '') and (rdeCaptionY.Text <> '') then
    begin
      ObjectLabel.OffSet := Point(rdeCaptionX.IntegerValue, rdeCaptionY.IntegerValue);
    end;
    if FCaptionTextChanged then
    begin
      ObjectLabel.Caption := memoCaption.Text;
    end;
    if FCaptionFontChanged then
    begin
      ObjectLabel.Font := FCaptionFont;
    end;

    ObjectVertexLabel := AScreenObject.ObjectVertexLabel;
    if cbVertexLabelVisible.State <> cbGrayed then
    begin
      ObjectVertexLabel.Visible := cbVertexLabelVisible.Checked;
    end;
    if (rdeVertexXOffset.Text <> '') and (rdeVertexYOffset.Text <> '') then
    begin
      ObjectVertexLabel.OffSet := Point(rdeVertexXOffset.IntegerValue,
        rdeVertexYOffset.IntegerValue);
    end;
    if FVertexCaptionFontChanged then
    begin
      ObjectVertexLabel.Font :=   FVertexCaptionFont
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetObjectLabelForAdditionalScreenObject(
  AScreenObject: TScreenObject);
var
  ObjectLabel: TObjectLabel;
  ObjectVertexLabel: TObjectVertexLabel;
begin
  ObjectLabel := AScreenObject.ObjectLabel;
  if cbCaptionVisible.Checked <> ObjectLabel.Visible then
  begin
    cbCaptionVisible.AllowGrayed := True;
    cbCaptionVisible.State := cbGrayed;
  end;
  if (rdeCaptionX.Text <> '')
    and (rdeCaptionX.IntegerValue <> ObjectLabel.OffSet.X) then
  begin
    rdeCaptionX.Text := '';
  end;
  if (rdeCaptionY.Text <> '')
    and (rdeCaptionY.IntegerValue <> ObjectLabel.OffSet.Y) then
  begin
    rdeCaptionY.Text := '';
  end;

  ObjectVertexLabel := AScreenObject.ObjectVertexLabel;
  if cbVertexLabelVisible.Checked <> ObjectVertexLabel.Visible then
  begin
    cbVertexLabelVisible.AllowGrayed := True;
    cbVertexLabelVisible.State := cbGrayed;
  end;
  if (rdeVertexXOffset.Text <> '')
    and (rdeVertexXOffset.IntegerValue <> ObjectVertexLabel.OffSet.X) then
  begin
    rdeVertexXOffset.Text := '';
  end;
  if (rdeVertexYOffset.Text <> '')
    and (rdeVertexYOffset.IntegerValue <> ObjectVertexLabel.OffSet.Y) then
  begin
    rdeVertexYOffset.Text := '';
  end;

end;

procedure TfrmScreenObjectProperties.SetModflowBoundaryColCount;
var
  CropIrrigationRequirement: TCropIrrigationRequirement;
begin
  frameChdParam.dgModflowBoundary.ColCount := 4;
  frameGhbParam.dgModflowBoundary.ColCount := 4;
  frameWellParam.dgModflowBoundary.ColCount := 3;
  frameRivParam.dgModflowBoundary.ColCount := 5;
  frameDrnParam.dgModflowBoundary.ColCount := 4;
  frameDrtParam.dgModflowBoundary.ColCount := 5;
  CropIrrigationRequirement :=
    frmGoPhast.PhastModel.ModflowPackages.FarmProcess.CropIrrigationRequirement;
  case CropIrrigationRequirement of
    cirContinuously:
      begin
        frameFarmWell.dgModflowBoundary.ColCount := 4;
      end;
    cirOnlyWhenNeeded:
      begin
        frameFarmWell.dgModflowBoundary.ColCount := 5;
      end;
  end;
  if frmGoPhast.PhastModel.RchTimeVaryingLayers then
  begin
    frameRchParam.dgModflowBoundary.ColCount := 4;
  end
  else
  begin
    frameRchParam.dgModflowBoundary.ColCount := 3;
  end;
  if frmGoPhast.PhastModel.EvtTimeVaryingLayers then
  begin
    frameEvtParam.dgModflowBoundary.ColCount := 6;
  end
  else
  begin
    frameEvtParam.dgModflowBoundary.ColCount := 5;
  end;
  if frmGoPhast.PhastModel.EtsTimeVaryingLayers then
  begin
    frameEtsParam.dgModflowBoundary.ColCount :=
      6 + (frmGoPhast.PhastModel.ModflowPackages.EtsPackage.SegmentCount - 1) * 2;
  end
  else
  begin
    frameEtsParam.dgModflowBoundary.ColCount :=
      5 + (frmGoPhast.PhastModel.ModflowPackages.EtsPackage.SegmentCount - 1) * 2;
  end;
  frameMT3DMS_SSM.dgModflowBoundary.ColCount :=
    2 + frmGoPhast.PhastModel.MobileComponents.Count
    + frmGoPhast.PhastModel.ImmobileComponents.Count;
  frameSWR_Rain.dgModflowBoundary.ColCount := 3;
  frameSWR_Evap.dgModflowBoundary.ColCount := 3;
  frameSWR_LatInfl.dgModflowBoundary.ColCount := 3;
  frameSWR_Stage.dgModflowBoundary.ColCount := 3;
  frameSWR_DirectRunoff.dgModflowBoundary.ColCount := 4;
//  frameSwrReach.frameSwr.dgModflowBoundary.ColCount := 6;
end;

procedure TfrmScreenObjectProperties.CreateSutraFeatureNodes;
begin
  jvpltvSutraFeatures.Items.Clear;
  CreateSutraObsNode;
  CreateSutraSpecPressNode;
  CreateSutraSpecTempConcNode;
  CreateSutraFluidFluxNode;
  CreateSutraMassEnergyFluxNode;
  CreateSutraLakeNode;
end;

{$IFDEF SUTRA30}
function TfrmScreenObjectProperties.ShouldCreateSutraLakeBoundary: Boolean;
var
  LocalModel: TPhastModel;
begin
  LocalModel := frmGoPhast.PhastModel;
  result := (LocalModel.ModelSelection in SutraSelection)
    and (LocalModel.SutraMesh <> nil)
    and (rgEvaluatedAt.ItemIndex = Ord(eaNodes))
    and (LocalModel.SutraMesh.MeshType = mt3D)
end;
{$ENDIF}

function TfrmScreenObjectProperties.ShouldCreateSutraBoundary: Boolean;
var
  LocalModel: TPhastModel;
begin
  LocalModel := frmGoPhast.PhastModel;
  result := (LocalModel.ModelSelection in SutraSelection)
    and (LocalModel.SutraMesh <> nil)
    and (rgEvaluatedAt.ItemIndex = Ord(eaNodes))
    and ((LocalModel.SutraMesh.MeshType in [mt2D, mtProfile])
    or (rgElevationCount.ItemIndex in [1, 2]));
end;

//function TfrmScreenObjectProperties.CanSelectMt3dms: Boolean;
//begin
//  if ((FCHD_Node <> nil) and (FCHD_Node.StateIndex <> 1))
//    or ((FWEL_Node <> nil) and (FWEL_Node.StateIndex <> 1))
//    or ((FDRN_Node <> nil) and (FDRN_Node.StateIndex <> 1))
//    or ((FRIV_Node <> nil) and (FRIV_Node.StateIndex <> 1))
//    or ((FGHB_Node <> nil) and (FGHB_Node.StateIndex <> 1))
//    or ((FRCH_Node <> nil) and (FRCH_Node.StateIndex <> 1))
//    or ((FEVT_Node <> nil) and (FEVT_Node.StateIndex <> 1))
//    or ((FRES_Node <> nil) and (FRES_Node.StateIndex <> 1))
//    or ((FLAK_Node <> nil) and (FLAK_Node.StateIndex <> 1))
//    or ((FDRT_Node <> nil) and (FDRT_Node.StateIndex <> 1))
//    or ((FETS_Node <> nil) and (FETS_Node.StateIndex <> 1)) then
//  begin
//    result := True;
//  end
//  else
//  begin
//    result := False;
//  end;
//end;

procedure TfrmScreenObjectProperties.GetCanSelectNode(Node: TTreeNode; var AllowChange: Boolean);
var
  SwrPackage: TSwrPackage;
begin
  SwrPackage := frmGoPhast.PhastModel.ModflowPackages.SwrPackage;
  if (Node = FChob_Node) then
  begin
    if (FCHD_Node = nil) or (FCHD_Node.StateIndex = 1) then
    begin
      AllowChange := False;
    end;
  end
  else if (Node = FDrob_Node) then
  begin
    if (FDRN_Node = nil) or (FDRN_Node.StateIndex = 1) then
    begin
      AllowChange := False;
    end;
  end
  else if (Node = FGbob_Node) then
  begin
    if (FGHB_Node = nil) or (FGHB_Node.StateIndex = 1) then
    begin
      AllowChange := False;
    end;
  end
  else if (Node = FRvob_Node) then
  begin
    if (FRIV_Node = nil) or (FRIV_Node.StateIndex = 1) then
    begin
      AllowChange := False;
    end
  end
  else if (Node = FStob_Node) then
  begin
    if (FSTR_Node = nil) or (FSTR_Node.StateIndex = 1) then
    begin
      AllowChange := False;
    end
  end
  else if (Node = FMt3dmsTobFlux_Node) then
  begin
    AllowChange := False;
    if (FCHD_Node <> nil) and (FCHD_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FDRN_Node <> nil) and (FDRN_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FGHB_Node <> nil) and (FGHB_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FRIV_Node <> nil) and (FRIV_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FWEL_Node <> nil) and (FWEL_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FEVT_Node <> nil) and (FEVT_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FMt3dmsSsm_Node <> nil) and (FMt3dmsSsm_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FRES_Node <> nil) and (FRES_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FLAK_Node <> nil) and (FLAK_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FDRT_Node <> nil) and (FDRT_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FETS_Node <> nil) and (FETS_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FSTR_Node <> nil) and (FSTR_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FFhbHead_Node <> nil) and (FFhbHead_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FFhbFlow_Node <> nil) and (FFhbFlow_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FSWR_Reach_Node <> nil) and (FSWR_Reach_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FSWR_Rain_Node <> nil) and (FSWR_Rain_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FSWR_Evap_Node <> nil) and (FSWR_Evap_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FSWR_LatInflow_Node <> nil) and (FSWR_LatInflow_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FSWR_Stage_Node <> nil) and (FSWR_Stage_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FSWR_DirectRunoff_Node <> nil) and (FSWR_DirectRunoff_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    {else if (FFmpFarm_Node <> nil) and (FFmpFarm_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FFarmWell_Node <> nil) and (FFarmWell_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FFarmPrecip_Node <> nil) and (FFarmPrecip_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FFarmRevEvap_Node <> nil) and (FFarmRevEvap_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FFarmCropID_Node <> nil) and (FFarmCropID_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end
    else if (FCfpPipe_Node <> nil) and (FCfpPipe_Node.StateIndex <> 1)
      and (rgElevationCount.ItemIndex = 1) then
    begin
      AllowChange := True;
    end
    else if (FCfpFixedHead_Node <> nil) and (FCfpFixedHead_Node.StateIndex <> 1) then
    begin
      AllowChange := True;
    end  }

  end
  else if (Node = FCfpPipe_Node) then
  begin
    if (rgElevationCount.ItemIndex <> 1) then
    begin
      AllowChange := False;
    end
  end
  else if (Node = FSWR_Reach_Node) and (FSWR_Reach_Node.StateIndex <> 1) then
  begin
    AllowChange := True;
  end
  else if Node = FSWR_Rain_Node then
  begin
    if (SwrPackage.RainSpecification = smObject)
      and (FSWR_Reach_Node.StateIndex = 1) then
    begin
      AllowChange := False;
    end;
  end
  else if Node = FSWR_Evap_Node then
  begin
    if (SwrPackage.EvapSpecification = smObject)
      and (FSWR_Reach_Node.StateIndex = 1) then
    begin
      AllowChange := False;
    end;
  end
  else if Node = FSWR_LatInflow_Node then
  begin
    if (SwrPackage.LateralInflowSpecification = smObject)
      and (FSWR_Reach_Node.StateIndex = 1) then
    begin
      AllowChange := False;
    end;
  end
  else if Node = FSWR_Stage_Node then
  begin
    if (SwrPackage.StageSpecification = smObject)
      and (FSWR_Reach_Node.StateIndex = 1) then
    begin
      AllowChange := False;
    end;
  end
  else if Node = FSWR_DirectRunoff_Node then
  begin
    AllowChange := True;
  end
  else if Node = FSWiObs_Node then
  begin
    AllowChange := True;
  end
  else if Node = FRipNode then
  begin
    AllowChange := True;
  end;

//  end
//  else if (Node = FMt3dms_Node) then
//  begin
//    AllowChange := CanSelectMt3dms;
//  end;
end;

procedure TfrmScreenObjectProperties.GetPositionLockedForAdditionalObject(AScreenObject: TScreenObject);
begin
  if AScreenObject.PositionLocked <> cbLock.Checked then
  begin
    cbLock.AllowGrayed := True;
    cbLock.State := cbGrayed;
  end;
end;

procedure TfrmScreenObjectProperties.FillChildModelList;
var
  Item: TChildModelItem;
  ChildModelIndex: Integer;
begin
  if FChildModels = nil then
  begin
    FChildModels := TList.Create;
  end;
  if FChildModelsScreenObjects = nil then
  begin
    FChildModelsScreenObjects := TList.Create;
  end;
  FChildModels.Clear;
  FChildModelsScreenObjects.Clear;
  clbChildModels.Items.BeginUpdate;
  try
    clbChildModels.Items.Clear;
    clbChildModels.Items.Add('none');
    for ChildModelIndex := 0 to frmGoPhast.PhastModel.ChildModels.Count - 1 do
    begin
      Item := frmGoPhast.PhastModel.ChildModels[ChildModelIndex];
      clbChildModels.Items.AddObject(Item.ChildModel.ModelName, Item.ChildModel);
      FChildModels.Add(Item.ChildModel);
      FChildModelsScreenObjects.Add(Item.ChildModel.HorizontalPositionScreenObject);
    end;
    clbChildModels.CheckedIndex := 0;
  finally
    clbChildModels.Items.EndUpdate;
  end;
end;

procedure TfrmScreenObjectProperties.EnableChildModelList(AScreenObject: TScreenObject);
begin
  if CanSpecifyChildModels(AScreenObject) then
  begin
    clbChildModels.Enabled := True;
//    FillChildModelList;
  end
  else
  begin
    clbChildModels.Enabled := False;
  end;
  if clbChildModels.Enabled then
  begin
    clbChildModels.Color := clWindow;
  end
  else
  begin
    clbChildModels.Color := clBtnFace;
  end;
end;

procedure TfrmScreenObjectProperties.GetAdditionalUsedModels(const AScreenObjectList: TList);
var
  ChildIndex: Integer;
  ChildModel: TChildModel;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
begin
  for ScreenObjectIndex := 1 to AScreenObjectList.Count - 1 do
  begin
    AScreenObject := AScreenObjectList[ScreenObjectIndex];
    if cbLgrAllModels.Checked <> AScreenObject.UsedModels.UsedWithAllModels then
    begin
      cbLgrAllModels.AllowGrayed := True;
      cbLgrAllModels.State := cbGrayed;
    end;
    if clbLgrUsedModels.Checked[0] <> AScreenObject.UsedModels.UsesModel(frmGoPhast.PhastModel) then
    begin
      clbLgrUsedModels.AllowGrayed := True;
      clbLgrUsedModels.State[0] := cbGrayed;
    end;
    for ChildIndex := 0 to frmGoPhast.PhastModel.ChildModels.Count - 1 do
    begin
      ChildModel := frmGoPhast.PhastModel.ChildModels[ChildIndex].ChildModel;
      if clbLgrUsedModels.Checked[ChildIndex+1] <> AScreenObject.UsedModels.UsesModel(ChildModel) then
      begin
        clbLgrUsedModels.AllowGrayed := True;
        clbLgrUsedModels.State[ChildIndex + 1] := cbGrayed;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetUsedLgrModels(const AScreenObject: TScreenObject);
var
  ChildModel: TChildModel;
  ChildModelIndex: Integer;
begin
  cbLgrAllModels.AllowGrayed := False;
  cbLgrAllModels.Checked := AScreenObject.UsedModels.UsedWithAllModels;
  clbLgrUsedModels.Checked[0] := AScreenObject.UsedModels.UsesModel(frmGoPhast.PhastModel);
  for ChildModelIndex := 0 to frmGoPhast.PhastModel.ChildModels.Count - 1 do
  begin
    ChildModel := frmGoPhast.PhastModel.ChildModels[ChildModelIndex].ChildModel;
    clbLgrUsedModels.Checked[ChildModelIndex + 1] := AScreenObject.UsedModels.UsesModel(ChildModel);
  end;
  clbLgrUsedModels.AllowGrayed := False;
  
end;

procedure TfrmScreenObjectProperties.SetVertexValues(AScreenObject: TScreenObject);
var
  RowIndex: Integer;
  PointValueItem: TPointValuesItem;
  ColIndex: Integer;
  ValuePosition: Integer;
  ValueItem: TPointValue;
begin
  if tabVertexValues.TabVisible then
  begin
    Assert(AScreenObject.PointPositionValues.Count =
      rdgVertexValues.RowCount - 1);
    for RowIndex := rdgVertexValues.RowCount - 1 downto 1 do
    begin
      PointValueItem := AScreenObject.PointPositionValues.
        Items[RowIndex - 1] as TPointValuesItem;
      for ColIndex := 1 to rdgVertexValues.ColCount - 1 do
      begin
        ValuePosition := PointValueItem.IndexOfName(
          rdgVertexValues.Cells[ColIndex, 0]);
        if rdgVertexValues.Cells[ColIndex, RowIndex] = '' then
        begin
          if ValuePosition >= 0 then
          begin
            PointValueItem.Values.Delete(ValuePosition);
          end;
        end
        else
        begin
          if ValuePosition >= 0 then
          begin
            ValueItem := PointValueItem.Values.
              Items[ValuePosition] as TPointValue;
          end
          else
          begin
            ValueItem := PointValueItem.Values.Add as TPointValue;
            ValueItem.Name := rdgVertexValues.Cells[ColIndex, 0];
          end;
          ValueItem.Value := StrToFloat(
            rdgVertexValues.Cells[ColIndex, RowIndex]);
        end;
      end;
      if PointValueItem.Values.Count = 0 then
      begin
        AScreenObject.PointPositionValues.Delete(RowIndex - 1);
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetVertexValues;
var
  AColumn: TRbwColumn4;
  RowIndex: Integer;
  VertexValueItem: TPointValue;
  ValueIndex: Integer;
  PointValueItem: TPointValuesItem;
  PointIndex: Integer;
  Keys: TStringList;
  ColIndex: Integer;
begin
  if FScreenObject.PointPositionValues.Count > 0 then
  begin
    tabVertexValues.TabVisible := True;
    rdgVertexValues.BeginUpdate;
    try
      Keys := TStringList.Create;
      try
        Keys.Sorted := True;
        Keys.CaseSensitive := False;
        for PointIndex := 0 to FScreenObject.PointPositionValues.Count - 1 do
        begin
          PointValueItem := FScreenObject.PointPositionValues.
            Items[PointIndex] as TPointValuesItem;
          for ValueIndex := 0 to PointValueItem.Values.Count - 1 do
          begin
            VertexValueItem := PointValueItem.Values.
              Items[ValueIndex] as TPointValue;
            if Keys.IndexOf(VertexValueItem.Name) < 0 then
            begin
              Keys.Add(VertexValueItem.Name);
            end;
          end;
        end;
        rdgVertexValues.RowCount := FScreenObject.PointPositionValues.Count + 1;
        rdgVertexValues.ColCount := Keys.Count + 1;
        for ColIndex := 0 to rdgVertexValues.ColCount - 1 do
        begin
          for RowIndex := 0 to rdgVertexValues.RowCount - 1 do
          begin
            rdgVertexValues.Cells[ColIndex, RowIndex] := '';
          end;
        end;
        for ColIndex := 1 to rdgVertexValues.ColCount - 1 do
        begin
          rdgVertexValues.ColWidths[ColIndex] :=
            rdgVertexValues.DefaultColWidth;
          rdgVertexValues.Cells[0, 0] := StrVertexNumbers;
          rdgVertexValues.Cells[ColIndex, 0] := Keys[ColIndex - 1];
          AColumn := rdgVertexValues.Columns[ColIndex];
          AColumn.AutoAdjustColWidths := True;
          AColumn.Format := rcf4Real;
        end;
        for PointIndex := 0 to FScreenObject.PointPositionValues.Count - 1 do
        begin
          PointValueItem := FScreenObject.PointPositionValues.
            Items[PointIndex] as TPointValuesItem;
          rdgVertexValues.Cells[0, PointIndex + 1] :=
            IntToStr(PointValueItem.Position + 1);
          for ValueIndex := 0 to PointValueItem.Values.Count - 1 do
          begin
            VertexValueItem := PointValueItem.Values.
              Items[ValueIndex] as TPointValue;
            ColIndex := Keys.IndexOf(VertexValueItem.Name) + 1;
            rdgVertexValues.Cells[ColIndex, PointIndex + 1] :=
              FloatToStr(VertexValueItem.Value);
          end;
        end;
      finally
        Keys.Free;
      end;
    finally
      rdgVertexValues.EndUpdate;
    end;
  end
  else
  begin
    tabVertexValues.TabVisible := False;
  end;
end;

function TfrmScreenObjectProperties.CanSpecifyChildModels(AScreenObject: TScreenObject): Boolean;
begin
  result := (AScreenObject <> nil)
    and frmGoPhast.PhastModel.LgrUsed
    and (AScreenObject.ViewDirection = vdTop)
    and (rgElevationCount.ItemIndex = 0);
end;

procedure TfrmScreenObjectProperties.SetupChildModelControls(AScreenObject: TScreenObject);
var
  ChildModelIndex: Integer;
  Item: TChildModelItem;
begin
  clbLgrUsedModels.Items.BeginUpdate;
  try
    clbLgrUsedModels.Clear;
    clbLgrUsedModels.Items.AddObject(StrParentModel,frmGoPhast.PhastModel);
    for ChildModelIndex := 0 to frmGoPhast.PhastModel.ChildModels.Count - 1 do
    begin
      Item := frmGoPhast.PhastModel.ChildModels[ChildModelIndex];
      clbLgrUsedModels.Items.AddObject(
        Item.ChildModel.ModelName, Item.ChildModel);
    end;
  finally
    clbLgrUsedModels.Items.EndUpdate;
  end;
  EnableChildModelList(AScreenObject);
end;

procedure TfrmScreenObjectProperties.UpdateSectionNumbers;
var
  SectionIndex: Integer;
  TempString: string;
  Index: Integer;
begin
  if FSettingVerticies then
  begin
    Exit;
  end;
  SectionIndex := 0;
  TempString := '0';
  dgVerticies.BeginUpdate;
  try
    for Index := 1 to dgVerticies.RowCount - 1 do
    begin
      if dgVerticies.Checked[Ord(vcNewSection), Index] then
      begin
        Inc(SectionIndex);
        TempString := IntToStr(SectionIndex);
      end;
      dgVerticies.Cells[Ord(vcSection), Index] := TempString;
    end;
  finally
    dgVerticies.EndUpdate;
  end;
end;

procedure TfrmScreenObjectProperties.UpdateVertexNumbers;
var
  Index: Integer;
  TempString: string;
begin
  if FSettingVerticies then
  begin
    Exit;
  end;
  dgVerticies.BeginUpdate;
  try
    for Index := 1 to dgVerticies.RowCount - 1 do
    begin
      TempString := IntToStr(Index);
      dgVerticies.Cells[Ord(vcN), Index] := TempString;
    end;
  finally
    dgVerticies.EndUpdate;
  end;
end;

procedure TfrmScreenObjectProperties.ClearExpressionsAndVariables();
var
  Compiler: TRbwParser;
  Index: Integer;
  CompilerList: TList;
begin
  CompilerList := TList.Create;
  try
    FillCompilerList(CompilerList);
    for Index := 0 to CompilerList.Count - 1 do
    begin
      Compiler := CompilerList[Index];
      Compiler.ClearExpressions;
      Compiler.ClearVariables;
    end;
  finally
    CompilerList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.SetFrameData;
var
  DataSetIndex: Integer;
  PipeIndex: Integer;
  AnEdit: TScreenObjectEditItem;
  Pipes: TCfpPipeBoundary;
  CfpEdit: TScreenObjectDataEdit;
  DiameterDataArray: TDataArray;
  TortuosityDataArray: TDataArray;
  RoughnessHeightDataArray: TDataArray;
  LowerCriticalRDataArray: TDataArray;
  UpperCriticalRDataArray: TDataArray;
  CondOrPermDataArray: TDataArray;
  PipeElevation: TDataArray;
  CfpFixedHeadsDataArray: TDataArray;
  FixedHeadIndex: Integer;
  CfpFixedHeads: TCfpFixedBoundary;
begin
  if (FHOB_Node <> nil) then
  begin
    frameHeadObservations.SetData(FNewProperties,
      (FHOB_Node.StateIndex = 2),
      (FHOB_Node.StateIndex = 1) and frmGoPhast.PhastModel.HobIsSelected);
  end;

  if (FSFR_Node <> nil) then
  begin
    frameScreenObjectSFR.SetData(FNewProperties,
      (FSFR_Node.StateIndex = 2),
      (FSFR_Node.StateIndex = 1) and frmGoPhast.PhastModel.SfrIsSelected);
  end;

  if (FSTR_Node <> nil) then
  begin
    frameScreenObjectSTR.SetData(FNewProperties,
      (FSTR_Node.StateIndex = 2),
      (FSTR_Node.StateIndex = 1) and frmGoPhast.PhastModel.StrIsSelected);
  end;

  if FSWiObs_Node <> nil then
  begin
    frameSwiObs.SetData(FNewProperties,
      (FSWiObs_Node.StateIndex = 2),
      (FSWiObs_Node.StateIndex = 1) and frmGoPhast.PhastModel.SwiObsUsed(nil));
  end;

  if (FMNW2_Node <> nil) then
  begin
    frameMNW2.SetData(FNewProperties,
      (FMNW2_Node.StateIndex = 2),
      (FMNW2_Node.StateIndex = 1) and frmGoPhast.PhastModel.Mnw2IsSelected);
  end;

  if (FMNW1_Node <> nil) then
  begin
    frameMNW1.SetData(FNewProperties,
      (FMNW1_Node.StateIndex = 2),
      (FMNW1_Node.StateIndex = 1) and frmGoPhast.PhastModel.Mnw1IsSelected);
  end;

  if (FHFB_Node <> nil) then
  begin
    frameHfbBoundary.SetData(FNewProperties,
      (FHFB_Node.StateIndex = 2),
      (FHFB_Node.StateIndex = 1) and frmGoPhast.PhastModel.HfbIsSelected);
  end;

  if (FHydmod_Node <> nil) then
  begin
    frameHydmod.SetData(FNewProperties,
      (FHydmod_Node.StateIndex = 2),
      (FHydmod_Node.StateIndex = 1) and frmGoPhast.PhastModel.HydmodIsSelected);
  end;

  if (FMt3dmsTobConc_Node <> nil) then
  begin
    frameMt3dmsTobConc.SetData(FNewProperties,
      (FMt3dmsTobConc_Node.StateIndex = 2),
      (FMt3dmsTobConc_Node.StateIndex = 1)
      and frmGoPhast.PhastModel.Mt3dmsTobIsSelected);
  end;

  if (FFhbHead_Node <> nil) then
  begin
    frameFhbHead.SetData(FNewProperties,
      (FFhbHead_Node.StateIndex = 2),
      (FFhbHead_Node.StateIndex = 1) and frmGoPhast.PhastModel.FhbIsSelected);
  end;

  if (FFhbFlow_Node <> nil) then
  begin
    frameFhbFlow.SetData(FNewProperties,
      (FFhbFlow_Node.StateIndex = 2),
      (FFhbFlow_Node.StateIndex = 1) and frmGoPhast.PhastModel.FhbIsSelected);
  end;

  if (FSWR_Reach_Node <> nil) then
  begin
    frameSwrReach.SetData(FNewProperties,
      (FSWR_Reach_Node.StateIndex = 2),
      (FSWR_Reach_Node.StateIndex = 1) and frmGoPhast.PhastModel.SwrIsSelected);
  end;

  if (FSutraObs_Node <> nil) then
  begin
    frameSutraObservations.SetData(FNewProperties,
      (FSutraObs_Node.StateIndex = 2),
      (FSutraObs_Node.StateIndex = 1)
      and (frmGoPhast.PhastModel.ModelSelection in SutraSelection));
  end;

  if (FSutraSpecPressure_Node <> nil) then
  begin
    frameSutraSpecifiedPressure.SetData(FNewProperties,
      (FSutraSpecPressure_Node.StateIndex = 2),
      (FSutraSpecPressure_Node.StateIndex = 1)
      and (frmGoPhast.PhastModel.ModelSelection in SutraSelection));
  end;

  if (FSutraLake_Node <> nil) then
  begin
    frameSutraLake.SetData(FNewProperties,
      (FSutraLake_Node.StateIndex = 2),
      (FSutraLake_Node.StateIndex = 1)
      and (frmGoPhast.PhastModel.ModelSelection in SutraSelection));
  end;

  if (FSutraSpecTempConc_Node <> nil) then
  begin
    frameSutraSpecTempConc.SetData(FNewProperties,
      (FSutraSpecTempConc_Node.StateIndex = 2),
      (FSutraSpecTempConc_Node.StateIndex = 1)
      and (frmGoPhast.PhastModel.ModelSelection in SutraSelection));
  end;

  if (FSutraFluidFlux_Node <> nil) then
  begin
    frameSutraFluidFlux.SetData(FNewProperties,
      (FSutraFluidFlux_Node.StateIndex = 2),
      (FSutraFluidFlux_Node.StateIndex = 1)
      and (frmGoPhast.PhastModel.ModelSelection in SutraSelection));
  end;

  if (FSutraMassEnergyFlux_Node <> nil) then
  begin
    frameSutraMassEnergyFlux.SetData(FNewProperties,
      (FSutraMassEnergyFlux_Node.StateIndex = 2),
      (FSutraMassEnergyFlux_Node.StateIndex = 1)
      and (frmGoPhast.PhastModel.ModelSelection in SutraSelection));
  end;

  if (FFarmPrecip_Node <> nil) then
  begin
    frameFarmPrecip.SetData(FNewProperties,
      (FFarmPrecip_Node.StateIndex = 2),
      (FFarmPrecip_Node.StateIndex = 1) and frmGoPhast.PhastModel.FarmProcessIsSelected);
  end;

  if (FFarmRevEvap_Node <> nil) then
  begin
    frameFarmRefEvap.SetData(FNewProperties,
      (FFarmRevEvap_Node.StateIndex = 2),
      (FFarmRevEvap_Node.StateIndex = 1) and frmGoPhast.PhastModel.FarmProcessIsSelected);
  end;

  if (FFarmCropID_Node <> nil) then
  begin
    frameFarmCropID.SetData(FNewProperties,
      (FFarmCropID_Node.StateIndex = 2),
      (FFarmCropID_Node.StateIndex = 1) and frmGoPhast.PhastModel.FarmProcessIsSelected);
  end;

  if (FFarmID_Node <> nil) then
  begin
    frameFarmID.SetData(FNewProperties,
      (FFarmID_Node.StateIndex = 2),
      (FFarmID_Node.StateIndex = 1) and frmGoPhast.PhastModel.FarmProcessIsSelected);
  end;

  if (FRipNode <> nil) then
  begin
    frameRip.SetData(FNewProperties,
      (FRipNode.StateIndex = 2),
      (FRipNode.StateIndex = 1) and frmGoPhast.PhastModel.RipIsSelected);
  end;

  if (FCfpPipe_Node <> nil) then
  begin
    frameCfpPipes.SetData(FNewProperties,
      (FCfpPipe_Node.StateIndex = 2),
      (FCfpPipe_Node.StateIndex = 1) and frmGoPhast.PhastModel.CfpIsSelected);

    DataSetIndex := self.GetDataSetIndexByName(KPipeDiameter);
    CfpEdit := FDataEdits[DataSetIndex];
    DiameterDataArray := CfpEdit.DataArray;

    DataSetIndex := self.GetDataSetIndexByName(KTortuosity);
    CfpEdit := FDataEdits[DataSetIndex];
    TortuosityDataArray := CfpEdit.DataArray;

    DataSetIndex := self.GetDataSetIndexByName(KRoughnessHeight);
    CfpEdit := FDataEdits[DataSetIndex];
    RoughnessHeightDataArray := CfpEdit.DataArray;

    DataSetIndex := self.GetDataSetIndexByName(KLowerCriticalR);
    CfpEdit := FDataEdits[DataSetIndex];
    LowerCriticalRDataArray := CfpEdit.DataArray;

    DataSetIndex := self.GetDataSetIndexByName(KUpperCriticalR);
    CfpEdit := FDataEdits[DataSetIndex];
    UpperCriticalRDataArray := CfpEdit.DataArray;

    DataSetIndex := self.GetDataSetIndexByName(KPipeConductanceOrPer);
    CfpEdit := FDataEdits[DataSetIndex];
    CondOrPermDataArray := CfpEdit.DataArray;

    DataSetIndex := self.GetDataSetIndexByName(KCfpNodeElevation);
    CfpEdit := FDataEdits[DataSetIndex];
    PipeElevation := CfpEdit.DataArray;

    for PipeIndex := 0 to FNewProperties.Count - 1 do
    begin
      AnEdit := FNewProperties[PipeIndex];
      Pipes := AnEdit.ScreenObject.ModflowCfpPipes;
      if (Pipes <> nil)  then
      begin
        if Pipes.Used then
        begin
          DataSetIndex := AnEdit.ScreenObject.AddDataSet(DiameterDataArray);
          AnEdit.ScreenObject.DataSetFormulas[DataSetIndex] :=
            Pipes.Diameter;

          DataSetIndex := AnEdit.ScreenObject.AddDataSet(TortuosityDataArray);
          AnEdit.ScreenObject.DataSetFormulas[DataSetIndex] :=
            Pipes.Tortuosity;

          DataSetIndex := AnEdit.ScreenObject.AddDataSet(RoughnessHeightDataArray);
          AnEdit.ScreenObject.DataSetFormulas[DataSetIndex] :=
            Pipes.RoughnessHeight;

          DataSetIndex := AnEdit.ScreenObject.AddDataSet(LowerCriticalRDataArray);
          AnEdit.ScreenObject.DataSetFormulas[DataSetIndex] :=
            Pipes.LowerCriticalR;

          DataSetIndex := AnEdit.ScreenObject.AddDataSet(UpperCriticalRDataArray);
          AnEdit.ScreenObject.DataSetFormulas[DataSetIndex] :=
            Pipes.HigherCriticalR;

          DataSetIndex := AnEdit.ScreenObject.AddDataSet(CondOrPermDataArray);
          AnEdit.ScreenObject.DataSetFormulas[DataSetIndex] :=
            Pipes.ConductancePermeability;

          if frameCfpPipes.edElevation.Enabled then
          begin
            DataSetIndex := AnEdit.ScreenObject.AddDataSet(PipeElevation);
            AnEdit.ScreenObject.DataSetFormulas[DataSetIndex] :=
              Pipes.Elevation;
          end
          else
          begin
            AnEdit.ScreenObject.RemoveDataSet(PipeElevation);
          end;
        end
        else
        begin
          AnEdit.ScreenObject.RemoveDataSet(DiameterDataArray);
          AnEdit.ScreenObject.RemoveDataSet(TortuosityDataArray);
          AnEdit.ScreenObject.RemoveDataSet(RoughnessHeightDataArray);
          AnEdit.ScreenObject.RemoveDataSet(LowerCriticalRDataArray);
          AnEdit.ScreenObject.RemoveDataSet(UpperCriticalRDataArray);
          AnEdit.ScreenObject.RemoveDataSet(CondOrPermDataArray);
          AnEdit.ScreenObject.RemoveDataSet(PipeElevation);
        end;
      end
      else
      begin
        AnEdit.ScreenObject.RemoveDataSet(DiameterDataArray);
        AnEdit.ScreenObject.RemoveDataSet(TortuosityDataArray);
        AnEdit.ScreenObject.RemoveDataSet(RoughnessHeightDataArray);
        AnEdit.ScreenObject.RemoveDataSet(LowerCriticalRDataArray);
        AnEdit.ScreenObject.RemoveDataSet(UpperCriticalRDataArray);
        AnEdit.ScreenObject.RemoveDataSet(CondOrPermDataArray);
        AnEdit.ScreenObject.RemoveDataSet(PipeElevation);
      end;
    end;
  end;

  if (FCfpFixedHead_Node <> nil) then
  begin
    frameCfpFixedHeads.SetData(FNewProperties,
      (FCfpFixedHead_Node.StateIndex = 2),
      (FCfpFixedHead_Node.StateIndex = 1) and frmGoPhast.PhastModel.CfpIsSelected);

    DataSetIndex := self.GetDataSetIndexByName(KCfpFixedHeads);
    CfpEdit := FDataEdits[DataSetIndex];
    CfpFixedHeadsDataArray := CfpEdit.DataArray;

    for FixedHeadIndex := 0 to FNewProperties.Count - 1 do
    begin
      AnEdit := FNewProperties[FixedHeadIndex];
      CfpFixedHeads := AnEdit.ScreenObject.ModflowCfpFixedHeads;
      if (CfpFixedHeads <> nil)  then
      begin
        if CfpFixedHeads.Used then
        begin
          DataSetIndex := AnEdit.ScreenObject.AddDataSet(CfpFixedHeadsDataArray);
          AnEdit.ScreenObject.DataSetFormulas[DataSetIndex] :=
            CfpFixedHeads.FixedHead;
        end
        else
        begin
          AnEdit.ScreenObject.RemoveDataSet(CfpFixedHeadsDataArray);
        end;
      end
      else
      begin
        AnEdit.ScreenObject.RemoveDataSet(CfpFixedHeadsDataArray);
      end;
    end;
  end;

  frameScreenObjectFootprintWell.SetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.UpdateVertices;
var
  Item: TScreenObjectEditItem;
  RowIndex: Integer;
  AnotherPoint: TPoint2D;
begin
  FCanSetPointsOutOfDate := True;
  InvalidateAllDataSets;
  if IsLoaded then
  begin
    dgVerticies.Invalidate;
    if CanSetPoints then
    begin
      if FNewProperties.Count <> 1 then
      begin
        Beep;
        MessageDlg(StrIfMoreThanOneObj, mtError, [mbOK], 0);
        Exit;
      end;
      Assert(FNewProperties.Count = 1);
      Item := FNewProperties[0];
      Item.ScreenObject.SectionStarts.Clear;
      Item.ScreenObject.ClearPoints;
      for RowIndex := 1 to dgVerticies.RowCount - 1 do
      begin
        if not AssignPoint(RowIndex, AnotherPoint) then
        begin
          Continue;
        end;
        Item.ScreenObject.AddPoint(AnotherPoint, dgVerticies.Checked[Ord(vcNewSection), RowIndex]);
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.SetGageNodeStateIndex;
begin
  if FGage_Node = nil then
  begin
    Exit;
  end;
  if (cbGageStandard.State = cbUnchecked)
    and (cbGage1.State = cbUnchecked)
    and (cbGage2.State = cbUnchecked)
    and (cbGage3.State = cbUnchecked)
    and (cbGage5.State = cbUnchecked)
    and (cbGage6.State = cbUnchecked)
    and (cbGage7.State = cbUnchecked) then
  begin
    FGage_Node.StateIndex := 1;
  end
  else if (cbGageStandard.State = cbChecked)
    or (cbGage1.State = cbChecked)
    or (cbGage2.State = cbChecked)
    or (cbGage3.State = cbChecked)
    or (cbGage5.State = cbChecked)
    or (cbGage6.State = cbChecked)
    or (cbGage7.State = cbChecked) then
  begin
    FGage_Node.StateIndex := 2;
  end
  else
  begin
    FGage_Node.StateIndex := 3;
  end;
end;

procedure TfrmScreenObjectProperties.GetFluxObservations(const AScreenObjectList: TList);
begin
  GetHeadFluxObservations(AScreenObjectList);
  GetDrainFluxObservations(AScreenObjectList);
  GetGhbFluxObservations(AScreenObjectList);
  GetRiverFluxObservations(AScreenObjectList);
  GetStreamFluxObservations(AScreenObjectList);
  GetMt3dmsFluxObservations(AScreenObjectList);
end;

procedure TfrmScreenObjectProperties.GetNearestDiversionSegment(
  var NewText: string; ParameterType: TParameterType);
var
  TestScreenObject: TScreenObject;
  InFlowLocation: TPoint2D;
  NearestStream: TScreenObject;
  Dist: Double;
  Index: Integer;
  AScreenObject: TScreenObject;
  TestLocation: TPoint2D;
  TestDist: Double;
  NearestLake: TScreenObject;
  SectionIndex: Integer;
begin
  if FScreenObject = nil then
  begin
    if FScreenObjectList.Count <> 1 then
    begin
      Beep;
      MessageDlg(StrSorryThisFunction, mtError, [mbOK], 0);
      Exit;
    end;
    Assert(FScreenObjectList.Count = 1);
    TestScreenObject := FScreenObjectList[0];
  end
  else
  begin
    TestScreenObject := FScreenObject;
  end;
  Assert(TestScreenObject <> nil);
  InFlowLocation := TestScreenObject.Points[0];
  Dist := 0;
  if ParameterType = ptSFR then
  begin
    NearestStream := nil;
    for Index := 0 to frmGoPhast.PhastModel.ScreenObjectCount - 1 do
    begin
      AScreenObject := frmGoPhast.PhastModel.ScreenObjects[Index];
      if (AScreenObject <> TestScreenObject)
        and (AScreenObject.ModflowSfrBoundary <> nil)
        and AScreenObject.ModflowSfrBoundary.Used then
      begin
        TestLocation := AScreenObject.Points[AScreenObject.Count - 1];
        if NearestStream = nil then
        begin
          NearestStream := AScreenObject;
          Dist := Distance(TestLocation, InFlowLocation);
        end
        else
        begin
          TestDist := Distance(TestLocation, InFlowLocation);
          if TestDist < Dist then
          begin
            Dist := TestDist;
            NearestStream := AScreenObject;
          end;
        end;
      end;
    end;
    NearestLake := nil;
    if frmGoPhast.PhastModel.LakIsSelected then
    begin
      for Index := 0 to frmGoPhast.PhastModel.ScreenObjectCount - 1 do
      begin
        AScreenObject := frmGoPhast.PhastModel.ScreenObjects[Index];
        if (AScreenObject <> TestScreenObject)
           and (AScreenObject.ModflowLakBoundary <> nil)
           and AScreenObject.ModflowLakBoundary.Used then
        begin
          TestDist := AScreenObject.DistanceToScreenObject(
            InFlowLocation, TestLocation, 1, SectionIndex);
          if (NearestStream = nil) or (TestDist < Dist) then
          begin
            Dist := TestDist;
            NearestLake := AScreenObject;
          end;
        end;
      end;
    end;
    NewText := '';
    if NearestLake = nil then
    begin
      if (NearestStream = nil)  then
      begin
        Beep;
        MessageDlg(StrThereIsNoOtherSt, mtInformation, [mbOK], 0);
      end
      else
      begin
        Assert(NearestStream.ModflowSfrBoundary <> nil);
        NewText := IntToStr(NearestStream.ModflowSfrBoundary.SegmentNumber);
      end;
    end
    else
    begin
      Assert(NearestLake.ModflowLakBoundary <> nil);
      NewText := IntToStr(-NearestLake.ModflowLakBoundary.LakeID);
    end;
  end
  else
  begin
    Assert(ParameterType = ptSTR);
    NearestStream := nil;
    for Index := 0 to frmGoPhast.PhastModel.ScreenObjectCount - 1 do
    begin
      AScreenObject := frmGoPhast.PhastModel.ScreenObjects[Index];
      if (AScreenObject <> TestScreenObject)
        and (AScreenObject.ModflowStrBoundary <> nil)
        and AScreenObject.ModflowStrBoundary.Used then
      begin
        TestLocation := AScreenObject.Points[AScreenObject.Count - 1];
        if NearestStream = nil then
        begin
          NearestStream := AScreenObject;
          Dist := Distance(TestLocation, InFlowLocation);
        end
        else
        begin
          TestDist := Distance(TestLocation, InFlowLocation);
          if TestDist < Dist then
          begin
            Dist := TestDist;
            NearestStream := AScreenObject;
          end;
        end;
      end;
    end;
    if (NearestStream = nil)  then
    begin
      Beep;
      MessageDlg(StrThereIsNoOtherSteam, mtInformation, [mbOK], 0);
    end
    else
    begin
      Assert(NearestStream.ModflowStrBoundary <> nil);
      NewText := IntToStr(NearestStream.ModflowStrBoundary.SegmentNumber);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetNearestOutflowSegment(
  var NewText: string; ParameterType: TParameterType);
var
  NearestStream: TScreenObject;
  NearestLake: TScreenObject;
  TestScreenObject: TScreenObject;
begin
  if FScreenObject = nil then
  begin
    if FScreenObjectList.Count <> 1 then
    begin
      Beep;
      MessageDlg(StrSorryThisFunction, mtError, [mbOK], 0);
      Exit;
    end;
    Assert(FScreenObjectList.Count = 1);
    TestScreenObject := FScreenObjectList[0];
  end
  else
  begin
    TestScreenObject := FScreenObject;
  end;
  Assert(TestScreenObject <> nil);
  NewText := '';
  if ParameterType = ptSFR then
  begin
    frmGoPhast.PhastModel.LocateNearestLakeOrStream(TestScreenObject,
      NearestLake, NearestStream);
    if (NearestStream = nil) and (NearestLake = nil) then
    begin
      Beep;
      MessageDlg(StrThereIsNoOtherSt, mtInformation, [mbOK], 0);
    end
    else
    begin
      if NearestLake = nil then
      begin
        Assert(NearestStream.ModflowSfrBoundary <> nil);
        NewText := IntToStr(NearestStream.ModflowSfrBoundary.SegmentNumber);
      end
      else
      begin
        Assert(NearestLake.ModflowLakBoundary <> nil);
        NewText := IntToStr(-NearestLake.ModflowLakBoundary.LakeID);
      end;
    end;
  end
  else
  begin
    Assert(ParameterType = ptSTR);
    frmGoPhast.PhastModel.LocateNearestStrStream(TestScreenObject,
      NearestStream);
    if (NearestStream = nil)  then
    begin
      Beep;
      MessageDlg(StrThereIsNoOtherSteam, mtInformation, [mbOK], 0);
    end
    else
    begin
      Assert(NearestStream.ModflowStrBoundary <> nil);
      NewText := IntToStr(NearestStream.ModflowStrBoundary.SegmentNumber);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.SetGages(List: TList);
var
  Index: Integer;
  ScreenObject: TScreenObject;
  Gage: TStreamGage;
begin
  for Index := 0 to List.Count - 1 do
  begin
    ScreenObject := List[Index];
    Gage := ScreenObject.ModflowStreamGage;
    if (cbGageStandard.State = cbChecked) then
    begin
      if Gage = nil then
      begin
        ScreenObject.CreateGagBoundary;
        Gage := ScreenObject.ModflowStreamGage;
      end;
      Gage.Gage0 := True;
    end
    else if (Gage <> nil)
      and (cbGageStandard.State = cbUnchecked) then
    begin
      Gage.Gage0 := False;
    end;

    if (cbGage1.State = cbChecked) then
    begin
      if Gage = nil then
      begin
        ScreenObject.CreateGagBoundary;
        Gage := ScreenObject.ModflowStreamGage;
      end;
      Gage.Gage1 := True;
    end
    else if (Gage <> nil)
      and (cbGage1.State = cbUnchecked) then
    begin
      Gage.Gage1 := False;
    end;

    if (cbGage2.State = cbChecked) then
    begin
      if Gage = nil then
      begin
        ScreenObject.CreateGagBoundary;
        Gage := ScreenObject.ModflowStreamGage;
      end;
      Gage.Gage2 := True;
    end
    else if (Gage <> nil)
      and (cbGage2.State = cbUnchecked) then
    begin
      Gage.Gage2 := False;
    end;

    if (cbGage3.State = cbChecked) then
    begin
      if Gage = nil then
      begin
        ScreenObject.CreateGagBoundary;
        Gage := ScreenObject.ModflowStreamGage;
      end;
      Gage.Gage3 := True;
    end
    else if (Gage <> nil)
      and (cbGage3.State = cbUnchecked) then
    begin
      Gage.Gage3 := False;
    end;

    if (cbGage5.State = cbChecked) then
    begin
      if Gage = nil then
      begin
        ScreenObject.CreateGagBoundary;
        Gage := ScreenObject.ModflowStreamGage;
      end;
      Gage.Gage5 := True;
    end
    else if (Gage <> nil)
      and (cbGage5.State = cbUnchecked) then
    begin
      Gage.Gage5 := False;
    end;

    if (cbGage6.State = cbChecked) then
    begin
      if Gage = nil then
      begin
        ScreenObject.CreateGagBoundary;
        Gage := ScreenObject.ModflowStreamGage;
      end;
      Gage.Gage6 := True;
    end
    else if (Gage <> nil)
      and (cbGage6.State = cbUnchecked) then
    begin
      Gage.Gage6 := False;
    end;

    if (cbGage7.State = cbChecked) then
    begin
      if Gage = nil then
      begin
        ScreenObject.CreateGagBoundary;
        Gage := ScreenObject.ModflowStreamGage;
      end;
      Gage.Gage7 := True;
    end
    else if (Gage <> nil)
      and (cbGage7.State = cbUnchecked) then
    begin
      Gage.Gage7 := False;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.SetAllFluxObservations(List: TList);
begin
  SetFluxObservations(List, FChob_Node, frameCHOB, frmGoPhast.PhastModel.HeadFluxObservations);
  SetFluxObservations(List, FDrob_Node, frameDROB, frmGoPhast.PhastModel.DrainObservations);
  SetFluxObservations(List, FGbob_Node, frameGBOB, frmGoPhast.PhastModel.GhbObservations);
  SetFluxObservations(List, FRvob_Node, frameRVOB, frmGoPhast.PhastModel.RiverObservations);
  SetFluxObservations(List, FStob_Node, frameSTOB, frmGoPhast.PhastModel.StreamObservations);
  SetMt3dFluxObs(List);
end;

procedure TfrmScreenObjectProperties.SetMt3dFluxObs(List: TList);
var
  ObsList: TMt3dFluxGroupList;
  CheckState: TCheckBoxState;
begin
  if FMt3dmsTobFlux_Node = nil then
  begin
    Exit;
  end;
  ObsList := TMt3dFluxGroupList.Create;
  try
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsHeadMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsWellMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsDrnMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsRivMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsGhbMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsRchMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsEvtMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsMassLoadingMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsResMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsLakMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsDrtMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsEtsMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsStrMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsFhbHeadMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsFhbFlowMassFluxObservations);

    Assert(FMt3dmsTobFlux_Node.StateIndex in [1, 2, 3]);
    CheckState := TCheckBoxState(FMt3dmsTobFlux_Node.StateIndex - 1);
    frameMt3dmsFluxObs.SetData(List, ObsList, CheckState);
  finally
    ObsList.Free;
  end;

end;

procedure TfrmScreenObjectProperties.SetFluxObservations(List: TList;
   ANode: TJvPageIndexNode;
  AFrame: TframeFluxObs; FluxObservations: TFluxObservationGroups);
var
  CheckState: TCheckBoxState;
begin
  if ANode <> nil then
  begin
    Assert(ANode.StateIndex in [1, 2, 3]);
    CheckState := TCheckBoxState(ANode.StateIndex - 1);
    AFrame.SetData(List, FluxObservations, CheckState);
  end;
end;

procedure TfrmScreenObjectProperties.CreateFhbHeadNode;
var
  Node: TJvPageIndexNode;
begin
  FFhbHead_Node := nil;
  if frmGoPhast.PhastModel.FhbIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, 'Heads in ' +
      frmGoPhast.PhastModel.ModflowPackages.FhbPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspFhbHeads.PageIndex;
    frameFhbHead.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FFhbHead_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateFhbFlowNode;
var
  Node: TJvPageIndexNode;
begin
  FFhbFlow_Node := nil;
  if frmGoPhast.PhastModel.FhbIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, 'Flows in ' +
      frmGoPhast.PhastModel.ModflowPackages.FhbPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspFhbFlows.PageIndex;
    frameFhbFlow.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FFhbFlow_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateFluxNode(
  var NewNode: TJvPageIndexNode; FluxPackage: TModflowPackageSelection;
  AFrame: TframeFluxObs; APage: TJvStandardPage;
  FluxObservations: TFluxObservationGroups);
begin
  NewNode := nil;
  if frmGoPhast.PhastModel.PackageIsSelected(FluxPackage) then
  begin
    NewNode := jvtlModflowBoundaryNavigator.Items.AddChild(
      nil, FluxPackage.PackageIdentifier) as TJvPageIndexNode;
    NewNode.PageIndex := APage.PageIndex;
    AFrame.lblFluxObservations.Caption := NewNode.Text;
    NewNode.ImageIndex := 1;
  end;
end;

procedure TfrmScreenObjectProperties.GetHeadFluxObservations(
  const AScreenObjectList: TList);
begin
  GetFluxObservationsForFrame(FChob_Node, frmGoPhast.PhastModel.HeadFluxObservations,
    AScreenObjectList, frameCHOB);
end;

procedure TfrmScreenObjectProperties.GetDrainFluxObservations(
  const AScreenObjectList: TList);
begin
  GetFluxObservationsForFrame(FDrob_Node, frmGoPhast.PhastModel.DrainObservations,
    AScreenObjectList, frameDROB);
end;

procedure TfrmScreenObjectProperties.GetGhbFluxObservations(
  const AScreenObjectList: TList);
begin
  GetFluxObservationsForFrame(FGbob_Node, frmGoPhast.PhastModel.GhbObservations,
    AScreenObjectList, frameGBOB);
end;

procedure TfrmScreenObjectProperties.GetRiverFluxObservations(
  const AScreenObjectList: TList);
begin
  GetFluxObservationsForFrame(FRvob_Node, frmGoPhast.PhastModel.RiverObservations,
    AScreenObjectList, frameRvOB);
end;

procedure TfrmScreenObjectProperties.GetStreamFluxObservations(
  const AScreenObjectList: TList);
begin
  GetFluxObservationsForFrame(FStob_Node, frmGoPhast.PhastModel.StreamObservations,
    AScreenObjectList, frameSTOB);
end;

procedure TfrmScreenObjectProperties.GetSwrEvapBoundary(
  ScreenObjectList: TList);
var
  TimeList: TParameterTimeList;
  ColumnOffset: integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TSwrEvapBoundary;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  TimeIndex: Integer;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  State: TCheckBoxState;
//  First: Boolean;
begin
  if not frmGoPhast.PhastModel.SwrIsSelected then
  begin
    Exit;
  end;
  TimeList := TParameterTimeList.Create;
  try
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrEvap;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
    if FSWR_Evap_Node <> nil then
    begin
      FSWR_Evap_Node.StateIndex := Ord(State)+1;
    end;
//    First := True;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrEvap;
      // get all the times associated with the boundary.
      if Boundary <> nil then
      begin
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;

      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

    // display the times that are left.

    frameSWR_Evap.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameSWR_Evap.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;
      GetSwrEvapBoundaryCollection(DataGrid, ColumnOffset,
        ScreenObjectList, TimeList);
    finally
      DataGrid.EndUpdate;
    end;

  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetSwrLatInflowBoundary(
  ScreenObjectList: TList);
var
  TimeList: TParameterTimeList;
  ColumnOffset: integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TSwrLatInflowBoundary;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  TimeIndex: Integer;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  State: TCheckBoxState;
  First: Boolean;
begin
  if not frmGoPhast.PhastModel.SwrIsSelected then
  begin
    Exit;
  end;
  frameSWR_LatInfl.comboFormulaInterp.Enabled :=
    frmGoPhast.PhastModel.ModflowPackages.
    SwrPackage.LateralInflowSpecification = smObject;
  TimeList := TParameterTimeList.Create;
  try
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrLatInflow;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
    if FSWR_LatInflow_Node <> nil then
    begin
      FSWR_LatInflow_Node.StateIndex := Ord(State)+1;
    end;
    First := True;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrLatInflow;
      // get all the times associated with the boundary.
      if Boundary <> nil then
      begin
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;

        if First then
        begin
          frameSWR_LatInfl.comboFormulaInterp.ItemIndex :=
            Ord(Boundary.FormulaInterpretation);
          First := False;
        end
        else
        begin
          if frameSWR_LatInfl.comboFormulaInterp.ItemIndex <>
            Ord(Boundary.FormulaInterpretation) then
          begin
            frameSWR_LatInfl.comboFormulaInterp.ItemIndex := -1;
          end;
        end;
      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

    // display the times that are left.

    frameSWR_LatInfl.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameSWR_LatInfl.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;
      GetSwrLatInflowBoundaryCollection(DataGrid, ColumnOffset,
        ScreenObjectList, TimeList);
    finally
      DataGrid.EndUpdate;
    end;

  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetSwrRainBoundary(
  ScreenObjectList: TList);
var
  TimeList: TParameterTimeList;
  ColumnOffset: integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TSwrRainBoundary;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  TimeIndex: Integer;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  State: TCheckBoxState;
//  First: Boolean;
begin
  if not frmGoPhast.PhastModel.SwrIsSelected then
  begin
    Exit;
  end;
  TimeList := TParameterTimeList.Create;
  try
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrRain;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
    if FSWR_Rain_Node <> nil then
    begin
      FSWR_Rain_Node.StateIndex := Ord(State)+1;
    end;
//    First := True;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrRain;
      // get all the times associated with the boundary.
      if Boundary <> nil then
      begin
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

    // display the times that are left.

    frameSWR_Rain.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameSWR_Rain.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;
      GetSwrRainBoundaryCollection(DataGrid, ColumnOffset,
        ScreenObjectList, TimeList);
    finally
      DataGrid.EndUpdate;
    end;

  finally
    TimeList.Free;
  end;
end;


procedure TfrmScreenObjectProperties.GetSwrDirectRunoffBoundary(
  ScreenObjectList: TList);
var
  TimeList: TParameterTimeList;
  ColumnOffset: integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TSwrDirectRunoffBoundary;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  TimeIndex: Integer;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  State: TCheckBoxState;
//  First: Boolean;
begin
  if not frmGoPhast.PhastModel.SwrIsSelected then
  begin
    Exit;
  end;
  TimeList := TParameterTimeList.Create;
  try
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrDirectRunoff;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
    if FSWR_DirectRunoff_Node <> nil then
    begin
      FSWR_DirectRunoff_Node.StateIndex := Ord(State)+1;
    end;
//    First := True;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrDirectRunoff;
      // get all the times associated with the boundary.
      if Boundary <> nil then
      begin
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;

      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

    // display the times that are left.

    frameSWR_DirectRunoff.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameSWR_DirectRunoff.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;
      GetSwrDirectRunoffBoundaryCollection(DataGrid, ColumnOffset,
        ScreenObjectList, TimeList);
    finally
      DataGrid.EndUpdate;
    end;

  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetSwrStageBoundary(
  ScreenObjectList: TList);
var
  TimeList: TParameterTimeList;
  ColumnOffset: integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TSwrStageBoundary;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  TimeIndex: Integer;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  State: TCheckBoxState;
//  First: Boolean;
begin
  if not frmGoPhast.PhastModel.SwrIsSelected then
  begin
    Exit;
  end;
  TimeList := TParameterTimeList.Create;
  try
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrStage;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
    if FSWR_Stage_Node <> nil then
    begin
      FSWR_Stage_Node.StateIndex := Ord(State)+1;
    end;
//    First := True;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowSwrStage;
      // get all the times associated with the boundary.
      if Boundary <> nil then
      begin
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;

      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

    // display the times that are left.

    frameSWR_Stage.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameSWR_Stage.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;
      GetSwrStageBoundaryCollection(DataGrid, ColumnOffset,
        ScreenObjectList, TimeList);
    finally
      DataGrid.EndUpdate;
    end;

  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetSwrRainBoundaryCollection(
  DataGrid: TRbwDataGrid4; ColumnOffset: Integer; ScreenObjectList: TList;
  TimeList: TParameterTimeList);
var
  RowIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: Boolean;
  ScreenObjectIndex: Integer;
  AnotherBoundary: TModflowBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  BoundaryIndex: Integer;
begin
  AScreenObject := ScreenObjectList[0];
  Boundary := AScreenObject.ModflowSwrRain;
  if Boundary = nil then
  begin
    Values := nil;
  end
  else
  begin
    Values := Boundary.Values;
  end;
  ValuesIdentical := True;
  for ScreenObjectIndex := 1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowSwrRain;
    if (Boundary = nil) and (AnotherBoundary = nil) then
    begin
      ValuesIdentical := True;
    end
    else if (Boundary = nil) or (AnotherBoundary = nil) then
    begin
      ValuesIdentical := False;
    end
    else
    begin
      ValuesIdentical := Values.IsSame(AnotherBoundary.Values);
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Values <> nil) then
  begin
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
      RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
      Assert(RowIndex >= 1);
      for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex]
          := Item.BoundaryFormula[BoundaryIndex];
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetSwrStageBoundaryCollection(
  DataGrid: TRbwDataGrid4; ColumnOffset: Integer; ScreenObjectList: TList;
  TimeList: TParameterTimeList);
var
  RowIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: Boolean;
  ScreenObjectIndex: Integer;
  AnotherBoundary: TModflowBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  BoundaryIndex: Integer;
begin
  AScreenObject := ScreenObjectList[0];
  Boundary := AScreenObject.ModflowSwrStage;
  if Boundary = nil then
  begin
    Values := nil;
  end
  else
  begin
    Values := Boundary.Values;
  end;
  ValuesIdentical := True;
  for ScreenObjectIndex := 1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowSwrStage;
    if (Boundary = nil) and (AnotherBoundary = nil) then
    begin
      ValuesIdentical := True;
    end
    else if (Boundary = nil) or (AnotherBoundary = nil) then
    begin
      ValuesIdentical := False;
    end
    else
    begin
      ValuesIdentical := Values.IsSame(AnotherBoundary.Values);
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Values <> nil) then
  begin
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
      RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
      Assert(RowIndex >= 1);
      for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex]
          := Item.BoundaryFormula[BoundaryIndex];
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetSwrDirectRunoffBoundaryCollection(
  DataGrid: TRbwDataGrid4; ColumnOffset: Integer; ScreenObjectList: TList;
  TimeList: TParameterTimeList);
var
  RowIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: Boolean;
  ScreenObjectIndex: Integer;
  AnotherBoundary: TModflowBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  BoundaryIndex: Integer;
begin
  AScreenObject := ScreenObjectList[0];
  Boundary := AScreenObject.ModflowSwrDirectRunoff;
  if Boundary = nil then
  begin
    Values := nil;
  end
  else
  begin
    Values := Boundary.Values;
  end;
  ValuesIdentical := True;
  for ScreenObjectIndex := 1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowSwrDirectRunoff;
    if (Boundary = nil) and (AnotherBoundary = nil) then
    begin
      ValuesIdentical := True;
    end
    else if (Boundary = nil) or (AnotherBoundary = nil) then
    begin
      ValuesIdentical := False;
    end
    else
    begin
      ValuesIdentical := Values.IsSame(AnotherBoundary.Values);
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Values <> nil) then
  begin
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
      RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
      Assert(RowIndex >= 1);
      for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex]
          := Item.BoundaryFormula[BoundaryIndex];
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetSwrEvapBoundaryCollection(
  DataGrid: TRbwDataGrid4; ColumnOffset: Integer; ScreenObjectList: TList;
  TimeList: TParameterTimeList);
var
  RowIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: Boolean;
  ScreenObjectIndex: Integer;
  AnotherBoundary: TModflowBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  BoundaryIndex: Integer;
begin
  AScreenObject := ScreenObjectList[0];
  Boundary := AScreenObject.ModflowSwrEvap;
  if Boundary = nil then
  begin
    Values := nil;
  end
  else
  begin
    Values := Boundary.Values;
  end;
  ValuesIdentical := True;
  for ScreenObjectIndex := 1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowSwrEvap;
    if (Boundary = nil) and (AnotherBoundary = nil) then
    begin
      ValuesIdentical := True;
    end
    else if (Boundary = nil) or (AnotherBoundary = nil) then
    begin
      ValuesIdentical := False;
    end
    else
    begin
      ValuesIdentical := Values.IsSame(AnotherBoundary.Values);
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Values <> nil) then
  begin
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
      RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
      Assert(RowIndex >= 1);
      for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex]
          := Item.BoundaryFormula[BoundaryIndex];
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetSwrLatInflowBoundaryCollection(
  DataGrid: TRbwDataGrid4; ColumnOffset: Integer; ScreenObjectList: TList;
  TimeList: TParameterTimeList);
var
  RowIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: Boolean;
  ScreenObjectIndex: Integer;
  AnotherBoundary: TModflowBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  BoundaryIndex: Integer;
begin
  AScreenObject := ScreenObjectList[0];
  Boundary := AScreenObject.ModflowSwrLatInflow;
  if Boundary = nil then
  begin
    Values := nil;
  end
  else
  begin
    Values := Boundary.Values;
  end;
  ValuesIdentical := True;
  for ScreenObjectIndex := 1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowSwrLatInflow;
    if (Boundary = nil) and (AnotherBoundary = nil) then
    begin
      ValuesIdentical := True;
    end
    else if (Boundary = nil) or (AnotherBoundary = nil) then
    begin
      ValuesIdentical := False;
    end
    else
    begin
      ValuesIdentical := Values.IsSame(AnotherBoundary.Values);
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Values <> nil) then
  begin
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
      RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
      Assert(RowIndex >= 1);
      for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex]
          := Item.BoundaryFormula[BoundaryIndex];
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetMt3dmsFluxObservations(
  const AScreenObjectList: TList);
var
  ObsList: TMt3dFluxGroupList;
  UsedObjectCount: Integer;
begin
  if FMt3dmsTobFlux_Node = nil then
  begin
    Exit;
  end;
  frameMt3dmsFluxObs.InitializeControls;
  ObsList := TMt3dFluxGroupList.Create;
  try
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsHeadMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsWellMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsDrnMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsRivMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsGhbMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsRchMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsEvtMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsMassLoadingMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsResMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsLakMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsDrtMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsEtsMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsStrMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsFhbHeadMassFluxObservations);
    ObsList.Add(frmGoPhast.PhastModel.Mt3dmsFhbFlowMassFluxObservations);
    UsedObjectCount := frameMt3dmsFluxObs.GetData(AScreenObjectList, ObsList);
    if UsedObjectCount = 0 then
    begin
      FMt3dmsTobFlux_Node.StateIndex := 1;
    end
    else if UsedObjectCount = AScreenObjectList.Count then
    begin
      FMt3dmsTobFlux_Node.StateIndex := 2;
    end
    else
    begin
      FMt3dmsTobFlux_Node.StateIndex := 3;
    end;
  finally
    ObsList.Free;
  end;
end;


procedure TfrmScreenObjectProperties.GetFluxObservationsForFrame(Node: TJvPageIndexNode;
  FluxObservations: TFluxObservationGroups; const AScreenObjectList: TList;
  FluxFrame: TframeFluxObs);
var
  UsedObjectCount: Integer;
begin
  if Node = nil then
  begin
    Exit;
  end;
  FluxFrame.InitializeControls;
  UsedObjectCount := FluxFrame.GetData(AScreenObjectList, FluxObservations);
  if UsedObjectCount = 0 then
  begin
    Node.StateIndex := 1;
  end
  else if UsedObjectCount = AScreenObjectList.Count then
  begin
    Node.StateIndex := 2;
  end
  else
  begin
    Node.StateIndex := 3;
  end;
end;

procedure TfrmScreenObjectProperties.GetGages(ListOfScreenObjects: TList);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Gage: TStreamGage;
  procedure GrayCheck(CheckBox: TCheckBox);
  begin
    if CheckBox.Checked then
    begin
      CheckBox.AllowGrayed := True;
      CheckBox.State := cbGrayed;
    end;
  end;
begin
  cbGageStandard.AllowGrayed := False;
  cbGage1.AllowGrayed := False;
  cbGage2.AllowGrayed := False;
  cbGage3.AllowGrayed := False;
  cbGage5.AllowGrayed := False;
  cbGage6.AllowGrayed := False;
  cbGage7.AllowGrayed := False;
  for ScreenObjectIndex := 0 to ListOfScreenObjects.Count - 1 do
  begin
    ScreenObject := ListOfScreenObjects[ScreenObjectIndex];
    Gage := ScreenObject.ModflowStreamGage;
    if ScreenObjectIndex = 0 then
    begin
      if (Gage <> nil) and Gage.Used then
      begin
        cbGageStandard.Checked := Gage.Gage0;
        cbGage1.Checked := Gage.Gage1;
        cbGage2.Checked := Gage.Gage2;
        cbGage3.Checked := Gage.Gage3;
        cbGage5.Checked := Gage.Gage5;
        cbGage6.Checked := Gage.Gage6;
        cbGage7.Checked := Gage.Gage7;
      end
      else
      begin
        cbGageStandard.Checked := False;
        cbGage1.Checked := False;
        cbGage2.Checked := False;
        cbGage3.Checked := False;
        cbGage5.Checked := False;
        cbGage6.Checked := False;
        cbGage7.Checked := False;
      end;
    end
    else
    begin
      if (Gage <> nil) and Gage.Used then
      begin
        if cbGageStandard.Checked <> Gage.Gage0 then
        begin
          cbGageStandard.AllowGrayed := True;
          cbGageStandard.State := cbGrayed;
        end;
        if cbGage1.Checked <> Gage.Gage1 then
        begin
          cbGage1.AllowGrayed := True;
          cbGage1.State := cbGrayed;
        end;
        if cbGage2.Checked <> Gage.Gage2 then
        begin
          cbGage2.AllowGrayed := True;
          cbGage2.State := cbGrayed;
        end;
        if cbGage3.Checked <> Gage.Gage3 then
        begin
          cbGage3.AllowGrayed := True;
          cbGage3.State := cbGrayed;
        end;
        if cbGage5.Checked <> Gage.Gage5 then
        begin
          cbGage5.AllowGrayed := True;
          cbGage5.State := cbGrayed;
        end;
        if cbGage6.Checked <> Gage.Gage6 then
        begin
          cbGage6.AllowGrayed := True;
          cbGage6.State := cbGrayed;
        end;
        if cbGage7.Checked <> Gage.Gage7 then
        begin
          cbGage7.AllowGrayed := True;
          cbGage7.State := cbGrayed;
        end;
      end
      else
      begin
        GrayCheck(cbGageStandard);
        GrayCheck(cbGage1);
        GrayCheck(cbGage2);
        GrayCheck(cbGage3);
        GrayCheck(cbGage5);
        GrayCheck(cbGage6);
        GrayCheck(cbGage7);
      end;
    end;
  end;
  SetGageNodeStateIndex;
end;

procedure TfrmScreenObjectProperties.GetModpathParticles(ListOfScreenObjects: TList);
var
  Frame: TframeModpathParticles;
  Particles: TParticleStorage;
  GridParticles: TGridDistribution;
  CylParticles: TCylSphereDistribution;
  SphereParticles: TCylSphereDistribution;
  CustomParticles: TParticles;
  Index: Integer;
  Item: TParticleLocation;
  ScreenObject : TScreenObject;
  ScreenObjectIndex: Integer;
  UsedDistribution: Set of TParticleDistribution;
  CheckBox: TCheckBox;
  RowIndex: Integer;
  TimeItem: TModpathTimeItem;
  procedure UpdateRadioGroup(RadioGroup: TRadioGroup; Value: integer);
  begin
    if RadioGroup.ItemIndex <> Value then
    begin
      RadioGroup.ItemIndex := -1;
    end;
  end;
  procedure UpdateCheckBox(CheckBox: TCheckBox; Checked: boolean);
  begin
    if CheckBox.Checked <> Checked then
    begin
      CheckBox.AllowGrayed := True;
      CheckBox.State := cbGrayed;
    end;
  end;
  procedure UpdateIntegerSpinEdit(SpinEdit: TJvSpinEdit; Value: integer);
  begin
    if SpinEdit.AsInteger <> Value then
    begin
      SpinEdit.MinValue := 0;
      SpinEdit.AsInteger := 0;
    end;
  end;
  procedure UpdateFloatSpinEdit(SpinEdit: TJvSpinEdit; Value: double);
  begin
    if SpinEdit.Value <> Value then
    begin
      SpinEdit.MinValue := 0;
      SpinEdit.Value := 0;
    end;
  end;
  procedure AssignGridParticles;
  begin
    GridParticles := Particles.GridParticles;
    Frame.cbLeftFace.Checked := GridParticles.LeftFace;
    Frame.cbRightFace.Checked := GridParticles.RightFace;
    Frame.cbBackFace.Checked := GridParticles.BackFace;
    Frame.cbFrontFace.Checked := GridParticles.FrontFace;
    Frame.cbBottomFace.Checked := GridParticles.BottomFace;
    Frame.cbTopFace.Checked := GridParticles.TopFace;
    Frame.cbInternal.Checked := GridParticles.Internal;
    Frame.seX.AsInteger := GridParticles.XCount;
    Frame.seY.AsInteger := GridParticles.YCount;
    Frame.seZ.AsInteger := GridParticles.ZCount;
  end;
  procedure AssignCylinderParticles;
  begin
    CylParticles := Particles.CylinderParticles;
    Frame.rgCylinderOrientation.ItemIndex := Ord(CylParticles.Orientation);
    Frame.seCylParticleCount.AsInteger := CylParticles.CircleParticleCount;
    Frame.seCylLayerCount.AsInteger := CylParticles.LayerCount;
    Frame.seCylRadius.Value := CylParticles.Radius;
  end;
  procedure AssignSphereParticles;
  begin
    SphereParticles := Particles.SphereParticles;
    Frame.rgSphereOrientation.ItemIndex := Ord(SphereParticles.Orientation);
    Frame.seSphereParticleCount.AsInteger := SphereParticles.CircleParticleCount;
    Frame.seSphereLayerCount.AsInteger := SphereParticles.LayerCount;
    Frame.seSphereRadius.Value := SphereParticles.Radius;
  end;
  procedure AssignCustomParticles;
  var
    Index: integer;
    Item: TParticleLocation;
  begin
    CustomParticles := Particles.CustomParticles;
    Frame.seSpecificParticleCount.AsInteger := CustomParticles.Count;
    frameModpathParticlesseSpecificParticleCountChange(nil);
    for Index := 0 to CustomParticles.Count - 1 do
    begin
      Item := CustomParticles.Items[Index] as TParticleLocation;
      Frame.rdgSpecific.Cells[1, Index + 1] := FloatToStr(Item.X);
      Frame.rdgSpecific.Cells[2, Index + 1] := FloatToStr(Item.Y);
      Frame.rdgSpecific.Cells[3, Index + 1] := FloatToStr(Item.Z);
    end;
  end;
begin
  Frame := frameModpathParticles;
  Frame.TrackingDirection := frmGoPhast.PhastModel.
    ModflowPackages.ModPath.TrackingDirection;
  Frame.MPathVersion := frmGoPhast.PhastModel.
    ModflowPackages.ModPath.MPathVersion;
  UsedDistribution := [];
  for ScreenObjectIndex := 0 to ListOfScreenObjects.Count - 1 do
  begin
    ScreenObject := ListOfScreenObjects[ScreenObjectIndex];
    Particles := ScreenObject.ModpathParticles;

    if not Particles.Used then
    begin
      if ScreenObjectIndex = 0 then
      begin
        Frame.gbParticles.Checked := False;
      end
      else
      begin
        CheckBox := Frame.gbParticles.Components[0] as TCheckBox;
        if CheckBox.State = cbChecked then
        begin
          CheckBox.AllowGrayed := True;
          CheckBox.State := cbGrayed;
        end;
      end;
    end
    else
    begin
      if ScreenObjectIndex = 0 then
      begin
        Frame.gbParticles.Checked := True;
      end
      else
      begin
        CheckBox := Frame.gbParticles.Components[0] as TCheckBox;
        if CheckBox.State = cbUnChecked then
        begin
          CheckBox.AllowGrayed := True;
          CheckBox.State := cbGrayed;
        end;
      end;

      if UsedDistribution = [] then
      begin
        Frame.rgChoice.ItemIndex := Ord(Particles.ParticleDistribution);
      end
      else
      begin
        UpdateRadioGroup(Frame.rgChoice, Ord(Particles.ParticleDistribution));
      end;
      if not (Particles.ParticleDistribution in UsedDistribution) then
      begin
        Include(UsedDistribution, Particles.ParticleDistribution);
        case Particles.ParticleDistribution of
          pdGrid: AssignGridParticles;
          pdCylinder: AssignCylinderParticles;
          pdSphere: AssignSphereParticles;
          pdIndividual: AssignCustomParticles;
          else Assert(False);
        end;
        Frame.seTimeCount.AsInteger := Particles.ReleaseTimes.Count;
        Frame.UpdateTimeRowCount;
        for RowIndex := 0 to Particles.ReleaseTimes.Count - 1 do
        begin
          TimeItem := Particles.ReleaseTimes.Items[RowIndex] as TModpathTimeItem;
          Frame.rdgReleaseTimes.Cells[1,RowIndex+1] := FloatToStr(TimeItem.Time);
        end;
      end
      else
      begin
        case Particles.ParticleDistribution of
          pdGrid:
            begin
              GridParticles := Particles.GridParticles;
              UpdateCheckBox(Frame.cbLeftFace, GridParticles.LeftFace);
              UpdateCheckBox(Frame.cbRightFace, GridParticles.RightFace);
              UpdateCheckBox(Frame.cbBackFace, GridParticles.BackFace);
              UpdateCheckBox(Frame.cbFrontFace, GridParticles.FrontFace);
              UpdateCheckBox(Frame.cbBottomFace, GridParticles.BottomFace);
              UpdateCheckBox(Frame.cbTopFace, GridParticles.TopFace);
              UpdateCheckBox(Frame.cbInternal, GridParticles.Internal);
              UpdateIntegerSpinEdit(Frame.seX, GridParticles.XCount);
              UpdateIntegerSpinEdit(Frame.seY, GridParticles.YCount);
              UpdateIntegerSpinEdit(Frame.seZ, GridParticles.ZCount);
            end;
          pdCylinder:
            begin
              CylParticles := Particles.CylinderParticles;
              UpdateRadioGroup(Frame.rgCylinderOrientation, Ord(CylParticles.Orientation));
              UpdateIntegerSpinEdit(Frame.seCylParticleCount, CylParticles.CircleParticleCount);
              UpdateIntegerSpinEdit(Frame.seCylLayerCount, CylParticles.LayerCount);
              UpdateFloatSpinEdit(Frame.seCylRadius, CylParticles.Radius);
            end;
          pdSphere:
            begin
              SphereParticles := Particles.SphereParticles;
              UpdateRadioGroup(Frame.rgSphereOrientation, Ord(SphereParticles.Orientation));
              UpdateIntegerSpinEdit(Frame.seSphereParticleCount, SphereParticles.CircleParticleCount);
              UpdateIntegerSpinEdit(Frame.seSphereLayerCount, SphereParticles.LayerCount);
              UpdateFloatSpinEdit(Frame.seSphereRadius, SphereParticles.Radius);
            end;
          pdIndividual:
            begin
              CustomParticles := Particles.CustomParticles;
              if Frame.seSpecificParticleCount.AsInteger <> CustomParticles.Count then
              begin
                Frame.seSpecificParticleCount.MinValue := -1;
                Frame.seSpecificParticleCount.AsInteger := -1;
                frameModpathParticlesseSpecificParticleCountChange(nil);
              end
              else
              begin
                for Index := 0 to CustomParticles.Count - 1 do
                begin
                  Item := CustomParticles.Items[Index] as TParticleLocation;
                  if Frame.rdgSpecific.Cells[1, Index + 1] <> FloatToStr(Item.X) then
                  begin
                    Frame.rdgSpecific.Cells[1, Index + 1] := '';
                  end;
                  if Frame.rdgSpecific.Cells[2, Index + 1] <> FloatToStr(Item.Y) then
                  begin
                    Frame.rdgSpecific.Cells[2, Index + 1] := '';
                  end;
                  if Frame.rdgSpecific.Cells[3, Index + 1] <> FloatToStr(Item.Z) then
                  begin
                    Frame.rdgSpecific.Cells[4, Index + 1] := '';
                  end;
                end;
              end;
            end;
          else Assert(False);
        end;
        UpdateIntegerSpinEdit(Frame.seTimeCount,
          Particles.ReleaseTimes.Count);
        Frame.UpdateTimeRowCount;
        if Frame.seTimeCount.AsInteger >= 1 then
        begin
          for RowIndex := 0 to Particles.ReleaseTimes.Count - 1 do
          begin
            TimeItem := Particles.ReleaseTimes.Items[RowIndex] as TModpathTimeItem;
            if Frame.rdgReleaseTimes.Cells[1,RowIndex+1] <>
              FloatToStr(TimeItem.Time) then
            begin
              Frame.rdgReleaseTimes.Cells[1,RowIndex+1] := '';
            end;
          end;
        end;

      end;
    end;
  end;
  frameModpathParticlesgbParticlesCheckBoxClick(nil);
  frameModpathParticles.CreateParticles;
end;

procedure TfrmScreenObjectProperties.GetIFaceForAdditionalObject(AScreenObject: TScreenObject);
begin
  if frameIFACE.IFACE <> AScreenObject.IFACE then
  begin
    frameIFACE.IFACE := iIndeterminant;
  end;
end;

procedure TfrmScreenObjectProperties.AssignConductanceCaptions(
  Frame: TframeScreenObjectCondParam; Boundary: TSpecificModflowBoundary);
var
  ColIndex: Integer;
  Index: Integer;
  Param: TModflowParameter;
  TimeList: TModflowTimeList;
begin
  ColIndex := -1;
  for Index := 0 to Frame.dgModflowBoundary.ColCount - 1 do
  begin
    if Frame.dgModflowBoundary.Objects[Index, 0] <> nil then
    begin
      ColIndex := Index + Frame.ConductanceColumn;
      break;
    end;
  end;
  if ColIndex >= 0 then
  begin
    while ColIndex < Frame.dgModflowBoundary.ColCount do
    begin
      Param := Frame.dgModflowBoundary.Objects[
        ColIndex - Frame.ConductanceColumn, 0] as TModflowParameter;
      Frame.dgModflowBoundary.Cells[ColIndex, 0] :=
        Param.ParameterName + Frame.ParamColumnCaption(Frame.ConductanceColumn);
      Inc(ColIndex, Frame.ParameterColumnSuffix.Count);
    end;
  end;
  if (Boundary <> nil) and Boundary.Used then
  begin
    TimeList := Boundary.Values.TimeLists[Frame.ConductanceColumn, frmGoPhast.PhastModel];
    Frame.dgModflowBoundary.Cells[Frame.ConductanceColumn + 2, 0] :=
      Frame.ConductanceCaption(TimeList.NonParamDescription);
  end;
end;

function TfrmScreenObjectProperties.GetLowerCoordinateCaption(
  const AScreenObject: TScreenObject): string;
begin
  result := AScreenObject.LowerCoordinateCaption;
//  case AScreenObject.ViewDirection of
//    vdTop:
//      begin
//        result := StrLowerZcoordinate;
//      end;
//    vdFront:
//      begin
//        result := StrLowerYcoordinate;
//      end;
//    vdSide:
//      begin
//        result := StrLowerXcoordinate;
//      end;
//  else
//    begin
//      Assert(False);
//    end;
//  end;
end;

function TfrmScreenObjectProperties.GetHigherCoordinateCaption(
  const AScreenObject: TScreenObject): string;
begin
  result := AScreenObject.HigherCoordinateCaption;
//  case AScreenObject.ViewDirection of
//    vdTop:
//      begin
//        result := StrHigherZcoordinate;
//      end;
//    vdFront:
//      begin
//        result := StrHigherYcoordinate;
//      end;
//    vdSide:
//      begin
//        result := StrHigherXcoordinate;
//      end;
//  else
//    begin
//      Assert(False);
//    end;
//  end;
end;

function TfrmScreenObjectProperties.GetCoordinateCaption(
  const AScreenObject: TScreenObject): string;
begin
  result := AScreenObject.CoordinateCaption;
//  case AScreenObject.ViewDirection of
//    vdTop:
//      begin
//        result := StrZcoordinate;
//      end;
//    vdFront:
//      begin
//        result := StrYcoordinate;
//      end;
//    vdSide:
//      begin
//        result := StrXcoordinate;
//      end;
//  else
//    begin
//      Assert(False);
//    end;
//  end;
end;

procedure TfrmScreenObjectProperties.AssignImportedValuesColumn(
  var First: boolean; var ColIndex: Integer; ValueStorage: TValueArrayStorage;
  const ColumnCaption: string);
var
  ValueIndex: Integer;
  RowCount: Integer;
  RowIndex: Integer;
  ExistingCount: Integer;
begin
  Inc(ColIndex);
  RowCount := ValueStorage.Count + 1;
  rdgImportedData.Objects[ColIndex, 0] := ValueStorage;
  if First then
  begin
    rdgImportedData.RowCount := RowCount;
    First := False;
    for RowIndex := 1 to rdgImportedData.RowCount - 1 do
    begin
      rdgImportedData.Cells[0,RowIndex] := IntToStr(RowIndex);
    end;
  end
  else
  begin
    if rdgImportedData.RowCount < RowCount then
    begin
      ValueStorage.Count := rdgImportedData.RowCount-1;
      RowCount := ValueStorage.Count + 1;
      Beep;
      MessageDlg(Format(StrThereAreTooManyI, [ColumnCaption]), mtWarning, [mbOK], 0);
    end
    else if rdgImportedData.RowCount > RowCount then
    begin
      Beep;
      MessageDlg(Format(StrThereAreTooFewIm, [ColumnCaption]), mtWarning, [mbOK], 0);
      ExistingCount := ValueStorage.Count;
      ValueStorage.Count := rdgImportedData.RowCount-1;
      case ValueStorage.DataType of
        rdtDouble:
          begin
            for ValueIndex := ExistingCount+1 to ValueStorage.Count - 1 do
            begin
              ValueStorage.RealValues[ValueIndex] := 0;
            end;
          end;
        rdtInteger:
          begin
            for ValueIndex := ExistingCount+1 to ValueStorage.Count - 1 do
            begin
              ValueStorage.IntValues[ValueIndex] := 0;
            end;
          end;
        rdtBoolean:
          begin
            for ValueIndex := ExistingCount+1 to ValueStorage.Count - 1 do
            begin
              ValueStorage.BooleanValues[ValueIndex] := False;
            end;
          end;
        rdtString:
          begin
            for ValueIndex := ExistingCount+1 to ValueStorage.Count - 1 do
            begin
              ValueStorage.StringValues[ValueIndex] := '""';
            end;
          end;
      end;
      RowCount := ValueStorage.Count + 1;
    end;
    Assert(rdgImportedData.RowCount = RowCount)
  end;
  rdgImportedData.Cells[ColIndex, 0] := ColumnCaption;
  case ValueStorage.DataType of
    rdtDouble: rdgImportedData.Columns[ColIndex].Format := rcf4Real;
    rdtInteger: rdgImportedData.Columns[ColIndex].Format := rcf4Integer;
    rdtBoolean: rdgImportedData.Columns[ColIndex].Format := rcf4Boolean;
    rdtString:
      begin
        rdgImportedData.Columns[ColIndex].Format := rcf4String;
        rdgImportedData.Columns[ColIndex].AutoAdjustColWidths:= False;
      end
    else Assert(False);
  end;
  for ValueIndex := 0 to ValueStorage.Count - 1 do
  begin
    case ValueStorage.DataType of
      rdtDouble:
        begin
          rdgImportedData.Cells[ColIndex, ValueIndex + 1] :=
            FloatToStr(ValueStorage.RealValues[ValueIndex]);
        end;
      rdtInteger:
        begin
          rdgImportedData.Cells[ColIndex, ValueIndex + 1] :=
            IntToStr(ValueStorage.IntValues[ValueIndex]);
        end;
      rdtBoolean:
        begin
          rdgImportedData.Checked[ColIndex, ValueIndex + 1] :=
            ValueStorage.BooleanValues[ValueIndex];
        end;
      rdtString:
        begin
          rdgImportedData.Cells[ColIndex, ValueIndex + 1] :=
            ValueStorage.StringValues[ValueIndex];
        end;
    else
      Assert(False);
    end;
  end;
  ValueStorage.CacheData;
end;

procedure TfrmScreenObjectProperties.SetDisabledElevationFormulas(
  FirstScreenObject: TScreenObject);
var
  EvalAt: TEvaluatedAt;
begin
  if rgEvaluatedAt.ItemIndex >= 0 then
  begin
    EvalAt := TEvaluatedAt(rgEvaluatedAt.ItemIndex);
  end
  else
  begin
    EvalAt := eaBlocks;
  end;
  if not edZ.Enabled then
  begin
    edZ.Text := frmGoPhast.PhastModel.DefaultElevationFormula(
      FirstScreenObject.ViewDirection, EvalAt);
  end;
  if not edHighZ.Enabled then
  begin
    edHighZ.Text := frmGoPhast.PhastModel.DefaultHigherElevationFormula(
      FirstScreenObject.ViewDirection, EvalAt);
  end;
  if not edLowZ.Enabled then
  begin
    edLowZ.Text := frmGoPhast.PhastModel.DefaultLowerElevationFormula(
      FirstScreenObject.ViewDirection, EvalAt);
  end;
end;

procedure TfrmScreenObjectProperties.DisableAllowGrayed(CheckBox: TCheckBox);
begin
  if CheckBox.State = cbGrayed then
  begin
    CheckBox.AllowGrayed := False;
    CheckBox.State := cbChecked;
  end;
end;

procedure TfrmScreenObjectProperties.AssignHfbFormulas(Ed: TEdit);
var
  NewFormula: string;
  NewValue: string;
  OldFormula: string;
begin
  OldFormula := Ed.Text;
  NewValue := OldFormula;
  with TfrmFormula.Create(self) do
  begin
    try
      IncludeGIS_Functions(eaBlocks);
      RemoveGetVCont;
      RemoveHufFunctions;
      PopupParent := self;
      // show the variables and functions
      UpdateTreeList;
      // put the formula in the TfrmFormula.
      Formula := NewValue;
      // The user edits the formula.
      ShowModal;
      if ResultSet then
      begin
        NewFormula := Formula;
        Ed.Text := NewFormula;
      end;
    finally
      Free;
    end;
  end;
    // Don't allow the user to click the OK button if any formulas are invalid.
//    EnableOK_Button;
end;

procedure TfrmScreenObjectProperties.SetSelectedName;
var
  SelectedEdit: TScreenObjectDataEdit;
begin
  if tvDataSets.Selected = nil then
  begin
    FSelectedDataArrayName := '';
  end
  else
  begin
    SelectedEdit := tvDataSets.Selected.Data;
    if SelectedEdit = nil then
    begin
      FSelectedDataArrayName := '';
    end
    else
    begin
      if SelectedEdit.DataArray = nil then
      begin
        FSelectedDataArrayName := '';
      end
      else
      begin
        FSelectedDataArrayName := SelectedEdit.DataArray.Name;
      end;
    end;
  end;
end;


procedure TfrmScreenObjectProperties.UpdateDataSetTreeViewNodeStates;
var
  ChildState: Integer;
  ChildNode: TTreeNode;
  Node: TTreeNode;
  Index: Integer;
begin
  for Index := tvDataSets.Items.Count - 1 downto 0 do
  begin
    Node := tvDataSets.Items[Index];
    if Node.HasChildren then
    begin
      ChildNode := Node.getFirstChild;
      ChildState := ChildNode.StateIndex;
      while ChildNode <> nil do
      begin
        ChildNode := ChildNode.getNextSibling;
        if ChildNode = nil then
          break;
        if ChildState <> ChildNode.StateIndex then
        begin
          ChildState := Ord(cbGrayed) + 1;
          break;
        end;
      end;
      Node.StateIndex := ChildState;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.InvalidateAllDataSets;
var
  Edit: TScreenObjectDataEdit;
  Index: Integer;
begin
  for Index := 0 to FDataEdits.Count - 1 do
  begin
    Edit := FDataEdits[Index];
    if Edit.Used <> cbUnChecked then
    begin
      Edit.Invalidate;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.UpdateScreenObjectData;
var
  DataEditIndex: Integer;
  ScreenObject: TScreenObject;
  Item: TScreenObjectEditItem;
  Index: Integer;
  ExistingItem: TInterpValuesItem;
  UpdatedItem: TInterpValuesItem;
  FormulaPosition: Integer;
  Formula: string;
  DataSetFormula: string;
  SpecialCase: Boolean;
  Used: TCheckBoxState;
  UseDataArray: Boolean;
  Edit: TScreenObjectDataEdit;
  Boundary: TLakBoundary;
  AScreenObject: TScreenObject;
begin
  Assert(FNewProperties <> nil);
  if (FNewProperties.Count = 1) and (FScreenObjectList <> nil) then
  begin
    AScreenObject := FScreenObjectList[0];
    Item := FNewProperties[0];
    ScreenObject := Item.ScreenObject;
    if AScreenObject.ImportedValues.Count > 0 then
    begin
      ScreenObject.ImportedValues := AScreenObject.ImportedValues;
    end;
    if AScreenObject.ImportedSectionElevations.Count > 0 then
    begin
      AScreenObject.ImportedSectionElevations :=
        AScreenObject.ImportedSectionElevations;
    end;
    if AScreenObject.ImportedHigherSectionElevations.Count > 0 then
    begin
      AScreenObject.ImportedHigherSectionElevations :=
        AScreenObject.ImportedHigherSectionElevations;
    end;
    if AScreenObject.ImportedLowerSectionElevations.Count > 0 then
    begin
      AScreenObject.ImportedLowerSectionElevations :=
        AScreenObject.ImportedLowerSectionElevations;
    end;
    ScreenObject.Comment := memoComments.Text;
    AScreenObject.Comment := memoComments.Text;
    SetVertexValues(ScreenObject);
  end;
  for Index := 0 to FNewProperties.Count - 1 do
  begin
    Item := FNewProperties[Index];
    ScreenObject := Item.ScreenObject;
    Assert(ScreenObject <> nil);
    for DataEditIndex := 0 to FDataEdits.Count - 1 do
    begin
      Edit := FDataEdits[DataEditIndex];
      if not Edit.ShouldUpdateDataSet then
      begin
        Continue;
      end;
      UseDataArray := False;
      Used := Edit.Used;
      SpecialCase := False;
      if UpperCase(Edit.DataArray.Name) = UpperCase(rsModflowSpecifiedHead) then
      begin
        SpecialCase := True;
        if frameChdParam.seNumberOfTimes.Value > 0 then
        begin
          Used := cbChecked;
        end
        else
        begin
          Used := cbUnChecked;
        end;
        DataSetFormula := 'True';
      end
      else if UpperCase(Edit.DataArray.Name) = UpperCase(StrUzfGage_1_and_2) then
      begin
        SpecialCase := True;
        if cbUzfGage1.Checked then
        begin
          Used := cbChecked;
        end
        else
        begin
          Used := cbUnChecked;
        end;
        if cbUzfGage1.Checked then
        begin
          if cbUzfGage2.Checked then
          begin
            DataSetFormula := '2';
          end
          else
          begin
            DataSetFormula := '1';
          end;
        end
        else
        begin
          DataSetFormula := '0';
        end;
      end
      else if UpperCase(Edit.DataArray.Name) = UpperCase(StrUzfGage3) then
      begin
        SpecialCase := True;
        if cbUzfGage3.Checked then
        begin
          Used := cbChecked;
        end
        else
        begin
          Used := cbUnChecked;
        end;
        if cbUzfGage3.Checked then
        begin
          DataSetFormula := '3';
        end
        else
        begin
          DataSetFormula := '0';
        end;
      end
      else if UpperCase(Edit.DataArray.Name) = UpperCase(rsLakeID) then
      begin
        Boundary := ScreenObject.ModflowLakBoundary;
        if (Boundary <> nil) and ShouldStoreBoundary(FLAK_Node, Boundary) then
        begin
          Used := cbChecked;
        end
        else
        begin
          Used := cbUnChecked;
        end;
        if Used = cbChecked then
        begin
          DataSetFormula := IntToStr(Boundary.LakeID);
          if DataSetFormula = '0' then
          begin
            Used := cbUnChecked;
          end;
        end;
      end;

      case Used of
        cbUnchecked:
          begin
            UseDataArray := False;
          end;
        cbChecked:
          begin
            UseDataArray := True;
          end;
        cbGrayed:
          begin
            UseDataArray := ScreenObject.IndexOfDataSet(Edit.DataArray) >= 0;
          end;
      else
        Assert(False);
      end;
      if not UseDataArray then
      begin
        ScreenObject.RemoveDataSet(Edit.DataArray);
      end
      else
      begin
        if SpecialCase then
        begin
          Formula := DataSetFormula;
        end
        else
        begin
          Formula := Edit.Formula;
        end;
        FormulaPosition := ScreenObject.IndexOfDataSet(Edit.DataArray);
        if FormulaPosition < 0 then
        begin
          FormulaPosition := ScreenObject.AddDataSet(Edit.DataArray);
          if Formula = '' then
          begin
            Formula := Edit.DataArray.Formula;
          end;
        end;
        if Formula <> '' then
        begin
          ScreenObject.DataSetFormulas[FormulaPosition] := Formula;
        end;
        if Edit.DataArray is TCustomPhastDataSet then
        begin
          UpdatedItem := Edit.InterpValue.Items[Index] as TInterpValuesItem;
          ExistingItem := ScreenObject.InterpValues.ItemOfDataSet[Edit.DataArray];
          ExistingItem.Assign(UpdatedItem);
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.UpdateCurrentEdit;
var
  Edit: TScreenObjectDataEdit;
  Index: Integer;
  InterpValue: TInterpValuesItem;
  ChemDataSets: TList;
begin
  if not IsLoaded then
  begin
    Exit;
  end;
  FUpdatingCurrentEdit := True;
  try
    reDataSetComment.Lines.Clear;
    reAssocModDataSets.Lines.Clear;
    // Check that the formula entered for the previous
    // data set is correct.
    if FCurrentEdit <> nil then
    begin
      ValidateDataSetFormula;
    end;
    // Change the FCurrentEdit to the one for the new
    // data set that is being edited.
    if tvDataSets.Selected = nil then
    begin
      reDataSetFormula.Enabled := False;
      framePhastInterpolationData.Enabled := False;
      reDataSetFormula.Text := '';
      FCurrentEdit := nil;
    end
    else
    begin
      Edit := tvDataSets.Selected.Data;
      FCurrentEdit := Edit;
      if Edit = nil then
      begin
        reDataSetFormula.Enabled := False;
        reDataSetFormula.Text := '';
        framePhastInterpolationData.Enabled := False;
      end
      else
      begin
        if Edit.Used = cbUnchecked then
        begin
          reDataSetFormula.Enabled := False;
          reDataSetFormula.Text := '';
        end
        else
        begin
          reDataSetFormula.Enabled := True;
          reDataSetFormula.Text := Edit.Formula;
          ValidateDataSetFormula;
        end;
        if (Edit.DataArray is TCustomPhastDataSet)
          and (frmGoPhast.PhastModel.ModelSelection = msPhast) then
        begin
          framePhastInterpolationData.Enabled := Edit.Used <> cbUnChecked;
          for Index := 0 to Edit.InterpValue.Count - 1 do
          begin
            InterpValue := Edit.InterpValue.Items[Index] as TInterpValuesItem;
            if Index = 0 then
            begin
              framePhastInterpolationData.AssigningValues := True;
              framePhastInterpolationData.GetFirstData(InterpValue.Values);
              framePhastInterpolationData.AssigningValues := False;
            end
            else
            begin
              framePhastInterpolationData.AssigningValues := True;
              framePhastInterpolationData.GetMoreData(InterpValue.Values);
              framePhastInterpolationData.AssigningValues := False;
            end;
          end;
          ChemDataSets := TList.Create;
          try
            ChemDataSets.Add(frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(rsChemistry_Initial_Solution));
            ChemDataSets.Add(frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(rsChemistry_Initial_Equilibrium_Phases));
            ChemDataSets.Add(frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(rsChemistry_Initial_Surface));
            ChemDataSets.Add(frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(rsChemistry_Initial_Exchange));
            ChemDataSets.Add(frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(rsChemistry_Initial_Gas_Phase));
            ChemDataSets.Add(frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(rsChemistry_Initial_Solid_Solutions));
            ChemDataSets.Add(frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(rsChemistry_Initial_Kinetics));
            framePhastInterpolationData.SetMixtureAllowed(ChemDataSets.IndexOf(Edit.DataArray) >= 0);
          finally
            ChemDataSets.Free;
          end;
        end
        else
        begin
          framePhastInterpolationData.Enabled := False;
        end;
        if Edit.DataArray <> nil then
        begin
          reDataSetComment.Lines.Add(Edit.DataArray.Comment);
          reAssocModDataSets.Lines.Add(Edit.DataArray.AssociatedDataSets);
        end;
      end;
    end;
    btnDataSetFormula.Enabled := reDataSetFormula.Enabled;
    UpdateDataSetTreeViewNodeStates;
  finally
    FUpdatingCurrentEdit := False;
  end;
end;

procedure TfrmScreenObjectProperties.CheckIfDataSetUsedInElevationFormula(
  var CreateNode: Boolean; DataSet: TDataArray; ElevationFormula: string;
  Ed: TRbwEdit);
var
  Compiler: TRbwParser;
  Expression: TExpression;
begin
  if Ed.Text <> '' then
  begin
    ElevationFormula := Ed.Text;
  end;
  Compiler := GetElevationCompiler;
  try
    Compiler.Compile(ElevationFormula);
    CreateNode := ElevationFormula <> DataSet.Name;
    if CreateNode then
    begin
      Expression := Compiler.CurrentExpression;
      CreateNode := Expression.VariablesUsed.IndexOf(DataSet.Name) <= 0;
    end;
  except
    on ERbwParserError do
    begin
    end;
  end;
end;

procedure TfrmScreenObjectProperties.clbChildModelsClickCheck(Sender: TObject);
var
  ChildModel: TChildModel;
  ItemIndex: Integer;
  Item: TScreenObjectEditItem;
begin
  inherited;
  ChildModel := clbChildModels.Items.Objects[
    clbChildModels.CheckedIndex] as TChildModel;
  if ChildModel <> nil then
  begin
    ChildModel.CanUpdateGrid := False;
  end;

  if FScreenObject <> nil then
  begin
    FScreenObject.ChildModel := ChildModel;
  end
  else
  begin
    for ItemIndex := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[ItemIndex];
      Item.ScreenObject.ChildModel := ChildModel;
    end;
  end;

end;

procedure TfrmScreenObjectProperties.clbLgrUsedModelsClickCheck(
  Sender: TObject);
var
  Model: TCustomModel;
  ItemIndex: Integer;
  UsedsModels: TUsedWithModelCollection;
  ModelIndex: Integer;
  AllUsed: Boolean;
begin
  inherited;
  if IsLoaded then
  begin
    if clbLgrUsedModels.State[clbLgrUsedModels.ItemIndex] = cbGrayed then
    begin
      clbLgrUsedModels.State[clbLgrUsedModels.ItemIndex] := cbChecked
    end;
    AllUsed := True;
    for ModelIndex := 0 to clbLgrUsedModels.Items.Count - 1 do
    begin
      Model := clbLgrUsedModels.Items.Objects[ModelIndex] as TCustomModel;
      for ItemIndex := 0 to FNewProperties.Count - 1 do
      begin
        UsedsModels := FNewProperties[ItemIndex].ScreenObject.UsedModels;
        if clbLgrUsedModels.State[ModelIndex] = cbChecked then
        begin
          UsedsModels.AddModel(Model);
        end
        else if clbLgrUsedModels.State[ModelIndex] = cbUnChecked then
        begin
          UsedsModels.RemoveModel(Model);
          AllUsed := False;
        end;
      end;
      if FScreenObject <> nil then
      begin
        UsedsModels := FScreenObject.UsedModels;
        if clbLgrUsedModels.State[ModelIndex] = cbChecked then
        begin
          UsedsModels.AddModel(Model);
        end
        else if clbLgrUsedModels.State[ModelIndex] = cbUnChecked then
        begin
          UsedsModels.RemoveModel(Model);
          AllUsed := False;
        end;
      end;
    end;
    if not AllUsed then
    begin
      cbLgrAllModels.Checked := False;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.FillCompilerList(CompilerList: TList);
begin
  CompilerList.Add(rparserFrontFormulaElements);
  CompilerList.Add(rparserFrontFormulaNodes);
  CompilerList.Add(rparserSideFormulaElements);
  CompilerList.Add(rparserSideFormulaNodes);
  CompilerList.Add(rparserThreeDFormulaElements);
  CompilerList.Add(rparserThreeDFormulaNodes);
  CompilerList.Add(rparserTopFormulaElements);
  CompilerList.Add(rparserTopFormulaNodes);

  rparserFrontFormulaElements.Tag := Ord(eaBlocks);
  rparserSideFormulaElements.Tag := Ord(eaBlocks);
  rparserThreeDFormulaElements.Tag := Ord(eaBlocks);
  rparserTopFormulaElements.Tag := Ord(eaBlocks);

  rparserFrontFormulaNodes.Tag := Ord(eaNodes);
  rparserSideFormulaNodes.Tag := Ord(eaNodes);
  rparserThreeDFormulaNodes.Tag := Ord(eaNodes);
  rparserTopFormulaNodes.Tag := Ord(eaNodes);
end;

procedure TfrmScreenObjectProperties.CheckIfDataSetCanBeEdited(
  var CanEdit: boolean; Edit: TScreenObjectDataEdit;
  ListOfScreenObjects: TList);
var
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  DataSet: TDataArray;
  MethodIndex: Integer;
  List: TList;
  TestedElevationFormulas: TStringList;
begin
  CanEdit := True;

  // Check that Edit.DataArray.EvaluatedAt is correct.
  if rgEvaluatedAt.ItemIndex >= 0 then
  begin
    CanEdit := (Ord(Edit.DataArray.EvaluatedAt) = rgEvaluatedAt.ItemIndex);
  end
  else
  begin
    for ScreenObjectIndex := 0 to ListOfScreenObjects.Count - 1 do
    begin
      AScreenObject := ListOfScreenObjects[ScreenObjectIndex];
      CanEdit := Edit.DataArray.EvaluatedAt = AScreenObject.EvaluatedAt;
      if not CanEdit then
      begin
        break;
      end;
    end;
  end;
  CanEdit := CanEdit and not (dcFormula in Edit.DataArray.Lock);
  CanEdit := CanEdit and Edit.DataArray.Visible;
  // Check that Edit.DataArray.Orientation is correct.
  case Edit.DataArray.Orientation of
    dsoTop:
      begin
        CanEdit := CanEdit and (FViewDirection = vdTop);
      end;
    dsoFront:
      begin
        CanEdit := CanEdit and (FViewDirection = vdFront);
      end;
    dsoSide:
      begin
        CanEdit := CanEdit and (FViewDirection = vdSide);
      end;
    dso3D: ; // do nothing
    else Assert(False);
  end;
  if (rgElevationCount.ItemIndex = 0)
    and (Edit.DataArray.Orientation = dso3D) then
  begin
    CanEdit := False;
  end;

  // Check that the Elevation formula(s) does not depend on the
  // the TDataArray.
  if CanEdit then
  begin
    DataSet := Edit.DataArray;
    TestedElevationFormulas:= TStringList.Create;
    List := TList.Create;
    try
      TestedElevationFormulas.Capacity := ListOfScreenObjects.Count;
      TestedElevationFormulas.Sorted := True;
      frmGoPhast.PhastModel.GetModflowLayerGroupDataSets(List);
      frmGoPhast.PhastModel.GetSutraLayerGroupDataSets(List);
      for ScreenObjectIndex := 0 to ListOfScreenObjects.Count - 1 do
      begin
        if not CanEdit then
        begin
          break;
        end;
        AScreenObject := ListOfScreenObjects[ScreenObjectIndex];
        if rgElevationCount.ItemIndex = -1 then
        begin
          MethodIndex := Ord(AScreenObject.ElevationCount);
        end
        else
        begin
          MethodIndex := rgElevationCount.ItemIndex
        end;
        if MethodIndex <> 0 then
        begin
          CanEdit := (List.IndexOf(DataSet) < 0);
          if not CanEdit then
          begin
            break;
          end;
        end;
        if (MethodIndex <> 0) or (List.IndexOf(DataSet) < 0) then
        begin
          CanEdit := not AScreenObject.IsListeningTo(DataSet);
        end;
        if CanEdit then
        begin
          case MethodIndex of
            0:
              begin
                // Do nothing
              end;
            1:
              begin
                if TestedElevationFormulas.IndexOf(
                  AScreenObject.ElevationFormula) < 0 then
                begin
                  CheckIfDataSetUsedInElevationFormula(CanEdit,
                    DataSet, AScreenObject.ElevationFormula, edZ);
                  TestedElevationFormulas.Add(AScreenObject.ElevationFormula);
                end;
              end;
            2:
              begin
                if TestedElevationFormulas.IndexOf(
                  AScreenObject.HigherElevationFormula) < 0 then
                begin
                  CheckIfDataSetUsedInElevationFormula(CanEdit,
                    DataSet, AScreenObject.HigherElevationFormula, edHighZ);
                  TestedElevationFormulas.Add(AScreenObject.HigherElevationFormula);
                end;
                if CanEdit then
                begin
                  if TestedElevationFormulas.IndexOf(
                    AScreenObject.LowerElevationFormula) < 0 then
                  begin
                    CheckIfDataSetUsedInElevationFormula(CanEdit,
                      DataSet, AScreenObject.LowerElevationFormula, edLowZ);
                    TestedElevationFormulas.Add(AScreenObject.LowerElevationFormula);
                  end;
                end;
              end;
            else Assert(False);
          end;
        end;
      end;
    finally
      TestedElevationFormulas.Free;
      List.Free;
    end;
  end
end;

procedure TfrmScreenObjectProperties.FillDataSetsTreeView(ListOfScreenObjects: TList);
var
  Index: Integer;
  Edit: TScreenObjectDataEdit;
  CreateNode: boolean;
  Node: TTreeNode;
  Position: integer;
  ClassifiedDataSets: TStringList;
  LayerList: TList;
  SutraLayerList: TList;
  DataEdits: TClassificationList;
  LayerEdits: TClassificationList;
  SutraLayerEdits: TClassificationList;
  HydrogeologicUnitNames: TStringList;
  HufDataArrays: TClassificationList;
  SelectedNode: TTreeNode;
begin

  { TODO : Nearly the same code is use in TfrmFormulaUnit, TFrmGridColor,
  TfrmScreenObjectProperties, and TfrmDataSets. Find a way to combine them. }
  // depends on rgEvaluatedAt.ItemIndex
  // depends on rgElevationCount.ItemIndex
  // depends on edZ.Text
  // depends on edHighZ.Text
  // depends on edLowZ.Text
  if not FCanFillTreeView or (FDataEdits.Count = 0) or FFilledDataSetTreeView then
  begin
    Exit;
  end;

  FFillingDataSetTreeView := True;
  HydrogeologicUnitNames := TStringList.Create;
  HufDataArrays := TClassificationList.Create;
  LayerList := TList.Create;
  SutraLayerList := TList.Create;
  ClassifiedDataSets := TStringList.Create;
  DataEdits := TClassificationList.Create;
  LayerEdits := TClassificationList.Create;
  SutraLayerEdits := TClassificationList.Create;
  try
    frmGoPhast.PhastModel.HydrogeologicUnits.FillDataArrayNames(
      HydrogeologicUnitNames);
    HydrogeologicUnitNames.CaseSensitive := False;
    for Index := 0 to HydrogeologicUnitNames.Count - 1 do
    begin
      HufDataArrays.Add(nil);
    end;

    frmGoPhast.PhastModel.GetModflowLayerGroupDataSets(LayerList);
    for Index := 0 to LayerList.Count - 1 do
    begin
      LayerEdits.Add(nil);
    end;

    frmGoPhast.PhastModel.GetSutraLayerGroupDataSets(SutraLayerList);
    for Index := 0 to SutraLayerList.Count - 1 do
    begin
      SutraLayerEdits.Add(nil);
    end;

    FCurrentEdit := nil;
    tvDataSets.Items.Clear;
    for Index := 0 to FDataEdits.Count - 1 do
    begin
      Edit := FDataEdits[Index];
      Edit.Node := nil;

      CheckIfDataSetCanBeEdited(CreateNode, Edit, ListOfScreenObjects);

      // Only include the data set in on tvDataSets
      // if it can be validly set by
      // one or more of the TScreenObject's,
      if CreateNode then
      begin
        DataEdits.Add(Edit);
        Position := LayerList.IndexOf(Edit.DataArray);
        if Position >= 0 then
        begin
          LayerEdits[Position] := Edit;
        end;

        Position := SutraLayerList.IndexOf(Edit.DataArray);
        if Position >= 0 then
        begin
          SutraLayerEdits[Position] := Edit;
        end;

        Position := HydrogeologicUnitNames.IndexOf(Edit.DataArray.Name);
        if Position >= 0 then
        begin
          HufDataArrays[Position] := Edit;
        end;
      end;
    end;
    LayerEdits.Pack;
    HufDataArrays.Pack;
    SutraLayerEdits.Pack;

    if DataEdits.Count > 0 then
    begin
      ClassifyListedObjects(ClassifiedDataSets, DataEdits,
        [LayerEdits, SutraLayerEdits, HufDataArrays]);
      Assert(ClassifiedDataSets.Count> 0);
      Assert(ClassifiedDataSets[0] = StrDataSets);
      ClassifiedDataSets.Delete(0);
      Assert(ClassifiedDataSets.IndexOf(StrDataSets) < 0);

      CreateClassifiedNodes(ClassifiedDataSets, 1, tvDataSets,
        FSelectedDataArrayName);

      for Index := 0 to tvDataSets.Items.Count - 1 do
      begin
        Node := tvDataSets.Items[Index];
        Edit := Node.Data;
        if Edit <> nil then
        begin
          Node.StateIndex := Ord(Edit.Used) + 1;
          Edit.Node := Node;
        end;
      end;

      UpdateDataSetTreeViewNodeStates;

      SelectedNode := nil;
      for Index := 0 to tvDataSets.Items.Count - 1 do
      begin
        Node := tvDataSets.Items[Index];
        if Node.HasChildren and (Node.StateIndex <> Ord(cbUnchecked) + 1) then
        begin
          Node.Expanded := True;
        end;
        if (SelectedNode = nil) and not Node.HasChildren
          and (Node.StateIndex <> Ord(cbUnchecked) + 1) then
        begin
          SelectedNode := Node;
          tvDataSets.Selected := SelectedNode;
        end;
      end;


    end;
  finally
    SutraLayerList.Free;
    ClassifiedDataSets.Free;
    LayerList.Free;
    DataEdits.Free;
    SutraLayerEdits.Free;
    LayerEdits.Free;
    HufDataArrays.Free;
    HydrogeologicUnitNames.Free;
    FFillingDataSetTreeView := False;
  end;

end;

procedure TfrmScreenObjectProperties.CreateDataSetEdits(ListOfScreenObjects: TList);
//  function DataArrayNameToEdit(const Name: string): TScreenObjectDataEdit;
//  var
//    Index: integer;
//    Edit: TScreenObjectDataEdit;
//  begin
//    result := nil;
//    for Index := 0 to FDataEdits.Count - 1 do
//    begin
//      Edit := FDataEdits[Index];
//      if Edit.DataArray.Name = Name then
//      begin
//        result := Edit;
//        Exit;
//      end;
//    end;
//  end;
var
  Index: Integer;
  Edit: TScreenObjectDataEdit;
  DataSet: TDataArray;
  DataArrayManager: TDataArrayManager;
begin
  FCurrentEdit := nil;
  FDataEdits.Clear;
  DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
  for Index := 0 to DataArrayManager.DataSetCount - 1 do
  begin
    Edit := TScreenObjectDataEdit.Create(ListOfScreenObjects,
      DataArrayManager.DataSets[Index]);
    FDataEdits.Add(Edit);
    CreateVariable(Edit);
  end;
  for Index := 0 to FDataEdits.Count - 1 do
  begin
    Edit := FDataEdits[Index];
    DataSet := Edit.DataArray;
    // Get the names of all the data sets that depend on DataSet
    DataSet.FullUseList(Edit.UsedBy);
  end;
  for Index := 0 to FDataEdits.Count - 1 do
  begin
    Edit := FDataEdits[Index];
    if (Edit.Used <> cbUnchecked) and (Edit.Expression = nil) then
    begin
      CreateFormula(Index, Edit.Formula, false);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.AddGisFunctionsToAllParsers;
var
  CompilerList: TList;
  Index: Integer;
  Compiler: TRbwParser;
begin
  CompilerList := TList.Create;
  try
    FillCompilerList(CompilerList);
    for Index := 0 to CompilerList.Count - 1 do
    begin
      Compiler := CompilerList[Index];
      AddGIS_Functions(Compiler, frmGoPhast.PhastModel.ModelSelection,
        TEvaluatedAt(Compiler.Tag));
    end;
  finally
    CompilerList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetAssignmentMethodForSingleObject;
begin
  // Display whether the enclosed or intersected cells should
  // have their values set.
  cbEnclosedCells.Checked := FScreenObject.SetValuesOfEnclosedCells;
  cbIntersectedCells.Checked := FScreenObject.SetValuesOfIntersectedCells;
  cbInterpolation.Checked := FScreenObject.SetValuesByInterpolation;
  rdeMinimumCellFraction.RealValue := FScreenObject.MinimumFraction;
  // Enable or disable controls.
  cbEnclosedCellsClick(nil);
  cbIntersectedCellsClick(nil);
  cbInterpolationClick(nil);
end;

procedure TfrmScreenObjectProperties.GetColorDataForSingleObject;
begin
  // Display the colors associated with the screen object.
  shpLineColor.Brush.Color := FScreenObject.LineColor;
  shpLineColor.Pen.Color := FScreenObject.LineColor;
  shpFillColor.Brush.Color := FScreenObject.FillColor;
  // Display whether the colors are used.
  cbLineColor.Checked := FScreenObject.ColorLine;
  cbFillColor.Checked := FScreenObject.FillScreenObject;
  // Enable or disable controls.
  cbLineColorClick(nil);
  cbFillColorClick(nil);
end;

procedure TfrmScreenObjectProperties.SetElevationDataForSingleObject;
begin
  rgElevationCount.ItemIndex := Ord(FScreenObject.ElevationCount);
  rgElevationCount.OnClick(nil);
  if (FScreenObject.ElevationCount = ecOne) then
  begin
    edZ.Text := FScreenObject.ElevationFormula;
  end
  else if (FScreenObject.ElevationCount = ecTwo) then
  begin
    edHighZ.Text := FScreenObject.HigherElevationFormula;
    edLowZ.Text := FScreenObject.LowerElevationFormula;
  end;
  ValidateEdFormula(edZ);
  ValidateEdFormula(edHighZ);
  ValidateEdFormula(edLowZ);
end;

procedure TfrmScreenObjectProperties.SetGridCellSizeDataForSingleObject;
begin
  cbSetGridCellSize.Checked := FScreenObject.CellSizeUsed;
  if FScreenObject.CellSizeUsed then
  begin
    rdeGridCellSize.Enabled := True;
    lblGridCellSize.Enabled := True;
    rdeGridCellSize.Text := FloatToStr(FScreenObject.CellSize);
  end;
end;

procedure TfrmScreenObjectProperties.GetDataSetsForSingleObject;
var
  Index: Integer;
  DataSet: TDataArray;
  DataSetPosition: Integer;
  Edit: TScreenObjectDataEdit;
begin
  // read data sets.

  for Index := 0 to FDataEdits.Count - 1 do
  begin
    Edit := FDataEdits[Index];
    DataSet := Edit.DataArray;
    // store data for PHAST-style interpolation.
    Assert(FScreenObject is TScreenObject);
    if Edit.Used <> cbUnchecked then
    begin
      DataSetPosition := FScreenObject.IndexOfDataSet(DataSet);
      Edit.Formula := FScreenObject.DataSetFormulas[DataSetPosition];
      CreateFormula(Index, Edit.Formula);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.SetScreenObjectVerticies;
var
  TempScreenObject: TScreenObject;
  Index: Integer;
  APoint: TPoint2D;
  CanSetPositions: Boolean;
begin
  if tabNodes.TabVisible then
  begin
    CanSetPositions := True;
    TempScreenObject := frmGoPhast.PhastModel.ScreenObjectClass.Create(nil);
    try
      TempScreenObject.Capacity := dgVerticies.RowCount - 1;
      for Index := 1 to dgVerticies.RowCount - 1 do
      begin
        if dgVerticies.Cells[Ord(vcX), Index] = '' then
        begin
          APoint.X := 0;
        end
        else
        begin
          try
            APoint.X := StrToFloat(dgVerticies.Cells[Ord(vcX), Index]);
          except
            on EConvertError do
            begin
              APoint.X := 0;
            end;
          end;
        end;
        if dgVerticies.Cells[Ord(vcY), Index] = '' then
        begin
          APoint.Y := 0;
        end
        else
        begin
          try
            APoint.Y := StrToFloat(dgVerticies.Cells[Ord(vcY), Index]);
          except
            on EConvertError do
            begin
              APoint.Y := 0;
            end;
          end;
        end;
        try
          TempScreenObject.AddPoint(APoint,
            dgVerticies.Checked[Ord(vcNewSection), Index]);
        except
          on E: EScreenObjectError do
          begin
          end;
        end;
        if TempScreenObject.Count <> Index then
        begin
          CanSetPositions := False;
          break;
        end;
      end;
    finally
      TempScreenObject.Free;
    end;
    if CanSetPositions then
    begin
      FScreenObject.SectionStarts.Clear;
      for Index := 2 to dgVerticies.RowCount - 1 do
      begin
        if dgVerticies.Checked[Ord(vcNewSection), Index] then
        begin
          FScreenObject.SectionStarts.Add;
          FScreenObject.SectionStarts.IntValues[FScreenObject.SectionStarts.Count -1] := Index -1;
        end;
      end;
      FScreenObject.Count := dgVerticies.RowCount - 1;
      for Index := 1 to dgVerticies.RowCount - 1 do
      begin
        if dgVerticies.Cells[Ord(vcX), Index] = '' then
        begin
          APoint.X := 0;
        end
        else
        begin
          try
            APoint.X := StrToFloat(dgVerticies.Cells[Ord(vcX), Index]);
          except
            on EConvertError do
            begin
              APoint.X := 0;
            end;
          end;
        end;
        if dgVerticies.Cells[Ord(vcY), Index] = '' then
        begin
          APoint.Y := 0;
        end
        else
        begin
          try
            APoint.Y := StrToFloat(dgVerticies.Cells[Ord(vcY), Index]);
          except
            on EConvertError do
            begin
              APoint.Y := 0;
            end;
          end;
        end;
        if (FScreenObject.Points[Index - 1].X <> APoint.X) or (FScreenObject.Points[Index - 1].Y <> APoint.Y) then
        begin
          FScreenObject.Points[Index - 1] := APoint;
          frmGoPhast.PhastGrid.NeedToRecalculateCellColors;
          frmGoPhast.ModflowGrid.NeedToRecalculateCellColors;
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetEvaluatedAtForAdditionalObject(AScreenObject: TScreenObject);
var
  EvaluatedAtIndex: Integer;
begin
  EvaluatedAtIndex := Ord(AScreenObject.EvaluatedAt);
  if EvaluatedAtIndex <> rgEvaluatedAt.ItemIndex then
  begin
    rgEvaluatedAt.ItemIndex := -1;
  end;
end;

function TfrmScreenObjectProperties.GenerateNewDataSetFormula(
  DataArray: TDataArray): string;
var
  DataSetPosition: Integer;
  Index: Integer;
  AScreenObject: TScreenObject;
begin
  result := '';
  if FScreenObject <> nil then
  begin
    DataSetPosition := FScreenObject.IndexOfDataSet(DataArray);
    if DataSetPosition >= 0 then
    begin
      result := FScreenObject.DataSetFormulas[DataSetPosition];
    end;
  end
  else
  begin
    for Index := 0 to FScreenObjectList.Count - 1 do
    begin
      AScreenObject := FScreenObjectList[Index];
      DataSetPosition := AScreenObject.IndexOfDataSet(DataArray);
      if DataSetPosition >= 0 then
      begin
        result := AScreenObject.DataSetFormulas[DataSetPosition];
        if result <> '' then
        begin
          break;
        end;
      end;
    end;
  end;
  if result = '' then
  begin
    result := DataArray.DisplayFormula;
  end;
end;

procedure TfrmScreenObjectProperties.GetDuplicatesAllowedForAdditionalObject
  (AScreenObject: TScreenObject);
begin
  if cbDuplicatesAllowed.Checked <> AScreenObject.DuplicatesAllowed then
  begin
    cbDuplicatesAllowed.AllowGrayed := True;
    cbDuplicatesAllowed.State := cbGrayed;
    cbEnclosedCellsClick(nil);
  end;
end;


procedure TfrmScreenObjectProperties.GetAssignmentMethodForAdditionalObject(AScreenObject: TScreenObject);
begin
  if AScreenObject.Closed then
  begin
    cbEnclosedCells.Enabled := True;
  end;
  if cbEnclosedCells.Checked <> AScreenObject.SetValuesOfEnclosedCells then
  begin
    cbEnclosedCells.AllowGrayed := True;
    cbEnclosedCells.State := cbGrayed;
    cbEnclosedCellsClick(nil);
  end;
  if cbIntersectedCells.Checked <> AScreenObject.SetValuesOfIntersectedCells then
  begin
    cbIntersectedCells.AllowGrayed := True;
    cbIntersectedCells.State := cbGrayed;
    cbIntersectedCellsClick(nil);
  end;
  if cbInterpolation.Checked <> AScreenObject.SetValuesByInterpolation then
  begin
    cbInterpolation.AllowGrayed := True;
    cbInterpolation.State := cbGrayed;
    cbInterpolationClick(nil);
  end;
  if not rdeMinimumCellFraction.Enabled then
  begin
    rdeMinimumCellFraction.Enabled := (AScreenObject.ScreenObjectLength > 0)
      and (cbIntersectedCells.State <> cbUnchecked);
  end;
  if rdeMinimumCellFraction.RealValue <> AScreenObject.MinimumFraction then
  begin
    rdeMinimumCellFraction.Text := '';
  end;
end;

procedure TfrmScreenObjectProperties.GetColorDataForAdditionalObject(AScreenObject: TScreenObject);
begin
  // update display of screen object line and fill colors.
  // Hide the TShapes that display the colors if the
  // colors are not consistent.
  if shpLineColor.Brush.Color <> AScreenObject.LineColor then
  begin
    shpLineColor.Visible := False;
  end;
  if shpFillColor.Brush.Color <> AScreenObject.FillColor then
  begin
    shpFillColor.Visible := False;
  end;
  // Set checkbox state to grayed if they screen objects don't
  // all do the same thing.
  if cbLineColor.Checked <> AScreenObject.ColorLine then
  begin
    cbLineColor.AllowGrayed := True;
    cbLineColor.State := cbGrayed;
  end;
  if cbFillColor.Checked <> AScreenObject.FillScreenObject then
  begin
    cbFillColor.AllowGrayed := True;
    cbFillColor.State := cbGrayed;
  end;
end;

procedure TfrmScreenObjectProperties.GetCellSizeUsedForAdditionalObject(AScreenObject: TScreenObject);
var
  CellSizeText: string;
begin
  if AScreenObject.CellSizeUsed <> cbSetGridCellSize.Checked then
  begin
    cbSetGridCellSize.AllowGrayed := True;
    cbSetGridCellSize.State := cbGrayed;
  end;
  if AScreenObject.CellSizeUsed then
  begin
    if not rdeGridCellSize.Enabled then
    begin
      rdeGridCellSize.Enabled := True;
      lblGridCellSize.Enabled := True;
      rdeGridCellSize.Text := FloatToStr(AScreenObject.CellSize);
    end
    else
    begin
      CellSizeText := FloatToStr(AScreenObject.CellSize);
      if CellSizeText <> rdeGridCellSize.Text then
      begin
        rdeGridCellSize.Text := '';
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetDataSetsForAdditionalObject(
  AScreenObject: TScreenObject);
var
  DataSetIndex: Integer;
  DataSet: TDataArray;
  ScreenObjectDataSetIndex: Integer;
  DataSetUsed: Boolean;
  DataSetState: TCheckBoxState;
  AFunction: string;
  Edit: TScreenObjectDataEdit;
begin
  // update data for Data sets.
  for DataSetIndex := 0 to frmGoPhast.PhastModel.DataArrayManager.DataSetCount - 1 do
  begin
    Edit := FDataEdits[DataSetIndex];
    DataSet := Edit.DataArray;
    // see if the data set is used.
    ScreenObjectDataSetIndex := AScreenObject.IndexOfDataSet(DataSet);
    DataSetUsed := ScreenObjectDataSetIndex >= 0;
    // Set the DataSetState depending on DataSetUsed.
    if DataSetUsed then
    begin
      DataSetState := cbChecked;
    end
    else
    begin
      DataSetState := cbUnChecked;
    end;
    // If the data set is not used in previous screen objects but is used in
    // the current screen object. display the function.
    if (Edit.Used = cbUnChecked)
      and DataSetUsed then
    begin
      AFunction := AScreenObject.DataSetFormulas[ScreenObjectDataSetIndex];
      CreateFormula(DataSetIndex, AFunction);
    end;
    // Set the checkbox to cbGrayed if only some of the screen objects
    // use the data set.
    if Edit.Used <> DataSetState then
    begin
      Edit.Used := cbGrayed;
    end;
    if DataSetUsed then
    begin
      // If some screen objects use different expressions than others,
      // blank out the display of the expression.
      AFunction := AScreenObject.DataSetFormulas[ScreenObjectDataSetIndex];
      if AFunction <> Edit.Formula then
      begin
        Edit.Formula := '';
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetElevationFormulasForAdditionalObject(
  AScreenObject: TScreenObject);
var
  TempEnabled: Boolean;
begin
  if Ord(AScreenObject.ElevationCount) <> (rgElevationCount.ItemIndex) then
  begin
    rgElevationCount.ItemIndex := -1;
    if AScreenObject.ElevationCount = ecZero then
    begin
      cbInterpolation.Enabled := True;
    end;
  end;
  if (AScreenObject.ElevationCount = ecOne) then
  begin
    if not edZ.Enabled then
    begin
      TempEnabled := edHighZ.Enabled;
      rgElevationCount.ItemIndex := -1;
      lblZ.Enabled := True;
      edZ.Enabled := True;
      btnZ.Enabled := True;
      edZ.Text := AScreenObject.ElevationFormula;
      rgElevationCountClick(rgElevationCount);
      lblHighZ.Enabled := TempEnabled;
      edHighZ.Enabled := TempEnabled;
      btnHighZ.Enabled := TempEnabled;
      lblLowZ.Enabled := TempEnabled;
      edLowZ.Enabled := TempEnabled;
      btnLowZ.Enabled := TempEnabled;
    end
    else if edZ.Text <> AScreenObject.ElevationFormula then
    begin
      edZ.Text := '';
    end;
  end
  else if (AScreenObject.ElevationCount = ecTwo) then
  begin
    if not edHighZ.Enabled then
    begin
      TempEnabled := edZ.Enabled;
      rgElevationCount.ItemIndex := -1;
      lblHighZ.Enabled := True;
      edHighZ.Enabled := True;
      btnHighZ.Enabled := True;
      edHighZ.Text := AScreenObject.HigherElevationFormula;
      lblLowZ.Enabled := True;
      edLowZ.Enabled := True;
      btnLowZ.Enabled := True;
      edLowZ.Text := AScreenObject.LowerElevationFormula;
      rgElevationCountClick(rgElevationCount);
      lblZ.Enabled := TempEnabled;
      edZ.Enabled := TempEnabled;
      btnZ.Enabled := TempEnabled;
    end
    else
    begin
      if edHighZ.Text <> AScreenObject.HigherElevationFormula then
      begin
        edHighZ.Text := '';
      end;
      if edLowZ.Text <> AScreenObject.LowerElevationFormula then
      begin
        edLowZ.Text := '';
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetPhastWellBoundaryForAdditionalObject(
  AScreenObject: TScreenObject; UsedTimes: TRealList;
  var TempType: TPhastBoundaryTypes);
var
  BoundaryIndentical: Boolean;
  Index: Integer;
  WellInterval: TWellInterval;
begin
  with AScreenObject.WellBoundary do
  begin
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      TempType := btWell;
      if rgBoundaryType.ItemIndex <> Integer(btRiver) then
      begin
        rgBoundaryType.ItemIndex := -1;
      end;
      GetBoundaryTimes([BoundaryValue, Solution], UsedTimes);
      BoundaryIndentical := TimesIdentical(dgWell, UsedTimes, Ord(nicTime))
        and PhastBoundaryIsIdentical(dgWell, UsedTimes, BoundaryValue, Ord(nicBoundaryValue), -1)
        and PhastBoundaryIsIdentical(dgWell, UsedTimes, Solution, Ord(nicSolution), -1);
      if not BoundaryIndentical then
      begin
        ResetWellGrid;
      end;
      if edWellDescription.Text <> Description then
      begin
        edWellDescription.Text := '';
      end;
      if rdeWellDiameter.Text <> FloatToStr(Diameter) then
      begin
        rdeWellDiameter.Text := '';
      end;
      if rdeWellLandSurfaceDatum.Text <> FloatToStr(LandSurfaceDatum) then
      begin
        rdeWellLandSurfaceDatum.Text := '';
      end;
      if cbWellPumpAllocation.Checked <> AllocateByPressureAndMobility then
      begin
        cbWellPumpAllocation.AllowGrayed := True;
        cbWellPumpAllocation.State := cbGrayed;
      end;
      if comboWellIntervalStyle.ItemIndex <> Ord(WellElevationFormat) then
      begin
        comboWellIntervalStyle.ItemIndex := -1;
        comboWellIntervalStyleChange(nil);
      end;
      BoundaryIndentical := True;
      if Intervals.Count <> seWellIntervals.Value then
      begin
        BoundaryIndentical := False;
      end;
      if BoundaryIndentical then
      begin
        for Index := 0 to Intervals.Count - 1 do
        begin
          WellInterval := Intervals.Items[Index] as TWellInterval;
          if FloatToStr(WellInterval.FirstElevation)
            <> dgWellElevations.Cells[Ord(wicFirst), Index + 1] then
          begin
            BoundaryIndentical := False;
            break;
          end;
          if FloatToStr(WellInterval.SecondElevation)
            <> dgWellElevations.Cells[Ord(wicSecond), Index + 1] then
          begin
            BoundaryIndentical := False;
            break;
          end;
        end;
      end;
      if not BoundaryIndentical then
      begin
        ResetWellElevationGrid;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetPhastRiverBoundaryForAdditionalObject(
  AScreenObject: TScreenObject; UsedTimes: TRealList;
  var TempType: TPhastBoundaryTypes);
var
  BoundaryIndentical: Boolean;
begin
  with AScreenObject.RiverBoundary do
  begin
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      TempType := btRiver;
      if rgBoundaryType.ItemIndex <> Integer(btRiver) then
      begin
        rgBoundaryType.ItemIndex := -1;
      end;
      GetBoundaryTimes([BoundaryValue, Solution], UsedTimes);
      BoundaryIndentical := TimesIdentical(dgBoundaryRiver, UsedTimes, Ord(nicTime))
        and PhastBoundaryIsIdentical(dgBoundaryRiver, UsedTimes, BoundaryValue, Ord(nicBoundaryValue), -1)
        and PhastBoundaryIsIdentical(dgBoundaryRiver, UsedTimes, Solution, Ord(nicSolution), -1);
      if not BoundaryIndentical then
      begin
        ResetRiverGrid;
      end;
      if edRiverDescripton.Text <> Description then
      begin
        edRiverDescripton.Text := '';
      end;
      if edRiverHydraulicConductivity.Text <> BedHydraulicConductivity then
      begin
        edRiverHydraulicConductivity.Text := '';
      end;
      if edRiverWidth.Text <> Width then
      begin
        edRiverWidth.Text := '';
      end;
      if edRiverDepth.Text <> Depth then
      begin
        edRiverDepth.Text := '';
      end;
      if edRiverBedThickness.Text <> BedThickness then
      begin
        edRiverBedThickness.Text := '';
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetPhastLeakyBoundaryForAdditionalObject(
  AScreenObject: TScreenObject; UsedTimes: TRealList;
  var TempType: TPhastBoundaryTypes);
var
  BoundaryIndentical: Boolean;
begin
  with AScreenObject.LeakyBoundary do
  begin
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      TempType := btLeaky;
      if rgBoundaryType.ItemIndex <> Integer(btLeaky) then
      begin
        rgBoundaryType.ItemIndex := -1;
      end;
      GetBoundaryTimes([BoundaryValue, Solution], UsedTimes);
      BoundaryIndentical := TimesIdentical(dgBoundaryLeaky, UsedTimes, Ord(ibcTime))
        and PhastBoundaryIsIdentical(dgBoundaryLeaky, UsedTimes, BoundaryValue,
          Ord(ibcBoundaryValue), Ord(ibcBoundaryInterpolate))
        and PhastBoundaryIsIdentical(dgBoundaryLeaky, UsedTimes, Solution,
          Ord(ibcSolution), Ord(ibcSolutionInterpolate));
      if not BoundaryIndentical then
      begin
        ResetLeakyGrid;
      end;
      if edLeakyHydraulicConductivity.Text <> HydraulicConductivity then
      begin
        edLeakyHydraulicConductivity.Text := '';
      end;
      if edLeakyThickness.Text <> Thickness then
      begin
        edLeakyThickness.Text := '';
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.
  GetPhastSpecifiedFluxBoundaryForAdditionalObject(AScreenObject: TScreenObject;
  UsedTimes: TRealList; var TempType: TPhastBoundaryTypes);
var
  BoundaryIndentical: Boolean;
begin
  with AScreenObject.FluxBoundary do
  begin
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      TempType := btFlux;
      if rgBoundaryType.ItemIndex <> Integer(btFlux) then
      begin
        rgBoundaryType.ItemIndex := -1;
      end;
      GetBoundaryTimes([BoundaryValue, Solution], UsedTimes);
      BoundaryIndentical := TimesIdentical(dgBoundaryFlux, UsedTimes, Ord(ibcTime))
        and PhastBoundaryIsIdentical(dgBoundaryFlux, UsedTimes, BoundaryValue,
          Ord(ibcBoundaryValue), Ord(ibcBoundaryInterpolate))
        and PhastBoundaryIsIdentical(dgBoundaryFlux, UsedTimes, Solution,
          Ord(ibcSolution), Ord(ibcSolutionInterpolate));
      if not BoundaryIndentical then
      begin
        ResetFluxGrid;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.
  GetPhastSpecifiedHeadBoundaryForAdditionalObject(AScreenObject: TScreenObject;
  UsedTimes: TRealList; var TempType: TPhastBoundaryTypes);
var
  BoundaryIndentical: Boolean;
begin
  with AScreenObject.SpecifiedHeadBoundary do
  begin
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      TempType := btSpecifiedHead;
      if rgBoundaryType.ItemIndex <> Integer(btSpecifiedHead) then
      begin
        rgBoundaryType.ItemIndex := -1;
      end;
      if (Ord(SolutionType) <> comboSolutionType.ItemIndex) then
      begin
        comboSolutionType.ItemIndex := -1;
        comboSolutionTypeChange(nil);
      end;
      GetBoundaryTimes([BoundaryValue, Solution], UsedTimes);
      BoundaryIndentical := TimesIdentical(dgSpecifiedHead, UsedTimes, Ord(ibcTime))
        and PhastBoundaryIsIdentical(dgSpecifiedHead, UsedTimes, BoundaryValue,
          Ord(ibcBoundaryValue), Ord(ibcBoundaryInterpolate))
        and PhastBoundaryIsIdentical(dgSpecifiedHead, UsedTimes, Solution,
          Ord(ibcSolution), Ord(ibcSolutionInterpolate));
      if not BoundaryIndentical then
      begin
        ResetSpecifiedHeadGrid;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.
  GetPhastBoundaryConditionsForAdditionalObjects(AScreenObject: TScreenObject;
  var TempType: TPhastBoundaryTypes);
var
  UsedTimes: TRealList;
begin
  TempType := btNone;
  UsedTimes := TRealList.Create;
  try
    GetPhastSpecifiedHeadBoundaryForAdditionalObject(
      AScreenObject, UsedTimes, TempType);
    GetPhastSpecifiedFluxBoundaryForAdditionalObject(
      AScreenObject, UsedTimes, TempType);
    GetPhastLeakyBoundaryForAdditionalObject(
      AScreenObject, UsedTimes, TempType);
    GetPhastRiverBoundaryForAdditionalObject(
      AScreenObject, UsedTimes, TempType);
    GetPhastWellBoundaryForAdditionalObject(
      AScreenObject, UsedTimes, TempType);
  finally
    UsedTimes.Free;
  end;
end;

procedure TfrmScreenObjectProperties.SetZLabelCaptions;
begin
  lblZ.Caption := GetCoordinateCaption(FScreenObject);
  lblHighZ.Caption := GetHigherCoordinateCaption(FScreenObject);
  lblLowZ.Caption := GetLowerCoordinateCaption(FScreenObject);
  case FScreenObject.ViewDirection of
    vdTop:
      begin
      end;
    vdFront:
      begin
        dgVerticies.Cells[Ord(vcY), 0] := 'Z';
      end;
    vdSide:
      begin
        dgVerticies.Cells[Ord(vcX), 0] := 'Z';
      end;
  else
    Assert(False);
  end;
end;

procedure TfrmScreenObjectProperties.GetScreenObjectVerticies;
var
  APoint: TPoint2D;
  Index: Integer;
  TempString: string;
{$IFDEF DEBUG}
  LFormatSettings: TFormatSettings;
{$ENDIF}
begin
  if FScreenObject.Count >= 1048560 then
  begin
    // TStringGrid can't handle too many rows.
    tabNodes.TabVisible := False;
    Exit;
  end;
  // read vertices of the screen object.
  dgVerticies.RowCount := FScreenObject.Count + 1;

  dgVerticies.BeginUpdate;
  try
    UpdateVertexNumbers;
    FSettingVerticies := True;
  {$IFDEF DEBUG}
    LFormatSettings := TFormatSettings.Create('en-US'); // do not localize
    LFormatSettings.DecimalSeparator := AnsiChar('.');
  {$ENDIF}
    try
      for Index := 1 to dgVerticies.RowCount - 1 do
      begin
        APoint := FScreenObject.Points[Index - 1];
      {$IFDEF DEBUG}
        // get more precise vertex locations for debugging mesh generation.
        TempString := FloatToStrF(APoint.X, ffFixed, 16, 18, LFormatSettings);
      {$ELSE}
        TempString := FloatToStr(APoint.X);
      {$ENDIF}
        dgVerticies.Cells[Ord(vcX), Index] := TempString;
      {$IFDEF DEBUG}
        // get more precise vertex locations for debugging mesh generation.
        TempString := FloatToStrF(APoint.Y, ffFixed, 16, 18, LFormatSettings);
      {$ELSE}
        TempString := FloatToStr(APoint.Y);
      {$ENDIF}
        dgVerticies.Cells[Ord(vcY), Index] := TempString;
        dgVerticies.Checked[Ord(vcNewSection), Index] := False;
      end;
      for Index := 0 to FScreenObject.SectionCount - 1 do
      begin
        dgVerticies.Checked[Ord(vcNewSection),
          FScreenObject.SectionStart[Index] + 1] := True;
      end;
    finally
      FSettingVerticies := False;
    end;
    UpdateSectionNumbers;
  finally
    dgVerticies.EndUpdate;
  end;
end;

procedure TfrmScreenObjectProperties.GetPhastWellBoundaryForSingleObject(
  UsedTimes: TRealList);
var
  WellInterval: TWellInterval;
  Local_Index25: Integer;
  IntegerBoundary: TIntegerPhastBoundaryCondition;
  Local_Index24: Integer;
  InterpValuesItem: TInterpValuesItem;
  InterpValuesCollection: TInterpValuesCollection;
  RowIndex: Integer;
  RealBoundary: TRealPhastBoundaryCondition;
  Local_Index23: Integer;
  Local_Index22: Integer;
  Local_Index21: Integer;
  Local_Index20: Integer;
begin
  with FScreenObject.WellBoundary do
  begin
    seWellIntervals.Value := Intervals.Count;
    seWellIntervalsChange(nil);
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      dgWell.RowCount := Max(BoundaryValue.Count, Solution.Count) + 1;
      rgBoundaryType.ItemIndex := Integer(btWell);
      edWellDescription.Text := Description;
      rdeWellDiameter.Text := FloatToStr(Diameter);
      rdeWellLandSurfaceDatum.Text := FloatToStr(LandSurfaceDatum);
      cbWellPumpAllocation.Checked := AllocateByPressureAndMobility;
      comboWellIntervalStyle.ItemIndex := Ord(WellElevationFormat);
      comboWellIntervalStyleChange(nil);
      UsedTimes.Clear;
      // In PHAST, the first time must always be zero.
      UsedTimes.AddUnique(0);
      for Local_Index20 := 0 to BoundaryValue.Count - 1 do
      begin
        UsedTimes.AddUnique((BoundaryValue.Items[Local_Index20]
          as TRealPhastBoundaryCondition).Time);
      end;
      for Local_Index21 := 0 to Solution.Count - 1 do
      begin
        UsedTimes.AddUnique((Solution.Items[Local_Index21]
          as TIntegerPhastBoundaryCondition).Time);
      end;
      // store the times for the boundary condition.
      seBoundaryTimes.Value := UsedTimes.Count;
      for Local_Index22 := 0 to UsedTimes.Count - 1 do
      begin
        dgWell.Cells[Ord(nicTime), Local_Index22 + 1]
          := FloatToStr(UsedTimes[Local_Index22]);
      end;
      for Local_Index23 := 0 to BoundaryValue.Count - 1 do
      begin
        RealBoundary := BoundaryValue.Items[Local_Index23]
          as TRealPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(RealBoundary.Time) + 1;
        if not RealBoundary.UsePHAST_Interpolation then
        begin
          dgWell.Cells[Ord(nicBoundaryValue), RowIndex]
            := RealBoundary.FormulaExpression;
        end;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(RealBoundary);
        dgWell.Objects[Ord(nicBoundaryValue), RowIndex]
          := InterpValuesCollection;
      end;
      for Local_Index24 := 0 to Solution.Count - 1 do
      begin
        IntegerBoundary := Solution.Items[Local_Index24]
          as TIntegerPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(IntegerBoundary.Time) + 1;
        if not IntegerBoundary.UsePHAST_Interpolation then
        begin
          dgWell.Cells[Ord(nicSolution), RowIndex]
            := IntegerBoundary.FormulaExpression;
        end;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(IntegerBoundary);
        dgWell.Objects[Ord(nicSolution), RowIndex] := InterpValuesCollection;
      end;
    end
    else
    begin
      dgWell.RowCount := 2;
    end;
    if Intervals.Count > 0 then
    begin
      for Local_Index25 := 0 to Intervals.Count - 1 do
      begin
        WellInterval := Intervals.Items[Local_Index25] as TWellInterval;
        dgWellElevations.Cells[Ord(wicFirst), Local_Index25 + 1]
          := FloatToStr(WellInterval.FirstElevation);
        dgWellElevations.Cells[Ord(wicSecond), Local_Index25 + 1]
          := FloatToStr(WellInterval.SecondElevation);
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.
  GetPhastSpecifiedHeadBoundaryForSingleObject(UsedTimes: TRealList);
var
  IntegerBoundary: TIntegerPhastBoundaryCondition;
  Local_Index19: Integer;
  InterpValuesItem: TInterpValuesItem;
  InterpValuesCollection: TInterpValuesCollection;
  RowIndex: Integer;
  RealBoundary: TRealPhastBoundaryCondition;
  Local_Index18: Integer;
  Local_Index17: Integer;
  Local_Index16: Integer;
  Local_Index15: Integer;
begin
  with FScreenObject.SpecifiedHeadBoundary do
  begin
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      dgSpecifiedHead.RowCount := Max(BoundaryValue.Count, Solution.Count) + 1;
      comboSolutionType.ItemIndex := Ord(SolutionType);
      comboSolutionTypeChange(nil);
      rgBoundaryType.ItemIndex := Integer(btSpecifiedHead);
      UsedTimes.Clear;
      // In PHAST, the first time must always be zero.
      UsedTimes.AddUnique(0);
      for Local_Index15 := 0 to BoundaryValue.Count - 1 do
      begin
        UsedTimes.AddUnique((BoundaryValue.Items[Local_Index15]
          as TRealPhastBoundaryCondition).Time);
      end;
      for Local_Index16 := 0 to Solution.Count - 1 do
      begin
        UsedTimes.AddUnique((Solution.Items[Local_Index16]
          as TIntegerPhastBoundaryCondition).Time);
      end;
      // store the times for the boundary condition.
      seBoundaryTimes.Value := UsedTimes.Count;
      for Local_Index17 := 0 to UsedTimes.Count - 1 do
      begin
        dgSpecifiedHead.Cells[Ord(ibcTime), Local_Index17 + 1]
          := FloatToStr(UsedTimes[Local_Index17]);
      end;
      for Local_Index18 := 0 to BoundaryValue.Count - 1 do
      begin
        RealBoundary := BoundaryValue.Items[Local_Index18]
          as TRealPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(RealBoundary.Time) + 1;
        if not RealBoundary.UsePHAST_Interpolation then
        begin
          dgSpecifiedHead.Cells[Ord(ibcBoundaryValue), RowIndex]
            := RealBoundary.FormulaExpression;
        end;
        dgSpecifiedHead.Checked[Ord(ibcBoundaryInterpolate), RowIndex]
          := RealBoundary.UsePHAST_Interpolation;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(RealBoundary);
        dgSpecifiedHead.Objects[Ord(ibcBoundaryValue), RowIndex]
          := InterpValuesCollection;
        dgSpecifiedHead.Objects[Ord(ibcBoundaryInterpolate), RowIndex]
          := InterpValuesCollection;
      end;
      for Local_Index19 := 0 to Solution.Count - 1 do
      begin
        IntegerBoundary := Solution.Items[Local_Index19]
          as TIntegerPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(IntegerBoundary.Time) + 1;
        if not IntegerBoundary.UsePHAST_Interpolation then
        begin
          dgSpecifiedHead.Cells[Ord(ibcSolution), RowIndex]
            := IntegerBoundary.FormulaExpression;
        end;
        dgSpecifiedHead.Checked[Ord(ibcSolutionInterpolate), RowIndex]
          := IntegerBoundary.UsePHAST_Interpolation;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(IntegerBoundary);
        dgSpecifiedHead.Objects[Ord(ibcSolution), RowIndex]
          := InterpValuesCollection;
        dgSpecifiedHead.Objects[Ord(ibcSolutionInterpolate), RowIndex]
          := InterpValuesCollection;
      end;
    end
    else
    begin
      dgSpecifiedHead.RowCount := 2;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetPhastRiverBoundaryForSingleObject(
  UsedTimes: TRealList);
var
  IntegerBoundary: TIntegerPhastBoundaryCondition;
  Local_Index14: Integer;
  InterpValuesItem: TInterpValuesItem;
  InterpValuesCollection: TInterpValuesCollection;
  RowIndex: Integer;
  RealBoundary: TRealPhastBoundaryCondition;
  Local_Index13: Integer;
  Local_Index12: Integer;
  Local_Index11: Integer;
  Local_Index10: Integer;
begin
  with FScreenObject.RiverBoundary do
  begin
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      dgBoundaryRiver.RowCount := Max(BoundaryValue.Count, Solution.Count) + 1;
      rgBoundaryType.ItemIndex := Integer(btRiver);
      // Store things that don't change with time.
      edRiverDescripton.Text := Description;
      edRiverHydraulicConductivity.Text := BedHydraulicConductivity;
      edRiverWidth.Text := Width;
      edRiverDepth.Text := Depth;
      edRiverBedThickness.Text := BedThickness;
      UsedTimes.Clear;
      // In PHAST, the first time must always be zero.
      UsedTimes.AddUnique(0);
      for Local_Index10 := 0 to BoundaryValue.Count - 1 do
      begin
        UsedTimes.AddUnique((BoundaryValue.Items[Local_Index10]
          as TRealPhastBoundaryCondition).Time);
      end;
      for Local_Index11 := 0 to Solution.Count - 1 do
      begin
        UsedTimes.AddUnique((Solution.Items[Local_Index11]
          as TIntegerPhastBoundaryCondition).Time);
      end;
      // store the times for the boundary condition.
      seBoundaryTimes.Value := UsedTimes.Count;
      for Local_Index12 := 0 to UsedTimes.Count - 1 do
      begin
        dgBoundaryRiver.Cells[Ord(nicTime), Local_Index12 + 1]
          := FloatToStr(UsedTimes[Local_Index12]);
      end;
      for Local_Index13 := 0 to BoundaryValue.Count - 1 do
      begin
        RealBoundary := BoundaryValue.Items[Local_Index13]
          as TRealPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(RealBoundary.Time) + 1;
        if not RealBoundary.UsePHAST_Interpolation then
        begin
          dgBoundaryRiver.Cells[Ord(nicBoundaryValue), RowIndex]
            := RealBoundary.FormulaExpression;
        end;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(RealBoundary);
        dgBoundaryRiver.Objects[Ord(nicBoundaryValue), RowIndex]
          := InterpValuesCollection;
      end;
      for Local_Index14 := 0 to Solution.Count - 1 do
      begin
        IntegerBoundary := Solution.Items[Local_Index14]
          as TIntegerPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(IntegerBoundary.Time) + 1;
        if not IntegerBoundary.UsePHAST_Interpolation then
        begin
          dgBoundaryRiver.Cells[Ord(nicSolution), RowIndex]
            := IntegerBoundary.FormulaExpression;
        end;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(IntegerBoundary);
        dgBoundaryRiver.Objects[Ord(nicSolution), RowIndex]
          := InterpValuesCollection;
      end;
    end
    else
    begin
      dgBoundaryRiver.RowCount := 2;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetPhastLeakyBoundaryForSingleObject(
  UsedTimes: TRealList);
var
  InterpValuesCollection: TInterpValuesCollection;
  RowIndex: Integer;
  RealBoundary: TRealPhastBoundaryCondition;
  Local_Index8: Integer;
  Local_Index7: Integer;
  Local_Index6: Integer;
  Local_Index5: Integer;
  IntegerBoundary: TIntegerPhastBoundaryCondition;
  Local_Index9: Integer;
  InterpValuesItem: TInterpValuesItem;
begin
  // store leaky boundary
  with FScreenObject.LeakyBoundary do
  begin
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      dgBoundaryLeaky.RowCount := Max(BoundaryValue.Count, Solution.Count) + 1;
      rgBoundaryType.ItemIndex := Integer(btLeaky);
      // Store things that don't change with time.
      edLeakyHydraulicConductivity.Text := HydraulicConductivity;
      edLeakyThickness.Text := Thickness;
      UsedTimes.Clear;
      // In PHAST, the first time must always be zero.
      UsedTimes.AddUnique(0);
      for Local_Index5 := 0 to BoundaryValue.Count - 1 do
      begin
        UsedTimes.AddUnique((BoundaryValue.Items[Local_Index5]
          as TRealPhastBoundaryCondition).Time);
      end;
      for Local_Index6 := 0 to Solution.Count - 1 do
      begin
        UsedTimes.AddUnique((Solution.Items[Local_Index6]
          as TIntegerPhastBoundaryCondition).Time);
      end;
      // store the times for the boundary condition.
      seBoundaryTimes.Value := UsedTimes.Count;
      for Local_Index7 := 0 to UsedTimes.Count - 1 do
      begin
        dgBoundaryLeaky.Cells[Ord(ibcTime), Local_Index7 + 1]
          := FloatToStr(UsedTimes[Local_Index7]);
      end;
      for Local_Index8 := 0 to BoundaryValue.Count - 1 do
      begin
        RealBoundary := BoundaryValue.Items[Local_Index8]
          as TRealPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(RealBoundary.Time) + 1;
        if not RealBoundary.UsePHAST_Interpolation then
        begin
          dgBoundaryLeaky.Cells[Ord(ibcBoundaryValue), RowIndex]
            := RealBoundary.FormulaExpression;
        end;
        dgBoundaryLeaky.Checked[Ord(ibcBoundaryInterpolate), RowIndex]
          := RealBoundary.UsePHAST_Interpolation;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(RealBoundary);
        dgBoundaryLeaky.Objects[Ord(ibcBoundaryValue), RowIndex]
          := InterpValuesCollection;
        dgBoundaryLeaky.Objects[Ord(ibcBoundaryInterpolate), RowIndex]
          := InterpValuesCollection;
      end;
      for Local_Index9 := 0 to Solution.Count - 1 do
      begin
        IntegerBoundary := Solution.Items[Local_Index9]
          as TIntegerPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(IntegerBoundary.Time) + 1;
        if not IntegerBoundary.UsePHAST_Interpolation then
        begin
          dgBoundaryLeaky.Cells[Ord(ibcSolution), RowIndex]
            := IntegerBoundary.FormulaExpression;
        end;
        dgBoundaryLeaky.Checked[Ord(ibcSolutionInterpolate), RowIndex]
          := IntegerBoundary.UsePHAST_Interpolation;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(IntegerBoundary);
        dgBoundaryLeaky.Objects[Ord(ibcSolution), RowIndex]
          := InterpValuesCollection;
        dgBoundaryLeaky.Objects[Ord(ibcSolutionInterpolate), RowIndex]
          := InterpValuesCollection;
      end;
    end
    else
    begin
      dgBoundaryLeaky.RowCount := 2;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetPhastFluxBoundaryForSingleObject(
  UsedTimes: TRealList);
var
  IntegerBoundary: TIntegerPhastBoundaryCondition;
  Local_Index4: Integer;
  InterpValuesItem: TInterpValuesItem;
  InterpValuesCollection: TInterpValuesCollection;
  RowIndex: Integer;
  RealBoundary: TRealPhastBoundaryCondition;
  Local_Index3: Integer;
  Local_Index2: Integer;
  Local_Index1: Integer;
  Local_Index: Integer;
begin
  // Store flux boundary
  with FScreenObject.FluxBoundary do
  begin
    if (BoundaryValue.Count > 0) or (Solution.Count > 0) then
    begin
      dgBoundaryFlux.RowCount := Max(BoundaryValue.Count, Solution.Count) + 1;
      rgBoundaryType.ItemIndex := Integer(btFlux);
      // UsedTimes.Clear is not really needed here
      // but if another boundary were stored before this,
      // it would be.
      UsedTimes.Clear;
      // Make a list of the times for the boundary condition.
      // In PHAST, the first time must always be zero.
      UsedTimes.AddUnique(0);
      for Local_Index := 0 to BoundaryValue.Count - 1 do
      begin
        UsedTimes.AddUnique((BoundaryValue.Items[Local_Index]
          as TRealPhastBoundaryCondition).Time);
      end;
      for Local_Index1 := 0 to Solution.Count - 1 do
      begin
        UsedTimes.AddUnique((Solution.Items[Local_Index1]
          as TIntegerPhastBoundaryCondition).Time);
      end;
      // store the times for the boundary condition.
      seBoundaryTimes.Value := UsedTimes.Count;
      for Local_Index2 := 0 to UsedTimes.Count - 1 do
      begin
        dgBoundaryFlux.Cells[Ord(ibcTime), Local_Index2 + 1]
          := FloatToStr(UsedTimes[Local_Index2]);
      end;
      for Local_Index3 := 0 to BoundaryValue.Count - 1 do
      begin
        RealBoundary := BoundaryValue.Items[Local_Index3]
          as TRealPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(RealBoundary.Time) + 1;
        if not RealBoundary.UsePHAST_Interpolation then
        begin
          dgBoundaryFlux.Cells[Ord(ibcBoundaryValue), RowIndex]
            := RealBoundary.FormulaExpression;
        end;
        dgBoundaryFlux.Checked[Ord(ibcBoundaryInterpolate), RowIndex]
          := RealBoundary.UsePHAST_Interpolation;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(RealBoundary);
        dgBoundaryFlux.Objects[Ord(ibcBoundaryValue), RowIndex]
          := InterpValuesCollection;
        dgBoundaryFlux.Objects[Ord(ibcBoundaryInterpolate), RowIndex]
          := InterpValuesCollection;
      end;
      for Local_Index4 := 0 to Solution.Count - 1 do
      begin
        IntegerBoundary := Solution.Items[Local_Index4]
          as TIntegerPhastBoundaryCondition;
        RowIndex := UsedTimes.IndexOf(IntegerBoundary.Time) + 1;
        if not IntegerBoundary.UsePHAST_Interpolation then
        begin
          dgBoundaryFlux.Cells[Ord(ibcSolution), RowIndex]
            := IntegerBoundary.FormulaExpression;
        end;
        dgBoundaryFlux.Checked[Ord(ibcSolutionInterpolate), RowIndex]
          := IntegerBoundary.UsePHAST_Interpolation;
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        InterpValuesItem := InterpValuesCollection.Add as TInterpValuesItem;
        InterpValuesItem.Values.Assign(IntegerBoundary);
        dgBoundaryFlux.Objects[Ord(ibcSolution), RowIndex]
          := InterpValuesCollection;
        dgBoundaryFlux.Objects[Ord(ibcSolutionInterpolate), RowIndex]
          := InterpValuesCollection;
      end;
    end
    else
    begin
      dgBoundaryFlux.RowCount := 2;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetPhastBoundariesForSingleObject;
var
  UsedTimes: TRealList;
begin
  // Store boundary condition data.
  UsedTimes := TRealList.Create;
  try
    UsedTimes.Sorted := True;
    GetPhastFluxBoundaryForSingleObject(UsedTimes);
    GetPhastLeakyBoundaryForSingleObject(UsedTimes);
    GetPhastRiverBoundaryForSingleObject(UsedTimes);
    GetPhastSpecifiedHeadBoundaryForSingleObject(UsedTimes);
    GetPhastWellBoundaryForSingleObject(UsedTimes);
  finally
    UsedTimes.Free;
  end;
end;

procedure TfrmScreenObjectProperties.InitializePhastBoundaryControls;
begin
  InitializePhastSpecifiedHeadGrid;
  InitializePhastSpecifiedFluxGrid;
  InitializePhastLeakyBoundaryGrid;
  InitializePhastRiverBoundaryGrid;
  InitializePhastWellGrid;
  SetColWidthsInPhastBoundaryGrids;
  pcPhastBoundaries.ActivePageIndex := 0;
  comboWellIntervalStyleChange(nil);
  pnlBoundaries.Constraints.MinWidth := pnlBoundaries.Width;
end;

procedure TfrmScreenObjectProperties.SetColWidthsInPhastBoundaryGrids;
var
  GridList: TList;
  Index: Integer;
  Grid: TRbwDataGrid4;
  ColIndex: Integer;
begin
  GridList := TList.Create;
  try
    GridList.Add(dgSpecifiedHead);
    GridList.Add(dgBoundaryFlux);
    GridList.Add(dgBoundaryLeaky);
    GridList.Add(dgBoundaryRiver);
    GridList.Add(dgWell);
    for Index := 0 to GridList.Count - 1 do
    begin
      Grid := GridList[Index];
      for ColIndex := 0 to Grid.ColCount - 1 do
      begin
        if Grid.Columns[ColIndex].ButtonUsed and (Grid.ColWidths[ColIndex] < Grid.Columns[ColIndex].ButtonWidth + 40) then
        begin
          Grid.ColWidths[ColIndex] := Grid.Columns[ColIndex].ButtonWidth + 40;
        end;
      end;
    end;
  finally
    GridList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.InitializePhastWellGrid;
begin
  dgWell.Cells[Ord(nicTime), 0] := StrTime;
  dgWell.Cells[Ord(nicBoundaryValue), 0] := StrPumpingRate;
  dgWell.Cells[Ord(nicSolution), 0] := StrSolution;
  dgWell.Cells[Ord(nicTime), 1] := '0';
  dgWell.Row := 1;
  dgWell.Column := 2;
  dgWell.Columns[Ord(nicBoundaryValue)].AutoAdjustColWidths := False;
  dgWell.Columns[Ord(nicSolution)].AutoAdjustColWidths := False;
  dgWell.Columns[Ord(nicBoundaryValue)].ButtonFont := Font;
  dgWell.Columns[Ord(nicSolution)].ButtonFont := Font;
end;

procedure TfrmScreenObjectProperties.InitializePhastRiverBoundaryGrid;
begin
  dgBoundaryRiver.Cells[Ord(nicTime), 0] := StrTime;
  dgBoundaryRiver.Cells[Ord(nicBoundaryValue), 0] := StrHead;
  dgBoundaryRiver.Cells[Ord(nicSolution), 0] := StrAssociatedSolution;
  dgBoundaryRiver.Cells[Ord(nicTime), 1] := '0';
  dgBoundaryRiver.Col := 2;
  dgBoundaryRiver.RowHeights[0] := dgBoundaryRiver.RowHeights[0] * 2;
  dgBoundaryRiver.Columns[Ord(nicBoundaryValue)].AutoAdjustColWidths := False;
  dgBoundaryRiver.Columns[Ord(nicSolution)].AutoAdjustColWidths := False;
  dgBoundaryRiver.Columns[Ord(nicBoundaryValue)].ButtonFont := Font;
  dgBoundaryRiver.Columns[Ord(nicSolution)].ButtonFont := Font;
end;

procedure TfrmScreenObjectProperties.InitializePhastLeakyBoundaryGrid;
begin
  dgBoundaryLeaky.Cells[Ord(ibcTime), 0] := StrTime;
  dgBoundaryLeaky.Cells[Ord(ibcBoundaryValue), 0] := StrHead;
  dgBoundaryLeaky.Cells[Ord(ibcBoundaryInterpolate), 0] := StrInterpolateHead;
  dgBoundaryLeaky.Cells[Ord(ibcSolution), 0] := StrAssociatedSolution;
  dgBoundaryLeaky.Cells[Ord(ibcSolutionInterpolate), 0]
    := StrInterpolateSolution;
  dgBoundaryLeaky.Cells[Ord(ibcTime), 1] := '0';
  dgBoundaryLeaky.Col := 2;
  dgBoundaryLeaky.RowHeights[0] := dgBoundaryLeaky.RowHeights[0] * 2;
  dgBoundaryLeaky.Columns[Ord(ibcBoundaryValue)].AutoAdjustColWidths := False;
  dgBoundaryLeaky.Columns[Ord(ibcSolution)].AutoAdjustColWidths := False;
  dgBoundaryLeaky.Columns[Ord(ibcBoundaryValue)].ButtonFont := Font;
  dgBoundaryLeaky.Columns[Ord(ibcSolution)].ButtonFont := Font;
end;

procedure TfrmScreenObjectProperties.InitializePhastSpecifiedFluxGrid;
begin
  dgBoundaryFlux.Cells[Ord(ibcTime), 0] := StrTime;
  dgBoundaryFlux.Cells[Ord(ibcBoundaryValue), 0] := StrFlux;
  dgBoundaryFlux.Cells[Ord(ibcBoundaryInterpolate), 0] := StrInterpolateFlux;
  dgBoundaryFlux.Cells[Ord(ibcSolution), 0] := StrAssociatedSolution;
  dgBoundaryFlux.Cells[Ord(ibcSolutionInterpolate), 0]
    := StrInterpolateSolution;
  dgBoundaryFlux.Cells[Ord(ibcTime), 1] := '0';
  dgBoundaryFlux.Col := 2;
  dgBoundaryFlux.RowHeights[0] := dgBoundaryFlux.RowHeights[0] * 2;
  dgBoundaryFlux.Columns[Ord(ibcBoundaryValue)].AutoAdjustColWidths := False;
  dgBoundaryFlux.Columns[Ord(ibcSolution)].AutoAdjustColWidths := False;
  dgBoundaryFlux.Columns[Ord(ibcBoundaryValue)].ButtonFont := Font;
  dgBoundaryFlux.Columns[Ord(ibcSolution)].ButtonFont := Font;
end;

procedure TfrmScreenObjectProperties.InitializePhastSpecifiedHeadGrid;
begin
  dgSpecifiedHead.Cells[Ord(ibcTime), 0] := StrTime;
  dgSpecifiedHead.Cells[Ord(ibcBoundaryValue), 0] := StrHead;
  dgSpecifiedHead.Cells[Ord(ibcBoundaryInterpolate), 0] := StrInterpolateHead;
  dgSpecifiedHead.Cells[Ord(ibcSolution), 0] := StrAssociatedSolution;
  dgSpecifiedHead.Cells[Ord(ibcSolutionInterpolate), 0]
    := StrInterpolateSolution;
  dgSpecifiedHead.Cells[Ord(ibcTime), 1] := '0';
  dgSpecifiedHead.Col := 2;
  dgSpecifiedHead.RowHeights[0] := dgSpecifiedHead.RowHeights[0] * 2;
  dgSpecifiedHead.Columns[Ord(ibcBoundaryValue)].AutoAdjustColWidths := False;
  dgSpecifiedHead.Columns[Ord(ibcSolution)].AutoAdjustColWidths := False;
  dgSpecifiedHead.Columns[Ord(ibcBoundaryValue)].ButtonFont := Font;
  dgSpecifiedHead.Columns[Ord(ibcSolution)].ButtonFont := Font;
end;

procedure TfrmScreenObjectProperties.InitializeVertexGrid;
begin
  dgVerticies.Cells[Ord(vcSection), 0] := StrSectionNumber;
  dgVerticies.Cells[Ord(vcX), 0] := StrX;
  dgVerticies.Cells[Ord(vcY), 0] := StrY;
  dgVerticies.Cells[Ord(vcNewSection), 0] := StrNewSection;
end;

procedure TfrmScreenObjectProperties.SetSelectedMfBoundaryNode;
var
  SelectedMfBoundaryNode: TTreeNode;
begin
  SelectedMfBoundaryNode := jvtlModflowBoundaryNavigator.Items.GetFirstNode;
  while SelectedMfBoundaryNode <> nil do
  begin
    if SelectedMfBoundaryNode.StateIndex <> 1 then
    begin
      break;
    end;
    SelectedMfBoundaryNode := SelectedMfBoundaryNode.GetNext;
  end;
  if SelectedMfBoundaryNode = nil then
  begin
    SelectedMfBoundaryNode := jvtlModflowBoundaryNavigator.Items.GetFirstNode;
  end;
  jvtlModflowBoundaryNavigator.Selected := SelectedMfBoundaryNode;
end;

procedure TfrmScreenObjectProperties.SetSelectedSutraBoundaryNode;
var
  SelectedSutraBoundaryNode: TTreeNode;
begin
  SelectedSutraBoundaryNode := jvpltvSutraFeatures.Items.GetFirstNode;
  while SelectedSutraBoundaryNode <> nil do
  begin
    if SelectedSutraBoundaryNode.StateIndex <> 1 then
    begin
      break;
    end;
    SelectedSutraBoundaryNode := SelectedSutraBoundaryNode.GetNext;
  end;
  if SelectedSutraBoundaryNode = nil then
  begin
    SelectedSutraBoundaryNode := jvpltvSutraFeatures.Items.GetFirstNode;
  end;
  if SelectedSutraBoundaryNode = nil then
  begin
    jvplSutraFeatures.ActivePage := jvspSutraBlank;
  end
  else
  begin
    jvpltvSutraFeatures.Selected := SelectedSutraBoundaryNode;
  end;
end;

procedure TfrmScreenObjectProperties.CreateUzfNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FUZF_Node := nil;
  if frmGoPhast.PhastModel.UzfIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.UzfPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspUzf.PageIndex;
    frameScreenObjectUZF.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FUZF_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateCfpRechargeNode;
var
  Node: TJvPageIndexNode;
begin
  FCRCH_Node := nil;
  if frmGoPhast.PhastModel.CfpRechargeIsSelected(nil) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      StrCRCHConduitRechar)
      as TJvPageIndexNode;
    Node.PageIndex := jvspCfpRechargeFraction.PageIndex;
    frameCfpRechargeFraction.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FCRCH_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSfrNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FSFR_Node := nil;
  if frmGoPhast.PhastModel.SfrIsSelected
    and (AScreenObject.ViewDirection = vdTop)
    and not AScreenObject.Closed then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.SFRPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspSFR.PageIndex;
    frameScreenObjectSFR.ISFROPT :=
      frmGoPhast.PhastModel.ModflowPackages.SFRPackage.ISFROPT;
    frameScreenObjectSFR.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSFR_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateStrNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FSTR_Node := nil;
  if frmGoPhast.PhastModel.StrIsSelected
    and (AScreenObject.ViewDirection = vdTop)
    and not AScreenObject.Closed then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.STRPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspSTR.PageIndex;
    frameScreenObjectSTR.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSTR_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSwiObsNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FSWiObs_Node := nil;
{$IFNDEF SWIObs}
  Exit;
{$ENDIF}
  if frmGoPhast.PhastModel.SwiObsUsed(nil)
    and (AScreenObject.Count = 1) then
//    and (AScreenObject.ElevationCount = ecOne) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.SwiPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspSWI_Obs.PageIndex;
    frameSwiObs.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSWiObs_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateHobNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FHob_Node := nil;
  if frmGoPhast.PhastModel.HobIsSelected
    and (AScreenObject.ViewDirection = vdTop)
    and (AScreenObject.Count = 1) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.HobPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspHOB.PageIndex;
    frameHeadObservations.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FHob_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateHfbNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FHfb_Node := nil;
  if frmGoPhast.PhastModel.HfbIsSelected
    and (AScreenObject.ViewDirection = vdTop)
    and (AScreenObject.Count > 1) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.HFBPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspHFB.PageIndex;
    frameHfbBoundary.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FHfb_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateHydmodNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FHydmod_Node := nil;
  if frmGoPhast.PhastModel.HydmodIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.HydmodPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspHydmod.PageIndex;
    frameHydmod.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FHydmod_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateLakNode;
var
  Node: TJvPageIndexNode;
begin
  FLAK_Node := nil;
  if frmGoPhast.PhastModel.LakIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.LakPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspLak.PageIndex;
    frameLak.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FLAK_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateMnw2Node;
var
  Node: TJvPageIndexNode;
begin
  FMNW2_Node := nil;
  if frmGoPhast.PhastModel.Mnw2IsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.MNW2Package.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspMNW2.PageIndex;
    frameMNW2.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FMNW2_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateMnw1Node;
var
  Node: TJvPageIndexNode;
begin
  FMNW1_Node := nil;
  if frmGoPhast.PhastModel.Mnw1IsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.MNW1Package.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspMNW1.PageIndex;
    frameMNW1.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FMNW1_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateResNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FRES_Node := nil;
  if frmGoPhast.PhastModel.ResIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.ResPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspRES.PageIndex;
    frameRes.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FRES_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSWR_Rain_Node(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FSWR_Rain_Node := nil;
  if frmGoPhast.PhastModel.SwrIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, 'Rain in ' +
      frmGoPhast.PhastModel.ModflowPackages.SwrPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspSWR_Rain.PageIndex;
    frameSWR_Rain.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSWR_Rain_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSWR_Reach_Node(
  AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FSWR_Reach_Node := nil;
  if frmGoPhast.PhastModel.SwrIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, 'Reaches in ' +
      frmGoPhast.PhastModel.ModflowPackages.SwrPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspSwrReaches.PageIndex;
    frameSwrReach.frameSwr.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSWR_Reach_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSWR_Stage_Node(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FSWR_Stage_Node := nil;
  if frmGoPhast.PhastModel.SwrIsSelected
    and (AScreenObject.ViewDirection = vdTop)
    and (frmGoPhast.PhastModel.ModflowPackages.SwrPackage.StageSpecification = smArray) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, 'Stage in ' +
      frmGoPhast.PhastModel.ModflowPackages.SwrPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspSWR_Stage.PageIndex;
    frameSWR_Stage.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSWR_Stage_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSWR_DirectRunoff_Node(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FSWR_DirectRunoff_Node := nil;
  if frmGoPhast.PhastModel.SwrIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, 'Direct Runoff in ' +
      frmGoPhast.PhastModel.ModflowPackages.SwrPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspSWR_DirectRunoff.PageIndex;
    frameSWR_DirectRunoff.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSWR_DirectRunoff_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSWR_Evap_Node(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FSWR_Evap_Node := nil;
  if frmGoPhast.PhastModel.SwrIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, 'Evaporation in ' +
      frmGoPhast.PhastModel.ModflowPackages.SwrPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspSWR_Evap.PageIndex;
    frameSWR_Evap.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSWR_Evap_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSWR_LatInflow_Node(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FSWR_LatInflow_Node := nil;
  if frmGoPhast.PhastModel.SwrIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, 'Lateral Inflow in ' +
      frmGoPhast.PhastModel.ModflowPackages.SwrPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspSWR_LatInfl.PageIndex;
    frameSWR_LatInfl.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSWR_LatInflow_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateEtsNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FETS_Node := nil;
  if frmGoPhast.PhastModel.EtsIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.EtsPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspETS.PageIndex;
    frameEtsParam.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FETS_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateEvtNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FEVT_Node := nil;
  if frmGoPhast.PhastModel.EvtIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.EvtPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspEVT.PageIndex;
    frameEvtParam.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FEVT_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateRchNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FRCH_Node := nil;
  if frmGoPhast.PhastModel.RchIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.RchPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspRCH.PageIndex;
    frameRchParam.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FRCH_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateDrtNode;
var
  Node: TJvPageIndexNode;
begin
  FDRT_Node := nil;
  if frmGoPhast.PhastModel.DrtIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.DrtPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspDRT.PageIndex;
    frameDrtParam.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FDRT_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateDrnNode;
var
  Node: TJvPageIndexNode;
begin
  FDRN_Node := nil;
  if frmGoPhast.PhastModel.DrnIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.DrnPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspDRN.PageIndex;
    frameDrnParam.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FDRN_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateRivNode;
var
  Node: TJvPageIndexNode;
begin
  FRIV_Node := nil;
  if frmGoPhast.PhastModel.RivIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.RivPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspRIV.PageIndex;
    frameRivParam.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FRIV_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateChobNode;
begin
  CreateFluxNode(FChob_Node, frmGoPhast.PhastModel.ModflowPackages.ChobPackage,
    frameChob, jvspCHOB, frmGoPhast.PhastModel.HeadFluxObservations);
end;

procedure TfrmScreenObjectProperties.CreateDrobNode;
begin
  CreateFluxNode(FDrob_Node, frmGoPhast.PhastModel.ModflowPackages.DrobPackage,
    frameDrob, jvspDROB, frmGoPhast.PhastModel.DrainObservations);
end;

procedure TfrmScreenObjectProperties.CreateGbobNode;
begin
  CreateFluxNode(FGbob_Node, frmGoPhast.PhastModel.ModflowPackages.GbobPackage,
    frameGbob, jvspGBOB, frmGoPhast.PhastModel.GhbObservations);
end;

procedure TfrmScreenObjectProperties.CreateRvobNode;
begin
  CreateFluxNode(FRvob_Node, frmGoPhast.PhastModel.ModflowPackages.RvobPackage,
    frameRvob, jvspRVOB, frmGoPhast.PhastModel.RiverObservations);
end;

procedure TfrmScreenObjectProperties.CreateStobNode;
begin
  CreateFluxNode(FStob_Node, frmGoPhast.PhastModel.ModflowPackages.StobPackage,
    frameStob, jvspSTOB, frmGoPhast.PhastModel.StreamObservations);
end;

procedure TfrmScreenObjectProperties.CreateMt3dmsSsmNode;
var
  Node: TJvPageIndexNode;
begin
  FMt3dmsSsm_Node := nil;
  if frmGoPhast.PhastModel.Mt3dmsSsmIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.Mt3dmsSourceSink.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspMT3DMS_SSM.PageIndex;
    frameMT3DMS_SSM.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FMt3dmsSsm_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateMt3dmsTobFluxNode;
var
  Node: TJvPageIndexNode;
begin
  FMt3dmsTobFlux_Node := nil;
  if frmGoPhast.PhastModel.Mt3dmsTobIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      StrFluxObserv +
      frmGoPhast.PhastModel.ModflowPackages.Mt3dmsTransObs.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspMT3DMS_TOB_Flux.PageIndex;
    frameMt3dmsFluxObs.lblFluxObservations.Caption := Node.Text;
    Node.ImageIndex := 1;
    FMt3dmsTobFlux_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateMt3dmsTobConcNode;
var
  Node: TJvPageIndexNode;
begin
  FMt3dmsTobConc_Node := nil;
  if frmGoPhast.PhastModel.Mt3dmsTobIsSelected
    and (AScreenObject.ViewDirection = vdTop)
    and (AScreenObject.Count = 1) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      StrConcentrationObserv +
      frmGoPhast.PhastModel.ModflowPackages.Mt3dmsTransObs.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspMT3DMS_TOB_Conc.PageIndex;
    frameMt3dmsTobConc.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FMt3dmsTobConc_Node := Node;
  end;
end;


procedure TfrmScreenObjectProperties.CreateModpathNode;
var
  Node: TJvPageIndexNode;
begin
  FModpath_Node := nil;
  if frmGoPhast.PhastModel.MODPATHIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.MODPATH.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspModpath.PageIndex;
//    frameModpath.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FModpath_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateWelNode;
var
  Node: TJvPageIndexNode;
begin
  FWEL_Node := nil;
  if frmGoPhast.PhastModel.WelIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.WelPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspWell.PageIndex;
    frameWellParam.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FWEL_Node := Node;   
  end;
end;

procedure TfrmScreenObjectProperties.CreateFarmWelNode;
var
  Node: TJvPageIndexNode;
begin
  FFarmWell_Node := nil;
  if frmGoPhast.PhastModel.FarmProcessIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, Format(StrFarmWellsInS,
      [frmGoPhast.PhastModel.ModflowPackages.FarmProcess.PackageIdentifier]))
      as TJvPageIndexNode;
    Node.PageIndex := jvspFarmWell.PageIndex;
    frameFarmWell.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FFarmWell_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateFarmPrecipNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FFarmPrecip_Node := nil;
  if frmGoPhast.PhastModel.FarmProcessIsSelected
    and (frmGoPhast.PhastModel.ModflowPackages.
    FarmProcess.Precipitation = pSpatiallyDistributed)
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, Format(StrFarmPrecipInS,
      [frmGoPhast.PhastModel.ModflowPackages.FarmProcess.PackageIdentifier]))
      as TJvPageIndexNode;
    Node.PageIndex := jvspFarmPrecip.PageIndex;
    frameFarmPrecip.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FFarmPrecip_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateFarmRefEvapNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FFarmRevEvap_Node := nil;
  if frmGoPhast.PhastModel.FarmProcessIsSelected
    and (frmGoPhast.PhastModel.ModflowPackages.
    FarmProcess.ConsumptiveUse in
    [cuPotentialAndReferenceET, cuCropCoefficient])
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, Format(StrFarmRefEvapIn,
      [frmGoPhast.PhastModel.ModflowPackages.FarmProcess.PackageIdentifier]))
      as TJvPageIndexNode;
    Node.PageIndex := jvspFarmRefEvap.PageIndex;
    frameFarmRefEvap.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FFarmRevEvap_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateFarmCropIDNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FFarmCropID_Node := nil;
  if frmGoPhast.PhastModel.FarmProcessIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, Format(StrCropIDInS,
      [frmGoPhast.PhastModel.ModflowPackages.FarmProcess.PackageIdentifier]))
      as TJvPageIndexNode;
    Node.PageIndex := jvspFarmCropID.PageIndex;
    frameFarmCropID.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FFarmCropID_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateFarmIDNode(
  AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FFarmID_Node := nil;
  if frmGoPhast.PhastModel.FarmProcessIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil, Format(StrFarmIDInS,
      [frmGoPhast.PhastModel.ModflowPackages.FarmProcess.PackageIdentifier]))
      as TJvPageIndexNode;
    Node.PageIndex := jvspFarmID.PageIndex;
    frameFarmID.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FFarmID_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateGageNode;
var
  Node: TJvPageIndexNode;
begin
  FGage_Node := nil;
  if frmGoPhast.PhastModel.SfrIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      Format(StrGAGEForS, [StringReplace(
      frmGoPhast.PhastModel.ModflowPackages.SfrPackage.PackageIdentifier,
      ':', '', [rfReplaceAll])]))
      as TJvPageIndexNode;
    Node.PageIndex := jvspGAGE.PageIndex;
    lblGageCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FGage_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateGhbNode;
var
  Node: TJvPageIndexNode;
begin
  FGHB_Node := nil;
  if frmGoPhast.PhastModel.GhbIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.GhbBoundary.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspGHB.PageIndex;
    frameGhbParam.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FGHB_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSutraObsNode;
var
  Node: TJvPageIndexNode;
  LocalModel: TPhastModel;
begin
  FSutraObs_Node := nil;
  LocalModel := frmGoPhast.PhastModel;
  if (LocalModel.ModelSelection in SutraSelection)
    and (LocalModel.SutraMesh <> nil)
    and ((LocalModel.SutraMesh.MeshType in [mt2D, mtProfile])
    or (rgElevationCount.ItemIndex in [1,2])) then
  begin
    Node := jvpltvSutraFeatures.Items.AddChild(nil,
      StrSutraObservations) as TJvPageIndexNode;
    Node.PageIndex := jvspSutraObservations.PageIndex;
    frameSutraObservations.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSutraObs_Node := Node;
    frameSutraObservations.RefreshNodeState;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSutraLakeNode;
{$IFDEF SUTRA30}
var
  Node: TJvPageIndexNode;
{$ENDIF}
begin
  FSutraLake_Node := nil;
{$IFDEF SUTRA30}
  if ShouldCreateSutraLakeBoundary then
  begin
    Node := jvpltvSutraFeatures.Items.AddChild(nil,
      'Lake') as TJvPageIndexNode;
    Node.PageIndex := jvspSutraLake.PageIndex;
    frameSutraLake.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSutraLake_Node := Node;
    frameSutraLake.RefreshNodeState;
  end;
{$ENDIF}
end;


procedure TfrmScreenObjectProperties.CreateSutraSpecPressNode;
var
  Node: TJvPageIndexNode;
  NodeName: string;
begin
  FSutraSpecPressure_Node := nil;
  if ShouldCreateSutraBoundary then
  begin
    NodeName := '';
    case frmGoPhast.PhastModel.SutraOptions.TransportChoice of
      tcSolute, tcEnergy:
        begin
          NodeName := StrSpecifiedPressure;
        end;
      tcSoluteHead:
        begin
          NodeName := StrSutraSpecifiedHead;
        end;
      else
        Assert(False);
    end;
    Node := jvpltvSutraFeatures.Items.AddChild(nil,
      NodeName) as TJvPageIndexNode;
    Node.PageIndex := jvspSutraSpecifiedPressure.PageIndex;
    frameSutraSpecifiedPressure.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSutraSpecPressure_Node := Node;
    frameSutraSpecifiedPressure.RefreshNodeState;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSutraSpecTempConcNode;
var
  Node: TJvPageIndexNode;
  TransportChoice: TTransportChoice;
begin
  FSutraSpecTempConc_Node := nil;
  if ShouldCreateSutraBoundary then
  begin
    Node := nil;
    TransportChoice := frmGoPhast.PhastModel.SutraOptions.TransportChoice;
    case TransportChoice of
      tcSolute, tcSoluteHead:
        begin
          Node := jvpltvSutraFeatures.Items.AddChild(nil,
            StrSpecifiedConc) as TJvPageIndexNode;
        end;
      tcEnergy:
        begin
          Node := jvpltvSutraFeatures.Items.AddChild(nil,
            StrSpecifiedTemp) as TJvPageIndexNode;
        end;
      else Assert(False);
    end;
    Node.PageIndex := jvspSutraSpecTempConc.PageIndex;
    frameSutraSpecTempConc.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSutraSpecTempConc_Node := Node;
    frameSutraSpecTempConc.RefreshNodeState;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSutraFluidFluxNode;
var
  Node: TJvPageIndexNode;
begin
  FSutraFluidFlux_Node := nil;
  if ShouldCreateSutraBoundary then
  begin
    Node := jvpltvSutraFeatures.Items.AddChild(nil,
      StrFluidFlux) as TJvPageIndexNode;
    Node.PageIndex := jvspSutraFluidFlux.PageIndex;
    frameSutraFluidFlux.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSutraFluidFlux_Node := Node;
    frameSutraFluidFlux.RefreshNodeState;
  end;
end;

procedure TfrmScreenObjectProperties.CreateSutraMassEnergyFluxNode;
var
  Node: TJvPageIndexNode;
  TransportChoice: TTransportChoice;
begin
  FSutraMassEnergyFlux_Node := nil;
  if ShouldCreateSutraBoundary then
  begin
    Node := nil;
    TransportChoice := frmGoPhast.PhastModel.SutraOptions.TransportChoice;
    case TransportChoice of
      tcSolute, tcSoluteHead:
        begin
          Node := jvpltvSutraFeatures.Items.AddChild(nil,
            StrMassFlux) as TJvPageIndexNode;
        end;
      tcEnergy:
        begin
          Node := jvpltvSutraFeatures.Items.AddChild(nil,
            StrEnergyFlux) as TJvPageIndexNode;
        end;
      else Assert(False);
    end;
    Node.PageIndex := jvspSutraMassEnergyFlux.PageIndex;
    frameSutraMassEnergyFlux.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FSutraMassEnergyFlux_Node := Node;
    frameSutraMassEnergyFlux.RefreshNodeState;
  end;
end;

procedure TfrmScreenObjectProperties.CreateChdNode;
var
  Node: TJvPageIndexNode;
begin
  FCHD_Node := nil;
  if frmGoPhast.PhastModel.ChdIsSelected then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.ChdBoundary.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspCHD.PageIndex;
    frameChdParam.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FCHD_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateCfpPipeNode(AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FCfpPipe_Node := nil;
  if frmGoPhast.PhastModel.CfpPipesSelected(nil)
    and (AScreenObject.Count > 1) and not AScreenObject.Closed
    {and (AScreenObject.ElevationCount = ecOne)} then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.ConduitFlowProcess.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspCfpPipes.PageIndex;
    frameCfpPipes.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FCfpPipe_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateCfpFixedHeadNode(
  AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FCfpFixedHead_Node := nil;
  if frmGoPhast.PhastModel.CfpPipesSelected(nil)
    and (AScreenObject.ElevationCount in [ecOne, ecTwo]) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      StrCFPFixedHeads)
      as TJvPageIndexNode;
    Node.PageIndex := jvspCfpFixedHeads.PageIndex;
    frameCfpFixedHeads.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FCfpFixedHead_Node := Node;
  end;
end;

procedure TfrmScreenObjectProperties.CreateRipNode(
  AScreenObject: TScreenObject);
var
  Node: TJvPageIndexNode;
begin
  FRipNode := nil;
  if frmGoPhast.PhastModel.RipIsSelected
    and (AScreenObject.ViewDirection = vdTop) then
  begin
    Node := jvtlModflowBoundaryNavigator.Items.AddChild(nil,
      frmGoPhast.PhastModel.ModflowPackages.RipPackage.PackageIdentifier)
      as TJvPageIndexNode;
    Node.PageIndex := jvspRip.PageIndex;
    frameRip.pnlCaption.Caption := Node.Text;
    Node.ImageIndex := 1;
    FRipNode := Node;
  end;
end;

procedure TfrmScreenObjectProperties.UpdateNodeState(Node: TJvPageIndexNode);
begin
  if IsLoaded  and (Node <> nil) then
  begin
    if Node.StateIndex = 1 then
    begin
      Node.StateIndex := 2;
    end;
  end;
end;

function TfrmScreenObjectProperties.ShouldStoreBoundary(Node: TJvPageIndexNode;
  Boundary: TFormulaProperty): boolean;
begin
  result := (Node <> nil) and ((Node.StateIndex = 2)
    or ((Node.StateIndex = 3) and Boundary.Used));
end;

procedure TfrmScreenObjectProperties.GetSwrReaches(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TSwrReachBoundary;
begin
  if not frmGoPhast.PhastModel.SwrIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowSwrReaches;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FSWR_Reach_Node <> nil then
  begin
    FSWR_Reach_Node.StateIndex := Ord(State)+1;
  end;
  frameSwrReach.GetData(FNewProperties, FSWR_Reach_Node);

end;

procedure TfrmScreenObjectProperties.GetSwiObsBoundray(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TSwiObsBoundary;
begin
  if not frmGoPhast.PhastModel.SwiObsUsed(nil) then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowSwiObservations;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FSWiObs_Node <> nil then
  begin
    FSWiObs_Node.StateIndex := Ord(State)+1;
  end;
  frameSwiObs.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetSfrBoundary(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TSfrBoundary;
begin
  if not frmGoPhast.PhastModel.SfrIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowSfrBoundary;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FSFR_Node <> nil then
  begin
    FSFR_Node.StateIndex := Ord(State)+1;
  end;
  frameScreenObjectSFR.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetStrBoundary(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TStrBoundary;
begin
  if not frmGoPhast.PhastModel.StrIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowStrBoundary;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FSTR_Node <> nil then
  begin
    FSTR_Node.StateIndex := Ord(State)+1;
  end;
  frameScreenObjectSTR.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetMnw1Boundary(
  const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TMnw1Boundary;
begin
  if not frmGoPhast.PhastModel.Mnw1IsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowMnw1Boundary;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FMNW1_Node <> nil then
  begin
    FMNW1_Node.StateIndex := Ord(State)+1;
  end;
  frameMNW1.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetMnw2Boundary(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TMnw2Boundary;
begin
  if not frmGoPhast.PhastModel.Mnw2IsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowMnw2Boundary;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FMNW2_Node <> nil then
  begin
    FMNW2_Node.StateIndex := Ord(State)+1;
  end;
  frameMNW2.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetFhbHeadBoundary
  (const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TFhbHeadBoundary;
begin
  if not frmGoPhast.PhastModel.FhbIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowFhbHeadBoundary;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FFhbHead_Node <> nil then
  begin
    FFhbHead_Node.StateIndex := Ord(State)+1;
  end;
  frameFhbHead.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetFarmPrecip
  (const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TFmpPrecipBoundary;
begin
  if not frmGoPhast.PhastModel.FarmProcessIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowFmpPrecip;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;

  if FFarmPrecip_Node <> nil then
  begin
    FFarmPrecip_Node.StateIndex := Ord(State)+1;
  end;
  frameFarmPrecip.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetFarmRefEvap
  (const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TFmpRefEvapBoundary;
begin
  if not frmGoPhast.PhastModel.FarmProcessIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowFmpRefEvap;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;

  if FFarmRevEvap_Node <> nil then
  begin
    FFarmRevEvap_Node.StateIndex := Ord(State)+1;
  end;
  frameFarmRefEvap.GetData(FNewProperties);

  if FFarmCropID_Node <> nil then
  begin
    FFarmCropID_Node.StateIndex := Ord(State)+1;
  end;
  frameFarmCropID.GetData(FNewProperties);

  if FFarmID_Node <> nil then
  begin
    FFarmID_Node.StateIndex := Ord(State)+1;
  end;
  frameFarmID.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetCfpPipes
  (const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TCfpPipeBoundary;
begin
  if not frmGoPhast.PhastModel.CfpIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowCfpPipes;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;

  if FCfpPipe_Node <> nil then
  begin
    FCfpPipe_Node.StateIndex := Ord(State)+1;
  end;
  frameCfpPipes.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetCfpFixedHeads
  (const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TCfpFixedBoundary;
begin
  if not frmGoPhast.PhastModel.CfpIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowCfpFixedHeads;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;

  if FCfpFixedHead_Node <> nil then
  begin
    FCfpFixedHead_Node.StateIndex := Ord(State)+1;
  end;
  frameCfpFixedHeads.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetRip
  (const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TRipBoundary;
begin
  if not frmGoPhast.PhastModel.RipIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowRipBoundary;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;

  if FRipNode <> nil then
  begin
    FRipNode.StateIndex := Ord(State)+1;
  end;
  frameRip.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetFarmCropID
  (const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TFmpCropIDBoundary;
begin
  if not frmGoPhast.PhastModel.FarmProcessIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowFmpCropID;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;

  if FFarmCropID_Node <> nil then
  begin
    FFarmCropID_Node.StateIndex := Ord(State)+1;
  end;
  frameFarmCropID.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetFarmID(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TFmpFarmIDBoundary;
begin
  if not frmGoPhast.PhastModel.FarmProcessIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowFmpFarmID;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;

  if FFarmID_Node <> nil then
  begin
    FFarmID_Node.StateIndex := Ord(State)+1;
  end;
  frameFarmID.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetFhbFlowBoundary
  (const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TFhbFlowBoundary;
begin
  if not frmGoPhast.PhastModel.FhbIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowFhbFlowBoundary;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FFhbFlow_Node <> nil then
  begin
    FFhbFlow_Node.StateIndex := Ord(State)+1;
  end;
  frameFhbFlow.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetHfbBoundary(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: THfbBoundary;
begin
  if not frmGoPhast.PhastModel.HfbIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowHfbBoundary;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FHFB_Node <> nil then
  begin
    FHFB_Node.StateIndex := Ord(State)+1;
  end;
  frameHfbBoundary.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetChildModels(const ScreenObjectList: TList);
var
  AScreenObject: TScreenObject;
  ItemPosition: Integer;
begin
  if clbChildModels.Enabled then
  begin
    AScreenObject := ScreenObjectList[0];
    EnableChildModelList(AScreenObject);
    ItemPosition := FChildModels.IndexOf(AScreenObject.ChildModel)+1;
    clbChildModels.Checked[ItemPosition] := True;
  end;
end;


procedure TfrmScreenObjectProperties.GetHydmod(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  HydmodData: THydmodData;
begin
  if not frmGoPhast.PhastModel.HydmodIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    HydmodData := AScreenObject.ModflowHydmodData;
    UpdateBoundaryState(HydmodData, ScreenObjectIndex, State);
  end;
  if Fhydmod_Node <> nil then
  begin
    Fhydmod_Node.StateIndex := Ord(State)+1;
  end;
  frameHydmod.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetHeadObservations(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: THobBoundary;
begin
  if not frmGoPhast.PhastModel.HobIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowHeadObservations;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FHOB_Node <> nil then
  begin
    FHOB_Node.StateIndex := Ord(State)+1;
  end;
  frameHeadObservations.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetMt3dConcObservations(const ScreenObjectList: TList);
var
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TMt3dmsTransObservations;
begin
  if not frmGoPhast.PhastModel.Mt3dmsTobIsSelected then
  begin
    Exit;
  end;
  State := cbUnchecked;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.Mt3dmsTransObservations;
    UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
  end;
  if FMt3dmsTobConc_Node <> nil then
  begin
    FMt3dmsTobConc_Node.StateIndex := Ord(State)+1;
  end;
  frameMt3dmsTobConc.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.UpdateBoundaryState(
  Boundary: TFormulaProperty; ScreenObjectIndex: Integer;
  var State: TCheckBoxState);
begin
  if Boundary = nil then
  begin
    if ScreenObjectIndex = 0 then
    begin
      State := cbUnchecked;
    end
    else
    begin
      if State = cbChecked then
      begin
        State := cbGrayed;
      end;
    end;
  end
  else
  begin
    if Boundary.Used then
    begin
      if ScreenObjectIndex = 0 then
      begin
        State := cbChecked;
      end
      else
      begin
        if State = cbUnchecked then
        begin
          State := cbGrayed;
        end;
      end;
    end
    else
    begin
      if ScreenObjectIndex = 0 then
      begin
        State := cbUnchecked;
      end
      else
      begin
        if State = cbChecked then
        begin
          State := cbGrayed;
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetUzfCollection(
  TimeList: TParameterTimeList;
  ScreenObjectList: TList;
  ColumnOffset: Integer; DataGrid: TRbwDataGrid4;
  Method: TGetBoundaryCollectionEvent);
var
  BoundaryIndex: Integer;
  RowIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  TimeIndex: Integer;
  AnotherBoundary: TUzfBoundary;
  ScreenObjectIndex: Integer;
  ValuesIdentical: Boolean;
  AnotherValues: TCustomMF_BoundColl;
  AScreenObject: TScreenObject;
  Boundary :TModflowBoundary;
  Values: TCustomMF_BoundColl;
begin
  if not frmGoPhast.PhastModel.UzfIsSelected then
  begin
    Exit;
  end;
  AScreenObject := ScreenObjectList[0];
  Boundary := AScreenObject.ModflowUzfBoundary;
  if Boundary = nil then
  begin
    Values := nil;
  end
  else
  begin
    Values := Method(Boundary);
  end;
  ValuesIdentical := True;
  for ScreenObjectIndex := 1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowUzfBoundary;
    if (Boundary = nil) and (AnotherBoundary = nil) then
    begin
      ValuesIdentical := True;
    end
    else if (Boundary = nil) or (AnotherBoundary = nil) then
    begin
      ValuesIdentical := False;
    end
    else
    begin
      AnotherValues := Method(AnotherBoundary);
      ValuesIdentical := Values.IsSame(AnotherValues);
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Values <> nil) then
  begin
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
      RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
      Assert(RowIndex >= 1);
      for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex] :=
          Item.BoundaryFormula[BoundaryIndex];
      end;
    end;
  end;
end;

function TfrmScreenObjectProperties.DataSetsSpecified: Boolean;
var
  Index: Integer;
  Edit: TScreenObjectDataEdit;
begin
  result := False;
  for Index := 0 to FDataEdits.Count - 1 do
  begin
    Edit := FDataEdits[Index];
    if Edit.Used <> cbUnchecked then
    begin
      result := True;
      Exit;
    end;
  end;
end;

destructor TfrmScreenObjectProperties.Destroy;
begin

  try
    inherited;
  except on EExternalException do
    begin
      // work around for bug in Microsoft OpenGL driver on 64 bit Windows.
      // do nothing;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.EnableWellTabfile;
begin
  frameWellParam.fedTabfile.ShowButton := ((FWEL_Node <> nil)
    and (FWEL_Node.StateIndex <> 1))
    and frmGoPhast.PhastModel.ModflowPackages.WelPackage.UseTabFilesInThisModel;
  frameWellParam.fedTabfile.ReadOnly :=
    not frameWellParam.fedTabfile.ShowButton;
end;

procedure TfrmScreenObjectProperties.GetModflowBoundaryCollection(
  DataGrid: TRbwDataGrid4; ValuesFunction: TGetBoundaryCollectionEvent;
  ColumnOffset: Integer; ScreenObjectList: TList; Parameter: TParameterType;
  TimeList: TParameterTimeList);
var
  RowIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowParamBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: Boolean;
  ScreenObjectIndex: Integer;
  AnotherBoundary: TModflowParamBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  BoundaryIndex: Integer;
begin
  DataGrid.BeginUpdate;
  try
    AScreenObject := ScreenObjectList[0];
    Boundary := AScreenObject.GetMfBoundary(Parameter);
    if Boundary = nil then
    begin
      Values := nil;
    end
    else
    begin
      Values := ValuesFunction(Boundary);
    end;
    ValuesIdentical := True;
    for ScreenObjectIndex := 1 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      AnotherBoundary := AScreenObject.GetMfBoundary(Parameter);
      if (Boundary = nil) and (AnotherBoundary = nil) then
      begin
        ValuesIdentical := True;
      end
      else if (Boundary = nil) or (AnotherBoundary = nil) then
      begin
        ValuesIdentical := False;
      end
      else
      begin
        ValuesIdentical := Values.IsSame(ValuesFunction(AnotherBoundary));
      end;
      if not ValuesIdentical then
      begin
        break;
      end;
    end;
    if ValuesIdentical and (Values <> nil) then
    begin
      for TimeIndex := 0 to Values.Count - 1 do
      begin
        Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
        RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
        Assert(RowIndex >= 1);
        for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
        begin
          DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex]
            := Item.BoundaryFormula[BoundaryIndex];
        end;
      end;
    end;
  finally
    DataGrid.EndUpdate;
  end;
end;

procedure TfrmScreenObjectProperties.GetReservoirBoundaryCollection(
  DataGrid: TRbwDataGrid4; ColumnOffset: Integer; ScreenObjectList: TList;
  TimeList: TParameterTimeList);
var
  RowIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: Boolean;
  ScreenObjectIndex: Integer;
  AnotherBoundary: TModflowBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  BoundaryIndex: Integer;
begin
  AScreenObject := ScreenObjectList[0];
  Boundary := AScreenObject.ModflowResBoundary;
  if Boundary = nil then
  begin
    Values := nil;
  end
  else
  begin
    Values := Boundary.Values;
  end;
  ValuesIdentical := True;
  for ScreenObjectIndex := 1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowResBoundary;
    if (Boundary = nil) and (AnotherBoundary = nil) then
    begin
      ValuesIdentical := True;
    end
    else if (Boundary = nil) or (AnotherBoundary = nil) then
    begin
      ValuesIdentical := False;
    end
    else
    begin
      ValuesIdentical := Values.IsSame(AnotherBoundary.Values);
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Values <> nil) then
  begin
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
      RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
      Assert(RowIndex >= 1);
      for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex]
          := Item.BoundaryFormula[BoundaryIndex];
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetMt3dmsBoundaryCollection(
  DataGrid: TRbwDataGrid4; ColumnOffset: Integer; ScreenObjectList: TList;
  TimeList: TParameterTimeList);
var
  RowIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TMt3dmsConcBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: Boolean;
  ScreenObjectIndex: Integer;
  AnotherBoundary: TMt3dmsConcBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  BoundaryIndex: Integer;
  FirstIndex: integer;
  ColIndex: Integer;
begin
  FirstIndex := -1;
  Boundary := nil;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.Mt3dmsConcBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      FirstIndex := ScreenObjectIndex;
      break;
    end;
  end;
  if FirstIndex < 0 then
  begin
    frameMT3DMS_SSM.seNumberOfTimes.AsInteger := 0;
    if Assigned(frameMT3DMS_SSM.seNumberOfTimes.OnChange) then
    begin
      frameMT3DMS_SSM.seNumberOfTimes.OnChange(frameMT3DMS_SSM.seNumberOfTimes);
    end;
    Exit;
  end;
  for ColIndex := ColumnOffset to DataGrid.ColCount - 1 do
  begin
    for RowIndex := DataGrid.FixedRows to DataGrid.RowCount - 1 do
    begin
      DataGrid.Cells[ColIndex,RowIndex] := '';
    end;
  end;
  Assert(Boundary <> nil);
  Values := Boundary.Values;
  ValuesIdentical := True;
  for ScreenObjectIndex := FirstIndex+1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.Mt3dmsConcBoundary;
    if (AnotherBoundary <> nil) and AnotherBoundary.Used then
    begin
      ValuesIdentical := Values.IsSame(AnotherBoundary.Values);
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Values <> nil) then
  begin
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
      RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
      Assert(RowIndex >= 1);
      for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex]
          := Item.BoundaryFormula[BoundaryIndex];
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetLakeBoundaryCollection(
  DataGrid: TRbwDataGrid4; ColumnOffset: Integer; ScreenObjectList: TList;
  TimeList: TParameterTimeList);
var
  RowIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TLakBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: Boolean;
  ScreenObjectIndex: Integer;
  AnotherBoundary: TLakBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  BoundaryIndex: Integer;
  FirstIndex: integer;
  ColIndex: Integer;
  ExternalLakeTable: TExternalLakeTable;
  BathItem: TLakeTableItem;
  Index: integer;
begin
  frameLak.tabBathymetry.TabVisible := (ScreenObjectList.Count = 1)
    and frmGoPhast.PhastModel.LakBathymetryUsed;
  frameLak.tabLakeProperties.TabVisible := frameLak.tabBathymetry.TabVisible;
  frameLak.pcLake.ActivePageIndex := 0;
  FirstIndex := -1;
  Boundary := nil;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowLakBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      FirstIndex := ScreenObjectIndex;
      break;
    end;
  end;
  if FirstIndex < 0 then
  begin
    frameLak.seNumberOfTimes.AsInteger := 0;
    if Assigned(frameLak.seNumberOfTimes.OnChange) then
    begin
      frameLak.seNumberOfTimes.OnChange(frameLak.seNumberOfTimes);
    end;
    frameLak.rdeLakeID.Text := '';
    frameLak.rdeInitialStage.Text := '';
    frameLak.rdeCenterLake.Text := '';
    frameLak.rdeSill.Text := '';
    frameLak.rdgLakeTable.BeginUpdate;
    try
      for Index := 1 to frameLak.rdgLakeTable.RowCount - 1 do
      begin
        frameLak.rdgLakeTable.Cells[Ord(bcStage), Index] := '';
        frameLak.rdgLakeTable.Cells[Ord(bcVolume), Index] := '';
        frameLak.rdgLakeTable.Cells[Ord(bcSurfaceArea), Index] := '';
      end;
    finally
      frameLak.rdgLakeTable.EndUpdate;
    end;
    Exit;
  end;
  for ColIndex := ColumnOffset to DataGrid.ColCount - 1 do
  begin
    for RowIndex := DataGrid.FixedRows to DataGrid.RowCount - 1 do
    begin
      DataGrid.Cells[ColIndex,RowIndex] := '';
    end;
  end;
  Assert(Boundary <> nil);
  Values := Boundary.Values;
  ValuesIdentical := True;
  for ScreenObjectIndex := FirstIndex+1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowLakBoundary;
    if (AnotherBoundary <> nil) and AnotherBoundary.Used then
    begin
      ValuesIdentical := Values.IsSame(AnotherBoundary.Values);
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Values <> nil) then
  begin
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
      RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
      Assert(RowIndex >= 1);
      for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex]
          := Item.BoundaryFormula[BoundaryIndex];
      end;
    end;
  end;

  ValuesIdentical := True;
  for ScreenObjectIndex := FirstIndex+1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowLakBoundary;
    if (AnotherBoundary <> nil) and AnotherBoundary.Used then
    begin
      ValuesIdentical := Boundary.InitialStage = AnotherBoundary.InitialStage;
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Boundary <> nil) then
  begin
    frameLak.rdeInitialStage.Text := FloatToStr(Boundary.InitialStage);
  end
  else
  begin
    frameLak.rdeInitialStage.Text := '';
  end;

  ValuesIdentical := True;
  for ScreenObjectIndex := FirstIndex+1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowLakBoundary;
    if (AnotherBoundary <> nil) and AnotherBoundary.Used then
    begin
      ValuesIdentical := Boundary.CenterLake = AnotherBoundary.CenterLake;
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Boundary <> nil) then
  begin
    frameLak.rdeCenterLake.Text := IntToStr(Boundary.CenterLake);
  end
  else
  begin
    frameLak.rdeCenterLake.Text := '';
  end;

  ValuesIdentical := True;
  for ScreenObjectIndex := FirstIndex+1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowLakBoundary;
    if (AnotherBoundary <> nil) and AnotherBoundary.Used then
    begin
      ValuesIdentical := Boundary.Sill = AnotherBoundary.Sill;
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Boundary <> nil) then
  begin
    frameLak.rdeSill.Text := FloatToStr(Boundary.Sill);
  end
  else
  begin
    frameLak.rdeSill.Text := '';
  end;

  ValuesIdentical := True;
  for ScreenObjectIndex := FirstIndex+1 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    AnotherBoundary := AScreenObject.ModflowLakBoundary;
    if (AnotherBoundary <> nil) and AnotherBoundary.Used then
    begin
      ValuesIdentical := Boundary.LakeID = AnotherBoundary.LakeID;
    end;
    if not ValuesIdentical then
    begin
      break;
    end;
  end;
  if ValuesIdentical and (Boundary <> nil) then
  begin
    frameLak.rdeLakeID.Text := IntToStr(Boundary.LakeID);
  end
  else
  begin
    frameLak.rdeLakeID.Text := '';
  end;

  if frameLak.tabBathymetry.TabVisible then
  begin
    AScreenObject := ScreenObjectList[0];
    Boundary := AScreenObject.ModflowLakBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      ExternalLakeTable := Boundary.ExternalLakeTable;
      frameLak.rgBathChoice.ItemIndex := Ord(ExternalLakeTable.LakeTableChoice);
      frameLak.feLakeBathymetry.FileName := ExternalLakeTable.FullLakeTableFileName;
      frameLak.SetFeLakeBathymetryColor(frameLak.feLakeBathymetry.FileName);
      frameLak.rdgLakeTable.BeginUpdate;
      try
        for Index := 0 to ExternalLakeTable.LakeTable.Count - 1 do
        begin
          if Index + 1 = frameLak.rdgLakeTable.RowCount then
          begin
            Break;
          end;
          BathItem := ExternalLakeTable.LakeTable[Index];
          frameLak.rdgLakeTable.Cells[Ord(bcStage), Index+1] :=
            FloatToStr(BathItem.Stage);
          frameLak.rdgLakeTable.Cells[Ord(bcVolume), Index+1] :=
            FloatToStr(BathItem.Volume);
          frameLak.rdgLakeTable.Cells[Ord(bcSurfaceArea), Index+1] :=
            FloatToStr(BathItem.SurfaceArea);
        end;
      finally
        frameLak.rdgLakeTable.EndUpdate;
      end;
    end;
  end;
end;


procedure TfrmScreenObjectProperties.GetModflowBoundaryTimes(
  ScreenObjectList: TList; Parameter: TParameterType;
  TimeList: TParameterTimeList);
var
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowParamBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  ParamIndex: Integer;
  Time2: TParameterTime;
  ParamItem: TModflowParamItem;
  Time1: TParameterTime;
begin
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.GetMfBoundary(Parameter);
    if Boundary <> nil then
    begin
      // get all the times associated with the boundary.
      for TimeIndex := 0 to Boundary.Values.Count - 1 do
      begin
        Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
        Time := TParameterTime.Create;
        Time.StartTime := Item.StartTime;
        Time.EndTime := Item.EndTime;
        TimeList.Add(Time);
      end;
      for ParamIndex := 0 to Boundary.Parameters.Count - 1 do
      begin
        ParamItem := Boundary.Parameters[ParamIndex];
        for TimeIndex := 0 to ParamItem.Param.Count - 1 do
        begin
          Item := ParamItem.Param[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
      end;
      if (Boundary = AScreenObject.ModflowRchBoundary)
        and frmGoPhast.PhastModel.RchTimeVaryingLayers then
      begin
        for TimeIndex := 0 to AScreenObject.ModflowRchBoundary.RechargeLayers.Count - 1 do
        begin
          Item := AScreenObject.ModflowRchBoundary.RechargeLayers[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
      end;
      if (Boundary = AScreenObject.ModflowEvtBoundary) then
      begin
        if frmGoPhast.PhastModel.EvtTimeVaryingLayers then
        begin
          for TimeIndex := 0 to AScreenObject.ModflowEvtBoundary.EvapotranspirationLayers.Count - 1 do
          begin
            Item := AScreenObject.ModflowEvtBoundary.EvapotranspirationLayers[TimeIndex] as TCustomModflowBoundaryItem;
            Time := TParameterTime.Create;
            Time.StartTime := Item.StartTime;
            Time.EndTime := Item.EndTime;
            TimeList.Add(Time);
          end;
        end;
        for TimeIndex := 0 to AScreenObject.ModflowEvtBoundary.EvtSurfDepthCollection.Count - 1 do
        begin
          Item := AScreenObject.ModflowEvtBoundary.EvtSurfDepthCollection[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
      end;
      if (Boundary = AScreenObject.ModflowEtsBoundary) then
      begin
        if frmGoPhast.PhastModel.EtsTimeVaryingLayers then
        begin
          for TimeIndex := 0 to AScreenObject.ModflowEtsBoundary.EvapotranspirationLayers.Count - 1 do
          begin
            Item := AScreenObject.ModflowEtsBoundary.EvapotranspirationLayers[TimeIndex] as TCustomModflowBoundaryItem;
            Time := TParameterTime.Create;
            Time.StartTime := Item.StartTime;
            Time.EndTime := Item.EndTime;
            TimeList.Add(Time);
          end;
        end;
        for TimeIndex := 0 to AScreenObject.ModflowEtsBoundary.EtsSurfDepthCollection.Count - 1 do
        begin
          Item := AScreenObject.ModflowEtsBoundary.EtsSurfDepthCollection[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
      end;
    end;
  end;
  // Sort the times in ascending order.
  TimeList.Sort;
  // get rid of duplicate times.
  for TimeIndex := TimeList.Count - 1 downto 1 do
  begin
    Time1 := TimeList[TimeIndex];
    Time2 := TimeList[TimeIndex - 1];
    if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
    begin
      TimeList.Delete(TimeIndex);
    end;
  end;
end;

function TfrmScreenObjectProperties.GetBoundaryValues(
  Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := Boundary.Values;
end;

procedure TfrmScreenObjectProperties.GetModflowBoundaryValues(
  Parameter: TParameterType; ScreenObjectList: TList;
  TimeList: TParameterTimeList; DataGrid: TRbwDataGrid4);
var
  ValuesFunction: TGetBoundaryCollectionEvent;
  ColumnOffset: integer;
begin
  ValuesFunction := GetBoundaryValues;
  ColumnOffset := 2;
  GetModflowBoundaryCollection(DataGrid, ValuesFunction, ColumnOffset,
    ScreenObjectList, Parameter, TimeList);
end;

procedure TfrmScreenObjectProperties.GetModflowBoundaryParameters(
  Parameter: TParameterType; ScreenObjectList: TList;
  Frame: TframeScreenObjectParam; TimeList: TParameterTimeList);
var
  BoundaryItem: TModflowParamItem;
  Index: Integer;
  Parameters: TModflowParameters;
  List: TList;
  BoundIndex: Integer;
  ChdIndex: Integer;
  ParametersIdentical: Boolean;
  ItemIndex: Integer;
  ScreenObjectIndex: Integer;
  ColIndex, RowIndex: integer;
  Param: TModflowTransientListParameter;
  Item: TCustomModflowBoundaryItem;
  Boundary: TModflowParamBoundary;
  DataGrid: TRbwDataGrid4;
  AScreenObject: TScreenObject;
begin
  DataGrid := Frame.dgModflowBoundary;
  for ItemIndex := 1 to Frame.clbParameters.Items.Count - 1 do
  begin
    if Frame.clbParameters.State[ItemIndex] in [cbChecked, cbGrayed] then
    begin
      Param := Frame.clbParameters.Items.Objects[ItemIndex] as TModflowTransientListParameter;
      List := TList.Create;
      try
        for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
        begin
          AScreenObject := ScreenObjectList[ScreenObjectIndex];
          Boundary := AScreenObject.GetMfBoundary(Parameter);
          if (Boundary <> nil)
            and (Boundary.Parameters.IndexOfParam(Param) >= 0) then
          begin
            List.Add(AScreenObject);
          end;
        end;
        if List.Count >= 1 then
        begin
          AScreenObject := List[0];
          Boundary := AScreenObject.GetMfBoundary(Parameter);
          Assert(Boundary <> nil);
          Parameters := Boundary.Parameters;
          Index := Parameters.IndexOfParam(Param);
          BoundaryItem := Parameters[Index] as TModflowParamItem;
          ParametersIdentical := True;
          for ScreenObjectIndex := 1 to List.Count - 1 do
          begin
            AScreenObject := List[ScreenObjectIndex];
            Boundary := AScreenObject.GetMfBoundary(Parameter);
            Assert(Boundary <> nil);
            Parameters := Boundary.Parameters;
            Index := Parameters.IndexOfParam(Param);
            ParametersIdentical := BoundaryItem.IsSame(Parameters[Index]);
            if not ParametersIdentical then
            begin
              break;
            end;
          end;
          if ParametersIdentical then
          begin
            ColIndex := DataGrid.Rows[0].IndexOfObject(Param);
            Assert(ColIndex >= 0);
            for ChdIndex := 0 to BoundaryItem.Param.Count - 1 do
            begin
              Item := BoundaryItem.Param[ChdIndex] as TCustomModflowBoundaryItem;
              RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
              Assert(RowIndex >= 1);
              for BoundIndex := 0 to Boundary.Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
              begin
                DataGrid.Cells[ColIndex + BoundIndex, RowIndex] :=
                  Item.BoundaryFormula[BoundIndex];
              end;
            end;
          end;
        end;
      finally
        List.Free;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetMF_BoundaryTimes(var Times: TTimeArray;
  Frame: TframeScreenObjectNoParam);
var
  RowIndex: Integer;
  DataGrid: TRbwDataGrid4;
begin
  DataGrid := Frame.dgModflowBoundary;
  SetLength(Times, DataGrid.RowCount);
  for RowIndex := 1 to DataGrid.RowCount - 1 do
  begin
    Times[RowIndex].TimeOK :=
      TryStrToFloat(DataGrid.Cells[0, RowIndex], Times[RowIndex].StartTime)
      and TryStrToFloat(DataGrid.Cells[1, RowIndex], Times[RowIndex].EndTime);
  end;
end;

procedure TfrmScreenObjectProperties.StoreMF_BoundColl(ColumnOffset: Integer;
  BoundaryValues: TCustomMF_BoundColl; const Times: TTimeArray;
  Frame: TframeScreenObjectNoParam);
var
  RowIndex: Integer;
  BoundIndex: Integer;
//  Value: string;
  BoundItem: TCustomModflowBoundaryItem;
  DataGrid: TRbwDataGrid4;
  ColIndex: integer;
  NewValue: string;
begin
  DataGrid := Frame.dgModflowBoundary;

  for RowIndex := 1 to DataGrid.RowCount - 1 do
  begin
    if Times[RowIndex].TimeOK then
    begin
      for BoundIndex := 0 to BoundaryValues.TimeListCount(frmGoPhast.PhastModel) - 1 do
      begin
        ColIndex := BoundIndex + ColumnOffset;
        NewValue := DataGrid.Cells[ColIndex, RowIndex];
        if Frame.DeletedCells[ColIndex,RowIndex] or (NewValue <> '') then
        begin
          if RowIndex - 1 < BoundaryValues.Count then
          begin
            BoundItem := BoundaryValues.Items[RowIndex - 1] as TCustomModflowBoundaryItem;
          end
          else
          begin
            BoundItem := BoundaryValues.Add as TCustomModflowBoundaryItem;
          end;
          BoundItem.StartTime := Times[RowIndex].StartTime;
          BoundItem.EndTime := Times[RowIndex].EndTime;
          BoundItem.BoundaryFormula[BoundIndex] := NewValue;
        end;
      end;
    end;
  end;
  for RowIndex := DataGrid.RowCount  to BoundaryValues.Count do
  begin
    for BoundIndex := 0 to BoundaryValues.TimeListCount(frmGoPhast.PhastModel) - 1 do
    begin
      BoundItem := BoundaryValues.Items[RowIndex - 1] as TCustomModflowBoundaryItem;
      BoundItem.BoundaryFormula[BoundIndex] := '';
    end;
  end;

end;

procedure TfrmScreenObjectProperties.StoreModflowBoundaryValues(
  Frame: TframeScreenObjectNoParam; Times: TTimeArray;
  Boundary: TModflowBoundary);
var
  BoundaryValues: TCustomMF_BoundColl;
  ColumnOffset: integer;
begin
  ColumnOffset := 2;
  BoundaryValues := Boundary.Values;
  StoreMF_BoundColl(ColumnOffset, BoundaryValues, Times, Frame);
end;

procedure TfrmScreenObjectProperties.StoreModflowBoundaryParameters(
  Boundary: TModflowParamBoundary; Times: TTimeArray;
  Frame: TframeScreenObjectParam);
var
  ParamItem: TModflowParamItem;
  AssignToAll: Boolean;
  ParamPosition: Integer;
  Param: TModflowParameter;
  ColIndex: Integer;
  StartCol: Integer;
  RowIndex: Integer;
  Value: string;
  BoundItem: TCustomModflowBoundaryItem;
  BoundIndex: Integer;
  ValuesOK: Boolean;
  Values: TStringList;
  DataGrid: TRbwDataGrid4;
  CheckListBox: TJvxCheckListBox;
  CheckIndex: Integer;
  ParamIndex: Integer;
begin
  DataGrid := Frame.dgModflowBoundary;
  Values := TStringList.Create;
  try
    StartCol := Boundary.NonParameterColumns;
    for ColIndex := StartCol to DataGrid.ColCount - 1 do
    begin
      if ((ColIndex - StartCol) mod Boundary.Values.
        TimeListCount(frmGoPhast.PhastModel)) <> 0 then
      begin
        Continue;
      end;
      Param := DataGrid.Objects[ColIndex, 0] as TModflowParameter;
      ParamPosition := Frame.clbParameters.Items.IndexOfObject(Param);
      AssignToAll := Frame.clbParameters.State[ParamPosition] = cbChecked;
      ParamItem := nil;
      for RowIndex := 1 to DataGrid.RowCount - 1 do
      begin
        if Times[RowIndex].TimeOK then
        begin
          Values.Clear;
          ValuesOK := True;
          for BoundIndex := 0 to Boundary.Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
          begin
            Value := DataGrid.Cells[BoundIndex + ColIndex, RowIndex];
            ValuesOK := Value <> '';
            if ValuesOK then
            begin
              Values.Add(Value);
            end
            else
            begin
              break;
            end;
          end;
          if ValuesOK then
          begin
            if ParamItem = nil then
            begin
              ParamItem := Boundary.Parameters.GetParamByName(Param.ParameterName);
              if ParamItem <> nil then
              begin
                ParamItem.Param.Clear;
              end;
            end;
            if (ParamItem = nil) and AssignToAll then
            begin
              ParamItem := Boundary.Parameters.Add;
              ParamItem.Param.Param := Param as TModflowTransientListParameter;
            end;
            if ParamItem = nil then
            begin
              break;
            end;
            BoundItem := ParamItem.Param.Add as TCustomModflowBoundaryItem;
            BoundItem.StartTime := Times[RowIndex].StartTime;
            BoundItem.EndTime := Times[RowIndex].EndTime;
            for BoundIndex := 0 to Boundary.Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
            begin
              BoundItem.BoundaryFormula[BoundIndex] := Values[BoundIndex];
            end;
          end;
        end;
      end;
    end;
    CheckListBox := Frame.clbParameters;
    for CheckIndex := 1 to CheckListBox.Items.Count - 1 do
    begin
      if CheckListBox.State[CheckIndex] = cbUnchecked then
      begin
        Param := CheckListBox.Items.Objects[CheckIndex] as TModflowParameter;
        ParamIndex :=  Boundary.Parameters.IndexOfParam(
          Param as TModflowTransientListParameter);
        if ParamIndex >= 0 then
        begin
          Boundary.Parameters.Delete(ParamIndex);
        end;
      end;
    end;
  finally
    Values.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetModflowBoundaries(
  const AScreenObjectList: TList);
begin
  GetChdBoundary(AScreenObjectList);
  GetGhbBoundary(AScreenObjectList);
  GetWellBoundary(AScreenObjectList);
  GetRivBoundary(AScreenObjectList);
  GetDrnBoundary(AScreenObjectList);
  GetDrtBoundary(AScreenObjectList);
  GetRchBoundary(AScreenObjectList);
  GetEvtBoundary(AScreenObjectList);
  GetEtsBoundary(AScreenObjectList);
  GetResBoundary(AScreenObjectList);
  GetLakBoundary(AScreenObjectList);
  GetUzfBoundary(AScreenObjectList);
  GetSfrBoundary(AScreenObjectList);
  GetStrBoundary(AScreenObjectList);
  GetMnw1Boundary(AScreenObjectList);
  GetMnw2Boundary(AScreenObjectList);
  GetFhbHeadBoundary(AScreenObjectList);
  GetFhbFlowBoundary(AScreenObjectList);
  GetHeadObservations(AScreenObjectList);
  GetHfbBoundary(AScreenObjectList);
  GetHydmod(AScreenObjectList);
  GetFluxObservations(AScreenObjectList);
  GetFarmWell(AScreenObjectList);
  GetFarmPrecip(AScreenObjectList);
  GetFarmRefEvap(AScreenObjectList);
  GetFarmCropID(AScreenObjectList);
  GetFarmID(AScreenObjectList);
  GetCfpPipes(AScreenObjectList);
  GetCfpFixedHeads(AScreenObjectList);
  GetCfpRechargeBoundary(AScreenObjectList);
  GetMt3dmsChemBoundary(AScreenObjectList);
  GetMt3dConcObservations(AScreenObjectList);
  GetMt3dmsFluxObservations(AScreenObjectList);
  GetSwrReaches(AScreenObjectList);
  GetSwrRainBoundary(AScreenObjectList);
  GetSwrEvapBoundary(AScreenObjectList);
  GetSwrLatInflowBoundary(AScreenObjectList);
  GetSwrStageBoundary(AScreenObjectList);
  GetSwrDirectRunoffBoundary(AScreenObjectList);
  GetSwiObsBoundray(AScreenObjectList);
  GetRip(AScreenObjectList);

  SetSelectedMfBoundaryNode;

  GetChildModels(AScreenObjectList);
end;

procedure TfrmScreenObjectProperties.GetFootprintWells;
begin
  frameScreenObjectFootprintWell.GetData(FNewProperties);
end;

procedure TfrmScreenObjectProperties.GetFormulaInterpretation(
  Frame: TframeScreenObjectCondParam; Parameter: TParameterType;
  ScreenObjectList: TList);
var
  First: Boolean;
  CondInterp: TFormulaInterpretation;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TSpecificModflowBoundary;
begin
  Frame.comboFormulaInterp.ItemIndex := 0;
  First := True;
  CondInterp := fiSpecific;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.GetMfBoundary(Parameter) as TSpecificModflowBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      if First then
      begin
        CondInterp := Boundary.FormulaInterpretation;
        Frame.comboFormulaInterp.ItemIndex := Ord(CondInterp);
        First := False;
      end
      else if CondInterp <> Boundary.FormulaInterpretation then
      begin
        Frame.comboFormulaInterp.ItemIndex := -1;
      end;
    end;
  end;
  if Assigned(Frame.comboFormulaInterp.OnChange) then
  begin
    Frame.comboFormulaInterp.OnChange(Frame.comboFormulaInterp);
  end;
end;

procedure TfrmScreenObjectProperties.StoreFormulaInterpretation(
  Frame: TframeScreenObjectCondParam; ParamType: TParameterType);
var
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TSpecificModflowBoundary;
begin
  if Frame.comboFormulaInterp.ItemIndex >= 0 then
  begin
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Boundary := Item.ScreenObject.GetMfBoundary(ParamType)
        as TSpecificModflowBoundary;
      Assert(Boundary <> nil);
      Boundary.FormulaInterpretation := TFormulaInterpretation(
        Frame.comboFormulaInterp.ItemIndex);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetModflowBoundary(
  Frame: TframeScreenObjectParam; Parameter: TParameterType;
  ScreenObjectList: TList; Node: TJvPageIndexNode);
var
  TimeList: TParameterTimeList;
  ItemIndex: Integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowParamBoundary;
  TimeIndex: Integer;
  Time: TParameterTime;
  ParamIndex: Integer;
  ParamItem: TModflowParamItem;
  Param: TModflowTransientListParameter;
  ParamUsed: Boolean;
  ColIndex: Integer;
  RowIndex: Integer;
  DataGrid: TRbwDataGrid4;
  State: TCheckBoxState;
begin
  Frame.dgModflowBoundary.BeginUpdate;
  TimeList := TParameterTimeList.Create;
  try
    for ItemIndex := 0 to Frame.clbParameters.Items.Count - 1 do
    begin
      Frame.clbParameters.State[ItemIndex] := cbUnchecked;
    end;

    GetModflowBoundaryTimes(ScreenObjectList, Parameter, TimeList);

    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.GetMfBoundary(Parameter);
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
    if Node <> nil then
    begin
      Node.StateIndex := Ord(State)+1;
    end;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.GetMfBoundary(Parameter);
      if Boundary <> nil then
      begin
        if (Boundary.Values.Count > 0)
          and (Frame.clbParameters.Items.Count > 0) then
        begin
          Frame.clbParameters.State[0] := cbChecked;
        end;
        // get all the times associated with the boundary.
        for ParamIndex := 0 to Boundary.Parameters.Count - 1 do
        begin
          ParamItem := Boundary.Parameters[ParamIndex];
          if ScreenObjectIndex = 0 then
          begin
            Param := ParamItem.Param.Param;
            if Param <> nil then
            begin
              ItemIndex := Frame.clbParameters.Items.IndexOf(Param.ParameterName);
              Frame.clbParameters.State[ItemIndex] := cbChecked;
            end;
          end;
        end;
      end;
      if ScreenObjectIndex > 0 then
      begin
        if (Frame.clbParameters.Items.Count > 0)
          and (Boundary <> nil)
          and (Frame.clbParameters.Checked[0] <> (Boundary.Values.Count > 0)) then
        begin
          Frame.clbParameters.State[0] := cbGrayed;
        end;
        for ItemIndex := 1 to Frame.clbParameters.Items.Count - 1 do
        begin
          if Frame.clbParameters.State[ItemIndex] = cbGrayed then
          begin
            Continue;
          end;
          Param := Frame.clbParameters.Items.Objects[ItemIndex]
            as TModflowTransientListParameter;
          ParamUsed := (Boundary <> nil) and
            (Boundary.Parameters.IndexOfParam(Param) >= 0);
          if Frame.clbParameters.Checked[ItemIndex] <> ParamUsed then
          begin
            Frame.clbParameters.State[ItemIndex] := cbGrayed;
          end;
        end;
      end;
    end;

    Frame.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := Frame.dgModflowBoundary;
    for ColIndex := 0 to DataGrid.ColCount - 1 do
    begin
      for RowIndex := 1 to DataGrid.RowCount - 1 do
      begin
        DataGrid.Cells[ColIndex, RowIndex] := '';
      end;
    end;

    // display the times that are left.
    for TimeIndex := 0 to TimeList.Count - 1 do
    begin
      Time := TimeList[TimeIndex];
      DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
      DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
    end;
    GetModflowBoundaryValues(Parameter, ScreenObjectList, TimeList, DataGrid);
    GetModflowBoundaryParameters(Parameter, ScreenObjectList, Frame, TimeList);
    Frame.ClearDeletedCells;
  finally
    TimeList.Free;
    Frame.dgModflowBoundary.EndUpdate;
  end;
end;

procedure TfrmScreenObjectProperties.StoreModflowBoundary(
  Frame: TframeScreenObjectParam; ParamType: TParameterType;
  Node: TJvPageIndexNode);
var
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TModflowParamBoundary;
begin
  Assert(Node <> nil);
  GetMF_BoundaryTimes(Times, Frame);
  for Index := 0 to FNewProperties.Count - 1 do
  begin
    Item := FNewProperties[Index];
    Boundary := Item.ScreenObject.GetMfBoundary(ParamType);
    Assert(Boundary <> nil);
    if ShouldStoreBoundary(Node, Boundary) then
    begin
      if (Frame.clbParameters.Items.Count > 0)
        and not (Frame.clbParameters.State[0] in [cbChecked, cbGrayed]) then
      begin
        Boundary.Values.Clear
      end
      else
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
      end;
      StoreModflowBoundaryParameters(Boundary, Times, Frame);
    end
    else if  Node.StateIndex = 1 then
    begin
      Boundary.Clear;
    end;

  end;
end;

procedure TfrmScreenObjectProperties.InitializeModflowBoundaryFrames(
  const AScreenObject: TScreenObject);
var
  Index: integer;
  ScreenObject: TScreenObject;
  TimeList: TModflowTimeList;
  EtsColCount: integer;
  StoredUpToDate: boolean;
  PriorCanInvalidateModel: Boolean;
begin
  StoredUpToDate := frmGoPhast.PhastModel.UpToDate;
  PriorCanInvalidateModel := AScreenObject.CanInvalidateModel;
  AScreenObject.CanInvalidateModel := False;
  try
    AScreenObject.CreateChdBoundary;
    frameChdParam.InitializeFrame(AScreenObject.ModflowChdBoundary);
    if (AScreenObject.ModflowChdBoundary <> nil)
      and not AScreenObject.ModflowChdBoundary.Used then
    begin
      AScreenObject.ModflowChdBoundary := nil;
    end;

    AScreenObject.CreateGhbBoundary;
    frameGhbParam.InitializeFrame(AScreenObject.ModflowGhbBoundary);
    if (AScreenObject.ModflowGhbBoundary <> nil)
      and not AScreenObject.ModflowGhbBoundary.Used then
    begin
      AScreenObject.ModflowGhbBoundary := nil;
    end;

    AScreenObject.CreateWelBoundary;
    frameWellParam.InitializeFrame(AScreenObject.ModflowWellBoundary);
    frameWellParam.fedTabfile.FileName := '';
    if (AScreenObject.ModflowWellBoundary <> nil)
      and not AScreenObject.ModflowWellBoundary.Used then
    begin
      AScreenObject.ModflowWellBoundary := nil;
    end;

    AScreenObject.CreateFarmWell;
    frameFarmWell.InitializeFrame(AScreenObject.ModflowFmpWellBoundary);
    if (AScreenObject.ModflowFmpWellBoundary <> nil)
      and not AScreenObject.ModflowFmpWellBoundary.Used then
    begin
      AScreenObject.ModflowFmpWellBoundary := nil;
    end;

    AScreenObject.CreateRivBoundary;
    frameRivParam.InitializeFrame(AScreenObject.ModflowRivBoundary);
    if (AScreenObject.ModflowRivBoundary <> nil)
      and not AScreenObject.ModflowRivBoundary.Used then
    begin
      AScreenObject.ModflowRivBoundary := nil;
    end;

    AScreenObject.CreateDrnBoundary;
    frameDrnParam.InitializeFrame(AScreenObject.ModflowDrnBoundary);
    if (AScreenObject.ModflowDrnBoundary <> nil)
      and not AScreenObject.ModflowDrnBoundary.Used then
    begin
      AScreenObject.ModflowDrnBoundary := nil;
    end;

    AScreenObject.CreateDrtBoundary;
    frameDrtParam.InitializeFrame(AScreenObject.ModflowDrtBoundary);
    comboDrtReturnObject.Items.Clear;
    for Index := 0 to frmGoPhast.PhastModel.ScreenObjectCount - 1 do
    begin
      ScreenObject := frmGoPhast.PhastModel.ScreenObjects[Index];
      if (ScreenObject.Count = 1)
        and (ScreenObject.ElevationCount = ecOne)
        and not ScreenObject.Deleted then
      begin
        comboDrtReturnObject.Items.AddObject(ScreenObject.Name, ScreenObject);
      end;
    end;
    if (AScreenObject.ModflowDrtBoundary <> nil)
      and not AScreenObject.ModflowDrtBoundary.Used then
    begin
      AScreenObject.ModflowDrtBoundary := nil;
    end;

    if frmGoPhast.PhastModel.RchTimeVaryingLayers then
    begin
      frameRchParam.dgModflowBoundary.ColCount := 4;
    end
    else
    begin
      frameRchParam.dgModflowBoundary.ColCount := 3;
    end;
    AScreenObject.CreateRchBoundary;
    frameRchParam.InitializeFrame(AScreenObject.ModflowRchBoundary);
    if frmGoPhast.PhastModel.RchTimeVaryingLayers then
    begin
//      frameRchParam.dgModflowBoundary.Columns[3].WordWrapCaptions := True;
      frameRchParam.dgModflowBoundary.Columns[3].AutoAdjustColWidths := True;
      TimeList := AScreenObject.ModflowRchBoundary.RechargeLayers.TimeLists[0, frmGoPhast.PhastModel];
      frameRchParam.dgModflowBoundary.Cells[3, 0] := TimeList.NonParamDescription;
      frameRchParam.dgModflowBoundary.Columns[3].AutoAdjustColWidths := False;
      frameRchParam.dgModflowBoundary.ColWidths[3] :=
        frameRchParam.dgModflowBoundary.WidthNeededToFitText(3,0);
    end;
    if (AScreenObject.ModflowRchBoundary <> nil)
      and not AScreenObject.ModflowRchBoundary.Used then
    begin
      AScreenObject.ModflowRchBoundary := nil;
    end;

    if frmGoPhast.PhastModel.EvtTimeVaryingLayers then
    begin
      frameEvtParam.dgModflowBoundary.ColCount := 6;
    end
    else
    begin
      frameEvtParam.dgModflowBoundary.ColCount := 5;
    end;
    AScreenObject.CreateEvtBoundary;
    frameEvtParam.InitializeFrame(AScreenObject.ModflowEvtBoundary);
    if frmGoPhast.PhastModel.EvtTimeVaryingLayers then
    begin
//      frameEvtParam.dgModflowBoundary.Columns[5].WordWrapCaptions := True;
      frameEvtParam.dgModflowBoundary.Columns[5].AutoAdjustColWidths := True;
      TimeList := AScreenObject.ModflowEvtBoundary.EvapotranspirationLayers.TimeLists[0, frmGoPhast.PhastModel];
      frameEvtParam.dgModflowBoundary.Cells[5, 0] := TimeList.NonParamDescription;
      frameEvtParam.dgModflowBoundary.Columns[5].AutoAdjustColWidths := False;
      frameEvtParam.dgModflowBoundary.ColWidths[5] :=
        frameEvtParam.dgModflowBoundary.WidthNeededToFitText(5,0);
    end;

    for Index := 0 to AScreenObject.ModflowEvtBoundary.
      EvtSurfDepthCollection.TimeListCount(frmGoPhast.PhastModel) - 1 do
    begin
      frameEvtParam.dgModflowBoundary.Columns[3+Index].WordWrapCaptions := True;
//      frameEvtParam.dgModflowBoundary.Columns[3+Index].AutoAdjustColWidths := True;
      TimeList := AScreenObject.ModflowEvtBoundary.EvtSurfDepthCollection.TimeLists[Index, frmGoPhast.PhastModel];
      frameEvtParam.dgModflowBoundary.Cells[3+Index, 0] := TimeList.NonParamDescription;
      frameEvtParam.dgModflowBoundary.Columns[3+Index].AutoAdjustColWidths := False;
      frameEvtParam.dgModflowBoundary.ColWidths[3+Index] :=
        frameEvtParam.dgModflowBoundary.WidthNeededToFitText(3+Index,0);
    end;
    if (AScreenObject.ModflowEvtBoundary <> nil)
      and not AScreenObject.ModflowEvtBoundary.Used then
    begin
      AScreenObject.ModflowEvtBoundary := nil;
    end;

    if frmGoPhast.PhastModel.EtsTimeVaryingLayers then
    begin
      EtsColCount := 6
        + (frmGoPhast.PhastModel.ModflowPackages.EtsPackage.SegmentCount -1) * 2;
    end
    else
    begin
      EtsColCount := 5
        + (frmGoPhast.PhastModel.ModflowPackages.EtsPackage.SegmentCount -1) * 2;
    end;
    frameEtsParam.dgModflowBoundary.ColCount := EtsColCount;

    AScreenObject.CreateEtsBoundary;
    frameEtsParam.InitializeFrame(AScreenObject.ModflowEtsBoundary);
    if frmGoPhast.PhastModel.EtsTimeVaryingLayers then
    begin
      frameEtsParam.dgModflowBoundary.Columns[EtsColCount-1].WordWrapCaptions := True;
//      frameEtsParam.dgModflowBoundary.Columns[EtsColCount-1].AutoAdjustColWidths := True;
      TimeList := AScreenObject.ModflowEtsBoundary.EvapotranspirationLayers.TimeLists[0, frmGoPhast.PhastModel];
      frameEtsParam.dgModflowBoundary.Cells[EtsColCount-1, 0] := TimeList.NonParamDescription;
      frameEtsParam.dgModflowBoundary.Columns[EtsColCount-1].AutoAdjustColWidths := False;
      frameEtsParam.dgModflowBoundary.ColWidths[EtsColCount-1] :=
        frameEtsParam.dgModflowBoundary.WidthNeededToFitText(EtsColCount-1,0);
    end;

    for Index := 0 to AScreenObject.ModflowEtsBoundary.
      EtsSurfDepthCollection.TimeListCount(frmGoPhast.PhastModel) - 1 do
    begin
      frameEtsParam.dgModflowBoundary.Columns[3+Index].WordWrapCaptions := True;
      frameEtsParam.dgModflowBoundary.Columns[3+Index].AutoAdjustColWidths := True;
      TimeList := AScreenObject.ModflowEtsBoundary.EtsSurfDepthCollection.TimeLists[Index, frmGoPhast.PhastModel];
      frameEtsParam.dgModflowBoundary.Cells[3+Index, 0] := TimeList.NonParamDescription;
      frameEtsParam.dgModflowBoundary.Columns[3+Index].AutoAdjustColWidths := False;
    end;
    if (AScreenObject.ModflowEtsBoundary <> nil)
      and not AScreenObject.ModflowEtsBoundary.Used then
    begin
      AScreenObject.ModflowEtsBoundary := nil;
    end;

    AScreenObject.CreateMt3dmsConcBoundary;
    frameMT3DMS_SSM.dgModflowBoundary.ColCount := 2
      + frmGoPhast.PhastModel.MobileComponents.Count
      + frmGoPhast.PhastModel.ImmobileComponents.Count;
    frameMT3DMS_SSM.InitializeNoParamFrame(AScreenObject.Mt3dmsConcBoundary);
    if (AScreenObject.Mt3dmsConcBoundary <> nil)
      and not AScreenObject.Mt3dmsConcBoundary.Used then
    begin
      AScreenObject.Mt3dmsConcBoundary := nil;
    end;

    AScreenObject.CreateResBoundary;
    frameRes.InitializeNoParamFrame(AScreenObject.ModflowResBoundary);
    if (AScreenObject.ModflowResBoundary <> nil)
      and not AScreenObject.ModflowResBoundary.Used then
    begin
      AScreenObject.ModflowResBoundary := nil;
    end;

    AScreenObject.CreateLakBoundary;
    frameLak.InitializeNoParamFrame(AScreenObject.ModflowLakBoundary);
    if (AScreenObject.ModflowLakBoundary <> nil)
      and not AScreenObject.ModflowLakBoundary.Used then
    begin
      AScreenObject.ModflowLakBoundary := nil;
    end;

    frameScreenObjectUZF.dgModflowBoundary.RowHeights[0] :=
      frameScreenObjectUZF.dgModflowBoundary.DefaultRowHeight;
    AScreenObject.CreateUzfBoundary;
    frameScreenObjectUZF.InitializeNoParamFrame(AScreenObject.ModflowUzfBoundary);
    if frmGoPhast.PhastModel.ModflowPackages.UzfPackage.SimulateET then
    begin
      frameScreenObjectUZF.dgModflowBoundary.ColCount := 6;
      // UZF ET Rates
      frameScreenObjectUZF.dgModflowBoundary.Columns[3].WordWrapCaptions := True;
//      frameScreenObjectUZF.dgModflowBoundary.Columns[3].AutoAdjustColWidths := True;
      frameScreenObjectUZF.dgModflowBoundary.Columns[3].AutoAdjustRowHeights := True;
      TimeList := AScreenObject.ModflowUzfBoundary.EvapotranspirationDemand.TimeLists[0, frmGoPhast.PhastModel];
      frameScreenObjectUZF.dgModflowBoundary.Cells[3, 0] := TimeList.NonParamDescription;
      frameScreenObjectUZF.dgModflowBoundary.Columns[3].AutoAdjustColWidths := False;
      frameScreenObjectUZF.dgModflowBoundary.Columns[3].AutoAdjustRowHeights := False;
      frameScreenObjectUZF.dgModflowBoundary.ColWidths[3] :=
        frameScreenObjectUZF.dgModflowBoundary.WidthNeededToFitText(3,0);
      // UZF ET Extinction depth
      frameScreenObjectUZF.dgModflowBoundary.Columns[4].WordWrapCaptions := True;
//      frameScreenObjectUZF.dgModflowBoundary.Columns[4].AutoAdjustColWidths := True;
      frameScreenObjectUZF.dgModflowBoundary.Columns[4].AutoAdjustRowHeights := True;
      TimeList := AScreenObject.ModflowUzfBoundary.ExtinctionDepth.TimeLists[0, frmGoPhast.PhastModel];
      frameScreenObjectUZF.dgModflowBoundary.Cells[4, 0] := TimeList.NonParamDescription;
      frameScreenObjectUZF.dgModflowBoundary.Columns[4].AutoAdjustColWidths := False;
      frameScreenObjectUZF.dgModflowBoundary.Columns[4].AutoAdjustRowHeights := False;
      frameScreenObjectUZF.dgModflowBoundary.ColWidths[4] :=
        frameScreenObjectUZF.dgModflowBoundary.WidthNeededToFitText(4,0);
      // UZF ET Extinction water content
      frameScreenObjectUZF.dgModflowBoundary.Columns[5].WordWrapCaptions := True;
//      frameScreenObjectUZF.dgModflowBoundary.Columns[5].AutoAdjustColWidths := True;
      frameScreenObjectUZF.dgModflowBoundary.Columns[5].AutoAdjustRowHeights := True;
      TimeList := AScreenObject.ModflowUzfBoundary.WaterContent.TimeLists[0, frmGoPhast.PhastModel];
      frameScreenObjectUZF.dgModflowBoundary.Cells[5, 0] := TimeList.NonParamDescription;
      frameScreenObjectUZF.dgModflowBoundary.Columns[5].AutoAdjustColWidths := False;
      frameScreenObjectUZF.dgModflowBoundary.Columns[5].AutoAdjustRowHeights := False;
      frameScreenObjectUZF.dgModflowBoundary.ColWidths[5] :=
        frameScreenObjectUZF.dgModflowBoundary.WidthNeededToFitText(5,0);
    end
    else
    begin
      frameScreenObjectUZF.dgModflowBoundary.ColCount := 3;
    end;
    // dispose of UZF.
    if (AScreenObject.ModflowUzfBoundary <> nil)
      and not AScreenObject.ModflowUzfBoundary.Used then
    begin
      AScreenObject.ModflowUzfBoundary := nil;
    end;

    frameCfpRechargeFraction.dgModflowBoundary.RowHeights[0] :=
      frameCfpRechargeFraction.dgModflowBoundary.DefaultRowHeight;
    AScreenObject.CreateCfpRchFraction;
    frameCfpRechargeFraction.InitializeNoParamFrame(AScreenObject.ModflowCfpRchFraction);
    frameCfpRechargeFraction.dgModflowBoundary.ColCount := 3;
    if (AScreenObject.ModflowCfpRchFraction <> nil)
      and not AScreenObject.ModflowCfpRchFraction.Used then
    begin
      AScreenObject.ModflowCfpRchFraction := nil;
    end;

    AScreenObject.CreateSwrRainBoundary;
    frameSWR_Rain.InitializeNoParamFrame(AScreenObject.ModflowSwrRain);
    if (AScreenObject.ModflowSwrRain <> nil)
      and not AScreenObject.ModflowSwrRain.Used then
    begin
      AScreenObject.ModflowSwrRain := nil;
    end;

    AScreenObject.CreateSwrEvapBoundary;
    frameSWR_Evap.InitializeNoParamFrame(AScreenObject.ModflowSwrEvap);
    if (AScreenObject.ModflowSwrEvap <> nil)
      and not AScreenObject.ModflowSwrEvap.Used then
    begin
      AScreenObject.ModflowSwrEvap := nil;
    end;

    AScreenObject.CreateSwrLatInflowBoundary;
    frameSWR_LatInfl.InitializeNoParamFrame(AScreenObject.ModflowSwrLatInflow);
    if (AScreenObject.ModflowSwrLatInflow <> nil)
      and not AScreenObject.ModflowSwrLatInflow.Used then
    begin
      AScreenObject.ModflowSwrLatInflow := nil;
    end;

    AScreenObject.CreateSwrStageBoundary;
    frameSWR_Stage.InitializeNoParamFrame(AScreenObject.ModflowSwrStage);
    if (AScreenObject.ModflowSwrStage <> nil)
      and not AScreenObject.ModflowSwrStage.Used then
    begin
      AScreenObject.ModflowSwrStage := nil;
    end;

    AScreenObject.CreateSwrDirectRunoffBoundary;
    frameSWR_DirectRunoff.InitializeNoParamFrame(AScreenObject.ModflowSwrDirectRunoff);
    if (AScreenObject.ModflowSwrDirectRunoff <> nil)
      and not AScreenObject.ModflowSwrDirectRunoff.Used then
    begin
      AScreenObject.ModflowSwrDirectRunoff := nil;
    end;

    frameSwrReach.InitializeFrame;

  finally
    AScreenObject.CanInvalidateModel := PriorCanInvalidateModel;
    frmGoPhast.PhastModel.UpToDate := StoredUpToDate;
  end;
end;

function TfrmScreenObjectProperties.CanSetPoints: Boolean;
var
  Index: Integer;
  APoint: TPoint2D;
  TempScreenObject: TScreenObject;
begin
  result := FStoredCanSetPoints;
  if FCanSetPointsOutOfDate then
  begin
    result := True;
    try
      TempScreenObject := frmGoPhast.PhastModel.ScreenObjectClass.Create(nil);
      try
        TempScreenObject.Capacity := dgVerticies.RowCount - 1;
        for Index := 1 to dgVerticies.RowCount - 1 do
        begin
          if not AssignPoint(Index, APoint) then
          begin
            Continue;
          end;
          try
            TempScreenObject.AddPoint(APoint,
              dgVerticies.Checked[Ord(vcNewSection),Index]);
          except
            on E: EScreenObjectError do
            begin
            end;
          end;
          if TempScreenObject.Count <> Index then
          begin
            result := False;
            Break;
          end;
        end;
      finally
        TempScreenObject.Free;
      end;
    finally
      FStoredCanSetPoints := result;
      FCanSetPointsOutOfDate := False;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreInterpolatedBoundary(
  Boundary: TCustomInterpolatedBoundary; DataGrid: TRbwDataGrid4);
var
  Time: Extended;
  InterpValuesCollection: TInterpValuesCollection;
  RowIndex: Integer;
  BoundaryValue: TRealPhastBoundaryCondition;
  SolutionValue: TIntegerPhastBoundaryCondition;
  InterpValueItem: TInterpValuesItem;
begin
  for RowIndex := 1 to DataGrid.RowCount - 1 do
  begin
    if TryStrToFloat(DataGrid.Cells[Ord(ibcTime), RowIndex], Time) then
    begin
      Assert(DataGrid.State[Ord(ibcBoundaryInterpolate), RowIndex] <> cbGrayed);
      Assert(DataGrid.State[Ord(ibcSolutionInterpolate), RowIndex] <> cbGrayed);

      if DataGrid.Checked[
        Ord(ibcBoundaryInterpolate), RowIndex] then
      begin
        InterpValuesCollection := DataGrid.Objects[
          Ord(ibcBoundaryInterpolate), RowIndex] as TInterpValuesCollection;
        InterpValueItem := InterpValuesCollection.Items[0] as TInterpValuesItem;
        BoundaryValue := Boundary.BoundaryValue.Add
          as TRealPhastBoundaryCondition;
        BoundaryValue.Time := Time;
        BoundaryValue.Assign(InterpValueItem);
      end
      else
      begin
        if DataGrid.Cells[Ord(ibcBoundaryValue), RowIndex] <> '' then
        begin
          BoundaryValue := Boundary.BoundaryValue.Add
            as TRealPhastBoundaryCondition;
          BoundaryValue.Time := Time;
          BoundaryValue.UsePHAST_Interpolation := False;
          BoundaryValue.FormulaExpression := DataGrid.Cells[
            Ord(ibcBoundaryValue), RowIndex];
        end;
      end;
      if DataGrid.Checked[Ord(ibcSolutionInterpolate), RowIndex] then
      begin
        InterpValuesCollection := DataGrid.Objects[
          Ord(ibcSolutionInterpolate), RowIndex] as TInterpValuesCollection;
        InterpValueItem := InterpValuesCollection.Items[0]
          as TInterpValuesItem;
        SolutionValue := Boundary.Solution.Add
          as TIntegerPhastBoundaryCondition;
        SolutionValue.Time := Time;
        SolutionValue.Assign(InterpValueItem);
      end
      else
      begin
        if DataGrid.Cells[Ord(ibcSolution), RowIndex] <> '' then
        begin
          SolutionValue := Boundary.Solution.Add
            as TIntegerPhastBoundaryCondition;
          SolutionValue.Time := Time;
          SolutionValue.UsePHAST_Interpolation := False;
          SolutionValue.FormulaExpression := DataGrid.Cells[
            Ord(ibcSolution), RowIndex];
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreNonInterpolatedBoundary(Boundary: TCustomInterpolatedBoundary; DataGrid: TRbwDataGrid4);
var
  Time: Extended;
  RowIndex: Integer;
  BoundaryValue: TRealPhastBoundaryCondition;
  SolutionValue: TIntegerPhastBoundaryCondition;
begin
  for RowIndex := 1 to DataGrid.RowCount - 1 do
  begin
    if TryStrToFloat(DataGrid.Cells[Ord(nicTime), RowIndex], Time) then
    begin
        if DataGrid.Cells[Ord(nicBoundaryValue), RowIndex] <> '' then
        begin
          BoundaryValue := Boundary.BoundaryValue.Add
            as TRealPhastBoundaryCondition;
          BoundaryValue.Time := Time;
          BoundaryValue.UsePHAST_Interpolation := False;
          BoundaryValue.FormulaExpression := DataGrid.Cells[
            Ord(nicBoundaryValue), RowIndex];
        end;

        if DataGrid.Cells[Ord(nicSolution), RowIndex] <> '' then
        begin
          SolutionValue := Boundary.Solution.Add
            as TIntegerPhastBoundaryCondition;
          SolutionValue.Time := Time;
          SolutionValue.UsePHAST_Interpolation := False;
          SolutionValue.FormulaExpression := DataGrid.Cells[
            Ord(nicSolution), RowIndex];
        end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.ShowOrHideTabs;
var
  CanSetData: boolean;
begin
  CanSetData := (cbEnclosedCells.State <> cbUnchecked)
    or (cbIntersectedCells.State <> cbUnchecked)
    or (cbInterpolation.State <> cbUnchecked);
  tabBoundaries.TabVisible := CanSetData and
    (frmGoPhast.ModelSelection = msPhast) and
    (rgEvaluatedAt.ItemIndex = 1) and
    ((FScreenObjectList = nil) or (FScreenObjectList.Count = 1));
  tabDataSets.TabVisible := CanSetData and
    (frmGoPhast.PhastModel.DataArrayManager.DataSetCount > 0);
  tabModflowBoundaryConditions.TabVisible := CanSetData and
    (frmGoPhast.ModelSelection in ModflowSelection);
  tabSutraFeatures.TabVisible := CanSetData and
    (frmGoPhast.ModelSelection in SutraSelection);
  tabFootprintFeatures.TabVisible := CanSetData and
    (frmGoPhast.ModelSelection = msFootprint);
end;

procedure TfrmScreenObjectProperties.AssignNewDataSetFormula(
  DSIndex: Integer; const NewFormula: string);
var
  Item: TScreenObjectEditItem;
  Position: Integer;
  DataSet: TDataArray;
  Index: Integer;
  Edit: TScreenObjectDataEdit;
begin
  if IsLoaded and (NewFormula <> '') then
  begin
    Edit := FDataEdits[DSIndex];
    DataSet := Edit.DataArray;
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Position := Item.ScreenObject.IndexOfDataSet(DataSet);
      if Position >= 0 then
      begin
        Item.ScreenObject.DataSetFormulas[Position] := NewFormula;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetListOfOkVariables(
  EvaluatedAt: TEvaluatedAt; Orientation: TDataSetOrientation;
  VariableList: TList; DataSetIndex: Integer;
  DSEdit: TScreenObjectDataEdit);
var
  VariablePosition: Integer;
  TempUsesList: TStringList;
  VariableName: string;
  DataSet: TDataArray;
  Index: Integer;
  Edit: TScreenObjectDataEdit;
  DataArrayManager: TDataArrayManager;
begin
  TempUsesList := DSEdit.UsedBy;
  DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
  for Index := 0 to DataArrayManager.DataSetCount - 1 do
  begin
    DataSet := DataArrayManager.DataSets[Index];
    if (Index <> DataSetIndex)
      and (EvaluatedAt = DataSet.EvaluatedAt)
      and DataSet.Visible then
    begin
      VariableName := DataSet.Name;
//      OtherEdit := FDataEdits[GetDataSetIndexByName(VariableName)];
//      TempUsesList := OtherEdit.UsedBy;
      VariablePosition := TempUsesList.IndexOf(VariableName);
      if (VariablePosition < 0) and ((Orientation = dso3D)
        or (Orientation = DataSet.Orientation)) then
      begin
        Edit := FDataEdits[Index];
        // if the variable
        // (1) does not depend on the data set whose formula is being edited,
        // (2) it's orientation is OK, and
        // (3) the variable does not represent the TDataArray itself,
        // the variable can be used in the formula.
        VariableList.Add(Edit.Variable);
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.FormDestroy(Sender: TObject);
begin
  inherited;
//  frameIface.glsvViewer.Free;
//  frameModpathParticles.GLSceneViewer1.Free;

  FVertexCaptionFont.Free;
  FCaptionFont.Free;
  FCurrentEdit := nil;

  // If FUndoSetScreenObjectProperties was submitted, it will have
  // been set to nil.
  FUndoSetScreenObjectProperties.Free;

  FBoundaryPhastInterpolationList.Free;
  FNewProperties.Free;
  FOldProperties.Free;
  FDataEdits.Free;
  FChildModels.Free;
  FChildModelsScreenObjects.Free;
end;

procedure TfrmScreenObjectProperties.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ActiveControl is TRbwDataGrid4) and (ssCtrl in Shift)
    and (Key in [Ord('a'), Ord('A')]) then
  begin
    TRbwDataGrid4(ActiveControl).SelectAll;
  end;
end;

function TfrmScreenObjectProperties.GetDataSetIndexByName(const DataSetName:
  string):
  integer;
var
  Index: integer;
  DataSet: TDataArray;
  Edit: TScreenObjectDataEdit;
begin
  // GetDataSetIndexByName returns the position of the data set whose name is
  // DataSetName in FDataSetList.  If the data set isn't in FDataSetList,
  // GetDataSetIndexByName returns -1.
  result := -1;
  for Index := 0 to FDataEdits.Count - 1 do
  begin
    Edit := FDataEdits[Index];
    DataSet := Edit.DataArray;
    if DataSet.Name = DataSetName then
    begin
      result := Index;
      Exit;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.CheckForCircularReference(
  const Expression: TExpression; const DSetName: string;
  const EditIndex: integer; const OldFormulaOK: boolean;
  const OldFormula: string);
var
  Used: TStringList;
  Index: integer;
  VariableName: string;
  Edit: TScreenObjectDataEdit;
begin
  Assert(Expression <> nil);
  Used := TStringList.Create;
  try
    Edit := FDataEdits[EditIndex];
    Used.Assign(Expression.VariablesUsed);
    // Check that the formula does not result in
    // a circular reference.
    for Index := 0 to Used.Count - 1 do
    begin
      VariableName := Used[Index];
      if Edit.UsedBy.IndexOf(VariableName) >= 0 then
      begin
        Edit.Expression := nil;
        Beep;
        if OldFormulaOK then
        begin
          if MessageDlg(Format(StrErrorThereAppears, [VariableName, DSetName]),
            mtError, [mbYes, mbNo], 0) = mrYes then
          begin
            Edit.Formula := OldFormula;
            CreateFormula(EditIndex, OldFormula);
          end;
        end
        else
        begin
          MessageDlg(Format(StrErrorThereAppearsNoRevert,
            [VariableName, DSetName]), mtError, [mbOK], 0)
        end;
        Exit;
      end;
    end;
  finally
    Used.Free;
  end;
end;

procedure TfrmScreenObjectProperties.CreateVariable(const Edit: TScreenObjectDataEdit);
var
  NewName: string;
  DataType: TRbwDataType;
  Variable: TCustomVariable;
  TempFormulaCompiler: TRbwParser;
  DataSet: TDataArray;
  Local3DCompiler: TRbwParser;
  NewDisplayName: string;
begin
  // Create a variable to represent the dataset specified by Index in
  // each TRbwParser that needs it.
  DataSet := Edit.DataArray;
  TempFormulaCompiler := GetCompiler(DataSet.Orientation, DataSet.EvaluatedAt);

  Variable := nil;
  NewName := DataSet.Name;
  NewDisplayName := DataSet.DisplayName;

  Local3DCompiler := nil;
  case DataSet.EvaluatedAt of
    eaBlocks:
      begin
        Local3DCompiler := rparserThreeDFormulaElements;
      end;
    eaNodes:
      begin
        Local3DCompiler := rparserThreeDFormulaNodes;
      end;
  else
    Assert(False);
  end;

  DataType := DataSet.Datatype;
  case DataType of
    rdtDouble:
      begin
        Variable := TempFormulaCompiler.CreateVariable(NewName,
          DataSet.FullClassification, 0.0, NewDisplayName);
        if TempFormulaCompiler <> Local3DCompiler then
        begin
          Local3DCompiler.CreateVariable(NewName, DataSet.FullClassification, 0.0, NewDisplayName);
        end;
      end;
    rdtInteger:
      begin
        Variable := TempFormulaCompiler.CreateVariable(NewName,
          DataSet.FullClassification, 0, NewDisplayName);
        if TempFormulaCompiler <> Local3DCompiler then
        begin
          Local3DCompiler.CreateVariable(NewName, DataSet.FullClassification, 0, NewDisplayName);
        end;
      end;
    rdtBoolean:
      begin
        Variable := TempFormulaCompiler.CreateVariable(NewName,
          DataSet.FullClassification, False, NewDisplayName);
        if TempFormulaCompiler <> Local3DCompiler then
        begin
          Local3DCompiler.CreateVariable(NewName, DataSet.FullClassification, False, NewDisplayName);
        end;
      end;
    rdtString:
      begin
        Variable := TempFormulaCompiler.CreateVariable(NewName,
          DataSet.FullClassification, '0', NewDisplayName);
        if TempFormulaCompiler <> Local3DCompiler then
        begin
          Local3DCompiler.CreateVariable(NewName, DataSet.FullClassification, '0', NewDisplayName);
        end;
      end;
  else
    Assert(False);
  end;
  Edit.Variable := Variable;
end;

function TfrmScreenObjectProperties.GetElevationCompiler: TRbwParser;
var
  AScreenObject: TScreenObject;
begin
  // GetElevationCompiler returns the compiler that is appropriate
  // for specifying the elevation formula for a screen object based on the
  // direction from which the screen object is viewed and whether it is evaluated
  // by blocks or nodes.
  result := nil;
  AScreenObject := nil;
  if FScreenObject = nil then
  begin
    if FScreenObjectList.Count > 0 then
    begin
      AScreenObject := FScreenObjectList[0];
    end;
  end
  else
  begin
    AScreenObject := FScreenObject
  end;
  if AScreenObject = nil then
  begin
    result := nil;
  end
  else
  begin
    case rgEvaluatedAt.ItemIndex of
      0:
        begin
          case AScreenObject.ViewDirection of
            vdTop:
              begin
                result := rparserTopFormulaElements;
              end;
            vdFront:
              begin
                result := rparserFrontFormulaElements;
              end;
            vdSide:
              begin
                result := rparserSideFormulaElements;
              end;
          else
            Assert(False);
          end;
        end;
      1:
        begin
          case AScreenObject.ViewDirection of
            vdTop:
              begin
                result := rparserTopFormulaNodes;
              end;
            vdFront:
              begin
                result := rparserFrontFormulaNodes;
              end;
            vdSide:
              begin
                result := rparserSideFormulaNodes;
              end;
          else
            Assert(False);
          end;
        end;
    else
      result := nil;
    end;
  end;
end;

function TfrmScreenObjectProperties.GetCompiler(const Orientation:
  TDataSetOrientation; const EvaluatedAt: TEvaluatedAt): TRbwParser;
begin
  // GetCompiler returns the appropriate TRbwParser based on the
  // combination of Orientation and EvaluatedAt.
  result := nil;
  case EvaluatedAt of
    eaBlocks:
      begin
        case Orientation of
          dsoTop:
            begin
              result := rparserTopFormulaElements;
            end;
          dsoFront:
            begin
              result := rparserFrontFormulaElements;
            end;
          dsoSide:
            begin
              result := rparserSideFormulaElements;
            end;
          dso3D:
            begin
              result := rparserThreeDFormulaElements;
            end;
        else
          Assert(False);
        end;
      end;
    eaNodes:
      begin
        case Orientation of
          dsoTop:
            begin
              result := rparserTopFormulaNodes;
            end;
          dsoFront:
            begin
              result := rparserFrontFormulaNodes;
            end;
          dsoSide:
            begin
              result := rparserSideFormulaNodes;
            end;
          dso3D:
            begin
              result := rparserThreeDFormulaNodes;
            end;
        else
          Assert(False);
        end;
      end;
  else
    Assert(False);
  end;
end;

function TfrmScreenObjectProperties.GetCompilerByIndex(const Index: integer):
  TRbwParser;
var
  DataSet: TDataArray;
  Orientation: TDataSetOrientation;
  EvaluatedAt: TEvaluatedAt;
  Edit: TScreenObjectDataEdit;
begin
  // GetCompiler determines the Orientation and EvaluatedAt of the data set
  // at Index and returns the appropriate compiler based on that combination.
  Edit := FDataEdits[Index];
  DataSet := Edit.DataArray;
  Orientation := DataSet.Orientation;
  EvaluatedAt := DataSet.EvaluatedAt;

  result := GetCompiler(Orientation, EvaluatedAt);
end;

procedure TfrmScreenObjectProperties.GetGhbBoundary(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectCondParam;
  Parameter: TParameterType;
begin
  if not frmGoPhast.PhastModel.GhbIsSelected then
  begin
    Exit;
  end;
  Frame := frameGhbParam;
  Parameter := ptGHB;
  GetFormulaInterpretation(Frame, Parameter, ScreenObjectList);
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FGHB_Node);
end;

procedure TfrmScreenObjectProperties.GetWellBoundary(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectCondParam;
  Parameter: TParameterType;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TMfWellBoundary;
  First: Boolean;
begin
  if not frmGoPhast.PhastModel.WelIsSelected then
  begin
    Exit;
  end;
  Frame := frameWellParam;
  Parameter := ptQ;
  GetFormulaInterpretation(Frame, Parameter, ScreenObjectList);
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FWEL_Node);
  First := True;
  for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[ScreenObjectIndex];
    Boundary := AScreenObject.ModflowWellBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      if First then
      begin
        frameWellParam.fedTabfile.FileName := Boundary.TabFileName;
        First := False;
      end
      else if frameWellParam.fedTabfile.FileName <> Boundary.TabFileName then
      begin
        frameWellParam.fedTabfile.FileName := '';
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.GetFarmWell(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectCondParam;
  Parameter: TParameterType;
begin
  if not frmGoPhast.PhastModel.FarmProcessIsSelected then
  begin
    Exit;
  end;
  Frame := frameFarmWell;
  Parameter := ptQMAX;
  GetFormulaInterpretation(Frame, Parameter, ScreenObjectList);
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FFarmWell_Node);
end;

procedure TfrmScreenObjectProperties.GetRivBoundary(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectCondParam;
  Parameter: TParameterType;
begin
  if not frmGoPhast.PhastModel.RivIsSelected then
  begin
    Exit;
  end;
  Frame := frameRivParam;
  Parameter := ptRIV;
  GetFormulaInterpretation(Frame, Parameter, ScreenObjectList);
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FRIV_Node);
end;

function TfrmScreenObjectProperties.GetSfrParser(Sender: TObject): TRbwParser;
begin
  result := rparserThreeDFormulaElements;
end;

procedure TfrmScreenObjectProperties.GetCfpRechargeBoundary(ScreenObjectList: TList);
var
//  FirstScreenObjectFound: boolean;
  TimeList: TParameterTimeList;
  State: TCheckBoxState;
  ScreenObjectIndex: integer;
  AScreenObject: TScreenObject;
  Boundary: TCfpRchFractionBoundary;
  TimeIndex: Integer;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  ColumnOffset: integer;
  AnotherValues: TCustomMF_BoundColl;
//  AScreenObject: TScreenObject;
//  Boundary :TModflowBoundary;
  Values: TCustomMF_BoundColl;
  ValuesIdentical: boolean;
  AnotherBoundary: TCfpRchFractionBoundary;
  RowIndex: integer;
  BoundaryIndex: integer;
begin
  if not frmGoPhast.PhastModel.CfpRechargeIsSelected(nil) then
  begin
    Exit;
  end;
//  FirstScreenObjectFound := False;
  TimeList := TParameterTimeList.Create;
  try
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowCfpRchFraction;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
    if FCRCH_Node <> nil then
    begin
      FCRCH_Node.StateIndex := Ord(State)+1;
    end;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowCfpRchFraction;
      if Boundary <> nil then
      begin
        // get all the times associated with the boundary.
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

// display the times that are left.
    frameCfpRechargeFraction.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameCfpRechargeFraction.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;

      AScreenObject := ScreenObjectList[0];
      Boundary := AScreenObject.ModflowCfpRchFraction;
      if Boundary = nil then
      begin
        Values := nil;
      end
      else
      begin
        Values := Boundary.Values;
      end;
      ValuesIdentical := True;
      for ScreenObjectIndex := 1 to ScreenObjectList.Count - 1 do
      begin
        AScreenObject := ScreenObjectList[ScreenObjectIndex];
        AnotherBoundary := AScreenObject.ModflowCfpRchFraction;
        if (Boundary = nil) and (AnotherBoundary = nil) then
        begin
          ValuesIdentical := True;
        end
        else if (Boundary = nil) or (AnotherBoundary = nil) then
        begin
          ValuesIdentical := False;
        end
        else
        begin
          AnotherValues := AnotherBoundary.Values;
          ValuesIdentical := Values.IsSame(AnotherValues);
        end;
        if not ValuesIdentical then
        begin
          break;
        end;
      end;
      if ValuesIdentical and (Values <> nil) then
      begin
        for TimeIndex := 0 to Values.Count - 1 do
        begin
          Item := Values[TimeIndex] as TCustomModflowBoundaryItem;
          RowIndex := TimeList.IndexOfTime(Item.StartTime, Item.EndTime) + 1;
          Assert(RowIndex >= 1);
          for BoundaryIndex := 0 to Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
          begin
            DataGrid.Cells[ColumnOffset + BoundaryIndex, RowIndex] :=
              Item.BoundaryFormula[BoundaryIndex];
          end;
        end;
      end;

    finally
      DataGrid.EndUpdate;
    end


  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetUzfBoundary(ScreenObjectList: TList);
var
  TimeList: TParameterTimeList;
  ColumnOffset: integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TUzfBoundary;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  TimeIndex: Integer;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  Gage1, Gage2: integer;
  FirstScreenObjectFound: boolean;
  State: TCheckBoxState;
begin
  if not frmGoPhast.PhastModel.UzfIsSelected then
  begin
    Exit;
  end;
  FirstScreenObjectFound := False;
  TimeList := TParameterTimeList.Create;
  try
    cbUzfGage1.AllowGrayed := False;
    cbUzfGage2.AllowGrayed := False;
    cbUzfGage3.AllowGrayed := False;
    Gage1 := -1;
    Gage2 := -1;
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowUzfBoundary;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
    if FUZF_Node <> nil then
    begin
      FUZF_Node.StateIndex := Ord(State)+1;
    end;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowUzfBoundary;
      if Boundary <> nil then
      begin
        // get all the times associated with the boundary.
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
        for TimeIndex := 0 to Boundary.EvapotranspirationDemand.Count - 1 do
        begin
          Item := Boundary.EvapotranspirationDemand[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
        for TimeIndex := 0 to Boundary.ExtinctionDepth.Count - 1 do
        begin
          Item := Boundary.ExtinctionDepth[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
        for TimeIndex := 0 to Boundary.WaterContent.Count - 1 do
        begin
          Item := Boundary.WaterContent[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
        if not FirstScreenObjectFound then
        begin
          Gage1 := AScreenObject.ModflowUzfBoundary.GageOption1;
          Gage2 := AScreenObject.ModflowUzfBoundary.GageOption2;
        end
        else
        begin
          if Gage1 <> AScreenObject.ModflowUzfBoundary.GageOption1 then
          begin
            Gage1 := -1;
          end;
          if Gage2 <> AScreenObject.ModflowUzfBoundary.GageOption2 then
          begin
            Gage2 := -1;
          end;
        end;
        FirstScreenObjectFound := True;
      end;
    end;
    if not FirstScreenObjectFound then
    begin
      cbUzfGage1.Checked := False;
      cbUzfGage2.Checked := False;
    end
    else if Gage1 < 0 then
    begin
      cbUzfGage1.AllowGrayed := True;
      cbUzfGage1.State := cbGrayed;
      cbUzfGage2.AllowGrayed := True;
      cbUzfGage2.State := cbGrayed;
    end
    else
    begin
      case Gage1 of
        0:
          begin
            cbUzfGage1.Checked := False;
            cbUzfGage2.Checked := False;
          end;
        1:
          begin
            cbUzfGage1.Checked := True;
            cbUzfGage2.Checked := False;
          end;
        2:
          begin
            cbUzfGage1.Checked := True;
            cbUzfGage2.Checked := True;
          end;
        else
          Assert(False);
      end;
    end;
    if not FirstScreenObjectFound then
    begin
      cbUzfGage3.Checked := False;
    end
    else if Gage2 < 0 then
    begin
      cbUzfGage3.AllowGrayed := True;
      cbUzfGage3.State := cbGrayed;
    end
    else
    begin
      case Gage2 of
        0:
          begin
            cbUzfGage3.Checked := False;
          end;
        3:
          begin
            cbUzfGage3.Checked := True;
          end;
        else
          Assert(False);
      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

    // display the times that are left.
    frameScreenObjectUZF.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameScreenObjectUZF.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;
      GetUzfCollection(TimeList, ScreenObjectList, ColumnOffset,
        DataGrid, GetUzfInfiltrationRate);

      if frmGoPhast.PhastModel.ModflowPackages.UzfPackage.SimulateET then
      begin
        ColumnOffset := 3;
        GetUzfCollection(TimeList, ScreenObjectList, ColumnOffset,
          DataGrid, GetUzfEtRate);

        ColumnOffset := 4;
        GetUzfCollection(TimeList, ScreenObjectList, ColumnOffset,
          DataGrid, GetUzfEtExtinctionDepth);

        ColumnOffset := 5;
        GetUzfCollection(TimeList, ScreenObjectList, ColumnOffset,
          DataGrid, GetUzfEtExtinctionWaterContent);
      end;
    finally
      DataGrid.EndUpdate;
    end;

  finally
    TimeList.Free;
  end;
end;

function TfrmScreenObjectProperties.GetUzfEtRate(Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := (Boundary as TUzfBoundary).EvapotranspirationDemand
end;

function TfrmScreenObjectProperties.GetUzfEtExtinctionDepth(Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := (Boundary as TUzfBoundary).ExtinctionDepth
end;

function TfrmScreenObjectProperties.GetUzfEtExtinctionWaterContent(Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := (Boundary as TUzfBoundary).WaterContent
end;

function TfrmScreenObjectProperties.GetUzfInfiltrationRate(Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := (Boundary as TUzfBoundary).Values;
end;

procedure TfrmScreenObjectProperties.GetDrnBoundary(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectCondParam;
  Parameter: TParameterType;
begin
  if not frmGoPhast.PhastModel.DrnIsSelected then
  begin
    Exit;
  end;
  Frame := frameDrnParam;
  Parameter := ptDRN;
  GetFormulaInterpretation(Frame, Parameter, ScreenObjectList);
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FDRN_Node);
end;

function TfrmScreenObjectProperties.GetRechargeLayers(
  Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := (Boundary as TRchBoundary).RechargeLayers;
end;

function TfrmScreenObjectProperties.GetEvapLayers(
  Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := (Boundary as TEvtBoundary).EvapotranspirationLayers;
end;

function TfrmScreenObjectProperties.GetEtsLayers(
  Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := (Boundary as TEtsBoundary).EvapotranspirationLayers;
end;

function TfrmScreenObjectProperties.GetEvapSurfaceDepth(
  Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := (Boundary as TEvtBoundary).EvtSurfDepthCollection;
end;

function TfrmScreenObjectProperties.GetEtsSurfaceDepth(
  Boundary: TModflowBoundary): TCustomMF_BoundColl;
begin
  result := (Boundary as TEtsBoundary).EtsSurfDepthCollection;
end;

procedure TfrmScreenObjectProperties.GetRchBoundary(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectParam;
  Parameter: TParameterType;
  TimeList: TParameterTimeList;
  ValuesFunction: TGetBoundaryCollectionEvent;
  ColumnOffset: integer;
begin
  if not frmGoPhast.PhastModel.RchIsSelected then
  begin
    Exit;
  end;
  Frame := frameRchParam;
  Parameter := ptRch;
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FRCH_Node);

  if frmGoPhast.PhastModel.RchTimeVaryingLayers then
  begin
    TimeList := TParameterTimeList.Create;
    try
      GetModflowBoundaryTimes(ScreenObjectList, Parameter, TimeList);
      ColumnOffset := 3;
      ValuesFunction := GetRechargeLayers;

      GetModflowBoundaryCollection(Frame.dgModflowBoundary, ValuesFunction,
        ColumnOffset, ScreenObjectList, Parameter, TimeList);
    finally
      TimeList.Free;
    end;

  end;
end;

procedure TfrmScreenObjectProperties.GetEvtBoundary(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectParam;
  Parameter: TParameterType;
  TimeList: TParameterTimeList;
  ValuesFunction: TGetBoundaryCollectionEvent;
  ColumnOffset: integer;
begin
  if not frmGoPhast.PhastModel.EvtIsSelected then
  begin
    Exit;
  end;
  Frame := frameEvtParam;
  Parameter := ptEvt;
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FEVT_Node);

  if frmGoPhast.PhastModel.EvtTimeVaryingLayers then
  begin
    TimeList := TParameterTimeList.Create;
    try
      GetModflowBoundaryTimes(ScreenObjectList, Parameter, TimeList);
      ColumnOffset := 5;
      ValuesFunction := GetEvapLayers;

      GetModflowBoundaryCollection(Frame.dgModflowBoundary, ValuesFunction,
        ColumnOffset, ScreenObjectList, Parameter, TimeList);
    finally
      TimeList.Free;
    end;

  end;
  TimeList := TParameterTimeList.Create;
  try
    GetModflowBoundaryTimes(ScreenObjectList, Parameter, TimeList);
    ColumnOffset := 3;
    ValuesFunction := GetEvapSurfaceDepth;

    GetModflowBoundaryCollection(Frame.dgModflowBoundary, ValuesFunction,
      ColumnOffset, ScreenObjectList, Parameter, TimeList);
  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetEtsBoundary(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectParam;
  Parameter: TParameterType;
  TimeList: TParameterTimeList;
  ValuesFunction: TGetBoundaryCollectionEvent;
  ColumnOffset: integer;
begin
  if not frmGoPhast.PhastModel.EtsIsSelected then
  begin
    Exit;
  end;
  Frame := frameEtsParam;
  Parameter := ptETS;
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FETS_Node);

  if frmGoPhast.PhastModel.EtsTimeVaryingLayers then
  begin
    TimeList := TParameterTimeList.Create;
    try
      GetModflowBoundaryTimes(ScreenObjectList, Parameter, TimeList);
      ColumnOffset := 5 + (frmGoPhast.PhastModel.ModflowPackages.
        EtsPackage.SegmentCount -1) * 2;
      ValuesFunction := GetEtsLayers;

      GetModflowBoundaryCollection(Frame.dgModflowBoundary, ValuesFunction,
        ColumnOffset, ScreenObjectList, Parameter, TimeList);
    finally
      TimeList.Free;
    end;

  end;
  TimeList := TParameterTimeList.Create;
  try
    GetModflowBoundaryTimes(ScreenObjectList, Parameter, TimeList);
    ColumnOffset := 3;
    ValuesFunction := GetEtsSurfaceDepth;

    GetModflowBoundaryCollection(Frame.dgModflowBoundary, ValuesFunction,
      ColumnOffset, ScreenObjectList, Parameter, TimeList);
  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetResBoundary(ScreenObjectList: TList);
var
  TimeList: TParameterTimeList;
  ColumnOffset: integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  TimeIndex: Integer;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  State: TCheckBoxState;
begin
  if not frmGoPhast.PhastModel.ResIsSelected then
  begin
    Exit;
  end;
  TimeList := TParameterTimeList.Create;
  try
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowResBoundary;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
    if FRES_Node <> nil then
    begin
      FRES_Node.StateIndex := Ord(State)+1;
    end;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowResBoundary;
      // get all the times associated with the boundary.
      if Boundary <> nil then
      begin
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

    // display the times that are left.
    frameRes.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameRes.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;
      GetReservoirBoundaryCollection(DataGrid, ColumnOffset,
        ScreenObjectList, TimeList);
    finally
      DataGrid.EndUpdate;
    end;

  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetMt3dmsChemBoundary(ScreenObjectList: TList);
var
  TimeList: TParameterTimeList;
  ColumnOffset: integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TMt3dmsConcBoundary;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  TimeIndex: Integer;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  State: TCheckBoxState;
  FoundFirst: boolean;
begin
  if not frmGoPhast.PhastModel.Mt3dmsIsSelected then
  begin
    Exit;
  end;
  TimeList := TParameterTimeList.Create;
  try
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.Mt3dmsConcBoundary;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
   if FMt3dmsSsm_Node <> nil then
    begin
      FMt3dmsSsm_Node.StateIndex := Ord(State)+1;
    end;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.Mt3dmsConcBoundary;
      if Boundary <> nil then
      begin
        // get all the times associated with the boundary.
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

    // display the times that are left.
    frameMT3DMS_SSM.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameMT3DMS_SSM.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;
      GetMt3dmsBoundaryCollection(DataGrid, ColumnOffset,
        ScreenObjectList, TimeList);

    finally
      DataGrid.EndUpdate;
    end;

    FoundFirst := False;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.Mt3dmsConcBoundary;
      if Boundary <> nil then
      begin
        if FoundFirst then
        begin
          if frameMT3DMS_SSM.cbSpecifiedConcentration.Checked <> Boundary.SpecifiedConcBoundary then
          begin
            frameMT3DMS_SSM.cbSpecifiedConcentration.AllowGrayed := True;
            frameMT3DMS_SSM.cbSpecifiedConcentration.State := cbGrayed
          end;
          if frameMT3DMS_SSM.cbMassLoading.Checked <> Boundary.MassLoadingBoundary then
          begin
            frameMT3DMS_SSM.cbMassLoading.AllowGrayed := True;
            frameMT3DMS_SSM.cbMassLoading.State := cbGrayed
          end;
        end
        else
        begin
          frameMT3DMS_SSM.cbSpecifiedConcentration.Checked := Boundary.SpecifiedConcBoundary;
          frameMT3DMS_SSM.cbMassLoading.Checked := Boundary.MassLoadingBoundary;
        end;
      end;
    end;

  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetLakBoundary(ScreenObjectList: TList);
var
  TimeList: TParameterTimeList;
  ColumnOffset: integer;
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
  Boundary: TLakBoundary;
  Item: TCustomModflowBoundaryItem;
  Time: TParameterTime;
  TimeIndex: Integer;
  Time1: TParameterTime;
  Time2: TParameterTime;
  DataGrid: TRbwDataGrid4;
  State: TCheckBoxState;
  Gage0: TCheckBoxState;
  Gage1: TCheckBoxState;
  Gage2: TCheckBoxState;
  Gage4: TCheckBoxState;
  FirstGage: boolean;
  OutState0: TCheckBoxState;
  OutState1: TCheckBoxState;
  OutState2: TCheckBoxState;
  OutState4: TCheckBoxState;
begin
  if not frmGoPhast.PhastModel.LakIsSelected then
  begin
    Exit;
  end;
  TimeList := TParameterTimeList.Create;
  try
    State := cbUnchecked;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowLakBoundary;
      UpdateBoundaryState(Boundary, ScreenObjectIndex, State);
    end;
   if FLAK_Node <> nil then
    begin
      FLAK_Node.StateIndex := Ord(State)+1;
    end;
    for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
    begin
      AScreenObject := ScreenObjectList[ScreenObjectIndex];
      Boundary := AScreenObject.ModflowLakBoundary;
      if Boundary <> nil then
      begin
        // get all the times associated with the boundary.
        for TimeIndex := 0 to Boundary.Values.Count - 1 do
        begin
          Item := Boundary.Values[TimeIndex] as TCustomModflowBoundaryItem;
          Time := TParameterTime.Create;
          Time.StartTime := Item.StartTime;
          Time.EndTime := Item.EndTime;
          TimeList.Add(Time);
        end;
      end;
    end;
    // Sort the times in ascending order.
    TimeList.Sort;
    // get rid of duplicate times.
    for TimeIndex := TimeList.Count - 1 downto 1 do
    begin
      Time1 := TimeList[TimeIndex];
      Time2 := TimeList[TimeIndex - 1];
      if (Time1.StartTime = Time2.StartTime) and (Time1.EndTime = Time2.EndTime) then
      begin
        TimeList.Delete(TimeIndex);
      end;
    end;

    // display the times that are left.
    frameLak.seNumberOfTimes.Value := TimeList.Count;
    DataGrid := frameLak.dgModflowBoundary;
    DataGrid.BeginUpdate;
    try
      for TimeIndex := 0 to TimeList.Count - 1 do
      begin
        Time := TimeList[TimeIndex];
        DataGrid.Cells[0, TimeIndex + 1] := FloatToStr(Time.StartTime);
        DataGrid.Cells[1, TimeIndex + 1] := FloatToStr(Time.EndTime);
      end;

      ColumnOffset := 2;
      GetLakeBoundaryCollection(DataGrid, ColumnOffset,
        ScreenObjectList, TimeList);

      FirstGage := True;
      Gage0 := cbUnChecked;
      Gage1 := cbUnChecked;
      Gage2 := cbUnChecked;
      Gage4 := cbUnChecked;
      for ScreenObjectIndex := 0 to ScreenObjectList.Count - 1 do
      begin
        AScreenObject := ScreenObjectList[ScreenObjectIndex];
        Boundary := AScreenObject.ModflowLakBoundary;
        if (Boundary <> nil) and Boundary.Used then
        begin
          if FirstGage then
          begin
            if Boundary.StandardGage then
            begin
              Gage0 := cbChecked;
              if Boundary.FluxCondGage then
              begin
                Gage1 := cbChecked;
              end
              else
              begin
                Gage1 := cbUnChecked;
              end;
              if Boundary.DeltaGage then
              begin
                Gage2 := cbChecked;
              end
              else
              begin
                Gage2 := cbUnChecked;
              end;
            end
            else
            begin
              Gage0 := cbUnChecked;
              Gage1 := cbUnChecked;
              Gage2 := cbUnChecked;
            end;

            if Boundary.Gage4 then
            begin
              Gage4 := cbChecked;
            end
            else
            begin
              Gage4 := cbUnChecked;
            end;

            FirstGage := False;
          end
          else
          begin
            if Boundary.StandardGage then
            begin
              OutState0 := cbChecked;
              if Boundary.FluxCondGage then
              begin
                OutState1 := cbChecked;
              end
              else
              begin
                OutState1 := cbUnChecked;
              end;
              if Boundary.DeltaGage then
              begin
                OutState2 := cbChecked;
              end
              else
              begin
                OutState2 := cbUnChecked;
              end;
            end
            else
            begin
              OutState0 := cbUnChecked;
              OutState1 := cbUnChecked;
              OutState2 := cbUnChecked;
            end;
            if Boundary.Gage4 then
            begin
              OutState4 := cbChecked;
            end
            else
            begin
              OutState4 := cbUnChecked;
            end;
            if Gage0 <> OutState0 then
            begin
              Gage0 := cbGrayed;
            end;
            if Gage1 <> OutState1 then
            begin
              Gage1 := cbGrayed;
            end;
            if Gage2 <> OutState2 then
            begin
              Gage2 := cbGrayed;
            end;
            if Gage4 <> OutState4 then
            begin
              Gage4 := cbGrayed;
            end;
          end;
        end;
      end;
      frameLak.cbGagStandard.State := Gage0;
      frameLak.cbGagFluxAndCond.State := Gage1;
      frameLak.cbGagDelta.State := Gage2;
      frameLak.cbGage4.State := Gage4;
      frameLak.cbGagStandard.OnClick(nil);
      frameLak.cbGagFluxAndCond.OnClick(nil);
      frameLak.cbGagDelta.OnClick(nil);
      frameLak.cbGage4.OnClick(nil);
    finally
      DataGrid.EndUpdate;
    end;
  finally
    TimeList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.GetDrtBoundary(ScreenObjectList: TList);
var
  Frame: TframeScreenObjectCondParam;
  Parameter: TParameterType;
  Index: Integer;
  AScreenObject: TScreenObject;
  First: Boolean;
  DrainReturn: TDrainReturn;
  FirstObject, FirstLocation, FirstCell: Boolean;
begin
  if not frmGoPhast.PhastModel.DrtIsSelected then
  begin
    Exit;
  end;
  comboDrtLocationChoice.ItemIndex := 0;
  comboDrtLocationChoiceChange(nil);
  rdeDrtCol.Text := '1';
  rdeDrtRow.Text := '1';
  rdeDrtLay.Text := '1';
  rdeDrtX.Text := '0';
  rdeDrtY.Text := '0';
  rdeDrtZ.Text := '0';
  First := True;
  FirstObject := True;
  FirstLocation := True;
  FirstCell := True;
  for Index := 0 to ScreenObjectList.Count - 1 do
  begin
    AScreenObject := ScreenObjectList[Index];
    if (AScreenObject.ModflowDrtBoundary <> nil)
      and AScreenObject.ModflowDrtBoundary.Used then
    begin
      DrainReturn := AScreenObject.ModflowDrtBoundary.DrainReturn;
      if First then
      begin
        comboDrtLocationChoice.ItemIndex :=
          Ord(DrainReturn.ReturnChoice);
        comboDrtLocationChoiceChange(nil);
        First := False;
        case DrainReturn.ReturnChoice of
          rtNone: ; // do nothing
          rtObject:
            begin
              comboDrtReturnObject.ItemIndex :=
                comboDrtReturnObject.Items.IndexOf(
                DrainReturn.ReturnObject.ObjectName);
              FirstObject := False;
            end;
          rtLocation:
            begin
              rdeDrtX.Text := FloatToStr(DrainReturn.ReturnLocation.X);
              rdeDrtY.Text := FloatToStr(DrainReturn.ReturnLocation.Y);
              rdeDrtZ.Text := FloatToStr(DrainReturn.ReturnLocation.Z);
              FirstLocation := False;
            end;
          rtCell:
            begin
              rdeDrtCol.Text := IntToStr(DrainReturn.ReturnCell.Col);
              rdeDrtRow.Text := IntToStr(DrainReturn.ReturnCell.Row);
              rdeDrtLay.Text := IntToStr(DrainReturn.ReturnCell.Lay);
              FirstCell := False;
            end;
          else Assert(False);
        end;
      end
      else
      begin
        if comboDrtLocationChoice.ItemIndex <>
          Ord(DrainReturn.ReturnChoice) then
        begin
          comboDrtLocationChoice.ItemIndex := -1;
          comboDrtLocationChoiceChange(nil);
        end;
        case DrainReturn.ReturnChoice of
          rtNone: ; // do nothing
          rtObject:
            begin
              if FirstObject then
              begin
                comboDrtReturnObject.ItemIndex :=
                  comboDrtReturnObject.Items.IndexOf(
                  DrainReturn.ReturnObject.ObjectName);
                FirstObject := False;
              end
              else
              begin
                if comboDrtReturnObject.ItemIndex <>
                  comboDrtReturnObject.Items.IndexOf(
                  DrainReturn.ReturnObject.ObjectName) then
                begin
                  comboDrtReturnObject.ItemIndex := -1;
                end;
              end;
            end;
          rtLocation:
            begin
              if FirstLocation then
              begin
                rdeDrtX.Text := FloatToStr(DrainReturn.ReturnLocation.X);
                rdeDrtY.Text := FloatToStr(DrainReturn.ReturnLocation.Y);
                rdeDrtZ.Text := FloatToStr(DrainReturn.ReturnLocation.Z);
                FirstLocation := False;
              end
              else
              begin
                if rdeDrtX.Text <> FloatToStr(DrainReturn.ReturnLocation.X) then
                begin
                  rdeDrtX.Text := '';
                end;
                if rdeDrtY.Text <> FloatToStr(DrainReturn.ReturnLocation.Y) then
                begin
                  rdeDrtY.Text := '';
                end;
                if rdeDrtZ.Text <> FloatToStr(DrainReturn.ReturnLocation.Z) then
                begin
                  rdeDrtZ.Text := '';
                end;
              end;
            end;
          rtCell:
            begin
              if FirstCell then
              begin
                rdeDrtCol.Text := IntToStr(DrainReturn.ReturnCell.Col);
                rdeDrtRow.Text := IntToStr(DrainReturn.ReturnCell.Row);
                rdeDrtLay.Text := IntToStr(DrainReturn.ReturnCell.Lay);
                FirstCell := False;
              end
              else
              begin
                if rdeDrtCol.Text <> FloatToStr(DrainReturn.ReturnCell.Col) then
                begin
                  rdeDrtCol.Text := '';
                end;
                if rdeDrtRow.Text <> FloatToStr(DrainReturn.ReturnCell.Row) then
                begin
                  rdeDrtRow.Text := '';
                end;
                if rdeDrtLay.Text <> FloatToStr(DrainReturn.ReturnCell.Lay) then
                begin
                  rdeDrtLay.Text := '';
                end;
              end;
            end;
          else Assert(False);
        end;
      end;
    end;
  end;
  Frame := frameDrtParam;
  Parameter := ptDRT;
  GetFormulaInterpretation(Frame, Parameter, ScreenObjectList);
  GetModflowBoundary(Frame, Parameter, ScreenObjectList, FDRT_Node);
end;

procedure TfrmScreenObjectProperties.CreateBoundaryFormula(const DataGrid:
  TRbwDataGrid4; const ACol, ARow: integer; Formula: string;
  const Orientation: TDataSetOrientation; const EvaluatedAt: TEvaluatedAt);
var
  TempCompiler: TRbwParser;
  CompiledFormula: TExpression;
  ResultType: TRbwDataType;
//  DelCol: TDeliveryColumns;
  TestCol: Integer;
  CropIrrigationRequirement: TCropIrrigationRequirement;
  Divisor: integer;
begin
  // CreateBoundaryFormula creates an Expression for a boundary condition
  // based on the text in DataGrid at ACol, ARow. Orientation, and EvaluatedAt
  // are used to chose the TRbwParser.
  TempCompiler := GetCompiler(Orientation, EvaluatedAt);
  try
    TempCompiler.Compile(Formula);

  except on E: ERbwParserError do
    begin
      Beep;
      raise ERbwParserError.Create(Format(StrErrorInFormulaS,
        [E.Message]));
      Exit;
    end
  end;
  CompiledFormula := TempCompiler.CurrentExpression;

  ResultType := rdtDouble;
  if (DataGrid = dgSpecifiedHead) or (DataGrid = dgBoundaryFlux) or
    (DataGrid = dgBoundaryLeaky) then
  begin
    if ACol = 2 then
    begin
      ResultType := rdtDouble;
    end
    else if ACol = 4 then
    begin
      ResultType := rdtInteger;
    end
    else
    begin
      Assert(False);
    end;
  end
  else if (DataGrid = dgBoundaryRiver) or (DataGrid = dgWell) then
  begin
    if ACol = 2 then
    begin
      ResultType := rdtDouble;
    end
    else if ACol = 3 then
    begin
      ResultType := rdtInteger;
    end
    else
    begin
      Assert(False);
    end;
  end
  else if (DataGrid.Owner is TframeScreenObjectNoParam) then
  begin
    ResultType := rdtDouble;
    if (DataGrid = frameRchParam.dgModflowBoundary)
      and frmGoPhast.PhastModel.RchTimeVaryingLayers
      and (ACol = 3) then
    begin
      // We are setting the formula for  the layer
      // to which the recharge will be applied.
      ResultType := rdtInteger;
    end
    else if (DataGrid = frameEvtParam.dgModflowBoundary)
      and frmGoPhast.PhastModel.EvtTimeVaryingLayers
      and (ACol = 5) then
    begin
      // We are setting the formula for  the layer
      // to which the recharge will be applied.
      ResultType := rdtInteger;
    end
    else if DataGrid = frameFarmWell.dgModflowBoundary then
    begin
      TestCol := ACol-2;
      CropIrrigationRequirement :=
        frmGoPhast.PhastModel.ModflowPackages.FarmProcess.CropIrrigationRequirement;
      Divisor := 1;
      case CropIrrigationRequirement of
        cirContinuously:
          begin
            Divisor := 2;
          end;
        cirOnlyWhenNeeded:
          begin
            Divisor := 3;
          end;
        else Assert(False);
      end;
      TestCol := TestCol mod Divisor;
      case TestCol of
        0:
          begin
            ResultType := rdtDouble;
          end;
        1:
          begin
            ResultType := rdtInteger;
          end;
        2:
          begin
            ResultType := rdtBoolean;
          end;
      end
    end
    else if DataGrid = frameFarmID.dgModflowBoundary then
    begin
      ResultType := rdtInteger;
    end
    else if DataGrid = frameFarmCropID.dgModflowBoundary then
    begin
      ResultType := rdtInteger;
    end;
  end
  else if (DataGrid.Owner is TCustomframeFluxObs) then
  begin
    ResultType := rdtDouble;
  end
  else if (DataGrid.Owner = frameScreenObjectSFR)
    or (DataGrid.Owner = frameMNW2)
    or (DataGrid.Owner is TframeCrossSection)
    or (DataGrid.Owner is TframeFlowTable) then
  begin
    ResultType := rdtDouble;
  end
  else if  (DataGrid.Owner = frameMNW1) then
  begin
    ResultType := rdtDouble;
    case TMnw1Columns(ACol) of
      mcDesiredPumpingRate, mcWaterQuality, mcWellRadius, mcConductance,
        mcSkinFactor, mcLimitingWaterLevel, mcReferenceElevation,
        mcNonLinearLossCoefficient, mcMinimumActiveRate,
        mcReactivationPumpingRate: ResultType := rdtDouble;
      mcWaterQualityGroup: ResultType := rdtInteger;
      else Assert(False);
    end;
  end
  else if (DataGrid.Owner is TframeSutraBoundary) then
  begin
    ResultType := rdtDouble;
  end
  else if
//    (DataGrid = frameScreenObjectFarm.frameFormulaGridCrops.Grid)
//    or (DataGrid = frameScreenObjectFarm.frameFormulaGridWaterRights.Grid)
//    or (DataGrid = frameScreenObjectFarm.frameFormulaGridCosts.Grid)
//    or
    (DataGrid = frameFarmPrecip.dgModflowBoundary)
    or (DataGrid = frameFarmRefEvap.dgModflowBoundary) then
  begin
    ResultType := rdtDouble;
  end
  else if (DataGrid = frameFarmCropID.dgModflowBoundary) then
  begin
    ResultType := rdtInteger;
  end
  else if (DataGrid = frameFarmID.dgModflowBoundary) then
  begin
    ResultType := rdtInteger;
  end
//  else if (DataGrid = frameScreenObjectFarm.frameDelivery.Grid) then
//  begin
//    DelCol := TDeliveryColumns((ACol - 2) mod 3);
//    case DelCol of
//      dcVolume:
//        begin
//          ResultType := rdtDouble;
//        end;
//      dcRank:
//        begin
//          ResultType := rdtInteger;
//        end;
//      else
//        Assert(False);
//    end;
//  end
  else
  begin
    Assert(False);
  end;

  if (ResultType = CompiledFormula.ResultType) or
    ((ResultType = rdtDouble) and (CompiledFormula.ResultType = rdtInteger))
      then
  begin
    DataGrid.Cells[ACol, ARow] := CompiledFormula.DecompileDisplay;
  end
  else
  begin
    Formula := AdjustFormula(Formula, CompiledFormula.ResultType, ResultType);
    TempCompiler.Compile(Formula);
    CompiledFormula := TempCompiler.CurrentExpression;
    DataGrid.Cells[ACol, ARow] := CompiledFormula.DecompileDisplay;
  end;
  if Assigned(DataGrid.OnSetEditText) then
  begin
    DataGrid.OnSetEditText(DataGrid, ACol, ARow, DataGrid.Cells[ACol, ARow]);
  end;
end;

function TfrmScreenObjectProperties.CreateMixtureFormula(const DataSetIndex:
  integer): TExpression;
var
  Formula: string;
  TempCompiler: TRbwParser;
  ResultType: TRbwDataType;
  Edit: TScreenObjectDataEdit;
begin
  result := nil;
  // Create a formula for a cell
  Formula := framePhastInterpolationData.edMixFormula.Text;
  TempCompiler := GetCompilerByIndex(DataSetIndex);
  try
    try
      TempCompiler.Compile(Formula);

    except on E: ErbwParserError do
      begin
        Beep;
        Edit := FDataEdits[DataSetIndex];
        MessageDlg(Format(StrErrorInMixtureFor,
          [Edit.DataArray.DisplayName, E.Message]), mtError, [mbOK], 0);
        Exit;
      end
    end;

    result := TempCompiler.CurrentExpression;
    framePhastInterpolationData.edMixFormula.Text := result.DecompileDisplay;
    ResultType := rdtDouble;
    // check that the formula is OK.
    if not (result.ResultType in [rdtDouble, rdtInteger]) then
    begin
      // If the formula is not OK, try to fix it.
      Beep;
      MessageDlg(StrTheFormulaYouEnte,
        mtError, [mbOK], 0);
      Formula := AdjustFormula(Formula, result.ResultType, ResultType);
      TempCompiler.Compile(Formula);
      result := TempCompiler.CurrentExpression;

      framePhastInterpolationData.edMixFormula.Text := result.DecompileDisplay;
    end;
  except
    raise;
  end;
end;

procedure TfrmScreenObjectProperties.CreateFormula(const DataSetIndex:
  integer; const NewFormula: string;
  const ShowError: boolean = True);
var
  Formula: string;
  TempCompiler: TRbwParser;
  CompiledFormula: TExpression;
  ResultType: TRbwDataType;
  Edit:  TScreenObjectDataEdit;
begin
  if NewFormula = '' then
  begin
    Exit;
  end;
  Edit := FDataEdits[DataSetIndex];
  // Create a formula for a cell

  Formula := NewFormula;
  TempCompiler := GetCompilerByIndex(DataSetIndex);
  try
    try
      TempCompiler.Compile(Formula);

    except on E: ErbwParserError do
      begin
        Edit.Expression := nil;
        Beep;
        MessageDlg(Format(StrErrorInFormulaFor,
          [Edit.DataArray.DisplayName, E.Message]), mtError, [mbOK], 0);
        Exit;
      end
    end;

    CompiledFormula := TempCompiler.CurrentExpression;
    if CompiledFormula = nil then
    begin
      Formula := Edit.Formula;
      try
        TempCompiler.Compile(Formula);
        CompiledFormula := TempCompiler.CurrentExpression;
      except on E: ErbwParserError do
        begin
          Edit.Expression := nil;
          Beep;
          MessageDlg(Format(StrErrorInFormulaFor,
            [Edit.DataArray.DisplayName, E.Message]), mtError, [mbOK], 0);
          Exit;
        end
      end;
    end;

    Edit.Formula := CompiledFormula.DecompileDisplay;
    ResultType := Edit.DataArray.DataType;
    // check that the formula is OK.
    if (ResultType = CompiledFormula.ResultType) or
      ((ResultType = rdtDouble) and (CompiledFormula.ResultType = rdtInteger))
        then
    begin
      Edit.Expression := CompiledFormula;
    end
    else
    begin
      // If the formula is not OK, try to fix it.
      Edit.Expression := nil;
      if ShowError then
      begin
        Beep;
        MessageDlg(StrTheFormulaYouEnte, mtError, [mbOK], 0);
      end;
      Formula := AdjustFormula(Formula, CompiledFormula.ResultType, ResultType);
      TempCompiler.Compile(Formula);
      CompiledFormula := TempCompiler.CurrentExpression;
      Edit.Expression := CompiledFormula;
      Edit.Formula := CompiledFormula.DecompileDisplay;
    end;
  except
    Edit.Expression := nil;
    raise;
  end;
end;

function TfrmScreenObjectProperties.AssignPoint(const Row: integer;
  out APoint: TPoint2D): boolean;
begin
  result := TryStrToFloat(dgVerticies.Cells[Ord(vcX), Row], APoint.X)
    and TryStrToFloat(dgVerticies.Cells[Ord(vcY), Row], APoint.Y);
end;

procedure TfrmScreenObjectProperties.dgVerticiesBeforeDrawCell(Sender: TObject;
  ACol, ARow: Integer);
var
  Dummy: Extended;
begin
  inherited;
  if (TVertexColumn(ACol) in [vcX, vcY]) and (ARow >= dgVerticies.FixedRows)
    and (dgVerticies.Cells[ACol, ARow] <> '') then
  begin
    if not TryStrToFloat(dgVerticies.Cells[ACol, ARow], Dummy)
      or not CanSetPoints then
    begin
      dgVerticies.Canvas.Brush.Color := clRed;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.dgVerticiesEndUpdate(Sender: TObject);
begin
  inherited;

  if FSettingVerticies or (csReading in ComponentState) then
  begin
    Exit;
  end;
  UpdateVertices;
  if FVertexRowCount <> dgVerticies.RowCount then
  begin
    FVertexRowCount := dgVerticies.RowCount;
    dgVerticies.BeginUpdate;
    try
      UpdateVertexNumbers;
      UpdateSectionNumbers;
    finally
      dgVerticies.EndUpdate;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.dgVerticiesEnter(Sender: TObject);
begin
  inherited;
  FVertexRowCount := dgVerticies.RowCount;
end;

procedure TfrmScreenObjectProperties.dgVerticiesStateChange(Sender: TObject;
  ACol, ARow: Integer; const Value: TCheckBoxState);
begin
  inherited;
  UpdateSectionNumbers;
end;

procedure TfrmScreenObjectProperties.UpdateDataSetLinkages(const Expression:
  TExpression; const DataSetIndex: integer; const DSName: string);
var
  TempUsesList, TempUsesList2: TStringList;
  UseList: TStringList;
  TempIndex: integer;
  DataSetName: string;
  DSIndex: integer;
  Edit, OtherEdit: TScreenObjectDataEdit;
  OtherDataSetIndex: integer;
begin
  // update the list of which variables depend on which
  // others.;
  TempUsesList := TStringList.Create;
  try
    // Put the list of variables used in Expression into TempUsesList.
    TempUsesList.Assign(Expression.VariablesUsed);
    // TempUsesList now has a list of the variables/datasets
    // in the expression.

    // Get the list of variables that depends on the DataSet whose
    // formula has been changed.
    Edit := FDataEdits[DataSetIndex];

    UseList := Edit.UsesList;
    // Add the additional variables that depend on it because
    // they depend on the variable/dataset being edited.
    UseList.AddStrings(TempUsesList);

    for TempIndex := 0 to TempUsesList.Count - 1 do
    begin
      // get the name of a variable
      DataSetName := TempUsesList[TempIndex];
      // get the row that has that variable.
      OtherDataSetIndex := GetDataSetIndexByName(DataSetName);
      if OtherDataSetIndex >= 0 then
      begin
        OtherEdit := FDataEdits[OtherDataSetIndex];
        // Get the list of variables that depends on it.
        OtherEdit.UsedBy.Add(Edit.DataArray.Name);
        // Add the additional variables that depend on it because
        // they depend on the variable/dataset being edited.
        OtherEdit.UsedBy.AddStrings(Edit.UsedBy);
      end;
    end;
  finally
    TempUsesList.Free;
  end;
  DSIndex := DataSetIndex;
  // Get the list of variables that depends on it.
  UseList := Edit.UsedBy;

  for OtherDataSetIndex := 0 to FDataEdits.Count - 1 do
  begin
    if DSIndex = OtherDataSetIndex then
    begin
      Continue;
    end;
    OtherEdit := FDataEdits[OtherDataSetIndex];
    TempUsesList2 := OtherEdit.UsedBy;
    if TempUsesList2.IndexOf(DSName) >= 0 then
    begin
      TempUsesList2.AddStrings(UseList);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.ValidateDataSetFormula(ShowError: boolean = True);
var
  Variable: TCustomValue;
  Index: integer;
  Used: TStringList;
  VariableName: string;
  Orientation: TDataSetOrientation;
  VariableList: TList;
  TempUsesList: TStringList;
  Expression: TExpression;
  VariablePosition: integer;
  OldFormula: string;
  OldFormulaOK: boolean;
  AFormula: string;
  Value: string;
  DSName: string;
  Tester: TRbwParser;
  CompilerList: TList;
  EditIndex: integer;
  OtherEdit: TScreenObjectDataEdit;
  NewEditIndex: integer;
  EvalAt: TEvaluatedAt;
begin
  if FCurrentEdit = nil then Exit;
  // ValidateDataSetFormula ensures that when a formula
  // for a data set has been entered, that the formula is valid.
  try
    if FCurrentEdit.Used = cbUnChecked then
    begin
      Exit;
    end;

    Value := reDataSetFormula.Text;
    if Trim(Value) = '' then
    begin
      Exit;
    end;

    DSName := FCurrentEdit.DataArray.Name;

    VariableList := TList.Create;
    // VariableList will hold a list of variables that can
    // be used in the function
    Used := TStringList.Create;
    // "Used" will be a list of variables that depend on
    // the data set whose formula will be edited.
    try
      Orientation := FCurrentEdit.DataArray.Orientation;
      EvalAt := FCurrentEdit.DataArray.EvaluatedAt;
      // Add the variable whose value is being set to "Used".

      Used.Assign(FCurrentEdit.UsesList);

      Used.Sorted := True;
      for EditIndex := 0 to FDataEdits.Count - 1 do
      begin
        OtherEdit := FDataEdits[EditIndex];
        if FCurrentEdit <> OtherEdit then
        begin
          VariableName := OtherEdit.DataArray.Name;
          TempUsesList := OtherEdit.UsesList;
          VariablePosition := TempUsesList.IndexOf(DSName);
          if (VariablePosition < 0)
            and (EvalAt = OtherEdit.DataArray.EvaluatedAt)
            and ((Orientation = dso3D)
            or (Orientation = OtherEdit.DataArray.Orientation)) then
          begin
            // if the variable does not depend on the
            // data set whose formula is being edited
            // and it's orientation is OK, the variable
            // can be used in the formula.
            VariableList.Add(OtherEdit.Variable);
          end;
        end;
      end;

      // if the user makes an invalid formula, it
      // may be necessary to restore it but only
      // if the formula that was already present
      // was OK to begin with.
      OldFormulaOK := FCurrentEdit.Expression <> nil;
      if OldFormulaOK then
      begin
        OldFormula := FCurrentEdit.Expression.DecompileDisplay;
      end;

      Tester := TRbwParser.Create(self);
      try
        AddGIS_Functions(Tester, frmGoPhast.PhastModel.ModelSelection,
          FCurrentEdit.DataArray.EvaluatedAt);
        // put the formula in the TfrmFormula.

        CompilerList := TList.Create;
        try
          CompilerList.Add(Tester);
          frmGoPhast.PhastModel.RefreshGlobalVariables(CompilerList);
        finally
          CompilerList.Free;
        end;

        AFormula := Value;

        // register the appropriate variables with the
        // parser.
        for Index := 0 to VariableList.Count - 1 do
        begin
          Variable := VariableList[Index];
          Tester.RegisterVariable(Variable);
        end;

        // show the variables and functions

        try
          Tester.Compile(AFormula);
        except on E: ErbwParserError do
          begin
            FCurrentEdit.Expression := nil;
            if ShowError then
            begin
              Beep;
              if OldFormulaOK then
              begin
                if MessageDlg(Format(StrSThisMightBeD, [E.Message]), mtError,
                  [mbYes, mbNo], 0) = mrYes then
                begin
                  NewEditIndex := GetDataSetIndexByName(DSName);
                  reDataSetFormula.Text := OldFormula;
                  CreateFormula(NewEditIndex, OldFormula);
                end;
              end
              else
              begin
                MessageDlg(Format(StrSThisMightBeDNoRevert, [E.Message]),
                  mtError, [mbOK], 0)
              end;
            end;
            Exit;
          end;
        end;

        FSetCellsColor := True;
        NewEditIndex := GetDataSetIndexByName(DSName);
        CreateFormula(NewEditIndex, AFormula);
        Expression := FCurrentEdit.Expression;

        if Expression <> nil then
        begin
          // Check that the formula does not result in
          // a circular reference.
          CheckForCircularReference(Expression, DSName, NewEditIndex,
            OldFormulaOK, OldFormula);
          if FCurrentEdit.Expression <> nil then
          begin
            FCurrentEdit.Formula := FCurrentEdit.Expression.DecompileDisplay;
          end;

          // update the list of which variables depend on which
          // others.;
          UpdateDataSetLinkages(Expression, NewEditIndex, DSName);
        end;
      finally
        Tester.Free;
      end;
    finally
      Used.Free;
      VariableList.Free;
      // Don't allow the user to click the OK button
      // if any formulas are invalid.
    end;
  finally
    EnableOK_Button;
  end;
end;

procedure TfrmScreenObjectProperties.ValidateEdFormula(const ed: TEdit);
var
  FunctionString: string;
  VariableList: TList;
  VarIndex, Index: integer;
  Variable: TCustomValue;
  Compiler: TRbwParser;
  CompiledFormula: TExpression;
  Tester: TRbwParser;
  AVar: TCustomValue;
begin
  // ValidateEdFormula ensures that when a formula has been entered at
  // one of the elevation edit boxes, that the formula is valid.
  inherited;
  try
    Assert((ed = edZ) or (ed = edHighZ) or (ed = edLowZ)
      or (ed = edLeakyHydraulicConductivity) or (ed = edLeakyThickness)
      or (ed = edRiverHydraulicConductivity) or (ed = edRiverWidth)
      or (ed = edRiverDepth) or (ed = edRiverBedThickness));
    if not ed.Enabled then
      Exit;
    if ed = edZ then
    begin
      FZFormula := nil;
    end
    else if ed = edHighZ then
    begin
      FHighZFormula := nil;
    end
    else if ed = edLowZ then
    begin
      FLowZFormula := nil;
    end
    else if (ed = edLeakyHydraulicConductivity) or (ed = edLeakyThickness)
      or (ed = edRiverHydraulicConductivity) or (ed = edRiverWidth)
      or (ed = edRiverDepth) or (ed = edRiverBedThickness) then
    begin
      // do nothing
    end
    else
    begin
      Assert(False);
    end;
    FunctionString := ed.Text;
    if (FunctionString = '') and (FScreenObject = nil) then
    begin
      Exit;
    end;

    CompiledFormula := nil;
    Compiler := GetElevationCompiler;
    if Compiler = nil then
    begin
      If IsLoaded then
      begin
        Beep;
        MessageDlg( StrYouMustSpecifyNod, mtInformation, [mbOK], 0);
      end;
    end
    else
    begin
      if ed.Enabled then
      begin
        ed.Color := clWindow;
      end
      else
      begin
        ed.Color := clBtnFace;
      end;
      VariableList := TList.Create;
      try
        for VarIndex := 0 to Compiler.VariableCount - 1 do
        begin
          AVar := Compiler.Variables[VarIndex];
          if VariableList.IndexOf(AVar) < 0 then
          begin
            VariableList.Add(AVar);
          end;
        end;

        Tester := TRbwParser.Create(self);
        try
          AddGIS_Functions(Tester, frmGoPhast.PhastModel.ModelSelection,
            TEvaluatedAt(rgEvaluatedAt.ItemIndex));
          for Index := 0 to VariableList.Count - 1 do
          begin
            Variable := VariableList[Index];
            Tester.RegisterVariable(Variable);
          end;

          try
            Tester.Compile(FunctionString);
          except on E: ERbwParserError do
            begin
              ed.Color := clRed;
              Beep;
              MessageDlg(Format(StrErrorInFormulaS, [E.Message]),
                mtError, [mbOK], 0);
              Exit;
            end;
          end;
        finally
          Tester.Free;
        end;

        try
          Compiler.Compile(FunctionString);
        except on E: ErbwParserError do
          begin
            ed.Color := clRed;
            Beep;
            MessageDlg(Format(StrErrorInFormulaS, [E.Message]),
              mtError, [mbOK], 0);
            Exit;
          end
        end;

        CompiledFormula := Compiler.CurrentExpression;
        // check that the formula is OK.
        if not (CompiledFormula.ResultType in [rdtDouble, rdtInteger]) then
        begin
          ed.Color := clRed;
          Beep;
          MessageDlg(StrErrorTheFormulaI, mtError, [mbOK], 0);
          Exit;
        end
        else
        begin
          FunctionString := CompiledFormula.DecompileDisplay;
          if FunctionString <> ed.Text then
          begin
            ed.Text := FunctionString;
            if Assigned(ed.OnChange) then
            begin
              ed.OnChange(ed);
            end;
          end;
        end
      finally
        VariableList.Free;
      end;
    end;
    if CompiledFormula <> nil then
    begin
      if ed = edZ then
      begin
        FZFormula := CompiledFormula;
      end
      else if ed = edHighZ then
      begin
        FHighZFormula := CompiledFormula;
      end
      else if ed = edLowZ then
      begin
        FLowZFormula := CompiledFormula;
      end
      else if (ed = edLeakyHydraulicConductivity) or (ed = edLeakyThickness)
        or (ed = edRiverHydraulicConductivity) or (ed = edRiverWidth)
        or (ed = edRiverDepth) or (ed = edRiverBedThickness) then
      begin
        // do nothing
      end
      else
      begin
        Assert(False);
      end;
    end;

  finally
    EnableOK_Button;
  end;
end;

Type
  TCustomEditCrack = class(TCustomEdit);

procedure TfrmScreenObjectProperties.btnFormulaClick(Sender: TObject);
var
  FunctionString: string;
  ed: TCustomEdit;
  VariableList: TList;
  VarIndex, Index: integer;
  Variable: TCustomValue;
  Compiler: TRbwParser;
  CompiledFormula: TExpression;
  AScreenObject: TScreenObject;
  ScreenObjectIndex: integer;
  AVar: TCustomValue;
  DataSetIndex: Integer;
  DataArray: TDataArray;
  UsedDataSets: TStringList;
  Edit: TScreenObjectDataEdit;
  UsedIndex: Integer;
  UsedArray: TDataArray;
  DataArrayManager: TDataArrayManager;
  DataSetPostion: Integer;
  ADataArray: TDataArray;
  SwrReaches: TSwrReachBoundary;
  FootprintWell: TFootprintWell;
begin
{ TODO : See if some of this can be combined with ValidateEdFormula. }

  inherited;
  // edit the formula that is not part of a data set or boundary data set.
  DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
  ed := nil;
  if Sender = btnZ then
  begin
    ed := edZ;
    FZFormula := nil;
  end
  else if Sender = btnHighZ then
  begin
    ed := edHighZ;
    FHighZFormula := nil;
  end
  else if Sender = btnLowZ then
  begin
    ed := edLowZ;
    FLowZFormula := nil;
  end
  else if Sender = btnLeakyHydraulicConductivity then
  begin
    ed := edLeakyHydraulicConductivity;
  end
  else if Sender = btnLeakyThickness then
  begin
    ed := edLeakyThickness;
  end
  else if Sender = btnRiverHydraulicConductivity then
  begin
    ed := edRiverHydraulicConductivity;
  end
  else if Sender = btnRiverWidth then
  begin
    ed := edRiverWidth;
  end
  else if Sender = btnRiverDepth then
  begin
    ed := edRiverDepth;
  end
  else if Sender = btnRiverBedThickness then
  begin
    ed := edRiverBedThickness;
  end
  else if Sender = framePhastInterpolationBoundaries.btnEditMixtureFormula then
  begin
    ed := framePhastInterpolationBoundaries.edMixFormula;
  end
  else if Sender = frameCfpPipes.btnDiameter then
  begin
    ed := frameCfpPipes.edDiameter;
  end
  else if Sender = frameCfpPipes.btnTortuosity then
  begin
    ed := frameCfpPipes.edTortuosity;
  end
  else if Sender = frameCfpPipes.btnRoughnessHeight then
  begin
    ed := frameCfpPipes.edRoughnessHeight;
  end
  else if Sender = frameCfpPipes.btnLowerCriticalR then
  begin
    ed := frameCfpPipes.edLowerCriticalR;
  end
  else if Sender = frameCfpPipes.btnHigherCriticalR then
  begin
    ed := frameCfpPipes.edHigherCriticalR;
  end
  else if Sender = frameCfpPipes.btnConductancePermeability then
  begin
    ed := frameCfpPipes.edConductancePermeability;
  end
  else if Sender = frameCfpPipes.btnElevation then
  begin
    ed := frameCfpPipes.edElevation;
  end
  else if Sender = frameCfpFixedHeads.btnFixedHead then
  begin
    ed := frameCfpFixedHeads.edFixedHead;
  end
  else if Sender = frameSwrReach.btnEditReachLength then
  begin
    ed := frameSwrReach.edReachLength
  end
  else if Sender = frameScreenObjectFootprintWell.btnPumpingRate then
  begin
    ed := frameScreenObjectFootprintWell.edPumpingRate;
  end
  else
  begin
    Assert(False);
  end;
  FunctionString := ed.Text;
  if (FunctionString = '') and (FScreenObject = nil) then
  begin
    if Sender = btnZ then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        if AScreenObject.ElevationCount = ecOne then
        begin
          FunctionString := AScreenObject.ElevationFormula;
          break;
        end;
      end;
    end
    else if Sender = btnHighZ then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        if AScreenObject.ElevationCount = ecTwo then
        begin
          FunctionString := AScreenObject.HigherElevationFormula;
          break;
        end;
      end;
    end
    else if Sender = btnLowZ then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        if AScreenObject.ElevationCount = ecTwo then
        begin
          FunctionString := AScreenObject.LowerElevationFormula;
          break;
        end;
      end;
    end
    else if Sender = btnLeakyHydraulicConductivity then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        if (AScreenObject.LeakyBoundary.BoundaryValue.Count > 0)
          or (AScreenObject.LeakyBoundary.Solution.Count > 0) then
        begin
          FunctionString := AScreenObject.LeakyBoundary.HydraulicConductivity;
          break;
        end;
      end;
    end
    else if Sender = btnLeakyThickness then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        if (AScreenObject.LeakyBoundary.BoundaryValue.Count > 0)
          or (AScreenObject.LeakyBoundary.Solution.Count > 0) then
        begin
          FunctionString := AScreenObject.LeakyBoundary.Thickness;
          break;
        end;
      end;
    end
    else if Sender = btnRiverHydraulicConductivity then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        if (AScreenObject.RiverBoundary.BoundaryValue.Count > 0)
          or (AScreenObject.RiverBoundary.Solution.Count > 0) then
        begin
          FunctionString :=
            AScreenObject.RiverBoundary.BedHydraulicConductivity;
          break;
        end;
      end;
    end
    else if Sender = btnRiverWidth then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        if (AScreenObject.RiverBoundary.BoundaryValue.Count > 0)
          or (AScreenObject.RiverBoundary.Solution.Count > 0) then
        begin
          FunctionString := AScreenObject.RiverBoundary.Width;
          break;
        end;
      end;
    end
    else if Sender = btnRiverDepth then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        if (AScreenObject.RiverBoundary.BoundaryValue.Count > 0)
          or (AScreenObject.RiverBoundary.Solution.Count > 0) then
        begin
          FunctionString := AScreenObject.RiverBoundary.Depth;
          break;
        end;
      end;
    end
    else if Sender = btnRiverBedThickness then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        if (AScreenObject.RiverBoundary.BoundaryValue.Count > 0)
          or (AScreenObject.RiverBoundary.Solution.Count > 0) then
        begin
          FunctionString := AScreenObject.RiverBoundary.BedThickness;
          break;
        end;
      end;
    end
    else if Sender = framePhastInterpolationBoundaries.btnEditMixtureFormula
      then
    begin
      FunctionString := framePhastInterpolationBoundaries.edMixFormula.Text;
    end
    else if Sender = frameCfpPipes.btnDiameter then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        ADataArray := DataArrayManager.GetDataSetByName(KPipeDiameter);
        DataSetPostion := AScreenObject.IndexOfDataSet(ADataArray);

        if (DataSetPostion >= 0) then
        begin
          FunctionString := AScreenObject.DataSetFormulas[DataSetPostion];
          break;
        end;
      end;
    end
    else if Sender = frameCfpPipes.btnTortuosity then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        ADataArray := DataArrayManager.GetDataSetByName(KTortuosity);
        DataSetPostion := AScreenObject.IndexOfDataSet(ADataArray);
        if (DataSetPostion >= 0) then
        begin
          FunctionString := AScreenObject.DataSetFormulas[DataSetPostion];
          break;
        end;
      end;
    end
    else if Sender = frameCfpPipes.btnRoughnessHeight then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        ADataArray := DataArrayManager.GetDataSetByName(KRoughnessHeight);
        DataSetPostion := AScreenObject.IndexOfDataSet(ADataArray);
        if (DataSetPostion >= 0) then
        begin
          FunctionString := AScreenObject.DataSetFormulas[DataSetPostion];
          break;
        end;
      end;
    end
    else if Sender = frameCfpPipes.btnLowerCriticalR then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        ADataArray := DataArrayManager.GetDataSetByName(KLowerCriticalR);
        DataSetPostion := AScreenObject.IndexOfDataSet(ADataArray);
        if (DataSetPostion >= 0) then
        begin
          FunctionString := AScreenObject.DataSetFormulas[DataSetPostion];
          break;
        end;
      end;
    end
    else if Sender = frameCfpPipes.btnHigherCriticalR then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        ADataArray := DataArrayManager.GetDataSetByName(KUpperCriticalR);
        DataSetPostion := AScreenObject.IndexOfDataSet(ADataArray);
        if (DataSetPostion >= 0) then
        begin
          FunctionString := AScreenObject.DataSetFormulas[DataSetPostion];
          break;
        end;
      end;
    end
    else if Sender = frameCfpPipes.btnConductancePermeability then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        ADataArray := DataArrayManager.GetDataSetByName(KPipeConductanceOrPer);
        DataSetPostion := AScreenObject.IndexOfDataSet(ADataArray);
        if (DataSetPostion >= 0) then
        begin
          FunctionString := AScreenObject.DataSetFormulas[DataSetPostion];
          break;
        end;
      end;
    end
    else if Sender = frameCfpPipes.btnElevation then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        ADataArray := DataArrayManager.GetDataSetByName(KCfpNodeElevation);
        DataSetPostion := AScreenObject.IndexOfDataSet(ADataArray);
        if (DataSetPostion >= 0) then
        begin
          FunctionString := AScreenObject.DataSetFormulas[DataSetPostion];
          break;
        end;
      end;
    end
    else if Sender = frameCfpFixedHeads.btnFixedHead then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        ADataArray := DataArrayManager.GetDataSetByName(KCfpFixedHeads);
        DataSetPostion := AScreenObject.IndexOfDataSet(ADataArray);
        if (DataSetPostion >= 0) then
        begin
          FunctionString := AScreenObject.DataSetFormulas[DataSetPostion];
          break;
        end;
      end;
    end
    else if Sender = frameSwrReach.btnEditReachLength then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        SwrReaches := AScreenObject.ModflowSwrReaches;
        if SwrReaches <> nil then
        begin
          FunctionString := SwrReaches.ReachLengthFormula;
          break;
        end;
      end;
    end
    else if Sender = frameScreenObjectFootprintWell.btnPumpingRate then
    begin
      for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[ScreenObjectIndex];
        FootprintWell := AScreenObject.FootprintWell;
        if FootprintWell <> nil then
        begin
          FunctionString := FootprintWell.Withdrawal;
          break;
        end;
      end;
    end
    else
    begin
      Assert(False);
    end;
  end;

  if (Sender = btnZ) or (Sender = btnHighZ) or (Sender = btnLowZ) then
  begin
    Compiler := GetElevationCompiler;
  end
  else if (ed = frameCfpPipes.edDiameter)
    or (ed = frameCfpPipes.edTortuosity)
    or (ed = frameCfpPipes.edRoughnessHeight)
    or (ed = frameCfpPipes.edLowerCriticalR)
    or (ed = frameCfpPipes.edHigherCriticalR)
    or (ed = frameCfpPipes.edConductancePermeability)
    or (ed = frameCfpPipes.edElevation)
    or (ed = frameCfpFixedHeads.edFixedHead)
    or (ed = frameSwrReach.edReachLength)
    then
  begin
    Compiler := GetCompiler(dso3D, eaBlocks);
  end
  else if Sender = frameScreenObjectFootprintWell.btnPumpingRate then
  begin
    Compiler := GetCompiler(dsoTop, eaBlocks);
  end
  else
  begin
    Compiler := GetCompiler(dso3D, eaNodes);
  end;

  if Compiler = nil then
  begin
    Beep;
    MessageDlg(StrYouMustSpecifyNod, mtInformation, [mbOK], 0);
    Exit;
  end;

  VariableList := TList.Create;
  try
    UsedDataSets := TStringList.Create;
    try
      UsedDataSets.CaseSensitive  := False;
      UsedDataSets.Duplicates := dupIgnore;
      UsedDataSets.Sorted := True;
      if FScreenObject = nil then
      begin
        for ScreenObjectIndex := 0 to FScreenObjectList.Count - 1 do
        begin
          AScreenObject := FScreenObjectList[ScreenObjectIndex];
          for DataSetIndex := 0 to AScreenObject.DataSetCount - 1 do
          begin
            DataArray := AScreenObject.DataSets[DataSetIndex];
            UsedDataSets.AddObject(DataArray.Name, DataArray);
          end;
        end;
      end
      else
      begin
        for DataSetIndex := 0 to FScreenObject.DataSetCount - 1 do
        begin
          DataArray := FScreenObject.DataSets[DataSetIndex];
          UsedDataSets.AddObject(DataArray.Name, DataArray);
        end;
      end;

      for Index := 0 to FDataEdits.Count - 1 do
      begin
        Edit := FDataEdits[Index];
        if Edit.Used <> cbUnChecked then
        begin
          UsedDataSets.AddObject(Edit.DataArray.Name, Edit.DataArray);
        end;
      end;

//      DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
      for Index := 0 to DataArrayManager.DataSetCount - 1 do
      begin
        DataArray := DataArrayManager.DataSets[Index];
        if UsedDataSets.IndexOf(DataArray.Name) < 0 then
        begin
          for UsedIndex := 0 to UsedDataSets.Count - 1 do
          begin
            UsedArray := UsedDataSets.Objects[UsedIndex] as TDataArray;
            if DataArray.IsListeningTo(UsedArray) then
            begin
              UsedDataSets.AddObject(DataArray.Name, DataArray);
              break;
            end;
          end;
        end;
      end;

      for VarIndex := 0 to Compiler.VariableCount - 1 do
      begin
        AVar := Compiler.Variables[VarIndex];
        if (frmGoPhast.PhastModel.GlobalVariables.
          IndexOfVariable(AVar.Name) < 0)
          and (UsedDataSets.IndexOf(AVar.Name) < 0) then
        begin
          VariableList.Add(Compiler.Variables[VarIndex]);
        end;
      end;
    finally
      UsedDataSets.Free;
    end;

    with TfrmFormula.Create(nil) do
    begin
      try
        IncludeGIS_Functions(TEvaluatedAt(rgEvaluatedAt.ItemIndex));
        RemoveGetVCont;
        RemoveHufFunctions;
        PopupParent := self;

        for Index := 0 to VariableList.Count - 1 do
        begin
          Variable := VariableList[Index];
          rbFormulaParser.RegisterVariable(Variable);
        end;

        UpdateTreeList;
        Formula := FunctionString;

        ShowModal;
        if ResultSet then
        begin
          FunctionString := Formula;
        end
        else
        begin
          if FunctionString = '' then
            FunctionString := '0';
        end;
      finally
        Free;
      end;
    end;

    try
      Compiler.Compile(FunctionString);
    except on E: ErbwParserError do
      begin
        Beep;
        MessageDlg(Format(StrErrorInFormulaS, [E.Message]), mtError, [mbOK], 0);
        Exit;
      end
    end;

    CompiledFormula := Compiler.CurrentExpression;
    // check that the formula is OK.
    if not (CompiledFormula.ResultType in [rdtDouble, rdtInteger]) then
    begin
      TCustomEditCrack(ed).Color := clRed;
      Beep;
      MessageDlg(StrErrorTheFormulaI, mtError, [mbOK], 0);
      Exit;
    end
    else
    begin
      TCustomEditCrack(ed).Color := clWindow;
      FunctionString := CompiledFormula.DecompileDisplay;
      if FunctionString <> ed.Text then
      begin
        ed.Text := FunctionString;
        if Assigned(TCustomEditCrack(ed).OnChange) then
        begin
          TCustomEditCrack(ed).OnChange(ed);
        end;
        if Assigned(TCustomEditCrack(ed).OnExit) then
        begin
          TCustomEditCrack(ed).OnExit(ed);
        end;
      end;
    end
  finally
    VariableList.Free;
  end;
  if ed = edZ then
  begin
    FZFormula := CompiledFormula;
  end
  else if ed = edHighZ then
  begin
    FHighZFormula := CompiledFormula;
  end
  else if ed = edLowZ then
  begin
    FLowZFormula := CompiledFormula;
  end
  else if (ed = edLeakyHydraulicConductivity)
    or (ed = edLeakyThickness) or (ed = edRiverHydraulicConductivity)
    or (ed = edRiverWidth) or (ed = edRiverDepth)
    or (ed = edRiverBedThickness)
    or (ed = framePhastInterpolationBoundaries.edMixFormula)
    or (ed = frameCfpPipes.edDiameter)
    or (ed = frameCfpPipes.edTortuosity)
    or (ed = frameCfpPipes.edRoughnessHeight)
    or (ed = frameCfpPipes.edLowerCriticalR)
    or (ed = frameCfpPipes.edHigherCriticalR)
    or (ed = frameCfpPipes.edConductancePermeability)
    or (ed = frameCfpPipes.edElevation)
    or (ed = frameCfpFixedHeads.edFixedHead)
    or (ed = frameSwrReach.edReachLength)
    or (ed = frameScreenObjectFootprintWell.edPumpingRate)
    then
  begin
    // do nothing
  end
  else
  begin
    Assert(False);
  end;
  EnableOK_Button;
end;

procedure TfrmScreenObjectProperties.edHighZExit(Sender: TObject);
var
  NewFormula: string;
  Index: Integer;
  Item: TScreenObjectEditItem;
  List: TList;
begin
  inherited;
  if FFillingDataSetTreeView then Exit;
  if FScreenObject <> nil then
  begin
    List := TList.Create;
    try
      List.Add(FScreenObject);
      FillDataSetsTreeView(List);
    finally
      List.Free;
    end;
  end
  else
  begin
    FillDataSetsTreeView(FScreenObjectList);
  end;

  ValidateEdFormula(edHighZ);
  if IsLoaded and (FHighZFormula <> nil) then
  begin
    NewFormula := edHighZ.Text;
    if NewFormula <> '' then
    begin
      if FScreenObject <> nil then
      begin
        FScreenObject.HigherElevationFormula := NewFormula;
      end;
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.HigherElevationFormula := NewFormula;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.edLowZExit(Sender: TObject);
var
  NewFormula: string;
  Index: Integer;
  Item: TScreenObjectEditItem;
  List: TList;
begin
  inherited;
  if FFillingDataSetTreeView then Exit;
  if FScreenObject <> nil then
  begin
    List := TList.Create;
    try
      List.Add(FScreenObject);
      FillDataSetsTreeView(List);
    finally
      List.Free;
    end;
  end
  else
  begin
    FillDataSetsTreeView(FScreenObjectList);
  end;

  ValidateEdFormula(edLowZ);
  if IsLoaded and (FLowZFormula <> nil) then
  begin
    NewFormula := edLowZ.Text;
    if NewFormula <> '' then
    begin
      if FScreenObject <> nil then
      begin
        FScreenObject.LowerElevationFormula := NewFormula;
      end;
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.LowerElevationFormula := NewFormula;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.cbInterpolationClick(Sender: TObject);
var
  Index: integer;
  Item: TScreenObjectEditItem;
begin
  inherited;

  InvalidateAllDataSets;

  ShowOrHideTabs;
  EmphasizeValueChoices;
  if IsLoaded then
  begin
    DisableAllowGrayed(cbInterpolation);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.SetValuesByInterpolation := cbInterpolation.Checked;
    end;
  end;
end;


procedure TfrmScreenObjectProperties.edZExit(Sender: TObject);
var
  Index: Integer;
  Item: TScreenObjectEditItem;
  NewFormula: string;
  List: TList;
begin
  inherited;
  if FFillingDataSetTreeView then Exit;
  if FScreenObject <> nil then
  begin
    List := TList.Create;
    try
      List.Add(FScreenObject);
      FillDataSetsTreeView(List);
    finally
      List.Free;
    end;
  end
  else
  begin
    FillDataSetsTreeView(FScreenObjectList);
  end;

  ValidateEdFormula(Sender as TEdit);
  if IsLoaded and (FZFormula <> nil) then
  begin
    NewFormula := edZ.Text;
    if NewFormula <> '' then
    begin
      if FScreenObject <> nil then
      begin
        FScreenObject.ElevationFormula := NewFormula;
      end;
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.ElevationFormula := NewFormula;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.rdeDrtLocationControlExit(Sender: TObject);
begin
  inherited;
  UpdateNodeState(FDRT_Node);
  StoreDrtBoundary;
end;

procedure TfrmScreenObjectProperties.rdeGridCellSizeExit(Sender: TObject);
var
  Index: Integer;
  Item: TScreenObjectEditItem;
  NewCellSize: Extended;
begin
  inherited;
  if IsLoaded then
  begin
    if TryStrToFloat(rdeGridCellSize.Text, NewCellSize) then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.CellSize := NewCellSize;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.rdeMinimumCellFractionChange(
  Sender: TObject);
var
  Fraction: Extended;
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  inherited;
  if IsLoaded then
  begin
    if rdeMinimumCellFraction.Text <> '' then
    begin
      Fraction := rdeMinimumCellFraction.RealValue;
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.MinimumFraction := Fraction;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.rdgImportedDataSetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
var
  ValueStorage: TValueArrayStorage;
  IntValue: Integer;
  FloatValue: double;
begin
  inherited;
  if IsLoaded and (ARow < rdgImportedData.RowCount) then
  begin
    ValueStorage := rdgImportedData.Objects[ACol, 0] as TValueArrayStorage;
    Assert(ValueStorage <> nil);
    case rdgImportedData.Columns[ACol].Format of
      rcf4String:
        begin
          ValueStorage.StringValues[ARow-1] :=
            rdgImportedData.Cells[ACol, ARow];
        end;
      rcf4Integer:
        begin
          if TryStrToInt(rdgImportedData.Cells[ACol, ARow], IntValue) then
          begin
            ValueStorage.IntValues[ARow-1] := IntValue;
          end;
        end;
      rcf4Real:
        begin
          if TryStrToFloat(rdgImportedData.Cells[ACol, ARow], FloatValue) then
          begin
            ValueStorage.RealValues[ARow-1] := FloatValue;
          end;
        end;
      rcf4Boolean:
        begin
          ValueStorage.BooleanValues[ARow-1] :=
            rdgImportedData.Checked[ACol, ARow];
        end;
      else Assert(False);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.reDataSetFormulaChange(Sender: TObject);
begin
  inherited;
  if FFormulaEdit = FCurrentEdit then
  begin
    ValidateDataSetFormula(False);
  end;
end;

procedure TfrmScreenObjectProperties.reDataSetFormulaEnter(Sender: TObject);
begin
  inherited;
  FFormulaEdit := FCurrentEdit;
end;

procedure TfrmScreenObjectProperties.reDataSetFormulaExit(Sender: TObject);
begin
  inherited;
  if FFormulaEdit = FCurrentEdit then
  begin
    ValidateDataSetFormula;
  end;
end;

procedure TfrmScreenObjectProperties.rgElevationCountClick(Sender: TObject);
var
  RowIndex: integer;
  DataSet: TDataArray;
  Index: integer;
  AScreenObject: TScreenObject;
  Item: TScreenObjectEditItem;
  NewElevationCount: TElevationCount;
  List: TList;
  Edit: TScreenObjectDataEdit;
  DsIndex: Integer;
  ShowWarning: Boolean;
  UsedDataSets: TStringList;
  TempFormula: string;
  LocalCompiler: TRbwParser;
  DataArray: TDataArray;
  AnotherDataArray: TDataArray;
  DataEdit: TScreenObjectDataEdit;
  DataArrayManager: TDataArrayManager;
begin
  inherited;
  if FFillingDataSetTreeView then Exit;
  if FScreenObject <> nil then
  begin
    List := TList.Create;
    try
      List.Add(FScreenObject);
      FillDataSetsTreeView(List);
    finally
      List.Free;
    end;
  end
  else
  begin
    FillDataSetsTreeView(FScreenObjectList);
  end;

  if rgElevationCount.ItemIndex = Ord(ecTwo) then
  begin
    if FScreenObject = nil then
    begin
      for Index := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[Index];
        if AScreenObject.Count > 1 then
        begin
          cbFillColor.Enabled := True;
          break;
        end
      end;
    end
    else
    begin
      cbFillColor.Enabled := FScreenObject.Count > 1;
    end;
  end
  else
  begin
    if FScreenObject = nil then
    begin
      for Index := 0 to FScreenObjectList.Count - 1 do
      begin
        AScreenObject := FScreenObjectList[Index];
        if AScreenObject.Closed then
        begin
          cbFillColor.Enabled := True;
          break;
        end
      end;
    end
    else
    begin
      cbFillColor.Enabled := FScreenObject.Closed;
    end;
  end;
  if not cbFillColor.Enabled then
    cbFillColor.Checked := False;

  if rgElevationCount.ItemIndex >=0 then
  begin
    edZ.Enabled := (rgElevationCount.ItemIndex = 1);
    btnZ.Enabled := edZ.Enabled;
    lblZ.Enabled := edZ.Enabled;
    edHighZ.Enabled := (rgElevationCount.ItemIndex = 2);
    btnHighZ.Enabled := edHighZ.Enabled;
    lblHighZ.Enabled := edHighZ.Enabled;
    edLowZ.Enabled := edHighZ.Enabled;
    btnLowZ.Enabled := edHighZ.Enabled;
    lblLowZ.Enabled := edHighZ.Enabled;
  end;


  case rgElevationCount.ItemIndex of
    0:
      begin
        for RowIndex := 0 to FDataEdits.Count - 1 do
        begin
          Edit := FDataEdits[RowIndex];
          DataSet := Edit.DataArray;
          if (DataSet.Orientation = dso3D)
            and (Edit.Used <> cbUnchecked) then
          begin
            Edit.Used := cbUnchecked;
            break;
          end;
        end;
      end;
    1:
      begin
        FFilledDataSetTreeView := True;
        try
          edZExit(edZ);
        finally
          FFilledDataSetTreeView := False;
        end;
      end;
    2:
      begin
        FFilledDataSetTreeView := True;
        try
          edHighZExit(edHighZ);
          edLowZExit(edLowZ);
        finally
          FFilledDataSetTreeView := False;
        end;
      end;
    else
    begin
      if edHighZ.Enabled then
      begin
        edZExit(edZ);
      end;
      if edHighZ.Enabled then
      begin
        edHighZExit(edHighZ);
        edLowZExit(edLowZ);
      end;
    end;
  end;
  if FScreenObject <> nil then
  begin
    clbChildModels.Enabled := CanSpecifyChildModels(FScreenObject);
  end
  else
  begin
    Assert(FScreenObjectList <> nil);
    if FScreenObjectList.Count = 1 then
    begin
      AScreenObject := FScreenObjectList[0];
      clbChildModels.Enabled := CanSpecifyChildModels(AScreenObject);
    end
    else
    begin
      clbChildModels.Enabled := False;
    end;
  end;
  if clbChildModels.Enabled then
  begin
    clbChildModels.Color := clWindow;
  end
  else
  begin
    clbChildModels.Color := clBtnFace;
  end;
  if IsLoaded and (rgElevationCount.ItemIndex >= 0) then
  begin
    ShowWarning := False;
    NewElevationCount:= TElevationCount(rgElevationCount.ItemIndex);

    UsedDataSets := TStringList.Create;
    try
      UsedDataSets.Sorted := True;
      UsedDataSets.Duplicates := dupIgnore;
      LocalCompiler := GetElevationCompiler;
      case rgElevationCount.ItemIndex of
        0: ;  // do nothing
        1:
          begin
            TempFormula := edZ.Text;
            if TempFormula <> '' then
            begin
              try
                LocalCompiler.Compile(TempFormula);
                UsedDataSets.AddStrings(LocalCompiler.CurrentExpression.VariablesUsed);
              except on ERbwParserError do
                begin
                  // do nothing
                end;
              end;
            end;
          end;
        2:
          begin
            TempFormula := edHighZ.Text;
            if TempFormula <> '' then
            begin
              try
                LocalCompiler.Compile(TempFormula);
                UsedDataSets.AddStrings(LocalCompiler.CurrentExpression.VariablesUsed);
              except on ERbwParserError do
                begin
                  // do nothing
                end;
              end;
            end;
            TempFormula := edLowZ.Text;
            if TempFormula <> '' then
            begin
              try
                LocalCompiler.Compile(TempFormula);
                UsedDataSets.AddStrings(LocalCompiler.CurrentExpression.VariablesUsed);
              except on ERbwParserError do
                begin
                  // do nothing
                end;
              end;
            end;
          end;
      end;
      for Index := 0 to UsedDataSets.Count - 1 do
      begin
        DataArray := frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(UsedDataSets[Index]);
        UsedDataSets.Objects[Index] := DataArray;
      end;
      Index := 0;
      UsedDataSets.Sorted := False;
      DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
      while Index < UsedDataSets.Count do
      begin
        DataArray := UsedDataSets.Objects[Index] as TDataArray;
        for DSIndex := 0 to DataArrayManager.DataSetCount - 1 do
        begin
          AnotherDataArray := DataArrayManager.DataSets[DSIndex];
          if UsedDataSets.IndexOfObject(AnotherDataArray) < 0 then
          begin
            if DataArray.IsListeningTo(AnotherDataArray) then
            begin
              UsedDataSets.AddObject(AnotherDataArray.Name, AnotherDataArray);
            end;
          end;
        end;
        Inc(Index);
      end;
      for Index := 0 to FDataEdits.Count - 1 do
      begin
        DataEdit := FDataEdits[Index];
        if UsedDataSets.IndexOfObject(DataEdit.DataArray) >= 0 then
        begin
          DataEdit.Used := cbUnchecked;
          ShowWarning := True;
        end;
      end;
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties.Items[Index];
        Item.ScreenObject.ElevationCount := NewElevationCount;
      end;
    finally
      UsedDataSets.Free;
    end;
    if ShowWarning then
    begin
      Beep;
      if FNewProperties.Count = 1 then
      begin
        MessageDlg(StrThisObjectWillNo, mtWarning, [mbOK], 0);
      end
      else
      begin
        MessageDlg(StrTheseObjectsWillN, mtWarning, [mbOK], 0);
      end;

    end;
    case rgElevationCount.ItemIndex of
      0:
        begin
        end;
      1:
        begin
          edZExit(edZ);
        end;
      2:
        begin
          edHighZExit(edHighZ);
          edLowZExit(edLowZ);
        end;
      else
      begin
        if edHighZ.Enabled then
        begin
          edZExit(edZ);
        end;
        if edHighZ.Enabled then
        begin
          edHighZExit(edHighZ);
          edLowZExit(edLowZ);
        end;
      end;
    end;
  end;

  if (rgElevationCount.ItemIndex > 0)
    and (clbChildModels.CheckedIndex > 0) then
  begin
    clbChildModels.CheckedIndex := 0;
    clbChildModelsClickCheck(clbChildModels);
  end;

  FPriorElevationCount := rgElevationCount.ItemIndex;
  CreateSutraFeatureNodes;
  SetSelectedSutraBoundaryNode;

  if rgElevationCount.ItemIndex > 0 then
  begin
    cbInterpolation.Enabled := False;
    if cbInterpolation.Checked then
    begin
      cbInterpolation.Checked := False;
      cbInterpolationClick(nil);
    end;
  end
  else
  begin
    cbInterpolation.Enabled := True;
  end;

end;

procedure TfrmScreenObjectProperties.cbSetGridCellSizeClick(Sender: TObject);
var
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  inherited;
  rdeGridCellSize.Enabled := cbSetGridCellSize.Checked;
  lblGridCellSize.Enabled := cbSetGridCellSize.Checked;
  EmphasizeValueChoices;
  if IsLoaded then
  begin
    DisableAllowGrayed(cbSetGridCellSize);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CellSizeUsed := cbSetGridCellSize.Checked;
    end;
    if cbSetGridCellSize.Checked then
    begin
      rdeGridCellSizeExit(nil);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.cbUzfGage1Click(Sender: TObject);
begin
  inherited;
  UpdateNodeState(FUZF_Node);
  cbUzfGage2.Enabled := cbUzfGage1.Checked;
  cbUzfGage1.AllowGrayed := False;
  StoreUzfBoundary
end;

procedure TfrmScreenObjectProperties.cbUzfGage2Click(Sender: TObject);
begin
  inherited;
  UpdateNodeState(FUZF_Node);
  cbUzfGage2.AllowGrayed := False;
  StoreUzfBoundary
end;

procedure TfrmScreenObjectProperties.cbUzfGage3Click(Sender: TObject);
begin
  inherited;
  UpdateNodeState(FUZF_Node);
  cbUzfGage3.AllowGrayed := False;
  StoreUzfBoundary
end;

procedure TfrmScreenObjectProperties.cbVertexLabelVisibleClick(Sender: TObject);
begin
  inherited;
  cbVertexLabelVisible.AllowGrayed := False;
end;

procedure TfrmScreenObjectProperties.SetCheckBoxCaptions;
var
  NodeElemString: string;
begin
  if rgEvaluatedAt.ItemIndex >= 0 then
  begin
    NodeElemString := EvalAtToString(TEvaluatedAt(rgEvaluatedAt.ItemIndex),
         frmGoPhast.ModelSelection, True, False);
  end
  else
  begin
    NodeElemString := 'node or element';
  end;
  cbEnclosedCells.Caption := rsSetValueOfEnclosed + NodeElemString;
  cbIntersectedCells.Caption := rsSetValueOfIntersected + NodeElemString;
  cbInterpolation.Caption := rsSetValueOf + NodeElemString + rsByInterpolation;
  cbDuplicatesAllowed.Caption := Format(StrDuplicateSAllowed, [NodeElemString]);
  case frmGoPhast.ModelSelection of
    msUndefined, msPhast:
      begin
        cbSetGridCellSize.Caption := StrUseToSetGridElem;
        lblGridCellSize.Caption := StrGridElementSize;
      end;
    msModflow, msModflowLGR, msModflowLGR2, msModflowNWT,
      msModflowFmp, msModflowCfp, msFootPrint, msModflow2015:
      begin
        cbSetGridCellSize.Caption := StrUseToSetGridCell;
        lblGridCellSize.Caption := StrGridCellSize;
      end;
    msSutra22, msSutra30:
      begin
        cbSetGridCellSize.Caption := StrUseToSetMeshElem;
        lblGridCellSize.Caption := StrMeshElementSize;
      end;
    else Assert(False);
  end;
end;

procedure TfrmScreenObjectProperties.rgEvaluatedAtClick(Sender: TObject);
var
  Item: TScreenObjectEditItem;
  NewEvaluatedAt: TEvaluatedAt;
  ItemIndex, RowIndex: Integer;
  DataArray: TDataArray;
  List: TList;
  Edit: TScreenObjectDataEdit;
begin
  inherited;
  if FFillingDataSetTreeView then Exit;
  if FScreenObject <> nil then
  begin
    List := TList.Create;
    try
      List.Add(FScreenObject);
      FillDataSetsTreeView(List);
    finally
      List.Free;
    end;
  end
  else
  begin
    FillDataSetsTreeView(FScreenObjectList);
  end;

  SetCheckBoxCaptions;

  if edZ.Enabled then
  begin
    edZ.OnExit(edZ);
  end;
  if edHighZ.Enabled then
  begin
    edHighZ.OnExit(edHighZ);
  end;
  if edLowZ.Enabled then
  begin
    edLowZ.OnExit(edLowZ);
  end;

  if IsLoaded and (rgEvaluatedAt.ItemIndex >= 0) then
  begin
    NewEvaluatedAt := TEvaluatedAt(rgEvaluatedAt.ItemIndex);
    if (NewEvaluatedAt = eaBlocks) then
    begin
      pcPhastBoundaries.ActivePageIndex := Ord(btNone);
    end
    else
    begin
      rgBoundaryTypeClick(nil);
    end;
    for RowIndex := 0 to FDataEdits.Count - 1 do
    begin
      Edit := FDataEdits[RowIndex];
      DataArray := Edit.DataArray;
      if DataArray.EvaluatedAt <> NewEvaluatedAt then
      begin
        Edit.Used := cbUnchecked;
      end;
      if Edit.Used <> cbUnchecked then
      begin
        if Edit.Expression = nil then
        begin
          CreateFormula(RowIndex, Edit.Formula);
        end;
      end;
    end;
    for ItemIndex := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[ItemIndex];
      Item.ScreenObject.EvaluatedAt := NewEvaluatedAt;
      if NewEvaluatedAt = eaBlocks then
      begin
        Item.ScreenObject.SpecifiedHeadBoundary.Clear;
        Item.ScreenObject.LeakyBoundary.Clear;
        Item.ScreenObject.RiverBoundary.Clear;
        Item.ScreenObject.WellBoundary.Clear;
        Item.ScreenObject.FluxBoundary.Clear;
      end;
    end;
  end;
  ShowOrHideTabs;
  CreateSutraFeatureNodes;
  SetSelectedSutraBoundaryNode;
end;

procedure TfrmScreenObjectProperties.AssignPhastInterpolation(DataArray: TDataArray);
var
  Index: Integer;
  ScreenItem: TScreenObjectEditItem;
  InterpValues: TInterpValuesCollection;
  Item: TInterpValuesItem;
  NewDistance: Extended;
  NewValue: Extended;
begin
  if IsLoaded and (DataArray is TCustomPhastDataSet) then
  begin
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      ScreenItem := FNewProperties[Index];
      InterpValues := ScreenItem.ScreenObject.InterpValues;
      Item := InterpValues.ItemOfDataSet[DataArray];
      if Item = nil then
      begin
        Item := InterpValues.Add as TInterpValuesItem;
        Item.Values.Assign(DataArray);
      end;
      case framePhastInterpolationData.cbPhastInterpolation.State of
        cbUnchecked: Item.Values.UsePHAST_Interpolation := False;
        cbChecked: Item.Values.UsePHAST_Interpolation := True;
        cbGrayed: ; // do nothing
        else Assert(False);
      end;
      if Item.Values.UsePHAST_Interpolation then
      begin
        if (framePhastInterpolationData.rgInterpolationDirection.ItemIndex >= 0)
          and framePhastInterpolationData.rgInterpolationDirection.Enabled then
        begin
          Item.Values.InterpolationDirection := TInterpolationDirection(
            framePhastInterpolationData.rgInterpolationDirection.ItemIndex);
        end;
        if (framePhastInterpolationData.rdeDistance1.Text <> '') and
          framePhastInterpolationData.rdeDistance1.Enabled and
          TryStrToFloat(framePhastInterpolationData.rdeDistance1.Text,
          NewDistance) then
        begin
          Item.Values.Distance1 := NewDistance;
        end;
        if (framePhastInterpolationData.rdeDistance2.Text <> '') and
          framePhastInterpolationData.rdeDistance2.Enabled and
          TryStrToFloat(framePhastInterpolationData.rdeDistance2.Text,
          NewDistance) then
        begin
          Item.Values.Distance2 := NewDistance;
        end;
        if (framePhastInterpolationData.rdeValue1.Text <> '') and
          framePhastInterpolationData.rdeValue1.Enabled and
          TryStrToFloat(framePhastInterpolationData.rdeValue1.Text,
          NewValue) then
        begin
          Item.Values.RealValue1 := NewValue;
          Item.Values.IntValue1 := Round(NewValue);
        end;
        if (framePhastInterpolationData.rdeValue2.Text <> '') and
          framePhastInterpolationData.rdeValue2.Enabled and
          TryStrToFloat(framePhastInterpolationData.rdeValue2.Text,
          NewValue) then
        begin
          Item.Values.RealValue2 := NewValue;
          Item.Values.IntValue2 := Round(NewValue);
        end;
        if (framePhastInterpolationData.edMixFormula.Text <> '')
          and (Item.Values.InterpolationDirection = pidMix) then
        begin
          Item.Values.MixtureExpression :=
            framePhastInterpolationData.edMixFormula.Text;
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationDatacbPhastInterpolationClick(Sender: TObject);
var
  Index: integer;
  Item: TInterpValuesItem;
  DataSet: TDataArray;
begin
  inherited;
    // respond to the user activating or deactivating PHAST-style interpolation for a
    // data set.
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  framePhastInterpolationData.cbPhastInterpolationClick(Sender);

  if IsLoaded and not FUpdatingCurrentEdit and (FCurrentEdit <> nil) then
  begin
    FCurrentEdit.Invalidate;

    DataSet := FCurrentEdit.DataArray;
    for Index := 0 to FCurrentEdit.InterpValue.Count - 1 do
    begin
      Item := FCurrentEdit.InterpValue.Items[Index] as TInterpValuesItem;
      Item.Values.UsePHAST_Interpolation :=
        framePhastInterpolationData.cbPhastInterpolation.Checked;
    end;

    AssignPhastInterpolation(DataSet);
  end;
end;

procedure TfrmScreenObjectProperties.framePhastInterpolationDatardeDistance1Exit(
  Sender: TObject);
var
  Index: integer;
  Item: TInterpValuesItem;
  DataSet: TDataArray;
begin
  inherited;
    // respond to the user having finished editing the
    // PHAST-Interpolation distance 1
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  if not FUpdatingCurrentEdit and (FCurrentEdit <> nil) then
  begin
    FCurrentEdit.Invalidate;

    DataSet := FCurrentEdit.DataArray;
    for Index := 0 to FCurrentEdit.InterpValue.Count - 1 do
    begin
      Item := FCurrentEdit.InterpValue.Items[Index] as TInterpValuesItem;
      Item.Values.Distance1 :=
        StrToFloat(framePhastInterpolationData.rdeDistance1.Text);
    end;
    AssignPhastInterpolation(DataSet);
  end;
end;

procedure TfrmScreenObjectProperties.framePhastInterpolationDatardeDistance2Exit(
  Sender: TObject);
var
  Index: integer;
  Item: TInterpValuesItem;
  DataSet: TDataArray;
begin
  inherited;
    // respond to the user having finished editing the
    // PHAST-Interpolation distance 2
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  if not FUpdatingCurrentEdit and (FCurrentEdit <> nil) then
  begin
    FCurrentEdit.Invalidate;

    DataSet := FCurrentEdit.DataArray;
    for Index := 0 to FCurrentEdit.InterpValue.Count - 1 do
    begin
      Item := FCurrentEdit.InterpValue.Items[Index] as TInterpValuesItem;
      Item.Values.Distance2 :=
        StrToFloat(framePhastInterpolationData.rdeDistance2.Text);
    end;
    AssignPhastInterpolation(DataSet);
  end;
end;

procedure TfrmScreenObjectProperties.framePhastInterpolationDatardeValue1Exit(
  Sender: TObject);
var
  Index: integer;
  Item: TInterpValuesItem;
  DataSet: TDataArray;
begin
  inherited;
    // respond to the user having finished editing the
    // PHAST-Interpolation value 1
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  if not FUpdatingCurrentEdit and (FCurrentEdit <> nil) then
  begin
    FCurrentEdit.Invalidate;
    DataSet := FCurrentEdit.DataArray;
    for Index := 0 to FCurrentEdit.InterpValue.Count - 1 do
    begin
      Item := FCurrentEdit.InterpValue.Items[Index] as TInterpValuesItem;
      if framePhastInterpolationData.rdeValue1.DataType = dtReal then
      begin
        Item.Values.RealValue1 :=
          StrToFloat(framePhastInterpolationData.rdeValue1.Text);
      end
      else if framePhastInterpolationData.rdeValue1.DataType = dtInteger then
      begin
        Item.Values.IntValue1 :=
          StrToInt(framePhastInterpolationData.rdeValue1.Text);
      end
      else
      begin
        Assert(False);
      end;
    end;
    AssignPhastInterpolation(DataSet);
  end;
end;

procedure TfrmScreenObjectProperties.framePhastInterpolationDatardeValue2Exit(
  Sender: TObject);
var
  Index: integer;
  Item: TInterpValuesItem;
  DataSet: TDataArray;
begin
  inherited;
    // respond to the user having finished editing the
    // PHAST-Interpolation value 2
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  if not FUpdatingCurrentEdit and (FCurrentEdit <> nil) then
  begin
    FCurrentEdit.Invalidate;

    DataSet := FCurrentEdit.DataArray;
    for Index := 0 to FCurrentEdit.InterpValue.Count - 1 do
    begin
      Item := FCurrentEdit.InterpValue.Items[Index] as TInterpValuesItem;
      if framePhastInterpolationData.rdeValue2.DataType = dtReal then
      begin
        Item.Values.RealValue2 :=
          StrToFloat(framePhastInterpolationData.rdeValue2.Text);
      end
      else if framePhastInterpolationData.rdeValue2.DataType = dtInteger then
      begin
        Item.Values.IntValue2 :=
          StrToInt(framePhastInterpolationData.rdeValue2.Text);
      end
      else
      begin
        Assert(False);
      end;
    end;
    AssignPhastInterpolation(DataSet);
  end;
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationDatargInterpolationDirectionClick(Sender: TObject);
var
  Index: integer;
  Item: TInterpValuesItem;
  DataSet: TDataArray;
begin
  inherited;
    // respond to the user editing the PHAST-Interpolation
    // interpolation direction
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  framePhastInterpolationData.rgInterpolationDirectionClick(Sender);
  if not FUpdatingCurrentEdit and (FCurrentEdit <> nil) then
  begin
    FCurrentEdit.Invalidate;
    DataSet := FCurrentEdit.DataArray;
    for Index := 0 to FCurrentEdit.InterpValue.Count - 1 do
    begin
      Item := FCurrentEdit.InterpValue.Items[Index] as TInterpValuesItem;
      Item.Values.InterpolationDirection
        := TInterpolationDirection(framePhastInterpolationData.
        rgInterpolationDirection.ItemIndex);
    end;
    AssignPhastInterpolation(DataSet);
  end;
end;

procedure TfrmScreenObjectProperties.frameRchParamclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateNodeState(FRCH_Node);
  frameRchParam.clbParametersStateChange(Sender, Index);
  StoreRchBoundary;
end;

procedure TfrmScreenObjectProperties.frameRchParamcomboFormulaInterpChange(
  Sender: TObject);
begin
  inherited;
  UpdateNodeState(FRCH_Node);
  StoreRchBoundary;
end;

procedure TfrmScreenObjectProperties.frameRchParamdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreRchBoundary;
end;

procedure TfrmScreenObjectProperties.frameRchParamdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateNodeState(FRCH_Node);
  frameRchParam.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateRchBoundary;
    StartParamCol := Item.ScreenObject.ModflowRchBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameRchParam, StartParamCol, ACol, ARow,Value);
  end;

  if not frameRchParam.dgModflowBoundary.DistributingText then
  begin
    StoreRchBoundary;  
  end;
end;

procedure TfrmScreenObjectProperties.frameRchParamseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameRchParam.seNumberOfTimesChange(Sender);
  StoreRchBoundary;
end;

procedure TfrmScreenObjectProperties.frameResdgModflowBoundaryButtonClick(
  Sender: TObject; ACol, ARow: Integer);
var
  Orientation: TDataSetOrientation;
  DataGrid: TRbwDataGrid4;
  EvaluatedAt: TEvaluatedAt;
  NewValue: string;
begin
  inherited;
  DataGrid := Sender as TRbwDataGrid4;
  // Lakes and reservoirs can only be specified from the top.
  Orientation := dsoTop;
  // All the MODFLOW boundary conditions are evaluated at blocks.
  EvaluatedAt := eaBlocks;

  NewValue := DataGrid.Cells[ACol, ARow];
  if (NewValue = '') then
  begin
    NewValue := '0';
  end;

  with TfrmFormula.Create(self) do
  begin
    try
      // GIS functions are not included and
      // Data sets are not included
      // because the variables will be evaluated for screen objects and
      // not at specific locations.

      PopupParent := self;

      // Show the functions and global variables.
      UpdateTreeList;

      // put the formula in the TfrmFormula.
      Formula := NewValue;
      // The user edits the formula.
      ShowModal;
      if ResultSet then
      begin
        CreateBoundaryFormula(DataGrid, ACol, ARow, Formula, Orientation,
          EvaluatedAt);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.frameResdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreResBoundary;
end;

procedure TfrmScreenObjectProperties.frameResdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  UpdateNodeState(FRES_Node);
  frameRes.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);
  if not frameRes.dgModflowBoundary.DistributingText then
  begin
    StoreResBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameResseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameRes.seNumberOfTimesChange(Sender);
  StoreResBoundary;
end;

procedure TfrmScreenObjectProperties.frameRivParamclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateNodeState(FRIV_Node);
  frameRivParam.clbParametersStateChange(Sender, Index);
  StoreRivBoundary;
end;

procedure TfrmScreenObjectProperties.frameRivParamcomboFormulaInterpChange(
  Sender: TObject);
var
  Item: TScreenObjectEditItem;
begin
  inherited;
  UpdateNodeState(FRIV_Node);
  StoreRivBoundary;
  Item := FNewProperties[0];
  AssignConductanceCaptions(frameRivParam, Item.ScreenObject.ModflowRivBoundary);
end;

procedure TfrmScreenObjectProperties.frameRivParamdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreRivBoundary;
end;

procedure TfrmScreenObjectProperties.frameRivParamdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateNodeState(FRIV_Node);
  frameRivParam.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateRivBoundary;
    StartParamCol := Item.ScreenObject.ModflowRivBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameRivParam, StartParamCol, ACol, ARow,Value);
  end;

  if not frameRivParam.dgModflowBoundary.DistributingText then
  begin
    StoreRivBoundary;  
  end;
end;

procedure TfrmScreenObjectProperties.frameRivParamseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameRivParam.seNumberOfTimesChange(Sender);
  StoreRivBoundary;
end;

procedure TfrmScreenObjectProperties.frameFarmWellclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateNodeState(FFarmWell_Node);
  frameFarmWell.clbParametersStateChange(Sender, Index);
  StoreFarmWell;
end;

procedure TfrmScreenObjectProperties.frameFarmWellcomboFormulaInterpChange(
  Sender: TObject);
var
  Item: TScreenObjectEditItem;
begin
  inherited;
  UpdateNodeState(FFarmWell_Node);
  StoreFarmWell;
  Item := FNewProperties[0];
  AssignConductanceCaptions(frameFarmWell, Item.ScreenObject.ModflowFmpWellBoundary);
end;

procedure TfrmScreenObjectProperties.frameFarmWelldgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreFarmWell;
end;

procedure TfrmScreenObjectProperties.frameFarmWelldgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateNodeState(FFarmWell_Node);
  frameFarmWell.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateWelBoundary;
    StartParamCol := Item.ScreenObject.ModflowFmpWellBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameFarmWell, StartParamCol, ACol, ARow,Value);
  end;

  if not frameFarmWell.dgModflowBoundary.DistributingText then
  begin
    StoreFarmWell;
  end;
end;

procedure TfrmScreenObjectProperties.frameFarmWellseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameFarmWell.seNumberOfTimesChange(Sender);
  StoreFarmWell;
end;

procedure TfrmScreenObjectProperties.frameFluxObsbtnAddOrRemoveFluxObservationsClick(
  Sender: TObject);
var
  List: TList;
begin
  inherited;
//  frmGoPhast.miManageFluxObservationsClick(nil);
  ShowAForm(TfrmManageFluxObservations);
  if FScreenObject = nil then
  begin
    GetFluxObservations(FScreenObjectList);
  end
  else
  begin
    List := TList.Create;
    try
      List.Add(FScreenObject);
      GetFluxObservations(List);
    finally
      List.Free;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.frameRVOBrdgObservationGroupsSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  if IsLoaded then
  begin
    FRvob_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameRVOBrdgObservationGroupsStateChange(
  Sender: TObject; ACol, ARow: Integer; const Value: TCheckBoxState);
begin
  inherited;
  if IsLoaded then
  begin
    FRvob_Node.StateIndex := 2;
  end;
end;

//procedure TfrmScreenObjectProperties.frameScreenObjectFarmpcMainChange(
//  Sender: TObject);
//begin
//  inherited;
//  if IsLoaded then
//  begin
//    HelpKeyword := frameScreenObjectFarm.pcMain.ActivePage.HelpKeyword;
//    btnHelp.HelpKeyword := HelpKeyword;
//  end;
//end;

procedure TfrmScreenObjectProperties.frameScreenObjectSFRjceButtonClick(
  Sender: TObject);
var
  FunctionString: string;
  ed: TJvComboEdit;
  VariableList: TList;
  VarIndex, Index: integer;
  Variable: TCustomValue;
  Compiler: TRbwParser;
  CompiledFormula: TExpression;
  AVar: TCustomValue;
begin
{ TODO : See if some of this can be combined with ValidateEdFormula. }

  inherited;
  // edit the formula that is not part of a data set or boundary data set.
  ed := Sender as TJvComboEdit;

  FunctionString := ed.Text;
  if (FunctionString = '') then
  begin
    FunctionString := '0';
  end;

  Compiler := rparserThreeDFormulaElements;

  VariableList := TList.Create;
  try
    for VarIndex := 0 to Compiler.VariableCount - 1 do
    begin
      AVar := Compiler.Variables[VarIndex];
      if frmGoPhast.PhastModel.GlobalVariables.IndexOfVariable(AVar.Name) < 0 then
      begin
        VariableList.Add(Compiler.Variables[VarIndex]);
      end;
    end;

    with TfrmFormula.Create(nil) do
    begin
      try
        IncludeGIS_Functions(eaBlocks);
        RemoveGetVCont;
        RemoveHufFunctions;
        PopupParent := self;

        for Index := 0 to VariableList.Count - 1 do
        begin
          Variable := VariableList[Index];
          rbFormulaParser.RegisterVariable(Variable);
        end;

        UpdateTreeList;
        Formula := FunctionString;

        ShowModal;
        if ResultSet then
        begin
          FunctionString := Formula;
        end
        else
        begin
          if FunctionString = '' then
            FunctionString := '0';
        end;
      finally
        Free;
      end;
    end;

    try
      Compiler.Compile(FunctionString);
    except on E: ErbwParserError do
      begin
        Beep;
        MessageDlg(Format(StrErrorInFormulaS, [E.Message]), mtError, [mbOK], 0);
        Exit;
      end
    end;

    CompiledFormula := Compiler.CurrentExpression;
    // check that the formula is OK.
    if not (CompiledFormula.ResultType in [rdtDouble, rdtInteger]) then
    begin
      ed.Color := clRed;
      Beep;
      MessageDlg(StrErrorTheFormulaI, mtError, [mbOK], 0);
      Exit;
    end
    else
    begin
      ed.Color := clWindow;
      FunctionString := CompiledFormula.DecompileDisplay;
      if FunctionString <> ed.Text then
      begin
        ed.Text := FunctionString;
        if Assigned(ed.OnChange) then
        begin
          ed.OnChange(ed);
        end;
        if Assigned(ed.OnExit) then
        begin
          ed.OnExit(ed);
        end;
      end;
    end
  finally
    VariableList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.frameScreenObjectSFRpcSFRChange(
  Sender: TObject);
begin
  inherited;
  HelpKeyword := frameScreenObjectSFR.pcSFR.ActivePage.HelpKeyword;
  btnHelp.HelpKeyword := HelpKeyWord;
end;

procedure TfrmScreenObjectProperties.frameScreenObjectSFRrdgNetworkButtonClick(
  Sender: TObject; ACol, ARow: Integer);
var
  NetworkColumn: TSfrNetworkColumns;  
  NewText: string;
begin
  inherited;
  NewText := '';
  NetworkColumn := TSfrNetworkColumns(ACol);
  case NetworkColumn of
    sncOutflowSegment:
      begin
        GetNearestOutflowSegment(NewText, ptSFR);
      end;
    sncDiversionSegment:
      begin
        GetNearestDiversionSegment(NewText, ptSFR);
      end;
    else
      Assert(False);
  end;
  if NewText <> '' then
  begin
    frameScreenObjectSFR.rdgNetwork.Cells[ACol, ARow] := NewText;
  end;
end;

procedure TfrmScreenObjectProperties.frameScreenObjectSTRdgModflowBoundaryButtonClick(
  Sender: TObject; ACol, ARow: Integer);
var
  NetworkColumn: TStrTimeColumns;
  NewText: string;
begin
  inherited;

  NewText := '';
  NetworkColumn := TStrTimeColumns(ACol);
  case NetworkColumn of
    stcDownstreamSegment:
      begin
        GetNearestOutflowSegment(NewText, ptSTR);
      end;
    stcDiversionSegment:
      begin
        GetNearestDiversionSegment(NewText, ptSTR);
      end;
    else
      begin
        frameChdParamdgModflowBoundaryButtonClick(Sender, ACol, ARow);
      end;
  end;
  if NewText <> '' then
  begin
    frameScreenObjectSTR.dgModflowBoundary.Cells[ACol, ARow] := NewText;
  end;

end;

procedure TfrmScreenObjectProperties.UpdateSfrNode(Sender: TObject);
begin
  UpdateNodeState(FSFR_Node);
end;

procedure TfrmScreenObjectProperties.UpdateStrNode(Sender: TObject);
begin
  UpdateNodeState(FSTR_Node);
end;

procedure TfrmScreenObjectProperties.frameScreenObjectUZFdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreUzfBoundary;
end;

procedure TfrmScreenObjectProperties.frameScreenObjectUZFdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  UpdateNodeState(FUZF_Node);
  frameScreenObjectUZF.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);
  if not frameScreenObjectUZF.dgModflowBoundary.DistributingText then
  begin
    StoreUzfBoundary
  end;
end;

procedure TfrmScreenObjectProperties.frameScreenObjectUZFseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameScreenObjectUZF.seNumberOfTimesChange(Sender);
  StoreUzfBoundary;
end;

procedure TfrmScreenObjectProperties.frameSTOBrdgObservationGroupsSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  if IsLoaded then
  begin
    FStob_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameSTOBrdgObservationGroupsStateChange(
  Sender: TObject; ACol, ARow: Integer; const Value: TCheckBoxState);
begin
  inherited;
  if IsLoaded then
  begin
    FStob_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.SutraBoundaryButtonClick(
  Sender: TObject; ACol, ARow: Integer);
var
  VariableList: TList;
  Orientation: TDataSetOrientation;
  DataGrid: TRbwDataGrid4;
  EvaluatedAt: TEvaluatedAt;
  Index: integer;
  DataSet: TDataArray;
  NewValue: string;
  Variable: TCustomValue;
  Edit: TScreenObjectDataEdit;
  DataArrayManager: TDataArrayManager;
begin
  inherited;
  DataGrid := Sender as TRbwDataGrid4;
  VariableList := TList.Create;
  // VariableList will hold a list of variables that can
  // be used in the function
  try
      Orientation := dso3D;
    // All the MODFLOW boundary conditions are evaluated at blocks.
    EvaluatedAt := eaNodes;

    DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
    for Index := 0 to DataArrayManager.DataSetCount - 1 do
    begin
      DataSet := DataArrayManager.DataSets[Index];
      if (EvaluatedAt = DataSet.EvaluatedAt) then
      begin
        if ((Orientation = dso3D)
          or (Orientation = DataSet.Orientation)) then
        begin
          Edit := FDataEdits[Index];
          // if the variable does not depend on the
          // data set whose formula is being edited
          // and it's orientation is OK, the variable
          // can be used in the formula.
          VariableList.Add(Edit.Variable);
        end;
      end;
    end;

    NewValue := DataGrid.Cells[ACol, ARow];
    if (NewValue = '') then
    begin
      NewValue := '0';
    end;

    with TfrmFormula.Create(self) do
    begin
      try
        IncludeGIS_Functions(eaBlocks);
        RemoveGetVCont;
        RemoveHufFunctions;
        PopupParent := self;

        // register the appropriate variables with the
        // parser.
        for Index := 0 to VariableList.Count - 1 do
        begin
          Variable := VariableList[Index];
          rbFormulaParser.RegisterVariable(Variable);
        end;

        // show the variables and functions
        UpdateTreeList;

        // put the formula in the TfrmFormula.
        Formula := NewValue;
        // The user edits the formula.
        ShowModal;
        if ResultSet then
        begin
          CreateBoundaryFormula(DataGrid, ACol, ARow, Formula, Orientation,
            EvaluatedAt);
        end;
      finally
        Free;
      end;
    end;

  finally
    VariableList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.frameSutraObservationsbtnDeleteClick(
  Sender: TObject);
begin
  inherited;
  frameSutraObservations.btnDeleteClick(Sender);
end;

procedure TfrmScreenObjectProperties.frameSutraObservationsbtnInsertClick(
  Sender: TObject);
begin
  inherited;
  frameSutraObservations.btnInsertClick(Sender);
end;

procedure TfrmScreenObjectProperties.frameSutraObservationsedNameExit(
  Sender: TObject);
begin
  inherited;
  frameSutraObservations.edNameExit(Sender);
end;

procedure TfrmScreenObjectProperties.frameSwiObsGridSetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
begin
  inherited;
  frameSwiObs.frameSwiObsGridSetEditText(Sender, ACol, ARow, Value);
  UpdateNodeState(FSWiObs_Node);
end;

procedure TfrmScreenObjectProperties.frameSwrdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  UpdateNodeState(FSWR_Reach_Node);
  frameSwrReach.frameSwrdgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

end;

procedure TfrmScreenObjectProperties.frameSWR_DirectRunoffdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreSwrDirectRunoffBoundary;
end;

procedure TfrmScreenObjectProperties.frameSWR_DirectRunoffdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  UpdateNodeState(FSWR_DirectRunoff_Node);
  frameSWR_DirectRunoff.dgModflowBoundarySetEditText(Sender, ACol, ARow,
    Value);
  if not frameSWR_DirectRunoff.dgModflowBoundary.DistributingText then
  begin
    StoreSwrDirectRunoffBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameSWR_DirectRunoffseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameSWR_DirectRunoff.seNumberOfTimesChange(Sender);
  StoreSwrDirectRunoffBoundary;
end;

procedure TfrmScreenObjectProperties.frameSWR_EvapdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreSwrEvapBoundary
end;

procedure TfrmScreenObjectProperties.frameSWR_EvapdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;

  UpdateNodeState(FSWR_Evap_Node);
  frameSWR_Evap.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);
  if not frameSWR_Evap.dgModflowBoundary.DistributingText then
  begin
    StoreSwrEvapBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameSWR_EvapseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameSWR_Evap.seNumberOfTimesChange(Sender);
  StoreSwrEvapBoundary
end;

procedure TfrmScreenObjectProperties.frameSWR_LatInflcomboFormulaInterpChange(
  Sender: TObject);
begin
  inherited;
  StoreSwrLatInflowBoundary;
end;

procedure TfrmScreenObjectProperties.frameSWR_LatInfldgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
 StoreSwrLatInflowBoundary;
end;

procedure TfrmScreenObjectProperties.frameSWR_LatInfldgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  UpdateNodeState(FSWR_LatInflow_Node);
  frameSWR_LatInfl.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);
  if not frameSWR_LatInfl.dgModflowBoundary.DistributingText then
  begin
    StoreSwrLatInflowBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameSWR_LatInflseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameSWR_LatInfl.seNumberOfTimesChange(Sender);
  StoreSwrLatInflowBoundary
end;

procedure TfrmScreenObjectProperties.frameSWR_RaindgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreSwrRainBoundary
end;

procedure TfrmScreenObjectProperties.frameSWR_RaindgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  UpdateNodeState(FSWR_Rain_Node);
  frameSWR_Rain.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);
  if not frameSWR_Rain.dgModflowBoundary.DistributingText then
  begin
    StoreSwrRainBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameSWR_RainseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameSWR_Rain.seNumberOfTimesChange(Sender);
  StoreSwrRainBoundary
end;

procedure TfrmScreenObjectProperties.frameSWR_StagedgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreSwrStageBoundary;
end;

procedure TfrmScreenObjectProperties.frameSWR_StagedgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  UpdateNodeState(FSWR_Stage_Node);
  frameSWR_Stage.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);
  if not frameSWR_Stage.dgModflowBoundary.DistributingText then
  begin
    StoreSwrStageBoundary;
  end;

end;

procedure TfrmScreenObjectProperties.frameSWR_StageseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameSWR_Stage.seNumberOfTimesChange(Sender);
    StoreSwrStageBoundary;
end;

procedure TfrmScreenObjectProperties.frameWellParamclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateWellNodeState;
  frameWellParam.clbParametersStateChange(Sender, Index);
  StoreWellBoundary;
end;

procedure TfrmScreenObjectProperties.frameWellParamcomboFormulaInterpChange(
  Sender: TObject);
var
  Item: TScreenObjectEditItem;
begin
  inherited;
  UpdateWellNodeState;
  StoreWellBoundary;
  Item := FNewProperties[0];
  AssignConductanceCaptions(frameWellParam, Item.ScreenObject.ModflowWellBoundary);
end;

procedure TfrmScreenObjectProperties.frameWellParamdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreWellBoundary;
end;

procedure TfrmScreenObjectProperties.UpdateWellNodeState;
begin
  UpdateNodeState(FWEL_Node);
  EnableWellTabfile;
end;

procedure TfrmScreenObjectProperties.frameWellParamdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateWellNodeState;
  frameWellParam.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateWelBoundary;
    StartParamCol := Item.ScreenObject.ModflowWellBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameWellParam, StartParamCol, ACol, ARow,Value);
  end;

  if not frameWellParam.dgModflowBoundary.DistributingText then
  begin
    StoreWellBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameWellParamfedTabfileChange(
  Sender: TObject);
begin
  inherited;
  frameWellParam.fedTabfileChange(Sender);
  if IsLoaded then
  begin
    FWellTabFileChanged := True;
    StoreWellBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameWellParamseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameWellParam.seNumberOfTimesChange(Sender);
  StoreWellBoundary;
end;

procedure TfrmScreenObjectProperties.SelectBoundaryCell;
var
  DataGrid: TRbwDataGrid4;
  ColIndex, RowIndex: integer;
begin
  DataGrid := nil;
  case TPhastBoundaryTypes(rgBoundaryType.ItemIndex) of
    btSpecifiedHead:
      begin
        DataGrid := dgSpecifiedHead;
      end;
    btFlux:
      begin
        DataGrid := dgBoundaryFlux;
      end;
    btLeaky:
      begin
        DataGrid := dgBoundaryLeaky;
      end;
    btNone, btRiver, btWell:
      begin
        Exit;
      end;
  else
    if rgBoundaryType.ItemIndex < 0 then
    begin
      Exit;
    end;

    Assert(False);
  end;

  Assert(DataGrid <> nil);
  for RowIndex := 1 to DataGrid.RowCount - 1 do
  begin
    for ColIndex := 3 to DataGrid.ColCount - 1 do
    begin
      if DataGrid.Columns[ColIndex].Format = rcf4Boolean then
      begin
        if DataGrid.Checked[ColIndex, RowIndex] then
        begin
          DataGrid.Column := ColIndex;
          DataGrid.Row := RowIndex;
          DataGrid.OnStateChange(DataGrid, ColIndex, RowIndex, cbChecked);
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.rgBoundaryTypeClick(Sender: TObject);
var
  ItemIndex: Integer;
  Item: TScreenObjectEditItem;
  NewBoundaryType: TPhastBoundaryTypes;
begin
  inherited;

  seBoundaryTimes.Enabled := rgBoundaryType.ItemIndex <> 0;
  if (rgBoundaryType.ItemIndex < 0)
    or (rgBoundaryType.ItemIndex = pcPhastBoundaries.ActivePageIndex) then
  begin
    Exit;
  end;

  pcPhastBoundaries.ActivePageIndex := rgBoundaryType.ItemIndex;

  gbBoundaryPhastInterpolation.Caption := '';
  framePhastInterpolationBoundaries.cbPhastInterpolation.Checked := False;
  SelectBoundaryCell;
  if IsLoaded and (rgBoundaryType.ItemIndex >= 0) then
  begin
    NewBoundaryType := TPhastBoundaryTypes(rgBoundaryType.ItemIndex);
    for ItemIndex := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[ItemIndex];
      if NewBoundaryType <> btSpecifiedHead then
      begin
        Item.ScreenObject.SpecifiedHeadBoundary.Clear;
      end;
      if NewBoundaryType <> btFlux then
      begin
        Item.ScreenObject.FluxBoundary.Clear;
      end;
      if NewBoundaryType <> btLeaky then
      begin
        Item.ScreenObject.LeakyBoundary.Clear;
      end;
      if NewBoundaryType <> btRiver then
      begin
        Item.ScreenObject.RiverBoundary.Clear;
      end;
      if NewBoundaryType <> btWell then
      begin
        Item.ScreenObject.WellBoundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.seBoundaryTimesChange(Sender: TObject);
begin
  inherited;
  FDeletingPhastTime := True;
  try
    case TPhastBoundaryTypes(pcPhastBoundaries.ActivePageIndex) of
      btNone:
        begin
          FBoundaryGrid := nil;
        end;
      btSpecifiedHead:
        begin
          FBoundaryGrid := dgSpecifiedHead;
        end;
      btFlux:
        begin
          FBoundaryGrid := dgBoundaryFlux;
        end;
      btLeaky:
        begin
          FBoundaryGrid := dgBoundaryLeaky;
        end;
      btRiver:
        begin
          FBoundaryGrid := dgBoundaryRiver;
        end;
      btWell:
        begin
          FBoundaryGrid := dgWell;
        end;
    else
      FBoundaryGrid := nil;
    end;
    if FBoundaryGrid <> nil then
    begin
      FBoundaryGrid.RowCount := seBoundaryTimes.AsInteger + 1;
    end;
    StorePhastBoundary;
  finally
    FDeletingPhastTime := False;
  end;
end;

procedure TfrmScreenObjectProperties.dgBoundarySelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
var
  AnObject: TObject;
  InterpValuesCollection: TInterpValuesCollection;
  Item: TInterpValuesItem;
  Index: integer;
  AScreenObject: TScreenObject;
  MixtureAllowed: boolean;
begin
  inherited;
    // Show the PHAST-style Interpolation values when the user clicks on a cell
    // in a boundary.  (Not just river boundaries.)
  CanSelect := ((ACol <> 1) or (ARow <> 1)) and (ARow > 0);
  if (Sender = dgSpecifiedHead) or (Sender = dgBoundaryFlux)
    or (Sender = dgBoundaryLeaky) then
  begin
    If ACol in [2,4] then
    begin
      CanSelect := not (Sender as TRbwDataGrid4).Checked[ACol+1,ARow];
    end;
  end;

  if not IsLoaded or (Sender as TRbwDataGrid4).Drawing then
    Exit;
  AScreenObject := FScreenObject;
  if AScreenObject = nil then
  begin
    AScreenObject := FScreenObjectList[0];
  end;

  if not (Sender as TRbwDataGrid4).Drawing
    and not (csCreating in ControlState) then
  begin
    MixtureAllowed := False;
    if (ACol >= 2) and (ARow > 0) then
    begin
      FBoundaryGrid := Sender as TRbwDataGrid4;
      FBoundaryRow := ARow;
      if (Sender = dgBoundaryRiver) or (Sender = dgWell) or Odd(ACol) then
      begin
        FBoundaryCol := ACol;
      end
      else
      begin
        FBoundaryCol := ACol + 1;
      end;

      if (Sender = dgSpecifiedHead) or (Sender = dgBoundaryFlux)
        or (Sender = dgBoundaryLeaky) then
      begin
        framePhastInterpolationBoundaries.Enabled :=
          (Sender as TRbwDataGrid4).Checked[FBoundaryCol,ARow];
      end
      else
      begin
        framePhastInterpolationBoundaries.Enabled := False;
      end;
//      framePhastInterpolationBoundaries.cbPhastInterpolation.Checked :=
//        framePhastInterpolationBoundaries.Enabled;
//      framePhastInterpolationBoundaries.cbPhastInterpolationClick(nil);

      AnObject := FBoundaryGrid.Objects[ACol, ARow];
      if AnObject = nil then
      begin
        // create InterpValuesCollection if it hasn't already been created.
        InterpValuesCollection := TInterpValuesCollection.Create(nil);
        FBoundaryPhastInterpolationList.Add(InterpValuesCollection);
        FBoundaryGrid.Objects[ACol, ARow] := InterpValuesCollection;
        if Odd(ACol) then
        begin
          FBoundaryGrid.Objects[ACol - 1, ARow] := InterpValuesCollection;
        end
        else
        begin
          FBoundaryGrid.Objects[ACol + 1, ARow] := InterpValuesCollection;
        end;
      end
      else
      begin
        InterpValuesCollection := AnObject as TInterpValuesCollection;
      end;
      if InterpValuesCollection.Count = 0 then
      begin
        Item := InterpValuesCollection.Add as TInterpValuesItem;
        if FBoundaryGrid = dgSpecifiedHead then
        begin
          if FBoundaryCol = Ord(ibcBoundaryInterpolate) then
          begin
            Item.Values.Assign(AScreenObject.
              SpecifiedHeadBoundary.BoundaryValue.GetDataSet(0));
          end
          else if FBoundaryCol = Ord(ibcSolutionInterpolate) then
          begin
            Item.Values.Assign(AScreenObject.
              SpecifiedHeadBoundary.Solution.
              GetDataSet(0));
          end
          else
          begin
            Assert(False);
          end;
        end
        else if FBoundaryGrid = dgBoundaryFlux then
        begin
          if FBoundaryCol = Ord(ibcBoundaryInterpolate) then
          begin
            Item.Values.Assign(AScreenObject.FluxBoundary.BoundaryValue.GetDataSet(0));
          end
          else if FBoundaryCol = Ord(ibcSolutionInterpolate) then
          begin
            Item.Values.Assign(AScreenObject.
              FluxBoundary.Solution.GetDataSet(0));
          end
          else
          begin
            Assert(False);
          end;
        end
        else if FBoundaryGrid = dgBoundaryLeaky then
        begin
          if FBoundaryCol = Ord(ibcBoundaryInterpolate) then
          begin
            Item.Values.Assign(AScreenObject.LeakyBoundary.BoundaryValue.GetDataSet(0));
          end
          else if FBoundaryCol = Ord(ibcSolutionInterpolate) then
          begin
            Item.Values.Assign(AScreenObject.
              LeakyBoundary.Solution.GetDataSet(0));
          end
          else
          begin
            Assert(False);
          end;
        end
        else if FBoundaryGrid = dgBoundaryRiver then
        begin
          if FBoundaryCol = Ord(nicBoundaryValue) then
          begin
            Item.Values.Assign(AScreenObject.RiverBoundary.BoundaryValue.GetDataSet(0));
          end
          else if FBoundaryCol = Ord(nicSolution) then
          begin
            Item.Values.Assign(AScreenObject.
              RiverBoundary.Solution.GetDataSet(0));
          end
          else
          begin
            Assert(False);
          end;
        end
        else if FBoundaryGrid = dgWell then
        begin
          if FBoundaryCol = Ord(nicBoundaryValue) then
          begin
            Item.Values.Assign(AScreenObject.
              WellBoundary.BoundaryValue.GetDataSet(0));
          end
          else if FBoundaryCol = Ord(nicSolution) then
          begin
            Item.Values.Assign(AScreenObject.
              WellBoundary.Solution.GetDataSet(0));
          end
          else
          begin
            Assert(False);
          end;
        end
        else
        begin
          Assert(False)
        end;
      end;

      if FBoundaryGrid = dgSpecifiedHead then
      begin
        if FBoundaryCol = Ord(ibcBoundaryInterpolate) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrSpecifiedHead;
          MixtureAllowed := False;
        end
        else if FBoundaryCol = Ord(ibcSolutionInterpolate) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrSolution;
          MixtureAllowed := True;
        end
        else
        begin
          Assert(False);
        end;
      end
      else if FBoundaryGrid = dgBoundaryFlux then
      begin
        if FBoundaryCol = Ord(ibcBoundaryInterpolate) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrSpecifiedFlux;
          MixtureAllowed := False;
        end
        else if FBoundaryCol = Ord(ibcSolutionInterpolate) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrAssociatedSolution;
          MixtureAllowed := True;
        end
        else
        begin
          Assert(False);
        end;
      end
      else if FBoundaryGrid = dgBoundaryLeaky then
      begin
        if FBoundaryCol = Ord(ibcBoundaryInterpolate) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrLeakyBoundaryHead;
          MixtureAllowed := False;
        end
        else if FBoundaryCol = Ord(ibcSolutionInterpolate) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrAssociatedSolution;
          MixtureAllowed := True;
        end
        else
        begin
          Assert(False);
        end;
      end
      else if FBoundaryGrid = dgBoundaryRiver then
      begin
        if FBoundaryCol = Ord(nicBoundaryValue) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrRiver;
          MixtureAllowed := False;
        end
        else if FBoundaryCol = Ord(nicSolution) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrAssociatedSolution;
          MixtureAllowed := True;
        end
        else
        begin
          Assert(False);
        end;
      end
      else if FBoundaryGrid = dgWell then
      begin
        if FBoundaryCol = Ord(nicBoundaryValue) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrWellRate;
          MixtureAllowed := False;
        end
        else if FBoundaryCol = Ord(nicSolution) then
        begin
          gbBoundaryPhastInterpolation.Caption := StrSolution;
          MixtureAllowed := True;
        end
        else
        begin
          Assert(False);
        end;
      end
      else
      begin
        Assert(False)
      end;

      gbBoundaryPhastInterpolation.Caption
        := gbBoundaryPhastInterpolation.Caption + ' '
        + FBoundaryGrid.Cells[1, ARow];

      framePhastInterpolationData.AssigningValues := True;
      framePhastInterpolationBoundaries.GetFirstData((InterpValuesCollection.
        Items[0] as TInterpValuesItem).Values);
      framePhastInterpolationData.AssigningValues := False;
      for Index := 1 to InterpValuesCollection.Count - 1 do
      begin
        framePhastInterpolationData.AssigningValues := True;
        framePhastInterpolationBoundaries.GetMoreData((InterpValuesCollection.
          Items[Index] as TInterpValuesItem).Values);
        framePhastInterpolationData.AssigningValues := False;
      end;

      framePhastInterpolationBoundaries.SetMixtureAllowed(MixtureAllowed);
    end
    else
    begin
      framePhastInterpolationBoundaries.Enabled := False;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.dgBoundaryRiverDistributeTextProgress(
  Sender: TObject; Position, Max: Integer);
begin
  inherited;
  seBoundaryTimes.AsInteger := dgBoundaryRiver.RowCount -1;
  seBoundaryTimesChange(nil);
end;

procedure TfrmScreenObjectProperties.dgBoundaryRowMoving(Sender: TObject;
  const Origin, Destination: Integer; var CanMove: Boolean);
begin
  inherited;
  CanMove := (Origin <> 1) and (Destination <> 1);
end;

procedure TfrmScreenObjectProperties.dgBoundaryDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
  if (ACol = 1) and (ARow = 1) then
  begin
    with Sender as TRbwDataGrid4 do
    begin
      Canvas.Brush.Color := FixedColor;
      Canvas.FillRect(Rect);
      Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
    end;
  end;
  if (Sender = dgSpecifiedHead)
  or (Sender = dgBoundaryFlux) or (Sender = dgBoundaryLeaky) then
  begin
    if (ARow >= 1) and (ACol >= 2) and not Odd(ACol) then
    begin
      with Sender as TRbwDataGrid4 do
      begin
        if Checked[ACol + 1, ARow] then
        begin
          Canvas.Brush.Color := FixedColor;
          Canvas.FillRect(Rect);
          Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, StrInterpolated);
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.dgBoundaryFluxDistributeTextProgress(
  Sender: TObject; Position, Max: Integer);
begin
  inherited;
  seBoundaryTimes.AsInteger := dgBoundaryFlux.RowCount -1;
  seBoundaryTimesChange(nil);
end;

procedure TfrmScreenObjectProperties.dgBoundaryLeakyDistributeTextProgress(
  Sender: TObject; Position, Max: Integer);
begin
  inherited;
  seBoundaryTimes.AsInteger := dgBoundaryLeaky.RowCount -1;
  seBoundaryTimesChange(nil);
end;

procedure TfrmScreenObjectProperties.pcPhastBoundariesChange(Sender: TObject);
begin
  inherited;
  case TPhastBoundaryTypes(pcPhastBoundaries.ActivePageIndex) of
    btNone:
      begin
        Exit;
      end;
    btSpecifiedHead:
      begin
        seBoundaryTimes.Value := dgSpecifiedHead.RowCount - 1;
      end;
    btFlux:
      begin
        seBoundaryTimes.Value := dgBoundaryFlux.RowCount - 1;
      end;
    btLeaky:
      begin
        seBoundaryTimes.Value := dgBoundaryLeaky.RowCount - 1;
      end;
    btRiver:
      begin
        seBoundaryTimes.Value := dgBoundaryRiver.RowCount - 1;
      end;
    btWell:
      begin
        seBoundaryTimes.Value := dgWell.RowCount - 1;
      end;
  else
    Assert(False);
  end;
end;

procedure TfrmScreenObjectProperties.seWellIntervalsChange(Sender: TObject);
begin
  inherited;
  if seWellIntervals.Value = 0 then
  begin
    seWellIntervals.Value := 1;
  end;

  dgWellElevations.RowCount := seWellIntervals.AsInteger + 1;
  StorePhastWellBoundary;
end;

procedure TfrmScreenObjectProperties.comboWellIntervalStyleChange(Sender:
  TObject);
begin
  inherited;
  case comboWellIntervalStyle.ItemIndex of
    -1:
      begin
        // Elevation
        dgWellElevations.Cells[Ord(wicFirst), 0] := StrFirstValue;
        dgWellElevations.Cells[Ord(wicSecond), 0] := StrSecondValue;
        rdeWellLandSurfaceDatum.Enabled := True;
      end;
    0:
      begin
        // Elevation
        dgWellElevations.Cells[Ord(wicFirst), 0] := StrFirstElevation;
        dgWellElevations.Cells[Ord(wicSecond), 0] := StrSecondElevation;
        rdeWellLandSurfaceDatum.Enabled := False;
      end;
    1:
      begin
        // Depth
        dgWellElevations.Cells[Ord(wicFirst), 0] := StrFirstDepth;
        dgWellElevations.Cells[Ord(wicSecond), 0] := StrSecondDepth;
        rdeWellLandSurfaceDatum.Enabled := True;
      end;
  else
    Assert(False);
  end;
  lblWellLandSurfaceDatum.Enabled := rdeWellLandSurfaceDatum.Enabled;
  StorePhastWellBoundary;
end;

procedure TfrmScreenObjectProperties.StoreGhbBoundary;
var
  ParamType: TParameterType;
  Frame: TframeScreenObjectCondParam;
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  if IsLoaded then
  begin
    Assert(FGHB_Node <> nil);
    Frame := frameGhbParam;
    ParamType := ptGHB;
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateGhbBoundary;
    end;
    StoreFormulaInterpretation(Frame, ParamType);
    StoreModflowBoundary(Frame, ParamType, FGHB_Node);
  end;
end;

procedure TfrmScreenObjectProperties.StoreResBoundary;
var
  Frame: TframeScreenObjectNoParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TModflowBoundary;
begin
  if IsLoaded then
  begin
    Frame := frameRes;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateResBoundary;
      Boundary := Item.ScreenObject.ModflowResBoundary;
      if ShouldStoreBoundary(FRES_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
      end
      else if FRES_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreMt3dmsChemBoundary;
var
  Frame: TframeScreenObjectSsm;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TMt3dmsConcBoundary;
begin
  if IsLoaded then
  begin
    Frame := frameMT3DMS_SSM;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateMt3dmsConcBoundary;
      Boundary := Item.ScreenObject.Mt3dmsConcBoundary;
      case Frame.cbSpecifiedConcentration.State of
        cbUnchecked: Boundary.SpecifiedConcBoundary := False;
        cbChecked: Boundary.SpecifiedConcBoundary := True;
        cbGrayed: ;  // do nothing;
        else Assert(False);
      end;
      case Frame.cbMassLoading.State of
        cbUnchecked: Boundary.MassLoadingBoundary := False;
        cbChecked: Boundary.MassLoadingBoundary := True;
        cbGrayed: ;  // do nothing;
        else Assert(False);
      end;
      Assert(Boundary <> nil);
      if ShouldStoreBoundary(FMt3dmsSsm_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
      end
      else if  FMt3dmsSsm_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreLakBoundary;
var
  Frame: TframeScreenObjectNoParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TLakBoundary;
  IntValue: Integer;
  RealValue: Extended;
  DataSetIndex: integer;
  DataArray: TDataArray;
  Edit: TScreenObjectDataEdit;
  ItemIndex: integer;
  Stage: double;
  Volume: double;
  SurfaceArea: double;
  ExternalLakeTable: TExternalLakeTable;
  BathItem: TLakeTableItem;
begin
  if IsLoaded then
  begin
    Frame := frameLak;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateLakBoundary;
      Boundary := Item.ScreenObject.ModflowLakBoundary;
      Assert(Boundary <> nil);
      if ShouldStoreBoundary(FLAK_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
        if frameLak.cbGagStandard.State <> cbGrayed then
        begin
          Boundary.StandardGage := frameLak.cbGagStandard.Checked;
        end;
        if frameLak.cbGagFluxAndCond.State <> cbGrayed then
        begin
          Boundary.FluxCondGage := frameLak.cbGagFluxAndCond.Checked;
        end;
        if frameLak.cbGagDelta.State <> cbGrayed then
        begin
          Boundary.DeltaGage := frameLak.cbGagDelta.Checked;
        end;
        if frameLak.cbGage4.State <> cbGrayed then
        begin
          Boundary.Gage4 := frameLak.cbGage4.Checked;
        end;
      end
      else if  FLAK_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
    end;

    DataSetIndex := self.GetDataSetIndexByName(rsLakeID);
    Edit := FDataEdits[DataSetIndex];
    DataArray := Edit.DataArray;
    if TryStrToInt(frameLak.rdeLakeID.Text, IntValue) then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Boundary := Item.ScreenObject.ModflowLakBoundary;
        Assert(Boundary <> nil);

        if ShouldStoreBoundary(FLAK_Node, Boundary) then
        begin
          Boundary.LakeID := IntValue;
        end;

        { TODO : See if UpdateScreenObjectData can be made to do this. }
//        DataSetIndex := self.GetDataSetIndexByName(rsLakeID);
//        Edit := FDataEdits[DataSetIndex];
//        DataArray := Edit.DataArray;
        if ShouldStoreBoundary(FLAK_Node, Boundary) then
        begin
          if IntValue = 0 then
          begin
            Item.ScreenObject.RemoveDataSet(DataArray)
          end
          else
          begin
            DataSetIndex := Item.ScreenObject.AddDataSet(DataArray);
            Item.ScreenObject.DataSetFormulas[DataSetIndex] := IntToStr(IntValue)
          end;
        end;
      end;
    end
    else
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Boundary := Item.ScreenObject.ModflowLakBoundary;
        Assert(Boundary <> nil);

        if ShouldStoreBoundary(FLAK_Node, Boundary) then
        begin
          if  (Boundary.LakeID = 0) then
          begin
            Boundary.LakeID := 1;
          end;
          IntValue := Boundary.LakeID;
        end
        else
        begin
          IntValue := 0;
        end;

        { TODO : See if UpdateScreenObjectData can be made to do this. }
        if ShouldStoreBoundary(FLAK_Node, Boundary) then
        begin
          if IntValue = 0 then
          begin
            Item.ScreenObject.RemoveDataSet(DataArray)
          end
          else
          begin
            DataSetIndex := Item.ScreenObject.AddDataSet(DataArray);
            Item.ScreenObject.DataSetFormulas[DataSetIndex] := IntToStr(IntValue)
          end;
        end;
      end;
    end;

    if TryStrToInt(frameLak.rdeCenterLake.Text, IntValue) then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Boundary := Item.ScreenObject.ModflowLakBoundary;
        Assert(Boundary <> nil);
        if ShouldStoreBoundary(FLAK_Node, Boundary) then
        begin
          Boundary.CenterLake := IntValue;
        end;
      end;
    end;
    if TryStrToFloat(frameLak.rdeInitialStage.Text, RealValue) then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Boundary := Item.ScreenObject.ModflowLakBoundary;
        Assert(Boundary <> nil);
        if ShouldStoreBoundary(FLAK_Node, Boundary) then
        begin
          Boundary.InitialStage := RealValue;
        end;
      end;
    end;
    if TryStrToFloat(frameLak.rdeSill.Text, RealValue) then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Boundary := Item.ScreenObject.ModflowLakBoundary;
        Assert(Boundary <> nil);
        if ShouldStoreBoundary(FLAK_Node, Boundary) then
        begin
          Boundary.Sill := RealValue;
        end;
      end;
    end;
    if frameLak.tabBathymetry.TabVisible then
    begin
      Item := FNewProperties[0];
      Item.ScreenObject.CreateLakBoundary;
      Boundary := Item.ScreenObject.ModflowLakBoundary;
      Assert(Boundary <> nil);

      ExternalLakeTable := Boundary.ExternalLakeTable;
      ExternalLakeTable.LakeTableChoice := TLakeTableChoice(frameLak.rgBathChoice.ItemIndex);
      ExternalLakeTable.FullLakeTableFileName := frameLak.feLakeBathymetry.FileName;
      ItemIndex := 0;
      for Index := 1 to frameLak.rdgLakeTable.RowCount - 1 do
      begin
        if TryStrToFloat(frameLak.rdgLakeTable.Cells[Ord(bcStage), Index], Stage)
          and TryStrToFloat(frameLak.rdgLakeTable.Cells[Ord(bcVolume), Index], Volume)
          and TryStrToFloat(frameLak.rdgLakeTable.Cells[Ord(bcSurfaceArea), Index], SurfaceArea)
          then
        begin

          if ItemIndex < ExternalLakeTable.LakeTable.Count then
          begin
            BathItem := ExternalLakeTable.LakeTable[ItemIndex];
          end
          else
          begin
            BathItem := ExternalLakeTable.LakeTable.Add;
          end;

          BathItem.Stage := Stage;
          BathItem.Volume := Volume;
          BathItem.SurfaceArea := SurfaceArea;
          Inc(ItemIndex);
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreDrnBoundary;
var
  ParamType: TParameterType;
  Frame: TframeScreenObjectCondParam;
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  if IsLoaded then
  begin
    Assert(FDRN_Node <> nil);
    Frame := frameDrnParam;
    ParamType := ptDRN;
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateDrnBoundary;
    end;
    StoreFormulaInterpretation(Frame, ParamType);
    StoreModflowBoundary(Frame, ParamType, FDRN_Node);
  end;
end;

procedure TfrmScreenObjectProperties.StoreRchBoundary;
var
  ParamType: TParameterType;
  Frame: TframeScreenObjectParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TRchBoundary;
  ColumnOffset: Integer;
  BoundaryLayers: TCustomMF_BoundColl;
begin
  if IsLoaded then
  begin
    Assert(FRCH_Node <> nil);
    Frame := frameRchParam;
    ParamType := ptRCH;
    StoreModflowBoundary(Frame, ParamType, FRCH_Node);

    if frmGoPhast.PhastModel.ModflowTransientParameters.
      CountParam(ptRCH) > 0 then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.CreateRchBoundary;
        Boundary := Item.ScreenObject.ModflowRchBoundary;
        Boundary.Values.Clear;
      end;
    end;

    if frmGoPhast.PhastModel.RchTimeVaryingLayers then
    begin
      GetMF_BoundaryTimes(Times, Frame);
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.CreateRchBoundary;
        Boundary := Item.ScreenObject.ModflowRchBoundary;
        ColumnOffset := 3;
        BoundaryLayers := Boundary.RechargeLayers;
        if ShouldStoreBoundary(FRCH_Node, Boundary) then
        begin
          StoreMF_BoundColl(ColumnOffset, BoundaryLayers, Times, Frame);
        end
        else if  FRCH_Node.StateIndex = 1 then
        begin
          Boundary.Clear;
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreEvtBoundary;
var
  ParamType: TParameterType;
  Frame: TframeScreenObjectParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TEvtBoundary;
  ColumnOffset: Integer;
  BoundaryLayers: TCustomMF_BoundColl;
begin
  if IsLoaded then
  begin
    Assert(FEVT_Node <> nil);
    Frame := frameEvtParam;
    ParamType := ptEVT;
    StoreModflowBoundary(Frame, ParamType, FEVT_Node);

    if frmGoPhast.PhastModel.ModflowTransientParameters.
      CountParam(ptEVT) > 0 then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.CreateEvtBoundary;
        Boundary := Item.ScreenObject.ModflowEvtBoundary;
        Boundary.Values.Clear;
      end;
    end;

    GetMF_BoundaryTimes(Times, Frame);
    if frmGoPhast.PhastModel.EvtTimeVaryingLayers then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.CreateEvtBoundary;
        Boundary := Item.ScreenObject.ModflowEvtBoundary;
        ColumnOffset := 5;
        BoundaryLayers := Boundary.EvapotranspirationLayers;
        if ShouldStoreBoundary(FEVT_Node, Boundary) then
        begin
          StoreMF_BoundColl(ColumnOffset, BoundaryLayers, Times, Frame);
        end
        else if  FEVT_Node.StateIndex = 1 then
        begin
          Boundary.Clear;
        end;
      end;
    end;
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateEvtBoundary;
      Boundary := Item.ScreenObject.ModflowEvtBoundary;
      ColumnOffset := 3;
      BoundaryLayers := Boundary.EvtSurfDepthCollection;
      if ShouldStoreBoundary(FEVT_Node, Boundary) then
      begin
        StoreMF_BoundColl(ColumnOffset, BoundaryLayers, Times, Frame);
      end
      else if  FEVT_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreEtsBoundary;
var
  ParamType: TParameterType;
  Frame: TframeScreenObjectParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TEtsBoundary;
  ColumnOffset: Integer;
  BoundaryLayers: TCustomMF_BoundColl;
begin
  if IsLoaded then
  begin
    Assert(FETS_Node <> nil);
    Frame := frameEtsParam;
    ParamType := ptETS;
    StoreModflowBoundary(Frame, ParamType, FETS_Node);

    if frmGoPhast.PhastModel.ModflowTransientParameters.
      CountParam(ptETS) > 0 then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.CreateEtsBoundary;
        Boundary := Item.ScreenObject.ModflowEtsBoundary;
        Boundary.Values.Clear;
      end;
    end;

    GetMF_BoundaryTimes(Times, Frame);
    if frmGoPhast.PhastModel.EtsTimeVaryingLayers then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.CreateEtsBoundary;
        Boundary := Item.ScreenObject.ModflowEtsBoundary;
        Assert(Boundary <> nil);
        ColumnOffset := 5 + (
          frmGoPhast.PhastModel.ModflowPackages.
          EtsPackage.SegmentCount-1)*2;
        BoundaryLayers := Boundary.EvapotranspirationLayers;
        if ShouldStoreBoundary(FETS_Node, Boundary) then
        begin
          StoreMF_BoundColl(ColumnOffset, BoundaryLayers, Times, Frame);
        end
        else if  FETS_Node.StateIndex = 1 then
        begin
          Boundary.Clear;
        end;
      end;
    end;
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateEtsBoundary;
      Boundary := Item.ScreenObject.ModflowEtsBoundary;
      Assert(Boundary <> nil);
      ColumnOffset := 3;
      BoundaryLayers := Boundary.EtsSurfDepthCollection;
      if ShouldStoreBoundary(FETS_Node, Boundary) then
      begin
        StoreMF_BoundColl(ColumnOffset, BoundaryLayers, Times, Frame);
      end
      else if  (FETS_Node.StateIndex = 1) then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreDrtBoundary;
var
  ParamType: TParameterType;
  Frame: TframeScreenObjectCondParam;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TDrtBoundary;
  RealValue: double;
  IntValue: integer;
  ObjectIndex: integer;
begin
  if IsLoaded then
  begin
    Assert(FDRT_Node <> nil);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateDrtBoundary;
      Boundary := Item.ScreenObject.ModflowDrtBoundary;
      if comboDrtLocationChoice.ItemIndex >= 0 then
      begin
        Boundary.DrainReturn.ReturnChoice :=
          TReturnChoice(comboDrtLocationChoice.ItemIndex);
        if ShouldStoreBoundary(FDRT_Node, Boundary) then
        begin
          case Boundary.DrainReturn.ReturnChoice of
            rtNone: ; // do nothing.
            rtObject:
              begin
                ObjectIndex := comboDrtReturnObject.ItemIndex;
                if ObjectIndex >= 0 then
                begin
                  Boundary.DrainReturn.ReturnObject.ScreenObject :=
                    comboDrtReturnObject.Items.Objects[ObjectIndex];
                end;
              end;
            rtLocation:
              begin
                if TryStrToFloat(rdeDrtX.Text, RealValue) then
                begin
                  Boundary.DrainReturn.ReturnLocation.X := RealValue;
                end;
                if TryStrToFloat(rdeDrtY.Text, RealValue) then
                begin
                  Boundary.DrainReturn.ReturnLocation.Y := RealValue;
                end;
                if TryStrToFloat(rdeDrtZ.Text, RealValue) then
                begin
                  Boundary.DrainReturn.ReturnLocation.Z := RealValue;
                end;
              end;
            rtCell:
              begin
                if TryStrToInt(rdeDrtCol.Text, IntValue) then
                begin
                  Boundary.DrainReturn.ReturnCell.Col := IntValue;
                end;
                if TryStrToInt(rdeDrtRow.Text, IntValue) then
                begin
                  Boundary.DrainReturn.ReturnCell.Row := IntValue;
                end;
                if TryStrToInt(rdeDrtLay.Text, IntValue) then
                begin
                  Boundary.DrainReturn.ReturnCell.Lay := IntValue;
                end;
              end;
            else Assert(False);
          end;
        end;
      end;
    end;

    Frame := frameDrtParam;
    ParamType := ptDRT;
    StoreFormulaInterpretation(Frame, ParamType);
    StoreModflowBoundary(Frame, ParamType, FDRT_Node);
  end;
end;

procedure TfrmScreenObjectProperties.StoreWellBoundary;
var
  ParamType: TParameterType;
  Frame: TframeScreenObjectCondParam;
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  if IsLoaded then
  begin
    Assert(FWEL_Node <> nil);
    Frame := frameWellParam;
    ParamType := ptQ;
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateWelBoundary;
      if FWellTabFileChanged then
      begin
        Item.ScreenObject.ModflowWellBoundary.TabFileName :=
          frameWellParam.fedTabfile.FileName;
      end;
    end;
    FWellTabFileChanged := False;
    StoreFormulaInterpretation(Frame, ParamType);
    StoreModflowBoundary(Frame, ParamType, FWEL_Node);
  end;
end;

procedure TfrmScreenObjectProperties.StoreFarmWell;
var
  ParamType: TParameterType;
  Frame: TframeScreenObjectCondParam;
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  if IsLoaded then
  begin
    Assert(FFarmWell_Node <> nil);
    Frame := frameFarmWell;
    ParamType := ptQMAX;
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateFarmWell;
    end;
    StoreFormulaInterpretation(Frame, ParamType);
    StoreModflowBoundary(Frame, ParamType, FFarmWell_Node);
  end;
end;

procedure TfrmScreenObjectProperties.StoreRivBoundary;
var
  ParamType: TParameterType;
  Frame: TframeScreenObjectCondParam;
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  if IsLoaded then
  begin
    Assert(FRIV_Node <> nil);
    Frame := frameRivParam;
    ParamType := ptRiv;
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateRivBoundary;
    end;
    StoreFormulaInterpretation(Frame, ParamType);
    StoreModflowBoundary(Frame, ParamType, FRIV_Node);
  end;
end;

procedure TfrmScreenObjectProperties.StoreSwrEvapBoundary;
var
  Frame: TframeScreenObjectNoParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TSwrEvapBoundary;
begin
  if IsLoaded then
  begin
    Frame := frameSWR_Evap;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateSwrEvapBoundary;
      Boundary := Item.ScreenObject.ModflowSwrEvap;
      if ShouldStoreBoundary(FSWR_Evap_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
      end
      else if FSWR_Evap_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreSwrLatInflowBoundary;
var
  Frame: TframeScreenObjectNoParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TSwrLatInflowBoundary;
begin
  if IsLoaded then
  begin
    Frame := frameSWR_LatInfl;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateSwrLatInflowBoundary;
      Boundary := Item.ScreenObject.ModflowSwrLatInflow;
      if ShouldStoreBoundary(FSWR_LatInflow_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
        if frameSWR_LatInfl.comboFormulaInterp.ItemIndex >= 1 then
        begin
          Boundary.FormulaInterpretation :=
            TFormulaInterpretation(frameSWR_LatInfl.comboFormulaInterp.ItemIndex)
        end;
      end
      else if FSWR_LatInflow_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreSwrRainBoundary;
var
  Frame: TframeScreenObjectNoParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TSwrRainBoundary;
begin
  if IsLoaded then
  begin
    Frame := frameSWR_Rain;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateSwrRainBoundary;
      Boundary := Item.ScreenObject.ModflowSwrRain;
      if ShouldStoreBoundary(FSWR_Rain_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
      end
      else if FSWR_Rain_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreSwrStageBoundary;
var
  Frame: TframeScreenObjectNoParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TSwrStageBoundary;
begin
  if IsLoaded then
  begin
    Frame := frameSWR_Stage;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateSwrStageBoundary;
      Boundary := Item.ScreenObject.ModflowSwrStage;
      if ShouldStoreBoundary(FSWR_Stage_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
      end
      else if FSWR_Stage_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreSwrDirectRunoffBoundary;
var
  Frame: TframeScreenObjectNoParam;
  Times: TTimeArray;
  Index: Integer;
  Item: TScreenObjectEditItem;
  Boundary: TSwrDirectRunoffBoundary;
begin
  if IsLoaded then
  begin
    Frame := frameSWR_DirectRunoff;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateSwrDirectRunoffBoundary;
      Boundary := Item.ScreenObject.ModflowSwrDirectRunoff;
      if ShouldStoreBoundary(FSWR_DirectRunoff_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
      end
      else if FSWR_DirectRunoff_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreCfpRechargeFraction;
var
  Frame: TframeScreenObjectNoParam;
  Index: Integer;
  Times: TTimeArray;
  Item: TScreenObjectEditItem;
  Boundary: TCfpRchFractionBoundary;
begin
  if IsLoaded then
  begin
    Frame := frameCfpRechargeFraction;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateCfpRchFraction;
      Boundary := Item.ScreenObject.ModflowCfpRchFraction;
      Assert(Boundary <> nil);
      if ShouldStoreBoundary(FCRCH_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
      end
      else if (FCRCH_Node.StateIndex = 1) then
      begin
        Boundary.Clear;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreUzfBoundary;
var
  Frame: TframeScreenObjectNoParam;
  Index: Integer;
  Times: TTimeArray;
  Item: TScreenObjectEditItem;
  Boundary: TUzfBoundary;
  ColumnOffset: integer;
  Gage: integer;
begin
  if IsLoaded then
  begin
    Frame := frameScreenObjectUZF;
    GetMF_BoundaryTimes(Times, Frame);
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateUzfBoundary;
      Boundary := Item.ScreenObject.ModflowUzfBoundary;
      Assert(Boundary <> nil);
      if ShouldStoreBoundary(FUZF_Node, Boundary) then
      begin
        StoreModflowBoundaryValues(Frame, Times, Boundary);
        if frmGoPhast.PhastModel.ModflowPackages.UzfPackage.SimulateET then
        begin
          ColumnOffset := 3;
          StoreMF_BoundColl(ColumnOffset, Boundary.EvapotranspirationDemand, Times, Frame);
          ColumnOffset := 4;
          StoreMF_BoundColl(ColumnOffset, Boundary.ExtinctionDepth, Times, Frame);
          ColumnOffset := 5;
          StoreMF_BoundColl(ColumnOffset, Boundary.WaterContent, Times, Frame);
        end;
      end
      else if  FUZF_Node.StateIndex = 1 then
      begin
        Boundary.Clear;
      end;
      Gage := 0;
      if cbUzfGage1.Checked then
      begin
        Gage := 1;
        if cbUzfGage2.Checked then
        begin
          Gage := 2;
        end;
      end;
      if not (cbUzfGage1.State = cbGrayed)
        and not (cbUzfGage2.State = cbGrayed) then
      begin
        Boundary.GageOption1 := Gage;
      end;
      Gage := 0;
      if cbUzfGage3.Checked then
      begin
        Gage := 3;
      end;
      if not (cbUzfGage3.State = cbGrayed) then
      begin
        Boundary.GageOption2 := Gage;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StoreChdBoundary;
var
  Frame: TframeScreenObjectParam;
  ParamType: TParameterType;
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  if IsLoaded then
  begin
    Assert(FCHD_Node <> nil);
    Frame := frameChdParam;
    ParamType := ptCHD;
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.CreateChdBoundary;
    end;
    StoreModflowBoundary(Frame, ParamType, FCHD_Node);
  end;
end;

procedure TfrmScreenObjectProperties.frameCfpRechargeFractiondgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreCfpRechargeFraction
end;

procedure TfrmScreenObjectProperties.frameCfpRechargeFractiondgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  frameCfpRechargeFraction.dgModflowBoundarySetEditText(Sender, ACol, ARow,
  Value);
  UpdateNodeState(FCRCH_Node);
  frameCfpRechargeFraction.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);
  if not frameCfpRechargeFraction.dgModflowBoundary.DistributingText then
  begin
    StoreCfpRechargeFraction
  end;
end;

procedure TfrmScreenObjectProperties.frameCfpRechargeFractionseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameCfpRechargeFraction.seNumberOfTimesChange(Sender);
  StoreCfpRechargeFraction;
end;

procedure TfrmScreenObjectProperties.frameChdParamclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateNodeState(FCHD_Node);
  frameChdParam.clbParametersStateChange(Sender, Index);
  StoreChdBoundary;
end;

procedure TfrmScreenObjectProperties.frameChdParamdgModflowBoundaryButtonClick(
  Sender: TObject; ACol, ARow: Integer);
var
  VariableList: TList;
  Orientation: TDataSetOrientation;
  DataGrid: TRbwDataGrid4;
  EvaluatedAt: TEvaluatedAt;
  Index: integer;
  DataSet: TDataArray;
  NewValue: string;
  Variable: TCustomValue;
  Edit: TScreenObjectDataEdit;
  DataArrayManager: TDataArrayManager;
begin
  inherited;
  DataGrid := Sender as TRbwDataGrid4;
  VariableList := TList.Create;
  // VariableList will hold a list of variables that can
  // be used in the function
  try
    // get the orientation of the data set.
    if (DataGrid = frameRchParam.dgModflowBoundary)
      or (DataGrid = frameEvtParam.dgModflowBoundary)
      or (DataGrid = frameEtsParam.dgModflowBoundary)
      or (DataGrid = frameFarmCropID.dgModflowBoundary)
      or (DataGrid = frameFarmID.dgModflowBoundary)
      or (DataGrid = frameFarmPrecip.dgModflowBoundary)
      or (DataGrid = frameFarmRefEvap.dgModflowBoundary)
      or (DataGrid = frameFarmID.dgModflowBoundary)
      then
    begin
      Orientation := dsoTop;
    end
    else
    begin
      Orientation := dso3D;
    end;
    // All the MODFLOW boundary conditions are evaluated at blocks.
    EvaluatedAt := eaBlocks;

    DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
    for Index := 0 to DataArrayManager.DataSetCount - 1 do
    begin
      DataSet := DataArrayManager.DataSets[Index];
      if not DataSet.Visible then
      begin
        Continue;
      end;
      if (EvaluatedAt = DataSet.EvaluatedAt) then
      begin
        if ((Orientation = dso3D)
          or (Orientation = DataSet.Orientation)) then
        begin
          Edit := FDataEdits[Index];
          // if the variable does not depend on the
          // data set whose formula is being edited
          // and it's orientation is OK, the variable
          // can be used in the formula.
          VariableList.Add(Edit.Variable);
        end;
      end;
    end;

    NewValue := DataGrid.Cells[ACol, ARow];
    if (NewValue = '') then
    begin
      NewValue := '0';
    end;

    with TfrmFormula.Create(self) do
    begin
      try
        IncludeGIS_Functions(eaBlocks);
        RemoveGetVCont;
        RemoveHufFunctions;
        PopupParent := self;

        // register the appropriate variables with the
        // parser.
        for Index := 0 to VariableList.Count - 1 do
        begin
          Variable := VariableList[Index];
          rbFormulaParser.RegisterVariable(Variable);
        end;

        // show the variables and functions
        UpdateTreeList;

        // put the formula in the TfrmFormula.
        Formula := NewValue;
        // The user edits the formula.
        ShowModal;
        if ResultSet then
        begin
          CreateBoundaryFormula(DataGrid, ACol, ARow, Formula, Orientation,
            EvaluatedAt);
        end;
      finally
        Free;
      end;
    end;

  finally
    VariableList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.frameChdParamdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreChdBoundary;
end;

procedure TfrmScreenObjectProperties.UpdateNonParamCheckBox(
  Frame: TframeScreenObjectParam; ParamCol, ACol, ARow: Integer;
  const Value: string);
begin
  if (Frame.clbParameters.Items.Count > 0)
    and (Frame.clbParameters.State[0] = cbUnchecked)
    and (ARow >= Frame.dgModflowBoundary.FixedRows)
    and (ACol >= 2) and (ACol < ParamCol) and (Value <> '') then
  begin
    Frame.clbParameters.Checked[0] := True;
  end;
end;

procedure TfrmScreenObjectProperties.frameChdParamdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateNodeState(FCHD_Node);
  frameChdParam.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateChdBoundary;
    StartParamCol := Item.ScreenObject.ModflowChdBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameChdParam, StartParamCol, ACol, ARow,Value);
  end;

  if not frameChdParam.dgModflowBoundary.DistributingText then
  begin
    StoreChdBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameChdParamseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameChdParam.seNumberOfTimesChange(Sender);
  StoreChdBoundary
end;

procedure TfrmScreenObjectProperties.frameCHOBrdgObservationGroupsSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  if IsLoaded then
  begin
    FChob_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameCHOBrdgObservationGroupsStateChange(
  Sender: TObject; ACol, ARow: Integer; const Value: TCheckBoxState);
begin
  inherited;
  if IsLoaded then
  begin
    FChob_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameDrnParamclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateNodeState(FDRN_Node);
  frameDrnParam.clbParametersStateChange(Sender, Index);
  StoreDrnBoundary;
end;

procedure TfrmScreenObjectProperties.frameDrnParamcomboFormulaInterpChange(
  Sender: TObject);
var
  Item: TScreenObjectEditItem;
begin
  inherited;
  UpdateNodeState(FDRN_Node);
  StoreDrnBoundary;
  Item := FNewProperties[0];
  AssignConductanceCaptions(frameDrnParam, Item.ScreenObject.ModflowDrnBoundary);
end;

procedure TfrmScreenObjectProperties.frameDrnParamdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreDrnBoundary
end;

procedure TfrmScreenObjectProperties.frameDrnParamdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateNodeState(FDRN_Node);
  frameDrnParam.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateDrnBoundary;
    StartParamCol := Item.ScreenObject.ModflowDrnBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameDrnParam, StartParamCol, ACol, ARow,Value);
  end;

  if not frameDrnParam.dgModflowBoundary.DistributingText then
  begin
    StoreDrnBoundary;
  end;

end;

procedure TfrmScreenObjectProperties.frameDrnParamseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameDrnParam.seNumberOfTimesChange(Sender);
  StoreDrnBoundary;
end;

procedure TfrmScreenObjectProperties.frameDROBrdgObservationGroupsSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  if IsLoaded then
  begin
    FDrob_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameDROBrdgObservationGroupsStateChange(
  Sender: TObject; ACol, ARow: Integer; const Value: TCheckBoxState);
begin
  inherited;
  if IsLoaded then
  begin
    FDrob_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameDrtParamclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateNodeState(FDRT_Node);
  frameDrtParam.clbParametersStateChange(Sender, Index);
  StoreDrtBoundary;
end;

procedure TfrmScreenObjectProperties.frameDrtParamcomboFormulaInterpChange(
  Sender: TObject);
var
  Item: TScreenObjectEditItem;
begin
  inherited;
  UpdateNodeState(FDRT_Node);
  StoreDrtBoundary;
  Item := FNewProperties[0];
  AssignConductanceCaptions(frameDrtParam, Item.ScreenObject.ModflowDrtBoundary);
end;

procedure TfrmScreenObjectProperties.frameDrtParamdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreDrtBoundary;
end;

procedure TfrmScreenObjectProperties.frameDrtParamdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateNodeState(FDRT_Node);
  frameDrtParam.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateDrtBoundary;
    StartParamCol := Item.ScreenObject.ModflowDrtBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameDrtParam, StartParamCol, ACol, ARow,Value);
  end;

  if not frameDrtParam.dgModflowBoundary.DistributingText then
  begin
    StoreDrtBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameDrtParamseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameDrtParam.seNumberOfTimesChange(Sender);
  StoreDrtBoundary
end;

procedure TfrmScreenObjectProperties.frameEtsParamclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateNodeState(FETS_Node);
  frameEtsParam.clbParametersStateChange(Sender, Index);
  StoreEtsBoundary;
end;

procedure TfrmScreenObjectProperties.frameEtsParamcomboFormulaInterpChange(
  Sender: TObject);
begin
  inherited;
  UpdateNodeState(FETS_Node);
  StoreEtsBoundary;
end;

procedure TfrmScreenObjectProperties.frameEtsParamdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreEtsBoundary;
end;

procedure TfrmScreenObjectProperties.frameEtsParamdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateNodeState(FETS_Node);
  frameEtsParam.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateEtsBoundary;
    StartParamCol := Item.ScreenObject.ModflowEtsBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameEtsParam, StartParamCol, ACol, ARow,Value);
  end;

  if not frameEtsParam.dgModflowBoundary.DistributingText then
  begin
    StoreEtsBoundary;  
  end;
end;

procedure TfrmScreenObjectProperties.frameEtsParamseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameEtsParam.seNumberOfTimesChange(Sender);
  StoreEtsBoundary;
end;

procedure TfrmScreenObjectProperties.frameEvtParamclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateNodeState(FEVT_Node);
  frameEvtParam.clbParametersStateChange(Sender, Index);
  StoreEvtBoundary;
end;

procedure TfrmScreenObjectProperties.frameEvtParamcomboFormulaInterpChange(
  Sender: TObject);
begin
  inherited;
  UpdateNodeState(FEVT_Node);
  StoreEvtBoundary;
end;

procedure TfrmScreenObjectProperties.frameEvtParamdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreEvtBoundary;
end;

procedure TfrmScreenObjectProperties.frameEvtParamdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateNodeState(FEVT_Node);
  frameEvtParam.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateEvtBoundary;
    StartParamCol := Item.ScreenObject.ModflowEvtBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameEvtParam, StartParamCol, ACol, ARow,Value);
  end;

  if not frameEvtParam.dgModflowBoundary.DistributingText then
  begin
    StoreEvtBoundary;  
  end;
end;

procedure TfrmScreenObjectProperties.frameEvtParamseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameEvtParam.seNumberOfTimesChange(Sender);
  StoreEvtBoundary;
end;

procedure TfrmScreenObjectProperties.frameGBOBrdgObservationGroupsSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  if IsLoaded then
  begin
    FGbob_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameGBOBrdgObservationGroupsStateChange(
  Sender: TObject; ACol, ARow: Integer; const Value: TCheckBoxState);
begin
  inherited;
  if IsLoaded then
  begin
    FGbob_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameGhbParamclbParametersStateChange(
  Sender: TObject; Index: Integer);
begin
  inherited;
  UpdateNodeState(FGHB_Node);
  frameGhbParam.clbParametersStateChange(Sender, Index);
  StoreGhbBoundary;
end;

procedure TfrmScreenObjectProperties.frameGhbParamcomboFormulaInterpChange(
  Sender: TObject);
var
  Item: TScreenObjectEditItem;
begin
  inherited;
  UpdateNodeState(FGHB_Node);
  StoreGhbBoundary;
  Item := FNewProperties[0];
  AssignConductanceCaptions(frameGhbParam, Item.ScreenObject.ModflowGhbBoundary);
end;

procedure TfrmScreenObjectProperties.frameGhbParamdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreGhbBoundary;
end;

procedure TfrmScreenObjectProperties.frameGhbParamdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  Item: TScreenObjectEditItem;
  StartParamCol: Integer;
begin
  inherited;
  UpdateNodeState(FGHB_Node);
  frameGhbParam.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);

  if (FNewProperties <> nil) and (FNewProperties.Count > 0) then
  begin
    Item := FNewProperties[0];
    Item.ScreenObject.CreateGhbBoundary;
    StartParamCol := Item.ScreenObject.ModflowGhbBoundary.NonParameterColumns;
    UpdateNonParamCheckBox(frameGhbParam, StartParamCol, ACol, ARow,Value);
  end;

  if not frameGhbParam.dgModflowBoundary.DistributingText then
  begin
    StoreGhbBoundary;  
  end;
end;

procedure TfrmScreenObjectProperties.frameGhbParamseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameGhbParam.seNumberOfTimesChange(Sender);
  StoreGhbBoundary;
end;

procedure TfrmScreenObjectProperties.frameHeadObservationsrdgHeadsSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  frameHeadObservations.rdgObservationsSetEditText(Sender, ACol, ARow, Value);
  UpdateNodeState(FHOB_Node);
end;

procedure TfrmScreenObjectProperties.frameHeadObservationsseTimesChange(
  Sender: TObject);
begin
  inherited;
  frameHeadObservations.seTimesChange(Sender);
  if frameHeadObservations.seTimes.asInteger = 0 then
  begin
    if IsLoaded  and (FHOB_Node <> nil) then
    begin
      if FHOB_Node.StateIndex = 2 then
      begin
        FHOB_Node.StateIndex := 1;
      end;
    end;
  end
  else
  begin
    UpdateNodeState(FHOB_Node);
  end;
end;

procedure TfrmScreenObjectProperties.frameHfbBoundarybtnEditHfbHydraulicConductivityFormulaClick(
  Sender: TObject);
begin
  inherited;
  AssignHfbFormulas(frameHfbBoundary.edHydraulicConductivity);
end;

procedure TfrmScreenObjectProperties.frameHfbBoundarybtnEditHfbThicknessyFormulaClick(
  Sender: TObject);
begin
  inherited;
  AssignHfbFormulas(frameHfbBoundary.edBarrierThickness);
end;

procedure TfrmScreenObjectProperties.frameHydmodclbBasicClickCheck(
  Sender: TObject);
begin
  inherited;
  UpdateNodeState(FHydmod_Node);
end;

procedure TfrmScreenObjectProperties.frameHydmodclbSFRClickCheck(
  Sender: TObject);
begin
  inherited;
  frameHydmod.clbSFRClickCheck(Sender);
  UpdateNodeState(FHydmod_Node);

end;

procedure TfrmScreenObjectProperties.frameHydmodclbSubClickCheck(
  Sender: TObject);
begin
  inherited;
  UpdateNodeState(FHydmod_Node);

end;

procedure TfrmScreenObjectProperties.frameHydmodcomboLayerGroupChange(
  Sender: TObject);
begin
  inherited;
  frameHydmod.comboLayerGroupChange(Sender);

end;

procedure TfrmScreenObjectProperties.frameHydmodcomboNoDelayBedChange(
  Sender: TObject);
begin
  inherited;
  frameHydmod.comboNoDelayBedChange(Sender);

end;

procedure TfrmScreenObjectProperties.frameIfacerbHorizontalClick(
  Sender: TObject);
var
  Index: Integer;
  Item: TScreenObjectEditItem;
  RadioButton: TRadioButton;
begin
  inherited;
  if IsLoaded then
  begin
    RadioButton := Sender as TRadioButton;
    if RadioButton.Checked then
    begin
      frameIface.IFACE := TIface(RadioButton.Tag + 2);
    end;
    if frameIface.IFACE <> iIndeterminant then
    begin
      for Index := 0 to FNewProperties.Count - 1 do
      begin
        Item := FNewProperties[Index];
        Item.ScreenObject.IFACE := frameIface.IFACE;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.frameLakcbGagDeltaClick(Sender: TObject);
begin
  inherited;
  frameLak.cbGagDeltaClick(frameLak.cbGagDelta);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakcbGage4Click(Sender: TObject);
begin
  inherited;
  frameLak.cbGage4Click(frameLak.cbGage4);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakcbGagFluxAndCondClick(
  Sender: TObject);
begin
  inherited;
  frameLak.cbGagFluxAndCondClick(frameLak.cbGagFluxAndCond);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakcbGagStandardClick(
  Sender: TObject);
begin
  inherited;
  frameLak.cbGagStandardClick(frameLak.cbGagStandard);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  UpdateNodeState(FLAK_Node);
  frameLak.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);
  if not frameLak.dgModflowBoundary.DistributingText then
  begin
    StoreLakBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameLakfeLakeBathymetryChange(
  Sender: TObject);
begin
  inherited;
  UpdateNodeState(FLAK_Node);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakrdeCenterLakeChange(
  Sender: TObject);
begin
  inherited;
  frameLak.rdeCenterLakeChange(Sender);
  UpdateNodeState(FLAK_Node);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakrdeInitialStageChange(
  Sender: TObject);
begin
  inherited;
  UpdateNodeState(FLAK_Node);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakrdeLakeIDChange(Sender: TObject);
begin
  inherited;
  UpdateNodeState(FLAK_Node);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakrdeSillChange(Sender: TObject);
begin
  inherited;
  UpdateNodeState(FLAK_Node);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakrdgLakeTableEndUpdate(
  Sender: TObject);
begin
  inherited;

  if IsLoaded then
  begin
    UpdateNodeState(FLAK_Node);
    StoreLakBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameLakrgBathChoiceClick(Sender: TObject);
begin
  inherited;
  UpdateNodeState(FLAK_Node);
  frameLak.rgBathChoiceClick(Sender);
  StoreLakBoundary;
end;

procedure TfrmScreenObjectProperties.frameLakseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameLak.seNumberOfTimesChange(Sender);
  StoreLakBoundary;
end;


procedure TfrmScreenObjectProperties.frameMNW2pcMnw2Change(Sender: TObject);
begin
  inherited;
  HelpKeyWord := frameMNW2.pcMnw2.ActivePage.HelpKeyword;
  btnHelp.HelpKeyword := HelpKeyWord;
end;

procedure TfrmScreenObjectProperties.frameModpathParticlescbLeftFaceClick(
  Sender: TObject);
begin
  inherited;
  if IsLoaded then
  begin
    (Sender as TCheckBox).AllowGrayed := False;
    frameModpathParticles.CreateParticles;
    StoreModPath;
  end;
end;
//
procedure TfrmScreenObjectProperties.frameModpathParticlesgbParticlesCheckBoxClick(
  Sender: TObject);
var
  Check: TCheckBox;
  Index: Integer;
  GB: TJvGroupBox;
begin
  inherited;
  GB := frameModpathParticles.gbParticles;
  GB.Handle;
  Check := GB.Components[0] as TCheckBox;
  for Index := 0 to GB.ControlCount - 1 do
  begin
    if GB.Controls[Index] <> Check then
    begin
      GB.Controls[Index].Enabled := Check.State <> cbUnChecked;
    end;
  end;
  if IsLoaded then
  begin
    Check.AllowGrayed := False;
    frameModpathParticles.CreateParticles;
    StoreModPath;
  end;
end;

procedure TfrmScreenObjectProperties.frameModpathParticlesrdgSpecificSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  if IsLoaded then
  begin
    frameModpathParticles.CreateParticles;
    StoreModPath;
  end;
end;

procedure TfrmScreenObjectProperties.StoreModPath;
var
  Index: Integer;
  Item: TScreenObjectEditItem;
  ScreenObject: TScreenObject;
  Particles: TParticleStorage;
  GridParticles: TGridDistribution;
  CylinderParticles: TCylSphereDistribution;
  SphereParticles: TCylSphereDistribution;
  CustomParticles: TParticles;
  RowIndex: Integer;
  Grid: TRbwDataGrid4;
  X: double;
  Y: double;
  Z: double;
  ParticleItem: TParticleLocation;
  TimeItem: TModpathTimeItem;
  DeleteRowList: TIntegerList;
  Time: double;
  RowAdded: Boolean;
  CheckBox: TCheckBox;
begin
  if IsLoaded  and (FNewProperties <> nil) then
  begin
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      ScreenObject := Item.ScreenObject;
      Particles := ScreenObject.ModpathParticles;
      CheckBox := frameModpathParticles.gbParticles.Components[0] as TCheckBox;
      case CheckBox.State of
        cbUnchecked: Particles.Used := False;
        cbChecked: Particles.Used := True;
        cbGrayed: ; // do nothing
        else Assert(False);
      end;
      if Particles.Used then
      begin
        if frameModpathParticles.rgChoice.ItemIndex >= 0 then
        begin
          Particles.ParticleDistribution :=
            TParticleDistribution(frameModpathParticles.rgChoice.ItemIndex);
        end;
        case Particles.ParticleDistribution of
          pdGrid:
            begin
              GridParticles := Particles.GridParticles;
              if frameModpathParticles.cbLeftFace.State <> cbGrayed then
              begin
                GridParticles.LeftFace :=
                  frameModpathParticles.cbLeftFace.Checked;
              end;
              if frameModpathParticles.cbRightFace.State <> cbGrayed then
              begin
                GridParticles.RightFace :=
                  frameModpathParticles.cbRightFace.Checked;
              end;
              if frameModpathParticles.cbBackFace.State <> cbGrayed then
              begin
                GridParticles.BackFace :=
                  frameModpathParticles.cbBackFace.Checked;
              end;
              if frameModpathParticles.cbFrontFace.State <> cbGrayed then
              begin
                GridParticles.FrontFace :=
                  frameModpathParticles.cbFrontFace.Checked;
              end;
              if frameModpathParticles.cbBottomFace.State <> cbGrayed then
              begin
                GridParticles.BottomFace :=
                  frameModpathParticles.cbBottomFace.Checked;
              end;
              if frameModpathParticles.cbTopFace.State <> cbGrayed then
              begin
                GridParticles.TopFace :=
                  frameModpathParticles.cbTopFace.Checked;
              end;
              if frameModpathParticles.cbInternal.State <> cbGrayed then
              begin
                GridParticles.Internal :=
                  frameModpathParticles.cbInternal.Checked;
              end;
              if frameModpathParticles.seX.AsInteger > 0 then
              begin
                GridParticles.XCount := frameModpathParticles.seX.AsInteger;
              end;
              if frameModpathParticles.seY.AsInteger > 0 then
              begin
                GridParticles.YCount := frameModpathParticles.seY.AsInteger;
              end;
              if frameModpathParticles.seZ.AsInteger > 0 then
              begin
                GridParticles.ZCount := frameModpathParticles.seZ.AsInteger;
              end;
            end;
          pdCylinder:
            begin
              CylinderParticles := Particles.CylinderParticles;
              if frameModpathParticles.rgCylinderOrientation.ItemIndex >= 0 then
              begin
                CylinderParticles.Orientation :=
                  TParticleGroupOrientation(frameModpathParticles.
                  rgCylinderOrientation.ItemIndex);
              end;
              if frameModpathParticles.seCylParticleCount.AsInteger > 0 then
              begin
                CylinderParticles.CircleParticleCount :=
                  frameModpathParticles.seCylParticleCount.AsInteger;
              end;
              if frameModpathParticles.seCylLayerCount.AsInteger > 0 then
              begin
                CylinderParticles.LayerCount :=
                  frameModpathParticles.seCylLayerCount.AsInteger;
              end;
              if frameModpathParticles.seCylRadius.Value > 0 then
              begin
                CylinderParticles.Radius :=
                  frameModpathParticles.seCylRadius.Value;
              end;
            end;
          pdSphere:
            begin
              SphereParticles := Particles.SphereParticles;
              if frameModpathParticles.rgSphereOrientation.ItemIndex >= 0 then
              begin
                SphereParticles.Orientation :=
                  TParticleGroupOrientation(frameModpathParticles.
                  rgSphereOrientation.ItemIndex);
              end;
              if frameModpathParticles.seSphereParticleCount.AsInteger > 0 then
              begin
                SphereParticles.CircleParticleCount :=
                  frameModpathParticles.seSphereParticleCount.AsInteger;
              end;
              if frameModpathParticles.seSphereLayerCount.AsInteger > 0 then
              begin
                SphereParticles.LayerCount :=
                  frameModpathParticles.seSphereLayerCount.AsInteger;
              end;
              if frameModpathParticles.seSphereRadius.Value > 0 then
              begin
                SphereParticles.Radius :=
                  frameModpathParticles.seSphereRadius.Value;
              end;
            end;
          pdIndividual:
            begin
              if frameModpathParticles.seSpecificParticleCount.AsInteger > 0 then
              begin
                CustomParticles := Particles.CustomParticles;
                Grid := frameModpathParticles.rdgSpecific;
                DeleteRowList := TIntegerList.Create;
                try
                  for RowIndex := 1 to Grid.RowCount -1 do
                  begin
                    RowAdded := False;
                    while RowIndex-1 >= CustomParticles.Count do
                    begin
                      CustomParticles.Add;
                      RowAdded := True;
                    end;
                  
                    if TryStrToFloat(Grid.Cells[1,RowIndex], X)
                      and TryStrToFloat(Grid.Cells[2,RowIndex], Y)
                      and TryStrToFloat(Grid.Cells[3,RowIndex], Z) then
                    begin
                      ParticleItem := CustomParticles.Items[RowIndex-1] as TParticleLocation;
                      ParticleItem.X := X;
                      ParticleItem.Y := Y;
                      ParticleItem.Z := Z;
                    end
                    else if RowAdded then
                    begin
                      DeleteRowList.Add(RowIndex);
                    end;
                  end;
                  for RowIndex := DeleteRowList.Count - 1 downto 0 do
                  begin
                    CustomParticles.Delete(DeleteRowList[RowIndex]-1);
                  end;
                finally
                  DeleteRowList.Free;
                end;
              end;
            end;
          else Assert(False);
        end;
        if frameModpathParticles.seTimeCount.AsInteger >= 1 then
        begin
          DeleteRowList := TIntegerList.Create;
          try
            for RowIndex := 0 to frameModpathParticles.seTimeCount.AsInteger - 1 do
            begin
              RowAdded := False;
              while Particles.ReleaseTimes.Count <= RowIndex do
              begin
                Particles.ReleaseTimes.Add;
                RowAdded := True;
              end;
              TimeItem := Particles.ReleaseTimes.Items[RowIndex] as TModpathTimeItem;
              if tryStrToFloat(frameModpathParticles.rdgReleaseTimes.Cells[1,RowIndex+1], Time) then
              begin
                TimeItem.Time := Time;
              end
              else if RowAdded then
              begin
                DeleteRowList.Add(RowIndex);
              end;
            end;
            for RowIndex :=  DeleteRowList.Count - 1 downto 0 do
            begin
              Particles.ReleaseTimes.Delete(DeleteRowList[RowIndex]);
            end;
          finally
            DeleteRowList.Free
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.frameModpathParticlesrgChoiceClick(
  Sender: TObject);
begin
  inherited;
  if frameModpathParticles.rgChoice.ItemIndex >= 0 then
  begin
    frameModpathParticles.plParticlePlacement.ActivePageIndex :=
      frameModpathParticles.rgChoice.ItemIndex;
    if IsLoaded then
    begin
      frameModpathParticles.CreateParticles;
    end;
  end
  else
  begin
    frameModpathParticles.plParticlePlacement.ActivePage
      := frameModpathParticles.jvspBlank;
  end;
  StoreModPath;
end;

procedure TfrmScreenObjectProperties.frameModpathParticlesrgCylinderOrientationClick(
  Sender: TObject);
begin
  inherited;
  if isLoaded then
  begin
    frameModpathParticles.CreateParticles;
    StoreModPath;
  end;
end;

procedure TfrmScreenObjectProperties.frameModpathParticlesseCylRadiusClick(
  Sender: TObject);
begin
  inherited;
  if IsLoaded then
  begin
    frameModpathParticles.CreateParticles;
    StoreModPath;
  end;
end;

procedure TfrmScreenObjectProperties.frameModpathParticlesseSpecificParticleCountChange(
  Sender: TObject);
begin
  inherited;
  frameModpathParticles.UpdateRowCount;
  frameModpathParticles.seSpecificParticleCount.MinValue := 0;
  frameModpathParticles.CreateParticles;
  if IsLoaded then
  begin
    StoreModPath;
  end;
end;

procedure TfrmScreenObjectProperties.frameModpathParticlesseTimeCountChange(
  Sender: TObject);
begin
  inherited;
  if IsLoaded then
  begin
    frameModpathParticles.UpdateTimeRowCount;
    frameModpathParticles.seTimeCount.MinValue := 1;
    StoreModPath;
  end;
end;

procedure TfrmScreenObjectProperties.frameModpathParticlesseXChange(
  Sender: TObject);
begin
  inherited;
  if IsLoaded then
  begin
    if Sender = frameModpathParticles.seSphereLayerCount then
    begin
      frameModpathParticles.seSphereLayerCount.MinValue := 2;
    end
    else
    begin
      (Sender as TJvSpinEdit).MinValue := 1;
    end;
    frameModpathParticles.CreateParticles;
    StoreModPath;
  end;
end;

procedure TfrmScreenObjectProperties.frameMT3DMScbMassLoadingClick(
  Sender: TObject);
begin
  inherited;
  frameMT3DMS_SSM.cbMassLoadingClick(Sender);
  StoreMt3dmsChemBoundary;
end;

procedure TfrmScreenObjectProperties.frameMT3DMScbSpecifiedConcentrationClick(
  Sender: TObject);
begin
  inherited;
  frameMT3DMS_SSM.cbSpecifiedConcentrationClick(Sender);
  StoreMt3dmsChemBoundary;
end;

procedure TfrmScreenObjectProperties.frameMT3DMSdgModflowBoundaryEndUpdate(
  Sender: TObject);
begin
  inherited;
  StoreMt3dmsChemBoundary;
end;

procedure TfrmScreenObjectProperties.frameMT3DMSdgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  UpdateNodeState(FMt3dmsSsm_Node);
  frameMT3DMS_SSM.dgModflowBoundarySetEditText(Sender, ACol, ARow, Value);
    if not frameMT3DMS_SSM.dgModflowBoundary.DistributingText then
  begin
    StoreMt3dmsChemBoundary;
  end;
end;

procedure TfrmScreenObjectProperties.frameMt3dmsFluxObsrdgObservationGroupsSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  if IsLoaded then
  begin
    FMt3dmsTobFlux_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameMt3dmsFluxObsrdgObservationGroupsStateChange(
  Sender: TObject; ACol, ARow: Integer; const Value: TCheckBoxState);
begin
  inherited;
  if IsLoaded then
  begin
    FMt3dmsTobFlux_Node.StateIndex := 2;
  end;
end;

procedure TfrmScreenObjectProperties.frameMT3DMSseNumberOfTimesChange(
  Sender: TObject);
begin
  inherited;
  frameMT3DMS_SSM.seNumberOfTimesChange(Sender);
  StoreMt3dmsChemBoundary;
end;

procedure TfrmScreenObjectProperties.frameMt3dmsTobConcrdgObservationsSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  frameMt3dmsTobConc.rdgObservationsSetEditText(Sender, ACol, ARow, Value);
  UpdateNodeState(FMt3dmsTobConc_Node);
end;

procedure TfrmScreenObjectProperties.frameMt3dmsTobConcseTimesChange(
  Sender: TObject);
begin
  inherited;
  frameMt3dmsTobConc.seTimesChange(Sender);
  if frameMt3dmsTobConc.seTimes.asInteger = 0 then
  begin
    if IsLoaded  and (FMt3dmsTobConc_Node <> nil) then
    begin
      if FMt3dmsTobConc_Node.StateIndex = 2 then
      begin
        FMt3dmsTobConc_Node.StateIndex := 1;
      end;
    end;
  end
  else
  begin
    UpdateNodeState(FMt3dmsTobConc_Node);
  end;
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationBoundariescbPhastInterpolationClick(Sender: TObject);
var
  Index: integer;
  InterpValuesCollection: TInterpValuesCollection;
  InterpValuesItem: TInterpValuesItem;
begin
  inherited;
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  framePhastInterpolationBoundaries.cbPhastInterpolationClick(Sender);
  FBoundaryGrid.Checked[FBoundaryCol, FBoundaryRow] :=
    framePhastInterpolationBoundaries.cbPhastInterpolation.Checked;
  InterpValuesCollection := FBoundaryGrid.Objects[FBoundaryCol, FBoundaryRow] as
    TInterpValuesCollection;
  if (InterpValuesCollection <> nil)  then
  begin
    for Index := 0 to InterpValuesCollection.Count - 1 do
    begin
      InterpValuesItem := InterpValuesCollection.Items[Index] as
        TInterpValuesItem;
      InterpValuesItem.Values.UsePHAST_Interpolation :=
        framePhastInterpolationBoundaries.cbPhastInterpolation.Checked;
    end;
    if framePhastInterpolationBoundaries.cbPhastInterpolation.Checked then
    begin
      framePhastInterpolationData.AssigningValues := True;
      framePhastInterpolationBoundaries.GetFirstData((InterpValuesCollection.
        Items[0] as TInterpValuesItem).Values);
      framePhastInterpolationData.AssigningValues := False;
      for Index := 1 to InterpValuesCollection.Count - 1 do
      begin
        framePhastInterpolationData.AssigningValues := True;
        framePhastInterpolationBoundaries.GetMoreData((InterpValuesCollection.
          Items[Index] as TInterpValuesItem).Values);
        framePhastInterpolationData.AssigningValues := False;
      end;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.StorePhastLeakyBoundary;
var
  Item: TScreenObjectEditItem;
  LeakyBoundary: TLeakyBoundary;
  DataGrid: TRbwDataGrid4;
  Boundary: TCustomInterpolatedBoundary;
begin
  if IsLoaded then
  begin
    Assert(FNewProperties.Count = 1);
    Assert(comboSolutionType.ItemIndex >= 0);
    Item := FNewProperties.Items[0];
    LeakyBoundary := Item.ScreenObject.LeakyBoundary;
    LeakyBoundary.Clear;

    LeakyBoundary.Model := frmGoPhast.PhastModel;
    try
      LeakyBoundary.HydraulicConductivity := edLeakyHydraulicConductivity.Text;
      LeakyBoundary.Thickness := edLeakyThickness.Text;
    finally
      LeakyBoundary.Model := nil;
    end;

    Boundary := LeakyBoundary;
    DataGrid := dgBoundaryLeaky;
    StoreInterpolatedBoundary(Boundary, DataGrid);
  end;
end;

procedure TfrmScreenObjectProperties.StorePhastSpecifiedFlux;
var
  Item: TScreenObjectEditItem;
  FluxBoundary: TFluxBoundary;
  DataGrid: TRbwDataGrid4;
  Boundary: TCustomInterpolatedBoundary;
begin
  if IsLoaded then
  begin
    Assert(FNewProperties.Count = 1);
    Item := FNewProperties.Items[0];
    FluxBoundary := Item.ScreenObject.FluxBoundary;
    FluxBoundary.Clear;

    Boundary := FluxBoundary;
    DataGrid := dgBoundaryFlux;
    StoreInterpolatedBoundary(Boundary, DataGrid);
  end;
end;

procedure TfrmScreenObjectProperties.StorePhastRiverBoundary;
var
  Item: TScreenObjectEditItem;
  RiverBoundary: TRiverBoundary;
  DataGrid: TRbwDataGrid4;
  Boundary: TCustomInterpolatedBoundary;
begin
  if IsLoaded then
  begin
    Assert(FNewProperties.Count = 1);
    Item := FNewProperties.Items[0];
    RiverBoundary := Item.ScreenObject.RiverBoundary;
    RiverBoundary.Clear;

    RiverBoundary.Model := frmGoPhast.PhastModel;
    try
      RiverBoundary.BedHydraulicConductivity :=
        edRiverHydraulicConductivity.Text;
      RiverBoundary.BedThickness := edRiverBedThickness.Text;
      RiverBoundary.Depth := edRiverDepth.Text;
      RiverBoundary.Width := edRiverWidth.Text;
      RiverBoundary.Description := edRiverDescripton.Text;
    finally
      RiverBoundary.Model := nil;
    end;

    Boundary := RiverBoundary;
    DataGrid := dgBoundaryRiver;
    StoreNonInterpolatedBoundary(Boundary, DataGrid);
  end;
end;

procedure TfrmScreenObjectProperties.StorePhastWellBoundary;
var
  Item: TScreenObjectEditItem;
  WellBoundary: TWellBoundary;
  DataGrid: TRbwDataGrid4;
  Boundary: TCustomInterpolatedBoundary;
  NewValue: Extended;
  FirstElevation: Extended;
  Index: Integer;
  SecondElevation: Extended;
  WellInterval: TWellInterval;
begin
  if IsLoaded then
  begin
    Assert(FNewProperties.Count = 1);
    Item := FNewProperties.Items[0];
    WellBoundary := Item.ScreenObject.WellBoundary;
    WellBoundary.Clear;

    WellBoundary.Model := frmGoPhast.PhastModel;
    try
      WellBoundary.AllocateByPressureAndMobility :=
        cbWellPumpAllocation.Checked;
      WellBoundary.Description := edWellDescription.Text;
      if TryStrToFloat(rdeWellDiameter.Text, NewValue) then
      begin
        WellBoundary.Diameter := NewValue;
      end;
      if TryStrToFloat(rdeWellLandSurfaceDatum.Text, NewValue) then
      begin
        WellBoundary.LandSurfaceDatum := NewValue;
      end;
      if comboWellIntervalStyle.ItemIndex >= 0 then
      begin
        WellBoundary.WellElevationFormat :=
          TWellElevationFormat(comboWellIntervalStyle.ItemIndex);
      end;

      for Index := 1 to dgWellElevations.RowCount - 1 do
      begin
        if (dgWellElevations.Cells[Ord(wicFirst), Index] <> '')
        and (dgWellElevations.Cells[Ord(wicSecond), Index] <> '') then
        begin
          if not TryStrToFloat(dgWellElevations.Cells[Ord(wicFirst),
              Index], FirstElevation) then
          begin
            Continue;
          end;

          if not TryStrToFloat(dgWellElevations.Cells[Ord(wicSecond),
              Index], SecondElevation) then
          begin
            Continue;
          end;

          WellInterval := WellBoundary.Intervals.Add as TWellInterval;
          WellInterval.FirstElevation := FirstElevation;
          WellInterval.SecondElevation := SecondElevation;
        end;
      end
    finally
      WellBoundary.Model := nil;
    end;

    Boundary := WellBoundary;
    DataGrid := dgWell;
    StoreNonInterpolatedBoundary(Boundary, DataGrid);
  end;
end;

procedure TfrmScreenObjectProperties.StorePhastSpecifiedHeads;
var
  Item: TScreenObjectEditItem;
  HeadBoundary: TSpecifiedHeadBoundary;
  DataGrid: TRbwDataGrid4;
  Boundary: TCustomInterpolatedBoundary;
begin
  if IsLoaded then
  begin
    Assert(FNewProperties.Count = 1);
    Assert(comboSolutionType.ItemIndex >= 0);
    Item := FNewProperties.Items[0];
    HeadBoundary := Item.ScreenObject.SpecifiedHeadBoundary;
    HeadBoundary.Clear;

    HeadBoundary.Model := frmGoPhast.PhastModel;
    try
      HeadBoundary.SolutionType := TSolutionType(
        comboSolutionType.ItemIndex);
    finally
      HeadBoundary.Model := nil;
    end;

    Boundary := HeadBoundary;
    DataGrid := dgSpecifiedHead;
    StoreInterpolatedBoundary(Boundary, DataGrid);
  end;
end;

procedure TfrmScreenObjectProperties.dgBoundaryStateChanged(
  Sender: TObject; ACol, ARow: Integer; const Value: TCheckBoxState);
var
  Index: integer;
  InterpValuesCollection: TInterpValuesCollection;
  CanSelectDummy: boolean;
  StoredAssigningValues: boolean;
begin
  inherited;
    // update the displayed PHAST-style Interpolation when the use clicks one of the
    // check boxes in a boundary table.
  if not IsLoaded then
    Exit;
  StoredAssigningValues := framePhastInterpolationData.AssigningValues;
  framePhastInterpolationData.AssigningValues := True;
  framePhastInterpolationBoundaries.cbPhastInterpolation.Checked :=
    (Sender as TRbwDataGrid4).Checked[ACol, ARow];
  framePhastInterpolationBoundaries.cbPhastInterpolationClick(nil);
  framePhastInterpolationData.AssigningValues := StoredAssigningValues;
  InterpValuesCollection := (Sender as TRbwDataGrid4).Objects[ACol, ARow] as
    TInterpValuesCollection;

  if framePhastInterpolationBoundaries.cbPhastInterpolation.Checked then
  begin
    if InterpValuesCollection <> nil then
    begin
      (InterpValuesCollection.
        Items[0] as TInterpValuesItem).Values.UsePHAST_Interpolation := True;
      framePhastInterpolationData.AssigningValues := True;
      framePhastInterpolationBoundaries.GetFirstData((InterpValuesCollection.
        Items[0] as TInterpValuesItem).Values);
      framePhastInterpolationData.AssigningValues := False;
      for Index := 1 to InterpValuesCollection.Count - 1 do
      begin
        framePhastInterpolationData.AssigningValues := True;
        framePhastInterpolationBoundaries.GetMoreData((InterpValuesCollection.
          Items[Index] as TInterpValuesItem).Values);
        framePhastInterpolationData.AssigningValues := False;
      end;
    end;

    CanSelectDummy := False;
    dgBoundarySelectCell(Sender, ACol, ARow, CanSelectDummy);

  end;
  StorePhastBoundary;
end;

procedure TfrmScreenObjectProperties.dgSpecifiedHeadDistributeTextProgress(
  Sender: TObject; Position, Max: Integer);
begin
  inherited;
  seBoundaryTimes.AsInteger := dgSpecifiedHead.RowCount -1;
  seBoundaryTimesChange(nil);
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationBoundariesrgInterpolationDirectionClick(
  Sender: TObject);
var
  Index: integer;
  InterpValuesCollection: TInterpValuesCollection;
  InterpValuesItem: TInterpValuesItem;
begin
  inherited;
    // respond the the user clicking on the interpolation direction radio
    // buttons for a boundary condition.
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  framePhastInterpolationBoundaries.rgInterpolationDirectionClick(Sender);
  InterpValuesCollection := FBoundaryGrid.Objects[FBoundaryCol, FBoundaryRow] as
    TInterpValuesCollection;
  if InterpValuesCollection <> nil then
  begin
    for Index := 0 to InterpValuesCollection.Count - 1 do
    begin
      InterpValuesItem := InterpValuesCollection.Items[Index] as
        TInterpValuesItem;
      InterpValuesItem.Values.InterpolationDirection :=
        TInterpolationDirection(framePhastInterpolationBoundaries.
        rgInterpolationDirection.ItemIndex);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationBoundariesrdeDistance1Exit(Sender: TObject);
var
  Index: integer;
  InterpValuesCollection: TInterpValuesCollection;
  InterpValuesItem: TInterpValuesItem;
begin
  inherited;
    // Respond to the user finishing editing the PHAST-style Interpolation Distance 1
    // for a boundary condition.
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  InterpValuesCollection := FBoundaryGrid.Objects[FBoundaryCol, FBoundaryRow] as
    TInterpValuesCollection;
  for Index := 0 to InterpValuesCollection.Count - 1 do
  begin
    InterpValuesItem := InterpValuesCollection.Items[Index] as
      TInterpValuesItem;
    InterpValuesItem.Values.Distance1 :=
      StrToFloat(framePhastInterpolationBoundaries.rdeDistance1.Text);
  end;
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationBoundariesrdeDistance2Exit(Sender: TObject);
var
  Index: integer;
  InterpValuesCollection: TInterpValuesCollection;
  InterpValuesItem: TInterpValuesItem;
begin
  inherited;
    // Respond to the user finishing editing the PHAST-style Interpolation Distance 2
    // for a boundary condition.
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  InterpValuesCollection := FBoundaryGrid.Objects[FBoundaryCol, FBoundaryRow] as
    TInterpValuesCollection;
  for Index := 0 to InterpValuesCollection.Count - 1 do
  begin
    InterpValuesItem := InterpValuesCollection.Items[Index] as
      TInterpValuesItem;
    InterpValuesItem.Values.Distance2 :=
      StrToFloat(framePhastInterpolationBoundaries.rdeDistance2.Text);
  end;
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationBoundariesrdeValue1Exit(Sender: TObject);
var
  Index: integer;
  InterpValuesCollection: TInterpValuesCollection;
  InterpValuesItem: TInterpValuesItem;
begin
  inherited;
    // Respond to the user finishing editing the PHAST-style Interpolation value 1
    // for a boundary condition.
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  InterpValuesCollection := FBoundaryGrid.Objects[FBoundaryCol, FBoundaryRow] as
    TInterpValuesCollection;
  for Index := 0 to InterpValuesCollection.Count - 1 do
  begin
    InterpValuesItem := InterpValuesCollection.Items[Index] as
      TInterpValuesItem;
    if framePhastInterpolationBoundaries.rdeValue1.DataType = dtInteger then
    begin
      InterpValuesItem.Values.IntValue1 :=
        StrToInt(framePhastInterpolationBoundaries.rdeValue1.Text);
    end
    else if framePhastInterpolationBoundaries.rdeValue1.DataType = dtReal then
    begin
      InterpValuesItem.Values.RealValue1 :=
        StrToFloat(framePhastInterpolationBoundaries.rdeValue1.Text);
    end
    else
    begin
      Assert(False);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationBoundariesrdeValue2Exit(Sender: TObject);
var
  Index: integer;
  InterpValuesCollection: TInterpValuesCollection;
  InterpValuesItem: TInterpValuesItem;
begin
  inherited;
    // Respond to the user finishing editing the PHAST-style Interpolation value 2
    // for a boundary condition.
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  InterpValuesCollection := FBoundaryGrid.Objects[FBoundaryCol, FBoundaryRow] as
    TInterpValuesCollection;
  for Index := 0 to InterpValuesCollection.Count - 1 do
  begin
    InterpValuesItem := InterpValuesCollection.Items[Index] as
      TInterpValuesItem;
    if framePhastInterpolationBoundaries.rdeValue2.DataType = dtInteger then
    begin
      InterpValuesItem.Values.IntValue2 :=
        StrToInt(framePhastInterpolationBoundaries.rdeValue2.Text);
    end
    else if framePhastInterpolationBoundaries.rdeValue2.DataType = dtReal then
    begin
      InterpValuesItem.Values.RealValue2 :=
        StrToFloat(framePhastInterpolationBoundaries.rdeValue2.Text);
    end
    else
    begin
      Assert(False);
    end;
  end;
end;

procedure TfrmScreenObjectProperties.dgBoundaryButtonClick(
  Sender: TObject; ACol, ARow: Integer);
var
  VariableList: TList;
  Orientation: TDataSetOrientation;
  DataGrid: TRbwDataGrid4;
  EvaluatedAt: TEvaluatedAt;
  Index: integer;
  DataSet: TDataArray;
  NewValue: string;
  Variable: TCustomValue;
  Edit: TScreenObjectDataEdit;
  DataArrayManager: TDataArrayManager;
begin
  inherited;
  DataGrid := Sender as TRbwDataGrid4;
  VariableList := TList.Create;
  // VariableList will hold a list of variables that can
  // be used in the function
  try
    // get the orientation of the data set.
    if (DataGrid = dgSpecifiedHead) or {(DataGrid = dgSpecifiedSolution) or}
    (DataGrid = dgBoundaryFlux) or (DataGrid = dgBoundaryLeaky) then
    begin
      Orientation := dso3D;
    end
    else if (DataGrid = dgBoundaryRiver) or (DataGrid = dgWell) then
    begin
      Orientation := dsoTop;
    end
    else
    begin
      Assert(False);
      Orientation := dso3D;
    end;
    // All the PHAST boundary conditions are evaluated at nodes.
    EvaluatedAt := eaNodes;

    DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
    for Index := 0 to DataArrayManager.DataSetCount - 1 do
    begin
      DataSet := DataArrayManager.DataSets[Index];
      if not DataSet.Visible then
      begin
        Continue;
      end;
      if (EvaluatedAt = DataSet.EvaluatedAt) then
      begin
        if ((Orientation = dso3D)
          or (Orientation = DataSet.Orientation)) then
        begin
          Edit := FDataEdits[Index];
          // if the variable does not depend on the
          // data set whose formula is being edited
          // and it's orientation is OK, the variable
          // can be used in the formula.
          VariableList.Add(Edit.Variable);
        end;
      end;
    end;

    NewValue := DataGrid.Cells[ACol, ARow];
    if (NewValue = '') then
    begin
      NewValue := '0';
    end;

    with TfrmFormula.Create(self) do
    begin
      try
        IncludeGIS_Functions(eaNodes);
        RemoveGetVCont;
        RemoveHufFunctions;
        PopupParent := self;

        // register the appropriate variables with the
        // parser.
        for Index := 0 to VariableList.Count - 1 do
        begin
          Variable := VariableList[Index];
          rbFormulaParser.RegisterVariable(Variable);
        end;

        // show the variables and functions
        UpdateTreeList;

        // put the formula in the TfrmFormula.
        Formula := NewValue;
        // The user edits the formula.
        ShowModal;
        if ResultSet then
        begin
          CreateBoundaryFormula(DataGrid, ACol, ARow, Formula, Orientation,
            EvaluatedAt);
        end;
      finally
        Free;
      end;
    end;

  finally
    VariableList.Free;
  end;
end;

procedure TfrmScreenObjectProperties.dgBoundarySetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
begin
  inherited;
  if FDeletingPhastTime then
  begin
    Exit;
  end;
  StorePhastBoundary;
end;

procedure TfrmScreenObjectProperties.edLeakyHydraulicConductivityExit(
  Sender: TObject);
begin
  inherited;
  ValidateEdFormula(Sender as TEdit);
  StorePhastLeakyBoundary;
end;

procedure TfrmScreenObjectProperties.edRiverDescriptonExit(Sender: TObject);
begin
  inherited;
  StorePhastRiverBoundary;
end;

procedure TfrmScreenObjectProperties.edRiverExit(Sender: TObject);
begin
  inherited;
  ValidateEdFormula(Sender as TEdit);
  StorePhastRiverBoundary;
end;

procedure TfrmScreenObjectProperties.edWellExit(Sender: TObject);
begin
  inherited;
  StorePhastWellBoundary;
end;

procedure TfrmScreenObjectProperties.cbWellPumpAllocationClick(Sender: TObject);
begin
  inherited;
  StorePhastWellBoundary;
end;

procedure TfrmScreenObjectProperties.dgWellDistributeTextProgress(
  Sender: TObject; Position, Max: Integer);
begin
  inherited;
  seBoundaryTimes.AsInteger := dgWell.RowCount -1;
  seBoundaryTimesChange(nil);
end;

procedure TfrmScreenObjectProperties.dgWellElevationsDistributeTextProgress(
  Sender: TObject; Position, Max: Integer);
begin
  inherited;
  seWellIntervals.AsInteger := dgWellElevations.RowCount -1;
  seWellIntervalsChange(nil);
end;

procedure TfrmScreenObjectProperties.dgWellElevationsSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  inherited;
  StorePhastWellBoundary;
end;

procedure TfrmScreenObjectProperties.edNameExit(Sender: TObject);
var
  AString: string;
  Changed: boolean;
  NewName: string;
  Index: Integer;
  Item: TScreenObjectEditItem;
begin
  inherited;
  // edNameExit ensures that the value given for the name of a screen object
  // is valid.
  AString := edName.Text;
  NewName := TScreenObject.ValidName(AString);
  Changed := AString <> NewName;
  if Changed then
  begin
    edName.Text := NewName
  end;
  if IsLoaded then
  begin
    for Index := 0 to FNewProperties.Count - 1 do
    begin
      Item := FNewProperties[Index];
      Item.ScreenObject.Name := NewName;
    end;
  end;
end;

procedure TfrmScreenObjectProperties.btnCancelClick(Sender: TObject);
begin
  inherited;
  // If the user hasn't changed anything, don't force the user
  // to save the model.
  frmGoPhast.PhastModel.UpToDate := FPriorModelUpToDate;
end;

procedure TfrmScreenObjectProperties.btnCaptionFontClick(Sender: TObject);
var
  AScreenObject: TScreenObject;
begin
  inherited;
  if FScreenObject <> nil then
  begin
    dlgFontCaption.Font := FScreenObject.ObjectLabel.Font;
  end
  else
  begin
    AScreenObject := FScreenObjectList[0];
    dlgFontCaption.Font := AScreenObject.ObjectLabel.Font;
  end;
  if dlgFontCaption.Execute then
  begin
    FCaptionFont.Free;
    FCaptionFont := TFont.Create;
    FCaptionFont.Assign(dlgFontCaption.Font);
    FCaptionFontChanged := True;
  end;
end;

procedure TfrmScreenObjectProperties.splitterBoundaryMoved(Sender: TObject);
begin
  inherited;
  // See FInitialWidth for details.
  if Width - pnlBoundaries.Width < FInitialWidth then
  begin
    Width := pnlBoundaries.Width + FInitialWidth;
  end;
end;

procedure TfrmScreenObjectProperties.FormResize(Sender: TObject);
begin
  inherited;
  // See FInitialWidth for details.
  if Width - pnlBoundaries.Width < FInitialWidth then
  begin
    pnlBoundaries.Width := Width - FInitialWidth;
  end;
end;

procedure TfrmScreenObjectProperties.FormShow(Sender: TObject);
begin
  inherited;
  if frmDataSets <> nil then
  begin
    frmDataSets.Close;
  end;
  HelpKeyword := 'Object_Properties_Dialog_Box';
  frameScreenObjectSFR.zbChannel.InvalidateImage32;
  frameScreenObjectSFR.zbFlowDepthTable.InvalidateImage32;
  frameScreenObjectSFR.zbFlowWidthTable.InvalidateImage32;
  FCanSetPointsOutOfDate := True;
  HideGLViewersWithMicrosoftOpenGL;
end;

procedure TfrmScreenObjectProperties.comboSolutionTypeChange(Sender: TObject);
var
  NewTitle: string;
begin
  inherited;
  case comboSolutionType.ItemIndex of
    Ord(stAssociated):
      begin
        NewTitle := StrAssociatedSolution;
      end;
    Ord(stSpecified):
      begin
        NewTitle := StrSpecifiedSolution;
      end;
  else
    begin
      NewTitle := StrSolution;
    end;
  end;

  dgSpecifiedHead.Cells[Ord(ibcSolution), 0] := NewTitle;

  StorePhastSpecifiedHeads;
end;

procedure TfrmScreenObjectProperties.framePhastInterpolationDataedMixFormulaExit(
  Sender: TObject);
var
  Index: integer;
  Item: TInterpValuesItem;
  DataSet: TDataArray;
  DSName: string;
  VariableList: TList;
  Used: TStringList;
  Orientation: TDataSetOrientation;
  EvaluatedAt: TEvaluatedAt;
  VariableName: string;
  TempUsesList: TStringList;
  VariablePosition: integer;
  OldFormula, NewValue: string;
  Variable: TCustomValue;
  Expression: TExpression;
  Tester: TRbwParser;
  OtherEdit: TScreenObjectDataEdit;
  Edit: TScreenObjectDataEdit;
  DataArrayManager: TDataArrayManager;
begin
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  if not FUpdatingCurrentEdit and (FCurrentEdit <> nil) then
  begin
    DSName := FCurrentEdit.DataArray.Name;
    VariableList := TList.Create;
    // VariableList will hold a list of variables that can
    // be used in the function
    Used := TStringList.Create;
    // "Used" will be a list of variables that depend on
    // the data set whose formula will be edited.
    try
      Orientation := FCurrentEdit.DataArray.Orientation;
      EvaluatedAt := FCurrentEdit.DataArray.EvaluatedAt;
      // Add the variable whose value is being set to "Used".

      Used.Assign(FCurrentEdit.UsedBy);

      Used.Sorted := True;
      DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
      for Index := 0 to DataArrayManager.DataSetCount - 1 do
      begin
        DataSet := DataArrayManager.DataSets[Index];
        if not DataSet.Visible then
        begin
          Continue
        end;
        if (DataSet <> FCurrentEdit.DataArray)
          and (EvaluatedAt = DataSet.EvaluatedAt) then
        begin
          VariableName := DataSet.Name;
          OtherEdit := FDataEdits[GetDataSetIndexByName(VariableName)];
          TempUsesList := OtherEdit.UsedBy;
          VariablePosition := TempUsesList.IndexOf(DSName);
          if (VariablePosition < 0) and ((Orientation = dso3D)
            or (Orientation = DataSet.Orientation)) then
          begin
            Edit := FDataEdits[Index];
            // if the variable does not depend on the
            // data set whose formula is being edited
            // and it's orientation is OK, the variable
            // can be used in the formula.
            VariableList.Add(Edit.Variable);
          end;
        end;
      end;

      // if the user makes an invalid formula, it
      // may be necessary to restore it but only
      // if the formula that was already present
      // was OK to begin with.
      OldFormula := FOldMixFormula;
      NewValue := framePhastInterpolationData.edMixFormula.Text;
      if (NewValue = '') then
      begin
        NewValue := FortranFloatToStr(0.5);
      end;

      Tester := TRbwParser.Create(self);
      begin
        try
          AddGIS_Functions(Tester, frmGoPhast.PhastModel.ModelSelection,
            FCurrentEdit.DataArray.EvaluatedAt);
          // put the formula in the TfrmFormula.
          //Formula := NewValue;

          // register the appropriate variables with the
          // parser.
          for Index := 0 to VariableList.Count - 1 do
          begin
            Variable := VariableList[Index];
            Tester.RegisterVariable(Variable);
          end;

          try
            Tester.Compile(NewValue);
            Expression := Tester.CurrentExpression;
            framePhastInterpolationData.edMixFormula.Text := NewValue;
          except on E: ErbwParserError do
            begin
              framePhastInterpolationData.edMixFormula.Color := clRed;
              Beep;
              if MessageDlg(StrErrorThereAppearsCirc, mtError,
                [mbYes, mbNo], 0) = mrYes then
              begin
                framePhastInterpolationData.edMixFormula.Text :=
                  OldFormula;
                Expression :=
                  CreateMixtureFormula(FDataEdits.IndexOf(FCurrentEdit));
                framePhastInterpolationData.edMixFormula.Color := clBtnFace;
              end;
              Exit;
            end;
          end;
          framePhastInterpolationData.edMixFormula.Color := clBtnFace;

          if Expression <> nil then
          begin
            // Check that the formula does not result in
            // a circular reference.

            CheckForCircularReferencesInMixtureFormulas(Expression, DSName,
              OldFormula, FDataEdits.IndexOf(FCurrentEdit));

            // update the list of which variables depend on which
            // others.;
            UpdateDataSetLinkages(Expression, FDataEdits.IndexOf(FCurrentEdit), DSName);
          end;

        finally
          Tester.Free;
        end;
      end;
    finally
      Used.Free;
      VariableList.Free;
      // Don't allow the user to click the OK button if any formulas are invalid.
      EnableOK_Button;
    end;

    FCurrentEdit.Invalidate;

    DataSet := FCurrentEdit.DataArray;
    for Index := 0 to FCurrentEdit.InterpValue.Count - 1 do
    begin
      Item := FCurrentEdit.InterpValue.Items[Index] as TInterpValuesItem;
      Item.Values.MixtureFormula :=
        framePhastInterpolationData.edMixFormula.Text;
    end;
    AssignPhastInterpolation(DataSet);
  end;
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationBoundariesedMixFormulaExit(Sender: TObject);
var
  Index: integer;
  InterpValuesCollection: TInterpValuesCollection;
  InterpValuesItem: TInterpValuesItem;
begin
  inherited;
  if framePhastInterpolationData.AssigningValues then
  begin
    Exit;
  end;
  InterpValuesCollection := FBoundaryGrid.Objects[FBoundaryCol, FBoundaryRow] as
    TInterpValuesCollection;
  for Index := 0 to InterpValuesCollection.Count - 1 do
  begin
    InterpValuesItem := InterpValuesCollection.Items[Index] as
      TInterpValuesItem;
    InterpValuesItem.Values.MixtureFormula :=
      framePhastInterpolationBoundaries.edMixFormula.Text;
  end;
end;

procedure TfrmScreenObjectProperties.StorePhastBoundary;
var
  NewBoundaryType: TPhastBoundaryTypes;
begin
  if IsLoaded then
  begin
    NewBoundaryType := TPhastBoundaryTypes(rgBoundaryType.ItemIndex);
    case NewBoundaryType of
      btNone: ;  // do nothing
      btSpecifiedHead: StorePhastSpecifiedHeads;
      btFlux: StorePhastSpecifiedFlux;
      btLeaky: StorePhastLeakyBoundary;
      btRiver: StorePhastRiverBoundary;
      btWell: StorePhastWellBoundary;
      else Assert(False)
    end;

  end;
end;

procedure TfrmScreenObjectProperties.framePhastInterpolationBoundariesExit(
  Sender: TObject);
begin
  inherited;
  StorePhastBoundary;
end;

procedure TfrmScreenObjectProperties.CheckForCircularReferencesInMixtureFormulas(
  var Expression: TExpression; const DSName, OldFormula: string;
  const EditIndex: integer);
var
  Used: TStringList;
  VariableName: string;
  VariablePosition: integer;
  TempUsesList3: TStringList;
  Index: integer;
  Edit: TScreenObjectDataEdit;
begin
  Used := TStringList.Create;
  try
    Used.Assign(Expression.VariablesUsed);
    // Check that the formula does not result in
    // a circular reference.
    for Index := 0 to Used.Count - 1 do
    begin
      VariableName := Used[Index];
      VariablePosition := GetDataSetIndexByName(VariableName);
      Edit := FDataEdits[VariablePosition];
      TempUsesList3 := Edit.UsedBy;
      if TempUsesList3.IndexOf(DSName) >= 0 then
      begin
        Beep;
        if MessageDlg(Format(StrErrorThereAppears2, [Used[Index]]), mtError,
          [mbYes, mbNo], 0) = mrYes then
        begin
          framePhastInterpolationData.edMixFormula.Text :=
            OldFormula;
          Expression :=
            CreateMixtureFormula(EditIndex);
        end;

        Exit;
      end;
    end;
  finally
    Used.Free;
  end;
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationDatabtnEditMixtureFormulaClick(Sender: TObject);
var
  NewFormula: string;
  Variable: TCustomValue;
  Index: integer;
  Used: TStringList;
  VariableName: string;
  Orientation: TDataSetOrientation;
  VariableList: TList;
  TempUsesList: TStringList;
  VariablePosition: integer;
  OldFormula: string;
  DataSet: TDataArray;
  NewValue: string;
  EvaluatedAt: TEvaluatedAt;
  DSName: string;
  Edit, OtherEdit: TScreenObjectDataEdit;
  DataArray: TDataArray;
  DataArrayManager: TDataArrayManager;
begin
  inherited;

  Edit := FCurrentEdit;
  DSName := Edit.DataArray.Name;
  VariableList := TList.Create;
  // VariableList will hold a list of variables that can
  // be used in the function
  Used := TStringList.Create;
  // "Used" will be a list of variables that depend on
  // the data set whose formula will be edited.
  try
    DataArray := Edit.DataArray;
    Orientation := DataArray.Orientation;
    EvaluatedAt := DataArray.EvaluatedAt;
    // Add the variable whose value is being set to "Used".

    Used.Assign(Edit.UsedBy);

    Used.Sorted := True;
    DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
    for Index := 0 to DataArrayManager.DataSetCount - 1 do
    begin
      DataSet := DataArrayManager.DataSets[Index];
      if not DataSet.Visible then
      begin
        Continue;
      end;
      if (Index <> FDataEdits.IndexOf(Edit))
        and (EvaluatedAt = DataSet.EvaluatedAt) then
      begin
        VariableName := DataSet.Name;
        OtherEdit := FDataEdits[GetDataSetIndexByName(VariableName)];
        TempUsesList := OtherEdit.UsedBy;
        VariablePosition := TempUsesList.IndexOf(DSName);
        if (VariablePosition < 0) and ((Orientation = dso3D)
          or (Orientation = DataSet.Orientation)) then
        begin
          Edit := FDataEdits[Index];
          // if the variable does not depend on the
          // data set whose formula is being edited
          // and it's orientation is OK, the variable
          // can be used in the formula.
          VariableList.Add(Edit.Variable);
        end;
      end;
    end;

    // if the user makes an invalid formula, it
    // may be necessary to restore it but only
    // if the formula that was already present
    // was OK to begin with.
    OldFormula := framePhastInterpolationData.edMixFormula.Text;
    NewValue := OldFormula;
    if (NewValue = '') then
    begin
      NewValue := FortranFloatToStr(0.5);
    end;
    with TfrmFormula.Create(self) do
    begin
      try
        IncludeGIS_Functions(Edit.DataArray.EvaluatedAt);
        RemoveGetVCont;
        RemoveHufFunctions;
        PopupParent := self;

        // register the appropriate variables with the
        // parser.
        for Index := 0 to VariableList.Count - 1 do
        begin
          Variable := VariableList[Index];
          rbFormulaParser.RegisterVariable(Variable);
        end;

        // show the variables and functions
        UpdateTreeList;

        // put the formula in the TfrmFormula.
        Formula := NewValue;
        // The user edits the formula.
        ShowModal;
        if ResultSet then
        begin
          NewFormula := Formula;
          if framePhastInterpolationData.edMixFormula.Text <> NewFormula then
          begin
            framePhastInterpolationData.edMixFormula.Text := NewFormula;
            framePhastInterpolationDataedMixFormulaExit(
              framePhastInterpolationData.edMixFormula);
          end;
        end;
      finally
        Free;
      end;
    end;
  finally
    Used.Free;
    VariableList.Free;
    // Don't allow the user to click the OK button if any formulas are invalid.
    EnableOK_Button;
  end;
end;

procedure TfrmScreenObjectProperties.pageMainChange(Sender: TObject);
begin
  inherited;
  HelpKeyWord := pageMain.ActivePage.HelpKeyword;
  btnHelp.HelpKeyword := HelpKeyWord;

  btnCopyVertices.Visible := pageMain.ActivePage = tabNodes;

  btnConvertTimeUnits.Visible :=
    (pageMain.ActivePage = tabModflowBoundaryConditions)
    or (pageMain.ActivePage = tabSutraFeatures);

  btnEditFeatureFormulas.Visible :=
    (pageMain.ActivePage = tabModflowBoundaryConditions)
    and (FScreenObjectList <> nil) and (FScreenObjectList.Count > 1);
end;

procedure TfrmScreenObjectProperties.
  framePhastInterpolationDataedMixFormulaEnter(Sender: TObject);
begin
  inherited;
  FOldMixFormula := framePhastInterpolationData.edMixFormula.Text;
end;

procedure TfrmScreenObjectProperties.EmphasizeValueChoices;
begin
  EmphasizeCheckBoxes([cbSetGridCellSize, cbEnclosedCells,
    cbIntersectedCells, cbInterpolation]);
  if DataSetsSpecified then
  begin
    EmphasizeCheckBoxes([cbEnclosedCells, cbIntersectedCells, cbInterpolation]);
  end;
end;

procedure TfrmScreenObjectProperties.SetMultipleScreenObjects(
  const Value: boolean);
begin
  FMultipleScreenObjects := Value;
  cbLineColor.AllowGrayed := Value;
  cbInterpolation.AllowGrayed := Value;
  cbIntersectedCells.AllowGrayed := Value;
  cbEnclosedCells.AllowGrayed := Value;
  cbFillColor.AllowGrayed := Value;
end;

{ TParameterTimeList }

procedure TParameterTimeList.Add(Item: TParameterTime);
begin
  FList.Add(Item);
end;

constructor TParameterTimeList.Create;
begin
  inherited;
  FList := TObjectList.Create;
end;

procedure TParameterTimeList.Delete(Index: integer);
begin
  FList.Delete(Index);
end;

destructor TParameterTimeList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TParameterTimeList.GetCount: integer;
begin
  result := FList.Count;
end;

function TParameterTimeList.GetItems(Index: integer): TParameterTime;
begin
  result := FList[Index];
end;

function TParameterTimeList.IndexOfTime(const StartTime,
  EndTime: double): integer;
var
  Index: Integer;
  Time: TParameterTime;
  TempTime: TParameterTime;
  LowIndex, HighIndex, MiddleIndex, CompareResult: Integer;
begin
  result := -1;
  if Sorted and (Count > 0) then
  begin
    TempTime := TParameterTime.Create;
    try
      TempTime.StartTime := StartTime;
      TempTime.EndTime := EndTime;

      LowIndex := 0;
      HighIndex := Count - 1;
      if CompareStartAndEndTimes(Items[LowIndex], TempTime) = 0 then
      begin
        result := LowIndex;
        Exit;
      end
      else if CompareStartAndEndTimes(Items[HighIndex], TempTime) = 0 then
      begin
        result := HighIndex;
        Exit;
      end;
      while HighIndex - LowIndex > 1 do
      begin
        MiddleIndex := (LowIndex + HighIndex) shr 1;
        CompareResult := CompareStartAndEndTimes(Items[MiddleIndex], TempTime) + 1;
        case CompareResult of
          0:
            begin
              LowIndex := MiddleIndex;
            end;
          1:
            begin
              result := MiddleIndex;
              Exit;
            end;
          2:
            begin
              HighIndex := MiddleIndex;
            end;
        end;
      end;
    finally
      TempTime.Free;
    end;
  end
  else
  begin
    for Index := 0 to Count - 1 do
    begin
      Time := Items[Index];
      if (Time.StartTime = StartTime) and  (Time.EndTime = EndTime) then
      begin
        result := Index;
        Exit;
      end;
    end;
  end;
end;

procedure TParameterTimeList.SetItems(Index: integer;
  const Value: TParameterTime);
begin
  FList[Index] := Value;
end;

procedure TParameterTimeList.SetSorted(const Value: boolean);
begin
  if FSorted <> Value then
  begin
    FSorted := Value;
    if FSorted then
    begin
      Sort
    end;
  end;
end;

procedure TParameterTimeList.Sort;
begin
  FList.Sort(CompareStartAndEndTimes);
  FSorted := True;
end;

end.

