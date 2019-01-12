unit uSpringRegister;

interface

uses
    Spring.Container;

    procedure RegisterGlobally;

implementation

uses

    iConfigService, uConfigService,
    iSocketService, uSocketService,
    iVideoFormsMgr, uVideoFormsMgr,
    iVideoDecoder, uVideoDecoder;


    procedure RegisterGlobally();
    begin
        GlobalContainer.RegisterType<TIConfigService, TConfigService>.AsSingleton;
        GlobalContainer.RegisterType<TISocketService, TSocketService>.AsSingleton;
        GlobalContainer.RegisterType<TIVideoFormsMgr, TVideoFormsMgr>.AsSingleton;
        GlobalContainer.RegisterType<TIVideoDecoder, TVideoDecoder>;

        // MaZ attn: HAVE to build
        GlobalContainer.Build;
    end;

end.
