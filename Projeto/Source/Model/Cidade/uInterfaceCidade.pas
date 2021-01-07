unit uInterfaceCidade;

interface

uses
  System.Classes, FMX.ListView;

type

  iModelCidade = interface
  ['{74DA75F4-121B-4567-BD99-7733E70C65C4}']

    function ID(value: integer): iModelCidade;
    function Nome(value: String): iModelCidade;
    function PopulaListView(value: TListView): iModelCidade;
    function BuscarCidade(value: integer): String;
  end;

implementation

end.
