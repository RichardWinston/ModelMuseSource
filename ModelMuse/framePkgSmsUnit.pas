unit framePkgSmsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, framePackageUnit, RbwController,
  Vcl.StdCtrls, JvExStdCtrls, JvCombobox, JvListComb, Vcl.Grids, RbwDataGrid4,
  ModflowPackageSelectionUnit, Vcl.Mask, JvExMask, JvSpin;

type
  TSmsColumns = (scName, scOverride, scValue);

  TframePkgSms = class(TframePackage)
    comboPrintOption: TJvImageComboBox;
    lblPrintOption: TLabel;
    comboComplexity: TJvImageComboBox;
    lblComplexity: TLabel;
    rdgOptions: TRbwDataGrid4;
    lblSolutionGroupMaxIter: TLabel;
    seSolutionGroupMaxIter: TJvSpinEdit;
    cbContinue: TCheckBox;
    procedure rdgOptionsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure rdgOptionsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure comboComplexityChange(Sender: TObject);
    procedure rdgOptionsStateChange(Sender: TObject; ACol, ARow: Integer;
      const Value: TCheckBoxState);
  private
    FInitializedGrid: boolean;
    FUnderRelaxPickList: TStringList;
    FLinearSolverPickList: TStringList;
    FRCloseOptionPickList: TStringList;
    FLinLinearAccPickList: TStringList;
    FReorderingPickList: TStringList;
    FScalingMethodPickList: TStringList;
    FXmdLinearAccPickList: TStringList;
    procedure InitializeGrid;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetData(Package: TModflowPackageSelection); override;
    procedure SetData(Package: TModflowPackageSelection); override;
    { Public declarations }
  end;

var
  framePkgSms: TframePkgSms;

implementation

{$R *.dfm}

{ TframePkgSms }

procedure TframePkgSms.comboComplexityChange(Sender: TObject);
var
  LinSolver: TSmsLinearSolver;
begin
  inherited;
  if TSmsComplexityOption(comboComplexity.ItemIndex) = scoSpecified then
  begin
    rdgOptions.Checked[Ord(scOverride), Ord(soOuterHclose) + 1] := True;
    rdgOptions.Checked[Ord(scOverride), Ord(soOuterMaxIt) + 1] := True;
    rdgOptions.Checked[Ord(scOverride), Ord(soUnderRelax) + 1] := True;
    rdgOptions.Checked[Ord(scOverride), Ord(soInnerMaxIterations) + 1] := True;
    rdgOptions.Checked[Ord(scOverride), Ord(soInnerHclose) + 1] := True;

    if not rdgOptions.Checked[Ord(scOverride), Ord(soLinearSolver) + 1] then
    begin
      LinSolver := slsDefault
    end
    else
    begin
      LinSolver := TSmsLinearSolver(FLinearSolverPickList.IndexOf(
        rdgOptions.Cells[Ord(scValue), Ord(soLinearSolver) + 1]))
    end;

    case LinSolver of
      slsDefault:
        begin
          rdgOptions.Checked[Ord(scOverride), Ord(soInnerRclose) + 1] := True;
          rdgOptions.Checked[Ord(scOverride), Ord(soLinLinearAcceleration) + 1] := True;
        end;
      slsXMD:
        begin
          rdgOptions.Checked[Ord(scOverride), Ord(soXmdLinearAcceleration) + 1] := True;
          rdgOptions.Checked[Ord(scOverride), Ord(soPreconditionerLevel) + 1] := True;
          rdgOptions.Checked[Ord(scOverride), Ord(soNumberOfOrthoganalizations) + 1] := True;
        end;
    end;
    rdgOptions.Invalidate;
  end;
end;

