object frmMain: TfrmMain
  Left = 0
  Top = 0
  ClientHeight = 401
  ClientWidth = 853
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    853
    401)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 4
    Top = 39
    Width = 843
    Height = 323
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyPress = DBGrid1KeyPress
    Columns = <
      item
        DropDownRows = 12
        Expanded = False
        FieldName = 'Tipo'
        PickList.Strings = (
          'Atividade'
          'An'#225'lise T'#233'cnica'
          'An'#225'lise de Regra de Neg'#243'cio'
          'Desenvolvimento'
          'Hist'#243'ria'
          'Reuni'#227'o'
          'Teste Funcional'
          'Teste Unit'#225'rio')
        Width = 128
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Titulo'
        Width = 177
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Width = 414
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TarefaPai'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 3
    Top = 368
    Width = 190
    Height = 25
    Action = actEnviar
    Anchors = [akLeft, akBottom]
    Caption = 'Preparar Para o Redmine (F9)'
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 3
    Top = 8
    Width = 113
    Height = 25
    Action = ActDuplicar
    Caption = 'Duplicar (Ctrl+D)'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object Button2: TButton
    Left = 747
    Top = 5
    Width = 99
    Height = 25
    Action = actConfigurar
    Anchors = [akTop, akRight]
    TabOrder = 3
  end
  object Button3: TButton
    Left = 639
    Top = 5
    Width = 102
    Height = 25
    Action = actImportar
    Anchors = [akTop, akRight]
    TabOrder = 4
  end
  object ComboBoxTipoPadrao: TComboBox
    Left = 122
    Top = 8
    Width = 145
    Height = 21
    TabOrder = 5
  end
  object chAlterarTipo: TCheckBox
    Left = 273
    Top = 8
    Width = 97
    Height = 17
    Caption = 'Alterar o tipo'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object FDMemTable1: TFDMemTable
    Active = True
    AfterScroll = FDMemTable1AfterScroll
    FieldDefs = <
      item
        Name = 'Tipo'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Titulo'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'Descricao'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'Gerado'
        DataType = ftBoolean
      end
      item
        Name = 'TarefaPai'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 48
    Top = 80
    Content = {
      414442530F000000CA020000FF00010001FF02FF03040016000000460044004D
      0065006D005400610062006C006500310005000A0000005400610062006C0065
      00060000000000070000080032000000090000FF0AFF0B040008000000540069
      0070006F000500080000005400690070006F000C00010000000E000D000F0014
      0000001000011100011200011300011400011500011600080000005400690070
      006F00170014000000FEFF0B04000C00000054006900740075006C006F000500
      0C00000054006900740075006C006F000C00020000000E000D000F0028000000
      10000111000112000113000114000115000116000C0000005400690074007500
      6C006F00170028000000FEFF0B04001200000044006500730063007200690063
      0061006F00050012000000440065007300630072006900630061006F000C0003
      0000000E000D000F00F401000010000111000112000113000114000115000116
      0012000000440065007300630072006900630061006F001700F4010000FEFF0B
      04000C000000470065007200610064006F0005000C0000004700650072006100
      64006F000C00040000000E001800100001110001120001130001140001150001
      16000C000000470065007200610064006F00FEFF0B0400120000005400610072
      0065006600610050006100690005001200000054006100720065006600610050
      00610069000C00050000000E0019001000011100011200011300011400011500
      01160012000000540061007200650066006100500061006900FEFEFF1AFEFF1B
      FEFF1CFF1D1E000000000020001F00FF2100000F000000446573656E766F6C76
      696D656E746F010011000000546172656661206465204578656D706C6F020028
      000000446573637269E7E36F20446574616C6861646120646120546172656661
      206465204578656D706C6F03000000040000000000FEFEFEFEFEFF22FEFF2324
      0002000000FF25FEFEFE0E004D0061006E0061006700650072001E0055007000
      6400610074006500730052006500670069007300740072007900120054006100
      62006C0065004C006900730074000A005400610062006C00650008004E006100
      6D006500140053006F0075007200630065004E0061006D0065000A0054006100
      620049004400240045006E0066006F0072006300650043006F006E0073007400
      7200610069006E00740073001E004D0069006E0069006D0075006D0043006100
      700061006300690074007900180043006800650063006B004E006F0074004E00
      75006C006C00140043006F006C0075006D006E004C006900730074000C004300
      6F006C0075006D006E00100053006F0075007200630065004900440018006400
      740041006E007300690053007400720069006E00670010004400610074006100
      54007900700065000800530069007A0065001400530065006100720063006800
      610062006C006500120041006C006C006F0077004E0075006C006C0008004200
      61007300650014004F0041006C006C006F0077004E0075006C006C0012004F00
      49006E0055007000640061007400650010004F0049006E005700680065007200
      65001A004F0072006900670069006E0043006F006C004E0061006D0065001400
      53006F007500720063006500530069007A00650012006400740042006F006F00
      6C00650061006E000E006400740049006E007400330032001C0043006F006E00
      730074007200610069006E0074004C0069007300740010005600690065007700
      4C006900730074000E0052006F0077004C00690073007400060052006F007700
      0A0052006F0077004900440016007200730055006E006300680061006E006700
      650064001A0052006F0077005000720069006F00720053007400610074006500
      10004F0072006900670069006E0061006C001800520065006C00610074006900
      6F006E004C006900730074001C0055007000640061007400650073004A006F00
      750072006E0061006C001200530061007600650050006F0069006E0074000E00
      4300680061006E00670065007300}
    object FDMemTable1Tipo: TStringField
      DisplayWidth = 20
      FieldName = 'Tipo'
    end
    object FDMemTable1Titulo: TStringField
      DisplayWidth = 40
      FieldName = 'Titulo'
      Size = 40
    end
    object FDMemTable1Descricao: TStringField
      DisplayWidth = 47
      FieldName = 'Descricao'
      Size = 500
    end
    object FDMemTable1Gerado: TBooleanField
      DisplayWidth = 5
      FieldName = 'Gerado'
    end
    object FDMemTable1TarefaPai: TIntegerField
      FieldName = 'TarefaPai'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 64
    Top = 160
  end
  object MainMenu1: TMainMenu
    Left = 56
    Top = 256
    object Editar1: TMenuItem
      Caption = 'Editar'
      object Criarapartirdeumalista1: TMenuItem
        Caption = 'Criar a partir de uma lista'
      end
    end
  end
  object ActionList1: TActionList
    Left = 296
    Top = 328
    object ActDuplicar: TAction
      Caption = 'Duplicar'
      ShortCut = 16452
      OnExecute = ActDuplicarExecute
    end
    object actEnviar: TAction
      Caption = 'Enviar (F9)'
      ShortCut = 120
      OnExecute = actEnviarExecute
    end
    object actImportar: TAction
      Caption = 'Importar (F11)'
      ShortCut = 122
      OnExecute = actImportarExecute
    end
    object actConfigurar: TAction
      Caption = 'Configurar (F12)'
      ShortCut = 123
      OnExecute = actConfigurarExecute
    end
  end
end
