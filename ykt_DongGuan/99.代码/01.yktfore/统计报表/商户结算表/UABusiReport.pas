unit UABusiReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UqhSimpleQueryTemp, WVCmdReq, WorkViews, Grids, DBGrids, StdCtrls,
  ImageCtrls, ExtCtrls, UICtrls, WVCtrls, Mask, WVDBBinders, Db, 
  RzDBGrid, RzPanel, RzSplit, ComCtrls, RzTreeVw, Buttons,
  UReportMachineTemp, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  RM_e_Jpeg, RM_e_Graphic, RM_e_bmp, RM_Common, RM_Class, RM_e_main,
  RM_e_htm, RM_Designer, RM_Dataset, ImgList, RM_Preview, RzButton,
  UTreeRptTemp,KsBranchTree,contnrs, RM_e_Xls, RzListVw;
{
type
  PMyRec = ^TMyRec;
  TMyRec = record
    id: Integer;
    name: string;
end;
type
  TTreeNodeInfoData = class
  private
    FMetaNode: TKSMetaNode;

  protected

  public
    constructor Create(AMetaNode: TKSMetaNode);
    function    GetCaption : string;
    function    GetID : string;
    property    MetaNode: TKSMetaNode read FMetaNode;
  end;
}

type
  TfaqhBusiReport = class(TfaTreeRptTemp)
    Panel1: TPanel;
    edtBeginDate: TWVEdit;
    lbl1: TLabel;
    Label1: TLabel;
    edtEndDate: TWVEdit;
    pnl1: TPanel;
    zqry1: TZQuery;
    lbl2: TLabel;
    cbbleave: TComboBox;
    WorkView4: TWorkView;
    QueryRequest: TWVRequest;
    Panel2: TPanel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    WVEdit3: TWVEdit;
    WVEdit1: TWVEdit;
    WVEdit2: TWVEdit;
    WVEdit6: TWVEdit;
    btnBusiQ: TBitBtn;
    lvBusi: TRzListView;
    procedure tvtreeClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnBusiQClick(Sender: TObject);
    procedure lvBusiClick(Sender: TObject);
  private

    { Private declarations }
    endSign:Boolean;
    strBDate,strEDate:string;
    custId:integer;
    custName:string;
    {
    FList: TObjectList;
    //刷新商户树
    procedure RefreshCurrentTree();
    procedure getLeval;
    procedure   BuildTree();
    procedure   InternalBuildTree(AInfo: TUIInfo; Parent: TTreeNode);
    }
  public
    procedure Init; override;
    { Public declarations }
  end;

var
  faqhBusiReport: TfaqhBusiReport;

implementation

uses KsFrameworks,KSClientConsts,SmartCardCommon, UCMqhReportImp, UrptTbl,KSDataDictionary;
     
{$R *.DFM}

procedure TfaqhBusiReport.Init;
begin
  inherited;
  {
  if FInfoAdmin<>nil then
  begin
    FInfoAdmin.Free ;
  end;
  FInfoAdmin := TInfoAdmin.Create;

  //TreeView.ControlStyle := TreeView.ControlStyle - [csDoubleClicks];
  FList := TObjectList.Create;

  RefreshCurrentTree;
  getLeval;
  }
  edtBeginDate.Text := bAccountDate;
  edtEndDate.Text := bAccountDate;
  endSign := True;
