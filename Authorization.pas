{��������� ������������� ��� ������ ��������� ������, ����������� � HTML-�������.
� ������ �������� ������ ������������ �������� ��� ������/���������� ������
� ������������� ���� �������� �������� �������������� �����������������
������������ � ������������ ������, �������������� GUI, ������������� �
���� ���� � ����. � �������� ������� ������ ����� �������������� ������
������������ (��� ������������, ������), � ����� ��������� ������������� ����
� �������� (������/����������).

{ ������ ����������� ������������ }
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
  AuthorForm: TAuthorForm;  //����� �����������

implementation

{$R *.dfm}

uses
  AuthorController, //������ �������� ������ �����������
  HuffPackage;      //������ ������� ����� ���������

type

  { ���-������ ���������� � ������������ }
  TUserInfo = record
                Login,Password: String[16];
                LastSes,RegDate: TDateTime;
              end;

  { ��� ����� ������������ }
  TUserData = file of TUserInfo;

var
  UserFile: TUserData; //���� ������ ������������
  InfoUser: TUserInfo; //������ ������������
  FileName: string;    //��� ����� ������������

{ �������� ����������� ������������ }
procedure CheckFileReg(var MyFile: TUserData; var Login,Pass: TEdit);

begin

  AuthorForm.Icon.Create;
  FileName:='������������\'+Login.Text;

  { �������� ��������� ������ }
  if FileExists(FileName) then ShowMessage('������ ����� ��� �����')
  else
  begin

    Assign(UserFile,FileName);
    Rewrite(UserFile);

    { ������������� ������ ������������ }
    With InfoUser do
    begin

      Login:=AuthorForm.edtLogin.Text;
      Password:=AuthorForm.edtPassword.Text;
      RegDate:=Now;
      LastSes:=RegDate;

    end;

    Write(UserFile,InfoUser);
    Close(UserFile);
    ShowMessage('��������������� ����� ������������ '+Login.Text);
    AuthorForm.Hide;
    MainForm.lblUserName.Caption:=Login.Text;
    MainForm.Show;

  end;

end;

{ �������� ��� ����� ������������ }
procedure CheckFileAuth(var MyFile: TUserData; var Login,Pass: TEdit);

begin

  FileName:='������������\'+Login.Text;

  { �������� ������������� ������������ }
  if not(FileExists(FileName))
  then ShowMessage('������������ � ����� ������� �� ����������')
  else
  begin

    Assign(UserFile,FileName);
    Reset(UserFile);
    Read(UserFile,InfoUser);

    { �������� ���������� ������ }
    if InfoUser.Password=Pass.Text then
    begin

      InfoUser.LastSes:=Now;
      ShowMessage('����� ����������, '+Login.Text);
      AuthorForm.Hide;
      MainForm.lblUserName.Caption:=Login.Text;
      MainForm.Show;

    end
    else ShowMessage('�������� ������');

  end;

end;

{ �������� ��� ������� ������ ���� }
procedure TAuthorForm.btnLoginClick(Sender: TObject);
begin

  { �������� ������������ �������� ������ }
  if not(CheckInfo(edtLogin,edtPassword))
  then CheckFileAuth(UserFile,edtLogin,edtPassword);

end;

{ �������� ��� ������� ������ ����������� }
procedure TAuthorForm.btnRegistrationClick(Sender: TObject);
begin

  { �������� ������������ �������� ������ }
  if not(CheckInfo(edtLogin,edtPassword))
  then CheckFileReg(UserFile,edtLogin,edtPassword);

end;

end.
