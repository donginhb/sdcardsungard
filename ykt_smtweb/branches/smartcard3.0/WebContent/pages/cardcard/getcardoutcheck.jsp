<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.kingstargroup.fdykt.KSConfiguration"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<html>
	<head>
		<title>卡卡转账确认</title>
		<link href="/smartcardweb/pages/css/css.css" rel="stylesheet"
			type="text/css" />
		<%
            String logincardId =  session.getAttribute("cardno") == null ? ""
                    : session.getAttribute("cardno").toString();      
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
		
		function dochecktrans()
        {
         var serverbase = "http://"+"<%=webserverip%>"+":"+"<%=webserverport%>"+"/"+"<%=webserverapp%>"+"/";
           var device_port = '<%=read_card_device_port%>'; 
           var logingcardid = '<%=logincardId%>'
           writeCardForm.all.RFScanner.PortNo=device_port;//读卡器端口设置
           var ret=writeCardForm.all.RFScanner.DoScan();
           if(ret==0){
           //读卡成功
               var cardid = writeCardForm.all.RFScanner.CardNo;
               if(cardid!=logingcardid){
                    alert("此卡非转出卡，请放入要转出的卡片");
                    return false;
               }else{
	              var rrt = writeCardForm.all.RFScanner.GetMainKey(serverbase+"getSysPara.do");    
	              if(rrt == 0){
	                var pktret = writeCardForm.all.RFScanner.ReadCardPocket(1,cardid,"");      
	                if(pktret==0){
	                    writeCardForm.action='/smartcardweb/getcardoutchecknext.do';    
	                    writeCardForm.all.cardphyno.value=cardid;                     
	                    writeCardForm.all.cardbalance.value=writeCardForm.all.RFScanner.GetPacketInfo("bala");                     
	                    writeCardForm.all.cardcnt.value=writeCardForm.all.RFScanner.GetPacketInfo("total_cnt");      
	                    writeCardForm.submit();
	                 }else{
	                    alert("读卡失败，请正确放置卡片...");
	                    return false;
	                 }
	              }else{
	                   alert("网络不通，请稍后重试...");
	                   return false;
	               } 
              }
             }else{
               alert("读卡失败，请放置卡片...");
               return false;
           }
                   
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
		<form action="/smartcardweb/cardcardchecktrans.do" method="post"
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
								<table width="80%" border="0" align="center" cellpadding="0"
									cellspacing="0" class="box">
									 <tr>
                                        <td width="50%" height="50" class="样式13">
                                                                                                 收款方卡学/工号：
                                        </td>
                                        <td>
                                            <%=request.getAttribute("outstuempno") == null ? ""
                    : request.getAttribute("outstuempno")%> 
                                        </td>
                                    </tr>   
                                    <tr>
                                        <td height="50" class="样式13">
                                                                                                 收款方卡姓名：
                                        </td>
                                        <td>
                                            <%=request.getAttribute("outaccname") == null ? ""
                    : request.getAttribute("outaccname")%> 
                                        </td>
                                    </tr>
									   <tr>
										<td height="50" class="样式13">
											卡片余额:
											<input type="hidden" name="outcardphyno"
                                                value="<%=request.getAttribute("outcardphyno") == null ? "0"
                    : request.getAttribute("outcardphyno")%>" />
    
                                            <input type="hidden" name="outcardbalance"
                                                value="<%=request.getAttribute("outcardbalance") == null ? "0"
                    : request.getAttribute("outcardbalance")%>" />
                    <input type="hidden" name="outcardcnt"
                                                value="<%=request.getAttribute("outcardcnt") == null ? "0"
                    : request.getAttribute("outcardcnt")%>" />
                                         <input type="hidden" name="cardphyno" />
                                            <input type="hidden" name="cardbalance"/>
                                            <input type="hidden" name="cardcnt" />
										</td>
										<td>
											<%=request.getAttribute("outcardbalance") == null?0: Float.parseFloat(request.getAttribute("outcardbalance").toString())/100%>
											元
										</td>
									</tr>
								

									<tr>
										<td height="180" align="center" class="show" id="errmsg"
											colspan="2">
											<html:errors />											
											请确认 <font style="font-size: 22px;"><b>收款方卡</b></font> 信息后
											<br>
											<br>
                                            
											请将  <font style="font-size: 22px;"><b>转出卡</b></font> 放置于读卡器上，点击   <font style="font-size: 22px;"><b>确定</b></font> 进入下一步
											 <br>
											
											<br>
											<br>
											<br>
										</td>
									</tr>
								</table>
							</div>
							<div id="content_buttom">
								<table>
									<tr>
										<td align="center">
											<a onclick="javascript:dochecktrans();"
												onmouseup="MM_swapImgRestore()"
												onmousedown="MM_swapImage('send','','/smartcardweb/pages/images/senda.gif',1)"><img
													src="/smartcardweb/pages/images/send.gif" name="send"
													width="109" height="48" border="0" id="send" /> </a>
										</td>
										<td>
											<a
												onclick="javascript: window.location='/smartcardweb/main.do';"
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

