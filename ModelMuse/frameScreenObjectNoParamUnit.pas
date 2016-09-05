{@name defines @link(TframeScreenObjectParam).}
unit frameScreenObjectNoParamUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, Dialogs, Grids, Math, RbwDataGrid4, JvExControls, JvComponent,
  JvxCheckListBox, ExtCtrls, Buttons, Mask, JvExMask, JvSpin, ArgusDataEntry,
  ModflowBoundaryUnit, frameScreenObjectUnit;

type
  // See @link(TframeScreenObjectParam.UnselectableColumnsIfParametersUsed).
  TColumn = 0..255;
  // See @link(TframeScreenObjectParam.UnselectableColumnsIfParametersUsed).
  TColumns = set of TColumn;


  {
    @abstract(@name is used to define time-varying MODFLOW
    boundary condition data associated with @link(TScreenObject)s
    when parameter instances can NOT be defined.)
    Typically, the first two columns of @link(dgModflowBoundary) will have
    the start and ending times for the boundary condtion.  Following that
    will be columns representing the values to be assigned the boundary.

    @member(dgModflowBoundary @name is used to indicate the time-varying
      boundary condition values.)
    @member(pnlBottom @name holds buttons and controls that affect
      @link(dgModflowBoundary).)
    @member(seNumberOfTimes @name specifies the number of times at which
      the parameter is specified and thus the number of rows in
      @link(dgModflowBoundary).)
    @member(lblNumTimes @name labels @link(seNumberOfTimes).)
    @member(btnDelete @name deletes one of the times at which
      the parameter is specified.)
    @member(btnInsert @name inserts a new time at which
      the boundary condition is specified.)
    @member(dgModflowBoundarySelectCell @name prevents the user from selecting
      certain cells.)
    @member(seNumberOfTimesChange @name changes the number of rows
      in @link(dgModflowBoundary) and takes other related actions. @name is
      the OnChange event handler for @link(seNumberOfTimes).)
    @member(btnDeleteClick @name deletes the selected row in
      @link(dgModflowBoundary).  @name is the OnClick eventhandler for
      @link(btnDelete).)
    @member(btnInsertClick @name inserts a new row beneath the selected row in
      @link(dgModflowBoundary).  @name is the OnClick eventhandler for
      @link(btnInsert).)
  }
  TframeScreenObjectNoParam = class(TframeScreenObject)
    dgModflowBoundary: TRbwDataGrid4;
    pnlBottom: TPanel;
    seNumberOfTimes: TJvSpinEdit;
    lblNumTimes: TLabel;
    btnDelete: TBitBtn;
    btnInsert: TBitBtn;
    pnlTop: TPanel;
    pnlCaption: TPanel;
    pnlGrid: TPanel;
    pnlEditGrid: TPanel;
    lblFormula: TLabel;
    rdeFormula: TRbwDataEntry;
    procedure dgModflowBoundarySelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure seNumberOfTimesChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure dgModflowBoundaryMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rdeFormulaChange(Sender: TObject);
    procedure dgModflowBoundaryHorizontalScroll(Sender: TObject);
    procedure dgModflowBoundaryColSize(Sender: TObject; ACol,
      PriorWidth: Integer);
    procedure FrameResize(Sender: TObject);
    procedure dgModflowBoundarySetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure dgModflowBoundaryBeforeDrawCell(Sender: TObject; ACol,
      ARow: Integer);
  private
    FSelectedText: string;
    FDeleting: Boolean;
    FDeletedCells: array of array of boolean;
    FConductanceColumn: Integer;
    // See @link(DeletedCells)
    function GetDeletedCells(ACol, ARow: integer): boolean;
    // See @link(DeletedCells)
    procedure SetDeletedCells(ACol, ARow: integer; const Value: boolean);
    { Private declarations }
  protected
    procedure LayoutMultiRowEditControls; virtual;
  public
    property ConductanceColumn: Integer read FConductanceColumn write FConductanceColumn;
    procedure ClearDeletedCells;
    property DeletedCells[ACol, ARow: integer]: boolean read GetDeletedCells
      write SetDeletedCells;
    function ConductanceCaption(DirectCaption: string): string; virtual;
    procedure InitializeNoParamFrame(
      Boundary: TModflowBoundary);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // @name loads the starting times of all the MODFLOW stress periods into
    // the @link(TCustomRowOrColumn.PickList) of the
    // @link(TCustomRowOrColumn column) of @link(dgModflowBoundary)
    // specified by Col.
    procedure GetStartTimes(Col: integer);
    // @name loads the ending times of all the MODFLOW stress periods into
    // the @link(TCustomRowOrColumn.PickList) of the
    // @link(TCustomRowOrColumn column) of @link(dgModflowBoundary)
    // specified by Col.
    procedure GetEndTimes(Col: Integer);
    procedure SetButtonCaptions;
    { Public declarations }
  end;

