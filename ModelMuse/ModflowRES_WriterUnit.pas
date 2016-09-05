unit ModflowRES_WriterUnit;

interface

uses SysUtils, Classes, CustomModflowWriterUnit, ModflowCellUnit,
  ModflowPackageSelectionUnit, ScreenObjectUnit, ModflowBoundaryUnit,
  OrderedCollectionUnit;

type
  TModflowRES_Writer = class(TCustomTransientArrayWriter)
  private
    NRES: integer;
    NRESOP: integer;
    procedure WriteDataSet1;
    procedure WriteDataSet2;
    procedure WriteDataSet3;
    procedure WriteDataSet4;
    procedure WriteDataSet5;
    procedure WriteDataSet6;
    procedure WriteDataSet7;
    procedure WriteCells(CellList: TList; const DataSetIdentifier,
      VariableIdentifiers: string);
  protected
    function CellType: TValueCellType; override;
    function GetBoundary(ScreenObject: TScreenObject): TModflowBoundary;
      override;
    function Prefix: string; override;
    procedure Evaluate; override;
    class function Extension: string; override;
    function Package: TModflowPackageSelection; override;
    function ParameterType: TParameterType; override;
    procedure WriteStressPeriods(const VariableIdentifiers, DataSetIdentifier,
      DS5, D7PNameIname, D7PName: string); override;
  public
    procedure WriteFile(const AFileName: string);

  end;

implementation

uses RbwParser, ModflowUnitNumbers, DataSetUnit, PhastModelUnit, ModflowResUnit,
  ModflowTimeUnit, frmProgressUnit, frmFormulaErrorsUnit, Forms, GoPhastTypes,
  frmErrorsAndWarningsUnit;

resourcestring
  StrNoReservoirsDefine = 'No reservoirs defined';
  StrTheReservoirPackag = 'The Reservoir package is selected but no reservoi' +
  'rs have been defined.';
  StrEndingHeadForThe = '(Ending head for the %s)';
  StrStartingHeadForT = '(Starting head for the %s)';
  StrEvaluatingRESPacka = 'Evaluating RES Package data.';
  StrWritingStressP = '    Writing Stress Period %d';
  StrWritingRESPackage = 'Writing RES Package input.';
  StrTheRESPackageIsN = 'The RES package is not supported by MT3DMS.';
  StrMT3DMSVersion53D = 'MT3DMS version 5.3 does not suppport the RES packag' +
  'e.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
//  StrWritingDataSet2 = '  Writing Data Set 2.';
//  StrWritingDataSet3 = '  Writing Data Set 3.';
//  StrWritingDataSet4 = '  Writing Data Set 4.';
//  StrWritingDataSet5 = '  Writing Data Set 5.';
//  StrWritingDataSet6 = '  Writing Data Set 6.';
//  StrWritingDataSet7 = '  Writing Data Set 7.';

{ TModflowRES_Writer }

function TModflowRES_Writer.CellType: TValueCellType;
begin
  result := TRes_Cell;
end;

procedure TModflowRES_Writer.Evaluate;
var
  Index: Integer;
  AScreenObject: TScreenObject;
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmProgressMM.AddMessage(StrEvaluatingRESPacka);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrNoReservoirsDefine);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrTheRESPackageIsN);

    if Model.ModflowPackages.Mt3dBasic.IsSelected then
    begin
      frmErrorsAndWarnings.AddWarning(Model, StrTheRESPackageIsN,
        StrMT3DMSVersion53D);
    end;

    NRES := 0;
    for Index := 0 to Model.ScreenObjectCount - 1 do
    begin
      AScreenObject := Model.ScreenObjects[Index];
      if AScreenObject.Deleted then
      begin
        Continue;
      end;
      if not AScreenObject.UsedModels.UsesModel(Model) then
      begin
        Continue;
      end;
      if (AScreenObject.ModflowResBoundary <> nil)
        and AScreenObject.ModflowResBoundary.Used then
      begin
        Assert(AScreenObject.ViewDirection = vdTop);
        Inc(NRES);
        AScreenObject.ModflowResBoundary.ResId := NRES;
      end;
    end;
    if NRES = 0 then
    begin
      frmErrorsAndWarnings.AddError(Model, StrNoReservoirsDefine,
        StrTheReservoirPackag);
    end;
    inherited;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

