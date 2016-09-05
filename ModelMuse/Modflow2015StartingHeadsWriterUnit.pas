unit Modflow2015StartingHeadsWriterUnit;

interface

uses SysUtils, PhastModelUnit, DataSetUnit, CustomModflowWriterUnit,
  ModflowBasicWriterUnit, Vcl.Forms;

type
  TModflowStartingHeadsWriter = class(TCustomBasicWriter)
  private
    procedure WriteDataSet0;
    procedure WriteOptions;
  protected
    class function Extension: string; override;
  public
    Constructor Create(AModel: TCustomModel; EvaluationType: TEvaluationType); override;
    procedure WriteFile(const AFileName: string);
  end;


implementation

uses
  frmErrorsAndWarningsUnit, frmProgressUnit, GoPhastTypes;

{ TModflowStartingHeadsWriter }


constructor TModflowStartingHeadsWriter.Create(AModel: TCustomModel;
  EvaluationType: TEvaluationType);
begin
  inherited;
  XSECTION := False;
end;

class function TModflowStartingHeadsWriter.Extension: string;
begin
  result := '.ic';
end;

procedure TModflowStartingHeadsWriter.WriteDataSet0;
begin
  WriteCommentLines(Model.ModflowOptions.Description);
  WriteCommentLine('Initial Conditions Package file created on ' + DateToStr(Now) + ' by '
    + Model.ProgramName
    + ' version ' + IModelVersion + '.');
end;

procedure TModflowStartingHeadsWriter.WriteFile(const AFileName: string);
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrFileForTheInitial);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, StrWrongExtension);

    if Model.ModelSelection <> msModflow2015 then
    begin
      Exit;
    end;

    FNameOfFile := FileName(AFileName);
    if Model.PackageGeneratedExternally('IC8') then
    begin
      Exit;
    end;
    WriteToNameFile('IC8', Model.UnitNumbers.UnitNumber('IC'),
      FNameOfFile, foInput, Model);
    OpenFile(FNameOfFile);
    try
      frmProgressMM.AddMessage('Writing Initial Conditions Package input');
      frmProgressMM.AddMessage(StrWritingDataSet0);
      WriteDataSet0;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      WriteOptions;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      frmProgressMM.AddMessage('  Writing Starting Heads');
      WriteStartingHeads;
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;

      frmProgressMM.AddMessage(StrCheckingStarting);
      CheckStartingHeads;

    finally
      CloseFile;
    end;

  finally
    frmErrorsAndWarnings.EndUpdate;
  end;

end;

procedure TModflowStartingHeadsWriter.WriteOptions;
begin
  WriteBeginOptions;
  WriteEndOptions;
end;

end.
