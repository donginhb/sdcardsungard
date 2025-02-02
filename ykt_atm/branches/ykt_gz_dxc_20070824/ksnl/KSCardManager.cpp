#include "stdafx.h"
#include ".\kscardmanager.h"
#include "KSConfig.h"
#include "KSWorkflow.h"
#include "ksutil.h"

//////////////////////////////////////////////////////////////////////////
// KSCardDLL 定义
// static HINSTANCE gsKSComHandle = NULL;
static HINSTANCE gsCardDLLHandle = NULL;

DEF_KSFUNC(Load_Dll)
DEF_KSFUNC(Load_WorkKey)
DEF_KSFUNC(SMT_PacketAddMomey)
DEF_KSFUNC(SMT_PacketDelMomey)
DEF_KSFUNC(SMT_PacketSetMoney)
DEF_KSFUNC(ReadBalance)
DEF_KSFUNC(ReadCardNO)
DEF_KSFUNC(SMT_SetBlackCardFlag)
DEF_KSFUNC(ConnectMF)
DEF_KSFUNC(CloseMF)
DEF_KSFUNC(ReadSerial)
DEF_KSFUNC(SMT_SetNormalFlag)
DEF_KSFUNC(SMT_WritePersonalPassword)
DEF_KSFUNC(UpdateCardInfo)
DEF_KSFUNC(ReadInfoFromCard)
DEF_KSFUNC(SMT_ReadWaterPackInfo)
DEF_KSFUNC(SMT_WriteWaterPackInfo)
DEF_KSFUNC(SMT_InitWaterInfo)
DEF_KSFUNC(SMT_WaterNewAuthCard)

//////////////////////////////////////////////////////////////////////////
// 错误与错误信息定义

static struct {
	int errcode;
	const char * errmsg;
}gs_errMap[] = {
	{ERR_LOADKSCOM_DLL,"加载KS动态库失败"},
	{ERR_READCARDID,"读取卡号失败"},
	{ERR_READBALANCE,"读取卡金额失败"},
	{ERR_CARD_NOT_CONSIST,"卡号不一致"},
	{ERR_LOAD_FUNC,"加载入口函数失败"},
	{ERR_SUCCEEDED,"成功"},
	{ERR_OPEN_COM,"打开串口失败"},
	{ERR_CLOSE_COM,"关闭串口失败"},
	{ERR_COM_NOT_OPEN,"串口未打开"},
	{ERR_CARD_NOT_EXIST,"未放卡"},
	{ERR_PACKAGE_SET_MONEY,"写卡余额失败"},
	{ERR_USER_CANCEL,"用户取消"},
	{ERR_MODIFY_CARD, "更新卡信息失败"},
	{ERR_READ_CARDINFO, "读取卡信息失败"},
	{-1,NULL}
};

//////////////////////////////////////////////////////////////////////////
// CKSCardManager static member
int CKSCardManager::ciCardId = 0x01;
int CKSCardManager::ciPhyId = 0x02;
int CKSCardManager::ciPswd = 0x04;
int CKSCardManager::ciBalance = 0x08;
int CKSCardManager::ciAllInfo = 0x0F;

bool CKSCardManager::ms_isComOpen = false;
CEvent CKSCardManager::ms_testCardEvent;
CEvent CKSCardManager::ms_cancelEvent;
const int CKSCardManager::ms_globalPackageNo = 1;

//////////////////////////////////////////////////////////////////////////
// 
#if 1
#define TEST_COM_OPEN \
	if(!CKSCardManager::ms_isComOpen) { this->m_errno = ERR_COM_NOT_OPEN;return -1;}
#else
#define TEST_COM_OPEN
#endif

//////////////////////////////////////////////////////////////////////////
// CKSCardManager 定义
CKSCardManager::CKSCardManager(CKSConfig * config,const char* workKey,CKSWorkflow * workflow)
:m_config(config),m_errno(ERR_SUCCEEDED),m_workflow(workflow)
{
	strncpy(m_workKey,workKey,sizeof m_workKey);
//	if(LoadKSCom())
	if (LoadCardCom())
	{
//		AfxMessageBox("加载CardDLL失败");
	}
}

CKSCardManager::~CKSCardManager(void)
{
//	ReleaseKSCom();
	CloseCOM();
	ReleaseCardCom();
}

