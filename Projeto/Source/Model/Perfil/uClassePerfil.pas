unit uClassePerfil;

interface

uses uInterfacePerfil, System.Classes, FireDAC.Comp.Client, uDmDados,
  Form_Mensagem, u_Library, FireDAC.Stan.Param, Data.DB, System.UITypes,
  FMX.ListView, FMX.ListView.Appearances, FMX.ListView.Types, FMX.Objects;

type
  TPerfil = class(TInterfacedObject, iModelPerfil)
  private
    FID: Integer;
    FNome: String;
    FTelefone: String;
    FEndereco: String;
    FBairro: String;
    FIdCidade: Integer;
    FCpfCnpj: String;
    FLogo: TImage;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelPerfil;

    function ID(value: Integer): iModelPerfil;
    function Nome(value: String): iModelPerfil;
    function Telefone(value: String): iModelPerfil;
    function Endereco(value: String): iModelPerfil;
    function Bairro(value: String): iModelPerfil;
    function IdCidade(value: Integer): iModelPerfil;
    function CpfCnpj(value: String): iModelPerfil;
    function Logo(value: TImage): iModelPerfil;
    function RetornaImg(value: Integer; AImage: TImage): iModelPerfil;
    function PopulaCampos(value: Integer; AList: TStringList): iModelPerfil;
    function PopulaListview(value: tlistview): iModelPerfil;
    function ValidarCampos: iModelPerfil;
    function ValidaDB: iModelPerfil;
    function Gravar: iModelPerfil;
    function Editar(value: Integer): iModelPerfil;
  end;

implementation

uses
  System.SysUtils;

{ TPerfil }

class function TPerfil.new: iModelPerfil;
begin
  result := Self.create;
end;

constructor TPerfil.create;
begin

end;

destructor TPerfil.destroy;
begin

  inherited;
end;

function TPerfil.Bairro(value: String): iModelPerfil;
begin
  result := Self;
  FBairro := trim(value);
end;

function TPerfil.CpfCnpj(value: String): iModelPerfil;
begin
  result := Self;
  FCpfCnpj := trim(value);
end;

function TPerfil.Endereco(value: String): iModelPerfil;
begin
  result := Self;
  FEndereco := trim(value);
end;

function TPerfil.ID(value: Integer): iModelPerfil;
begin
  result := Self;
  FID := value;
end;

function TPerfil.IdCidade(value: Integer): iModelPerfil;
begin
  result := Self;
  FIdCidade := value;
end;

function TPerfil.Logo(value: TImage): iModelPerfil;
begin
  result := Self;
  FLogo := value;
end;

function TPerfil.Nome(value: String): iModelPerfil;
begin
  result := Self;
  FNome := trim(value);
end;

function TPerfil.Telefone(value: String): iModelPerfil;
begin
  result := Self;
  FTelefone := trim(value);
end;

function TPerfil.PopulaCampos(value: Integer; AList: TStringList): iModelPerfil;
var
  qry: TFDQuery;
  I: Integer;
begin

  result := Self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT NOME, TELEFONE, ENDERECO, BAIRRO, ID_CIDADE, CPFCNPJ FROM PERFIL WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger:= value;
    qry.Open;

    if qry.RecordCount = 0 then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Registro não encontrado!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

    for I := 0 to qry.FieldCount - 1 do
    begin
      AList.Add(qry.Fields[I].AsString);
      qry.Next;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TPerfil. RetornaImg(value: Integer; AImage: TImage): iModelPerfil;
var
  vStream: TMemoryStream;
  qry: TFDQuery;
begin

  result := Self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT LOGO FROM PERFIL WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger:=value;
    qry.Open;

    if qry.RecordCount = 0 then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Registro não encontrado!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

    vStream := TMemoryStream.create;
    TBlobField(qry.FieldByName('logo')).SaveToStream(vStream);
    vStream.Position := 0;
    AImage.MultiResBitmap.LoadItemFromStream(vStream, 1);
    vStream.Free;



  finally
    FreeAndNil(qry);
  end;
end;

function TPerfil.PopulaListview(value: tlistview): iModelPerfil;
var
  x: Integer;
  qry: TFDQuery;
  item: TListViewItem;
  txt: TListItemText;
