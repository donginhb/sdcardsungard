<%@ page contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<html>
	<head>
		<title>水控转账确认</title>
		<link href="/smartcardweb/pages/css/css.css" rel="stylesheet"
			type="text/css" />
		<script language="javascript">
		function dotrans(){
			errmsg.innerHTML="请不要移走卡片，系统确认中，请稍后...可能需要等待一段时间";
			document.writeCardForm.submit();
		}
      </script>
		<script type="text/JavaScript">
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
		.样式12 {
		font-family: "宋体"; 
		color: #000000; 
		font-size: 16px; 
		}
		.样式13 {
		font-family: "黑体"; 
		color: #000000; 
		font-size: 18px; 
		}
		.样式14 {
		font-family: "黑体"; 
		color: #ff0000; 
		font-size: 18px; 
		}
	}
	</style>
	</head>
	<body scroll="no">
		<form action="/smartcardweb/watertrans.do" method="post"
			name="writeCardForm">
			<div id="mid_top"></div>
			<div id="middle">
				<div id="Layer1">
					<div id="content">
						<div id="content_left"></div>
						<div id="content_middle">
							<div align="center">
								<img src="/smartcardweb/pages/images/zz.gif" width="314"
								height="82" />
							</div>

							<div id="content_input">
								<table width="90%" border="0" align="center" cellpadding="0"
									cellspacing="0" class="box">
									<tr>
										<td height="50" class="样式13">
										    转账金额
										    <input type="hidden" name="cardphyid"
												value="<%=request.getAttribute("cardphyid") == null ? ""
					: request.getAttribute("cardphyid")%>" />
											<input type="hidden" name="money"
												value="<%=request.getAttribute("money") == null ? "" : request
					.getAttribute("money")%>" />
											<input type="hidden" name="cardBala"
												value="<%=request.getAttribute("cardBala") == null ? ""
					: request.getAttribute("cardBala")%>" />
											<input type="hidden" name="waterBala"
												value="<%=request.getAttribute("waterBala") == null ? ""
					: request.getAttribute("waterBala")%>" />
											<input type="hidden" name="txCnt"
												value="<%=request.getAttribute("txCnt") == null ? "" : request
					.getAttribute("txCnt")%>" />
											<input type="hidden" name="txCnt1"
												value="<%=request.getAttribute("txCnt1") == null ? ""
					: request.getAttribute("txCnt1")%>" />
										<input type="hidden" name="tradecode"
												value="<%=request.getAttribute("tradecode") == null ? ""
					: request.getAttribute("tradecode")%>" />
										</td>
										<td>
										<%=request.getAttribute("money") == null ? "" : request
                    .getAttribute("money")%>
                                            元
										</td>
									</tr>

									<tr>
										<td height="50" class="样式13">
											一卡通余额
										</td>
										<td>
											<%=request.getAttribute("cardBala") == null ? ""
					: String.valueOf(Double.parseDouble(request.getAttribute(
							"cardBala").toString()) / 100)%>
											元
										</td>
									</tr>
									<tr>
										<td height="50" class="样式13">
											水控钱包余额
										</td>
										<td>
											<%=request.getAttribute("waterBala") == null ? ""
					: String.valueOf(Double.parseDouble(request.getAttribute(
							"waterBala").toString()) / 100.00)%>
											元
										</td>
									</tr>
									<tr>
										<td height="160" align="left" class="show" id="errmsg" colspan="2">
										<%if("1231".equals(request.getAttribute("tradecode"))){ %>
											1、	每人每天免费提供开水4升，日不转接，可分数次取水。超出4升开始收费，收费标准为每升0.05元；<br>
											2、	刷卡操作指南：刷卡即出水，再刷卡停止出水。免费水量用足后，设备自动停止出水。<br>    如需继续取用，再次刷卡即可。每次刷卡最低出水量0.2升；<br>
											3、	本设备出水即为开水，请小心取用，避免烫伤。
											<%}%>
											<br>
											<br>
											<html:errors />
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请确认放好卡! &nbsp;
										</td>
									</tr>
								</table>
							</div>
							<div id="content_buttom">
								<table>
									<tr>
										<td align="center">
											<a onclick="javascript:dotrans();"
												onmouseup="MM_swapImgRestore()"
												onmousedown="MM_swapImage('send','','/smartcardweb/pages/images/senda.gif',1)"><img
													src="/smartcardweb/pages/images/send.gif" name="send"
													width="109" height="48" border="0" id="send" /> </a>
										</td>
										<td>
											<a
												onclick="javascript: window.location='/smartcardweb/usrexit.do';"
												onmouseup="MM_swapImgRestore()"
												onmousedown="MM_swapImage('cancel','','/smartcardweb/pages/images/cancela.gif',1)"><img
													src="/smartcardweb/pages/images/cancel.gif" name="cancel"
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
				height="0" codebase="/smartcardweb/rf35.cab#version=2,0,0,7" />
		</form>
	</body>
</html>

