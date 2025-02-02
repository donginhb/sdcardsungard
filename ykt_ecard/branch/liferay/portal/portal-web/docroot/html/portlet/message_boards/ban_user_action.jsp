<%
/**
 * Copyright (c) 2000-2008 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/portlet/message_boards/init.jsp" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

MBBan ban = (MBBan)row.getObject();
%>

<liferay-ui:icon-menu>
	<c:if test="<%= PortletPermissionUtil.contains(permissionChecker, plid.longValue(), PortletKeys.MESSAGE_BOARDS, ActionKeys.BAN_USER) %>">
		<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="unbanUserURL">
			<portlet:param name="struts_action" value="/message_boards/ban_user" />
			<portlet:param name="<%= Constants.CMD %>" value="unban" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="banUserId" value="<%= String.valueOf(ban.getBanUserId()) %>" />
		</portlet:actionURL>

		<liferay-ui:icon
			image="../message_boards/unban_user"
			message="unban-this-user"
			url="<%= unbanUserURL %>"
		/>
	</c:if>
</liferay-ui:icon-menu>