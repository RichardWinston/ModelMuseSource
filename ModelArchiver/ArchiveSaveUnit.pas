unit ArchiveSaveUnit;

interface

uses
  System.Classes, System.SysUtils, System.Zip, System.Generics.Collections,
  ArchiveNodeInterface, System.Types;

type
  TActivity = (aSaveArchive, aSaveDescriptions, aMove);
  TDescriptionWriting = (dwAll, dwModel);

  TProgressEvent = Procedure (Sender: TObject; Fraction: double) of object;

  EArchiveException = class(Exception);

  TArchiveSaver = class(TObject)
  private
    const
    Indent = '    ';
    var
    FOnProgress: TProgressEvent;
    FZipFile: TZipFile;
    FCurrentZipFile: TZipFile;
    FRootNodes: TArchiveNodeList;
    FBaseNode: IArchiveNodeInterface;
    FDescriptions: TStringList;
    FCurrentDescriptions: TStringList;
    FActivity: TActivity;
    FMaxProgress: double;
    FProgress: double;
    FBigFiles: TStringList;
    FRootZipFileName: string;
    FDiskFileName: string;
    FRootDirectory: string;
    FWhatToWrite: TDescriptionWriting;
    procedure HandleNode(Node: IArchiveNodeInterface; Prefix: string);
    procedure ArchiveNode(Node: IArchiveNodeInterface; Prefix: string);
    function GetArchivePath(Node: IArchiveNodeInterface): string;
    procedure WriteDescription(Prefix, Text: string; MaxLineLength: integer);
    procedure CalculateMaxProgress;
    procedure CountNodeProgress(Node: IArchiveNodeInterface);
    procedure DoOnProgress(Node: IArchiveNodeInterface);
    function GetFileSize(FileName: string): Int64;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveArchive(ZipFileName: string);
    procedure MoveFilesToArchive(DirectoryName: string);
    procedure WriteFileDescriptions(TextFileName: string;
      WhatToWrite: TDescriptionWriting);
    property RootNodes: TArchiveNodeList read FRootNodes write FRootNodes;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property SkippedFiles: TStringList read FBigFiles;
  end;

implementation

uses
  System.IOUtils;

var FourGigaBytes: Int64;

{ TArchiveSaver }

procedure TArchiveSaver.CalculateMaxProgress;
var
  NodeIndex: Integer;
  ANode: IArchiveNodeInterface;
begin
  FMaxProgress := 0;
  for NodeIndex   := 0 to RootNodes.Count - 1 do
  begin
    ANode := RootNodes[NodeIndex] ;
    CountNodeProgress(ANode);
  end;
end;

procedure TArchiveSaver.CountNodeProgress(Node: IArchiveNodeInterface);
var
  FileName: string;
  ChildIndex: Integer;
//  AFileSize: Int64;
begin
  case FActivity of
    aSaveArchive, aMove:
      begin
        if Node.NodeType = ntFile then
        begin
          FileName := Node.NodeText;
          FMaxProgress := FMaxProgress + GetFileSize(FileName);
        end;
      end;
    aSaveDescriptions:
      begin
        FMaxProgress := FMaxProgress + 1;
      end;
    else
      Assert(False);
  end;
  for ChildIndex := 0 to Node.Count - 1 do
  begin
    CountNodeProgress(Node.Children[ChildIndex]);
  end;
end;

constructor TArchiveSaver.Create;
begin
  FBigFiles := TStringList.Create;
end;

destructor TArchiveSaver.Destroy;
begin
  FBigFiles.Free;
  inherited;
end;

procedure TArchiveSaver.DoOnProgress(Node: IArchiveNodeInterface);
var
  FileName: string;
begin
  if Assigned(FOnProgress) and (FMaxProgress <> 0) then
  begin
    case FActivity of
      aSaveArchive, aMove:
        begin
          if Node.NodeType = ntFile then
          begin
            FileName := Node.NodeText;
            FProgress := FProgress + GetFileSize(FileName);
          end;
        end;
      aSaveDescriptions:
        begin
          FProgress := FProgress + 1;
        end;
      else
        Assert(False);
    end;
    FOnProgress(self, FProgress/FMaxProgress);
  end;
end;

function TArchiveSaver.GetArchivePath(Node: IArchiveNodeInterface): string;
var
  ParentNode: IArchiveNodeInterface;
  function ContinuePath: boolean;
  begin
    result := ParentNode <> nil;
    if result then
    begin
      if FActivity = aSaveArchive then
      begin
        result := (ParentNode <> FBaseNode)
          and (ParentNode.NodeType <> ntArchiveRoot);
      end
      else
      begin
        result := (ParentNode.NodeType <> ntArchiveRoot);
      end;
    end;
  end;
