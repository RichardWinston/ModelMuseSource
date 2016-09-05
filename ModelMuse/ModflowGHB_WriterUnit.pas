unit ModflowGHB_WriterUnit;

interface

uses SysUtils, Classes, Contnrs, CustomModflowWriterUnit, ModflowGhbUnit,
  PhastModelUnit, ScreenObjectUnit, ModflowBoundaryUnit, ModflowCellUnit,
  ModflowPackageSelectionUnit, OrderedCollectionUnit, GoPhastTypes,
  ModflowBoundaryDisplayUnit, ModflowTransientListParameterUnit;

type
  TModflowGHB_Writer = class(TFluxObsWriter)
  private
    NPGHB: integer;
    MXL: integer;
    FCells: array of array of TGhb_Cell;
    procedure WriteDataSet1;
    procedure WriteDataSet2;
    procedure WriteDataSets3And4;
    procedure WriteDataSets5To7;
    procedure InitializeCells;
  protected
    function ObservationPackage: TModflowPackageSelection; override;
    function CellType: TValueCellType; override;
    class function Extension: string; override;
    function GetBoundary(ScreenObject: TScreenObject): TModflowBoundary;
      override;
    function Package: TModflowPackageSelection; override;
    function ParameterType: TParameterType; override;
    procedure WriteParameterCells(CellList: TValueCellList; NLST: Integer;
      const VariableIdentifiers, DataSetIdentifier: string;
      AssignmentMethod: TUpdateMethod; MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection); override;
    procedure WriteCell(Cell: TValueCell;
      const DataSetIdentifier, VariableIdentifiers: string); override;
    class function ObservationExtension: string; override;
    class function ObservationOutputExtension: string; override;
    function ObsNameWarningString: string; override;
    procedure CheckCell(ValueCell: TValueCell; const PackageName: string); override;
    procedure DoBeforeWriteCells; override;
    function ObsTypeMF6: string; override;
  public
    procedure WriteFile(const AFileName: string);
    procedure WriteFluxObservationFile(const AFileName: string;
      Purpose: TObservationPurpose);
  end;

implementation

uses ModflowTimeUnit, frmErrorsAndWarningsUnit, ModflowUnitNumbers, 
  frmProgressUnit, Forms, DataSetUnit, FastGEO;

resourcestring
  StrTheFollowingGHBOb = 'The following GHB observation names may be valid f' +
  'or MODFLOW but they are not valid for UCODE.';
  StrWritingGHBPackage = 'Writing GHB Package input.';
//  StrWritingDataSet0 = '  Writing Data Set 0.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
//  StrWritingDataSet2 = '  Writing Data Set 2.';
//  StrWritingDataSets3and4 = '  Writing Data Sets 3 and 4.';
//  StrWritingDataSets5to7 = '  Writing Data Sets 5 to 7.';
  StrGHBBoundaryHeadIs = 'GHB Boundary head is below the bottom of the cell ' +
  'at the following locations.';
  StrLargeGHBBoundaryHDetailed = 'Large GHB boundary head gradient between %' +
  '0:s and %1:s. Gradient := %2:g';
  StrLargeGHBBoundaryH = 'Large GHB boundary head gradient';
  StrHighGHBConductance = 'High GHB conductance compared to the cell-to-cell' +
  ' conductance may cause numerical difficulties';
  StrZeroGHBConductance = 'Transmissivity is negative or zero in cell containing a general-head boundary';

{ TModflowGHB_Writer }

function TModflowGHB_Writer.CellType: TValueCellType;
begin
  result := TGhb_Cell;
end;

procedure TModflowGHB_Writer.CheckCell(ValueCell: TValueCell;
  const PackageName: string);
const
  HighConductanceContrast = 1E6;
var
  Ghb_Cell: TGhb_Cell;
  ActiveDataArray: TDataArray;
  ScreenObject: TScreenObject;
  OtherCell: TGhb_Cell;
  CellBottomElevation: double;
  AqCond: Double;
  Ratio: Extended;
  procedure CheckGradient;
  var
    DeltaGhbElevation: double;
