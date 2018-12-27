unit uSocketEntry;

interface

uses

    Windows,
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type

    STREAM_INFO = Record
        versione: Word;
        bm: TBITMAPINFOHEADER;	// videoformat
        fps: Uint32;
        quality: LongWord;
//        wf: EXT_WAVEFORMATEX;	// audioformat
        noBuffers: Boolean;	                    // server says don't buffer because transmission may be discontinous
//        maxTime: CTimeSpan;
        authenticationWWW: Array [0..127] of char;	//a site for authentication
        IDServer: LongWord;	                    // ID of server-user, for listing in the users' database
        dontSave: Byte;	                        // not allowed to save video
        remoteCtrl: Byte;	                    // for remote control
        openWWW: Array [0..127] of char;	    // opens a webpage along with connection (advertising or else)
        splashOrIntro: Array [0..127] of char;  // a splash screen to be shown before video starts
        streamTitle: Array [0..63] of char;	    // transmission title
    End;

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
