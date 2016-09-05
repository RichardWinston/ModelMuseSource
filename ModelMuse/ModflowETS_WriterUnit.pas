unit ModflowETS_WriterUnit;

interface

uses SysUtils, Classes, Contnrs, RbwParser, CustomModflowWriterUnit,
  ScreenObjectUnit, ModflowBoundaryUnit, ModflowPackageSelectionUnit,
  OrderedCollectionUnit, ModflowCellUnit, PhastModelUnit,
  ModflowBoundaryDisplayUnit, DataSetUnit;

Type
  TModflowETS_Writer = class(TCustomTransientArrayWriter)
  private
    NPETS: integer;
    NETSEG: integer;
    NETSOP: integer;
    FDepthSurface: TList;
    FPriorDepthFractionArray: TDataArray;
    FPriorRateFractionArray: TDataArray;
    FEtsPackage: TEtsPackageSelection;
    procedure WriteDataSet1;
    procedure WriteDataSets2And3;
    procedure WriteDataSets4To11;
    procedure WriteCells(CellList: TList; const DataSetIdentifier,
      VariableIdentifiers: string);
    procedure WriteEvapotranspirationSurface(CellList: TList);
    procedure WriteExtinctionDepth(CellList: TList);
    procedure WriteDepthFraction(CellList: TList; SegmentIndex: integer);
    procedure WriteRateFraction(CellList: TList; SegmentIndex: integer);
    procedure CheckDepthFraction(NewArray: TDataArray; SegmentIndex: Integer);
    procedure CheckRateFraction(NewArray: TDataArray; SegmentIndex: Integer);
  protected
    function CellType: TValueCellType; override;
    function Prefix: string; override;
    class function Extension: string; override;
    function GetBoundary(ScreenObject: TScreenObject): TModflowBoundary;
      override;
    function Package: TModflowPackageSelection; override;
    function ParameterType: TParameterType; override;
    procedure WriteStressPeriods(const VariableIdentifiers, DataSetIdentifier,
      DS5, D7PNameIname, D7PName: string); override;
    procedure Evaluate; override;
  public
    Constructor Create(Model: TCustomModel; EvaluationType: TEvaluationType); override;
    // @name destroys the current instance of @classname.
    Destructor Destroy; override;
    procedure WriteFile(const AFileName: string);
    // @name is used to update the display of transient data used to color the
    // grid.
    // @param(TimeLists TimeLists is a list of
    //   @link(TModflowBoundaryDisplayTimeList)s that are to be updated.
    //   The order of the @link(TModflowBoundaryDisplayTimeList)s in TimeLists
    //   is important. The position in the list must be same as the index
    //   value used to access @link(TValueCell.RealValue TValueCell.RealValue)
    //   and @link(TValueCell.RealAnnotation TValueCell.RealAnnotation).  The
    //   contents of TimeLists should be in the following order.
    //   @unorderedList(
    //       @item(Evapotranspiration Rate)
    //       @item(Evapotranspiration Surface)
    //       @item(Evapotranspiration Depth)
    //       @item(Depth Fraction 1)
    //       @item(Et Fraction 1)
    //       @item(Depth Fraction 2)
    //       @item(Et Fraction 2)
    //       @item(...)
    //       @item(Depth Fraction N)
    //       @item(Et Fraction N)
    //     )
    //   )
    // @param(ParameterIndicies The values included in ParameterIndicies
    //   indicate which @link(TModflowBoundaryDisplayTimeList)s in TimeLists
    //   are affected by MODFLOW parameters.)
    procedure UpdateDisplay(TimeLists: TModflowBoundListOfTimeLists);
  end;

implementation

uses ModflowUnitNumbers, ModflowTransientListParameterUnit,
  frmErrorsAndWarningsUnit, ModflowEtsUnit, GoPhastTypes, 
  frmProgressUnit, Forms;

{ TModflowETS_Writer }

