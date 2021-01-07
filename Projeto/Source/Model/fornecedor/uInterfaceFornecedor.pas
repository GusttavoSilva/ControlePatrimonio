unit uInterfaceFornecedor;

interface

uses
  FMX.ListView, System.Classes;

type

  iModelFornecedor = interface
    ['{80221662-A008-4ABA-B55D-32CC8CACE51B}']

    function ID(value: integer): iModelFornecedor;
    function Nome(value: string): iModelFornecedor;
    function Telefone(value: string): iModelFornecedor;
    function CpfCnpj(value: string): iModelFornecedor;
    function Endereco(value: string): iModelFornecedor;
    function Bairro(value: String): iModelFornecedor;

    function IdCidade(value: integer): iModelFornecedor;
    function ValidarCampos: iModelFornecedor;
    function VerificarFornecedorDB(value: integer): iModelFornecedor;
    function PopulaListview(value: tlistview): iModelFornecedor;
    function PopulaCampos(value: integer; AList: TStringList): iModelFornecedor;
    function BuscarFornecedor(value: Integer): String;
    function Gravar: iModelFornecedor;
    function Editar(value: integer): iModelFornecedor;
    function delete(value: integer): iModelFornecedor;
  end;

implementation

end.
