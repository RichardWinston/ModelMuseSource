unit ModflowRiverWriterUnit;

interface

uses SysUtils, Classes, Contnrs, CustomModflowWriterUnit, ModflowRivUnit,
  PhastModelUnit, ScreenObjectUnit, ModflowBoundaryUnit, ModflowCellUnit,
  ModflowPackageSelectionUnit, OrderedCollectionUnit, GoPhastTypes;

type
  TModflowRIV_Writer = class(TFluxObsWriter)
  private
    NPRIV: integer;
    MXL: integer;
    FCells: array of array of TRiv_Cell;
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

uses ModflowTimeUnit, frmErrorsAndWarningsUnit,
  ModflowTransientListParameterUnit, ModflowUnitNumbers, frmProgressUnit, Forms,
  DataSetUnit, FastGEO;

resourcestring
  StrInTheFollowingRiv = 'In the following river cells, the stage is equal to or below t' +
  'he river bottom.';
  StrLayerDRowDC = 'Layer: %0:d, Row %1:d, Column %2:d. Amount: %3:g.';
  StrTheFollowingRiver = 'The following River observation names may be valid' +
  ' for MODFLOW but they are not valid for UCODE.';
  StrWritingRIVPackage = 'Writing RIV Package input.';
//  StrWritingDataSet0 = '  Writing Data Set 0.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
//  StrWritingDataSet2 = '  Writing Data Set 2.';
//  StrWritingDataSets3and4 = '  Writing Data Sets 3 and 4.';
//  StrWritingDataSets5to7 = '  Writing Data Sets 5 to 7.';
  StrRiverStageIsBelow = 'River stage is below the bottom of the cell at the' +
  ' following locations.';
  StrRiverBottomIsBelo = 'River bottom is below the bottom of the cell at th' +
  'e following locations.';
  StrRiverStageIsBelowBottom = 'River stage is below the river bottom at the' +
  ' following locations.';
  StrLargeRiverStageGrDetailed = 'Large river stage gradient between %0:s an' +
  'd %1:s. Amount: %2:g';
  StrLargeRiverStageGr = 'Large river stage gradient';
  StrHighRiverConductan = 'High River conductance compared to the cell-to-ce' +
  'll conductance may cause numerical difficulties';
  StrZeroRiverConductan = 'Transmissivity is negative or zero in cell containing a River';
  StrWritingOptions = '  Writing Options';
  StrWritingDimensions = '  Writing Dimensions';

{ TModflowRIV_Writer }

function TModflowRIV_Writer.CellType: TValueCellType;
begin
  result := TRiv_Cell;
end;

procedure TModflowRIV_Writer.CheckCell(ValueCell: TValueCell;
  const PackageName: string);
const
  HighConductanceContrast = 1E6;
var
  Riv_Cell: TRiv_Cell;
  ActiveDataArray: TDataArray;
  ScreenObject: TScreenObject;
  OtherCell: TRiv_Cell;
  CellBottomElevation: Real;
  AqCond: Double;
  Ratio: Extended;
  Delta: double;
  procedure CheckGradient;
  var
    DeltaRivElevation: double;
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
      DeltaRivElevation := Abs(Riv_Cell.RiverStage - OtherCell.RiverStage);
      Point1 := Model.Grid.TwoDElementCenter(Riv_Cell.Column, Riv_Cell.Row);
      Point2 := Model.Grid.TwoDElementCenter(OtherCell.Column, OtherCell.Row);
      Gradient := DeltaRivElevation/Distance(Point1, Point2);
//      OtherCellBottomElevation := Model.Grid.CellElevation[
//        OtherCell.Column, OtherCell.Row, OtherCell.Layer+1];
//      DeltaCellElevation := Abs(OtherCellBottomElevation - CellBottomElevation);
      if Gradient > HighGradient then
      begin
        ScreenObject := Riv_Cell.ScreenObject as TScreenObject;
        Cell1 := Format(StrLayerRowColObject, [
          Riv_Cell.Layer+1, Riv_Cell.Row+1, Riv_Cell.Column+1, ScreenObject.Name]);
        ScreenObject := OtherCell.ScreenObject as TScreenObject;
        Cell2 := Format(StrLayerRowColObject, [
          OtherCell.Layer+1, OtherCell.Row+1, OtherCell.Column+1, ScreenObject.Name]);
        WarningMessage := Format(StrLargeRiverStageGrDetailed,
          [Cell1, Cell2, Gradient]);
        frmErrorsAndWarnings.AddWarning(Model, StrLargeRiverStageGr,
          WarningMessage, ScreenObject);
      end;
    end;
  end;
