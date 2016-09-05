unit ModflowSmsWriterUnit;

interface

uses SysUtils, CustomModflowWriterUnit, ModflowPackageSelectionUnit;

type
  TSmsWriter = class(TCustomSolverWriter)
  private
    procedure WriteInnerMaximum;
    procedure WriteInnerHClose;
    procedure WritePreconditionerLevels;
    procedure WritePreconditionerDropTolerances;
    procedure WriteNumberOfOrthogonalizations;
    procedure WriteReorderingMethod;
  protected
    FSmsPackage: TSmsPackageSelection;
    function Package: TModflowPackageSelection; override;
    class function Extension: string; override;
    procedure WriteOptions;
    procedure WriteNonLinearBlock;
    function LinearSolver: TSmsLinearSolver;
    procedure WriteLinearBlock;
    procedure WriteXmdBlock;
  public
    procedure WriteFile(const AFileName: string);
  end;

implementation

uses ModflowUnitNumbers, PhastModelUnit, frmProgressUnit;

{ TSmsWriter }

class function TSmsWriter.Extension: string;
begin
  result := '.sms';
end;

function TSmsWriter.LinearSolver: TSmsLinearSolver;
begin
  result := slsDefault;
  if soLinearSolver in FSmsPackage.SmsOverrides then
  begin
    result := FSmsPackage.LinearSolver;
  end;
end;

function TSmsWriter.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.SmsPackage;
end;

procedure TSmsWriter.WriteFile(const AFileName: string);
var
  NameOfFile: string;
begin
  if not Package.IsSelected then
  begin
    Exit
  end;
  if SolverFileGeneratedExternally then
  begin
    Exit;
  end;
  NameOfFile := FileName(AFileName);
  // write to simulation name file
  OpenFile(NameOfFile);
  try
    frmProgressMM.AddMessage('Writing SMS Package input');
    WriteDataSet0;
    FSmsPackage := Model.ModflowPackages.SmsPackage;
    WriteOptions;
    WriteNonLinearBlock;
    case LinearSolver of
      slsDefault: WriteLinearBlock;
      slsXMD: WriteXmdBlock;
      else Assert(False);
    end;
  finally
    CloseFile;
  end;

end;

procedure TSmsWriter.WriteReorderingMethod;
begin
  if soReorderingMethod in FSmsPackage.SmsOverrides then
  begin
    WriteString('  REORDERING_METHOD ');
    case FSmsPackage.ReorderingMethod of
      srmNone:
        WriteString('NONE');
      srmReverseCuthillMcKee:
        WriteString('RKM');
      srmMinimumDegreeOrdering:
        WriteString('MD');
    else
      Assert(False);
    end;
    NewLine;
  end;
end;

procedure TSmsWriter.WriteNumberOfOrthogonalizations;
begin
  if soNumberOfOrthoganalizations in FSmsPackage.SmsOverrides then
  begin
    WriteString('  NUMBER_ORTHOGONALIZATIONS');
    WriteInteger(FSmsPackage.NumberOfOrthoganalizations);
    NewLine;
  end;
end;

procedure TSmsWriter.WritePreconditionerDropTolerances;
begin
  if soPreconditionerDropTolerance in FSmsPackage.SmsOverrides then
  begin
    WriteString('  PRECONDITIONER_DROP_TOLERANCE');
    WriteFloat(FSmsPackage.PreconditionerDropTolerance);
    NewLine;
  end;
end;

procedure TSmsWriter.WritePreconditionerLevels;
begin
  if soPreconditionerLevel in FSmsPackage.SmsOverrides then
  begin
    WriteString('  PRECONDITIONER_LEVELS');
    WriteInteger(FSmsPackage.PreconditionerLevel);
    NewLine;
  end;
end;

procedure TSmsWriter.WriteInnerHClose;
begin
  WriteString('  INNER_HCLOSE');
  if soInnerHclose in FSmsPackage.SmsOverrides then
  begin
    WriteFloat(FSmsPackage.InnerHclose);
  end
  else
  begin
    WriteFloat(0.0001);
  end;
  NewLine;
end;

procedure TSmsWriter.WriteInnerMaximum;
begin
  WriteString('  INNER_MAXIMUM');
  if soInnerMaxIterations in FSmsPackage.SmsOverrides then
  begin
    WriteInteger(FSmsPackage.InnerMaxIterations);
  end
  else
  begin
    WriteInteger(100);
  end;
  NewLine;
end;

