#ifndef __DB_FUNC_H_
#define __DB_FUNC_H_
//#ifdef __cplusplus
//extern "C" {
//#endif
#include "pubdb.h"
#include "cpack.h"
#include "cpucard.h"

// 数据影响行数
#ifdef ESQL_DB2
#define EFFECT_ROWS sqlca.sqlerrd[3]
#elif defined ESQL_ORA
#define EFFECT_ROWS sqlca.sqlerrd[3]
#endif


int getNewUniqNo(char *sTypeCode,int *iUniqno);
int getNewVocNo(int iType,char  *sVocNo);
int GetNewCardAccno(char *cardaccno);
int GetNewShopAccno(char *shopaccno);
int GetNewNetAccno(char *netaccno);
int IsActNoInvalid(char *actno);
/**
* @brief 生成版本号，版本号格式 yymmdd + 6位数（不足6位在左补0)
*
* @param sTypeCode - 版本号类型（对应数据序号表中的类型）
* @param volume - [out] 生成的版本号，12位字符串
*
* @return - 成功返回0，失败返回数据SQLCODE
*/
int GetNewVolume(char *sTypeCode,char * volume);

//函数功能	:  根据999设备物理ID查询设备ID
//输入		:   phyid 	char[9]　物理设备ID
//输出		:   devid  	int *	　设备ID
//返回值	:   0	 --成功
//返回值	:  非０--相应的错误码
int GetDevIdByDevPhyId(int *devid,char *phyid);
int GetDevusageByDeviceID(int deviceid,int *devusage);

int SetLogicDate(const int dateNum);
/*
	功能: 取全局参数
	描述：根据全局参数ID，将数据库中参数值取出置于buf中
	作者: 耿刚
	返回: int       	0：成功； 非0：SQLCODE
	参数: int ParaID      	全局参数的ID，正整数，参考全局参数宏定义
	参数: char* buf      	存储全局参数值，char buf[100]
*/
int GetSysParaVal(const int ParaID,char* const buf);
/*
	功能: 设置全局参数
	描述：根据全局参数ID，用buf中的内容更新数据库中参数值
	作者: 耿刚
	返回: int       	0：成功； 非0：SQLCODE
	参数: int ParaID      	全局参数的ID，正整数，参考全局参数宏定义
	参数: char* buf      	存储全局参数值，char buf[100]
*/
int SetSysParaVal(int ParaID,char* buf);

int  get_errcode_msg(int ecode,char *emsg);
int  UpdMsgStatByMsgId(T_t_msglist *meslist);
//更新消费流水表状态和返回码
//int  UpdCosumelogBySerialNo(int  serialno,T_t_tif_cosume_log *pCosumelog);
//更新卡操作流水表状态和返回码
//int  UpdCardmessBySerialNo(int  serialno,T_t_tif_cardmess *pCardmess);

//int  UpdTradeserialBySerialNo(int  serialno,T_t_tif_tradeserial *pTradeserial);
//函数功能	:根据设备ID和日期、时间,查询商户设备表，得到商户ID
//输入		:   devid 	int　		物理设备ID
//输入		:   txdate 	char[11]　交易日期
//输入		:   txtime 	char[9]　	交易时间
//输出		:   shpid 	int　		商户ID
//输入		:   fee_code int		收费科目代码
//返回值	:   0	 --成功
//返回值	:  非０--相应的错误码
//int get_shpId_by_devId_date_time(int  *shpid,int devid,char *txdate,char *txtime,int fee_code);

//函数功能	: 根据商户ID查询商户表，得到客户号
//输入		:   shpid 	int　商户ID
//输出		:   custid  	int *	　客户号
//返回值	:   0	 --成功
//返回值	:  非０--相应的错误码
//int  get_customid_by_shpid(int *custid,int shpid);

//函数功能	: 根据客户号和帐户类别查询帐户表得到账号
//输入		:   devid 	int　		物理设备ID
//输入		:   txdate 	char[11]　交易日期
//输入		:   txtime 	char[9]　	交易时间
//输出		:   actno  	char[17]	帐号
//返回值	:   0	 --成功
//返回值	:  非０--相应的错误码
//int get_actno_by_devId_date_time(char *actno,int devid,char *txdate,char *txtime);

