/* --------------------------------------------
 * 程序名称: F930007.sqc
 * 创建日期: 9 17 2004
 * 程序作者: 杜叶飞
 * 版本信息: 1.0.0.0
 * 程序功能: 下传设备主参数
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

int F930007(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg)
{
	int ret = 0;
 	int cnt=0;
	int msgid=0;
 T_t_msglist tMsgList;
	T_t_device tDevice;

	ST_CPACK aPack;
	ST_PACK *out_pack = &(aPack.pack);

	ResetNormalCPack(&aPack,0,1);
	SetCol(handle,0);
	SetCol(handle,F_VSVARSTR0,0);
	memset(&tMsgList,0,sizeof(tMsgList));
	memset(&tDevice,0,sizeof(tDevice));

	if(strlen(in_pack->sdate0)==0)
	{
		*pRetCode=E_DEVPHYID_NULL;
		goto L_RETU;
	}
	ret=get_devinfo_by_phyid(in_pack->sdate0,&tDevice);
	if(ret)
	{
		*pRetCode=ret;
		writelog(LOG_ERR,"get_devinfo_by_phyid err[%d]",ret);
		goto L_RETU;
	}
	AddXmlItemInt(tMsgList.reqdata, XML_KEY_DEV999_NO, tDevice.deviceno);		//机号
	AddXmlItemStr(tMsgList.reqdata, XML_KEY_DEV999_ID, tDevice.devphyid);		//注册号	
	AddXmlItemInt(tMsgList.reqdata, XML_KEY_BAUDRATE, tDevice.baudrate);		//波特率
//	AddXmlItemStr(tMsgList.reqdata, XML_KEY_SYSPWD, tDevice.syspwd);			//系统员密码	
//	AddXmlItemStr(tMsgList.reqdata, XML_KEY_ADMPWD,tDevice.admpwd);			//管理员密码
//	AddXmlItemInt(tMsgList.reqdata, XML_KEY_PWDONOFF,tDevice.pwdonoff);		//密码开关	
	AddXmlItemStr(tMsgList.reqdata, XML_KEY_CARDSTR, "100");					//卡片结构	
//	AddXmlItemInt(tMsgList.reqdata, XML_KEY_CARDUSENUM,tDevice.cardusenum);	//卡的最大使用次数\允许最大消费次数	
//	AddXmlItemInt(tMsgList.reqdata, XML_KEY_MAXDEPOSIT, tDevice.maxdeposit);	//钱包最高存款限额
//	AddXmlItemInt(tMsgList.reqdata, XML_KEY_MINDEPOSIT, tDevice.mindeposit);		//钱包最低剩余款限额	
//	AddXmlItemInt(tMsgList.reqdata, XML_KEY_RATION, tDevice.ration);				//定值收费方式使用的定值额\定值金额
//	AddXmlItemStr(tMsgList.reqdata, XML_KEY_PUSERNO, tDevice.puserno);			//钱包代码\钱包号	
//	AddXmlItemInt(tMsgList.reqdata, XML_KEY_MAXTRADE, tDevice.maxtrade);		//每次交易最高额\大额消费限额	
	AddXmlItemStr(tMsgList.reqdata, XML_KEY_VCARDSET, tDevice.cardset);		//终端机适用用户卡类别	
//	AddXmlItemStr(tMsgList.reqdata, XML_KEY_FUNONOFF, tDevice.funonoff);			//收费机增强功能开关	
//	AddXmlItemInt(tMsgList.reqdata, XML_KEY_FEETYPE, tDevice.feetype);			//收费方式

	tMsgList.deviceid = tDevice.deviceid;
	tMsgList.funcno = 930007;
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
	des2src(out_pack->sdate0,in_pack->sdate0);
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
	PutRow(handle,out_pack,pRetCode,szMsg);
	return 0;
L_RETU:
	return  -1;	
}





