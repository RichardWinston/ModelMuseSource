unit frmEditFeatureFormulaUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmCustomGoPhastUnit, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, ScreenObjectUnit, System.Generics.Collections,
  ModflowEvtUnit, ModflowRchUnit, ModflowBoundaryUnit, ModflowEtsUnit,
  ModflowSfrUnit, ModflowUzfUnit, UndoItemsScreenObjects, Vcl.ComCtrls;

type
  TMfFeatureType = (ftCHD, ftFhbHead, ftFhbFlow, ftRCH, ftWEL, ftDRN, ftDRT,
    ftETS, ftEVT, ftGHB, ftLAK, ftMNW1, ftMNW2, ftRES, ftRIV, ftSFR, ftSTR,
    ftUZF, ftMt3dms, ftCfpFixed, ftCfpPipes, ftCfpRecharge, ftSwrReach,
    ftSwrRain, ftSwrET, ftSwrLateralInflow, ftSwrDirectRunoff, ftSwrStage,
    ftFmpFarmID, ftFmpCropID, ftFmpRefEvap, ftFmpPrecip, ftFmpWell);

  TMfFeatureTypes = set of TMfFeatureType;

  TModflowFeatureTypeSelection = class(TObject)
  private
    FFeatureType: TMfFeatureType;
    FFeatureName: string;
    FScreenObjects: TScreenObjectList;
    FNode: TTreeNode;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TModflowFeatureSelectionObjectList = TObjectList<TModflowFeatureTypeSelection>;

  TfrmEditFeatureFormula = class(TfrmCustomGoPhast)
    pnlBottom: TPanel;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    btnHelp: TBitBtn;
    pnlTop: TPanel;
    memoFormula: TMemo;
    tvFeatures: TTreeView;
    spl1: TSplitter;
    pnlControls: TPanel;
    btnEditFormula: TButton;
    lblTotalObjects: TLabel;
    comboEndingTime: TComboBox;
    comboStartingTime: TComboBox;
    comboAllTimes: TComboBox;
    lblStartingTime: TLabel;
    lblEndingTime: TLabel;
    procedure FormCreate(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure btnOKClick(Sender: TObject);
    procedure comboAllTimesChange(Sender: TObject);
    procedure btnEditFormulaClick(Sender: TObject);
    procedure tvFeaturesChange(Sender: TObject; Node: TTreeNode);
    procedure tvFeaturesHint(Sender: TObject; const Node: TTreeNode;
      var Hint: string);
    procedure memoFormulaChange(Sender: TObject);
  private
    FMfFeatureTypes: TMfFeatureTypes;
    FSelectedMFFeatureTypes: TModflowFeatureSelectionObjectList;
    FScreenObjects: TScreenObjectList;
    procedure GetObjectsOfSelectedType(
      SelectedType: TModflowFeatureTypeSelection);
    procedure SetData;
    function FeatureTypeToBoundary(FeatureType: TMfFeatureType;
      ScreenObject: TScreenObject): TModflowBoundary;
    // See also   @link(TfrmScreenObjectProperties.FillPropertyCollection).
    procedure FillPropertyCollection(Collection: TScreenObjectEditCollection;
      List: TScreenObjectList);
    procedure GetItemsOfSelectedFeature2(
      SelectedType: TModflowFeatureTypeSelection);
    procedure AddBoundaryParam2(Boundary: TModflowBoundary; ANode: TTreeNode);
    procedure GetRchParam2(RchBoundary: TRchBoundary; ANode: TTreeNode);
    procedure GetEtsParam2(EtsBoundary: TEtsBoundary; ANode: TTreeNode);
    procedure GetEvtParam2(EvtBoundary: TEvtBoundary; ANode: TTreeNode);
    procedure GetSfrParam2(SfrBoundary: TSfrBoundary; ANode: TTreeNode);
    procedure GetUzfParam2(UzfBoundary: TUzfBoundary; ANode: TTreeNode);
    procedure EnableOkButton;
    { Private declarations }
  public
    procedure GetData(ScreenObjects: TScreenObjectList);
    { Public declarations }
  end;


implementation

uses
  frmGoPhastUnit, PhastModelUnit, GoPhastTypes, ModflowPackagesUnit,
  ModflowConstantHeadBoundaryUnit, RbwParser, ModflowMnw2Unit,
  ModflowCfpFixedUnit, ModflowCfpPipeUnit, frmFormulaUnit, DataSetUnit,
  ModflowStrUnit;

resourcestring
  StrNoObjectsOfTheSe = 'No objects of the selected type were selected for e' +
  'diting';
  StrObjectsWithSelecte = 'Objects with selected feature: %d';
  StrSelectedObjectsD = 'Number of objects = %d';
  StrHeadsIn = 'Heads in ';
  StrTheDataTypeRequir = 'The data type required is %0:s but the formula g' +
  'ives %1:s.';
  Str0dOutOf1dSel = '%0:d objects selected out of %1:d';

{$R *.dfm}

{ TfrmEditFeatureFormula }

procedure TfrmEditFeatureFormula.btnEditFormulaClick(Sender: TObject);
var
  Formula: string;
  TimeList: TModflowTimeList;
  DataType: TRbwDataType;
  frmFormula: TfrmFormula;
  DataArrayManager: TDataArrayManager;
  DataSetIndex: Integer;
  DataArray: TDataArray;
  ResultDataType: TRbwDataType;
  ResultTypeString: string;
  RequiredTypeString: string;
  ErrorMessage: string;
  OkResultType: Boolean;
begin
  inherited;
  TimeList := nil;
  Formula := Trim(memoFormula.Text);
  if (tvFeatures.Selected <> nil)
    and (tvFeatures.Selected.Parent <> nil)
    and (tvFeatures.Selected.Parent.Data <> nil) then
  begin
    TimeList := tvFeatures.Selected.Data;
    if TimeList <> nil then
    begin
      DataType := TimeList.DataType;
    end
    else
    begin
      DataType := rdtDouble;
    end;
  end
  else
  begin
    DataType := rdtDouble;
  end;
  frmFormula := TfrmFormula.Create(nil);
  try
    frmFormula.IncludeGIS_Functions(eaBlocks);

    if TimeList <> nil then
    begin
      DataArrayManager := frmGoPhast.PhastModel.DataArrayManager;
      for DataSetIndex := 0 to DataArrayManager.DataSetCount - 1 do
      begin
        DataArray := DataArrayManager.DataSets[DataSetIndex];
        if DataArray.Visible and (DataArray.EvaluatedAt = eaBlocks) then
        begin
          case DataArray.DataType of
            rdtDouble: frmFormula.rbFormulaParser.CreateVariable(DataArray.Name,
              DataArray.Classification, 0.0, DataArray.DisplayName);
            rdtInteger: frmFormula.rbFormulaParser.CreateVariable(DataArray.Name,
              DataArray.Classification, 0, DataArray.DisplayName);
            rdtBoolean: frmFormula.rbFormulaParser.CreateVariable(DataArray.Name,
              DataArray.Classification, True, DataArray.DisplayName);
            rdtString: frmFormula.rbFormulaParser.CreateVariable(DataArray.Name,
              DataArray.Classification, ' ', DataArray.DisplayName);
            else Assert(False);
          end;
        end;
      end;
    end;

    frmFormula.UpdateTreeList;
    frmFormula.Formula := Formula;
    frmFormula.ShowModal;
    if frmFormula.ResultSet then
    begin
      Formula := frmFormula.Formula;
      frmFormula.rbFormulaParser.Compile(Formula);
      ResultDataType := frmFormula.rbFormulaParser.CurrentExpression.ResultType;
      OkResultType := (ResultDataType = DataType)
        or ((ResultDataType = rdtInteger) and (DataType = rdtDouble));
      if not OkResultType then
      begin
        ResultTypeString := DataTypeToString(ResultDataType);
        RequiredTypeString := DataTypeToString(DataType);
        ErrorMessage := Format(StrTheDataTypeRequir,
          [RequiredTypeString, ResultTypeString]);
        Beep;
        MessageDlg(ErrorMessage, mtError, [mbOK], 0);
      end;
      memoFormula.Text := frmFormula.Formula;
    end;
  finally
    frmFormula.Free;
  end;
end;

procedure TfrmEditFeatureFormula.btnOKClick(Sender: TObject);
begin
  inherited;
  SetData;
end;

procedure TfrmEditFeatureFormula.comboAllTimesChange(Sender: TObject);
begin
  inherited;
  comboStartingTime.Enabled := comboAllTimes.ItemIndex = 1;
  comboEndingTime.Enabled := comboStartingTime.Enabled;
  if comboStartingTime.Enabled and (comboStartingTime.Text = '') then
  begin
    comboStartingTime.ItemIndex := 0
  end;
  if comboEndingTime.Enabled and (comboEndingTime.Text = '') then
  begin
    comboEndingTime.ItemIndex := 0
  end;
end;

procedure TfrmEditFeatureFormula.FormCreate(Sender: TObject);
begin
  inherited;
  FSelectedMFFeatureTypes := TModflowFeatureSelectionObjectList.Create;

  frmGoPhast.PhastModel.ModflowStressPeriods.FillStringsWithStartTimes(comboStartingTime.Items);
  frmGoPhast.PhastModel.ModflowStressPeriods.FillStringsWithEndTimes(comboEndingTime.Items);
end;

procedure TfrmEditFeatureFormula.FormDestroy(Sender: TObject);
begin
  inherited;
  FSelectedMFFeatureTypes.Free;
end;

procedure TfrmEditFeatureFormula.GetData(ScreenObjects: TScreenObjectList);
var
  Model: TPhastModel;
  Packages: TModflowPackages;
  PackageList: TList<TModflowPackages>;
  AModel: TChildModel;
  PackgeIndex: Integer;
  ModelIndex: Integer;
  FeatureSelection: TModflowFeatureTypeSelection;
  FeatureIndex: Integer;
  SelectedNode: TTreeNode;
  MaxScreenObjectsObjects: Integer;
begin
  FScreenObjects := ScreenObjects;
  lblTotalObjects.Caption := Format(StrSelectedObjectsD,
    [FScreenObjects.Count]);
  Model := frmGoPhast.PhastModel;
  case Model.ModelSelection of
    msPhast:
      begin

      end;
    msModflow, msModflowLGR, msModflowLGR2, msModflowNWT, msModflowFmp,
      msModflowCfp, msModflow2015:
      begin
        PackageList := TList<TModflowPackages>.Create;
        try
          PackageList.Add(Model.ModflowPackages);
          for ModelIndex := 0 to Model.ChildModels.Count - 1 do
          begin
            AModel := Model.ChildModels[ModelIndex].ChildModel;
            PackageList.Add(AModel.ModflowPackages);
          end;
          FMfFeatureTypes := [];
          for PackgeIndex := 0 to PackageList.Count - 1 do
          begin
            Packages := PackageList[PackgeIndex];
            if Packages.ChdBoundary.IsSelected then
            begin
              Include(FMfFeatureTypes, ftCHD);
            end;
            if Packages.FhbPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftFhbHead);
              Include(FMfFeatureTypes, ftFhbFlow);
            end;
            if Packages.RchPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftRCH);
            end;
            if Packages.WelPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftWEL);
            end;
            if Packages.DrnPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftDRN);
            end;
            if Packages.DrtPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftDRT);
            end;
            if Packages.EtsPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftETS);
            end;
            if Packages.EvtPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftEVT);
            end;
            if Packages.GhbBoundary.IsSelected then
            begin
              Include(FMfFeatureTypes, ftGHB);
            end;
            if Packages.LakPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftLAK);
            end;
            if Packages.Mnw1Package.IsSelected then
            begin
              Include(FMfFeatureTypes, ftMNW1);
            end;
            if Packages.Mnw2Package.IsSelected then
            begin
              Include(FMfFeatureTypes, ftMNW2);
            end;
            if Packages.ResPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftRES);
            end;
            if Packages.RivPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftRIV);
            end;
            if Packages.SfrPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftSFR);
            end;
            if Packages.StrPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftSTR);
            end;
            if Packages.UzfPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftUZF);
            end;
            if Packages.Mt3dBasic.IsSelected
              and Packages.Mt3dmsSourceSink.IsSelected then
            begin
              Include(FMfFeatureTypes, ftMt3dms);
            end;
            if Packages.ConduitFlowProcess.IsSelected
              and Packages.ConduitFlowProcess.PipesUsed then
            begin
              Include(FMfFeatureTypes, ftCfpFixed);
              Include(FMfFeatureTypes, ftCfpPipes);
              if Packages.ConduitFlowProcess.ConduitRechargeUsed then
              begin
                Include(FMfFeatureTypes, ftCfpRecharge);
              end;
            end;
            if Packages.SwrPackage.IsSelected then
            begin
              Include(FMfFeatureTypes, ftSwrReach);
              Include(FMfFeatureTypes, ftSwrRain);
              Include(FMfFeatureTypes, ftSwrET);
              Include(FMfFeatureTypes, ftSwrLateralInflow);
              Include(FMfFeatureTypes, ftSwrDirectRunoff);
              Include(FMfFeatureTypes, ftSwrStage);
            end;
            if Packages.FarmProcess.IsSelected then
            begin
              Include(FMfFeatureTypes, ftFmpFarmID);
              Include(FMfFeatureTypes, ftFmpCropID);
              Include(FMfFeatureTypes, ftFmpRefEvap);
              Include(FMfFeatureTypes, ftFmpPrecip);
              Include(FMfFeatureTypes, ftFmpWell);
            end;
          end;

          Packages := PackageList[0];
          if ftCHD in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftCHD;
            FeatureSelection.FFeatureName :=
              Packages.ChdBoundary.PackageIdentifier;
          end;
          if ftDRN in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftDRN;
            FeatureSelection.FFeatureName :=
              Packages.DrnPackage.PackageIdentifier;
          end;
          if ftDRT in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftDRT;
            FeatureSelection.FFeatureName :=
              Packages.DrtPackage.PackageIdentifier;
          end;
          if ftETS in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftETS;
            FeatureSelection.FFeatureName :=
              Packages.EtsPackage.PackageIdentifier;
          end;
          if ftEVT in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftEVT;
            FeatureSelection.FFeatureName :=
              Packages.EvtPackage.PackageIdentifier;
          end;
          if ftFhbFlow in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftFhbFlow;
            FeatureSelection.FFeatureName :=
              Packages.FhbPackage.PackageIdentifier;
          end;
          if ftFhbHead in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftFhbHead;
            FeatureSelection.FFeatureName :=
              Packages.FhbPackage.PackageIdentifier;
          end;
          if ftGHB in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftGHB;
            FeatureSelection.FFeatureName :=
              Packages.GhbBoundary.PackageIdentifier;
          end;
          if ftLAK in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftLAK;
            FeatureSelection.FFeatureName :=
              Packages.LakPackage.PackageIdentifier;
          end;
          if ftMNW1 in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftMNW1;
            FeatureSelection.FFeatureName :=
              Packages.Mnw1Package.PackageIdentifier;
          end;
          if ftMNW2 in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftMNW2;
            FeatureSelection.FFeatureName :=
              Packages.Mnw2Package.PackageIdentifier;
          end;
          if ftRCH in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftRCH;
            FeatureSelection.FFeatureName :=
              Packages.RchPackage.PackageIdentifier;
          end;
          if ftRES in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftRES;
            FeatureSelection.FFeatureName :=
              Packages.ResPackage.PackageIdentifier;
          end;
          if ftRIV in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftRIV;
            FeatureSelection.FFeatureName :=
              Packages.RivPackage.PackageIdentifier;
          end;
          if ftSFR in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftSFR;
            FeatureSelection.FFeatureName :=
              Packages.SfrPackage.PackageIdentifier;
          end;
          if ftSTR in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftSTR;
            FeatureSelection.FFeatureName :=
              Packages.StrPackage.PackageIdentifier;
          end;
          if ftUZF in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftUZF;
            FeatureSelection.FFeatureName :=
              Packages.UzfPackage.PackageIdentifier;
          end;
          if ftWEL in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftWEL;
            FeatureSelection.FFeatureName :=
              Packages.WelPackage.PackageIdentifier;
          end;
          if ftCfpPipes in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftCfpPipes;
            FeatureSelection.FFeatureName := 'Pipes in ' +
              Packages.ConduitFlowProcess.PackageIdentifier;
          end;
          if ftCfpFixed in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftCfpFixed;
            FeatureSelection.FFeatureName := 'Fixed Head in ' +
              Packages.ConduitFlowProcess.PackageIdentifier;
          end;
          if ftCfpRecharge in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftCfpRecharge;
            FeatureSelection.FFeatureName := 'Recharge in ' +
              Packages.ConduitFlowProcess.PackageIdentifier;
          end;
          if ftFmpFarmID in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftFmpFarmID;
            FeatureSelection.FFeatureName := 'Farm ID in ' +
              Packages.FarmProcess.PackageIdentifier;
          end;
          if ftFmpWell in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftFmpWell;
            FeatureSelection.FFeatureName := 'Farm Well in ' +
              Packages.FarmProcess.PackageIdentifier;
          end;
          if ftFmpCropID in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftFmpCropID;
            FeatureSelection.FFeatureName := 'Crop ID in ' +
              Packages.FarmProcess.PackageIdentifier;
          end;
          if ftFmpPrecip in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftFmpPrecip;
            FeatureSelection.FFeatureName := 'Precipitation in ' +
              Packages.FarmProcess.PackageIdentifier;
          end;
          if ftFmpRefEvap in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftFmpRefEvap;
            FeatureSelection.FFeatureName := 'Reference Evaporation in ' +
              Packages.FarmProcess.PackageIdentifier;
          end;
          if ftMt3dms in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftMt3dms;
            FeatureSelection.FFeatureName :=
              Packages.Mt3dmsSourceSink.PackageIdentifier;
          end;
          if ftSwrReach in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftSwrReach;
            FeatureSelection.FFeatureName := 'Reach Information in ' +
              Packages.SwrPackage.PackageIdentifier;
          end;
          if ftSwrRain in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftSwrRain;
            FeatureSelection.FFeatureName := 'Rain in ' +
              Packages.SwrPackage.PackageIdentifier;
          end;
          if ftSwrET in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftSwrET;
            FeatureSelection.FFeatureName := 'Evapotranspiration in ' +
              Packages.SwrPackage.PackageIdentifier;
          end;
          if ftSwrLateralInflow in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftSwrLateralInflow;
            FeatureSelection.FFeatureName := 'Lateral Inflow in ' +
              Packages.SwrPackage.PackageIdentifier;
          end;
          if ftSwrStage in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftSwrStage;
            FeatureSelection.FFeatureName := 'Stage in ' +
              Packages.SwrPackage.PackageIdentifier;
          end;
          if ftSwrDirectRunoff in FMfFeatureTypes then
          begin
            FeatureSelection := TModflowFeatureTypeSelection.Create;
            FSelectedMFFeatureTypes.Add(FeatureSelection);
            FeatureSelection.FFeatureType := ftSwrDirectRunoff;
            FeatureSelection.FFeatureName := 'Direct Runoff in ' +
              Packages.SwrPackage.PackageIdentifier;
          end;

          for FeatureIndex := FSelectedMFFeatureTypes.Count - 1 downto 0 do
          begin
            FeatureSelection := FSelectedMFFeatureTypes[FeatureIndex];
            GetObjectsOfSelectedType(FeatureSelection);
            if FeatureSelection.FScreenObjects.Count = 0 then
            begin
              FSelectedMFFeatureTypes.Delete(FeatureIndex);
            end;
          end;

          MaxScreenObjectsObjects := 0;
          SelectedNode := nil;
          for FeatureIndex := 0 to FSelectedMFFeatureTypes.Count - 1 do
          begin
            FeatureSelection := FSelectedMFFeatureTypes[FeatureIndex];
            FeatureSelection.FNode := tvFeatures.Items.AddObject(nil,
              FeatureSelection.FFeatureName, FeatureSelection);
            GetItemsOfSelectedFeature2(FeatureSelection);
            if FeatureSelection.FScreenObjects.Count > MaxScreenObjectsObjects then
            begin
              MaxScreenObjectsObjects := FeatureSelection.FScreenObjects.Count;
              SelectedNode := FeatureSelection.FNode;
            end;
          end;

          if SelectedNode <> nil then
          begin
            tvFeatures.Selected := SelectedNode.getFirstChild;
          end;

        finally
          PackageList.Free;
        end;
      end;
    msSutra22, msSutra30, msFootPrint:
      begin

      end;
    else Assert(False);
  end;
