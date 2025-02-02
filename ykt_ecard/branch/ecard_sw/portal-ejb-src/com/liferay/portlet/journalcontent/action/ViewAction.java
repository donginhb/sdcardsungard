/**
 * Copyright (c) 2000-2005 Liferay, LLC. All rights reserved.
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

package com.liferay.portlet.journalcontent.action;

import com.liferay.portal.language.LanguageUtil;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.Constants;
import com.liferay.portal.util.WebKeys;
import com.liferay.portlet.journal.NoSuchArticleException;
import com.liferay.portlet.journalcontent.util.JournalContentUtil;
import com.liferay.util.GetterUtil;
import com.liferay.util.StringPool;
import com.liferay.util.Validator;

import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import javax.servlet.jsp.PageContext;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * <a href="ViewAction.java.html"><b><i>View Source</i></b></a>
 *
 * @author  Brian Wing Shun Chan
 * @version $Revision: 1.5 $
 *
 */
public class ViewAction extends PortletAction {

	public ActionForward render(
			ActionMapping mapping, ActionForm form, PortletConfig config,
			RenderRequest req, RenderResponse res)
		throws Exception {

		try {
			PortletPreferences prefs = req.getPreferences();

			String portletTitle = prefs.getValue(
				"portlet-title", StringPool.BLANK);
			boolean showPortletBorders = GetterUtil.getBoolean(prefs.getValue(
				"show-portlet-borders", "true"));

			if (Validator.isNotNull(portletTitle)) {
				res.setTitle(portletTitle);
			}

			String articleId = prefs.getValue("article-id", StringPool.BLANK);
			String languageId = LanguageUtil.getLanguageId(req);
			String rootPath = (String)req.getAttribute(WebKeys.ROOT_PATH);

			String content = JournalContentUtil.getContent(
				articleId, languageId, rootPath);

			if (Validator.isNull(content)) {
				throw new NoSuchArticleException();
			}

			req.setAttribute(WebKeys.JOURNAL_ARTICLE_CONTENT, content);

			if (showPortletBorders) {
				return mapping.findForward("portlet.journal_content.view_1");
			}
			else {
				return mapping.findForward("portlet.journal_content.view_2");
			}
		}
		catch (Exception e) {
			if (e != null &&
				e instanceof NoSuchArticleException) {

				return mapping.findForward("/portal/portlet_not_setup");
			}
			else {
				req.setAttribute(PageContext.EXCEPTION, e);

				return mapping.findForward(Constants.COMMON_ERROR);
			}
		}
	}

}