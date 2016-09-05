unit ModflowHFB_WriterUnit;

interface

uses SysUtils, Classes, Contnrs, PhastModelUnit, CustomModflowWriterUnit,
  ScreenObjectUnit, ModflowPackageSelectionUnit, ModflowParameterUnit,
  EdgeDisplayUnit, GoPhastTypes;

type
  TModflowHfb_Writer = class;

  TBarrier = class(TCustomModflowGridEdgeFeature)
  protected
    function GetRealAnnotation(Index: integer): string; override;
    function GetRealValue(Index: integer): double; override;
  public
    Parameter: TModflowSteadyParameter;
    HydraulicConductivity: double;
    Thickness: double;
    HydraulicConductivityAnnotation: string;
    ThicknessAnnotation: string;
    Function LocationSame(ABarrier: TBarrier): boolean;
    procedure WriteBarrier(Writer: TModflowHfb_Writer; const Comment: string);
  end;

  TParamList = class(TObject)
  private
    FScreenObjectList: TList;
    FBarrierList: TList;
    FParam: TModflowSteadyParameter;
    function GetScreenObjectCount: integer;
    function GetScreenObject(Index: integer): TScreenObject;
    function GetBarrier(Index: integer): TBarrier;
    function GetBarrierCount: integer;
  public
    procedure AddScreenObject(ScreenObject: TScreenObject);
    Constructor Create(Param: TModflowSteadyParameter);
    Destructor Destroy; override;
    property ScreenObjectCount: integer read GetScreenObjectCount;
    property ScreenObjects[Index: integer]: TScreenObject
      read GetScreenObject; default;
    property Parameter: TModflowSteadyParameter read FParam;
    procedure AddBarrier(Barrier: TBarrier);
    property BarrierCount: integer read GetBarrierCount;
    property Barriers[Index: integer]: TBarrier read GetBarrier;
  end;

  TModflowHfb_Writer = class(TCustomPackageWriter)
  private
    NPHFB: integer;
    FParameterScreenObjectList: TStringList;
    procedure Evaluate;
    {@name fills @link(FParameterScreenObjectList) with the names
    of the HFB parameters except for the first position which is set to ''.
    The Objects property of @link(FParameterScreenObjectList) is filled
    with a newly created @link(TParamList) that contains
    all the @link(TScreenObject)s that are associated with that parameter.
    @link(TScreenObject)s that are not associated with any parameter are placed
    in the @link(TParamList) in the first position.  }
    procedure FillParameterScreenObjectList;
    {@name frees all the @link(TParamList) in FParameterScreenObjectList
    and then clear it. }
    procedure ClearParameterScreenObjectList;
    procedure WriteDataSet1;
    procedure WriteDataSets2and3;
    procedure WriteDataSet4;
    procedure WriteDataSet5;
    procedure WriteDataSet6;
  protected
    class function Extension: string; override;
    function Package: TModflowPackageSelection; override;
  public
    Constructor Create(Model: TCustomModel; EvaluationType: TEvaluationType); override;
    Destructor Destroy; override;
    procedure WriteFile(const AFileName: string);
    procedure UpdateDisplay;
  end;


implementation

uses Math, RbwParser, ModflowUnitNumbers, ModflowHfbUnit, OrderedCollectionUnit,
  frmErrorsAndWarningsUnit, ModflowGridUnit, GIS_Functions, 
  frmProgressUnit, frmFormulaErrorsUnit, Forms;

resourcestring
  StrInTheHFBPackage = 'In the HFB package, one or more objects do not defin' +
  'e any barriers.';
  StrSIsSupposedToDe = '%s is supposed to define a flow barrier but does not' +
  '.';
  StrInTheHFBPackage1 = 'In the HFB package, a parameter has been used withou' +
  't being defined';
  StrIn0sTheHFBPara = 'In %0:s the HFB parameter has been specified as %1:s ' +
  'but no such parameter has been defined.';
  StrNoDefinedBoundarie = 'No defined boundaries for an HFB parameter';
  StrForTheParameterS = 'For the parameter %s, there are no objects that def' +
  'ine the location of an HFB barrier';
  StrHydraulicConductiv = '(hydraulic conductivity for the HFB package)';
  StrThicknessForTheH = '(thickness for the HFB package)';
  StrEvaluatingHFBPacka = 'Evaluating HFB Package data.';
  StrWritingHFB6Package = 'Writing HFB6 Package input.';
  StrWritingDataSet0 = '  Writing Data Set 0.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
