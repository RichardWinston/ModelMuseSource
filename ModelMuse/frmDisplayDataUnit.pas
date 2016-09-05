unit frmDisplayDataUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCustomGoPhastUnit, frameStreamLinkUnit, JvPageList, ExtCtrls,
  ComCtrls, JvExComCtrls, JvPageListTreeView, JvExControls, StdCtrls, Buttons,
  frameHeadObservationResultsUnit, frameModpathDisplayUnit,
  frameModpathTimeSeriesDisplayUnit, frameModpathEndpointDisplayUnit,
  frameCustomColorUnit, frameColorGridUnit, frameContourDataUnit,
  frameVectorsUnit, frameDrawCrossSectionUnit, frameSwrReachConnectionsUnit,
  frameSwrObsDisplayUnit, Mask, JvExMask, JvSpin;

type
  TPostPages = (ppColorGrid, ppContourData, ppPathline, ppEndPoints,
    ppTimeSeries, ppHeadObs, ppSfrStreamLink, ppStrStreamLink,
    ppSwrReachConnections, ppSwrObsDisplay,
    ppVectors, ppCrossSection);

  TfrmDisplayData = class(TfrmCustomGoPhast)
    pglstMain: TJvPageList;
    tvpglstMain: TJvPageListTreeView;
    splSplit: TSplitter;
    jvspSfrStreamLinks: TJvStandardPage;
    frameSfrStreamLink: TframeStreamLink;
    pnlBottom: TPanel;
    btnHelp: TBitBtn;
    btnApply: TBitBtn;
    btnClose: TBitBtn;
    jvspHeadObsResults: TJvStandardPage;
    frameHeadObservationResults: TframeHeadObservationResults;
    jvspModpathPathline: TJvStandardPage;
    frameModpathDisplay: TframeModpathDisplay;
    jvspModpathTimeSeries: TJvStandardPage;
    frameModpathTimeSeriesDisplay: TframeModpathTimeSeriesDisplay;
    jvspModpathEndpoints: TJvStandardPage;
    frameModpathEndpointDisplay1: TframeModpathEndpointDisplay;
    jvspColorGrid: TJvStandardPage;
    frameColorGrid: TframeColorGrid;
    jvspContourData: TJvStandardPage;
    frameContourData: TframeContourData;
    jvspVectors: TJvStandardPage;
    frameVectors: TframeVectors;
    jvspStrStreamLinks: TJvStandardPage;
    frameStrStreamLink: TframeStreamLink;
    jvspCrossSection: TJvStandardPage;
    frameDrawCrossSection: TframeDrawCrossSection;
    jvspSwrReachConnections: TJvStandardPage;
    frameSwrReachConnections: TframeSwrReachConnections;
    jvspSwrObsDisplay: TJvStandardPage;
    frameSwrObsDisplay: TframeSwrObsDisplay;
    procedure btnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject); override;
    procedure pglstMainChange(Sender: TObject);
    procedure tvpglstMainChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure tvpglstMainCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure frameContourDatavirttreecomboDataSetsChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject); override;
    procedure FormShow(Sender: TObject);
    procedure frameSwrReachConnectionsbtnReachColorClick(Sender: TObject);
    procedure frameSwrReachConnectionsbtnUnconnectedColorClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure frameColorGridResize(Sender: TObject);
    procedure frameContourDataResize(Sender: TObject);
    procedure frameColorGridsplColorMoved(Sender: TObject);
    procedure frameContourDatasplColorMoved(Sender: TObject);
    procedure frameColorGridreCommentResizeRequest(Sender: TObject;
      Rect: TRect);
  private
    FShouldUpdate: Boolean;
    procedure SetData;
    { Private declarations }
  public
    procedure GetData;
    procedure SetPage(Page: TPostPages);
    property ShouldUpdate: Boolean read FShouldUpdate write FShouldUpdate;
    procedure UpdateLabelsAndLegend;
    procedure UpdateColorSchemes;
    procedure NilDisplay;
    { Public declarations }
  end;

var
  frmDisplayData: TfrmDisplayData = nil;

procedure UpdateFrmDisplayData(Force: boolean = false);

implementation

uses
  frmGoPhastUnit, PhastModelUnit, GoPhastTypes, ModflowPackagesUnit;

