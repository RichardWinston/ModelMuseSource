unit ModflowRCH_WriterUnit;

interface

uses SysUtils, Classes, Contnrs, CustomModflowWriterUnit, ScreenObjectUnit,
  ModflowBoundaryUnit, ModflowPackageSelectionUnit, OrderedCollectionUnit,
  ModflowCellUnit, PhastModelUnit, ModflowBoundaryDisplayUnit;

Type
  TModflowRCH_Writer = class(TCustomTransientArrayWriter)
  private
    NPRCH: integer;
    NRCHOP: integer;
    FRchPackage: TRchPackageSelection;
    procedure WriteDataSet1;
    procedure WriteDataSet2;
    procedure WriteDataSets3And4;
    procedure WriteDataSets5To8;
    procedure WriteCells(CellList: TValueCellList; const DataSetIdentifier,
      VariableIdentifiers: string);
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
    procedure WriteFile(const AFileName: string);
    procedure UpdateDisplay(TimeLists: TModflowBoundListOfTimeLists);
  end;

implementation

uses RbwParser, ModflowUnitNumbers, ModflowTransientListParameterUnit,
  frmErrorsAndWarningsUnit, DataSetUnit, ModflowRchUnit, GoPhastTypes,
  frmProgressUnit, Forms, Windows;

resourcestring
  StrNoRechargeDefined = 'No recharge defined';
  StrTheRechargePackage = 'The recharge package is active but no recharge ha' +
  's been defined for any stress period.';
  StrWritingRCHPackage = 'Writing RCH Package input.';
//  StrWritingDataSet0 = '  Writing Data Set 0.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
//  StrWritingDataSet2 = '  Writing Data Set 2.';
//  StrWritingDataSets3and4 = '  Writing Data Sets 3 and 4.';
//  StrWritingDataSets5to8 = '  Writing Data Sets 5 to 8.';
  StrWritingStressP = '    Writing Stress Period %d';
//  ErrorRoot = 'One or more %s parameters have been eliminated '
//    + 'because there are no cells associated with them.';
  StrNoParametersHaveB = 'No parameters have been defined for the Recharge p' +
  'ackage for the following Stress periods.';

{ TModflowRCH_Writer }

function TModflowRCH_Writer.CellType: TValueCellType;
begin
  result := TRch_Cell;
end;

procedure TModflowRCH_Writer.Evaluate;
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TRchBoundary;
begin
  inherited;
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
    Boundary := ScreenObject.ModflowRchBoundary;
    if Boundary <> nil then
    begin
      Boundary.GetRechargeLayerCells(FLayers, Model);
      Boundary.RechargeLayers.ClearBoundaries(Model);
    end;
  end;
end;

class function TModflowRCH_Writer.Extension: string;
begin
  result := '.rch';
end;

function TModflowRCH_Writer.GetBoundary(
  ScreenObject: TScreenObject): TModflowBoundary;
begin
  result := ScreenObject.ModflowRchBoundary;
end;

function TModflowRCH_Writer.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.RchPackage;
end;

function TModflowRCH_Writer.ParameterType: TParameterType;
begin
  result := ptRCH;
end;

function TModflowRCH_Writer.Prefix: string;
begin
  result := 'R'
end;

procedure TModflowRCH_Writer.UpdateDisplay(
  TimeLists: TModflowBoundListOfTimeLists);
var
  List: TValueCellList;
  ParameterValues: TList;
  ParametersUsed: TStringList;
  TimeIndex: Integer;
  Comment: string;
  ParamDefArrays: TList;
  RechRateTimes: TModflowBoundaryDisplayTimeList;
  RechLayerTimes: TModflowBoundaryDisplayTimeList;
  RechRateArray: TModflowBoundaryDisplayDataArray;
  RechLayerArray: TModflowBoundaryDisplayDataArray;
  DefArrayList: TList;
  Index: Integer;
  ATimeList: TModflowBoundaryDisplayTimeList;
const
  D7PNameIname = '';
  D7PName = '';
begin
  if not Package.IsSelected then
  begin
    UpdateNotUsedDisplay(TimeLists);
    Exit;
  end;
