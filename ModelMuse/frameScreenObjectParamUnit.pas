{@name defines @link(TframeScreenObjectParam).}
unit frameScreenObjectParamUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, Dialogs, Grids, Math, RbwDataGrid4, JvExControls, JvComponent,
  JvxCheckListBox, ExtCtrls, Buttons, Mask, JvExMask, JvSpin, ArgusDataEntry,
  frameScreenObjectNoParamUnit, ModflowBoundaryUnit;

type
  // See @link(TframeScreenObjectParam.UnselectableColumnsIfParametersUsed).
  TColumn = 0..255;
  // See @link(TframeScreenObjectParam.UnselectableColumnsIfParametersUsed).
  TColumns = set of TColumn;


  {
    @abstract(@name is used to define time-varying MODFLOW
    boundary condition data associated with @link(TScreenObject)s
    when parameter instances can be defined.)
    Typically, the first two columns of @link(dgModflowBoundary) will have
    the start and ending times for the boundary condtion.  Following that
    will be columns representing the values to be assigned the boundary.
    Then there will be columns representing the MODFLOW parameters associated
    with the boundary.  The objects property of Row 0 will have the
    @link(TModflowParameter) in the column corresponding to the column for
    that @link(TModflowParameter). @link(clbParameters) will indicate which
    @link(TModflowParameter)s are in use.

    @member(splitHorizontal @name separates @link(clbParameters)
      from @link(dgModflowBoundary).)
    @member(clbParameters @name is used to indicate which
      parameters are being used.)
    @member(clbParametersStateChange @name is the OnChange
      event for @link(clbParameters).  @name inserts columns into
      @link(dgModflowBoundary) or deletes them.  When inserting a column, it
      puts a @link(TModflowParameter) in @link(dgModflowBoundary)Objects
      at Row = 0 and Col = the new column. )
    @member(dgModflowBoundarySelectCell @name prevents the user from selecting
      certain cells.)
  }
  TframeScreenObjectParam = class(TframeScreenObjectNoParam)
    splitHorizontal: TSplitter;
    clbParameters: TJvxCheckListBox;
    procedure clbParametersStateChange(Sender: TObject; Index: Integer);
    procedure dgModflowBoundarySelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure clbParametersClickCheck(Sender: TObject);
  private
    // See @link(UnselectableColumnsIfParametersUsed).
    FUnselectableColumnsIfParametersUsed: TColumns;
    // See @link(ParameterColumnSuffix).
    FParameterColumnSuffix: TStrings;
    // See @link(UnselectableColumnsIfParametersUsed).
    procedure SetUnselectableColumnsIfParametersUsed(const Value: TColumns);
    // See @link(ParameterColumnSuffix).
    procedure SetParameterColumnSuffix(const Value: TStrings);
    { Private declarations }
  public
    function ParamColumnCaption(NameIndex: integer): string; virtual;
    procedure InitializeFrame(Boundary: TModflowBoundary);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // If parameters related to this boundary condition
    // are used anywhere in the model,
    // the user shouldn't be able to select certain
    // columns in @link(dgModflowBoundary).  @name indicates which ones
    // it shouldn't be possible to select.
    property UnselectableColumnsIfParametersUsed: TColumns
      read FUnselectableColumnsIfParametersUsed
      write SetUnselectableColumnsIfParametersUsed;
    // @name is a string appended to the end of a column name.
    property ParameterColumnSuffix: TStrings read FParameterColumnSuffix
      write SetParameterColumnSuffix;
    { Public declarations }
  end;

implementation

uses OrderedCollectionUnit, frmGoPhastUnit, ModflowTimeUnit,
  frmCustomGoPhastUnit;

{$R *.dfm}

{ TframeScreenObjectParam }

procedure TframeScreenObjectParam.InitializeFrame(
  Boundary: TModflowBoundary);
var
  Index: integer;
  TimeList: TModflowTimeList;
begin
  InitializeNoParamFrame(Boundary);
  ParameterColumnSuffix.Clear;
  for Index := 0 to Boundary.Values.TimeListCount(frmGoPhast.PhastModel) - 1 do
  begin
    TimeList := Boundary.Values.TimeLists[Index, frmGoPhast.PhastModel];
    ParameterColumnSuffix.Add(TimeList.ParamDescription);
  end;
  SetButtonCaptions;
end;

procedure TframeScreenObjectParam.clbParametersClickCheck(Sender: TObject);
begin
  inherited;
  dgModflowBoundary.Invalidate;
end;

procedure TframeScreenObjectParam.clbParametersStateChange(Sender: TObject;
  Index: Integer);
var
  ColIndex: integer;
  Param: TModflowParameter;
  ItemIndex: integer;
  NewColPosition: integer;
  NameIndex: Integer;
  AddGrayColumn: boolean;
