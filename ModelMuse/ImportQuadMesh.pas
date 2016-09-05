unit ImportQuadMesh;

interface

uses
  Windows, Classes, SutraMeshUnit, SysUtils;

procedure ImportSutraMeshFromFile(const AFileName: string; GmshExag: double = 1;
  ChangeVE: Boolean = True);

implementation

uses
  IOUtils, frmGoPhastUnit, ModelMuseUtilities, UndoItems, Dialogs,
  QuadTreeClass, PhastModelUnit, ScreenObjectUnit, Math, ZoomBox2,
  GoPhastTypes, frmErrorsAndWarningsUnit;

resourcestring
  StrTheMeshContained = 'The mesh contained %d triangular elements. The tria' +
  'ngular elements were skipped.';
  StrTriangularElements = 'Triangular Elements Locations';

type
  TUndoImportMesh = class(TUndoChangeMesh)
  private
    FUndoVE: TUndoVerticalExaggeration;
    FChangeVE: boolean;
  protected
    function Description: string; override;
  public
    constructor Create;
    // @name determines whether the vertical exaggeration will be set to
    // the default vertical exaggeration. @name is true by default.
    property ChangeVE: boolean read FChangeVE write FChangeVE;
    destructor Destroy; override;
    procedure DoCommand; override;
    procedure Undo; override;
  end;

procedure ImportArgusOneMesh(FileReader: TStreamReader; Splitter: TStringList;
  Mesh2D: TSutraMesh2D; ALine: string);
var
  ElementCount: Integer;
  NodeCount: Integer;
  Nodes: TSutraNode2DArray;
  NodeNumber: Integer;
  X: Extended;
  Y: Extended;
  ANode: TSutraNode2D;
//  ElementNumber: Integer;
  NodeIndex: Integer;
  AnElement: TSutraElement2D;
  NumberedNode: TSutraNodeNumber2D_Item;
//  Undo: TUndoImportMesh;
//  Mesh3D: TSutraMesh3D;
  NewNodeNumber: integer;
  NewElementNumber: integer;
begin
  repeat
    Splitter.DelimitedText := ALine;
    if (Splitter.Count > 0) and (Splitter[0] <> '#') then
    begin
      break;
    end;
    ALine := FileReader.ReadLine;
  until (Splitter.Count > 0) and (Splitter[0] <> '#');
  Assert(Splitter.Count >= 2);
  ElementCount := StrToInt(Splitter[0]);
  NodeCount := StrToInt(Splitter[1]);
  SetLength(Nodes, NodeCount+1);
  Mesh2D.Nodes.Capacity := NodeCount;
  Mesh2D.Elements.Capacity := ElementCount;
  NewNodeNumber := 0;
  NewElementNumber := 0;

  while not FileReader.EndOfStream do
  begin
    Splitter.DelimitedText := FileReader.ReadLine;
    if (Splitter.Count > 0) and (Splitter[0] <> '#') then
    begin
      if Splitter[0] = 'N' then
      begin
        Assert(Splitter.Count >= 4);
        NodeNumber := StrToInt(Splitter[1]);
        X := FortranStrToFloat(Splitter[2]);
        Y := FortranStrToFloat(Splitter[3]);
        ANode := TSutraNode2D.Create(Mesh2D.Nodes);
        ANode.X := X;
        ANode.Y := Y;
        ANode.Number := NewNodeNumber;
        Inc(NewNodeNumber);
        if NodeNumber >= Length(Nodes) then
        begin
          SetLength(Nodes, NodeNumber*2);
        end;
        Nodes[NodeNumber] := ANode;
      end
      else if Splitter[0] = 'E' then
      begin
        Assert(Splitter.Count >= 6);
        AnElement := TSutraElement2D.Create(Mesh2D.Elements);
        AnElement.ElementNumber := NewElementNumber;
        Inc(NewElementNumber);
        {ElementNumber :=}StrToInt(Splitter[1]);
        for NodeIndex := 2 to 5 do
        begin
          NodeNumber := StrToInt(Splitter[NodeIndex]);
          ANode := Nodes[NodeNumber];
          Assert(ANode <> nil);
          NumberedNode := AnElement.Nodes.Add;
          NumberedNode.Node := ANode;
        end;
      end
      else
      begin
        Assert(False);
      end;
    end;
  end