begin
  inherited;
  Riv_Cell := ValueCell as TRiv_Cell;
  if Length(FCells) = 0 then
  begin
    InitializeCells;
  end;
  FCells[Riv_Cell.Row, Riv_Cell.Column] := Riv_Cell;
  ActiveDataArray := Model.DataArrayManager.GetDataSetByName(rsActive);
  Assert(ActiveDataArray <> nil);
  CellBottomElevation := Model.Grid.CellElevation[
    Riv_Cell.Column, Riv_Cell.Row, Riv_Cell.Layer+1];
  if ActiveDataArray.BooleanData[Riv_Cell.Layer, Riv_Cell.Row, Riv_Cell.Column] then
  begin
    if (Riv_Cell.RiverStage < CellBottomElevation) then
    begin
      Delta := CellBottomElevation-Riv_Cell.RiverStage;
      ScreenObject := Riv_Cell.ScreenObject as TScreenObject;
      if Model.ModelSelection = msModflowNWT then
      begin
        frmErrorsAndWarnings.AddError(Model, StrRiverStageIsBelow,
          Format(StrLayerRowColObjectAmount, [
          Riv_Cell.Layer+1, Riv_Cell.Row+1, Riv_Cell.Column+1, ScreenObject.Name, Delta]),
          ScreenObject);
      end
      else
      begin
        frmErrorsAndWarnings.AddWarning(Model, StrRiverStageIsBelow,
          Format(StrLayerRowColObjectAmount, [
          Riv_Cell.Layer+1, Riv_Cell.Row+1, Riv_Cell.Column+1, ScreenObject.Name, Delta]),
          ScreenObject);
      end;
    end;

    if (Riv_Cell.RiverBottom < Model.Grid.CellElevation[
      Riv_Cell.Column, Riv_Cell.Row, Riv_Cell.Layer+1]) then
    begin
      Delta := Model.Grid.CellElevation[
        Riv_Cell.Column, Riv_Cell.Row, Riv_Cell.Layer+1]
        - Riv_Cell.RiverBottom;
      ScreenObject := Riv_Cell.ScreenObject as TScreenObject;
      if Model.ModelSelection = msModflowNWT then
      begin
        frmErrorsAndWarnings.AddError(Model, StrRiverBottomIsBelo,
          Format(StrLayerRowColObjectAmount, [
          Riv_Cell.Layer+1, Riv_Cell.Row+1, Riv_Cell.Column+1, ScreenObject.Name, Delta]),
          ScreenObject);
      end
      else
      begin
        frmErrorsAndWarnings.AddWarning(Model, StrRiverBottomIsBelo,
          Format(StrLayerRowColObjectAmount, [
          Riv_Cell.Layer+1, Riv_Cell.Row+1, Riv_Cell.Column+1, ScreenObject.Name, Delta]),
          ScreenObject);
      end;
    end;

    if Riv_Cell.RiverStage <= Riv_Cell.RiverBottom then
    begin
      Delta := Riv_Cell.RiverBottom - Riv_Cell.RiverStage;
      ScreenObject := Riv_Cell.ScreenObject as TScreenObject;
      frmErrorsAndWarnings.AddError(Model, StrRiverStageIsBelowBottom,
        Format(StrLayerRowColObjectAmount, [
        Riv_Cell.Layer+1, Riv_Cell.Row+1, Riv_Cell.Column+1, ScreenObject.Name, Delta]),
        ScreenObject);
    end;

    AqCond := AquiferConductance(Riv_Cell.Layer, Riv_Cell.Row, Riv_Cell.Column);
    if AqCond > 0 then
    begin
      Ratio := Riv_Cell.Conductance/AqCond;
      if Ratio > HighConductanceContrast then
      begin
        ScreenObject := Riv_Cell.ScreenObject as TScreenObject;
        frmErrorsAndWarnings.AddWarning(Model,StrHighRiverConductan,
          Format(StrLayerRowColObjectAmount, [
          Riv_Cell.Layer+1, Riv_Cell.Row+1, Riv_Cell.Column+1, ScreenObject.Name, Ratio]),
          ScreenObject);
      end;
    end
    else
    begin
      ScreenObject := Riv_Cell.ScreenObject as TScreenObject;
      frmErrorsAndWarnings.AddWarning(Model,StrZeroRiverConductan,
        Format(StrLayerRowColObject, [
        Riv_Cell.Layer+1, Riv_Cell.Row+1, Riv_Cell.Column+1, ScreenObject.Name]),
        ScreenObject);
    end;
  end;
  if Riv_Cell.Row > 0 then
  begin
    OtherCell := FCells[Riv_Cell.Row-1,Riv_Cell.Column];
    CheckGradient;
  end;
  if Riv_Cell.Column > 0 then
  begin
    OtherCell := FCells[Riv_Cell.Row,Riv_Cell.Column-1];
    CheckGradient;
  end;
  if Riv_Cell.Row < Model.Grid.RowCount-1 then
  begin
    OtherCell := FCells[Riv_Cell.Row+1,Riv_Cell.Column];
    CheckGradient;
  end;
  if Riv_Cell.Column < Model.Grid.ColumnCount-1 then
  begin
    OtherCell := FCells[Riv_Cell.Row,Riv_Cell.Column+1];
    CheckGradient;
  end;
