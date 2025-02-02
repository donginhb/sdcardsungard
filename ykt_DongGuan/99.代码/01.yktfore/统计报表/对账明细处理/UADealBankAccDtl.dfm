inherited faqhDealBankAccDtl: TfaqhDealBankAccDtl
  Width = 833
  Height = 489
  inherited UIPanel1: TUIPanel
    Top = 448
    Width = 833
    Height = 41
    TabOrder = 3
    inherited btnQuery: TBitBtn
      Left = 656
      Top = 11
    end
    inherited btnPrint: TBitBtn
      Left = 743
      Top = 1000
      Visible = False
    end
    object grpResult: TGroupBox
      Left = 0
      Top = 0
      Width = 385
      Height = 41
      Align = alLeft
      Caption = '处理意见'
      TabOrder = 2
      object Label1: TLabel
        Left = 7
        Top = 18
        Width = 48
        Height = 12
        Caption = '处理状态'
      end
      object Label3: TLabel
        Left = 183
        Top = 18
        Width = 24
        Height = 12
        Caption = '备注'
      end
      object WVComboBox1: TWVComboBox
        Left = 60
        Top = 14
        Width = 109
        Height = 20
        Style = csDropDownList
        Color = clWhite
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '宋体'
        Font.Style = []
        ItemHeight = 12
        ParentFont = False
        TabOrder = 0
        WorkView = WVDeal
        FieldName = '处理状态'
        DataPresentType = 'IDOBJECTS'
        SeperatedStr = '-'
        AutoDropDown = False
        ItemsDataEntry = '*173'
      end
      object edtMemo: TWVEdit
        Left = 212
        Top = 13
        Width = 165
        Height = 20
        CharCase = ecUpperCase
        Color = clWhite
        ReadOnly = False
        TabOrder = 1
        Text = '<备注>'
        WorkView = WVDeal
        FieldName = '备注'
      end
    end
    object btnDeal: TBitBtn
      Left = 744
      Top = 11
      Width = 79
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '处 理'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnDealClick
    end
  end
  inherited UIPnlQueryCount: TUIPanel
    Width = 833
    TabOrder = 2
    inherited Image1: TImage
      Width = 833
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 18
    Width = 833
    Height = 55
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label2: TLabel
      Left = 18
      Top = 9
      Width = 48
      Height = 12
      Caption = '开始日期'
    end
    object lbl1: TLabel
      Left = 376
      Top = 9
      Width = 48
      Height = 12
      Caption = '银行名称'
    end
    object lbl2: TLabel
      Left = 194
      Top = 9
      Width = 48
      Height = 12
      Caption = '结束日期'
    end
    object lbl3: TLabel
      Left = 18
      Top = 33
      Width = 48
      Height = 12
      Caption = '对账结果'
    end
    object lbl4: TLabel
      Left = 194
      Top = 33
      Width = 48
      Height = 12
      Caption = '处理状态'
    end
    object Label4: TLabel
      Left = 382
      Top = 33
      Width = 42
      Height = 12
      Caption = '学/工号'
    end
    object edtBeginDate: TWVEdit
      Left = 68
      Top = 5
      Width = 109
      Height = 20
      CharCase = ecUpperCase
      Color = clWhite
      ReadOnly = False
      TabOrder = 0
      Text = '<开始日期>'
      WorkView = WorkView
      FieldName = '开始日期'
    end
    object cbbOperTrans: TWVComboBox
      Left = 428
      Top = 5
      Width = 133
      Height = 20
      Style = csDropDownList
      Color = clWhite
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ItemHeight = 12
      ParentFont = False
      TabOrder = 1
      WorkView = WorkView
      FieldName = '银行编号'
      DataPresentType = 'IDOBJECTS'
      SeperatedStr = '-'
      AutoDropDown = False
      ItemsDataEntry = '*-18'
    end
    object edtEndDate: TWVEdit
      Left = 244
      Top = 5
      Width = 109
      Height = 20
      CharCase = ecUpperCase
      Color = clWhite
      ReadOnly = False
      TabOrder = 2
      Text = '<结束日期>'
      WorkView = WorkView
      FieldName = '结束日期'
    end
    object cbb1: TWVComboBox
      Left = 68
      Top = 29
      Width = 109
      Height = 20
      Style = csDropDownList
      Color = clWhite
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ItemHeight = 12
      ParentFont = False
      TabOrder = 3
      WorkView = WorkView
      FieldName = '对账状态'
      DataPresentType = 'IDOBJECTS'
      SeperatedStr = '-'
      AutoDropDown = False
      ItemsDataEntry = '*172'
    end
    object cbb2: TWVComboBox
      Left = 244
      Top = 29
      Width = 109
      Height = 20
      Style = csDropDownList
      Color = clWhite
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ItemHeight = 12
      ParentFont = False
      TabOrder = 4
      WorkView = WorkView
      FieldName = '处理状态'
      DataPresentType = 'IDOBJECTS'
      SeperatedStr = '-'
      AutoDropDown = False
      ItemsDataEntry = '*173'
    end
    object WVEdit1: TWVEdit
      Left = 428
      Top = 29
      Width = 133
      Height = 20
      CharCase = ecUpperCase
      Color = clWhite
      ReadOnly = False
      TabOrder = 5
      Text = '<学工号>'
      WorkView = WorkView
      FieldName = '学工号'
    end
  end
  inherited UIPanel2: TUIPanel
    Top = 73
    Width = 833
    Height = 375
    TabOrder = 1
    inherited Grid: TRzDBGrid
      Width = 833
      Height = 375
      Columns = <
        item
          Expanded = False
          FieldName = 'lbank_acc_type'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '银行名称'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sdate0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '账单日期'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lserial0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '记录号'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sdate1'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '交易日期'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'damt0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '发生额'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sorder0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '对账结果'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sorder1'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '处理状态'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vsvarstr0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '备注'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Sphone2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '一卡通流水号'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scard0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '一卡通卡号'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_auth'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '一卡通客户号'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Spager'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '一卡通学/工号'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'semp_no'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '处理操作员'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sphone1'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '银行流水号'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sbank_acc'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '银行卡号'
          Width = 100
          Visible = True
        end>
    end
  end
  inherited WorkView: TWorkView
    WorkFields = <
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
        Name = '查询结果集'
        Caption = '查询结果集'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtObject
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '开始日期'
        Caption = '开始日期'
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
        Name = '结束日期'
        Caption = '结束日期'
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
        Name = '银行编号'
        Caption = '银行编号'
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
        Name = '对账状态'
        Caption = '对账状态'
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
        Name = '处理状态'
        Caption = '处理状态'
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
        Name = '学工号'
        Caption = '学工号'
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
        MonitorValueChangedFields = '|学号|'
        OnValueChanged = WorkViewFieldsMonitors0ValueChanged
      end>
    Left = 164
    Top = 223
  end
  inherited MainRequest: TWVRequest
    ID = '银行对账明细查询'
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
        ParamName = '开始日期'
        FieldName = '开始日期'
      end
      item
        ParamName = '结束日期'
        FieldName = '结束日期'
      end
      item
        ParamName = '银行编号'
        FieldName = '银行编号'
      end
      item
        ParamName = '对账状态'
        FieldName = '对账状态'
      end
      item
        ParamName = '处理状态'
        FieldName = '处理状态'
      end
      item
        ParamName = '学工号'
        FieldName = '学工号'
      end>
    Left = 200
    Top = 224
  end
  inherited WVDBBinder: TWVDBBinder
    FieldName = '查询结果集'
    Bindings = <
      item
        FieldName = 'lbank_acc_type'
        DataPresentType = 'idobjects'
        DataPresentParam = '-18'
      end
      item
        FieldName = 'sorder0'
        DataPresentType = 'idobjects'
        DataPresentParam = '172'
      end
      item
        FieldName = 'sorder1'
        DataPresentType = 'idobjects'
        DataPresentParam = '173'
      end
      item
        FieldName = 'semp_no'
        DataPresentType = 'idobjects'
        DataPresentParam = '-30'
      end>
    Left = 240
    Top = 224
  end
  inherited DataSource: TDataSource
    Left = 280
    Top = 224
  end
  object WVDeal: TWorkView
    WorkFields = <
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
      end
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
      end
      item
        Name = '账单日期'
        Caption = '账单日期'
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
        Name = '银行编号'
        Caption = '银行编号'
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
        Name = '处理状态'
        Caption = '处理状态'
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
        Name = '备注'
        Caption = '备注'
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
        Name = '记录号'
        Caption = '记录号'
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
      end>
    WorkProcesses = <>
    FieldsMonitors = <
      item
        MonitorValueChangedFields = '|学号|'
      end>
    Left = 164
    Top = 255
  end
  object WVRDeal: TWVRequest
    WorkView = WVDeal
    ID = '银行对账明细处理'
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
        ParamName = '账单日期'
        FieldName = '账单日期'
      end
      item
        ParamName = '银行编号'
        FieldName = '银行编号'
      end
      item
        ParamName = '处理状态'
        FieldName = '处理状态'
      end
      item
        ParamName = '备注'
        FieldName = '备注'
      end
      item
        ParamName = '记录号'
        FieldName = '记录号'
      end
      item
        ParamName = '学工号'
        FieldName = '学工号'
      end>
    AfterExec = MainRequestAfterExec
    Left = 200
    Top = 256
  end
end
