<%@ page contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ include  file="/pages/init.jsp"%><script language="javascript" src="<%=path%>/pages/js/other.js"></script><html>
	<head>
		<title>卡片挂失</title>
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
	
	<script type="text/JavaScript">
	function dolosscard()
    { 
          document.lossForm.deviceId.value=readfile();
          lossForm.submit();
    }
	</script>
		<style type="text/css">
	
	.样式13 {
		font-family: "黑体"; 
		color: #000000; 
		font-size: 18px; 
	}
	
	</style>
	</head>
	<%
				com.kingstargroup.fdykt.dto.AccountDTO acc = (com.kingstargroup.fdykt.dto.AccountDTO) session
				.getAttribute("account"); 
		String state = acc.getState_id();
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
		String open_Date = acc.getOpen_Date();
		String close_Date = acc.getClose_Date();
		if (open_Date != null && open_Date.length() == 8)
			open_Date = open_Date.substring(0, 4) + "年"
			+ open_Date.substring(4, 6) + "月"
			+ open_Date.substring(6, 8) + "日";
		if (close_Date != null && close_Date.length() == 8)
			close_Date = close_Date.substring(0, 4) + "年"
			+ close_Date.substring(4, 6) + "月"
			+ close_Date.substring(6, 8) + "日";
			    String    msg =  request.getAttribute("msg")==null?"":request.getAttribute("msg").toString();
	%>
	<body scroll="no" onkeydown="return (event.keyCode!=8)">
		<form action="<%=path%>/lossresult.do" method="post"
			name="lossForm">
			<div id="mid_top"></div>
			<div id="middle">
				<div id="Layer1">
					<div id="content">
						<div id="content_left"></div>
						<div id="content_middle">
							<div align="center">
								<img src="<%=path%>/pages/images/guashi.gif" width="314"
									height="82" />
							</div>

							<div id="content_input">
								<table width="80%" border="0" align="center" cellpadding="0"
									cellspacing="0" class="box">
									<tr>
										<td width="162" height="31" class="样式13">
											客&nbsp;户&nbsp;号
										</td>
										<td width="162">
											<bean:write name="account" property="customer_id" />
											<input type="hidden" name="deviceId"/>
											&nbsp;
										</td>
									</tr>
									<tr>
										<td height="31" class="样式13">
											客&nbsp;户&nbsp;名
										</td>
										<td>
											<bean:write name="account" property="cut_name" />
											&nbsp;
										</td>
									</tr>
									<tr>
										<td height="31" class="样式13">
											帐&nbsp;&nbsp;&nbsp;&nbsp;号
										</td>
										<td>
											<bean:write name="account" property="account_id" />
											&nbsp;
										</td>
									</tr>
									<tr>
										<td height="31" class="样式13">
											卡&nbsp;&nbsp;&nbsp;&nbsp;号
										</td>
										<td>
											<bean:write name="account" property="card_id" />
											&nbsp;
										</td>
									</tr>
									<tr>
										<td height="31" class="样式13">
											卡&nbsp;状&nbsp;态
										</td>
										<td>
											<%=tmp%>
											&nbsp;
										</td>
									</tr>
									<tr>
										<td height="31" class="样式13">
											可用余额
										</td>
										<td>
											<bean:write name="account" property="cur_FreeBala"
												format="0.00" />
											元
										</td>
									</tr>
									<tr>
										<td height="31" class="样式13">
											冻结余额
										</td>
										<td>
											<bean:write name="account" property="cur_FrozeBala"
												format="0.00" />
											元
										</td>
									</tr>
									<tr>
										<td height="31" class="样式13">
											开户日期
										</td>
										<td>
											<%=open_Date%>
											&nbsp;
										</td>
									</tr>
									<tr>
										<td height="31" class="样式13">
											有效期至
										</td>
										<td>
											<%=close_Date%>
											&nbsp;
										</td>
									</tr>
									<tr>
										<td colspan="2" class="样式12" align="center">
											<html:errors />
											&nbsp;
											<%=msg%>
										</td>
									</tr>
								</table>
							</div>
							<div id="content_buttom">
								<table>
									<tr>
										<td align="center">
											<a
												onclick="javascript:dolosscard();"
												onmouseup="MM_swapImgRestore()"
												onmousedown="MM_swapImage('send','','<%=path%>/pages/images/senda.gif',1)"><img
													src="<%=path%>/pages/images/send.gif" name="send"
													width="109" height="48" border="0" id="send" />
											</a>
										</td>
										<td>
											<a
												onclick="javascript: window.location='<%=path%>/usrexit.do';"
												onmouseup="MM_swapImgRestore()"
												onmousedown="MM_swapImage('back','','<%=path%>/pages/images/backa.gif',1)"><img
													src="<%=path%>/pages/images/back.gif" name="back"
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
		</form>
	</body>
</html>

