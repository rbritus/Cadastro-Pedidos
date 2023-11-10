unit Excecao.ConvercaoDeTipos;

interface

uses
  System.SysUtils, System.Classes, Conexao.unConection, Excecao.InterfaceParse, Vcl.Dialogs,
  Utils.Messages, FMX.Types, FMX.Forms;

type
  TExceptionConvercaoDeTipos = class(TInterfacedObject, IParserException)
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

{ TExceptionConvercaoDeTipos }

constructor TExceptionConvercaoDeTipos.Create(E: Exception);
begin
  FExcept := E;
end;

procedure TExceptionConvercaoDeTipos.EfetuarRollback;
begin
  TConexao.New.Rollback;
end;

procedure TExceptionConvercaoDeTipos.MensagemExcecao;
begin
  if FExcept.ClassType <> EConvertError then
  begin
    if not Assigned(FProximoParser) then
      raise Exception.Create('Exceção desconhecida.');

    FProximoParser.MensagemExcecao;
    Exit;
  end;

  var Mensagem := 'Erro de conversão de tipos:';
  Mensagem := Mensagem + SLineBreak + FExcept.ClassName + SLineBreak + 'Erro: ' + FExcept.Message;
  TUtilsMessages.ToastMessage(TForm(Application.MainForm), Mensagem, TAlignLayout.Top, $FFE75050);
  EfetuarRollback;
end;

class function TExceptionConvercaoDeTipos.New(E: Exception): IParserException;
begin
  Result := Self.Create(E);
end;

procedure TExceptionConvercaoDeTipos.SetProximoParser(Parser: IParserException);
begin
  FProximoParser := Parser;
end;

end.

