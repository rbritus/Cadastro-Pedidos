unit Builder.Pedido;

interface

uses
  System.Classes;

type
  IBuilderPedido = interface
    ['{92364F84-2AE1-4DE4-B8E7-8EF880F66269}']
    function SetNumero(const ANumero: Integer): IBuilderPedido;
    function GetNumero(var ANumero: Integer): IBuilderPedido;
    function SetDataEmissao(const ADataEmissao: TDateTime) :IBuilderPedido;
    function GetDataEmissao(var ADataEmissao: TDateTime): IBuilderPedido;
    function SetIdCliente(const AIdCliente: Integer): IBuilderPedido;
    function GetIdCliente(var AIdCliente: Integer): IBuilderPedido;
    function SetValorTotal(const AValorTotal: Double) :IBuilderPedido;
    function GetValorTotal(var AValorTotal: Double): IBuilderPedido;
  end;

  TBuilderPedido = class(TInterfacedPersistent, IBuilderPedido)
    private
      FNumero: Integer;
      FDataEmissao: TDateTime;
      FIdCliente: Integer;
      FValorTotal: Double;
    public
      function SetNumero(const ANumero: Integer): IBuilderPedido;
      function GetNumero(var ANumero: Integer): IBuilderPedido;
      function SetDataEmissao(const ADataEmissao: TDateTime) :IBuilderPedido;
      function GetDataEmissao(var ADataEmissao: TDateTime): IBuilderPedido;
      function SetIdCliente(const AIdCliente: Integer): IBuilderPedido;
      function GetIdCliente(var AIdCliente: Integer): IBuilderPedido;
      function SetValorTotal(const AValorTotal: Double) :IBuilderPedido;
      function GetValorTotal(var AValorTotal: Double): IBuilderPedido;
      class function New: IBuilderPedido;
  end;

implementation

{ TBuilderPedido }

function TBuilderPedido.GetIdCliente(var AIdCliente: Integer): IBuilderPedido;
begin
  Result := Self;
  AIdCliente := FIdCliente;
end;

function TBuilderPedido.GetNumero(var ANumero: Integer): IBuilderPedido;
begin
  Result := Self;
  ANumero := FNumero;
end;

function TBuilderPedido.GetDataEmissao(var ADataEmissao: TDateTime): IBuilderPedido;
begin
  Result := Self;
  ADataEmissao := FDataEmissao;
end;

function TBuilderPedido.GetValorTotal(var AValorTotal: Double): IBuilderPedido;
begin
  Result := Self;
  AValorTotal := FValorTotal;
end;

class function TBuilderPedido.New: IBuilderPedido;
begin
  Result := Self.Create;
end;

function TBuilderPedido.SetIdCliente(const AIdCliente: Integer): IBuilderPedido;
begin
  Result := Self;
  FIdCliente := AIdCliente;
end;

function TBuilderPedido.SetNumero(const ANumero: Integer): IBuilderPedido;
begin
  Result := Self;
  FNumero := ANumero;
end;

function TBuilderPedido.SetDataEmissao(const ADataEmissao: TDateTime): IBuilderPedido;
begin
  Result := Self;
  FDataEmissao := ADataEmissao;
end;

function TBuilderPedido.SetValorTotal(const AValorTotal: Double): IBuilderPedido;
begin
  Result := Self;
  FValorTotal := AValorTotal;
end;

end.