implementation

uses OrderedCollectionUnit, frmGoPhastUnit, ModflowTimeUnit,
  frmCustomGoPhastUnit, GoPhastTypes;

resourcestring
  StrF = 'F()';


{$R *.dfm}

{ TframeScreenObjectParam }

procedure TframeScreenObjectNoParam.ClearDeletedCells;
begin
  SetLength(FDeletedCells, 0, 0);
end;

function TframeScreenObjectNoParam.ConductanceCaption(DirectCaption: string): string;
begin
  result := DirectCaption;
end;

procedure TframeScreenObjectNoParam.InitializeNoParamFrame(
  Boundary: TModflowBoundary);
var
  Index: integer;
  TimeList: TModflowTimeList;
  GridRect: TGridRect;
  ColIndex: Integer;
  RowIndex: Integer;
begin
  seNumberOfTimes.AsInteger := 0;
  for ColIndex := 0 to dgModflowBoundary.ColCount - 1 do
  begin
    dgModflowBoundary.Objects[ColIndex,0] := nil;
    dgModflowBoundary.Columns[ColIndex].WordWrapCaptions := True;
    for RowIndex := 1 to dgModflowBoundary.RowCount - 1 do
    begin
      dgModflowBoundary.Cells[ColIndex,RowIndex] := '';
    end;
  end;
  dgModflowBoundary.Columns[0].Format := rcf4Real;
  dgModflowBoundary.Columns[1].Format := rcf4Real;
  dgModflowBoundary.Columns[0].ComboUsed := true;
  dgModflowBoundary.Columns[1].ComboUsed := true;
  for Index := FLastTimeColumn+1 to dgModflowBoundary.ColCount - 1 do
  begin
    dgModflowBoundary.Columns[Index].ButtonUsed := true;
  end;
  dgModflowBoundary.Cells[0, 0] := StrStartingTime;
  dgModflowBoundary.Cells[1, 0] := StrEndingTime;
  if Boundary <> nil then
  begin
    for Index := 0 to Boundary.Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
    begin
      ColIndex := FLastTimeColumn+1+Index;
//      if ColIndex >= dgModflowBoundary.ColCount then
//      begin
//        Continue;
//      end;
//      dgModflowBoundary.Columns[2+Index].AutoAdjustColWidths := True;
      TimeList := Boundary.Values.TimeLists[Index, frmGoPhast.PhastModel];
      if Index = ConductanceColumn then
      begin
        dgModflowBoundary.Cells[ColIndex, 0] :=
          ConductanceCaption(TimeList.NonParamDescription);
      end
      else
      begin
        dgModflowBoundary.Cells[ColIndex, 0] := TimeList.NonParamDescription;
      end;
      dgModflowBoundary.Columns[ColIndex].AutoAdjustColWidths := False;
      dgModflowBoundary.ColWidths[ColIndex] :=
        dgModflowBoundary.WidthNeededToFitText(ColIndex,0);
    end;
  end;
  GridRect.Left := 2;
  GridRect.Right := 2;
  GridRect.Top := 1;
  GridRect.Bottom := 1;
  dgModflowBoundary.Selection := GridRect;
  SetButtonCaptions;
end;



procedure TframeScreenObjectNoParam.btnInsertClick(Sender: TObject);
begin
  if (dgModflowBoundary.SelectedRow <= 0)
    or (dgModflowBoundary.SelectedRow >= dgModflowBoundary.RowCount) then
  begin
    Beep;
    MessageDlg(StrYouNeedToSelectA, mtInformation, [mbOK], 0);
    Exit;
  end;
  if (seNumberOfTimes.AsInteger > 0) then
  begin
    dgModflowBoundary.InsertRow(dgModflowBoundary.SelectedRow);
  end;
  seNumberOfTimes.AsInteger := seNumberOfTimes.AsInteger +1;
end;

