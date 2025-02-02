/* ----------------------------------------------------------
 * 程序名称：F900077.cpp
 * 创建日期：2004-09-09
 * 程序作者：韩海东
 * 版本信息：1.0.0.0
 * 程序功能：转帐服务程序
 * ----------------------------------------------------------
 * ----------------------------------------------------------*/

#define _IN_SQC_
#include <string.h>
#include <stdio.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/sem.h>
#include<sys/shm.h>
#include <signal.h>
#include "errdef.h"
#include "mypub.h"
#include "cpack.h"
#include "bupub.h"
//#include "pubdb.h"
#include "pubfunc.h"
//#include "fdsqc.h"
#include "transinfo.h"
#include "bank.h"
#include "shem.h"
//#include "do_trade.h"

#ifndef	SEGSIZE
	#define 	SEGSIZE	1024
#endif
#ifndef DEBUG
	#define DEBUG
#endif
//#define CHECK_BANK_LOGIN	if(shm[3]!=1) goto L_RET_BANK_NOT_LOGIN;


// {900077 ,F900077,"转帐服务程序" ,"hhd"       ,1,     false,0,0,0,0,0},
//查询转帐流水
int Pos_QuerySerial(INNER_TRANS_REQUEST * pNode,TRUSERID * handle,int *pRetCode,char *szMsg);
int query_subsidy(ST_PACK *in_pack,TRUSERID *handle,int *pRetCode,char *szMsg);
int get_subsidy(ST_PACK *in_pack,TRUSERID *handle,int *pRetCode,char *szMsg);
int do_update_card_info(ST_PACK *in_pack,TRUSERID *handle,int *pRetCode,char *szMsg);


