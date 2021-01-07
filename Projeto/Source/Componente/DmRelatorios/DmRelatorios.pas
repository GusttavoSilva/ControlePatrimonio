unit DmRelatorios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FMX.frxClass, FMX.frxDBSet, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uDmDados;

type
  TDmRelatorio = class(TDataModule)
    QRelatFornecedor: TFDQuery;
    frxDBDataset1: TfrxDBDataset;
    QRelatFornecedorID: TFDAutoIncField;
    QRelatFornecedorNOME: TStringField;
    QRelatFornecedorCPFCNPJ: TStringField;
    QRelatFornecedorTELEFONE: TStringField;
    QRelatFornecedorCIDADE: TStringField;
    QPerfil: TFDQuery;
    frxDBDataset2: TfrxDBDataset;
    QPerfilid: TFDAutoIncField;
    QPerfilnome: TStringField;
    QPerfiltelefone: TStringField;
    QPerfilendereco: TStringField;
    QPerfilbairro: TStringField;
    QPerfilid_cidade: TIntegerField;
    QPerfilcpfcnpj: TStringField;
    QPerfillogo: TBlobField;
    QPerfilCIDADE: TStringField;
    QRelatPatrimonio: TFDQuery;
    frxDBDataset3: TfrxDBDataset;
    QRelatPatrimonioid: TIntegerField;
    QRelatPatrimonionumero_placa: TIntegerField;
    QRelatPatrimoniotipopatrimonio: TStringField;
    QRelatPatrimoniomarca: TStringField;
    QRelatPatrimoniofornecedor: TStringField;
    QRelatPatrimoniosala: TStringField;
    QRelatPatrimoniocor: TStringField;
    QRelatPatrimoniostatus: TStringField;
    QRelatPatrimonioconservacao: TStringField;
    QRelatPatrimoniovalor: TSingleField;
    QRelatPatrimoniodata_aquisicao: TStringField;
    QRelatPatrimoniodata_cadastro: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmRelatorio: TDmRelatorio;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDmRelatorio.DataModuleCreate(Sender: TObject);
begin
 QRelatFornecedor.Connection := Dm.FDConn;
end;

end.
