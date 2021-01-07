unit uClasseFornecedor;

interface

uses uInterfaceFornecedor, FMX.ListView, FireDAC.Stan.Param, Data.DB, System.Classes, FireDAC.Comp.Client,
  Form_Mensagem, u_Library, System.SysUtils, uDmDados,
  FMX.ListView.Appearances, FMX.ListView.Types, System.UITypes;

type

  TForncedor = class(TInterfacedObject, iModelFornecedor)
  private
    FID: Integer;
    FNome: String;
    FTelefone: String;
    FCpfCnpj: String;
    FEndereco: String;
    FBairro: String;
    FIdcidade: Integer;
  public
    constructor create;
    destructor destroy; override;
    class function new: iModelFornecedor;

    function ID(value: Integer): iModelFornecedor;
    function Nome(value: string): iModelFornecedor;
    function Telefone(value: string): iModelFornecedor;
    function CpfCnpj(value: string): iModelFornecedor;
    function Endereco(value: string): iModelFornecedor;
    function Bairro(value: String): iModelFornecedor;

    function IdCidade(value: Integer): iModelFornecedor;
    function ValidarCampos: iModelFornecedor;
    function VerificarFornecedorDB(value: Integer): iModelFornecedor;
    function PopulaListview(value: tlistview): iModelFornecedor;
    function PopulaCampos(value: Integer; AList: TStringList): iModelFornecedor;
    function BuscarFornecedor(value: Integer): String;
    function Gravar: iModelFornecedor;
    function Editar(value: Integer): iModelFornecedor;
    function delete(value: Integer): iModelFornecedor;
  end;

implementation

{ TForncedor }

class function TForncedor.new: iModelFornecedor;
begin
  result := self.create;
end;

constructor TForncedor.create;
begin

end;

destructor TForncedor.destroy;
begin

  inherited;
end;

function TForncedor.Bairro(value: String): iModelFornecedor;
begin
  FBairro := value;
  result := self;
end;

function TForncedor.CpfCnpj(value: string): iModelFornecedor;
begin
  result := self;
  FCpfCnpj := value;
end;

function TForncedor.Endereco(value: string): iModelFornecedor;
begin
  result := self;
  FEndereco := value;
end;

function TForncedor.ID(value: Integer): iModelFornecedor;
begin
  result := self;
  FID := value;
end;

function TForncedor.IdCidade(value: Integer): iModelFornecedor;
begin
  result := self;
  FIdcidade := value;
end;

function TForncedor.Nome(value: string): iModelFornecedor;
begin
  result := self;
  FNome := value;
end;

function TForncedor.Telefone(value: string): iModelFornecedor;
begin
  result := self;
  FTelefone := value;
end;

function TForncedor.ValidarCampos: iModelFornecedor;
begin
  result := self;

  if FNome.IsEmpty then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o nome do fornecedor!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FCpfCnpj.IsEmpty then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o CPF/CNPJ do fornecedor!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FTelefone.IsEmpty then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o telefone de contato do fornecedor!', 'OK', '', $FFDF5447,
      $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

end;

function TForncedor.BuscarFornecedor(value: Integer): String;
var
  qry: TFDQuery;
begin

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT NOME FROM FORNECEDORES WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := value;
    qry.Open;

    if qry.RecordCount = 0 then
      result := EmptyStr
    else
      result := qry.FieldByName('NOME').AsString;

  finally
    FreeAndNil(qry);
  end;
end;

function TForncedor.VerificarFornecedorDB(value: Integer): iModelFornecedor;
var
  qry: TFDQuery;
begin
  result := self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.Close;
    qry.SQL.Clear;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ID FROM FORNECEDORES WHERE CPFCNPJ = CPFCNPJ ');
    if acao = upUpdate then
    begin
      qry.SQL.Add(' AND ID <> :ID');
      qry.ParamByName('ID').AsInteger := value;
    end;
    qry.ParamByName('CPFCNPJ').AsString := FCpfCnpj;
    qry.Open;

    if qry.RecordCount <> 0 then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Usuario já cadastrado!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TForncedor.PopulaCampos(value: Integer; AList: TStringList): iModelFornecedor;
