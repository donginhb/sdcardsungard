#ifndef _KSGATEWAY_H_
#define _KSGATEWAY_H_
/*! @file
*	模块名:	一卡通通用前置机
*	文件名: ksgateway.h
*	文件实现功能:	
*	作者:	汤成
*	版本:	V0.1
*	备注:	
*/
#ifdef _MSC_VER
#pragma once
#endif
#include "ksglobal.h"
#include "taskdef.h"
#include "taskqueue.h"
#include "device.h"
#include "smartpool.h"
#include "DRTPHelper.h"
#include "scheduler.h"
#include <boost/pool/object_pool.hpp>
#include <ace/Log_Msg_Backend.h>
#include <ace/Thread_Manager.h>
#include <map>

//////////////////////////////////////////////////////////////////////////
// 
//typedef KSGTaskManager<KSGDeviceNode::Task> TaskManager;
typedef KSGTaskManager TaskManager;

//! 设备厂商配置
class KSGVendorConfig
{
public:
	std::string _vendor;
	//<! 设备联机模式
	int _devMode;

};

struct KSG_Schd_Alg_Config_t
{
	std::string _algorithm_name;
	size_t _thr_count;
};

//! 前置机全局配置参数
class KSGConfig
{
public:
	//<! 前置机主版本号
	int _majorVer;
	//<! 前置机次版本号
	int _minorVer;
	//<! 前置机的ID号
	int _gwId;
	//<! 主程序目录
	std::string _basedir;
	//<! DRTP 服务器IP
	std::string _drtpSvrIP;
	//<! DRTP 服务器端口号
	int _drtpSvrPort;
	//<! DRTP 主功能号
	int _drtpMainFunc;
	//<! DRTP 节点号
	int _drtpNo;
	//<! DRTP 缓存池最大接连数
	int _drtpPoolMaxCnt;
	//<! 前置机使用的IP
	std::string _localIP;
	//<! 本地IP对应的 MAC
	std::string _localMac;
	//<! 动态密钥
	std::string _dynaKey;
	//<! 指令请求功能号
	int _taskRecvFuncNo;
	int _taskResponseFuncNo;
	//<! 下载设备参数的功能号
	int _drtpGetDevFuncNo;
	//<! 心跳时间间隔
	int _heartbeat;
	//<! 心跳阀值
	int _heartbeatIntval;
	//<! 心跳应答DRTP功能号
	int _heartbeatFuncNo;
	//<! 前置机DRTP队列号
	int _drtpQueueNo;
	//<! 前置机指令执行超时时间
	int _execTimeout;
	/*
	//<! 设备类型
	std::string _devType;
	*/
	//<! 签到时应用服务器数据库时间
	std::string _startDBTime;
	//<! 采集流水时间间隔
	int _serialIntval;
	//<! 指令队列最大等待指令数
	int _taskQueueMaxWaiting;
	//<! 收取指令时间间隔
	int _taskRecvIntval;
	//<! 启动的指令线程号
	std::string _runTaskIds;
	//<! 启动的侦听服务号
	std::string _listenerIds;
	//<! 主工作密钥
	BYTE _workKey[32];
	//<! 设备卡密钥
	std::string _cardKey;
	///////////////////////////////////////////////////////////
	//<! 日志级别
	std::string _logLevel;
	//<! 日志输出
	std::string _logOutput;
	//<! 日志文件路径
	std::string _logFilePath;
	//<! 日志文件大小
	unsigned long _log_max_file_size;
	//<! 日志文件个数
	int _log_max_backup;

public:
	//! default constructor
	KSGConfig();
	//! destructor
	~KSGConfig();
	//! 加载本地配置文件
	/*!
	 \param filename 本地配置文件
	 \return 返回0 表示加载成功，失败返回 -1
	 */
	int loadConfig(const std::string& filename);
};

// class KSGDeviceManager;
class KSGSchedulerObserver;


