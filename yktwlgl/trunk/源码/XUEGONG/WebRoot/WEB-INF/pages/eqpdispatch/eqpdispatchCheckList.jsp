<%@page pageEncoding="GBK"%>
<%@ include file="../tiles/include.jsp"%>
<%@ include file="/pages/common/messages.jsp"%>
<%@ include file="/pages/common/meta.jsp"%>
<html>
	<head>
		<title>上海复旦大学物料库存及仓储管理系统</title>

		<%@ include file="/pages/components/calendar/calendar.jsp"%>
		<link href="<c:url value="/pages/styles/style.css"/>" type="text/css" rel=stylesheet>
		<link href="<c:url value="/pages/styles/extremecomponents.css"/>" type="text/css" rel=stylesheet>
		<script src="<c:url value="/pages/scripts/admin.js"/>" type="text/javascript"></script>
		<script src="<c:url value="/pages/scripts/util.js"/>" type="text/javascript"></script>

	</head>
	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
		<br>
		<html:form action="/gyf/eqpdispatchAction.do?method=search4CheckList" method="post">

			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td align="left" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="25" align="left" valign="top">
									<table width="170" height="20" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="10" bgcolor="#0066CA">
												&nbsp;
											</td>
											<td bgcolor="#0066CA" class="mediumwhite">
												派发申请审核
											</td>
											<td width="27"><img src="<c:url value="/pages/style/default/images/tabletitle.jpg" />" width="27" height="20"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="40" align="center" valign="top">
									<table width=100% border=1 align=center cellpadding=1 cellspacing=0 bordercolor=#FFFFFF id=submenu1>
										<tbody>
											<tr align="center" valign=center>
												<td width="15%" height="26" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2">
													设备编号
												</td>
												<td width="20%" align="left" valign="middle" class="tableHeader3">
													<html:text property="search_bh" styleClass="input_box" maxlength="32" />
												</td>
												<td width="20%" lign="left" valign="middle" class="tableHeader2">
													设备资产号
												</td>
												<td width="20%" align="left" valign="middle" class="tableHeader3">
													<html:text property="search_zch" styleClass="input_box" maxlength="50" />
												</td>
												<td width="15%" align="left" valign="middle" class="tableHeader2">
													设备序列号
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<html:text property="search_xlh" styleClass="input_box" maxlength="50" />
												</td>
											</tr>
											<tr align="center" valign=center>
												<td height="26" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2">
													所处校区
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<html:select property="search_xq" styleClass="select01" onchange="changeOBd(this)">
														<html:option value="">请选择</html:option>
														<html:options collection="arealist" labelProperty="dictCaption" property="dictValue" />
													</html:select>
												</td>
												<td align="left" valign="middle" class="tableHeader2">
													所在楼宇
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<html:select property="search_louyu" styleClass="select01">
														<html:option value="">请选择</html:option>
														<html:options collection="buildinglist" labelProperty="lymc" property="id" />
													</html:select>
												</td>
												<td height="26" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2">
													所在房间
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<html:text property="search_jfkf" styleClass="input_box" maxlength="50" />
												</td>
											</tr>
											<tr align="center" valign=center>
												<td height="26" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2">
													机柜编号
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<html:text property="search_jgbh" styleClass="input_box" maxlength="50" />
												</td>
												<td align="left" valign="middle" class="tableHeader2">
													起始位置
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<html:text property="search_blocation" styleClass="input_box" maxlength="10" />
												</td>
												<td height="26" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2">
													终止位置
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<html:text property="search_elocation" styleClass="input_box" maxlength="10" />
												</td>
											</tr>
											<tr align="center" valign=center>
												<td height="26" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2">
													申请人
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<html:text property="search_sqr" styleClass="input_box" maxlength="50" />
												</td>
												<td height="26" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2">
													申请日期从
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="130">
																<html:text property="search_sqrqc" styleClass="input_box" maxlength="50" readonly="true" />
															</td>
															<td>
																<img id="select_sqrqc" src="<c:url value="/pages/components/calendar/skins/aqua/cal.gif"/>" border="0" alt="开始日期" style="cursor:pointer">
															</td>
														</tr>
													</table>
												</td>
												<td align="right" valign="middle" class="tableHeader2">
													申请日期到
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="130">
																<html:text property="search_sqrqd" styleClass="input_box" maxlength="50" readonly="true" />
															</td>
															<td>
																<img id="select_sqrqd" src="<c:url value="/pages/components/calendar/skins/aqua/cal.gif"/>" border="0" alt="结束日期" style="cursor:pointer">
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<script type="text/javascript">
                new calendar("search_sqrqc", "select_sqrqc", "%Y-%m-%d");
                new calendar("search_sqrqd", "select_sqrqd", "%Y-%m-%d");
           </script>
											<tr align="center" valign=center>
												<td height="26" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2">
													派发审核状态
												</td>
												<td align="left" valign="middle" class="tableHeader3">
													<html:select property="search_shzt" styleClass="select01">
														<html:option value="">请选择</html:option>
														<html:options collection="shztlist" labelProperty="ztName" property="ztCode" />
													</html:select>
												</td>
												<td align="left" valign="middle" class="tableHeader2">
													派发申请名称
												</td>
												<td align="left" valign="middle" class="tableHeader3" colspan="3">
													<html:select property="search_applyname" styleClass="select01">
														<html:option value="">请选择</html:option>
														<html:options collection="appNamelist" labelProperty="applyName" property="applyName" />
													</html:select>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<td height="40" align="right" valign="middle" class="tdborder02">
									<input name="Submit" type="submit" class="button_nor" value="查 询">
									&nbsp;
									<input name="Submit2" type="button" class="button_nor" value="重 置" onclick="DoClear()">
								</td>

							</tr>
							<logic:present name="msg" scope="request">
								<input name="hmsg" type="hidden" value="<bean:write name="msg" />">
							</logic:present>
							<logic:notPresent name="msg" scope="request">
								<input name="hmsg" type="hidden" value="">
							</logic:notPresent>
							<logic:present name="nccols" scope="request">
								<input name="hnccols" type="hidden" value="<bean:write name="nccols" />">
							</logic:present>
							<logic:notPresent name="nccols" scope="request">
								<input name="hnccols" type="hidden" value="">
							</logic:notPresent>
							<logic:present name="ncupdate" scope="request">
								<input name="hncupdate" type="hidden" value="<bean:write name="ncupdate" />">
							</logic:present>
							<logic:notPresent name="ncupdate" scope="request">
								<input name="hncupdate" type="hidden" value="">
							</logic:notPresent>
							<logic:present name="nsameloc" scope="request">
								<input name="hnsameloc" type="hidden" value="<bean:write name="nsameloc" />">
							</logic:present>
							<logic:notPresent name="nsameloc" scope="request">
								<input name="hnsameloc" type="hidden" value="">
							</logic:notPresent>
							<logic:present name="nmHeight" scope="request">
								<input name="hnmHeight" type="hidden" value="<bean:write name="nmHeight" />">
							</logic:present>
							<logic:notPresent name="nmHeight" scope="request">
								<input name="hnmHeight" type="hidden" value="">
							</logic:notPresent>
							<logic:present name="nmRoom" scope="request">
								<input name="hnmRoom" type="hidden" value="<bean:write name="nmRoom" />">
							</logic:present>
							<logic:notPresent name="nmRoom" scope="request">
								<input name="hnmRoom" type="hidden" value="">
							</logic:notPresent>
							<input name="checkMemo" type="hidden" value="" title="审批备注" maxLength="300">
							</html:form>

							<tr>
								<td height="35" align="center" valign="middle" class="mediumblack">
									设备派发申请列表
								</td>
							</tr>
							<jodd:form bean="request">
								<tr>
									<td height="20" align="center" valign="middle">
										<ec:table items="dispatchchecklist" var="eqpJBInfo" autoIncludeParameters="false" rowsDisplayed="10" action="eqpdispatchAction.do?method=search4CheckList">

											<ec:parameter name="search_bh" />
											<ec:parameter name="search_zch" />
											<ec:parameter name="search_xlh" />
											<ec:parameter name="search_xq" />
											<ec:parameter name="search_louyu" />
											<ec:parameter name="search_jfkf" />
											<ec:parameter name="search_jgbh" />
											<ec:parameter name="search_blocation" />
											<ec:parameter name="search_elocation" />
											<ec:parameter name="search_sqr" />
											<ec:parameter name="search_sqrqc" />
											<ec:parameter name="search_sqrqd" />
											<ec:parameter name="search_applyname" />
											<ec:parameter name="search_shzt" />

											<ec:exportXls fileName="eqpdispatchApplyList.xls" tooltip="导出 Excel" />
											<ec:row>
												<ec:column property="checkbox" title="选择" sortable="false" viewsAllowed="html" width="30" headerStyle="text-align:center" style="text-align: left">
													<input type="checkbox" name="cbgroup" value="${eqpJBInfo.xid}" style="border:0px" onClick="doSel(this)" />
												</ec:column>
																								<ec:column property="equipmentNo" title="查看" headerStyle="text-align:center" style="text-align: left" width="80">
													<c:choose>
													<c:when test="${eqpJBInfo.applyStateName=='等待'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')">查看</a>
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')">查看</a>
												</c:if>
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')"><font color="#000000">查看</font></a>
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')"><font color="#000000">查看</font></a>
												</c:if>	&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')"><font color="green">查看</font></a>
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')"><font color="green">查看</font></a>
												</c:if>	&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')"><font color="red">查看</font></a>
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')"><font color="red">查看</font></a>
												</c:if>	&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批中'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')"><font color="#000000">查看</font></a>
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												<a href="javascript:DoView('${eqpJBInfo.id}')"><font color="#000000">查看</font></a>
												</c:if>	&nbsp;
					</c:when>
					</c:choose>
																										
												</ec:column>	
												<ec:column property="assetNo" title="设备标识" headerStyle="text-align:center" style="text-align: left" width="80">
													<c:choose>
													<c:when test="${eqpJBInfo.applyStateName=='等待'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												${eqpJBInfo.equipmentNo}
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												${eqpJBInfo.assetNo}
												</c:if>
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												<font color="#000000">${eqpJBInfo.equipmentNo}</font>
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												<font color="#000000">${eqpJBInfo.assetNo}</font>
												</c:if>	&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												<font color="green">${eqpJBInfo.equipmentNo}</font>
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												<font color="green">${eqpJBInfo.assetNo}</font>
												</c:if>	&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												<font color="red">${eqpJBInfo.equipmentNo}</font>
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												<font color="red">${eqpJBInfo.assetNo}</font>
												</c:if>	&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批中'}">
							<c:if test="${eqpJBInfo.assetNo==null||eqpJBInfo.assetNo==''}">
												<font color="#000000">${eqpJBInfo.equipmentNo}</font>
												</c:if>
												<c:if test="${eqpJBInfo.assetNo!=null&&eqpJBInfo.assetNo!=''}">
												<font color="#000000">${eqpJBInfo.assetNo}</font>
												</c:if>	&nbsp;
					</c:when>
					</c:choose>
																										
												</ec:column>												
												<ec:column property="managerName" title="管理员" headerStyle="text-align:center" style="text-align: left" width="50" >
																		<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.managerName}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.managerName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.managerName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.managerName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.managerName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>
												
												<ec:column property="applyName" title="派发申请" headerStyle="text-align:center" style="text-align: left" width="80" >
													<c:choose>
												<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.applyName}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.applyName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.applyName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.applyName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.applyName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>
												<ec:column property="collegeArea" title="校区" headerStyle="text-align:center" style="text-align: left" width="60" >
																			<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.collegeArea}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.collegeArea}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.collegeArea}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.collegeArea}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.collegeArea}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>
												<ec:column property="lymc" title="楼宇" headerStyle="text-align:center" style="text-align: left" width="50" >
											<c:choose>		
													<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.lymc}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.lymc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.lymc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.lymc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.lymc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>
												<ec:column property="roommc" title="房间" headerStyle="text-align:center" style="text-align: left" width="60" >
																			<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.roommc}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.roommc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.roommc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.roommc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.roommc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>
												<ec:column property="cabinetmc" title="柜号" headerStyle="text-align:center" style="text-align: left" width="40" >
																			<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.cabinetmc}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.cabinetmc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.cabinetmc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.cabinetmc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.cabinetmc}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>
												<ec:column property="BLocation" title="起U" headerStyle="text-align:center" style="text-align: left" width="40" >
													
					<c:choose>
													<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.BLocation}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.BLocation}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.BLocation}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.BLocation}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.BLocation}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>
												<ec:column property="ELocation" title="终U" headerStyle="text-align:center" style="text-align: left" width="40" >
																				<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.ELocation}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.ELocation}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.ELocation}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.ELocation}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.ELocation}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>
												<ec:column property="applyPersonName" title="申请人" headerStyle="text-align:center" style="text-align: left" width="50">
												<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.applyPersonName}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.applyPersonName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.applyPersonName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.applyPersonName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.applyPersonName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>
												<ec:column property="recordDate" title="申请日期"  headerStyle="text-align:center" style="text-align: left" width="70" >
																																					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							<bean:write name="eqpJBInfo" property="recordDate" format="yyyy-MM-dd"/>&nbsp;
					</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000"><bean:write name="eqpJBInfo" property="recordDate" format="yyyy-MM-dd"/></font>&nbsp;
					</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green"><bean:write name="eqpJBInfo" property="recordDate" format="yyyy-MM-dd"/></font>&nbsp;
					</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red"><bean:write name="eqpJBInfo" property="recordDate" format="yyyy-MM-dd"/></font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000"><bean:write name="eqpJBInfo" property="recordDate" format="yyyy-MM-dd"/></font>&nbsp;
					</c:when>
					</c:choose>
					</ec:column>
												<ec:column property="checkStateName" title="状态" headerStyle="text-align:center" style="text-align: left" width="50" >
																			<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='等待'}">
							${eqpJBInfo.checkStateName}&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='已提交'}">
							<font color="#000000">${eqpJBInfo.checkStateName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批通过'}">
							<font color="green">${eqpJBInfo.checkStateName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='审批不通过'}">
							<font color="red">${eqpJBInfo.checkStateName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					<c:choose>
						<c:when test="${eqpJBInfo.checkStateName=='待审核'}">
							<font color="#000000">${eqpJBInfo.checkStateName}</font>&nbsp;
					</c:when>
					</c:choose>
					
					</ec:column>												
											</ec:row>
										</ec:table>
									</td>
								</tr>
								<tr>
									<td height="40" align="left" valign="top">
										<table width=100% border=1 align=center cellpadding=1 cellspacing=0 bordercolor=#FFFFFF id=submenu1>
											<tbody>
												<tr align="center" valign=center>
													<td width="15%" height="26" align="right" valign="middle" bgcolor="#FFFFFF" class="tableHeader2">
														审核备注
													</td>
													<td align="left" valign="middle" class="tableHeader3">
														<textarea name="tcheckMemo" cols=80 rows=2 onchange="javascript:document.eqpdispatchForm.checkMemo.value=this.value;"></textarea>
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>

								<%if (((java.util.ArrayList) request
					.getAttribute("dispatchchecklist")).size() > 0) {%>
								<tr>
									<td height="40" align="left" valign="middle">
										<table width=100% border=1 align=center cellpadding=1 cellspacing=0 bordercolor=#FFFFFF id=submenu1>
											<tbody>
												<tr align="center" valign=center>
													<td height="40" align="left" valign="middle">
														<input name="selectall" type="button" class="button_nor" value="全 选" onClick="DoSelectall()">
														<input name="notselectall" type="button" class="button_nor" value="全不选" onClick="DoNotselectall()">
														<input name="reverseselect" type="button" class="button_nor" value="反 选" onClick="DoReverseselect()">
													</td>
													<td height="40" align="right" valign="middle">
														<input name="bupdate" type="button" class="button_nor" value="修 改" onClick="DoUpdate()">
														<input name="bcheckok" type="button" class="button_nor" value="通 过" onClick="DoCheck('20')">
														<input name="bchecknok" type="button" class="button_nor" value="不通过" onClick="DoCheck('21')">
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
								<%}%>
							</jodd:form>
						</table>
					</td>
				</tr>
			</table>
	</body>
</html>

<script>

    var datacount2=0;
    dataset2=new Array();
    
   <%
   int count2=0;
   String[][] resultset2=null;
   if(request.getAttribute("ablist")!=null)
       resultset2=(String[][])request.getAttribute("ablist");//读取校区、楼宇对应数据
   
   if(resultset2!=null){
     for(count2=0;count2<resultset2.length;count2++)
     {
     %>
      dataset2[<%=count2%>] = new Array("<%=resultset2[count2][0]%>","<%=resultset2[count2][1]%>","<%=resultset2[count2][2]%>");//产生javascript二维数组，对应楼宇id、楼宇名称、校区id
     <%
     }
   }
   %>
   datacount2=<%=count2%>;
   
</script>

<SCRIPT language=javascript>

setTimeout('init()',10);
function init(){
   
  var area=document.eqpdispatchForm.elements["search_xq"].value;
  var building=document.eqpdispatchForm.elements["search_louyu"].value;
  
  if(area!='')
      changeBd(document.eqpdispatchForm.elements["search_xq"]);
  for(var j=0;j<document.eqpdispatchForm.elements["search_louyu"].length;j++){
      if(document.eqpdispatchForm.elements["search_louyu"][j].value==building)
	     document.eqpdispatchForm.elements["search_louyu"][j].selected=true;
					
  }
  
  if(document.eqpdispatchForm.hmsg.value=='1')
       alert("审核成功！");  
  else if(document.eqpdispatchForm.hmsg.value=='7')
       alert("机柜起止位置差不能小于设备高度,保存失败！"); 
  else if(document.eqpdispatchForm.hmsg.value=='0')
       alert("审核失败！"); 
  else if(document.eqpdispatchForm.hmsg.value=='8')
       alert("派发申请在审核中或已审核通过，不能修改！");
  if(document.eqpdispatchForm.hnccols.value!='')
       alert(document.eqpdispatchForm.hnccols.value+" 派发申请已审核完毕，不能修改！");
  if(document.eqpdispatchForm.hncupdate.value!=''&&!isNaN(document.eqpdispatchForm.hncupdate.value)){
       alert("修改"+document.eqpdispatchForm.hncupdate.value+"条派发申请！若派发申请已审核通过，不能修改！");       
   }
   if(document.eqpdispatchForm.hnsameloc.value=='1')
       alert("已有其它设备放在该起始位置！");
   else if(document.eqpdispatchForm.hnsameloc.value!='')
       alert(document.eqpdispatchForm.hnsameloc.value+" 已有其它设备放在该起始位置！");
   
   if(document.eqpdispatchForm.hnmRoom.value=='1')
       alert("机柜所属房间与派发记录相关内容不符,请检查！");
   else if(document.eqpdispatchForm.hnmRoom.value!='')
       alert(document.eqpdispatchForm.hnmRoom.value+" 机柜所属房间与派发记录相关内容不符,请检查！");
       
   if(document.eqpdispatchForm.hnmHeight.value!='')
       alert(document.eqpdispatchForm.hnmHeight.value+" 机柜起止位置差不能小于设备高度,保存失败！");
}  

function changeBd(sel){

   var id;        
   var i;        

   id=sel.options[sel.selectedIndex].value;
        
   document.eqpdispatchForm.elements["search_louyu"].length=1; //清空原楼宇列表        
   
   if(id!="")
      for (i=0;i < datacount2; i++)
      {
         if (dataset2[i][2] == id)
          {   
             document.eqpdispatchForm.elements["search_louyu"].options[document.eqpdispatchForm.elements["search_louyu"].length]=new Option(dataset2[i][1], dataset2[i][0]);              
                
          }
      }
    else{
       for (i=0;i < datacount2; i++)
      {
          document.eqpdispatchForm.elements["search_louyu"].options[document.eqpdispatchForm.elements["search_louyu"].length]=new Option(dataset2[i][1], dataset2[i][0]);
        
      }
     
    }
   

}

function zchSetup(sel){

   alert(sel.value);

}
function doSel(sel){
//alert(sel.value);
}

function DoSelectall(){

  if(document.all.cbgroup!=null&&document.all.cbgroup.length>1){   
       for(var i=0;i<document.all.cbgroup.length;i++){
              document.all.cbgroup[i].checked=true;
       }
       
  }
  else if(document.all.cbgroup!=null){
       document.all.cbgroup.checked=true;       
  }
  else{
       alert("当前无记录！");
  }
  

}

function DoNotselectall(){
  
  if(document.all.cbgroup!=null&&document.all.cbgroup.length>1){   
       for(var i=0;i<document.all.cbgroup.length;i++){
              document.all.cbgroup[i].checked=false;
       }
       
  }
  else if(document.all.cbgroup!=null){
       document.all.cbgroup.checked=false;       
  }
  else{
       alert("当前无记录！");
  }

}

function DoReverseselect(){
   
   if(document.all.cbgroup!=null&&document.all.cbgroup.length>1){   
       for(var i=0;i<document.all.cbgroup.length;i++){
           if(document.all.cbgroup[i].checked)
              document.all.cbgroup[i].checked=false;
           else if(!document.all.cbgroup[i].checked)
              document.all.cbgroup[i].checked=true;
       }
       
  }
  else if(document.all.cbgroup!=null){
      if(document.all.cbgroup.checked)
          document.all.cbgroup.checked=false; 
      else if(!document.all.cbgroup.checked)
          document.all.cbgroup.checked=true;    
  }
  else{
       alert("当前无记录！");
  }
  

}

function DoUpdate(){
 
   var sflag=0;
   var ids="";
   
   if(document.all.cbgroup!=null&&document.all.cbgroup.length>1){
          for(var i=0;i<document.all.cbgroup.length;i++){
              if(document.all.cbgroup[i].checked){
                   sflag=sflag+1; 
                   ids=ids+document.all.cbgroup[i].value+",";                                                 
              }
          }           
         if(sflag==0){
              alert("请选择要修改的设备派发申请！");
              return;
          } 
   }
   else{
        if(document.all.cbgroup.checked){
              ids=ids+document.all.cbgroup.value+","; 
              sflag=sflag+1;     
        }
        else{
            alert("请选择要修改的设备派发申请！");
            return;   
        }            
   }
   
   eqpdispatchForm.action="eqpdispatchAction.do?method=load4Checkupdate&idset="+ids.substring(0,ids.length-1)+"&idcount="+sflag;       
   eqpdispatchForm.submit();
   
  
  
}

function DoCheck(str){

   var sflag=0;
   var ids="";
   
   if(document.all.cbgroup!=null&&document.all.cbgroup.length>1){
          for(var i=0;i<document.all.cbgroup.length;i++){
              if(document.all.cbgroup[i].checked){
                   sflag=sflag+1; 
                   ids=ids+document.all.cbgroup[i].value+",";                                                 
              }
          }           
         if(sflag==0){
              alert("请选择要审核的设备派发申请！");
              return;
          } 
   }
   else{
        if(document.all.cbgroup.checked){
              ids=ids+document.all.cbgroup.value+","; 
              sflag=sflag+1;     
        }
        else{
            alert("请选择要审核的设备派发申请！");
            return;   
        }            
   }
   //alert("eqpdispatchAction.do?method=check&idset="+ids.substring(0,ids.length-1)+"&idcount="+sflag+"&checkState="+str+"&checkMemo="+document.eqpdispatchForm.bcheckMemo.value);
   
if(doCheckForm(eqpdispatchForm)) {
   if(confirm("您确定要审核吗？")){
      // var checkmemo=document.eqpdispatchForm.bcheckMemo.value;
      //if(checkmemo.length%2!=0)
      //     checkmemo=checkmemo+"曰";
       eqpdispatchForm.action="eqpdispatchAction.do?method=check&checkState="+str+"&idset="+ids.substring(0,ids.length-1)+"&idcount="+sflag;       
       eqpdispatchForm.submit();
   }
   else
      return;
}
}

function DoView(eno){

    window.open("eqpdispatchAction.do?method=load4Applyview&applyId="+eno,"detailInfo","height=600,width=800,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=yes");
   
}

function DoViewDispatch(eno){

    window.open("eqpdispatchAction.do?method=load4view&dispatchId="+eno,"dispatchInfo","height=600,width=800,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=yes");
   
}

function DoClear(){

    document.eqpdispatchForm.elements["search_bh"].value="";
    document.eqpdispatchForm.elements["search_zch"].value="";    
    document.eqpdispatchForm.elements["search_xlh"].value="";
    
    document.eqpdispatchForm.elements["search_jfkf"].value="";
    document.eqpdispatchForm.elements["search_xq"].value="";
    document.eqpdispatchForm.elements["search_louyu"].value="";
    
    document.eqpdispatchForm.elements["search_jgbh"].value="";
    document.eqpdispatchForm.elements["search_blocation"].value="";
    document.eqpdispatchForm.elements["search_elocation"].value="";
    
    document.eqpdispatchForm.elements["search_applyname"].value="";   
    document.eqpdispatchForm.elements["search_shzt"].value="";
    
    document.eqpdispatchForm.elements["search_sqr"].value="";
    document.eqpdispatchForm.elements["search_sqrqc"].value="";
    document.eqpdispatchForm.elements["search_sqrqd"].value="";
            
}

</SCRIPT>

