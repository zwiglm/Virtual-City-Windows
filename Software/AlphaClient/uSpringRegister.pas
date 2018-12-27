unit uSpringRegister;

interface

uses
    Spring.Container;

    procedure RegisterContainer(aContainer: TContainer);

implementation

uses

    iConfigService, uConfigService,
    iSocketService, uSocketService,
    iVideoFormsMgr, uVideoFormsMgr;


    procedure RegisterContainer(aContainer: TContainer);
    begin
        aContainer.RegisterType<TIConfigService, TConfigService>.AsSingleton;
        aContainer.RegisterType<TISocketService, TSocketService>.AsSingleton;
        aContainer.RegisterType<TIVideoFormsMgr, TVideoFormsMgr>.AsSingleton;

        // MaZ attn: HAVE to build
        aContainer.Build;
    end;

end.