constructor TframePkgSms.Create(AOwner: TComponent);
begin
  inherited;
  FUnderRelaxPickList := TStringList.Create;
  FUnderRelaxPickList.Add('None');
  FUnderRelaxPickList.Add('DBD');
  FUnderRelaxPickList.Add('Cooley');

  FLinearSolverPickList := TStringList.Create;
  FLinearSolverPickList.Add('Linear');
  FLinearSolverPickList.Add('XMD');

  FRCloseOptionPickList := TStringList.Create;
  FRCloseOptionPickList.Add('Absolute');
  FRCloseOptionPickList.Add('L2Norm');
  FRCloseOptionPickList.Add('Relative');

  FLinLinearAccPickList := TStringList.Create;
  FLinLinearAccPickList.Add('CG');
  FLinLinearAccPickList.Add('BICGSTAB');

  FReorderingPickList := TStringList.Create;
  FReorderingPickList.Add('None');
  FReorderingPickList.Add('reverse Cuthill McKee');
  FReorderingPickList.Add('minimum degree');

  FScalingMethodPickList := TStringList.Create;
  FScalingMethodPickList.Add('None');
  FScalingMethodPickList.Add('Diagonal');
  FScalingMethodPickList.Add('L2Norm');

  FXmdLinearAccPickList := TStringList.Create;
  FXmdLinearAccPickList.Add('CG');
  FXmdLinearAccPickList.Add('ORTHOMIN');
  FXmdLinearAccPickList.Add('BICGSTAB');
end;

destructor TframePkgSms.Destroy;
begin
  FXmdLinearAccPickList.Free;
  FScalingMethodPickList.Free;
  FReorderingPickList.Free;
  FLinLinearAccPickList.Free;
  FRCloseOptionPickList.Free;
  FLinearSolverPickList.Free;
  FUnderRelaxPickList.Free;
  inherited;
end;

procedure TframePkgSms.GetData(Package: TModflowPackageSelection);
var
  SmsPackage: TSmsPackageSelection;
  SmsOveride: TSmsOverride;
