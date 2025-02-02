/****************************************************************************
*
*文件(File):         mifare.c
*
*修改(Modify):       2011/7/28 13:34:51
*
*作者(Author):       USER
*
*编绎(Compile):      智能平台(Smart Platform)
*
*描述(Description):
*
*
*
----------------------------------------------------------------------------
|
| Version | Datetime             |   Author    | Description
| --------+----------------------+-------------+----------------------------
|
| V1.00  2011/7/28 13:34:51           USER 
----------------------------------------------------------------------------
****************************************************************************/
#include "in_call.h"
int M1_start(unsigned char* PICCsnr, unsigned char* ATQ, unsigned char* ATS);	//启动M1卡
/***********************************************************************
		module		:	[M1卡读写]
		function		:	[10秒内读M1卡]
  		return		:	[0:成功
  						-1:失败]
		comment	:	[全局普通函数]
		machine		:	[EH-0818]
		language	:	[CHN]
 		keyword		:	[CPU_CARD]
		date			:	[11/07/28]
 		author		:	[chen-zhengkai]
************************************************************************/
char readM1Card(char (*card_r)())
{
	char dspBuf[20] = {0};	//显示内存
	char retStr[] = "按任意键返回";
	char str[20] = {0};
	unsigned char cnt = 0;	//读卡计时数
	char read_ok = 0;	//读卡结果 0:成功 	1:失败
	char TempStatus = 0;
	
	if( RCX_Init(CARD_TYPE_14443A) != RCX_OK ) {	//ISO14443协议TypeA 型卡初始化
		DispStr_CE(0,6,"打开接口错误",DISP_POSITION|DISP_CLRSCR);
		DispStr_CE(0,10,retStr,DISP_POSITION);
		delay_and_wait_key( 3, EXIT_KEY_ALL, 0 );
		return -1;
	}
	
	DispStr_CE(0,2,"请在10秒内刷卡",DISP_CENTER|DISP_CLRSCR);
	Sys_Timer_Start(SYS_TIMER1,64);	//启动系统定时器，间隔为1秒
	for (cnt = READ_CARD_SECOND, read_ok = 1; cnt && read_ok; ) {
		if (!Sys_Timer_Read(SYS_TIMER1)) {	//1秒钟计时到，定时器自动关闭
			cnt--;
			sprintf(str, "请在%d秒内刷卡", cnt);
			DispStr_CE(0,2,str,DISP_CENTER|DISP_CLRLINE);
			Sys_Timer_Start(SYS_TIMER1,64);	//重新启动定时器
		}
		TempStatus = card_r();	//读卡操作
		if (!TempStatus) {	//读卡成功
			read_ok = 0;
		}
		if (KEY_Read()==KEY_F1) {
			break;
		}		
	}
	RCX_Close();
	if ( read_ok ) {	//读卡失败
		if (TempStatus == -1) {
			strcpy(dspBuf, "未读到合法卡");
		}
		else  if (TempStatus == -2) {
			strcpy(dspBuf, "EEPROM读写失败");
		}
		DispStr_CE(0, 6, dspBuf, DISP_CENTER|DISP_CLRSCR);
		DispStr_CE(0, 10, retStr, DISP_CENTER);
		delay_and_wait_key( 3, EXIT_KEY_ALL, 0 );
		return -1;
	}
	return 0;
}
/***********************************************************************
		module		:	[M1卡读写]
		function		:	[读授权卡M1（获取密钥）]
  		return		:	[0:读卡成功
						-1:读卡失败
						-2:eeprom写入失败]
		comment	:	[全局普通函数]
		machine		:	[EH-0818]
		language	:	[CHN]
 		keyword		:	[CPU_CARD]
		date			:	[11/07/28]
 		author		:	[chen-zhengkai]
************************************************************************/
char readAuthorizeCard()
{
	int	ret = RCX_OK;
	unsigned char 	ATQ[3] = {0};		//请求应答(2 bytes)
	unsigned char 	PICCsnr[5] = {0};	//物理卡号(4 bytes) 
	unsigned char 	ATS[2] = {0};		//选择码应答，对于mifare1:0x08(1 byte)
	unsigned char 	rdata[16] = {0};	//读取BUFFER
	unsigned char keya[6] = {0};		//keyA密钥
	char temp[4] = {0};					//逆序存放的物理ID号
	unsigned char main_key[8] = {0};	//主密钥
	int sectno = 0;				//扇区号
	int blockno = 0;			//块号
	int key_block = 0;			//
	int key_pos = 0;			//

	ret = M1_start(PICCsnr, ATQ, ATS);

	if (ret == RCX_OK) {	//计算第七扇区密钥
		int i = 0;
		for (i = 0; i < 4; i++) {
			temp[i] = PICCsnr[3-i];
		};
		sectno = 7;
		memcpy(keya,temp,4);
		sprintf(temp,"%02X",sectno);
		memcpy(keya+4,temp,2);
		ret = CardMFCAuthKey(PICC_AUTHENT1A,PICCsnr,keya,(4*sectno+0));	//密钥认证
	}
	if (ret == RCX_OK) {
		blockno = sectno * 4 + 1;
		ret = CardMFCRead16Bytes(blockno,rdata);	//读取第七扇区第一块的内容，序数都从0起
		key_block = rdata[6]-'0';
		key_pos = rdata[7] - '0';
	}
	if (ret == RCX_OK) {		//计算第十五扇区密钥
		int i = 0;
		for (i = 0; i < 4; i++) {
			temp[i] = PICCsnr[3-i];
		};
		sectno = 15;
		memcpy(keya,temp,4);
		sprintf(temp,"%02X",sectno);
		memcpy(keya+4,temp,2);
		ret = CardMFCAuthKey(PICC_AUTHENT1A,PICCsnr,keya,(4*sectno+0));	//密钥认证
	}
	if (ret == RCX_OK) {
		blockno = sectno * 4 + 2;
		ret = CardMFCRead16Bytes(blockno,rdata);	//读取第十五扇区第二块的内容，序数都从0起
	}
	if (ret == RCX_OK) {		//读取主密钥
		memset(temp,0,sizeof(temp));
		memcpy(temp,rdata+14,2);
		sectno = strtoul(temp,NULL,16);
		memcpy(keya,rdata+8,6);
		ret = CardMFCAuthKey(PICC_AUTHENT1A,PICCsnr,keya,(4*sectno+0));	//密钥认证
	}
	if (ret == RCX_OK) {
		blockno = 4 * sectno + key_block;
		ret = CardMFCRead16Bytes(blockno,rdata);	//读取内容
		memcpy(main_key,rdata+key_pos,8);			//存放主密钥
	}
	if (ret == RCX_OK) {
		ret = eeprom_write(main_key, 8, EEPROM_OFFSET_MAIN_KEY);
		if (ret) {
			return -2;		//eeprom写入失败
		}
	}
	else {
		return -1;		//获取主密钥失败
	}
	return 0;
}
/***********************************************************************
		module		:	[M1卡读写]
		function		:	[启动M1卡]
  		return		:	[RCX_OK: 成功
  						其他: 失败]
		comment	:	[全局普通函数]
		machine		:	[EH-0818]
		language	:	[CHN]
 		keyword		:	[CPU_CARD]
		date			:	[11/08/01]
 		author		:	[chen-zhengkai]
************************************************************************/
int M1_start(unsigned char* PICCsnr, unsigned char* ATQ, unsigned char* ATS)
{
	int ret = RCX_OK;
	ret = CardTypeARequest(PICC_REQALL,ATQ); //有可能处于 Halt 状态
	if ( ret != RCX_OK) {
		ret = CardTypeARequest(PICC_REQALL,ATQ);//有可能处于active状态
	}
	if ( ret == RCX_OK ) {
		ret = CardTypeAAnticollLevel1(PICCsnr);	//执行防冲突级别1
	}
	if ( ret == RCX_OK ) {
		ret = CardTypeASelectLevel1(PICCsnr,ATS);	//选择激活卡片
	}
	return ret;
}

