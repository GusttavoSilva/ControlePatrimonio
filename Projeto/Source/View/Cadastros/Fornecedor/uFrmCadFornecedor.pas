unit uFrmCadFornecedor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainCadastros, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView, FMX.TabControl, FMX.Layouts, uFrmPesqCidade, FMX.Edit, u_Library,
  uClasseCidade, Form_Mensagem, uClasseFornecedor;

type
  TFrmCadFornecedor = class(TFrmMainCadastros)
    edt_Nome: TEdit;
    Label10: TLabel;
    Label9: TLabel;
    edt_IdCidade: TEdit;
    Image7: TImage;
    edt_Cidade: TEdit;
    Label11: TLabel;
    edt_Telefone: TEdit;
    Label7: TLabel;
    edt_CpfCnpj: TEdit;
    Label8: TLabel;
    edt_Endereco: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    edt_Bairros: TEdit;
    procedure Image7Click(Sender: TObject);
    procedure edt_IdCidadeChangeTracking(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rct_SalvarClick(Sender: TObject);
    procedure rct_ExcluirClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);

    procedure ValidaCampos;
    procedure edt_CpfCnpjExit(Sender: TObject);
    procedure edt_TelefoneExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadFornecedor: TFrmCadFornecedor;

implementation

{$R *.fmx}

uses uClassePatrimonio;

procedure TFrmCadFornecedor.edt_CpfCnpjExit(Sender: TObject);
begin
  inherited;
edt_CpfCnpj.Text := formacpfcnpj(edt_CpfCnpj.Text);
end;

procedure TFrmCadFornecedor.edt_IdCidadeChangeTracking(Sender: TObject);
begin
  inherited;

  if edt_IdCidade.Text <> '' then
    edt_Cidade.Text := TCidade.new.BuscarCidade(StrToInt(edt_IdCidade.Text))
  else
    edt_Cidade.Text := EmptyStr;
  if edt_Cidade.Text.IsEmpty then
    edt_IdCidade.Text := '0';
end;

procedure TFrmCadFornecedor.edt_TelefoneExit(Sender: TObject);
begin
  inherited;
 edt_Telefone.Text := formatelefone(edt_Telefone.Text);
end;

procedure TFrmCadFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
 TForncedor
  .new
  .PopulaListview(ListView1);
end;

procedure TFrmCadFornecedor.Image7Click(Sender: TObject);
begin
  inherited;
 if not assigned(FrmPesqCidade) then
    FrmPesqCidade := TFrmPesqCidade.Create(Application);
  FrmPesqCidade.ShowModal;

  edt_IdCidade.Text := IntToStr(codBusca);
end;

procedure TFrmCadFornecedor.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  List : TStringList;
begin
  inherited;

  List := TStringList.Create;
  try
   TForncedor
   .new
    .PopulaCampos(codRegistro, List);

    edt_Nome.Text := List[0];
    edt_CpfCnpj.Text:= List[1];
    edt_Telefone.Text := List[2];
    edt_Endereco.Text:= List[3];
    edt_Bairros.Text :=List[4];
    edt_IdCidade.Text :=List[5];
  finally
    FreeAndNil(List);
  end;

end;

procedure TFrmCadFornecedor.rct_ExcluirClick(Sender: TObject);
begin
  inherited;
    TPatrimonio.new.VerificaRelacionamentoSQL('id_fornecedor', codRegistro);
   TForncedor
   .new
  .delete(codRegistro)
  .PopulaListview(ListView1);

   TabControl1.TabIndex := 0;
   Acao := upView;
end;

procedure TFrmCadFornecedor.rct_SalvarClick(Sender: TObject);
begin
  inherited;
  ValidaCampos;
case Acao of
    upInsert:
      begin
        TForncedor
        .new
        .Nome(edt_Nome.text)
        .Telefone(edt_Telefone.text)
        .CpfCnpj(edt_CpfCnpj.text)
        .Endereco(edt_Endereco.text)
        .Bairro(edt_Bairros.text)
        .IdCidade(StrToInt(edt_IdCidade.Text))
           .ValidarCampos
          .Gravar;

      end;
    upUpdate:
      begin
         TForncedor
        .new
        .Nome(edt_Nome.text)
        .Telefone(edt_Telefone.text)
        .CpfCnpj(edt_CpfCnpj.text)
        .Endereco(edt_Endereco.text)
        .Bairro(edt_Bairros.Text)
        .IdCidade(StrToInt(edt_IdCidade.Text))
          .ValidarCampos
          .Editar(codRegistro);
      end;
     upView :
       Abort;
  end;
  TForncedor
  .new
  .PopulaListview(ListView1);
  TabControl1.TabIndex := 0;
  Acao := upView;
end;

procedure TFrmCadFornecedor.ValidaCampos;
begin
  if edt_IdCidade.Text.IsEmpty then
    edt_IdCidade.Text := '0';
end;

end.
