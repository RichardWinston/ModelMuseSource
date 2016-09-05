unit frmUpdateDataSetsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCustomGoPhastUnit, StdCtrls;

type
  TfrmUpdateDataSets = class(TfrmCustomGoPhast)
    Label1: TLabel;
    btnUpdate: TButton;
    btnCreate: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUpdateDataSets: TfrmUpdateDataSets;

implementation

{$R *.dfm}

end.
