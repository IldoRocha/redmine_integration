unit frmConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmConfiguracao = class(TForm)
    FlowPanel1: TFlowPanel;
    Label1: TLabel;
    edtURL: TEdit;
    Label2: TLabel;
    edtIdProjeto: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtVersao: TEdit;
    edtNomeVersao: TEdit;
    edtAgente: TEdit;
    edtStatus: TEdit;
    edtCategoria: TEdit;
    edtPrioridade: TEdit;
    edtDataInicial: TDateTimePicker;
    edtDataFinal: TDateTimePicker;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    edtKey: TEdit;
    Label11: TLabel;

    procedure Button1Click(Sender: TObject);
    procedure ProximoControle(Sender: TObject; var Key: Char);
  private
    function getAGENTE: String;
    function getCATEGORIA: String;
    function getDATAF: String;
    function getDATAI: String;
    function getID: String;
    function getNOMEVERSAO: String;
    function getPRIORIDADE: String;
    function getSTATUS: String;
    function getURL: String;
    function getKey: String;
    function getVERSAO: String;
    property URL: String read getURL;
    property Key: String read getKey;
    property ID: String read getID;
    property VERSAO: String read getVERSAO;
    property AGENTE: String read getAGENTE;
    property NOMEVERSAO: String read getNOMEVERSAO;
    property STATUS: String read getSTATUS;
    property CATEGORIA: String read getCATEGORIA;
    property PRIORIDADE: String read getPRIORIDADE;
    property DATAI: String read getDATAI;
    property DATAF: String read getDATAF;
  public
    { Public declarations }
  end;

var
  frmConfiguracao: TfrmConfiguracao;

implementation

uses
  JsonUtils, ShellApi;

{$R *.dfm}

procedure TfrmConfiguracao.Button1Click(Sender: TObject);
const
  REGISTRO = '{            '#13+
'    "RedmineUrl": "%s",   '#13+
'    "RedmineKey": "%s",   '#13+
'    "IdProjeto": "%s",    '#13+
'    "IdVersao": "%s",     '#13+
'    "Agent": "%s",        '#13+
'    "NomeVersao": "%s",   '#13+
'    "Status": "%s",       '#13+
'    "Categoria": "%s",    '#13+
'    "Prioridade": "%s",   '#13+
'    "DataInicial": "%s",  '#13+
'    "DataFinal": "%s"     '#13+
'}';

  NOMEARQUIVOJSON = 'Config.Json';
var
  AJson: String;
begin
  AJson := Format(REGISTRO, [URL, Key, ID, VERSAO, AGENTE, NOMEVERSAO, STATUS, CATEGORIA, PRIORIDADE, DATAI, DATAF] );

  TJsonUtil.SalvarJson(AJson, NOMEARQUIVOJSON, True);
  ShellExecute(Handle, 'open', PChar(NOMEARQUIVOJSON), nil, nil, SW_SHOW);
  ModalResult := mrOk;
end;

procedure TfrmConfiguracao.ProximoControle(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    perform(WM_NEXTDLGCTL, 0,0 );
end;

function TfrmConfiguracao.getAGENTE: String;
begin
  Result := edtAgente.Text;
end;

function TfrmConfiguracao.getCATEGORIA: String;
begin
  Result := edtCategoria.Text;
end;

function TfrmConfiguracao.getDATAF: String;
begin
  Result := FormatDateTime('yyyy-mm-dd', edtDataFinal.DateTime);
end;

function TfrmConfiguracao.getDATAI: String;
begin
  Result := FormatDateTime('yyyy-mm-dd', edtDataInicial.DateTime);
end;

function TfrmConfiguracao.getID: String;
begin
  Result := edtIdProjeto.Text;
end;

function TfrmConfiguracao.getKey: String;
begin
  Result := edtKey.Text;
end;

function TfrmConfiguracao.getNOMEVERSAO: String;
begin
  Result := edtNomeVersao.Text;
end;

function TfrmConfiguracao.getPRIORIDADE: String;
begin
  Result := edtPrioridade.Text;
end;

function TfrmConfiguracao.getSTATUS: String;
begin
  Result := edtStatus.Text;
end;

function TfrmConfiguracao.getURL: String;
begin
  Result := edtURL.Text;
end;

function TfrmConfiguracao.getVERSAO: String;
begin
  Result := edtVersao.Text;
end;

end.
