unit uClasseRelatFornecedor;

interface

uses uInterfaceRelatFornecedor, FireDAC.Stan.Param, Data.DB, FireDAC.Comp.Client,
  DmRelatorios, FMX.frxClass;

type

  TRelatFornecedor = class(TInterfacedObject, iModelRelatFornecedor)
  private
    FNome: String;
    FIdCidade: Integer;
    FString: string;

    FTipoDeConsulta: Integer;
  public

    constructor create;
    destructor destroy;
    class function mew: iModelRelatFornecedor;

    function report(const pReport: TfrxReport): iModelRelatFornecedor;
    function Nome(value: string): iModelRelatFornecedor;
    function IDCidade(value: Integer): iModelRelatFornecedor;
    function ValidarCampos: iModelRelatFornecedor;
    function FindAll: iModelRelatFornecedor;
    function TipoDeConsulta(value: Integer): iModelRelatFornecedor;
    function Filter: iModelRelatFornecedor;
  end;

implementation

uses
  System.SysUtils, u_Library, Form_Mensagem;

{ TRelatFornecedor }

class function TRelatFornecedor.mew: iModelRelatFornecedor;
begin
  result := self.create;
end;

constructor TRelatFornecedor.create;
begin

end;

destructor TRelatFornecedor.destroy;
begin

end;

function TRelatFornecedor.Nome(value: string): iModelRelatFornecedor;
begin
  result := self;
  FNome := value;
end;

function TRelatFornecedor.IDCidade(value: Integer): iModelRelatFornecedor;
begin
  result := self;
  FIdCidade := value;
end;

function TRelatFornecedor.TipoDeConsulta(value: Integer): iModelRelatFornecedor;
begin
  result := self;
  FTipoDeConsulta := value;
end;

function TRelatFornecedor.ValidarCampos: iModelRelatFornecedor;
begin
  result := self;

  case FTipoDeConsulta of
    2:
      begin
        if (FNome.IsEmpty) then
          Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Digite um nome valido!', 'OK', '', $FFDF5447, $FFDF5447);
        Frm_Mensagem.Show;
        abort;

      End;
    3:
      begin
        if (FIdCidade = 0) then
          Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Informe uma cidade valida!', 'OK', '', $FFDF5447, $FFDF5447);
        Frm_Mensagem.Show;
        abort;
      end;
  end;

end;

function TRelatFornecedor.FindAll: iModelRelatFornecedor;
begin
  result := self;

  DmRelatorio.QRelatFornecedor.FetchOptions.RowsetSize := 50000;
  DmRelatorio.QRelatFornecedor.Active := false;
  DmRelatorio.QRelatFornecedor.sql.Clear;
  DmRelatorio.QRelatFornecedor.sql.Add
    (' SELECT F.ID, F.NOME, F.CPFCNPJ, F.TELEFONE, UPPER(CONCAT(M.NOME, '' - '', M.UF)) AS CIDADE FROM FORNECEDORES F '
    + ' LEFT OUTER JOIN MUNICIPIO M ON (M.ID = F.ID_CIDADE) ');

  DmRelatorio.QRelatFornecedor.sql.Add(FString);

  DmRelatorio.QRelatFornecedor.Open;

  if DmRelatorio.QRelatFornecedor.RecordCount = 0 then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Não exite registro cadastrado!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end;

end;

function TRelatFornecedor.Filter: iModelRelatFornecedor;
begin
  result := self;

  case FTipoDeConsulta of
    1:
      FString := '';
    2:
      begin
        FString := ' WHERE F.NOME LIKE ''%' + FNome + '%''';

      End;
    3:
      begin
        FString := ' WHERE F.ID_CIDADE = ' + IntToStr(FIdCidade);
      end;
  end;

end;

function TRelatFornecedor.report(const pReport: TfrxReport): iModelRelatFornecedor;
begin
  result := self;
  pReport.PrepareReport;
  pReport.ShowPreparedReport;
end;

end.
