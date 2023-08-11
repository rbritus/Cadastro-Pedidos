unit Conexao.unConection;

interface

uses
  System.SysUtils, System.Win.Registry, Winapi.Windows, System.Classes,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, Data.DbxMySql, FireDAC.Phys.MySQL, FireDAC.FMXUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Intf,
  DB, Datasnap.DBClient, Datasnap.Provider, FireDAC.DApt, inifiles;

type
  TQuery = class(TFDQuery);

  TConexao = class(TFDConnection)
  strict private
    DriverLink: TFDPhysMySQLDriverLink;
    Transaction: TFDTransaction;
    FDataBase: string;
    FUserName: string;
    FPassword: string;
    FServer: string;
    FPort: string;
    FLib: string;
    class var FConection: TConexao;
    procedure GetConexao();
  private
    function GetDatabaseNameFromIni(): string;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetConnection: TConexao;
    class function GetQuery: TQuery;
    class function GetNextId(TableName, CampoId: String): Integer;
    procedure FecharConexao();

    const SELECT_RECUPERACAO_ID = 'SELECT last_insert_id() ID;';
  end;

implementation

uses
  vcl.Forms;

{ TConexao }

constructor TConexao.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TConexao.FecharConexao;
begin
  FConection.Close;
end;

procedure TConexao.GetConexao;
begin
  DriverLink := TFDPhysMySQLDriverLink.Create(nil);
  Transaction := TFDTransaction.Create(nil);
  Transaction.Connection := FConection;
  GetDatabaseNameFromIni();
  DriverLink.VendorLib := FLib;
  FConection.TxOptions.AutoCommit := False;
  FConection.Params.Values['DriverID'] := 'MySQL';
  FConection.Params.Values['Database'] := FDataBase;
  FConection.Params.Values['User_Name'] := FUserName;
  FConection.Params.Values['Password'] := FPassword;
  FConection.Params.Values['Server'] := FServer;
  FConection.Params.Values['Port'] := FPort;
  FConection.Connected := True;
end;

function TConexao.GetDatabaseNameFromIni: string;
begin
  var appINI: TMemIniFile;
  var Diretorio := IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));
  appINI := TMemIniFile.Create(Diretorio + 'app.ini',TEncoding.UTF8);
  FDataBase := appINI.ReadString('Conexao', 'database', EmptyStr);
  FUserName := appINI.ReadString('Conexao', 'username', EmptyStr);
  FPassword := appINI.ReadString('Conexao', 'password', EmptyStr);
  FServer := appINI.ReadString('Conexao', 'server', EmptyStr);
  FPort := appINI.ReadString('Conexao', 'port', EmptyStr);
  FLib := appINI.ReadString('Conexao', 'lib', EmptyStr);
  appINI.Free;
end;

class function TConexao.GetConnection: TConexao;
begin
  if not Assigned(Self.FConection) then
  begin
    FConection := TConexao(Inherited NewInstance);
    FConection.Create(nil);
    FConection.GetConexao;
  end;
  if not Self.FConection.InTransaction then
    Self.FConection.StartTransaction;

  Result := Self.FConection;
end;

class function TConexao.GetNextId(TableName, CampoId: String): Integer;
begin
  var Query: TFDQuery;
  Query := GetQuery;
  Query.Open('SELECT IfNull(MAX('+ CampoId + '), 0) + 1 AS MAX FROM ' + TableName);
  Result := Query.FieldByName('MAX').AsInteger;
  Query.Close;
  Query.DisposeOf;
end;

class function TConexao.GetQuery: TQuery;
begin
  var Query: TFDQuery;
  Query := TFDQuery.Create(nil);
  Query.Connection := GetConnection;
  Result := TQuery(Query);
end;

end.
