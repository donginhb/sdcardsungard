/***********************************************************************************
  编码日志记录
  编码者: 陈永华
  编码日期 2004-2-7 15:36:16
  版本: V1.00 
  说明: 与各个sqc程序相关的全局变量和函数定义
 ***********************************************************************************/
#ifndef _FDSQC_H
#define _FDSQC_H

#include "cpack.h"
#include "mypub.h"
#include "bupub.h"
#include "pubfunc.h"

#define  SC_OK       0
#define  SC_NOTFOUND 100  	// No data found 
#define	 SC_SEVERE_ERR	-10000	// <10000者为严重错误
#include <sqlca.h>
extern struct sqlca sqlca;	// 全局sqlca, 在fdsqc.sqc里定义

#ifdef __cplusplus
extern "C" {
#endif
//////////////////////////////////////////////////////////////////////
// 目前只考虑单一数据库连接

void SQLErrorHandler();
void SQLInitialize();
void SQLExit();

// 函数名: SQLConnectToServer
// 编程  : 陈永华 2004-2-7 23:24:49
// 描述  : 根据g_SqlDB中定义的SQL数据库连接参数，建立连接
// 返回  : long   0: 表示连接成功；其他则连接失败，检查g_SqlDB中的SQL处理失败信息
long SQLConnectToServer();
int  SQLIsConnectOK();
int  TestSQLConnect();
void SQLDisconnect();

#ifdef _IN_SQC_

#ifdef SQLSERVER
EXEC SQL WHENEVER SQLERROR CALL SQLErrorHandler();
#else
#define SQLERRD1	(sqlca.sqlerrd[1])
//#define SQLERRMC	(char*) (sqlca.sqlerrmc)
#endif

#define SQLSTATE (char *)(sqlca.sqlstate)

#endif

#ifdef __cplusplus
}
#endif

#endif
