/**
 * 
 */
package com.kingstargroup.ecard.portlet.news.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kingstargroup.ecard.exceptions.PortalException;
import com.kingstargroup.ecard.portlet.information.service.EcardInformationServiceUtil;
import com.kingstargroup.ecard.util.EcardConstants;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.struts.ActionConstants;
import com.liferay.portal.struts.PortletAction;
/**
 * Copyright (C), 2000-2005, Kingstar Co., Ltd.<br>
 * File name: SearchNewsAction.java<br>
 * Description: <br>
 * Modify History: <br>
 * 操作类型   操作人   操作时间     操作内容<br>
 * ===================================<br>
 *  创建    Xiao Qi  2005-9-21  <br>
 * @author Xiao Qi
 * @version 
 * @since 1.0
 */
public class SearchNewsAction extends PortletAction {
	/* (non-Javadoc)
	 * @see org.apache.struts.action.Action#execute(org.apache.struts.action.ActionMapping, org.apache.struts.action.ActionForm, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public ActionForward execute(
			ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res)
		throws Exception {
		String title = req.getParameter("search_title");
		String content = req.getParameter("search_content");		
		int page = ParamUtil.get(req, "page", 0);		
		try {
			if (mapping.getAttribute() != null) {
				if ("request".equals(mapping.getScope())) {					
					req.setAttribute(mapping.getAttribute(), form);					
				} else {
					req.getSession().setAttribute(mapping.getAttribute(), form);
				}
			}
			req.setAttribute("result", EcardInformationServiceUtil.search(title, content, EcardConstants.INFORMATION_NEWS_TYPE, page,EcardConstants.LIST_MORE_SIZE));
			return mapping.findForward("portlet.ecardnews.search_result");
		} catch (PortalException pe) {
			req.setAttribute(PageContext.EXCEPTION, pe);
			return mapping.findForward(ActionConstants.COMMON_ERROR);
		}
	}
}
