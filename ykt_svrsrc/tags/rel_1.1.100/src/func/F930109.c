/* --------------------------------------------
 * 程序名称: F930109.c
 * 创建日期: 2005-09-02
 * 程序作者: 闻剑
 * 版本信息: 1.0.0.0
 * 程序功能:下传计时宝节假日
 * --------------------------------------------
 * 修改日期:
 * 修改人员:
 * 修改描述:
 * 版本信息:
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

int F930109(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg)
{
	int ret = 0;
	T_t_tif_meslist tMesList;

	memset(&tMesList,0,sizeof(tMesList));

	des2src(tMesList.devphy999_id, in_pack->sdate0);
	trim(tMesList.devphy999_id);
	if(strlen(tMesList.devphy999_id)==0)
	{
		*pRetCode=E_DEVPHYID_NULL;
		goto L_RETU;
	}
	AddXmlItemInt(tMesList.incontent,XML_KEY_OUTNUM,in_pack->lvol5);		//条数
	AddXmlItemStr(tMesList.incontent,XML_KEY_HOLIDAY,in_pack->vsvarstr0);	//节假日
	//FIXME
	//需要查询节假日表下传
	//FIXME
	tMesList.funid = 930109;
	tMesList.level =1;
	tMesList.max_send_cnt = 10;
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