resourcestring
  StrColorGrid = 'Color Grid';
  StrContourData = 'Contour Data';
  StrMODPATHPathlines = 'MODPATH Pathlines';
  StrMODPATHEndPoints = 'MODPATH End Points';
  StrMODPATHTimeSeries = 'MODPATH Time Series';
  StrHeadObservationRes = 'Head Observation Results';
  StrStreamLinks = 'SFR Stream Links';
  StrStreamStrLinks = 'STR Stream Links';
  StrVectors = 'Vectors (SUTRA models)';
  StrCrossSections = 'Cross Sections';
  StrSWRReachConnection = 'SWR Reach Connections';
  StrSWRObservations = 'SWR Observations';

{$R *.dfm}

procedure UpdateFrmDisplayData(Force: boolean = false);
begin
  if (frmDisplayData <> nil) and (Force or frmDisplayData.Visible)
    and (frmGoPhast.PhastModel <> nil)
    and not (csDestroying in frmGoPhast.ComponentState)
    and not frmGoPhast.PhastModel.Clearing then
  begin
    frmDisplayData.GetData;
    frmDisplayData.UpdateLabelsAndLegend;
  end;
end;

procedure TfrmDisplayData.btnApplyClick(Sender: TObject);
begin
  inherited;
  SetData;
end;

procedure TfrmDisplayData.FormCreate(Sender: TObject);
var
  Node: TJvPageIndexNode;
begin
  inherited;
  AdjustFormPosition(dpRight);
  Handle;
  tvpglstMain.Handle;

  tvpglstMain.Items.Clear;
  // All nodes must be created even if they aren't used
  // for "GetData" to work properly.
  Node := tvpglstMain.Items.Add(nil, StrColorGrid) as TJvPageIndexNode;
  Node.PageIndex := jvspColorGrid.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrContourData) as TJvPageIndexNode;
  Node.PageIndex := jvspContourData.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrMODPATHPathlines) as TJvPageIndexNode;
  Node.PageIndex := jvspModpathPathline.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrMODPATHEndPoints) as TJvPageIndexNode;
  Node.PageIndex := jvspModpathEndpoints.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrMODPATHTimeSeries) as TJvPageIndexNode;
  Node.PageIndex := jvspModpathTimeSeries.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrHeadObservationRes) as TJvPageIndexNode;
  Node.PageIndex := jvspHeadObsResults.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrStreamLinks) as TJvPageIndexNode;
  Node.PageIndex := jvspSfrStreamLinks.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrStreamStrLinks) as TJvPageIndexNode;
  Node.PageIndex := jvspStrStreamLinks.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrSWRReachConnection) as TJvPageIndexNode;
  Node.PageIndex := jvspSwrReachConnections.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrSWRObservations) as TJvPageIndexNode;
  Node.PageIndex := jvspSwrObsDisplay.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrVectors) as TJvPageIndexNode;
  Node.PageIndex := jvspVectors.PageIndex;
  Node := tvpglstMain.Items.Add(nil, StrCrossSections) as TJvPageIndexNode;
  Node.PageIndex := jvspCrossSection.PageIndex;
end;

procedure TfrmDisplayData.FormDestroy(Sender: TObject);
begin
  inherited;
  frmDisplayData := nil;
end;

procedure TfrmDisplayData.FormResize(Sender: TObject);
begin
  inherited;
  if tvpglstMain.Left > splSplit.Left then
  begin
    tvpglstMain.Left := splSplit.Left;
  end;
end;

procedure TfrmDisplayData.FormShow(Sender: TObject);
begin
  inherited;
  frameHeadObservationResults.lblGraphInstructions.Width :=
    frameHeadObservationResults.pnlGraphControls.ClientWidth -
    frameHeadObservationResults.lblGraphInstructions.Left - 8;
end;

procedure TfrmDisplayData.frameColorGridreCommentResizeRequest(Sender: TObject;
  Rect: TRect);
begin
  inherited;
   Beep;
end;

procedure TfrmDisplayData.frameColorGridResize(Sender: TObject);
begin
  inherited;
  frameColorGrid.FrameResize(Sender);
  FormResize(Sender);
end;

