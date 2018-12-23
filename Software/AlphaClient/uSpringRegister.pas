unit uSpringRegister;

interface

uses
    Spring.Container;

    procedure RegisterContainer(aContainer: TContainer);

implementation

uses

    iConfigService, uConfigService,
    iSocketService, uSocketService;


    procedure RegisterContainer(aContainer: TContainer);
    begin
        aContainer.RegisterType<TIConfigService, TConfigService>.AsSingleton;
        aContainer.RegisterType<TISocketService, TSocketService>.AsSingleton;

        // MaZ attn: HAVE to build
        aContainer.Build;
    end;

end.