//! 前置机主程序
class KSGateway
{
public:
	typedef KSGDeviceNode DeviceNodeType;
	typedef KSGDevice DeviceType;
	typedef enum KSG_Gateway_Status { stRunning, stRestarting, stStop,stStopPedding };
private:
	//<! 状态
	KSG_Gateway_Status _status;
	//<! 全局配置参数
	KSGConfig _configuration;
	//<! 厂商硬件设备配置参数
	typedef std::map<std::string,KSGVendorConfig*> vendor_map_type;
	vendor_map_type _vender_config;
	//<! 设备节点管理器
	KSGDeviceManager *_devManager;
	/*!
	 * 前置机向应用服务器签到，应用服务器会将前置机的 ID 与动态密钥下载
	 * \return 签到成功返回 0 ,失败返回错误码
	 */
	int enroll();
	/*!
	 * 前置机向应用服务器签退
	 * \return 签退成功返回 0 ,失败返回错误码
	 */
	int exit();
	/*!
	 * 下载前置机的所有运行参数
	 * \return 下载成功返回 0 ,失败返回错误码
	 */
	int downloadRuntimeParams();
	/*!
	 * 读取本地的前置机配置,配置文件是运行目录下的 yktgw.cfg
	 * \return 成功返回 0 , -1 表示失败
	 */
	int loadLocalConfig();
	/*!
	 * 加载所有设备信息，可以是从应用服务器下载，也可以不需要从应用服务器加载
	 * \return 加载成功返回 0 ,失败返回错误码 
	 */
	int setupAllDevices();
	int device_factory_init(const std::string &vendor);
	/*!
	 *  加载所有的定时任务
	 */
	int startTimeScheduler();
	//! 加载日志系统
	/*!
	 \brief 该方法必须第一个被调用，以初始化日志
	 \return 加载成功返回 0 , 失败返回 -1
	 */
	int setupLogSystem();
	//! 关闭日志系统
	int closeLogSystem();
	//! 加载 DRTP 缓存池, 缓存池大小由 _drtpPoolMaxCnt 参数决定 \sa KSGConfig
	/*!
	 \return 成功返回 0,失败返回 -1;
	 */
	int setupDrtpPool();
	//! 加载 Loop 设备
	/*
	 \return 加载成功返回0, 失败返回 -1
	 */
	int loadLoopDevice();
	//! 加载指令执行器
	int loadTaskExecutor();
	//! 加载厂商配置
	/*!
	 \brief 加载硬件厂商类型, 只有加载过的硬件厂商类型的设备接口才可以使用!!!
			LOOP 设备默认被加载
	 \return 0 表示成功 -1 表失败
	 */
	int load_vendor_config();
	int free_vendor_config();

	int start_scheduler_algorithm();
	int init_scheduler_algorithm(const std::string &alg_name);
	int stop_scheduler_algorithm();
	typedef std::list<void*> task_schd_list_type;
	task_schd_list_type _task_schd;
	ACE_Thread_Manager _task_schd_thr_manager;

	int setup_all_proactor_acceptor();

	int stop_all_proactor_acceptor();

	//<! 分组指令队列的管理类型
	typedef KSGTaskQueueManager TaskQueueManager;
	//<! 分组指令队列
	TaskManager* _taskManager;
	TaskQueueManager _taskQueue;
	//KSGDeviceGroupScheduler _devgrpSchd;
	//<! 任务调度算法
	typedef std::list<KSG_Schd_Alg_Config_t*> schd_alg_list_type;
	//schd_alg_list_type _schd_alg_list;
	//<! 调度线程观察者
	KSGSchedulerObserver* _schdObserver;
	//<! 
	ACE_Log_Msg_Backend* _logBackend;
public:
	/*!
	 * 启动前置机服务，该函数是主方法
	 * 如果启动失败返回一个错误码，如果启动成功将进入一个无限循环
	 * \return 返回 0 表示正常退出，否则返回退出代码
	 */
	int run();
	/*!
	 * 调用该函数将停止服务器，系统会首先停止所有正在运行线程，然后返回
	 * 如果停止服务失败返回错误码，但该函数不会超时，可能一直等待服务器停止。
	 * 调用该函数，前置机后先向应用服务器签退。
	 * 停止前置机会将所有在指令队列中的指令删除。
	 * \return 0 表示停止失败，否则返回错误码
	 */
	int stop();
	void restart();

	inline KSG_Gateway_Status status() const
	{
		return _status;
	}
	/*!
	 * default constructor
	 */
	KSGateway();
	/*!
	 * destructor
	 */
	~KSGateway();
	//! 创建 DRTPHelper 对象,通过本地配置来创建DRTP连接
	/*!
	 \return DRTPHelper 的指针，失败返回 NULL
	 */
	CDRTPHelper * CreateDrtpHelper();
	//! 获取前置机配置类
	const KSGConfig* GetConfig() const
	{
		return &_configuration;
	}
	//! 获取前置机任务管理器
	inline TaskManager* GetTaskManager()
	{
		return _taskManager;
	}
	inline TaskQueueManager* GetTaskQueue()
	{
		return &_taskQueue;
	}
	//! 获取前置机设备节点管理器
	inline KSGDeviceManager* GetDeviceManager()
	{
		return _devManager;
	}
	/*
	inline KSGDeviceGroupScheduler* GetDeviceGroupScheduler()
	{
		//return &_devgrpSchd;
	}
	*/
	inline KSGVendorConfig* get_vendor_config(const std::string &config) const
	{
		vendor_map_type::const_iterator iter = _vender_config.find(config);
		if(iter == _vender_config.end())
			return NULL;
		return iter->second;
	}
};
//! 调度线程观察者
class KSGSchedulerObserver : public KSGMTObserver
{
private:
	KSGateway * _gateway;
public:
	//! constructor
	/*
	 \param gateway 前置机对象指针
	 */
	KSGSchedulerObserver(KSGateway* gateway):_gateway(gateway)
	{
		assert(gateway != NULL);
	}
	//! 调度线程通知接口函数
	virtual void Update(KSGScheduler& obj);
};

//<! DRTP 缓存池类型
typedef ResourcePool<CDRTPHelper,KSGLockThreadModel> DRTPPoolType;
//<! 全局 DRTP 缓存池
extern DRTPPoolType theDrtpPool;
//<! 获取全局的 DrtpPool 池
inline DRTPPoolType* KsgGetDrtpPool()
{
	return &theDrtpPool;
}
int KsgStartServer(KSGateway* gateway);

#endif // _KSGATEWAY_H_

