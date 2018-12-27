unit uVideoDisplayForm;

interface

uses
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdGlobal,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TVidDisplayForm = class(TForm)
    Image1: TImage;

    _socket: TIdTCPClient;    
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateNew(AOwner: TComponent; Socket: TIdTCPClient; Dummy: Integer = 0); overload;
    procedure SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure SocketConnectedEvent(Sender: TObject);
  end;

var
  VidDisplayForm: TVidDisplayForm;

implementation

{$R *.dfm}

    constructor TVidDisplayForm.CreateNew(AOwner: TComponent; Socket: TIdTCPClient; Dummy: Integer = 0);
    begin
        inherited CreateNew(AOwner, Dummy);

//        BorderIcons := [];
        BorderStyle := bsNone;

        _socket := Socket;
        _socket.OnStatus := SocketStatusEvent;
        _socket.OnConnected := SocketConnectedEvent;
    end;
    
    procedure TVidDisplayForm.SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    begin

    end;

    procedure TVidDisplayForm.SocketConnectedEvent(Sender: TObject);
    var
        buffer: TIdBytes;
    begin
        _socket.IOHandler.ReadBytes(buffer, 1);
    end;
    
end.
