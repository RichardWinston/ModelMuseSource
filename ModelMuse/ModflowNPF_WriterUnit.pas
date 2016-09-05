unit ModflowNPF_WriterUnit;

interface

uses
  CustomModflowWriterUnit, ModflowPackageSelectionUnit, Vcl.Forms, DataSetUnit;

type
  TNpfWriter = class(TCustomFlowPackageWriter)
  private
    procedure WriteDataSet1;
    procedure WriteIcelltype;
    procedure WriteHK;
    procedure WriteVK;
    procedure WriteWETDRY;
    procedure WriteHANI;
  protected
    function Package: TModflowPackageSelection; override;
    class function Extension: string; override;
  public
    procedure WriteFile(const AFileName: string);
  end;

implementation

uses
  frmErrorsAndWarningsUnit, ModflowUnitNumbers, frmProgressUnit, GoPhastTypes,
  ModflowOptionsUnit, ModflowOutputControlUnit, PhastModelUnit,
  System.SysUtils;

resourcestring
  StrWritingNPFPackage = 'Writing NPF Package input.';

{ TNpfWriter }

class function TNpfWriter.Extension: string;
begin
  Result := '.npf';
end;

function TNpfWriter.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.NpfPackage;
end;

procedure TNpfWriter.WriteDataSet1;
var
  HNOFlO: Real;
  HDRY: Real;
  NpfPackage: TNpfPackage;
  Wetting: TWettingOptions;
  WETFCT: Real;
  IWETIT: Integer;
  IHDWET: Integer;
begin
  WriteBeginOptions;

  WriteSaveFlowsOption;

  HNOFlO := Model.ModflowOptions.HNoFlow;
  WriteString('  HNOFLO ');
  WriteFloat(HNOFlO);
  NewLine;

  HDRY := Model.ModflowOptions.HDry;
  WriteString('  HDRY ');
  WriteFloat(HDRY);
  NewLine;

  NpfPackage := Model.ModflowPackages.NpfPackage;

  case NpfPackage.CellAveraging of
    caHarmonic: WriteString('  CELL_AVERAGING HARMONIC');
    caLogarithmic: WriteString('  CELL_AVERAGING LOGARITHMIC');
    caArithLog: WriteString('  CELL_AVERAGING AMT-LMK');
    else Assert(False);
  end;
  NewLine;

  if NpfPackage.UseSaturatedThickness then
  begin
    WriteString('  THICKSTRT');
    NewLine;
  end;

  if NpfPackage.TimeVaryingVerticalConductance then
  begin
    WriteString('  VARIABLECV');
    if NpfPackage.Dewatered then
    begin
      WriteString(' DEWATERED');
    end;
    NewLine;
  end;

  if NpfPackage.Perched then
  begin
    WriteString('  PERCHED');
    NewLine;
  end;

  Wetting := Model.ModflowWettingOptions;
  if Wetting.WettingActive then
  begin
    WriteString('  REWET');
    NewLine;

    WETFCT := Wetting.WettingFactor;
    WriteString('  WETFCT ');
    WriteFloat(WETFCT);
    NewLine;

    IWETIT := Wetting.WettingIterations;
    WriteString('  IWETIT ');
    WriteInteger(IWETIT);
    NewLine;

    IHDWET := Wetting.WettingEquation;
    WriteString('  IHDWET ');
    WriteInteger(IHDWET);
    NewLine;
  end;

  if NpfPackage.UseNewtonRaphson then
  begin
    WriteString('  NEWTON');
    NewLine;
  end;

  if NpfPackage.ApplyHeadDampening then
  begin
    WriteString('  NEWTON_HEAD_DAMPENING');
    NewLine;
  end;

  WriteEndOptions;
end;

procedure TNpfWriter.WriteFile(const AFileName: string);
var
  NameOfFile: string;
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    if not Model.ModflowPackages.NpfPackage.IsSelected then
    begin
      Exit
    end;
    if FlowPackageFileGeneratedExternally then
    begin
      Exit;
    end;
    NameOfFile := FileName(AFileName);
    WriteToNameFile(StrNPF, -1, NameOfFile, foInput, Model);
    OpenFile(NameOfFile);
    try
      frmProgressMM.AddMessage(StrWritingNPFPackage);
      frmProgressMM.AddMessage(StrWritingDataSet0);
      WriteDataSet0;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      frmProgressMM.AddMessage(StrWritingOptions);
      WriteDataSet1;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      NewLine;
      WriteString('BEGIN NPFDATA');
      NewLine;

      WriteIcelltype;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      WriteHK;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      WriteVK;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;


      WriteWETDRY;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      WriteHANI;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      WriteString('END NPFDATA');
      NewLine;
    finally
      CloseFile;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

procedure TNpfWriter.WriteHANI;
var
  DataArray: TDataArray;
begin
  frmProgressMM.AddMessage('  Writing HANI');
  DataArray := Model.DataArrayManager.GetDataSetByName(rsHorizontalAnisotropy);
  WriteMf6_DataSet(DataArray, 'HANI');
end;

procedure TNpfWriter.WriteHK;
var
  DataArray: TDataArray;
begin
  frmProgressMM.AddMessage('  Writing HK');
  DataArray := Model.DataArrayManager.GetDataSetByName(rsKx);
  WriteMf6_DataSet(DataArray, 'HK');
end;

procedure TNpfWriter.WriteIcelltype;
var
  DataArray: TDataArray;
begin
  frmProgressMM.AddMessage('  Writing ICELLTYPE');
  DataArray := Model.DataArrayManager.GetDataSetByName(KCellType);
  WriteMf6_DataSet(DataArray, 'ICELLTYPE');
end;

procedure TNpfWriter.WriteVK;
var
  DataArray: TDataArray;
begin
  frmProgressMM.AddMessage('  Writing VK');
  DataArray := Model.DataArrayManager.GetDataSetByName(rsKz);
  WriteMf6_DataSet(DataArray, 'VK');
end;

procedure TNpfWriter.WriteWETDRY;
var
  DataArray: TDataArray;
begin
  if Model.ModflowWettingOptions.WettingActive then
  begin
    frmProgressMM.AddMessage('  Writing WETDRY');
    DataArray := Model.DataArrayManager.GetDataSetByName(rsWetDry);
    WriteMf6_DataSet(DataArray, 'WETDRY');
  end;
end;

end.
