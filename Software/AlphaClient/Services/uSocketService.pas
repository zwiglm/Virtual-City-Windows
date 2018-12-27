unit uSocketService;

interface

uses

    Vcl.ExtCtrls,
    System.Generics.Collections, System.SysUtils,
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdIOHandlerSocket,
    iSocketService, iConfigService,
    uGlobalConsts, uServerEntry, uSocketEntry;

type

    TSockets = TObjectList<TSocketEntry>;

    TSocketService = class(TInterfacedObject, TISocketService)
    private
        _configService: TIConfigService;
        _allSockets: TSockets;
        function createIndySocket(ipOrName: string) : TSocketEntry;
    public
        constructor Create(configService: TIConfigService);
        function GetAllSockets() : TObjectList<TSocketEntry>;
        procedure CreateSockets();

        procedure CreateMasterTimer();
        procedure OnMasterTimerEvent(Sender: TObject);
    end;


implementation

    constructor TSocketService.Create(configService: TIConfigService);
    begin
        _configService := configService;
        _allSockets := TSockets.Create();

        CreateMasterTimer;
        CreateSockets;
    end;

    procedure TSocketService.OnMasterTimerEvent(Sender: TObject);
    begin
        // MaZ todo: check for live connection
    end;

    procedure TSocketService.CreateMasterTimer;
    var
        timer: TTimer;
    begin
        timer := TTimer.Create(nil);
        timer.Interval := TGlobalConsts.MASTER_TIMER_INTERVAL;
        timer.OnTimer := OnMasterTimerEvent;
    end;


    procedure TSocketService.CreateSockets();
    var
        servers: TObjectList<TServerEntry>;
        serverEntry: TServerEntry;
        serverIpOrName: string;
        socketEntry: TSocketEntry;
    begin
        servers := _configService.GetServers;
        for serverEntry in servers do
        begin
            serverIpOrName := serverEntry.IpAddr;
            socketEntry := createIndySocket(serverIpOrName);
            _allSockets.Add(socketEntry);
        end;
    end;


    function TSocketService.GetAllSockets() : TObjectList<TSocketEntry>;
    begin
        Result := _allSockets;        
    end;
    

    /// -------------------------------------------
    ///    private

    function TSocketService.createIndySocket(ipOrName: string) : TSocketEntry;
    var
        socket: TIdTCPClient;
    begin
        socket := TIdTCPClient.Create(nil);
        socket.Host := ipOrName;
        socket.Port := TGlobalConsts.CONTROL_SOCKET;

        Result := TSocketEntry.Create(socket);
    end;

end.