//    OtherCellBottomElevation: Real;
//    DeltaCellElevation: double;
    Cell1: string;
    Cell2: string;
    WarningMessage: string;
    Point1: TPoint2D;
    Point2: TPoint2D;
    Gradient: Extended;
  begin
    if OtherCell <> nil then
    begin
      DeltaGhbElevation := Abs(Ghb_Cell.BoundaryHead - OtherCell.BoundaryHead);
      Point1 := Model.Grid.TwoDElementCenter(Ghb_Cell.Column, Ghb_Cell.Row);
      Point2 := Model.Grid.TwoDElementCenter(OtherCell.Column, OtherCell.Row);
      Gradient := DeltaGhbElevation/Distance(Point1, Point2);
//      OtherCellBottomElevation := Model.Grid.CellElevation[
//        OtherCell.Column, OtherCell.Row, OtherCell.Layer+1];
//      DeltaCellElevation := Abs(OtherCellBottomElevation - CellBottomElevation);
      if Gradient > HighGradient then
      begin
        ScreenObject := Ghb_Cell.ScreenObject as TScreenObject;
        Cell1 := Format(StrLayerRowColObject, [
          Ghb_Cell.Layer+1, Ghb_Cell.Row+1, Ghb_Cell.Column+1, ScreenObject.Name]);
        ScreenObject := OtherCell.ScreenObject as TScreenObject;
        Cell2 := Format(StrLayerRowColObject, [
          OtherCell.Layer+1, OtherCell.Row+1, OtherCell.Column+1, ScreenObject.Name]);
        WarningMessage := Format(StrLargeGHBBoundaryHDetailed,
          [Cell1, Cell2, Gradient]);
        frmErrorsAndWarnings.AddWarning(Model, StrLargeGHBBoundaryH,
          WarningMessage, ScreenObject);
      end;
    end;
  end;
begin
  inherited;
  Ghb_Cell := ValueCell as TGhb_Cell;
  if Length(FCells) = 0 then
  begin
    InitializeCells;
  end;
  FCells[Ghb_Cell.Row, Ghb_Cell.Column] := Ghb_Cell;
  ActiveDataArray := Model.DataArrayManager.GetDataSetByName(rsActive);
  Assert(ActiveDataArray <> nil);
  CellBottomElevation := Model.Grid.CellElevation[
    Ghb_Cell.Column, Ghb_Cell.Row, Ghb_Cell.Layer+1];
  if ActiveDataArray.BooleanData[Ghb_Cell.Layer, Ghb_Cell.Row, Ghb_Cell.Column]
    then
  begin
    if (Ghb_Cell.BoundaryHead < CellBottomElevation) then
    begin
      ScreenObject := Ghb_Cell.ScreenObject as TScreenObject;
      if Model.ModelSelection = msModflowNWT then
      begin
        frmErrorsAndWarnings.AddError(Model, StrGHBBoundaryHeadIs,
          Format(StrLayerRowColObject, [
          Ghb_Cell.Layer+1, Ghb_Cell.Row+1, Ghb_Cell.Column+1, ScreenObject.Name]),
          ScreenObject);
      end
      else
      begin
        frmErrorsAndWarnings.AddWarning(Model, StrGHBBoundaryHeadIs,
          Format(StrLayerRowColObject, [
          Ghb_Cell.Layer+1, Ghb_Cell.Row+1, Ghb_Cell.Column+1, ScreenObject.Name]),
          ScreenObject);
      end;
    end;
    AqCond := AquiferConductance(Ghb_Cell.Layer, Ghb_Cell.Row, Ghb_Cell.Column);
    if AqCond > 0 then
    begin
      Ratio := Ghb_Cell.Conductance/AqCond;
      if Ratio > HighConductanceContrast then
      begin
        ScreenObject := Ghb_Cell.ScreenObject as TScreenObject;
        frmErrorsAndWarnings.AddWarning(Model,StrHighGHBConductance,
          Format(StrLayerRowColObject, [
          Ghb_Cell.Layer+1, Ghb_Cell.Row+1, Ghb_Cell.Column+1, ScreenObject.Name]),
          ScreenObject);
      end;
    end
    else
    begin
      ScreenObject := Ghb_Cell.ScreenObject as TScreenObject;
      frmErrorsAndWarnings.AddWarning(Model,StrZeroGHBConductance,
        Format(StrLayerRowColObject, [
        Ghb_Cell.Layer+1, Ghb_Cell.Row+1, Ghb_Cell.Column+1, ScreenObject.Name]),
        ScreenObject);
    end;
  end;
  if Ghb_Cell.Row > 0 then
  begin
    OtherCell := FCells[Ghb_Cell.Row-1,Ghb_Cell.Column];
    CheckGradient;
  end;
  if Ghb_Cell.Column > 0 then
  begin
    OtherCell := FCells[Ghb_Cell.Row,Ghb_Cell.Column-1];
    CheckGradient;
  end;
  if Ghb_Cell.Row < Model.Grid.RowCount-1 then
  begin
    OtherCell := FCells[Ghb_Cell.Row+1,Ghb_Cell.Column];
    CheckGradient;
  end;
  if Ghb_Cell.Column < Model.Grid.ColumnCount-1 then
  begin
    OtherCell := FCells[Ghb_Cell.Row,Ghb_Cell.Column+1];
    CheckGradient;
  end;
