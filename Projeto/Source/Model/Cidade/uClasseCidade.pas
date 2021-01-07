unit uClasseCidade;

interface

uses FireDAC.Comp.Client, FMX.ListView, uDmDados, System.SysUtils, FMX.Dialogs, u_Library,
  Form_Mensagem, FireDAC.Stan.Param, Data.DB,
  FMX.ListView.Appearances, FMX.ListView.Types, System.UITypes, System.Classes,
  uInterfaceCidade;

type
  TCidade = class(TInterfacedObject, iModelCidade)

  private
    FID: Integer;
    FNome: String;
  public

    constructor create;
    destructor destroy; override;
    class function new: iModelCidade;

    function ID(value: Integer): iModelCidade;
    function Nome(value: String): iModelCidade;
    function PopulaListView(value: TListView): iModelCidade;
    function BuscarCidade(value: Integer): String;
  end;

implementation

{ TCidade }

class function TCidade.new: iModelCidade;
begin
  result := self.create;
end;

constructor TCidade.create;
begin
  //
end;

destructor TCidade.destroy;
begin
  //
  inherited;
end;

function TCidade.ID(value: Integer): iModelCidade;
begin
  result := self;
  FID := value;
end;

function TCidade.Nome(value: String): iModelCidade;
begin
  result := self;
  FNome := value;
end;

function TCidade.BuscarCidade(value: Integer): String;
var
  qry: TFDQuery;
begin

  try
    qry := TFDQuery.create(nil);
    qry.Connection := dm.FDConn;
    qry.FetchOptions.RowsetSize := 50000;
    qry.Active := false;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT NOME, UF FROM MUNICIPIO WHERE ID = :ID');
    qry.ParamByName('ID').AsInteger := value;
    qry.Open;

    if qry.RecordCount = 0 then
      result := EmptyStr
    else
      result := qry.FieldByName('NOME').AsString + ' - ' + qry.FieldByName('UF').AsString;

  finally
    FreeAndNil(qry);
  end;

end;

function TCidade.PopulaListView(value: TListView): iModelCidade;
var
  LThread: TThread;
begin

  result := self;
  LThread := TThread.CreateAnonymousThread(
    procedure
    var
      x: Integer;
      qry: TFDQuery;
      item: TListViewItem;
      txt: TListItemText;
    begin
      try
        qry := TFDQuery.create(nil);
        qry.Connection := dm.FDConn;
        qry.FetchOptions.RowsetSize := 50000;
        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add('SELECT ID, NOME, UF FROM MUNICIPIO LIMIT 50000');
        qry.Open;
        qry.First;

        value.Items.Clear;
        value.BeginUpdate;

        for x := 1 to 1 do
        begin
          item := value.Items.Add;

          with item do
          begin
            txt := TListItemText(Objects.FindDrawable('lbl_id'));
            txt.Text := 'CÓDIGO';
            txt.TagString := '0';

            txt := TListItemText(Objects.FindDrawable('lbl_nome'));
            txt.Text := 'CIDADE';

            txt := TListItemText(Objects.FindDrawable('lbl_uf'));
            txt.Text := 'UF';

          end;
        end;

        for x := 1 to qry.RecordCount do
        begin

          item := value.Items.Add;

          with item do
          begin
            txt := TListItemText(Objects.FindDrawable('ID'));
            txt.Text := formatfloat('0000', qry.FieldByName('id').AsFloat);
            txt.TagString := qry.FieldByName('id').AsString;

            txt := TListItemText(Objects.FindDrawable('NOME'));
            txt.Text := qry.FieldByName('nome').AsString;

            txt := TListItemText(Objects.FindDrawable('UF'));
            txt.Text := qry.FieldByName('UF').AsString;

          end;

          qry.Next
        end;
      finally
        value.EndUpdate;
        FreeAndNil(qry);
      end;
    end);
  LThread.FreeOnTerminate := True;
  LThread.Start;
end;

end.