end;

procedure TModflowRIV_Writer.DoBeforeWriteCells;
begin
  inherited;
  InitializeCells;
end;

class function TModflowRIV_Writer.Extension: string;
begin
  result := '.riv';
end;

function TModflowRIV_Writer.GetBoundary(
  ScreenObject: TScreenObject): TModflowBoundary;
begin
  result := ScreenObject.ModflowRivBoundary;
end;

class function TModflowRIV_Writer.ObservationExtension: string;
begin
  result := '.ob_rvob';
end;

class function TModflowRIV_Writer.ObservationOutputExtension: string;
begin
  result := '.rvob_out';
end;

function TModflowRIV_Writer.ObservationPackage: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.RvobPackage;
end;

function TModflowRIV_Writer.ObsNameWarningString: string;
begin
  result := StrTheFollowingRiver;
end;

function TModflowRIV_Writer.ObsTypeMF6: string;
begin
  result := ' riv';
end;

function TModflowRIV_Writer.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.RivPackage;
end;

procedure TModflowRIV_Writer.WriteCell(Cell: TValueCell;
  const DataSetIdentifier, VariableIdentifiers: string);
var
  Riv_Cell: TRiv_Cell;
  LocalLayer: integer;
  ScreenObject: TScreenObject;
  Delta: double;
begin
  Riv_Cell := Cell as TRiv_Cell;
  LocalLayer := Model.
    DataSetLayerToModflowLayer(Riv_Cell.Layer);
  WriteInteger(LocalLayer);
  WriteInteger(Riv_Cell.Row+1);
  WriteInteger(Riv_Cell.Column+1);
  WriteFloat(Riv_Cell.RiverStage);
  WriteFloat(Riv_Cell.Conductance);
  WriteFloat(Riv_Cell.RiverBottom);
  WriteIface(Riv_Cell.IFace);
  WriteBoundName(Riv_Cell);
  WriteString(' # ' + DataSetIdentifier + ' Layer Row Column Stage '
    + VariableIdentifiers);
//  WriteString(' ' + Riv_Cell.ConductanceAnnotation);
  NewLine;
  if Riv_Cell.RiverStage <= Riv_Cell.RiverBottom then
  begin
    Delta := Riv_Cell.RiverBottom - Riv_Cell.RiverStage;
    ScreenObject := Riv_Cell.ScreenObject as TScreenObject;
    if Model.ModelSelection = msModflowNWT then
    begin
      frmErrorsAndWarnings.AddError(Model, StrInTheFollowingRiv,
        Format(StrLayerRowColObjectAmount, [Riv_Cell.Layer+1, Riv_Cell.Row+1,
        Riv_Cell.Column+1, ScreenObject.Name, Delta]), ScreenObject);
    end
    else
    begin
      frmErrorsAndWarnings.AddWarning(Model, StrInTheFollowingRiv,
        Format(StrLayerRowColObjectAmount, [Riv_Cell.Layer+1, Riv_Cell.Row+1,
        Riv_Cell.Column+1, ScreenObject.Name, Delta]), ScreenObject);
    end;
  end;
end;

procedure TModflowRIV_Writer.WriteDataSet1;
begin
  CountParametersAndParameterCells(NPRIV, MXL);
  if NPRIV > 0 then
  begin
    WriteString('PARAMETER');
    WriteInteger(NPRIV);
    WriteInteger(MXL);
    WriteString(' # DataSet 1: PARAMETER NPRIV MXL');
    NewLine;
  end;
end;

procedure TModflowRIV_Writer.WriteDataSet2;
var
  MXACTC: integer;
  Option: String;
  IRIVCB: Integer;
begin
  CountCells(MXACTC);
  GetFlowUnitNumber(IRIVCB);
  GetOption(Option);

  WriteInteger(MXACTC);
  WriteInteger(IRIVCB);
  WriteString(Option);
  WriteString(' # DataSet 2: MXACTC IRIVCB');
  if Option <> '' then
  begin
    WriteString(' Option');
  end;
  NewLine
end;

function TModflowRIV_Writer.ParameterType: TParameterType;
begin
  result := ptRIV;
end;

