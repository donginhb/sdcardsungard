unit UACardUsedInfo_R;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UqhSimpleQueryTemp, WVCmdReq, WorkViews, Grids, DBGrids, StdCtrls,
  ImageCtrls, ExtCtrls, UICtrls, WVCtrls, Mask, WVDBBinders, Db, WVCmdProc,
  KCWVProcBinds, WVCmdTypeInfo, RzDBGrid, Buttons, UIncrementComboBox,
  UReportMachineTemp, RM_Common, RM_Class, RM_e_main, RM_e_Xls,
  RM_Designer, RM_Dataset, ImgList, RM_Preview, RzPanel, RzButton,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractTable,
  RM_e_Jpeg, RM_e_Graphic, RM_e_bmp, RM_e_htm;

type
  TfaqhCardUsedInfo_R = class(TfaReportMachineTemp)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbbCardType: TWVComboBox;
    cbbOperTrans: TWVComboBox;
    cbbNetInfo: TWVComboBox;
    WVLabel1: TWVLabel;
    edtBeginDate: TWVEdit;
    WVLabel2: TWVLabel;
    edtEndDate: TWVEdit;
    ztbl1: TZTable;
    procedure WorkViewFieldsMonitors0ValueChanged(Sender: TWVFieldMonitor;
      Valid: Boolean);
    procedure btnQueryClick(Sender: TObject);
  private

    { Private declarations }
    strBDate,strEDate:string;
    endSign:Boolean;
  public
    procedure Init; override;
    { Public declarations }
  end;

var
  faqhCardUsedInfo_R: TfaqhCardUsedInfo_R;

implementation

uses KsFrameworks, KSFrameWorkUtils, KSComCmdDefs, KSCustomers, SmartCardCommon,
     KSClientConsts,KSDataDictionary,DataUsageUtils, UCMqhReportImp,
  UrptTbl;
     
{$R *.DFM}

procedure TfaqhCardUsedInfo_R.Init;
begin
  inherited;
  endSign := True;
  if Context.ParamData(svOperatorNoName).AsString='system' then
  begin
    cbbOperTrans.ItemIndex := 0;
  end
  else
  begin
    WorkView.FieldByName('操作员号').DefaultValue  := Context.ParamData(svOperatorNoName).AsString;
    WorkView.Reset;
  end;
  edtBeginDate.Text := bAccountDate;
  edtEndDate.Text := bAccountDate;

end;

procedure TfaqhCardUsedInfo_R.WorkViewFieldsMonitors0ValueChanged(
  Sender: TWVFieldMonitor; Valid: Boolean);
begin
  inherited;
  btnQuery.Enabled:=Valid;
end;

procedure TfaqhCardUsedInfo_R.btnQueryClick(Sender: TObject);
var
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
  inherited;
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
  if execSQL_SLite(delrptOperCard)<>0 then
    Exit;
  //execSQL(delrptOperCard);
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
      qry.SQL.Add(irptOperCardSql(tmpData));
      qry.ExecSQL;
      tmpData.Next;
    end;
    if execSQL_SLite(commitTrans)<>0 then
      Exit;
  finally
    qry.Close;
    qry.Destroy;
  end;
  rptReport.LoadFromFile(sPreAppPath+'report\操作员卡片使用情况表.rmf');
  ztbl1.TableName := 'T_RPTOPERCARD';
  if ztbl1.Active=True then
    ztbl1.Active := False;
  ztbl1.Active := True;
  if (strBDate<>'') and (strEDate<>'') then
    rptReport.Dictionary.Variables.AsString['dateRange'] := '统计日期：'+strBDate+'至'+strEDate;
  rptReport.Dictionary.Variables.AsString['rptTitle'] := rptTitle;
  rptReport.Dictionary.Variables.AsString['rptOper'] := rptOper;
  rptReport.Dictionary.Variables.AsString['checkOper'] := Context.ParamData(svOperatorNameName).AsString;
  rptReport.DoublePass := True;
  rptReport.Preview := rmprvwP;
  rptReport.ShowReport;
  endSign := True;
end;

initialization
  TUIStdClassFactory.Create('卡片使用情况汇总_R',TfaqhCardUsedInfo_R);

end.