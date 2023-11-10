unit Entidade.Produto;

interface

uses
  System.Classes, Entidade.Padrao, Builder.Produto, Attributes.Entidades;

type
  [TNomeTabela('PRODUTO')]
  TProduto = class(TEntidade)
    private
      FID: Integer;
      FDescricao: string;
      FPreco: Double;
    public
      [TCampoInteiro('ID', 'Código')]
      property ID: Integer read FID write FID;
      [TCampoTexto('DESCRICAO', 'Descrição')]
      property Descricao: string read FDescricao write FDescricao;
      [TCampoDecimal('PRECO', 'Preço')]
      property Preco: Double read FPreco write FPreco;

      class function New: TProduto;
      function Preencher(Builder: IBuilderProduto): TProduto;
  end;

implementation

{ TProduto }

class function TProduto.New: TProduto;
begin
  Result := Self.Create;
end;

function TProduto.Preencher(Builder: IBuilderProduto): TProduto;
begin
  Result := Self;
  Builder.SetID(FID)
    .SetDescricao(FDescricao)
    .SetPreco(FPreco);
end;

initialization
  RegisterClass(TProduto);

end.
