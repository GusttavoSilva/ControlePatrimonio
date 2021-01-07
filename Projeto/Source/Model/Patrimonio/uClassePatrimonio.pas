unit uClassePatrimonio;

interface

uses uInterfacePatrimonio, FMX.Objects, System.Classes, FMX.ListView,
  System.SysUtils, FireDAC.Comp.Client, Form_Mensagem, u_Library, uDmDados,
  Data.DB, System.UITypes, FMX.ListView.Appearances, FMX.ListView.Types,
  FireDAC.Stan.Param;

type
  TPatrimonio = class(TInterfacedObject, iModelPatrimonio)
  private
    FID: integer;
    FQtd: integer;
    FNumeroPlaca: integer;
    FStatus: integer;
    FIdSala: integer;
    FIdTipoPatrimonio: integer;
    FEstadoFisico: integer;
    FCor: integer;
    FMarca: string;
    FValor: double;
    FDescricao: string;
    FDataCadastro: TDateTime;
    FDataAquisicao: TDateTime;
    FIdFornecedor: integer;
    FLogo: TImage;
  public
    constructor create;
    destructor destroy; override;
    class function new: iModelPatrimonio;

    function ID(value: integer): iModelPatrimonio;
    function Qtd(value: integer): iModelPatrimonio;
    function NumeroPlaca(value: integer): iModelPatrimonio;
    function Status(value: integer): iModelPatrimonio;
    function IdSala(value: integer): iModelPatrimonio;
    function IdTipoPatrimonio(value: integer): iModelPatrimonio;
    function EstadoFisico(value: integer): iModelPatrimonio;
    function Cor(value: integer): iModelPatrimonio;
    function Marca(value: string): iModelPatrimonio;
    function Valor(value: double): iModelPatrimonio;
    function Descricao(value: string): iModelPatrimonio;
    function DataCadastro(value: TDateTime): iModelPatrimonio;
    function DataAquisicao(value: TDateTime): iModelPatrimonio;
    function IdFornecedor(value: integer): iModelPatrimonio;
    function Logo(value: TImage): iModelPatrimonio;
    function RetornaImg(value: integer; AImage: TImage): iModelPatrimonio;
    function PopulaCampos(value: integer; AList: TStringList): iModelPatrimonio;
    function ValidarCampos: iModelPatrimonio;
    function PopulaListview(value: tlistview): iModelPatrimonio;
    function ValidaDB(value: integer): iModelPatrimonio;
    function Gravar: iModelPatrimonio;
    function Editar(value: integer): iModelPatrimonio;
    function delete(value: integer): iModelPatrimonio;
    function ValidaRemessaDB(numberplaca: integer; value: integer): iModelPatrimonio;
    function VerificaRelacionamentoSQL(campo: String; value: integer): iModelPatrimonio;
  end;

implementation

{ TPatrimonio }

class function TPatrimonio.new: iModelPatrimonio;
begin
  result := Self.create;
end;

constructor TPatrimonio.create;
begin

end;

destructor TPatrimonio.destroy;
begin

  inherited;
end;

function TPatrimonio.Cor(value: integer): iModelPatrimonio;
begin
  result := Self;
  FCor := value;
end;

function TPatrimonio.Descricao(value: string): iModelPatrimonio;
begin
  result := Self;
  FDescricao := trim(value);
end;

function TPatrimonio.DataAquisicao(value: TDateTime): iModelPatrimonio;
begin
  result := Self;
  FDataAquisicao := value;
end;

function TPatrimonio.DataCadastro(value: TDateTime): iModelPatrimonio;
begin
  result := Self;
  FDataCadastro := value;
end;

function TPatrimonio.EstadoFisico(value: integer): iModelPatrimonio;
begin
  result := Self;
  FEstadoFisico := value;
end;

function TPatrimonio.ID(value: integer): iModelPatrimonio;
begin
  result := Self;
  FID := value;
end;

function TPatrimonio.Qtd(value: integer): iModelPatrimonio;
begin
  result := Self;
  FQtd := value;
end;

function TPatrimonio.IdFornecedor(value: integer): iModelPatrimonio;
begin
  result := Self;
  FIdFornecedor := value;
end;

function TPatrimonio.IdSala(value: integer): iModelPatrimonio;
begin
  result := Self;
  FIdSala := value
end;

function TPatrimonio.IdTipoPatrimonio(value: integer): iModelPatrimonio;
begin
  result := Self;
  FIdTipoPatrimonio := value;
end;

function TPatrimonio.Logo(value: TImage): iModelPatrimonio;
begin
  result := Self;
  FLogo := value
end;

