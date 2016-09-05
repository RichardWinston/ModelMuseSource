unit frmSutraOptionsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCustomGoPhastUnit, StdCtrls, Buttons, ExtCtrls, UndoItems,
  SutraOptionsUnit, SutraMeshUnit, ComCtrls, JvExComCtrls,
  JvPageListTreeView, JvPageList, JvExControls, Mask, JvExMask, JvToolEdit,
  JvSpin, JvEditorCommon, JvEditor, ArgusDataEntry, RequiredDataSetsUndoUnit,
  JvExExtCtrls, JvNetscapeSplitter, Vcl.ImgList;

type
  TfrmSutraOptions = class(TfrmCustomGoPhast)
    rgMeshType: TRadioGroup;
    rgTransport: TRadioGroup;
    pnlBottom: TPanel;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    btnHelp: TBitBtn;
    rgSaturation: TRadioGroup;
    jplMain: TJvPageList;
    jvspConfiguration: TJvStandardPage;
    jvpltvNavigation: TJvPageListTreeView;
    jvspTitle: TJvStandardPage;
    rgSimulationType: TRadioGroup;
    jvspInitialCondition: TJvStandardPage;
    rgStartType: TRadioGroup;
    fedRestartFile: TJvFilenameEdit;
    lblRestartFile: TLabel;
    seRestartFrequency: TJvSpinEdit;
    lblRestartFrequency: TLabel;
    jvedTitle: TJvEditor;
    pnlTitleCaption: TPanel;
    lblTitle: TLabel;
    jvspNumericalControls: TJvStandardPage;
    rdeFractionalUpstreamWeight: TRbwDataEntry;
    rdePressureFactor: TRbwDataEntry;
    rdeUFactor: TRbwDataEntry;
    lblFractionalUpstreamWeight: TLabel;
    lblPressureFactor: TLabel;
    lblUFactor: TLabel;
    seMaxIterations: TJvSpinEdit;
    lblMaxIterations: TLabel;
    rdeNonLinPressureCriterion: TRbwDataEntry;
    lblNonLinPressureCriterion: TLabel;
    lblUCriterion: TLabel;
    rdeUCriterion: TRbwDataEntry;
    jvspSolverControls: TJvStandardPage;
    rgPressureSolution: TRadioGroup;
    seMaxPressureIterations: TJvSpinEdit;
    lblMaxPressureIterations: TLabel;
    rdePressureCriterion: TRbwDataEntry;
    lblPressureCriterion: TLabel;
    rgUSolutionMethod: TRadioGroup;
    seMaxTransportIterations: TJvSpinEdit;
    lblMaxTransportIterations: TLabel;
    rdeTransportCriterion: TRbwDataEntry;
    lblTransportCriterion: TLabel;
    jvspFluidProperties: TJvStandardPage;
    rdeFluidCompressibility: TRbwDataEntry;
    lblFluidCompressibility: TLabel;
    rdeFluidSpecificHeat: TRbwDataEntry;
    lblFluidSpecificHeat: TLabel;
    rdeFluidDiffusivity: TRbwDataEntry;
    lblFluidDiffusivity: TLabel;
    rdeBaseFluidDensity: TRbwDataEntry;
    lblBaseFluidDensity: TLabel;
    rdeBaseConcentration: TRbwDataEntry;
    lblBaseU: TLabel;
    rdeFluidDensityCoefficientConcentration: TRbwDataEntry;
    lblFluidDensityCoefficientConcentration: TLabel;
    rdeViscosity: TRbwDataEntry;
    lblViscosityScaleFactor: TLabel;
    jvspSolidAdsorption: TJvStandardPage;
    jvspProdGrav: TJvStandardPage;
    rdeZeroFluidProd: TRbwDataEntry;
    lblZeroFluidProd: TLabel;
    rdeZeroImmobProd: TRbwDataEntry;
    lblZeroImmobProd: TLabel;
    rdeFirstFluidProd: TRbwDataEntry;
    rdeFirstImmobProd: TRbwDataEntry;
    lblFirstFluidProd: TLabel;
    lblFirstImmobProd: TLabel;
    rdeGravX: TRbwDataEntry;
    rdeGravY: TRbwDataEntry;
    rdeGravZ: TRbwDataEntry;
    lblGravX: TLabel;
    lblGravY: TLabel;
    lblGravZ: TLabel;
    rdeScaleFactor: TRbwDataEntry;
    lblScaleFactor: TLabel;
    rdeFluidThermalConductivity: TRbwDataEntry;
    lblFluidThermalConductivity: TLabel;
    rdeFluidDensityCoefficientTemperature: TRbwDataEntry;
    lblFluidDensityCoefficientTemperature: TLabel;
    rdeBaseTemperature: TRbwDataEntry;
    lblBaseTemperature: TLabel;
    splttrVertical: TJvNetscapeSplitter;
    grpSolidMatrix: TGroupBox;
    rdeSolidGrainDensity: TRbwDataEntry;
    rdeSolidGrainDiffusivity: TRbwDataEntry;
    rdeSolidGrainSpecificHeat: TRbwDataEntry;
    rdeMatrixCompressibility: TRbwDataEntry;
    lblMatrixCompressibility: TLabel;
    lblSolidGrainSpecificHeat: TLabel;
    lblSolidGrainDiffusivity: TLabel;
    lblSolidGrainDensity: TLabel;
    grpAdsorption: TGroupBox;
    rgSorptionModel: TRadioGroup;
    rdeFirstDistributionCoefficient: TRbwDataEntry;
    lblFirstDistributionCoefficient: TLabel;
    rdeSecondDistributionCoefficient: TRbwDataEntry;
    lblSecondDistributionCoefficient: TLabel;
    rgInitialValues: TRadioGroup;
    lblRestartInitialConditions: TLabel;
    fedRestartInitialConditions: TJvFilenameEdit;
    jvspLake: TJvStandardPage;
    grpLakeDataset1: TGroupBox;
    seLakeMaxIter: TJvSpinEdit;
    lblLakeMaxIter: TLabel;
    seLakeOutputCycle: TJvSpinEdit;
    lblLakeOutputCycle: TLabel;
    grpLakeDataset2: TGroupBox;
    lblDefaultRechargeFrac: TLabel;
    lblDefaultDischargeFrac: TLabel;
    lblMinLakeVolume: TLabel;
    lblLakeOutput: TLabel;
    rdeDefaultRechargeFrac: TRbwDataEntry;
    rdeDefaultDischargeFrac: TRbwDataEntry;
    rdeMinLakeVolume: TRbwDataEntry;
    rdeLakeOutput: TRbwDataEntry;
    procedure FormCreate(Sender: TObject); override;
    procedure btnOKClick(Sender: TObject);
    procedure seMaxIterationsChange(Sender: TObject);
    procedure rgPressureSolutionClick(Sender: TObject);
    procedure rgUSolutionMethodClick(Sender: TObject);
    procedure rdeFractionalUpstreamWeightChange(Sender: TObject);
    procedure rgTransportClick(Sender: TObject);
    procedure rgSorptionModelClick(Sender: TObject);
    procedure rgMeshTypeClick(Sender: TObject);
    procedure rgStartTypeClick(Sender: TObject);
    procedure jplMainChange(Sender: TObject);
    procedure rgInitialValuesClick(Sender: TObject);
    procedure fedRestartFileChange(Sender: TObject);
    procedure fedRestartInitialConditionsChange(Sender: TObject);
    procedure jvpltvNavigationCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    FGettingData: Boolean;
    FLakeNode: TJvPageIndexNode;
    procedure GetData;
    procedure SetData;
    procedure EnableRhos;
    procedure EnableLakeNode;
    procedure EnableControls;
    { Private declarations }
  public
    { Public declarations }
  end;

  TUndoChangeSutraOptions = class(TCustomCreateRequiredDataSetsUndo)
  private
    FNewSutraOptions: TSutraOptions;
    FOldSutraOptions: TSutraOptions;
    FNewMeshType: TMeshType;
    FOldMeshType: TMeshType;
  protected
    function Description: string; override;
  public
    constructor Create(var NewSutraOptions: TSutraOptions;
      NewMeshType: TMeshType);
    destructor Destroy; override;
    procedure DoCommand; override;
    procedure Undo; override;
  end;

