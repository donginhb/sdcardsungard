inherited faqhReadPASMCard: TfaqhReadPASMCard
  Width = 626
  Height = 547
  inherited UIPanel1: TUIPanel
    Top = 496
    Width = 626
    Height = 51
    TabOrder = 3
    inherited btnQuery: TBitBtn
      Left = 526
      Top = 43
      Width = 94
      Hint = '发行授权卡'
      Caption = '发行授权卡'
      TabOrder = 2
      Visible = False
      Glyph.Data = {00000000}
    end
    inherited btnPrint: TBitBtn
      Left = 360
      Top = 43
      Visible = False
    end
    object StatusBar: TRzStatusBar
      Left = 0
      Top = 30
      Width = 626
      Height = 21
      AutoStyle = False
      BorderColor = clWindow
      BorderInner = fsNone
      BorderOuter = fsNone
      BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
      BorderWidth = 0
      Color = 16184303
      FlatColor = 15458000
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object RzStatusPane1: TRzStatusPane
        Left = 0
        Top = 0
        Width = 626
        Height = 21
        FrameStyle = fsStatus
        Align = alClient
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited UIPnlQueryCount: TUIPanel
    Width = 626
    inherited Image1: TImage
      Width = 626
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 18
    Width = 626
    Height = 478
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object grp1: TGroupBox
      Left = 184
      Top = 72
      Width = 401
      Height = 353
      Caption = 'PSAM卡信息'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object RzStatusPane2: TRzStatusPane
        Left = 13
        Top = 218
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = '启用日期'
      end
      object RzStatusPane3: TRzStatusPane
        Left = 13
        Top = 250
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = '有效日期'
      end
      object rzstspn3: TRzStatusPane
        Left = 13
        Top = 26
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = 'PSAM卡号'
      end
      object rzstspn4: TRzStatusPane
        Left = 13
        Top = 58
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = 'PSAM卡版本号'
      end
      object rzstspn5: TRzStatusPane
        Left = 13
        Top = 90
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = 'PSAM卡类型'
      end
      object rzstspn6: TRzStatusPane
        Left = 13
        Top = 122
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = '终端编号'
      end
      object rzstspn7: TRzStatusPane
        Left = 13
        Top = 154
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = '终端交易序号'
      end
      object rzstspn8: TRzStatusPane
        Left = 13
        Top = 186
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = '密钥索引号'
      end
      object rzstspn9: TRzStatusPane
        Left = 13
        Top = 282
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = '发行方标识'
      end
      object rzstspn10: TRzStatusPane
        Left = 13
        Top = 314
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Alignment = taRightJustify
        Caption = '使用方标识'
      end
      object edtLimitDate: TRzEdit
        Left = 136
        Top = 251
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
      end
      object edtBeginDate: TRzEdit
        Left = 136
        Top = 219
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
      object edtCardNo: TRzEdit
        Left = 136
        Top = 27
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtVer: TRzEdit
        Left = 136
        Top = 59
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object edtCardType: TRzEdit
        Left = 136
        Top = 91
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object edtTermID: TRzEdit
        Left = 136
        Top = 123
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object edtTermSeqno: TRzEdit
        Left = 136
        Top = 155
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object edtkeyNo: TRzEdit
        Left = 136
        Top = 187
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
      object edtPubSign: TRzEdit
        Left = 136
        Top = 283
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
      end
      object edtUser: TRzEdit
        Left = 136
        Top = 315
        Width = 197
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
      end
    end
    object btnReadPASM: TBitBtn
      Left = 387
      Top = 435
      Width = 94
      Height = 25
      Hint = 'PASM卡读取'
      Caption = 'PSAM卡读取'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnReadPASMClick
    end
    object btnSaveLib: TBitBtn
      Left = 491
      Top = 435
      Width = 94
      Height = 25
      Hint = '保存psam卡信息到数据库'
      Caption = '保  存(&S)'
      Enabled = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnSaveLibClick
    end
  end
  inherited UIPanel2: TUIPanel
    Left = 624
    Top = 416
    Width = 76
    Height = 22
    Align = alNone
    TabOrder = 2
    Visible = False
    inherited Grid: TRzDBGrid
      Align = alNone
      DataSource = nil
      Columns = <
        item
          Expanded = False
          FieldName = 'lvol0'
          PickList.Strings = ()
          Title.Caption = '交易卡号'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_limit'
          PickList.Strings = ()
          Title.Caption = '操作员号'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sdate2'
          PickList.Strings = ()
          Title.Caption = '有效期'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lvol1'
          PickList.Strings = ()
          Title.Caption = '卡权限位'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sbank_acc'
          PickList.Strings = ()
          Title.Caption = '工作密钥'
          Visible = True
        end>
    end
  end
  inherited WorkView: TWorkView
    WorkFields = <
      item
        Name = '返回码'
        Caption = '返回码'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '返回信息'
        Caption = '返回信息'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '启用日期'
        Caption = '启用日期'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '有效日期'
        Caption = '有效日期'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '设备使用方'
        Caption = '设备使用方'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '操作标志'
        Caption = '操作标志'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '卡类型'
        Caption = '卡类型'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '终端编号'
        Caption = '终端编号'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end>
    FieldsMonitors = <
      item
        MonitorValueChangedFields = '|操作员号|物理卡号|授权卡权限|业务操作员|有效期|'
      end>
    Left = 52
    Top = 55
  end
  inherited MainRequest: TWVRequest
    ID = 'PASM卡发行'
    Bindings = <
      item
        ParamName = '返回码'
        FieldName = '返回码'
        Direction = bdParam2Field
      end
      item
        ParamName = '返回信息'
        FieldName = '返回信息'
        Direction = bdParam2Field
      end
      item
        ParamName = '启用日期'
        FieldName = '启用日期'
      end
      item
        ParamName = '有效日期'
        FieldName = '有效日期'
      end
      item
        ParamName = '设备使用方'
        FieldName = '设备使用方'
      end
      item
        ParamName = '操作标志'
        FieldName = '操作标志'
      end
      item
        ParamName = '卡类型'
        FieldName = '卡类型'
      end
      item
        ParamName = '终端编号'
        FieldName = '终端编号'
      end>
    Left = 88
    Top = 56
  end
  inherited WVDBBinder: TWVDBBinder
    FieldName = '查询结果集'
    Left = 88
    Top = 96
  end
  inherited DataSource: TDataSource
    Left = 128
    Top = 96
  end
end