end;
{
constructor TTreeNodeInfoData.Create(AMetaNode: TKSMetaNode);
begin
  Assert(AMetaNode<>nil);
  inherited Create;
  FMetaNode := AMetaNode;
end;

function TTreeNodeInfoData.GetCaption: string;
begin
  Result := FMetaNode.Caption;
end;

function TTreeNodeInfoData.GetID: string;
begin
  Result := FMetaNode.Id ;
end;

procedure TfaqhBusiReport.RefreshCurrentTree;
begin
  try
    WorkView1.FieldByName('操作标志').Data.SetString('R');
    WorkView1.FieldByName('商户标识').Data.SetInteger(0);
    WVRequest1.SendCommand;

    self.FDataSetFieldID:='lvol3';
    self.FDataSetParentFieldID:='lvol1';
    self.FDataSetFieldName:='sall_name';
    
    self.FDataSet:= (WorkView1.FieldByName('查询结果集').Data.AsObject) as TDataSet;
    BuildTree;
  except
    on e:Exception do
      Context.GetDialogSystem.ShowMessage(e.Message);
  end;
end;
}
procedure TfaqhBusiReport.tvtreeClick(Sender: TObject);
begin
  {
  if not tvTree.Selected.Selected then
    exit;
  custId:=PMyRec(tvTree.Selected.Data)^.id;
  custName:=PMyRec(tvTree.Selected.Data)^.name;
  pnl1.Caption := ' '+inttostr(custid)+'--'+custName;
  }
end;

procedure TfaqhBusiReport.btnQueryClick(Sender: TObject);
var
  //subId,subName:string;
  tmpData:TDataSet;
  qry:TZQuery;

begin
  if Trim(edtEndDate.Text)<>'' then
    if CheckInputDateFormat(edtEndDate.Text)=False then
    begin
      Context.GetDialogSystem.ShowMessage('结束日期输入不正确，格式：yyyymmdd');
      edtEndDate.SetFocus;
      Exit;
    end;
  if Trim(edtBeginDate.Text)<>'' then
    if CheckInputDateFormat(edtBeginDate.Text)=False then
    begin
      Context.GetDialogSystem.ShowMessage('开始日期输入不正确，格式：yyyymmdd');
      edtBeginDate.SetFocus;
      Exit;
    end;
  if (Trim(edtEndDate.Text)<>'') and (Trim(edtBeginDate.Text)<>'') then
    if Trim(edtBeginDate.Text)>Trim(edtEndDate.Text) then
      Context.GetDialogSystem.ShowMessage('开始日期不能大于结束日期！');
  WorkView.FieldByName('显示级别').Data.SetInteger(cbbleave.ItemIndex+1);
  //WorkView.FieldByName('商户账号').Data.SetInteger(custId);
  MainRequest.SendCommand;
  strBDate := edtBeginDate.Text;
  strEDate := edtEndDate.Text;
  
  tmpData := TDataSet(WorkView.FieldByName('查询结果集').Data.AsObject);
  if tmpData.IsEmpty then
  begin
    Context.GetDialogSystem.ShowMessage('数据统计表没有相关记录，请重新指定条件');
    Exit;
  end;
  if endSign = False then
    Exit;
  endSign := False;
  if execSQL_SLite(delrptAccLeager)<>0 then
    Exit;
  //execSQL(delrptAccLeager);
  qry := nil;
  try
    qry := TZQuery.Create(nil);
    qry.Connection := dmReportImp.conSLite;
    if execSQL_SLite(beginTrans)<>0 then
      Exit;
    tmpData.First;
    while not tmpData.Eof do
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add(irptAccLeager(tmpData));
      qry.ExecSQL;
      tmpData.Next;
    end;
    if execSQL_SLite(commitTrans)<>0 then
      Exit;
  finally
    qry.Close;
    qry.Destroy;
  end;
  try
    rptReport.LoadFromFile(sPreAppPath+'report\商户分类结算表.rmf');
    //ztbl1.TableName := 't_rptsysstat';
    if zqry1.Active=True then
      zqry1.Active := False;
    zqry1.Active := True;
    rptReport.Dictionary.Variables.AsString['dateRange'] := '统计日期：'+strBDate+'至'+strEDate;
    rptReport.Dictionary.Variables.AsString['rptTitle'] := rptTitle;
    rptReport.Dictionary.Variables.AsString['rptOper'] := rptOper;
    rptReport.Dictionary.Variables.AsString['checkOper'] := Context.ParamData(svOperatorNameName).AsString;
    rptReport.DoublePass := True;
    rptReport.Preview := rmprvwP;
    rptReport.ShowReport;
  except
    Context.GetDialogSystem.ShowMessage('你没有安装打印机，请先安装(可以是虚拟打印机)！');
  end;
  endSign := True;