int F900077(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg)
{

	int ret=0;
	int checkpwd = 1;
	char tradecode[6+1]="";
	
	// 此处检查银行登陆状态,可能过于严格,可转移到switch中需要银行登陆的功能中
	/*
	if(!BANK_LOGIN)
	{
		*pRetCode=E_TRANS_BANK_NETERR;
		return *pRetCode;
	}
	*/
	INNER_TRANS_REQUEST 	from_pos,to_pos;
	//BANK_TRANS_REQUEST		from_bank;

	ST_CPACK aPack;
	ST_PACK *out_pack = &(aPack.pack);

	// 用于根据请求包整理本CPACK包的头清空包头位图和包体中的数据
	SetErrMsg("");
	ResetNormalCPack(&aPack,0,1);
	//初始化交换结构
	memset(&from_pos,0,sizeof(from_pos));
	//从输入cpack中提取数据，填充到通用交换数据结构中
	memcpy(from_pos.TradeCode,in_pack->sclose_emp,sizeof(from_pos.TradeCode));		//交易代码
	memcpy(from_pos.TransMoney,in_pack->sorder0,sizeof(from_pos.TransMoney));								   //交易金额
	memcpy(from_pos.ExtraMoney,in_pack->sorder1,sizeof(from_pos.ExtraMoney));								//附加交易金额
	memcpy(from_pos.AccountMoney,in_pack->sserial1,sizeof(from_pos.AccountMoney));							//校园卡帐户金额
	from_pos.SendNo=in_pack->lvol0;												//发起方流水号
	from_pos.RecvNo=in_pack->lvol1;												//接受方流水号
	memcpy(from_pos.TradeDate,in_pack->sdate0,sizeof(from_pos.TradeDate));			//交易日期	 YYYYMMDD
	memcpy(from_pos.TradeTime,in_pack->stime0,sizeof(from_pos.TradeTime));			//交易时间	 HHMMSS
	memcpy(from_pos.BankDate,in_pack->sdate1,sizeof(from_pos.BankDate));			//银行处理日期
	memcpy(from_pos.BankTime,in_pack->stime1,sizeof(from_pos.BankTime));			//银行处理时间
	memcpy(from_pos.Balance,in_pack->scust_no,sizeof(from_pos.Balance));			//银行卡余额
	memcpy(from_pos.RetCode,in_pack->schange_emp,sizeof(from_pos.RetCode));		//交易结果
	memcpy(from_pos.CardNo,in_pack->sserial0,sizeof(from_pos.CardNo));				//校园卡卡号
	from_pos.Notecase=in_pack->lvol2;												//校园卡对应钱包号
	memcpy(from_pos.BankCardNo,in_pack->scust_auth,sizeof(from_pos.BankCardNo));	//银行卡号
	from_pos.MngFeeFlag=atoi(in_pack->sstatus1);									//手续费标志
	memcpy(from_pos.AccountPwd,in_pack->semp_pwd,sizeof(from_pos.AccountPwd));	//校园账户密码
	memcpy(from_pos.AccountNewPwd,in_pack->semp_pwd2,sizeof(from_pos.AccountNewPwd));	//校园账户新密码
	memcpy(from_pos.BankCardPwd,in_pack->sstation0,sizeof(from_pos.BankCardPwd));			//银行账户密码
	memcpy(from_pos.BankCardNewPwd,in_pack->sstation1,sizeof(from_pos.BankCardNewPwd));	//银行账户新密码
	memcpy(from_pos.TerminalId,in_pack->sorder2,sizeof(from_pos.TerminalId));				//终端编号
	strncpy(from_pos.Reserve1, in_pack->vsvarstr0, sizeof(from_pos.Reserve1));
	strncpy(from_pos.Reserve2, in_pack->vsvarstr1, sizeof(from_pos.Reserve2));
	strncpy(from_pos.Reserve3, in_pack->vsvarstr2, sizeof(from_pos.Reserve3));
	memcpy(from_pos.SencodMagTune,in_pack->sbank_acc,sizeof(from_pos.SencodMagTune));
	memcpy(from_pos.ThirdMagTune,in_pack->scusttypes,sizeof(from_pos.ThirdMagTune));
	//使用两个备用字段取南京银行所需的持卡人姓名和身份证号字段
	//ret=Get_cut_name_and_id(atoi(from_pos.CardNo),from_pos.Reserve2,from_pos.Reserve3);
	//if(ret)
	//{
		//writelog(LOG_ERR,"Get_cut_name_and_id err,errcode=[%d],name=[%20s]",ret,from_pos.Reserve2);
	//}
	//判断交易代码，进行相应处理
	//switch(241031)
	//int temp=atoi(from_pos.TradeCode);
	//printf("this is test record:atoi(from_pos.TradeCode)=[%d]\n",temp);

	SetCol(handle,0);
   	SetCol(handle,F_SCLOSE_EMP,F_SORDER0,F_SORDER1,F_SSERIAL1,F_LVOL0,F_LVOL1,F_SDATE0,F_STIME0,F_SDATE1,F_STIME1,F_SCUST_NO,F_SCHANGE_EMP,F_SSERIAL0,F_LVOL2,F_SCUST_AUTH,F_SSTATUS1,F_SEMP_PWD,F_SEMP_PWD2,F_SSTATION0,F_SSTATION1,F_SORDER2,0);

	memcpy(tradecode,from_pos.TradeCode,sizeof(from_pos.TradeCode));
	tradecode[6]=0;
	writelog(LOG_INFO,"Trade start,trade code=[%6.6s],card_id=[%s],bankcardno=[%s],TerminalId=[%s],SendNo=[%d],BankTime=[%s],TradeTime=[%s],SendMagTune=[%s],ThirdMagTune=[%s], Reserve1=[%s], Reserve2=[%s], Reserve3=[%s], BankCardPwd=[%s]",tradecode,from_pos.CardNo,from_pos.BankCardNo,from_pos.TerminalId,from_pos.SendNo,from_pos.BankTime,from_pos.TradeTime,in_pack->sbank_acc,in_pack->scusttypes, from_pos.Reserve1, from_pos.Reserve2, from_pos.Reserve3, from_pos.BankCardPwd);
	switch(atoi(tradecode))
	{
		case TRADE_INNER_CHKPWD:
			ret=VerifyCardPwd(in_pack->lvol0,in_pack->scust_limit,szMsg);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				writelog(LOG_INFO,"VerifyCardPwd error!cardid=[%d]cardpwd[%s]",in_pack->lvol0,in_pack->scust_limit);
				return E_TRANS_SCHCARD_PWDERR;
			}
			break;
		case TRADE_INNER_QUERYBANK:
			if(Is_out_of_service())
			{
				sprintf(szMsg,"不在银行服务时间");			
				return E_TRANS_BANK_SERVICE_NOEXIT;
			}
			if(!BANK_LOGIN)
			{
				return E_TRANS_BANK_NETERR;
			}
			ret=Pos_QueryBank(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_ELEC:
			checkpwd = 0; // 电子钱包
		case TRADE_INNER_TRANS:
		case TRADE_INNER_YCT:
			if(Is_out_of_service())
			{
				strcpy(szMsg,"不在银行服务时间");			
				return E_TRANS_BANK_SERVICE_NOEXIT;
			}
			if(!BANK_LOGIN)
			{
				
				strcpy(szMsg,"银行网络故障");
				return E_TRANS_BANK_NETERR;
			}
	//广州大学城要求，如果中大的圈存机
	//则限制圈存金额不超过20元
//			if((atoi(from_pos.TerminalId)==5925)&&(atoi(from_pos.TransMoney)>2000))
//			{
//				*pRetCode=E_TRANS_TRANSMONEY_OUTRANGE;
//				goto L_RETU;
//			}
	// 应云南财大要求, 圈存金额不允许超过200元
	//		writelog(LOG_INFO,"pos_trans_money=[%d], bank_trans_money=[%d]", atoi(from_pos.TransMoney), g_Bank.trans_money);
			//writelog(LOG_INFO,"Pos_Transfer Begin Amount[%s]",from_pos.TransMoney);
			ret=Pos_Transfer(&from_pos,atoi(tradecode),checkpwd);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				writelog(LOG_INFO,"Pos_Transfer Failed End");
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			writelog(LOG_INFO,"Pos_Transfer End");
			break;
			// modify by 汤成2008-08-30 
			// 增加银行卡转账冲正交易
		case TRADE_INNER_TRANS_REVERSE:
			ret = Pos_Bank_Reverse(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_FEE:
			ret=Pos_Fee(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_ADDRELATION:
			ret=Pos_AddRelation(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_DELRELATION:
			ret=Pos_DelRelation(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_POSLOGIN:
			ret=Pos_Login(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_QUERYINNER:
			//ret=Pos_QuerySchool(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_CHANGEPWD:
			ret=Pos_ChangePwd(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_LOST:
			ret=Pos_LostCard(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_UNLOST:
			ret=Pos_UnlostCard(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			memcpy(&to_pos,&from_pos,sizeof(to_pos));
			break;
		case TRADE_INNER_QUERYSERIAL:
			ret=Pos_QuerySerial(&from_pos,handle,pRetCode,szMsg);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			return 0;
		case TRADE_INNER_WRITEERRCARD:
			ret=Pos_WriteErrCard(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			break;
		//前台发起部分，包括签到、签退、对帐等
		case TRADE_INNER_LOGIN:
			writelog(LOG_ERR,"start inner login!");
			break;
		//查询补助信息
		case TRADE_INNER_QUERYSUBSIDY:
			/*
			ret=query_subsidy(in_pack,handle,pRetCode,szMsg);
			if(ret)
			{
				*pRetCode=ret;
				goto L_RETU;
			}
			*/
			return 0;
		//领取补助
		case TRADE_INNER_GETSUBSIDY:
			//ret=get_subsidy(in_pack,handle,pRetCode,szMsg);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			return 0;
		case TRADE_INNER_UPDATECOMSUMELIMIT:
			ret = do_updateconsumelimit(in_pack);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			return 0;

		case TRADE_INNER_DEVBEATE:
			ret = do_update_device_state(&from_pos);
			if(ret)
			{
				strcpy(szMsg,GetErrMsg());
				return ret;
			}
			
			return 0;

		/*
		case TRADE_INNER_TRANSFER_WFAIL:
			ret = do_write_card_fail(in_pack,handle,pRetCode,szMsg);
			if (ret)
			{
				*pRetCode = ret;
				goto L_RETU;
			}
			break;
		case TRADE_INNER_BUYWATER:
			ret = do_buy_water(in_pack,handle,pRetCode,szMsg);
			writelog(LOG_ERR,"do buy water failed--ret=[%d]",ret);
			if (ret)
			{
				*pRetCode = ret;
				goto L_RETU;
			}
			break;
		*/	
		default:
			writelog(LOG_INFO,"This trade can't supplied,tradecode=[%d]!",atoi(tradecode));
			strcpy(szMsg,"该功能不支持�");
			return E_TRANS_FUNC_NONSUPPORT;
	}
	des2src(out_pack->sclose_emp,to_pos.TradeCode);
	des2src(out_pack->sorder0,to_pos.TransMoney);
	des2src(out_pack->sorder1,to_pos.ExtraMoney);
	des2src(out_pack->sserial1,to_pos.AccountMoney);
	out_pack->lvol0=to_pos.SendNo;
	out_pack->lvol1=to_pos.RecvNo;
	des2src(out_pack->sdate0,to_pos.TradeDate);
	des2src(out_pack->stime0,to_pos.TradeTime);
	des2src(out_pack->sdate1,to_pos.BankDate);
	des2src(out_pack->stime1,to_pos.BankTime);
	des2src(out_pack->scust_no,to_pos.Balance);
	des2src(out_pack->schange_emp,to_pos.RetCode);
	des2src(out_pack->sserial0,to_pos.CardNo);
	out_pack->lvol2=to_pos.Notecase;
	des2src(out_pack->scust_auth,to_pos.BankCardNo);
	sprintf(out_pack->sstatus1,"%c",to_pos.MngFeeFlag);
	des2src(out_pack->semp_pwd,to_pos.AccountPwd);
	des2src(out_pack->semp_pwd2,to_pos.AccountNewPwd);
	des2src(out_pack->sstation0,to_pos.BankCardPwd);
	des2src(out_pack->sstation1,to_pos.BankCardNewPwd);
	des2src(out_pack->sorder2,to_pos.TerminalId);

	PutRow(handle,out_pack,pRetCode,szMsg);
	writelog(LOG_INFO,"Trade succeed,trade code=[%6.6s]!",to_pos.TradeCode);
	return 0;
}



