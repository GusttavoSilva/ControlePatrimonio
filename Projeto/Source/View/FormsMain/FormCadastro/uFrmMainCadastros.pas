unit uFrmMainCadastros;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.ListView,
  FMX.TabControl, FMX.Layouts, u_Library, Form_Mensagem;

type
  TFrmMainCadastros = class(TForm)
    lay_Principal: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Layout1: TLayout;
    Layout3: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    ListView1: TListView;
    TabItem2: TTabItem;
    lay_Top: TLayout;
    Rectangle1: TRectangle;
    lbl_NomeForm: TLabel;
    img_Fechar: TImage;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    Lay_Novo: TLayout;
    rct_Novo: TRectangle;
    Label1: TLabel;
    Image2: TImage;
    Layout4: TLayout;
    Rectangle4: TRectangle;
    lay_Editar: TLayout;
    rct_Editar: TRectangle;
    Label2: TLabel;
    Image3: TImage;
    lay_Deletar: TLayout;
    rct_Excluir: TRectangle;
    Label3: TLabel;
    Image4: TImage;
    lay_Salvar: TLayout;
    rct_Salvar: TRectangle;
    Label4: TLabel;
    Image5: TImage;
    Layout7: TLayout;
    Label5: TLabel;
    Layout8: TLayout;
    rct_Cancelar: TRectangle;
    Label6: TLabel;
    Image6: TImage;
    procedure FormCreate(Sender: TObject);
    procedure rct_NovoClick(Sender: TObject);
    procedure rct_EditarClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure img_FecharClick(Sender: TObject);
    procedure rct_CancelarClick(Sender: TObject);
    procedure rct_ExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }

  end;

var
  FrmMainCadastros: TFrmMainCadastros;

implementation

{$R *.fmx}

uses uFrmPrincipal;

procedure TFrmMainCadastros.FormCreate(Sender: TObject);
begin
  TabControl1.TabPosition := TTabPosition.None;
  ListViewSearch(ListView1);
  lbl_NomeForm.Text := Self.Caption;
  acao := upView;
  TabControl1.TabIndex := 0;
end;

procedure TFrmMainCadastros.FormShow(Sender: TObject);
begin
FormCreate(self);
end;

procedure TFrmMainCadastros.img_FecharClick(Sender: TObject);
begin
  if acao <> upView then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Não é possivel sair da tela em modo de edição.' + sLineBreak +
      'Para sair, primeiro cancele ou salve as alterações!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end
  else
  begin
    FrmPrincipal.tab_Conteiner.TabIndex := 0;
    TabControl1.TabIndex := 0;
    close;
  end;
end;

procedure TFrmMainCadastros.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  txt: TListItemText;
begin
  with AItem do
  begin
    txt := TListItemText(Objects.FindDrawable('ID'));
    codRegistro := txt.TagString.ToInteger;

    acao := upView;
    LimpaCampos(Self);
    DesabilitaCampo(Self);
    TabControl1.TabIndex := 1;

  end

end;

procedure TFrmMainCadastros.rct_CancelarClick(Sender: TObject);
begin
  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'CANCELAR', 'Deseja cancelar?', 'Sim', 'Não', $FF3C7F04, $FFDF5447);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin
        acao := upView;
        TabControl1.TabIndex := 0;
      end;
    end);

  abort;
end;

procedure TFrmMainCadastros.rct_EditarClick(Sender: TObject);
begin
  acao := upUpdate;
  HabilitaCampos(Self);

end;

procedure TFrmMainCadastros.rct_ExcluirClick(Sender: TObject);
begin
  //
end;

procedure TFrmMainCadastros.rct_NovoClick(Sender: TObject);
begin
  LimpaCampos(Self);
  HabilitaCampos(Self);
  acao := upInsert;
  TabControl1.TabIndex := 1;
end;

end.
