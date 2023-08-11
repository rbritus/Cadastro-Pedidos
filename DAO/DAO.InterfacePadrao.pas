unit DAO.InterfacePadrao;

interface

uses
  Data.DB, Generics.Collections;

type
  IDAOPadrao<T: class> = interface
  ['{6CE27093-D842-42BC-A263-FF630F52DB73}']
    function Insert(AEntidade: T): Integer;
    procedure Update(AEntidade: T);
    procedure Delete(AEntidade: T);
    function Carregar(Id: Integer): T;
    function GetListaEntidade(): TObjectList<T>;
    function ObterListaComFiltro(ACondicaoSql: string): TObjectList<T>;
  end;

implementation

end.
