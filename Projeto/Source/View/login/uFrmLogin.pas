unit uFrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  uClasseUsuario, FMX.Objects, FMX.Layouts;

type
  TFrmLogin = class(TForm)
    Layout1: TLayout;
    Rectangle3: TRectangle;
    Label3: TLabel;
    Layout2: TLayout;
    Layout5: TLayout;
    rct_Entrar: TRectangle;
    Label4: TLabel;
    Layout6: TLayout;
    Rectangle5: TRectangle;
    Label5: TLabel;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout4: TLayout;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    edt_Usuario: TEdit;
    edt_Senha: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure rct_EntrarClick(Sender: TObject);
    procedure Rectangle5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses uFrmPrincipal, Form_Mensagem, u_Library;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  Acao :=upView;
  edt_Usuario.SetFocus;
end;

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then
    rct_EntrarClick(self);
end;

procedure TFrmLogin.rct_EntrarClick(Sender: TObject);
begin
  Tusuario
    .new
      .Usuario(edt_Usuario.Text)
      .Senha(edt_Senha.Text)
    .ValidaLogin;

  FrmLogin.Visible := false;

  if not assigned(FrmPrincipal) then
    FrmPrincipal := TFrmPrincipal.Create(Application);
  FrmPrincipal.Show;
end;

procedure TFrmLogin.Rectangle5Click(Sender: TObject);
begin
  if Acao <> upView then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Não é possivel sair da tela em modo de edição.' + sLineBreak +
      'Para sair, primeiro cancele ou salve as alterações!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end
  else
  begin

    Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Cancelamento', 'Deseja sair do sistema?', 'Sim', 'Não', $FF3C7F04,
      $FFDF5447);
    Frm_Mensagem.ShowModal(
      procedure(ModalResult: TModalResult)
      begin
        if Frm_Mensagem.retorno = '1' then
        begin
          Application.Terminate;
        end;
      end);

    abort;
  end;
end;

end.
