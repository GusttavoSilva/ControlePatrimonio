unit uFrmPesqSalas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainPesquisa, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView, FMX.TabControl, FMX.Layouts, uClasseSala, FMX.ListBox, FMX.Edit,
  FMX.ScrollBox, FMX.Memo, u_Library;

type
  TFrmPesqSalas = class(TFrmMainPesquisa)
    mem_Descricao: TMemo;
    Label7: TLabel;
    edt_IdDepartamento: TEdit;
    Label9: TLabel;
    edt_NomeDepartamento: TEdit;
    Image7: TImage;
    Label11: TLabel;
    edt_Nome: TEdit;
    cbx_Status: TComboBox;
    Label8: TLabel;
    Label10: TLabel;
    procedure rct_SalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure edt_IdDepartamentoChangeTracking(Sender: TObject);
    procedure ValidaCampos;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesqSalas: TFrmPesqSalas;

implementation

{$R *.fmx}

uses uClasseDepartamento, uFrmPesqDepartamento;

procedure TFrmPesqSalas.edt_IdDepartamentoChangeTracking(Sender: TObject);
begin
  inherited;
  if edt_IdDepartamento.Text <> '' then
    edt_NomeDepartamento.Text := TDepartamento.new.BuscarDepartamento(StrToInt(edt_IdDepartamento.Text))
  else
    edt_NomeDepartamento.Text := EmptyStr;
  if edt_NomeDepartamento.Text.IsEmpty then
    edt_IdDepartamento.Text := EmptyStr;

end;

procedure TFrmPesqSalas.FormCreate(Sender: TObject);
begin
  inherited;
  TSala.new.PopulaListView(ListView1);
end;

procedure TFrmPesqSalas.Image7Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqDepartamento) then
    FrmPesqDepartamento := TFrmPesqDepartamento.Create(Application);
  FrmPesqDepartamento.ShowModal;

  edt_IdDepartamento.Text := IntToStr(codBusca);
end;

procedure TFrmPesqSalas.rct_SalvarClick(Sender: TObject);
begin
  inherited;
  ValidaCampos;
  TSala.new.Sala(edt_Nome.Text).Descricao(mem_Descricao.Lines.Text).IdDepartamento(StrToInt(edt_IdDepartamento.Text))
    .Status(cbx_Status.ItemIndex).ValidaCampos.ValidaSalaDB(codRegistro).Gravar.PopulaListView(ListView1);
  TabControl1.TabIndex := 0;
end;

procedure TFrmPesqSalas.ValidaCampos;
begin
  if edt_IdDepartamento.Text.IsEmpty then
    edt_IdDepartamento.Text := '0';
end;

end.
