unit SearchRecords;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSearchForm = class(TForm)
    edtFindWord: TEdit;
    chkIncl1: TCheckBox;
    chkIncl2: TCheckBox;
    chkIncl3: TCheckBox;
    chkIncl4: TCheckBox;
    chkIncl5: TCheckBox;
    btnGoFind: TButton;
    chkIncl7: TCheckBox;
    chkIncl8: TCheckBox;
    chkIncl9: TCheckBox;
    chkIncl6: TCheckBox;
    procedure btnGoFindClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SearchForm: TSearchForm;
  FoundRow: Word =1;
  FoundCell: word = 0;

implementation

{$R *.dfm}

Uses
  StatsForAdmin;

procedure TSearchForm.btnGoFindClick(Sender: TObject);

const
  BoxCount = 9;


var
  i,j: word;
  SetFound: set of Byte;

begin

  SetFound:=[];

  if chkIncl1.Checked then SetFound:=SetFound+[0];
  if chkIncl2.Checked then SetFound:=SetFound+[1];
  if chkIncl3.Checked then SetFound:=SetFound+[2];
  if chkIncl4.Checked then SetFound:=SetFound+[3];
  if chkIncl5.Checked then SetFound:=SetFound+[4];
  if chkIncl6.Checked then SetFound:=SetFound+[5];
  if chkIncl7.Checked then SetFound:=SetFound+[6];
  if chkIncl8.Checked then SetFound:=SetFound+[7];
  if chkIncl9.Checked then SetFound:=SetFound+[8];

  with StatsForm do
  for i:=FoundRow to StatsGrid.RowCount-1 do
  begin

    for j:=FoundCell to BoxCount do
    if j in SetFound then
      if Pos(edtFindWord.Text,StatsGrid.Cells[j,i])<>0 then
      begin

        if FoundCell=5 then
        begin

          FoundCell:=0;
          FoundRow:=i+1;

        end
        else inc(FoundCell);
        ShowMessage('Найдено совпадение!');
        StatsGrid.Row:=i;
        Exit;

      end;

    FoundRow:=i+1;
    FoundCell:=0;

  end;
  ShowMessage('Не найдено более совпадений!');
  FoundRow:=1;
  FoundCell:=0;

end;

procedure TSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FoundRow:=1;

end;

end.
