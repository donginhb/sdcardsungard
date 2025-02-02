/* --------------------------------------------
 * 程序名称: F847307.c
 * 创建日期: 2006-12-12
 * 程序作者: 闻剑
 * 版本信息: 1.0.0.0
 * 程序功能: 小钱包转大钱包
 * --------------------------------------------*/

#include <string.h>
#include <stdio.h>
#include "cpack.h"
#include "errdef.h"
#include "pubdef.h"
#include "pubdb.h"
#include "dbfunc.h"
#include "mypub.h"
#include "pubfunc.h"
#include "account.h"
#include "fdsqc.h"
#include "dbfunc_foo.h"

static int process(InAcc * IA, T_t_tif_tradeserial * p)
{
    int ret = 0;
    //根据卡号和钱包号得到消费者账号(借方)
    IA->iMainDevId = p->maindevice_id;                  //工作站标示
    IA->iDevId = p->device_id;                          //设备ID号
    IA->iSerialNo = p->serial_no;                       //流水号
    IA->iTradeNo = p->serial_type;                      //交易代码 
    strcpy(IA->sTxDate, p->operate_date);               //交易日期
    strcpy(IA->sTxTime, p->operate_time);               //交易时间
    strcpy(IA->sTxCollectDate, p->collect_date);        //采集日期
    strcpy(IA->sTxCollectTime, p->collect_time);        //采集时间
    strcpy(IA->sTxAccDate, p->enteract_date);           //记帐日期
    strcpy(IA->sTxAccTime, p->enteract_time);           //记帐时间

    IA->iTxCnt = p->trade_count;                        //交易次数
    IA->iUseCardFlag = USE_CARD_TYPE_ONLINE;            //联机交易
    IA->dInCardBala = p->in_balance;                    //入卡值
    IA->dOutCardBala = -1;                              //出卡值
    des2src(IA->sMdeOper, p->oper_code);                 //操作员号

    // 修改借方和贷方的帐户余额, 记会计分录入帐
    ret = AccountProcess(IA);
    if (ret)
    {
        writelog(LOG_ERR,"AccountProcess ret[%d]",ret);
        return ret;
    }
    p->out_balance = IA->dOutCardBala;                  //出卡值          
    return 0;
}

