unit uGlobalConsts;

interface

type

    TGlobalConsts = class
    const
        // Debug
        DBG_RECEIVE_BYTES: Integer = 594;

        //
        SETTING_FILE_NAME: string = 'settings.json';

        // Settings
        SERVER_IP_ADDR: string = 'ipAddr';
        SERVER_NAME: string = 'name';

        // Errors
        NO_ERROR: Integer = 0;

        AV_PACKET_ALLOC_ERR: Integer = 1001;
        AV_FIND_DECODER_ERR: Integer = 1002;
        AV_PARSER_INIT_ERR: Integer = 1003;
        AV_CONTEXT_ALLOC_ERR: Integer = 1004;
        AV_OPEN_CODEC_ERR: Integer = 1005;
        AV_FRAME_ALLOC_ERR: Integer = 1006;

        // Sockets
        MASTER_TIMER_INTERVAL: Integer = (1000 * 60 * 5);
        FORM_TIMER_INTERVAL: Integer = (1000 * 15);
        CONTROL_SOCKET: Integer = 7600;
        TEXT_SOCKET: Integer = 7601;
        VIDEO_SOCKET: Integer = 7602;
        AUDIO_SOCKET: Integer = 7603;
    end;

implementation

end.
