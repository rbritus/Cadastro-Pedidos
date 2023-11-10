unit Conexao.unConection;

interface

uses
  System.SysUtils, System.Win.Registry, Winapi.Windows, System.Classes,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, Data.DbxMySql, FireDAC.Phys.MySQL, FireDAC.FMXUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Intf,
  DB, Datasnap.DBClient, Datasnap.Provider, FireDAC.DApt, inifiles,
  System.StrUtils;

type
  TQuery = class(TFDQuery);

  TConexao = class
  private
    class var FInstance: TConexao;
    class var FConection: TFDConnection;
    function GetConection: TFDConnection;
    function GetDriver: string;
    function GetSqlNextId: string;
  public
    class function New: TConexao;
    procedure Commit;
    procedure Rollback;
    function GetQuery: TQuery;
    function GetNextId(TableName, CampoId: String): Integer;
    procedure FecharConexao();

    function GetSqlRecuperaID: string;
  end;

implementation  

uses
  vcl.Forms,
  Conexao.MySql,
  Conexao.SqLite;

{ TConexao }

procedure TConexao.Commit;
begin
  FConection.CommitRetaining;
end;

procedure TConexao.FecharConexao;
begin
  FConection.Close;
end;

class function TConexao.New: TConexao;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TConexao(Inherited NewInstance);
    FInstance.Create;
    if not Assigned(FConection) then
      FConection := FInstance.GetConection;
  end;

  if not FConection.InTransaction then
    FConection.StartTransaction;

  Result := FInstance;
end;

procedure TConexao.Rollback;
begin
  FConection.RollbackRetaining;
end;

function TConexao.GetConection: TFDConnection;
begin
  Result := Nil;
  var lDriver := GetDriver;
  if lDriver.ToUpper = 'MYSQL' then
    Exit(TConexaoMySql.New);
    
  if lDriver.ToUpper = 'SQLITE' then
    Exit(TConexaoSqLite.New);  
end;

function TConexao.GetDriver: string;
begin
  var appINI: TMemIniFile;
  var Diretorio := IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));
  appINI := TMemIniFile.Create(Diretorio + 'app.ini',TEncoding.UTF8);
  Result := appINI.ReadString('Conexao', 'driver', 'SqLite');
  appINI.Free;
end;

function TConexao.GetNextId(TableName, CampoId: String): Integer;
begin
  var lSql := GetSqlNextId;
  var Query: TFDQuery;
  Query := GetQuery;
  Query.Open(Format(lSql,[CampoId,TableName]));
  Result := Query.FieldByName('MAX').AsInteger;
  Query.Close;
  Query.DisposeOf;
end;      

function TConexao.GetSqlNextId: string;
begin
  Result := EmptyStr; 
  var lDriver := GetDriver;
  if lDriver.ToUpper = 'MYSQL' then
    Exit(TConexaoMySql.GetSqlNextId);
    
  if lDriver.ToUpper = 'SQLITE' then
    Exit(TConexaoSqLite.GetSqlNextId);  
end;

function TConexao.GetSqlRecuperaID: string;
begin
  Result := EmptyStr; 
  var lDriver := GetDriver;
  if lDriver.ToUpper = 'MYSQL' then
    Exit(TConexaoMySql.GetSqlRecuperaId);
    
  if lDriver.ToUpper = 'SQLITE' then
    Exit(TConexaoSqLite.GetSqlRecuperaId);  
end;

function TConexao.GetQuery: TQuery;
begin
  var Query := TFDQuery.Create(nil);
  Query.Connection := FConection;
  Result := TQuery(Query);
end;

end.
