/*
*/
#include "hundure/rac2000devnode.h"
#include "hundure/hundure_def.h"
#include "xutils/xstring.h"
#include "ksgateway.h"

#if defined(HAS_RAC2000G_SUPPORT) || defined(HAS_RAC2000P_SUPPORT)
#ifdef WIN32
#ifdef _DEBUG
#pragma message("auto like rac2000 library")
#pragma comment(lib,"rac2000_d.lib")
#else
#pragma message("auto like rac2000 library release")
#pragma comment(lib,"rac2000.lib")
#endif
#endif
#endif

#define RAC_DOOR1_TERMID 1
#define RAC_DOOR2_TERMID 2

#define RAC_DOOR1_TIME_SECT_BEGIN 0x0800
#define RAC_DOOR2_TIME_SECT_BEGIN 0x0A00
#define RAC_DOOR1_WEEK_BEGIN 0x0100
#define RAC_DOOR2_WEEK_BEGIN 0x0480
#define RAC_DOOR1_HOLIDAY_BEGIN 0x0C00
#define RAC_DOOR2_HOLIDAY_BEGIN 0x0E58
#define RAC_HOLIDAY_DATE_MAX 100

namespace HUNDURE
{
	static const int g_rac_default_timeout = 1000;
	static const HNDR_Event_Code_Def_t g_rac_event_defs[]={
		{0,1},
		{1,2},
		{2,3},
		{3,4},
		{4,5},
		{5,6},
		{6,7},
		{10,8},
		{11,9},
		{20,10},
		{61,11},
		{62,12},
		{63,13},
		{64,14},
		{HNDR_EVENT_CODE_END,HNDR_EVENT_CODE_END},
	};
	int HNDR_RAC2000_Base::make_handler(KSGDeviceNode* node,ACE_HANDLE* handler)
	{
		KSGDeviceURL url = node->GetDevAddr();
		int ret;
		HNDR_HANDLE hd;
		if(url.GetConnType() == KSGDeviceURL::DevConnType::dctCOM)
		{
			// com
			char com[5] = "";
			sprintf(com,"COM%d",url.GetPort());
			int rate = HUNDURE_RAC_BAND_RATE;
			ret = hacOpenChannel(com,rate,&hd);
		}
		else
		{
			/*
			std::string ip = node->GetDevAddr().GetConnect();
			int port = node->GetDevAddr().GetPort();
			ret = hacOpenChannel(ip.c_str(),port,&hd);
			*/
			return 1;
		}
		if(ret == E_HNDR_PARAM_ERR)
		{
			ACE_DEBUG((LM_ERROR,"设备参数不正确,返回码[%d]",ret));
			return -1;
		}
		else if(ret == E_HNDR_FAILED)
		{
			ACE_DEBUG((LM_ERROR,"连接设备失败,dev[%d]",node->GetDevId()));
			node->SetState(KSGDeviceNode::dsOffline);
			return -1;
		}
		else if(ret == E_HNDR_SUCCESS)
		{
			*handler = (ACE_HANDLE)hd;
			return 0;
		}
		else
		{
			ACE_DEBUG((LM_ERROR,"连接设备失败,dev[%d],未知错误",node->GetDevId()));
			node->SetState(KSGDeviceNode::dsOffline);
			return -1;
		}
	}
	int HNDR_RAC2000_Base::close_handler(KSGDeviceNode* node,ACE_HANDLE handler)
	{
		KSGDeviceURL url = node->GetDevAddr();
		if(url.GetConnType() != KSGDeviceURL::DevConnType::dctCOM)
			return 1;
		HNDR_HANDLE hd = (HNDR_HANDLE)handler;
		int ret;
		ret = hacCloseChannel(hd);
		if(ret)
		{
			ACE_DEBUG((LM_ERROR,"关闭设备连接错误,dev[%d]ret[%d]"
				,node->GetDevId(),ret));
			return -1;
		}
		return 0;
	}

