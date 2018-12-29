unit uSocketEntry;

interface

uses

    Windows, MMSystem,
    System.SysUtils,
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdGlobal;

type

    TEXT_WAVEFORMATEX = Record
        wf: TWaveFormatEx;
	    extra: Array [0..63] of Byte;
    End;

    TSTREAM_INFO = Record
        versione: UInt16;
        bm: TBitMapInfoHeader;	                // videoformat
        fps: Uint32;
        quality: Uint32;
        wf: TEXT_WAVEFORMATEX;	                // audioformat
        noBuffers: bool;	                    // server says don't buffer because transmission may be discontinous
        maxTime: Array [0..3] of Byte;          // MaZ attn: doing tricks here
        authenticationWWW: Array [0..127] of Byte;	//a site for authentication
        IDServer: Uint32;	                    // ID of server-user, for listing in the users' database
        dontSave: Byte;	                        // not allowed to save video
        remoteCtrl: Byte;	                    // for remote control
        openWWW: Array [0..127] of Byte;	    // opens a webpage along with connection (advertising or else)
        splashOrIntro: Array [0..127] of Byte;  // a splash screen to be shown before video starts
        streamTitle: Array [0..63] of Byte;	    // transmission title
    End;

    TSocketEntry = class
    private
        vIpOrName: String;
        vSocket: TIdTCPClient;
        vVidSocket: TidTCPClient;
        vAudSocket: TidTCPClient;
    public
        RStreamInfo: TSTREAM_INFO;
        property IpOrName: String read vIpOrName write vIpOrName;
        property Socket: TIdTCPClient read vSocket;
        property VideoSocket: TIdTCPClient read vVidSocket;
        property AudioSocket: TIdTCPClient read vAudSocket;

        constructor Create(ctrlSocket: TIdTCPClient; vidSocket: TIdTCPClient; audSocket: TIdTCPClient);

        function convertToStreamInfo(bytes: TIdBytes) : TSTREAM_INFO;
        function convertTobmpInfoHdr(bytes: array of byte) : TBitMapInfoHeader;
    end;

implementation

    constructor TSocketEntry.Create(ctrlSocket: TIdTCPClient; vidSocket: TIdTCPClient; audSocket: TIdTCPClient);
    begin
        vSocket := ctrlSocket;
        vVidSocket := vidSocket;
        vAudSocket := audSocket;
    end;


    function TSocketEntry.convertToStreamInfo(bytes: TIdBytes) : TSTREAM_INFO;
    var
        streamInfo: TSTREAM_INFO;

        version: Uint16;
        bmpArray: array of byte;
        bmp: TBitmapInfoHeader;
  I: Integer;
    begin
        // Version
        WordRec(version).Lo := bytes[0];
        WordRec(version).Hi := bytes[1];
        streamInfo.versione := version;

        // Bitmap
        SetLength(bmpArray, SizeOf(bmp));
        for I := 2 to (2 + SizeOf(bmp)) - 1 do
        begin
            bmpArray[I-2] := bytes[I];
        end;
        streamInfo.bm := convertTobmpInfoHdr(bmpArray);

        Result := streamInfo;
    end;

    function TSocketEntry.convertTobmpInfoHdr(bytes: array of byte) : TBitMapInfoHeader;
    var
        bmpInfoHeader: TBitmapInfoHeader;

        biSize: DWORD;
        biWidth: Longint;
        biHeight: Longint;
        biPlanes: Word;
        biBitCount: Word;
        biCompression: DWORD;
        biSizeImage: DWORD;
        biXPelsPerMeter: Longint;
        biYPelsPerMeter: Longint;
        biClrUsed: DWORD;
        biClrImportant: DWORD;

        dum01, dum02: Word;
    begin
        WordRec(dum01).Lo := bytes[0];
        WordRec(dum01).Hi := bytes[1];
        WordRec(dum02).Lo := bytes[2];
        WordRec(dum02).Hi := bytes[3];
        LongRec(biSize).Hi := dum01;
        LongRec(biSize).Lo := dum02;
        bmpInfoHeader.biSize := biSize;

        Result := bmpInfoHeader;
    end;

end.