resourcestring
//  ErrorRoot = 'One or more %s parameters have been eliminated '
//    + 'because there are no cells associated with them.';
  EtsSurfaceError = 'The ET Surface is undefined in the ETS package.';
  EtsSurfaceErrorMessage = 'No objects define the ET Surface in the ETS package.';
  EtsDepthError = 'The ET Depth is undefined in the ETS package.';
  EtsDepthErrorMessage = 'No objects define the ET Depth in the ETS package.';
  StrInTheETSRate = 'In the ETS package, rate fraction of each succeeding' +
  ' segment should be less than the rate fraction of the previous segment.  ' +
  'At the following locations, this does not occur.';
  StrSegment0dRow = 'Segment: %0:d; Row: %1:d; Column: %2:d';
  StrInTheETSDepth = 'In the ETS package, depth fraction of each succeeding ' +
  'segment should be greater than the depth fraction of the previous segment' +
  '.  At the following locations, this does not occur.';
  StrNoEvapotranspiratio = 'No evapotranspiration segments defined';
  StrTheEvapotranspirati = 'The Evapotranspiration Segments package is activ' +
  'e but no evapotranspiration segments have been defined for any stress per' +
  'iod.';
  StrWritingETSPackage = 'Writing ETS Package input.';
//  StrWritingDataSet0 = '  Writing Data Set 0.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
//  StrWritingDataSets2and3 = '  Writing Data Sets 2 and 3.';
  StrWritingDataSets4to11 = '  Writing Data Sets 4 to 11.';
  StrWritingStressP = '    Writing Stress Period %d';
  StrNoParametersHaveB = 'No parameters have been defined for the Evapotrans' +
  'piration Segments package for the following Stress periods.';

function TModflowETS_Writer.CellType: TValueCellType;
begin
  result := TEtsSurfDepth_Cell;
end;

constructor TModflowETS_Writer.Create(Model: TCustomModel; EvaluationType: TEvaluationType);
begin
  inherited;
  FDepthSurface := TObjectList.Create;
end;

destructor TModflowETS_Writer.Destroy;
begin
  FDepthSurface.Free;
  inherited;
end;

procedure TModflowETS_Writer.Evaluate;
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TEtsBoundary;
begin
  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrEvapotranspirationD_ETS);
  frmErrorsAndWarnings.BeginUpdate;
  try
    inherited Evaluate;
    for ScreenObjectIndex := 0 to Model.ScreenObjectCount - 1 do
    begin
      ScreenObject := Model.ScreenObjects[ScreenObjectIndex];
      if ScreenObject.Deleted then
      begin
        Continue;
      end;
      if not ScreenObject.UsedModels.UsesModel(Model) then
      begin
        Continue;
      end;
      Boundary := ScreenObject.ModflowEtsBoundary;
      if Boundary <> nil then
      begin
  //      if PhastModel.ModflowPackages.EtsPackage.TimeVaryingLayers then
        begin
          Boundary.GetEvapotranspirationLayerCells(FLayers, Model);
        end;
        Boundary.GetEvapotranspirationSurfaceDepthCells(FDepthSurface, Model);
        Boundary.EvapotranspirationLayers.ClearBoundaries(Model);
        Boundary.EtsSurfDepthCollection.ClearBoundaries(Model);
      end;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

class function TModflowETS_Writer.Extension: string;
begin
  result := '.ets';
end;

function TModflowETS_Writer.GetBoundary(
  ScreenObject: TScreenObject): TModflowBoundary;
begin
  result := ScreenObject.ModflowEtsBoundary;
end;

function TModflowETS_Writer.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.EtsPackage;
end;

function TModflowETS_Writer.ParameterType: TParameterType;
begin
  result := ptETS;
end;

function TModflowETS_Writer.Prefix: string;
begin
  result := 'ETS'
end;

procedure TModflowETS_Writer.UpdateDisplay(
  TimeLists: TModflowBoundListOfTimeLists);