//检查交易是否已经存在
//int IsExistCosumelogDetail(T_t_tif_cosume_log *p);
//int IsExistCardMessDetail(T_t_tif_cardmess *p);
//得到商户收费比率最大值
//int GetMaxFeeRatioFromShop(double* maxfeeratio);
//商户结算表的数据提取函数，将发生额与管理费金额合并到一条记录中
//int DB_v_tif_shopdeptfee_open_select_by_c5();
//int DB_v_tif_shopdeptfee_fetch_select_by_c5(T_t_tif_report_shop_balance *pv_tif_shopdeptfee);
//int DB_v_tif_shopdeptfee_close_select_by_c5();
////科目余额表的对应视图的数据提取，情况同上类似
//int DB_v_tif_acttype_trade_open_select_by_c5();
//int DB_v_tif_acttype_trade_fetch_select_by_c5(T_t_tif_subject_balance *pv_tif_acttype);
//int DB_v_tif_acttype_close_select_by_c5();
//修改设备签到表中设备状态标志，修改为未签到
int DB_t_device_update_by_subsystem_type(int v_sysid,int v_status);
//修改卡状态(卡信息)
//int UpdateCardState(int cardno,int state_type,char flag);
//根据学号得到卡的交易卡号
int get_cardno_by_stuempno(char *stuempno,int *cardno);
int IsExistOtherNormalCardByCustid(int custid,int cardno);
//判断是否发行过卡
int IsExistCardByCustomId(int custom_id);
int IsExistCardByPhyCardNo(char *phycardno);
//得到挂失卡号
//int GetLostCardIdByCustomId_TypeId(int customid,int type_id,int *o_card_id);
//得到挂失卡号4
int GetLostCardIdByCustomId(int customid,int *o_card_id);
//获得正式卡的有效期
int GetCardValiddate(int custtype,char *logicdate,char *validdate);
//获得卡状态
int GetCardState(int cardid,char  *status1);
//获得挂失卡的有效期限
int GetLostCardValiddate(char *logicdate,char *validdate);
//判断客户是否存在正常的过渡临时卡
int IsExistNormalTmpCardByCustid(int custid);
//判断客户是否存在正常的卡
int IsExistNormalCardByCustid(int customid);
//判断卡是否已经使用
int IsExistCardByPhyCardNo(char *phycardno);
//判断客户是否存在非挂失状态的卡
//根据帐户类型得到该类型帐户的个数
int Get_Account_Count_by_AccType(double *count,int acctype);
//根据账户类型得到该类型账户的总金额
int Get_Account_SumMoney_by_AccType(double *SumMoney,int acctype);
//根据商户账户的客户号判断该商户是否为独立核算商户--by hhd
int JudgeShopAccountType(int custid,int * indep_yes_no);
int  UpdateCardLossInfoState(int cardno,int before_state, int after_state);
int IsExistDeviceByShopId(int shop_id,char *logicdate);
int IsExistSameShopName(char *shop_name,int shop_id);
int AddMsgLst(T_t_msglist *pMeslist);
int UpdMsgLst(T_t_msglist *pMeslist);
int GetTempPersonId(char  *sTmpId);
//核对子系统密钥
int chk_dyn_key(int system_id,char *key);
int chk_card_pwd(char *stu_no,char *card_pwd);
int chk_card_pwd_by_showcardno(char  *showcardno,char *card_pwd,int *card_no);
int get_max_black_list_version(char blackver[13]);
int get_subsysid_by_phyid(char *devphyid,int *subsys_id);
int get_subsysid_by_deviceid(int deviceid,int* subsysid);
int get_devinfo_by_phyid(char *devphyid,T_t_device *pt_pif_device);
int IsNoWorkTimeByDevId(int dev_id);
int ChkWorkTimeConflict(int shop_id,int deviceid,char *logic_date,char *begin_date,char *end_date,char *begin_time,char *end_time,int id);
int ChkWorkTimeConflict2(int shop_id,int deviceid,char *logic_date,char *begin_date,char *end_date,char *begin_time,char *end_time,int id,int fee_code);
//int getdata(T_t_tif_tradeserial *pTradeserial,T_t_tif_rcvdtl *pRcvdtl);
//int process930030(T_t_tif_tradeserial *pTradeserial);
//int process930031(T_t_tif_tradeserial *pTradeserial);
//int process930033(T_t_tif_tradeserial *pTradeserial);
//int process930034(T_t_tif_tradeserial *pTradeserial);
//int process930036(T_t_tif_tradeserial *pTradeserial);
int DB_t_tif_tradelog_del_all_by_step_commit();
int DB_t_tif_tradeserial_del_all_by_step_commit();
int DB_t_msglist_del_all_by_step_commit();
int DB_t_msglist_del_all_in_03_04_60_by_step_commit();
int chk_oper_pwd(char *oper_no,char *oper_pwd);
int get_datetime_from_db(char *dbdate,char* dbtime);
/************************************************************
 * 写入名单数据，由通用前置向子系统发送
 * 目前只需要用2, 9 两种标志
 * @param cardid - 交易卡号
 * @param flag - 名单类别: 2 注销9. 换卡
 *			   2 : CANCEL_BLACKLIST
 *			   9 : BLACK_BLACKLIST
 * @return - 0 表示成功，否则返回错误原因的错误码
*************************************************************/
int InsertToBlkList(int cardid,int flag);
/**
* @brief 写入客户信息更新记录，由通用前置向子系统发送
*
* @param cardid - 交易卡号
* @param flag - 名单类型
*				 更新信息 CUTUPD_UPDATE
*				 注销客户 CUTUPD_CANCEL
*				 新增客户 CUTUPD_ADD
*
* @return - 0 表示成功,否则返回错误的SQLCODE码
*/
int InsertToCutUpdList(int cardid,int flag,char phyno[9]);
//判断客户是否存在冻结状态的卡
int IsExistFreezeCardByCustomId(int customid);
int get_latest_lost_date_by_card_no(int card_no,char *lost_date);
/*
 * 将所有的标志为1 的键初始化为0
*/
int InitializeSyskey();
//检查操作员是否存在，状态是否正常
int chk_oper(char *oper_no);

