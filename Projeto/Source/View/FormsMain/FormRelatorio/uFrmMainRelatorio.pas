unit uFrmMainRelatorio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView,
  FMX.TabControl, FMX.Layouts, FMX.frxClass, DmRelatorios, uFrmPrincipal,
  FMX.ListBox;

type
  TFrmMainRelatorio = class(TForm)
    lay_Principal: TLayout;
    lay_Top: TLayout;
    Rectangle1: TRectangle;
    lbl_NomeForm: TLabel;
    img_Fechar: TImage;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    Rectangle3: TRectangle;
    Lay_Gerar: TLayout;
    rct_Gerar: TRectangle;
    Label1: TLabel;
    Image2: TImage;
    frxReport1: TfrxReport;
    Layout3: TLayout;
    Label5: TLabel;
    cbx_TipoRelatorio: TComboBox;
    procedure img_FecharClick(Sender: TObject);
    procedure rct_GerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbx_TipoRelatorioChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMainRelatorio: TFrmMainRelatorio;

implementation

{$R *.fmx}

uses u_Library;

procedure TFrmMainRelatorio.cbx_TipoRelatorioChange(Sender: TObject);
begin
  if (cbx_TipoRelatorio.ItemIndex = 0) then
  begin
    DesabilitaCampo(self);
    cbx_TipoRelatorio.Enabled := true;
  end;
end;

Procedure TFrmMainRelatorio.FormCreate(Sender: TObject);
begin
lbl_NomeForm.Text := Self.Caption;
  LimpaCampos(self);
  cbx_TipoRelatorio.ItemIndex := 0;
end;

procedure TFrmMainRelatorio.img_FecharClick(Sender: TObject);
begin
  FrmPrincipal.tab_Conteiner.TabIndex := 0;
  close;
end;

procedure TFrmMainRelatorio.rct_GerarClick(Sender: TObject);
begin
  DmRelatorio.QPerfil.Active := true;
  DmRelatorio.QPerfil.Refresh;

end;

end.
