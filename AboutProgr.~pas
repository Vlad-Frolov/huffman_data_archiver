{ Модуль "О программе" }
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
  AboutProgrForm: TAboutProgrForm; //Форма "О программе"

implementation

{$R *.dfm}

uses
  HuffPackage;  //Модуль главной формы программы

const
  InfoDir = 'AboutProgr.txt'; //Местоположения файла с информацией

{ Действия при закрытии формы }
procedure TAboutProgrForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  MainForm.Enabled:=True;

end;

{ Действия при создании формы }
procedure TAboutProgrForm.FormCreate(Sender: TObject);
begin

   { Загрузка информации из файла }
   AboutProgrForm.mmoAbout.lines.loadFromFile(InfoDir);

end;

end.
