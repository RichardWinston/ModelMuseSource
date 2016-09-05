unit frmFilesToArchiveUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCustomGoPhastUnit, StdCtrls, Buttons, ExtCtrls, JvExStdCtrls,
  UndoItems, StrUtils, JvExControls, JvLinkLabel, ComCtrls, JvRichEdit,
  Vcl.Menus, System.Generics.Collections;

type
  TfrmFilesToArchive = class(TfrmCustomGoPhast)
    pnlBottom: TPanel;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    btnHelp: TBitBtn;
    btnArchive: TButton;
    sdArchive: TSaveDialog;
    btnAddFiles: TButton;
    odAddFiles: TOpenDialog;
    JvLinkLabel1: TJvLinkLabel;
    btnArchiveList: TButton;
    dlgSaveArchiveList: TSaveDialog;
    tvArchive: TTreeView;
    pm1: TPopupMenu;
    mniAddFiles: TMenuItem;
    mniDelete: TMenuItem;
    procedure FormCreate(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure btnOKClick(Sender: TObject);
    procedure btnArchiveClick(Sender: TObject);
    procedure JvLinkLabel1LinkClick(Sender: TObject; LinkNumber: Integer;
      LinkText, LinkParam: string);
    procedure btnArchiveListClick(Sender: TObject);
    procedure tvArchiveCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure tvArchiveDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvArchiveDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure mniAddFilesClick(Sender: TObject);
    procedure mniDeleteClick(Sender: TObject);
  private
//    FFilesToArchive: TStringList;
    FBinaryFileNode: TTreeNode;
    FAncillaryNode: TTreeNode;
    FModelInputFilesNode: TTreeNode;
    FModelOutputFiles: TTreeNode;
    FModpathInputFiles: TTreeNode;
    FModpathOutputFiles: TTreeNode;
    FZonebudgetInputFiles: TTreeNode;
    FZonebudgetOutputFiles: TTreeNode;
    FMt3dmsInputFiles: TTreeNode;
    FMt3dmsOutputFiles: TTreeNode;
    FRootNodes: TList<TTreeNode>;
    procedure GetData;
    procedure SetData;
    procedure AddFilesToTree(FileNames: TStrings; Classification: string;
      var ANode: TTreeNode);
    procedure EnableCreateArchive;
    { Private declarations }
  public
    { Public declarations }
  end;

  TFileLists = class(TObject)
  private
    FAuxilliaryFiles: TStringList;
    FModelInputFiles: TStringList;
    FModelOutputFiles: TStringList;
    FModpathInputFiles: TStringList;
    FModpathOutputFiles: TStringList;
    FZonebudgetInputFiles: TStringList;
    FZonebudgetOutputFiles: TStringList;
    FMt3dmsInputFiles: TStringList;
    FMt3dmsOutputFiles: TStringList;
    function SameContents(Strings1, Strings2: TStrings): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function IsSame(OtherFiles: TFileLists): Boolean;
  end;

  TUndoFilesToArchive = class(TCustomUndo)
  private
    FOriginalFiles: TFileLists;
    FNewFiles: TFileLists;
    procedure AssignFilesToModel(Files: TFileLists);
  protected
    function Description: string; override;
  public
    constructor Create(var NewFiles: TFileLists);
    destructor Destroy; override;
    // @name does the command for the first time.
    procedure DoCommand; override;
    // @name undoes the command.
    procedure Undo; override;
    function Changed: boolean;
  end;


implementation

uses frmGoPhastUnit, JvLinkLabelTools, AbExcept, System.IOUtils, System.Contnrs,
  PhastModelUnit, ArchiveNodeInterface, ModelMuseUtilities;

resourcestring
  StrChangedFilesToArc = 'changed files to archive';
  StrModelMuseCanOnlyC = 'ModelMuse can only create archives in the zip form' +
  'at.';

{$R *.dfm}

procedure TfrmFilesToArchive.btnArchiveClick(Sender: TObject);
begin
  inherited;
  sdArchive.FileName := frmGoPhast.PhastModel.ArchiveName;
  if sdArchive.Execute then
  begin
    try
      frmGoPhast.PhastModel.CreateArchive(sdArchive.FileName);
    except on E: EAbException do
      begin
        Beep;
        MessageDlg(E.message, mtError, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TfrmFilesToArchive.btnArchiveListClick(Sender: TObject);
var
  ArchiveName: string;
begin
  inherited;
  if frmGoPhast.PhastModel.ModelFileName = '' then
  begin
    ArchiveName := GetCurrentDir + '\Archive.axml'
  end
  else
  begin
    ArchiveName := ChangeFileExt(frmGoPhast.PhastModel.ModelFileName, '.axml');
  end;
  dlgSaveArchiveList.FileName := ArchiveName;
  if dlgSaveArchiveList.Execute then
  begin
    frmGoPhast.PhastModel.SaveArchiveList(dlgSaveArchiveList.FileName);
  end;
end;

procedure TfrmFilesToArchive.btnOKClick(Sender: TObject);
begin
  inherited;
  SetData;
end;

procedure TfrmFilesToArchive.EnableCreateArchive;
var
  index: Integer;
  ButtonEnabled: Boolean;
begin
  ButtonEnabled := False;
  for index := 0 to FRootNodes.Count - 1 do
  begin
    ButtonEnabled := FRootNodes[index]. HasChildren;
    if ButtonEnabled then
    begin
      break;
    end;
  end;
  btnArchive.Enabled := ButtonEnabled;
end;

procedure TfrmFilesToArchive.FormCreate(Sender: TObject);
begin
  inherited;
  FRootNodes := TList<TTreeNode>.Create;
//  FFilesToArchive := TStringList.Create;
  GetData;
  EnableCreateArchive;
//  btnArchive.Enabled := FFilesToArchive.Count > 0;
end;

procedure TfrmFilesToArchive.FormDestroy(Sender: TObject);
begin
  inherited;
//  FFilesToArchive.Free;
  FRootNodes.Free;
end;

procedure TfrmFilesToArchive.GetData;
var
  InputFiles: TStringList;
  ProgramFiles: TStringList;
  ChildIndex: Integer;
  AChildModel: TChildModel;
  ProgramIndex: Integer;
  PosIndex: Integer;
begin
//  FFilesToArchive.Clear;
//  FFilesToArchive.Duplicates := dupIgnore;
//  FFilesToArchive.Sorted := True;
//  if frmGoPhast.PhastModel.ModelFileName <> '' then
//  begin
//    FFilesToArchive.Add(frmGoPhast.PhastModel.ModelFileName);
//  end;
//  FFilesToArchive.AddStrings(frmGoPhast.PhastModel.FilesToArchive);
//  FFilesToArchive.AddStrings(frmGoPhast.PhastModel.ModelInputFiles);
//  FFilesToArchive.AddStrings(frmGoPhast.PhastModel.ModelOutputFiles);
//  FFilesToArchive.AddStrings(frmGoPhast.PhastModel.ModpathInputFiles);
//  FFilesToArchive.AddStrings(frmGoPhast.PhastModel.ModpathOutputFiles);
//  FFilesToArchive.AddStrings(frmGoPhast.PhastModel.ZonebudgetInputFiles);
//  FFilesToArchive.AddStrings(frmGoPhast.PhastModel.ZonebudgetOutputFiles);
//  FFilesToArchive.AddStrings(frmGoPhast.PhastModel.Mt3dmsInputFiles);
//  FFilesToArchive.AddStrings(frmGoPhast.PhastModel.Mt3dmsOutputFiles);
//  reFilesToSave.Lines := FFilesToArchive;

  InputFiles := TStringList.Create;
  ProgramFiles := TStringList.Create;
  try
    InputFiles.Duplicates := dupIgnore;
    InputFiles.Sorted := True;

    InputFiles.AddStrings(frmGoPhast.PhastModel.FilesToArchive);
    for ChildIndex := 0 to frmGoPhast.PhastModel.ChildModels.Count - 1 do
    begin
      AChildModel := frmGoPhast.PhastModel.ChildModels[ChildIndex].ChildModel;
      InputFiles.AddStrings(AChildModel.FilesToArchive);
    end;
    AddFilesToTree(InputFiles, StrAncillary, FAncillaryNode);

    ProgramFiles.Duplicates := dupIgnore;
    ProgramFiles.Sorted := True;
    frmGoPhast.PhastModel.AddModelProgramsToList(ProgramFiles);
    InputFiles.AddStrings(frmGoPhast.PhastModel.ModelInputFiles);
    for ChildIndex := 0 to frmGoPhast.PhastModel.ChildModels.Count - 1 do
    begin
      AChildModel := frmGoPhast.PhastModel.ChildModels[ChildIndex].ChildModel;
      InputFiles.AddStrings(AChildModel.ModelInputFiles);
    end;
    frmGoPhast.PhastModel.AddModelProgramsToList(ProgramFiles);
    for ProgramIndex := 0 to ProgramFiles.Count - 1 do
    begin
      PosIndex := InputFiles.IndexOf(ProgramFiles[ProgramIndex]);
      if PosIndex >= 0 then
      begin
        InputFiles.Delete(PosIndex);
      end;
    end;
    AddFilesToTree(ProgramFiles, StrBinary, FBinaryFileNode);
    AddFilesToTree(InputFiles, StrModelInputFiles, FModelInputFilesNode);
  finally
    InputFiles.Free;
    ProgramFiles.Free;
  end;

//  AddFilesToTree(frmGoPhast.PhastModel.ModelInputFiles, 'Model Input Files',
//    FModelInputFilesNode);
  AddFilesToTree(frmGoPhast.PhastModel.ModelOutputFiles, StrModelOutputFiles,
    FModelOutputFiles);
  AddFilesToTree(frmGoPhast.PhastModel.ModpathInputFiles, 'Modpath Input Files',
    FModpathInputFiles);
  AddFilesToTree(frmGoPhast.PhastModel.ModpathOutputFiles, 'Modpath Output Files',
    FModpathOutputFiles);
  AddFilesToTree(frmGoPhast.PhastModel.ZonebudgetInputFiles, 'Zonebudget Input Files',
    FZonebudgetInputFiles);
  AddFilesToTree(frmGoPhast.PhastModel.ZonebudgetOutputFiles, 'Zonebudget Output Files',
    FZonebudgetOutputFiles);
  AddFilesToTree(frmGoPhast.PhastModel.Mt3dmsInputFiles, 'MT3DMS Input Files',
    FMt3dmsInputFiles);
  AddFilesToTree(frmGoPhast.PhastModel.Mt3dmsOutputFiles, 'MT3DMS Output Files',
    FMt3dmsOutputFiles);
end;

procedure TfrmFilesToArchive.JvLinkLabel1LinkClick(Sender: TObject;
  LinkNumber: Integer; LinkText, LinkParam: string);
begin
  inherited;
//  TWebTools.OpenWebPage('http://water.usgs.gov/admin/memo/GW/gw11.01.html');
  TWebTools.OpenWebPage('http://water.usgs.gov/admin/memo/GW/gw2015.02.pdf');
end;

procedure TfrmFilesToArchive.mniAddFilesClick(Sender: TObject);
var
  RootNode: TTreeNode;
  FileName: string;
  FileIndex: Integer;
begin
  inherited;
  if odAddFiles.Execute then
  begin
    RootNode := tvArchive.Selected;
    if RootNode = nil then
    begin
      RootNode := FAncillaryNode;
    end;
    if FRootNodes.IndexOf(RootNode) < 0 then
    begin
      RootNode := RootNode.Parent;
    end;
    for FileIndex := 0 to odAddFiles.Files.Count - 1 do
    begin
      FileName := odAddFiles.Files[FileIndex];
      tvArchive.Items.AddChild(RootNode, FileName)
    end;
  end;
end;

procedure TfrmFilesToArchive.mniDeleteClick(Sender: TObject);
var
  ANode: TTreeNode;
  NextNode: TTreeNode;
  NodesToDelete: TObjectList;
begin
  inherited;
  NodesToDelete := TObjectList.Create;
  try
    ANode := tvArchive.Items.GetFirstNode;
    while ANode <> nil do
    begin
      NextNode := ANode.GetNext;
      if ANode.Selected and (FRootNodes.IndexOf(ANode) < 0) then
      begin
        NodesToDelete.Add(ANode);
      end;
      ANode := NextNode
    end;
  finally
    NodesToDelete.Free;
  end;
  EnableCreateArchive;
end;

procedure TfrmFilesToArchive.AddFilesToTree(FileNames: TStrings; Classification: string; var ANode: TTreeNode);
var
  index: Integer;
begin
  ANode := tvArchive.Items.Add(nil, Classification);
  FRootNodes.Add(ANode);
  for index := 0 to FileNames.Count - 1 do
  begin
    tvArchive.Items.AddChild(ANode, FileNames[index]);
  end;
end;

procedure TfrmFilesToArchive.SetData;
var
  NewFiles: TFileLists;
  Undo2: TUndoFilesToArchive;
  procedure AddNodeTextToStrings(RootNode: TTreeNode; FileNames: TStringList);
  var
    ANode: TTreeNode;
  begin
    ANode := RootNode.getFirstChild;
    FileNames.Sorted := True;
    while ANode <> nil do
    begin
      if FileNames.IndexOf(ANode.Text) < 0 then
      begin
        FileNames.Add(ANode.Text);
      end;
      ANode := ANode.getNextSibling;
    end;
  end;
begin
  NewFiles := TFileLists.Create;
  try
    AddNodeTextToStrings(FAncillaryNode, NewFiles.FAuxilliaryFiles);
    AddNodeTextToStrings(FModelInputFilesNode, NewFiles.FModelInputFiles);
    AddNodeTextToStrings(FBinaryFileNode, NewFiles.FModelInputFiles);
    AddNodeTextToStrings(FModelOutputFiles, NewFiles.FModelOutputFiles);
    AddNodeTextToStrings(FModpathInputFiles, NewFiles.FModpathInputFiles);
    AddNodeTextToStrings(FModpathOutputFiles, NewFiles.FModpathOutputFiles);
    AddNodeTextToStrings(FZonebudgetInputFiles, NewFiles.FZonebudgetInputFiles);
    AddNodeTextToStrings(FZonebudgetOutputFiles, NewFiles.FZonebudgetOutputFiles);
    AddNodeTextToStrings(FMt3dmsInputFiles, NewFiles.FMt3dmsInputFiles);
    AddNodeTextToStrings(FMt3dmsOutputFiles, NewFiles.FMt3dmsOutputFiles);

    Undo2 := TUndoFilesToArchive.Create(NewFiles);
    try
      if Undo2.Changed then
      begin
        frmGoPhast.UndoStack.Submit(Undo2)
      end
      else
      begin
        Undo2.Free;
      end;
    except
      Undo2.free;
//      raise;
    end;
  finally
    NewFiles.Free;
  end;
end;

procedure TfrmFilesToArchive.tvArchiveCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  FileName: string;
begin
  inherited;
  if FRootNodes.IndexOf(Node) < 0  then
  begin
    FileName := Node.Text;

    if not TPath.DriveExists(FileName) then
    begin
      tvArchive.Canvas.Brush.Color := clRed;
    end
    else if not TFile.Exists(FileName) then
    begin
      tvArchive.Canvas.Brush.Color := clRed;
    end;
  end;
end;

procedure TfrmFilesToArchive.tvArchiveDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Dst: TTreeNode;
  ANode: TTreeNode;
  NodesToMove: TList<TTreeNode>;
  NodeIndex: Integer;
begin
//  Src := tvArchive.Selected;
  Dst := tvArchive.GetNodeAt(X,Y);
  if FRootNodes.IndexOf(Dst) < 0 then
  begin
    Dst := Dst.Parent
  end;
  NodesToMove := TList<TTreeNode>.Create;
  try
    ANode := tvArchive.Items.GetFirstNode;
    while ANode <> nil do
    begin
      if ANode.Selected and (Self.FRootNodes.IndexOf(ANode) < 0) and
        (ANode.Parent <> Dst) then
      begin
        NodesToMove.Add(ANode);
      end;
      ANode := ANode.GetNext;
    end;
    for NodeIndex := 0 to NodesToMove.Count - 1 do
    begin
      NodesToMove[NodeIndex].MoveTo(Dst, naAddChild);
    end;
  finally
    NodesToMove.Free;
  end;

//  Src.MoveTo(Dst, naAddChild);
end;

procedure TfrmFilesToArchive.tvArchiveDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Src, Dst: TTreeNode;
begin
  Src := tvArchive.Selected;
  Dst := tvArchive.GetNodeAt(X,Y);
  Accept := (Sender = Source) and Assigned(Dst) and (Src<>Dst)
    and (FRootNodes.IndexOf(Src) < 0);
end;

{ TFileLists }

constructor TFileLists.Create;
begin
  FAuxilliaryFiles := TStringList.Create;
  FModelInputFiles := TStringList.Create;
  FModelOutputFiles := TStringList.Create;
  FModpathInputFiles := TStringList.Create;
  FModpathOutputFiles := TStringList.Create;
  FZonebudgetInputFiles := TStringList.Create;
  FZonebudgetOutputFiles := TStringList.Create;
  FMt3dmsInputFiles := TStringList.Create;
  FMt3dmsOutputFiles := TStringList.Create;
end;

destructor TFileLists.Destroy;
begin
  FAuxilliaryFiles.Free;
  FModelInputFiles.Free;
  FModelOutputFiles.Free;
  FModpathInputFiles.Free;
  FModpathOutputFiles.Free;
  FZonebudgetInputFiles.Free;
  FZonebudgetOutputFiles.Free;
  FMt3dmsInputFiles.Free;
  FMt3dmsOutputFiles.Free;
  inherited;
end;

function TFileLists.IsSame(OtherFiles: TFileLists): Boolean;
begin
  result := SameContents(FAuxilliaryFiles, OtherFiles.FAuxilliaryFiles)
    and SameContents(FModelInputFiles, OtherFiles.FModelInputFiles)
    and SameContents(FModelOutputFiles, OtherFiles.FModelOutputFiles)
    and SameContents(FModpathInputFiles, OtherFiles.FModpathInputFiles)
    and SameContents(FModpathOutputFiles, OtherFiles.FModpathOutputFiles)
    and SameContents(FZonebudgetInputFiles, OtherFiles.FZonebudgetInputFiles)
    and SameContents(FZonebudgetOutputFiles, OtherFiles.FZonebudgetOutputFiles)
    and SameContents(FMt3dmsInputFiles, OtherFiles.FMt3dmsInputFiles)
    and SameContents(FMt3dmsOutputFiles, OtherFiles.FMt3dmsOutputFiles)
end;

function TFileLists.SameContents(Strings1, Strings2: TStrings): boolean;
var
  index: Integer;
begin
  result := Strings1.Count = Strings2.Count;
  if result then
  begin
    for index := 0 to Strings1.Count - 1 do
    begin
      result := Strings1[index] = Strings2[index];
      if not Result then
      begin
        Exit;
      end;
    end;
  end;
end;

{ TNewUndoFilesToArchive }

procedure TUndoFilesToArchive.AssignFilesToModel(Files: TFileLists);
var
  ChildIndex: Integer;
  AChildModel: TChildModel;
begin
  frmGoPhast.PhastModel.FilesToArchive := Files.FAuxilliaryFiles;
  frmGoPhast.PhastModel.ModelInputFiles := Files.FModelInputFiles;
  frmGoPhast.PhastModel.ModelOutputFiles := Files.FModelOutputFiles;
  frmGoPhast.PhastModel.ModpathInputFiles := Files.FModpathInputFiles;
  frmGoPhast.PhastModel.ModpathOutputFiles := Files.FModpathOutputFiles;
  frmGoPhast.PhastModel.ZonebudgetInputFiles := Files.FZonebudgetInputFiles;
  frmGoPhast.PhastModel.ZonebudgetOutputFiles := Files.FZonebudgetOutputFiles;
  frmGoPhast.PhastModel.Mt3dmsInputFiles := Files.FMt3dmsInputFiles;
  frmGoPhast.PhastModel.Mt3dmsOutputFiles := Files.FMt3dmsOutputFiles;

  for ChildIndex := 0 to frmGoPhast.PhastModel.ChildModels.Count - 1 do
  begin
    AChildModel := frmGoPhast.PhastModel.ChildModels[ChildIndex].ChildModel;
    AChildModel.FilesToArchive.Clear;
    AChildModel.ModelInputFiles.Clear;
    AChildModel.ModelOutputFiles.Clear;
    AChildModel.ModpathInputFiles.Clear;
    AChildModel.ModpathOutputFiles.Clear;
    AChildModel.ZonebudgetInputFiles.Clear;
    AChildModel.ZonebudgetOutputFiles.Clear;
    AChildModel.Mt3dmsInputFiles.Clear;
    AChildModel.Mt3dmsOutputFiles.Clear;
  end;

end;

function TUndoFilesToArchive.Changed: boolean;
begin
  Result := not FOriginalFiles.IsSame(FNewFiles);
end;

constructor TUndoFilesToArchive.Create(var NewFiles: TFileLists);
var
  ChildIndex: Integer;
  AChildModel: TChildModel;
begin
  FOriginalFiles := TFileLists.Create;
  FOriginalFiles.FAuxilliaryFiles.AddStrings(frmGoPhast.PhastModel.FilesToArchive);
  FOriginalFiles.FModelInputFiles.AddStrings(frmGoPhast.PhastModel.ModelInputFiles);
  FOriginalFiles.FModelOutputFiles.AddStrings(frmGoPhast.PhastModel.ModelOutputFiles);
  FOriginalFiles.FModpathInputFiles.AddStrings(frmGoPhast.PhastModel.ModpathInputFiles);
  FOriginalFiles.FModpathOutputFiles.AddStrings(frmGoPhast.PhastModel.ModpathOutputFiles);
  FOriginalFiles.FZonebudgetInputFiles.AddStrings(frmGoPhast.PhastModel.ZonebudgetInputFiles);
  FOriginalFiles.FZonebudgetOutputFiles.AddStrings(frmGoPhast.PhastModel.ZonebudgetOutputFiles);
  FOriginalFiles.FMt3dmsInputFiles.AddStrings(frmGoPhast.PhastModel.Mt3dmsInputFiles);
  FOriginalFiles.FMt3dmsOutputFiles.AddStrings(frmGoPhast.PhastModel.Mt3dmsOutputFiles);

  for ChildIndex := 0 to frmGoPhast.PhastModel.ChildModels.Count - 1 do
  begin
    AChildModel := frmGoPhast.PhastModel.ChildModels[ChildIndex].ChildModel;
    FOriginalFiles.FAuxilliaryFiles.AddStrings(AChildModel.FilesToArchive);
    FOriginalFiles.FModelInputFiles.AddStrings(AChildModel.ModelInputFiles);
    FOriginalFiles.FModelOutputFiles.AddStrings(AChildModel.ModelOutputFiles);
    FOriginalFiles.FModpathInputFiles.AddStrings(AChildModel.ModpathInputFiles);
    FOriginalFiles.FModpathOutputFiles.AddStrings(AChildModel.ModpathOutputFiles);
    FOriginalFiles.FZonebudgetInputFiles.AddStrings(AChildModel.ZonebudgetInputFiles);
    FOriginalFiles.FZonebudgetOutputFiles.AddStrings(AChildModel.ZonebudgetOutputFiles);
    FOriginalFiles.FMt3dmsInputFiles.AddStrings(AChildModel.Mt3dmsInputFiles);
    FOriginalFiles.FMt3dmsOutputFiles.AddStrings(AChildModel.Mt3dmsOutputFiles);
  end;

  FNewFiles := NewFiles;
  NewFiles := nil;
end;

function TUndoFilesToArchive.Description: string;
begin
  result := StrChangedFilesToArc;
end;

destructor TUndoFilesToArchive.Destroy;
begin
  FOriginalFiles.Free;
  FNewFiles.Free;
  inherited;
end;

procedure TUndoFilesToArchive.DoCommand;
begin
  inherited;
  AssignFilesToModel(FNewFiles);
end;

procedure TUndoFilesToArchive.Undo;
begin
  inherited;
  AssignFilesToModel(FOriginalFiles);
end;

end.
