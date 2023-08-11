unit Repository.PedidoProduto;

interface

uses
  System.Classes, Repository.InterfacePadrao, Entidade.PedidoProduto, System.SysUtils,
  Conexao.unConection;

type
  TRepositoryPedidoProduto = class(TInterfacedPersistent, IRepository<TPedidoProduto>)
  public
    function GetScriptInsert: string;
    function GetScriptUpdate: string;
    function GetScriptDelete: string;
    function GetScriptLoad: string;
    function GetScriptLoadList: string;
    function GetScriptLoadFilter: string;
    class function New: IRepository<TPedidoProduto>;
  end;

implementation

{ TRepositoryPedidoProduto }

function TRepositoryPedidoProduto.GetScriptInsert: string;
begin
  var SQL := TStringBuilder.Create
    .Append('INSERT INTO PEDIDO_PRODUTO ')
    .Append('(NUMERO_PEDIDO, ID_PRODUTO, QUANTIDADE, PRECO, VALOR_TOTAL) ')
    .Append('VALUES ')
    .Append('(:NUMERO_PEDIDO, :ID_PRODUTO, :QUANTIDADE, :PRECO, :VALOR_TOTAL);')
    .Append(TConexao.SELECT_RECUPERACAO_ID);

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryPedidoProduto.GetScriptUpdate: string;
begin
  var SQL := TStringBuilder.Create.Append('UPDATE PEDIDO_PRODUTO SET ')
    .Append('NUMERO_PEDIDO = :NUMERO_PEDIDO, ')
    .Append('ID_PRODUTO = :ID_PRODUTO, ')
    .Append('QUANTIDADE = :QUANTIDADE, ')
    .Append('PRECO = :PRECO, ')
    .Append('VALOR_TOTAL = :VALOR_TOTAL ')
    .Append('WHERE ID = :ID');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

class function TRepositoryPedidoProduto.New: IRepository<TPedidoProduto>;
begin
  Result := Self.Create;
end;

function TRepositoryPedidoProduto.GetScriptDelete: string;
begin
  var SQL := TStringBuilder.Create
    .Append('DELETE FROM PEDIDO_PRODUTO ')
    .Append('WHERE ID = :ID');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryPedidoProduto.GetScriptLoad: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT ID, NUMERO_PEDIDO, ID_PRODUTO, QUANTIDADE, PRECO, VALOR_TOTAL ')
    .Append('FROM PEDIDO_PRODUTO ')
    .Append('WHERE ID = :ID');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryPedidoProduto.GetScriptLoadFilter: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT ID, NUMERO_PEDIDO, ID_PRODUTO, QUANTIDADE, PRECO, VALOR_TOTAL ')
    .Append('FROM PEDIDO_PRODUTO ')
    .Append('WHERE &MACRO');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryPedidoProduto.GetScriptLoadList: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT ID, NUMERO_PEDIDO, ID_PRODUTO, QUANTIDADE, PRECO, VALOR_TOTAL ')
    .Append('FROM PEDIDO_PRODUTO ');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

end.

