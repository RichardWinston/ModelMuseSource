unit ZoneBudgetWriterUnit;

interface

uses
  CustomModflowWriterUnit, PhastModelUnit, ModflowPackageSelectionUnit,
  SysUtils, IntListUnit, Classes, DataSetUnit;

type
  TZoneBudgetZoneFileWriter = class(TCustomModflowWriter)
  private
    FZoneBudget: TZoneBudgetSelect;
    FUsedZones: TIntegerList;
    procedure WriteDataSet1;
    procedure WriteDataSet2;
    procedure WriteDataSet3;
    procedure InitializeUsedZones;
    procedure CheckValidZoneNumbers;
    procedure ReportInvalidZonesInCompositeZones(MissingZones: TIntegerList; NAMCOMP: string);
  protected
    class function Extension: string; override;
  public
    Constructor Create(Model: TCustomModel; EvaluationType: TEvaluationType); override;
    destructor Destroy; override;
    Procedure WriteU2DINTHeader(const Comment: string;
      ArrayType: TModflowArrayType; const MF6_ArrayName: string); override;
    procedure WriteFile(const AFileName: string);
  end;

  TZoneBudgetResponseFileWriter = class(TCustomModflowWriter)
  private
    FZoneBudget: TZoneBudgetSelect;
    FNameOfFile: string;
    FEmbeddedExport: Boolean;
    procedure WriteResponse1(ArchiveFile: Boolean);
    procedure WriteResponse2(ArchiveFile: Boolean);
    procedure WriteResponse3;
    procedure WriteResponse4;
    procedure WriteResponse5;
  public
    class function Extension: string; override;
    Constructor Create(Model: TCustomModel; EvaluationType: TEvaluationType;
      EmbeddedExport: boolean); reintroduce;
    procedure WriteFile(const AFileName: string);
  end;

const
  StrZbzones = '.zb_zones';

implementation

uses
  ModflowUnitNumbers, frmProgressUnit, frmErrorsAndWarningsUnit, Forms,
  GoPhastTypes;

resourcestring
  StrZONEBUDGETZonesMus = 'ZONEBUDGET Zones must be  between 0 and 999 ' +
    'inclusive. The following zones are outside that range';
  StrSomeCompositeZones = 'Some composite zones contain numerical Zone values'
    + ' that are not included in the zone arrays.';
  StrTheNamesOfSomeZO = 'The names of some ZONEBUDGET composite zones appear' +
    ' more than once.';
  StrInTheFollowingZON = 'In the following ZONEBUDGET composite zones, a "0"' +
    ' appears before the end of the list of zones.  ZONEBUDGET will ignore all' +
    ' zones after zone 0';
  StrTheBudgetFileRequ = 'The budget file required by ZONEBUDGET is absent. '
    + 'Try running MODFLOW again.';
  StrWritingZONEBUDGETZ = 'Writing ZONEBUDGET Zone File input.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
//  StrWritingDataSet2 = '  Writing Data Set 2.';
//  StrWritingDataSet3 = '  Writing Data Set 3.';
  StrWritingZONEBUDGETR = 'Writing ZONEBUDGET Response file.';

{ TZoneBudgetWriter }

constructor TZoneBudgetZoneFileWriter.Create(Model: TCustomModel; EvaluationType: TEvaluationType);
begin
  inherited;
  FArrayWritingFormat := awfModflow;
  FZoneBudget := Model.ModflowPackages.ZoneBudget;
  FUsedZones:= TIntegerList.Create;
end;

destructor TZoneBudgetZoneFileWriter.Destroy;
begin
  FUsedZones.Free;
  inherited;
end;

class function TZoneBudgetZoneFileWriter.Extension: string;
begin
  result := StrZbzones;
end;

procedure TZoneBudgetZoneFileWriter.WriteDataSet1;
var
  NLAY: Integer;
  NROW: Integer;
  NCOL: Integer;
begin
  NLAY := Model.ModflowLayerCount;
  NROW := Model.Grid.RowCount;
  NCOL := Model.Grid.ColumnCount;
  WriteInteger(NLAY);
  WriteInteger(NROW);
  WriteInteger(NCOL);
  WriteString(' # Data set 1: NROW NROW NCOL');
  NewLine;
end;

procedure TZoneBudgetZoneFileWriter.WriteDataSet2;
var
  LayerIndex: Integer;
  DataArray: TDataArray;
begin
  DataArray := Model.DataArrayManager.GetDataSetByName(StrZones);
  for LayerIndex := 0 to Model.LayerStructure.LayerCount - 1 do
  begin
    if Model.IsLayerSimulated(LayerIndex) then
    begin
      WriteArray(DataArray, LayerIndex,
        'IZONE for layer ' + IntToStr(LayerIndex+1), StrNoValueAssigned, 'IZONE');
    end;
  end;
end;