function TPatrimonio.Marca(value: string): iModelPatrimonio;
begin
  result := Self;
  FMarca := trim(value);
end;

function TPatrimonio.NumeroPlaca(value: integer): iModelPatrimonio;
begin
  result := Self;
  FNumeroPlaca := value;
end;

function TPatrimonio.Status(value: integer): iModelPatrimonio;
begin
  result := Self;
  FStatus := value;
end;

function TPatrimonio.Valor(value: double): iModelPatrimonio;
begin
  result := Self;
  FValor := value;
end;

function TPatrimonio.VerificaRelacionamentoSQL(campo: String; value: integer): iModelPatrimonio;
var
  qry: TFDQuery;
  I: integer;
begin

  result := Self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ' + campo + ' FROM PATRIMONIO WHERE ' + campo + ' = :value ');
    qry.ParamByName('value').AsInteger := value;
    qry.Open;

    if qry.RecordCount <> 0 then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro',
        'Não é possivel deletar pois existe patrimônio com esse relacionamento!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;

end;

function TPatrimonio.PopulaCampos(value: integer; AList: TStringList): iModelPatrimonio;
var
  qry: TFDQuery;
  I: integer;
begin

  result := Self;

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add
      ('SELECT NUMERO_PLACA, STATUS, ID_SALA, ID_TIPO_PATRIMONIO, ESTADO_FISICO, COR, MARCA, VALOR, DESCRICAO, ID_FORNECEDOR, DATA_CADASTRO, DATA_AQUISICAO FROM PATRIMONIO WHERE ID = :ID');
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