begin
  inherited;
  rdgOptions.BeginUpdate;
  try
    if not FInitializedGrid then
    begin
      InitializeGrid;
      FInitializedGrid := True;
    end;

    SmsPackage := Package as TSmsPackageSelection;

    seSolutionGroupMaxIter.AsInteger := SmsPackage.SolutionGroupMaxIteration;
    comboPrintOption.ItemIndex := Ord(SmsPackage.Print);
    comboComplexity.ItemIndex := Ord(SmsPackage.Complexity);
    cbContinue.Checked := SmsPackage.ContinueModel;

    for SmsOveride := Low(TSmsOverride) to High(TSmsOverride) do
    begin
      rdgOptions.Checked[Ord(scOverride), Ord(SmsOveride)+1] :=
        SmsOveride in SmsPackage.SmsOverrides;
    end;

    rdgOptions.RealValue[Ord(scValue), Ord(soOuterHclose)+1] :=
      SmsPackage.OuterHclose;
    rdgOptions.IntegerValue[Ord(scValue), Ord(soOuterMaxIt)+1] :=
      SmsPackage.MaxOuterIterations;
    rdgOptions.Cells[Ord(scValue), Ord(soUnderRelax)+1] :=
      FUnderRelaxPickList[Ord(SmsPackage.UnderRelaxation)];
    rdgOptions.RealValue[Ord(scValue), Ord(soUnderRelaxTheta)+1] :=
      SmsPackage.UnderRelaxTheta;
    rdgOptions.RealValue[Ord(scValue), Ord(soUnderRelaxKappa)+1] :=
      SmsPackage.UnderRelaxKappa;
    rdgOptions.RealValue[Ord(scValue), Ord(soUnderRelaxGamma)+1] :=
      SmsPackage.UnderRelaxGamma;
    rdgOptions.RealValue[Ord(scValue), Ord(soUnderRelaxMomentum)+1] :=
      SmsPackage.UnderRelaxMomentum;
    rdgOptions.IntegerValue[Ord(scValue), Ord(soBacktrackingNumber)+1] :=
      SmsPackage.BacktrackingNumber;
    rdgOptions.RealValue[Ord(scValue), Ord(soBacktrackingTolerance)+1] :=
      SmsPackage.BacktrackingTolerance;
    rdgOptions.RealValue[Ord(scValue), Ord(soBacktrackingReductionFactor)+1] :=
      SmsPackage.BacktrackingReductionFactor;
    rdgOptions.RealValue[Ord(scValue), Ord(soBacktrackingResidualLimit)+1] :=
      SmsPackage.BacktrackingResidualLimit;
    rdgOptions.Cells[Ord(scValue), Ord(soLinearSolver)+1] :=
      FLinearSolverPickList[Ord(SmsPackage.LinearSolver)];
    rdgOptions.IntegerValue[Ord(scValue), Ord(soInnerMaxIterations)+1] :=
      SmsPackage.InnerMaxIterations;
    rdgOptions.RealValue[Ord(scValue), Ord(soInnerHclose)+1] :=
      SmsPackage.InnerHclose;
    rdgOptions.RealValue[Ord(scValue), Ord(soInnerRclose)+1] :=
      SmsPackage.InnerRclose;
    rdgOptions.Cells[Ord(scValue), Ord(soLinLinearAcceleration)+1] :=
      FLinLinearAccPickList[Ord(SmsPackage.LinLinearAcceleration)];
    rdgOptions.IntegerValue[Ord(scValue), Ord(soPreconditionerLevel)+1] :=
      SmsPackage.PreconditionerLevel;
    rdgOptions.IntegerValue[Ord(scValue), Ord(soNumberOfOrthoganalizations)+1] :=
      SmsPackage.NumberOfOrthoganalizations;
    rdgOptions.Cells[Ord(scValue), Ord(soReorderingMethod)+1] :=
      FReorderingPickList[Ord(SmsPackage.ReorderingMethod)];
    rdgOptions.RealValue[Ord(scValue), Ord(soPreconditionerDropTolerance)+1] :=
      SmsPackage.PreconditionerDropTolerance;
    rdgOptions.Cells[Ord(scValue), Ord(soRcloseOption)+1] :=
      FRCloseOptionPickList[Ord(SmsPackage.RcloseOption)];
    rdgOptions.RealValue[Ord(scValue), Ord(soRelaxationFactor)+1] :=
      SmsPackage.RelaxationFactor;
    rdgOptions.Cells[Ord(scValue), Ord(soScalingMethod)+1] :=
      FScalingMethodPickList[Ord(SmsPackage.ScalingMethod)];
    rdgOptions.Cells[Ord(scValue), Ord(soXmdLinearAcceleration)+1] :=
      FXmdLinearAccPickList[Ord(SmsPackage.XmdLinearAcceleration)];
    rdgOptions.Checked[Ord(scValue), Ord(soRedBlackOrder)+1] :=
      SmsPackage.RedBlackOrder;
  finally
    rdgOptions.EndUpdate;
  end;

end;