begin
  if FrameLoaded then
  begin
    if clbParameters.State[Index] = cbGrayed then
    begin
      clbParameters.State[Index] := cbChecked;
      Exit;
    end;
  end;

  AddGrayColumn := False;
  if (Index > 0) and (clbParameters.State[Index] = cbGrayed) then
  begin
    AddGrayColumn := True;
    Param := clbParameters.Items.Objects[Index] as TModflowParameter;
    for ColIndex := 0 to dgModflowBoundary.ColCount - 1 do
    begin
      if dgModflowBoundary.Objects[ColIndex,0] = Param then
      begin
        AddGrayColumn := False;
        break;
      end;
    end;
  end;
  if AddGrayColumn or (clbParameters.State[Index] = cbChecked) then
  begin
    Param := nil;
    for ItemIndex := Index +1 to clbParameters.Items.Count - 1 do
    begin
      if clbParameters.State[ItemIndex] in [cbChecked,cbGrayed] then
      begin
        Param := clbParameters.Items.Objects[ItemIndex] as TModflowParameter;
        break;
      end;
    end;
    NewColPosition := dgModflowBoundary.ColCount;
    if Param <> nil then
    begin
      for ColIndex := 0 to dgModflowBoundary.ColCount - 1 do
      begin
        if dgModflowBoundary.Objects[ColIndex,0] = Param then
        begin
          NewColPosition := ColIndex;
          break;
        end;
      end;
    end;
    Param := clbParameters.Items.Objects[Index] as TModflowParameter;
    if Param <> nil then
    begin
      for NameIndex := 0 to ParameterColumnSuffix.Count - 1 do
      begin
        dgModflowBoundary.InsertColumn(NewColPosition + NameIndex);
        dgModflowBoundary.Columns[NewColPosition + NameIndex].
          AutoAdjustRowHeights := True;
        dgModflowBoundary.Columns[NewColPosition + NameIndex].
          WordWrapCaptions := True;
        dgModflowBoundary.Columns[NewColPosition + NameIndex].
          Format := rcf4String;
        dgModflowBoundary.Columns[NewColPosition + NameIndex].
          UseButton := True;

  //      dgModflowBoundary.Columns[NewColPosition + NameIndex].
  //        AutoAdjustColWidths := True;
        dgModflowBoundary.Cells[NewColPosition + NameIndex,0] :=
          Param.ParameterName +
          ParamColumnCaption(NameIndex);
        dgModflowBoundary.Columns[NewColPosition + NameIndex].
          AutoAdjustColWidths := False;

        dgModflowBoundary.Objects[NewColPosition + NameIndex,0] := Param;
        dgModflowBoundary.ColWidths[NewColPosition + NameIndex] :=
          dgModflowBoundary.WidthNeededToFitText(NewColPosition + NameIndex,0);
      end;
    end;
  end
  else if (Index > 0) and (clbParameters.State[Index] = cbUnchecked) then
  begin
    Param := clbParameters.Items.Objects[Index] as TModflowParameter;
    if Param <> nil then
    begin
      for ColIndex := dgModflowBoundary.ColCount - 1 downto 0 do
      begin
        if dgModflowBoundary.Objects[ColIndex,0] = Param then
        begin
          dgModflowBoundary.DeleteColumn(ColIndex);
        end;
      end;
    end;
  end;
  SetButtonCaptions;
end;

function TframeScreenObjectParam.ParamColumnCaption(NameIndex: integer): string;
begin
  result := ParameterColumnSuffix[NameIndex];
end;

constructor TframeScreenObjectParam.Create(AOwner: TComponent);
begin
  inherited;
  FParameterColumnSuffix := TStringList.Create;
end;

destructor TframeScreenObjectParam.Destroy;
begin
  FParameterColumnSuffix.Free;
  inherited;
end;


procedure TframeScreenObjectParam.dgModflowBoundarySelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited dgModflowBoundarySelectCell(Sender, ACol, ARow,  CanSelect);
  if (ACol in UnselectableColumnsIfParametersUsed)
    and (clbParameters.Items.Count > 0) then
  begin
    CanSelect := False;
  end;
  if (clbParameters.Items.Count > 0)
    and (clbParameters.Items.Objects[0] = nil)
    and (clbParameters.State[0] = cbUnchecked) then
  begin
    if (ACol >= 2) and (ACol <= ParameterColumnSuffix.Count + 1) then
    begin
      CanSelect := False;
    end;
  end;
end;

procedure TframeScreenObjectParam.SetParameterColumnSuffix(const Value: TStrings);
begin
  FParameterColumnSuffix.Assign(Value);
end;

procedure TframeScreenObjectParam.SetUnselectableColumnsIfParametersUsed(
  const Value: TColumns);
begin
  if FUnselectableColumnsIfParametersUsed <> Value then
  begin
    FUnselectableColumnsIfParametersUsed := Value;
    dgModflowBoundary.Invalidate;
  end;
end;

end.
