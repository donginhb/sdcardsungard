/* --------------------------------------------
 * 程序名称: F848006.c
 * 创建日期: 2005-09-12
 * 程序作者: 闻剑
 * 版本信息: 1.0.0.0
 * 程序功能:门禁人员分配
 * --------------------------------------------
 * 修改日期:
 * 修改人员:
 * 修改描述:
 * 版本信息:
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

int F930117(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg);

static int check_device(char* deviceid) {
    int ret=0;
    T_t_device tDevice;

    memset(&tDevice,0,sizeof(tDevice));


    if(strlen(deviceid)<8) {
        return E_NOTEXIST_DEVICE;
    }
    ret=get_devinfo_by_phyid(deviceid,&tDevice);
    if(ret) {
        writelog(LOG_ERR,"deviceid[%s]ret[%d]",deviceid,ret);
        return ret;
    }
    if(strcmp(tDevice.devtype,DEVITYPE_JSB)) {
        return E_DEVTYPE_NOT_JSP;
    }
    return 0;
}
int check_cardno(int cardno) {
    int ret=0;
    T_t_card  tCard;

    memset(&tCard,0,sizeof(tCard));

    if(cardno<1) {
        return E_INPUT_CARDNO_CANNOT_NULL;
    }
    ret=DB_t_card_read_by_cardno(cardno, &tCard);
    if(ret) {
        writelog(LOG_ERR,"cardno[%s]ret[%d]",cardno,ret);
        if(DB_NOTFOUND==ret)
            return E_NOTEXIST_CARDNO;
        else
            return E_DB_CARD_R;
    }
    if(strncmp(tCard.cardstatus,CARDSTAT_REG,4)!=0) {
        if('2'==tCard.cardstatus[CARDSTAT_TYPE_REG])
            return  E_CARD_CLOSE;
        else if(tCard.cardstatus[CARDSTAT_TYPE_LOST]==STATE_TRUE)
            return E_CARD_LOST;
        else if(tCard.cardstatus[CARDSTAT_TYPE_FREEZE]==STATE_TRUE)
            return E_CARD_FREEZE;
    }
    return 0;
}

int F848006(TRUSERID *handle,int iRequest,ST_PACK *in_pack,int *pRetCode,char *szMsg) {
    int ret = 0;
    int card_status = 0;
    T_t_doordevcardlist tDoorDeviceCardlist;
    T_t_door_oper_right	tDoorOperRight;

    memset(&tDoorDeviceCardlist,0,sizeof(tDoorDeviceCardlist));
    memset(&tDoorOperRight,0,sizeof(tDoorOperRight));

    getsysdate(tDoorDeviceCardlist.transdate);
    getsystime(tDoorDeviceCardlist.transtime);
    tDoorDeviceCardlist.cardno=in_pack->lvol1;
    des2src(tDoorDeviceCardlist.deviceid,in_pack->sname);
    des2src(tDoorDeviceCardlist.status,"0");					//0-增加1-删除
    des2src(tDoorDeviceCardlist.send_flag,"0");				//0-未发送1-已发送

    ret=check_device(tDoorDeviceCardlist.deviceid);
    if(ret) {
        *pRetCode=ret;
        writelog(LOG_ERR,"check_device err[%d]deviceid[%s]",ret,tDoorDeviceCardlist.deviceid);
        goto L_RETU;
    }
    ret=check_cardno(tDoorDeviceCardlist.cardno);
    if(ret) {
        card_status = ret;
        if(!(E_CARD_LOST == ret || E_CARD_FREEZE == ret)) {
            *pRetCode=ret;
            writelog(LOG_ERR,"check_cardno err[%d]cardno[%s]",ret,tDoorDeviceCardlist.cardno);
            goto L_RETU;
        }
    }
    ret=chk_oper(in_pack->scust_limit);
    if(ret) {
        *pRetCode=ret;
        writelog(LOG_ERR,"chk_oper err[%d]in_pack->scust_limit[%s]",ret,in_pack->scust_limit);
        goto L_RETU;
    }
//检查权限
    ret=DB_t_door_oper_right_read_by_oper_no_and_deviceid(in_pack->scust_limit,tDoorDeviceCardlist.deviceid,&tDoorOperRight);
    if(ret) {
        writelog(LOG_ERR,"oper [%s]deviceid[%s]ret[%d]",in_pack->scust_limit,tDoorDeviceCardlist.deviceid,ret);
        if(DB_NOTFOUND==ret)
            *pRetCode=E_OPER_NO_RIGHT_FOR_DEVICE;
        else
            *pRetCode=E_DB_DOOR_OPER_RIGHT_R;
        goto L_RETU;
    }
    ret=GetNewVolume(KEYTYPE_DOOR_CARDLIST,tDoorDeviceCardlist.version);
    if(ret) {
        *pRetCode=ret;
        writelog(LOG_ERR,"GetNewVolume err[%d]",ret);
        goto L_RETU;
    }
    des2src(tDoorDeviceCardlist.stuempno,in_pack->semail);
    // 关闭 db_chk_err
    g_dbchkerr = 0;
    ret=DB_t_doordevcardlist_add(&tDoorDeviceCardlist);
    // 调用完后，重新打开 db_chk_err
    g_dbchkerr = 1;

    if(ret) {
        //如果记录已经存在则更新该记录
        if(DB_REPEAT==ret) {
            writelog(LOG_DEBUG,"update deviceid[%s],cardno[%d]",tDoorDeviceCardlist.deviceid, tDoorDeviceCardlist.cardno);
            ret=DB_t_doordevcardlist_update_by_deviceid_and_cardno(tDoorDeviceCardlist.deviceid, tDoorDeviceCardlist.cardno,&tDoorDeviceCardlist);
            if(ret) {
                writelog(LOG_ERR,"deviceid[%s],cardno[%d]",tDoorDeviceCardlist.deviceid, tDoorDeviceCardlist.cardno);
                if(DB_NOTFOUND==ret)
                    *pRetCode=E_DB_DOOR_CARDLIST_N;
                else
                    *pRetCode=E_DB_DOOR_CARDLIST_U;
                goto L_RETU;
            }
        }
    }
    // 如果卡状态正常,下传名单
    if(0 == card_status) {
        /*
        in_pack->lvol3=tDoorDeviceCardlist.cardno;
        des2src(in_pack->sdate0,tDoorDeviceCardlist.deviceid);
        in_pack->lvol5=0;
        ret = F930117(handle,iRequest,in_pack,pRetCode,szMsg);
        if (ret)
        {
        	writelog(LOG_ERR,"F930117 ret[%d]",ret);
        	goto L_RETU;
        }
        */
    }
    return 0;
L_RETU:
    return  -1;
}





