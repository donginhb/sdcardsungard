#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <signal.h>
#include "shem.h"
#include "fdsqc.h"
#include "dbfunc.h"
#include "pubdb.h"
#include "errdef.h"
#include "logfile.h"
#include "profile.h"
#include "transinfo.h"
#include "bank.h"
#include "bankdb.h"


extern int debug;
ST_BUNIT g_BUnit;


#ifdef DEBUG
#define	TRACE	printf
#else
#define	TRACE	NULL
#endif


//#define writelog getpos(__FILE__,__LINE__),errlog


/**********************************************************************
 Added by hhd at 2004-09-16
**********************************************************************
 Update by hhd at 2004-10-27
 为了增加签到处理，达到共享内存的处理
 增加共享内存和信号量
 为了反映每个终端的当前工作状态，在共享内存中设置一个状态标志
 共享内存一共1024个字节，其中使用前26个字节
 shm[0]:代表是否进行过签到的标志，如果为1，已经签过到但不知道是否成功
 		，后续业务将不能进行签到处理,如果为其他值，系统将进行签到
 shm[1]:代表签到是否成功的标志，如果为1，则标识签到成功，后续16个字节为
 		银行正常返回数据，可以使用
 shm[2]:代表系统重新启动标志，如果不为1，系统进行初始化操作(进行设备
 		注册表中设备的状态的清空操作),然后系统将改标志置为1，其他BU启动
 		跳过该项操作
 shm[10~25]:前8个字节为加密的PIN密钥，后8个字节为加密的MAC密钥

 ----------------
 Updated by lq at 2005-03-10
 将签到、冲正、通信监测集中到本程序(bankguard)中处理，通过共享内存与银行转账bu交互
 为保持数据一致性，读写共享内存区通过信号量进行同步
 shm[3]:通信状况标志：如果为1，表示通信异常，bu应该直接拒绝请求
***********************************************************************/


void SQLDebugLog(int errorcode,char *fmt,...)
{
	va_list args;
	char msg[4096] = "";
	char body[3840] = "";

	va_start(args, fmt);
	vsprintf(body, fmt, args);
	va_end(args);

	sprintf(msg, "SQL ERROR[%d]-%s", errorcode, body);
	syslog(LOG_ERR, msg);

}

bool ReadIni(char *inifile)
{
   TIniFile tf;

   char szBuf[256];
   memset(&g_BUnit,0,sizeof(g_BUnit));
   if (!tf.Open(inifile))
   {
      writelog(LOG_ERR,"不能打开配置文件<%s>\n",inifile);
      return false;
   }


   tf.ReadString("DB","DB_NAME","test",g_BUnit.m_SqlDB.szDatabase,sizeof(g_BUnit.m_SqlDB.szDatabase)-1);
   tf.ReadString("DB","DB_USER","db2inst4",g_BUnit.m_SqlDB.szLogin,sizeof(g_BUnit.m_SqlDB.szLogin)-1);
   tf.ReadString("DB","DB_PASSWORD","db2inst4",g_BUnit.m_SqlDB.szPassword,sizeof(g_BUnit.m_SqlDB.szPassword)-1);

   tf.Close();
   return(true);
}

bool GetGatewayIP(char *inifile,char *host)
{
  TIniFile tf;

   if (!tf.Open(inifile))
   {
      writelog(LOG_ERR,"不能打开配置文件<%s>\n",inifile);
      return false;
   }

   tf.ReadString("GATE_WAY","HOST_IP","127.0.0.1",host,20);
   tf.Close();
   return(true);
}
int	app_flag = 0;
#define APP_FLAG_DAEMON	0x0001
#define APP_FLAG_CONFIG	0x0002
#define APP_FLAG_DEBUG	0x0004
#define APP_FLAG_TERM	0x8000

void sig_handler(int signo)
{
	switch(signo)
	{
	case	SIGINT:
	case	SIGTERM:
		app_flag |= APP_FLAG_TERM;
		break;
	default:
		break;
	}
}

