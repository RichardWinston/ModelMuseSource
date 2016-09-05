unit ModflowDRN_WriterUnit;

interface

uses SysUtils, Classes, Contnrs, CustomModflowWriterUnit, ModflowDrnUnit,
  PhastModelUnit, ScreenObjectUnit, ModflowBoundaryUnit, ModflowCellUnit,
  ModflowPackageSelectionUnit, OrderedCollectionUnit, FluxObservationUnit,
  GoPhastTypes;

type
  TModflowDRN_Writer = class(TFluxObsWriter)
  private
    NPDRN: integer;
    MXL: integer;
    FCells: array of array of TDrn_Cell;
    procedure WriteDataSet1;
    procedure WriteDataSet2;
    procedure WriteDataSets3And4;
    procedure WriteDataSets5To7;
    procedure InitializeCells;
  protected
    function ObservationPackage: TModflowPackageSelection; override;
    function CellType: TValueCellType; override;
    class function Extension: string; override;
    class function ObservationExtension: string; override;
    class function ObservationOutputExtension: string; override;
    function GetBoundary(ScreenObject: TScreenObject): TModflowBoundary;
      override;
    function Package: TModflowPackageSelection; override;
    function ParameterType: TParameterType; override;
    procedure WriteCell(Cell: TValueCell;
      const DataSetIdentifier, VariableIdentifiers: string); override;
    procedure WriteParameterCells(CellList: TValueCellList; NLST: Integer;
      const VariableIdentifiers, DataSetIdentifier: string;
      AssignmentMethod: TUpdateMethod; MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection); override;
    function ObsNameWarningString: string; override;
    procedure Evaluate; override;
    procedure CheckCell(ValueCell: TValueCell; const PackageName: string); override;
    procedure DoBeforeWriteCells; override;
    function ObsTypeMF6: string; override;
  public
    procedure WriteFile(const AFileName: string);
    procedure WriteFluxObservationFile(const AFileName: string;
      Purpose: TObservationPurpose);
  end;

implementation

uses ModflowTimeUnit, frmErrorsAndWarningsUnit,
  ModflowTransientListParameterUnit, ModflowUnitNumbers, frmProgressUnit,
  RbwParser, DataSetUnit, Forms, FastGEO;

resourcestring
  StrTheFollowingDrain = 'The following Drain observation names may be valid' +
  ' for MODFLOW but they are not valid for UCODE.';
  StrWritingDRNPackage = 'Writing DRN Package input.';
//  StrWritingDataSet0 = '  Writing Data Set 0.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
//  StrWritingDataSet2 = '  Writing Data Set 2.';
//  StrWritingDataSets3and4 = '  Writing Data Sets 3 and 4.';
//  StrWritingDataSets5to7 = '  Writing Data Sets 5 to 7.';
  StrDrainElevationIsB = 'Drain elevation is below the bottom of the cell at' +
  ' the following locations.';
  StrLargeDrainElevatioDetailed = 'Large drain elevation gradient between %0:s and %' +
  '1:s. Amount: %2:g';
  StrLargeDrainElevatio = 'Large drain elevation gradient';
  StrHighDrainConductan = 'High Drain conductance compared to the cell-to-cell '
  + 'conductance may cause numerical difficulties';
  StrNegativeOrZeroDrainConductance = 'Transmissivity is negative or zero in cell containing a drain.';
//  StrLayerRowColumn = 'Layer, Row Column = %0:d, %1:d, %2:d';

{ TModflowDRN_Writer }

function TModflowDRN_Writer.CellType: TValueCellType;
begin
  result := TDrn_Cell;
end;

procedure TModflowDRN_Writer.CheckCell(ValueCell: TValueCell;
  const PackageName: string);
const
  HighConductanceContrast = 1E6;
var
  Drn_Cell: TDrn_Cell;
  ActiveDataArray: TDataArray;
  ScreenObject: TScreenObject;
  OtherCell: TDrn_Cell;
  CellBottomElevation: Real;
  AqCond: Double;
  Ratio: Extended;
  Delta: double;
  procedure CheckGradient;
  var
    DeltaDrnElevation: double;
    WarningMessage: string;
//    OtherCellBottomElevation: Real;
//    DeltaCellElevation: Real;
    Cell1: string;
    Cell2: string;
    Point1: TPoint2D;
    Point2: TPoint2D;
    Gradient: Extended;
  begin
    if OtherCell <> nil then
    begin
      DeltaDrnElevation := Abs(Drn_Cell.Elevation - OtherCell.Elevation);
      Point1 := Model.Grid.TwoDElementCenter(Drn_Cell.Column, Drn_Cell.Row);
      Point2 := Model.Grid.TwoDElementCenter(OtherCell.Column, OtherCell.Row);
      Gradient := DeltaDrnElevation/Distance(Point1, Point2);