class function TModflowRES_Writer.Extension: string;
begin
  result := '.res';
end;

function TModflowRES_Writer.GetBoundary(
  ScreenObject: TScreenObject): TModflowBoundary;
begin
  result := ScreenObject.ModflowResBoundary;
end;

function TModflowRES_Writer.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.ResPackage;
end;

function TModflowRES_Writer.ParameterType: TParameterType;
begin
  result := ptUndefined;
end;

function TModflowRES_Writer.Prefix: string;
begin
  result := '';
end;

procedure TModflowRES_Writer.WriteCells(CellList: TList;
  const DataSetIdentifier, VariableIdentifiers: string);
var
  DefaultValue: double;
  DataType: TRbwDataType;
  DataTypeIndex: integer;
  Comment: string;
  Dummy: TDataArray;
begin
  DefaultValue := 0;
  DataType := rdtInteger;
  DataTypeIndex := 0;
  Comment := DataSetIdentifier + ' ' + VariableIdentifiers;
  WriteTransient2DArray(Comment, DataTypeIndex, DataType,
    DefaultValue, CellList, umAssign, False, Dummy, VariableIdentifiers);
end;

procedure TModflowRES_Writer.WriteDataSet1;
var
  IRESCB, IRESPT, NPTS: integer;
begin
  GetFlowUnitNumber(IRESCB);
  case Model.ModflowPackages.ResPackage.LayerOption of
    loTop: NRESOP := 1;
    loSpecified: NRESOP := 2;
    loTopActive: NRESOP := 3;
  end;
  if Model.ModflowPackages.ResPackage.PrintStage then
  begin
    IRESPT := 1;
  end
  else
  begin
    IRESPT := 0;
  end;
  NPTS := Model.ModflowPackages.ResPackage.TableStages;

  WriteString(FixedFormattedInteger(NRES, 10));
  WriteString(FixedFormattedInteger(IRESCB, 10));
  WriteString(FixedFormattedInteger(NRESOP, 10));
  WriteString(FixedFormattedInteger(IRESPT, 10));
  WriteString(FixedFormattedInteger(NPTS, 10));
  WriteString(' # Data Set 1: NRES IRESCB NRESOP IRESPT NPTS');
  NewLine;
end;

procedure TModflowRES_Writer.WriteDataSet2;
var
  List: TList;
  DataSetIdentifier: string;
  VariableIdentifiers: string;
begin
  List := Values[0];
  DataSetIdentifier := ' # Data Set 2:';
  VariableIdentifiers := 'IRES';
  WriteCells(List, DataSetIdentifier, VariableIdentifiers)
end;

procedure TModflowRES_Writer.WriteDataSet3;
var
  DataArray: TDataArray;
//  ArrayIndex: integer;
begin
  if NRESOP = 2 then
  begin
    DataArray := Model.DataArrayManager.GetDataSetByName(rsResLayer);
    Assert(DataArray <> nil);
//    DataArray := PhastModel.DataSets[ArrayIndex];
    WriteArray(DataArray, 0, ' # Data Set 3: IRESL', StrNoValueAssigned, 'IRESL');
  end;
end;

procedure TModflowRES_Writer.WriteDataSet4;
var
  DataArray: TDataArray;
//  ArrayIndex: integer;
begin
  DataArray := Model.DataArrayManager.GetDataSetByName(rsResBottom);
  Assert(DataArray <> nil);
//  DataArray := PhastModel.DataSets[ArrayIndex];
  WriteArray(DataArray, 0, ' # Data Set 4: BRES', StrNoValueAssigned, 'BRES');
