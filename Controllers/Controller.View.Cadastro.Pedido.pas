unit Controller.View.Cadastro.Pedido;

interface

uses
  System.Classes, Entidade.PedidoProduto, Generics.Collections, DAO.PedidoProduto,
  System.SysUtils, System.Types, Entidade.Produto, DAO.Produto, Entidade.Cliente,
  DAO.Cliente, Entidade.Pedido, DAO.Pedido, Conexao.unConection;

type
  IControllerCadastroPedido = Interface
  ['{7C0FFD0D-E129-4BF3-BD1B-B66B5A099B48}']
    function ObterListaDePedidoProdutos(ANumeroPedido: Integer): TObjectList<TPedidoProduto>; overload;
    function ObterListaDePedidoProdutos(ACondicaoWhere: string): TObjectList<TPedidoProduto>; overload;
    function ObterProduto(AIdProduto: Integer): TProduto;
    function ObterCliente(AIdCliente: Integer): TCliente;
    function ObterPedido(ANumeroPedido: Integer): TPedido;
    function ObterPedidoProduto(AIdPedidoProduto: Integer): TPedidoProduto;
    function ObterNovoNumeroDePedido: Integer;
    procedure AtualizarPedido(APedido: TPedido);
    procedure InserirPedido(APedido: TPedido);
    procedure ExcluirPedido(APedido: TPedido);
    procedure AtualizarPedidoProduto(APedidoProduto: TPedidoProduto);
    procedure InserirPedidoProduto(APedidoProduto: TPedidoProduto);
    procedure ExcluirPedidoProduto(APedidoProduto: TPedidoProduto);
    procedure ExcluirListaPedidoProduto(ALista: TObjectList<TPedidoProduto>);
    procedure Commit;
    procedure Rollback;
  End;

  TControllerCadastroPedido = class(TInterfacedPersistent, IControllerCadastroPedido)
    public
      function ObterListaDePedidoProdutos(ANumeroPedido: Integer): TObjectList<TPedidoProduto>; overload;
      function ObterListaDePedidoProdutos(ACondicaoWhere: string): TObjectList<TPedidoProduto>; overload;
      function ObterProduto(AIdProduto: Integer): TProduto;
      function ObterCliente(AIdCliente: Integer): TCliente;
      function ObterPedido(ANumeroPedido: Integer): TPedido;
      function ObterPedidoProduto(AIdPedidoProduto: Integer): TPedidoProduto;
      function ObterNovoNumeroDePedido: Integer;
      procedure AtualizarPedido(APedido: TPedido);
      procedure InserirPedido(APedido: TPedido);
      procedure ExcluirPedido(APedido: TPedido);
      procedure AtualizarPedidoProduto(APedidoProduto: TPedidoProduto);
      procedure InserirPedidoProduto(APedidoProduto: TPedidoProduto);
      procedure ExcluirPedidoProduto(APedidoProduto: TPedidoProduto);
      procedure ExcluirListaPedidoProduto(ALista: TObjectList<TPedidoProduto>);
      procedure Commit;
      procedure Rollback;
      class function New: IControllerCadastroPedido;
  end;

implementation

{ TControllerCadastroPedido }

procedure TControllerCadastroPedido.AtualizarPedido(APedido: TPedido);
begin
  TDAOPedido.New.Update(APedido);
end;

procedure TControllerCadastroPedido.AtualizarPedidoProduto(
  APedidoProduto: TPedidoProduto);
begin
  TDAOPedidoProduto.New.Update(APedidoProduto);
end;

procedure TControllerCadastroPedido.Commit;
begin
  TConexao.New.Commit;
end;

procedure TControllerCadastroPedido.ExcluirListaPedidoProduto(
  ALista: TObjectList<TPedidoProduto>);
begin
  for var PedidoProduto in ALista do
    TDAOPedidoProduto.New.Delete(PedidoProduto);
end;

procedure TControllerCadastroPedido.ExcluirPedido(APedido: TPedido);
begin
  TDAOPedido.New.Delete(APedido);
end;

procedure TControllerCadastroPedido.ExcluirPedidoProduto(
  APedidoProduto: TPedidoProduto);
begin
  TDAOPedidoProduto.New.Delete(APedidoProduto);
end;

procedure TControllerCadastroPedido.InserirPedido(APedido: TPedido);
begin
  TDAOPedido.New.Insert(APedido);
end;

procedure TControllerCadastroPedido.InserirPedidoProduto(
  APedidoProduto: TPedidoProduto);
begin
  TDAOPedidoProduto.New.Insert(APedidoProduto);
end;

class function TControllerCadastroPedido.New: IControllerCadastroPedido;
begin
  Result := Self.Create;
end;

function TControllerCadastroPedido.ObterCliente(AIdCliente: Integer): TCliente;
begin
  Result := TDAOCliente.New.Carregar(AIdCliente);
end;

function TControllerCadastroPedido.ObterListaDePedidoProdutos(
  ACondicaoWhere: string): TObjectList<TPedidoProduto>;
begin
  Result := TDAOPedidoProduto.New.ObterListaComFiltro(ACondicaoWhere);
end;

function TControllerCadastroPedido.ObterNovoNumeroDePedido: Integer;
begin
  Result := TDAOPedido.GetNovoNumeroPedido;
end;

function TControllerCadastroPedido.ObterListaDePedidoProdutos(
  ANumeroPedido: Integer): TObjectList<TPedidoProduto>;
begin
  Result := TDAOPedidoProduto.New.ObterListaComFiltro('NUMERO_PEDIDO = ' + ANumeroPedido.ToString);
end;

function TControllerCadastroPedido.ObterPedido(ANumeroPedido: Integer): TPedido;
begin
  Result := TDAOPedido.New.Carregar(ANumeroPedido);
end;

function TControllerCadastroPedido.ObterPedidoProduto(
  AIdPedidoProduto: Integer): TPedidoProduto;
begin
  Result := TDAOPedidoProduto.New.Carregar(AIdPedidoProduto);
end;

function TControllerCadastroPedido.ObterProduto(AIdProduto: Integer): TProduto;
begin
  Result := TDAOProduto.New.Carregar(AIdProduto);
end;

procedure TControllerCadastroPedido.Rollback;
begin
  TConexao.New.Rollback;
end;

end.