	//////////////////////////////////////////////////////////////////
	int ID_HNDR_RACP_DLUL_Card::ExecuteTask(KSGDeviceNode* node,Task* task)
	{
		HNDR_HANDLE hd = (HNDR_HANDLE)task->_handle;
		int weekno,holiday,flag,ret;
		std::string phyno = task->GetParams().GetParam(XML_KEY_CARDPHY);
		try
		{
			weekno = task->GetParams().GetParamIntVal(XML_KEY_WEEKNO);
			flag = task->GetParams().GetParamIntVal(XML_KEY_FTFLAG);
			holiday = task->GetParams().GetParamIntVal(XML_KEY_HOLIDAY);
		}
		catch (...)
		{
			return TASK_ERR_PARAM;
		}
		
		if(weekno < 0 || phyno.length() != 8 || flag < 0 || flag > 1)
		{
			return TASK_ERR_PARAM;
		}
		KSGDeviceNode *task_node = task->GetDeviceNode();
		ACE_ASSERT(task_node != NULL);
		// 机号
		int nodeid = node->GetTermId();
		std::string phyno_dec;
		if(HNDR_convert_cardphy_hex2dec(phyno,phyno_dec))
			return TASK_ERR_PARAM;
		if(flag == 0)
		{
			if(node->GetDeviceType() == HUNDURE_RAC2000P)
				ret = hacDelCard(nodeid,phyno_dec.c_str(),phyno_dec.length()
				,hd,g_rac_default_timeout);
			else
				ret = hacDelZCard(nodeid,phyno_dec.c_str(),phyno_dec.length()
				,hd,g_rac_default_timeout);
		}
		else
		{
			char status = RAC_RIGHT_CHECK_WEEK;
			if(holiday != -1)
				status |= RAC_RIGHT_CHECK_HOLIDAY;
			if(task_node->GetTermId() == 1)
			{
				status |= RAC_RIGHT_DOOR1;
			}
			else if(task_node->GetTermId() == 2)
			{
				status |= RAC_RIGHT_DOOR2;
			}
			if(node->GetDeviceType() == HUNDURE_RAC2000P)
				ret = hacAddCard(nodeid,phyno_dec.c_str(),phyno_dec.length()
				,NULL,0,weekno,status,hd,g_rac_default_timeout);
			else
				ret = hacAddZCard(nodeid,phyno_dec.c_str(),phyno_dec.length()
				,NULL,0,status,hd,g_rac_default_timeout);
		}
		if(ret == E_HNDR_TIMEOUT)
			return TASK_ERR_TIMEOUT;
		else if(ret != E_HNDR_SUCCESS)
			return TASK_ERR_EXECUTE;
		return TASK_SUCCESS;
	}
	/*
	int ID_HNDR_RACG_DLUL_Card::ExecuteTask(KSGDeviceNode* node,Task* task)
	{
		HNDR_HANDLE hd = (HNDR_HANDLE)task->_handle;
		int weekno,flag,ret;
		std::string phyno = task->GetParams().GetParam(XML_KEY_CARDPHY);
		try
		{
			weekno = task->GetParams().GetParamIntVal(XML_KEY_WEEKNO);
			flag = task->GetParams().GetParamIntVal(XML_KEY_FTFLAG);
		}
		catch (...)
		{
			return TASK_ERR_PARAM;
		}

		if(weekno < 0 || phyno.length() != 8 || flag < 0 || flag > 1)
		{
			return TASK_ERR_PARAM;
		}
		KSGDeviceNode *task_node = task->GetDeviceNode();
		ACE_ASSERT(task_node != NULL);
		// 机号
		int nodeid = node->GetTermId();
		char zip_card[5] = "";
		if(HNDR_convert_cardphy_hex2zip(phyno,zip_card))
			return TASK_ERR_PARAM;
		
		if(flag == 0)
			ret = hacDelZCard(nodeid,zip_card,5
			,hd,g_rac_default_timeout);
		else
		{
			char status = RAC_RIGHT_CHECK_WEEK;
			if(task_node->GetTermId() == RAC_DOOR1_TERMID)
			{
				status |= RAC_RIGHT_DOOR1;
			}
			else if(task_node->GetTermId() == RAC_DOOR2_TERMID)
			{
				status |= RAC_RIGHT_DOOR2;
			}
			else
				return TASK_ERR_PARAM;
			ret = hacAddCard(nodeid,zip_card,5
				,NULL,0,weekno,status,hd,g_rac_default_timeout);
		}
		if(ret == E_HNDR_TIMEOUT)
			return TASK_ERR_TIMEOUT;
		else if(ret != E_HNDR_SUCCESS)
			return TASK_ERR_EXECUTE;
		return TASK_SUCCESS;
	}
	*/
	int ID_HNDR_RAC_DL_Timesect::ExecuteTask(KSGDeviceNode* node,Task* task)
	{
		HNDR_HANDLE hd = (HNDR_HANDLE)task->_handle;
		int seqno;
		std::string time_sect;
		try
		{
			seqno = task->GetParams().GetParamIntVal(XML_KEY_SEQNO);
			time_sect = task->GetParams().GetParam(XML_KEY_DOORTIME1);
		}
		catch (...)
		{
			return TASK_ERR_PARAM;
		}
		if(seqno < 0 || seqno > 127 || time_sect.length() != 8)
			return TASK_ERR_PARAM;
		unsigned int start_addr;
		KSGDeviceNode *task_node = task->GetDeviceNode();
		KSGDeviceNode *task_parent = task_node->GetParent();
		ACE_ASSERT(task_parent != NULL);
		if(task_node->GetTermId() == RAC_DOOR1_TERMID)
		{
			start_addr = RAC_DOOR1_TIME_SECT_BEGIN + 4 * seqno;
		}
		else if(task_node->GetTermId() == RAC_DOOR2_TERMID)
		{
			start_addr = RAC_DOOR2_TIME_SECT_BEGIN + 4 * seqno;
		}
		else
			return TASK_ERR_PARAM;
		
		unsigned char buf[4];
		xutil::StringUtil::Str2BCD(time_sect.c_str(),8,buf);
		int ret = hacSetEEData(task_parent->GetTermId(),buf,start_addr,sizeof buf
			,hd,g_rac_default_timeout);
		if(ret == E_HNDR_TIMEOUT)
			return TASK_ERR_TIMEOUT;
		else if(ret != E_HNDR_SUCCESS)
			return TASK_ERR_EXECUTE;
		KSGTaskResponse &resp = task->GetResponse();
		resp.AddField(XML_KEY_MAJOR_DEV,task_node->GetParent()->GetDevId());
		resp.AddField(XML_KEY_MINOR_DEV,task_node->GetDevId());
		resp.AddField(XML_KEY_SEQNO,seqno);
		// 表示设置的是时间段
		resp.AddField(XML_KEY_FTFLAG,2);
		return TASK_SUCCESS;
	}