var
  List: TValueCellList;
  ParameterValues: TList;
  ParametersUsed: TStringList;
  TimeIndex: Integer;
  DepthSurfaceCellList: TValueCellList;
  SegmentIndex: integer;
  NPETS, NETSEG: integer;
  EvapRateTimes: TModflowBoundaryDisplayTimeList;
  EvapRateArray: TModflowBoundaryDisplayDataArray;
  EvapotranspirationSurfaceTimes : TModflowBoundaryDisplayTimeList;
  EvapSurfArray: TModflowBoundaryDisplayDataArray;
  EvapotranspirationDepthTimes : TModflowBoundaryDisplayTimeList;
  EvapDepthArray: TModflowBoundaryDisplayDataArray;
  DepthFractionList: TList;
  EtFractionList: TList;
  ATimeList: TModflowBoundaryDisplayTimeList;
  AnArray: TModflowBoundaryDisplayDataArray;
  Index: integer;
  ParamDefArrays: TList;
  DefArrayList: TList;
  EvapotranspirationLayerTimes : TModflowBoundaryDisplayTimeList;
  EvapLayerArray: TModflowBoundaryDisplayDataArray;
  ErrorString: string;
const
  D7PNameIname = '';
  D7PName = '';
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveErrorGroup(Model, EtsSurfaceError);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, EtsDepthError);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrInTheETSRate);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrInTheETSDepth);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrNoEvapotranspiratio);



    if not Package.IsSelected then
    begin
      UpdateNotUsedDisplay(TimeLists);
      Exit;
    end;
    ParameterValues := TList.Create;
    try
      Evaluate;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      ClearTimeLists(Model);
      ParamDefArrays := TObjectList.Create;
      DepthFractionList := TList.Create;
      EtFractionList := TList.Create;
      try
        EvaluateParameterDefinitions(ParamDefArrays, StrOneOrMoreSParam, umAssign);
        NPETS := ParameterCount;
        NETSOP := Ord(Model.ModflowPackages.EtsPackage.LayerOption) + 1;
        NETSEG := Model.ModflowPackages.EtsPackage.SegmentCount;

        for SegmentIndex := 2 to NETSEG - 1 do
        begin
          ErrorString := 'In the ETS package, depth fraction of each succeeding '
          + 'segment should be greater than the depth fraction of the previous '
          + 'segment.  At the following locations in segment '
          + IntToStr(SegmentIndex) + ' this does not occur. (Row, Col)';
          frmErrorsAndWarnings.RemoveErrorGroup(Model, ErrorString);

          ErrorString := 'In the ETS package, rate fraction of each succeeding '
            + 'segment should be less than the rate fraction of the previous '
            + 'segment.  At the following locations in segment '
            + IntToStr(SegmentIndex) + ' this does not occur. (Row, Col)';
          frmErrorsAndWarnings.RemoveErrorGroup(Model, ErrorString);
        end;

        EvapRateTimes := TimeLists[0];
        EvapotranspirationSurfaceTimes := TimeLists[1];
        EvapotranspirationDepthTimes := TimeLists[2];
        EvapotranspirationLayerTimes := TimeLists[3];
        for TimeIndex := 4 to TimeLists.Count - 1 do
        begin
          if Odd(TimeIndex) then
          begin
            EtFractionList.Add(TimeLists[TimeIndex]);
          end
          else
          begin
            DepthFractionList.Add(TimeLists[TimeIndex]);
          end;
        end;

        if Values.Count = 0 then
        begin
          SetTimeListsUpToDate(TimeLists);
          Exit;
        end;
        for TimeIndex := 0 to Values.Count - 1 do
        begin
          EvapRateArray := EvapRateTimes[TimeIndex]
            as TModflowBoundaryDisplayDataArray;
          EvapSurfArray := EvapotranspirationSurfaceTimes[TimeIndex]
            as TModflowBoundaryDisplayDataArray;
          EvapDepthArray := EvapotranspirationDepthTimes[TimeIndex]
            as TModflowBoundaryDisplayDataArray;
          if EvapotranspirationLayerTimes = nil then
          begin
            EvapLayerArray := nil;
          end
          else
          begin
            EvapLayerArray := EvapotranspirationLayerTimes[TimeIndex]
              as TModflowBoundaryDisplayDataArray;
          end;

          ParametersUsed := TStringList.Create;
          try
            RetrieveParametersForStressPeriod(D7PNameIname, D7PName, TimeIndex,
              ParametersUsed, ParameterValues, True);
            List := Values[TimeIndex];
  //          List.CheckRestore;

            // data set 5
            if FDepthSurface.Count > 0 then
            begin
              DepthSurfaceCellList := FDepthSurface[TimeIndex];
  //            DepthSurfaceCellList.CheckRestore;
              AssignTransient2DArray(EvapSurfArray, 0, DepthSurfaceCellList, 0,
                rdtDouble, umAssign);
            end
            else
            begin
              DepthSurfaceCellList := nil;
              EvapSurfArray.UpToDate := True;
              frmErrorsAndWarnings.AddError(Model, EtsSurfaceError,
                EtsSurfaceErrorMessage);
            end;
            EvapSurfArray.CacheData;

            if NPETS = 0 then
            begin
              // data set 6
              AssignTransient2DArray(EvapRateArray, 0, List, 0, rdtDouble,
                umAssign);
            end
            else
            begin
              DefArrayList := ParamDefArrays[TimeIndex];
              UpdateTransient2DArray(EvapRateArray, DefArrayList);
            end;
            Model.AdjustDataArray(EvapRateArray);
            EvapRateArray.CacheData;

            // data set 8

            if DepthSurfaceCellList <> nil then
            begin
              AssignTransient2DArray(EvapDepthArray, 1, DepthSurfaceCellList, 0,
                rdtDouble, umAssign);
            end
            else
            begin
              EvapDepthArray.UpToDate := True;
              frmErrorsAndWarnings.AddError(Model, EtsDepthError,
                EtsDepthErrorMessage);
            end;
            EvapDepthArray.CacheData;

            if EvapLayerArray <> nil then
            begin
              if (Model.ModflowPackages.EtsPackage.
                LayerOption = loSpecified)
                and not Model.ModflowPackages.EtsPackage.
                TimeVaryingLayers and (ParameterCount > 0)  then
              begin
                RetrieveParametersForStressPeriod(D7PNameIname, D7PName, 0,
                  ParametersUsed, ParameterValues, True);
                List := Values[0];
              end;
              // data set 9
              UpdateLayerDisplay(List, ParameterValues, TimeIndex,
                EvapLayerArray);
            end;

            FPriorDepthFractionArray := nil;
            FPriorRateFractionArray := nil;
            if DepthSurfaceCellList <> nil then
            begin
              try
                for SegmentIndex := 1 to NETSEG - 1 do
                begin
                  // data set 10
                  ATimeList := DepthFractionList[SegmentIndex-1];
                  AnArray := ATimeList[TimeIndex] as TModflowBoundaryDisplayDataArray;
                  AssignTransient2DArray(AnArray, SegmentIndex*2,
                    DepthSurfaceCellList, 0, rdtDouble, umAssign);
                  CheckDepthFraction(AnArray, SegmentIndex);
                  FPriorDepthFractionArray := AnArray;

                  // data set 11
                  ATimeList := EtFractionList[SegmentIndex-1];
                  AnArray := ATimeList[TimeIndex]
                    as TModflowBoundaryDisplayDataArray;
                  AssignTransient2DArray(AnArray, SegmentIndex*2+1,
                    DepthSurfaceCellList, 0, rdtDouble, umAssign);
                  CheckRateFraction(AnArray, SegmentIndex);
                  FPriorRateFractionArray := AnArray;
                end;
              finally
                FPriorDepthFractionArray := nil;
                FPriorRateFractionArray := nil;
              end;
            end;
            List.Cache;
          finally
            ParametersUsed.Free;
          end;
        end;
        for Index := 0 to TimeLists.Count - 1 do
        begin
          ATimeList := TimeLists[Index];
          if ATimeList <> nil then
          begin
            ATimeList.SetUpToDate(True);
          end;
        end;
      finally
        DepthFractionList.Free;
        EtFractionList.Free;
        ParamDefArrays.Free;
      end;
    finally
      ParameterValues.Free;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

