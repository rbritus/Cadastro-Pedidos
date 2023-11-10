unit DAO.PedidoProduto;

interface

uses
  System.Classes, DAO.InterfacePadrao, Entidade.PedidoProduto, Data.DB, Generics.Collections,
  FireDAC.Stan.Param, Utils.Serialize;

type
  TDAOPedidoProduto = class(TInterfacedPersistent, IDAOPadrao<TPedidoProduto>)
  public
    function Insert(AEntidade: TPedidoProduto): Integer;
    procedure Update(AEntidade: TPedidoProduto);
    procedure Delete(AEntidade: TPedidoProduto);
    function Carregar(Id: Integer): TPedidoProduto;
    function GetListaEntidade(): TObjectList<TPedidoProduto>;
    function ObterListaComFiltro(ACondicaoSql: string): TObjectList<TPedidoProduto>;
    class function New: IDAOPadrao<TPedidoProduto>;
  end;

implementation

uses
  Repository.PedidoProduto, Conexao.unConection;

{ TDAOPedidoProduto }

function TDAOPedidoProduto.Insert(AEntidade: TPedidoProduto): Integer;
begin
   var Qry := TConexao.New.GetQuery;
   Qry.SQL.Add(TRepositoryPedidoProduto.New.GetScriptInsert);
   Qry.ParamByName('NUMERO_PEDIDO').AsInteger := AEntidade.NumeroPedido;
   Qry.ParamByName('ID_PRODUTO').AsInteger := AEntidade.IdProduto;
   Qry.ParamByName('QUANTIDADE').AsFloat := AEntidade.Quantidade;
   Qry.ParamByName('PRECO').AsFloat := AEntidade.Preco;
   Qry.ParamByName('VALOR_TOTAL').AsFloat := AEntidade.ValorTotal;
   Qry.OpenOrExecute;
   Result := Qry.FieldByName('ID').AsInteger;
   Qry.DisposeOf;
end;

procedure TDAOPedidoProduto.Update(AEntidade: TPedidoProduto);
begin
   var Qry := TConexao.New.GetQuery;
   Qry.SQL.Add(TRepositoryPedidoProduto.New.GetScriptUpdate);
   Qry.ParamByName('ID').AsInteger := AEntidade.ID;
   Qry.ParamByName('NUMERO_PEDIDO').AsInteger := AEntidade.NumeroPedido;
   Qry.ParamByName('ID_PRODUTO').AsInteger := AEntidade.IdProduto;
   Qry.ParamByName('QUANTIDADE').AsFloat := AEntidade.Quantidade;
   Qry.ParamByName('PRECO').AsFloat := AEntidade.Preco;
   Qry.ParamByName('VALOR_TOTAL').AsFloat := AEntidade.ValorTotal;
   Qry.ExecSQL;
   Qry.DisposeOf;
end;

function TDAOPedidoProduto.Carregar(Id: Integer): TPedidoProduto;
begin
   var Qry := TConexao.New.GetQuery;
   Qry.SQL.Add(TRepositoryPedidoProduto.New.GetScriptLoad);
   Qry.ParamByName('ID').AsInteger := Id;
   Qry.Open;
   Result := TUtilsSerialize.DataSetToEntidade(TDataSet(Qry),TPedidoProduto) as TPedidoProduto;
   Qry.DisposeOf;
end;

procedure TDAOPedidoProduto.Delete(AEntidade: TPedidoProduto);
begin
   var Qry := TConexao.New.GetQuery;
   Qry.SQL.Add(TRepositoryPedidoProduto.New.GetScriptDelete);
   Qry.ParamByName('ID').AsInteger := AEntidade.ID;
   Qry.ExecSQL;
   Qry.DisposeOf;
end;

function TDAOPedidoProduto.GetListaEntidade: TObjectList<TPedidoProduto>;
begin
  var Qry := TConexao.New.GetQuery;
  Qry.SQL.Add(TRepositoryPedidoProduto.New.GetScriptLoadList);
  Qry.Open;
  Result := TObjectList<TPedidoProduto>(TUtilsSerialize.DataSetToListaEntidade(TDataSet(Qry),TPedidoProduto));
  Qry.DisposeOf;
end;

class function TDAOPedidoProduto.New: IDAOPadrao<TPedidoProduto>;
begin
  Result := Self.Create;
end;

function TDAOPedidoProduto.ObterListaComFiltro(ACondicaoSql: string): TObjectList<TPedidoProduto>;
begin
  var Qry := TConexao.New.GetQuery;
  Qry.SQL.Add(TRepositoryPedidoProduto.New.GetScriptLoadFilter);
  Qry.MacroByName('MACRO').AsRaw := ACondicaoSql;
  Qry.Open;
  Result := TObjectList<TPedidoProduto>(TUtilsSerialize.DataSetToListaEntidade(TDataSet(Qry),TPedidoProduto));
  Qry.DisposeOf;
end;

end.