//  StrWritingDataSets2and3 = '  Writing Data Sets 2 and 3.';
//  StrWritingDataSet4 = '  Writing Data Set 4.';
//  StrWritingDataSet5 = '  Writing Data Set 5.';
//  StrWritingDataSet6 = '  Writing Data Set 6.';
  Str0sIn1s = '%0:s in %1:s.';
  StrHFBThicknessOrHyd = 'HFB thickness or hydraulic conductivity less than ' +
  'or equal to zero';
  StrLayer0dRow11 = 'Layer %0:d, Row1 %1:d, Col1 %2:d, Row2: %3:d, Col2 %4:d' +
  '.';

{ TModflowHfb_Writer }

constructor TModflowHfb_Writer.Create(Model: TCustomModel; EvaluationType: TEvaluationType);
begin
  inherited;
  FParameterScreenObjectList:= TStringList.Create;
end;

destructor TModflowHfb_Writer.Destroy;
begin
  ClearParameterScreenObjectList;
  FParameterScreenObjectList.Free;
  inherited;
end;

procedure TModflowHfb_Writer.Evaluate;
var
  ParmIndex: integer;
  ScreenObjectList: TParamList;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  SegmentIndex: integer;
  SegmentList: TList;
  PriorSection: integer;
  ASegment: TCellElementSegment;
  PriorCount: Integer;
  Compiler: TRbwParser;
  DataToCompile: TModflowDataObject;
  DataSetFunction: string;
  HydraulicConductivityExpression: TExpression;
  ThicknessExpression: TExpression;
  PriorSegments: TList;
  SubsequentSegments: TList;
  HydCondComment: string;
  ThicknessComment: string;
  procedure HandleSection;
  var
    Segment: TCellElementSegment;
    SegmentIndex: Integer;
    MinX, MinY, MaxX, MaxY: double;
    ColumnCenter: double;
    RowCenter: double;
    Grid: TModflowGrid;
    MidCellX, MidCellY: double;
    CrossRow, CrossColumn: integer;
    Barrier: TBarrier;
    Angle: double;
    Start: integer;
    procedure AssignValues;
    var
      Formula: string;
    begin
      UpdateCurrentScreenObject(ScreenObject);
      UpdateCurrentSegment(Segment);
      UpdateCurrentSection(Segment.SectionIndex);
      UpdateGlobalLocations(Segment.Col, Segment.Row, Segment.Layer, eaBlocks,
        Model);

      try
        HydraulicConductivityExpression.Evaluate;
      except on E: ERbwParserError do
        begin
          frmFormulaErrors.AddFormulaError(ScreenObject.Name,
            StrHydraulicConductiv,
            ScreenObject.ModflowHfbBoundary.HydraulicConductivityFormula,
            E.Message);

          ScreenObject.ModflowHfbBoundary.HydraulicConductivityFormula := '0.';
          Formula := ScreenObject.ModflowHfbBoundary.HydraulicConductivityFormula;
          Compiler.Compile(Formula);
          HydraulicConductivityExpression := Compiler.CurrentExpression;
          HydraulicConductivityExpression.Evaluate;
        end;
      end;
      Barrier.HydraulicConductivity := HydraulicConductivityExpression.DoubleResult;
      Barrier.HydraulicConductivityAnnotation := HydCondComment;

      try
        ThicknessExpression.Evaluate;
      except on E: ERbwParserError do
        begin
          frmFormulaErrors.AddFormulaError(ScreenObject.Name,
            StrThicknessForTheH,
            ScreenObject.ModflowHfbBoundary.ThicknessFormula,
            E.Message);

          ScreenObject.ModflowHfbBoundary.ThicknessFormula := '0.';
          Formula := ScreenObject.ModflowHfbBoundary.ThicknessFormula;
          Compiler.Compile(Formula);
          ThicknessExpression := Compiler.CurrentExpression;
          ThicknessExpression.Evaluate;
        end;
      end;
      Barrier.Thickness := ThicknessExpression.DoubleResult;
      Barrier.ThicknessAnnotation := ThicknessComment;
    end;
    function PreviousBarrierExists: boolean;
    var
      Index: Integer;
      AnotherBarrier: TBarrier;
    begin
      result := False;
      for Index := ScreenObjectList.BarrierCount - 1 downto Start do
      begin
        AnotherBarrier :=ScreenObjectList.Barriers[Index];
        result := Barrier.LocationSame(AnotherBarrier);
        if result then Exit;
      end;
    end;
  begin
    Start := ScreenObjectList.BarrierCount;
    Grid := Model.ModflowGrid;
    for SegmentIndex := 0 to SegmentList.Count - 1 do
    begin
      Segment := SegmentList[SegmentIndex];
      if Model.IsLayerSimulated(Segment.Layer) then
      begin
        MinX := Min(Segment.X1, Segment.X2);
        MaxX := Max(Segment.X1, Segment.X2);
        MinY := Min(Segment.Y1, Segment.Y2);
        MaxY := Max(Segment.Y1, Segment.Y2);
        ColumnCenter := Grid.ColumnCenter(Segment.Col);
        RowCenter := Grid.RowCenter(Segment.Row);
        if (MinX <= ColumnCenter) and (MaxX > ColumnCenter) then
        begin
          MidCellY := (ColumnCenter-Segment.X1)/(Segment.X2-Segment.X1)
            *(Segment.Y2-Segment.Y1) + Segment.Y1;
          if MidCellY > RowCenter then
          begin
            CrossRow := Segment.Row -1;
          end
          else
          begin
            CrossRow := Segment.Row +1;
          end;
          if (CrossRow >=0) and (CrossRow < Grid.RowCount) then
          begin
            Barrier := TBarrier.Create(Model);
            Barrier.FCol1 := Segment.Col;
            Barrier.FCol2 := Segment.Col;
            Barrier.FRow1 := Segment.Row;
            Barrier.FRow2 := CrossRow;
            Barrier.FLayer := Segment.Layer;
            Barrier.Parameter := ScreenObjectList.Parameter;
            if PreviousBarrierExists then
            begin
              Barrier.Free;
            end
            else
            begin
              ScreenObjectList.AddBarrier(Barrier);
              AssignValues;
              if ScreenObject.ModflowHfbBoundary.AdjustmentMethod <> amNone then
              begin
                Angle := ArcTan2(Segment.Y1-Segment.Y2,Segment.X1-Segment.X2);
                case ScreenObject.ModflowHfbBoundary.AdjustmentMethod of
                  amNone: Assert(False);
                  amAllEdges: Barrier.HydraulicConductivity :=
                    Barrier.HydraulicConductivity * Abs(Cos(Angle));
                  amNearlyParallel:
                    begin
                      While Angle > Pi/2 do
                      begin
                        Angle := Angle - Pi;
                      end;
                      While Angle < -Pi/2 do
                      begin
                        Angle := Angle + Pi;
                      end;
                      if (Angle > Pi/4) or (Angle < -Pi/4) then
                      begin
                        Barrier.HydraulicConductivity := 0;
                      end
                      else
                      begin
                        Barrier.HydraulicConductivity :=
                          Barrier.HydraulicConductivity/Abs(Cos(Angle));
                      end;
                    end;
                  else Assert(False);
                end;
              end;
            end;
          end;
        end;
        if (MinY <= RowCenter) and (MaxY > RowCenter) then
        begin
          MidCellX := (RowCenter-Segment.Y1)/(Segment.Y2-Segment.Y1)
            *(Segment.X2-Segment.X1) + Segment.X1;
          if MidCellX > ColumnCenter then
          begin
            CrossColumn := Segment.Col +1;
          end
          else
          begin
            CrossColumn := Segment.Col -1;
          end;
          if (CrossColumn >=0) and (CrossColumn < Grid.ColumnCount) then
          begin
            Barrier := TBarrier.Create(Model);
            Barrier.FCol1 := Segment.Col;
            Barrier.FCol2 := CrossColumn;
            Barrier.FRow1 := Segment.Row;
            Barrier.FRow2 := Segment.Row;
            Barrier.FLayer := Segment.Layer;
            Barrier.Parameter := ScreenObjectList.Parameter;
            if PreviousBarrierExists then
            begin
              Barrier.Free;
            end
            else
            begin
              ScreenObjectList.AddBarrier(Barrier);
              AssignValues;
              if ScreenObject.ModflowHfbBoundary.AdjustmentMethod <> amNone then
              begin
                Angle := ArcTan2(Segment.X1-Segment.X2,Segment.Y1-Segment.Y2);
                case ScreenObject.ModflowHfbBoundary.AdjustmentMethod of
                  amNone: Assert(False);
                  amAllEdges: Barrier.HydraulicConductivity :=
                    Barrier.HydraulicConductivity * Abs(Cos(Angle));
                  amNearlyParallel:
                    begin
                      While Angle > Pi/2 do
                      begin
                        Angle := Angle - Pi;
                      end;
                      While Angle < -Pi/2 do
                      begin
                        Angle := Angle + Pi;
                      end;
                      if (Angle > Pi/4) or (Angle < -Pi/4) then
                      begin
                        Barrier.HydraulicConductivity := 0;
                      end
                      else
                      begin
                        Barrier.HydraulicConductivity :=
                          Barrier.HydraulicConductivity/Abs(Cos(Angle));
                      end;
                    end;
                  else Assert(False);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrInTheHFBPackage);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrInTheHFBPackage1);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrNoDefinedBoundarie);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrHFBThicknessOrHyd);


    frmProgressMM.AddMessage(StrEvaluatingHFBPacka);
    FillParameterScreenObjectList;
    PriorSegments := TList.Create;
    SubsequentSegments := TList.Create;
    SegmentList := TList.Create;
    try
      for ParmIndex := 0 to FParameterScreenObjectList.Count - 1 do
      begin
        ScreenObjectList := FParameterScreenObjectList.Objects[ParmIndex] as TParamList;
        for ScreenObjectIndex := 0 to ScreenObjectList.ScreenObjectCount - 1 do
        begin
          PriorCount := ScreenObjectList.BarrierCount;
          ScreenObject := ScreenObjectList[ScreenObjectIndex];
          if ScreenObject.Deleted then
          begin
            Continue;
          end;
          if not ScreenObject.UsedModels.UsesModel(Model) then
          begin
            Continue;
          end;

          // Initialize HydraulicConductivityExpression and
          // ThicknessExpression.
          DataToCompile := TModflowDataObject.Create;
          try
            DataToCompile.Compiler := Model.GetCompiler(dsoTop, eaBlocks);
            DataToCompile.DataSetFunction :=
              ScreenObject.ModflowHfbBoundary.HydraulicConductivityFormula;
            DataToCompile.AlternateName := 'HFB Hydraulic Conductivity';
            DataToCompile.AlternateDataType := rdtDouble;
            (ScreenObject.Delegate as TModflowDelegate).InitializeExpression(
              Compiler, DataSetFunction, HydraulicConductivityExpression, nil,
               DataToCompile);
            HydCondComment := Format(Str0sIn1s,
              [ScreenObject.ModflowHfbBoundary.HydraulicConductivityFormula,
              ScreenObject.Name]);

            DataToCompile.DataSetFunction :=
              ScreenObject.ModflowHfbBoundary.ThicknessFormula;
            DataToCompile.AlternateName := 'HFB Thickness';
            (ScreenObject.Delegate as TModflowDelegate).InitializeExpression(
              Compiler, DataSetFunction, ThicknessExpression, nil, DataToCompile);
            ThicknessComment := Format(Str0sIn1s,
              [ScreenObject.ModflowHfbBoundary.ThicknessFormula,
              ScreenObject.Name]);
          finally
            DataToCompile.Free;
          end;
          PriorSection := -1;
          SegmentList.Clear;
          for SegmentIndex := 0 to ScreenObject.Segments[Model].Count - 1 do
          begin
            ASegment := ScreenObject.Segments[Model][SegmentIndex];
            if ASegment.SectionIndex <> PriorSection then
            begin
              HandleSection;
              PriorSection := ASegment.SectionIndex;
              SegmentList.Clear;
            end;
            SegmentList.Add(ASegment);
          end;
          HandleSection;
          if PriorCount = ScreenObjectList.BarrierCount then
          begin
            frmErrorsAndWarnings.AddWarning(Model, StrInTheHFBPackage,
              Format(StrSIsSupposedToDe, [ScreenObject.Name]), ScreenObject);
          end;
        end;
      end;
    finally
      SegmentList.Free;
      PriorSegments.Free;
      SubsequentSegments.Free;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

