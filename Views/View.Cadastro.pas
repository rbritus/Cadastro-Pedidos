unit View.Cadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Utils.Enumerators,
  Utils.Messages;

type
  TViewCadastro = class(TForm)
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  protected
    FComportamento: TComportamentoCadastro;
    procedure SetComportamentoInserindo; virtual;
    procedure SetComportamentoEditando; virtual;
  public
    procedure InicializarFormParaCadastro;
    procedure InicializarFormEdicao;
    function FormEmEdicao: Boolean;
  end;

var
  ViewCadastro: TViewCadastro;

implementation

{$R *.fmx}

{ TViewCadastro }

function TViewCadastro.FormEmEdicao: Boolean;
begin
  Result := FComportamento = ccEditando;
end;

procedure TViewCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    Key := vkTab;
    KeyDown(Key, KeyChar, Shift);
  end;
end;

procedure TViewCadastro.InicializarFormEdicao;
begin
  FComportamento := ccEditando;
  SetComportamentoEditando;
end;

procedure TViewCadastro.InicializarFormParaCadastro;
begin
  FComportamento := ccInserindo;
  SetComportamentoInserindo;
end;

procedure TViewCadastro.SetComportamentoEditando;
begin
  raise EMessage.Create('Obrigatório a implementação do método "SetComportamentoEditando".');
end;

procedure TViewCadastro.SetComportamentoInserindo;
begin
  raise EMessage.Create('Obrigatório a implementação do método "SetComportamentoEditando".');
end;

end.
