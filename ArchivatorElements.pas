{ ������ ��������������� ��������� ��������� }
unit ArchivatorElements;

interface

uses
  ChangedAction;   //������ ��������� ������� �������������

Type

  {����������� ��� - ����� ������� ��������� ������ (��� ������/����������)}
  TSymbolGet = procedure(var source: file; var FrTable: TFreqTable);
  TAdr = ^Tlief;                      //���-��������� �� ������
  TBin = 0..1;                        //��� ������� � ������ (0 - ����, 1 �����)
  TLief = record                      //���-������- ���� ������
            Pos: TBin;                //������� (�����/������);
            Symbol: Byte;             //����� �����
            Code: string;             //��� ��������
            Freq: Word;               //�������������
            Left,Right: TAdr;         //�����/������ ���
          end;

  { ���-������ ���������� �� ������ }
  TTrees = array of TAdr;
  TAlphabet = array[Byte] of TAdr;

function QuickSortArr(var MyForest: TTrees):byte;
procedure GetTable(var FrTable: TFreqTable; var SourSt: string;
                   GetProc: pointer);
procedure CountInfo(var FrTable: TFreqTable; var MyForest: TTrees;
                    var ByteAlph: TAlphabet);
procedure CreateTree(var MyForest: TTrees);
procedure ViewTree(var Tree:TAdr;code:string);

implementation

uses
  StatsForAdmin;  //������ ���������� ��������

{ ��������� ������� ������������� ����� �������������/���������������� }
procedure GetTable;

var
  Action: TSymbolGet;
  F: file;

begin

  Assign(F,SourSt);
  Reset(F,1);
  Action:=GetProc;
  Action(F,FrTable);
  Close(F);

end;

{ �������� ���� ������� ������ }
procedure CountInfo;

var
  i:byte;       //������� �����

begin

  SetLength(MyForest,256);

  {���������� ������� ����������� �� ������������� ������}
  for i:=0 to 255 do
  begin

    New(MyForest[i]);   //�������� �������� � �������

    with MyForest[i]^ do
    begin

      Freq:=FrTable[i]; //�������������
      Left:=nil;        //��������� �� ������ ����
      Right:=nil;       //��������� �� ������� ����
      Symbol:=i;        //����� �����

    end;

    ByteAlph[i]:=MyForest[i];

  end;

end;

{ ������� ���������� ���������� �� ������ }
function QuickSortArr;

var
  i,j,s: Integer;     //��������
  l,r,x:integer;      //�����/������ ������� / ������� ��������
  temp:TAdr;          // ��������� ����������
  st:array[1..100,1..2] of integer; //����������� ������� ����������

begin

  { ������������� ���������� }
  s:=1;
  st[1,1]:=0;
  st[1,2]:=Length(MyForest)-1;

  repeat

    { ����������� ������ }
    l:=st[s,1];
    r:=st[s,2];
    s:=s-1;

    repeat

      i:=l;
      j:=r;
      x:=MyForest[(l+r) div 2]^.Freq;

      repeat

        { ��������� � ����� ��������� �� �������� }
        while MyForest[i]^.Freq>x do i:=i+1;
        while x>MyForest[j]^.Freq do j:=j-1;
        if i<=j then
        begin
          temp:=MyForest[i];
          MyForest[i]:=MyForest[j];
          MyForest[j]:=temp;
          inc(i);
          Dec(j);
        end;

      until  i>j;

      { ����������� ������� ���������� }
      if i<r then
      begin
        Inc(s);
        st[s,1]:=i;
        st[s,2]:=r;
      end;
      r:=j;

    until  l>=r;

  until s=0;

  { ������ ������, ��� ������������ ����� ���� }
  j:=Length(MyForest)-1;
  while MyForest[j]^.Freq=0 do
  begin

    Dispose(MyForest[j]);
    dec(j);

  end;
  SetLength(MyForest,j+1);
  Result:=j; //����� ������� �������������

end;

{ �������� ������ ������������� ���� }
function CreateLief(var lief1, lief2: TAdr):TAdr;

var
  CurTree: TAdr;

begin

  lief2.Pos:=0;
  lief2.Pos:=1;
  New(CurTree);
  CurTree.Freq:=lief1.Freq+lief2.Freq;
  CurTree.Left:=lief1;
  CurTree.Right:=lief2;
  Result:=CurTree;

end;

{ ������� ������ �� ���� �� ������ ������� }
procedure InsertLief(var InLief: TAdr; var MyArr: TTrees; PrevPos:byte);

var
  TempLief: TAdr;
  i:integer;
  InsPos:integer;

begin

  InsPos:=PrevPos-1; //������� ��� ��������� ������������ ��������
  { ����� ������� ��� ������� }
  while (InsPos>=0) and (MyArr[PrevPos].Freq>MyArr[InsPos].Freq) do Dec(InsPos);
  TempLief:=InLief;   //���������� ������������ �����
  for i:=PrevPos downto InsPos+1 do MyArr[i]:=MyArr[i-1]; //�������� ������
  MyArr[InsPos+1]:=TempLief; //������� �����

end;

{ ���������� ������ �������� }
procedure CreateTree;

var

  i:byte;       //�������
  Lief: TAdr;   //����������� ����-��������

begin

  i:=Length(MyForest)-1;

  while i>0 do
  begin

    Lief:=CreateLief(MyForest[i],MyForest[i-1]); //�������� �����
    MyForest[i-1]:=Lief;
    InsertLief(MyForest[i-1],MyForest,i-1); //������� ����� �� ������ �������
    Dec(i);
    SetLength(MyForest,Length(MyForest)-1); //������������� ������� �������

  end;

end;

{ ����������� ����� ������ �������� ������ ���� }
procedure ViewTree;

begin

  { �������� ������ ��������� }
  If Tree.Left<>Nil then
  begin

    code:=code+'0';             //������� � ����. ���� � ����
    Tree.Left.Code:=code;     //���������� ������ ���� ����
    ViewTree(Tree^.Left,code);  //����������� �������� ������ ���������

  end;

  { �������� ������� ��������� }
  If Tree^.Right<>Nil then
  begin

    setlength(code,length(code)-1);
    code:=code+'1';             //������� � ����. ���� � �����
    Tree.Right.Code:=code;    //���������� ������� ���� ����
    ViewTree(Tree.Right,code); //����������� �������� ������� ���������

  end;

end;

end.
