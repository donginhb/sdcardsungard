/**
 * 
 */
package com.kingstargroup.conference.action.parameter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kingstargroup.conference.util.ParameterUtil;

/**
 * @author ��Ө
 * 
 */
public class ViewConferenceTypeAction extends Action {

	public ActionForward execute(
			ActionMapping mapping, 
			ActionForm form,
			HttpServletRequest request, 
			HttpServletResponse response)
			throws Exception {
		try {
			request.setAttribute("result", ParameterUtil.getAllConferenceType());
			return mapping.findForward("viewconftype");
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("error");
		}
	}

}
