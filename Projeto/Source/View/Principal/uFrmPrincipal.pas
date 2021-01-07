unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ListBox, FMX.Effects, FMX.Ani, FMX.Objects, FMX.TabControl,
  uFrmCadUsuario, FMX.Edit, FMX.EditBox,
  uFrmCadPerfil, uFrmCadPatrimonio;

type
  TFrmPrincipal = class(TForm)
    FloatAnimation1: TFloatAnimation;
    Layout1: TLayout;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    RectAnimation1: TRectAnimation;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    lbl_NomeUsuario: TLabel;
    Image3: TImage;
    Layout5: TLayout;
    Rectangle15: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout18: TLayout;
    Layout19: TLayout;
    Rectangle16: TRectangle;
    ShadowEffect2: TShadowEffect;
    Label23: TLabel;
    Label25: TLabel;
    Layout20: TLayout;
    Image8: TImage;
    Layout21: TLayout;
    Image6: TImage;
    Image7: TImage;
    FloatAnimation2: TFloatAnimation;
    Layout6: TLayout;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    rct_Sair: TRectangle;
    rct_CadUsuario: TRectangle;
    Rectangle17: TRectangle;
    rct_Config: TRectangle;
    Rectangle19: TRectangle;
    Rectangle20: TRectangle;
    rct_Relatorios: TRectangle;
    Rectangle23: TRectangle;
    tab_Conteiner: TTabControl;
    TabItem1: TTabItem;
    Layout7: TLayout;
    Layout8: TLayout;
    Rectangle7: TRectangle;
    Layout10: TLayout;
    Rectangle9: TRectangle;
    Layout11: TLayout;
    Rectangle12: TRectangle;
    Layout12: TLayout;
    Rectangle10: TRectangle;
    Label18: TLabel;
    Layout15: TLayout;
    Layout16: TLayout;
    Rectangle13: TRectangle;
    Label24: TLabel;
    Layout17: TLayout;
    Rectangle14: TRectangle;
    TabItem2: TTabItem;
    lay_Center: TLayout;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Image4: TImage;
    Image5: TImage;
    Image10: TImage;
    Layout9: TLayout;
    Rectangle6: TRectangle;
    rct_Cadastro: TRectangle;
    Label1: TLabel;
    Image9: TImage;
    lbl_Dia: TLabel;
    lbl_Hora: TLabel;
    Timer1: TTimer;
    Rectangle11: TRectangle;
    Label2: TLabel;
    rct_Perfil: TRectangle;
    Label3: TLabel;
    Rectangle8: TRectangle;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure rct_CadUsuarioClick(Sender: TObject);
    procedure rct_SairClick(Sender: TObject);
    procedure Rectangle5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Rectangle23Click(Sender: TObject);
    procedure Rectangle19Click(Sender: TObject);
    procedure Rectangle11Click(Sender: TObject);
    procedure rct_PerfilClick(Sender: TObject);
    procedure Rectangle20Click(Sender: TObject);
    procedure Rectangle17Click(Sender: TObject);
    procedure Rectangle8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses u_Library, Form_Mensagem, uFrmCadDepartamento, uFrmCadSala,
  uFrmCadFornecedor, uFrmRelatFornecedores, uFrmRelatPatrimonio,
  uFrmCadTipoPatrimonio;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Timer1.Enabled := true;
  lbl_Dia.text := DiaSemana(now);
  Acao := upView;
  tab_Conteiner.TabIndex := 0;
  lbl_NomeUsuario.text := 'Bem Vindo!' + sLineBreak + NomeUsuario;
end;

procedure TFrmPrincipal.rct_CadUsuarioClick(Sender: TObject);
begin
  tab_Conteiner.TabIndex := 1;
  FormOpen(lay_Center, TFrmCadUsuarios);
end;

procedure TFrmPrincipal.rct_PerfilClick(Sender: TObject);
begin
  tab_Conteiner.TabIndex := 1;
  FormOpen(lay_Center, TFrmCadPerfil);
end;

procedure TFrmPrincipal.rct_SairClick(Sender: TObject);
begin

  if Acao <> upView then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro',
      'Não é possivel sair da tela em modo de edição.' + sLineBreak +
      'Para sair, primeiro cancele ou salve as alterações!', 'OK', '',
      $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end
  else
  begin
    Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Cancelamento',
      'Deseja sair do sistema?', 'Sim', 'Não', $FF3C7F04, $FFDF5447);
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

procedure TFrmPrincipal.Rectangle11Click(Sender: TObject);
begin
  tab_Conteiner.TabIndex := 1;
  FormOpen(lay_Center, TFrmRelatFornecedores);
end;

procedure TFrmPrincipal.Rectangle17Click(Sender: TObject);
begin
  tab_Conteiner.TabIndex := 1;
  FormOpen(lay_Center, TFrmRelatPatrimonio);
end;

procedure TFrmPrincipal.Rectangle19Click(Sender: TObject);
begin
  tab_Conteiner.TabIndex := 1;
  FormOpen(lay_Center, TFrmCadFornecedor);
end;

procedure TFrmPrincipal.Rectangle20Click(Sender: TObject);
begin
  tab_Conteiner.TabIndex := 1;
  FormOpen(lay_Center, TFrmCadPatrimonio);
end;

procedure TFrmPrincipal.Rectangle23Click(Sender: TObject);
begin
  tab_Conteiner.TabIndex := 1;
  FormOpen(lay_Center, TFrmCadSala);
end;

procedure TFrmPrincipal.Rectangle5Click(Sender: TObject);
begin
  tab_Conteiner.TabIndex := 1;
  FormOpen(lay_Center, TFrmCadDepartamento);
end;

procedure TFrmPrincipal.Rectangle8Click(Sender: TObject);
begin
  tab_Conteiner.TabIndex := 1;
  FormOpen(lay_Center, TFrmCadTipoPatrimonio);
end;

procedure TFrmPrincipal.Timer1Timer(Sender: TObject);
begin
  lbl_Hora.text := FormatDateTime('HH:MM:SS', now);
end;

end.
