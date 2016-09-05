unit SutraInputWriterUnit;

interface

uses
  CustomModflowWriterUnit, PhastModelUnit, JclAnsiStrings, SutraOptionsUnit,
  SutraMeshUnit, SutraOutputControlUnit, Generics.Collections,
  Generics.Defaults, IntListUnit, SysUtils, Classes, GoPhastTypes;

type
  TNodeData = class(TObject)
    Number: Integer;
    NREG: Integer;
    X: Double;
    Y: double;
    Z: double;
    Porosity: double;
  end;

  TNodeDataList = TObjectList<TNodeData>;

  TNodeDataComparer = TComparer<TNodeData>;

  TElementData = class(TObject)
    Number: Integer;
    LREG: Integer;
    PMAX: double;
    PMID: double;
    PMIN: double;
    ANGLE1: double;
    ANGLE2: double;
    ANGLE3: double;
    ALMAX: double;
    ALMID: double;
    ALMIN: double;
    ATMAX: double;
    ATMID: double;
    ATMIN: double;
    // X, Y, and Z are used when importing model results.
    X: Double;
    Y: double;
    Z: Double;
  end;

  TElementDataList = TObjectList<TElementData>;

  TElementDataComparer = TComparer<TElementData>;

  TSutraInputWriter = class(TCustomFileWriter)
  private
    FOptions: TSutraOptions;
    FNOBS: Integer;
    FMesh: TSutraMesh3D;
    FOutputControl: TSutraOutputControl;
    FFluidSourceNodes: IBoundaryNodes;
    FMassEnergySourceNodes: IBoundaryNodes;
    FSpecifiedPressureNodes: IBoundaryNodes;
    FSpecifiedTempConcNodes: IBoundaryNodes;
    FFileName: string;
    FSchedules: TStringList;
    FObservations: TStringList;
    procedure WriteDataSet0;
    procedure WriteDataSet1;
    procedure WriteDataSet2A;
    procedure WriteDataSet2B;
    procedure WriteDataSet3;
    procedure WriteDataSet4;
    procedure WriteDataSet5;
    procedure WriteDataSet6;
    procedure WriteDataSet7A;
    procedure WriteDataSet7B;
    procedure WriteDataSet7C;
    procedure WriteDataSet8A;
    procedure WriteDataSet8B;
    procedure WriteDataSet8C;
    procedure WriteDataSet8D;
    procedure WriteDataSet8E;
    procedure WriteDataSet9;
    procedure WriteDataSet10;
    procedure WriteDataSet11;
    procedure WriteDataSet12;
    procedure WriteDataSet13;
    procedure WriteDataSet14A;
    procedure WriteDataSet14B;
    procedure WriteDataSet15A;
    procedure WriteDataSet15B;
    procedure WriteDataSet17;
    procedure WriteDataSet18;
    procedure WriteDataSet19;
    procedure WriteDataSet20;
    procedure WriteDataSet22;
  protected
    class function Extension: string; override;
  public
    Constructor Create(AModel: TCustomModel); reintroduce;
    procedure WriteFile(FileName: string; FluidSourceNodes,
      MassEnergySourceNodes, SpecifiedPressureNodes,
      SpecifiedTempConcNodes: IBoundaryNodes; NOBS: integer;
      Schedules, Observations: TStringList);
  end;


implementation

uses
  DataSetUnit, SutraFileWriterUnit, frmErrorsAndWarningsUnit;

resourcestring
  StrMaxPermMinPerm = 'Maximum permeability < Minimum permeability';
  StrMaxKMinK = 'Maximum hydraulic conductivity < Minimum hydraulic conducti' +
  'vity';
  StrMaxPermMidPerm = 'Maximum permeability < Middle permeability';
  StrMaxKMidK = 'Maximum hydraulic conductivity < Middle hydraulic conductiv' +
  'ity';
  StrMidPermMinPerm = 'Middle permeability < Minimum permeability';
  StrMidKMinK = 'Middle hydraulic conductivity < Minimum hydraulic conductiv' +
  'ity';

{ TSutraInputWriter }

constructor TSutraInputWriter.Create(AModel: TCustomModel);
begin
  inherited Create(AModel, etExport);
  FOptions := AModel.SutraOptions;
  FOutputControl := AModel.SutraOutputControl;
  FMesh := AModel.SutraMesh;
end;

procedure TSutraInputWriter.WriteDataSet1;
var
  TITLE1: AnsiString;
  TITLE2: AnsiString;
  StringList: TJclAnsiStringList;
  LineIndex: Integer;
  ALine: AnsiString;
begin
  StringList := TJclAnsiStringList.Create;
  try
    StringList.Text := FOptions.TitleLines;
    if StringList.Count > 0 then
    begin
      TITLE1 := StringList[0];
    end
    else
    begin
      TITLE1 := '_';
    end;
    WriteCommentLine('Data set 1');

    WriteString(TITLE1);
    NewLine;

    if StringList.Count > 1 then
    begin
      TITLE2 := StringList[1];
    end
    else
    begin
      TITLE2 := '_';
    end;
    WriteString(TITLE2);
    NewLine;

    for LineIndex := 2 to StringList.Count - 1 do
    begin
      ALine := '# ' + StringList[LineIndex];
      WriteString(ALine);
      NewLine;
    end;
  finally
    StringList.Free;
  end;
  // Data set 1
end;

procedure TSutraInputWriter.WriteDataSet10;
var
  COMPMA: Double;
  CS: Double;
  SIGMAS: Double;
  RHOS: Double;
begin
  WriteCommentLine('Data set 10');
  COMPMA := FOptions.MatrixCompressibility;

  CS := 0.;
  SIGMAS := 0.;
  RHOS := 0.;
  case FOptions.TransportChoice of
    tcSolute, tcSoluteHead:
      begin
        CS := 0;
        SIGMAS := 0;
        if FOptions.SorptionModel = smNone then
        begin
          RHOS := 0;
        end
        else
        begin
          RHOS := FOptions.SolidGrainDensity;
        end;
      end;
    tcEnergy:
      begin
        CS := FOptions.SolidGrainSpecificHeat;
        SIGMAS := FOptions.SolidGrainDiffusivity;
        RHOS := FOptions.SolidGrainDensity;
      end;
    else
      Assert(False);
  end;
  WriteFloat(COMPMA);
  WriteFloat(CS);
  WriteFloat(SIGMAS);
  WriteFloat(RHOS);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet11;
var
  ADSMOD: AnsiString;
  CHI1: double;
  CHI2: double;
