<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.kingstargroup.fdykt.KSConfiguration" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include  file="/pages/init.jsp"%><script language="javascript" src="<%=path%>/pages/js/other.js"></script><html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>搭伙费清算</title>
		<link href="<%=path%>/pages/css/css.css" rel="stylesheet" type="text/css" />		
		<%
		   String cardno=request.getAttribute("cardno").toString();
		   String writecardmoney = request.getAttribute("writecardmoney").toString();
		   String showmoney = request.getAttribute("showmoney").toString();
		   String cxCnt = request.getAttribute("cxCnt").toString();
		%>
	<script language="javascript">
		  
		function writeCard(){		
			var serverbase = "http://"+"<%=webserverip%>"+":"+"<%=webserverport%>"+"/"+"<%=webserverapp%>"+"/";
			var device_port = '<%=read_card_device_port%>';
			document.all.RFScanner.PortNo=device_port;
			ret = document.all.RFScanner.CardTransWriteCard(<%=writecardmoney%>,<%=cardno%>,<%=cxCnt%>);
			var ret =0;
			if(ret ==0){
				//写卡成功，到成功页面
				msg.innerHTML="搭伙费余额清算完毕<br><br>您的当前卡余额为:"+<%=showmoney%>+"元<br><br>按'返回'退出系统";
			}else{
			   
			    msg.innerHTML="搭伙费余额清算完毕,写卡失败,请到卡务中心处理";
			    
			}
			
		}
		
	</script>
	
	</head>
	<body scroll="no" onload="writeCard()" onkeydown="return (event.keyCode!=8)">
	<form name="returnform">
	  <div id="mid_top"></div>
			<div id="middle">
				<div id="Layer1">
					<div id="content">
						<div id="content_left"></div>
						<div id="content_middle">
							<div align="center">
								<img src="<%=path%>/pages/images/czjg.gif" width="314"
								height="82" />
							</div>
							<div id="content_input">
								<table width="50%" border="0" align="center" cellpadding="0"
									cellspacing="0" class="box">
									<tr>
										<td height="320" align="center" class="样式13" id="msg">
											 正在写卡中，请不要移动校园卡
										</td>
									</tr>

								</table>
							</div>
							<div id="content_buttom">
								<table>
									<tr>
								<!--<td align="left" width="200">
								    <a onclick="writeCard()"
												onmouseup="MM_swapImgRestore()"
												onmousedown="MM_swapImage('send','','<%=path%>/pages/images/senda.gif',1)"><img
													src="<%=path%>/pages/images/send.gif" name="send"
													width="109" height="48" border="0" id="send" /> </a>
						           </td>
										-->
										<td align="center">
											<a
												onclick="javascript: window.location='<%=path%>/index.do';"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('back','','<%=path%>/pages/images/backa.gif',1)"><img
													src="<%=path%>/pages/images/back.gif" name="back"
													width="109" height="48" border="0" id="back" /> </a>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div id="content_right"></div>
					</div>
				</div>
			</div>
			<div id="bottom"></div>
			<object id="RFScanner"
				classid="clsid:{335AEB92-0D39-4999-A2B5-536A2C718901}" width="0"
				height="0" codebase="<%=path%>/rf35.cab#version=2,0,0,7" />
		</form>
	</body>
</html>

