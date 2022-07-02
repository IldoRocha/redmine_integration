unit Importar;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TfrmImportar = class(TForm)
    edtCaminhoArquivo: TEdit;
    Button1: TButton;
    ListaTxt: TMemo;
    Button2: TButton;
    dlgImportar: TOpenDialog;
    Label1: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportar: TfrmImportar;

implementation

{$R *.dfm}

procedure TfrmImportar.Button1Click(Sender: TObject);
begin
  if dlgImportar.Execute then
  begin
    ListaTxt.Lines.LoadFromFile(dlgImportar.FileName);
    EdtCaminhoArquivo.Text := dlgImportar.FileName
  end;
end;

procedure TfrmImportar.Button2Click(Sender: TObject);
begin
  if ListaTxt.Lines.Count > 0 then
   ModalResult := mrOk;
end;

procedure TfrmImportar.Button3Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmImportar.Button4Click(Sender: TObject);
begin
  ListaTxt.Clear;
end;

end.
