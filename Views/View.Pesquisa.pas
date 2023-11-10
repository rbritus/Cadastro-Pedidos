unit View.Pesquisa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, Entidade.Padrao,
  Data.DB, FireDAC.Comp.Client, Conexao.unConection, Utils.Entidade, Data.Bind.DBScope,
  Data.Bind.Components, Data.Bind.Grid, Generics.Collections, Generics.Defaults;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdDadosCellDblClick(const Column: TColumn; const Row: Integer);
    procedure FormCreate(Sender: TObject);
  private
    FSelecionado: Boolean;
    FQuery: TFDQuery;
    FDataSource: TDataSource;
    FBindSourceDB: TBindSourceDB;
    FBindingsList: TBindingsList;
    FLinkGridToDataSource: TLinkGridToDataSource;
    procedure CriarGridePorClasse(AClasseEntidade: TClass);
    procedure InicializarComponentesBind;
    procedure FinalizarComponentesBind;
    procedure CriarFieldsGride(AClasseEntidade: TClass);
    procedure AjustarColunas;
    procedure CarregarEntidadeSelecionada(AEntidade: TEntidade);
  public
    class function New(AOwner: TComponent): TViewPesquisa;
    function InformarCaption(ACaption: string): TViewPesquisa;
    function ShowConsulta<T: Class>: T;
  end;

implementation

{$R *.fmx}

function TViewPesquisa.ShowConsulta<T>: T;
begin
  var Entidade: T;
  Self.CriarGridePorClasse(T);
  Self.ShowModal;

  if FSelecionado then
  begin
    Entidade := TUtilsEntidade.ObterObjetoGenerico<T>;
    CarregarEntidadeSelecionada(TEntidade(Entidade));
  end;

  Result := Entidade;
end;

procedure TViewPesquisa.CarregarEntidadeSelecionada(AEntidade: TEntidade);
begin
  TUtilsEntidade.PreencherEntidade(AEntidade,FQuery);
end;

procedure TViewPesquisa.btnSelecionarClick(Sender: TObject);
begin
  FSelecionado := True;
  Close;
end;

procedure TViewPesquisa.CriarGridePorClasse(AClasseEntidade: TClass);
begin
  FQuery := TConexao.New.GetQuery;
  FDataSource.DataSet := FQuery;
  FQuery.Open(TUtilsEntidade.ObterSelectSql(TEntidadeClass(AClasseEntidade)));

  FBindSourceDB.DataSet := FQuery;

  FLinkGridToDataSource := TLinkGridToDataSource.Create(FBindingsList);
  FLinkGridToDataSource.DataSource := FBindSourceDB;
  FLinkGridToDataSource.GridControl := grdDados;
  CriarFieldsGride(AClasseEntidade);
  AjustarColunas;
end;

procedure TViewPesquisa.CriarFieldsGride(AClasseEntidade: TClass);
begin
   TUtilsEntidade.InformarCaptionParaColunas(FQuery,TEntidadeClass(AClasseEntidade));

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

  Action := TCloseAction.caFree;
end;

procedure TViewPesquisa.FormCreate(Sender: TObject);
begin
  FSelecionado := False;
  InicializarComponentesBind;
end;

function TViewPesquisa.InformarCaption(ACaption: string): TViewPesquisa;
begin
  Result := Self;
  Self.Caption := ACaption;
end;

procedure TViewPesquisa.InicializarComponentesBind;
begin
  FDataSource := TDataSource.Create(Self);
  FBindSourceDB := TBindSourceDB.Create(Self);
  FBindingsList := TBindingsList.Create(Self);
end;

class function TViewPesquisa.New(AOwner: TComponent): TViewPesquisa;
begin
  Result := TViewPesquisa.Create(AOwner)
end;

procedure TViewPesquisa.FinalizarComponentesBind;
begin
  FDataSource.DisposeOf;
  FBindSourceDB.DisposeOf;
  FBindingsList.DisposeOf;
end;

procedure TViewPesquisa.grdDadosCellDblClick(const Column: TColumn;
  const Row: Integer);
begin
  FSelecionado := True;
  Close;
end;

end.
