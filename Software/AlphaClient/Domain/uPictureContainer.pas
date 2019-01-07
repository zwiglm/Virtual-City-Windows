unit uPictureContainer;

interface

uses

    Vcl.Graphics;

type

    TPictureContainer = class
    private
        vError: Integer;
        vPicture: TPicture;
    public
        property Error: Integer read vError write vError;
        property Picture: TPicture read vPicture write vPicture;
    end;


implementation

end.
