inherited faMoney: TfaMoney
  Width = 731
  Height = 473
  inherited UIPanel1: TUIPanel
    Top = 18
    Width = 731
    Height = 455
    Align = alClient
    Color = 16184303
    TabOrder = 1
    object RzStatusPane2: TRzStatusPane [0]
      Left = 0
      Top = 434
      Width = 731
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
    inherited btnOK: TBitBtn
      Left = 88
      Top = 1000
      Enabled = False
      TabOrder = 5
      Visible = False
    end
    inherited btnCancel: TBitBtn
      Left = 8
      Top = 1000
      TabOrder = 4
      Visible = False
    end
    object btnReadCardInfo: TBitBtn
      Left = 352
      Top = 355
      Width = 113
      Height = 25
      Hint = '读取卡信息'
      Caption = '读卡信息(&R)'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
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
    object btnMoneyOut: TBitBtn
      Left = 476
      Top = 355
      Width = 108
      Height = 25
      Hint = '校园卡金额支取'
      Caption = '金额支取(&O)'
      Enabled = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnMoneyOutClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C31
        00009C310000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C31
        0000CE6300009C310000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300CE9C
        6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C31
        0000CE630000CE6300009C310000FFFFFF00FFFFFF00FFFFFF00CE9C6300FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C31
        0000CE630000CE630000CE6300009C310000FFFFFF00FFFFFF00CE9C6300FFFF
        FF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7009C31
        0000CE630000CE630000CE630000CE6300009C310000FFFFFF00CE9C6300FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C31
        0000CE630000CE630000CE630000CE630000CE6300009C310000CE9C6300FFFF
        FF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7009C31
        0000CE630000CE630000CE630000CE6300009C310000FFFFFF00CE9C6300FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C31
        0000CE630000CE630000CE6300009C310000FFFFFF00FFFFFF00CE9C6300FFFF
        FF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7009C31
        0000CE630000CE6300009C310000FFFFFF00FFFFFF00FFFFFF00CE9C6300FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C31
        0000CE6300009C310000FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300FFFF
        FF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E7009C31
        00009C310000CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300FFFF
        FF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
        E700FFFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE9C6300CE9C
        6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C6300CE9C
        6300CE9C6300CE9C6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    end
    object grp2: TGroupBox
      Left = 184
      Top = 256
      Width = 401
      Height = 81
      Caption = '支取信息'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object WVLabel1: TWVLabel
        Left = 300
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
        Caption = '支取金额'
      end
      object edtmoney: TWVDigitalEdit
        Left = 133
        Top = 21
        Width = 160
        Height = 22
        AllowPoint = True
        AllowNegative = True
        UserSeprator = True
        Precision = 2
        MaxIntLen = 9
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        TabStop = True
        Text = '0'
        WorkView = WorkView
        FieldName = '支取金额'
        SynchronizeByValue = True
      end
      object chkPrint: TCheckBox
        Left = 133
        Top = 49
        Width = 124
        Height = 17
        Caption = '打印支取凭证'
        TabOrder = 1
      end
    end
    object grp1: TGroupBox
      Left = 184
      Top = 72
      Width = 401
      Height = 177
      Caption = '卡信息'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object WVLabel5: TWVLabel
        Left = 300
        Top = 120
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
        Top = 152
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
        Top = 56
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
        Caption = '交易卡号'
      end
      object RzStatusPane4: TRzStatusPane
        Left = 13
        Top = 86
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
        Caption = '学/工号'
      end
      object RzStatusPane5: TRzStatusPane
        Left = 13
        Top = 116
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
        Caption = '支取前余额'
      end
      object RzStatusPane6: TRzStatusPane
        Left = 13
        Top = 146
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
        Caption = '支取后余额'
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
        Top = 57
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
        Top = 87
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
        Top = 117
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
        Top = 147
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
  end
  object UIPnlQueryCount: TUIPanel [1]
    Left = 0
    Top = 0
    Width = 731
    Height = 18
    Align = alTop
    BevelOuter = bvNone
    Color = 15458000
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    StyleItemName = '操作界面的外围背景'
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
        Name = '入卡金额'
        Caption = '入卡金额'
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
        Name = '交易次数'
        Caption = '交易次数'
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
        Name = '支取金额'
        Caption = '支取金额'
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
        Name = '流水号'
        Caption = '流水号'
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
        Name = '业务日期'
        Caption = '业务日期'
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
        Name = '出卡金额'
        Caption = '出卡金额'
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
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '业务时间'
        Caption = '业务时间'
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
    Left = 536
    Top = 32
  end
  inherited MainRequest: TWVRequest
    ID = '卡支取'
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
        ParamName = '卡号'
        FieldName = '卡号'
        Direction = bdBiDirection
      end
      item
        ParamName = '物理卡号'
        FieldName = '物理卡号'
      end
      item
        ParamName = '入卡金额'
        FieldName = '入卡金额'
      end
      item
        ParamName = '交易次数'
        FieldName = '交易次数'
      end
      item
        ParamName = '支取金额'
        FieldName = '支取金额'
      end
      item
        ParamName = '流水号'
        FieldName = '流水号'
        Direction = bdParam2Field
      end
      item
        ParamName = '业务日期'
        FieldName = '业务日期'
        Direction = bdBiDirection
      end
      item
        ParamName = '出卡金额'
        FieldName = '出卡金额'
        Direction = bdParam2Field
      end
      item
        ParamName = '终端编号'
        FieldName = '终端编号'
        Direction = bdParam2Field
      end
      item
        ParamName = '业务时间'
        FieldName = '业务时间'
        Direction = bdParam2Field
      end
      item
        ParamName = '充值次数'
        FieldName = '充值次数'
      end>
    Left = 584
    Top = 32
  end
  object DataSource1: TDataSource
    Left = 664
    Top = 32
  end
  object WVDBBinder1: TWVDBBinder
    DataSource = DataSource1
    WorkView = WorkView
    FieldName = '查询结果集'
    Bindings = <>
    HideUnbindingFields = False
    Left = 624
    Top = 32
  end
  object WVcashOperCancel: TWorkView
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
        Name = '业务日期'
        Caption = '业务日期'
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
        Name = '流水号'
        Caption = '流水号'
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
        Name = '终端编号'
        Caption = '终端编号'
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
    FieldsMonitors = <>
    Left = 584
    Top = 72
  end
  object WVRcashOperCancel: TWVRequest
    WorkView = WVcashOperCancel
    ID = '充值支取冲正'
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
        ParamName = '流水号'
        FieldName = '流水号'
      end
      item
        ParamName = '业务日期'
        FieldName = '业务日期'
      end
      item
        ParamName = '终端编号'
        FieldName = '终端编号'
      end>
    AfterExec = MainRequestAfterExec
    Left = 624
    Top = 72
  end
  object rpt1: TRMReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbPageSetup, pbExit, pbSaveToXLS]
    DefaultCopies = 0
    DefaultCollate = False
    SaveReportOptions.RegistryPath = 'ReportMachine\ReportSettings\'
    Left = 544
    Top = 74
    ReportData = {}
  end
end