procedure TModflowRIV_Writer.WriteDataSets3And4;
const
  ErrorRoot = 'One or more %s parameters have been eliminated '
    + 'because there are no cells associated with them.';
  DS3 = ' # Data Set 3: PARNAM PARTYP Parval NLST';
  DS3Instances = ' INSTANCES NUMINST';
  DS4A = ' # Data Set 4a: INSTNAM';
  DataSetIdentifier = 'Data Set 4b:';
  VariableIdentifiers = 'Condfact Rbot IFACE';
begin
  WriteParameterDefinitions(DS3, DS3Instances, DS4A, DataSetIdentifier,
    VariableIdentifiers, ErrorRoot, umAssign, nil, nil);
end;

procedure TModflowRIV_Writer.WriteDataSets5To7;
const
  D7PName =      ' # Data Set 7: PARNAM';
  D7PNameIname = ' # Data Set 7: PARNAM Iname';
  DS5 = ' # Data Set 5: ITMP NP';
  DataSetIdentifier = 'Data Set 6:';
  VariableIdentifiers = 'Cond Rbot IFACE';
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

procedure TModflowRIV_Writer.WriteFile(const AFileName: string);
var
  NameOfFile: string;
  ShouldWriteFile: Boolean;
  ShouldWriteObservationFile: Boolean;
  Abbreviation: string;
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrRiverStageIsBelow);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrRiverStageIsBelow);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrRiverBottomIsBelo);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrRiverBottomIsBelo);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrLargeRiverStageGr);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrHighRiverConductan);

    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrInTheFollowingRiv);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrInTheFollowingRiv);
    if not Package.IsSelected then
    begin
      Exit
    end;
    if Model.ModelSelection = msModflow2015 then
    begin
      Abbreviation := 'RIV8';
    end
    else
    begin
      Abbreviation := StrRIV;
    end;
    ShouldWriteFile := not Model.PackageGeneratedExternally(Abbreviation);
    ShouldWriteObservationFile := ObservationPackage.IsSelected
      and not Model.PackageGeneratedExternally(StrRVOB);

    if not ShouldWriteFile and not ShouldWriteObservationFile then
    begin
      Exit;
    end;
    NameOfFile := FileName(AFileName);
    FFileName := NameOfFile;
    if ShouldWriteFile then
    begin
      WriteToNameFile(Abbreviation, Model.UnitNumbers.UnitNumber(StrRIV),
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
    OpenFile(NameOfFile);
    try
      frmProgressMM.AddMessage(StrWritingRIVPackage);
      frmProgressMM.AddMessage(StrWritingDataSet0);
      WriteDataSet0;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      if Model.ModelSelection = msModflow2015 then
      begin
        frmProgressMM.AddMessage(StrWritingOptions);
        WriteOptionsMF6;
        Application.ProcessMessages;
        if not frmProgressMM.ShouldContinue then
        begin
          Exit;
        end;

        frmProgressMM.AddMessage(StrWritingDimensions);
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

procedure TModflowRIV_Writer.WriteFluxObservationFile(const AFileName: string;
  Purpose: TObservationPurpose);
const
  DataSet1Comment = ' # Data Set 1: NQRV NQCRV NQTRV IURVOBSV';
  DataSet2Comment = ' # Data Set 2: TOMULTRV';
  DataSet3Comment = ' # Data Set 3: NQOBRV NQCLRV';
  PackageAbbreviation = StrRVOB;
begin
  if Model.ModelSelection <> msModflow2015 then
  begin
    WriteFluxObsFile(AFileName, StrIURVOBSV, PackageAbbreviation,
      DataSet1Comment, DataSet2Comment, DataSet3Comment,
      Model.RiverObservations, Purpose);
  end
  else
  begin
    WriteFluxObsFileMF6(AFileName, StrIURVOBSV, PackageAbbreviation,
      DataSet1Comment, DataSet2Comment, DataSet3Comment,
      Model.RiverObservations, Purpose);
  end;
end;

procedure TModflowRIV_Writer.InitializeCells;
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

procedure TModflowRIV_Writer.WriteParameterCells(CellList: TValueCellList;
  NLST: Integer; const VariableIdentifiers, DataSetIdentifier: string;
  AssignmentMethod: TUpdateMethod; MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection);
var
  Cell: TRiv_Cell;
  CellIndex: Integer;
begin
  // Data set 4b
  InitializeCells;
  for CellIndex := 0 to CellList.Count - 1 do
  begin
    Cell := CellList[CellIndex] as TRiv_Cell;
    WriteCell(Cell, DataSetIdentifier, VariableIdentifiers);
    CheckCell(Cell, 'RIV');
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
    WriteFloat(0);
    WriteInteger(0);
    WriteString(
      ' # Data Set 4b: Layer Row Column Stage Condfact Rbot IFACE (Dummy boundary)');
    NewLine;
  end;
end;

end.
