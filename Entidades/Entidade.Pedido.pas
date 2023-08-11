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

      constructor Create(Builder: IBuilderPedido); overload;
  end;

implementation

{ TPedido }

constructor TPedido.Create(Builder: IBuilderPedido);
begin
  Builder
    .GetNumero(FNumero)
    .GetDataEmissao(FDataEmissao)
    .GetIdCliente(FIdCliente)
    .GetValorTotal(FValorTotal);
end;

initialization
  RegisterClass(TPedido);

end.