end;

procedure ImportFromGeomPack(FileReader: TStreamReader; Splitter: TStringList;
  Mesh2D: TSutraMesh2D; GeompackExag: double; FirstLine: string);
var
  ALine: string;
  NodeIndex: Integer;
  NewNodeNumber: Integer;
  Nodes: TSutraNode2DArray;
  NodeNumber: Integer;
  X: double;
  Y: double;
  ANode: TSutraNode2D;
  NodeCount: Integer;
  ElementCount: Integer;
  ElementIndex: Integer;
  ElementNumber: Integer;
//  ElementType: Integer;
//  TriangularElements: Integer;
  AnElement: TSutraElement2D;
  NumberedNode: TSutraNodeNumber2D_Item;
  NodeTree: TRbwQuadTree;
  Model: TPhastModel;
  ObjectIndex: Integer;
  AScreenObject: TScreenObject;
  MinX: Real;
  MaxX: Real;
  MinY: Real;
  MaxY: Real;
  ZoomBox: TQRbwZoomBox2;
  XEpsilon: Extended;
  YEpsilon: Extended;
  ObjectCount: Integer;
//  ErrorMessage: string;
  nvx: Integer;
  LineIndex: Integer;
  procedure CreateNode;
  begin
    ANode := TSutraNode2D.Create(Mesh2D.Nodes);
    ANode.X := X;
    ANode.Y := Y;
    NodeTree.AddPoint(X, Y, ANode);
    ANode.Number := NewNodeNumber;
    Inc(NewNodeNumber);
  end;
//  NodeList: TSutraNode2D_List;
begin
  Model := frmGoPhast.PhastModel;
  frmErrorsAndWarnings.RemoveWarningGroup(Model, StrTriangularElements);
  ZoomBox := frmGoPhast.frameTopView.ZoomBox;
  MinX := ZoomBox.X(0);
  MaxX := ZoomBox.X(ZoomBox.Width);
  MinY := ZoomBox.Y(ZoomBox.Height);
  MaxY := ZoomBox.Y(0);
  ObjectCount := 0;
  for ObjectIndex := 0 to Model.ScreenObjectCount - 1 do
  begin
    AScreenObject := Model.ScreenObjects[ObjectIndex];
    if AScreenObject.ViewDirection = vdTop then
    begin
      MinX := Min(MinX, AScreenObject.MinX);
      MaxX := Max(MaxX, AScreenObject.MaxX);
      MinY := Min(MinY, AScreenObject.MinY);
      MaxY := Max(MaxY, AScreenObject.MaxY);
      Inc(ObjectCount);
      if ObjectCount >= 100 then
      begin
        break;
      end;
    end;
  end;
  XEpsilon := (MaxX-MinX)/1e7;
  YEpsilon := (MaxY-MinY)/1e7;
  NodeTree := TRbwQuadTree.Create(nil);
//  NodeList := TSutraNode2D_List.Create;
  try
    NodeTree.XMin := MinX;
    NodeTree.XMax := MaxX;
    NodeTree.YMin := MinY;
    NodeTree.Ymax := MaxY;
    Assert (FirstLine <> '');
    NodeCount := StrToInt(FirstLine);
    SetLength(Nodes, NodeCount+1);
    NewNodeNumber := 0;
    for NodeIndex := 0 to NodeCount - 1 do
    begin
      repeat
        ALine := FileReader.ReadLine;
      until (ALine <> '');
      Splitter.DelimitedText := ALine;
      Assert(Splitter.Count = 3);
      NodeNumber := NodeIndex+1;
      X := FortranStrToFloat(Splitter[0]);
      Y := FortranStrToFloat(Splitter[1])/GeompackExag;

      if NodeTree.Count > 0 then
      begin
        ANode := NodeTree.NearestPointsFirstData(X, Y);
        if (Abs(ANode.X - X) > XEpsilon) or (Abs(ANode.Y - Y) > YEpsilon) then
        begin
          CreateNode;
        end;
      end
      else
      begin
        CreateNode;
      end;

      if NodeNumber >= Length(Nodes) then
      begin
        SetLength(Nodes, NodeNumber*2);
      end;
      Nodes[NodeNumber] := ANode;
    end;

    repeat
      ALine := FileReader.ReadLine;
    until (ALine <> '' );
    nvx := StrToInt(ALine);
    for LineIndex := 0 to nvx - 1 do
    begin
      repeat
        ALine := FileReader.ReadLine;
      until (ALine <> '' );
    end;

    repeat
      ALine := FileReader.ReadLine;
    until (ALine <> '' );
    Splitter.DelimitedText := ALine;
    Assert(Splitter.Count = 2);
    Assert(Splitter[0] = '4');
    ElementCount := StrToInt(Splitter[1]);

    ElementNumber := 0;
