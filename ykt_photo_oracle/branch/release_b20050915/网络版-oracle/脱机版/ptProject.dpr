program ptProject;

uses
  Forms,
  ptMain in 'ptMain.pas' {fMain},
  uConst in 'uConst.pas',
  fConfig in 'fConfig.pas' {frmConfig};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
