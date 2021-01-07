unit uFrmRelatFornecedores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainRelatorio, FMX.frxClass, FMX.Objects, FMX.Controls.Presentation,
  FMX.Layouts, DmRelatorios, uClasseRelatFornecedor, System.Math.Vectors,
  FMX.Controls3D, FMX.Layers3D, FMX.Edit, FMX.ListBox;

type
  TFrmRelatFornecedores = class(TFrmMainRelatorio)
    edt_Cidade: TEdit;
    img_BuscaCidade: TImage;
    edt_IdCidade: TEdit;
    lbl_TIDCidade: TLabel;
    lbl_TCidadeEstado: TLabel;
    edt_Nome: TEdit;
    lbl_TNome: TLabel;
    Layout3D1: TLayout3D;
    procedure rct_GerarClick(Sender: TObject);
    procedure cbx_TipoRelatorioChange(Sender: TObject);
    procedure edt_IdCidadeChangeTracking(Sender: TObject);
    procedure img_BuscaCidadeClick(Sender: TObject);

  private
    procedure ValidaCampos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatFornecedores: TFrmRelatFornecedores;

implementation

{$R *.fmx}

uses uClasseCidade, uFrmPesqCidade, u_Library;

procedure TFrmRelatFornecedores.cbx_TipoRelatorioChange(Sender: TObject);
begin
  inherited;
  case cbx_TipoRelatorio.ItemIndex of
    1:
      begin
        lbl_TIDCidade.Enabled := false;
        lbl_TCidadeEstado.Enabled := false;
        edt_Cidade.Enabled := false;
        edt_IdCidade.Enabled := false;
        img_BuscaCidade.Enabled := false;
        lbl_TNome.Enabled := false;
        edt_Nome.Enabled := false;
      end;
    2: // por Nome
      begin
        lbl_TIDCidade.Enabled := false;
        lbl_TCidadeEstado.Enabled := false;
        edt_Cidade.Enabled := false;
        edt_IdCidade.Enabled := false;
        img_BuscaCidade.Enabled := false;

        //
        lbl_TNome.Enabled := true;
        edt_Nome.Enabled := true;
      end;
    3: // por Cidade
      begin
        lbl_TNome.Enabled := false;
        edt_Nome.Enabled := false;

        //
        lbl_TIDCidade.Enabled := true;
        lbl_TCidadeEstado.Enabled := true;
        edt_Cidade.Enabled := true;
        edt_IdCidade.Enabled := true;
        img_BuscaCidade.Enabled := true;
      end;
  end;
end;

procedure TFrmRelatFornecedores.edt_IdCidadeChangeTracking(Sender: TObject);
begin
  inherited;
  if edt_IdCidade.Text <> '' then
    edt_Cidade.Text := TCidade.new.BuscarCidade(StrToInt(edt_IdCidade.Text))
  else
    edt_Cidade.Text := EmptyStr;
  if edt_Cidade.Text.IsEmpty then
    edt_IdCidade.Text := '0';
end;

procedure TFrmRelatFornecedores.img_BuscaCidadeClick(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqCidade) then
    FrmPesqCidade := TFrmPesqCidade.Create(Application);
  FrmPesqCidade.ShowModal;

  edt_IdCidade.Text := IntToStr(codBusca);
end;

procedure TFrmRelatFornecedores.rct_GerarClick(Sender: TObject);
begin
  inherited;
  ValidaCampos;
  TRelatFornecedor
  .mew
  .Nome(edt_Nome.Text)
  .TipoDeconsulta(cbx_TipoRelatorio.ItemIndex)
    .IDCidade(StrToInt(edt_IdCidade.Text))
    .Filter
    .FindAll
    .report(frxReport1);
end;

procedure TFrmRelatFornecedores.ValidaCampos;
begin
  if edt_IdCidade.Text.IsEmpty then
    edt_IdCidade.Text := '0';
end;

end.
