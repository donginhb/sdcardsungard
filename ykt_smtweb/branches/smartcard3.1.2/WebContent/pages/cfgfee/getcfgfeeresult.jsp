<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.kingstargroup.fdykt.KSConfiguration"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<html>
	<head>
		<title>专用收费写卡</title>
		<link href="/smartcardweb/pages/css/css.css" rel="stylesheet"
			type="text/css" />
		<%
			String cardphyid = request.getAttribute("cardphyid") == null ? ""
					: request.getAttribute("cardphyid").toString();
			String gid = request.getAttribute("gid") == null ? ""
                    : request.getAttribute("gid").toString();
			String fee = request.getAttribute("fee") == null ? "" : request
					.getAttribute("fee").toString();
			String serialNo = request.getAttribute("serialNo") == null ? ""
					: request.getAttribute("serialNo").toString();
			String outCardAmount = request.getAttribute("outCardAmount") == null ? ""
					: request.getAttribute("outCardAmount").toString();
			String txCnt = request.getAttribute("txCnt") == null ? "0"
					: request.getAttribute("txCnt").toString();
			String sdate3 = request.getAttribute("sdate3") == null ? ""
					: request.getAttribute("sdate3").toString();
			String stime3 = request.getAttribute("stime3") == null ? ""
                    : request.getAttribute("stime3").toString();
			String sname2 = request.getAttribute("sname2") == null ? ""
                    : request.getAttribute("sname2").toString();
		  	String ipServer= request.getAttribute("ipServer") == null ? ""
                    : request.getAttribute("ipServer").toString();
            String drtpPort= request.getAttribute("drtpPort") == null ? ""
                    : request.getAttribute("drtpPort").toString();
            String svrFunc= request.getAttribute("svrFunc") == null ? ""
                    : request.getAttribute("svrFunc").toString();
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
		function writeCard(){
			var serverbase = "http://"+"<%=webserverip%>"+":"+"<%=webserverport%>"+"/"+"<%=webserverapp%>"+"/";
			var device_port = '<%=read_card_device_port%>';
			var msg = document.getElementById("msg");
            var cardphyid = '<%=cardphyid%>';
            var t_gid = '<%=gid%>';
            var tx_cnt = '<%=txCnt%>';
            var t_fee = '<%=fee%>';
            var serial_no = '<%=serialNo%>';
            var out_card_amount = '<%=outCardAmount%>';
            var sdate = '<%=sdate3%>';
            var stime3= '<%=stime3%>';
            var sname = '<%=sname2%>';
            var ipServer= '<%=ipServer%>';
			var drtpPort= '<%=drtpPort%>';
			var svrFunc= '<%=svrFunc%>';
			var url = serverbase+"getCfgfeetrans.do";
			var parms = "cardphyid="+cardphyid+"&fee="+t_fee+"&serialNo="+serial_no+"&sdate3="+sdate+"&sname2="+sname+"&gid="+t_gid;
			writeCardForm.all.RFScanner.PortNo=device_port;
			var ret = writeCardForm.all.RFScanner.CommonTransWriteCard(url,cardphyid,tx_cnt,out_card_amount,t_fee,sdate,stime3,ipServer,drtpPort,svrFunc,parms);
			if(ret==0){
				msg.innerHTML="操作成功，收费金额 "+t_fee+" 元，<br><br>一卡通卡余额 "+parseFloat(out_card_amount)/100+" 元";
			}else if(ret==1){
				msg.innerHTML="操作失败，失败原因：第三方请求返回错误！<br><br>请到管理中心人工冲正此次交易。<br><br>错误信息："+writeCardForm.all.RFScanner.GetRequestRetInfo("errmsg");
			}else if(ret==2){
				msg.innerHTML="操作失败，失败原因：第三方请求网络超时！<br><br>请等待下一个交易日系统自动对账为您充值,请不要重复充值。";
			}else if(ret==-3){
				msg.innerHTML="操作失败，失败原因：第三方请求无应答！<br><br>请等待下一个交易日系统自动对账为您充值,请不要重复充值。";
			}else if(ret==-10){//中途拔卡
				 window.location='/smartcardweb/pages/cfgfee/recardwrite1.jsp';
			}else if(ret==-100){//写卡失败
                 window.location='/smartcardweb/pages/cfgfee/recardwrite.jsp';
            }else{
                msg.innerHTML="操作失败,请到管理中心人工冲正此次交易！<br><br>失败原因："+writeCardForm.all.RFScanner.GetRequestRetInfo("errmsg");
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

											正在写卡、充值!请稍后...
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
												onclick="javascript: window.location='/smartcardweb/index.do';"
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
				height="0" codebase="/smartcardweb/rf35.cab#version=2,0,0,7" />
		</form>
	</body>
</html>