var
  frmSutraOptions: TfrmSutraOptions;

implementation

uses
  frmGoPhastUnit, frmShowHideObjectsUnit, GoPhastTypes;

resourcestring
  StrYouMustSetAtLeas = 'You must set at least one of the gravity vector com' +
  'ponents to a non-zero value.';
  StrYouHaveSetMoreTh = 'You have set more than one of the gravity vector co' +
  'mponents to a non-zero value so you model is tilted. Do you want to conti' +
  'nue anyway?';
  StrConfiguration = 'Configuration';
  StrTitle = 'Title';
  StrInitialConditions = 'Initial Conditions';
  StrNumericalControls = 'Numerical Controls';
  StrSolverControls = 'Solver Controls';
  StrFluidProperties = 'Fluid Properties';
  StrSolidMatrixAdsorp = 'Solid Matrix, Adsorption';
  StrProduction = 'Production';
  StrChangeSUTRAOptions = 'change SUTRA options';
  StrLakes = 'Lakes';

{$R *.dfm}

{ TfrmSutraOptions }

procedure TfrmSutraOptions.btnOKClick(Sender: TObject);
var
  Tilted: Boolean;
  Count: Integer;
  TransportChoice: TTransportChoice;
begin
  inherited;

  TransportChoice := TTransportChoice(rgTransport.ItemIndex);
  Tilted := False;
  if TransportChoice <> tcSoluteHead then
  begin
    case TMeshType(rgMeshType.ItemIndex) of
      mt2D, mtProfile:
        begin
          Tilted := (rdeGravX.RealValue <> 0) and (rdeGravY.RealValue <> 0);
        end;
      mt3D:
        begin
          Count := 0;
          if (rdeGravX.RealValue <> 0) then
          begin
            Inc(Count);
          end;
          if (rdeGravY.RealValue <> 0) then
          begin
            Inc(Count);
          end;
          if (rdeGravZ.RealValue <> 0) then
          begin
            Inc(Count);
          end;
          if Count = 0 then
          begin
            Beep;
            MessageDlg(StrYouMustSetAtLeas, mtError, [mbOK], 0);
            ModalResult := mrNone;
            Exit;
          end;
          Tilted := Count <> 1;
        end;
      else
        Assert(False);
    end;

    if Tilted then
    begin
      Beep;
      if (MessageDlg(StrYouHaveSetMoreTh, mtWarning, [mbYes, mbNo], 0) <>
        mrYes) then
      begin
        ModalResult := mrNone;
        Exit;
      end;
    end;
  end;

  SetData;

  if (frmGoPhast.PhastModel.SutraMesh.MeshType = mt3D)
    and (frmGoPhast.PhastModel.SutraLayerStructure.Count <= 1) then
  begin
    frmGoPhast.acSutraLayersExecute(nil);
  end;