class function TModflowHfb_Writer.Extension: string;
begin
  result := '.hfb';
end;

function TModflowHfb_Writer.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.HfbPackage;
end;

procedure TModflowHfb_Writer.UpdateDisplay;
var
  ParmIndex: Integer;
  ScreenObjectList: TParamList;
  BarrierIndex: Integer;
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
begin
  Evaluate;
  if not frmProgressMM.ShouldContinue then
  begin
    Exit;
  end;
  Model.HfbDisplayer.Clear;
  for ParmIndex := 0 to FParameterScreenObjectList.Count - 1 do
  begin
    ScreenObjectList := FParameterScreenObjectList.Objects[ParmIndex]
      as TParamList;
    for BarrierIndex := 0 to ScreenObjectList.BarrierCount - 1 do
    begin
      Model.HfbDisplayer.Add(ScreenObjectList.Barriers[BarrierIndex]);
    end;
    for ScreenObjectIndex := 0 to ScreenObjectList.ScreenObjectCount - 1 do
    begin
      ScreenObject := ScreenObjectList.ScreenObjects[ScreenObjectIndex];
      ScreenObject.ModflowHfbBoundary.BoundaryObserver.UpToDate := True;
    end;
  end;
  Model.HfbDisplayer.UpToDate := True;
end;

