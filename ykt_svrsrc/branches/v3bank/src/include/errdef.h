#ifndef  __ERRDEF_H_
#define  __ERRDEF_H_

#define E_COMMON_ERR						-1	//
#define E_999_BASE			    390000
#define E_999_0X00                     390000	//黑卡交易
#define E_999_0X01                     390001	//非法卡
#define E_999_0X02                     390002	//中途拔卡
#define E_999_0X03                     390003	//钱包格式错
#define E_999_0X05                     390005	//无法写卡
#define E_999_0X10                     390016	//密码错误
#define E_999_0x99			    390153      // 正确
#define E_999_0XA0                     390160	//不在时间段内打卡
#define E_999_0XA1                     390161	//次数超出
#define E_999_0XA2                     390162	//时间间隔不够
#define E_999_0XFA                     390250	//充值交易
#define E_999_0XFE                     390254	//冲正交易
#define E_999_0XFF			    390255	//交易不成功

#define E_999_AMT                      100000	//上传流水交易发生金额有误
#define E_999_CARD_BALANCE    100001	//上传流水出入卡余额有误
#define E_999_CRC                       100002	//上传流水CRC校验错误
#define E_999_DATE                     100003	//上传流水交易日期有误
#define E_999_TIME                     100004	//上传流水交易时间有误
#define E_ACTNO_INVALID                 100005	//账号无效
#define E_ACTNO_NOT_EXIST               100006	//帐号不存在
#define E_APP_NO_IS_NULL                100007	//应用程序编号为空
#define E_AREA_FIDNULL                  100008	//父区域不能为空
#define E_AREA_ROOTUNIQUE               100009	//区域设置中根节点只能有一个
#define E_BALANCE_NOW                   100010	//系统正在结帐，无法同时结帐
#define E_BALANCE_SHORTAGE              100011	//帐户余额不足
#define E_CARDNO_LOST                      100012	//卡已经挂失
#define E_CARDNORMAL                    100013	//非正常卡状态,不能做挂失\退卡操作.
#define E_CARDNOTAVAILABILITY           100014	//卡的挂失有效期限未到,不能补办.
#define E_CARDNO_INVALID                100015	//卡号无效
#define E_CARDNO_NOT_EXIST              100016	//卡号不存在
#define E_CARDSTATE_NOTWRITEFAIL        100017	//卡状态不是写卡未成功状态
#define E_CARD_STATE_ERROR              100018	//此卡状态错误
#define E_CHANGE_FLAG                   100019	//更改全局结帐标志出错
#define E_CHECK_INITKEY                 100020	//匹配初始密钥失败
#define E_CREATE_SHARE_MEMORY           100021	//创建共享内存失败
#define E_CUTTYPEFEE_D                  100022	//客户类别与搭伙费表删除错误
#define E_CUTTYPEFEE_I                  100023	//客户类别与搭伙费表插入错误
#define E_CUTTYPEFEE_N                  100024	//客户类别与搭伙费表无相关记录
#define E_CUTTYPEFEE_R                  100025	//客户类别与搭伙费表读取错误
#define E_CUTTYPEFEE_U                  100026	//客户类别与搭伙费表更新错误
#define E_CUTTYPE_NOT_EXIST             100027	//客户类别不存在
#define E_DATE_FMT                      100028	//日期格式不正确
#define E_DAYEND_STATUS                 100029	//系统出于日终状态业务系统服务暂停
#define E_DB_ACCOUNT_D                  100030	//帐户表删除错误
#define E_DB_ACCOUNT_I                  100031	//帐户表插入错误
#define E_DB_ACCOUNT_N                  100032	//读帐户表无相关记录
#define E_DB_ACCOUNT_R                  100033	//帐户表读取错误
#define E_DB_ACCOUNT_U                  100034	//帐户表更新错误
#define E_DB_ALARMLEVEL_D               100035	//警戒级别信息表删除错误
#define E_DB_ALARMLEVEL_I               100036	//警戒级别信息表插入错误
#define E_DB_ALARMLEVEL_N               100037	//警戒级别信息表无记录
#define E_DB_ALARMLEVEL_R               100038	//警戒级别信息表读错误
#define E_DB_ALARMLEVEL_U               100039	//警戒级别信息表更新错误
#define E_DB_ALARMOP_D                  100040	//报警处理记录表删除错误
#define E_DB_ALARMOP_I                  100041	//报警处理记录表插入错误
#define E_DB_ALARMOP_N                  100042	//报警处理记录表无相关记录
#define E_DB_ALARMOP_R                  100043	//报警处理记录表查询错误
#define E_DB_ALARMOP_U                  100044	//报警处理记录表更新错误
#define E_DB_ALARM_D                    100045	//警戒信息表删除错误
#define E_DB_ALARM_I                    100046	//警戒信息表插入错误
#define E_DB_ALARM_N                    100047	//警戒信息表无记录
#define E_DB_ALARM_R                    100048	//警戒信息表读错误
#define E_DB_ALARM_U                    100049	//警戒信息表更新错误
#define E_DB_APP_FUNC_LIST_D            100050	//程序功能列表删除错误
#define E_DB_APP_FUNC_LIST_I            100051	//程序功能列表插入错误
#define E_DB_APP_FUNC_LIST_N            100052	//程序功能列表无相关记录
#define E_DB_APP_FUNC_LIST_R            100053	//程序功能列表查询错误
#define E_DB_APP_FUNC_LIST_U            100054	//程序功能列表更新错误
#define E_DB_AREA_D                     100055	//区域表删除错误
#define E_DB_AREA_I                     100056	//区域表插入错误
#define E_DB_AREA_N                     100057	//区域表查询无相关记录
#define E_DB_AREA_R                     100058	//区域表读取错误
#define E_DB_AREA_U                     100059	//区域表修改错误
#define E_DB_AUTHCARD_D                 100060	//授权卡信息表删除错误
#define E_DB_AUTHCARD_I                 100061	//授权卡信息表插入错误
#define E_DB_AUTHCARD_N                 100062	//授权卡信息表无相关记录
#define E_DB_AUTHCARD_R                 100063	//授权卡信息表查询错误
#define E_DB_AUTHCARD_U                 100064	//授权卡信息表更新错误
#define E_DB_AUTHEN_LOG_BAK_D           100065	//认证流水表归档删除错误
#define E_DB_AUTHEN_LOG_BAK_I           100066	//认证流水表归档插入错误
#define E_DB_AUTHEN_LOG_BAK_U           100067	//认证流水表归档更新错误
#define E_DB_BLACK_SHEET_D              100068	//黑名单表删除错误
#define E_DB_BLACK_SHEET_I              100069	//黑名单表插入错误
#define E_DB_BLACK_SHEET_LOG_D          100070	//黑名单日志表删除错误
#define E_DB_BLACK_SHEET_LOG_I          100071	//黑名单日志表插入错误
#define E_DB_BLACK_SHEET_LOG_N          100072	//黑名单日志表无相关记录
#define E_DB_BLACK_SHEET_LOG_R          100073	//黑名单日志表查询错误
#define E_DB_BLACK_SHEET_LOG_U          100074	//黑名单日志表更新错误
#define E_DB_BLACK_SHEET_N              100075	//黑名单表无相关记录
#define E_DB_BLACK_SHEET_R              100076	//黑名单表查询错误
#define E_DB_BLACK_SHEET_U              100077	//黑名单表更新错误
#define E_DB_CARDDBINCON_D              100078	//监控卡库不平异常表删除错误
#define E_DB_CARDDBINCON_I              100079	//监控卡库不平异常表插入错误
#define E_DB_CARDDBINCON_N              100080	//监控卡库不平异常表无相关记录
#define E_DB_CARDDBINCON_R              100081	//监控卡库不平异常表查询错误
#define E_DB_CARDDBINCON_U              100082	//监控卡库不平异常表更新错误
#define E_DB_CARDLOSSINFO_D             100083	//卡有效期表删除错误
#define E_DB_CARDLOSSINFO_I             100084	//卡有效期表插入错误
#define E_DB_CARDLOSSINFO_N             100085	//卡有效期表无相关记录
#define E_DB_CARDLOSSINFO_R             100086	//卡有效期表查询错误
#define E_DB_CARDLOSSINFO_U             100087	//卡有效期表更新错误
#define E_DB_CARDMESS_D                 100088	//卡操作信息表删除错误
#define E_DB_CARDMESS_I                 100089	//卡操作信息表插入错误
#define E_DB_CARDMESS_N                 100090	//卡操作信息表无相关记录
#define E_DB_CARDMESS_R                 100091	//卡操作信息表查询错误
#define E_DB_CARDMESS_U                 100092	//卡操作信息表更新错误
#define E_DB_CARDOPERATE_D              100093	//监控异常卡操作流水表删除错误
#define E_DB_CARDOPERATE_I              100094	//监控异常卡操作流水表插入错误
#define E_DB_CARDOPERATE_N              100095	//监控异常卡操作流水表无相关记录
#define E_DB_CARDOPERATE_R              100096	//监控异常卡操作流水表查询错误
#define E_DB_CARDOPERATE_U              100097	//监控异常卡操作流水表更新错误
#define E_DB_CARDSTRUT_D                100098	//卡物理结构信息表删除错误
#define E_DB_CARDSTRUT_I                100099	//卡物理结构信息表插入错误
#define E_DB_CARDSTRUT_N                100100	//卡物理结构信息表查询无相关记录
#define E_DB_CARDSTRUT_R                100101	//卡物理结构信息表读取错误
#define E_DB_CARDSTRUT_U                100102	//卡物理结构信息表更新错误
#define E_DB_CARD_D                     100103	//卡信息表删除错误
#define E_DB_CARD_I                     100104	//卡信息表插入错误
#define E_DB_CARD_N                     100105	//卡信息表无相关记录
#define E_DB_CARD_R                     100106	//卡信息表查询错误
#define E_DB_CARD_U                     100107	//卡信息表更新错误
#define E_DB_CHECKOUT_HIS_D             100108	//历史结帐流水表删除错误
#define E_DB_CHECKOUT_HIS_I             100109	//历史结帐流水表插入错误
#define E_DB_CHECKOUT_HIS_N             100110	//历史结帐流水表无相关记录
#define E_DB_CHECKOUT_HIS_R             100111	//历史结帐流水表查询错误
#define E_DB_CHECKOUT_HIS_U             100112	//历史结帐流水表更新错误
#define E_DB_COMMIT                     100113	//事务提交失败
#define E_DB_COSUME_HIS_D               100114	//消费历史转账流水表删除错误
#define E_DB_COSUME_HIS_I               100115	//消费历史转账流水表插入错误
#define E_DB_COSUME_HIS_N               100116	//消费历史流水表无相关记录
#define E_DB_COSUME_HIS_R               100117	//消费历史转账流水表查询错误
#define E_DB_COSUME_HIS_U               100118	//消费历史转账流水表更新错误
#define E_DB_COSUME_LOG_D               100119	//流水数据表删除错误
#define E_DB_COSUME_LOG_I               100120	//流水数据表插入错误
#define E_DB_COSUME_LOG_N               100121	//流水数据表无相关记录
#define E_DB_COSUME_LOG_R               100122	//流水数据表查询错误
#define E_DB_COSUME_LOG_U               100123	//流水数据表更新错误
#define E_DB_COSUME_lOG_BAK_D           100124	//消费流水表归档删除错误
#define E_DB_COSUME_lOG_BAK_I           100125	//消费流水表归档插入错误
#define E_DB_COSUME_lOG_BAK_U           100126	//消费流水表归档更新错误
#define E_DB_CUR_SYSPARA_D              100127	//全局参数正式表删除错误
#define E_DB_CUR_SYSPARA_I              100128	//全局参数正式表插入错误
#define E_DB_CUR_SYSPARA_N              100129	//全局参数正式表查询无相关记录
#define E_DB_CUR_SYSPARA_R              100130	//全局参数正式表读取错误
#define E_DB_CUR_SYSPARA_RE             100131	//全局参数标识定义重复
#define E_DB_CUR_SYSPARA_U              100132	//全局参数正式表修改错误
#define E_DB_CUSTOMER_D                 100133	//客户信息表删除错误
#define E_DB_CUSTOMER_I                 100134	//客户信息表插入错误
#define E_DB_CUSTOMER_N                 100135	//客户信息表无相关记录
#define E_DB_CUSTOMER_P                 100136	//客户信息查询，执行 EXEC SQL PREPARE 时错误
#define E_DB_CUSTOMER_QUERY_N           100137	//客户信息查询无相关记录
#define E_DB_CUSTOMER_QUERY_P           100138	//准备动态查询语句错误
#define E_DB_CUSTOMER_R                 100139	//客户信息表查询错误
#define E_DB_CUSTOMER_U                 100140	//客户信息表更新错误
#define E_DB_CUTTYPEFEE_D               100141	//客户类别表删除错误
#define E_DB_CUTTYPEFEE_I               100142	//客户类别表插入错误
#define E_DB_CUTTYPEFEE_N               100143	//客户类别表无相关记录
#define E_DB_CUTTYPEFEE_P               100144	//客户类别查询，执行 EXEC SQL PREPARE 时错误
#define E_DB_CUTTYPEFEE_R               100145	//客户类别表查询错误
#define E_DB_CUTTYPEFEE_U               100146	//客户类别表更新错误
#define E_DB_DEPARTMENT_D               100147	//单位表删除错误
#define E_DB_DEPARTMENT_I               100148	//单位表插入错误
#define E_DB_DEPARTMENT_N               100149	//单位表查询错误
#define E_DB_DEPARTMENT_R               100150	//单位表更新错误
#define E_DB_DEPARTMENT_U               100151	//单位表无相关记录
#define E_DB_DEPOSIT_LOG_BAK_D          100152	//充值流水表归档删除错误
#define E_DB_DEPOSIT_LOG_BAK_I          100153	//充值流水表归档插入错误
#define E_DB_DEPOSIT_LOG_BAK_U          100154	//充值流水表归档更新错误
#define E_DB_DEPT_D                     100155	//单位信息表删除错误
#define E_DB_DEPT_I                     100156	//单位信息表插入错误
#define E_DB_DEPT_N                     100157	//单位信息表无相关记录
#define E_DB_DEPT_R                     100158	//单位信息表查询错误
#define E_DB_DEPT_U                     100159	//单位信息表更新错误
#define E_DB_DEVASSET_D                 100160	//设备资产表删除错误
#define E_DB_DEVASSET_I                 100161	//设备资产表插入错误
#define E_DB_DEVASSET_N                 100162	//设备资产表无记录
#define E_DB_DEVASSET_R                 100163	//设备资产表读错误
#define E_DB_DEVASSET_U                 100164	//设备资产表更新错误
#define E_DB_DEVICE_D                   100165	//设备注册表删除错误
#define E_DB_DEVICE_I                   100166	//设备注册表插入错误
#define E_DB_DEVICE_LOG_D               100167	//设备签到/签出日志表删除错误
#define E_DB_DEVICE_LOG_I               100168	//设备签到/签出日志表插入错误
#define E_DB_DEVICE_LOG_N               100169	//设备签到/签出日志表查询无记录
#define E_DB_DEVICE_LOG_R               100170	//设备签到/签出日志表读取错误
#define E_DB_DEVICE_LOG_U               100171	//设备签到/签出日志表修改错误
#define E_DB_DEVICE_N                   100172	//设备注册表查询无记录
#define E_DB_DEVICE_R                   100173	//设备注册表读取错误
#define E_DB_DEVICE_U                   100174	//设备注册表修改错误
#define E_DB_DEVI_LOGIN                 100175	//设备没有签到，不能签出
#define E_DB_DEVI_MATCH                 100176	//设备标志与子系统标志匹配失败
#define E_DB_DEVMONERR_D                100177	//设备监控异常表表删除错误
#define E_DB_DEVMONERR_I                100178	//设备监控异常表表插入错误
#define E_DB_DEVMONERR_N                100179	//设备监控异常表表无相关记录
#define E_DB_DEVMONERR_R                100180	//设备监控异常表表查询错误
#define E_DB_DEVMONERR_U                100181	//设备监控异常表表更新错误
#define E_DB_DEVMONITOR_D               100182	//设备监控表删除错误
#define E_DB_DEVMONITOR_I               100183	//设备监控表插入错误
#define E_DB_DEVMONITOR_N               100184	//设备监控表无相关记录
#define E_DB_DEVMONITOR_R               100185	//设备监控表查询错误
#define E_DB_DEVMONITOR_U               100186	//设备监控表更新错误
#define E_DB_DEVTIME_D                  100187	//设备时间段设置表删除错误
#define E_DB_DEVTIME_I                  100188	//设备时间段设置表插入错误
#define E_DB_DEVTIME_N                  100189	//设备时间段设置表无记录
#define E_DB_DEVTIME_R                  100190	//设备时间段设置表读错误
#define E_DB_DEVTIME_U                  100191	//设备时间段设置表更新错误
#define E_DB_DICTIONARY_D               100192	//数据字典表删除错误
#define E_DB_DICTIONARY_I               100193	//数据字典表插入错误
#define E_DB_DICTIONARY_N               100194	//数据字典表查询无相关记录
#define E_DB_DICTIONARY_R               100195	//数据字典表查询错误
#define E_DB_DICTIONARY_RE              100196	//数据字典重复注册
#define E_DB_DICTIONARY_U               100197	//数据字典表更新错误
#define E_DB_EMPLOYEE_D                 100198	//员工信息表删除错误
#define E_DB_EMPLOYEE_I                 100199	//员工信息表插入错误
#define E_DB_EMPLOYEE_N                 100200	//员工信息表无相关记录
#define E_DB_EMPLOYEE_R                 100201	//员工信息表查询错误
#define E_DB_EMPLOYEE_U                 100202	//员工信息表更新错误
#define E_DB_ERRCODE_D                  100203	//返回码表删除错误
#define E_DB_ERRCODE_I                  100204	//返回码表插入错误
#define E_DB_ERRCODE_N                  100205	//返回码表查询无相关记录
#define E_DB_ERRCODE_R                  100206	//返回码表查询错误
#define E_DB_ERRCODE_U                  100207	//返回码表更新错误
#define E_DB_ERROR                      100208	// 数据库错误
#define E_DB_LINKMAN_N                  100209	//报警联系人表无相关记录
#define E_DB_LINKMAN_R                  100210	//报警联系人表读取错误
#define E_DB_MESLIST_D                  100211	//消息队列信息表删除错误
#define E_DB_MESLIST_E                  100212	//消息ID错误
#define E_DB_MESLIST_I                  100213	//消息队列信息表插入错误
#define E_DB_MESLIST_N                  100214	//消息队列信息表无相关记录
#define E_DB_MESLIST_R                  100215	//消息队列信息表查询错误
#define E_DB_MESLIST_U                  100216	//消息队列信息表更新错误
#define E_DB_MESLIST_X                  100217	//消息队列信息错误
#define E_DB_MODULE_AUTH_D              100218	//权限模板表删除错误
#define E_DB_MODULE_AUTH_I              100219	//权限模板表插入错误
#define E_DB_MODULE_AUTH_N              100220	//权限模板表无相关记录
#define E_DB_MODULE_AUTH_R              100221	//权限模板表查询错误
#define E_DB_MODULE_AUTH_RE             100222	//权限模板重复注册
#define E_DB_MODULE_AUTH_U              100223	//权限模板表更新错误
#define E_DB_NOTFOUND                   100224	// 结果集为空
#define E_DB_OLD_SYSPARA_D              100225	//全局参数临时表删除错误
#define E_DB_OLD_SYSPARA_I              100226	//全局参数临时表插入错误
#define E_DB_OLD_SYSPARA_N              100227	//全局参数临时表查询无相关记录
#define E_DB_OLD_SYSPARA_R              100228	//全局参数临时表读取错误
#define E_DB_OLD_SYSPARA_U              100229	//全局参数临时表修改错误
#define E_DB_OPERATOR_D                 100230	//操作员注册表删除错误
#define E_DB_OPERATOR_I                 100231	//操作员注册表插入错误
#define E_DB_OPERATOR_LOG_D             100232	//操作员登陆登出日志表删除错误
#define E_DB_OPERATOR_LOG_I             100233	//操作员登陆登出日志表插入错误
#define E_DB_OPERATOR_LOG_N             100234	//操作员登陆登出日志表无相关记录
#define E_DB_OPERATOR_LOG_R             100235	//操作员登陆登出日志表查询错误
#define E_DB_OPERATOR_LOG_U             100236	//操作员登陆登出日志表更新错误
#define E_DB_OPERATOR_N                 100237	//操作员注册表无相关记录
#define E_DB_OPERATOR_R                 100238	//操作员注册表查询错误
#define E_DB_OPERATOR_RE                100239	//操作员代码已存在
#define E_DB_OPERATOR_U                 100240	//操作员注册表更新错误
#define E_DB_OPER_MAIN_FUNC_D           100241	//操作员主功能号删除错误
#define E_DB_OPER_MAIN_FUNC_I           100242	//操作员主功能号插入错误
#define E_DB_OPER_MAIN_FUNC_N           100243	//操作员主功能号表无相关记录
#define E_DB_OPER_MAIN_FUNC_R           100244	//操作员主功能号查询错误
#define E_DB_OPER_MAIN_FUNC_U           100245	//操作员主功能号更新错误
#define E_DB_OPER_SITE_D                100246	//操作员－登陆站点表删除错误
#define E_DB_OPER_SITE_I                100247	//操作员－登陆站点表插入错误
#define E_DB_OPER_SITE_N                100248	//操作员－登陆站点表无相关记录
#define E_DB_OPER_SITE_R                100249	//操作员－登陆站点表查询错误
#define E_DB_OPER_SITE_RE               100250	//操作员登陆站点重复注册
#define E_DB_OPER_SITE_U                100251	//操作员－登陆站点表更新错误
#define E_DB_PHYDEVICE_D                100252	//设备物理结构信息表删除错误
#define E_DB_PHYDEVICE_I                100253	//设备物理结构信息表插入错误
#define E_DB_PHYDEVICE_N                100254	//设备物理结构信息表查询无相关记录
#define E_DB_PHYDEVICE_R                100255	//设备物理结构信息表读取错误
#define E_DB_PHYDEVICE_U                100256	//设备物理结构信息表修改错误
#define E_DB_REPORT_ACTIVE_D            100257	//运行情况表删除错误
#define E_DB_REPORT_ACTIVE_I            100258	//运行情况表插入错误
#define E_DB_REPORT_ACTIVE_N            100259	//运行情况表无相关记录
#define E_DB_REPORT_ACTIVE_R            100260	//运行情况表读取错误
#define E_DB_REPORT_ACTIVE_U            100261	//运行情况表更新错误
#define E_DB_REVISE_LOG_BAK_D           100262	//冲正流水表归档删除错误
#define E_DB_REVISE_LOG_BAK_I           100263	//冲正流水表归档插入错误
#define E_DB_REVISE_LOG_BAK_U           100264	//冲正流水表归档更新错误
#define E_DB_ROLLBACK                   100265	//事务回滚失败
#define E_DB_SHOPDEPTFEE_D              100266	//所有商户交易明细视图删除错误
#define E_DB_SHOPDEPTFEE_I              100267	//所有商户交易明细视图插入错误
#define E_DB_SHOPDEPTFEE_N              100268	//所有商户交易明细视图无相关记录
#define E_DB_SHOPDEPTFEE_R              100269	//所有商户交易明细视图读取错误
#define E_DB_SHOPDEPTFEE_U              100270	//所有商户交易明细视图更新错误
#define E_DB_SHOP_D                     100271	//商户信息表删除错误
#define E_DB_SHOP_I                     100272	//商户信息表插入错误
#define E_DB_SHOP_LOG_D                 100273	//商户信息临时表删除错误
#define E_DB_SHOP_LOG_I                 100274	//商户信息临时表插入错误
#define E_DB_SHOP_LOG_N                 100275	//商户信息临时表无相关记录
#define E_DB_SHOP_LOG_R                 100276	//商户信息临时表读取错误
#define E_DB_SHOP_LOG_U                 100277	//商户信息临时表更新错误
#define E_DB_SHOP_N                     100278	//商户信息表无相关记录
#define E_DB_SHOP_POS_D                 100279	//商户设备信息表删除错误
#define E_DB_SHOP_POS_I                 100280	//商户设备信息表插入错误
#define E_DB_SHOP_POS_LOG_D             100281	//商户设备信息临时表删除错误
#define E_DB_SHOP_POS_LOG_I             100282	//商户设备信息临时表插入错误
#define E_DB_SHOP_POS_LOG_N             100283	//商户设备信息临时表无相关记录
#define E_DB_SHOP_POS_LOG_R             100284	//商户设备信息临时表查询错误
#define E_DB_SHOP_POS_LOG_U             100285	//商户设备信息临时表更新错误
#define E_DB_SHOP_POS_N                 100286	//商户设备信息表无相关记录
#define E_DB_SHOP_POS_R                 100287	//商户设备信息表查询错误
#define E_DB_SHOP_POS_U                 100288	//商户设备信息表更新错误
#define E_DB_SHOP_R                     100289	//商户信息表查询错误
#define E_DB_SHOP_U                     100290	//商户信息表更新错误
#define E_DB_SITE_INFO_D                100291	//站点表删除错误
#define E_DB_SITE_INFO_I                100292	//站点表插入错误
#define E_DB_SITE_INFO_N                100293	//站点表无相关记录
#define E_DB_SITE_INFO_R                100294	//站点表查询错误
#define E_DB_SITE_INFO_RE               100295	//登陆站点重复注册
#define E_DB_SITE_INFO_U                100296	//站点表更新错误
#define E_DB_SPECIALITY_D               100297	//专业信息表删除错误
#define E_DB_SPECIALITY_I               100298	//专业信息表插入错误
#define E_DB_SPECIALITY_N               100299	//专业信息表无相关记录
#define E_DB_SPECIALITY_R               100300	//专业信息表查询错误
#define E_DB_SPECIALITY_U               100301	//专业信息表更新错误
#define E_DB_STUDENT_D                  100302	//学生信息表删除错误
#define E_DB_STUDENT_I                  100303	//学生信息表插入错误
#define E_DB_STUDENT_N                  100304	//学生信息表无相关记录
#define E_DB_STUDENT_R                  100305	//学生信息表查询错误
#define E_DB_STUDENT_U                  100306	//学生信息表更新错误
#define E_DB_SUBJECT_D                  100307	//科目表删除错误
#define E_DB_SUBJECT_I                  100308	//科目表插入错误
#define E_DB_SUBJECT_N                  100309	//科目表无相关记录
#define E_DB_SUBJECT_R                  100310	//科目表读取错误
#define E_DB_SUBJECT_U                  100311	//科目表更新错误
#define E_DB_SUBSIDY_LOG_BAK_D          100312	//补助流水表归档删除错误
#define E_DB_SUBSIDY_LOG_BAK_I          100313	//补助流水表归档插入错误
#define E_DB_SUBSIDY_LOG_BAK_U          100314	//补助流水表归档更新错误
#define E_DB_SUBSIDY_WAITING_BAK_D      100315	//待写卡流水表归档删除错误
#define E_DB_SUBSIDY_WAITING_BAK_I      100316	//待写卡流水表归档插入错误
#define E_DB_SUBSIDY_WAITING_BAK_U      100317	//待写卡流水表归档更新错误
#define E_DB_SUBSYSTEM_D                100318	//子系统注册表删除错误
#define E_DB_SUBSYSTEM_I                100319	//子系统注册表插入错误
#define E_DB_SUBSYSTEM_N                100320	//子系统注册表查询相关无记录
#define E_DB_SUBSYSTEM_R                100321	//子系统注册表读取错误
#define E_DB_SUBSYSTEM_SIGN             100322	//子系统尚未签到却进行签出操作
#define E_DB_SUBSYSTEM_U                100323	//子系统注册表修改错误
#define E_DB_SUBSYS_LOG_D               100324	//子系统签到/签出日志表删除错误
#define E_DB_SUBSYS_LOG_I               100325	//子系统签到/签出日志表插入错误
#define E_DB_SUBSYS_LOG_N               100326	//子系统签到/签出日志表查询相关无记录
#define E_DB_SUBSYS_LOG_R               100327	//子系统签到/签出日志表读取错误
#define E_DB_SUBSYS_LOG_U               100328	//子系统签到/签出日志表修改错误
#define E_DB_SYSKEY_D                   100329	//序号控制表删除错误
#define E_DB_SYSKEY_I                   100330	//序号控制表插入错误
#define E_DB_SYSKEY_N                   100331	//序号控制表无相关记录
#define E_DB_SYSKEY_R                   100332	//序号控制表读取错误
#define E_DB_SYSKEY_U                   100333	//序号控制表更新错误
#define E_DB_SYSPARA_D                  100334	//系统参数表删除错误
#define E_DB_SYSPARA_I                  100335	//系统参数表插入错误
#define E_DB_SYSPARA_N                  100336	//系统参数表无相关记录
#define E_DB_SYSPARA_R                  100337	//系统参数表读取错误
#define E_DB_SYSPARA_U                  100338	//系统参数表更新错误
#define E_DB_SYSSTATE_D                 100339	//监控系统状态异常表删除错误
#define E_DB_SYSSTATE_I                 100340	//监控系统状态异常表插入错误
#define E_DB_SYSSTATE_N                 100341	//监控系统状态异常表无相关记录
#define E_DB_SYSSTATE_R                 100342	//监控系统状态异常表查询错误
#define E_DB_SYSSTATE_U                 100343	//监控系统状态异常表更新错误
#define E_DB_SYSTIME_D                  100344	//系统时间表删除错误
#define E_DB_SYSTIME_I                  100345	//系统时间表插入错误
#define E_DB_SYSTIME_N                  100346	//系统时间表无相关记录
#define E_DB_SYSTIME_R                  100347	//系统时间表查询错误
#define E_DB_SYSTIME_U                  100348	//系统时间表更新错误
#define E_DB_TABLE_DBCARD_D             100349	//卡库不平报表删除错误
#define E_DB_TABLE_DBCARD_I             100350	//卡库不平报表插入错误
#define E_DB_TABLE_DBCARD_N             100351	//卡库不平报表无相关记录
#define E_DB_TABLE_DBCARD_R             100352	//卡库不平报表读错误
#define E_DB_TABLE_DBCARD_U             100353	//卡库不平报表更新错误
#define E_DB_TABLE_ERRACC_D             100354	//对帐不符报表删除错误
#define E_DB_TABLE_ERRACC_I             100355	//对帐不符报表插入错误
#define E_DB_TABLE_ERRACC_N             100356	//对帐不符报表无相关记录
#define E_DB_TABLE_ERRACC_R             100357	//对帐不符报表读错误
#define E_DB_TABLE_ERRACC_U             100358	//对帐不符报表更新错误
#define E_DB_TRADEACT_D                 100359	//分录配置表删除错误
#define E_DB_TRADEACT_I                 100360	//分录配置表插入错误
#define E_DB_TRADEACT_N                 100361	//分录配置表无相关记录
#define E_DB_TRADEACT_R                 100362	//分录配置表读取错误
#define E_DB_TRADEACT_U                 100363	//分录配置表更新错误
#define E_DB_TRADELOG_BAK_D             100364	//交易明细表归档删除错误
#define E_DB_TRADELOG_BAK_I             100365	//交易明细表归档插入错误
#define E_DB_TRADELOG_D                 100366	//交易明细表删除错误
#define E_DB_TRADELOG_I                 100367	//交易明细表插入错误
#define E_DB_TRADELOG_N                 100368	//交易明细表无相关记录
#define E_DB_TRADELOG_R                 100369	//交易明细表查询错误
#define E_DB_TRADELOG_U                 100370	//交易明细表更新错误
#define E_DB_TRADESERIALERROR_D         100371	//监控异常消费流水表删除错误
#define E_DB_TRADESERIALERROR_I         100372	//监控异常消费流水表插入错误
#define E_DB_TRADESERIALERROR_N         100373	//监控异常消费流水表无相关记录
#define E_DB_TRADESERIALERROR_R         100374	//监控异常消费流水表查询错误
#define E_DB_TRADESERIALERROR_U         100375	//监控异常消费流水表更新错误
#define E_DB_TRADESERIAL_D              100376	//流水数据表删除错误
#define E_DB_TRADESERIAL_I              100377	//流水数据表插入错误
#define E_DB_TRADESERIAL_N              100378	//流水数据表无相关记录
#define E_DB_TRADESERIAL_R              100379	//流水数据表查询错误
#define E_DB_TRADESERIAL_U              100380	//流水数据表更新错误
#define E_DB_TRANSFER_LOG_BAK_D         100381	//转帐流水表归档删除错误
#define E_DB_TRANSFER_LOG_BAK_I         100382	//转帐流水表归档插入错误
#define E_DB_TRANSFER_LOG_BAK_U         100383	//转帐流水表归档更新错误
#define E_DB_TRANSFER_LOG_D             100384	//转帐流水表删除错误
#define E_DB_TRANSFER_LOG_I             100385	//转帐流水表插入错误
#define E_DB_TRANSFER_LOG_N             100386	//转帐流水表无相关记录
#define E_DB_TRANSFER_LOG_R             100387	//转帐流水表读取错误
#define E_DB_TRANSFER_LOG_U             100388	//转帐流水表更新错误
#define E_DB_TRAN_D                     100389	//监控异常转账流水表删除错误
#define E_DB_TRAN_I                     100390	//监控异常转账流水表插入错误
#define E_DB_TRAN_N                     100391	//监控异常转账流水表无相关记录
#define E_DB_TRAN_R                     100392	//监控异常转账流水表查询错误
#define E_DB_TRAN_U                     100393	//监控异常转账流水表更新错误
#define E_DB_T_REPORT_BANK_TRANSFER_D   100394	//银行划拨表删除错误
#define E_DB_T_REPORT_BANK_TRANSFER_I   100395	//银行划拨表插入错误
#define E_DB_T_REPORT_BANK_TRANSFER_N   100396	//银行划拨表无相关记录
#define E_DB_T_REPORT_BANK_TRANSFER_R   100397	//银行划拨表读取错误
#define E_DB_T_REPORT_BANK_TRANSFER_U   100398	//银行划拨表更新错误
#define E_DB_T_REPORT_OPER_D            100399	//操作情况表删除错误
#define E_DB_T_REPORT_OPER_I            100400	//操作情况表插入错误
#define E_DB_T_REPORT_OPER_N            100401	//操作情况表无相关记录
#define E_DB_T_REPORT_OPER_R            100402	//操作情况表读取错误
#define E_DB_T_REPORT_OPER_U            100403	//操作情况表更新错误
#define E_DB_T_REPORT_RICH_DEBT_D       100404	//资产负债表删除错误
#define E_DB_T_REPORT_RICH_DEBT_I       100405	//资产负债表插入错误
#define E_DB_T_REPORT_RICH_DEBT_N       100406	//资产负债表无相关记录
#define E_DB_T_REPORT_RICH_DEBT_R       100407	//资产负债表读取错误
#define E_DB_T_REPORT_RICH_DEBT_U       100408	//资产负债表更新错误
#define E_DB_T_REPORT_SHOP_BALANCE_D    100409	//商户结算表删除错误
#define E_DB_T_REPORT_SHOP_BALANCE_I    100410	//商户结算表插入错误
#define E_DB_T_REPORT_SHOP_BALANCE_N    100411	//商户结算表无相关记录
#define E_DB_T_REPORT_SHOP_BALANCE_R    100412	//商户结算表读取错误
#define E_DB_T_REPORT_SHOP_BALANCE_U    100413	//商户结算表更新错误
#define E_DB_T_REPORT_TRANS_COMP_D      100414	//转账对帐表删除错误
#define E_DB_T_REPORT_TRANS_COMP_I      100415	//转账对帐表插入错误
#define E_DB_T_REPORT_TRANS_COMP_N      100416	//转账对帐表无相关记录
#define E_DB_T_REPORT_TRANS_COMP_R      100417	//转账对帐表读取错误
#define E_DB_T_REPORT_TRANS_COMP_U      100418	//转账对帐表更新错误
#define E_DB_T_TRANSFER_LOG_D           100419	//转帐流水表删除错误
#define E_DB_T_TRANSFER_LOG_I           100420	//转帐流水表插入错误
#define E_DB_T_TRANSFER_LOG_N           100421	//转帐流水表无相关记录
#define E_DB_T_TRANSFER_LOG_R           100422	//转帐流水表读取错误
#define E_DB_T_TRANSFER_LOG_U           100423	//转帐流水表更新错误
#define E_DB_VIEW_DBCARD_D              100424	//卡库不平视图删除错误
#define E_DB_VIEW_DBCARD_I              100425	//卡库不平视图插入错误
#define E_DB_VIEW_DBCARD_N              100426	//卡库不平视图没有记录
#define E_DB_VIEW_DBCARD_R              100427	//卡库不平视图读错误
#define E_DB_VIEW_DBCARD_U              100428	//卡库不平视图更新错误
#define E_DB_VIEW_ERRACC_D              100429	//对帐不符视图删除错误
#define E_DB_VIEW_ERRACC_I              100430	//对帐不符视图插入错误
#define E_DB_VIEW_ERRACC_N              100431	//对帐不符视图无相关记录
#define E_DB_VIEW_ERRACC_R              100432	//对帐不符视图读错误
#define E_DB_VIEW_ERRACC_U              100433	//对帐不符视图更新错误
#define E_DB_VIEW_TOTALACC_N            100434	//总帐视图无相关记录
#define E_DB_VIEW_TOTALACC_R            100435	//总帐视图读错误
#define E_DB_V_REPORT_BANK_TRANSFER_D   100436	//银行划拨视图删除错误
#define E_DB_V_REPORT_BANK_TRANSFER_I   100437	//银行划拨视图插入错误
#define E_DB_V_REPORT_BANK_TRANSFER_N   100438	//银行划拨视图无相关记录
#define E_DB_V_REPORT_BANK_TRANSFER_R   100439	//银行划拨视图读取错误
#define E_DB_V_REPORT_BANK_TRANSFER_U   100440	//银行划拨视图更新错误
#define E_DB_V_REPORT_OPER_D            100441	//操作情况视图删除错误
#define E_DB_V_REPORT_OPER_I            100442	//操作情况视图插入错误
#define E_DB_V_REPORT_OPER_N            100443	//操作情况视图无相关记录
#define E_DB_V_REPORT_OPER_R            100444	//操作情况视图读取错误
#define E_DB_V_REPORT_OPER_U            100445	//操作情况视图更新错误
#define E_DB_V_REPORT_RICH_DEBT_D       100446	//资产负债视图删除错误
#define E_DB_V_REPORT_RICH_DEBT_I       100447	//资产负债视图插入错误
#define E_DB_V_REPORT_RICH_DEBT_N       100448	//资产负债视图无相关记录
#define E_DB_V_REPORT_RICH_DEBT_R       100449	//资产负债视图读取错误
#define E_DB_V_REPORT_RICH_DEBT_U       100450	//资产负债视图更新错误
#define E_DB_V_REPORT_SHOP_BALANCE_D    100451	//商户结算视图删除错误
#define E_DB_V_REPORT_SHOP_BALANCE_I    100452	//商户结算视图插入错误
#define E_DB_V_REPORT_SHOP_BALANCE_N    100453	//商户结算视图无相关记录
#define E_DB_V_REPORT_SHOP_BALANCE_R    100454	//商户结算视图读取错误
#define E_DB_V_REPORT_SHOP_BALANCE_U    100455	//商户结算视图更新错误
#define E_DB_V_REPORT_TRANS_COMP_D      100456	//转账对帐视图删除错误
#define E_DB_V_REPORT_TRANS_COMP_I      100457	//转账对帐视图插入错误
#define E_DB_V_REPORT_TRANS_COMP_N      100458	//转账对帐视图无相关记录
#define E_DB_V_REPORT_TRANS_COMP_R      100459	//转账对帐视图读取错误
#define E_DB_V_REPORT_TRANS_COMP_U      100460	//转账对帐视图更新错误
#define E_DB_WARRANT_D                  100461	//凭证表删除错误
#define E_DB_WARRANT_I                  100462	//凭证表插入错误
#define E_DB_WARRANT_N                  100463	//凭证表无相关记录
#define E_DB_WARRANT_R                  100464	//凭证表读取错误
#define E_DB_WARRANT_U                  100465	//凭证表更新错误
#define E_DB_WATCH_LOG_BAK_D            100466	//巡更流水表归档删除错误
#define E_DB_WATCH_LOG_BAK_I            100467	//巡更流水表归档插入错误
#define E_DB_WATCH_LOG_BAK_U            100468	//巡更流水表归档更新错误
#define E_DEPT_HAVE_CHILDREN            100469	//该单位有下级单位故不能删除
#define E_ENTER_ACCOUNT                 100470	//入帐失败
#define E_ERROR_DATE                    100471	// 日期转换失败
#define E_ERROR_ENDDATE                 100472	// 终结日期转换失败
#define E_ERROR_INIDATE                 100473	// 初始日期转换失败
#define E_ERROR_IN_COMM_WITH_BANK       100474	//与银行通信错误
#define E_ERROR_WHEN_RECORDING_ACCOUNT  100475	//记会计分录时出错
#define E_FAT_SHP_ID_NOT_EXIST          100477	//父商户不存在
#define E_FEERATIO_TOO_HIGH             100478	//搭伙费比率太高
#define E_FEETYPE_NOT_EXIST             100479	//不存在该收费方式
#define E_FUNC_SET_NO_DEF               100503	//操作员的权限集合中没有该模块的定义
#define E_GETAVAILABILITY               100504	//发行正式卡时获得卡的有效期错误
#define E_GETAVAILABILITY_TEMP          100505	//发行临时卡时获得卡的有效期错误
#define E_GET_DYNAKEY                   100506	//取动态密钥错误
#define E_GET_INITKEY                   100507	//取初始密钥错误
#define E_GET_READCARDKEY               100508	//取得读卡密钥错误
#define E_INPUT_DATA_INVAILD            100509	//输入数据有误
#define E_INPUT_NODATE                  100510	//日期为空
#define E_INPUT_NOENDTIME               100511	//结束时间为空
#define E_INPUT_NOFUNCNO                100512	//输入的功能号为空
#define E_INPUT_NOOPERATOR              100513	//操作员代码为空
#define E_INPUT_NOSTARTTIME             100514	//起始时间为空
#define E_JOIN_SHARE_MEMORY             100515	//关联共享内存失败
#define E_LOGINTOBANK_FAIL              100516	//系统登陆到银行失败
#define E_LOGINTOBANK_NO                100517	//系统未登陆到银行
#define E_MAC_FAIL                      100518	//MAC校验错误
#define E_NO_APP_DEFINE                 100519	//系统中没有该应用程序的定义
#define E_NO_BANK_CARD_INFO             100520	//该卡并未绑定银行卡,请于发卡中心联系
#define E_NO_SUCH_CARD                  100521	//无效的卡信息,无此校园卡
#define E_NO_THIS_SYMBOL                100522	//没有这个功能标志
#define E_OPER_LOGIN_LIMIT              100523	//无登陆此站点权限
#define E_OPER_LOGIN_RE                 100524	//此操作员已登陆
#define E_OPER_NO_MODULE_RIGHT          100525	//此操作员没有登陆此模板的权限
#define E_PASSWORD_WRONG                100526	//操作员登陆密码错误
#define E_PATCH_CARD                    100527	//补办卡错误,该客户不允许补办卡
#define E_PERSON_ACC                    100528	//核对个人帐务不平
#define E_PUBLISH_CARD                  100529	//发行正式卡错误,该客户已经发行过卡
#define E_PUBLISH_TEMPCARD              100530	//发行临时卡错误,该客户不允许发行临时卡
#define E_REC_ACCOUNT                   100531	//记会计分录出错
#define E_SEARCH_FLAG                   100532	//读全局结帐标志出错
#define E_SERIALNO_NOT_EXIST            100533	//流水号不存在
#define E_SHOP_HAVE_CHILDREN            100534	//该商户有下级商户故不能删除
#define E_SHP_ID_NOT_EXIST              100535	//商户号不存在
#define E_SITE_ALREADY_LOGIN            100536	//已有操作员绑定此站点故无法删除
#define E_SUBSYSREQUESTINVALID          100537	//子系统请求为非法,动态密钥或子系统标识不正确
#define E_SUBSYSTEM_RELOGIN             100538	//子系统的IP或网卡地址不能重复
#define E_TIMESTAMP_FMT                 100539	//时间戳格式不正确
#define E_TIME_FMT                      100540	//时间格式不正确
#define E_TOTAL_ACC                     100541	//核对总账不平
#define E_TRADE_DETAIL_EXIST            100542	//交易流水已存在
#define E_WHEN_SEARCH_CARD              100543	//查寻卡信息表出错
#define E_XML_KEY_NOTFOUND              100544	//XML标记没找到
#define E_CARD_ACC_NO_EQ			100545	//卡上余额与账户余额不等
#define E_DB_ACCOUNT_E			100546		//账户表记录重复
#define E_DB_TRADESERIAL_E		100547		//流水表记录重复
#define E_DEPOSIT_FEE			100548		//押金金额错误
#define E_COST_FEE				100549		//卡成本费金额错误
#define E_IN_FEE					100550		//管理费金额错误
#define E_CUSTOMER_NOT_EXIST 	100551		//客户号不存在
#define E_CARDNOFREEZE				100552		//非正常卡状态,不能做解冻操作
#define E_CUSTOMER_LOGOUT			100553		//该客户已注销
#define E_ACTNO_EXIST				100554		//账户已存在
#define E_CASH_LACK					100555		//该交易现金不足
#define E_CARD_PUBLISHED			100556		//该卡已经发行使用
#define E_CUSTOMER_HAVE_CARD		100557		//该客户已经发行过卡
#define E_DB_CARD_E					100558		//卡信息表记录重复
#define E_NORMALCARD_NOLOST		100559		//该客户正式卡未挂失,不能办临时卡
#define E_TEMPCARD_NOLOST			100560		//该客户有一张临时卡可正常使用,不能再办临时卡
#define E_NORMALCARD_NOT_REACH_ENDDATE		100561		//该卡挂失后未到补办正式卡的日期
#define E_CARD_TYPE_NOT_EXIST		100562		//卡类型不存在
#define E_TMPCARDNO_NOT_EXIST	100563			//临时卡号不存在
#define E_DB_TRADECODE_D            100564		//交易代码删除错误
#define E_DB_TRADECODE_I            100565		//交易代码插入错误
#define E_DB_TRADECODE_N            100566		//交易代码无相关记录
#define E_DB_TRADECODE_R            100567		//交易代码读取错误
#define E_DB_TRADECODE_U            100568		//交易代码更新错误
#define E_SUBSYSTEM_DELSTATE    100569		//子系统状态不为预注册、注册或签出，不能删除
#define E_TMPCARDNO_DIFFER	100570			//临时卡卡号不符
#define E_CARDNO_DIFFER		100571			//正式卡卡号不符
#define E_ACTNO_LOGOUT			100572			//账户已经注销
#define E_TMPCARD_NOT_REACH_ENDDATE		100573		//临时卡挂失后未到补办正式卡的日期
#define E_INPUT_CARDNO_CANNOT_NULL		100574		//输入的卡号不能为空
#define E_INPUT_CARDNO						100575		//卡号输入错误
#define E_INPUT_SERIALNO					100576		//流水号输入错误
#define E_CARDNO_LOGOUT					100577		//该卡已经注销
#define E_CARDNO_NOLOST					100578		//该卡没有挂失
#define E_FIRST_DEAL_TMPCARD				100579		//请先办理该客户临时卡的退卡手续
#define E_CARD_PHYNO_DIFFER				100580		//卡物理ID不符
#define E_CARDNO_FREEZE					100581		//该卡已经被冻结
#define E_CARDNO_NOFREEZE					100582		//该卡没有冻结
#define E_CARDNO_WFAIL						100583		//该卡上次交易中写卡失败，请先补写卡才能交易
#define E_SHOP_HAVE_DEVICE					100584		//该商户有相关设备未删除
#define E_BACK_CARD_FOR_NORCARD			100585		//该客户存在正常使用的临时卡,请退回临时卡,才能解挂
#define E_BACK_CARD_FOR_TMPCARD			100586		//该客户存在正常使用的临时卡,该卡不能解挂,请办理退卡交易
#define E_BACK_CARD_FOR_NORCARD2			100587		//该客户存在正常使用的正式卡,该卡不能解挂,请办理退卡交易
#define E_CARD_PWD_DIFFER					100588		//卡密码不符
#define E_CUTTYPE_IN_USE					100589		//该客户类别已经在使用,不可以直接删除
#define E_AMT_EXCEED_MAX					100590		//充值金额超过最大额度
#define E_DEV_WORK_TIME_CONFLICT			100591		//该设备的不同科目的不同工作时间段之间的时间间隔必须大于10分钟以上
#define E_DB_SHOP_POS_LOG_E				100592		//商户设备临时表记录重复
#define E_SHOP_HAVE_SUB_NODE				100593		//该商户有下级商户,不能删除
#define E_SHP_ACC_NO_RECKONING			100594		//该商户当前帐户有资金未结算
#define E_EXIST_SAME_SHOP_NAME			100595		//存在同名的商户名称,请换个商户名称
#define E_PWD_NULL							100596		//密码不能空
#define E_PWD_LEN							100597		//密码位数不正确,,请输入6位密码
#define E_DEVICE_DELSTATE            			100598		//设备状态不为注册或签出,不能删除
#define E_SUBSYS_LOGONIPMAC            		100599		//前置机注册中IP/MAC不能为空
#define E_SUBSYS_DELDEVICE 	           		100600		//该子系统的下级设备没有全部注销,需要先注销其下级设备
#define E_DEVICE_SUBDEV	 	           		100601		//该设备的下级设备没有全部注销,需要先注销其下级设备
#define E_DEVICE_DEVSHOP	 	           		100602		//该设备已被分配给了某个商户,需要先删除设备与商户的对应关系
#define E_AREA_DEL			 	           		100603		//该区域有下级节点,不能删除,应先删除其下级节点
#define E_OPERLOGON_UNREG	 	           		100604		//操作员已经注销,不能登陆
#define E_DB_SITE_INFO_NETRE                		100605		//该站点的名称或IP或MAC地址已经存在,不能重复
#define E_DB_DEVICE_RE                			100606		//设备名称或设备物理ID或设备IP重复
#define E_AREA_RENAME	                			100607		//区域名称不能重复
#define E_SUBSYSTEM_NOT_EXIST				100608		//该前置机系统不存在
#define E_DYN_KEY_DIFFER					100609		//动态密钥错误
#define E_DEVPHYID_NULL					100610		//终端设备物理ID不能为空
#define E_DB_RCVDTL_D						100611		//消费来帐流水表删除错误
#define E_DB_RCVDTL_E						100612		//消费来帐流水表记录重复
#define E_DB_RCVDTL_N						100613		//消费来帐流水表无相关记录
#define E_DB_RCVDTL_R						100614		//消费来帐流水表读取错误
#define E_DB_RCVDTL_U						100615		//消费来帐流水表更新错误
#define E_DB_DBCONN						100616		//数据库连接失败
#define E_DB_DICINVALID						100617		//不能对小于2000的数据字典大项进行编辑
#define E_FE_REGIST                                           100618          	//该前置机已经注册
#define E_IP_MAC_NO_MATCH               			100619  		//IP或网卡地址不匹配
#define E_SYSNAME_SAME						100620  		//子系统名称不能重复
#define E_DEVICE_NOT_EXIST					100621		//本系统中没有此设备
#define E_VALIDDATE_TOO_SHORT				100622		//客户类别表中该类别客户有效期参数设置太短
#define E_DEV_NOT_IN_WORKTIME				100623		//设备不在工作时间
#define E_EIME_MUST_GT_BTIME				100624		//结束时间必须大于起始时间
#define E_EDATE_MUST_GE_BDATE			100625		//结束日期必须大于等于起始日期
#define E_DB_PHOTO_D                     			100626		//照片表删除错误
#define E_DB_PHOTO_I                    			100627		//照片表插入错误
#define E_DB_PHOTO_N                     			100628		//照片表无相关记录
#define E_DB_PHOTO_R                     			100629		//照片表查询错误
#define E_DB_PHOTO_U                     			100630		//照片表更新错误
#define E_DB_STUEMPNO_RE                     		100631		//学工号不能重复
#define E_SUBSYSTEM_OFFLINE				100632		//前置机未联机,与设备无法通讯
#define E_TXCODE_NOT_EXIST					100633		//交易码错误
#define E_DEV_SUBSYS						100634		//该设备与上级父设备所属子系统不相同
#define E_INPUT_CARDPHYID					100635		//输入的卡物理ID有误
#define E_SYNCCUT_RUN						100636		//客户同步程序正在运行
#define E_DEV_LPORT							100637		//设备的上级设备只能是机型代码为"服务器"的LPORT或根节点
#define E_TX_SERIAL_CZ						100638		//该交易已经冲正,不能重复冲正
#define E_TX_SERIAL_CANNOT_CZ				100639		//该交易不能冲正
#define E_CARDNO_SERIAL_NE					100640		//卡号与流水中卡号不符
#define E_TX_CANNOT_DEAL					100641		//该交易流水不能执行该交易
#define E_SHOP_ACTNO_NOT_EXIST			100642		//商户帐户不存在
#define E_CARD_ACTNO_NOT_EXIST			100643		//持卡人帐户不存在
#define E_DB_V_BLKLST_R              				100644		//黑名单视图查询错误
#define E_DB_CURSOR_DECLARE				100645		//游标声明失败,请检查SQL语句语法
#define E_DB_CURSOR_OPEN					100646		//游标打开出错
#define E_DB_CURSOR_FETCH					100647		//游标FETCH  出错
#define E_DB_CURSOR_CLOSE					100648		//游标关闭 出错
#define E_STUNO_NOT_EXIST					100649		//学/工号不存在
#define E_INPUT_SHOWCARDNO				100650		//显示卡号输入有误
#define E_SHOWCARDNO_EXIST				100651		//显示卡号已存在
#define E_OPER_NOT_EXIST					100652		//操作员不存在
#define E_AUTH_OPER_NOT_EXIST				100653		//授权操作员不存在
#define E_OPER_AND_AUTH_OPER_EQ			100654		//授权操作员不能和当前操作员相同
#define E_AUTH_OPER_PWD					100655		//授权操作员密码错
#define E_TX_SERIAL							100656		//交易流水有误,请核对流水
#define E_DB_SAVDTL_I                     			100657		//充值明细记录表插入错误
#define E_DB_SAVDTL_E                     			100658		//充值明细记录表记录重复
#define E_DB_SAVDTL_N                     			100659		//充值明细记录表无相关记录
#define E_DB_SAVDTL_R                     			100660		//充值明细记录表读取错误
#define E_DB_SAVDTL_U                     			100661		//充值明细记录表更新错误
#define E_DB_SAVDTL_D                     			100662		//充值明细记录表删除错误
#define E_INPUT_SHOWID						100663		//显示卡号输入有误
#define E_INPUT_AMT							100664		//金额输入有误
#define E_CUTTYPE_CANNOT_DO				100665		//该客户的类别不能做该交易
#define E_INPUT_DATE						100666		//日期输入有误
#define E_INPUT_TIME						100667		//时间输入有误
#define E_BEYOND_MAXNUM_TRADECODE		100668		//交易码配置超过最大数
#define E_BEYOND_MAXNUM_SPLITCFG			100669		//分录配置超过最大数
#define E_BEYOND_MAXNUM_SUBJECT			100670		//科目配置超过最大数
#define E_BEYOND_MAXNUM_CFGIDX			100671		//索引配置超过最大数
#define E_TXCODE_NOT_CONFIG				100672		//交易码分录未配置
#define E_SPLIT_CFG							100673		//分录配置有误
#define E_DB_CFGSPLIT_N                     		100674		//分录配置表无相关记录
#define E_DB_CFGSPLIT_R                     			100675		//分录配置表查询错误
#define E_DB_CFGIDX_N                     			100676		//索引配置表无相关记录
#define E_DB_CFGIDX_R                     			100677		//索引配置表查询错误
#define E_DB_CFGTXFEE_N                     		100678		//收费配置表无相关记录
#define E_DB_CFGTXFEE_R                     		100679		//收费配置表查询错误
#define E_DB_SUBUPDATE_I				100680			//子系统更新名单表插入错误
#define E_DB_SUBUPDATE_E				100681			//子系统更新名单表记录重复
#define E_DB_SUBUPDATE_N				100682			//子系统更新名单表无相关记录
#define E_DB_SUBUPDATE_R				100683			//子系统更新名单表读取错误
#define E_DB_SUBUPDATE_U				100684			//子系统更新名单表更新错误
#define E_DB_SUBUPDATE_D				100685			//子系统更新名单表删除错误
#define E_EXP_NOT_CFG					100686			//表达式未配置
#define E_EXP_CFG						100687			//表达式配置错误
#define E_ACTNO_IDX_NOT_CFG			100688			//账号索引未配置
#define E_ACTNO_IDX_CFG				100689			//账号索引配置错误
#define E_DB_FEETYPE_N					100690			//收费类别表无相关记录
#define E_DB_FEETYPE_R					100691			//收费类别表读取错误
#define E_CUSTOMER_NO_FEE_TYPE		100692			//该客户没有收费类别
#define E_DB_SPEFEE_I					100693			//特殊收费参数表插入错误
#define E_DB_SPEFEE_U					100694			//特殊收费参数表更新错误
#define E_DB_SPEFEE_R					100695			//特殊收费参数表读取错误
#define E_DB_SPEFEE_D					100696			//特殊收费参数表删除错误
#define E_DB_SPEFEE_N					100697			//特殊收费参数表无相关记录
#define E_DB_SPEFEE_E					100698			//特殊收费参数表记录已存在
#define E_CUSTOMER_NO_RIGHT			100699			//该客户没有权限进行本项交易
#define E_INPUT_CARD_TXCNT				100700			//卡交易次数输入有误
#define E_INPUT_CARD_BALA				100701			//卡上余额输入有误
#define E_CARD_CHANGE					100702			//该卡换卡时写卡失败,请先换卡
#define E_OLDCARDINFO_NOSAVE			100703			//原卡信息未保存,不能换卡
#define E_CARD_TXCNT					100704			//数据库中卡交易次数有误
#define E_CARD_BALA						100705			//数据库中卡余额有误
#define E_DB_CUSTOMER_TMP_R			100706			//客户信息临时表读取错误
#define E_DB_CUSTOMER_TMP_I			100707			//客户信息临时表插入错误
#define E_DB_CUSTOMER_TMP_U			100708			//客户信息临时表更新错误
#define E_DB_CUSTOMER_TMP_D			100709			//客户信息临时表删除错误
#define E_DB_CUSTOMER_TMP_E			100710			//客户信息临时表记录已存在
#define E_DB_CUSTOMER_TMP_N			100711			//客户信息临时表无相关记录
#define E_INPUT_BATCH_NO				100712			//导入批次号输入有误
#define E_BLACKLIST_VERSION_DIFF		100713			//版本号不匹配
#define E_BLACKLIST_VERSION			100714			//版本号错误
#define E_NOCARD						100715			//无卡,不能交易
#define E_AMT_LACK						100716			//该交易金额不足,无法办理
#define E_EXIST_FREEZE_CARD			100717			//该客户有卡被冻结,不能补办新卡
#define E_INPUT_AUTH_OPER_NULL		100718			//请先输入授权操作员和密码
#define E_CARD_STATE_NOT_CHANGE          100719			//卡状态不是换卡未成功状态
#define E_DB_DIFF_TRANSFER_R			100720			//转帐对帐表读取错误
#define E_DB_DIFF_TRANSFER_I			100721			//转帐对帐插入错误
#define E_DB_DIFF_TRANSFER_U			100722			//转帐对帐表更新错误
#define E_DB_DIFF_TRANSFER_D			100723			//转帐对帐表删除错误
#define E_DB_DIFF_TRANSFER_E			100724			//转帐对帐表记录已存在
#define E_DB_DIFF_TRANSFER_N			100725			//转帐对帐表无相关记录
#define E_INPUT_BILLNO					100732			//票据号码输入有误
#define E_DB_CUTINFO_UPD_R			100741			// 客户信息更新表读取错误
#define E_DB_CUTINFO_UPD_I				100742			// 客户信息更新表接入错误
#define E_DB_CUTINFO_UPD_U			100743			// 客户信息更新表更新错误
#define E_DB_CUTINFO_UPD_D			100744			// 客户信息更新表删除错误
#define E_DB_CUTINFO_UPD_E			100745			// 客户信息更新表数据已存在
#define E_DB_CUTINFO_UPD_N			100746			// 客户信息更新表无相关记录
#define E_INPUT_GROUP_NAME			100747			//组的名称输入有误
#define E_MSG_ID_NULL					100748			//消息ID不能为空
#define E_MSG_ID_NOT_EXIST				100749			//消息ID不存在
#define E_FEE_CODE_SCOPE_ERR			100750			//收费科目范围不正确
#define E_NOT_SUPPORT_FEE_CODE		100751			//设备没有打开科目收费开关
#define E_DEVTYPE_NOT_JSP				100758			//该设备不是门禁设备
#define E_FEE_CODE_INUSE				100760			//该设备已经使用科目代码
#define E_CARDNO_CARDLIST_NOT_EXIST	100761			//门禁人员名单表中没有该卡号
#define E_RIGHT_ALREADY_ASSIGN		100762			//该操作员对该设备权限已经分配过
#define E_DB_PREPARE					100769			//查询SQL语法错误
#define E_OPER_NO_RIGHT_FOR_DEVICE	100770			//操作员对该设备没有管理权限
#define E_DB_CFGTXFEE_I                     	100771			//收费配置表无相关记录
#define E_DB_CFGTXFEE_D                     	100772			//收费配置表查询错误
#define E_DB_CFGTXFEE_E				100773      		//收费配置表记录重复
#define E_DB_FEETYPE_I					100774			//收费类别表插入错误
#define E_DB_FEETYPE_D					100775			//收费类别表删除错误
#define E_DB_FEETYPE_E					100776			//收费类别表记录已存在
#define E_DB_FEETYPE_U					100777			//收费类别表更新错误

