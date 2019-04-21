{ ������ ���� �������������� ������ ���������� }
unit AdmEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
  TEditForm = class(TForm)
    edtChLogin: TEdit;
    edtChAction: TEdit;
    edtChOldName: TEdit;
    edtChNewName: TEdit;
    btnChOk: TButton;
    lblChLogin: TLabel;
    lblChAction: TLabel;
    lblChOldName: TLabel;
    lblChNewName: TLabel;
    edtChProcVal: TEdit;
    lblChProcVal: TLabel;
    procedure btnChOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditForm: TEditForm;

implementation

{$R *.dfm}

uses
  StatsForAdmin;

{ �������� ��� ������� ������ "��" }
procedure TEditForm.btnChOkClick(Sender: TObject);
begin

  StatsForm.Enabled:=true;
  EditForm.Hide;
  SaveField;
  StatsForm.cbbSortBy.ItemIndex:=-1;
  ShowStatsInfo;

end;

{ �������� ��� �������� ���� �������������� }
procedure TEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  StatsForAdmin.StatsForm.Enabled:=true;

end;

end.