procedure TfrmDisplayData.frameColorGridsplColorMoved(Sender: TObject);
begin
  inherited;
  FormResize(Sender);
end;

procedure TfrmDisplayData.frameContourDataResize(Sender: TObject);
begin
  inherited;
  frameContourData.FrameResize(Sender);
  FormResize(Sender);
end;

procedure TfrmDisplayData.frameContourDatasplColorMoved(Sender: TObject);
begin
  inherited;
  FormResize(Sender);
end;

procedure TfrmDisplayData.frameContourDatavirttreecomboDataSetsChange(
  Sender: TObject);
begin
  inherited;
  frameContourData.virttreecomboDataSetsChange(Sender);
end;

procedure TfrmDisplayData.frameSwrReachConnectionsbtnReachColorClick(
  Sender: TObject);
begin
  inherited;
  frameSwrReachConnections.btnReachColorClick(Sender);

end;

procedure TfrmDisplayData.frameSwrReachConnectionsbtnUnconnectedColorClick(
  Sender: TObject);
begin
  inherited;
  frameSwrReachConnections.btnUnconnectedColorClick(Sender);

end;

procedure TfrmDisplayData.GetData;
var
  LocalModel: TPhastModel;
  ModflowSelected: Boolean;
  ModpathSelected: Boolean;
  SfrSelected: Boolean;
  StrSelected: boolean;
  HeadObsSelected: Boolean;
  VectorSelected: Boolean;
  SwrSelected: Boolean;
begin
  Handle;
  tvpglstMain.Handle;
  LocalModel := frmGoPhast.PhastModel;
  ModflowSelected := LocalModel.ModelSelection in ModflowSelection;
  ModpathSelected := ModflowSelected and LocalModel.MODPATHIsSelected;
  SfrSelected := ModflowSelected and LocalModel.SfrIsSelected;
  StrSelected := ModflowSelected and LocalModel.StrIsSelected;
  SwrSelected := ModflowSelected and LocalModel.SwrIsSelected;
  HeadObsSelected := ModflowSelected and LocalModel.HobIsSelected;
  VectorSelected := LocalModel.ModelSelection in SutraSelection;

  if Ord(High(TPostPages)) <> tvpglstMain.Items.Count-1 then
  begin
    Beep;
    Exit
  end;
  Assert(Ord(High(TPostPages)) = tvpglstMain.Items.Count-1);

  tvpglstMain.Items[Ord(ppPathline)].Enabled :=
    ModpathSelected
    or (LocalModel.PathLines.Lines.Count > 0)
    or (LocalModel.PathLines.LinesV6.Count > 0);
  tvpglstMain.Items[Ord(ppEndPoints)].Enabled :=
    ModpathSelected
    or (LocalModel.EndPoints.Points.Count > 0)
    or (LocalModel.EndPoints.PointsV6.Count > 0);
  tvpglstMain.Items[Ord(ppTimeSeries)].Enabled :=
    ModpathSelected
    or (LocalModel.TimeSeries.Series.Count > 0)
    or (LocalModel.TimeSeries.SeriesV6.Count > 0);
  tvpglstMain.Items[Ord(ppHeadObs)].Enabled :=
    HeadObsSelected or (LocalModel.HeadObsResults.Count > 0);
  tvpglstMain.Items[Ord(ppSfrStreamLink)].Enabled := SfrSelected;
  tvpglstMain.Items[Ord(ppStrStreamLink)].Enabled := StrSelected;
  tvpglstMain.Items[Ord(ppSwrReachConnections)].Enabled := SwrSelected;
  tvpglstMain.Items[Ord(ppSwrObsDisplay)].Enabled := SwrSelected;

  tvpglstMain.Items[Ord(ppVectors)].Enabled := VectorSelected;
  tvpglstMain.Items[Ord(ppCrossSection)].Enabled := ModflowSelected;

  if frmGoPhast.ModelSelection in ModflowSelection then
  begin
    frameStrStreamLink.GetData(stSTR);
    frameSfrStreamLink.GetData(stSFR);
    frameHeadObservationResults.GetData;
    frameModpathDisplay.GetData;
    frameModpathTimeSeriesDisplay.GetData;
    frameModpathEndpointDisplay1.GetData;
    frameDrawCrossSection.GetData;
    frameSwrReachConnections.GetData;
  end
  else if frmGoPhast.ModelSelection in SutraSelection then
  begin
    frameVectors.GetData;
  end;
  frameColorGrid.GetData;
  frameContourData.GetData;