procedure TZoneBudgetZoneFileWriter.WriteDataSet3;
var
  CompositeZoneIndex: Integer;
  CompositeZone: TCompositeZone;
  NAMCOMP: string;
  ZoneIndex: Integer;
  ICOMP: Integer;
  MissingZones: TIntegerList;
  DuplicateNames: TStringList;
  AllNames: TStringList;
  DupIndex: Integer;
begin
  InitializeUsedZones;
  CheckValidZoneNumbers;

  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrSomeCompositeZones);
  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrTheNamesOfSomeZO);
  frmErrorsAndWarnings.RemoveWarningGroup(Model, StrInTheFollowingZON);

  AllNames:= TStringList.Create;
  DuplicateNames:= TStringList.Create;
  MissingZones := TIntegerList.Create;
  try
    DuplicateNames.Sorted := True;
    DuplicateNames.Duplicates := dupIgnore;
    for CompositeZoneIndex := 0 to FZoneBudget.CompositeZones.Count - 1 do
    begin
      CompositeZone := FZoneBudget.CompositeZones[
        CompositeZoneIndex].CompositeZone;
      NAMCOMP := CompositeZone.ZoneName;
      if AllNames.IndexOf(NAMCOMP) >= 0 then
      begin
        DuplicateNames.Add(NAMCOMP);
      end;
      AllNames.Add(NAMCOMP);

      WriteString(NAMCOMP + ' ');
      MissingZones.Clear;
      for ZoneIndex := 0 to CompositeZone.Count - 1 do
      begin
        ICOMP := CompositeZone[ZoneIndex].ZoneNumber;
        WriteInteger(ICOMP);
        if ICOMP > 0 then
        begin
          if FUsedZones.IndexOf(ICOMP) < 0 then
          begin
            MissingZones.Add(ICOMP);
          end;
        end
        else if (ICOMP = 0) and (ZoneIndex < CompositeZone.Count - 1) then
        begin
          frmErrorsAndWarnings.AddWarning(Model, StrInTheFollowingZON, NAMCOMP);
        end;
             
      end;
      WriteInteger(0);
      WriteString(' # NAMCOMP, ICOMP');
      NewLine;
      ReportInvalidZonesInCompositeZones(MissingZones, NAMCOMP);
    end;
    for DupIndex := 0 to DuplicateNames.Count - 1 do
    begin
      frmErrorsAndWarnings.AddError(Model,
        StrTheNamesOfSomeZO, DuplicateNames[DupIndex]);
    end;
  finally
    MissingZones.Free;
    DuplicateNames.Free;
    AllNames.Free;
  end;
end;

procedure TZoneBudgetZoneFileWriter.WriteFile(const AFileName: string);
var
  NameOfFile: string;
begin
  if not FZoneBudget.IsSelected then
  begin
    Exit
  end;
  NameOfFile := FileName(AFileName);
  Model.AddZoneBudgetInputFile(NameOfFile);

  OpenFile(NameOfFile);
  try
    frmProgressMM.AddMessage(StrWritingZONEBUDGETZ);
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
  finally
    CloseFile;
  end;
end;

procedure TZoneBudgetZoneFileWriter.ReportInvalidZonesInCompositeZones(
  MissingZones: TIntegerList; NAMCOMP: string);
var
  ErrorString: string;
  MissIndex: Integer;
begin
  if MissingZones.Count > 0 then
  begin
    ErrorString := '';
    for MissIndex := 0 to MissingZones.Count - 1 do
    begin
      ErrorString := ErrorString + IntToStr(MissingZones[MissIndex]) + ' ';
    end;
    frmErrorsAndWarnings.AddError(Model,
      StrSomeCompositeZones, NAMCOMP + '; ' + Trim(ErrorString));
  end;
end;

procedure TZoneBudgetZoneFileWriter.CheckValidZoneNumbers;
var
  AValue: Integer;
  Index: Integer;
begin
  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrZONEBUDGETZonesMus);
  for Index := 0 to FUsedZones.Count - 1 do
  begin
    AValue := FUsedZones[Index];
    if (AValue < 0) or (AValue > 999) then
    begin
      frmErrorsAndWarnings.AddError(Model,
        StrZONEBUDGETZonesMus, IntToStr(AValue));
    end;
  end;
end;

procedure TZoneBudgetZoneFileWriter.InitializeUsedZones;
var
  ColIndex: Integer;
  RowIndex: Integer;
  LayerIndex: Integer;
  DataArray: TDataArray;
begin
  DataArray := Model.DataArrayManager.GetDataSetByName(StrZones);
  DataArray.Initialize;
  FUsedZones.Sorted := True;
  for LayerIndex := 0 to Model.LayerStructure.LayerCount - 1 do
  begin
    if Model.IsLayerSimulated(LayerIndex) then
    begin
      for RowIndex := 0 to DataArray.RowCount - 1 do
      begin
        for ColIndex := 0 to DataArray.ColumnCount - 1 do
        begin
          FUsedZones.AddUnique(DataArray.IntegerData[LayerIndex, RowIndex, ColIndex]);
        end;
      end;
    end;
  end;
  Model.DataArrayManager.AddDataSetToCache(DataArray);
  Model.DataArrayManager.CacheDataArrays;