//      OtherCellBottomElevation := Model.Grid.CellElevation[
//        OtherCell.Column, OtherCell.Row, OtherCell.Layer+1];
//      DeltaCellElevation := Abs(OtherCellBottomElevation - CellBottomElevation);
      if Gradient > HighGradient  then
      begin
        ScreenObject := Drn_Cell.ScreenObject as TScreenObject;
        Cell1 := Format(StrLayerRowColObject, [
          Drn_Cell.Layer+1, Drn_Cell.Row+1, Drn_Cell.Column+1, ScreenObject.Name]);
        ScreenObject := OtherCell.ScreenObject as TScreenObject;
        Cell2 := Format(StrLayerRowColObject, [
          OtherCell.Layer+1, OtherCell.Row+1, OtherCell.Column+1, ScreenObject.Name]);
        WarningMessage := Format(StrLargeDrainElevatioDetailed,
          [Cell1, Cell2, Gradient]);
        frmErrorsAndWarnings.AddWarning(Model, StrLargeDrainElevatio,
          WarningMessage, ScreenObject);
      end;
    end;
  end;
begin
  inherited;
  Drn_Cell := ValueCell as TDrn_Cell;
  if Length(FCells) = 0 then
  begin
    InitializeCells;
  end;
  FCells[Drn_Cell.Row, Drn_Cell.Column] := Drn_Cell;
  ActiveDataArray := Model.DataArrayManager.GetDataSetByName(rsActive);
  Assert(ActiveDataArray <> nil);
  CellBottomElevation := Model.Grid.CellElevation[
    Drn_Cell.Column, Drn_Cell.Row, Drn_Cell.Layer+1];
  if ActiveDataArray.BooleanData[Drn_Cell.Layer, Drn_Cell.Row, Drn_Cell.Column]
    then
  begin
    if (Drn_Cell.Elevation < CellBottomElevation) then
    begin
      Delta := CellBottomElevation - Drn_Cell.Elevation;
      ScreenObject := Drn_Cell.ScreenObject as TScreenObject;
      if Model.ModelSelection = msModflowNWT then
      begin
        frmErrorsAndWarnings.AddError(Model, StrDrainElevationIsB,
          Format(StrLayerRowColObjectAmount, [
          Drn_Cell.Layer+1, Drn_Cell.Row+1, Drn_Cell.Column+1, ScreenObject.Name, Delta]),
          ScreenObject);
      end
      else
      begin
        frmErrorsAndWarnings.AddWarning(Model, StrDrainElevationIsB,
          Format(StrLayerRowColObjectAmount, [
          Drn_Cell.Layer+1, Drn_Cell.Row+1, Drn_Cell.Column+1, ScreenObject.Name, Delta]),
          ScreenObject);
      end;
    end;
    AqCond := AquiferConductance(Drn_Cell.Layer, Drn_Cell.Row, Drn_Cell.Column);
    if AqCond > 0 then
    begin
      Ratio := Drn_Cell.Conductance/AqCond;
      if Ratio > HighConductanceContrast then
      begin
        ScreenObject := Drn_Cell.ScreenObject as TScreenObject;
        frmErrorsAndWarnings.AddWarning(Model,StrHighDrainConductan,
          Format(StrLayerRowColObjectAmount, [
          Drn_Cell.Layer+1, Drn_Cell.Row+1, Drn_Cell.Column+1, ScreenObject.Name, Ratio]),
          ScreenObject);
      end;
    end
    else
    begin
      ScreenObject := Drn_Cell.ScreenObject as TScreenObject;
      frmErrorsAndWarnings.AddWarning(Model,StrNegativeOrZeroDrainConductance,
        Format(StrLayerRowColObject, [
        Drn_Cell.Layer+1, Drn_Cell.Row+1, Drn_Cell.Column+1, ScreenObject.Name]),
        ScreenObject);
    end;
  end;
  if Drn_Cell.Row > 0 then
  begin
    OtherCell := FCells[Drn_Cell.Row-1,Drn_Cell.Column];
    CheckGradient;
  end;
  if Drn_Cell.Column > 0 then
  begin
    OtherCell := FCells[Drn_Cell.Row,Drn_Cell.Column-1];
    CheckGradient;
  end;
  if Drn_Cell.Row < Model.Grid.RowCount-1 then
  begin
    OtherCell := FCells[Drn_Cell.Row+1,Drn_Cell.Column];
    CheckGradient;
  end;
  if Drn_Cell.Column < Model.Grid.ColumnCount-1 then
  begin
    OtherCell := FCells[Drn_Cell.Row,Drn_Cell.Column+1];
    CheckGradient;
  end;
end;

procedure TModflowDRN_Writer.DoBeforeWriteCells;
begin
  inherited;
  InitializeCells;
end;

