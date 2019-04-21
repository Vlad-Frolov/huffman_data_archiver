{ ������ �������� ������ ����� }
unit Compression;

interface

uses
  SysUtils,
  ChangedAction,       //������ ��������� ������� �������������
  ArchivatorElements;  //������ ��������������� ��������� ���������

procedure SaveData(var Source,Dest: string; var FrTable: TFreqTable;
                   var ByteArr: TAlphabet; LenTable: Byte);

implementation

Uses
  StatsForAdmin;

{ ���������� ���������� ����� }
procedure SaveExtension(var Dest: file; var Loc: string);

var
  InFileExt,FileExt: string[5];  //���������� �����
  i:byte;                        //�������

begin

  InFileExt:='    ';
  FileExt:=ExtractFileExt(Loc);
  Delete(FileExt,1,1);
  Insert(FileExt,InFileExt,1);
  for i:=1 to 4 do blockwrite(Dest,InFileExt[i],1);

end;

{ ���������� ������� ������������� }
procedure SaveTable(var Dest: file; var FrTable: TFreqTable; LenTable:Byte);

var
  i:byte;

begin

  blockWrite(Dest,LenTable,1); //���������� ����� ������� �������������

  { ������ ������� ������������� }
  for i:=0 to 255 do
    if FrTable[i]<>0 then
    begin

      blockWrite(Dest,i,1);
      blockwrite(Dest,FrTable[i],2);

    end;

end;

{ ������ ������ � ���� }
function PutValue(var str: string; var Dest: file):byte;

var
  i,j,Val:byte;  //��������

begin

  j:=1;
  val:=0;

  { ������ �� ������ }
  for i:=8 downto 1 do
  begin

    if str[i]='1' then val:=val or j;
    j:=j*2;

  end;

  Result:=val;

end;

{ �������� �������� ��������� ���������� }
procedure PackBytes(var Source, Dest: file; var ByteALph: TAlphabet);

var

  i,k:longword;         //��������
  MyStr,OldStr: string; //������ ��� ��������� ����

begin

  Reset(Source,1);
  NextAct.OldSize:=FileSize(Source);
  k:=0;
  i:=k;
  { ������ �� ����� ����� }
  while not(Eof(Source)) or (i<=ResIn) do
  begin

    MyStr:='';
    BlockRead(Source,Buffer,BufSize,ResIn);
    i:=0;

    { �������� ������ ������ ������ }
    repeat

      MyStr:=ByteALph[Buffer[i]]^.Code;
      MyStr:=OldStr+MyStr;

      { �������� �����, ���� ����� ���� ������ ��� ����� ������ }
      if Length(MyStr)>=8 then
      begin

        OldStr:=Copy(MyStr,9,Length(MyStr)-8);
        SetLength(MyStr,8);

        { ������ ������ ��� ������ ���������� }
        if k=BufSize then
        begin

          BlockWrite(Dest,BufferOut,k,ResIn);
          k:=0;

        end;

        BufferOut[k]:=PutValue(MyStr,Dest);
        inc(k);

      end
      else OldStr:=MyStr;
      inc(i);

    until i>ResIn;

  end;

  { ������ ������ ��� �������� ��� ���������� }
  if Length(MyStr)<>0 then
  begin

    BufferOut[k]:=PutValue(MyStr,Dest);
    BlockWrite(Dest,BufferOut,k,ResOut);

  end;

end;

{ ���������� ���������� �� ���������� ����� }
procedure SaveData;

var
  SourFile, DestFile:file;  //���� ��������/���� �������

begin

  Assign(SourFile,Source);
  Assign(DestFile,Dest);
  Rewrite(DestFile,1);
  SaveExtension(DestFile,Source);       //���������� ����������
  SaveTable(DestFile,FrTable,LenTable); //���������� ������� �������������
  PackBytes(SourFile,DestFile,ByteArr); //������ �������� ����������
  NextAct.NewSize:=FileSize(DestFile);
  Close(DestFile);
  Close(SourFile);

end;

end.
