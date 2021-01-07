unit uInterfaceDepartamento;

interface

uses
  FMX.ListView, System.Classes;

type

  iModelDepartamento = interface
    ['{316C585C-81F1-486A-BBA2-943B83DE48CF}']

    function ID(value: integer): iModelDepartamento;
    function Nome(value: String): iModelDepartamento;
    function Descricao(value: String): iModelDepartamento;
    function Status(value: integer): iModelDepartamento;
    function ValidaCampos: iModelDepartamento;
    function PopulaCampos(value: integer; AList: TStringList): iModelDepartamento;
    function PopulaListView(value: TListView): iModelDepartamento;
     function ValidaDepartamentoDB(value: Integer): iModelDepartamento;
    function BuscarDepartamento(value: integer): String;
    function editar(value: integer): iModelDepartamento;
    function delete(value: integer): iModelDepartamento;
    function Gravar: iModelDepartamento;
    function VerificaExisteSalaSQL: iModelDepartamento;
  end;

implementation

end.