int F847307(TRUSERID *handle,int iRequest,ST_PACK *rPack,int *pRetCode,char *szMsg)
{
    T_t_tif_tradeserial tSerial, tPacketSerial;
    T_t_aif_account tAccount;
    T_t_pif_card tCard;
    T_t_cif_customer tCustomer;
    T_t_tif_writefailed tWriteFailed;
    InAcc IA;

    ST_CPACK aPack;
    ST_PACK *out_pack = &(aPack.pack);

    int ret = 0;
    int TxTypeCount = 0;
    int hi_cardid = 0;             //交易卡号
    char buf[100 + 1] = "";
    char sysdate[11] = "";
    char systime[7] = "";
    char logicdate[11] = "";
    char sMsg[128] = "";
    double dUniqNo = 0;                              //最大流水号
    double in_balance = 0;
    double small_packet_balance = 0;                    //小钱包中的余额
    double max_balance = 0;                           //小钱包余额上限  
    double transfer_price = 0;                          //转入金额

    memset(&tAccount, 0, sizeof tAccount);
    memset(&tCard, 0, sizeof tCard);
    memset(&tCustomer, 0, sizeof tCustomer);
    memset(&IA, 0, sizeof IA);
    memset(&tPacketSerial, 0, sizeof tPacketSerial);
    memset(&tWriteFailed, 0, sizeof tWriteFailed);

    memset(&aPack,0,sizeof aPack);
    ResetNormalCPack(&aPack, 0, 1);
    SetCol(handle,0);
    SetCol(handle,F_LVOL0,F_LVOL1,F_DAMT0,F_DAMT2,F_VSMESS,F_LVOL9,F_LVOL5,0);

    hi_cardid = rPack->lvol0;
    if (hi_cardid <= 0)
    {
        *pRetCode = E_INPUT_CARDNO;
        goto L_RETU;
    }

    //判断小钱包中的余额
    small_packet_balance = rPack->damt3;

    //读取小钱包余额上限
    ret = GetParameter(GLB_PACKET_LIMITS,buf);
    if (ret)
    {
        *pRetCode = ret;
        goto L_RETU;
    }
    max_balance = atof(buf);
    if (amtcmp(max_balance,0) <= 0)
    {
        *pRetCode = E_GLOBAL_PARAM_ERROR;
        goto L_RETU;
    }

    //判断充值到小钱包的金额
    transfer_price = rPack->damt4;               //钱包转入金额
    in_balance = rPack->damt1;
    writelog(LOG_DEBUG,"in_balance=[%lf]",in_balance);
    writelog(LOG_DEBUG,"tranfser_price=[%lf]",transfer_price);
    writelog(LOG_DEBUG,"small_packet_balance=[%lf]",small_packet_balance);
    if (amtcmp(transfer_price, 0) <= 0 || amtcmp(small_packet_balance, 0) < 0)
    {
        *pRetCode = E_INPUT_DATA_INVAILD;
        goto L_RETU;
    }
    if (amtcmp(in_balance,0.0) < 0)
    {
        *pRetCode = E_BALANCE_SHORTAGE;
        goto L_RETU;
    }
    
    ret = DB_t_pif_card_read_by_card_id(hi_cardid,&tCard);
	if(ret)
	{
		if(DB_NOTFOUND == ret)
		{
		    *pRetCode = E_DB_CARD_N;
		}
		else
		{
		    *pRetCode = E_DB_CARD_R;
	    }
	    goto L_RETU;
	}
	
    //判断卡密码是否正确
    /*
    if (CheckUserPswd(rPack->semp_pwd,tCard.password))
    {
        writelog(LOG_ERR,"Card password error");
        *pRetCode = E_TRANS_SCHCARD_PWDERR;
        goto L_RETU;
    }
    */
    
    if (strncmp(tCard.state_id, TYPE_YES, 1) != 0)
    {
        writelog(LOG_ERR,"card_state=[%s]",tCard.state_id);
        *pRetCode = E_TRANS_SCHACC_DESTORY;
        goto L_RETU;
    }

    if (STATE_TRUE == tCard.state_id[CARDSTAT_TYPE_LOST])
    {
        writelog(LOG_ERR,"card_state=[%s]",tCard.state_id);
        *pRetCode = E_TRANS_SCHCARD_LOSTING;
        goto L_RETU;
    }

    if (STATE_TRUE == tCard.state_id[CARDSTAT_TYPE_FREEZE])
    {
        writelog(LOG_ERR,"card_state=[%s]",tCard.state_id);
        *pRetCode = E_TRANS_SCHCARD_FREEZE;
        goto L_RETU;
    }

    if (STATE_TRUE == tCard.state_id[CARDSTAT_TYPE_WFAIL])
    {
        *pRetCode = E_CARDNO_WFAIL;
        goto L_RETU;
    }

    ret = DB_t_cif_customer_read_by_cut_id(tCard.cosumer_id,&tCustomer);
    if (ret)
    {
        if (DB_NOTFOUND == ret)
        {
            *pRetCode = E_DB_CUSTOMER_N;
        }
        else
        {
            *pRetCode = E_DB_CUSTOMER_R;
        }
        goto L_RETU;
    }

    //读取个人帐户
    ret = DB_t_aif_account_read_by_card_id_and_purse_id(tCard.card_id,PURSE_NO_ONE,&tAccount);
    if (ret)
    {
        if (DB_NOTFOUND == ret)
        {
            *pRetCode = E_DB_ACCOUNT_N;
        }
        else
        {
            *pRetCode = E_DB_ACCOUNT_R;
        }
        goto L_RETU;
    }
    //个人临时帐户填死掉了, 不需要查询
    ret = getNewUniqNo(KEYTYPE_TRADESERIAL,&dUniqNo);              // 获得最大流水号
    if (ret)
    {
        writelog(LOG_ERR,"ret[%d]",ret);
        *pRetCode = ret;
		goto L_RETU;
    }

    getsysdate(sysdate);
    getsystime(systime);
    GetLogicDate(logicdate);
    memset(&tSerial, 0, sizeof tSerial);
    tSerial.serial_no = D2I(dUniqNo);
    tSerial.other_seri_no = 0;
    tSerial.serial_state = SERISTAT_DEBT;                           //流水状态
    tSerial.serial_type = TXCODE_WALLET_TRANSFER;            //交易类型
    des2src(tSerial.operate_date,sysdate);                           //发生日期
    des2src(tSerial.operate_time,systime);                           //发生时间
    des2src(tSerial.collect_date,sysdate);                           //采集日期
    des2src(tSerial.collect_time,systime);                           //采集时间
    des2src(tSerial.enteract_date,logicdate);                        //处理日期
    des2src(tSerial.enteract_time,systime);                          //处理时间

//    tSerial.maindevice_id = rPack->lvol3;                            //上传工作站标识
    tSerial.device_id = 0;                                          //采集设备标识 
    tSerial.card_id = hi_cardid;                                    //交易卡号
    des2src(tSerial.showid,tCard.showid);                           //显示卡号
    tSerial.purse_id = PURSE_NO_ONE;                                //钱包号
    tSerial.customer_id = tCard.cosumer_id;                         //客户号
    des2src(tSerial.oper_code, rPack->scust_no);                      //操作员代码
    tSerial.sys_id = 0;
    tSerial.trade_count = rPack->lvol4 + 1;                          //钱包1卡交易次数
    tSerial.trade_fee = transfer_price;                             //转钱金额
    tSerial.in_balance = in_balance;                                //入卡值
    writelog(LOG_DEBUG,"水控转账入卡值[%.2lf]",in_balance);
    des2src(IA.sArrInActno[0],tAccount.account_id);                 //个人帐户
//  des2src(IA.sArrInActno[1],temp_account_id);                  //个人临时帐户
    IA.dArrInAmt[0] = tSerial.trade_fee;                            //交易金额
    IA.iCardNo = tCard.card_id;                                     //交易卡号
    IA.iFeeType = tCustomer.fee_type;                               //客户收费类型

    //调用入帐子模块
    ret = process(&IA,&tSerial);
    if (ret)
    {
        writelog(LOG_ERR,"process ret[%d]",ret);
        *pRetCode = ret;
        goto L_RETU;
    }
    sprintf(out_pack->vsmess,"流水号:%d 卡号:%d ",IA.iSerialNo,IA.iCardNo);
	for(TxTypeCount = 1; TxTypeCount <= IA.iOutTxTypeCnt; TxTypeCount++)
	{
		switch(IA.iArrOutTxType[TxTypeCount])
		{
			case TXTYPE_TOLL_DEPOSIT:
			case TXTYPE_TOLL_DEPOSIT_BILL:
			case TXTYPE_TOLL_DEPOSIT_FUNDBOOK:
			case TXTYPE_DEDUCT_DEPOSIT:
			case TXTYPE_RETURN_DEPOSIT:
				tSerial.deposit_fee = IA.dArrOutAmt[TxTypeCount];
				break;
			case TXTYPE_PRE_TOLL_BOARD:
			case TXTYPE_PRE_TOLL_BOARD_BILL:
			case TXTYPE_PRE_TOLL_BOARD_FUNDBOOK:
			case TXTYPE_TOLL_BOARD:
			case TXTYPE_DEDUCT_BOARD:
			case TXTYPE_RETURN_BOARD:
			case TXTYPE_RETURN_BOARD_BILL:
			case TXTYPE_RETURN_BOARD_FUNDBOOK:
				tSerial.boardfee = IA.dArrOutAmt[TxTypeCount];
				break;
			case TXTYPE_TOLL_CHARGE:
			case TXTYPE_TOLL_CHARGE_BILL:
			case TXTYPE_TOLL_CHARGE_FUNDBOOK:
				tSerial.in_fee = IA.dArrOutAmt[TxTypeCount];
				break;
			case TXTYPE_TOLL_CARDCOST:
			case TXTYPE_TOLL_CARDCOST_BILL:
			case TXTYPE_TOLL_CARDCOST_FUNDBOOK:
				tSerial.cost_fee = IA.dArrOutAmt[TxTypeCount];
				break;
			default:
				break;
		}
		if (amtcmp(IA.dArrOutAmt[TxTypeCount], 0) != 0)
		{
		    sprintf(sMsg,"%s:%.2lf元 ", IA.sArrOutTxName[TxTypeCount], IA.dArrOutAmt[TxTypeCount]);
			strcat(out_pack->vsmess, sMsg);
		}
	}
	sprintf(sMsg, "卡当前余额:%.2lf元", tSerial.out_balance);
	strcat(out_pack->vsmess, sMsg);
	writelog(LOG_DEBUG,out_pack->vsmess);
	rPack->damt5= tSerial.out_balance;
	//插入交易流水表
	ret = DB_t_tif_tradeserial_add(&tSerial);
	if (ret)
	{
	    writelog(LOG_ERR,"ret[%d]",ret);
		if (DB_REPEAT == ret)
		{
		    *pRetCode = E_DB_TRADESERIAL_E;
		}
		else
		{
		    *pRetCode = E_DB_TRADESERIAL_I;
		}
		goto L_RETU;
	}
	//保存充值流水
	memcpy(&tPacketSerial, &tSerial, sizeof tPacketSerial);
	ret = getNewUniqNo(KEYTYPE_TRADESERIAL,&dUniqNo);  						//获得最大流水号
	if(ret)
	{
		writelog(LOG_ERR,"ret [%d]",ret);
		*pRetCode = ret;
		goto L_RETU;
	}
	tPacketSerial.serial_no = D2I(dUniqNo);
	tPacketSerial.serial_state = SERISTAT_NONEEDDEBT;
	tPacketSerial.serial_type = TXCODE_DEPOSIT_SMALL_PACKET;
	tPacketSerial.purse_id = PURSE_NO_TWO;
	tPacketSerial.trade_count = rPack->lvol5 + 1;
    	des2src(tPacketSerial.oper_code, rPack->scust_no);
	tPacketSerial.in_balance = small_packet_balance;
	tPacketSerial.trade_fee = transfer_price;
//	tPacketSerial.out_balance = small_packet_balance + tPacketSerial.trade_fee;
	tPacketSerial.out_balance = small_packet_balance -tPacketSerial.trade_fee;
	
	ret = DB_t_tif_tradeserial_add(&tPacketSerial);
	if(ret)
	{
		if(DB_REPEAT == ret)
		{
	        *pRetCode = E_DB_TRADESERIAL_E;	
		}
		else
		{
		    *pRetCode = E_DB_TRADESERIAL_I;
		}
		goto L_RETU;
	}
	out_pack->lvol0 = tSerial.serial_no;
	out_pack->lvol1 = tPacketSerial.serial_no;
	out_pack->damt2 = tPacketSerial.out_balance;
	out_pack->damt0 = tSerial.out_balance;
	out_pack->lvol9 = tSerial.trade_count;
	out_pack->lvol5 = tPacketSerial.trade_count;
	writelog(LOG_DEBUG,"水控钱包余额[%.2lf], 出卡值[%.2lf]",out_pack->damt2,out_pack->damt0);
	if(TXCODE_CALLBACK_CARD!=iRequest)
		PutRow(handle,out_pack,pRetCode,szMsg);
    return 0;
L_RETU:
	return -1;	
}

