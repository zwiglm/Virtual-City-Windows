unit uSocketEntry;

interface

uses

    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type

    TSocketEntry = class
    private
      vIpOrName: String;
      vSocket: TIdTCPClient;
    public
      property IpOrName: String read vIpOrName write vIpOrName;
      property Socket: TIdTCPClient read vSocket;

      constructor Create(socket: TIdTCPClient);
    end;

implementation

    constructor TSocketEntry.Create(socket: TIdTCPClient);
    begin
        vSocket := socket;
    end;


end.
