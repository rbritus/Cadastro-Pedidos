unit Repository.Cliente;

interface

uses
  System.Classes, Repository.InterfacePadrao, Entidade.Cliente, System.SysUtils,
  Conexao.unConection;

type
  TRepositoryCliente = class(TInterfacedPersistent, IRepository<TCliente>)
  public
    function GetScriptInsert: string;
    function GetScriptUpdate: string;
    function GetScriptDelete: string;
    function GetScriptLoad: string;
    function GetScriptLoadList: string;
    function GetScriptLoadFilter: string;
    class function New: IRepository<TCliente>;
  end;

implementation

{ TRepositoryCliente }

function TRepositoryCliente.GetScriptInsert: string;
begin
  var SQL := TStringBuilder.Create
    .Append('INSERT INTO CLIENTE ')
    .Append('(NOME, CIDADE, UF) ')
    .Append('VALUES ')
    .Append('(:NOME, :CIDADE, :UF);')
    .Append(TConexao.SELECT_RECUPERACAO_ID);

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryCliente.GetScriptUpdate: string;
begin
  var SQL := TStringBuilder.Create.Append('UPDATE CLIENTE SET ')
    .Append('NOME = :NOME, ')
    .Append('CIDADE = :CIDADE, ')
    .Append('UF = :UF ')
    .Append('WHERE ID = :ID');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

class function TRepositoryCliente.New: IRepository<TCliente>;
begin
  Result := Self.Create;
end;

function TRepositoryCliente.GetScriptDelete: string;
begin
  var SQL := TStringBuilder.Create
    .Append('DELETE FROM CLIENTE ')
    .Append('WHERE ID = :ID');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryCliente.GetScriptLoad: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT ID, NOME, CIDADE, UF ')
    .Append('FROM CLIENTE ')
    .Append('WHERE ID = :ID');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryCliente.GetScriptLoadFilter: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT ID, NOME, CIDADE, UF ')
    .Append('FROM CLIENTE ')
    .Append('WHERE &MACRO');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryCliente.GetScriptLoadList: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT ID, NOME, CIDADE, UF ')
    .Append('FROM CLIENTE ');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

end.

