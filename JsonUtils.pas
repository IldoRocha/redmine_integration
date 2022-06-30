unit JsonUtils;

interface

uses
  System.SysUtils;

type

TJsonUtil = class
  class procedure SalvarJson(AJson: String; AFilename: TFilename; _AConfiguracao: Boolean);
end;

implementation

{ TJsonUtil }

class procedure TJsonUtil.SalvarJson(AJson: String; AFilename: TFilename; _AConfiguracao: Boolean);
var
  AFile: TextFile;
begin
   AssignFile(AFile, AFilename);
  ReWrite(AFile);
  if _AConfiguracao then
    Write(AFile, AJson)
  else
    Write(AFile, '[', AJson, ']');
  CloseFile(AFile);
end;



end.