	int ID_HNDR_RAC_DL_Week::ExecuteTask(KSGDeviceNode* node,Task* task)
	{
		HNDR_HANDLE hd = (HNDR_HANDLE)task->_handle;
		int seqno,day1,day2,day3,day4,day5,day6,day7;
		try
		{
			seqno = task->GetParams().GetParamIntVal(XML_KEY_SEQNO);
			day1 = task->GetParams().GetParamIntVal(XML_KEY_WEEK_DAY1);
			day2 = task->GetParams().GetParamIntVal(XML_KEY_WEEK_DAY2);
			day3 = task->GetParams().GetParamIntVal(XML_KEY_WEEK_DAY3);
			day4 = task->GetParams().GetParamIntVal(XML_KEY_WEEK_DAY4);
			day5 = task->GetParams().GetParamIntVal(XML_KEY_WEEK_DAY5);
			day6 = task->GetParams().GetParamIntVal(XML_KEY_WEEK_DAY6);
			day7 = task->GetParams().GetParamIntVal(XML_KEY_WEEK_DAY7);
		}
		catch (...)
		{
			return TASK_ERR_PARAM;
		}
		unsigned char buf[7];
		buf[0] = day1;
		buf[1] = day2;
		buf[2] = day3;
		buf[3] = day4;
		buf[4] = day5;
		buf[5] = day6;
		buf[6] = day7;
		if(seqno < 0 || seqno > 127)
			return TASK_ERR_PARAM;
		KSGDeviceNode *task_node = task->GetDeviceNode();
		ACE_ASSERT(task_node != NULL);
		KSGDeviceNode *task_parent = task_node->GetParent();
		ACE_ASSERT(task_parent != NULL);
		
		unsigned int start_addr;
		if(task_node->GetTermId() == RAC_DOOR1_TERMID)
		{
			start_addr = RAC_DOOR1_WEEK_BEGIN + 7 * seqno;
		}
		else if(task_node->GetTermId() == RAC_DOOR2_TERMID)
		{
			start_addr = RAC_DOOR2_WEEK_BEGIN + 7 * seqno;
		}
		else
			return TASK_ERR_PARAM;
		
		int ret = hacSetEEData(task_parent->GetTermId(),buf,start_addr,sizeof buf
			,hd,g_rac_default_timeout);
		if(ret == E_HNDR_TIMEOUT)
			return TASK_ERR_TIMEOUT;
		else if(ret != E_HNDR_SUCCESS)
			return TASK_ERR_EXECUTE;
		KSGTaskResponse &resp = task->GetResponse();
		resp.AddField(XML_KEY_MAJOR_DEV,task_node->GetParent()->GetDevId());
		resp.AddField(XML_KEY_MINOR_DEV,task_node->GetDevId());
		resp.AddField(XML_KEY_SEQNO,seqno);
		return TASK_SUCCESS;
	}
	int ID_HNDR_RAC_DL_Holiday::ExecuteTask(KSGDeviceNode* node,Task* task)
	{
		HNDR_HANDLE hd = static_cast<HNDR_HANDLE>(task->_handle);
		int seqno,holiday_id,ret;
		try
		{
			seqno = task->GetParams().GetParamIntVal(XML_KEY_SEQNO);
			holiday_id = task->GetParams().GetParamIntVal(XML_KEY_HOLIDAY);
		}
		catch (...)
		{
			return TASK_ERR_PARAM;
		}
		KSGDeviceNode *task_node = task->GetDeviceNode();
		ACE_ASSERT(task_node != NULL);
		KSGDeviceNode *task_parent = task_node->GetParent();
		ACE_ASSERT(task_parent != NULL);
		DRTPPoolType::SmartObject drtp = KsgGetDrtpPool()->Alloc();
		if(!drtp)
			return TASK_ERR_EXECUTE;
		drtp->SetRequestHeader(HUNDURE_HOLIDAY_FUNC_NO);
		drtp->AddField(F_LVOL2,holiday_id);
		drtp->AddField(F_LVOL0,task_parent->GetDevId());
		drtp->AddField(F_LVOL1,task_node->GetDevId());
		if(drtp->SendRequest(1000) || drtp->GetReturnCode())
		{
			ACE_DEBUG((LM_DEBUG,"读取节假日信息失败,ret[%d][%s]"
				,drtp->GetReturnCode(),drtp->GetReturnMsg().c_str()));
			return TASK_ERR_EXECUTE;
		}
		unsigned char data_buf[3*RAC_HOLIDAY_DATE_MAX];
		memset(data_buf,0xFF,sizeof data_buf);
		int i = 0;
		while(drtp->HasMoreRecord() && i < RAC_HOLIDAY_DATE_MAX)
		{
			ST_PACK *data = drtp->GetNextRecord();
			xutil::StringUtil::Str2BCD(data->sdate0+4,4,&data_buf[i*3]);
			data_buf[i*3+2] = static_cast<unsigned char>(data->lvol0);
			i++;
		}
		int data_len = i*3;
		// 没有数据,返回成功
		if(data_len == 0)
			goto L_END;
		KSGTaskResponse &resp = task->GetResponse();
		unsigned int start_addr;
		if(task_node->GetTermId() == RAC_DOOR1_TERMID)
		{
			start_addr = RAC_DOOR1_HOLIDAY_BEGIN;
		}
		else if(task_node->GetTermId() == RAC_DOOR2_TERMID)
		{
			start_addr = RAC_DOOR2_HOLIDAY_BEGIN;
		}
		else
		{
			resp.AddField(KEY_TASK_ERR_MSG,"设备机号错误");
			return TASK_ERR_EXECUTE;
		}
		int send_len = 3 * 50;
		for(int i = 0;i < sizeof data_buf;i+=send_len)
		{
			ret = hacSetEEData(task_parent->GetTermId(),data_buf+i,start_addr+i
				,send_len,hd,g_rac_default_timeout);
			if(ret)
				break;
		}
		
		if(ret == E_HNDR_TIMEOUT)
			return TASK_ERR_TIMEOUT;
		else if(ret != E_HNDR_SUCCESS)
			return TASK_ERR_EXECUTE;
L_END:
		resp.AddField(XML_KEY_MAJOR_DEV,task_node->GetParent()->GetDevId());
		resp.AddField(XML_KEY_MINOR_DEV,task_node->GetDevId());
		resp.AddField(XML_KEY_SEQNO,seqno);
		return TASK_SUCCESS;
	}