procedure TModflowHfb_Writer.WriteDataSet1;
var
  MXFB: integer;
  NHFBNP: integer;
  Index: Integer;
  ParamList: TParamList;
begin
  NPHFB := 0;
  MXFB := 0;
  // Start at 1 rather than 0 because the list at 0 is for
  // barriers that are not associated with parameters.
  for Index := 1 to FParameterScreenObjectList.Count - 1 do
  begin
    ParamList := FParameterScreenObjectList.Objects[Index] as TParamList;
    if ParamList.BarrierCount > 0 then
    begin
      Inc(NPHFB);
      MXFB := MXFB + ParamList.BarrierCount;
    end;
  end;
  Assert(FParameterScreenObjectList.Count > 0);
  ParamList := FParameterScreenObjectList.Objects[0] as TParamList;
  NHFBNP := ParamList.BarrierCount;
  WriteInteger(NPHFB);
  WriteInteger(MXFB);
  WriteInteger(NHFBNP);
  WriteString(' # Data set 1: NPHFB MXFB NHFBNP');
  NewLine; 
end;

procedure TModflowHfb_Writer.WriteDataSet4;
const
  DataSet4Comment = ' # Data set 4: Layer IROW1 ICOL1 IROW2  ICOL2 Hydchr';
var
  ParamList: TParamList;
  BarrierIndex: Integer;
  Barrier: TBarrier;