procedure TModflowETS_Writer.CheckRateFraction(NewArray: TDataArray;
  SegmentIndex: Integer);
var
  Error: string;
  PriorValue: Double;
  NewValue: Double;
  ColIndex: Integer;
  RowIndex: Integer;
//  ErrorRoot: string;
begin
  if FPriorRateFractionArray <> nil then
  begin
//    ErrorRoot := 'In the ETS package, rate fraction of each succeeding '
//      + 'segment should be less than the rate fraction of the previous '
//      + 'segment.  At the following locations in segment '
//      + IntToStr(SegmentIndex) + ' this does not occur. (Row, Col)';
//    ErrorRoot := Format(StrInTheETSPackage, [SegmentIndex]);
//    frmErrorsAndWarnings.RemoveErrorGroup(ErrorRoot);
    Assert(NewArray.UpToDate);
    for RowIndex := 0 to Model.ModflowGrid.RowCount - 1 do
    begin
      for ColIndex := 0 to Model.ModflowGrid.ColumnCount - 1 do
      begin
        NewValue := NewArray.RealData[0, RowIndex, ColIndex];
        PriorValue := FPriorRateFractionArray.RealData[0, RowIndex, ColIndex];
        if NewValue > PriorValue then
        begin
          Error := Format(StrSegment0dRow,
            [SegmentIndex, RowIndex + 1, ColIndex + 1]);
