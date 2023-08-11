unit Wrapper.Exception;

interface

uses
  SysUtils, FMX.Forms, System.Classes, dbxcommon, Data.DB, Vcl.Dialogs, Utils.Messages,
  FMX.Types;

type
  TWrapperException = class
    private
      procedure EfetuarRollback;
    public
      constructor Create;
      procedure TrataException(Sender: TObject; E : Exception);
  end;

  TExceptionGenerica = class
      class procedure MensagemExcecao(Sender: TObject; E : Exception);
  end;

  TExceptionAccessViolation = class
      class procedure MensagemExcecao(Sender: TObject; E : EAccessViolation);
  end;

  TExceptionConvercaoDeTipos = class
      class procedure MensagemExcecao(Sender: TObject; E : EConvertError);
  end;

  TExceptionDBX = class
      class procedure MensagemExcecao(Sender: TObject; E : TDBxError);
  end;

  TExceptionDataBase = class
      class procedure MensagemExcecao(Sender: TObject; E : EDatabaseError);
  end;

  TExceptionMensagemPadrao = class
      class procedure MensagemExcecao(Sender: TObject; E : EMessage);
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

procedure TWrapperException.EfetuarRollback;
begin
  if TConexao.GetConnection.InTransaction then
    TConexao.GetConnection.RollbackRetaining;
end;

procedure TWrapperException.TrataException(Sender: TObject; E : Exception);
begin
  if E.ClassType = EAccessViolation then
  begin
    TExceptionAccessViolation.MensagemExcecao(Sender,E as EAccessViolation);
    EfetuarRollback;
    Exit;
  end;

  if E.ClassType = EConvertError then
  begin
    TExceptionConvercaoDeTipos.MensagemExcecao(Sender,E as EConvertError);
    EfetuarRollback;
    Exit;
  end;

  if E.ClassType = TDBxError then
  begin
    TExceptionDBX.MensagemExcecao(Sender,E as TDBxError);
    EfetuarRollback;
    Exit;
  end;

  if E.ClassType = EDatabaseError then
  begin
    TExceptionDataBase.MensagemExcecao(Sender,E as EDatabaseError);
    EfetuarRollback;
    Exit;
  end;

  if E.ClassType = EMessage then
  begin
    TExceptionMensagemPadrao.MensagemExcecao(Sender,E as EMessage);
    Exit;
  end;

  TExceptionGenerica.MensagemExcecao(Sender,E);
  EfetuarRollback;
end;

{ TException }

class procedure TExceptionGenerica.MensagemExcecao(Sender: TObject; E: Exception);
begin
  var Mensagem := 'Notificação de exceção:';
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
end;

{ TExceptionAccessViolation }

class procedure TExceptionAccessViolation.MensagemExcecao(Sender: TObject; E: EAccessViolation);
begin
  var Mensagem := 'Acesso inválido à memória:';
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
end;

{ TExceptionConvercaoDeTipos }

class procedure TExceptionConvercaoDeTipos.MensagemExcecao(Sender: TObject; E: EConvertError);
begin
  var Mensagem := 'Erro de conversão de tipos:';
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
end;

{ TExceptionBancoDeDados }

class procedure TExceptionDBX.MensagemExcecao(Sender: TObject; E: TDBxError);
begin
  var Mensagem := string.Empty;
  case E.ErrorCode of
    TDBXErrorCodes.Warning: Mensagem := 'Warning banco de dados:';
  else
    Mensagem := 'Erro banco de dados:'
  end;
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
end;

{ TExceptionDataBase }

class procedure TExceptionDataBase.MensagemExcecao(Sender: TObject; E: EDatabaseError);
begin
  var Mensagem := 'Erro banco de dados:';
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
end;

{ TExceptionMensagemPadrao }

class procedure TExceptionMensagemPadrao.MensagemExcecao(Sender: TObject;
  E: EMessage);
begin
  var Mensagem := E.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top);
end;

initialization
  MinhaException := TWrapperException.Create;

finalization
  MinhaException.Free;

end.
