/* --------------------------------------------
 * 程序名称: F930019.sqc
 * 创建日期: 9 17 2004
 * 程序作者: 杜叶飞
 * 版本信息: 1.0.0.0
 * 程序功能:采集设备结账流水（历史）
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
#include "fdsqc.h"

int F930019(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg)
{
	int ret = 0;
       T_t_tif_meslist tMesList;
	T_t_pif_device tDevice;
	memset(&tDevice,0,sizeof tDevice);

	memset(&tMesList,0,sizeof(tMesList));

	if(strlen(in_pack->sdate0)==0)
	{
		*pRetCode=E_DEVPHYID_NULL;
		goto L_RETU;
	}
//	AddXmlItemInt(tMesList.incontent,XML_KEY_FEETYPE, in_pack->lvol3);
	AddXmlItemInt(tMesList.incontent,XML_KEY_STARTNUM,in_pack->lvol5);
	AddXmlItemInt(tMesList.incontent,XML_KEY_ENDNUM,in_pack->lvol6);

	if((ret = get_devinfo_by_phyid(in_pack->sdate0,&tDevice)))
	{
		*pRetCode = ret;
		goto L_RETU;
	}
	tMesList.devid = tDevice.device_id;
	tMesList.funid = iRequest;
	tMesList.level = 1;
	ret=AddMsgLst(&tMesList);
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





