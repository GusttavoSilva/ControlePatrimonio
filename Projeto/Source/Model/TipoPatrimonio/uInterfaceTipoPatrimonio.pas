unit uInterfaceTipoPatrimonio;

interface

uses
  System.Classes, FMX.ListView;

type

  iModelTipoPatrimonio = interface
   ['{150B6DA9-D38B-4F10-9617-AEC655AE9193}']

    function ID(value: integer): iModelTipoPatrimonio;
    function Nome(value: String): iModelTipoPatrimonio;
    function ValidaCampos: iModelTipoPatrimonio;
    function PopulaCampos(value: integer; AList: TStringList): iModelTipoPatrimonio;
    function PopulaListView(value: TListView): iModelTipoPatrimonio;
     function ValidaPatrimonioDB(value: Integer): iModelTipoPatrimonio;
    function BuscarPatrimonio(value: integer): String;
    function editar(value: integer): iModelTipoPatrimonio;
    function delete(value: integer): iModelTipoPatrimonio;
    function Gravar: iModelTipoPatrimonio;
  end;

implementation

end.