procedure TModflowDRN_Writer.Evaluate;
begin
    inherited;
end;

class function TModflowDRN_Writer.Extension: string;
begin
  result := '.drn';
end;

function TModflowDRN_Writer.GetBoundary(
  ScreenObject: TScreenObject): TModflowBoundary;
begin
  result := ScreenObject.ModflowDrnBoundary;
end;

class function TModflowDRN_Writer.ObservationExtension: string;
begin
  result := '.ob_drob';
end;

class function TModflowDRN_Writer.ObservationOutputExtension: string;
begin
  result := '.drob_out';
end;

function TModflowDRN_Writer.ObservationPackage: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.DrobPackage;
end;

function TModflowDRN_Writer.ObsNameWarningString: string;
begin
  result := StrTheFollowingDrain;
end;

function TModflowDRN_Writer.ObsTypeMF6: string;
begin
  result := ' drn';
end;

function TModflowDRN_Writer.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.DrnPackage;
end;

procedure TModflowDRN_Writer.WriteCell(Cell: TValueCell;
  const DataSetIdentifier, VariableIdentifiers: string);
var
  Drn_Cell: TDrn_Cell;
  LocalLayer: integer;
begin
  Drn_Cell := Cell as TDrn_Cell;
  LocalLayer := Model.
    DataSetLayerToModflowLayer(Drn_Cell.Layer);
  WriteInteger(LocalLayer);
  WriteInteger(Drn_Cell.Row+1);
  WriteInteger(Drn_Cell.Column+1);
  WriteFloat(Drn_Cell.Elevation);
  WriteFloat(Drn_Cell.Conductance);
  WriteIface(Drn_Cell.IFace);
  WriteBoundName(Drn_Cell);
  WriteString(' # ' + DataSetIdentifier + ' Layer Row Column Elevation '
    + VariableIdentifiers);

  NewLine;

end;

procedure TModflowDRN_Writer.WriteDataSet1;
begin
  CountParametersAndParameterCells(NPDRN, MXL);
  if NPDRN > 0 then
  begin
    WriteString('PARAMETER');
    WriteInteger(NPDRN);
    WriteInteger(MXL);
    WriteString(' # DataSet 1: PARAMETER NPDRN MXL');
    NewLine;
  end;
end;

procedure TModflowDRN_Writer.WriteDataSet2;
var
  MXACTD: integer;
  Option: String;
  IDRNCB: Integer;
begin
  CountCells(MXACTD);
  GetFlowUnitNumber(IDRNCB);
  GetOption(Option);

  WriteInteger(MXACTD);
  WriteInteger(IDRNCB);
  WriteString(Option);
  WriteString(' # DataSet 2: MXACTD IDRNCB');
  if Option <> '' then
  begin
    WriteString(' Option');
  end;
  NewLine
end;

function TModflowDRN_Writer.ParameterType: TParameterType;
begin
  result := ptDRN;
end;

procedure TModflowDRN_Writer.WriteDataSets3And4;
const
//  ErrorRoot = 'One or more %s parameters have been eliminated '
//    + 'because there are no cells associated with them.';
  DS3 = ' # Data Set 3: PARNAM PARTYP Parval NLST';
  DS3Instances = ' INSTANCES NUMINST';
  DS4A = ' # Data Set 4a: INSTNAM';
  DataSetIdentifier = 'Data Set 4b:';
  VariableIdentifiers = 'Condfact IFACE';
begin
  WriteParameterDefinitions(DS3, DS3Instances, DS4A, DataSetIdentifier,
    VariableIdentifiers, StrOneOrMoreSParam, umAssign, nil, nil);
end;

procedure TModflowDRN_Writer.WriteDataSets5To7;
const
  D7PName =      ' # Data Set 7: PARNAM';
  D7PNameIname = ' # Data Set 7: PARNAM Iname';
  DS5 = ' # Data Set 5: ITMP NP';
  DataSetIdentifier = 'Data Set 6:';
  VariableIdentifiers = 'Cond IFACE';
var
  VI: string;
begin
  VI := VariableIdentifiers;
  if Model.modelSelection = msModflow2015 then
  begin
    VI := VI + ' boundname';
  end;
  WriteStressPeriods(VI, DataSetIdentifier, DS5,
    D7PNameIname, D7PName);
end;

