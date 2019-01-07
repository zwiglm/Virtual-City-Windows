unit uDataTypeHelper;

interface

uses

    System.SysUtils, Windows;

type

    TDataTypeHelper = class
    public
        class function Bytes2Word(first, second: Byte): Word;
        class function Bytes2DWord(first, second, third, fourth: Byte): DWord;

        class function Bytes2LongInt(first, second, third, fourth: Byte): LongInt;  Overload;
        class function Bytes2LongInt(bytes: array of Byte) : LongInt;  Overload;
    end;

implementation

    class function TDataTypeHelper.Bytes2Word(first, second: Byte) : Word;
    var
        tempResult: Word;
    begin
        WordRec(tempResult).Lo := first;
        WordRec(tempResult).Hi := second;
        Result := tempResult;
    end;

    class function TDataTypeHelper.Bytes2DWord(first, second, third, fourth: Byte): DWORD;
    var
        tmpWord1, tmpWord2: Word;
        tmpDWord: DWord;
    begin
        WordRec(tmpWord1).Lo := first;
        WordRec(tmpWord1).Hi := second;
        WordRec(tmpWord2).Lo := third;
        WordRec(tmpWord2).Hi := fourth;

        LongRec(tmpDWord).Lo := tmpWord1;
        LongRec(tmpDWord).Hi := tmpWord2;

        Result := tmpDWord;
    end;

    class function TDataTypeHelper.Bytes2LongInt(first: Byte; second: Byte; third: Byte; fourth: Byte) : LongInt;
    var
        tmpBytes: array [0..3] of Byte;
        tmpLongInt: LongInt;
    begin
        tmpBytes[0] := first;
        tmpBytes[1] := second;
        tmpBytes[2] := third;
        tmpBytes[3] := fourth;

        Move(tmpBytes[0], tmpLongInt, SizeOf(tmpLongInt));

        Result := tmpLongInt;
    end;

    class function TDataTypeHelper.Bytes2LongInt(bytes: array of Byte) : LongInt;
    var
        tmpLongInt: LongInt;
    begin
        Move(bytes[0], tmpLongInt, SizeOf(tmpLongInt));
        Result := tmpLongInt;
    end;


end.
