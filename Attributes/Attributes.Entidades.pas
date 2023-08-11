unit Attributes.Entidades;

interface

uses
  System.SysUtils;

type

  TNomeTabela = class(TCustomAttribute)
  private
    FNome: string;
  public
    property Nome: string read FNome write FNome;
    constructor Create(const AValue: string);
  end;

  TAtributoBanco = class(TCustomAttribute)
  private
    Fnome: string;
    Fcaption: string;
    FVisivel: Boolean;
  public
    property nome: string read Fnome write Fnome;
    property caption: string read Fcaption write Fcaption;
    property Visivel: Boolean read FVisivel write FVisivel;
  end;

  TCampoTexto = class(TAtributoBanco)
  public
    constructor create(ANome: string; ACaption: string = ''; AVisivel: Boolean = True); overload;
  end;

  TCampoInteiro = class(TAtributoBanco)
  public
    constructor create(ANome: string; ACaption: string = ''; AVisivel: Boolean = True); overload;
  end;

  TCampoDecimal = class(TAtributoBanco)
  public
    constructor create(ANome: string; ACaption: string = ''; AVisivel: Boolean = True); overload;
  end;

  TCampoData = class(TAtributoBanco)
  public
    constructor create(ANome: string; ACaption: string = ''; AVisivel: Boolean = True); overload;
  end;

implementation

{ TNomeTabela }

constructor TNomeTabela.Create(const AValue: string);
begin
  Self.Nome := AValue;
end;

{ TCampoTexto }

constructor TCampoTexto.create(ANome, ACaption: string; AVisivel: Boolean);
begin
  Fnome := ANome;
  Fcaption := ACaption;
  FVisivel := AVisivel;
end;

{ TCampoInteiro }

constructor TCampoInteiro.create(ANome, ACaption: string; AVisivel: Boolean);
begin
  Fnome := ANome;
  Fcaption := ACaption;
  FVisivel := AVisivel;
end;

{ TCampoDecimal }

constructor TCampoDecimal.create(ANome, ACaption: string; AVisivel: Boolean);
begin
  Fnome := ANome;
  Fcaption := ACaption;
  FVisivel := AVisivel;
end;

{ TCampoData }

constructor TCampoData.create(ANome, ACaption: string; AVisivel: Boolean);
begin
  Fnome := ANome;
  Fcaption := ACaption;
  FVisivel := AVisivel;
end;

end.
