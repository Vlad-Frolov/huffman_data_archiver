{ Модуль контроля процесса сжатия/распаковки }
unit Compressor;

interface

procedure CompressFile(var Source, Dest: string);
procedure DecompressFile(var Source, Dest: string);
procedure PrepareFile(var Source, Dest: string);

implementation

Uses
  ArchivatorElements,
  ChangedAction,
  Compression,
  Decompression,
  StatsForAdmin;

var
  Forest: TTrees;        //Лес листьев (записи)
  ByteArray: TAlphabet;  //Указатели на листья
  TableLength: Byte;     //Размер таблицы встречаемости

{ Контроль сжатия файла }
procedure CompressFile;

begin

  { Получение таблицы встречаемости при распаковке }
  GetTable(FreqArr,Source,@GetSymbolEnc);
  PrepareFile(Source,Dest);
  SaveData(Source,Dest,FreqArr,ByteArray,TableLength);

end;

{ Контроль распаковки файла }
procedure DecompressFile;

begin

  { Получение таблицы встречаемости при сжатии }
  GetTable(FreqArr,Source,@GetSymbolDec);
  PrepareFile(Source,Dest);
  Decomp(Source,Dest,Forest[0]);

end;

{ Подготовка файла к сжатию/распаковке }
procedure PrepareFile;

begin

  CountInfo(FreqArr,Forest,ByteArray);
  TableLength:=QuickSortArr(Forest);
  CreateTree(Forest);
  ViewTree(Forest[0],'');

end;

end.

