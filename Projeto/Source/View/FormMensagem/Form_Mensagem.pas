unit Form_Mensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrm_Mensagem = class(TForm)
    rect_fundo: TRectangle;
    img_erro: TImage;
    img_alerta: TImage;
    img_sucesso: TImage;
    img_pergunta: TImage;
    rect_msg: TRectangle;
    lbl_titulo: TLabel;
    lbl_msg: TLabel;
    img_icone: TImage;
    layout_botao: TLayout;
    rect_btn1: TRectangle;
    lbl_btn1: TLabel;
    rect_btn2: TRectangle;
    lbl_btn2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lbl_btn1Click(Sender: TObject);
    procedure lbl_btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retorno : string;
  end;

var
  Frm_Mensagem: TFrm_Mensagem;

implementation

{$R *.fmx}

procedure TFrm_Mensagem.FormCreate(Sender: TObject);
begin
Frm_Mensagem.Transparency:= true;
        img_erro.Visible := false;
        img_alerta.Visible := false;
        img_sucesso.Visible := false;
        img_pergunta.Visible := false;
end;

procedure TFrm_Mensagem.lbl_btn1Click(Sender: TObject);
begin
        retorno := '1';
        close;
end;

procedure TFrm_Mensagem.lbl_btn2Click(Sender: TObject);
begin
        retorno := '2';
        close;
end;

end.