end;

procedure TModflowRES_Writer.WriteDataSet5;
var
  DataArray: TDataArray;
//  ArrayIndex: integer;
begin
  DataArray := Model.DataArrayManager.GetDataSetByName(rsResKv);
  Assert(DataArray <> nil);
//  DataArray := PhastModel.DataSets[ArrayIndex];
  WriteArray(DataArray, 0, ' # Data Set 5: HCres', StrNoValueAssigned, 'HCres');
end;

procedure TModflowRES_Writer.WriteDataSet6;
var
  DataArray: TDataArray;
//  ArrayIndex: integer;
begin
  DataArray := Model.DataArrayManager.GetDataSetByName(rsResBedThickness);
  Assert(DataArray <> nil);
//  DataArray := PhastModel.DataSets[ArrayIndex];
  WriteArray(DataArray, 0, ' # Data Set 6: Rbthck', StrNoValueAssigned, 'Rbthck');
end;

procedure TModflowRES_Writer.WriteDataSet7;
var
  Index: integer;
  Item: TModflowStressPeriod;
  Reservoirs: TList;
  AScreenObject: TScreenObject;
  Reservoir: TResBoundary;
  ReservoirIndex: integer;
//  TimeIndex: integer;
  ResItem: TResItem;
  StartHead: double;
  EndHead: double;
  ScreenObjectIndex: Integer;
  ExportedStartHead: double;
  ExportedEndHead: double;
  Compiler: TRbwParser;
  TempFormula: string;
  Expression: TExpression;
  ScreenObject: TScreenObject;
//  PriorItem: TResItem;
  UseStartOnly: Boolean;
  UseLastOnly: Boolean;
  procedure EvaluateStartAndEndHead;
  begin
    Assert(ResItem <> nil);

    Expression := nil;
    TempFormula := ResItem.StartHead;
    try
      Compiler.Compile(TempFormula);
      Expression := Compiler.CurrentExpression;
      Expression.Evaluate;
    except on E: ERbwParserError do
      begin
        ScreenObject := Reservoir.ScreenObject as TScreenObject;
        frmFormulaErrors.AddFormulaError(ScreenObject.Name,
          Format(StrEndingHeadForThe,
          [sLineBreak+Package.PackageIdentifier]),
          TempFormula, E.Message);

        ResItem.EndHead := '0.';
        TempFormula := ResItem.EndHead;
        Compiler.Compile(TempFormula);
        Expression := Compiler.CurrentExpression;
        Expression.Evaluate;
      end;
    end;
    StartHead := Expression.DoubleResult;

    Expression := nil;
    TempFormula := ResItem.EndHead;
    try
      Compiler.Compile(TempFormula);
      Expression := Compiler.CurrentExpression;
      Expression.Evaluate;
    except on E: ERbwParserError do
      begin
        ScreenObject := Reservoir.ScreenObject as TScreenObject;
        frmFormulaErrors.AddFormulaError(ScreenObject.Name,
          Format(StrEndingHeadForThe,
          [sLineBreak+Package.PackageIdentifier]),
          TempFormula, E.Message);

        ResItem.EndHead := '0.';
        TempFormula := ResItem.EndHead;
        Compiler.Compile(TempFormula);
        Expression := Compiler.CurrentExpression;
        Expression.Evaluate;
      end;
    end;
//        ExportedStartHead := Expression.DoubleResult;
    EndHead := Expression.DoubleResult;
  end;