procedure TSmsWriter.WriteLinearBlock;
//var
//  UseNonLinear: Boolean;
begin
//  UseNonLinear := [soInnerMaxIterations, soInnerHclose, soInnerRclose,
//    soLinLinearAcceleration, soRelaxationFactor, soPreconditionerLevel,
//    soPreconditionerDropTolerance, soNumberOfOrthoganalizations,
//    soScalingMethod, soReorderingMethod] * FSmsPackage.SmsOverrides <> [];
//  if not UseNonLinear then
//  begin
//    Exit;
//  end;

  WriteString('BEGIN LINEAR');
  NewLine;

  WriteInnerMaximum;
  WriteInnerHClose;

  WriteString('  INNER_RCLOSE');
  if soInnerRclose in FSmsPackage.SmsOverrides then
  begin
    WriteFloat(FSmsPackage.InnerRclose);

    if soRcloseOption in FSmsPackage.SmsOverrides then
    begin
      case FSmsPackage.RcloseOption of
        sroAbsolute: {do nothing};
        sroL2Norm: WriteString(' L2NORM_RCLOSE');
        sroRelative: WriteString(' RELATIVE_RCLOSE');
        else Assert(False);
      end;
    end;
  end
  else
  begin
    WriteFloat(0.1);
  end;
  NewLine;

  WriteString('  LINEAR_ACCELERATION ');
  if soLinLinearAcceleration in FSmsPackage.SmsOverrides then
  begin
    case FSmsPackage.LinLinearAcceleration of
      sllaCg: WriteString('CG');
      sllaBiCgStab: WriteString('BICGSTAB');
      else Assert(False);
    end;
  end
  else
  begin
    WriteString('CG');
  end;
  NewLine;

  if soRelaxationFactor in FSmsPackage.SmsOverrides then
  begin
    WriteString('  RELAXATION_FACTOR');
    WriteFloat(FSmsPackage.RelaxationFactor);
    NewLine;
  end;

  WritePreconditionerLevels;
  WritePreconditionerDropTolerances;
  WriteNumberOfOrthogonalizations;

  if soScalingMethod in FSmsPackage.SmsOverrides then
  begin
    WriteString('  SCALING_METHOD ');
    case FSmsPackage.ScalingMethod of
      ssmNone: WriteString('NONE');
      ssmDiagonal: WriteString('DIAGONAL');
      ssmL2Norm: WriteString('L2NORM');
      else Assert(False);
    end;
    NewLine;
  end;
  WriteReorderingMethod;

  WriteString('END LINEAR');
  NewLine;
  NewLine;
end;

procedure TSmsWriter.WriteNonLinearBlock;
//var
//  UseNonLinear: Boolean;
begin
//  UseNonLinear := False;
//  if [soOuterHclose, soOuterMaxIt, soUnderRelax, soBacktrackingNumber]
//    * FSmsPackage.SmsOverrides <> []  then
//  begin
//    UseNonLinear := True;
//  end
//  else if (soLinearSolver in FSmsPackage.SmsOverrides)
//    and (FSmsPackage.LinearSolver = slsXMD) then
//  begin
//    UseNonLinear := True;
//  end;
//
//  if not UseNonLinear then
//  begin
//    Exit;
//  end;


  WriteString('BEGIN NONLINEAR');
  NewLine;

  WriteString('  OUTER_HCLOSE ');
  if soOuterHclose in FSmsPackage.SmsOverrides then
  begin
    WriteFloat(FSmsPackage.OuterHclose);
  end
  else
  begin
    WriteFloat(0.01);
  end;
  NewLine;

  WriteString('  OUTER_MAXIMUM ');
  if soOuterMaxIt in FSmsPackage.SmsOverrides then
  begin
    WriteInteger(FSmsPackage.MaxOuterIterations);
  end
  else
  begin
    WriteInteger(100);
  end;
  NewLine;

  WriteString('  UNDER_RELAXATION ');
  if soUnderRelax in FSmsPackage.SmsOverrides then
  begin
    case FSmsPackage.UnderRelaxation of
      surNone: WriteString('NONE');
      surDbd: WriteString('DTD');
      surCooley: WriteString('COOLEY');
      else Assert(False);
    end;
    NewLine;

    if FSmsPackage.UnderRelaxation = surNone then
    begin
      if soUnderRelaxTheta in FSmsPackage.SmsOverrides then
      begin
        WriteString('  UNDER_RELAXATION_THETA ');
        WriteFloat(FSmsPackage.UnderRelaxTheta);
        NewLine;
      end;

      if soUnderRelaxKappa in FSmsPackage.SmsOverrides then
      begin
        WriteString('  UNDER_RELAXATION_KAPPA');
        WriteFloat(FSmsPackage.UnderRelaxKappa);
        NewLine;
      end;

      if soUnderRelaxGamma in FSmsPackage.SmsOverrides then
      begin
        WriteString('  UNDER_RELAXATION_GAMMA');
        WriteFloat(FSmsPackage.UnderRelaxGamma);
        NewLine;
      end;

      if soUnderRelaxMomentum in FSmsPackage.SmsOverrides then
      begin
        WriteString('  UNDER_RELAXATION_MOMENTUM');
        WriteFloat(FSmsPackage.UnderRelaxMomentum);
        NewLine;
      end;
    end;
  end
  else
  begin
    WriteString('NONE');
    NewLine;
  end;

  if soBacktrackingNumber in FSmsPackage.SmsOverrides then
  begin
    WriteString('  BACKTRACKING_NUMBER');
    WriteInteger(FSmsPackage.BacktrackingNumber);
    NewLine;

    if FSmsPackage.BacktrackingNumber > 0 then
    begin
      if soBacktrackingTolerance in FSmsPackage.SmsOverrides then
      begin
        WriteString('  BACKTRACKING_TOLERANCE');
        WriteFloat(FSmsPackage.BacktrackingTolerance);
        NewLine;
      end;

      if soBacktrackingReductionFactor in FSmsPackage.SmsOverrides then
      begin
        WriteString('  BACKTRACKING_REDUCTION_FACTOR');
        WriteFloat(FSmsPackage.BacktrackingReductionFactor);
        NewLine;
      end;

      if soBacktrackingResidualLimit in FSmsPackage.SmsOverrides then
      begin
        WriteString('  BACKTRACKING_RESIDUAL_LIMIT');
        WriteFloat(FSmsPackage.BacktrackingResidualLimit);
        NewLine;
      end;
    end;
  end;

  if (soLinearSolver in FSmsPackage.SmsOverrides)
    and (FSmsPackage.LinearSolver = slsXMD) then
  begin
    WriteString('  LINEAR_SOLVER XMD');
    NewLine;
  end;

  WriteString('END NONLINEAR');
  NewLine;
  NewLine;
