package com.kingstargroup.fdykt.transfer;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kingstargroup.fdykt.Util;
import com.kingstargroup.fdykt.dao.DB2CardDAO;
import com.kingstargroup.fdykt.dao.DB2CustomerDAO;
import com.kingstargroup.fdykt.dao.KSDaoSessionFactory;
import com.kingstargroup.fdykt.dto.CardDTO;
import com.kingstargroup.fdykt.dto.CustomerDTO;
import com.kingstargroup.fdykt.logon.LogonAction;

public class CheckPasswordAction extends Action {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(LogonAction.class);

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {

		KSDaoSessionFactory.createSession();
		ActionForward forward = doLogin(mapping, request);
		try {
			KSDaoSessionFactory.commit();
		} catch (SQLException e) {
			logger.error("提交事务失败");
			e.printStackTrace();
		}
		return forward;
	}

	private ActionForward doLogin(ActionMapping mapping,
			HttpServletRequest request) {
		String cardno = request.getParameter("cardno");
		String password = request.getParameter("password");
		DB2CustomerDAO customerdao = new DB2CustomerDAO();
		DB2CardDAO carddao = new DB2CardDAO();
		try {
			ActionErrors errors = new ActionErrors();
			
			if (null == password || "".equals(password)) {
				errors.add("login", new ActionError("errors.emptypwd"));
				saveErrors(request, errors);
				return mapping.findForward("failure");
			}
			String hexcardno = Integer.toHexString(Integer.parseInt(cardno))
					.toUpperCase();
			for (int i = hexcardno.length(); i < 8; i++) {
				hexcardno = "0" + hexcardno;// pad left
			}
			String ciphered = Util.DESEnc(password);

			// 查询出唯一的卡
			CardDTO card = carddao.getCardInfoByIdPwd(hexcardno, ciphered);
			
			if (card == null) {
				errors.add("login", new ActionError("errors.password"));
				saveErrors(request, errors);
				return mapping.findForward("failure");
			} else {

				String stateId = card.getCardstatus();
				if ("1".equals(stateId.substring(1, 2))) {
					errors.add("login", new ActionError("errors.cardisloss"));
					saveErrors(request, errors);
					return mapping.findForward("failure");
				} else if ("1".equals(stateId.substring(2, 3))) {
					errors.add("login", new ActionError("errors.cardislock"));
					saveErrors(request, errors);
					return mapping.findForward("failure");
				}

				String sql = "select * from ykt_cur.t_customer cus "
						+ "where cus.custid= " + card.getCustid();
				ArrayList customers = customerdao.RetriveCustomer(sql);
				HttpSession session = request.getSession(true);

				if (customers.size() == 0) {
					
					errors.add("login", new ActionError("errors.nocusterinfo"));
					saveErrors(request, errors);
					return mapping.findForward("failure");
				}else{
					CustomerDTO custDTO = (CustomerDTO) customers.get(0);
//					long custid = custDTO.getCustid();
//					String custname = custDTO.getCustname();
//					String stuempno = custDTO.getStuempno();
//					if(stuempno!=null){
//						stuempno= stuempno.toUpperCase();
//					}
					session.setAttribute("customer", custDTO);
//					session.setAttribute("name", custname);
//					session.setAttribute("cutid", String.valueOf(custid));
//					session.setAttribute("stuempno", stuempno);
				}
//				session.setAttribute("cardid", String.valueOf(card.getCardno()));
//				session.setAttribute("cardPhysicalNo", hexcardno);
				request.setAttribute("cardno", cardno);
				return (mapping.findForward("success"));
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
			return (mapping.findForward("failure"));
		}
	}

}
