unit ModflowPCG_WriterUnit;

interface

uses SysUtils, CustomModflowWriterUnit, ModflowPackageSelectionUnit;

Type
  TPcgWriter = class(TCustomSolverWriter)
  private
    procedure WriteDataSet1;
    procedure WriteDataSet2;
  protected
    function Package: TModflowPackageSelection; override;
    class function Extension: string; override;
  public
    procedure WriteFile(const AFileName: string);
  end;

implementation

uses ModflowUnitNumbers, PhastModelUnit, frmProgressUnit;

resourcestring
  StrWritingPCGPackage = 'Writing PCG Package input.';

{ TPcgWriter }

class function TPcgWriter.Extension: string;
begin
  result := '.pcg';
end;

function TPcgWriter.Package: TModflowPackageSelection;
begin
  result := Model.ModflowPackages.PcgPackage;
end;

procedure TPcgWriter.WriteDataSet1;
var
  PCG: TPcgSelection;
begin
  PCG := Model.ModflowPackages.PcgPackage;
  WriteInteger(PCG.MXITER);
  WriteInteger(PCG.ITER1);
  WriteInteger(Ord(PCG.NPCOND)+1);
  WriteInteger(Ord(PCG.IHCOFADD));
  WriteString(' # MXITER, ITER1, NPCOND, IHCOFADD');
  NewLine;
end;

procedure TPcgWriter.WriteDataSet2;
var
  PCG: TPcgSelection;
begin
  PCG := Model.ModflowPackages.PcgPackage;
  WriteFloat(PCG.HCLOSE.Value);
  WriteFloat(PCG.RCLOSE.Value);
  WriteFloat(PCG.RELAX.Value);
  WriteInteger(Ord(PCG.NBPOL)+1);
  WriteInteger(PCG.IPRPCG);
  WriteInteger(Ord(PCG.MUTPCG));
  if PCG.DAMPPCG.Value = PCG.DAMPPCGT.Value then
  begin
    WriteFloat(PCG.DAMPPCG.Value);
    WriteString(' # HCLOSE, RCLOSE, RELAX, NBPOL, IPRPCG, MUTPCG, DAMPPCG');
  end
  else
  begin
    WriteFloat(-PCG.DAMPPCG.Value);
    WriteFloat(PCG.DAMPPCGT.Value);
    WriteString(' # HCLOSE, RCLOSE, RELAX, NBPOL, IPRPCG, MUTPCG, DAMPPCG, DAMPPCGT');
  end;
  NewLine;
end;

procedure TPcgWriter.WriteFile(const AFileName: string);
var
  NameOfFile: string;
begin
  if not Package.IsSelected then
  begin
    Exit
  end;
  if SolverFileGeneratedExternally then
  begin
    Exit;
  end;
  NameOfFile := FileName(AFileName);
  WriteToNameFile('PCG', Model.UnitNumbers.UnitNumber(StrPCG),
    NameOfFile, foInput, Model);
  OpenFile(NameOfFile);
  try
    frmProgressMM.AddMessage(StrWritingPCGPackage);
    WriteDataSet0;
    WriteDataSet1;
    WriteDataSet2;
  finally
    CloseFile;
  end;
end;

end.

