unit Entidade.Cliente;

interface

uses
  System.Classes, Entidade.Padrao, Builder.Cliente, Attributes.Entidades;

type
  [TNomeTabela('CLIENTE')]
  TCliente = class(TEntidade)
    private
      FID: Integer;
      FNome: string;
      FCidade: string;
      FUF: string;
    public
      [TCampoInteiro('ID', 'Código')]
      property ID: Integer read FID write FID;
      [TCampoTexto('NOME', 'Nome')]
      property Nome: string read FNome write FNome;
      [TCampoTexto('CIDADE', 'Cidade')]
      property Cidade: String read FCidade write FCidade;
      [TCampoTexto('UF', 'UF')]
      property UF: string read FUF write FUF;

      class function New: TCliente;
      function Preencher(Builder: IBuilderCliente): TCliente;
  end;

implementation

{ TCliente }

class function TCliente.New: TCliente;
begin
  Result := Self.Create;
end;

function TCliente.Preencher(Builder: IBuilderCliente): TCliente;
begin
  Result := Self;
  Builder
    .GetID(FID)
    .GetNome(FNome)
    .GetCidade(FCidade)
    .GetUF(FUF);
end;

initialization
  RegisterClass(TCliente);

end.
