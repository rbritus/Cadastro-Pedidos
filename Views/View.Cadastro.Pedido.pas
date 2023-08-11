unit View.Cadastro.Pedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Edit, Entidade.Cliente,
  Builder.Cliente, View.Cadastro, FMX.Effects, FireDAC.Stan.Async, FireDAC.DApt,
  FMX.Colors, Utils.Messages, FMX.EditBox, FMX.NumberBox,
  Entidade.PedidoProduto, Entidade.Pedido, Builder.Pedido, Builder.PedidoProduto,
  View.Pesquisa, Entidade.Produto, FireDAC.Stan.ExprFuncs, FMX.DateTimeCtrls,
  FMX.DialogService, FMX.DialogService.Async, Controller.View.Cadastro.Pedido;

type
  TViewCadastroPedido = class(TViewCadastro)
    lytBotoes: TLayout;
    recBotoes: TRectangle;
    lytCliente: TLayout;
    recDadosCliente: TRectangle;
    lytProdutos: TLayout;
    recDadosProduto: TRectangle;
    recTituloCliente: TRectangle;
    recTituloProdutos: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    edtCodigoCliente: TEdit;
    edtNomeCliente: TEdit;
    edtCidadeCliente: TEdit;
    edtUFCliente: TEdit;
    edtCodigoProduto: TEdit;
    edtDescricaoProduto: TEdit;
    dscProdutos: TDataSource;
    tabProdutos: TFDMemTable;
    tabProdutosCodigo: TIntegerField;
    tabProdutosDescricao: TStringField;
    tabProdutosPreco: TFloatField;
    ShadowEffect2: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    btnAddProduto: TRoundRect;
    Label4: TLabel;
    ShadowEffect7: TShadowEffect;
    edtPreco: TEdit;
    btnGravarPedido: TRoundRect;
    Label3: TLabel;
    ShadowEffect3: TShadowEffect;
    btnPesquisarCliente: TCircle;
    Image1: TImage;
    btnPesquisarProduto: TCircle;
    Image2: TImage;
    edtQuantidade: TEdit;
    tabProdutosquantidade: TIntegerField;
    tabProdutosvalor_total: TFloatField;
    grdDados: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Rectangle1: TRectangle;
    edtValorTotal: TEdit;
    Label5: TLabel;
    tabProdutosTotalGeral: TAggregateField;
    lytPedido: TLayout;
    Rectangle2: TRectangle;
    ShadowEffect9: TShadowEffect;
    Rectangle3: TRectangle;
    Label6: TLabel;
    ShadowEffect10: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    ShadowEffect13: TShadowEffect;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    ShadowEffect17: TShadowEffect;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    ShadowEffect1: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    edtNumeroPedido: TEdit;
    edtDataEmissao: TDateEdit;
    Label7: TLabel;
    Label8: TLabel;
    ShadowEffect8: TShadowEffect;
    ShadowEffect20: TShadowEffect;
    tabProdutosID_PEDIDOPRODUTO: TIntegerField;
    btnCarregarPedido: TRoundRect;
    Label9: TLabel;
    ShadowEffect21: TShadowEffect;
    btnExcluirPedido: TRoundRect;
    Label10: TLabel;
    ShadowEffect22: TShadowEffect;
    procedure btnAddProdutoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure tabProdutosCalcFields(DataSet: TDataSet);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnCarregarPedidoClick(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure btnExcluirPedidoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LimparEditsGrupoProdutos;
    procedure AdicionarProdutoNaGride; overload;
    procedure AdicionarProdutoNaGride(AProduto: TProduto); overload;
    function ProdutoInformadoParaAdicao: Boolean;
    procedure PreencherCamposDoCliente(ACliente: TCliente);
    procedure LimparCamposDoCliente;
    procedure LimparCamposDoProduto;
    procedure PreencherCamposDoProduto(AProduto: TProduto);
    procedure InformarTotalNoRodape;
    procedure LimparGride;
    procedure InicializarCamposDoPedido; overload;
    procedure InicializarCamposDoPedido(APedido: TPedido); overload;
    procedure ValidarCamposObrigatorios;
    procedure GravarPedido;
    procedure GravarProdutosDoPedido;
    procedure LimparCamposDoPedido;
    function ObterNumeroDoPedidoParaEdicao: integer;
    procedure CarregarDadosDoPedidoParaEdicao(ANumeroPedido: Integer);
    procedure CarregarListaDePedidoProdutosParaEdicao(ANumeroPedido: Integer);
    procedure CarregarDadosDoPedidoParaExclusao(ANumeroPedido: Integer);
    procedure ExcluirListaPedidoProdutos(ANumeroPedido: Integer);
    procedure OnKeyDownGrdDados(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure ExcluirRegistroGride;
    procedure ExcluirPedidoProduto(AId: Integer);
  protected
    procedure SetComportamentoInserindo; override;
    procedure SetComportamentoEditando; override;
  end;

var
  ViewCadastroPedido: TViewCadastroPedido;

implementation

{$R *.fmx}

procedure TViewCadastroPedido.AdicionarProdutoNaGride(AProduto: TProduto);
begin
  tabProdutos.AppendRecord([AProduto.ID,
                            AProduto.Descricao,
                            AProduto.Preco,
                            1,
                            0]);
  LimparEditsGrupoProdutos;
  AProduto.DisposeOf;
end;

procedure TViewCadastroPedido.btnAddProdutoClick(Sender: TObject);
begin
  inherited;
  if not ProdutoInformadoParaAdicao then
    TUtilsMessages.ToastMessage('Informe o produto a quantidade e o preço.');

  AdicionarProdutoNaGride;
  edtCodigoProduto.SetFocus;
end;

function TViewCadastroPedido.ObterNumeroDoPedidoParaEdicao: integer;
begin
  var NumeroPedido: string;
  TDialogService.InputQuery('Edição de pedido',['Informe o número:'],[''],
    procedure(const AResult: TModalResult; const AValue: array of string)
    begin
      if AResult = mrOk then
        NumeroPedido := AValue[0];
    end);
  Result := NumeroPedido.ToInteger;
end;

procedure TViewCadastroPedido.CarregarListaDePedidoProdutosParaEdicao(ANumeroPedido: Integer);
begin
  var Lista := TControllerCadastroPedido.New.ObterListaDePedidoProdutos(ANumeroPedido);

  for var PedidoProduto in Lista do
  begin
    var Produto := TControllerCadastroPedido.New.ObterProduto(PedidoProduto.IdProduto);
    tabProdutos.AppendRecord([Produto.ID,
                              Produto.Descricao,
                              PedidoProduto.Preco,
                              PedidoProduto.Quantidade,
                              PedidoProduto.ID]);
    Produto.DisposeOf;
    PedidoProduto.DisposeOf;
  end;
end;

procedure TViewCadastroPedido.CarregarDadosDoPedidoParaEdicao(ANumeroPedido: Integer);
begin
  Var Pedido := TControllerCadastroPedido.New.ObterPedido(ANumeroPedido);

  if Pedido.Numero = 0 then
    TUtilsMessages.ToastMessage('O pedido não foi encontrado!');

  InicializarCamposDoPedido(Pedido);
  var Cliente := TControllerCadastroPedido.New.ObterCliente(Pedido.IdCliente);
  PreencherCamposDoCliente(Cliente);
  CarregarListaDePedidoProdutosParaEdicao(Pedido.Numero);
  Pedido.DisposeOf;
end;

procedure TViewCadastroPedido.btnCarregarPedidoClick(Sender: TObject);
begin
  inherited;
  InicializarFormEdicao;

  var NumeroPedido := ObterNumeroDoPedidoParaEdicao;
  CarregarDadosDoPedidoParaEdicao(NumeroPedido);
end;

procedure TViewCadastroPedido.btnExcluirPedidoClick(Sender: TObject);
begin
  inherited;
  var NumeroPedido := ObterNumeroDoPedidoParaEdicao;
  CarregarDadosDoPedidoParaExclusao(NumeroPedido);
  TControllerCadastroPedido.New.Commit;
  TUtilsMessages.ToastMessage('Pedido excluído!');
  InicializarFormParaCadastro;
end;

procedure TViewCadastroPedido.CarregarDadosDoPedidoParaExclusao(ANumeroPedido: Integer);
begin
  Var Pedido := TControllerCadastroPedido.New.ObterPedido(ANumeroPedido);

  if Pedido.Numero = 0 then
    TUtilsMessages.ToastMessage('O pedido não foi encontrado!');

  ExcluirListaPedidoProdutos(Pedido.Numero);
  TControllerCadastroPedido.New.ExcluirPedido(Pedido);
  Pedido.DisposeOf;
end;

procedure TViewCadastroPedido.ExcluirListaPedidoProdutos(ANumeroPedido: Integer);
begin
  var Lista := TControllerCadastroPedido.New.ObterListaDePedidoProdutos('NUMERO_PEDIDO = '+ANumeroPedido.ToString);
  TControllerCadastroPedido.New.ExcluirListaPedidoProduto(Lista);
  Lista.DisposeOf;
end;

procedure TViewCadastroPedido.AdicionarProdutoNaGride;
begin
  tabProdutos.AppendRecord([edtCodigoProduto.Text.ToInteger,
                            edtDescricaoProduto.Text.Trim,
                            edtPreco.Text.ToDouble,
                            edtQuantidade.Text.ToInteger,
                            0]);
  LimparEditsGrupoProdutos;
  edtCodigoProduto.SetFocus;
end;

procedure TViewCadastroPedido.LimparEditsGrupoProdutos;
begin
  edtCodigoProduto.Text := EmptyStr;
  edtDescricaoProduto.Text := EmptyStr;
  edtQuantidade.Text := EmptyStr;
  edtPreco.Text := EmptyStr;
end;

procedure TViewCadastroPedido.ValidarCamposObrigatorios;
begin
  if edtCodigoCliente.Text.Trim.IsEmpty then
    TUtilsMessages.ToastMessage('Cliente não informado.');

  if tabProdutos.IsEmpty then
    TUtilsMessages.ToastMessage('Não existem produtos lançados no pedido.');

  if edtDataEmissao.Date = 0 then
    TUtilsMessages.ToastMessage('Data de emissão não informada');
end;

procedure TViewCadastroPedido.GravarPedido;
begin
  var Pedido := TPedido.Create(
    TBuilderPedido.New.SetNumero(edtNumeroPedido.Text.ToInteger)
      .SetDataEmissao(edtDataEmissao.Date)
      .SetIdCliente(edtCodigoCliente.Text.ToInteger)
      .SetValorTotal(edtValorTotal.Text.ToDouble)
  );
  if FormEmEdicao then
    TControllerCadastroPedido.New.AtualizarPedido(Pedido)
  else
    TControllerCadastroPedido.New.InserirPedido(Pedido);
end;

procedure TViewCadastroPedido.GravarProdutosDoPedido;
begin
  tabProdutos.DisableControls;
  try
    tabProdutos.First;
    while not tabProdutos.Eof do
    begin
      var PedidoProduto := TPedidoProduto.Create(
        TBuilderPedidoProduto.New.SetID(tabProdutos.FieldByName('ID_PEDIDOPRODUTO').AsInteger)
          .SetNumeroPedido(edtNumeroPedido.Text.ToInteger)
          .SetIdProduto(tabProdutos.FieldByName('Codigo').AsInteger)
          .SetQuantidade(tabProdutos.FieldByName('quantidade').AsInteger)
          .SetPreco(tabProdutos.FieldByName('Preco').AsFloat)
          .SetValorTotal(tabProdutos.FieldByName('valor_total').AsFloat)
      );

      if PedidoProduto.ID <> 0 then
        TControllerCadastroPedido.New.AtualizarPedidoProduto(PedidoProduto)
      else
        TControllerCadastroPedido.New.InserirPedidoProduto(PedidoProduto);

      tabProdutos.Next;
    end;
  finally
    tabProdutos.EnableControls;
  end;
end;

procedure TViewCadastroPedido.btnGravarPedidoClick(Sender: TObject);
begin
  inherited;
  ValidarCamposObrigatorios;
  GravarPedido;
  GravarProdutosDoPedido;
  TControllerCadastroPedido.New.Commit;
  TUtilsMessages.ToastMessage('Pedido excluído!');
  InicializarFormParaCadastro;
end;

procedure TViewCadastroPedido.btnPesquisarClienteClick(Sender: TObject);
begin
  Application.CreateForm(TViewPesquisa,ViewPesquisa);
  ViewPesquisa.InformarClasseDaEntidade(TCliente);
  ViewPesquisa.ShowModal;
  var Cliente := TCliente(ViewPesquisa.ObterEntidadeDoRegistroSelecionado);
  ViewPesquisa.DisposeOf;

  if not Assigned(Cliente) then
    TUtilsMessages.ToastMessage('Cliente não encontrado!');

  PreencherCamposDoCliente(Cliente);
end;

procedure TViewCadastroPedido.PreencherCamposDoCliente(ACliente: TCliente);
begin
  edtCodigoCliente.Text := ACliente.ID.ToString;
  edtNomeCliente.Text := ACliente.Nome;
  edtCidadeCliente.Text := ACliente.Cidade;
  edtUFCliente.Text := ACliente.UF;
  ACliente.DisposeOf;
end;

procedure TViewCadastroPedido.LimparCamposDoCliente;
begin
  edtCodigoCliente.Text := EmptyStr;
  edtNomeCliente.Text := EmptyStr;
  edtCidadeCliente.Text := EmptyStr;
  edtUFCliente.Text := EmptyStr;
end;

procedure TViewCadastroPedido.btnPesquisarProdutoClick(Sender: TObject);
begin
  Application.CreateForm(TViewPesquisa,ViewPesquisa);
  ViewPesquisa.InformarClasseDaEntidade(TProduto);
  ViewPesquisa.ShowModal;
  var Produto := TProduto(ViewPesquisa.ObterEntidadeDoRegistroSelecionado);
  ViewPesquisa.DisposeOf;

  if not Assigned(Produto) then
    TUtilsMessages.ToastMessage('Produto não encontrado!');

  AdicionarProdutoNaGride(Produto);
  edtCodigoProduto.SetFocus;
end;

procedure TViewCadastroPedido.LimparCamposDoProduto;
begin
  edtCodigoProduto.Text := EmptyStr;
  edtDescricaoProduto.Text := EmptyStr;
  edtPreco.Text := EmptyStr;
end;

function TViewCadastroPedido.ProdutoInformadoParaAdicao: Boolean;
begin
  Result := not edtCodigoProduto.Text.Trim.IsEmpty and not edtDescricaoProduto.Text.Trim.IsEmpty
    and (StrToFloatDef(edtPreco.Text,0) > 0);
end;

procedure TViewCadastroPedido.edtCodigoClienteChange(Sender: TObject);
begin
  inherited;
  btnCarregarPedido.Visible := edtCodigoCliente.Text.Trim.IsEmpty and not FormEmEdicao;
  btnExcluirPedido.Visible := edtCodigoCliente.Text.Trim.IsEmpty and not FormEmEdicao;
end;

procedure TViewCadastroPedido.edtCodigoClienteExit(Sender: TObject);
begin
  inherited;
  if edtCodigoCliente.Text.Trim.IsEmpty then
  begin
    LimparCamposDoCliente;
    Exit;
  end;

  var Cliente := TControllerCadastroPedido.New.ObterCliente(StrToInt(edtCodigoCliente.Text));
  PreencherCamposDoCliente(Cliente);
end;

procedure TViewCadastroPedido.edtCodigoProdutoExit(Sender: TObject);
begin
  inherited;
  if edtCodigoProduto.Text.Trim.IsEmpty then
  begin
    LimparCamposDoProduto;
    Exit;
  end;

  var Produto := TControllerCadastroPedido.New.ObterProduto(StrToInt(edtCodigoProduto.Text));
  PreencherCamposDoProduto(Produto);
end;

procedure TViewCadastroPedido.PreencherCamposDoProduto(AProduto: TProduto);
begin
  edtCodigoProduto.Text := AProduto.ID.ToString;
  edtDescricaoProduto.Text := AProduto.Descricao;
  edtQuantidade.Text := '1';
  edtPreco.Text := AProduto.Preco.ToString;
  AProduto.DisposeOf;
end;

procedure TViewCadastroPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if FormEmEdicao then
    TControllerCadastroPedido.New.Rollback;
end;

procedure TViewCadastroPedido.FormShow(Sender: TObject);
begin
  inherited;
  tabProdutos.CreateDataSet;
  InicializarFormParaCadastro;
  grdDados.OnKeyDown := OnKeyDownGrdDados;
end;

procedure TViewCadastroPedido.ExcluirPedidoProduto(AId: Integer);
begin
  var PedidoProduto := TControllerCadastroPedido.New.ObterPedidoProduto(AId);
  TControllerCadastroPedido.New.ExcluirPedidoProduto(PedidoProduto);
  PedidoProduto.DisposeOf;
end;

procedure TViewCadastroPedido.ExcluirRegistroGride;
begin
  if tabProdutos.IsEmpty then
    Exit;

  if not TUtilsMessages.GetDeleteConfirmation('Deseja excluir o produto do pedido?') then
    Exit;

  if tabProdutos.FieldByName('ID_PEDIDOPRODUTO').AsInteger > 0 then
    ExcluirPedidoProduto(tabProdutos.FieldByName('ID_PEDIDOPRODUTO').AsInteger);

  tabProdutos.Delete;
end;

procedure TViewCadastroPedido.OnKeyDownGrdDados(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkDelete then
    ExcluirRegistroGride;
end;

procedure TViewCadastroPedido.LimparCamposDoPedido;
begin
  edtNumeroPedido.Text := EmptyStr;
  edtDataEmissao.Date := Date;
  edtValorTotal.Text := EmptyStr;
end;

procedure TViewCadastroPedido.SetComportamentoEditando;
begin
  LimparCamposDoCliente;
  LimparCamposDoProduto;
  LimparGride;
  LimparCamposDoPedido
end;

procedure TViewCadastroPedido.LimparGride;
begin
  tabProdutos.EmptyDataSet;
end;

procedure TViewCadastroPedido.InicializarCamposDoPedido;
begin
  edtNumeroPedido.Text := TControllerCadastroPedido.New.ObterNovoNumeroDePedido.ToString;
  edtDataEmissao.Date := Date;
  edtValorTotal.Text := EmptyStr;
end;

procedure TViewCadastroPedido.SetComportamentoInserindo;
begin
  LimparCamposDoCliente;
  LimparCamposDoProduto;
  LimparGride;
  InicializarCamposDoPedido;
  edtCodigoCliente.SetFocus;
end;

procedure TViewCadastroPedido.tabProdutosCalcFields(DataSet: TDataSet);
begin
  tabProdutos.FieldByName('valor_total').AsFloat := tabProdutos.FieldByName('Preco').AsFloat *
    tabProdutos.FieldByName('quantidade').AsInteger;
  InformarTotalNoRodape;
end;

procedure TViewCadastroPedido.InformarTotalNoRodape;
begin
  edtValorTotal.Text := tabProdutos.FieldByName('TotalGeral').AsString;
end;

procedure TViewCadastroPedido.InicializarCamposDoPedido(APedido: TPedido);
begin
  edtNumeroPedido.Text := APedido.Numero.ToString;
  edtDataEmissao.Date := APedido.DataEmissao;
  edtValorTotal.Text := APedido.ValorTotal.ToString;
end;

end.