end;

procedure TfrmSutraOptions.EnableControls;
begin
  seMaxIterationsChange(nil);
  rgPressureSolutionClick(nil);
  rgUSolutionMethodClick(nil);
  rdeFractionalUpstreamWeightChange(nil);
  rgTransportClick(nil);
  rgSorptionModelClick(nil);
  rgMeshTypeClick(nil);
end;

procedure TfrmSutraOptions.EnableLakeNode;
begin
  if FLakeNode <> nil then
  begin
    // Lakes are only allowed in 3D meshes in SUTRA 3.0.
    FLakeNode.Enabled := (rgMeshType.ItemIndex = 2)
      and (frmGoPhast.ModelSelection = msSutra30);
  end;
end;

procedure TfrmSutraOptions.EnableRhos;
begin
  rdeSolidGrainDensity.Enabled :=
    (TTransportChoice(rgTransport.ItemIndex) = tcEnergy)
    or (TSorptionModel(rgSorptionModel.ItemIndex) <> smNone);
end;

procedure TfrmSutraOptions.fedRestartFileChange(Sender: TObject);
begin
  inherited;
  if fedRestartFile.Enabled and not FileExists(fedRestartFile.FileName) then
  begin
    fedRestartFile.Color := clRed;
  end
  else
  begin
    fedRestartFile.Color := clWindow;
  end;
end;

procedure TfrmSutraOptions.fedRestartInitialConditionsChange(Sender: TObject);
begin
  inherited;
  if fedRestartInitialConditions.Enabled and
    not FileExists(fedRestartInitialConditions.FileName) then
  begin
    fedRestartInitialConditions.Color := clRed;
  end
  else
  begin
    fedRestartInitialConditions.Color := clWindow;
  end;
end;

procedure TfrmSutraOptions.FormCreate(Sender: TObject);
var
  Node: TJvPageIndexNode;
  StoredHelpKeyword: string;
begin
  inherited;
  StoredHelpKeyword := HelpKeyword;
  Handle;
  jvpltvNavigation.Handle;
  jvpltvNavigation.Items.Clear;
  Node := jvpltvNavigation.Items.Add(nil, StrConfiguration) as TJvPageIndexNode;
  Node.PageIndex := jvspConfiguration.PageIndex;
  Node := jvpltvNavigation.Items.Add(nil, StrTitle) as TJvPageIndexNode;
  Node.PageIndex := jvspTitle.PageIndex;
  Node := jvpltvNavigation.Items.Add(nil, StrInitialConditions) as TJvPageIndexNode;
  Node.PageIndex := jvspInitialCondition.PageIndex;
  Node := jvpltvNavigation.Items.Add(nil, StrNumericalControls) as TJvPageIndexNode;
  Node.PageIndex := jvspNumericalControls.PageIndex;
  Node := jvpltvNavigation.Items.Add(nil, StrSolverControls) as TJvPageIndexNode;
  Node.PageIndex := jvspSolverControls.PageIndex;
  Node := jvpltvNavigation.Items.Add(nil, StrFluidProperties) as TJvPageIndexNode;
  Node.PageIndex := jvspFluidProperties.PageIndex;
  Node := jvpltvNavigation.Items.Add(nil, StrSolidMatrixAdsorp) as TJvPageIndexNode;
  Node.PageIndex := jvspSolidAdsorption.PageIndex;
  Node := jvpltvNavigation.Items.Add(nil, StrProduction) as TJvPageIndexNode;
  Node.PageIndex := jvspProdGrav.PageIndex;