//    TriangularElements := 0;
    for ElementIndex := 0 to ElementCount - 1 do
    begin
      repeat
        ALine := FileReader.ReadLine;
      until (ALine <> '' );
      Splitter.DelimitedText := ALine;
      Assert(Splitter.Count = 4);
//      ElementType := StrToInt(Splitter[1]);
//      if ElementType = 3 then
//      begin
//        Assert(Splitter.Count = 4);
        AnElement := TSutraElement2D.Create(Mesh2D.Elements);
        AnElement.ElementNumber := ElementNumber;
        Inc(ElementNumber);
        for NodeIndex := 0 to Splitter.Count-1 do
        begin
          NodeNumber := StrToInt(Splitter[NodeIndex]);
          ANode := Nodes[NodeNumber];
          Assert(ANode <> nil);
          NumberedNode := AnElement.Nodes.Add;
          NumberedNode.Node := ANode;
        end;
//      end
//      else if ElementType = 2 then
//      begin
//        ErrorMessage := '';
//        Assert(Splitter.Count >= 6);
//        for NodeIndex := Splitter.Count-4 to Splitter.Count-1 do
//        begin
//          NodeNumber := StrToInt(Splitter[NodeIndex]);
//          ANode := Nodes[NodeNumber];
//          Assert(ANode <> nil);
//          ErrorMessage := ErrorMessage +  Format('(X: %0:g; Y: %1:g)', [ANode.X, ANode.Y]);
//          if NodeIndex < Splitter.Count-1 then
//          begin
//            ErrorMessage := ErrorMessage + ', ';
//          end;
//        end;
//        frmErrorsAndWarnings.AddWarning(Model, StrTriangularElements, ErrorMessage);
//        Inc(TriangularElements);
//
//      end;
    end;
//    ALine := FileReader.ReadLine;
//    Assert(ALine = '$EndElements');
//    if TriangularElements > 0 then
//    begin
//      Beep;
//      MessageDlg(Format(StrTheMeshContained, [TriangularElements]), mtWarning, [mbOK], 0);
//      frmErrorsAndWarnings.Show;
//    end;
    Mesh2D.DeleteUnconnectedNodes;
    Mesh2D.SetCorrectElementOrientation;
  finally
//    NodeList.Free;
    NodeTree.Free;
  end;
end;

procedure ImportFromGMsh(FileReader: TStreamReader; Splitter: TStringList;
  Mesh2D: TSutraMesh2D; GmshExag: double);
var
  ALine: string;
  NodeIndex: Integer;
  NewNodeNumber: Integer;
  Nodes: TSutraNode2DArray;
  NodeNumber: Integer;
  X: double;
  Y: double;
  ANode: TSutraNode2D;
  NodeCount: Integer;
  ElementCount: Integer;
  ElementIndex: Integer;
  ElementNumber: Integer;
  ElementType: Integer;
  TriangularElements: Integer;
  AnElement: TSutraElement2D;
  NumberedNode: TSutraNodeNumber2D_Item;
  NodeTree: TRbwQuadTree;
  Model: TPhastModel;
  ObjectIndex: Integer;
  AScreenObject: TScreenObject;
  MinX: Real;
  MaxX: Real;
  MinY: Real;
  MaxY: Real;
  ZoomBox: TQRbwZoomBox2;
  XEpsilon: Extended;
  YEpsilon: Extended;
  ObjectCount: Integer;
  ErrorMessage: string;
  procedure CreateNode;
  begin
    ANode := TSutraNode2D.Create(Mesh2D.Nodes);
    ANode.X := X;
    ANode.Y := Y;
    NodeTree.AddPoint(X, Y, ANode);
    ANode.Number := NewNodeNumber;
    Inc(NewNodeNumber);
  end;
