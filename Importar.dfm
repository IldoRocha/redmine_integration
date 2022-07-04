object frmImportar: TfrmImportar
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Importar'
  ClientHeight = 359
  ClientWidth = 638
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    638
    359)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 324
    Width = 457
    Height = 27
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 
      'Utilize o caractere PIPE " | " para separar a descri'#231#227'o curta da' +
      ' descri'#231#227'o longa Quando n'#227'o possuir PIPE a descri'#231#227'o curta ser'#225' ' +
      'a mesma da descri'#231#227'o longa.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsItalic]
    ParentFont = False
    WordWrap = True
  end
  object edtCaminhoArquivo: TEdit
    Left = 8
    Top = 8
    Width = 586
    Height = 21
    TabOrder = 0
    TextHint = 'Caminho do arquivo .txt'
  end
  object Button1: TButton
    Left = 595
    Top = 6
    Width = 27
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ListaTxt: TMemo
    Left = 8
    Top = 64
    Width = 619
    Height = 256
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Exemplo de tarefa|Exemplo de tarefa Descri'#231#227'o Longa')
    TabOrder = 2
    ExplicitHeight = 254
  end
  object Button2: TButton
    Left = 552
    Top = 326
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Importar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
    ExplicitTop = 324
  end
  object Button3: TButton
    Left = 471
    Top = 326
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = Button3Click
    ExplicitTop = 324
  end
  object Button4: TButton
    Left = 8
    Top = 33
    Width = 75
    Height = 26
    Caption = 'Limpar'
    TabOrder = 5
    OnClick = Button4Click
  end
  object dlgImportar: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Listas simples|*.txt'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Importar uma lista simples de texto'
    Left = 224
    Top = 128
  end
end
