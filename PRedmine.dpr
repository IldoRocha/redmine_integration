program PRedmine;

uses
  Vcl.Forms,
  Redmine in 'Redmine.pas' {Form1},
  frmConfig in 'frmConfig.pas' {frmConfiguracao},
  JsonUtils in 'JsonUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmConfiguracao, frmConfiguracao);
  Application.Run;
end.
