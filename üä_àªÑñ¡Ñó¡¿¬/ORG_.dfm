object Form1: TForm1
  Left = 237
  Top = 130
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1041#1044' '#1045#1078#1077#1076#1085#1077#1074#1085#1080#1082
  ClientHeight = 321
  ClientWidth = 757
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000BB333333333333333300000000000000B0000000000000000300000000000
    000B7FF6FFFFFFFFFFF0300000000000000B7FF6FFFFFFFFFFF0300000000000
    000B7666666666666660300000000000000B7FF6FFFFFFFFFFF0300000000000
    000B7FF6FFFFFFFFFFF0300000000000000B7666666666666660300000000000
    000B7FF6FFFFFFFFFFF0300000000000000B7FF6FFFFFFFFFFF0300000000000
    000B7666666666666660300000000000000B7FF6FFFFFFFFFFF0300000000000
    000B7FF6FFFFFFFFFFF0300000000000000B7666666666666660300000000000
    000B7FF6FFFFFFFFFFF0300000000000000B7FF6FFFFFFFFFFF0300000000000
    000B7666666666666660300000000000000B7FF6FFFFFFFFFFF0300000000000
    000B7FF6FFFFFFFFFFF0300000000000000B7FF68888888888F0300000000000
    000B7FF00000000008F0300000000000000B7770FF8888770770B00000000000
    000BBBBB0FF88770BBBBB000000000000000000000F887000000000000000000
    000000000FF88870000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFE00007FFC00003FFC00003FFC00003FFC00003FFC00
    003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00
    003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00
    003FFC00003FFC00003FFE00007FFFF00FFFFFF81FFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 54
    Height = 20
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 41
    Width = 48
    Height = 16
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 72
    Width = 737
    Height = 209
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Data'
        Title.Caption = #1050#1086#1075#1076#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsItalic]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'What'
        Title.Caption = #1063#1090#1086
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsItalic]
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 360
    Top = 288
    Width = 129
    Height = 25
    Caption = #1057#1083#1077#1076'. '#1085#1077#1076#1077#1083#1103
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 288
    Width = 105
    Height = 25
    Caption = #1057#1077#1075#1086#1076#1085#1103
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 120
    Top = 288
    Width = 113
    Height = 25
    Caption = #1047#1072#1074#1090#1088#1072
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 240
    Top = 288
    Width = 113
    Height = 25
    Caption = #1069#1090#1072' '#1085#1077#1076#1077#1083#1103
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 496
    Top = 287
    Width = 249
    Height = 26
    Caption = #1042#1089#1077' '#1079#1072#1076#1072#1085#1080#1103
    TabOrder = 5
    OnClick = Button5Click
  end
  object DBNavigator1: TDBNavigator
    Left = 416
    Top = 24
    Width = 330
    Height = 26
    DataSource = DataSource1
    TabOrder = 6
  end
  object Table1: TTable
    DatabaseName = 'diary'
    TableName = 'diary.DB'
    Left = 152
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 216
    Top = 120
  end
  object Query1: TQuery
    DatabaseName = 'diary'
    SQL.Strings = (
      'SELECT DISTINCT  Data, What'
      'FROM "diary" '
      'WHERE'
      '(Data = '#39'03.02.2002'#39')'
      'ORDER BY  Data, What')
    Left = 184
    Top = 120
  end
end
