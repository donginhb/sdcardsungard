<%@ include file="/html/extportlet/ecard/cardtransaction/init.jsp"%>
<table width="719" height="29"  border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td ><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="2%">&nbsp;</td>
          <td width="72%" class="text_blue_12_c"></td>
          <td width="11%" valign="bottom">&nbsp;</td>
          <td width="15%" align="right" valign="middle" nowrap class="text_brown">&nbsp;</td>
        </tr>
      </table></td>
    </tr>
  </table>
    <table width="100"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="5"></td>
      </tr>
    </table>
    <table width="719"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" height="7"></td>
        <td height="7" ></td>
        <td width="6" height="7"></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td valign="top" align=center >
        <!-- content table -->
			<html:form action="/ext/ecardtransactionadd_picdelay_result" method="POST" onsubmit="javascript:submitPortletForm(this); return false;">
       
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
        	
          <tr>            
            <td width="20%" align=center valign="baseline" class="text_or_12"><bean:message key="ecardtransaction.picdelay.oldStuempNo" />: 
              </td>
            <td width="50%" valign="baseline" class="text_or_12">
            <html:text property="oldStuempNo" size="40" /></td>
            <td width="30%" align=left><font style="font-size: 11;"><html:errors
							property="oldStuempNo" />
							</font></td>
          </tr>
        </table>          
          
			<table width="100%" height="1"  border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td bgcolor="#e1e1e2"></td>
            </tr>
          </table>
          <table width="100%" height="5"  border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td></td>
            </tr>
          </table>
          <table width="99%" height="35"  border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td align="center">
				<html:submit styleClass="button_blank" property="save"
								value='<%=LanguageUtil.get(pageContext,"ecardtransaction.button.apply")%>' onclick="javascript:confirmPicdelay();"/>
				<html:button property="reset" styleClass="button_blank"	value='<%= LanguageUtil.get(pageContext, "ecard.reset") %>' />
				</td>
            </tr>
          </table>
          </html:form>
          <!-- content table --></td>
        <td >&nbsp;</td>
      </tr>
      <tr>
        <td width="9" height="7"></td>
        <td height="7" ></td>
        <td width="6" height="7"></td>
      </tr>
    </table>
    <script>
    	function confirmPicdelay() {
    		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "ecard.picdelay.confirm.start") %>' + 
    			document.PicDelayInputForm.oldStuempNo.value +
    			'<%= UnicodeLanguageUtil.get(pageContext, "ecard.picdealy.confirm.end") %>')) {  submitPortletForm(document.PicDelayInputForm); }
    	}
    </script>