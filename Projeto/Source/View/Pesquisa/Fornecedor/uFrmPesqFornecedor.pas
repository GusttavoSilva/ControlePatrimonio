unit uFrmPesqFornecedor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainPesquisa, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.TabControl, FMX.Objects,
  FMX.Controls.Presentation, FMX.Layouts, uClasseFornecedor, FMX.Edit;

type
  TFrmPesqFornecedor = class(TFrmMainPesquisa)
    edt_Bairro: TEdit;
    edt_Cidade: TEdit;
    edt_CpfCnpj: TEdit;
    edt_Endereco: TEdit;
    edt_IdCidade: TEdit;
    edt_Nome: TEdit;
    edt_Telefone: TEdit;
    Image7: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure rct_SalvarClick(Sender: TObject);
    procedure ValidaCampos;
    procedure FormCreate(Sender: TObject);
    procedure edt_IdCidadeChangeTracking(Sender: TObject);
    procedure Image7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesqFornecedor: TFrmPesqFornecedor;

implementation

{$R *.fmx}

uses uClasseCidade, uFrmPesqCidade, u_Library;

procedure TFrmPesqFornecedor.edt_IdCidadeChangeTracking(Sender: TObject);
begin
  inherited;

  if edt_IdCidade.Text <> '' then
    edt_Cidade.Text := TCidade.new.BuscarCidade(StrToInt(edt_IdCidade.Text))
  else
    edt_Cidade.Text := EmptyStr;
  if edt_Cidade.Text.IsEmpty then
    edt_IdCidade.Text := '0';
end;

procedure TFrmPesqFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
   TForncedor.new.PopulaListView(ListView1);
end;

procedure TFrmPesqFornecedor.Image7Click(Sender: TObject);
begin
  inherited;
   if not assigned(FrmPesqCidade) then
    FrmPesqCidade := TFrmPesqCidade.Create(Application);
  FrmPesqCidade.ShowModal;

  edt_IdCidade.Text := IntToStr(codBusca);
end;

procedure TFrmPesqFornecedor.rct_SalvarClick(Sender: TObject);
begin
  inherited;
  ValidaCampos;
 TForncedor
        .new
        .Nome(edt_Nome.text)
        .Telefone(edt_Telefone.text)
        .CpfCnpj(edt_CpfCnpj.text)
        .Endereco(edt_Endereco.text)
        .Bairro(edt_Bairro.text)
        .IdCidade(StrToInt(edt_IdCidade.Text))
          .ValidarCampos
          .Gravar
          .PopulaListView(ListView1);
       TabControl1.TabIndex := 0;
end;

procedure TFrmPesqFornecedor.ValidaCampos;
begin
  if edt_IdCidade.Text.IsEmpty then
    edt_IdCidade.Text := '0';
end;

end.
