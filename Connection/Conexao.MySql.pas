unit Conexao.MySql;

interface

uses
  System.SysUtils, System.Win.Registry, Winapi.Windows, System.Classes,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, Data.DbxMySql, FireDAC.Phys.MySQL, FireDAC.FMXUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Intf,
  DB, Datasnap.DBClient, Datasnap.Provider, FireDAC.DApt, inifiles;

type
  TConexaoMySql = class(TFDConnection)
  strict private
    DriverLink: TFDPhysMySQLDriverLink;
    Transaction: TFDTransaction;
    FDataBase: string;
    FUserName: string;
    FPassword: string;
    FServer: string;
    FPort: string;
    FLib: string;
    procedure GetConexao();
  private
    function GetDatabaseNameFromIni(): string;
  public
    constructor Create(AOwner: TComponent); override;
    class function New: TFDConnection;
    class function GetSqlNextId: string;
    class function GetSqlRecuperaId: string;
  end;

implementation

uses
  vcl.Forms;

{ TConexaoMySql }

constructor TConexaoMySql.Create(AOwner: TComponent);
begin
  inherited;
  GetConexao();
end;

procedure TConexaoMySql.GetConexao;
begin
  DriverLink := TFDPhysMySQLDriverLink.Create(nil);
  Transaction := TFDTransaction.Create(nil);
  Transaction.Connection := Self;
  GetDatabaseNameFromIni();
  DriverLink.VendorLib := FLib;
  Self.TxOptions.AutoCommit := False;
  Self.Params.Values['DriverID'] := 'MySQL';
  Self.Params.Values['Database'] := FDataBase;
  Self.Params.Values['User_Name'] := FUserName;
  Self.Params.Values['Password'] := FPassword;
  Self.Params.Values['Server'] := FServer;
  Self.Params.Values['Port'] := FPort;
  Self.Connected := True;
end;

function TConexaoMySql.GetDatabaseNameFromIni: string;
begin
  var appINI: TMemIniFile;
  var Diretorio := IncludeTrailingPathDelimiter(System.SysUtils.GetCurrentDir);
  appINI := TMemIniFile.Create(Diretorio + 'app.ini',TEncoding.UTF8);
  FDataBase := appINI.ReadString('Conexao', 'database', EmptyStr);
  FUserName := appINI.ReadString('Conexao', 'username', EmptyStr);
  FPassword := appINI.ReadString('Conexao', 'password', EmptyStr);
  FServer := appINI.ReadString('Conexao', 'server', EmptyStr);
  FPort := appINI.ReadString('Conexao', 'port', EmptyStr);
  FLib := appINI.ReadString('Conexao', 'lib', EmptyStr);
  appINI.Free;
end;

class function TConexaoMySql.GetSqlNextId: string;
begin
  Result := 'SELECT IfNull(MAX(%s), 0) + 1 AS MAX FROM %s';
end;

class function TConexaoMySql.GetSqlRecuperaId: string;
begin
  Result := 'SELECT last_insert_id() ID;';
end;

class function TConexaoMySql.New: TFDConnection;
begin
  Result := Self.Create(nil);
end;

end.
