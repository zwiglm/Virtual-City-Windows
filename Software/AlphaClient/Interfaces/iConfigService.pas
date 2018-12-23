unit iConfigService;

interface

uses

    System.Generics.Collections,
    uServerEntry;

type

    TIConfigService = interface
    ['{B27818C5-AAED-456C-A7FB-8DA5DA09C807}']
        function GetServers() : TObjectList<TServerEntry>;
    end;


implementation

end.
