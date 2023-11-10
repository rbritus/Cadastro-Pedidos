unit Excecao.Generic;

interface

uses
  System.SysUtils, System.Classes, Conexao.unConection, Excecao.InterfaceParse, Vcl.Dialogs,
  Utils.Messages, FMX.Types, FMX.Forms;

type
  TExceptionGenerica = class(TInterfacedObject, IParserException)
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

{ TExceptionGenerica }

constructor TExceptionGenerica.Create(E: Exception);
begin
  FExcept := E;
end;

procedure TExceptionGenerica.EfetuarRollback;
begin
  TConexao.New.Rollback;
end;

procedure TExceptionGenerica.MensagemExcecao;
begin
//  if FExcept.ClassType <> Exception then
//  begin
//    if not Assigned(FProximoParser) then
//      raise Exception.Create('Exceção desconhecida.');
//
//    FProximoParser.MensagemExcecao;
//  end;

  var Mensagem := 'Notificação de exceção:';
  Mensagem := Mensagem + SLineBreak + FExcept.ClassName + SLineBreak + 'Erro: ' + FExcept.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
  EfetuarRollback;
end;

class function TExceptionGenerica.New(E : Exception): IParserException;
begin
  Result := Self.Create(E);
end;

procedure TExceptionGenerica.SetProximoParser(Parser: IParserException);
begin
  FProximoParser := Parser;
end;

end.
