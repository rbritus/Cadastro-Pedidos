unit Conexao.SqLite;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, System.IOUtils, inifiles;

type
  TConexaoSqLite = class(TFDConnection)
  strict private
    DriverLink: TFDPhysSQLiteDriverLink;
    Transaction: TFDTransaction;
    procedure GetConexao();
  public
    constructor Create(AOwner: TComponent); override;
    class function New: TFDConnection;
    class function GetSqlNextId: string;
    class function GetSqlRecuperaId: string;
  end;

implementation

uses
  vcl.Forms;

{ TConexaoSqLite }

constructor TConexaoSqLite.Create(AOwner: TComponent);
begin
  inherited;
  GetConexao();
end;

procedure TConexaoSqLite.GetConexao;
begin
  DriverLink := TFDPhysSQLiteDriverLink.Create(nil);
  Transaction := TFDTransaction.Create(nil);
  Transaction.Connection := Self;
  Self.Params.Values['DriverID'] := 'SQLite';
  Self.Params.Values['Database'] := IncludeTrailingPathDelimiter(System.SysUtils.GetCurrentDir) + 'banco.db';
  Self.Connected := True;
  Self.TxOptions.AutoCommit := False;
end;

class function TConexaoSqLite.GetSqlNextId: string;
begin
  Result := 'SELECT IfNull(MAX(%s), 0) + 1 AS MAX FROM %s';
end;

class function TConexaoSqLite.GetSqlRecuperaId: string;
begin
  Result := 'SELECT last_insert_rowid() ID;'
end;

class function TConexaoSqLite.New: TFDConnection;
begin
  Result := Self.Create(nil);
end;

end.
