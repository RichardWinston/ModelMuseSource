program RollupExample;

uses
  madExcept,
  madLinkDisAsm,
  GetOpenGlVendorUnit,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  frmMainUnit in 'frmMainUnit.pas' {Form11};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm11, Form11);
  Application.Run;
end.