end;

procedure TfrmEditFeatureFormula.EnableOkButton;
var
  Node: TTreeNode;
begin
  Node := tvFeatures.Selected;
  btnOK.Enabled := (Node <> nil)
    and (Node.Parent <> nil)
    and (Node.Parent.Data <> nil)
    and (memoFormula.Text <> '');
end;

procedure TfrmEditFeatureFormula.AddBoundaryParam2(Boundary: TModflowBoundary; ANode: TTreeNode);
var
  TimeListIndex: Integer;
  TimeList: TModflowTimeList;
begin
  for TimeListIndex := 0 to Boundary.Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := Boundary.Values.TimeLists[TimeListIndex, frmGoPhast.PhastModel];
    tvFeatures.Items.AddChildObject(ANode, TimeList.NonParamDescription, TimeList)
//    comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
  end;
end;


procedure TfrmEditFeatureFormula.GetItemsOfSelectedFeature2(
  SelectedType: TModflowFeatureTypeSelection);
var
  FirstScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  ObjectIndex: Integer;
  AScreenObject: TScreenObject;
  EvtBoundary: TEvtBoundary;
  RchBoundary: TRchBoundary;
  EtsBoundary: TEtsBoundary;
  SfrBoundary: TSfrBoundary;
  UZFBoundary: TUzfBoundary;
