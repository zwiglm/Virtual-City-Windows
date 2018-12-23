unit uServerEntry;

interface

type

    TServerEntry = class
    private
      vIpAddr: String;
      vName: String;
    public
      property IpAddr: String read vIpAddr write vIpAddr;
      property Name: String read vName write vName;
    end;

implementation

end.