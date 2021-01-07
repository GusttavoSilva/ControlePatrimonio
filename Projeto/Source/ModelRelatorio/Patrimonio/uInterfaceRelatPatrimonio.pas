unit uInterfaceRelatPatrimonio;

interface

uses
  FMX.frxClass;

type
  iModelRelatPatrimonio = interface
    ['{19C24199-12DC-43FA-83B8-76DB39F3E4F1}']

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

end.
