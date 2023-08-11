unit Builder.PedidoProduto;

interface

uses
  System.Classes;

type
  IBuilderPedidoProduto = interface
    ['{847E7F55-CFDE-4852-A987-F596CA727695}']
    function SetID(const AID: Integer): IBuilderPedidoProduto;
    function GetID(var AID: Integer): IBuilderPedidoProduto;
    function SetNumeroPedido(const ANumeroPedido: Integer): IBuilderPedidoProduto;
    function GetNumeroPedido(var ANumeroPedido: Integer): IBuilderPedidoProduto;
    function SetIdProduto(const AIdProduto: Integer): IBuilderPedidoProduto;
    function GetIdProduto(var AIdProduto: Integer): IBuilderPedidoProduto;
    function SetQuantidade(const AQuantidade: Double) :IBuilderPedidoProduto;
    function GetQuantidade(var AQuantidade: Double): IBuilderPedidoProduto;
    function SetPreco(const APreco: Double) :IBuilderPedidoProduto;
    function GetPreco(var APreco: Double): IBuilderPedidoProduto;
    function SetValorTotal(const AValorTotal: Double) :IBuilderPedidoProduto;
    function GetValorTotal(var AValorTotal: Double): IBuilderPedidoProduto;
  end;

  TBuilderPedidoProduto = class(TInterfacedPersistent, IBuilderPedidoProduto)
    private
      FID: Integer;
      FNumeroPedido: Integer;
      FIdProduto: Integer;
      FQuantidade: Double;
      FPreco: Double;
      FValorTotal: Double;
    public
      function SetID(const AID: Integer): IBuilderPedidoProduto;
      function GetID(var AID: Integer): IBuilderPedidoProduto;
      function SetNumeroPedido(const ANumeroPedido: Integer): IBuilderPedidoProduto;
      function GetNumeroPedido(var ANumeroPedido: Integer): IBuilderPedidoProduto;
      function SetIdProduto(const AIdProduto: Integer): IBuilderPedidoProduto;
      function GetIdProduto(var AIdProduto: Integer): IBuilderPedidoProduto;
      function SetQuantidade(const AQuantidade: Double) :IBuilderPedidoProduto;
      function GetQuantidade(var AQuantidade: Double): IBuilderPedidoProduto;
      function SetPreco(const APreco: Double) :IBuilderPedidoProduto;
      function GetPreco(var APreco: Double): IBuilderPedidoProduto;
      function SetValorTotal(const AValorTotal: Double) :IBuilderPedidoProduto;
      function GetValorTotal(var AValorTotal: Double): IBuilderPedidoProduto;
      class function New: IBuilderPedidoProduto;
  end;

implementation

{ TBuilderPedidoProduto }

function TBuilderPedidoProduto.GetID(var AID: Integer): IBuilderPedidoProduto;
begin
  Result := Self;
  AID := FID;
end;

function TBuilderPedidoProduto.GetIdProduto(
  var AIdProduto: Integer): IBuilderPedidoProduto;
begin
  Result := Self;
  AIdProduto := FIdProduto;
end;

function TBuilderPedidoProduto.GetNumeroPedido(
  var ANumeroPedido: Integer): IBuilderPedidoProduto;
begin
  Result := Self;
  ANumeroPedido := FNumeroPedido;
end;

function TBuilderPedidoProduto.GetPreco(
  var APreco: Double): IBuilderPedidoProduto;
begin
  Result := Self;
  APreco := FPreco;
end;

function TBuilderPedidoProduto.GetQuantidade(
  var AQuantidade: Double): IBuilderPedidoProduto;
begin
  Result := Self;
  AQuantidade := FQuantidade;
end;

function TBuilderPedidoProduto.GetValorTotal(
  var AValorTotal: Double): IBuilderPedidoProduto;
begin
  Result := Self;
  AValorTotal := FValorTotal;
end;

class function TBuilderPedidoProduto.New: IBuilderPedidoProduto;
begin
  Result := Self.Create;
end;

function TBuilderPedidoProduto.SetID(const AID: Integer): IBuilderPedidoProduto;
begin
  Result := Self;
  FID := AID;
end;

function TBuilderPedidoProduto.SetIdProduto(
  const AIdProduto: Integer): IBuilderPedidoProduto;
begin
  Result := Self;
  FIdProduto := AIdProduto;
end;

function TBuilderPedidoProduto.SetNumeroPedido(
  const ANumeroPedido: Integer): IBuilderPedidoProduto;
begin
  Result := Self;
  FNumeroPedido := ANumeroPedido;
end;

function TBuilderPedidoProduto.SetPreco(
  const APreco: Double): IBuilderPedidoProduto;
begin
  Result := Self;
  FPreco := APreco;
end;

function TBuilderPedidoProduto.SetQuantidade(
  const AQuantidade: Double): IBuilderPedidoProduto;
begin
  Result := Self;
  FQuantidade := AQuantidade;
end;

function TBuilderPedidoProduto.SetValorTotal(
  const AValorTotal: Double): IBuilderPedidoProduto;
begin
  Result := Self;
  FValorTotal := AValorTotal;
end;

end.