begin
  ParamList := FParameterScreenObjectList.Objects[0] as TParamList;
  if ParamList.BarrierCount > 0 then
  begin
    // data set 4
    for BarrierIndex := 0 to ParamList.BarrierCount - 1 do
    begin
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      Barrier := ParamList.Barriers[BarrierIndex];
      Barrier.WriteBarrier(self, DataSet4Comment);
    end;
  end;
end;

procedure TModflowHfb_Writer.WriteDataSet5;
var
  NACTHFB: integer;
begin
  NACTHFB := NPHFB;
  WriteInteger(NACTHFB);
  WriteString(' # Data Set 5: NACTHFB');
  NewLine;
end;

procedure TModflowHfb_Writer.WriteDataSet6;
var
  Index: Integer;
  ParamList: TParamList;
begin
  // Start at 1 rather than 0 because the list at 0 is for
  // barriers that are not associated with parameters.
  for Index := 1 to FParameterScreenObjectList.Count - 1 do
  begin
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    ParamList := FParameterScreenObjectList.Objects[Index] as TParamList;
    if ParamList.BarrierCount > 0 then
    begin
      WriteString(ParamList.Parameter.ParameterName);
      WriteString(' # Data set 6: Pname');
      NewLine;
    end;
  end;
end;

procedure TModflowHfb_Writer.WriteDataSets2and3;
const
  DataSet3Comment = ' # Data set 3: Layer IROW1 ICOL1 IROW2  ICOL2 Factor';