DWORD CKSCardManager::GetLastKey()
{
	if(m_workflow)
	{
		return m_workflow->GetLastKeyCode();
	}
	return -1;
}
int CKSCardManager::ReadCardInfo(KS_CARD_INFO * cardinfo,int ciBit,int timeout/*=-1*/)
{
	TEST_COM_OPEN;
	int ret;
	char msg[128];
	if(TestCardExists(timeout))
	{
  		return -1;
	}
	KS_CARD_INFO tmp;
	memcpy(&tmp,cardinfo,sizeof tmp);
	int buf1[1],buf2[1];
	if(ciBit & ciCardId)
	{
		if((ret = ReadCardNO(buf1)) != 0)
		{
			m_errno = ERR_READCARDID;
			return ret;
		}
		tmp.cardid = buf1[0];
	}
	if(ciBit & ciBalance)
	{
		if(ReadBalance(1,buf1,buf2)!=0)
		{
			m_errno = ERR_READBALANCE;
			return -1;
		}
		tmp.balance = (double)buf1[0] / 100.0;
		tmp.tx_cnt = buf2[0];	
	}
	if(ciBit & ciPhyId)
	{
		memset(msg,0,sizeof msg);
		if(ReadSerial((unsigned char*)msg) != 0)
		{
			m_errno = ERR_READCARDID;
			return ret;
		}
		HexToAscii((unsigned char*)msg,4,(char*)tmp.phyid);
	}
	m_errno = ERR_SUCCEEDED;
	memcpy(cardinfo,&tmp,sizeof(KS_CARD_INFO));
	return 0;
}

int CKSCardManager::AddMoney(int cardid,int money)
{
	TEST_COM_OPEN;
	if(TestCardExists(10))
	{
		return -1;
	}
	KS_CARD_INFO cardinfo;
	memset(&cardinfo,0,sizeof cardinfo);
	if(ReadCardInfo(&cardinfo,ciCardId) != 0)
	{
		return -1;
	}
	if(cardinfo.cardid != cardid)
	{
		m_errno = ERR_CARD_NOT_CONSIST;
		return -1;
	}
	if(money > 0)
	{
		if(SMT_PacketAddMomey(ms_globalPackageNo,money) != 0)
		{
			m_errno = ERR_PACKAGE_ADD_MONEY;
			return -1;
		}
	}
	else if(money < 0)
	{
		if(SMT_PacketDelMomey(ms_globalPackageNo,abs(money)) != 0)
		{
			m_errno = ERR_PACKAGE_DEC_MONEY;
			return -1;
		}
	}
	return 0;
}

int CKSCardManager::SetMoney(int cardid,int money)
{
	TEST_COM_OPEN;
	if(TestCardExists(10))
	{
		return -1;
	}
	KS_CARD_INFO cardinfo;
	memset(&cardinfo,0,sizeof cardinfo);
	if(ReadCardInfo(&cardinfo,ciCardId) != 0)
	{
		return -1;
	}
	if(cardinfo.cardid != cardid)
	{
		m_errno = ERR_CARD_NOT_CONSIST;
		return -1;
	}
	if(SMT_PacketSetMoney(ms_globalPackageNo,money) != 0)
	{
		m_errno = ERR_PACKAGE_SET_MONEY;
		return -1;
	}
	return 0;
}

// 更新卡信息
int CKSCardManager::ModifyCardInfo(int cardid, TPublishCard *pc)
{
	TEST_COM_OPEN;
	if (TestCardExists(10))
	{
		return -1;
	}
	KS_CARD_INFO cardinfo;
	memset(&cardinfo,0,sizeof cardinfo);
	if (ReadCardInfo(&cardinfo, ciCardId))
	{
		return -1;
	}
	if (cardinfo.cardid != cardid)
	{
		m_errno = ERR_CARD_NOT_CONSIST;
		return -1;	
	}
	if (UpdateCardInfo(pc))
	{
		m_errno = ERR_MODIFY_CARD;
		return -1;
	}
	return 0;
}

// 读取卡信息
int CKSCardManager::ReadCardInformation(int cardid, TPublishCard *pc)
{
	TEST_COM_OPEN;
	if (TestCardExists(10))
	{
		return -1;
	}
	KS_CARD_INFO cardinfo;
	memset(&cardinfo,0,sizeof cardinfo);
	if (ReadCardInfo(&cardinfo, ciCardId))
	{
		return -1;
	}
	if (cardinfo.cardid != cardid)
	{
		m_errno = ERR_CARD_NOT_CONSIST;
		return -1;	
	}
	if (ReadInfoFromCard(pc))
	{
		m_errno = ERR_READ_CARDINFO;
		return -1;
	}
	return 0;
}