#define E_DB_PHOTOTMP_R				100826			//照片临时表读取错误
#define E_DB_PHOTOTMP_I				100827			//照片临时表插入错误
#define E_DB_PHOTOTMP_U				100828			//照片临时表更新错误
#define E_DB_PHOTOTMP_D				100829			//照片临时表删除错误
#define E_DB_PHOTOTMP_E				100830			//照片临时表记录已存在
#define E_DB_PHOTOTMP_N				100831			//照片临时表无相关记录
#define E_SYS_CALL						100832			//系统调用失败
#define E_DYNAMIC_STMT_EXECUTE		100833			//执行动态语句失败
#define E_DB_SYS_UPDATE_R				100834			//子系统名单表读取错误
#define E_DB_SYS_UPDATE_I				100835			//子系统名单表插入错误
#define E_DB_SYS_UPDATE_U				100836			//子系统名单表更新错误
#define E_DB_SYS_UPDATE_D				100837			//子系统名单表删除错误
#define E_DB_SYS_UPDATE_E				100838			//子系统名单表记录已存在
#define E_DB_SYS_UPDATE_N				100839			//子系统名单表无相关记录
#define E_SUBSYS_FUNC_NOT_EXISTS		100840			//子系统功能不存在
#define E_INPUT_ACTNO_NULL				100841			//请输入帐号
#define E_INPUT_2ACTNO_EQ				100842			//两个输入的帐号不能相同
#define E_INPUT_OPER_PWD				100843			//输入的操作员密码错误
#define E_INPUT_OPER_NULL				100844			//请输入操作员号
#define E_INPUT_OPER_EXIST				100845			//输入的操作员不存在
#define E_INPUT_AMT_NULL				100846			//请输入金额
#define E_INPUT_2OPER_EQ				100847			//两个操作员号不能相同
#define E_TB_CUSTOMER_ENDTIME			100848			//客户信息表中该客户的预计毕业日期有误
#define E_TB_CUSTOMER_NO_ENDTIME 	100849			//客户信息表中该客户没有预计毕业日期,请手工输入卡的有效期
#define E_NO_NEXT_TRADE				100850			//没有下一笔流水,暂不处理
#define E_INPUT_DEPOSIT_TYPE			100851			//请输入有效的充值方式
#define E_DB_SUBSIDY_I					100852			//补助信息表插入错误
#define E_DB_SUBSIDY_U					100853			//补助信息表更新错误
#define E_DB_SUBSIDY_R					100854			//补助信息表读取错误
#define E_DB_SUBSIDY_D					100855			//补助信息表删除错误
#define E_DB_SUBSIDY_N					100856			//补助信息表无相关记录
#define E_DB_SUBSIDY_E					100857			//补助信息表记录已存在
#define E_DB_SUBSIDYTMP_I				100858			//补助信息临时表插入错误
#define E_DB_SUBSIDYTMP_U				100869			//补助信息临时表更新错误
#define E_DB_SUBSIDYTMP_R				100860			//补助信息临时表读取错误
#define E_DB_SUBSIDYTMP_D				100861			//补助信息临时表删除错误
#define E_DB_SUBSIDYTMP_N				100862			//补助信息临时表无相关记录
#define E_DB_SUBSIDYTMP_E				100863			//补助信息临时表记录已存在
#define E_INPUT_STUEMP_NO				100864			//学/工号输入有误
#define E_INPUT_SUMMARY				100865			//摘要内容不能为空
#define E_DB_DOOR_DEV_HAS_MORE_WT		100866			//门禁同一天还有未下传的时间段
#define E_DEVICE_PARAM_ERR				100867			//设备参数错误
#define E_USER_NO_SUBSIDY				100868			//没有补助可以领取
#define E_SHOP_IS_NOT_LEAF				100869			//商户不是叶子节点

