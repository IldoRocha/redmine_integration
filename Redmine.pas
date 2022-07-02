unit Redmine;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Menus,
  Vcl.ActnList,
  Vcl.Buttons,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin,
  Data.DB,
  System.Generics.Collections,
  System.SysUtils,
  System.Actions,
  System.UITypes,
  JSON;

type

  TDbIterator = class
    class procedure Iterate(ADataset: TDataset; AProc: TProc<TDataset>);
  end;

  TJsonProcedure = procedure(AJson: TJsonValue) of Object;

  TfrmMain = class(TForm)
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    FDMemTable1Tipo: TStringField;
    FDMemTable1Titulo: TStringField;
    FDMemTable1Descricao: TStringField;
    FDMemTable1Gerado: TBooleanField;
    MainMenu1: TMainMenu;
    Editar1: TMenuItem;
    Criarapartirdeumalista1: TMenuItem;
    Button1: TButton;
    BitBtn1: TBitBtn;
    ActionList1: TActionList;
    ActDuplicar: TAction;
    FDMemTable1TarefaPai: TIntegerField;
    Button2: TButton;
    Button3: TButton;
    ComboBoxTipoPadrao: TComboBox;
    chAlterarTipo: TCheckBox;
    actEnviar: TAction;
    actConfigurar: TAction;
    actImportar: TAction;
    procedure ActDuplicarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actEnviarExecute(Sender: TObject);
    procedure actConfigurarExecute(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure actImportarExecute(Sender: TObject);
    procedure FDMemTable1AfterScroll(DataSet: TDataSet);
  private
    function GetTitulo: string;
    function GetDescricao: string;
    function GetTipoTarefa: string;
    function GetTarefaPrincipal: string;
    procedure CarregarComboBox;
    procedure CarregarJson(const AFilename: TFilename; AProc: TJsonProcedure);
    procedure CarregarTarefas(AJson: TJsonValue);
    procedure CarregarTarefa(AJson: TJsonValue);
    function  GetTipo: string;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses         
  Importar, 
  Configurar, 
  ShellApi, 
  Vcl.Dialogs, 
  IOUtils, 
  JsonUtils;

{$R *.dfm}

{ TDbIterator }


procedure TfrmMain.FDMemTable1AfterScroll(DataSet: TDataSet);
begin
  if not (Dataset.State in [dsInsert]) then
    if chAlterarTipo.Checked then
       ComboBoxTipoPadrao.Text := FDMemTable1Tipo.AsString;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmConfiguracao := TfrmConfiguracao.Create(Application);
  CarregarComboBox();
  CarregarJson('Config.Json', frmConfiguracao.CarregarConfiguracoes);
  CarregarJson('Tarefas.Json', CarregarTarefas);
end;

procedure TfrmMain.CarregarTarefas(AJson: TJsonValue);
var
  Tarefa: TJsonValue;
begin
  if AJson is TJsonArray then
  begin
    FDMemTable1.EmptyDataSet;
    for Tarefa in TJsonArray(AJson) do
      CarregarTarefa(Tarefa);
  end;
end;

procedure TfrmMain.CarregarTarefa(AJson: TJsonValue);
var
  ADicionario: TDictionary<String, String>;
begin
  ADicionario := TJsonUtil.CarregarObjetoJson(AJson as TJSONObject);
  try
    FdMemTable1.insert;
    FDMemTable1Titulo.asString := TJsonUtil.LerJson(ADicionario, 'Subject');
    FDMemTable1Descricao.asString := TJsonUtil.LerJson(ADicionario, 'Description');
    FDMemTable1TarefaPai.AsInteger := StrToIntDef(TJsonUtil.LerJson(ADicionario, 'Parent'), 0);
    FDMemTable1Tipo.asString := TJsonUtil.LerJson(ADicionario, 'Tipo');

    FDMemTable1.Post;
  finally
    FreeAndNil(ADicionario);
  end;
end;

procedure TfrmMain.CarregarJson(const AFilename: TFilename; AProc: TJsonProcedure);
var                     
  JSONValue: TJSONValue;
begin
  if not FileExists(AFilename) then
    Exit;

  if not Assigned(AProc) then
    Exit;

  JSONValue := TJSONObject.ParseJSONValue(TFile.ReadAllText(AFilename));

  try
    AProc(JsonValue);
  finally
    JSONValue.Free;
  end;
end 

{ GetGeneratedNames };

procedure TfrmMain.CarregarComboBox;
begin
  ComboBoxTipoPadrao.Items.Text := DBGrid1.Columns[0].PickList.Text;
end;

procedure TfrmMain.DBGrid1KeyPress(Sender: TObject; var Key: Char);
  const
  ANALISETECNICA = 'Análise Técnica';
  DESENVOLVIMENTO = 'Desenvolvimento';
  REGRANEGOCIO = 'Análise de Regra de Negócio';
  TESTEFUNCIONAL = 'Teste Funcional';
  TESTEUNITARIO = 'Teste Unitário';
  ERRO = 'Erro';

procedure Escolher(Valor: String);
begin
  Key := #0;
  if FDMemTable1.RecordCount = 0 then
    Exit;
  if FDMemTable1Tipo.asString <> Valor then
  begin
    FDMemTable1.Edit;
    FDMemTable1Tipo.asString := Valor;
    FDMemTable1.Post;
  end;
end;

begin
  if (DBGrid1.SelectedIndex = 0)
  and not (FDMemTable1.State in [dsInsert, dsEdit] ) then
  begin
    if Key in ['a','A'] then
      Escolher(ANALISETECNICA)
    else if Key in ['d','D'] then
      Escolher(DESENVOLVIMENTO)
    else if Key in ['t','T'] then
      Escolher(TESTEFUNCIONAL)
    else if Key in ['r','R'] then
      Escolher(REGRANEGOCIO)
    else if Key in ['n','N'] then
      Escolher(REGRANEGOCIO)
    else if Key in ['u','U'] then
      Escolher(TESTEUNITARIO)

  end;
end;

class procedure TDbIterator.Iterate(ADataset: TDataset; AProc: TProc<TDataset>);
begin
  ADataset.First;
  while not ADataset.Eof do
  begin
    AProc(ADataset);
    ADataset.Next;
  end;
end;

procedure TfrmMain.actConfigurarExecute(Sender: TObject);
begin
  frmConfiguracao.ShowModal;
end;

procedure TfrmMain.ActDuplicarExecute(Sender: TObject);
var
  Campos: TArray<Variant>;
  Field: TField;
  I: Integer;
begin
  Campos := [];

  for Field in FDMemTable1.Fields do
    Campos := Campos + [Field.Value];

  FDMemTable1.Insert;

  for I := 1 to FDMemTable1.Fields.Count do
    FDMemTable1.Fields[I-1].Value := Campos[I-1];

  if chAlterarTipo.Checked then
    FDMemTable1Tipo.asString := ComboBoxTipoPadrao.Text;

  FDMemTable1.Post;
end;

procedure TfrmMain.actEnviarExecute(Sender: TObject);
const
  REGISTRO = '{"Name":"%0:s","Subject":"%0:s","Description":"%1:s","Status":"","Priority":"baixa", "Tracker":"%2:s","Parent":%3:s, "Tipo": "%4:s" }';
  NOMEARQUIVOJSON = 'Tarefas.Json';
var
  AJson: String;
begin
  AJson := emptyStr;
  TDbIterator.Iterate(FDMemTable1, procedure (ADataset: TDataset) begin
    If AJson > EmptyStr then
      AJson := AJson + ','#13#10;
    with ADataset do
    AJson := AJson + Format(REGISTRO, [ GetTitulo, GetDescricao, GetTipoTarefa, GetTarefaPrincipal, GetTipo ]);

  end);
  TJsonUtil.SalvarJson('[' + AJson + ']', NOMEARQUIVOJSON, False);
  ShellExecute(Handle, 'open', PChar(NOMEARQUIVOJSON), nil, nil, SW_SHOW);

  if MessageDlg('Deseja executar o Redmine agora?', mtConfirmation, [mbYes, mbNo],0) = mrYES then
    ShellExecute(0, nil, PWideChar('main.exe'), nil, nil, SW_HIDE);
end;

procedure TfrmMain.actImportarExecute(Sender: TObject);
var
  i: Integer;
  linha, descricaoCurta, descricaoLonga: String;
begin
  if frmImportar.ShowModal = mrOk then
  begin
    for i := 0 to (frmImportar.ListaTxt.Lines.Count -1) do
    begin
      linha := frmImportar.ListaTxt.Lines.Strings[i];
      descricaoCurta := GetShortHint(linha);
      descricaoLonga := GetLongHint(linha);
      if descricaoLonga = EmptyStr then
        descricaoLonga := descricaoCurta;
      FDMemTable1.Insert;
      FDMemTable1Titulo.AsString := descricaoCurta;
      FDMemTable1Descricao.AsString := descricaoLonga;
      FDMemTable1Tipo.AsString := ComboBoxTipoPadrao.text;
    end;
  end;
end;

function TfrmMain.GetDescricao: string;
begin
  Result := FDMemTable1Descricao.AsString;
end;

function TfrmMain.GetTipo: string;
begin
  Result := FDMemTable1Tipo.AsString;
end;

function TfrmMain.GetTarefaPrincipal: string;
var
  Codigo: Integer;
begin
  Codigo := FDMemTable1TarefaPai.AsInteger;

  if Codigo > 0 then
    Result := Format('"%d"', [Codigo])
  else
    Result := 'null';
end;

function TfrmMain.GetTipoTarefa: string;
begin
  Result := FDMemTable1Tipo.AsString;
end;

function TfrmMain.GetTitulo: string;
begin
  Result := FDMemTable1Titulo.AsString;
end;

end.
