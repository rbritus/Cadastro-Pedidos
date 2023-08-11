unit DAO.Cliente;

interface

uses
  System.Classes, DAO.InterfacePadrao, Entidade.Cliente, Data.DB, Generics.Collections,
  FireDAC.Stan.Param, Utils.Serialize;

type
  TDAOCliente = class(TInterfacedPersistent, IDAOPadrao<TCliente>)
  public
    function Insert(AEntidade: TCliente): Integer;
    procedure Update(AEntidade: TCliente);
    procedure Delete(AEntidade: TCliente);
    function Carregar(Id: Integer): TCliente;
    function GetListaEntidade(): TObjectList<TCliente>;
    function ObterListaComFiltro(ACondicaoSql: string): TObjectList<TCliente>;
    class function New: IDAOPadrao<TCliente>;
  end;

implementation

uses
  Repository.Cliente, Conexao.unConection;

{ TDAOCliente }

function TDAOCliente.Insert(AEntidade: TCliente): Integer;
begin
   var Qry := TConexao.GetConnection.GetQuery;
   Qry.SQL.Add(TRepositoryCliente.New.GetScriptInsert);
   Qry.ParamByName('NOME').AsString := AEntidade.Nome;
   Qry.ParamByName('CIDADE').AsString := AEntidade.Cidade;
   Qry.ParamByName('UF').AsString := AEntidade.UF;
   Qry.OpenOrExecute;
   Result := Qry.FieldByName('ID').AsInteger;
   Qry.DisposeOf;
end;

procedure TDAOCliente.Update(AEntidade: TCliente);
begin
   var Qry := TConexao.GetConnection.GetQuery;
   Qry.SQL.Add(TRepositoryCliente.New.GetScriptUpdate);
   Qry.ParamByName('ID').AsInteger := AEntidade.ID;
   Qry.ParamByName('NOME').AsString := AEntidade.Nome;
   Qry.ParamByName('CIDADE').AsString := AEntidade.Cidade;
   Qry.ParamByName('UF').AsString := AEntidade.UF;
   Qry.ExecSQL;
   Qry.DisposeOf;
end;

function TDAOCliente.Carregar(Id: Integer): TCliente;
begin
   var Qry := TConexao.GetConnection.GetQuery;
   Qry.SQL.Add(TRepositoryCliente.New.GetScriptLoad);
   Qry.ParamByName('ID').AsInteger := Id;
   Qry.Open;
   Result := TUtilsSerialize.DataSetToEntidade(TDataSet(Qry),TCliente) as TCliente;
   Qry.DisposeOf;
end;

procedure TDAOCliente.Delete(AEntidade: TCliente);
begin
   var Qry := TConexao.GetConnection.GetQuery;
   Qry.SQL.Add(TRepositoryCliente.New.GetScriptDelete);
   Qry.ParamByName('ID').AsInteger := AEntidade.ID;
   Qry.ExecSQL;
   Qry.DisposeOf;
end;

function TDAOCliente.GetListaEntidade: TObjectList<TCliente>;
begin
  var Qry := TConexao.GetConnection.GetQuery;
  Qry.SQL.Add(TRepositoryCliente.New.GetScriptLoadList);
  Qry.Open;
  Result := TObjectList<TCliente>(TUtilsSerialize.DataSetToListaEntidade(TDataSet(Qry),TCliente));
  Qry.DisposeOf;
end;

class function TDAOCliente.New: IDAOPadrao<TCliente>;
begin
  Result := Self.Create;
end;

function TDAOCliente.ObterListaComFiltro(ACondicaoSql: string): TObjectList<TCliente>;
begin
  var Qry := TConexao.GetConnection.GetQuery;
  Qry.SQL.Add(TRepositoryCliente.New.GetScriptLoadFilter);
  Qry.MacroByName('MACRO').AsRaw := ACondicaoSql;
  Qry.Open;
  Result := TObjectList<TCliente>(TUtilsSerialize.DataSetToListaEntidade(TDataSet(Qry),TCliente));
  Qry.DisposeOf;
end;

end.
