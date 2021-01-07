unit uInterfaceUsuario;

interface

uses
  FMX.ListView, System.Classes, FMX.Objects;

type
  iModelUsuario = interface
    ['{88DE2D4A-47E3-4096-9722-403E1F550F82}']

    function ID(value: integer): iModelUsuario;
    function Nome(value: string): iModelUsuario;
    function Usuario(value: string): iModelUsuario;
    function Senha(value: string): iModelUsuario;
    function ValidaSenha(value: string): iModelUsuario;
    function Status(value: Integer): iModelUsuario;
    function ValidaLogin: iModelUsuario;
    function ValidarCampos: iModelUsuario;
    function VerificarUsuarioDB(value:integer): iModelUsuario;
    function PopulaListview(value : tlistview): iModelUsuario;
    function PopulaCampos(value: Integer; AList: TStringList): iModelUsuario;
    function Gravar: iModelUsuario;
    function Editar(value: integer): iModelUsuario;
    function delete(value: integer): iModelUsuario;
  end;

implementation

end.
