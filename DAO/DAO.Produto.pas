unit DAO.Produto;

interface

uses
  System.Classes, DAO.InterfacePadrao, Entidade.Produto, Data.DB, Generics.Collections,
  FireDAC.Stan.Param, Utils.Serialize;

type
  TDAOProduto = class(TInterfacedPersistent, IDAOPadrao<TProduto>)
  public
    function Insert(AEntidade: TProduto): Integer;
    procedure Update(AEntidade: TProduto);
    procedure Delete(AEntidade: TProduto);
    function Carregar(Id: Integer): TProduto;
    function GetListaEntidade(): TObjectList<TProduto>;
    function ObterListaComFiltro(ACondicaoSql: string): TObjectList<TProduto>;
    class function New: IDAOPadrao<TProduto>;
  end;

implementation

uses
  Repository.Produto, Conexao.unConection;

{ TDAOProduto }

function TDAOProduto.Insert(AEntidade: TProduto): Integer;
begin
   var Qry := TConexao.New.GetQuery;
   Qry.SQL.Add(TRepositoryProduto.New.GetScriptInsert);
   Qry.ParamByName('DESCRICAO').AsString := AEntidade.Descricao;
   Qry.ParamByName('PRECO').AsFloat := AEntidade.Preco;
   Qry.OpenOrExecute;
   Result := Qry.FieldByName('ID').AsInteger;
   Qry.DisposeOf;
end;

procedure TDAOProduto.Update(AEntidade: TProduto);
begin
   var Qry := TConexao.New.GetQuery;
   Qry.SQL.Add(TRepositoryProduto.New.GetScriptUpdate);
   Qry.ParamByName('ID').AsInteger := AEntidade.ID;
   Qry.ParamByName('DESCRICAO').AsString := AEntidade.Descricao;
   Qry.ParamByName('PRECO').AsFloat := AEntidade.Preco;
   Qry.ExecSQL;
   Qry.DisposeOf;
end;

function TDAOProduto.Carregar(Id: Integer): TProduto;
begin
   var Qry := TConexao.New.GetQuery;
   Qry.SQL.Add(TRepositoryProduto.New.GetScriptLoad);
   Qry.ParamByName('ID').AsInteger := Id;
   Qry.Open;
   Result := TUtilsSerialize.DataSetToEntidade(TDataSet(Qry),TProduto) as TProduto;
   Qry.DisposeOf;
end;

procedure TDAOProduto.Delete(AEntidade: TProduto);
begin
   var Qry := TConexao.New.GetQuery;
   Qry.SQL.Add(TRepositoryProduto.New.GetScriptDelete);
   Qry.ParamByName('ID').AsInteger := AEntidade.ID;
   Qry.ExecSQL;
   Qry.DisposeOf;
end;

function TDAOProduto.GetListaEntidade: TObjectList<TProduto>;
begin
  var Qry := TConexao.New.GetQuery;
  Qry.SQL.Add(TRepositoryProduto.New.GetScriptLoadList);
  Qry.Open;
  Result := TObjectList<TProduto>(TUtilsSerialize.DataSetToListaEntidade(TDataSet(Qry),TProduto));
  Qry.DisposeOf;
end;

class function TDAOProduto.New: IDAOPadrao<TProduto>;
begin
  Result := Self.Create;
end;

function TDAOProduto.ObterListaComFiltro(ACondicaoSql: string): TObjectList<TProduto>;
begin
  var Qry := TConexao.New.GetQuery;
  Qry.SQL.Add(TRepositoryProduto.New.GetScriptLoadFilter);
  Qry.MacroByName('MACRO').AsRaw := ACondicaoSql;
  Qry.Open;
  Result := TObjectList<TProduto>(TUtilsSerialize.DataSetToListaEntidade(TDataSet(Qry),TProduto));
  Qry.DisposeOf;
end;

end.
