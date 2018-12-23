unit uConfigService;

interface

uses

    System.Classes, System.Generics.Collections, System.IOUtils, System.JSON.Readers, System.JSON.Types,
    uGlobalConsts,
    uServerEntry,
    iConfigService;

type

    TServers = TObjectList<TServerEntry>;

    TConfigService = class(TInterfacedObject, TIConfigService)
    private
        _servers : TServers;
        procedure initConfig();
        procedure processServerToken(jtr: TJsonTextReader);
    public
        constructor Create;
        function GetServers() : TObjectList<TServerEntry>;
        destructor Free;
    end;


implementation

    constructor TConfigService.Create;
    begin
        _servers := TServers.Create();
        initConfig();
    end;

    function TConfigService.GetServers() : TObjectList<TServerEntry>;
    begin
        Result := _servers;
    end;

    destructor TConfigService.Free;
    begin
        _servers.Free;
    end;


    procedure TConfigService.initConfig();
    var
        configFileContent: String;
        stringReader: TStringReader;
        jsonReader: TJsonTextReader;
    begin

        configFileContent := TFile.ReadAllText(TGlobalConsts.SETTING_FILE_NAME);

        stringReader := TStringReader.Create(configFileContent);
        try
            jsonReader := TJsonTextReader.Create(stringReader);
            try
                while jsonReader.Read do
                begin
                    if jsonReader.TokenType = TJsonToken.StartObject then
                        processServerToken(jsonReader);
                end;
            finally
                jsonReader.Free;
            end;
        finally
            stringReader.Free;
        end;

    end;

    procedure TConfigService.processServerToken(jtr: TJsonTextReader);
    var
        server: TServerEntry;
    begin
        server := TServerEntry.Create;

        while jtr.Read do
        begin
            if jtr.TokenType = TJsonToken.PropertyName then
            begin
              if jtr.Value.ToString = TGlobalConsts.SERVER_IP_ADDR then
              begin
                jtr.Read;
                server.IpAddr := jtr.Value.AsString;
              end

              else if jtr.Value.ToString = TGlobalConsts.SERVER_NAME then
              begin
                jtr.Read;
                server.Name := jtr.Value.AsString;
              end
            end

            else if jtr.TokenType = TJsonToken.EndObject then
            begin
              _servers.Add(server);
              Break;
            end;
        end;
    end;

end.
