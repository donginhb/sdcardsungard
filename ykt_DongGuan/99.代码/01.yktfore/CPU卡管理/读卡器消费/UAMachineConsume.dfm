inherited faqhMachineConsume: TfaqhMachineConsume
  Width = 655
  Height = 453
  inherited UIPanel1: TUIPanel
    Top = 18
    Width = 655
    Height = 435
    Align = alClient
    Anchors = [akLeft, akTop]
    Color = 16184303
    object RzStatusPane2: TRzStatusPane [0]
      Left = 0
      Top = 414
      Width = 655
      Height = 21
      FrameStyle = fsStatus
      Align = alBottom
      Color = 16184303
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    inherited btnQuery: TBitBtn
      Left = 30
      Top = 419
      TabOrder = 5
      Visible = False
    end
    inherited btnPrint: TBitBtn
      Left = 32
      Top = 371
      Caption = '重打回执'
      Enabled = True
      TabOrder = 2
      Visible = False
      Glyph.Data = {00000000}
    end
    object btnReadCardInfo: TBitBtn
      Left = 280
      Top = 339
      Width = 105
      Height = 25
      Hint = '读取卡信息'
      Caption = '读卡信息(&R)'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnReadCardInfoClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF00FFFFFF007B7B
        7B007B7B7B007B7B7B00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF007B7B
        7B007B7B7B007B7B7B007B7B7B00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF00FFFFFF007B7B
        7B007B7B7B007B7B7B00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF007B7B
        7B007B7B7B00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FF000000FF000000FF000000FF000000FF000000FFFFFF007B7B
        7B007B7B7B007B7B7B00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
        00000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF007B7B
        7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
        7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    end
    object grp1: TGroupBox
      Left = 184
      Top = 72
      Width = 401
      Height = 193
      Caption = '读卡信息'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object WVLabel5: TWVLabel
        Left = 300
        Top = 128
        Width = 14
        Height = 14
        Caption = '元'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object WVLabel10: TWVLabel
        Left = 300
        Top = 160
        Width = 14
        Height = 14
        Caption = '元'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object RzStatusPane1: TRzStatusPane
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
        Caption = '姓    名'
      end
      object RzStatusPane3: TRzStatusPane
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
        Caption = '应用序列号'
      end
      object RzStatusPane4: TRzStatusPane
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
        Caption = '证件号码'
      end
      object RzStatusPane5: TRzStatusPane
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
        Caption = '消费前余额'
      end
      object RzStatusPane6: TRzStatusPane
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
        Caption = '消费后余额'
      end
      object edtName: TRzEdit
        Left = 132
        Top = 27
        Width = 161
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtCardNo: TRzEdit
        Left = 132
        Top = 59
        Width = 161
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object edtStuempNo: TRzEdit
        Left = 132
        Top = 91
        Width = 161
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object edtCardMoney: TRzEdit
        Left = 132
        Top = 123
        Width = 161
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object edtAfterMoney: TRzEdit
        Left = 132
        Top = 155
        Width = 161
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        FrameVisible = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
    end
    object grp2: TGroupBox
      Left = 184
      Top = 272
      Width = 401
      Height = 57
      Caption = '消费信息'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object WVLabel3: TWVLabel
        Left = 297
        Top = 25
        Width = 14
        Height = 14
        Caption = '元'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object RzStatusPane7: TRzStatusPane
        Left = 13
        Top = 20
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
        Caption = '消费金额'
      end
      object RzStatusPane8: TRzStatusPane
        Left = 29
        Top = 107
        Width = 116
        Height = 24
        FrameStyle = fsStatus
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        Visible = False
        Alignment = taRightJustify
        Caption = '卡/票据号'
      end
      object lblTip: TLabel
        Left = 13
        Top = 113
        Width = 66
        Height = 19
        Caption = 'lblTip'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = '宋体'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object edtmoney: TWVDigitalEdit
        Left = 134
        Top = 21
        Width = 158
        Height = 21
        AllowPoint = True
        Precision = 2
        Color = clWindow
        ParentColor = False
        TabOrder = 0
        TabStop = True
        Text = '0'
        OnKeyDown = edtmoneyKeyDown
        WorkView = WorkView
        FieldName = '充值金额'
      end
      object chkSaveMoney: TCheckBox
        Left = 312
        Top = 24
        Width = 75
        Height = 17
        Caption = '保留金额'
        TabOrder = 1
      end
    end
    object btnMoneyIn: TBitBtn
      Left = 397
      Top = 339
      Width = 95
      Height = 25
      Hint = '校园卡充值'
      Caption = '消 费(&C)'
      Enabled = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnMoneyInClick
    end
    object chkPrint: TCheckBox
      Left = 200
      Top = 344
      Width = 73
      Height = 17
      Caption = '打印回单'
      Checked = True
      State = cbChecked
      TabOrder = 6
      Visible = False
    end
    object btnRePrint: TBitBtn
      Left = 501
      Top = 339
      Width = 84
      Height = 25
      Hint = '重打回执'
      Caption = '重打回执(P)'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = btnRePrintClick
    end
  end
  inherited UIPnlQueryCount: TUIPanel
    Width = 655
    inherited Image1: TImage
      Width = 655
    end
    inherited LabRecordCount: TLabel
      Visible = False
    end
  end
  inherited UIPanel2: TUIPanel
    Left = 8
    Top = 360
    Width = 73
    Height = 17
    Align = alNone
    Visible = False
    inherited Grid: TRzDBGrid
      Left = 56
      Top = 464
      Width = 233
      Height = 41
      Align = alNone
      Visible = False
      Columns = <
        item
          Expanded = False
          FieldName = 'sname'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '姓名'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_type'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '性别'
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_auth'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '学/工号'
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lvol2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '客户号'
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lvol1'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '客户状态'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lvol0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '客户类别'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lvol5'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '收费类别'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lvol3'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '卡标识'
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'damt0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '总余额'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'damt1'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '可用余额'
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'damt2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '冻结余额'
          Width = 94
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sstation0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '帐号'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_no2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '密码'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'scust_no'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '单位'
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_auth2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '注册时间'
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sphone'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '联系电话'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sname2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '身份证号'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sphone3'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '截至时间'
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'damt3'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '卡成本费'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'snote'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '卡信息备注'
          Width = 86
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
        DataField = '@Return'
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
        DataField = 'vsmess'
      end
      item
        Name = '交易标志'
        Caption = '交易标志'
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
        Name = '交易日期'
        Caption = '交易日期'
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
        Name = '交易时间'
        Caption = '交易时间'
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
        Name = 'sam终端号'
        Caption = 'sam终端号'
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
        Name = 'sam流水号'
        Caption = 'sam流水号'
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
        Name = '应用序列号'
        Caption = '应用序列号'
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
        Name = '物理卡号'
        Caption = '物理卡号'
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
        Name = '充值次数'
        Caption = '充值次数'
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
        Name = '消费次数'
        Caption = '消费次数'
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
        Name = '消费金额'
        Caption = '消费金额'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtFloat
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '卡余额'
        Caption = '卡余额'
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
        Name = '记账日期'
        Caption = '记账日期'
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
        Name = '交易参考号'
        Caption = '交易参考号'
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
        Name = '出卡值'
        Caption = '出卡值'
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
        Name = '卡类型'
        Caption = '卡类型'
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
        Name = '姓名'
        Caption = '姓名'
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
        Name = '手机'
        Caption = '手机'
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
        Name = '记账时间'
        Caption = '记账时间'
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
        Name = '卡号'
        Caption = '卡号'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end>
    FieldsMonitors = <
      item
        MonitorValueChangedFields = '|客户号|学工号|卡号|姓名|身份证号|'
      end>
    Left = 44
    Top = 79
  end
  inherited MainRequest: TWVRequest
    ID = '读卡器消费'
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
        ParamName = '交易标志'
        FieldName = '交易标志'
      end
      item
        ParamName = '交易日期'
        FieldName = '交易日期'
      end
      item
        ParamName = '交易时间'
        FieldName = '交易时间'
      end
      item
        ParamName = 'sam终端号'
        FieldName = 'sam终端号'
      end
      item
        ParamName = 'sam流水号'
        FieldName = 'sam流水号'
      end
      item
        ParamName = '应用序列号'
        FieldName = '应用序列号'
      end
      item
        ParamName = '物理卡号'
        FieldName = '物理卡号'
      end
      item
        ParamName = '充值次数'
        FieldName = '充值次数'
      end
      item
        ParamName = '消费次数'
        FieldName = '消费次数'
      end
      item
        ParamName = '消费金额'
        FieldName = '消费金额'
      end
      item
        ParamName = '卡余额'
        FieldName = '卡余额'
      end
      item
        ParamName = '记账日期'
        FieldName = '记账日期'
        Direction = bdParam2Field
      end
      item
        ParamName = '交易参考号'
        FieldName = '交易参考号'
        Direction = bdParam2Field
      end
      item
        ParamName = '出卡值'
        FieldName = '出卡值'
        Direction = bdParam2Field
      end
      item
        ParamName = '卡类型'
        FieldName = '卡类型'
        Direction = bdParam2Field
      end
      item
        ParamName = '姓名'
        FieldName = '姓名'
        Direction = bdParam2Field
      end
      item
        ParamName = '手机'
        FieldName = '手机'
        Direction = bdParam2Field
      end
      item
        ParamName = '记账时间'
        FieldName = '记账时间'
        Direction = bdParam2Field
      end
      item
        ParamName = '卡号'
        FieldName = '卡号'
        Direction = bdParam2Field
      end>
    Left = 80
    Top = 80
  end
  inherited WVDBBinder: TWVDBBinder
    FieldName = '查询结果集'
    Left = 40
    Top = 424
  end
  inherited DataSource: TDataSource
    Left = 72
    Top = 424
  end
  object WorkView1: TWorkView
    WorkFields = <
      item
        Name = '返回码'
        Caption = '返回码'
        FieldType = wftUndefined
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DataField = '@Return'
      end
      item
        Name = '返回信息'
        Caption = '返回信息'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DataField = 'vsmess'
      end
      item
        Name = '查询结果集'
        Caption = '查询结果集'
        FieldType = wftUndefined
        DataType = kdtObject
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DataField = '@Dataset'
      end
      item
        Name = '客户号'
        Caption = '客户号'
        FieldType = wftUndefined
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.DefaultValid = False
        Checker.AcceptAlphabet = False
        Checker.AcceptOther = False
        Checker.AcceptHigh = False
        Checker.LowerCase = False
        Checker.UpperCase = False
        GetPrevChar = '*'
      end
      item
        Name = '学工号'
        Caption = '学工号'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '客户姓名'
        Caption = '客户姓名'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '部门'
        Caption = '部门'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '证件类型'
        Caption = '证件类型'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '证件号码'
        Caption = '证件号码'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '客户类别'
        Caption = '客户类别'
        FieldType = wftUndefined
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '收费类别'
        Caption = '收费类别'
        FieldType = wftUndefined
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '所属区域'
        Caption = '所属区域'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '显示卡号'
        Caption = '显示卡号'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '导入批次号'
        Caption = '导入批次号'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '注销日期'
        Caption = '注销日期'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '卡号'
        Caption = '卡号'
        FieldType = wftUndefined
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.DefaultValid = False
        Checker.AcceptAlphabet = False
        Checker.AcceptOther = False
        Checker.AcceptHigh = False
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '钱包号'
        Caption = '钱包号'
        FieldType = wftUndefined
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DataField = 'lvol3'
      end
      item
        Name = '物理卡号'
        Caption = '物理卡号'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end>
    WorkProcesses = <>
    FieldsMonitors = <
      item
        MonitorValueChangedFields = '|客户号|学工号|卡号|姓名|身份证号|'
      end>
    Left = 44
    Top = 111
  end
  object WVRequest1: TWVRequest
    WorkView = WorkView1
    ID = '已开卡客户信息查询'
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
        ParamName = '查询结果集'
        FieldName = '查询结果集'
        Direction = bdParam2Field
      end
      item
        ParamName = '客户号'
        FieldName = '客户号'
      end
      item
        ParamName = '部门'
        FieldName = '部门'
      end
      item
        ParamName = '导入批次号'
        FieldName = '导入批次号'
      end
      item
        ParamName = '客户类别'
        FieldName = '客户类别'
      end
      item
        ParamName = '客户姓名'
        FieldName = '客户姓名'
      end
      item
        ParamName = '收费类别'
        FieldName = '收费类别'
      end
      item
        ParamName = '所属区域'
        FieldName = '所属区域'
      end
      item
        ParamName = '学工号'
        FieldName = '学工号'
      end
      item
        ParamName = '证件号码'
        FieldName = '证件号码'
      end
      item
        ParamName = '证件类型'
        FieldName = '证件类型'
      end
      item
        ParamName = '注销日期'
        FieldName = '注销日期'
      end
      item
        ParamName = '显示卡号'
        FieldName = '显示卡号'
      end
      item
        ParamName = '卡号'
        FieldName = '卡号'
      end
      item
        ParamName = '钱包号'
        FieldName = '钱包号'
      end
      item
        ParamName = '物理卡号'
        FieldName = '物理卡号'
      end>
    AfterExec = MainRequestAfterExec
    Left = 80
    Top = 112
  end
  object WorkView2: TWorkView
    WorkFields = <
      item
        Name = '返回码'
        Caption = '返回码'
        FieldType = wftUndefined
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DataField = '@Return'
      end
      item
        Name = '返回信息'
        Caption = '返回信息'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DataField = 'vsmess'
      end
      item
        Name = '交易标志'
        Caption = '交易标志'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '交易日期'
        Caption = '交易日期'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '交易时间'
        Caption = '交易时间'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = 'sam终端号'
        Caption = 'sam终端号'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = 'sam流水号'
        Caption = 'sam流水号'
        FieldType = wftUndefined
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '应用序列号'
        Caption = '应用序列号'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '记账日期'
        Caption = '记账日期'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '交易参考号'
        Caption = '交易参考号'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = 'TAC码'
        Caption = 'TAC码'
        FieldType = wftUndefined
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
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '姓名'
        Caption = '姓名'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '手机'
        Caption = '手机'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '记账时间'
        Caption = '记账时间'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '卡号'
        Caption = '卡号'
        FieldType = wftUndefined
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end>
    WorkProcesses = <>
    FieldsMonitors = <
      item
        MonitorValueChangedFields = '|客户号|学工号|卡号|姓名|身份证号|'
      end>
    Left = 44
    Top = 143
  end
  object WVRequest2: TWVRequest
    WorkView = WorkView2
    ID = '读卡器消费确认'
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
        ParamName = '交易标志'
        FieldName = '交易标志'
      end
      item
        ParamName = '交易日期'
        FieldName = '交易日期'
      end
      item
        ParamName = '交易时间'
        FieldName = '交易时间'
      end
      item
        ParamName = 'sam终端号'
        FieldName = 'sam终端号'
      end
      item
        ParamName = 'sam流水号'
        FieldName = 'sam流水号'
      end
      item
        ParamName = '应用序列号'
        FieldName = '应用序列号'
      end
      item
        ParamName = '记账日期'
        FieldName = '记账日期'
      end
      item
        ParamName = '交易参考号'
        FieldName = '交易参考号'
      end
      item
        ParamName = 'TAC码'
        FieldName = 'TAC码'
      end
      item
        ParamName = '卡类型'
        FieldName = '卡类型'
        Direction = bdParam2Field
      end
      item
        ParamName = '姓名'
        FieldName = '姓名'
        Direction = bdParam2Field
      end
      item
        ParamName = '手机'
        FieldName = '手机'
        Direction = bdParam2Field
      end
      item
        ParamName = '记账时间'
        FieldName = '记账时间'
        Direction = bdParam2Field
      end
      item
        ParamName = '卡号'
        FieldName = '卡号'
        Direction = bdParam2Field
      end>
    AfterExec = MainRequestAfterExec
    Left = 80
    Top = 144
  end
end
