unit uFrmCadPatrimonio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmMainCadastros, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FMX.ScrollBox, FMX.Memo,
  FMX.ListBox, FMX.Edit, uClassePatrimonio, u_Library, uClasseSala,
  uClasseFornecedor, uFrmPesqSalas, uFrmPesqFornecedor, uFrmPesqTipoPatrimonio,
  uClasseTipoPatrimonio, FMX.DateTimeCtrls;

type
  TFrmCadPatrimonio = class(TFrmMainCadastros)
    cbx_Status: TComboBox;
    Label8: TLabel;
    mem_Descricao: TMemo;
    Label7: TLabel;
    edt_NumeroPlaca: TEdit;
    edt_Qtd: TEdit;
    edtNmroPlaca: TLabel;
    lbl_Qtd: TLabel;
    edt_Marca: TEdit;
    Label11: TLabel;
    edt_IdSala: TEdit;
    Image7: TImage;
    edt_Sala: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    edt_IdTipoPatrimonio: TEdit;
    Image1: TImage;
    edt_TipoPatrimonio: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    edt_IdFornecedor: TEdit;
    Image8: TImage;
    edt_Fornecedor: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    edt_Valor: TEdit;
    Label18: TLabel;
    cbx_Cor: TComboBox;
    Label19: TLabel;
    cbx_EstadoFisico: TComboBox;
    Label20: TLabel;
    Rectangle3: TRectangle;
    Label21: TLabel;
    img_logo: TImage;
    OpenDialog: TOpenDialog;
    DtAquisicao: TDateEdit;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure edt_IdSalaChangeTracking(Sender: TObject);
    procedure edt_IdFornecedorChangeTracking(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure img_logoClick(Sender: TObject);
    procedure rct_SalvarClick(Sender: TObject);
    procedure edt_IdTipoPatrimonioChangeTracking(Sender: TObject);
    procedure rct_NovoClick(Sender: TObject);
    procedure ValidaEdits;
    procedure rct_ExcluirClick(Sender: TObject);
    procedure rct_EditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPatrimonio: TFrmCadPatrimonio;

implementation

{$R *.fmx}

procedure TFrmCadPatrimonio.edt_IdFornecedorChangeTracking(Sender: TObject);
begin
  inherited;
  if edt_IdFornecedor.Text <> '' then
    edt_Fornecedor.Text := TForncedor.new.BuscarFornecedor(StrToInt(edt_IdFornecedor.Text))
  else
    edt_Fornecedor.Text := EmptyStr;
  if edt_Fornecedor.Text = '' then
    edt_IdFornecedor.Text := '0';
end;

procedure TFrmCadPatrimonio.edt_IdSalaChangeTracking(Sender: TObject);
begin
  inherited;
  if edt_IdSala.Text <> '' then
    edt_Sala.Text := TSala.new.BuscarSala(StrToInt(edt_IdSala.Text))
  else
    edt_Sala.Text := EmptyStr;
  if edt_Sala.Text = '' then
    edt_IdSala.Text := '0';
end;

procedure TFrmCadPatrimonio.edt_IdTipoPatrimonioChangeTracking(Sender: TObject);
begin
  inherited;
  if edt_IdTipoPatrimonio.Text <> '' then
    edt_TipoPatrimonio.Text := TTipoPatrimonio.new.BuscarPatrimonio(StrToInt(edt_IdTipoPatrimonio.Text))
  else
    edt_TipoPatrimonio.Text := EmptyStr;
  if edt_TipoPatrimonio.Text = '' then
    edt_IdTipoPatrimonio.Text := '0';

end;

procedure TFrmCadPatrimonio.FormCreate(Sender: TObject);
begin
  inherited;
  TPatrimonio
  .new
  .PopulaListview(ListView1)
end;

procedure TFrmCadPatrimonio.Image1Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqTipoPatrimonio) then
    FrmPesqTipoPatrimonio := TFrmPesqTipoPatrimonio.Create(Application);
  FrmPesqTipoPatrimonio.ShowModal;

  edt_IdTipoPatrimonio.Text := IntToStr(codBusca);
end;

procedure TFrmCadPatrimonio.Image7Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqSalas) then
    FrmPesqSalas := TFrmPesqSalas.Create(Application);
  FrmPesqSalas.ShowModal;

  edt_IdSala.Text := IntToStr(codBusca);
end;

procedure TFrmCadPatrimonio.Image8Click(Sender: TObject);
begin
  inherited;
  if not assigned(FrmPesqFornecedor) then
    FrmPesqFornecedor := TFrmPesqFornecedor.Create(Application);
  FrmPesqFornecedor.ShowModal;

  edt_IdFornecedor.Text := IntToStr(codBusca);
end;

procedure TFrmCadPatrimonio.img_logoClick(Sender: TObject);
begin
  inherited;
    if OpenDialog.Execute then
    img_logo.Bitmap.LoadFromFile(OpenDialog.FileName);

    exit;
end;

