program PRedmine;

uses
  Vcl.Forms,
  Redmine in 'Redmine.pas' {frmMain},
  Configurar in 'Configurar.pas' {frmConfiguracao},
  Importar in 'Importar.pas' {frmImportar},
  JsonUtils in 'JsonUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmImportar, frmImportar);
  Application.Run;
end.
