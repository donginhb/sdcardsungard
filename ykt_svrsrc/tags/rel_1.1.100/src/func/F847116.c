/* --------------------------------------------
 * 程序名称: F847116.sqc
 * 创建日期: 9 17 2004
 * 程序作者: 杜叶飞
 * 版本信息: 1.0.0.0
 * 程序功能:  发行临时卡
 * --------------------------------------------
 * 修改日期:2004-10-12
 * 修改人员:	闻剑
 * 修改描述: 增加记账交易处理
 * 版本信息:1.0.0.1
 * 备注信息:
 * --------------------------------------------*/
#define _IN_SQC_
#include <stdio.h>
#include <string.h>
#include "pubdef.h"
#include "errdef.h"
#include "pubfunc.h"
#include "pubdb.h"
#include "dbfunc.h"
#include "account.h"
#include "fdsqc.h"

static int process(InAcc *IA,T_t_tif_tradeserial *p)
{
	int ret = 0;

	//根据卡号和钱包号得到消费者账号(借方)

	IA->iMainDevId=p->maindevice_id;			//工作站标识
	IA->iDevId=p->device_id;					//设备ID
	IA->iSerialNo=p->serial_no;				//流水号
	IA->iTradeNo=p->serial_type;				//交易码
	strcpy(IA->sTxDate,p->operate_date);		//交易日期
	strcpy(IA->sTxTime,p->operate_time);		//交易时间
	strcpy(IA->sTxCollectDate,p->collect_date);	//采集日期
	strcpy(IA->sTxCollectTime,p->collect_time);	//采集时间
	strcpy(IA->sTxAccDate,p->enteract_date);	//记账日期
	strcpy(IA->sTxAccTime,p->enteract_time);	//记账时间
	strcpy(IA->sMdeOper,p->oper_code);		//录入 操作员
	strcpy(IA->sChkOper,p->reserve_1);			//复核操作员

//	strcpy(IA->sActno[0],p->out_account_id);		//账号

//	IA->dAmt[0]=p->trade_fee;				//充值金额(不包含搭伙费)
//	IA->dAmt[1]=p->boardfee;					//充值金额(搭伙费)
//	IA->dAmt[2]=p->deposit_fee;				//预提费用
//	IA->dAmt[3]=p->in_fee;					//手续费/管理费
//	IA->dAmt[4]=p->cost_fee;					//卡成本费

	p->in_balance=0;							//入卡值
	IA->iUseCardFlag=USE_CARD_TYPE_ONLINE;		//联机交易
	IA->iTxCnt=p->trade_count;					//交易次数
	IA->dInCardBala=p->in_balance;				//入卡值
	IA->dOutCardBala=-1;							//出卡值
	//修改借方和贷方帐户余额，记会计分录帐
	ret=AccountProcess(IA);
	if(ret)
	{
		writelog(LOG_ERR,"AccountProcess ret[%d]",ret);
		return ret;
	}
	p->out_balance=IA->dOutCardBala;		//出卡值
	return 0;
}

