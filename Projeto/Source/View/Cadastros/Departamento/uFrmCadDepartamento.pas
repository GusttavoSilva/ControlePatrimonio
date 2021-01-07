unit uFrmCadDepartamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainCadastros, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView, FMX.TabControl, FMX.Layouts, uClasseDepartamento,
  FMX.ScrollBox, FMX.Memo, FMX.ListBox, FMX.Edit,
  u_Library, FMX.Colors, uFrmCadUsuario;

type
  TFrmCadDepartamento = class(TFrmMainCadastros)
    Label7: TLabel;
    edt_Nome: TEdit;
    Label10: TLabel;
    cbx_Status: TComboBox;
    Label8: TLabel;
    mem_Descricao: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure rct_SalvarClick(Sender: TObject);
    procedure rct_ExcluirClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadDepartamento: TFrmCadDepartamento;

implementation

{$R *.fmx}

uses Form_Mensagem, uFrmPrincipal;

procedure TFrmCadDepartamento.FormCreate(Sender: TObject);
begin
  inherited;
  TDepartamento.new.PopulaListview(ListView1);
end;

procedure TFrmCadDepartamento.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  List: TStringList;
begin
  inherited;

  List := TStringList.Create;
  try
    TDepartamento.new.PopulaCampos(codRegistro, List);

    edt_Nome.Text := List[0];
    mem_Descricao.Lines.Text := List[1];
    cbx_Status.ItemIndex := StrToInt(List[2]);
  finally
    FreeAndNil(List);
  end;
end;

procedure TFrmCadDepartamento.rct_ExcluirClick(Sender: TObject);
begin
  inherited;
  TDepartamento.new.ID(codRegistro).VerificaExisteSalaSQL;
  TDepartamento.new.delete(codRegistro).PopulaListview(ListView1);

  TabControl1.TabIndex := 0;
  Acao := upView;
end;

procedure TFrmCadDepartamento.rct_SalvarClick(Sender: TObject);
begin
  inherited;
  case Acao of
    upInsert:
      begin
        TDepartamento.new.Nome(edt_Nome.Text)
          .Descricao(mem_Descricao.Lines.Text).Status(cbx_Status.ItemIndex)
          .ValidaCampos.ValidaDepartamentoDB(codRegistro).Gravar;

      end;
    upUpdate:
      begin

        TDepartamento.new.Nome(edt_Nome.Text)
          .Descricao(mem_Descricao.Lines.Text).Status(cbx_Status.ItemIndex)
          .ValidaCampos.ValidaDepartamentoDB(codRegistro).Editar(codRegistro);
      end;
    upView:
      Abort;
  end;
  TDepartamento.new.PopulaListview(ListView1);

  TabControl1.TabIndex := 0;
  Acao := upView;
end;

end.
