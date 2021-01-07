unit uFrmPesqDepartamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainPesquisa, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView, FMX.TabControl, FMX.Layouts, uClasseDepartamento,
  FMX.ListBox, FMX.Edit, FMX.ScrollBox, FMX.Memo,
  u_Library;

type
  TFrmPesqDepartamento = class(TFrmMainPesquisa)
    mem_Descricao: TMemo;
    Label7: TLabel;
    edt_Nome: TEdit;
    Label10: TLabel;
    cbx_Status: TComboBox;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure rct_SalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesqDepartamento: TFrmPesqDepartamento;

implementation

{$R *.fmx}

procedure TFrmPesqDepartamento.FormCreate(Sender: TObject);
begin
  inherited;
 TDepartamento.new
    .PopulaListView(ListView1);
end;

procedure TFrmPesqDepartamento.rct_SalvarClick(Sender: TObject);
begin
  inherited;
    TDepartamento.new
        .Nome(edt_Nome.text)
        .Descricao(mem_Descricao.Lines.Text)
        .Status(cbx_Status.ItemIndex)
          .ValidaCampos
          .ValidaDepartamentoDB(codRegistro)
          .Gravar
          .PopulaListView(ListView1);

  TabControl1.TabIndex := 0;
end;

end.
