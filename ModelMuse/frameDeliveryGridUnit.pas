unit frameDeliveryGridUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, frameFormulaGridUnit, ExtCtrls,
  Grids, RbwDataGrid4, StdCtrls, Mask, JvExMask, JvSpin, Buttons,
  UndoItemsScreenObjects, Math, ModflowFmpFarmUnit;

type
  // @name is used for editing data set 33 in the Farm Process of MODFLOW-OWHM
  TframeDeliveryGrid = class(TframeFormulaGrid)
    lblNumberOfDeliveryTypes: TLabel;
    seNumberOfDeliveryTypes: TJvSpinEdit;
    comboHowUsed: TComboBox;
    lblHowUsed: TLabel;
    procedure seNumberOfDeliveryTypesChange(Sender: TObject);
    procedure GridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure seNumberChange(Sender: TObject);
    procedure lblNumberOfDeliveryTypesClick(Sender: TObject);
    procedure sbInsertClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure edFormulaChange(Sender: TObject);
    procedure comboHowUsedChange(Sender: TObject);
    procedure GridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    FChanged: boolean;
    FOnChange: TNotifyEvent;
    FChanging: Boolean;
    property Changing: Boolean read FChanging write FChanging;
    procedure CheckValidCell(Sender: TObject; ACol, ARow: Integer; var ValidCell: Boolean);
    procedure GetValidHowUsed(ColIndex, RowIndex: Integer; var ValidCell: Boolean);
    procedure DoChange;
    { Private declarations }
  public
    property DataChanged: Boolean read FChanged;
    procedure InitializeControls;
    // ScreenObjectList contains only objects that define farms.
    procedure GetData(FarmList: TFarmList);
    procedure SetData(FarmList: TFarmList);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    procedure LayoutMultiRowEditControls; override;
    { Public declarations }
  end;

type
  TDeliveryTimeColumns = (dtcStart, dtcEnd);
  TDeliveryColumns = (dcVolume, dcRank, dcHowUsed, dcVirtualFarm);

var
  frameDeliveryGrid: TframeDeliveryGrid;

implementation

uses
  GoPhastTypes, ModflowTimeUnit, frmGoPhastUnit,
  Generics.Collections, frmCustomGoPhastUnit;

resourcestring
  StrOnlyTheAmountRequ = 'Take required amount (0)';
  StrSurplusDischargedT = 'Surplus discharged (1)';
  StrSurplusStoredInGr = 'Surplus stored (2)';
  StrVolumeNRDV = 'Volume (NRDV)';
  StrRankNRDR = 'Rank (NRDR)';
  StrHowUsedNRDU = 'How used (NRDU)';
  StrVirtualFarm0 = 'Virtual Farm (<0)';
  StrVirtualFarmNumber = 'Virtual farm number (NRDU)';

const
  DeliveryColumns = Ord(High(TDeliveryColumns))+1;

{$R *.dfm}

procedure TframeDeliveryGrid.CheckValidCell(Sender: TObject; ACol,
  ARow: Integer; var ValidCell: Boolean);
begin
  ValidCell := (ARow >= 1) and (ACol > Ord(dtcEnd))
    and (((ACol-2) mod DeliveryColumns) <> Ord(dcHowUsed));
end;

procedure TframeDeliveryGrid.comboHowUsedChange(Sender: TObject);
var
  ColIndex: Integer;
  RowIndex: Integer;
  TempOptions: TGridOptions;
  ValidCell: Boolean;
begin
  for RowIndex := Grid.FixedRows to
    Grid.RowCount - 1 do
  begin
    for ColIndex := FirstFormulaColumn to Grid.ColCount - 1 do
    begin
      if Grid.IsSelectedCell(ColIndex, RowIndex) then
      begin
        GetValidHowUsed(ColIndex, RowIndex, ValidCell);
        if ValidCell then
        begin
          Grid.Cells[ColIndex, RowIndex] := comboHowUsed.Text;
          if Assigned(Grid.OnSetEditText) then
          begin
            Grid.OnSetEditText(
              Grid,ColIndex,RowIndex, comboHowUsed.Text);
          end;
        end;
      end;
    end;
  end;
  TempOptions := Grid.Options;
  try
    Grid.Options := [goEditing, goAlwaysShowEditor];
    Grid.UpdateEditor;
  finally
    Grid.Options := TempOptions;
  end;
end;

procedure TframeDeliveryGrid.DoChange;
begin
  if Changing then
  begin
    Exit;
  end;
  if Assigned(OnChange) then
  begin
    OnChange(Self);
  end;
  FChanged := True;
end;

