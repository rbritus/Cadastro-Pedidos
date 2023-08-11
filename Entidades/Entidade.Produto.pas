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
      constructor Create(Builder: IBuilderProduto); overload;
  end;

implementation

{ TProduto }

constructor TProduto.Create(Builder: IBuilderProduto);
begin
  Builder.SetID(FID)
    .SetDescricao(FDescricao)
    .SetPreco(FPreco);
end;

initialization
  RegisterClass(TProduto);

end.