procedure TframePkgSms.InitializeGrid;
begin
  rdgOptions.BeginUpdate;
  try
    rdgOptions.Columns[Ord(scValue)].PickList := FReorderingPickList;

    rdgOptions.Cells[Ord(scName), 0] := 'Option';
    rdgOptions.Cells[Ord(scOverride), 0] := 'Override';
    rdgOptions.Cells[Ord(scValue), 0] := 'Value';

    rdgOptions.Cells[Ord(scName), Ord(soOuterHclose)+1] := 'Outer HClose';
    rdgOptions.Cells[Ord(scName), Ord(soOuterMaxIt)+1] := 'Outer maximum iterations';
    rdgOptions.Cells[Ord(scName), Ord(soUnderRelax)+1] := 'Under-relaxation scheme';
    rdgOptions.Cells[Ord(scName), Ord(soUnderRelaxTheta)+1] := 'Under relaxation theta';
    rdgOptions.Cells[Ord(scName), Ord(soUnderRelaxKappa)+1] := 'Under relaxation kappa';
    rdgOptions.Cells[Ord(scName), Ord(soUnderRelaxGamma)+1] := 'Under relaxation gamma';
    rdgOptions.Cells[Ord(scName), Ord(soUnderRelaxMomentum)+1] := 'Under relaxation momentum';
    rdgOptions.Cells[Ord(scName), Ord(soBacktrackingNumber)+1] := 'Backtracking number';
    rdgOptions.Cells[Ord(scName), Ord(soBacktrackingTolerance)+1] := 'Backtracking tolerance';
    rdgOptions.Cells[Ord(scName), Ord(soBacktrackingReductionFactor)+1] := 'Backtracking reduction factor';
    rdgOptions.Cells[Ord(scName), Ord(soBacktrackingResidualLimit)+1] := 'Backtracking residual limit';
    rdgOptions.Cells[Ord(scName), Ord(soLinearSolver)+1] := 'Linear solver';
    rdgOptions.Cells[Ord(scName), Ord(soInnerMaxIterations)+1] := 'Inner maximum iterations';
    rdgOptions.Cells[Ord(scName), Ord(soInnerHclose)+1] := 'Inner HClose';
    rdgOptions.Cells[Ord(scName), Ord(soInnerRclose)+1] := 'Inner RClose';
    rdgOptions.Cells[Ord(scName), Ord(soLinLinearAcceleration)+1] := 'Linear acceleration (Linear block)';
    rdgOptions.Cells[Ord(scName), Ord(soPreconditionerLevel)+1] := 'Preconditioner levels';
    rdgOptions.Cells[Ord(scName), Ord(soNumberOfOrthoganalizations)+1] := 'Number of orthogonalizations';
    rdgOptions.Cells[Ord(scName), Ord(soReorderingMethod)+1] := 'Reordering method';
    rdgOptions.Cells[Ord(scName), Ord(soPreconditionerDropTolerance)+1] := 'Preconditioner drop tolerance';
    rdgOptions.Cells[Ord(scName), Ord(soRcloseOption)+1] := 'Rclose option';
    rdgOptions.Cells[Ord(scName), Ord(soRelaxationFactor)+1] := 'Relaxation factor';
    rdgOptions.Cells[Ord(scName), Ord(soScalingMethod)+1] := 'Scaling method';
    rdgOptions.Cells[Ord(scName), Ord(soXmdLinearAcceleration)+1] := 'Linear acceleration (XMD block)';
    rdgOptions.Cells[Ord(scName), Ord(soRedBlackOrder)+1] := 'Use red-black ordering scheme';


    rdgOptions.SpecialFormat[Ord(scValue), Ord(soOuterMaxIt)+1] := rcf4Integer;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soOuterMaxIt)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soUnderRelax)+1] := rcf4String;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soUnderRelax)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soBacktrackingNumber)+1] := rcf4Integer;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soBacktrackingNumber)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soLinearSolver)+1] := rcf4String;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soLinearSolver)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soInnerMaxIterations)+1] := rcf4Integer;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soInnerMaxIterations)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soLinLinearAcceleration)+1] := rcf4String;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soLinLinearAcceleration)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soPreconditionerLevel)+1] := rcf4Integer;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soPreconditionerLevel)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soNumberOfOrthoganalizations)+1] := rcf4Integer;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soNumberOfOrthoganalizations)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soReorderingMethod)+1] := rcf4String;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soReorderingMethod)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soRcloseOption)+1] := rcf4String;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soRcloseOption)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soScalingMethod)+1] := rcf4String;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soScalingMethod)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soXmdLinearAcceleration)+1] := rcf4String;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soXmdLinearAcceleration)+1] := True;

    rdgOptions.SpecialFormat[Ord(scValue), Ord(soRedBlackOrder)+1] := rcf4Boolean;
    rdgOptions.UseSpecialFormat[Ord(scValue), Ord(soRedBlackOrder)+1] := True;


  finally
    rdgOptions.EndUpdate;
  end;
end;

