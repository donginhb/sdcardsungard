inherited faqhSetBusiDev: TfaqhSetBusiDev
  Width = 839
  Height = 477
  Caption = '商户设备管理'
  inherited pcPages: TRzPageControl
    Width = 839
    Height = 477
    ActivePage = tsQuery
    TabIndex = 0
    FixedDimension = 19
    inherited tsQuery: TRzTabSheet
      inherited UIPanel1: TUIPanel
        Top = 424
        Width = 835
        TabOrder = 1
        inherited btnAdd: TBitBtn [0]
          Left = 573
          Enabled = False
          TabOrder = 3
        end
        inherited btnChange: TBitBtn [1]
          Left = 661
          Enabled = False
          TabOrder = 4
        end
        inherited btnQuery: TBitBtn [2]
          Left = 485
        end
        inherited btnDelete: TBitBtn
          Left = 746
          Enabled = False
          TabOrder = 2
        end
      end
      inherited UIPnlQueryCount: TUIPanel
        Width = 835
        TabOrder = 3
      end
      inherited Grid: TRzDBGrid
        Top = 73
        Width = 835
        Height = 351
        TabOrder = 2
        Columns = <
          item
            Expanded = False
            FieldName = 'lvol0'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '商户号'
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sall_name'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '商户名称'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'scust_auth'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '设备终端序列号'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'scust_auth2'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '省设备终端序列号'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sstock_code'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '设备类型'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'scurrency_type'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '状态'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sdate0'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '注册日期'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sdate1'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '启用日期'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sdate2'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '停用日期'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'lvol1'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '绑定设备编号'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'snote2'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '备注'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'scust_limit2'
            PickList.Strings = ()
            Title.Alignment = taCenter
            Title.Caption = '最后更新时间'
            Width = 80
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 18
        Width = 835
        Height = 55
        Align = alTop
        ParentColor = True
        TabOrder = 0
        object Label3: TLabel
          Left = 22
          Top = 10
          Width = 84
          Height = 12
          Caption = '设备终端序列号'
        end
        object Label4: TLabel
          Left = 10
          Top = 34
          Width = 96
          Height = 12
          Caption = '省设备终端序列号'
        end
        object Label5: TLabel
          Left = 282
          Top = 10
          Width = 48
          Height = 12
          Caption = '设备类型'
        end
        object Label6: TLabel
          Left = 306
          Top = 34
          Width = 24
          Height = 12
          Caption = '状态'
        end
        object WVEdit3: TWVEdit
          Left = 116
          Top = 6
          Width = 133
          Height = 20
          Color = clInfoBk
          ReadOnly = False
          TabOrder = 0
          Text = '<查询.设备终端序列号>'
          WorkView = WorkView
          FieldName = '查询.设备终端序列号'
        end
        object WVEdit4: TWVEdit
          Left = 116
          Top = 30
          Width = 133
          Height = 20
          Color = clInfoBk
          ReadOnly = False
          TabOrder = 1
          Text = '<查询.省设备终端序列号>'
          WorkView = WorkView
          FieldName = '查询.省设备终端序列号'
        end
        object WVComboBox3: TWVComboBox
          Left = 340
          Top = 3
          Width = 141
          Height = 20
          Style = csDropDownList
          Color = clInfoBk
          ImeName = '中文 (简体) - 微软拼音'
          ItemHeight = 12
          TabOrder = 2
          WorkView = WorkView
          FieldName = '查询.设备类型'
          DataPresentType = 'IDOBJECTS'
          SeperatedStr = '-'
          AutoDropDown = False
          ItemsDataEntry = '*221'
        end
        object WVComboBox4: TWVComboBox
          Left = 340
          Top = 27
          Width = 141
          Height = 20
          Style = csDropDownList
          Color = clInfoBk
          ImeName = '中文 (简体) - 微软拼音'
          ItemHeight = 12
          TabOrder = 3
          WorkView = WorkView
          FieldName = '查询.状态'
          DataPresentType = 'IDOBJECTS'
          SeperatedStr = '-'
          AutoDropDown = False
          ItemsDataEntry = '*239'
        end
      end
    end
    inherited tsEdit: TRzTabSheet
      object Label10: TLabel [0]
        Left = 78
        Top = 60
        Width = 36
        Height = 12
        Caption = '商户号'
      end
      object Label13: TLabel [1]
        Left = 84
        Top = 164
        Width = 6
        Height = 12
        Caption = '�'
      end
      object Label14: TLabel [2]
        Left = 66
        Top = 166
        Width = 48
        Height = 12
        Caption = '设备类型'
      end
      object Label1: TLabel [3]
        Left = 18
        Top = 130
        Width = 96
        Height = 12
        Caption = '省设备终端序列号'
      end
      object btnQBusi: TSpeedButton [4]
        Left = 243
        Top = 56
        Width = 23
        Height = 22
        Caption = '>>>'
        Flat = True
        OnClick = btnQBusiClick
      end
      object Label2: TLabel [5]
        Left = 66
        Top = 96
        Width = 48
        Height = 12
        Caption = '商户名称'
      end
      object Label7: TLabel [6]
        Left = 90
        Top = 200
        Width = 24
        Height = 12
        Caption = '备注'
      end
      inherited UIPanel2: TUIPanel
        Top = 418
        Width = 835
        TabOrder = 3
        inherited btnOK: TBitBtn
          Left = 659
        end
        inherited btnCancel: TBitBtn
          Left = 747
        end
        inherited DBNavigator: TRzDBNavigator
          Hints.Strings = ()
        end
      end
      object edtSSNo: TWVEdit
        Left = 124
        Top = 126
        Width = 277
        Height = 20
        Color = clInfoBk
        ReadOnly = False
        TabOrder = 1
        Text = '<省设备终端序列号>'
        WorkView = WorkView
        FieldName = '省设备终端序列号'
        SynchronizeWhenExit = True
      end
      object cbbDevType: TWVComboBox
        Left = 124
        Top = 161
        Width = 277
        Height = 20
        Style = csDropDownList
        Color = clInfoBk
        ImeName = '中文 (简体) - 微软拼音'
        ItemHeight = 12
        TabOrder = 2
        WorkView = WorkView
        FieldName = '设备类型'
        DataPresentType = 'IDOBJECTS'
        SeperatedStr = '-'
        AutoDropDown = False
        ItemsDataEntry = '*221'
      end
      object edtBusiName: TWVEdit
        Left = 124
        Top = 92
        Width = 277
        Height = 20
        Enabled = False
        ParentColor = True
        ReadOnly = False
        TabOrder = 4
        SynchronizeWhenExit = True
      end
      object WVEdit2: TWVEdit
        Left = 124
        Top = 196
        Width = 277
        Height = 20
        Color = clInfoBk
        ReadOnly = False
        TabOrder = 5
        Text = '<备注>'
        WorkView = WorkView
        FieldName = '备注'
        SynchronizeWhenExit = True
      end
      object pnlBusiQ: TPanel
        Left = 270
        Top = 56
        Width = 539
        Height = 353
        TabOrder = 6
        object Panel2: TPanel
          Left = 1
          Top = 1
          Width = 537
          Height = 79
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label9: TLabel
            Left = 230
            Top = 10
            Width = 60
            Height = 12
            Caption = '中心商户号'
          end
          object Label11: TLabel
            Left = 30
            Top = 34
            Width = 60
            Height = 12
            Caption = '省商户编号'
          end
          object Label12: TLabel
            Left = 42
            Top = 10
            Width = 48
            Height = 12
            Caption = '商户名称'
          end
          object Label17: TLabel
            Left = 242
            Top = 58
            Width = 48
            Height = 12
            Caption = '商户类型'
          end
          object Label18: TLabel
            Left = 42
            Top = 58
            Width = 48
            Height = 12
            Caption = '行业类型'
          end
          object Label25: TLabel
            Left = 242
            Top = 34
            Width = 48
            Height = 12
            Caption = '商户状态'
          end
          object WVEdit7: TWVEdit
            Left = 300
            Top = 6
            Width = 120
            Height = 20
            Color = clInfoBk
            ReadOnly = False
            TabOrder = 1
            Text = '<查询.中心商户号>'
            WorkView = WorkView1
            FieldName = '查询.中心商户号'
          end
          object WVEdit8: TWVEdit
            Left = 100
            Top = 30
            Width = 121
            Height = 20
            Color = clInfoBk
            ReadOnly = False
            TabOrder = 2
            Text = '<查询.省商户编号>'
            WorkView = WorkView1
            FieldName = '查询.省商户编号'
          end
          object WVEdit9: TWVEdit
            Left = 100
            Top = 6
            Width = 121
            Height = 20
            Color = clInfoBk
            ReadOnly = False
            TabOrder = 0
            Text = '<查询.商户名>'
            WorkView = WorkView1
            FieldName = '查询.商户名'
          end
          object WVComboBox8: TWVComboBox
            Left = 300
            Top = 30
            Width = 120
            Height = 20
            Style = csDropDownList
            Color = clInfoBk
            ImeName = '中文 (简体) - 微软拼音'
            ItemHeight = 12
            TabOrder = 3
            WorkView = WorkView1
            FieldName = '查询.商户状态'
            DataPresentType = 'IDOBJECTS'
            SeperatedStr = '-'
            AutoDropDown = False
            ItemsDataEntry = '*224'
          end
          object WVComboBox1: TWVComboBox
            Left = 300
            Top = 54
            Width = 120
            Height = 20
            Style = csDropDownList
            Color = clInfoBk
            ImeName = '中文 (简体) - 微软拼音'
            ItemHeight = 12
            TabOrder = 5
            WorkView = WorkView1
            FieldName = '查询.商户类型'
            DataPresentType = 'IDOBJECTS'
            SeperatedStr = '-'
            AutoDropDown = False
            ItemsDataEntry = '*216'
          end
          object WVComboBox2: TWVComboBox
            Left = 100
            Top = 54
            Width = 121
            Height = 20
            Style = csDropDownList
            Color = clInfoBk
            ImeName = '中文 (简体) - 微软拼音'
            ItemHeight = 12
            TabOrder = 4
            WorkView = WorkView1
            FieldName = '查询.行业类型'
            DataPresentType = 'IDOBJECTS'
            SeperatedStr = '-'
            AutoDropDown = False
            ItemsDataEntry = '*217'
          end
          object btnQ: TButton
            Left = 436
            Top = 50
            Width = 65
            Height = 25
            Caption = '查 询'
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = '宋体'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnClick = btnQClick
          end
        end
        object Grid1: TRzDBGrid
          Left = 1
          Top = 80
          Width = 537
          Height = 236
          Align = alClient
          Color = clWhite
          DataSource = DataSource1
          FixedColor = 15458000
          ImeName = '拼音加加集合版'
          TabOrder = 1
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = '宋体'
          TitleFont.Style = []
          OnDrawColumnCell = Grid1DrawColumnCell
          OnDblClick = Grid1DblClick
          FrameColor = 12164479
          FrameStyle = fsGroove
          FrameVisible = True
          FixedLineColor = 12164479
          LineColor = clBackground
          Columns = <
            item
              Expanded = False
              FieldName = 'lvol0'
              Title.Alignment = taCenter
              Title.Caption = '商户编号'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sname'
              Title.Alignment = taCenter
              Title.Caption = '中心商户号'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sname2'
              Title.Alignment = taCenter
              Title.Caption = '省商户编号'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'snote'
              Title.Alignment = taCenter
              Title.Caption = '商户名称'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'snote2'
              Title.Alignment = taCenter
              Title.Caption = '商户英文名称'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'semail'
              Title.Alignment = taCenter
              Title.Caption = '商户简称'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sbranch_code0'
              Title.Alignment = taCenter
              Title.Caption = '商户类型'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sbranch_code1'
              Title.Alignment = taCenter
              Title.Caption = '行业类型'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sbankname'
              Title.Alignment = taCenter
              Title.Caption = '联系人'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sphone'
              Title.Alignment = taCenter
              Title.Caption = '电话'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sphone2'
              Title.Alignment = taCenter
              Title.Caption = '手机'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'semail2'
              Title.Alignment = taCenter
              Title.Caption = '电子信箱'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sphone3'
              Title.Alignment = taCenter
              Title.Caption = '传真'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'vsvarstr0'
              Title.Alignment = taCenter
              Title.Caption = '营业地址'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'spost_code'
              Title.Alignment = taCenter
              Title.Caption = '邮政编码'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'damt0'
              Title.Alignment = taCenter
              Title.Caption = '结算费率'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'vsvarstr1'
              Title.Alignment = taCenter
              Title.Caption = '开户银行'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'spager'
              Title.Alignment = taCenter
              Title.Caption = '银行账号'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sbankname2'
              Title.Alignment = taCenter
              Title.Caption = '银行帐户名'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'scert_no'
              Title.Alignment = taCenter
              Title.Caption = '联行号'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sdate0'
              Title.Alignment = taCenter
              Title.Caption = '开户日期'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sdate1'
              Title.Alignment = taCenter
              Title.Caption = '销户日期'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sstatus1'
              Title.Alignment = taCenter
              Title.Caption = '商户状态'
              Width = 70
              Visible = True
            end>
        end
        object pnl1: TPanel
          Left = 1
          Top = 316
          Width = 537
          Height = 36
          Align = alBottom
          TabOrder = 2
          object btnSelect: TButton
            Left = 392
            Top = 5
            Width = 65
            Height = 25
            Caption = '选  择'
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = '宋体'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = btnSelectClick
          end
          object btnCan: TButton
            Left = 464
            Top = 5
            Width = 65
            Height = 25
            Caption = '取 消'
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = '宋体'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = btnCanClick
          end
        end
      end
      object edtBusiId: TWVEdit
        Left = 124
        Top = 57
        Width = 118
        Height = 20
        Color = clInfoBk
        MaxLength = 22
        ReadOnly = False
        TabOrder = 0
        Text = '<商户号>'
        WorkView = WorkView
        FieldName = '商户号'
      end
    end
  end
  inherited DataSource: TDataSource
    Left = 124
    Top = 295
  end
  inherited WorkView: TWorkView
    WorkFields = <
      item
        Name = '查询结果集'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtObject
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GroupIndex = 1
      end
      item
        Name = '操作类别.增加'
        Caption = '操作类别.增加'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DefaultValue = '1'
      end
      item
        Name = '操作类别.删除'
        Caption = '操作类别.删除'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DefaultValue = '2'
      end
      item
        Name = '操作类别.修改'
        Caption = '操作类别.修改'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DefaultValue = '3'
      end
      item
        Name = '操作标志'
        Caption = '操作标志'
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
        Name = '查询.商户号'
        Caption = '查询.商户号'
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
        Name = '查询.设备终端序列号'
        Caption = '查询.设备终端序列号'
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
        Name = '查询.省设备终端序列号'
        Caption = '查询.省设备终端序列号'
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
        Name = '查询.设备类型'
        Caption = '查询.设备类型'
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
        Name = '查询.状态'
        Caption = '查询.状态'
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
        Name = '查询.注册日期'
        Caption = '查询.注册日期'
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
        Name = '查询.启用日期'
        Caption = '查询.启用日期'
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
        Name = '查询.停用日期'
        Caption = '查询.停用日期'
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
        Name = '商户号'
        Caption = '商户号'
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
        GroupIndex = 1
        DataField = 'lvol0'
      end
      item
        Name = '商户名称'
        Caption = '商户名称'
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
        GroupIndex = 1
        DataField = 'sall_name'
      end
      item
        Name = '设备终端序列号'
        Caption = '设备终端序列号'
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
        GroupIndex = 1
        DataField = 'scust_auth'
      end
      item
        Name = '省设备终端序列号'
        Caption = '省设备终端序列号'
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
        GroupIndex = 1
        DataField = 'scust_auth2'
      end
      item
        Name = '设备类型'
        Caption = '设备类型'
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
        GroupIndex = 1
        DataField = 'sstock_code'
      end
      item
        Name = '状态'
        Caption = '状态'
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
        GroupIndex = 1
        DataField = 'scurrency_type'
      end
      item
        Name = '注册日期'
        Caption = '注册日期'
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
        GroupIndex = 1
        DataField = 'sdate0'
      end
      item
        Name = '启用日期'
        Caption = '启用日期'
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
        GroupIndex = 1
        DataField = 'sdate1'
      end
      item
        Name = '停用日期'
        Caption = '停用日期'
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
        GroupIndex = 1
        DataField = 'sdate2'
      end
      item
        Name = '绑定设备编号'
        Caption = '绑定设备编号'
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
        GroupIndex = 1
        DataField = 'lvol1'
      end
      item
        Name = '备注'
        Caption = '备注'
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
        GroupIndex = 1
        DataField = 'snote2'
      end
      item
        Name = '最后更新时间'
        Caption = '最后更新时间'
        FieldType = wftUndefined
        Features.Strings = ()
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GetPrevChar = '*'
        GroupIndex = 1
        DataField = 'scust_limit2'
      end>
    FieldsMonitors = <
      item
        MonitorValueChangedFields = 
          '|查询.操作标志|查询.商户号|查询.设备终端序列号|查询.省设备终端序' +
          '列号|查询.设备类型|查询.状态|查询.注册日期|查询.启用日期|查询.停' +
          '用日期|'
      end
      item
        MonitorValueChangedFields = 
          '|商户号|商户名称|设备终端序列号|蕓设备类型|状态|注册日期|启用日' +
          '期|停用日期|绑定设备编号|备注|'
      end>
    Left = 56
    Top = 264
  end
  inherited QueryRequest: TWVRequest
    ID = '商户设备管理查询'
    Bindings = <
      item
        ParamName = '查询结果集'
        FieldName = '查询结果集'
        Direction = bdParam2Field
      end
      item
        ParamName = '操作标志'
        FieldName = '操作标志'
      end
      item
        ParamName = '商户号'
        FieldName = '查询.商户号'
        DefaultValue = 0
      end
      item
        ParamName = '设备终端序列号'
        FieldName = '查询.设备终端序列号'
      end
      item
        ParamName = '省设备终端序列号'
        FieldName = '查询.省设备终端序列号'
      end
      item
        ParamName = '设备类型'
        FieldName = '查询.设备类型'
      end
      item
        ParamName = '状态'
        FieldName = '查询.状态'
      end
      item
        ParamName = '注册日期'
        FieldName = '查询.注册日期'
      end
      item
        ParamName = '启用日期'
        FieldName = '查询.启用日期'
      end
      item
        ParamName = '停用日期'
        FieldName = '查询.停用日期'
      end>
    Left = 192
    Top = 264
  end
  inherited QueryBinder: TWVDBBinder
    FieldName = '查询结果集'
    Bindings = <
      item
        FieldName = 'sstock_code'
        DataPresentType = 'idobjects'
        DataPresentParam = '221'
      end
      item
        FieldName = 'scurrency_type'
        DataPresentType = 'idobjects'
        DataPresentParam = '239'
      end>
    Left = 84
    Top = 295
  end
  inherited AddRequest: TWVRequest
    ID = '商户设备管理'
    Bindings = <
      item
        ParamName = '商户号'
        FieldName = '商户号'
      end
      item
        ParamName = '商户名称'
        FieldName = '商户名称'
      end
      item
        ParamName = '设备终端序列号'
        FieldName = '设备终端序列号'
      end
      item
        ParamName = '省设备终端序列号'
        FieldName = '省设备终端序列号'
      end
      item
        ParamName = '设备类型'
        FieldName = '设备类型'
      end
      item
        ParamName = '状态'
        FieldName = '状态'
      end
      item
        ParamName = '注册日期'
        FieldName = '注册日期'
      end
      item
        ParamName = '启用日期'
        FieldName = '启用日期'
      end
      item
        ParamName = '停用日期'
        FieldName = '停用日期'
      end
      item
        ParamName = '绑定设备编号'
        FieldName = '绑定设备编号'
      end
      item
        ParamName = '备注'
        FieldName = '备注'
      end
      item
        ParamName = '最后更新时间'
        FieldName = '最后更新时间'
      end
      item
        ParamName = '操作标志'
        FieldName = '操作标志'
      end>
    Left = 88
    Top = 264
  end
  inherited DeleteRequest: TWVRequest
    ID = '商户设备管理'
    Bindings = <
      item
        ParamName = '商户号'
        FieldName = '商户号'
      end
      item
        ParamName = '商户名称'
        FieldName = '商户名称'
      end
      item
        ParamName = '设备终端序列号'
        FieldName = '设备终端序列号'
      end
      item
        ParamName = '省设备终端序列号'
        FieldName = '省设备终端序列号'
      end
      item
        ParamName = '设备类型'
        FieldName = '设备类型'
      end
      item
        ParamName = '状态'
        FieldName = '状态'
      end
      item
        ParamName = '注册日期'
        FieldName = '注册日期'
      end
      item
        ParamName = '启用日期'
        FieldName = '启用日期'
      end
      item
        ParamName = '停用日期'
        FieldName = '停用日期'
      end
      item
        ParamName = '绑定设备编号'
        FieldName = '绑定设备编号'
      end
      item
        ParamName = '备注'
        FieldName = '备注'
      end
      item
        ParamName = '操作标志'
        FieldName = '操作标志'
      end>
    Left = 120
    Top = 264
  end
  inherited ChangeRequest: TWVRequest
    ID = '商户设备管理'
    Bindings = <
      item
        ParamName = '商户号'
        FieldName = '商户号'
      end
      item
        ParamName = '商户名称'
        FieldName = '商户名称'
      end
      item
        ParamName = '设备终端序列号'
        FieldName = '设备终端序列号'
      end
      item
        ParamName = '省设备终端序列号'
        FieldName = '省设备终端序列号'
      end
      item
        ParamName = '设备类型'
        FieldName = '设备类型'
      end
      item
        ParamName = '状态'
        FieldName = '状态'
      end
      item
        ParamName = '注册日期'
        FieldName = '注册日期'
      end
      item
        ParamName = '启用日期'
        FieldName = '启用日期'
      end
      item
        ParamName = '停用日期'
        FieldName = '停用日期'
      end
      item
        ParamName = '绑定设备编号'
        FieldName = '绑定设备编号'
      end
      item
        ParamName = '备注'
        FieldName = '备注'
      end
      item
        ParamName = '最后更新时间'
        FieldName = '最后更新时间'
      end
      item
        ParamName = '操作标志'
        FieldName = '操作标志'
      end>
    Left = 152
    Top = 264
  end
  inherited WVDataSource: TWVDataSource
    Left = 156
    Top = 303
  end
  inherited alDatasetActions: TActionList
    Left = 196
    Top = 300
  end
  object WVRequest1: TWVRequest
    WorkView = WorkView1
    ID = '商户信息维护查询'
    Bindings = <
      item
        ParamName = '查询结果集'
        FieldName = '查询结果集'
        Direction = bdParam2Field
      end
      item
        ParamName = '操作标志'
        FieldName = '操作标志'
      end
      item
        ParamName = '商户编号'
        FieldName = '查询.商户编号'
        DefaultValue = 0
      end
      item
        ParamName = '中心商户号'
        FieldName = '查询.中心商户号'
      end
      item
        ParamName = '商户状态'
        FieldName = '查询.商户状态'
      end
      item
        ParamName = '省商户编号'
        FieldName = '查询.省商户编号'
      end
      item
        ParamName = '商户名'
        FieldName = '查询.商户名'
      end
      item
        ParamName = '商户英文名称'
        FieldName = '查询.商户英文名称'
      end
      item
        ParamName = '商户简称'
        FieldName = '查询.商户简称'
      end
      item
        ParamName = '商户类型'
        FieldName = '查询.商户类型'
      end
      item
        ParamName = '行业类型'
        FieldName = '查询.行业类型'
      end>
    AfterExec = CheckReturnData
    Left = 400
    Top = 8
  end
  object WorkView1: TWorkView
    WorkFields = <
      item
        Name = '查询结果集'
        FieldType = wftUndefined
        DataType = kdtObject
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GroupIndex = 1
      end
      item
        Name = '操作类别.增加'
        Caption = '操作类别.增加'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DefaultValue = '1'
      end
      item
        Name = '操作类别.删除'
        Caption = '操作类别.删除'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DefaultValue = '2'
      end
      item
        Name = '操作类别.修改'
        Caption = '操作类别.修改'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        DefaultValue = '3'
      end
      item
        Name = '操作标志'
        Caption = '操作标志'
        FieldType = wftUndefined
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
        Name = '查询.商户编号'
        Caption = '查询.商户编号'
        FieldType = wftUndefined
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
        Name = '查询.中心商户号'
        Caption = '查询.中心商户号'
        FieldType = wftUndefined
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
        Name = '查询.商户状态'
        Caption = '查询.商户状态'
        FieldType = wftUndefined
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
        Name = '查询.省商户编号'
        Caption = '查询.省商户编号'
        FieldType = wftUndefined
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
        Name = '查询.商户名'
        Caption = '查询.商户名'
        FieldType = wftUndefined
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
        Name = '查询.商户英文名称'
        Caption = '查询.商户英文名称'
        FieldType = wftUndefined
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
        Name = '查询.商户简称'
        Caption = '查询.商户简称'
        FieldType = wftUndefined
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
        Name = '查询.商户类型'
        Caption = '查询.商户类型'
        FieldType = wftUndefined
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
        Name = '查询.行业类型'
        Caption = '查询.行业类型'
        FieldType = wftUndefined
        DataType = kdtString
        OwnObject = False
        Visible = False
        Constrained = True
        Checker.MinLength = 0
        Checker.MaxLength = 0
        Checker.LowerCase = False
        Checker.UpperCase = False
        GetPrevChar = '*'
      end>
    WorkProcesses = <>
    FieldsMonitors = <
      item
        MonitorValueChangedFields = 
          '|查询.操作标志|查询.商户编号|查询.中心商户号|查询.省商户编号|查' +
          '询.商户名|查询.商户英文名称|查询.商户简称|查询.商户类型|查询.行' +
          '业类型|查询.联系人|查询.电话|查询.手机|查询.电子信箱|查询.传真|' +
          '查询.营业地址|查询.邮政编码|查询.结算费率|查询.开户银行|查询.银' +
          '行账号|查询.银行帐户名|查询.联行号|查询.开户日期|查询.销户日期|' +
          '查询.销户状态|查询.商户状态|'
      end
      item
        MonitorValueChangedFields = 
          '|商户编号|中心商户号|省商户编号|商户名|商户英文名称|商户简称|商' +
          '户类型|行业类型|联系人|电话|手机|电子信箱|传真|营业地址|邮政编码' +
          '|结算费率|开户银行|银行账号|银行帐户名|联行号|开户日期|销户日期|' +
          '销户状态|'
      end>
    Left = 368
    Top = 8
  end
  object WVDBBinder1: TWVDBBinder
    DataSource = DataSource1
    WorkView = WorkView1
    FieldName = '查询结果集'
    Bindings = <
      item
        FieldName = 'sbranch_code0'
        WVFieldName = '商户类型'
        DataPresentType = 'idobjects'
        DataPresentParam = '216'
      end
      item
        FieldName = 'sbranch_code1'
        WVFieldName = '行业类型'
        DataPresentType = 'idobjects'
        DataPresentParam = '217'
      end
      item
        FieldName = 'sstatus1'
        WVFieldName = '商户状态'
        DataPresentType = 'idobjects'
        DataPresentParam = '224'
      end>
    HideUnbindingFields = False
    Left = 436
    Top = 7
  end
  object DataSource1: TDataSource
    OnStateChange = DataSourceStateChange
    OnDataChange = DataSourceDataChange
    Left = 468
    Top = 7
  end
end
