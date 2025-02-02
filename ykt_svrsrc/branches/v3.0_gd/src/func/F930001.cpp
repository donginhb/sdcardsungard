/* --------------------------------------------
 * 程序名称: F930002.sqc
 * 创建日期: 9 17 2004
 * 程序作者: 杜叶飞
 * 版本信息: 1.0.0.0
 * 程序功能: 下传设备时钟
 * --------------------------------------------
 * 修改日期:2004-12-14
 * 修改人员:	闻剑
 * 修改描述: 修改业务逻辑
 * 版本信息:1.0.0.1
 * 备注信息:
 * --------------------------------------------*/
#define _IN_SQC_                    
#include <string.h>
#include <stdio.h>
#include "pubfunc.h"
#include "pubdb.h"
#include "pubdef.h"
#include "errdef.h"
#include "dbfunc.h"
#include "acctrans.h"
#include "busqc.h"

int F930001(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg)
{
	int ret = 0;
	int cnt=0;
	int msgid=0;
	char sysdatetime[21]="";
    T_t_msglist tMsgList;
//	T_t_device tDevice;

	ST_CPACK aPack;
	ST_PACK *out_pack = &(aPack.pack);
	ResetNormalCPack(&aPack,0,1);

	memset(&tMsgList,0,sizeof(tMsgList));
//	memset(&tDevice,0,sizeof tDevice);
	
	tMsgList.deviceid = in_pack->lcert_code;
	if(!tMsgList.deviceid)
	{
		return E_INPUTNULL_DEVICE;
	}
//	ret = DB_t_device_read_by_deviceid(tMsgList.deviceid,&tDevice);
//	if(ret)
//	{
//		if(DB_NOTFOUND == ret)
//			return ERRINFO(E_NOTEXIST_DEVICE,tMsgList.deviceid);
//		else
//			return E_DB_DEVICE_R;
//	}
	des2src(sysdatetime,CAccTrans::getInstance()->trans.sysdatetime);
	AddXmlItemStr(tMsgList.reqdata,XML_KEY_CLOCK ,sysdatetime+2);	//yymmddhhmmss

	tMsgList.funcno = 930001;
	tMsgList.msglevel = 2;
	ret=AddMsgLst(&tMsgList);
	if(ret)
	{
		*pRetCode=ret;
		writelog(LOG_ERR,"AddMsgLst err[%d]",ret);
		goto L_RETU;
	}	
	if(iRequest!=tMsgList.funcno)
		return 0;	
	ret=db_commit();
	if(ret)
	{
		writelog(LOG_ERR,"db_commit ret[%d]",ret);
		*pRetCode=E_DB_COMMIT;
		goto  L_RETU;
	}
	msgid=tMsgList.msgid;
	for(cnt=0;(cnt<10)&&(tMsgList.errcode!=0);cnt++)
	{
		sleep(1);
		memset(&tMsgList,0,sizeof(tMsgList));
		ret=DB_t_msglist_read_by_msgid(msgid, &tMsgList);
		if(ret)
		{
			writelog(LOG_ERR,"DB_t_msglist_read_by_msgid err[%d]",ret);
			*pRetCode=E_DB_MSGLIST_R;
			goto L_RETU;
		}
	}
	switch(tMsgList.errcode)
	{
		case 0:		//成功
			des2src(out_pack->vsvarstr0,"成功");
			break;
		case 9999:		//交易未处理
			des2src(out_pack->vsvarstr0,"前置机无应答");
			break;
		default:			//交易已经处理,但结果是失败
			des2src(out_pack->vsvarstr0,tMsgList.errmsg);				
			break;
	}	
	SetCol(handle,0);
	SetCol(handle,F_LSERIAL1,F_SDATE0,F_SSERIAL0,F_VSVARSTR0,0);
	des2src(out_pack->sdate0,in_pack->sdate0);
	des2src(out_pack->sserial0,sysdatetime+2);	
	PutRow(handle,out_pack,pRetCode,szMsg);
	return 0;
L_RETU:
	return  -1;	
}





