unit uFrmPesqCidade;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainPesquisa, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.TabControl, FMX.Objects,
  FMX.Controls.Presentation, FMX.Layouts, uClasseCidade;

type
  TFrmPesqCidade = class(TFrmMainPesquisa)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesqCidade: TFrmPesqCidade;

implementation

{$R *.fmx}

procedure TFrmPesqCidade.FormCreate(Sender: TObject);
begin
  inherited;
  rct_Novo.Visible := false;
  TCidade.new.PopulaListView(ListView1);
end;


end.
