unit Excecao.MensagemPadrao;

interface

uses
  System.SysUtils, System.Classes, Conexao.unConection, Excecao.InterfaceParse, Vcl.Dialogs,
  Utils.Messages, FMX.Types, FMX.Forms;

type
  TExceptionMensagemPadrao = class(TInterfacedObject, IParserException)
  private
    FExcept: Exception;
    FProximoParser: IParserException;
  public
    procedure SetProximoParser(Parser: IParserException);
    procedure MensagemExcecao;
    constructor Create(E : Exception); overload;
    class function New(E : Exception): IParserException;
  end;

implementation

{ TExceptionMensagemPadrao }

constructor TExceptionMensagemPadrao.Create(E: Exception);
begin
  FExcept := E;
end;

procedure TExceptionMensagemPadrao.MensagemExcecao;
begin
  if FExcept.ClassType <> EMessage then
  begin
    if not Assigned(FProximoParser) then
      raise Exception.Create('Exceção desconhecida.');

    FProximoParser.MensagemExcecao;
    Exit;
  end;

  var Mensagem := FExcept.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFB7B11C);
end;

class function TExceptionMensagemPadrao.New(E: Exception): IParserException;
begin
  Result := Self.Create(E);
end;

procedure TExceptionMensagemPadrao.SetProximoParser(Parser: IParserException);
begin
  FProximoParser := Parser;
end;

end.

