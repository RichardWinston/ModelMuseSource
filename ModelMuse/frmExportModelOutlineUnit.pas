unit frmExportModelOutlineUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmCustomGoPhastUnit, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, XBase1, frmGoPhastUnit, FastGEO,
  System.Generics.Collections, AbstractGridUnit, GPC_Classes, ShapefileUnit;

type
  TPointList = TList<TPoint2D>;

  TExportChoice = (ecEntireGrid, ecActiveCells, acActiveAndInactive);

  TfrmExportModelOutline = class(TfrmCustomGoPhast)
    rgExportChoice: TRadioGroup;
    pnlBottom: TPanel;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    btnHelp: TBitBtn;
    sdShapefile: TSaveDialog;
    xbsShapeFile: TXBase;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
  private
    FGrid: TCustomModelGrid;
    FOutline: TGpcPolygonClass;
    FGeomWriter: TShapefileGeometryWriter;
    procedure SetData;
    procedure GetEntireGridOutline(var Polygon: TGpcPolygonClass);
    procedure GetActiveGridOutline(var ActiveCells, InactiveCells: TGpcPolygonClass;
      out InactiveCellCount: Integer);
    procedure GetActiveAndInactiveGrid;
    procedure GetMeshOutline;
//    procedure StoreGeometry;
//    procedure StoreDataBase;
    procedure StoreAShape;
    procedure AppendDataBaseRecord(Active: Boolean);
    procedure InitializeDataBase;
    procedure FinalizeDataBase;
    procedure InitializeGeometryWriter;
    procedure FinalizeGeometryWriter;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExportModelOutline: TfrmExportModelOutline;

implementation

uses
  DataSetUnit, PhastModelUnit, gpc, SutraMeshUnit;

resourcestring
  StrAREA = 'AREA';
  StrACTIVE = 'ACTIVE';

{$R *.dfm}

procedure TfrmExportModelOutline.btnOKClick(Sender: TObject);
begin
  inherited;
  if sdShapefile.Execute then
  begin
    SetData
  end
  else
  begin
    ModalResult := mrNone;
  end;
end;

procedure TfrmExportModelOutline.FormCreate(Sender: TObject);
begin
  inherited;
  FOutline := TGpcPolygonClass.Create;
  if frmGoPhast.Grid = nil then
  begin
    rgExportChoice.Items[0] := 'Mesh outline';
    rgExportChoice.Items[1] := 'Active elements';
    rgExportChoice.Controls[1].Enabled := False;
    rgExportChoice.Items[2] := 'Active and inactive elements';
    rgExportChoice.Controls[2].Enabled := False;
  end;
end;

procedure TfrmExportModelOutline.FormDestroy(Sender: TObject);
begin
  inherited;
  FOutline.Free;
end;

procedure TfrmExportModelOutline.GetActiveAndInactiveGrid;
var
  ActiveCells: TGpcPolygonClass;
  GridOutline: TGpcPolygonClass;
  InactiveCount: Integer;
  Temp: TGpcPolygonClass;
  InactiveCells: TGpcPolygonClass;
begin
  ActiveCells := TGpcPolygonClass.Create;
  GridOutline := TGpcPolygonClass.Create;
  InactiveCells := TGpcPolygonClass.Create;
  try
    InactiveCount := 0;
    GetActiveGridOutline(ActiveCells, InactiveCells, InactiveCount);
    if InactiveCount = 0 then
    begin
      GetEntireGridOutline(GridOutline);
      Temp := FOutline;
      try
        FOutline := GridOutline;
        StoreAShape;
        AppendDataBaseRecord(True);
      finally
        FOutline := Temp;
      end;
    end
    else
    begin
      Temp := FOutline;
      try
        FOutline := ActiveCells;
        StoreAShape;
        AppendDataBaseRecord(True);

        FOutline := InactiveCells;
        StoreAShape;
        AppendDataBaseRecord(False);
      finally
        FOutline := Temp;
      end;
    end;
  finally
    ActiveCells.Free;
    GridOutline.Free;
    InactiveCells.Free;
  end;
end;

procedure TfrmExportModelOutline.GetActiveGridOutline(
  var ActiveCells, InactiveCells: TGpcPolygonClass; out InactiveCellCount: Integer);
var
  ActiveDataArray: TDataArray;
  RowIndex: Integer;
  ColIndex: Integer;
  IsActive: Boolean;
  LayerIndex: Integer;
  Cell: TGpcPolygonClass;
  NewOutline: TGpcPolygonClass;
  APoint: TPoint2D;
