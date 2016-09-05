unit frameMt3dBasicPkgUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, framePackageUnit, RbwController, StdCtrls, ExtCtrls, ArgusDataEntry,
  ModflowPackageSelectionUnit, frameGridUnit, Mt3dmsChemSpeciesUnit, Mask,
  JvExMask, JvSpin;

type
  TSpeciesColumn = (scName, scUseFile, scFileName);

  TframeMt3dBasicPkg = class(TframePackage)
    edMassUnit: TLabeledEdit;
    rdeInactiveConcentration: TRbwDataEntry;
    lblInactiveConcentration: TLabel;
    rdeMinimumSaturatedFraction: TRbwDataEntry;
    lblMinimumSaturatedFraction: TLabel;
    pnlSpecies: TPanel;
    Splitter1: TSplitter;
    frameGridImmobile: TframeGrid;
    frameGridMobile: TframeGrid;
    dlgOpenSelectFile: TOpenDialog;
    grpInitialConcentrationTimes: TGroupBox;
    lblStressPeriod: TLabel;
    seStressPeriod: TJvSpinEdit;
    seTimeStep: TJvSpinEdit;
    lblTimeStep: TLabel;
    lblTransportStep: TLabel;
    seTransportStep: TJvSpinEdit;
    procedure frameGridSpeciesGridButtonClick(Sender: TObject; ACol,
      ARow: Integer);
    procedure frameGridMobileGridSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure frameGridImmobileGridSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure frameSpeciesGridStateChange(Sender: TObject; ACol,
      ARow: Integer; const Value: TCheckBoxState);
  private
    procedure GetMt3dComponents(Mt3DComponents: TCustomChemSpeciesCollection;
      AFrame: TframeGrid);
    procedure SetMt3dComponents(Mt3DComponents: TCustomChemSpeciesCollection;
      AFrame: TframeGrid);
    procedure FixNames(Names: TStringList; AFrame: TframeGrid);
    procedure EnableTimeControls;
    { Private declarations }
  public
    procedure GetData(Package: TModflowPackageSelection); override;
    procedure SetData(Package: TModflowPackageSelection); override;
    procedure GetMt3dmsChemSpecies(
      MobileComponents: TMobileChemSpeciesCollection;
      ImmobileComponents: TChemSpeciesCollection);
    procedure SetMt3dmsChemSpecies(
      MobileComponents: TMobileChemSpeciesCollection;
      ImmobileComponents: TChemSpeciesCollection);
    { Public declarations }
  end;

var
  frameMt3dBasicPkg: TframeMt3dBasicPkg;

implementation

uses
  PhastModelUnit, Grids;

{$R *.dfm}

resourcestring
  StrMobileSpecies = 'Mobile Species';
  StrImmobileSpecies = 'Immobile Species';
  StrUseInitialConcentr = 'Use Initial Concentration File';
  StrFileName = 'File Name';

{ TframeMt3dBasicPkg }

procedure TframeMt3dBasicPkg.frameGridImmobileGridSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  if (ACol = Ord(scFileName))
    and not frameGridMobile.Grid.Checked[Ord(scUseFile), ARow] then
  begin
    CanSelect := False;
  end;
end;

procedure TframeMt3dBasicPkg.frameGridMobileGridSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  if (ACol = Ord(scFileName))
    and not frameGridMobile.Grid.Checked[Ord(scUseFile), ARow] then
  begin
    CanSelect := False;
  end;
end;

procedure TframeMt3dBasicPkg.frameSpeciesGridStateChange(Sender: TObject;
  ACol, ARow: Integer; const Value: TCheckBoxState);
begin
  inherited;
  EnableTimeControls;
end;

procedure TframeMt3dBasicPkg.frameGridSpeciesGridButtonClick(Sender: TObject;
  ACol, ARow: Integer);
var
  Grid: TStringGrid;
begin
  inherited;
  Grid := Sender as TStringGrid;
  dlgOpenSelectFile.FileName := Grid.Cells[ACol, ARow];
  if dlgOpenSelectFile.Execute then
  begin
    Grid.Cells[ACol, ARow] := dlgOpenSelectFile.FileName;
  end;