procedure TModflowDRN_Writer.WriteFile(const AFileName: string);
var
  NameOfFile: string;
  ShouldWriteFile: Boolean;
  ShouldWriteObservationFile: Boolean;
  Abbreviation: string;
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrDrainElevationIsB);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrDrainElevationIsB);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrLargeDrainElevatio);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrHighDrainConductan);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrNegativeOrZeroDrainConductance);
    if not Package.IsSelected then
    begin
      Exit
    end;
    if Model.ModelSelection = msModflow2015 then
    begin
      Abbreviation := 'DRN8';
    end
    else
    begin
      Abbreviation := StrDRN;
    end;
    ShouldWriteFile := not Model.PackageGeneratedExternally(Abbreviation);
    ShouldWriteObservationFile := ObservationPackage.IsSelected
      and not Model.PackageGeneratedExternally(StrDROB);

    if not ShouldWriteFile and not ShouldWriteObservationFile then
    begin
      Exit;
    end;

    NameOfFile := FileName(AFileName);
    FFileName := NameOfFile;
    if ShouldWriteFile then
    begin
      WriteToNameFile(Abbreviation, Model.UnitNumbers.UnitNumber(StrDRN),
        NameOfFile, foInput, Model);
    end;
    if ShouldWriteFile or ShouldWriteObservationFile then
    begin
      Evaluate;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      ClearTimeLists(Model);
    end;
    if not ShouldWriteFile then
    begin
      Exit;
    end;
    OpenFile(FileName(AFileName));
    try
      frmProgressMM.AddMessage(StrWritingDRNPackage);
      frmProgressMM.AddMessage(StrWritingDataSet0);
      WriteDataSet0;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      if Model.ModelSelection = msModflow2015 then
      begin
        frmProgressMM.AddMessage('  Writing Options');
        WriteOptionsMF6;
        Application.ProcessMessages;
        if not frmProgressMM.ShouldContinue then
        begin
          Exit;
        end;

        frmProgressMM.AddMessage('  Writing Dimensions');
        WriteDimensionsMF6;
        Application.ProcessMessages;
        if not frmProgressMM.ShouldContinue then
        begin
          Exit;
        end;
      end
      else
      begin
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
      end;

      if Model.ModelSelection <> msModflow2015 then
      begin
        frmProgressMM.AddMessage(StrWritingDataSets3and4);
        WriteDataSets3And4;
        if not frmProgressMM.ShouldContinue then
        begin
          Exit;
        end;
      end;

      frmProgressMM.AddMessage(StrWritingDataSets5to7);
      WriteDataSets5To7;
    finally
      CloseFile;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

procedure TModflowDRN_Writer.WriteFluxObservationFile(const AFileName: string;
  Purpose: TObservationPurpose);
const
  DataSet1Comment = ' # Data Set 1: NQDR NQCDR NQTDR IUDROBSV';
  DataSet2Comment = ' # Data Set 2: TOMULTDR';
  DataSet3Comment = ' # Data Set 3: NQOBDR NQCLDR';
  PackageAbbreviation = StrDROB;
begin
  if Model.ModelSelection <> msModflow2015 then
  begin
    WriteFluxObsFile(AFileName, StrIUDROBSV, PackageAbbreviation,
      DataSet1Comment, DataSet2Comment, DataSet3Comment,
      Model.DrainObservations, Purpose);
  end
  else
  begin
    WriteFluxObsFileMF6(AFileName, StrIUDROBSV, PackageAbbreviation,
      DataSet1Comment, DataSet2Comment, DataSet3Comment,
      Model.DrainObservations, Purpose);
  end;
end;

procedure TModflowDRN_Writer.InitializeCells;
var
  RowIndex: Integer;
  ColIndex: Integer;
begin
  SetLength(FCells, Model.Grid.RowCount, Model.Grid.ColumnCount);
  for RowIndex := 0 to Model.Grid.RowCount - 1 do
  begin
    for ColIndex := 0 to Model.Grid.ColumnCount - 1 do
    begin
      FCells[RowIndex, ColIndex] := nil;
    end;
  end;
end;

procedure TModflowDRN_Writer.WriteParameterCells(CellList: TValueCellList;
  NLST: Integer; const VariableIdentifiers, DataSetIdentifier: string;
  AssignmentMethod: TUpdateMethod; MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection);
var
  Cell: TDrn_Cell;
  CellIndex: Integer;
begin
  // Data set 4b
  InitializeCells;
  for CellIndex := 0 to CellList.Count - 1 do
  begin
    Cell := CellList[CellIndex] as TDrn_Cell;
    WriteCell(Cell, DataSetIdentifier, VariableIdentifiers);
    CheckCell(Cell, 'DRN');
  end;
  // Dummy inactive cells to fill out data set 4b.
  // Each instance of a parameter is required to have the same
  // number of cells.  This introduces dummy boundaries to fill
  // out the list.  because Condfact is set equal to zero, the
  // dummy boundaries have no effect.
  for CellIndex := CellList.Count to NLST - 1 do
  begin
    WriteInteger(1);
    WriteInteger(1);
    WriteInteger(1);
    WriteFloat(0);
    WriteFloat(0);
    WriteInteger(0);
    WriteString(
      ' # Data Set 4b: Layer Row Column Stage Condfact IFACE (Dummy boundary)');
    NewLine;
  end;
end;

end.