begin
  InactiveCellCount := 0;
  ActiveCells.NumberOfContours := 0;
  Cell := TGpcPolygonClass.Create;
  try
    Cell.NumberOfContours := 1;
    Cell.VertexCount[0] := 4;
    ActiveDataArray := frmGoPhast.PhastModel.DataArrayManager.GetDataSetByName(rsActive);
    for RowIndex := 0 to ActiveDataArray.RowCount - 1 do
    begin
      for ColIndex := 0 to ActiveDataArray.ColumnCount - 1 do
      begin
        IsActive := False;
        for LayerIndex := 0 to ActiveDataArray.LayerCount - 1 do
        begin
          IsActive := ActiveDataArray.BooleanData[LayerIndex,RowIndex,ColIndex];
          if IsActive then
          begin
            break;
          end;
        end;
        APoint := FGrid.TwoDElementCorner(ColIndex, RowIndex);
        Cell.Vertices[0,0] := APoint;
        APoint := FGrid.TwoDElementCorner(ColIndex+1, RowIndex);
        Cell.Vertices[0,1] := APoint;
        APoint := FGrid.TwoDElementCorner(ColIndex+1, RowIndex+1);
        Cell.Vertices[0,2] := APoint;
        APoint := FGrid.TwoDElementCorner(ColIndex, RowIndex+1);
        Cell.Vertices[0,3] := APoint;
        if IsActive then
        begin
          NewOutline := TGpcPolygonClass.CreateFromOperation(
            GPC_UNION, Cell, ActiveCells);
          ActiveCells.Free;
          ActiveCells := NewOutline;
        end
        else
        begin
          NewOutline := TGpcPolygonClass.CreateFromOperation(
            GPC_UNION, Cell, InactiveCells);
          InactiveCells.Free;
          InactiveCells := NewOutline;
          Inc(InactiveCellCount);
        end;
      end;
    end;
  finally
    Cell.Free;
  end;
end;

procedure TfrmExportModelOutline.StoreAShape;
var
  PartIndex: Integer;
  AShape: TShapeObject;
  StartIndex: Integer;
  PointIndex: Integer;
  VertexIndex: Integer;
  APoint: TPoint2D;
  AShapePoint: TShapePoint;
begin
  AShape := TShapeObject.Create;
  AShape.FShapeType := stPolygon;
  AShape.FNumParts := FOutline.NumberOfContours;
  SetLength(AShape.FParts, AShape.FNumParts);
  AShape.FNumPoints := 0;
  StartIndex := 0;
  for PartIndex := 0 to FOutline.NumberOfContours - 1 do
  begin
    AShape.FParts[PartIndex] := StartIndex;
    AShape.FNumPoints := AShape.FNumPoints + FOutline.VertexCount[PartIndex]+1;
    StartIndex := AShape.FNumPoints;
  end;
  SetLength(AShape.FPoints, AShape.FNumPoints);
  PointIndex := 0;
  for PartIndex := 0 to FOutline.NumberOfContours - 1 do
  begin
    for VertexIndex := 0 to FOutline.VertexCount[PartIndex] - 1 do
    begin
      APoint := FOutline.Vertices[PartIndex,VertexIndex];
      AShapePoint.x := APoint.x;
      AShapePoint.y := APoint.y;
      AShape.FPoints[PointIndex] := AShapePoint;
      Inc(PointIndex);
    end;
    APoint := FOutline.Vertices[PartIndex,0];
    AShapePoint.x := APoint.x;
    AShapePoint.y := APoint.y;
    AShape.FPoints[PointIndex] := AShapePoint;
    Inc(PointIndex);
  end;
  FGeomWriter.AddShape(AShape);
end;

procedure TfrmExportModelOutline.AppendDataBaseRecord(Active: Boolean);
var
  Area: Double;
  ContourIndex: Integer;
begin
  Area := 0;
  for ContourIndex := 0 to FOutline.NumberOfContours - 1 do
  begin
    if FOutline.Holes[ContourIndex] then
    begin
      Area := Area - FOutline.ContourArea(ContourIndex);
    end
    else
    begin
      Area := Area + FOutline.ContourArea(ContourIndex);
    end;

  end;
  Area := Abs(Area);
  xbsShapeFile.AppendBlank;
  xbsShapeFile.UpdFieldNum(StrAREA, Area);
  if rgExportChoice.ItemIndex <> 0 then
  begin
    if Active then
    begin
      xbsShapeFile.UpdFieldInt(AnsiString(StrACTIVE), 1);
    end
    else
    begin
      xbsShapeFile.UpdFieldInt(AnsiString(StrACTIVE), 0);
    end;
  end;
  xbsShapeFile.PostChanges;
