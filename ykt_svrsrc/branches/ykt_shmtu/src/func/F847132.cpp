/* --------------------------------------------
 * 程序名称: F847132.c
 * 创建日期: 2005-12-7
 * 程序作者: 闻剑
 * 版本信息: 1.0.0.0
 * 程序功能: 下发补助
 * --------------------------------------------
 * 修改日期:
 * 修改人员:
 * 修改描述:
 * 版本信息:
 * 备注信息:
 * --------------------------------------------*/

#include <stdio.h>
#include <string.h>
#include "pubdef.h"
#include "errdef.h"
#include "pubfunc.h"
#include "pubdb.h"
#include "dbfunc.h"
#include "account.h"
#include "fdsqc.h"
#include "dbfunc_foo.h"

static int process(InAcc *IA,T_t_tif_tradeserial *p)
{
	int ret=0;

	IA->iMainDevId=p->maindevice_id;				//工作站标识
	IA->iDevId=p->device_id;						//设备ID
	IA->iSerialNo=p->serial_no;					//流水号
	IA->iTradeNo=p->serial_type;					//交易码
	strcpy(IA->sTxDate,p->operate_date);			//交易日期
	strcpy(IA->sTxTime,p->operate_time);			//交易时间
	strcpy(IA->sTxCollectDate,p->collect_date);		//采集日期
	strcpy(IA->sTxCollectTime,p->collect_time);		//采集时间
	strcpy(IA->sTxAccDate,p->enteract_date);		//记账日期
	strcpy(IA->sTxAccTime,p->enteract_time);		//记账时间
	strcpy(IA->sMdeOper,p->oper_code);			//操作员
	strcpy(IA->sChkOper,p->reserve_1);			//复核操作员

	IA->iUseCardFlag=USE_CARD_TYPE_NULL;		//无卡交易
	//if(p->trade_fee<0)	p->trade_fee=0-p->trade_fee;

	//修改借方和贷方帐户余额，记会计分录帐
	ret=AccountProcess(IA);
	if(ret)
	{
		writelog(LOG_ERR,"AccountProcess ret[%d]",ret);
		return ret;
	}
	return 0;
}