procedure TframeDeliveryGrid.edFormulaChange(Sender: TObject);
begin
  inherited;
  DoChange;
end;


procedure TframeDeliveryGrid.GetData(FarmList: TFarmList);
var
  ObjectIndex: Integer;
  AFarm: TFarm;
  MaxCount: Integer;
  FirstFarm: TFarm;
  DelivItem: TDeliveryParamItem;
  OuterIndex: Integer;
  TimeIndex: Integer;
  TimeItem: TNonRoutedDeliveryParameterItem;
begin
  Changing := True;
  try
    Assert(FarmList.Count > 0);
    MaxCount := 0;
    FirstFarm := FarmList[0];
    for ObjectIndex := 1 to FarmList.Count - 1 do
    begin
      AFarm := FarmList[ObjectIndex];
      if not FirstFarm.DeliveryParamCollection.IsSame(
        AFarm.DeliveryParamCollection) then
      begin
        ClearGrid;
        seNumberOfDeliveryTypes.AsInteger := 0;
        seNumberOfDeliveryTypes.OnChange(seNumberOfDeliveryTypes);
        Grid.RowCount := 2;
        seNumber.AsInteger := 0;
        seNumber.OnChange(seNumber);
        Exit;
      end;
    end;
    MaxCount := Max(MaxCount, FirstFarm.DeliveryParamCollection.Count);
    if MaxCount = 0 then
    begin
      ClearGrid;
      seNumberOfDeliveryTypes.AsInteger := 0;
      seNumberOfDeliveryTypes.OnChange(seNumberOfDeliveryTypes);
      Grid.RowCount := 2;
      seNumber.AsInteger := 0;
      seNumber.OnChange(seNumber);
      Exit;
    end;

    seNumberOfDeliveryTypes.AsInteger := MaxCount;
    Grid.BeginUpdate;
    try
      ClearGrid;
      DelivItem := FirstFarm.DeliveryParamCollection[0];

      Grid.RowCount := Max(2, DelivItem.DeliveryParam.Count);
      seNumber.AsInteger := DelivItem.DeliveryParam.Count;
      seNumber.OnChange(seNumber);
      for OuterIndex := 0 to FirstFarm.DeliveryParamCollection.Count - 1 do
      begin
        DelivItem := FirstFarm.DeliveryParamCollection[OuterIndex];
        for TimeIndex := 0 to DelivItem.DeliveryParam.Count - 1 do
        begin
          TimeItem := DelivItem.DeliveryParam[TimeIndex];
          Grid.Cells[Ord(dtcStart), TimeIndex+1] := FloatToStr(TimeItem.StartTime);
          Grid.Cells[Ord(dtcEnd), TimeIndex+1] := FloatToStr(TimeItem.EndTime);
          Grid.Cells[Ord(dcVolume) + OuterIndex*DeliveryColumns + 2, TimeIndex+1] := TimeItem.Volume;
          Grid.Cells[Ord(dcRank) + OuterIndex*DeliveryColumns + 2, TimeIndex+1] := TimeItem.Rank;
          Grid.ItemIndex[Ord(dcHowUsed) + OuterIndex*DeliveryColumns + 2, TimeIndex+1] := Ord(TimeItem.NonRoutedDeliveryType);
          Grid.Cells[Ord(dcVirtualFarm) + OuterIndex*DeliveryColumns + 2, TimeIndex+1] := TimeItem.VirtualFarm;
        end;
      end;
    finally
      Grid.EndUpdate;
    end;
  finally
    FChanged := False;
    Changing := False;
  end;
end;

procedure TframeDeliveryGrid.GridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ShouldEnable: boolean;
  ColIndex, RowIndex: Integer;
begin
  inherited;
  ShouldEnable := False;
  for RowIndex := Grid.FixedRows to Grid.RowCount -1 do
  begin
    for ColIndex := FirstFormulaColumn to Grid.ColCount - 1 do
    begin
      ShouldEnable := Grid.IsSelectedCell(ColIndex,RowIndex);
      if ShouldEnable then
      begin
        GetValidHowUsed(ColIndex, RowIndex, ShouldEnable);
        if ShouldEnable then
        begin
          Break;
        end;
      end;
    end;
    if ShouldEnable then
    begin
      break;
    end;
  end;
  comboHowUsed.Enabled := ShouldEnable;
  lblHowUsed.Enabled := ShouldEnable;
end;

procedure TframeDeliveryGrid.GridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  ColumnType: TDeliveryColumns;
  DelivType: TNonRoutedDeliveryType;
