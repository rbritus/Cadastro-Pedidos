unit Entidade.PedidoProduto;

interface

uses
  System.Classes, Entidade.Padrao, Builder.PedidoProduto, Attributes.Entidades;

type
  [TNomeTabela('PEDIDO_PRODUTO')]
  TPedidoProduto = class(TEntidade)
    private
      FID: Integer;
      FNumeroPedido: Integer;
      FIdProduto: Integer;
      FQuantidade: Double;
      FPreco: Double;
      FValorTotal: Double;
    public
      [TCampoInteiro('ID', 'C�digo')]
      property ID: Integer read FID write FID;
      [TCampoInteiro('NUMERO_PEDIDO', 'N�mero')]
      property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
      [TCampoInteiro('ID_PRODUTO', 'Produto')]
      property IdProduto: Integer read FIdProduto write FIdProduto;
      [TCampoDecimal('QUANTIDADE', 'Quantidade')]
      property Quantidade: Double read FQuantidade write FQuantidade;
      [TCampoDecimal('PRECO', 'Pre�o')]
      property Preco: Double read FPreco write FPreco;
      [TCampoDecimal('VALOR_TOTAL', 'Valor total')]
      property ValorTotal: Double read FValorTotal write FValorTotal;

      class function New: TPedidoProduto;
      function Preencher(Builder: IBuilderPedidoProduto): TPedidoProduto;
  end;

implementation

{ TPedidoProduto }

class function TPedidoProduto.New: TPedidoProduto;
begin
  Result := Self.Create;
end;

function TPedidoProduto.Preencher(Builder: IBuilderPedidoProduto): TPedidoProduto;
begin
  Result := Self;
  Builder
    .GetID(FID)
    .GetNumeroPedido(FNumeroPedido)
    .GetIdProduto(FIdProduto)
    .GetQuantidade(FQuantidade)
    .GetPreco(FPreco)
    .GetValorTotal(FValorTotal);
end;

initialization
  RegisterClass(TPedidoProduto);

end.
