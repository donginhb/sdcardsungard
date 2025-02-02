package com.kingstargroup.fdykt.trade;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Arrays;

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
import org.apache.struts.action.ActionMessages;

import com.kingstar.bcc.bccclt;
import com.kingstargroup.fdykt.BccctlInit;
import com.kingstargroup.fdykt.KSConfiguration;
import com.kingstargroup.fdykt.dao.DB2AccountDAO;
import com.kingstargroup.fdykt.dao.DB2CardDAO;
import com.kingstargroup.fdykt.dao.KSDaoSessionFactory;
import com.kingstargroup.fdykt.dto.CardDTO;
import com.kingstargroup.fdykt.util.BccUtil;
import com.kingstargroup.fdykt.util.DateUtil;

public class NetCheckAction extends Action {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(NetCheckAction.class);

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
		try {
			request.setCharacterEncoding("GBK");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		DB2CardDAO carddao = new DB2CardDAO();
		DB2AccountDAO accdao = new DB2AccountDAO();
		HttpSession session = request.getSession();
		String cardId = request.getParameter("cardId");
		String money = request.getParameter("money");
		String card_bala = request.getParameter("cardBala");
		String txCnt = request.getParameter("txCnt");
		String stuempno = request.getParameter("stuempno");
		String stuempname =  request.getParameter("stuempname");

		request.setAttribute("stuempno", stuempno);
		request.setAttribute("cardId", cardId);
		request.setAttribute("txCnt", txCnt);
		request.setAttribute("money", money);
		request.setAttribute("thirdpartname", stuempname);
		session.setAttribute("thirdpartname", stuempname);
		// double cardBala = Double.parseDouble(card_bala);
		// cardBala = cardBala / 100;
		String hexcardno = Integer.toHexString(Integer.parseInt(cardId))
				.toUpperCase();
		for (int i = hexcardno.length(); i < 8; i++) {
			hexcardno = "0" + hexcardno;// pad left
		}

		ActionErrors errors = new ActionErrors();
		CardDTO card = new CardDTO();
		try {
			card = carddao.getCardInfoById(hexcardno);
			if(card==null){
				request.setAttribute("errmsg", "卡信息异常，请检查是否正常卡!");
				return mapping.findForward("failure");
			}
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("卡信息读取失败");
			System.out.println("卡信息读取失败");
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"back.error", "卡信息读取失败"));
			saveErrors(request, errors);
			return mapping.findForward("failure");
		}

		String reqip = request.getRemoteAddr();
		// reqip = "10.49.188.50";
		int deviceid = -2;
		try {
			deviceid = accdao.getdevidFromip(reqip);
			if (deviceid < 0) {
				errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
						"deviceid.notregister"));
				saveErrors(request, errors);
				return mapping.findForward("failure");
			}
		} catch (Exception e1) {
			e1.printStackTrace();
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"deviceid.notregister"));
			saveErrors(request, errors);
			return mapping.findForward("failure");
		}

		long xpackhandle = 0;
		int drtpno = 0;
		int errcode[] = { 1 };
		byte errmsg[] = new byte[300];
		int branchno = 0;// 后台drtp功能号
		int mainfunction = KSConfiguration.getInstance().getPropertyAsInt(
				"mainfunction1", 9000);
		int func = KSConfiguration.getInstance().getPropertyAsInt(
				"logicfunc_nettrans_check", 846330);// 后台业务功能号
		int tries = KSConfiguration.getInstance().getPropertyAsInt("tries", 3);// 默认重试次数
		String lcert_code_p = KSConfiguration.getInstance().getProperty(
				"lcert_code", "11");
		int[] RetCode = new int[1];
		int[] RecordCount = new int[1];
		bccclt bcc = null;
		try {
			bcc = BccctlInit.getBccctlInstance();
			xpackhandle = bcc.NewXpackHandle(KSConfiguration.getInstance()
					.getProperty("cpackfile", "/opt/cpack.dat").getBytes());
			if (0 != xpackhandle) {
				bcc.SetRequestType(xpackhandle, func);
				bcc.SetIntFieldByName(xpackhandle, 0, "lcert_code".getBytes(),
						Integer.parseInt(lcert_code_p));// 收费编号
				bcc.SetStringFieldByName(xpackhandle, 0, "lwithdraw_flag"
						.getBytes(), String.valueOf(deviceid).getBytes());// 终端号
				bcc.SetStringFieldByName(xpackhandle, 0, "scust_auth"
						.getBytes(), DateUtil.getNow().getBytes());// 发送方凭证号
				bcc.SetStringFieldByName(xpackhandle, 0,
						"sstation1".getBytes(), hexcardno.getBytes());// 物理卡号
				bcc.SetIntFieldByName(xpackhandle, 0, "lvol0".getBytes(),
						Integer.parseInt(String.valueOf(card.getCardno())));// 卡号
				bcc.SetIntFieldByName(xpackhandle, 0, "lvol7".getBytes(),
						Integer.parseInt(card_bala));// 卡交易前余额(分)
				bcc.SetIntFieldByName(xpackhandle, 0, "lvol6".getBytes(),
						Integer.parseInt(txCnt));// 交易次数
				bcc.SetIntFieldByName(xpackhandle, 0, "lvol1".getBytes(),
						Integer.parseInt(money) * 100);// 收费金额(分)
				bcc.SetStringFieldByName(xpackhandle, 0,
						"snote".getBytes(), stuempno.getBytes());// 对方学号
				bcc.SetStringFieldByName(xpackhandle, 0,
						"snote2".getBytes(), stuempname.getBytes());// 对方姓名
				boolean bccret = false;
				bccret = bcc.CallRequest(xpackhandle, drtpno, branchno,
							mainfunction, 10000, errcode, errmsg);

				if (bccret) {
					bcc.GetRetCode(xpackhandle, RetCode);
					bcc.GetRecordCount(xpackhandle, RecordCount);
					if (0 == RetCode[0]) {
						if (0 < RecordCount[0]) {
							byte[] inStr = new byte[300];
							int[] intRec = new int[1];

							Arrays.fill(intRec, 0);
							bcc.GetIntFieldByName(xpackhandle, 0, "lserial1"
									.getBytes(), intRec);
							String serial_no = String.valueOf(intRec[0]);//终端流水号

							Arrays.fill(intRec, 0);
							bcc.GetIntFieldByName(xpackhandle, 0, "lvol8"
									.getBytes(), intRec);
							String out_card_amount = String.valueOf(intRec[0]);//出卡值

							Arrays.fill(inStr, (byte) 0);
							bcc.GetStringFieldByName(xpackhandle, 0, "sdate3"
									.getBytes(), inStr, 10);
							String sdate3 = BccUtil.getStringFromByte(inStr);//系统日期

							Arrays.fill(inStr, (byte) 0);
							bcc.GetStringFieldByName(xpackhandle, 0, "sname2"
									.getBytes(), inStr, 21);
							String sname2 = BccUtil.getStringFromByte(inStr);//交易参考号

							request.setAttribute("serialNo", serial_no);
							request.setAttribute("sdate3", sdate3);
							request.setAttribute("outCardAmount",
									out_card_amount);
							request.setAttribute("sname2", sname2);
							
							//写一笔流水？？						
							return mapping.findForward("success");
						} else {
							errors.add(ActionMessages.GLOBAL_MESSAGE,
									new ActionError("back.error", "后台处理失败"));
							saveErrors(request, errors);
							return mapping.findForward("failure");
						}

					} else {
						// 失败
						if (0 < RecordCount[0]) {
							byte[] vsmess = new byte[300];
							bcc.GetStringFieldByName(xpackhandle, 0, "vsmess"
									.getBytes(), vsmess, 300);
							int i;
							for (i = 0; i < vsmess.length; i++) {
								if (vsmess[i] == 0) {
									break;
								}
							}
							String vs_mess = new String(vsmess, 0, i);
							errors.add(ActionMessages.GLOBAL_MESSAGE,
									new ActionError("back.error", vs_mess));
							saveErrors(request, errors);
							return mapping.findForward("failure");
						} else {
							errors.add(ActionMessages.GLOBAL_MESSAGE,
									new ActionError("back.error", "后台处理失败"));
							saveErrors(request, errors);
							return mapping.findForward("failure");
						}

					}

				} else {
					// 请求失败

					int i;
					for (i = 0; i < errmsg.length; i++) {
						if (errmsg[i] == 0) {
							break;
						}
					}
					String s = new String(errmsg, 0, i);
					System.out.println("connect:errcode=" + errcode[0] + "msg="
							+ s);
					errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
							"back.error", "后台通讯暂时不可用，请稍后重试！ " + s));
					saveErrors(request, errors);
					return mapping.findForward("failure");
				}
			}
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"back.error", "系统出现异常，请稍后重试！"));
			saveErrors(request, errors);
			return mapping.findForward("failure");

		} catch (Exception e) {
			// TODO: handle exception
			logger.error(e.getMessage());
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"back.error", "系统出现异常，请稍后重试！"));
			return mapping.findForward("failure");
		} catch (UnsatisfiedLinkError e) {
			logger.error(e.getMessage());
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionError(
					"back.error", "系统出现异常，请稍后重试！"));
			return mapping.findForward("failure");
		} finally {
			if (xpackhandle != 0) {
				bcc.DeleteXpackHandle(xpackhandle);
			}
		}

	}
}
