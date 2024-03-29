{ ������ �������� ������ ����������� }
unit AuthorController;

interface

Uses
  StdCtrls, Dialogs;

{ ������� �������� ���� ����� �� ������������ }
function CheckInfo(var Login, Pass: TEdit):boolean;

{ ������� �������� ����� � ������� ���� }
function CheckFields(var InfoField: TEdit):Boolean;

{ ������� �������� �������� � ���� }
function IsBadSymbols(var InfoField: TEdit):Boolean;

implementation

{ �������� ���� ����� �� ������������ }
function CheckInfo;

begin

  Result:=CheckFields(Login) or CheckFields(Pass) or IsBadSymbols(Login)
  or IsBadSymbols(Pass);

end;

{ ������� �������� �������� � ���� }
function IsBadSymbols;

var
  i:byte;
  flag: boolean;

begin

  i:=1;
  flag:=false;

  { ����� ��������, �� �������� � ���������� }
  while not(flag) and (i<=Length(InfoField.Text)) do
  begin

    if not(InfoField.Text[i] in ['A'..'Z','a'..'z','0'..'9','_']) then
    begin

      ShowMessage('������������ ������ � ���� '+InfoField.Hint);
      flag:=true;

    end;

    inc(i);

  end;

  Result:=Flag;

end;

{ ������� �������� ����� }
function CheckFields;

begin

  Result:=False;

  { �������� �� ������� }
  if InfoField.Text='' then
  begin

    ShowMessage('���� '+InfoField.Hint+' ������');
    Result:=true;

  end;

  { �������� ����� ���� }
  if Length(InfoField.Text)>16 then
  begin

    ShowMessage('����� ���� '+InfoField.Hint+' ��������� 16 ��������');
    Result:=true;

  end;

end;

end.
