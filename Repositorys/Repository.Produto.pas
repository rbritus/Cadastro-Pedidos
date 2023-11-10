unit Repository.Produto;

interface

uses
  System.Classes, Repository.InterfacePadrao, Entidade.Produto, System.SysUtils,
  Conexao.unConection;

type
  TRepositoryProduto = class(TInterfacedPersistent, IRepository<TProduto>)
  public
    function GetScriptInsert: string;
    function GetScriptUpdate: string;
    function GetScriptDelete: string;
    function GetScriptLoad: string;
    function GetScriptLoadList: string;
    function GetScriptLoadFilter: string;
    class function New: IRepository<TProduto>;
  end;

implementation

{ TRepositoryProduto }

function TRepositoryProduto.GetScriptInsert: string;
begin
  var SQL := TStringBuilder.Create
    .Append('INSERT INTO PRODUTO ')
    .Append('(DESCRICAO, PRECO) ')
    .Append('VALUES ')
    .Append('(:DESCRICAO, :PRECO);')
    .Append(TConexao.New.GetSqlRecuperaID);

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryProduto.GetScriptUpdate: string;
begin
  var SQL := TStringBuilder.Create.Append('UPDATE PRODUTO SET ')
    .Append('DESCRICAO = :DESCRICAO, ')
    .Append('PRECO = :PRECO ')
    .Append('WHERE ID = :ID');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

class function TRepositoryProduto.New: IRepository<TProduto>;
begin
  Result := Self.Create;
end;

function TRepositoryProduto.GetScriptDelete: string;
begin
  var SQL := TStringBuilder.Create
    .Append('DELETE FROM PRODUTO ')
    .Append('WHERE ID = :ID');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryProduto.GetScriptLoad: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT ID, DESCRICAO, PRECO ')
    .Append('FROM PRODUTO ')
    .Append('WHERE ID = :ID');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryProduto.GetScriptLoadFilter: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT ID, DESCRICAO, PRECO ')
    .Append('FROM PRODUTO ')
    .Append('WHERE &MACRO');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryProduto.GetScriptLoadList: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT DESCRICAO, PRECO ')
    .Append('FROM PRODUTO ');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

end.

