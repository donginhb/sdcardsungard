/* --------------------------------------------
 * 程序名称: F843362.sqC
 * 创建日期: 2007-11-02
 * 程序作者:闻剑
 * 版本信息: 1.0.0.0
 * 程序功能: 充值操作员设备添加
 * --------------------------------------------
 * 修改日期: 
 * 修改人员: 
 * 修改描述: 
 * 版本信息: 
 * 备注信息: 
 * --------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cpack.h"
#include "errdef.h"
#include "pubdef.h"
#include "pubdb.h"
#include "pubfunc.h"
#include "dbfunc.h"
#include "busqc.h"
#include "acctrans.h"

int F843362(TRUSERID *handle,int iRequest,ST_PACK *rPack,int *pRetCode,char *szMsg)
{
	int ret=0;

	CAccTrans *pAccTrans=CAccTrans::getInstance();
	des2src(pAccTrans->trans.opercode,rPack->semp);
	pAccTrans->trans.transcode=MAKETRANSCODEADD(TCM_DEPOSITOPERPOS);
	ret=pAccTrans->InitTrans();
	if(ret)
		return ret;			
	char deviceid[31]="";
	T_t_dpsoperpos tDepositOperPos;
	T_t_dpsoper tDepositOper;
	T_t_dpsshoppos  tDepositShopPos;
	
	memset(&tDepositOperPos,0,sizeof(tDepositOperPos));
	memset(&tDepositOper,0,sizeof(tDepositOper));
	memset(&tDepositShopPos,0,sizeof(tDepositShopPos));
	
	if(!strlen(rPack->vsvarstr1))
	{
		return E_INPUT_DATA_INVAILD;
	}	
	ret=DB_t_dpsoper_read_by_opercode(rPack->scust_auth,&tDepositOper);
	if(ret)
	{
		if(DB_NOTFOUND==ret)
			return ERRINFO(E_NOTEXIST_DEPOSITOPER,rPack->scust_auth);
		else
			return E_DB_DEPOSITOPER_R;
	}
	if(tDepositOper.devlimitflag[0]!='1')
	{
		return E_OPER_NO_NEED_DEVICE;
	}
	des2src(tDepositOperPos.opercode,rPack->scust_auth);
	des2src(tDepositOperPos.openoper,rPack->semp);
	des2src(tDepositOperPos.lastsaved,CAccTrans::getInstance()->trans.sysdatetime);
	vector<string>  strlist;
	split2list(rPack->vsvarstr1,',',strlist);
	for(int i=0;i<strlist.size();i++)
	{
		tDepositOperPos.deviceid=atoi(strlist[i].c_str());
		//如果操作员不是充值商户操作员则不允许绑定充值商户设备
		ret=DB_t_dpsshoppos_read_by_deviceid(tDepositOperPos.deviceid, &tDepositShopPos);
		if(ret)
		{
			if(ret==DB_NOTFOUND)
			{
				if(tDepositOper.shopoperflag[0]=='1')
				{
					return ERRINFO(E_DEVICE_NOTIS_DEPOSITSHOP,tDepositOperPos.deviceid);
				}
			}	
			else
			{
				return E_DB_DEPOSITSHOPPOS_R;

			}
		}
		else
		{
			if(tDepositOper.shopoperflag[0]=='0')
			{
				return ERRINFO(E_DEVICE_IS_DEPOSITSHOP,tDepositOperPos.deviceid);
			}
		}
		SQLCODE=0;
		ret=DB_t_dpsoperpos_add(&tDepositOperPos);
		if(ret)
		{
			writelog(LOG_ERR,"opercode[%s]",tDepositOperPos.opercode);
			if(DB_REPEAT==ret)
			{
				return ERRINFO(E_DB_DEPOSITOPERPOS_E,tDepositOperPos.opercode,ltos(tDepositOperPos.deviceid).c_str());
			}
			else
			{
				return E_DB_DEPOSITOPERPOS_I;
			}
		}
	}
	return 0;
}
