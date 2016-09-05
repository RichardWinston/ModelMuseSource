unit ModflowDiscretizationWriterUnit;

interface

uses SysUtils, CustomModflowWriterUnit, PhastModelUnit;

type
  TModflowDiscretizationWriter = class(TCustomModflowWriter)
  private
    procedure WriteDataSet0;
    procedure WriteDataSet1;
    procedure WriteIDomain;
  public
    class function Extension: string; override;
    procedure WriteFile(const AFileName: string);
  end;

resourcestring
  StrInvalidSelectionOf = 'Invalid selection of time unit';
  StrTheFarmProcessReq = 'The farm process requires that the time unit be se' +
  't to days if rooting depth or consumptive use is to be calculated from cli' +
  'mate data.';

implementation

uses ModflowUnitNumbers, frmProgressUnit, Forms, ModelMuseUtilities,
  frmGoPhastUnit, ModflowOptionsUnit, GoPhastTypes, ModflowPackageSelectionUnit,
  frmErrorsAndWarningsUnit, FastGEO, DataSetUnit;

resourcestring
  StrWritingDiscretizati = 'Writing Discretization Package input.';
//  StrWritingDataSet0 = '  Writing Data Set 0.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
//  StrWritingDataSet2 = '  Writing Data Set 2.';
//  StrWritingDataSet3 = '  Writing Data Set 3.';
//  StrWritingDataSet4 = '  Writing Data Set 4.';
  StrCheckingColumnWi = '  Checking column widths.';
  StrCheckingRowHeigh = '  Checking row height.';
  StrCheckingRowToCo = '  Checking row to column size ratios.';
//  StrWritingDataSet5 = '  Writing Data Set 5.';
//  StrWritingDataSet6 = '  Writing Data Set 6.';
  StrCheckingElevation = '  Checking elevations.';
  StrDIS8 = 'DIS8';
//  StrWritingDataSet7 = '  Writing Data Set 7.';

{ TModflowDiscretizationWriter }

class function TModflowDiscretizationWriter.Extension: string;
begin
  result := '.dis';
end;

procedure TModflowDiscretizationWriter.WriteFile(const AFileName: string);
var
  NameOfFile: string;
  FTYPE: string;
begin
  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrInvalidSelectionOf);

  if Model.ModelSelection = msModflow2015 then
  begin
    FTYPE := StrDIS8;
  end
  else
  begin
    FTYPE := StrDIS;
  end;
  if Model.PackageGeneratedExternally(FTYPE) then
  begin
    Exit;
  end;
  NameOfFile := FileName(AFileName);
  if Model.ModelSelection = msModflow2015 then
  begin
    WriteToNameFile(FTYPE, -1, NameOfFile, foInput, Model);
  end
  else
  begin
    WriteToNameFile(FTYPE, Model.UnitNumbers.UnitNumber(FTYPE),
      NameOfFile, foInput, Model);
  end;
  OpenFile(NameOfFile);
  try
    frmProgressMM.AddMessage(StrWritingDiscretizati);
    frmProgressMM.AddMessage(StrWritingDataSet0);
    WriteDataSet0;
    frmProgressMM.AddMessage(StrWritingDataSet1);
    WriteDataSet1;

    // data set 2
    if Model.ModelSelection <> msModflow2015 then
    begin
      frmProgressMM.AddMessage(StrWritingDataSet2);
      Model.WriteLAYCB(self);
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
    end;

    if Model.ModelSelection = msModflow2015 then
    begin
      NewLine;
      WriteString('BEGIN DISDATA');
      NewLine;
    end;

    // data set 3
    frmProgressMM.AddMessage(StrWritingDataSet3);
    Model.ModflowGrid.WriteDELR(self);
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    // data set 4
    frmProgressMM.AddMessage(StrWritingDataSet4);
    Model.ModflowGrid.WriteDELC(self);
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrCheckingColumnWi);
    Model.ModflowGrid.CheckColumnWidths;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrCheckingRowHeigh);
    Model.ModflowGrid.CheckRowHeights;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrCheckingRowToCo);
    Model.ModflowGrid.CheckRowToColumnRatios;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    // data set 5
    frmProgressMM.AddMessage(StrWritingDataSet5);
    Model.ModflowGrid.WriteTOP(self);
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    Model.DataArrayManager.CacheDataArrays;

    // data set 6
    frmProgressMM.AddMessage(StrWritingDataSet6);
    Model.ModflowGrid.WriteBOTM(self, Model);
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;

    frmProgressMM.AddMessage(StrCheckingElevation);
    Model.ModflowGrid.CheckElevations;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    Model.DataArrayManager.CacheDataArrays;

    WriteIDomain;
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    Model.DataArrayManager.CacheDataArrays;

    if Model.ModelSelection = msModflow2015 then
    begin
      WriteString('END DISDATA');
      NewLine;
    end;

    // data set 7
    if Model.ModelSelection <> msModflow2015 then
    begin
      frmProgressMM.AddMessage(StrWritingDataSet7);
      Model.ModflowFullStressPeriods.WriteStressPeriods(self);
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
    end;

  finally
    CloseFile;
  end;
