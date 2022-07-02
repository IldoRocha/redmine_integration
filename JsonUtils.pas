unit JsonUtils;

interface

uses
  System.SysUtils,
  Generics.Collections,
  Json;

type

  TJsonUtil = class
    class function CarregarArquivoString(AFilename: TFilename): string;
    class function CarregarArquivoJson(AFilename: TFilename; const EscapeDoubleQuotes: Boolean): TDictionary<String, String>;
    class function CarregarStringJson(AJsonContent: String; const EscapeDoubleQuotes: Boolean): TDictionary<String, String>;
    class function CarregarObjetoJson(AJsonObject: TJsonObject; const EscapeDoubleQuotes: Boolean = True): TDictionary<String, String>;
    class procedure SalvarJson(AJson: String; AFilename: TFilename; _AConfiguracao: Boolean);
    class function  LerJson(AJsonObject: TDictionary<String, String>; AChave: String): String;
  end;

implementation

uses
  System.Classes;

{ TJsonUtil }

class function TJsonUtil.CarregarArquivoString(AFilename: TFilename): string;
var
  Txt: TextFile;
  Value: String;
begin
  if FileExists(AFilename) then
  begin
    AssignFile(Txt, AFilename);
    Reset(Txt);
    while not Eof(Txt) do
    begin
      Readln(Txt, Value);
      Result := Result + Value;
    end;
    CloseFile(Txt);
  end
  else
    Result := '';
end;

class function TJsonUtil.CarregarArquivoJson(AFilename: TFilename; const EscapeDoubleQuotes: Boolean): TDictionary<String, String>;
var
  AJsonContent: String;
begin
  AJsonContent := CarregarArquivoString(AFilename);
  Result := CarregarStringJson(AJsonContent, EscapeDoubleQuotes);
end;

class function TJsonUtil.CarregarStringJson(AJsonContent: String; const EscapeDoubleQuotes: Boolean): TDictionary<String, String>;
var
  AJsonObject: TJSONObject;
begin
  AJsonObject := TJsonObject.ParseJSONValue
    (TEncoding.ASCII.GetBytes(AJsonContent), 0) as TJsonObject;
  try
    Result := CarregarObjetoJson(AJsonObject);
  finally
    FreeAndNil(AJsonObject);
  end;
end;

class function TJsonUtil.LerJson(AJsonObject: TDictionary<String, String>;
  AChave: String): String;
begin
  Result := AJsonObject[AChave];
  Result := StringReplace(Result, '"', EmptyStr, [rfReplaceAll]);
end;

class procedure TJsonUtil.SalvarJson(AJson: String; AFilename: TFilename; _AConfiguracao: Boolean);
var
  AFile: TStrings;
begin
  AFile := TStringList.Create();
  AFile.Text := AJson;
  AFile.SaveToFile(AFilename, TUTF8Encoding.UTF8);
end;

class function TJsonUtil.CarregarObjetoJson(AJsonObject: TJsonObject; const EscapeDoubleQuotes: Boolean): TDictionary<String, String>;
var
  Par: TJsonPair;

  function ParseContent(Value: String): String;
  begin
    Result := Value;
    if EscapeDoubleQuotes then
      if Value.StartsWith('"') then
        Result := StringReplace(Result, '"', EmptyStr, [rfReplaceAll]);
  end;
begin
   Result := TDictionary<String, String>.Create;
    for Par in AJsonObject do
      Result.AddOrSetValue(
        ParseContent(Par.JsonString.ToString),
        ParseContent(Par.JsonValue.ToString) );
end;

end.