begin
  FirstScreenObject := SelectedType.FScreenObjects[0];
//  Boundary := nil;
  case SelectedType.FFeatureType of
    ftCHD, ftWEL, ftDRN, ftDRT, ftGHB, ftLAK, ftMNW1, ftRES, ftRIV, ftSTR,
      ftMt3dms, ftCfpRecharge, ftSwrReach, ftSwrRain, ftSwrET,
      ftSwrLateralInflow, ftSwrDirectRunoff, ftSwrStage, ftFmpFarmID,
      ftFmpCropID, ftFmpRefEvap, ftFmpPrecip, ftFmpWell:
      begin
        Boundary := FeatureTypeToBoundary(SelectedType.FFeatureType, FirstScreenObject);
        AddBoundaryParam2(Boundary, SelectedType.FNode);
      end;
    ftFhbHead, ftFhbFlow:
      begin
        for ObjectIndex := 0 to FScreenObjects.Count - 1 do
        begin
          AScreenObject := FScreenObjects[ObjectIndex];
          Boundary := FeatureTypeToBoundary(SelectedType.FFeatureType, AScreenObject);
          if Boundary <> nil then
          begin
            AddBoundaryParam2(Boundary, SelectedType.FNode);
            Break;
          end;
        end;
      end;
    ftRCH:
      begin
        RchBoundary := FirstScreenObject.ModflowRchBoundary;
        AddBoundaryParam2(RchBoundary, SelectedType.FNode);
        GetRchParam2(RchBoundary, SelectedType.FNode);
      end;
    ftETS:
      begin
        EtsBoundary := FirstScreenObject.ModflowEtsBoundary;
        AddBoundaryParam2(EtsBoundary, SelectedType.FNode);
        GetEtsParam2(EtsBoundary, SelectedType.FNode);
      end;
    ftEVT:
      begin
        EvtBoundary := FirstScreenObject.ModflowEvtBoundary;
        AddBoundaryParam2(EvtBoundary, SelectedType.FNode);
        GetEvtParam2(EvtBoundary, SelectedType.FNode);
      end;
    ftMNW2:
      begin
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Pumping Rate');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Head Capacity Multiplier');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Limiting Water Level');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Inactivation Pumping Rate');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Reactivation Pumping Rate');
      end;
    ftSFR:
      begin
        SfrBoundary := FirstScreenObject.ModflowSfrBoundary;
        AddBoundaryParam2(SfrBoundary, SelectedType.FNode);
        GetSfrParam2(SfrBoundary, SelectedType.FNode);
      end;
    ftUZF:
      begin
        UZFBoundary := FirstScreenObject.ModflowUzfBoundary;
        AddBoundaryParam2(UZFBoundary, SelectedType.FNode);
        GetUzfParam2(UZFBoundary, SelectedType.FNode);
      end;
    ftCfpFixed:
      begin
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Fixed Head');
      end;
    ftCfpPipes:
      begin
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Diameter');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Tortuosity');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Roughness Height');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Lower Critical R');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Higher Critical R');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Conductance Permeability');
        tvFeatures.Items.AddChild(SelectedType.FNode, 'Elevation');
      end;
    else Assert(False);
  end;
