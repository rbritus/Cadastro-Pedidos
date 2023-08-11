unit Utils.Messages;

interface

uses
  System.Classes, System.SysUtils, Winapi.Windows, FMX.Dialogs, FMX.Forms,
  System.UITypes, FMX.Types, FMX.Controls, FMX.StdCtrls, FMX.Objects,
  FMX.Effects, FMX.Layouts, FMX.Graphics, FMX.Ani, FMX.VirtualKeyboard,
  FMX.Platform, Vcl.Clipbrd, FMX.DialogService;

type
  EMessage = Class(Exception);

  TUtilsMessages = class
  private
    class var FMsg: string;
    class var Layout: TLayout;
    class var Fundo: TRectangle;
    class var Arco: TArc;
    class var Mensagem: TLabel;
    class var Animacao: TFloatAnimation;
    class var LayoutToast: TLayout;
    class var FundoToast: TRectangle;
    class var ButtonCopy: TSpeedButton;
    class var AnimacaoToast: TFloatAnimation;
    class var MensagemToast: TLabel;
    class procedure DeleteToast(Sender: TObject);
    class procedure ButtonCopyClick(Sender: TObject);
  public
    class procedure Show(const Frm: Tform; const msg: string);
    class procedure Hide;
    class procedure ToastMessage(const Frm: Tform; const msg: string;
      alinhamento: TAlignLayout = TAlignLayout.Bottom; cor_fundo: Cardinal = $FF88A5E6;
      cor_fonte: Cardinal = $FFFFFFFF; duracao: integer = 5); overload;
    class procedure ToastMessage(const AMensagem: string); overload;
    class function GetDeleteConfirmation(AMessage: String): Boolean;
  end;


implementation

uses
  Vcl.Graphics;

{ TUtilsMessages }

class procedure TUtilsMessages.Hide;
begin
  if Assigned(Layout) then
  begin
    try
      if Assigned(Mensagem) then
        Mensagem.DisposeOf;

      if Assigned(Animacao) then
        Animacao.DisposeOf;

      if Assigned(Arco) then
        Arco.DisposeOf;

      if Assigned(Fundo) then
        Fundo.DisposeOf;

      if Assigned(Layout) then
        Layout.DisposeOf;
    except
    end;
  end;

  Mensagem := nil;
  Animacao := nil;
  Arco := nil;
  Layout := nil;
  Fundo := nil;
  ButtonCopy := nil;
  FMsg := EmptyStr;
end;

class procedure TUtilsMessages.Show(const Frm : Tform; const msg: string);
var
  FService: IFMXVirtualKeyboardService;
