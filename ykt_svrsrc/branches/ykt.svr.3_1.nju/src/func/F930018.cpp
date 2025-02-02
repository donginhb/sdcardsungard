/* --------------------------------------------
 * 程序名称: F930018.sqc
 * 创建日期: 9 17 2004
 * 程序作者: 杜叶飞
 * 版本信息: 1.0.0.0
 * 程序功能:采集现金充值流水（历史）
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
#include "busqc.h"

int F930018(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg)
{
	int ret = 0;
       T_t_msglist tMsgList;
//	T_t_device tDevice;
//	memset(&tDevice,0,sizeof tDevice);

	memset(&tMsgList,0,sizeof(tMsgList));

	tMsgList.deviceid = in_pack->lcert_code;
	if(!tMsgList.deviceid)
	{
		return E_INPUTNULL_DEVICE;
	}

	AddXmlItemInt(tMsgList.reqdata,XML_KEY_FEETYPE, in_pack->lvol4);
	AddXmlItemInt(tMsgList.reqdata,XML_KEY_STARTNUM,in_pack->lvol5);
	AddXmlItemInt(tMsgList.reqdata,XML_KEY_ENDNUM,in_pack->lvol6);

//	if((ret = get_devinfo_by_phyid(in_pack->sdate0,&tDevice)))
//	{
//		*pRetCode = ret;
//		goto L_RETU;
//	}
//	tMsgList.deviceid = tDevice.deviceid;
	tMsgList.funcno = 930018;
	tMsgList.msglevel = 1;
	ret=AddMsgLst(&tMsgList);
	if(ret)
	{
		*pRetCode=ret;
		writelog(LOG_ERR,"AddMsgLst err[%d]",ret);
		goto L_RETU;
	}
	return 0;
L_RETU:
	return  -1;	
}





