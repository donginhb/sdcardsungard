/* --------------------------------------------
 * 程序名称: F847183.sqc
 * 创建日期: 2005-04-11
 * 程序作者: 闻剑
 * 版本信息: 1.0.0.0
 * 程序功能:  交易冲正
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

static int Isnot_cash_847106(T_t_tif_tradeserial *tTradeserial)
{	
	T_t_tif_savdtl		tSavdtl;
	int ret;

	memset(&tSavdtl,0,sizeof tSavdtl);

	ret = DB_t_tif_savdtl_read_lock_by_cur_and_tx_date_and_seqno(
		tTradeserial->operate_date,tTradeserial->reviseserial_no,&tSavdtl);
	if(ret)
	{
		if(DB_NOTFOUND != ret)
			return E_DB_SAVDTL_R;
	}
	else
	{
		//不是现金充值流水不能冲正
		DB_t_tif_savdtl_free_lock_cur();
		return E_NOT_CASH_TRANSACTION;
	}

	return 0;
}

int F847183(TRUSERID *handle, int iRequest, ST_PACK *rPack, int *pRetCode, char *szMsg)
{

	int ret = 0;
	char    	tx_date[8+1] = "";              	//发生日期
//		char    	tx_time[6+1]="";      		//发生时间
	int		card_no = 0;                    	//卡号
	char    	device_id[8+1] = "";            	//终端机ID
	int		serial_no = 0;                  	//终端机流水号
	int 		flag = 0;
	double 	dUniqno = 0;
	T_t_tif_tradeserial		tOldTradeserial;	//当日流水表
	T_t_tif_tradeserial		tTradeserial;	//当日流水表
	T_t_tif_tradeserial_his	tTradeserialhis;	//历史流水表
	T_t_pif_tradecode tTradeCode;
	T_t_pif_card tCard;
	RevAcc revAcc;
	char sysdate[11] = "";
	char systime[9] = "";
	char sYear[5] = "";
	char sMonDay[5] = "";
	char logic_date[9] = "";
	int days = 0;
	ST_CPACK aPack;
	ST_PACK *out_pack = &(aPack.pack);

	ResetNormalCPack(&aPack, 0, 1);
	memset(&tTradeserial, 0, sizeof(tTradeserial));
	memset(&tOldTradeserial, 0, sizeof(tOldTradeserial));
	memset(&tTradeserialhis, 0, sizeof(tTradeserialhis));
	memset(&tTradeCode, 0, sizeof tTradeCode);
	memset(&tCard, 0, sizeof tCard);
	memset(&revAcc,0,sizeof revAcc);
	getsysdate(sysdate);
	getsystime(systime);
	des2src(tTradeserial.enteract_time, systime);

	des2src(tx_date, rPack->sbank_pwd);
//		des2src(tx_time,rPack->sbank_code);
	card_no = rPack->lvol0;
	des2src(device_id, rPack->sbank_pwd2);
	serial_no = rPack->lvol1;
	trim(rPack->scust_limit);
	trim(rPack->scust_limit2);
	trim(rPack->semp_pwd);
	des2src(sYear, tx_date);
	des2src(sMonDay, tx_date + 4);

	if (strlen(rPack->scust_limit) == 0)
	{
		*pRetCode = E_OPER_NOT_EXIST;
		goto L_RETU;
	}
	if (strlen(rPack->scust_limit2) == 0)
	{
		*pRetCode = E_INPUT_AUTH_OPER_NULL;
		goto L_RETU;
	}
	if (strcmp(rPack->scust_limit, rPack->scust_limit2) == 0)
	{
		writelog(LOG_ERR, "oper[%s]auth_oper[%s]", rPack->scust_limit, rPack->scust_limit2);
		*pRetCode = E_OPER_AND_AUTH_OPER_EQ;
		goto L_RETU;
	}
	ret = chk_oper_pwd(rPack->scust_limit2, rPack->semp_pwd);
	if (ret)
	{
		if (E_OPER_NOT_EXIST == ret)
			*pRetCode = E_AUTH_OPER_NOT_EXIST;
		else if (E_PASSWORD_WRONG == ret)
			*pRetCode = E_AUTH_OPER_PWD;
		else
			*pRetCode = ret;
		goto L_RETU;
	}
	ret = DB_t_pif_card_read_by_card_id(card_no, &tCard);
	if (ret)
	{
		if (DB_NOTFOUND == ret)
			*pRetCode = E_CARDNO_NOT_EXIST;
		else
			*pRetCode = E_DB_CARD_R;
		goto L_RETU;
	}
	if (tCard.state_id[CARDSTAT_TYPE_REG] == '2')
	{
		writelog(LOG_ERR, "冲正交易卡号已注销cardid[%d]", tCard.card_id);
		*pRetCode = E_ACTNO_LOGOUT;
		goto L_RETU;
	}
	//查询当前流水表
//	ret = DB_t_tif_tradeserial_read_lock_by_c4_and_operate_date_and_serial_no_and_card_id(tx_date, serial_no, card_no, &tOldTradeserial);
	ret = DB_t_tif_tradeserial_read_lock_by_cur_and_serial_no(serial_no,&tOldTradeserial);
	if (ret)
	{
		writelog(LOG_ERR, "tx_date[%s]serial_no[%d]ret[%d]", tx_date, serial_no, ret);
		if (DB_NOTFOUND != ret)
		{
			*pRetCode = E_DB_TRADESERIAL_R;
			goto L_RETU;
		}
	}
	else
	{
		// 如果入账日期相同,表示同一笔流水
		if(strcmp(tOldTradeserial.enteract_date,tx_date) == 0)
		{
			flag = 1;
			memcpy(&tTradeserial, &tOldTradeserial, sizeof(tTradeserial));
			//上传端流水号
			tTradeserial.other_seri_no = tOldTradeserial.serial_no;	
			des2src(tTradeserial.reserve_1, tOldTradeserial.enteract_date);
			tOldTradeserial.serial_state = SERISTAT_RUSH;				//冲正
			ret = DB_t_tif_tradeserial_update_lock_by_cur(&tOldTradeserial);
			if (ret)
			{
				*pRetCode = E_DB_TRADESERIAL_U;
				writelog(LOG_ERR, "DB_t_tif_tradeserial_update_lock_by_c4[%d]", ret);
				goto L_RETU;
			}
			DB_t_tif_tradeserial_free_lock_cur();

			revAcc.iSerialNo= tOldTradeserial.serial_no;
			des2src(revAcc.sTxAccDate,tOldTradeserial.enteract_date);
		//	des2src(revAcc.sTxDate,tOldTradeserial.operate_date);
		}
	}
	if (!flag)
	{
		//查询历史流水表
//		ret = DB_t_tif_tradeserial_his_read_lock_by_c0_and_trans_year_and_trans_mon_day_and_serial_no_and_card_id(sYear, sMonDay, serial_no, card_no, &tTradeserialhis);
		ret = DB_t_tif_tradeserial_his_read_lock_by_c1_and_bak_date_and_serial_no(
			tx_date,serial_no,&tTradeserialhis);
		if (ret)
		{
			writelog(LOG_ERR, "enteract_date[%s]serialno[%d]ret[%d]", 
					 tx_date, serial_no, ret);
			if (DB_NOTFOUND == ret)
			{
				*pRetCode = E_SERIALNO_NOT_EXIST;
				goto L_RETU;
			}
			else
			{
				*pRetCode = E_DB_TRADESERIAL_R;
				goto L_RETU;
			}
		}
		tTradeserial.other_seri_no = tTradeserialhis.serial_no;					
		des2src(tTradeserial.reserve_1, tTradeserialhis.enteract_date);			// 被冲正的流水的入账日期
		tTradeserial.serial_state = tTradeserialhis.serial_state;				//流水状态
		tTradeserial.tmark = tTradeserialhis.tmark;								//999交易标记
		tTradeserial.maindevice_id = tTradeserialhis.maindevice_id;				//上传工作站标识(前置机注册号)
		tTradeserial.sys_id = tTradeserialhis.sys_id;
		tTradeserial.comu_ver = tTradeserialhis.comu_ver;						//通信版本号
		
		tTradeserial.device_id = tTradeserialhis.device_id;
		des2src(tTradeserial.devphy999_id, tTradeserialhis.devphy999_id);		//物理设备ID
		des2src(tTradeserial.dev_auth, tTradeserialhis.dev_auth);				//终端设备授权号
		des2src(tTradeserial.crc, tTradeserialhis.crc);							//CRC校验
		tTradeserial.card_id = tTradeserialhis.card_id;							//交易卡号
		tTradeserial.purse_id = tTradeserialhis.purse_id;						//消费钱包号
		tTradeserial.in_balance = tTradeserialhis.in_balance;					//入卡金额
		tTradeserial.out_balance = tTradeserialhis.out_balance;					//出卡金额
		tTradeserial.trade_fee = tTradeserialhis.trade_fee;						//本次消费金额
		tTradeserial.trade_count = tTradeserialhis.trade_count;					//当前卡中帐户消费次数(累计使用次数)
		tTradeserial.serial_type = tTradeserialhis.serial_type;					//交易代码
		tTradeserial.boardfee = tTradeserialhis.boardfee;						//搭伙费
		des2src(tTradeserial.operate_date, tTradeserialhis.operate_date);		//发生日期(格式化输入的日期)
		des2src(tTradeserial.operate_time, tTradeserialhis.operate_time);		//发生时间(格式化输入的时间)
		// 历史入账日期
		des2src(tTradeserial.enteract_date,tTradeserialhis.enteract_date);
		tTradeserial.condition_id = tTradeserialhis.condition_id;				// 收费科目
		
		tTradeserialhis.serial_state = SERISTAT_RUSH;							//冲正
		// 保存被冲正交易的操作员号
		//des2src(tTradeserial.oper_code, tTradeserialhis.oper_code);
		tTradeserial.customer_id = tTradeserialhis.customer_id;
		ret = DB_t_tif_tradeserial_his_update_lock_by_c1(&tTradeserialhis);
		if (ret)
		{
			*pRetCode = E_DB_TRADESERIAL_U;
			writelog(LOG_ERR, "DB_t_tif_tradeserial_update_lock_by_c1[%d]", ret);
			goto L_RETU;
		}
		DB_t_tif_tradeserial_his_free_lock_by_c1();

		revAcc.iSerialNo = tTradeserialhis.serial_no;
		des2src(revAcc.sTxAccDate,tTradeserialhis.enteract_date);
	//	des2src(revAcc.sTxDate,tTradeserialhis.operate_date);
	}
	if (tTradeserial.card_id != card_no)
	{
		writelog(LOG_ERR, "流水中卡号不符cardid[%d]serial[%d]", card_no, tTradeserial.card_id);
		*pRetCode = E_SERIALNO_NOT_EXIST;
		goto L_RETU;
	}
	if (tTradeserial.serial_state == SERISTAT_RUSH)
	{
		*pRetCode = E_TX_SERIAL_CZ;
		goto L_RETU;
	}
	if (tTradeserial.serial_state != SERISTAT_DEBT)
	{
		*pRetCode = E_TX_SERIAL_CANNOT_CZ;
		goto L_RETU;
	}
	if (amtcmp(tTradeserial.trade_fee, 0) <= 0)
	{
		*pRetCode = E_TX_SERIAL_CANNOT_CZ;
		strcpy(szMsg,"交易金额有误!");
		goto L_RETU;
	}

	ret = DB_t_pif_tradecode_read_by_tradecode(tTradeserial.serial_type, &tTradeCode);
	if (ret)
	{
		if (DB_NOTFOUND == ret)
		{
			writelog(LOG_ERR,"冲正交易码[%d]不存在",tTradeserial.serial_type);
			*pRetCode = E_DB_TRADECODE_N;
		}
		else
			*pRetCode = E_DB_TRADECODE_R;
		goto L_RETU;
	}

	if (tTradeCode.rush_flag != IS_YES)
	{
		*pRetCode = E_TX_SERIAL_CANNOT_CZ;
		strcpy(szMsg,"该交易不能被冲正");
		goto L_RETU;
	}

	ret = GetLogicDate(logic_date);						//业务日期
	if (ret)
	{
		*pRetCode = ret;
		writelog(LOG_ERR, "GetLogicDate  err ret[%d]", ret);
		goto L_RETU;
	}
	// 小于 0 , 则不判断
	if (tTradeCode.rush_max_day >= 0)
	{
		ret = DiffDay(logic_date, tTradeserial.enteract_date, &days);
		if (ret)
		{
			writelog(LOG_ERR,"ret[%d]date1[%s]date2[%s]",ret,
					 logic_date,tTradeserial.enteract_date);
			*pRetCode = ret;
			goto L_RETU;
		}
		writelog(LOG_DEBUG,"tradecode[%d]max day[%d]diff day[%d]",tTradeCode.tradecode
				 ,tTradeCode.rush_max_day,days);
		if (days > tTradeCode.rush_max_day)
		{
			writelog(LOG_ERR, "流水入账日期[%s],已超过期限[%d]天",
					 tTradeserial.enteract_date, days-tTradeCode.rush_max_day);
			*pRetCode = E_TX_SERIAL_CANNOT_CZ;
			strcpy(szMsg, "流水入账日期已超过可冲正期限!");
			goto L_RETU;
		}
	}

	if (tTradeCode.restrict_oper == IS_YES)
	{
		if (strcmp(rPack->scust_limit, tTradeserial.oper_code) != 0)
		{
			strcpy(szMsg, "必须由作此次交易的操作员来冲正");
			*pRetCode = E_TX_SERIAL_CANNOT_CZ;
			goto L_RETU;
		}
	}

	des2src(revAcc.sMdeOper, rPack->scust_limit);
	des2src(revAcc.sChkOper,rPack->scust_limit2);
	des2src(revAcc.sTxDate,sysdate);
	des2src(revAcc.sTxTime,systime);
	
	des2src(tTradeserial.operate_date, sysdate);
	des2src(tTradeserial.operate_time, systime);
	des2src(tTradeserial.collect_date, sysdate);
	des2src(tTradeserial.collect_time, systime);
	des2src(tTradeserial.enteract_date, logic_date);						//业务日期
	des2src(tTradeserial.enteract_time, systime);

	/////有卡冲正
	if(rPack->lvol3)
	{
		if(rPack->lvol10 <=0)			//交易次数
			return E_INPUT_CARD_TXCNT;
		
		revAcc.iUseCardFlag = USE_CARD_TYPE_ONLINE;
		revAcc.iTradeCnt = rPack->lvol10 + 1;
		revAcc.dInCardBala = rPack->damt1;		//有卡冲正，卡片上余额
		tTradeserial.in_balance = rPack->damt1;			
		tTradeserial.trade_count = rPack->lvol10 + 1;        //交易次数增加
	}
	else												//使用流水的出卡值作为冲正流水的入卡值
	{
		revAcc.iUseCardFlag = USE_CARD_TYPE_NULL;
		tTradeserial.in_balance = tTradeserial.out_balance ;
		revAcc.dInCardBala = tTradeserial.in_balance;
		revAcc.iTradeCnt = tTradeserial.trade_count;
	}

	revAcc.dOutCardBala=revAcc.dInCardBala;						//在冲正模块中计算出卡值
	tTradeserial.trade_fee = -1 * tTradeserial.trade_fee;					//本次消费金额
	tTradeserial.boardfee = -1 * tTradeserial.boardfee;					//本次消费管理费
	tTradeserial.maindevice_id = rPack->lvol6;
	tTradeserial.device_id = 0;
	revAcc.maindevice_id = tTradeserial.maindevice_id;
	// 上传的操作员号
	des2src(tTradeserial.oper_code, rPack->scust_limit);
	tTradeserial.reviseserial_no = tTradeserial.other_seri_no;				//被冲正的流水的流水号

	switch (tTradeserial.serial_type)
	{
	case 847106: // 现金充值冲正
		
		ret = Isnot_cash_847106(&tTradeserial);		// 不是现金充值，不能冲正
		if(ret)
		{
			*pRetCode = ret;
			goto L_RETU;
		}
		break;
	default:
		break;
	}
	//取流水号,入帐处理
	ret = getNewUniqNo(KEYTYPE_TRADESERIAL, &dUniqno);
	if (ret)
	{
		*pRetCode = ret;
		writelog(LOG_ERR, "getNewUniqNo err[%d]", ret);
		goto L_RETU;
	}
	tTradeserial.serial_no = D2I(dUniqno);
	//######################################################
	//入账处理

	revAcc.iRevSeriNo = tTradeserial.serial_no;
	revAcc.iTradeNo = tTradeserial.serial_type;
	ret = ReverseProcess(&revAcc);
	if(ret)
	{
		*pRetCode = ret;
		writelog(LOG_ERR, "ReverseProcess err[%d]", ret);
		goto L_RETU;
	}
	
	//######################################################
	//添加交易流水
	tTradeserial.serial_type = TXCODE_TX_REVEAL;		//交易代码记录为冲正
	tTradeserial.serial_state = SERISTAT_DEBT;
	tTradeserial.out_balance = revAcc.dOutCardBala;
	ret = DB_t_tif_tradeserial_add(&tTradeserial);
	if (ret)
	{
		writelog(LOG_ERR, "DB_t_tif_tradeserial_add ret[%d]", ret);
		if (DB_REPEAT == ret)
			*pRetCode = E_DB_TRADESERIAL_E;
		else
			*pRetCode = E_DB_TRADESERIAL_I;
		goto L_RETU;
	}
	if (amtcmp(tTradeserial.out_balance, 0) < 0)
	{
		*pRetCode = E_ENTER_ACCOUNT;
		goto L_RETU;
	}
	SetCol(handle, 0);
	SetCol(handle, F_LSERIAL1, F_DAMT2, F_DAMT3, F_VSMESS, 0);
	out_pack->lserial1 = tTradeserial.serial_no;
	out_pack->damt2 = tTradeserial.out_balance;
	out_pack->damt3 = -tTradeserial.trade_fee;
	sprintf(out_pack->vsmess, "流水号:%d 冲正金额:%.2lf元 冲正前卡余额:%.2lf元 卡当前余额:%.2lf元", tTradeserial.serial_no, -tTradeserial.trade_fee , tTradeserial.in_balance, tTradeserial.out_balance);
	writelog(LOG_DEBUG, out_pack->vsmess);
	PutRow(handle, out_pack, pRetCode, szMsg);
	return 0;
L_RETU:
	return -1;
}