begin
  FMsg := msg;
        // Panel de fundo opaco...
  Fundo := TRectangle.Create(Frm);
  Fundo.Opacity := 0;
  Fundo.Parent := Frm;
  Fundo.Visible := true;
  Fundo.Align := TAlignLayout.Contents;
  Fundo.Fill.Color := TAlphaColorRec.Black;
  Fundo.Fill.Kind := TBrushKind.Solid;
  Fundo.Stroke.Kind := TBrushKind.None;
  Fundo.Visible := true;

  // Layout contendo o texto e o arco...
  Layout := TLayout.Create(Frm);
  Layout.Opacity := 0;
  Layout.Parent := Frm;
  Layout.Visible := true;
  Layout.Align := TAlignLayout.Contents;
  Layout.Width := 250;
  Layout.Height := 78;
  Layout.Visible := true;

  // Arco da animacao...
  Arco := TArc.Create(Frm);
  Arco.Visible := true;
  Arco.Parent := Layout;
  Arco.Align := TAlignLayout.Center;
  Arco.Margins.Bottom := 55;
  Arco.Width := 25;
  Arco.Height := 25;
  Arco.EndAngle := 280;
  Arco.Stroke.Color := $FFFEFFFF;
  Arco.Stroke.Thickness := 2;
  Arco.Position.X := trunc((Layout.Width - Arco.Width) / 2);
  Arco.Position.Y := 0;

  // Animacao...
  Animacao := TFloatAnimation.Create(Frm);
  Animacao.Parent := Arco;
  Animacao.StartValue := 0;
  Animacao.StopValue := 360;
  Animacao.Duration := 0.8;
  Animacao.Loop := true;
  Animacao.PropertyName := 'RotationAngle';
  Animacao.AnimationType := TAnimationType.InOut;
  Animacao.Interpolation := TInterpolationType.Linear;
  Animacao.Start;

  // Label do texto...
  Mensagem := TLabel.Create(Frm);
  Mensagem.Parent := Layout;
  Mensagem.Align := TAlignLayout.Center;
  Mensagem.Margins.Top := 60;
  Mensagem.Font.Size := 13;
  Mensagem.Height := 70;
  Mensagem.Width := Frm.Width - 100;
  Mensagem.FontColor := $FFFEFFFF;
  Mensagem.TextSettings.HorzAlign := TTextAlign.Center;
  Mensagem.TextSettings.VertAlign := TTextAlign.Leading;
  Mensagem.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
  Mensagem.Text := msg;
  Mensagem.VertTextAlign := TTextAlign.Leading;
  Mensagem.Trimming := TTextTrimming.None;
  Mensagem.TabStop := false;
  Mensagem.SetFocus;

  ButtonCopy := TSpeedButton.Create(Frm);
  ButtonCopy.Parent := Fundo;
  ButtonCopy.Size.Height := 24;
  ButtonCopy.Size.Width := 24;
  ButtonCopy.HitTest := True;
  ButtonCopy.Hint := 'Copiar mensagem.';
  ButtonCopy.Position.X := Fundo.Size.Width - 30;
  ButtonCopy.Position.Y := Fundo.Size.Height - 30;
  ButtonCopy.StyleLookup := 'composetoolbutton';
  ButtonCopy.OnClick := ButtonCopyClick;

  // Exibe os controles...
  TAnimator.AnimateFloat(Fundo, 'Opacity', 0.7);
  TAnimator.AnimateFloat(Layout, 'Opacity', 1);
  Layout.BringToFront;

  // Esconde o teclado virtual...
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
    IInterface(FService));
  if (FService <> nil) then
    FService.HideVirtualKeyboard;

  FService := nil;
end;

class procedure TUtilsMessages.ToastMessage(const AMensagem: string);
begin
  raise EMessage.Create(AMensagem);
end;

class procedure TUtilsMessages.ButtonCopyClick(Sender: TObject);
begin
  Clipboard.AsText := FMsg;
end;

class procedure TUtilsMessages.DeleteToast(Sender: TObject);
begin
  if Assigned(FundoToast) then
  begin
    FundoToast.Visible := false;

    try
      if Assigned(MensagemToast) then
        MensagemToast.DisposeOf;

      if Assigned(AnimacaoToast) then
        AnimacaoToast.DisposeOf;

      if Assigned(FundoToast) then
        FundoToast.DisposeOf;

      if Assigned(LayoutToast) then
        LayoutToast.DisposeOf;
    except
    end;
  end;

  MensagemToast := nil;
  AnimacaoToast := nil;
  FundoToast := nil;
  LayoutToast := nil;
  ButtonCopy := nil;
  FMsg := EmptyStr;
end;

class function TUtilsMessages.GetDeleteConfirmation(AMessage: String): Boolean;
begin
  var lResultStr := False;
  TDialogService.PreferredMode := TDialogService.TPreferredMode.platform;
  TDialogService.MessageDialog(AMessage, TMsgDlgType.mtConfirmation, FMX.Dialogs.mbYesNo, TMsgDlgBtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    begin
      case AResult of
        mrYes:
          lResultStr := True;
        mrNo:
          lResultStr := False;
      end;
    end);

  Result := lResultStr;
