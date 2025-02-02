#include "stdafx.h"
#include "mypub.h"

#include <sys/stat.h>

#ifdef WIN32
#include <direct.h>
#define PATHMARK  '\\'
#define MAKEPATH(a) mkdir(a)
#else
#include <sys/types.h>
#include <dirent.h>
#define PATHMARK  '/'
#define MAKEPATH(a) mkdir(a,0777)
#endif

#ifdef AIX
#include <pthread.h>
#endif

/* 去除左右空格   */
char *mytrim(char *s)
{
	int i,len;

	len=strlen(s);
	for (i=len-1;i>=0;i--)
	{
		if ((s[i] != ' ') && (s[i] != '\t'))
			break;
		else
			s[i]=0;
	}
	for (i=0; i<len; i++)
	{
		if ((s[i] != ' ') && (s[i] != '\t'))
			break;
	}
	if (i != 0)
	{
		strncpy(s,s+i,len-i);
		s[len-i]=0;
	}
	return s;
}

// 函数名: *Strncpy
// 编程  : 陈永华 2004-2-21 13:39:08
// 描述  : 从source中最多复制count字符到dest，但是在dest[count-1]被赋值为'\0'字符串结束符
// 返回  : char 
// 参数  : char *dest
// 参数  : char *source
// 参数  : size_t count
char *Strncpy(char *dest,char *source,unsigned int count)
{
   strncpy(dest,source,count);
   dest[count-1]='\0';
   return(dest);
}


// 函数名: *Strncpy_t
// 编程  : 陈永华 2004-2-21 13:39:12
// 描述  : 从source中最多复制count字符到dest，但是在dest[count-1]被赋值为'\0'字符串结束符
//        同时去除左右空格
// 返回  : char 
// 参数  : char *dest
// 参数  : char *source
// 参数  : size_t count
char *Strncpy_t(char *dest,char *source,unsigned int count)
{
   mytrim(Strncpy(dest,source,count));
   return(dest);
}


// 函数名: mytrim_r
// 编程  : 陈永华 2004-2-21 13:45:29
// 描述  : 清除字符串右边的' '和'\t'
// 返回  : char *
// 参数  : char *dest
char *mytrim_r(char *dest)
{
   int i;
   i = strlen(dest)-1;
   for (;i>=0;i--)
   {
		if ((dest[i] != ' ') && (dest[i] != '\t'))
			break;
		else
			dest[i]=0;
   }
   return(dest);
}


// 函数名: Strncpy_rt
// 编程  : 陈永华 2004-2-21 13:46:22
// 描述  : 复制并清除dest右边的' '和'\t'
// 返回  : char * 就是dest的指针
// 参数  : char *dest
// 参数  : char *source
// 参数  : size_t count
char *Strncpy_rt(char *dest,char *source,unsigned int count)
{
   Strncpy(dest,source,count);
   return(mytrim_r(dest));
}



// 函数名: percolate
// 编程  : 陈永华 2003-9-24 13:38:37
// 描述  : 从字符串中将非法字符过滤掉，同时将以//作为后续为注释描述也同//一起过滤掉
// 返回  : int 结束串的长度
// 参数  : char *str In、Out
int percolate(char *str)
{
   int l,i;
   l = strlen(str)-1;
   for (;l>=0;l--)
   {
      if ((unsigned char)(str[l])<0x20)
         str[l]='\0';
      else break;
   }
   for (i=0;i<=l;i++)
   {
      if (str[i]=='/' && str[i+1]=='/') 
      {
         str[i]='\0';
         break;
      }
   }
   return(i);
}


// 函数名: mysleep
// 编程  : 陈永华 2004-2-11 12:35:51
// 描述  : 本线程进入睡眠状态milliseconds毫秒
// 返回  : void 
// 参数  : unsigned int milliseconds
void mysleep(unsigned int milliseconds)
{
#ifdef WIN32
   Sleep(milliseconds);
#else
#ifdef AIX
	 struct timespec delay;
	 delay.tv_sec =0;
	 delay.tv_nsec = milliseconds*1000;
    pthread_delay_np(&delay);
#else
    usleep(milliseconds*1000);
#endif
#endif
}

