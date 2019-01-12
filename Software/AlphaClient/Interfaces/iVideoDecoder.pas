unit iVideoDecoder;

interface

uses

    System.Generics.Collections;

type

    TIVideoDecoder = interface
    ['{ED724F3E-C079-4B8D-A2FD-606E26B44D6C}']
        function DecodeBytes(encodedContent: array of byte; dataSize: LongInt) : Integer;
    end;


implementation

end.