{$IFDEF SUTRA30}
  if frmGoPhast.ModelSelection = msSutra30 then
  begin
    FLakeNode := jvpltvNavigation.Items.Add(nil, StrLakes) as TJvPageIndexNode;
    FLakeNode.PageIndex := jvspLake.PageIndex;
  end;
{$ENDIF}

  jplMain.ActivePageIndex := 0;

  HelpKeyword := StoredHelpKeyword;


  GetData;
end;

procedure TfrmSutraOptions.GetData;
var
  SutraOptions: TSutraOptions;
  LakeOptions: TSutraLakeOptions;
begin
  FGettingData := true;
  try
    SutraOptions := frmGoPhast.PhastModel.SutraOptions;
    if frmGoPhast.PhastModel.SutraMesh = nil then
    begin
      rgMeshType.Enabled := False;
    end
    else
    begin
      rgMeshType.ItemIndex := Ord(frmGoPhast.PhastModel.SutraMesh.MeshType);
    end;
    rgTransport.ItemIndex := Ord(SutraOptions.TransportChoice);
    rgSaturation.ItemIndex := Ord(SutraOptions.SaturationChoice);
    jvedTitle.Lines.Text := string(SutraOptions.TitleLines);
    rgSimulationType.ItemIndex := Ord(SutraOptions.SimulationType);

    rgStartType.ItemIndex := Ord(SutraOptions.StartType);
    try
      fedRestartFile.FileName := SutraOptions.FullRestartFileName;
    except on EComboEditError do
      begin
        // do nothing.
      end;
    end;
    fedRestartFileChange(nil);

    rgInitialValues.ItemIndex := Ord(SutraOptions.ReadStart);
    try
      fedRestartInitialConditions.FileName
        := SutraOptions.FullReadStartRestartFileName;
    except on EComboEditError do
      begin
        // do nothing.
      end;
    end;
    fedRestartInitialConditionsChange(nil);

    seRestartFrequency.AsInteger := SutraOptions.RestartFrequency;
    rdeFractionalUpstreamWeight.RealValue :=
      SutraOptions.FractionalUpstreamWeight;
    rdePressureFactor.RealValue := SutraOptions.PressureFactor;
    rdeUFactor.RealValue := SutraOptions.UFactor;
    seMaxIterations.AsInteger := SutraOptions.MaxIterations;
    rdeNonLinPressureCriterion.RealValue := SutraOptions.NonLinPressureCriterion;
    rdeUCriterion.RealValue := SutraOptions.UCriterion;

    rgPressureSolution.ItemIndex := Ord(SutraOptions.PresSolutionMethod);
    seMaxPressureIterations.AsInteger := SutraOptions.MaxPressureIterations;
    rdePressureCriterion.RealValue := SutraOptions.PressureCriterion;

    rgUSolutionMethod.ItemIndex := Ord(SutraOptions.USolutionMethod);
    seMaxTransportIterations.AsInteger := SutraOptions.MaxTransportIterations;
    rdeTransportCriterion.RealValue := SutraOptions.TransportCriterion;

    rdeFluidCompressibility.RealValue := SutraOptions.FluidCompressibility;
    rdeFluidSpecificHeat.RealValue := SutraOptions.FluidSpecificHeat;
    rdeFluidDiffusivity.RealValue := SutraOptions.FluidDiffusivity;
    rdeFluidThermalConductivity.RealValue := SutraOptions.FluidThermalConductivity;

    rdeBaseFluidDensity.RealValue := SutraOptions.BaseFluidDensity;
    rdeBaseConcentration.RealValue := SutraOptions.BaseConcentration;
    rdeBaseTemperature.RealValue := SutraOptions.BaseTemperature;
    rdeFluidDensityCoefficientConcentration.RealValue :=
      SutraOptions.FluidDensityCoefficientConcentration;
    rdeFluidDensityCoefficientTemperature.RealValue :=
      SutraOptions.FluidDensityCoefficientTemperature;
    rdeViscosity.RealValue := SutraOptions.Viscosity;
    rdeScaleFactor.RealValue := SutraOptions.ScaleFactor;

    rdeMatrixCompressibility.RealValue := SutraOptions.MatrixCompressibility;
    rdeSolidGrainSpecificHeat.RealValue := SutraOptions.SolidGrainSpecificHeat;
    rdeSolidGrainDiffusivity.RealValue := SutraOptions.SolidGrainDiffusivity;
    rdeSolidGrainDensity.RealValue := SutraOptions.SolidGrainDensity;

    rgSorptionModel.ItemIndex := Ord(SutraOptions.SorptionModel);
    rdeFirstDistributionCoefficient.RealValue := SutraOptions.FirstDistributionCoefficient;
    rdeSecondDistributionCoefficient.RealValue := SutraOptions.SecondDistributionCoefficient;

    rdeZeroFluidProd.RealValue := SutraOptions.ZeroFluidProduction;
    rdeZeroImmobProd.RealValue := SutraOptions.ZeroImmobileProduction;
    rdeFirstFluidProd.RealValue := SutraOptions.FirstFluidProduction;
    rdeFirstImmobProd.RealValue := SutraOptions.FirstImmobileProduction;
    rdeGravX.RealValue := SutraOptions.GravityX;
    rdeGravY.RealValue := SutraOptions.GravityY;
    rdeGravZ.RealValue := SutraOptions.GravityZ;

    LakeOptions := SutraOptions.LakeOptions;
    seLakeMaxIter.AsInteger := LakeOptions.MaxLakeIterations;
    seLakeOutputCycle.AsInteger := LakeOptions.LakeOutputCycle;
    rdeDefaultRechargeFrac.RealValue := LakeOptions.RechargeFraction;
    rdeDefaultDischargeFrac.RealValue := LakeOptions.DischargeFraction;
    rdeMinLakeVolume.RealValue := LakeOptions.MinLakeVolume;
    rdeLakeOutput.RealValue := LakeOptions.SubmergedOutput;

    EnableControls;
  finally
    FGettingData := False;
  end;