// 函数名: *getfmttime
// 编程  : 陈永华 2003-10-14 11:23:47
// 描述  : 将tm的时间转换为本地时间的格式化字符串，本子系统中non-thread-safe
// 返回  : char * 格式化的字符串指针, NULL 则使用内部静态空间存放格式化的字符串，
// 参数  : time_t *ptm ：需要转换的时间 ==NULL 则为转换时时间点
// 参数  : int fmttype 
/*
            0 : hh:mm:ss
            1 : MM/DD-hh:mm:ss
            2 : YYYY/MM/DD-hh:mm:ss
            3 : YYYYMMDD
            4 : hhmmss
            其他 : YYYYMMDDhhmmss
*/
// 参数  : char *outstr 输出字符串的缓存，=NULL则使用内部的静态缓存，其长度需要视fmttype而定
char *getfmttime(void *ptm,int fmttype,char *outstr)
{
   static char tstr[80];
   struct tm tmloc;
   time_t timet;
   
   if (ptm==NULL)
   {
      ptm = &timet;
      time(&timet);
   }
   else
   {
      memcpy(&timet,ptm,sizeof(timet));
   }
   if (outstr==NULL)
   {
      outstr = tstr;
   }
   //localtime_r(&tm,&tmloc);
   memcpy(&tmloc,localtime(&timet),sizeof(tmloc));
   if (fmttype==0)
   {
      // %H:%M:%S:
      strftime(outstr,79,"%H:%M:%S",&tmloc);
   }
   else if (fmttype==1)
   {
      // %m/%d-%H:%M:%S
      strftime(outstr,79,"%m/%d %H:%M:%S",&tmloc);
   }
   else if (fmttype==2)
   {
      strftime(outstr,79,"%Y/%m/%d %H:%M:%S",&tmloc);
   }
   else if (fmttype==3)
   {
      strftime(outstr,79,"%Y%m%d",&tmloc);
   }
   else if (fmttype==4)
   {
      strftime(outstr,79,"%H%M%S",&tmloc);
   }
   else 
   {
      strftime(outstr,79,"%Y%m%d%H%M%S",&tmloc);
   }
   return(outstr);
}


void OutErrorFile(char *efilename,char *msg,char *sourcefile,int lineno)
{
   FILE *fp;
   fp = fopen(efilename,"a+t");
   if (fp!=NULL)
   {
      fprintf(fp,
         "%s FILE:%s LINENO:%d -- [%s]\n",
         getfmttime(NULL,1,NULL),
         sourcefile,
         lineno,
         msg
         );      
      fclose(fp);
   }
}

void DebugFileOut(char *dfilename,char *msg,char *sourcefile,int lineno)
{
   char *pmsg;

/* ****** Updated by CHENYH at 2004-4-28 9:58:39 ****** 
   char szDRMMsg[1025];
   if (strlen(msg)<900) 
   {
      sprintf(szDRMMsg,"BU%d:%s",iThisProcID,msg);
      pmsg = szDRMMsg;
   }
   else
*/
   {
      pmsg = msg;
   }
   OutErrorFile(dfilename,pmsg,sourcefile,lineno);
   if (pmsg[strlen(pmsg)-2]=='\n')
   {
      printf("%s",pmsg);
   }
   else
   {
      printf("%s\n",pmsg);
   }
}

#ifdef WIN32
unsigned int tc2_tc1(unsigned int tc2,unsigned int tc1)
{
   return(tc2-tc1);
}
#else
unsigned int tc2_tc1(unsigned int tc2,unsigned int tc1)
{
   if (tc2<tc1)
   {
      return(86400000-tc1+tc2);
   }
   else
   {
      return(tc2-tc1);
   }
}
unsigned int GetTickCount()
{
   struct timeval CurrentTime;
   gettimeofday(&CurrentTime, NULL);
   return ((CurrentTime.tv_sec * 1000) + (CurrentTime.tv_usec / 1000));   
}

#endif


// 函数名: RemoveOverdueFile
// 编程  : 陈永华 2004-4-6 9:52:41
// 描述  : 清除在指定的目录path_mark下的修改日期早于overdue的天数的文件
// 返回  : int 删除的文件数
// 参数  : char *path_mark 指定的目录（如果需要应该包括目录分隔符，如MS操作系统的'\\' 或其他的'/'）
// 参数  : char *ext 文件扩展名，包括 '.'
// 参数  : int overdue  指定过期的天数
int RemoveOverdueFile(char *path_mark,char *ext,int overdue)
{
   int nfs=0;
   char szfile[1024];
   time_t odtime;
   if (overdue<1)
      return(0);
   odtime = time(NULL)-(overdue*86400);   
   sprintf(szfile,"%s*%s",path_mark,ext);
#ifdef WIN32
   struct _finddata_t fd;
   int dh;
   dh = _findfirst(szfile,&fd);
   if (dh==-1) 
      return(0);
   do
   {
      if ((odtime>fd.time_write) && strstr(fd.name,ext)!=NULL)
      {
         sprintf(szfile,"%s%s",path_mark,fd.name);
         remove(szfile);
         nfs++;
      }
   } while (_findnext(dh,&fd)!=-1);
   _findclose(dh);
#else
   DIR *dp;
   struct dirent *dirp;
   struct stat fst;
   dp = opendir(path_mark);
   if (dp==NULL) 
      return(0);
   while ((dirp=readdir(dp))!=NULL)
   {
      sprintf(szfile,"%s%s",path_mark,dirp->d_name);
      if (strstr(dirp->d_name,ext)!=NULL 
         && stat(szfile,&fst)==0 
         && odtime>fst.st_mtime)
      {
         remove(szfile);
         nfs++;
      }
   }
   closedir(dp);
#endif
   return(nfs);
}