int F847132(TRUSERID *handle,int iRequest,ST_PACK *rPack,int *pRetCode,char *szMsg)
{
	int ret=0;
	int i=0;
	int iTotalCnt=0;
	double dTotalAmt=0.0;
	double dSerialNo = 0;
	char logicdate[11]="";										//业务日期
	char sysdate[11]="";
	char systime[9]="";
	char sMsg[256]="";
	T_t_tif_tradeserial  tradeserial;
	T_t_tif_savdtl		tSavdtl;
	T_t_tif_subsidy  	tSubsidy;
	InAcc	IA;
	ST_CPACK aPack;
	ST_PACK *out_pack = &(aPack.pack);
	T_t_tif_meslist tMesList;
	T_t_pif_device t_device;

	memset(&t_device,0,sizeof t_device);
	memset(&tMesList,0,sizeof tMesList);
	memset(&tSavdtl,0,sizeof(tSavdtl));
	memset(&tSubsidy,0,sizeof(tSubsidy));
	memset(&tradeserial,0,sizeof(tradeserial));
	memset(&IA,0,sizeof(IA));

	ResetNormalCPack(&aPack,0,1);
	SetCol(handle,0);
	SetCol(handle,F_VSMESS,0);
	getsysdate(sysdate);
	getsystime(systime);
	ret=GetLogicDate(logicdate);					//业务日期
	if(ret)
	{
		*pRetCode=ret;
		goto L_RETU;
	}
	if(strlen(rPack->scust_limit)<1)
	{
		*pRetCode=E_INPUT_BATCH_NO;
		goto L_RETU;
	}
	if(strlen(rPack->scust_no)<1)
	{
		*pRetCode=E_INPUT_OPER_NULL;
		goto L_RETU;
	}
	//允许补助负金额
	if(amtcmp(rPack->damt0,0)==0)
	{
		*pRetCode=E_INPUT_AMT;
		goto L_RETU;
	}
	des2src(tSubsidy.summary,rPack->semail);		//补助摘要
	if(strlen(rPack->semail)<1)
	{
		*pRetCode=E_INPUT_SUMMARY;
		goto L_RETU;
	}
	
	tSubsidy.subsidy_no=atoi(rPack->scust_limit);
	//writelog(LOG_ERR,"[%d]:[%d]:[%d]:[%d]:[%d]:[%d]:[%d]:[%d]:[%d]:[%d]:[%d]:[%d]",tSubsidy.subsidy_no, rPack->lvol1, rPack->lvol2,rPack->lvol3, rPack->lvol4, rPack->lvol5, rPack->lvol6, rPack->lvol7, rPack->lvol8, rPack->lvol9, rPack->lvol10, rPack->lvol11);
	//des2src(tSubsidy.batch_no,rPack->scust_limit);
	tSubsidy.bill_type=rPack->lvol2;					//票据类型
	des2src(tSubsidy.bill_no,rPack->scust_auth2);	//票据号码
	tSubsidy.amount=rPack->damt0;				//补助金额
	des2src(tSubsidy.subsidytype,rPack->smain_flag);//补助标志(0增值1减值)
	des2src(tSubsidy.subsidytype,"1");			//补助标志(0增值1减值)
	des2src(tSubsidy.broker_id,rPack->sname);		//经办人身份证号
	des2src(tSubsidy.broker_name,rPack->semail2);	//经办人姓名

	IA.dArrInAmt[0]=tradeserial.trade_fee;
	switch(tSubsidy.bill_type)
	{
		case TYPE_CASH:	//现金
			IA.iArrInFeeSwitch[1]=1;
			break;
		case TYPE_BILL:	//支票
			IA.iArrInFeeSwitch[2]=1;
			break;
		case TYPE_FUNDBOOK:	//经费本
			IA.iArrInFeeSwitch[3]=1;
			break;
		default:
			*pRetCode=E_INPUT_DEPOSIT_TYPE;
			goto L_RETU;
	}
	ret=get_batch_no_by_subsidy_no(tSubsidy.subsidy_no,tSubsidy.batch_no);
	if(ret)
	{
		*pRetCode = E_DB_SUBSIDYTMP_R;
		goto L_RETU;
	}
	ret=judge_with_max_subsidy_no_within_new(tSubsidy.subsidy_no);
	if(ret)
	{
		*pRetCode = E_SUBSIDY_DOWN_ERROR;
		goto L_RETU;
	}
	ret=stat_subsidy_amount_by_batch_no(tSubsidy.batch_no, &iTotalCnt,&dTotalAmt);
	if(ret)
	{
		*pRetCode = ret;
		writelog(LOG_ERR,"ret[%d]",ret);
		goto L_RETU;
	}

	if(iTotalCnt!=rPack->lvol3)
	{
		strcpy(szMsg,"补助人数与导入的数据不符");
		*pRetCode=E_INPUT_DATA_INVAILD;
		goto L_RETU;
	}
	if(amtcmp(dTotalAmt,rPack->damt0)!=0)
	{
		strcpy(szMsg,"补助总金额与导入的补助数据不符");
		*pRetCode=E_INPUT_DATA_INVAILD;
		goto L_RETU;
	}
	writelog(LOG_DEBUG,"subsidy batch_no : %s",tSubsidy.batch_no);
	des2src(tSubsidy.tx_date,sysdate);
	des2src(tSubsidy.tx_time,systime);
	ret=update_subsidy_info_by_batch_no(&tSubsidy);
	if(ret)
	{
		*pRetCode = ret;
		writelog(LOG_ERR,"ret[%d]",ret);
		goto L_RETU;
	}
	ret = getNewUniqNo(KEYTYPE_TRADESERIAL,&dSerialNo);  					//获得最大流水号
	if(ret)
	{
		*pRetCode = ret;
		writelog(LOG_ERR,"ret[%d]",ret);
		goto L_RETU;
	}
	tradeserial.serial_no = D2I(dSerialNo);											//流水号
	tradeserial.other_seri_no = 0;															//上传端流水号
	if(dTotalAmt>0)
		tradeserial.serial_type = TXCODE_SET_SUBSIDY;
	else tradeserial.serial_type = TXCODE_DESUBSIDY_DOWN;
	
	tradeserial.serial_state = SERISTAT_DEBT;				//流水状态
	des2src(tradeserial.operate_date,sysdate);			//发生日期
	des2src(tradeserial.operate_time,systime);			//发生时间
	des2src(tradeserial.collect_date,sysdate);				//采集日期
	des2src(tradeserial.collect_time,systime);				//采集时间
	des2src(tradeserial.enteract_date,logicdate);			//处理日期
	des2src(tradeserial.enteract_time,systime);			//处理时间
	tradeserial.maindevice_id = rPack->lvol6;				//上传工作站标识
	tradeserial.device_id = rPack->lvol7;					//采集设备标识
	des2src(tradeserial.oper_code , rPack->scust_no);		//操作员代码
	tradeserial.sys_id = 0;								//外部系统标识
	// 设置发生金额
	tradeserial.trade_fee = dTotalAmt;
	switch(tSubsidy.bill_type)
	{
		case TYPE_CASH:		//现金
			break;
 		case TYPE_BILL:		//支票
		case TYPE_FUNDBOOK:	//经费本
 			tSavdtl.amount=rPack->damt0;				//发生额
 			if(amtcmp(tSavdtl.amount,0)==0)
				break;
			des2src(tSavdtl.bill_no,tSubsidy.bill_no);		//票据号码
			if(strlen(tSavdtl.bill_no)<1)
			{
				*pRetCode=E_INPUT_BILLNO;
				goto L_RETU;
			}
			tSavdtl.card_no=0;							//卡号
			des2src(tSavdtl.oper_no,rPack->scust_limit);	//操作员
			tSavdtl.seqno=tradeserial.serial_no;			//流水号
			des2src(tSavdtl.tx_date,sysdate);			//发生日期
			des2src(tSavdtl.tx_time,systime);			//发生时间
			tSavdtl.cnt=1;								//票据数量
			tSavdtl.bill_type=tSubsidy.bill_type;			//票据类型
			tSavdtl.tx_code=tradeserial.serial_type;		//交易码
			ret=DB_t_tif_savdtl_add(&tSavdtl);
			if(ret)
			{
				if(DB_REPEAT==ret)
					*pRetCode = E_DB_SAVDTL_E;
				else
					*pRetCode = E_DB_SAVDTL_I;
				goto L_RETU;
			}
			break;
		default:
			*pRetCode=E_INPUT_DEPOSIT_TYPE;
			goto L_RETU;
	}
	IA.iFeeType=1;				//默认值
	//支持负金额扣款
	if(tradeserial.trade_fee<0)
		tradeserial.trade_fee=-tradeserial.trade_fee;
	IA.dArrInAmt[0]=tradeserial.trade_fee;
	// writelog(LOG_DEBUG,"补助金额[%lf]",tradeserial.trade_fee);
//	if(strncmp(tSubsidy.subsidytype,"1",1)==0)
//		IA.dArrInAmt[0]=tradeserial.trade_fee;
//	else if(strncmp(tSubsidy.subsidytype,"2",1)==0)
//	{
//		IA.dArrInAmt[0]=-tradeserial.trade_fee;
//		IA.iTxFlag=1;
//	}
//	else
//	{
//		*pRetCode=E_INPUT_DATA_INVAILD;
//		sprintf(szMsg,"输入的补助类型%s不存在",strncmp(tSubsidy.subsidytype);
//		goto L_RETU;
//	}
	IA.iArrInFeeSwitch[0]=rPack->lvol0;
	IA.iArrInFeeSwitch[5]=rPack->lvol5;
	IA.iArrInFeeSwitch[6]=rPack->lvol6;
	IA.iArrInFeeSwitch[7]=rPack->lvol7;
	IA.iArrInFeeSwitch[8]=rPack->lvol8;
	IA.iArrInFeeSwitch[9]=rPack->lvol9;
	IA.iArrInFeeSwitch[10]=rPack->lvol10;

	ret=process(&IA,&tradeserial);
	if(ret)
	{
		writelog(LOG_ERR,"process ret[%d]",ret);
		*pRetCode=ret;
		goto L_RETU;
	}
	sprintf(out_pack->vsmess,"流水号:%d ",IA.iSerialNo);
	// writelog(LOG_DEBUG,"out tx type count %d",IA.iOutTxTypeCnt);
	for(i=1;i<=IA.iOutTxTypeCnt;i++)
	{
		if(amtcmp(IA.dArrOutAmt[i],0)!=0)
		{
			sprintf(sMsg,"%s:%.2lf元 ",IA.sArrOutTxName[i],IA.dArrOutAmt[i]);
			strcat(out_pack->vsmess,sMsg);
		}
	}
	sprintf(sMsg,",共%d笔",iTotalCnt);
	strcat(out_pack->vsmess,sMsg);
	// strcat(out_pack->vsmess,sMsg);
	// writelog(LOG_DEBUG,out_pack->vsmess);
	ret = DB_t_tif_tradeserial_add(&tradeserial);
	if (ret)
	{
		writelog(LOG_ERR,"ret[%d]",ret);
		if(DB_REPEAT==ret)
			*pRetCode = E_DB_TRADESERIAL_E;
		else
			*pRetCode = E_DB_TRADESERIAL_I;
		goto L_RETU;
	}
	ret=DB_t_pif_device_open_select_by_c4_and_devtype("5301");
	if(ret)
	{
		DB_t_pif_device_close_select_by_c4();
		writelog(LOG_ERR,"DB_t_pif_device_open_select_by_c4_and_devtype error,ret=[%d]",ret);
		*pRetCode = E_DB_DEVICE_R;
		goto L_RETU;
	}
/*
	while(1)
	{
		// 初始化宿主变量

		ret=DB_t_pif_device_fetch_select_by_c4(&t_device);
		if (ret)    
		{
			db_chk_err(__FILE__,__LINE__,&sqlca);
			if(DB_NOTFOUND==ret)
			{
				break;
			}
			else
			{
				*pRetCode=E_DB_DEVICE_R;
				writelog(LOG_ERR,"DB_t_pif_device_fetch_select_by_c4 err [%d]",ret);
				goto L_RETU;
			}
		}
		memset(&tMesList,0,sizeof tMesList);
		tMesList.funid=930077;
		tMesList.level = MESLIST_PRIORITY_REALTIME;
		tMesList.msgtype = MESLIST_TYPE_NORMAL;
		tMesList.devid = t_device.device_id;
		tMesList.device_id= t_device.subsystem_id;

		//AddXmlItemInt(tMesList.incontent,XML_KEY_SEQNO,g_seqno);
		//AddXmlItemInt(tMesList.incontent,XML_KEY_HOLIDAY,g_ho_holiday_id);
		// 重试10次
		tMesList.max_send_cnt = 10;
		ret=AddMsgLst(&tMesList);
		if(ret)
		{
			*pRetCode=E_DB_MESLIST_I;
			writelog(LOG_ERR,"AddMsgLst err[%d]",ret);
			return ret;
		}
	}
*/
	PutRow(handle,out_pack,pRetCode,szMsg);
	DB_t_pif_device_close_select_by_c4();
	return 0;
L_RETU:
	return -1;
}
