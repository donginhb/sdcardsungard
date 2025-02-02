/**
 * 
 */
package com.kingstargroup.ecard.portlet.hitinfo.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kingstargroup.ecard.util.PermissionUtil;
import com.liferay.portal.model.Layout;
import com.liferay.portal.struts.PortletAction;
import com.liferay.portal.util.WebKeys;
import com.liferay.util.ParamUtil;

/**
 * Copyright (C), 2000-2005, Kingstar Co., Ltd.<br>
 * File name: ViewAction.java<br>
 * Description: <br>
 * Modify History: <br>
 * 操作类型   操作人   操作时间     操作内容<br>
 * ===================================<br>
 *  创建    Xiao Qi  2005-11-18  <br>
 * @author Xiao Qi
 * @version 
 * @since 1.0
 */
public class ViewAction extends PortletAction {

	/* (non-Javadoc)
	 * @see org.apache.struts.action.Action#execute(org.apache.struts.action.ActionMapping, org.apache.struts.action.ActionForm, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public ActionForward execute(
			ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res)
		throws Exception {
		String layoutId = ((Layout)req.getAttribute(WebKeys.LAYOUT)).getLayoutId();
		if (layoutId.equals("1") || layoutId.equals("1.1")) {
			return mapping.findForward("portlet.ecardhit.view_normal");
		} else {
			if (PermissionUtil.hasHitinfoAdmin(req)) {
				return mapping.findForward("portlet.ecardhit.view_admin");
			} else if (PermissionUtil.hasAdmin(req)){
				return mapping.findForward("portlet.ecardhit.view");
			}
		}
		return null;
	}

}