var
  Index: Integer;
  ParamList: TParamList;
  BarrierIndex: Integer;
  Barrier: TBarrier;
begin
  // Start at 1 rather than 0 because the list at 0 is for
  // barriers that are not associated with parameters.
  for Index := 1 to FParameterScreenObjectList.Count - 1 do
  begin
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    ParamList := FParameterScreenObjectList.Objects[Index] as TParamList;
    if ParamList.BarrierCount > 0 then
    begin
      // data set 2
      WriteString(ParamList.Parameter.ParameterName + ' ');
      WriteString('HFB ');
      WriteFloat(ParamList.Parameter.Value);
      WriteInteger(ParamList.BarrierCount);
      WriteString(' # Data set 2: PARNAM PARTYP Parval NLST');
      NewLine;

      Model.WritePValAndTemplate(ParamList.Parameter.ParameterName,
        ParamList.Parameter.Value);

      // data set 3
      for BarrierIndex := 0 to ParamList.BarrierCount - 1 do
      begin
        Application.ProcessMessages;
        if not frmProgressMM.ShouldContinue then
        begin
          Exit;
        end;
        Barrier := ParamList.Barriers[BarrierIndex];
        Barrier.WriteBarrier(self, DataSet3Comment);
      end;
    end;
  end;
end;

procedure TModflowHfb_Writer.WriteFile(const AFileName: string);
var
  NameOfFile: string;
begin
  if not Package.IsSelected then
  begin
    Exit
  end;
  if Model.PackageGeneratedExternally(StrHFB) then
  begin
    Exit;
  end;
  NameOfFile := FileName(AFileName);
  WriteToNameFile(StrHFB, Model.UnitNumbers.UnitNumber(StrHFB), NameOfFile, foInput, Model);
  Evaluate;
  Application.ProcessMessages;
  if not frmProgressMM.ShouldContinue then
  begin
    Exit;
  end;
  OpenFile(FileName(AFileName));
  try
    frmProgressMM.AddMessage(StrWritingHFB6Package);
    frmProgressMM.AddMessage(StrWritingDataSet0);
    WriteDataSet0;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSet1);
    WriteDataSet1;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSets2and3);
    WriteDataSets2and3;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSet4);
    WriteDataSet4;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSet5);
    WriteDataSet5;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSet6);
    WriteDataSet6;
  finally
    CloseFile;
  end;
end;

procedure TModflowHfb_Writer.ClearParameterScreenObjectList;
var
  Index: Integer;
begin
  for Index := 0 to FParameterScreenObjectList.Count - 1 do
  begin
    FParameterScreenObjectList.Objects[Index].Free;
  end;
  FParameterScreenObjectList.Clear;
end;

procedure TModflowHfb_Writer.FillParameterScreenObjectList;
var
  Index: Integer;
  ScreenObject: TScreenObject;
  Boundary: THfbBoundary;
  ParamIndex: Integer;
  Param: TModflowSteadyParameter;
  List: TParamList;
begin
  ClearParameterScreenObjectList;
  FParameterScreenObjectList.AddObject('', TParamList.Create(nil));
  for ParamIndex := 0 to Model.ModflowSteadyParameters.Count-1 do
  begin
    Param := Model.ModflowSteadyParameters[ParamIndex];
    if Param.ParameterType = ptHFB then
    begin
      FParameterScreenObjectList.AddObject(Param.ParameterName,
        TParamList.Create(Param));
    end;
  end;
  for Index := 0 to Model.ScreenObjectCount - 1 do
  begin
    ScreenObject := Model.ScreenObjects[Index];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    Boundary := ScreenObject.ModflowHfbBoundary;
    if (Boundary <> nil) and Boundary.Used then
    begin
      ParamIndex := FParameterScreenObjectList.IndexOf(Boundary.ParameterName);
      if ParamIndex < 0 then
      begin
        frmErrorsAndWarnings.AddWarning(Model, StrInTheHFBPackage1,
          Format(StrIn0sTheHFBPara, [ScreenObject.Name, Boundary.ParameterName]),
          ScreenObject);
        ParamIndex := 0;
      end;
      List := FParameterScreenObjectList.Objects[ParamIndex] as TParamList;
      List.AddScreenObject(ScreenObject);
    end;
  end;
  for Index := 1 to FParameterScreenObjectList.Count - 1 do
  begin
    List := FParameterScreenObjectList.Objects[Index] as TParamList;
    if List.ScreenObjectCount = 0 then
    begin
      frmErrorsAndWarnings.AddWarning(Model, StrNoDefinedBoundarie,
        Format(StrForTheParameterS, [FParameterScreenObjectList[Index]]) );
    end;
  end;
