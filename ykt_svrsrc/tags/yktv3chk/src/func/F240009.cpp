/* --------------------------------------------
 * 程序名称: F240009.sqc
 * 创建日期: 2007-07-21
 * 程序作者: 韩海东
 * 版本信息: 1.0.0.0
 * 程序功能: 判断设备是否签到成功状态
 * --------------------------------------------*/

#define _IN_SQC_
#include <stdio.h>
#include <string.h>
#include "pubdef.h"
#include "errdef.h"
#include "pubfunc.h"
#include "pubdb.h"
#include "dbfunc.h"
#include "dbfunc_foo.h"
#include "account.h"
#include "busqc.h"



int F240009(TRUSERID *handle,int iRequest,ST_PACK *rPack,int *pRetCode,char *szMsg)
{

	int ret=0;
	T_t_device t_device;

	ST_CPACK aPack;
	ST_PACK *out_pack = &(aPack.pack);

	memset(&t_device,0,sizeof(t_device));
	ResetNormalCPack(&aPack,0,1);
	SetCol(handle,0);
	SetCol(handle,F_SCARD0,0);

	//writelog(LOG_ERR," deviceid=[%s]",rPack->sorder2);
	ret=DB_t_device_read_by_deviceid(atoi(rPack->sorder2),&t_device);
	if(ret)
	{
		writelog( LOG_ERR,"DB_t_device_read_by_deviceid error,errcode=[%d],deviceid=[%d]",ret,t_device.deviceid);
		*pRetCode=E_DB_DEVICE_R;
		goto L_RETU;
	}
	//writelog( LOG_ERR,"Device don't login,deviceid=[%d],login_flag=[%d]",deviceid,t_device.status);
	if(DEVISTAT_ONLINE!=t_device.status[0])
	{
		writelog( LOG_ERR,"Device don't login,deviceid=[%d],login_flag=[%d]",t_device.deviceid,t_device.status);
		*pRetCode=E_DB_DEVI_LOGIN;
		goto L_RETU;
	}
	
	return 0;
L_RETU:
	return -1;
}


