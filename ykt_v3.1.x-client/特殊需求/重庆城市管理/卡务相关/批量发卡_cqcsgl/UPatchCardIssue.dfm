inherited faqhPatchCardIssue: TfaqhPatchCardIssue
  Width = 746
  Height = 481
  inherited UIPanel1: TUIPanel
    Top = 421
    Width = 746
    Height = 60
    TabOrder = 4
    object WVLabel4: TWVLabel [0]
      Left = 407
      Top = 12
      Width = 24
      Height = 12
      Caption = '金额'
    end
    object WVLabel5: TWVLabel [1]
      Left = 509
      Top = 12
      Width = 12
      Height = 12
      Caption = '元'
    end
    object WVLabel8: TWVLabel [2]
      Left = 552
      Top = 24
      Width = 7
      Height = 14
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object WVLabel2: TWVLabel [3]
      Left = 48
      Top = 35
      Width = 7
      Height = 14
      Font.Charset = GB2312_CHARSET
      Font.Color = clNavy
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object WVLabel10: TWVLabel [4]
      Left = 8
      Top = 8
      Width = 6
      Height = 12
    end
    object WVLabel12: TWVLabel [5]
      Left = 64
      Top = 11
      Width = 48
      Height = 12
      Caption = '充值方式'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [6]
      Left = 223
      Top = 12
      Width = 48
      Height = 12
      Caption = '票据号码'
    end
    inherited btnQuery: TBitBtn
      Left = 577
      Top = 5
      Width = 81
    end
    inherited btnPrint: TBitBtn
      Left = 664
      Top = 107
      TabOrder = 8
      Visible = False
    end
    object btnReleaseCard: TBitBtn
      Left = 663
      Top = 5
      Width = 81
      Height = 25
      Hint = '发行卡'
      Anchors = [akTop, akRight]
      Caption = '发行卡'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnReleaseCardClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000063FFFF0063FF
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00000000000000000029FFFF0063FFFF0094FFFF00000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
        00000000000029FFFF0063FFFF0063FFFF0063FFFF0094FFFF0094FFFF0094FF
        FF0094FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        000063FFFF0063FFFF0063FFFF0063FFFF0063FFFF0094FFFF0094FFFF0094FF
        FF0094FFFF00CEFFFF0000000000FFFFFF00FFFFFF00FFFFFF000000000063FF
        FF0063FFFF0063FFFF0063FFFF0063FFFF0094FFFF0094FFFF0094FFFF0094FF
        FF00CEFFFF00CEFFFF00CEFFFF0000000000FFFFFF00FFFFFF000000000063FF
        FF0063FFFF0063FFFF0063FFFF0063FFFF0094FFFF0094FFFF0094FFFF0094FF
        FF00CEFFFF00C6D6EF00BDBDBD009494940000000000FFFFFF00FFFFFF000000
        000063FFFF0063FFFF0063FFFF0094FFFF0094FFFF0094FFFF0094FFFF00CEFF
        FF00C6D6EF0084848400949494009494940063949400FFFFFF00FFFFFF00FFFF
        FF000000000063FFFF0063FFFF0094FFFF0094FFFF0094FFFF00CEFFFF00C6D6
        EF0073737300313131005A5A5A009494940084848400BDBDBD00FFFFFF00FFFF
        FF00FFFFFF000000000063FFFF0094FFFF0094FFFF0094FFFF00CEFFFF007373
        73006363290063630000632900006329290052525200ADADAD00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000000063FFFF0094FFFF0094FFFF0094CEFF006363
        2900CECE630094630000946300006363000052525200FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000000063FFFF0094FFFF00CEFFFF00C6D6EF007373
        730063632900CE9429009463000063290000BDBDBD00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF000000000063FFFF00CEFFFF0000000000BDBD
        BD00313131009463000029290000ADADAD00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF000000000063FFFF0000000000FFFFFF00BDBD
        BD000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
        0000CECE2900FFFF9400FFFF63000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00}
    end
    object cbbType: TWVComboBox
      Left = 117
      Top = 7
      Width = 100
      Height = 20
      Style = csDropDownList
      Color = clWhite
      ItemHeight = 12
      TabOrder = 2
      OnChange = cbbTypeChange
      DataPresentType = 'IDOBJECTS'
      AutoDropDown = False
      ItemsDataEntry = '*63'
    end
    object edtTicketNo: TWVEdit
      Left = 277
      Top = 7
      Width = 120
      Height = 20
      Color = clWhite
      ReadOnly = False
      TabOrder = 3
    end
    object chkSelect: TWVCheckBox
      Left = 8
      Top = 9
      Width = 57
      Height = 17
      Caption = '全选'
      TabOrder = 5
      OnClick = chkSelectClick
      DefaultChecked = False
      PresentType = cdpEqual
    end
    object StatusBar: TRzStatusBar
      Left = 0
      Top = 39
      Width = 746
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
      TabOrder = 7
      object RzStatusPane1: TRzStatusPane
        Left = 0
        Top = 0
        Width = 746
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
    object chkSaveM: TWVCheckBox
      Left = 528
      Top = 9
      Width = 73
      Height = 17
      Caption = '保留金额'
      TabOrder = 6
      OnClick = chkSelectClick
      DefaultChecked = False
      PresentType = cdpEqual
    end
    object edtmoney: TWVDigitalEdit
      Left = 436
      Top = 8
      Width = 69
      Height = 19
      AllowPoint = True
      Precision = 2
      MaxIntLen = 12
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = '宋体'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 4
      TabStop = True
      Text = '0'
      WorkView = WVReleaseCard
      FieldName = '收费金额'
      SynchronizeByValue = True
    end
  end
  inherited UIPnlQueryCount: TUIPanel
    Width = 746
    inherited Image1: TImage
      Width = 746
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 18
    Width = 746
    Height = 143
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label1: TLabel
      Left = 88
      Top = 125
      Width = 617
      Height = 12
      AutoSize = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 44
      Top = 9
      Width = 36
      Height = 12
      Caption = '客户号'
    end
    object Label3: TLabel
      Left = 255
      Top = 9
      Width = 42
      Height = 12
      Caption = '学/工号'
    end
    object Label7: TLabel
      Left = 470
      Top = 9
      Width = 48
      Height = 12
      Caption = '客户姓名'
    end
    object WVLabel1: TWVLabel
      Left = 470
      Top = 33
      Width = 48
      Height = 12
      Caption = '客户类别'
    end
    object Label5: TLabel
      Left = 249
      Top = 33
      Width = 48
      Height = 12
      Caption = '证件号码'
    end
    object WVLabel6: TWVLabel
      Left = 32
      Top = 33
      Width = 48
      Height = 12
      Caption = '证件类型'
    end
    object WVLabel7: TWVLabel
      Left = 32
      Top = 56
      Width = 48
      Height = 12
      Caption = '收费类别'
    end
    object WVLabel9: TWVLabel
      Left = 56
      Top = 80
      Width = 24
      Height = 12
      Caption = '专业'
    end
    object Label6: TLabel
      Left = 249
      Top = 80
      Width = 48
      Height = 12
      Caption = '开户日期'
    end
    object WVLabel11: TWVLabel
      Left = 249
      Top = 56
      Width = 48
      Height = 12
      Caption = '所属区域'
    end
    object Label8: TLabel
      Left = 262
      Top = 105
      Width = 36
      Height = 12
      Caption = '批次号'
    end
    object WVLabel13: TWVLabel
      Left = 470
      Top = 57
      Width = 48
      Height = 12
      Caption = '所属部门'
    end
    object Label9: TLabel
      Left = 57
      Top = 104
      Width = 24
      Height = 12
      Caption = '班级'
    end
    object WVLabel3: TWVLabel
      Left = 470
      Top = 82
      Width = 48
      Height = 12
      Caption = '发卡类别'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object WVEdit1: TWVEdit
      Left = 88
      Top = 5
      Width = 126
      Height = 20
      Color = clWhite
      MaxLength = 22
      ReadOnly = False
      TabOrder = 0
      Text = '<客户号>'
      WorkView = WorkView
      FieldName = '客户号'
    end
    object WVEdit2: TWVEdit
      Left = 304
      Top = 5
      Width = 125
      Height = 20
      Color = clWhite
      ReadOnly = False
      TabOrder = 1
      Text = '<学工号>'
      WorkView = WorkView
      FieldName = '学工号'
    end
    object WVEdit8: TWVEdit
      Left = 527
      Top = 5
      Width = 127
      Height = 20
      Color = clWhite
      ReadOnly = False
      TabOrder = 2
      Text = '<客户姓名>'
      WorkView = WorkView
      FieldName = '客户姓名'
    end
    object WVComboBox6: TWVComboBox
      Left = 527
      Top = 29
      Width = 127
      Height = 20
      Style = csDropDownList
      Color = clWhite
      ItemHeight = 12
      TabOrder = 5
      WorkView = WorkView
      FieldName = '客户类别'
      DataPresentType = 'IDOBJECTS'
      AutoDropDown = False
      ItemsDataEntry = '*-34'
    end
    object WVEdit3: TWVEdit
      Left = 304
      Top = 29
      Width = 125
      Height = 20
      Color = clWhite
      ReadOnly = False
      TabOrder = 4
      Text = '<证件号码>'
      WorkView = WorkView
      FieldName = '证件号码'
    end
    object WVComboBox1: TWVComboBox
      Left = 88
      Top = 28
      Width = 126
      Height = 20
      Style = csDropDownList
      Color = clWhite
      ItemHeight = 12
      TabOrder = 3
      WorkView = WorkView
      FieldName = '证件类型'
      DataPresentType = 'IDOBJECTS'
      AutoDropDown = False
      ItemsDataEntry = '*87'
    end
    object WVComboBox3: TWVComboBox
      Left = 88
      Top = 51
      Width = 126
      Height = 20
      Style = csDropDownList
      Color = clWhite
      ItemHeight = 12
      TabOrder = 6
      WorkView = WorkView
      FieldName = '收费类别'
      DataPresentType = 'IDOBJECTS'
      AutoDropDown = False
      ItemsDataEntry = '*-43'
    end
    object cbbSpec: TWVComboBox
      Left = 88
      Top = 75
      Width = 125
      Height = 20
      Style = csDropDownList
      Color = clWhite
      DropDownCount = 25
      ItemHeight = 12
      TabOrder = 11
      WorkView = WorkView
      FieldName = '专业'
      DataPresentType = 'IDOBJECTS'
      AutoDropDown = False
      ItemsDataEntry = '*-23'
    end
    object WVComboBox2: TWVComboBox
      Left = 304
      Top = 52
      Width = 125
      Height = 20
      Style = csDropDownList
      Color = clWhite
      ItemHeight = 12
      TabOrder = 7
      WorkView = WorkView
      FieldName = '所属区域'
      DataPresentType = 'IDOBJECTS'
      AutoDropDown = False
      ItemsDataEntry = '*-27'
    end
    object WVEdit5: TWVEdit
      Left = 304
      Top = 76
      Width = 125
      Height = 20
      Color = clWhite
      ReadOnly = False
      TabOrder = 12
      Text = '<注销日期>'
      WorkView = WorkView
      FieldName = '注销日期'
    end
    object cbbDept: TWVComboBox
      Left = 527
      Top = 53
      Width = 125
      Height = 20
      Style = csDropDownList
      Color = clWhite
      DropDownCount = 25
      ItemHeight = 12
      TabOrder = 9
      WorkView = WorkView
      FieldName = '部门'
      DataPresentType = 'IDOBJECTS'
      AutoDropDown = False
      ItemsDataEntry = '*-22'
    end
    object WVEdit6: TWVEdit
      Left = 304
      Top = 101
      Width = 125
      Height = 20
      Color = clWhite
      ReadOnly = False
      TabOrder = 15
      Text = '<导入批次号>'
      WorkView = WorkView
      FieldName = '导入批次号'
    end
    object WVEdit4: TWVEdit
      Left = 88
      Top = 100
      Width = 126
      Height = 20
      Color = clWhite
      ReadOnly = False
      TabOrder = 14
      Text = '<班级>'
      WorkView = WorkView
      FieldName = '班级'
    end
    object cbbCardType: TWVComboBox
      Left = 527
      Top = 78
      Width = 127
      Height = 20
      Style = csDropDownList
      Color = clWhite
      ItemHeight = 12
      TabOrder = 13
      WorkView = WorkView
      FieldName = '发卡类别'
      DataPresentType = 'IDOBJECTS'
      AutoDropDown = False
      ItemsDataEntry = '-5'
    end
    object cbb1: TKSFilterComboBox
      Left = 527
      Top = 52
      Width = 127
      Height = 22
      ListFont.Charset = GB2312_CHARSET
      ListFont.Color = clWindowText
      ListFont.Height = -12
      ListFont.Name = '宋体'
      ListFont.Style = []
      OnFilterItems = cbb1FilterItems
      TabOrder = 8
    end
    object cbb2: TKSFilterComboBox
      Left = 88
      Top = 74
      Width = 126
      Height = 22
      ListFont.Charset = GB2312_CHARSET
      ListFont.Color = clWindowText
      ListFont.Height = -12
      ListFont.Name = '宋体'
      ListFont.Style = []
      OnFilterItems = cbb2FilterItems
      TabOrder = 10
    end
  end
  inherited UIPanel2: TUIPanel
    Top = 161
    Width = 746
    Height = 260
    TabOrder = 3
    inherited Grid: TRzDBGrid
      Width = 746
      Height = 260
      DataSource = nil
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      DisabledColor = clHighlightText
      Columns = <
        item
          Expanded = False
          FieldName = 'sname'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '姓名'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_type'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '性别'
          Width = 56
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_auth'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '学工号'
          Width = 77
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lvol2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '客户号'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lvol0'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '客户类别'
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_no2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '专业'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_no'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '院系'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sname2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '身份证号'
          Width = 131
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'scust_auth2'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '注册时间'
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sphone'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '联系电话'
          Width = 114
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sstock_code'
          PickList.Strings = ()
          Title.Alignment = taCenter
          Title.Caption = '年级'
          Visible = True
        end>
    end
  end
  object RzListView1: TRzListView [4]
    Left = 0
    Top = 161
    Width = 746
    Height = 260
    Align = alClient
    AlphaSortAll = True
    Checkboxes = True
    Columns = <
      item
        Caption = '所属区域'
        Width = 70
      end
      item
        Caption = '客户号'
        Width = 60
      end
      item
        Alignment = taCenter
        Caption = '学/工号'
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = '姓名'
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = '客户类别'
        Width = 100
      end
      item
        Caption = '收费类别代码'
        Width = 0
      end
      item
        Alignment = taCenter
        Caption = '收费类别'
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = '部门'
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = '专业'
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = '截至日期'
        Width = 70
      end
      item
        Caption = '批次号'
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = '证件类型'
        Width = 70
      end
      item
        Caption = '证件号码'
        Width = 349
      end
      item
        Width = 10
      end>
    FlatScrollBars = True
    FrameColor = clInactiveCaption
    FrameHotTrack = True
    FrameVisible = True
    GridLines = True
    ReadOnly = True
    RowSelect = True
    SmallImages = ImageList1
    SortType = stBoth
    TabOrder = 2
    ViewStyle = vsReport
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
        DataField = '@Dataset'
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
        Name = '客户号'
        Caption = '客户号'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtInteger
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GroupIndex = 1
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
        GroupIndex = 1
      end
      item
        Name = '客户姓名'
        Caption = '客户姓名'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GroupIndex = 1
      end
      item
        Name = '部门'
        Caption = '部门'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GroupIndex = 1
      end
      item
        Name = '证件类型'
        Caption = '证件类型'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GroupIndex = 1
      end
      item
        Name = '证件号码'
        Caption = '证件号码'
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
        Name = '客户类别'
        Caption = '客户类别'
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
        Name = '收费类别'
        Caption = '收费类别'
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
        Name = '所属区域'
        Caption = '所属区域'
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
        Name = '专业'
        Caption = '专业'
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
        Name = '导入批次号'
        Caption = '导入批次号'
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
        Name = '注销日期'
        Caption = '注销日期'
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
        Name = '班级'
        Caption = '班级'
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
        Name = '发卡类别'
        Caption = '发卡类别'
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
        MonitorValueChangedFields = '|客户号|'
        OnValueChanged = WorkViewFieldsMonitors0ValueChanged
      end>
    Top = 199
  end
  inherited MainRequest: TWVRequest
    ID = '发卡客户信息查询'
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
        ParamName = '部门'
        FieldName = '部门'
      end
      item
        ParamName = '导入批次号'
        FieldName = '导入批次号'
      end
      item
        ParamName = '客户号'
        FieldName = '客户号'
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
        ParamName = '专业'
        FieldName = '专业'
      end
      item
        ParamName = '班级'
        FieldName = '班级'
      end
      item
        ParamName = '发卡类别'
        FieldName = '发卡类别'
      end>
    Left = 104
    Top = 200
  end
  inherited WVDBBinder: TWVDBBinder
    FieldName = '查询结果集'
    Bindings = <
      item
        FieldName = 'scust_type'
        DataPresentType = 'IDOBJECTS'
        DataPresentParam = '39'
      end
      item
        FieldName = 'lvol0'
        DataPresentType = 'IDOBJECTS'
        DataPresentParam = '-34'
      end
      item
        FieldName = 'lvol1'
        DataPresentType = 'IDOBJECTS'
        DataPresentParam = '15'
      end
      item
        FieldName = 'scust_no'
        DataPresentType = 'IDOBJECTS'
        DataPresentParam = '-22'
      end
      item
        FieldName = 'scust_no2'
        DataPresentType = 'IDOBJECTS'
        DataPresentParam = '-23'
      end>
    Left = 152
    Top = 200
  end
  inherited DataSource: TDataSource
    Left = 240
    Top = 200
  end
  object WVRFeeQuery: TWVRequest
    WorkView = WVFeeQuery
    ID = '发卡收费查询'
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
        ParamName = '收费信息'
        FieldName = '收费信息'
        Direction = bdParam2Field
      end
      item
        ParamName = '总费用'
        FieldName = '总费用'
        Direction = bdParam2Field
      end
      item
        ParamName = '功能号'
        FieldName = '功能号'
      end
      item
        ParamName = '卡类型'
        FieldName = '卡类型'
      end
      item
        ParamName = '收费类别'
        FieldName = '收费类别'
      end
      item
        ParamName = '是否不记名卡'
        FieldName = '是否不记名卡'
      end
      item
        ParamName = '卡有效期'
        FieldName = '卡有效期'
        Direction = bdParam2Field
      end
      item
        ParamName = '客户号'
        FieldName = '客户号'
      end>
    AfterExec = MainRequestAfterExec
    Left = 104
    Top = 240
  end
  object WVFeeQuery: TWorkView
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
        Name = '功能号'
        Caption = '功能号'
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
        Name = '卡类型'
        Caption = '卡类型'
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
        Name = '收费信息'
        Caption = '收费信息'
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
        Name = '总费用'
        Caption = '总费用'
        FieldType = wftUndefined
        DataType = kdtFloat
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
      end
      item
        Name = '是否不记名卡'
        Caption = '是否不记名卡'
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
        Name = '卡有效期'
        Caption = '卡有效期'
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
        Name = '客户号'
        Caption = '客户号'
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
    Left = 68
    Top = 239
  end
  object WVRReleaseCard: TWVRequest
    WorkView = WVReleaseCard
    ID = '发行卡cqcsgl'
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
        ParamName = '操作员'
        FieldName = '操作员'
        Direction = bdBiDirection
      end
      item
        ParamName = '卡类型'
        FieldName = '卡类型'
        Direction = bdBiDirection
      end
      item
        ParamName = '显示卡号'
        FieldName = '显示卡号'
        Direction = bdBiDirection
      end
      item
        ParamName = '物理卡号'
        FieldName = '物理卡号'
      end
      item
        ParamName = '票据号码'
        FieldName = '票据号码'
      end
      item
        ParamName = '到期日期'
        FieldName = '到期日期'
        Direction = bdBiDirection
      end
      item
        ParamName = '客户号'
        FieldName = '客户号'
        Direction = bdBiDirection
      end
      item
        ParamName = '收费方式'
        FieldName = '收费方式'
      end
      item
        ParamName = '收费金额'
        FieldName = '收费金额'
      end
      item
        ParamName = '客户类别'
        FieldName = '客户类别'
        Direction = bdParam2Field
      end
      item
        ParamName = '收费类别'
        FieldName = '收费类别'
        Direction = bdParam2Field
      end
      item
        ParamName = '客户姓名'
        FieldName = '客户姓名'
        Direction = bdParam2Field
      end
      item
        ParamName = '学工号'
        FieldName = '学工号'
        Direction = bdParam2Field
      end
      item
        ParamName = '部门代码'
        FieldName = '部门代码'
        Direction = bdParam2Field
      end
      item
        ParamName = '证件号码'
        FieldName = '证件号码'
        Direction = bdParam2Field
      end
      item
        ParamName = '性别'
        FieldName = '性别'
        Direction = bdParam2Field
      end
      item
        ParamName = '卡号'
        FieldName = '卡号'
        Direction = bdParam2Field
      end
      item
        ParamName = '卡密码'
        FieldName = '卡密码'
        Direction = bdParam2Field
      end
      item
        ParamName = '出卡值'
        FieldName = '出卡值'
        Direction = bdParam2Field
      end
      item
        ParamName = '流水号'
        FieldName = '流水号'
        Direction = bdParam2Field
      end
      item
        ParamName = '业务日期'
        FieldName = '业务日期'
        Direction = bdParam2Field
      end
      item
        ParamName = '是否不记名卡'
        FieldName = '是否不记名卡'
      end
      item
        ParamName = '终端编号'
        FieldName = '终端编号'
        Direction = bdParam2Field
      end
      item
        ParamName = '日限额'
        FieldName = '日限额'
        Direction = bdParam2Field
      end
      item
        ParamName = '单次限额'
        FieldName = '单次限额'
        Direction = bdParam2Field
      end
      item
        ParamName = '证件类型'
        FieldName = '证件类型'
        Direction = bdParam2Field
      end
      item
        ParamName = '发行方标识'
        FieldName = '发行方标识'
        Direction = bdParam2Field
      end
      item
        ParamName = '业务时间'
        FieldName = '业务时间'
        Direction = bdParam2Field
      end>
    AfterExec = MainRequestAfterExec
    Left = 104
    Top = 280
  end
  object WVReleaseCard: TWorkView
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
        Name = '操作员'
        Caption = '操作员'
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
        DataType = kdtInteger
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
      end
      item
        Name = '票据号码'
        Caption = '票据号码'
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
        Name = '到期日期'
        Caption = '到期日期'
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
        Name = '客户号'
        Caption = '客户号'
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
        Name = '收费方式'
        Caption = '收费方式'
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
        Name = '收费金额'
        Caption = '收费金额'
        FieldType = wftUndefined
        DataType = kdtFloat
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
        Name = '部门代码'
        Caption = '部门代码'
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
        Name = '性别'
        Caption = '性别'
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
      end
      item
        Name = '卡密码'
        Caption = '卡密码'
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
        Name = '出卡值'
        Caption = '出卡值'
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
        Name = '是否不记名卡'
        Caption = '是否不记名卡'
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
      end
      item
        Name = '单次限额'
        Caption = '单次限额'
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
        Name = '日限额'
        Caption = '日限额'
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
        Name = '发行方标识'
        Caption = '发行方标识'
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
        Name = '业务时间'
        Caption = '业务时间'
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
    Left = 68
    Top = 279
  end
  object WVRelCardOk: TWorkView
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
        GroupIndex = 1
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
        GroupIndex = 1
        DataField = 'lserial1'
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
        GroupIndex = 1
      end
      item
        Name = '开户操作员'
        Caption = '开户操作员'
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
    FieldsMonitors = <>
    Left = 72
    Top = 312
  end
  object WVRRelCardOk: TWVRequest
    WorkView = WVRelCardOk
    ID = '发卡确认'
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
        ParamName = '终端编号'
        FieldName = '终端编号'
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
        ParamName = '开户操作员'
        FieldName = '开户操作员'
      end>
    Left = 104
    Top = 312
  end
  object ImageList1: TImageList
    Left = 440
    Top = 240
  end
end
