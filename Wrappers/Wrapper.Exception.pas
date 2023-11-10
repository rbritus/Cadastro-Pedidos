unit Wrapper.Exception;

interface

uses
  SysUtils, FMX.Forms, System.Classes, dbxcommon, Data.DB, Vcl.Dialogs, Utils.Messages,
  FMX.Types, Excecao.Generic, Excecao.AccessViolation, Excecao.ConvercaoDeTipos,
  Excecao.DBX, Excecao.DataBase, Excecao.MensagemPadrao;

type
  TWrapperException = class
    public
      constructor Create;
      procedure TrataException(Sender: TObject; E : Exception);
  end;

var
  MinhaException : TWrapperException;

implementation

uses
  Conexao.unConection;

{ TException }

constructor TWrapperException.Create;
begin
  Application.OnException := TrataException;
end;

procedure TWrapperException.TrataException(Sender: TObject; E : Exception);
begin
  var lExceptionViolation := TExceptionAccessViolation.New(E);
  var lExceptionConversaoDeTipos := TExceptionConvercaoDeTipos.New(E);
  var lExceptionDBX := TExceptionDBX.New(E);
  var lExceptionDataBase := TExceptionDataBase.New(E);
  var lExceptioMensagemPadrao := TExceptionMensagemPadrao.New(E);
  var lExceptionGenerica := TExceptionGenerica.New(E);

  lExceptionViolation.SetProximoParser(lExceptionConversaoDeTipos);
  lExceptionConversaoDeTipos.SetProximoParser(lExceptionDBX);
  lExceptionDBX.SetProximoParser(lExceptionDataBase);
  lExceptionDataBase.SetProximoParser(lExceptioMensagemPadrao);
  lExceptioMensagemPadrao.SetProximoParser(lExceptionGenerica);
  lExceptionGenerica.SetProximoParser(nil);

  lExceptionViolation.MensagemExcecao;
end;

initialization
  MinhaException := TWrapperException.Create;

finalization
  MinhaException.Free;

end.