procedure TframePkgSms.rdgOptionsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  SmsOverride: TSmsOverride;
  AColumn: TRbwColumn4;
  SmsColumn: TSmsColumns;
  function Solver: TSmsLinearSolver;
  begin
    if not rdgOptions.Checked[Ord(scOverride), Ord(soLinearSolver) + 1] then
    begin
      result := slsDefault
    end
    else
    begin
      result := TSmsLinearSolver(FLinearSolverPickList.IndexOf(
        rdgOptions.Cells[Ord(scValue), Ord(soLinearSolver) + 1]))
    end;
  end;
  function Complexity: TSmsComplexityOption;
  begin
    result := TSmsComplexityOption(comboComplexity.ItemIndex);
  end;
  function BackTrackingNumber: integer;
  begin
    if rdgOptions.Checked[Ord(scOverride), Ord(soBacktrackingNumber)+1] then
    begin
      result := rdgOptions.IntegerValueDefault[Ord(scValue), Ord(soBacktrackingNumber)+1, 0];
    end
    else
    begin
      result := 0;
    end;
  end;
  function UnderRelaxation: TSmsUnderRelaxation;
  begin
    if rdgOptions.Checked[Ord(scOverride), Ord(soUnderRelax)+1] then
    begin
      result := TSmsUnderRelaxation(FUnderRelaxPickList.IndexOf(
        rdgOptions.Cells[Ord(scValue), Ord(soUnderRelax)+1]));
    end
    else
    begin
      result := surNone;
    end;
  end;
