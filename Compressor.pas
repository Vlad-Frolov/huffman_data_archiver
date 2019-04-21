{ ������ �������� �������� ������/���������� }
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
  Forest: TTrees;        //��� ������� (������)
  ByteArray: TAlphabet;  //��������� �� ������
  TableLength: Byte;     //������ ������� �������������

{ �������� ������ ����� }
procedure CompressFile;

begin

  { ��������� ������� ������������� ��� ���������� }
  GetTable(FreqArr,Source,@GetSymbolEnc);
  PrepareFile(Source,Dest);
  SaveData(Source,Dest,FreqArr,ByteArray,TableLength);

end;

{ �������� ���������� ����� }
procedure DecompressFile;

begin

  { ��������� ������� ������������� ��� ������ }
  GetTable(FreqArr,Source,@GetSymbolDec);
  PrepareFile(Source,Dest);
  Decomp(Source,Dest,Forest[0]);

end;

{ ���������� ����� � ������/���������� }
procedure PrepareFile;

begin

  CountInfo(FreqArr,Forest,ByteArray);
  TableLength:=QuickSortArr(Forest);
  CreateTree(Forest);
  ViewTree(Forest[0],'');

end;

end.

