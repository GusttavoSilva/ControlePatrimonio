unit uInterfaceSala;

interface

uses
  FMX.ListView, System.Classes;

type

  iModelSala = interface
    ['{D04C2265-0B61-4FBE-8FB5-2882FE218A46}']

    function ID(value: Integer): iModelSala;
    function Sala(value: string): iModelSala;
    function Descricao(value: string): iModelSala;
    function Status(value: Integer): iModelSala;
    function IdDepartamento(value: Integer): iModelSala;
    function ValidaCampos: iModelSala;
    function PopulaCampos(value: Integer; AList: TStringList): iModelSala;
    function PopulaListView(value: TListView): iModelSala;
    function ValidaSalaDB(value: Integer): iModelSala;
    function BuscarSala(value: Integer): String;
    function editar(value: Integer): iModelSala;
    function delete(value: Integer): iModelSala;
    function Gravar: iModelSala;

  end;

implementation

end.
