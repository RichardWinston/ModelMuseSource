unit frmImportSutraModelResultsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, frmCustomGoPhastUnit, StdCtrls,
  CheckLst, Buttons, ExtCtrls, ReadSutraNodEleUnit, ScreenObjectUnit,
  frmImportShapefileUnit, Generics.Collections, Generics.Defaults, DataSetUnit,
  GoPhastTypes, ReadSutraBoundaryOutputFilesUnit, SutraInputWriterUnit,
  JvDialogs;

type
  TImportItem = (iiPressure, iiU, iiSaturation, iiXVel, iiYVel, iiZVel);
  TImportItems = set of TImportItem;

  TColorContourItem = class(TObject)
    ImportChoice: TImportItem;
    BoundaryImportChoice: Byte;
    TimeStep: integer;
  end;
  TColorContourList = TObjectList<TColorContourItem>;
  TColorContourItemComparer = TComparer<TColorContourItem>;

const
  FirstNodeItem = iiPressure;
  LastNodeItem = iiSaturation;
  FirstElementItem = iiXVel;
  LastElementItem = iiZVel;

type
  TUndoImportSutraResults = class(TUndoImportShapefile)
  strict private
    FDisplayDataSet: TDataArray;
    FDisplayChoice: TDisplayChoice;
    FOldTimeList: TCustomTimeList;
    FOldTopDataSet: TDataArray;
    FOld3DDataSet: TDataArray;
    FOldTopContourDataSet: TDataArray;
    FOld3DContourDataSet: TDataArray;
  private
    procedure SetDisplayChoice(const Value: TDisplayChoice);
    procedure SetDisplayDataSet(const Value: TDataArray);
  protected
    function Description: string; override;
  public
    constructor Create;
    property DisplayDataSet: TDataArray read FDisplayDataSet write SetDisplayDataSet;
    property DisplayChoice: TDisplayChoice read FDisplayChoice write SetDisplayChoice;
    procedure DoCommand; override;
    procedure Undo; override;
  end;

  TfrmImportSutraModelResults = class(TfrmCustomGoPhast)
    chklstTimeStepsToImport: TCheckListBox;
    lblTimeStepsToImport: TLabel;
    chklstDataToImport: TCheckListBox;
    lblDataToImport: TLabel;
    pnlBottom: TPanel;
    btnHelp: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    rgDisplayChoice: TRadioGroup;
    lblColorMesh: TLabel;
    comboColorMesh: TComboBox;
    btnSelectAll: TButton;
    btnSelectNone: TButton;
    btnSelectAllTimes: TButton;
    btnDeselectAllTimes: TButton;
    dlgOpenSutraFile: TJvOpenDialog;
    procedure FormCreate(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure btnOKClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnSelectNoneClick(Sender: TObject);
    procedure btnSelectAllTimesClick(Sender: TObject);
    procedure btnDeselectAllTimesClick(Sender: TObject);
    procedure chklstDataToImportClick(Sender: TObject);
    procedure chklstTimeStepsToImportClick(Sender: TObject);
    procedure dlgOpenSutraFileTypeChange(Sender: TObject);
  private
    FNodeReader: TNodReader;
    FEleReader: TEleReader;
    FResultList: TStoredResultsList;
    FColorContourList: TColorContourList;
    FColorContourDataArray: TDataArray;
    F_CCItem: TColorContourItem;
    FNodeFileName: string;
    FElementFileName: string;
    procedure GetData;
    procedure SetData;
    procedure CreateNodeScreenObject(out ScreenObject: TScreenObject);
    procedure CreateElementScreenObject(out ScreenObject: TScreenObject);
    procedure CreateNodeDataSets(StepIndex: Integer; NewDataSets: TList);
    procedure CreateElementDataSets(StepIndex: Integer; NewDataSets: TList);
    procedure AssignNodeValues(NewDataSets: TList; AScreenObject: TScreenObject);
    procedure AssignElementValues(NewDataSets: TList; AScreenObject: TScreenObject);
    procedure UpdateColorContourList;
    procedure EnableOkButton;
    function GetNodeAndElementFileNames: Boolean;
    function OpenNodeAndElementFiles: Boolean;
    procedure ShowAvailableTimeSteps;
    procedure CreateBoundaryNodeDataSets(StepIndex: Integer;
      NewDataSets: TList);
    procedure CreateBoundaryNodeScreenObject(AFileName: string; List: TCustomItemList;
      out ScreenObject: TScreenObject);
    procedure GetNodeLocations(Nodes: TNodeDataList);
    function CreateEmptyBoundaryNodeScreenObject(AFileName: string): TScreenObject;
    procedure GetSelectedTimeSteps;
    procedure ImportNodeAndElementData(AllNewDataSets, NewScreenObjects: TList);
    procedure ImportBoundaryDataForOneTimeStep(CustomList: TCustomItemList;
      TimeIndex: Integer; NewDataSets, AllNewDataSets,
      NewScreenObjects: TList; var NodeScreenObject: TScreenObject; AFileName: string);
    procedure ImportFluidSourcesData(AllNewDataSets, NewScreenObjects: TList);
    procedure ImportSoluteSourcesData(AllNewDataSets, NewScreenObjects: TList);
    procedure ImportSpecifiedPressureData(AllNewDataSets, NewScreenObjects: TList);
    procedure ImportSpecifiedConcentrationData(AllNewDataSets, NewScreenObjects: TList);
  protected
    procedure Loaded; override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportSutraModelResults: TfrmImportSutraModelResults;

var
  SutraPressureResults: string;
  SutraUResults: string;
  SutraSaturationResults: string;
  SutraXVelocityResults: string;
  SutraYVelocityResults: string;
  SutraZVelocityResults: string;

implementation

uses
  frmGoPhastUnit, SutraOptionsUnit, SutraMeshUnit, IntListUnit,
  UndoItems, FastGEO, GIS_Functions,
  RbwParser, PhastModelUnit, frmSelectResultToImportUnit,
  ValueArrayStorageUnit, Math, frmDisplayDataUnit, frmGridValueUnit,
  VectorDisplayUnit, IOUtils;

{$R *.dfm}

resourcestring
  StrUnableToOpen0s = 'Unable to open %0:s. Error message = %1:s';
  StrOnlyNodAndEleF = 'Only .nod and .ele files may be selected.';
  StrConcentration = 'Concentration';
  StrTemperature = 'Temperature';
  StrTheNodAndEleFi = 'The .nod and .ele files contain no data.';
  StrTheNumbersOfNodes = 'The numbers of nodes or elements in the files do n' +
  'ot match the numbers of nodes or element in the model. Do you want to att' +
  'empt to import the data anyway?';
  StrImportSUTRAModelR = 'import SUTRA model results';
  StrYouMustSpecifyAt = 'You must specify at least one type of data and one ' +
  'time step.';
  StrUnableToImportNod = 'Unable to import node data because the node locati' +
  'ons were not saved in the .nod file.';
  StrUnableToImportEle = 'Unable to import element data because the element locati' +
  'ons were not saved in the .nod file.';
  StrNone = 'none';
  StrReadFrom0sOn = 'read from: "%0:s" on %1:s'
    + sLineBreak + 'Time Step: %2:d.'
    + sLineBreak + 'Elapsed Time: %3:g.'
    + sLineBreak + 'File last modified on: %4:s';
  StrVelocityAtTimeSte = 'Velocity at time step %0:d imported on %1:s';
  StrPressure = 'Pressure';
  StrSaturation = 'Saturation';
  StrXVelocity = 'X velocity';
  StrYVelocity = 'Y velocity';
  StrZVelocity = 'Z velocity';
  StrSpecifiedConcentrat = 'Specified concentration';
  StrSpecifiedTemperatur = 'Specified temperature';
  StrSpecifiedFluidSour = 'Specified fluid source rate';
  StrSpecifiedSoluteFlu = 'Specified solute flux';
  StrSpecifiedEnergyFlu = 'Specified energy flux';
  StrResultantFluidSour = 'Resultant fluid source';
  StrResultantSoluteFlu = 'Resultant solute flux';
  StrResultantEnergyFlu = 'Resultant energy flux';
  StrComputedPressure = 'Computed pressure';
  StrSpecifiedPressure = 'Specified pressure';
  StrComputedConcentrati = 'Computed concentration';
  StrComputedTemperature = 'Computed temperature';
  StrStep0dTime1 = 'Step: %0:d; Time: %1:g';
  Str0sTS1d = '%0:s, TS: %1:d';


{ TfrmImportSutraModelResults }

procedure TfrmImportSutraModelResults.btnDeselectAllTimesClick(Sender: TObject);
begin
  inherited;
  chklstTimeStepsToImport.CheckAll(cbUnchecked);
  UpdateColorContourList;
end;

procedure TfrmImportSutraModelResults.btnOKClick(Sender: TObject);
var
  index: Integer;
  OK: Boolean;
  DisplayChoice: TDisplayChoice;
begin
  inherited;
  OK := False;
  for index := 0 to chklstDataToImport.Items.Count - 1 do
  begin
    OK := chklstDataToImport.Checked[index];
    if OK then
    begin
      break;
    end;
  end;
  if OK then
  begin
    OK := False;
    for index := 0 to chklstTimeStepsToImport.Items.Count - 1 do
    begin
      OK := chklstTimeStepsToImport.Checked[index];
      if OK then
      begin
        break;
      end;
    end;
  end;
  if OK then
  begin
    SetData;
    DisplayChoice := TDisplayChoice(rgDisplayChoice.ItemIndex);
    Inc(DisplayChoices[DisplayChoice]);
  end
  else
  begin
    Beep;
    MessageDlg(StrYouMustSpecifyAt, mtWarning, [mbOK], 0);
    ModalResult := mrNone;
  end;

end;

procedure TfrmImportSutraModelResults.btnSelectAllClick(Sender: TObject);
begin
  inherited;
  chklstDataToImport.CheckAll(cbChecked);
  UpdateColorContourList;
end;

procedure TfrmImportSutraModelResults.btnSelectAllTimesClick(Sender: TObject);
begin
  inherited;
  chklstTimeStepsToImport.CheckAll(cbChecked);
  UpdateColorContourList;
end;

procedure TfrmImportSutraModelResults.btnSelectNoneClick(Sender: TObject);
begin
  inherited;
  chklstDataToImport.CheckAll(cbUnchecked);
  UpdateColorContourList;
end;

procedure TfrmImportSutraModelResults.chklstDataToImportClick(Sender: TObject);
begin
  inherited;
  UpdateColorContourList;
end;

procedure TfrmImportSutraModelResults.chklstTimeStepsToImportClick(
  Sender: TObject);
begin
  inherited;
  UpdateColorContourList;
end;

procedure TfrmImportSutraModelResults.FormCreate(Sender: TObject);
begin
  inherited;
  FColorContourList := TColorContourList.Create;
  dlgOpenSutraFileTypeChange(nil);
//  chklstDataToImport.CheckAll(cbChecked);
//  case frmGoPhast.PhastModel.SutraOptions.TransportChoice of
//    tcSolute, tcSoluteHead:
//      begin
//        chklstDataToImport.Items[Ord(iiU)] := StrConcentration;
//      end;
//    tcEnergy:
//      begin
//        chklstDataToImport.Items[Ord(iiU)] := StrTemperature;
//      end;
//    else Assert(False);
//  end;
//  if frmGoPhast.PhastModel.SutraMesh.MeshType in [mt2D, mtProfile] then
//  begin
//    chklstDataToImport.ItemEnabled[Ord(iiZVel)]  := False;
//    chklstDataToImport.Checked[Ord(iiZVel)]  := False;
//  end;
  GetData;
end;

procedure TfrmImportSutraModelResults.FormDestroy(Sender: TObject);
begin
  inherited;
  FNodeReader.Free;
  FEleReader.Free;
  FResultList.Free;
  FColorContourList.Free;
end;

procedure TfrmImportSutraModelResults.ShowAvailableTimeSteps;
var
  ItemIndex: Integer;
begin
  chklstTimeStepsToImport.Items.Capacity := FResultList.Count;
  for ItemIndex := 0 to FResultList.Count - 1 do
  begin
    chklstTimeStepsToImport.Items.AddObject(Format(StrStep0dTime1,
      [FResultList[ItemIndex].TimeStep, FResultList[ItemIndex].Time]),
      FResultList[ItemIndex]);
  end;
  chklstTimeStepsToImport.Checked[chklstTimeStepsToImport.items.Count-1] :=
    True;
end;

procedure TfrmImportSutraModelResults.GetData;
var
  ItemIndex: Integer;
  Mesh: TSutraMesh3D;
  ShowWarning: Boolean;
  FileExtension: string;
begin
  if frmGoPhast.PhastModel.ModelFileName <> '' then
  begin
    dlgOpenSutraFile.FileName := ChangeFileExt(
      frmGoPhast.PhastModel.ModelFileName, '.nod');
  end;
  if dlgOpenSutraFile.Execute then
  begin
    if dlgOpenSutraFile.FilterIndex = 1 then
    begin
      FileExtension := LowerCase(ExtractFileExt(dlgOpenSutraFile.FileName));
      if (FileExtension = '.nod') or (FileExtension = '.ele') then
      begin
        dlgOpenSutraFile.FilterIndex := 2;
      end
      else if (FileExtension = '.bcof') then
      begin
        dlgOpenSutraFile.FilterIndex := 3;
      end
      else if (FileExtension = '.bcos') then
      begin
        dlgOpenSutraFile.FilterIndex := 4;
      end
      else if (FileExtension = '.bcop') then
      begin
        dlgOpenSutraFile.FilterIndex := 5;
      end
      else if (FileExtension = '.bcou') then
      begin
        dlgOpenSutraFile.FilterIndex := 6;
      end
      else
      begin
        Assert(False);
      end;
      dlgOpenSutraFileTypeChange(nil);
    end;
    case dlgOpenSutraFile.FilterIndex of
      2:
        begin
          if not GetNodeAndElementFileNames then
          begin
            ModalResult := mrOk;
            Exit;
          end;
          if not OpenNodeAndElementFiles then
          begin
            ModalResult := mrOk;
            Exit;
          end;

          FResultList := TStoredResultsList.Create;
          FResultList.OwnsObjects := False;
          FResultList.AddRange(FNodeReader.StoredResults.ToArray);
          FResultList.AddRange(FEleReader.StoredResults.ToArray);
          if FResultList.Count = 0 then
          begin
            Beep;
            MessageDlg(StrTheNodAndEleFi, mtWarning, [mbOK], 0);
            ModalResult := mrOk;
            Exit;
          end;

          FResultList.Sort(TStoredResultsComparer.Construct(
            function (const L, R: TStoredResults): integer
             begin
               result := L.TimeStep - R.TimeStep;
             end));

          for ItemIndex := FResultList.Count - 1 downto 1 do
          begin
            if FResultList[ItemIndex].TimeStep = FResultList[ItemIndex-1].TimeStep then
            begin
              FResultList.Delete(ItemIndex);
            end;
          end;

          ShowAvailableTimeSteps;

          ShowWarning := False;
          Mesh := frmGoPhast.PhastModel.SutraMesh;
          case Mesh.MeshType of
            mt2D, mtProfile:
              begin
                ShowWarning := (Mesh.Mesh2D.Nodes.Count <> FNodeReader.Count)
                  or (Mesh.Mesh2D.Elements.Count <> FEleReader.Count)
              end;
            mt3D:
              begin
                ShowWarning := (Mesh.ActiveNodeCount <> FNodeReader.Count)
                  or (Mesh.ActiveElementCount <> FEleReader.Count)
              end;
            else Assert(False);
          end;
          if ShowWarning then
          begin
            Beep;
            if (MessageDlg(StrTheNumbersOfNodes, mtWarning, [mbYes, mbNo], 0)
              <> mrYes) then
            begin
              ModalResult := mrOk;
              Exit;
            end;
          end;
        end;
      3..6:
        begin
          FResultList := TStoredResultsList.Create;
          ReadFileHeader(dlgOpenSutraFile.FileName, FResultList);
          ShowAvailableTimeSteps;
        end;
      else
        Assert(False);
    end;

    UpdateColorContourList;
  end
  else
  begin
    ModalResult := mrOk;
  end;
end;

procedure TfrmImportSutraModelResults.Loaded;
begin
  inherited;
  Constraints.MinHeight := Height;
end;

procedure TfrmImportSutraModelResults.ImportBoundaryDataForOneTimeStep(
  CustomList: TCustomItemList; TimeIndex: Integer;
  NewDataSets, AllNewDataSets, NewScreenObjects: TList;
  var NodeScreenObject: TScreenObject; AFileName: string);
var
  DataSetIndex: Integer;
  DataSetPosition: Integer;
  ImportedValueItem: TValueArrayItem;
  ADataArray: TDataArray;
  AnItem: TCustomSutraBoundaryItem;

  ValueIndex: Integer;
  ItemIndex: Integer;
begin
  NewDataSets.Clear;
  CreateBoundaryNodeDataSets(TimeIndex, NewDataSets);
  if NewDataSets.Count > 0 then
  begin
    for DataSetIndex := 0 to NewDataSets.Count - 1 do
    begin
      AllNewDataSets.Add(NewDataSets[DataSetIndex]);
    end;
    if NodeScreenObject = nil then
    begin
      CreateBoundaryNodeScreenObject(AFileName, CustomList, NodeScreenObject);
      Assert(NodeScreenObject <> nil);
//      if NodeScreenObject = nil then
//      begin
//        Exit;
//      end;
      NewScreenObjects.Add(NodeScreenObject);
    end;
    DataSetIndex := 0;
    for ItemIndex := 0 to chklstDataToImport.Items.Count - 1 do
    begin
      if chklstDataToImport.Checked[ItemIndex] then
      begin
        ADataArray := NewDataSets[DataSetIndex];
        Inc(DataSetIndex);
        DataSetPosition := NodeScreenObject.AddDataSet(ADataArray);
        NodeScreenObject.DataSetFormulas[DataSetPosition] := rsObjectImportedValuesR + '("' + ADataArray.Name + '")';
        ImportedValueItem := NodeScreenObject.ImportedValues.Add;
        ImportedValueItem.Name := ADataArray.Name;
        ImportedValueItem.Values.DataType := rdtDouble;
        ImportedValueItem.Values.Count := CustomList.Count;
        for ValueIndex := 0 to CustomList.Count - 1 do
        begin
          AnItem := CustomList[ValueIndex];
          ImportedValueItem.Values.RealValues[ValueIndex] := AnItem.Values[ItemIndex];
        end;
      end;
    end;
  end;
end;

function TfrmImportSutraModelResults.CreateEmptyBoundaryNodeScreenObject(AFileName: string): TScreenObject;
var
  UndoCreateScreenObject: TCustomUndo;
  Mesh: TSutraMesh3D;
begin
  Mesh := frmGoPhast.PhastModel.SutraMesh;
  result := TScreenObject.CreateWithViewDirection(frmGoPhast.PhastModel,
    vdTop, UndoCreateScreenObject, False);
  result.Comment := 'Imported from ' + AFileName +' on ' + DateTimeToStr(Now);
  result.SetPropertiesOfIntersectedCells := True;
  result.EvaluatedAt := eaNodes;
  result.Visible := False;
  case Mesh.MeshType of
    mt2D, mtProfile:
      begin
        result.ElevationCount := ecZero;
        result.ElevationFormula := '0';
      end;
    mt3D:
      begin
        result.ElevationCount := ecOne;
        result.ElevationFormula := rsObjectImportedValuesR
          + '("' + StrImportedElevations + '")';
      end;
  else
    Assert(False);
  end;
end;

procedure TfrmImportSutraModelResults.GetNodeLocations(Nodes: TNodeDataList);
var
  LayerIndex: Integer;
  ANode3D: TSutraNode3D;
  ANode2D: TSutraNode2D;
  NodeData: TNodeData;
  Mesh: TSutraMesh3D;
  NodeIndex: Integer;
begin
  Mesh := frmGoPhast.PhastModel.SutraMesh;
  case Mesh.MeshType of
    mt2D, mtProfile:
      begin
        Nodes.Capacity := Mesh.Mesh2D.Nodes.Count;
        for NodeIndex := 0 to Mesh.Mesh2D.Nodes.Count - 1 do
        begin
          ANode2D := Mesh.Mesh2D.Nodes[NodeIndex];
          NodeData := TNodeData.Create;
          Nodes.Add(NodeData);
          NodeData.Number := ANode2D.Number;
          NodeData.NREG := 0;
          NodeData.X := ANode2D.X;
          NodeData.Y := ANode2D.Y;
          NodeData.Z := 0;
          NodeData.Porosity := 0;
        end;
      end;
    mt3D:
      begin
        Nodes.Capacity := Mesh.ActiveNodeCount;
        for LayerIndex := 0 to Mesh.LayerCount do
        begin
          for NodeIndex := 0 to Mesh.Mesh2D.Nodes.Count - 1 do
          begin
            ANode3D := Mesh.NodeArray[LayerIndex, NodeIndex];
            if ANode3D.Active then
            begin
              NodeData := TNodeData.Create;
              Nodes.Add(NodeData);
              NodeData.Number := ANode3D.Number;
              NodeData.NREG := 0;
              NodeData.X := ANode3D.X;
              NodeData.Y := ANode3D.Y;
              NodeData.Z := ANode3D.Z;
              NodeData.Porosity := 0;
            end;
          end;
        end;
      end;
  else
    Assert(False);
  end;
  if Nodes.Count > 0 then
  begin
    Nodes.Sort(TNodeDataComparer.Construct(function (const L, R: TNodeData): integer
    begin
          result := L.Number - R.Number;
        end));
  end;
end;

function TfrmImportSutraModelResults.OpenNodeAndElementFiles: Boolean;
begin
  result := True;
  try
    FNodeReader := TNodReader.Create(FNodeFileName);
  except
    on E: EInOutError do
    begin
      Beep;
      MessageDlg(Format(StrUnableToOpen0s, [FNodeFileName, E.message]), mtWarning, [mbOK], 0);
      result := False;
    end;
  end;
  if result then
  begin
    try
      FEleReader := TEleReader.Create(FElementFileName);
    except
      on E: EInOutError do
      begin
        Beep;
        MessageDlg(Format(StrUnableToOpen0s, [FElementFileName, E.message]), mtWarning, [mbOK], 0);
        result := False;
      end;
    end;
  end;
end;

function TfrmImportSutraModelResults.GetNodeAndElementFileNames: Boolean;
var
  Extension: string;
  FileName: TFileName;
begin
  result := True;
  FileName := dlgOpenSutraFile.FileName;
  Extension := LowerCase(ExtractFileExt(FileName));
  if Extension = '.nod' then
  begin
    FNodeFileName := FileName;
    FElementFileName := ChangeFileExt(FileName, '.ele');
  end
  else if Extension = '.ele' then
  begin
    FNodeFileName := ChangeFileExt(FileName, '.nod');
    FElementFileName := FileName;
  end
  else
  begin
    FNodeFileName := '';
    FElementFileName := '';
    Beep;
    MessageDlg(StrOnlyNodAndEleF, mtError, [mbOK], 0);
    result := False;
  end;
end;


procedure TfrmImportSutraModelResults.CreateNodeScreenObject(
  Out ScreenObject: TScreenObject);
var
  UndoCreateScreenObject: TCustomUndo;
  NeedLocations: Boolean;
  Mesh: TSutraMesh3D;
  NodeIndex: Integer;
  ANode2D: TSutraNode2D;
  NodeData: TNodeData;
  LayerIndex: Integer;
  ANode3D: TSutraNode3D;
  Nodes: TNodeDataList;
  APoint: TPoint2D;
  Z: Extended;
begin
  ScreenObject := nil;
  Mesh := frmGoPhast.PhastModel.SutraMesh;
  Nodes := TNodeDataList.Create;
  try
    NeedLocations := False;
    case Mesh.MeshType of
      mt2D, mtProfile:
        begin
          NeedLocations := (Mesh.Mesh2D.Nodes.Count <> FNodeReader.Count);
          if NeedLocations then
          begin
            if (Length(FNodeReader.X) = 0) or (Length(FNodeReader.Y) = 0)  then
            begin
              Beep;
              MessageDlg(StrUnableToImportNod, mtError, [mbOK], 0);
              Exit;
            end;
          end;
          Nodes.Capacity := Mesh.Mesh2D.Nodes.Count;
          for NodeIndex := 0 to Mesh.Mesh2D.Nodes.Count - 1 do
          begin
            ANode2D := Mesh.Mesh2D.Nodes[NodeIndex];
            NodeData := TNodeData.Create;
            Nodes.Add(NodeData);
            NodeData.Number := ANode2D.Number;
            NodeData.NREG := 0;
            NodeData.X := ANode2D.X;
            NodeData.Y := ANode2D.Y;
            NodeData.Z := 0;
            NodeData.Porosity := 0
          end;
        end;
      mt3D:
        begin
          NeedLocations := (Mesh.ActiveNodeCount <> FNodeReader.Count);
          if NeedLocations then
          begin
            if (Length(FNodeReader.X) = 0)
              or (Length(FNodeReader.Y) = 0)
              or (Length(FNodeReader.Z) = 0)  then
            begin
              Beep;
              MessageDlg(StrUnableToImportNod, mtError, [mbOK], 0);
              Exit;
            end;
          end;
          Nodes.Capacity := Mesh.ActiveNodeCount;
          for LayerIndex := 0 to Mesh.LayerCount do
          begin
            for NodeIndex := 0 to Mesh.Mesh2D.Nodes.Count - 1 do
            begin
              ANode3D := Mesh.NodeArray[LayerIndex,NodeIndex];
              if ANode3D.Active then
              begin
                NodeData := TNodeData.Create;
                Nodes.Add(NodeData);
                NodeData.Number := ANode3D.Number;
                NodeData.NREG := 0;
                NodeData.X := ANode3D.X;
                NodeData.Y := ANode3D.Y;
                NodeData.Z := ANode3D.Z;
                NodeData.Porosity := 0;
              end;
            end;
          end
        end;
      else Assert(False);
    end;

    if Nodes.Count > 0 then
    begin
      Nodes.Sort(TNodeDataComparer.Construct(
        function (const L, R: TNodeData): integer
        begin
          result := L.Number - R.Number;
        end));
    end;

    ScreenObject := TScreenObject.CreateWithViewDirection(
      frmGoPhast.PhastModel, vdTop,
      UndoCreateScreenObject, False);
    ScreenObject.SetPropertiesOfIntersectedCells := True;
    ScreenObject.EvaluatedAt := eaNodes;
    ScreenObject.Visible := False;
    ScreenObject.ElevationCount := ecOne;
    case Mesh.MeshType of
      mt2D, mtProfile:
        begin
          ScreenObject.ElevationFormula := '0'
        end;
      mt3D:
        begin
          ScreenObject.ElevationFormula :=
            rsObjectImportedValuesR
            + '("' + StrImportedElevations + '")';

        end;
      else Assert(False);
    end;

    for NodeIndex := 0 to FNodeReader.Count - 1 do
    begin
      if (Length(FNodeReader.X) = 0) or not NeedLocations then
      begin
        // The X coordinates were NOT stored in the .node file
        APoint.X := Nodes[NodeIndex].X;
      end
      else
      begin
        // The X coordinates WERE stored in the .node file
        APoint.X := FNodeReader.X[NodeIndex];
      end;
      if (Length(FNodeReader.Y) = 0) or not NeedLocations then
      begin
        // The Y coordinates were NOT stored in the .node file
        APoint.Y := Nodes[NodeIndex].Y;
      end
      else
      begin
        // The Y coordinates WERE stored in the .node file
        APoint.Y := FNodeReader.Y[NodeIndex];
      end;
      ScreenObject.AddPoint(APoint, True);


      if ScreenObject.ElevationCount = ecOne then
      begin
        // 3D model
        if (Length(FNodeReader.Z) = 0) or not NeedLocations then
        begin
          // The Z coordinates were NOT stored in the .node file
          Z := Nodes[NodeIndex].Z;
        end
        else
        begin
          // The Z coordinates WERE stored in the .node file
          Z := FNodeReader.Z[NodeIndex];
        end;
        ScreenObject.ImportedSectionElevations.Add(Z);
      end;
    end;
  finally
    Nodes.Free;
  end;

end;

procedure TfrmImportSutraModelResults.dlgOpenSutraFileTypeChange(
  Sender: TObject);
var
  Labels: TStringList;
  NewFileName: string;
begin
  inherited;
  Labels := TStringList.Create;
  try
    case dlgOpenSutraFile.FilterIndex of
      1,2:
        begin
          // nod and ele files.
          NewFileName := ChangeFileExt(dlgOpenSutraFile.FileName, '.nod');
          dlgOpenSutraFile.FileName := NewFileName;
          UpdateDialogBoxFileName(dlgOpenSutraFile, NewFileName);
          Labels.Add(StrPressure);
          case frmGoPhast.PhastModel.SutraOptions.TransportChoice of
            tcSolute, tcSoluteHead:
              begin
                Labels.Add(StrConcentration);
              end;
            tcEnergy:
              begin
                Labels.Add(StrTemperature);
              end;
            else Assert(False);
          end;
          Labels.Add(StrSaturation);
          Labels.Add(StrXVelocity);
          Labels.Add(StrYVelocity);
          Labels.Add(StrZVelocity);
        end;
      3:
        begin
          // Fluid sources and sinks (*.bcof)|*.bcof
          NewFileName := ChangeFileExt(dlgOpenSutraFile.FileName, '.bcof');
          dlgOpenSutraFile.FileName := NewFileName;
          UpdateDialogBoxFileName(dlgOpenSutraFile, NewFileName);
          Labels.Add(StrSpecifiedFluidSour);
          case frmGoPhast.PhastModel.SutraOptions.TransportChoice of
            tcSolute, tcSoluteHead:
              begin
                Labels.Add(StrSpecifiedConcentrat);
                Labels.Add(StrSpecifiedSoluteFlu);
              end;
            tcEnergy:
              begin
                Labels.Add(StrSpecifiedTemperatur);
                Labels.Add(StrSpecifiedEnergyFlu);
              end;
            else Assert(False);
          end;
        end;
      4:
        begin
          // Solute or energy sources and sinks (*.bcos)|*.bcos
          NewFileName := ChangeFileExt(dlgOpenSutraFile.FileName, '.bcos');
          dlgOpenSutraFile.FileName := NewFileName;
          UpdateDialogBoxFileName(dlgOpenSutraFile, NewFileName);
         case frmGoPhast.PhastModel.SutraOptions.TransportChoice of
            tcSolute, tcSoluteHead:
              begin
                Labels.Add(StrSpecifiedConcentrat);
              end;
            tcEnergy:
              begin
                Labels.Add(StrSpecifiedTemperatur);
              end;
            else Assert(False);
          end;
        end;
      5:
        begin
          // Specified pressure (*.bcop)|*.bcop
          NewFileName := ChangeFileExt(dlgOpenSutraFile.FileName, '.bcop');
          dlgOpenSutraFile.FileName := NewFileName;
          UpdateDialogBoxFileName(dlgOpenSutraFile, NewFileName);
          Labels.Add(StrResultantFluidSour);
          case frmGoPhast.PhastModel.SutraOptions.TransportChoice of
            tcSolute, tcSoluteHead:
              begin
                Labels.Add(StrConcentration);
                Labels.Add(StrResultantSoluteFlu);
              end;
            tcEnergy:
              begin
                Labels.Add(StrTemperature);
                Labels.Add(StrResultantEnergyFlu);
              end;
            else Assert(False);
          end;
          Labels.Add(StrComputedPressure);
          Labels.Add(StrSpecifiedPressure);
        end;
      6:
        begin
          // Specified concentration or temperature (*.bcou)|*.bcou
          NewFileName := ChangeFileExt(dlgOpenSutraFile.FileName, '.bcou');
          dlgOpenSutraFile.FileName := NewFileName;
          UpdateDialogBoxFileName(dlgOpenSutraFile, NewFileName);
          case frmGoPhast.PhastModel.SutraOptions.TransportChoice of
            tcSolute, tcSoluteHead:
              begin
                Labels.Add(StrResultantSoluteFlu);
                Labels.Add(StrComputedConcentrati);
                Labels.Add(StrSpecifiedConcentrat);
              end;
            tcEnergy:
              begin
                Labels.Add(StrResultantEnergyFlu);
                Labels.Add(StrComputedTemperature);
                Labels.Add(StrSpecifiedTemperatur);
              end;
            else Assert(False);
          end;
        end;
      else
        Assert(False);
    end;
    chklstDataToImport.Items := Labels;
  finally
    Labels.Free;
  end;
  chklstDataToImport.CheckAll(cbChecked);

  if (dlgOpenSutraFile.FilterIndex = 2)
    and (frmGoPhast.PhastModel.SutraMesh.MeshType in [mt2D, mtProfile]) then
  begin
    chklstDataToImport.ItemEnabled[Ord(iiZVel)]  := False;
    chklstDataToImport.Checked[Ord(iiZVel)]  := False;
  end;

end;

procedure TfrmImportSutraModelResults.EnableOkButton;
var
  index: Integer;
  ShouldEnable: Boolean;
begin
  ShouldEnable := False;
  for index := 0 to chklstDataToImport.Items.Count - 1 do
  begin
    ShouldEnable := chklstDataToImport.Checked[index];
    if ShouldEnable then
    begin
      Break;
    end;
  end;
  if ShouldEnable then
  begin
    ShouldEnable := False;
    for index := 0 to chklstTimeStepsToImport.Items.Count - 1 do
    begin
      ShouldEnable := chklstTimeStepsToImport.Checked[index];
      if ShouldEnable then
      begin
        Break;
      end;
    end;
  end;
  btnOK.Enabled := ShouldEnable;
end;

procedure TfrmImportSutraModelResults.CreateElementDataSets(StepIndex: Integer;
  NewDataSets: TList);
var
  index: TImportItem;
  NewName: string;
  DataSet: TDataArray;
  NewFormula: string;
  NewDataType: TRbwDataType;
  MeshType: TMeshType;
  VItem: TVectorItem;
  Vectors: TVectorCollection;
  Classification: string;
  procedure AssignCommonProperties;
  var
    PriorItem: TVectorItem;
  begin
    VItem := Vectors.Add as TVectorItem;
    DataSet := NewDataSets[0];
    VItem.Vectors.XVelocityName := DataSet.Name;
    DataSet := NewDataSets[1];
    VItem.Vectors.YVelocityName := DataSet.Name;
    VItem.Description := Format(StrVelocityAtTimeSte,
      [FResultList[StepIndex].TimeStep, DateTimeToStr(Now)]);
    if Vectors.Count = 1 then
    begin
      VItem.Vectors.Color := clFuchsia;
    end
    else
    begin
      PriorItem := Vectors.Items[Vectors.Count-2] as TVectorItem;
      VItem.Vectors.Color := PriorItem.Vectors.Color;
    end;
  end;
begin
  Assert(NewDataSets.Count = 0);
  for index := FirstElementItem to LastElementItem do
  begin
    if chklstDataToImport.Checked[Ord(index)] then
    begin
      case index of
        iiXVel:
          begin
            if Length(FEleReader.FXVelocity) = 0 then
            begin
              Continue;
            end;
            Classification := SutraXVelocityResults;
          end;
        iiYVel:
          begin
            if Length(FEleReader.FYVelocity) = 0 then
            begin
              Continue;
            end;
            Classification := SutraYVelocityResults;
          end;
        iiZVel:
          begin
            if Length(FEleReader.FZVelocity) = 0 then
            begin
              Continue;
            end;
            Classification := SutraZVelocityResults;
          end;
        else
          Assert(False);
      end;
      NewName := GenerateNewName(chklstDataToImport.Items[Ord(index)] + '_'
        + IntToStr(FResultList[StepIndex].TimeStep), nil, '_');

      NewDataType := rdtDouble;
      NewFormula := '0.';

      DataSet := frmGoPhast.PhastModel.DataArrayManager.CreateNewDataArray(
        TDataArray, NewName, NewFormula, NewName, [], NewDataType,
        eaBlocks, dso3D, Classification);

      DataSet.Comment := Format(StrReadFrom0sOn,
        [FElementFileName, DateTimeToStr(Now), FResultList[StepIndex].TimeStep,
        FResultList[StepIndex].Time,
        DateTimeToStr(TFile.GetLastWriteTime(FElementFileName))]);

      if (F_CCItem <> nil) and (F_CCItem.ImportChoice = index)
        and (F_CCItem.TimeStep = FResultList[StepIndex].TimeStep) then
      begin
        FColorContourDataArray  := DataSet;
      end;

      NewDataSets.Add(DataSet);
      frmGoPhast.PhastModel.UpdateDataArrayDimensions(DataSet);

      DataSet.Units := '';

    end;
  end;
  MeshType := frmGoPhast.PhastModel.SutraMesh.MeshType;
  Vectors := frmGoPhast.PhastModel.VelocityVectors;
  case MeshType of
    mt2D, mtProfile:
      begin
        if NewDataSets.Count = 2 then
        begin
          AssignCommonProperties;
        end;
      end;
    mt3D:
      begin
        if NewDataSets.Count = 3 then
        begin
          AssignCommonProperties;
//          VItem := frmGoPhast.PhastModel.VelocityVectors.Add as TVectorItem;
//          DataSet := NewDataSets[0];
//          VItem.Vectors.XVelocityName := DataSet.Name;
//          DataSet := NewDataSets[1];
//          VItem.Vectors.YVelocityName := DataSet.Name;
          DataSet := NewDataSets[2];
          VItem.Vectors.ZVelocityName := DataSet.Name;
//          VItem.Description := Format(StrVelocityAtTimeSte,
//            [FResultList[StepIndex].TimeStep, DateTimeToStr(Now)]);
//          if Vectors.Count = 1 then
//          begin
//            VItem.Vectors.Color := clFuchsia;
//          end
//          else
//          begin
//            PriorItem := Vectors[Vectors.Count-2];
//            VItem.Vectors.Color := PriorItem.Vectors.Color;
//          end;
        end;
      end;
    else
      Assert(False);
  end;
end;

procedure TfrmImportSutraModelResults.CreateElementScreenObject(
  out ScreenObject: TScreenObject);
var
  UndoCreateScreenObject: TCustomUndo;
  NeedLocations: Boolean;
  Mesh: TSutraMesh3D;
  ElementIndex: Integer;
  AnElement2D: TSutraElement2D;
  ElementData: TElementData;
  LayerIndex: Integer;
  AnElement3D: TSutraElement3D;
  Elements: TElementDataList;
  APoint: TPoint2D;
  Z: Extended;
  CenterPoint: TPoint2D;
  CenterLocation: TPoint3D;
begin
  ScreenObject := nil;
  Mesh := frmGoPhast.PhastModel.SutraMesh;
  Elements := TElementDataList.Create;
  try
    NeedLocations := False;
    case Mesh.MeshType of
      mt2D, mtProfile:
        begin
          NeedLocations := (Mesh.Mesh2D.Elements.Count <> FEleReader.Count);
          if NeedLocations then
          begin
            if (Length(FEleReader.X) = 0) or (Length(FEleReader.Y) = 0)  then
            begin
              Beep;
              MessageDlg(StrUnableToImportEle, mtError, [mbOK], 0);
              Exit;
            end;
          end;
          Elements.Capacity := Mesh.Mesh2D.Elements.Count;
          for ElementIndex := 0 to Mesh.Mesh2D.Elements.Count - 1 do
          begin
            AnElement2D := Mesh.Mesh2D.Elements[ElementIndex];
            ElementData := TElementData.Create;
            Elements.Add(ElementData);
            ElementData.Number := AnElement2D.ElementNumber;
            CenterPoint := AnElement2D.Center;
            ElementData.X := CenterPoint.X;
            ElementData.Y := CenterPoint.Y;
            ElementData.Z := 0;
          end;
        end;
      mt3D:
        begin
          NeedLocations := (Mesh.ActiveElementCount <> FEleReader.Count);
          if NeedLocations then
          begin
            if (Length(FEleReader.X) = 0)
              or (Length(FEleReader.Y) = 0)
              or (Length(FEleReader.Z) = 0)  then
            begin
              Beep;
              MessageDlg(StrUnableToImportEle, mtError, [mbOK], 0);
              Exit;
            end;
          end;
          Elements.Capacity := Mesh.ActiveElementCount;
          for LayerIndex := 0 to Mesh.LayerCount-1 do
          begin
            for ElementIndex := 0 to Mesh.Mesh2D.Elements.Count - 1 do
            begin
              AnElement3D := Mesh.ElementArray[LayerIndex,ElementIndex];
              if AnElement3D.Active then
              begin
                ElementData := TElementData.Create;
                Elements.Add(ElementData);
                ElementData.Number := AnElement3D.ElementNumber;
                CenterLocation := AnElement3D.CenterLocation;
                ElementData.X := CenterLocation.X;
                ElementData.Y := CenterLocation.Y;
                ElementData.Z := CenterLocation.Z;
              end;
            end;
          end
        end;
      else Assert(False);
    end;

    if Elements.Count > 0 then
    begin
      Elements.Sort(TElementDataComparer.Construct(
        function (const L, R: TElementData): integer
        begin
          result := L.Number - R.Number;
        end));
    end;

    ScreenObject := TScreenObject.CreateWithViewDirection(
      frmGoPhast.PhastModel, vdTop,
      UndoCreateScreenObject, False);
    ScreenObject.SetPropertiesOfIntersectedCells := True;
    ScreenObject.EvaluatedAt := eaBlocks;
    ScreenObject.Visible := False;
    ScreenObject.ElevationCount := ecOne;
    case Mesh.MeshType of
      mt2D, mtProfile:
        begin
          ScreenObject.ElevationFormula := '0'
        end;
      mt3D:
        begin
          ScreenObject.ElevationFormula :=
            rsObjectImportedValuesR
            + '("' + StrImportedElevations + '")';

        end;
      else Assert(False);
    end;

    for ElementIndex := 0 to FEleReader.Count - 1 do
    begin
      if (Length(FEleReader.X) = 0) or not NeedLocations then
      begin
        // The X coordinates were NOT stored in the .node file
        APoint.X := Elements[ElementIndex].X;
      end
      else
      begin
        // The X coordinates WERE stored in the .node file
        APoint.X := FEleReader.X[ElementIndex];
      end;
      if (Length(FEleReader.Y) = 0) or not NeedLocations then
      begin
        // The Y coordinates were NOT stored in the .node file
        APoint.Y := Elements[ElementIndex].Y;
      end
      else
      begin
        // The Y coordinates WERE stored in the .node file
        APoint.Y := FEleReader.Y[ElementIndex];
      end;
      ScreenObject.AddPoint(APoint, True);


      if ScreenObject.ElevationCount = ecOne then
      begin
        // 3D model
        if (Length(FEleReader.Z) = 0) or not NeedLocations then
        begin
          // The Z coordinates were NOT stored in the .node file
          Z := Elements[ElementIndex].Z;
        end
        else
        begin
          // The Z coordinates WERE stored in the .node file
          Z := FEleReader.Z[ElementIndex];
        end;
        ScreenObject.ImportedSectionElevations.Add(Z);
      end;
    end;
  finally
    Elements.Free;
  end;

end;

procedure TfrmImportSutraModelResults.CreateNodeDataSets(StepIndex: Integer;
  NewDataSets: TList);
var
  index: TImportItem;
  NewName: string;
  DataSet: TDataArray;
  NewFormula: string;
  NewDataType: TRbwDataType;
  Classification: string;
begin
  for index := FirstNodeItem to LastNodeItem do
  begin
    if chklstDataToImport.Checked[Ord(index)] then
    begin
      case index of
        iiPressure:
          begin
            if Length(FNodeReader.Pressure) = 0 then
            begin
              Continue;
            end;
            Classification := SutraPressureResults;
          end;
        iiU:
          begin
            if Length(FNodeReader.U) = 0 then
            begin
              Continue;
            end;
            Classification := SutraUResults;
          end;
        iiSaturation:
          begin
            if Length(FNodeReader.Saturation) = 0 then
            begin
              Continue;
            end;
            Classification := SutraSaturationResults;
          end;
        else
          Assert(False);
      end;
      NewName := GenerateNewName(chklstDataToImport.Items[Ord(index)] + '_'
        + IntToStr(FResultList[StepIndex].TimeStep));

      NewDataType := rdtDouble;
      NewFormula := '0.';

      DataSet := frmGoPhast.PhastModel.DataArrayManager.CreateNewDataArray(
        TDataArray, NewName, NewFormula, NewName, [], NewDataType,
        eaNodes, dso3D, Classification);
      DataSet.Comment := Format(StrReadFrom0sOn,
        [FNodeFileName, DateTimeToStr(Now), FResultList[StepIndex].TimeStep,
        FResultList[StepIndex].Time,
        DateTimeToStr(TFile.GetLastWriteTime(FNodeFileName))]);

      if (F_CCItem <> nil) and (F_CCItem.ImportChoice = index)
        and (F_CCItem.TimeStep = FResultList[StepIndex].TimeStep) then
      begin
        FColorContourDataArray  := DataSet;
      end;

      NewDataSets.Add(DataSet);
      frmGoPhast.PhastModel.UpdateDataArrayDimensions(DataSet);

      DataSet.Units := '';

    end;
  end;
end;

procedure TfrmImportSutraModelResults.CreateBoundaryNodeDataSets
  (StepIndex: Integer; NewDataSets: TList);
var
  ItemIndex: Integer;
  Classification: string;
  NewName: string;
  NewDataType: TRbwDataType;
  NewFormula: string;
  DataSet: TDataArray;
begin
  for ItemIndex := 0 to chklstDataToImport.Items.Count - 1 do
  begin
    if chklstDataToImport.Checked[ItemIndex] then
    begin
      Classification := 'Sutra Boundary Results';

      NewName := GenerateNewName(chklstDataToImport.Items[ItemIndex] + '_'
        + IntToStr(FResultList[StepIndex].TimeStep));

      NewDataType := rdtDouble;
      NewFormula := '0.';

      DataSet := frmGoPhast.PhastModel.DataArrayManager.CreateNewDataArray(
        TDataArray, NewName, NewFormula, NewName, [], NewDataType,
        eaNodes, dso3D, Classification);
      DataSet.Comment := Format(StrReadFrom0sOn,
        [dlgOpenSutraFile.FileName, DateTimeToStr(Now), FResultList[StepIndex].TimeStep,
        FResultList[StepIndex].Time,
        DateTimeToStr(TFile.GetLastWriteTime(dlgOpenSutraFile.FileName))]);

      if (F_CCItem <> nil) and (F_CCItem.BoundaryImportChoice = ItemIndex)
        and (F_CCItem.TimeStep = FResultList[StepIndex].TimeStep) then
      begin
        FColorContourDataArray  := DataSet;
      end;

      NewDataSets.Add(DataSet);
      frmGoPhast.PhastModel.UpdateDataArrayDimensions(DataSet);

      DataSet.Units := '';
    end;

  end;
end;

procedure TfrmImportSutraModelResults.CreateBoundaryNodeScreenObject(AFileName: string;
  List: TCustomItemList; out ScreenObject: TScreenObject);
var
  index: Integer;
  ABoundaryItem: TCustomSutraBoundaryItem;
  NodeNumber: Integer;
  Nodes: TNodeDataList;
  APoint: TPoint2D;
  Z: Double;
begin

  Nodes := TNodeDataList.Create;
  try
    GetNodeLocations(Nodes);

    ScreenObject := CreateEmptyBoundaryNodeScreenObject(AFileName);

    ScreenObject.Capacity := List.Count;
    if ScreenObject.ElevationCount = ecOne then
    begin
      ScreenObject.ImportedSectionElevations.Count := List.Count
    end;
    for index := 0 to List.Count - 1 do
    begin
      ABoundaryItem := List[index];
      NodeNumber := ABoundaryItem.Node-1;
      APoint.X := Nodes[NodeNumber].X;
      APoint.Y := Nodes[NodeNumber].Y;
      ScreenObject.AddPoint(APoint, True);

      if ScreenObject.ElevationCount = ecOne then
      begin
        Z := Nodes[NodeNumber].Z;
        ScreenObject.ImportedSectionElevations.RealValues[index] := Z;
      end;
    end
  finally
    Nodes.Free;
  end;
end;

procedure TfrmImportSutraModelResults.AssignElementValues(NewDataSets: TList;
  AScreenObject: TScreenObject);
var
  DSIndex: Integer;
  DataArray: TDataArray;
  ValueArray: TOneDRealArray;
  Item: TValueArrayItem;
  ValueIndex: Integer;
  DataSetPosition: integer;
  ItemIndex: TImportItem;
begin
  DSIndex := 0;
  for ItemIndex := FirstElementItem to LastElementItem do
  begin
    if chklstDataToImport.Checked[Ord(ItemIndex)] then
    begin
      DataArray := nil;
      case ItemIndex of
        iiXVel:
          begin
            if Length(FEleReader.XVelocity) = 0 then
            begin
              Continue;
            end
            else
            begin
              ValueArray := FEleReader.XVelocity;
              DataArray := NewDataSets[DSIndex];
              Inc(DSIndex);
            end;
          end;
        iiYVel:
          begin
            if Length(FEleReader.YVelocity) = 0 then
            begin
              Continue;
            end
            else
            begin
              ValueArray := FEleReader.YVelocity;
              DataArray := NewDataSets[DSIndex];
              Inc(DSIndex);
            end;
          end;
        iiZVel:
          begin
            if Length(FEleReader.ZVelocity) = 0 then
            begin
              Continue;
            end
            else
            begin
              ValueArray := FEleReader.ZVelocity;
              DataArray := NewDataSets[DSIndex];
              Inc(DSIndex);
            end;
          end;
        else
          Assert(False);
      end;

      Item := AScreenObject.ImportedValues.Add as TValueArrayItem;
      Item.Name := DataArray.Name;
      Item.Values.DataType := DataArray.DataType;
      Item.Values.Count := FEleReader.Count;

      for ValueIndex := 0 to FEleReader.Count - 1 do
      begin
        Item.Values.RealValues[ValueIndex] := ValueArray[ValueIndex];
      end;

      DataSetPosition := AScreenObject.AddDataSet(DataArray);
      AScreenObject.DataSetFormulas[DataSetPosition] :=
        rsObjectImportedValuesR + '("' + DataArray.Name + '")';

    end;
  end
end;

procedure TfrmImportSutraModelResults.AssignNodeValues(NewDataSets: TList;
  AScreenObject: TScreenObject);
var
  DSIndex: Integer;
  DataArray: TDataArray;
  ValueArray: TOneDRealArray;
  Item: TValueArrayItem;
  ValueIndex: Integer;
  DataSetPosition: integer;
  ItemIndex: TImportItem;
begin
  DSIndex := 0;
  for ItemIndex := FirstNodeItem to LastNodeItem do
  begin
    if chklstDataToImport.Checked[Ord(ItemIndex)] then
    begin
      DataArray := nil;
      case ItemIndex of
        iiPressure:
          begin
            if Length(FNodeReader.Pressure) = 0 then
            begin
              Continue;
            end
            else
            begin
              ValueArray := FNodeReader.Pressure;
              DataArray := NewDataSets[DSIndex];
              Inc(DSIndex);
            end;
          end;
        iiU:
          begin
            if Length(FNodeReader.U) = 0 then
            begin
              Continue;
            end
            else
            begin
              ValueArray := FNodeReader.U;
              DataArray := NewDataSets[DSIndex];
              Inc(DSIndex);
            end;
          end;
        iiSaturation:
          begin
            if Length(FNodeReader.Saturation) = 0 then
            begin
              Continue;
            end
            else
            begin
              ValueArray := FNodeReader.Saturation;
              DataArray := NewDataSets[DSIndex];
              Inc(DSIndex);
            end;
          end;
        else
          Assert(False);
      end;

      Item := AScreenObject.ImportedValues.Add as TValueArrayItem;
      Item.Name := DataArray.Name;
      Item.Values.DataType := DataArray.DataType;
      Item.Values.Count := FNodeReader.Count;

      for ValueIndex := 0 to FNodeReader.Count - 1 do
      begin
        Item.Values.RealValues[ValueIndex] := ValueArray[ValueIndex];
      end;

      DataSetPosition := AScreenObject.AddDataSet(DataArray);
      AScreenObject.DataSetFormulas[DataSetPosition] :=
        rsObjectImportedValuesR + '("' + DataArray.Name + '")';

    end;
  end
end;

procedure TfrmImportSutraModelResults.GetSelectedTimeSteps;
var
  TimeStepIndex: Integer;
begin
  for TimeStepIndex := chklstTimeStepsToImport.Count - 1 downto 0 do
  begin
    if not chklstTimeStepsToImport.Checked[TimeStepIndex] then
    begin
      FResultList.Delete(TimeStepIndex);
    end;
  end;
end;

procedure TfrmImportSutraModelResults.ImportNodeAndElementData(AllNewDataSets,
  NewScreenObjects: TList);
var
  NewDataSets: TList;
  StepList: TIntegerList;
  FirstResults: Boolean;
  index: Integer;
  DataSetIndex: Integer;
  NodeScreenObject: TScreenObject;
  ElementScreenObject: TScreenObject;
begin
  NewDataSets := TList.Create;
  StepList := TIntegerList.Create;
  try
//    FirstResults := True;
    if chklstDataToImport.Checked[Ord(iiPressure)]
      or chklstDataToImport.Checked[Ord(iiU)]
      or chklstDataToImport.Checked[Ord(iiSaturation)] then
    begin
      for index := 0 to FNodeReader.StoredResults.Count - 1 do
      begin
        StepList.Add(FNodeReader.StoredResults[index].TimeStep);
      end;
      StepList.Sorted := True;
      Assert(FResultList.Count = chklstTimeStepsToImport.Items.Count);
      FirstResults := True;
      NodeScreenObject := nil;
      for index := 0 to FResultList.Count - 1 do
      begin
        if StepList.IndexOf(FResultList[index].TimeStep) >= 0 then
        begin
          if chklstTimeStepsToImport.Checked[index] then
          begin
            FNodeReader.ReadNextResults;
            NewDataSets.Clear;
            CreateNodeDataSets(index, NewDataSets);
            if NewDataSets.Count > 0 then
            begin
              for DataSetIndex := 0 to NewDataSets.Count -1 do
              begin
                AllNewDataSets.Add(NewDataSets[DataSetIndex]);
              end;
              if FirstResults then
              begin
                CreateNodeScreenObject(NodeScreenObject);
                if NodeScreenObject = nil then
                begin
                  Exit;
                end;
                NewScreenObjects.Add(NodeScreenObject);
                FirstResults := False;
              end;

              AssignNodeValues(NewDataSets, NodeScreenObject);
            end;

          end
          else
          begin
            FNodeReader.SkipNextResults
          end;
        end;
      end;
    end;
    StepList.Sorted := True;

    if chklstDataToImport.Checked[Ord(iiXVel)]
      or chklstDataToImport.Checked[Ord(iiYVel)]
      or chklstDataToImport.Checked[Ord(iiZVel)] then
    begin
      StepList.Clear;
      for index := 0 to FEleReader.StoredResults.Count - 1 do
      begin
        StepList.AddUnique(FEleReader.StoredResults[index].TimeStep);
      end;
//        StepList.Sorted := True;
      Assert(FResultList.Count = chklstTimeStepsToImport.Items.Count);
      FirstResults := True;
      ElementScreenObject := nil;
      for index := 0 to FResultList.Count - 1 do
      begin
        if StepList.IndexOf(FResultList[index].TimeStep) >= 0 then
        begin
          if chklstTimeStepsToImport.Checked[index] then
          begin
            FEleReader.ReadNextResults;
            NewDataSets.Clear;
            CreateElementDataSets(index, NewDataSets);
            if NewDataSets.Count > 0 then
            begin
              for DataSetIndex := 0 to NewDataSets.Count -1 do
              begin
                AllNewDataSets.Add(NewDataSets[DataSetIndex]);
              end;
              if FirstResults then
              begin
                CreateElementScreenObject(ElementScreenObject);
                if ElementScreenObject = nil then
                begin
                  Exit;
                end;
                NewScreenObjects.Add(ElementScreenObject);
                FirstResults := False;
              end;

              AssignElementValues(NewDataSets, ElementScreenObject);
            end;

          end
          else
          begin
            FEleReader.SkipNextResults
          end;
        end;
      end;
    end;
  finally
    NewDataSets.Free;
    StepList.Free;
  end
end;

procedure TfrmImportSutraModelResults.ImportFluidSourcesData(AllNewDataSets,
  NewScreenObjects: TList);
var
  NewDataSets: TList;
  BcofLists: TBcofLists;
  TimeIndex: Integer;
  ABcofList: TBcofList;
  ItemIndex: Integer;
  CustomList: TCustomItemList;
  NodeScreenObject: TScreenObject;
begin
  GetSelectedTimeSteps;
  NewDataSets := TList.Create;
  BcofLists := TBcofLists.Create;
  try
    ReadBcofFile(dlgOpenSutraFile.FileName, FResultList, BcofLists);
    NodeScreenObject := nil;
    for TimeIndex := 0 to BcofLists.Count - 1 do
    begin
      ABcofList := BcofLists[TimeIndex];
      CustomList := TCustomItemList.Create(False);
      try
        CustomList.Capacity := ABcofList.Count;
        for ItemIndex := 0 to ABcofList.Count - 1 do
        begin
          CustomList.Add(ABcofList[ItemIndex]);
        end;
        ImportBoundaryDataForOneTimeStep(CustomList, TimeIndex,
          NewDataSets, AllNewDataSets, NewScreenObjects, NodeScreenObject, dlgOpenSutraFile.FileName);
      finally
        CustomList.Free;
      end;
    end;
  finally
    NewDataSets.Free;
    BcofLists.Free;
  end;
end;

procedure TfrmImportSutraModelResults.ImportSoluteSourcesData(AllNewDataSets,
  NewScreenObjects: TList);
var
  NewDataSets: TList;
  BcosLists: TBcosLists;
  TimeIndex: Integer;
  ABcosList: TBcosList;
  ItemIndex: Integer;
  CustomList: TCustomItemList;
  NodeScreenObject: TScreenObject;
begin
  GetSelectedTimeSteps;
  NewDataSets := TList.Create;
  BcosLists := TBcosLists.Create;
  try
    NodeScreenObject := nil;
    ReadBcosFile(dlgOpenSutraFile.FileName, FResultList, BcosLists);
    for TimeIndex := 0 to BcosLists.Count - 1 do
    begin
      ABcosList := BcosLists[TimeIndex];
      CustomList := TCustomItemList.Create(False);
      try
        CustomList.Capacity := ABcosList.Count;
        for ItemIndex := 0 to ABcosList.Count - 1 do
        begin
          CustomList.Add(ABcosList[ItemIndex]);
        end;
        ImportBoundaryDataForOneTimeStep(CustomList, TimeIndex,
          NewDataSets, AllNewDataSets, NewScreenObjects, NodeScreenObject,
            dlgOpenSutraFile.FileName);
      finally
        CustomList.Free;
      end;
    end;
  finally
    NewDataSets.Free;
    BcosLists.Free;
  end;
end;

procedure TfrmImportSutraModelResults.ImportSpecifiedPressureData(AllNewDataSets,
  NewScreenObjects: TList);
var
  NewDataSets: TList;
  BcopLists: TBcopLists;
  TimeIndex: Integer;
  ABcopList: TBcopList;
  ItemIndex: Integer;
  CustomList: TCustomItemList;
  NodeScreenObject: TScreenObject;
begin
  GetSelectedTimeSteps;
  NewDataSets := TList.Create;
  BcopLists := TBcopLists.Create;
  try
    NodeScreenObject := nil;
    ReadBcopFile(dlgOpenSutraFile.FileName, FResultList, BcopLists);
    for TimeIndex := 0 to BcopLists.Count - 1 do
    begin
      ABcopList := BcopLists[TimeIndex];
      CustomList := TCustomItemList.Create(False);
      try
        CustomList.Capacity := ABcopList.Count;
        for ItemIndex := 0 to ABcopList.Count - 1 do
        begin
          CustomList.Add(ABcopList[ItemIndex]);
        end;
        ImportBoundaryDataForOneTimeStep(CustomList, TimeIndex,
          NewDataSets, AllNewDataSets, NewScreenObjects, NodeScreenObject,
          dlgOpenSutraFile.FileName);
      finally
        CustomList.Free;
      end;
    end;
  finally
    NewDataSets.Free;
    BcopLists.Free;
  end;
end;

procedure TfrmImportSutraModelResults.ImportSpecifiedConcentrationData(AllNewDataSets,
  NewScreenObjects: TList);
var
  NewDataSets: TList;
  BcouLists: TBcouLists;
  TimeIndex: Integer;
  ABcouList: TBcouList;
  ItemIndex: Integer;
  CustomList: TCustomItemList;
  NodeScreenObject: TScreenObject;
begin
  GetSelectedTimeSteps;
  NewDataSets := TList.Create;
  BcouLists := TBcouLists.Create;
  try
    NodeScreenObject := nil;
    ReadBcouFile(dlgOpenSutraFile.FileName, FResultList, BcouLists);
    for TimeIndex := 0 to BcouLists.Count - 1 do
    begin
      ABcouList := BcouLists[TimeIndex];
      CustomList := TCustomItemList.Create(False);
      try
        CustomList.Capacity := ABcouList.Count;
        for ItemIndex := 0 to ABcouList.Count - 1 do
        begin
          CustomList.Add(ABcouList[ItemIndex]);
        end;
        ImportBoundaryDataForOneTimeStep(CustomList, TimeIndex,
          NewDataSets, AllNewDataSets, NewScreenObjects, NodeScreenObject,
          dlgOpenSutraFile.FileName);
      finally
        CustomList.Free;
      end;
    end;
  finally
    NewDataSets.Free;
    BcouLists.Free;
  end;
end;

procedure TfrmImportSutraModelResults.SetData;
var
  AllNewDataSets: TList;
  NewScreenObjects: TList;
  Undo: TUndoImportSutraResults;
  DisplayChoice: TDisplayChoice;
begin
  FColorContourDataArray := nil;
  F_CCItem := comboColorMesh.Items.
    Objects[comboColorMesh.ItemIndex] as TColorContourItem;
  AllNewDataSets := TList.Create;
  NewScreenObjects := TList.Create;
  try
    Undo := TUndoImportSutraResults.Create;
    try
      case dlgOpenSutraFile.FilterIndex of
        2:
          begin
            ImportNodeAndElementData(AllNewDataSets, NewScreenObjects);
          end;
        3:
          begin
            ImportFluidSourcesData(AllNewDataSets, NewScreenObjects);
          end;
        4:
          begin
            ImportSoluteSourcesData(AllNewDataSets, NewScreenObjects);
          end;
        5:
          begin
            ImportSpecifiedPressureData(AllNewDataSets, NewScreenObjects);
          end;
        6:
          begin
            ImportSpecifiedConcentrationData(AllNewDataSets, NewScreenObjects);
          end;
        else
          begin
            Assert(False);
          end;
      end;

      DisplayChoice := TDisplayChoice(rgDisplayChoice.ItemIndex);
      if FColorContourDataArray <> nil then
      begin
        case DisplayChoice of
          dcColor:
            begin
              frmGoPhast.acColoredGrid.Enabled := True;
              frmGoPhast.acColoredGrid.Checked := True;
              frmGoPhast.tb3DColors.Down := True;
            end;
          dcContour, dcNone:
            begin
              // do nothing
            end;
          else Assert(False);
        end;
      end;


      Undo.StoreNewScreenObjects(NewScreenObjects);
      Undo.StoreNewDataSets(AllNewDataSets);
      Undo.DisplayChoice := DisplayChoice;
      Undo.DisplayDataSet := FColorContourDataArray;
      frmGoPhast.BeginSuppressDrawing;
      try
        frmGoPhast.UndoStack.Submit(Undo)
      finally
        frmGoPhast.EndSupressDrawing;
      end;
    except
      Undo.Free;
      raise
    end;
  finally
    AllNewDataSets.Free;
    NewScreenObjects.Free;
  end;
end;

procedure TfrmImportSutraModelResults.UpdateColorContourList;
var
  ImportItems: TImportItems;
  Index: integer;
  TimeStep: Integer;
  ItemIndex: TImportItem;
  CCItem: TColorContourItem;
  SelectedText: TCaption;
  ItemText: string;
  IntList: TIntegerList;
  StoredResult: TStoredResults;
  BoundaryImportItems: TByteSet;
  ByteIndex: Byte;
begin
  EnableOkButton;
  FColorContourList.Clear;
  try
    case dlgOpenSutraFile.FilterIndex of
      2:
        begin
          ImportItems := [];
          for Index := 0 to chklstDataToImport.Count - 1 do
          begin
            if chklstDataToImport.Checked[Index] then
            begin
              Include(ImportItems, TImportItem(Index));
            end;
          end;
          if ImportItems = [] then
          begin
            Exit;
          end;
          IntList:= TIntegerList.Create;
          try
            for Index := 0 to chklstTimeStepsToImport.Count - 1 do
            begin
              if chklstTimeStepsToImport.Checked[Index] then
              begin
                StoredResult := chklstTimeStepsToImport.Items.
                  Objects[Index] as TStoredResults;
                IntList.Add(StoredResult.TimeStep);
              end;
            end;
            IntList.Sorted := True;
            if IntList.Count = 0 then
            begin
              Exit;
            end;
            if (ImportItems * [iiPressure, iiU, iiSaturation]) <> [] then
            begin
              for Index := 0 to FNodeReader.StoredResults.Count - 1 do
              begin
                TimeStep := FNodeReader.StoredResults[Index].TimeStep;

                if IntList.IndexOf(TimeStep) >= 0 then
                begin
                  for ItemIndex := FirstNodeItem to LastNodeItem do
                  begin
                    if ItemIndex in ImportItems then
                    begin
                      CCItem := TColorContourItem.Create;
                      FColorContourList.Add(CCItem);
                      CCItem.ImportChoice := ItemIndex;
                      CCItem.TimeStep := TimeStep;
                    end;
                  end;
                end;
              end;
            end;
            if (ImportItems * [iiXVel, iiYVel, iiZVel]) <> [] then
            begin
              for Index := 0 to FEleReader.StoredResults.Count - 1 do
              begin
                TimeStep := FEleReader.StoredResults[Index].TimeStep;
                if IntList.IndexOf(TimeStep) >= 0 then
                begin
                  for ItemIndex := FirstElementItem to LastElementItem do
                  begin
                    if ItemIndex in ImportItems then
                    begin
                      CCItem := TColorContourItem.Create;
                      FColorContourList.Add(CCItem);
                      CCItem.ImportChoice := ItemIndex;
                      CCItem.TimeStep := TimeStep;
                    end;
                  end;
                end;
              end;
            end;
          finally
            IntList.Free;
          end;

          FColorContourList.Sort(TColorContourItemComparer.Construct(
            function (const L, R: TColorContourItem): integer
             begin
               result := L.TimeStep - R.TimeStep;
               if result = 0 then
               begin
                 result := Ord(L.ImportChoice) - Ord(R.ImportChoice);
               end;
             end));
        end;
      3..6:
        begin
          BoundaryImportItems := [];
          for ByteIndex := 0 to chklstDataToImport.Count - 1 do
          begin
            if chklstDataToImport.Checked[ByteIndex] then
            begin
              Include(BoundaryImportItems, ByteIndex);
            end;
          end;
          if BoundaryImportItems = [] then
          begin
            Exit;
          end;
          for Index := 0 to chklstTimeStepsToImport.Count - 1 do
          begin
            if chklstTimeStepsToImport.Checked[Index] then
            begin
              TimeStep := FResultList[Index].TimeStep;
              for ByteIndex := 0 to chklstDataToImport.Count - 1 do
              begin
                if chklstDataToImport.Checked[ByteIndex] then
                begin
                  CCItem := TColorContourItem.Create;
                  FColorContourList.Add(CCItem);
                  CCItem.BoundaryImportChoice := ByteIndex;
                  CCItem.TimeStep := TimeStep;
                end;
              end;
            end;
          end;

        end
      else
        Assert(false);
    end;
  finally
    SelectedText := comboColorMesh.Text;
    comboColorMesh.Items.Clear;
    comboColorMesh.Items.Capacity := FColorContourList.Count+1;
    comboColorMesh.Items.Add(StrNone);
    for Index := 0 to FColorContourList.Count - 1 do
    begin
      CCItem := FColorContourList[Index];
      case dlgOpenSutraFile.FilterIndex of
        2: ItemText := chklstDataToImport.Items[Ord(CCItem.ImportChoice)];
        3..6: ItemText := chklstDataToImport.Items[CCItem.BoundaryImportChoice];
        else Assert(False);
      end;
      ItemText := Format(Str0sTS1d, [ItemText,CCItem.TimeStep]);
      comboColorMesh.Items.AddObject(ItemText, CCItem);
    end;
    comboColorMesh.ItemIndex := Max(0,
      comboColorMesh.Items.IndexOf(SelectedText));
  end;
end;

{ TUndoImportSutraResults }

constructor TUndoImportSutraResults.Create;
var
  SutraMesh: TSutraMesh3D;
  PhastModel: TPhastModel;
begin
  inherited;
  PhastModel := frmGoPhast.PhastModel;
  SutraMesh := PhastModel.SutraMesh;
  FOldTimeList := PhastModel.ThreeDTimeList;
  FOld3DDataSet := PhastModel.ThreeDDataSet;
  FOldTopDataSet := PhastModel.TopDataSet;
  FOldTopContourDataSet := SutraMesh.TopContourDataSet;
  FOld3DContourDataSet := SutraMesh.ThreeDContourDataSet;
end;

function TUndoImportSutraResults.Description: string;
begin
  result := StrImportSUTRAModelR;
end;

procedure TUndoImportSutraResults.DoCommand;
var
  PhastModel: TPhastModel;
  SutraMesh: TSutraMesh3D;
begin
  inherited;
  if FDisplayDataSet = nil then
  begin
    Exit;
  end;
  case DisplayChoice of
    dcColor:
      begin
        PhastModel := frmGoPhast.PhastModel;
        PhastModel.ThreeDTimeList := nil;
        PhastModel.ThreeDDataSet := FDisplayDataSet;
        PhastModel.TopDataSet := FDisplayDataSet;

        UpdateFrmDisplayData;
        UpdateFrmGridValue;
      end;
    dcContour:
      begin
        PhastModel := frmGoPhast.PhastModel;
        SutraMesh := PhastModel.SutraMesh;
        SutraMesh.TopContourDataSet := FDisplayDataSet;
        SutraMesh.ThreeDContourDataSet := FDisplayDataSet;
        UpdateFrmDisplayData;
        UpdateFrmGridValue;
      end;
    dcNone:;// do nothing
    else Assert(False);
  end;
end;

procedure TUndoImportSutraResults.SetDisplayChoice(const Value: TDisplayChoice);
begin
  FDisplayChoice := Value;
end;

procedure TUndoImportSutraResults.SetDisplayDataSet(const Value: TDataArray);
begin
  FDisplayDataSet := Value;
end;

procedure TUndoImportSutraResults.Undo;
var
  PhastModel: TPhastModel;
  SutraMesh: TSutraMesh3D;
begin
  inherited;
  if (FDisplayDataSet = nil) or (DisplayChoice = dcNone) then
  begin
    Exit;
  end;

  PhastModel := frmGoPhast.PhastModel;
  SutraMesh := PhastModel.SutraMesh;
  PhastModel.ThreeDTimeList := FOldTimeList;
  PhastModel.ThreeDDataSet := FOld3DDataSet;
  PhastModel.TopDataSet := FOldTopDataSet;
  SutraMesh.TopContourDataSet := FOldTopContourDataSet;
  SutraMesh.ThreeDContourDataSet := FOld3DContourDataSet;

  UpdateFrmDisplayData;
  UpdateFrmGridValue;

end;

initialization
  SutraPressureResults := StrModelResults + '|' + 'Pressure';
  SutraUResults := StrModelResults + '|' + 'U Values';
  SutraSaturationResults := StrModelResults + '|' + 'Saturation';

  SutraXVelocityResults := StrModelResults + '|' + 'X Velocity';
  SutraYVelocityResults := StrModelResults + '|' + 'Y Velocity';
  SutraZVelocityResults := StrModelResults + '|' + 'Z Velocity';

end.
