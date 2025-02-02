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

package com.liferay.portlet.communities.action;

import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.model.Group;
import com.liferay.portal.model.MembershipRequest;
import com.liferay.portal.service.GroupLocalServiceUtil;
import com.liferay.portal.service.MembershipRequestLocalServiceUtil;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.WebKeys;

import javax.portlet.ActionRequest;
import javax.portlet.RenderRequest;

import javax.servlet.http.HttpServletRequest;

/**
 * <a href="ActionUtil.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class ActionUtil
	extends com.liferay.portlet.enterpriseadmin.action.ActionUtil {

	public static void getGroup(ActionRequest req) throws Exception {
		HttpServletRequest httpReq = PortalUtil.getHttpServletRequest(req);

		getGroup(httpReq);
	}

	public static void getGroup(RenderRequest req) throws Exception {
		HttpServletRequest httpReq = PortalUtil.getHttpServletRequest(req);

		getGroup(httpReq);
	}

	public static void getGroup(HttpServletRequest req) throws Exception {
		long groupId = ParamUtil.getLong(req, "groupId");

		Group group = null;

		if (groupId > 0) {
			group = GroupLocalServiceUtil.getGroup(groupId);
		}

		req.setAttribute(WebKeys.GROUP, group);
	}

	public static void getMembershipRequest(ActionRequest req)
		throws Exception {

		HttpServletRequest httpReq = PortalUtil.getHttpServletRequest(req);

		getMembershipRequest(httpReq);
	}

	public static void getMembershipRequest(RenderRequest req)
		throws Exception {

		HttpServletRequest httpReq = PortalUtil.getHttpServletRequest(req);

		getMembershipRequest(httpReq);
	}

	public static void getMembershipRequest(HttpServletRequest req)
		throws Exception {

		long membershipRequestId =
			ParamUtil.getLong(req, "membershipRequestId");

		MembershipRequest membershipRequest = null;

		if (membershipRequestId > 0) {
			membershipRequest =
				MembershipRequestLocalServiceUtil.getMembershipRequest(
					membershipRequestId);
		}

		req.setAttribute(WebKeys.MEMBERSHIP_REQUEST, membershipRequest);
	}

}