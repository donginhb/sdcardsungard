unit UABusiPayIn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UqhSimpleQueryTemp, WVCmdReq, WorkViews, Grids, DBGrids, StdCtrls,
  ImageCtrls, ExtCtrls, UICtrls, WVCtrls, Mask, WVDBBinders, Db, WVCmdProc,
  KCWVProcBinds, WVCmdTypeInfo, RzDBGrid, Buttons, UIncrementComboBox,
  EditExts, ComCtrls, RzTreeVw, RzPanel, RzSplit, UqhTreeSimQryTemp,KsBranchTree,contnrs;
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

type
  TfaqhBusiPayIn = class(TfaqhTreeSimQryTemp)
    Panel1: TPanel;
    WorkView1: TWorkView;
    WVRequest1: TWVRequest;
    lbl1: TLabel;
    btnPayIn: TBitBtn;
    edtMoney: TWVDigitalEdit;
    lblCustname: TLabel;
    WorkView2: TWorkView;
    QueryRequest2: TWVRequest;
    lbl2: TLabel;
    lblBusiName: TLabel;
    procedure WorkViewFieldsMonitors0ValueChanged(Sender: TWVFieldMonitor;
      Valid: Boolean);
    procedure btnPayInClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure GridCellClick(Column: TColumn);
    procedure tvCustClick(Sender: TObject);
  private

    { Private declarations }
    FList: TObjectList;
    custId:integer;
    custName:string;
    //刷新商户树
    procedure RefreshCurrentTree();
    procedure   BuildTree();
    procedure   InternalBuildTree(AInfo: TUIInfo; Parent: TTreeNode);
  public
    procedure Init; override;
    { Public declarations }
  end;

var
  faqhBusiPayIn: TfaqhBusiPayIn;

implementation

uses KsFrameworks, KSFrameWorkUtils, KSComCmdDefs, KSCustomers,
     KSClientConsts,KSDataDictionary,DataUsageUtils,SmartCardCommon;
     
{$R *.DFM}

procedure TfaqhBusiPayIn.Init;
begin
  inherited;
  if FInfoAdmin<>nil then
  begin
    FInfoAdmin.Free ;
  end;
  FInfoAdmin := TInfoAdmin.Create;

  //TreeView.ControlStyle := TreeView.ControlStyle - [csDoubleClicks];
  FList := TObjectList.Create;
  RefreshCurrentTree;
end;

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

procedure TfaqhBusiPayIn.WorkViewFieldsMonitors0ValueChanged(
  Sender: TWVFieldMonitor; Valid: Boolean);
begin
  inherited;
  btnQuery.Enabled:=Valid;
end;

procedure TfaqhBusiPayIn.btnPayInClick(Sender: TObject);
var
  busiName:string;
  busiId:Integer;
  tmpdata:TDataSet;
begin
  if WorkView.FieldByName('查询结果集').Data.IsEmpty then
  begin
    Context.GetDialogSystem.ShowMessage('请先选择要解款的商户，然后再进行解款操作！');
    Exit;
  end;
  tmpData := TDataSet(WorkView.FieldByName('查询结果集').Data.AsObject);
  busiId := tmpdata.fieldbyname('lvol3').AsInteger;
  busiName := tmpdata.fieldbyname('vsvarstr0').AsString;
  if Application.MessageBox(PChar('你确定要为商户【'+businame+'】解款吗？'),PChar(Application.Title),MB_YESNO+mb_iconquestion)=idno then
    Exit;
  WorkView1.FieldByName('商户号').Data.SetInteger(busiId);
  WorkView1.FieldByName('解款金额').Data.SetFloat(StrToFloat(edtMoney.Text));
  WVRequest1.SendCommand;
  if WorkView1.FieldByName('返回码').Data.AsInteger=0 then
    Context.GetDialogSystem.ShowMessage('商户['+businame+']解款成功！');
end;

procedure TfaqhBusiPayIn.btnQueryClick(Sender: TObject);
var
  tmpData:TDataSet;
begin
  //inherited;
  WorkView.FieldByName('商户号').Data.SetInteger(custId);
  MainRequest.SendCommand;
  if WorkView.FieldByName('查询结果集').Data.IsEmpty then
  begin
    btnPayIn.Enabled := False;
    Exit
  end
  else
  begin
    Grid.DataSource.DataSet.Last;
    //WorkView1.FieldByName('解款金额').Data.SetFloat(Grid.DataSource.DataSet.fieldbyname('damt0').AsFloat);
    edtMoney.Text := Grid.DataSource.DataSet.fieldbyname('damt0').AsString;
    btnPayIn.Enabled := True;
  end;

end;

procedure TfaqhBusiPayIn.GridCellClick(Column: TColumn);
var
  tmpdata:TDataSet;
begin
  tmpData := TDataSet(WorkView.FieldByName('查询结果集').Data.AsObject);
  try
    edtMoney.Text := tmpdata.fieldbyname('damt0').AsString;
    lblBusiName.Caption := tmpdata.fieldbyname('vsvarstr0').AsString;
  except

  end;
end;

procedure TfaqhBusiPayIn.RefreshCurrentTree;
begin
  try
    WorkView2.FieldByName('商户标识').Data.SetInteger(0);
    QueryRequest2.SendCommand;

    self.FDataSetFieldID:='lvol3';
    self.FDataSetParentFieldID:='lvol1';
    self.FDataSetFieldName:='sall_name';
    self.FDataSet:= (WorkView2.FieldByName('查询结果集').Data.AsObject) as TDataSet;
    self.BuildTree;
  except
    on e:Exception do
      Context.GetDialogSystem.ShowMessage(e.Message);
  end;
end;

procedure TfaqhBusiPayIn.tvCustClick(Sender: TObject);
begin
  if not tvTree.Selected.Selected then
    exit;
  try
    custId:=PMyRec(tvTree.Selected.Data)^.id;
    custName:=PMyRec(tvTree.Selected.Data)^.name;
  except
    on ex:Exception do
    begin
      Context.GetDialogSystem.ShowMessage(ex.Message);
      Exit;
    end;
  end;
  lblCustname.Caption := '当前选择的商户:'+inttostr(custid)+'--'+custName;
end;

procedure TfaqhBusiPayIn.BuildTree;
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

procedure TfaqhBusiPayIn.InternalBuildTree(AInfo: TUIInfo;Parent: TTreeNode);
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

initialization
  TUIStdClassFactory.Create('商户解款',TfaqhBusiPayIn);

end.