end;

procedure TframeMt3dBasicPkg.GetData(Package: TModflowPackageSelection);
var
  BasicPackage: TMt3dBasic;
begin
  inherited;
  BasicPackage := Package as TMt3dBasic;
  edMassUnit.Text := BasicPackage.MassUnit;
  rdeInactiveConcentration.Text := FloatToStr(BasicPackage.InactiveConcentration);
  rdeMinimumSaturatedFraction.Text := FloatToStr(BasicPackage.MinimumSaturatedFraction);
  seStressPeriod.AsInteger := BasicPackage.InitialConcentrationStressPeriod;
  seTimeStep.AsInteger := BasicPackage.InitialConcentrationTimeStep;
  seTransportStep.AsInteger := BasicPackage.InitialConcentrationTransportStep;

  frameGridMobile.Grid.Cells[Ord(scName),0] := StrMobileSpecies;
  frameGridMobile.Grid.Cells[Ord(scUseFile),0] := StrUseInitialConcentr;
  frameGridMobile.Grid.Cells[Ord(scFileName),0] := StrFileName;


  frameGridImmobile.Grid.Cells[Ord(scName),0] := StrImmobileSpecies;
  frameGridImmobile.Grid.Cells[Ord(scUseFile),0] := StrUseInitialConcentr;
  frameGridImmobile.Grid.Cells[Ord(scFileName),0] := StrFileName;
end;

procedure TframeMt3dBasicPkg.SetData(Package: TModflowPackageSelection);
var
  BasicPackage: TMt3dBasic;
begin
  inherited;
  BasicPackage := Package as TMt3dBasic;
  BasicPackage.MassUnit := edMassUnit.Text;
  BasicPackage.InactiveConcentration := StrToFloat(rdeInactiveConcentration.Text);
  BasicPackage.MinimumSaturatedFraction := StrToFloat(rdeMinimumSaturatedFraction.Text);
  BasicPackage.InitialConcentrationStressPeriod := seStressPeriod.AsInteger;
  BasicPackage.InitialConcentrationTimeStep := seTimeStep.AsInteger;
  BasicPackage.InitialConcentrationTransportStep := seTransportStep.AsInteger;
end;

procedure TframeMt3dBasicPkg.FixNames(Names: TStringList; AFrame: TframeGrid);
var
  Index: Integer;
  AName: string;
begin
  for Index := 1 to AFrame.seNumber.AsInteger do
  begin
    AName := Trim(AFrame.Grid.Cells[0, Index]);
    if AName <> '' then
    begin
      AName := GenerateNewRoot(AName);
      if Names.IndexOf(AName) >= 0 then
      begin
        AFrame.Grid.Cells[0, Index] := '';
      end
      else
      begin
        Names.Add(AName);
      end;
    end
    else
    begin
      AFrame.Grid.Cells[0, Index] := '';
    end;
  end;
end;

procedure TframeMt3dBasicPkg.SetMt3dComponents(
  Mt3DComponents: TCustomChemSpeciesCollection; AFrame: TframeGrid);
var
  ItemIndex: Integer;
  Index: Integer;
  Item: TChemSpeciesItem;
  AList: TList;
  GridCol: TStrings;
  ItemRow: integer;