begin
  WriteCommentLine('Data set 11');
  case FOptions.TransportChoice of
    tcSolute, tcSoluteHead:
      begin
        ADSMOD := '';
        CHI1 := 0.;
        CHI2 := 0.;
        case FOptions.SorptionModel of
          smNone:
            begin
              ADSMOD := '''NONE'' ';
              CHI1 := 0.;
              CHI2 := 0.;
            end;
          smLinear:
            begin
              ADSMOD := '''LINEAR'' ';
              CHI1 := FOptions.FirstDistributionCoefficient;
              CHI2 := 0.;
            end;
          smFreundlich:
            begin
              ADSMOD := '''FREUNDLICH'' ';
              CHI1 := FOptions.FirstDistributionCoefficient;
              CHI2 := FOptions.SecondDistributionCoefficient;
            end;
          smLangmuir:
            begin
              ADSMOD := '''LANGMUIR'' ';
              CHI1 := FOptions.FirstDistributionCoefficient;
              CHI2 := FOptions.SecondDistributionCoefficient;
            end;
          else
            Assert(False);
        end;
        WriteString(ADSMOD);
        WriteFloat(CHI1);
        WriteFloat(CHI2);
      end;
    tcEnergy:
      begin
        ADSMOD := '''NONE''';
        WriteString(ADSMOD);
      end;
    else Assert(False);
  end;
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet12;
var
  PRODF�: Double;
  PRODS�: Double;
  PRODF1: Double;
  PRODS1: Double;
begin
  WriteCommentLine('Data set 12');
  PRODF� := FOptions.ZeroFluidProduction;
  PRODS� := FOptions.ZeroImmobileProduction;
  PRODF1 := FOptions.FirstFluidProduction;
  PRODS1 := FOptions.FirstImmobileProduction;
  WriteFloat(PRODF�);
  WriteFloat(PRODS�);
  WriteFloat(PRODF1);
  WriteFloat(PRODS1);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet13;
var
  GRAVX: Double;
  GRAVY: Double;
  GRAVZ: Double;
begin
  GRAVX := 0;
  GRAVY := 0;
  GRAVZ := 0;
  WriteCommentLine('Data set 13');
  case FOptions.TransportChoice of
    tcSolute, tcEnergy:
      begin
        GRAVX := FOptions.GravityX;
        GRAVY := FOptions.GravityY;
        if FMesh.MeshType in [mt2D, mtProfile] then
        begin
          GRAVZ := 0;
        end
        else
        begin
          GRAVZ := FOptions.GravityZ;
        end;
      end;
    tcSoluteHead:
      begin
        GRAVX := 0;
        GRAVY := 0;
        GRAVZ := 0;
      end;
    else
      Assert(False);
  end;
  WriteFloat(GRAVX);
  WriteFloat(GRAVY);
  WriteFloat(GRAVZ);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet14A;
const
  SCALX = 1.;
  SCALY = 1.;
  SCALZ = 1.;
  PORFAC = 1.;
