unit DAO.Pedido;

interface

uses
  System.Classes, DAO.InterfacePadrao, Entidade.Pedido, Data.DB, Generics.Collections,
  FireDAC.Stan.Param, Utils.Serialize;

type
  TDAOPedido = class(TInterfacedPersistent, IDAOPadrao<TPedido>)
  public
    function Insert(AEntidade: TPedido): Integer;
    procedure Update(AEntidade: TPedido);
    procedure Delete(AEntidade: TPedido);
    function Carregar(Id: Integer): TPedido;
    function GetListaEntidade(): TObjectList<TPedido>;
    function ObterListaComFiltro(ACondicaoSql: string): TObjectList<TPedido>;
    class function GetNovoNumeroPedido: Integer;
    class function New: IDAOPadrao<TPedido>;
  end;

implementation

uses
  Repository.Pedido, Conexao.unConection;

{ TDAOPedido }

function TDAOPedido.Insert(AEntidade: TPedido): Integer;
begin
   var Qry := TConexao.GetConnection.GetQuery;
   Qry.SQL.Add(TRepositoryPedido.New.GetScriptInsert);
   Qry.ParamByName('NUMERO').AsInteger := AEntidade.Numero;
   Qry.ParamByName('DATA_EMISSAO').AsDateTime := AEntidade.DataEmissao;
   Qry.ParamByName('ID_CLIENTE').AsInteger := AEntidade.IdCliente;
   Qry.ParamByName('VALOR_TOTAL').AsFloat := AEntidade.ValorTotal;
   Qry.ExecSQL;
   Result := AEntidade.Numero;
   Qry.DisposeOf;
end;

procedure TDAOPedido.Update(AEntidade: TPedido);
begin
   var Qry := TConexao.GetConnection.GetQuery;
   Qry.SQL.Add(TRepositoryPedido.New.GetScriptUpdate);
   Qry.ParamByName('NUMERO').AsInteger := AEntidade.Numero;
   Qry.ParamByName('DATA_EMISSAO').AsDateTime := AEntidade.DataEmissao;
   Qry.ParamByName('ID_CLIENTE').AsInteger := AEntidade.IdCliente;
   Qry.ParamByName('VALOR_TOTAL').AsFloat := AEntidade.ValorTotal;
   Qry.ExecSQL;
   Qry.DisposeOf;
end;

function TDAOPedido.Carregar(Id: Integer): TPedido;
begin
   var Qry := TConexao.GetConnection.GetQuery;
   Qry.SQL.Add(TRepositoryPedido.New.GetScriptLoad);
   Qry.ParamByName('NUMERO').AsInteger := Id;
   Qry.Open;
   Result := TUtilsSerialize.DataSetToEntidade(TDataSet(Qry),TPedido) as TPedido;
   Qry.DisposeOf;
end;

procedure TDAOPedido.Delete(AEntidade: TPedido);
begin
   var Qry := TConexao.GetConnection.GetQuery;
   Qry.SQL.Add(TRepositoryPedido.New.GetScriptDelete);
   Qry.ParamByName('NUMERO').AsInteger := AEntidade.Numero;
   Qry.ExecSQL;
   Qry.DisposeOf;
end;

function TDAOPedido.GetListaEntidade: TObjectList<TPedido>;
begin
  var Qry := TConexao.GetConnection.GetQuery;
  Qry.SQL.Add(TRepositoryPedido.New.GetScriptLoadList);
  Qry.Open;
  Result := TObjectList<TPedido>(TUtilsSerialize.DataSetToListaEntidade(TDataSet(Qry),TPedido));
  Qry.DisposeOf;
end;

class function TDAOPedido.GetNovoNumeroPedido: Integer;
begin
  Result := TConexao.GetConnection.GetNextId('PEDIDO','NUMERO');
end;

class function TDAOPedido.New: IDAOPadrao<TPedido>;
begin
  Result := Self.Create;
end;

function TDAOPedido.ObterListaComFiltro(ACondicaoSql: string): TObjectList<TPedido>;
begin
  var Qry := TConexao.GetConnection.GetQuery;
  Qry.SQL.Add(TRepositoryPedido.New.GetScriptLoadFilter);
  Qry.MacroByName('MACRO').AsRaw := ACondicaoSql;
  Qry.Open;
  Result := TObjectList<TPedido>(TUtilsSerialize.DataSetToListaEntidade(TDataSet(Qry),TPedido));
  Qry.DisposeOf;
end;

end.