#define E_DB_CONFDEV_I					100870			//会议设备表插入错误
#define E_DB_CONFDEV_U					100871			//会议设备表更新错误
#define E_DB_CONFDEV_R					100872			//会议设备表读取错误
#define E_DB_CONFDEV_D					100873			//会议设备表删除错误
#define E_DB_CONFDEV_N					100874			//会议设备表无相关记录
#define E_DB_CONFDEV_E					100875			//会议设备表记录已存在
#define E_DB_CONFATTLST_I					100876			//会议签到表插入错误
#define E_DB_CONFATTLST_U					100877			//会议签到表更新错误
#define E_DB_CONFATTLST_R					100878			//会议签到表读取错误
#define E_DB_CONFATTLST_D					100879			//会议签到表删除错误
#define E_DB_CONFATTLST_N					100880			//会议签到表无相关记录
#define E_DB_CONFATTLST_E					100882			//会议签到表记录已存在

//卡库不平处理错误码
#define E_NOT_REATH_CARDDB_NOBALA_TIMES		100883		//该账户卡库不平天数太短，不允许处理
#define E_INPUT_DATE_TIME_ERROR			100884			//请选择缺失的流水号进行补流水操作
#define E_FEETYPE_IN_USE					100885			//该收费类别已使用，不可以删除
#define E_DEPT_CODE_IN_USE					100886			//该部门代码已使用，不能删除
#define E_SPECIALITY_CODE_IN_USE			100887			//该专业代码已使用，不能删除
#define E_AREA_CODE_IN_USE				100886			//该区域代码已使用，不能删除
#define E_GLOBAL_PARAM_ERROR				110001			//系统参数错误

