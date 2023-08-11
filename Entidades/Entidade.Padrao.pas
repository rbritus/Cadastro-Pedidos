unit Entidade.Padrao;

interface

uses
  System.Classes;
type
  TEntidade = class;
  TEntidadeClass = class of TEntidade;

  TEntidade = class(TInterfacedPersistent)
  end;


implementation

end.