begin
  result := '';
  ParentNode := Node.ParentNode;
  while ContinuePath do
  begin
    if result = '' then
    begin
      result := ParentNode.NodeText;
    end
    else
    begin
      result := ParentNode.NodeText + '\' + result;
    end;
    ParentNode := ParentNode.ParentNode;
  end;
end;

procedure TArchiveSaver.HandleNode(Node: IArchiveNodeInterface; Prefix: string);
var
  ChildIndex: Integer;
  ChildNode: IArchiveNodeInterface;
  LocalZipFile: TZipFile;
  ArchiveFileName: string;
  DiskFileName: string;
  FileStream: TFileStream;
  CategoryNode: IArchiveNodeInterface;
  EmptyData: TBytes;
  LocalDescriptions: TStringList;
begin
  if Node.NodeType = ntFile then
  begin
    ArchiveNode(Node, Prefix);
  end
  else
  begin
    LocalZipFile := nil;
    ArchiveFileName := '';
    if (Node.Count > 0)
      and (Node.NodeType in [ntModel, ntCategoryCompressed]) then
    begin
      case FActivity of
        aSaveArchive:
          begin
            LocalZipFile := TZipFile.Create;
            FCurrentZipFile := LocalZipFile;
          end;
        aSaveDescriptions:
          begin
            LocalDescriptions := TStringList.Create;
            FCurrentDescriptions := LocalDescriptions;
          end;
        aMove: ; // do nothing
        else
          Assert(False);
      end;

      if Node.NodeType in [ntModel, ntFolder] then
      begin
        CategoryNode := Node.ParentNode;
      end
      else
      begin
        CategoryNode := Node;
      end;

      ArchiveFileName := IncludeTrailingPathDelimiter(GetArchivePath(Node))
        +  IncludeTrailingPathDelimiter(Node.NodeText) ;
      case FActivity of
        aSaveArchive:
          begin
            if CategoryNode.NodeText = StrModelOutputFiles then
            begin
              SetLength(EmptyData, 0);
              FZipFile.Add(EmptyData, ArchiveFileName);
            end;
          end;
        aSaveDescriptions:
          begin
            if (FWhatToWrite = dwAll) or (Node.NodeType = ntModel) then
            begin

              FCurrentDescriptions.Add('');
              if FWhatToWrite = dwAll then
              begin
                FCurrentDescriptions.Add(Prefix + ArchiveFileName);
                FCurrentDescriptions.Add(Prefix + Indent + 'Description:');
                FCurrentDescriptions.Add(Prefix + Indent + '-----------');
              end
              else
              begin
                FCurrentDescriptions.Add(Prefix + Node.NodeText);
                FCurrentDescriptions.Add(Prefix + Indent + '-----------');
              end;
              WriteDescription(Prefix + Indent, Node.Description, 80);
              if (FWhatToWrite = dwAll) and (Node.Count > 0)
                and (Node.Children[0].NodeType = ntFile) then
              begin
                FCurrentDescriptions.Add('');
                FCurrentDescriptions.Add(Prefix + Indent + 'Files:');
                FCurrentDescriptions.Add(Prefix + Indent + '-----');
              end;
            end;
          end;
        aMove: ; // do nothing
        else
          Assert(False);
      end;
      ArchiveFileName := IncludeTrailingPathDelimiter(GetArchivePath(Node)) + Node.NodeText +  '.zip';

      if FActivity = aSaveArchive then
      begin
        DiskFileName := TPath.GetTempFileName;
        LocalZipFile.Open(DiskFileName, zmWrite);
        FDiskFileName := ArchiveFileName;
      end
      else
      begin
        FDiskFileName := FRootZipFileName;
      end;
      FBaseNode := Node;
    end
    else
    begin
      LocalZipFile := nil;
      LocalDescriptions := nil;
      FDiskFileName := FRootZipFileName;
    end;
    try
      for ChildIndex := 0 to Node.Count - 1 do
      begin
        ChildNode := Node.Children[ChildIndex];
        HandleNode(ChildNode, Prefix + Indent);
      end;
    finally
      case FActivity of
        aSaveArchive:
          begin
            if LocalZipFile <> nil then
            begin
              try
                LocalZipFile.Close;
                LocalZipFile.Free;
                FCurrentZipFile := FZipFile;
                FileStream := TFile.OpenRead(DiskFileName);
                try
                  if Assigned(FOnProgress) then
                  begin
                    FMaxProgress := FMaxProgress + FileStream.Size;
