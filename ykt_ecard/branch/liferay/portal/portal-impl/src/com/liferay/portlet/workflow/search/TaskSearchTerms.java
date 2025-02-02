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

package com.liferay.portlet.workflow.search;

import com.liferay.portal.kernel.dao.DAOParamUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;

import javax.portlet.RenderRequest;

/**
 * <a href="TaskSearchTerms.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class TaskSearchTerms extends TaskDisplayTerms {

	public TaskSearchTerms(RenderRequest req) {
		super(req);

		instanceId = ParamUtil.getLong(req, INSTANCE_ID);
		taskName = DAOParamUtil.getLike(req, TASK_NAME, StringPool.PERCENT);
		definitionName = DAOParamUtil.getLike(
			req, DEFINITION_NAME, StringPool.PERCENT);
		assignedTo = ParamUtil.getString(req, ASSIGNED_TO);
		createDateGT = DAOParamUtil.getISODate(req, CREATE_DATE_GT);
		createDateLT = DAOParamUtil.getISODate(req, CREATE_DATE_LT);
		startDateGT = DAOParamUtil.getISODate(req, START_DATE_GT);
		startDateLT = DAOParamUtil.getISODate(req, START_DATE_LT);
		endDateGT = DAOParamUtil.getISODate(req, END_DATE_GT);
		endDateLT = DAOParamUtil.getISODate(req, END_DATE_LT);
		hideEndedTasks = ParamUtil.getBoolean(req, HIDE_ENDED_TASKS);
	}

}