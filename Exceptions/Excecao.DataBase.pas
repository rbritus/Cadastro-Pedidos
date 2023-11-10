unit Excecao.DataBase;

interface

uses
  System.SysUtils, System.Classes, Conexao.unConection, Excecao.InterfaceParse, Vcl.Dialogs,
  Utils.Messages, FMX.Types, FMX.Forms, Data.DB;

type
  TExceptionDataBase = class(TInterfacedObject, IParserException)
  private
    FExcept: Exception;
    FProximoParser: IParserException;
    procedure EfetuarRollback;
  public
    procedure SetProximoParser(Parser: IParserException);
    procedure MensagemExcecao;
    constructor Create(E : Exception); overload;
    class function New(E : Exception): IParserException;
  end;

implementation

{ TExceptionDataBase }

constructor TExceptionDataBase.Create(E: Exception);
begin
  FExcept := E;
end;

procedure TExceptionDataBase.EfetuarRollback;
begin
  TConexao.New.Rollback;
end;

procedure TExceptionDataBase.MensagemExcecao;
begin
  if FExcept.ClassType <> EDatabaseError then
  begin
    if not Assigned(FProximoParser) then
      raise Exception.Create('Exceção desconhecida.');

    FProximoParser.MensagemExcecao;
    Exit;
  end;

  var Mensagem := 'Erro banco de dados:';
  Mensagem := Mensagem + SLineBreak + FExcept.ClassName + SLineBreak + 'Erro: ' + FExcept.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
  EfetuarRollback;
end;

class function TExceptionDataBase.New(E: Exception): IParserException;
begin
  Result := Self.Create(E);
end;

procedure TExceptionDataBase.SetProximoParser(Parser: IParserException);
begin
  FProximoParser := Parser;
end;

end.

