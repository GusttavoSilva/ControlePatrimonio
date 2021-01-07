unit uFrmRelatPatrimonio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainRelatorio, FMX.frxClass, FMX.ListBox, FMX.Objects,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Edit,

  uClasseFornecedor, uClasseSala, uClasseTipoPatrimonio, uFrmPesqFornecedor,
  uFrmPesqSalas, uFrmPesqTipoPatrimonio, uClasseDepartamento,
  uFrmPesqDepartamento;

type
  TFrmRelatPatrimonio = class(TFrmMainRelatorio)
    edt_NumeroPlaca: TEdit;
    Label9: TLabel;
    cbx_Status: TComboBox;
    Label8: TLabel;
    cbx_EstadoFisico: TComboBox;
    Label20: TLabel;
    edt_Fornecedor: TEdit;
    Label16: TLabel;
    Image8: TImage;
    edt_IdFornecedor: TEdit;
    Label17: TLabel;
    edt_IdTipoPatrimonio: TEdit;
    Label15: TLabel;
    Image1: TImage;
    edt_TipoPatrimonio: TEdit;
    Label14: TLabel;
    edt_Sala: TEdit;
    Label12: TLabel;
    Image7: TImage;
    edt_IdSala: TEdit;
    Label13: TLabel;
    edt_IdDepartamento: TEdit;
    Image3: TImage;
    edt_NomeDepartamento: TEdit;
    Label11: TLabel;
    Label2: TLabel;
    ck_ComValor: TCheckBox;
    frxReport2: TfrxReport;
    procedure rct_GerarClick(Sender: TObject);
    procedure edt_IdSalaChangeTracking(Sender: TObject);
    procedure edt_IdTipoPatrimonioChangeTracking(Sender: TObject);
    procedure edt_IdFornecedorChangeTracking(Sender: TObject);
    procedure edt_IdDepartamentoChangeTracking(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ValidaEdit;
  public
    { Public declarations }
  end;

var
  FrmRelatPatrimonio: TFrmRelatPatrimonio;

implementation

{$R *.fmx}

uses u_Library, uClasseRelatPatrimonio;

procedure TFrmRelatPatrimonio.edt_IdDepartamentoChangeTracking(Sender: TObject);
begin
  inherited;
  if edt_IdDepartamento.Text <> '' then
    edt_NomeDepartamento.Text := TDepartamento.new.BuscarDepartamento
      (StrToInt(edt_IdDepartamento.Text))
  else
    edt_NomeDepartamento.Text := EmptyStr;
  if edt_NomeDepartamento.Text = '' then
    edt_IdDepartamento.Text := '0';
end;

procedure TFrmRelatPatrimonio.edt_IdFornecedorChangeTracking(Sender: TObject);
begin
  inherited;
  if edt_IdFornecedor.Text <> '' then
    edt_Fornecedor.Text := TForncedor.new.BuscarFornecedor
      (StrToInt(edt_IdFornecedor.Text))
  else
    edt_Fornecedor.Text := EmptyStr;
  if edt_Fornecedor.Text = '' then
    edt_IdFornecedor.Text := '0';
end;

procedure TFrmRelatPatrimonio.edt_IdSalaChangeTracking(Sender: TObject);
begin
  inherited;
  if edt_IdSala.Text <> '' then
    edt_Sala.Text := TSala.new.BuscarSala(StrToInt(edt_IdSala.Text))
  else
    edt_Sala.Text := EmptyStr;
  if edt_Sala.Text = '' then
    edt_IdSala.Text := '0';
end;

procedure TFrmRelatPatrimonio.edt_IdTipoPatrimonioChangeTracking
  (Sender: TObject);
begin
  inherited;
  if edt_IdTipoPatrimonio.Text <> '' then
    edt_TipoPatrimonio.Text := TTipoPatrimonio.new.BuscarPatrimonio
      (StrToInt(edt_IdTipoPatrimonio.Text))
  else
    edt_TipoPatrimonio.Text := EmptyStr;
  if edt_TipoPatrimonio.Text = '' then
    edt_IdTipoPatrimonio.Text := '0';

end;

procedure TFrmRelatPatrimonio.FormCreate(Sender: TObject);
begin
  inherited;
  cbx_TipoRelatorio.Visible := false;
end;

procedure TFrmRelatPatrimonio.Image1Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqTipoPatrimonio) then
    FrmPesqTipoPatrimonio := TFrmPesqTipoPatrimonio.Create(Application);
  FrmPesqTipoPatrimonio.ShowModal;

  edt_IdTipoPatrimonio.Text := IntToStr(codBusca);
end;

procedure TFrmRelatPatrimonio.Image3Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqDepartamento) then
    FrmPesqDepartamento := TFrmPesqDepartamento.Create(Application);
  FrmPesqDepartamento.ShowModal;

  edt_IdDepartamento.Text := IntToStr(codBusca);
end;

procedure TFrmRelatPatrimonio.Image7Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqSalas) then
    FrmPesqSalas := TFrmPesqSalas.Create(Application);
  FrmPesqSalas.ShowModal;

  edt_IdSala.Text := IntToStr(codBusca);
end;

procedure TFrmRelatPatrimonio.Image8Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqFornecedor) then
    FrmPesqFornecedor := TFrmPesqFornecedor.Create(Application);
  FrmPesqFornecedor.ShowModal;

  edt_IdFornecedor.Text := IntToStr(codBusca);
end;

procedure TFrmRelatPatrimonio.rct_GerarClick(Sender: TObject);
var
  Relatorio: TfrxReport;
begin
  inherited;
  if ck_ComValor.IsChecked then
    Relatorio := frxReport1
  else
    Relatorio := frxReport2;

  ValidaEdit;
  TRelatPatrimonio.mew.NumeroPlaca(StrToInt(edt_NumeroPlaca.Text))
    .Status(cbx_Status.ItemIndex).IdSala(StrToInt(edt_IdSala.Text))
    .IdDepartamento(StrToInt(edt_IdDepartamento.Text))
    .IdTipoPatrimonio(StrToInt(edt_IdTipoPatrimonio.Text))
    .EstadoFisico(cbx_EstadoFisico.ItemIndex)
    .IdFornecedor(StrToInt(edt_IdFornecedor.Text)).Filter.FindAll.report
    (Relatorio);

end;

procedure TFrmRelatPatrimonio.ValidaEdit;
begin
  if edt_NumeroPlaca.Text.IsEmpty then
  begin
    edt_NumeroPlaca.Text := '0';
  end;

  if edt_IdSala.Text.IsEmpty then
  begin
    edt_IdSala.Text := '0';
  end;

  if edt_IdTipoPatrimonio.Text.IsEmpty then
  begin
    edt_IdTipoPatrimonio.Text := '0';
  end;

  if edt_IdFornecedor.Text.IsEmpty then
  begin
    edt_IdFornecedor.Text := '0';
  end;

  if edt_IdDepartamento.Text.IsEmpty then
  begin
    edt_IdDepartamento.Text := '0';
  end;
end;

end.
