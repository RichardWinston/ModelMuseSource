unit SutraLakeWriterUnit;

interface

uses
  CustomModflowWriterUnit, System.Generics.Collections, PhastModelUnit,
  SutraOptionsUnit, System.SysUtils;

type
  TLakeNodeRecord = record
    InitialStage: double;
    InitialU: double;
    RechargeFraction: double;
    DischargeFraction: double;
  end;

  TLakeNode = class(TObject)
    NodeNumber: Integer;
    LakeProperties: TLakeNodeRecord;
  end;

  TLakeNodes = TObjectList<TLakeNode>;

  TSutraLakeWriter = class(TCustomFileWriter)
  private
    FLakeNodes: TLakeNodes;
    FLakeOptions: TSutraLakeOptions;
    procedure Evaluate;
    procedure WriteDataSet1;
    procedure WriteDataSet2;
    procedure WriteDataSet3;
    procedure WriteLakeAreaDataSet1a;
    procedure WriteLakeAreaDataSet1b;
  protected
    class function Extension: string; override;
  public
    Constructor Create(AModel: TCustomModel; EvaluationType: TEvaluationType); override;
    destructor Destroy; override;
    procedure WriteFile(const AFileName: string);
  end;

implementation

uses
  ScreenObjectUnit, SutraBoundariesUnit, GoPhastTypes, DataSetUnit, RbwParser,
  frmFormulaErrorsUnit, SutraMeshUnit, SutraFileWriterUnit;

resourcestring
  StrInitialLakeStage = 'Initial Lake Stage';
  StrInitialLakeConcent = 'Initial Lake Concentration or Temperature';

{ TSutraLakeWriter }

constructor TSutraLakeWriter.Create(AModel: TCustomModel;
  EvaluationType: TEvaluationType);
begin
  inherited;
  FLakeNodes := TLakeNodes.Create;
end;

destructor TSutraLakeWriter.Destroy;
begin
  FLakeNodes.Free;
  inherited;
end;

procedure TSutraLakeWriter.Evaluate;
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  ALake: TSutraLake;
  InitialStageFormula: string;
  InitalStageDataSet: TRealSparseDataSet;
  InitialU: TRealSparseDataSet;
  InitialUFormula: string;
  FractionRechargeDivertedFormula: string;
  FractionRechargeDiverted: TRealSparseDataSet;
  FractionDischargeDivertedFormula: string;
  FractionDischargeDiverted: TRealSparseDataSet;
  ColIndex: Integer;
  NodeNumber: Integer;
  LakeNodes: array of TLakeNode;
  LakeNodeRecord: TLakeNodeRecord;
  ALakeNode: TLakeNode;