procedure TframeScreenObjectNoParam.btnDeleteClick(Sender: TObject);
begin
  if (dgModflowBoundary.RowCount > 2)
    and (dgModflowBoundary.Row> 0) then
  begin
    dgModflowBoundary.DeleteRow(dgModflowBoundary.Row);
  end;
  seNumberOfTimes.AsInteger := seNumberOfTimes.AsInteger -1;
end;

constructor TframeScreenObjectNoParam.Create(AOwner: TComponent);
begin
  inherited;
  ConductanceColumn := -1;
end;

destructor TframeScreenObjectNoParam.Destroy;
begin
  inherited;
end;

procedure TframeScreenObjectNoParam.dgModflowBoundaryBeforeDrawCell(
  Sender: TObject; ACol, ARow: Integer);
var
  EndTime: double;
  NextStartTime: double;
begin
  if (ACol = 1) and (ARow >= dgModflowBoundary.FixedRows)
    and (ARow < dgModflowBoundary.RowCount -1) then
  begin
    if TryStrToFloat(dgModflowBoundary.Cells[ACol, ARow], EndTime)
      and TryStrToFloat(dgModflowBoundary.Cells[0, ARow+1], NextStartTime) then
    begin
      if NextStartTime < EndTime then
      begin
        dgModflowBoundary.Canvas.Brush.Color := clRed;
      end;
    end;
  end;
end;

procedure TframeScreenObjectNoParam.dgModflowBoundaryColSize(Sender: TObject;
  ACol, PriorWidth: Integer);
begin
  LayoutMultiRowEditControls;
end;

procedure TframeScreenObjectNoParam.dgModflowBoundaryHorizontalScroll(
  Sender: TObject);
begin
  LayoutMultiRowEditControls;
end;

procedure TframeScreenObjectNoParam.dgModflowBoundaryMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ShouldEnable: boolean;
  ColIndex, RowIndex: Integer;
begin
  ShouldEnable := False;
  for RowIndex := dgModflowBoundary.FixedRows to dgModflowBoundary.RowCount -1 do
  begin
    for ColIndex := FLastTimeColumn+1 to dgModflowBoundary.ColCount - 1 do
    begin
      ShouldEnable := dgModflowBoundary.IsSelectedCell(ColIndex,RowIndex);
      if ShouldEnable then
      begin
        break;
      end;
    end;
    if ShouldEnable then
    begin
      break;
    end;
  end;
  rdeFormula.Enabled := ShouldEnable;
end;

procedure TframeScreenObjectNoParam.dgModflowBoundarySelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if (ARow = dgModflowBoundary.FixedRows)
    and (seNumberOfTimes.AsInteger = 0) then
  begin
    FSelectedText := dgModflowBoundary.Cells[ACol, ARow];
    CanSelect := False;
    Exit;
  end;
end;

procedure TframeScreenObjectNoParam.dgModflowBoundarySetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  if FDeleting  then
  begin
    Exit;
  end;
  if seNumberOfTimes.AsInteger < dgModflowBoundary.RowCount -1  then
  begin
    seNumberOfTimes.AsInteger := dgModflowBoundary.RowCount -1;
    seNumberOfTimes.OnChange(seNumberOfTimes);
  end;
  if FSelectedText <> Value then
  begin
    DeletedCells[ACol, ARow] := Value = '';
  end;

  UpdateNextTimeCell(dgModflowBoundary, ACol, ARow);
end;

procedure TframeScreenObjectNoParam.FrameResize(Sender: TObject);
begin
  LayoutMultiRowEditControls;
end;

function TframeScreenObjectNoParam.GetDeletedCells(ACol,
  ARow: integer): boolean;
begin
  if (ACol < 0) or (ARow < 0) then
  begin
    result := False;
    Exit;
  end;
  if (Length(FDeletedCells) = 0) or (Length(FDeletedCells[0]) = 0) then
  begin
    result := False;
    Exit;
  end;
  if (ACol < Length(FDeletedCells))
    and (ARow < Length(FDeletedCells[0])) then
  begin
    result := FDeletedCells[ACol,ARow];
  end
  else
  begin
    result := False;
  end;
end;

procedure TframeScreenObjectNoParam.GetEndTimes(Col: integer);
begin
  frmGoPhast.PhastModel.ModflowStressPeriods.FillPickListWithEndTimes(dgModflowBoundary, Col);
end;