function TPatrimonio.RetornaImg(value: integer; AImage: TImage): iModelPatrimonio;
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
    qry.SQL.Add('SELECT FOTO FROM PATRIMONIO WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := value;
    qry.Open;

    if qry.RecordCount = 0 then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Registro não encontrado!', 'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end
    else if qry.FieldByName('FOTO').AsString <> '' then
    begin

      vStream := TMemoryStream.create;
      TBlobField(qry.FieldByName('foto')).SaveToStream(vStream);
      vStream.Position := 0;
      AImage.MultiResBitmap.LoadItemFromStream(vStream, 1);
      vStream.Free;

    end
    else
      AImage.Bitmap := nil;
  finally
    FreeAndNil(qry);
  end;
end;

function TPatrimonio.PopulaListview(value: tlistview): iModelPatrimonio;
var
  x: integer;
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
    qry.SQL.Add
      ('SELECT P.ID, P.NUMERO_PLACA, P.STATUS, S.NOME AS SALA, TP.NOME AS TIPO_PATRIMONIO, P.ESTADO_FISICO, P.COR, P.MARCA, P.VALOR, P.DESCRICAO, F.NOME AS FORNECEDOR FROM PATRIMONIO P  '
      + ' LEFT OUTER JOIN SALAS S ON (S.ID = P.ID_SALA) ' +
      ' LEFT OUTER JOIN TIPO_PATRIMONIO TP ON (TP.ID = P.ID_TIPO_PATRIMONIO) ' +
      ' LEFT OUTER JOIN FORNECEDORES F ON (F.ID = P.ID_FORNECEDOR);');
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

        txt := TListItemText(Objects.FindDrawable('lbl_numeroplaca'));
        txt.Text := 'Nº PLACA';

        txt := TListItemText(Objects.FindDrawable('lbl_status'));
        txt.Text := 'STATUS';

        txt := TListItemText(Objects.FindDrawable('lbl_sala'));
        txt.Text := 'SALA';

        txt := TListItemText(Objects.FindDrawable('lbl_tipopatrimonio'));
        txt.Text := 'TIPO PATRIMONIO';

        txt := TListItemText(Objects.FindDrawable('lbl_estadofisico'));
        txt.Text := 'ESTADO FÍSICO';

        txt := TListItemText(Objects.FindDrawable('lbl_cor'));
        txt.Text := 'COR';

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

        txt := TListItemText(Objects.FindDrawable('NUMEROPLACA'));
        txt.Text := qry.FieldByName('numero_placa').AsString;

        txt := TListItemText(Objects.FindDrawable('STATUS'));
        txt.Text := StatusExtenso(qry.FieldByName('status').AsInteger);

        txt := TListItemText(Objects.FindDrawable('SALA'));
        txt.Text := qry.FieldByName('sala').AsString;

        txt := TListItemText(Objects.FindDrawable('TIPOPATRIMONIO'));
        txt.Text := qry.FieldByName('tipo_patrimonio').AsString;

        txt := TListItemText(Objects.FindDrawable('ESTADOFISICO'));
        txt.Text := ConservacaoExtenso(qry.FieldByName('estado_fisico').AsInteger);

        txt := TListItemText(Objects.FindDrawable('COR'));
        txt.Text := CorExtenso(qry.FieldByName('cor').AsInteger);
      end;

      qry.Next
    end;
  finally
    value.EndUpdate;
    FreeAndNil(qry);
  end;
end;

function TPatrimonio.ValidaDB(value: integer): iModelPatrimonio;
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
    qry.SQL.Add('SELECT ID FROM PATRIMONIO WHERE NUMERO_PLACA = :NUMERO_PLACA ');
    qry.ParamByName('NUMERO_PLACA').AsInteger := FNumeroPlaca;
    qry.Open;

    if (qry.RecordCount <> 0) and (Acao = upInsert) then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Esse número de placa já está cadastrado em outro patrimonio!', 'OK',
        '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;
end;

function TPatrimonio.ValidarCampos: iModelPatrimonio;
begin
  result := Self;
  if FNumeroPlaca = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o número da placa do patrimonio!', 'OK', '', $FFDF5447,
      $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FStatus = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe uma status válido!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FIdSala = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe uma sala válida!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FIdTipoPatrimonio = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe uma tipo de patrimonio válido!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FEstadoFisico = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe o estado físico do patrimonio!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

  if FCor = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe a cor do patrimonio!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

end;

function TPatrimonio.Gravar: iModelPatrimonio;
var
  qry: TFDQuery;
  I: integer;
begin
  result := Self;
  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.Close;
    qry.SQL.Clear;
    if FQtd > 1 then
    begin
      for I := 0 to FQtd - 1 do
      begin
        ValidaRemessaDB(FNumeroPlaca, I);
      end;

      for I := 0 to FQtd - 1 do
      begin
        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add
          ('INSERT INTO PATRIMONIO (NUMERO_PLACA, STATUS, ID_SALA, ID_TIPO_PATRIMONIO, ESTADO_FISICO, COR, MARCA, VALOR, DESCRICAO, ID_FORNECEDOR, FOTO, DATA_CADASTRO, DATA_AQUISICAO) '
          + ' VALUES (:NUMERO_PLACA, :STATUS, :ID_SALA, :ID_TIPO_PATRIMONIO, :ESTADO_FISICO, :COR, :MARCA, :VALOR, :DESCRICAO, :ID_FORNECEDOR, :FOTO, :DATA_CADASTRO, :DATA_AQUISICAO);');
        qry.ParamByName('NUMERO_PLACA').AsInteger := FNumeroPlaca + I;
        qry.ParamByName('STATUS').AsInteger := FStatus;
        qry.ParamByName('ID_SALA').AsInteger := FIdSala;
        qry.ParamByName('ID_TIPO_PATRIMONIO').AsInteger := FIdTipoPatrimonio;
        qry.ParamByName('ESTADO_FISICO').AsInteger := FEstadoFisico;
        qry.ParamByName('COR').AsInteger := FCor;
        qry.ParamByName('MARCA').AsString := FMarca;
        qry.ParamByName('VALOR').AsFloat := FValor;
        qry.ParamByName('DESCRICAO').AsString := FDescricao;
        qry.ParamByName('ID_FORNECEDOR').AsInteger := FIdFornecedor;
        qry.ParamByName('FOTO').Assign(FLogo.Bitmap);
        qry.ParamByName('DATA_CADASTRO').AsDateTime := FDataCadastro;
        qry.ParamByName('DATA_AQUISICAO').AsDateTime := FDataAquisicao;

        try
          qry.ExecSQL;
        except
          Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao salvar novo patrimonio!', 'OK', '', $FFDF5447, $FFDF5447);
          Frm_Mensagem.Show;
          exit;
        end;
      end;
    end
    else
    begin
      qry.Active := false;
      qry.SQL.Clear;
      qry.SQL.Add
        ('INSERT INTO PATRIMONIO (NUMERO_PLACA, STATUS, ID_SALA, ID_TIPO_PATRIMONIO, ESTADO_FISICO, COR, MARCA, VALOR, DESCRICAO, ID_FORNECEDOR, FOTO, DATA_CADASTRO, DATA_AQUISICAO) '
        + ' VALUES (:NUMERO_PLACA, :STATUS, :ID_SALA, :ID_TIPO_PATRIMONIO, :ESTADO_FISICO, :COR, :MARCA, :VALOR, :DESCRICAO, :ID_FORNECEDOR, :FOTO, :DATA_CADASTRO, :DATA_AQUISICAO );');
      qry.ParamByName('NUMERO_PLACA').AsInteger := FNumeroPlaca;
      qry.ParamByName('STATUS').AsInteger := FStatus;
      qry.ParamByName('ID_SALA').AsInteger := FIdSala;
      qry.ParamByName('ID_TIPO_PATRIMONIO').AsInteger := FIdTipoPatrimonio;
      qry.ParamByName('ESTADO_FISICO').AsInteger := FEstadoFisico;
      qry.ParamByName('COR').AsInteger := FCor;
      qry.ParamByName('MARCA').AsString := FMarca;
      qry.ParamByName('VALOR').AsFloat := FValor;
      qry.ParamByName('DESCRICAO').AsString := FDescricao;
      qry.ParamByName('ID_FORNECEDOR').AsInteger := FIdFornecedor;
      qry.ParamByName('FOTO').Assign(FLogo.Bitmap);
      qry.ParamByName('DATA_CADASTRO').AsDateTime := FDataCadastro;
      qry.ParamByName('DATA_AQUISICAO').AsDateTime := FDataAquisicao;

      try
        qry.ExecSQL;
      except
        Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao salvar novo patrimonio!', 'OK', '', $FFDF5447, $FFDF5447);
        Frm_Mensagem.Show;
        exit;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TPatrimonio.Editar(value: integer): iModelPatrimonio;
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
            ('UPDATE PATRIMONIO SET NUMERO_PLACA  = :NUMERO_PLACA, STATUS = :STATUS, ID_SALA = :ID_SALA , ID_TIPO_PATRIMONIO = :ID_TIPO_PATRIMONIO '
            + ', ESTADO_FISICO = :ESTADO_FISICO, COR = :COR, MARCA = :MARCA, VALOR = :VALOR, DESCRICAO = :DESCRICAO, ID_FORNECEDOR = :ID_FORNECEDOR, FOTO = :FOTO, DATA_AQUISICAO = :DATA_AQUISICAO WHERE ID = :ID');
          qry.ParamByName('NUMERO_PLACA').AsInteger := FNumeroPlaca;
          qry.ParamByName('STATUS').AsInteger := FStatus;
          qry.ParamByName('ID_SALA').AsInteger := FIdSala;
          qry.ParamByName('ID_TIPO_PATRIMONIO').AsInteger := FIdTipoPatrimonio;
          qry.ParamByName('ESTADO_FISICO').AsInteger := FEstadoFisico;
          qry.ParamByName('COR').AsInteger := FCor;
          qry.ParamByName('MARCA').AsString := FMarca;
          qry.ParamByName('VALOR').AsFloat := FValor;
          qry.ParamByName('DESCRICAO').AsString := FDescricao;
          qry.ParamByName('ID_FORNECEDOR').AsInteger := FIdFornecedor;
          qry.ParamByName('FOTO').Assign(FLogo.Bitmap);
          qry.ParamByName('ID').AsInteger := value;
          qry.ParamByName('DATA_AQUISICAO').AsDateTime := FDataAquisicao;

          try
            qry.ExecSQL;;
          except
            Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao editar patrimonio!', 'OK', '', $FFDF5447, $FFDF5447);
            Frm_Mensagem.Show;
            exit;

          end;
        finally
          FreeAndNil(qry);
        end;
      end;
    end);