//  NodeList: TSutraNode2D_List;
begin
  Model := frmGoPhast.PhastModel;
  frmErrorsAndWarnings.RemoveWarningGroup(Model, StrTriangularElements);
  ZoomBox := frmGoPhast.frameTopView.ZoomBox;
  MinX := ZoomBox.X(0);
  MaxX := ZoomBox.X(ZoomBox.Width);
  MinY := ZoomBox.Y(ZoomBox.Height);
  MaxY := ZoomBox.Y(0);
  ObjectCount := 0;
  for ObjectIndex := 0 to Model.ScreenObjectCount - 1 do
  begin
    AScreenObject := Model.ScreenObjects[ObjectIndex];
    if AScreenObject.ViewDirection = vdTop then
    begin
      MinX := Min(MinX, AScreenObject.MinX);
      MaxX := Max(MaxX, AScreenObject.MaxX);
      MinY := Min(MinY, AScreenObject.MinY);
      MaxY := Max(MaxY, AScreenObject.MaxY);
      Inc(ObjectCount);
      if ObjectCount >= 100 then
      begin
        break;
      end;
    end;
  end;
  XEpsilon := (MaxX-MinX)/1e7;
  YEpsilon := (MaxY-MinY)/1e7;
  NodeTree := TRbwQuadTree.Create(nil);
//  NodeList := TSutraNode2D_List.Create;
  try
    NodeTree.XMin := MinX;
    NodeTree.XMax := MaxX;
    NodeTree.YMin := MinY;
    NodeTree.Ymax := MaxY;
    repeat
      ALine := FileReader.ReadLine;
    until (ALine = '$Nodes');
    NodeCount := StrToInt(FileReader.ReadLine);
    SetLength(Nodes, NodeCount+1);
    NewNodeNumber := 0;
    for NodeIndex := 0 to NodeCount - 1 do
    begin
      Splitter.DelimitedText := FileReader.ReadLine;
      Assert(Splitter.Count = 4);
      NodeNumber := StrToInt(Splitter[0]);
      X := FortranStrToFloat(Splitter[1]);
      Y := FortranStrToFloat(Splitter[2])/GmshExag;

      if NodeTree.Count > 0 then
      begin
        ANode := NodeTree.NearestPointsFirstData(X, Y);
        if (Abs(ANode.X - X) > XEpsilon) or (Abs(ANode.Y - Y) > YEpsilon) then
        begin
          CreateNode;
        end;
      end
      else
      begin
        CreateNode;
      end;

      if NodeNumber >= Length(Nodes) then
      begin
        SetLength(Nodes, NodeNumber*2);
      end;
      Nodes[NodeNumber] := ANode;
    end;
    ALine := FileReader.ReadLine;
    Assert(ALine = '$EndNodes');

    repeat
      ALine := FileReader.ReadLine;
    until (ALine = '$Elements');
    ElementCount := StrToInt(FileReader.ReadLine);

    ElementNumber := 0;
    TriangularElements := 0;
    for ElementIndex := 0 to ElementCount - 1 do
    begin
      Splitter.DelimitedText := FileReader.ReadLine;
      Assert(Splitter.Count >= 2);
      ElementType := StrToInt(Splitter[1]);
      if ElementType = 3 then
      begin
        Assert(Splitter.Count >= 7);
        AnElement := TSutraElement2D.Create(Mesh2D.Elements);
        AnElement.ElementNumber := ElementNumber;
        Inc(ElementNumber);
        for NodeIndex := Splitter.Count-4 to Splitter.Count-1 do
        begin
          NodeNumber := StrToInt(Splitter[NodeIndex]);
          ANode := Nodes[NodeNumber];
          Assert(ANode <> nil);
          NumberedNode := AnElement.Nodes.Add;
          NumberedNode.Node := ANode;
        end;
      end
      else if ElementType = 2 then
      begin
        ErrorMessage := '';
        Assert(Splitter.Count >= 6);
        for NodeIndex := Splitter.Count-4 to Splitter.Count-1 do
        begin
          NodeNumber := StrToInt(Splitter[NodeIndex]);
          ANode := Nodes[NodeNumber];
          Assert(ANode <> nil);
          ErrorMessage := ErrorMessage +  Format('(X: %0:g; Y: %1:g)', [ANode.X, ANode.Y]);
          if NodeIndex < Splitter.Count-1 then
          begin
            ErrorMessage := ErrorMessage + ', ';
          end;
        end;
        frmErrorsAndWarnings.AddWarning(Model, StrTriangularElements, ErrorMessage);
        Inc(TriangularElements);

      end;
    end;
    ALine := FileReader.ReadLine;
    Assert(ALine = '$EndElements');
    if TriangularElements > 0 then
    begin
      Beep;
      MessageDlg(Format(StrTheMeshContained, [TriangularElements]), mtWarning, [mbOK], 0);
      frmErrorsAndWarnings.Show;
    end;
    Mesh2D.DeleteUnconnectedNodes;
    Mesh2D.SetCorrectElementOrientation;
  finally