int F847116(TRUSERID *handle,int iRequest,ST_PACK *rPack,int *pRetCode,char *szMsg)
{
	int	hi_cutid = 0;											//客户ID
	int	hi_cuttype = 0;										//客户类型
	int i=0;
	int ret = 0;
	int len = 0;
	char h_showcardid[11] = "";								//显示卡号
	char h_password[7] = "";									//卡密码
	double h_temp_Card_id = 0;								//卡号
	char seed_key[17] = "";									//种子密钥
	char card_endtime[27 + 1] = "";							//卡的有效截至日期
	char logicdate[11]="";
	char sysdate[11]="";
	char systime[9]="";
	char sMsg[256]="";
	char sMaxCardBalance[20]="";
	double dMaxCardBalance=0;
	T_t_cif_customer tCustomer;
	T_t_pif_spefee 	tSpeFee;
	T_t_pif_card tCard;
	T_t_aif_account  tAccount;
	T_t_tif_tradeserial  tradeserial;
	InAcc	IA;
	ST_CPACK aPack;
	ST_PACK *out_pack = &(aPack.pack);

	ResetNormalCPack(&aPack,0,1);
	SetCol(handle,0);
	SetCol(handle,F_LVOL0,F_LVOL1,F_LVOL5,
				F_SCUST_NO,	F_SCUST_NO2,F_SCUST_AUTH,F_SCUST_AUTH2,
				F_SDATE0,F_SNAME,F_SNAME2,
				F_SOPEN_EMP,F_SSTATUS0,
				F_DAMT2,F_DAMT3,F_LSERIAL1,F_VSMESS,0);

	memset(&IA,0,sizeof(IA));
	memset(&tCustomer,0,sizeof(tCustomer));
	memset(&tCard, 0, sizeof(tCard));
	memset(&tAccount,0,sizeof(tAccount));
	memset(&tradeserial,0,sizeof(tradeserial));
	memset(&tSpeFee,0,sizeof(tSpeFee));

#ifdef DEBUG
	writelog(LOG_DEBUG,"rPack->damt0[%lf]",rPack->damt0);
	writelog(LOG_DEBUG,"rPack->scust_auth2[%s]",rPack->scust_auth2);
#endif

	hi_cutid = rPack->lvol0;									//客户ID
	hi_cuttype = rPack->lvol3;									//客户类别
	tradeserial.trade_fee=rPack->damt0;					//发生额
	des2src(h_showcardid,rPack->scust_no);					//显示卡号

	getsysdate(sysdate);
	getsystime(systime);
	ret=GetLogicDate(logicdate);								//业务日期
	if(ret)
	{
		*pRetCode=ret;
		goto L_RETU;
	}
	ret=IsExistShowCardNo(h_showcardid);
	if(ret)
	{
		*pRetCode = ret;
		goto L_RETU;
	}
	//	检查客户信息，判断是否可以发行临时卡
	ret = IsExistNoLostCardByCustomId(hi_cutid);
	if (ret)
	{
		writelog(LOG_ERR,"hi_cutid[%d]",hi_cutid);
		*pRetCode = ret;
		goto L_RETU;
	}
	des2src(tCard.physical_no, rPack->sbank_acc);				//物理卡号
	ret=IsExistCardByPhyCardNo(tCard.physical_no);			//物理卡号
	if(ret)
	{
		writelog(LOG_ERR,"physical_no[%s]",tCard.physical_no);
		*pRetCode = ret;
		goto L_RETU;
	}
	ret=DB_t_cif_customer_read_lock_by_cur_and_cut_id(hi_cutid, &tCustomer);
	if(ret)
	{
		writelog(LOG_ERR,"cut_id[%d]",hi_cutid);
		if(DB_NOTFOUND==ret)
			*pRetCode= E_CUSTOMER_NOT_EXIST;
		else
			*pRetCode= E_DB_CUSTOMER_R;
		goto L_RETU;
	}
	//得到收费类别
	if(tCustomer.fee_type<1)
	{
		ret=DB_t_pif_spefee_read_by_dept_code_and_cut_type(tCustomer.classdept_no, tCustomer.cut_type,&tSpeFee);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
			{
				tCustomer.fee_type=tCustomer.cut_type;
			}
			else
			{
				DB_t_cif_customer_free_lock_cur();
				*pRetCode=E_DB_SPEFEE_R;
				goto L_RETU;
			}
		}
		else
		{
			tCustomer.fee_type=tSpeFee.fee_type;
		}
		//更新客户表的收费类别字段
		ret=DB_t_cif_customer_update_lock_by_cur(&tCustomer);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				*pRetCode= E_CUSTOMER_NOT_EXIST;
			else
				*pRetCode= E_DB_CUSTOMER_U;
			goto L_RETU;
		}
	}
	DB_t_cif_customer_free_lock_cur();
	//检查金额是否超过最大额度
	ret=GetParameter(GLOBE_MAXCARDBALANCE,sMaxCardBalance);
	if(ret)
	{
		*pRetCode=ret;
		goto L_RETU;
	}
	dMaxCardBalance=atof(sMaxCardBalance);

	if(amtcmp(tradeserial.trade_fee,dMaxCardBalance)>0)
	{
		writelog(LOG_ERR,"tradeserial.trade_fee[%lf]",tradeserial.trade_fee);
		*pRetCode=E_AMT_EXCEED_MAX;
		goto L_RETU;
	}
	//	准备数据插入卡信息表
	memcpy(seed_key,STATIC_SEED_KEY,sizeof(seed_key));						//读种子密钥

	//	默认密码, 初始取身份证的后6位, 没有身份证号用666666.
	trim(rPack->sname2);
	len=strlen(rPack->sname2) ;
	if (len >= 6)
	{
		strncpy(h_password,&(rPack->sname2[len-6]),6);
		if(h_password[5]>'9'||h_password[5]<'0')
			h_password[5]='0';
	}
	else
	{
		strcpy(h_password,"666666");
	}
	ret = getNewUniqNo(KEYTYPE_CARD_ID,&h_temp_Card_id);						//获取最大卡号
	if(ret)
	{
		*pRetCode = ret;
		writelog(LOG_ERR,"ret[%d]",ret);
		goto L_RETU;
	}
	tCard.card_id = (int)h_temp_Card_id;											//卡号
	des2src(tCard.showid,h_showcardid);										//显示卡号
	des2src(tCard.is_main,TYPE_YES);  											//是否为主卡
	des2src(tCard.state_id,CARDSTAT_REG);											//卡状态
	tCard.type_id = CT_TEMP;													//卡类别
	EncodePwd(seed_key,h_password,tCard.password,0);							//卡密码
	tCard.cosumer_id = hi_cutid;												//客户标识
	tCard.account_count = ACCOUNT_COUNT_ONE;									//卡对应帐户个数
	des2src(tCard.begin_time,logicdate);											//注册时间

	ret = GetTempCardValiddate(GLOBE_TMPCARDVALIDDATE,logicdate,card_endtime);						//计算卡的有效期
	if (ret)
	{
		*pRetCode = ret;
		goto L_RETU;
	}

	des2src(tCard.end_time, card_endtime);										//截至时间
	tCard.phytype = PHYTYPE_NO_ONE;											//设备物理型号;默认为1

	//	插入卡信息
	ret = DB_t_pif_card_add(&tCard);
	if (ret)
	{
		if(DB_REPEAT==ret)
			*pRetCode = E_DB_CARD_E;
		else
			*pRetCode = E_DB_CARD_I;
		goto L_RETU;
	}

	//	准备数据插入帐户信息表
	ret = getNewActno(tAccount.account_id);  	    //获得最大帐号
	if (ret)
	{
		*pRetCode = ret;
		goto L_RETU;
	}

	des2src(tAccount.open_date,logicdate);		   								//开户时间
	des2src(tAccount.open_time,systime);
	tAccount.current_state = ACCOUNTSTAT_REGIST;      								//当前状态
	tAccount.act_type = ACCTYPE_PERMAIN;				        						//帐号类别
	tAccount.customer_id = rPack->lvol0;				        						//客户号
	des2src(tAccount.cut_name,rPack->sname);									//客户名称
	tAccount.cut_type = hi_cuttype;												//客户类别
	des2src(tAccount.stuemp_no,rPack->scust_auth2); 							//客户学号或员工号
	tAccount.card_id = (int)h_temp_Card_id; 											//关联卡号
	tAccount.purse_id = PURSE_NO_ONE;											//关联卡钱包号
	tAccount.card_type = CT_TEMP;													//卡类别
	des2src(tAccount.subno,SUBJECT_INDIVIDUALSAVING);							//所属科目
	des2src(tAccount.isautotra,TYPE_NO); 											//是否自动转帐
	//	插入帐户信息表
	ret = DB_t_aif_account_add(&tAccount);
	if (ret)
	{
		if(DB_REPEAT==ret)
			*pRetCode = E_DB_ACCOUNT_E;
		else
			*pRetCode = E_DB_ACCOUNT_I;
		goto L_RETU;
	}
	//	准备数据插入交易流水表

	double h_temp_Serial_no = 0;
	ret = getNewUniqNo(KEYTYPE_TRADESERIAL,&h_temp_Serial_no);  						//获得最大流水号
	if(ret)
	{
		*pRetCode = ret;
		goto L_RETU;
	}

	tradeserial.serial_no = (int)h_temp_Serial_no;											//流水号
	tradeserial.other_seri_no = 0;														//上传端流水号
	tradeserial.serial_type = TXCODE_TEMPCARD_OPEN;									//交易代码
	tradeserial.serial_state = SERISTAT_DEBT;												//流水状态
	des2src(tradeserial.operate_date,sysdate);											//发生日期
	des2src(tradeserial.operate_time,systime);											//发生时间
	des2src(tradeserial.collect_date,sysdate);												//采集日期
	des2src(tradeserial.collect_time,systime);												//采集时间
	des2src(tradeserial.enteract_date,logicdate);											//处理日期
	des2src(tradeserial.enteract_time,systime);											//处理时间
	tradeserial.maindevice_id = rPack->lvol6;												//上传工作站标识
	tradeserial.device_id = rPack->lvol7;													//采集设备标识
	tradeserial.card_id = tCard.card_id;													//卡号
	des2src(tradeserial.showid,tCard.showid);												//显示卡号
	tradeserial.purse_id = PURSE_NO_ONE;												//钱包号
	tradeserial.customer_id = rPack->lvol0;												//客户标识
	des2src(tradeserial.oper_code,rPack->scust_limit);									//操作员代码
	tradeserial.sys_id = 0;																//外部系统标识
	tradeserial.trade_count=1;														//当前卡交易次数

	des2src(IA.sArrInActno[0],tAccount.account_id);						//帐户
	IA.iCardNo=tCard.card_id;
	IA.iFeeType=tCustomer.fee_type;
	IA.dArrInAmt[0]=tradeserial.trade_fee;

	IA.iArrInFeeSwitch[0]=rPack->lvol0;
	IA.iArrInFeeSwitch[1]=rPack->lvol1;
	IA.iArrInFeeSwitch[2]=rPack->lvol2;
	IA.iArrInFeeSwitch[3]=rPack->lvol3;
	IA.iArrInFeeSwitch[4]=rPack->lvol4;
	IA.iArrInFeeSwitch[5]=rPack->lvol5;
	IA.iArrInFeeSwitch[6]=rPack->lvol6;
	IA.iArrInFeeSwitch[7]=rPack->lvol7;
	IA.iArrInFeeSwitch[8]=rPack->lvol8;
	IA.iArrInFeeSwitch[9]=rPack->lvol9;
	IA.iArrInFeeSwitch[10]=rPack->lvol10;

	//	调用入账子模块
	ret=process(&IA,&tradeserial);
	if(ret)
	{
		*pRetCode=ret;
		writelog(LOG_ERR,"process ret[%d]",ret);
		goto L_RETU;
	}
	sprintf(out_pack->vsmess,"流水号:%d 卡号:%d ",IA.iSerialNo,IA.iCardNo);
	for(i=1;i<=IA.iOutTxTypeCnt;i++)
	{
		switch(IA.iArrOutTxType[i])
		{
			case TXTYPE_TOLL_DEPOSIT:
			case TXTYPE_DEDUCT_DEPOSIT:
			case TXTYPE_RETURN_DEPOSIT:
				tradeserial.deposit_fee=IA.dArrOutAmt[i];
				break;
			case TXTYPE_PRE_TOLL_BOARD:
			case TXTYPE_TOLL_BOARD:
			case TXTYPE_DEDUCT_BOARD:
			case TXTYPE_RETURN_BOARD:
				tradeserial.boardfee=IA.dArrOutAmt[i];
				break;
			case TXTYPE_TOLL_CHARGE:
				tradeserial.in_fee=IA.dArrOutAmt[i];
				break;
			case TXTYPE_TOLL_CARDCOST:
				tradeserial.cost_fee=IA.dArrOutAmt[i];
				break;
			default:
				break;
		}
		if(amtcmp(IA.dArrOutAmt[i],0)!=0)
		{
			sprintf(sMsg,"%s:%.2lf元 ",IA.sArrOutTxName[i],IA.dArrOutAmt[i]);
			strcat(out_pack->vsmess,sMsg);
		}
	}
	sprintf(sMsg,"卡当前余额:%.2lf元",tradeserial.out_balance);
	strcat(out_pack->vsmess,sMsg);
	writelog(LOG_DEBUG,out_pack->vsmess);
	//	插入交易流水表
	ret = DB_t_tif_tradeserial_add(&tradeserial);
	if (ret)
	{
		if(DB_REPEAT==ret)
			*pRetCode = E_DB_TRADESERIAL_E;
		else
			*pRetCode = E_DB_TRADESERIAL_I;
		goto L_RETU;
	}
	if(amtcmp(tradeserial.out_balance,0)<0)
	{
		*pRetCode=E_ENTER_ACCOUNT;
		goto L_RETU;
	}

	//	返回卡号\密码\显示卡号\客户类型\图书证号\有效截至日期
	out_pack->lvol0 = (int)h_temp_Card_id;						//交易卡号
	out_pack->lvol1 = tCustomer.cut_type;						//客户类别
	out_pack->lvol5 = tCustomer.fee_type;						//收费类别
	des2src(out_pack->scust_no,h_showcardid);					//显示卡号
	des2src(out_pack->scust_no2,tCustomer.classdept_no);			//部门号
	des2src(out_pack->scust_auth,tCustomer.stuemp_no);			//学号
	des2src(out_pack->scust_auth2,tCustomer.man_id);			//身份证号
	des2src(out_pack->sname,tCustomer.cut_name);				//客户姓名
	des2src(out_pack->sname2,tCustomer.lib_cardid);				//图书证号
	des2src(out_pack->sstatus0,tCustomer.sex);					//性别
	des2src(out_pack->sopen_emp,h_password);					//卡密码
	des2src(out_pack->sdate0,card_endtime);					//有效截至日期

	out_pack->damt2=tradeserial.out_balance;				//出卡值
	out_pack->damt3=tradeserial.boardfee;					//搭伙费
	out_pack->lserial1=tradeserial.serial_no;					//流水号

	// add by 汤成 2005-8-8
	// 增加向名单表写入记录
	ret = InsertToBlkList((int)h_temp_Card_id,CHCARD_BLACKLIST);
	if(ret)
	{
		*pRetCode = ret;
		goto L_RETU;
	}
	PutRow(handle,out_pack,pRetCode,szMsg);
	return 0;
L_RETU:
	return -1;
}