#define E_DB_TRADECODE_SHOP_I				110008			//交易代码商户信息表插入错误
#define E_DB_TRADECODE_SHOP_U			110009			//交易代码商户信息表更新错误
#define E_DB_TRADECODE_SHOP_R				110010			//交易代码商户信息表读取错误
#define E_DB_TRADECODE_SHOP_D			110011			//交易代码商户信息表删除错误
#define E_DB_TRADECODE_SHOP_N			110012			//交易代码商户信息表无相关记录
#define E_DB_TRADECODE_SHOP_E				110013			//交易代码商户信息表记录已存在
#define E_CARD_INFO_NOT_FOUND				100890			//无该卡相关信息
#define E_CARD_INFO_MUST_NEW_CARD			100891			//该卡只能新卡发行
#define E_CARD_INFO_MUST_SECOND_CARD		100892			//该卡只能补办卡发行
#define E_CARD_INFO_PHY_ID_DUP				100893			//该卡重复拍照
#define E_DB_WRITEFAILED_I                107001           //添加写卡失败表失败
#define E_DB_WRITEFAILED_R               107002           //读取写卡失败表失败
#define E_DB_WRITEFAILED_N               107003           //写卡失败表无相关记录
#define E_DB_WRITEFAILED_U               107004           //更新写卡失败表出错
#define E_WRITEFAILED_DEAL_FLAG_N         107008           //没有标记写卡失败钱包标志
#define E_CARD_REWRITE_REMAIN            107010           //此卡所有钱包并未有补写完成 
#define E_PACKET_LIMIT_EXCEED             106001           //小钱包余额超过限额
#define E_DB_DEVICE_IN_ACCOUNT            107020           //此设备采集金额已入帐
#define E_DB_DEVICE_COLLECT_LOG_I         107021           //插入设备采集表出错