end;

procedure TZoneBudgetZoneFileWriter.WriteU2DINTHeader(const Comment: string;
  ArrayType: TModflowArrayType; const MF6_ArrayName: string);
begin
  WriteString( 'INTERNAL () ');
  WriteInteger(IPRN_Integer);
  WriteString( ' # ' + Comment);
  NewLine;
end;

{ TZoneBudgetResponseFileWriter }

constructor TZoneBudgetResponseFileWriter.Create(Model: TCustomModel;
  EvaluationType: TEvaluationType; EmbeddedExport: boolean);
begin
  inherited Create(Model, EvaluationType);
  FEmbeddedExport := EmbeddedExport;
  FZoneBudget := Model.ModflowPackages.ZoneBudget;
end;

class function TZoneBudgetResponseFileWriter.Extension: string;
begin
  result := '.zb_response'
end;

procedure TZoneBudgetResponseFileWriter.WriteFile(const AFileName: string);
var
  NameOfArchiveFile: string;
begin
  if not FZoneBudget.IsSelected then
  begin
    Exit
  end;
  FNameOfFile := FileName(AFileName);

  frmProgressMM.AddMessage(StrWritingZONEBUDGETR);
  OpenFile(FNameOfFile);
  try
    WriteResponse1(False);
    WriteResponse2(False);
    WriteResponse3;
    WriteResponse4;
    WriteResponse5;
  finally
    CloseFile;
  end;

  NameOfArchiveFile := FNameOfFile + '.archive';
  Model.AddZoneBudgetInputFile(NameOfArchiveFile);
  OpenFile(NameOfArchiveFile);
  try
    WriteResponse1(True);
    WriteResponse2(True);
    WriteResponse3;
    WriteResponse4;
    WriteResponse5;
  finally
    CloseFile;
  end;
end;

procedure TZoneBudgetResponseFileWriter.WriteResponse1(ArchiveFile: Boolean);
var
  AFileName: string;
begin
  // Write the output file names and options.
  AFileName := ExtractFileName(FNameOfFile);
  if ArchiveFile then
  begin
    AFileName := ChangeFileExt(AFileName, '');
    AFileName := '..\..\output\' + AFileName  + '_ZoneBudget\' + AFileName;
  end;
  if FZoneBudget.ExportZBLST
    and not FZoneBudget.ExportCSV
    and not FZoneBudget.ExportCSV2 then
  begin
    AFileName := ChangeFileExt(AFileName, '.zblst');
    WriteString(AFileName);
  end
  else
  begin
    AFileName := ChangeFileExt(AFileName, '');
    WriteString(AFileName);
    if FZoneBudget.ExportZBLST then
    begin
      WriteString(' ZBLST');
    end;
    if FZoneBudget.ExportCSV then
    begin
      WriteString(' CSV');
    end;
    if FZoneBudget.ExportCSV2 then
    begin
      WriteString(' CSV2');
    end;
  end;
  NewLine;
end;

procedure TZoneBudgetResponseFileWriter.WriteResponse2(ArchiveFile: Boolean);
var
  AFileName: string;
begin
  // write the name of the budget file
  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrTheBudgetFileRequ);

  AFileName := FNameOfFile;
  if ArchiveFile then
  begin
    AFileName := ExtractFileName(AFileName);
    AFileName := ChangeFileExt(AFileName, '');
    AFileName := '..\..\output\' + AFileName  + '\' + AFileName;
  end;
  AFileName := ChangeFileExt(AFileName, StrCbcExt);

  if not ArchiveFile then
  begin
    if (not FEmbeddedExport) and (not FileExists(AFileName)) then
    begin
      frmErrorsAndWarnings.AddError(Model, StrTheBudgetFileRequ, AFileName);
    end;
  end;
//  Model.ZoneBudgetInputFiles.Add(AFileName);
  if not ArchiveFile then
  begin
    AFileName := ExtractFileName(AFileName);
  end;
  WriteString(AFileName);
  NewLine;
end;

procedure TZoneBudgetResponseFileWriter.WriteResponse3;
var
  ATitle: string;
begin
  // Use the first line of the comments as the title if there is one.
  if FZoneBudget.Comments.Count > 0 then
  begin
    ATitle := FZoneBudget.Comments[0];
  end
  else
  begin
    ATitle := PackageID_Comment(FZoneBudget);
  end;
  WriteString(ATitle);
  NewLine;
end;

procedure TZoneBudgetResponseFileWriter.WriteResponse4;
var
  AFileName: string;
begin
  // write the name of the zone file
  AFileName := ExtractFileName(FNameOfFile);
  AFileName := ChangeFileExt(AFileName,
    TZoneBudgetZoneFileWriter.Extension);
  WriteString(AFileName);
  NewLine;
end;

procedure TZoneBudgetResponseFileWriter.WriteResponse5;
begin
  // Compute budgets for all times.
  WriteString('A');
  NewLine;
end;




end.
