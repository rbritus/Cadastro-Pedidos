unit Entidade.Pedido;

interface

uses
  System.Classes, Entidade.Padrao, Builder.Pedido, Attributes.Entidades;

type
  [TNomeTabela('PEDIDO')]
  TPedido = class(TEntidade)
    private
      FNumero: Integer;
      FDataEmissao: TDateTime;
      FIdCliente: Integer;
      FValorTotal: Double;
    public
      [TCampoInteiro('NUMERO', 'Número')]
      property Numero: Integer read FNumero write FNumero;
      [TCampoData('DATA_EMISSAO', 'Data emissão')]
      property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
      [TCampoInteiro('ID_CLIENTE', 'Cliente')]
      property IdCliente: Integer read FIdCliente write FIdCliente;
      [TCampoDecimal('VALOR_TOTAL', 'Valor total')]
      property ValorTotal: Double read FValorTotal write FValorTotal;

      class function New: TPedido;
      function Preencher(Builder: IBuilderPedido): TPedido;
  end;

implementation

{ TPedido }

class function TPedido.New: TPedido;
begin
  Result := Self.Create;
end;

function TPedido.Preencher(Builder: IBuilderPedido): TPedido;
begin
  Result := Self;
  Builder
    .GetNumero(FNumero)
    .GetDataEmissao(FDataEmissao)
    .GetIdCliente(FIdCliente)
    .GetValorTotal(FValorTotal);
end;

initialization
  RegisterClass(TPedido);

end.