begin
  inherited;
  if ACol >= 2 then
  begin
    ColumnType := TDeliveryColumns((ACol-2) mod DeliveryColumns);
    if ColumnType = dcVirtualFarm then
    begin
      DelivType := TNonRoutedDeliveryType(Grid.ItemIndex[ACol-1,ARow]);
      CanSelect  := DelivType = nrdtVirtualFarm;
    end;
  end;
end;

procedure TframeDeliveryGrid.GridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  inherited;
//  UpdateNextTimeCell(Grid, ACol, ARow);
  DoChange;
end;

procedure TframeDeliveryGrid.lblNumberOfDeliveryTypesClick(Sender: TObject);
begin
  inherited;
  DoChange;
//  FChanged := True;
end;

procedure TframeDeliveryGrid.sbDeleteClick(Sender: TObject);
begin
  inherited;
  DoChange;
//  FChanged := True;
end;

procedure TframeDeliveryGrid.sbInsertClick(Sender: TObject);
begin
  inherited;
  DoChange;
//  FChanged := True;
end;

procedure TframeDeliveryGrid.seNumberChange(Sender: TObject);
begin
  inherited;
  DoChange;
//  FChanged := True;
end;

procedure TframeDeliveryGrid.seNumberOfDeliveryTypesChange(Sender: TObject);

var
  PickList: TStringList;
  PriorColCount: Integer;
  ColIndex: Integer;
  ColumnType: TDeliveryColumns;
begin
  inherited;
  PriorColCount := Grid.ColCount;
  Assert(PriorColCount >= 2);
  Grid.ColCount := seNumberOfDeliveryTypes.AsInteger * DeliveryColumns + 2;

  PickList := TStringList.Create;
  try
    PickList.Add(StrOnlyTheAmountRequ);
    PickList.Add(StrSurplusDischargedT);
    PickList.Add(StrSurplusStoredInGr);
    PickList.Add(StrVirtualFarm0);
    comboHowUsed.Items := PickList;

    Grid.BeginUpdate;
    try
      for ColIndex := PriorColCount to Grid.ColCount - 1 do
      begin
        ColumnType := TDeliveryColumns((ColIndex-2) mod DeliveryColumns);
        case ColumnType of
          dcVolume:
            begin
              Grid.Cells[ColIndex,0] := StrVolumeNRDV;
              Grid.Columns[ColIndex].ButtonUsed := True;
              Grid.Columns[ColIndex].ButtonCaption := StrF;
              Grid.Columns[ColIndex].ButtonWidth := 35;
            end;
          dcRank:
            begin
              Grid.Cells[ColIndex,0] := StrRankNRDR;
              Grid.Columns[ColIndex].ButtonUsed := True;
              Grid.Columns[ColIndex].ButtonCaption := StrF;
              Grid.Columns[ColIndex].ButtonWidth := 35;
            end;
          dcHowUsed:
            begin
              Grid.Cells[ColIndex,0] := StrHowUsedNRDU;
              Grid.Columns[ColIndex].ComboUsed := True;
              Grid.Columns[ColIndex].LimitToList := True;
              Grid.Columns[ColIndex].PickList := PickList;
            end;
          dcVirtualFarm:
            begin
              Grid.Cells[ColIndex,0] := StrVirtualFarmNumber;
              Grid.Columns[ColIndex].ButtonUsed := True;
              Grid.Columns[ColIndex].ButtonCaption := StrF;
              Grid.Columns[ColIndex].ButtonWidth := 35;
            end;
          else
            Assert(False);
        end;
        Grid.Columns[ColIndex].AutoAdjustColWidths := True;
        Grid.Columns[ColIndex].AutoAdjustRowHeights := True;
        Grid.Columns[ColIndex].WordWrapCaptions := True;
        Grid.Columns[ColIndex].ButtonFont := Font;
      end;
    finally
      Grid.EndUpdate;
    end;
  finally
    PickList.Free;
  end;

  for ColIndex := PriorColCount to Grid.ColCount - 1 do
  begin
    Grid.Columns[ColIndex].AutoAdjustColWidths := False;
  end;
  LayoutMultiRowEditControls;

  DoChange;
//  FChanged := True;
end;

procedure TframeDeliveryGrid.SetData(FarmList: TFarmList);
var
  index: Integer;
  Farm: TFarm;
  Delivery: TDeliveryParamCollection;
  StartTimes: TList<Double>;
  EndTimes: TList<Double>;
  Rows: TList<Integer>;
  StartTime: double;
  EndTime: double;
  RowIndex: Integer;
  DeliveryIndex: Integer;
  DeliveryItem: TDeliveryParamItem;
  ARow: Integer;
  ColStart: Integer;
  DeliveryTimeItem: TNonRoutedDeliveryParameterItem;