begin
  inherited;

  if (ARow >= 1) and (ACol >= 1) then
  begin
    SmsOverride := TSmsOverride(ARow-1);
    SmsColumn := TSmsColumns(ACol);
    case SmsColumn of
      scOverride:
        begin
          case SmsOverride of
            soOuterHclose, soOuterMaxIt, soUnderRelax:
              begin
                // The user must specify OUTER_HCLOSE, OUTER_MAXIMUM,
                // and UNDER_RELAXATION if the Complexity is specified.
                CanSelect := Complexity <> scoSpecified;
              end;
            soUnderRelaxTheta, soUnderRelaxKappa, soUnderRelaxGamma,
              soUnderRelaxMomentum:
              begin
                CanSelect := (UnderRelaxation = surNone);
              end;
            soBacktrackingNumber:
              begin
                CanSelect := True;
              end;
            soBacktrackingTolerance, soBacktrackingReductionFactor,
              soBacktrackingResidualLimit:
              begin
                CanSelect := BackTrackingNumber > 0;
              end;
            soLinearSolver:
              begin
                CanSelect := True;
              end;
            soInnerMaxIterations, soInnerHclose:
              begin
                // The user must specify INNER_MAXIMUM
                // and INNER_HCLOSE if the Complexity is specified
                CanSelect := Complexity <> scoSpecified;
              end;
            soInnerRclose:
              begin
                // The user must specify INNER_RCLOSE if the Complexity is specified
                // and the linear solver is used.
                // INNER_RCLOSE is optional in the XMD solver.
                CanSelect := (Complexity <> scoSpecified) or (Solver = slsXMD);
              end;
            soRcloseOption:
              begin
                // RcloseOption is only used with RClose in the default
                // linear block
                CanSelect := (Solver = slsDefault)
                  and rdgOptions.Checked[Ord(scOverride), Ord(soInnerRclose)+1];
              end;
            soLinLinearAcceleration:
              begin
                // The user must specify LINEAR_ACCELERATION
                // for the linear solver
                // if the Complexity is specified
                // LINEAR_ACCELERATION is specified by a different variable
                // for the XMD solver.
                CanSelect := (Solver = slsDefault)
                  and (Complexity <> scoSpecified)
              end;
            soPreconditionerLevel, soNumberOfOrthoganalizations:
              begin
                // When the Complexity is specified,
                // PRECONDITIONER_LEVELS and NUMBER_ORTHOGONALIZATIONS
                // are required in the XMD solver but is optional in the
                // default linear solver.
                CanSelect := (Solver <> slsXMD) or (Complexity <> scoSpecified)
              end;
            soReorderingMethod:
              begin
                // REORDERING_METHOD is optional with either solver.
                CanSelect := True;
              end;
            soPreconditionerDropTolerance:
              begin
                // When the Complexity is specified,
                // PRECONDITIONER_DROP_TOLERANCE
                // is required in the XMD solver but is optional in the
                // default linear solver.
                CanSelect := (Solver <> slsXMD) or (Complexity <> scoSpecified)
              end;
            soRelaxationFactor, soScalingMethod:
              begin
                // RELAXATION_FACTOR and [SCALING_METHOD are only used with
                // the default linear solver.
                CanSelect := Solver = slsDefault
              end;
            soXmdLinearAcceleration:
              begin
                // The user must specify LINEAR_ACCELERATION
                // for the XMD solver
                // if the Complexity is specified
                // LINEAR_ACCELERATION is specified by a different variable
                // for the linear solver.
                CanSelect := (Solver = slsXMD) and (Complexity <> scoSpecified)
              end;
            soRedBlackOrder:
              begin
                // RED_BLACK_ORDERING is only used with the XMD solver.
                CanSelect := (Solver = slsXMD)
              end;
            else
              Assert(False);
          end;
        end;
      scValue:
        begin
          if Complexity = scoSpecified then
          begin
            if SmsOverride in [soOuterHclose, soOuterMaxIt, soUnderRelax,
              soInnerMaxIterations, soInnerHclose] then
            begin
              CanSelect := true;
            end
            else if SmsOverride in [soInnerRclose, soLinLinearAcceleration] then
            begin
              CanSelect := (Solver = slsDefault)
            end
            else if SmsOverride in [soXmdLinearAcceleration, soPreconditionerLevel, soNumberOfOrthoganalizations] then
            begin
              CanSelect := (Solver = slsXMD)
            end
            else
            begin
              rdgOptionsSelectCell(Sender, Ord(scOverride), ARow, CanSelect);
            end;
          end
          else
          begin
            rdgOptionsSelectCell(Sender, Ord(scOverride), ARow, CanSelect);
          end;

          if CanSelect then
          begin
            CanSelect := rdgOptions.Checked[ACol-1, ARow];
          end;
        end;
      else Assert(False);
    end;

    if (SmsColumn = scValue) and not rdgOptions.Drawing  then
    begin
      AColumn := rdgOptions.Columns[ACol];
      case SmsOverride of
        soOuterHclose:
          begin
            AColumn.ComboUsed := False;
          end;
        soOuterMaxIt:
          begin
            AColumn.ComboUsed := False;
          end;
        soUnderRelax:
          begin
            AColumn.ComboUsed := True;
            AColumn.PickList := FUnderRelaxPickList;
          end;
        soUnderRelaxTheta:
          begin
            AColumn.ComboUsed := False;
          end;
        soUnderRelaxKappa:
          begin
            AColumn.ComboUsed := False;
          end;
        soUnderRelaxGamma:
          begin
            AColumn.ComboUsed := False;
          end;
        soUnderRelaxMomentum:
          begin
            AColumn.ComboUsed := False;
          end;
        soBacktrackingNumber:
          begin
            AColumn.ComboUsed := False;
          end;
        soBacktrackingTolerance:
          begin
            AColumn.ComboUsed := False;
          end;
        soBacktrackingReductionFactor:
          begin
            AColumn.ComboUsed := False;
          end;
        soBacktrackingResidualLimit:
          begin
            AColumn.ComboUsed := False;
          end;
        soLinearSolver:
          begin
            AColumn.ComboUsed := True;
            AColumn.PickList := FLinearSolverPickList;
          end;
        soInnerMaxIterations:
          begin
            AColumn.ComboUsed := False;
          end;
        soInnerHclose:
          begin
            AColumn.ComboUsed := False;
          end;
        soInnerRclose:
          begin
            AColumn.ComboUsed := False;
          end;
        soRcloseOption:
          begin
            AColumn.ComboUsed := True;
            AColumn.PickList := FRCloseOptionPickList;
          end;
        soLinLinearAcceleration:
          begin
            AColumn.ComboUsed := True;
            AColumn.PickList := FLinLinearAccPickList;
          end;
        soPreconditionerLevel:
          begin
            AColumn.ComboUsed := False;
          end;
        soNumberOfOrthoganalizations:
          begin
            AColumn.ComboUsed := False;
          end;
        soReorderingMethod:
          begin
            AColumn.ComboUsed := True;
            AColumn.PickList := FReorderingPickList;
          end;
        soPreconditionerDropTolerance:
          begin
            AColumn.ComboUsed := False;
          end;
        soRelaxationFactor:
          begin
            AColumn.ComboUsed := False;
          end;
        soScalingMethod:
          begin
            AColumn.ComboUsed := True;
            AColumn.PickList := FScalingMethodPickList;
          end;
        soXmdLinearAcceleration:
          begin
            AColumn.ComboUsed := True;
            AColumn.PickList := FXmdLinearAccPickList;
          end;
        soRedBlackOrder:
          begin
            AColumn.ComboUsed := False;
          end;
        else
          Assert(False);
      end;
    end;
  end;
