unit Utils.Serialize;

interface

uses
  System.Classes, Data.DB, Entidade.Padrao, Generics.Collections, Rtti,
  Attributes.Entidades, Utils.Entidade;

type
  TUtilsSerialize = class
    class function DataSetToEntidade(DataSet: TDataSet; Classe: TEntidadeClass): TEntidade;
    class function DataSetToListaEntidade(DataSet: TDataSet; Classe: TEntidadeClass): TObjectList<TEntidade>;
  end;

implementation

{ TUtilsSerialize }

class function TUtilsSerialize.DataSetToEntidade(DataSet: TDataSet;
  Classe: TEntidadeClass): TEntidade;
begin
  Result := Classe.Create;
  TUtilsEntidade.PreencherEntidade(Result, DataSet);
end;

class function TUtilsSerialize.DataSetToListaEntidade(DataSet: TDataSet;
  Classe: TEntidadeClass): TObjectList<TEntidade>;
begin
  var Lista := TObjectList<TEntidade>.Create;

  DataSet.First;
  while not DataSet.Eof do
  begin
    var Entidade := Classe.Create;
    TUtilsEntidade.PreencherEntidade(Entidade, DataSet);
    Lista.Add(Entidade);

    DataSet.Next;
  end;
  Result := Lista;
end;

end.