// int CKSCardManager::LoadKSComDLL()
// {
// 	gsKSComHandle = LoadLibrary(m_config->m_KSComDLLPath);
// 	if(NULL == gsKSComHandle)
// 	{
// 		m_errno = ERR_LOADKSCOM_DLL;
// 		return -1;
// 	}
// 	m_errno = ERR_LOAD_FUNC;
// 	LOAD_KSFUNC(gsKSComHandle,Load_Dll);
// 	LOAD_KSFUNC(gsKSComHandle,Load_WorkKey);
// 	LOAD_KSFUNC(gsKSComHandle,PacketAddMoney);
// 	LOAD_KSFUNC(gsKSComHandle,PacketDecMoney);
// 	LOAD_KSFUNC(gsKSComHandle,ReadBalance);
// 	LOAD_KSFUNC(gsKSComHandle,ReadCardNo);
// 	LOAD_KSFUNC(gsKSComHandle,SetBlackCardFlag);
// 	LOAD_KSFUNC(gsKSComHandle,ComInit);
// 	LOAD_KSFUNC(gsKSComHandle,COMClose);
// 	LOAD_KSFUNC(gsKSComHandle,SetNormalFlag);
// 	LOAD_KSFUNC(gsKSComHandle,ChangePassWord);
// 	LOAD_KSFUNC(gsKSComHandle,ReadSerial);
// 	LOAD_KSFUNC(gsKSComHandle,PacketSetMoney);
// 	m_errno = ERR_SUCCEEDED;
// 	return 0;
// }

int CKSCardManager::LoadCardDLL()
{
	gsCardDLLHandle = LoadLibrary(m_config->m_CardDLLPath);
//	AfxMessageBox(m_config->m_CardDLLPath);
	if(NULL == gsCardDLLHandle)
	{
		m_errno = ERR_LOADKSCOM_DLL;
		return -1;
	}
	m_errno = ERR_LOAD_FUNC;
	LOAD_KSFUNC(gsCardDLLHandle,Load_Dll);
//	TRACE("%d\n", Load_Dll);
	LOAD_KSFUNC(gsCardDLLHandle,Load_WorkKey);
//	TRACE("%d\n", Load_WorkKey);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_PacketAddMomey);
//	TRACE("%d\n", SMT_PacketAddMomey);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_PacketDelMomey);
//	TRACE("%d\n", SMT_PacketDelMomey);
	LOAD_KSFUNC(gsCardDLLHandle,ReadBalance);
//	TRACE("%d\n", ReadBalance);
	LOAD_KSFUNC(gsCardDLLHandle,ReadCardNO);
//	TRACE("%d\n", ReadCardNO);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_SetBlackCardFlag);
//	TRACE("%d\n", SMT_SetBlackCardFlag);
	LOAD_KSFUNC(gsCardDLLHandle,ConnectMF);
//	TRACE("%d\n", ConnectMF);
	LOAD_KSFUNC(gsCardDLLHandle,CloseMF);
//	TRACE("%d\n", CloseMF);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_SetNormalFlag);
//	TRACE("%d\n", SMT_SetNormalFlag);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_WritePersonalPassword);
//	TRACE("%d\n", SMT_WritePersonalPassword);
	LOAD_KSFUNC(gsCardDLLHandle,ReadSerial);
//	TRACE("%d\n", ReadSerial);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_PacketSetMoney);
//	TRACE("%d\n", SMT_PacketSetMoney);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_ReadWaterPackInfo);
//	TRACE("%d\n", SMT_ReadWaterPackInfo);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_WriteWaterPackInfo);
//	TRACE("%d\n", SMT_WriteWaterPackInfo);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_InitWaterInfo);
//	TRACE("%d\n", SMT_InitWaterInfo);
	LOAD_KSFUNC(gsCardDLLHandle,SMT_WaterNewAuthCard);
//	TRACE("%d\n", SMT_WaterNewAuthCard);
	LOAD_KSFUNC(gsCardDLLHandle,ReadInfoFromCard);
	LOAD_KSFUNC(gsCardDLLHandle,UpdateCardInfo);
	m_errno = ERR_SUCCEEDED;
//	AfxMessageBox(m_config->m_CardDLLPath);       // 测试加载KS_SMTCard.dll
	return 0;	
}

// int CKSCardManager::LoadKSCom()
// {
// 	int ret = LoadKSComDLL();
// 	if(ret!=0)
// 	{
// 		return ret;
// 	}
// 	if(Load_WorkKey(m_workKey) != 0)
// 	{
// 		m_errno = ERR_SETWORKKEY;
// 		return -1;
// 	}
// 	return 0;
//}