begin
  AList := TList.Create;
  try
    for Index := 1 to AFrame.seNumber.AsInteger do
    begin
      if Trim(AFrame.Grid.Cells[0, Index]) <> '' then
      begin
        AList.Add(AFrame.Grid.Objects[0, Index]);
      end;
    end;
    GridCol := AFrame.Grid.Cols[0];
    for Index := Mt3DComponents.Count - 1 downto 0 do
    begin
      if AList.IndexOf(Mt3DComponents[Index]) < 0 then
      begin
        Item := Mt3DComponents[Index];
        ItemRow := GridCol.IndexOfObject(Item);
        if ItemRow >= 1 then
        begin
          AFrame.Grid.Objects[0, ItemRow] := nil;
        end;
        Mt3DComponents.Delete(Index);
      end;
    end;
    ItemIndex := 0;
    for Index := 1 to AFrame.seNumber.AsInteger do
    begin
      Item := AFrame.Grid.Objects[0, Index] as TChemSpeciesItem;
      if (Item = nil) and (Trim(AFrame.Grid.Cells[0, Index]) <> '') then
      begin
        Item := Mt3DComponents.Add;
      end;
      if Item <> nil then
      begin
        Item.Index := ItemIndex;
        Item.Name := Trim(AFrame.Grid.Cells[0, Index]);
        Item.UseInitialConcentrationFile := AFrame.Grid.Checked[Ord(scUseFile), Index];
        Item.InitialConcentrationFileName := AFrame.Grid.Cells[Ord(scFileName), Index];

        Inc(ItemIndex);
      end;
    end;
  finally
    AList.Free;
  end;
end;

procedure TframeMt3dBasicPkg.SetMt3dmsChemSpecies(
  MobileComponents: TMobileChemSpeciesCollection;
  ImmobileComponents: TChemSpeciesCollection);
var
  Names: TStringList;
begin
  Names := TStringList.Create;
  try
    Names.Sorted := True;
    Names.CaseSensitive := False;
    FixNames(Names, frameGridMobile);
    FixNames(Names, frameGridImmobile);
  finally
    Names.Free;
  end;

  SetMt3dComponents(MobileComponents, frameGridMobile);
  SetMt3dComponents(ImmobileComponents, frameGridImmobile);
end;

procedure TframeMt3dBasicPkg.EnableTimeControls;
var
  ShouldEnable: Boolean;
  RowIndex: Integer;
begin
  ShouldEnable := False;
  for RowIndex := 1 to frameGridMobile.Grid.RowCount - 1 do
  begin
    ShouldEnable := frameGridMobile.Grid.Checked[Ord(scUseFile), RowIndex];
    if ShouldEnable then
    begin
      break;
    end;
  end;
  if not ShouldEnable then
  begin
    for RowIndex := 1 to frameGridImmobile.Grid.RowCount - 1 do
    begin
      ShouldEnable := frameGridImmobile.Grid.Checked[Ord(scUseFile), RowIndex];
      if ShouldEnable then
      begin
        break;
      end;
    end;
  end;
  seStressPeriod.Enabled := ShouldEnable;
  seTimeStep.Enabled := ShouldEnable;
  seTransportStep.Enabled := ShouldEnable;
end;

procedure TframeMt3dBasicPkg.GetMt3dComponents(
  Mt3DComponents: TCustomChemSpeciesCollection; AFrame: TframeGrid);
var
  Item: TChemSpeciesItem;
  Index: Integer;
begin
  AFrame.seNumber.AsInteger := Mt3DComponents.Count;
  AFrame.Grid.BeginUpdate;
  try
    if Mt3DComponents.Count > 0 then
    begin
      for Index := 0 to Mt3DComponents.Count - 1 do
      begin
        Item := Mt3DComponents[Index];
        AFrame.Grid.Cells[Ord(scName), Index + 1] := Item.Name;
        AFrame.Grid.Checked[Ord(scUseFile), Index + 1] := Item.UseInitialConcentrationFile;
        AFrame.Grid.Cells[Ord(scFileName), Index + 1] := Item.InitialConcentrationFileName;
        AFrame.Grid.Objects[Ord(scName), Index + 1] := Item;
      end;
    end
    else
    begin
      AFrame.Grid.Cells[0, 1] := '';
    end;
  finally
    AFrame.Grid.EndUpdate;
  end;
  AFrame.seNumber.AsInteger := Mt3DComponents.Count;
end;

procedure TframeMt3dBasicPkg.GetMt3dmsChemSpecies(
  MobileComponents: TMobileChemSpeciesCollection;
  ImmobileComponents: TChemSpeciesCollection);
begin
  GetMt3dComponents(MobileComponents, frameGridMobile);
  GetMt3dComponents(ImmobileComponents, frameGridImmobile);
  EnableTimeControls;
end;

end.
