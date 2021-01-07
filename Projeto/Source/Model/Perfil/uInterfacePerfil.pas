unit uInterfacePerfil;

interface

uses
  FMX.ListView, System.Classes, FMX.Objects;

type

iModelPerfil = interface
  ['{D064C7E4-A563-4114-9C31-CFD126F85E12}']

  function ID(value:Integer):iModelPerfil;
  function Nome(value:String):iModelPerfil;
  function Telefone(value:String):iModelPerfil;
  function Endereco(value:String):iModelPerfil;
  function Bairro(value:String):iModelPerfil;
  function IdCidade(value:Integer):iModelPerfil;
  function CpfCnpj(value:String):iModelPerfil;
  function Logo(value:TImage):iModelPerfil;
  function RetornaImg(value: Integer; AImage: TImage): iModelPerfil;
  function PopulaCampos(value: Integer; AList: TStringList):iModelPerfil;
  function ValidarCampos:iModelPerfil;
  function PopulaListview(value: tlistview): iModelPerfil;
  function ValidaDB:iModelPerfil;
  function Gravar:iModelPerfil;
  function Editar(value: Integer):iModelPerfil;


end;

implementation

end.
