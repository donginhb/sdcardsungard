<%if(!PermissionUtil.hasCardTransactionAdmin(request) || 
	!PermissionUtil.hasDelayProcess(request) ) {%>
	<font class="portlet-msg-error" style="font-size: 13;">
	<bean:message key="ecard.error.visitpageunlegal" />
	</font>
<%return;}%>