#define E_DB_GROUP_I						100895			//操作员组表插入错误
#define E_DB_GROUP_U						100896			//操作员组表更新错误
#define E_DB_GROUP_R						100897			//操作员组表读取错误
#define E_DB_GROUP_D						100898			//操作员组表删除错误
#define E_DB_GROUP_N						100899			//操作员组表无相关记录
#define E_DB_GROUP_E						100900			//操作员组表记录已存在
#define E_DB_GROUP_DE						100901			//操作员组表存在已注销组
#define E_DB_OPER_GROUP_I					100902			//操作员分组表插入错误
#define E_DB_OPER_GROUP_U					100903			//操作员分组表更新错误
#define E_DB_OPER_GROUP_R					100904			//操作员分组表读取错误
#define E_DB_OPER_GROUP_D					100905			//操作员分组表删除错误
#define E_DB_OPER_GROUP_N					100906			//操作员分组表无相关记录
#define E_DB_OPER_GROUP_E					100907			//操作员分组表记录已存在
#define E_DB_OPER_GROUP_DE				100908			//操作员分组表存在已注销记录

#define E_OPER_HAS_MONEY					100909			//操作员账户还有余额,不能注销

#define E_DB_GRP_CASH_RPT_I				100910			//操作员组现金表插入错误
#define E_DB_GRP_CASH_RPT_U				100911			//操作员组现金表更新错误
#define E_DB_GRP_CASH_RPT_R				100912			//操作员组现金表读取错误
#define E_DB_GRP_CASH_RPT_D				100913			//操作员组现金表删除错误
#define E_DB_GRP_CASH_RPT_N				100914			//操作员组现金表无相关记录
#define E_DB_GRP_CASH_RPT_E				100915			//操作员组现金表记录已存在

