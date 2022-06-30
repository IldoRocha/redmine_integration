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
  Vcl.StdCtrls, 
  Vcl.Menus, 
  Data.DB, 
  System.Generics.Collections, 
  System.SysUtils, 
  System.Actions, 
  Vcl.ActnList, 
  Vcl.Buttons;

type

  TDbIterator = class
    class procedure Iterate(ADataset: TDataset; AProc: TProc<TDataset>);
  end;

  TForm1 = class(TForm)
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
    procedure Button1Click(Sender: TObject);
    procedure ActDuplicarExecute(Sender: TObject);
    procedure Configurar(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetTitulo: string; 
    function GetDescricao: string; 
    function GetTipoTarefa: string; 
    function GetTarefaPrincipal: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

  uses ShellApi, frmConfig, JsonUtils, Vcl.Dialogs;

{$R *.dfm}

{ TDbIterator }


procedure TForm1.FormCreate(Sender: TObject);
begin
  //CarregarJson
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

procedure TForm1.ActDuplicarExecute(Sender: TObject);
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

  FDMemTable1.Post;
end;

procedure TForm1.Button1Click(Sender: TObject);
const
  REGISTRO = '{"Name":"%0:s","Subject":"%0:s","Description":"%1:s","Status":"","Priority":"baixa", "Tracker":"%2:s","Parent":%3:s}';
  NOMEARQUIVOJSON = 'Tarefas.Json';
var
  AJson: String;
begin
  AJson := emptyStr;
  TDbIterator.Iterate(FDMemTable1, procedure (ADataset: TDataset) begin
    If AJson > EmptyStr then
      AJson := AJson + ','#13#10;
    with ADataset do
    AJson := AJson + Format(REGISTRO, [ GetTitulo, GetDescricao, GetTipoTarefa, GetTarefaPrincipal ]);

  end);
  TJsonUtil.SalvarJson(AJson, NOMEARQUIVOJSON, False);
  ShellExecute(Handle, 'open', PChar(NOMEARQUIVOJSON), nil, nil, SW_SHOW);

//  if MessageDlg('Deseja executar o Redmine agora?', mtConfirmation, [mbYes, mbNo],0) = mrYES then
//    ShellExecute(ExecutaroPython);
end;

procedure TForm1.Configurar(Sender: TObject);
begin
  frmConfiguracao.ShowModal;
end;

function TForm1.GetDescricao: string;
begin
  Result := FDMemTable1Descricao.AsString;
end;

function TForm1.GetTarefaPrincipal: string;
var
  Codigo: Integer;
begin
  Codigo := FDMemTable1TarefaPai.AsInteger;

  if Codigo > 0 then
    Result := Format('"%d"', [Codigo])
  else
    Result := 'null';
end;

function TForm1.GetTipoTarefa: string;
begin
  Result := FDMemTable1Tipo.AsString;
end;

function TForm1.GetTitulo: string;
begin
  Result := FDMemTable1Titulo.AsString;
end;

end.