//  StartType
//  RestartFileName
//  RestartFrequency
end;

procedure TfrmSutraOptions.jplMainChange(Sender: TObject);
begin
  inherited;
  HelpKeyWord := jplMain.ActivePage.HelpKeyword;
end;

procedure TfrmSutraOptions.jvpltvNavigationCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  inherited;
  if Node.Selected and not Sender.Focused then
  begin
    Sender.Canvas.Brush.Color := clMenuHighlight;
  end;
end;

procedure TfrmSutraOptions.rdeFractionalUpstreamWeightChange(Sender: TObject);
begin
  if  csLoading in ComponentState then
  begin
    Exit;
  end;
  inherited;
  // Ensure that the windows handles for the rgPressureSolution radio buttons
  // have been created. If this isn't done, disabling one of them won't work.
  rgPressureSolution.Handle;

  rgPressureSolution.Buttons[Ord(pcmCG)].Enabled :=
    rdeFractionalUpstreamWeight.RealValue = 0;
end;

procedure TfrmSutraOptions.rgInitialValuesClick(Sender: TObject);
begin
  inherited;
  fedRestartInitialConditions.Enabled := rgInitialValues.Enabled
    and (rgInitialValues.ItemIndex > 0);
  if  csLoading in ComponentState then
  begin
    Exit;
  end;
  if not FGettingData and fedRestartInitialConditions.Enabled
    and (fedRestartInitialConditions.FileName = '') then
  begin
    if fedRestartInitialConditions.Dialog.Execute then
    begin
      fedRestartInitialConditions.FileName :=
        fedRestartInitialConditions.Dialog.FileName
    end;
  end;

end;

procedure TfrmSutraOptions.rgMeshTypeClick(Sender: TObject);
var
  TransportChoice: TTransportChoice;
begin
  // Note that if the TMeshType changes, corresponding changes
  // need to be made in TfrmStartUp.
  if  csLoading in ComponentState then
  begin
    Exit;
  end;
  inherited;
  TransportChoice := TTransportChoice(rgTransport.ItemIndex);
  rdeGravZ.Enabled := (TMeshType(rgMeshType.ItemIndex) = mt3D)
    and (TransportChoice in [tcSolute, tcEnergy]);

  if not FGettingData and (Sender <> nil) then
  begin
    case TMeshType(rgMeshType.ItemIndex) of
      mt2D, mt3D:
        begin
          rdeGravY.Text := '0'
        end;
      mtProfile:
        begin
          if StrToFloat(rdeGravY.Output) = 0 then
          begin
            rdeGravY.Text := '-9.81';
          end;
        end;
      else Assert(False);
    end;
  end;
  EnableLakeNode;
end;

procedure TfrmSutraOptions.rgPressureSolutionClick(Sender: TObject);
begin
  if  csLoading in ComponentState then
  begin
    Exit;
  end;
  inherited;
  if TPressureSolutionMethod(rgPressureSolution.ItemIndex) = psmDirect then
  begin
    if TUSolutionMethod(rgUSolutionMethod.ItemIndex) <> usmDirect then
    begin
      rgUSolutionMethod.ItemIndex := Ord(usmDirect);
    end;
  end
  else
  begin
    if TUSolutionMethod(rgUSolutionMethod.ItemIndex) = usmDirect then
    begin
      rgUSolutionMethod.ItemIndex := Ord(usmGMRES);
    end;
  end;

  seMaxPressureIterations.Enabled :=
    TPressureSolutionMethod(rgPressureSolution.ItemIndex) <> psmDirect;
  rdePressureCriterion.Enabled := seMaxPressureIterations.Enabled;

end;

procedure TfrmSutraOptions.rgSorptionModelClick(Sender: TObject);
var
  TransportChoice: TTransportChoice;
