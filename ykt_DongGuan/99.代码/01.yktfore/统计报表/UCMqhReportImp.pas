unit UCMqhReportImp;
                                            
interface                                            
  
uses  
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,                                            
  KSCmdModules, WVCmdProc, KCWVProcBinds, Db, BDAImpEx, KCDataAccess,
  ZConnection,NativeXml;

type                                            
  TdmReportImp = class(TCommandModule)
    cqSetOperator: TKCWVQuery;
    KCTradeSubject: TKCWVQuery;
    KCTotSubject: TKCWVQuery;
    KCWSubBalanceRep: TKCWVQuery;
    KCWBusiReport: TKCWVQuery;
    kcTicketCashRpt_R: TKCWVQuery;
    KCWBusiReportDay: TKCWVQuery;
    Dataset: TKCDataset;
    kcBusiGatherRep: TKCWVQuery;
    kcSubject: TKCWVQuery;
    KCCashRpt: TKCWVQuery;
    kcBusiRunStatRpt: TKCWVQuery;
    kcOperRpt: TKCWVQuery;
    kcOperCashTot: TKCWVQuery;
    conSLite: TZConnection;
    cqSetBusiInfo: TKCWVQuery;
    KCAtmRpt: TKCWVQuery;
    KCReFillTermRtp: TKCWVQuery;
    KCExpendRpt: TKCWVQuery;
    KCPkgFileRpt: TKCWVQuery;
    KCTradeStat: TKCWVQuery;
    KCPersonStat: TKCWVQuery;
    KCPubCardStat: TKCWVQuery;
    KCBusiBalQ: TKCWVQuery;
    KCPatchPay: TKCWVQuery;
    cqPayFileQ: TKCWVQuery;
    cqPayDetailQ: TKCWVQuery;
  private  
    { Private declarations }  
  public  
    { Public declarations }
    procedure Init; override;
  end;                                            
                                            
var  
  dmReportImp: TdmReportImp;                                
                                            
implementation                                            

uses SmartCardCommon,KSClientConsts;
{$R *.DFM}
                                
{ TdmReportImp }

procedure TdmReportImp.Init;
var
  dbPath:string;
begin
  inherited;
  dbPath := ExtractFilePath(Application.ExeName);
  {
  try
    if conFB.Connected then
      conFB.Connected := False;
    conFB.Database := dbPath+'\YKTDB.FDB';
    conFB.Connected;
  except
    on e:Exception do
      ShowMessage('打开FB数据库失败-'+e.Message);
  end;
  }
  try
    if conSLite.Connected then
      conSLite.Connected := False;
    conSLite.Database :=sdAnsiToUtf8(dbPath+'\YKTDB.db3') ;
    conSLite.Connected;
  except
    on e:Exception do
      ShowMessage('打开SQLite数据库失败，安装目录不能是中文-'+e.Message);
  end;
end;

initialization
dmReportImp:=TdmReportImp.Create(Application);                                
                                            
end.                                            
                                           
                                          
                                         
                                        

                                      
  
                                    
                                   
                                  
                                 
                                
                               
                              
                             
                            
                           
                          
                         
                        
                       
                      
                     
                    
                   
                  
                 
                
               
              
             
            
           
          
         
        
       
      
     
    
   
  
 

