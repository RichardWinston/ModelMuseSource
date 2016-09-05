unit frmSutraLayersUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCustomGoPhastUnit, frameDiscretizationUnit, StdCtrls, RbwEdit,
  ComCtrls, Buttons, ExtCtrls, LayerStructureUnit, RequiredDataSetsUndoUnit,
  ArgusDataEntry;

type
  TfrmSutraLayers = class(TfrmCustomGoPhast)
    pnl1: TPanel;
    tvLayerGroups: TTreeView;
    pnlTop: TPanel;
    pnlMain: TPanel;
    lbl1: TLabel;
    edName: TRbwEdit;
    frameDiscretization: TframeDiscretization;
    pnl2: TPanel;
    btnHelp: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    sbAddUnit: TSpeedButton;
    sbInsertUnit: TSpeedButton;
    sbDeleteUnit: TSpeedButton;
    spl1: TSplitter;
    rdeMinimumThickness: TRbwDataEntry;
    lblMinimumThickness: TLabel;
    procedure FormCreate(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure btnOKClick(Sender: TObject);
    procedure tvLayerGroupsChange(Sender: TObject; Node: TTreeNode);
    procedure sbAddUnitClick(Sender: TObject);
    procedure sbInsertUnitClick(Sender: TObject);
    procedure sbDeleteUnitClick(Sender: TObject);
    procedure edNameChange(Sender: TObject);
    procedure rdeMinimumThicknessChange(Sender: TObject);
  private
    FLayerStructure: TSutraLayerStructure;
    FSelectedUnits: TList;
    FSelectedTreeNodes: TList;
    FSettingUnit: Boolean;
    procedure GetData;
    Procedure SetData;
    procedure UpdateSelectedUnits;
    procedure SetControlValues;
    function AddNewUnit(Position: integer): TTreeNode;
    procedure EnableOkButton;
    procedure UpdateDiscretization;
    { Private declarations }
  public
    { Public declarations }
  end;

  TUndoDefineSutraLayers = class(TCustomCreateRequiredDataSetsUndo)
  private
    FNewLayerStructure: TSutraLayerStructure;
    FOldLayerStructure: TSutraLayerStructure;
    FNewDataSets: TList;
  protected
    function Description: string; override;
  public
    constructor Create(var NewLayerStructure: TSutraLayerStructure);
    Destructor Destroy; override;
    procedure DoCommand; override;
    procedure Undo; override;
  end;


var
  frmSutraLayers: TfrmSutraLayers;

implementation

uses
  frmGoPhastUnit, PhastModelUnit, frmLayersUnit, Character;

resourcestring
  StrChangeSUTRALayerS = 'change SUTRA layer structure';

{$R *.dfm}

{ TfrmSutraLayers }

procedure TfrmSutraLayers.UpdateDiscretization;
var
  List: TList;
  index: Integer;
  Group: TSutraLayerGroup;
begin
  List := TList.Create;
  try
    List.Capacity := FSelectedUnits.Count;
    for index := 0 to FSelectedUnits.Count - 1 do
    begin
      Group := FSelectedUnits[index];
      List.Add(Group.GrowthControls)
    end;
    frameDiscretization.UpdateSelectedUnits(List);
  finally
    List.Free;
  end;
end;

function TfrmSutraLayers.AddNewUnit(Position: integer): TTreeNode;
var
  LayerGroup: TSutraLayerGroup;
  Index: Integer;
  TreeNode: TTreeNode;
  Sibling: TTreeNode;
begin
  for Index := 0 to FSelectedTreeNodes.Count - 1 do
  begin
    TreeNode := FSelectedTreeNodes[Index];
    TreeNode.Selected := False;
  end;
  FSelectedTreeNodes.Clear;
  FSelectedUnits.Clear;
  UpdateDiscretization;
  if FLayerStructure.Count = 0 then
  begin
    LayerGroup := FLayerStructure.Insert(0) as TSutraLayerGroup;
    LayerGroup.AquiferName := kSUTRAMeshTop;
  end;
  LayerGroup := FLayerStructure.Insert(Position+1) as TSutraLayerGroup;
  // LayerGroup.AquiferName can not be assigned in LayerGroup.Create
  // because that causes an error if you delete a layer group
  // and then undo the deletion.
  LayerGroup.AquiferName := StrNewLayerGroup;

  if Position < tvLayerGroups.Items.Count then
  begin
    Sibling := tvLayerGroups.Items[Position];
  end
  else
  begin
    Sibling := nil;
  end;

  result := tvLayerGroups.Items.Insert(Sibling,
    LayerGroup.AquiferName);
  result.Data := LayerGroup;
  result.Selected := True;
  result.StateIndex := 1;

  sbDeleteUnit.Enabled := True;
  EnableOkButton;
  tvLayerGroups.Invalidate;
end;

procedure TfrmSutraLayers.btnOKClick(Sender: TObject);
begin
  inherited;
  SetData;
end;

procedure TfrmSutraLayers.edNameChange(Sender: TObject);
  function Alpha(C: Char): Boolean; inline;
  begin
    Result := TCharacter.IsLetter(C) or (C = '_');
  end;
var
  SelectedUnit: TSutraLayerGroup;
  TreeNode: TTreeNode;
  Index: Integer;
  UsedNames: TStringList;
  ALayerGroup: TSutraLayerGroup;
  TestName: string;
  FirstChar: Char;
  SelStart: Integer;
begin
  inherited;
  if (not FSettingUnit) and (FSelectedUnits.Count > 0) then
  begin
    UsedNames := TStringList.Create;
    try
      UsedNames.CaseSensitive := False;
      for Index := 1 to FLayerStructure.Count - 1 do
      begin
        ALayerGroup := FLayerStructure[Index];
        if FSelectedUnits.IndexOf(ALayerGroup) < 0 then
        begin
          UsedNames.Add(GenerateNewName(ALayerGroup.AquiferName));
        end;
      end;
      if edName.Text <> '' then
      begin
        FirstChar := edName.Text[1];
        if not Alpha(FirstChar) then
        begin
          SelStart := edName.SelStart;
          edName.Text := '_' + edName.Text;
          edName.SelStart := SelStart+1;
        end;
        TestName := GenerateNewName(edName.Text);
        if UsedNames.IndexOf(TestName) >= 0 then
        begin
          Beep;
          MessageDlg(StrThisNameIsTooSim, mtWarning, [mbOK], 0);
          Exit;
        end;
        Assert(FSelectedUnits.Count = 1);
        SelectedUnit := FSelectedUnits[0];
        SelectedUnit.AquiferName := edName.Text;
      end;
      TreeNode := FSelectedTreeNodes[0];
      TreeNode.Text := edName.Text;
    finally
      UsedNames.Free;
    end;
  end;
end;

procedure TfrmSutraLayers.EnableOkButton;
//var
//  Group: TSutraLayerGroup;
//  Group1, Group2: TSutraLayerGroup;
//  Index: Integer;
//  ShouldShowMessage: boolean;
begin
  if FLayerStructure.Count = 0 then Exit;

//  ShouldShowMessage := btnOK.Enabled;
//  Group := FLayerStructure.Items[FLayerStructure.Count-1] as TSutraLayerGroup;
  btnOK.Enabled := True;
//  if btnOK.Enabled then
//  begin
//    Group := FLayerStructure.Items[1] as TSutraLayerGroup;
//    btnOK.Enabled := Group.Simulated;
//    if btnOK.Enabled then
//    begin
//      for Index := 2 to FLayerStructure.Count - 2 do
//      begin
//        Group1 := FLayerStructure.Items[Index] as TSutraLayerGroup;
//        Group2 := FLayerStructure.Items[Index+1] as TSutraLayerGroup;
//        btnOK.Enabled := Group1.Simulated or Group2.Simulated;
//        if not btnOK.Enabled then
//        begin
//          break;
//          if ShouldShowMessage then
//          begin
//            Beep;
//            MessageDlg(StrANonsimulatedLaye, mtError, [mbOK], 0);
//          end;
//        end;
//      end;
//    end
//    else
//    begin
//      if ShouldShowMessage then
//      begin
//        Beep;
//        MessageDlg(StrTheTopLayerGroup,
//          mtError, [mbOK], 0);
//      end;
//    end;
//  end
//  else
//  begin
//    if ShouldShowMessage then
//    begin
//      Beep;
//      MessageDlg(StrTheBottomLayerGro,
//        mtError, [mbOK], 0);
//    end;
//  end;
end;

procedure TfrmSutraLayers.FormCreate(Sender: TObject);
begin
  inherited;
  FLayerStructure:= TSutraLayerStructure.Create(nil);
  FSelectedUnits:= TList.Create;
  FSelectedTreeNodes:= TList.Create;

  GetData;
end;

procedure TfrmSutraLayers.FormDestroy(Sender: TObject);
begin
  inherited;
  FLayerStructure.Free;
  FSelectedUnits.Free;
  FSelectedTreeNodes.Free;
end;

procedure TfrmSutraLayers.GetData;
var
  Index: Integer;
  LayerGroup: TSutraLayerGroup;
  NodeItem: TTreeNode;
begin
  FLayerStructure.Assign(frmGoPhast.PhastModel.SutraLayerStructure);
  for Index := 1 to FLayerStructure.Count - 1 do
  begin
    LayerGroup := FLayerStructure.Items[Index] as TSutraLayerGroup;

    NodeItem := tvLayerGroups.Items.Add(nil, LayerGroup.AquiferName);
    NodeItem.Data := LayerGroup;


  end;

  if tvLayerGroups.Items.Count > 0 then
  begin
    tvLayerGroups.Items[0].Selected := True;
  end;

  sbDeleteUnit.Enabled := FLayerStructure.Count > 2;

  UpdateSelectedUnits;
  SetControlValues;
end;

procedure TfrmSutraLayers.rdeMinimumThicknessChange(Sender: TObject);
var
  MinThickness: Double;
  index: Integer;
  AGroup: TSutraLayerGroup;
begin
  inherited;
  if (ComponentState * [csLoading, csReading]) <> [] then
  begin
    Exit;
  end;
  if (not FSettingUnit) and (FSelectedUnits.Count > 0) then
  begin
    if TryStrToFloat(rdeMinimumThickness.Text, MinThickness) then
    begin
      for index := 0 to FSelectedUnits.Count - 1 do
      begin
        AGroup := FSelectedUnits[index];
        AGroup.MinThickness := MinThickness;
      end;
    end;

  end;
end;

procedure TfrmSutraLayers.sbAddUnitClick(Sender: TObject);
begin
  inherited;
  AddNewUnit(tvLayerGroups.Items.Count);
end;

procedure TfrmSutraLayers.sbDeleteUnitClick(Sender: TObject);
var
  Index: Integer;
  Item: TTreeNode;
  NewIndex: Integer;
begin
  inherited;
  NewIndex := 0;
  for Index := tvLayerGroups.Items.Count - 1 downto 0 do
  begin
    Item := tvLayerGroups.Items[Index];
    if Item.Selected then
    begin
      FLayerStructure.Delete(Index+1);
      NewIndex := Index-1;
      Item.Selected := False;
      tvLayerGroups.Items.Delete(Item);
    end;
  end;
  if NewIndex < 0 then
  begin
    NewIndex := tvLayerGroups.Items.Count - 1;
  end;
  tvLayerGroups.Items[NewIndex].Selected := True;
  sbDeleteUnit.Enabled := FLayerStructure.Count > 2;
  EnableOkButton;
end;

procedure TfrmSutraLayers.sbInsertUnitClick(Sender: TObject);
var
  SelectIndex: integer;
begin
  inherited;
  if tvLayerGroups.Selected <> nil then
  begin
    SelectIndex := tvLayerGroups.Selected.Index;
    AddNewUnit(SelectIndex);
  end
  else
  begin
    sbAddUnitClick(nil);
  end;
end;

procedure TfrmSutraLayers.SetControlValues;
var
  FirstUnit: TSutraLayerGroup;
  UnitIndex: Integer;
  AGroup: TSutraLayerGroup;
  IsSame: Boolean;
begin
  if csDestroying in ComponentState then Exit;

  FSettingUnit := True;
  edName.Enabled := FSelectedUnits.Count = 1;

  if FSelectedUnits.Count = 0 then
  begin
    Exit;
  end;
  FirstUnit := FSelectedUnits[0];

  try
    if FSelectedUnits.Count = 1 then
    begin
      edName.Text := FirstUnit.AquiferName;
      rdeMinimumThickness.Text := FloatToStr(FirstUnit.MinThickness);
    end
    else
    begin
      edName.Text := '';
      IsSame := True;
      for UnitIndex := 1 to FSelectedUnits.Count - 1 do
      begin
        AGroup := FSelectedUnits[UnitIndex];
        IsSame := FirstUnit.MinThickness = AGroup.MinThickness;
        if not IsSame then
        begin
          break;
        end;
      end;
      if IsSame then
      begin
        rdeMinimumThickness.Text := FloatToStr(FirstUnit.MinThickness);
      end
      else
      begin
        rdeMinimumThickness.Text := '';
      end;
    end;
//    FirstUnit := FSelectedUnits[0];
    UpdateDiscretization;
    frameDiscretization.SetControlValues;
  finally
    FSettingUnit := False;
  end;

end;

procedure TfrmSutraLayers.SetData;
var
  Undo: TUndoDefineSutraLayers;
begin
  Undo := TUndoDefineSutraLayers.Create(FLayerStructure);
  frmGoPhast.UndoStack.Submit(Undo);
end;

procedure TfrmSutraLayers.tvLayerGroupsChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  UpdateSelectedUnits;
  SetControlValues;
end;

procedure TfrmSutraLayers.UpdateSelectedUnits;
var
  Index: Integer;
  NodeItem: TTreeNode;
begin
  if csDestroying in ComponentState then Exit;
  FSelectedUnits.Clear;
  FSelectedTreeNodes.Clear;
  if tvLayerGroups.Selected <> nil then
  begin
    for Index := 0 to tvLayerGroups.Items.Count - 1 do
    begin
      NodeItem := tvLayerGroups.Items[Index];
      if NodeItem.Selected then
      begin
        if NodeItem.Data <> nil then
        begin
          FSelectedUnits.Add(NodeItem.Data);
          FSelectedTreeNodes.Add(NodeItem);
        end;
      end;
    end;
  end;
  UpdateDiscretization;
end;

{ TUndoDefineSutraLayers }

constructor TUndoDefineSutraLayers.Create(
  var NewLayerStructure: TSutraLayerStructure);
begin
  inherited Create;
  FNewDataSets := TList.Create;

  FNewLayerStructure:= NewLayerStructure;
  // TUndoDefineLayers takes ownership of NewLayerStructure.
  NewLayerStructure := nil;
  FOldLayerStructure:= TSutraLayerStructure.Create(nil);
  FOldLayerStructure.Assign(frmGoPhast.PhastModel.SutraLayerStructure);

end;

function TUndoDefineSutraLayers.Description: string;
begin
  result := StrChangeSUTRALayerS;
end;

destructor TUndoDefineSutraLayers.Destroy;
begin
  FNewLayerStructure.Free;
  FOldLayerStructure.Free;
  FNewDataSets.Free;
  inherited;
end;

procedure TUndoDefineSutraLayers.DoCommand;
var
  LocalModel: TPhastModel;
begin
  frmGoPhast.CanDraw := False;
  try
    inherited;
    LocalModel := frmGoPhast.PhastModel;
    LocalModel.SutraLayerStructure.NewDataSets := FNewDataSets;
    LocalModel.SutraLayerStructure.ClearNewDataSets;
    LocalModel.SutraLayerStructure.Assign(FNewLayerStructure);
    LocalModel.SutraLayerStructure.NewDataSets := nil;
    UpdatedRequiredDataSets;
    LocalModel.UpdateDataSetDimensions;
    frmGoPhast.FrontDiscretizationChanged := True;
    if Assigned(LocalModel.Mesh) then
    begin
      LocalModel.Mesh.ElevationsNeedUpdating := True;
    end;
    frmGoPhast.InvalidateImage32AllViews;
    frmGoPhast.EnableMeshRenumbering;
  finally
    frmGoPhast.CanDraw := True;
  end;
end;

procedure TUndoDefineSutraLayers.Undo;
var
  LocalModel: TPhastModel;
begin
  frmGoPhast.CanDraw := False;
  try
    inherited;
    LocalModel := frmGoPhast.PhastModel;
    LocalModel.SutraLayerStructure.NewDataSets := FNewDataSets;
    LocalModel.SutraLayerStructure.Assign(FOldLayerStructure);
    LocalModel.SutraLayerStructure.RemoveNewDataSets;
    LocalModel.SutraLayerStructure.NewDataSets := nil;
    UpdatedRequiredDataSets;
    LocalModel.UpdateDataSetDimensions;
    frmGoPhast.FrontDiscretizationChanged := True;
    if Assigned(LocalModel.Mesh) then
    begin
      LocalModel.Mesh.ElevationsNeedUpdating := True;
    end;
    frmGoPhast.InvalidateImage32AllViews;
    frmGoPhast.EnableMeshRenumbering;
  finally
    frmGoPhast.CanDraw := True;
  end;
end;

end.