begin
  if  csLoading in ComponentState then
  begin
    Exit;
  end;
  inherited;
  EnableRhos;

  TransportChoice := TTransportChoice(rgTransport.ItemIndex);

  rdeFirstDistributionCoefficient.Enabled := (TransportChoice in [tcSolute, tcSoluteHead])
    and (TSorptionModel(rgSorptionModel.ItemIndex) <> smNone);
  rdeSecondDistributionCoefficient.Enabled :=(TransportChoice in [tcSolute, tcSoluteHead])
    and (TSorptionModel(rgSorptionModel.ItemIndex)
    in [smFreundlich, smLangmuir]);
end;

procedure TfrmSutraOptions.rgStartTypeClick(Sender: TObject);
begin
  inherited;
  fedRestartFile.Enabled := (rgStartType.ItemIndex = 1);
  rgInitialValues.Enabled := (rgStartType.ItemIndex = 0);
  rgInitialValuesClick(nil);
  if  csLoading in ComponentState then
  begin
    Exit;
  end;
  if not FGettingData and fedRestartFile.Enabled
    and (fedRestartFile.FileName = '') then
  begin
    if fedRestartFile.Dialog.Execute then
    begin
      try
        fedRestartFile.FileName :=
          fedRestartFile.Dialog.FileName
      except on EComboEditError do
        begin
          // do nothing.
        end;
      end;
    end;
  end;
end;

procedure TfrmSutraOptions.rgTransportClick(Sender: TObject);
var
  TransportChoice: TTransportChoice;
begin
  if  csLoading in ComponentState then
  begin
    Exit;
  end;
  inherited;
  TransportChoice := TTransportChoice(rgTransport.ItemIndex);


  // energy transport
  rdeFluidSpecificHeat.Enabled := TransportChoice = tcEnergy;
  rdeScaleFactor.Enabled := TransportChoice = tcEnergy;
  rdeFluidThermalConductivity.Enabled := TransportChoice = tcEnergy;
  rdeFluidDensityCoefficientTemperature.Enabled := TransportChoice = tcEnergy;
  rdeBaseTemperature.Enabled := TransportChoice = tcEnergy;
  rdeSolidGrainSpecificHeat.Enabled := TransportChoice = tcEnergy;
  rdeSolidGrainDiffusivity.Enabled := TransportChoice = tcEnergy;

  // solute transport with pressure or head
  rgSorptionModel.Enabled := TransportChoice in [tcSolute, tcSoluteHead];
  rdeFirstFluidProd.Enabled := TransportChoice in [tcSolute, tcSoluteHead];
  rdeFirstImmobProd.Enabled := TransportChoice in [tcSolute, tcSoluteHead];
  rdeFluidDiffusivity.Enabled := TransportChoice in [tcSolute, tcSoluteHead];

  // solute transport with pressure
  rdeViscosity.Enabled := TransportChoice = tcSolute;
  rdeFluidDensityCoefficientConcentration.Enabled := TransportChoice = tcSolute;
  rdeBaseConcentration.Enabled := TransportChoice in [tcSolute];

  // solute with pressure or energy
  rdeBaseFluidDensity.Enabled := TransportChoice in [tcSolute, tcEnergy];
  rdeGravX.Enabled := TransportChoice in [tcSolute, tcEnergy];
  rdeGravY.Enabled := TransportChoice in [tcSolute, tcEnergy];
  rgMeshTypeClick(nil);
  rgSaturation.Enabled := TransportChoice in [tcSolute, tcEnergy];
  if not rgSaturation.Enabled then
  begin
    rgSaturation.ItemIndex := 0;
  end;

  EnableRhos;
end;

procedure TfrmSutraOptions.rgUSolutionMethodClick(Sender: TObject);
begin
  if  csLoading in ComponentState then
  begin
    Exit;
  end;
  inherited;
  if TUSolutionMethod(rgUSolutionMethod.ItemIndex) = usmDirect then
  begin
    if TPressureSolutionMethod(rgPressureSolution.ItemIndex) <> psmDirect then
    begin
      rgPressureSolution.ItemIndex := Ord(psmDirect);
    end;
  end
  else
  begin
    if TPressureSolutionMethod(rgPressureSolution.ItemIndex) = psmDirect then
    begin
      rgPressureSolution.ItemIndex := Ord(psmGMRES);
    end;
  end;

  seMaxTransportIterations.Enabled :=
    TUSolutionMethod(rgUSolutionMethod.ItemIndex) <> usmDirect;
  rdeTransportCriterion.Enabled := seMaxTransportIterations.Enabled;

end;

procedure TfrmSutraOptions.seMaxIterationsChange(Sender: TObject);
begin
  if  csLoading in ComponentState then
  begin
    Exit;
  end;
  inherited;

  rdeNonLinPressureCriterion.Enabled := seMaxIterations.AsInteger > 1;
  rdeUCriterion.Enabled := rdeNonLinPressureCriterion.Enabled;
end;

procedure TfrmSutraOptions.SetData;
var
  SutraOptions: TSutraOptions;
  UndoItem: TUndoChangeSutraOptions;
  MeshType: TMeshType;
  LakeOptions: TSutraLakeOptions;
