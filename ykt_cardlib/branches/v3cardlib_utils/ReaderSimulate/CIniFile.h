#ifndef _CC_INIFILE_H_
#define _CC_INIFILE_H_

#ifdef _MSC_VER
#pragma once
#pragma warning (disable: 4786)
#endif

#include <string>
#include <vector>
#include <map>
#include "StdAfx.h"

class CCIniFile
{
public:
	//! constructor
	/*!
	 \param filename INI文件的路径
	 */
	CCIniFile(const std::string &fileName);
	~CCIniFile(void);
private:
	//<! buffer 大小
	static int ms_maxBufferSize;
	//<! Ini文件名
	std::string m_fileName;
public:
	//! 读取字符串值
	std::string ReadString(const char* section, const char* indent, const char* defaultValue);
	//! 写入INI文件
	bool WriteString(const char* section, const char* indent, const char* value);
	//! 读取所有的 Section
	void ReadSections(std::vector<std::string>& sect);
	//! 读取section的所有 key和 value
	void ReadSectionValues(const char* section,std::map<std::string,std::string>& values);
	//! 读取section下的所有 key
	void ReadSection(const char* section,std::vector<std::string>& keys);
	//! 读取整数值
	int ReadInteger(const char* section, const char* indent,int defaultValue);
	//! 读取布尔值（可以是 true , false , yes ,no ,1 , 0)
	bool ReadBoolean(const char* section,const char* indent,bool defaultValue);

public:
	static char iniDllFilePathBuf[2048];
	static char iniSkinFilePathBuf[2048];
};

#endif // _CC_INIFILE_H_