/***********************************************************************
		module		:	[M1卡读写]
		function		:	[考勤记录(M1卡，西科大)]
  		return		:	[0:读卡成功
						-1:读卡失败
						-2:eeprom读写失败]
		comment	:	[全局普通函数]
		machine		:	[EH-0818]
		language	:	[CHN]
 		keyword		:	[CPU_CARD]
		date			:	[11/07/28]
 		author		:	[chen-zhengkai]
************************************************************************/
#if 0
char workAttendance_xian()
{
	int	ret = RCX_OK;
	unsigned char 	ATQ[3] = {0};		//请求应答(2 bytes)
	unsigned char 	PICCsnr[5] = {0};	//物理卡号(4 bytes) 
	unsigned char	phyNo[9] = {0};	//物理卡号(8 bytes)		//add chen
	unsigned char 	ATS[2] = {0};		//选择码应答，对于mifare1:0x08(1 byte)
	unsigned char 	rdata[16] = {0};	//读取BUFFER
	unsigned char keya[6] = {0};		//keyA密钥
	unsigned char main_key[8] = {0};	//主密钥
	unsigned char num[20] = {0};	//显示学号
	unsigned char name[10] = {0};	//显示姓名
	int sectno = 0;				//扇区号
	int blockno = 0;			//块号
	char keya_0[6] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06};	//第0扇区的keya是固定的，123456
	USER_INFO	tempInfo;
	typ_TIME		ttime;	//时间结构
	typ_DATE	tdate;	//日期结构

	
	ret = M1_start(PICCsnr, ATQ, ATS);
	if (ret == RCX_OK) {
		if (eeprom_read(main_key, sizeof(main_key), EEPROM_OFFSET_MAIN_KEY)) {
			return -2;		//读取eeprom失败
		}
		CalKeyA(PICCsnr, main_key, keya);	//计算得到KEYA
		sectno = 0;
		ret = CardMFCAuthKey(PICC_AUTHENT1A, PICCsnr, keya_0, sectno*4 + 3);	//认证第0扇区
	}
	if (ret == RCX_OK) {
		//读取学号，第0扇区第1块和第2块前4字节是学号
		sectno = 0;
		blockno = sectno*4+1;
		ret = CardMFCRead16Bytes(blockno,rdata);
		memcpy(num, rdata, 16);
		blockno = sectno*4+1;
		ret = CardMFCRead16Bytes(blockno,rdata);
		memcpy(num+16, rdata, 4);
	}
	if (ret == RCX_OK) {
		sectno = 2;
		ret = CardMFCAuthKey(PICC_AUTHENT1A, PICCsnr, keya, sectno*4 + 3);	//认证第2扇区
		if (ret == RCX_OK) {
			//读取姓名，第2扇区第0块的前8字节是姓名
			blockno = sectno*4+0;
			ret = CardMFCRead16Bytes(blockno,rdata);
			memcpy(name, rdata, 8);
		}
	}
	//添加记录到数据库
	if (ret == RCX_OK) {
		dec2hex(PICCsnr, 4, phyNo);
		memcpy(tempInfo.phyNo, phyNo, 8);
		RTC_Get_Time(&ttime);		//获取现在时间
		RTC_Get_Date(&tdate);		//获取当前日期
		sprintf(tempInfo.time, "%04d%02d%02d%02d%02d%02d", tdate.year, tdate.month, tdate.day, ttime.hour, ttime.min, ttime.sec);
		ret = DB_add_record(ATTENDANCE_INDEX,  (void *)(&tempInfo));	//把记录添加到数据库中
		if ( !ret ) {
			return -1;		//记录添加失败
		}
	}
	else {
		return -1;
	}
	warning_beep();
	DispStr_CE(0, 6, (char*)name, DISP_CENTER|DISP_CLRSCR);
	DispStr_CE(0, 10, (char*)num, DISP_CENTER);
	return 0;
}
/***********************************************************************
		module		:	[M1卡读写（大连海事临时版）]
		function		:	[考勤记录]
  		return		:	[0:读卡成功
						-1:读卡失败
						-2:eeprom读写失败]
		comment	:	[全局普通函数]
		machine		:	[EH-0818]
		language	:	[CHN]
 		keyword		:	[CPU_CARD]
		date			:	[11/09/03]
 		author		:	[chen-zhengkai]
************************************************************************/
char workAttendanceTemp()
{
	int	ret = RCX_OK;
	unsigned char 	ATQ[3] = {0};		//请求应答(2 bytes)
	unsigned char 	PICCsnr[5] = {0};	//物理卡号(4 bytes) 
	unsigned char	phyNo[9] = {0};	//物理卡号(8 bytes)		//add chen
	unsigned char 	ATS[2] = {0};		//选择码应答，对于mifare1:0x08(1 byte)
	unsigned char 	rdata[16] = {0};	//读取BUFFER
	unsigned char keya[6] = {0};		//keyA密钥
	unsigned char main_key[8] = {0};	//主密钥
	unsigned char num[20] = {0};	//显示学号
	unsigned char name[10] = {0};	//显示姓名
	int sectno = 0;				//扇区号
	int blockno = 0;			//块号
	int idx = 0;
	char keya_0[6] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06};	//第0扇区的keya是固定的，123456
	USER_INFO	tempInfo;
	typ_TIME		ttime;	//时间结构
	typ_DATE	tdate;	//日期结构

	
	ret = M1_start(PICCsnr, ATQ, ATS);
