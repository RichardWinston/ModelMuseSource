unit ModflowFmpSoilUnit;

interface

uses
  OrderedCollectionUnit, ModflowBoundaryUnit, SysUtils, Classes,
  ModflowFmpBaseClasses;

type
  TSoilType = (stSandyLoam, stSilt, stSiltyClay, stOther);

  TSoilItem = class(TCustomZeroFarmItem)
  private
    const
    CapillaryFringePosition =  0;
    ACoeffPosition = 1;
    BCoeffPosition = 2;
    CCoeffPosition = 3;
    DCoeffPosition = 4;
    ECoeffPosition = 5;
    var
    FSoilName: string;
    FSoilType: TSoilType;
    function GetACoeff: string;
    function GetBCoeff: string;
    function GetCapillaryFringe: string;
    function GetCCoeff: string;
    function GetDCoeff: string;
    function GetECoeff: string;
    procedure SetACoeff(const Value: string);
    procedure SetBCoeff(const Value: string);
    procedure SetCapillaryFringe(const Value: string);
    procedure SetCCoeff(const Value: string);
    procedure SetDCoeff(const Value: string);
    procedure SetECoeff(const Value: string);
    procedure SetSoilName(Value: string);
    procedure SetSoilType(const Value: TSoilType);
  protected
    // See @link(BoundaryFormula).
    function GetBoundaryFormula(Index: integer): string; override;
    // See @link(BoundaryFormula).
    procedure SetBoundaryFormula(Index: integer; const Value: string); override;
    function BoundaryFormulaCount: integer; override;
    // @name checks whether AnotherItem is the same as the current @classname.
    function IsSame(AnotherItem: TOrderedItem): boolean; override;
    procedure SetIndex(Value: Integer); override;
  public
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;

  published
    property SoilName: string read FSoilName write SetSoilName;
    property SoilType: TSoilType read FSoilType write SetSoilType;
    property CapillaryFringe: string read GetCapillaryFringe write SetCapillaryFringe;
    property ACoeff: string read GetACoeff write SetACoeff;
    property BCoeff: string read GetBCoeff write SetBCoeff;
    property CCoeff: string read GetCCoeff write SetCCoeff;
    property DCoeff: string read GetDCoeff write SetDCoeff;
    property ECoeff: string read GetECoeff write SetECoeff;
  end;

  TSoilRecord = record
    SoilID: integer;
    SoilType: TSoilType;
    CapillaryFringe: double;
    ACoeff: double;
    BCoeff: double;
    CCoeff: double;
    DCoeff: double;
    ECoeff: double;
  end;

  TSoilArray = array of TSoilRecord;

  TSoilCollection = class(TCustomFarmCollection)
  private
    FSoilArray: TSoilArray;
    function GetItems(Index: Integer): TSoilItem;
    procedure SetItems(Index: Integer; const Value: TSoilItem);
  protected
    class function ItemClass: TBoundaryItemClass; override;
    procedure DeleteItemsWithZeroDuration; override;
  public
    property SoilArray: TSoilArray read FSoilArray;
    property Items[Index: Integer]: TSoilItem read GetItems write SetItems; default;
    procedure EvaluateSoils;
  end;

implementation

uses
  PhastModelUnit, ModflowPackageSelectionUnit, RbwParser, frmFormulaErrorsUnit,
  GoPhastTypes;

resourcestring
  StrSoilVariable = 'Soil Variable';

//const
//  CapillaryFringePosition =  0;
//  ACoeffPosition = 1;
//  BCoeffPosition = 2;
//  CCoeffPosition = 3;
//  DCoeffPosition = 4;
//  ECoeffPosition = 5;


{ TSoilItem }

procedure TSoilItem.Assign(Source: TPersistent);
var
  SourceItem: TSoilItem;
begin
  if Source is TSoilItem then
  begin
    SourceItem := TSoilItem(Source);
    SoilName := SourceItem.SoilName;
    SoilType := SourceItem.SoilType;
  end;
  inherited;
end;

function TSoilItem.BoundaryFormulaCount: integer;
begin
  result := 6
end;

destructor TSoilItem.Destroy;
var
  LocalModel: TPhastModel;
  Position: integer;
