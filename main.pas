unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, Menus, StdCtrls;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    pmeStart: TMenuItem;
    PopupMenu1: TPopupMenu;
    ProgressBar1: TProgressBar;
    tmrPomo: TTimer;
    TrayIcon1: TTrayIcon;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure pmeStartClick(Sender: TObject);
    procedure tmrPomoTimer(Sender: TObject);
  private
    var
      time: integer;
      frmClose: boolean;
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.tmrPomoTimer(Sender: TObject);
begin
     ProgressBar1.Position:= ProgressBar1.Position - 1;
     Label1.Caption:= IntToStr(ProgressBar1.Position);
     if (ProgressBar1.Position=time-5) then
     begin
          frmMain.Close;
     end;
     if (ProgressBar1.Position<=0) then
     begin
       tmrPomo.Enabled:= False;
       ShowMessage('terminou o pomo');
     end;

end;

procedure TfrmMain.pmeStartClick(Sender: TObject);
begin
     frmMain.Show;
     ProgressBar1.Max:= time;
     ProgressBar1.Position:= time;
     tmrPomo.Enabled:= true;
end;

procedure TfrmMain.MenuItem1Click(Sender: TObject);
begin
  tmrPomo.Enabled:= False;

end;

procedure TfrmMain.MenuItem2Click(Sender: TObject);
var
  s:String;

begin
  InputQuery('Time pomodoro', 'Time in Sec', s);
  time := StrToInt(s);
end;

procedure TfrmMain.MenuItem3Click(Sender: TObject);
begin
  frmClose := True;
  frmMain.Close;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  time := 3600;
  tmrPomo.Enabled:= False;
  frmClose := False;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if frmClose then
  begin
    CloseAction:= caFree;
  end else begin
    CloseAction:= caHide;
  end;
end;

end.

