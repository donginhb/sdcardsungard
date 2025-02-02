/* --------------------------------------------
 * 程序名称: F930034.sqc
 * 创建日期: 20050306
 * 程序作者: 闻剑
 * 版本信息: 1.0.0.0
 * 程序功能:  采集现金充值流水
 * --------------------------------------------*/
#define _IN_SQC_
#include <stdio.h>
#include <string.h>
#include "pubdef.h"
#include "errdef.h"
#include "pubfunc.h"
#include "pubdb.h"
#include "dbfunc.h"
#include "acctrans.h"
#include "busqc.h"

static int check(T_t_posdtl *p) {
    int ret=0;
    if(strlen(p->crc)==0) {
        return E_999_CRC;							//上传流水CRC校验错误
    }
    ret=IsInvalidDateTime(p->transdate,"YYYYMMDD");
    if(ret) {
        return E_999_DATE;							//上传流水交易日期有误
    }
    ret=IsInvalidDateTime(p->transtime,"HHMMSS");
    if(ret) {
        return E_999_TIME;							//上传流水交易时间有误
    }
    if((p->transmark!=0XFA)&&(p->transmark!=0xFE)) {
        return 	p->transmark+E_999_0X00;			//把返回码置为交易标记
    }
    if(0XFA==p->transmark) {
        if(p->cardaftbal<=p->cardbefbal) {
            return E_999_CARD_BALANCE;					//上传流水出入卡余额有误
        }
        if(p->amount<=0) {
            return E_999_AMT;							//上传流水交易发生金额有误
        }
    } else {
        if(p->cardaftbal>=p->cardbefbal) {
            return E_999_CARD_BALANCE;					//上传流水出入卡余额有误
        }
        if(p->amount>=0) {
            return E_999_AMT;							//上传流水交易发生金额有误
        }
    }
    return 0;
}
int F930034(TRUSERID *handle,int iRequest,ST_PACK *rPack,int *pRetCode,char *szMsg) {

    int ret=0;
    T_t_posdtl posdtl;

    /*
    ret=chk_dyn_key(rPack->lcert_code,rPack->scust_limit2);
    if(ret)
    {
    	writelog(LOG_ERR,"subsys_id[%d]dyn_key[%s]",rPack->lcert_code,rPack->scust_limit2);
    	*pRetCode =  ret;
    	goto L_RETU;
    }
    */
    memset(&posdtl,0,sizeof(posdtl));

    posdtl.devseqno= rPack->lvol4;							//上传端流水号
    posdtl.transmark=rPack->lvol12;							//999交易标记
    posdtl.sysid  = rPack->lcert_code;						//上传工作站标识(前置机注册号)
    des2src(posdtl.devphyid, rPack->sdate1);				//物理设备ID
    des2src(posdtl.inpower_no,rPack->stx_pwd);				//终端设备授权号
//	posdtl.comu_ver=rPack->lbank_acc_type;				//通信版本号
//	posdtl.run_reason = rPack->lbank_acc_type2;				//启动原因
    des2src(posdtl.crc,rPack->sbank_code2);				//CRC校验

    posdtl.cardno= rPack->lvol5;							//交易卡号
    posdtl.purseno = rPack->lvol6;						//消费钱包号
    posdtl.cardbefbal= rPack->lvol9;							//入卡金额
    posdtl.cardaftbal = rPack->lvol10;						//出卡金额
    posdtl.amount = rPack->lvol8;							//本次消费金额
    posdtl.cardcnt= rPack->lvol7;							//当前卡中帐户消费次数(累计使用次数)
    sprintf(posdtl.oper_no,"%d",rPack->lvol3);				//操作员号
    posdtl.transcode = 930034;								//交易代码
    snprintf(posdtl.transdate,9,"20%s",rPack->spost_code);		//发生日期(格式化输入的日期)
    des2src(posdtl.transtime,rPack->spost_code2);			//发生时间(格式化输入的时间)
    getsysdate(posdtl.coldate);
    ret=check(&posdtl);
    if(ret) {
        posdtl.status[0]='5';								//无效交易
//		posdtl.run_reason=ret;
        posdtl.errcode=ret;
        strncpy(posdtl.accdate,posdtl.coltimestamp,8);
        strncpy(posdtl.acctime,posdtl.coltimestamp+8,6);
    } else
        posdtl.status[0]='1';
    g_dbchkerr=0;
    ret = DB_t_posdtl_add(&posdtl);
    if (ret) {
        g_dbchkerr=1;
        writelog(LOG_DEBUG,"serial_no[%d]cardno[%d]deviceid[%s]transdate[%s]transtime[%s]",posdtl.devseqno,posdtl.cardno,posdtl.devphyid,posdtl.transdate,posdtl.transtime);
        if(DB_REPEAT==ret)
            return 0;
        else
            *pRetCode = E_DB_TRADESERIAL_I;
        goto L_RETU;
    }
    g_dbchkerr=1;
    return 0;
L_RETU:
    //回滚事务
    return -1;
}

