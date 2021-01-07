unit uInterfaceRelatFornecedor;

interface

uses
  FMX.frxClass;
type
iModelRelatFornecedor = interface
  ['{5ECB80E8-0B22-4B1C-B2F2-412C46EA9F56}']

  function report(const pReport: TfrxReport): iModelRelatFornecedor;
  function TipoDeConsulta(value: Integer) : iModelRelatFornecedor;
  function Nome(value : string): iModelRelatFornecedor;
    function IDCidade(value: integer): iModelRelatFornecedor;
  function ValidarCampos: iModelRelatFornecedor;
  function FindAll: iModelRelatFornecedor;
  function Filter: iModelRelatFornecedor;

end;
implementation

end.