end;

procedure TframePkgSms.rdgOptionsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
var
  FloatValue: Extended;
  SmsOverride: TSmsOverride;
begin
  inherited;
  if (ARow >= 1) and (ACol = Ord(scValue)) then
  begin
    SmsOverride := TSmsOverride(ARow-1);
    if SmsOverride in [soUnderRelaxTheta, soUnderRelaxKappa, soUnderRelaxGamma,
        soUnderRelaxMomentum, soBacktrackingTolerance,
        soBacktrackingReductionFactor, soRelaxationFactor] then
    begin
      if TryStrToFloat(Value, FloatValue) then
      begin
        if FloatValue > 1 then
        begin
          Beep;
          rdgOptions.Cells[ACol,ARow] := '1';
        end;
      end;
    end;
    if SmsOverride = soLinearSolver then
    begin
      comboComplexityChange(Sender);
    end;
    rdgOptions.Invalidate;
  end
end;

procedure TframePkgSms.rdgOptionsStateChange(Sender: TObject; ACol,
  ARow: Integer; const Value: TCheckBoxState);
begin
  inherited;
  rdgOptions.Invalidate;
end;

procedure TframePkgSms.SetData(Package: TModflowPackageSelection);
var
  SmsPackage: TSmsPackageSelection;
  NewOverRides: TSmsOverrides;
  SmsOveride: TSmsOverride;
