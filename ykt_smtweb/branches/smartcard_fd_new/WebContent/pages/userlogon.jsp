<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include  file="/pages/init.jsp"%><script language="javascript" src="<%=path%>/pages/js/other.js"></script><html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>用户登陆</title>
		<link href="<%=path%>/pages/css/css.css" rel="stylesheet"
			type="text/css" />   
		<style type="text/css">
			.样式12 {
			font-family: "宋体"; 
			color: #000000; 
			font-size: 14px;
			}
			.样式11 {
			font-family: "宋体"; 
			color: #000000; 
			font-size: 18px;
			font-weight: bold;
			}
		</style>
		<script language="javascript">
		   
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
        function addnum(num)
        {
			if(logonForm.nowinput.value=="1" && logonForm.stuempno.value.length < 15){
				if(logonForm.locknum.value=="1"){
					logonForm.stuempno.value+=num;
				}else{
					logonForm.stuempno.value+=num.toUpperCase();
				}
				
			}else if(logonForm.nowinput.value=="2" && logonForm.password.value.length < 6){
				logonForm.password.value+=num;
			}
        }
        function numlock(){
        	if("1"==logonForm.locknum.value){
        		logonForm.locknum.value="2";
        		document.all.lock.style.background='url(<%=path%>/pages/images/locka.gif)';
				
        	}else{
        		logonForm.locknum.value="1";
        		document.all.lock.style.background='url(<%=path%>/pages/images/lock.gif)';
        	}
        }
        
        function backnum()
        {
		if(logonForm.nowinput.value=="1")
			logonForm.stuempno.value=logonForm.stuempno.value.substring(0,logonForm.stuempno.value.length-1);
		else if(logonForm.nowinput.value=="2")
			logonForm.password.value=logonForm.password.value.substring(0,logonForm.password.value.length-1);
        }
        function tab()
        {
              if(logonForm.nowinput.value=="1")
                 logonForm.password.focus();
              else if(logonForm.nowinput.value=="2")
                 logonForm.stuempno.focus();
        }
        function toup(){
           document.logonForm.stuempno.focus();
        }
        function todown(){
           document.logonForm.password.focus();
        }
        function init(){
            document.getElementById("previce").style.display='none';
            document.getElementById("next").style.display='none';
		    javascript:document.logonForm.stuempno.focus();
        }
       
       
        </script>
	
	</head>
	<body scroll="no"
		onload="init();">
		<form action="<%=path%>/userlogon.do" method="post"
			name="logonForm">
			<div id="mid_top"></div>
			<div id="middle">
				<div id="Layer1">
					<div id="miss">
						<table width="900" border="0" align="center" cellpadding="0"
							cellspacing="0">
							<tr>
								<td height="32" colspan="2">
									&nbsp;<input type="hidden" name="nowinput" value="1" />
									<input type="hidden" name="locknum" value="1" />
								</td>
							</tr>
							<tr>
								<td width="355" height="81" valign="top">
									&nbsp;
								</td>
								<td width="505" rowspan="2" valign="top">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												&nbsp;
											</td>
										</tr>
										<tr>
											<td>
												&nbsp;
											</td>
										</tr>
										<tr>
											<td>
												<div id="mis">
													<div>
														<ul>
															<li onmouseup="this.style.background='url(<%=path%>/pages/images/a.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/aa.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/a.gif)"
																onclick="javascript:addnum('a');"></li>
															<li onmouseup="this.style.background='url(<%=path%>/pages/images/b.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ba.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/b.gif)"
																onclick="javascript:addnum('b');"></li>
															<li onmouseup="this.style.background='url(<%=path%>/pages/images/c.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ca.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/c.gif)"
																onclick="javascript:addnum('c');"></li>
															<li onmouseup="this.style.background='url(<%=path%>/pages/images/d.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/da.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/d.gif)"
																onclick="javascript:addnum('d');"></li>
															<li onmouseup="this.style.background='url(<%=path%>/pages/images/e.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ea.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/e.gif)"
																onclick="javascript:addnum('e');"></li>
															<li onmouseup="this.style.background='url(<%=path%>/pages/images/f.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/fa.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/f.gif)"
																onclick="javascript:addnum('f');"></li>
															<li onmouseup="this.style.background='url(<%=path%>/pages/images/g.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ga.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/g.gif)"
																onclick="javascript:addnum('g');"></li>
															<li onmouseup="this.style.background='url(<%=path%>/pages/images/h.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ha.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/h.gif)"
																onclick="javascript:addnum('h');"></li>
															<li onmouseup="this.style.background='url(<%=path%>/pages/images/i.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ia.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/i.gif)"
																onclick="javascript:addnum('i');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/j.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ja.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/j.gif)"
																onclick="javascript:addnum('j');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/k.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ka.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/k.gif)"
																onclick="javascript:addnum('k');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/l.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/la.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/l.gif)"
																onclick="javascript:addnum('l');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/m.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ma.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/m.gif)"
																onclick="javascript:addnum('m');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/n.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/na.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/n.gif)"
																onclick="javascript:addnum('n');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/o.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/oa.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/o.gif)"
																onclick="javascript:addnum('o');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/p.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/pa.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/p.gif)"
																onclick="javascript:addnum('p');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/q.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/qa.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/q.gif)"
																onclick="javascript:addnum('q');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/r.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ra.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/r.gif)"
																onclick="javascript:addnum('r');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/s.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/sa.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/s.gif)"
																onclick="javascript:addnum('s');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/t.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ta.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/t.gif)"
																onclick="javascript:addnum('t');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/u.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ua.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/u.gif)"
																onclick="javascript:addnum('u');"></li>
															<li onmouseup="this.style.background='url()'"
																onmousedown="this.style.background='url()'"
																style="cursor:hand; background:url()"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/v.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/va.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/v.gif)"
																onclick="javascript:addnum('v');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/w.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/wa.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/w.gif)"
																onclick="javascript:addnum('w');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/x.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/xa.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/x.gif)"
																onclick="javascript:addnum('x');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/y.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/ya.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/y.gif)"
																onclick="javascript:addnum('y');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/z.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/za.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/z.gif)"
																onclick="javascript:addnum('z');"></li>
															<li onmouseup="this.style.background='url()'"
																onmousedown="this.style.background='url()'"
																style="cursor:hand; background:url()"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/0.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/0a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/0.gif)"
																onclick="javascript:addnum('0');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/1.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/1a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/1.gif)"
																onclick="javascript:addnum('1');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/2.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/2a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/2.gif)"
																onclick="javascript:addnum('2');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/3.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/3a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/3.gif)"
																onclick="javascript:addnum('3');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/4.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/4a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/4.gif)"
																onclick="javascript:addnum('4');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/5.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/5a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/5.gif)"
																onclick="javascript:addnum('5');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/6.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/6a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/6.gif)"
																onclick="javascript:addnum('6');"></li>
															<li id="lock"
																style="cursor:hand; background:url(<%=path%>/pages/images/lock.gif)"
																onclick="javascript:numlock();"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/7.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/7a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/7.gif)"
																onclick="javascript:addnum('7');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/8.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/8a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/8.gif)"
																onclick="javascript:addnum('8');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/9.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/9a.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/9.gif)"
																onclick="javascript:addnum('9');"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/del.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/dela.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/del.gif)"
																onclick="javascript:backnum();"></li>
															<li
																onmouseup="this.style.background='url(<%=path%>/pages/images/tab.gif)'"
																onmousedown="this.style.background='url(<%=path%>/pages/images/taba.gif)'"
																style="cursor:hand; background:url(<%=path%>/pages/images/tab.gif)"
																onclick="javascript:tab();"></li>
														</ul>
													</div>


												</div>
											</td>
										</tr>
										<tr>
											<td>
												&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="250" align="center" valign="top">
									<p>
										&nbsp;
									</p>
									<table width="90%" border="0" align="right" cellpadding="0"
										cellspacing="0">
										<tr>
											<td align="center" colspan = "2">
											   <font color="red"><html:errors/></font>
											</td>
											
										</tr>
										<tr>
											<td align="center">
												<img src="<%=path%>/pages/images/xh.gif" width="99"
													height="31" align="absmiddle" />
											</td>
											<td>
												<input type="text" name="stuempno" class="样式11" size="15"
													maxlength="15"
													onfocus="javascript:logonForm.nowinput.value='1'" />
											</td>
										</tr>
										<tr>
											<td align="center">
												<img src="<%=path%>/pages/images/ps.gif" width="99"
													height="29" align="absmiddle" />
											</td>
											<td>
												<input name="password" type="password" class="样式11"
													onfocus="javascript:logonForm.nowinput.value='2'" size="15"
													maxlength="6" />
											</td>
										</tr>
										<tr>
											<td colspan="2">
												&nbsp;
											</td>
										</tr>
										<tr>
											<td colspan="2">
												&nbsp;
											</td>
										</tr>
										<tr>
											<td align="right" colspan="2">
												<a onclick="javascript:logonForm.submit();"
													onmouseup="MM_swapImgRestore()"
													onmousedown="MM_swapImage('send','','<%=path%>/pages/images/senda.gif',1)"><img
														src="<%=path%>/pages/images/send.gif" name="send"
														width="109" height="48" border="0" id="send" /> </a>

												<a
													onclick="javascript: window.location='<%=path%>/index.do';"
													onmouseup="MM_swapImgRestore()"
													onmousedown="MM_swapImage('back','','<%=path%>/pages/images/backa.gif',1)"><img
														src="<%=path%>/pages/images/back.gif" name="back"
														width="109" height="48" border="0" id="back" /> </a>
											</td>
											
										</tr>
										<tr>
											<td align="right" colspan="2">
								   <a onclick="javascript:toup()"
								            onmouseout="MM_swapImgRestore()"
								            onmousedown="MM_swapImage('previce','','<%=path%>/pages/images/previcea.gif',1)"><img
									        src="<%=path%>/pages/images/previce.gif" name="previce"
									        width="109" height="48" border="0" id="previce" /> </a>

									<a onclick="javascript:todown()"
								    onmouseout="MM_swapImgRestore()"
								    onmousedown="MM_swapImage('next','','<%=path%>/pages/images/nexta.gif',1)"><img
									src="<%=path%>/pages/images/next.gif" name="next"
									width="109" height="48" border="0" id="next" /> </a>
														
											</td>
										</tr>

									</table>

									<div id="login_buttom">
									</div>
								</td>
							</tr>
						</table>
					</div>

				</div>
			</div>
			<div id="bottom"></div>
		</form>
	</body>
</html>

