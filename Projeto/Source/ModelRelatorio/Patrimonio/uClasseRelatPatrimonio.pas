unit uClasseRelatPatrimonio;

interface

uses uInterfaceRelatPatrimonio, FireDAC.Stan.Param, Data.DB, FireDAC.Comp.Client,
  DmRelatorios, FMX.frxClass;

type

  TRelatPatrimonio = class(TInterfacedObject, iModelRelatPatrimonio)
  private
    FNumeroPlaca: Integer;
    FStatus: Integer;
    FIdSala: Integer;
    FIdDepartamento: Integer;
    FIdTipoPatrimonio: Integer;
    FEstadoFisico: Integer;
    FIdFornecedor: Integer;
    FString: String;

  public

    constructor create;
    destructor destroy;
    class function mew: iModelRelatPatrimonio;

    function NumeroPlaca(value: Integer): iModelRelatPatrimonio;
    function Status(value: Integer): iModelRelatPatrimonio;
    function IdSala(value: Integer): iModelRelatPatrimonio;
    function IdDepartamento(value: Integer): iModelRelatPatrimonio;
    function IdTipoPatrimonio(value: Integer): iModelRelatPatrimonio;
    function EstadoFisico(value: Integer): iModelRelatPatrimonio;
    function IdFornecedor(value: Integer): iModelRelatPatrimonio;

    function report(const pReport: TfrxReport): iModelRelatPatrimonio;
    function TipoDeConsulta(value: Integer): iModelRelatPatrimonio;
    function FindAll: iModelRelatPatrimonio;
    function Filter: iModelRelatPatrimonio;

  end;

implementation

{ TRelatPatrimonio }

uses u_Library, Form_Mensagem, System.SysUtils;

constructor TRelatPatrimonio.create;
begin

end;

destructor TRelatPatrimonio.destroy;
begin

end;

class function TRelatPatrimonio.mew: iModelRelatPatrimonio;
begin
  result := self.create;
end;

function TRelatPatrimonio.EstadoFisico(value: Integer): iModelRelatPatrimonio;
begin
  result := self;
  FEstadoFisico := value;
end;

function TRelatPatrimonio.IdDepartamento(value: Integer): iModelRelatPatrimonio;
begin
  result := self;
  FIdDepartamento := value;
end;

function TRelatPatrimonio.IdFornecedor(value: Integer): iModelRelatPatrimonio;
begin
  result := self;
  FIdFornecedor := value;
end;

function TRelatPatrimonio.IdSala(value: Integer): iModelRelatPatrimonio;
begin
  result := self;
  FIdSala := value;
end;

function TRelatPatrimonio.IdTipoPatrimonio(value: Integer): iModelRelatPatrimonio;
begin
  result := self;
  FIdTipoPatrimonio := value;
end;

function TRelatPatrimonio.NumeroPlaca(value: Integer): iModelRelatPatrimonio;
begin
  result := self;
  FNumeroPlaca := value;
end;

function TRelatPatrimonio.Status(value: Integer): iModelRelatPatrimonio;
begin
  result := self;
  FStatus := value;
end;

function TRelatPatrimonio.TipoDeConsulta(value: Integer): iModelRelatPatrimonio;
begin
  result := self;
end;

function TRelatPatrimonio.FindAll: iModelRelatPatrimonio;
begin
  result := self;

  DmRelatorio.QRelatPatrimonio.FetchOptions.RowsetSize := 50000;
  DmRelatorio.QRelatPatrimonio.Active := false;
  DmRelatorio.QRelatPatrimonio.sql.Clear;
  DmRelatorio.QRelatPatrimonio.sql.Add
    (' select p.id, p.numero_placa, t.nome as tipopatrimonio, p.marca, f.nome as fornecedor, concat(s.nome, '' - '',  d.nome) as sala, '
    + ' case p.cor ' + ' when 1 then ''AMARELO'' when 2 then ''AZUL'' ' +
    ' when 3 then ''BEGE'' when 4 then ''BRANCO'' ' + ' when 5 then ''CINZA'' when 6 then ''LARANJA'' ' +
    ' when 7 then ''MARROM'' when 8 then ''PRETA'' ' + ' when 9 then ''ROXO'' when 10 then ''VERDE'' ' +
    ' when 11 then ''VERMELHO'' end as cor, ' + ' case p.status ' +
    ' when 1 then ''INATIVO'' when 2 then ''ATIVO'' end as status, ' + ' case p.estado_fisico ' +
    ' when 1 then ''NOVO'' when 2 then ''BOM'' ' + ' when 3 then ''OCIOSO'' when 4 then ''RECUPERÁVEL'' ' +
    ' when 5 then ''ANTIECONÔMICO'' when 6 then ''IRRECUPERÁVEL'' end as conservacao, ' +
    ' IFNULL(p.valor, 0) as valor, '+
    ' date_format(p.data_aquisicao, ''%d/%m/%Y'') as data_aquisicao, '+
    ' date_format(p.data_cadastro, ''%d/%m/%Y'') as data_cadastro '+
    ' from patrimonio p ' + ' left outer join salas s on (p.id_sala = s.id) ' +
    ' left outer join tipo_patrimonio t on (p.id_tipo_patrimonio = t.id) ' +
    ' left outer join fornecedores f on (p.id_fornecedor = f.id) ' +
    ' left outer join departamento d on (s.id_departamento = d.id) ');

  DmRelatorio.QRelatPatrimonio.sql.Add(FString);
  DmRelatorio.QRelatPatrimonio.sql.Add('order by p.numero_placa');

  DmRelatorio.QRelatPatrimonio.Open;

  if DmRelatorio.QRelatPatrimonio.RecordCount = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Não exite registro cadastrado!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;
end;

function TRelatPatrimonio.Filter: iModelRelatPatrimonio;
begin
  result := self;

  if FStatus = 0 then
    FString := 'where p.status <> 0'
  else
    FString := 'where p.status = ' + IntToStr(FStatus);

  if FEstadoFisico = 0 then
    FString := FString + ' and p.estado_fisico <> 0'
  else
    FString := FString + ' and p.estado_fisico = ' + IntToStr(FEstadoFisico);

  if FNumeroPlaca <> 0 then
    FString := FString + ' and p.numero_placa = ' + IntToStr(FNumeroPlaca);

  if FIdSala <> 0 then
    FString := FString + ' and p.id_sala = ' + IntToStr(FIdSala);

  if FIdDepartamento <> 0 then
    FString := FString + ' and d.id = ' + IntToStr(FIdDepartamento);

  if FIdTipoPatrimonio <> 0 then
    FString := FString + ' and p.id_tipo_patrimonio = ' + IntToStr(FIdTipoPatrimonio);

  if FIdFornecedor <> 0 then
    FString := FString + ' and p.id_fornecedor = ' + IntToStr(FIdFornecedor);

end;

function TRelatPatrimonio.report(const pReport: TfrxReport): iModelRelatPatrimonio;
begin
    result := self;
  pReport.PrepareReport;
  pReport.ShowPreparedReport;
end;

end.