end;

procedure TModflowGHB_Writer.DoBeforeWriteCells;
begin
  inherited;
  InitializeCells;
end;

class function TModflowGHB_Writer.Extension: string;
begin
  result := '.ghb';
end;

function TModflowGHB_Writer.GetBoundary(
  ScreenObject: TScreenObject): TModflowBoundary;
begin
  result := ScreenObject.ModflowGhbBoundary;
end;

class function TModflowGHB_Writer.ObservationExtension: string;
begin
  result := '.ob_gbob';
end;

class function TModflowGHB_Writer.ObservationOutputExtension: string;
begin
  result := '.gbob_out';
end;

function TModflowGHB_Writer.ObservationPackage: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.GbobPackage;
end;

function TModflowGHB_Writer.ObsNameWarningString: string;
begin
  result := StrTheFollowingGHBOb;
end;

function TModflowGHB_Writer.ObsTypeMF6: string;
begin
  result := ' ghb'
end;

function TModflowGHB_Writer.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.GhbBoundary;
end;

function TModflowGHB_Writer.ParameterType: TParameterType;
begin
  result := ptGHB;
end;

procedure TModflowGHB_Writer.WriteCell(Cell: TValueCell;
  const DataSetIdentifier, VariableIdentifiers: string);
var
  GHB_Cell: TGhb_Cell;
  LocalLayer: integer;
begin
  GHB_Cell := Cell as TGhb_Cell;
  LocalLayer := Model.
    DataSetLayerToModflowLayer(GHB_Cell.Layer);
  WriteInteger(LocalLayer);
  WriteInteger(GHB_Cell.Row+1);
  WriteInteger(GHB_Cell.Column+1);
  WriteFloat(GHB_Cell.BoundaryHead);
  WriteFloat(GHB_Cell.Conductance);
  WriteIface(GHB_Cell.IFace);
  WriteBoundName(GHB_Cell);
  WriteString(' # ' + DataSetIdentifier + ' Layer Row Column Bhead '
    + VariableIdentifiers);

  NewLine;
end;

procedure TModflowGHB_Writer.WriteDataSet1;
begin
  CountParametersAndParameterCells(NPGHB, MXL);
  if NPGHB > 0 then
  begin
    WriteString('PARAMETER');
    WriteInteger(NPGHB);
    WriteInteger(MXL);
    WriteString(' # DataSet 1: PARAMETER NPGHB MXL');
    NewLine;
  end;
end;