	int ID_HNDR_RAC2000_UL_Event::ExecuteTask(KSGDeviceNode* node,Task* task)
	{
		HNDR_HANDLE hd = (HNDR_HANDLE)task->_handle;
		HNDR_Device_Base *rac_base;
		stPollList poll_list[20];
		ACE_OS::memset(poll_list,0,sizeof poll_list);
		int ret;
		KSGDeviceNode *task_node = task->GetDeviceNode();
		rac_base = dynamic_cast<HNDR_Device_Base*>(task_node->GetDevice());
		if(!rac_base)
			return TASK_ERR_PARAM;
		int last_record = rac_base->get_last_poll_record(task_node);
		int recv_record = 0;
		int success = 0;
		if(task_node->GetDeviceType() == HUNDURE_RAC2000P)
		{
			// 不压缩卡号
			ret = hacPolling(task_node->GetTermId(),last_record,poll_list,&recv_record
				,hd,300,0);
			if(!ret)
			{
				success = upload_event_to_server(task_node,poll_list,recv_record,0);
			}
		}
		else
		{
			// 压缩卡号
			ret = hacPolling(task_node->GetTermId(),last_record,poll_list,&recv_record
				,hd,300,1);
			if(!ret)
			{
				success = upload_event_to_server(task_node,poll_list,recv_record,1);
			}
		}
		if(ret || success == 0)
			rac_base->update_poll_status(task_node,HNDR_RAC2000_Base::psFailed,0);
		else
			rac_base->update_poll_status(task_node,HNDR_RAC2000_Base::psSuccess,success);
		
		task->SetNeedResponse(false);
		if(ret == E_HNDR_TIMEOUT)
			return TASK_ERR_TIMEOUT;
		else if(ret != E_HNDR_SUCCESS)
			return TASK_ERR_EXECUTE;
		
		return TASK_SUCCESS;
	}