end;

class procedure TUtilsMessages.ToastMessage(const Frm : Tform; const msg: string;
  alinhamento: TAlignLayout = TAlignLayout.Bottom; cor_fundo: Cardinal = $FF88A5E6;
  cor_fonte: Cardinal = $FFFFFFFF; duracao: integer = 5);
var
  FService: IFMXVirtualKeyboardService;
begin
  FMsg := msg;
  // Layout invisivel de fundo (nao clicavel)...
  LayoutToast := TLayout.Create(Frm);
  LayoutToast.Opacity := 1;
  LayoutToast.Parent := Frm;
  LayoutToast.Visible := true;
  LayoutToast.Align := TAlignLayout.Contents;
  LayoutToast.Visible := true;
  LayoutToast.HitTest := false;
  LayoutToast.BringToFront;

  // Fundo da mensagem...
  FundoToast := TRectangle.Create(Frm);
  FundoToast.Opacity := 0;
  FundoToast.Parent := LayoutToast;
  FundoToast.Height := 80;
  FundoToast.Width := 200;
  FundoToast.Align := alinhamento;
  FundoToast.Margins.Left := 20;
  FundoToast.Margins.Right := 20;
  FundoToast.Margins.Bottom := 20;
  FundoToast.Margins.Top := 20;
  FundoToast.Fill.Color := cor_fundo;
  FundoToast.Fill.Kind := TBrushKind.Solid;
  FundoToast.Stroke.Kind := TBrushKind.None;
  FundoToast.XRadius := 12;
  FundoToast.YRadius := 12;
  FundoToast.Visible := true;

  // Animacao...
  AnimacaoToast := TFloatAnimation.Create(Frm);
  AnimacaoToast.Parent := FundoToast;
  AnimacaoToast.StartValue := 0;
  AnimacaoToast.StopValue := 3;
  AnimacaoToast.Duration := duracao / 2;
  AnimacaoToast.Delay := 0;
  AnimacaoToast.AutoReverse := true;
  AnimacaoToast.PropertyName := 'Opacity';
  AnimacaoToast.AnimationType := TAnimationType.&In;
  AnimacaoToast.Interpolation := TInterpolationType.Linear;
  AnimacaoToast.OnFinish := TUtilsMessages.DeleteToast;

  // Label do texto...
  MensagemToast := TLabel.Create(Frm);
  MensagemToast.Parent := FundoToast;
  MensagemToast.Align := TAlignLayout.Client;
  MensagemToast.Font.Size := 13;
  MensagemToast.Font.Style := [fsBold];
  MensagemToast.FontColor := cor_fonte;
  MensagemToast.TextSettings.HorzAlign := TTextAlign.Center;
  MensagemToast.TextSettings.VertAlign := TTextAlign.Center;
  MensagemToast.StyledSettings := [TStyledSetting.Family];
  MensagemToast.Text := msg;
  MensagemToast.VertTextAlign := TTextAlign.Center;
  MensagemToast.Trimming := TTextTrimming.None;
  MensagemToast.TabStop := false;

  ButtonCopy := TSpeedButton.Create(Frm);
  ButtonCopy.Parent := FundoToast;
  ButtonCopy.Size.Height := 24;
  ButtonCopy.Size.Width := 24;
  ButtonCopy.HitTest := True;
  ButtonCopy.Hint := 'Copiar mensagem.';
  ButtonCopy.Position.X := FundoToast.Size.Width - 30;
  ButtonCopy.Position.Y := FundoToast.Size.Height - 30;
  ButtonCopy.StyleLookup := 'composetoolbutton';
  ButtonCopy.OnClick := ButtonCopyClick;

  // Esconde o teclado virtual...
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (FService <> nil) then
    FService.HideVirtualKeyboard;

  FService := nil;
  // Exibe os controles...
  AnimacaoToast.Enabled := true;
end;

end.
