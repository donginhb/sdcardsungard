unit UASubjectBalanceReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UqhSimpleQueryTemp, WVCmdReq, WorkViews, Grids, DBGrids, StdCtrls,
  ImageCtrls, ExtCtrls, UICtrls, WVCtrls, Mask, WVDBBinders, Db, 
  RzDBGrid, ComCtrls, RzTreeVw, RzGrids,
  RzCmboBx, RzPanel, RzSplit, UIncrementComboBox,
  Buttons, UReportMachineTemp, RM_Common, RM_Class, RM_e_main, RM_e_Xls,
  RM_Designer, RM_Dataset, ImgList, RM_Preview, RzButton,
  ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset, RM_e_htm,
  RM_e_Graphic, RM_e_Jpeg, RM_e_bmp;
type
  PMyRec = ^TMyRec;
  TMyRec = record
    id: Integer;
    name: string;
end;
type
  TfaqhSubjectBalanceReport = class(TfaReportMachineTemp)
    Panel1: TPanel;
    lbl1: TLabel;
    lblBusiName: TLabel;
    WVLabel1: TWVLabel;
    edtBeginDate: TWVEdit;
    WVLabel2: TWVLabel;
    edtEndDate: TWVEdit;
    cbbBusiName: TWVComboBox;
    ztbl1: TZTable;
    procedure WorkViewFieldsMonitors0ValueChanged(Sender: TWVFieldMonitor;
      Valid: Boolean);
    procedure btnQueryClick(Sender: TObject);
  private

    { Private declarations }
    endSign:Boolean;
    strBDate,strEDate:string;
  public
    procedure Init; override;
    { Public declarations }
  end;

var
  faqhSubjectBalanceReport: TfaqhSubjectBalanceReport;

implementation

uses KsFrameworks, KSFrameWorkUtils, KSClientConsts,SmartCardCommon,
  UCMqhReportImp, UrptTbl;

{$R *.DFM}

procedure TfaqhSubjectBalanceReport.Init;
begin
  inherited;
  endSign := True;
  edtBeginDate.Text := bAccountDate;
  edtEndDate.Text := bAccountDate;
end;

procedure TfaqhSubjectBalanceReport.WorkViewFieldsMonitors0ValueChanged(
  Sender: TWVFieldMonitor; Valid: Boolean);
begin
  inherited;
  btnQuery.Enabled:=Valid;
end;

procedure TfaqhSubjectBalanceReport.btnQueryClick(Sender: TObject);
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
  if execSQL_SLite(delrptsubjbal)<>0 then
    Exit;
  qry := nil;
  try
    qry := TZQuery.Create(nil);
    qry.Connection := dmReportImp.conSLite;
    tmpData.First;
    if execSQL_SLite(beginTrans)<>0 then
      Exit;
    while not tmpData.Eof do
    begin
      {
      if Trim(tmpData.fieldbyname('sdate3').AsString)='' then
      begin
        tmpData.Next;
        Continue;
      end;
      }
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add(irptsubjbalSql(tmpData));
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
    rptReport.LoadFromFile(sPreAppPath+'report\科目余额表.rmf');
    ztbl1.TableName := 'T_RPTSUBJBAL';
    if ztbl1.Active=True then
      ztbl1.Active := False;
    ztbl1.Active := True;
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

initialization
  TUIStdClassFactory.Create('科目余额表',TfaqhSubjectBalanceReport);

end.