begin
  SutraOptions := TSutraOptions.Create(nil);
  try
    MeshType := TMeshType(rgMeshType.ItemIndex);
    SutraOptions.TransportChoice := TTransportChoice(rgTransport.ItemIndex);
    SutraOptions.SaturationChoice := TSaturationChoice(rgSaturation.ItemIndex);
    SutraOptions.SimulationType := TSimulationType(rgSimulationType.ItemIndex);
    SutraOptions.TitleLines := AnsiString(jvedTitle.Lines.Text);
    SutraOptions.StartType := TStartType(rgStartType.ItemIndex);
    SutraOptions.FullRestartFileName := fedRestartFile.FileName;

    SutraOptions.ReadStart := TReadStart(rgInitialValues.ItemIndex);
    SutraOptions.FullReadStartRestartFileName := fedRestartInitialConditions.FileName;

    SutraOptions.RestartFrequency := seRestartFrequency.AsInteger;
    SutraOptions.FractionalUpstreamWeight :=
      rdeFractionalUpstreamWeight.RealValue;
    SutraOptions.PressureFactor := rdePressureFactor.RealValue;
    SutraOptions.UFactor := rdeUFactor.RealValue;
    SutraOptions.MaxIterations := seMaxIterations.AsInteger;
    SutraOptions.NonLinPressureCriterion := rdeNonLinPressureCriterion.RealValue;
    SutraOptions.UCriterion := rdeUCriterion.RealValue;

    SutraOptions.PresSolutionMethod := TPressureSolutionMethod(
      rgPressureSolution.ItemIndex);
    SutraOptions.MaxPressureIterations := seMaxPressureIterations.AsInteger;
    SutraOptions.PressureCriterion := rdePressureCriterion.RealValue;

    SutraOptions.USolutionMethod := TUSolutionMethod(rgUSolutionMethod.ItemIndex);
    SutraOptions.MaxTransportIterations := seMaxTransportIterations.AsInteger;
    SutraOptions.TransportCriterion := rdeTransportCriterion.RealValue;

    SutraOptions.FluidCompressibility := rdeFluidCompressibility.RealValue;
    SutraOptions.FluidSpecificHeat := rdeFluidSpecificHeat.RealValue;
    SutraOptions.FluidDiffusivity := rdeFluidDiffusivity.RealValue;
    SutraOptions.FluidThermalConductivity := rdeFluidThermalConductivity.RealValue;
    SutraOptions.BaseFluidDensity := rdeBaseFluidDensity.RealValue;
    SutraOptions.BaseConcentration := rdeBaseConcentration.RealValue;
    SutraOptions.BaseTemperature := rdeBaseTemperature.RealValue;
    SutraOptions.FluidDensityCoefficientConcentration := rdeFluidDensityCoefficientConcentration.RealValue;
    SutraOptions.FluidDensityCoefficientTemperature := rdeFluidDensityCoefficientTemperature.RealValue;
    SutraOptions.Viscosity := rdeViscosity.RealValue;
    SutraOptions.ScaleFactor := rdeScaleFactor.RealValue;

    SutraOptions.MatrixCompressibility := rdeMatrixCompressibility.RealValue;
    SutraOptions.SolidGrainSpecificHeat := rdeSolidGrainSpecificHeat.RealValue;
    SutraOptions.SolidGrainDiffusivity := rdeSolidGrainDiffusivity.RealValue;
    SutraOptions.SolidGrainDensity := rdeSolidGrainDensity.RealValue;

    SutraOptions.SorptionModel := TSorptionModel(rgSorptionModel.ItemIndex);
    SutraOptions.FirstDistributionCoefficient := rdeFirstDistributionCoefficient.RealValue;
    SutraOptions.SecondDistributionCoefficient := rdeSecondDistributionCoefficient.RealValue;

    SutraOptions.ZeroFluidProduction := rdeZeroFluidProd.RealValue;
    SutraOptions.ZeroImmobileProduction := rdeZeroImmobProd.RealValue;
    SutraOptions.FirstFluidProduction := rdeFirstFluidProd.RealValue;
    SutraOptions.FirstImmobileProduction := rdeFirstImmobProd.RealValue;
    SutraOptions.GravityX := rdeGravX.RealValue;
    SutraOptions.GravityY := rdeGravY.RealValue;
    SutraOptions.GravityZ := rdeGravZ.RealValue;

    LakeOptions := SutraOptions.LakeOptions;
    LakeOptions.MaxLakeIterations := seLakeMaxIter.AsInteger;
    LakeOptions.LakeOutputCycle := seLakeOutputCycle.AsInteger;
    LakeOptions.RechargeFraction := rdeDefaultRechargeFrac.RealValue;
    LakeOptions.DischargeFraction := rdeDefaultDischargeFrac.RealValue;
    LakeOptions.MinLakeVolume := rdeMinLakeVolume.RealValue;
    LakeOptions.SubmergedOutput := rdeLakeOutput.RealValue;

    UndoItem := TUndoChangeSutraOptions.Create(SutraOptions, MeshType);
    frmGoPhast.UndoStack.Submit(UndoItem);
  finally
    SutraOptions.Free;
  end;