begin
  Compiler := Model.rpThreeDFormulaCompiler;

  Reservoirs := TList.Create;
  try
    for ScreenObjectIndex := 0 to Model.ScreenObjectCount - 1 do
    begin
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      AScreenObject := Model.ScreenObjects[ScreenObjectIndex];
      if (AScreenObject.ModflowResBoundary <> nil)
        and AScreenObject.ModflowResBoundary.Used then
      begin
        Reservoirs.Add(AScreenObject.ModflowResBoundary);
      end;
    end;
    for Index := 0 to Model.ModflowFullStressPeriods.Count - 1 do
    begin
      frmProgressMM.AddMessage(Format(StrWritingStressP, [Index+1]));
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      Item := Model.ModflowFullStressPeriods.Items[Index];
      for ReservoirIndex := 0 to Reservoirs.Count - 1 do
      begin
        Application.ProcessMessages;
        if not frmProgressMM.ShouldContinue then
        begin
          Exit;
        end;
        Reservoir := Reservoirs[ReservoirIndex];

        UseStartOnly := False;
        UseLastOnly := False;
        ResItem := Reservoir.Values.GetItemContainingTime(Item.StartTime) as TResItem;
        if ResItem <> nil then
        begin
          if (ResItem.EndTime <= Item.StartTime) then
          begin
            UseLastOnly := True;
          end;
        end
        else
        if (ResItem = nil) or (ResItem.EndTime <= Item.StartTime)
          or (ResItem.StartTime > Item.EndTime) then
        begin
          ResItem := Reservoir.Values.First as TResItem;
          if ResItem.StartTime >= Item.EndTime then
          begin
            UseStartOnly := True;
          end
          else
          begin
            ResItem := Reservoir.Values.Last as TResItem;
            if ResItem.EndTime <= Item.StartTime then
            begin
              UseLastOnly := True;
            end;
          end;
        end;
        Assert(ResItem <> nil);


//        if ResItem.EndTime = Item.StartTime then
//        begin
//          PriorItem := ResItem;
//          ResItem := Reservoir.Values.GetItemContainingTime(Item.EndTime) as TResItem;
//          if ResItem = nil then
//          begin
//            ResItem := PriorItem;
//          end;
//        end;
        EvaluateStartAndEndHead;

        if UseStartOnly then
        begin
          ExportedStartHead := StartHead;
          ExportedEndHead := StartHead;
        end
        else if UseLastOnly then
        begin
          ExportedStartHead := EndHead;
          ExportedEndHead := EndHead;
        end
        else
        begin
          if ResItem.StartTime = Item.StartTime then
          begin
            ExportedStartHead := StartHead
          end
          else
          begin
            Assert(ResItem.StartTime < Item.StartTime);
            ExportedStartHead := StartHead + (Item.StartTime-ResItem.StartTime)
              / (ResItem.EndTime-ResItem.StartTime)*(EndHead-StartHead);
          end;

          if ResItem.EndTime = Item.EndTime then
          begin
            ExportedEndHead := EndHead;
          end
          else
          begin
            Assert (ResItem.EndTime > Item.EndTime);
            ExportedEndHead := StartHead + (Item.EndTime-ResItem.StartTime)
              / (ResItem.EndTime-ResItem.StartTime)*(EndHead-StartHead);
          end;
        end;

