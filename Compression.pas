{ Модуль процесса сжатия файла }
unit Compression;

interface

uses
  SysUtils,
  ChangedAction,       //Модуль получения таблицы встречаемости
  ArchivatorElements;  //Модуль вспомогательных элементов программы

procedure SaveData(var Source,Dest: string; var FrTable: TFreqTable;
                   var ByteArr: TAlphabet; LenTable: Byte);

implementation

Uses
  StatsForAdmin;

{ Сохранение расширения файла }
procedure SaveExtension(var Dest: file; var Loc: string);

var
  InFileExt,FileExt: string[5];  //Расширение файла
  i:byte;                        //Счётчик

begin

  InFileExt:='    ';
  FileExt:=ExtractFileExt(Loc);
  Delete(FileExt,1,1);
  Insert(FileExt,InFileExt,1);
  for i:=1 to 4 do blockwrite(Dest,InFileExt[i],1);

end;

{ Сохранение таблицы встречаемости }
procedure SaveTable(var Dest: file; var FrTable: TFreqTable; LenTable:Byte);

var
  i:byte;

begin

  blockWrite(Dest,LenTable,1); //Сохранение длины таблицы встречаемости

  { Запись таблицы встречаемости }
  for i:=0 to 255 do
    if FrTable[i]<>0 then
    begin

      blockWrite(Dest,i,1);
      blockwrite(Dest,FrTable[i],2);

    end;

end;

{ Запись строки в байт }
function PutValue(var str: string; var Dest: file):byte;

var
  i,j,Val:byte;  //Счётчики

begin

  j:=1;
  val:=0;

  { Проход по строке }
  for i:=8 downto 1 do
  begin

    if str[i]='1' then val:=val or j;
    j:=j*2;

  end;

  Result:=val;

end;

{ Упаковка основной сжимаемой информации }
procedure PackBytes(var Source, Dest: file; var ByteALph: TAlphabet);

var

  i,k:longword;         //Счётчики
  MyStr,OldStr: string; //Строки для получения кода

begin

  Reset(Source,1);
  NextAct.OldSize:=FileSize(Source);
  k:=0;
  i:=k;
  { Проход по всему файлу }
  while not(Eof(Source)) or (i<=ResIn) do
  begin

    MyStr:='';
    BlockRead(Source,Buffer,BufSize,ResIn);
    i:=0;

    { Упаковка байтов буфера чтения }
    repeat

      MyStr:=ByteALph[Buffer[i]]^.Code;
      MyStr:=OldStr+MyStr;

      { Упаковка байта, если длина кода больше или равна восьми }
      if Length(MyStr)>=8 then
      begin

        OldStr:=Copy(MyStr,9,Length(MyStr)-8);
        SetLength(MyStr,8);

        { Запись буфера при полном заполнении }
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

  { Запись буфера при неполном его заполнении }
  if Length(MyStr)<>0 then
  begin

    BufferOut[k]:=PutValue(MyStr,Dest);
    BlockWrite(Dest,BufferOut,k,ResOut);

  end;

end;

{ Сохранение информации по сжимаемому файлу }
procedure SaveData;

var
  SourFile, DestFile:file;  //Файл исчтоник/файл приёмник

begin

  Assign(SourFile,Source);
  Assign(DestFile,Dest);
  Rewrite(DestFile,1);
  SaveExtension(DestFile,Source);       //Сохранение расширения
  SaveTable(DestFile,FrTable,LenTable); //Сохранение таблицы встречаемости
  PackBytes(SourFile,DestFile,ByteArr); //Сжатие основной информации
  NextAct.NewSize:=FileSize(DestFile);
  Close(DestFile);
  Close(SourFile);

end;

end.