int main(int argc,char *argv[])
{
	int	_pid = 0;
	int 	ret=0;
	key_t 	key;
	int intping = 60;	// ping银行间隔
	int intflush = 60;	// 冲正间隔
	int inttrans = 60;	//划拨间隔
	int intcomp = 10;	//对帐时间间隔
	struct 	shmid_ds buf;
	
	BANK_TRANS_REQUEST	bank_trans;

   	int opt;
   	extern int optind;
   	extern char *optarg;

	while ((opt = getopt(argc, argv, "bdvhi:p:f:")) != EOF)
	{
		switch(opt)
		{
		case 'v':
			printf("bank guard version 1.0.2.10\n");
			return 0;
		case 'b':
			app_flag |= APP_FLAG_DAEMON;
			break;
		case 'd':
			app_flag |= APP_FLAG_DEBUG;
			debug = 2;
			break;
		case 'i':
			app_flag |= APP_FLAG_CONFIG;
			ReadIni(optarg);
			break;
		case 'p':
			intping = atol(optarg);
			break;
		case 'f':
			intflush = atol(optarg);
			break;
		case '?':
		case 'h':
		default:
			printf("usage: %s -options \n", argv[0]);
			printf("\toptions:\n");
			printf("\t-b\t\trun as daemon\n");
			printf("\t-d\t\trun in debug mode, communication content will be printed to stdout\n");
			printf("\t-h\t\tshow this help message\n");
			printf("\t-i inifile\tassign config file\n");
			printf("\t-p ping_interval\tassign the interval between each ping\n");
			printf("\t-f flush_interval\tassign the interval between each database process\n");
			return 0;
		}
	}

 	// 屏蔽信号
	signal(SIGPIPE, sig_handler);
	signal(SIGALRM, sig_handler);
	signal(SIGINT, sig_handler);
	signal(SIGHUP, sig_handler);
	signal(SIGTERM, sig_handler);
	signal(SIGCHLD, sig_handler);

 	if((app_flag&APP_FLAG_CONFIG) == 0)
		ReadIni("trans.ini");

	if((app_flag&APP_FLAG_DAEMON)!= 0)
 	{
 		_pid=fork();
		if(_pid != 0)
			exit(0);
		else if(_pid< 0)
			exit(1);

		setsid();
		_pid=fork();
		if(_pid != 0)
			exit(0);
		else if(_pid< 0)
			exit(1);

		int i;
		for(i=3;i<20;++i)
			close(i);

		//umask(0);
 	}

    	openlog("bank",LOG_PID|LOG_CONS|LOG_NDELAY,LOG_LOCAL4);

	// 初始化数据库连接：
	SQLInitialize();
	ret = SQLConnectToServer();
	if (ret!=0)
	{
		writelog(LOG_ERR,"连接数据库失败[%d]", ret);
		//printf("连接数据库失败database %s, username %s, password %s, [%d]", g_BUnit.m_SqlDB.szDatabase,g_BUnit.m_SqlDB.szLogin,g_BUnit.m_SqlDB.szPassword, ret);
		printf("连接数据库失败\n");
		return 	E_DB_DBCONN;
	}

   	//创建共享内存
	key=ftok(".",0);
	shmid=shmget(key,SEGSIZE,IPC_CREAT|0666);
	if(-1==shmid)
	{
		writelog(LOG_ERR,"创建共享内存失败[%d]",shmid);
		printf("创建共享内存失败\n");
		return 	E_CREATE_SHARE_MEMORY;
	}
	shm=(char*)shmat(shmid,0,0);
	if((int)shm==-1)
	{
		writelog(LOG_ERR,"连接共享内存失败[%d]",shm);
		printf("连接共享内存失败\n");
		return 	E_JOIN_SHARE_MEMORY;
	}


	//枷锁进行清除设备签到表和前置机签到
	semid=sem(key);
	if((int)semid==-1)
	{
		writelog(LOG_ERR,"创建信号量失败[%d]",semid);
		printf("创建信号量失败\n");
		return 	E_JOIN_SHARE_MEMORY;
	}

	p(semid);

	//初始化共享内存
	memset(shm, 0, SEGSIZE);
	shm[0]=0;
	shm[1]=0;
	writelog(LOG_INFO,"已重置共享内存");
	ret=DB_t_pif_device_update_by_subsystem_type(SUBSYSTYPE_KEEP,SUBSYSSTAT_OFFLINE);
	//if(ret)
	if((ret!=0)&&(ret!=100))
	{
		writelog(LOG_ERR,"DB_t_pif_device_update_by_subsystem_type error,errcode=[%d]",ret);
		shmdt(shm);
		shmctl(shmid,IPC_RMID,&buf);
		d_sem(semid);
		return 	ret;
	}

	shm[2]=1;
	writelog(LOG_ERR,"已清理设备表");

	//枷锁退出
	v(semid);

	//writelog(LOG_INFO,"银行接口初始化完成，bank_bu可以启动了");
	//printf("银行接口初始化完成\n");

	time_t	now = 0;
	time_t 	lastping = 0;		// 上次ping银行时间
	time_t	lastflush = 0;		// 上次处理冲正时间
	time_t	lasttrans=0;		//上次试图帐务划拨的时间
	time_t	lastcomp=0;		//上次试图银行对帐的时间
	T_t_tif_tradeserial  tradeserial; //卡操作流水表，用做冲正用

	bool		bLinked = false;
	char 	host_ip[20]="127.0.0.1";
	GetGatewayIP("trans.ini", host_ip);
	DB_MONITORS_UPDATE(host_ip,"block");			//初始化为阻塞状态
	writelog(LOG_INFO,"初始化[%s]状态为block",host_ip);

	// 进入运行
	while(true)
	{
		if((app_flag&APP_FLAG_TERM) != 0)
		{
			writelog(LOG_INFO,"收到终止信号，退出");
			break;
		}

		// 监测与银行通信情况

		now = time(0);
		if((now - lastping) > intping)
		{

			lastping = now;
			if(shm[1] != 1)
			{
				//进行系统登陆，修改登陆标志
				p(semid);

				writelog(LOG_INFO,"开始登陆银行");
				printf("正在登陆银行...\n");

				shm[0]=1;

				ret=Do_Login(&bank_trans);

				if(ret!=0)
				{	
					if(bLinked)
					{
						bLinked = false;
						writelog(LOG_INFO,"前置[%s]状态转为block",host_ip);
						DB_MONITORS_UPDATE(host_ip,"block");
					}
					
					writelog(LOG_ERR,"登陆银行失败[%d]",ret);
					printf("----------登陆银行失败----------\n");
				}
				else
				{
					if(!bLinked)
					{
						bLinked = true;
						writelog(LOG_INFO,"前置[%s]状态转为ok",host_ip);
						DB_MONITORS_UPDATE(host_ip,"ok");
					}
					
					writelog(LOG_INFO,"登陆银行成功");
					printf("----------登陆银行成功----------\n");
					shm[1]=1;
					shm[3]=0;
					memcpy(shm+10,bank_trans.BankCardPwd,sizeof(bank_trans.BankCardPwd));

					ret=DB_t_pif_device_update_by_subsystem_type(SUBSYSTYPE_KEEP,SUBSYSSTAT_OFFLINE);
					//if(ret)
					if((ret!=0)&&(ret!=100))
					{
						writelog(LOG_ERR,"DB_t_pif_device_update_by_subsystem_type error,errcode=[%d]",ret);
						shmdt(shm);
						shmctl(shmid,IPC_RMID,&buf);
						d_sem(semid);
						return 	ret;
					}
					else
					{
						db_commit();
					}

					shm[2]=1;
					writelog(LOG_ERR,"已清理设备表");

					char buffer[100]="";
					int k=0;
					for(int i=0;i<16;i++)
					{
						k=bank_trans.BankCardPwd[i];
						sprintf(&buffer[2*i],"%02X",k);
					}
					writelog(LOG_INFO,"BankCardPwd=[%s]",buffer);
				}
				v(semid);
				continue;
			}

			ret=Do_CheckLine(&bank_trans);
			if(ret != 0)	// ret?
			{
				writelog(LOG_ERR,"与银行的通信可能中断[%d]",ret);
				p(semid);
				shm[1]=0;	// 置登陆标志，// 是否有必要重新登陆？？
				shm[3]=1;	// 置通信标志
				v(semid);
			}
			else if(shm[3] == 1)
			{
				writelog(LOG_ERR,"与银行的通信恢复[%d]",ret);
				p(semid);
				shm[3]=0;	// 置通信标志
				v(semid);
			}
		
		}

		//补发冲正
		now = time(0);
		if((now - lastflush) > intflush)
		{
			lastflush = now;
			// 获取下一个冲正记录：状态为需冲正且上次冲正时间最早
			//RESERVE_1不为空的视为冲正成功
			ret = DB_t_tif_tradeserial_next_flush(&tradeserial);
			if( ret == 0)
			{
				// TODO: 发送冲正记录.注意填空格
				writelog(LOG_INFO,"补发冲正", ret);
				//组织银行包
				memset(&bank_trans, ' ', sizeof(bank_trans));
				//写交易代码
				strnscpy( bank_trans.TradeCode,TRADE_BANK_DETRANS, BANK_TRADE_CODE_LEN);
				//写交易日期和交易时间
				strnscpy(bank_trans.TradeDate,tradeserial.operate_date,sizeof(bank_trans.TradeDate));
				strnscpy(bank_trans.TradeTime,tradeserial.operate_time,sizeof(bank_trans.TradeTime));
				//改成校园卡卡号
				sprintf(bank_trans.CustAccountNo,"%-10d",tradeserial.card_id);
				/*
				//写校园卡帐号
				ret=GetActnoByCardIdAndPurseId(bank_trans.CustAccountNo,tradeserial.card_id, tradeserial.purse_id);
				if(ret)
				{
					writelog(LOG_ERR,"GetActnoByCardIdAndPurseId err,errcode=[%d],card_id=[%d],purse_id=[%d]",ret,tradeserial.card_idtradeserial.purse_id);
				}
				*/
				//写银行卡号字段
				strnscpy(bank_trans.BankCardNo,tradeserial.b_act_id, sizeof(bank_trans.BankCardNo));
				//写商户号字段
				strnscpy(bank_trans.MercAccount,SCHOOL_ACCOUNT_NO,sizeof(bank_trans.MercAccount));
				//写转帐金额字段
				sprintf(bank_trans.TransMoney,"%-9d", int(tradeserial.trade_fee));
				//写银行卡密码字段!!!oldpwd? or pwd in shm?
				strnscpy(bank_trans.BankCardPwd, tradeserial.oldpwd,sizeof(bank_trans.BankCardPwd));
				//写校园端流水号!!!serial_no or ReviseSerial_no? f?
				sprintf(bank_trans.CustSn,"%-8d",tradeserial.other_seri_no);
				//sprintf(bank_trans.BankSn,
				//写院校代码
				sprintf(bank_trans.CustNo,"%-16s",SCHOOL_CODE);
				//写校验mac码
				generate_mac((char*)(&bank_trans),sizeof(bank_trans),bank_trans.MAC);

				ret = Do_DeTrans(&bank_trans); //, &tradeserial);

				if(ret == 0)
				{
					// 更新该冲正记录状态（发送时间、次数）
					// 保留银行端流水号BankSn
					if(0!=strncmp(bank_trans.RetCode,RET_BANK_OK,2))
					{
						db_rollback();
						DB_t_tif_tradeserial_done_flush(&tradeserial);
						writelog(LOG_ERR,"冲正失败,retcode=[%2.2s]",bank_trans.RetCode);
					}
					else
					{
						memcpy(tradeserial.reserve_1, bank_trans.BankSn, sizeof(bank_trans.BankSn));
						DB_t_tif_tradeserial_done_flush(&tradeserial);
						writelog(LOG_INFO,"补发冲正记录成功[%ld]", tradeserial.serial_no);
					}
				}
				else
				{
					DB_t_tif_tradeserial_done_flush(&tradeserial);
					writelog(LOG_INFO,"补发冲正记录失败[%ld]", tradeserial.serial_no);
				}
				ret=db_commit();
				if(ret)
				{
					writelog(LOG_ERR,"db_commit ret[%d]",ret);
					db_rollback();
				}

			}
			else if( ret == DB_DISCONN || ret == DB_BADCONN)
			{
				// 与数据库连接中断，重新连接
				SQLConnectToServer();
				writelog(LOG_INFO,"与数据库连接中断[%d]，重新连接", ret);
			}

		}

		//做批量划拨
		/*
		char buffer[20]="";
		int ho_OpCount=0;
		double ho_Fee_Change=0;
		int ret=0;
		now = time(0);
		if((now - lasttrans) > inttrans)
		{
			writelog(LOG_INFO,"开始划拨", ret);

			lasttrans	= now;
			ret=GetParameter(GLOBE_FLAG_BALANCE,buffer);
			if(ret)
			{
				writelog(LOG_ERR,"Read syspara err [%d]",ret);
				if( ret == DB_DISCONN || ret == DB_BADCONN)
				{
					// 与数据库连接中断，重新连接
					SQLConnectToServer();
					writelog(LOG_INFO,"与数据库连接中断[%d]，重新连接", ret);
				}
				break;
			}
			//系统正在结算，可以生成划拨文件
			if(0==strcmp(buffer,"1"))
			if(true)
			{
				//置结算标志，开始划拨
				ret=SetParameter(GLOBE_FLAG_BALANCE,"2");
				if(ret)
				{
					writelog(LOG_ERR,"SetParameter error[%d]", ret);
				}
				ret=db_commit()
				if(ret)
				{	writelog(LOG_ERR,"db_commit [%d]", ret);
					db_rollback();	}

				ret=Do_Transfer(&bank_trans);
				if(ret)
				{
					writelog(LOG_ERR,"生成划拨文件失败[%d]", ret);
				}
				//划拨完成，置回该标志
				ret=SetParameter(GLOBE_FLAG_BALANCE,"1");
				if(ret)
				{
					writelog(LOG_ERR,"SetParameter error[%d]", ret);
				}
				ret=db_commit()
				if(ret)
				{	writelog(LOG_ERR,"db_commit [%d]", ret);
					db_rollback();	}

				writelog(LOG_INFO,"生成划拨文件成功[%d]", ret);
			}
		}
		*/
		//做银行对帐

		char buffer[20]="";
		//char time[10]="";
		int ho_OpCount=0;
		double ho_Fee_Change=0;
		int ret=0;
		now = time(0);
		if((now - lastcomp) > intcomp)
		{
			lastcomp=now;
			#ifdef DEBUG
				//writelog(LOG_ERR,"systime=[%s]", getsystime(NULL));
			#endif
			//判断系统时间是否到达早6点
			if(0==memcmp("06",getsystime(NULL),2))
			{
				ret=Do_Compare_file();
				if(ret)
				{
					writelog(LOG_ERR,"Do_Compare_file error[%d]", ret);
				}
				writelog(LOG_ERR,"Do_Compare_file complete");
			}
		}

		// 休眠
		sleep(5);//13938470950

	}

	p(semid);
	shm[3]=0;	// 置通信标志
	v(semid);

	shmdt(shm);
	shmctl(shmid,IPC_RMID,&buf);
	d_sem(semid);

	SQLExit();
	writelog(LOG_INFO, "程序正常退出");

printf("程序正常退出\n");

	return(0);

}