//
//          '('+ IntToStr(SegmentIndex)+ ', '
//            + IntToStr(RowIndex + 1) + ', '
//            + IntToStr(ColIndex + 1) + ')';
          frmErrorsAndWarnings.AddError(Model, StrInTheETSRate, Error);
        end;
      end;
    end;
  end;
end;

procedure TModflowETS_Writer.CheckDepthFraction(NewArray: TDataArray;
  SegmentIndex: Integer);
var
  RowIndex: Integer;
  ColIndex: Integer;
  NewValue: Double;
  PriorValue: Double;
  Error: string;
//  ErrorRoot: string;
begin
  if FPriorDepthFractionArray <> nil then
  begin
//    ErrorRoot := StrInTheETSDepth;
//    frmErrorsAndWarnings.RemoveErrorGroup(ErrorRoot);
    Assert(NewArray.UpToDate);
    for RowIndex := 0 to Model.ModflowGrid.RowCount - 1 do
    begin
      for ColIndex := 0 to Model.ModflowGrid.ColumnCount - 1 do
      begin
        NewValue := NewArray.RealData[0, RowIndex, ColIndex];
        PriorValue := FPriorDepthFractionArray.RealData[0, RowIndex, ColIndex];
        if NewValue < PriorValue then
        begin
          Error := Format(StrSegment0dRow,
            [SegmentIndex, RowIndex + 1, ColIndex + 1]);
//          Error := '(' + IntToStr(RowIndex + 1) + ', '
//            + IntToStr(ColIndex + 1) + ')';
          frmErrorsAndWarnings.AddError(Model, StrInTheETSDepth, Error);
        end;
      end;
    end;
  end;
end;

procedure TModflowETS_Writer.WriteDataSets2And3;
const
  DS3 = ' # Data Set 2: PARNAM PARTYP Parval NCLU';
  DS3Instances = ' INSTANCES NUMINST';
  DS4A = ' # Data Set 3a: INSTNAM';
  DataSetIdentifier = 'Data Set 3b:';
  VariableIdentifiers = 'Condfact';
begin
  WriteParameterDefinitions(DS3, DS3Instances, DS4A, DataSetIdentifier,
    VariableIdentifiers, StrOneOrMoreSParam, umAssign, FEtsPackage.MultiplierArrayNames,
    FEtsPackage.ZoneArrayNames);
end;

procedure TModflowETS_Writer.WriteDataSet1;
var
  IEVTCB: integer;
begin
  NETSOP := Ord(Model.ModflowPackages.EtsPackage.LayerOption) + 1;
  GetFlowUnitNumber(IEVTCB);
  NPETS := ParameterCount;
  NETSEG := Model.ModflowPackages.EtsPackage.SegmentCount;

  WriteInteger(NETSOP);
  WriteInteger(IEVTCB);
  WriteInteger(NPETS);
  WriteInteger(NETSEG);
  WriteString(' # DataSet 1: NETSOP IEVTCB, NPETS, NETSEG');
  NewLine
end;

