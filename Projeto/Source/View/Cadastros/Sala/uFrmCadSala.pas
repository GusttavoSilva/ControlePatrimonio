unit uFrmCadSala;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainCadastros, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView, FMX.TabControl, FMX.Layouts, uClasseSala, Form_Mensagem,
  u_Library, uClasseDepartamento, FMX.ListBox, FMX.Edit, FMX.ScrollBox, FMX.Memo,
  uFrmPesqDepartamento;

type
  TFrmCadSala = class(TFrmMainCadastros)
    mem_Descricao: TMemo;
    edt_Nome: TEdit;
    Label7: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    cbx_Status: TComboBox;
    edt_IdDepartamento: TEdit;
    Label9: TLabel;
    edt_NomeDepartamento: TEdit;
    Label11: TLabel;
    Image7: TImage;
    procedure rct_SalvarClick(Sender: TObject);
    procedure edt_IdDepartamentoChangeTracking(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure rct_ExcluirClick(Sender: TObject);
    procedure ValidaCampos;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadSala: TFrmCadSala;

implementation

{$R *.fmx}

uses uFrmPrincipal, uClassePatrimonio;

procedure TFrmCadSala.edt_IdDepartamentoChangeTracking(Sender: TObject);
begin
  inherited;

      if edt_IdDepartamento.Text <> '' then
    edt_NomeDepartamento.Text := TDepartamento.new.BuscarDepartamento(StrToInt(edt_IdDepartamento.Text))
  else
    edt_NomeDepartamento.Text := EmptyStr;
  if edt_NomeDepartamento.Text = '' then
    edt_IdDepartamento.Text := '0';

end;

procedure TFrmCadSala.FormCreate(Sender: TObject);
begin
  inherited;
  TSala.new.PopulaListview(ListView1);
end;

procedure TFrmCadSala.Image7Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqDepartamento) then
    FrmPesqDepartamento := TFrmPesqDepartamento.Create(Application);
  FrmPesqDepartamento.ShowModal;

  edt_IdDepartamento.Text := IntToStr(codBusca);
end;

procedure TFrmCadSala.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  List : TStringList;
begin
  inherited;
  List := TStringList.Create;
  try
   TSala
   .new
    .PopulaCampos(codRegistro, List);

    edt_Nome.Text := List[0];
    edt_IdDepartamento.Text := List[1];
    mem_Descricao.Lines.Add(List[2]);
    cbx_Status.ItemIndex := StrToInt(List[3]);

  finally
    FreeAndNil(List);
  end;
end;

procedure TFrmCadSala.rct_ExcluirClick(Sender: TObject);
begin
  inherited;
    TPatrimonio.new.VerificaRelacionamentoSQL('id_sala', codRegistro);
 TSala.new.delete(codRegistro)
 .PopulaListview(ListView1);

   TabControl1.TabIndex := 0;
   Acao := upView;
end;

procedure TFrmCadSala.rct_SalvarClick(Sender: TObject);
begin
  inherited;
  ValidaCampos;
  case Acao of
    upInsert:
      begin
        TSala.new.Sala(edt_Nome.Text).Descricao(mem_Descricao.Lines.Text)
          .IdDepartamento(StrToInt(edt_IdDepartamento.Text)).Status(cbx_Status.ItemIndex)
          .ValidaCampos.ValidaSalaDB(codRegistro).Gravar;

      end;
    upUpdate:
      begin
        TSala.new.Sala(edt_Nome.Text).Descricao(mem_Descricao.Lines.Text)
          .IdDepartamento(StrToInt(edt_IdDepartamento.Text)).Status(cbx_Status.ItemIndex)
          .ValidaCampos.ValidaSalaDB(codRegistro).Gravar;
      end;
    upView:
      Abort;
  end;
  TSala.new.PopulaListview(ListView1);

  TabControl1.TabIndex := 0;
  Acao := upView;
end;


procedure TFrmCadSala.ValidaCampos;
begin
if edt_IdDepartamento.Text.IsEmpty then
   edt_IdDepartamento.Text := '0';
end;

end.
