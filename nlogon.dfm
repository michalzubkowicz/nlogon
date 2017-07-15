object logon: Tlogon
  Left = 322
  Top = 321
  HorzScrollBar.Visible = False
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Logowanie do systemu'
  ClientHeight = 114
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = LoadConfig
  OnDestroy = BeforeExit
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 98
    Height = 13
    Caption = 'Nazwa u'#380'ytkownika:'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 29
    Height = 13
    Caption = 'Has'#322'o'
  end
  object Label4: TLabel
    Left = 326
    Top = 97
    Width = 51
    Height = 12
    Cursor = crHandPoint
    Caption = 'O programie'
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = [fsUnderline]
    ParentColor = False
    ParentFont = False
    OnClick = Info
  end
  object Ok: TButton
    Left = 288
    Top = 24
    Width = 97
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = OkClick
  end
  object Cancel: TButton
    Left = 288
    Top = 64
    Width = 97
    Height = 25
    Caption = 'Anuluj'
    TabOrder = 2
    OnClick = CancelClick
  end
  object username_edit: TEdit
    Left = 8
    Top = 24
    Width = 265
    Height = 21
    Color = clWhite
    MaxLength = 40
    OEMConvert = True
    TabOrder = 3
  end
  object password_edit: TEdit
    Left = 8
    Top = 64
    Width = 265
    Height = 21
    MaxLength = 40
    OEMConvert = True
    PasswordChar = '*'
    TabOrder = 0
  end
  object XPManifest1: TXPManifest
    Left = 112
    Top = 88
  end
end