procedure TModflowETS_Writer.WriteDataSets4To11;
const
  D7PName =      ' # Data Set 7: PARNAM IETSPF';
  D7PNameIname = ' # Data Set 7: PARNAM Iname IETSPF';
  DS5 = ' # Data Set 4: INETSS INETSR INETSX [INIETS [INSGDF]]';
  DataSetIdentifier = 'Data Set 6:';
  VariableIdentifiers = 'ETSR';
begin
  WriteStressPeriods(VariableIdentifiers, DataSetIdentifier, DS5,
    D7PNameIname, D7PName);
end;

procedure TModflowETS_Writer.WriteFile(const AFileName: string);
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveErrorGroup(Model, EtsSurfaceError);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, EtsDepthError);
    if not Package.IsSelected then
    begin
      Exit
    end;
    FEtsPackage := Package as TEtsPackageSelection;
    if Model.PackageGeneratedExternally(StrETS) then
    begin
      Exit;
    end;
    FEtsPackage.MultiplierArrayNames.Clear;
    FEtsPackage.ZoneArrayNames.Clear;
    FNameOfFile := FileName(AFileName);
    WriteToNameFile(StrETS, Model.UnitNumbers.UnitNumber(StrETS),
      FNameOfFile, foInput, Model);
    Evaluate;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    ClearTimeLists(Model);
    OpenFile(FileName(AFileName));
    try
      frmProgressMM.AddMessage(StrWritingETSPackage);
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
      WriteDataSets2And3;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      frmProgressMM.AddMessage(StrWritingDataSets4to11);
      WriteDataSets4To11;
    finally
      CloseFile;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

procedure TModflowETS_Writer.WriteCells(CellList: TList;
  const DataSetIdentifier, VariableIdentifiers: string);
var
  DefaultValue: double;
  DataType: TRbwDataType;
  DataTypeIndex: integer;
  Comment: string;
  Dummy: TDataArray;
begin
  DefaultValue := 0;
  DataType := rdtDouble;
  DataTypeIndex := 0;
  Comment := DataSetIdentifier + ' ' + VariableIdentifiers;
  WriteTransient2DArray(Comment, DataTypeIndex, DataType, DefaultValue,
    CellList, umAssign, True, Dummy, VariableIdentifiers);
end;

procedure TModflowETS_Writer.WriteEvapotranspirationSurface(CellList: TList);
var
  DefaultValue: double;
  DataType: TRbwDataType;
  DataTypeIndex: integer;
  Comment: string;
  Dummy: TDataArray;
begin
  DefaultValue := 0;
  DataType := rdtDouble;
  DataTypeIndex := 0;
  Comment := 'Data Set 5: ETSS';
  WriteTransient2DArray(Comment, DataTypeIndex, DataType, DefaultValue,
    CellList, umAssign, False, Dummy, 'ETSS');
end;

procedure TModflowETS_Writer.WriteExtinctionDepth(CellList: TList);
var
  DefaultValue: double;
  DataType: TRbwDataType;
  DataTypeIndex: integer;
  Comment: string;
  Dummy: TDataArray;
begin
  DefaultValue := 0;
  DataType := rdtDouble;
  DataTypeIndex := 1;
  Comment := 'Data Set 8: ETSX';
  WriteTransient2DArray(Comment, DataTypeIndex, DataType, DefaultValue,
    CellList, umAssign, False, Dummy, 'ETSX');
end;

procedure TModflowETS_Writer.WriteDepthFraction(CellList: TList;
  SegmentIndex: integer);
var
  DefaultValue: double;
  DataType: TRbwDataType;
  DataTypeIndex: integer;
  Comment: string;
  NewArray: TDataArray;
begin
  DefaultValue := 0;
  DataType := rdtDouble;
  DataTypeIndex := SegmentIndex*2;
  Comment := 'Data Set 10: PXDP';
  WriteTransient2DArray(Comment, DataTypeIndex, DataType, DefaultValue,
    CellList, umAssign, False, NewArray, 'PXDP', False);
  CheckDepthFraction(NewArray, SegmentIndex);
  FPriorDepthFractionArray.Free;
  FPriorDepthFractionArray := NewArray;
end;

procedure TModflowETS_Writer.WriteRateFraction(CellList: TList;
  SegmentIndex: integer);