end;


procedure TModflowDiscretizationWriter.WriteIDomain;
var
  IDomainDataSet: TDataArray;
begin
  if Model.ModelSelection = msModflow2015 then
  begin
    frmProgressMM.AddMessage('  Writing IDOMAIN');

    IDomainDataSet := Model.DataArrayManager.GetDataSetByName(K_IDOMAIN);

    WriteMf6_DataSet(IDomainDataSet, 'IDOMAIN');
  end;
end;

procedure TModflowDiscretizationWriter.WriteDataSet0;
var
  GridAngle: Real;
  procedure WriteCorner(const CornerDesc: string; APoint: TPoint2D);
  begin
    WriteCommentLine(CornerDesc + ' (' + FortranFloatToStr(APoint.x)
      + ', ' + FortranFloatToStr(APoint.y) + ')');
  end;
begin
  WriteCommentLine('Discretization File created on ' + DateToStr(Now) + ' by '
    + Model.ProgramName
    + ' version ' + IModelVersion + '.');
  WriteCommentLines(Model.ModflowOptions.Description);

  WriteCorner('Upper left corner:', Model.Grid.TwoDElementCorner(0,0));
  WriteCorner('Lower left corner:', Model.Grid.TwoDElementCorner(
    0,Model.Grid.RowCount));
  WriteCorner('Upper right corner:', Model.Grid.TwoDElementCorner(
    Model.Grid.ColumnCount,0));
  WriteCorner('Lower right corner:', Model.Grid.TwoDElementCorner(
    Model.Grid.ColumnCount,Model.Grid.RowCount));
  GridAngle := Model.Grid.GridAngle * 180 / Pi;
  WriteCommentLine('Grid angle (in degrees counterclockwise): ' + FortranFloatToStr(GridAngle));
end;

procedure TModflowDiscretizationWriter.WriteDataSet1;
var
  ModflowOptions: TModflowOptions;
  FarmProcess: TFarmProcess;
  GridAngle: double;
  APoint: TPoint2D;
begin
  ModflowOptions := Model.ModflowOptions;
  if Model.ModelSelection = msModflow2015 then
  begin
    WriteBeginOptions;

    WriteString('  LENGTH_UNITS ');
      case ModflowOptions.LengthUnit of
        0:
          begin
            // WriteString('UNKNOWN');
          end;
        1:
          begin
            WriteString('FEET');
          end;
        2:
          begin
            WriteString('METERS');
          end;
        3:
          begin
            WriteString('CENTIMETERS');
          end;
        else
          Assert(False);
      end;
    NewLine;

    WriteEndOptions;

    WriteString('BEGIN DIMENSIONS');
    NewLine;

    WriteString('  NLAY ');
    WriteInteger(Model.ModflowLayerCount);
    NewLine;

    WriteString('  NROW ');
    WriteInteger(Model.ModflowGrid.RowCount);
    NewLine;

    WriteString('  NCOL ');
    WriteInteger(Model.ModflowGrid.ColumnCount);
    NewLine;

    WriteString('END DIMENSIONS');
    NewLine;

    Exit;
  end;
  WriteInteger(Model.ModflowLayerCount);
  WriteInteger(Model.ModflowGrid.RowCount);
  WriteInteger(Model.ModflowGrid.ColumnCount);
  WriteInteger(Model.ModflowFullStressPeriods.Count);
  if (Model.ModelSelection = msModflowFmp)
    and Model.ModflowPackages.FarmProcess.IsSelected then
  begin
    FarmProcess := Model.ModflowPackages.FarmProcess;
    if (FarmProcess.RootingDepth = rdCalculated)
      or (FarmProcess.ConsumptiveUse = cuCalculated) then
    begin
      if ModflowOptions.TimeUnit <> 4 then
      begin
        frmErrorsAndWarnings.AddError(Model, StrInvalidSelectionOf,
          StrTheFarmProcessReq)
      end;
    end;
  end;
  WriteInteger(ModflowOptions.TimeUnit);
  WriteInteger(ModflowOptions.LengthUnit);
  if (Model.ModelSelection = msModflowFmp) then
  begin
    APoint := Model.Grid.TwoDElementCorner(0,0);
    WriteFloat(APoint.x);
    WriteFloat(APoint.y);
    GridAngle := Model.Grid.GridAngle * 180 / Pi;
    WriteFloat(GridAngle);
    WriteString(' CORNERCOORD');
    if Model.ModflowOutputControl.PrintInputArrays then
    begin
      WriteString(' PRINTCOORD');
    end;
  end;

  WriteString(' # NLAY, NROW, NCOL, NPER, ITMUNI, LENUNI');
  if (Model.ModelSelection = msModflowFmp) then
  begin
    WriteString(' XFIRSTCORD YFIRSTCORD GRIDROTATION COORD_OPTIONS');
  end;

  NewLine;
end;

end.
