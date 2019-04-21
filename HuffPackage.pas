{ ������ ������� ����� ��������� }
unit HuffPackage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, Buttons, ActnList, ExtCtrls, ImgList,
  Menus, Grids, jpeg;

type
  TMainForm = class(TForm)
    btnDecompress: TBitBtn;
    dlgOpenFile: TOpenDialog;
    dlgSaveFile: TSaveDialog;
    btnCompress: TBitBtn;
    actlstUserActions: TActionList;
    mmMainMenu: TMainMenu;
    mniArchivator: TMenuItem;
    mniHelp: TMenuItem;
    mniAboutProgr: TMenuItem;
    mniCompress: TMenuItem;
    mniDecompress: TMenuItem;
    actFileCompress: TAction;
    actDecompressFile: TAction;
    InfoTable: TStringGrid;
    Picture: TImage;
    lblUserName: TLabel;
    lblUserText: TLabel;
    pbProgress: TProgressBar;
    mniHuffmanWiki: TMenuItem;
    mniHabrTopic: TMenuItem;
    mniStats: TMenuItem;
    procedure actFileCompressExecute(Sender: TObject);
    procedure actDecompressFileExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mniAboutProgrClick(Sender: TObject);
    procedure mniHuffmanWikiClick(Sender: TObject);
    procedure mniHabrTopicClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mniStatsClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm; //������� ����� ���������

implementation

{$R *.dfm}

uses
  AboutProgr,      //������ "� ���������"
  Authorization,   //������ ����������� ������������
  ChangedAction,   //������ ��������� ������� �������������
  Compressor,      //������ �������� �������� ������/����������
  ShellApi,        //������ ��� �������������� � ���������
  StatsForAdmin;   //������ ���������� ��������

{ ��������� ������������ ������ }
procedure SetFiles(var SourSt,DestSt: string);

begin

  If Not(MainForm.dlgOpenFile.Execute) Then Exit;
  SourSt:=MainForm.dlgOpenFile.FileName;
  If Not(MainForm.dlgSaveFile.Execute) Then Exit;
  DestSt:=MainForm.dlgSaveFile.FileName;

  { ������������� ���������� }
  With NextAct do
  begin

    OldName:=SourSt;
    NewName:=DestSt;
    Time:=Now;

  end;

end;

{ ����� ������������� ������ ����� }
procedure GetAnalys(var FrArr: TFreqTable);

var
  i:Byte;

begin

  MainForm.InfoTable.RowCount:=2;

  for i:=1 to Length(FrArr)-1 do
  begin

    with MainForm.InfoTable do
    begin

      Cells[0,i]:=IntToStr(i);
      Cells[1,i]:=Chr(i);
      Cells[2,i]:=IntToStr(FrArr[i]);
      RowCount:=RowCount+1;

    end;

  end;

  with MainForm do
  begin

    InfoTable.RowCount:=InfoTable.RowCount-1;
    pbProgress.Position:=100;

  end;

end;

{ �������� ��� ������ ����� }
procedure TMainForm.actFileCompressExecute(Sender: TObject);

var
  SourStr,DestStr:string;

begin

  MainForm.dlgOpenFile.Filter:='�����|*.txt;*.docx;*.doc;*.rtf;*.html;*.jpg;*.png';
  dlgSaveFile.DefaultExt:='hfm';
  SetFiles(SourStr,DestStr);
  { �������� ��������� ������������ ������ }
  if (SourStr='') or (DestStr='') then showmessage('���� �� ������')
  else
  begin

    NextAct.Action:='������';
    MainForm.pbProgress.Position:=0;
    CompressFile(SourStr, DestStr);
    with NextAct do ProcVal:=OldSize/NewSize;
    WriteInfo;
    MainForm.pbProgress.Position:=90;
    GetAnalys(FreqArr);

  end;
  
end;

{ �������� ��� ���������� ����� }
procedure TMainForm.actDecompressFileExecute(Sender: TObject);

var
  SourStr,DestStr:string;

begin

  MainForm.dlgOpenFile.Filter:='����� (*.hfm*)|*.hfm*';
  dlgSaveFile.DefaultExt:='';
  SetFiles(SourStr,DestStr);

  { �������� ��������� ������������ ������ }
  if (SourStr='') or (DestStr='') then showmessage('���� �� ������')
  else
  begin

    NextAct.Action:='����������';
    MainForm.pbProgress.Position:=0;
    DecompressFile(SourStr, DestStr);
    with NextAct do ProcVal:=NewSize/OldSize;
    WriteInfo;
    MainForm.pbProgress.Position:=90;
    GetAnalys(FreqArr);

  end;

end;

{ �������� ��� �������� ������� ����� }
procedure TMainForm.FormCreate(Sender: TObject);
begin

  with InfoTable do
  begin

    Cells[0,0]:='����';
    Cells[1,0]:='��� ASCII';
    Cells[2,0]:='�������������';

  end;

end;

{ �������� ��� ����������� ����� }
procedure TMainForm.FormShow(Sender: TObject);
begin

  if lblUserName.Caption='Admin' then mniStats.Visible:=true;
  NextAct.Login:=lblUserName.Caption;

end;

{ �������� ��� ������� ������ "� ���������" }
procedure TMainForm.mniAboutProgrClick(Sender: TObject);
begin

  MainForm.Enabled:=false;
  AboutProgrForm.Show;

end;

{ �������� ��� ������� ������ �� (Wiki) }
procedure TMainForm.mniHuffmanWikiClick(Sender: TObject);
begin

  ShellExecute( Handle, 'open',
  'https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%B4_%D0%A5%D0%B0%D1%84%D1%84%D0%BC%D0%B0%D0%BD%D0%B0',
  nil, nil, SW_NORMAL )

end;

{ �������� ��� ������� ������ C����� }
procedure TMainForm.mniHabrTopicClick(Sender: TObject);
begin

  ShellExecute( Handle, 'open',
  'http://algolist.manual.ru/compress/standard/huffman.php', nil,nil,SW_NORMAL )

end;

{ �������� ��� �������� ������� ����� }
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  AuthorForm.Close;

end;

{ �������� ��� ����������� ����� ���������� �������� }
procedure TMainForm.mniStatsClick(Sender: TObject);
begin

  MainForm.Hide;
  StatsForm.Show;

end;

end.
