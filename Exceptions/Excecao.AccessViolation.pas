unit Excecao.AccessViolation;

interface

uses
  System.SysUtils, System.Classes, Conexao.unConection, Excecao.InterfaceParse, Vcl.Dialogs,
  Utils.Messages, FMX.Types, FMX.Forms;

type
  TExceptionAccessViolation = class(TInterfacedObject, IParserException)
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

{ TExceptionAccessViolation }

constructor TExceptionAccessViolation.Create(E: Exception);
begin
  FExcept := E;
end;

procedure TExceptionAccessViolation.EfetuarRollback;
begin
  TConexao.New.Rollback;
end;

procedure TExceptionAccessViolation.MensagemExcecao;
begin
  if FExcept.ClassType <> EAccessViolation then
  begin
    if not Assigned(FProximoParser) then
      raise Exception.Create('Exceção desconhecida.');

    FProximoParser.MensagemExcecao;
    Exit;
  end;

  var Mensagem := 'Acesso inválido à memória:';
  Mensagem := Mensagem + SLineBreak + FExcept.ClassName + SLineBreak + 'Erro: ' + FExcept.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
  EfetuarRollback;
end;

class function TExceptionAccessViolation.New(E: Exception): IParserException;
begin
  Result := Self.Create(E);
end;

procedure TExceptionAccessViolation.SetProximoParser(Parser: IParserException);
begin
  FProximoParser := Parser;
end;

end.