end;
{
procedure TfaqhBusiReport.getLeval;
var
  i,j:integer;
  currlevel:integer;
  totlevel:integer;
begin
  totlevel:=0;
  for i := 0 to tvTree.Items.Count-1 do
  begin
    currlevel:=tvTree.Items[i].Level;
    if totlevel<currlevel then
      totlevel := currlevel;
  end;
  cbbleave.Items.Clear;
  for j := 1 to totlevel+1 do
    cbbleave.Items.Add('第'+inttostr(j)+'级');

  cbbleave.ItemIndex:=0;
end;

procedure TfaqhBusiReport.BuildTree();
begin
  tvTree.Items.BeginUpdate;
  try
    tvTree.Items.Clear;
    if FInfoAdmin=nil then Exit;
    ReadTreeInfoFromDataSet(FDataSet,FInfoAdmin);
    InternalBuildTree(FInfoAdmin.Root, nil);
    //tvTree.FullExpand ;
  finally
    tvTree.Items.EndUpdate;
  end;
end;

procedure TfaqhBusiReport.InternalBuildTree(AInfo: TUIInfo;Parent: TTreeNode);
var
  I: Integer;
  Node: TTreeNode;
  InfoData: TTreeNodeInfoData;
  MyRecPtr: PMyRec;
begin
  // 创建对应的数据对象
  InfoData := TTreeNodeInfoData.Create(AInfo.MetaNode);
  FList.Add(InfoData);
  New(MyRecPtr);
  MyRecPtr^.id := StrToInt(InfoData.GetID);
  MyRecPtr^.name := InfoData.GetCaption;
  Node := tvTree.Items.AddChildObject(Parent,InfoData.GetCaption,MyRecPtr);
  // 如果包含子节点，构造它们
  if AInfo is TUIInfoGroup then
    for I := 0 to TUIInfoGroup(AInfo).Count - 1 do
      InternalBuildTree(TUIInfoGroup(AInfo).Items[I],Node);
end;
}

procedure TfaqhBusiReport.btnBusiQClick(Sender: TObject);
var
  tmpItem: TListItem;
  tmpdata:TDataSet;
begin
  WorkView4.FieldByName('操作标志').Data.SetString('R');
  QueryRequest.SendCommand;
  if WorkView4.FieldByName('返回码').Data.AsInteger<>0 then
  begin
    Context.GetDialogSystem.ShowMessage(WorkView4.FieldByName('返回信息').Data.AsString);
    Exit;
  end;
  lvBusi.Items.Clear;

  tmpdata := TDataSet(WorkView4.FieldByName('查询结果集').Data.AsObject);
  tmpdata.First;
  while not tmpdata.eof do
  begin
    tmpItem := lvBusi.Items.Add;
    //商户编号
    tmpItem.Caption := tmpdata.fieldbyname('lvol0').AsString;
    //商户名称
    tmpItem.SubItems.Add(tmpdata.fieldbyname('snote').AsString);
    //中心商户号
    tmpItem.SubItems.Add(tmpdata.fieldbyname('sname').AsString);
    //省商户编号
    tmpItem.SubItems.Add(tmpdata.fieldbyname('sname2').AsString);
    //商户类型
    tmpItem.SubItems.Add(GetIdObjectName(216,tmpdata.fieldbyname('sbranch_code0').AsString));
    //行业类型
    tmpItem.SubItems.Add(GetIdObjectName(217,tmpdata.fieldbyname('sbranch_code1').AsString));
    tmpdata.Next;
  end;
end;

procedure TfaqhBusiReport.lvBusiClick(Sender: TObject);
var
  i:Integer;
begin
  try
    i:=lvBusi.Selected.Index;
    custId := StrToInt(lvBusi.Items.Item[i].Caption);
    custName := lvBusi.Items.Item[i].SubItems[0];
    pnl1.Caption := ' 当前选择商户-'+custName;
  except

  end;
end;

initialization
  TUIStdClassFactory.Create('商户分类结算表',TfaqhBusiReport);

end.