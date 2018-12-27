unit uVideoDisplayForm;

interface

uses
    IdBaseComponent, IdComponent,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TVidDisplayForm = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }

    procedure SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
  end;

var
  VidDisplayForm: TVidDisplayForm;

implementation

{$R *.dfm}

    procedure TVidDisplayForm.SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    begin

    end;

end.
