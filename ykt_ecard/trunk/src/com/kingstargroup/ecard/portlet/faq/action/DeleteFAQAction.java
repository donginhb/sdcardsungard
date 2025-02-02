/**
 * 
 */
package com.kingstargroup.ecard.portlet.faq.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kingstargroup.ecard.exceptions.PortalException;
import com.kingstargroup.ecard.hibernate.util.InformationUtil;
import com.kingstargroup.ecard.util.EcardConstants;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.Constants;
import com.liferay.util.servlet.SessionErrors;

/**
 * Copyright (C), 2000-2005, Kingstar Co., Ltd.<br>
 * File name: DeleteFAQAction.java<br>
 * Description: <br>
 * Modify History: <br>
 * 操作类型   操作人   操作时间     操作内容<br>
 * ===================================<br>
 *  创建    Xiao Qi  2005-9-22  <br>
 * @author Xiao Qi
 * @version 
 * @since 1.0
 */
public class DeleteFAQAction extends PortletAction {
	/* (non-Javadoc)
	 * @see org.apache.struts.action.Action#execute(org.apache.struts.action.ActionMapping, org.apache.struts.action.ActionForm, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public ActionForward execute(
			ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res)
		throws Exception {
		try {
			String[] ids = req.getParameterValues("ids");
			if (ids == null) {
				SessionErrors.add(req, EcardConstants.CHOOSE_DEL_CONTENT);			
				return mapping.findForward("portlet.ecardfaq.admin");
			}
			InformationUtil.deleteInfos(ids);
			SessionErrors.add(req, EcardConstants.DELETE_INFO_SUCCEED);			
		} catch (PortalException pe) {
			SessionErrors.add(req, EcardConstants.DELETE_INFO_FAILED);			
		}
		return mapping.findForward("portlet.ecardfaq.admin");
	}
}
