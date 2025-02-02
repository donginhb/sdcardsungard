/* --------------------------------------------
 * 创建日期: 2009-11-10
 * 程序作者:xlh
 * 版本信息: 1.0.0.0
 * 程序功能: 新生换卡
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
#include "dbfunc_foo.h"
#include "busqc.h"
#include "acctrans.h"


static int SaveOldCardInfo(TRUSERID *handle,ST_PACK *rPack,int *pRetCode,char *szMsg)
{
		int ret=0;
		CAccTrans *pAccTrans=CAccTrans::getInstance();

		TRANS& trans=pAccTrans->trans;

		T_t_card tCard;

		memset(&tCard,0,sizeof(tCard));
		
		ret=DB_t_card_read_by_cardno(trans.cardno,&tCard);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return ERRINFO(E_NOTEXIST_CARDNO,trans.cardno);
			else 
				return E_DB_CARD_R;
		}
		if(tCard.status[0]!=STATUS_NORMAL)
		{
			return ERRINFO(E_CARD_LOGOUT,trans.cardno);
		}	
		if('1'==tCard.frozeflag[0])
		{
			return ERRINFO(E_CARD_FREEZE,trans.cardno);
		}
		if('1'==tCard.lossflag[0])
		{
			return ERRINFO(E_CARD_LOST,trans.cardno);
		}	
		if('1'==tCard.badflag[0])
		{
			return ERRINFO(E_CARD_BADRECORD,trans.cardno);
		}	
		//比较卡物理ID是否相同
		if(strcmp(tCard.cardphyid,trans.cardphyid)!=0)
		{
				writelog(LOG_ERR,"db cardphyid[%s],input cardphyid[%s]",tCard.cardphyid,trans.cardphyid);
				return E_CARD_PHYNO_DIFFER;
		}
		T_t_account tCardAccount;	
		memset(&tCardAccount,0,sizeof(tCardAccount));
		ret=DB_t_account_read_lock_by_c0_and_accno(tCard.accno,&tCardAccount);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return ERRINFO(E_NOTEXIST_CARDACCNO,tCard.accno);
			else 
				return E_DB_ACCOUNT_R;
		}
		tCardAccount.lastpaycnt=trans.paycnt;
		tCardAccount.lastcardbal=trans.cardbefbal;
		tCardAccount.paycnt = trans.paycnt;
		tCardAccount.cardbal=trans.cardbefbal;
		tCardAccount.lastsubsidyno=trans.cardsubsidyno;
		ret=DB_t_account_update_lock_by_c0(&tCardAccount);
		if(ret)
		{
			return E_DB_ACCOUNT_U;
		}
		ret=DB_t_cardinsteaddtl_del_by_cardno(trans.cardno);
		if(ret)
		{
			if(DB_NOTFOUND!=ret)
				return E_DB_CARDINSTEADDTL_R;
		}		
		T_t_cardinsteaddtl cardinsteaddtl;

		memset(&cardinsteaddtl,0,sizeof(cardinsteaddtl));
		des2src(cardinsteaddtl.accdate,pAccTrans->trans.accdate);
		cardinsteaddtl.termid = trans.termid;
		cardinsteaddtl.termseqno = trans.termseqno;
		cardinsteaddtl.cardno = trans.cardno;
		cardinsteaddtl.oldcardtype=tCard.cardtype;
		des2src(cardinsteaddtl.oldcardphyid,trans.cardphyid);
		des2src(cardinsteaddtl.oldshowcardno,tCard.showcardno);
		cardinsteaddtl.oldcardcnt = trans.paycnt;
		cardinsteaddtl.oldcardbal = trans.cardbefbal;	
		cardinsteaddtl.oldsubsidyno=trans.cardsubsidyno;
		cardinsteaddtl.revflag[0]='0';
		cardinsteaddtl.status[0]=STATUS_NORMAL;
		ret=DB_t_cardinsteaddtl_add(&cardinsteaddtl);
		if(ret)
		{
			if(DB_REPEAT==ret)
				return E_DB_CARDINSTEADDTL_E;
			else
				return E_DB_CARDINSTEADDTL_I;
		}

         T_t_cardver cardver;
		
		memset(&cardver,0,sizeof(cardver));
		cardver.cardno=tCard.cardno;
		des2src(cardver.accdate,pAccTrans->trans.accdate);
		cardver.termid=trans.termid;
		cardver.termseqno=trans.termseqno;
		cardver.status[0]=STATUS_NORMAL;	
		des2src(cardver.cardphyid,cardinsteaddtl.oldcardphyid);
		des2src(cardver.stuempno,trans.stuempno);
		cardver.cardvertype=CARDVERTYPE_CARDINSTEADOLD;
		ret=getCardVerNo(cardver.cardverno);
		if(ret)
			return ret;
        
		ret=DB_t_cardver_add(&cardver);
		if(ret)
		{
			if(DB_REPEAT==ret)
				return E_DB_CARDVER_E;
			else
				return E_DB_CARDVER_I;
		}

		T_t_newcardchange newcardchange;
		memset(&newcardchange,0,sizeof(newcardchange));

		ret=DB_t_newcardchange_read_lock_by_c1_and_showcardno(trans.showcardno,&newcardchange);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return E_DB_NEWCARDCHANGE_N;
			else
				return E_DB_NEWCARDCHANGE_R;
		}
		newcardchange.status= NEWCARDSTATUS_INIT;
		des2src(newcardchange.oldcardphyid,cardinsteaddtl.oldcardphyid);
		des2src(newcardchange.cardphyid,rPack->scust_no2);
		des2src(newcardchange.lastsaved,trans.sysdatetime);
		ret=DB_t_newcardchange_update_lock_by_c1(&newcardchange);
		if(ret)
		{
			return E_DB_NEWCARDCHANGE_U;
		}
		ST_CPACK aPack;
		ST_PACK *outPack = &(aPack.pack); 
		
		ResetNormalCPack(&aPack,0,1);

			
		SetCol(handle,0);
		
		SetCol(handle,F_LWITHDRAW_FLAG,F_LSERIAL1,F_VSMESS,0);	
		des2src(outPack->sdate3,pAccTrans->trans.accdate);
		outPack->lwithdraw_flag=trans.termid;
		outPack->lserial1=trans.termseqno;
		PutRow(handle,outPack,pRetCode,szMsg); 		
		return 0;
}
static int DoCardInstead(TRUSERID *handle,ST_PACK *rPack,int *pRetCode,char *szMsg)
{
		int ret=0;
	    char  sqlcmd[2048]="";
		CAccTrans *pAccTrans=CAccTrans::getInstance();
		TRANS& trans=pAccTrans->trans;
		ST_CPACK aPack;
		ST_PACK *outPack = &(aPack.pack); 
		
		ResetNormalCPack(&aPack,0,1);

			
		SetCol(handle,0);
		
		SetCol(handle,F_LVOL1,F_LSAFE_LEVEL2,F_LVOL4,F_LVOL5,
					F_SALL_NAME,F_SPAGER,F_SCERT_NO,
					F_SEMAIL2,F_SMARKET_CODE,F_SDATE0,
					F_LVOL0,F_STX_PWD,F_LVOL8,F_LVOL6,
					F_SORDER0,F_LWITHDRAW_FLAG,F_SDATE3,F_LVOL11,F_LVOL12,
					F_LWITHDRAW_FLAG,F_LSERIAL1,F_VSMESS,0);	

		T_t_card  tCard;
		memset(&tCard,0,sizeof(tCard));
		ret=DB_t_card_read_by_cardno(trans.cardno,&tCard);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return ERRINFO(E_NOTEXIST_CARDNO,trans.cardno);
			else 
				return E_DB_CARD_R;
		}
		if(tCard.status[0]!=STATUS_NORMAL)
		{
			return ERRINFO(E_CARD_LOGOUT,trans.cardno);
		}	
		if('1'==tCard.frozeflag[0])
		{
			return ERRINFO(E_CARD_FREEZE,trans.cardno);
		}
		if('1'==tCard.lossflag[0])
		{
			return ERRINFO(E_CARD_LOST,trans.cardno);
		}	
		if('1'==tCard.badflag[0])
		{
			return ERRINFO(E_CARD_BADRECORD,trans.cardno);
		}	
		T_t_account tCardAccount;	
		memset(&tCardAccount,0,sizeof(tCardAccount));
		ret=DB_t_account_read_by_accno(tCard.accno,&tCardAccount);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return ERRINFO(E_NOTEXIST_CARDACCNO,tCard.accno);
			else 
				return E_DB_ACCOUNT_R;
		}
		
		T_t_customer  customer;
		memset(&customer,0,sizeof(customer));
		if(tCard.custid)
		{
			ret=DB_t_customer_read_by_custid(tCard.custid,&customer);
			if(ret)
			{
				if(DB_NOTFOUND==ret)
					return ERRINFO(E_NOTEXIST_CUSTOMER,tCard.custid);
				else
					return E_DB_CUSTOMER_R;
			}
			des2src(trans.stuempno,customer.stuempno);
			des2src(trans.custname,customer.custname);
			trans.custid=customer.custid;
		}
		char cardpwd[33]="";
		char key[17]="";
		strcpy(key,STATIC_SEED_KEY);
		EncodePwd(key,cardpwd,tCard.cardpwd, 1);
		T_t_cardinsteaddtl cardinsteaddtl;
		memset(&cardinsteaddtl,0,sizeof(cardinsteaddtl));
		ret=DB_t_cardinsteaddtl_read_lock_by_c0_and_cardno(trans.cardno,&cardinsteaddtl);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return E_DB_CARDINSTEADDTL_N;
			else
				return E_DB_CARDINSTEADDTL_R;
		}
		//核对登记信息与卡表是否一致
		if(strcmp(cardinsteaddtl.oldcardphyid,tCard.cardphyid)!=0)
		{
			DB_t_cardinsteaddtl_free_lock_by_c0();
			strcpy(szMsg,"保存的卡信息与原卡物理ID不一致");
			return E_CARD_PHYNO_DIFFER;
		}
		//核对原物理ID是否一致
		if(strcmp(cardinsteaddtl.oldcardphyid,rPack->scust_no)!=0)
		{
			DB_t_cardinsteaddtl_free_lock_by_c0();
			return E_CARD_PHYNO_DIFFER;
		}
		if(cardinsteaddtl.revflag[0]=='1')
		{
			DB_t_cardinsteaddtl_free_lock_by_c0();
			return E_CARDINSTEAD_CANCEL;
		}
		if(cardinsteaddtl.status[0]=='2')
		{
			DB_t_cardinsteaddtl_free_lock_by_c0();
			if(strcmp(cardinsteaddtl.cardphyid,trans.cardphyid)!=0)
			{
				return ERRINFO(E_CARD_PHYNO_DIFFER,trans.cardphyid,cardinsteaddtl.cardphyid);
			}			
			outPack->lvol1=tCard.custid;
			outPack->lsafe_level2=customer.custtype;
			outPack->lvol5=tCard.feetype;
			des2src(outPack->sall_name,customer.custname);
			des2src(outPack->spager,customer.stuempno);
			des2src(outPack->scert_no,customer.deptcode);
			des2src(outPack->semail2,customer.idno);
			des2src(outPack->smarket_code,customer.sex);
			des2src(outPack->sdate0,tCard.expiredate);
			outPack->lvol0=tCard.cardno;
			outPack->lvol8=(int)(cardinsteaddtl.oldcardbal*100);
			outPack->lvol11=D4U5(tCardAccount.singlemaxamt*100,0);
			outPack->lvol12=D4U5(tCardAccount.daycostmaxamt*100,0);
			outPack->lvol6=cardinsteaddtl.oldcardcnt;
			outPack->lvol4=cardinsteaddtl.oldsubsidyno;
			des2src(outPack->sorder0,tCard.showcardno);
			des2src(outPack->sdate3,pAccTrans->trans.accdate);
			des2src(outPack->stx_pwd,cardpwd);			
			outPack->lwithdraw_flag=trans.termid;
			outPack->lserial1=trans.termseqno;
			PutRow(handle,outPack,pRetCode,szMsg);		
			return 0;
		}
		cardinsteaddtl.status[0]=STATUS_DELETE;
		des2src(cardinsteaddtl.cardphyid,trans.cardphyid);
		des2src(cardinsteaddtl.showcardno,trans.showcardno);
		ret=DB_t_cardinsteaddtl_update_lock_by_c0(&cardinsteaddtl);
		if(ret)
		{
			return E_DB_CARDINSTEADDTL_U;
		}
		T_t_newcardchange newcardchange;
		memset(&newcardchange,0,sizeof(newcardchange));

		ret=DB_t_newcardchange_read_lock_by_c1_and_showcardno(cardinsteaddtl.showcardno,&newcardchange);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return E_DB_NEWCARDCHANGE_N;
			else
				return E_DB_NEWCARDCHANGE_R;
		}
		newcardchange.status= NEWCARDSTATUS_SUCCESS;
		des2src(newcardchange.oldcardphyid,cardinsteaddtl.oldcardphyid);
		des2src(newcardchange.cardphyid,cardinsteaddtl.cardphyid);
		des2src(newcardchange.lastsaved,CAccTrans::getInstance()->trans.sysdatetime);
		ret=DB_t_newcardchange_update_lock_by_c1(&newcardchange);
		if(ret)
		{
				return E_DB_NEWCARDCHANGE_U;
		}
		//检查新卡物理id
		T_t_card cardtmp;
		memset(&cardtmp,0,sizeof(cardtmp));
		ret=DB_t_card_read_by_cardphyid_and_status(trans.cardphyid,"1",&cardtmp);
		if(ret!=DB_NOTFOUND)
		{
			if(DB_SUCCESS==ret)
				return ERRINFO(E_EXIST_CARDPHYID,trans.cardphyid);
			else
				return E_DB_CARD_R;
		}
		T_t_cardver cardver;
		
		memset(&cardver,0,sizeof(cardver));
		cardver.cardno=trans.cardno;
		des2src(cardver.accdate,pAccTrans->trans.accdate);
		cardver.termid=trans.termid;
		cardver.termseqno=trans.termseqno;
		cardver.status[0]=STATUS_NORMAL;	
		des2src(cardver.cardphyid,cardinsteaddtl.cardphyid);
		des2src(cardver.stuempno,trans.stuempno);
		cardver.cardvertype=CARDVERTYPE_CARDINSTEADNEW;
		ret=getCardVerNo(cardver.cardverno);
		if(ret)
			return ret;
		ret=DB_t_cardver_add(&cardver);
		if(ret)
		{
			if(DB_REPEAT==ret)
				return E_DB_CARDVER_E;
			else
				return E_DB_CARDVER_I;
		}
		//更新卡信息
		des2src(tCard.cardphyid,trans.cardphyid);
		des2src(tCard.showcardno,trans.showcardno);
		des2src(tCard.cardverno,cardver.cardverno);
		des2src(tCard.expiredate,newcardchange.expiredate);
		des2src(tCard.lastsaved,trans.sysdatetime);
		ret=DB_t_card_update_by_cardno(tCard.cardno,&tCard);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return E_NOTEXIST_CARDNO;
			else 
				return E_DB_CARD_U;
		}
		if(tCard.custid)
		{
			char sql[512]={0};
			sprintf(sql,"update ykt_cur.t_customer set outdate='%s' where custid=%d",tCard.expiredate,tCard.custid);
			ret=DynamicStmtExecute(sql);
			if(ret)
			{
				writelog(LOG_ERR,"update customer outdate err ret=%d",ret);
				return ret;
			}
		}
		T_t_transdtl transdtl;
		memset(&transdtl,0,sizeof(transdtl));
		
		des2src(transdtl.transdate,trans.transdate);
		des2src(transdtl.transtime,trans.transtime);
		strcpy(transdtl.accdate,trans.accdate);
		strcpy(transdtl.acctime,trans.acctime);
		transdtl.termid=trans.termid;
		transdtl.termseqno=trans.termseqno;
		transdtl.transcode=trans.transcode;
		transdtl.paytype=trans.fundtype;
		des2src(transdtl.voucherno,trans.voucherno);
		transdtl.cardno=trans.cardno;
		transdtl.purseno=trans.purseno;
		transdtl.cardcnt=cardinsteaddtl.oldcardcnt;
		transdtl.cardbefbal=cardinsteaddtl.oldcardbal;
		transdtl.cardaftbal=cardinsteaddtl.oldcardbal; 	

		transdtl.managefee=trans.totalfeeamt;
		transdtl.amount=trans.totaltransamt;
		transdtl.custid=tCard.custid;
		des2src(transdtl.custname,customer.custname);
		des2src(transdtl.stuempno,customer.stuempno);
		des2src(transdtl.opercode,trans.opercode);
		transdtl.status[0]=DTLSTATUS_SUCCESS;
		des2src(transdtl.showcardno,tCard.showcardno);		
		ret=DB_t_transdtl_add(&transdtl);
		if(ret)
		{
			if(DB_REPEAT==ret)
				return E_DB_TRANSDTL_E;
			else
				return E_DB_TRANSDTL_I;
		} 		
		outPack->lvol1=tCard.custid;
		outPack->lsafe_level2=customer.custtype;
		outPack->lvol5=tCard.feetype;
		des2src(outPack->sall_name,customer.custname);
		des2src(outPack->spager,customer.stuempno);
		des2src(outPack->scert_no,customer.deptcode);
		des2src(outPack->semail2,customer.idno);
		des2src(outPack->smarket_code,customer.sex);
		des2src(outPack->sdate0,tCard.expiredate);
		outPack->lvol0=tCard.cardno;
		outPack->lvol4=cardinsteaddtl.oldsubsidyno;
		outPack->lvol8=(int)(cardinsteaddtl.oldcardbal*100);
		outPack->lvol11=D4U5(tCardAccount.singlemaxamt*100,0);
		outPack->lvol12=D4U5(tCardAccount.daycostmaxamt*100,0);
		outPack->lvol6=cardinsteaddtl.oldcardcnt;
		des2src(outPack->sorder0,tCard.showcardno);
		des2src(outPack->stx_pwd,cardpwd);			
		des2src(outPack->sdate3,pAccTrans->trans.accdate);
		outPack->lwithdraw_flag=trans.termid;
		outPack->lserial1=trans.termseqno;
		PutRow(handle,outPack,pRetCode,szMsg); 		
		return 0;
}
//取消换卡
static int DoCardInsteadCancel(TRUSERID *handle,ST_PACK *rPack,int *pRetCode,char *szMsg)
{
		int ret=0;
		CAccTrans *pAccTrans=CAccTrans::getInstance();
		TRANS& trans=pAccTrans->trans;
		ST_CPACK aPack;
		ST_PACK *outPack = &(aPack.pack); 
		
		ResetNormalCPack(&aPack,0,1);

			
		SetCol(handle,0);
		
		SetCol(handle,F_LVOL1,F_LSAFE_LEVEL2,F_LVOL4,F_LVOL5,
					F_SALL_NAME,F_SPAGER,F_SCERT_NO,
					F_SEMAIL2,F_SMARKET_CODE,F_SDATE0,
					F_LVOL0,F_STX_PWD,F_LVOL8,F_LVOL6,
					F_SORDER0,F_LWITHDRAW_FLAG,F_SDATE3,F_LVOL11,F_LVOL12,
					F_LWITHDRAW_FLAG,F_LSERIAL1,F_VSMESS,0);	
		
		T_t_card  tCard;
		memset(&tCard,0,sizeof(tCard));
		ret=DB_t_card_read_by_cardno(trans.cardno,&tCard);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return ERRINFO(E_NOTEXIST_CARDNO,trans.cardno);
			else 
				return E_DB_CARD_R;
		}
		if(tCard.status[0]!=STATUS_NORMAL)
		{
			return ERRINFO(E_CARD_LOGOUT,trans.cardno);
		}	
		if('1'==tCard.frozeflag[0])
		{
			return ERRINFO(E_CARD_FREEZE,trans.cardno);
		}
		if('1'==tCard.lossflag[0])
		{
			return ERRINFO(E_CARD_LOST,trans.cardno);
		}	
		if('1'==tCard.badflag[0])
		{
			return ERRINFO(E_CARD_BADRECORD,trans.cardno);
		}	
		T_t_account tCardAccount;	
		memset(&tCardAccount,0,sizeof(tCardAccount));
		ret=DB_t_account_read_by_accno(tCard.accno,&tCardAccount);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return ERRINFO(E_NOTEXIST_CARDACCNO,tCard.accno);
			else 
				return E_DB_ACCOUNT_R;
		}
		
		T_t_customer  customer;
		memset(&customer,0,sizeof(customer));
		if(tCard.custid)
		{
			ret=DB_t_customer_read_by_custid(tCard.custid,&customer);
			if(ret)
			{
				if(DB_NOTFOUND==ret)
					return ERRINFO(E_NOTEXIST_CUSTOMER,tCard.custid);
				else
					return E_DB_CUSTOMER_R;
			}
		}
		char cardpwd[33]="";
		char key[17]="";
		strcpy(key,STATIC_SEED_KEY);
		EncodePwd(key,cardpwd,tCard.cardpwd, 1);
		T_t_cardinsteaddtl cardinsteaddtl;

		memset(&cardinsteaddtl,0,sizeof(cardinsteaddtl));
		ret=DB_t_cardinsteaddtl_read_lock_by_c0_and_cardno(trans.cardno,&cardinsteaddtl);
		if(ret)
		{
			if(DB_NOTFOUND==ret)
				return E_DB_CARDINSTEADDTL_N;
			else
				return E_DB_CARDINSTEADDTL_R;
		}
		if(cardinsteaddtl.status[0]==STATUS_NORMAL)
		{
			T_t_transdtl transdtl;
			memset(&transdtl,0,sizeof(transdtl));
			
			des2src(transdtl.transdate,trans.transdate);
			des2src(transdtl.transtime,trans.transtime);
			des2src(transdtl.accdate,pAccTrans->trans.accdate);
			des2src(transdtl.acctime,trans.acctime);
			transdtl.termid=trans.termid;
			transdtl.termseqno=trans.termseqno;
			transdtl.transcode=trans.transcode;
			transdtl.paytype=trans.fundtype;
			des2src(transdtl.voucherno,trans.voucherno);
			transdtl.cardno=trans.cardno;
			transdtl.purseno=trans.purseno;
			transdtl.cardcnt=cardinsteaddtl.oldcardcnt;
			transdtl.cardbefbal=cardinsteaddtl.oldcardbal;
			transdtl.cardaftbal=transdtl.cardbefbal;	

			transdtl.managefee=trans.totalfeeamt;
			transdtl.amount=trans.totaltransamt;
			transdtl.custid=tCard.custid;
			des2src(transdtl.custname,customer.custname);
			des2src(transdtl.stuempno,customer.stuempno);
			des2src(transdtl.opercode,trans.opercode);
			transdtl.status[0]=DTLSTATUS_SUCCESS;
			des2src(transdtl.showcardno,cardinsteaddtl.oldshowcardno);
			ret=DB_t_transdtl_add(&transdtl);
			if(ret)
			{
				if(DB_REPEAT==ret)
					return E_DB_TRANSDTL_E;
				else
					return E_DB_TRANSDTL_I;
			} 
			outPack->lvol1=tCard.custid;
			outPack->lsafe_level2=customer.custtype;
			outPack->lvol5=tCard.feetype;
			des2src(outPack->sall_name,customer.custname);
			des2src(outPack->spager,customer.stuempno);
			des2src(outPack->scert_no,customer.deptcode);
			des2src(outPack->semail2,customer.idno);
			des2src(outPack->smarket_code,customer.sex);
			des2src(outPack->sdate0,tCard.expiredate);
			outPack->lvol0=tCard.cardno;
			outPack->lvol8=(int)(cardinsteaddtl.oldcardbal*100);
			outPack->lvol4=cardinsteaddtl.oldsubsidyno;
			outPack->lvol11=D4U5(tCardAccount.singlemaxamt*100,0);
			outPack->lvol12=D4U5(tCardAccount.daycostmaxamt*100,0);
			outPack->lvol6=cardinsteaddtl.oldcardcnt;
			des2src(outPack->sorder0,tCard.showcardno);
			des2src(outPack->sdate3,pAccTrans->trans.accdate);
			outPack->lwithdraw_flag=trans.termid;
			outPack->lserial1=trans.termseqno;			
			des2src(outPack->stx_pwd,cardpwd);
			PutRow(handle,outPack,pRetCode,szMsg);		
			return 0;
		}
		if(cardinsteaddtl.revflag[0]=='1')
		{
				return E_CARDINSTEAD_CANCEL;
		}
		T_t_card cardtmp;
		memset(&cardtmp,0,sizeof(cardtmp));
		ret=DB_t_card_read_by_cardphyid_and_status(trans.cardphyid,"1",&cardtmp);
		if(ret!=DB_NOTFOUND)
		{
			if(DB_SUCCESS==ret)
				return ERRINFO(E_EXIST_CARDPHYID,trans.cardphyid);
			else
					return E_DB_CARD_R;
		}
		if(pAccTrans->sysPara.bEnableCardMgr)
		{
			ret=DB_t_card_read_by_showcardno_and_status(trans.showcardno,"1",&tCard);
			if(ret!=DB_NOTFOUND)
			{
				if(DB_SUCCESS==ret)
						return ERRINFO(E_EXIST_SHOWCARDNO,trans.showcardno);
				else
						return E_DB_CARD_R;
			} 
			//回收卡
			ret=UseShowCardNoBack(trans.opercode,cardinsteaddtl.showcardno);
			if(ret)
			{
				return ret;
			}
			T_t_carddtl carddtl;
			memset(&carddtl,0,sizeof(carddtl));
			
			des2src(carddtl.accdate,pAccTrans->trans.accdate);
			des2src(carddtl.acctime,trans.acctime);
			carddtl.termid=trans.termid;
			carddtl.termseqno=trans.termseqno;
			des2src(carddtl.opercode,trans.opercode);
			carddtl.cardtype=trans.cardtype;
			carddtl.usetype=CARDUSETYPE_REUSE;
			carddtl.inoutflag=INOUTFLAG_IN;
			carddtl.transcnt=1;
			strcpy(carddtl.summary,"换卡撤销(新卡回收)");
			des2src(carddtl.cardphyid,cardinsteaddtl.cardphyid);
			des2src(carddtl.showcardno,cardinsteaddtl.showcardno);
			
			ret=DB_t_carddtl_add(&carddtl);
			if(ret)
			{
				if(DB_REPEAT==ret)
					return E_DB_CARDDTL_E;
				else
					return E_DB_CARDDTL_I;
			}
			//使用原卡
			int cardtype=0;
			ret=UseShowCardNo(trans.opercode,cardinsteaddtl.oldshowcardno,cardtype);
			if(ret)
			{
				return ret;
			}
			memset(&carddtl,0,sizeof(carddtl));
			
			des2src(carddtl.accdate,pAccTrans->trans.accdate);
			des2src(carddtl.acctime,trans.acctime);
			carddtl.termid=trans.termid;
			carddtl.termseqno=trans.termseqno;
			des2src(carddtl.opercode,trans.opercode);
			carddtl.cardtype=cardinsteaddtl.oldcardtype;
			carddtl.usetype=CARDUSETYPE_USE;
			carddtl.inoutflag=INOUTFLAG_OUT;
			carddtl.transcnt=1;
			strcpy(carddtl.summary,"换卡撤销(重发原卡)"); 
			des2src(carddtl.cardphyid,cardinsteaddtl.oldcardphyid);
			des2src(carddtl.showcardno,cardinsteaddtl.oldshowcardno);
			ret=DB_t_carddtl_add(&carddtl);
			if(ret)
			{
				if(DB_REPEAT==ret)
					return E_DB_CARDDTL_E;
				else
					return E_DB_CARDDTL_I;
			}
		}
		//更新卡信息
		memset(&tCard,0,sizeof(tCard));
		ret=DB_t_card_read_lock_by_cur_and_cardno(trans.cardno,&tCard);
		if(ret)
		{
				if(DB_NOTFOUND==ret)
					return E_NOTEXIST_CARDNO;
				else 
					return E_DB_CARD_R;
		}
		if(tCard.status[0]!=STATUS_NORMAL)
		{
			  DB_t_card_free_lock_by_cur();
				return E_CARD_LOGOUT;
		}
		tCard.cardtype=cardinsteaddtl.oldcardtype;
		des2src(tCard.cardphyid,cardinsteaddtl.oldcardphyid);
		des2src(tCard.showcardno,cardinsteaddtl.oldshowcardno);
		ret=DB_t_card_update_lock_by_cur(&tCard);
		if(ret)
		{
				if(DB_NOTFOUND==ret)
					return E_NOTEXIST_CARDNO;
				else 
					return E_DB_CARD_U;
		}
		T_t_transdtl transdtl;
		memset(&transdtl,0,sizeof(transdtl));
		
		des2src(transdtl.transdate,trans.transdate);
		des2src(transdtl.transtime,trans.transtime);
		strcpy(transdtl.accdate,trans.accdate);
		strcpy(transdtl.acctime,trans.acctime);
		transdtl.termid=trans.termid;
		transdtl.termseqno=trans.termseqno;
		transdtl.transcode=trans.transcode;
		transdtl.paytype=trans.fundtype;
		des2src(transdtl.voucherno,trans.voucherno);
		transdtl.cardno=trans.cardno;
		transdtl.purseno=trans.purseno;
		transdtl.cardcnt=cardinsteaddtl.oldcardcnt;
		transdtl.cardbefbal=cardinsteaddtl.oldcardbal;
		transdtl.cardaftbal=transdtl.cardbefbal;	

		transdtl.managefee=trans.totalfeeamt;
		transdtl.amount=trans.totaltransamt;
		transdtl.custid=tCard.custid;
		des2src(transdtl.custname,customer.custname);
		des2src(transdtl.stuempno,customer.stuempno);
		des2src(transdtl.opercode,trans.opercode);
		transdtl.status[0]=DTLSTATUS_SUCCESS;
		des2src(transdtl.showcardno,cardinsteaddtl.oldshowcardno);
		ret=DB_t_transdtl_add(&transdtl);
		if(ret)
		{
			if(DB_REPEAT==ret)
				return E_DB_TRANSDTL_E;
			else
				return E_DB_TRANSDTL_I;
		} 
		outPack->lvol1=tCard.custid;
		outPack->lsafe_level2=customer.custtype;
		outPack->lvol5=trans.feetype;
		des2src(outPack->sall_name,customer.custname);
		des2src(outPack->spager,customer.stuempno);
		des2src(outPack->scert_no,customer.deptcode);
		des2src(outPack->semail2,customer.idno);
		des2src(outPack->smarket_code,customer.sex);
		des2src(outPack->sdate0,tCard.expiredate);
		outPack->lvol0=tCard.cardno;
		outPack->lvol4=cardinsteaddtl.oldsubsidyno;
		outPack->lvol8=(int)(cardinsteaddtl.oldcardbal*100);
		outPack->lvol11=D4U5(tCardAccount.singlemaxamt*100,0);
		outPack->lvol12=D4U5(tCardAccount.daycostmaxamt*100,0);
		outPack->lvol6=cardinsteaddtl.oldcardcnt;
		des2src(outPack->sorder0,tCard.showcardno);
		des2src(outPack->sdate3,pAccTrans->trans.accdate);
		des2src(outPack->stx_pwd,cardpwd);
		outPack->lwithdraw_flag=trans.termid;
		outPack->lserial1=trans.termseqno;
		PutRow(handle,outPack,pRetCode,szMsg); 		
		return 0;
}


int F846327(TRUSERID *handle,int iRequest,ST_PACK *rPack,int *pRetCode,char *szMsg)
{
	int ret=0;
	CAccTrans *pAccTrans=CAccTrans::getInstance();
	ret=pAccTrans->CheckCfgUpdate();
	if(ret)
		return ret;
	pAccTrans->trans.termid=rPack->lcert_code;
	//des2src(pAccTrans->trans.opercode,rPack->semp);
	TRANS& trans=pAccTrans->trans;
	switch(rPack->sstatus0[0])
	{
		case 'S':
			trans.transcode=TC_CARDSAVEINFO;
			ret=pAccTrans->InitTrans();
			if(ret)
				return ret; 		
			trans.cardflag=1;
			trans.usecardflag=1;	
			trans.cardno=rPack->lvol0;	
			trans.purseno=PURSE_NO_ONE;
			trans.cardsubsidyno=rPack->lvol4;
			trans.dpscnt=rPack->lvol5;
			trans.paycnt=rPack->lvol6;
			trans.cardbefbal=rPack->lvol7/100.0;
			des2src(trans.cardphyid,rPack->scust_no);  	//旧物理卡号
			des2src(trans.showcardno,rPack->sorder0);	//新显示卡号
			ret=SaveOldCardInfo(handle,rPack,pRetCode,szMsg);
			break;
		case 'C':
			trans.transcode=TC_CARDINSTEAD;
			ret=pAccTrans->InitTrans();
			if(ret)
				return ret; 
			trans.cardflag=1;
			trans.usecardflag=1;	
			trans.cardno=rPack->lvol0;	
			trans.purseno=PURSE_NO_ONE;
			trans.cardsubsidyno=rPack->lvol4;
			trans.dpscnt=rPack->lvol5;
			trans.paycnt=rPack->lvol6;
			trans.cardbefbal=rPack->lvol7/100.0;
			des2src(trans.cardphyid,rPack->scust_no2);
			des2src(trans.showcardno,rPack->sorder0);
			ret=DoCardInstead(handle,rPack,pRetCode,szMsg);
			break;
		case 'D':
			trans.transcode=TC_CARDINSTEADREV;
			ret=pAccTrans->InitTrans();
			if(ret)
				return ret; 		
			trans.cardflag=1;
			trans.usecardflag=1;	
			trans.cardno=rPack->lvol0;	
			trans.purseno=PURSE_NO_ONE;
			trans.cardsubsidyno=rPack->lvol4;
			trans.dpscnt=rPack->lvol5;
			trans.paycnt=rPack->lvol6;
			trans.cardbefbal=rPack->lvol7/100.0;
			des2src(trans.cardphyid,rPack->scust_no2);			
			ret=DoCardInsteadCancel(handle,rPack,pRetCode,szMsg);	
			break;
		default:
			return -1;
	}
	if(ret)
		return ret;
	return 0;
}