//                    FOnProgress(self, FProgress/FMaxProgress);
                  end;
                  if FileStream.Size >= FourGigaBytes then
                  begin
                    raise EArchiveException.Create(Format(
                      'Error creating %s. File is greater than four gigabytes in size',
                      [ArchiveFileName]));
                  end
                  else
                  begin
                    FZipFile.Add(FileStream, ArchiveFileName);
                  end;
                  if Assigned(FOnProgress) then
                  begin
                    FProgress := FProgress + FileStream.Size;
                    FOnProgress(self, FProgress/FMaxProgress);
                  end;
                finally
                  FileStream.Free;
                end;
              finally
                TFile.Delete(DiskFileName);
              end;
              FBaseNode := nil;
            end;
          end;
        aSaveDescriptions:
          begin
            if LocalDescriptions <> nil then
            begin
              FCurrentDescriptions := FDescriptions;
              FDescriptions.AddStrings(LocalDescriptions);
              FreeAndNil(LocalDescriptions);
            end;
          end;
        aMove: ; // do nothing
        else
          Assert(False);
      end;
    end;
  end;
  DoOnProgress(Node);
end;

procedure TArchiveSaver.MoveFilesToArchive(DirectoryName: string);
var
  NodeIndex: Integer;
  ANode: IArchiveNodeInterface;
  CurDir: string;
  FreeSpace: Int64;
begin
  FActivity := aMove;
  FRootDirectory := IncludeTrailingPathDelimiter(DirectoryName);
  TDirectory.GetFiles(FRootDirectory);
  if not TDirectory.IsEmpty(FRootDirectory) then
  begin
    raise EArchiveException.Create('The archive directory must be empty');
  end;
  CalculateMaxProgress;
  if Assigned (FOnProgress) then
  begin
    FProgress := 0
  end;
  CurDir := GetCurrentDir;
  try
    SetCurrentDir(DirectoryName);
    FreeSpace := DiskFree(0);
    if FreeSpace < FMaxProgress then
    begin
      raise EArchiveException.Create(Format(
        'Not enough free disk space. Required disk space = %d',
        [FMaxProgress]));
    end;
  finally
    SetCurrentDir(CurDir);
  end;
  for NodeIndex   := 0 to RootNodes.Count - 1 do
  begin
    ANode := RootNodes[NodeIndex] ;
    HandleNode(ANode, Indent);
  end;
end;

procedure TArchiveSaver.ArchiveNode(Node: IArchiveNodeInterface; Prefix: string);
var
  FullPath: string;
  ArchivePath: string;
  FileStream: TFileStream;
  ArchiveFileName: string;
  ArchiveDirectory: string;
begin
  ArchivePath := GetArchivePath(Node);
  if ArchivePath <> '' then
  begin
    ArchivePath := IncludeTrailingPathDelimiter(ArchivePath);
  end;
  FullPath := Node.NodeText;
  if TFile.Exists(FullPath) then
  begin
    if Pos(Node.ModelDirectory, FullPath) = 1 then
    begin
      ArchivePath := ArchivePath
        + ExtractRelativePath(Node.ModelDirectory, FullPath)
    end
    else
    begin
      ArchivePath := ArchivePath + ExtractFileName(FullPath);
    end;

    if ExtractFileExt(ArchivePath) = ArchiveExt then
    begin
      ArchivePath := ChangeFileExt(ArchivePath, '');
    end;

    case FActivity of
      aSaveArchive:
        begin
          FileStream := TFile.OpenRead(FullPath);
          try
            if FileStream.Size >= FourGigabytes then
            begin
//              FBigFiles.Add(Format('"%0:s" "%1:s"', [FullPath, ArchivePath]))
              FBigFiles.Add(Format('"%0:s" "%1:s" in "%2:s"', [FullPath, ArchivePath, FDiskFileName]));
            end
            else
            begin
              FCurrentZipFile.Add(FileStream, ArchivePath);
            end;
          finally
            FileStream.Free;
          end;
        end;
      aSaveDescriptions:
        begin
          if FWhatToWrite = dwAll then
          begin
            WriteDescription(Prefix, ArchivePath + ':', 80);
            WriteDescription(Prefix + Indent, Node.Description, 80);
            FCurrentDescriptions.Add('');
          end;
