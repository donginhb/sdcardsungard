/* --------------------------------------------
 * 程序名称: F930201.sqc
 * 创建日期: 2005-11-22
 * 程序作者: 汤成
 * 版本信息: 1.0.0.0
 * 程序功能: 通知计时宝需要下载名单
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


int F930201(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg)
{
	int ret;
	T_t_tif_meslist tMeslist;
	T_t_pif_device tDevice;
	memset(&tDevice,0,sizeof tDevice);
	
	memset(&tMeslist,0,sizeof tMeslist);
	if(strlen(in_pack->sdate0) != 8)
	{
		return E_DEVPHYID_NULL;
	}
	tMeslist.funid = 930201;
	tMeslist.level = 2;
	tMeslist.max_send_cnt = 10;
	tMeslist.del_flag[0] = '0';
	AddXmlItemStr(tMeslist.incontent,XML_KEY_DEVPHY999_NO,in_pack->sdate0);
	if((ret = get_devinfo_by_phyid(in_pack->sdate0,&tDevice)))
	{
		*pRetCode = ret;
		goto L_RETU;
	}
	tMeslist.devid = tDevice.device_id;
	ret = DB_t_tif_meslist_del_by_devid_and_funid(tMeslist.devid,tMeslist.funid);
	if(ret)
	{
		if(ret != DB_NOTFOUND)
		{
			*pRetCode = E_DB_MESLIST_D;
			goto L_RETU;
		}
	}
	ret = AddMsgLst(&tMeslist);
	if(ret)
	{
		writelog(LOG_ERR,"add message list 930201 error!");
		*pRetCode = E_DB_MESLIST_I;
		goto L_RETU;
	}
	return 0;
L_RETU:
		return -1;
}
