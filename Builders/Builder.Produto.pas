unit Builder.Produto;

interface

uses
  System.Classes;

type
  IBuilderProduto = interface
    ['{EC854E3A-B5F8-4B87-A79A-DFC2EDFF13FF}']
    function SetID(const AID: Integer): IBuilderProduto;
    function GetID(var AID: Integer): IBuilderProduto;
    function SetDescricao(const ADescricao: string) :IBuilderProduto;
    function GetDescricao(var ADescricao: string): IBuilderProduto;
    function SetPreco(const APreco: Double): IBuilderProduto;
    function GetPreco(var APreco: Double): IBuilderProduto;
  end;

  TBuilderProduto = class(TInterfacedPersistent, IBuilderProduto)
    private
      FID: Integer;
      FDescricao: string;
      FPreco: Double;
    public
      function SetID(const AID: Integer): IBuilderProduto;
      function GetID(var AID: Integer): IBuilderProduto;
      function SetDescricao(const ADescricao: string) :IBuilderProduto;
      function GetDescricao(var ADescricao: string): IBuilderProduto;
      function SetPreco(const APreco: Double): IBuilderProduto;
      function GetPreco(var APreco: Double): IBuilderProduto;
      class function New: IBuilderProduto;
  end;

implementation

{ TBuilderProduto }

{ TBuilderProduto }

function TBuilderProduto.GetDescricao(var ADescricao: string): IBuilderProduto;
begin
  Result := Self;
  ADescricao := FDescricao;
end;

function TBuilderProduto.GetID(var AID: Integer): IBuilderProduto;
begin
  Result := Self;
  AID := FID;
end;

function TBuilderProduto.GetPreco(var APreco: Double): IBuilderProduto;
begin
  Result := Self;
  APreco := FPreco;
end;

class function TBuilderProduto.New: IBuilderProduto;
begin
  Result := Self.Create;
end;

function TBuilderProduto.SetDescricao(const ADescricao: string): IBuilderProduto;
begin
  Result := Self;
  FDescricao := ADescricao;
end;

function TBuilderProduto.SetID(const AID: Integer): IBuilderProduto;
begin
  Result := Self;
  FID := AID;
end;

function TBuilderProduto.SetPreco(const APreco: Double): IBuilderProduto;
begin
  Result := Self;
  FPreco := APreco;
end;

end.