begin
  if (Model <> nil) and (SoilName <> '')  then
  begin
    LocalModel := Model as TPhastModel;
    Position := LocalModel.GlobalVariables.IndexOfVariable(SoilName);
    if Position >= 0 then
    begin
      LocalModel.GlobalVariables.Delete(Position);
    end;
  end;
  inherited;
end;

function TSoilItem.GetACoeff: string;
begin
  Result := FFormulaObjects[ACoeffPosition].Formula;
  ResetItemObserver(ACoeffPosition);
end;

function TSoilItem.GetBCoeff: string;
begin
  Result := FFormulaObjects[BCoeffPosition].Formula;
  ResetItemObserver(BCoeffPosition);
end;

function TSoilItem.GetBoundaryFormula(Index: integer): string;
begin
  case Index of
    CapillaryFringePosition:
      result := CapillaryFringe;
    ACoeffPosition:
      result := ACoeff;
    BCoeffPosition:
      result := BCoeff;
    CCoeffPosition:
      result := CCoeff;
    DCoeffPosition:
      result := DCoeff;
    ECoeffPosition:
      result := ECoeff;
    else Assert(False);
  end;
end;

function TSoilItem.GetCapillaryFringe: string;
begin
  Result := FFormulaObjects[CapillaryFringePosition].Formula;
  ResetItemObserver(CapillaryFringePosition);
end;

function TSoilItem.GetCCoeff: string;
begin
  Result := FFormulaObjects[CCoeffPosition].Formula;
  ResetItemObserver(CCoeffPosition);
end;

function TSoilItem.GetDCoeff: string;
begin
  Result := FFormulaObjects[DCoeffPosition].Formula;
  ResetItemObserver(DCoeffPosition);
end;

function TSoilItem.GetECoeff: string;
begin
  Result := FFormulaObjects[ECoeffPosition].Formula;
  ResetItemObserver(ECoeffPosition);
end;

function TSoilItem.IsSame(AnotherItem: TOrderedItem): boolean;
var
  OtherItem: TSoilItem;
begin
  Result := (AnotherItem is TSoilItem) and inherited IsSame(AnotherItem);
  if Result then
  begin
    OtherItem := TSoilItem(AnotherItem);
    result := (SoilName = OtherItem.SoilName)
      and (SoilType = OtherItem.SoilType)
  end;
end;

procedure TSoilItem.SetACoeff(const Value: string);
begin
  if FFormulaObjects[ACoeffPosition].Formula <> Value then
  begin
    UpdateFormula(Value, ACoeffPosition, FFormulaObjects[ACoeffPosition]);
  end;
end;

procedure TSoilItem.SetBCoeff(const Value: string);
begin
  if FFormulaObjects[BCoeffPosition].Formula <> Value then
  begin
    UpdateFormula(Value, BCoeffPosition, FFormulaObjects[BCoeffPosition]);
  end;
end;

procedure TSoilItem.SetBoundaryFormula(Index: integer; const Value: string);
begin
  case Index of
    CapillaryFringePosition:
      CapillaryFringe := Value;
    ACoeffPosition:
      ACoeff := Value;
    BCoeffPosition:
      BCoeff := Value;
    CCoeffPosition:
      CCoeff := Value;
    DCoeffPosition:
      DCoeff := Value;
    ECoeffPosition:
      ECoeff := Value;
    else Assert(False);
  end;
end;

procedure TSoilItem.SetCapillaryFringe(const Value: string);
begin
  if FFormulaObjects[CapillaryFringePosition].Formula <> Value then
  begin
    UpdateFormula(Value, CapillaryFringePosition, FFormulaObjects[CapillaryFringePosition]);
  end;
end;

procedure TSoilItem.SetCCoeff(const Value: string);
begin
  if FFormulaObjects[CCoeffPosition].Formula <> Value then
  begin
    UpdateFormula(Value, CCoeffPosition, FFormulaObjects[CCoeffPosition]);
  end;
end;

procedure TSoilItem.SetDCoeff(const Value: string);
begin
  if FFormulaObjects[DCoeffPosition].Formula <> Value then
  begin
    UpdateFormula(Value, DCoeffPosition, FFormulaObjects[DCoeffPosition]);
  end;
