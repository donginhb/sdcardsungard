/**
 * 
 */
package com.kingstargroup.ecard.util;

import java.util.ArrayList;
import java.util.List;

import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.util.PropsUtil;


/**
 * Copyright (C), 2000-2005, Kingstar Co., Ltd.
 * File name: EcardConstants.java
 * Description: 一卡通综合查询中的常量定义类
 * Modify History: 
 * 操作类型   操作人   操作时间     操作内容
 * ===================================
 *  创建    Xiao Qi  2005-9-2  
 * @author Xiao Qi
 * @version 
 * @since 1.0
 */
public class EcardConstants {
	
	/**
	 * 一卡通普通用户组名
	 */
	public final static String GENERAL_YKT_GROUP_NAME = "YKT General Group";
	
	/**
	 * 一卡通管理员用户组名
	 */
	public final static String ADMIN_YKT_GROUP_NAME = "YKT Admin Group";
	
	/**
	 * 默认结果集大小
	 */
	public final static int DEFAULT_RESULT_SIZE = Integer.parseInt(PropsUtil.get("ecard.result.defaultsize"));
	
	public final static int HOT_INFORMATION_INTERVAL = Integer.parseInt(PropsUtil.get("ecard.hotinfo.interval"));
		
	public final static int LIST_MORE_SIZE = Integer.parseInt(PropsUtil.get("ecard.result.listmoresize"));
	
	public final static int ADMIN_SIZE = Integer.parseInt(PropsUtil.get("ecard.result.adminsize"));
	
	public final static int MAX_RESULT_SIZE = Integer.parseInt(PropsUtil.get("ecard.result.maxsize"));
	
	/**
	 * 新闻信息对应类型值
	 */
	public final static String INFORMATION_NEWS_TYPE = "0";
	
	public final static String INFORMATION_RULE_TYPE = "1";
	
	/**
	 * 文档下载对应类型值
	 */
	public final static String INFORMATION_DOCUMENT_TYPE = "2";
	
	/**
	 * 自动设备分布图对应信息类型值
	 */
	public final static String INFORMATION_DISTRIBUTION_TYPE = "3";
	
	/**
	 * FAQ对应信息类型值
	 */
	public final static String INFORMATION_FAQ_TYPE = "4";
	/**
	 * 卡名单对应信息类型值
	 */
	public final static String INFORMATION_CARDLIST_TYPE = "5";
	
	/**
	 * 操作指南对应信息类型值
	 */
	public final static String INFORMATION_TUTORIAL_TYPE = "7";
	
	/**
	 * 系统简介对应信息类型值
	 */
	public final static String INFORMATION_ABOUT_TYPE = "8";
	
	/**
	 * 服务信息对应信息类型值
	 */
	public final static String INFORMATION_SERVICEINFO_TYPE = "9";
	
	/**
	 * 文档上传最大尺度
	 */
	public final static int DOC_MAX_SIZE = Integer.parseInt(PropsUtil.get("info.upload.document.maxsize"));
	
	/**
	 * 图片上传最大尺度
	 */
	public final static int IMAGE_MAX_SIZE = Integer.parseInt(PropsUtil.get("info.upload.image.maxsize"));
	
	/**
	 * 允许上传的文件列表
	 */
	public final static List DOC_EXTENSION_LIST = new ArrayList();
	
	public final static List IMAGE_EXTENSION_LIST = new ArrayList();
	
	public final static String DELIMITER = ",";
	
	/**
	 * 上传文件存放的根目录
	 */
	public final static String DOC_ROOT = PropsUtil.get("info.upload.document.dir");
	
	public final static String IMAGE_ROOT = PropsUtil.get("info.upload.image.dir");
	
	public final static String CACHE_DIR = PropsUtil.get("picdealy.cache.dir");
	/**
	 * 上传类型定义
	 */
	public final static int IMAGE_TYPE = 1;
	public final static int DOCUMENT_TYPE = 0;
	
	public final static int CARD_STATUS_DIC_NO = 17;
	
	public final static int CARD_TYPE_DIC_NO = 18;
	
	public final static int CONSUME_TYPE_DIC_NO = 21;
	
	public final static String POSTPONE_STATUS_UNACCEPTED = "0";
	
	public final static String POSTPONE_STATUS_ACCEPTED = "1";
	
	public final static String POSTPONE_STATUS_REJECTED = "2";
	/**
	 * 返回信息字符串
	 */
	public final static String CHOOSE_DEL_CONTENT = "choosedelcontent";
	public final static String DELETE_INFO_SUCCEED = "deleteinfosucceed";
	public final static String DELETE_INFO_FAILED = "deleteinfofailed";
	public final static String CHOOSE_PROCESS_CONTENT = "chooseprocesscontent";
	public final static String PROCESS_DELAY_SUCCESS = "processdelaysuccess";
	public final static String ADD_INFO_SUCCEED = "addinfosucceed";
	public final static String EDIT_INFO_SUCCESS = "editinfosuccess";
	public final static String EDIT_PASSWORD_SUCCEED = "editpasswordsucced";
	public final static String REPLY_MSG_SUCCESS = "replymsgsuccess";

	/**
	 * 得到挂失后重新补办正式卡需要的天数的系统参数ID
	 */
	public final static int REAPPLY_DAYS_ID = 9;
	
	/**
	 * 卡注销标识
	 */
	public final static String CARD_WRITE_OFF_STATUS = "2000";
	
	/**
	 * 卡挂失标识
	 */
	public final static char CARD_LOST_FLAG = '1';
	
	public final static String LINE_SEPARATOR = "\r\n";
	
	/**
	 * 留言回复状态
	 */
	public final static String MSG_NO_REPLY = "0";
	public final static String MSG_REPLIED = "1";
	
	public final static String WEB_COUNTER_NAME = "kingstargroup.webcounter";
	
	/*
	 * 定义信息缓存
	 */
	public final static boolean INFO_CACHEABLE = GetterUtil.getBoolean(PropsUtil.get("info.cacheable"));
	public final static int INFO_CACHE_MAXSIZE = GetterUtil.getInteger(PropsUtil.get("info.cache.maxsize"));
	
	public final static int HIT_INFO_SIZE = GetterUtil.getInteger(PropsUtil.get("hitinfo.result.size"));
}
