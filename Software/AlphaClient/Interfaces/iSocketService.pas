unit iSocketService;

interface

uses

    System.Generics.Collections,
    uSocketEntry;

type

    TISocketService = interface
    ['{FE8C3506-EBE1-4BF1-9E1F-E91177A32A25}']
        procedure CreateSockets;
    ['{4FBE9E55-D5D2-4516-9A3F-2FAAB5EF06F8}']
        function GetAllSockets() : TObjectList<TSocketEntry>;
    end;


implementation

end.