//        for TimeIndex := 0 to Reservoir.Values.Count - 1 do
//        begin
//          Application.ProcessMessages;
//          if not frmProgressMM.ShouldContinue then
//          begin
//            Exit;
//          end;
//          frmProgressMM.AddMessage(Format(StrWritingStressP, [TimeIndex+1]));
//          ResItem := Reservoir.Values[TimeIndex] as TResItem;
//
//          TempFormula := ResItem.StartHead;
//          try
//            Compiler.Compile(TempFormula);
//            Expression := Compiler.CurrentExpression;
//            Expression.Evaluate;
//          except on E: ERbwParserError do
//            begin
//              ScreenObject := Reservoir.ScreenObject as TScreenObject;
//              frmFormulaErrors.AddFormulaError(ScreenObject.Name,
//                Format(StrStartingHeadForT,
//                [sLineBreak+ Package.PackageIdentifier]),
//                TempFormula, E.Message);
//
//              ResItem.StartHead := '0.';
//              TempFormula := ResItem.StartHead;
//              Compiler.Compile(TempFormula);
//              Expression := Compiler.CurrentExpression;
//              Expression.Evaluate;
//            end;
//          end;
//          StartHead := Expression.DoubleResult;
//
//          TempFormula := ResItem.EndHead;
//          try
//            Compiler.Compile(TempFormula);
//            Expression := Compiler.CurrentExpression;
//            Expression.Evaluate;
//          except on E: ERbwParserError do
//            begin
//              ScreenObject := Reservoir.ScreenObject as TScreenObject;
//              frmFormulaErrors.AddFormulaError(ScreenObject.Name,
//                Format(StrEndingHeadForThe,
//                [sLineBreak+Package.PackageIdentifier]),
//                TempFormula, E.Message);
//
//              ResItem.EndHead := '0.';
//              TempFormula := ResItem.EndHead;
//              Compiler.Compile(TempFormula);
//              Expression := Compiler.CurrentExpression;
//              Expression.Evaluate;
//            end;
//          end;
//          EndHead := Expression.DoubleResult;
//
//          if ResItem.StartTime = Item.StartTime then
//          begin
//            ExportedStartHead := StartHead;
//          end
//          else if ResItem.EndTime <= Item.StartTime then
//          begin
//            ExportedStartHead := EndHead;
//          end
//          else if (ResItem.StartTime < Item.StartTime)
//            and (ResItem.EndTime > Item.StartTime) then
//          begin
//            Assert(ResItem.EndTime <> ResItem.StartTime);
//            ExportedStartHead := (Item.StartTime - ResItem.StartTime)/
//              (ResItem.EndTime - ResItem.StartTime)*
//              (EndHead - StartHead) + StartHead;
//          end;
//
//          if ResItem.EndTime <= Item.EndTime then
//          begin
//            ExportedEndHead := EndHead;
//          end
//          else if (ResItem.StartTime < Item.EndTime)
//            and (ResItem.EndTime > Item.EndTime) then
//          begin
//            Assert(ResItem.EndTime <> ResItem.StartTime);
//            ExportedEndHead := (Item.EndTime - ResItem.StartTime)/
//              (ResItem.EndTime - ResItem.StartTime)*
//              (EndHead - StartHead) + StartHead;
//          end;
//
//          if ResItem.EndTime >= Item.EndTime then
//          begin
//            break;
//          end;
//        end;
        WriteF10Float(ExportedStartHead);
        WriteF10Float(ExportedEndHead);
        WriteString(' # Data Set 7, Stress period');
        WriteInteger(Index + 1);
        WriteString(': Ststage Endstage');
        NewLine;
      end;
    end;
  finally
    Reservoirs.Free;
  end;
end;

procedure TModflowRES_Writer.WriteFile(const AFileName: string);
var
  NameOfFile: string;
begin
  if not Package.IsSelected then
  begin
    Exit
  end;
  if Model.PackageGeneratedExternally(StrRES) then
  begin
    Exit;
  end;
  NameOfFile := FileName(AFileName);
  WriteToNameFile(StrRES, Model.UnitNumbers.UnitNumber(StrRES), NameOfFile, foInput, Model);
  Evaluate;
  if NRES = 0 then
  begin
    Exit;
  end;
  Application.ProcessMessages;
  if not frmProgressMM.ShouldContinue then
  begin
    Exit;
  end;
  ClearTimeLists(Model);
  OpenFile(NameOfFile);
  try
//    WriteDataSet0;
    frmProgressMM.AddMessage(StrWritingRESPackage);
    frmProgressMM.AddMessage(StrWritingDataSet1);
    WriteDataSet1;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSet2);
    WriteDataSet2;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSet3);
    WriteDataSet3;
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
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSet7);
    WriteDataSet7;
  finally
    CloseFile;
  end;

end;

procedure TModflowRES_Writer.WriteStressPeriods(const VariableIdentifiers,
  DataSetIdentifier, DS5, D7PNameIname, D7PName: string);
begin
  inherited;
end;

end.
