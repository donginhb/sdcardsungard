<%@page pageEncoding="GBK"%>
<%@ include file = "../tiles/include.jsp"%>

<center>

<html:form action = "dictionaryAction.do?method=findlocationList">

<br>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="30" align="center" valign="middle" class="tdborder02"><strong><font class="medium">区域字典维护</font></strong></td>
  </tr>
  <tr> 
    <td align="center" valign="top" >&nbsp;</td>
  </tr>
  <logic:notPresent name="dictlist" scope="request">
  <font size="2.5" color="#990000">当前没有可维护的区域。</font>
  </logic:notPresent>  
  <tr> 
    <td align="center" valign="top" ><table 
        width=100% border=1 align=center 
      cellpadding=1 cellspacing=0 bordercolor=#FFFFFF       id=submenu1>
          <tbody>
            <tr align="center" valign="middle">               
              <td width="15%" align="left" valign="middle" class="tableHeader2" >校区名称</td>
              <td width="70%" align="left" valign="middle" class="tableHeader3" colspan="2">
              <html:select property="search_area" styleClass="select01">
				<html:option value="" >请选择</html:option>
				<logic:present name="arealist" scope="request">
				    <html:options collection="arealist" labelProperty="dictCaption" property="dictValue" />
                </logic:present>									
			  </html:select>
			  </td>
			  <td width="15%" align="left" valign="middle" class="tableHeader3" >
              <input name="Submit" type="button" class="button_nor" value="查 询" onClick="DoFind()">&nbsp;
              <input name="Reset" type="button" class="button_nor" value="重 置" onClick="DoClear()"> </td>             
             </tr>                    
          </tbody>
        </table></td>
  </tr>
  <tr> 
    <td align="right" valign="middle">&nbsp;</td>
  </tr>
  <tr> 
      <td align="left" valign="top">
      <table width=100% border=1 align=center 
      cellpadding=1 cellspacing=0 bordercolor=#AA817F bordercolordark=#ffffff      id=submenu1>
          <tbody>
           <logic:present name="dictlist" scope="request">
           <thead>
           <tr align="center" valign="middle">
              <td align="center" valign="middle" class="tableHeader" >校区名称</td>
              <td align="center" valign="middle" class="tableHeader" >区域代码</td>
              <td align="center" valign="middle" class="tableHeader" >区域名称</td>
              <td align="center" valign="middle" class="tableHeader" >排序编号</td>
              <td align="center" valign="middle" class="tableHeader" ><bean:message bundle="checkinmanage" key="checkin.saveondisk"/></td>
            </tr>             
           </thead>
           <%int j=0;%>
            <logic:iterate name="dictlist" id="cl" type="java.util.Map"  indexId="i">             
            <tr align="center" valign="middle" <%if(j%2!=0){%> bgcolor="#FFFFFF" <%}else{%> bgcolor="#F6F4F5" <%}%>>             
              <td height="24" align="center" valign="middle" ><bean:write name="cl" property="areaName"/></td>
              <td align="center" valign="middle" ><bean:write name="cl" property="dictValue"/></td>
              <td align="center" valign="middle"><input name="dictCaption<bean:write name="cl" property="dictValue"/>" value="<bean:write name="cl" property="dictCaption"/>" maxlength="10"></td> 
              <td align="center" valign="middle"><input name="dictSort<bean:write name="cl" property="dictValue"/>" value="<bean:write name="cl" property="dictSort"/>" maxlength="5"></td>              
              <td align="center" valign="middle">
                <input name="save" type="button" class="button_nor" value="<bean:message bundle="checkinmanage" key="checkin.save"/>" onClick="DoSaveUpdate('<bean:write name="cl" property="dictValue"/>')" >
              </td>     
            </tr>
            <%j = j + 1;%>            
            </logic:iterate>                 
            </logic:present>           
          </tbody>
        </table>
      </td>
  </tr>
  <logic:present name="dictlist">
    <tr> 
    <td height="40" align="left" valign="middle">
        <%int rowcount=((Integer)request.getAttribute("listcount")).intValue();%>        
        <font color="#000000" size="2.5">共<%=rowcount%>条记录</font>
    </td>
    </tr>  
  </logic:present>
  <tr> 
    <td height="40" align="left" valign="middle">
       <input name="dictionaryId.dictNo" type="hidden" value="20"><input name="dictionary.dictName" type="hidden" value="区域">
        校区名称：
        <select name="dictionary.dictParent" class="select01">
            <option value="" selected><bean:message bundle="checkinmanage" key="checkin.select"/></option>
            <logic:present name="arealist" scope="request">
            <logic:iterate name="arealist" id="al" type="java.util.Map">
              <option value="<bean:write name="al" property="dictValue"/>"><bean:write name="al" property="dictCaption"/></option>
            </logic:iterate>
            </logic:present>
       </select>&nbsp;&nbsp;
        区域代码：<input name="dictionaryId.dictValue" value="" maxlength="10">&nbsp;&nbsp;区域名称：<input name="dictionary.dictCaption" value="" maxlength="10">&nbsp;&nbsp;排序编号：<input name="dictionary.dictSort" value="" maxlength="5">&nbsp;&nbsp;
        <input name="savenew" type="button" class="button_nor" value="添加" onClick="DoSaveNew()" >
    </td>
  </tr>
