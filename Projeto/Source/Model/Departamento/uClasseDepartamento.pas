unit uClasseDepartamento;

interface

uses uInterfaceDepartamento, FireDAC.Comp.Client, FMX.ListView, uDmDados,
  System.SysUtils, FMX.Dialogs, u_Library,
  Form_Mensagem, FireDAC.Stan.Param, Data.DB,
  FMX.ListView.Appearances, FMX.ListView.Types, System.UITypes, System.Classes;

type
  TDepartamento = class(TInterfacedObject, iModelDepartamento)

  private
    FID: Integer;
    FNome: String;
    FDescricao: String;
    FStatus: Integer;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelDepartamento;

    function ID(value: Integer): iModelDepartamento;
    function Nome(value: String): iModelDepartamento;
    function Descricao(value: String): iModelDepartamento;
    function Status(value: Integer): iModelDepartamento;
    function ValidaCampos: iModelDepartamento;
    function PopulaCampos(value: Integer; AList: TStringList)
      : iModelDepartamento;
    function PopulaListView(value: TListView): iModelDepartamento;
    function ValidaDepartamentoDB(value: Integer): iModelDepartamento;
    function BuscarDepartamento(value: Integer): String;
    function editar(value: Integer): iModelDepartamento;
    function delete(value: Integer): iModelDepartamento;
    function Gravar: iModelDepartamento;
    function VerificaExisteSalaSQL: iModelDepartamento;
  end;

implementation

{ TDepartamento }

class function TDepartamento.new: iModelDepartamento;
begin
  result := self.create;
end;

constructor TDepartamento.create;
begin
  //
end;

destructor TDepartamento.destroy;
begin
  //
  inherited;
end;

function TDepartamento.Descricao(value: String): iModelDepartamento;
begin
  result := self;
  FDescricao := value;
end;

function TDepartamento.Status(value: Integer): iModelDepartamento;
begin
  result := self;
  FStatus := value;
end;

function TDepartamento.ID(value: Integer): iModelDepartamento;
begin
  result := self;
  FID := value;
end;

function TDepartamento.Nome(value: String): iModelDepartamento;
begin
  result := self;
  FNome := value;
end;

function TDepartamento.BuscarDepartamento(value: Integer): String;
var
  qry: TFDQuery;
begin

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT NOME FROM DEPARTAMENTO WHERE ID = :ID');
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

function TDepartamento.PopulaCampos(value: Integer; AList: TStringList)
  : iModelDepartamento;
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
    qry.SQL.Add
      ('SELECT NOME, DESCRICAO, STATUS FROM DEPARTAMENTO WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := value;
    qry.Open;

    if qry.RecordCount = 0 then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Registro não encontrado!',
        'OK', '', $FFDF5447, $FFDF5447);
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

function TDepartamento.PopulaListView(value: TListView): iModelDepartamento;
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
      ('SELECT ID, NOME, CASE WHEN STATUS = 1 THEN ''ATIVO'' ELSE ''INATIVO'' END AS STATUS FROM DEPARTAMENTO');
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
        txt.Text := 'DEPARTAMENTO';

        txt := TListItemText(Objects.FindDrawable('lbl_status'));
        txt.Text := 'STATUS';

      end;
    end;

    for x := 1 to qry.RecordCount do
    begin

      item := value.Items.Add;

      with item do
      begin
        txt := TListItemText(Objects.FindDrawable('ID'));
        txt.Text := formatfloat('0000', qry.FieldByName('id').AsFloat);
        txt.TagString := qry.FieldByName('id').AsString;

        txt := TListItemText(Objects.FindDrawable('NOME'));
        txt.Text := qry.FieldByName('nome').AsString;

        txt := TListItemText(Objects.FindDrawable('STATUS'));
        txt.Text := qry.FieldByName('status').AsString;
      end;

      qry.Next
    end;
  finally
    value.EndUpdate;
    FreeAndNil(qry);
  end;
end;

function TDepartamento.ValidaCampos: iModelDepartamento;
begin
  result := self;

  if FNome.IsEmpty then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o nome do departamento!',
      'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

end;

function TDepartamento.ValidaDepartamentoDB(value: Integer): iModelDepartamento;
var
  qry: TFDQuery;