end;

{ TUndoChangeSutraOptions }

constructor TUndoChangeSutraOptions.Create(var NewSutraOptions: TSutraOptions;
  NewMeshType: TMeshType);
begin
  FNewSutraOptions := NewSutraOptions;
  NewSutraOptions := nil;
  FOldSutraOptions := TSutraOptions.Create(nil);
  FOldSutraOptions.Assign(frmGoPhast.PhastModel.SutraOptions);
  FNewMeshType := NewMeshType;
  if frmGoPhast.PhastModel.SutraMesh <> nil then
  begin
    FOldMeshType := frmGoPhast.PhastModel.SutraMesh.MeshType;
  end
  else
  begin
    FOldMeshType := mt2D;
  end;
end;

function TUndoChangeSutraOptions.Description: string;
begin
  result := StrChangeSUTRAOptions;
end;

destructor TUndoChangeSutraOptions.Destroy;
begin
  FOldSutraOptions.Free;
  FNewSutraOptions.Free;
  inherited;
end;

procedure TUndoChangeSutraOptions.DoCommand;
var
  AdjustVerticalExag: Boolean;
  VerticalExag: Double;
begin
  inherited;
  AdjustVerticalExag := (FNewMeshType = mtProfile) <> (FOldMeshType = mtProfile);
  if AdjustVerticalExag then
  begin
    VerticalExag := frmGoPhast.PhastModel.Exaggeration;
  end
  else
  begin
    VerticalExag := 0;
  end;
  if frmGoPhast.PhastModel.SutraMesh <> nil then
  begin
    frmGoPhast.PhastModel.SutraMesh.MeshType := FNewMeshType;
    frmGoPhast.splitHoriz.Minimized :=
      frmGoPhast.PhastModel.SutraMesh.MeshType <> mt3D;
  end;
  frmGoPhast.PhastModel.SutraOptions := FNewSutraOptions;
  frmGoPhast.PhastModel.SutraLayerStructure.Loaded;
  frmGoPhast.PhastModel.DataArrayManager.CreateInitialDataSets;
  frmGoPhast.PhastModel.UpdateSutraTimeListNames;
  UpdatedRequiredDataSets;
  if AdjustVerticalExag then
  begin
    frmGoPhast.UpdateVerticalExaggeration(VerticalExag);
  end;
  if (frmShowHideObjects <> nil) and (frmShowHideObjects.Visible) then
  begin
    frmShowHideObjects.UpdateScreenObjects;
  end;
  if FNewMeshType <> FOldMeshType then
  begin
    frmGoPhast.PhastModel.InvalidateSegments;
    frmGoPhast.frameTopView.MagnificationChanged := True;
    frmGoPhast.frameFrontView.MagnificationChanged := True;
    frmGoPhast.InvalidateAllViews;
  end;
end;

procedure TUndoChangeSutraOptions.Undo;
var
  AdjustVerticalExag: Boolean;
  VerticalExag: Double;
begin
  inherited;
  AdjustVerticalExag := (FNewMeshType = mtProfile) <> (FOldMeshType = mtProfile);
  if AdjustVerticalExag then
  begin
    VerticalExag := frmGoPhast.PhastModel.Exaggeration;
  end
  else
  begin
    VerticalExag := 0;
  end;
  if frmGoPhast.PhastModel.SutraMesh <> nil then
  begin
    frmGoPhast.PhastModel.SutraMesh.MeshType := FOldMeshType;
    frmGoPhast.splitHoriz.Minimized :=
      frmGoPhast.PhastModel.SutraMesh.MeshType <> mt3D;
  end;
  frmGoPhast.PhastModel.SutraOptions := FOldSutraOptions;
  frmGoPhast.PhastModel.SutraLayerStructure.Loaded;
  frmGoPhast.PhastModel.DataArrayManager.CreateInitialDataSets;
  frmGoPhast.PhastModel.UpdateSutraTimeListNames;
  UpdatedRequiredDataSets;
  if AdjustVerticalExag then
  begin
    frmGoPhast.UpdateVerticalExaggeration(VerticalExag);
  end;
  if (frmShowHideObjects <> nil) and (frmShowHideObjects.Visible) then
  begin
    frmShowHideObjects.UpdateScreenObjects;
  end;
  if FNewMeshType <> FOldMeshType then
  begin
    frmGoPhast.PhastModel.InvalidateSegments;
    frmGoPhast.frameTopView.MagnificationChanged := True;
    frmGoPhast.frameFrontView.MagnificationChanged := True;
    frmGoPhast.InvalidateAllViews;
  end;
end;

end.
