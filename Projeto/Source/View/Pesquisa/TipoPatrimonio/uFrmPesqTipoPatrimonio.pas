unit uFrmPesqTipoPatrimonio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainPesquisa, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView, FMX.TabControl, FMX.Layouts, uClasseTipoPatrimonio, FMX.Edit,
  u_Library;

type
  TFrmPesqTipoPatrimonio = class(TFrmMainPesquisa)
    edt_Nome: TEdit;
    Label10: TLabel;
    procedure rct_SalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesqTipoPatrimonio: TFrmPesqTipoPatrimonio;

implementation

{$R *.fmx}

procedure TFrmPesqTipoPatrimonio.FormCreate(Sender: TObject);
begin
  inherited;
 TTipoPatrimonio.new
    .PopulaListView(ListView1);
end;

procedure TFrmPesqTipoPatrimonio.rct_SalvarClick(Sender: TObject);
begin
  inherited;
  TTipoPatrimonio.new
        .Nome(edt_Nome.text)
          .ValidaCampos
          .ValidaPatrimonioDB(codRegistro)
          .Gravar
          .PopulaListView(ListView1);

  TabControl1.TabIndex := 0;
end;

end.