procedure TModflowGHB_Writer.WriteDataSet2;
var
  MXACTC: integer;
  Option: String;
  IGHBCB: Integer;
begin
  CountCells(MXACTC);
  GetFlowUnitNumber(IGHBCB);
  GetOption(Option);

  WriteInteger(MXACTC);
  WriteInteger(IGHBCB);
  WriteString(Option);
  WriteString(' # DataSet 2: MXACTC IGHBCB');
  if Option <> '' then
  begin
    WriteString(' Option');
  end;
  NewLine
end;

procedure TModflowGHB_Writer.WriteDataSets3And4;
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

procedure TModflowGHB_Writer.WriteDataSets5To7;
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

procedure TModflowGHB_Writer.WriteFile(const AFileName: string);
var
  NameOfFile: string;
  ShouldWriteFile: Boolean;
  ShouldWriteObservationFile: Boolean;
  Abbreviation: string;
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveWarningGroup(Model,StrHighGHBConductance);
    frmErrorsAndWarnings.RemoveWarningGroup(Model,StrLargeGHBBoundaryH);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrGHBBoundaryHeadIs);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrGHBBoundaryHeadIs);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrZeroGHBConductance);

    if not Package.IsSelected then
    begin
      Exit
    end;
    if Model.ModelSelection = msModflow2015 then
    begin
      Abbreviation := 'GHB8';
    end
    else
    begin
      Abbreviation := StrGHB;
    end;
    ShouldWriteFile := not Model.PackageGeneratedExternally(Abbreviation);
    ShouldWriteObservationFile := ObservationPackage.IsSelected
      and not Model.PackageGeneratedExternally(StrGBOB);

    if not ShouldWriteFile and not ShouldWriteObservationFile then
    begin
      Exit;
    end;
    NameOfFile := FileName(AFileName);
    FFileName := NameOfFile;
    if ShouldWriteFile then
    begin
      WriteToNameFile(Abbreviation, Model.UnitNumbers.UnitNumber(StrGHB),
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
      frmProgressMM.AddMessage(StrWritingGHBPackage);
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
        Application.ProcessMessages;
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

procedure TModflowGHB_Writer.WriteFluxObservationFile(const AFileName: string;
  Purpose: TObservationPurpose);
const
  DataSet1Comment = ' # Data Set 1: NQGB NQCGB NQTGB IUGBOBSV';
  DataSet2Comment = ' # Data Set 2: TOMULTGB';
  DataSet3Comment = ' # Data Set 3: NQOBGB NQCLGB';
  PackageAbbreviation = StrGBOB;
begin
  if Model.ModelSelection <> msModflow2015 then
  begin
    WriteFluxObsFile(AFileName, StrIUGBOBSV, PackageAbbreviation,
      DataSet1Comment, DataSet2Comment, DataSet3Comment,
      Model.GhbObservations, Purpose);
  end
  else
  begin
    WriteFluxObsFileMF6(AFileName, StrIUGBOBSV, PackageAbbreviation,
      DataSet1Comment, DataSet2Comment, DataSet3Comment,
      Model.GhbObservations, Purpose);
  end;
end;

procedure TModflowGHB_Writer.InitializeCells;
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

procedure TModflowGHB_Writer.WriteParameterCells(CellList: TValueCellList;
  NLST: Integer; const VariableIdentifiers, DataSetIdentifier: string;
  AssignmentMethod: TUpdateMethod; MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection);
var
  Cell: TGhb_Cell;
  CellIndex: Integer;
begin
  // Data set 4b
  InitializeCells;
  for CellIndex := 0 to CellList.Count - 1 do
  begin
    Cell := CellList[CellIndex] as TGhb_Cell;
    WriteCell(Cell, DataSetIdentifier, VariableIdentifiers);
    CheckCell(Cell, 'GHB');
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
      ' # Data Set 4b: Layer Row Column Bhead Condfact IFACE (Dummy boundary)');
    NewLine;
  end;
end;

end.
