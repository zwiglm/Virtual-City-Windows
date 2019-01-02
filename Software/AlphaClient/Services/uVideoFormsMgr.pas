unit uVideoFormsMgr;

interface

uses

    System.Generics.Collections, System.SysUtils,
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
        exceptionMsg: string;

        displayForm: TVidDisplayForm;
    begin
        allSockets := _socketService.GetAllSockets;
        for socket in allSockets do
        begin
            displayForm := TVidDisplayForm.CreateNew(nil, socket);

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