end;

{ TParamList }

procedure TParamList.AddBarrier(Barrier: TBarrier);
begin
  FBarrierList.Add(Barrier);
end;

procedure TParamList.AddScreenObject(ScreenObject: TScreenObject);
begin
  FScreenObjectList.Add(ScreenObject);
end;

constructor TParamList.Create(Param: TModflowSteadyParameter);
begin
  FScreenObjectList:= TList.Create;
  FBarrierList := TObjectList.Create;
  FParam := Param;
end;

destructor TParamList.Destroy;
begin
  FBarrierList.Free;
  FScreenObjectList.Free;
  inherited;
end;

function TParamList.GetBarrier(Index: integer): TBarrier;
begin
  result := FBarrierList[Index];
end;

function TParamList.GetBarrierCount: integer;
begin
  result := FBarrierList.Count;
end;

function TParamList.GetScreenObject(Index: integer): TScreenObject;
begin
  result := FScreenObjectList[Index];
end;

function TParamList.GetScreenObjectCount: integer;
begin
  result := FScreenObjectList.Count;
end;

{ TBarrier }

function TBarrier.GetRealAnnotation(Index: integer): string;
begin
  result := '';
  case Index of
    0:
      begin
        result := HydraulicConductivityAnnotation;
        if Parameter <> nil then
        begin
          result := result + ' multiplied by the parameter value "'
            + FloatToStr(Parameter.Value) + '" assigned to the parameter "'
            + Parameter.ParameterName + '."';
        end;
      end;
    1:
      begin
        result := ThicknessAnnotation;
      end;
    2:
      begin
        result := 'Hydraulic Conductivity/Thickness';
      end;
    else
      Assert(False);
  end;
end;

function TBarrier.GetRealValue(Index: integer): double;
begin
  result := 0;
  case Index of
    0:
      begin
        result := HydraulicConductivity;
        if Parameter <> nil then
        begin
          result := result * Parameter.Value;
        end;
      end;
    1:
      begin
        result := Thickness;
      end;
    2:
      begin
        if Thickness = 0 then
        begin
          result := 0;
        end
        else
        begin
          result := GetRealValue(0)/Thickness;
        end;
      end;
    else
      Assert(False);
  end;
end;

function TBarrier.LocationSame(ABarrier: TBarrier): boolean;
begin
  result := (Layer = ABarrier.Layer) and (Parameter = ABarrier.Parameter);
  if not Result then
  begin
    Exit;
  end;
  result := ((Col2 = ABarrier.Col1) and (Col1 = ABarrier.Col2))
    or ((Col1 = ABarrier.Col1) and (Col2 = ABarrier.Col2));
  if not Result then
  begin
    Exit;
  end;
  result := ((Row2 = ABarrier.Row1) and (Row1 = ABarrier.Row2))
    or ((Row1 = ABarrier.Row1) and (Row2 = ABarrier.Row2));
end;

procedure TBarrier.WriteBarrier(Writer: TModflowHfb_Writer;
  const Comment: string);
var
  ModelLayer: integer;
begin
  ModelLayer := Writer.Model.
    DataSetLayerToModflowLayer(Layer);
  Writer.WriteInteger(ModelLayer);
  Writer.WriteInteger(Row1+1);
  Writer.WriteInteger(Col1+1);
  Writer.WriteInteger(Row2+1);
  Writer.WriteInteger(Col2+1);
  if Thickness = 0 then
  begin
    Writer.WriteFloat(0);
  end
  else
  begin
    Writer.WriteFloat(HydraulicConductivity/Thickness);
  end;
  if (Thickness <= 0) or (HydraulicConductivity <= 0) then
  begin
    frmErrorsAndWarnings.AddWarning(Writer.Model, StrHFBThicknessOrHyd,
      Format(StrLayer0dRow11, [Layer+1, Row1, Col1, Row2, Col2]));
  end;
  Writer.WriteString(Comment);
  Writer.NewLine;
end;

end.
