program AlphaClient;

uses
  Vcl.Forms,
  System.SysUtils,
  System.Generics.Collections,
  MainForm in 'MainForm.pas' {FrmMain},
  uSpringRegister in 'uSpringRegister.pas',
  Spring.Container,
  iConfigService in 'Interfaces\iConfigService.pas',
  uServerEntry in 'Domain\uServerEntry.pas',
  uConfigService in 'Services\uConfigService.pas',
  uGlobalConsts in 'Domain\uGlobalConsts.pas',
  iSocketService in 'Interfaces\iSocketService.pas',
  uSocketService in 'Services\uSocketService.pas';

var
    Container: TContainer;
    _socketService: TISocketService;

{$R *.res}

begin

    try

        // Register Container here
        Container := TContainer.Create;
        try
            RegisterContainer(Container);

            _socketService := Container.Resolve<TISocketService>;
            _socketService.CreateSockets;


            Application.Initialize;
            Application.MainFormOnTaskbar := True;
            Application.CreateForm(TFrmMain, FrmMain);
            Application.Run;
        finally
            Container.Free;
        end;

    except on E: Exception do
        Writeln(E.Classname, ': ', E.Message);
    end;

end.
