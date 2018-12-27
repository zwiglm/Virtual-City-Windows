unit uVideoDisplayForm;

interface

uses
    IdBaseComponent, IdComponent,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TVidDisplayForm = class(TForm)
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    procedure SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
  end;

var
  VidDisplayForm: TVidDisplayForm;

implementation

{$R *.dfm}

    constructor TVidDisplayForm.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
    begin
        inherited;

//        BorderIcons := [];
        BorderStyle := bsNone;
    end;
    
    procedure TVidDisplayForm.SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    begin

    end;

end.