begin
  SetLength(LakeNodes, Model.SutraMesh.Nodes.Count);
  for ScreenObjectIndex := 0 to Model.ScreenObjectCount - 1 do
  begin
    ScreenObject := Model.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    ALake := ScreenObject.SutraBoundaries.Lake;
    if ALake.IsUsed then
    begin
      InitialStageFormula := ALake.InitialStage;
      InitialUFormula := ALake.InitialConcentrationOrTemperature;
      FractionRechargeDivertedFormula := ALake.FractionRechargeDiverted;
      FractionDischargeDivertedFormula := ALake.FractionDischargeDiverted;

      InitalStageDataSet := TRealSparseDataSet.Create(Model);
      InitialU := TRealSparseDataSet.Create(Model);
      FractionRechargeDiverted := TRealSparseDataSet.Create(Model);
      FractionDischargeDiverted := TRealSparseDataSet.Create(Model);
      try
        InitalStageDataSet.DataType := rdtDouble;
        InitalStageDataSet.Name := ValidName('Initial_Stage');
        InitalStageDataSet.UseLgrEdgeCells := lctUse;
        InitalStageDataSet.EvaluatedAt := eaNodes;
        InitalStageDataSet.Orientation := dsoTop;
        Model.UpdateDataArrayDimensions(InitalStageDataSet);

        InitialU.DataType := rdtDouble;
        InitialU.Name := ValidName('Initial_U');
        InitialU.UseLgrEdgeCells := lctUse;
        InitialU.EvaluatedAt := eaNodes;
        InitialU.Orientation := dsoTop;
        Model.UpdateDataArrayDimensions(InitialU);

        FractionRechargeDiverted.DataType := rdtDouble;
        FractionRechargeDiverted.Name := ValidName('Fraction_Recharge_Diverted');
        FractionRechargeDiverted.UseLgrEdgeCells := lctUse;
        FractionRechargeDiverted.EvaluatedAt := eaNodes;
        FractionRechargeDiverted.Orientation := dsoTop;
        Model.UpdateDataArrayDimensions(FractionRechargeDiverted);

        FractionDischargeDiverted.DataType := rdtDouble;
        FractionDischargeDiverted.Name := ValidName('Fraction_Discharge_Diverted');
        FractionDischargeDiverted.UseLgrEdgeCells := lctUse;
        FractionDischargeDiverted.EvaluatedAt := eaNodes;
        FractionDischargeDiverted.Orientation := dsoTop;
        Model.UpdateDataArrayDimensions(FractionDischargeDiverted);

        try
          ScreenObject.AssignValuesToSutraDataSet(Model.SutraMesh, InitalStageDataSet,
            InitialStageFormula, Model);
        except on E: ErbwParserError do
          begin
            frmFormulaErrors.AddFormulaError(ScreenObject.Name, StrInitialLakeStage,
              InitialStageFormula, E.Message);
            InitialStageFormula := '0';
            ScreenObject.AssignValuesToSutraDataSet(Model.SutraMesh, InitalStageDataSet,
              InitialStageFormula, Model);
          end;
        end;

        try
          ScreenObject.AssignValuesToSutraDataSet(Model.SutraMesh, InitialU,
            InitialUFormula, Model);
        except on E: ErbwParserError do
          begin
            frmFormulaErrors.AddFormulaError(ScreenObject.Name, StrInitialLakeConcent,
              InitialUFormula, E.Message);
            InitialUFormula := '0';
            ScreenObject.AssignValuesToSutraDataSet(Model.SutraMesh, InitialU,
              InitialUFormula, Model);
          end;
        end;

        try
          ScreenObject.AssignValuesToSutraDataSet(Model.SutraMesh, FractionRechargeDiverted,
            FractionRechargeDivertedFormula, Model);
        except on E: ErbwParserError do
          begin
            frmFormulaErrors.AddFormulaError(ScreenObject.Name, StrInitialLakeConcent,
              FractionRechargeDivertedFormula, E.Message);
            FractionRechargeDivertedFormula := '0';
            ScreenObject.AssignValuesToSutraDataSet(Model.SutraMesh, FractionRechargeDiverted,
              FractionRechargeDivertedFormula, Model);
          end;
        end;

        try
          ScreenObject.AssignValuesToSutraDataSet(Model.SutraMesh, FractionDischargeDiverted,
            FractionDischargeDivertedFormula, Model);
        except on E: ErbwParserError do
          begin
            frmFormulaErrors.AddFormulaError(ScreenObject.Name, StrInitialLakeConcent,
              FractionDischargeDivertedFormula, E.Message);
            FractionDischargeDivertedFormula := '0';
            ScreenObject.AssignValuesToSutraDataSet(Model.SutraMesh, FractionDischargeDiverted,
              FractionDischargeDivertedFormula, Model);
          end;
        end;

        Assert(InitalStageDataSet.RowCount = 1);
        Assert(InitalStageDataSet.LayerCount = 1);
        for ColIndex := 0 to InitalStageDataSet.ColumnCount - 1 do
        begin
          if InitalStageDataSet.IsValue[0,0,ColIndex] then
          begin
            Assert(InitialU.IsValue[0,0,ColIndex]);
            Assert(FractionRechargeDiverted.IsValue[0,0,ColIndex]);
            Assert(FractionDischargeDiverted.IsValue[0,0,ColIndex]);

            NodeNumber := Model.SutraMesh.NodeArray[0,ColIndex].Number;

            LakeNodeRecord.InitialStage := InitalStageDataSet.RealData[0,0,ColIndex];
            LakeNodeRecord.InitialU := InitalStageDataSet.RealData[0,0,ColIndex];
            LakeNodeRecord.RechargeFraction := FractionRechargeDiverted.RealData[0,0,ColIndex];
            LakeNodeRecord.DischargeFraction := FractionDischargeDiverted.RealData[0,0,ColIndex];

            if LakeNodes[NodeNumber] = nil then
            begin
              ALakeNode := TLakeNode.Create;
              ALakeNode.NodeNumber := NodeNumber;
              FLakeNodes.Add(ALakeNode);
              LakeNodes[NodeNumber] := ALakeNode;
            end
            else
            begin
              ALakeNode := LakeNodes[NodeNumber];
            end;
            ALakeNode.LakeProperties := LakeNodeRecord;
          end;
        end;

        Model.DataArrayManager.CacheDataArrays;
        InitalStageDataSet.UpToDate := True;
        InitalStageDataSet.CacheData;

      finally
        InitalStageDataSet.Free;
        InitialU.Free;
        FractionRechargeDiverted.Free;
        FractionDischargeDiverted.Free;
      end;
    end;
  end;