//  ParameterValues := TValueCellList.Create(CellType);
  ParameterValues := TList.Create;
  try
    Evaluate;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    ClearTimeLists(Model);
    ParamDefArrays := TObjectList.Create;
    try
      EvaluateParameterDefinitions(ParamDefArrays, StrOneOrMoreSParam,
        Model.ModflowPackages.RchPackage.AssignmentMethod);
      NPRCH := ParameterCount;
      NRCHOP := Ord(Model.ModflowPackages.RchPackage.LayerOption) + 1;
      RechRateTimes := TimeLists[0];
      RechLayerTimes := TimeLists[1];

      Comment := '# Data Set 8: IRCH';
      if Values.Count = 0 then
      begin
        SetTimeListsUpToDate(TimeLists);
        Exit;
      end;
      for TimeIndex := 0 to Values.Count - 1 do
      begin
        RechRateArray := RechRateTimes[TimeIndex]
          as TModflowBoundaryDisplayDataArray;
        if RechLayerTimes = nil then
        begin
          RechLayerArray := nil;
        end
        else
        begin
          RechLayerArray := RechLayerTimes[TimeIndex]
            as TModflowBoundaryDisplayDataArray;
        end;

        ParametersUsed := TStringList.Create;
        try
          RetrieveParametersForStressPeriod(D7PNameIname, D7PName, TimeIndex,
            ParametersUsed, ParameterValues, True);
          List := Values[TimeIndex];
//          List.CheckRestore;

          if NPRCH = 0 then
          begin
            // data set 6
            AssignTransient2DArray(RechRateArray, 0, List, 0, rdtDouble,
              Model.ModflowPackages.RchPackage.AssignmentMethod);
          end
          else
          begin
            // data set 7
            DefArrayList := ParamDefArrays[TimeIndex];
            UpdateTransient2DArray(RechRateArray, DefArrayList);
          end;
          Model.AdjustDataArray(RechRateArray);
          RechRateArray.CacheData;

          // Data set 8
          if RechLayerArray <> nil then
          begin
            if (Model.ModflowPackages.RchPackage.
              LayerOption = loSpecified)
              and not Model.ModflowPackages.RchPackage.
              TimeVaryingLayers and (ParameterCount > 0) then
            begin
              RetrieveParametersForStressPeriod(D7PNameIname, D7PName, 0,
                ParametersUsed, ParameterValues, True);
              List := Values[0];
            end;
            UpdateLayerDisplay(List, ParameterValues, TimeIndex,
              RechLayerArray);
            RechLayerArray.CacheData;
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
      ParamDefArrays.Free;
    end;
  finally
    ParameterValues.Free;
  end;
end;

procedure TModflowRCH_Writer.WriteDataSet1;
begin
  NPRCH := ParameterCount;
  if NPRCH > 0 then
  begin
    WriteString('PARAMETER');
    WriteInteger(NPRCH);
    WriteString(' # PARAMETER NPRCH');
    NewLine;
  end;
end;

procedure TModflowRCH_Writer.WriteDataSet2;
var
  IRCHCB: integer;
begin
  NRCHOP := Ord(Model.ModflowPackages.RchPackage.LayerOption) + 1;
  GetFlowUnitNumber(IRCHCB);

  WriteInteger(NRCHOP);
  WriteInteger(IRCHCB);
  WriteString(' # DataSet 2: NRCHOP IRCHCB');
  NewLine
end;

procedure TModflowRCH_Writer.WriteDataSets3And4;
const
  DS3 = ' # Data Set 3: PARNAM PARTYP Parval NCLU';
  DS3Instances = ' INSTANCES NUMINST';
  DS4A = ' # Data Set 4a: INSTNAM';
  DataSetIdentifier = 'Data Set 4b:';
  VariableIdentifiers = 'Condfact';
begin
  WriteParameterDefinitions(DS3, DS3Instances, DS4A, DataSetIdentifier,
    VariableIdentifiers, StrOneOrMoreSParam, FRchPackage.AssignmentMethod,
    FRchPackage.MultiplierArrayNames, FRchPackage.ZoneArrayNames);
end;

procedure TModflowRCH_Writer.WriteDataSets5To8;
const
  D7PName =      ' # Data Set 7: PARNAM IRCHPF';
  D7PNameIname = ' # Data Set 7: PARNAM Iname IRCHPF';
  DS5 = ' # Data Set 5: INRECH INIRCH';
  DataSetIdentifier = 'Data Set 6:';
  VariableIdentifiers = 'RECH';
