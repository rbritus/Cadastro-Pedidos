program CadastroPedidos;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Cadastro.Pedido in 'Views\View.Cadastro.Pedido.pas' {ViewCadastroPedido},
  Entidade.Padrao in 'Entidades\Entidade.Padrao.pas',
  Entidade.Cliente in 'Entidades\Entidade.Cliente.pas',
  Entidade.Produto in 'Entidades\Entidade.Produto.pas',
  Builder.Cliente in 'Builders\Builder.Cliente.pas',
  Builder.Produto in 'Builders\Builder.Produto.pas',
  View.Cadastro in 'Views\View.Cadastro.pas' {ViewCadastro},
  Utils.Enumerators in 'Utils\Utils.Enumerators.pas',
  Utils.Messages in 'Utils\Utils.Messages.pas',
  Wrapper.Exception in 'Wrappers\Wrapper.Exception.pas',
  Entidade.Pedido in 'Entidades\Entidade.Pedido.pas',
  Builder.Pedido in 'Builders\Builder.Pedido.pas',
  Entidade.PedidoProduto in 'Entidades\Entidade.PedidoProduto.pas',
  Builder.PedidoProduto in 'Builders\Builder.PedidoProduto.pas',
  Conexao.unConection in 'Connection\Conexao.unConection.pas',
  DAO.InterfacePadrao in 'DAO\DAO.InterfacePadrao.pas',
  DAO.Pedido in 'DAO\DAO.Pedido.pas',
  Repository.InterfacePadrao in 'Repositorys\Repository.InterfacePadrao.pas',
  Repository.Pedido in 'Repositorys\Repository.Pedido.pas',
  Utils.Serialize in 'Utils\Utils.Serialize.pas',
  Attributes.Entidades in 'Attributes\Attributes.Entidades.pas',
  DAO.PedidoProduto in 'DAO\DAO.PedidoProduto.pas',
  Repository.PedidoProduto in 'Repositorys\Repository.PedidoProduto.pas',
  View.Pesquisa in 'Views\View.Pesquisa.pas' {ViewPesquisa},
  Repository.Cliente in 'Repositorys\Repository.Cliente.pas',
  DAO.Cliente in 'DAO\DAO.Cliente.pas',
  Repository.Produto in 'Repositorys\Repository.Produto.pas',
  DAO.Produto in 'DAO\DAO.Produto.pas',
  Controller.View.Cadastro.Pedido in 'Controllers\Controller.View.Cadastro.Pedido.pas',
  Utils.Entidade in 'Utils\Utils.Entidade.pas',
  Excecao.Generic in 'Exceptions\Excecao.Generic.pas',
  Excecao.InterfaceParse in 'Exceptions\Excecao.InterfaceParse.pas',
  Excecao.AccessViolation in 'Exceptions\Excecao.AccessViolation.pas',
  Excecao.ConvercaoDeTipos in 'Exceptions\Excecao.ConvercaoDeTipos.pas',
  Excecao.DBX in 'Exceptions\Excecao.DBX.pas',
  Excecao.DataBase in 'Exceptions\Excecao.DataBase.pas',
  Excecao.MensagemPadrao in 'Exceptions\Excecao.MensagemPadrao.pas',
  Conexao.MySql in 'Connection\Conexao.MySql.pas',
  Conexao.SqLite in 'Connection\Conexao.SqLite.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewCadastroPedido, ViewCadastroPedido);
  Application.Run;
end.
