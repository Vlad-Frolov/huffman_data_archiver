object SearchForm: TSearchForm
  Left = 642
  Top = 282
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 135
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object edtFindWord: TEdit
    Left = 8
    Top = 8
    Width = 129
    Height = 21
    TabOrder = 0
  end
  object chkIncl1: TCheckBox
    Left = 8
    Top = 40
    Width = 97
    Height = 17
    Caption = #1051#1086#1075#1080#1085
    TabOrder = 1
  end
  object chkIncl2: TCheckBox
    Left = 8
    Top = 64
    Width = 97
    Height = 17
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077
    TabOrder = 2
  end
  object chkIncl3: TCheckBox
    Left = 8
    Top = 88
    Width = 121
    Height = 17
    Caption = #1057#1090#1072#1088#1086#1077' '#1080#1084#1103' '#1092#1072#1081#1083#1072
    TabOrder = 3
  end
  object chkIncl4: TCheckBox
    Left = 8
    Top = 112
    Width = 121
    Height = 17
    Caption = #1053#1086#1074#1086#1077' '#1080#1084#1103' '#1092#1072#1081#1083#1072
    TabOrder = 4
  end
  object chkIncl5: TCheckBox
    Left = 136
    Top = 40
    Width = 65
    Height = 17
    Caption = #1042#1088#1077#1084#1103
    TabOrder = 5
  end
  object btnGoFind: TButton
    Left = 152
    Top = 8
    Width = 113
    Height = 25
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 6
    OnClick = btnGoFindClick
  end
  object chkIncl7: TCheckBox
    Left = 136
    Top = 64
    Width = 145
    Height = 17
    Caption = #1057#1090#1072#1088#1099#1081' '#1088#1072#1079#1084#1077#1088' '#1092#1072#1081#1083#1072
    TabOrder = 7
  end
  object chkIncl8: TCheckBox
    Left = 136
    Top = 88
    Width = 145
    Height = 17
    Caption = #1053#1086#1074#1099#1081' '#1088#1072#1079#1084#1077#1088' '#1092#1072#1081#1083#1072
    TabOrder = 8
  end
  object chkIncl9: TCheckBox
    Left = 136
    Top = 112
    Width = 97
    Height = 17
    Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090
    TabOrder = 9
  end
  object chkIncl6: TCheckBox
    Left = 216
    Top = 40
    Width = 97
    Height = 17
    Caption = #1044#1072#1090#1072
    TabOrder = 10
  end
end
