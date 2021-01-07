unit uInterfacePatrimonio;

interface

uses
  FMX.ListView, System.Classes, FMX.Objects;

type

  iModelPatrimonio = interface
    ['{89115386-E0BC-4793-8B35-95A05870E63D}']

    function ID(value: Integer): iModelPatrimonio;
    function Qtd(value: Integer): iModelPatrimonio;
    function NumeroPlaca(value: Integer): iModelPatrimonio;
    function Status(value: Integer): iModelPatrimonio;
    function IdSala(value: Integer): iModelPatrimonio;
    function IdTipoPatrimonio(value: Integer): iModelPatrimonio;
    function EstadoFisico(value: Integer): iModelPatrimonio;
    function Cor(value: Integer): iModelPatrimonio;
    function Marca(value: string): iModelPatrimonio;
    function Valor(value: double): iModelPatrimonio;
    function Descricao(value: string): iModelPatrimonio;
    function DataCadastro(value: TDateTime): iModelPatrimonio;
    function DataAquisicao(value: TDateTime): iModelPatrimonio;
    function IdFornecedor(value: Integer): iModelPatrimonio;
    function Logo(value: TImage): iModelPatrimonio;
    function RetornaImg(value: Integer; AImage: TImage): iModelPatrimonio;
    function PopulaCampos(value: Integer; AList: TStringList): iModelPatrimonio;
    function ValidarCampos: iModelPatrimonio;
    function PopulaListview(value: tlistview): iModelPatrimonio;
    function ValidaDB(value: Integer): iModelPatrimonio;
    function Gravar: iModelPatrimonio;
    function Editar(value: Integer): iModelPatrimonio;
    function delete(value: Integer): iModelPatrimonio;
    function ValidaRemessaDB(numberplaca: Integer; value: Integer): iModelPatrimonio;
    function VerificaRelacionamentoSQL(campo: String; value: Integer): iModelPatrimonio;
  end;

implementation

end.