//	if (ret == RCX_OK) {
//		if (eeprom_read(main_key, sizeof(main_key), EEPROM_OFFSET_MAIN_KEY)) {
//			return -2;		//读取eeprom失败
//		}
//		CalKeyA(PICCsnr, main_key, keya);	//计算得到KEYA
//		sectno = 0;
//		ret = CardMFCAuthKey(PICC_AUTHENT1A, PICCsnr, keya_0, sectno*4 + 3);	//认证第0扇区
//	}
//	if (ret == RCX_OK) {
//		//读取学号，第0扇区第1块和第2块前4字节是学号
//		sectno = 0;
//		blockno = sectno*4+1;
//		ret = CardMFCRead16Bytes(blockno,rdata);
//		memcpy(num, rdata, 16);
//		blockno = sectno*4+1;
//		ret = CardMFCRead16Bytes(blockno,rdata);
//		memcpy(num+16, rdata, 4);
//	}
//	if (ret == RCX_OK) {
//		sectno = 2;
//		ret = CardMFCAuthKey(PICC_AUTHENT1A, PICCsnr, keya, sectno*4 + 3);	//认证第2扇区
//		if (ret == RCX_OK) {
//			//读取姓名，第2扇区第0块的前8字节是姓名
//			blockno = sectno*4+0;
//			ret = CardMFCRead16Bytes(blockno,rdata);
//			memcpy(name, rdata, 8);
//		}
//	}
	//添加记录到数据库
	if (ret == RCX_OK) {
		dec2hex(PICCsnr, 4, phyNo);
		memcpy(tempInfo.phyNo, phyNo, 8);
		RTC_Get_Time(&ttime);		//获取现在时间
		RTC_Get_Date(&tdate);		//获取当前日期
		sprintf(tempInfo.time, "%04d%02d%02d%02d%02d%02d", tdate.year, tdate.month, tdate.day, ttime.hour, ttime.min, ttime.sec);
		ret = DB_add_record(ATTENDANCE_INDEX,  (void *)(&tempInfo));	//把记录添加到数据库中
		if ( !ret ) {
			return -1;		//记录添加失败
		}
	}
	else {
		return -1;
	}
	warning_beep();
