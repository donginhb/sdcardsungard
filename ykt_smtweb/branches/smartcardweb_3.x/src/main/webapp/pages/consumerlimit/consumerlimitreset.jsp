<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.kingstargroup.fdykt.KSConfiguration"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<html>
	<head>
		<title>限额重置成功</title>
		<link href="/smartcardweb/pages/css/css.css" rel="stylesheet"
			type="text/css" />
		<%
			String CardPhyId = request.getAttribute("CardPhyId") == null ? ""
					: request.getAttribute("CardPhyId").toString();
			String maxpercount = request.getAttribute("maxpercount") == null ? "50"
					: request.getAttribute("maxpercount").toString();
			String maxperday = request.getAttribute("maxperday") == null ? "100"
					: request.getAttribute("maxperday").toString();
			String webserverip = KSConfiguration.getInstance().getProperty(
					"webserverip");
			String webserverport = KSConfiguration.getInstance().getProperty(
					"webserverport");
			String webserverapp = KSConfiguration.getInstance().getProperty(
					"webserverapp");
			String read_card_device_port = KSConfiguration.getInstance()
					.getProperty("read_card_device_port", "0");
		%>
		<script type="text/JavaScript">
		var serverbase = "http://"+'<%=webserverip%>'+":"+'<%=webserverport%>'+"/"+'<%=webserverapp%>'+"/";
		var device_port = '<%=read_card_device_port%>';
		function writeCard(){
			var card_id = '<%=CardPhyId%>';
			var t_maxpercount = '<%=maxpercount%>';
			var t_maxperday = '<%=maxperday%>';
			writeCardForm.all.RFScanner.PortNo=device_port;
			var ret = writeCardForm.all.RFScanner.ResetConsumerLimit(card_id,t_maxpercount,t_maxperday);
			if(ret==0){
				msg.innerHTML="卡限额修改成功!<br/><br/>单次消费限额 "+parseFloat(t_maxpercount)/100+" 元.<br/><br/>日累计消费限额 "+parseFloat(t_maxperday)/100+" 元";
			}else if(ret==2){
                msg.innerHTML="卡限额修改失败!<br/><br/>失败原因：写限额失败，请重新修改！";
            }else if(ret==-2){
				msg.innerHTML="卡限额修改失败!<br/><br/>失败原因：写卡失败，请重新修改！";
			}else if(ret==-3){
				msg.innerHTML="卡限额修改失败!<br/><br/>失败原因：卡号不正确！";
			}else{
				msg.innerHTML="卡限额修改失败!<br/><br/>失败原因：未知错误(返回码："+ret+")!";
			}
		}
		function MM_swapImgRestore() { //v3.0
		  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
		}
		
		function MM_preloadImages() { //v3.0
		  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
		    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
		    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
		}
		
		function MM_findObj(n, d) { //v4.01
		  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
		    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
		  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
		  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
		  if(!x && d.getElementById) x=d.getElementById(n); return x;
		}
		
		function MM_swapImage() { //v3.0
		  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
		   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
		}
		</script>
		<style type="text/css">
.样式5 {
	font-family: "宋体";
	color: #000000;
	font-size: 18px;
}

.样式13 {
	font-family: "黑体";
	color: #ff0000;
	font-size: 18px;
}
</style>
	</head>
	<body scroll="no" onload="javascript:writeCard();">
		<form action="" method="post" name="writeCardForm">
			<div id="mid_top"></div>
			<div id="middle">
				<div id="Layer1">
					<div id="content">
						<div id="content_left"></div>
						<div id="content_middle">
							<div align="center">
								<img src="/smartcardweb/pages/images/czjg.gif" width="314"
									height="82" />
							</div>

							<div id="content_input">
								<table width="70%" border="0" align="center" cellpadding="0"
									cellspacing="0" class="box">

									<tr>
										<td height="320" align="center" class="样式13" id="msg">

											正在更新卡信息!请稍后...
											<br />
											(可能需要等待一段时间，请不要移动卡片！)
										</td>
									</tr>

								</table>
							</div>
							<div id="content_buttom">
								<table>
									<tr>
										<td align="center">
											<a
												onclick="javascript: window.location='/smartcardweb/main.do';"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('cancel','','/smartcardweb/pages/images/backa.gif',1)"><img
													src="/smartcardweb/pages/images/back.gif" name="cancel"
													width="109" height="48" border="0" id="cancel" /> </a>
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
				height="0" />
		</form>
	</body>
</html>