//  if comboFeatureProperty.Items.Count = 1 then
//  begin
//    comboFeatureProperty.ItemIndex := 0;
//  end;
end;


procedure TfrmEditFeatureFormula.GetUzfParam2(UzfBoundary: TUzfBoundary; ANode: TTreeNode);
var
  TimeListIndex: Integer;
  TimeList: TModflowTimeList;
begin
  for TimeListIndex := 0 to UzfBoundary.EvapotranspirationDemand.TimeListCount(
    frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := UzfBoundary.EvapotranspirationDemand.TimeLists[TimeListIndex,
      frmGoPhast.PhastModel];
    tvFeatures.Items.AddChildObject(ANode, TimeList.NonParamDescription, TimeList)
//    comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
  end;
  for TimeListIndex := 0 to UzfBoundary.ExtinctionDepth.TimeListCount(
    frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := UzfBoundary.ExtinctionDepth.TimeLists[TimeListIndex,
      frmGoPhast.PhastModel];
    tvFeatures.Items.AddChildObject(ANode, TimeList.NonParamDescription, TimeList)
//    comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
  end;
  for TimeListIndex := 0 to UzfBoundary.WaterContent.TimeListCount(
    frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := UzfBoundary.WaterContent.TimeLists[TimeListIndex,
      frmGoPhast.PhastModel];
    tvFeatures.Items.AddChildObject(ANode, TimeList.NonParamDescription, TimeList)
//    comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
  end;
end;

procedure TfrmEditFeatureFormula.memoFormulaChange(Sender: TObject);
begin
  inherited;
  EnableOkButton;
end;

procedure TfrmEditFeatureFormula.GetSfrParam2(SfrBoundary: TSfrBoundary; ANode: TTreeNode);
var
  TimeListIndex: Integer;
  TimeList: TModflowTimeList;
begin
    // SfrBoundary.ChannelValues
  tvFeatures.Items.AddChild(ANode, 'Channel Roughness');
  tvFeatures.Items.AddChild(ANode, 'Bank Roughness');
  for TimeListIndex := 0 to SfrBoundary.UpstreamSegmentValues.TimeListCount(frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := SfrBoundary.UpstreamSegmentValues.TimeLists[TimeListIndex,
      frmGoPhast.PhastModel];
    tvFeatures.Items.AddChildObject(ANode, 'Upstream ' + TimeList.NonParamDescription, TimeList)
  end;
  for TimeListIndex := 0 to SfrBoundary.DownstreamSegmentValues.TimeListCount(frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := SfrBoundary.DownstreamSegmentValues.TimeLists[TimeListIndex,
      frmGoPhast.PhastModel];
    tvFeatures.Items.AddChildObject(ANode, 'Downstream ' + TimeList.NonParamDescription, TimeList)
  end;
  for TimeListIndex := 0 to SfrBoundary.UpstreamUnsatSegmentValues.TimeListCount(frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := SfrBoundary.UpstreamUnsatSegmentValues.TimeLists[TimeListIndex,
      frmGoPhast.PhastModel];
    tvFeatures.Items.AddChildObject(ANode, 'Upstream ' + TimeList.NonParamDescription, TimeList)
  end;
  for TimeListIndex := 0 to SfrBoundary.DownstreamUnsatSegmentValues.TimeListCount(frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := SfrBoundary.DownstreamUnsatSegmentValues.TimeLists[TimeListIndex,
      frmGoPhast.PhastModel];
    tvFeatures.Items.AddChildObject(ANode, 'Downstream ' + TimeList.NonParamDescription, TimeList)
  end;
//  for TimeListIndex := 0 to SfrBoundary.TableCollection.Count - 1 do
//  begin
//    TimeList := SfrBoundary.TableCollection.TimeLists[TimeListIndex,
//      frmGoPhast.PhastModel];
//    comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
//  end;

  // SfrBoundary.SegmentFlows
  tvFeatures.Items.AddChild(ANode, 'Flow');
  tvFeatures.Items.AddChild(ANode, 'Precipitation');
  tvFeatures.Items.AddChild(ANode, 'Evapotranspiration');
  tvFeatures.Items.AddChild(ANode, 'Runnoff');

  // SfrBoundary.EquationValues
  tvFeatures.Items.AddChild(ANode, 'Depth Coefficient');
  tvFeatures.Items.AddChild(ANode, 'Depth Exponent');
  tvFeatures.Items.AddChild(ANode, 'Width Coefficient');
  tvFeatures.Items.AddChild(ANode, 'Width Exponent');

//  for TimeListIndex := 0 to SfrBoundary.ParamIcalc.Count - 1 do
//  begin
//    TimeList := SfrBoundary.ParamIcalc.TimeLists[TimeListIndex,
//      frmGoPhast.PhastModel];
//    comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
//  end;
end;

procedure TfrmEditFeatureFormula.SetData;
const
  SfrChannelRoughnessFormulas = 2;
  SegmentFlowFormulas = 4;
  EquationFlowFormulas = 4;
var
  SelectedType: TModflowFeatureTypeSelection;
  UseAllTimes: Boolean;
  StartTime: double;
  EndTime: double;
  ObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
  RchBoundary: TRchBoundary;
  EtsBoundary: TEtsBoundary;
  EvtBoundary: TEvtBoundary;
  SfrBoundary: TSfrBoundary;
  UZFBoundary: TUzfBoundary;
  Formula: string;
  FormulaIndex: Integer;
  OldProperties: TScreenObjectEditCollection;
  NewProperties: TScreenObjectEditCollection;
  ModifiedObjectList: TList;
  Undo: TUndoSetScreenObjectProperties;
  Dummy: TList;
  Mnw2Boundary: TMnw2Boundary;
  TimeIndex: Integer;
  TimeItem: TMnw2TimeItem;
  SfrFormulaIndex: Integer;
  CfpFixedHeads: TCfpFixedBoundary;
  CfpPipes: TCfpPipeBoundary;
  Number: integer;
  StrBoundary: TStrBoundary;
  AnStrItem: TStrItem;
  procedure SetItemFormula(AnItem: TCustomModflowBoundaryItem;
    FormulaIndex: Integer);
  begin
    if UseAllTimes then
    begin
      AnItem.BoundaryFormula[FormulaIndex] := Formula;
    end
    else
    begin
      if (AnItem.StartTime >= StartTime) and (AnItem.EndTime <= EndTime) then
      begin
        AnItem.BoundaryFormula[FormulaIndex] := Formula;
      end;
    end;
  end;
  procedure SetCollectionFormula(Collection: TCustomNonSpatialBoundColl;
    FormulaIndex: integer);
  var
    TimeIndex: Integer;
    AnItem: TCustomModflowBoundaryItem;
  begin
    for TimeIndex := 0 to Collection.Count - 1 do
    begin
      AnItem := Collection[TimeIndex] as TCustomModflowBoundaryItem;
      SetItemFormula(AnItem, FormulaIndex);
    end;
  end;
  procedure SetValueParamFormula(Boundary: TModflowBoundary);
  var
    ParamBoundary: TModflowParamBoundary;
    ParamIndex: Integer;
    AParam: TModflowParamItem;
  begin
    Assert(Boundary <> nil);
    SetCollectionFormula(Boundary.Values, FormulaIndex);
    if Boundary is TModflowParamBoundary  then
    begin
      ParamBoundary := TModflowParamBoundary(Boundary);
      for ParamIndex := 0 to ParamBoundary.Parameters.Count -1 do
      begin
        AParam := ParamBoundary.Parameters[ParamIndex];
        SetCollectionFormula(AParam.Param, FormulaIndex);
      end;
    end;
  end;
begin
  SelectedType := tvFeatures.Selected.Parent.Data;
  Assert(SelectedType <> nil);
  Formula := memoFormula.Text;
  try
    frmGoPhast.PhastModel.rpThreeDFormulaCompiler.Compile(Formula);
  except on ERbwParserError do
    begin
      Beep;
      MessageDlg('Invalid Formula', mtError, [mbOK], 0);
      Exit;
    end;
  end;

  OldProperties := TScreenObjectEditCollection.Create;
  NewProperties := TScreenObjectEditCollection.Create;
  ModifiedObjectList := TList.Create;
  Screen.Cursor := crHourGlass;
  try
    OldProperties.OwnScreenObject := True;
    NewProperties.OwnScreenObject := True;

    FillPropertyCollection(OldProperties, SelectedType.FScreenObjects);

//    Assert(comboFeatureType.ItemIndex >= 0);
//    FormulaIndex := comboFeatureProperty.ItemIndex;
    FormulaIndex := tvFeatures.Selected.Parent.IndexOf(tvFeatures.Selected);
    Assert(FormulaIndex >= 0);
//    SelectedType := TModflowFeatureTypeSelection(
//      comboFeatureType.Items.Objects[comboFeatureType.ItemIndex]);
    UseAllTimes := comboAllTimes.ItemIndex = 0;
    if not UseAllTimes then
    begin
      StartTime := StrToFloat(comboStartingTime.Text);
      EndTime := StrToFloat(comboEndingTime.Text);
    end;
    for ObjectIndex := 0 to SelectedType.FScreenObjects.Count -1 do
    begin
      ScreenObject := SelectedType.FScreenObjects[ObjectIndex];
      ModifiedObjectList.Add(ScreenObject);
      case SelectedType.FFeatureType of
        ftCHD, ftWEL, ftDRN, ftDRT, ftGHB, ftLAK, ftMNW1, ftRES, ftRIV,
          ftFhbHead, ftFhbFlow, ftMt3dms, ftCfpRecharge, ftSwrReach, ftSwrRain,
          ftSwrET, ftSwrLateralInflow, ftSwrDirectRunoff, ftSwrStage,
          ftFmpFarmID, ftFmpCropID, ftFmpRefEvap, ftFmpPrecip, ftFmpWell:
          begin
            Boundary := FeatureTypeToBoundary(SelectedType.FFeatureType,
              ScreenObject);
            SetValueParamFormula(Boundary);
          end;
        ftRCH:
          begin
            RchBoundary := ScreenObject.ModflowRchBoundary;
            case FormulaIndex of
              0:
                begin
                  SetValueParamFormula(RchBoundary);
                end;
              1:
                begin
                  SetCollectionFormula(RchBoundary.RechargeLayers, 0);
                end;
              else Assert(False);
            end;
          end;
        ftETS:
          begin
            EtsBoundary := ScreenObject.ModflowEtsBoundary;
            if FormulaIndex = 0 then
            begin
              SetValueParamFormula(EtsBoundary);
            end
            else if frmGoPhast.PhastModel.ModflowPackages.EtsPackage.TimeVaryingLayers
              and (FormulaIndex = tvFeatures.Selected.Parent.Count-1) then
            begin
              SetCollectionFormula(EtsBoundary.EvapotranspirationLayers, 0);
            end
            else
            begin
              SetCollectionFormula(EtsBoundary.EtsSurfDepthCollection, FormulaIndex-1);
            end;
          end;
        ftEVT:
          begin
            EvtBoundary := ScreenObject.ModflowEvtBoundary;
            case FormulaIndex of
              0:
                begin
                  SetValueParamFormula(EvtBoundary);
                end;
              1,2:
                begin
                  SetCollectionFormula(EvtBoundary.EvtSurfDepthCollection,
                    FormulaIndex-1);
                end;
              3:
                begin
                  SetCollectionFormula(EvtBoundary.EvapotranspirationLayers, 0);
                end;
            end;
          end;
        ftMNW2:
          begin
            Mnw2Boundary := ScreenObject.ModflowMnw2Boundary;
            for TimeIndex := 0 to Mnw2Boundary.TimeValues.Count - 1 do
            begin
              TimeItem := Mnw2Boundary.TimeValues[TimeIndex] as TMnw2TimeItem;
              if UseAllTimes then
              begin
                TimeItem.BoundaryFormula[FormulaIndex] := Formula;
              end
              else
              begin
                if (TimeItem.StartTime >= StartTime) and (TimeItem.EndTime <= EndTime) then
                begin
                  TimeItem.BoundaryFormula[FormulaIndex] := Formula;
                end;
              end;
            end;
          end;
        ftSTR:
          begin
            Boundary := FeatureTypeToBoundary(SelectedType.FFeatureType,
              ScreenObject);
            if FormulaIndex <= StreamRoughnessPosition then
            begin
              SetValueParamFormula(Boundary);
            end
            else if FormulaIndex in [8..10] then
            begin
              if TryStrToInt(Formula, Number) then
              begin
                StrBoundary := Boundary as TStrBoundary;
                case FormulaIndex of
                  8:
                    begin
                      StrBoundary.SegmentNumber := Number;
                    end;
                  9:
                    begin
                      for TimeIndex := 0 to StrBoundary.Values.Count - 1 do
                      begin
                        AnStrItem := StrBoundary.Values[TimeIndex] as TStrItem;
                        if UseAllTimes then
                        begin
                          if (AnStrItem.StartTime >= StartTime)
                            and (AnStrItem.EndTime <= EndTime) then
                          begin
                            AnStrItem.OutflowSegment := Number;
                          end;
                        end
                        else
                        begin
                          AnStrItem.OutflowSegment := Number;
                        end;
                      end
                    end;
                  10:
                    begin
                      for TimeIndex := 0 to StrBoundary.Values.Count - 1 do
                      begin
                        AnStrItem := StrBoundary.Values[TimeIndex] as TStrItem;
                        if UseAllTimes then
                        begin
                          if (AnStrItem.StartTime >= StartTime) and (AnStrItem.EndTime <= EndTime) then
                          begin
                            AnStrItem.DiversionSegment := Number;
                          end;
                        end
                        else
                        begin
                          AnStrItem.DiversionSegment := Number;
                        end;
                      end
                    end;
                end;
              end;
            end;
          end;
        ftSFR:
          begin
            SfrBoundary := ScreenObject.ModflowSfrBoundary;
            SfrFormulaIndex := FormulaIndex;
            if SfrFormulaIndex < SfrBoundary.Values.TimeListCount(frmGoPhast.PhastModel) then
            begin
              SetValueParamFormula(SfrBoundary);
              Continue;
            end
            else
            begin
              SfrFormulaIndex := SfrFormulaIndex - SfrBoundary.Values.TimeListCount(frmGoPhast.PhastModel);
            end;

            if SfrFormulaIndex < SfrChannelRoughnessFormulas then
            begin
              SetCollectionFormula(SfrBoundary.ChannelValues, SfrFormulaIndex);
              Continue;
            end
            else
            begin
              SfrFormulaIndex := SfrFormulaIndex - SfrChannelRoughnessFormulas
            end;

            if SfrFormulaIndex < SfrBoundary.UpstreamSegmentValues.TimeListCount(frmGoPhast.PhastModel) then
            begin
              SetCollectionFormula(SfrBoundary.UpstreamSegmentValues, SfrFormulaIndex);
              Continue;
            end
            else
            begin
              SfrFormulaIndex := SfrFormulaIndex - SfrBoundary.UpstreamSegmentValues.TimeListCount(frmGoPhast.PhastModel);
            end;
            if SfrFormulaIndex < SfrBoundary.DownstreamSegmentValues.TimeListCount(frmGoPhast.PhastModel) then
            begin
              SetCollectionFormula(SfrBoundary.DownstreamSegmentValues, SfrFormulaIndex);
              Continue;
            end
            else
            begin
              SfrFormulaIndex := SfrFormulaIndex - SfrBoundary.DownstreamSegmentValues.TimeListCount(frmGoPhast.PhastModel);
            end;
            if SfrFormulaIndex < SfrBoundary.UpstreamUnsatSegmentValues.TimeListCount(frmGoPhast.PhastModel) then
            begin
              SetCollectionFormula(SfrBoundary.UpstreamUnsatSegmentValues, SfrFormulaIndex);
              Continue;
            end
            else
            begin
              SfrFormulaIndex := SfrFormulaIndex - SfrBoundary.UpstreamUnsatSegmentValues.TimeListCount(frmGoPhast.PhastModel);
            end;
            if SfrFormulaIndex < SfrBoundary.DownstreamUnsatSegmentValues.TimeListCount(frmGoPhast.PhastModel) then
            begin
              SetCollectionFormula(SfrBoundary.DownstreamUnsatSegmentValues, SfrFormulaIndex);
              Continue;
            end
            else
            begin
              SfrFormulaIndex := SfrFormulaIndex - SfrBoundary.DownstreamUnsatSegmentValues.TimeListCount(frmGoPhast.PhastModel);
            end;
            if SfrFormulaIndex < SegmentFlowFormulas then
            begin
              SetCollectionFormula(SfrBoundary.SegmentFlows, SfrFormulaIndex);
              Continue;
            end
            else
            begin
              SfrFormulaIndex := SfrFormulaIndex - SegmentFlowFormulas;
            end;
            if SfrFormulaIndex < EquationFlowFormulas then
            begin
              SetCollectionFormula(SfrBoundary.EquationValues, SfrFormulaIndex);
              Continue;
            end
            else
            begin
//              SfrFormulaIndex := SfrFormulaIndex - EquationFlowFormulas;
              Assert(False);
            end;
          end;
        ftUZF:
          begin
            UZFBoundary := ScreenObject.ModflowUzfBoundary;
            case FormulaIndex of
              0:
                begin
                  SetValueParamFormula(UZFBoundary);
                end;
              1:
                begin
                  SetCollectionFormula(UZFBoundary.EvapotranspirationDemand, 0);
                end;
              2:
                begin
                  SetCollectionFormula(UZFBoundary.ExtinctionDepth, 0);
                end;
              3:
                begin
                  SetCollectionFormula(UZFBoundary.WaterContent, 0);
                end;
              else Assert(False);
            end;
  //          AddBoundaryParam(UZFBoundary);
  //          GetUzfParam(UZFBoundary);
          end;
        ftCfpFixed:
          begin
            CfpFixedHeads := ScreenObject.ModflowCfpFixedHeads;
            CfpFixedHeads.FixedHead := Formula;
          end;
        ftCfpPipes:
          begin
            CfpPipes := ScreenObject.ModflowCfpPipes;
            CfpPipes.BoundaryFormula[FormulaIndex] := Formula;
          end;
        else Assert(False);
      end;
    end;
    FillPropertyCollection(NewProperties, SelectedType.FScreenObjects);

    Dummy := nil;
    Undo := TUndoSetScreenObjectProperties.Create(ModifiedObjectList,
      NewProperties, OldProperties, Dummy);

    Undo.UpdateObservations;
    frmGoPhast.UndoStack.Submit(Undo);

  finally
    OldProperties.Free;
    NewProperties.Free;
    ModifiedObjectList.Free;
    Screen.Cursor := crDefault;
  end;

end;

procedure TfrmEditFeatureFormula.tvFeaturesChange(Sender: TObject;
  Node: TTreeNode);
var
  SelectedType: TModflowFeatureTypeSelection;
begin
  inherited;
  EnableOkButton;
  if (Node <> nil)
    and (Node.Parent <> nil)
    and (Node.Parent.Data <> nil) then
  begin
    SelectedType := tvFeatures.Selected.Parent.Data;
    lblTotalObjects.Caption := Format(Str0dOutOf1dSel,
      [SelectedType.FScreenObjects.Count, FScreenObjects.Count]);
  end
  else
  begin
    lblTotalObjects.Caption := Format(StrSelectedObjectsD,
      [FScreenObjects.Count]);
  end;
end;

procedure TfrmEditFeatureFormula.tvFeaturesHint(Sender: TObject;
  const Node: TTreeNode; var Hint: string);
begin
  inherited;
  Hint := Node.Text;
end;

procedure TfrmEditFeatureFormula.GetEtsParam2(EtsBoundary: TEtsBoundary; ANode: TTreeNode);
var
  TimeListIndex: Integer;
  TimeList: TModflowTimeList;
begin
  for TimeListIndex := 0 to EtsBoundary.EtsSurfDepthCollection.TimeListCount(
    frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := EtsBoundary.EtsSurfDepthCollection.TimeLists[TimeListIndex,
      frmGoPhast.PhastModel];
    tvFeatures.Items.AddChildObject(ANode, TimeList.NonParamDescription, TimeList)
//    comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
  end;
  if frmGoPhast.PhastModel.ModflowPackages.EtsPackage.TimeVaryingLayers then
  begin
    for TimeListIndex := 0 to EtsBoundary.EvapotranspirationLayers.TimeListCount(
      frmGoPhast.PhastModel) - 1 do
    begin
      TimeList := EtsBoundary.EvapotranspirationLayers.TimeLists[TimeListIndex,
        frmGoPhast.PhastModel];
      tvFeatures.Items.AddChildObject(ANode, TimeList.NonParamDescription, TimeList)
//      comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
    end;
  end;
end;


procedure TfrmEditFeatureFormula.GetRchParam2(RchBoundary: TRchBoundary; ANode: TTreeNode);
var
  TimeListIndex: Integer;
  TimeList: TModflowTimeList;
begin
  if frmGoPhast.PhastModel.ModflowPackages.RchPackage.TimeVaryingLayers then
  begin
    for TimeListIndex := 0 to RchBoundary.RechargeLayers.TimeListCount(frmGoPhast.PhastModel) - 1 do
    begin
      TimeList := RchBoundary.RechargeLayers.TimeLists[TimeListIndex, frmGoPhast.PhastModel];
      tvFeatures.Items.AddChildObject(ANode, TimeList.NonParamDescription, TimeList)
//      comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
    end;
  end;
end;

procedure TfrmEditFeatureFormula.GetEvtParam2(EvtBoundary: TEvtBoundary; ANode: TTreeNode);
var
  TimeListIndex: Integer;
  TimeList: TModflowTimeList;
begin
  for TimeListIndex := 0 to EvtBoundary.EvtSurfDepthCollection.TimeListCount(
    frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := EvtBoundary.EvtSurfDepthCollection.TimeLists[TimeListIndex,
      frmGoPhast.PhastModel];
//    comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
    tvFeatures.Items.AddChildObject(ANode, TimeList.NonParamDescription, TimeList)
  end;
  if frmGoPhast.PhastModel.ModflowPackages.EvtPackage.TimeVaryingLayers then
  begin
    for TimeListIndex := 0 to EvtBoundary.EvapotranspirationLayers.TimeListCount(
      frmGoPhast.PhastModel) - 1 do
    begin
      TimeList := EvtBoundary.EvapotranspirationLayers.TimeLists[TimeListIndex,
        frmGoPhast.PhastModel];
//      comboFeatureProperty.Items.AddObject(TimeList.NonParamDescription, TimeList);
      tvFeatures.Items.AddChildObject(ANode, TimeList.NonParamDescription, TimeList)
    end;
  end;
end;

function TfrmEditFeatureFormula.FeatureTypeToBoundary(
  FeatureType: TMfFeatureType; ScreenObject: TScreenObject): TModflowBoundary;
begin
  result := nil;
  case FeatureType of
    ftCHD: result := ScreenObject.ModflowChdBoundary;
    ftFhbHead: Result := ScreenObject.ModflowFhbHeadBoundary;
    ftFhbFlow: Result := ScreenObject.ModflowFhbHeadBoundary;
    ftRCH: Result := ScreenObject.ModflowRchBoundary;
    ftWEL: Result := ScreenObject.ModflowWellBoundary;
    ftDRN: Result := ScreenObject.ModflowDrnBoundary;
    ftDRT: Result := ScreenObject.ModflowDrtBoundary;
    ftETS: Result := ScreenObject.ModflowEtsBoundary;
    ftEVT: Result := ScreenObject.ModflowEvtBoundary;
    ftGHB: Result := ScreenObject.ModflowGhbBoundary;
    ftLAK: Result := ScreenObject.ModflowLakBoundary;
    ftMNW1: Result := ScreenObject.ModflowMnw1Boundary;
    ftMNW2: Result := ScreenObject.ModflowMnw2Boundary;
    ftRES: Result := ScreenObject.ModflowResBoundary;
    ftRIV: Result := ScreenObject.ModflowRivBoundary;
    ftSFR: Result := ScreenObject.ModflowSfrBoundary;
    ftSTR: Result := ScreenObject.ModflowStrBoundary;
    ftUZF: Result := ScreenObject.ModflowUzfBoundary;
    ftMt3dms: Result := ScreenObject.Mt3dmsConcBoundary;
//    ftCfpFixed: Result := ScreenObject.ModflowCfpFixedHeads;
    ftCfpFixed: Result := nil;
//    ftCfpPipes: result := ScreenObject.ModflowCfpPipes;
    ftCfpPipes: result := nil;
    ftCfpRecharge: Result := ScreenObject.ModflowCfpRchFraction;
    ftSwrReach: Result := ScreenObject.ModflowSwrReaches;
    ftSwrRain: Result := ScreenObject.ModflowSwrRain;
    ftSwrET: Result := ScreenObject.ModflowSwrEvap;
    ftSwrLateralInflow: Result := ScreenObject.ModflowSwrLatInflow;
    ftSwrDirectRunoff: Result := ScreenObject.ModflowSwrDirectRunoff;
    ftSwrStage: Result := ScreenObject.ModflowSwrStage;
    ftFmpFarmID: Result := ScreenObject.ModflowFmpFarmID;
    ftFmpCropID: Result := ScreenObject.ModflowFmpCropID;
    ftFmpRefEvap: Result := ScreenObject.ModflowFmpRefEvap;
    ftFmpPrecip: Result := ScreenObject.ModflowFmpPrecip;
    ftFmpWell: Result := ScreenObject.ModflowFmpWellBoundary;
    else Assert(False);
  end;
end;

procedure TfrmEditFeatureFormula.FillPropertyCollection(
  Collection: TScreenObjectEditCollection; List: TScreenObjectList);
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

procedure TfrmEditFeatureFormula.GetObjectsOfSelectedType(
  SelectedType: TModflowFeatureTypeSelection);
var
  ScreenObjectIndex: Integer;
  AScreenObject: TScreenObject;
begin
  if SelectedType.FScreenObjects = nil then
  begin
    SelectedType.FScreenObjects := TScreenObjectList.Create;
    for ScreenObjectIndex := 0 to FScreenObjects.Count - 1 do
    begin
      AScreenObject := FScreenObjects[ScreenObjectIndex];
      case SelectedType.FFeatureType of
        ftCHD:
          begin
            if (AScreenObject.ModflowChdBoundary <> nil)
              and AScreenObject.ModflowChdBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftFhbHead:
          begin
            if ((AScreenObject.ModflowFhbHeadBoundary <> nil)
              and AScreenObject.ModflowFhbHeadBoundary.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftFhbFlow:
          begin
            if ((AScreenObject.ModflowFhbFlowBoundary <> nil)
              and AScreenObject.ModflowFhbFlowBoundary.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftRCH:
          begin
            if (AScreenObject.ModflowRchBoundary <> nil)
              and AScreenObject.ModflowRchBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftWEL:
          begin
            if (AScreenObject.ModflowWellBoundary <> nil)
              and AScreenObject.ModflowWellBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftDRN:
          begin
            if (AScreenObject.ModflowDrnBoundary <> nil)
              and AScreenObject.ModflowDrnBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftDRT:
          begin
            if (AScreenObject.ModflowDrtBoundary <> nil)
              and AScreenObject.ModflowDrtBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftETS:
          begin
            if (AScreenObject.ModflowEtsBoundary <> nil)
              and AScreenObject.ModflowEtsBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftEVT:
          begin
            if (AScreenObject.ModflowEvtBoundary <> nil)
              and AScreenObject.ModflowEvtBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftGHB:
          begin
            if (AScreenObject.ModflowGhbBoundary <> nil)
              and AScreenObject.ModflowGhbBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftLAK:
          begin
            if (AScreenObject.ModflowLakBoundary <> nil)
              and AScreenObject.ModflowLakBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftMNW1:
          begin
            if (AScreenObject.ModflowMnw1Boundary <> nil)
              and AScreenObject.ModflowMnw1Boundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftMNW2:
          begin
            if (AScreenObject.ModflowMnw2Boundary <> nil)
              and AScreenObject.ModflowMnw2Boundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftRES:
          begin
            if (AScreenObject.ModflowResBoundary <> nil)
              and AScreenObject.ModflowResBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftRIV:
          begin
            if (AScreenObject.ModflowRivBoundary <> nil)
              and AScreenObject.ModflowRivBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftSFR:
          begin
            if (AScreenObject.ModflowSfrBoundary <> nil)
              and AScreenObject.ModflowSfrBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftSTR:
          begin
            if (AScreenObject.ModflowStrBoundary <> nil)
              and AScreenObject.ModflowStrBoundary.Used then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftUZF:
          begin
            if ((AScreenObject.ModflowUzfBoundary <> nil)
              and AScreenObject.ModflowUzfBoundary.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftMt3dms:
          begin
            if ((AScreenObject.Mt3dmsConcBoundary <> nil)
              and AScreenObject.Mt3dmsConcBoundary.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftCfpFixed:
          begin
            if ((AScreenObject.ModflowCfpFixedHeads <> nil)
              and AScreenObject.ModflowCfpFixedHeads.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftCfpPipes:
          begin
            if ((AScreenObject.ModflowCfpPipes <> nil)
              and AScreenObject.ModflowCfpPipes.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftCfpRecharge:
          begin
            if ((AScreenObject.ModflowCfpRchFraction <> nil)
              and AScreenObject.ModflowCfpRchFraction.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftSwrReach:
          begin
            if ((AScreenObject.ModflowSwrReaches <> nil)
              and AScreenObject.ModflowSwrReaches.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftSwrRain:
          begin
            if ((AScreenObject.ModflowSwrRain <> nil)
              and AScreenObject.ModflowSwrRain.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftSwrET:
          begin
            if ((AScreenObject.ModflowSwrEvap <> nil)
              and AScreenObject.ModflowSwrEvap.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftSwrLateralInflow:
          begin
            if ((AScreenObject.ModflowSwrLatInflow <> nil)
              and AScreenObject.ModflowSwrLatInflow.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftSwrDirectRunoff:
          begin
            if ((AScreenObject.ModflowSwrDirectRunoff <> nil)
              and AScreenObject.ModflowSwrDirectRunoff.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftSwrStage:
          begin
            if ((AScreenObject.ModflowSwrStage <> nil)
              and AScreenObject.ModflowSwrStage.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftFmpFarmID:
          begin
            if ((AScreenObject.ModflowFmpFarmID <> nil)
              and AScreenObject.ModflowFmpFarmID.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftFmpCropID:
          begin
            if ((AScreenObject.ModflowFmpCropID <> nil)
              and AScreenObject.ModflowFmpCropID.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftFmpRefEvap:
          begin
            if ((AScreenObject.ModflowFmpRefEvap <> nil)
              and AScreenObject.ModflowFmpRefEvap.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftFmpPrecip:
          begin
            if ((AScreenObject.ModflowFmpPrecip <> nil)
              and AScreenObject.ModflowFmpPrecip.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;
        ftFmpWell:
          begin
            if ((AScreenObject.ModflowFmpWellBoundary <> nil)
              and AScreenObject.ModflowFmpWellBoundary.Used) then
            begin
              SelectedType.FScreenObjects.Add(AScreenObject);
            end;
          end;

      else
        Assert(False);
      end;
    end;
  end;
end;

{ TModflowFeatureTypeSelection }

constructor TModflowFeatureTypeSelection.Create;
begin
  FScreenObjects := nil
end;

destructor TModflowFeatureTypeSelection.Destroy;
begin
  FScreenObjects.Free;
  inherited;
end;

end.
