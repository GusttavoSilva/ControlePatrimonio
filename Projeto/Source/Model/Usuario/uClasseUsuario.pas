unit uClasseUsuario;

interface

uses uInterfaceUsuario, FireDAC.Comp.Client, FMX.ListView, uDmDados, System.SysUtils, FMX.Dialogs, u_Library, Form_Mensagem,
  FMX.ListView.Appearances, FMX.ListView.Types, System.UITypes, FireDAC.Stan.Param, Data.DB, System.Classes;

type
  Tusuario = class(TInterfacedObject, iModelUsuario)
  private
    FID: integer;
    FNome: String;
    FUsuario: String;
    FSenha: String;
    FValidaSenha: String;
    FStatus: Integer;

  public

    constructor create;
    destructor destroy; override;
    class function new: iModelUsuario;

    function ID(value: integer): iModelUsuario;
    function Nome(value: string): iModelUsuario;
    function Usuario(value: string): iModelUsuario;
    function Senha(value: string): iModelUsuario;
    function Status(value: Integer): iModelUsuario;
    function ValidaSenha(value: string): iModelUsuario;
    function ValidaLogin: iModelUsuario;
    function ValidarCampos: iModelUsuario;
    function VerificarUsuarioDB(value:integer): iModelUsuario;
    function PopulaListview(value: tlistview): iModelUsuario;
    function PopulaCampos(value: Integer; AList: TStringList): iModelUsuario;
    function Gravar: iModelUsuario;
    function Editar(value: integer): iModelUsuario;
    function delete(value: integer): iModelUsuario;

  end;

implementation

{ Tusuario }

constructor Tusuario.create;
begin
  //
end;

destructor Tusuario.destroy;
begin
  //
  inherited;
end;

class function Tusuario.new: iModelUsuario;
begin
  result := self.create;
end;

function Tusuario.ID(value: integer): iModelUsuario;
begin
  result := self;
  FID := value;
end;

function Tusuario.Nome(value: string): iModelUsuario;
begin
  result := self;
  FNome := trim(value);
end;

function Tusuario.Usuario(value: string): iModelUsuario;
begin
  result := self;
  FUsuario := trim(value);
end;

function Tusuario.Senha(value: string): iModelUsuario;
begin
  result := self;
  FSenha := trim(value);
end;

function Tusuario.Status(value: Integer): iModelUsuario;
begin
   result := self;
  FStatus := value;
end;

function Tusuario.ValidaSenha(value: string): iModelUsuario;
begin
  result := self;
  FValidaSenha :=trim(value);
end;

function Tusuario.PopulaCampos(value: Integer; aList: TStringList): iModelUsuario;
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
    qry.SQL.Add('SELECT NOME, USUARIO, SENHA, STATUS FROM USUARIOS WHERE ID = :ID');
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

function Tusuario.PopulaListview(value: tlistview): iModelUsuario;
var
  x: integer;
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
    qry.SQL.Add('SELECT ID, NOME, USUARIO, CASE WHEN STATUS = 1 THEN ''ATIVO'' ELSE ''INATIVO'' END AS STATUS FROM USUARIOS');
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

        txt := TListItemText(Objects.FindDrawable('lbl_usuario'));
        txt.Text := 'USUARIO';

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

        txt := TListItemText(Objects.FindDrawable('USUARIO'));
        txt.Text := qry.FieldByName('usuario').AsString;

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

function Tusuario.ValidarCampos: iModelUsuario;
begin
  result := self;
  if FNome.IsEmpty then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o nome do usuario!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if (FUsuario.IsEmpty) and (Acao = upInsert) then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe um usuario!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FSenha.IsEmpty then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o nome do usuario!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if not(FValidaSenha.Equals(FSenha)) then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Senhas não conferem!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

end;

function Tusuario.VerificarUsuarioDB(value:integer): iModelUsuario;
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
    qry.SQL.Add('SELECT ID FROM USUARIOS WHERE USUARIO = :USUARIO ');
       if acao = upUpdate then
    begin
      qry.SQL.Add(' AND ID <> :ID');
      qry.ParamByName('ID').AsInteger := value;
    end;
    qry.ParamByName('USUARIO').AsString := FUsuario;
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

function Tusuario.ValidaLogin: iModelUsuario;
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
    qry.SQL.Add('SELECT ID, NOME  FROM USUARIOS WHERE USUARIO = :USUARIO AND SENHA = :SENHA AND STATUS = 1');
    qry.ParamByName('USUARIO').AsString := FUsuario;
    qry.ParamByName('SENHA').AsString := FSenha;
    qry.Open;


    CodUsuario := qry.FieldByName('ID').AsInteger;
    NomeUsuario := qry.FieldByName('NOME').AsString;

    if qry.RecordCount = 0 then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Usuario ou senha invalido!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;
end;

function Tusuario.Gravar: iModelUsuario;
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
    qry.SQL.Add('INSERT INTO USUARIOS (NOME, USUARIO, SENHA, STATUS) VALUES (:NOME, :USUARIO, :SENHA, :STATUS);');
    qry.ParamByName('NOME').AsString := FNome;
    qry.ParamByName('USUARIO').AsString := FUsuario;
    qry.ParamByName('SENHA').AsString := FSenha;
    qry.ParamByName('STATUS').AsInteger := FStatus;

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

function Tusuario.Editar(value: integer): iModelUsuario;
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
          qry.SQL.Add('UPDATE USUARIOS SET NOME  = :NOME, SENHA = :SENHA, STATUS = :STATUS WHERE ID = :ID');
          qry.ParamByName('NOME').AsString := FNome;
          qry.ParamByName('SENHA').AsString := FSenha;
          qry.ParamByName('STATUS').AsInteger := FStatus;
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

function Tusuario.delete(value: integer): iModelUsuario;
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
          qry.SQL.Add('DELETE FROM USUARIOS WHERE ID = :ID;');
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

end.
