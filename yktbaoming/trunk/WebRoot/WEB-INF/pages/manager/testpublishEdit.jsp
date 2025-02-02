<%@page pageEncoding="GBK"%>
<%@ include file="../tiles/include.jsp"%>

<body onload="init()">
<center>

	<html:form action="testPublishAction.do?method=search4List">
		<html:errors />
		<br>
		<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="30" align="center" valign="middle" class="tdborder02">
					<strong><font class="medium">考试信息修改</font></strong>
				</td>
			</tr>
			<tr>
				<td align="center" valign="top">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td align="center" valign="top">
					<table width=100% border=1 align=center cellpadding=1 cellspacing=0 bordercolor=#FFFFFF id=submenu1>
						<tbody>
						<logic:present name="testpublishlist" scope="request">
                            <logic:iterate name="testpublishlist" id="nl" type="java.util.Map" indexId="i" length="1">     
                            <input name="bmTestPublish.id" type="hidden" value="<bean:write name="nl" property="id"/>">					
							<tr align="center" valign="middle">							
								<td height="24" width="10%" align="left" valign="middle" class="tableHeader2">
									标题
								</td>
								<td align="left" valign="middle" class="tableHeader3" colspan="3">
									<input name="bmTestPublish.title" style="height:18px; width:480px; border:#000000 solid 1px; margin:0px; padding:0px; FONT-SIZE:12px" maxlength="60" value="<bean:write name="nl" property="title"/>">								    
								</td>
							</tr>
							<tr align="center" valign="middle">							
								<td width="10%" align="left" valign="middle" class="tableHeader2">
									是否显示
								</td>
								<td align="left" valign="middle" class="tableHeader3" >
								<c:if test="${nl.ifDisplay == '1'}">			
				                    <input name="bmTestPublish.ifDisplay" type="radio" value="1" checked>显示&nbsp;
								    <input name="bmTestPublish.ifDisplay" type="radio" value="0" >不显示
		                        </c:if>
								<c:if test="${nl.ifDisplay == '0'}">			
				                    <input name="bmTestPublish.ifDisplay" type="radio" value="1" >显示&nbsp;
								    <input name="bmTestPublish.ifDisplay" type="radio" value="0" checked>不显示
		                        </c:if>																    
								</td>
								<td width="10%" align="left" valign="middle" class="tableHeader2">
									是否公开
								</td>
								<td align="left" valign="middle" class="tableHeader3" >
								<c:if test="${nl.ifPublic == '1'}">
									<input name="bmTestPublish.ifPublic" type="radio" value="1" checked>公开&nbsp;
									<input name="bmTestPublish.ifPublic" type="radio" value="0" >不公开
							    </c:if>	
							    <c:if test="${nl.ifPublic == '0'}">
									<input name="bmTestPublish.ifPublic" type="radio" value="1" >公开&nbsp;
									<input name="bmTestPublish.ifPublic" type="radio" value="0" checked>不公开
							    </c:if>															    
								</td>								
							</tr>
							<tr align="center" valign="middle">	
							    <td width="10%" align="left" valign="middle" class="tableHeader2">
									内容
								</td>
								<td align="left" valign="middle" class="tableHeader3" colspan="3">
									<textarea name="bmTestPublish.body" style="width:1px;height:1px;" onfocus="editor.HtmlEdit.focus();"><bean:write name="nl" property="body"/></textarea>
									<iframe ID="editor" src="editor.do" frameborder="0" scrolling="no" width="100%" height="405"></iframe>																	    
								</td>
							</tr>
							<input type="hidden" name="bmTestPublish.creator" value="<bean:write name="nl" property="creator"/>">
                            <input type="hidden" name="bmTestPublish.createTime" value="<bean:write name="nl" property="createTime"/>">
							</logic:iterate>
                        </logic:present>	
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td height="40" align="right" valign="middle">
					<input name="Submit" type="button" class="button_nor" value="保 存" onClick="DoCheck()">
					&nbsp;&nbsp;&nbsp;
                    <input name="cancel" type="submit" class="button_nor" value="取 消">
				</td>
			</tr>
		</table>
<logic:present name="msg" scope="request">
  <input name="hmsg" type="hidden" value="<bean:write name="msg" />"> 
  </logic:present>
  <logic:notPresent name="msg" scope="request">
  <input name="hmsg" type="hidden" value=""> 
</logic:notPresent>

<input type="hidden" name="pager.offset" value="<%=request.getParameter("pager.offset")%>"/>
<html:hidden property="search_title" />
</html:form>
</center>
</body>

<script language="JavaScript">

function init(){

    editor.HtmlEdit.document.body.innerHTML =document.forms[0].elements["bmTestPublish.body"].value;
    
    if(document.all.hmsg.value=='1')
        alert("保存失败！");
}

function DoCheck(){
 
   if(document.forms[0].elements["bmTestPublish.title"].value==''){
      alert("请输入标题！");  
      document.forms[0].elements["bmTestPublish.title"].focus();
      return; 
   }
   if (editor.EditMode.checked==true)
	  document.forms[0].elements["bmTestPublish.body"].value=editor.HtmlEdit.document.body.innerText;
  else
	  document.forms[0].elements["bmTestPublish.body"].value=editor.HtmlEdit.document.body.innerHTML;  
      
  document.testPublishForm.action="testPublishAction.do?method=update";
  document.testPublishForm.submit();     
}

</script>
