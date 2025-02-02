package com.kingstargroup.fdykt.trade;

import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kingstargroup.fdykt.dao.*;

import java.sql.SQLException;
import java.util.*;

public class AdminPageAction extends Action {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(AdminPageAction.class);
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		KSDaoSessionFactory.createSession();
		ActionForward forward = doPageAction(mapping, request);
		try {
			KSDaoSessionFactory.commit();
		} catch (SQLException e) {
			logger.error("查询流水失败");
			e.printStackTrace();
		}
		return forward;
	}

	private ActionForward doPageAction(ActionMapping mapping,
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		List list = new ArrayList();
		int page = Integer.parseInt(request.getParameter("page"));
		int  total = Integer.parseInt(request.getParameter("total"));
		DB2DeviceDAO    deviceDao = new DB2DeviceDAO();
		try {
			
			list = deviceDao.DeviceList((page - 1) * 10 + 1);
			request.setAttribute("list", list);
			request.setAttribute("total", new Integer(total));
			request.setAttribute("page", new Integer(page));
			return (mapping.findForward("success"));
		} catch (Exception e) {
			logger.error("分页查询流水失败");
			return (mapping.findForward("failure"));
		}
	}
}
