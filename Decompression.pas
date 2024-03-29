{ ������ �������� ���������� ����� }
unit Decompression;

interface

uses
  SysUtils,
  ChangedAction,
  ArchivatorElements;

procedure Decomp(var Source,Dest: string; var Root: TAdr);

implementation

Uses
  StatsForAdmin;   //������ ���������� ��������

var
  Flag:boolean;    //������-�������

{ ��������� �������� ������ }
function RetBin(val: byte):string;

var
  BinStr: string;
  i,ost:byte;

begin

  i:=8;
  BinStr:='00000000';
  repeat

    ost:=val mod 2;
    BinStr[i]:=chr(ost+ord('0'));
    val:=val div 2;
    dec(i);

  until val=0;

  Result:=BinStr;

end;

{ �������� ���������������� ����� }
function GetChar(var MyTree: TAdr; var Mystr: string):byte;

var
  i:byte;         //�������
  CurTree: TAdr;  //������� � ������

begin

  flag:=False;
  CurTree:=MyTree;
  i:=1;

  { ������ �� ������ }
  while (CurTree^.Left<>nil) and (i<=length(MyStr)) do
  begin
    if Mystr[i]='0' then CurTree:=CurTree^.Left else CurTree:=CurTree^.Right;
    Inc(i);
  end;
  if ((CurTree^.Left=nil) and (CurTree^.Right=nil)) and (i<=Length(Mystr)) then
  begin

    Delete(Mystr,1,i-1);
    Result:=CurTree^.Symbol;
    Flag:=true;

  end
  else Result:=0;

end;

{ ��������� ���������� ������� ����� }
function GetExtension(var Source: file):string;

var
  i: byte;  //�������
  Symbol: byte;

begin

   { ����������� ���������� ������������� ����� }
  for i:=1 to 4 do
  begin

    Blockread(Source,Symbol,1);
    Result:=Result+chr(Symbol);

  end;
  if Result[4]=' ' then SetLength(Result,3);

end;

{ ���������� ����� }
procedure Decomp;

var
  Symbol:byte;             //��������������� ����
  SourFile, DestFile:file; //����-���������/����-�������
  pos: word;               //������� � �����
  Mystr: string;           //�������� ������
  i,k: longword;           //��������

begin

  { ��������� ������ }
  pos:=0;
  Assign(SourFile,Source);
  Reset(SourFile,1);
  NextAct.OldSize:=FileSize(SourFile);
  Assign(DestFile,Dest+'.'+GetExtension(SourFile));
  Rewrite(DestFile,1);

  { ��������� �� ������ ������� � ����� }
  Blockread(SourFile,pos,1);
  pos:=(pos+1)*3+5;
  seek(SourFile,pos);

  MyStr:='';
  k:=0;

  { ������ �� ����� ����� }
  while not(eof(SourFile)) do
  begin

    BlockRead(SourFile,Buffer,BufSize,ResIn);
    i:=0;

    while i<ResIn do
    begin

      MyStr:=MyStr+RetBin(Buffer[i]);
      inc(i);

      repeat

        Symbol:=GetChar(Root,Mystr);  //��������� ������������� �����

        { ���� ���� ��� �������, �� ����������� ������ � ����� }
        if Flag then
        begin

          if k=BufSize then
          begin

            BlockWrite(DestFile,BufferOut,k,ResIn);
            k:=0;

          end;

          BufferOut[k]:=Symbol;
          inc(k);

        end

      until (Mystr='') or not(Flag);

    end;

  end;

  { ���� ������ �� ��� �������� ��������� }
  if k<>0 then BlockWrite(DestFile,BufferOut,k,ResOut);

  NextAct.NewSize:=FileSize(DestFile);
  Close(DestFile);
  Close(SourFile);

end;

end.
 