unit uFrmCadPerfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainCadastros, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView, FMX.TabControl, FMX.Layouts, uClassePerfil, FMX.Edit,
  uFrmPesqCidade, u_Library, uClasseCidade;

type
  TFrmCadPerfil = class(TFrmMainCadastros)
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
    Label8: TLabel;
    Label9: TLabel;
    Label14: TLabel;
    Rectangle3: TRectangle;
    Label7: TLabel;
    img_logo: TImage;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure edt_IdCidadeChangeTracking(Sender: TObject);
    procedure rct_SalvarClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure img_logoClick(Sender: TObject);
    procedure edt_TelefoneExit(Sender: TObject);
    procedure edt_CpfCnpjExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPerfil: TFrmCadPerfil;

implementation

{$R *.fmx}

procedure TFrmCadPerfil.edt_CpfCnpjExit(Sender: TObject);
begin
  inherited;
 edt_CpfCnpj.Text := formacpfcnpj(edt_CpfCnpj.Text);
end;

procedure TFrmCadPerfil.edt_IdCidadeChangeTracking(Sender: TObject);
begin
  inherited;
  if edt_IdCidade.Text <> '' then
    edt_Cidade.Text := TCidade.new.BuscarCidade(StrToInt(edt_IdCidade.Text))
  else
    edt_Cidade.Text := EmptyStr;
  if edt_Cidade.Text = '' then
    edt_IdCidade.Text := EmptyStr;
end;

procedure TFrmCadPerfil.edt_TelefoneExit(Sender: TObject);
begin
  inherited;
   edt_Telefone.Text := formatelefone(edt_Telefone.Text);
end;

procedure TFrmCadPerfil.FormCreate(Sender: TObject);
begin
  inherited;
  lay_Deletar.Visible := false;
   TPerfil.new
  .PopulaListview(ListView1);


  if ListView1.Items.Count = 2 then
    Lay_Novo.Enabled:=false;

end;

procedure TFrmCadPerfil.Image7Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqCidade) then
    FrmPesqCidade := TFrmPesqCidade.Create(Application);
  FrmPesqCidade.ShowModal;

  edt_IdCidade.Text := IntToStr(codBusca);
end;

procedure TFrmCadPerfil.img_logoClick(Sender: TObject);
begin
  inherited;
    if OpenDialog.Execute then
    img_logo.Bitmap.LoadFromFile(OpenDialog.FileName);

    exit;
end;

procedure TFrmCadPerfil.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  List: TStringList;
begin
  inherited;
  List := TStringList.Create;
  try
    TPerfil
    .new
    .PopulaCampos(codRegistro, List);

    edt_Nome.Text := List[0];
    edt_CpfCnpj.Text := List[5];
    edt_Telefone.Text := List[1];
    edt_Endereco.Text := List[2];
    edt_Bairro.Text := List[3];
    edt_IdCidade.Text := List[4];

   TPerfil
    .new
    .RetornaImg(codRegistro, img_logo);

  finally
    FreeAndNil(List);
  end;

end;

procedure TFrmCadPerfil.rct_SalvarClick(Sender: TObject);
begin
  inherited;
  case Acao of
    upInsert:
      begin
        TPerfil
        .new
            .Nome(edt_Nome.Text)
            .Telefone(edt_Telefone.Text)
            .CpfCnpj(edt_CpfCnpj.Text)
            .Endereco(edt_Endereco.Text)
            .Bairro(edt_Bairro.Text)
            .IdCidade(StrToInt(edt_IdCidade.Text))
            .Logo(img_logo)
         .ValidarCampos
         .Gravar;

      end;
    upUpdate:
      begin
        TPerfil
        .new
            .Nome(edt_Nome.Text)
            .Telefone(edt_Telefone.Text)
            .CpfCnpj(edt_CpfCnpj.Text)
            .Endereco(edt_Endereco.Text)
            .Bairro(edt_Bairro.Text)
            .IdCidade(StrToInt(edt_IdCidade.Text))
            .Logo(img_logo)
        .ValidarCampos
        .Editar(codRegistro);
      end;
    upView:
      Abort;
  end;
  TPerfil
  .new
  .PopulaListview(ListView1);
  TabControl1.TabIndex := 0;
  Acao := upView;
end;


end.