end;

function TPatrimonio.delete(value: integer): iModelPatrimonio;
var
  qry: TFDQuery;
begin

  result := Self;
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
          qry.SQL.Add('DELETE FROM PATRIMONIO WHERE ID = :ID;');
          qry.ParamByName('ID').AsInteger := value;
          try
            qry.ExecSQL;

          except
            Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Erro ao deletar patrimonio!', 'OK', '', $FFDF5447, $FFDF5447);
            Frm_Mensagem.Show;
            exit;

          end;
        finally
          FreeAndNil(qry);
        end;
      end;
    end);
end;

function TPatrimonio.ValidaRemessaDB(numberplaca: integer; value: integer): iModelPatrimonio;
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
    qry.SQL.Add('SELECT ID FROM PATRIMONIO WHERE NUMERO_PLACA = :NUMERO_PLACA ');
    qry.ParamByName('NUMERO_PLACA').AsInteger := numberplaca + value;
    qry.Open;

    if qry.RecordCount <> 0 then
    begin
      Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Esse nº de placa (' + IntToStr(numberplaca + value) +
        ') já está cadastrado em outro patrimonio ' + IntToStr(value) + ' número(s) a frente do nº de placa inicial.',
        'OK', '', $FFDF5447, $FFDF5447);
      Frm_Mensagem.Show;
      abort;
    end;

  finally
    FreeAndNil(qry);
  end;
end;

end.
