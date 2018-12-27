unit uVideoFormsMgr;

interface

uses

    System.Generics.Collections,
    uSocketEntry, uVideoDisplayForm,
    iSocketService, iVideoFormsMgr;

type

    TVideoFormsMgr = class(TInterfacedObject, TIVideoFormsMgr)
    private
        _socketService: TISocketService;
    public
        constructor Create(socketService: TISocketService);
        procedure CreateVideoDisplays();
    end;

implementation

    constructor TVideoFormsMgr.Create(socketService: TISocketService);
    begin
        _socketService := socketService;
    end;

    procedure TVideoFormsMgr.CreateVideoDisplays;
    var
        allSockets: TObjectList<TSocketEntry>;
        socket: TSocketEntry;
        dummy: string;
        dummyFrm: TVidDisplayForm;
    begin
        allSockets := _socketService.GetAllSockets;
        for socket in allSockets do
        begin
            dummy := socket.Socket.BoundIP;
            dummyFrm := TVidDisplayForm.CreateNew(nil);
            socket.Socket.OnStatus := dummyFrm.SocketStatusEvent;
            dummyFrm.Show;
        end;
    end;

end.
