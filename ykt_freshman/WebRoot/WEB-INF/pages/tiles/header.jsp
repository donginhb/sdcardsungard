<%@page pageEncoding="GBK"%>
<%@ include file="include.jsp"%>
<%@page import="java.text.SimpleDateFormat"%>

<%String style = (session != null && session.getAttribute("STYLE") != null) ? (String) session
					.getAttribute("STYLE")
					: "default";
			String context = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath();
			String stylePath = context + "/pages/style/" + style;

            String userName = (String) session.getAttribute("userName");
            if (userName == null) {
				userName = "";
			}
			
			String personName = (String) session.getAttribute("personName");
			if (personName == null) {
				personName = "";
			}
%>

<table width="100%" height="86" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="56" align="center" valign="top" background="<%=stylePath%>/images/top1bg.gif"><img src="<%=stylePath%>/images/top1.gif" width="997" height="56" border="0" usemap="#Map"></td>
  </tr>
  <tr> 
    <td align="center" valign="top" background="<%=stylePath%>/images/top2bg.jpg"><table width="997" height="30" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="226" align="left" valign="middle" background="<%=stylePath%>/images/top2.gif">&nbsp;</td>
          <td width="771" align="left" valign="middle"><font color="#FFFFFF"><%=userName%> - <%=personName%>，您好！ 
            今天是<script language=JavaScript> var version = 1.0;</script> <script language=JavaScript1.1> var version = 1.1;</script> <script language=JavaScript1.2> var version = 1.2;</script> <script
								language=JavaScript1.3> var version = 1.3;</script> <script language="JavaScript">
								<!--
								var y=new Date();  
								var gy=y.getYear();  
								var dName=new Array("星期天","星期一","星期二","星期三","星期四","星期五","星期六");  
								var mName=new Array("1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月");  
								if (version < 1.3)  
								{  
								    if (gy<2000)  
								    {  
										document.write(""+"19"+y.getYear()+"年" + mName[y.getMonth()] + y.getDate() + "日 " + dName[y.getDay()] + "" + "");  
									}  
									else  
										document.write(""+y.getYear()+"年" + mName[y.getMonth()] + y.getDate() + "日 " + dName[y.getDay()] + "" + "");  
									}  
									else  
									{  
										document.write(""+y.getFullYear() +"年"+ mName[y.getMonth()] + y.getDate() + "日 " + dName[y.getDay()] + "");  
									}  
								//-->
								</script></font></td>
        </tr>
      </table> </td>
  </tr>
</table>

<map name="Map">
	<area shape="rect" coords="900,35,940,55" href="logoutAction.do?method=logout" target="_parent">
	<area shape="rect" coords="830,35,890,55" href="changePWDManager.do?method=load4ChangePWD" target="main">
	<area shape="rect" coords="946,35,987,55" id="DownloadOptions" href="./all.htm" alt="系统帮助" target="_blank">
</map>