//	DispStr_CE(0, 6, (char*)name, DISP_CENTER|DISP_CLRSCR);
//	DispStr_CE(0, 10, (char*)num, DISP_CENTER);
	DispStr_CE(0, 6, "打卡成功", DISP_CENTER|DISP_CLRSCR);
	DispStr_CE(0, 10, "已签到", DISP_CENTER);
	return 0;
}
#endif
/***********************************************************************
		module		:	[M1卡读写]
		function		:	[身份识别]
  		return		:	[0:读卡成功
						-1:读卡失败
						-2:eeprom读写失败]
		comment	:	[全局普通函数]
		machine		:	[EH-0818]
		language	:	[CHN]
 		keyword		:	[CPU_CARD]
		date			:	[11/07/28]
 		author		:	[chen-zhengkai]
************************************************************************/
char discernID()
{
	int	ret = RCX_OK;
	unsigned char 	ATQ[3] = {0};		//请求应答(2 bytes)
	unsigned char 	PICCsnr[5] = {0};	//物理卡号(4 bytes) 
	unsigned char 	ATS[2] = {0};		//选择码应答，对于mifare1:0x08(1 byte)
	unsigned char 	rdata[16] = {0};	//读取BUFFER
	unsigned char keya[6] = {0};		//keyA密钥
	unsigned char main_key[8] = {0};	//主密钥
	unsigned char num[20] = {0};	//显示学号
	unsigned char name[10] = {0};	//显示姓名
	int sectno = 0;				//扇区号
	int blockno = 0;			//块号
	char keya_0[6] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06};		//第0扇区的keya是固定的，123456

	ret = M1_start(PICCsnr, ATQ, ATS);
	if (ret == RCX_OK) {
		if (eeprom_read(main_key, sizeof(main_key), EEPROM_OFFSET_MAIN_KEY)) {
			return -2;		//读取eeprom失败
		}
		CalKeyA(PICCsnr, main_key, keya);	//计算得到KEYA
		sectno = 0;
		ret = CardMFCAuthKey(PICC_AUTHENT1A, PICCsnr, keya_0, sectno*4 + 3);	//认证第0扇区
	}
	if (ret == RCX_OK) {
		//读取学号，第0扇区第1块和第2块前4字节是学号
		sectno = 0;
		blockno = sectno*4+1;
		ret = CardMFCRead16Bytes(blockno,rdata);
		memcpy(num, rdata, 16);
		blockno = sectno*4+1;
		ret = CardMFCRead16Bytes(blockno,rdata);
		memcpy(num+16, rdata, 4);
	}
	if (ret == RCX_OK) {
		sectno = 2;
		ret = CardMFCAuthKey(PICC_AUTHENT1A, PICCsnr, keya, sectno*4 + 3);	//认证第2扇区
		if (ret == RCX_OK) {
			//读取姓名，第2扇区第0块的前8字节是姓名
			blockno = sectno*4+0;
			ret = CardMFCRead16Bytes(blockno,rdata);
			memcpy(name, rdata, 8);
		}
	}
	if (ret != RCX_OK) {
		return -1;
	}
	warning_beep();
	DispStr_CE(0, 6, (char*)name, DISP_CENTER|DISP_CLRSCR);
	DispStr_CE(0, 10, (char*)num, DISP_CENTER);
	return 0;
}