	int ID_HNDR_RAC2000_UL_Event::upload_event_to_server(KSGDeviceNode *node,
		stPollList *poll_list,int record,int zipped)
	{
		int success,retries;
		DRTPPoolType::SmartObject drtp = KsgGetDrtpPool()->Alloc();
		if(!drtp)
			return 0;
		for(success = 0; success < record;++success)
		{
			char phy_no[9] = "";
			std::string hex_str;
			if(ACE_OS::strlen(poll_list[success].cCard) > 0)
			{
				if(HNDR_convert_cardphy_dec2hex(poll_list[success].cCard,hex_str))
				{
					ACE_DEBUG((LM_ERROR,"收到的卡号错误"));
					continue;
				}
				//xutil::StringUtil::revert_str(hex_str.c_str(),8,phy_no);
				ACE_OS::strncpy(phy_no,hex_str.c_str(),8);
			}
			drtp->SetRequestHeader(HUNDURE_EVENT_FUNC_NO);
			drtp->AddField(F_LCERT_CODE,KsgGetGateway()->GetConfig()->_gwId);
			int event_code = ACE_OS::strtoul(poll_list[success].cEventCode,NULL,16);
			event_code = HNDR_event_code_2_ks_event(g_rac_event_defs,event_code);
			drtp->AddField(F_SEMP_NO,event_code);
			drtp->AddField(F_SDATE1,phy_no);
			char date_str[15] = "";
			char time_str[7] = "";
			HNDR_convert_event_datetime(poll_list[success].cDateTime,date_str);
			int reader_id = ACE_OS::atoi(poll_list[success].cReaderID);
			int device_id = ACE_OS::atoi(poll_list[success].cDeviceID);
			drtp->AddField(F_LVOL0,device_id);
			drtp->AddField(F_LVOL1,(reader_id+1)/2);
			// rac2000 设备ID号
			drtp->AddField(F_LVOL2,node->GetDevId());
			ACE_DEBUG((LM_DEBUG,"门禁事件[%s]",date_str));
			ACE_OS::strcpy(time_str,&date_str[8]);
			date_str[8] = '\0';
			drtp->AddField(F_SDATE0,date_str);
			drtp->AddField(F_STIME0,time_str);
			retries = 3;
			do
			{
				if(drtp->Connect())
					continue;
				if(drtp->SendRequest(500))
					continue;
				if(drtp->GetReturnCode())
				{
					ACE_DEBUG((LM_DEBUG,"保存RAC2000事件失败，返回[%d: %s]",
						drtp->GetReturnCode(),drtp->GetReturnMsg().c_str()));
					continue;
				}
				break;
			}while(--retries>0);
			if(retries <= 0)
				return success;
		}
		return success;
	}
};
