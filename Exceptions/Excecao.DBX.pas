unit Excecao.DBX;

interface

uses
  System.SysUtils, System.Classes, Conexao.unConection, Excecao.InterfaceParse, Vcl.Dialogs,
  Utils.Messages, FMX.Types, FMX.Forms, dbxcommon;

type
  TExceptionDBX = class(TInterfacedObject, IParserException)
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

{ TExceptionDBX }

constructor TExceptionDBX.Create(E: Exception);
begin
  FExcept := E;
end;

procedure TExceptionDBX.EfetuarRollback;
begin
  TConexao.New.Rollback;
end;

procedure TExceptionDBX.MensagemExcecao;
begin
  if FExcept.ClassType <> TDBxError then
  begin
    if not Assigned(FProximoParser) then
      raise Exception.Create('Exceção desconhecida.');

    FProximoParser.MensagemExcecao;
    Exit;
  end;

  var Mensagem := string.Empty;
  case TDBxError(FExcept).ErrorCode of
    TDBXErrorCodes.Warning: Mensagem := 'Warning banco de dados:';
  else
    Mensagem := 'Erro banco de dados:'
  end;
  Mensagem := Mensagem + SLineBreak + FExcept.ClassName + SLineBreak + 'Erro: ' + FExcept.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
  EfetuarRollback;
end;

class function TExceptionDBX.New(E: Exception): IParserException;
begin
  Result := Self.Create(E);
end;

procedure TExceptionDBX.SetProximoParser(Parser: IParserException);
begin
  FProximoParser := Parser;
end;

end.