var
  DefaultValue: double;
  DataType: TRbwDataType;
  DataTypeIndex: integer;
  Comment: string;
  NewArray: TDataArray;
begin
  DefaultValue := 0;
  DataType := rdtDouble;
  DataTypeIndex := SegmentIndex*2+1;
  Comment := 'Data Set 11: PETM';
  WriteTransient2DArray(Comment, DataTypeIndex, DataType, DefaultValue,
    CellList, umAssign, False, NewArray, 'PETM', False);
  CheckRateFraction(NewArray, SegmentIndex);
  FPriorRateFractionArray.Free;
  FPriorRateFractionArray := NewArray;
end;

procedure TModflowETS_Writer.WriteStressPeriods(const VariableIdentifiers,
  DataSetIdentifier, DS5, D7PNameIname, D7PName: string);
var
  NP: Integer;
  EtRateList, PriorEtRateList: TValueCellList;
  ParameterValues: TList;
  ParamIndex: Integer;
  ParametersUsed: TStringList;
  TimeIndex: Integer;
  INETSR, INIETS, INSGDF: Integer;
  INETSS: Integer;
  INETSX: Integer;
  DepthSurfaceCellList, PriorListDepthSurfaceCellList: TValueCellList;
  Comment: string;
  SegmentIndex: integer;
//  ErrorString: string;
begin
  inherited;
  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrNoParametersHaveB);
  ParameterValues := TList.Create;
  try
    Comment := 'Data Set 9: IETS';
    if Values.Count = 0 then
    begin
      frmErrorsAndWarnings.AddError(Model, StrNoEvapotranspiratio,
        StrTheEvapotranspirati);
    end;
    for TimeIndex := 0 to Values.Count - 1 do
    begin
      DepthSurfaceCellList := nil;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      frmProgressMM.AddMessage(Format(StrWritingStressP, [TimeIndex+1]));
      ParametersUsed := TStringList.Create;
      try
        RetrieveParametersForStressPeriod(D7PNameIname, D7PName, TimeIndex,
          ParametersUsed, ParameterValues, True);
        NP := ParametersUsed.Count;
        EtRateList := Values[TimeIndex];

        // data set 4;

//        DepthSurfaceCellList := nil;
        if (TimeIndex > 0) and (FDepthSurface.Count > 0) then
        begin
          PriorListDepthSurfaceCellList := FDepthSurface[TimeIndex-1];
          DepthSurfaceCellList := FDepthSurface[TimeIndex];
          if PriorListDepthSurfaceCellList.AreRealValuesIdentical(DepthSurfaceCellList, 0) then
          begin
            INETSS := -1;
//            DepthSurfaceCellList.Cache;
          end
          else
          begin
            INETSS := 1;
          end;
//          PriorListDepthSurfaceCellList.Cache;
        end
        else
        begin
          INETSS := 1;
        end;

        if NPETS > 0 then
        begin
          INETSR := NP;
        end
        else
        begin
         if (TimeIndex > 0) then
          begin
            PriorEtRateList := Values[TimeIndex-1];
            if PriorEtRateList.AreRealValuesIdentical(EtRateList, 0) then
            begin
              INETSR := -1;
              EtRateList.Cache;
            end
            else
            begin
              INETSR := 1;
            end;
            PriorEtRateList.Cache;
          end
          else
          begin
            INETSR := 1;
          end;
        end;

        if (TimeIndex > 0) and (FDepthSurface.Count > 0) then
        begin
          PriorListDepthSurfaceCellList := FDepthSurface[TimeIndex-1];
          DepthSurfaceCellList := FDepthSurface[TimeIndex];
          if PriorListDepthSurfaceCellList.AreRealValuesIdentical(DepthSurfaceCellList, 1) then
          begin
            INETSX := -1;