#define E_DB_MEAL_TYPE_I					100916			//餐次表插入错误
#define E_DB_MEAL_TYPE_U					100917			//餐次表更新错误
#define E_DB_MEAL_TYPE_R					100918			//餐次表读取错误
#define E_DB_MEAL_TYPE_D					100919			//餐次表删除错误
#define E_DB_MEAL_TYPE_N					100920			//餐次表无相关记录
#define E_DB_MEAL_TYPE_E					100921			//餐次表记录已经存在

#define E_DB_SHOP_MEAL_I					100922			//商户餐次表插入错误
#define E_DB_SHOP_MEAL_U					100923			//商户餐次表更新错误
#define E_DB_SHOP_MEAL_R					100924			//商户餐次表读取错误
#define E_DB_SHOP_MEAL_D					100925			//商户餐次表删除错误
#define E_DB_SHOP_MEAL_N					100926			//商户餐次表无相关记录
#define E_DB_SHOP_MEAL_E					100927			//商户餐次表记录已经存在

#define E_DB_V_REPORT_DEVICE_MEAL_I		100928			//商户设备餐次视图插入错误
#define E_DB_V_REPORT_DEVICE_MEAL_U		100929			//商户设备餐次视图更新错误
#define E_DB_V_REPORT_DEVICE_MEAL_R		100930			//商户设备餐次视图读取错误
#define E_DB_V_REPORT_DEVICE_MEAL_D		100931			//商户设备餐次视图删除错误
#define E_DB_V_REPORT_DEVICE_MEAL_N		100932			//商户设备餐次视图无相关记录
#define E_DB_V_REPORT_DEVICE_MEAL_E		100933			//商户设备餐次视图记录已经存在

#define E_DB_T_REPORT_DEVICE_MEAL_I		100934			//商户设备餐次表插入错误
#define E_DB_T_REPORT_DEVICE_MEAL_U		100935			//商户设备餐次视图更新错误
#define E_DB_T_REPORT_DEVICE_MEAL_R		100936			//商户设备餐次视图读取错误
#define E_DB_T_REPORT_DEVICE_MEAL_D		100937			//商户设备餐次视图删除错误
#define E_DB_T_REPORT_DEVICE_MEAL_N		100938			//商户设备餐次视图无相关记录
#define E_DB_T_REPORT_DEVICE_MEAL_E		100939			//商户设备餐次视图记录已经存在

#define E_SHOP_MEAL_TYPE_CONFLICT			100940			//修改造成商户餐次分配有冲突
#define E_MEAL_TYPE_ID_NOFOUND			100941			//指定的餐次号不存在

#define E_DB_OPER_AUTHCARD_I				100942			//操作员授权卡表插入错误
#define E_DB_OPER_AUTHCARD_U				100943			//操作员授权卡更新错误
#define E_DB_OPER_AUTHCARD_R				100944			//操作员授权卡读取错误
#define E_DB_OPER_AUTHCARD_D				100945			//操作员授权卡删除错误
#define E_DB_OPER_AUTHCARD_N				100946			//操作员授权卡无相关记录
#define E_DB_OPER_AUTHCARD_E				100947			//操作员授权卡记录已经存在
#define E_AUTHCARD_NOT_EXISTS				100950			//授权卡不存在
#define E_AUTHCARD_HAS_CANCEL			100951			//授权卡已注销
#define E_AUTHCARD_IS_LOSS					100952			//授权卡已经挂失
#define E_OPER_ALREADY_HAS_AUTHCARD		100953			//操作员已经有授权卡
#define E_PHYSICAL_NO_IS_IN_USE			100954			//该卡已经被其他操作员使用

#define E_DB_CUT_RLTN_I				110015			//客户银行卡号绑定关系表插入错误
#define E_DB_CUT_RLTN_U				110016			//客户银行卡号绑定关系表更新错误
#define E_DB_CUT_RLTN_R				110017			//客户银行卡号绑定关系表读取错误
#define E_DB_CUT_RLTN_D				110018			//客户银行卡号绑定关系表删除错误
#define E_DB_CUT_RLTN_N				110019			//客户银行卡号绑定关系表无相关记录
#define E_DB_CUT_RLTN_E				110020			//客户银行卡号绑定关系表记录已存在
#define E_DB_CUT_RLTN_TMP_I				110021			//客户银行卡号绑定关系临时表插入错误
#define E_DB_CUT_RLTN_TMP_U				110022			//客户银行卡号绑定关系临时表更新错误
#define E_DB_CUT_RLTN_TMP_R				110023			//客户银行卡号绑定关系临时表读取错误
#define E_DB_CUT_RLTN_TMP_D				110024			//客户银行卡号绑定关系临时表删除错误
#define E_DB_CUT_RLTN_TMP_N				110025			//客户银行卡号绑定关系临时表无相关记录
#define E_DB_CUT_RLTN_TMP_E				110026			//客户银行卡号绑定关系临时表记录已存在

/////////////////////////////////////////////////////////////////////////////////
// 通用错误信息代码范围 190000 - 199999
#define E_CUSTOMER_HASNO_NORM_CARD		190001			//客户无正常卡
#define E_MES_GROUP_NOT_DEFINED			190002			//消息功能未定义组
#define E_SHOP_NOT_LEAF_GETFEE			190003			//非叶子节点不能收取搭伙费
//////////////////////////////////////////////////////////////////////////////
// 门禁类交易错误码范围 130000 - 139999