end;

procedure TfrmExportModelOutline.InitializeDataBase;
var
  FieldDefinitions: TStringList;
  DataBaseFileName: string;
begin
  DataBaseFileName := ChangeFileExt(sdShapefile.FileName, '.dbf');
  if FileExists(DataBaseFileName) then
  begin
    DeleteFile(DataBaseFileName);
  end;
  FieldDefinitions := TStringList.Create;
  try
    FieldDefinitions.Add(StrAREA + '=N18,10');

    if rgExportChoice.ItemIndex <> 0 then
    begin
      FieldDefinitions.Add(StrACTIVE + '=N');
    end;

    xbsShapeFile.DBFCreate(DataBaseFileName, FieldDefinitions);
  finally
    FieldDefinitions.Free;
  end;
  xbsShapeFile.FileName := DataBaseFileName;
  xbsShapeFile.Active := True;
  xbsShapeFile.GotoBOF;
end;

procedure TfrmExportModelOutline.FinalizeDataBase;
begin
  xbsShapeFile.Active := False;
end;

procedure TfrmExportModelOutline.InitializeGeometryWriter;
begin
  FGeomWriter := TShapefileGeometryWriter.Create(stPolygon, True);
end;

procedure TfrmExportModelOutline.FinalizeGeometryWriter;
begin
  //    AShape := TShapeObject.Create;
  //    AShape.FShapeType := stPolygon;
  //    AShape.FNumParts := FOutline.NumberOfContours;
  //    SetLength(AShape.FParts, AShape.FNumParts);
  //    AShape.FNumPoints := 0;
  //    StartIndex := 0;
  //    for PartIndex := 0 to FOutline.NumberOfContours - 1 do
  //    begin
  //      AShape.FParts[PartIndex] := StartIndex;
  //      AShape.FNumPoints := AShape.FNumPoints + FOutline.VertexCount[PartIndex]+1;
  //      StartIndex := AShape.FNumPoints;
  //    end;
  //    SetLength(AShape.FPoints, AShape.FNumPoints);
  //    PointIndex := 0;
  //    for PartIndex := 0 to FOutline.NumberOfContours - 1 do
  //    begin
  //      for VertexIndex := 0 to FOutline.VertexCount[PartIndex] - 1 do
  //      begin
  //        APoint := FOutline.Vertices[PartIndex,VertexIndex];
  //        AShapePoint.x := APoint.x;
  //        AShapePoint.y := APoint.y;
  //        AShape.FPoints[PointIndex] := AShapePoint;
  //        Inc(PointIndex);
  //      end;
  //      APoint := FOutline.Vertices[PartIndex,0];
  //      AShapePoint.x := APoint.x;
  //      AShapePoint.y := APoint.y;
  //      AShape.FPoints[PointIndex] := AShapePoint;
  //      Inc(PointIndex);
  //    end;
  //    GeomWriter.AddShape(AShape);
  FGeomWriter.WriteToFile(sdShapefile.FileName,
    ChangeFileExt(sdShapefile.FileName, '.shx'));
  FGeomWriter.Free;
end;

//procedure TfrmExportModelOutline.StoreGeometry;
//var
//  PartIndex: Integer;
//  AShape: TShapeObject;
//  GeomWriter: TShapefileGeometryWriter;
//  StartIndex: Integer;
//  PointIndex: Integer;
//  VertexIndex: Integer;
//  APoint: TPoint2D;
//  AShapePoint: TShapePoint;
//begin
//  InitializeGeometryWriter(GeomWriter);
//  try
//    StoreAShape(GeomWriter);
//  finally
//  FinalizeGeometryWriter(GeomWriter);
//  end;
//end;
//
//procedure TfrmExportModelOutline.StoreDataBase;
////var
//begin
//  InitializeDataBase;
//  try
//  AppendDataBaseRecord;
//  finally
//  FinalizeDataBase;
//  end;
//end;

procedure TfrmExportModelOutline.GetEntireGridOutline(var Polygon: TGpcPolygonClass);
var
  ColIndex: Integer;
  APoint: TPoint2D;
  RowIndex: Integer;
  PointList: TPointList;
  index: Integer;
