unit Builder.Cliente;

interface

uses
  System.Classes;

type
  IBuilderCliente = interface
    ['{92364F84-2AE1-4DE4-B8E7-8EF880F66269}']
    function SetID(const AID: Integer): IBuilderCliente;
    function GetID(var AID: Integer): IBuilderCliente;
    function SetNome(const ANome: string) :IBuilderCliente;
    function GetNome(var ANome: string): IBuilderCliente;
    function SetCidade(const ACidade: string): IBuilderCliente;
    function GetCidade(var ACidade: string): IBuilderCliente;
    function SetUF(const AUF: string) :IBuilderCliente;
    function GetUF(var AUF: string): IBuilderCliente;
  end;

  TBuilderCliente = class(TInterfacedPersistent, IBuilderCliente)
    private
      FID: Integer;
      FNome: string;
      FCidade: string;
      FUF: string;
    public
      function SetID(const AID: Integer): IBuilderCliente;
      function GetID(var AID: Integer): IBuilderCliente;
      function SetNome(const ANome: string) :IBuilderCliente;
      function GetNome(var ANome: string): IBuilderCliente;
      function SetCidade(const ACidade: string): IBuilderCliente;
      function GetCidade(var ACidade: string): IBuilderCliente;
      function SetUF(const AUF: string) :IBuilderCliente;
      function GetUF(var AUF: string): IBuilderCliente;
      class function New: IBuilderCliente;
  end;

implementation

{ TBuilderCliente }

function TBuilderCliente.GetCidade(var ACidade: string): IBuilderCliente;
begin
  Result := Self;
  ACidade := FCidade;
end;

function TBuilderCliente.GetID(var AID: Integer): IBuilderCliente;
begin
  Result := Self;
  AID := FID;
end;

function TBuilderCliente.GetNome(var ANome: string): IBuilderCliente;
begin
  Result := Self;
  ANome := FNome;
end;

function TBuilderCliente.GetUF(var AUF: string): IBuilderCliente;
begin
  Result := Self;
  AUF := FUF;
end;

class function TBuilderCliente.New: IBuilderCliente;
begin
  Result := Self.Create;
end;

function TBuilderCliente.SetCidade(const ACidade: string): IBuilderCliente;
begin
  Result := Self;
  FCidade := ACidade;
end;

function TBuilderCliente.SetID(const AID: Integer): IBuilderCliente;
begin
  Result := Self;
  FID := AID;
end;

function TBuilderCliente.SetNome(const ANome: string): IBuilderCliente;
begin
  Result := Self;
  FNome := ANome;
end;

function TBuilderCliente.SetUF(const AUF: string): IBuilderCliente;
begin
  Result := Self;
  FUF := AUF;
end;

end.