#define E_DB_DOOR_TIMESECT_I				130001			//门禁时间段表插入错误
#define E_DB_DOOR_TIMESECT_U				130002			//门禁时间段表更新错误
#define E_DB_DOOR_TIMESECT_R				130003			//门禁时间段表读取错误
#define E_DB_DOOR_TIMESECT_D				130004			//门禁时间段表删除错误
#define E_DB_DOOR_TIMESECT_N				130005			//门禁时间段表无相关记录
#define E_DB_DOOR_TIMESECT_E				130006			//门禁时间段表记录已存在
#define E_DB_DOOR_WEEKS_I					130007			//门禁时间段组表插入错误
#define E_DB_DOOR_WEEKS_U					130008			//门禁时间段组表更新错误
#define E_DB_DOOR_WEEKS_R					130009			//门禁时间段组表读取错误
#define E_DB_DOOR_WEEKS_D					130010			//门禁时间段组表删除错误
#define E_DB_DOOR_WEEKS_N					130011			//门禁时间段组表无相关记录
#define E_DB_DOOR_WEEKS_E					130012			//门禁时间段组表记录已存在
#define E_DOOR_WEEK_TIME_IDX				130013			//门禁时间段组时间段个数不正确
#define E_DOOR_WEEK_NO					130014			//门禁时间段组星期不正确
#define E_DB_DOOR_WEEK_TIMES_I			130015			//门禁时间段组设置表插入错误
#define E_DB_DOOR_WEEK_TIMES_U			130016			//门禁时间段组设置表更新错误
#define E_DB_DOOR_WEEK_TIMES_R			130017			//门禁时间段组设置表读取错误
#define E_DB_DOOR_WEEK_TIMES_D			130018			//门禁时间段组设置表删除错误
#define E_DB_DOOR_WEEK_TIMES_N			130019			//门禁时间段组设置表无相关记录
#define E_DB_DOOR_WEEK_TIMES_E			130020			//门禁时间段组设置表记录已存在
#define E_DB_DOOR_HOLIDAY_R			130021			//门禁节假日表读取错误
#define E_DB_DOOR_HOLIDAY_I			130022			//门禁节假日表插入错误
#define E_DB_DOOR_HOLIDAY_U			130023			//门禁节假日表更新错误
#define E_DB_DOOR_HOLIDAY_D			130024			//门禁节假日表删除错误
#define E_DB_DOOR_HOLIDAY_E			130025			//门禁节假日表记录已存在
#define E_DB_DOOR_HOLIDAY_N			130026			//门禁节假日表无相关记录
#define E_DOOR_HOLIDAY_MAX_FLAG		130027			//读取门禁节假日最大数参数错误
#define E_DOOR_HOLIDAY_EXCEED			130028			//门禁节假日个数超过最大值
#define E_DB_DOOR_HOLIDAY_TIME_R			130029			//门禁节假日时间段表读取错误
#define E_DB_DOOR_HOLIDAY_TIME_I			130030			//门禁节假日时间段表插入错误
#define E_DB_DOOR_HOLIDAY_TIME_U			130031			//门禁节假日时间段表更新错误
#define E_DB_DOOR_HOLIDAY_TIME_D			130032			//门禁节假日时间段表删除错误
#define E_DB_DOOR_HOLIDAY_TIME_E			130033			//门禁节假日时间段表记录已存在
#define E_DB_DOOR_HOLIDAY_TIME_N			130034			//门禁节假日时间段表无相关记录
#define E_DB_DOOR_GROUP_R				130035			//门禁组表读取错误
#define E_DB_DOOR_GROUP_I				130036			//门禁组表插入错误
#define E_DB_DOOR_GROUP_U				130037			//门禁组表更新错误
#define E_DB_DOOR_GROUP_D				130038			//门禁组表删除错误
#define E_DB_DOOR_GROUP_E				130039			//门禁组表记录已存在
#define E_DB_DOOR_GROUP_N				130040			//门禁组表无相关记录
#define E_OPER_NO_RIGHT_FOR_DOOR_GROUP 130041		//操作员无门禁组管理权限
#define E_DOOR_GROUP_IN_USE			130042			//门禁组已经使用
#define E_DB_DOOR_GROUP_MEMBER_R		130043			//门禁组设备表读取错误
#define E_DB_DOOR_GROUP_MEMBER_I		130044			//门禁组设备表插入错误
#define E_DB_DOOR_GROUP_MEMBER_U	130045			//门禁组设备表更新错误
#define E_DB_DOOR_GROUP_MEMBER_D	130046			//门禁组设备表删除错误
#define E_DB_DOOR_GROUP_MEMBER_E		130047			//门禁组设备表记录已存在
#define E_DB_DOOR_GROUP_MEMBER_N	130048			//门禁组设备表无相关记录
#define E_DOOR_WEEK_MUST_SET			130049			//门禁周必须设置时间段组
#define E_DB_DOOR_TIME_GROUP_R		130050			//门禁组设备表读取错误
#define E_DB_DOOR_TIME_GROUP_I		130051			//门禁组设备表插入错误
#define E_DB_DOOR_TIME_GROUP_U		130052			//门禁组设备表更新错误
#define E_DB_DOOR_TIME_GROUP_D		130053			//门禁组设备表删除错误
#define E_DB_DOOR_TIME_GROUP_E		130054			//门禁组设备表记录已存在
#define E_DB_DOOR_TIME_GROUP_N		130055			//门禁组设备表无相关记录
#define E_DOOR_GROUP_CANCEL			130056			//门禁组已被注销
#define E_DB_DOOR_OPER_RIGHT_R		130057			//门禁机权限表读取错误
#define E_DB_DOOR_OPER_RIGHT_I		130058			//门禁机权限表插入错误
#define E_DB_DOOR_OPER_RIGHT_U		130059			//门禁机权限表更新错误
#define E_DB_DOOR_OPER_RIGHT_D		130060			//门禁机权限表删除错误
#define E_DB_DOOR_OPER_RIGHT_E		130061			//门禁机权限表记录已存在
#define E_DB_DOOR_OPER_RIGHT_N		130062			//门禁机权限表无相关记录
#define E_DB_DOOR_GRP_OPER_RIGHT_R	130063			//门禁组权限表读取错误
#define E_DB_DOOR_GRP_OPER_RIGHT_I	130064			//门禁组权限表插入错误
#define E_DB_DOOR_GRP_OPER_RIGHT_U	130065			//门禁组权限表更新错误
#define E_DB_DOOR_GRP_OPER_RIGHT_D	130066			//门禁组权限表删除错误
#define E_DB_DOOR_GRP_OPER_RIGHT_E	130067			//门禁组权限表记录已存在
#define E_DB_DOOR_GRP_OPER_RIGHT_N	130068			//门禁组权限表无相关记录
#define E_DB_DOOR_CARDLIST_R			130069			//门禁机人员名单表读取错误
#define E_DB_DOOR_CARDLIST_I			130070			//门禁机人员名单表插入错误
#define E_DB_DOOR_CARDLIST_U			130071			//门禁机人员名单表更新错误
#define E_DB_DOOR_CARDLIST_D			130072			//门禁机人员名单表删除错误
#define E_DB_DOOR_CARDLIST_E			130073			//门禁机人员名单表记录已存在
#define E_DB_DOOR_CARDLIST_N			130074			//门禁机人员名单表无相关记录
#define E_DB_DOOR_DEV_WEEK_R			130075			//门禁设备工作周表读取错误
#define E_DB_DOOR_DEV_WEEK_I			130076			//门禁设备工作周表插入错误
#define E_DB_DOOR_DEV_WEEK_U			130077			//门禁设备工作周表更新错误
#define E_DB_DOOR_DEV_WEEK_D			130078			//门禁设备工作周表删除错误
#define E_DB_DOOR_DEV_WEEK_E			130079			//门禁设备工作周表记录已存在
#define E_DB_DOOR_DEV_WEEK_N			130080			//门禁设备工作周表无此记录
#define E_DOOR_DEV_WEEK_EXCEED		130081			//门禁设备工作周超过上限
#define E_DOOR_DEV_WEEK_IN_USE		130082			//门禁设备工作周段分配重复
#define E_DOOR_DEV_TIMESECT_EXCEED	130083			//门禁时间段超过上限
#define E_DB_DOOR_DEV_TMSC_R			130084			//门禁设备时间段表读取错误
#define E_DB_DOOR_DEV_TMSC_I			130085			//门禁设备时间段表插入错误
#define E_DB_DOOR_DEV_TMSC_U			130086			//门禁设备时间段表更新错误
#define E_DB_DOOR_DEV_TMSC_D			130087			//门禁设备时间段表删除错误
#define E_DB_DOOR_DEV_TMSC_E			130088			//门禁设备时间段表记录已存在
#define E_DB_DOOR_DEV_TMSC_N			130089			//门禁设备时间段表无此记录
#define E_DOOR_DEV_TIMESECT_INUSE  130090			//门禁时间段已经使用
#define E_DOOR_DEV_TIMEGROUP_EXCEED 130091		//门禁时间段组超过上限
#define E_DOOR_DEV_HOLIDAY_EXCEED	 130092			//门禁节假日超过上限
#define E_DOOR_DEV_TIMEGROUP_INUSE 130093			//门禁时间段组已使用
#define E_DOOR_DEV_HOLIDAY_INUSE	130094			//门禁节假日组已使用
#define E_DB_DOOR_DEV_TG_R			130095			//门禁设备时间段组表读取错误
#define E_DB_DOOR_DEV_TG_I			130096			//门禁设备时间段组表插入错误
#define E_DB_DOOR_DEV_TG_U			130097			//门禁设备时间段组表更新错误
#define E_DB_DOOR_DEV_TG_D			130098			//门禁设备时间段组表删除错误
#define E_DB_DOOR_DEV_TG_E			130099			//门禁设备时间段组表记录已存在
#define E_DB_DOOR_DEV_TG_N			130100			//门禁设备时间段组表无此记录
#define E_DB_DOOR_DEV_HLD_R			130101			//门禁机节假日表读取错误
#define E_DB_DOOR_DEV_HLD_I			130102			//门禁机节假日表插入错误
#define E_DB_DOOR_DEV_HLD_U			130103			//门禁机节假日表更新错误
#define E_DB_DOOR_DEV_HLD_D			130104			//门禁机节假日表删除错误
#define E_DB_DOOR_DEV_HLD_E			130105			//门禁机节假日表记录已存在
#define E_DB_DOOR_DEV_HLD_N			130106			//门禁机节假日表无相关记录
#define E_DB_DOOR_TXDTL_R				130107			//门禁流水表读取错误
#define E_DB_DOOR_TXDTL_I				130108			//门禁流水表插入错误
#define E_DB_DOOR_TXDTL_U				130109			//门禁流水表更新错误
#define E_DB_DOOR_TXDTL_D				130110			//门禁流水表删除错误
#define E_DB_DOOR_TXDTL_E				130111			//门禁流水表记录已存在
#define E_DB_DOOR_TXDTL_N				130112			//门禁流水表无相关记录
#define E_DB_DOOR_TXDTL_HIS_R			130113			//门禁历史流水读取错误
#define E_DB_DOOR_TXDTL_HIS_I			130114			//门禁历史流水插入错误
#define E_DB_DOOR_TXDTL_HIS_U			130115			//门禁历史流水更新错误
#define E_DB_DOOR_TXDTL_HIS_D			130116			//门禁历史流水删除错误
#define E_DB_DOOR_TXDTL_HIS_E			130117			//门禁历史流水记录已存在
#define E_DB_DOOR_TXDTL_HIS_N			130118			//门禁历史流水无相关记录
#define E_DB_DOOR_DEVICE_NO_RIGHT	130119			//操作员没有门禁访问权限
#define E_DB_DOOR_DEV_GRP_NO_RIGHT	130120			//操作员没有门禁组访问权限

#define E_INPUT_WEEK					100795			//输入星期不正确
#define E_INPUT_ERROR					100796			//输入数据不正确
#define E_INPUT_GROUP_ID				100797			//输入组ID错误
#define E_INPUT_DEVICE_ID				100798			//输入设备ID错误
#define E_INPUT_DOOR_HOLIDAY_ID		100816			//输入门禁节假日ID错误
#define E_DEVICE_TYPE_NOT_FIT			100817			//设备类型不正确


/*************************************************************************
解款类交易错误码
*/
#define E_FAN_ACC_INSUFFICIENT			200100			//解款账户余额不足
#define E_FAN_ACC_NOT_EXISTS				200101			//解款账户不存在
#define E_FAN_OPER_INVALID					200102			//交易操作员验证失败
#define E_FAN_ACC_TRADE_ERR				200103			//交易操作失败
#define E_FAN_SERIAL_NOT_EXISTS			200104			//交易流水号不存在
#define E_FAN_INSUFFICIENT_PRI				200105			//交易权限不足
#define E_FAN_ALREADY_RUSHED				200106			//已经被冲正
#define E_FAN_SHOP_HAS_NO_LEAF			200107			//商户无叶子节点
#define E_FAN_SHOP_NOT_INDEP				200108			//商户不是独立核算
#define E_INPUT_GROUP_OR_OPER				200109			//输入的组号或者操作员号异常
#define E_INPUT_NOW_OR_PAST				200110			//输入的历史或者当天异常


