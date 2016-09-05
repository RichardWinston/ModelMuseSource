unit ModflowOC_Writer;

interface

uses SysUtils, PhastModelUnit, CustomModflowWriterUnit, ModflowOutputControlUnit;

type
  TOutputControlWriter = class(TCustomModflowWriter)
  private
    FOutputControl: TModflowOutputControl;
    FNameOfFile: string;
    procedure WriteDataSet0;
    procedure WriteDataSet1;
    procedure WriteDataSets2and3;
  protected
    class function Extension: string; override;
  public
    Constructor Create(AModel: TCustomModel; EvaluationType: TEvaluationType); override;
    procedure WriteFile(const AFileName: string);
  end;

implementation

uses ModflowUnitNumbers, ModflowTimeUnit, frmErrorsAndWarningsUnit, 
  frmProgressUnit, Forms, GoPhastTypes, System.Math;

resourcestring
  StrStressPeriod0d = 'Stress period: %0:d; Starting Time: %1:g';
  StrWritingDataSet2 = '    Writing Data Set 2 for stress period %0:d; time s' +
  'tep %1:d';
  StrWritingDataSet3 = '    Writing Data Set 3 for stress period %0:d; time ' +
  'step %1:d';
  StrWritingOutputContr = 'Writing Output Control input.';
//  StrWritingDataSet0 = '  Writing Data Set 0.';
//  StrWritingDataSet1 = '  Writing Data Set 1.';
  StrStressPeriodWarning = 'One or more transient stress periods are reference '
    + 'periods for calculating drawdown';
  StrOC8 = 'OC8';

{ TOutputControlWriter }

constructor TOutputControlWriter.Create(AModel: TCustomModel; EvaluationType: TEvaluationType);
begin
  inherited Create(AModel, EvaluationType);
  FOutputControl := Model.ModflowOutputControl;
end;

class function TOutputControlWriter.Extension: string;
begin
  result := '.oc';
end;

procedure TOutputControlWriter.WriteDataSet0;
var
  Index: integer;
begin
  WriteCommentLine('Output Control file created on '
    + DateToStr(Now) + ' by ' + Model.ProgramName
    + ' version ' + IModelVersion + '.');
  for Index := 0 to FOutputControl.Comments.Count - 1 do
  begin
    WriteCommentLine(FOutputControl.Comments[Index]);
  end;
end;