int CKSCardManager::LoadCardCom()
{
	int ret = LoadCardDLL();
	if (ret != 0)
	{
		return ret;
	}
	//////////////////////////////////////////////////////////////////////////
	// 这里加一句话，以调用SMARTDXQ411.dll里面的函数
	ret = Load_Dll();
	if (ret != 0)
	{
		return ret;
	}
	//////////////////////////////////////////////////////////////////////////
	//AfxMessageBox(m_workKey);
	if (Load_WorkKey(m_workKey) != 0)                          // 这里出现问题
	{
		m_errno = ERR_SETWORKKEY;
		return -1;
	}
	return 0;
}

/*int CKSCardManager::ReleaseKSCom()*/
int CKSCardManager::ReleaseCardCom()
{
	if(gsCardDLLHandle != NULL)
	{
		FreeLibrary(gsCardDLLHandle);
		gsCardDLLHandle = NULL;
	}
	return 0;
}

CString CKSCardManager::GetErrMsg()
{
	int i = 0;
	while(gs_errMap[i].errcode != -1)
	{
		if(gs_errMap[i].errcode == m_errno)
		{
			return CString(gs_errMap[i].errmsg);
		}
		i++;
	}
	return "";
}

int CKSCardManager::OpenCOM()
{
	if(!ms_isComOpen)
	{
//		if(ConnectMF((LPSTR)(LPCTSTR)m_config->m_RFComPort,0) != 0)
		CString cs = m_config->m_RFComPort.Right(1);
		int port = atoi((LPSTR)(LPCTSTR)cs);
		if (ConnectMF(port, 19200) != 0)
		{
			m_errno = ERR_OPEN_COM;
			return -1;
		}
		ms_isComOpen = true;
	}
	return 0;
}

int CKSCardManager::CloseCOM()
{
	if(ms_isComOpen)
	{
		CloseMF();
		ms_isComOpen = false;
	}
	return 0;
}
bool CKSCardManager::IsCOMOpen()
{
	return ms_isComOpen;
}

int CKSCardManager::TestCardExists(int timeout)
{
	TEST_COM_OPEN;
	DWORD key;
	m_timeout = timeout;
	CWinThread * pThread = AfxBeginThread(CKSCardManager::TestCardThread
		,(LPVOID)this,THREAD_PRIORITY_NORMAL,0,CREATE_SUSPENDED,NULL);
	ms_testCardEvent.ResetEvent();
	ms_cancelEvent.ResetEvent();
	pThread->ResumeThread();
	while(1)
	{
		key = m_workflow->GetLastKeyCode();
		if(VK_ESCAPE == key)
		{
			ms_cancelEvent.SetEvent();
			while(WaitForSingleObject(ms_testCardEvent,1000) == WAIT_OBJECT_0)
			{
				goto L_END;
			}
		}
		// 读卡完成
		if(WaitForSingleObject(ms_testCardEvent,0) == WAIT_OBJECT_0)
		{
			if(!m_errno)
				return 0;
			else
				return -1;
		}
	}
L_END:
	return -1;
}

UINT CKSCardManager::TestCardThread( LPVOID pParam )
{
	CKSCardManager * manager = (CKSCardManager*)pParam;
	int tick = manager->m_timeout * 2; // 500 * m_timeout * 2 ms
	int i;
	unsigned char serial[20] = "";
	do 
	{
		memset(serial,0,sizeof serial);
		manager->m_errno = ERR_CARD_NOT_EXIST;
		
		if(!ReadSerial(serial)) //&& strlen((char*)serial) == 8)
		{	
			manager->m_errno = ERR_SUCCEEDED;
			break;
		}
		
		i = 0;
		// 等待 500 ms
		while(i < 500)
		{
			if(WaitForSingleObject(ms_cancelEvent,0) == WAIT_OBJECT_0)
			{
				// 如果请求已经被取消退出
				// TRACE0(_T("exits all"));
				goto L_END;
			}
			Sleep(10);
			i += 10;
		}	
	} while(--tick > 0);
L_END:
	//m_errno = ERR_CARD_NOT_EXIST;
	ms_testCardEvent.SetEvent();
	AfxEndThread(0);
	return 0;
}

int CKSCardManager::ReadCard(KS_CARD_INFO *cardinfo,int ciBit)
{
	int ret = this->ReadCardInfo(cardinfo,ciBit, 20);
	if(ret)
	{
		ret = this->GetErrNo();
		if(ERR_USER_CANCEL == ret)
		{
			return RET_WF_TIMEOUT;
		}
		return RET_WF_ERROR;
	}
	return RET_WF_SUCCESSED;
}