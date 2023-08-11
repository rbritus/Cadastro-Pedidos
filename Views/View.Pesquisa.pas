unit View.Pesquisa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, Entidade.Padrao,
  Data.DB, FireDAC.Comp.Client, Conexao.unConection, Utils.Entidade, Data.Bind.DBScope,
  Data.Bind.Components, Data.Bind.Grid;

type
  TViewPesquisa = class(TForm)
    lytBotoes: TLayout;
    recBotoes: TRectangle;
    ShadowEffect1: TShadowEffect;
    btnSelecionar: TButton;
    ShadowEffect2: TShadowEffect;
    lytGride: TLayout;
    ShadowEffect3: TShadowEffect;
    grdDados: TGrid;
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdDadosCellDblClick(const Column: TColumn; const Row: Integer);
  private
    FEntidadeRetorno: TEntidade;
    FQuery: TFDQuery;
    FDataSource: TDataSource;
    FClasseEntidade: TEntidadeClass;
    FBindSourceDB: TBindSourceDB;
    FBindingsList: TBindingsList;
    FLinkGridToDataSource: TLinkGridToDataSource;
    procedure CriarGridePorClasse;
    procedure InicializarComponentesBind;
    procedure FinalizarComponentesBind;
    procedure CriarFieldsGride;
    procedure AjustarColunas;
    procedure CarregarEntidadeSelecionada;
    procedure RetornarPesquisa;
  public
    procedure InformarClasseDaEntidade(AClasseEntidade: TEntidadeClass);
    function ObterEntidadeDoRegistroSelecionado: TEntidade;
  end;

var
  ViewPesquisa: TViewPesquisa;

implementation

{$R *.fmx}

procedure TViewPesquisa.CarregarEntidadeSelecionada;
begin
  FEntidadeRetorno := FClasseEntidade.Create;
  TUtilsEntidade.PreencherEntidade(FEntidadeRetorno,FQuery);
end;

procedure TViewPesquisa.RetornarPesquisa;
begin
  CarregarEntidadeSelecionada;
  Self.Close;
end;

procedure TViewPesquisa.btnSelecionarClick(Sender: TObject);
begin
  RetornarPesquisa;
end;

procedure TViewPesquisa.CriarGridePorClasse;
begin
  FQuery := TConexao.GetQuery;
  FDataSource.DataSet := FQuery;
  FQuery.Open(TUtilsEntidade.ObterSelectSql(FClasseEntidade));

  FBindSourceDB.DataSet := FQuery;

  FLinkGridToDataSource := TLinkGridToDataSource.Create(FBindingsList);
  FLinkGridToDataSource.DataSource := FBindSourceDB;
  FLinkGridToDataSource.GridControl := grdDados;
  CriarFieldsGride;
  AjustarColunas;
end;

procedure TViewPesquisa.CriarFieldsGride;
begin
   TUtilsEntidade.InformarCaptionParaColunas(FQuery,FClasseEntidade);

   for var Contador := 0 to Pred(FQuery.FieldCount) do
     with FLinkGridToDataSource.Columns.Add do
     begin
       Header := FQuery.Fields.Fields[Contador].DisplayLabel;
       MemberName := FQuery.Fields.Fields[Contador].FieldName;
     end;
end;

procedure TViewPesquisa.AjustarColunas;
begin
  for var Contador := 0 to Pred(grdDados.ColumnCount) do
  begin
    if grdDados.Columns[Contador].Width > 260 then
    begin
      grdDados.Columns[Contador].Width := 260;
      Continue;
    end;

    if grdDados.Columns[Contador].Width < 30 then
    begin
      grdDados.Columns[Contador].Width := 30;
      Continue;
    end;
  end;
end;

procedure TViewPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinalizarComponentesBind;

  if Assigned(FQuery) then
    FQuery.DisposeOf;
end;

procedure TViewPesquisa.InicializarComponentesBind;
begin
  FDataSource := TDataSource.Create(Self);
  FBindSourceDB := TBindSourceDB.Create(Self);
  FBindingsList := TBindingsList.Create(Self);
end;

function TViewPesquisa.ObterEntidadeDoRegistroSelecionado: TEntidade;
begin
  Result := FEntidadeRetorno;
end;

procedure TViewPesquisa.FinalizarComponentesBind;
begin
  FDataSource.DisposeOf;
  FBindSourceDB.DisposeOf;
  FBindingsList.DisposeOf;
end;

procedure TViewPesquisa.FormShow(Sender: TObject);
begin
  InicializarComponentesBind;
  CriarGridePorClasse;
end;

procedure TViewPesquisa.grdDadosCellDblClick(const Column: TColumn;
  const Row: Integer);
begin
  RetornarPesquisa;
end;

procedure TViewPesquisa.InformarClasseDaEntidade(AClasseEntidade: TEntidadeClass);
begin
  FClasseEntidade := AClasseEntidade;
end;

end.