begin
  WriteCommentLine('Data set 14A');
  WriteString('''NODE'' ');
  WriteFloat(SCALX);
  WriteFloat(SCALY);
  WriteFloat(SCALZ);
  WriteFloat(PORFAC);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet14B;
var
  Porosity: TDataArray;
  UnsatRegion: TDataArray;
  Thickness: TDataArray;
  Nodes: TNodeDataList;
  LayerIndex: Integer;
  NodeIndex: Integer;
  ANode2D: TSutraNode2D;
  NodeData: TNodeData;
  ANode3D: TSutraNode3D;
begin
  WriteCommentLine('Data set 14B');
  Porosity := Model.DataArrayManager.GetDataSetByName(KNodalPorosity);
  Porosity.Initialize;
  if FOptions.SaturationChoice = scUnsaturated then
  begin
    UnsatRegion := Model.DataArrayManager.GetDataSetByName(KUnsatRegionNodes);
    UnsatRegion.Initialize;
  end
  else
  begin
    UnsatRegion := nil;
  end;
  if FMesh.MeshType in [mt2D, mtProfile] then
  begin
    Thickness := Model.DataArrayManager.GetDataSetByName(KNodalThickness);
    Thickness.Initialize;
  end
  else
  begin
    Thickness := nil;
  end;

  Nodes := TNodeDataList.Create;
  try

    if FMesh.MeshType in [mt2D, mtProfile] then
    begin
      Nodes.Capacity := FMesh.Mesh2D.Nodes.Count;
      for NodeIndex := 0 to FMesh.Mesh2D.Nodes.Count - 1 do
      begin
        ANode2D := FMesh.Mesh2D.Nodes[NodeIndex];
        NodeData := TNodeData.Create;
        Nodes.Add(NodeData);
        NodeData.Number := ANode2D.Number;
        if UnsatRegion = nil then
        begin
          NodeData.NREG := 0;
        end
        else
        begin
          NodeData.NREG := UnsatRegion.IntegerData[0,0,NodeIndex];
        end;
        NodeData.X := ANode2D.X;
        NodeData.Y := ANode2D.Y;
        NodeData.Z := Thickness.RealData[0,0,NodeIndex];
        NodeData.Porosity := Porosity.RealData[0,0,NodeIndex];
      end;
    end
    else
    begin
      Nodes.Capacity := FMesh.ActiveNodeCount;
      for LayerIndex := 0 to FMesh.LayerCount do
      begin
        for NodeIndex := 0 to FMesh.Mesh2D.Nodes.Count - 1 do
        begin
          ANode3D := FMesh.NodeArray[LayerIndex,NodeIndex];
          if ANode3D.Active then
          begin
            NodeData := TNodeData.Create;
            Nodes.Add(NodeData);
            NodeData.Number := ANode3D.Number;
            if UnsatRegion = nil then
            begin
              NodeData.NREG := 0;
            end
            else
            begin
              NodeData.NREG := UnsatRegion.IntegerData[LayerIndex,0,NodeIndex];
            end;
            NodeData.X := ANode3D.X;
            NodeData.Y := ANode3D.Y;
            NodeData.Z := ANode3D.Z;
            NodeData.Porosity := Porosity.RealData[LayerIndex,0,NodeIndex];
          end;
        end;
      end;

      Nodes.Sort(TNodeDataComparer.Construct(
        function (const L, R: TNodeData): integer
        begin
          result := L.Number - R.Number;
        end));
    end;




    for NodeIndex := 0 to Nodes.Count - 1 do
    begin
      NodeData := Nodes[NodeIndex];
      Assert(NodeIndex = NodeData.Number);
      WriteInteger(NodeData.Number + 1);
      WriteInteger(NodeData.NREG);
      WriteFloat(NodeData.X);
      WriteFloat(NodeData.Y);
      WriteFloat(NodeData.Z);
      WriteFloat(NodeData.Porosity);
      NewLine;
    end;
  finally
    Nodes.Free;
  end;

  Model.DataArrayManager.AddDataSetToCache(Porosity);
  if UnsatRegion <> nil then
  begin
    Model.DataArrayManager.AddDataSetToCache(UnsatRegion);
  end;
  if Thickness <> nil then
  begin
    Model.DataArrayManager.AddDataSetToCache(Thickness);
  end;
  Model.DataArrayManager.CacheDataArrays;
end;

procedure TSutraInputWriter.WriteDataSet15A;
const
  PMAXFA = 1.;
  PMIDFA = 1.;
  PMINFA = 1.;
  ANG1FA = 1.;
  ANG2FA = 1.;
  ANG3FA = 1.;
  ALMAXF = 1.;
  ALMIDF = 1.;
  ALMINF = 1.;
  ATMAXF = 1.;
  ATMIDF = 1.;
  ATMINF = 1.;
begin
  WriteCommentLine('Data set 15A');
  WriteString('''ELEMENT'' ');
  WriteFloat(PMAXFA);
  if FMesh.MeshType = mt3D then
  begin
    WriteFloat(PMIDFA);
  end;
  WriteFloat(PMINFA);
  WriteFloat(ANG1FA);
  if FMesh.MeshType = mt3D then
  begin
    WriteFloat(ANG2FA);
    WriteFloat(ANG3FA);
  end;
  WriteFloat(ALMAXF);
  if FMesh.MeshType = mt3D then
  begin
    WriteFloat(ALMIDF);
  end;
  WriteFloat(ALMINF);
  WriteFloat(ATMAXF);
  if FMesh.MeshType = mt3D then
  begin
    WriteFloat(ATMIDF);
  end;
  WriteFloat(ATMINF);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet15B;
var
  UnsatRegion: TDataArray;
  MaxPerm: TDataArray;
  MinPerm: TDataArray;
  MidPerm: TDataArray;
  HorizAngle: TDataArray;
  VerticalAngle: TDataArray;
  RotationAngle: TDataArray;
  MaxLongDisp: TDataArray;
  MidLongDisp: TDataArray;
  MinLongDisp: TDataArray;
  MaxTransvDisp: TDataArray;
  MidTransvDisp: TDataArray;
  MinTransvDisp: TDataArray;
  ElementList: TElementDataList;
  ElementIndex: Integer;
  AnElement2D: TSutraElement2D;
  ElData: TElementData;
  LayerIndex: Integer;
  AnElement3D: TSutraElement3D;
begin
  WriteCommentLine('Data set 15B');
  if FOptions.SaturationChoice = scUnsaturated then
  begin
    UnsatRegion := Model.DataArrayManager.GetDataSetByName(KUnsatRegionElements);
    UnsatRegion.Initialize;
  end
  else
  begin
    UnsatRegion := nil;
  end;
  MaxPerm := nil;
  case FOptions.TransportChoice of
    tcSolute, tcEnergy:
      MaxPerm := Model.DataArrayManager.GetDataSetByName(KMaximumPermeability);
    tcSoluteHead:
      MaxPerm := Model.DataArrayManager.GetDataSetByName(KMaximumK);
    else Assert(False);
  end;
  MaxPerm.Initialize;
  MidPerm := nil;
  if FMesh.MeshType = mt3D then
  begin
    case FOptions.TransportChoice of
      tcSolute, tcEnergy:
        MidPerm := Model.DataArrayManager.GetDataSetByName(KMiddlePermeability);
      tcSoluteHead:
        MidPerm := Model.DataArrayManager.GetDataSetByName(KMiddleK);
      else Assert(False);
    end;
    MidPerm.Initialize;
  end
  else
  begin
    MidPerm := nil;
  end;
  MinPerm := nil;
  case FOptions.TransportChoice of
    tcSolute, tcEnergy:
      MinPerm := Model.DataArrayManager.GetDataSetByName(KMinimumPermeability);
    tcSoluteHead:
      MinPerm := Model.DataArrayManager.GetDataSetByName(KMinimumK);
    else Assert(False);
  end;
  MinPerm.Initialize;
  HorizAngle := Model.DataArrayManager.GetDataSetByName(KHorizontalAngle);
  HorizAngle.Initialize;
  if FMesh.MeshType = mt3D then
  begin
    VerticalAngle := Model.DataArrayManager.GetDataSetByName(KVerticalAngle);
    VerticalAngle.Initialize;
    RotationAngle := Model.DataArrayManager.GetDataSetByName(KRotationalAngle);
    RotationAngle.Initialize;
  end
  else
  begin
    VerticalAngle := nil;
    RotationAngle := nil;
  end;

  MaxLongDisp := Model.DataArrayManager.GetDataSetByName(KMaxLongitudinalDisp);
  MaxLongDisp.Initialize;
  if FMesh.MeshType = mt3D then
  begin
    MidLongDisp := Model.DataArrayManager.GetDataSetByName(KMidLongitudinalDisp);
    MidLongDisp.Initialize;
  end
  else
  begin
    MidLongDisp := nil;
  end;
  MinLongDisp := Model.DataArrayManager.GetDataSetByName(KMinLongitudinalDisp);
  MinLongDisp.Initialize;

  MaxTransvDisp := Model.DataArrayManager.GetDataSetByName(KMaxTransverseDisp);
  MaxTransvDisp.Initialize;
  if FMesh.MeshType = mt3D then
  begin
    MidTransvDisp := Model.DataArrayManager.GetDataSetByName(KMidTransverseDisp);
    MidTransvDisp.Initialize;
  end
  else
  begin
    MidTransvDisp := nil;
  end;
  MinTransvDisp := Model.DataArrayManager.GetDataSetByName(KMinTransverseDisp);
  MinTransvDisp.Initialize;

  ElementList := TElementDataList.Create;
  try
    if FMesh.MeshType in [mt2D, mtProfile] then
    begin
      ElementList.Capacity := FMesh.Mesh2D.Elements.Count;
      for ElementIndex := 0 to FMesh.Mesh2D.Elements.Count - 1 do
      begin
        AnElement2D := FMesh.Mesh2D.Elements[ElementIndex];
        ElData := TElementData.Create;
        ElementList.Add(ElData);
        ElData.Number := AnElement2D.ElementNumber;
        if UnsatRegion = nil then
        begin
          ElData.LREG := 0
        end
        else
        begin
          ElData.LREG := UnsatRegion.IntegerData[0,0,ElementIndex];
        end;
        ElData.PMAX := MaxPerm.RealData[0,0,ElementIndex];
        ElData.PMID := 0;
        ElData.PMIN := MinPerm.RealData[0,0,ElementIndex];
        ElData.ANGLE1 := HorizAngle.RealData[0,0,ElementIndex];
        ElData.ANGLE2 := 0;
        ElData.ANGLE3 := 0;
        ElData.ALMAX := MaxLongDisp.RealData[0,0,ElementIndex];
        ElData.ALMID := 0;
        ElData.ALMIN := MinLongDisp.RealData[0,0,ElementIndex];
        ElData.ATMAX := MaxTransvDisp.RealData[0,0,ElementIndex];
        ElData.ATMID := 0;
        ElData.ATMIN := MinTransvDisp.RealData[0,0,ElementIndex];
      end;
    end
    else
    begin
      ElementList.Capacity := FMesh.ActiveElementCount;
      for LayerIndex := 0 to FMesh.LayerCount - 1 do
      begin
        for ElementIndex := 0 to FMesh.Mesh2D.Elements.Count - 1 do
        begin
          AnElement3D := FMesh.ElementArray[LayerIndex,ElementIndex];
          if AnElement3D.Active then
          begin
            ElData := TElementData.Create;
            ElementList.Add(ElData);
            ElData.Number := AnElement3D.ElementNumber;
            if UnsatRegion = nil then
            begin
              ElData.LREG := 0
            end
            else
            begin
              ElData.LREG := UnsatRegion.IntegerData[LayerIndex,0,ElementIndex];
            end;
            ElData.PMAX := MaxPerm.RealData[LayerIndex,0,ElementIndex];
            ElData.PMID := MidPerm.RealData[LayerIndex,0,ElementIndex];
            ElData.PMIN := MinPerm.RealData[LayerIndex,0,ElementIndex];
            ElData.ANGLE1 := HorizAngle.RealData[LayerIndex,0,ElementIndex];
            ElData.ANGLE2 := VerticalAngle.RealData[LayerIndex,0,ElementIndex];
            ElData.ANGLE3 := RotationAngle.RealData[LayerIndex,0,ElementIndex];
            ElData.ALMAX := MaxLongDisp.RealData[LayerIndex,0,ElementIndex];
            ElData.ALMID := MidLongDisp.RealData[LayerIndex,0,ElementIndex];
            ElData.ALMIN := MinLongDisp.RealData[LayerIndex,0,ElementIndex];
            ElData.ATMAX := MaxTransvDisp.RealData[LayerIndex,0,ElementIndex];
            ElData.ATMID := MidTransvDisp.RealData[LayerIndex,0,ElementIndex];
            ElData.ATMIN := MinTransvDisp.RealData[LayerIndex,0,ElementIndex];
          end;
        end;
      end;
    end;

    ElementList.Sort(TElementDataComparer.Construct(
      function (const L, R: TElementData): integer
      begin
        result := L.Number - R.Number;
      end));

    for ElementIndex := 0 to ElementList.Count - 1 do
    begin
      ElData := ElementList[ElementIndex];
      Assert(ElData.Number = ElementIndex);
      WriteInteger(ElData.Number+1);
      WriteInteger(ElData.LREG);
      WriteFloat(ElData.PMAX);
      if FMesh.MeshType = mt3D then
      begin
        WriteFloat(ElData.PMID);
      end;
      WriteFloat(ElData.PMIN);
      WriteFloat(ElData.ANGLE1);
      if FMesh.MeshType = mt3D then
      begin
        WriteFloat(ElData.ANGLE2);
        WriteFloat(ElData.ANGLE3);
      end;
      WriteFloat(ElData.ALMAX);
      if FMesh.MeshType = mt3D then
      begin
        WriteFloat(ElData.ALMID);
      end;
      WriteFloat(ElData.ALMIN);
      WriteFloat(ElData.ATMAX);
      if FMesh.MeshType = mt3D then
      begin
        WriteFloat(ElData.ATMID);
      end;
      WriteFloat(ElData.ATMIN);
      NewLine;
      case FMesh.MeshType of
        mt2D, mtProfile:
          begin
            if ElData.PMAX < ElData.PMIN then
            begin
              case FOptions.TransportChoice of
                tcSolute, tcEnergy:
                  begin
                    frmErrorsAndWarnings.AddWarning(Model,
                      StrMaxPermMinPerm, IntToStr(ElData.Number+1));
                  end;
                tcSoluteHead:
                  begin
                    frmErrorsAndWarnings.AddWarning(Model,
                      StrMaxKMinK, IntToStr(ElData.Number+1));
                  end;
                else Assert(False);
              end;
            end;

//            if ElData.ALMAX < ElData.ALMIN then
//            begin
//
//            end;
//
//            if ElData.ATMAX < ElData.ATMIN then
//            begin
//
//            end;
          end;
        mt3D:
          begin
            if ElData.PMAX < ElData.PMID then
            begin
              case FOptions.TransportChoice of
                tcSolute, tcEnergy:
                  begin
                    frmErrorsAndWarnings.AddWarning(Model,
                      StrMaxPermMidPerm, IntToStr(ElData.Number+1));
                  end;
                tcSoluteHead:
                  begin
                    frmErrorsAndWarnings.AddWarning(Model,
                      StrMaxKMidK, IntToStr(ElData.Number+1));
                  end;
                else Assert(False);
              end;
            end;
            if ElData.PMID < ElData.PMIN then
            begin
              case FOptions.TransportChoice of
                tcSolute, tcEnergy:
                  begin
                    frmErrorsAndWarnings.AddWarning(Model,
                      StrMidPermMinPerm, IntToStr(ElData.Number+1));
                  end;
                tcSoluteHead:
                  begin
                    frmErrorsAndWarnings.AddWarning(Model,
                      StrMidKMinK, IntToStr(ElData.Number+1));
                  end;
                else Assert(False);
              end;
            end;

//            if ElData.ALMAX < ElData.ALMID then
//            begin
//
//            end;
//            if ElData.ALMID < ElData.ALMIN then
//            begin
//
//            end;
//
//            if ElData.ATMAX < ElData.ATMID then
//            begin
//
//            end;
//            if ElData.ATMID < ElData.ATMIN then
//            begin
//
//            end;
          end;
      end;
    end;

  finally
    ElementList.Free;
  end;

  if UnsatRegion <> nil then
  begin
    Model.DataArrayManager.AddDataSetToCache(UnsatRegion);
  end;
  Model.DataArrayManager.AddDataSetToCache(MaxPerm);
  if MidPerm <> nil then
  begin
    Model.DataArrayManager.AddDataSetToCache(MidPerm);
  end;
  Model.DataArrayManager.AddDataSetToCache(MinPerm);
  Model.DataArrayManager.AddDataSetToCache(HorizAngle);
  if VerticalAngle <> nil then
  begin
    Model.DataArrayManager.AddDataSetToCache(VerticalAngle);
  end;
  if RotationAngle <> nil then
  begin
    Model.DataArrayManager.AddDataSetToCache(RotationAngle);
  end;

  Model.DataArrayManager.AddDataSetToCache(MaxLongDisp);
  if MidLongDisp <> nil then
  begin
    Model.DataArrayManager.AddDataSetToCache(MidLongDisp);
  end;
  Model.DataArrayManager.AddDataSetToCache(MinLongDisp);

  Model.DataArrayManager.AddDataSetToCache(MaxTransvDisp);
  if MidTransvDisp <> nil then
  begin
    Model.DataArrayManager.AddDataSetToCache(MidTransvDisp);
  end;
  Model.DataArrayManager.AddDataSetToCache(MinTransvDisp);


end;

procedure TSutraInputWriter.WriteDataSet17;
var
  NodeIndex: Integer;
  Nodes: TArray<TPair<Integer, TBoundaryNode>>;
  ANode: TBoundaryNode;
begin
  Nodes := FFluidSourceNodes.ToArray;
  if Length(Nodes) > 0 then
  begin
    WriteCommentLine('Data set 17');
    for NodeIndex := 0 to Length(Nodes) - 1 do
    begin
      ANode := Nodes[NodeIndex].Value;
      WriteInteger(ANode.NodeNumber);
      WriteFloat(ANode.PressureOrFlow);
      WriteFloat(ANode.TempOrConc);
      NewLine;
    end;
    WriteInteger(0);
    NewLine;
  end;

//  if FFluidSourceNodes.Count > 0 then
//  begin
//    WriteCommentLine('Data set 17');
//    for NodeIndex := 0 to FFluidSourceNodes.Count - 1 do
//    begin
//      WriteInteger(FFluidSourceNodes[NodeIndex]);
//      WriteFloat(0.0);
//      WriteFloat(0.0);
//      NewLine;
//    end;
//    WriteInteger(0);
//    NewLine;
//  end;
end;

procedure TSutraInputWriter.WriteDataSet18;
var
  NodeIndex: Integer;
  Nodes: TArray<TPair<Integer, TBoundaryNode>>;
  ANode: TBoundaryNode;
begin
  Nodes := FMassEnergySourceNodes.ToArray;
  if Length(Nodes) > 0 then
  begin
    WriteCommentLine('Data set 18');
    for NodeIndex := 0 to Length(Nodes) - 1 do
    begin
      ANode := Nodes[NodeIndex].Value;
      WriteInteger(ANode.NodeNumber);
//      WriteFloat(ANode.PressureOrFlow);
      WriteFloat(ANode.TempOrConc);
      NewLine;
    end;
    WriteInteger(0);
    NewLine;
  end;


//  if FMassEnergySourceNodes.Count > 0 then
//  begin
//    WriteCommentLine('Data set 18');
//    for NodeIndex := 0 to FMassEnergySourceNodes.Count - 1 do
//    begin
//      WriteInteger(FMassEnergySourceNodes[NodeIndex]);
//      WriteFloat(0.0);
//      NewLine;
//    end;
//    WriteInteger(0);
//    NewLine;
//  end;
end;

procedure TSutraInputWriter.WriteDataSet19;
var
  NodeIndex: Integer;
  Nodes: TArray<TPair<Integer, TBoundaryNode>>;
  ANode: TBoundaryNode;
begin
  Nodes := FSpecifiedPressureNodes.ToArray;
  if Length(Nodes) > 0 then
  begin
    WriteCommentLine('Data set 19');
    for NodeIndex := 0 to Length(Nodes) - 1 do
    begin
      ANode := Nodes[NodeIndex].Value;
      WriteInteger(ANode.NodeNumber);
      WriteFloat(ANode.PressureOrFlow);
      WriteFloat(ANode.TempOrConc);
      NewLine;
    end;
    WriteInteger(0);
    NewLine;
  end;

//  if FSpecifiedPressureNodes.Count > 0 then
//  begin
//    WriteCommentLine('Data set 19');
//    for NodeIndex := 0 to FSpecifiedPressureNodes.Count - 1 do
//    begin
//      WriteInteger(FSpecifiedPressureNodes[NodeIndex]);
//      WriteFloat(0.0);
//      WriteFloat(0.0);
//      NewLine;
//    end;
//    WriteInteger(0);
//    NewLine;
//  end;
end;

procedure TSutraInputWriter.WriteDataSet9;
var
  COMPFL: double;
  CW: double;
  RHOW�: Double;
  SIGMAW: Double;
  URHOW�: Double;
  DRWDU: Double;
  VISC�: Double;
begin
  WriteCommentLine('Data set 9');
  COMPFL := FOptions.FluidCompressibility;

  CW := 0.;
  SIGMAW := 0.;
  URHOW� := 0.;
  DRWDU := 0.;
  VISC� := 0.;
  RHOW� := 0.;
  case FOptions.TransportChoice of
    tcSolute:
      begin
        CW := 0.;
        SIGMAW := FOptions.FluidDiffusivity;
        URHOW� := FOptions.BaseConcentration;
        DRWDU := FOptions.FluidDensityCoefficientConcentration;
        VISC� := FOptions.Viscosity;
        RHOW� := FOptions.BaseFluidDensity;
      end;
    tcSoluteHead:
      begin
        CW := 0.;
        SIGMAW := FOptions.FluidDiffusivity;
        URHOW� := 0;
        DRWDU := 0;
        VISC� := 1;
        RHOW� := 1;
      end;
    tcEnergy:
      begin
        CW := FOptions.FluidSpecificHeat;
        SIGMAW := FOptions.FluidThermalConductivity;
        URHOW� := FOptions.BaseTemperature;
        DRWDU := FOptions.FluidDensityCoefficientTemperature;
        VISC� := FOptions.ScaleFactor;
        RHOW� := FOptions.BaseFluidDensity;
      end
    else
      Assert(False);
  end;
  WriteFloat(COMPFL);
  WriteFloat(CW);
  WriteFloat(SIGMAW);
  WriteFloat(RHOW�);
  WriteFloat(URHOW�);
  WriteFloat(DRWDU);
  WriteFloat(VISC�);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet20;
var
  NodeIndex: Integer;
  Nodes: TArray<TPair<Integer, TBoundaryNode>>;
  ANode: TBoundaryNode;
begin
  Nodes := FSpecifiedTempConcNodes.ToArray;
  if Length(Nodes) > 0 then
  begin
    WriteCommentLine('Data set 20');
    for NodeIndex := 0 to Length(Nodes) - 1 do
    begin
      ANode := Nodes[NodeIndex].Value;
      WriteInteger(ANode.NodeNumber);
//      WriteFloat(ANode.PressureOrFlow);
      WriteFloat(ANode.TempOrConc);
      NewLine;
    end;
    WriteInteger(0);
    NewLine;
  end;

//  if FSpecifiedTempConcNodes.Count > 0 then
//  begin
//    WriteCommentLine('Data set 20');
//    for NodeIndex := 0 to FSpecifiedTempConcNodes.Count - 1 do
//    begin
//      WriteInteger(FSpecifiedTempConcNodes[NodeIndex]);
//      WriteFloat(0.0);
//      NewLine;
//    end;
//    WriteInteger(0);
//    NewLine;
//  end;
end;

procedure TSutraInputWriter.WriteDataSet22;
var
  ElementIndex: Integer;
  Element2D: TSutraElement2D;
  El2DList: TSutraElement2D_List;
  NodeIndex: Integer;
  Node2D: TSutraNode2D;
  El3DList: TSutraElement3DList;
  AnElement3D: TSutraElement3D;
  Node3D: TSutraNode3D;
begin
  WriteCommentLine('Data set 22');
  WriteString('INCIDENCE');
  NewLine;
  if FMesh.MeshType in [mt2D, mtProfile] then
  begin
    El2DList := TSutraElement2D_List.Create;
    try
      El2DList.Capacity := FMesh.Mesh2D.Elements.Count;
      for ElementIndex := 0 to FMesh.Mesh2D.Elements.Count - 1 do
      begin
        El2DList.Add(FMesh.Mesh2D.Elements[ElementIndex]);
      end;

      El2DList.Sort(TComparer<TSutraElement2D>.Construct(
        function (const L, R: TSutraElement2D): integer
        begin
          result := L.ElementNumber - R.ElementNumber;
        end));

      for ElementIndex := 0 to El2DList.Count - 1 do
      begin
        Element2D := El2DList[ElementIndex];
        Assert(Element2D.ElementNumber = ElementIndex);
        Assert(Element2D.Nodes.Count = 4);
        WriteInteger(Element2D.ElementNumber+1);
        for NodeIndex := 0 to Element2D.Nodes.Count - 1 do
        begin
          Node2D := Element2D.Nodes[NodeIndex].Node;
          WriteInteger(Node2D.Number+1);
        end;
        NewLine;
      end;
    finally
      El2DList.Free;
    end;
  end
  else
  begin
    El3DList := TSutraElement3DList.Create;
    try
      El3DList.Capacity := FMesh.ActiveElementCount;
      for ElementIndex := 0 to FMesh.Elements.Count - 1 do
      begin
        AnElement3D := FMesh.Elements[ElementIndex];
        if AnElement3D.Active then
        begin
          El3DList.Add(AnElement3D);
        end;
      end;

      El3DList.Sort(TComparer<TSutraElement3D>.Construct(
        function (const L, R: TSutraElement3D): integer
        begin
          result := L.ElementNumber - R.ElementNumber;
        end));

      for ElementIndex := 0 to El3DList.Count - 1 do
      begin
        AnElement3D := El3DList[ElementIndex];
        Assert(AnElement3D.ElementNumber = ElementIndex);
        Assert(AnElement3D.Nodes.Count = 8);
        WriteInteger(AnElement3D.ElementNumber+1);
        for NodeIndex := 4 to AnElement3D.Nodes.Count - 1 do
        begin
          Node3D := AnElement3D.Nodes[NodeIndex].Node;
          WriteInteger(Node3D.Number+1);
        end;
        for NodeIndex := 0 to 3 do
        begin
          Node3D := AnElement3D.Nodes[NodeIndex].Node;
          WriteInteger(Node3D.Number+1);
        end;
        NewLine;
      end;
    finally
      El3DList.Free;
    end;
  end;
end;

procedure TSutraInputWriter.WriteDataSet2A;
var
  SIMULA: AnsiString;
begin
  WriteCommentLine('Data set 2A');
  case FOptions.TransportChoice of
    tcSolute, tcSoluteHead:
      SIMULA := '''SUTRA VERSION 2.2 SOLUTE TRANSPORT''';
    tcEnergy:
      SIMULA := '''SUTRA VERSION 2.2 ENERGY TRANSPORT''';
  else
    Assert(False);
  end;
  WriteString(SIMULA);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet2B;
var
  MSHSTR: string;
begin
  WriteCommentLine('Data set 2B');
  case Model.SutraMesh.MeshType of
    mt2D, mtProfile:
      begin
        MSHSTR := '''2D IRREGULAR''';
      end;
    mt3D:
      begin
        MSHSTR := '''3D IRREGULAR''';
      end;
  else
    Assert(False);
  end;
  WriteString(MSHSTR);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet3;
var
  NN: Integer;
  NE: Integer;
  NPBC: Integer;
  NUBC: Integer;
  NSOP: Integer;
  NSOU: Integer;
begin
  WriteCommentLine('Data set 3');
  NN := 0;
  NE := 0;
  case FMesh.MeshType of
    mt2D, mtProfile:
      begin
        NN := FMesh.Mesh2D.Nodes.Count;
        NE := FMesh.Mesh2D.Elements.Count;
      end;
    mt3D:
      begin
        NN := FMesh.ActiveNodeCount;
        NE := FMesh.ActiveElementCount;
      end;
  end;
  NPBC := FSpecifiedPressureNodes.Count;
  NUBC := FSpecifiedTempConcNodes.Count;
  NSOP := FFluidSourceNodes.Count;
  NSOU := FMassEnergySourceNodes.Count;

  WriteInteger(NN);
  WriteInteger(NE);
  WriteInteger(NPBC);
  WriteInteger(NUBC);
  WriteInteger(NSOP);
  WriteInteger(NSOU);
  WriteInteger(FNOBS);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet4;
var
  CUNSAT: AnsiString;
  CSSFLO: AnsiString;
  CSSTRA: AnsiString;
  CREAD: AnsiString;
  ISTORE: integer;
begin
  WriteCommentLine('Data set 4');
  case FOptions.SaturationChoice of
    scSaturated: CUNSAT := '''SATURATED'' ';
    scUnsaturated: CUNSAT := '''UNSATURATED'' ';
    else Assert(False);
  end;

  case FOptions.SimulationType of
    stSteadyFlowSteadyTransport:
      begin
        CSSFLO := '''STEADY FLOW'' ';
        CSSTRA := '''STEADY TRANSPORT'' ';
      end;
    stSteadyFlowTransientTransport:
      begin
        CSSFLO := '''STEADY FLOW'' ';
        CSSTRA := '''TRANSIENT TRANSPORT'' ';
      end;
    stTransientFlowTransientTransport:
      begin
        CSSFLO := '''TRANSIENT FLOW'' ';
        CSSTRA := '''TRANSIENT TRANSPORT'' ';
      end;
    else
      Assert(False);
  end;

  case FOptions.StartType of
    stCold: CREAD := '''COLD'' ';
    stWarm: CREAD := '''WARM'' ';
  end;

  ISTORE := FOptions.RestartFrequency;

  WriteString(CUNSAT);
  WriteString(CSSFLO);
  WriteString(CSSTRA);
  WriteString(CREAD);
  WriteInteger(ISTORE);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet5;
var
  UP: double;
  GNUP: double;
  GNUU: Double;
begin
  WriteCommentLine('Data set 5');
  UP := FOptions.FractionalUpstreamWeight;
  GNUP := FOptions.PressureFactor;
  GNUU := FOptions.UFactor;
  WriteFloat(UP);
  WriteFloat(GNUP);
  WriteFloat(GNUU);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet6;
var
//  DS6_FileName: string;
//  StringList: TStringList;
  Index: Integer;
begin
  WriteCommentLine('Data set 6');
//  DS6_FileName := ChangeFileExt(FFileName, '.6');
//  Assert(FileExists(DS6_FileName));
//  StringList := TStringList.Create;
//  try
//    StringList.LoadFromFile(DS6_FileName);
    for Index := 0 to FSchedules.Count - 1 do
    begin
      WriteString(FSchedules[Index]);
      NewLine;
    end;
//  finally
//    StringList.Free;
//  end;
//  DS6_FileName := ''''+ DS6_FileName + '''';
//  WriteString('@INSERT 52 ');
//  WriteString(DS6_FileName);
//  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet7A;
var
  ITRMAX: Integer;
  RPMAX: Double;
  RUMAX: Double;
begin
  WriteCommentLine('Data set 7A');
  ITRMAX := FOptions.MaxIterations;
  WriteInteger(ITRMAX);

  if ITRMAX <> 1 then
  begin
    RPMAX := FOptions.NonLinPressureCriterion;
    RUMAX := FOptions.UCriterion;
    WriteFloat(RPMAX);
    WriteFloat(RUMAX);
  end;

  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet7B;
var
  CSOLVP: AnsiString;
  ITRMXP: Integer;
  TOLP: Double;
begin
  WriteCommentLine('Data set 7B');
  case FOptions.PresSolutionMethod of
    psmDirect: CSOLVP := '''DIRECT'' ';
    pcmCG: CSOLVP := '''CG'' ';
    psmGMRES: CSOLVP := '''GMRES'' ';
    psmOthomin: CSOLVP := '''ORTHOMIN'' ';
  end;
  WriteString(CSOLVP);

  if FOptions.PresSolutionMethod <> psmDirect then
  begin
    ITRMXP := FOptions.MaxPressureIterations;
    TOLP := FOptions.PressureCriterion;
    WriteInteger(ITRMXP);
    WriteFloat(TOLP);
  end;
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet7C;
var
  CSOLVU: AnsiString;
  ITRMXU: Integer;
  TOLU: Double;
begin
  WriteCommentLine('Data set 7C');
  case FOptions.USolutionMethod of
    usmDirect: CSOLVU := '''DIRECT'' ';
    usmGMRES: CSOLVU := '''GMRES'' ';
    usmOthomin: CSOLVU := '''ORTHOMIN'' ';
  end;
  WriteString(CSOLVU);

  if FOptions.USolutionMethod <> usmDirect then
  begin
    ITRMXU := FOptions.MaxTransportIterations;
    TOLU := FOptions.TransportCriterion;
    WriteInteger(ITRMXU);
    WriteFloat(TOLU);
  end;
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet8A;
var
  NPRINT: integer;
  CNODAL: AnsiString;
  CELMNT: AnsiString;
  CINCID: AnsiString;
  CPANDS: AnsiString;
  CVEL: AnsiString;
  CCORT: AnsiString;
  CBUDG: AnsiString;
  CSCRN: AnsiString;
  CPAUSE: AnsiString;
begin
  WriteCommentLine('Data set 8A');
  NPRINT := FOutputControl.ListingPrintFrequency;
  if not (sloNPrint in FOutputControl.ListingOptions) then
  begin
    NPRINT := -NPRINT;
  end;

  if sloCNodal in FOutputControl.ListingOptions then
  begin
    CNODAL := ' ''Y'' ';
  end
  else
  begin
    CNODAL := ' ''N'' ';
  end;

  if sloCElment in FOutputControl.ListingOptions then
  begin
    CELMNT := ' ''Y'' ';
  end
  else
  begin
    CELMNT := ' ''N'' ';
  end;

  if sloCIncid in FOutputControl.ListingOptions then
  begin
    CINCID := ' ''Y'' ';
  end
  else
  begin
    CINCID := ' ''N'' ';
  end;

  if sloCPandS in FOutputControl.ListingOptions then
  begin
    CPANDS := ' ''Y'' ';
  end
  else
  begin
    CPANDS := ' ''N'' ';
  end;

  if sloCVel in FOutputControl.ListingOptions then
  begin
    CVEL := ' ''Y'' ';
  end
  else
  begin
    CVEL := ' ''N'' ';
  end;

  if sloCCorT in FOutputControl.ListingOptions then
  begin
    CCORT := ' ''Y'' ';
  end
  else
  begin
    CCORT := ' ''N'' ';
  end;

  if sloCBudg in FOutputControl.ListingOptions then
  begin
    CBUDG := ' ''Y'' ';
  end
  else
  begin
    CBUDG := ' ''N'' ';
  end;

  if sloCScrn in FOutputControl.ListingOptions then
  begin
    CSCRN := ' ''Y'' ';
  end
  else
  begin
    CSCRN := ' ''N'' ';
  end;

  if sloCPause in FOutputControl.ListingOptions then
  begin
    CPAUSE := ' ''Y'' ';
  end
  else
  begin
    CPAUSE := ' ''N'' ';
  end;
  WriteInteger(NPRINT);
  WriteString(CNODAL);
  WriteString(CELMNT);
  WriteString(CINCID);
  WriteString(CPANDS);
  WriteString(CVEL);
  WriteString(CCORT);
  WriteString(CBUDG);
  WriteString(CSCRN);
  WriteString(CPAUSE);
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet8B;
var
  NCOLPR: integer;
begin
  WriteCommentLine('Data set 8B');
  NCOLPR := FOutputControl.NE_PrintFrequency;
  if not (neoPrintFirst in FOutputControl.NodeElementOptions) then
  begin
    NCOLPR := -NCOLPR;
  end;
  WriteInteger(NCOLPR);
  if neoNumber in FOutputControl.NodeElementOptions then
  begin
    WriteString(' ''N'' ');
  end;
  if neoCoordinates in FOutputControl.NodeElementOptions then
  begin
    WriteString(' ''X'' ''Y'' ');
    if (Model.SutraMesh.MeshType = mt3D) then
    begin
      WriteString('''Z'' ');
    end;
  end;
  if neoPressure in FOutputControl.NodeElementOptions then
  begin
    WriteString(' ''P'' ');
  end;
  if neoU in FOutputControl.NodeElementOptions then
  begin
    WriteString(' ''U'' ');
  end;
  if neoSaturation in FOutputControl.NodeElementOptions then
  begin
    WriteString(' ''S'' ');
  end;
  WriteString(' ''-''');
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet8C;
var
  LCOLPR: integer;
begin
  WriteCommentLine('Data set 8C');
  LCOLPR := FOutputControl.NE_PrintFrequency;
//  if not (neoPrintFirst in FOutputControl.NodeElementOptions) then
//  begin
//    LCOLPR := -LCOLPR;
//  end;
  WriteInteger(LCOLPR);
  if (neoNumber in FOutputControl.NodeElementOptions) then
  begin
    WriteString(' ''E'' ');
  end;
  if neoCoordinates in FOutputControl.NodeElementOptions then
  begin
    WriteString(' ''X'' ''Y'' ');
    if (Model.SutraMesh.MeshType = mt3D) then
    begin
      WriteString('''Z'' ');
    end;
  end;
  if neoVelocities in FOutputControl.NodeElementOptions then
  begin
    WriteString(' ''VX'' ''VY'' ');
    if (Model.SutraMesh.MeshType = mt3D) then
    begin
      WriteString('''VZ'' ');
    end;
  end;
  WriteString(' ''-''');
  NewLine;
end;

procedure TSutraInputWriter.WriteDataSet8D;
var
//  DS8D_FileName: string;
//  StringList: TStringList;
  Index: Integer;
begin
  if FNOBS > 0 then
  begin
    WriteCommentLine('Data set 8D');
//    DS8D_FileName := ChangeFileExt(FFileName, '.8d');
//    Assert(FileExists(DS8D_FileName));
//    StringList := TStringList.Create;
//    try
//      StringList.LoadFromFile(DS8D_FileName);
      for Index := 0 to FObservations.Count - 1 do
      begin
        WriteString(FObservations[Index]);
        NewLine;
      end;
//    finally
//      StringList.Free;
//    end;

//    DS8D_FileName := ''''+ DS8D_FileName + '''';
//    WriteString('@INSERT 53 ');
//    WriteString(DS8D_FileName);
//    NewLine;
  end;
end;

procedure TSutraInputWriter.WriteDataSet8E;
var
  NBCFPR: Integer;
  NBCSPR: Integer;
  NBCPPR: Integer;
  NBCUPR: Integer;
  CINACT: AnsiString;
begin
  WriteCommentLine('Data set 8E');
  NBCFPR := FOutputControl.FluidSourcePrintFrequency;
  NBCSPR := FOutputControl.SoluteEnergySourcePrintFrequency;
  NBCPPR := FOutputControl.SpecifiedPressurePrintFrequency;
  NBCUPR := FOutputControl.SpecifiedConcTempPrintFrequency;
  if FOutputControl.ListAll then
  begin
    CINACT := ' ''Y''';
  end
  else
  begin
    CINACT := ' ''N''';
  end;
  WriteInteger(NBCFPR);
  WriteInteger(NBCSPR);
  WriteInteger(NBCPPR);
  WriteInteger(NBCUPR);
  WriteString(CINACT);
  NewLine;
end;

procedure TSutraInputWriter.WriteFile(FileName: string; FluidSourceNodes,
  MassEnergySourceNodes, SpecifiedPressureNodes,
  SpecifiedTempConcNodes: IBoundaryNodes; NOBS: integer;
  Schedules, Observations: TStringList);
begin

  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrMaxPermMinPerm);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrMaxKMinK);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrMaxPermMidPerm);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrMaxKMidK);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrMidPermMinPerm);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrMidKMinK);


    FFileName := ChangeFileExt(FileName, '.inp');
    FSchedules := Schedules;
    FObservations := Observations;

    FFluidSourceNodes := FluidSourceNodes;
    FMassEnergySourceNodes := MassEnergySourceNodes;
    FSpecifiedPressureNodes := SpecifiedPressureNodes;
    FSpecifiedTempConcNodes := SpecifiedTempConcNodes;
    FNOBS := NOBS;

    OpenFile(FFileName);
    try
      WriteDataSet0;
      WriteDataSet1;
      WriteDataSet2A;
      WriteDataSet2B;
      WriteDataSet3;
      WriteDataSet4;
      WriteDataSet5;
      WriteDataSet6;
      WriteDataSet7A;
      WriteDataSet7B;
      WriteDataSet7C;
      WriteDataSet8A;
      WriteDataSet8B;
      WriteDataSet8C;
      WriteDataSet8D;
      WriteDataSet8E;
      WriteDataSet9;
      WriteDataSet10;
      WriteDataSet11;
      WriteDataSet12;
      WriteDataSet13;
      WriteDataSet14A;
      WriteDataSet14B;
      WriteDataSet15A;
      WriteDataSet15B;
      WriteDataSet17;
      WriteDataSet18;
      WriteDataSet19;
      WriteDataSet20;
      WriteDataSet22;
      SutraFileWriter.AddFile(sftInp, FFileName);
    finally
      CloseFile;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

class function TSutraInputWriter.Extension: string;
begin
  Assert(False);
end;

procedure TSutraInputWriter.WriteDataSet0;
begin
  WriteCommentLine(File_Comment('Main SUTRA input file'));
end;

end.
