unit uSocketEntry;

interface

uses

    Windows, MMSystem,
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type

    TEXT_WAVEFORMATEX = Record
        wf: TWAVEFORMATEX;
	    extra: Array [0..64] of Byte;
    End;

    TSTREAM_INFO = Record
        versione: UInt16;
        bm: TBITMAPINFOHEADER;	                // videoformat
        fps: Uint32;
        quality: Uint32;
        wf: TEXT_WAVEFORMATEX;	                // audioformat
        noBuffers: Boolean;	                    // server says don't buffer because transmission may be discontinous
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
    end;

implementation

    constructor TSocketEntry.Create(ctrlSocket: TIdTCPClient; vidSocket: TIdTCPClient; audSocket: TIdTCPClient);
    begin
        vSocket := ctrlSocket;
        vVidSocket := vidSocket;
        vAudSocket := audSocket;
    end;


end.
