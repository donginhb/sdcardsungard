<%@ page contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include  file="/pages/init.jsp"%><script language="javascript" src="<%=path%>/pages/js/other.js"></script><html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>帐户信息</title>
		<link href="pages/css/css.css" rel="stylesheet" type="text/css" />
		<script type="text/JavaScript">
<!--
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
//-->
</script>

	</head>
	<body scroll="no" onkeydown="return (event.keyCode!=8)">
		<div id="mid_top"></div>
		<div id="middle">
			<div id="Layer1">
				<div id="content">
					<div id="content_left"></div>
					<div id="content_middle">
						<div align="center">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="80"></td>
								</tr>
							</table>
						</div>

						<div id="content_input">
							<table width="50%" border="0" align="center" cellpadding="0"
								cellspacing="0" class="box">

								<%
								if (request.getAttribute("card_id") == null) {
								%>
								<tr>
									<td height="320" align="center" class="样式13">
									<b>	对不起,您还没有开卡!</b>
									</td>
								</tr>
								<%
										} else {

										String state = request.getAttribute("state") == null ? ""
										: request.getAttribute("state").toString();
										String tmp = "";
										if (state.equals("1000")) {
											tmp = "正常";
										} else if (state.equals("2000")) {
											tmp = "注销";
										} else if (state.equals("1100")) {
											tmp = "挂失";
										} else if (state.equals("1010")) {
											tmp = "冻结";
										} else if (state.equals("1001")) {
											tmp = "写卡失败";
										} else if (state.equals("1110")) {
											tmp = "挂失冻结";
										} else if (state.equals("1111")) {
											tmp = "挂失冻结写卡失败";
										}
								%>
								<tr>
									<td height="320" align="center" class="样式13">
									<b>	您的卡已经
										<%="".equals(tmp) ? "挂失了" : tmp%>! </b>
									</td>
								</tr>
								<%
								}
								%>
							</table>
						</div>
						<div id="content_buttom">
							<table>
								<tr>
									<td align="center">
										<a
											onclick="javascript: window.location='<%=path%>/usrexit.do';"
											onmouseout="MM_swapImgRestore()"
											onmouseover="MM_swapImage('back','','<%=path%>/pages/images/zxa.gif',1)"><img
												src="<%=path%>/pages/images/zx.gif" name="back"
												width="109" height="48" border="0" id="back" />
										</a>
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
	</body>
</html>

