{ ������ "� ���������" }
unit AboutProgr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAboutProgrForm = class(TForm)
    mmoAbout: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutProgrForm: TAboutProgrForm; //����� "� ���������"

implementation

{$R *.dfm}

uses
  HuffPackage;  //������ ������� ����� ���������

const
  InfoDir = 'AboutProgr.txt'; //�������������� ����� � �����������

{ �������� ��� �������� ����� }
procedure TAboutProgrForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  MainForm.Enabled:=True;

end;

{ �������� ��� �������� ����� }
procedure TAboutProgrForm.FormCreate(Sender: TObject);
begin

   { �������� ���������� �� ����� }
   AboutProgrForm.mmoAbout.lines.loadFromFile(InfoDir);

end;

end.