begin
  for index := 0 to FarmList.Count - 1 do
  begin
    Farm := FarmList[index];
    if Farm <> nil then
    begin
      Delivery := Farm.DeliveryParamCollection;
      while Delivery.Count < seNumberOfDeliveryTypes.AsInteger do
      begin
        Delivery.Add;
      end;
      while Delivery.Count > seNumberOfDeliveryTypes.AsInteger do
      begin
        Delivery.Last.Free;
      end;
      StartTimes := TList<Double>.Create;
      EndTimes := TList<Double>.Create;
      Rows := TList<Integer>.Create;
      try
        for RowIndex := 1 to seNumber.AsInteger do
        begin
          if TryStrToFloat(Grid.Cells[Ord(dtcStart), RowIndex], StartTime)
            and TryStrToFloat(Grid.Cells[Ord(dtcEnd), RowIndex], EndTime) then
          begin
            Rows.Add(RowIndex);
            StartTimes.Add(StartTime);
            EndTimes.Add(EndTime);
          end;
        end;
        for DeliveryIndex := 0 to seNumberOfDeliveryTypes.AsInteger - 1 do
        begin
          DeliveryItem := Delivery[DeliveryIndex];
          ColStart := DeliveryIndex*DeliveryColumns+2;
          for RowIndex := 0 to Rows.Count-1 do
          begin
            ARow := Rows[RowIndex];
            if RowIndex < DeliveryItem.DeliveryParam.Count then
            begin
              DeliveryTimeItem := DeliveryItem.DeliveryParam[RowIndex];
            end
            else
            begin
              DeliveryTimeItem := DeliveryItem.DeliveryParam.Add;
            end;
            DeliveryTimeItem.StartTime := StartTimes[RowIndex];
            DeliveryTimeItem.EndTime := EndTimes[RowIndex];
            DeliveryTimeItem.Volume := Grid.Cells[ColStart + Ord(dcVolume),ARow];
            DeliveryTimeItem.Rank := Grid.Cells[ColStart + Ord(dcRank),ARow];
            DeliveryTimeItem.NonRoutedDeliveryType :=
              TNonRoutedDeliveryType(Max(0, Grid.ItemIndex[ColStart + Ord(dcHowUsed),ARow]));
            if DeliveryTimeItem.NonRoutedDeliveryType = nrdtVirtualFarm then
            begin
              DeliveryTimeItem.VirtualFarm := Grid.Cells[ColStart + Ord(dcVirtualFarm),ARow];
            end;
          end;
          while DeliveryItem.DeliveryParam.Count > Rows.Count do
          begin
            DeliveryItem.DeliveryParam.Last.Free;
          end;
        end;
      finally
        StartTimes.Free;
        EndTimes.Free;
        Rows.Free;
      end;

    end;
  end;
end;

procedure TframeDeliveryGrid.GetValidHowUsed(ColIndex, RowIndex: Integer;
  var ValidCell: Boolean);
begin
  ValidCell := (RowIndex >= 1) and (ColIndex > Ord(dtcEnd))
    and (((ColIndex - 2) mod DeliveryColumns) = Ord(dcHowUsed));
end;

procedure TframeDeliveryGrid.InitializeControls;
var
  StressPeriods: TModflowStressPeriods;
begin
  FirstFormulaColumn := Succ(Ord(dtcEnd));
  ClearGrid;
  OnValidCell := CheckValidCell;
  Grid.Cells[Ord(dtcStart), 0] := StrStartingTime;
  Grid.Cells[Ord(dtcEnd), 0] := StrEndingTime;
  StressPeriods := frmGoPhast.PhastModel.ModflowStressPeriods;
  StressPeriods.FillPickListWithStartTimes(Grid, Ord(dtcStart));
  StressPeriods.FillPickListWithEndTimes(Grid, Ord(dtcEnd));
  seNumberOfDeliveryTypes.AsInteger := 0;
  seNumber.AsInteger := 0;
  LayoutMultiRowEditControls;
end;

procedure TframeDeliveryGrid.LayoutMultiRowEditControls;
var
  Column: integer;
  ColIndex: Integer;
  ValidCell: Boolean;
begin
  inherited;
  if [csLoading, csReading] * ComponentState <> [] then
  begin
    Exit
  end;
  Column := Max(FirstFormulaColumn,Grid.LeftCol);
  for ColIndex := Column to Grid.ColCount - 1 do
  begin
    GetValidHowUsed(ColIndex,1,ValidCell);
    if ValidCell then
    begin
      Column := ColIndex;
      break;
    end;
  end;
  LayoutControls(Grid, comboHowUsed, lblHowUsed,
    Column);
end;

end.