//  frameColorGrid.UpdateLabelsAndLegend;
//  frameContourData.UpdateLabelsAndLegend;
end;

procedure TfrmDisplayData.NilDisplay;
begin
  frameColorGrid.LegendDataSource := nil;
  frameContourData.LegendDataSource := nil;
end;

procedure TfrmDisplayData.pglstMainChange(Sender: TObject);
begin
  inherited;
  HelpKeyword := pglstMain.ActivePage.HelpKeyword;
  btnApply.Enabled := pglstMain.ActivePage <> jvspSwrObsDisplay;

  if (pglstMain.ActivePage = jvspSwrObsDisplay)
    and not frameSwrObsDisplay.ReachesUpdated then
  begin
    frameSwrObsDisplay.GetData;
  end;
end;

procedure TfrmDisplayData.SetData;
begin
  if pglstMain.ActivePage = jvspSfrStreamLinks then
  begin
    if frmGoPhast.ModelSelection in ModflowSelection then
    begin
      frameSfrStreamLink.SetData;
    end;
  end
  else if pglstMain.ActivePage = jvspStrStreamLinks then
  begin
    if frmGoPhast.ModelSelection in ModflowSelection then
    begin
      frameStrStreamLink.SetData;
    end;
  end
  else if pglstMain.ActivePage = jvspHeadObsResults then
  begin
    if frmGoPhast.ModelSelection in ModflowSelection then
    begin
      frameHeadObservationResults.SetData;
    end;
  end
  else if pglstMain.ActivePage = jvspModpathPathline then
  begin
    if frmGoPhast.ModelSelection in ModflowSelection then
    begin
      frameModpathDisplay.SetData;
    end;
  end
  else if pglstMain.ActivePage = jvspModpathTimeSeries then
  begin
    if frmGoPhast.ModelSelection in ModflowSelection then
    begin
      frameModpathTimeSeriesDisplay.SetData;
    end;
  end

  else if pglstMain.ActivePage = jvspSwrReachConnections then
  begin
    if frmGoPhast.ModelSelection in ModflowSelection then
    begin
      frameSwrReachConnections.SetData;
    end;
  end

  else if pglstMain.ActivePage = jvspModpathEndpoints then
  begin
    if frmGoPhast.ModelSelection in ModflowSelection then
    begin
      frameModpathEndpointDisplay1.SetData;
    end;
  end
  else if pglstMain.ActivePage = jvspColorGrid then
  begin
    frameColorGrid.SetData;
  end
  else if pglstMain.ActivePage = jvspContourData then
  begin
    frameContourData.SetData;
  end
  else if pglstMain.ActivePage = jvspVectors then
  begin
    frameVectors.SetData;
  end
  else if pglstMain.ActivePage = jvspCrossSection then
  begin
    frameDrawCrossSection.SetData;
  end;
end;

procedure TfrmDisplayData.SetPage(Page: TPostPages);
begin
  tvpglstMain.Items[Ord(Page)].Selected := True;
end;

procedure TfrmDisplayData.tvpglstMainChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange := tvpglstMain.Items[Node.Index].Enabled;
end;

procedure TfrmDisplayData.tvpglstMainCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  inherited;
  if Node.Enabled then
  begin
    tvpglstMain.Canvas.Font.Color := clBlack;
  end
  else
  begin
    tvpglstMain.Canvas.Font.Color := clBtnShadow;
  end;
  if Node.Selected and not Sender.Focused then
  begin
    Sender.Canvas.Brush.Color := clMenuHighlight;
  end;
end;

procedure TfrmDisplayData.UpdateColorSchemes;
begin
  frameColorGrid.UpdateColorSchemes;
  frameContourData.UpdateColorSchemes;
end;

procedure TfrmDisplayData.UpdateLabelsAndLegend;
begin
  frameColorGrid.UpdateLabelsAndLegend;
  frameContourData.UpdateLabelsAndLegend;
  frameModpathEndpointDisplay1.UpdateLabelsAndLegend;
  ShouldUpdate := False;
end;

end.