procedure TframeScreenObjectNoParam.LayoutMultiRowEditControls;
begin
  if [csLoading, csReading] * ComponentState <> [] then
  begin
    Exit
  end;
  LayoutControls(dgModflowBoundary, rdeFormula, lblFormula,
    Max(FLastTimeColumn+1,dgModflowBoundary.LeftCol));
end;

procedure TframeScreenObjectNoParam.GetStartTimes(Col: integer);
begin
  frmGoPhast.PhastModel.ModflowStressPeriods.FillPickListWithStartTimes(dgModflowBoundary, Col);
end;

procedure TframeScreenObjectNoParam.rdeFormulaChange(Sender: TObject);
var
  ColIndex: Integer;
  RowIndex: Integer;
  TempOptions: TGridOptions;
begin
  dgModflowBoundary.BeginUpdate;
  try
    for RowIndex := dgModflowBoundary.FixedRows to
      dgModflowBoundary.RowCount - 1 do
    begin
      for ColIndex := FLastTimeColumn+1 to dgModflowBoundary.ColCount - 1 do
      begin
        if dgModflowBoundary.IsSelectedCell(ColIndex, RowIndex) then
        begin
          dgModflowBoundary.Cells[ColIndex, RowIndex] := rdeFormula.Text;
          if Assigned(dgModflowBoundary.OnSetEditText) then
          begin
            dgModflowBoundary.OnSetEditText(
              dgModflowBoundary,ColIndex,RowIndex, rdeFormula.Text);
          end;
        end;
      end;
    end;
  finally
    dgModflowBoundary.EndUpdate;
  end;
  TempOptions := dgModflowBoundary.Options;
  try
    dgModflowBoundary.Options := [goEditing, goAlwaysShowEditor];
    dgModflowBoundary.UpdateEditor;
  finally
    dgModflowBoundary.Options := TempOptions;
  end;
end;

procedure TframeScreenObjectNoParam.seNumberOfTimesChange(Sender: TObject);
begin
  FDeleting := True;
  try
    if seNumberOfTimes.AsInteger = 0 then
    begin
      dgModflowBoundary.RowCount := 2;
    end
    else
    begin
      dgModflowBoundary.RowCount := seNumberOfTimes.AsInteger + 1;
    end;
    btnDelete.Enabled := seNumberOfTimes.AsInteger >= 1;
    dgModflowBoundary.Invalidate;
  finally
    FDeleting := False;
  end;
end;

procedure TframeScreenObjectNoParam.SetDeletedCells(ACol, ARow: integer;
  const Value: boolean);
var
  OldColCount: integer;
  OldRowCount: integer;
  ColIndex: Integer;
  RowIndex: Integer;
begin
  if (ACol < 0) or (ARow < 0) or (ACol >= dgModflowBoundary.ColCount)
    or (ARow >= dgModflowBoundary.RowCount) then
  begin
    Exit;
  end;
  Assert(ACol >= 0);
  Assert(ARow >= 0);
  Assert(ACol < dgModflowBoundary.ColCount);
  Assert(ARow < dgModflowBoundary.RowCount);
  OldColCount := Length(FDeletedCells);
  if OldColCount = 0 then
  begin
    OldRowCount := 0;
  end
  else
  begin
    OldRowCount := Length(FDeletedCells[0])
  end;
  if (ACol >= OldColCount) or (ARow >= OldRowCount) then
  begin
    SetLength(FDeletedCells, dgModflowBoundary.ColCount,
      dgModflowBoundary.RowCount);
    for ColIndex := OldColCount to dgModflowBoundary.ColCount - 1 do
    begin
      for RowIndex := 0 to dgModflowBoundary.RowCount - 1 do
      begin
        FDeletedCells[ColIndex,RowIndex] := False;
      end;
    end;
    for ColIndex := 0 to OldColCount - 1 do
    begin
      for RowIndex := OldRowCount to dgModflowBoundary.RowCount - 1 do
      begin
        FDeletedCells[ColIndex,RowIndex] := False;
      end;
    end;
  end;
  FDeletedCells[ACol, ARow] := Value;
end;

procedure TframeScreenObjectNoParam.SetButtonCaptions;
var
  Index: Integer;
begin
  for Index := 0 to dgModflowBoundary.ColCount - 1 do
  begin
    if dgModflowBoundary.Columns[Index].ButtonCaption = '...' then
    begin
      dgModflowBoundary.Columns[Index].ButtonCaption := StrF;
      dgModflowBoundary.Columns[Index].ButtonWidth := 35;
    end;
  end;
end;

end.
