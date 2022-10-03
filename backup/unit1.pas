unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  OpenGLContext, gl, glu, Clipbrd;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    OnApp: TApplicationProperties;
    OpenGLControl1: TOpenGLControl;
    OpenGLControl2: TOpenGLControl;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    TrackBar7: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnAppIdle(Sender: TObject; var Done: Boolean);
    procedure OpenGLControl1Paint(Sender: TObject);
    procedure OpenGLControl1Resize(Sender: TObject);
    procedure OpenGLControl2Paint(Sender: TObject);
    procedure OpenGLControl2Resize(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  xr, yr, zr, ar, rt, gt, bt: real;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

  xr:=0;
  yr:=0;
  zr:=0;
  ar:=0;
  rt:= 0;
  bt:= 0;
  gt:= 0;
  Application.AddOnIdleHandler(@OnAppIdle);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Clipboard.AsText:=StringReplace(FloatToStr(rt), ',', '.', [rfReplaceAll]) + ', ' + StringReplace(FloatToStr(gt), ',', '.', [rfReplaceAll]) + ', ' + StringReplace(FloatToStr(bt), ',', '.', [rfReplaceAll]);
end;

procedure TForm1.OnAppIdle(Sender: TObject; var Done: Boolean);
begin
  Done:=False;
  OpenGLControl1.Invalidate;
  OpenGLControl2.Invalidate;
end;

procedure TForm1.OpenGLControl1Paint(Sender: TObject);
begin
  // -------------------------- OpenGL Code ----------------------------------

  glClearColor(0.27, 0.53, 0.71, 1.0); // Set blue background
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);


  glLoadIdentity;
  glTranslatef(0, 0, 0);
  glRotatef(ar, xr, yr, zr);

  // Coord Grid

  glBegin(GL_LINES);

    // x Line Rot
    glColor4f(1, 0, 0, 0);
    glVertex3f(-10,0,0);
    glVertex3f(10, 0, 0);

    // y Line Grün
    glColor4f(0, 1, 0, 0);
    glVertex3f(0,-10,0);
    glVertex3f(0, 10, 0);

    // z Line Blau
    glColor4f(0, 0, 1, 0);
    glVertex3f(0,0,-10);
    glVertex3f(0, 0, 10);

  glEnd;

  glBegin(GL_TRIANGLE_FAN);
    // Dreieck rot
    glColor4f(1, 0, 0, 0);
    glVertex3f(0, 0.5, 0);
    // Dreieck grün
    glColor4f(0, 1, 0, 0);
    glVertex3f(0, 0, -0.5);
    // Dreieck rot
    glColor4f(1, 0, 0, 0);
    glVertex3f(0.5, 0, 0.5);
    glVertex3f(-0.5, 0, 0.5);
    // Dreieck blau
    glColor4f(0, 0, 1, 0);
    glVertex3f(0, 0, -0.5);
  glEnd;

  // glColor4f(1, 1, 1, 0);
  // gluSphere(gluNewQuadric(), 0.1, 100, 10);

  // -------------------------------------------------------------------------

  glFlush();
  OpenGLControl1.SwapBuffers;

end;

procedure TForm1.OpenGLControl1Resize(Sender: TObject);
begin
  if Height = 0 then
    Height := 1;

  glViewport(0, 0, Width, Height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(45, Width / Height, 0.1, 1000);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;

procedure TForm1.OpenGLControl2Paint(Sender: TObject);
begin
  glClearColor(rt, gt, bt, 0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glFlush();
  OpenGLControl2.SwapBuffers;
end;

procedure TForm1.OpenGLControl2Resize(Sender: TObject);
begin

end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  xr:=(TrackBar1.Position/100);
  Label1.Caption:='X: ' + FloatToStr(TrackBar1.Position/100);
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  yr:=(TrackBar2.Position/100);
  Label2.Caption:='Y: ' + FloatToStr((TrackBar2.Position/100));
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
  zr:=(TrackBar3.Position/100);
  Label3.Caption:='Z: ' + FloatToStr((TrackBar3.Position/100));
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
  ar:=(TrackBar4.Position);
  Label4.Caption:='A: ' + FloatToStr((TrackBar4.Position));
end;

procedure TForm1.TrackBar5Change(Sender: TObject);
begin
  rt:=(TrackBar5.Position/1000);
  Label6.Caption:=FloatToStr(Trackbar5.Position/1000) + ' - Rot';
end;

procedure TForm1.TrackBar6Change(Sender: TObject);
begin
  gt:=(TrackBar6.Position/1000);
  Label7.Caption:=FloatToStr(Trackbar6.Position/1000) + ' - Gruen';
end;

procedure TForm1.TrackBar7Change(Sender: TObject);
begin
  bt:=(TrackBar7.Position/1000);
  Label8.Caption:=FloatToStr(Trackbar7.Position/1000) + ' - Blau';
end;

end.