//          FCurrentDescriptions.Add(Prefix + ArchivePath + ': ' + Node.Description)
        end;
      aMove:
        begin
          // copy file
          ArchiveFileName := FRootDirectory + ArchivePath;
          ArchiveDirectory := ExtractFileDir(ArchiveFileName);
          if not TDirectory.Exists(ArchiveDirectory) then
          begin
            TDirectory.CreateDirectory(ArchiveDirectory);
          end;
          if TFile.Exists(ArchiveFileName) then
          begin
            raise EArchiveException.Create(Format(
              'Cannot move %0:s to %1:s because a file by that name is already exists in that location',
              [FullPath, ArchiveFileName]));
          end;
          TFile.Copy(FullPath, ArchiveFileName);
        end
      else
        Assert(False);

    end;
  end
  else
  begin

    raise EArchiveError.Create(Format(
      'The file %0:s under %1:s does not exist', [FullPath, ArchivePath]));
  end;
end;


procedure TArchiveSaver.SaveArchive(ZipFileName: string);
var
  NodeIndex: Integer;
  ANode: IArchiveNodeInterface;
begin
  FBigFiles.Clear;
  FActivity := aSaveArchive;
  if Assigned (FOnProgress) then
  begin
    CalculateMaxProgress;
    FProgress := 0
  end;
  FZipFile := TZipFile.Create;
  try
    FCurrentZipFile := FZipFile;
    FRootZipFileName := ZipFileName;
    FZipFile.Open(ZipFileName, zmWrite);
    try
      for NodeIndex   := 0 to RootNodes.Count - 1 do
      begin
        ANode := RootNodes[NodeIndex] ;
        HandleNode(ANode, Indent);
      end;
    finally
      FZipFile.Close;
    end;
  finally
    FreeAndNil(FZipFile);
  end;
end;

procedure TArchiveSaver.WriteDescription(Prefix, Text: string;
  MaxLineLength: integer);
var
  IntList: TList<Integer>;
  CharIndex: Integer;
  StartIndex: Integer;
  PrefixLength: Integer;
  TextToWrite: string;
  Lines: TStringList;
  LineIndex: Integer;
begin
  Lines := TStringList.Create;
  IntList := TList<Integer>.Create;
  try
    Lines.Text := Text;
    for LineIndex := 0 to Lines.Count - 1 do
    begin
      Text := Lines[LineIndex];
      IntList.Clear;
      for CharIndex := 1 to Length(Text) do
      begin
        if Text[CharIndex] = ' ' then
        begin
          IntList.Add(CharIndex)
        end;
      end;
      IntList.Add(Length(Text)+1);
      StartIndex := 1;
      PrefixLength := Length(Prefix);
      for CharIndex := 1 to IntList.Count - 1 do
      begin
        if PrefixLength + IntList[CharIndex] - StartIndex > MaxLineLength then
        begin
          TextToWrite := Copy(Text, StartIndex, IntList[CharIndex-1]-StartIndex);
          FCurrentDescriptions.Add(Prefix + TextToWrite);
          StartIndex := IntList[CharIndex-1]+1;
        end;
      end;
      TextToWrite := Copy(Text, StartIndex, MaxInt);
      FCurrentDescriptions.Add(Prefix + TextToWrite);
    end;
//    FCurrentDescriptions.Add('');
  finally
    IntList.Free;
    Lines.Free;
  end;
end;

procedure TArchiveSaver.WriteFileDescriptions(TextFileName: string;
  WhatToWrite: TDescriptionWriting);
var
  NodeIndex: Integer;
  ANode: IArchiveNodeInterface;
begin
  FActivity := aSaveDescriptions;
  FWhatToWrite := WhatToWrite;
  if Assigned (FOnProgress) then
  begin
    CalculateMaxProgress;
    FProgress := 0;
  end;
  FDescriptions := TStringList.Create;
  try
    FCurrentDescriptions := FDescriptions;

    FDescriptions.Add(Indent + 'Files:');
    FDescriptions.Add(Indent + '-----');

    for NodeIndex   := 0 to RootNodes.Count - 1 do
    begin
      ANode := RootNodes[NodeIndex] ;
      HandleNode(ANode, Indent);
    end;
    FDescriptions.SaveToFile(TextFileName);
  finally
    FreeAndNil(FDescriptions);
  end;
end;

function TArchiveSaver.GetFileSize(FileName: string): Int64;
var
  FileStream: TFileStream;
begin
  if TFile.Exists(FileName) then
  begin
    FileStream := TFile.OpenRead(FileName);
    try
      result := FileStream.Size;
    finally
      FileStream.Free;
    end;
  end
  else
  begin
    result := 0;
  end;
end;

initialization
 FourGigaBytes := 1024*1024;
 FourGigaBytes := FourGigaBytes*1024*4;

end.