procedure TOutputControlWriter.WriteDataSet1;
var
  NameOfFile: string;
  COLUMNS: Integer;
  WIDTH: Integer;
  DIGITS: Integer;
  PrintFormatType: TPrintNumberType;
  CellFlowsName: string;
  BudgetSummaryUnitNumber: Integer;
  procedure WriteSingleQuoteMF6;
  begin
    if Model.ModelSelection = msModflow2015 then
    begin
      WriteString('''');
    end;
  end;
  procedure WritePrintFormat(HeadDrawdownOC: THeadDrawdownOutputControl;
    const DataLabel: string);
  begin
    if HeadDrawdownOC.PrintInListing then
    begin
      if Model.ModelSelection = msModflow2015 then
      begin
        WriteString('  ');
      end;
      WriteString(DataLabel);
      WriteString(' PRINT FORMAT ');

      if Model.ModelSelection = msModflow2015 then
      begin
        COLUMNS := 0;
        WIDTH := 0;
        DIGITS := 0;
        case HeadDrawdownOC.PrintFormat of
          nf11G_10_3:
            begin
              COLUMNS := 11;
              WIDTH := 10;
              DIGITS := 3;
              PrintFormatType := pntGeneral;
            end;
          nf9G_13_6:
            begin
              COLUMNS := 9;
              WIDTH := 13;
              DIGITS := 6;
              PrintFormatType := pntGeneral;
            end;
          nf15F_7_1:
            begin
              COLUMNS := 15;
              WIDTH := 7;
              DIGITS := 1;
              PrintFormatType := pntFixed;
            end;
          nf15F_7_2:
            begin
              COLUMNS := 15;
              WIDTH := 7;
              DIGITS := 2;
              PrintFormatType := pntFixed;
            end;
          nf15F_7_3:
            begin
              COLUMNS := 15;
              WIDTH := 7;
              DIGITS := 3;
              PrintFormatType := pntFixed;
            end;
          nf15F_7_4:
            begin
              COLUMNS := 15;
              WIDTH := 7;
              DIGITS := 4;
              PrintFormatType := pntFixed;
            end;
          nf20F_5_0:
            begin
              COLUMNS := 20;
              WIDTH := 5;
              DIGITS := 0;
              PrintFormatType := pntFixed;
            end;
          nf20F_5_1:
            begin
              COLUMNS := 20;
              WIDTH := 5;
              DIGITS := 1;
              PrintFormatType := pntFixed;
            end;
          nf20F_5_2:
            begin
              COLUMNS := 20;
              WIDTH := 5;
              DIGITS := 2;
              PrintFormatType := pntFixed;
            end;
          nf20F_5_3:
            begin
              COLUMNS := 20;
              WIDTH := 5;
              DIGITS := 3;
              PrintFormatType := pntFixed;
            end;
          nf20F_5_4:
            begin
              COLUMNS := 20;
              WIDTH := 5;
              DIGITS := 4;
              PrintFormatType := pntFixed;
            end;
          nf10G_11_4:
            begin
              COLUMNS := 10;
              WIDTH := 11;
              DIGITS := 4;
              PrintFormatType := pntFixed;
            end;
          nf10F_6_0:
            begin
              COLUMNS := 10;
              WIDTH := 6;
              DIGITS := 0;
              PrintFormatType := pntFixed;
            end;
          nf10F_6_1:
            begin
              COLUMNS := 10;
              WIDTH := 6;
              DIGITS := 1;
              PrintFormatType := pntFixed;
            end;
          nf10F_6_2:
            begin
              COLUMNS := 10;
              WIDTH := 6;
              DIGITS := 2;
              PrintFormatType := pntFixed;
            end;
          nf10F_6_3:
            begin
              COLUMNS := 10;
              WIDTH := 6;
              DIGITS := 3;
              PrintFormatType := pntFixed;
            end;
          nf10F_6_4:
            begin
              COLUMNS := 10;
              WIDTH := 6;
              DIGITS := 4;
              PrintFormatType := pntFixed;
            end;
          else
            Assert(False);
        end;
  //        18:
  //          begin
  //            COLUMNS := 10;
  //            WIDTH := 6;
  //            DIGITS := 5;
  //          end;
  //        19:
  //          begin
  //            COLUMNS := 5;
  //            WIDTH := 12;
  //            DIGITS := 5;
  //          end;
  //        20:
  //          begin
  //            COLUMNS := 6;
  //            WIDTH := 11;
  //            DIGITS := 4;
  //          end;
  //        21:
  //          begin
  //            COLUMNS := 7;
  //            WIDTH := 9;
  //            DIGITS := 2;
  //          end;
        WriteString(' COLUMNS ');
        WriteInteger(COLUMNS);
        WriteString(' WIDTH ');
        WriteInteger(WIDTH);
        WriteString(' DIGITS ');
        WriteInteger(DIGITS);

        case HeadDrawdownOC.Wrapping of
          wStrip: WriteString('STRIP ');
          wWrap: WriteString('WRAP ');
          else Assert(False);
        end;

        case PrintFormatType of
          pntExponential: WriteString(' EXPONENTIAL ');
          pntFixed: WriteString(' FIXED ');
          pntGeneral: WriteString(' GENERAL ');
          pntScientific: WriteString(' SCIENTIFIC ');
          else Assert(False);
        end;

      end
      else
      begin
        WriteInteger(HeadDrawdownOC.PrintCode);
      end;
      NewLine;
    end;
  end;
  procedure WriteSaveFile(HeadDrawdownOC: THeadDrawdownOutputControl;
    const DataLabel, FormatedExtension, BinaryExtension: string);
  begin
    if HeadDrawdownOC.SaveInExternalFile then
    begin
      case HeadDrawdownOC.OutputFileType of
        oftText:
          begin
            NameOfFile := ChangeFileExt(FNameOfFile, FormatedExtension);
            WriteToNameFile(StrDATA, Model.UnitNumbers.UnitNumber(DataLabel),
              NameOfFile, foOutput, Model);
            if Model.ModelSelection = msModflow2015 then
            begin
              WriteString('  ');
              WriteString(DataLabel);
              WriteString(' SAVE FILE ');
              WriteSingleQuoteMF6;
              WriteString(NameOfFile);
              WriteSingleQuoteMF6;
              NewLine;
              WriteString('  ');
            end;

            WriteString(DataLabel);
            WriteString(' SAVE FORMAT ');
            WriteString(HeadDrawdownOC.ExternalFormat.FullFormat);
            WriteString(' LABEL');
            NewLine;
          end;
        oftBinary:
          begin
            NameOfFile := ChangeFileExt(FNameOfFile, BinaryExtension);
            WriteToNameFile(StrDATABINARY,
              Model.UnitNumbers.UnitNumber(DataLabel), NameOfFile, foOutput, Model);
            if Model.ModelSelection = msModflow2015 then
            begin
              WriteString('  ');
              WriteString(DataLabel);
              WriteString(' SAVE FILE ');
              WriteSingleQuoteMF6;
              WriteString(NameOfFile);
              WriteSingleQuoteMF6;
              NewLine;
            end;
          end;
        else Assert(False);
      end;
      if Model.ModelSelection <> msModflow2015 then
      begin
        WriteString(DataLabel);
        WriteString(' SAVE UNIT ');
        WriteInteger(Model.UnitNumbers.UnitNumber(DataLabel));
        NewLine;
      end;
    end;
  end;
begin
  if Model.ModelSelection = msModflow2015 then
  begin
    WriteBeginOptions;
  end;

  if Model.ModelSelection = msModflow2015 then
  begin
    { TODO -cMODFLOW-2015 : TModflowOutputControl.SaveCellFlows is different in MODFLOW-2015. You can both save and print values. }
    if FOutputControl.SaveCellFlows = csfBinary then
    begin
      CellFlowsName := ChangeFileExt(FNameOfFile, StrCbcExt);
      WriteString('  BUDGET SAVE FILE ');
      WriteString(CellFlowsName);
      NewLine
    end;
  end;

  WritePrintFormat(FOutputControl.HeadOC, StrHEAD);

  WriteSaveFile(FOutputControl.HeadOC, StrHEAD, StrFhd, StrBhd);

  WritePrintFormat(FOutputControl.DrawdownOC, StrDRAWDOWN);

  WriteSaveFile(FOutputControl.DrawdownOC, StrDRAWDOWN, StrFdn, StrBdn);

  if (Model.ModelSelection = msModflowFmp)
    and FOutputControl.SaveBudgetSummary then
  begin
    NameOfFile := ChangeFileExt(FNameOfFile, '.wbgt');
    BudgetSummaryUnitNumber := Model.UnitNumbers.UnitNumber(StrWBGT);
    WriteToNameFile(StrDATA, BudgetSummaryUnitNumber, NameOfFile, foOutput, Model);
    WriteString(StrWBGT);
    WriteString(' SAVE UNIT ');
    WriteInteger(BudgetSummaryUnitNumber);
    NewLine;
  end;

  if Model.ModelSelection <> msModflow2015 then
  begin
    if FOutputControl.Compact then
    begin
      WriteString('COMPACT BUDGET AUXILIARY');
      NewLine;
    end;
  end;

  if Model.ModelSelection = msModflow2015 then
  begin
    WriteEndOptions;
  end;

end;

procedure TOutputControlWriter.WriteDataSets2and3;
type
  TPrintSave = (psPrint, psSave);
var
  StressPeriods: TModflowStressPeriods;
  HeadFrequency: integer;
  HeadFrequencyChoice: TFrequencyChoice;
  DrawdownFrequency: integer;
  DrawdownFrequencyChoice: TFrequencyChoice;
  StressPeriodIndex: integer;
  TimeStepIndex: integer;
  StressPeriod: TModflowStressPeriod;
  ShouldExportHead: boolean;
  ShouldExportDrawdown: boolean;
  SetDDREFERENCE: boolean;
  IPEROC: Integer;
  ITSOC: Integer;
  ShouldExportOverallBudget: boolean;
  ShouldExportCellBudget: boolean;
  BudgetFrequencyChoice: TFrequencyChoice;
  BudgetFrequency: integer;
  WarningMessage: string;
  function ShouldExport(FrequencyChoice: TFrequencyChoice;
    Frequency: integer; TimeStepIndex: Integer): boolean;
  begin
    result := False;
    case FrequencyChoice of
      fcTimeSteps:
        begin
          result := (TimeStepIndex < Frequency)
            or ((TimeStepIndex + 1) mod Frequency = 0)
            or (TimeStepIndex = StressPeriod.NumberOfSteps - 1);
        end;
      fcStressPeriods:
        begin
          result := (TimeStepIndex = StressPeriod.NumberOfSteps - 1)
            and (((StressPeriodIndex + 1) mod Frequency = 0)
            or (StressPeriodIndex = StressPeriods.Count - 1));
        end;
      else Assert(False);
    end;
  end;
  procedure WriteOC_MF6(const DataLabel: string; Frequency: Integer;
    FrequencyChoice: TFrequencyChoice; PrintSave: TPrintSave);
  var
    ShouldExportData: Boolean;
    TimeIndex: integer;
    procedure WritePrintOrSave;
    begin
      case PrintSave of
        psPrint:
          begin
            WriteString(' PRINT');
          end;
        psSave:
          begin
            WriteString(' SAVE');
          end;
        else
          Assert(False);
      end;
    end;
  begin
    ShouldExportData := ShouldExport(FrequencyChoice, Frequency,
      StressPeriod.NumberOfSteps - 1);
    if ShouldExportData then
    begin
      case FrequencyChoice of
        fcTimeSteps:
          begin
            if (Frequency = 1) or (StressPeriod.NumberOfSteps = 1) then
            begin
              WriteString('  ');
              WriteString(DataLabel);
              WritePrintOrSave;
              WriteString(' ALL');
              NewLine;
            end
            else
            begin
              if StressPeriod.NumberOfSteps > Frequency then
              begin
                WriteString('  ');
                WriteString(DataLabel);
                WritePrintOrSave;
                WriteString(' FREQUENCY ');
                WriteInteger(Frequency);
                NewLine;
              end;

              WriteString('  ');
              WriteString(DataLabel);
              WritePrintOrSave;
              WriteString(' STEPS ');
              for TimeIndex := 1 to Min(StressPeriod.NumberOfSteps, Frequency)-1 do
              begin
                WriteInteger(TimeIndex);
              end;
              NewLine;

              WriteString('  ');
              WriteString(DataLabel);
              WritePrintOrSave;
              WriteString(' LAST');
              NewLine;
            end;
          end;
        fcStressPeriods:
          begin
            WriteString('  ');
            WriteString(DataLabel);
            WritePrintOrSave;
            WriteString(' LAST');
            NewLine;
          end;
        else
          Assert(False);
      end
    end;
  end;
begin
  StressPeriods := Model.ModflowFullStressPeriods;

  HeadFrequency := FOutputControl.HeadOC.Frequency;
  HeadFrequencyChoice := FOutputControl.HeadOC.FrequencyChoice;
  DrawdownFrequency := FOutputControl.DrawdownOC.Frequency;
  DrawdownFrequencyChoice := FOutputControl.DrawdownOC.FrequencyChoice;
  BudgetFrequencyChoice := FOutputControl.BudgetFrequencyChoice;
  BudgetFrequency := FOutputControl.BudgetFrequency;
  Assert(HeadFrequency >= 1);
  Assert(DrawdownFrequency >= 1);
  Assert(BudgetFrequency >= 1);

  for StressPeriodIndex := 0 to StressPeriods.Count - 1 do
  begin
    StressPeriod := StressPeriods.Items[StressPeriodIndex];
    if Model.ModelSelection = msModflow2015 then
    begin
      WriteString('BEGIN PERIOD ');
      WriteInteger(StressPeriodIndex + 1);
      NewLine;

      if FOutputControl.HeadOC.PrintInListing then
      begin
        WriteOC_MF6(StrHEAD, HeadFrequency, HeadFrequencyChoice, psPrint);
      end;

      if FOutputControl.HeadOC.SaveInExternalFile then
      begin
        WriteOC_MF6(StrHEAD, HeadFrequency, HeadFrequencyChoice, psSave);
      end;

      if FOutputControl.DrawdownOC.PrintInListing then
      begin
        WriteOC_MF6(StrDRAWDOWN, DrawdownFrequency, DrawdownFrequencyChoice, psPrint);
      end;

      if FOutputControl.DrawdownOC.SaveInExternalFile then
      begin
        WriteOC_MF6(StrDRAWDOWN, DrawdownFrequency, DrawdownFrequencyChoice, psSave);
      end;

      if FOutputControl.SaveCellFlows <> csfNone then
      begin
        WriteOC_MF6('BUDGET', BudgetFrequency, BudgetFrequencyChoice, psPrint);
      end;

      if FOutputControl.SaveCellFlows <> csfNone then
      begin
        WriteOC_MF6('BUDGET', BudgetFrequency, BudgetFrequencyChoice, psSave);
      end;

      if StressPeriod.DrawDownReference then
      begin
        WriteString('  DRAWDOWN REFERENCE ');
        WriteInteger(StressPeriod.NumberOfSteps);
        NewLine;
      end;

      WriteString('END PERIOD ');
      NewLine;
    end
    else
    begin
      for TimeStepIndex := 0 to StressPeriod.NumberOfSteps - 1 do
      begin
        Application.ProcessMessages;
        if not frmProgressMM.ShouldContinue then
        begin
          Exit;
        end;
        ShouldExportHead := False;
        if FOutputControl.HeadOC.PrintInListing
          or FOutputControl.HeadOC.SaveInExternalFile then
        begin
          ShouldExportHead := ShouldExport(HeadFrequencyChoice,
            HeadFrequency, TimeStepIndex);
        end;

        ShouldExportDrawdown := False;
        if FOutputControl.DrawdownOC.PrintInListing
          or FOutputControl.DrawdownOC.SaveInExternalFile then
        begin
          ShouldExportDrawdown := ShouldExport(DrawdownFrequencyChoice,
            DrawdownFrequency, TimeStepIndex);
        end;

        ShouldExportCellBudget := False;
        if FOutputControl.SaveCellFlows <> csfNone then
        begin
          ShouldExportCellBudget := ShouldExport(BudgetFrequencyChoice,
            BudgetFrequency, TimeStepIndex);
        end;

        ShouldExportOverallBudget := ShouldExport(BudgetFrequencyChoice,
          BudgetFrequency, TimeStepIndex);

        SetDDREFERENCE := StressPeriod.DrawDownReference
          and (TimeStepIndex = StressPeriod.NumberOfSteps - 1);

        if SetDDREFERENCE
          and (StressPeriod.StressPeriodType = sptTransient) then
        begin
          WarningMessage := Format(StrStressPeriod0d,
            [StressPeriodIndex+1, StressPeriod.StartTime]);
          frmErrorsAndWarnings.AddWarning(Model, StrStressPeriodWarning, WarningMessage);
        end;

        if ShouldExportHead or ShouldExportDrawdown or SetDDREFERENCE
          or ShouldExportCellBudget or ShouldExportOverallBudget then
        begin
          // Data set 2
          frmProgressMM.AddMessage(Format(StrWritingDataSet2,
            [StressPeriodIndex+1, TimeStepIndex+1]));
          IPEROC := StressPeriodIndex + 1;
          ITSOC := TimeStepIndex + 1;

          WriteString('PERIOD');
          WriteInteger(IPEROC);
          WriteString(' STEP');
          WriteInteger(ITSOC);
          if SetDDREFERENCE then
          begin
            WriteString(' DDREFERENCE');
          end;
          NewLine;

          // Data set 3
          frmProgressMM.AddMessage(Format(StrWritingDataSet3,
            [StressPeriodIndex+1, TimeStepIndex+1]));
          if ShouldExportHead and FOutputControl.HeadOC.PrintInListing then
          begin
            WriteString('     PRINT HEAD');
            NewLine;
          end;
          if ShouldExportHead and FOutputControl.HeadOC.SaveInExternalFile then
          begin
            WriteString('     SAVE HEAD');
            NewLine;
          end;
          if ShouldExportDrawdown and FOutputControl.DrawdownOC.PrintInListing then
          begin
            WriteString('     PRINT DRAWDOWN');
            NewLine;
          end;
          if ShouldExportDrawdown and FOutputControl.DrawdownOC.SaveInExternalFile then
          begin
            WriteString('     SAVE DRAWDOWN');
            NewLine;
          end;
          if ShouldExportCellBudget then
          begin
            WriteString('     SAVE BUDGET');
            NewLine;
          end;
          if ShouldExportOverallBudget then
          begin
            WriteString('     PRINT BUDGET');
            NewLine;

            if (Model.ModelSelection = msModflowFmp)
              and FOutputControl.SaveBudgetSummary then
            begin
              WriteString('     SAVE WBGT ');
              NewLine;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TOutputControlWriter.WriteFile(const AFileName: string);
var
  FTYPE: string;
begin
  if Model.ModelSelection = msModflow2015 then
  begin
    FTYPE := StrOC8;
  end
  else
  begin
    FTYPE := StrOC;
  end;
  if Model.PackageGeneratedExternally(FTYPE) then
  begin
    Exit;
  end;
  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveWarningGroup(Model, StrStressPeriodWarning);
    FNameOfFile := FileName(AFileName);
    if Model.ModelSelection = msModflow2015 then
    begin
      WriteToNameFile(FTYPE, -1, FNameOfFile, foInput, Model);
    end
    else
    begin
      WriteToNameFile(FTYPE, Model.UnitNumbers.UnitNumber(FTYPE), FNameOfFile, foInput, Model);
    end;
    OpenFile(FNameOfFile);
    try
      frmProgressMM.AddMessage(StrWritingOutputContr);
      frmProgressMM.AddMessage(StrWritingDataSet0);
      WriteDataSet0;
      frmProgressMM.AddMessage(StrWritingDataSet1);
      WriteDataSet1;
      WriteDataSets2and3;
    finally
      CloseFile;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

end.

