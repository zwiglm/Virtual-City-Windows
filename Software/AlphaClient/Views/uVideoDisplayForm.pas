unit uVideoDisplayForm;

interface

uses
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdGlobal,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
    uSocketEntry, uGlobalConsts;

type
  TVidDisplayForm = class(TForm)
    Image1: TImage;
    FrmTimer: TTimer;

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
    // Timer
    procedure OnFormTimerEvent(Sender: TObject);
  end;

var
    VidDisplayForm: TVidDisplayForm;
    _rStreamInfo: TSTREAM_INFO;

implementation

{$R *.dfm}


    constructor TVidDisplayForm.CreateNew(AOwner: TComponent; Socket: TSocketEntry; Dummy: Integer = 0);
    begin
        inherited CreateNew(AOwner, Dummy);

        BorderStyle := bsNone;

        // Form-Timer for eg. Heartbeat
        FrmTimer := TTimer.Create(nil);
        FrmTimer.Interval := TGlobalConsts.FORM_TIMER_INTERVAL;
        FrmTimer.OnTimer := OnFormTimerEvent;

        // SocketEntry
        _socket := Socket;
        // Control-Socket
        _socket.Socket.OnStatus := SocketStatusEvent;
        _socket.Socket.OnConnected := SocketConnectedEvent;
        // Video-Socket
        _socket.VideoSocket.OnStatus := VideoStatusEvent;
        _socket.VideoSocket.OnConnected := VideoConnectedEvent;
    end;


    procedure TVidDisplayForm.OnFormTimerEvent(Sender: TObject);
    begin

        // MaZ attn: Heartbeat
        if (_socket.Socket.Connected) then
        begin
            _socket.Socket.IOHandler.Write(3);
        end;

    end;


    procedure TVidDisplayForm.SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    begin

    end;

    procedure TVidDisplayForm.SocketConnectedEvent(Sender: TObject);
    var
        bufFirst: TIdBytes;
        bufStreamInfo: TIdBytes;

        exceptionMsg: string;

        cnt1, cnt2, cnt3: Integer;
    begin
        { TODO 5 -oMaZ -cDebug : remove debug }
        cnt1 := SizeOf(_rStreamInfo);
        cnt2 := SizeOf(_rStreamInfo.bm);
        cnt3 := SizeOf(_rStreamInfo.wf);

        _socket.Socket.IOHandler.ReadBytes(bufFirst, 1);
        // MaZ attn: why are we still different in size from server....?
//        _socket.Socket.IOHandler.ReadBytes(bufStreamInfo, SizeOf(rStreamInfo));
        _socket.Socket.IOHandler.ReadBytes(bufStreamInfo, TGlobalConsts.DBG_RECEIVE_BYTES);

        _rStreamInfo := _socket.convertToStreamInfo(bufStreamInfo);
        // if biSize < 0 then somehow open socket to video-server-socket
        if (_rStreamInfo.bm.biSize >0) then
        begin
            try
                _socket.VideoSocket.Connect;
            except on E: Exception do
                { TODO 3 -oMaZ -cErro Handling : Show some message on screen }
                exceptionMsg := E.Message;
            end;
        end;
    end;


    procedure TVidDisplayForm.VideoStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    begin

    end;

    procedure TVidDisplayForm.VideoConnectedEvent(Sender: TObject);
    var
        bufPacketHeader: TIdBytes;
        avPacketHeader: TAV_PACKET_HDR;

        bufFrameData: TIdBytes;
    begin
        while _socket.VideoSocket.Connected do
        begin

            _socket.VideoSocket.IOHandler.ReadBytes(bufPacketHeader, Sizeof(avPacketHeader), false);
            avPacketHeader := _socket.convertToAvPacketHeader(bufPacketHeader);

            _socket.VideoSocket.IOHandler.ReadBytes(bufFrameData, avPacketHeader.len, false);

            _socket.VideoSocket.IOHandler.Write(0);
        end;
    end;


end.
