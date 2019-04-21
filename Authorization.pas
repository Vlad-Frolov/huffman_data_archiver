{Программа предназначена для сжатия текстовых файлов, изображений и HTML-страниц.
В основу принципа работы программного средства для сжатия/распаковки файлов
с использование кода Хаффмана положено взаимодействие авторизированного
пользователя и программного модуля, обеспечиваемое GUI, реализованным в
виде форм и окон. В качестве входных данных будут использоваться данные
пользователя (имя пользователя, пароль), а также выбранный пользователем файл
и операция (сжатие/распаковка).

{ Модуль авторизации пользователя }
unit Authorization;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls;

type
  TAuthorForm = class(TForm)
    btnLogin: TButton;
    btnRegistration: TButton;
    edtLogin: TEdit;
    edtPassword: TEdit;
    lblLogin: TLabel;
    lblPassword: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure btnRegistrationClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AuthorForm: TAuthorForm;  //Форма авторизации

implementation

{$R *.dfm}

uses
  AuthorController, //Модуль контроля данных авторизации
  HuffPackage;      //Модуль главной формы программы

type

  { Тип-запись информации о пользователе }
  TUserInfo = record
                Login,Password: String[16];
                LastSes,RegDate: TDateTime;
              end;

  { Тип файла пользователя }
  TUserData = file of TUserInfo;

var
  UserFile: TUserData; //Файл данных пользователя
  InfoUser: TUserInfo; //Данные пользователя
  FileName: string;    //Имя файла пользователя

{ Действия регистрации пользователя }
procedure CheckFileReg(var MyFile: TUserData; var Login,Pass: TEdit);

begin

  AuthorForm.Icon.Create;
  FileName:='Пользователи\'+Login.Text;

  { Проверка занятости логина }
  if FileExists(FileName) then ShowMessage('Данный логин уже занят')
  else
  begin

    Assign(UserFile,FileName);
    Rewrite(UserFile);

    { Инициализация данных пользователя }
    With InfoUser do
    begin

      Login:=AuthorForm.edtLogin.Text;
      Password:=AuthorForm.edtPassword.Text;
      RegDate:=Now;
      LastSes:=RegDate;

    end;

    Write(UserFile,InfoUser);
    Close(UserFile);
    ShowMessage('Зарегестрирован новый пользователь '+Login.Text);
    AuthorForm.Hide;
    MainForm.lblUserName.Caption:=Login.Text;
    MainForm.Show;

  end;

end;

{ Действия при входе пользователя }
procedure CheckFileAuth(var MyFile: TUserData; var Login,Pass: TEdit);

begin

  FileName:='Пользователи\'+Login.Text;

  { Проверка существования пользователя }
  if not(FileExists(FileName))
  then ShowMessage('Пользователя с таким логином не существует')
  else
  begin

    Assign(UserFile,FileName);
    Reset(UserFile);
    Read(UserFile,InfoUser);

    { Проверка совпадения пароля }
    if InfoUser.Password=Pass.Text then
    begin

      InfoUser.LastSes:=Now;
      ShowMessage('Добро пожаловать, '+Login.Text);
      AuthorForm.Hide;
      MainForm.lblUserName.Caption:=Login.Text;
      MainForm.Show;

    end
    else ShowMessage('Неверный пароль');

  end;

end;

{ Действия при нажатии кнопки Вход }
procedure TAuthorForm.btnLoginClick(Sender: TObject);
begin

  { Проверка корректности введённых данных }
  if not(CheckInfo(edtLogin,edtPassword))
  then CheckFileAuth(UserFile,edtLogin,edtPassword);

end;

{ Действия при нажатии кнопки Регистрация }
procedure TAuthorForm.btnRegistrationClick(Sender: TObject);
begin

  { Проверка корректности введённых данных }
  if not(CheckInfo(edtLogin,edtPassword))
  then CheckFileReg(UserFile,edtLogin,edtPassword);

end;

end.
