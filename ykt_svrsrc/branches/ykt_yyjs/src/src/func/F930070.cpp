/* --------------------------------------------
 * 程序名称: F930070.sqc
 * 创建日期: 2007-08-12
 * 程序作者: 汤成
 * 版本信息: 1.0.0.0
 * 程序功能: 下载计费器报警金额
 * --------------------------------------------*/
#define _IN_SQC_                    
#include <string.h>
#include <stdio.h>
#include "pubfunc.h"
#include "pubdb.h"
#include "pubdef.h"
#include "errdef.h"
#include "dbfunc.h"
#include "dbfunc_foo.h"
#include "fdsqc.h"

int F930070(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg)
{
	int ret = 0;
	int cnt=0;
	int mesid=0;
	char sysdatetime[21]="";
       T_t_tif_meslist tMesList;
	T_t_pif_device tDevice;

	ST_CPACK aPack;
	ST_PACK *out_pack = &(aPack.pack);
	ResetNormalCPack(&aPack,0,1);

	memset(&tMesList,0,sizeof(tMesList));
	memset(&tDevice,0,sizeof tDevice);
	
	if(strlen(in_pack->sdate0)==0)
	{
		if(in_pack->lcert_code <= 0)
		{
			*pRetCode=E_DEVPHYID_NULL;
			goto L_RETU;
		}
		tMesList.devid = in_pack->lcert_code;
	}
	else
	{
		if((ret = get_devinfo_by_phyid(in_pack->sdate0,&tDevice)))
		{
			*pRetCode = ret;
			goto L_RETU;
		}
		tMesList.devid = tDevice.device_id;
	}
	
	getsysdatetime(sysdatetime);
	AddXmlItemInt(tMesList.incontent,XML_KEY_AMT,in_pack->lvol3*100);	

	tMesList.funid = 930070;
	tMesList.level = 2;
	tMesList.msgtype = MESLIST_TYPE_ORDER;
	ret=AddMsgLst(&tMesList);
	if(ret)
	{
		*pRetCode=ret;
		writelog(LOG_ERR,"AddMsgLst err[%d]",ret);
		goto L_RETU;
	}	
	if(iRequest!=tMesList.funid)
		return 0;	
	ret=db_commit();
	if(ret)
	{
		writelog(LOG_ERR,"db_commit ret[%d]",ret);
		*pRetCode=E_DB_COMMIT;
		goto  L_RETU;
	}
	mesid=tMesList.mesid;
	for(cnt=0;(cnt<10)&&(tMesList.ecode!=0);cnt++)
	{
		sleep(1);
		memset(&tMesList,0,sizeof(tMesList));
		ret=DB_t_tif_meslist_read_by_mesid(mesid, &tMesList);
		if(ret)
		{
			writelog(LOG_ERR,"DB_t_tif_meslist_read_by_mesid err[%d]",ret);
			*pRetCode=E_DB_MESLIST_R;
			goto L_RETU;
		}
	}
	switch(tMesList.ecode)
	{
		case 0:		//成功
			des2src(out_pack->vsvarstr0,"成功");
			break;
		case 9999:		//交易未处理
			des2src(out_pack->vsvarstr0,"前置机无应答");
			break;
		default:			//交易已经处理,但结果是失败
			des2src(out_pack->vsvarstr0,tMesList.emsg);				
			break;
	}	
	SetCol(handle,0);
	SetCol(handle,F_VSVARSTR0,0);
	PutRow(handle,out_pack,pRetCode,szMsg);
	return 0;
L_RETU:
	return  -1;	
}