//    NodeList.Free;
    NodeTree.Free;
  end;
end;


procedure ImportSutraMeshFromFile(const AFileName: string; GmshExag: double = 1;
  ChangeVE: Boolean = True);
var
  FileReader: TStreamReader;
  Splitter: TStringList;
  Mesh2D: TSutraMesh2D;
  Undo: TUndoImportMesh;
  Mesh3D: TSutraMesh3D;
  ALine: string;
  Value: integer;
begin
  FileReader := TFile.OpenText(AFileName);
  try
    Mesh3D := TSutraMesh3D.Create(nil);
    try
      Mesh2D := Mesh3D.Mesh2D;
      Mesh2D.MeshGenControls := frmGoPhast.PhastModel.SutraMesh.Mesh2D.MeshGenControls;
      Splitter := TStringList.Create;
      try
        Splitter.Delimiter := ' ';
        ALine := FileReader.ReadLine;
        if ALine = '$MeshFormat' then
        begin
          ImportFromGMsh(FileReader, Splitter, Mesh2D, GmshExag);
        end
        else
        begin
          Splitter.DelimitedText := ALine;
          if (Splitter.Count = 1) and TryStrToInt(ALine, Value) then
          begin
            ImportFromGeomPack(FileReader, Splitter, Mesh2D, GmshExag, ALine);
          end
          else
          begin
            ImportArgusOneMesh(FileReader, Splitter, Mesh2D, ALine);
          end;
        end;

      finally
        Splitter.Free;
      end;
      Mesh3D.DeleteUnconnectedNodes;
      Mesh3D.SetCorrectElementOrientation;
      Undo := TUndoImportMesh.Create;
      Undo.ChangeVE := ChangeVE;
      Undo.UpdateOldMesh(frmGoPhast.PhastModel.SutraMesh);
      Undo.UpdateNewMesh(Mesh3D);
      frmGoPhast.UndoStack.Submit(Undo);
    finally
      Mesh3D.Free;
    end;
  finally
    FileReader.Free
  end;
end;

{ TUndoImportMesh }

constructor TUndoImportMesh.Create;
begin
  inherited;
  FChangeVE := True;
end;

function TUndoImportMesh.Description: string;
begin
  result := 'ímport SUTRA mesh';
end;

destructor TUndoImportMesh.Destroy;
begin
  FUndoVE.Free;
  inherited;
end;

procedure TUndoImportMesh.DoCommand;
begin
  inherited;
  if FChangeVE then
  begin
    if FUndoVE = nil then
    begin
      FUndoVE := TUndoVerticalExaggeration.Create(frmGoPhast.DefaultVE);
    end;
    FUndoVE.DoCommand;
  end;
end;

procedure TUndoImportMesh.Undo;
begin
  inherited;
  if FChangeVE then
  begin
    FUndoVE.Undo;
  end;
end;

end.