int CheckNewCardHook(T_t_customer *customer,int newcardid);
int Db_t_tif_tradelog_backup_by_bak_date(char* logic_date);
int Db_t_tif_tradeserial_backup_by_bak_date(char* logic_date);
int Db_v_door_txdtl_his_backup();
int Db_t_door_txdtl_del_all_by_step_commit();
int Db_t_tif_report_depttrade_generate();
//检查一卡通系统是否不存在该学/工号
int IsInexistenceStuEmp(char *stuempno);
int stat_subsidy_amount_by_batchno(char *batchno,int *total_cnt,double *total_amt);
int update_subsidy_info_by_batchno(T_t_subsidy *pSubsidy);
int Db_v_blklst_lost_return_lost_date(int card_no,char *lost_date);
int get_stuempno_by_cardno(int cardno,char *stuempno);
//根据学号得到客户号
int get_custid_by_stuempno(char *stuempno,int* custid);
//根据学号得到卡号
int get_cardno_by_stuempno(char *stuempno,int *cardno);
int get_cardno_by_custid(int custid,int* cardno);
//根据学号更新客户批次号
int UpdCustomerBatch_noByStuemp_no(char *stuempno,char *batchno);
//得到圈存子系统的子系统id
int GetTransferSystemId();
//取得冻结的客户信息,withhold方式打开
int DB_t_customer_open_select_with_hold_by_cur3_and_frozen_status(int v_frozen_status);
int DB_t_customer_fetch_select_by_cur3(T_t_customer *pt_cif_customer);
int DB_t_customer_close_select_by_cur3();
int GetCardMaxBlkVerNo(int cardno,char *blkverno);
int UseShowCardNo(char *opercode,char *showcardno,int& cardtype);
int UseShowCardNoRev(char *showcardno);
int UseShowCardNoBack(char *opercode,char *showcardno);
//int GetSysParaVal(int paraid,char *paraval);
//int getCardBookRecordNo(int& recordno);
int getCardVerNo(char *cardverno);
int getSubsidyCardNo(int custid,int& cardno);
int addoperdtl(ST_PACK *rPack);
int getNewTermID(int& termid);
int UpdCardVerStatus(int cardno,int cardvertype);
bool IsDatabaseConnect(bool update=false);
int GetShopidByDevphyid(char *devphyid,char *transdate,char *transtime,int& deviceid,int& shopid);
int GetMaxShopFeeRate(double& shopfeerate);
int getTransName(int transtype,char *transname);
int DelCardAccDiffByCardno(int cardno);
//获取最大黑名单版本号
int GetMaxBlackCardVerNo(char *cardverno);
int GetCustidByStuempno(char *stuempno,int& custid);
int IsIdnoExist(char *idno,char *idtype);
int IsStuempnoExist(char *stuempno);
int GetCustidBySchoolCodeAndStuempno(char *schoolcode,char *stuempno,int& custid);
int UpdateCardExpireDate(int custid,char *expiredate);
//根据校区生成新客户号
int GetNewCustIDByShoolCode(char *school_code,int& custid);
//读取钱包最大金额
int GetPurseMaxBal(int purseno,double& cardmaxbal);
//考虑联机效率，单独写了读取学号的函数
int GetStuempnoByCustid(int custid,char *stuempno);
int GetAccdtlTableName(char *accdate,char *accdtlname);
int GetTransdtlTableName(char *accdate,char *transdtlname);
int chk_cardpwd_by_cardno(int cardno,char *cardpwd);
// CPU 卡计算 MAC2
int calc_cpucard_mac(cpu_trade_t *trade,char *mac,int mode);
int GetAccnoByCardno(int cardno,char *accno);
int GetCardAccInfoByCardNo(int cardno,int* custid,char *cardaccno,char *showcardno);
int GetCustBaseInfoByCustID(int custid,char *custname,char *stuempno,char *deptcode);
int ReadTransdtlData(char *transdtlname,char *accdate,int termid,int termseqno,T_t_transdtl& transdtl);
int get_cardaddr(int cardno,int ctrlid,int listid,int adddel,int &cardaddr);
int update_cardaddr(int ctrlid,int listid);
int IsExistUnGetSubsidy(int cardno,int* existflag);
int GetCustIDByBankcardno(char *bankcardno,int* custid);
int ChkOperPwd(char *operno,char *operpwd);
int GetStuempnoByAccno(char* accno,char *stuempno);

//#ifdef __cplusplus
//}
//#endif
#endif
