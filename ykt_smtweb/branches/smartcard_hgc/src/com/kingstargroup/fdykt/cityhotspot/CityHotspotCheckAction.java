package com.kingstargroup.fdykt.cityhotspot;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kingstargroup.fdykt.dao.KSDaoSessionFactory;

public class CityHotspotCheckAction extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		KSDaoSessionFactory.createSession();
		ActionForward forward = docheck(mapping, form, request, response);
		try {
			KSDaoSessionFactory.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return forward;
	}

	private ActionForward docheck(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String cardId = request.getParameter("cardId");
		String money = request.getParameter("money");
		String serialNo = request.getParameter("serialNo");
		String outCardAmount = request.getParameter("outCardAmount");
		String pwd = request.getParameter("pwd");
		String txCnt = request.getParameter("txCnt");
		
		
		request.setAttribute("txCnt",txCnt); 
		request.setAttribute("pwd",pwd);
		request.setAttribute("cardId", cardId);
		request.setAttribute("money", money);
		request.setAttribute("serialNo", serialNo);
		request.setAttribute("outCardAmount", outCardAmount);	
		return mapping.findForward("success");
						
	}
}
