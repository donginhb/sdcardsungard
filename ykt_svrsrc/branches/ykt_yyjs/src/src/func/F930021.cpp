/* --------------------------------------------
 * 程序名称: F930021.sqc
 * 创建日期: 9 17 2004
 * 程序作者: 杜叶飞
 * 版本信息: 1.0.0.0
 * 程序功能: 下传设备档案信息
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
#include "fdsqc.h"

int F930021(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg)
{
	int ret = 0;
	int cnt=0;
	int mesid=0;
     	T_t_tif_meslist tMesList;
	T_t_pif_device	tDevice;
	T_t_pif_device tPDev;

	ST_CPACK aPack;
	ST_PACK *out_pack = &(aPack.pack);

	ResetNormalCPack(&aPack,0,1);
	SetCol(handle,0);
	SetCol(handle,F_VSVARSTR0,0);
	memset(&tMesList,0,sizeof(tMesList));
	memset(&tDevice,0,sizeof(tDevice));
	memset(&tPDev,0,sizeof tPDev);


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

	if((ret = DB_t_pif_device_read_by_device_id(tDevice.fdev_id,&tPDev)))
	{
		*pRetCode = ret;
		goto L_RETU;
	}
	AddXmlItemStr(tMesList.incontent,XML_KEY_DEV999_ID, tDevice.dev999_id);
	AddXmlItemInt(tMesList.incontent,XML_KEY_DEV999_NO,  tDevice.dev999_no);
	AddXmlItemStr(tMesList.incontent,XML_KEY_DEVTYPE,tDevice.devtype);
	AddXmlItemStr(tMesList.incontent,XML_KEY_DEVVERSION, tDevice.devversion);
	AddXmlItemStr(tMesList.incontent,XML_KEY_CARDSTR, tDevice.cardstr);
	AddXmlItemStr(tMesList.incontent,XML_KEY_VCARDSET, tDevice.cardtype);
	AddXmlItemInt(tMesList.incontent, XML_KEY_PORTCOUNT, tDevice.portcount);
	AddXmlItemStr(tMesList.incontent, XML_KEY_FDEVPHY_ID, tPDev.dev999_id);
	AddXmlItemInt(tMesList.incontent, XML_KEY_PORTNO,tDevice.portno);
	AddXmlItemInt(tMesList.incontent, XML_KEY_STATE_ID, tDevice.state_id);
	AddXmlItemInt(tMesList.incontent,XML_KEY_JOINMODE,tDevice.joinmode);
	AddXmlItemStr(tMesList.incontent, XML_KEY_COMADD, tDevice.comadd);
	AddXmlItemStr(tMesList.incontent, XML_KEY_PORT,  tDevice.port);
	AddXmlItemInt(tMesList.incontent, XML_KEY_BAUDRATE, tDevice.baudrate);
	AddXmlItemInt(tMesList.incontent, XML_KEY_COMTYPE,tDevice.comtype);
	AddXmlItemStr(tMesList.incontent, XML_KEY_NOTVALIDITY, tDevice.bsheetvdate);
	AddXmlItemStr(tMesList.incontent, XML_KEY_VERNUM,tDevice.bsheetver);
	AddXmlItemInt(tMesList.incontent, XML_KEY_LASTTRASERNO, tDevice.lasttraserno);
	AddXmlItemStr(tMesList.incontent, XML_KEY_LASTTRADATE, tDevice.lasttradate);
	AddXmlItemInt(tMesList.incontent, XML_KEY_LASTSHUTSERNO, tDevice.lastshutserno);
	AddXmlItemStr(tMesList.incontent, XML_KEY_LASTSHUTDATE, tDevice.lastshutdate);
	tMesList.devid = tDevice.device_id;
	tMesList.funid = 930021;
	tMesList.level = 3;
	ret=AddMsgLst(&tMesList);
	if(ret)
	{
		*pRetCode=ret;
		writelog(LOG_ERR,"AddMsgLst err[%d]",ret);
		goto L_RETU;
	}
	if(iRequest!=tMesList.funid)
		return 0;	
	ret=db_commit();
	if(ret)
	{
		writelog(LOG_ERR,"db_commit ret[%d]",ret);
		*pRetCode=E_DB_COMMIT;
		goto  L_RETU;
	}
	mesid=tMesList.mesid;
	des2src(out_pack->sdate0,in_pack->sdate0);
	for(cnt=0;(cnt<10)&&(tMesList.ecode!=0);cnt++)
	{
		sleep(1);
		memset(&tMesList,0,sizeof(tMesList));
		ret=DB_t_tif_meslist_read_by_mesid(mesid, &tMesList);
		if(ret)
		{
			writelog(LOG_ERR,"DB_t_tif_meslist_read_by_mesid err[%d]",ret);
			*pRetCode=E_DB_MESLIST_R;
			goto L_RETU;
		}
	}
	switch(tMesList.ecode)
	{
		case 0:		//成功
			des2src(out_pack->vsvarstr0,"成功");
			break;
		case 9999:		//交易未处理
			des2src(out_pack->vsvarstr0,"前置机无应答");
			break;
		default:			//交易已经处理,但结果是失败
			des2src(out_pack->vsvarstr0,tMesList.emsg);				
			break;
	}	
	PutRow(handle,out_pack,pRetCode,szMsg);
	return 0;
L_RETU:
	return  -1;	
}