procedure TFrmCadPatrimonio.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  List : TStringList;
begin
  inherited;
  edt_Qtd.Visible := false;
  lbl_Qtd.Visible := false;
  edtNmroPlaca.Text := 'Nº da Placa:';
  List := TStringList.Create;
  try
   TPatrimonio
   .new
    .PopulaCampos(codRegistro, List);

    edt_NumeroPlaca.Text := List[0];
    cbx_Status.ItemIndex := StrToInt(List[1]);
    edt_IdSala.Text := List[2];
    edt_IdTipoPatrimonio.Text:= List[3];
    cbx_EstadoFisico.ItemIndex := StrToInt(List[4]);
    cbx_Cor.ItemIndex := StrToInt(List[5]);
    edt_Marca.Text := List[6];
    edt_Valor.Text := List[7];
    mem_Descricao.Lines.Add(List[8]);
    edt_IdFornecedor.Text := List[9];

    TPatrimonio
    .new
    .RetornaImg(codRegistro, img_logo);
  finally
    FreeAndNil(List);
  end;
end;

procedure TFrmCadPatrimonio.rct_EditarClick(Sender: TObject);
begin
  inherited;
  edt_Qtd.Visible := false;
  lbl_Qtd.Visible := false;
  edt_NumeroPlaca.Enabled := False;
end;

procedure TFrmCadPatrimonio.rct_ExcluirClick(Sender: TObject);
begin
  inherited;
   TPatrimonio
   .new
  .delete(codRegistro)
  .PopulaListview(ListView1);

   TabControl1.TabIndex := 0;
   Acao := upView;
end;

procedure TFrmCadPatrimonio.rct_NovoClick(Sender: TObject);
begin
  inherited;
  edt_Qtd.Visible := true;
  lbl_Qtd.Visible := true;
  edt_Qtd.Text := '1';
  img_logo.Bitmap := nil;
  edtNmroPlaca.Text := 'Nº da Placa(Placa Inicial):';
end;

procedure TFrmCadPatrimonio.rct_SalvarClick(Sender: TObject);
begin
  inherited;
  case Acao of
    upInsert:
      begin
        ValidaEdits;
        TPatrimonio
        .new
        .NumeroPlaca(StrToInt(edt_NumeroPlaca.Text))
        .Status(cbx_Status.ItemIndex)
        .IdSala(StrToInt(edt_IdSala.Text))
        .IdTipoPatrimonio(StrToInt(edt_IdTipoPatrimonio.Text))
        .EstadoFisico(cbx_EstadoFisico.ItemIndex)
        .Cor(cbx_Cor.ItemIndex)
        .Marca(edt_Marca.Text)
        .Valor(StrToFloat(edt_Valor.Text))
        .Descricao(mem_Descricao.Lines.Text)
        .DataCadastro(Now)
        .DataAquisicao(DtAquisicao.Date)
        .IdFornecedor(StrToInt(edt_IdFornecedor.Text))
        .Qtd(StrToInt(edt_Qtd.Text))
        .Logo(img_logo)
          .ValidarCampos
          .ValidaDB(StrToInt(edt_NumeroPlaca.Text))
          .Gravar;

      end;
    upUpdate:
      begin
        ValidaEdits;
        TPatrimonio
        .new
            .NumeroPlaca(StrToInt(edt_NumeroPlaca.Text))
            .Status(cbx_Status.ItemIndex)
            .IdSala(StrToInt(edt_IdSala.Text))
            .IdTipoPatrimonio(StrToInt(edt_IdTipoPatrimonio.Text))
            .EstadoFisico(cbx_EstadoFisico.ItemIndex)
            .Cor(cbx_Cor.ItemIndex)
            .Marca(edt_Marca.Text)
            .Valor(StrToFloat(edt_Valor.Text))
            .Descricao(mem_Descricao.Lines.Text)
            .DataAquisicao(DtAquisicao.Date)
            .IdFornecedor(StrToInt(edt_IdFornecedor.Text))
            .Qtd(StrToInt(edt_Qtd.Text))
            .Logo(img_logo)
        .ValidarCampos
        .ValidaDB(StrToInt(edt_NumeroPlaca.Text))
        .Editar(codRegistro);
      end;
    upView:
      Abort;
  end;
  TPatrimonio
  .new
  .PopulaListview(ListView1);
  TabControl1.TabIndex := 0;
  Acao := upView;
end;

procedure TFrmCadPatrimonio.ValidaEdits;
begin
  if edt_NumeroPlaca.Text.IsEmpty then
  begin
    edt_NumeroPlaca.Text := '0';
  end;

  if edt_Valor.Text.IsEmpty then
  begin
    edt_Valor.Text := '0';
  end;

  if edt_IdSala.Text.IsEmpty then
  begin
    edt_IdSala.Text := '0';
  end;

  if edt_IdTipoPatrimonio.Text.IsEmpty then
  begin
    edt_IdTipoPatrimonio.Text := '0';
  end;

  if edt_IdFornecedor.Text.IsEmpty then
  begin
    edt_IdFornecedor.Text := '0';
  end;

  if edt_Qtd.Text.IsEmpty then
  begin
    edt_Qtd.Text := '1';
  end;

end;

end.
