unit uFrmMainPesquisa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView,
  FMX.TabControl, FMX.Layouts, u_Library, Form_Mensagem;

type
  TFrmMainPesquisa = class(TForm)
    lay_Principal: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Layout1: TLayout;
    Layout3: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    ListView1: TListView;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    Lay_Novo: TLayout;
    rct_Novo: TRectangle;
    Label1: TLabel;
    Image2: TImage;
    TabItem2: TTabItem;
    Layout4: TLayout;
    Rectangle4: TRectangle;
    lay_Salvar: TLayout;
    rct_Salvar: TRectangle;
    Label4: TLabel;
    Image5: TImage;
    Layout8: TLayout;
    rct_Cancelar: TRectangle;
    Label6: TLabel;
    Image6: TImage;
    Layout7: TLayout;
    Label5: TLabel;
    lay_Top: TLayout;
    Rectangle1: TRectangle;
    lbl_NomeForm: TLabel;
    img_Fechar: TImage;
    Layout9: TLayout;
    Rectangle3: TRectangle;
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure rct_NovoClick(Sender: TObject);
    procedure img_FecharClick(Sender: TObject);
    procedure rct_CancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMainPesquisa: TFrmMainPesquisa;

implementation

{$R *.fmx}

procedure TFrmMainPesquisa.FormCreate(Sender: TObject);
begin
  TabControl1.TabPosition := TTabPosition.None;
  ListViewSearch(ListView1);
  lbl_NomeForm.Text := Self.Caption;
  TabControl1.TabIndex := 0;
end;

procedure TFrmMainPesquisa.img_FecharClick(Sender: TObject);
begin
   close;
end;

procedure TFrmMainPesquisa.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  txt: TListItemText;
begin
  with AItem do
  begin
    txt := TListItemText(Objects.FindDrawable('ID'));
    CodBusca := txt.TagString.ToInteger;
    close;
  end
end;

procedure TFrmMainPesquisa.rct_CancelarClick(Sender: TObject);
begin
 Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'CANCELAR', 'Deseja cancelar?', 'Sim', 'Não', $FF3C7F04, $FFDF5447);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin
        TabControl1.TabIndex := 0;
      end;
    end);

  abort;
end;

procedure TFrmMainPesquisa.rct_NovoClick(Sender: TObject);
begin
  LimpaCampos(Self);
  HabilitaCampos(Self);
  TabControl1.TabIndex := 1;
end;

end.
