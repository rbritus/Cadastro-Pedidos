unit Utils.Entidade;

interface

uses
  Generics.Collections, Rtti, Classes, Entidade.Padrao, Data.DB, Attributes.Entidades,
  System.SysUtils;

type
  TUtilsEntidade = class
    class procedure PreencherEntidade(var Entidade: TEntidade; DSet: TDataSet);
    class procedure InformarCaptionParaColunas(DSet: TDataSet; Classe: TEntidadeClass);
    class function ObterSelectSql(Classe: TEntidadeClass): string;
    class function ObterNomeTabela(Classe: TEntidadeClass): string;
  end;

implementation

{ TUtilsEntidade }

class procedure TUtilsEntidade.InformarCaptionParaColunas(DSet: TDataSet;
  Classe: TEntidadeClass);
begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(Classe);
    if Tipo = Nil then
      Exit;

    for var Prop in Tipo.GetProperties do
    begin
      for var Atrib in Prop.GetAttributes do
      begin
        if not (Atrib is TAtributoBanco) then
          Continue;

        if not Assigned(DSet.FindField(TAtributoBanco(Atrib).nome)) then
          Continue;

        DSet.FieldByName(TAtributoBanco(Atrib).nome).DisplayLabel := TAtributoBanco(Atrib).caption;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TUtilsEntidade.ObterNomeTabela(Classe: TEntidadeClass): string;
begin
  Result := EmptyStr;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(Classe);
    if Tipo <> Nil then
    begin
      for var Atrib in Tipo.GetAttributes do
      begin
        if Atrib is TNomeTabela then
        begin
          Result := Trim(TNomeTabela(Atrib).Nome);
          Break;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TUtilsEntidade.ObterSelectSql(Classe: TEntidadeClass): string;
begin
  Result := EmptyStr;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(Classe);
    if Tipo = Nil then
      Exit;

    var BuilderSql := TStringBuilder.Create.Append('Select ');
    var LSql := EmptyStr;
    for var Prop in Tipo.GetProperties do
    begin
      for var Atrib in Prop.GetAttributes do
      begin
        if not (Atrib is TAtributoBanco) then
          Continue;

        if not LSql.IsEmpty then
          LSql := LSql + ', ';

        if TAtributoBanco(Atrib).Visivel then
          LSql := LSql + sLineBreak + TAtributoBanco(Atrib).nome;
      end;
    end;
    BuilderSql.Append(LSql + sLineBreak);
    BuilderSql.Append('From ' + sLineBreak);
    BuilderSql.Append(ObterNomeTabela(Classe));
    Result := BuilderSql.ToString;
  finally
    Ctx.Free;
  end;
end;

class procedure TUtilsEntidade.PreencherEntidade(var Entidade: TEntidade; DSet: TDataSet);
begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(FindClass(Entidade.ClassName));
    if Tipo = Nil then
      Exit;

    for var Prop in Tipo.GetProperties do
    begin
      for var Atrib in Prop.GetAttributes do
      begin
        if not (Atrib is TAtributoBanco) then
          Continue;

        case Prop.PropertyType.TypeKind of
          tkInteger:
            Prop.SetValue(Entidade, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsInteger);
          tkFloat:
            begin
              if Atrib is TCampoData then
              begin
                if not DSet.FieldByName(TAtributoBanco(Atrib).nome).IsNull then
                  Prop.SetValue(Entidade, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsDateTime);
                Continue;
              end;

              Prop.SetValue(Entidade, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsFloat);
            end;
          tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
            Prop.SetValue(Entidade, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsString);
          tkVariant:
            Prop.SetValue(Entidade, TValue.From(DSet.FieldByName(TAtributoBanco(Atrib).nome).AsVariant));
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
End;

end.