//            DepthSurfaceCellList.Cache;
          end
          else
          begin
            INETSX := 1;
          end;
          PriorListDepthSurfaceCellList.Cache;
        end
        else
        begin
          INETSX := 1;
        end;

        if NETSOP = 2 then
        begin
          INIETS  := 1;
        end
        else
        begin
          INIETS  := -1;
        end;
        INSGDF := 1;

        WriteInteger(INETSS);
        WriteInteger(INETSR);
        WriteInteger(INETSX);
        WriteInteger(INIETS);
        WriteInteger(INSGDF);
        WriteString(DS5 + ' Stress period ' + IntToStr(TimeIndex+1));
        NewLine;

        // data set 5
        if INETSS > 0 then
        begin
          if FDepthSurface.Count > 0 then
          begin
            DepthSurfaceCellList := FDepthSurface[TimeIndex];
            WriteEvapotranspirationSurface(DepthSurfaceCellList);
            Application.ProcessMessages;
            if not frmProgressMM.ShouldContinue then
            begin
              EtRateList.Cache;
              Exit;
            end;
//            if (INETSX < 0) and (TimeIndex = Values.Count - 1) then
//            begin
//              DepthSurfaceCellList.Cache
//            end;
          end
          else
          begin
//            DepthSurfaceCellList := nil;
            frmErrorsAndWarnings.AddError(Model, EtsSurfaceError,
              EtsSurfaceErrorMessage);
          end;
        end;

        if INETSR > 0 then
        begin
          if NPETS = 0 then
          begin
            // data set 6
            WriteCells(EtRateList, DataSetIdentifier, VariableIdentifiers);
          end
          else
          begin
            // data set 7
            if ParametersUsed.Count = 0 then
            begin
              frmErrorsAndWarnings.AddError(Model, StrNoParametersHaveB,
                IntToStr(TimeIndex+1));
            end;
            for ParamIndex := 0 to ParametersUsed.Count - 1 do
            begin
              WriteString(ParametersUsed[ParamIndex]);
              NewLine;
            end;
          end;
          Application.ProcessMessages;
          if not frmProgressMM.ShouldContinue then
          begin
            EtRateList.Cache;
            Exit;
          end;
        end;

        // data set 8

        if INETSX > 0 then
        begin
          if FDepthSurface.Count > 0 then
          begin
            DepthSurfaceCellList := FDepthSurface[TimeIndex];
            WriteExtinctionDepth(DepthSurfaceCellList);
            Application.ProcessMessages;
            if not frmProgressMM.ShouldContinue then
            begin
              EtRateList.Cache;
              Exit;
            end;
          end
          else
          begin
            frmErrorsAndWarnings.AddError(Model, EtsDepthError, EtsDepthErrorMessage);
          end;

        end;
        // data set 9
        WriteLayerSelection(EtRateList, ParameterValues, TimeIndex, Comment, 'IETS');
        Application.ProcessMessages;
        if not frmProgressMM.ShouldContinue then
        begin
          EtRateList.Cache;
          Exit;
        end;

        FPriorDepthFractionArray := nil;
        FPriorRateFractionArray := nil;
        try
          if FDepthSurface.Count > 0 then
          begin
            DepthSurfaceCellList := FDepthSurface[TimeIndex];
            for SegmentIndex := 1 to NETSEG - 1 do
            begin
              // data set 10
              WriteDepthFraction(DepthSurfaceCellList, SegmentIndex);
              Application.ProcessMessages;
              if not frmProgressMM.ShouldContinue then
              begin
                EtRateList.Cache;
                Exit;
              end;

              // data set 11
              WriteRateFraction(DepthSurfaceCellList, SegmentIndex);
              Application.ProcessMessages;
              if not frmProgressMM.ShouldContinue then
              begin
                EtRateList.Cache;
                Exit;
              end;
            end;
          end
          else
          begin
            frmErrorsAndWarnings.AddError(Model, EtsDepthError, EtsDepthErrorMessage)
          end;
        finally
          FPriorDepthFractionArray.Free;
          FPriorRateFractionArray.Free;
          FPriorDepthFractionArray := nil;
          FPriorRateFractionArray := nil;
        end;
        if (TimeIndex = Values.Count - 1) then
        begin
          if DepthSurfaceCellList <> nil then
          begin
            DepthSurfaceCellList.Cache;
          end;
          EtRateList.Cache;
        end;
      finally
        ParametersUsed.Free;
      end;
    end;
  finally
    ParameterValues.Free;
  end;
end;

end.
