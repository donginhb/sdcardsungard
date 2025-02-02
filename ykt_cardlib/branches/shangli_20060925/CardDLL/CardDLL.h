//使用预编译指令保证头文件只能被包含一次
#ifndef __CardDLL_H__
#define __CardDLL_H__

//用预编译指令使C函数能被C++程序直接调用
#ifdef __cplusplus
extern "C" {
#endif


//发行卡结构定义
#pragma pack(1)

typedef struct               
{
	unsigned char ShowCardNo[11];			//用户卡显示卡号
	unsigned char CardNo[8];				//用户卡交易卡号
	unsigned char DeadLineDate[9];			//用户卡使用截止日期
	int CardRightType;						//用户卡使用权限类型（1--254）
	unsigned char ucName[9];				//姓名
	unsigned char ucDutyNo[9];				//职务代码
	unsigned char ucCertificateNo[21];		//证件号码
	unsigned char ucDepartmentNo[11];		//部门编号
	unsigned char ucIdentifyNo[5];			//身份代码
	unsigned char ucSexNo[2];				//性别代码
	unsigned char ucCardNo[21];				//卡号（工号或学号）
	unsigned char ucPwd[6];					//卡密码
	unsigned char ucLibraryNo[21];			//图书证号
	int Money;								//金额（分）
	unsigned char isFormat;					//是否格式化第一扇区
}TPublishCard;

typedef struct
{
		DWORD RemainMoney;			// 电子钱包余额
		WORD DealTimes;				// 用户卡交易流水号
		BYTE DealYear;				// 交易日期
		BYTE DealMonth; 
		BYTE DealDay;
		BYTE DealHour;
		BYTE DealMin;
		BYTE DealTimes_CurTime;		// 累计交易次数(当前时间段内)
		BYTE DealTimes_CurDay;		// 累计交易次数(当日内)
} LOOPPURSEINFO ,*LPLOOPPURSEINFO;

typedef struct 
{
	int bala;
	int daybala;
	int total_cnt;
	int day_cnt;
	int time_cnt;
	int date;	//yyyymmdd
	int time;	//hhmmss
}MONEY_PACK_INFO;

typedef struct
{
	char cardtype;
	int termid;
	int remain;
	BYTE oldSerialNo[4];
}WATER_PACK_INFO;

/******************************************************/
// 费率结构
/******************************************************/
typedef struct  
{
	BYTE time_ladder[1];				// 时间阶梯
	BYTE deduct_time[1];				// 扣费的单位时间，以秒为单位
	BYTE deduct_fee[1];					// 扣费的单位金额，以分为单位
}FEE_RATE;

/******************************************************/
// 当前权限的费率个数
/******************************************************/
typedef struct
{
	short right_flag;					// 权限标志, 1打开, 0关闭
	short right_num;					// 传入当前权限下的费率个数
	FEE_RATE fee_rate[5];				// 最大设置为5个, 其实有一些没有用到
}FEE_RIGHT_NO;

/*******************************************************/
// 费率卡结构说明
/*******************************************************/
typedef struct  
{
	BYTE water_card_flag[5];			// 水控卡标志
	char packet_num;					// 水控钱包号
	BYTE main_work_key[9];				// 主工作密钥(明文)
	BYTE packet_work_key[9];			// 小钱包工作密钥(明文)
	BYTE data_length[3];				// 数据长度
	BYTE check_crc[2];					// 效验字节
	FEE_RIGHT_NO fee_right_num[256];	// 设置费率的个数
}FEE_RATE_CARD_INFO;

typedef struct  
{
	char   devphy999_id[9];
	double sum_balance;
}COLLECT_BALANCE;

#define WATER_AUTH_CARD 1
#define WATER_COMMON_CARD 2
#define WATER_CLEAR_CARD 3
#define WATER_NEW_CARD 4
#define WATER_FIXED_CARD 5
#define WATER_CLEAR_CARD2 6

// 来自于COMM.H的数据结构
// #define	STX1	0xC0
// #define	ETX1	0xC1
// #define	STX2	0xC2
// #define	ETX2	0xC3
// //----------------------------
// int ErrorCode;
// BYTE Dll_RetData[500];
// int Dll_CommByte;
// int Dll_bps = 19200;
// BYTE Dll_MacNo;
// COMMTIMEOUTS CommTimeOuts;
// unsigned char subkey[17][49];

// 来自于COMM.H的数据结构

#pragma pack()


//十进制字符串转换为BCD字符串
int __stdcall dec2bcd(unsigned char *sDecStr,unsigned char *sBcdStr,int bcd_len);

//BCD字符串转换为十进制字符串
int __stdcall bcd2dec(unsigned char *sBcdStr,int bcd_len,unsigned char *sDecStr);

//打开串口
int __stdcall ConnectMF(int,int);

//关闭串口
int __stdcall CloseMF(void);

//休眠卡程序
int __stdcall HaltCard(void);

//读卡器鸣叫
int __stdcall ControlBuzzer();

//读写器授权
int __stdcall ReaderAuthor(unsigned char *);

//读卡物理序列号
int __stdcall RequestCard(char *,char *);

//发行卡
int __stdcall PublishCard(TPublishCard *pc);

//读卡信息
int __stdcall ReadCardInfo(TPublishCard *pc);

//读用户卡钱包信息
int __stdcall ReadPacketInfo(LOOPPURSEINFO *LoopPurseInfo);

//更新卡信息
int __stdcall UpdateCardInfo(TPublishCard *CardInfo);

//读交易卡号
int __stdcall ReadCardNO(int nCardNo[1]);

int __stdcall WriteCardPwd(unsigned char pwd[6]);
int __stdcall ReadCardPwd(unsigned char pwd[6]);
int __stdcall Load_Dll();
int __stdcall GetLastErrMsg(int ecode[1],char *errmsg);

// 读大钱包余额 
int __stdcall ReadBalance(int nPacketNo,int nBalance[1],int nCnt[1]);

// 读取卡序列号
int __stdcall ReadSerial(unsigned char *serial);

// 用于新大陆和明华的读卡程序
int __stdcall Load_WorkKey(char *ascWorkKey);

//////////////////////////////////////////////////////////////////////////
// 新添加的操作, 来自于SMARTCOM411DXQ
// int SMT_Philips_Packet_Proc(int flag,int Sector,int BlockNo,int Money,unsigned char *BlockBuf);        // (此函数未有使用到, 但是SMARTCOM411DXQ接口实现了)
// int SMT_Copy_DataBlock(int Sector,int souBlock,int desBlock,unsigned char *BlockBuf);			      // (此函数未有使用到, 但是SMARTCOM411DXQ接口实现了)
extern int nAutoFlag;
int __stdcall SMT_JudgeAutoFlag();
int __stdcall SMT_AutoDll(unsigned char *ucWorkingKey);                                                                                
int __stdcall SMT_CreateGreyCard(BOOL bPersonalFlag,BOOL bStateFlag, BOOL bBankInfo,BOOL bPacketFlag[8]);           // (此函数未有使用到)
int __stdcall SMT_WriteCardStateInfo(unsigned char ucShowCardNo[5], int nDealCardNo[1], 
									 unsigned char ucDeadLineDate[3], unsigned char ucCardRightType[1]);            // (使用到)
int __stdcall SMT_ReadCardStateInfo(unsigned char ucShowCardNo[5],
								    int nDealCardNo[1],
								    unsigned char ucDeadLineDate[3],
								    unsigned char ucCardRightType[1]);												// (使用到)                                                                    
int __stdcall SMT_ChangeShowCardNo(unsigned char ucShowCardNo[5]);                                                  // (使用到)
int __stdcall SMT_ChangeDeadLineDate(unsigned char ucDeadLineDate[3]);                                              // (使用到)
int __stdcall SMT_ChangeDealCardNo(int nDealCardNo);
int __stdcall SMT_ChangeCardRightType (unsigned char ucCardRightType[1]);                                           // (使用到)
int __stdcall SMT_WritePersonalInfo(unsigned char ucName[8],
									unsigned char ucDutyNo[4],
									unsigned char ucCertificateNo[20],
									unsigned char ucDepartmentNo[10],
									unsigned char ucIdentifyNo[4],
									unsigned char ucSexNo[1],
									unsigned char ucCardNo[20]);                                                    // (使用到)
int __stdcall SMT_ReadPersonalInfo(unsigned char ucName[8],
								   unsigned char ucDutyNo[4],
								   unsigned char ucCertificateNo[20],
								   unsigned char ucDepartmentNo[10],
								   unsigned char ucIdentifyNo[4],
								   unsigned char ucSexNo[1],
								   unsigned char ucCardNo[20]);                                                     // (使用到)
int __stdcall SMT_ChangeName(unsigned char ucName[8]);                                                              // (使用到)
int __stdcall SMT_ChangeDutyNo(unsigned char ucDutyNo[4]);                                                          // (使用到)
int __stdcall SMT_ChangeCerificateNo (unsigned char ucCertificateNo[20]);                                           // (使用到)                
int __stdcall SMT_ChangeDepartmentNo(unsigned char ucDepartmentNo[10]);                                             // (使用到)
int __stdcall SMT_ChangeIdentifyNo (unsigned char ucIdentifyNo[4]);                                                 // (使用过)
int __stdcall SMT_ChangeSexNo (unsigned char ucSexNo[1]);                                                           // (使用过)
int __stdcall SMT_ChangeCardNo(unsigned char ucCardNo[20]);                                                         // (使用过)
int __stdcall SMT_WritePersonalPassword(unsigned char PersonalPsd[3]);                                              // (使用过)
int __stdcall SMT_ReadPersonalPassword(unsigned char PersonalPsd[3]);                                               // (使用过)
int __stdcall SMT_WriteLibraryNo(unsigned char ucLibraryNo[13]);                                                    // (使用过)
int __stdcall SMT_ReadLibraryNo(unsigned char ucLibraryNo[13]);                                                     // (使用过)
int __stdcall SMT_WriteBankCardNo(unsigned char ucBankCardNo[10]);                                                  // (使用过)
int __stdcall SMT_ReadBankCardNo(unsigned char  ucBankCardNo[10]);                                                  // (使用过)
int __stdcall SMT_ReadPacketInfo(int nPacketNo, LOOPPURSEINFO *LoopPurseInfo);                                      // (使用过)
int __stdcall SMT_PacketAddMomey(int nPacketNo,int nMoney);															// (使用过)			
int __stdcall SMT_PacketDelMomey(int nPacketNo,int nMoney);															// (使用过)	
int __stdcall SMT_PacketSetMoney(int nPacketNo,int nMoney);															// (使用过)
int __stdcall SMT_PacketReset(int nPacketNo);																		// (使用过)	
int __stdcall SMT_WriteAssistInfo (int nBatchNo[1],int nMoney[1]);												    // (未有使用过)
int __stdcall SMT_ReadAssisInfo(int nBatchNo[1],int nMoney[1],
								unsigned char ucBatchTime[5], unsigned char ucMacNo[4]);							// (未有使用过)							
int __stdcall SMT_SetBlackCardFlag();																                // (使用过)
int __stdcall SMT_SetNormalFlag();																				    // (使用过) 	
int __stdcall SMT_SetNormalFlagByBlkVerion(char *blkversion);														// (使用过)			
int __stdcall SMT_ClearCard();																					    // (使用过)
int __stdcall SMT_ReadAuthCardFlag(short * flag);																	// (使用过)	 						
int __stdcall SMT_ReadAuthCard2(unsigned char ucWorkKey[8],short * flag);											// (使用过)
int __stdcall SMT_ReadAuthCard(unsigned char ucWorkKey[8]);														    // (使用过)		
int __stdcall SMT_ResetCard();																					    // (使用过)			 	
int __stdcall SMT_ResetPacketInfo(int nPacketNo);																	// (使用过)	
int __stdcall SMT_GetPacketInfo(int nPacketNo, MONEY_PACK_INFO *pPackInfo);										    // (使用过)
int __stdcall SMT_SetPacketInfo(int nPacketNo,MONEY_PACK_INFO *pPackInfo);										    // (使用过)		
int __stdcall SMT_SetTxCnt(int nPacketNo,int tx_cnt);																// (使用过)			
int __stdcall SMT_ReadBlackNameListVersion(int *flag,char *version);                                                // (使用过) 
int __stdcall SMT_ReadWaterPackInfo(WATER_PACK_INFO* info);
int __stdcall SMT_WriteWaterPackInfo(WATER_PACK_INFO* info);
int __stdcall SMT_WaterSetCapability(int value);
int __stdcall SMT_InitWaterInfo(const WATER_PACK_INFO* info);
int __stdcall SMT_WaterNewAuthCard();
void GetIniFile(char *FilePathBuf);
void GetIniFileFromDll(char *FilePathBuf);

//	初始化卡程序所有调用函数
#define E_COM_NOT_OPEN 10001
#define E_COM_NOT_CLOSE 10002

#define E_READ_CARD_ID_ERROR 10005
#define E_GEN_CARD_KEY_A_ERROR 10006
#define E_GEN_CARD_KEY_B_ERROR 10007

#define E_READ_CARD_ERROR 10010
#define E_CARD_LOGIN_ERROR 10011
#define E_MAIN_KEY_ERROR 10012
#define E_CARD_WRITE_ERROR 10020

#define E_INVALID_CARD 10030
#define E_CARD_FLAG_ERROR 10040	

typedef struct _tagCardKeyData
{
	long flag;
	BYTE key[7];
} CardKeyData,* PCardKeyData;

typedef int (*PWriteDataFunc)(long sect,CardKeyData * keya 
							  ,CardKeyData * keyb ,BYTE * card_type
							  ,CardKeyData * login_key);

typedef void (*LPGetBlockData)(int sect,int block,BYTE *buf
							   ,BYTE *key,long flag);
// 回调函数
typedef void (CALLBACK * LPProcessCallBack)(int step);

int __stdcall InitNewCard(int * err_code, const char* showcardno, LPProcessCallBack lpCallBack);
int __stdcall ReadCardMainKey(BYTE * main_key, short wantFlag, short * readFlag);
int __stdcall ReadCardPhyID(BYTE card_id[4],BYTE card_type[2]);
int __stdcall RefineCard(int *err_code,LPProcessCallBack lpFunc);
int __stdcall ReadCardBlock(int startSect,int endSect,short block,LPGetBlockData lpFunc);
int __stdcall ResetMainKey();
int __stdcall SetCardMainKey(BYTE main_key[8]);
int __stdcall ResetAuthCard(int * err_code,LPProcessCallBack lpCallBack);

//////////////////////////////////////////////////////////////////////////
// 上海理工水控业务函数
void GenerateKeyA(BYTE Srn[4], BYTE KeyA[6]);
int __stdcall SMT_ClearWaterCard();
int __stdcall RefineWaterCard(int *err_code, LPProcessCallBack lpFunc);
int __stdcall SMT_WriteWaterCardFlag(BYTE water_card_flag[4]);
int __stdcall InitNewCollectionCard(int *err_code, LPProcessCallBack lpCallBack);
int __stdcall ReadWaterCardBlock(int startSect, int endSect, short block, LPGetBlockData lpFunc);
int Login_Collect_Card(int sector);
int __stdcall WaterTransferSmallPacket(int BigPacketNo, int SmallPacketNo, int nMoney);
int __stdcall ReadCollectCardInfo(FEE_RATE_CARD_INFO *fee_rate_card_info);
int __stdcall SMT_ClearCollectCardData();
int __stdcall SMT_ReadWaterCardFlag(BYTE WaterCardFlag[4]);
//////////////////////////////////////////////////////////////////////////

#ifdef __cplusplus
}
#endif

#endif