var
  qry: TFDQuery;
  I: Integer;
begin

  result := self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT NOME, CPFCNPJ, TELEFONE, ENDERECO, BAIRRO, ID_CIDADE FROM FORNECEDORES WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := value;
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

function TForncedor.PopulaListview(value: tlistview): iModelFornecedor;
var
  x: Integer;
  qry: TFDQuery;
  item: TListViewItem;
  txt: TListItemText;
begin

  result := self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add
      ('SELECT F.ID, F.NOME, F.CPFCNPJ, F.TELEFONE, UPPER(CONCAT(M.NOME, '' - '', M.UF)) AS CIDADE FROM FORNECEDORES F'
      + ' LEFT OUTER JOIN MUNICIPIO M ON (M.ID = F.ID_CIDADE)');
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
        txt.Text := 'FORNECEDOR';

        txt := TListItemText(Objects.FindDrawable('lbl_telefone'));
        txt.Text := 'TELEFONE';

        txt := TListItemText(Objects.FindDrawable('lbl_cidade'));
        txt.Text := 'CIDADE';

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

        txt := TListItemText(Objects.FindDrawable('TELEFONE'));
        txt.Text := qry.FieldByName('TELEFONE').AsString;

        txt := TListItemText(Objects.FindDrawable('CIDADE'));
        txt.Text := qry.FieldByName('CIDADE').AsString;
      end;

      qry.Next
    end;
  finally
    value.EndUpdate;
    FreeAndNil(qry);
  end;

end;

function TForncedor.delete(value: Integer): iModelFornecedor;
var
  qry: TFDQuery;
begin

  result := self;
  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Cancelamento', 'Deseja deletar esse resgistro?', 'Sim', 'Não', $FF3C7F04,
    $FFDF5447);
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
          qry.SQL.Add('DELETE FROM FORNECEDORES WHERE ID = :ID;');
          qry.ParamByName('ID').AsInteger := value;
          try
            qry.ExecSQL;

          except
            Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao deletar usuario!', 'OK', '', $FFDF5447, $FFDF5447);
            Frm_Mensagem.Show;
            exit;

          end;
        finally
          FreeAndNil(qry);
        end;
      end;
    end);

end;

function TForncedor.Editar(value: Integer): iModelFornecedor;
var
  qry: TFDQuery;
begin
  result := self;

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
            ('UPDATE FORNECEDORES SET NOME = :NOME, CPFCNPJ = :CPFCNPJ, TELEFONE = :TELEFONE, ENDERECO = :ENDERECO, BAIRRO = :BAIRRO, ID_CIDADE = :ID_CIDADE WHERE ID = :ID');
          qry.ParamByName('NOME').AsString := FNome;
          qry.ParamByName('CPFCNPJ').AsString := FCpfCnpj;
          qry.ParamByName('TELEFONE').AsString := FTelefone;
          qry.ParamByName('ENDERECO').AsString := FEndereco;
          qry.ParamByName('BAIRRO').AsString := FBairro;
          qry.ParamByName('ID_CIDADE').AsInteger := FIdcidade;
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

function TForncedor.Gravar: iModelFornecedor;
var
  qry: TFDQuery;
begin
  result := self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.Close;
    qry.SQL.Clear;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add
      ('INSERT INTO FORNECEDORES (NOME, CPFCNPJ, TELEFONE, ENDERECO, BAIRRO, ID_CIDADE) VALUES (:NOME, :CPFCNPJ, :TELEFONE, :ENDERECO, :BAIRRO, :ID_CIDADE);');
    qry.ParamByName('NOME').AsString := FNome;
    qry.ParamByName('CPFCNPJ').AsString := FCpfCnpj;
    qry.ParamByName('TELEFONE').AsString := FTelefone;
    qry.ParamByName('ENDERECO').AsString := FEndereco;
    qry.ParamByName('BAIRRO').AsString := FBairro;
    qry.ParamByName('ID_CIDADE').AsInteger := FIdcidade;

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
