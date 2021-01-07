unit uFrmCadUsuario;

interface

uses uFrmMainCadastros, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView, FMX.Controls, FMX.TabControl, FMX.Types,
  FMX.Layouts,  u_Library, FMX.Edit, FMX.ListView.Types, System.Classes,
  System.SysUtils, FMX.ListBox, uFrmPesqDepartamento,
  uClasseUsuario,
  uClasseDepartamento, FMX.Dialogs;

type
  TFrmCadUsuarios = class(TFrmMainCadastros)
    edt_Nome: TEdit;
    edt_Usuario: TEdit;
    edt_Senha: TEdit;
    edt_ValidaSenha: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cbx_Status: TComboBox;
    Label11: TLabel;
    procedure rct_SalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rct_ExcluirClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure rct_EditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadUsuarios: TFrmCadUsuarios;

implementation

{$R *.fmx}

uses Form_Mensagem, uFrmPrincipal, FMX.Forms;

procedure TFrmCadUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
   TUsuario
    .new
    .PopulaListview(ListView1);
end;

procedure TFrmCadUsuarios.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  List : TStringList;
begin
  inherited;

  List := TStringList.Create;
  try
   TUsuario
   .new
    .PopulaCampos(codRegistro, List);

    edt_Nome.Text := List[0];
    edt_Usuario.Text := List[1];
    edt_Senha.Text:= List[2];
    edt_ValidaSenha.Text:= List[2];
    cbx_Status.ItemIndex :=StrToInt(List[3]);
  finally
    FreeAndNil(List);
  end;

end;

procedure TFrmCadUsuarios.rct_EditarClick(Sender: TObject);
begin
  inherited;
  edt_Usuario.Enabled := false;

end;

procedure TFrmCadUsuarios.rct_ExcluirClick(Sender: TObject);
begin
  inherited;
   TUsuario
   .new
  .delete(codRegistro)
  .PopulaListview(ListView1);

   TabControl1.TabIndex := 0;
   Acao := upView;
end;

procedure TFrmCadUsuarios.rct_SalvarClick(Sender: TObject);
begin
  inherited;
  case Acao of
    upInsert:
      begin
        TUsuario
        .new
        .Nome(edt_Nome.text)
        .Usuario(edt_Usuario.text)
        .Senha(edt_Senha.text)
        .ValidaSenha(edt_ValidaSenha.text)
        .Status(cbx_Status.ItemIndex)
          .ValidarCampos
          .VerificarUsuarioDB(codRegistro)
          .Gravar;

      end;
    upUpdate:
      begin

         TUsuario
        .new
        .Nome(edt_Nome.text)
        .Senha(edt_Senha.text)
        .ValidaSenha(edt_ValidaSenha.text)
        .Status(cbx_Status.ItemIndex)
          .ValidarCampos
          .VerificarUsuarioDB(codRegistro)
          .Editar(codRegistro);
      end;
     upView :
       Abort;
  end;
  TUsuario
  .new
  .PopulaListview(ListView1);
  TabControl1.TabIndex := 0;
  Acao := upView;
end;

end.
