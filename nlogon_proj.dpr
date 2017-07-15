program nlogon_proj;

uses
  Forms,
  nlogon in 'nlogon.pas' {logon};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Logowanie';
  Application.CreateForm(Tlogon, logon);
  Application.Run;
end.