end;

procedure TSoilItem.SetECoeff(const Value: string);
begin
  if FFormulaObjects[ECoeffPosition].Formula <> Value then
  begin
    UpdateFormula(Value, ECoeffPosition, FFormulaObjects[ECoeffPosition]);
  end;
end;

procedure TSoilItem.SetIndex(Value: Integer);
var
  ChangeGlobals: TDefineGlobalObject;
begin
  if {(Index <> Value) and} (Model <> nil) and (FSoilName <> '') then
  begin
    ChangeGlobals := TDefineGlobalObject.Create(Model, FSoilName, FSoilName,
      StrSoilVariable);
    try
      ChangeGlobals.SetValue(Value+1);
    finally
      ChangeGlobals.Free;
    end;
  end;
  inherited;

end;

procedure TSoilItem.SetSoilName(Value: string);
var
  ChangeGlobals: TDefineGlobalObject;
begin
  if (FSoilName <> Value) and (Model <> nil)
    and not (csReading in Model.ComponentState) then
  begin
    Value := GenerateNewName(Value, nil, '_');
  end;
  ChangeGlobals := TDefineGlobalObject.Create(Model, FSoilName, Value,
    StrSoilVariable);
  try
    if FSoilName <> Value then
    begin
      if (Model <> nil) and (Value <> '') then
      begin
        ChangeGlobals.Rename;
      end;
      FSoilName := Value;
      InvalidateModel;
    end;
    if (Model <> nil) and (FSoilName <> '') then
    begin
      ChangeGlobals.SetValue(Index+1);
    end;
  finally
    ChangeGlobals.Free;
  end;
end;

procedure TSoilItem.SetSoilType(const Value: TSoilType);
begin
  if FSoilType <> Value then
  begin
    FSoilType := Value;
    InvalidateModel;
  end;
end;

{ TSoilCollection }

procedure TSoilCollection.DeleteItemsWithZeroDuration;
begin
//  inherited;
  // Don't delete based on duration.
end;

procedure TSoilCollection.EvaluateSoils;
var
  CurrentRecord: TSoilRecord;
  Compiler: TRbwParser;
  PhastModel: TPhastModel;
  Formula: string;
  Expression: TExpression;
  Index: integer;
  CurrentItem: TSoilItem;
  FarmProcess: TFarmProcess;