////////////////////////////////////////////////////////
/// 转账后台错误定义
#define  E_TRANS_BANKCARD_LOST         	108001	//银行卡挂失
#define  E_TRANS_BANKACC_STATERR        108002	//银行帐户状态不对
#define  E_TRANS_BANKACC_NOMONEY        108003	//银行卡余额不足
#define  E_TRANS_BANKCARD_PWDERR        108005	//银行卡密码错误
#define  E_TRANS_SCHCARD_LOST         	108101	//校园卡挂失
#define  E_TRANS_SCHCARD_FREEZE         108102	//校园卡冻结
#define  E_TRANS_SCHCARD_UNLOSTING      108103	//持卡人已经为解挂状态
#define  E_TRANS_SCHCARD_LOSTING        108104	//持卡人已经为挂失状态
#define  E_TRANS_SCHACC_NOEXIT         	108105	//该校园卡帐户不存在
#define  E_TRANS_SCHACC_DESTORY         108106	//持卡人已经销户
#define  E_TRANS_RELATION_ERR         	108107	//对应关系不符
#define  E_TRANS_SCHCARD_PWDERR         108108	//校园卡密码错
#define  E_TRANS_TRANSMONEY_OUTRANGE    108109	//转帐金额超出范围
#define  E_TRANS_ACCMONEY_OUTRANGE      108110	//校园卡余额超出范围
#define  E_TRANS_BANK_NODECIDE         	108111	//银行未决交易
#define  E_TRANS_BANK_NOANSWER         	108112	//银行超时，无应答
#define  E_TRANS_BANK_NETERR         	108113	//银行网络故障
#define  E_TRANS_BANK_SERVICE_NOEXIT    108114	//服务没有启动
#define  E_TRANS_RELATION_NOEXIT        108115	//没有对应关系
#define  E_TRANS_FUNC_NONSUPPORT        108116	//此功能暂不被支持
#define  E_TRANS_BANK_RECVERR         	108117	//银行返回数据错误
#define  E_TRANS_SCHOOL_NETERR         	108118	//校园端网络故障
#define  E_TRANS_INNER_TIMEOUT         	108119	//内部超时
#define  E_TRANS_TERM_NOLOGIN         	108120	//终端未登陆
#define  E_TRANS_SCHCARD_TWICE		108121	//客户有多张卡
#define  E_TRANS_SCHCARD_WFAIL	108122	// 校园卡写卡失败
#define  E_DB_SUBSYSPARAMS_D               108123	//子系统参数表删除错误
#define  E_DB_SUBSYSPARAMS_I                108124	//子系统参数表插入错误
#define  E_DB_SUBSYSPARAMS_N               108125	//子系统参数表查询相关无记录
#define  E_DB_SUBSYSPARAMS_R               108126	//子系统参数表读取错误
#define  E_DB_SUBSYSPARAMS_E               108127	//子系统参数表已存在
#define  E_TRANS_UNKNOW_ERROR         	109000	//其他未知错误#define  E_TRANS_BANK_BODYLENERR         	109001	//银行返回数据错误
#define E_BOC_RET_98 109001 //银行文件处理异常，请检查你的帐户资料是否正常。 
#define E_BOC_RET_99 109002 //银行系统还未启动。 
#define E_BOC_RET_01 109003 //帐号在银行控制文件中未定义。 
#define E_BOC_RET_02 109004 //会计科目未建立。 
#define E_BOC_RET_03 109005 //帐号状态不正常。 
#define E_BOC_RET_04 109006 //转出金额超过帐户可用余额。 
#define E_BOC_RET_05 109007 //该货币码不存在。 
#define E_BOC_RET_06 109008 //根据利率码查找会计科目错误。 
#define E_BOC_RET_07 109009 //查找利率错误。 
#define E_BOC_RET_08 109010 //日期计算错误。 
#define E_BOC_RET_09 109011 //交易处理代码错误。RS/6000 
#define E_BOC_RET_10 109012 //计算利息积数错误。 
#define E_BOC_RET_0A 109013 //交易信息代码错误。RS/6000 
//#define E_BOC_RET_0B 109014 //你未申请电话银行服务。 
#define E_BOC_RET_0C 109015 //该帐号未申请电话银行服务。 
#define E_BOC_RET_0D 109016 //该交易已冲正，不能重复冲正。RS/6000 
#define E_BOC_RET_0E 109017 //外汇买卖系统未启动。 
#define E_BOC_RET_0F 109018 //外汇买卖汇率建立。 
#define E_BOC_RET_0G 109019 //外汇牌价未发现。 
#define E_BOC_RET_11 109020 //交易次数与未登折次数不符。 
#define E_BOC_RET_12 109021 //转存到信用卡帐户，限于人民币帐户。 
#define E_BOC_RET_13 109022 //活期一本通无折交易次数超过20次，请到银行补印存折。 
#define E_BOC_RET_14 109023 //你的帐户已销户。 
#define E_BOC_RET_15 109024 //你的该帐户已止扣。 
#define E_BOC_RET_16 109025 //你的帐户已变成长期不动户，请到银行解除。 
#define E_BOC_RET_17 109026 //你的定期一本通存款次数已到60次。请到银行换发新存折。 
#define E_BOC_RET_18 109027 //该笔定期存款状态不正常，不能予以支取。 
#define E_BOC_RET_19 109028 //该笔存款未支取，不能冲正。RS/6000. 
#define E_BOC_RET_20 109029 //该帐户不是个人支票帐户。 
#define E_BOC_RET_21 109030 //该笔定期存款的货币种类与个人支票或者借记卡帐户不相符。 
#define E_BOC_RET_22 109031 //计算利息错误，请与银行联系。 
#define E_BOC_RET_23 109032 //该支票不是个人支票或者未保付。 
#define E_BOC_RET_24 109033 //对不起，你的帐户可保付金额不足，该支票不能保付。 
#define E_BOC_RET_25 109034 //对不起，该支票已兑付，不能再保付。 
#define E_BOC_RET_26 109035 //该支票未售出。 
#define E_BOC_RET_27 109036 //该支票已止扣。 
#define E_BOC_RET_28 109037 //外汇买卖应该用同一个帐号。 
#define E_BOC_RET_29 109038 //你输入的帐户类别错误。 
#define E_BOC_RET_30 109039 //你输入的两个货币代码重复。 
#define E_BOC_RET_31 109040 //你输入的货币代码不是可兑换的货币码. 
#define E_BOC_RET_32 109041 //存款序号未输入或者已大于60。 
#define E_BOC_RET_33 109042 //你输入的存期错误。 
#define E_BOC_RET_34 109043 //你输入的人民币存款存期错误。 
#define E_BOC_RET_35 109044 //你输入的外币存款存期错误。 
#define E_BOC_RET_36 109045 //转出帐号的货币代码帐户类别与转入帐号不相符。 
#define E_BOC_RET_37 109046 //支票号码未输入。 
#define E_BOC_RET_38 109047 //记录已存在，重复记录。 
#define E_BOC_RET_39 109048 //请输入查询的帐号。 
#define E_BOC_RET_40 109049 //你所要查询的交易资料不存在。 
#define E_BOC_RET_41 109050 //银行文件未打开，请电讯银行. 
#define E_BOC_RET_42 109051 //TRACE 
#define E_BOC_RET_43 109052 //请输入支取金额。 
#define E_BOC_RET_44 109053 //请输入存入金额。 
#define E_BOC_RET_45 109054 //你的存折交易次数超过60次，请到银行换发新存折。 
#define E_BOC_RET_46 109055 //你输入的金额与存款金额不符。 
#define E_BOC_RET_A9 109056 //信息代码与处理代码不相符。RS/6000 
#define E_BOC_RET_S1 109057 //你的活期一本通帐号未申请电话银行服务。 
#define E_BOC_RET_S2 109058 //你的个人支票帐号未申请电话银行服务。 
#define E_BOC_RET_S3 109059 //你的定期一本通帐号未申请电话银行服务。 
#define E_BOC_RET_S4 109060 //你的信用卡帐号未申请电话银行服务。 
#define E_BOC_RET_S5 109061 //你的借记卡帐号未申请电话银行服务。 
#define E_BOC_RET_R0 109062 //冲正记录未发现，TRACE 
#define E_BOC_RET_R1 109063 //帐户余额不足，不能冲正。 
#define E_BOC_RET_R2 109064 //冲正金额错误。RS/6000 
#define E_BOC_RET_R3 109065 //冲正存款序号错误。RS/6000 
#define E_BOC_RET_R4 109066 //该交易不允许冲正。RS/6000 
#define E_BOC_RET_W3 109067 //查询的外汇汇率超过50笔。 
#define E_BOC_RET_W4 109068 //查询的存款资料超过50笔，请回送最后一笔存款的序号。RS/6000 
#define E_BOC_RET_W1 109069 //查询历史交易资料超过60笔，请回送日期与序号。RS/6000 
#define E_BOC_RET_W5 109070 //对公查询，交易资料超过11笔，请继续查询 
#define E_BOC_RET_W2 109071 //定期一本通存款次数已够60次，请你到银行换发新存折。 
#define E_BOC_RET_W8 109072 //您所查询的对公历史交易不成功。 
#define E_BOC_RET_61 109073 //无法创建消息队列’ 
#define E_BOC_RET_62 109074 //无法创建共享内存 
#define E_BOC_RET_63 109075 //无法创建信号灯 
#define E_BOC_RET_64 109076 //数据库操作错误 
#define E_BOC_RET_65 109077 //写消息队列失败 
#define E_BOC_RET_66 109078 //取款，或开户时，借记卡密码错误 
#define E_BOC_RET_67 109079 //读消息队列失败 
#define E_BOC_RET_68 109080 //系统停机 
//#define E_BOC_RET_69 109081 //前端申请的应用系统停机 
#define E_BOC_RET_80 109082 //帐户密码错 
#define E_BOC_RET_70 109083 //8583数据错误 
#define E_BOC_RET_71 109084 //无效的码表查询 
#define E_BOC_RET_72 109085 //冲正申请失败 
#define E_BOC_RET_73 109086 //用户未申请银券转帐服务 
//#define E_BOC_RET_74 109087 //前端申请的应用系统通信中断。 
#define E_BOC_RET_75 109088 //交易请求方通信中断。 
#define E_BOC_RET_76 109089 //交易请求方已签退。 
#define E_BOC_RET_M1 109090 //非法报文。 
#define E_BOC_RET_M2 109091 //无此终端 
#define E_BOC_RET_M3 109092 //无此操作员 
#define E_BOC_RET_M4 109093 //该帐户已过期 
#define E_BOC_RET_M5 109094 //无效金额 
#define E_BOC_RET_M6 109095 //超过日提款限次 
#define E_BOC_RET_M7 109096 //超过日提款限额 
#define E_BOC_RET_M8 109097 //帐户未登记 
#define E_BOC_RET_M9 109098 //帐户登记不匹配 
#define E_BOC_RET_M0 109099 //证券系统错误 
#define E_BOC_RET_MA 109100 //身份证错误 
#define E_BOC_RET_MB 109101 //与应用系统数据通信错误。 
#define E_BOC_RET_MC 109102 //接收证券主机错误 
#define E_BOC_RET_MD 109103 //与应用系统通信数据格式错误。 
#define E_BOC_RET_F1 109104 //外汇买卖不成功 
#define E_BOC_RET_F2 109105 //您所输入的汇价，银行近日无法满足 
#define E_BOC_RET_F3 109106 //委托的外汇买卖交易已成功成交（挂单） 
#define E_BOC_RET_W7 109107 //委托的外汇买卖挂单交易即时成功成交 
#define E_BOC_RET_F4 109108 //非法的外汇买卖货币 
#define E_BOC_RET_F5 109109 //非法的外汇买卖交易网点 
#define E_BOC_RET_F6 109110 //您所输入的货币，今日不能进行外汇买卖。 
#define E_BOC_RET_F7 109111 //法国法郎货币外汇买卖限额不得低于二万美元 
#define E_BOC_RET_F8 109112 //瑞士法郎货币外汇买卖限额不得低于二万美元 
#define E_BOC_RET_FA 109113 //外汇买卖委托交易已撤消 
#define E_BOC_RET_FB 109114 //外汇买卖委托交易不存在。 
#define E_BOC_RET_FC 109115 //外汇买卖委托交易成交失败。 
#define E_BOC_RET_FD 109116 //外汇买卖委托交易未成交。 
#define E_BOC_RET_C1 109117 //无效的卡号。 
#define E_BOC_RET_C2 109118 //查询信用卡历史交易时，必须输入查询截止日期。 
#define E_BOC_RET_X1 109119 //信用卡帐户错误，请与发卡行联系。 
#define E_BOC_RET_X4 109120 //查询信用卡交易失败。 
#define E_BOC_RET_R8 109121 //信用卡存取款冲帐失败。 
#define E_BOC_RET_W6 109122 //您的信用卡帐户透支金额为。 
#define E_BOC_RET_52 109123 //查询信用卡交易失败。 
#define E_BOC_RET_Z1 109124 //已开户，重复开户 
#define E_BOC_RET_Z3 109125 //资料不存在 
#define E_BOC_RET_Z0 109126 //开户错 
#define E_BOC_RET_Z2 109127 //未做预开户 
#define E_BOC_RET_74 109128 //通讯状态错 
#define E_BOC_RET_69 109129 //未签到 
#define E_BOC_RET_T0 109130 //交易模式错 
#define E_BOC_RET_Z5 109131 //缴费资料不存在 
#define E_BOC_RET_Z6 109132 //已缴费 
#define E_BOC_RET_Z7 109133 //未缴费 
#define E_BOC_RET_P4 109134 //密码错 
#define E_BOC_RET_PX 109135 //帐户类别错 
#define E_BOC_RET_P6 109136 //卡号错 
#define E_BOC_RET_Z9 109137 //补打失败 
#define E_BOC_RET_Z8 109138 //正在进行交费处理 
#define E_BOC_RET_ZA 109139 //公司代码错 
#define E_BOC_RET_ZC 109140 //公司代码错 
#define E_BOC_RET_ZZ 109141 //总帐不平 
#define E_BOC_RET_T1 109142 //交易时间错 
#define E_BOC_RET_T2 109143 //预开户过期 
#define E_BOC_RET_P0 109144 //记帐错误 
#define E_BOC_RET_P1 109145 //更新活期主档错 
#define E_BOC_RET_P2 109146 //活期帐号不存在 
#define E_BOC_RET_P3 109147 //读活期档错 
#define E_BOC_RET_P5 109148 //借记卡状态不正常 
#define E_BOC_RET_P7 109149 //读借记卡主档错 
#define E_BOC_RET_P8 109150 //写ATMLOG出错 
#define E_BOC_RET_P9 109151 //活期状态不正常 
#define E_BOC_RET_Q0 109152 //未申请电话银行服务 
#define E_BOC_RET_Q1 109153 //该客户已销户 
#define E_BOC_RET_Q2 109154 //客户记录未发现 
#define E_BOC_RET_Q3 109155 //读客户出错 
#define E_BOC_RET_Q4 109156 //该活期帐号非客户活期帐号 
#define E_BOC_RET_Q5 109157 //写文件键值重复 
#define E_BOC_RET_Q8 109158 //帐户类别错 
#define E_BOC_RET_Q9 109159 //柜员现金不足 
#define E_BOC_RET_ME 109160 //手机号不存在 
#define E_BOC_RET_N1 109161 //客户状态不正常 
#define E_BOC_RET_N2 109162 //写现金档重复 
#define E_BOC_RET_N3 109163 //写现金档出错 
#define E_BOC_RET_N4 109164 //预交费交易类型错 
#define E_BOC_RET_77 109165 //索取对帐文件失败 
#define E_BOC_RET_0B 109166 //未申请服务 
#define E_BOC_RET_81 109167 //应用系统返回错误。 


#define E_MOBILE_TRANS_REQUEST 109168 //充值请求发送失败
#define E_MOBILE_TRANS_CONNECT 109169 //充值请求连接失败
#define E_MOBILE_TRANS_NOT_CONNECT 109170 //充值服务网络故障
#define E_MOBILE_TRANS_TIME_OUT 109171 //充值请求超时无应答
#define E_MOBILE_CHECK_MAC 109172 //mac校验出错
#define E_MOBILE_CHECK_FAIL 109173 //手机号码不正确
#define E_MOBILE_CHECK_UNKNOW 109174 //移动返回数据错误
#define E_MOBILE_TRANS_FAILURE 109175 //充值失败

#define E_ELEC_DB_CONN	109176 //数据库连接错误
#define E_ELEC_CARD	109177 //一卡通账号与房间不对应
#define E_ELEC_ROOM	109178 // 不存在的房间
#define E_ELEC_WORKSTAT 109179 //不存在工作站
#define E_ELEC_DATA	109180 //数据校验错误
#define E_ELEC_DATA_LOSS 109181 //数据丢失
#define E_ELEC_UNKNOW	109182 //未知错误
#define E_TRANS_REQUEST 109183 //请求发送失败
#define E_TRANS_CONNECT 109184 //请求连接失败
#define E_TRANS_NOT_CONNECT 109185 //请求网络故障
#define E_TRANS_TIME_OUT 109186 //请求超时无应答

#define E_INVALID_SHOP 109200 	//无效商户
#define E_CVN_FAILED 109201 	//CVN效验失败
#define E_TRADE_FAILED 109202 	//交易出错
#define E_INVALIED_TRADE 109203 	//无效交易
#define E_INVALIED_MONEY 109204 	//无效金额
#define E_INVALIED_CARD 109205 	//无效卡号
#define E_TROUBLE_DOUBT 109206 	//故障怀疑
#define E_FIND_INIT_TRADE 109207 	//找不到原始交易
#define E_OUTOFPIN_INPUT 109208 	//超过允许的的PIN输入
#define E_BANK_CARD_LOST 109209 	//该卡已经挂失
#define E_NO_BANK_ACCOUNT 109210 	//无银行账户
#define E_FUNDS_SHORTAGE 109211 	//资金短缺
#define E_CARD_OUTOFDATE 109212 	//过期卡
#define E_INVALID_PIN 	109213 		//无效的PIN密码
#define E_CARDHOLDER_TRADE 	109214 		//不允许持卡人进行交易
#define E_OUTOF_TRADE_COUNTS 	109215 		//超出交易次数
#define E_BANK_SETTLE_ACCOUNTS 	109216 		//银行日终结算
#define E_BANK_MAC_FAILED 	109217 		//MAC效验失败
#define E_CONNECT_PUBLISH_BANK 	109218 		//请与发卡行联系


#endif