begin
  PointList := TPointList.Create;
  try
    case FGrid.RowDirection of
      rdSouthToNorth:
        begin
          // PHAST
          for ColIndex := FGrid.ColumnCount downto 0 do
          begin
            APoint := FGrid.TwoDElementCorner(ColIndex, 0);
            PointList.Add(APoint);
          end;
          for RowIndex := FGrid.RowCount downto 1 do
          begin
            APoint := FGrid.TwoDElementCorner(FGrid.ColumnCount, RowIndex);
            PointList.Add(APoint);
          end;
          for ColIndex := 0 to FGrid.ColumnCount -1 do
          begin
            APoint := FGrid.TwoDElementCorner(ColIndex, FGrid.RowCount);
            PointList.Add(APoint);
          end;
          for RowIndex := 1 to FGrid.RowCount -1 do
          begin
            APoint := FGrid.TwoDElementCorner(0, RowIndex);
            PointList.Add(APoint);
          end;
        end;
      rdNorthToSouth:
        begin
          // MODFLOW
          for ColIndex := 0 to FGrid.ColumnCount do
          begin
            APoint := FGrid.TwoDElementCorner(ColIndex, 0);
            PointList.Add(APoint);
          end;
          for RowIndex := 1 to FGrid.RowCount do
          begin
            APoint := FGrid.TwoDElementCorner(FGrid.ColumnCount, RowIndex);
            PointList.Add(APoint);
          end;
          for ColIndex := FGrid.ColumnCount -1 downto 0 do
          begin
            APoint := FGrid.TwoDElementCorner(ColIndex, FGrid.RowCount);
            PointList.Add(APoint);
          end;
          for RowIndex := FGrid.RowCount -1 downto 1 do
          begin
            APoint := FGrid.TwoDElementCorner(0, RowIndex);
            PointList.Add(APoint);
          end;
        end;
    end;
    Polygon.NumberOfContours := 1;
    Polygon.VertexCount[0] := PointList.Count;
    for index := 0 to PointList.Count - 1 do
    begin
      Polygon.Vertices[0,index] := PointList[index];
    end;
  finally
    PointList.Free;
  end;

end;

procedure TfrmExportModelOutline.GetMeshOutline;
var
  Cell: TGpcPolygonClass;
  NewOutline: TGpcPolygonClass;
  APoint: TPoint2D;
  Mesh: TSutraMesh2D;
  ElementIndex: Integer;
  AnElement: TSutraElement2D;
  NodeIndex: Integer;
  ANode: TSutraNode2D;
begin
  Mesh := frmGoPhast.PhastModel.Mesh.Mesh2D;
  Assert(Mesh <> nil);
  FOutline.NumberOfContours := 0;
  Cell := TGpcPolygonClass.Create;
  try
    Cell.NumberOfContours := 1;
    Cell.VertexCount[0] := 4;
    for ElementIndex := 0 to Mesh.Elements.Count - 1 do
    begin
      AnElement := Mesh.Elements[ElementIndex];
      for NodeIndex := 0 to AnElement.Nodes.Count - 1 do
      begin
        ANode := AnElement.Nodes[NodeIndex].Node;
        APoint := ANode.Location;
        Cell.Vertices[0,NodeIndex] := APoint;
      end;
      NewOutline := TGpcPolygonClass.CreateFromOperation(
        GPC_UNION, Cell, FOutline);
      FOutline.Free;
      FOutline := NewOutline;
    end;
  finally
    Cell.Free;
  end;
end;

procedure TfrmExportModelOutline.SetData;
var
  Dummy: integer;
//  GeomWriter: TShapefileGeometryWriter;
  InactiveCells: TGpcPolygonClass;
begin
  InitializeDataBase;
  InitializeGeometryWriter;
  try
    FGrid := frmGoPhast.Grid;
    if FGrid <> nil then
    begin
      case TExportChoice(rgExportChoice.ItemIndex) of
        ecEntireGrid:
          begin
            GetEntireGridOutline(FOutline);
            StoreAShape;
            AppendDataBaseRecord(False);
          end;
        ecActiveCells:
          begin
            Dummy := 0;
            InactiveCells := TGpcPolygonClass.Create;
            try
              GetActiveGridOutline(FOutline, InactiveCells, Dummy);
            finally
              InactiveCells.Free;
            end;
            StoreAShape;
            AppendDataBaseRecord(True);
          end;
        acActiveAndInactive:
          begin
            GetActiveAndInactiveGrid;
          end;
      end;
    end
    else
    begin
      GetMeshOutline;
      StoreAShape;
      AppendDataBaseRecord(True);
    end;
  finally
    FinalizeGeometryWriter;
    FinalizeDataBase;
  end;
end;

end.
