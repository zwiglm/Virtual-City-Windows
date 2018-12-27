unit uVideoDisplayForm;

interface

uses

    Vcl.Forms,
    IdBaseComponent, IdComponent;

type

    TVideoDisplayForm = class(TForm)
    private
        { Private declarations }
    public
        { Public declarations }
        procedure SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    end;

implementation

    procedure TVideoDisplayForm.SocketStatusEvent(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    begin

    end;

end.
