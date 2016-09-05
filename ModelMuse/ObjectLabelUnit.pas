unit ObjectLabelUnit;

interface

uses
  Types, Classes, Controls, Graphics;

type
  TCustomObjectLabel = class(TPersistent)
  private
    FFont: TFont;
    FVisible: boolean;
    FOnChange: TNotifyEvent;
    FOffSet: TPoint;
    procedure SetFont(const Value: TFont);
    procedure SetOffSet(const Value: TPoint);
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure SetVisible(const Value: boolean);
  protected
    procedure DoChange; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Font: TFont read FFont write SetFont;
    // Instead of specifying the location of the label, a label offset
    // is specified. This will be the offset from the location of the
    // object with which @classname is associated.
    property OffSet: TPoint read FOffSet write SetOffSet;
    property Visible: boolean read FVisible write SetVisible;
    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
  end;

  TObjectLabel = class(TCustomObjectLabel)
  private
    FCaption: TCaption;
    procedure SetCaption(const Value: TCaption);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: TCaption read FCaption write SetCaption;
  end;

  TObjectVertexLabel = class(TCustomObjectLabel);

implementation

{ TCustomObjectLabel }

procedure TCustomObjectLabel.Assign(Source: TPersistent);
var
  SourceLabel: TCustomObjectLabel;
begin
  if Source is TCustomObjectLabel then
  begin
    SourceLabel := TCustomObjectLabel(Source);
    Font := SourceLabel.Font;
    OffSet := SourceLabel.OffSet;
    Visible := SourceLabel.Visible;
  end
  else
  begin
    inherited;
  end;
end;

constructor TCustomObjectLabel.Create;
begin
  FFont := TFont.Create;
  FFont.Color := clBlack;
  FOffSet.Y := 20;
end;

destructor TCustomObjectLabel.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TCustomObjectLabel.DoChange;
begin
  if Assigned(OnChange) then
  begin
    OnChange(Self);
  end;
end;

procedure TObjectLabel.Assign(Source: TPersistent);
var
  SourceLabel: TObjectLabel;
begin
  if Source is TObjectLabel then
  begin
    SourceLabel := TObjectLabel(Source);
    Caption := SourceLabel.Caption;
  end;
  inherited;
end;

procedure TObjectLabel.SetCaption(const Value: TCaption);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    DoChange
  end;
end;

procedure TCustomObjectLabel.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  DoChange;
end;

procedure TCustomObjectLabel.SetOffSet(const Value: TPoint);
begin
  if (FOffSet.X <> Value.X) or (FOffSet.Y <> Value.Y) then
  begin
    FOffSet := Value;
    DoChange
  end;
end;

procedure TCustomObjectLabel.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TCustomObjectLabel.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    DoChange
  end;
end;

end.
