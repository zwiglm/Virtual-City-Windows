unit uSocketEntry;

interface

uses

    Windows, MMSystem,
    System.SysUtils,
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdGlobal,
    uDataTypeHelper;

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

    TAV_PACKET_HDR = Record
	    tag: DWORD;
	    cType: DWORD;			    // video=0,audio=1
        //	psec: Word;			    // mSec per frame
	    len: LongInt;
	    timestamp: DWORD;
	    info: DWORD;			    // p.es. keyFrames=AVIIF_KEYFRAME=0x10
	    reserved1,reserved2: Word;	// usati come cnt per buffer Asyncroni
	    lpData: Pointer;    		// a volte i byte seguono la struct, a volte sono puntati da qua!
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
        function convertToBmpInfoHdr(bytes: array of byte) : TBitMapInfoHeader;
        function convertToAvPacketHeader(bytes: array of byte) : TAV_PACKET_HDR;
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
        streamInfo.versione := TDataTypeHelper.Bytes2Word(bytes[0], bytes[1]);

        // Bitmap
        SetLength(bmpArray, SizeOf(bmp));
        for I := 2 to (2 + SizeOf(bmp)) - 1 do
        begin
            bmpArray[I-2] := bytes[I];
        end;
        streamInfo.bm := convertTobmpInfoHdr(bmpArray);

        Result := streamInfo;
    end;

    function TSocketEntry.convertToBmpInfoHdr(bytes: array of byte) : TBitMapInfoHeader;
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
    begin
        bmpInfoHeader.biSize := TDataTypeHelper.Bytes2DWord(bytes[0], bytes[1], bytes[2], bytes[3]);

        bmpInfoHeader.biWidth := TDataTypeHelper.Bytes2LongInt(bytes[4], bytes[5], bytes[6], bytes[7]);
        bmpInfoHeader.biHeight := TDataTypeHelper.Bytes2LongInt(bytes[8], bytes[9], bytes[10], bytes[11]);

        bmpInfoHeader.biPlanes := TDataTypeHelper.Bytes2Word(bytes[12], bytes[13]);
        bmpInfoHeader.biBitCount := TDataTypeHelper.Bytes2Word(bytes[14], bytes[15]);

        Result := bmpInfoHeader;
    end;


    function TSocketEntry.convertToAvPacketHeader(bytes: array of byte) : TAV_PACKET_HDR;
    var
     tmpResult: TAV_PACKET_HDR;

     tmpPointer: Pointer;
    begin
        tmpResult.tag := TDataTypeHelper.Bytes2DWord(bytes[0], bytes[1], bytes[2], bytes[3]);
        tmpResult.cType := TDataTypeHelper.Bytes2DWord(bytes[4], bytes[5], bytes[6], bytes[7]);
        tmpResult.len := TDataTypeHelper.Bytes2LongInt(bytes[8], bytes[9], bytes[10], bytes[11]);
        tmpResult.timestamp := TDataTypeHelper.Bytes2DWord(bytes[12], bytes[13], bytes[14], bytes[15]);
        tmpResult.info := TDataTypeHelper.Bytes2DWord(bytes[16], bytes[17], bytes[18], bytes[19]);

        tmpResult.reserved1 := TDataTypeHelper.Bytes2Word(bytes[20], bytes[21]);
        tmpResult.reserved2 := TDataTypeHelper.Bytes2Word(bytes[22], bytes[23]);

        Move(bytes[24], tmpPointer, SizeOf(tmpPointer));
        tmpResult.lpData := tmpPointer;

        Result := tmpResult;
    end;

end.
