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
  uSocketService in 'Services\uSocketService.pas',
  uSocketEntry in 'Domain\uSocketEntry.pas',
  iVideoFormsMgr in 'Interfaces\iVideoFormsMgr.pas',
  uVideoFormsMgr in 'Services\uVideoFormsMgr.pas',
  uVideoDisplayForm in 'Views\uVideoDisplayForm.pas' {VidDisplayForm},
  uDataTypeHelper in 'Helpers\uDataTypeHelper.pas';

var
    Container: TContainer;
//    _socketService: TISocketService;
    _vidFrmsMgr: TIVideoFormsMgr;

{$R *.res}

begin

    try

        // Register Container here
        Container := TContainer.Create;
        try
            RegisterContainer(Container);
//            _socketService := Container.Resolve<TISocketService>;
//            _socketService.CreateSockets;
            _vidFrmsMgr := Container.Resolve<TIVideoFormsMgr>;
            _vidFrmsMgr.CreateVideoDisplays;

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
