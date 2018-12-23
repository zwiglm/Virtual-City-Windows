unit uSocketService;

interface

uses

    System.Generics.Collections,
    iSocketService, iConfigService,
    uServerEntry;

type

    TSocketService = class(TInterfacedObject, TISocketService)
    private
        _configService: TIConfigService;
    public
        constructor Create(configService: TIConfigService);
        procedure CreateSockets();
    end;


implementation

    constructor TSocketService.Create(configService: TIConfigService);
    begin
        _configService := configService;
    end;

    procedure TSocketService.CreateSockets();
    var
        servers: TObjectList<TServerEntry>;
        serverEntry: TServerEntry;
        serverName: string;
    begin
        servers := _configService.GetServers;
        for serverEntry in servers do
        begin
            serverName := serverEntry.Name;
        end;
    end;

end.