begin
  inherited;
  SmsPackage := Package as TSmsPackageSelection;

  SmsPackage.SolutionGroupMaxIteration := seSolutionGroupMaxIter.AsInteger;
  SmsPackage.Print := TSmsPrint(comboPrintOption.ItemIndex);
  SmsPackage.Complexity := TSmsComplexityOption(comboComplexity.ItemIndex);
  SmsPackage.ContinueModel := cbContinue.Checked;


  NewOverRides := [];
  for SmsOveride := Low(TSmsOverride) to High(TSmsOverride) do
  begin
    if rdgOptions.Checked[Ord(scOverride), Ord(SmsOveride)+1] then
    begin
      Include(NewOverRides, SmsOveride);
    end;
  end;
  SmsPackage.SmsOverrides := NewOverRides;

  SmsPackage.OuterHclose := rdgOptions.RealValueDefault[Ord(scValue), Ord(soOuterHclose)+1, SmsPackage.OuterHclose];
  SmsPackage.MaxOuterIterations := rdgOptions.IntegerValue[Ord(scValue), Ord(soOuterMaxIt)+1];
  SmsPackage.UnderRelaxation := TSmsUnderRelaxation(FUnderRelaxPickList.IndexOf(rdgOptions.Cells[Ord(scValue), Ord(soUnderRelax)+1]));

  SmsPackage.UnderRelaxTheta := rdgOptions.RealValueDefault[Ord(scValue), Ord(soUnderRelaxTheta)+1, SmsPackage.UnderRelaxTheta ];
  SmsPackage.UnderRelaxKappa := rdgOptions.RealValueDefault[Ord(scValue), Ord(soUnderRelaxKappa)+1, SmsPackage.UnderRelaxKappa];
  SmsPackage.UnderRelaxGamma := rdgOptions.RealValueDefault[Ord(scValue), Ord(soUnderRelaxGamma)+1, SmsPackage.UnderRelaxGamma];
  SmsPackage.UnderRelaxMomentum := rdgOptions.RealValueDefault[Ord(scValue), Ord(soUnderRelaxMomentum)+1, SmsPackage.UnderRelaxMomentum];
  SmsPackage.BacktrackingNumber := rdgOptions.IntegerValue[Ord(scValue), Ord(soBacktrackingNumber)+1];
  SmsPackage.BacktrackingTolerance := rdgOptions.RealValueDefault[Ord(scValue), Ord(soBacktrackingTolerance)+1, SmsPackage.BacktrackingTolerance];
  SmsPackage.BacktrackingReductionFactor := rdgOptions.RealValueDefault[Ord(scValue), Ord(soBacktrackingReductionFactor)+1, SmsPackage.BacktrackingReductionFactor];
  SmsPackage.BacktrackingResidualLimit := rdgOptions.RealValueDefault[Ord(scValue), Ord(soBacktrackingResidualLimit)+1, SmsPackage.BacktrackingResidualLimit];
  SmsPackage.LinearSolver := TSmsLinearSolver(FLinearSolverPickList.IndexOf(rdgOptions.Cells[Ord(scValue), Ord(soLinearSolver)+1]));
  SmsPackage.InnerMaxIterations := rdgOptions.IntegerValue[Ord(scValue), Ord(soInnerMaxIterations)+1];
  SmsPackage.InnerHclose := rdgOptions.RealValueDefault[Ord(scValue), Ord(soInnerHclose)+1, SmsPackage.InnerHclose];
  SmsPackage.InnerRclose := rdgOptions.RealValueDefault[Ord(scValue), Ord(soInnerRclose)+1, SmsPackage.InnerRclose];
  SmsPackage.LinLinearAcceleration := TSmsLinLinearAcceleration(FLinLinearAccPickList.IndexOf(rdgOptions.Cells[Ord(scValue), Ord(soLinLinearAcceleration)+1]));
  SmsPackage.PreconditionerLevel := rdgOptions.IntegerValue[Ord(scValue), Ord(soPreconditionerLevel)+1];
  SmsPackage.NumberOfOrthoganalizations := rdgOptions.IntegerValue[Ord(scValue), Ord(soNumberOfOrthoganalizations)+1];
  SmsPackage.ReorderingMethod := TSmsReorderingMethod(FReorderingPickList.IndexOf(rdgOptions.Cells[Ord(scValue), Ord(soReorderingMethod)+1]));
  SmsPackage.PreconditionerDropTolerance := rdgOptions.RealValueDefault[Ord(scValue), Ord(soPreconditionerDropTolerance)+1, SmsPackage.PreconditionerDropTolerance];
  SmsPackage.RcloseOption := TSmsRcloseOption(FRCloseOptionPickList.IndexOf(rdgOptions.Cells[Ord(scValue), Ord(soRcloseOption)+1]));
  SmsPackage.RelaxationFactor := rdgOptions.RealValueDefault[Ord(scValue), Ord(soRelaxationFactor)+1, SmsPackage.RelaxationFactor];
  SmsPackage.ScalingMethod := TSmsScalingMethod(FScalingMethodPickList.IndexOf(rdgOptions.Cells[Ord(scValue), Ord(soScalingMethod)+1]));
  SmsPackage.XmdLinearAcceleration := TSmsXmdLinearAcceleration(FXmdLinearAccPickList.IndexOf(rdgOptions.Cells[Ord(scValue), Ord(soXmdLinearAcceleration)+1]));
  SmsPackage.RedBlackOrder := rdgOptions.Checked[Ord(scValue), Ord(soRedBlackOrder)+1];

end;

end.