begin

  result := Self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ID, NOME, CPFCNPJ FROM PERFIL');
    qry.Open;
    qry.First;

    value.Items.Clear;
    value.BeginUpdate;

    for x := 1 to 1 do
    begin
      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('lbl_id'));
        txt.Text := 'CÓDIGO';
        txt.TagString := '0';

        txt := TListItemText(Objects.FindDrawable('lbl_nome'));
        txt.Text := 'NOME/NOME FANTASIA';

        txt := TListItemText(Objects.FindDrawable('lbl_cpfcnpj'));
        txt.Text := 'CPF/CNPJ';

      end;
    end;

    for x := 1 to qry.RecordCount do
    begin

      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('ID'));
        txt.Text := formatfloat('0000', qry.FieldByName('ID').AsFloat);
        txt.TagString := qry.FieldByName('ID').AsString;

        txt := TListItemText(Objects.FindDrawable('NOME'));
        txt.Text := qry.FieldByName('NOME').AsString;

        txt := TListItemText(Objects.FindDrawable('CPFCNPJ'));
        txt.Text := qry.FieldByName('CPFCNPJ').AsString;
      end;

      qry.Next
    end;
  finally
    value.EndUpdate;
    FreeAndNil(qry);
  end;

end;

function TPerfil.ValidaDB: iModelPerfil;
// var
// qry: TFDQuery;
// I: Integer;
begin

  // result := self;
  //
  // try
  // qry := TFDQuery.create(nil);
  // qry.Connection := dm.FDConn;
  // qry.FetchOptions.RowsetSize := 50000;
  // qry.Active := false;
  // qry.SQL.Clear;
  // qry.SQL.Add('SELECT ID FROM PERFIL ');
  // qry.Open;
  //
  // if qry.RecordCount = 0 then
  // Acao = upInsert
  // else
  // Acao = upUpdate;
  //
  // finally
  // FreeAndNil(qry);
  // end;
end;

function TPerfil.ValidarCampos: iModelPerfil;
begin
  result := Self;
  if FNome.IsEmpty then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o nome/nome fantasia!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;
end;

function TPerfil.Editar(value: Integer): iModelPerfil;
var
  qry: TFDQuery;
begin
  result := Self;

  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Editar', 'Deseja gravar essa edição ?', 'Sim', 'Não', $FF3C7F04, $FFDF5447);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin

        try
          qry := TFDQuery.create(nil);
          qry.Connection := dm.FDConn;
          qry.Close;
          qry.SQL.Clear;
          qry.Active := false;
          qry.SQL.Clear;
          qry.SQL.Add
            ('UPDATE PERFIL SET NOME  = :NOME, TELEFONE = :TELEFONE, ENDERECO = :ENDERECO , BAIRRO = :BAIRRO, ID_CIDADE = :ID_CIDADE, CPFCNPJ = :CPFCNPJ, LOGO = :LOGO WHERE ID = :ID');
          qry.ParamByName('NOME').AsString := FNome;
          qry.ParamByName('TELEFONE').AsString := FTelefone;
          qry.ParamByName('ENDERECO').AsString := FEndereco;
          qry.ParamByName('BAIRRO').AsString := FBairro;
          qry.ParamByName('ID_CIDADE').AsInteger := FIdCidade;
          qry.ParamByName('CPFCNPJ').AsString := FCpfCnpj;
          qry.ParamByName('logo').Assign(FLogo.Bitmap);
          qry.ParamByName('ID').AsInteger := value;

          try
            qry.ExecSQL;;
          except
            Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao editar usuario!', 'OK', '', $FFDF5447, $FFDF5447);
            Frm_Mensagem.Show;
            exit;

          end;
        finally
          FreeAndNil(qry);
        end;
      end;
    end);

end;

function TPerfil.Gravar: iModelPerfil;
var
  qry: TFDQuery;
begin
  result := Self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.Close;
    qry.SQL.Clear;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add
      ('INSERT INTO PERFIL (NOME, TELEFONE, ENDERECO, BAIRRO, ID_CIDADE, CPFCNPJ, LOGO) VALUES (:NOME, :TELEFONE, :ENDERECO, :BAIRRO, :ID_CIDADE, :CPFCNPJ, :LOGO);');
    qry.ParamByName('NOME').AsString := FNome;
    qry.ParamByName('TELEFONE').AsString := FTelefone;
    qry.ParamByName('ENDERECO').AsString := FEndereco;
    qry.ParamByName('BAIRRO').AsString := FBairro;
    qry.ParamByName('ID_CIDADE').AsInteger := FIdCidade;
    qry.ParamByName('CPFCNPJ').AsString := FCpfCnpj;
    qry.ParamByName('logo').Assign(FLogo.Bitmap);

    try
      qry.ExecSQL;
    except
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao salvar novo usuario!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      exit;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

end.