begin
  PhastModel := Model as TPhastModel;
  FarmProcess := PhastModel.ModflowPackages.FarmProcess;
  SetLength(FSoilArray, Count);
  Compiler := PhastModel.rpThreeDFormulaCompiler;
  for Index := 0 to Count - 1 do
  begin
    CurrentItem := Items[Index];
    CurrentRecord.SoilID := Index+1;

    Expression := nil;
    Formula := CurrentItem.CapillaryFringe;
    try
      Compiler.Compile(Formula);
      Expression := Compiler.CurrentExpression;
      // only global variables are used so there should be no need
      // to update the variables.
      Expression.Evaluate;
    except on E: ERbwParserError do
      begin
        frmFormulaErrors.AddFormulaError('', Format(
          'Error in Capillary Fringe for "%s" in the Farm Process', [CurrentItem.SoilName]),
          Formula, E.Message);

        CurrentItem.CapillaryFringe := '0.';
        Formula := CurrentItem.CapillaryFringe;
        Compiler.Compile(Formula);
        Expression := Compiler.CurrentExpression;
        Expression.Evaluate;
      end;
    end;
    CurrentRecord.CapillaryFringe := Expression.DoubleResult;

    CurrentRecord.SoilType := CurrentItem.SoilType;

    if (FarmProcess.CropConsumptiveConcept = cccConcept1)
      and (CurrentItem.SoilType = stOther) then
    begin
      Expression := nil;
      Formula := CurrentItem.ACoeff;
      try
        Compiler.Compile(Formula);
        Expression := Compiler.CurrentExpression;
        // only global variables are used so there should be no need
        // to update the variables.
        Expression.Evaluate;
      except on E: ERbwParserError do
        begin
          frmFormulaErrors.AddFormulaError('', Format(
            'Error in A-Coeff for "%s" in the Farm Process', [CurrentItem.SoilName]),
            Formula, E.Message);

          CurrentItem.ACoeff := '0.';
          Formula := CurrentItem.ACoeff;
          Compiler.Compile(Formula);
          Expression := Compiler.CurrentExpression;
          Expression.Evaluate;
        end;
      end;
      CurrentRecord.ACoeff := Expression.DoubleResult;

      Expression := nil;
      Formula := CurrentItem.BCoeff;
      try
        Compiler.Compile(Formula);
        Expression := Compiler.CurrentExpression;
        // only global variables are used so there should be no need
        // to update the variables.
        Expression.Evaluate;
      except on E: ERbwParserError do
        begin
          frmFormulaErrors.AddFormulaError('', Format(
            'Error in B-Coeff for "%s" in the Farm Process', [CurrentItem.SoilName]),
            Formula, E.Message);

          CurrentItem.BCoeff := '0.';
          Formula := CurrentItem.BCoeff;
          Compiler.Compile(Formula);
          Expression := Compiler.CurrentExpression;
          Expression.Evaluate;
        end;
      end;
      CurrentRecord.BCoeff := Expression.DoubleResult;

      Expression := nil;
      Formula := CurrentItem.CCoeff;
      try
        Compiler.Compile(Formula);
        Expression := Compiler.CurrentExpression;
        // only global variables are used so there should be no need
        // to update the variables.
        Expression.Evaluate;
      except on E: ERbwParserError do
        begin
          frmFormulaErrors.AddFormulaError('', Format(
            'Error in C-Coeff for "%s" in the Farm Process', [CurrentItem.SoilName]),
            Formula, E.Message);

          CurrentItem.CCoeff := '0.';
          Formula := CurrentItem.CCoeff;
          Compiler.Compile(Formula);
          Expression := Compiler.CurrentExpression;
          Expression.Evaluate;
        end;
      end;
      CurrentRecord.CCoeff := Expression.DoubleResult;

      Expression := nil;
      Formula := CurrentItem.DCoeff;
      try
        Compiler.Compile(Formula);
        Expression := Compiler.CurrentExpression;
        // only global variables are used so there should be no need
        // to update the variables.
        Expression.Evaluate;
      except on E: ERbwParserError do
        begin
          frmFormulaErrors.AddFormulaError('', Format(
            'Error in D-Coeff for "%s" in the Farm Process', [CurrentItem.SoilName]),
            Formula, E.Message);

          CurrentItem.DCoeff := '0.';
          Formula := CurrentItem.DCoeff;
          Compiler.Compile(Formula);
          Expression := Compiler.CurrentExpression;
          Expression.Evaluate;
        end;
      end;
      CurrentRecord.DCoeff := Expression.DoubleResult;

      Expression := nil;
      Formula := CurrentItem.ECoeff;
      try
        Compiler.Compile(Formula);
        Expression := Compiler.CurrentExpression;
        // only global variables are used so there should be no need
        // to update the variables.
        Expression.Evaluate;
      except on E: ERbwParserError do
        begin
          frmFormulaErrors.AddFormulaError('', Format(
            'Error in E-Coeff for "%s" in the Farm Process', [CurrentItem.SoilName]),
            Formula, E.Message);

          CurrentItem.ECoeff := '0.';
          Formula := CurrentItem.ECoeff;
          Compiler.Compile(Formula);
          Expression := Compiler.CurrentExpression;
          Expression.Evaluate;
        end;
      end;
      CurrentRecord.ECoeff := Expression.DoubleResult;

    end;

    FSoilArray[Index] := CurrentRecord;
  end;
end;

function TSoilCollection.GetItems(Index: Integer): TSoilItem;
begin
  result := inherited Items[Index] as TSoilItem;
end;

class function TSoilCollection.ItemClass: TBoundaryItemClass;
begin
  result := TSoilItem;
end;

procedure TSoilCollection.SetItems(Index: Integer; const Value: TSoilItem);
begin
  inherited Items[Index] := Value;
end;

end.
