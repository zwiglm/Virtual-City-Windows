unit uSpringRegister;

interface

uses
    Spring.Container;

    procedure RegisterContainer(aContainer: TContainer);

implementation

uses

    iConfigService, uConfigService;


    procedure RegisterContainer(aContainer: TContainer);
    begin
        aContainer.RegisterType<TConfigService>.Implements<TIConfigService>.AsSingleton();
    end;

end.