end;

class function TSutraLakeWriter.Extension: string;
begin
  result := '.lkin';
end;

procedure TSutraLakeWriter.WriteDataSet1;
var
  ITLMAX: Integer;
  NPRLAK: Integer;
begin
  ITLMAX := FLakeOptions.MaxLakeIterations;
  NPRLAK := FLakeOptions.LakeOutputCycle;
  WriteInteger(ITLMAX);
  WriteInteger(NPRLAK);
  NewLine;
end;

procedure TSutraLakeWriter.WriteDataSet2;
var
  NLSPEC: Integer;
  FRROD: Double;
  FDROD: Double;
  VLIM: Double;
  RNOLK: Double;
begin
  NLSPEC := FLakeNodes.Count;
  FRROD := FLakeOptions.RechargeFraction;
  FDROD := FLakeOptions.DischargeFraction;
  VLIM := FLakeOptions.MinLakeVolume;
  RNOLK := FLakeOptions.SubmergedOutput;
  WriteInteger(NLSPEC);
  WriteFloat(FRROD);
  WriteFloat(FDROD);
  WriteFloat(VLIM);
  WriteFloat(RNOLK);
  NewLine;
end;

procedure TSutraLakeWriter.WriteDataSet3;
const
  CTYPE = 'NODE';
var
  NodeIndex: Integer;
  ALake: TLakeNode;
  ILON: Integer;
  STGI: Double;
  UWI: Double;
  FRRO: Double;
  FDRO: Double;
begin
  for NodeIndex := 0 to FLakeNodes.Count - 1 do
  begin
    ALake := FLakeNodes[NodeIndex];
    ILON := ALake.NodeNumber + 1;
    STGI := ALake.LakeProperties.InitialStage;
    UWI := ALake.LakeProperties.InitialU;
    FRRO := ALake.LakeProperties.RechargeFraction;
    FDRO := ALake.LakeProperties.DischargeFraction;
    WriteString(CTYPE);
    WriteInteger(ILON);
    WriteFloat(STGI);
    WriteFloat(UWI);
    WriteFloat(FRRO);
    WriteFloat(FDRO);
    NewLine;
  end;
end;

procedure TSutraLakeWriter.WriteFile(const AFileName: string);
var
  NameOfFile: string;
  LakeStageFile: string;
  LakeRestartFile: string;
begin
  if Model.ModelSelection <> msSutra30 then
  begin
    Exit;
  end;
  if Model.Mesh.MeshType <> mt3D then
  begin
    Exit;
  end;
  Evaluate;

  if FLakeNodes.Count = 0 then
  begin
    Exit;
  end;

  FLakeOptions := Model.SutraOptions.LakeOptions;

  NameOfFile := FileName(AFileName);
  OpenFile(NameOfFile);
  try
    WriteDataSet1;
    WriteDataSet2;
    WriteDataSet3;
  finally
    CloseFile;
  end;
  SutraFileWriter.AddFile(sftLkin, NameOfFile);

  NameOfFile := ChangeFileExt(AFileName, '.lkar');
  OpenFile(NameOfFile);
  try
    WriteLakeAreaDataSet1a;
    WriteLakeAreaDataSet1b;
  finally
    CloseFile;
  end;
  SutraFileWriter.AddFile(sftLkar, NameOfFile);

  LakeStageFile := ChangeFileExt(AFileName, '.lkst');
  SutraFileWriter.AddFile(sftLkst, LakeStageFile);

  LakeRestartFile := ChangeFileExt(AFileName, '.lkrs');
  SutraFileWriter.AddFile(sftLKrs, LakeRestartFile);
end;

procedure TSutraLakeWriter.WriteLakeAreaDataSet1a;
var
  NNLK: integer;
begin
  NNLK := FLakeNodes.Count;
  WriteString('LAKE');
  WriteInteger(NNLK);
  NewLine;
end;

procedure TSutraLakeWriter.WriteLakeAreaDataSet1b;
var
  NodeIndex: Integer;
  IL: Integer;
begin
  for NodeIndex := 0 to FLakeNodes.Count - 1 do
  begin
    IL := FLakeNodes[NodeIndex].NodeNumber + 1;
    WriteInteger(IL);
    NewLine;
  end;
  WriteInteger(0);
  NewLine;
end;

end.