end;

procedure TSmsWriter.WriteOptions;
begin
  WriteBeginOptions;

  WriteString('  PRINT_OPTION ');
  case FSmsPackage.Print of
    spPrintNone: WriteString('NONE');
    spSummary: WriteString('SUMMARY');
    spFull: WriteString('ALL');
  end;
  NewLine;

  WriteString('  COMPLEXITY ');
  case FSmsPackage.Complexity of
    scoSimple: WriteString('SIMPLE');
    scoModerate: WriteString('MODERATE');
    scoComplex: WriteString('COMPLEX');
    scoSpecified: WriteString('SPECIFIED');
    else Assert(False);
  end;
  NewLine;

  WriteEndOptions;
end;

procedure TSmsWriter.WriteXmdBlock;
var
  UseXmd: Boolean;
begin
  UseXmd := False;
  if [soInnerMaxIterations, soInnerHclose, soInnerRclose,
    soXmdLinearAcceleration, soPreconditionerLevel,
    soPreconditionerDropTolerance, soNumberOfOrthoganalizations,
    soReorderingMethod]
    * FSmsPackage.SmsOverrides <> [] then
  begin
    UseXmd := True;
  end
  else if (soRedBlackOrder in FSmsPackage.SmsOverrides)
    and FSmsPackage.RedBlackOrder then
  begin
    UseXmd := True;
  end;

  if not UseXmd then
  begin
    Exit;
  end;

  WriteString('BEGIN XMD');
  NewLine;

  WriteInnerMaximum;
  WriteInnerHClose;

  WriteString('  INNER_RCLOSE');
  if soInnerRclose in FSmsPackage.SmsOverrides then
  begin
    WriteFloat(FSmsPackage.InnerRclose);
  end
  else
  begin
    WriteFloat(0.1);
  end;
  NewLine;

  WriteString('  LINEAR_ACCELERATION ');
  if soXmdLinearAcceleration in FSmsPackage.SmsOverrides then
  begin
    case FSmsPackage.XmdLinearAcceleration of
      sxlaCg: WriteString('CG');
      sxlaOrthomin: WriteString('ORTHOMIN');
      sxlaBiCgStab: WriteString('BICGSTAB');
      else Assert(False);
    end;
  end
  else
  begin
    WriteString('CG');
  end;
  NewLine;

  WritePreconditionerLevels;
  WritePreconditionerDropTolerances;
  WriteNumberOfOrthogonalizations;

  if (soRedBlackOrder in FSmsPackage.SmsOverrides)
    and FSmsPackage.RedBlackOrder then
  begin
    WriteString('  RED_BLACK_ORDERING');
    NewLine;
  end;

  WriteReorderingMethod;

  WriteString('END XMD');
  NewLine;
end;

end.
