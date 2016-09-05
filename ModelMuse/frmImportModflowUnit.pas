unit frmImportModflowUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCustomGoPhastUnit, StdCtrls, Buttons, Mask, JvExMask, JvToolEdit,
  ArgusDataEntry, ComCtrls;

type
  TfrmImportModflow = class(TfrmCustomGoPhast)
    rdeX: TRbwDataEntry;
    Label1: TLabel;
    Label2: TLabel;
    rdeY: TRbwDataEntry;
    Label3: TLabel;
    rdeGridAngle: TRbwDataEntry;
    Label4: TLabel;
    edNameFile: TJvFilenameEdit;
    btnHelp: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lblWarning: TLabel;
    sbStatusBar: TStatusBar;
    pbProgress: TProgressBar;
    cbOldStream: TCheckBox;
    comboGridOrigin: TComboBox;
    lblGridOrigin: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure edNameFileChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
  private
    FReadModflowInputProperly: Boolean;
    FConsoleLines: TStringList;
    procedure HandleModflowConsolLine(const Text: string);
    procedure UpdateStatusBar(const Text: string);
    procedure ShowProgress(Position, Total: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses JclSysUtils, Modflow2005ImporterUnit, frmShowHideObjectsUnit,
  frmDisplayDataUnit, ModelMuseUtilities, StrUtils, frmConsoleLinesUnit,
  Generics.Collections, System.SysConst;

resourcestring
  StrTheMODFLOWNameFil = 'The MODFLOW Name file appears to be invalid';
  StrSWasNotFound = '%s was not found.';
  StrNoLISTFileWasFou = 'No LIST file was found in the MODFLOW Name file.';
  StrThereWasAnErrorR = 'There was an error reading the MODFLOW input files.' +
  '  Check the console lines below and %s for error messages.';
  StrTheListingFile = 'The listing file, "%s", was not found.';
  StrTheNameOfTheMODF = 'The name of the MODFLOW Name file can not contain a' +
  'ny spaces.';
  StrReadingStressPerio = 'Reading Stress Period %s';
  StrAbortingModelMuse = 'Aborting.  ModelMuse was unable to create %0:s. Pl' +
  'ease correct this problem. The error message was %1:s.';
  StrADirectoryListedI = 'A directory listed in the name file "%s" does not ' +
  'exist and could not be created.';
  StrUnableToSaveTempo = 'Unable to save temporaray name file: %s';
  StrTheSolverPackages = 'The solver packages can not be imported in MODFLOW' +
  '-2000 models.';

{$IF CompilerVersion < 24}
// This is a workaround for a bug in SysUtils.DirectoryExists
// In Delphi XE2. If fixed in the version of Delphi used to compile
// this unit, this function may be removed.
function DirectoryExists(Directory: string): Boolean;
var
  Code: Cardinal;
  LastError: Cardinal;
begin
  Code := GetFileAttributes(PChar(Directory));

  if Code <> INVALID_FILE_ATTRIBUTES then
  begin
    result := SysUtils.DirectoryExists(Directory)
  end
  else
  begin
    LastError := GetLastError;
    Result := (LastError <> ERROR_FILE_NOT_FOUND) and
      (LastError <> ERROR_PATH_NOT_FOUND) and
      (LastError <> ERROR_INVALID_NAME) and
      (LastError <> ERROR_BAD_NETPATH) and
      (LastError <> ERROR_NOT_READY);
  end;
end;

// This is a workaround for a bug in Delphi XE2.
// If fixed in the version of Delphi used to compile
// this unit, this function may be removed.
function ForceDirectories(Dir: string): Boolean;
var
  E: EInOutError;
begin
  Result := True;
  if Dir = '' then
  begin
    E := EInOutError.CreateRes(@SCannotCreateDir);
    E.ErrorCode := 3;
    raise E;
  end;
  Dir := ExcludeTrailingPathDelimiter(Dir);
{$IFDEF MSWINDOWS}
  if (Length(Dir) < 3) or DirectoryExists(Dir)
    or (ExtractFilePath(Dir) = Dir) then Exit; // avoid 'xyz:\' problem.
{$ENDIF}
{$IFDEF POSIX}
  if (Dir = '') or DirectoryExists(Dir) then Exit;
{$ENDIF POSIX}
  Result := ForceDirectories(ExtractFilePath(Dir)) and CreateDir(Dir);
end;
{$IFEND}


procedure TfrmImportModflow.btnOKClick(Sender: TObject);
var
  ModflowImporterName: string;
  NameFile: TStringList;
  Index: Integer;
  ALine: string;
  LineContents: TStringList;
  ListFileName: string;
  CurrentDir: string;
  XOrigin: double;
  YOrigin: double;
  GridAngle: double;
  OldFile: string;
  LineIndex: Integer;
  Splitter: TStringList;
  Ftype: string;
  Nunit: Integer;
  BadUnitNumberLine: Integer;
  UnitNumbers: TList<Integer>;
  Fname: string;
  FullFileName: string;
  FileDir: string;
  UnitNumberIndex: Integer;
  NameFileName: string;
  Modflow2000Model: Boolean;
  ImportParameters: TImportParameters;
//  DelimPos: Integer;
begin
  inherited;
  Enabled := False;
  CurrentDir := GetCurrentDir;
  try
    ModflowImporterName := ExtractFileDir(Application.ExeName)
      + '\' + 'MF2005_Importer.exe';
    if not FileExists(ModflowImporterName) then
    begin
      Beep;
      MessageDlg(Format(StrSWasNotFound, [ModflowImporterName]), mtError, [mbOK], 0);
      Exit;
    end;

    NameFileName := edNameFile.FileName;
    SetCurrentDir(ExtractFileDir(edNameFile.FileName));


    BadUnitNumberLine := -1;
    NameFile := TStringList.Create;
    Splitter := TStringList.Create;
    UnitNumbers := TList<Integer>.Create;
    try
      Splitter.Delimiter := ' ';
      NameFile.LoadFromFile(NameFileName);
      Modflow2000Model := False;
      for LineIndex := 0 to NameFile.Count - 1 do
      begin
        ALine := NameFile[LineIndex];
        if (Length(ALine) > 0) and (ALine[1] <> '#') then
        begin
          if Pos('"', ALine) >= 1 then
          begin
            Splitter.QuoteChar := '"';
          end
          else if Pos('''', ALine) >= 1 then
          begin
            Splitter.QuoteChar := '''';
          end;
          Splitter.DelimitedText := ALine;
          if Splitter.Count > 0 then
          begin
            Ftype := UpperCase(Splitter[0]);
            if (Ftype = 'GLOBAL')
               or (Ftype = 'BTN') or (Ftype = 'ADV') or (Ftype = 'DSP')
               or (Ftype = 'GCG') or (Ftype = 'VDF') or (Ftype = 'SSM')
               or (Ftype = 'RCT') or (Ftype = 'SOR') or (Ftype = 'SEN')
               or (Ftype = 'PES') or (Ftype = 'OBS') or (Ftype = 'LMG')
               or (Ftype = 'DAF') or (Ftype = 'DAFG') or (Ftype = 'VSC')
               or (Ftype = 'DTOB') or (Ftype = 'ADV2') or (Ftype = 'GWT')
               then
            begin
              Modflow2000Model := True;
            end;
          end;
        end;
      end;
      for LineIndex := 0 to NameFile.Count - 1 do
      begin
        ALine := NameFile[LineIndex];
        if (Length(ALine) > 0) and (ALine[1] <> '#') then
        begin
          if Pos('"', ALine) >= 1 then
          begin
            Splitter.QuoteChar := '"';
          end
          else if Pos('''', ALine) >= 1 then
          begin
            Splitter.QuoteChar := '''';
          end;
          Splitter.DelimitedText := ALine;
          if Splitter.Count > 0 then
          begin
            Ftype := UpperCase(Splitter[0]);
            // comment out MODFLOW-2000 files or other unhandled file types.
            if (Ftype = 'OBS') or (Ftype = 'LMG') or (Ftype = 'SEN')
               or (Ftype = 'SEN') or (Ftype = 'PES') or (Ftype = 'GLOBAL')
               or (Ftype = 'SOR') or (Ftype = 'DAF') or (Ftype = 'DAFG')
               or (Ftype = 'DTOB') or (Ftype = 'ADV2')
               or (Ftype = 'BTN') or (Ftype = 'ADV') or (Ftype = 'DSP')
               or (Ftype = 'GCG') or (Ftype = 'VDF') or (Ftype = 'SSM')
               or (Ftype = 'RCT') or (Ftype = 'VSC')
               or (Ftype = 'CFP') or (Ftype = 'CRCH') or (Ftype = 'COC')
               or (Ftype = 'BFH') or (Ftype = 'BFH2') or (Ftype = 'RIP')
               or (Ftype = 'FMP')
               // CLB, NDC, and WHS are only in Visual MODFLOW.
               or (Ftype = 'CLB') or (Ftype = 'NDC') or (Ftype = 'WHS')
               or (Ftype = 'GWT') then
            begin
              ALine := '#' + ALine;
              NameFile[LineIndex] := ALine;
            end
            else if Modflow2000Model and
              ((Ftype = 'DE4') or (Ftype = 'GMG') or (Ftype = 'LMG')
              or (Ftype = 'PCG') or (Ftype = 'PCGN') or (Ftype = 'SIP')
               or (Ftype = 'SOR')) then
            begin
              ALine := '#' + ALine;
              NameFile[LineIndex] := ALine;
              Beep;
              MessageDlg(StrTheSolverPackages, mtInformation, [mbOK], 0);
            end
            else if Splitter.Count > 2 then
            begin
              if (Ftype = 'DATAGLO(BINARY)') then
              begin
                Splitter[0] := 'DATA(BINARY)';
                NameFile[LineIndex] := Splitter.DelimitedText;
              end
              else if (Ftype = 'DATAGLO') then
              begin
                Splitter[0] := 'DATA';
                NameFile[LineIndex] := Splitter.DelimitedText;
              end;

              if TryStrToInt(Splitter[1], Nunit) then
              begin
                if Nunit = 6 then
                begin
                  BadUnitNumberLine := LineIndex;
                end
                else
                begin
                  UnitNumbers.Add(Nunit);
                end;
                Fname := Splitter[2];
                FullFileName := ExpandFileName(Fname);
                FileDir := ExtractFileDir(FullFileName);
                if not DirectoryExists(FileDir) then
                begin
                  if not ForceDirectories(FileDir) then
                  begin
                    Beep;
                    MessageDlg(Format(StrADirectoryListedI, [FileDir]),
                      mtError, [mbOK], 0);
                    Exit;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
      if BadUnitNumberLine >= 0 then
      begin
        Splitter.DelimitedText := NameFile[BadUnitNumberLine];
        for UnitNumberIndex := 7 to MAXINT do
        begin
          if UnitNumbers.IndexOf(UnitNumberIndex) < 0 then
          begin
            Splitter[1] := IntToStr(UnitNumberIndex);
            Break;
          end;
        end;
        NameFile[BadUnitNumberLine] := Splitter.DelimitedText;
      end;
      NameFileName := IncludeTrailingPathDelimiter(ExtractFileDir(edNameFile.FileName))
        + 'TempNameFile.nam';
        try
          NameFile.SaveToFile(NameFileName);
        except  on EFCreateError do
          begin
            Beep;
            MessageDlg(Format(StrUnableToSaveTempo, [NameFileName]), mtError, [mbOK], 0);
          end;

        end;
    finally
      NameFile.Free;
      Splitter.Free;
      UnitNumbers.Free;
    end;

//    if Pos(' ', ExtractFileName(edNameFile.FileName)) > 0 then
//    begin
//      Beep;
//      MessageDlg(StrTheNameOfTheMODF, mtError, [mbOK], 0);
//      Exit;
//    end;

    XOrigin := StrToFloat(rdeX.Text);
    YOrigin := StrToFloat(rdeY.Text);
    GridAngle := StrToFloat(rdeGridAngle.Text) * Pi/180;

    try
      OldFile := ExtractFileDir(NameFileName) + '\old.txt';
      if cbOldStream.Checked then
      begin
        With TStringList.Create do
        begin
          SaveToFile(OldFile);
          Free;
        end;
      end
      else
      begin
        DeleteFile(OldFile);
      end;
    except on E: EFCreateError do
      begin
        Beep;
        MessageDlg(Format(StrAbortingModelMuse, [OldFile, E.Message]), mtError, [mbOK], 0);
        ModalResult := mrNone;
        Exit;
      end;
    end;

    ListFileName := '';
    NameFile := TStringList.Create;
    LineContents := TStringList.Create;
    try
      LineContents.Delimiter := ' ';
      try
        NameFile.LoadFromFile(NameFileName);
      except on EFOpenError do
        begin
          CantOpenFileMessage(NameFileName);
          Exit;
        end;
      end;
      for Index := 0 to NameFile.Count - 1 do
      begin
        ALine := NameFile[Index];
        if (Length(ALine) > 0) and (ALine[1] <> '#') then
        begin
          LineContents.DelimitedText := UpperCase(ALine);
          if LineContents.Count = 0 then
          begin
            Beep;
            MessageDlg(StrTheMODFLOWNameFil, mtError, [mbOK], 0);
            Exit;
          end;
          if Trim(LineContents[0]) = 'LIST' then
          begin
            LineContents.DelimitedText := ALine;
            if LineContents.Count < 3 then
            begin
              Beep;
              MessageDlg(StrTheMODFLOWNameFil, mtError, [mbOK], 0);
              Exit;
            end;
            ListFileName := LineContents[2];
            break;
          end;
        end;
      end;
    finally
      NameFile.Free;
      LineContents.Free;
    end;
    if ListFileName = '' then
    begin
      Beep;
      MessageDlg(StrNoLISTFileWasFou, mtError, [mbOK], 0);
      Exit;
    end;
    SetCurrentDir(ExtractFileDir(NameFileName));
//    if Copy(ListFileName,1,2) = '.\' then
//    begin
//      DelimPos := PosEx(PathDelim,ListFileName,3);
//      if DelimPos > 0 then
//      begin
//        ListFileName := Copy(ListFileName,DelimPos+1,MaxInt);
//      end;
//
//    end;
    ListFileName := ExpandFileName(ListFileName);

    FReadModflowInputProperly := False;
    Execute('"' + ModflowImporterName + '" '
      + ExtractFileName(NameFileName), HandleModflowConsolLine);
    if not FReadModflowInputProperly then
    begin
      Beep;
      frmConsoleLines := TfrmConsoleLines.Create(nil);
      try
        frmConsoleLines.lblMessage.Caption :=
          Format(StrThereWasAnErrorR, [ListFileName]);
        frmConsoleLines.memoConsoleLines.Lines := FConsoleLines;
        frmConsoleLines.ShowModal;
      finally
        frmConsoleLines.Free;
      end;
//      MessageDlg(Format(StrThereWasAnErrorR, [ListFileName]),
//        mtError, [mbOK], 0);
      Exit;
    end;
    if not FileExists(ListFileName) then
    begin
      Beep;
      MessageDlg(Format(StrTheListingFile, [ListFileName]),
        mtError, [mbOK], 0);
      Exit;
    end;
    sbStatusBar.SimpleText := '';
    FreeAndNil(frmShowHideObjects);
    FreeAndNil(frmDisplayData);
    ImportParameters.ListFileName := ListFileName;
    ImportParameters.XOrigin := XOrigin;
    ImportParameters.YOrigin := YOrigin;
    ImportParameters.GridAngle := GridAngle;
    ImportParameters.textHandler := UpdateStatusBar;
    ImportParameters.ProgressHandler := ShowProgress;
    ImportParameters.ModelType := mtParent;
    ImportParameters.NameFile := NameFileName;
    ImportParameters.GridOrigin := TGridOrigin(comboGridOrigin.ItemIndex);
    ImportModflow2005(ImportParameters);
//    ImportModflow2005(ListFileName, XOrigin, YOrigin, GridAngle,
//      UpdateStatusBar, ShowProgress, mtParent, NameFileName);
    DeleteFile(NameFileName);
    if FileExists(OldFile) then
    begin
      DeleteFile(OldFile);
    end;
  finally
    SetCurrentDir(CurrentDir);
    Enabled := True;
  end;
end;
procedure TfrmImportModflow.edNameFileChange(Sender: TObject);
begin
  inherited;
  btnOK.Enabled := FileExists(edNameFile.FileName);
end;

procedure TfrmImportModflow.FormCreate(Sender: TObject);
begin
  inherited;
  FConsoleLines := TStringList.Create;
end;

procedure TfrmImportModflow.FormDestroy(Sender: TObject);
begin
  inherited;
  FConsoleLines.Free;
end;

procedure TfrmImportModflow.FormShow(Sender: TObject);
begin
  inherited;
  SetAppearance;
  lblWarning.Width := Width - 16;
  lblWarning.Font.Style := [fsBold];
end;

procedure TfrmImportModflow.HandleModflowConsolLine(const Text: string);
const
  Normal = 'Normal termination of simulation';
  SP = 'Solving:  Stress period:';
  TS = 'Time step:';
var
  SpPos: Integer;
  TsPos: Integer;
  StressPeriod: string;
  SPStart: integer;
begin
  FConsoleLines.Add(Text);
  SpPos := Pos(SP, Text);
  TsPos := Pos(TS, Text);
  if (SpPos > 0) and (TsPos > 0) then
  begin
    SPStart := SpPos + Length(SP);
    StressPeriod := Trim(Copy(Text, SPStart, TsPos-SPStart));
    sbStatusBar.SimpleText := Format(StrReadingStressPerio, [StressPeriod]);
  end
  else
  begin
    if Trim(Text) <> '' then
    begin
      sbStatusBar.SimpleText := Text;
    end;
  end;
  Application.ProcessMessages;

  if Trim(Text) = Normal then
  begin
    FReadModflowInputProperly := True;
  end;
end;

procedure TfrmImportModflow.ShowProgress(Position, Total: integer);
begin
  if pbProgress.Max <> Total then
  begin
    pbProgress.Max := Total
  end;
  pbProgress.Position := Position;
  Application.ProcessMessages;
end;

procedure TfrmImportModflow.UpdateStatusBar(const Text: string);
begin
  sbStatusBar.SimpleText := Text;
  Application.ProcessMessages;
end;

end.
