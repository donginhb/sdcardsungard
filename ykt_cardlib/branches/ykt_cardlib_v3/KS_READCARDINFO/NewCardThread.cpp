// NewCardThread.cpp : implementation file
//
#include "stdafx.h"
#include "NewCardThread.h"
#include "ReadCardInfoDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CNewCardThread


CNewCardThread::~CNewCardThread()
{
}

BOOL CNewCardThread::InitInstance()
{
	// TODO:  perform and per-thread initialization here
	return TRUE;
}

int CNewCardThread::ExitInstance()
{
	// TODO:  perform any per-thread cleanup here
	return CWinThread::ExitInstance();
}

BEGIN_MESSAGE_MAP(CNewCardThread, CWinThread)
	//{{AFX_MSG_MAP(CNewCardThread)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CNewCardThread message handlers

int CNewCardThread::DoInit()
{
	int ret = -1;
	unsigned char ucSerialNo[5];
	char phyid[9] = "";
//	char stuemp_no[21] = ""; 
	int _Mode = ((CReadCardInfoDlg*)m_pMainWnd)->m_nInvokeMode;
	int t_card_flag = ((CReadCardInfoDlg*)m_pMainWnd)->m_card_flag;

	if (SMT_SleepCard() != 0) { return 0; }

	// 读取授权卡
	if (_Mode == 0)
	{
		if (CARDFLAG_PHYSICALID == t_card_flag)
		{
			ret = ReadSerial(ucSerialNo);
			if (ret)
			{
				Sleep(500);
				return 0;
			}

			dec2hex(ucSerialNo, 4, phyid);
			((CReadCardInfoDlg*)m_pMainWnd)->SimulateKeyPress(phyid);
		}
		else
		{
			TPublishCard CI;
			memset(&CI, 0, sizeof(CI));
			ret = ReadCardInfo(&CI);
			if (ret) { return 0; }

			((CReadCardInfoDlg*)m_pMainWnd)->SimulateKeyPress(CI, t_card_flag);
		}
	}
	// 从后台获得密钥信息
	else if (_Mode == 1)
	{
		if (CARDFLAG_PHYSICALID == t_card_flag)
		{
			ret = ReadSerial(ucSerialNo);
			if (ret)
			{
				Sleep(500);
				return 0;
			}

			dec2hex(ucSerialNo, 4, phyid);
			((CReadCardInfoDlg*)m_pMainWnd)->SimulateKeyPress(phyid);
		}
		else
		{
			TPublishCard CI;
			memset(&CI, 0, sizeof(CI));
			ret = ReadCardInfo(&CI);
			if (ret) { return 0; }
			
			((CReadCardInfoDlg*)m_pMainWnd)->SimulateKeyPress(CI, t_card_flag);
		}
	}
	else
	{			
		return 0;
	}
	Sleep(1000);
	
	return 0;
}

CNewCardThread::CNewCardThread(CWnd *pWnd)
{
	pre_card_id = 0;	
	m_pMainWnd = pWnd;
}

int CNewCardThread::Run()
{
	while (!m_terminate)
	{
		if (DoInit() != 0)
		{
			::AfxMessageBox("读卡失败!");
			break;
		}
	}
	if (m_pMainWnd)
	{
		m_pMainWnd->PostMessage(WM_INIT_THREAD_TERM, 0, 0);
	}
	Reset();
	SMT_SleepCard();
	return CWinThread::Run();
}

void CNewCardThread::Reset()
{
	pre_card_id = 0;
	if (m_hThread != NULL)
	{
		CloseHandle(m_hThread);
		m_hThread = NULL;
	}
	m_index = 0;
	return ;
}
