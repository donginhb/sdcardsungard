/* --------------------------------------------
 * 程序名称: F930203.sqc
 * 创建日期: 2007-04-23
 * 程序作者: 汤成
 * 版本信息: 1.0.0.0
 * 程序功能: 采集门禁流水与事件
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
#include "dbfunc_foo.h"

static int ConverPhyNo(char *physical_no_hex, char *physical_no_dec)
{
	char tmp[8+1] = "";
	int i = 0;
	char a1[3] = "";
	char a2[3] = "";
	char a3[3] = "";
	char a4[3] = "";

	memcpy(a1, physical_no_hex, 2);
	memcpy(a2, physical_no_hex + 2, 2);
	memcpy(a3, physical_no_hex + 4, 2);
	memcpy(a4, physical_no_hex + 6, 2);

	sprintf(tmp, "%s%s%s%s", a4, a3, a2, a1);
	sscanf(tmp, "%8X", &i);
	sprintf(physical_no_dec, "%d", i);
	return 0;
}


int F930203(TRUSERID *handle, int iRequest, ST_PACK *in_pack, int *pRetCode, char *szMsg)
{
	T_t_door_txdtl txdtl;
	T_t_pif_card tCard;
	T_t_pif_device device;
	T_t_door_events event;
	int ret;
	char weigand_no[12+1] = "";
	memset(&device, 0, sizeof device);
	// 查询设备ID号
	if (in_pack->lvol5 > 0)
	{
		ret = DB_t_pif_device_read_by_device_id(in_pack->lvol5, &device);
	}
	else
	{
		// 先判断是不是有父设备ID
		if (in_pack->lvol2 > 0)
			ret = get_door_dev_by_parent_and_termid(&device, in_pack->lvol2
			                                        , in_pack->lvol1); // 通过机号查询
		else
		{
			// 判断父设备机号
			if (in_pack->lvol3 > 0)
				ret = find_device_by_parent_termid(&device, in_pack->lvol3, in_pack->lvol1
				                                   , in_pack->lserial0); // 通过父设备机号与设备机号查询
			else
			{
				// 通过子系统号与设备机号查询
				ret = find_device_by_devinfo(&device, in_pack->lcert_code, in_pack->lvol1
				                             , in_pack->sbank_code, in_pack->lserial0);
			}
		}
	}
	if (ret)
	{
		writelog(LOG_ERR, "get_door_dev_by_parent_and_termid err,device[=%d]parent_id=[%d],dev_no=[%d],ret=[%d]",
		         in_pack->lvol5, in_pack->lvol2, in_pack->lvol1, ret);
		if (ret == E_DB_DEVICE_N)
		{
			writelog(LOG_ERR, "上传记录找不到对应的设备termid[%d]type[%s]parent[%d][%d],sys[%d],phytype[%d]"
			         , in_pack->lvol1, in_pack->sbank_code, in_pack->lvol2, in_pack->lvol3, in_pack->lcert_code, in_pack->lserial0);
			return 0;
		}
		else
		{
			*pRetCode = ret;
			goto L_RETU;
		}
	}
	// 没有物理卡号
	if (strlen(in_pack->sdate1) == 0)
	{
		//事件
		memset(&event, 0, sizeof event);
		event.device_id = device.device_id;
		event.event_code = atoi(in_pack->semp_no);
		des2src(event.event_msg, in_pack->vsmess);
		event.sysid = in_pack->lcert_code;
		des2src(event.tx_date, in_pack->sdate0);
		des2src(event.tx_time, in_pack->stime0);
		getsysdate(event.col_date);
		getsystime(event.col_time);
		ret = DB_t_door_events_add(&event);
		if (ret)
		{
			if (DB_REPEAT == ret)	return 0;
			*pRetCode = E_DB_DOOR_TXDTL_I;
			goto L_RETU;
		}
		return 0;

	}
	else
	{
		memset(&tCard, 0, sizeof tCard);
		ret = get_card_by_phyno(&tCard, in_pack->sdate1);
		if (ret)
		{
			if (ret == E_DB_CARD_N)
			{
				ConverPhyNo(in_pack->sdate1, weigand_no);
				ret = get_card_by_weigand_no(&tCard, weigand_no);
				if (ret)
				{
					writelog(LOG_ERR, "Get_card_by_weigand_no err,weigand_no=[%s],ret=[%d]", weigand_no, ret);
					// 没有这张卡,仍然保留流水
					if (ret != E_DB_CARD_N)
					{
					    // 可能是 weigand 26 卡，无法唯一确认一张卡。
						return 0;
					};
				}
			}
			else
			{
				*pRetCode = ret;
				goto L_RETU;
			}
		}
		memset(&txdtl, 0, sizeof txdtl);
		txdtl.device_id = device.device_id;
		txdtl.card_no = tCard.card_id;
		txdtl.sys_id = in_pack->lcert_code;
		txdtl.cust_id = tCard.cosumer_id;
		if (!ret)	des2src(txdtl.phycard_no, tCard.physical_no);
		else des2src(txdtl.phycard_no, in_pack->sdate1);
		//writelog(LOG_DEBUG,"door serial date[%s] time[%s]",in_pack->sdate0,in_pack->stime0);
		des2src(txdtl.tx_date, in_pack->sdate0);
		des2src(txdtl.tx_time, in_pack->stime0);
		getsysdate(txdtl.col_date);
		getsystime(txdtl.col_time);
		txdtl.tx_mark = atoi(in_pack->semp_no);
		// 保存门禁流水
		ret = DB_t_door_txdtl_add(&txdtl);
		if (ret)
		{
			// 重复流水忽略
			if (DB_REPEAT == ret)
			{
				writelog(LOG_DEBUG, "流水重复card[%s],date[%s],time[%s]", in_pack->sdate1
				         , in_pack->sdate0, in_pack->stime0);
				return 0;
			}
			writelog(LOG_ERR, "保存流水失败card[%s],date[%s],time[%s]", in_pack->sdate1
			         , in_pack->sdate0, in_pack->stime0);
			*pRetCode = E_DB_DOOR_TXDTL_I;
			goto L_RETU;
		}
		switch (device.dev_usage)
		{
		case DU_JSB_CONFRENCE:
			/*
			ret = SaveDoorJSBSerial(&txdtl);
			if(ret)
			{
				writelog(LOG_ERR,"保存计时宝流水失败,errcode[%d]",ret);
				break;
			}
			ret = UpdateConferSerial(&txdtl);
			*/
			break;
		case DU_JSB_ATTENDANCE:
			ret = SaveKQSerial(&txdtl);
			if (ret)
			{
				writelog(LOG_ERR, "插入考勤流水表失败,errcode[%d]", ret);
				break;
			}
		default:
			//ret = SaveDoorJSBSerial(&txdtl);
			break;
		}
		if (ret)
		{
			*pRetCode = ret;
			goto L_RETU;
		}
	}
	return 0;

L_RETU:
	return -1;

}

