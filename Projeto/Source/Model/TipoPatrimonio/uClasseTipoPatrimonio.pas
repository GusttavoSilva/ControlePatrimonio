unit uClasseTipoPatrimonio;

interface

uses  FireDAC.Comp.Client, FMX.ListView, uDmDados, System.SysUtils, FMX.Dialogs, u_Library,
  Form_Mensagem,FireDAC.Stan.Param, Data.DB,
  FMX.ListView.Appearances, FMX.ListView.Types, System.UITypes, System.Classes,
  uInterfaceTipoPatrimonio;

type
  TTipoPatrimonio = class(TInterfacedObject, iModelTipoPatrimonio)

  private
    FID: Integer;
    FNome: String;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelTipoPatrimonio;

    function ID(value: Integer): iModelTipoPatrimonio;
    function Nome(value: String): iModelTipoPatrimonio;
    function ValidaCampos: iModelTipoPatrimonio;
    function PopulaCampos(value: Integer; AList: TStringList): iModelTipoPatrimonio;
    function PopulaListView(value: TListView): iModelTipoPatrimonio;
    function ValidaPatrimonioDB(value: Integer): iModelTipoPatrimonio;
    function BuscarPatrimonio(value: Integer): String;
    function editar(value: Integer): iModelTipoPatrimonio;
    function delete(value: Integer): iModelTipoPatrimonio;
    function Gravar: iModelTipoPatrimonio;
  end;

implementation

{ TTipoPatrimonio }

class function TTipoPatrimonio.new: iModelTipoPatrimonio;
begin
  result := self.create;
end;

constructor TTipoPatrimonio.create;
begin
  //
end;

destructor TTipoPatrimonio.destroy;
begin
  //
  inherited;
end;

function TTipoPatrimonio.ID(value: Integer): iModelTipoPatrimonio;
begin
  result := self;
  FID := value;
end;

function TTipoPatrimonio.Nome(value: String): iModelTipoPatrimonio;
begin
  result := self;
  FNome := value;
end;

function TTipoPatrimonio.BuscarPatrimonio(value: Integer): String;
var
  qry: TFDQuery;
begin

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT NOME FROM TIPO_PATRIMONIO WHERE ID = :ID');
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

function TTipoPatrimonio.PopulaCampos(value: Integer; AList: TStringList): iModelTipoPatrimonio;
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
    qry.SQL.Add('SELECT NOME FROM TIPO_PATRIMONIO WHERE ID = :ID');
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

function TTipoPatrimonio.PopulaListView(value: TListView): iModelTipoPatrimonio;
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
      ('SELECT ID, NOME FROM TIPO_PATRIMONIO');
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
        txt.Text := 'NOME';


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

      end;

      qry.Next
    end;
  finally
    value.EndUpdate;
    FreeAndNil(qry);
  end;
end;

function TTipoPatrimonio.ValidaCampos: iModelTipoPatrimonio;
begin
  result := self;

  if FNome.IsEmpty then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o nome do departamento!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

end;

function TTipoPatrimonio.ValidaPatrimonioDB(value: Integer): iModelTipoPatrimonio;
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
    qry.SQL.Add('SELECT ID FROM TIPO_PATRIMONIO WHERE NOME = :NOME');
     if acao = upUpdate then
    begin
      qry.SQL.Add(' AND ID <> :ID');
      qry.ParamByName('ID').AsInteger := value;
    end;
    qry.ParamByName('NOME').AsString := FNome;
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

function TTipoPatrimonio.editar(value: Integer): iModelTipoPatrimonio;
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
          qry.FetchOptions.RowsetSize := 50000;
          qry.Active := false;
          qry.SQL.Clear;
          qry.SQL.Add('UPDATE TIPO_PATRIMONIO SET NOME = :NOME WHERE ID = :ID');
          qry.ParamByName('NOME').AsString := FNome;
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

function TTipoPatrimonio.Gravar: iModelTipoPatrimonio;
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
    qry.SQL.Add('INSERT INTO TIPO_PATRIMONIO (NOME) VALUES (:NOME)');
    qry.ParamByName('NOME').AsString := FNome;

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

function TTipoPatrimonio.delete(value: Integer): iModelTipoPatrimonio;
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
          qry.FetchOptions.RowsetSize := 50000;
          qry.Active := false;
          qry.SQL.Clear;
          qry.SQL.Add('DELETE FROM TIPO_PATRIMONIO WHERE ID = :ID');
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
