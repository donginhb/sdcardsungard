package com.kingstargroup.fdykt.netcomputebind;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class NetComputePutinAction extends Action {
	/**
	 * Logger for this class
	 */

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String cardphyid = request.getParameter("cardphyid");//��������long
		String money = request.getParameter("money");
		String cardBala = request.getParameter("cardBala");
		String txCnt = request.getParameter("txCnt");
		request.setAttribute("cardphyid", cardphyid);
		request.setAttribute("money", money);
		request.setAttribute("cardBala", cardBala);
		request.setAttribute("txCnt", txCnt);
		return mapping.findForward("success");
	}

}
