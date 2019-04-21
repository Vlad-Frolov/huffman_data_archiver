program HuffmanArchivator;

uses
  Forms,
  HuffPackage in 'HuffPackage.pas' {MainForm},
  ArchivatorElements in 'ArchivatorElements.pas',
  ChangedAction in 'ChangedAction.pas',
  Compression in 'Compression.pas',
  Compressor in 'Compressor.pas',
  Decompression in 'Decompression.pas',
  Authorization in 'Authorization.pas' {AuthorForm},
  AuthorController in 'AuthorController.pas',
  StatsForAdmin in 'StatsForAdmin.pas' {StatsForm},
  AboutProgr in 'AboutProgr.pas' {AboutProgrForm},
  AdmEditForm in 'AdmEditForm.pas' {EditForm},
  SearchRecords in 'SearchRecords.pas' {SearchForm};

begin
  Application.Initialize;
  Application.CreateForm(TAuthorForm, AuthorForm);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TStatsForm, StatsForm);
  Application.CreateForm(TAboutProgrForm, AboutProgrForm);
  Application.CreateForm(TEditForm, EditForm);
  Application.CreateForm(TSearchForm, SearchForm);
  Application.Run;
end.
