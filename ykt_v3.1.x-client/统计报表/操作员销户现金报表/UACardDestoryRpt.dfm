inherited faqhCardDestoryRpt: TfaqhCardDestoryRpt
  Width = 672
  Height = 489
  inherited upnlBottom: TUIPanel
    Top = 452
    Width = 672
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
      Left = 581
    end
  end
  inherited UIPnlQueryCount: TUIPanel
    Width = 672
    inherited Image1: TImage
      Width = 672
    end
    inherited LabRecordCount: TLabel
      Visible = False
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 18
    Width = 672
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label2: TLabel
      Left = 368
      Top = 9
      Width = 48
      Height = 12
      Caption = '操作员号'
    end
    object WVLabel1: TWVLabel
      Left = 18
      Top = 8
      Width = 48
      Height = 12
      Caption = '开始日期'
    end
    object WVLabel2: TWVLabel
      Left = 192
      Top = 8
      Width = 48
      Height = 12
      Caption = '结束日期'
    end
    object cbbOperTrans: TWVComboBox
      Left = 428
      Top = 5
      Width = 133
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
      TabOrder = 2
      WorkView = WorkView
      FieldName = '操作员号'
      DataPresentType = 'IDOBJECTS'
      SeperatedStr = '-'
      AutoDropDown = False
      ItemsDataEntry = '*-30'
    end
    object edtBeginDate: TWVEdit
      Left = 75
      Top = 4
      Width = 102
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
      Left = 252
      Top = 4
      Width = 101
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
    Top = 49
    Width = 672
    Height = 403
    TabOrder = 2
    inherited Grid: TRzDBGrid
      Width = 672
      Height = 403
      Columns = <
        item
          Expanded = False
          FieldName = 'Sdate3'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '记账日期'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Sdate0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '交易日期'
          Visible = False
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
          FieldName = 'sall_name'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '操作员名'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'sstock_code'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '网点号'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sstock_code2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '卡类型'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sbankname'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '卡类型名称'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'Snote'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '摘要'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sserial0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '交易次数'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sserial1'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '收入数量'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sserial2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '支出数量'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sserial3'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '库存数量'
          Width = 70
          Visible = True
        end>
    end
    inherited rmprvwP: TRMPreview
      Width = 672
      Height = 403
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
    ID = '销户现金报表'
    Bindings = <
      item
        ParamName = '查询结果集'
        FieldName = '查询结果集'
        Direction = bdParam2Field
      end
      item
        ParamName = '操作员号'
        FieldName = '操作员号'
      end
      item
        ParamName = '开始日期'
        FieldName = '开始日期'
      end
      item
        ParamName = '结束日期'
        FieldName = '结束日期'
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
        FieldName = 'sstock_code2'
        DataPresentType = 'idobjects'
        DataPresentParam = '-56'
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
    DataSet = ztbl1
  end
  object ztbl1: TZTable
    Connection = dmReportImp.conSLite
    SortType = stIgnored
    TableName = 'T_RPTDAILYACC'
    Left = 403
    Top = 92
  end
end
