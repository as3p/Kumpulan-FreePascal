


// https://indy.fulgan.com/SSL/
// http://www.ararat.cz/synapse/doku.php/download
//http://www.ararat.cz/synapse/lib/exe/fetch.php/file:synapse40.zip
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, httpsend, ssl_openssl;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function SynapseDownload(URL: string; SaveToFile: boolean=False;
      TargetFile: string=''): string;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}




procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   Memo1.clear  ;
   Memo1.Text := SynapseDownload(Edit1.Text);
end;



function TForm1.SynapseDownload(URL: string; SaveToFile: boolean=False; TargetFile: string=''): string;
var
 HTTPGetResult: Boolean;
 HTTPSender: THTTPSend;
 S: string;
begin
 // Result will be:
 // - empty ('') when it has failed
 // - filename when the file has been downloaded successfully
 // - content when the content SaveToFile is set to False
 Result := '';
 HTTPSender := THTTPSend.Create;

 try
   HTTPGetResult := HTTPSender.HTTPMethod('GET', URL);
   if (HTTPSender.ResultCode >= 100) and (HTTPSender.ResultCode<=299) then begin
     if SaveToFile = true then begin
       HTTPSender.Document.SaveToFile(TargetFile);
       Result := TargetFile;
     end else begin
       SetLength(S, HTTPSender.Document.Size);
       HTTPSender.Document.Read(S[1], Length(S));
       Result:=S;
     end;
   end;

 finally
   HTTPSender.Free;

 end;

end;

end.


