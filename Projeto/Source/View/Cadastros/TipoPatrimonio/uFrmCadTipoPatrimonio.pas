unit uFrmCadTipoPatrimonio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainCadastros, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FMX.Edit;

type
  TFrmCadTipoPatrimonio = class(TFrmMainCadastros)
    edt_Nome: TEdit;
    Label10: TLabel;
    procedure rct_SalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure rct_ExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadTipoPatrimonio: TFrmCadTipoPatrimonio;

implementation

{$R *.fmx}

uses uClasseTipoPatrimonio, u_Library, uClassePatrimonio;

procedure TFrmCadTipoPatrimonio.FormCreate(Sender: TObject);
begin
  inherited;
  TTipoPatrimonio.new.PopulaListView(ListView1);
end;

procedure TFrmCadTipoPatrimonio.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  edt_Nome.Text := TTipoPatrimonio.new.BuscarPatrimonio(codRegistro);
end;

procedure TFrmCadTipoPatrimonio.rct_ExcluirClick(Sender: TObject);
begin
  inherited;
  TPatrimonio.new.VerificaRelacionamentoSQL('id_tipo_patrimonio', codRegistro );
  TTipoPatrimonio.new.delete(codRegistro).PopulaListView(ListView1);

  TabControl1.TabIndex := 0;
  Acao := upView;
end;

procedure TFrmCadTipoPatrimonio.rct_SalvarClick(Sender: TObject);
begin
  inherited;

  case Acao of
    upInsert:
      begin
        TTipoPatrimonio.new.Nome(edt_Nome.Text).ValidaCampos.ValidaPatrimonioDB
          (codRegistro).Gravar

      end;
    upUpdate:
      begin
        TTipoPatrimonio.new.Nome(edt_Nome.Text).ValidaCampos.ValidaPatrimonioDB
          (codRegistro).editar(codRegistro);
      end;
    upView:
      Abort;
  end;
  TTipoPatrimonio.new.PopulaListView(ListView1);

  TabControl1.TabIndex := 0;
  Acao := upView;

end;

end.
