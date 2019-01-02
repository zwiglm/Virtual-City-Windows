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
