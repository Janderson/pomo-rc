unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, Menus, StdCtrls, IniPropStorage;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    IniPropStorage1: TIniPropStorage;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    menMostrar: TMenuItem;
    pmeStart: TMenuItem;
    PopupMenu1: TPopupMenu;
    ProgressBar1: TProgressBar;
    tmrPomo: TTimer;
    TrayIcon1: TTrayIcon;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menMostrarClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure pmeStartClick(Sender: TObject);
    procedure tmrPomoTimer(Sender: TObject);
  private
    var
      intTimeSec: integer;
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
     Label1.Caption:= IntToStr(ProgressBar1.Position div 60) + ':' + IntToStr(ProgressBar1.Position mod 60);
     if (ProgressBar1.Position=intTimeSec-5) then
     begin
          frmMain.Close;
     end;
     if (ProgressBar1.Position<=0) then
     begin
       tmrPomo.Enabled:= False;
       Label1.Caption:= 'Fim';
       TrayIcon1.BalloonTitle:='terminou o pomo';
       TrayIcon1.BalloonHint:='faça uma pausa';
       frmMain.Show;
       TrayIcon1.ShowBalloonHint;


     end;

end;

procedure TfrmMain.pmeStartClick(Sender: TObject);
begin
     frmMain.Show;
     ProgressBar1.Max:= intTimeSec;
     ProgressBar1.Position:= intTimeSec;
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
  intTimeSec := StrToInt(s);
end;

procedure TfrmMain.MenuItem3Click(Sender: TObject);
begin
  frmClose := True;
  frmMain.Close;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  frmClose := False;
  menMostrar.Visible:= False;

end;

procedure TfrmMain.menMostrarClick(Sender: TObject);
begin
  frmMain.Show;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if frmClose then
  begin
    CloseAction:= caFree;
  end else begin
    CloseAction:= caHide;
    menMostrar.Visible:= True;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  intTimeSec := 1500;
  tmrPomo.Enabled:= False;

end;

end.