begin
  WriteStressPeriods(VariableIdentifiers, DataSetIdentifier, DS5,
    D7PNameIname, D7PName);
end;

procedure TModflowRCH_Writer.WriteFile(const AFileName: string);
begin
//  OutputDebugString('SAMPLING ON');
  if not Package.IsSelected then
  begin
    Exit
  end;
  FRchPackage := Package as TRchPackageSelection;
  if Model.PackageGeneratedExternally(StrRCH) then
  begin
    Exit;
  end;
//  if Model.ModelSelection = msModflow2015 then
//  begin
//    Abbreviation := 'RCH8';
//  end
//  else
//  begin
//    Abbreviation := StrRCH;
//  end;
  FRchPackage.MultiplierArrayNames.Clear;
  FRchPackage.ZoneArrayNames.Clear;
  FNameOfFile := FileName(AFileName);
  WriteToNameFile(StrRCH, Model.UnitNumbers.UnitNumber(StrRCH),
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
    frmProgressMM.AddMessage(StrWritingRCHPackage);
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

    frmProgressMM.AddMessage(StrWritingDataSet2);
    WriteDataSet2;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSets3and4);
    WriteDataSets3And4;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrWritingDataSets5to8);
    WriteDataSets5To8;
  finally
    CloseFile;
//    Clear;
  end;
//  OutputDebugString('SAMPLING OFF');
end;

procedure TModflowRCH_Writer.WriteCells(CellList: TValueCellList;
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


  WriteTransient2DArray(Comment, DataTypeIndex, DataType,
    DefaultValue, CellList, Model.ModflowPackages.RchPackage.AssignmentMethod,
    True, Dummy, VariableIdentifiers);
end;

procedure TModflowRCH_Writer.WriteStressPeriods(const VariableIdentifiers,
  DataSetIdentifier, DS5, D7PNameIname, D7PName: string);
var
  NP: Integer;
  RechRateList, PriorRechRateList: TValueCellList;
  ParameterValues: TValueCellList;
  ParamIndex: Integer;
  ParametersUsed: TStringList;
  TimeIndex: Integer;
  INRECH, INIRCH: Integer;
  Comment: string;
begin
  inherited;
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrNoParametersHaveB);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrNoRechargeDefined);
    ParameterValues := TValueCellList.Create(CellType);
    try
      ParameterValues.OwnsObjects := False;
      Comment := '# Data Set 8: IRCH';
      if Values.Count = 0 then
      begin
        frmErrorsAndWarnings.AddError(Model, StrNoRechargeDefined,
          StrTheRechargePackage);
      end;
      for TimeIndex := 0 to Values.Count - 1 do
      begin
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
          RechRateList := Values[TimeIndex];
          // data set 5;
          if NPRCH > 0 then
          begin
            INRECH := NP;
          end
          else
          begin
           if (TimeIndex > 0) then
            begin
              PriorRechRateList := Values[TimeIndex-1];
              if PriorRechRateList.AreRealValuesIdentical(RechRateList, 0) then
              begin
                INRECH := -1;
  //              RechRateList.Cache;
              end
              else
              begin
                INRECH := 1;
              end;
              PriorRechRateList.Cache;
            end
            else
            begin
              INRECH := 1;
            end;
          end;
          INIRCH := 1;

          WriteInteger(INRECH);
          WriteInteger(INIRCH);
          WriteString(DS5 + ' Stress period ' + IntToStr(TimeIndex+1));
          NewLine;
          Application.ProcessMessages;
          if not frmProgressMM.ShouldContinue then
          begin
            Exit;
          end;

          if INRECH > 0 then
          begin
            if NPRCH = 0 then
            begin
              // data set 6
              WriteCells(RechRateList, DataSetIdentifier, VariableIdentifiers);
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
              RechRateList.Cache;
              Exit;
            end;
          end;

          // Data set 8
          WriteLayerSelection(RechRateList, ParameterValues, TimeIndex, Comment, 'IRCH');
          Application.ProcessMessages;
          if not frmProgressMM.ShouldContinue then
          begin
            RechRateList.Cache;
            Exit;
          end;
          if TimeIndex = Values.Count - 1 then
          begin
            RechRateList.Cache;
          end;
        finally
          ParametersUsed.Free;
        end;
      end;
    finally
      ParameterValues.Free;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

end.
