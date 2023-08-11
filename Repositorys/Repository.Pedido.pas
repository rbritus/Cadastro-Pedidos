unit Repository.Pedido;

interface

uses
  System.Classes, Repository.InterfacePadrao, Entidade.Pedido, System.SysUtils,
  Conexao.unConection;

type
  TRepositoryPedido = class(TInterfacedPersistent, IRepository<TPedido>)
  public
    function GetScriptInsert: string;
    function GetScriptUpdate: string;
    function GetScriptDelete: string;
    function GetScriptLoad: string;
    function GetScriptLoadList: string;
    function GetScriptLoadFilter: string;
    class function New: IRepository<TPedido>;
  end;

implementation

{ TRepositoryPedido }

function TRepositoryPedido.GetScriptInsert: string;
begin
  var SQL := TStringBuilder.Create
    .Append('INSERT INTO PEDIDO ')
    .Append('(NUMERO, DATA_EMISSAO, ID_CLIENTE, VALOR_TOTAL) ')
    .Append('VALUES ')
    .Append('(:NUMERO, :DATA_EMISSAO, :ID_CLIENTE, :VALOR_TOTAL)');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryPedido.GetScriptUpdate: string;
begin
  var SQL := TStringBuilder.Create
    .Append('UPDATE PEDIDO SET ')
    .Append('DATA_EMISSAO = :DATA_EMISSAO, ')
    .Append('ID_CLIENTE = :ID_CLIENTE, ')
    .Append('VALOR_TOTAL = :VALOR_TOTAL ')
    .Append('WHERE NUMERO = :NUMERO');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

class function TRepositoryPedido.New: IRepository<TPedido>;
begin
  Result := Self.Create;
end;

function TRepositoryPedido.GetScriptDelete: string;
begin
  var SQL := TStringBuilder.Create
    .Append('DELETE FROM PEDIDO ')
    .Append('WHERE NUMERO = :NUMERO');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryPedido.GetScriptLoad: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT NUMERO, DATA_EMISSAO, ID_CLIENTE, VALOR_TOTAL ')
    .Append('FROM PEDIDO ')
    .Append('WHERE NUMERO = :NUMERO');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryPedido.GetScriptLoadFilter: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT NUMERO, DATA_EMISSAO, ID_CLIENTE, VALOR_TOTAL ')
    .Append('FROM PEDIDO ')
    .Append('WHERE &MACRO');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

function TRepositoryPedido.GetScriptLoadList: string;
begin
  var SQL := TStringBuilder.Create
    .Append('SELECT NUMERO, DATA_EMISSAO, ID_CLIENTE, VALOR_TOTAL ')
    .Append('FROM PEDIDO ');

  Result := SQL.ToString;
  SQL.DisposeOf;
end;

end.

