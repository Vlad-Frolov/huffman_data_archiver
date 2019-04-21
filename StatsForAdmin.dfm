object StatsForm: TStatsForm
  Left = 399
  Top = 203
  BorderStyle = bsToolWindow
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
  ClientHeight = 443
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatsGrid: TStringGrid
    Left = 0
    Top = 40
    Width = 809
    Height = 401
    ColCount = 10
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 0
    ColWidths = (
      68
      67
      105
      106
      60
      64
      117
      115
      93
      64)
  end
  object btnDeleteRec: TButton
    Left = 320
    Top = 8
    Width = 113
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
    TabOrder = 1
    OnClick = btnDeleteRecClick
  end
  object btnEditRec: TButton
    Left = 440
    Top = 8
    Width = 129
    Height = 25
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
    TabOrder = 2
    OnClick = btnEditRecClick
  end
  object btnDeleteUser: TButton
    Left = 176
    Top = 8
    Width = 137
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    TabOrder = 3
    OnClick = btnDeleteUserClick
  end
  object btnSaveInfo: TButton
    Left = 8
    Top = 8
    Width = 89
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 4
    OnClick = btnSaveInfoClick
  end
  object edtDelUser: TEdit
    Left = 104
    Top = 8
    Width = 65
    Height = 21
    TabOrder = 5
  end
  object cbbSortBy: TComboBoxEx
    Left = 576
    Top = 8
    Width = 145
    Height = 22
    ItemsEx.SortType = stText
    ItemsEx = <
      item
        Caption = #1044#1072#1090#1072' ('#1089#1085#1072#1095#1072#1083#1072' '#1085#1086#1074#1099#1077')'
      end
      item
        Caption = #1044#1072#1090#1072' ('#1089#1085#1072#1095#1072#1083#1072' '#1089#1090#1072#1088#1099#1077')'
      end
      item
        Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' (A-Z)'
      end
      item
        Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' (Z-A)'
      end
      item
        Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' (Max-Min)'
      end
      item
        Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' (Min-Max)'
      end
      item
        Caption = #1051#1086#1075#1080#1085' (A-Z)'
      end
      item
        Caption = #1051#1086#1075#1080#1085' (Z-A)'
      end>
    ItemHeight = 16
    TabOrder = 6
    Text = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086
    OnSelect = cbbSortBySelect
    DropDownCount = 8
  end
  object btnSearchRec: TButton
    Left = 728
    Top = 8
    Width = 75
    Height = 25
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 7
    OnClick = btnSearchRecClick
  end
end
