/****************************************************************************
*
*文件(File):         WiFi_Demo.c
*
*修改(Modify):       2011-03-24 14:18:45
*
*作者(Author):       forsunzheng
*
*编绎(Compile):      智能平台(Smart Platform)
*
*描述(Description):
*1..ARM 项目文件(ARM Project):WiFi_Demo.dsp 
*2..项目二进制输出文件(project binary output  file):WiFi_Demo.bin
*
----------------------------------------------------------------------------
|
| Version | Datetime             |   Author    | Description
| --------+----------------------+-------------+----------------------------
|
| V1.00  2011-03-24 14:18:displayPosition5           forsunzheng 
----------------------------------------------------------------------------
****************************************************************************/

/*在此增加代码(TODO: add  code here)*/

#include "in_call.h"
#include "WiFi/WiFi.h"
#include "WiFi/NaNoWiFiConst.h"
#include "WiFi/WiFiPubFuncs.h"
#include <unistd.h>
//#include "usb.h"
//#include "updown.h"

int main(void)
{
	Disp_Init(DISP_INIT_ON);		//初始化 LCD
	Disp_Clear();				
	
	KEY_Init(KEY_BEEP_KEY|KEY_AUTO_EL_ON);	//初始化 Keyborad
	KEY_Beep_Mask_Set(0xffffffff);			
	KEY_EL_Mask_Set(0xffffffff);
	EL_Set_Timeout(20);			//定时关闭背光灯
	Sys_Auto_Poweroff_Set(60*2);		//定时待机
	
	//Meanless for 0218/0318/0518
	Disp_Icon_Battery_Time_Set(1,ICON_AT_TAIL);
	Disp_Icon_Battery_Time_Refresh();
	Disp_Set_Color(SET_FONT_COLOR, 0x0000);		//黑
	Disp_Set_Color(SET_BACK_COLOR, 0xFFFF);		//白
	Disp_Set_Color(SET_SELECT_COLOR, 0x07E0);	//绿
	Disp_Set_Color(SET_CLEAR_COLOR, 0xFFFF);	//白

	adminPsd_init();	//一次性初始化，数据初置
	db_check();	//数据库检查
	//wifiInit_open();	//wifi初始化
	main_task();
	return 0;
}
/*************************************/
void debugFun(char* debugStr)	//debug函数
{
	DispStr_CE(0, 22, "MESSAGE", DISP_CENTER|DISP_CLRSCR);
	DispStr_CE(0, 24, debugStr, DISP_CENTER);
	DispStr_CE(0, 26, "按任意键返回", DISP_CENTER);
	delay_and_wait_key( 0, EXIT_KEY_ALL, 0 );
}
