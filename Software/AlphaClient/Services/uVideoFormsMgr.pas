unit uVideoFormsMgr;

interface

uses

    System.Generics.Collections, System.SysUtils,
    uSocketEntry, uVideoDisplayForm,
    iSocketService, iVideoDecoder, iVideoFormsMgr;

type

    TVideoFormsMgr = class(TInterfacedObject, TIVideoFormsMgr)
    private
        _socketService: TISocketService;
        _videoDecoder: TIVideoDecoder;
    public
        constructor Create(socketService: TISocketService; videoDecoder: TIVideoDecoder);
        procedure CreateVideoDisplays();
    end;

implementation

    constructor TVideoFormsMgr.Create(socketService: TISocketService; videoDecoder: TIVideoDecoder);
    begin
        _socketService := socketService;
        _videoDecoder := videoDecoder;
    end;

    procedure TVideoFormsMgr.CreateVideoDisplays;
    var
        allSockets: TObjectList<TSocketEntry>;
        socket: TSocketEntry;
        exceptionMsg: string;

        displayForm: TVidDisplayForm;
    begin
        allSockets := _socketService.GetAllSockets;
        for socket in allSockets do
        begin
            displayForm := TVidDisplayForm.CreateNew(nil, socket, _videoDecoder);

            try
                socket.Socket.Connect;
            except on E: Exception do
                { TODO 3 -oMaZ -cErro Handling : Show some message on screen }
                exceptionMsg := E.Message;
            end;

            displayForm.Show;
        end;
    end;

end.
