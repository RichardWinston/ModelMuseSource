unit framePackageNpfUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, framePackageUnit, RbwController,
  Vcl.StdCtrls, JvExStdCtrls, JvCombobox, JvListComb, Vcl.Grids, RbwDataGrid4,
  ModflowPackageSelectionUnit;

type
  TNprOptions = (noThickStrt, noVaryingVerticalConductance, noDewatered,
    noPerched, noNewton, noDampening);

  TframePackageNpf = class(TframePackage)
    rdgOptions: TRbwDataGrid4;
    lblInterblockMethod: TLabel;
    comboInterblockMethod: TJvImageComboBox;
    procedure FrameResize(Sender: TObject);
    procedure rdgOptionsVerticalScroll(Sender: TObject);
    procedure rdgOptionsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
  protected
    procedure Loaded; override;
  public
    procedure GetData(Package: TModflowPackageSelection); override;
    procedure SetData(Package: TModflowPackageSelection); override;
    { Public declarations }
  end;

var
  framePackageNpf: TframePackageNpf;

implementation

resourcestring
  StrCellsHavingANegat = 'Cells having a negative CellType are confined. How' +
  'ever, their cell thickness for conductance calculations will be based on ' +
  'the saturated thickness rather than the cell height (THICKSTRT)';
  StrVerticalConductance = 'Vertical conductance will be recalculated each t' +
  'ime step based on saturated thickness (VARIABLECV).';
  StrDewatered = 'When a cell is less than fully saturated, the vertical con' +
  'ductance of the overlying cell will depend only on the properties of the ' +
  'overlying cell (DEWATERED).';
  StrPerched = 'When a cell is less than fully saturated, the vertical head ' +
  'gradient between it and the overlying cell will be the difference between' +
  ' the head in the overlying cell and the bottom of the overlying cell (PER' +
  'CHED)';
  StrActivateTheNewton = 'Activate the Newton-Raphson formulation for ground' +
  'water flow between connected, convertible groundwater cells (NEWTON).';
  StrGroundwaterHeadIn = 'Groundwater head in a cell will be dampened when w' +
  'ater levels fall below the bottom of a cell (NEWTON HEAD DAMPENING).';

{$R *.dfm}

procedure TframePackageNpf.FrameResize(Sender: TObject);
begin
  inherited;
  rdgOptions.BeginUpdate;
  rdgOptions.ColWidths[0] := rdgOptions.Width-4;
  rdgOptions.EndUpdate;
end;

procedure TframePackageNpf.GetData(Package: TModflowPackageSelection);
var
  NpfPackage: TNpfPackage;
begin
  inherited;
  NpfPackage := Package as TNpfPackage;
  comboInterblockMethod.ItemIndex := Ord(NpfPackage.CellAveraging);
  rdgOptions.Checked[0, Ord(noThickStrt)] := NpfPackage.UseSaturatedThickness;
  rdgOptions.Checked[0, Ord(noVaryingVerticalConductance)] := NpfPackage.TimeVaryingVerticalConductance;
  rdgOptions.Checked[0, Ord(noDewatered)] := NpfPackage.Dewatered;
  rdgOptions.Checked[0, Ord(noPerched)] := NpfPackage.Perched;
  rdgOptions.Checked[0, Ord(noNewton)] := NpfPackage.UseNewtonRaphson;
  rdgOptions.Checked[0, Ord(noDampening)] := NpfPackage.ApplyHeadDampening;
end;

procedure TframePackageNpf.Loaded;
begin
  inherited;
  rdgOptions.BeginUpdate;
  try
    FrameResize(self);
    rdgOptions.Cells[0, Ord(noThickStrt)] := StrCellsHavingANegat;
    rdgOptions.Cells[0, Ord(noVaryingVerticalConductance)] := StrVerticalConductance;
    rdgOptions.Cells[0, Ord(noDewatered)] := StrDewatered;
    rdgOptions.Cells[0, Ord(noPerched)] := StrPerched;
    rdgOptions.Cells[0, Ord(noNewton)] := StrActivateTheNewton;
    rdgOptions.Cells[0, Ord(noDampening)] := StrGroundwaterHeadIn;

  finally
    rdgOptions.EndUpdate;

  end;
end;

procedure TframePackageNpf.rdgOptionsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  if (ACol >= 0)  then
  begin
    if ARow = Ord(noDewatered) then
    begin
      CanSelect := rdgOptions.Checked[0, Ord(noVaryingVerticalConductance)];
    end
    else  if ARow = Ord(noDampening) then
    begin
      CanSelect := rdgOptions.Checked[0, Ord(noNewton)];
    end;
  end;
end;

procedure TframePackageNpf.rdgOptionsVerticalScroll(Sender: TObject);
begin
  inherited;
  // this ensures that the cells are redrawn properly.
  rdgOptions.EditorMode := False;
end;

procedure TframePackageNpf.SetData(Package: TModflowPackageSelection);
var
  NpfPackage: TNpfPackage;
begin
  inherited;
  NpfPackage := Package as TNpfPackage;
  NpfPackage.CellAveraging := TCellAveraging(comboInterblockMethod.ItemIndex);
  NpfPackage.UseSaturatedThickness := rdgOptions.Checked[0, Ord(noThickStrt)];
  NpfPackage.TimeVaryingVerticalConductance := rdgOptions.Checked[0, Ord(noVaryingVerticalConductance)];
  NpfPackage.Dewatered := rdgOptions.Checked[0, Ord(noDewatered)];
  NpfPackage.Perched := rdgOptions.Checked[0, Ord(noPerched)];
  NpfPackage.UseNewtonRaphson := rdgOptions.Checked[0, Ord(noNewton)];
  NpfPackage.ApplyHeadDampening := rdgOptions.Checked[0, Ord(noDampening)];
end;

end.