/***********************************************************************
		module		:	[M1卡读写]
		function		:	[考勤记录(M1卡，大连海事)]
  		return		:	[0:读卡成功
						-1:读卡失败
						-2:eeprom读写失败]
		comment	:	[全局普通函数]
		machine		:	[EH-0818]
		language	:	[CHN]
 		keyword		:	[CPU_CARD]
		date			:	[11/09/05]
 		author		:	[chen-zhengkai]
************************************************************************/
#if 0
char workAttendance_Dalian()
{
	int	ret = RCX_OK;
	unsigned char 	ATQ[3] = {0};		//请求应答(2 bytes)
	unsigned char 	PICCsnr[5] = {0};	//物理卡号(4 bytes) 
	unsigned char	phyNo[9] = {0};	//物理卡号(8 bytes)		//add chen
	unsigned char 	ATS[2] = {0};		//选择码应答，对于mifare1:0x08(1 byte)
	unsigned char 	rdata[16] = {0};	//读取BUFFER
	unsigned char keya[6] = {0};		//keyA密钥
	//unsigned char keyA[8] = {0};	//主密钥
	unsigned char num[20] = {0};	//显示学号
	unsigned char name[10] = {0};	//显示姓名
	int sectno = 0;				//扇区号
	int blockno = 0;			//块号
	char keya_0[6] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06};	//第0扇区的keya是固定的，123456
	USER_INFO	tempInfo;
	typ_TIME		ttime;	//时间结构
	typ_DATE	tdate;	//日期结构

	
	ret = M1_start(PICCsnr, ATQ, ATS);
	if (ret == RCX_OK) {
		if ( calkeyAfromPSAM(keya, PICCsnr) ) {	//计算得到KEYA
			return -1;		//获取keya失败
		}
		//CalKeyA(PICCsnr, main_key, keya);	//计算得到KEYA
		sectno = 0;
		ret = CardMFCAuthKey(PICC_AUTHENT1A, PICCsnr, keya_0, sectno*4 + 3);	//认证第0扇区
	}
	if (ret == RCX_OK) {
		//读取学号，第0扇区第1块和第2块前4字节是学号
		sectno = 0;
		blockno = sectno*4+1;
		ret = CardMFCRead16Bytes(blockno,rdata);
		memcpy(num, rdata, 16);
		blockno = sectno*4+1;
		ret = CardMFCRead16Bytes(blockno,rdata);
		memcpy(num+16, rdata, 4);
	}
	if (ret == RCX_OK) {
		sectno = 2;
		ret = CardMFCAuthKey(PICC_AUTHENT1A, PICCsnr, keya, sectno*4 + 3);	//认证第2扇区
		if (ret == RCX_OK) {
			//读取姓名，第2扇区第0块的前8字节是姓名
			blockno = sectno*4+0;
			ret = CardMFCRead16Bytes(blockno,rdata);
			memcpy(name, rdata, 8);
		}
	}
	//添加记录到数据库
	if (ret == RCX_OK) {
		dec2hex(PICCsnr, 4, phyNo);
		memcpy(tempInfo.phyNo, phyNo, 8);
		RTC_Get_Time(&ttime);		//获取现在时间
		RTC_Get_Date(&tdate);		//获取当前日期
		sprintf(tempInfo.time, "%04d%02d%02d%02d%02d%02d", tdate.year, tdate.month, tdate.day, ttime.hour, ttime.min, ttime.sec);
		ret = DB_add_record(ATTENDANCE_INDEX,  (void *)(&tempInfo));	//把记录添加到数据库中
		if ( !ret ) {
			return -1;		//记录添加失败
		}
	}
	else {
		return -1;
	}
	warning_beep();
	DispStr_CE(0, 6, (char*)name, DISP_CENTER|DISP_CLRSCR);
	DispStr_CE(0, 8, (char*)num, DISP_CENTER);
	return 0;
}
#endif
/***********************************************************************
		module		:	[M1卡读写]
		function		:	[读取PSAM卡，计算KEY_A(M1卡，大连海事)]
  		return		:	[0：获取成功
						其他：获取失败]
		comment	:	[全局普通函数]
		machine		:	[EH-0818]
		language	:	[CHN]
 		keyword		:	[CPU_CARD]
		date			:	[11/09/05]
 		author		:	[chen-zhengkai]
************************************************************************/
int calkeyAfromPSAM(char* keya, const char* phyNo)
{
	unsigned char szCmd[256] = {0};	//发送的命令
	unsigned char uRev[256] = {0};	//接受的数据
	short revLen = 0;		//接受长度
	short sendLen = 0;	//发送长度
	unsigned char sPlain[8];	//变异物理卡号
	int tempLen = 0;
	//char adfName[50] = {0};	//目录缓存
	char atr[200] = {0};
	int atrLen = 0;
	int ret = 0;
	unsigned short SW = 0;
	const unsigned char statickey[17]="3230303530313331";	//"20050131"
	char debugTemp[30] = {0};
	int i = 0;
//	static unsigned char prePhyNo[4] = {0};
//	static unsigned char preCipherData[16] = {0};
	unsigned char cipherData[17] = {0};
	unsigned int startpos = 0;
	
//	if(memcmp(prePhyNo, phyNo,4) == 0)
//	{
//		memcpy(cipherData,preCipherData,8);
//		return 0;
//	}
	//计算变异物理卡号
	for(i = 0; i < 4; i++) {
		sPlain[i] = phyNo[i];
		sPlain[i+4] = ~phyNo[i];
	}
	
	ICC_interface_power(ICC_POWER_ON);
	ret = ICC_select_sock(ICC_SOCK_AUX1);
	if (ret) {
		debugFun("找不到卡槽");
		return -1;
	}
	//卡片上电
	ret = ICC_cpucard_ATR(atr, &atrLen, ICC_CLOCK_4M, ICC_VOLTAGE_3, 0x11, ICC_CPUC_ATR_FLAG_LONGATR);
	if (ret) {
		debugFun("卡片上电失败");
		return -1;
	}
	
	//选择目录
	//strcpy(adfName, "D1560001018000000000000100000000");
	//sprintf(szCmd,"00A40400%02X%s",strlen(adfName)/2,adfName);
	//hex2dec(adfName, strlen(adfName), (unsigned char*)szCmd, &tempLen);
	if ((ICC_cpucard_get_param())->isT1) {
		debugFun("卡片是t1协议");
		return -2;
	}
	else {
		//选择目录
		hex2dec("DF04", 4, szCmd, &tempLen);
		ret = ICC_T0_TPDU(0 , 0x00 ,0xA4, 0x00, 0x00 , 2,  szCmd, &SW);
		if (ret) {
			debugFun("选择命令发送失败");
			return -1;
		}
		if ( !(SW == 0x9000 || (SW >> 8) == 0x61) ) {	//执行不成功
			debugFun("选择目录出错");
			return -1;
		}
		//分散密钥
		//sprintf(szCmd,"801A270208%s",statickey);
		hex2dec(statickey, 16, szCmd, &tempLen);
		ret = ICC_T0_TPDU(0 , 0x80 ,0x1A, 0x27, 0x02 , 0x08,  szCmd, &SW);
		if (ret) {
			debugFun("分散命令发送失败");
			return -1;
		}
		if ( !(SW == 0x9000 || (SW >> 8) == 0x61) ) {	//执行不成功
			debugFun("分散密钥出错");
//			sprintf(debugTemp, "%d %d", SW>>8,  SW&0xff);
//			debugFun(debugTemp);
			return -1;
		}
		//加密数据
		memset(szCmd,0,sizeof(szCmd));
		//dec2hex(sPlain, 8, szCmd);
		strncpy(szCmd, sPlain, 8);
		ret = ICC_T0_TPDU(0 , 0x80 ,0xFA, 0x00, 0x00 , 0x08,  szCmd, &SW);
		if (ret) {
			debugFun("计算命令发送失败");
			return -1;
		}
		if ( !(SW == 0x9000 || (SW >> 8) == 0x61) ) {	//执行不成功
			debugFun("计算密钥出错");
			return -1;
		}
		else {
			revLen = 0x0000;
			revLen = SW&0x00ff;
		}
		//获取数据
		//Sys_Delay_MS(20);
		 ret = ICC_T0_TPDU(1,0x00,0xC0,0x00,0x00, revLen ,uRev, &SW);
		 if (ret) {
			debugFun("获取数据失败");
			return -1;
		}
		if ( !(SW == 0x9000 || (SW >> 8) == 0x61) ) {	//执行不成功
			debugFun("获取密钥失败");
			return -1;
		}
//		memcpy(prePhyNo,phyNo,4);
		memcpy(cipherData, uRev, 8);
//		memcpy(preCipherData,cipherData,8);
		
		memcpy(cipherData + 8, cipherData, 8);
		startpos=(cipherData[0] + cipherData[1] + cipherData[2] + cipherData[3] + cipherData[4] + cipherData[5] + cipherData[6] + cipherData[7]) % 7;      // sCipher[17]6079813C4F1A2F92, startpos = 4
		memcpy(keya, cipherData + startpos, 6);
//		sprintf(debugTemp, "%d %d, %d,%d,%d,%d,%d,%d,%d,%d", startpos, revLen, uRev[0] , uRev[1] , uRev[2] , uRev[3] , uRev[4] , uRev[5] , uRev[6], uRev[7]);
//		debugFun(debugTemp);
	}
	ICC_interface_power(ICC_POWER_OFF);
	return 0;
}
/***********************************************************************
		module		:	[M1卡读写]
		function		:	[蜂鸣器]
  		return		:	[无]
		comment	:	[全局普通函数]
		machine		:	[EH-0818]
		language	:	[CHN]
 		keyword		:	[CPU_CARD]
		date			:	[11/08/02]
 		author		:	[chen-zhengkai]
************************************************************************/
void	warning_beep()
{
	int	j;
	for ( j=0; j<1000; j++ ) {
		Beep_Sound(BEEP_ON,6,50);
	}
	Sys_Delay_MS(200);		
	Beep_Sound(BEEP_OFF,6,50);
}





