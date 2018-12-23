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
  uGlobalConsts in 'Domain\uGlobalConsts.pas';

var
    Container: TContainer;

    // only debug now
//    settings: TConfigService;
//    servers: TObjectList<TServerEntry>;
//    server: TServerEntry;
//    name: string;

{$R *.res}

begin

    try

        // Register Container here
        Container := TContainer.Create;
        try
            RegisterContainer(Container);

            // only debug now
//            settings := TConfigService.Create;
//            servers := settings.GetServers;
//            for server in servers do
//            begin
//                name := server.Name;
//            end;
//            settings.Free;


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
