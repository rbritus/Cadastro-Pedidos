unit Excecao.InterfaceParse;

interface

type
  IParserException = interface
    procedure SetProximoParser(Parser: IParserException);
    procedure MensagemExcecao;
  end;

implementation

end.