begin
  result := self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ID FROM DEPARTAMENTO WHERE NOME = :NOME');
    if acao = upUpdate then
    begin
      qry.SQL.Add(' AND ID <> :ID');
      qry.ParamByName('ID').AsInteger := value;
    end;
    qry.ParamByName('NOME').AsString := FNome;
    qry.Open;

    if qry.RecordCount <> 0 then
    begin
      Exibir_Mensagem('ERRO', 'ERRO', 'Erro', 'Departamento já cadastrado!',
        'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;
end;

function TDepartamento.VerificaExisteSalaSQL: iModelDepartamento;
var
  qry: TFDQuery;
begin
  result := self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM SALAS WHERE ID_DEPARTAMENTO = :ID_DEPARTAMENTO');
    qry.ParamByName('ID_DEPARTAMENTO').AsInteger := FID;
    qry.Open;

    if qry.RecordCount <> 0 then
    begin
      Exibir_Mensagem('ERRO', 'ERRO', 'ERRO',
        'Não é possivel deletar. Existe salas nesse departamento!', 'OK', '',
        $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;

    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDepartamento.editar(value: Integer): iModelDepartamento;
var
  qry: TFDQuery;
begin
  result := self;
  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Editar',
    'Deseja gravar essa edição ?', 'Sim', 'Não', $FF3C7F04, $FFDF5447);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin
        try
          qry := TFDQuery.create(nil);
          qry.Connection := dm.FDConn;
          qry.FetchOptions.RowsetSize := 50000;
          qry.Active := false;
          qry.SQL.Clear;
          qry.SQL.Add
            ('UPDATE DEPARTAMENTO SET NOME = :NOME, DESCRICAO = :DESCRICAO, STATUS = :STATUS WHERE ID = :ID');
          qry.ParamByName('NOME').AsString := FNome;
          qry.ParamByName('DESCRICAO').AsString := FDescricao;
          qry.ParamByName('STATUS').AsInteger := FStatus;
          qry.ParamByName('ID').AsInteger := value;

          try
            qry.ExecSQL;

          except
            Exibir_Mensagem('ERRO', 'ERRO', 'ERRO',
              'Erro ao editar registro!', 'OK', '', $FFDF5447, $FFDF5447);
            Frm_Mensagem.Show;
            abort;
          end;

        finally
          FreeAndNil(qry);
        end;
      end;
    end);
end;

function TDepartamento.Gravar: iModelDepartamento;
var
  qry: TFDQuery;
begin
  result := self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add
      ('INSERT INTO DEPARTAMENTO (NOME, DESCRICAO, STATUS) VALUES (:NOME, :DESCRICAO, :STATUS)');
    qry.ParamByName('NOME').AsString := FNome;
    qry.ParamByName('DESCRICAO').AsString := FDescricao;
    qry.ParamByName('STATUS').AsInteger := FStatus;

    try
      qry.ExecSQL;

    except
      Exibir_Mensagem('ERRO', 'ERRO', 'ERRO', 'Erro ao gravar registro!',
        'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;
end;

function TDepartamento.delete(value: Integer): iModelDepartamento;
var
  qry: TFDQuery;
begin
  result := self;

  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Cancelamento',
    'Deseja deletar esse resgistro?', 'Sim', 'Não', $FF3C7F04, $FFDF5447);
  Frm_Mensagem.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if Frm_Mensagem.retorno = '1' then
      begin
        try
          qry := TFDQuery.create(nil);
          qry.Connection := dm.FDConn;
          qry.FetchOptions.RowsetSize := 50000;
          qry.Active := false;
          qry.SQL.Clear;
          qry.SQL.Add('DELETE FROM DEPARTAMENTO WHERE ID = :ID');
          qry.ParamByName('ID').AsInteger := value;

          try
            qry.ExecSQL;

          except
            Exibir_Mensagem('ERRO', 'ERRO', 'ERRO', 'Erro ao deletar registro!',
              'OK', '', $FFDF5447, $FFDF5447);
            Frm_Mensagem.Show;
            exit;
          end;

        finally
          FreeAndNil(qry);
        end;
      end;
    end);

end;

end.
