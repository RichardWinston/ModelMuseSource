unit frmNewVersionUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCustomGoPhastUnit, ExtCtrls, StdCtrls, JvExStdCtrls, JvHtControls,
  Buttons;

type
  TfrmNewVersion = class(TfrmCustomGoPhast)
    Image1: TImage;
    Label1: TLabel;
    btnClose: TBitBtn;
    btnGoToWeb: TBitBtn;
    lblYourVersion: TLabel;
    lblVersionOnWeb: TLabel;
    procedure FormCreate(Sender: TObject); override;
    procedure btnGoToWebClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNewVersion: TfrmNewVersion;

implementation

uses
  RbwInternetUtilities;

{$R *.dfm}

procedure TfrmNewVersion.btnGoToWebClick(Sender: TObject);
var
  Browser: string;
begin
  inherited;
  Browser := '';
  LaunchURL(Browser, 'http://water.usgs.gov/nrp/gwsoftware/ModelMuse/ModelMuse.html');
end;

procedure TfrmNewVersion.FormCreate(Sender: TObject);
begin
  inherited;
  Image1.Picture.Icon.Handle := LoadIcon(0, IDI_ASTERISK);
end;

end.
