<%@page pageEncoding="GBK"%>

<%@ include file = "../tiles/include.jsp"%>

<center>

<html:form action = "ygstufeeinfoAction.do?method=stuview">
<html:errors/>
<br>

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">

    <tr> 
      <td height="30" align="center" valign="middle" class="tdborder02"><strong><font class="medium">缴费信息</font></strong></td>
    </tr>
     <tr> 
    <td align="center" valign="top" >&nbsp;</td>
  </tr>
    
    <tr> 
      <td height="20" align="center" valign="middle" class="medium">&nbsp;</td>
    </tr>
    <tr> 
    <logic:present name="stuinfolist"  scope="request">
      <td height="40" align="center" valign="top"><input name="updateid" type="hidden" value="">
      <logic:iterate name="stuinfolist" id="sl" type="java.util.Map">
      <table 
        width=80% border=1 align=center 
      cellpadding=1 cellspacing=0 bordercolor=#AA817F bordercolordark=#ffffff      id=submenu1>
          <tbody>
            <tr align="center" valign=center> 
              <td width="15%" height="24" valign="middle" class="tableHeader5" ><bean:message bundle="checkinmanage" key="checkin.studentNo"/></td>
              <td width="35%" align="left" valign="middle" bgcolor="#FFFFFF" colspan="2"><bean:write name="sl" property="studentNo"/></td>
              <td width="15%" height="24" valign="middle" class="tableHeader5" ><bean:message bundle="checkinmanage" key="checkin.enrollNo"/></td>
              <td width="35%" align="left" valign="middle" bgcolor="#FFFFFF" ><bean:write name="sl" property="enrollNo"/>&nbsp;</td>
            </tr>
            <tr align="center" valign=center bgcolor="#F6F4F5"> 
              <td height="24" valign="middle" class="tableHeader5" ><bean:message bundle="checkinmanage" key="checkin.stuName"/></td>
              <td align="left" valign="middle" bgcolor="#F6F4F5" colspan="2"><bean:write name="sl" property="stuName"/></td>
              <td valign="middle" class="tableHeader5" ><bean:message bundle="checkinmanage" key="checkin.gender"/></td>
              <td align="left" valign="middle" bgcolor="#F6F4F5" >
              <c:choose><c:when test="${sl.gender == '1'}"><bean:message bundle="checkinmanage" key="checkin.male"/>
              </c:when></c:choose>
              <c:choose><c:when test="${sl.gender == '2'}"><bean:message bundle="checkinmanage" key="checkin.female"/>
              </c:when></c:choose>
              </td>
            </tr>
            <tr align="center" valign=center> 
              <td height="24" valign="middle" class="tableHeader5" style="display:none"><bean:message bundle="checkinmanage" key="checkin.majorin"/></td>
              <td align="left" valign="middle" bgcolor="#FFFFFF" colspan="2" style="display:none">
              <logic:present name="majorinlist" scope="request">            
               <logic:iterate name="majorinlist" id="ml" type="java.util.Map">
                <c:choose><c:when test="${ml.dictValue == sl.majorin}">              
                <bean:write name="ml" property="dictCaption"/>
                </c:when></c:choose>
               </logic:iterate>
               </logic:present>
              &nbsp;
              </td>
              <td valign="middle" class="tableHeader5" ><bean:message bundle="checkinmanage" key="checkin.classNo"/></td>
              <td align="left" valign="middle" bgcolor="#FFFFFF" colspan="4" ><bean:write name="sl" property="classNo"/></td>
            </tr>
            </logic:iterate>
            </logic:present>
            
            <tr align="center" valign=center>               
              <td colspan="5" align="left" valign="middle" bgcolor="#FFFFFF" >&nbsp;</td>
            </tr>
            
          <logic:present name="tuitionlist"  scope="request">
          <logic:iterate name="tuitionlist" id="tl" type="java.util.Map">
          <tr align="center" valign=center> 
            <td width="15%" height="30" rowspan="2" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2" >学费</td>
            <td width=15% height="24" align="right" valign="middle" class="tableHeader2" >应交</td>
            <td width=20% align="left" valign="middle" class="tableHeader3" colspan="3"><bean:write name="tl" property="shouldPay"/></td>
          </tr>          
          <tr align="center" valign=center> 
            <td width=15% height="24" align="right" valign="middle" class="tableHeader2" bgcolor="#F6F4F5"><font color="#FF0000">已交</font></td>
            <td align="left" valign="middle" class="tableHeader3" colspan="3" bgcolor="#F6F4F5"><bean:write name="tl" property="exactPay"/></td>
          </tr>
          </logic:iterate>
          </logic:present>
          
          <logic:present name="dormfeelist"  scope="request">
          <logic:iterate name="dormfeelist" id="dl" type="java.util.Map">
          <tr align="center" valign=center> 
            <td width=15% height="30" rowspan="2" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2" >住宿费</td>
            <td width=15% height="24" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2" >应交</td>
            <td align="left" valign="middle" class="tableHeader3" colspan="3"><bean:write name="dl" property="shouldPay"/></td>
          </tr>
          <tr align="center" valign=center> 
            <td height="24" align="right" valign="middle" class="tableHeader2" bgcolor="#F6F4F5"><font color="#FF0000">已交</font></td>
            <td align="left" valign="middle" class="tableHeader3" colspan="3" bgcolor="#F6F4F5"><bean:write name="dl" property="exactPay"/></td>
          </tr>
          </logic:iterate>
          </logic:present>
          
          <logic:present name="bookfeelist"  scope="request">
          <logic:iterate name="bookfeelist" id="bl" type="java.util.Map">
          <tr align="center" valign=center> 
            <td rowspan="2" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2" >预扣书费</td>
            <td width="10%" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2" >应交</td>
            <td height="24" align="left" valign="middle" class="tableHeader3" colspan="3"><bean:write name="bl" property="shouldPay"/></td>
          </tr>
          <tr align="center" valign=center> 
            <td height="24" align="right" valign="middle" class="tableHeader2" bgcolor="#F6F4F5"><font color="#FF0000">已交</font></td>
            <td height="24" align="left" valign="middle" class="tableHeader3" colspan="3" bgcolor="#F6F4F5"><bean:write name="bl" property="exactPay"/></td>
          </tr>
          </logic:iterate>
         </logic:present>           
          </tbody>
        </table>        
       </td>
    </tr>
    <tr>     
       
    <logic:notPresent name="tuitionlist"  scope="request">
     <font size="2.5" color="#990000">暂无该生的学费信息！</font>
    </logic:notPresent>
    <logic:notPresent name="bookfeelist"  scope="request">
     <font size="2.5" color="#990000">暂无该生的书籍费信息！</font>
    </logic:notPresent>
    <logic:notPresent name="dormfeelist"  scope="request">
     <font size="2.5" color="#990000">暂无该生的住宿费信息！</font>
    </logic:notPresent>
    
    <td height="40" align="right" valign="middle"> 
      <input name="Submit" type="button" class="button_nor" value="返 回" onClick="Goback()"> 
    </td>
    </tr>

</table>

</html:form>
</center>

<script language="JavaScript">
function Goback(){
  history.go(-1);
}
</script>