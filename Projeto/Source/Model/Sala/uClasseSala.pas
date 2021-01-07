unit uClasseSala;

interface

uses uInterfaceSala, System.Classes, FMX.ListView, FireDAC.Comp.Client, uDmDados,
  Form_Mensagem, u_Library, System.SysUtils, FMX.ListView.Types,
  FMX.ListView.Appearances, System.UITypes, FireDAC.Stan.Param, Data.Db;

type

  TSala = Class(TInterfacedObject, iModelSala)
  private
    FID: Integer;
    FSala: String;
    FDescricao: String;
    FStatus: Integer;
    FIdDepartamento: Integer;

  public

    constructor create;
    destructor destroy; override;
    class function new: iModelSala;

    function ID(value: Integer): iModelSala;
    function Sala(value: string): iModelSala;
    function Descricao(value: string): iModelSala;
    function Status(value: Integer): iModelSala;
    function IdDepartamento(value: Integer): iModelSala;
    function ValidaCampos: iModelSala;
    function PopulaCampos(value: Integer; AList: TStringList): iModelSala;
    function PopulaListView(value: TListView): iModelSala;
    function ValidaSalaDB(value: Integer): iModelSala;
    function BuscarSala(value: Integer): String;
    function editar(value: Integer): iModelSala;
    function delete(value: Integer): iModelSala;
    function Gravar: iModelSala;

  End;

implementation

{ TSala }

class function TSala.new: iModelSala;
begin
   result := self.create;
end;


constructor TSala.create;
begin
  //
end;

destructor TSala.destroy;
begin
  //
  inherited;
end;

function TSala.ID(value: Integer): iModelSala;
begin
  Result := Self;
  FID := value;
end;

function TSala.Descricao(value: string): iModelSala;
begin
  Result := Self;
  FDescricao := value;

end;

function TSala.Sala(value: string): iModelSala;
begin
  Result := Self;
  FSala := value;

end;

function TSala.Status(value: Integer): iModelSala;
begin
  Result := Self;
  FStatus := value;
end;

function TSala.IdDepartamento(value: Integer): iModelSala;
begin
  Result := Self;
  FIdDepartamento := value;

end;


function TSala.PopulaCampos(value: Integer; AList: TStringList): iModelSala;
var
  qry: TFDQuery;
  I: Integer;
begin

  Result := Self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT NOME, ID_DEPARTAMENTO, DESCRICAO, STATUS FROM SALAS WHERE ID = :ID');
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

function TSala.PopulaListView(value: TListView): iModelSala;
var
  x: Integer;
  qry: TFDQuery;
  item: TListViewItem;
  txt: TListItemText;
begin

  Result := Self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add
      (' SELECT S.ID, S.NOME AS SALA, CASE WHEN S.STATUS = 1 THEN ''ATIVO'' ELSE ''INATIVO''  END AS STATUS, D.NOME AS DEPARTAMENTO FROM SALAS S '
      + ' LEFT OUTER JOIN DEPARTAMENTO D ON (S.ID_DEPARTAMENTO = D.ID)');
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

        txt := TListItemText(Objects.FindDrawable('lbl_sala'));
        txt.Text := 'SALA';

        txt := TListItemText(Objects.FindDrawable('lbl_departamento'));
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

        txt := TListItemText(Objects.FindDrawable('SALA'));
        txt.Text := qry.FieldByName('sala').AsString;

        txt := TListItemText(Objects.FindDrawable('DEPARTAMENTO'));
        txt.Text := qry.FieldByName('departamento').AsString;

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

function TSala.ValidaCampos: iModelSala;
begin
  Result := Self;

  if FSala.IsEmpty then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o nome da Sala!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FIdDepartamento = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe um departamento valido!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

end;

function TSala.BuscarSala(value: Integer): String;
var
  qry: TFDQuery;
begin

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT NOME FROM SALAS WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := value;
    qry.Open;

    if qry.RecordCount = 0 then
      Result := EmptyStr
    else
      Result := qry.FieldByName('NOME').AsString;

  finally
    FreeAndNil(qry);
  end;

end;

function TSala.ValidaSalaDB(value: Integer): iModelSala;
var
  qry: TFDQuery;
begin
  Result := Self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ID FROM SALAS WHERE NOME = :NOME AND ID_DEPARTAMENTO = :IDDEPARTAMENTO');
    if acao = upUpdate then
    begin
      qry.SQL.Add(' AND ID <> :ID');
      qry.ParamByName('ID').AsInteger := value;
    end;
    qry.ParamByName('NOME').AsString := FSala;
    qry.ParamByName('IDDEPARTAMENTO').AsInteger := FIdDepartamento;
    qry.Open;

    if qry.RecordCount <> 0 then
    begin
      Exibir_Mensagem('ERRO', 'ERRO', 'Erro', 'Departamento já cadastrado!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TSala.editar(value: Integer): iModelSala;
var
  qry: TFDQuery;
begin
  Result := Self;
  Exibir_Mensagem('PERGUNTA', 'PERGUNTA', 'Editar', 'Deseja gravar essa edição ?', 'Sim', 'Não', $FF3C7F04, $FFDF5447);
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
            ('UPDATE SALAS SET NOME = :NOME, DESCRICAO = :DESCRICAO, ID_DEPARTAMENTO = :DEPARTAMENTO, STATUS = :STATUS WHERE ID = :ID');
          qry.ParamByName('NOME').AsString := FSala;
          qry.ParamByName('DESCRICAO').AsString := FDescricao;
          qry.ParamByName('STATUS').AsInteger := FStatus;
          qry.ParamByName('DEPARTAMENTO').AsInteger := FIdDepartamento;
          qry.ParamByName('ID').AsInteger := value;

          try
            qry.ExecSQL;

          except
            Exibir_Mensagem('ERRO', 'ERRO', 'ERRO', 'Erro ao editar registro!', 'OK', '', $FFDF5447, $FFDF5447);
            Frm_Mensagem.Show;
            abort;
          end;

        finally
          FreeAndNil(qry);
        end;
      end;
    end);

end;

function TSala.Gravar: iModelSala;
var
  qry: TFDQuery;
begin
  Result := Self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add
      ('INSERT INTO SALAS (NOME, DESCRICAO, ID_DEPARTAMENTO, STATUS) VALUES (:NOME, :DESCRICAO, :ID_DEPARTAMENTO, :STATUS)');
    qry.ParamByName('NOME').AsString := FSala;
    qry.ParamByName('DESCRICAO').AsString := FDescricao;
    qry.ParamByName('ID_DEPARTAMENTO').AsInteger := FIdDepartamento;
    qry.ParamByName('STATUS').AsInteger := FStatus;

    try
      qry.ExecSQL;

    except
      Exibir_Mensagem('ERRO', 'ERRO', 'ERRO', 'Erro ao gravar registro!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TSala.delete(value: Integer): iModelSala;
var
  qry: TFDQuery;
begin
  Result := Self;

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
          qry.FetchOptions.RowsetSize := 50000;
          qry.Active := false;
          qry.SQL.Clear;
          qry.SQL.Add('DELETE FROM SALAS WHERE ID = :ID');
          qry.ParamByName('ID').AsInteger := value;

          try
            qry.ExecSQL;

          except
            Exibir_Mensagem('ERRO', 'ERRO', 'ERRO', 'Erro ao deletar registro!', 'OK', '', $FFDF5447, $FFDF5447);
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