</table>
  <logic:present name="msg" scope="request">
  <input name="hmsg" type="hidden" value="<bean:write name="msg" />"> 
  </logic:present>
  <logic:notPresent name="msg" scope="request">
  <input name="hmsg" type="hidden" value=""> 
  </logic:notPresent>
</html:form>
</center>

<script language="JavaScript">
function DoInit(){
  
  if(document.all.hmsg.value=='0')
      alert("保存成功!");
  else if(document.all.hmsg.value=='1')
      alert("保存失败!");
  else if(document.all.hmsg.value=='2')
      alert("代码重复，保存失败!");    
  else if(document.all.hmsg.value=='9')
      alert("请勿重复添加!");
}
window.onload=DoInit;
function DoSaveUpdate(str){
    if(eval("document.all.dictCaption"+str+".value==''")){
        alert("请输入区域名称！");
        eval("document.all.dictCaption"+str+".focus();");
        return;
    }
    if(eval("document.all.dictSort"+str+".value==''")){
        alert("请输入排序编号！");
        eval("document.all.dictSort"+str+".focus();");
        return;
    }
    if(isNaN(eval("document.all.dictSort"+str+".value"))){
        alert("排序编号必须是数字！");
        eval("document.all.dictSort"+str+".select();");
        eval("document.all.dictSort"+str+".focus();");
        return;
    }
    if(confirm("确定要修改吗？")){
        document.dictionaryForm.action="dictionaryAction.do?method=updateLocation&dictvalue="+str;
        document.dictionaryForm.submit();
    }
    else
        return;
}

function DoSaveNew(){
   if(document.dictionaryForm.elements["dictionary.dictParent"].value==''){
       alert("请选择该区域的校区！");
       return;
   }
   if(document.dictionaryForm.elements["dictionaryId.dictValue"].value==''){
       alert("请输入区域代码！");
       document.dictionaryForm.elements["dictionaryId.dictValue"].focus();
       return;   
   }
   if(document.dictionaryForm.elements["dictionary.dictCaption"].value==''){
       alert("请输入区域名称！");
       document.dictionaryForm.elements["dictionary.dictCaption"].focus();
       return;   
   }
   if(document.dictionaryForm.elements["dictionary.dictSort"].value==''){
        alert("请输入排序编号！");
        document.dictionaryForm.elements["dictionary.dictSort"].focus();
        return;
    }
    if(isNaN(document.dictionaryForm.elements["dictionary.dictSort"].value)){
        alert("排序编号必须是数字！");
        document.dictionaryForm.elements["dictionary.dictSort"].select();
        document.dictionaryForm.elements["dictionary.dictSort"].focus();
        return;
    }
   document.dictionaryForm.action="dictionaryAction.do?method=saveLocation";
   document.dictionaryForm.submit();
  
}

function DoFind(){
   
   document.dictionaryForm.action="dictionaryAction.do?method=findlocationList";
   document.dictionaryForm.submit();
   
}

function DoClear(){
     
     document.forms[0].elements["search_area"].value="";
     
}
</script>