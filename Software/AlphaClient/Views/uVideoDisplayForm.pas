unit uVideoDisplayForm;

interface

uses
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdGlobal,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
    uSocketEntry;

type
  TVidDisplayForm = class(TForm)
    Image1: TImage;

    _socket: TSocketEntry;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateNew(AOwner: TComponent; Socket: TSocketEntry; Dummy: Integer = 0); overload;

    // Control-Socket
    procedure SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure SocketConnectedEvent(Sender: TObject);
    // Video-Socket
    procedure VideoStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure VideoConnectedEvent(Sender: TObject);
  end;

var
  VidDisplayForm: TVidDisplayForm;

implementation

{$R *.dfm}

    constructor TVidDisplayForm.CreateNew(AOwner: TComponent; Socket: TSocketEntry; Dummy: Integer = 0);
    begin
        inherited CreateNew(AOwner, Dummy);

//        BorderIcons := [];
        BorderStyle := bsNone;

        _socket := Socket;
        _socket.Socket.OnStatus := SocketStatusEvent;
        _socket.Socket.OnConnected := SocketConnectedEvent;
    end;


    procedure TVidDisplayForm.SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    begin

    end;

    procedure TVidDisplayForm.SocketConnectedEvent(Sender: TObject);
    var
        bufFirst: TIdBytes;
        bufStreamInfo: TIdBytes;
        rStreamInfo: TSTREAM_INFO;

        cnt1, cnt2, cnt3: Integer;
    begin
        { TODO 5 -oMaZ -cDebug : remove debug }
        cnt1 := SizeOf(rStreamInfo);
        cnt2 := SizeOf(rStreamInfo.bm);
        cnt3 := SizeOf(rStreamInfo.wf);

        _socket.Socket.IOHandler.ReadBytes(bufFirst, 1);
        _socket.Socket.IOHandler.ReadBytes(bufStreamInfo, SizeOf(rStreamInfo));

        rStreamInfo := _socket.convertToStreamInfo(bufStreamInfo);
    end;


    procedure TVidDisplayForm.VideoStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    begin

    end;

    procedure TVidDisplayForm.VideoConnectedEvent(Sender: TObject);
    begin
    end;


end.
