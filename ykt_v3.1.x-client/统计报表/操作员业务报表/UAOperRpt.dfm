inherited faqhOperRpt: TfaqhOperRpt
  Width = 775
  Height = 489
  inherited upnlBottom: TUIPanel
    Top = 452
    Width = 775
    TabOrder = 3
    inherited tlb1: TRzToolbar
      ToolbarControls = (
        btn100
        btnPageWidth
        rzspcr1
        btnFirst
        btnprevious
        btnNext
        btnLast
        rzspcr2
        btnExpXls
        btnPagePrint
        btnSetup
        rzspcr3
        btnDesign)
    end
    inherited btnQuery: TBitBtn
      Left = 683
    end
  end
  inherited UIPnlQueryCount: TUIPanel
    Width = 775
    inherited Image1: TImage
      Width = 775
    end
    inherited LabRecordCount: TLabel
      Visible = False
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 18
    Width = 775
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label1: TLabel
      Left = 6
      Top = 9
      Width = 36
      Height = 12
      Caption = '网点号'
    end
    object Label2: TLabel
      Left = 154
      Top = 9
      Width = 48
      Height = 12
      Caption = '操作员号'
    end
    object WVLabel1: TWVLabel
      Left = 322
      Top = 8
      Width = 48
      Height = 12
      Caption = '开始日期'
    end
    object WVLabel2: TWVLabel
      Left = 464
      Top = 8
      Width = 48
      Height = 12
      Caption = '结束日期'
    end
    object cbbOperTrans: TWVComboBox
      Left = 204
      Top = 5
      Width = 109
      Height = 20
      Style = csDropDownList
      Color = clInfoBk
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ItemHeight = 12
      ParentFont = False
      TabOrder = 3
      WorkView = WorkView
      FieldName = '操作员号'
      DataPresentType = 'IDOBJECTS'
      SeperatedStr = '-'
      AutoDropDown = False
      ItemsDataEntry = '*-30'
    end
    object cbbNetInfo: TWVComboBox
      Left = 43
      Top = 5
      Width = 102
      Height = 18
      Style = csOwnerDrawFixed
      Color = clInfoBk
      ItemHeight = 12
      TabOrder = 2
      WorkView = WorkView
      FieldName = '网点号'
      DataPresentType = 'IDOBJECTS'
      SeperatedStr = '-'
      AutoDropDown = False
      ItemsDataEntry = '*-2'
    end
    object edtBeginDate: TWVEdit
      Left = 376
      Top = 4
      Width = 81
      Height = 20
      Color = clWhite
      ImeName = '中文 (简体) - 微软拼音'
      ReadOnly = False
      TabOrder = 0
      Text = '<开始日期>'
      WorkView = WorkView
      FieldName = '开始日期'
    end
    object edtEndDate: TWVEdit
      Left = 520
      Top = 4
      Width = 89
      Height = 20
      Color = clWhite
      ImeName = '中文 (简体) - 微软拼音'
      ReadOnly = False
      TabOrder = 1
      Text = '<结束日期>'
      WorkView = WorkView
      FieldName = '结束日期'
    end
  end
  inherited UIPanel2: TUIPanel
    Top = 46
    Width = 775
    Height = 406
    TabOrder = 2
    inherited Grid: TRzDBGrid
      Width = 775
      Height = 406
      Columns = <
        item
          Expanded = False
          FieldName = 'sdate3'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '记账日期'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sstock_code'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '网点号'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Semp_no'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '操作员'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_auth'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '科目'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'snote'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '摘要'
          Width = 100
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'sserial0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '交易次数'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'sserial1'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '收入'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'sserial2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '支出'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'sserial3'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '结存金额'
          Width = 70
          Visible = True
        end>
    end
    inherited rmprvwP: TRMPreview
      Width = 775
      Height = 406
    end
  end
  inherited WorkView: TWorkView
    WorkFields = <
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
        Name = '网点号'
        Caption = '网点号'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Constrained = True
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GetPrevChar = '*'
      end
      item
        Name = '操作员号'
        Caption = '操作员号'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Constrained = True
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GetPrevChar = '*'
      end
      item
        Name = '开始日期'
        Caption = '开始日期'
        FieldType = wftUndefined
        DomainName = '日期校验'
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
        DomainName = '日期校验'
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
        MonitorValueChangedFields = '|网点号|操作员号|卡类型|'
        OnValueChanged = WorkViewFieldsMonitors0ValueChanged
      end>
    Left = 244
    Top = 135
  end
  inherited MainRequest: TWVRequest
    ID = '操作员业务报表'
    Bindings = <
      item
        ParamName = '查询结果集'
        FieldName = '查询结果集'
        Direction = bdParam2Field
      end
      item
        ParamName = '网点号'
        FieldName = '网点号'
      end
      item
        ParamName = '操作员号'
        FieldName = '操作员号'
      end
      item
        ParamName = '结束日期'
        FieldName = '结束日期'
      end
      item
        ParamName = '开始日期'
        FieldName = '开始日期'
      end>
    Left = 280
    Top = 136
  end
  inherited WVDBBinder: TWVDBBinder
    FieldName = '查询结果集'
    Bindings = <
      item
        FieldName = 'semp_no'
        DataPresentType = 'idobjects'
        DataPresentParam = '-30'
      end
      item
        FieldName = 'sstock_code'
        DataPresentType = 'idobjects'
        DataPresentParam = '-2'
      end
      item
        FieldName = 'scust_auth'
        DataPresentType = 'idobjects'
        DataPresentParam = '-25'
      end
      item
        FieldName = 'sserial0'
        DataPresentType = '货币'
      end
      item
        FieldName = 'sserial1'
        DataPresentType = '货币'
      end
      item
        FieldName = 'sserial2'
        DataPresentType = '货币'
      end
      item
        FieldName = 'sserial3'
        DataPresentType = '货币'
      end>
    Left = 312
    Top = 136
  end
  inherited DataSource: TDataSource
    Left = 344
    Top = 136
  end
  inherited rptReport: TRMReport
    ReportData = {}
  end
  inherited rmDS: TRMDBDataSet
    DataSet = zqry1
  end
  object zqry1: TZQuery
    Connection = dmReportImp.conSLite
    SortType = stIgnored
    SQL.Strings = (
      'select * from t_rptopercash')
    Params = <>
    Left = 411
    Top = 89
  end
end
